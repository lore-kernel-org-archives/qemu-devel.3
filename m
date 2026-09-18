Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F8C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAH-0005Xe-Qu; Fri, 18 Sep 2026 00:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAA-0005OP-Ms
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:26 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA8-0004BE-RN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:26 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-805bf8c2661so195575a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705523; x=1790310323;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mXf54NecBcpp3yFOeaQrnJ4HXYEjqcjwL+84glJdxs4=;
 b=o9w1RQbx5w0vbAatfI46Y0CQNzOYkgNNFJeF3CLxyvncOvaEgUSgE4Dz3CMAnedWrF
 0KisojVHOq9ZTEZdyO57GOAhjYFuE4eKfK44KUgtNVf/C7wfgSGBNopMfD4FjPiRQf+g
 dnsO615QIiGmXTGRbbzdzmCV7v0PVdz/QPhEJUWSSm4Op+2KwkYBYm0xPSFbE58VvAjM
 5MjQUfzPD6ttOxzAL7tW9d0LZ7rCO4xMcPaq1W9nkYwrzBpq4rrcxQgbM9Y8pXegQwm8
 tobrsOJhjqsStOVZdO8jZEJD860uQGD9DbplL+mjZvdOtxgNQ1ghPZlrB0zOYl37smGK
 QGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705523; x=1790310323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mXf54NecBcpp3yFOeaQrnJ4HXYEjqcjwL+84glJdxs4=;
 b=ziqpqnoDmP2HkjnSLVy1gf6fDNLGKlXEeTHT+1MLQrPWPdxzUaVbkzi0aWF4itQEFq
 uhnIAMU3qEislVw+1bpqyJZHN3YQzUkbu14WuaukDRRnXNhg/xMx7z67QzGgyqll2tcO
 lJaE5DvSah0YN81LaJos7hSlbVdW464fUALJiEG5kQwg1LNUl5x8xXQy0Tec1PF8nRv+
 oc9gRHAN+KZOB44fBIX14BJm6LKjzeyv9uFghsbmkIpWb7nT6LQRl12nvVlgh8FoTqRq
 uP1ZCqRS0uxn/GPN1s0cHNtY7+10QnwNPFECXNpbtQpwUUg9DJ5OvRlHgftnKAjtvY5L
 DQyA==
X-Gm-Message-State: AFuF++mp27PYC0t71CbJ0PEe0nMcCYIyYyIbOEeZnW+c82qWNi8KB4Vb
 kqR6AwVmZP0Hdc5k5KmQKJCbnGxB8iXsgnnAi1xHR6LtcWn+e7Xaa5Sq3Vc/7s2Kz6reF/Punct
 kLPzuY3E=
X-Gm-Gg: AYBFou2dChZdQjGEB3JL7kVYQuChjAP4310hp+CRpV/b8v/3NgH7Zv7DsBDO/L03+Tp
 rlavlKM3INeYG2PN+IwOiYYNp6CtnDQukBG82rJ+bmba+Nk6UkbxDZhz8b7XKEVvI502X92mJHW
 IH/acsvVREct2LUKSyftzv15ddwzfnBCS/BGmPzhkmJIvmkawkIYqUnh1ISJlpicCUKPVcIqMEV
 ighlnIekwTVglt6Qbj/oK7b+WyVqVipzLL1PGJy9adRg5imqvNLHM8Np4YBCvnjPyoszc1vTMkg
 3Mn6fRhRfoyDMMA36uHmm8mTcEbNIwXm/Yys9w/rGxJNXVccD8eplQ5KDsG5bors+aDuEADFQpC
 yeGJ58z7zy9n7vfT4aGA4FtswlKg4+WXxTyM5P3IUnecK8YKwnujnMXGxagQXEcO7U0rFb5s7d2
 NqjSxPmv+wqARoPLW0CLmnDbSfrOOd12CKpqVjl62T+PA50NoS5qhn3KoBMg==
X-Received: by 2002:a05:6830:2644:b0:7f4:2418:7ed8 with SMTP id
 46e09a7af769-80de126cf10mr1534172a34.12.1789705523536; 
 Thu, 17 Sep 2026 21:25:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/41] bsd-user: Add FreeBSD socket helpers and sockaddr
 conversion
Date: Thu, 17 Sep 2026 22:23:55 -0600
Message-ID: <20260918042422.38713-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Add bsd-socket.c with target_to_host_sockaddr, host_to_target_sockaddr,
and target_to_host_ip_mreq helper functions, and add it to the build.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.c   | 98 +++++++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build    |  1 +
 bsd-user/qemu-bsd.h     |  8 ++++
 bsd-user/syscall_defs.h | 49 +++++++++++++++------
 4 files changed, 143 insertions(+), 13 deletions(-)
 create mode 100644 bsd-user/bsd-socket.c

