Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAACC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25b6-0006VC-Pd; Thu, 03 Sep 2026 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b4-0006Ne-UA; Thu, 03 Sep 2026 07:27:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b2-0006pv-Ug; Thu, 03 Sep 2026 07:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8ZHu7/yzHBVaSmcVdMZEvOdbDOzsjlyp6QIYnj/WTEwecJ8H+vrjEDaFzbkP2U/hzLqfz/dTuZ4gc6Shiruuuiqgj0svhfOgaa+jlNg/fgNyHHUzXHKPH4Ona44wpYQDXGnFBaJFPpWDDXvbvx4G31qSA1xhOLt/fja3oLuxEI4aZ19aTkmPTVW0r+lG5gC5BjUmObciUgwAzn6pKgihZk2TxFVC1AU/QD+fWsBFal5xcrOyfs39ormHb3XyIVk22+dE5xrhFx4B/wl70EkUJkBeWOMCQRaTEhm+BJbVPZhiBZaolYPlnl3w0HX1B80mEp2TP8Nfko0SeZCxqdgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPcnScKJUvrxoHt++d+P/6lLlFOlAP1VQgGjaDTFGc0=;
 b=VNzK4KMu3w1nvwGT3ThfN7YhZJssvOJUBJRsKfhS+OD9jR7ypYIajVheV8P95dnDtGWvPsOVZAJ7LfcPAFVN2M6spWAblSK3LDDjCidzj5Uo8VNyzBMKa9qOQ7jOApUnrABP4pm+V6Gh0dbptPb0KE1v51aR2UfwMME2ee/THyvAbodx8tMODbpTj/Fo5ic2tsUqxIW7uPMVVYRGmb0qrh8B8aq08hqnVrgfcZWQR+Xrc5mG+NoYBD1gF8o6xy/OA+ldZrX8BtjIlr7vIK4N+78sXREVZJRliXhnewR68GY7PZnWp/YIkXzDytjSEJVwAux6MGiJ7LkxryUETV5X2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPcnScKJUvrxoHt++d+P/6lLlFOlAP1VQgGjaDTFGc0=;
 b=KZeI7ugYrBBv+J1WtTzyVkv7icD70KU3I1FC5HNO+2ikbsm+lkHqHzS6es+hElOeLqAbnsWxpd5Krf8nEgpclTBvSVa82NogGBs7ssk2JQKzEhpIv6ifSU/b3itRoO9m3DJxMV0u4KwkMd2EefnIwWWLeHFcSlJ/j2goubTeVYoOfi/BZ2f7UTvp7RoKXxRBZcDatPVXXwSjyzm+kwhUCjw/EGDY3ktVJ1MPqZEze6hSFBBGmWLkxUlNLsfAWqCZVuwIF06xtBN9K0Au1jJPiA4oGgZi+Oglj4swUFETuoHTd8x9K4wXkRrTPcwWtf8XGddEBBRe2EUWQLCbSeFIUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:43 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 27/33] hw/arm: phytium: Connect the Phytium E2000Q COMe QSPI
 flash
