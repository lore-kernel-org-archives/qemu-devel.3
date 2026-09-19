Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A17C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yHK-0005TA-N0; Sat, 19 Sep 2026 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFm-0003Y4-Ey
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:32 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFk-0008PN-Gv
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:30 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae7089c0so855324eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836567; x=1790441367;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gN5bPPz2ZX9SFfIIzKLBsSzIgLDk7FdQLhmqcIDkoOA=;
 b=DeWh76II6pdwgGr4Nk5Y2+H6VnmrC6HUEL4vW7jc6CJr7O5m22vC3KkSV8+FfKAPe8
 qT9eYBQ9Fn3BJXAUw7L8rudXqyqjbRDjsdRaArh7RajmIne90n31Pp/jTPT+rcpeWtds
 X95zvD513ope/wZPUtft5sQMBCrCWjvQIKRQo3m/zz4YncprYI1xb74pAHqOMp5KudaZ
 3a4a1BfrD1pW4/KT8IAG2HcB0fYYxG/rK5GwaDf17mVs/UluDwydD7b34Jd/Os2cdcDW
 W2W2aHC1y7WnPx3sBUAAAuBV/UAZ6iK6TZugGlSYiDR+H05J1+9Wm4sl6hisp9n7rgAK
 KVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836567; x=1790441367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gN5bPPz2ZX9SFfIIzKLBsSzIgLDk7FdQLhmqcIDkoOA=;
 b=D84xNJol/HT535kVcxmqBOx6DpSCra4HVivS0YPo09abwMoYuvFDuSlGOacmjjP5zg
 Jj86AwRQVJRxZ3AEqRxenQcHup26zwuSu2zp/XcPyKloL4JTHwznwbTX2EXfsCwn3WHF
 4Ub/Ya7KOc8lkSyLkBn38hQHbDlcH865CmOYaDEThvJ4QZO/+bHnwFr1c+NbwudZGkn/
 1fiS5KgyuGtWxIQggUmbyyYKI8U1AzFLu3xilhNNSAVgFEk1L44322Y1BWqW+SUzROat
 +7JYG0g2ZF12fcmto24vpojxrBmarI/EMUBy8l6yO2Zb0ujDs3Hfd6MKCN5d487sTGoB
 Ccvg==
X-Gm-Message-State: AFuF++kY1UwDVA4EvODNgYKxp08sMGxZm4KXXgCljGlHxANvnUrM7YPc
 jJ4Pb8Qainn8Vw4FCWKwDwH3VEsTYwnNga7vU6o6xMpyiFROO+/wlSJyqoM3yzlGgTZ62i06TLC
 jMLe/j8Q=
X-Gm-Gg: AYBFou1Q4hqukl42tL2m20UxcbkcciWF9b8fFXRejY3DGYuUhx96aIFzp5TlnAW9jau
 K9sPwl+MUxF3qp6B0agjZlCvYU0zlHkfPJVJqdc05b+SDr7wwRsb+slPapcNzeMHZ1ultd5hIUt
 naeaLDXYA2xTv9fw6kIa2DWFXEnqHY0BRHP9wWqF9dft93EEKHQamVFT/wAc8AQXp8O7pteC+jL
 NCHQVrgYMP40BvxSOmiXd5qjm4VgzP6CrBzkn6ygOLiE9LsbtJqBbuQUT+mvPmS7rF54Cb+lM6I
 Jxw5Xhb2qLF2I5MOs1Hoq910wLPt95QBjYjDnMNwZxepYGOxTG3YEKKait7rbPLDNL0Wkp0zb6A
 FEwx/y5fC/FiPAAhWhY/IArTRds4BhsRKliV5+0WAGxw3mDTUnHjCcVZDu+dzo9qwz8E+veKL8+
 rtOyPTQpHQWVLZH0oN9KZHrBOTaHV+9qzCwXDSpSWEfFz23alECyTdc4kvOMunwkeiL3vg
X-Received: by 2002:a05:6820:2909:b0:6b7:8396:f3c6 with SMTP id
 006d021491bc7-6ca9c05bde7mr5476950eaf.40.1789836567211; 
 Sat, 19 Sep 2026 09:49:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>, Michal Meloun <mmel@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/41] bsd-user: Add os-thread.h with thr and context functions
