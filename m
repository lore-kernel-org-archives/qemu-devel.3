Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527E9C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXh7-0008AL-QH; Thu, 13 Aug 2026 11:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXh6-00089s-2g; Thu, 13 Aug 2026 11:50:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXh4-0001nZ-70; Thu, 13 Aug 2026 11:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttlscS+kH4A1vEFafxCneuGYKLll9yce3Nr+EbQFPzw/a57Nz4J0Law8yLa34yb+xz/NGJLpfYdqcDBnDTRZW6NDwOSXLAiZMqUuSoZu9q8wL+yF4IHXE6XOYeyrzQ4JmEPeGpSx2ymEWMFFyllwWGPrOZbREtUS6ljzJ7sKvaR2J46llF+sD5wQw8xQ2lhVncoDaocBArqIQDVOld9b65aB51AiZPNws8IZe60etn/yOc/zV3lbAWMZUZZXW2CZZiGVrskkb6damvCYpEbtAVRG/R5+vAa5XF4meWWTyxRD7hTqD6zvQqaAx3sGgq9mz+hWP6uIHprv2RboNjdbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap0YiwASlT8E5/SwyI3UdsWAFZw4m/209KDm3mqmbGs=;
 b=H8WiItpBW90DwHkG13EClycfuXs5Y6uSyu2BlathscNp+gVtOjffwVERVriuqOmvccSWjuUAhC4gijW+OnsqeviM5cRoW1BQHKdbxubE7qcajKEal5xtxCSm8lqDPWDj0jor7hNYsKIzfwAmp7lJVLWwOtQAQMNjb8rZOaLS+W9Uxm6vQ88qOiJBqKBOwZgj+abKV7FlSyOlh+BXqnXdsyLbQ1b1RxA9vbsBGPFI0fJWs5ah0UKJMylPe5EVlLnXz/x/ToOHhn5pkL4vXLy0o/6mGKtIxkwHvoM5cXGp9Ugd7LXmZAqHOSGJIuTkvuKsiWMxpImL1BizcCx1Ts6tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap0YiwASlT8E5/SwyI3UdsWAFZw4m/209KDm3mqmbGs=;
 b=Vb75EyVSGJ56QuTCcngG0fQ3iluGeWNbOl81CfGZ6yVKj8m8zsSj7e1iDIJkOHJ038AqHGdTvXMmmnrgh30BRTaSh8C6lz8lVZsg1C9ohwmL7h2wYtmUS6dFePVP5SOIIiB9dXwzLrCGInxh7Bezk7mYdEE5+yLBubQPFYw1E4AbcJYhRESlxTcA6Yxfl6X1YM78uxAqCVyYwMKd3yV9PEcH+sw0GUHTCbMOj//0Se6Mac7SkLI9pUmvtlQf7jhT1YMut+I7F8dvbAFFt3nwadJDntF1FthNVdClo2hE9cCwye9g6s6RlVcUPq23UZ9twhcn+66+g5HwigjHCApzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:00 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:00 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 01/20] hw/arm: aspeed: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:48:49 +0800
