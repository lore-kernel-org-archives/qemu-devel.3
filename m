Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41917CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11M-0003VB-0A; Thu, 07 May 2026 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11G-0003S2-OY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11D-0003nt-Os
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso11857095e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169125; x=1778773925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qf1DrmdeUL5WS//Blvpc/pWWw3ADDfnrndB1PljHxgM=;
 b=Qkn//XsNNxehx/fIvJCIsQ7Q1qG66pPP2zT6aw8CQ3q8dLsnkYM1AFaHk8TSF/3lVE
 odQa2IrdVMv8hUu8tzLE/k/boASXdGyVDjEVuGruth1OQRmZVKeNEp75J3T+XsOzeL+E
 1G+gVEK9sq7fInpUz1S5XwQyj0ddhJiYVHao3Y5Fkn+y/dUibLP5cS+mYwZF35o4kVLC
 g6vv4/BoETzKBiivBMN8Qmd/ddzDtmDVr47t2Dxh0nKOYLp2lg5iZWQOLa3Cix8Sjwvd
 br1HG9cVZKbyX8FgktuJhq6awVD1HhehhgEw5zZ/3T/Nx2otlXBCWAIEctlIVg2Zxc3e
 dUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169125; x=1778773925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qf1DrmdeUL5WS//Blvpc/pWWw3ADDfnrndB1PljHxgM=;
 b=ijbGtlY9PyLlnasg0YoVSFdwq8/IiUdqBSHWy7Lksq5GkvOe3ZrWmZfZ8dmMDIg8+C
 tC3SArxxlENpMpDS61P3RbJg9Zl1m65OwSy57qdMspz8s6rA39YUzWOcz40VXWMb+UFv
 h5NPh4bGUS8Q1RKfrIbbSwpN4E7sRckGtRWi+r0t7eOgs2kdAj0NoBZaz9RS1fk0ZSvF
 k7GcBblrZGuAeGePVzz5CnyjPgA1eK/UWiwhCtKPibuQ5ysr44JPZZAsmLA0ag7dCCcC
 pDs43/b3dPLdb5lUmQVPz+ycViDOotb5Q409wZyVBtL8tRFDho6sneCZzshYiCVdkDNP
 iCZg==
X-Gm-Message-State: AOJu0YwEvAp3YqFYL5RTZl2t1S/BzH2hkHoOqzh/HyPOY5Yzeg5v2UGj
 xfnZCe220wGRrY5mtfDyNk+KvmhgH6JDZVYs0gBhO/n04oEpm8mKJhNySPil1LHBE1fIgLGhhzZ
 IhmHx
X-Gm-Gg: AeBDieuw2c2c94Ik0iIHBFp1mAJC7u2fv+ChMx90A7OjynK9J64ZIqXrxnN9eCfitVB
 XQFF+yfcyCB7M1jfJ2khrSehuTB6nvifa5ORMJSOuPJnIg2pqLig8AIlGHTeCP3N8WJDZnOTwe0
 oGi/eVMqLXG4Ja+3dGnPA+nXQWicaWTfV/1YatVdi9SZztNbRNSqvgRDzVpkW1c9aUM+aXTf/x+
 49yn+Wci94CJHd0htl72TjDNt+qACDiVHeC7GkD7sMjrh5TsFAtNhNzcMK41nDN1lhPnOyzbmMf
 5HypNi3uFNvJy4CAFpu2RXxoUDIMfl0KY5maOwu0g7vT/WyeUUeSGhzrQ1+g1qXqz0fI1hrf2XL
 IDrmMGR5nEiOSp+3fPahQF2Svirm9SFwr/pOd3NBVn7iQUClxqLj/kfU5z5H2jDpDOxgOydfBuS
 /Gcd7IW360HlH2oEk7tBKyvo3B0pzvclTteaEmQx6W/B6g60QkziOyHivwUeJkC6kNQEZCUJ0PA
 mhV0j5HSKQgiQBWeOO/QHTxnlOgSDU=
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48e635a1ba0mr14092625e9.0.1778169124859; 
 Thu, 07 May 2026 08:52:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/67] hw/intc/arm_gicv5: Implement IRS ID regs
