Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B83CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 21:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL70G-0005Pv-Lk; Mon, 17 Nov 2025 16:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vL70E-0005PR-Hb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:43:14 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vL70C-0002IL-4R
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:43:14 -0500
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-477770019e4so52550775e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 13:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763415790; x=1764020590;
 h=subject:date:cc:from:message-id:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yGqr0XbQ1boYsSl9Us6kx4bjxE+gXs+dhahgOBj9BF8=;
 b=ODj1bNbWd4JiF3Lp7d72vCT5uKNealy2dgnH1gojH075lSONo2XUeKO81mDCnRnFv0
 GG6neBk6PUUMzCwFXAzlgPo7iqoCorc8uKZNdWUptQOyafLazJoQ1tAvCoJf5ziWseeO
 TZrsBCmU/+B2vzegTXROvjEigB/qkquXz1ToKU2J3Hvjl+TBAfYdqSBOAwooc9+L3HNE
 J14lD74dPW1D9j+xtRD9g2JeqOKew49mPTYN+4+K4/m22cV2oioJZPJ1AhIDPG9a2KCt
 +IVICJ7ilt9CUAMt+o/5F0c5bO748ccuOCYrR6A/dg26m535zLbH/AUKbCw4HkqRRtFF
 g1OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn1jJ1oTyFb40R7ld0Wg1gzfrTloUer3n4D5JHmJLLPLQUx5dQubGZ1TT1zkcVP3o35dvwbvJYxANx@nongnu.org
X-Gm-Message-State: AOJu0YwnxPMRUOrR9bAjfH/ePcQo9r0SVXJKEx2qKstZ5OIek19t1VtL
 R/wMBYe+mw6EOVhXrZlc9yaVc6a0Fp0kAlMnWqtEIZRqKijN8ub2v0q3+9VYDwkr
X-Gm-Gg: ASbGnctzhw581cGHJopW9l+OpqdKVWjoXDxsNbRJdd/y3fEApiMLFu/2f8MBnrhyn6G
 1AQem5CiQj1oPZC7AyAam5h7FOZ04ssIDFimHION0EEhZjN7Gaa6lE2shYZsRTHudPAVVjdK13i
 NA5DHABocjIJ3JAJ3fvQfYlbsPJlJqMYJ81CFhv3PRw6qg8/Lc6I+3meKZDCI/In3wk1kkXJBZu
 1pj+nffZy5znzMXtjq9l/bYlZfMJMi7DZTYhSR9qdbNBgW0QsYZQ9Dznf1x1hYqSzvkMf5HTp8W
 hO6gshPhl9fTXnARj5If9RiVGfT1qzCaGE9uNZ7CLez6NkfFLrg8UwhVVBtPaUK5vcxGK1ktzBq
 3UJg/aikX7r7JVqujZ2jcu3Tq/aI3rVXfaCNQzUBoTmq6jcva826TFzARPNvIq+Edk9TwE/V4ZY
 p6NczeeJDN0sSewo5YcgspC6vyddrf/8UAP2uMhNvrW3/XgyrnKivw2sg=
X-Google-Smtp-Source: AGHT+IHYNBDGhoC4oVsqAyfmH57uZYJi4T6D81ZiCrh4wmzub4wLSzJCvaePxDhK+kude6iHynID6w==
X-Received: by 2002:a05:600c:1f10:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-4778fe4a046mr123821545e9.15.1763415789987; 
 Mon, 17 Nov 2025 13:43:09 -0800 (PST)
