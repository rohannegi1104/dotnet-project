using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// Configure services (if needed)
builder.Services.AddRazorPages();  // Example service

var app = builder.Build();

// Configure the HTTP request pipeline
app.MapGet("/", () => "Hello, World!");  // Simplified request handling

app.Run();
