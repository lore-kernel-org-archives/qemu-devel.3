Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B71C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUIe-0006nz-BU; Mon, 10 Feb 2025 08:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUIc-0006nR-RV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:58:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUIa-0001iZ-Hp
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:58:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso29298665e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739195887; x=1739800687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pftZOTu4W41f/6GB8KhGZh3z4DebWeK+fUoY69RtqXY=;
 b=jCSaHVrDrvA46bnP+siUyl2uB0KgCHFs5Nj0ZJKT68F+5Ew/Ka6kVnUcI/8a6j55zQ
 kxvpNGfkJEaMLLJV0shWIvRBulu9Pct8Dqx5lCesUj8yP7gpoq6egjlsFRzSIZXhUZkK
 /pPh29bBZFUWg0ipUFzaj28g2tDDkhtc7lAIcP3miveX04cOnqTYtqvaMiZHkuQi1viW
 pOUeu5WxNegKJDnvn/+wCsxy6RqixKJ0Ny/I1u+pIWnNiVx9/24bU0G1Y6mT3KcmF67r
 z5aroXO8GtFHScK9rqbROe8+vRkwjkVipQWW+PMOLaD/iiLruwcaoyZzSE0qnN2Hy7rH
 1KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739195887; x=1739800687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pftZOTu4W41f/6GB8KhGZh3z4DebWeK+fUoY69RtqXY=;
 b=eCzWwFNXj5EFXtTMxPhfCIQ2DtpVJl6Ln1nNrCbooReuV7cZy/X/QiTf9ZmIfdHvrj
 l5btWXBsIY+ROTmWlb5RTEp9eSwgqBtJtJFMUvmOQJsabNctfZEFpFyRGv+5WyZ16Kt6
 1iVOj5pt6DWWHiaUKCszbJYfwXZdQePwiX73sbpDl93R4NBcVRBGLg9SN53rkreCRiIO
 iIGPlkQEtOXy7cd9v94TMDI+UdvVnrTKWmBqp9A3mdegfvt0c/sM1L72ikq2lTxZ/zhG
 oisX3Q4o9HM7k+fTMksfnKE/M6jqj8iT9kqyz+VTyiEJKwbl1zGgSf6QBv3JRGmd9bVE
 lpvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYrFN0IVlrrO698g6BuE8rGtSVl932O1aUT9TL/CLeyBZF3nEbjBezHSeh8q1CdKWUv86itzcs62La@nongnu.org
X-Gm-Message-State: AOJu0YzGQ0b1d+Q+0UkuEJOUCE1yN9xFZ9kUow6oG1q4w+ilmK0xgreX
 zN16k6skIk6k2mO0wWze3SPtqm/fn7Ck+oQ7jsQQbI3FKqFoF01c0Hutux4OQVuYWppozm0VWUk
 f
X-Gm-Gg: ASbGncvqIjeohbSpJ5SxcyivF+IjIQDTVAO8YIG+UctX6l2hQDHq8ho9+KVaccUDBIL
 pniwghXpcGTY+62bEK4n4VIPmv3MMyaGNP0pnEzAQSoVMlwTuXVrULXXKRWSkbiWKaLOaDkI/p1
 lAucafKYNA8u6SQNt4mObk1EpNNSblBbZEq367wrSeJ/qe3k3o74s3DvvIkJIJWDNhNcxMZnZGE
 oZsy4jXdKvF5v7rXuZooKJC/jzlfZGQCht9wypXDzhAWw60k7dcGSYrl9GBErbNDKPLhdtKzYRf
 BF8Rx9018Y0X689Qlo4HUA==
X-Google-Smtp-Source: AGHT+IHaNYq08iPVpPn/doq9GXszwpXL1774yFW4fibBNLZ6jkVPuWar88biKdsU9DNv+DLpdatI8A==
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38dc9346494mr10134005f8f.32.1739195886658; 
 Mon, 10 Feb 2025 05:58:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd187360asm7596636f8f.43.2025.02.10.05.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 05:58:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
Date: Mon, 10 Feb 2025 13:58:04 +0000
Message-Id: <20250210135804.3526943-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently we call icount_start_warp_timer() from timerlist_rearm().
This produces incorrect behaviour, because timerlist_rearm() is
called, for instance, when a timer callback modifies its timer.  We
cannot decide here to warp the timer forwards to the next timer
deadline merely because all_cpu_threads_idle() is true, because the
timer callback we were called from (or some other callback later in
the list of callbacks being invoked) may be about to raise a CPU
interrupt and move a CPU from idle to ready.5A

The only valid place to choose to warp the timer forward is from the
main loop, when we know we have no outstanding IO or timer callbacks
that might be about to wake up a CPU.

For Arm guests, this bug was mostly latent until the refactoring
commit f6fc36deef6abc ("target/arm/helper: Implement
CNTHCTL_EL2.CNT[VP]MASK"), which exposed it because it refactored a
timer callback so that it happened to call timer_mod() first and
raise the interrupt second, when it had previously raised the
interrupt first and called timer_mod() afterwards.

This call seems to have originally derived from the
pre-record-and-replay icount code, which (as of e.g.  commit
db1a49726c3c in 2010) in this location did a call to
qemu_notify_event(), necessary to get the icount code in the vCPU
round-robin thread to stop and recalculate the icount deadline when a
timer was reprogrammed from the IO thread.  In current QEMU,
everything is done on the vCPU thread when we are in icount mode, so
there's no need to try to notify another thread here.

I suspect that the other reason why this call was doing icount timer
warping is that it pre-dates commit efab87cf79077a from 2015, which
added a call to icount_start_warp_timer() to main_loop_wait().  Once
the call in timerlist_rearm() has been removed, if the timer
callbacks don't cause any CPU to be woken up then we will end up
calling icount_start_warp_timer() from main_loop_wait() when the rr
main loop code calls rr_wait_io_event().

Remove the incorrect call from timerlist_rearm().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As far as I can tell, this is the right thing, and it fixes the
"icount warps the timer when it should not" bug I'm trying to
address, but I'm not super familiar with the icount subsystem or its
evolution, so it's possible I've accidentally broken some other setup
here.  This does pass the tcg, functional and avocado tests,
including the record-and-replay ones.  I've cc'd it to stable as a
bugfix, but it definitely merits careful review first.
---
 util/qemu-timer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 0e8a453eaa1..af6e1787e57 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -409,10 +409,6 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
 
 static void timerlist_rearm(QEMUTimerList *timer_list)
 {
-    /* Interrupt execution to force deadline recalculation.  */
-    if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
-        icount_start_warp_timer();
-    }
     timerlist_notify(timer_list);
 }
 
-- 
2.34.1


