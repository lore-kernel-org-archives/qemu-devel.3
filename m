Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D712CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vr-0000kv-LY; Mon, 18 May 2026 17:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Ve-0000VF-Tj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:22 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vb-0000Xw-IG
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:22 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e55b95ba13so1605361a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139698; x=1779744498;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ldcai+Sh0yZjHsZmgqYAlRKl+2d8wfQPogMXY1nKO5I=;
 b=UVBQatX7214MorA0wIASWwRKNILVACAG/JK5tlNaMcGAWrOXuxLSzmTsKX2oLwxcUo
 dQ8Mx4OepTNq/y05ojpSpSd7D8hD9YKmDIGea6fMEtpFFtGEYTh46HwbxyL+33RdMZfN
 /xTOc1o+WwyxGHIIeci/Cn4OcaTeIfreMMQTEVqgf4ugfh3ytOqESCdaos4ES4DRJDwa
 sHul513X3gqFE/QN/UcCJJNWLUcB4SIK6H7tDSNPmFxXTPnFc0iSLAUYaMTGrM+lVWU4
 FCEHJU9r1mFiQKY6lNF5jUirqLHhWUSpPo5wsU9cADL43+YCyxJY0eLJ85xnrG9N+7wP
 ZpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139698; x=1779744498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ldcai+Sh0yZjHsZmgqYAlRKl+2d8wfQPogMXY1nKO5I=;
 b=BzvdKKZQvxK3o3k4Mo8mow0t0UAMTmirCHhLSltd1M/tfN5FShsNY20C7636P8Pzhv
 BTqdWr+PCG81n9/hTfGuaAtbAl6oX7atmSoCe9ggM1KibqMTucHdeJ77ZtOnpI+H37OE
 rRRvSbweNPWRTggUcm0JiM/N8b82fqnHAVcJxXQRLxQ2C8z7Fagt/HMjK4rPd9loOf6k
 B6WtWDi66D1+Vyt9XAZPGAYAPuEbRQaWnihLv73ayalL0cnBGLfNo2Vs+mXf3wqetf9Z
 xMNllFw0A3VauJuIMXVtw3x6hrL2ij0kZD1NiIr4mOX9yKrzVB0NI85cqlEx9pXMTqKv
 QVew==
X-Gm-Message-State: AOJu0YzxiAvwjT3AqUwDTgTzkQbAMTsDu+THDp6hR8Tu8RY0LSXegbE5
 jnWTIkp+6hMgKUJvR0iARq/FrCLLFa2KabWz2RhbNyKsOkL4ywVbDMSbODiujbBjvuU=
X-Gm-Gg: Acq92OEDEuVq7HM7Zwh26T6+FSb7b/7vBAmsUoRxn2XLuAoVQmZL6XpLRMrlZ6jmyYk
 5WOJ0WaN2UfjopsL2dxs/8O/nMGdBMUJRdPadQiUmaBYySt4WA/t0zRHnt11CBUQM646oB6DwbV
 r0uwvQbpX/RNqH2AHwDMWkLRjeTXkH3xBy+7hHE3ZWdcw7OOSnrGW8zOqUfwrepyIxc6R9SEDtH
 CxskQn2B8tBqzFo5yLOrO0gLNMbuDYvwZw7sq+YMLj494jgyTxG24MzumtpRQ3lUIEVxacHuIcM
 lINmy9cAmfLOpI3xNKr2Ady6YVupgYC1v8vAvwDry/Gx0ddJdYObdK/yXDFU4jaPPfDxTbGWlyo
 kIrn+rNb+UkyWPDeG58qidBme+dh90tFzQoIHsND3NFCPa8dEHvqC8mPqD6U68qKjJpuDajua5Y
 8oxnPKLUSOz9GSudRpHh52
X-Received: by 2002:a05:6830:6995:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7e4f2b8bdd6mr11443163a34.15.1779139698499; 
 Mon, 18 May 2026 14:28:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:44 -0600
Subject: [PATCH v2 26/37] bsd-user: Add os-thread.h with thr and context
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-26-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8532; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=sb0rse5R0BhLV4cqBE8oVJE9gMbfncsjbjf2mHN6Geo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RIm/169DzExGNwn+xvGlhm3gfrCGDQ1v6Gl
 gQYEb8+gEaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 APdAD/0ST1M/khobsfdlUI5fVdn1khAW67p62ZZsPVRceb0ikYZO0RBBjj0QP7WyPHjT3viIvt3
 Dh8sjmRVnbmm+w1nhTKo0qUFAndHKuGRvy0tYU/QRcgy/MYG8Je2Mvhyskkxqk5dx32Gg/+gJyo
 xeYh4TCHpVBt2+5xbeeK9fUpymgOuJquJzWy396USPtBcq2LhQzj2+bgMujVnP1+S2J4V/osmaL
 3xOZpWFdYiXacYYzfGT4rK9mQYnnyvSjHeezODJs46mmMvrtqkF9Z2+0YAEvhbTwnNVOdVJfQMv
 S3CC2Q31Ws/OEYNZz97LeoHp+FWWBoFC/pQuUxlxaIkgJpq0ohhyCODXIWmSXu8vRxQodahNpLd
 06r8UZHKkdTiiNAiUCE7RR0Lmzha4gygeyaY1LEBlJohy2NkqIfqnw9XkhLiGdNBCXptlP0W3es
 l2otMKpCSROTW+7X+fRIA5rC+nyllaIYagq+f9rtTUWpOZ7tCoUxVzJ8Np5PkgeznHhHZzJi+Km
 mWjBhADV2L0J3sMPn9zH4yYBz/M2rH3oUVLbp/ysivZfz4NBPlWldI/h8emb/M4CmxbF3QDoMDB
 I9ShOxkNvZ/XJkV7nf1dM78uRdKulIfaoiw0r6c+gO1FkvOtf7ZKN2/ilhuClvYoxoYPpoRdqLz
 Jor+UZ9jDc1SrVw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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

Add thread management system call shims: thr_self, thr_exit, thr_kill,
thr_kill2, thr_suspend, thr_wake, thr_set_name, rtprio_thread,
getcontext, setcontext, and swapcontext.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   6 ++
 bsd-user/freebsd/os-thread.h  | 244 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

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
index 0000000000..bb8f279060
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
+            return ret;
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
2.52.0


