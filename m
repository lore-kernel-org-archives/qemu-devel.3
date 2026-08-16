Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30608C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvaim-0001u7-3I; Sun, 16 Aug 2026 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiB-0001fE-NM; Sun, 16 Aug 2026 09:15:39 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvai9-0005TH-N7; Sun, 16 Aug 2026 09:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kInri7asKoMsIrIhf9cYQV3oIf7Bo2aG4g4C1EWdUOzlduzJX6JqmYaYqjG2Rzs8Stki5Cqb5LKHXwlSK8kd4MAtprWHbDg9ZaU6gpy4Dk7gJLHdDfFEFcEQPSQAWUM+tUsePD5IrHiZ6D9v0IrZsSAJwIg6dv0DjfqlKewxMO8aFhKQjKufFUUumxbMR+ppugcvbREz7oWoKGPbn7V1/XV81oXdv6rwVWYQWWYSZ5I03r6O1CcNknqjVVaXW3vn0VUCSmay1puHSuOkcX6CHPd3BGJ2z4Y6qvpIOX935XyIw1CM5Or3p78ILPq+087wZdb4iy+bN4obXW/q3YHDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj+ezSXS4YGjM4RxgWEsxxYdjUM3LHaM0ajWOkLyHwg=;
 b=ojPtZs7TPhVNWGCx9ftH4yyRO3rN4PbIbjZQJGF/9R+v/ATKn+lanxvA9SMjjTNXE31bT72vH4vkDFlE5A1ATb/AcZfyAAMamFYoMLJ2D41s1+J4rDAxUa5/VCUqlePmrTD2w5wpJgb/XhqmY+1qHGNQfFeoQ9+iknhxMIwSH+5LyaF1LcTRcOpTjTUuD8cqoOSCBEo1PjLGM/p6mhCcfvNe5nVtvGxMER9LptB6zwOI23RgN+g4Rc4oRLXxG3zNs31y2OMxaw/+7gI0pJfKCCyLb4641EKbB5URpk9wZJvFBjSAPO14hmH3Tv2fjweR760bX2ipnqjSIL+KvtfEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj+ezSXS4YGjM4RxgWEsxxYdjUM3LHaM0ajWOkLyHwg=;
 b=IfWuoDuNt6R+19jtnRWn1t4Yf/TwLUFdHWId31Xd9PwDwPkfv6bJUHvYtMLqlEB+DN2SB+uresKjTmYCEpJbgjDyQZmAZjf3dneSUh4Z8WAIHFSiZy0I4K5SafDb0hsjwW05oyBSTmmMQ/UoEwx8HJNhuO6YykobtmkLgkPEH0mm9cNdpU0AtVd2rEP2YzXgD+RNID8BsuQnfewwkrA5bo6oyNqbh5jWdqnwArwe5kP1Hs6J+W51Qkx+x9hA64V63KBlvVaH/ReYn40Cgk26cWiOJ0zx6o2ak8Dn8c7yOalgZ10fNGZ7lLOkBTtmtRItbZxSAFWY0lN1rTxz5zgrOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:31 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 13/20] hw/arm: npcm7xx: Store boot info in the machine state
