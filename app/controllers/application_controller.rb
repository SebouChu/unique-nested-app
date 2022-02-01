class ApplicationController < ActionController::Base
  def breadcrumb
    add_breadcrumb t('home'), root_path
  end

  def breadcrumb_for(record, record_path: :polymorphic_path, record_path_params: [record])
    return unless record.present?
    record.new_record?  ? add_breadcrumb(t('create'))
                        : add_breadcrumb(record, public_send(record_path, *record_path_params))
  end
end
