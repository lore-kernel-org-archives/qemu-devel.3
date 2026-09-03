Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BEBC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25bD-0006cB-Cs; Thu, 03 Sep 2026 07:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25bB-0006bF-UZ; Thu, 03 Sep 2026 07:27:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25b8-0006qc-Re; Thu, 03 Sep 2026 07:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEuswf7nGcMBkrOwI3zHleznwdqVQUkdg/WSl4It7PnwvgcK0+uSkgHW3NoLz8JUD/x7GE9NR2HucKhr6dKyaDYI8QTpgK84LJdjdvrU2gV3IyKvp3rjW2yEKcP3OOKpfsBq7b8EmYeldnWyG139YcQruEnGIDauqvW3nS5QnOXCW3idW6MHxmKU+7f/w677IRV/O4n2tK/g/UJSyMC21Ffbfke0naYiSrsTTZl3onyTTWY5krJ9igCO0227XRgXM5gjNlwJ+tn1Vo/zL6qtuKiQ1m8JkamgaHzZdygDSEURtt9LNIHJ0HjkvpvDbI6twz6+AasSZU1Nc2EiGAEilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO4iBmY0M8t6z02uuprvnsdLcu6rcJ2XcdpIm5Ra75Q=;
 b=xg4wGRQtEbYzwws06sy2bsA/bWd8bdYQw9sUVe4KMQNWqNbIKJoLAZg1lX8GxdyqZM26//9JWldrDtD2RG/GUgPm+Dm7E2Zt9WM2EzyRX2Oe1Nb5LvztK/eVrW6tP4xy4pav59tv3XJB0VjeGKbqtJFgEeupfKtUQ0Pbj8zrGsB6E58Bt9xdhpMY/94cS/GFFaL5LSoMKkn0QCu5cznJ/n7rSP3GMxNiYFOxc96UNV99tXIOf15YXpt9V/c95ZJSySp4HPeYCmlglModtQgTFPysWcUWI8/Jjfjq4nfvGQBg6stA1082ex1tH5+jD00x5oR8hJkgnrU9f0Fc2oBUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO4iBmY0M8t6z02uuprvnsdLcu6rcJ2XcdpIm5Ra75Q=;
 b=GKDxtkyYLphle7/V5xckvGdD1xXQNWlXJj0vJSdIUbRRTvKT5DwiIpCU2ZLtYeV5Is4TiKRWTtqrlPr8Pw3z933qCKqZFsmHz6JgeyGy4hhEc911JgCcVD2O7/JRgznoPHKv4UK3iTw+VukhULq2fYLKk7V7HTPwzJrhNIIP2F884qmp2Za+o2RygOg44nwN76zpeuJ2bI/2FATNAEaIgT3QYWP+T5h9+8Sueq+wjTtvQNkX9rOFPZCc49kLdZF57yvqTQG+PLSrh2nQY2UN5hOjjE3locUT9hBf4lzx6uAEOC+TlYPP3NpPsya0KoEMEFhRu0SVm74i8/oZ5hWmmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5811.apcprd02.prod.outlook.com (2603:1096:400:1d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:47 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:46 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 29/33] hw/arm: Add Phytium E2000 Linux SCMI channel
