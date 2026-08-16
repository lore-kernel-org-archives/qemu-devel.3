Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B373BC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaiB-0001f9-Lr; Sun, 16 Aug 2026 09:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai2-0001Wf-66; Sun, 16 Aug 2026 09:15:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai0-0005Tk-8U; Sun, 16 Aug 2026 09:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmOd25cu1vrE8AmPyEzM/YmoWysq6u0GRWkk10+VY6Jdmwt8e9Z7s+IIcOO897Pig4KRuqqkB30H6ZCHAA6aVoQzCMSHSJVz35CsStW3AvDx1erBlnLvYzoErCC21Pn0lAPxBBzpp6ULyoIh+8Th/os+6mmvKvONatkpUVi6aX4Sp+hMggnMjVhYTI6FC3kUV0Jyu5MpU52ZNO9y9c+duITXU5pVUmbMXUQbyF3K4AQgbJHoJajYIKusXRMDW3PUrKhcW/qWXFU6VMY/bKodaoqqZpMPMs7fBjoXxH+9mmIcGjWKx2tlJIi2S824CH+Zl3nW8Yk6Vl40uZAoUt5L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d79OC6C+eegIaqkDVi56PZVegbv+CFn9CEvYsX9ar0w=;
 b=OUm4eeUNSl9mH/3zdxt5cxOyV/o4rgyQ2BfMbvC1TPuSnMgv5fVNPzJRQK8xjzy/ZTxiF9IPvh1thgiIjxEXGXxASaynzDZl1tyb0ZzKWOU8HBbTh7W+wFNOmdy0BUotC9poDjcB0o6ds7qVMY3AY+HW2M1aoKb8zzt12GBVk052jLt6vUOhAAHHjGb1DUPaPe2Re5nedaUwl+Zz2MhZEw3yoJEqD/2rGZMjWu6oViOCdNujvdg3g/pSLGv8LB3gsq6cij2/ifT31oeV4S0hQeZ7QLcHMyNKVZo+rNHE0qAvlpHD2gSmAnlHgXgruRXt8mfI3VuAr1rpxqp+vCMWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d79OC6C+eegIaqkDVi56PZVegbv+CFn9CEvYsX9ar0w=;
 b=cWO2ZoD/q22T1fNQayXDwQngwyHMi8nm49nGqgqOyvM2jyR71yRSvErB1L7q6BLlyhwh0oUSSFlywTHd1BxjGCdGM5IO2MFVwaob/qA3RkdluA55h5NkfGW37GIryQuafEmcamY8VVgPJR3ahLV+OY1bU0VQC7oBCRR2iw6vJWIvc5641+48FzRk/7V5VdcwhBEXUg5C9e52jTBOURaahncjnpgTrex1ED868UcGfqsoFizQ29IFP8Tu10y+leZPFbRne1aydM3R3dT+CpcAjYKcU82lG0hb8G7L7XZq/a8ldK8odCMTKNrBVLpkl9GFlO3j4rUjVz8Lb5n6JHTkCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v2 06/20] hw/arm: exynos4_boards: Store boot info in the board
 state
