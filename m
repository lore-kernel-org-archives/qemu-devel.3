Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE188D5CCAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69PL-0004cE-EE; Wed, 30 Oct 2024 10:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t69PJ-0004bv-SZ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:10:45 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t69PH-0000li-28
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:10:44 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e6105886dfso434093b6e.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730297441; x=1730902241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+E82RCmomA+sd4VxPE/nsTTizNIQkqjFJzq3s/cTkA=;
 b=KX8+JD1mYB6h190d+FgKlAjQo3zBb9UPtvvRBo/d3tb6pto3xHshat3idK7RtJWPrV
 FR4muWgRkmjSzGfWtjUqQLRc8Z6TEC8XDSIewhhdIqKsXjONwfhWi5SN7+Jp/7P+g/33
 OY+jedUP6yaKd/U7YSmLqMCTY8fwW6wGMJMl6WzOfkOTxfHt1DnoljMfOaKyGCc+jKma
 mHq4Dz1jZFZdX9+G7gksxe3LLeUfpN5oJP1Vjws8O4YquzI7fZ8PC5VmmgEf6823pIn0
 ICT24wBUnMlSZmbJzFkrLPP5BmxQIZeFxfizPnk2C1V3ReQvEO34mUsT3lu1Cpl/i6G2
 a42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730297441; x=1730902241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+E82RCmomA+sd4VxPE/nsTTizNIQkqjFJzq3s/cTkA=;
 b=k7a8Ey51hdCLfLO3D8nVcZRV1u5TP9vpc9n52bGCfad50WoDOFnmaxLQoHexycDgND
 iqXZCLCwxghPH9oRj3oRqrp0T057iJxa2tQV0aG7NZhUwBAHxUnsMBm65oiIzxrWb+fG
 zPFgPZWyhEQ2fv+Bdj/mHP9VWhf7j/SbsNzuBO3yd8MTWvlEKGINkxOSvV0W6Gq4xw4y
 xb6eOfGN+FN6jPOhanSeBm61SnuhjT/JJ3SB2iUxlu/VW4sqelk5mI8bdEKrh4YEvP5R
 3kJi0JScSrAL1OaZX2NkRqZ8Ui8zL/4AO4ChJQLgdRK8WgIkMC5LuE16d9Uz4eL7UVw9
 vsqg==
X-Gm-Message-State: AOJu0YzSZ2Z+TGDEzTqJPGiZJP7lqHdSCEmUmSRkONFsF4ZpJBtPNQ37
 2Q1RVT1MNwBB+faXoAN+vSKLmy/bX4gHXe/kUQOmOB5s0icU5bRerdLlIR4j
X-Google-Smtp-Source: AGHT+IFn1ywCAt5INAH4gS9aQMjXEtvyJPfupnuJ3ZZwK+LhV4CNAOTi7rM+qQKK2Qm2z4I1s4d0uw==
X-Received: by 2002:a54:4599:0:b0:3e6:4f60:407a with SMTP id
 5614622812f47-3e65963a351mr1187210b6e.4.1730297441400; 
 Wed, 30 Oct 2024 07:10:41 -0700 (PDT)
Received: from localhost.localdomain.lan
 ([2603:8080:1600:131:d34:e16a:7c04:76f1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29035da57fasm3403713fac.20.2024.10.30.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 07:10:40 -0700 (PDT)
From: Noah Goldstein <goldstein.w.n@gmail.com>
To: qemu-devel@nongnu.org
Cc: goldstein.w.n@gmail.com,
	iii@linux.ibm.com,
	laurent@vivier.eu
Subject: linux-user: Add option to run `execve`d programs through QEMU
Date: Wed, 30 Oct 2024 09:10:37 -0500
Message-ID: <20241030141037.375897-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The new option '-qemu-children' makes it so that on `execve` the child
process will be launch by the same `qemu` executable that is currently
running along with its current commandline arguments.

The motivation for the change is to make it so that plugins running
through `qemu` can continue to run on children.  Why not just
`binfmt`?: Plugins can be desirable regardless of system/architecture
emulation, and can sometimes be useful for elf files that can run
natively. Enabling `binfmt` for all natively runnable elf files may
not be desirable.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 linux-user/main.c                             | 21 ++++++
 linux-user/syscall.c                          | 21 ++++--
 linux-user/user-internals.h                   |  4 ++
 tests/tcg/multiarch/Makefile.target           |  8 +++
 .../linux/linux-execve-qemu-children.c        | 68 +++++++++++++++++++
 5 files changed, 117 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-execve-qemu-children.c

diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b0..5e3d41dc2b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
 uintptr_t guest_base;
 bool have_guest_base;
 
+bool qemu_dup_for_children;
+int qemu_argc;
+char **qemu_argv;
+
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
  * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
@@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
     perf_enable_jitdump();
 }
 
+static void handle_arg_qemu_children(const char *arg)
+{
+    qemu_dup_for_children = true;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 #ifdef CONFIG_PLUGIN
@@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+    {"qemu-children",
+                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
+     "",           "Run child processes (created with execve) with qemu "
+                   "(as instantiated for the parent)"},
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
 
     optind = parse_args(argc, argv);
 
+    if (qemu_dup_for_children) {
+        qemu_argc = optind;
+        qemu_argv = g_new0(char *, qemu_argc);
+        for (i = 0; i < optind; ++i) {
+            qemu_argv[i] = strdup(argv[i]);
+        }
+    }
+
     qemu_set_log_filename_flags(last_log_filename,
                                 last_log_mask | (enable_strace * LOG_STRACE),
                                 &error_fatal);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59b2080b98..96b105e9ce 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8550,13 +8550,14 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
                     abi_long pathname, abi_long guest_argp,
                     abi_long guest_envp, int flags, bool is_execveat)
 {
-    int ret;
+    int ret, argp_offset;
     char **argp, **envp;
     int argc, envc;
     abi_ulong gp;
     abi_ulong addr;
     char **q;
     void *p;
+    bool through_qemu = dirfd == AT_FDCWD && qemu_dup_for_children;
 
     argc = 0;
 
@@ -8580,10 +8581,12 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
         envc++;
     }
 
-    argp = g_new0(char *, argc + 1);
+    argp_offset = through_qemu ? qemu_argc : 0;
+    argp = g_new0(char *, argc + argp_offset + 1);
     envp = g_new0(char *, envc + 1);
 
-    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset;
+         gp; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp)) {
             goto execve_efault;
         }
