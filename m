Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6472C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25b9-0006ZB-Gv; Thu, 03 Sep 2026 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b7-0006XV-PD; Thu, 03 Sep 2026 07:27:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b5-0006pv-Nn; Thu, 03 Sep 2026 07:27:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVlMf/NsmeWJdXTXnjqDlbSWVZXJ8DeFEavgrtXh4KuhJWPBWYfuUL29bt7RQnYnSIpIA2IQ6GJ6z5YRFKVQOdHOhwkBjBRU3e06TcnonZv6TYDJMK3kIIRvOwYYFfK3LHJXPha8ViiDh7cZ4Za5FSdqZoJyWYRlY9AIpFUjMoh5HRmIFvZfkAgvjHy4wR9O0hlZDP0ho1nWqdGtSYi2W0WXs6dFAuN5bjkYe7sd3zAOdCI5pu11EKHPjt7b+6zE3mRDUryM/1vrCbG/40mJt1yvDUBFro5Vs6l6ZoUSI1cxVN1Qq2Htsmu97VHx8XQNUKVbMHBGdil264Z16ekIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpN8q0x/PxnM0kcfoWu/lWaxuHkzXm/t4h4e2swzv6M=;
 b=e2gNf7oetXwOhr/xysbJA5BvlFb7r/EI+pa0eX06pOpzzMX9QtPefFKejC8sTIJ+JrHn+4hXwFUmQ0Wct+zIMbUQdlouoDEOFRPXCB36dohCtOZki1uM2TecMM82NZRzN0xj20rIGGlVN26EDszEH1S8pHX72CBbX6bMQgnjB+I9seKwCnaXvb11PhD4UcgeeVSdLrzvlV5ZKQAYsYXSh7T83S0HFL9TMP/Mp/hGFzahCkkELpfgIdC+CUlZd0XSeyP7ayCzsQMHXnYHzYhVRGGPh0IGzGZ8FzxE2MfHlkZ7wvi4wTNqJJhXi5qv/UWq3mDwyd7wCXU5RyQUu27WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpN8q0x/PxnM0kcfoWu/lWaxuHkzXm/t4h4e2swzv6M=;
 b=pa7ESBmyjfzZyd13OaUBKK97RVmhSae5mwc1aXm3/cfL09kzjnnmtDTvM1uOEQvShJmask+AukzOphk8QBkbqyLyldDh+YbVUUb2QCrPxgs5LCnH6Y+2i5ASno0o/EdQuwJIdhabBv3Xfk7TJxLjBZbDMr3F38SM9lKTFWBOm9phqXOizbFvTXJ8hfXzdysxmrM6tJIWQrKBSconTvRMakQ3I6GI/f3cAApZFoTOxvJndx7lyZ40dxqaFCtfOunxOsEOamb6CibEipnCDfmnrmathS6vkVM5gnT5iKE65jf5ULn95FMYGyipqt+SqWOX87bl6qieN6lnh2UCp96Dow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:45 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 28/33] hw/arm: phytium: Add Phytium E2000 AHCI controllers
