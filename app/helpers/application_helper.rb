module ApplicationHelper
  def expiration_class(expiration_date)
    days_until = (expiration_date - Date.today).to_i
    if days_until < 0
      'expired'
    elsif days_until <= 3
      'expiring-soon'
    elsif days_until <= 7
      'expiring-this-week'
    else
      'fresh'
    end
  end

  def days_until_expiration(expiration_date)
    days_until = (expiration_date - Date.today).to_i
    if days_until < 0
      "Expired #{days_until.abs} days ago"
    elsif days_until == 0
      "Expires today"
    elsif days_until == 1
      "Expires tomorrow"
    else
      "#{days_until} days left"
    end
  end

  def status_class(food_item)
    return '' unless food_item.available?
    expiration_class(food_item.expiration_date)
  end
end
