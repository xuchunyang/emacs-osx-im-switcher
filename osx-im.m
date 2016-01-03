/* osx-im

Copyright 2016 Chunayng Xu

GNU Emacs is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

GNU Emacs is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.  */


#include <emacs-module.h>
#include <string.h>

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

int plugin_is_GPL_compatible;

static emacs_value
Fosx_im_current_im (emacs_env *env, int nargs, emacs_value args[], void *data)
{
  TISInputSourceRef cur_im = TISCopyCurrentKeyboardInputSource ();
  const char *cur_im_rdns_name = [TISGetInputSourceProperty (cur_im, kTISPropertyInputSourceID) UTF8String];
  return env->make_string (env, cur_im_rdns_name, strlen(cur_im_rdns_name));
}

/* Bind NAME to FUN.  */
static void
bind_function (emacs_env *env, const char *name, emacs_value Sfun)
{
  emacs_value Qfset = env->intern (env, "fset");
  emacs_value Qsym = env->intern (env, name);
  emacs_value args[] = { Qsym, Sfun };

  env->funcall (env, Qfset, 2, args);
}

/* Provide FEATURE to Emacs.  */
static void
provide (emacs_env *env, const char *feature)
{
  emacs_value Qfeat = env->intern (env, feature);
  emacs_value Qprovide = env->intern (env, "provide");
  emacs_value args[] = { Qfeat };

  env->funcall (env, Qprovide, 1, args);
}

int
emacs_module_init (struct emacs_runtime *ert)
{
  emacs_env *env = ert->get_environment (ert);
  bind_function (env, "osx-im-current-im",
                 env->make_function (env, 0, 0, Fosx_im_current_im, "Current the current Input method", NULL));

  provide (env, "osx-im");
  return 0;
}