Date: Thu,  3 Sep 2026 19:25:07 +0800
Message-ID: <20260903112532.3276678-28-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|PS1PPFF2E6AB00E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d218458-1a05-456c-254c-08df09ae3b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aSmjxTxjIGN/Bf548d387hEGWtBCIXN/e3kidwY8Wc7AEqkrcrwlCslQii77WQptrZUDCw4CDdMrq1RDnlXLWEZoBEvMUGjuuZDS/JVH4GSkUl5n7GdMzLgV4UWXfJgVfA42SWavKlXkUswTZm3jR82M+lxaPYiWk8VScN82/xgvYwxQMEb2cta80JfayIplpZF4D6RhJJQrgc4foIMjihhEp/urlX3bQxZwD/2j/tDfpnzGADJu1wbeMVwDvV9ddEeR77c4dJGnKTfOWgLq+bpVhmYtahXSs526XulG8eF8U/1TdTwgJMOlWE1pbmcYq6EhImanbAzWlICdSSPuVsgO075X1XBEZbmj4VOuv0eSMkiUaiDfzUd50+s9mGkjrV8wNih+0TXykB9NhtLBNdjSm7KAjVLh7qE7o/XvDECL84r7x9psj+RvE0WvfCm7G7tau+9sOYX3h9fNAZEwWtp4kT//zRlok95qa5GdpjnMFSysFp1o3CinoVv3gJyy3VQO2NK211TfFB+vkwaADzedo1x+LeOkPsqefncC0vN3d/XQNRdtfIWsSnu7HkTNkcLILvvN/G79fIQjCXh5YCTkPol2HtvVSagCfUGcyoOSQqk+/owZw8g0QxqP3cSxbgE0BD2npEiZRMOJGF4/P/XOFk1ED1vwm8p/6+MurRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxH51ShiNjzVZT7uTV3IUw0DrOyD1C8ImS58soR122s511sjGYAE7qANwhwt?=
 =?us-ascii?Q?xzcI82r8UisDRvlY1tkd2xa8iXPk86AFTzY2+LvZLBigd/js+ToyiDX/4xI+?=
 =?us-ascii?Q?zmkgM5IY4nT1ZxPky6yyd6ePp+yVbM/xsax0JCbRDEV2IGLnYUtBx5g0eDy8?=
 =?us-ascii?Q?6fr3YG+2zWlItoPAUGmFCscqVrXSrxJu7YzYNgJeTqkdATTUuM85ISuwzM74?=
 =?us-ascii?Q?ntycQSVZGJM6jysaq5zdm550CHtB0ia8muUoS5r4mPWPtkhva0XbhOK+Et1m?=
 =?us-ascii?Q?9M401dh6DLBHtv443K8j83Xt8YhKRU3zFaFu1vH0yOYPpeq1dXMlKjAeqLeo?=
 =?us-ascii?Q?8bev4KBlswhjtRO2bTX3Jtff6UfgPHjGMpeLUV5Xe5H9EIu7DnhSPxU33VeA?=
 =?us-ascii?Q?yePX85UYk0+94AldzQV4QO5c4Pv2z+l+XJKKYjtjBP7PRditA/ANjNABKw6c?=
 =?us-ascii?Q?u12nd1aDd+M4AVgPvd/HhnFdPOeaPsIxF5G3on+/q0rrodimpvrHA1DUyYmn?=
 =?us-ascii?Q?OEsjdVX7RXd9vhB+LePICiZysmPJ7HEUHY9NRe37IiwNJR5zG3Rf4DnT9Oam?=
 =?us-ascii?Q?7QmtQEqzjWcNmoBDX8JkAmlBA42B2EGxbEQMEXS5GxBZ6JsWLZq4ShOY/dKf?=
 =?us-ascii?Q?/D0qmtrif2TGN2HZPL1IPKT5ZeWBmSHkhrT5OceHU2zbpYIEtJt5r2ncMEzq?=
 =?us-ascii?Q?RYuVB0DAUs0oqQMK1xZyrcWPnCiXx5ztokenbkEJXMWTUD5hQ/uKioN9jB4h?=
 =?us-ascii?Q?IZV/FaWXHWmeyQ3iUeY83Ex2T3x0qJS/OqzZqxS1zj7SnVHNmVPUueLjhbmw?=
 =?us-ascii?Q?Y8GdVXWWE4JOZ4bagOucFyGPJJo3BYf5c3FNoQiFiRK77J34BKYJ+2Be4rbp?=
 =?us-ascii?Q?VyDJbCGVUHBJOSiZLJGFOL1U8FfKO91ljK7iIg2IrI6KXfB1zhq2YOqG0Ov5?=
 =?us-ascii?Q?ddjM8Ppz1iUBNIXFzKNrikvWikYev442jinmRIC6gd109PTnK9H9w9YuaFy0?=
 =?us-ascii?Q?Pt763dPzNloL0jyzAV3c2o1C8LY7S5F9thuW9Xy3kJb5cdd/t01+2eRNvu6Z?=
 =?us-ascii?Q?nEKvYp7aNR1mPhXMBiLamMlVJVAfP2CJ2G1h11o79OplYlALgaue0QX1Qz5X?=
 =?us-ascii?Q?wkZW2lm/3bcXph+7lKsU1p83Z5t6sgofgFfBBmZnfvjNomWDhTKi8hYC2vqB?=
 =?us-ascii?Q?ri+zx8477E6/xc9eazSEzKuJikGrDp1BijUBpTT0K5g0Pn2do4ILWiH093dc?=
 =?us-ascii?Q?fOM2+GAREuC1XztSC7C8UfazrHg/7f7qUtBNiXorwtaO06Ke7Cai01mQBuje?=
 =?us-ascii?Q?eWk8LdgZ7PnAbJ3MRh7qKImVqcfxs/A9D/bYIYmCZcTe/OohjARjpEGoazzX?=
 =?us-ascii?Q?GZXU3DjntNaD2tO1Gse1Y9mMyJ+CfLn5QSH4h+uKY/ae3dfpd1GQ+mGQojVx?=
 =?us-ascii?Q?IzvlwgV+6pvgNFUmLtm+qoIXhGn3tSCqZHBf96Z8uATTR4nZoKqRFkea00C4?=
 =?us-ascii?Q?WbFOlemgWAj6ZZm/ZcQzNClt0lWH74kaeG0p1KlXwgZbxfI1qRBU5OuNO2+L?=
 =?us-ascii?Q?XspV9zj+KUak4q4+cvFurHrJGZIVzC26mQqIwj7Okl4/grxiCZAZ6Gk05vZx?=
 =?us-ascii?Q?Wcb7zNrp6UwLc8Eh9d8p1lZO7b+Z4awzwiHwo7+0tWW/Tl+8xuKNxzvQfCdD?=
 =?us-ascii?Q?99DoFUK4N/yzFo/mskevAEqHv/tiPXGPHU7oyM7uhI1+bt6lCHXAAH4N9xw/?=
 =?us-ascii?Q?b0GtT2jIwxVBdr/NPrtRAOllI8MMzK0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d218458-1a05-456c-254c-08df09ae3b06
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:43.0522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkt9gVqhO5ULLZdoT3kpY8KEZZ7rR0MfSSTYeMmxPaNiruBhd4QrayBsSbR4SqGYlI9Vl6WboPHnrgDAulY3yunFoYNXqBj9xuXsSLYIybk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF2E6AB00E
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Attach the board GD25Q128 to QSPI0 chip select zero and expose an
MTD backend for COMe firmware storage.