Date: Thu,  3 Sep 2026 19:25:09 +0800
Message-ID: <20260903112532.3276678-30-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bf5c9e-d0b2-4bf9-a9b6-08df09ae3d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: PE2jx6jkKMaEO/8hS9bgQ2w3RSKhdLVZ9zRL0msmJ4ieaNkI/zKdUJNYJjmcpgkdCUxlUlJ+xXCKF5EnrXjYJlgMkT7CcaPavobSCYXILh84JxGRV24U+i4TVj7+A/X4byCz1AEfHildl68Wabt+PjjC+QrylSxh+2HUbU7BDPH7VutLuyb6DlbipyihX3T56nl1h3M1V+iMcS4DagXD+w3uF3AODMvxZyPhSWFkvnWnWVSABLfbBdo+BWDow7kZ9GlHlVta4THyHnk1CEHsV0JGZTAHEg6LxIXaMpXABxGl8JujQChPxy4kdowS9H75mGxFotTOO7G+2bgh5WItU4rMO/khDXTbPP1mnP8G5mnD6qoG1QU09AJmCkEfeygxhyrrvb6JeZxNc0RH+nv9rcRwRTJ69GPohnFm+Xh/O+XJDtwK7ASPQRUrVac5W8DhvKXO1LOnzStjnAV2i4/aNcX7ist5Gku8mtm6tQJUE7sQONNxN9hR2SkyygeZBkvD7E1sBWRfz+oKJ6kVWLwH44sWnbLfos/IgmxZmKuchB0jlRN/kIYX1Rop+AjYsbvXj/PbUxh3G82JIKDlVYG0NCQPN0PDrdHb20W7Wsy4xQHyEtXnollADdlbQZ3hWAzbYYvj2dRK6x46PYybcoYm0zXaQJlIam6VGe6r+1gjW0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usuBqsLpMwd5ikpt2bCefnvsT/Zo3DvBJwN9bR3lrwlGGXpd9gNm8mdAMjG8?=
 =?us-ascii?Q?ZkGkP5dE5iwa84SxEfOCTE5BdztfnASNzWQmu13yoMZW95XSUwRaCkUhsOOy?=
 =?us-ascii?Q?n5Lp7RtlFmQg4BNFQ55CByUH+kyPY73aV7gWULJSw9t0rDy3mbyCVrTyh+Sv?=
 =?us-ascii?Q?szixMJtBl1kION9yeUoGHy7xHgvpCF+6kK+XRNnsYaSwrbC/L6nvE0tmtKJD?=
 =?us-ascii?Q?XsnW8M1kF8FFedPtrjhwOhmpUEJ5gHJT1yua2GqqPq1sHRd75vTMIDpdZzoS?=
 =?us-ascii?Q?D50VY0Z1VwVd1jPBKAOMAecemU4g3tYYz2CTMtsxfviXflROGGvVDu52rPF5?=
 =?us-ascii?Q?AymLejY9kTECJgJYPWzVOss0Th1ZNkUCRN3g2zn3Zx6sxrXparmozFTV2QR8?=
 =?us-ascii?Q?ccsvdb6jggYnOqU3s8mhVUqC7pGIQATa3UoSOrNxHVN2CVAe7R9ZdiNxe1U8?=
 =?us-ascii?Q?GHHIrF1WK7DnDXNvu0EjQz7t4V8Jiuw2mDKMXLpaTFrk+NLBr8dou9DCcp5S?=
 =?us-ascii?Q?oO7dquea1JvUPJwf2w1pED9YG2GNIpAK+bsCnJpegNT1VAfVYI/cK6M0/iBT?=
 =?us-ascii?Q?HFz8XU3nmJ4TVrhSbw0i1DZb2GreWy8Gj0kcs/jf29rYqpOYnU/u4dn9ztdl?=
 =?us-ascii?Q?q8JhH60TZMLXagfeElsvdgrX5+6VcTRB99i9okMyC+s6wHI1GsadCZWj7dxR?=
 =?us-ascii?Q?aN1t3NOIO0XH+eGs2Kq2DRMSGwv9jwd/okhXts/r47AY0pCMd6x279rlyYcQ?=
 =?us-ascii?Q?HsjubB7GdAOm2tRdMumsliKFFpQfLykCjVKfgMc5DpLXKbEkBNngECoFf0Km?=
 =?us-ascii?Q?I4gYKVh+KKI1tD2ASACsffVUcEGzBvKZ063T+ToEGDPLBbohVutg3OWVhzm4?=
 =?us-ascii?Q?KDwllCnOVSzmPiSitYON+tZPunwPfUOSGdmedB/BeyLVj6PDXtudvY8GDFlT?=
 =?us-ascii?Q?JdUK6UiXdzZavFV+Qh66ikm2s0Oo3PuSuEQjEtiGQG3wJEsNYl+dCGwnjjxj?=
 =?us-ascii?Q?MgkdYGSTIP8mZWYcEVR7GX/mbZaEXI/nTsArLknwrfRZSEQIabPgXWa8BaDf?=
 =?us-ascii?Q?r7kijcBQtjNmnF/ca/wmggBa0A2R4ztAiCnco+OYBUTgwKnjlfNzk6vwZhbq?=
 =?us-ascii?Q?nsUPw6RsAAzJFCLccucmhtzDtBOKHfatL3WBxtrROauVQdkNy7SLF9qn7Vwz?=
 =?us-ascii?Q?OSOF8lVpl4VtTgdcNY1Erps/4fyHMFUV+NLqlk+yYhUJNkFqzlES+fnj1lA5?=
 =?us-ascii?Q?5+MHosLbOaXV02UENB3OUN/mH0MkydmmVo6n669Gxm+kXp7zWyk+tGYLOY9k?=
 =?us-ascii?Q?bxjHOB7+Bdw7NQF2dp80d8R3JJsTU9In8OmZisO0Y8SUSref6vfhO2PkAprU?=
 =?us-ascii?Q?EgBMfQhrLBB8ihhofDu4n7ua3BFHshrmCRJEzVtNwKXw48uN0f2lh95FgATT?=
 =?us-ascii?Q?c3u5Q1T60xAqRqNMNNnt8SuKnCh4HtrdP8r0jmgeG2yynJELRVS/KDBbEJeL?=
 =?us-ascii?Q?siNxIROLvGTCAmXUyEDEDfZgQ15X1tDW/z10cem+4nYF0LcYjSMOPkxPUpRt?=
 =?us-ascii?Q?dbVua712PUJjhA/r3JDUpAjEmNxkWDqQGjJwEGKBsDYNpb3L0eiBjgsAPage?=
 =?us-ascii?Q?5IEHIwu3pRDsxL/HHCn17OjX05DUbuGWi00Z92HzA60fHGh9L7bwTB5fis2+?=
 =?us-ascii?Q?TwZFQBBrT3aioTq/V7+vyRxKKFmU1U3PT5QF1MDk/BtamffV9afAs4PctUjI?=
 =?us-ascii?Q?INoyc5DMtF7bOC8WXdClzASHrM6eXfg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bf5c9e-d0b2-4bf9-a9b6-08df09ae3d41
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:46.7973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9h1DC0b+Dyku09dTJ6Ji+GcBRdoJC2Njuayo4ZpTojVio1jnFcSIVoOa421laHprXDGo0nuXmDN2WKZNYNP2F3jM82S5Y6CSaJ9PiezfMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5811
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

