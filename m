Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7D4C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA0-0005Jr-Mv; Fri, 18 Sep 2026 00:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9y-0005Is-7T
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:14 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9v-00048y-1E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:13 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f4df360cc9so266559a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705509; x=1790310309;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTx372A955iYn+m8eBz9b6pWPZEog7o6SPKBMuzmyhk=;
 b=chHDUwEqXVdaIi/eSudGrPDOHigboQuojGLMl0bAzOplhIjL8UtEZ5XBB8sRK+xeki
 AF6VTk6Xu0WWZJQbkpxbuq28hNi91cskF1blnzNOd061rIOUECVMGpuS74v5SFu8A67k
 ilshVqscuXK2NilF7oMO6APhWZkOgTWgFxeM+3R44cDSFY/CjiZY+xZ+yCJL7CN2MqbA
 MRGRGYbiLOh7LpOQ5j+iZF7i3hkvrNhTzdpg15x8lLG0/nY7EvMJn20gMzCYouCCE/Xq
 04aOk4t3qEodnBWFPq3kysHwunrm+Z9BdqeNHU8yfE+tLEn57Io1b7gHWZFUcbhawdZQ
 Xv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705509; x=1790310309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTx372A955iYn+m8eBz9b6pWPZEog7o6SPKBMuzmyhk=;
 b=Ea2hqM6S9llM9ERnBaioYGJAJiO3OTlnnC06eBt8Vb+Z0Z7ZWg/Ef1V3l6VplXbXYw
 VqEXpXMuKzMfiv53Kc+TvWIlCTd5Nhz5D41l1p5A04x3LQwBdZonBjxL961m35NKfV0X
 tEKlCsJ6SAxWNXUjTYORXOhojuaPfLH7Si76St2WVrYY2g4sWrKTfEwbRCc9JGFm8bPV
 Ly/+rdbzc7SgOblo7Lwh9VPt0oCyjVYXzijWdwva9fvgveMbnnfxf2h/eZi3DLfTkPgC
 mOHOj61yOgjZ1qQpVLDxEgWmtISlDWEytOG0OGi/C9YuQF0zZeg3GCPvPC5/Qp84sH9k
 5egg==
X-Gm-Message-State: AFuF++nQyljZnDvTXwPj/FS8o5Yg8UgKNWr+ZgKhKapqLj1oFDjGdY1N
 Vw3FITG0h7i5dD0gmeoBRNo8R+94Tfdy5/xlPcJkYqPHcY26GGw3nAz9QcBo82MbBtKH8vWcQQw
 ho8eF+Tw=
X-Gm-Gg: AYBFou2GPuQHWiplY23Dsy0KPYD9Mv3H8blR222636AkL/f5AGdPyLK6Dl/3L2vAHqH
 2GHw4fdAhoSXv1tnADWaKNzjaHLMGbrseMowWxe5gESeck4+r4lyS+2m924X/bxxTq8FgeBDw5f
 E32KL4klnxIelPKCL0JpABnI6PRnlii/z+lVgcTmZ4Gy5dmlcZx6v+R2oYPyv8jr27ADIyF8H5h
 YDWE8r2nZ1yEa5eOfTK8lApsXq8hnP+F59dF4watqIlMgGbwOXGvaw+luRe7ts4HSoTaaqYk0ji
 EGK+D55bs+1bTIvDaIzBrHU/jZUW0huRwzVQjqq28a6CG0IZINQd63WyhFPEY7KFuaFFs7knIcZ
 d9WTIrdx6+ZtlJyNxNDVyJhm3ZtY35eMAOmyqwhy2FkHR9cEY0gxL1mmRC5aO0aCl80Gn00tYPY
 6B+uy6+iW87bJWz1z1Er4FeQBr2uPzzhrT6WrqSevalVW16vIVXiWciGxDzw==
X-Received: by 2002:a05:6830:67e4:b0:807:50d:7f3a with SMTP id
 46e09a7af769-80c4e7f7ba1mr4213103a34.30.1789705509239; 
 Thu, 17 Sep 2026 21:25:09 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/41] bsd-user: Rename cpu_env to env throughout bsd-user
