Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0284DC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAJ-0005YP-Ph; Fri, 18 Sep 2026 00:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAE-0005WG-J6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:31 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAC-0004Mc-JE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:30 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-80638c24bedso266070a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705527; x=1790310327;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYUyMQoT40u2msHNKD8OftoQr7GgD9EvZv1AL0aAxu4=;
 b=atJSwybuR4al1J2DZ5JVnxTpLWibKhA++UJ1hI/4u3M/lZ/Kl1jzN0014PHMa3mhC9
 nDZNvbNX4PRVrGf5poYqpYI/+e/k/wQEWHPS8KamI8jw/63dzkewkUL9geFYohVxWZkt
 8kUECUWdPQY0Y+vTsbNr+02lJ915cijXWBJdvHKukFt5y8boe4ZPzwb8u1JuX/gunQL2
 BdMxAurQAJKeHIiPDM9HvVKEzwYViSqMs5CPSeAurTn9Q2zVXejAwPpRpJ8NWteWC3fp
 8Oqk/eu4uQB1pI1Mbr3smPGX16zXpbtMhAUMKc/UzapNbPj8Isn1nP4hbjMl5jULUuJT
 rT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705527; x=1790310327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eYUyMQoT40u2msHNKD8OftoQr7GgD9EvZv1AL0aAxu4=;
 b=xozlAYt9Aa01pUvdQFz3t8v0Oy3lWiXu6W/Gr2VF5R5wzbOh+jj3FyPvx1+CGzm6sB
 Q+DX5lZu2G+a0HUYheifieYrDDu7I6bby6dSFp8rkMjoOlwNkk8tqTLEjO6Ih8vtzEXc
 +DOowurp1xWLyJxs20u9uKRQkgrX1P5a0oKEi+nIs1W7bdK+SE1zZqGggCGSB6DApEV9
 1sYAwyMJjNWgcbiQSS2TKtfZ8XOxP4CW642NOrcyYWjHlaKM7CP3bcc5Vg4x1Fw5t7C7
 mH9Zi63Co5bHcpOdvcqL8XBStrW6KUBLYzQwnB8jfWjjL5aPMT9sby559hw4QqA7+45U
 gArA==
X-Gm-Message-State: AFuF++norWMuhrpAzCJJb8eOCSTlzvUWW5VvTEH7yl4a22n1qToMnxRf
 kEfVpnuwnuUaynGvqo0eH3PEeIbLEKaJhukmwf3n5FfqA87nhAsJx4KQn5PdFKKgb0twVeA9269
 GaTgy/VQ=
X-Gm-Gg: AYBFou2prZYQ+f5ClC3Vcpws+Lx2kfXHQtkbLwUNbQeLIlzkUwjzpEGiHShunEp3or4
 q7rsQJJINrhdbkphTnu+NUE7iuv1bJk43p+M93v6kEU9Ya2n1SuIU66ttSvWg7Bhn1rdiL6fGcW
 5LQThBzy6+pCBEmlIMEPeV8pPwNN+srL635QNg4M9J76Qix5xoAHvi43FCLLCmUN/OFYLNPIMSg
 Yp5LJU0lZT+WLBvlJem01zorb7aSUMav1poXcQ3LhaVtVRr/75G2Fp1mGg1T5jh1TOF5MgCJ/cg
 ITz/c/E41O3Df8cL+zet64fpO3aTyUq3ett8cUrGjbZP9T5XISK3+kzifOx1+2JXIdkM+WQes5x
 sq0oOe0FmkK25bcT3S7ziFHpHscZcrlHCfg4wa/TzgoD3YxLg3l4sZJOuBK8ESNCR54tj5reBsc
 HsMUZOUBMwu21Ma8sH9foFayVOHuMP9bll73LtTQYU/+jp8IfxF3hnAP4V2Q==
X-Received: by 2002:a05:6830:a1d0:10b0:804:3ca9:8e5c with SMTP id
 46e09a7af769-80c4bd14d95mr3486551a34.8.1789705527407; 
 Thu, 17 Sep 2026 21:25:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/41] bsd-user: Implement both getsockopt and setsockopt
Date: Thu, 17 Sep 2026 22:23:59 -0600
Message-ID: <20260918042422.38713-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Implement get/setsockopt with the generated file describing the socket
options. This uses a table driven conversion. At the moment, we only
implement the simple types. For 64 on 64 with the same endian, we also
try to just copy in/out since the representation should be the same.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 340 +++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)
 create mode 100644 bsd-user/freebsd/os-socket.h

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
new file mode 100644
index 0000000000..126e49b282
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.h
@@ -0,0 +1,340 @@
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
+#include "os-sockopt.h"
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
+static inline struct sockopt_entry *get_sockopt_entry(int level)
+{
+    for (int i = 0; i < ARRAY_SIZE(so_cache); i++) {
+        if (so_cache[i].level == level) {
+            return so_cache[i].entry;
+        }
+    }
+    return NULL;
+}
+
+/* setsockopt(2) */
+static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, socklen_t optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    if (e == NULL) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (optlen != sizeof(int)) {
+                continue;
+            }
+            if (get_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
+        case SOCKOPT_TYPE_U_CHAR:
+            if (optlen != sizeof(u_char)) {
+                continue;
+            }
+            if (get_user_u8(ch, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &ch, sizeof(ch)));
+        case SOCKOPT_TYPE_UINT64_T:
+            if (optlen != sizeof(uint64_t)) {
+                continue;
+            }
+            if (get_user_u64(val64, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val64, sizeof(val64)));
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same (we hope).
+     */
+    p = lock_user(VERIFY_READ, optval_addr, optlen, 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setsockopt(sockfd, level, optname, p, optlen));
+    unlock_user(p, optval_addr, 0);
+    return ret;
+}
+
+/* getsockopt(2) */
+static inline abi_long do_bsd_getsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, abi_ulong optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    socklen_t len;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    if (e == NULL) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    if (get_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (len != sizeof(int)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(int)) {
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_U_CHAR:
+            if (len != sizeof(u_char)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &ch, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(u_char)) {
+                if (put_user_u8(ch, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_UINT64_T:
+            if (len != sizeof(uint64_t)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val64, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(uint64_t)) {
+                if (put_user_u64(val64, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same, and
+     * if not that is handled above.
+     */
+    p = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getsockopt(sockfd, level, optname, p, &len));
+    unlock_user(p, optval_addr, ret < 0 ? 0 : len);
+done:
+    if (put_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+
+#endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
-- 
2.55.0


