using System;
using System.ComponentModel.DataAnnotations;

namespace WebApp.Models
{
    public class User
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [StringLength(100, ErrorMessage = "Max length is 100 characters.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid email.")]
        public string Email { get; set; }
    }
}