Date: Thu,  3 Sep 2026 19:25:08 +0800
Message-ID: <20260903112532.3276678-29-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cc966c7-6387-487b-03f2-08df09ae3c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tr4VyPhr8MaS7S20ZbI5ATvqLY9DFp3GHCpPcvM32y6AbpNnLZ9+Wyb8WEyxlWpdLJ4+xRE07ozLTuACJFBT8XUvsMBve8FRGd3nZCyv0Edx2oBJIfn7M+QCiWd1nKzi6nSBu/nI7dO7AYAcmQFiIvT9w6Ld+ndlXu+FtpoQ8cw7Q+zLw8UHYJ9gg+BbtmOAeqekgsiC0OQR6OWKbPLTwLWSz8DCcVSmfMcaNwkjtS6w151tlsdND3x5i8uY12yAyFJrx2tvDYh+md7HCb3EtI3VTIF4U11ei7kL9WOCqaKFCahfUOzkwpT3IMoX9L/61AaujQQSFPgR9WlB07HowRhqP+JAStFMDQXNOUJaDIzzmazxZdFfsB9yo8xO7gvYji/bmONyUQiohdGMJVP3Fr7PAjYgKbNy/xavHcYovYdYrvhetl/mCvbvGlvZpQW00aFRfNHGOWEpGCl1jrKL8D4w9iAizEwNR0T/QFxK+08Vu28kXQQuGJ0MB89zhthJ2DhbdiWFDXhKJ1/97SqfMn8NaBa1sX6tohLR5ocpslL7nPTX616AeedF106IU5wCbJUTihcg4ovogMPZN2BXIbnCmhAzYwv8JH0zvXJhLv4Kd/evv0pgTsntDLXtTCZW4yhMFFP4KLetjW9IhFq3WByBmUgW+eryqkDsk5r+lHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Cn2Mcd81rxSGlMNki/TBjwifF+2KljoqDShdqdE1LHrsOylmtFAu0srSLd6?=
 =?us-ascii?Q?7muvsTgxGRR9XVrb+JmW74wWhsGqvwT+AaFgJVNId6jXlBJ0qD0M3IJ/FC+9?=
 =?us-ascii?Q?zD48zua4xvbSMVMTTxjpL6tY119pJnj9jGcAtxNAN/243mutysKsxqbboAZp?=
 =?us-ascii?Q?00n5cpgCwpVF4d9+CLPwmdT8Iu8I0MOgtz46rNvoQ8QFBZqzIae0W7MP26z5?=
 =?us-ascii?Q?GwOu0PX8GleHoKSuYFpEkcibIvm+uhQW8MEada2y9g44w0PwCvj+H9TgBTif?=
 =?us-ascii?Q?6uEZACxhpzTL1lgYED0FtotPtZFGekoRFD0C5pQFlLgXjZOCK8t8yhoQaH03?=
 =?us-ascii?Q?e1hO3nIzcDxkNxhe3U/EQlFBGBZ5dxVL/hTMsAs0HdilpNzvjrZpVMlZyhMF?=
 =?us-ascii?Q?ExMRdyfX+8UvtrWbVRixEX2XCljbE4wgCftVVDiLir/oEE+CWDK79IgOBkF3?=
 =?us-ascii?Q?Kj2qSbm4oZDzOPopFobbeOPMqR3NEI0JIGS1Ktz7pz+PFflKRyJm76Iu0zBF?=
 =?us-ascii?Q?k17foYSTKYS2hRvuFFag+58JaPTHOqttcyC9CmAdCnaNrzZxsKKLI7ILN11a?=
 =?us-ascii?Q?RM//mjv4c8zrmys7epOfwWXZ0IWJ+rk3KAH1euWd8XS3mX9tZkosQFC5EYBy?=
 =?us-ascii?Q?nYTSCOoNOKBTmblmI0gp+p5uYc39ePwDTLEHxfS26Ws9JdB45FXJpCY4lxiS?=
 =?us-ascii?Q?lZ2cPjGJSjA73ABdHsJG32Je6csHVrBqpS3eBttyCLyP/KpmT8N3FZ9/I9aK?=
 =?us-ascii?Q?tVDvgHmLVwEj3Iw/+rdJ+LpET/oVTs2QhJInpI3AwMuDmEsrRtWI/0H2FIaD?=
 =?us-ascii?Q?qFsjLCRXccQtwbKrj+GM1nTRyAs28J1F+0R+ph0f0afRnd1+Tuc2pmRTtf87?=
 =?us-ascii?Q?zyL/P/dwl7iYpCb0o35m5CpZcgd6T98FpKnpWKtRzteXu6KrJ6t1QOKAUrVU?=
 =?us-ascii?Q?8oOPmhuyN07UXDWhdQI4bfYllGaDMbhM6ujpeCLPR5+oQdV6w854WFjhxTGE?=
 =?us-ascii?Q?v0V5OTKIQozAbdagtAiSyM2Ri6E7Jk+OAIMdRKJTmUX+aolKPMbWj+y7SfSq?=
 =?us-ascii?Q?82ciaD9+4dUacr9v16a2xX9UxwbVXbT3+/Rtx8mu4eEWowEeqoAquQ+607Mn?=
 =?us-ascii?Q?S2dbCY2Z6yeJjtkqDUqZM4aj4C34Y7wFYgvidoT02AtwUXKnoCJ2cdpuhG/y?=
 =?us-ascii?Q?SbajXXsudErNue6mRZczELAfdq97l6yjSI4GPNWjOFsT6sbsUETJOimAOGGp?=
 =?us-ascii?Q?giKOuKJNBjynbZFS+SztBVi/JjyTpcKFPKDDiQHTE1u4w13wLRvDXBQOXFY9?=
 =?us-ascii?Q?fGviHgUTK5LbhPDxL8fJpuO6NMZskPvubHVhINdqT1xKhRrkpeFYM1LTE2S5?=
 =?us-ascii?Q?5XjvJimM5xuYKrUeIH18oAqDqpo0c599KCtRkON/Q87GkvSxh15ZzfofSaqP?=
 =?us-ascii?Q?x6yjgZ1QPs3vcaqwrlD5rhqtHRSjSxXv9PCAZCS7MKZzwaFBB4s7GZkLkIGI?=
 =?us-ascii?Q?yQEp6uzOHHHFl9Wx7ZTYhIFkVcb6+X2gr1/aUi2VRwONBfvjN5jTM3ImXdpq?=
 =?us-ascii?Q?xBw84JK32uV5HCQ02WCT+Ppw0cSWrDLFSW4WNE3jZpfapzbzvzZM24BNxDzd?=
 =?us-ascii?Q?1RdyN2/F6/qtRU+dtHpwbNchG9B0+sckj0R0T3y4IicwO4lAGmI8or+imBcK?=
 =?us-ascii?Q?sfta6d6QJ0Qgo/ERJM/4dwEkDWGP6dPiDz/+SgklBUqb9CVJ7G5I7seQxBWE?=
 =?us-ascii?Q?fZWte+8a3Lb2GfJLxz7T4rH8SMi2OHA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc966c7-6387-487b-03f2-08df09ae3c32
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:45.0156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM7didOWIInErJ13SZ+ILW4bTOeoHPdtjsqQibpH9hh9tESX7W7vaouMGtEFcx1eBmVKANW/SyXyNexH4R35yCLlL6ylegiwnyPq3lSbpT8=
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

