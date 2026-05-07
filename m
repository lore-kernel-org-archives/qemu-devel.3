Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0913CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11U-0003cP-4k; Thu, 07 May 2026 11:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11T-0003bX-1v
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11R-0003sT-9A
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so12020685e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169140; x=1778773940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=facN1UwDMu3JSY3ts6JtzkWbj7pqYVHY8oHKersaP0k=;
 b=Thk775SOVtRczepkMYim8ASKGHW3zPokdeHfI1af0/BREITs294M7pwAX8RGfSlMSn
 3z7nc28yrDMhrFJKkZbniciTowiaAfbD0Uel3lpWcox1gXlDLDF87fE19BsJOTD6rtnE
 ONjn/jjGLVZTeDvyQoOxEDT8VmnwSnCpJvyczzL5Ep3ZMRuSyhGzcmH0oEEcDtGINOT6
 Rrs2twnuaqN/JejwRuRxPGh4hYAKBENgLpkgaB9DFCfoqit0HXkgUPZd1XYJSTu70cvj
 eMe0RrwXpwDAnOWvRLjNryYuWV3PWInUxGha81fVFweXlqpsaie4+e/vYQZnZb2wpOyh
 Z3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169140; x=1778773940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=facN1UwDMu3JSY3ts6JtzkWbj7pqYVHY8oHKersaP0k=;
 b=qU49oWIss3lKao5oRAUeodhInEoSq+nWSa3mosVdanO/LWrGxXLbzl1o7rIXx8y1k2
 b3z1566p3pH0JC5esn+wbIxiYi2XsfmpyD8D//73NQ/e4IMLXS0Rg/oHomQprmIyNjBr
 Wpbmcv62epJEzYi5aoGuGJ83JMFxq96isHlFJRdsLmwAgAq7OQNuG01GM1XEYl96ULwz
 lqVwsHt9/BgBOqiZPwXIfLwbrBd2if0lzXO1nYnewJN5/Jf7IaBtqZEKj8YufYsYX0Cm
 O757eVBshs+5MsFf8cuAkQncxySiDRH2SEpEPaSVCqSP6S2tNRqYHus7Vpcoc6sIxcZJ
 tBKA==
X-Gm-Message-State: AOJu0YyOBGgujv1oDZBgJ/X5Tnv6OdWM2RFDfkS9ZD0JjAPdelDpdt5y
 2QRZoULZQMSGenSVYB1XLQFR+N61p5UtISfkJAJdgO7aQyaYG8ssxuhQKP62M2M4sNC2sdxaHKi
 iWKi1
X-Gm-Gg: AeBDiesvco9g131J2nzrQS+vD7w8pUkXz3TyLztYpC7vVGUeGq9OShF1KS4LXO6IpNd
 O7l7KLtab+6nDjxUsfvAHM3Va1yeZStFJHlYbNGeQlRYUHYQzi8xEP4vElXxmGwMtQSBYKJQxaO
 XO4LkIlLu5i/qwli8EOUwOgEtoXKSCt1BdpkaiaJZbcuiwyFS6yDHDwscq8qMM2sF3t9XPuzJ6T
 Mj9QptNrstXeaXy6z54R+qqiYLaDqQF1recsf6zpg+QiiZbcLO1kFYstYqr5JL1/QSlEmw02FhT
 i7pi34PtKC6B42wjnPUi8Bj+8gqM/nva6Ke7K2lZEMRgtP04cg/JoBhektyEk4Al0mMJXlAydsa
 jrtDgJ+72+snd4oBvIL+k/oEkRNTPkUN1GWytxNtLBF13fU/HxWcK2d5w1NYmITXAIfSDw8I8jd
 KSAmO9IFwpET6hOKCO2XE7JKo8h7okHBOdAgIAmQHQM/3vBfdlFLQkGl3EJsYkWrP6QKMriqVew
 Hi+QaYFaOw5iCyfE3GiEXVr1Skb0Z4=
X-Received: by 2002:a05:600d:b:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48e5d91d240mr50277955e9.10.1778169139659; 
 Thu, 07 May 2026 08:52:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/67] hw/intc/arm_gicv5: Create backing state for SPIs
Date: Thu,  7 May 2026 16:51:10 +0100
Message-ID: <20260507155154.1886557-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The GICv5 allows an IRS to implement SPIs, which are fixed-wire
interrupts connected directly to the IRS.  For QEMU we want to use
these for all our traditional fixed-wire interrupt devices.  (The
other option the architecture permits is an Interrupt Wire Bridge
(IWB), which converts from a fixed-wire interrupt to an interrupt
event that is then translated through an ITS to send an LPI to the
ITS -- this is much more complexity than we need or want.)