Date: Thu, 17 Sep 2026 22:23:43 -0600
Message-ID: <20260918042422.38713-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace 'void *cpu_env' parameters with 'CPUArchState *env' across all
bsd-user source files. This improves type safety and aligns with the
convention used in the rest of the codebase.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/target.h     |  2 +-
 bsd-user/arm/target.h         |  2 +-
 bsd-user/bsd-file.h           | 28 +++++++++++-----------
 bsd-user/bsd-mem.h            |  4 ++--
 bsd-user/bsd-proc.h           |  8 +++----
 bsd-user/freebsd/os-proc.c    |  4 ++--
 bsd-user/freebsd/os-proc.h    | 26 ++++++++++-----------
 bsd-user/freebsd/os-sys.c     |  4 ++--
 bsd-user/freebsd/os-syscall.c | 44 +++++++++++++++++------------------
 bsd-user/i386/target.h        |  2 +-
 bsd-user/qemu.h               |  6 ++---
 bsd-user/riscv/target.h       |  2 +-
 bsd-user/x86_64/target.h      |  2 +-
 13 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/bsd-user/aarch64/target.h b/bsd-user/aarch64/target.h
index 702aeb7fc5..37b9817fe1 100644
--- a/bsd-user/aarch64/target.h
+++ b/bsd-user/aarch64/target.h
@@ -12,7 +12,7 @@
 /*
  * aaarch64 ABI does not 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/arm/target.h b/bsd-user/arm/target.h
index 7c423ec575..cf131f29fb 100644
--- a/bsd-user/arm/target.h
+++ b/bsd-user/arm/target.h
@@ -12,7 +12,7 @@
 /*
  * arm EABI 'lumps' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return true;
 }
diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index dca1518cb1..dec59bd80b 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -72,7 +72,7 @@ static abi_long do_bsd_read(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pread(2) */
-static abi_long do_bsd_pread(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pread(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
@@ -82,7 +82,7 @@ static abi_long do_bsd_pread(void *cpu_env, abi_long arg1,
     if (p == NULL) {
         return -TARGET_EFAULT;
     }
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg4 = arg5;
         arg5 = arg6;
     }
@@ -109,14 +109,14 @@ static abi_long do_bsd_readv(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* preadv(2) */
-static abi_long do_bsd_preadv(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_preadv(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
     struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 1);
 
     if (vec != NULL) {
-        if (regpairs_aligned(cpu_env) != 0) {
+        if (regpairs_aligned(env) != 0) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -151,7 +151,7 @@ static abi_long do_bsd_write(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pwrite(2) */
-static abi_long do_bsd_pwrite(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pwrite(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
@@ -161,7 +161,7 @@ static abi_long do_bsd_pwrite(void *cpu_env, abi_long arg1,
     if (p == NULL) {
         return -TARGET_EFAULT;
     }
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg4 = arg5;
         arg5 = arg6;
     }
@@ -188,14 +188,14 @@ static abi_long do_bsd_writev(abi_long arg1, abi_long arg2, abi_long arg3)
 }
 
 /* pwritev(2) */
-static abi_long do_bsd_pwritev(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_pwritev(CPUArchState *env, abi_long arg1,
     abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
     abi_long ret;
     struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
 
     if (vec != NULL) {
-        if (regpairs_aligned(cpu_env) != 0) {
+        if (regpairs_aligned(env) != 0) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -484,14 +484,14 @@ static abi_long do_bsd_dup2(abi_long arg1, abi_long arg2)
 }
 
 /* truncate(2) */
-static abi_long do_bsd_truncate(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_truncate(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4)
 {
     abi_long ret;
     void *p;
 
     LOCK_PATH(p, arg1);
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -502,10 +502,10 @@ static abi_long do_bsd_truncate(void *cpu_env, abi_long arg1,
 }
 
 /* ftruncate(2) */
-static abi_long do_bsd_ftruncate(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_ftruncate(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -735,7 +735,7 @@ static abi_long do_bsd_freebsd11_mknodat(abi_long arg1, abi_long arg2,
 }
 
 /* post-ino64 mknodat(2) */
-static abi_long do_bsd_mknodat(void *cpu_env, abi_long arg1,
+static abi_long do_bsd_mknodat(CPUArchState *env, abi_long arg1,
         abi_long arg2, abi_long arg3, abi_long arg4, abi_long arg5,
         abi_long arg6)
 {
@@ -744,7 +744,7 @@ static abi_long do_bsd_mknodat(void *cpu_env, abi_long arg1,
 
     LOCK_PATH(p, arg2);
        /* 32-bit arch's use two 32 registers for 64 bit return value */
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         ret = get_errno(mknodat(arg1, p, arg3, target_arg64(arg5, arg6)));
     } else {
         ret = get_errno(mknodat(arg1, p, arg3, target_arg64(arg4, arg5)));
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 9d7b60d3c3..3086143d40 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -51,11 +51,11 @@ extern abi_ulong target_brk;
 extern abi_ulong initial_target_brk;
 
 /* mmap(2) */
-static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_long arg2,
+static inline abi_long do_bsd_mmap(CPUArchState *env, abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, abi_long arg7,
     abi_long arg8)
 {
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         arg6 = arg7;
         arg7 = arg8;
     }
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b1d4446ff1..7efc5b4c92 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef BSD_PROC_H_
-#define BSD_PROC_H_
+#ifndef BSD_PROC_H
+#define BSD_PROC_H
 
 #include <sys/resource.h>
 
@@ -19,7 +19,7 @@ extern int _getlogin(char*, int);
 int bsd_get_ncpu(void);
 
 /* exit(2) */
-static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
+static inline abi_long do_bsd_exit(CPUArchState *env, abi_long arg1)
 {
     gdb_exit(arg1);
     qemu_plugin_user_exit();
@@ -400,4 +400,4 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
-#endif /* !BSD_PROC_H_ */
+#endif /* !BSD_PROC_H */
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index 0309036178..0a0cea5bb2 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -238,7 +238,7 @@ h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
 }
 
 abi_long
-do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong arg3,
+do_freebsd_procctl(CPUArchState *env, int idtype, abi_ulong arg2, abi_ulong arg3,
        abi_ulong arg4, abi_ulong arg5, abi_ulong arg6)
 {
     abi_long error = 0, target_rp_pids;
@@ -257,7 +257,7 @@ do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2, abi_ulong arg3,
 
 #if TARGET_ABI_BITS == 32
     /* See if we need to align the register pairs. */
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(env)) {
         id = (id_t)target_arg64(arg3, arg4);
         target_cmd = (int)arg5;
         target_arg = arg6;
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 1cf3c43de3..7a035f5481 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -68,7 +68,7 @@ static inline abi_long do_freebsd_wait4(abi_long arg1, abi_ulong target_status,
 }
 
 /* wait6(2) */
-static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
+static inline abi_long do_freebsd_wait6(CPUArchState *env, abi_long idtype,
     abi_long id1, abi_long id2,
     abi_ulong target_status, abi_long options, abi_ulong target_wrusage,
     abi_ulong target_infop, abi_ulong pad1)
@@ -79,7 +79,7 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     siginfo_t info;
     void *p;
 
-    if (regpairs_aligned(cpu_env) != 0) {
+    if (regpairs_aligned(env) != 0) {
         /* printf("shifting args\n"); */
         /* 64-bit id is aligned, so shift all the arguments over by one */
         id1 = id2;
@@ -173,7 +173,7 @@ static inline abi_long do_freebsd___setugid(abi_long arg1)
 }
 
 /* fork(2) */
-static inline abi_long do_freebsd_fork(void *cpu_env)
+static inline abi_long do_freebsd_fork(CPUArchState *env)
 {
     abi_long ret;
     abi_ulong child_flag;
@@ -183,7 +183,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -193,7 +193,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
 
     fork_end(ret);
 
@@ -201,13 +201,13 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
 }
 
 /* vfork(2) */
-static inline abi_long do_freebsd_vfork(void *cpu_env)
+static inline abi_long do_freebsd_vfork(CPUArchState *env)
 {
-    return do_freebsd_fork(cpu_env);
+    return do_freebsd_fork(env);
 }
 
 /* rfork(2) */
-static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
+static inline abi_long do_freebsd_rfork(CPUArchState *env, abi_long flags)
 {
     abi_long ret;
     abi_ulong child_flag;
@@ -228,7 +228,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -238,7 +238,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
     fork_end(ret);
 
     return ret;
@@ -246,7 +246,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 }
 
 /* pdfork(2) */
-static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
+static inline abi_long do_freebsd_pdfork(CPUArchState *env, abi_ulong target_fdp,
         abi_long flags)
 {
     abi_long ret;
@@ -258,7 +258,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
     if (ret == 0) {
         /* child */
         child_flag = 1;
-        target_cpu_clone_regs(cpu_env, 0);
+        target_cpu_clone_regs(env, 0);
     } else {
         /* parent */
         child_flag = 0;
@@ -271,7 +271,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * The fork system call sets a child flag in the second return
      * value: 0 for parent process, 1 for child process.
      */
-    set_second_rval(cpu_env, child_flag);
+    set_second_rval(env, child_flag);
     fork_end(ret);
 
     return ret;
diff --git a/bsd-user/freebsd/os-sys.c b/bsd-user/freebsd/os-sys.c
index df31706558..d6f7c92420 100644
--- a/bsd-user/freebsd/os-sys.c
+++ b/bsd-user/freebsd/os-sys.c
@@ -593,7 +593,7 @@ out:
 }
 
 /* sysarch() is architecture dependent. */
-abi_long do_freebsd_sysarch(void *cpu_env, abi_long arg1, abi_long arg2)
+abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2)
 {
-    return do_freebsd_arch_sysarch(cpu_env, arg1, arg2);
+    return do_freebsd_arch_sysarch(env, arg1, arg2);
 }
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 90ef1bd916..d402c64726 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -215,7 +215,7 @@ void unlock_iovec(struct iovec *vec, abi_ulong target_addr,
 /*
  * All errnos that freebsd_syscall() returns must be -TARGET_<errcode>.
  */
-static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                                 abi_long arg2, abi_long arg3, abi_long arg4,
                                 abi_long arg5, abi_long arg6, abi_long arg7,
                                 abi_long arg8)
@@ -227,19 +227,19 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * process system calls
          */
     case TARGET_FREEBSD_NR_fork: /* fork(2) */
-        ret = do_freebsd_fork(cpu_env);
+        ret = do_freebsd_fork(env);
         break;
 
     case TARGET_FREEBSD_NR_vfork: /* vfork(2) */
-        ret = do_freebsd_vfork(cpu_env);
+        ret = do_freebsd_vfork(env);
         break;
 
     case TARGET_FREEBSD_NR_rfork: /* rfork(2) */
-        ret = do_freebsd_rfork(cpu_env, arg1);
+        ret = do_freebsd_rfork(env, arg1);
         break;
 
     case TARGET_FREEBSD_NR_pdfork: /* pdfork(2) */
-        ret = do_freebsd_pdfork(cpu_env, arg1, arg2);
+        ret = do_freebsd_pdfork(env, arg1, arg2);
         break;
 
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
@@ -255,12 +255,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_wait6: /* wait6(2) */
-        ret = do_freebsd_wait6(cpu_env, arg1, arg2, arg3,
+        ret = do_freebsd_wait6(env, arg1, arg2, arg3,
                                arg4, arg5, arg6, arg7, arg8);
         break;
 
     case TARGET_FREEBSD_NR_exit: /* exit(2) */
-        ret = do_bsd_exit(cpu_env, arg1);
+        ret = do_bsd_exit(env, arg1);
         break;
 
     case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
@@ -424,7 +424,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_procctl: /* procctl(2) */
-        ret = do_freebsd_procctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_procctl(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
         /*
@@ -435,7 +435,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pread: /* pread(2) */
-        ret = do_bsd_pread(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pread(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_readv: /* readv(2) */
@@ -443,7 +443,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_preadv: /* preadv(2) */
-        ret = do_bsd_preadv(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_preadv(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_write: /* write(2) */
@@ -451,7 +451,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pwrite: /* pwrite(2) */
-        ret = do_bsd_pwrite(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pwrite(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_writev: /* writev(2) */
@@ -459,7 +459,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_pwritev: /* pwritev(2) */
-        ret = do_bsd_pwritev(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_pwritev(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_open: /* open(2) */
@@ -559,11 +559,11 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_truncate: /* truncate(2) */
-        ret = do_bsd_truncate(cpu_env, arg1, arg2, arg3, arg4);
+        ret = do_bsd_truncate(env, arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_ftruncate: /* ftruncate(2) */
-        ret = do_bsd_ftruncate(cpu_env, arg1, arg2, arg3, arg4);
+        ret = do_bsd_ftruncate(env, arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_acct: /* acct(2) */
@@ -595,7 +595,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_readlink: /* readlink(2) */
-        ret = do_bsd_readlink(cpu_env, arg1, arg2, arg3);
+        ret = do_bsd_readlink(env, arg1, arg2, arg3);
         break;
 
     case TARGET_FREEBSD_NR_readlinkat: /* readlinkat(2) */
@@ -627,7 +627,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_mknodat: /* mknodat(2) */
-        ret = do_bsd_mknodat(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_bsd_mknodat(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_chown: /* chown(2) */
@@ -807,7 +807,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * Memory management system calls.
          */
     case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
-        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+        ret = do_bsd_mmap(env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
                           arg8);
         break;
 
@@ -953,15 +953,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
          * sys{ctl, arch, call}
          */
     case TARGET_FREEBSD_NR___sysctl: /* sysctl(3) */
-        ret = do_freebsd_sysctl(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_sysctl(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR___sysctlbyname: /* sysctlbyname(2) */
-        ret = do_freebsd_sysctlbyname(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        ret = do_freebsd_sysctlbyname(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
     case TARGET_FREEBSD_NR_sysarch: /* sysarch(2) */
-        ret = do_freebsd_sysarch(cpu_env, arg1, arg2);
+        ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
     default:
@@ -979,7 +979,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
  * as a wrapper around freebsd_syscall() so that actually happens. Since
  * that is a singleton, modern compilers will inline it anyway...
  */
-abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
@@ -990,7 +990,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
-    ret = freebsd_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6,
+    ret = freebsd_syscall(env, num, arg1, arg2, arg3, arg4, arg5, arg6,
                           arg7, arg8);
     if (do_strace) {
         print_freebsd_syscall_ret(num, ret);
diff --git a/bsd-user/i386/target.h b/bsd-user/i386/target.h
index ddd3b8ec08..9cd158fc11 100644
--- a/bsd-user/i386/target.h
+++ b/bsd-user/i386/target.h
@@ -12,7 +12,7 @@
 /*
  * i386 doesn't 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index b0b2c249fb..60d1adf560 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -176,7 +176,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 void target_set_brk(abi_ulong new_brk);
 abi_long do_brk(abi_ulong new_brk);
 void syscall_init(void);
-abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8);
@@ -238,7 +238,7 @@ int host_to_target_errno(int err);
 /* os-proc.c */
 abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
         abi_ulong guest_envp, int do_fexec);
-abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+abi_long do_freebsd_procctl(CPUArchState *env, int idtype, abi_ulong arg2,
         abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
 
 /* os-sys.c */
@@ -247,7 +247,7 @@ abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
 abi_long do_freebsd_sysctlbyname(CPUArchState *env, abi_ulong namep,
         int32_t namelen, abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp,
         abi_ulong newlen);
-abi_long do_freebsd_sysarch(void *cpu_env, abi_long arg1, abi_long arg2);
+abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2);
 
 /* user access */
 
diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
index 036ddd185e..dc3e0be795 100644
--- a/bsd-user/riscv/target.h
+++ b/bsd-user/riscv/target.h
@@ -12,7 +12,7 @@
 /*
  * riscv64 ABI does not 'lump' the registers for 64-bit args.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
diff --git a/bsd-user/x86_64/target.h b/bsd-user/x86_64/target.h
index 0cf0e2a14a..fccfc593bd 100644
--- a/bsd-user/x86_64/target.h
+++ b/bsd-user/x86_64/target.h
@@ -12,7 +12,7 @@
 /*
  * x86 doesn't 'lump' the registers for 64-bit args, all args are 64 bits.
  */
-static inline bool regpairs_aligned(void *cpu_env)
+static inline bool regpairs_aligned(CPUArchState *env)
 {
     return false;
 }
-- 
2.55.0


