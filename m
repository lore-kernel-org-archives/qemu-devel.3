Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C160BCA101A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 01:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skCnt-0006Ey-65; Fri, 30 Aug 2024 21:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1skADw-0000bC-4R
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:36:08 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1skADu-00045w-CK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:36:07 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e1651f48c31so2499140276.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725057365; x=1725662165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rMDFVMvjJEOudw8bnlcbNGMt/5UtjU5WLRqGq7dj+Bw=;
 b=TMdBHMqziexjw/cCNcV5Kg85BKWbqVW6xhBGQZtVHDGq4Y1iwFJVzGtOJFFnenh16I
 4BofsQ78oMWJTFlFR0JWkjqI7+IkeTThwpjFBs9H7IvfoyuR0EWawk1EeWhYzN5Q5c/V
 PDFDzcu5zDIaJ9lOiHYZA2TC7480Ekptrao4DcAP1iHk8DCgK8VMTNBKnuG3ZvxJE0jH
 sv67bHAohpKOUpU2WcqrK12KRSlcBwGv+ohrzLZ/mqj4qAue/Pe0gjA/w463ZNp3Mp5x
 v1yWLMMT2gGcn0fk8mCF1m16iopkDuncQpRbOnUdtawcU5qjn6lPc7fqzQ1G8EQ7xDFL
 cNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725057365; x=1725662165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMDFVMvjJEOudw8bnlcbNGMt/5UtjU5WLRqGq7dj+Bw=;
 b=jfpHjtOZFv/zLNtcLEnJD2Vhx1cDN/UhaKd0a1qyI9VdM0bYeEB2mwGN7K/c8EqbGp
 teJpoH34xH0xtcvRg3rzFdfhxwVAZQo1Jqe6qSHmP8ExO3rj0R7wPdlLbjRoQiKBBMX0
 Jqw27ScWD9nllnBO8joN7OEzNRwsLYZq6kZ4PMPnQOXcLE9ENQrmlBoKdgQzxo8F/a6L
 PMW2+HEnbP/5zt9YchFNUG4wi2P7MFi/zjDpvmhu3uEPHGCoY2AkcnIjPVDuXamdaRYS
 9FXVd6MUolcPHcbdQiBOGFMO6cg+6lunwSCysmX2KEvvAlLHqqPkhOeGaAbC/iBh4FGs
 k/6Q==
X-Gm-Message-State: AOJu0YzvBi1H5koopDyh3nW5hm67WnmJ/IhY+OjJdoj73UV27VGWl/mE
 a/wZGPnpSY3L6ueG+Ax15ox1gvGWA3vuSy4lAI5kbZtIDF3qghmn67dZvw==
X-Google-Smtp-Source: AGHT+IEHZTuOGdhve44IJbM4iJ6V0ZOW6D1Gzd10ab+Ds2adEIxC8HCsT2S5SZK6sUXzoMJamowh6w==
X-Received: by 2002:a05:6902:2b0b:b0:e1a:41ef:4a1a with SMTP id
 3f1490d57ef6-e1a79fe7e63mr3942150276.12.1725057364655; 
 Fri, 30 Aug 2024 15:36:04 -0700 (PDT)
Received: from noahgold-desk.sc.intel.com ([192.55.54.47])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340bfa76bsm18816856d6.29.2024.08.30.15.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 15:36:04 -0700 (PDT)
From: Noah Goldstein <goldstein.w.n@gmail.com>
To: qemu-devel@nongnu.org
Cc: goldstein.w.n@gmail.com,
	laurent@vivier.eu
Subject: [PATCH v1] linux-user: Add option to run `execve`d programs through
 QEMU
Date: Fri, 30 Aug 2024 15:36:01 -0700
Message-Id: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Aug 2024 21:21:16 -0400
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
 linux-user/main.c           | 22 ++++++++++++++++++++++
 linux-user/syscall.c        | 20 +++++++++++++++-----
 linux-user/user-internals.h |  4 ++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b0..dfb303a1f2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
 uintptr_t guest_base;
 bool have_guest_base;
 
+bool qemu_dup_for_children;
+int qemu_argc;
+char ** qemu_argv;
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
 
@@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
 
     optind = parse_args(argc, argv);
 
+    if (qemu_dup_for_children) {
+        int i;
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
index 9d5415674d..732ef89054 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
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
+    bool through_qemu = !is_execveat && qemu_dup_for_children;
 
     argc = 0;
 
@@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
         envc++;
     }
 
-    argp = g_new0(char *, argc + 1);
+    argp_offset = through_qemu ? qemu_argc : 0;
+    argp = g_new0(char *, argc + argp_offset + 1);
     envp = g_new0(char *, envc + 1);
 
-    for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset; gp; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp)) {
             goto execve_efault;
         }
@@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     }
 
     const char *exe = p;
-    if (is_proc_myself(p, "exe")) {
+    if (through_qemu) {
+        int i;
+        for (i = 0; i < argp_offset; ++i) {
+            argp[i] = qemu_argv[i];
+        }
+        exe = qemu_argv[0];
+    }
+    else if (is_proc_myself(p, "exe")) {
         exe = exec_path;
     }
+
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
         : safe_execve(exe, argp, envp);
@@ -8553,7 +8563,7 @@ execve_efault:
     ret = -TARGET_EFAULT;
 
 execve_end:
-    for (gp = guest_argp, q = argp; *q; gp += sizeof(abi_ulong), q++) {
+    for (gp = guest_argp, q = argp + argp_offset; *q; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp) || !addr) {
             break;
         }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 5c7f173ceb..0719e65ff4 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -30,6 +30,10 @@ void stop_all_tasks(void);
 extern const char *qemu_uname_release;
 extern unsigned long mmap_min_addr;
 
+extern bool qemu_dup_for_children;
+extern int qemu_argc;
+extern char ** qemu_argv;
+
 typedef struct IOCTLEntry IOCTLEntry;
 
 typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
-- 
2.34.1