The E2000 model only serviced the private PBF mailbox channel. The
vendor Linux driver uses a separate shared-memory channel and therefore
timed out before it could discover any SCMI protocols.

Model the Linux MHU doorbells and Base protocol while leaving
Performance and Sensor unadvertised until their platform data can be
represented faithfully. Document the limitation.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c      |   4 +
 hw/misc/phytium_e2000_mhu.c | 457 +++++++++++++++++++++++++++++-------
 2 files changed, 381 insertions(+), 80 deletions(-)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 3acd9b716b..cfd1ca70c9 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -232,6 +232,8 @@ static const int phytium_e2000_gem_irqmap[PHYTIUM_E2000_NUM_GEMS]
     [3] = { 68, 69, 70, 71 },
 };
 
+static const int phytium_e2000_mhu_irq = 22;
+
 static const int phytium_e2000_pcie_irqmap[PCI_NUM_PINS] = {
     [0] = 4,
     [1] = 5,
@@ -756,6 +758,8 @@ static void phytium_e2000_create_mhu(PhytiumE2000State *s)
     }
     sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_MHU_BASE, 2);
+    sysbus_connect_irq(sbd, 0,
+                       qdev_get_gpio_in(s->gic, phytium_e2000_mhu_irq));
 }
 
 static void phytium_e2000_create_unimplemented(void)
