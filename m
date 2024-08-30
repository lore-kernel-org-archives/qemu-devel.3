Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961AECA1005
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk3jj-0007CN-EE; Fri, 30 Aug 2024 11:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sk3jh-0007Bs-UB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:40:29 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sk3jf-0000gs-N2
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:40:29 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso1843093a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725032426; x=1725637226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dtWBVBnvRzXmNnNzQnWmL83+wdr3RB3HRnVZEGFSZY=;
 b=TcsTX84QeJdeuK1zHaiyXnP5j7S7NQfwbkzGAvaH3uly1gGW21GGgwhG+Im+RCncRp
 9WzieDn3jjv7jgLqqZeeo5l51F6UNzWA3SXdzll7HEVCoRSfg3krvcLpIyVkbY2bxUio
 MWSuwRlLs/mVYoJJA3Fv8VQ9UFffCb4wFO2BiGGJ3RhL/TJ5kCaCZ3Jw9NVSYFIIPBTh
 +p70hvtnM9+A/KfbkRww++Lvr7VoKTr3CMEcGPfAMtEKaz5zVHmGxy7CCaGvXA96BP/a
 c29pyoe9n7djV9gydYjrC5pmtFqugpkGy4TU1QI/s9LX+d7up8+VvWFB69YiWTzXD5Ns
 BRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725032426; x=1725637226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dtWBVBnvRzXmNnNzQnWmL83+wdr3RB3HRnVZEGFSZY=;
 b=IjRvlkhxNzKQMStvkb5OuUfWY2CFsgwOIQTIr6xHCQbErNa4c+fA4H8iWG9sHXLSxM
 8GkI+LDMmzf9pQ43oFFkMzFtsKRs0wuOfrJv5ym/kO5X8KAWy4m7WuW4Iu9Sms3eKjts
 7zvvm/LUgTA83Cvqzl1vINkW7Utd6rEptSWxjiPCuXgFfTdDSTPfgD1LBKX7Poh9XAk0
 bJmsdhJ450HiiVq8KahnPtg7U2Kxu6DdzXRVX6A/ZXDrHi6XgUHXfh7J+eg6koeDN86E
 wZXaRqkdgsKajoZfbYwuxnHA5sKDooPLUWZoiSCAm4SLmG009LiMHaxTYFu0+YFb4jBC
 HjAw==
X-Gm-Message-State: AOJu0YyODtMQVlAlx2QxAM5KvrbJlI8sUVCf40tQNyMuw/qEXqliO19n
 0crG2H6MJsThejHzBzqOksxbxZZUKH3HPg5BrJbif9Qc5oJDeK3fIpF6iV/x
X-Google-Smtp-Source: AGHT+IEiJwbwWNY04n8hqw1xkzCXrOIJ3b0QBS1OI4zT561StpIzLDnQVCuccf4W7RRcmRJUDm02Kg==
X-Received: by 2002:a17:907:97c8:b0:a71:ddb8:9394 with SMTP id
 a640c23a62f3a-a89b95694c8mr5824666b.40.1725032425317; 
 Fri, 30 Aug 2024 08:40:25 -0700 (PDT)
Received: from top.fritz.box (p4fd6b0d7.dip0.t-ipconnect.de. [79.214.176.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891964d8sm227525766b.129.2024.08.30.08.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:40:25 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v3 1/1] linux-user: add openat2 support in linux-user
Date: Fri, 30 Aug 2024 17:39:45 +0200
Message-ID: <20240830153943.5337-4-mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830153943.5337-2-mvogt@redhat.com>
References: <20240830153943.5337-2-mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=michael.vogt@gmail.com; helo=mail-ed1-x52d.google.com
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

The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
a new `copy_struct_from_user()` is usef that works the same
as the kernels version to support backwards-compatibility
for struct syscall argument.

Instead of including openat2.h we create a copy of `open_how`
as `open_how_ver0` to ensure that if the structure grows we
can log a LOG_UNIMP warning.

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
 linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d5415674d..83c944508b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -602,6 +602,34 @@ static int check_zeroed_user(abi_long addr, size_t ksize, size_t usize)
     return 1;
 }
 
