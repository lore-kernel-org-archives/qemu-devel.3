Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2204CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hY-00036N-2T; Sun, 21 Jun 2026 00:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hR-000340-3k
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:25 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hO-0005Hv-MR
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:24 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-447046c980aso1585690fac.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015741; x=1782620541;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tlmzIUL4F6F4ICZ1PklXabenJHTG/7qkC9iqTezRffI=;
 b=qlZw0io58Hs1KVxnX/OXmjnQfr3zndMH2DdQISYFFBY6Isirq8uLFAQq/Pq3NQV0h0
 WTDWz/dxL0935OlPk+5uMRG4gtZZFtohytZlWv4+sdClR/0215BzXOBlHxmtGvPXCfUA
 Biit9qoS4yDSNPAieGr4dW4kK7zgIb183dHNqc2x+KdHYFrtBGb/0BtVsOv/PfuYywk3
 qZKnWgrlaoCWgulP42IuhkRPhfQM44zPraJwMvrWSRgMOfBaI4QCv9qnvFxEk+y5imyb
 Sl7JQwdis2lD8KtSusyNZKrSkFO8PSZY6N25S1e9dTMi6DHAcwvV735Vz6/sFibdvjm3
 wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015741; x=1782620541;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tlmzIUL4F6F4ICZ1PklXabenJHTG/7qkC9iqTezRffI=;
 b=H6gCKqaq+tDg+JFPIoiBI8Kg03vBXGg3CpPVxd7KuBtnWzGpYSt2YTAJ5n1QFhJMvp
 yGBYaCdu7+TrBEG6pdxO/bL1fkTp9/wkCS1iFGZZ36iAElpKaZrL5UA+ggGfe1/8LIjQ
 EpTAvSu5z2HNZSjJF7RvT0wHC0DXCN5cx8Ts35rk8fJJTKS/078bgcaXUeA9m1dgQU/5
 J4gEBV5KXbZ8vd5tm0N7LHxdPtNbBHnha8wFXCPru4zVyk/av4qfaBSDKLjgEpzo4H0l
 BP21ZvbS3MRbvPpKIih4Jx0weLmwQgJ/9ZuIAuytJRQapGzvHK2++quODDb7q1mPPyQK
 LclQ==
X-Gm-Message-State: AOJu0YwDwZbSo0W7OKU6SzvFOv/qKSA9ChY7qbczYdZv5G4uEeugT6Xy
 wt2hPyESyTAyqQ4gIwoC0q+1+uoiAIrWCAPKRb4r4vHfBjd8hOdnSSKp2RrT8qtG8v0=
X-Gm-Gg: AfdE7cmC3YgreCixw2OOtl+Xb7N9zVsXHEYd8jMT0Rp6RxZj1xA+oJ5p/B32330z7Ff
 mSv69+3Br81uS78N11k3LaAXthQiEa3eeJHmMhXN51xwtfBzNplBXYim+vYiQ82nxE9rdtobxv5
 S/BXuIkDMG0m1d2P07sQA2nzGEa5xXjRwGpqoU6UDAARJC0NbA4Mi2ET7ms0+VVhqKe8Z339BTH
 A8PZVhOJ81wobUzU9glWWW6ca0liW/+JD08YnRQqj/L1X+5DXzcrtwEK0KRGd77AGzd16ysFbU/
 jWNEVjGkwLV08xMogBc4SyqQd3xYo73obP4hWbdZ3KJHu+BS04VN6vKN+1at6+i/2Cm5iKSbbHn
 Y/iDvs0ARYVsJPwAnDdiQ0cxkSFWPQEosZk4cpnPfU3orJ9Tgzr0LGeF5ZgLKKbY6KR968Ktb1q
 I=
X-Received: by 2002:a05:6820:8189:b0:69d:c3a9:4ddb with SMTP id
 006d021491bc7-6a0d8cc9943mr8214542eaf.35.1782015741091; 
 Sat, 20 Jun 2026 21:22:21 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:15 -0600
Subject: [PATCH v3 28/40] bsd-user: Add os-thread.h with thr and context
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-28-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8528; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=L4ILbGJVV2CdpkkVG6MZp0lbSZ61Qkm2kcWY7Igooio=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aAZOCorbGSHNK09nfft6YnlavU+xR2R2p1g
 VXW6/y+wCyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AOYTD/97BTfZcNF1NE5Beo2FuXOHD0S6fLQWZHsTUTuqI3Kvek85kLLm9hc7hzqnvwnfp+DHAt4
 t5kgHiJ8sT+Db6Tk7bOcdFeNZ/nhgiwPbtLH+J27oBRq2fmzWNBZcQDNqv9JyAQ7f14YVBBoMOj
 twMLYxahbdu99pbqyqYKgwREm4gs7ij4OozmPMFCyI+xbih1erBFABSSrHkGAOLtNx3muMqbqzy
 2I5SQK3wc00cyyRF6raCWAOiRRRvg6l9jouxyziAnbZbFTz0+Sy51WA+zMNBo46Ze2zEFo0sLmi
 XCpOmkcskFUaCe+YaRkJXzy3TirSrH0GYwa4YD1O7ap2bodRnMZK5HLVVic1Rrqfz+F456lESBW
 0b5XfYHL5tDXA06SfL6fAkhJ/M6MVwaP9bzuZrjBc+0lKCmHJVuv5EFYROhUZALDRls7Vu40sTE
 HAj17kJB8cuE86ATRwHV1ABRndac4HC/nRZgrf0ma3q/luIb8XXrgwnCc8nr7qzXI7W8+OtN/Ld
 fBEnRqFuQ7Dh6ymZmBmwJ7yqKOvJHGt7hcHDnU5HVJDRPoPkUSqKmIbbfPsZSls/7IB1f4qjEcX
 oiF+E+08qH/0cnQjuIxSG18fkHD1+YD6ArgJfV2ArsHuf/62A1O3w1kl22LphgVzHD+aoTmiDhn
 bmwRw5jdLj4/otw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x30.google.com
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
2.52.0


