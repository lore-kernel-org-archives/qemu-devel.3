Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74687CDB46B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gy-0002wP-An; Sun, 21 Jun 2026 00:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gv-0002vr-HK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:53 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gs-00054P-JE
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:53 -0400
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-6a0db321df5so1690000eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015709; x=1782620509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRC3kvzITX1OvjKiubDPut5xsLaO/5c5/2N3DA0JvIw=;
 b=XuC6jJ7XJTsHcXPHSm6NYW2/dSmYQek8kwXBuMlj97Et81vCf7K7uDqu8glSOogVls
 t66VsJ0F4iZRhrfI0jx7b2z1phBG6LWPUUcUhG1kQKjAUxeID4jPRQS0LA1zlAmr6KS9
 xmGn0TeiFFFpHboSIg9wPTWkLVW4RsgyaMRU4isgUvaitvTKUW7ZtGxOVMCxQYeJ3BRs
 nnw3mDKolC89SP9F3CN7pBKJIsXIHv3xN6JrAXfD+tP3ipg1Jxp9s2/ANLZrLKwTSdmo
 fvrJVZEbVwFBKOsUkzp1RBVsq+2A1xKgi63l6IUa5ugxlPY0ioBJCAfN/cxm/uFaFOYX
 OZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015709; x=1782620509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRC3kvzITX1OvjKiubDPut5xsLaO/5c5/2N3DA0JvIw=;
 b=Wm0nUdeEfWyjaPsoEvM4Lkqlqg7EfIZqHAvRbr5UnG/noePLGy59lwH8DehKPQ2Ke/
 LqbgYShkwfO7Fo9EuFHU7+9sJG/GF/1m/SIJsqH+Iwqtcv3MA6lLPW8ZeGO0qVILDON6
 KhqGvRyl1z8JpwHpGM0FhCXS2FGAEnz4SlQ8DoQIjrHkAm3p1KArH7IqES59LEob0SKi
 v0ATUYLTl6YawLLWLFkqBcgiMBUohxGjEqyIzXomzgsgPkAoliO/APyJMNYXsbP9qZv/
 8FPI28BLiHicOdt+iELzyx9xE17WCd4CxlhUDtQO4MSz2r67V8ahhFruc731fxf+/6q9
 9PQw==
X-Gm-Message-State: AOJu0YzB0gP+AWiM7tOgQiiULrfKsb4h07Rn3otvQhODJjlV96TQNfMp
 oSeNWGxSC8pQk1oX0OyfEUlLt/trISEOv4daP5FmI0vg19uLMH8rcHNTk2NedsWr4p8=
X-Gm-Gg: AfdE7cm8T9kxGybfsypVaqvykQ+6wKzFj2dbpIyfvu6esaFub4jCI0WCRDFkMbYaItO
 70LWYi1FX+oHEwxpkqfjEaO1NatrvRrj+nkAoEkPBXUzyctjloNW+m/zTv9bgZNtSnrCfVmh79Z
 HMWxI+bHnVnJhoJLWPjFhe56UNeEf6Xpugpo0/MYTtTtpII2HFqR9wHSAZljCYnBSZJd30X1ti7
 +Xjgk73iX3LO+UcIav2EVwBLtCkBvzIL4mN0dey5mpf61il3mc+OB5XsaATUsmvJV93daP+Bj0w
 pUJMAFBIlcZ9DBN6pJUWt/hb+myYzTAPIXtfaYdaC1TRTTSCxQhoB4Dgk8QPL5nHb8WGQBWmF/G
 5L0uw79VMiyqE6lQYUEwPmLNVftn7qzvlu2CoTfpW64CSSr5mh4ELxrkWd5w9faTAwrnxYXtTwb
 qt+Be6VHuwcw==
X-Received: by 2002:a05:6820:201b:b0:69e:e019:a187 with SMTP id
 006d021491bc7-6a0d8c24227mr6879011eaf.20.1782015709392; 
 Sat, 20 Jun 2026 21:21:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:55 -0600