Date: Sun, 16 Aug 2026 21:12:36 +0800
Message-ID: <20260816131300.51799-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: f70432c0-2f64-4faa-d740-08defb986b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mv40TsTNdQrvo2MrJKU/WiCW2r5tcJgq4YE3bib002tNijOum8yQURZ/ZDQ51tvEjwtn/yWCd+Dx1HTqwUD4o3BFKWMINXS9qE/8EMjmNGJsTWrhcw381qqYJyXgr4WJwehzY7bEVtErzyAoCdbE2iZD/9BKCnsv76rLJLwP8hpb9s5HRE+oWP0jEwTQYMquXYDAeVnH4mKQoUi81F9DFC1kkDEtGblpfJOVuXp3HsUBdkJgJ+lLmeJ2MBOxo8/vrRFZ4pZpQfFRAPJrh50VNeSBrJOD4+kgcIfPNeXlQ9aJB7FhkcLSMwaCE5nOFp3I+aICDPQA3Sy+TPbEefWNx9XW5z5x9NTJvlCgyVYePcMtLaR4yHZEXKWrEaI8BdtKbl2hnh8KFytfneDJaEI49QidC1xGVnbrK9CIwZrotyechrreWrBbAI9LZpf+xLfOJKd5Ym5b4I9jKlsnfjUJILrl/sNUbH8bXqMFsyd47KYtxMbHhCfkp4np2KjKQvP4CAxcHfUCMIXhEfi+smVZPoaH8mUkaYEHpxRyAnrhTXt+vA6K9eM7Ow0trVsT12dFDnxEUO8h0Gw90HHAqlUaZWINjnEniBVF/uVLSlU6ecMwwM7NXGOQqgAFa8N1msSxwUZZx1FdGi3DsqIyh7IDoESkeqQY56tAJLBGWB55xGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DLLFzUNvYDiQ5hmTR9uTYLiExz58hmyWxJqjMe3/T2ObW5bZykui60Jb0L31?=
 =?us-ascii?Q?07MigTdLxWsblVn15ayew4WGOc7tiD1PurIpCpULBhQnl9TB19JizCmDjoih?=
 =?us-ascii?Q?4eE43aaFQv/4i5j3/a3aE+EWg35QsLB16MgU/SmIosSn4EgaCQno3Q1BLp2Y?=
 =?us-ascii?Q?aedyLVoRczeoBryycpCTJNSFo2QnKafxWeWroEEqtTP8pY+97Jb0w1SJ9OPJ?=
 =?us-ascii?Q?4CqoZp5tgOFlOxFYZgVZIVYzljYSr0azQOC6J2JvaFLeipGKYsoydYeNO9Mm?=
 =?us-ascii?Q?tQIk0l9jZ8MMiGcPezczvzc20+LOPkAmZlJPUvYpPf84wiCJ4O1KZF0nSwsc?=
 =?us-ascii?Q?n+IZyvuwoFhwzEd2VQry7Cutpc1wB96/G9uxS4eDEfL3W1UlEDPTjF+DPkQR?=
 =?us-ascii?Q?lzLJbB9vhWg2mRLFWmR9/a7QZbo+RfIBWaTN1E4OB1ogSsDY9+GYIe8TuSUz?=
 =?us-ascii?Q?zDX37myPy9Y8NZfJSDL8YEtfzUkK467vifdvEvnavWiMaYQ8o0YVo8kfMkgN?=
 =?us-ascii?Q?DsV4dYsAP+Vy+vVpWbBMjv329j4gAjaxbW9PVNfe21jTrbqwr+F17N1Aw/D3?=
 =?us-ascii?Q?4wjbySSSSGrI75WVLCtZrIGvmdIYqpwZG4g00hVb0deGqSXayXM524SfOgfE?=
 =?us-ascii?Q?qTrTLgY4xxLi/sMPWJ/iWokIaHbZi5jYcF9UgWF9AR1OL3v4trn3/CaRbqws?=
 =?us-ascii?Q?u3KvlxlJ8CoupFkey1BjD4nyjPaAng6vdaFXibGGhsW/2KxO2G1cpXl07qLs?=
 =?us-ascii?Q?GxhtKoDx1i2EJ7VIqV8j7EqQw7WJwDnQi7dfkQN0mZKvW4I/8qfGVLMVkZBk?=
 =?us-ascii?Q?Bh+8ZN60+ZbL3LJGISqIVfAbCfJzSdzRX5BikTnH18CTTY9aaIYeKu5TV7PH?=
 =?us-ascii?Q?NCoumfMgExtF8nA2Qrz1LmnnY0fM+X+2RLZzMCBCSD2LbZDQZoDXx9nF26E3?=
 =?us-ascii?Q?Jp7PSa6cw4mEKlLJERCjeedCaF9k80n7mhWI1taXI6QhAVUwBSqpjJ54h9aX?=
 =?us-ascii?Q?azF9r8bW4HfBjiC9WFXy/pPi4B7pQEhsy3wHNuJNOGcXB6y040GOhvuMr+Z2?=
 =?us-ascii?Q?wusWALL4NUE3HQYGqnAYQVcOMPtdhur54KfEhl+ECwMdlUh/apPfrZqLMpgh?=
 =?us-ascii?Q?fMNbb4OOHll4+sJWIEGA/Xv7c9nqI+yqbfM+oIap7PN98caUN91V+R+dLFQg?=
 =?us-ascii?Q?n94ZkSYriNyKsxZofsvyUSrkX3bBcKiIqe+mK6NbEIH3AdJZ2CZxp8pUCgZH?=
 =?us-ascii?Q?q74dyxNdJMfVjCrbNYY9a7m5Y0rz2SY3YsnMBwR6v6Bqni2tGFe1GHDEfMBL?=
 =?us-ascii?Q?Bgj+NV7LvQ5yjC0tkmlN2kQ2CbQGQQLdN3KeySyHlW9SUdHQ/BFWS1AAKjPV?=
 =?us-ascii?Q?tMiXW21lhb29yjzsAXtH4WzuU23WVA4s29/44ss+O5jRRzYOAD0Pup3yqrkL?=
 =?us-ascii?Q?vihdIZCtB9UciyUZywf44CIObZbrd4WUBJ3l288ZRd3/3KilHLIqGU6e262o?=
 =?us-ascii?Q?Fg/gN7VcM5iva7IYr9+QC8yBXvpX2vn7BE29EPCn3Js3YjpQXbjvSuwCEtww?=
 =?us-ascii?Q?K0nTNLAIwz02M+/AZeIsWq1ymGUu2ks/r3xE5q/JHvgPP6+4GPqNajCHN8h/?=
 =?us-ascii?Q?nBLkdNXo5j2fem5fJPjO+yaL9jix7UBjSGmptF6zNNcITJd5Sm5YERs9/nMJ?=
 =?us-ascii?Q?KIGG55OcAKfxznO9YNWRxgYliFrKKJcV/xL6MgH9Z7L1h0ksqlQ/XoYaljx7?=
 =?us-ascii?Q?sdrEpn30NAoYJAk+w8qwxhzRJR0sAu4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70432c0-2f64-4faa-d740-08defb986b43
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:18.7675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEW30FxzEqlPmglknivf9hfqsF6pvslU4vAqHHG1+F6wwuv50LoM33Cvm3MWx4IP9fcZUlpWP6/1weq/aeYlEG89uDf/FTOJaURnb+Q487g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

 hw/arm/exynos4_boards.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b8c9b618f..b7decdb2c7 100644
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
@@ -113,14 +108,15 @@ static Exynos4BoardState *
 exynos4_boards_init_common(MachineState *machine,
                            Exynos4BoardType board_type)
 {
-    Exynos4BoardState *s = g_new(Exynos4BoardState, 1);
+    Exynos4BoardState *s = g_new0(Exynos4BoardState, 1);
 
-    exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
-    exynos4_board_binfo.board_id = exynos4_board_id[board_type];
-    exynos4_board_binfo.smp_bootreg_addr =
-            exynos4_board_smp_bootreg_addr[board_type];
-    exynos4_board_binfo.gic_cpu_if_addr =
-            EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
+    s->bootinfo.loader_start = EXYNOS4210_BASE_BOOT_ADDR;
+    s->bootinfo.smp_loader_start = EXYNOS4210_SMP_BOOT_ADDR;
+    s->bootinfo.write_secondary_boot = exynos4210_write_secondary;
+    s->bootinfo.ram_size = exynos4_board_ram_size[board_type];
+    s->bootinfo.board_id = exynos4_board_id[board_type];
+    s->bootinfo.smp_bootreg_addr = exynos4_board_smp_bootreg_addr[board_type];
+    s->bootinfo.gic_cpu_if_addr = EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
 
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
@@ -137,7 +133,7 @@ static void nuri_init(MachineState *machine)
     Exynos4BoardState *s = exynos4_boards_init_common(machine,
                                                       EXYNOS4_BOARD_NURI);
 
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static void smdkc210_init(MachineState *machine)
@@ -147,7 +143,7 @@ static void smdkc210_init(MachineState *machine)
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static const char * const valid_cpu_types[] = {
-- 
2.53.0


