# GHOSTnet FTN

### Instructions for Updating the GhostNet FTN Nodelist Repository

Authorized GitHub users (Designated Network Admins) must use the **fork and pull request** process to update and compile the GhostNet nodelist or infopack. The `compile_nodelist.sh` script is located in the `ftn/nodelist` directory and handles compiling the nodelist and creating the infopack ZIP file and sending back to Github.

---

### **1. Pre-requisites**
Before starting, ensure you have the following:
- Git installed on your system.
- A working SSH key added to your GitHub account for repository access. Refer to [GitHub's documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) to set up your SSH key.
- Required tools installed:
  - `makenl`: Used for compiling the nodelist.
  - Bash shell to run the `compile_nodelist.sh` script.

---

### **2. Step-by-Step Guide**

#### **1. Fork the Repository**
1. Go to the [GhostNet repository](https://github.com/robbiew/ghostnet) on GitHub.
2. Click the **Fork** button in the top-right corner to create your own copy of the repository.

#### **2. Clone Your Fork**
1. Clone your forked repository using SSH:
   ```bash
   git clone git@github.com:<your-username>/ghostnet.git
   ```
   Replace `<your-username>` with your GitHub username.
2. Navigate to the repository directory:
   ```bash
   cd ghostnet
   ```

#### **3. Set the Original Repository as a Remote**
To ensure you can fetch updates from the original repository:
1. Add the original GhostNet repository as an upstream remote:
   ```bash
   git remote add upstream git@github.com:robbiew/ghostnet.git
   ```
2. Verify the remote setup:
   ```bash
   git remote -v
   ```
   You should see `origin` pointing to your fork and `upstream` pointing to the original repository.

#### **4. Synchronize Your Fork**
Before making changes, ensure your fork is up-to-date with the original repository:
1. Fetch the latest changes from the upstream repository:
   ```bash
   git fetch upstream
   ```
2. Merge the changes into your local `main` branch:
   ```bash
   git checkout main
   git merge upstream/main
   ```

#### **5. Make Changes to the Nodelist or Infopack**
1. Navigate to the appropriate directory:
   - To update the nodelist: `cd ftn/nodelist`
   - To update the infopack: `cd ftn/infopack`

2. Edit the necessary files:
   - For the nodelist, make changes to the nodelist text files.
   - For the infopack, update any of the included files, such as instructions, system lists, or echo area information.
3. Save the changes.

#### **6. Compile the Nodelist and Infopack**
1. If you made changes to the nodelist, navigate to the `ftn/nodelist` directory:
   ```bash
   cd ftn/nodelist
   ```
2. Run the `compile_nodelist.sh` script:
   ```bash
   ./compile_nodelist.sh
   ```
   This script will:
   - Compile the nodelist using `makenl`.
   - Create the updated infopack ZIP file.

3. Verify that the script completes successfully. The output files will be generated in the appropriate directories.

#### **7. Commit and Push Changes to Your Fork**
1. Add the changes to Git:
   ```bash
   git add .
   ```
2. Commit your changes with a clear message:
   ```bash
   git commit -m "Update nodelist and/or infopack with latest changes"
   ```
3. Push the changes to your fork:
   ```bash
   git push
   ```

#### **8. Create a Pull Request**
1. Go to your forked repository on GitHub.
2. Click the **Pull Request** button.
3. Compare your branch with the original `main` branch of the [GhostNet repository](https://github.com/robbiew/ghostnet).
4. Add a clear title and description of your changes (e.g., "Updated nodelist and system lists").
5. Submit the pull request.

#### **9. Wait for Review**
The repository maintainers will review your pull request. Once approved, your changes will be merged into the main repository.

---

### **3. Notes**
- **Changes to the Infopack**: The infopack includes files that end users rely on for instructions, system lists, and echo areas. Ensure these are clearly written and accurate to maintain usability.
- **SSH Key Setup**: Ensure your SSH key is correctly configured to avoid authentication errors. Test your SSH connection with:
   ```bash
   ssh -T git@github.com
   ```
- **Always Pull Updates**: Synchronize your fork with the upstream repository to avoid conflicts before starting any work.

By following this workflow, you can confidently update both the nodelist and the infopack while ensuring your changes are reviewed and approved before being merged into the main repository.
