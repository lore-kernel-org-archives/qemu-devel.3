Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90084CCD186
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q9-0005hS-J5; Tue, 07 Oct 2025 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q8-0005h8-1m
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ps-00029k-P9
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so32547715e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846303; x=1760451103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vxXaXfqv3cWb8+YSgVKngrQxGlcnGKZMSI57st3PZGE=;
 b=ioW+0+xJ3tiYP+0JqFQ9NzPAHdP6cZSAjNkUdOX2rE531UvlojQ1VfqIs+hSlJwyOD
 XYOtSIVJXU8F065245TjRei2ULfGudsCaBL3SwCnTTKYgHWfVVabjwNLaWW2rRgoINMo
 Ks1xYCGl6mluL2eEwXsVTqxz4KXo3B/GUamwqdR3tfUsh+aoYL0ijaj0zyWCiDjat3wI
 CK4RkBYC79k/jMqWsvxec8maQ7iqkNSCc16B6WaREioTU+dIQcfqqY7sEymwbA7/jOro
 NSBa1fN2ToH3Ge8vSD+wfKLP1/j39SW90MX8c+6cuxKz17/UegifWhCkY9AE9ZzYK1hk
 C5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846303; x=1760451103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxXaXfqv3cWb8+YSgVKngrQxGlcnGKZMSI57st3PZGE=;
 b=xSqDmhb6ZUgH1EAq3nwjUr15L060xwar5+EPGiUisUDFcPQAsvnKdAtyHZDXWMnyNn
 6HJsLdoMkQ9pQU6BFmSJhpvQLv3f9503GF8Mhug38mH78P+wL68v0VSdnc6TYw1w9zCH
 8a1QB7K+Je4xtL82cr/HRdnPWmfGTun8CoctrrVAEWFk+nKFOQw8xK9zlGwhZN2HpCxL
 g4loUlKBrGA1L/IcjaE6HJS2ro1OUyBrbBjioIJVj6T/d8Vx3zLKYvDRLR0QBiLxRmbF
 AX68/CCUzadRKM3hTc3r8Rio6BQR53NqRsmeHnmGAKxZGJYX9qP/63u9wir2zdM2GRwS
 EO/Q==
X-Gm-Message-State: AOJu0YyEJ8ChKVZELQxVgJohUIwfg1Gpu4Y8gt+x59KCpsqT3hntuSjf
 xVZucn5tal30B2PnwK5rBrIXu7pB21FjBnUqg7z2KR97/96k9dHERpK/qIInIzhwMVuaUbS8CMB
 UAau4
X-Gm-Gg: ASbGncsbddbFwbUR0326tmqvd1lWRx0jt6s6xAYnKlrfIM7NHWhc7b8NcG21jGUmMEc
 K/stoqof6dvprfh7ZUDHXjTfarjI8Ojr8O1zwG3Xvpcj49RCKreSSNPHPCmBR/7h5/5wDfCXhI/
 VTtsSvSrkvLalQ2L608e1yOactc6RI41xt0gjT0Pztr5hSKyNJewYrOZ1TW791QFkEF9aPqpVPK
 shRZ4Q10jU7ScH52I8r//I8frJACgiHNlInF6JJhZDQe+MujH9Gkco+0d2025lbNjM6nlYbNe7X
 jk/hWFxjkYUF8Hh7OtNLb2nGth8Pq7SzIvfsFhKQJm4N01TM94Lxi2eS4dTg9SA/VK+HDP+ImC4
 9LgEcfXelSShHNidtiFRQHmwe/EJ7wsKRS37FeIi/lxSDWBoN5RldNyDU
X-Google-Smtp-Source: AGHT+IF1gPFPSyBdhRrVJdZzaEUEJO6H2EfkNbO3c2dJ6Zm7ty0PmiCsYq7Dbiti/T1Eeixmmkc7Gw==
X-Received: by 2002:a05:600c:6b10:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-46fa296e00fmr16900425e9.7.1759846302834; 
 Tue, 07 Oct 2025 07:11:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/62] hw/arm/xlnx-versal: trng: refactor creation
Date: Tue,  7 Oct 2025 15:10:36 +0100
Message-ID: <20251007141123.3239867-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the TRNG device creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-16-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  2 --
 hw/arm/xlnx-versal.c         | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9adce02f8a9..bba96201d37 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -20,7 +20,6 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/misc/xlnx-versal-crl.h"
-#include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -83,7 +82,6 @@ struct Versal {
     /* The Platform Management Controller subsystem.  */
     struct {
         XlnxZynqMPRTC rtc;
-        XlnxVersalTRng trng;
         XlnxVersalCFUAPB cfu_apb;
         XlnxVersalCFUFDRO cfu_fdro;
         XlnxVersalCFUSFR cfu_sfr;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 31ceaf61bed..7a97d5df6b8 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -37,6 +37,7 @@
 #include "hw/ssi/xlnx-versal-ospi.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/nvram/xlnx-bbram.h"
+#include "hw/misc/xlnx-versal-trng.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -121,6 +122,7 @@ typedef struct VersalMap {
 
     VersalSimplePeriphMap pmc_iou_slcr;
     VersalSimplePeriphMap bbram;
+    VersalSimplePeriphMap trng;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -164,6 +166,7 @@ static const VersalMap VERSAL_MAP = {
 
     .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
     .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
+    .trng = { 0xf1230000, 141 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -780,19 +783,18 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
 }
 
-static void versal_create_trng(Versal *s, qemu_irq *pic)
+static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr;
 
-    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
-                            TYPE_XLNX_VERSAL_TRNG);
-    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_VERSAL_TRNG));
+    object_property_add_child(OBJECT(s), "trng", OBJECT(sbd));
+    sysbus_realize_and_unref(sbd, &error_abort);
 
     mr = sysbus_mmio_get_region(sbd, 0);
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 }
 
 static void versal_create_xrams(Versal *s, const struct VersalXramMap *map)
@@ -1338,10 +1340,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                                        "ospi-mux-sel", 0));
 
     versal_create_bbram(s, &map->bbram);
+    versal_create_trng(s, &map->trng);
 
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
-    versal_create_trng(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
-- 
2.43.0


