Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D4CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 19:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssoyO-0003rQ-OO; Mon, 23 Sep 2024 15:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1ssoyI-0003gp-Jf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 15:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1ssoyE-0004gC-32
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 15:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727120619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecWaXekbrVUlTdRG8ryViTYiagUXZMDutSRETePNj/g=;
 b=QE51vouQVTVHAPt2wZ6ly7vrBU320mEuSzBLhPvs34yWOc1/R8DRLryvrXxgcTr8lE4r7d
 EuljpJ1ZkbANob6zkNo2phjMdMXnk3gLB4W2LRXgIt8yNxMZRYI/UwKq5seFNHgon+zJ3+
 1Gv43efjV2UTQcmDkx5BpxApcq+wdWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-EAUOEgk_O8C2zZhztGocJQ-1; Mon, 23 Sep 2024 15:43:36 -0400
X-MC-Unique: EAUOEgk_O8C2zZhztGocJQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a8d1a00e0beso564237366b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 12:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727120615; x=1727725415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecWaXekbrVUlTdRG8ryViTYiagUXZMDutSRETePNj/g=;
 b=eCMjQi/0l15WOZm0U7SOrYFw9uLCAym/Qs3XZgVHCQcjcsj/1223nnKik8qZ+BKnaL
 QOlWsGsMpkYNwHvVAdYI/BNink9PwbzP1joifHAbN1NyxAKAWyhCqKbq1OYrgWF1TQ/k
 KMTnpRx7t29e8k6njO3MMB+RweE87NDZCAHw8TXOOHm5/q7JXp035ukeF/iWJ0lme9Np
 QSPDBOBv6QTLVt4TZudM/CkEKYK5uYyvNt3ICCgTRlVbrYqsWlzob+yXR0W/AG+V/tur
 j+JTS9IvI0Z0B5mSothe4ujx3tk/4sRyJoqdVsoRcIsHAaX39h0EF+ZQCt3Z2u2YsJ5V
 uFOQ==
X-Gm-Message-State: AOJu0YzcZeym7BkwXBsW5ppQ1QJPniilzTVLzH3s+0LxnnpC1pv6EAxY
 d/9jzchNVImUgHqofQ//UDv86Ok5z5wcFrNiJavvwqYack2BG51QwIOQwDdc7eaNuDk6S+AELDU
 DCNTInRH1yYU1pULFtpZk3nP++7TIoU44gFzDVSE26EzJ330UJxQUREsRTM4oZe4EhtOmx0cre7
 G+yViJ1MqAxaPD/LGURuFbGqI2cUFyqKjh
X-Received: by 2002:a17:907:7216:b0:a8b:58e3:ac1f with SMTP id
 a640c23a62f3a-a92c482d174mr87526166b.12.1727120615064; 
 Mon, 23 Sep 2024 12:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFkh/Ls3/MnZ+e/gvJ21AF6HCF9DcR6VmC3o8BcUjg2y71WVpq8aiw8ThVrO/QBFBNL0vulA==
X-Received: by 2002:a17:907:7216:b0:a8b:58e3:ac1f with SMTP id
 a640c23a62f3a-a92c482d174mr87523266b.12.1727120614620; 
 Mon, 23 Sep 2024 12:43:34 -0700 (PDT)
Received: from top.fritz.box (p4fd6b76f.dip0.t-ipconnect.de. [79.214.183.111])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df5cfsm1289084366b.146.2024.09.23.12.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 12:43:32 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v7 2/2] linux-user: add strace support for openat2
Date: Mon, 23 Sep 2024 21:37:50 +0200
Message-ID: <dba054de9c2285aa0908cae22ede2c082ed5af7c.1727119903.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727119903.git.mvogt@redhat.com>
References: <cover.1727119903.git.mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvogt@redhat.com;
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
 linux-user/qemu.h         |  9 +++++++++
 linux-user/strace.c       | 40 +++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list    |  3 +++
 linux-user/syscall.c      |  8 +-------
 linux-user/syscall_defs.h |  5 +++++
 meson.build               |  1 +
 6 files changed, 59 insertions(+), 7 deletions(-)

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
index b4d1098170..77d5108e5d 100644
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
@@ -3483,6 +3498,31 @@ print_openat(CPUArchState *cpu_env, const struct syscallname *name,
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
+        print_open_flags(how.flags, 0);
+        if (how.flags & TARGET_O_CREAT) {
+            print_file_mode(how.mode, 0);
+        }
+        print_flags(openat2_resolve_flags, how.resolve, 0);
+    } else {
+        print_pointer(arg2, 0);
+    }
+    print_raw_param("size=" TARGET_ABI_FMT_lu, arg3, 1);
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
index 8c5d68ef85..b7a0ee67cd 100644
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
index 9a2f2ef8f7..4eea4039c3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,6 +2754,11 @@ struct target_sched_param {
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


