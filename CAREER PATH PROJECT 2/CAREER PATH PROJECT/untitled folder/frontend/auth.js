// Register a new user
function register(email, password) {
  const user = { email, password };
  localStorage.setItem("user", JSON.stringify(user));
}

// Log in user
function login(email, password) {
  const user = JSON.parse(localStorage.getItem("user"));
  if (!user) return false;

  if (user.email === email && user.password === password) {
    localStorage.setItem("loggedIn", "true");
    return true;
  }
  return false;
}

// Protect pages that require authentication
function requireAuth() {
  const loggedIn = localStorage.getItem("loggedIn");
  if (loggedIn !== "true") {
    window.location.href = "login.html";
  }
}

// Log out user
function logout() {
  localStorage.removeItem("loggedIn");
  window.location.href = "login.html";
}