diff --git a/hw/misc/phytium_e2000_mhu.c b/hw/misc/phytium_e2000_mhu.c
index 554448398b..f158918af5 100644
--- a/hw/misc/phytium_e2000_mhu.c
+++ b/hw/misc/phytium_e2000_mhu.c
@@ -1,9 +1,8 @@
 /*
  * Phytium E2000 MHU/SCMI doorbell
  *
- * This is a boot-oriented SCMI transport proxy. It acknowledges requests in
- * shared SRAM so PBF can complete clock and platform setup; it is not a full
- * SCMI protocol server.
+ * This models the PBF firmware transport and the SCMI Base protocol used by
+ * Linux. Protocols whose platform data is not available remain unsupported.
  *
  * Copyright (c) 2026 Process Mission
  *
@@ -16,34 +15,65 @@
 #include "qemu/osdep.h"
 #include "hw/misc/phytium_e2000_mhu.h"
 
-#include "hw/core/register.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/address-spaces.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/cpu.h"
 
-#define PHYTIUM_E2000_PBF_SCMI_MBOX_BASE  0x32a10400
-#define PHYTIUM_E2000_SCMI_STATUS_OFFSET  0x04
-#define PHYTIUM_E2000_SCMI_LEN_OFFSET     0x14
-#define PHYTIUM_E2000_SCMI_HEADER_OFFSET  0x18
-#define PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET 0x1c
-#define PHYTIUM_E2000_SCMI_STATUS_FREE    BIT(0)
-
-#define SCMI_MESSAGE_ID(header)    extract32((header), 0, 8)
-#define SCMI_PROTOCOL_ID(header)   extract32((header), 10, 8)
-#define SCMI_PROTOCOL_POWER_DOMAIN 0x11
-#define SCMI_PROTOCOL_PHYTIUM      0x81
-#define SCMI_POWER_STATE_SET       0x4
-#define SCMI_PHYTIUM_GET_PSOSTAT   0x3
-#define SCMI_POWER_STATE_TYPE      BIT(30)
-#define SCMI_POWER_STATE_ID_MASK   (SCMI_POWER_STATE_TYPE - 1)
+#define PHYTIUM_E2000_PBF_SCMI_MBOX_BASE     0x32a10400
+#define PHYTIUM_E2000_OS_SCMI_MBOX_BASE      0x32a11400
+#define PHYTIUM_E2000_OS_SCMI_MBOX_SIZE      0x400
+#define PHYTIUM_E2000_SCMI_STATUS_OFFSET     0x04
+#define PHYTIUM_E2000_SCMI_FLAGS_OFFSET      0x10
+#define PHYTIUM_E2000_SCMI_LEN_OFFSET        0x14
+#define PHYTIUM_E2000_SCMI_HEADER_OFFSET     0x18
+#define PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET    0x1c
+#define PHYTIUM_E2000_SCMI_STATUS_FREE       BIT(0)
+#define PHYTIUM_E2000_SCMI_FLAG_INTR_ENABLED BIT(0)
+#define PHYTIUM_E2000_SCMI_MAX_FRAME_SIZE    \
+    (PHYTIUM_E2000_OS_SCMI_MBOX_SIZE - \
+     PHYTIUM_E2000_SCMI_HEADER_OFFSET)
+
+#define SCMI_MESSAGE_ID(header)              extract32((header), 0, 8)
+#define SCMI_MESSAGE_TYPE(header)            extract32((header), 8, 2)
+#define SCMI_PROTOCOL_ID(header)             extract32((header), 10, 8)
+#define SCMI_RESERVED(header)                extract32((header), 28, 4)
+#define SCMI_MESSAGE_TYPE_COMMAND            0
+#define SCMI_PROTOCOL_BASE                   0x10
+#define SCMI_PROTOCOL_POWER_DOMAIN           0x11
+#define SCMI_PROTOCOL_PHYTIUM                0x81
+#define SCMI_PROTOCOL_VERSION                0x0
+#define SCMI_PROTOCOL_ATTRIBUTES             0x1
+#define SCMI_PROTOCOL_MESSAGE_ATTRIBUTES     0x2
+#define SCMI_BASE_DISCOVER_VENDOR            0x3
+#define SCMI_BASE_DISCOVER_SUB_VENDOR        0x4
+#define SCMI_BASE_DISCOVER_IMPLEMENT_VERSION 0x5
+#define SCMI_BASE_DISCOVER_LIST_PROTOCOLS    0x6
+#define SCMI_BASE_DISCOVER_AGENT             0x7
+#define SCMI_BASE_NOTIFY_ERRORS              0x8
+#define SCMI_POWER_STATE_SET                 0x4
+#define SCMI_PHYTIUM_GET_PSOSTAT             0x3
+#define SCMI_POWER_STATE_TYPE                BIT(30)
+#define SCMI_POWER_STATE_ID_MASK             (SCMI_POWER_STATE_TYPE - 1)
+/* Values reported by the E2000 SCP firmware */
+#define SCMI_BASE_VERSION                    0x00020000
+#define SCMI_BASE_IMPLEMENTATION_VERSION     0x02050000
+#define SCMI_BASE_NUM_PROTOCOLS              0
+#define SCMI_BASE_NUM_AGENTS                 2
+#define SCMI_DOORBELL_COMPLETE               BIT(31)
 
 #define SCMI_SUCCESS            0
+#define SCMI_NOT_SUPPORTED      (-1)
 #define SCMI_INVALID_PARAMETERS (-2)
+#define SCMI_NOT_FOUND          (-4)
 #define SCMI_GENERIC_ERROR      (-8)
+#define SCMI_PROTOCOL_ERROR     (-10)
 
 #define PHYTIUM_E2000_PBF_ROOT_ANCHOR       \
     (PHYTIUM_E2000_PBR_BOOT_SRAM_BASE + 0xf00)
@@ -52,11 +82,14 @@
 #define PHYTIUM_E2000_CPU_LOCK_OWNER_OFFSET 0x30
 #define PHYTIUM_E2000_CPU_ON_COMPLETE       0xabcdef98
 
-/*
- * The SDK defines AP OS status/set/clear at 0x100/0x108/0x110 within a
- * channel. PBF selects the channel at MHU offset 0x200, producing the global
- * offsets below. Writes to AP_OS_SET are the request notification.
- */
+REG32(AP_RX_STAT, 0x000)
+REG32(AP_RX_SET, 0x008)
+REG32(AP_RX_CLR, 0x010)
+REG32(AP_TX_STAT, 0x100)
+REG32(AP_TX_SET, 0x108)
+REG32(AP_TX_CLR, 0x110)
+
+/* PBF selects the AP OS channel at offset 0x200 */
 REG32(AP_OS_STAT, 0x300)
 REG32(AP_OS_SET, 0x308)
 REG32(AP_OS_CLR, 0x310)