Date: Thu,  7 May 2026 16:50:57 +0100
Message-ID: <20260507155154.1886557-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the IRS frame ID registers IRS_IDR[0-7], IRS_IIDR and
IRS_AIDR.  These are all 32-bit registers.

We make these fields in the GIC state struct rather than just
hardcoding them in the register read function so that we can later
code "do this only if X is implemented" as a test on the ID register
value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-11-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 115 +++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h |  39 ++++++++++
 2 files changed, 154 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 4c1ec8f30a..250925f004 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -268,6 +268,65 @@ REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    uint32_t v = 0;
+
+    switch (offset) {
+    case A_IRS_IDR0:
+        v = cs->irs_idr0;
+        /* INT_DOM reports the domain this register is for */
+        v = FIELD_DP32(v, IRS_IDR0, INT_DOM, domain);
+        if (domain != GICV5_ID_REALM) {
+            /* MEC field RES0 except for the Realm domain */
+            v &= ~R_IRS_IDR0_MEC_MASK;
+        }
+        if (domain == GICV5_ID_EL3) {
+            /* VIRT is RES0 for EL3 domain */
+            v &= ~R_IRS_IDR0_VIRT_MASK;
+            /* ...which means VIRT_ONE_N is also RES0 */
+            v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
+        }
+        return true;
+
+    case A_IRS_IDR1:
+        *data = cs->irs_idr1;
+        return true;
+
+    case A_IRS_IDR2:
+        *data = cs->irs_idr2;
+        return true;
+
+    case A_IRS_IDR3:
+        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
+        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
+        return true;
+
+    case A_IRS_IDR4:
+        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
+        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
+        return true;
+
+    case A_IRS_IDR5:
+        *data = cs->irs_idr5;
+        return true;
+
+    case A_IRS_IDR6:
+        *data = cs->irs_idr6;
+        return true;
+
+    case A_IRS_IDR7:
+        *data = cs->irs_idr7;
+        return true;
+
+    case A_IRS_IIDR:
+        *data = cs->irs_iidr;
+        return true;
+
+    case A_IRS_AIDR:
+        *data = cs->irs_aidr;
+        return true;
+    }
+
     return false;
 }
 
@@ -422,6 +481,60 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
     }
 }
 
+static void gicv5_set_idregs(GICv5Common *cs)
+{
+    /* Set the ID register value fields */
+    uint32_t v;
+
+    /*
+     * Fields in IDR0 for optional parts of the spec that we don't
+     * implement are 0.
+     */
+    v = 0;
+    /*
+     * We can handle physical addresses of any size, so report support
+     * for 56 bits of physical address space.
+     */
+    v = FIELD_DP32(v, IRS_IDR0, PA_RANGE, 7);
+    v = FIELD_DP32(v, IRS_IDR0, IRSID, cs->irsid);
+    cs->irs_idr0 = v;
+
+    v = 0;
+    v = FIELD_DP32(v, IRS_IDR1, PE_CNT, cs->num_cpus);
+    v = FIELD_DP32(v, IRS_IDR1, IAFFID_BITS, QEMU_GICV5_IAFFID_BITS - 1);
+    v = FIELD_DP32(v, IRS_IDR1, PRI_BITS, QEMU_GICV5_PRI_BITS - 1);
+    cs->irs_idr1 = v;
+
+    v = 0;
+    /* We always support physical LPIs with 2-level ISTs of all sizes */
+    v = FIELD_DP32(v, IRS_IDR2, ID_BITS, QEMU_GICV5_ID_BITS);
+    v = FIELD_DP32(v, IRS_IDR2, LPI, 1);
+    v = FIELD_DP32(v, IRS_IDR2, MIN_LPI_ID_BITS, QEMU_GICV5_MIN_LPI_ID_BITS);
+    v = FIELD_DP32(v, IRS_IDR2, IST_LEVELS, 1);
+    v = FIELD_DP32(v, IRS_IDR2, IST_L2SZ, 7);
+    /* Our impl does not need IST metadata, so ISTMD and ISTMD_SZ are 0 */
+    cs->irs_idr2 = v;
+
+    /* We don't implement virtualization yet, so these are zero */
+    cs->irs_idr3 = 0;
+    cs->irs_idr4 = 0;
+
+    /* These three have just one field each */
+    cs->irs_idr5 = FIELD_DP32(0, IRS_IDR5, SPI_RANGE, cs->spi_range);
+    cs->irs_idr6 = FIELD_DP32(0, IRS_IDR6, SPI_IRS_RANGE, cs->spi_irs_range);
+    cs->irs_idr7 = FIELD_DP32(0, IRS_IDR7, SPI_BASE, cs->spi_base);
+
+    v = 0;
+    v = FIELD_DP32(v, IRS_IIDR, IMPLEMENTER, QEMU_GICV5_IMPLEMENTER);
+    v = FIELD_DP32(v, IRS_IIDR, REVISION, QEMU_GICV5_REVISION);
+    v = FIELD_DP32(v, IRS_IIDR, VARIANT, QEMU_GICV5_VARIANT);
+    v = FIELD_DP32(v, IRS_IIDR, PRODUCTID, QEMU_GICV5_PRODUCTID);
+    cs->irs_iidr = v;
+
+    /* This is a GICv5.0 IRS, so all fields are zero */
+    cs->irs_aidr = 0;
+}
+
 static void gicv5_realize(DeviceState *dev, Error **errp)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
