Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B439C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXiD-0000OX-4Z; Thu, 13 Aug 2026 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXiB-0000LO-LS; Thu, 13 Aug 2026 11:51:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXiA-00023y-55; Thu, 13 Aug 2026 11:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ1P1O+ZY+/3KQ+Ruq8R+lc1vxxqHClUjyfcPEgVIGdfilSxXB2GV92a8DLv8lJmn8/sGthuHB2byiNXqH8Yynp0E57Qr15vjXG5b0sQjMbGQ0juB3Wuqyv1juSD/Sdy0GJFWAbjpU45xsPqdKTi7dxy260UlbjX6ELFJJ3rO9Yg8WyuBzENrlWW3TJpbH1aO258k1qaWe9pUHeUhq3uijgLQ+AYL4lzQXLxJrqOcwuV2CnpE+9ajdNJ0mYygU8wMKfsZBdfRzrl0jAUheUbchtzXkIWMBgU4SypriMNln0KL44ukXaWOFXkgEC3POIOqtVqVTIyrgww8rRzBVeTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXGQMNH87wIyWu8NNZq1mO1VhHN+s6MFjqExH0RjmBU=;
 b=bVpkDjhrbW0q7BplT9JIqaE75dVXun8HVlC6qQi8+Y59ht729A39equytsXqj1L3AJZlhSi0hBxvUpmR17X0l/uw7/tx+ZXr2xSPXFowwLOxDPcjxyGC0AHBP5z/0MxBFvGTgXzvvobaHl5t3iCGT/M8bieMV9Ke1BRL9gbzA1yHVztLgi1XONyIX0h3HD1qzSULmLRkJBsWUjcPTLoKlhzzHbKOXgu9A/ycEVBaSZr0ZLHsAG6/d4JXakXXphOtMGf5Ik2WDfIXmG3RWsePXcqGHdd+p6p6erPMr9mAsY7MLl0+bsha6AKp+roLbs+flw+BQ+iuO/ZZo8VVoX2tGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXGQMNH87wIyWu8NNZq1mO1VhHN+s6MFjqExH0RjmBU=;
 b=r+98M+/vhR7b4Pr7yoQYKyFxGB5qgdivNAwKSqxjxBM5zNkTwm8odEWY+Ibtw3MeEau83kka+drjW+zbh9qsUjX2w8dTbzJJ0kcHK1W9qFDfdUSF8RlLgtkhQe8Y/wIa0XR7n8rlbLDK7w4RhBPyiK9XmSjwkjmhv3fu8mCDBMMNQmeZagJC+CnRjyPmc6PmXx0RkBwZY87xvTQs/nCjmOUqdBLX6Ojf2UUAOY4wczgEWst3Qjb9DqHkpymTkXkKkMuS6cOfdKIEMfWJsy/5TAL1KkOJj+cXNANhuHLFmsKbgNvDdO64jr7RAXeMLW+73PIhuaE3lbptZ+wpv7gALQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7537.apcprd02.prod.outlook.com (2603:1096:101:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:51:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:51:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 19/20] hw/arm: versatilepb: Store boot info in the machine
 state
