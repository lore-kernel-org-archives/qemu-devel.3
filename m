Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIW-00012q-Fk; Fri, 07 Mar 2025 10:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIU-00011v-8N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIS-0008LB-Ad
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so445724f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360051; x=1741964851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cZx+EJrwSEPWcdmfK70Ab9fdIcmzEh488cpidIw4fLI=;
 b=s3p1s0AtaBCx4R6UVezKIoBO7u64BmVlTqlohBdAkLXPv20EsZ/7HC7jsaZs/6tTkX
 /sr42D3fdgqpA9PAa/nBlhgs0wp33h6EC76cFabE4F+325EQJzJ8QmVIj12byle3O9Fo
 hBn39WaHPB/JZKNcJD0s4KC1yVwVULC45qS0RWY7GuLlc2y+7CjCL/1KGL8kKv6xyrV6
 VyUikuCrDrRncJz67+7P7P6WkNBeLNw+Hs8SKBIocot2ENfsa8Rwt6CeJ5qpZrVk6J9s
 9MzbQQbyHabZ+U7ClE7wphub3PrzyW5arVMVC+y48y1GzRHMhWgxJo9wpRR7AfSvrMJy
 vL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360051; x=1741964851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZx+EJrwSEPWcdmfK70Ab9fdIcmzEh488cpidIw4fLI=;
 b=ouwCFN6JjvaxFztLwD5leRxSBma7PAdVEO3zQOrYgkGx7Ayd4AVqaJ8FpA+LJWnAlo
 0AtgneboD4HiWvXFLafPYTGqinHSzy6NdZCndSJfwAv6+muMBJVwQZLYdgumLK/Hf9ek
 4vwuaOr8BmNkv6EZkbK399dSZCZ70pJgHShov80Z94IPyLpRINdsygW7FCGtWT0DmJxO
 dufex/yicWgcs/a8sjcPl2+LMzA+FFvawH2vJlf7ClXWTZkoUld+zIVK9hPVB/HHOC9p
 J5IEB+EtiJqa1bVlThhCaD/xzN9ZF42igwGW6lm53Gz6H1UDrwSeQxmL3OyVgA2lC6Nj
 iUhw==
X-Gm-Message-State: AOJu0YxjGpY5gZrc4IEEVMBIkzLeys6ZIJF//I2XvF5DnrNa36AJzcKB
 66yRnE5Y4ZxVa22k43pEEbhvhZtL5aOQ0FtCoDwpIlRZ+QmeqMqR3EhYhoS0H587qQcaw8DxpYV
 N
X-Gm-Gg: ASbGnctTAzT7xKfAKsLD3i13CQYo/0PJ2K+iqQnFVrchTAT7uZ/4HKcrC2EgXE0pbvO
 jV4DArH4bWUp9fWU0s1X3/Jh24HbD5j+D5xTns3PEYhA5JBEeLQM3fAPSaB70772dt/wbRF+91m
 QbZ00Onr7t/OfPpy16AmxH4avW/aocm/VgzUP7VkIhX1UjZornKABSP8jQSdWSqtHroH6xog9on
 mDrSN/RP1/cIeWpdtuSo1OQJs0Li7RcVCqQWau/zLmXPqvdJsJ2lvEVzHEFv3p/yPnSbT3F9cud
 RAVGZtx8lqm19Vjr61rQFZCaTGDSSgeqq0CjLKodtTKckVhOnwU=
X-Google-Smtp-Source: AGHT+IHziXLFxz81ONXB7x0ht5pVLmX3+N+T+LDixRVfcUyMwXy/Rq2zYjButNos+FDGdCgPr314+A==
X-Received: by 2002:a5d:584f:0:b0:391:ffc:2413 with SMTP id
 ffacd0b85a97d-39132da08b4mr2428556f8f.40.1741360050752; 
 Fri, 07 Mar 2025 07:07:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/21] util/qemu-timer.c: Don't warp timer from
 timerlist_rearm()
Date: Fri,  7 Mar 2025 15:07:04 +0000
Message-ID: <20250307150708.3222813-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
interrupt and move a CPU from idle to ready.

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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2703
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250210135804.3526943-1-peter.maydell@linaro.org
---
 util/qemu-timer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 3243d2c515c..788466fe22f 100644
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
2.43.0


