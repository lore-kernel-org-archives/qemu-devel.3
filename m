Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A33FCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxH-0001Om-M9; Fri, 15 May 2026 17:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxG-0001MV-O0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:22 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxE-0002x1-SI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:22 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7df05fc49e5so347679a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880020; x=1779484820;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RWzXl8z0F0/BpkJkUiOb6BsTfXQiEc7EgS1wk+2asw4=;
 b=mu/Wgx+93vkVu3YSwYnYFYFIAXo3PP8ow3rFafLrd3E99+4NR1BsoAW/ZRw8iqk05g
 T27NWezp5Wj/oGuxsH/bdb03fCvcEbb2J98zx5ZGyvoP0CO4ER6Enbx23H/Hfv3OjaPT
 AwhMuV4RzUqJLBkXv1zxdMpbqLR2p81edPi/mYv2QLOf6ZmQQM5meY1zoX26q8UPp29s
 hgo+Zd3C+OhVVADAUEyzUALIvdTjPWPaHyM+USdRZ9SBXRt47OKFMwtQ5ZbA41WwHR17
 IPKS6uZApGXygE/VTn43NUhTYBDyoUkqN4fhl3TaEodHNNPax6shJZaeZVgaq0sOfiWD
 o5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880020; x=1779484820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RWzXl8z0F0/BpkJkUiOb6BsTfXQiEc7EgS1wk+2asw4=;
 b=Prp8f747lfaP7DDCZRDzmuQzHOcnRAQhZueqnriWUINPpHvD6cPZqkEtqvBde3ssP0
 5ew8TFeZmB8OuNWQl/Uv+X8s+ptg/6cx827HpFqI6BleukQ5NFnJ7o+R3S66BpdEF8tf
 POohXHgMwgawwo+G6y3MNuPkCjj89+88v0bkqwYVXTZobQuUmYxu9vJPD3SNCc5ofR5D
 DKE6aTXoITFp5qyLf+2j/uxRtjz1Xb52uFVyTct4vxnAIl9bdfOeRyxna3XLf+6HkYr0
 vVvxWt5kmeXEEPjlai11d8J0AWAKZtT4wcITCaVFhCIu73xCW9p9KAeNLVNDe7GiKBqO
 UJZQ==
X-Gm-Message-State: AOJu0Yz7X6fKHWAhSfWvx9pO4yogeJTXTy3aq0Yiu1Wa5+W3342RX3n7
 qEh9IeLjkwWlqktja6X/Wd8oKUZUbkqtHKbh5azOkxT1FN3IZcvOMNY8Np78A5g2Hyo=
X-Gm-Gg: Acq92OFhL//FXHjGwYssY81INDht6BSwL6OymYMnIyvpavqtiZscfwb68PAbcBvRgTG
 xAyZAh5FWG16/XOk7xcZBlh3VXdKq6GcGtAPoRJx3Q+v3sjmiOMfxplTSpe0YfQ/tJipYg3YUzw
 jo6ye+gIAxvbmei0ypxqQkxj3ETcSoi87OxGozAur/kAf7UbFgWDAITCNn/sS8nxeugmKRk4fhi
 oM968mqDZtxG1K3IllPdoupTPeJnL6kMGDRpLcqdqtdNeOiMu68UepGDLhCQL9yvz2Ev1AaNyQx
 Bk9+wqhDMqWeVJHp0wX05uHX8LsfIr0hwqgF+nOiify2tznIPpMg7l+mm4QPzGyyjsibm5t4CAe
 D7Fq6jMBx4odqnxI9U5C458BPLPDGvVCz/bfRh5Pm8JD8uiGbdc+ZpH0jL0+O433nkH/XLIH8TS
 tO2h/ZJSckyw==
X-Received: by 2002:a05:6830:3805:b0:7de:427d:34ba with SMTP id
 46e09a7af769-7e4fa0497admr3928159a34.19.1778880019683; 
 Fri, 15 May 2026 14:20:19 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:16 -0600
