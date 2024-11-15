Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6636CD68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBynT-0004AS-WF; Fri, 15 Nov 2024 11:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33nA3ZwYKCt0QNPTDGFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--roqueh.bounces.google.com>)
 id 1tBynQ-00049X-PB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:45 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33nA3ZwYKCt0QNPTDGFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--roqueh.bounces.google.com>)
 id 1tBynP-00040x-8X
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:44 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e381f9e1395so2648391276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686622; x=1732291422; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HYr7dkbjOM3DhMWGJi0XHGtksaAWQFJUXcJyP4tJoMU=;
 b=MxfYrLR7Fj6HQ8ItFqA+yYZvGb473tJSXJv/+5upqp0CYSlZdlQeaYybSEhR3E6xon
 4Foq3KDQpG3OF/CYju318Yagbj7IpKvRNmWvUevSMixm8IsWPcTen0fJiT6GMkFJO62i
 X6e2VX5mZaBFMC7PwEQ4N9EgiCt7eWS31uIi7r2K9rUpV8rGHgKpCz8boVFvCXb74n1n
 n2xj+5t9bWagnMeYpSUiJQrybmV56DvYa0VyDEGyjka3SjvrHh5xqISVHK2df8qoETud
 MKmThUwlSBWGUZ+OSaHq2dkNPuILQaci0OM1iI5ypZx7YTA1fLZt4CBFFbxiCUaeSj4t
 IWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686622; x=1732291422;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HYr7dkbjOM3DhMWGJi0XHGtksaAWQFJUXcJyP4tJoMU=;
 b=AXGJSLQ9zyoKzetjLjwK0U8Z1lB/3OYSciSBTsTF5QjS0DCRoRmeIS+NN6Yhg1wi2z
 UoF18nuzQLuc76O9+/uXbT+oqz+0t/xdz85RrXhzvonEB5LpBgGzd9mqkow7SArq+ae/
 dA699roNB4AN/IK9EhiO/pvPn1zoxHUNiLqr22qha2IWu2sD7hnE92jFKxnWGOzhjDBu
 FLE8AruQetkwwrdOy17WKk1ar2m9JamU0LMYJ5GvxTqTjshtxzSLzluYDTNiMl7nzuHi
 KtMk3wwY7EdKxJ6TkxhqnILdbC/yw4+QcHQTvwQeZhYiXBzadFS3SL/tV4/Z5yWsg6B/
 Urcw==
X-Gm-Message-State: AOJu0YyX98wGE31S5J9yYZXCP/eK2VQ+M62IG+gvKrJwx2EARFeeTuYa
 V4lx4bMJg0NoyTZcX5ah85a3ORa61sRuPg3AbvuYbnMErJ9a/43YUfgDN82MTlPCgtQvxs6YThE
 EMQ==
X-Google-Smtp-Source: AGHT+IFAtteKGzbsxn7wEW/AZvhVZkag2wL/KsZoSf44v9m5j4DQzTGeTKHamCAz4aMV3IOr2XkH/iE+rQU=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:53c1:0:b0:e30:b93a:b3e4 with
 SMTP id
 3f1490d57ef6-e382614aae1mr129379276.4.1731686622044; Fri, 15 Nov 2024
 08:03:42 -0800 (PST)
Date: Fri, 15 Nov 2024 16:03:25 +0000
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115160328.1650269-3-roqueh@google.com>
Subject: [PATCH 2/5] hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=33nA3ZwYKCt0QNPTDGFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
 hw/watchdog/cmsdk-apb-watchdog.c | 34 +++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e4d25a25f7..ed5ff4257c 100644
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
2.47.0.338.g60cca15819-goog


