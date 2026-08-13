Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2DBC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhp-0008Ny-6Q; Thu, 13 Aug 2026 11:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhn-0008Ng-IJ; Thu, 13 Aug 2026 11:50:55 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhl-0001rl-4X; Thu, 13 Aug 2026 11:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K//o6TwXul7L2OWfgUtNU51uB1Ogqp4HrNS7/arcemnksMHcOn/cHok69lJb7xwAJGsH2iYkoUCYZd/VzhRJrMT8h0M8zQOGZYUbvEq5wdG6DdwF7fabXfnA8Nhm7nYFDEj6/kgVMi+4HWKuYac4d5nq0eIieg3/1Dl6Zi62zwYnpE357O7JGwldthLikLhB/WLDvZR+GmhvUZ6FsAijBjBPXtiCssfEBEN5dLm+Hc03JwWj9uclnhQwd+Ae3rwDQ4Kv/y9XgnBsEOZrs/NcbQkZyTUteFPjGiFUBmnwCRtwVNZoWPWZTxHKI/viMLsrJjy50BZm/Y5wIKDmcAfrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQsWu2T4VbaN+18fRJVOdxPWb6YDloA0+E7i8NXd74I=;
 b=bDSlgTHduceGud7zGTyApSMGlhaTt41KJ/02zL0zr6lQYSBxtI44vRLMSmmscnGmIOf8w9HE+v2O0wSpnoyVHiSpe+yybZBbNx9ng26iRoP52v3jMeoFpGL2yizBU7P3QT6UN0LBIKEtWv44Sn8cqBTecrapIp7Ahl+aF1lknq++nZzpSzMNze5cwEXQnqUBFr1HMUv2uR1EYjZWeev0mO//vbPmv8m4HTrDGyj3sFgqzVhygSz4DYbUgWcC5iMeP8TygpvwhmpPsUcp73pRmlC9VVFk3/65qmFTvNv5Y2SMijiOaIORND0GXm8TKDD0xe6Jzghs1aWCsIi1xBXwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQsWu2T4VbaN+18fRJVOdxPWb6YDloA0+E7i8NXd74I=;
 b=qcDY/Fi99jQVIwa5UnPaMEmQ0Yr2PRD0ovNIu7S0Yq6lr/9sWLfrWdD5K4E7Egd6pSMvrlFyAfHq6ot36j/OBedOwZVIIBx37b0bDzh0CBapINkVfUsngRe1XmUGJ5kIjXqF1q5mThtLjsqD5aoUKnDOiWPWeSgSQ2sB3z75s9RcZRTE5BlmkzM6sUCyu8m9oxXYCA9Gs8tweaY9So/RH105isUCsTg3CNbUXHpeAJvxWkdHKRiOICAUCSipR1YRH+9A4ii0k9fCKK3che+T5I6pekvTZx0ubG5ko1jshfOIj5aM1hT4uf+Q3chwGxTS8o3BxTquBAB6HaBZScd+EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:50 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH 13/20] hw/arm: npcm7xx: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:01 +0800