Date: Thu, 13 Aug 2026 23:49:07 +0800
Message-ID: <20260813154918.996812-20-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 050239ac-267c-4636-6c81-08def952b417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k7r7xxQiF1Mn2YxoFKaT6T/kD9s4YQuCozfQtEb8iKg0pWPAdMuGXqrRHUzDGMfejOzKe9Tv2lrCWW5iZhkdnsw2E+/LEUBWjyZaDOrYseh9B20iLKoV5DNDgUpRzhDIENjPup4IrROeFzJfibEQMvV7irrR2pWufDLsCWuMyt+xgpGtViMFWLrwAzoxLzV6J8IWK9iu11e3NegvtmTGRs9rcxVHq1E7v2XMeeVAgjLdBrzNrtobMxjvXS3AXnsa7y0zzOAzpUMnYL2/WXcB2ej9MOJ29DM4Cw5WaQTNivkBPsXnjZGgejv+QY/r8UT8wtj1WSy1k1TQA3m+zDwsF6fqLkJ8K90Xm5dHGHbcUqV6gg8MkZ/sfwxbL85+2eCCWpJGimO7an76kG/5stnNC84ECFqHCrwErSwNfCixJotnD2h7SiHBvPjBW3hdRkcBoaOnddFqdEDH2ARy7v20kGmpo7PLqJ9036vU8tFEsmOIYd30102ggPJBtUp51nO1RDoFGOn4nL8odeI8JEByG3Ey87WY3zM4hMnA3NPP5ln+7SfxKWDHCdYvl9Cc2EkuD4CYSUsrWRL5UzV9loQJGrQaysE+V9WrOJbQeH78jhVkMC5CqMPXEjD4C8i7qUu5OGCWSlWcWwe/5DsR+kqQfzhFt3+65TjJFrEk6gSoW3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2OneLOiYBUBxO6gAl+TKPiKMi/AzTjgpql/+9RvsRKEKdJ+T99AotwLawROP?=
 =?us-ascii?Q?fts9w+lJp6iyqvaHiQJxb3+Msj0SkLWhew8TRzYivEUYTaRJNO2+hBZ0bfUf?=
 =?us-ascii?Q?yOQ7Giju5qjLH2+Jk5dhvDok3BDmJAkZ3GNyepgWEHNn7jYFDjEkb1ICxtz7?=
 =?us-ascii?Q?S7As/vtZSXPIwKaepoT6ZFUXHuPSprj19mSDt7ZCr+wFmyHChHfCzQMc1hWi?=
 =?us-ascii?Q?yw/MprAMwQOtEZUqq/EEdDa6QH+O9qD6UOb2zpericPyFAtg0Gtclb8qYqxs?=
 =?us-ascii?Q?9HD6FEnceqnstOf6B4WxF5VU+lACMgWfIwrI66+8wxdhovow58rf21eo4ioU?=
 =?us-ascii?Q?C91tipMRivfo1sc35NJiAYtawtiMMyrKUrFJHNTpXNG7jM9nOnnHFx2SQfio?=
 =?us-ascii?Q?XA1O83z3+MJRIWDsuA4CkWW+q+JXh5Uqvw+Ug5TzKVm6+mgyiB3VClW0s6iM?=
 =?us-ascii?Q?sjjXdzMu1S2+ALnrpZpMICTqi5NnyjTwcvNdCoXFRdM8X5DI7P9iMWyQOykh?=
 =?us-ascii?Q?jwKhaxzoWJ22Wm56tJqBTTPJzwkFgGkQgN0kEoRpQG8uBXIETICXerAeHdm4?=
 =?us-ascii?Q?5h2o0qVtRxgS4iUAbeKmGIDR1FqUABWPhiVYuiwEgChP1wB3Vs7tMOKVJbxN?=
 =?us-ascii?Q?d4GZBFUMggVyBJzEziylgzi/+2cIRFnG8PlrnOU2esZY1QX2O9UUkj9b2K58?=
 =?us-ascii?Q?Mn8Ffyz+um6Fud/AnwjE00JQjwjS1lSiikbErQLKDZzZxGnNTSF0pSnFC1e9?=
 =?us-ascii?Q?H8Ch8rDTHin0T+uS4xH4XMINsttWQJdHS5F/v7jJjyvop/0Gtuk5+VVuipNO?=
 =?us-ascii?Q?R8rGuI4tb5Amag0ELPMh+d56sdw4hn8nDFix9nB2nTtNtk/eArFuxbc1S5Vs?=
 =?us-ascii?Q?ZCsIZwPbH1keJ361CfViA4daDMpnTeYP2z2E9XrMlmH1/mLJa+YP23qcz8ZJ?=
 =?us-ascii?Q?MPMkLM04oSSh8tYy2p24SqybJKwrZSdeSlby0F7Cw8/Qzm3A9eRS8kPLY9IK?=
 =?us-ascii?Q?2twfT3fPCzs53DBpCYgGAGYRJzgeM11dRFidpbPvEKE0blZvJvKElvhb0VKx?=
 =?us-ascii?Q?yuBKU+qRsj52Dnhjhqb98w65cLtGDRTPAtBp3JgnV8MEBOWa0IWut4T1KR5S?=
 =?us-ascii?Q?9tfRYdQMHi5X4Nmg3D3neqvaXmjpWDDGP3TyY0giNmaYk/7p1I2cBeJzFLTd?=
 =?us-ascii?Q?CbvWiDfsdCT1HcQNsHXlEsbh+cOftg85gzm0C0Q6XSv8x3sDdK3R4E8Ai/R0?=
 =?us-ascii?Q?eioQqRTiH0MCLHBAf1+qTRDaM83dHO/ej4nQZNR8qDwg2mFtnIL4KI6b9wm6?=
 =?us-ascii?Q?pG6P5qoW9LgQvCkm34qOYUdW+svesdLyXeuwMVGY0XQXYoyD7ix/qFIoKMxu?=
 =?us-ascii?Q?zXsFC1yKJpt/SQWJczmRC8zopM//A31zJSl0oD1tQF9b2jdkuzXXX7Rt24vg?=
 =?us-ascii?Q?AcCVRc8Xkp4Ppy40bMJITn7fCth61Hc4ektiGmZIDiUO6ZfczUheGzs8QDi8?=
 =?us-ascii?Q?UPo54ZuRQYMlIU6GgAhs07PYjImlywxB/mDZVbqvZd8QpSB5bOzu47n1Mgyk?=
 =?us-ascii?Q?a6E+uASQteSpai11qWkNl73lhQV6WOFOJduoYQi6ktZ3jnVQXOGCr0KsWwCX?=
 =?us-ascii?Q?n994M1E8d+K24Cv4MSoAC2UiOiUwn/2Smrf07PWg/I3vyZfVeDFfU63mbisq?=
 =?us-ascii?Q?IyItqrxxeAn5bWGkP+tzaxhy68ch6XYxkbHDWNeqTE99Q1X9ZTO6Ro8gXevH?=
 =?us-ascii?Q?RK3HnNW2OnZ0SUcIajgkBMEfItZOakw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050239ac-267c-4636-6c81-08def952b417
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:51:13.8293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usRXXrZSF7Hz7rtU0MnxbLgkff7MScmDSs60w3W3I0RChqTgfj60EGW7+wJ2lPgeG0Mc3JNHZyvoKR1ptyn1DqVlFPaMr3wuyAoWHMiO+dk=
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

