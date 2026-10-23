Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n87dpCUV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3N-0003OQ-K8; Fri, 23 Oct 2026 10:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3A-0003HQ-FZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG38-0006Yp-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so7753015e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764913; x=1793369713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=syDevahi+gLt3lC9ZT789aLDCSxqDn+34Mwp/R4yeME=;
 b=n87dpCUVSX21oWpJOg/K/UsUEHDd9HNZKVRArI8pYcUzkhPx4/u4bX31uYOBJ9JHa6
 bZ+cjxk9tlIEg8zOQJ2inNYfsoWeEWMI9orQbxv/fBrgEraiBn5eOvNzvwDNTHfFfvTY
 LEWGkjtHw5nLPJBjH/fd47JCbvJU8B2BKwUxnN7ggiouRMMXvlA0R1UizqhooefR3WNQ
 g9eZYYUMaacE0lBUXT8TG5+XEBMgxzxtCm6GPN9VzfGkLr/L48HLfg1fuGzzQiX+uyfL
 4HMk2Ty7fyW9aLNopMPFomyXt1huozRj0X7tYWN93TYrUzO7TfSQFqSR8iOGs+Ko/OmW
 AZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764913; x=1793369713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=syDevahi+gLt3lC9ZT789aLDCSxqDn+34Mwp/R4yeME=;
 b=2YnRbbRe9JGopATaM+4kSh/4yiQFkWNUR6TrHKsrWRXIQonhw/+KUWDkRHrikA79sT
 i4RNceW93x8E1v59vmaEwgz7Wg30Plq3IlcbkaRP4weLv3xxfkTwyHsi9W+1XaPb8WOS
 SxjyWz2Pv7upxnOO2XK6Dr29RbSF0YJqNl9Ml2HhmE88Dh5qCKGwUpvLu2JTk6QrUnvg
 jW3fK2ZQEt8syTBKk0D5u4WBvD1Aig0Gq8cK3S0V2uCcQvTAFrfiuSB2/tD/X69oNgcd
 ZCiCzS9eqXAQsMc727x6+lVI1WWttFxPLLY0ahKB4NOQMVDrxRIEHzml7qP8KLl1zskk
 u9LQ==
X-Gm-Message-State: AFq9FYJ4l7mytzDAUEe9JQXdoQP/LlVTzshoiokYheuAmEPjXt4TDuTd
 mEM8HBQCQ44NjbalTdeVow9uWqiriNPu3HoigM/s1OLLk7+rUn4Fu2iqHH4psYYZgjlwBdcV02S
 HvmQuf3c=
X-Gm-Gg: AYBFou08LPy+ApfAD1xV7CaOeCL3XSHb/1muMrM7gyYo6a7/U7EhICFW0orBbR3Suqh
 ddMaUDq6pSO7awjI65MKd3jf6+l/ia3249g7MTMNcyvdfWPxc7M81Pk6GHYkoqQB+tGbS2GwvW9
 CYKow3Z7/6lutozC11k0xDiBn2KBRyrcWCfTzXFY6NSPA0YbmrTWbE3GAJ5S1G2sgjabDPtAiSm
 pejym7txk3RC3Qxt1p99G+puWwz/vg6o+do4YS2RvkHFEj+acJNPw9KZLWzErOIYuyyjCOxZQ8T
 Za9B/atiCmDSHmScxYwi2hKIVA+Fbto+wFEWT7jrX7AUFZx+lnD4m1LsKJ1i0njyNn1YD4SgAk/
 ZCbwiP0iK0t+ZfCusCPpddAZSo6Dt9gcq5R0Pn4sb67aJeHD5DHbHFVI6I0O2CAUGlzPefctsPG
 +XMzcfUMHrY4mKZaQw8aEoNo0NrEW9DZ38nFyCtBZFPwd60lt1sx2BgZnGRqfiAsBspH0YOjttQ
 Apo6XQOrLtbz6gHu9wGakC7FYkqGxCWARu9N/kOuEpTQmwUgGFvAfgPkUcPnmxteL2icgEoLadH
 Wdv/QgKsauoag6mxEUSgg1ZCGnevYTnLzpeh20uyYC9mI/3skTah634QqvPL
X-Received: by 2002:a05:600c:c110:b0:4a2:ae8:3dff with SMTP id
 5b1f17b1804b1-4a211f007eemr30797245e9.34.1792764912702; 
 Fri, 23 Oct 2026 07:15:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] hw/arm/bcm2838: enable BCM2838 thermal sensor
Date: Fri, 23 Oct 2026 15:14:51 +0100
Message-ID: <20261023141503.1397009-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

Wire the BCM2838 thermal sensor (added in the previous patch) into
the SoC: instantiate it in the peripherals block and map its
register region at the real BCM2711 physical address. Also stop
raspi4b from masking out the "brcm,bcm2711-thermal" device-tree
node, now that the sensor it describes is actually implemented.

Adapted from patch 17/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261015181111.60491-5-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     |  1 -
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 15423527e80..a720eea8216 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2838_rng200.h"
+#include "hw/misc/bcm2838_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -66,6 +67,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     BCM2838Rng200State rng200;
+    Bcm2838ThermalState thermal;
     SDHCIState emmc2;
     BCM2838GpioState gpio;
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 35e2fc005ca..f4e9cb88f1f 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -38,6 +38,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Random Number Generator */
     object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
 
+    /* Thermal */
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -72,6 +75,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
     MemoryRegion *rng200_mr;
     qemu_irq rng_200_irq;
+    MemoryRegion *thermal_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -96,6 +100,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                          BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
 
+    /* THERMAL */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
+        return;
+    }
+    thermal_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0);
+    memory_region_add_subregion(&s->peri_low_mr, 0x15D2000, thermal_mr);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 87fcba036d8..61adccded97 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-pcie",
-        "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
 
-- 
2.43.0


