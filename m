Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD99C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXi8-0000JK-NR; Thu, 13 Aug 2026 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi6-0000IX-S0; Thu, 13 Aug 2026 11:51:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXi5-00023y-3v; Thu, 13 Aug 2026 11:51:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMUS2ojfTVyQIY1n73dqkuse5AB6FSHBseLoLvseoR7WEEgsKiqwoNZEVH4/TfmELOXp1Tg34Jgl071hjCo5w85ZQwmj7nopNVE2BKLSQ45DxF9R3hY+E12WQBr/9AnlTy8ADk9gRPcw8X/WAl2Ys46ASI+oW3d8O0wDKwb/2Xe1tYV5PW1PuM0CqHNX7otuhH9LpFqoxZEBmDWjuSyFPFWYtDIMMBJhY24r7YY6x2mXmQJzEHpbFlSmi/9Wk/+s8hf0T/OltNIeNxYSFMW0t1/+1sThtoxl9z787neNt3O7adZ5UzeFboF8063mgDySONVmRgRdSQg1ztL+oFKW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AJg5ZJlQk+3HHEYUO8QRzCquawWJodGRo6i5lObuTE=;
 b=rYXIe2CnT+fw46o8kmt71k8aX3f5E6V5UguBM+dpeqx+DqSmt3WTaCzaLAfda95ym5JeIBU5cuxMLDqB8qlcYyBfApFKRgry0ScPmP1eTCFjCuYytOxzA4dGxPBO4h+5Ace2fyiaI4a/xW+3cFRvOT+6uMvBZ8xuAYIMmv5B/1hEq6SqqjNZn4wgxZdmXlWGvL3XVaMcCkdK32ESFe86dlMKgLXTdVt1+Dqu3Fh6m6xwiTfrG9ihUtKUE173Tj0sCd0vf4l+gme8w91Z+OxHOtLfo/9vaBrnggDYsBDNNAl4u/qMwJgTg9xyHSkOylHNKLrefAImwmyHIVY388JRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AJg5ZJlQk+3HHEYUO8QRzCquawWJodGRo6i5lObuTE=;
 b=duPU3TFldCKea3MyW1jvELFCZ4RM5sHz6Vf7q079vPwCREwGIRpfh399XdxPaL82BrmlmSxjafP0r65JAg2Q2v23CcmFxYrTkQObIStXqdyVkdne1MtanjG1MyM1zzlGHfdF8nKDLqDloq6rbnLrNmjZHPLGa65ghBMGvAWh91JTSImuDTmrx1jnESuXDOtktf1FjI8n3xUWzSXewhG4++Kd86jQsyVVXwlABGRZxx1zRUvgR/PS9dKQobxhDpkIkvW96xgXYS1gzh+Kh3++T/QZYnlZfZLis8+6ZCSseYBBxb81UmQxXrCUU6A6MbbMUBajac5EsRMUNOyrkfK1vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:51:06 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:51:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 17/20] hw/arm: realview: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:49:05 +0800