Add the two single-port sysbus AHCI controllers integrated in the E2000
SoC and route their interrupts to the GIC. Both boards expose the fixed
controller blocks, but Phytium Pi does not wire either controller to a
SATA disk and therefore rejects an IDE backend.

The physical COMe board wires its boot SSD to the second controller.
Attach its SATA backend to AHCI1 so that U-Boot and Linux observe the
same controller order as on hardware.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  3 +++
 hw/arm/phytium_e2000.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 940457b58b..11c16bbebc 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -131,10 +131,13 @@ config PHYTIUM_E2000
     default y
     depends on TCG && AARCH64
     imply PCI_DEVICES
+    select AHCI_SYSBUS
     select ARM_GIC
     select CADENCE
     select DESIGNWARE_I2C
     select DW_MCI
+    select IDE_BUS
+    select IDE_DEV
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PHYTIUM_E2000_QSPI
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 499f5e0ffb..3acd9b716b 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -26,6 +26,8 @@
 #include "hw/char/pl011.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/ide/ahci-sysbus.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/i2c/designware_i2c.h"
@@ -63,6 +65,9 @@ OBJECT_DECLARE_TYPE(PhytiumE2000State, PhytiumE2000MachineClass,
 #define PHYTIUM_E2000_NUM_MCIS        2
 #define PHYTIUM_E2000_NUM_UARTS       7
 #define PHYTIUM_E2000_NUM_XHCIS       2
+#define PHYTIUM_E2000_NUM_AHCIS       2
+#define PHYTIUM_E2000_NUM_SATA_PORTS  1
+#define PHYTIUM_E2000_SATA_BOOT_AHCI  1
 #define PHYTIUM_E2000_NUM_GEMS        4
 
 #define PHYTIUM_E2000_MHU_BASE        0x32a00000
@@ -97,10 +102,12 @@ enum {
     PHYTIUM_E2000_BOARD_CTRL,
     PHYTIUM_E2000_XHCI0,
     PHYTIUM_E2000_XHCI1,
+    PHYTIUM_E2000_AHCI0,
     PHYTIUM_E2000_GEM0,
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_AHCI1,
     PHYTIUM_E2000_RNG_REGS,
     PHYTIUM_E2000_PLATFORM_CTRL,
     PHYTIUM_E2000_SECURITY_CTRL,
@@ -136,6 +143,7 @@ struct PhytiumE2000MachineClass {
     const char *direct_boot_dtb;
     const char *pbr_boot_mode;
     const char *qspi_flash_model;
+    bool has_sata_boot;
 };
 
 /*
@@ -168,10 +176,12 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
     [PHYTIUM_E2000_XHCI0] =          { 0x31a08000, 0x00018000 },
     [PHYTIUM_E2000_XHCI1] =          { 0x31a28000, 0x00018000 },
+    [PHYTIUM_E2000_AHCI0] =          { 0x31a40000, 0x00001000 },
     [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_AHCI1] =          { 0x32014000, 0x00001000 },
     [PHYTIUM_E2000_RNG_REGS] =       { 0x32a36000, 0x00001000 },
     [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
     [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
@@ -207,6 +217,11 @@ static const int phytium_e2000_xhci_irqmap[] = {
     [1] = 17,
 };
 
+static const int phytium_e2000_ahci_irqmap[] = {
+    [0] = 42,
+    [1] = 43,
+};
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS]
@@ -403,6 +418,32 @@ static void phytium_e2000_create_gem(PhytiumE2000State *s, int index)
     }
 }
 
+static void phytium_e2000_create_ahci(PhytiumE2000State *s, int index,
+                                      bool attach_boot_disk)
+{
+    int map_idx = index ? PHYTIUM_E2000_AHCI1 : PHYTIUM_E2000_AHCI0;
+    DriveInfo *hd[PHYTIUM_E2000_NUM_SATA_PORTS] = {};
+    DeviceState *dev = qdev_new(TYPE_SYSBUS_AHCI);
+    SysbusAHCIState *sysahci;
+
+    /*
+     * The COMe boot disk is wired to the second fixed AHCI controller. U-Boot
+     * probes both controllers and exposes the only attached disk as scsi 0.
+     */
+    qdev_prop_set_uint32(dev, "num-ports", PHYTIUM_E2000_NUM_SATA_PORTS);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
+        phytium_e2000_memmap[map_idx].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_ahci_irqmap[index]));
+
+    if (attach_boot_disk) {
+        sysahci = SYSBUS_AHCI(dev);
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        ahci_ide_create_devs(&sysahci->ahci, hd);
+    }
+}
+
 static void phytium_e2000_create_xhci(PhytiumE2000State *s, int index)
 {
     int map_idx = PHYTIUM_E2000_XHCI0 + index;
@@ -932,6 +973,12 @@ static void phytium_e2000_init(MachineState *ms)
         exit(1);
     }
 
