require 'json'
require 'date'

class TaskManager
  attr_accessor :tasks

  def initialize(file_path = 'tasks.json')
    @file_path = file_path
    @tasks = load_tasks
  end

  def add_task(title, deadline)
    tasks << { id: next_id, title: title, deadline: deadline, completed: false }
    save_tasks
    puts "Задачу додано!"
  end

  def edit_task(id, title: nil, deadline: nil, completed: nil)
    task = find_task(id)
    return unless task

    task[:title] = title if title
    task[:deadline] = deadline if deadline
    task[:completed] = completed unless completed.nil?
    save_tasks
    puts "Задачу відредаговано!"
  end

  def delete_task(id)
    task = find_task(id)
    return unless task

    tasks.delete(task)
    save_tasks
    puts "Задачу видалено!"
  end

  def filter_tasks(status: nil, deadline_before: nil)
    filtered = tasks
    filtered = filtered.select { |task| task[:completed] == status } unless status.nil?
    filtered = filtered.select { |task| Date.parse(task[:deadline]) < Date.parse(deadline_before) } if deadline_before
    filtered
  end

  def list_tasks
    tasks.each do |task|
      puts format_task(task)
    end
  end

  private

  def load_tasks
    File.exist?(@file_path) ? JSON.parse(File.read(@file_path), symbolize_names: true) : []
  end

  def save_tasks
    File.write(@file_path, JSON.pretty_generate(tasks))
  end

  def next_id
    tasks.empty? ? 1 : tasks.map { |task| task[:id] }.max + 1
  end

  def find_task(id)
    task = tasks.find { |t| t[:id] == id }
    puts "Задачу не знайдено!" unless task
    task
  end

  def format_task(task)
    "[#{task[:id]}] #{task[:title]} - До: #{task[:deadline]} - Статус: #{task[:completed] ? 'Виконано' : 'Не виконано'}"
  end
end

# Консольний інтерфейс
manager = TaskManager.new

loop do
  puts "\n1. Додати задачу"
  puts "2. Редагувати задачу"
  puts "3. Видалити задачу"
  puts "4. Показати всі задачі"
  puts "5. Фільтрувати задачі"
  puts "6. Вихід"
  print "Оберіть опцію: "

  choice = gets.chomp.to_i
  case choice
  when 1
    print "Назва задачі: "
    title = gets.chomp
    print "Дедлайн (YYYY-MM-DD): "
    deadline = gets.chomp
    manager.add_task(title, deadline)
  when 2
    print "ID задачі: "
    id = gets.chomp.to_i
    print "Нова назва (залиште порожнім, якщо не змінюється): "
    title = gets.chomp
    print "Новий дедлайн (залиште порожнім, якщо не змінюється): "
    deadline = gets.chomp
    print "Статус (true/false, залиште порожнім, якщо не змінюється): "
    status = gets.chomp
    manager.edit_task(id, title: title.empty? ? nil : title, deadline: deadline.empty? ? nil : deadline, completed: status.empty? ? nil : status == 'true')
  when 3
    print "ID задачі: "
    id = gets.chomp.to_i
    manager.delete_task(id)
  when 4
    manager.list_tasks
  when 5
    print "Статус (true/false, залиште порожнім): "
    status = gets.chomp
    print "Дедлайн до (YYYY-MM-DD, залиште порожнім): "
    deadline = gets.chomp
    filtered_tasks = manager.filter_tasks(status: status.empty? ? nil : status == 'true', deadline_before: deadline.empty? ? nil : deadline)
    filtered_tasks.each { |task| puts manager.send(:format_task, task) }
  when 6
    puts "До побачення!"
    break
  else
    puts "Невірний вибір, спробуйте ще раз!"
  end
end
