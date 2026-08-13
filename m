Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ACCC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhP-0008Ep-Dk; Thu, 13 Aug 2026 11:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhN-0008E7-SU; Thu, 13 Aug 2026 11:50:29 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhL-0001rl-5y; Thu, 13 Aug 2026 11:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByIpZ8vCanpL8WYW1/qdzMhgZVLfoO95B1CsHw7Ps0Vx904pX6m/4zvivdHNHQyWjE2VmzcZP+qzmdE5gcIhokFx+f/aP+NBzIlbYuQjSY/bjOagPdml75UI129rnRz0NpbNG2CbBngiGh29/E/+iq5p37Q6RtCPJH+aionv1CBchdd7of5e8s8Yh+somdxjWXjpwvNiZUx3H+2hvkSt7Wal9/jnfnSSeKBfMvXCvSNFS8IM5rB9Vn9SCQEU+1zTV06ovZLz2IlsJwTIJ4irTSjtopoCeyBVEDsmr9FOBiFcowstDAahXm97RiMclOgReDfDFoDjdB7x627ta2wzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjueGYjCU53FZ9A5qWQI+8yduXgDal2Ap+mkNizw0XQ=;
 b=cClN2bwuNkJsO4QOGThogyCpSHSha/2RponNbBBPTguT5yxVRNswlAp5fybOof7nZQ31K15Ua8OTrMwADMy+WzYtaX0hUwgedEz5crF7B+udytGs+BHGgpqWEE5YSHgXNaE+wiY+AvY0i89VvTKmBGcVMZ8za9i2O5/Mcw+Lao2s4+pinoMzgSW0hogLk7uDr+HNcoIbRoDffOgnX6ametfc07xxme3ad3axb+WccztG61NkymJndY/rfgSIcnrU5RhkWE3ToC47qGHhPZbznoF3jdW7srAJN5rlCwk1UrAm9gw9aE2MPrZJgbqkhrJWfYczZjlU6WaUqvvVPlxO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjueGYjCU53FZ9A5qWQI+8yduXgDal2Ap+mkNizw0XQ=;
 b=qsbjEjQGeGnDIqTVhKYpu3QeM6aWYtTYFdjyfBsBTjqFMsdJy+u7qmjFSo3KGnZxkzc8Z9ApkZF/1Vb2gYdDzhLPKLO9Eu9qYSHQhUddlh+AzE0hq/4Fw0yBGaTnBTuE08V63+Vy9XkhRkAS48GAJUxVm2UIaE+Aqwbo8pqVqc+f/lc4hIFuYN/Bdqkd4nOteE9OqP3aFuT4OfjtJ0hlfUujxLh37OB/ipxiUrtNGTCT1xCGrCfkVVd1cK77mnlrM5kb0XPDNE+K9axGeDkOY+h9zQBDkZ3Jb4E1R5n6qlnEMO1RXEggda5sVAtd67LN8t3JhzuIsMtkWGp/I4A2xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:22 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:22 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 06/20] hw/arm: exynos4_boards: Store boot info in the board
 state
