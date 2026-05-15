Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC20CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxQ-0001ii-8F; Fri, 15 May 2026 17:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxM-0001Wl-GM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxJ-0002zV-Ns
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:28 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dca4debedaso351556a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880025; x=1779484825;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XA2VapCdTmhzDnbqx3LnG0YGhwZKj+LcwAtR9i2xat0=;
 b=kHikg3Agwhp871m6BxpcvmU3Fr7FU6rh4bYdjwjSxYWalKJPxZ5k/LGv86QHIZmKs+
 UY4iPXNU61kh5RxXYrc45IM3gbHe8F7T91my4m9zOXwQUriQXyApjR2Cuw2dsDMXB7g0
 d5BGhlx+iLQ/Zitd8spy/vrAyFyJCgNRjKvZvU8ypdH8+xeACCvoxu0qYvUdUOIgX47d
 BT5r9SkZEWPY63u2LFviquo6foVvxfm8//nf+jSnRmdGI1G+lNlIcLDxkz73aEnhsXh3
 aPzS4JGI/H7zUo39COE8Y7ifgMiawBTjHV/19zDliR91IG+MdeB/X1Ol1+cfRcP7jaY1
 fzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880025; x=1779484825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XA2VapCdTmhzDnbqx3LnG0YGhwZKj+LcwAtR9i2xat0=;
 b=CFwDZYJA7YW/pUNLNby7RCCS9hLBsKXXJ76NZU+8LqC29PJ4gtMZWkghPLhWCWs+az
 wPkK2sa4hNcw/CJnYQjE0BsI2tc3EGItiKJBDYAQSRV1NmY/jfNuWXmn+lM2Nhv2SE4z
 7VaOqYBzKcUn9mRFBmw0bKxGQdSV4Ebn6sIabmqdfH4/Mpr37awfKM1Qf8e4So70ICwV
 3aiMmiFl4QeKiLPKGGHPRIWpO7wGcZQ1mm84dPI4Macu1Pporf88KtKmXvoivEbM6xBg
 cIKzfJBQF+KtFXkHzg5+WS9rDGlOH7h6szyrAljvFcVu0dyl53hUzcFAcLhPNx20yqq6
 Ps3w==
X-Gm-Message-State: AOJu0Yy7SqSfwr2aL7qqem6Sk1s0hy/OZNycqdm+zDCUP1d2hzdsdu+4
 qUA/OocVRFMa4kEp/rq/gBm6FVsoUB7B3fTIYROcLjDoqsvjMtPXE/7v81k4hv9USzw=
X-Gm-Gg: Acq92OFQhPkQoTM/yxPQQq9Xbn+E/mYUtV+avwv3NwVGSG3kauXdM0px95GNNpD8I+f
 KgAbyjh3mLa4Zyp3F+otiNA4yy6CSlGq84LtNe9y5dtwnNOmjuwFSTMyFLwXk9Y2k0kTu0KiSSl
 mbKJsmjx8taBWOI72ahDTKbU9emcwl0WW1fW/2NBlo2d1FaqmbhAeEBo3HgHXXxbIH9b38wPyxu
 uiY9YbTxHI1iQEfCibX+/TWSNzJtBJHog3Qf2QJo+cbGqOZnG7FmK5n+1H9gZlZR3PIfO+kGTvA
 /Sodw8u5VROgsc/2vJPhCbvO0Bfr5yY7sJQTZCWCGPSSZDRh0SgPgyHXNJUS3mKU8+jtAPGF18e
 s0AN3UdlJHaeC0bT5Jim2N/Cq/nQYA6iN8mnTCgaDNhzrBRSQmC3wgn0oOubf182Kpnz2isXaWs
 F4lW7Z1AlX3g==
X-Received: by 2002:a05:6830:81d7:b0:7dd:e032:3ce5 with SMTP id
 46e09a7af769-7e4f2bce60amr3751278a34.17.1778880024611; 
 Fri, 15 May 2026 14:20:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:21 -0600
