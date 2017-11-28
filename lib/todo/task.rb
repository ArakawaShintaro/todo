require 'active_record'

module Todo
  #tasksテーブルのモデル
  class Task < ActiveRecord::Base
    scope :status_with, ->(status) { where(status: status) }

    NOT_YET = 0
    DONE = 1
    PENDING = 2

    STATUS = {
      NOT_YET: NOT_YET,
      DONE: DONE,
      PENDING: PENDING
    }.freeze

    validates :name, presence: true, length: { maximum: 140 }
    validates :content, presence: true
    validates :status, numericality: true, inclusion: { in: STATUS.values }
  end
end


