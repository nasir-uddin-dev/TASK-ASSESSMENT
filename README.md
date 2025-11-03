

https://github.com/user-attachments/assets/54240d04-3fd3-473c-a96b-53adccfd3350

#  OnBoarding Screen

<img width="300" height="800" alt="Screenshot_1762149969" src="https://github.com/user-attachments/assets/e520b7ae-307e-4ccc-860a-e71eeaa7d81f" />
<img width="300" height="800" alt="Screenshot_1762149973" src="https://github.com/user-attachments/assets/f07d4be5-65f5-45e8-a949-55f14eaca3c0" />
<img width="300" height="800" alt="Screenshot_1762149976" src="https://github.com/user-attachments/assets/10b1905e-25e8-4d94-b470-1aefe3a0e027" />

#  Home Screen

<img width="300" height="800" alt="Screenshot_1762149984" src="https://github.com/user-attachments/assets/afce3a4c-2e08-4753-a3e7-8b291fb7d738" />

#  Alarm Screen

<img width="300" height="800" alt="Screenshot_1762150000" src="https://github.com/user-attachments/assets/21688e4e-e488-4c14-a0b8-00bfd86a52fd" />
<img width="300" height="800" alt="Screenshot_1762150008" src="https://github.com/user-attachments/assets/f06ca7ed-6ab8-424e-8c19-4edc8a0c1db6" />
<img width="300" height="800" alt="Screenshot_1762150017" src="https://github.com/user-attachments/assets/9b8687c4-abbf-4e73-8473-dc17d29425e0" />

# Project Overview: Nature Sync Alarm App 
## This task involves building a small Flutter app that helps users “sync with nature’s rhythm” through a smooth onboarding flow, location access, and alarm notifications.

# State Management (GetX)
## best practices for state management and clean architecture.

# Task Breakdown & Flow
## Onboarding Screens
### Goal: Introduce the app and its purpose to the user.
* Number of Screens: 3
* Content:
  * Screen 1: “Sync with nature’s rhythm” — visually appealing intro.
  * Screen 2: “Effortless and automatic syncing” — explain automation benefits.
  * Screen 3: “Relax and unwind” — show lifestyle benefits.

* Functionality:
    * Use PageView or a package like introduction_screen.
    * On last page → “Next” button to proceed.

# Location Access
## Goal: Get user’s location for personalized experience.
  * After onboarding, request location permission.
  * Use geolocator or flutter_maps_google package.
  * Fetch the current location and display something like:

# Set Alarm
  * Use showTimePicker() and showDatePicker() or a combined date-time picker package.
  * Display in a list: time, date and button
# Notifications
  * Use Awesome_local_notifications (recommended).
  * Notification title: “Time ”
  * Body: “Date”

# Flutter Package 
  * get
  *  google_maps_flutter
  *   geolocator
  *   geocoding
  *   awesome_notifications
  *    toggle_switch

