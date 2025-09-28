# tafeel_task

A Flutter app built with  **modular architecture**.  
The app connects to a mock API and displays a list of users with pagination, search, and user details.  

## 📂 Structure
- **core/** → shared resources (assets, theme, routing, constants, localization)  
- **modules/users/** → feature module with logic (Cubit), models, and UI (screens, widgets)  

## ⚙️ CI/CD
GitHub Actions workflow is included in `.github/workflows/main.yml` for automated build and upload.  