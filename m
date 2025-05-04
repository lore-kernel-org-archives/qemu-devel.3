Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLb-0007ew-0y; Sun, 04 May 2025 17:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLZ-0007e8-1u
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLX-0005E5-7S
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:58:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so33503155ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395882; x=1747000682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQ/IAr0L2Ye5hjM/5zDI94SM4bR+FE9DXwXYA3N/62o=;
 b=eLuShIx3K+dXoWfUFP6vgdpOTA3BHjz3eGt68r6fb00VTVM2g0VGpflHUPDUuyDG4D
 xW6465ABtn1U5lomnpMFW5zld13otE3z8fkIC4BLq1JH4lIBIT6CUhiMU8hvaSGDAxx2
 mdsGOgKkSydekM1JRM/u87VsHR2tfO/FTXVdbdR4bV7E5UtOp1SuSY+LWMW/VoyYchPq
 t26ujW3GJA09zQYgjjjUCrrXG6Ytee4hUGaPbK0Df8YTsVoYb+d2dnaRbcfXdwIDCte/
 z33iT9MxCx7Qh8DLqg/iAqhg9+3U9sdXtT4TL6uzSUzwtU5iXMCThMJ8FuiiDFos3Dy5
 jZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395882; x=1747000682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZQ/IAr0L2Ye5hjM/5zDI94SM4bR+FE9DXwXYA3N/62o=;
 b=VOwsrd0xu3jkoQgj7j3j7E+1P/XvFxafwzc5H885PLuS0tUoZoxMdugTiU/McnDovG
 qoF7h7wXT8priNRfgDbpAcIa5lsc6m8IELiPYMxepi7VHeMQizZBvCd9KUzlJH+GC1rl
 tCBJB85LpgExg1FqOvGAc12UUGQ/3GcquJzL/74IjWhYl9tiNz0Q2lsV5IdTloOGPZAx
 ZprrhoNydOVCisCb3tofM6KJo4EWduCOz/mmF79edMJozMPXtkELsOcIFpphtlJa5AAI
 WT/HXY1p5quqoJvGappDWh+j0bLsFvYmP+8CmTupiCiorOnOWAaOstE1est3s090WnhQ
 uRuw==
X-Gm-Message-State: AOJu0YxEz/IX1HFX3ZrZIQGmeU5XJhPikUnUsnpJ0xsQgXxOp3Hdhm/l
 D3SRPic2c0P9k3ZhL3iqs+YDvsu4k7/4XNV/xp9soSbtKtEeuvpy7hrl2NLJZ92oRolDd3M3Ozq
 sABg=
X-Gm-Gg: ASbGncs6qgq/rG91OLHRZATlEI4S1QrBg7reCT5y/16aaLl0Z8OgT7Ht3PR3qU+ddHn
 13RN+lqH6aXxdE1eWDUmacLeN5VjBDEBdAMkKqElYn2BF731hW+3/9mqk1MuXOZxw+rIBgQFiLD
 EHoy629/KVMfFxAr8sCcxE3540nprEzZfW8Kz10+IZkkWhCl7NTVbveWXbW+tj/D5etNnAxhfke
 U4/16v5gvv1TPvxCPktC4oTSrvXp1E1fE2IRgh1ilnyanatnVrHDDYlk/GaVC6Umf8K9v1Egbq9
 b69zkgtIK3kVD5htBRh0Ow1bjCQOpPdX6W7Z4VDnxzuQm5oV
X-Google-Smtp-Source: AGHT+IFXrhvAcF8x3OxhvGDQwhP2PJYnVsaoA+xNbyCx7Jnw9h0qxvBlO2eTj20uBXbBU6q9a+BxMQ==
X-Received: by 2002:a17:902:ce83:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-22e1036cfdamr164992485ad.43.1746395881604; 
 Sun, 04 May 2025 14:58:01 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:58:01 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/acpi/pcihp: Fix typo in function name
Date: Sun,  4 May 2025 21:56:38 +0000
Message-Id: <20250504215639.54860-10-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix typo in QEMU's ACPI PCI hotplug API function name that checks
whether a given bus is hotplug-capable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
 hw/acpi/ich9.c                  | 2 +-
 hw/acpi/pcihp.c                 | 2 +-
 hw/acpi/piix4.c                 | 2 +-
 include/hw/acpi/pcihp.h         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index b67b4a92da..b7bc6e40a1 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -34,7 +34,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
 {
 }
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
 {
     return true;
 }
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c7a735bf64..a07c9d115b 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -570,7 +570,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
-    return acpi_pcihp_is_hotpluggbale_bus(&lpc->pm.acpi_pci_hotplug, bus);
+    return acpi_pcihp_is_hotpluggable_bus(&lpc->pm.acpi_pci_hotplug, bus);
 }
 
 void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 5f79c9016b..aac90013d4 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -371,7 +371,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
 {
     Object *o = OBJECT(bus->parent);
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index b16d45f03e..d98b80df6d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,7 +406,7 @@ static bool piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
                                       BusState *bus)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
-    return acpi_pcihp_is_hotpluggbale_bus(&s->acpi_pci_hotplug, bus);
+    return acpi_pcihp_is_hotpluggable_bus(&s->acpi_pci_hotplug, bus);
 }
 
 static void piix4_pm_machine_ready(Notifier *n, void *opaque)
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ac21a95913..a97904bada 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpState {
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
                      MemoryRegion *io, uint16_t io_base);
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
 void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
 void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
-- 
2.34.1


