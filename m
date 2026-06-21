Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21397CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hG-00031P-Nk; Sun, 21 Jun 2026 00:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hD-0002zN-2g
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:12 -0400
Received: from mail-oa1-x43.google.com ([2001:4860:4864:20::43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hA-0005E4-EK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:10 -0400
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-43d3a0dabb0so2244844fac.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015727; x=1782620527;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/w2l1J64qfg21P2/IVcoiYALy0cgARIS1Qjr30kbu70=;
 b=d6+wJ+DX+4zY3AdKQLy/HoLD5k1Tigh1aAmusoA2iB3sFusn2whfHvSjR/Tw0Ro+kL
 oe0EBpJoYr91ZG7bZAQcQgOvqXUUKCfUgHUcjwTeSRD9PjjZKUadaV64ERiBuuQLN0U8
 gufFWW4/j/58UTx8L8bWnFwhu0J6cNxdzkvSQz1yp1Nw0Tg9BuHAj9MKeXLSUvugFZAX
 rQTik16yL7EKklFAT/9tNRpnap9kG9WbVXVdnBlHnKn8npU9DZuCtqCIMrNrVVZJcin7
 mh7Jr6CF5WdqSRtt4OWW77FpyEVv+Pc0eGeF1tAlSPh6AK8wr5d3v88BOX6/pWvh5PRG
 tCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015727; x=1782620527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/w2l1J64qfg21P2/IVcoiYALy0cgARIS1Qjr30kbu70=;
 b=QULwRORm4lUJ5zL0xAv1cTg4ZSl41YdPW7ZxgCir0G7zgYcL//wufJxLvepuHVyGN5
 8HZmtChLl3RPVt+mP1FkhnKn/PbfC9udx+YPViT/McYE22dA1xwRd3WmD6lh8/I4wGkN
 nehr+gloUadxMOC4XSaVabfb9jjUtP6st35MEHBlaZQzbf8iZIRYwtQdFwokf/xVeABr
 dLmgfb0FhxC5oGGQTMj/tjhk82tvCvRcHBW8a2CTlKsTd7fxWTUvEOjSBUWnfDk8jTvh
 DT10e9o7yztUfDDr57PmKD+jY3lHCUPidDYDaoN++XBDI7z+UCl980XYxtUZ+b9fLJc9
 +OwQ==
X-Gm-Message-State: AOJu0Yz4SCdIWK5ZQusXgP6l0NON0AL33zv0RWQ8+ho8u0lwQnZh1NgN
 P9nNGimrKr+HofKTN3XZZQQg2+Za+PqVpmbaWnAOnV7QNH+KrGoDnEeKr9xTX26LaL1KL0aelzS
 Mk/qnT9xNZfmU
X-Gm-Gg: AfdE7cltdwaG/fG8kKVZsUSZ6t/0HnbWOGCQcYZjpBaJbLbR+vehKRdJofxmt2/M/QD
 utw2k8JmopmjSIAoZAreS+wf5XIgYoJfsFqEVQkp/rZzY1LzpTRKPV5BPm+lLIO3FiMXcQf7sx3
 xJdduvMQhsu3xPYoYMTfLIJdFxaJ4Feoxstm5mCQ3EThLFpbsj11/Pwm8IJUlxmnhDxwUtgGc8X
 dUABc5QCxN/PaYujUFnZamTu0YM/gBvcjaBuWL57GdrGbv8WDMxamPQrRAF20Fv5LmMKS3Sc0td
 KPednFm50huncZYO4rcRRh/QtlSvoLjPOESxO1KQJtWVAqWBMi4U1rphsi3fJRpJohNwGxyClic
 tAfg1arc/OwNCBs0LxtUFh/4gQntaoWq6ETuolu8arMBgckopJgsJc/jtagT19ofCsmpDWsTrTa
 Q=
X-Received: by 2002:a05:6820:88f:b0:696:17a6:c06f with SMTP id
 006d021491bc7-6a0d8d94badmr7660494eaf.12.1782015726667; 
 Sat, 20 Jun 2026 21:22:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:06 -0600
Subject: [PATCH v3 19/40] bsd-user: Add os-time.h with clock and
 time-of-day functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-19-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7998; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ELfPXFxSrTKKfO8VRBS4dJaUcu7uSG5piMSKgxBy3n0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/1fWG/OGVAXwuBRBKm9FDj7VY57K0nX8bK
 bUefFAGdTuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 ACcHD/953asvEm/bKugHSUoEqlbEYObbvDdfT50OKSQfZB8+aIwUBt1FdOqkmA3rYjchdLlWBpS
 RlpPZP5FVrgfG6sVlEHGHMAer+Eo2ewhsxKOLNDplTs7AwfhVKVtPCdV7E/cD3huFVtoF2s/BYr
 PsVL1TNKijXtYUPHz/Xh+JrsyeuQO45lc/njSMW7ry8BTDY+1RZHO5IspUSTTC+edj2lGXDXRaE
 hTsDsOUXsW+hTnAIDI9a4C1GwBn4ZCa+RzRAl4CSge4WV7M1wsJI4EWU4hO83E3MFZSjIYPtiXi
 HM5aUn2cvJqf3Sw74lexsJ4Mmf/Def+JRMocKVBSniUDK1cXdxYZ7SLt5Q7T9sdC8MlJbNZZ1vA
 HRCx3ys69ULlcjrlRkbDRrcG43XAfNIwr1/01mODAFWsdVf9Dz+R/ijBkIjaNMya19Ls4HaFXvU
 Jc2PLZu2hUQ3GdVMdydGOjnObVtXjVRATlZsmi3ufDGbFWFF6xTynPlcVQfOLse6KQ6qY7lUdUN
 8MOEw++k5foqHxXgNJ7ipjThLqaJdLPiyhKySUcc4kl+MPKFu/GbSN5JE+1CH5sFEZ+LqILME3b
 agmqBIGbX02iso8ubr+bOSYZPlUEHVwHkalM5c27QWRvAzXntPbh/cCiMo744/xndKANZ0AQzc1
 IZZA/JiJluQWC6A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::43;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x43.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c |   9 ++
 bsd-user/freebsd/os-time.h    | 225 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+)

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
index 0000000000..e387441d86
--- /dev/null
+++ b/bsd-user/freebsd/os-time.h
@@ -0,0 +1,225 @@
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
+            if (h2t_freebsd_timespec(arg2, &rem) != 0) {
+                ret = -TARGET_EFAULT;
+            }
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
+            if (h2t_freebsd_timespec(arg4, &rem) != 0) {
+                ret = -TARGET_EFAULT;
+            }
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
+        if (h2t_freebsd_timespec(arg2, &ts) != 0) {
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
+        if (h2t_freebsd_timespec(arg2, &ts) != 0) {
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
+    if (!is_error(ret)) {
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


