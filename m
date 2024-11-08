Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E14CD64078
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNR-0000df-QZ; Fri, 08 Nov 2024 14:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3J2IuZwYKCuQXUWaKNMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--roqueh.bounces.google.com>)
 id 1t9UNQ-0000c5-6X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:36 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3J2IuZwYKCuQXUWaKNMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--roqueh.bounces.google.com>)
 id 1t9UNO-0002RB-7x
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:35 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e6101877abso51133657b3.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731093032; x=1731697832; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=At9m5rzWH99Iv6qvPLaYCajHW0bxi1ZNylBU9lm8qmU=;
 b=cm4DI3BSPT8ob8Hif/5+vNnI4hKgjosKe7RTA9X+OU/QXOMSNa9t5xnJwyYJvMUhUT
 d0IMkNcO340xRXqk8OXpaXUvG04fp5ku3eDdn1Wbd2o+tnCN89JJAPetzUnGOpSe2T1D
 V43eTsEeHw1Ei01FEES7+Lu69oiJuPDh4muFCx0fpiBkYm9vVjeVXZ8/da3aSjEjNFKp
 /pep3j3cU550HJaYar4R9/35dp8+RVmvEdmPEoMpCwyVidrZAgiz5ShFnoT75z9zf5ei
 dJEdiy5Z7WsxoDdMwCHQCk7uhP9Hledk89oECRRoNT3Qpm3Yn0ePy8SgB3H8QFaZhA4q
 BMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093032; x=1731697832;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=At9m5rzWH99Iv6qvPLaYCajHW0bxi1ZNylBU9lm8qmU=;
 b=lh+NtyK7FNJsvtPH2ML7A9VK+y4MtHljfRNvyn5sAFaUd2OlnjI9lOeGxUBGYWchws
 3RzaixSD7n4D6KnSBBhBq7rDCW10iFiT3zIysmz99v+keCjx3UlJzP0cZLe3+Cp8wXId
 wDLvyJgyQ2nZcYym0ATR9hk+c2YF2ZBESD1gyUbevc6qQ/v1bAoKr0XzwBDLgVnlAP4/
 w2VkDXBRVyTsuz7JlGI90xVwD81DDurEATepeXogg2oK8P+Uth3uaPOR9CjSQB8Mtgwb
 7OWutzzDc8IeZUnhliC41HbEIRjSiyaKoNEAlfDU/RSPt6uAYE4EqSg25g031/v3N4RA
 SqgA==
X-Gm-Message-State: AOJu0YyhsHkUBCQwDJ/xpqIDeP3LbKyjzuDGc2z9wJsWIyBmNERmnKQP
 a+tCeW7xIkcBUY4faezOcvsqdFiyt9pKU/Arqo8r1C40JPmZ7qxaWtfeWx7ONYT6rcQvNHkKhuh
 oBQ==
X-Google-Smtp-Source: AGHT+IHiW1xpr248nQRAqXJnmbDxidOfYoqjHicMICLwcI5KkohEaN8vgCzcF1xHpKjqLIMDLN4J93ddxs0=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a81:a806:0:b0:6e2:b263:103f with
 SMTP id
 00721157ae682-6eaddc25bb2mr451637b3.0.1731093031707; Fri, 08 Nov 2024
 11:10:31 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:22 +0000
In-Reply-To: <20241108191024.2931097-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191024.2931097-2-roqueh@google.com>
Subject: [PATCH 1/3] hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3J2IuZwYKCuQXUWaKNMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
---
 hw/watchdog/cmsdk-apb-watchdog.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 7ad46f9410..e6ddc0a53b 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -202,10 +202,10 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
          */
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
@@ -215,8 +215,25 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
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
@@ -305,8 +322,14 @@ static void cmsdk_apb_watchdog_reset(DeviceState *dev)
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
2.47.0.277.g8800431eea-goog