Subject: [PATCH 17/66] bsd-user: Add os-time.h with clock and time-of-day
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-17-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7787; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=AFlGlSLn0rd8kDgFR6S0jI8BaOlmMLpM6WEIvrSyrmk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43j9wzeSq4ycwysNfP1boQNIPT5I/sNeKnmk
 bcxIiBZjQ2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 ACzSD/9/MNwoCgAER/Sw3d9dW92AGHN7eH5pCEHquDET65iIsoQKpbwexk0a72mDCbMdT7leOLz
 Wn3ZaQWI9KKsAki/SnhkoE+kj1HViaq32hKb1xBtx5xkEPuKcDfe3hB78h00np9zZ2xmauOHiXu
 urvWOeogMte/wGeGjjABdgFxwSNBO9LhFqKwO/w2Lnb1fIwTFY269J99Ry0wUGDN60NfXR6bG2A
 OABZaxJKNfFO5R/vFDs+cop7frn4WNFnIOxu/Vht9ocGelHHJ1QQsAk8etYpyHgoULDnoFaE3pk
 /iZ9IVVBgPZQ9q63KgkIfhWvhcSqZ/3K5UI1jLgzosIJKmrdZHKK2zzAcQ12ee/FCX1u0yor/UU
 bZ25qHn8KRG9zUzPuBVym1LKUvvfAFrFAaJLrRq2k2CQ8DBRINvvNJSPtDuK5stffTYVg5wHcWS
 VgvK8PrKfqXRhmTj7ccZmw/PefAkU9YRR/wyZ+B4LTGqfXeqGE4PePYde4B63JB6s1VyBnhyUM3
 WInHaNsVfMMQ//oU9UnbJfrzitBltR+N9I1EjPZBVRkSdk5cNvnlooAPKJ//Jt51UvokXhr++U5
 RDmF6U5HFR3hILC8pkUQfh9AT1YcBa+rQZ5ezz0m6beM2RQanI2op0D6v8avWtKW4nRGwspizCF
 V9uvfiLW//++AiA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

Add the first part of FreeBSD time support: nanosleep, clock_nanosleep,
clock_gettime, clock_settime, clock_getres, gettimeofday, settimeofday,
adjtime, ntp_adjtime, and ntp_gettime. Also add safe_syscall wrappers
for nanosleep, clock_nanosleep, and kevent.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   9 ++
 bsd-user/freebsd/os-time.h    | 221 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5d3a66e360..6fbd2da261 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -89,6 +89,15 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
 safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
 safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
