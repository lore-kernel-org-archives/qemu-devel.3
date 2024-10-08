Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76193CEFC3F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJb-0007Tx-0Z; Tue, 08 Oct 2024 14:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qn-OG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJK-0002SM-32
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e0cd1f3b6so1567576b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413507; x=1729018307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nnulTAtUcmZmZfuGcf5eSLVvnbBtACxcyEvOVNzWDI=;
 b=HOWkmtFX5bWk+yQqu2HuS8tpUHsY0ETwB274GglsmoYDdncRCxTPc5Rczi6yVhATzE
 ARdxfVWmjC0za36gseFT7aB05hhXxH4r2IdvC3vnT8yjnelVxvNCXJoClLF+FxwlBpk2
 3aJDpLVBYDQhkMmj6kS4XjJ16j3EqSbyN9YQxvzeZok3F3CATnXxEYgX3B6SZQjHr+oN
 YvHrynosqkD1J1zI/ugYuBtJdd05E4xO/rOlVwUGjypwQjG3rLeFY+RaBwBWSzWYnNdc
 3JC5Y5VLS3WVmok75veLcc8KIjMfokxrmSRhodYqouW5r2Qd3MR90JtBuZelTqWRGDid
 gPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413507; x=1729018307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nnulTAtUcmZmZfuGcf5eSLVvnbBtACxcyEvOVNzWDI=;
 b=suaXGOox/eZ+P7AbiMxWlxLcD6czEmNmS/7zhkZ2qCyMdMm6V7MA6bYcwqZwSSYs1j
 XSm88zGj+VCVAvArMWikVsSU+6uTPkGWgh5ZfVr+Rlr7rNAlOcBNuHpLKP6TsT+x2bZH
 BpfdFVERe+Zpi0DsyAkxQ0bDCaqCAo3OdztDUenLx+xSxwFI6KXuWMId4eoeGC1yRJel
 55lCHHS7/WplD0zOGwou1oInQa/K0nExuK6zGPu2+9xhkZDgqtpbMlo6CkPt/23l0OPY
 Wa228rDz1pPRVIrj8FjkwSjpFDmoZVP26HHviQnd2IjNz9W3x0J1qlNeLH/fA/vXGuTz
 bUwA==
X-Gm-Message-State: AOJu0Yw4b8xD1yKVtce+dkFp1FF/d6FEQxTUr2os5iTkoOQwoVYX4QbH
 Zuo/naQGjKLR9uAsGWl54dHIdLfmnRxDDD96tf3Rm/AWCxoHAd6xGFK21voVdPK54ZKODP2MSA8
 3
X-Google-Smtp-Source: AGHT+IFwlv+FesL4xKx3xXvg2pWc9OjBahnbMv4Q85uOjJVSDUL+9da254jncGwfrBZMW4ulrxeFVA==
X-Received: by 2002:a05:6a21:1192:b0:1d8:a354:1acd with SMTP id
 adf61e73a8af0-1d8a35421f0mr141040637.25.1728413507435; 
 Tue, 08 Oct 2024 11:51:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Michael Vogt <mvogt@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 04/14] linux-user: add strace support for openat2
Date: Tue,  8 Oct 2024 11:51:31 -0700
Message-ID: <20241008185141.20057-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Michael Vogt <mvogt@redhat.com>

This commit adds support for the `openat2()` to `QEMU_STRACE`. It
will use the `openat2.h` header if available to create user
readable flags for the `resolve` argument but does not require
the header otherwise.

It also makes `copy_struct_from_user()` available via `qemu.h`
and `open_how_ver0` via `syscall_defs.h` so that strace.c can use
them.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f02d40c7751c03af885ced6dd94e4734d4be4d8f.1727795334.git.mvogt@redhat.com>
[rth: Add braces around the expanded how structure, like strace(3)]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h         |  9 ++++++++
 linux-user/syscall_defs.h |  5 +++++
 linux-user/strace.c       | 47 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      |  8 +------
 linux-user/strace.list    |  3 +++
 meson.build               |  1 +
 6 files changed, 66 insertions(+), 7 deletions(-)

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
diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..d3cdd09dc1 100644
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
@@ -3483,6 +3498,38 @@ print_openat(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_openat2
+static void
+print_openat2(CPUArchState *cpu_env, const struct syscallname *name,
+              abi_long arg0, abi_long arg1, abi_long arg2,
+              abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    struct open_how_ver0 how;
+
+    print_syscall_prologue(name);
+    print_at_dirfd(arg0, 0);
+    print_string(arg1, 0);
+
+    if ((abi_ulong)arg3 >= sizeof(struct target_open_how_ver0) &&
+        copy_struct_from_user(&how, sizeof(how), arg2, arg3) == 0) {
+        how.flags = tswap64(how.flags);
+        how.mode = tswap64(how.mode);
+        how.resolve = tswap64(how.resolve);
+        qemu_log("{");
+        print_open_flags(how.flags, 0);
+        if (how.flags & TARGET_O_CREAT) {
+            print_file_mode(how.mode, 0);
+        }
+        print_flags(openat2_resolve_flags, how.resolve, 1);
+        qemu_log("},");
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
diff --git a/meson.build b/meson.build
index 33954b3eba..4ea1984fc5 100644
--- a/meson.build
+++ b/meson.build
@@ -2481,6 +2481,7 @@ config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
 config_host_data.set('CONFIG_VALGRIND_H', cc.has_header('valgrind/valgrind.h'))
 config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 config_host_data.set('HAVE_DRM_H', cc.has_header('libdrm/drm.h'))
+config_host_data.set('HAVE_OPENAT2_H', cc.has_header('linux/openat2.h'))
 config_host_data.set('HAVE_PTY_H', cc.has_header('pty.h'))
 config_host_data.set('HAVE_SYS_DISK_H', cc.has_header('sys/disk.h'))
 config_host_data.set('HAVE_SYS_IOCCOM_H', cc.has_header('sys/ioccom.h'))
-- 
2.43.0


