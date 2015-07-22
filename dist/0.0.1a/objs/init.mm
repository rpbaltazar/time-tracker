#import <Foundation/Foundation.h>

extern "C" {
    void ruby_sysinit(int *, char ***);
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void ruby_set_argv(int, char **);
    void rb_vm_init_compiler(void);
    void rb_vm_init_jit(void);
    void rb_vm_aot_feature_provide(const char *, void *);
    void *rb_vm_top_self(void);
    void rb_define_global_const(const char *, void *);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_A98E4F66DF944CF5904A25711232AC80(void *, void *);
void MREP_556B5A9613404FD9A7EE540CE8635CD7(void *, void *);
void MREP_729D047A1DD84F57A75048C000EB24E8(void *, void *);
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
#if !__LP64__
	try {
#endif
	    void *self = rb_vm_top_self();
rb_define_global_const("RUBYMOTION_ENV", @"release");
rb_define_global_const("RUBYMOTION_VERSION", @"3.13");
MREP_A98E4F66DF944CF5904A25711232AC80(self, 0);
MREP_556B5A9613404FD9A7EE540CE8635CD7(self, 0);
MREP_729D047A1DD84F57A75048C000EB24E8(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