@@ -8628,9 +8631,16 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     }
 
     const char *exe = p;
-    if (is_proc_myself(p, "exe")) {
+    if (through_qemu) {
+        int i;
+        for (i = 0; i < argp_offset; ++i) {
+            argp[i] = qemu_argv[i];
+        }
+        exe = qemu_argv[0];
+    } else if (is_proc_myself(p, "exe")) {
         exe = exec_path;
     }
+
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
         : safe_execve(exe, argp, envp);
@@ -8644,7 +8654,8 @@ execve_efault:
     ret = -TARGET_EFAULT;
 
 execve_end:
-    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset;
+         *q; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp) || !addr) {
             break;
         }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 46ffc093f4..ed3ed666a0 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -30,6 +30,10 @@ void stop_all_tasks(void);
 extern const char *qemu_uname_release;
 extern unsigned long mmap_min_addr;
 
+extern bool qemu_dup_for_children;
+extern int qemu_argc;
+extern char **qemu_argv;
+
 typedef struct IOCTLEntry IOCTLEntry;
 
 typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 78b83d5575..0e220953e7 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -30,6 +30,14 @@ run-float_%: float_%
 	$(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/$<.ref)
 
 
+run-linux-execve-qemu-children: linux-execve-qemu-children
+	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) -qemu-children $< $(QEMU) 0)
+	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) $< linux-execve 0 skip)
+
+run-plugin-linux-execve-qemu-children-with-%: linux-execve-qemu-children
+	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) -qemu-children $< $(QEMU) 0)
+	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) $< linux-execve 0 skip)
+
 testthread: LDFLAGS+=-lpthread
 
 threadcount: LDFLAGS+=-lpthread
diff --git a/tests/tcg/multiarch/linux/linux-execve-qemu-children.c b/tests/tcg/multiarch/linux/linux-execve-qemu-children.c
new file mode 100644
index 0000000000..60d6537666
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-execve-qemu-children.c
@@ -0,0 +1,68 @@
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <malloc.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#define MAX_COMM_SIZE (4096)
+
+int
+main(int argc, char ** argv, char ** envp) {
+    int          fd;
+    char         next_arg[2];
+    char *       buf;
+    ssize_t      off;
+    const char * expec_comm;
+    assert(argc == 3 || argc == 4);
+    fd = open("/proc/self/comm", O_RDONLY);
+    assert(fd > 0);
+
+    buf = calloc(MAX_COMM_SIZE + 1, 1);
+    assert(buf != NULL);
+
+    off = 0;
+    for (;;) {
+        ssize_t res = read(fd, buf + off, 1);
+        if (res < 0 && errno != EAGAIN) {
+            perror("Failed to read comm");
+            return -1;
+        }
+        if (res == 0) {
+            break;
+        }
+
+        off += res;
+
+        if (off >= MAX_COMM_SIZE) {
+            fprintf(stderr, "/proc/self/comm too large for test\n");
+            return -1;
+        }
+    }
+    assert(off && buf[off] == '\0' && buf[off - 1] == '\n');
+    buf[off - 1] = '\0';
+    expec_comm   = basename(argv[1]);
+    if (argc == 3 && strncmp(buf, expec_comm, strlen(expec_comm))) {
+        fprintf(stderr,
+                "Didn't propagate qemu settings\nComm:  '%s'\nExpec: '%s'\n",
+                buf, expec_comm);
+        return -1;
+    }
+    free(buf);
+    next_arg[0] = argv[2][0];
+    next_arg[1] = '\0';
+    if (next_arg[0] == '9') {
+        return 0;
+    }
+    next_arg[0] += 1;
+    char * next_args[] = { argv[0], argv[1], next_arg, NULL };
+    int    eres        = execve(argv[0], &next_args[0], envp);
+    if (eres != 0) {
+        fprintf(stderr, "Unable to execve: %d/%d -> %s\n", eres, errno,
+                strerror(errno));
+        return -1;
+    }
+    return 0;
+}
-- 
2.43.0