Subject: [PATCH 22/66] bsd-user: Add os-time.c and time-related type
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-22-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11185; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8FJBhfUKzsQG676Z40f+0IZ90MIMLdq8HQ2JCFqGk4U=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jQY/EaDZmhUj66oFmMdAUBy3ymXMMZhF1i
 IazlFA2D7OJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AOibEADXd7PzDvXWWsAxpbnt4LCqQ5/w9YFJ5m+UxqGV09bLi4wudRBvaXeIwoi/b7xP2BzryJk
 2mhRJbNSVfaWXMe+PEC5357cRSd5r4DvaWS0JXN7whu05p44WRaKBq1WYL9TgmvigOBi5lo5vJK
 uXaC7MUJbSIt9rzRdhh9jcXOdCUJJNkA7us1C4tO96Gh7JpyhQpJ6YA/2FTB7pbRwTdP3QuYOO2
 kwC6a+EpWD1/Ltr8nsGzp6aX3yBw1k4eBrfUHR4M6GyBQAMm8bUIcagmq9UhyRe976GA0DcOucX
 oPtZPWp3pTNmHUs5BdK4l4YpkdfDtLM0QAmLofg7u6C5P15lj4x9/xltDCTifrZc5k9Xwl1M0WT
 06gP4FGeMtkT7kHg0SY+IAsxzzLSzhohw9iWuT0P972+odJPjUS1UYEJHrBC1IEm/gGAw5KHb8I
 mPjcmyywmJXmyoI5SRp+ClhlFPou31fGS9rtNRkKYg1yhAP0ONb0eavDL8UJTPYTVawb+I86rH6
 KaIDgXYxjsHKqvRTbN5VPdMz0NIwdKxMtay5iEYsGV3meCdPfKfG4PYS+zs/YR1u11awnKHrqy3
 j+XG8KOyzwEnpHBencb4caFzMUDz8sXAIFD70PfZzwPIoQ8pRzU+KTzmXtuM++bS/dR944J4xhv
 nyd0m+lA8Vs/R9A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
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

