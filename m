Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B9CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveam-0005rj-Mt; Tue, 01 Oct 2024 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sveaj-0005pC-Qe
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1sveah-000317-Gd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727795706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+DDLwciT2U9s6YaMw5ad3NppqiC8fN15Iiq9AYSzTQ=;
 b=a6ybsV6WBzMtvCVCbljUy9IuOy3oLkTwaGbaAbwnlLYhDTaSQ094EnRUXqWkUtAnPSnG9n
 1S23fIU9Bc4bxg7XxTACT5xA4n2kd7lAMKA8n1BvbqHb5nkkLcrskx9HIYH62qjg9HB9XW
 8MohYvUNROfjj0A6SY8WtJMbtjYBV0w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-dmHBveO6NWi2hGNacavDvA-1; Tue, 01 Oct 2024 11:15:05 -0400
X-MC-Unique: dmHBveO6NWi2hGNacavDvA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8711c48990so464977266b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795704; x=1728400504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+DDLwciT2U9s6YaMw5ad3NppqiC8fN15Iiq9AYSzTQ=;
 b=pgAOftfJFnZxKBy4S9/S9+aiCKw5jyzX3M1w3e72oRIsyxzdiA5ze4NJncu+UacDwp
 D8r+4sbk0Smh+9YRsjvlTIupP9+9LlgQXDrw+F35kcKX5va8V2hLZK0HSkdF/Hs5pUOY
 1pjJGlLSfhywfQ0sUKzQEE/7c58U9xYkjjUcv7+JOFm3yYF9OAE84ldGHTK9V+bEZp+N
 ogloHIpJf/RKo212Hr03HdOe6OKBiB6HOH2cNypJYh6SnBuMM+BuwhMdlWvWQ5zGIOBF
 vqTgZpKGm/I8dJ1XIO8BG6d1oMoJPfX7gPLpq8uXf3VF6QcRJnHqU8MrMUxOxtBi6zRW
 dy9Q==
X-Gm-Message-State: AOJu0YyYS50SvntzM39vDt+3UtGRHevnZjCCuR9xyDGJbC5MQYEK2GgK
 YjcDDQMFbuciNlGZF1lYH+8NJGN/Qaqp+kvAf4w/H0RLEQsWTMjTSv9K9UmtJSyuxqH2oHEwx5S
 t3yJLQ170QYS2j6q0VlmMZj73mIzEv2hSJ5ChgvuSDuKHKLbidGZNaw+GC+l+3Jtu8hXEdgg7DD
 oyMsuiOALBTJ6uB5+Y4x8k+WzK/0EWEuQS
X-Received: by 2002:a17:907:74b:b0:a8a:53fb:d571 with SMTP id
 a640c23a62f3a-a93c48e8009mr1917857366b.11.1727795704152; 
 Tue, 01 Oct 2024 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3AtHV0UP/RLGc9t6tkda11KoxmLU0QNbSKwZB2U4GzkdAXVsq7RFsI8zdkWXlTBkJ8rDq6A==
X-Received: by 2002:a17:907:74b:b0:a8a:53fb:d571 with SMTP id
 a640c23a62f3a-a93c48e8009mr1917853766b.11.1727795703683; 
 Tue, 01 Oct 2024 08:15:03 -0700 (PDT)