diff --git a/bsd-user/bsd-socket.c b/bsd-user/bsd-socket.c
new file mode 100644
index 0000000000..cc45400e4c
--- /dev/null
+++ b/bsd-user/bsd-socket.c
@@ -0,0 +1,98 @@
+/*
+ * BSD socket system call related helpers
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * socket conversion
+ */
+abi_long target_to_host_sockaddr(struct sockaddr *addr, abi_ulong target_addr,
+                                 socklen_t len)
+{
+    const socklen_t unix_maxlen = sizeof(struct sockaddr_un);
+    sa_family_t sa_family;
+    struct target_sockaddr *target_saddr;
+
+    target_saddr = lock_user(VERIFY_READ, target_addr, len, 1);
+    if (target_saddr == 0) {
+        return -TARGET_EFAULT;
+    }
+
+    sa_family = target_saddr->sa_family;
+
+    /*
+     * Oops. The caller might send a incomplete sun_path; sun_path
+     * must be terminated by \0 (see the manual page), but unfortunately
+     * it is quite common to specify sockaddr_un length as
+     * "strlen(x->sun_path)" while it should be "strlen(...) + 1". We will
+     * fix that here if needed.
+     */
+    if (target_saddr->sa_family == AF_UNIX) {
+        if (len < unix_maxlen && len > 0) {
+            char *cp = (char *)target_saddr;
+
+            if (cp[len - 1] && !cp[len]) {
+                len++;
+            }
+        }
+        if (len > unix_maxlen) {
+            len = unix_maxlen;
+        }
+    }
+
+    memcpy(addr, target_saddr, len);
+    addr->sa_family = sa_family;        /* type uint8_t */
+    addr->sa_len = target_saddr->sa_len;    /* type uint8_t */
+    unlock_user(target_saddr, target_addr, 0);
+
+    return 0;
+}
+
+abi_long host_to_target_sockaddr(abi_ulong target_addr, struct sockaddr *addr,
+                                 socklen_t len)
+{
+    struct target_sockaddr *target_saddr;
+
+    target_saddr = lock_user(VERIFY_WRITE, target_addr, len, 0);
+    if (target_saddr == 0) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(target_saddr, addr, len);
+    target_saddr->sa_family = addr->sa_family;  /* type uint8_t */
+    target_saddr->sa_len = addr->sa_len;        /* type uint8_t */
+    unlock_user(target_saddr, target_addr, len);
+
+    return 0;
+}
+
+abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn, abi_ulong target_addr,
+                                socklen_t len)
+{
+    struct target_ip_mreqn *target_smreqn;
+
+    target_smreqn = lock_user(VERIFY_READ, target_addr, len, 1);
+    if (target_smreqn == 0) {
+        return -TARGET_EFAULT;
+    }
+    mreqn->imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
+    mreqn->imr_address.s_addr = target_smreqn->imr_address.s_addr;
+    if (len == sizeof(struct target_ip_mreqn)) {
+        mreqn->imr_ifindex = tswap32(target_smreqn->imr_ifindex);
+    }
+    unlock_user(target_smreqn, target_addr, 0);
+
+    return 0;
+}
+
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 2abcae5122..ab6ddf2e9f 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -11,6 +11,7 @@ bsd_user_ss.add(files(
   'bsd-mem.c',
   'bsd-misc.c',
   'bsd-proc.c',
+  'bsd-socket.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 756425d18e..e32a09b37c 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -32,6 +32,14 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-socket.c */
+abi_long target_to_host_sockaddr(struct sockaddr *addr, abi_ulong target_addr,
+        socklen_t len);
+abi_long host_to_target_sockaddr(abi_ulong target_addr, struct sockaddr *addr,
+        socklen_t len);
+abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn, abi_ulong target_addr,
+        socklen_t len);
+
 /* bsd-mem.c */
 void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
         struct target_ipc_perm *target_ip);
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 75122ad521..1a85ceb464 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -203,6 +203,42 @@ struct target_freebsd__wrusage {
     struct target_freebsd_rusage wru_children;
 };
 
+/*
+ * sys/socket.h
+ */
+struct target_msghdr {
+    abi_long    msg_name;       /* Socket name */
+    int32_t     msg_namelen;    /* Length of name */
+    abi_long    msg_iov;        /* Data blocks */
+    int32_t     msg_iovlen;     /* Number of blocks */
+    abi_long    msg_control;    /* Per protocol magic (eg BSD fd passing) */
+    int32_t     msg_controllen; /* Length of cmsg list */
+    int32_t     msg_flags;      /* flags on received message */
+};
+
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+struct target_in_addr {
+    uint32_t s_addr; /* big endian */
+};
+/*
+ * netinet/in.h
+ */
+struct target_ip_mreq {
+    struct target_in_addr   imr_multiaddr;
+    struct target_in_addr   imr_interface;
+};
+
+struct target_ip_mreqn {
+    struct target_in_addr   imr_multiaddr;
+    struct target_in_addr   imr_address;
+    int32_t                 imr_ifindex;
+};
+
 /*
  * sys/stat.h
  */
@@ -531,19 +567,6 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
-/*
- * sys/socket.h
- */
-struct target_sockaddr {
-    uint8_t sa_len;
-    uint8_t sa_family;
-    uint8_t sa_data[14];
-} QEMU_PACKED;
-
-struct target_in_addr {
-    uint32_t s_addr; /* big endian */
-};
-
 #define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
-- 
2.55.0


