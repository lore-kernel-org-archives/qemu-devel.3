Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D67E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MG9-0007KQ-Bh; Wed, 30 Oct 2024 23:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG8-0007KC-Hn
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG7-0003vR-2W
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c7edf2872so12556025ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346845; x=1730951645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C32AOSRvgJJm4SKEesOSC4GwO3dBVLrjKqkchj8pJHU=;
 b=WGtpxRu/tFg/o3UQSuCZL7I9KsHvjniHeahBJinAg3Gh2oikjXl4LKl5tSILbZtKvB
 n0WeXqjFq6hq1/XpdmN3cqW3eOsmo7Aq/FxMyFlsXupC98r/N+9EsTru1+1HyFEEnkYe
 r4VT99nfMZtiCc+pxzNAVhcjSHYTjfyavKahp9e4GauWKPAm8038VsmF6yPH8Ubhb3Wi
 iXbJFonKk8iHLIEqe48EbXrPK+KJm54fyE4Lcj3syRTVJo1q5fvmKBgVODMnxr+qMFMP
 eAhNiauzxvG2tWr03bP5ZanO6f8ChYkhADcUi6NZaEySQy1NY8pgLXJCDhR1TBvkquku
 ZZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346845; x=1730951645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C32AOSRvgJJm4SKEesOSC4GwO3dBVLrjKqkchj8pJHU=;
 b=rKGqnkX39dU3hKPjYClEh5+pQ6N6FzKnPr5PFieH0fHgdizcKzptiH3in1bYEKvYsA
 BYSN3U4i5/JBnFFtCmRO5VRiwF+GWmHXDEWHCobcVb+khDosVrjRMQnSKrHZPSM2j+K8
 6PzsZClBScv8WK3qTDkuMpL2w21Wv7/jjrokK45dpf/ZAwwEPD6L197IngR1Xpa0zBhg
 B1lFwRSxQxHCsGjT0fxJOPqJIb6lnRhORbCeo1K0diI5sgFbnGRazfJMeMOkvM3tIJae
 SBw/7d6Duc4Bq7fXRO4RL+wfI3E9U+ALn0+AxvR0Fx+N6Fx+NmNFvQ2IIV7FUJ9MFRId
 tnlg==
X-Gm-Message-State: AOJu0Yy3DiFkPGdKtS68UzII4a4K3FizDB3uFpKMpaML+gSqCCR5NKCj
 NrNihvVENFQhTFZSu9oS3LBqDZw0pg22rgCxE/B2Eza/wbNUgjBWQ+G80ODK
X-Google-Smtp-Source: AGHT+IH7V4UQESPDWKiZbwqWQstmhWpIWygZqKIYPWuED9bdsBWP7SqT1dbKdxuYNEvdyyJjtvglZQ==
X-Received: by 2002:a17:903:234c:b0:20c:cd01:79ae with SMTP id
 d9443c01a7336-21105803b19mr14734255ad.24.1730346845319; 
 Wed, 30 Oct 2024 20:54:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/50] hw/intc/riscv_aplic: Check and update pending when write
 sourcecfg
Date: Thu, 31 Oct 2024 13:52:41 +1000
Message-ID: <20241031035319.731906-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The section 4.5.2 of the RISC-V AIA specification says that any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode.

If an interrupt is asserted before the driver configs its interrupt
type to APLIC, it's pending bit will not be set except a relevant
write to a setip or setipnum register. When we write the interrupt
type to sourcecfg register, if the APLIC device doesn't check
rectified input value and update the pending bit, this interrupt
might never becomes pending.

For APLIC.m, we can manully set pending by setip or setipnum
registers in driver. But for APLIC.w, the pending status totally
depends on the rectified input value, we can't control the pending
status via mmio registers. In this case, hw should check and update
pending status for us when writing sourcecfg registers.

Update QEMU emulation to handle "pre-existing" interrupts.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241004104649.13129-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 32edd6d07b..4a262c82f0 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -159,31 +159,42 @@ static bool is_kvm_aia(bool msimode)
     return kvm_irqchip_in_kernel() && msimode;
 }
 
+static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
+                                          uint32_t irq)
+{
+    uint32_t sourcecfg, sm, raw_input, irq_inverted;
+
+    if (!irq || aplic->num_irqs <= irq) {
+        return false;
+    }
+
+    sourcecfg = aplic->sourcecfg[irq];
+    if (sourcecfg & APLIC_SOURCECFG_D) {
+        return false;
+    }
+
+    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+        return false;
+    }
+
+    raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
+    irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+                    sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+
+    return !!(raw_input ^ irq_inverted);
+}
+
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
-    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret = 0;
+    uint32_t i, irq, rectified_val, ret = 0;
 
     for (i = 0; i < 32; i++) {
         irq = word * 32 + i;
-        if (!irq || aplic->num_irqs <= irq) {
-            continue;
-        }
 
-        sourcecfg = aplic->sourcecfg[irq];
-        if (sourcecfg & APLIC_SOURCECFG_D) {
-            continue;
-        }
-
-        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
-            continue;
-        }
-
-        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
-        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
-                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
-        ret |= (raw_input ^ irq_inverted) << i;
+        rectified_val = riscv_aplic_irq_rectified_val(aplic, irq);
+        ret |= rectified_val << i;
     }
 
     return ret;
@@ -702,6 +713,10 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
             (aplic->sourcecfg[irq] == 0)) {
             riscv_aplic_set_pending_raw(aplic, irq, false);
             riscv_aplic_set_enabled_raw(aplic, irq, false);
+        } else {
+            if (riscv_aplic_irq_rectified_val(aplic, irq)) {
+                riscv_aplic_set_pending_raw(aplic, irq, true);
+            }
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDR)) {
-- 
2.47.0