Add os-time.c with time conversion helpers (t2h/h2t functions for
timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer
helper functions. Also add target_freebsd_timex, target_freebsd_ntptimeval,
target_freebsd_itimerspec, kevent structures, and timer definitions
to syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   2 +
 bsd-user/freebsd/os-time.c    | 315 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6fbd2da261..020d16fda3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -98,6 +98,8 @@ safe_syscall6(int, kevent, int, kq, const struct kevent *, changelist,
     int, nchanges, struct kevent *, eventlist, int, nevents,
     const struct timespec *, timeout);
 
+int g_posix_timers[32] = { 0, } ;
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
new file mode 100644
index 0000000000..4333d7d30e
--- /dev/null
+++ b/bsd-user/freebsd/os-time.c
@@ -0,0 +1,315 @@
+/*
+ * FreeBSD time related system call helpers
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <errno.h>
+#include <time.h>
+#include <sys/timex.h>
+#include <sys/types.h>
+#include <sys/select.h>
+#include <sys/umtx.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+/*
+ * FreeBSD time conversion functions
+ */
+abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
+{
+    struct target_freebsd_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(tv->tv_sec, &target_tv->tv_sec);
+    __get_user(tv->tv_usec, &target_tv->tv_usec);
+    unlock_user_struct(target_tv, target_tv_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
+{
+    struct target_freebsd_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(tv->tv_sec, &target_tv->tv_sec);
+    __put_user(tv->tv_usec, &target_tv->tv_usec);
+    unlock_user_struct(target_tv, target_tv_addr, 1);
+
+    return 0;
+}
+
+abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr)
+{
+    struct target_freebsd_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(ts->tv_sec, &target_ts->tv_sec);
+    __get_user(ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_ts_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts)
+{
+    struct target_freebsd_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_ts_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(ts->tv_sec, &target_ts->tv_sec);
+    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_ts_addr, 1);
+
+    return 0;
+}
+
+abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
+        abi_ulong target_ut_size, void *host_t, size_t *host_tsz)
+{
+    abi_long ret;
+
+    if (target_ut_size <= sizeof(struct target_freebsd_timespec)) {
+        ret = t2h_freebsd_timespec((struct timespec *)host_t, target_ut_addr);
+        if (ret == 0) {
+            *host_tsz = sizeof(struct timespec);
+        }
+        return ret;
+    } else {
+        struct target_freebsd__umtx_time *target_ut;
+        struct _umtx_time *ut = (struct _umtx_time *)host_t;
+
+        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr, 0)) {
+            return -TARGET_EFAULT;
+        }
+        if (t2h_freebsd_timespec(&ut->_timeout, h2g(&target_ut->_timeout))) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(ut->_flags, &target_ut->_flags);
+        __get_user(ut->_clockid, &target_ut->_clockid);
+        unlock_user_struct(target_ut, target_ut_addr, 1);
+
+        if (target_ut_size > sizeof(struct target_freebsd__umtx_time)) {
+            *host_tsz = sizeof(struct _umtx_time) + sizeof(struct timespec);
+        } else {
+            *host_tsz = sizeof(struct _umtx_time);
+        }
+
+        return 0;
+    }
+}
+
+abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr)
+{
+    struct target_freebsd_timex *target_tx;
+
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_tx->modes, &target_tx->modes);
+    __get_user(host_tx->offset, &target_tx->offset);
+    __get_user(host_tx->freq, &target_tx->freq);
+    __get_user(host_tx->maxerror, &target_tx->maxerror);
+    __get_user(host_tx->esterror, &target_tx->esterror);
+    __get_user(host_tx->status, &target_tx->status);
+    __get_user(host_tx->constant, &target_tx->constant);
+    __get_user(host_tx->precision, &target_tx->precision);
+    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __get_user(host_tx->jitter, &target_tx->jitter);
+    __get_user(host_tx->shift, &target_tx->shift);
+    __get_user(host_tx->stabil, &target_tx->stabil);
+    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __get_user(host_tx->calcnt, &target_tx->calcnt);
+    __get_user(host_tx->errcnt, &target_tx->errcnt);
+    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
+    unlock_user_struct(target_tx, target_tx_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
+        struct ntptimeval *ntv)
+{
+    struct target_freebsd_ntptimeval *target_ntv;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ntv, target_ntv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(ntv->time.tv_sec, &target_ntv->time.tv_sec);
+    __put_user(ntv->time.tv_nsec, &target_ntv->time.tv_nsec);
+    __put_user(ntv->maxerror, &target_ntv->maxerror);
+    __put_user(ntv->esterror, &target_ntv->esterror);
+    __put_user(ntv->tai, &target_ntv->tai);
+    __put_user(ntv->time_state, &target_ntv->time_state);
+
+    return 0;
+}
+
+/*
+ * select(2) fdset copy functions
+ */
+abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n)
+{
+    int i, nw, j, k;
+    abi_ulong b, *target_fds;
+
+    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
+    target_fds = lock_user(VERIFY_READ, target_fds_addr,
+            sizeof(abi_ulong) * nw, 1);
+    if (target_fds == NULL) {
+        return -TARGET_EFAULT;
+    }
+    FD_ZERO(fds);
+    k = 0;
+    for (i = 0; i < nw; i++) {
+        /* grab the abi_ulong */
+        __get_user(b, &target_fds[i]);
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            /* check the bit inside the abi_ulong */
+            if ((b >> j) & 1) {
+                FD_SET(k, fds);
+            }
+            k++;
+        }
+    }
+    unlock_user(target_fds, target_fds_addr, 0);
+
+    return 0;
+}
+
+abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
+        abi_ulong target_fds_addr, int n)
+{
+
+    if (target_fds_addr) {
+        if (copy_from_user_fdset(fds, target_fds_addr, n)) {
+            return -TARGET_EFAULT;
+        }
+        *fds_ptr = fds;
+    } else {
+        *fds_ptr = NULL;
+    }
+
+    return 0;
+}
+
+abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds, int n)
+{
+    int i, nw, j, k;
+    abi_long v;
+    abi_ulong *target_fds;
+
+    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
+    target_fds = lock_user(VERIFY_WRITE, target_fds_addr,
+            sizeof(abi_ulong) * nw, 0);
+    if (target_fds == NULL) {
+        return -TARGET_EFAULT;
+    }
+    k = 0;
+    for (i = 0; i < nw; i++) {
+        v = 0;
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            v |= ((FD_ISSET(k, fds) != 0) << j);
+            k++;
+        }
+        __put_user(v, &target_fds[i]);
+    }
+    unlock_user(target_fds, target_fds_addr, sizeof(abi_ulong) * nw);
+
+    return 0;
+}
+
+abi_int next_free_host_timer(void)
+{
+    int k ;
+    /* FIXME: Does finding the next free slot require a lock? */
+    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
+        if (g_posix_timers[k] == 0) {
+            g_posix_timers[k] = 1;
+            return k;
+        }
+    }
+    return -1;
+}
+
+int host_to_target_timerid(int timerid)
+{
+    int k;
+
+    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
+        if (g_posix_timers[k] == timerid) {
+            return TIMER_MAGIC | k;
+        }
+    }
+
+    return -1;
+}
+
+abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+                                                 abi_ulong target_addr)
+{
+    struct target_freebsd_itimerspec *target_itspec;
+
+    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    host_itspec->it_interval.tv_sec =
+                            tswapal(target_itspec->it_interval.tv_sec);
+    host_itspec->it_interval.tv_nsec =
+                            tswapal(target_itspec->it_interval.tv_nsec);
+    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
+    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
+
+    unlock_user_struct(target_itspec, target_addr, 1);
+    return 0;
+}
+
+abi_long host_to_target_itimerspec(abi_ulong target_addr,
+                                               struct itimerspec *host_its)
+{
+    struct target_freebsd_itimerspec *target_itspec;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
+    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
+
+    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
+    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
+
+    unlock_user_struct(target_itspec, target_addr, 0);
+    return 0;
+}
+
+/* Convert QEMU provided timer ID back to internal 16bit index format */
+int get_timer_id(abi_long arg)
+{
+    int timerid = arg;
+
+    if ((timerid & TIMER_MAGIC_MASK) != TIMER_MAGIC) {
+        return -TARGET_EINVAL;
+    }
+
+    timerid &= 0xffff;
+
+    if (timerid >= ARRAY_SIZE(g_posix_timers)) {
+        return -TARGET_EINVAL;
+    }
+
+    return timerid;
+}

-- 
2.52.0