Date: Thu, 13 Aug 2026 23:48:54 +0800
Message-ID: <20260813154918.996812-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 65d3c669-f877-45e2-0335-08def952955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2wgefPraHuKW3JxX6zbwptyxYvDeFa4idbe7Oam9zSl1PDtUmwCO9JgwK/V2TOLZbn2iCrjo0mq0p9moPDMZp7YHyI1ShpoFSv7a7km9kXKixr8mVajzIItpXx6dyLIehV9KCuH1BdzFjbTeImTbsv5B20gDNrOLFwwbh5cAOjsWnlnHKFJdsiFlsbIxxVmpAADVUIBag3TPohbP2p6zD+Y/wlN8PRpkBJp8H+LnjV0p5WEh7mwUu5IQbZBjIa89w36gUIqeQo3vTbGVN1mtk6NgCHbFa2M1NExDbs2aAifOSdnQOInvDW83ANvpL1X2wIJwox/UgD1/vT6mkCz2J9zJUzaJ1dZgt6MeJ7FDfrAbBoWxAvbMs7PopgwZmCZEiPMa0S6UOXJKptKAd49XOm6yaDP3g2yDWjX+IgGKU2EEnQQQ9gG0k/Hn7hMJC50DFcSgcWDHoQ1h6to/uXizTlkpR8Ctzijuzf0TC/fGjUcoRm3jEbw9FzUly5+O2gXtPbM1J1cI/JtOVuGLwwnouW6EgbufRkfrMzql4lLUp4Qn3uirYq3UywnLfpB8+dOGgMfi1MckIMPGg8AfYzo03KieXjI0BdN1O/b8ulZGE0xBfS7kzwdjg5nMsiBgxd2zzEO1X2lhoFg5IwjFP+buXQlV0/mi7KS2JKUdUj2qP08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lzscu5/CnY9uxMdmCOI6UA5H1Q50cTIv32Lc5PnkK5uWs/W6MmW/6/krK39a?=
 =?us-ascii?Q?08rPHPgK7bYTxFCoAMwSYc3wQOkjO9B2AKsWr41WCKjzhG5CDBVALqvx1IYw?=
 =?us-ascii?Q?rSzls7+pw+wXp+x/ykdLK6Mb4uLNcHGkzAk5gI4138gqYJUj9DmcwtpaAOWN?=
 =?us-ascii?Q?ci8FFCy7tA5A4pedZFBRxwlicp6/BOizTyy7WCzDLYmXF0Ie7uVrENZzRdjn?=
 =?us-ascii?Q?LyUSlx6nEuoWXM/T1IGsJbGN6XuHu1AncdcdR8Icdtk0tUHmkTwFpCVaVRAQ?=
 =?us-ascii?Q?tdHJh4RCVYaxH6ia5BlVLCA2o1O697IzNRimCqbz24HsxsO8xFBkCWoHSm3A?=
 =?us-ascii?Q?BBWEGW17yDcI5+znQDdbbVaXsiasDayO6HdUBL94+aMn6uQY6O2QZkTf6/Mw?=
 =?us-ascii?Q?OWEtH+J1s4Iea8tpC4abJNj9YuSYy5/1ya2KJfpdoLPTwjv30AuRZeHtlztD?=
 =?us-ascii?Q?yDZR0em9S+zRnDH5T1HwDy7yitbSYyTSR+rY3NGmmS2lrI9DuzEpRlp/aGs8?=
 =?us-ascii?Q?cPCL2YrvUHE9NJrVh8moR/OclLXs/LVgTKpY26H8FGEXvhyNjvuNVn3e7QR/?=
 =?us-ascii?Q?qvNxpA4Wt7RvdWVULUXm1f0nyuWtmvenQ3scrojSFX2ayBe0evv9dON4BXrW?=
 =?us-ascii?Q?wqv87jwqAh+CNrJQtA5+Ox2Vb01VaJmD5d3sD7WcaWFftSx/LS4fCkd5Vq0S?=
 =?us-ascii?Q?Ru9JuIF9sJQ0e/XsR2Dj6Sg9wMzxAXK+7XjEZHgAPehSh91uqNay5NqxWyMd?=
 =?us-ascii?Q?EyOgRdrx+xS4E04gMSGx/WS+Bur+OpkYqpfARI2C5QHDbz5QClSK2CKlz3l+?=
 =?us-ascii?Q?P3vzPo6G3wK9fqJh9k90oKcSvGm6c9yu+yHP0IkQ2tz2dYmmpe6tHDokTMLr?=
 =?us-ascii?Q?Okkro+MRLQx7rcgkZKyapTrPHpq78EqmCILXsm6uW2SsPdLY26dN1c4icPjk?=
 =?us-ascii?Q?OC+WSq60ff4ZBjrRaxDu8WZe4OCnT1wSIAIEpPzNBfQEvAE+ByGB3Qi1gzak?=
 =?us-ascii?Q?6y/IyrsTs1oZI2E55jepejLgWIcKDlA1CaegETBoxOU9ONAExYiU2a2mZb06?=
 =?us-ascii?Q?ODzF9zCVLTI6JDBbKrvotOZpNJ49rareSpvaZg9rDlbGU49bjae2YnBM/GgG?=
 =?us-ascii?Q?1esUYuU9H25hun1YbjLDISY5lXNn02jQtmTp1PTaPPA4gmAxGVBF+BN/Bn1i?=
 =?us-ascii?Q?jBkq1G9Ib9pm8TOCbX+yFmJjfOLQK8LQL6PUIHDgcOm4AZ3CUjeoagWWEF4Z?=
 =?us-ascii?Q?l7VfAm79yPZ/2YAftnUesADxAmpqDFwf/qrz+Vi4/bPArNb/AlWZF4xh12Kn?=
 =?us-ascii?Q?WxuqczPBq5eonGuMRppcpiP/E2XOGwdLz/dduyNi99+NuBTV+aiz0zh8K/hY?=
 =?us-ascii?Q?Pa78LPJc4B/t/5+Bol92AYJti6wkCk/73X/rbTllBt8GE+lPdCjU2s65/Xvm?=
 =?us-ascii?Q?IgneQ16g2t+nSdtmPS4TEjntRVDVfLKo4lnOn2UHETuHss3Ooea+pSQgVa2q?=
 =?us-ascii?Q?CIWf3D/b+oxF55LgH0rIkLGqpeBaUI2hBA7GwkTi/vtN0TK7yyKXwAjtVqb/?=
 =?us-ascii?Q?uYX/Z/LRMKBz9NOEQzU7eUj87zO9RMaS6SmzJGogfBPKmRwGBAjTuE52njlf?=
 =?us-ascii?Q?Q5mgfR/qzVm3eGsknY0oXqU5dAUzjJVWtiy52YQ3ZN/UFlvNKCU7sZ7XpYox?=
 =?us-ascii?Q?hvMeawlbO7mtUxxDJRwOXGqvWDYMR05Ha7YA9Ll3Mv076kmq/6pnSeB1l1Xb?=
 =?us-ascii?Q?zqPSez1TWC8B3oJPI2/Wu3od8hxCKzo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d3c669-f877-45e2-0335-08def952955b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:22.2592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JQ/StG8pJldFL8Ir0iozQ8ER9i7h02C07x7uj6qb//bFpbg6C51dWrAR3RVpSPcB0/UdcMIVa64PqNczYMfgXrTSSFa0er2odgmdxmvqow=
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
rather than to a file scoped static object.