@@ -448,6 +561,8 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
      * NS domain.
      */
     cs->implemented_domains = (1 << GICV5_ID_NS);
+
+    gicv5_set_idregs(cs);
     gicv5_common_init_irqs_and_mmio(cs, gicv5_set_spi, config_frame_ops);
 }
 
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 10276d652f..21e1d7a21d 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -65,6 +65,18 @@ struct GICv5Common {
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
 
+    /* ID register values: set at realize, constant thereafter */
+    uint32_t irs_idr0;
+    uint32_t irs_idr1;
+    uint32_t irs_idr2;
+    uint32_t irs_idr3;
+    uint32_t irs_idr4;
+    uint32_t irs_idr5;
+    uint32_t irs_idr6;
+    uint32_t irs_idr7;
+    uint32_t irs_iidr;
+    uint32_t irs_aidr;
+
     /* Properties */
     uint32_t num_cpus;
     ARMCPU **cpus;
@@ -84,6 +96,33 @@ struct GICv5CommonClass {
 
 #define IRS_CONFIG_FRAME_SIZE 0x10000
 
+/*
+ * The architecture allows a GICv5 to implement less than the full
+ * width for various ID fields. QEMU's implementation always supports
+ * the full width of these fields. These constants define our
+ * implementation's limits.
+ */
+
+/* Number of INTID.ID bits we support */
+#define QEMU_GICV5_ID_BITS 24
+/* Min LPI_ID_BITS supported */
+#define QEMU_GICV5_MIN_LPI_ID_BITS 14
+/* IAFFID bits supported */
+#define QEMU_GICV5_IAFFID_BITS 16
+/* Number of priority bits supported in the IRS */
+#define QEMU_GICV5_PRI_BITS 5
+
+/*
+ * There are no TRMs currently published for hardware implementations
+ * of GICv5 that we might identify ourselves as. Instead, we borrow
+ * the Arm Implementer code and pick a fake product ID that is
+ * unlikely to be used by any real Arm hardware.
+ */
+#define QEMU_GICV5_IMPLEMENTER 0x43b
+#define QEMU_GICV5_PRODUCTID 0xfff
+#define QEMU_GICV5_REVISION 0
+#define QEMU_GICV5_VARIANT 0
+
 /**
  * gicv5_common_init_irqs_and_mmio: Create IRQs and MMIO regions for the GICv5
  * @s: GIC object
-- 
2.43.0