Message-ID: <20260813154918.996812-18-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f3fc06-c5e5-4f3c-549e-08def952af5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rWlxcQzrWN2Jw1Zf4sJlHiiyF1/HJvlbN9IF9glixJumY0gvDxX3zMXlcQs1didzojZNHRPgep0R28BoGkMogubuos3BDobmcFPn3aqHNnrgo3Sdit1LccunLNFTqVUNBIHLzk9x+SvEvlmgt0mvDQqEdBPerb0MzISuJNxA9hHSVK/RBj7FNlWhSLUP9bW8ExPkSJ4aoNhAYGMSuLfQOVKzd5tbfFnvDcqSiSOX5c/vHHKiH66axE82GTukAUgASUCgtAEjJ0hI7aUstPrbD4ayvSDyB3M9IlUFQigLBGVPus47qv8EgzTQFd4UzvuSJEIc4KVQUkTa4x9kYLgNondNiOrq32WxqJenoHrJdikHWgGgSBGzoFLFAe7WfewPzsQ333WE/mApWwk1xHEc4tXi1yWjPLEmfq8bWKED+ORGUSSAKptZU1wMdvKZWfrjP2c/6c4dih1S9Nj8fJrsl1XVomHU2q6PpC7ShRxyUM1f1Hw3aoQdIdonEUxJgEEvBHSpUJDM4JZxUG69Jx9/4mvunUGY6Z+HrmiKh1MKSEBF0IQWG2P0Y0NBAgpE0L8eSFmecoCYQ+F1XkdS8RsFOlk6aTLOTqCVM5WqW4ZOh5EJBKkiqYk9tTWz3pkb1mHeZRRIi8M1J4Naw0FkKCdSh5BlMVlODiNpAcZK+vShaSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeWhhIlAzF5OFlYVu8BvTWFBB8boD5U0FmrDDw1pN0J61z0Px1giASdIaDnP?=
 =?us-ascii?Q?Qlagy93Ywl7wjLCwmg5l2uDyWSnc5xUFIf5PC+7swjK9vlSjvcbZPFzDoE7g?=
 =?us-ascii?Q?1jVLXbKS+ZTsNp58THd6Makyrfaxl9/Yio2Kf7Lm2ELxc+EerJIzhBcy5OxF?=
 =?us-ascii?Q?ERM3/WTjBhtwRfU6s+3MpVZGuRBCwfnH23Ht6nCQqa1AZtY6SEn2qLCc1k4z?=
 =?us-ascii?Q?9Q7Uwrkmu6CWLA0CrFYFh2crV4LAPExcPcu0nmsB3UEi8GBNoqCRnfIf4qRQ?=
 =?us-ascii?Q?rTHzfPn7QfLjbHNxqw0raO+LiX2IVk3+9eM/Wgwwp6mVXM+RkxI+DxeVisKc?=
 =?us-ascii?Q?chM86Y0dQWD8uQJQ+EIPUetfCG5cUX/KXNoZorIW2GUcw4MtowXcoek3fOhy?=
 =?us-ascii?Q?cCGfygTpnqv7P4t1qcWGUxZ7ZicihF+iv6vaIC3Tris+UdQOLYfb7Gjrqd1X?=
 =?us-ascii?Q?kqtoUnf/oMMYyXrGOp503J5WIowIKqVhYjSEvFrPoYzdOSWpYWYxGB90+UMU?=
 =?us-ascii?Q?ityZMvnHP/i9AU2o9QkMb9XA6+w+UakxNJMn4hgFflV0/zr4gSYs0sWUeXzY?=
 =?us-ascii?Q?bdxet+++lA6s+DxIryHjS0A4Q91igkfpiWF+rhyYAJYNsXwnwFPQ2AA2jTHh?=
 =?us-ascii?Q?FzDJxMGy1KgAabUX5+TsEO6qhFGZuH0gqNR2yhaHSKIoLPpjSvOmFXgKoObA?=
 =?us-ascii?Q?LMkH8IViaRN6qS1txiQbaVEp6Txo1kr0b5WnoUWbYZqzFiT9U5Ivv8yWLBES?=
 =?us-ascii?Q?UZ/AaQzIztPd/nJHMWAaHqfJpclmUvS/Loz/AbiXMWwUYmeLUfKMoI+8SEDT?=
 =?us-ascii?Q?v/DQlOhB9eTq8rpm5ALnLIEL+DdY/md+tTmoBm9ZRsW4ZC/jF8jH1Q6qUzJv?=
 =?us-ascii?Q?waboISen73FHepM/9B8FBywxTXTxB5suQESTzC7KWXV11nnGQg+Tukt4+sVk?=
 =?us-ascii?Q?vL+zOdbLLAPRVmX9VtreDPGGt17UNu0LmwPdv3RrYADQSVPgmqJBcvZ3KCbk?=
 =?us-ascii?Q?BGGYpjOTKstTmRB0bJlznNyoRsWgv3uBVIYfty0h0MMs4VNta4SRc2LN4ozo?=
 =?us-ascii?Q?nucbw7JdzzzRMpc+rUWEWfmSmEWnpbZs1O5BGwsxubb62EdtOmye2JED6s8E?=
 =?us-ascii?Q?p/6AAduNMQG65/ymDmMJBR+OufVwVGxhnRJA1IX/Tp8hdnnD0DlVzhyf6B/J?=
 =?us-ascii?Q?qLZWNcUq/mJuzRX/tyuj57tZR8NuaAsY0oGc7Yf3Q228iEF9KGHltQog2zxp?=
 =?us-ascii?Q?n3w139wlbd0vo9lLJ1EabGiD0ccsclcHCUUwtbYIMkQfVSt3g3Fm9UR/NX2M?=
 =?us-ascii?Q?1446v2PHR/D2S25YAEHSiUUOGmNhQtVpP6BkuTjvx4uYdTVuiKeLzoGIWcsK?=
 =?us-ascii?Q?QLS6i9FolupTrjqa1Z1XUxh5gEIlhphCFyhTt/HFRxCKjY/kGTsIhPripGN+?=
 =?us-ascii?Q?byfkHPi0hGOoXUpTWw/Wf3LcjSvYKIdz5S5396PLVP1DKEMoZAAyZxL0V3JN?=
 =?us-ascii?Q?Rn6YGa3tZtbcxZGstTZIRfdmjtikeTUkJsWq9uIqxNfNNAk8JjtP+d7xB2mr?=
 =?us-ascii?Q?V7bFYjrxbvUufcYYHi1ItQ+1G+7zYZBSCIKEMXL/gbP6TuoNC1t3OQw6Kme1?=
 =?us-ascii?Q?fV+mvEbiYV22oxIafTQi0uEL5eVSoYF+C9x4QC9pu6S0buQIhWDSzj33aCnp?=
 =?us-ascii?Q?hhBZ1UzzhCj9qO4F7OuYYdW59orcsx7v5gfVRSw/DnCAUH9hupE0Qiyh0Ad3?=
 =?us-ascii?Q?fh0bI3dveHjf8wof45codoFTLTpDum0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f3fc06-c5e5-4f3c-549e-08def952af5b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:51:06.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35wRmp2W/rGyfdOppInX5DyTxfuFwo3+u1E13fkQP8GqT4l9XikumB62FlZknYjRkkMTXtcmsXwX074EgeWozssd7y9gggg+N33xriZuV7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7537
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

