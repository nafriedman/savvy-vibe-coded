# Food/Meal Helper MVP - Savvy Vibe Code

A Ruby on Rails application for managing your food inventory and tracking expiration dates.

## Getting Started

The application is already set up and running! You can access it at:
**http://localhost:3000**

## Features Implemented

### Models
- **Food**: Represents food types (e.g., Salmon, Chicken) with categories (fresh, prepared, pantry)
- **FoodItem**: Individual food items in your inventory with expiration dates, quantities, and status
- **Meal**: Planned or completed meals
- **MealIngredient**: Links meals with their required ingredients

### Food Items Management
- **Index Page** (`/food_items`): View all your food items in a card-based grid layout
- **Sort**: Sort by expiration date, name, or purchase date
- **Filter**: Filter by status (available, consumed, thrown_out, given_away) or category (fresh, prepared, pantry)
- **Status Updates**: Quickly mark items as consumed, thrown out, or given away
- **Visual Indicators**: Color-coded cards based on expiration status:
  - Red: Expired
  - Orange: Expiring soon (≤3 days)
  - Yellow: Expiring this week (≤7 days)
  - Green: Fresh (>7 days)
- **CRUD Operations**: Create, read, update, and delete food items

## Sample Data

The database has been seeded with sample food items including:
- Fresh Atlantic Salmon (expiring soon)
- Organic Chicken Breast (in freezer)
- Whole Milk
- Penne Pasta (pantry item)
- Fresh Broccoli
- Leftover Pizza
- An expired milk item (to test expired status)

## Usage

### Viewing Food Items
1. Navigate to http://localhost:3000 (automatically shows food items index)
2. Use the filter dropdowns to sort and filter items
3. Click on any card to view detailed information

### Adding a Food Item
1. Click "Add Food Item" button
2. Fill in the form with:
   - Food Type (select from existing food types)
   - Name
   - Quantity and Unit
   - Storage Location
   - Status
   - Expiration Date (required)
   - Purchase Date (optional)
   - Cost (optional)
   - Notes (optional)
3. Click "Create Food item"

### Updating Status
- From the index page: Click one of the status buttons at the bottom of each available item's card
- From the detail page: Use the "Update Status" section

### Editing or Deleting
- Click "Edit" to modify an item's details
- Click "Delete" to permanently remove an item (confirmation required)

## Tech Stack

- **Ruby on Rails 8.0.3**
- **SQLite3** (database)
- **Sass** (for styling)
- **Puma** (web server)

## Styling

The app features a clean, modern design with:
- Responsive grid layout
- Smooth hover effects and transitions
- Color-coded status badges
- Visual expiration indicators
- Mobile-friendly interface

## Next Steps (Not Yet Implemented)

- Meal planning functionality
- Calendar view for meals
- Automatic expiration notifications
- Search functionality
- More advanced filtering
- Dashboard/home page with stats

## Development

To stop the server:
```bash
# In the terminal where the server is running
Ctrl+C
```

To restart the server:
```bash
rails server
```

To reset the database:
```bash
rails db:reset db:seed
```
