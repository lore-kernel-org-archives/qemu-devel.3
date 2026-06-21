Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72739CDB46B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9h1-0002xT-3g; Sun, 21 Jun 2026 00:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gz-0002wd-34
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:57 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gx-00057I-55
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:56 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69de16f5e80so1814134eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015714; x=1782620514;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqGkbUPVWpPg4nAS2t8eDn1jA6zkTv0XMfxbv5aynCc=;
 b=iVkKVJGwhUthED0CwXSnnHyMhdNvqEGL40BW/Fr79+Lm1jPJM1u0r6qF6yFBGct4Jb
 kSSuBiz/hmAfq5ldUE/vQ1zcu5J3WvU2QsfndZmzaEHpgZg2Mk0cWimFzDvss9dnuqXg
 DrjJK4pg2+VNyHHKT588MnG4c5wJySifm0hunKGMrLvatIyRfj0s27c2uaAkrfAqI9VW
 jmlUegKZ7eE4dD4ebqe6t15CqKQI3msqsZ5W2QAONFRl3EvO8RtCnWMo+erkWy1JBILR
 jh3CMTbvWMxEWSLFqGTW9qtyvYiIGuj1ja/ZgScADHJqs3ULcEl98dkb03DczArpjn4P
 Sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015714; x=1782620514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jqGkbUPVWpPg4nAS2t8eDn1jA6zkTv0XMfxbv5aynCc=;
 b=OyICmLpOjU2Nrlftd7WPwDZMFj6qKWU4doQb0qP2dPUnS0aLW7pNiZGQSMFzdt6Vbf
 WV9DmwWAnKUtrOUdER8kYg6wE68BSUJ4oxyML3/SestA8fuHMRIKfKzIoMYirjny45hO
 0pF4hM44xFMrHONAzMBiRULc12WwV/5JQTlmlJDcJRjRKH+4CggT5p38+O61g7n4IxWA
 Ve7+MKcwsyLjDP/SLDPZErjC3szqR0/IA7yjARZFJU8dG/qMAhEAyNDqOkozd9s4AJBg
 yNeb4nkQ5fxp0usOm2IAKW2Hh7Kxgjw9suvKXEKPPCqv8tSZwnv6zTzAeGyaEjp16dzu
 Es+g==
X-Gm-Message-State: AOJu0YwhtIWPV7Fbxr0Iu3qstHMo5hFOuAWXBB0oeg69PtUICFdxy2iW
 tZ6MEN6pLALgzlyqQoNKrQRpx1yTFCC3qu4Cg4jc+TiK6a4+NZ9T3Qdag1Qvlj6AlugSOPuS4tf
 XJN51rK+ecA==
X-Gm-Gg: AfdE7cmn9bN5hX7j3t7MllVqaQRM4qTE7Ass5xewM0jcVGFvSF56ybNkvaSwZSN4Em5
 +U26Jc4ldVVoMaUtKdDU88bXSS5sBFNuU9zFxpuFHywccBSsqASCCB9NqaraHNEcm143ft30Ejh
 gUJcy2hPoad6MQ9GYvIWKk0+eYvhzr33AavysFzc7+RyCavdqVwEpjQYvOswLNynIbsptBYjVKh
 Y4VjHq58Y/IVlrRZTXhnNnHoKozHgQTLQyCMDU7/+XHCEjQBKY3fIdUv/2jfY88m87GRp1WukZ9
 /47SVRYu1DQ1n4lFaUG/LahgyNRLuMw+DWtwAnUPeItY35EVAqAkrtxD4/S/uXlVBBg1mVTArV2
 KebnTWWDh1IgpUaltoRaDKJmeAilOHdUCgn4ool4BJ8mV4bMiXPvRV6C1LN5qhB4ctQg+8YhZWz
 M=
X-Received: by 2002:a05:6820:3081:b0:696:77e2:a78 with SMTP id
 006d021491bc7-6a0d88b165dmr7848733eaf.23.1782015714057; 
 Sat, 20 Jun 2026 21:21:54 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:58 -0600