Give all four realview machine types the same RealViewMachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/realview.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2b9f3271d6..e12da39870 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -39,10 +39,11 @@
 
 /* Board init.  */
 
-static struct arm_boot_info realview_binfo = {
-    .smp_loader_start = SMP_BOOT_ADDR,
-    .smp_bootreg_addr = SMP_BOOTREG_ADDR,
-};
+typedef struct RealViewMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} RealViewMachineState;
 
 /* The following two lists must be consistent.  */
 enum realview_board_type {
@@ -76,6 +77,8 @@ static void split_irq_from_named(DeviceState *src, const char* outname,
 static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
+    /* All realview-* machines embed the same state as their first member */
+    RealViewMachineState *rvms = (RealViewMachineState *)machine;
     ARMCPU *cpu = NULL;
     CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
@@ -202,7 +205,7 @@ static void realview_init(MachineState *machine,
         }
         sysbus_create_varargs("l2x0", periphbase + 0x2000, NULL);
         /* Both A9 and 11MPCore put the GIC CPU i/f at base + 0x100 */
-        realview_binfo.gic_cpu_if_addr = periphbase + 0x100;
+        rvms->bootinfo.gic_cpu_if_addr = periphbase + 0x100;
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
@@ -387,10 +390,15 @@ static void realview_init(MachineState *machine,
                            &error_fatal);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
-    realview_binfo.ram_size = ram_size;
-    realview_binfo.board_id = realview_board_id[board_type];
-    realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
-    arm_load_kernel(cpu, machine, &realview_binfo);
+    rvms->bootinfo = (struct arm_boot_info) {
+        .smp_loader_start = SMP_BOOT_ADDR,
+        .smp_bootreg_addr = SMP_BOOTREG_ADDR,
+        .gic_cpu_if_addr = rvms->bootinfo.gic_cpu_if_addr,
+        .ram_size = ram_size,
+        .board_id = realview_board_id[board_type],
+        .loader_start = board_type == BOARD_PB_A8 ? 0x70000000 : 0,
+    };
+    arm_load_kernel(cpu, machine, &rvms->bootinfo);
 }
 
 static void realview_eb_init(MachineState *machine)
@@ -431,6 +439,7 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +462,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -473,6 +483,7 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -494,6 +505,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .instance_size = sizeof(RealViewMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