Received: from localhost (95C85BDA.dsl.pool.telekom.hu. [149.200.91.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b074sm27403474f8f.7.2025.11.17.13.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 13:43:09 -0800 (PST)
Message-ID: <b1a93d6bbac236f43803b5f0f0a220f6.rbalint@gmail.com>
CC: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Marc-André Lureau" <marcandre.lureau@redhat.com>, "Daniel P. Berrangé" <berrange@redhat.com>, "Philippe Mathieu-Daudé" <philmd@linaro.org>, "Alex Bennée" <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Date: Sun, 2 Nov 2025 14:26:45 +0100
Subject: [PATCH v2 1/1] user: add runtime switch to call safe_syscall via libc
Received-SPF: pass client-ip=209.85.128.48; envelope-from=rbalint@gmail.com;
 helo=mail-wm1-f48.google.com
X-Spam_score_int: 25
X-Spam_score: 2.5
X-Spam_bar: ++
X-Spam_report: (2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Balint Reczey <balint@balintreczey.hu>
From:  Balint Reczey via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a libc-backed path for safe_syscall() that make syscalls via
libc's syscall(). This enables interposing syscalls via LD_PRELOAD when
running static guest binaries under a dynamically linked qemu-user.

The assembly implementation (safe_syscall_base()) remains the default.
A runtime switch controls the behavior, which can be enabled in
./configure.

Configure option: --enable-libc-syscalls
Command line: -libc-syscalls
Environment: QEMU_LIBC_SYSCALLS
This preserves the existing signal-rewind semantics via the assembly
path by default, while enabling optional libc-based integration when
requested.

Signed-off-by: Balint Reczey <balint@balintreczey.hu>
---
 bsd-user/main.c               | 20 +++++++++++
 common-user/meson.build       |  4 +++
 common-user/safe-syscall.c    | 66 +++++++++++++++++++++++++++++++++++
 docs/user/main.rst            | 30 ++++++++++++++--
 include/user/safe-syscall.h   | 19 +++++++++-
 linux-user/main.c             | 15 ++++++++
 meson.build                   |  1 +
 meson_options.txt             |  4 +++
 scripts/meson-buildoptions.sh |  4 +++
 9 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 common-user/safe-syscall.c

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c327..692468453e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -38,6 +38,9 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
+#ifdef CONFIG_LIBC_SYSCALLS
+#include "user/safe-syscall.h"
+#endif
 #include "accel/accel-ops.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
@@ -166,6 +169,9 @@ static void usage(void)
            "-E var=value      sets/modifies targets environment variable(s)\n"
            "-U var            unsets targets environment variable(s)\n"
            "-B address        set guest_base address to address\n"
+#ifdef CONFIG_LIBC_SYSCALLS
+           "-libc-syscalls     use libc syscall() instead of assembly safe-syscall\n"
+#endif
            "\n"
            "Debug options:\n"
            "-d item1[,...]    enable logging of specified items\n"
@@ -183,6 +189,10 @@ static void usage(void)
            "Environment variables:\n"
            "QEMU_STRACE       Print system calls and arguments similar to the\n"
            "                  'strace' program.  Enable by setting to any value.\n"
+#ifdef CONFIG_LIBC_SYSCALLS
+           "QEMU_LIBC_SYSCALLS Use libc syscall() instead of assembly safe-syscall.\n"
+           "                  Enable by setting to any value.\n"
+#endif
            "You can use -E and -U options to set/unset environment variables\n"
            "for target process.  It is possible to provide several variables\n"
            "by repeating the option.  For example:\n"
@@ -310,6 +320,12 @@ int main(int argc, char **argv)
     qemu_add_opts(&qemu_trace_opts);
     qemu_plugin_add_opts();
 
+#ifdef CONFIG_LIBC_SYSCALLS
+    if (getenv("QEMU_LIBC_SYSCALLS")) {
+        qemu_use_libc_syscalls = true;
+    }
+#endif
+
     optind = 1;
     for (;;) {
         if (optind >= argc) {
@@ -380,6 +396,10 @@ int main(int argc, char **argv)
             have_guest_base = true;
         } else if (!strcmp(r, "drop-ld-preload")) {
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
+#ifdef CONFIG_LIBC_SYSCALLS
+        } else if (!strcmp(r, "libc-syscalls")) {
+            qemu_use_libc_syscalls = true;
+#endif
         } else if (!strcmp(r, "seed")) {
             seed_optarg = optarg;
         } else if (!strcmp(r, "one-insn-per-tb")) {
diff --git a/common-user/meson.build b/common-user/meson.build
index ac9de5b9e3..1df0302001 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -8,3 +8,7 @@ user_ss.add(files(
   'safe-syscall.S',
   'safe-syscall-error.c',
 ))
+
+if get_option('libc_syscalls').enabled()
+  user_ss.add(files('safe-syscall.c'))
+endif
diff --git a/common-user/safe-syscall.c b/common-user/safe-syscall.c
new file mode 100644
index 0000000000..13a702761f
--- /dev/null
+++ b/common-user/safe-syscall.c
@@ -0,0 +1,66 @@
+/*
+ * safe-syscall.c: C implementation using libc's syscall()
+ * to handle signals occurring right before system calls.
+ *
+ * Written by Balint Reczey <balint@balintreczey.hu>
+ *
+ * Copyright (C) 2025 Balint Reczey
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#if defined(__linux__)
+# include "special-errno.h"
+#elif defined(__FreeBSD__)
+# include "errno_defs.h"
+#endif
+#include "user/safe-syscall.h"
+#include <stdarg.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include "qemu/atomic.h"
+
+/* Global runtime toggle (default: false). */
+bool qemu_use_libc_syscalls;
+
+/*
+ * libc-backed implementation: Make a system call via libc's syscall()
+ * if no guest signal is pending.
+ *
+ * IMPORTANT: Unlike the assembly implementation, this approach
+ * can't completely eliminate the race between checking signal_pending and
+ * entering the syscall. The platform-specific assembly versions eliminate
+ * the race as described in details in safe-syscall.h.
+  *
+ * In practice, this race window is extremely narrow (typically a few CPU cycles),
+ * and guest signals are rare events. The primary use case for this implementation
+ * is debugging and LD_PRELOAD interposition where perfect atomicity may
+ * be less critical than observability.
+ */
+long safe_syscall_libc(int *pending, long number, ...)
+{
+    va_list ap;
+    long arg1, arg2, arg3, arg4, arg5, arg6;
+    long ret;
+
+    va_start(ap, number);
+    /* Extract up to 6 syscall arguments */
+    arg1 = va_arg(ap, long);
+    arg2 = va_arg(ap, long);
+    arg3 = va_arg(ap, long);
+    arg4 = va_arg(ap, long);
+    arg5 = va_arg(ap, long);
+    arg6 = va_arg(ap, long);
+    va_end(ap);
+
+    if (qatomic_read(pending)) {
+        errno = QEMU_ERESTARTSYS;
+        return -1;
+    }
+
+    /* Make the actual system call using libc's syscall() */
+    ret = syscall(number, arg1, arg2, arg3, arg4, arg5, arg6);
+
+    return ret;
+}
diff --git a/docs/user/main.rst b/docs/user/main.rst
index a8ddf91424..c3f0d4b4fe 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -70,7 +70,7 @@ Command line options
 
 ::
 
-   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] program [arguments...]
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] [-libc-syscalls] program [arguments...]
 
 ``-h``
    Print the help
@@ -101,6 +101,16 @@ Command line options
    bytes). \"G\", \"M\", and \"k\" suffixes may be used when specifying
    the size.
 
+``-libc-syscalls``
+   Use the host C library's ``syscall()`` entry point for guest system calls
+   instead of QEMU's built-in assembly safe-syscall. By default this option
+   is disabled and QEMU uses its internal assembly implementation for
+   performance and precise control of signal-restart semantics. This switch is
+   primarily intended for debugging and other special scenarios (for example
+   when interposing on ``syscall()`` via ``LD_PRELOAD``). Available on Linux
+   and BSD user-mode builds. This option is only present if QEMU was configured
+   with ``-Dlibc_syscalls=enabled``.
+
 Debug options:
 
 ``-d item1,...``
@@ -135,6 +145,10 @@ QEMU_STRACE
    format are printed with information for six arguments. Many
    flag-style arguments don't have decoders and will show up as numbers.
 
+QEMU_LIBC_SYSCALLS
+   When set to a non-empty value, behave as if ``-libc-syscalls`` was specified
+   on the command line. Defaults to disabled.
+
 Other binaries
 ~~~~~~~~~~~~~~
 
@@ -231,7 +245,7 @@ Command line options
 
 ::
 
-   qemu-sparc64 [-h] [-d] [-L path] [-s size] [-bsd type] program [arguments...]
+   qemu-sparc64 [-h] [-d] [-L path] [-s size] [-bsd type] [-libc-syscalls] program [arguments...]
 
 ``-h``
    Print the help
@@ -256,6 +270,12 @@ Command line options
    Set the type of the emulated BSD Operating system. Valid values are
    FreeBSD, NetBSD and OpenBSD (default).
 
+``-libc-syscalls``
+   Use the host C library's ``syscall()`` entry point for guest system calls
+   instead of QEMU's built-in assembly safe-syscall. See the Linux user-mode
+   option of the same name for details. Defaults to disabled. This option is
+   only present if QEMU was configured with ``-Dlibc_syscalls=enabled``.
+
 Debug options:
 
 ``-d item1,...``
@@ -266,3 +286,9 @@ Debug options:
    Run the emulation with one guest instruction per translation block.
    This slows down emulation a lot, but can be useful in some situations,
    such as when trying to analyse the logs produced by the ``-d`` option.
+
+Environment variables:
+
+QEMU_LIBC_SYSCALLS
+   When set to a non-empty value, behave as if ``-libc-syscalls`` was specified
+   on the command line. Defaults to disabled.
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index aa075f4d5c..682f2f16f0 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -128,13 +128,30 @@
 /* The core part of this function is implemented in assembly */
 long safe_syscall_base(int *pending, long number, ...);
 long safe_syscall_set_errno_tail(int value);
+#ifdef CONFIG_LIBC_SYSCALLS
+/* This is implemented in C.*/
+long safe_syscall_libc(int *pending, long number, ...);
+extern bool qemu_use_libc_syscalls;
+#endif
 
-/* These are defined by the safe-syscall.inc.S file */
+/*
+ * These are defined by the safe-syscall.inc.S file.
+ * In the C implementation, they are dummy symbols.
+ */
 extern char safe_syscall_start[];
 extern char safe_syscall_end[];
 
+#ifdef CONFIG_LIBC_SYSCALLS
+#define safe_syscall(...)                                               \
+    (qemu_use_libc_syscalls ?                                           \
+     safe_syscall_libc(&get_task_state(thread_cpu)->signal_pending,     \
+                       __VA_ARGS__) :                                   \
+     safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,     \
+                       __VA_ARGS__))
+#else
 #define safe_syscall(...)                                                 \
     safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,        \
                       __VA_ARGS__)