@@ -67,8 +100,9 @@ REG32(AP_OS_CLR, 0x310)
 struct PhytiumE2000MHUState {
     SysBusDevice parent_obj;
 
+    MemoryRegion iomem;
+    qemu_irq irq;
     uint32_t regs[PHYTIUM_E2000_MHU_R_MAX];
-    RegisterInfo regs_info[PHYTIUM_E2000_MHU_R_MAX];
     uint64_t cpu_mpidrs[PHYTIUM_E2000_MHU_MAX_CPUS];
     CPUState *cpus[PHYTIUM_E2000_MHU_MAX_CPUS];
     /* Firmware-owned slot address supplied by the PBR before realization */
@@ -122,34 +156,34 @@ static bool phytium_e2000_phys_writeq(hwaddr addr, uint64_t value)
                                sizeof(buf)) == MEMTX_OK;
 }
 
-static uint32_t phytium_e2000_scmi_readl(hwaddr offset)
+static bool phytium_e2000_phys_write(hwaddr addr, const void *buf, size_t size)
 {
-    uint8_t buf[sizeof(uint32_t)];
-
-    address_space_read(&address_space_memory,
-                       PHYTIUM_E2000_PBF_SCMI_MBOX_BASE + offset,
-                       MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
-    return ldl_le_p(buf);
+    return address_space_write(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, buf, size) == MEMTX_OK;
 }
 
-static void phytium_e2000_scmi_writel(hwaddr offset, uint32_t value)
+static uint32_t phytium_e2000_scmi_readl(hwaddr base, hwaddr offset)
 {
-    uint8_t buf[sizeof(uint32_t)];
+    uint32_t value = 0;
 
-    stl_le_p(buf, value);
-    address_space_write(&address_space_memory,
-                        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE + offset,
-                        MEMTXATTRS_UNSPECIFIED, buf, sizeof(buf));
+    phytium_e2000_phys_readl(base + offset, &value);
+    return value;
+}
+
+static void phytium_e2000_scmi_writel(hwaddr base, hwaddr offset,
+                                      uint32_t value)
+{
+    phytium_e2000_phys_writel(base + offset, value);
 }
 
-static void phytium_e2000_scmi_publish(uint32_t len)
+static void phytium_e2000_scmi_publish(hwaddr base, uint32_t len)
 {
-    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_LEN_OFFSET, len);
+    phytium_e2000_scmi_writel(base, PHYTIUM_E2000_SCMI_LEN_OFFSET, len);
     /*
      * Publish the free bit last. PBF polls this field as the ownership handoff
      * and may consume the response immediately after observing it.
      */
-    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+    phytium_e2000_scmi_writel(base, PHYTIUM_E2000_SCMI_STATUS_OFFSET,
                               PHYTIUM_E2000_SCMI_STATUS_FREE);
 }
 
@@ -287,8 +321,10 @@ static uint32_t phytium_e2000_mhu_psostat(PhytiumE2000MHUState *s)
 static int32_t phytium_e2000_mhu_set_power_state(PhytiumE2000MHUState *s)
 {
     uint32_t domain_id = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
         PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 4);
     uint32_t power_state = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
         PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 8);
     uint32_t core_mask = power_state & SCMI_POWER_STATE_ID_MASK;
     bool power_on = power_state & SCMI_POWER_STATE_TYPE;
@@ -347,8 +383,10 @@ static int32_t phytium_e2000_mhu_set_power_state(PhytiumE2000MHUState *s)
 static void phytium_e2000_mhu_complete_scmi(PhytiumE2000MHUState *s)
 {
     uint32_t header = phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
         PHYTIUM_E2000_SCMI_HEADER_OFFSET);
     uint32_t len = MAX(phytium_e2000_scmi_readl(
+        PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
         PHYTIUM_E2000_SCMI_LEN_OFFSET), (uint32_t)sizeof(uint32_t));
     int32_t scmi_status = SCMI_SUCCESS;
 
@@ -359,7 +397,8 @@ static void phytium_e2000_mhu_complete_scmi(PhytiumE2000MHUState *s)
      */
     if (SCMI_PROTOCOL_ID(header) == SCMI_PROTOCOL_PHYTIUM &&
         SCMI_MESSAGE_ID(header) == SCMI_PHYTIUM_GET_PSOSTAT) {
-        phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 4,
+        phytium_e2000_scmi_writel(PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
+                                  PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET + 4,
                                   phytium_e2000_mhu_psostat(s));
         len = 3 * sizeof(uint32_t);
     } else if (SCMI_PROTOCOL_ID(header) == SCMI_PROTOCOL_POWER_DOMAIN &&
@@ -368,9 +407,202 @@ static void phytium_e2000_mhu_complete_scmi(PhytiumE2000MHUState *s)
         len = 2 * sizeof(uint32_t);
     }
 
-    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
+                              PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
                               scmi_status);