Describe the flash model in the COMe machine class so the shared
E2000 SoC still instantiates QSPI0 while Phytium Pi does not acquire
a board-level SPI flash.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 61b9ca021f..940457b58b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -140,6 +140,7 @@ config PHYTIUM_E2000
     select PHYTIUM_E2000_QSPI
     select PL011
     select SD
+    select SSI_M25P80
     select UNIMP
     select USB_XHCI_SYSBUS
 
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 5a2155ee32..499f5e0ffb 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -40,6 +40,7 @@
 #include "hw/sd/phytium_e2000_mci.h"
 #include "hw/sd/sd.h"
 #include "hw/ssi/phytium_qspi.h"
+#include "hw/ssi/ssi.h"
 #include "hw/usb/xhci.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
@@ -118,6 +119,7 @@ struct PhytiumE2000State {
     struct arm_boot_info bootinfo;
     DeviceState *gic;
     DeviceState *qspi;
+    DeviceState *qspi_flash;
     PhytiumE2000PBRState *pbr;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
@@ -133,6 +135,7 @@ struct PhytiumE2000MachineClass {
     const char *machine_name;
     const char *direct_boot_dtb;
     const char *pbr_boot_mode;
+    const char *qspi_flash_model;
 };
 
 /*
@@ -577,6 +580,25 @@ static void phytium_e2000_create_qspi(PhytiumE2000State *s)
         phytium_e2000_memmap[PHYTIUM_E2000_QSPI_DIRECT].base, 2);
 }
 
+static void phytium_e2000_attach_qspi_flash(PhytiumE2000State *s,
+                                            const char *model)
+{
+    DeviceState *flash = qdev_new(model);
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+    qemu_irq flash_cs;
+
+    if (dinfo) {
+        qdev_prop_set_drive_err(flash, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+    }
+
+    s->qspi_flash = flash;
+    qdev_realize_and_unref(flash, qdev_get_child_bus(s->qspi, "spi"),
+                           &error_fatal);
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    qdev_connect_gpio_out_named(s->qspi, "cs", 0, flash_cs);
+}
+
 static bool phytium_e2000_create_pbr(PhytiumE2000State *s)
 {
     MachineState *ms = MACHINE(s);
@@ -588,10 +610,13 @@ static bool phytium_e2000_create_pbr(PhytiumE2000State *s)
     uint64_t cpu_mpidrs[PHYTIUM_E2000_NUM_CPUS];
     int i;
 
-    if (!ms->kernel_filename &&
-        !strcmp(pemc->pbr_boot_mode,
-                PHYTIUM_E2000_PBR_BOOT_MODE_SD0)) {
-        boot_blk = phytium_e2000_sd_blk(0);
+    if (!ms->kernel_filename) {
+        if (!strcmp(pemc->pbr_boot_mode,
+                    PHYTIUM_E2000_PBR_BOOT_MODE_QSPI)) {
+            boot_blk = m25p80_get_blk(s->qspi_flash);
+        } else {
+            boot_blk = phytium_e2000_sd_blk(0);
+        }
     }
 
     for (i = 0; i < ms->smp.cpus; i++) {
@@ -913,6 +938,9 @@ static void phytium_e2000_init(MachineState *ms)
     phytium_e2000_create_unimplemented();
 
     phytium_e2000_create_qspi(s);
+    if (pemc->qspi_flash_model) {
+        phytium_e2000_attach_qspi_flash(s, pemc->qspi_flash_model);
+    }
     firmware_loaded = phytium_e2000_create_pbr(s);
 
     phytium_e2000_create_cpus(s, firmware_loaded);
@@ -1024,6 +1052,7 @@ static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
     pemc->machine_name = "phytium-e2000-come";
     pemc->direct_boot_dtb = "e2000q-come-board.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_QSPI;
+    pemc->qspi_flash_model = "gd25q128";
 }
 
 static const TypeInfo phytium_e2000_base_info = {
-- 
2.53.0


