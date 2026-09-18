Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4585EC982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAE-0005Sk-0u; Fri, 18 Sep 2026 00:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAB-0005P5-Ld
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:27 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA9-0004BN-Gu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:27 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7fccd4c3f36so183277a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705524; x=1790310324;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j46Fn4u4yyCU61/i3hQ0EFvVlPI428ZavcaAEJn7RU0=;
 b=x1ye+pDYHhR5PfaC+J9Jdf5XmjLG3grZ2soJsW1N8yK9bhMiZ1mDR4wRZDnpsohVm1
 piyjzKfbt1Y6T1XFVFr3CdFlvdnm+hCigPGVzxT4ucqbuU5vLb7X1FCaLRFl7GZ+D6ym
 WgL6c7nPic8ivf6dHAl1Yxb74QnDB4jD/j4bT5rS+6c+tskY87UICPwQlstpfTegPsGl
 hV2FSM2366rcOL3WMJNUF84SdLjInM+XP4/AkXyk14vK9bG5hoUVKovUfLh/qABtZFlM
 ppE+t9U+RsWtN/cb5sM5bA64OBaKKKkM9NDmOq+Yk4wS3C3WhhZpIOHdu+CGY9aBAQPW
 ebTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705524; x=1790310324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j46Fn4u4yyCU61/i3hQ0EFvVlPI428ZavcaAEJn7RU0=;
 b=qe1x6Qz+VwEhbrwS/hP4IKa4e8u8HKTA7mHY0x9+gyOaQso79gl8hQcUEMoopv1xIZ
 1ir3O+ySjRw5/iH8X17NqHmQx5XIt3f7KvXregZT5GcvwfzGVCg3ZI68D/8ZIPI+FFkk
 HlE24dEChMMCKBLQR8U3DhVrE2LrtdKH9bDEEmkmg8KD5lg0xe89drrWfi8j9FW+63R1
 P3Hpij48W9ohWmkXfqjHmP/UrEACmcwGYbiHZdallGyN5jLlonRK4giW07KBPtYViYop
 Bjy/hwGRb4XrRsde5YrLOmV0vXdiv84JZm5H3UlCtEuyp651ZgWa0YybOibxwptHqpoQ
 duhA==
X-Gm-Message-State: AFuF++n8Rxmc3kO4wPexW3JDUwtVA5kgqTt0M7Ik8/QMUemgGEX93h3H
 8Gi+S2486294nKPvRdz8k15d2zNuTr75tQmP5zQ2+I9Z5KgQ4if8+JHdCGW9TeFDImQe1Yu7kQE
 magXT370=
X-Gm-Gg: AYBFou0P9sdxiTMyQxwcH2v4je5Uf5Ge9CP2csYEd97bh+SkiQIWUQS4xcWbg8MsDBF
 lvZLAzHoogMb6D0JZXJGm9c3dVR96j0ttlUjhCi/4UFXaIgYTmDWdd44XjyQzuwGJy7JAU2eTcA
 WIGs8/QtgvLhOogK/aw/ZdUVQNf+QMxleceby0S3po6cSatIxxDU0iurnn99HabFPWhm+7JDIHa
 zfkav2JgFduStDCj0aI0GyiPUa+hDkvvOGDaC0wx/Cs7NhzGozfmvip3q6SwUKYiRknDQTr5PU7
 0AgMrFFTt8bfFDaa6m/Ke0PUWVorNgQleOeSWz+vjySJJJ6r5YswwR9v06Zweqiobo0lP05xPpr
 NCpsP+UXYyNnIZgU+ahdqzxx9S7HLhgJX7bK7uuEh39lP4srAMJHbqGwieqG1NlNqtbAu35GMzx
 2gzxfejYOVznbyufUzyFWxAjZikqMT91HcuTNX+sqWGtlP2IZgFmak8/er9A==
X-Received: by 2002:a05:6830:7009:b0:80c:d34f:5f61 with SMTP id
 46e09a7af769-80de31e75d7mr1589196a34.26.1789705524472; 
 Thu, 17 Sep 2026 21:25:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/41] bsd-user: Add bsd-socket.h with bind through getsockname
Date: Thu, 17 Sep 2026 22:23:56 -0600
Message-ID: <20260918042422.38713-16-imp@bsdimp.com>
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

Add the first set of socket system call shims: bind, connect,
accept, getpeername, and getsockname. Also add safe_syscall wrappers
for sendto, recvfrom, select, and pselect.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h         | 167 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  13 +++
 bsd-user/syscall_defs.h       | 112 +++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 bsd-user/bsd-socket.h

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
index 228daed4c4..7bc9fedfb7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -40,6 +40,7 @@
 #include "bsd-proc.h"
 #include "bsd-misc.h"
 #include "bsd-signal.h"
+#include "bsd-socket.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -73,6 +74,18 @@ safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
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
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 1a85ceb464..0d7002312f 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -203,6 +203,73 @@ struct target_freebsd__wrusage {
     struct target_freebsd_rusage wru_children;
 };
 
