// Vanilla JavaScript for Food Store App
// No framework dependencies - pure JavaScript only

document.addEventListener('DOMContentLoaded', function() {
  console.log('Food Store App initialized with vanilla JavaScript');

  // Initialize all features
  initializeFilterForm();
  initializeStatusButtons();
});

/**
 * Filter Form - Handle filter changes and search with debouncing
 */
function initializeFilterForm() {
  const filterForm = document.getElementById('filter-form');
  if (!filterForm) return;

  const selects = filterForm.querySelectorAll('select');
  const searchInput = document.getElementById('search-input');
  let searchTimeout;

  // Handle select changes (immediate)
  selects.forEach(select => {
    select.addEventListener('change', function() {
      applyFilters();
    });
  });

  // Handle search input with debouncing (wait 500ms after user stops typing)
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      clearTimeout(searchTimeout);
      searchTimeout = setTimeout(() => {
        applyFilters();
      }, 500);
    });

    // Also handle Enter key for immediate search
    searchInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        clearTimeout(searchTimeout);
        applyFilters();
      }
    });
  }

  /**
   * Apply current filters and navigate to filtered URL
   */
  function applyFilters() {
    const formData = new FormData(filterForm);
    const params = new URLSearchParams();

    // Only add non-empty values
    for (const [key, value] of formData.entries()) {
      if (value && value.trim()) {
        params.append(key, value);
      }
    }

    // Navigate to the filtered URL
    const url = params.toString() ? `/food_items?${params.toString()}` : '/food_items';
    window.location.href = url;
  }
}

/**
 * Status Update Buttons - Handle status updates with AJAX
 */
function initializeStatusButtons() {
  const statusButtons = document.querySelectorAll('[data-action="update-status"]');

  statusButtons.forEach(button => {
    button.addEventListener('click', function(event) {
      event.preventDefault();
      event.stopPropagation();

      const itemId = this.dataset.id;
      const newStatus = this.dataset.status;

      // Show loading state
      const originalText = this.textContent;
      this.textContent = '...';
      this.disabled = true;

      // Make AJAX request to update status
      updateItemStatus(itemId, newStatus)
        .then(response => {
          if (response.ok) {
            // Reload the page to show updated status
            window.location.reload();
          } else {
            throw new Error('Failed to update status');
          }
        })
        .catch(error => {
          console.error('Error updating status:', error);
          alert('Failed to update status. Please try again.');

          // Restore button state
          this.textContent = originalText;
          this.disabled = false;
        });
    });
  });
}

/**
 * Update item status via AJAX
 * @param {number} itemId - The food item ID
 * @param {string} status - The new status
 * @returns {Promise} Fetch promise
 */
function updateItemStatus(itemId, status) {
  // Get CSRF token from meta tag
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  return fetch(`/food_items/${itemId}/update_status?status=${status}`, {
    method: 'PATCH',
    headers: {
      'X-CSRF-Token': csrfToken,
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    credentials: 'same-origin'
  });
}

/**
 * Helper function to show notifications
 * @param {string} message - The notification message
 * @param {string} type - 'success' or 'error'
 */
function showNotification(message, type = 'success') {
  const notification = document.createElement('div');
  notification.className = type === 'success' ? 'notice' : 'alert';
  notification.textContent = message;

  // Insert after navbar
  const navbar = document.querySelector('.navbar');
  if (navbar) {
    navbar.after(notification);
  } else {
    document.body.prepend(notification);
  }

  // Auto-remove after 3 seconds
  setTimeout(() => {
    notification.remove();
  }, 3000);
}
