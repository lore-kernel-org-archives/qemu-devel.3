Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0644C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Iw-0006fY-E2; Thu, 25 Jul 2024 19:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8It-0006Qo-Md; Thu, 25 Jul 2024 19:55:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ir-0000sf-W5; Thu, 25 Jul 2024 19:55:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so393233b3a.1; 
 Thu, 25 Jul 2024 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951720; x=1722556520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+iyWvitYD/j2rNBgmDFtisWhQvb5c4GOeulfi1Fuk8=;
 b=Lj3oe1E6O0ajnGlk11DhCQqEB/0uDxhiy8UwEUHScyEeINMRDKsf7vMwDObrhLOXXW
 CFGHgEsJp6EdFOoIMPWp+0rs4GFgYf95btxjke0Jr5t7FiAY9qtF/tuR21dFlOfQCCsc
 LmZy+uOFaJc5zc8zTarY/v32J2gpPCeaAcx3mwBvJ+nqWaPTCn9BhJDauaiaJ82GdhbT
 zd+CvfSM9S8JzDVjGuKbEKUM2Eeml+OGgyELc3exp82e086wMeBgwIosx8aHgNx2kOzi
 kJ8rbB/sdMQ0N8kONmM6lE/9Y8AcP+uDk4AmR0/B2Pcu5F3p7ZWHexJ9LCeCRqKo7Idl
 RJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951720; x=1722556520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+iyWvitYD/j2rNBgmDFtisWhQvb5c4GOeulfi1Fuk8=;
 b=nxO0U+9fHwdkK1YC217bMluia4rBNz0IoHIrkiEajSoPBobQ3sP80SYHqRX8jsaCG0
 T+Ikxzj8ggUvDVlyF8w+55irSAIyrS4jK5hO3wrl/NBax1cwt/zCdrr3vvdGaVhmMjW9
 BHKirrjTQldhSg9ALMlykmP04ZCBCLwj/Aue3pbO2U2z26Mewn3h5T6OiYr736LEYt35
 1jlYo0RUrkPVI3Rpd4YYAmaqW/k3SoMk6LiofeV4uZWBYBs3eAqq+rXr3wwYqAdPY1lQ
 Tyrmr9B8pwXj8tS4mqgIoMRLdfHrzmhu3K+VV7AqwaEq4TEobVVbtkG1m88LV5d1/TWI
 VEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBMYGA71Zz4zzwOxPoOW6q3MDVzvJ9P3YT7UIUBwVL1H+BZ4Z4tM6I2VG+xOztzFe5V5F0dtk9BiZFCD8Pls914tPW
X-Gm-Message-State: AOJu0YzRpWd3WJC+Po2JW0uEzLn3bCzWO7C3JFaoGzmaxJ7OHyzcEhB6
 r+IFeT1lGZCg+MdFCTEHYGcgh2yVBuuRmZfWh/GWKrmI43/JCI7ERMsdqg==
X-Google-Smtp-Source: AGHT+IG6qqGH5rKtxbhWHabXrfSt0FVOOhJ8CecgDCvqTvXNcrQ2scmjw15uLYKapdawB2YAZG1Txg==
X-Received: by 2002:a05:6a21:78a8:b0:1c0:ee57:a9a3 with SMTP id
 adf61e73a8af0-1c472b2443dmr5848835637.35.1721951719771; 
 Thu, 25 Jul 2024 16:55:19 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 14/96] ppc/pnv: Fix loss of LPC SERIRQ interrupts
Date: Fri, 26 Jul 2024 09:52:47 +1000
Message-ID: <20240725235410.451624-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The LPC HC irq status register bits are set when an LPC IRQSER input is
asserted. These irq status bits drive the PSI irq to the CPU interrupt
controller. The LPC HC irq status bits are cleared by software writing
to the register with 1's for the bits to clear.

Existing register write was clearing the irq status bits even when the
input was asserted, this results in interrupts being lost.

This fix changes the behavior to keep track of the device IRQ status
in internal state that is separate from the irq status register, and
only allowing the irq status bits to be cleared if the associated
input is not asserted.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
[np: rebased before P9 PSI SERIRQ patch, adjust changelog/comments]
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c         | 22 +++++++++++++++++++---
 include/hw/ppc/pnv_lpc.h |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d692858bee..7d26b29487 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -505,7 +505,14 @@ static void lpc_hc_write(void *opaque, hwaddr addr, uint64_t val,
         pnv_lpc_eval_irqs(lpc);
         break;
     case LPC_HC_IRQSTAT:
-        lpc->lpc_hc_irqstat &= ~val;
+        /*
+         * This register is write-to-clear for the IRQSER (LPC device IRQ)
+         * status. However if the device has not de-asserted its interrupt
+         * that will just raise this IRQ status bit again. Model this by
+         * keeping track of the inputs and only clearing if the inputs are
+         * deasserted.
+         */
+        lpc->lpc_hc_irqstat &= ~(val & ~lpc->lpc_hc_irq_inputs);
         pnv_lpc_eval_irqs(lpc);
         break;
     case LPC_HC_ERROR_ADDRESS:
@@ -803,11 +810,20 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
 static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
 {
     PnvLpcController *lpc = PNV_LPC(opaque);
+    uint32_t irq_bit = LPC_HC_IRQ_SERIRQ0 >> n;
 
-    /* The Naples HW latches the 1 levels, clearing is done by SW */
     if (level) {
-        lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SERIRQ0 >> n;
+        lpc->lpc_hc_irq_inputs |= irq_bit;
+
+        /*
+         * The LPC HC in Naples and later latches LPC IRQ into a bit field in
+         * the IRQSTAT register, and that drives the PSI IRQ to the IC.
+         * Software clears this bit manually (see LPC_HC_IRQSTAT handler).
+         */
+        lpc->lpc_hc_irqstat |= irq_bit;
         pnv_lpc_eval_irqs(lpc);
+    } else {
+        lpc->lpc_hc_irq_inputs &= ~irq_bit;
     }
 }
 
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 5d22c45570..97c6872c3f 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -73,6 +73,9 @@ struct PnvLpcController {
     uint32_t opb_irq_pol;
     uint32_t opb_irq_input;
 
+    /* LPC device IRQ state */
+    uint32_t lpc_hc_irq_inputs;
+
     /* LPC HC registers */
     uint32_t lpc_hc_fw_seg_idsel;
     uint32_t lpc_hc_fw_rd_acc_size;
-- 
2.45.2