-    phytium_e2000_scmi_publish(len);
+    phytium_e2000_scmi_publish(PHYTIUM_E2000_PBF_SCMI_MBOX_BASE, len);
+}
+
+static bool phytium_e2000_scmi_base_message_supported(uint32_t message_id)
+{
+    return message_id <= SCMI_BASE_DISCOVER_AGENT;
+}
+
+static int32_t phytium_e2000_mhu_complete_base(uint32_t message_id,
+                                               uint32_t request_len,
+                                               uint8_t response[16],
+                                               size_t *response_len)
+{
+    uint32_t parameter;
+
+    *response_len = 0;
+
+    switch (message_id) {
+    case SCMI_PROTOCOL_VERSION:
+        if (request_len != sizeof(uint32_t)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        stl_le_p(response, SCMI_BASE_VERSION);
+        *response_len = sizeof(uint32_t);
+        return SCMI_SUCCESS;
+    case SCMI_PROTOCOL_ATTRIBUTES:
+        if (request_len != sizeof(uint32_t)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        response[0] = SCMI_BASE_NUM_PROTOCOLS;
+        response[1] = SCMI_BASE_NUM_AGENTS;
+        *response_len = sizeof(uint32_t);
+        return SCMI_SUCCESS;
+    case SCMI_PROTOCOL_MESSAGE_ATTRIBUTES:
+        if (request_len != 2 * sizeof(uint32_t) ||
+            !phytium_e2000_phys_readl(
+                PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+                PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET, &parameter)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        if (!phytium_e2000_scmi_base_message_supported(parameter)) {
+            return SCMI_NOT_FOUND;
+        }
+        stl_le_p(response, 0);
+        *response_len = sizeof(uint32_t);
+        return SCMI_SUCCESS;
+    case SCMI_BASE_DISCOVER_VENDOR:
+        if (request_len != sizeof(uint32_t)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        memcpy(response, "Phytium", sizeof("Phytium"));
+        *response_len = 16;
+        return SCMI_SUCCESS;
+    case SCMI_BASE_DISCOVER_SUB_VENDOR:
+        if (request_len != sizeof(uint32_t)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        memcpy(response, "E2000", sizeof("E2000"));
+        *response_len = 16;
+        return SCMI_SUCCESS;
+    case SCMI_BASE_DISCOVER_IMPLEMENT_VERSION:
+        if (request_len != sizeof(uint32_t)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        stl_le_p(response, SCMI_BASE_IMPLEMENTATION_VERSION);
+        *response_len = sizeof(uint32_t);
+        return SCMI_SUCCESS;
+    case SCMI_BASE_DISCOVER_LIST_PROTOCOLS:
+        if (request_len != 2 * sizeof(uint32_t) ||
+            !phytium_e2000_phys_readl(
+                PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+                PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET, &parameter)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        if (parameter) {
+            return SCMI_INVALID_PARAMETERS;
+        }
+        stl_le_p(response, 0);
+        *response_len = sizeof(uint32_t);
+        return SCMI_SUCCESS;
+    case SCMI_BASE_DISCOVER_AGENT:
+        if (request_len != 2 * sizeof(uint32_t) ||
+            !phytium_e2000_phys_readl(
+                PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+                PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET, &parameter)) {
+            return SCMI_PROTOCOL_ERROR;
+        }
+        if (parameter > SCMI_BASE_NUM_AGENTS - 1) {
+            return SCMI_NOT_FOUND;
+        }
+        /*
+         * The E2000 SCP advertises Base v2.0 but returns the v1 16-byte agent
+         * name. Match this quirk because the SDK 5.10 client parses that
+         * layout rather than the v2 agent-ID-plus-name response.
+         */
+        if (parameter == 0) {
+            memcpy(response, "platform", sizeof("platform"));
+        } else {
+            memcpy(response, "OSPM", sizeof("OSPM"));
+        }
+        *response_len = 16;
+        return SCMI_SUCCESS;
+    case SCMI_BASE_NOTIFY_ERRORS:
+    default:
+        return SCMI_NOT_SUPPORTED;
+    }
+}
+
+static bool phytium_e2000_mhu_publish_os_response(uint32_t header,
+                                                  int32_t status,
+                                                  const uint8_t *response,
+                                                  size_t response_len)
+{
+    hwaddr payload = PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+                     PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET;
+
+    if (!phytium_e2000_phys_writel(payload, status) ||
+        (response_len &&
+         !phytium_e2000_phys_write(payload + sizeof(uint32_t), response,
+                                   response_len)) ||
+        !phytium_e2000_phys_writel(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_HEADER_OFFSET, header) ||
+        !phytium_e2000_phys_writel(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_LEN_OFFSET,
+            2 * sizeof(uint32_t) + response_len) ||
+        !phytium_e2000_phys_writel(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+            PHYTIUM_E2000_SCMI_STATUS_FREE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: failed to publish SCMI response\n");
+        return false;
+    }
+
+    return true;
+}
+
+static bool phytium_e2000_mhu_complete_os_scmi(PhytiumE2000MHUState *s)
+{
+    uint8_t response[16] = { 0 };
+    uint32_t flags;
+    uint32_t header;
+    uint32_t len;
+    size_t response_len = 0;
+    int32_t status;
+
+    if (!phytium_e2000_phys_readl(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_LEN_OFFSET, &len) ||
+        !phytium_e2000_phys_readl(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_HEADER_OFFSET, &header) ||
+        !phytium_e2000_phys_readl(
+            PHYTIUM_E2000_OS_SCMI_MBOX_BASE +
+            PHYTIUM_E2000_SCMI_FLAGS_OFFSET, &flags)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: failed to read SCMI request\n");
+        return false;
+    }
+
+    if (len < sizeof(uint32_t) || len > PHYTIUM_E2000_SCMI_MAX_FRAME_SIZE ||
+        !QEMU_IS_ALIGNED(len, sizeof(uint32_t)) ||
+        (flags & ~PHYTIUM_E2000_SCMI_FLAG_INTR_ENABLED) ||
+        SCMI_MESSAGE_TYPE(header) != SCMI_MESSAGE_TYPE_COMMAND ||
+        SCMI_RESERVED(header)) {
+        status = SCMI_PROTOCOL_ERROR;
+    } else if (SCMI_PROTOCOL_ID(header) != SCMI_PROTOCOL_BASE) {
+        status = SCMI_NOT_SUPPORTED;
+    } else {
+        status = phytium_e2000_mhu_complete_base(
+            SCMI_MESSAGE_ID(header), len, response, &response_len);
+    }
+
+    g_assert(response_len <= sizeof(response));
+    if (!phytium_e2000_mhu_publish_os_response(
+            header, status, response, response_len)) {
+        return false;
+    }
+
+    /*
+     * The vendor mailbox poll callback recognizes only BIT(31) as transmit
+     * completion. Raise RX only when the requester selected interrupts.
+     */
+    s->regs[A_AP_TX_STAT / sizeof(uint32_t)] = SCMI_DOORBELL_COMPLETE;
+    if (flags & PHYTIUM_E2000_SCMI_FLAG_INTR_ENABLED) {
+        s->regs[A_AP_RX_STAT / sizeof(uint32_t)] |=
+            SCMI_DOORBELL_COMPLETE;
+        qemu_set_irq(s->irq, 1);
+    }
+
+    return true;
 }
 
 void phytium_e2000_mhu_seed_mailbox(void)
@@ -379,41 +611,98 @@ void phytium_e2000_mhu_seed_mailbox(void)
      * PBR leaves the shared channel available before releasing PBF. Seed the
      * same ownership and success state even before the first doorbell write.
      */
-    phytium_e2000_scmi_writel(PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
+                              PHYTIUM_E2000_SCMI_PAYLOAD_OFFSET,
                               SCMI_SUCCESS);
-    phytium_e2000_scmi_publish(sizeof(uint32_t));
+    phytium_e2000_scmi_publish(PHYTIUM_E2000_PBF_SCMI_MBOX_BASE,
+                               sizeof(uint32_t));
 }
 
-static void phytium_e2000_mhu_doorbell_post_write(RegisterInfo *reg,
-                                                  uint64_t value)
+static void phytium_e2000_mhu_update_irq(PhytiumE2000MHUState *s)
 {
-    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(reg->opaque);
+    qemu_set_irq(s->irq,
+                 s->regs[A_AP_RX_STAT / sizeof(uint32_t)] != 0);
+}
 
-    /*
-     * Complete requests synchronously because no separate SCP CPU executes in
-     * this model. Zero writes only update doorbell storage.
-     */
-    if (value) {
-        phytium_e2000_mhu_complete_scmi(s);
+static uint64_t phytium_e2000_mhu_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(opaque);
+
+    switch (offset) {
+    case A_AP_RX_STAT:
+    case A_AP_TX_STAT:
+    case A_AP_OS_STAT:
+    case A_AP_OS_SET:
+    case A_AP_OS_CLR:
+        return s->regs[offset / sizeof(uint32_t)];
+    case A_AP_RX_SET:
+    case A_AP_RX_CLR:
+    case A_AP_TX_SET:
+    case A_AP_TX_CLR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: read from write-only register "
+                      "at 0x%" HWADDR_PRIx "\n", offset);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: read from unimplemented register "
+                      "at 0x%" HWADDR_PRIx "\n", offset);
+        return 0;
     }
 }
 
-static const RegisterAccessInfo phytium_e2000_mhu_regs_info[] = {
-    /*
-     * The functional transport does not model an SCP interrupt line. STAT is
-     * therefore idle, SET completes the shared-memory transaction, and CLR
-     * remains ordinary register storage for the firmware acknowledge path.
-     */
-    { .name = "AP_OS_STAT", .addr = A_AP_OS_STAT,
-      .ro = UINT32_MAX },
-    { .name = "AP_OS_SET", .addr = A_AP_OS_SET,
-      .post_write = phytium_e2000_mhu_doorbell_post_write },
-    { .name = "AP_OS_CLR", .addr = A_AP_OS_CLR },
-};
+static void phytium_e2000_mhu_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size)
+{
+    PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(opaque);
+    uint32_t val = value;
+
+    switch (offset) {
+    case A_AP_RX_SET:
+        s->regs[A_AP_RX_STAT / sizeof(uint32_t)] |= val;
+        phytium_e2000_mhu_update_irq(s);
+        break;
+    case A_AP_RX_CLR:
+        s->regs[A_AP_RX_STAT / sizeof(uint32_t)] &= ~val;
+        phytium_e2000_mhu_update_irq(s);
+        break;
+    case A_AP_TX_SET:
+        if (val) {
+            s->regs[A_AP_TX_STAT / sizeof(uint32_t)] |= val;
+            phytium_e2000_mhu_complete_os_scmi(s);
+        }
+        break;
+    case A_AP_TX_CLR:
+        s->regs[A_AP_TX_STAT / sizeof(uint32_t)] &= ~val;
+        break;
+    case A_AP_OS_SET:
+        s->regs[A_AP_OS_SET / sizeof(uint32_t)] = val;
+        if (val) {
+            phytium_e2000_mhu_complete_scmi(s);
+        }
+        break;
+    case A_AP_OS_CLR:
+        s->regs[A_AP_OS_CLR / sizeof(uint32_t)] = val;
+        break;
+    case A_AP_RX_STAT:
+    case A_AP_TX_STAT:
+    case A_AP_OS_STAT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: write to read-only register "
+                      "at 0x%" HWADDR_PRIx "\n", offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "phytium-e2000-mhu: write to unimplemented register "
+                      "at 0x%" HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
 
 static const MemoryRegionOps phytium_e2000_mhu_ops = {
-    .read = register_read_memory,
-    .write = register_write_memory,
+    .read = phytium_e2000_mhu_read,
+    .write = phytium_e2000_mhu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -425,12 +714,12 @@ static const MemoryRegionOps phytium_e2000_mhu_ops = {
 static void phytium_e2000_mhu_reset(DeviceState *dev)
 {
     PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(dev);
-    int i;
 
-    for (i = 0; i < ARRAY_SIZE(phytium_e2000_mhu_regs_info); i++) {
-        register_reset(&s->regs_info[
-            phytium_e2000_mhu_regs_info[i].addr / sizeof(uint32_t)]);
-    }
+    memset(s->regs, 0, sizeof(s->regs));
+    phytium_e2000_mhu_update_irq(s);
+    phytium_e2000_scmi_writel(PHYTIUM_E2000_OS_SCMI_MBOX_BASE,
+                              PHYTIUM_E2000_SCMI_STATUS_OFFSET,
+                              PHYTIUM_E2000_SCMI_STATUS_FREE);
 }
 
 void phytium_e2000_mhu_connect_cpu(PhytiumE2000MHUState *s,
@@ -466,13 +755,12 @@ void phytium_e2000_mhu_set_secondary_vector_slot(PhytiumE2000MHUState *s,
 static void phytium_e2000_mhu_init(Object *obj)
 {
     PhytiumE2000MHUState *s = PHYTIUM_E2000_MHU(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array = register_init_block32(
-        DEVICE(obj), phytium_e2000_mhu_regs_info,
-        ARRAY_SIZE(phytium_e2000_mhu_regs_info), s->regs_info, s->regs,
-        &phytium_e2000_mhu_ops, false, PHYTIUM_E2000_MHU_MMIO_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
+    memory_region_init_io(&s->iomem, obj, &phytium_e2000_mhu_ops, s,
+                          TYPE_PHYTIUM_E2000_MHU,
+                          PHYTIUM_E2000_MHU_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 }
 
 static void phytium_e2000_mhu_finalize(Object *obj)
@@ -485,10 +773,19 @@ static void phytium_e2000_mhu_finalize(Object *obj)
     }
 }
 
+static int phytium_e2000_mhu_post_load(void *opaque, int version_id)
+{
+    PhytiumE2000MHUState *s = opaque;
+
+    phytium_e2000_mhu_update_irq(s);
+    return 0;
+}
+
 static const VMStateDescription phytium_e2000_mhu_vmsd = {
     .name = TYPE_PHYTIUM_E2000_MHU,
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = phytium_e2000_mhu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, PhytiumE2000MHUState,
                              PHYTIUM_E2000_MHU_R_MAX),
-- 
2.53.0


