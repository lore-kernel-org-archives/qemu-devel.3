Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C397FCD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9h9-0002yv-5N; Sun, 21 Jun 2026 00:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h3-0002xv-EL
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:02 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h0-00059q-O1
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:00 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a0c604b9cfso2769527eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015717; x=1782620517;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NuDX3suEuhBni2TeqRPLYDKb+hwQ5H67fcr+5rGTXPQ=;
 b=BKOraGLr25XRL/+8bf5gwxRYTkz7cK0bFDposYELHtLvtVLg6Q+bld4kzro05fMH93
 dkA24tnQWvvFYs7k65HBRAQRLBEwUoR9uH09ip47z2ZbuBB1lGgcs8PQvEY5C+imy6CD
 8azO2yyRogiNPtXEzyVERgjFGcMd4W3SsWua+IwsD9Gt0sXPcmIGGBThUGuexyd1qvAF
 6cp9rla8rO2sh193KEBk9yO69xKI7Cy7esv3cL8imtLru2FCPUlScd27syVacrcBgYT4
 cXGbUEVnKUQEroA0Qm4yBvWkCHsMD/7fr3YDDTztOWOSn6hQAaUFdtCM4aNuDkdfK5JY
 MmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015717; x=1782620517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NuDX3suEuhBni2TeqRPLYDKb+hwQ5H67fcr+5rGTXPQ=;
 b=WVSdvcG9KZn7JpJRxBX5y+4nG/JeQVe/Tt0wV4H1oHgfqaY4GvFdnJyGvOxvt0jo1n
 px3UstS7AHWK/WZ5nyIdqQCnsJO8anjJJR9BprK/8zGQWL+I3ACh7HLhxFABDBn8To8u
 4xQ5v2N6CaDnqiA3ZD8hGKcTj6tpfqbh3MkXoxSf3q8pynAgAT/UARbv65BTyJaq7kHv
 WcnuRFF0+X1GRBccb+pi6S7+ns1FYZuZCH7iTMicCbNR0Os7ttkMTmPkP5c701cp5/tT
 0CbbWDaqhFdWUzFX76Cb24ew4u6KrwQyEPd+7sy1oF6zg5wNURP2iZLVorgkeuT1EJej
 c8Dw==
X-Gm-Message-State: AOJu0YxgkbLRcnJMeON4QKy09FQvw5CHCRjEeZ0RkiFqKPl1QcGSr8am
 KlJUDAdorgN1nNAvWvH4ikzAyZ2/9t/BeaBMPeXGdYdSB4mmC6cVPp86T3owF1fysI4=
X-Gm-Gg: AfdE7cnN/96AHtjFmb2hFLHXH19qiY6FVis5Zkj/xTanOMxDDaplHhJkHZGcuJ5hUIK
 vdYQhzzHyWzZuJa/M2jOxATL7vGkromXIVRWOA4dFvdEjlYv1gqR4X9ZGW8SZJcKl/f6NPRaLJ1
 Iwc97TyGYKCdjXTxzgxQdScuIjS9tGLitG8tpXhcUo1JeptnhMnwUW75HMIILUVwTOUHwKPWaao
 dWY6raLmt3QBq9D9HUnkv5757mW3rkeVJfguUXOkvAuzZrGc968rSeWY+GRSVmieUXq59OqHv77
 5rCCbhUPEY1RcfYO4yfhln4pHCluWFhCBjoqsW470GW06uo1tSnn/HAAq2Ffrl15Hb3gBvcMjZy
 dWfqpskz9xRj1DmPi7SnUZ3AwAW8EsWdkGF7bhNKFhd5FZln17831bq/Ku0YOgYkVw4zZZQAWok
 g=
X-Received: by 2002:a05:6820:4b01:b0:69d:8700:c925 with SMTP id
 006d021491bc7-6a0eb2bb79bmr4022497eaf.8.1782015717271; 
 Sat, 20 Jun 2026 21:21:57 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:00 -0600
Subject: [PATCH v3 13/40] bsd-user: Add os-socket.h with sendrecvmsg and
 message structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-13-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5700; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=O6uPorQhaJDF6iKXgsNK03Zv9M/bdNuQvvrVnzWPmM8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+NmpHVRsAZ8xMja+6ux3oyFqmXtDNYuT/7
 ilrQ98/VkuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 AH/8EACsPsIIfdygGsAqKucdoiUIzRl6T1CnLV1rzG+itK1cQBJU9sqUYJBwQOK4a8SqwfJPYyO
 xpVZiO416Z3tIF8Jom9gP9GrwdECCe6wwlS+QtFUZhEKHP6FFZy44jWIC9atfJ/9vDue+pCZFxR
 1/TGi5oxjHbUcinBjO0Eg/06v42Aq8JWF/x2FbGDOzziQrT8BWX+j0QtwL8B4PR0bI5huthmi6C
 k/H6zS35jd9evo/ubZty9/rzHA8iOdu4vuiAHa42ndYY3TaTAeNbEmqYOtIR6ST530vts1eWA6O
 UetuZTUjIRCEpT5VTsAgjnbdHnNiGD4BBORrS6PXwwFghJQpZx+mLrD+cw4xQnR2IaAzrcnfejS
 Jlmzs6UNDK/nM9Mvqmc3LMVqgCW9w1jXXAcDGYLwy1QDmuPyfg/oUTJgBvYywBZfQ05gl+JMzdh
 9qgtqVgFiYiUNi4EVyrbUBNY/mjX94wOqXTsgIutHo42Gl1tA3ulia8w1gQ5/uZBnA7yTft2Tx2
 g+1R2Fg/uJwAxsb5YJMjG+oE+fBMPzy4vef+SZYrgndn6oq5Qo9ftZ4DdWD+RkHQxoss3R3OBvq
 dPfwZQCR3nV2buq/8rLFFapP9AfnqCTXbKzW1RhsHzeVoGruqVGTQfo1VJyf+j1PMChX1R9qGpq
 DRXnpeThunN0iJQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc35.google.com
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