Date: Sat, 19 Sep 2026 10:47:58 -0600
Message-ID: <20260919164810.70151-31-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::c; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0c.google.com
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

Add thread management system call shims: thr_self, thr_exit, thr_kill,
thr_kill2, thr_suspend, thr_wake, thr_set_name, rtprio_thread,
getcontext, setcontext, and swapcontext.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c |   6 +
 bsd-user/freebsd/os-thread.h  | 244 ++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)
 create mode 100644 bsd-user/freebsd/os-thread.h

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index cc66be3b7c..f2c3ff25e8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -49,6 +49,7 @@
 #include "os-file.h"
 #include "os-socket.h"
 #include "os-time.h"
+#include "os-thread.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -90,6 +91,11 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
 safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
 safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
+/* used in os-thread */
+safe_syscall1(int, thr_suspend, struct timespec *, timeout);
+safe_syscall5(int, _umtx_op, void *, obj, int, op, unsigned long, val, void *,
+    uaddr, void *, uaddr2);
+
 /* used in os-time */
 safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
     rmtp);
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
new file mode 100644
index 0000000000..d3f1f01b13
--- /dev/null
+++ b/bsd-user/freebsd/os-thread.h
@@ -0,0 +1,244 @@
+/*
+ * FreeBSD thread and user mutex related system call shims
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_THREAD_H
+#define FREEBSD_OS_THREAD_H
+
+#include <sys/thr.h>
+#include <sys/rtprio.h>
+#include <sys/umtx.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+int safe_thr_suspend(struct timespec *timeout);
+int safe__umtx_op(void *, int, unsigned long, void *, void *);
+
+#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
+    (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
+#define _UMTX_OPTIMIZED
+#if defined(TARGET_ABI32)
+#define QEMU_UMTX_OP(n) (UMTX_OP__32BIT | (n))
+#else
+#define QEMU_UMTX_OP(n) (n)
+#endif /* TARGET_ABI32 */
+#else
+#define QEMU_UMTX_OP(n) (n)
+#endif
+
+static inline abi_long do_freebsd_thr_self(abi_ulong target_id)
+{
+    abi_long ret;
+    long tid;
+
+    ret = get_errno(thr_self(&tid));
+    if (!is_error(ret)) {
+        if (put_user_sal(tid, target_id)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_thr_exit(CPUArchState *env,
+        abi_ulong tid_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *ts;
+
+    if (block_signals()) {
+        return -TARGET_ERESTART;
+    }
+
+    pthread_mutex_lock(new_freebsd_thread_lock_ptr);
+
+    ts = cpu->opaque;
+
+    if (tid_addr) {
+        /* Signal target userland that it can free the stack. */
+        if (!put_user_sal(1, tid_addr)) {
+            freebsd_umtx_wake_unsafe(tid_addr, INT_MAX);
+        }
+    }
+
+    object_unparent(OBJECT(env_cpu(env)));
+    object_unref(OBJECT(env_cpu(env)));
+    /*
+     * At this point the CPU should be unrealized and removed
+     * from cpu lists. We can clean-up the rest of the thread
+     * data without the lock held.
+     */
+
+    pthread_mutex_unlock(new_freebsd_thread_lock_ptr);
+
+    thread_cpu = NULL;
+    g_free(ts);
+    rcu_unregister_thread();
+    pthread_exit(NULL);
+    /* Doesn't return */
+    return 0;
+}
+
+static inline abi_long do_freebsd_thr_kill(long id, int sig)
+{
+
+    return get_errno(thr_kill(id, target_to_host_signal(sig)));
+}
+
+static inline abi_long do_freebsd_thr_kill2(pid_t pid, long id, int sig)
+{
+
+    return get_errno(thr_kill2(pid, id, target_to_host_signal(sig)));
+}
+
+static inline abi_long do_freebsd_thr_suspend(abi_ulong target_ts)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    if (target_ts != 0) {
+        if (t2h_freebsd_timespec(&ts, target_ts)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(safe_thr_suspend(&ts));
+    } else {
+        ret = get_errno(safe_thr_suspend(NULL));
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_thr_wake(long tid)
+{
+
+    return get_errno(thr_wake(tid));
+}
+
+static inline abi_long do_freebsd_thr_set_name(long tid, abi_ulong target_name)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(target_name);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(thr_set_name(tid, p));
+    unlock_user(p, target_name, 0);
+
+    return ret;
+}
+
+static inline abi_long do_freebsd_rtprio_thread(int function, lwpid_t lwpid,
+        abi_ulong target_addr)
+{
+    int ret;
+    struct rtprio rtp;
+
+    ret = t2h_freebsd_rtprio(&rtp, target_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(rtprio_thread(function, lwpid, &rtp));
+    }
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_rtprio(target_addr, &rtp);
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_getcontext(CPUArchState *env, abi_ulong arg1)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+
+    if (arg1 == 0) {
+        return -TARGET_EINVAL;
+    }
+    ret = do_sigprocmask(0, NULL, &sigmask);
+    if (!is_error(ret)) {
+        ucp = lock_user(VERIFY_WRITE, arg1, sizeof(target_ucontext_t), 0);
+        if (ucp == 0) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_mcontext(env, &ucp->uc_mcontext, TARGET_MC_GET_CLEAR_RET);
+        host_to_target_sigset(&ucp->uc_sigmask, &sigmask);
+        memset(ucp->__spare__, 0, sizeof(ucp->__spare__));
+        unlock_user(ucp, arg1, sizeof(target_ucontext_t));
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_setcontext(CPUArchState *env, abi_ulong arg1)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+    if (arg1 == 0) {
+        return -TARGET_EINVAL;
+    }
+    ucp = lock_user(VERIFY_READ, arg1, sizeof(target_ucontext_t), 1);
+    if (ucp == 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = set_mcontext(env, &ucp->uc_mcontext, 0);
+    target_to_host_sigset(&sigmask, &ucp->uc_sigmask);
+    unlock_user(ucp, arg1, 0);
+    if (!is_error(ret)) {
+        (void)do_sigprocmask(SIG_SETMASK, &sigmask, NULL);
+    }
+    return ret == 0 ? -TARGET_EJUSTRETURN : ret;
+}
+
+/* swapcontext(2) */
+static inline abi_long do_freebsd_swapcontext(CPUArchState *env, abi_ulong arg1,
+        abi_ulong arg2)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+
+    if (arg1 == 0 || arg2 == 0) {
+        return -TARGET_EINVAL;
+    }
+    /* Save current context in arg1. */
+    ret = do_sigprocmask(0, NULL, &sigmask);
+    if (!is_error(ret)) {
+        ucp = lock_user(VERIFY_WRITE, arg1, sizeof(target_ucontext_t), 0);
+        if (ucp == 0) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_mcontext(env, &ucp->uc_mcontext, TARGET_MC_GET_CLEAR_RET);
+        host_to_target_sigset(&ucp->uc_sigmask, &sigmask);
+        memset(ucp->__spare__, 0, sizeof(ucp->__spare__));
+        unlock_user(ucp, arg1, sizeof(target_ucontext_t));
+    }
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    /* Restore the context in arg2 to the current context. */
+    ucp = lock_user(VERIFY_READ, arg2, sizeof(target_ucontext_t), 1);
+    if (ucp == 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = set_mcontext(env, &ucp->uc_mcontext, 0);
+    target_to_host_sigset(&sigmask, &ucp->uc_sigmask);
+    unlock_user(ucp, arg2, 0);
+    if (!is_error(ret)) {
+        (void)do_sigprocmask(SIG_SETMASK, &sigmask, NULL);
+    }
+    return ret == 0 ? -TARGET_EJUSTRETURN : ret;
+}
+
+
+#define safe_g2h_untagged(x) ((x) != 0 ? g2h_untagged(x) : NULL)
+
+/*
+ * undocumented _umtx_op(void *obj, int op, u_long val, void *uaddr,
+ *                           void *target_time);
+ */
+
+#endif /* FREEBSD_OS_THREAD_H */
-- 
2.55.0


