Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C04FD44163
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8h-0005vo-2H; Tue, 19 Nov 2024 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8b-0005q8-09
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Y-0006Cb-L4
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso31784465e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026205; x=1732631005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9cLsADc/b1nvOdEt6B14trzuyDptUS5PDXoA87jXxAM=;
 b=afnQIQZ0xzkMevTPNgiP6t25LxDr9iKee5HqOB5wwQsto3YAjkpRlEBjoT4HqKWhyg
 OInxwBS1IEUzxU99g+AmvnhATukGXBsAJqaCeSeMIUOBmeFtHUmX5eOiwrZs43VlE5ak
 y+RgaTRP1KgeYu+s/z8xNukzAZG+AQycUhvc/lqMdSbJe79HeRdBY1bDFaR1zjhWIXKh
 FaC1JKJ/suuB+IIyoRo5qqJsx3b6QeRSaE4DGBSJr9V2iH7oK4Ky/AT62K7kQ/e2b8jd
 XECOWjyUSJRZxXADN1UqXjegN36fdYA1qFMsKkKZPpdB89mTcMM67bRtPyrFlpEZrYHk
 N7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026205; x=1732631005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cLsADc/b1nvOdEt6B14trzuyDptUS5PDXoA87jXxAM=;
 b=H1IIFyqtFOTqHo3qcQRxVKhbSHWY1LwC6UWjJWH3S6dZBcee8QX72brb0/kkDcTBtY
 qDA0wvgFEmCzqD0jCCW/aULCUu1UU6KV4+CQBZlq7i6lrFbwtCypff55MU2JtJNiWpV1
 moTkV3FokXJ5IYalwYoD18NyczAU6/V8AV69clHqPqHoG9v22uUKcqLbUSHOXQofDBWp
 ycral1T585ngLIhKkquqyGJ/kKX7vtHqTFUAShZfP7ShzXYJBMVscGNYIq/8YwWhtSQ1
 idod5eJbnQsgsGIyhevYjT6RSw91U7ggSAAI3a9r6uAcwrLvarQpv7Zz65riXFx3Eetn
 I34w==
X-Gm-Message-State: AOJu0Yz3vOozBWhS105Ah1Nj8nr4V+Hs46XX4K/jRNk57pfl7W6ZeN7/
 AXOZJH9POp2VyThlRlkqkEmPax11LvpmO1LU/L7wop+JWa9THYBLymb+CPG4ClVVU9waISgPyFy
 3
X-Google-Smtp-Source: AGHT+IHesRT4o1EZVc1LRGcsuNpJHifcmtaQGWG/rpdNDZnIX83xiXMy5OULwAdUjJVcLtZ99buYpw==
X-Received: by 2002:a05:600c:58cb:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-432f57fba53mr29815185e9.16.1732026204917; 
 Tue, 19 Nov 2024 06:23:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
Date: Tue, 19 Nov 2024 14:23:10 +0000
Message-Id: <20241119142321.1853732-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Roque Arcudia Hernandez <roqueh@google.com>

Current watchdog is free running out of reset, this combined with the
fact that current implementation also ensures the counter is running
when programing WDOGLOAD creates issues when the firmware defer the
programing of WDOGCONTROL.INTEN much later after WDOGLOAD. Arm
Programmer's Model documentation states that INTEN is also the
counter enable:

> INTEN
>
> Enable the interrupt event, WDOGINT. Set HIGH to enable the counter
> and the interrupt, or LOW to disable the counter and interrupt.
> Reloads the counter from the value in WDOGLOAD when the interrupt
> is enabled, after previously being disabled.

Source of the time of writing:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Reviewed-by: Joe Komlodi <komlodi@google.com>
Message-id: 20241115160328.1650269-3-roqueh@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/cmsdk-apb-watchdog.c | 34 +++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e4d25a25f7a..ed5ff4257c1 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -196,16 +196,13 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case A_WDOGLOAD:
-        /*
-         * Reset the load value and the current count, and make sure
-         * we're counting.
-         */
+        /* Reset the load value and the current count. */
         ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, value, 1);
-        ptimer_run(s->timer, 0);
         ptimer_transaction_commit(s->timer);
         break;
-    case A_WDOGCONTROL:
+    case A_WDOGCONTROL: {
+        uint32_t prev_control = s->control;
         if (s->is_luminary && 0 != (R_WDOGCONTROL_INTEN_MASK & s->control)) {
             /*
              * The Luminary version of this device ignores writes to
@@ -215,8 +212,25 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
             break;
         }
         s->control = value & R_WDOGCONTROL_VALID_MASK;
+        if (R_WDOGCONTROL_INTEN_MASK & (s->control ^ prev_control)) {
+            ptimer_transaction_begin(s->timer);
+            if (R_WDOGCONTROL_INTEN_MASK & s->control) {
+                /*
+                 * Set HIGH to enable the counter and the interrupt. Reloads
+                 * the counter from the value in WDOGLOAD when the interrupt
+                 * is enabled, after previously being disabled.
+                 */
+                ptimer_set_count(s->timer, ptimer_get_limit(s->timer));
+                ptimer_run(s->timer, 0);
+            } else {
+                /* Or LOW to disable the counter and interrupt. */
+                ptimer_stop(s->timer);
+            }
+            ptimer_transaction_commit(s->timer);
+        }
         cmsdk_apb_watchdog_update(s);
         break;
+    }
     case A_WDOGINTCLR:
         s->intstatus = 0;
         ptimer_transaction_begin(s->timer);
@@ -305,8 +319,14 @@ static void cmsdk_apb_watchdog_reset(DeviceState *dev)
     s->resetstatus = 0;
     /* Set the limit and the count */
     ptimer_transaction_begin(s->timer);
+    /*
+     * We need to stop the ptimer before setting its limit reset value. If the
+     * order is the opposite when the code executes the stop after setting a new
+     * limit it may want to recalculate the count based on the current time (if
+     * the timer was currently running) and it won't get the proper reset value.
+     */
+    ptimer_stop(s->timer);
     ptimer_set_limit(s->timer, 0xffffffff, 1);
-    ptimer_run(s->timer, 0);
     ptimer_transaction_commit(s->timer);
 }
 
-- 
2.34.1