+/*
+ * Copies a target struct to a host struct, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments.
+ *
+ * Similar to kernels uaccess.h:copy_struct_from_user()
+ */
+static int
+copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
+{
+    size_t size = MIN(ksize, usize);
+    size_t rest = MAX(ksize, usize) - size;
+
+    /* Deal with trailing bytes. */
+    if (usize < ksize) {
+        memset(dst + size, 0, rest);
+    } else if (usize > ksize) {
+        int ret = check_zeroed_user(src, ksize, usize);
+        if (ret <= 0) {
+            return ret ?: -TARGET_E2BIG;
+        }
+    }
+    /* Copy the interoperable parts of the struct. */
+    if (copy_from_user(dst, src, size)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
 #define safe_syscall0(type, name) \
 static type safe_##name(void) \
 { \
@@ -653,6 +681,15 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+
+struct open_how_ver0 {
+    __u64 flags;
+    __u64 mode;
+    __u64 resolve;
+};
+safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
+              const struct open_how_ver0 *, how, size_t, size)
+
 #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
@@ -8334,8 +8371,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
-                    int flags, mode_t mode, bool safe)
+static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
+                              const char *fname, int flags, mode_t mode,
+                              bool safe, bool *use_returned_fd)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8362,6 +8400,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
 #endif
         { NULL, NULL, NULL }
     };
+    *use_returned_fd = true;
 
     /* if this is a file from /proc/ filesystem, expand full name */
     proc_name = realpath(fname, NULL);
@@ -8418,13 +8457,77 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    *use_returned_fd = false;
+    return -1;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
+                    int flags, mode_t mode, bool safe)
+{
+    bool use_returned_fd;
+    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe,
+                                &use_returned_fd);
+    if (use_returned_fd) {
+        return fd;
+    }
+
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, path(fname), flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, path(fname), flags, mode);
     }
 }
 
+
+static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
+                      abi_ptr guest_pathname, abi_ptr guest_open_how,
+                      abi_long guest_size)
+{
+    struct open_how_ver0 how = {0};
+    int ret;
+
+    if (guest_size < sizeof(struct target_open_how_ver0)) {
+        return -TARGET_EINVAL;
+    }
+    ret = copy_struct_from_user(&how, sizeof(how), guest_open_how, guest_size);
+    if (ret) {
+        if (ret == -TARGET_E2BIG) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Unimplemented openat2 open_how size: %lu\n",
+                          guest_size);
+        }
+        return ret;
+    }
+    char *pathname = lock_user_string(guest_pathname);
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
+    how.flags = target_to_host_bitmask(how.flags, fcntl_flags_tbl);
+    how.mode = tswap64(how.mode);
+    how.resolve = tswap64(how.resolve);
+
+    /*
+     * Ideally we would pass "how->resolve" flags into this helper too but
+     * the lookup for files that need faking is based on "realpath()" so
+     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
+     * be honored right now.
+     */
+    bool use_returned_fd;
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
+                                true, &use_returned_fd);
+    if (use_returned_fd) {
+        return fd;
+    } else {
+        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+                                     sizeof(struct open_how_ver0)));
+    }
+
+    fd_trans_unregister(ret);
+    unlock_user(pathname, guest_pathname, 0);
+    return ret;
+}
+
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
 {
     ssize_t ret;
@@ -9197,6 +9300,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+#if defined(TARGET_NR_openat2)
+    case TARGET_NR_openat2:
+        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
+        return ret;
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..74abcb4613 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,4 +2754,11 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how_ver0 {
+    abi_ullong flags;
+    abi_ullong mode;
+    abi_ullong resolve;
+};
+
 #endif
-- 
2.45.2


