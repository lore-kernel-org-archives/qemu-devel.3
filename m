Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A4D74964
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 07:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWUXj-0003t5-4k; Fri, 19 Dec 2025 02:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DPlEaQYKCmMZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com>)
 id 1vWUXg-0003rF-QJ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:48 -0500
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DPlEaQYKCmMZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com>)
 id 1vWUXe-0001ev-QY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 02:04:48 -0500
Received: by mail-dl1-x124a.google.com with SMTP id
 a92af1059eb24-11bd7a827fdso4540950c88.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 23:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1766127885; x=1766732685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=lpBaqT4r3FPCklQHTmWh52dS4CLScNaCba4saLnGc+8=;
 b=RfSB9zUaUv1sxaR2BbBkB8r9wj5mnBFf+MR7AeQepQaUNMTarTpkznyFaai2AkKSuU
 ZqUSYE+P6oR/698FsNuQgV0d+m74QfD6CdapECwF+pV6fkZIQy2gcih4Fs0NNUakDyNg
 v4p7GsbOEm5P/uAm5cCABPpmHB9VIOF9dcdIBvuo1y3kbJijzi4blRtWqy9tVPrjOnOL
 kTGAhWrLUIU4QBHYB1RbhrePCpktOaLMYYGwD+gM5vNgG1RwIag7r1gTm2fdItvrypW8
 YRd4vyj3i4CxuT+57FvSp7X900aBba2hf7ra/rCZ1bQbhSlpxjvCrAdSe0KHYu6yf3QO
 KaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766127885; x=1766732685;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lpBaqT4r3FPCklQHTmWh52dS4CLScNaCba4saLnGc+8=;
 b=lmPR0RO2ZVHlansnq9zUM03wtW66WQBFNRYT5d5CczA+ipnKHH/y08we7niifgo0Q2
 IBqOvYbPO0BXTShzMtwvIqX3anPvhPsyaDD3ZO/sUTuQeJJL8C8POSBh9ZKcbzzsdxPG
 YamVGs2dz+w0tvK5ypB7s1aEprT4nMSbv6daB83nUC2k3f5M7mSN+EtpvnF78rT2js4q
 xf1B+3AD4h+7xWZL46agafSbPdGUyxA13nLPOyXRN/SXostof4UHLCnRoPcIFJqR1ayQ
 DNhM8QtsCwUSUkw3N759UY9NZbN/bemB8dHXNEkEPld4bgWyHCJ8ZnZX/3QClrnuGZcV
 TQtg==
X-Gm-Message-State: AOJu0Yy4y97D9KIswvCrYdVlZTjJKodUskNrEEdeeYto6w1+oMIeWaXL
 TvcxhsKETOgAZpnPOSL6UA+3WOV89Xd4MfBzbkcGqUro7PHWjpWqcw2L14y28yydnqFkq37iNb2
 AF0HXFiaYAkFWYI24FKcfSs/zGdRRkc8xyAPtd1SLA4wWl386eNsFhw0skgi+wPjlpqQeqNBJss
 FoAc4h96su5xYhMQK/fFIEV+Ta97PklXa8Qgo=
X-Google-Smtp-Source: AGHT+IFAlkd9HsAiP5BzqXUz2oXPQsR+m3rEfgAzPQD1t+E3GgqPCheh3XZ94iRBWvotxeir5tmoju+nq5g=
X-Received: from dldoa5.prod.google.com ([2002:a05:701a:ca85:b0:120:56a0:1dd9])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e01:b0:11b:f271:835a
 with SMTP id a92af1059eb24-120619277e0mr5701950c88.3.1766127884694; Thu, 18
 Dec 2025 23:04:44 -0800 (PST)
Date: Fri, 19 Dec 2025 07:04:17 +0000
In-Reply-To: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Mime-Version: 1.0
References: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251219-aspeed-sgpio-v5-4-fd5593178144@google.com>
Subject: [PATCH v5 4/6] hw/arm/aspeed_soc: Update Aspeed SoC to support two
 SGPIO controllers
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>,
 "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::124a;
 envelope-from=3DPlEaQYKCmMZVCJOaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--yubinz.bounces.google.com;
 helo=mail-dl1-x124a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This commit updates the Aspeed SoC model to support two SGPIO
controllers, reflecting the hardware capabilities of the AST2700

The memory map and interrupt map are updated to include entries for
two SGPIO controllers (SGPIOM0 and SGPIOM1). This change is a
prerequisite for the full implementation of the SGPIO device model.

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  8 ++++++--
 hw/arm/aspeed_ast10x0.c     |  6 +++---
 hw/arm/aspeed_ast27x0.c     | 10 ++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4b8e599f1a53bfb2e4d3196d5495cd316f799354..18ff961a38508c5df83b46e187f=
732d736443f20 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -32,6 +32,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/gpio/aspeed_sgpio.h"
 #include "hw/sd/aspeed_sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qom/object.h"
@@ -46,6 +47,7 @@
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
=20
 #define ASPEED_SPIS_NUM  3
+#define ASPEED_SGPIO_NUM 2
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
 #define ASPEED_CPUS_NUM  4
