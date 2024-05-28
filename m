Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BDAC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqD2-000874-Bk; Tue, 28 May 2024 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCl-0007yy-Hj; Tue, 28 May 2024 02:21:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCi-0005Cp-G5; Tue, 28 May 2024 02:21:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso347674b3a.1; 
 Mon, 27 May 2024 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716877257; x=1717482057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkjpAdiL1tYmV8JXgRcDRpsqUIo0QsNMXicF1J6Hpoo=;
 b=U4vJddlatpj9OuLiK3FoqM0SoDZwONOOQCNcUYKrCkCA5mbkYuQocG9p/dIgYEjQxt
 X9r4nuBHWiJI+v8+AOMKHCs+sMEeoXlao+WpOwVRuABCoavGVaRQ0mbA3zI81dvhwp6r
 lE2o4fxPH3u1OsA2y0XjPqLeGFXZpcF8sHdwmx6Hfkn4cmBHQmg4gKtv+w6pGwjciwPl
 ORY2QQYQTf2kUJyinygmYVH5sH4L3Qn/axcJ2F7GUvhJPiDgensZaZ9QClw5nJnFc4ux
 JHQfGFzlFJ2n/c+4x4ZXEHGs3L2Kybynk1U2ejGNoK4+B0VVqEhAj7dQjneX4G4D7s3r
 Wh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716877257; x=1717482057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkjpAdiL1tYmV8JXgRcDRpsqUIo0QsNMXicF1J6Hpoo=;
 b=cWF+yIDCHqNJY7xXA6pKAq0APmF5iK7gYEOh/hItjvB4f88E1aEpD7X8+JYfXtl07X
 fXrrESIYBuJrYknvbntO9n1hyW6ljHa9br42QftlZSyhlOQzoUSkwHiNHvmB4XaaAg5v
 uyYNG+ytIaJQVaxut7JrZSt1y8ffLY4gNAw3C+r19XOKKSbYZjL0eINQAcFSwmg335aV
 khLpk/RGCqryrICR7rwE1GaAnBjKdhCigNfMER6BceKucyrzY6q7QV+ntK5qi+Jbiblc
 7se64epJ92y4wjDs49AIPe2C4UGh8D2FZ3fJcvvyP+XTAd1mrvk4oWw4e4eZj9bqibiV
 J/vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQAhhpGqC3sp0K7gf0QuZoUEreiROa7wnRO+FF3XjHV5MVeM5DHTFiNfZomRRIPjeRbC1fRidJABLvDvBwkaRVNM5M2E=
X-Gm-Message-State: AOJu0YyI3MuabjXdUZcuA+VSVaC7XoiAZB8st+CL5SX2CpdQ/ZYPF09R
 L3RXFvFJ/EesOlFYvgknIhfVgPETPWBszW1L3ZHRIHiSD3a1GgsidT9Yfw==
X-Google-Smtp-Source: AGHT+IH5jGa9eBF3dkDNvyJpNEdWk/ycBbctvTFcoxslsfV6cLjQGee8F7O9u7mdVvNS80F1fBDgjw==
X-Received: by 2002:a05:6a00:4390:b0:6ed:2f0d:8d73 with SMTP id
 d2e1a72fcca58-6f8e92488f8mr16056656b3a.3.1716877257412; 
 Mon, 27 May 2024 23:20:57 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbdesm5969779b3a.18.2024.05.27.23.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:20:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 1/2] ppc/pnv: Fix loss of LPC SERIRQ interrupts
Date: Tue, 28 May 2024 16:20:44 +1000
Message-ID: <20240528062045.624906-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528062045.624906-1-npiggin@gmail.com>
References: <20240528062045.624906-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[np: rebased before P9 PSI SERIRQ patch, adjust changelog/comments]
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_lpc.h |  3 +++
 hw/ppc/pnv_lpc.c         | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

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
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d692858bee..252690dcaa 100644
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
+	 * The LPC HC in Naples and later latches LPC IRQ into a bit field in
+	 * the IRQSTAT register, and that drives the PSI IRQ to the IC.
+	 * Software clears this bit manually (see LPC_HC_IRQSTAT handler).
+         */
+        lpc->lpc_hc_irqstat |= irq_bit;
         pnv_lpc_eval_irqs(lpc);
+    } else {
+        lpc->lpc_hc_irq_inputs &= ~irq_bit;
     }
 }
 
-- 
2.43.0