+/* used in os-time */
+safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
+    rmtp);
+safe_syscall4(int, clock_nanosleep, clockid_t, clock_id, int, flags,
+    const struct timespec *, rqtp, struct timespec *, rmtp);
+safe_syscall6(int, kevent, int, kq, const struct kevent *, changelist,
+    int, nchanges, struct kevent *, eventlist, int, nevents,
+    const struct timespec *, timeout);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
new file mode 100644
index 0000000000..bcc1a826a7
--- /dev/null
+++ b/bsd-user/freebsd/os-time.h
@@ -0,0 +1,221 @@
+/*
+ * FreeBSD time related system call shims
+ *
+ * Copyright (c) 2013-2015 Stacey Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_TIME_H
+#define FREEBSD_OS_TIME_H
+
+#include <sys/types.h>
+#include <sys/event.h>
+#include <sys/select.h>
+#include <sys/timex.h>
+#include <poll.h>
+#include <signal.h>
+#include <time.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+#include "bsd-socket.h"
+
+int safe_clock_nanosleep(clockid_t clock_id, int flags,
+     const struct timespec *rqtp, struct timespec *rmtp);
+int safe_nanosleep(const struct timespec *rqtp, struct timespec *rmtp);
+int safe_kevent(int, const struct kevent *, int, struct kevent *, int,
+     const struct timespec *);
+
+int __sys_ktimer_create(clockid_t, struct sigevent *restrict,
+     int *restrict);
+int __sys_ktimer_gettime(int, struct itimerspec *);
+int __sys_ktimer_settime(int, int, const struct itimerspec *restrict,
+     struct itimerspec *restrict);
+int __sys_ktimer_delete(int);
+
+/* nanosleep(2) */
+static inline abi_long do_freebsd_nanosleep(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec req, rem;
+
+    ret = t2h_freebsd_timespec(&req, arg1);
+    if (!is_error(ret)) {
+        ret = get_errno(safe_nanosleep(&req, &rem));
+        if (ret == -TARGET_EINTR && arg2) {
+            ret = h2t_freebsd_timespec(arg2, &rem);
+        }
+    }
+
+    return ret;
+}
+
+/* clock_nanosleep(2) */
+static inline abi_long do_freebsd_clock_nanosleep(abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4)
+{
+    struct timespec req, rem;
+    abi_long ret;
+    int clkid, flags;
+
+    clkid = arg1;
+    /* XXX Translate? */
+    flags = arg2;
+    ret = t2h_freebsd_timespec(&req, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(safe_clock_nanosleep(clkid, flags, &req, &rem));
+        if (ret == -TARGET_EINTR && arg4) {
+            h2t_freebsd_timespec(arg4, &rem);
+        }
+    }
+
+    return ret;
+}
+
+/* clock_gettime(2) */
+static inline abi_long do_freebsd_clock_gettime(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    ret = get_errno(clock_gettime(arg1, &ts));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timespec(arg2, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* clock_settime(2) */
+static inline abi_long do_freebsd_clock_settime(abi_long arg1, abi_long arg2)
+{
+    struct timespec ts;
+
+    if (t2h_freebsd_timespec(&ts, arg2) != 0) {
+        return -TARGET_EFAULT;
+    }
+
+    return get_errno(clock_settime(arg1, &ts));
+}
+
+/* clock_getres(2) */
+static inline abi_long do_freebsd_clock_getres(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    ret = get_errno(clock_getres(arg1, &ts));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timespec(arg2, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* gettimeofday(2) */
+static inline abi_long do_freebsd_gettimeofday(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    struct timeval tv;
+    struct timezone tz, *target_tz; /* XXX */
+
+    if (arg2 != 0) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+        unlock_user_struct(target_tz, arg2, 1);
+    }
+    ret = get_errno(gettimeofday(&tv, arg2 != 0 ? &tz : NULL));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timeval(&tv, arg1)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* settimeofday(2) */
+static inline abi_long do_freebsd_settimeofday(abi_long arg1, abi_long arg2)
+{
+    struct timeval tv;
+    struct timezone tz, *target_tz; /* XXX */
+
+    if (arg2 != 0) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+        unlock_user_struct(target_tz, arg2, 1);
+    }
+    if (t2h_freebsd_timeval(&tv, arg1)) {
+        return -TARGET_EFAULT;
+    }
+
+    return get_errno(settimeofday(&tv, arg2 != 0 ? &tz : NULL));
+}
+
+/* adjtime(2) */
+static inline abi_long do_freebsd_adjtime(abi_ulong target_delta_addr,
+        abi_ulong target_old_addr)
+{
+    abi_long ret;
+    struct timeval host_delta, host_old;
+
+    ret = t2h_freebsd_timeval(&host_delta, target_delta_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    if (target_old_addr) {
+        ret = get_errno(adjtime(&host_delta, &host_old));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = h2t_freebsd_timeval(&host_old, target_old_addr);
+    } else {
+        ret = get_errno(adjtime(&host_delta, NULL));
+    }
+
+    return ret;
+}
+
+/* ntp_adjtime(2) */
+static inline abi_long do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
+{
+    abi_long ret;
+    struct timex host_tx;
+
+    ret = t2h_freebsd_timex(&host_tx, target_tx_addr);
+    if (ret == 0) {
+        ret = get_errno(ntp_adjtime(&host_tx));
+    }
+
+    return ret;
+}
+
+/* ntp_gettime(2) */
+static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
+{
+    abi_long ret;
+    struct ntptimeval host_ntv;
+
+    ret = get_errno(ntp_gettime(&host_ntv));
+    if (ret == 0) {
+        ret = h2t_freebsd_ntptimeval(target_ntv_addr, &host_ntv);
+    }
+
+    return ret;
+}
+
+
+
+#endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0


