Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B0DC5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjJtB-0002JG-0F; Wed, 28 Aug 2024 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjJt9-0002A9-GJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:43:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjJt7-0000dU-5U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:43:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so659602966b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724856187; x=1725460987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hpVn81vMDt7oTw6ywsivWZmGXqKq2KnSx//V2GcwNPE=;
 b=mi+UCsGr6kJ89p67MdPSo1R3pIPA8m+58XR7MCNAn9Sfs9WqNPvW79+l4IJV0U0c62
 uovHxQsNGayoNQ228lB1e8vwHzD2I9OD3J8SEnlR7IchIpwrga8n7BVKrp5RX/SHnUbi
 q2KEonuKTadBcGPTRmnCAgDvXV1uvgMR7X78z19BEfO03xpxumPs1rCebG9/eQ6JyWxg
 6wTZFwIVqgTk5LhfHM3O13xUeW0JjR1bq7Tb+DdFGp2O9s7iJ5RE5Dvo084O8wkqwK1o
 ImzHIsPoH7X9X8z9sua8sd6mNL2VeMz1lnjzOZfD1bNqPLRTKWQyJLwbxc9R8YAbNm1q
 jNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724856187; x=1725460987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hpVn81vMDt7oTw6ywsivWZmGXqKq2KnSx//V2GcwNPE=;
 b=XNVB0q3rZ6fJuUH3aC61jHjJDVtop8pp72c8H5vpJDdM3sgmR+xuk6tjrytLEaPyE1
 nnpot7IuhdfcuDmuyn+13T0ov/1Uy/MKf4zsKErqmc1WbVGelRi/oCkErwqq2f/zTT+c
 RCMBnm0AlFrxw734uQYpy0R2O3oaBJKb9RIOo35+ZLSq9fiERKPSqmlw4zA78cUqd293
 4H/pnRf3HI8Nfbu/Ip0n2wBKDr+x7sDG5hPLO/MadWLlm0R4nL1BsvmfmetW5TEY5ewH
 Ak2dO29LuiC2sHYCQaBIYs7T9jQ9cSWddr2556ARBc3w28WhzfiV3OlUuKQptZUT/+fw
 5OPQ==
X-Gm-Message-State: AOJu0YxgWgE+W1sUKbKERBAm/ptyqxK3QVvR9W84VcX2gku8xGv9jH3g
 LwWGE/uSH0LPfrvWcVDirOhf4thJxTzGKfhkupLOyWJ3/AAkP+6VDstw2RY8
X-Google-Smtp-Source: AGHT+IHrAYQHjSYlXUDX+ubTdzqvMQcN7UY1cXgE3SFMxxqqRxL8Mnks8gvnxDnfKCWatyxrJQKjxg==
X-Received: by 2002:a17:907:7214:b0:a7a:9f0f:ab26 with SMTP id
 a640c23a62f3a-a86a52b36b2mr1204181166b.23.1724856185930; 
 Wed, 28 Aug 2024 07:43:05 -0700 (PDT)
Received: from top.fritz.box (p4fd6b0d7.dip0.t-ipconnect.de. [79.214.176.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e54852e9sm252483866b.37.2024.08.28.07.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 07:43:05 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Michael Vogt <mvogt@redhat.com>
Subject: [PATCH] linux-user: add openat2 support in linux-user
Date: Wed, 28 Aug 2024 16:42:28 +0200
Message-ID: <20240828144227.32977-2-mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=michael.vogt@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds support for the `openat2()` syscall in the
`linux-user` userspace emulator.

It is implemented by extracting a new helper `maybe_do_fake_open()`
out of the exiting `do_guest_openat()` and share that with the
new `do_guest_openat2()`. Unfortunatly we cannot just make
do_guest_openat2() a superset of do_guest_openat() because the
openat2() syscall is stricter with the argument checking and
will return an error for invalid flags or mode combinations (which
open()/openat() will ignore).

Note that in this commit using openat2() for a "faked" file in
/proc will ignore the "resolve" flags. This is not great but it
seems similar to the exiting behavior when openat() is called
with a dirfd to "/proc". Here too the fake file lookup may
not catch the special file because "realpath()" is used to
determine if the path is in /proc. Alternatively to ignoring
we could simply fail with `-TARGET_ENOSYS` (or similar) if
`resolve` flags are passed and we found something that looks
like a file in /proc that needs faking.

Signed-off-by: Michael Vogt <mvogt@redhat.com>

Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
---
 linux-user/qemu.h         |  4 +++
 linux-user/syscall.c      | 73 ++++++++++++++++++++++++++++++++++++---
 linux-user/syscall_defs.h |  7 ++++
 meson.build               |  1 +
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2e90a97175..47b6d7da88 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -164,6 +164,10 @@ struct TaskState {
 abi_long do_brk(abi_ulong new_brk);
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
                     int flags, mode_t mode, bool safe);
+#ifdef HAVE_OPENAT2_H
+int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                     struct target_open_how *how, bool safe);
+#endif
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz);
 
 /* user access */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d5415674d..f3a47bbfc0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -85,6 +85,12 @@
 #include <sys/kcov.h>
 #endif
 