Subject: [PATCH v3 08/40] bsd-user: Add poll, lseek, pipe, and swap system
 call shims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-8-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22843; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gcb/BuSEcjZjFvpsDNoniaTFulYGCVFqua2pj0rF1nk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z9NivZbSNPYyztqYthGPmQHYDV26G+weVUy
 mm0VWUy9j2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AJK+EACh6yDac8urEnbfBkesGCP7fI0LxB/W9e72/rdAJBfdxqpDeiu6OxDuLfuxwzoeHwXNLfw
 cjUQAFyM0gLskpnY65qnMTpMZdzl8vGxqAkWXR8Gr38WgWF8MWGML72ROa/zEMSREk2yCe2H2aP
 pqqbRpfD6BtrACBGP3dqnCfXEzsQwUEUHd2NHoSTqE6xNKYqhv4dczemFZ6qdNJOM1o7Nw+lifl
 64ngyLYFMnBsXCevf0NnN/LVJNbGlOsbidTKVcLFB/1fjDULcbIJMMhTGpWiMjzUZ6Lk9n21JDl
 HcLBlMT+l6BpuZzFcia7KfJ5KlkGTagdaPJsEUTdJRD49on05zokDdrJA9hM/08XSe7dvOtpPvT
 uDGtFQgkrQJekRy7Dpx43Mp1EYDkr5AZOHRcz7BjnoOdHzFq+4A8spRQdlavgQPHcfm8cY+cXVM
 MJcuKM/lRgUeLSnGlfYmNOtnpNS+9uBCRqYF8bEYi7ATc2qlr5FqvZjgdH5lY8uw1fbDxCOfNlr
 ppXfYdVdLtBtoMf/cS2iJ+8Ythy7yz8awXa7MDyMA9233LoUsI47Rv9HmgingvOaVNE7dqWO0Bd
 XR7dgThxl6Vb/nDklASfCnv8LXSUe6QBu30UXahb00LwNpiA2kIIsVwkZVkVUH06RjfP8ntoW4e
 uE467pqErClP/BA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c42;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc42.google.com
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

Add do_bsd_poll, do_bsd_lseek, do_bsd_pipe, do_bsd_swapon,
do_freebsd13_swapoff, and do_bsd_swapoff to bsd-file.h. Also add
target_pollfd structure to syscall_defs.h and include poll.h in
os-syscall.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h           | 136 +++++++++++++
 bsd-user/freebsd/os-syscall.c |   1 +
 bsd-user/syscall_defs.h       | 458 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 534 insertions(+), 61 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 7ef9470c4e..0fefc07232 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -55,6 +55,10 @@ ssize_t safe_pwrite(int fd, void *buf, size_t nbytes, off_t offset);
 ssize_t safe_writev(int fd, const struct iovec *iov, int iovcnt);
 ssize_t safe_pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset);
 
+int safe_ppoll(struct pollfd *fds, nfds_t nfds,
+               const struct timespec *restrict timeout,
+               const sigset_t *restrict newsigmask);
+
 /* read(2) */
 static abi_long do_bsd_read(abi_long arg1, abi_long arg2, abi_long arg3)
 {
@@ -925,4 +929,136 @@ static abi_long do_bsd_undelete(abi_long arg1)
     return ret;
 }
 
