Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D9CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxK-0001Tw-Lf; Fri, 15 May 2026 17:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxJ-0001Rs-0b
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:25 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxG-0002xH-VO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:24 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7df05fc49e5so347712a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880022; x=1779484822;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d0/bJ/fvDzngMRNYmuaXAMSOnqAu7xsnIdTO46mvHfI=;
 b=rRdZupzuU3F02pESBv4r0+IpPGLb8DvIq3XWndE5zT7elNb031GXXRVIB1oADdAU+G
 frW9+lXXbMa9JxK6K0QsyS47GNqVVgk+DggA9rpyBRzfnlIPKivj+YqmO3hp4i3/DPoM
 UF1k6IeBhHy81J6P+glIChrDcczmffjT1CecufAFytOPgE+oiipbJl0fvm/YgO0rBR7B
 Gwt52y9aAl+reOexgC0AHrRQSF4zHwzTWobsTSttexLPY6togTm7pn1E9pM/ubLD9Q7h
 JiJ+mGzCSnqp2ZN9M8kttevbS+qwWzUj1rEjTe4SyZkUdyTzGzur9h29iN/sYNEBKuEI
 R7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880022; x=1779484822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d0/bJ/fvDzngMRNYmuaXAMSOnqAu7xsnIdTO46mvHfI=;
 b=BpWBM0q22909M7WGxrg8KMrRy0HCebx/Keq/pkFokPx/vA1az0xD9FyQLbrTvfjTTg
 R0u0Kr/lvrWhwTeVbk8UZSC1r2xPgP5y197xjG/Vr3XAIUx1Ocp3jKKvnK4LVsLzJSMH
 gejOg9lY+DBwtu7gv1b11uwiFlrFOj0wXIK/YfCEa0klSW6Iq3VPmVHsyMU3nED5PJ3o
 D6qZen0W1UjuXT5LO9N/WNVqZFXbEbBTRU1JPjycGOo9NkjgSvgxPcf0YgOCpLeoM+nU
 csbj/fGLeCsjxmLBjLErdYNYXmNXLx9F6nWODeZAuSOctm/z5xlmFgWQHCdndGHH47Nm
 ENFQ==
X-Gm-Message-State: AOJu0YwyChBkOaDGDZ+x4Pgi0L8thOKOLHyLj2oIa6i+IBS1h2CkJ0M8
 srRbU0RmvHGTcOkt6MlbOMnbM/5/zQDgYmnCLQOudITm1jEaDPyG4FuEPRXBAs3q1sY=
X-Gm-Gg: Acq92OHM/Sn3XoE3/0Qsy5FMLiqO10kdxPcNZoUNgQvHPjnbQk8sANXDKiOgkvS4eTM
 AGjeC3lyalwFINePuGv4AR8T681Cx0mM9JsEL7yTVAXrcJ9CUBXrVX9OeWAOibF7SAQB+bQ9pf+
 j4ObCL7pi05nIVelrfLltAFx5TWl2HXYEQ10+BASHBOBqlOSxx1CccUkDgT3dTCNRotK9ctMM5F
 qrwK9i6hA208z36CBjiPzAOjeDPKBXLYsSpDhqmxRf17xwXhWuV3aFNUdEthuYIkNcVwpIb8uhu
 cictwiXJVzQTpg/GuU8aGmuq8iPTrfOy+LUXPgkv75DNPbAY/4MCbA1soDNFubA6+jgioWIHNtO
 AzG2jF0hVx3K8Y8nRlytWMJUmVM6RaSxBJvBCmauvdWf3F9JVN4Btcr1hz+O8NT+6NuSwlUf4TJ
 8x+kHXFk3lVC1eHtTGJhLc
X-Received: by 2002:a05:6830:3688:b0:7e3:9d19:1e47 with SMTP id
 46e09a7af769-7e4fa0b04bcmr4354925a34.25.1778880021763; 
 Fri, 15 May 2026 14:20:21 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:18 -0600
Subject: [PATCH 19/66] bsd-user: Add select, pselect, and ppoll to
 os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-19-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6810; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=hJ5CDrM6haAQECdrugV65nZzHU/y17UdE/xwfIVi3MU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jde8TsRLqAaGG9dmScuNjoPkRNNZ1v/xVS
 bOVZ1SjMbKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AHJeEADclKbk+98LPJEDnWAnsdWhV4cWaa3NOjdfWti2wOp1S/N2VpYanBdEJuyvqDbKOQMgPud
 0hgtfP8CEo9shaQO6rRZS5sq3qYGIjkSNVutC78yKKvmY2YspllYUGiGBhyc+Tg9s6nLIl+ohqt
 zgu2QozJrI/ac/HlpmiDCQN4QBoMHIsOFwlQ7rMFOIaDwDaydR0hkEB2/TiwxautU+EBRO+qyqM
 momrPtpXJPe/MrRvepvTeYK4J/BqM3Pa0yqOvXAUah7Im0v+235ZH3jH90k7XLPumGkvZnrzUuk
 O5CBtiyr3mzeiVnPv3cr7GXASryvnu6T9hvo50wCSa6PJ0pJOTRxBimVkwjORys/2TdUae+350N
 R3EHiDYuuSa4LNIhib9LXa2OTKBpunITmH3mFQAlhPW9NTbM83ht8vnmSnW6yxyZNSNNSPg4nMh
 OrsciHVFaALhaluXPe8PqPFiuYeQAnAPfxy/J7MNz0PKDiLe/zZcxxC3bFsPLxWM2NJHc3g0dgC
 REUbfblH2XklrkV0ek3OChdhRwpdpv9woL6kI6voBOQAhkIGQCchgRMDma4JmhnS7YnPGxysmx6
 QpcZtbepemIkFr7U/3AZwcGeh2eYrMsFfuN+LXemFVoFVI5lgWB/2DJHJEvumvnnskfOtcVyHvq
 l34sgCrA+EXu2DA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Add I/O multiplexing system call shims: select, pselect, and ppoll
with proper fd_set, timespec/timeval, and signal mask conversion.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index f1f8da90ba..51f84c31a1 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -427,5 +427,207 @@ static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* select(2) */
+static inline abi_long do_freebsd_select(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong target_tv_addr)
+{
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timeval tv, *tvp;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (target_tv_addr != 0) {
+        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
+            return -TARGET_EFAULT;
+        }
+        tvp = &tv;
+    } else {
+        tvp = NULL;
+    }
+
+    ret = get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp));
+
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (target_tv_addr != 0) {
+            error = h2t_freebsd_timeval(&tv, target_tv_addr);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* pselect(2) */
+static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong ts_addr, abi_ulong set_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    sigset_t *set_ptr;
+    struct timespec ts, *ts_ptr;
+    void *p;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    /* Unlike select(), pselect() uses struct timespec instead of timeval */
+    if (ts_addr) {
+        if (t2h_freebsd_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (set_addr != 0) {
+        p = lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, set_addr, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr, ts_ptr,
+        set_ptr));
+    if (ret != -TARGET_ERESTART)  {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* ppoll(2) */
+static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
+        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *ts_ptr;
+    sigset_t *set_ptr;
+    void *p;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+                           sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    /* Unlike poll(), ppoll() uses struct timespec. */
+    if (arg3) {
+        if (t2h_freebsd_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (arg4 != 0) {
+        p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, arg4, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
+    if (ret != -TARGET_ERESTART) {
+        tstate->in_sigsuspend = true;
+    }
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
+/* kqueue(2) */
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0