Message-ID: <20260813154918.996812-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a8155a2-f80a-434a-32fd-08def952a5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BFKnjAqh0RxYTRHp/cGSmZEvt27sh7EMXOeC5MsokSA60vKVWnkgkEpfNucTAy/x4sDMbZZ71IvaCd1Juh+cEiSQRX+AD1NIJ/Pr8n76/6j9dEAcCJtrxlvVwWbYXvQnoNPeLYMt7jL40Fex7G2jNAGZTzaUmvtjMTtnNZz3QWTdadvFGU6R0ype0PdHGn7Y121/PHCV4RzJY9POXWg1NvGb2j0FJDBkvB1hVCxHI28BSSbBAsqRG//w0o83H3ukLNvKIA6Q2jQNlzk2uP86v8ayShrw2r8Mskn+/vPgvgX1vpxNGyh89NR8OTgpddACDDwhVJCY2mzwXIiiKNyEvrLMX1cDShNzDJ+b+xDRNpWvSJP42jhiLqU5ROcQb0s2UE17TqbPX9Y/FW1JYGRs4nofvzB2hhLTMcF6eqYtqLLimmaYxB3tLnRXTkZaGpmZzLF9uP9lja2mo0Qok+9O7YrOpynSRHUkd7TIbElHFvgqUR6WbKp2Haiua9627DQ5wFFDGp5IlkWAlWT0FBLFzl2XkccoLWgRbzlqhNQBos9AjxBswtFEhkIKD6wEUqJFZ/QrCeannb0iNf/MaWcOsXYg+/EVbTJjGxB0I+UVjRn1TU5+HACn6zfjsA09n3sNaWjeD0kO/aDe0dAkOdPNV6n+P5Ogl8JpI6SAwvCOyR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCE2b7CHBNCf6QCJzKDW1kwVGy6qlZWCVrzrk0fB3Fg1hjg8rAD7VtGl1sZ2?=
 =?us-ascii?Q?DWjrjcLFADjp0djVo96SEyeDtVThBJqeLoah8UvsNAL5SfeFk2MatC0xdnsb?=
 =?us-ascii?Q?l7G9LYvmynRxSOh3tMhMmnyk0GXIrlYlrScwgXeQlXRRVl5iL0nsfJUmLRVN?=
 =?us-ascii?Q?cwRmpJ5+Vww9MDNNLCCVoW/QsZT59bQcbtaS2CfONtxQqDsLjI2F8LVmqODP?=
 =?us-ascii?Q?cGcMkXZMUk+KO8tJMmhrgENG3RFGNGUi613tOfZKLWfsgBz7vsw0NZS8YqjY?=
 =?us-ascii?Q?YgcCvwKJUiVob/uh7TBmmgYkKJELvvkLoT7U5pj6KRSDJ8r7Kh+UwA6NL9oi?=
 =?us-ascii?Q?hjy8/vXaboBDnQCq9rBpOYq6zwQzrsredVY1s+mGBgexpPQlN4BsjaBSZX43?=
 =?us-ascii?Q?YCbC7tPOSVnPhh+PYxxITnYySpcD2p5o7S1tq4wid6QT7nLezNdXln0pIfnP?=
 =?us-ascii?Q?Q972A0tg46hlZJex8meT2hoLTtpPPcor8HjoG4QQZwOBeojxhuE3pnDzjOmM?=
 =?us-ascii?Q?dx0lWb5uz93folJMRl5MbbdM1461v85yLxx1kWpjFrameviZgU0iRvuKlj6/?=
 =?us-ascii?Q?+C8u18cYCO1L6vhkonVoni5Q17iZjAVkzL7C+ijK2DrL8i/ZwQzAe6YtnV7+?=
 =?us-ascii?Q?NwR2ZfvcPJ4DGLIk/eQUm80DBQkr+YVImbYXEq03My3lrljMoAhUNheWhEGZ?=
 =?us-ascii?Q?4zvQd32/m0w2Rmuk/vG1u8asRJsUfivVHKnOzMcaADruP//3M8bEhMwctTKs?=
 =?us-ascii?Q?65BHPv3lkx781ELAmcfEyqEEXupUdryl4q9fMt6QAsjfBW5Q8RP/Yoa7Ry4l?=
 =?us-ascii?Q?wUHlWdmm7QBaZ17bAhxnRq4Ax+2d2Um6FqOB5GtFD4qR0rxgiTOg5k4617zi?=
 =?us-ascii?Q?2CgvgB5Tpw2/iThcX4q8LhBCi4C4ol8CnYn2q/WOT9hX7o8t0JZA6bb+1zPD?=
 =?us-ascii?Q?LEu2vP2KQu5A3c76HvYg5hdOIJItgOrvzHU4JQ09TZHX7CiJi08tY7YCEDjH?=
 =?us-ascii?Q?GAiPEW0r/mJQiL727+KaYCJkOgO0H0XVYamJ6PWpaAXEOUJ3bvF8VlCtrVp9?=
 =?us-ascii?Q?3/dAwoBbB4k1cjAsEiG9ukPoXGsRP5XJf65MZBNE2gEnmhnHo6xZ/43ceBzO?=
 =?us-ascii?Q?5Mj3xOxMfHJgpIw38pGbwmijREGGsdjblvneW3VWbOUSBg2ooVL6hEXqv6fS?=
 =?us-ascii?Q?DNG3cli5RyYTkvi+nxrNRgZKP6QtcAMBOv4T2ncaJzfDpdbxfoVPL7RDEgij?=
 =?us-ascii?Q?DrUGZl/QA1lO1SNUUrgSV8VkbVoXwFehMN5UEDyTCSrWp9DW4hSft7lK99B6?=
 =?us-ascii?Q?30si5OgDKtQDbAo2TRjYK827DGINSTs5XhlCDmKPKzbTkteowiq6wtTSljq2?=
 =?us-ascii?Q?7Oe9lp1cXo6dkzwI+AwQRsKVpnV0cnyZR3rHMtksYFdhQybZhtZSnrsbrNGA?=
 =?us-ascii?Q?kr/XKX7gfcR4WN4toqMW/lXV03y2ifaA8WHw4T0O67VCePfUU84IgrCZ9Opf?=
 =?us-ascii?Q?XmSK5WUI8j7TPfxfhAdyc252uCYPjoyh9Os883hGeSVRE8t1FYjLAiUsRC56?=
 =?us-ascii?Q?+2GuB3G550mVlAxZIqKllpH6VvF0LxlJAECvaSXS6UOA1lT333yhg9gttRzU?=
 =?us-ascii?Q?ypZoG/Ucvk2S6PfCWC+OSXdcnJtba/mZ0/gkVkW4Vlw6y31doW7Y5WakG6Cj?=
 =?us-ascii?Q?yBNoqAUBwukn2TJ2w1joeH+tM5F278f+fpj8lUYK3Git/0Xa8tYuLwAwttEp?=
 =?us-ascii?Q?wbZ7gjw9GbznOzVX4OO8q8hbMjyr2gw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8155a2-f80a-434a-32fd-08def952a5f2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:50.1336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZv8uPa1/SAyMB9rhBr8VH0uWuULvW921iVag8RTuO39oK9YXGix4ptQWhN+G2gfuXnd8oZAaPJ9efZ2OgmExvYJGDj3FpF6jEE11/D+AB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
