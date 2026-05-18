Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAACCD4F57
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VR-0000S0-Q5; Mon, 18 May 2026 17:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VQ-0000RA-QT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:08 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VO-0000Sq-PT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:08 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dccb8644c4so1606626a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139686; x=1779744486;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ektwjMp/LzL17TfgstxC86tlwuXgCikFmtXF+htjc5I=;
 b=yp7Hwu8ee0Y4ct9FgUeYBLdUmuEK4Oiu+dh9jXJZRLCTRszpiWAMmJMRNbW9eqkjEq
 eLaEWYcCUnbr+8/2z7ObKX9hIbeKdo8Y04uZZmEyFlM5YKruktIg0uPw23lQPUO8eNQ5
 rA5d1fb8VpVHhNghmNwwdiVH8io1DcknjOA8qBr26Xw3Hdojvg3jmUnEjLoaeL9D+v+W
 zrF3ehN7CFYz2xs6lo9fUGRW/f4+gQKylSsGC4dFWyL/gYzkPsf8FEqqhvNDpbCKn+mc
 okgFVB5oMPzReVBZIVsfsvQKjWCjVLarmVtDAheENiG1EJBCRg4FO0W6X1eAVSa65+YN
 5/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139686; x=1779744486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ektwjMp/LzL17TfgstxC86tlwuXgCikFmtXF+htjc5I=;
 b=ggp94EohVrJJ1KNzDx3/zpjz1rQmp8VURDG7sulMK/49EYivtjN0DtPjBdjt/H5XOm
 BZQn8DHXgNnsDfQUPE5gGxC1ScjFC9KZS4OjTBwi06+XSwZ5mt3/VgXvYzl9VKeYr/JU
 H+KjKr3z+no8XQ0YjaAQoL1n1730S/x+9be/OapvCnV7BzkeoOSRrzI0UN3J9UFmplTU
 aJ/5YUHoZpsDBJDiH/hthc8BwL8fZYucrw3qBFfFMBt+jIDC7L/FyfwVmBVv5PVnWilV
 U+/obLLsW+eV7um70Jwqgs34kLUmum7k0vssgFgPIeRGsPKFKFbekYkpfi7CRErhnT1n
 ad1g==
X-Gm-Message-State: AOJu0YzfvNLEqDwVNCwXu1k/8zDzLvjH9diIb7Lmyje1PtHqio/zKhZ4
 hjXc8hIJFT+oosE/dXixwPoT5S5QiVQqX20Izgm+8T29SMdzgNJ4UkMjSP7EnDRxlxA=
X-Gm-Gg: Acq92OHSTWK20+Yd1iI7SVOsGbBaTYSfP9u84wi7fRHULNQSpfRhCtN/0nHyMT/Sxuc
 FMoRKgYmu10kSOBEDTnKoxjPLn+0RlwhlF70XhXve4psnronQYZRmPaZbYGnWWy6UiC/7G+RgxD
 dc/zaU8jBJWC2M7YvKywYaewIarq40V39jdJbFsqDzMLZJZ6644N7JHwe++rYWXA3xYowsNwFA2
 +DGP1i6db0BG3KyJjbzaL+F/CHKO3cm/BHuQ+seEX+08g3svN5kXm6pktQuviTtSct4edp0btBh
 HWWOxIjKhhgULyZJyNdTqC59fLzsSgFSpWLzTuUjv+4t82J/weiABW3tJmlEjGNfFi5ShWvhCVh
 D34UT8Upuva+esZYPiBBedFsWrxfe5y83dXAKoK1vox+gFvv4yIt+omq3/WC9HDVvKWJjC/ruIw
 JarKqbqY66jS/sWfF1I4p0
X-Received: by 2002:a05:6830:6312:b0:7d7:4639:43ee with SMTP id
 46e09a7af769-7e4ea071964mr12327579a34.3.1779139685724; 
 Mon, 18 May 2026 14:28:05 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:32 -0600
