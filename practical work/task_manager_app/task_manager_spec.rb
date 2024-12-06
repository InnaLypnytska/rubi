require_relative '../task_manager'

RSpec.describe TaskManager do
  let(:file_path) { 'test_tasks.json' }
  let(:manager) { TaskManager.new(file_path) }

  before do
    File.delete(file_path) if File.exist?(file_path)
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#add_task' do
    it 'додає нову задачу' do
      manager.add_task('Test Task', '2024-12-31')
      expect(manager.tasks.size).to eq(1)
      expect(manager.tasks.first[:title]).to eq('Test Task')
    end
  end

  describe '#edit_task' do
    it 'редагує існуючу задачу' do
      manager.add_task('Test Task', '2024-12-31')
      manager.edit_task(1, title: 'Updated Task')
      expect(manager.tasks.first[:title]).to eq('Updated Task')
    end
  end

  describe '#delete_task' do
    it 'видаляє задачу' do
      manager.add_task('Test Task', '2024-12-31')
      manager.delete_task(1)
      expect(manager.tasks).to be_empty
    end
  end

  describe '#filter_tasks' do
    it 'фільтрує задачі за статусом та термінами' do
      manager.add_task('Task 1', '2024-12-01')
      manager.add_task('Task 2', '2024-12-31')
      manager.edit_task(1, completed: true)
      filtered = manager.filter_tasks(status: true, deadline_before: '2024-12-15')
      expect(filtered.size).to eq(1)
      expect(filtered.first[:title]).to eq('Task 1')
    end
  end
end