+#endif
 
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index db751c0757..8d4e4f7722 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -40,6 +40,9 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
+#ifdef CONFIG_LIBC_SYSCALLS
+#include "user/safe-syscall.h"
+#endif
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
 #include "accel/accel-ops.h"
@@ -456,6 +459,14 @@ static void handle_arg_jitdump(const char *arg)
     perf_enable_jitdump();
 }
 
+#ifdef CONFIG_LIBC_SYSCALLS
+static void handle_arg_libc_syscalls(const char *arg)
+{
+    /* Enable libc-backed syscall implementation */
+    qemu_use_libc_syscalls = true;
+}
+#endif
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 #ifdef CONFIG_PLUGIN
@@ -534,6 +545,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+#ifdef CONFIG_LIBC_SYSCALLS
+    {"libc-syscalls", "QEMU_LIBC_SYSCALLS", false, handle_arg_libc_syscalls,
+     "",           "use libc syscall() instead of assembly safe-syscall"},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
diff --git a/meson.build b/meson.build
index 48c1795b0f..21bf921e34 100644
--- a/meson.build
+++ b/meson.build
@@ -2508,6 +2508,7 @@ if numa.found()
 endif
 config_host_data.set('CONFIG_OPENGL', opengl.found())
 config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
+config_host_data.set('CONFIG_LIBC_SYSCALLS', get_option('libc_syscalls').enabled())
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
 config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
