Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E51C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2q-0002IG-CF; Tue, 01 Apr 2025 07:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2h-0002FX-48
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2f-0003hf-CJ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22622ddcc35so29354045ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507868; x=1744112668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfSxfoPJes1VEH5r0b3g31jznF6Yt9hKoGOVvi6NHvo=;
 b=NLIQcTOi/wHUpW5wMclBZvxzPzsDES5dyU2QJyGjsmY95/wdHbeoXN1XYf4kjLxyKn
 krMFhES8Ia4FIpKp0Yr0vQD2gzriIbIeQEoUHpqXCNXBXfh+puKbfYt+nDgXLYRk4IlV
 i8wNscy4lhwYHCzQBOD2bKpLuwZktyQKZN29rWcZOYaMLII9pDVlHMSJbqBrITiZBGp6
 dIs0EmuOCBx/r7KvrFXptS6QpN398cp67v9r+SgRMkJP5zDvbVUzPBZJ6odyNHiBie5h
 At0/RDw5aE0vHmRxZqh3q0x1w66MbCQfWP0foIresXfE4iZVkY4jPBOYjYSj8nPZFYa1
 5Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507868; x=1744112668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfSxfoPJes1VEH5r0b3g31jznF6Yt9hKoGOVvi6NHvo=;
 b=pN7mrNvql4ixD599M3fQODc3/7Fb46HtHzwVYI6VG7WeqQmWX3Bs9fW+S1nMMyrTZY
 QFPB9PlpOvt71AXlyFV6g+FxpsFpReU96yLSH5Z5mpJwBXO2sym9JP5d6BJ+e/2Bd2QG
 lXkBGUAmHTzvc+rAt0OLs9JFzXROU5L/wu55MPs925Nk7ZcTXplBmA7lArx9U0xM51Uj
 +rpf0rXkCZlSugIu7qDM/SrzBouj2keFlf3uWFf+VsQ5EDoLS5K4YywxMwdiBS31/YNy
 DKAPqPYolaOzH3nc8AZtMajPg+0jiSjEC4PidvRbuznlOEvflMcluER0Lm8rYCnp9b/z
 4Udg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVflrlKDYZFLxhuY8dthXsJcHzk7lWufygb8pxYJlW5OoLY9qbTgOncY9KZ5zvYBaQJpw+9em52uMqE@nongnu.org
X-Gm-Message-State: AOJu0YwSSghsqQS1sVL2gM5EEqQW7BhBUNKFeSkXEsi3pczZmmkwQv0s
 Y8C0eGBe1t7S4twGYzG9juUTlKZF1nhD2qzZn7WupXNOtyqvlapD
X-Gm-Gg: ASbGncs7pSzeYhy/0rGxYqd1R6PIia5mmwovzwdJLnpbQqEriHfnCm4gEZM8Mfo/Q3d
 k5l50H7AZiG6+odv84qNHuRAs4hUJNc52qX+UYs3lj6B/C9z4ijQ2Qt0RF1MXPD0zZIB4bq/puX
 i5hR0bwUUEhWv0bP9SidaM7sY9/6Yz/lhvyDjviacw2npI9tdsxyKvmOzjSFPi5xnTPwyU1PCrM
 oSC+/nnzyfs4d+ea8bGbzMKy4h+WZqpCVus2coyQOzoX1zH0uhitqdiCKQQ+IS+K1ZJfV3ACbrf
 fzlRfW5GYNeE9iItw37RVVxbbRxQBrVZAkP8a7CSW3OhJXBeUfLgEyo6ciXC
X-Google-Smtp-Source: AGHT+IHe7pAbnq33036z2YU4NAvEiOXePCQBPNT2k1FYV5rp5D9+EWjxJYhkSRIDXgk+6twGzEUjSw==
X-Received: by 2002:a17:902:8a87:b0:223:517a:d2a3 with SMTP id
 d9443c01a7336-2292f95d884mr151445935ad.17.1743507867923; 
 Tue, 01 Apr 2025 04:44:27 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] ipmi/bmc-sim: implement watchdog dont log flag
Date: Tue,  1 Apr 2025 21:44:11 +1000
Message-ID: <20250401114412.676636-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401114412.676636-1-npiggin@gmail.com>
References: <20250401114412.676636-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If the dont-log flag is set in the 'timer use' field for the
'set watchdog' command, a watchdog timeout will not get logged as
a timer use expiration.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 216bf8ff7f0..3cefc69f8a8 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -514,7 +514,8 @@ static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
 
 static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
                                     unsigned int bit, unsigned int val,
-                                    uint8_t evd1, uint8_t evd2, uint8_t evd3)
+                                    uint8_t evd1, uint8_t evd2, uint8_t evd3,
+                                    bool do_log)
 {
     IPMISensor *sens;
     uint16_t mask;
@@ -534,7 +535,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
             return; /* Already asserted */
         }
         sens->assert_states |= mask & sens->assert_suppt;
-        if (sens->assert_enable & mask & sens->assert_states) {
+        if (do_log && (sens->assert_enable & mask & sens->assert_states)) {
             /* Send an event on assert */
             gen_event(ibs, sensor, 0, evd1, evd2, evd3);
         }
@@ -544,7 +545,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
             return; /* Already deasserted */
         }
         sens->deassert_states |= mask & sens->deassert_suppt;
-        if (sens->deassert_enable & mask & sens->deassert_states) {
+        if (do_log && (sens->deassert_enable & mask & sens->deassert_states)) {
             /* Send an event on deassert */
             gen_event(ibs, sensor, 1, evd1, evd2, evd3);
         }
@@ -700,6 +701,7 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
 {
     IPMIInterface *s = ibs->parent.intf;
     IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    bool do_log = !IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs);
 
     if (!ibs->watchdog_running) {
         goto out;
@@ -711,14 +713,16 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
             ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
             k->do_hw_op(s, IPMI_SEND_NMI, 0);
             sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
-                                    0xc8, (2 << 4) | 0xf, 0xff);
+                                    0xc8, (2 << 4) | 0xf, 0xff,
+                                    do_log);
             break;
 
         case IPMI_BMC_WATCHDOG_PRE_MSG_INT:
             ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
             k->set_atn(s, 1, attn_irq_enabled(ibs));
             sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
-                                    0xc8, (3 << 4) | 0xf, 0xff);
+                                    0xc8, (3 << 4) | 0xf, 0xff,
+                                    do_log);
             break;
 
         default:
@@ -734,28 +738,36 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
 
  do_full_expiry:
     ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
-    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
+
+    if (do_log) {
+        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
+    }
+
     switch (IPMI_BMC_WATCHDOG_GET_ACTION(ibs)) {
     case IPMI_BMC_WATCHDOG_ACTION_NONE:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 0, 1,
-                                0xc0, ibs->watchdog_use & 0xf, 0xff);
+                                0xc0, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_RESET:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 1, 1,
-                                0xc1, ibs->watchdog_use & 0xf, 0xff);
+                                0xc1, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_RESET_CHASSIS, 0);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
-                                0xc2, ibs->watchdog_use & 0xf, 0xff);
+                                0xc2, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_POWEROFF_CHASSIS, 0);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
-                                0xc3, ibs->watchdog_use & 0xf, 0xff);
+                                0xc3, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_POWERCYCLE_CHASSIS, 0);
         break;
     }
-- 
2.47.1