Give both machine types the same VersatileMachineState instance struct
and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/versatilepb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c6991a52e6..520af79c80 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -182,10 +182,16 @@ static void vpb_sic_init(Object *obj)
    peripherals and expansion busses.  For now we emulate a subset of the
    PB peripherals and just change the board ID.  */
 
-static struct arm_boot_info versatile_binfo;
+typedef struct VersatileMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} VersatileMachineState;
 
 static void versatile_init(MachineState *machine, int board_id)
 {
+    /* versatilepb and versatileab embed the same state as first member */
+    VersatileMachineState *vms = (VersatileMachineState *)machine;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem = get_system_memory();
@@ -397,9 +403,9 @@ static void versatile_init(MachineState *machine, int board_id)
                           VERSATILE_FLASH_SECT_SIZE,
                           4, 0x0089, 0x0018, 0x0000, 0x0, 0);
 
-    versatile_binfo.ram_size = machine->ram_size;
-    versatile_binfo.board_id = board_id;
-    arm_load_kernel(cpu, machine, &versatile_binfo);
+    vms->bootinfo.ram_size = machine->ram_size;
+    vms->bootinfo.board_id = board_id;
+    arm_load_kernel(cpu, machine, &vms->bootinfo);
 }
 
 static void vpb_init(MachineState *machine)
@@ -431,6 +437,7 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +460,7 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.53.0


