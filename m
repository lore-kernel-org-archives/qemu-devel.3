Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242E6CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxE-0001Lj-E0; Fri, 15 May 2026 17:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxC-0001IW-BY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:18 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxA-0002v7-Fv
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:18 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso279710a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880015; x=1779484815;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqhQXs5wR5nd7oLuihoRKnbMlHQOKOF3uFmYpei+6Tc=;
 b=TK16gMleam7v3q8XR85mqgDC0qFFs1Lku8DhsOeUNbfxaV7ibdpnRkba+G8E96prgs
 r39/v7tqf8uyAtaKKuKGV8alvz23wbE+Foxs9lPqW4KlXNSz8iqz9xWGjB60JvFl0poY
 0mo30B1Sh9ISf5ucyYysyOvnKv1Adj6VzoqkkfsdPUwS+byHmSq2VjGWCoNevx2o4zPm
 a7Lj1qu6stuQ9PGc10z5ALllpkIPgUSIE52VJuCsh6j9/R4ycpxGT5BhYacz09jedPel
 jlOcDcwgYQPT/La1hVhwNq+lb/Seh9MpR+ps14JjWpLchYmkXTrsnYDRTQeG/byLU9Wk
 56kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880015; x=1779484815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jqhQXs5wR5nd7oLuihoRKnbMlHQOKOF3uFmYpei+6Tc=;
 b=RrGeuzorMQtGT2HEsvQcZBC5g0+2rw9kNFfjJZZ/xoOkULu2dI2ZUnszNNNdLuQ7NZ
 8Er/daXz5j0Eodf9i8d7QbhqyGumJ+SvgZDRDIDVocrRFtRMSrs9kSxG0B28V2F/7jVc
 2lkLeTtqhB9CEt00znCnrGZGTuEQ7JWYyzg/cxIbI2dEKbUTZgKwUrbofVYE/il4YXeQ
 DuPjddY1CMA/MJE+Ku+ZsmiL38meEehYr+m9LeSbCaora4KyxAbTe7VTPp04U6Qhr99C
 JUwHmpIQazpk6S71owD4d7zWRBO8VXX3IOggxTqk1iHm2To9TxPIVI2npiDNLIs7m97D
 lWxQ==
X-Gm-Message-State: AOJu0YwH9te/Rz0OoTM7J0J14Rfibrd8YJUZ5FRbC2UADz/+NpAVeXwU
 E2Gpwk1fTnNtc2z/HdndIfhOjr5/e4yc6xjjMVM95awvxxJE7qlcXADWEfgERDAAWNY=
X-Gm-Gg: Acq92OF+qIozWgzEeSHu1cHze72le5HO5OT1jHcwErxkVtQNddMbCiULBBZFs1nJcpv
 ixmXtdEBlMfIm7uzJOoOUD007Fxkrtl1lz8Enym2rmZKiUy7Ege+l3ImWjUPgRwkEYQWp5RlJe1
 RCfF3Gba5byJrAivaezPuNDilzUEfu8So3nqQF1nz2XhxPh3WxOOStYSDT+juvwAoshXT+K770i
 zJhZnKQ024Z9isJlWqVfcYdM5t6bChZNufPbeNuJrb0HRjqiEQbRRcJs2Fzg9MFBB9M1n08ASZa
 Ls+ZwT5/F8UTvT+1s41TufycniK2280RKuD/DDHH3dNl3yLudTq3l8RPWOf/0MDs4TTMCmpre48
 PYDZKQJAh5ogiT3lXKfaaSb24LTL4CHZftTQm9kxgy39VvkpGDYh2PK/5v4FJqX5j0zTWqHVvjs
 9LVfdI6ipvOg==
X-Received: by 2002:a05:6830:70d4:20b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7e3f14c8d26mr3430889a34.9.1778880015410; 
 Fri, 15 May 2026 14:20:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:13 -0600
Subject: [PATCH 14/66] bsd-user: Add FreeBSD socket helpers and sockaddr
 conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-14-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7195; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=u/iAconNAsAY4vmVhMWqgaztouQLoWm+Rg/Z9CJihN8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43iuGsBjh/pvF2UCy5z4TNf7lV7L77PzIZYC
 MkUaIsYeL2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 AFSSD/9ts09zUufdCsetunX9e6SbA6HmpGA8+1NuByFp6R0qpiFcIsB6PbUllxzaQ1WRjrvykBV
 vpsFo/veYM5Mxt8B0HUnckJQNGOxw0HO82A0TKwgatIXLl9bEh/b+ggzHISo29TFq/tlBoyLsS3
 1bkgEvlK0YCPErclqlR4Q+7/DZEl6yPY2zkoI0C1b5Ejf0bxDDdnkwfF9xrdFrbRx5WkhG7OjFE
 XAO7Y1K98yZu/lp0Ms/JtpaonEfez3osCyw2qxtvdtNt14yA4gLlIHBBdcXbfEpzHcsHyXN8vOA
 vZsGWNm83FRWMjN2eq2UzGp6pHhnz+mWqgurYpaRt5JRBX6UrsrKnQsz0HFSXJ1rElZG7ml2mv/
 lbx5kYnjgn1k6MeItMkowKGKNpsJOemWp3aEvsV3Gb71w/ujy+va4DAKiKAJ8matNf1VnWR39UW
 5j59B21xf3qLC7AnK4IRTJRvk1Gy0iPE0MSt+HajBgctHU+ADrWFPeHbKRNy7RecSzwiORa+Axw
 WLfm/GoDbOHOqx9OPLLHzD4e7lciAF5hvb0lbKMfBJyzjDHQmjd878JaYPTucCRdPfNuRF/5dCC
 7oJP4Xt82YYGgZMcPSHBP1RulTQ6nEiK6Q7k4KtBXlFQE4WBCwjEiEkFouuKslYH+o5rpVY1DZt
 5biU6F61rRzqGwA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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
 bsd-user/freebsd/os-socket.h | 80 ++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build         |  1 +
 bsd-user/qemu-bsd.h          |  8 ++++
 4 files changed, 187 insertions(+)

diff --git a/bsd-user/bsd-socket.c b/bsd-user/bsd-socket.c
new file mode 100644
index 0000000000..5c85131202
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
+        mreqn->imr_ifindex = tswapal(target_smreqn->imr_ifindex);
+    }
+    unlock_user(target_smreqn, target_addr, 0);
+
+    return 0;
+}
+
diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index cd85d9be8c..05c22f2f0c 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -680,5 +680,85 @@ unimplemented:
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
+        host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (put_user_u32(addrlen, target_addrlen_addr)) {
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


