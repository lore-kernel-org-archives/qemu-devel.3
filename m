Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE15D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3Sf-0005ST-L5; Sun, 11 Jan 2026 16:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Se-0005Rw-E6
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:59:00 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3Sc-0003uZ-Pc
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:59:00 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso42936105ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168737; x=1768773537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAbrBW43TSmdFxMsFe0oqQvzIcATowrJezfs7xJvcpM=;
 b=hO7Z2WQtQHmumGYzYo4nTDKTxzrxLg8NZLw2mfMjytf8eb6ikB0RGczog5kIoq2H00
 AVRNxt+ut3S/+VL9003ZRooLVxZl65zKSruKRWrADBdfL7BXJfQ60yO5UwYyUW7ExN5N
 hSt5pG3R/0sKnXCsv2HZ5adc1JKXfVjxk7T9wSEgrfuhovDJejzDWB4IoNKi6ce+7vQg
 dxJJydbaATV0vzIDpx8tp2bUSQZLblHPsGYrzURkB31lAeakavpuKlnICDE0IrB6geoR
 pheAr+p+JrprYtS+or4TmtAzSjjUkiDbPcijy1wBnze3cZZINveTlnB5Lego1oygeMbD
 6ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168737; x=1768773537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gAbrBW43TSmdFxMsFe0oqQvzIcATowrJezfs7xJvcpM=;
 b=ZcfxsQlLwaYu6Hek30DV9+ouCbhZyAXkER0UbBUjgrcdymdw9HY6wG3Jy8yA7pT5u4
 j4OLbR1mDhWLVDo+7xT0omAhH0ttYqtg+t9BW/V0Y/gjnk7I+6k4Xi3Bh8nJUImdrsou
 IEORh3SXe58yC1Rz88DJ7QBMTOplw0R42Ecuaz3mEAFBoTzgAF+Y1gTxfuSEQNARr/RQ
 sFIadfBi51LWPHEyavhCWcwjkS53lHkUz5K+CaxJRxmRAiQ53y/v2CkK9W8tMCp+Q9ei
 7nxhIMk8itAd8r2oSTfqpA9N8iEqcSzZs0PelT6BtEiRlMcPPYZGEM1QK378LZzGnnVY
 XbbQ==
X-Gm-Message-State: AOJu0YwhzsD2eetLU6UZG3xTG2GAphJC65j3uz/KT/9Dq/p4YDmi++Za
 rPMnPQpHL91d5PrXTF+LySW+gqt5thAryjECTL72o7did2M2udA0gL9pFoldncjPdJb0HaMGDtz
 7PE0gUWk=
X-Gm-Gg: AY/fxX7AhbEpghEHGDQhPpwIEoS0L+pZuQujnxXqf2ldoMZzhnYDeRo06uzLT59p8Z3
 T2Lm4vDQRtW1BnLly6O9EHDh6i5PYgnzEz9C5HhPJebljqMP3w+tOrOm8ER04Rn0SOjMEFHBUDq
 o+Ez/CVW7VUdrR9PywrkMGwp8Iw0igp7AyViGynlDfWsLim2Apy+Ytxu0xAVcNBrE76CkMA82IL
 P82+YLnW288hvLyEmWDxlY7R6byugpGQqhcKeVBzp1ouQDdc8N4G24QpVdV6PG/F4njn3Y4PlDK
 VvVRlSe+O/GD4u0mpCp+j+EiPslDvbhBUx2Ox1/eMgJ6E2dgV1M05uMbH2gyaBhI9z8dqUOPbME
 837blbf9c64K+MyB0efitx1gxCJwbYDs/4PEk/VltIIFXERKyAUwPNdDp3CkYgd+ZDEnRmnLbBt
 fPazjax/tjLz9SF4U=
X-Google-Smtp-Source: AGHT+IH1Z1uPxFEsP6S2TCuDvgVH2JD08gvE2cd4dXJhYGC6Y/jlHt8agLvhRRWbBdacZT47fl82Pw==
X-Received: by 2002:a17:903:3c2f:b0:295:586d:677f with SMTP id
 d9443c01a7336-2a3ee4139acmr162412705ad.10.1768168737292; 
 Sun, 11 Jan 2026 13:58:57 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/13] linux-user: implement epoll_pwait2 syscall
Date: Mon, 12 Jan 2026 08:58:17 +1100
Message-ID: <20260111215819.569209-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

epoll_pwait2 is the same as epoll_pwait but with timeout being
(a pointer to) struct timespec instead of an integer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3210
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109090937.599881-3-mjt@tls.msk.ru>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2c7e1eb5b2..67ad681098 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -708,8 +708,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               size_t, sigsetsize)
 #endif
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
-              int, maxevents, int, timeout, const sigset_t *, sigmask,
-              size_t, sigsetsize)
+              int, maxevents, int, timeout,
+              const sigset_t *, sigmask, size_t, sigsetsize)
+safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, events,
+              int, maxevents, struct timespec *, timeout_ts,
+              const sigset_t *, sigmask, size_t, sigsetsize)
 #if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
@@ -13623,12 +13626,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_epoll_wait:
 #endif
     case TARGET_NR_epoll_pwait:
+    case TARGET_NR_epoll_pwait2:
     {
         struct target_epoll_event *target_ep;
         struct epoll_event *ep;
         int epfd = arg1;
         int maxevents = arg3;
-        int timeout = arg4;
+        struct timespec ts, *timeout_ts = NULL;
+
+        if (num == TARGET_NR_epoll_pwait2 && arg4 != 0) {
+            if (target_to_host_timespec(&ts, arg4)) {
+                return -TARGET_EFAULT;
+            }
+            timeout_ts = &ts;
+        }
 
         if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
             return -TARGET_EINVAL;
@@ -13648,6 +13659,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
         switch (num) {
         case TARGET_NR_epoll_pwait:
+        case TARGET_NR_epoll_pwait2:
         {
             sigset_t *set = NULL;
 
@@ -13658,8 +13670,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
             }
 
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
-                                             set, SIGSET_T_SIZE));
+            if (num == TARGET_NR_epoll_pwait) {
+                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
+                                                 set, SIGSET_T_SIZE));
+            } else {
+                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, timeout_ts,
+                                                  set, SIGSET_T_SIZE));
+            }
 
             if (set) {
                 finish_sigsuspend_mask(ret);
@@ -13668,7 +13685,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
 #if defined(TARGET_NR_epoll_wait)
         case TARGET_NR_epoll_wait:
-            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
+            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
                                              NULL, 0));
             break;
 #endif
-- 
2.43.0