Subject: [PATCH v3 11/40] bsd-user: Add bsd-socket.h with bind through
 getsockname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-11-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7162; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=J8SA0e583JfbXoF/dYpAHOqxYLUapaIlg1a5MTqLMlc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+hRlQbwI0g09mEYSHs3AdRfeynKrY9QVpX
 zk67JIPoJuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 AKGCEACLnroxZR33CrI/vm9FfjvshfgE6EEuXvVa0JUk7zg4v4132yx7gigztVe/tCdu/GI4nrk
 0+HASVr1XTzIUXQbuXJ13RPCqODxH3nK+ltcESho0Mq1b3/HWj4PBn1/62ZUMjZRYP2Sx8jD4gC
 XBqnFMW6QSSLTM7AbffQsg99hYODJ1obF7LBhoHpqDofgiEfHU+aFdqN43/ZaADVnMx4zSXTtpn
 UFwSVvRD1ZkoU07pJOFowcNFpBnZPg4bAky1GTznnkc2oOwVE2vT928CXLqpfq9z73lSW8TW62W
 Nlw3l2jhulxNWB4AtgXADCnYcxZa8OQQOvRLdvVEvBQ91DxiHwsK5zilyb4c0Rx7SXXagmggO1F
 a5TkMIXfUdpDpbUhd/KyXSqHCbWjA0iFY1nhldTQqUHCBaB5qO69z9VHNjiRAHxh+Gm3cVzPhN+
 nAY/ZwjUTdkU60yKdpf1wAUBrItejrJy65uibCwryNWZPOx+qH6KQDEnNyf3CvoLg1ooGQy5dBl
 ZcCObFZV8mwhThIngDeL6oaNri1lXjQjl+HL3kAxlVtnrr4G5QzX15mvKVKKfeAuWWYum/vQcz7
 3dkHtSfRGTk4Fa0NS3MtlFwjfid6g65z2iQewTCUFsdbLd1HfIb6C5xPzs8o2RGpUttp6cH/X9o
 0J76WWlelnGOnQA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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

Add the first set of socket system call shims: bind, connect,
accept, getpeername, and getsockname. Also add safe_syscall wrappers
for sendto, recvfrom, select, pselect, recvmsg, and sendmsg.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h         | 167 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  15 ++++
 2 files changed, 182 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
new file mode 100644
index 0000000000..c786d6717a
--- /dev/null
+++ b/bsd-user/bsd-socket.h
@@ -0,0 +1,167 @@
+/*
+ * socket related system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_SOCKET_H
+#define BSD_SOCKET_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu-bsd.h"
+
+ssize_t safe_recvfrom(int s, void *buf, size_t len, int flags,
+    struct sockaddr *restrict from, socklen_t *restrict fromlen);
+ssize_t safe_sendto(int s, const void *buf, size_t len, int flags,
+    const struct sockaddr *to, socklen_t tolen);
+int safe_select(int nfds, fd_set *readfs, fd_set *writefds, fd_set *exceptfds,
+    struct timeval *timeout);
+int safe_pselect(int nfds, fd_set *restrict readfds,
+    fd_set *restrict writefds, fd_set *restrict exceptfds,
+    const struct timespec *restrict timeout,
+    const sigset_t *restrict newsigmask);
+
+/* bind(2) */
+static inline abi_long do_bsd_bind(int sockfd, abi_ulong target_addr,
+                                   socklen_t addrlen)
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
+    return get_errno(bind(sockfd, addr, addrlen));
+}
+
+/* connect(2) */
+static inline abi_long do_bsd_connect(int sockfd, abi_ulong target_addr,
+                                      socklen_t addrlen)
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
+    return get_errno(connect(sockfd, addr, addrlen));
+}
+
+/* accept(2) */
+static inline abi_long do_bsd_accept(int fd, abi_ulong target_addr,
+                                     abi_ulong target_addrlen_addr)
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
+    ret = get_errno(accept(fd, addr, &addrlen));
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
+
+/* getpeername(2) */
+static inline abi_long do_bsd_getpeername(int fd, abi_ulong target_addr,
+                                          abi_ulong target_addrlen_addr)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EFAULT;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EFAULT;
+    }
+    addr = alloca(addrlen);
+    ret = get_errno(getpeername(fd, addr, &addrlen));
+    if (!is_error(ret)) {
+        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (is_error(ret)) {
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* getsockname(2) */
+static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
+                                          abi_ulong target_addrlen_addr)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EFAULT;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EFAULT;
+    }
+    addr = alloca(addrlen);
+
+    ret = get_errno(getsockname(fd, addr, &addrlen));
+    if (!is_error(ret)) {
+        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (is_error(ret)) {
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+#endif /* BSD_SOCKET_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 228daed4c4..737de36514 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -40,6 +40,7 @@
 #include "bsd-proc.h"
 #include "bsd-misc.h"
 #include "bsd-signal.h"
+#include "bsd-socket.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -73,6 +74,20 @@ safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
 safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
     off_t *, outoffp, size_t, len, unsigned int, flags);
 
+/* used in bsd-socket */
+safe_syscall5(int, select, int, nfds, fd_set *, readfs, fd_set *, writefds,
+    fd_set *, exceptfds, struct timeval *, timeout);
+safe_syscall6(int, pselect, int, nfds, fd_set *restrict, readfs,
+    fd_set *restrict, writefds, fd_set *restrict, exceptfds,
+    const struct timespec *restrict, timeout, const sigset_t *restrict,
+    newsigmask);
+safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len, int, flags,
+    struct sockaddr *restrict, from, socklen_t *restrict, fromlen);
+safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
+    flags, const struct sockaddr *, to, socklen_t, tolen);
+safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
+safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);

-- 
2.52.0