SPI configuration is set via the same CPUIF instructions as LPI
configuration.  Create an array of structs which track the SPI state
information listed in I_JVVTZ and I_BWPPP (ignoring for the moment
the VM assignment state, which we will add when we add virtualization
support).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-24-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5_common.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 27 +++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_types.h  | 14 ++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 21b40c35a5..aa5877ee05 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -64,6 +64,34 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
 
     memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
+
+    if (cs->spi) {
+        GICv5Domain mp_domain;
+
+        /*
+         * D_YGLYC, D_TVVRZ: SPIs reset to edge-triggered, inactive,
+         * idle, disabled, targeted routing mode, not assigned to a
+         * VM, and assigned to the most-privileged interrupt domain.
+         * Other state is UNKNOWN: we choose to zero it.
+         */
+        memset(cs->spi, 0, cs->spi_irs_range * sizeof(*cs->spi));
+
+        /*
+         * The most-privileged interrupt domain is effectively the
+         * first in the list (EL3, S, NS) that we implement.
+         */
+        if (gicv5_domain_implemented(cs, GICV5_ID_EL3)) {
+            mp_domain = GICV5_ID_EL3;
+        } else if (gicv5_domain_implemented(cs, GICV5_ID_S)) {
+            mp_domain = GICV5_ID_S;
+        } else {
+            mp_domain = GICV5_ID_NS;
+        }
+
+        for (int i = 0; i < cs->spi_irs_range; i++) {
+            cs->spi[i].domain = mp_domain;
+        }
+    }
 }
 
 static void gicv5_common_init(Object *obj)
@@ -142,6 +170,8 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
 
     address_space_init(&cs->dma_as, cs->dma, "gicv5-sysmem");
 
+    cs->spi = g_new0(GICv5SPIState, cs->spi_irs_range);
+
     trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
                                cs->spi_base, cs->spi_irs_range, cs->spi_range);
 }
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 19e1af8ceb..983faa5ef1 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -55,6 +55,25 @@
 
 OBJECT_DECLARE_TYPE(GICv5Common, GICv5CommonClass, ARM_GICV5_COMMON)
 
+/*
+ * This is where we store the state the IRS handles for an SPI.
+ * Generally this corresponds to the spec's list of state in I_JVVTZ
+ * and J_BWPPP. level is a QEMU implementation detail and is where we
+ * store the actual current state of the incoming qemu_irq line.
+ */
+typedef struct GICv5SPIState {
+    uint32_t iaffid;
+    uint8_t priority;
+    bool level;
+    bool pending;
+    bool active;
+    bool enabled;
+    GICv5HandlingMode hm;
+    GICv5RoutingMode irm;
+    GICv5TriggerMode tm;
+    GICv5Domain domain;
+} GICv5SPIState;
+
 /*
  * This class is for common state that will eventually be shared
  * between TCG and KVM implementations of the GICv5.
@@ -67,6 +86,14 @@ struct GICv5Common {
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
 
+    /*
+     * Pointer to an array of state information for the SPIs.  Array
+     * element 0 is SPI ID s->spi_base, and there are s->spi_irs_range
+     * elements in total. SPI state is not per-domain: SPI is
+     * configurable to a particular domain via IRS_SPI_DOMAINR.
+     */
+    GICv5SPIState *spi;
+
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
 
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 20de5b3f46..f6f8709a6a 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -70,4 +70,18 @@ typedef enum GICv5RoutingMode {
     GICV5_1OFN = 1,
 } GICv5RoutingMode;
 
+/*
+ * Interrupt trigger mode (same encoding as IRS_SPI_CFGR.TM) Note that
+ * this is not the same thing as handling mode, even though the two
+ * possible states have the same names. Trigger mode applies only for
+ * SPIs and tells the IRS what kinds of changes to the input signal
+ * wire should make it generate SET and CLEAR events.  Handling mode
+ * affects whether the pending state of an interrupt is cleared when
+ * the interrupt is acknowledged, and applies to both SPIs and LPIs.
+ */
+typedef enum GICv5TriggerMode {
+    GICV5_TRIGGER_EDGE = 0,
+    GICV5_TRIGGER_LEVEL = 1,
+} GICv5TriggerMode;
+
 #endif
-- 
2.43.0