Message-ID: <20260813154918.996812-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ced163-db03-4bbb-240d-08def9528850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x8A64QDsm3kxU5mmvt2xkXu1GWVUDaxR28LBUyJvuz3NMPm7+BOnpxUMTmDzg4WVLvO4XJ6Ldd81Kza8XE/NmZfsHgq/kDHkqhQJwwk95dyZl0WDdcKxu3JrdNWGFxgtABtLOZMp2lZeXhBvlNXS+YI7goq0tDjR4uU54ACVFxcAa417/2E2Xx/+58ZwOCC8YR0Py89oIvH0xcLNUp/zMx86VuqKQqzbDcBCFOllv8/ksmsbL8nwTCpxGpWe1Rbm1hQapEmrdcqN+710nmRBAb79XiePRj9qE0D70dqTx85N+vlvMHaHQ3qhEQ5sgX3vK8N2W4uL0NLTrtkvOQkN3s1yGb8darTYlvyWJejOoG9a/LlgES9CVVbo4b/XU/mtyF/RXIzn44Wa5FtwhBBtfA3RDg5wdSM9qkfGkJTzhEMPSeltz+R6BKi8EfBixsMFUwkOn1eiyVV+vmeaubY1bjHf20HHxu93NXwWLDnrWNEe/04tk9cL6juYuEC1N4suQIY5jdS0r/2rokTFwzgG6kdAWMbFY8rDz2ocLPPhgD77qbvkRNIu6cWaH8J8NC1MvYbyACjYFh6v2cz7Aj5JYVERqyxpZUpZaLOGyjXZ25MWmqd8O+fEIN1z3y2MMAKc6nirjCzDev4pFFwg9C3uf16qJ9aw/OJUyr2ht4DHPBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NB1b4j+y88CFhsH8MmBFCPuBWeU69dlCoFE77MsShDamq2DzF4e84FtStiZs?=
 =?us-ascii?Q?uW8m0BrruGYQTnmOakZ0/8nGPF1f78koFgRpIRAfj0r8tQ4xu/vdpYrnkXGs?=
 =?us-ascii?Q?I9thWm13D0e+6ExBbRWyaeGgOcxDcNuej0LZgSIbvRR8UO5skXxBBvDnXmdO?=
 =?us-ascii?Q?OB5KinoipO7Id3rp6k/pb7nq8cmZkfWamUZS0t64ZNu3aPGHt5ZWO6Fb2fFI?=
 =?us-ascii?Q?jfPSGhLKnJ5kNsBehWPec64dF71VeE9wjH+IkMfns7YiQUt0nGcIl3M7ANqz?=
 =?us-ascii?Q?W140TVitKhz7nWvZHg6IgqJwoHqUPGRoTm4PSO1eIus3cyxZOcFJhZnDDb7F?=
 =?us-ascii?Q?AaF7zieJSnzdcF2bzExCYoQUeCjQa1tGxJaNNCO24MEik//3cY+H5czxAVN8?=
 =?us-ascii?Q?upYp2hpSRUZ26lERDIljvjPLbCI6DecZRyZX+Z3MQkVX//Te22OdXYbKvM8W?=
 =?us-ascii?Q?vWLXtObH2f0+J8ZzFh0Dh3cauozAP7UMDkcoR+41cgMseRS/MzBgmYmAnGc6?=
 =?us-ascii?Q?IDTpDDLkXIMKKF7fcBKUzUjMs0Fa1YYvnN1seSD5t2BMmYOpsUPaOF7JZuf4?=
 =?us-ascii?Q?+jpn03rsnA07NRYBDalYpvFlBpnEGtk/iYi89kRWT8v/tmU5kHbYj9DzcWR8?=
 =?us-ascii?Q?3Q2pofvvvxTVaGGwfcavNyZqDKsJN/kdqEjzaHoR8wp9+EiP8XrD7i6LJt1i?=
 =?us-ascii?Q?qzdoHLokpfPKPzzdcmSiyDaWyJ54DqUb4eVUujQisiu8HEMADTgRbrz+DXXZ?=
 =?us-ascii?Q?QciaFHoDOzJdw/FcJZFfifcO7uxYodTAhzDTQK/dkDTFOS79TAqpQPdBerVD?=
 =?us-ascii?Q?ky2ETwXC3R3uOTfWH+OwiZ5tDNt/2EKfdLLCvkjL6Oy4/VMz3IOtFIpoIAfZ?=
 =?us-ascii?Q?GlckDcbi4Bo4HO22FWahLRXlxG+IIR8GS2Q8MC/dtI280uQuOhVjyqCBrrug?=
 =?us-ascii?Q?d2YXOS/WLn5Tv9Zo/VSB1SA5ni9WctxhTRTiggDD1rZpDV5B5ahWDKd0/DPO?=
 =?us-ascii?Q?Qb/PNfOsq2e/XDxdyFeZDkxgt2T39Vm2cKJSsbCxDpzuGcdtCPkbgasCA5MC?=
 =?us-ascii?Q?frrwRuBw7wdgzUARTU6eFLxktZt3WPJrvGVsm9sIUMtvMtc5olK+In0Sjp8K?=
 =?us-ascii?Q?ZxVdAZnXVwWACao/H4X5SxL7l4SBec40kZJg0/Tcpca3O8FAFnP88osYgwSw?=
 =?us-ascii?Q?zIkl6MB1xGHTWd2tmliJ+7NF2kdKquLTR33RBStGQh5OqftK/0MEPfXjjih7?=
 =?us-ascii?Q?0zCaqOGfksqfqvHSCJwo7uFxgM6RPp3cyaADfvdBSxsYUvMLTORD4ZK2HMkz?=
 =?us-ascii?Q?kWm9oXGpq0As1wISLRrnPFcZASkPThDKP65OcGrvfulbJb91Pb9qJOKDvKuw?=
 =?us-ascii?Q?KRywm0950wbyD7s5LJPPoH3XUm5pIf6ScRElCiAVeU1qB7bXncxwi6/CoWo9?=
 =?us-ascii?Q?KwetjHBJZVLcL5lwHn6P+jGuzlxt1gmRhujiSfxYInsXjedSOfmEZdYprAth?=
 =?us-ascii?Q?co4vLCgXp5CUyS3M4BhVGE+91pPHNeqqWoYVgYPbbMH8/5gXHjgTeEQxgCp+?=
 =?us-ascii?Q?bjf61vxXTsWpB6bB2/5gNF3iURzDwba935LdCNHW9LJvPgXyfMd6VZahg5Vu?=
 =?us-ascii?Q?Nsik2Z+oQduiJamO15Ubc06GdePO6reWJ92JDroj0oYc4iEv+Y6g+qCaF0Xa?=
 =?us-ascii?Q?vldu9ImbRgrnffPnMTCN/m70QtmnuH2qdzhfG862rj0OG74QQve0AS7T3Zru?=
 =?us-ascii?Q?tm7Y7a8eJe3sGqnknHnBPbo1bmQ1eTM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ced163-db03-4bbb-240d-08def9528850
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:00.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWMxLjsy0r1xzOWsfNm/UX6hn+wmeEkekdBiEuEso6scTHpDRIpufCG6pfZbzwYaTyzKI+1aukHAv4PASgWmXJjhp2jQE91OKHWBorH3v40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing AspeedMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/aspeed.c         | 17 +++++++----------
 include/hw/arm/aspeed.h |  2 ++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a9238e6217..8fa16b3831 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -24,10 +24,6 @@
 #include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
-static struct arm_boot_info aspeed_board_binfo = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -206,13 +202,14 @@ static void aspeed_machine_init(MachineState *machine)
         memory_region_add_subregion(get_system_memory(),
                                     AST_SMP_MAILBOX_BASE, smpboot);
 
-        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
-        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
-        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
+        bmc->bootinfo.write_secondary_boot = aspeed_write_smpboot;
+        bmc->bootinfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
+        bmc->bootinfo.smp_loader_start = AST_SMP_MBOX_CODE;
     }
 
-    aspeed_board_binfo.ram_size = machine->ram_size;
-    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    bmc->bootinfo.board_id = -1; /* device-tree-only board */
+    bmc->bootinfo.ram_size = machine->ram_size;
+    bmc->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
     if (amc->i2c_init) {
         amc->i2c_init(bmc);
@@ -248,7 +245,7 @@ static void aspeed_machine_init(MachineState *machine)
         aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &bmc->bootinfo);
 }
 
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74..54f0d7643d 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/boot.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -42,6 +43,7 @@ struct AspeedMachineState {
     char *fmc_model;
     char *spi_model;
     uint32_t hw_strap1;
+    struct arm_boot_info bootinfo;
 };
 
 struct AspeedMachineClass {
-- 
2.53.0