Subject: [PATCH v2 14/37] bsd-user: Add FreeBSD socket helpers and sockaddr
 conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-14-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7613; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZjsmeB1iV30iXnseqbtwzWbLnO3Hvy7F3LvgR6/oqVc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RHCNN/hgReJz/LeFlqJLwnJo8y/fwPImFuA
 zc6ZE4TIcOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 AIgzD/0W2gCqk61qbEzakU6EXAeazlWhlZ13o6ZgXase6/8kNf3MDOPUnaIB0YWanbYw9Ulpmeq
 jdn7GruYbunptqxiUSrzvkoRifI77tXH+0Cvv8iUdTLqS57mPYlVmjqDV8+2YeXU0lRZn3YHsdq
 wU8h46N0R3zGYaamkMdVmVEPkbHpY6dLRTwlJj407VBjnsNnOrCAiYD9ybIa7hyYfmaQANQBW3c
 9BO5I0Yz84KmMF566QLibn8CUV8gaqlLhRWgcBAoykxYUpCS5p6Idxw+iMnBfzOmxBEkP4WtNS6
 7p6PXOiFfHjQP8/6Lh7HT2w5j6DBtLPa72mYTTyMaeij7Zfz/qghq9QG91vXJyw6Fl2VChKL0zt
 kzq7rHhj/FEk62SNUIOHGkyAQr1/EE1VRoIuzFyiTj5PEvShyOmBybAQvmgW6FW5DnFID6LYvHS
 g3xvApzUX+5iWSbuu8zjbrwv/Y3g+KZC6E4BRLDeEbq3f9sMZds/Di+j0U2FHRv1wA1PbCUhk89
 1JKtKBj7W/++xr7wz5EoluG/mri3XM7QbG5CI5o14uWgc0YA9p+N9ZpVtU9A3+PUIGdMDnJbUS/
 WwNxeyHsmuKsl68FNeB/Pkob2lEPkxuUli2CsKtGeAeP80X6I+g3WzPiAuiMcVkuw+pfEKM3Y9p
 wi8MHUC4eYTLn6w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Complete os-socket.h with setfib, bindat, connectat, and accept4.
Add bsd-socket.c with target_to_host_sockaddr, host_to_target_sockaddr,
and target_to_host_ip_mreq helper functions, and add it to the build.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-socket.c        | 98 ++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-socket.h | 85 +++++++++++++++++++++++++++++++++++++-
 bsd-user/meson.build         |  1 +
 bsd-user/qemu-bsd.h          |  8 ++++
 4 files changed, 191 insertions(+), 1 deletion(-)

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
diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index f8521780c1..6ad16f73b5 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -334,7 +334,7 @@ static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
             break;
 
         case TARGET_SO_SNDLOWAT:
-            optname = SO_RCVLOWAT;
+            optname = SO_SNDLOWAT;
             break;
 
         case TARGET_SO_RCVLOWAT:
@@ -683,5 +683,88 @@ unimplemented:
     return ret;
 }
 
+/* setfib(2) */
+static inline abi_long do_freebsd_setfib(abi_long fib)
+{
+
+    return get_errno(setfib(fib));
+}
+
+/* bindat(2) */
+static inline abi_long do_freebsd_bindat(int fd, int sockfd,
+        abi_ulong target_addr, socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+
+    addr = alloca(addrlen + 1);
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(bindat(fd, sockfd, addr, addrlen));
+}
+
+/* connectat(2) */
+static inline abi_long do_freebsd_connectat(int fd, int sockfd,
+        abi_ulong target_addr, socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen);
+
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(connectat(fd, sockfd, addr, addrlen));
+}
+
+/* accept4(2) */
+static inline abi_long do_freebsd_accept4(int fd, abi_ulong target_addr,
+        abi_ulong target_addrlen_addr, int flags)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (target_addr == 0) {
+        return get_errno(accept(fd, NULL, NULL));
+    }
+    /* return EINVAL if addrlen pointer is invalid */
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EINVAL;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen);
+
+    ret = get_errno(accept4(fd, addr, &addrlen, flags));
+    if (!is_error(ret)) {
+        if (is_error(host_to_target_sockaddr(target_addr, addr, addrlen))) {
+            close(ret);
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
+            close(ret);
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
 
 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
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
index f7c8338213..b4ca8268c9 100644
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
 /* bsd-misc.c */
 abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
 

-- 
2.52.0


