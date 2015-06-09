using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Octokit;

namespace code_me.Controllers
{
    public class ProfileController : Controller
    {
        // GET: Profile
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult UserDetails()
        {
            Activity[] user_activityfeed = new Activity[20];
            List<string> user_orgs = new List<string>();
            
            ViewData.Add("user_name", "user_name");
            ViewData.Add("user_image", "https://avatars3.githubusercontent.com/u/4678601?v=3&s=460");
            ViewData.Add("user_joindate", DateTime.Now.ToString());
            ViewData.Add("user_feeditems", user_activityfeed);
            ViewData.Add("user_organizations", user_orgs);
            ViewData.Add("user_contact_email", "user_contact_email");
            ViewData.Add("user_contact_website", "user_contact_website");
            ViewData.Add("user_location", "user_location");
            return View();
        }
    }
}