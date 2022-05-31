class ApplicationController < ActionController::API
  include JsonapiErrorsHandler

  ErrorMapper.map_errors!({
                            'ActiveRecord::RecordNotFound' => 'JsonApiErrorsHandler::Errors::NotFound'
                          })
  rescue_from ::StandardError, with: lambda {|e| handle_error(e)}
end
