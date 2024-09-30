Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41908CE8375
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 17:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJsn-0006uX-AB; Mon, 30 Sep 2024 13:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsh-0006sC-K6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsc-0001Cp-PN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727716092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gMF25+OQ76L5kMFSaQJWClmZBFiY84FfTl382gIXGg=;
 b=YbsRbmBGITRYTD+kRglGx1oo2Dp2rj7KI9jsJ/EPDTpOSveyhM7GzUdG6/LrtHzooqO3+s
 3bp60IzcRXScGYR7RdyT157tfITx8rsKLQNoSZdViWz8pb8Zrs3o66nSSOoMvRLdml/2+p
 JgIO7aYJCa5D8Za9MauLQqgZGeijfxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-HsYOZA7iMkuI99KTcA2O0Q-1; Mon, 30 Sep 2024 13:08:11 -0400
X-MC-Unique: HsYOZA7iMkuI99KTcA2O0Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb6dc3365so35989175e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 10:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727716089; x=1728320889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gMF25+OQ76L5kMFSaQJWClmZBFiY84FfTl382gIXGg=;
 b=LxmLoRLx/sw7FEicmMp/bM/fZAM30zuBUQGsp33hn4j6L9KiV68fwOp7wgLFZRIelJ
 j8SQ3dO3Zmo+5k+7nyA2oTZ2dblJFXBvbW6jXHzSQZK1cMtetzNqsv+aF2kTGQcbXe8d
 MjvAosdpCWvyMVoQsWAHvB8ypChCdqqsLkjSs+h9fOuqU5ew8VLXYHsnoHR6qUmzcbQ6
 LGUpWeP8hTOL8CI5sE37TviA4bhMs3EXPUKh0HVqZn4n9wWPf3fxfd7aXCCvcW8Tphx0
 6aQmf83wdj4WTN1ApHB8leRyvHF32YUaK0TZph7muySF85imthZsebO0VTcsphuubiLx
 XuEg==
X-Gm-Message-State: AOJu0YxFFbnvOreJWEkwCN16U+c3X13hbyPw+oARlrX0Y6VQDswfXXGl
 dAEKVKn/9C+MEx6bMTXjlmmcQGMPRoPc853U1qLcSDRmwscWG7mXIxWnqyXRU8vuuShWZyDWCEY
 FV34QZm37mUKrG+sHJHFNE/FXDc+xHUncww9lcMgRt0iWB/lGS7bwzmNokClr99T0IPAzJPy1iX
 KNXt8a2AowjhB8MiO7ZqmkhMN2sWQ5GTfH
X-Received: by 2002:adf:e589:0:b0:37c:d183:abd6 with SMTP id
 ffacd0b85a97d-37cd5a9a255mr6178283f8f.32.1727716089343; 
 Mon, 30 Sep 2024 10:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDYxRbGGYxiVQ0XxAulD2olEwWFTDQT5EDwOvgXHoxtOPUm4U9YZsKyhSk65cdjyYe5bknzQ==
X-Received: by 2002:adf:e589:0:b0:37c:d183:abd6 with SMTP id
 ffacd0b85a97d-37cd5a9a255mr6178259f8f.32.1727716088798; 
 Mon, 30 Sep 2024 10:08:08 -0700 (PDT)
Received: from top.fritz.box (p4fdf9fd8.dip0.t-ipconnect.de. [79.223.159.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36251sm156842415e9.37.2024.09.30.10.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 10:08:08 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v8 2/2] linux-user: add strace support for openat2
Date: Mon, 30 Sep 2024 19:07:19 +0200
Message-ID: <4e65ab27fa0eda54034299802cb176ce78db9091.1727715697.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727715697.git.mvogt@redhat.com>
References: <cover.1727715697.git.mvogt@redhat.com>
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
index b4d1098170..42a34e599d 100644
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


