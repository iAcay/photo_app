class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    @customer = Stripe::Customer.create(email: params[:user][:email])
    resource.class.transaction do 
      begin
        @session = Stripe::Checkout::Session.create({ 
          customer: @customer.id,
          payment_method_types: ['card'],
          line_items: [{ price: 'price_1LLAqALkLgFuVfHBhi0kie6x', quantity: 1 }],
          allow_promotion_codes: true,
          mode: 'payment',
          success_url: root_url + "?session)id={CHECKOUT_SESSION_ID}",
          cancel_url: root_url,
          })
        redirect_to @session.url
      rescue Exception => e
        flash[:error] = e.message

        resource.destroy
        puts "Payment failed."
        render :new and return
      end

      # if @session.status == 'open'
      #   resource.save
      #   yield resource if block_given?
      #   if resource.persisted?
        
      #     if resource.active_for_authentication?
      #       set_flash_message! :notice, :signed_up
      #       sign_up(resource_name, resource)
      #       respond_with resource, location: after_sign_up_path_for(resource)
      #     else
      #       set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      #       expire_data_after_sign_in!
      #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
      #     end
      #   else
      #     clean_up_passwords resource
      #     set_minimum_password_length
      #     respond_with resource
      #   end
      # end
    end
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:payment)
  end
end