The Exynos4BoardState struct is already allocated per machine
instance, so move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/exynos4_boards.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b8c9b618f..3090172e54 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -49,6 +49,7 @@ typedef struct Exynos4BoardState {
     Exynos4210State soc;
     MemoryRegion dram0_mem;
     MemoryRegion dram1_mem;
+    struct arm_boot_info bootinfo;
 } Exynos4BoardState;
 
 static int exynos4_board_id[EXYNOS4_NUM_OF_BOARDS] = {
@@ -66,12 +67,6 @@ static unsigned long exynos4_board_ram_size[EXYNOS4_NUM_OF_BOARDS] = {
     [EXYNOS4_BOARD_SMDKC210] = 1 * GiB,
 };
 
-static struct arm_boot_info exynos4_board_binfo = {
-    .loader_start     = EXYNOS4210_BASE_BOOT_ADDR,
-    .smp_loader_start = EXYNOS4210_SMP_BOOT_ADDR,
-    .write_secondary_boot = exynos4210_write_secondary,
-};
-
 static void lan9215_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
@@ -115,12 +110,15 @@ exynos4_boards_init_common(MachineState *machine,
 {
     Exynos4BoardState *s = g_new(Exynos4BoardState, 1);
 
-    exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
-    exynos4_board_binfo.board_id = exynos4_board_id[board_type];
-    exynos4_board_binfo.smp_bootreg_addr =
-            exynos4_board_smp_bootreg_addr[board_type];
-    exynos4_board_binfo.gic_cpu_if_addr =
-            EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
+    s->bootinfo = (struct arm_boot_info) {
+        .loader_start = EXYNOS4210_BASE_BOOT_ADDR,
+        .smp_loader_start = EXYNOS4210_SMP_BOOT_ADDR,
+        .write_secondary_boot = exynos4210_write_secondary,
+        .ram_size = exynos4_board_ram_size[board_type],
+        .board_id = exynos4_board_id[board_type],
+        .smp_bootreg_addr = exynos4_board_smp_bootreg_addr[board_type],
+        .gic_cpu_if_addr = EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100,
+    };
 
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
@@ -137,7 +135,7 @@ static void nuri_init(MachineState *machine)
     Exynos4BoardState *s = exynos4_boards_init_common(machine,
                                                       EXYNOS4_BOARD_NURI);
 
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static void smdkc210_init(MachineState *machine)
@@ -147,7 +145,7 @@ static void smdkc210_init(MachineState *machine)
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static const char * const valid_cpu_types[] = {
-- 
2.53.0