+/* poll(2) */
+static abi_long do_bsd_poll(abi_long arg1, abi_long arg2, abi_long arg3)
+{
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    int timeout = arg3;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *pts = NULL;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+            sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    if (timeout != INFTIM) {
+        ts.tv_sec = timeout / 1000;
+        ts.tv_nsec = (timeout % 1000) * 1000000;
+        pts = &ts;
+    }
+
+    ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL));
+
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+
+    return ret;
+}
+
+/* lseek(2) */
+static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_long ret;
+#if TARGET_ABI_BITS == 32
+    int64_t res;
+
+    /* 32-bit arch's use two 32 registers for 64 bit return value */
+    if (regpairs_aligned(env) != 0) {
+        res = lseek(arg1, target_arg64(arg3, arg4), arg5);
+    } else {
+        res = lseek(arg1, target_arg64(arg2, arg3), arg4);
+    }
+    if (res == -1) {
+        ret = get_errno(res);
+        set_second_rval(env, 0xFFFFFFFF);
+    } else {
+#ifdef TARGET_BIG_ENDIAN
+        ret = ((res >> 32) & 0xFFFFFFFF);
+        set_second_rval(env, res & 0xFFFFFFFF);
+#else
+        ret = res & 0xFFFFFFFF;
+        set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
+#endif
+    }
+#else
+    ret = get_errno(lseek(arg1, arg2, arg3));
+#endif
+    return ret;
+}
+
+/* pipe(2) */
+static abi_long do_bsd_pipe(CPUArchState *env, abi_ulong pipedes)
+{
+    abi_long ret;
+    int host_pipe[2];
+    int host_ret = pipe(host_pipe);
+
+    if (host_ret != -1) {
+        set_second_rval(env, host_pipe[1]);
+        ret = host_pipe[0];
+    } else {
+        ret = get_errno(host_ret);
+    }
+    return ret;
+}
+
+/* swapon(2) */
+static abi_long do_bsd_swapon(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(swapon(path(p)));
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+
+#ifdef TARGET_FREEBSD_NR_freebsd13_swapoff
+/* swapoff(2) */
+static abi_long do_freebsd13_swapoff(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(swapoff(path(p), 0));
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+#endif
+
+/* swapoff(2) */
+static abi_long do_bsd_swapoff(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+#ifdef TARGET_FREEBSD_NR_freebsd13_swapoff
+    ret = get_errno(swapoff(path(p), arg2));
+#else
+    ret = get_errno(swapoff(path(p)));
+#endif
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+
 #endif /* BSD_FILE_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 06148fe3ce..fc6273a780 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -26,6 +26,7 @@
 #include <sys/mount.h>
 #include <sys/sysctl.h>
 #include <utime.h>
+#include <poll.h>
 
 #include "include/gdbstub/syscalls.h"
 
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 0612be8bbb..833c7509e3 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -42,26 +42,6 @@ struct target_ipc_perm {
 #define TARGET_IPC_SET  1   /* set options */
 #define TARGET_IPC_STAT 2   /* get options */
 
-/*
- * sys/shm.h
- */
-struct target_shmid_ds {
-    struct  target_ipc_perm shm_perm; /* peration permission structure */
-    abi_ulong   shm_segsz;  /* size of segment in bytes */
-    int32_t     shm_lpid;   /* process ID of last shared memory op */
-    int32_t     shm_cpid;   /* process ID of creator */
-    int32_t     shm_nattch; /* number of current attaches */
-    target_time_t shm_atime;  /* time of last shmat() */
-    target_time_t shm_dtime;  /* time of last shmdt() */
-    target_time_t shm_ctime;  /* time of last change by shmctl() */
-};
-
-#define N_BSD_SHM_REGIONS   32
-struct bsd_shm_regions {
-    abi_long start;
-    abi_long size;
-};
-
 /*
  * sys/sem.h
  */
@@ -93,6 +73,26 @@ struct target_semid_ds {
     target_time_t   sem_ctime;  /* times measured in secs */
 };
 
+/*
+ * sys/shm.h
+ */
+struct target_shmid_ds {
+    struct  target_ipc_perm shm_perm; /* peration permission structure */
+    abi_ulong   shm_segsz;  /* size of segment in bytes */
+    int32_t     shm_lpid;   /* process ID of last shared memory op */
+    int32_t     shm_cpid;   /* process ID of creator */
+    int32_t     shm_nattch; /* number of current attaches */
+    target_time_t shm_atime;  /* time of last shmat() */
+    target_time_t shm_dtime;  /* time of last shmdt() */
+    target_time_t shm_ctime;  /* time of last change by shmctl() */
+};
+
+#define N_BSD_SHM_REGIONS   32
+struct bsd_shm_regions {
+    abi_long start;
+    abi_long size;
+};
+
 /*
  * sys/msg.h
  */
@@ -118,23 +118,26 @@ struct target_msgbuf {
     char        mtext[1];   /* body of message */
 };
 
+/*
+ * sched.h
+ */
+struct target_sched_param {
+        int32_t sched_priority;
+};
+
 /*
  *  sys/mman.h
  */
 #define TARGET_MADV_DONTNEED            4       /* dont need these pages */
 
-#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
-                                                /* MAP_INHERIT */
-#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-                                                /* MAP_NOEXTEND */
-#define TARGET_FREEBSD_MAP_STACK        0x0400  /* region grows down, like a */
-                                                /* stack */
-#define TARGET_FREEBSD_MAP_NOSYNC       0x0800  /* page to but do not sync */
-                                                /* underlying file */
+#define MAP_TYPE 0xf
 
+/* XXX These are needed by mmap.c until it is updated to match blitz */
+#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080
+#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100
+#define TARGET_FREEBSD_MAP_STACK        0x0400
+#define TARGET_FREEBSD_MAP_NOSYNC       0x0800
 #define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
-
-/* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 
 /*
@@ -142,8 +145,6 @@ struct target_msgbuf {
  * sys/timex.h
  */
 
-typedef abi_long target_freebsd_suseconds_t;
-
 /* compare to sys/timespec.h */
 struct target_freebsd_timespec {
     target_time_t   tv_sec;     /* seconds */
@@ -165,12 +166,75 @@ struct target_freebsd__umtx_time {
 
 struct target_freebsd_timeval {
     target_time_t       tv_sec; /* seconds */
-    target_freebsd_suseconds_t  tv_usec;/* and microseconds */
+    target_suseconds_t  tv_usec;/* and microseconds */
 #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
     abi_long _pad;
 #endif
 };
 
+/* compare to sys/timex.h */
+struct target_freebsd_ntptimeval {
+    struct target_freebsd_timespec  time;
+    abi_long    maxerror;
+    abi_long    esterror;
+    abi_long    tai;
+    int32_t     time_state;
+};
+
+struct target_freebsd_itimerspec {
+    struct target_freebsd_timespec it_interval;
+    struct target_freebsd_timespec it_value;
+};
+
+struct target_freebsd_timex {
+    uint32_t    modes;
+    abi_long    offset;
+    abi_long    freq;
+    abi_long    maxerror;
+    abi_long    esterror;
+    int32_t     status;
+    abi_long    constant;
+    abi_long    precision;
+    abi_long    tolerance;
+
+    abi_long    ppsfreq;
+    abi_long    jitter;
+    int32_t     shift;
+    abi_long    stabil;
+    abi_long    jitcnt;
+    abi_long    calcnt;
+    abi_long    errcnt;
+    abi_long    stbcnt;
+};
+
+/* Maxiumum of 32 active POSIX timers allowed at any one time. */
+extern int g_posix_timers[32];
+
+#define TIMER_MAGIC 0x0caf0000
+#define TIMER_MAGIC_MASK 0xffff0000
+
+/*
+ * sys/event.h
+ */
+struct target_freebsd11_kevent {
+    abi_ulong  ident;
+    int16_t    filter;
+    uint16_t   flags;
+    uint32_t   fflags;
+    abi_long   data;
+    abi_ulong  udata;
+};
+
+struct target_freebsd_kevent {
+    abi_ulong  ident;
+    int16_t    filter;
+    uint16_t   flags;
+    uint32_t   fflags;
+    int64_t data;
+    abi_ulong  udata;
+    uint64_t  ext[4];
+};
+
 /*
  *  sys/resource.h
  */
@@ -219,6 +283,154 @@ struct target_freebsd__wrusage {
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
@@ -434,6 +646,152 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/* sys/specialfd.h */
+enum target_specialfd_type {
+    TARGET_SPECIALFD_EVENT         = 1,
+};
+
+struct target_specialfd_eventfd {
+    unsigned int initval;
+    int flags;
+};
+
+/*
+ * FreeBSD thread and user mutex support.
+ */
+
+/* sys/thr.h */
+#define TARGET_THR_SUSPENDED    0x0001
+#define TARGET_THR_SYSTEM_SCOPE 0x0002
+
+struct target_freebsd_thr_param {
+    abi_ulong   start_func; /* thread entry function. */
+    abi_ulong   arg;        /* argument for entry function. */
+    abi_ulong   stack_base; /* stack base address. */
+    abi_ulong   stack_size; /* stack size. */
+    abi_ulong   tls_base;   /* tls base address. */
+    abi_ulong   tls_size;   /* tls size. */
+    abi_ulong   child_tid;  /* address to store new TID. */
+    abi_ulong   parent_tid; /* parent access the new TID here. */
+    int32_t     flags;      /* thread flags. */
+    abi_ulong   rtp;        /* Real-time scheduling priority. */
+    abi_ulong   spare[3];   /* spares. */
+};
+
+/* sys/rtprio.h */
+struct target_freebsd_rtprio {
+    uint16_t    type;
+    uint16_t    prio;
+};
+
+typedef struct {
+    CPUArchState *env;
+    long parent_tid;
+    pthread_mutex_t mutex;
+    pthread_cond_t cond;
+    pthread_t thread;
+    sigset_t sigmask;
+    struct target_freebsd_thr_param param;
+} new_freebsd_thread_info_t;
+
+/* sys/utmx.h */
+/* op code for _umtx_op */
+#define TARGET_UMTX_OP_LOCK                 0
+#define TARGET_UMTX_OP_UNLOCK               1
+#define TARGET_UMTX_OP_WAIT                 2
+#define TARGET_UMTX_OP_WAKE                 3
+#define TARGET_UMTX_OP_MUTEX_TRYLOCK        4
+#define TARGET_UMTX_OP_MUTEX_LOCK           5
+#define TARGET_UMTX_OP_MUTEX_UNLOCK         6
+#define TARGET_UMTX_OP_SET_CEILING          7
+#define TARGET_UMTX_OP_CV_WAIT              8
+#define TARGET_UMTX_OP_CV_SIGNAL            9
+#define TARGET_UMTX_OP_CV_BROADCAST         10
+#define TARGET_UMTX_OP_WAIT_UINT            11
+#define TARGET_UMTX_OP_RW_RDLOCK            12
+#define TARGET_UMTX_OP_RW_WRLOCK            13
+#define TARGET_UMTX_OP_RW_UNLOCK            14
+#define TARGET_UMTX_OP_WAIT_UINT_PRIVATE    15
+#define TARGET_UMTX_OP_WAKE_PRIVATE         16
+#define TARGET_UMTX_OP_MUTEX_WAIT           17
+#define TARGET_UMTX_OP_MUTEX_WAKE           18
+#define TARGET_UMTX_OP_SEM_WAIT             19
+#define TARGET_UMTX_OP_SEM_WAKE             20
+#define TARGET_UMTX_OP_NWAKE_PRIVATE        21
+#define TARGET_UMTX_OP_MUTEX_WAKE2          22
+#define TARGET_UMTX_OP_SEM2_WAIT            23
+#define TARGET_UMTX_OP_SEM2_WAKE            24
+#define TARGET_UMTX_OP_SHM                  25
+#define TARGET_UMTX_OP_ROBUST_LISTS         26
+
+/* flags for UMTX_OP_CV_WAIT */
+#define TARGET_CVWAIT_CHECK_UNPARKING       0x01
+#define TARGET_CVWAIT_ABSTIME               0x02
+#define TARGET_CVWAIT_CLOCKID               0x04
+
+#define TARGET_UMTX_UNOWNED                 0x0
+#define TARGET_UMUTEX_UNOWNED               0x0
+#define TARGET_UMTX_CONTESTED               (abi_ulong)(-1)
+#define TARGET_UMUTEX_CONTESTED             0x80000000U
+
+/* flags for umutex */
+#define TARGET_UMUTEX_ERROR_CHECK   0x0002  /* Error-checking mutex */
+#define TARGET_UMUTEX_PRIO_INHERIT  0x0004  /* Priority inherited mutex */
+#define TARGET_UMUTEX_PRIO_PROTECT  0x0008  /* Priority protect mutex */
+
+#define TARGET_UMUTEX_TRY           1
+#define TARGET_UMUTEX_WAIT          2
+
+/* urwlock flags */
+#define TARGET_URWLOCK_PREFER_READER    0x0002
+#define TARGET_URWLOCK_WRITE_OWNER      0x80000000U
+#define TARGET_URWLOCK_WRITE_WAITERS    0x40000000U
+#define TARGET_URWLOCK_READ_WAITERS     0x20000000U
+#define TARGET_URWLOCK_MAX_READERS      0x1fffffffU
+#define TARGET_URWLOCK_READER_COUNT(c)  ((c) & TARGET_URWLOCK_MAX_READERS)
+
+/*
+ * sys/acl.h
+ */
+#define TARGET_FREEBSD_ACL_MAX_ENTRIES          254
+
+/* vaild acl_type_t arguments */
+#define TARGET_FREEBSD_ACL_TYPE_ACCESS_OLD      0x00000000
+#define TARGET_FREEBSD_ACL_TYPE_DEFAULT_OLD     0x00000001
+#define TARGET_FREEBSD_ACL_TYPE_ACCESS          0x00000002
+#define TARGET_FREEBSD_ACL_TYPE_DEFAULT         0x00000003
+#define TARGET_FREEBSD_ACL_TYPE_NFS4            0x00000004
+
+struct target_freebsd_acl_entry {
+    uint32_t    ae_tag;
+    uint32_t    ae_id;
+    uint32_t    ae_perm;
+    uint16_t    ae_entry_type;
+    uint16_t    ae_flags;
+};
+
+struct target_freebsd_acl {
+    uint32_t            acl_maxcnt;
+    uint32_t            acl_cnt;
+    int32_t             acl_spare[4];
+    struct target_freebsd_acl_entry  acl_entry[TARGET_FREEBSD_ACL_MAX_ENTRIES];
+};
+
+/*
+ *  sys/uuid.h
+ */
+
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 /*
  * from sys/procctl.h
  */
@@ -475,21 +833,6 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
-/*
- * sys/uuid.h
- */
-#define TARGET_UUID_NODE_LEN    6
-
-struct target_uuid {
-    uint32_t    time_low;
-    uint16_t    time_mid;
-    uint16_t    time_hi_and_version;
-    uint8_t     clock_seq_hi_and_reserved;
-    uint8_t     clock_seq_low;
-    uint8_t     node[TARGET_UUID_NODE_LEN];
-};
-
-
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
@@ -537,22 +880,15 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
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
 
+struct target_pollfd {
+    int32_t fd;         /* file descriptor */
+    int16_t events;     /* requested events */
+    int16_t revents;    /* returned events */
+};
+
 /* So far all target and host bitmasks are the same */
 #undef  target_to_host_bitmask
 #define target_to_host_bitmask(x, tbl) (x)

-- 
2.52.0


