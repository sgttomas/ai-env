export function greet(name = "world") {
  return `Hello, ${name}!`;
}

export function add(a, b) {
  return a + b;
}

// If executed directly: print a greeting
if (import.meta.url === `file://${process.argv[1]}`) {
  const name = process.argv[2] || "world";
  console.log(greet(name));
}
