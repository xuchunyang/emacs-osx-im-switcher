#include <emacs-module.h>
#include <string.h>

int plugin_is_GPL_compatible;

static emacs_value
Fosx_im_current_im (emacs_env *env, int nargs, emacs_value args[], void *data)
{
  char *str = "English U.S.";
  return env->make_string (env, str, strlen(str));
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
