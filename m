Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF4FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOp-0000Uo-43; Mon, 27 Apr 2026 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNN-0007lR-4k
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNK-0005Sg-Nh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so126639755e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294064; x=1777898864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AQb5G+E5ajG0E+LBF57eBp4L/RpYLZ+IMh399SSPq7U=;
 b=FrtjvHHet2yK1VlIrHw5TcB3TlMBqokaHwov1V81bWtqARvH2NCixoxZlsjvO9YH3q
 UOqKU7ua/6wMXYgZ3BRIb62XNIk06s3OJB1JJ+szjWJVa9ZpsisYbk/Lmo4l6IlxMZZ2
 oYBP557bPibXYbSjFAwOzYFO26czCVEQUotZh6hz5PfCZwliTV3UPmQkiBH5B7I7wuat
 XiPy53gIbJrMRiU4zU5ER+vtX0V7fzVHmBnhzQET7oAOW+8r/zhjtOP0WKPl/Y9Do5z7
 skNAD92d0/YxElsAgcq538K7FehwRPHgvDNgkhXK5ES6vsS5aI8eeuzDcJTovi+PVwqn
 Y1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294064; x=1777898864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AQb5G+E5ajG0E+LBF57eBp4L/RpYLZ+IMh399SSPq7U=;
 b=Z+WLtbOP7Yyu4xTCBPikIe/+lMFVO5dVfYdZ+esyEG+HpKIXVv1g0GM7rLASgzOSCp
 GNG6p2zHOE5B8V4cwzceBD4eBaVMElnkWuobe7n2gMEi1H7yFK1l92zXMMrGEv6vw/OJ
 NnwLodI5jtEfAZqA0QxYNGb69Y3kKKc9/bmAXv0a7NV10gV0EXWvQeXbxds81J5hkjSw
 TkitpAnZp85A5vOfR4uKrWqZa1pJcRYyePosAUg/0yMC9TKy8LxlTMuZIJTOdcKdh3U1
 DjUEUnJh/1K3eXxQUueHMDU6vlE5hy5DoqCKCRk+TEucErJ5q1zveKmZVYekc/mQaEcM
 +5Mw==
X-Gm-Message-State: AOJu0Yy0o8Ex5gKD6SyYuC5og5Pr19cqi7ZimaEmU5WUb/aHxefqipR7
 XxGzRQ5PdcKlixZCz38umKiz2FszNs03crZQLBzOTyw6jthCOR8Bq/z+kcFjZ56OpicGuQGvBc8
 WopWB
X-Gm-Gg: AeBDieuAkMJoYwZTVZWv7/Ib/GNvnO7hXaXXacTW3mCEPzEQ1reGljnAoywXTtwroye
 5MAFvuOvNjZsbhgFFJjI+nxaUwLU4T79RIelVdeE5nY1C/d1W/N/bNueVO4NFxnk3aKrmC4V/06
 /2P4iVf2Vr3QTxspn2/ppU0RoisnygsxBO1mnCYIIHesANvy3Ll3KaYNpww7WRyigOvVnfGXHOD
 1fCK1+qI7u/bNEjaUPZrEg93yPPuug5qUP/u0vlX/5Wjg+MTsdhLHFxutYhY0jAwSuogoOZeM1j
 ZpNwkBxyk3wzMvHtdmCcFYiD6fcJBXoad6RETQ4Wy3S2X8RC484gEmpi71Cqa27S2jHNZFQW33d
 IcKehdCUIu9T7QBHzyJAM/JcI+IUa617lpYOlAbzgja4PcpLeM2Aafvn6vGkzmlNuEdwqAo4gkV
 o2hlowukRk73ebhjfWCtdWMM+pheeBPWLN5hshZqSV3ccT9ddnCkr/VWto0o76uRC0O/Cpr3Oef
 xq7rnnnUdjs3imoFaQxu6wn8oteBpA994dDwasLkQ==
X-Received: by 2002:a05:600d:b:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-48a563cd137mr310097505e9.3.1777294063765; 
 Mon, 27 Apr 2026 05:47:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/63] hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
Date: Mon, 27 Apr 2026 13:46:39 +0100
Message-ID: <20260427124738.966578-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Add the Clock Control Module (CCM) device to i.MX8MM SoC.
The CCM implementation is shared with i.MX8MP as the register
layout is identical between the two variants.Hence iMX8MM will
be using the source of iMX8MP CCM.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx8mm.c         | 10 ++++++++++
 include/hw/arm/fsl-imx8mm.h |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b3db2d6848..26dc3e6ed1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -621,6 +621,7 @@ config FSL_IMX8MM
     bool
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
+    select FSL_IMX8MP_CCM
     select IMX
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 8218448074..053434412c 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -169,6 +169,8 @@ static void fsl_imx8mm_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
+
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
     for (i = 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
@@ -305,6 +307,13 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_CCM].addr);
+
     /* Analog */
     object_property_set_uint(OBJECT(&s->analog), "arm-pll-fdiv-ctl0-reset",
                             0x000fa030, &error_abort);
@@ -350,6 +359,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
         case FSL_IMX8MM_ANA_PLL:
+        case FSL_IMX8MM_CCM:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 0a020c32a1..df35f0f5ac 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -14,6 +14,7 @@
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx8mp_analog.h"
+#include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -34,6 +35,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
-- 
2.43.0