diff --git a/meson_options.txt b/meson_options.txt
index 2836156257..0f1ad3452c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -66,6 +66,10 @@ option('tools', type : 'feature', value : 'auto',
 option('qga_vss', type : 'feature', value: 'auto',
        description: 'build QGA VSS support (broken with MinGW)')
 
+# Enable libc-backed safe_syscall in user-mode (-libc-syscalls option)
+option('libc_syscalls', type: 'feature', value: 'disabled',
+       description: 'Enable libc-backed safe_syscall() and -libc-syscalls in user-mode (POTENTIALLY UNSAFE SIGNAL HANDLING)')
+
 option('malloc_trim', type : 'feature', value : 'auto',
        description: 'enable libc malloc_trim() for memory optimization')
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3d0d132344..31ab6625fb 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -136,6 +136,8 @@ meson_options_help() {
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
   printf "%s\n" '  l2tpv3          l2tpv3 network backend support'
+  printf "%s\n" '  libc-syscalls    Enable libc-backed safe_syscall() and -libc-syscalls in'
+  printf "%s\n" '                  user-mode (POTENTIALLY UNSAFE SIGNAL HANDLING)'
   printf "%s\n" '  libcbor         libcbor support'
   printf "%s\n" '  libdaxctl       libdaxctl support'
   printf "%s\n" '  libdw           debuginfo support'
@@ -365,6 +367,8 @@ _meson_option_parse() {
     --disable-kvm) printf "%s" -Dkvm=disabled ;;
     --enable-l2tpv3) printf "%s" -Dl2tpv3=enabled ;;
     --disable-l2tpv3) printf "%s" -Dl2tpv3=disabled ;;
+    --enable-libc-syscalls) printf "%s" -Dlibc_syscalls=enabled ;;
+    --disable-libc-syscalls) printf "%s" -Dlibc_syscalls=disabled ;;
     --enable-libcbor) printf "%s" -Dlibcbor=enabled ;;
     --disable-libcbor) printf "%s" -Dlibcbor=disabled ;;
     --enable-libdaxctl) printf "%s" -Dlibdaxctl=enabled ;;
-- 
2.43.0