rather than to a file scoped static object inside
npcm7xx_load_kernel().

Let the caller own the boot info: the boards store it in their
NPCM7xxMachine and pass it to npcm7xx_load_kernel(), which only fills
in the SoC specific values.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/npcm7xx.c         | 28 ++++++++++++++--------------
 hw/arm/npcm7xx_boards.c  | 15 ++++++++++-----
 include/hw/arm/npcm7xx.h | 10 ++++++++--
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c27f149c04..608d533cb4 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -364,22 +364,22 @@ static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
                        NPCM7XX_SMP_LOADER_START);
 }
 
-static struct arm_boot_info npcm7xx_binfo = {
-    .loader_start           = NPCM7XX_LOADER_START,
-    .smp_loader_start       = NPCM7XX_SMP_LOADER_START,
-    .smp_bootreg_addr       = NPCM7XX_SMP_BOOTREG_ADDR,
-    .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
-    .write_secondary_boot   = npcm7xx_write_secondary_boot,
-    .board_id               = -1,
-    .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
-    .write_board_setup      = npcm7xx_write_board_setup,
-};
-
-void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
+void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc,
+                         struct arm_boot_info *binfo)
 {
-    npcm7xx_binfo.ram_size = machine->ram_size;
+    *binfo = (struct arm_boot_info) {
+        .loader_start           = NPCM7XX_LOADER_START,
+        .smp_loader_start       = NPCM7XX_SMP_LOADER_START,
+        .smp_bootreg_addr       = NPCM7XX_SMP_BOOTREG_ADDR,
+        .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
+        .write_secondary_boot   = npcm7xx_write_secondary_boot,
+        .board_id               = -1,
+        .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
+        .write_board_setup      = npcm7xx_write_board_setup,
+        .ram_size               = machine->ram_size,
+    };
 
-    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm7xx_init_fuses(NPCM7xxState *s)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e..ed65b6693b 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -374,7 +374,8 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm750_evb_i2c_init(soc);
     npcm750_evb_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc,
+                            &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gsj_init(MachineState *machine)
@@ -390,7 +391,8 @@ static void quanta_gsj_init(MachineState *machine)
                           drive_get(IF_MTD, 0, 0));
     quanta_gsj_i2c_init(soc);
     quanta_gsj_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc,
+                            &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gbs_init(MachineState *machine)
@@ -408,7 +410,8 @@ static void quanta_gbs_init(MachineState *machine)
 
     quanta_gbs_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc,
+                            &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void kudo_bmc_init(MachineState *machine)
@@ -427,7 +430,8 @@ static void kudo_bmc_init(MachineState *machine)
 
     kudo_bmc_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc,
+                            &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void mori_bmc_init(MachineState *machine)
@@ -442,7 +446,8 @@ static void mori_bmc_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc,
+                            &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index eef7cc5332..9f3dd489ec 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -19,6 +19,7 @@
 #include "hw/core/boards.h"
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/split-irq.h"
+#include "hw/arm/boot.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
@@ -62,6 +63,7 @@ struct NPCM7xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM7XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
@@ -129,11 +131,15 @@ typedef struct NPCM7xxClass {
  * npcm7xx_load_kernel - Loads memory with everything needed to boot
  * @machine - The machine containing the SoC to be booted.
  * @soc - The SoC containing the CPU to be booted.
+ * @binfo - Caller owned boot info structure to be filled in.
  *
  * This will set up the ARM boot info structure for the specific NPCM7xx
  * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
- * into memory, if requested by the user.
+ * into memory, if requested by the user.  The boot info is owned by the
+ * caller because arm_load_kernel() keeps a pointer to it for the lifetime
+ * of the CPUs.
  */
-void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc);
+void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc,
+                         struct arm_boot_info *binfo);
 
 #endif /* NPCM7XX_H */
-- 
2.53.0