+/*
+ * sys/socket.h
+ */
+
+/*
+ * Types
+ */
+#define TARGET_SOCK_STREAM      1   /* stream socket */
+#define TARGET_SOCK_DGRAM       2   /* datagram socket */
+#define TARGET_SOCK_RAW         3   /* raw-protocol interface */
+#define TARGET_SOCK_RDM         4   /* reliably-delivered message */
+#define TARGET_SOCK_SEQPACKET   5   /* sequenced packet stream */
+
+
+/*
+ * Option flags per-socket.
+ */
+
+#define TARGET_SO_DEBUG         0x0001  /* turn on debugging info recording */
+#define TARGET_SO_ACCEPTCONN    0x0002  /* socket has had listen() */
+#define TARGET_SO_REUSEADDR     0x0004  /* allow local address reuse */
+#define TARGET_SO_KEEPALIVE     0x0008  /* keep connections alive */
+#define TARGET_SO_DONTROUTE     0x0010  /* just use interface addresses */
+#define TARGET_SO_BROADCAST     0x0020  /* permit sending of broadcast msgs */
+#define TARGET_SO_USELOOPBACK   0x0040  /* bypass hardware when possible */
+#define TARGET_SO_LINGER        0x0080  /* linger on close if data present */
+#define TARGET_SO_OOBINLINE     0x0100  /* leave received OOB data in line */
+#define TARGET_SO_REUSEPORT     0x0200  /* allow local address & port reuse */
+#define TARGET_SO_TIMESTAMP     0x0400  /* timestamp received dgram traffic */
+#define TARGET_SO_NOSIGPIPE     0x0800  /* no SIGPIPE from EPIPE */
+#define TARGET_SO_ACCEPTFILTER  0x1000  /* there is an accept filter */
+#define TARGET_SO_BINTIME       0x2000  /* timestamp received dgram traffic */
+#define TARGET_SO_NO_OFFLOAD    0x4000  /* socket cannot be offloaded */
+#define TARGET_SO_NO_DDP        0x8000  /* disable direct data placement */
+
+/*
+ * Additional options, not kept in so_options.
+ */
+#define TARGET_SO_SNDBUF        0x1001  /* send buffer size */
+#define TARGET_SO_RCVBUF        0x1002  /* receive buffer size */
+#define TARGET_SO_SNDLOWAT      0x1003  /* send low-water mark */
+#define TARGET_SO_RCVLOWAT      0x1004  /* receive low-water mark */
+#define TARGET_SO_SNDTIMEO      0x1005  /* send timeout */
+#define TARGET_SO_RCVTIMEO      0x1006  /* receive timeout */
+#define TARGET_SO_ERROR         0x1007  /* get error status and clear */
+#define TARGET_SO_TYPE          0x1008  /* get socket type */
+#define TARGET_SO_LABEL         0x1009  /* socket's MAC label */
+#define TARGET_SO_PEERLABEL     0x1010  /* socket's peer's MAC label */
+#define TARGET_SO_LISTENQLIMIT  0x1011  /* socket's backlog limit */
+#define TARGET_SO_LISTENQLEN    0x1012  /* socket's complete queue length */
+#define TARGET_SO_LISTENINCQLEN 0x1013  /* socket's incomplete queue length */
+#define TARGET_SO_SETFIB        0x1014  /* use this FIB to route */
+#define TARGET_SO_USER_COOKIE   0x1015  /* user cookie (dummynet etc.) */
+#define TARGET_SO_PROTOCOL      0x1016  /* get socket protocol (Linux name) */
+
+/* alias for SO_PROTOCOL (SunOS name) */
+#define TARGET_SO_PROTOTYPE     TARGET_SO_PROTOCOL
+
+/*
+ * Level number for (get/set)sockopt() to apply to socket itself.
+ */
+#define TARGET_SOL_SOCKET       0xffff  /* options for socket level */
+
+#ifndef CMSG_ALIGN
+#define CMSG_ALIGN(len) (((len) + sizeof(long) - 1) & ~(sizeof(long) - 1))
+#endif
+
 /*
  * sys/socket.h
  */
@@ -225,6 +292,51 @@ struct target_sockaddr {
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
+
+struct target_cmsghdr {
+    uint32_t    cmsg_len;
+    int32_t     cmsg_level;
+    int32_t     cmsg_type;
+};
+
+/*
+ * mips32 is the exception to the general rule of long-alignment; it
+ * unconditionally uses 64-bit alignment instead.
+ */
+#if defined(TARGET_MIPS) && TARGET_ABI_BITS == 32
+#define TARGET_ALIGNBYTES   (sizeof(abi_llong) - 1)
+#else
+#define TARGET_ALIGNBYTES   (sizeof(abi_long) - 1)
+#endif
+
+#define TARGET_CMSG_NXTHDR(mhdr, cmsg, cmsg_start) \
+                               __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
+#define TARGET_CMSG_ALIGN(len) (((len) + TARGET_ALIGNBYTES) \
+                               & (size_t) ~TARGET_ALIGNBYTES)
+#define TARGET_CMSG_DATA(cmsg) \
+    ((unsigned char *)(cmsg) + TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)))
+#define TARGET_CMSG_SPACE(len) \
+    (TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)) + TARGET_CMSG_ALIGN(len))
+#define TARGET_CMSG_LEN(len) \
+    (TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)) + (len))
+
+static inline struct target_cmsghdr *
+__target_cmsg_nxthdr(struct target_msghdr *__mhdr,
+                     struct target_cmsghdr *__cmsg,
+                     struct target_cmsghdr *__cmsg_start)
+{
+    struct target_cmsghdr *__ptr;
+
+    __ptr = (struct target_cmsghdr *)((unsigned char *) __cmsg +
+        TARGET_CMSG_ALIGN(tswap32(__cmsg->cmsg_len)));
+    if ((unsigned long)((char *)(__ptr + 1) - (char *)__cmsg_start) >
+        tswap32(__mhdr->msg_controllen)) {
+        /* No more entries.  */
+        return (struct target_cmsghdr *)0;
+    }
+    return __ptr;
+}
+
 /*
  * netinet/in.h
  */
-- 
2.55.0