Add the first part of FreeBSD socket support: do_sendrecvmsg_locked
and do_sendrecvmsg functions. Also add target_msghdr, target_cmsghdr,
CMSG macros, target_ip_mreq, and target_ip_mreqn structures to
syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h  | 142 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   1 +
 2 files changed, 143 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
new file mode 100644
index 0000000000..279157dd05
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.h
@@ -0,0 +1,142 @@
+/*
+ * FreeBSD socket related system call shims
+ *
+ * Copyright (c) 2013-2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_SOCKET_H
+#define BSD_USER_FREEBSD_OS_SOCKET_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu-os.h"
+
+ssize_t safe_recvmsg(int s, struct msghdr *msg, int flags);
+ssize_t safe_sendmsg(int s, const struct msghdr *msg, int flags);
+
+/* do_sendrecvmsg_locked() Must return target values and target errnos. */
+static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
+                                      int flags, int send)
+{
+    abi_long ret, len;
+    struct msghdr msg;
+    abi_ulong count;
+    struct iovec *vec;
+    abi_ulong target_vec;
+
+    if (msgp->msg_name) {
+        msg.msg_namelen = tswap32(msgp->msg_namelen);
+        msg.msg_name = alloca(msg.msg_namelen + 1);
+        ret = target_to_host_sockaddr(msg.msg_name,
+                                      tswapal(msgp->msg_name),
+                                      msg.msg_namelen);
+        if (ret == -TARGET_EFAULT) {
+            /*
+             * For connected sockets msg_name and msg_namelen must be ignored,
+             * so returning EFAULT immediately is wrong.  Instead, pass a bad
+             * msg_name to the host kernel, and let it decide whether to return
+             * EFAULT or not.
+             */
+            msg.msg_name = (void *)-1;
+        } else if (ret) {
+            goto out2;
+        }
+    } else {
+        msg.msg_name = NULL;
+        msg.msg_namelen = 0;
+    }
+    msg.msg_controllen = 2 * tswap32(msgp->msg_controllen);
+    if (msgp->msg_control) {
+        msg.msg_control = alloca(msg.msg_controllen);
+        memset(msg.msg_control, 0, msg.msg_controllen);
+    } else {
+        msg.msg_control = NULL;
+    }
+
+    msg.msg_flags = tswap32(msgp->msg_flags);
+
+    count = tswap32(msgp->msg_iovlen);
+    target_vec = tswapal(msgp->msg_iov);
+
+    if (count > IOV_MAX) {
+        /*
+         * sendrcvmsg returns a different errno for this condition than
+         * readv/writev, so we must catch it here before lock_iovec() does.
+         */
+        ret = -TARGET_EMSGSIZE;
+        goto out2;
+    }
+
+    vec = lock_iovec(send ? VERIFY_READ : VERIFY_WRITE,
+                     target_vec, count, send);
+    if (vec == NULL) {
+        ret = -host_to_target_errno(errno);
+        goto out2;
+    }
+    msg.msg_iovlen = count;
+    msg.msg_iov = vec;
+
+    if (send) {
+        if (msg.msg_control != NULL) {
+            ret = t2h_freebsd_cmsg(&msg, msgp);
+        } else {
+            ret = 0;
+        }
+        if (ret == 0) {
+            ret = get_errno(safe_sendmsg(fd, &msg, flags));
+        }
+    } else {
+        ret = get_errno(safe_recvmsg(fd, &msg, flags));
+        if (!is_error(ret)) {
+            len = ret;
+            if (msg.msg_control != NULL) {
+                ret = h2t_freebsd_cmsg(msgp, &msg);
+            } else {
+                ret = 0;
+            }
+            if (!is_error(ret)) {
+                msgp->msg_namelen = tswap32(msg.msg_namelen);
+                msgp->msg_flags = tswap32(msg.msg_flags);
+                if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
+                    ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
+                                    msg.msg_name, msg.msg_namelen);
+                    if (ret) {
+                        goto out;
+                    }
+                }
+
+                ret = len;
+            }
+        }
+    }
+
+out:
+    unlock_iovec(vec, target_vec, count, !send);
+out2:
+    return ret;
+}
+
+
+static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
+                               int flags, int send)
+{
+    abi_long ret;
+    struct target_msghdr *msgp;
+
+    if (!lock_user_struct(send ? VERIFY_READ : VERIFY_WRITE,
+                          msgp,
+                          target_msg,
+                          send ? 1 : 0)) {
+        return -TARGET_EFAULT;
+    }
+    ret = do_sendrecvmsg_locked(fd, msgp, flags, send);
+    unlock_user_struct(msgp, target_msg, send ? 0 : 1);
+    return ret;
+}
+
+
+#endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 737de36514..46fee46336 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -47,6 +47,7 @@
 #include "os-proc.h"
 #include "os-signal.h"
 #include "os-file.h"
+#include "os-socket.h"
 #include "os-misc.h"
 
 /* I/O */

-- 
2.52.0