@@ -89,6 +91,7 @@ struct AspeedSoCState {
     AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
+    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
@@ -106,7 +109,6 @@ struct AspeedSoCState {
     UnimplementedDeviceState pwm;
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
-    UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
@@ -166,6 +168,7 @@ struct AspeedSoCClass {
     uint64_t secsram_size;
     int pcie_num;
     int spis_num;
+    int sgpio_num;
     int ehcis_num;
     int wdts_num;
     int macs_num;
@@ -221,6 +224,8 @@ enum {
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
+    ASPEED_DEV_SGPIOM0,
+    ASPEED_DEV_SGPIOM1,
     ASPEED_DEV_RTC,
     ASPEED_DEV_TIMER1,
     ASPEED_DEV_TIMER2,
@@ -263,7 +268,6 @@ enum {
     ASPEED_DEV_I3C,
     ASPEED_DEV_ESPI,
     ASPEED_DEV_UDC,
-    ASPEED_DEV_SGPIOM,
     ASPEED_DEV_JTAG0,
     ASPEED_DEV_JTAG1,
     ASPEED_DEV_FSI1,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 7f49c13391be0b923e317409a0fccfa741f5e658..c141cc080422579ca6b6965369d=
84dfbe416247b 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] =3D {
     [ASPEED_DEV_ESPI]      =3D 0x7E6EE000,
     [ASPEED_DEV_SBC]       =3D 0x7E6F2000,
     [ASPEED_DEV_GPIO]      =3D 0x7E780000,
-    [ASPEED_DEV_SGPIOM]    =3D 0x7E780500,
+    [ASPEED_DEV_SGPIOM0]   =3D 0x7E780500,
     [ASPEED_DEV_TIMER1]    =3D 0x7E782000,
     [ASPEED_DEV_UART1]     =3D 0x7E783000,
     [ASPEED_DEV_UART2]     =3D 0x7E78D000,
@@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] =3D {
     [ASPEED_DEV_I2C]       =3D 110, /* 110 ~ 123 */
     [ASPEED_DEV_KCS]       =3D 138, /* 138 -> 142 */
     [ASPEED_DEV_UDC]       =3D 9,
-    [ASPEED_DEV_SGPIOM]    =3D 51,
+    [ASPEED_DEV_SGPIOM0]   =3D 51,
     [ASPEED_DEV_JTAG0]     =3D 27,
     [ASPEED_DEV_JTAG1]     =3D 53,
 };
@@ -427,7 +427,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev=
_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
                                   "aspeed.sgpiom",
-                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
=20
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
                                   "aspeed.jtag",
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c484bcd4e22fb49faf9c16992ae2cdfd6cd82da4..e5f04bd16e80696e41005d9062a=
6df6d060b8088 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
     [ASPEED_DEV_ADC]       =3D  0x14C00000,
     [ASPEED_DEV_SCUIO]     =3D  0x14C02000,
     [ASPEED_DEV_GPIO]      =3D  0x14C0B000,
+    [ASPEED_DEV_SGPIOM0]   =3D  0x14C0C000,
+    [ASPEED_DEV_SGPIOM1]   =3D  0x14C0D000,
     [ASPEED_DEV_I2C]       =3D  0x14C0F000,
     [ASPEED_DEV_INTCIO]    =3D  0x14C18000,
     [ASPEED_DEV_PCIE_PHY2] =3D  0x14C1C000,
@@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] =3D {
     [ASPEED_DEV_KCS]       =3D 128,
     [ASPEED_DEV_ADC]       =3D 130,
     [ASPEED_DEV_GPIO]      =3D 130,
+    [ASPEED_DEV_SGPIOM0]   =3D 130,
+    [ASPEED_DEV_SGPIOM1]   =3D 130,
     [ASPEED_DEV_I2C]       =3D 130,
     [ASPEED_DEV_FMC]       =3D 131,
     [ASPEED_DEV_WDT]       =3D 131,
@@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {
     [ASPEED_DEV_I2C]       =3D 194,
     [ASPEED_DEV_ADC]       =3D 194,
     [ASPEED_DEV_GPIO]      =3D 194,
+    [ASPEED_DEV_SGPIOM0]   =3D 194,
+    [ASPEED_DEV_SGPIOM1]   =3D 194,
     [ASPEED_DEV_FMC]       =3D 195,
     [ASPEED_DEV_WDT]       =3D 195,
     [ASPEED_DEV_PWM]       =3D 195,
@@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] =3D {
     [ASPEED_DEV_I2C]        =3D 0,
     [ASPEED_DEV_ADC]        =3D 16,
     [ASPEED_DEV_GPIO]       =3D 18,
+    [ASPEED_DEV_SGPIOM0]    =3D 21,
+    [ASPEED_DEV_SGPIOM1]    =3D 24,
 };
=20
 /* GICINT 131 */
@@ -1061,6 +1069,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectCla=
ss *oc, const void *data)
     sc->sram_size    =3D 0x20000;
     sc->pcie_num     =3D 0;
     sc->spis_num     =3D 3;
+    sc->sgpio_num    =3D 2;
     sc->ehcis_num    =3D 2;
     sc->wdts_num     =3D 8;
     sc->macs_num     =3D 1;
@@ -1089,6 +1098,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, const void *data)
     sc->sram_size    =3D 0x20000;
     sc->pcie_num     =3D 3;
     sc->spis_num     =3D 3;
+    sc->sgpio_num    =3D 2;
     sc->ehcis_num    =3D 4;
     sc->wdts_num     =3D 8;
     sc->macs_num     =3D 3;

--=20
2.52.0.351.gbe84eed79e-goog