+    if (!pemc->has_sata_boot && drive_get_by_index(IF_IDE, 0)) {
+        error_report("%s does not expose a SATA boot disk; "
+                     "use if=sd,index=0", pemc->machine_name);
+        exit(1);
+    }
+
     phytium_e2000_reject_legacy_firmware(ms, pemc);
 
     phytium_e2000_create_ram(s);
@@ -961,6 +1008,10 @@ static void phytium_e2000_init(MachineState *ms)
     for (i = 0; i < PHYTIUM_E2000_NUM_XHCIS; i++) {
         phytium_e2000_create_xhci(s, i);
     }
+    for (i = 0; i < PHYTIUM_E2000_NUM_AHCIS; i++) {
+        phytium_e2000_create_ahci(s, i,
+            pemc->has_sata_boot && i == PHYTIUM_E2000_SATA_BOOT_AHCI);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
@@ -1040,6 +1091,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     pemc->machine_name = "phytium-pi";
     pemc->direct_boot_dtb = "phytiumpi_firefly.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
+    pemc->has_sata_boot = false;
 }
 
 static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
@@ -1049,10 +1101,12 @@ static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
         PHYTIUM_E2000_MACHINE_CLASS(oc);
 
     mc->desc = "Phytium E2000Q COMe Development Board";
+    mc->block_default_type = IF_IDE;
     pemc->machine_name = "phytium-e2000-come";
     pemc->direct_boot_dtb = "e2000q-come-board.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_QSPI;
     pemc->qspi_flash_model = "gd25q128";
+    pemc->has_sata_boot = true;
 }
 
 static const TypeInfo phytium_e2000_base_info = {
-- 
2.53.0


