Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D3CE835D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 17:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJsp-0006wj-9g; Mon, 30 Sep 2024 13:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsl-0006sz-KQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsg-0001Cn-6q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727716092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KRiyw0at5DGRgBVyJeLHnY8AwyrMo6ngg550Y6llmjo=;
 b=dwfPm7WEJs7WnzG8AsMcJ1llr7zkeiakTTKf6BoF5x9yOs6v/VZrKyVF1pJADwwXXunT61
 8YW0HT5882/HxAO45YG1VzNIYZXMQ+9flIJYyD/Vx/NioWrnwPOa33m40SdXEQkVk6oHPL
 rH5CvvPK74a1/0TdIUIQR6YDG7WhEus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-G1IVGgumNZu7_gkzPcgcxw-1; Mon, 30 Sep 2024 13:08:10 -0400
X-MC-Unique: G1IVGgumNZu7_gkzPcgcxw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8cso25986975e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 10:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727716089; x=1728320889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRiyw0at5DGRgBVyJeLHnY8AwyrMo6ngg550Y6llmjo=;
 b=pzI5sgrTZKiQs2DNt2wLpjrb7q4/b2OTjExwK4EGjntrThtgNMgrRpN8ewSRx7iur/
 0yc1+hKkWlXl196DSKOa3LrYQ8g3skQHfbg8NmjmEfZ22509mkOEM/ZvnXqSeKCHq+0j
 DUZ32KITiwzjmXH+uGYtlYT9WuoLweeaWPEkNBIDlKQ384LQalbh4FtYwxChxxCtBiMU
 ZxXvkUdCCBi4BnyhCmViNw4ccjGQF5mLO2dx/m6IseB9LQqS/thoGqud5IIiTPP1P/6I
 Gvnjb9XlfyGmgzQf4VTs2eliLdkFhq0Rl6PnoMW/Qv9d+rVuvLj65o6lfj6kuTNKW6eh
 a1WQ==
X-Gm-Message-State: AOJu0YyYLQ+sHn2y7QZFU1OPySzby4qPsCIGG2xjpzd4nzy7PXBSk9jQ
 Zqjcb7kVorAazjPdhpmbdzAxIenL5K98ge85Ej6LuxPEVdidt1Ek9yPWwJiR5VmmtxC5j6g6FBD
 Jx+tWNr9Op+nkgV5YAGDsJ5mZKX+LLW5hveYmVgUxyXpoXGf7Jw97hRS+7vDGQceaiRMYw2MD0w
 n0Z50aysCok1L/Zb1MjQ20euofmo7KgNWQ
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-42f58434112mr102934285e9.10.1727716088588; 
 Mon, 30 Sep 2024 10:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq69dp95nNBHahJdCCcXf1JlB73PN7Y1Vw+9/UNeDGgUzD9nqwu8hZOHluIzmSkBz8ohWLDg==
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-42f58434112mr102933915e9.10.1727716087999; 
 Mon, 30 Sep 2024 10:08:07 -0700 (PDT)
Received: from top.fritz.box (p4fdf9fd8.dip0.t-ipconnect.de. [79.223.159.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36251sm156842415e9.37.2024.09.30.10.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 10:08:07 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v8 1/2] linux-user: add openat2 support in linux-user
Date: Mon, 30 Sep 2024 19:07:18 +0200
Message-ID: <1c2c8c9db3731ed4c6fd9b10c63637c3e4caf8f5.1727715697.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727715697.git.mvogt@redhat.com>
References: <cover.1727715697.git.mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
new `do_guest_openat2()`. Unfortunately we cannot just make
do_guest_openat2() a superset of do_guest_openat() because the
openat2() syscall is stricter with the argument checking and
will return an error for invalid flags or mode combinations (which
open()/openat() will ignore).

The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
a new `copy_struct_from_user()` is used that works the same
as the kernels version to support backwards-compatibility
for struct syscall argument.

Instead of including openat2.h we create a copy of `open_how`
as `open_how_ver0` to ensure that if the structure grows we
can log a LOG_UNIMP warning.

Note that in this commit using openat2() for a "faked" file in
/proc will honor the "resolve" flags for
RESOLVE_NO_{MAGIC,SYM}LINKS for path based access to /proc/self/exe
(which is the only magic link we support for faked files).
Note it will not catch special access via e.g. dirfd. This is not
great but it seems similar to the exiting behavior when openat()
is called with a dirfd to "/proc". Here too the fake file lookup
may not catch the special file because no dirfd is used to
determine if the path is in /proc.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
---
 linux-user/syscall.c      | 105 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  13 +++++
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a666986189..2febc3bc3f 100644
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
@@ -8332,8 +8369,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
-                    int flags, mode_t mode, bool safe)
+static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
+                              const char *fname, int flags, mode_t mode,
+                              int openat2_resolve, bool safe)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8370,6 +8408,12 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 
     if (is_proc_myself(pathname, "exe")) {
+        /* Honor openat2 resolve flags */
+        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
+            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
+            errno = ELOOP;
+            return -1;
+        }
         if (safe) {
             return safe_openat(dirfd, exec_path, flags, mode);
         } else {
@@ -8416,6 +8460,17 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    return -2;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode, bool safe)
+{
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mode, 0, safe);
+    if (fd > -2) {
+        return fd;
+    }
+
     if (safe) {
         return safe_openat(dirfd, path(pathname), flags, mode);
     } else {
@@ -8423,6 +8478,49 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
     }
 }
 
+
+static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
+                      abi_ptr guest_pathname, abi_ptr guest_open_how,
+                      abi_ulong guest_size)
+{
+    struct open_how_ver0 how = {0};
+    char *pathname;
+    int ret;
+
+    if (guest_size < sizeof(struct target_open_how_ver0)) {
+        return -TARGET_EINVAL;
+    }
+    ret = copy_struct_from_user(&how, sizeof(how), guest_open_how, guest_size);
+    if (ret) {
+        if (ret == -TARGET_E2BIG) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Unimplemented openat2 open_how size: "
+                          TARGET_ABI_FMT_lu "\n", guest_size);
+        }
+        return ret;
+    }
+    pathname = lock_user_string(guest_pathname);
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
+    how.flags = target_to_host_bitmask(tswap64(how.flags), fcntl_flags_tbl);
+    how.mode = tswap64(how.mode);
+    how.resolve = tswap64(how.resolve);
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
+                                how.resolve, true);
+    if (fd > -2) {
+        ret = get_errno(fd);
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
@@ -9195,6 +9293,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+    case TARGET_NR_openat2:
+        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
+        return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e08d088740..de5091c977 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2748,4 +2748,17 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how_ver0 {
+    abi_ullong flags;
+    abi_ullong mode;
+    abi_ullong resolve;
+};
+#ifndef RESOLVE_NO_MAGICLINKS
+#define RESOLVE_NO_MAGICLINKS   0x02
+#endif
+#ifndef RESOLVE_NO_SYMLINKS
+#define RESOLVE_NO_SYMLINKS     0x04
+#endif
+
 #endif
-- 
2.45.2