Date: Sun, 16 Aug 2026 21:12:43 +0800
Message-ID: <20260816131300.51799-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2af66055-e2d6-4173-0162-08defb9872e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UlQAcyRyoh1mpMz9/6NePM0i3Ix0yrh/sRkdJZtDmCerFm3aVyP/an9KV+I+tfAo4pmN3D+D2EykcxsXOM7X+ZS/YVolMxI+hSmaZzj8GoU4iNRGeuMy2Wzyy5tr3ChdKyt6NQjEIaUD+qMUj1of4jMNYluYbmeVzq13lr5ohXx+n5RO2lk4EdxPXnXrtk9z2r8SUvGt55YjsDw/jGax4ZSsYS5kazL7xP0QqdOdoFpL+KwvGA/KZ2H6T5Bj+Ta0llOSP43qvm/ktAOjVgEyC1vZq9JN/ElT63AOuxX1c/l48N+QalS1l7SKflg97qLWh+Ocu7yobh8Qu9HmzkMR1KDxSY41lvrfE++dVPBT50U0kfhetUsHTdiDYABvsvr8HZ/nzIFxZaoHUgEuefRgPRspZBMeocZ2WVmb3tuW0mPjveEjax4M+4DHZZIYD4Ognm8pinwkM/oNIktU/d8kO5QkdNazRGmLzolI4PeWGjHKzhX0khXMFrh6P5j7cAnN5hP6E+eh3eKI9/dz2ZlHlFN1dkuERLYyphyHml9cceMy9H1LLvBDBcBR7dpK3HL06aQQjdpgzq1Cc8E27GAxyELE1wH2Z6CPfGoFpV9ZkSuftPMhH6WB2SiTl8ps0L//7wcB+LGiFDF5s6R/v2w7AS83uyJeYUG2Fm4mq+agAi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozGMk0yvC6wGXEIlBvk1oh5CVxB09xX+AMBcpZN28ITcC4yUWcu4hlVnd+YV?=
 =?us-ascii?Q?HEgL8iiB5/gWAkGuhzeozmijCBUnri5lIj361mEJzXh/TpNrODi4T4y4c4ZT?=
 =?us-ascii?Q?yMSembUgaaWUA8NBKjvhBUDQAaKFFFrJ1dkgVNm13SEnq/3NECt6bqtKfr5i?=
 =?us-ascii?Q?iRld4o/Rc5Nl6Gsw+/JltlQrQH7EzVxiArwegeKnkz+gSix9mo5RKPVxD5aH?=
 =?us-ascii?Q?hkWYUaCzuY6BQSAZ4OVFK2aaudRbIa9l/ogVK8dSe7o9ytT3FlOK3lTkHJbL?=
 =?us-ascii?Q?R0qmJ7edV58bI28Ds5EdUDKnrZza6MasOuLvJHhOs2FJk/cQLGVuB14+jqYK?=
 =?us-ascii?Q?IAL7u9RKpa3cLng9cY90Mru8hS3EqJRS9pZ952T1vRu1PCY3BVNlEDILHy2A?=
 =?us-ascii?Q?jb9EHofPePNr/qB379PIsAeQspM6mwDSAeXriTpyIozFjbk2mj++gQETqdsO?=
 =?us-ascii?Q?833mdy/yAp42DUfB/23+vrBDqUYQB6B/kXmqoCQjJyqZz0gwzRnwGJgpw5pm?=
 =?us-ascii?Q?aTOLvJgDyXcEYSRio9ggPwYyyBbN9neMGO6dX99vm826OnacG8qYIr60/IfY?=
 =?us-ascii?Q?e9d1AeztWWAkOWcQycL7gxp5h5TSziuNTbSgI1S3k0n78tkDLYM4ZLAdUNJP?=
 =?us-ascii?Q?vwwp4LRio7YrQTVSgzF9PGApHNdGIA/6xoy4Jqg45IaoNjk0ldi/5sfME4tP?=
 =?us-ascii?Q?dB6F6mY0czf6FzcAzZyProGxPjz+HLF5ZwILMIgsoQiFQ3kpivfIvEoY0Mel?=
 =?us-ascii?Q?H2db/ailWTDkYSTnYO2ItpCXR8cHtbnhuFaQYxAFFI8p3PJZfvvrpAhcb3oE?=
 =?us-ascii?Q?qqCjAdw+0GSpofEV+YnLxVmUy96I1XVj6AFflw9Szi6OnC8tJR1TWnhIW+PY?=
 =?us-ascii?Q?scp4jPlh6BwlkPqEPAOD0RSqCGS7f7AtnfCArqXo+WEyUWJtxiX8O+muTOoM?=
 =?us-ascii?Q?aK4/9Uc7KS4ORfw36IjktmKqRhLoU9qJaQfp5RlgI1kDzF1g5y7EQ5Ajwm/8?=
 =?us-ascii?Q?wS9FzBU6D5DXIukGeNaJUauUaROhcme2cXn7LWlc+Daj8V2dV3V++qR0lcfK?=
 =?us-ascii?Q?wNtGJeWXhiZkmP5N7SRrA+AAU6T59TqvOIoPhh6b+YoJJ39sB6o4Be0TK6E1?=
 =?us-ascii?Q?IVzCU5MQtymKU84RSh0Syw5qcRLqwjwDLKov4Jt62MzXos1PbMrlxDhbKHTm?=
 =?us-ascii?Q?96ZquYixqD4diKQS2RXk/NZX9LtWwnHj4hS6dR3Zonopq3fLLdRw4i3+N+o8?=
 =?us-ascii?Q?tk1SmAGgWQZiS7aEyGcfW0wqJLTHNsjncGcpnN5I0Q4S2wtMpPIHHLRzMDwO?=
 =?us-ascii?Q?OWjGof1JQlMzXm2OS+pcrGp1FNS4Ba4r7XiCPuV/K7z1RwEApuoOgig2r3rj?=
 =?us-ascii?Q?yC0WL4KBEppUOZe/iADa+8AMWFzByVkG0yLPQ+TiSAN1JlaFBo27iG7JzBzP?=
 =?us-ascii?Q?i3xitp/X48sIjFq7uV87/nTuk9eLA9edTZGd5L2mn6olpJKSA6e+UHY15CFW?=
 =?us-ascii?Q?A9Cprj5mstH8Zv4hr1yKAYNBJmKzwoZntS79aiOzCdLiz2yYC8ONt9ojvTNA?=
 =?us-ascii?Q?n7vknR0weANC3mnWwENBfsiZkOvaurfCrYypTqeGAZjAfpnN5jIbbA0gbkmj?=
 =?us-ascii?Q?Y3074h83OH4mQNSSbRxd9aNhtSOpzLdhCCw9sUzWGJXjCGXiRNtw53AIq0oh?=
 =?us-ascii?Q?YL+SOZqQxGuHUDDsRqRdCKtPpzhqvbv7iWS2a8l2zacgxd6Ts0Y8nPZJH13G?=
 =?us-ascii?Q?OL8j24fuLF0VZdQI2ARIfQJKKdUGI8M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af66055-e2d6-4173-0162-08defb9872e5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:31.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHlrmXJpLwPhp6A6WVXgsAHoXvMsSE7EAKDhg+DexDm/FG2M/S2iQk74QM3nhd3j2xomiMsuKSETKG9zflwTzKjS4nngr+oxoO+uh5pmPrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
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

 hw/arm/npcm7xx.c         | 28 +++++++++++++---------------
 hw/arm/npcm7xx_boards.c  | 10 +++++-----
 include/hw/arm/npcm7xx.h | 10 ++++++++--
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c27f149c04..695f30a0dc 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -364,22 +364,20 @@ static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
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
-
-    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
+    binfo->loader_start = NPCM7XX_LOADER_START;
+    binfo->smp_loader_start = NPCM7XX_SMP_LOADER_START;
+    binfo->smp_bootreg_addr = NPCM7XX_SMP_BOOTREG_ADDR;
+    binfo->gic_cpu_if_addr = NPCM7XX_GIC_CPU_IF_ADDR;
+    binfo->write_secondary_boot = npcm7xx_write_secondary_boot;
+    binfo->board_id = -1;
+    binfo->board_setup_addr = NPCM7XX_BOARD_SETUP_ADDR;
+    binfo->write_board_setup = npcm7xx_write_board_setup;
+    binfo->ram_size = machine->ram_size;
+
+    arm_load_kernel(&soc->cpu[0], machine, binfo);
 }
 
 static void npcm7xx_init_fuses(NPCM7xxState *s)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e..4f14d25746 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -374,7 +374,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm750_evb_i2c_init(soc);
     npcm750_evb_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gsj_init(MachineState *machine)
@@ -390,7 +390,7 @@ static void quanta_gsj_init(MachineState *machine)
                           drive_get(IF_MTD, 0, 0));
     quanta_gsj_i2c_init(soc);
     quanta_gsj_fan_init(NPCM7XX_MACHINE(machine), soc);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void quanta_gbs_init(MachineState *machine)
@@ -408,7 +408,7 @@ static void quanta_gbs_init(MachineState *machine)
 
     quanta_gbs_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void kudo_bmc_init(MachineState *machine)
@@ -427,7 +427,7 @@ static void kudo_bmc_init(MachineState *machine)
 
     kudo_bmc_i2c_init(soc);
     sdhci_attach_drive(&soc->mmc.sdhci, 0);
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
 }
 
 static void mori_bmc_init(MachineState *machine)
@@ -442,7 +442,7 @@ static void mori_bmc_init(MachineState *machine)
     npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
-    npcm7xx_load_kernel(machine, soc);
+    npcm7xx_load_kernel(machine, soc, &NPCM7XX_MACHINE(machine)->bootinfo);
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


