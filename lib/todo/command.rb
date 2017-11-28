module Todo
  # コマンドラインベースの処理を行うクラス
  class Command
    def execute
      DB.prepare
    end

    def Tp(name, content)
      Task.create!(name: name, content: content).reload
    end

    def delete_task(id)
      task = Task.find(id)
      task.destory
    end

    def update_task(id, attributes)
      binding.pry
      if status_name = attributes[:status]
        attributes[:status] = Task::STATUS.fetch(status_name.upcase.to_sym)
      end

      task = Task.find(id)
      task.update_attributes!(attributes)

      task.reload
    end

    def find_tasks(status_name)
      all_tasks = Task.order('created_at DESC')

      if status_name
        status = Task::STATUS.fetch(status_name.upcase)
        all_tasks.status_with(status)
      else
        all_tasks
      end
    end
  end
end