+#ifdef HAVE_OPENAT2_H
+#include <linux/openat2.h>
+/* glibc has no header for SYS_openat2 so we need to get it via syscall.h */
+#include <sys/syscall.h>
+#endif
+
 #define termios host_termios
 #define winsize host_winsize
 #define termio host_termio
@@ -653,6 +659,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#ifdef HAVE_OPENAT2_H
+safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
+              const struct open_how *, how, size_t, size);
+#endif
 #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
@@ -8334,8 +8344,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
-                    int flags, mode_t mode, bool safe)
+static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
+                              const char *fname, int flags, mode_t mode,
+                              bool safe)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8418,13 +8429,48 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    return -1;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
+                    int flags, mode_t mode, bool safe)
+{
+    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe);
+    if (fd >= 0)
+        return fd;
+
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, path(fname), flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, path(fname), flags, mode);
     }
 }
 
+#ifdef HAVE_OPENAT2_H
+int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *fname,
+                     struct target_open_how *how, bool safe)
+{
+    /*
+     * Ideally we would pass "how->resolve" flags into this helper too but
+     * the lookup for files that need faking is based on "realpath()" so
+     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
+     * be honored right now.
+     */
+    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, how->flags, how->mode,
+                                safe);
+    if (fd >= 0)
+        return fd;
+
+    if (safe) {
+        return safe_openat2(dirfd, fname, (struct open_how *)how,
+                            sizeof(struct target_open_how));
+    } else {
+        return syscall(SYS_openat2, dirfd, fname, (struct open_hosw *)how,
+                       sizeof(struct target_open_how));
+    }
+}
+#endif
+
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
 {
     ssize_t ret;
@@ -9197,6 +9243,25 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+#if defined(TARGET_NR_openat2) && defined(HAVE_OPENAT2_H)
+    case TARGET_NR_openat2:
+        {
+            struct target_open_how how, *target_how;
+            if (!(p = lock_user_string(arg2)))
+                return -TARGET_EFAULT;
+            if (!(lock_user_struct(VERIFY_READ, target_how, arg3, 1)))
+                return -TARGET_EFAULT;
+            how.flags = target_to_host_bitmask(target_how->flags,
+                                               fcntl_flags_tbl);
+            how.mode = tswap64(target_how->mode);
+            how.resolve = tswap64(target_how->resolve);
+            ret = get_errno(do_guest_openat2(cpu_env, arg1, p, &how, true));
+            fd_trans_unregister(ret);
+            unlock_user_struct(target_how, arg3, 0);
+            unlock_user(p, arg2, 0);
+            return ret;
+        }
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..2ae694261c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,4 +2754,11 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how {
+    __u64 flags;
+    __u64 mode;
+    __u64 resolve;
+};
+
 #endif
diff --git a/meson.build b/meson.build
index fbda17c987..220ccbcbe6 100644
--- a/meson.build
+++ b/meson.build
@@ -2465,6 +2465,7 @@ config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
 config_host_data.set('CONFIG_VALGRIND_H', cc.has_header('valgrind/valgrind.h'))
 config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 config_host_data.set('HAVE_DRM_H', cc.has_header('libdrm/drm.h'))
+config_host_data.set('HAVE_OPENAT2_H', cc.has_header('linux/openat2.h'))
 config_host_data.set('HAVE_PTY_H', cc.has_header('pty.h'))
 config_host_data.set('HAVE_SYS_DISK_H', cc.has_header('sys/disk.h'))
 config_host_data.set('HAVE_SYS_IOCCOM_H', cc.has_header('sys/ioccom.h'))
-- 
2.45.2


