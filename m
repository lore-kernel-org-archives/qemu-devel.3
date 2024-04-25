Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D70C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWb-00028D-0F; Thu, 25 Apr 2024 06:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWW-00022P-2K
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWT-0007DF-4i
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso5214235e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041611; x=1714646411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0tEoEynUn/Blzafott1YrsfCl8+TNo9nbqDoRZ2ImKI=;
 b=GnwWQCiSt30pKDvUa+OPs5eQeBsLtIJm00FASUyiKqw19/HnB8jseaFOm+yvSrzxzU
 C1DgKwR5MpsDuNGC9r2YeQUloCOfIKW9P+ERRzIfg1c+R+Ypiiy3FbkXfsOPThpAa6nu
 3nrKaJnV2VLmzq3MfmdU7tEdf2/QQPFnWaTizP7GOs2J3hkUGY6EHlhfOcx2Uaoll8TH
 dafgPkBQug2MFIjpG8i5l9cbtaBPkGJsOcVhQUTZX1X+5bk+ygE2cPQhOBC5cNZFylm3
 TZFqzkhwzbJnIe7CaA8n2I/IQOyomGF9topcIPXSXVzFNVLKeA1lJs8NhbTMDTzDJx13
 NERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041611; x=1714646411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tEoEynUn/Blzafott1YrsfCl8+TNo9nbqDoRZ2ImKI=;
 b=f8Boo4yy1UfUP612q7m4/4BBwAMstLbdtjplpwOhVmB85phuqCymIQ++rAijKoCgC7
 gGvwiUjidwMg+rsMeA/pRY2/a/eG7CFxv3OML3Ad/6B0aM+edoGK99uZeI5DxyE6HfBm
 4muZhEld2FqwMQXOBF6WZ5XlOUPSifHBFTK0BVgyPOGsNfxVFk40afoCLIkso8GX9kA3
 i5vPXRQiXcCoxPR7C44xS1eRU9V/4GIhNd0sT9UDisc1CCy6EOhnHctQF8TNs9Epzjt3
 Uey2IXXQgMtfgsvZeARlIu0Xjkz11Agh91TagKZmwyfjxpluluu+2pmFqOFWZaDSmXu5
 zCHw==
X-Gm-Message-State: AOJu0Yw9jKjoO5rBkYAt/UBErpVRmorbJ61QRjYr5PDPYpPxv11xojVo
 cEGtLcD+XQRziucawLJ8qDKNNtBREtAqe/SHLkcEAxpzPtVpWxk7QzWB/knGsg/EJlC0bJoPKy+
 L
X-Google-Smtp-Source: AGHT+IHX9ybYHLCatXSYHResAm69x5YnuuHYhGqCcJt54CeTU4kQ9sCDJzfWfWFERZ5f9GuFiYLT3g==
X-Received: by 2002:a7b:c406:0:b0:418:2a57:380c with SMTP id
 k6-20020a7bc406000000b004182a57380cmr4339476wmi.26.1714041611583; 
 Thu, 25 Apr 2024 03:40:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] hw/intc/arm_gicv3: Report the VINMI interrupt
Date: Thu, 25 Apr 2024 11:39:43 +0100
Message-Id: <20240425103958.3237225-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

In vCPU Interface, if the vIRQ has the non-maskable property, report
vINMI to the corresponding vPE.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-23-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 2cf232d099c..bdb13b00e98 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -481,6 +481,7 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
     int idx;
     int irqlevel = 0;
     int fiqlevel = 0;
+    int nmilevel = 0;
 
     idx = hppvi_index(cs);
     trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx,
@@ -498,9 +499,17 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
         uint64_t lr = cs->ich_lr_el2[idx];
 
         if (icv_hppi_can_preempt(cs, lr)) {
-            /* Virtual interrupts are simple: G0 are always FIQ, and G1 IRQ */
+            /*
+             * Virtual interrupts are simple: G0 are always FIQ, and G1 are
+             * IRQ or NMI which depends on the ICH_LR<n>_EL2.NMI to have
+             * non-maskable property.
+             */
             if (lr & ICH_LR_EL2_GROUP) {
-                irqlevel = 1;
+                if (lr & ICH_LR_EL2_NMI) {
+                    nmilevel = 1;
+                } else {
+                    irqlevel = 1;
+                }
             } else {
                 fiqlevel = 1;
             }
@@ -510,6 +519,7 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
     trace_gicv3_cpuif_virt_set_irqs(gicv3_redist_affid(cs), fiqlevel, irqlevel);
     qemu_set_irq(cs->parent_vfiq, fiqlevel);
     qemu_set_irq(cs->parent_virq, irqlevel);
+    qemu_set_irq(cs->parent_vnmi, nmilevel);
 }
 
 static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
-- 
2.34.1