Received: from top.fritz.box (p4fdf9fd8.dip0.t-ipconnect.de. [79.223.159.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775d23sm732438166b.4.2024.10.01.08.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:15:03 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v9 2/2] linux-user: add strace support for openat2
Date: Tue,  1 Oct 2024 17:14:54 +0200
Message-ID: <f02d40c7751c03af885ced6dd94e4734d4be4d8f.1727795334.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727795334.git.mvogt@redhat.com>
References: <cover.1727795334.git.mvogt@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This commit adds support for the `openat2()` to `QEMU_STRACE`. It
will use the `openat2.h` header if available to create user
readable flags for the `resolve` argument but does not require
the header otherwise.

It also makes `copy_struct_from_user()` available via `qemu.h`
and `open_how_ver0` via `syscall_defs.h` so that strace.c can use
them.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
---
 linux-user/qemu.h         |  9 ++++++++
 linux-user/strace.c       | 44 +++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list    |  3 +++
 linux-user/syscall.c      |  8 +------
 linux-user/syscall_defs.h |  5 +++++
 meson.build               |  1 +
 6 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2e90a97175..98ad848ab2 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -313,6 +313,15 @@ static inline bool access_ok(CPUState *cpu, int type,
 int copy_from_user(void *hptr, abi_ulong gaddr, ssize_t len);
 int copy_to_user(abi_ulong gaddr, void *hptr, ssize_t len);
 
+/*
+ * copy_struct_from_user() copies a target struct to a host struct, in
+ * a way that guarantees backwards-compatibility for struct syscall
+ * arguments.
+ *
+ * Similar to kernels uaccess.h:copy_struct_from_user()
+ */
+int copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize);
+
 /* Functions for accessing guest memory.  The tget and tput functions
    read/write single values, byteswapping as necessary.  The lock_user function
    gets a pointer to a contiguous area of guest memory, but does not perform
diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..350cb707e4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -13,6 +13,9 @@
 #include <linux/if_packet.h>
 #include <linux/in6.h>
 #include <linux/netlink.h>
+#ifdef HAVE_OPENAT2_H
+#include <linux/openat2.h>
+#endif
 #include <sched.h>
 #include "qemu.h"
 #include "user-internals.h"
@@ -1063,6 +1066,18 @@ UNUSED static const struct flags open_flags[] = {
     FLAG_END,
 };
 
+UNUSED static const struct flags openat2_resolve_flags[] = {
+#ifdef HAVE_OPENAT2_H
+    FLAG_GENERIC(RESOLVE_NO_XDEV),
+    FLAG_GENERIC(RESOLVE_NO_MAGICLINKS),
+    FLAG_GENERIC(RESOLVE_NO_SYMLINKS),
+    FLAG_GENERIC(RESOLVE_BENEATH),
+    FLAG_GENERIC(RESOLVE_IN_ROOT),
+    FLAG_GENERIC(RESOLVE_CACHED),
+#endif
+    FLAG_END,
+};
+
 UNUSED static const struct flags mount_flags[] = {
 #ifdef MS_BIND
     FLAG_GENERIC(MS_BIND),
@@ -3483,6 +3498,35 @@ print_openat(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_openat2
+static void
+print_openat2(CPUArchState *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    struct open_how_ver0 how = {0};
+
+    print_syscall_prologue(name);
+    print_at_dirfd(arg0, 0);
+    print_string(arg1, 0);
+    if (copy_struct_from_user(&how, sizeof(how), arg2, arg3) == 0) {
+        how.flags = tswap64(how.flags);
+        how.mode = tswap64(how.mode);
+        how.resolve = tswap64(how.resolve);
+
+        print_open_flags(how.flags, 0);
+        if (how.flags & TARGET_O_CREAT) {
+            print_file_mode(how.mode, 0);
+        }
+        print_flags(openat2_resolve_flags, how.resolve, 0);
+    } else {
+        print_pointer(arg2, 0);
+    }
+    print_raw_param(TARGET_ABI_FMT_lu, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_pidfd_send_signal
 static void
 print_pidfd_send_signal(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index dfd4237d14..ef658224fc 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -715,6 +715,9 @@
 #ifdef TARGET_NR_openat
 { TARGET_NR_openat, "openat" , NULL, print_openat, NULL },
 #endif
+#ifdef TARGET_NR_openat2
+{ TARGET_NR_openat2, "openat2" , NULL, print_openat2, NULL },
+#endif
 #ifdef TARGET_NR_osf_adjtime
 { TARGET_NR_osf_adjtime, "osf_adjtime" , NULL, NULL, NULL },
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2febc3bc3f..1354e75694 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -608,8 +608,7 @@ static int check_zeroed_user(abi_long addr, size_t ksize, size_t usize)
  *
  * Similar to kernels uaccess.h:copy_struct_from_user()
  */
-static int
-copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
+int copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
 {
     size_t size = MIN(ksize, usize);
     size_t rest = MAX(ksize, usize) - size;
@@ -682,11 +681,6 @@ safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
 
-struct open_how_ver0 {
-    __u64 flags;
-    __u64 mode;
-    __u64 resolve;
-};
 safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
               const struct open_how_ver0 *, how, size_t, size)
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index de5091c977..0ade83745e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2749,6 +2749,11 @@ struct target_sched_param {
 };
 
 /* from kernel's include/uapi/linux/openat2.h */
+struct open_how_ver0 {
+    __u64 flags;
+    __u64 mode;
+    __u64 resolve;
+};
 struct target_open_how_ver0 {
     abi_ullong flags;
     abi_ullong mode;
diff --git a/meson.build b/meson.build
index 10464466ff..77cb5c41d8 100644
--- a/meson.build
+++ b/meson.build
@@ -2488,6 +2488,7 @@ config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
 config_host_data.set('CONFIG_VALGRIND_H', cc.has_header('valgrind/valgrind.h'))
 config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 config_host_data.set('HAVE_DRM_H', cc.has_header('libdrm/drm.h'))
+config_host_data.set('HAVE_OPENAT2_H', cc.has_header('linux/openat2.h'))
 config_host_data.set('HAVE_PTY_H', cc.has_header('pty.h'))
 config_host_data.set('HAVE_SYS_DISK_H', cc.has_header('sys/disk.h'))
 config_host_data.set('HAVE_SYS_IOCCOM_H', cc.has_header('sys/ioccom.h'))
-- 
2.45.2


