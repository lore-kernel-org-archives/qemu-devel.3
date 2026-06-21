Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C419CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hE-0002zO-Jy; Sun, 21 Jun 2026 00:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h7-0002yV-6y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:05 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h5-0005CA-9n
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:04 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69de16f5f79so1792932eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015722; x=1782620522;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5AEqQNr8VLxyEg30sVvmd/ilyg9Zn0MVds35QNF1zw4=;
 b=UUc3tRZ0NQpoHCX7/IwCmw/+dGGjm+y1/83f92/Sn6VBcwcZa21hU7LXUOHz7D0jd+
 qna9BHaFL8ud0HJcPiXvzNz2sqonkJYIc+7ts9YO2Wm8ZdsatVXOQX2pHW9lbDtOfBCB
 0gyMsJWw0SRVBS8yBuyr0URBZoyjLzT6tHLlCOedEPEOjB1MOkS04ZVFozVTSQMtm6B7
 NmgcNNVJWpxfcWgpqdhrOm/4sxMc6UhO10ZLxjkXUUdy7S+jCwRjOMAFSRlsTEbR8RFC
 kAXX+okXY1IUM94L1pKRV5T1Oq6UYhHtL7oyqdmX+xVljWzCoFfZ640B8CltgGSHnl0L
 q9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015722; x=1782620522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5AEqQNr8VLxyEg30sVvmd/ilyg9Zn0MVds35QNF1zw4=;
 b=l2RrTBIlwpGgfirtpStp9N9O84ww2GLCJcGssdfNmgsmSukVcchaWhgQIDQOfss0Y+
 BSRtQtHmGeVAeu2NQhqCrZdmVfHlhl8ilZUip8nwOevEyYIu3f6E12wgG0LpjRLyPS0Y
 OFBeQiHt4eVaLoLNyg16BzSNLSSUGdjc9QzKFLmfr6GMjyFRr3Wb/0Rvj1WPa0ARYAj2
 qTPIUEqGZtgV9MHv8Zc7tQmZOFi8JnBwzQ/LdFu49v4ap4Up6U+H9MUV8U+b8tYmE8tP
 lqVAnVDCedQ0dv6o28trn0FCRaMXJCERqtYSeUwcJS7ojwSunNdYxPV54FzC8An4s3ql
 9cYg==
X-Gm-Message-State: AOJu0YxFogDiUKIzFgVFTcJJ7IwmGMGr0tdUJx3LAfza0E4/azjT83Hy
 761yG12ZFMTYc94FbOkIJfdLUG+7tsyNP4YQ9O4LcucjW2sxx2vzp3sa7DkUjNFscq0=
X-Gm-Gg: AfdE7cnlKnY8Mns/nNHbrvOrGiTP2q7io7EntNVPTEx5JhmUG+g+eko3KrnaAnoEmOX
 Bx4iJE0PyQ5f8agTNAAuJOsHQ922U97lkJ11I5QoKUZXlCxt8gfvgpmGcdOGy4Up5cdCOJaPJBj
 krM14E2TgA7wiXruRkvMbiDt5qf5ruV0ri4mWfIfoFl+8NSVxUSP+ttqxnlManZ86VGtoHXGtnN
 3+0IJdPm+Ljb7coYXaW9Ust3nzgpV4mDmQbcSbW8IAntRZ2D1qvcVzRqbehL4WKIPFTxVMCni5m
 NvcQ+7aMt5AAmWmeJcjLTmg2+v/gcBYLCD5UySJq6DtZNuZfTowJ/TUUEmUHHJZqxPAj4qXLDNZ
 ysHVsStXsbVeG2YLzmPWkYGKTOfVcJAem1ZiprIUTO6cDBnuengbBM9vWrWLVb5Be6zoQnE/v6h
 M=
X-Received: by 2002:a05:6820:4dfa:b0:6a0:b186:2bd3 with SMTP id
 006d021491bc7-6a0ddedf035mr6636387eaf.12.1782015722046; 
 Sat, 20 Jun 2026 21:22:02 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:01 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:03 -0600
Subject: [PATCH v3 16/40] bsd-user: Add FreeBSD socket helpers and sockaddr
 conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-16-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7369; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lFg4vCIs68uCUNNZmKVN2eYOr/5K1QflLLCgwRfYb3I=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+6E6h6nlMVdUw48XnjlhG7Fk5arnfsLjh3
 Zrg9YKhaI6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 ALo3EADKAYCUSt/tXgmMWEZfOHmPO6y1AT9/zFCm4T+o002CLUyyW6pwzupd7NlikH5W50ggjt2
 V8celQ9LYpbBC6rwdqTYcqQ622JV5VQk5yuWw6lZn5ZmtlpUg0vdmnC/Nr1RBGpE6yUkMNmj1yk
 mptzhJBkOAAunrDzhtqRBGiQUSzvQjrCh6yBY6dIl8SD5sT6QIVJKAmy2PNHvXykVvPCEh9Y3Hq
 FPTpLYVJrbazU1o73nDBcLrunyCKDa2dgw3tR6d0ndWUhakdog2u37bWmtWrfWWIhTq8vR8Qu+d
 aW5XfSIKX0XzpFGxInE721WhkhuPgLnsCHcQ/iw6wH4Kq3BBvDZV/GSjLl6t1XgwtDw8uweWNRg
 gUF2x+jExq33Lit9BtDrZKavjK8fUaMjaKwXsx7q34wbJyTFSY2/EiSy+pWtx+dmmMWPck11uEz
 xHsrcey+WpYuUMm3VkVMhMPBXNJ9pifpN+Roey/OYsr5safdq4Y++EwEhSyH4FQNv/NCq/pA+80
 3h8rTqChc/+9I/VuaLY5Wb6Dz9p5mHHss3ZrRUiDhawb9G79sErik5XKvKDG2w8LPkvH7jfWpQS
 a1axJzcy6kFF9skkeO4q3hZTJf98Jge/wN5goAgP7YumnebFo1FLVMWU/st8ZySvemqRdyyIDeT
 2/1j9NvprVVkNvg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.c        | 98 ++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-socket.h | 83 +++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build         |  1 +
 bsd-user/qemu-bsd.h          |  8 ++++
 4 files changed, 190 insertions(+)

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
index 30d62ebaf1..0b41e87b68 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -337,5 +337,88 @@ done:
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
+    addr = alloca(addrlen + 1);
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
index cdd27b44b4..253e32500e 100644
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


