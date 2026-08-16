Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB23AC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvain-0001yk-IX; Sun, 16 Aug 2026 09:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiH-0001iR-92; Sun, 16 Aug 2026 09:15:56 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvaiE-0005Xo-Sq; Sun, 16 Aug 2026 09:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypakrBAJrXrc8E/0LU/GBwamo96SkuxL4h2eluQRCaUO2zpbm7/tzWWVhn0YC3rfQaqadYkM1fAHU4pNVkA3Yw9uoruwtYlUVJsbtJ5EwOJvCK6YqPV/UJ0x8QT7gpdy2QZdfhQPSTAdHI+yYY4B7u7DDmSzUIfC5Nzv8xd/DOsRH724G2zqosQEReRCTwiO+wMHxONOWJKnZrZwtav9D9lFJ8iV9gyYxpxdtHC0el5XItIWF7EVNYaNG6qPu+JpLM/KcbGm5KQzGw3dzIyEVy73ATBsccg5zJwKt8r/KcyQyyA3QjXRJ7NCeeXwHk4H7iqK2duZP6gOknX9sOAU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPkr6tpD7AlZEO44/XwJWgn1tiQYj1wDt2vnAKcigv0=;
 b=g/FyxNEW8oxAaguh+6Ckv/Q1Vno4sZfi7Q5ZWbWr1jdMB1W6Swk5F95Xgd4KbOXNFku+nb7ZHJVL6AKvxfNqlSQPNTK4T8okdcVjxVogBDzkpwKqq04TQxwyyCBmbJyWsuLcDTLTLtDfmipCuo2torTmO2MW9u0wDimmmj138cVhuVo6qKMkIG4Wlh3BLynUz3nj9HmeyU3c8HnEb3UgvQNHKTEXlBpQcgjX0zVt1xeQIkFG9JwaMtTwprntxJs+/r+xJ2UWE1xcTzSivT/I36KNmOYiWt+wHIpLWb7mpsBoR0CFVig8roOns5UMHxjFN0C7q5AhbXu8tSilv/KvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPkr6tpD7AlZEO44/XwJWgn1tiQYj1wDt2vnAKcigv0=;
 b=dfRvuB3JU8dv0+LhdjNn69MrXvDzC4bfRUTRvRzN/2K812azPihtSle7hK4t2wo2PO6pN+31hgN0DBS4N5SCndCXbO+t6KoN02WCtT5b15Aqn4M4iJAk5nnRGTIUKauMMp8A2xu46Ang2QM0EDezvkf86XBn6O9g0A/htcHqDWhVDDePw2p58cJxyMspBw/aoQDSumhf0Sfl2F/mnZhtdAoFd7wdzR4WBSBe0aLI5GUi/9l9zrjQuUNnOqjQz94gklZg+Z34F2wFQSY2clG3s6cZkvHAP9c7RmNQcYQ4mwhUic/Aqx/shsETPe8HHqFi82gj8xhGhJN70Srv1hhEjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB5475.apcprd02.prod.outlook.com (2603:1096:400:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:37 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 16/20] hw/arm: orangepi: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:46 +0800
Message-ID: <20260816131300.51799-17-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdad06a-596e-418c-9f5f-08defb987642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: flTXGueNTXhNx0mzyAghz9yagQQ/llNqTcbjw4DkW3jZvKRk+uPUaxgRuZ9u3VX/id/X45UWKi/7L53Ga8CX8q5ti3UAwMuRT0J716p6pE7qqVno/tr282ESS570emGiK2Y+9rD02ZS3IA5mlcXU8YEzbgxa+7wq2F2zM5Dpuuj1lSAziGqu+s4fXASROcT1vhcA7E7j91kXi2ZEa5jOHKjx717XelQOD5wZ9ICNEqrpPmL/xVSBuccdc4EABEsWU5aBCRLseGFWlUxe+3bqJBQgywYQoKaYbN3f0Z4i7871pR3et4n5mXS4HYZ38wNWITMljIzeIdTpVuEu9/yto69K/lNuZ1hFN5JeGEPIAT8Jj3eD7MIBCbPoMRuP3P7tVjCaFXAFLkFaKo5TXQZ2ULA2XLmFnMTSDQ/oZix3jEj+L+DcEgctEIRuq1TpPrGq7t+Scxg8RpicwwII05CSbzW4MxedUsCHXOqXgpkLQuvk+SJHvZrloVsesAEv0t9O4CShKOiPIW4ObMie39NlWwej/lrHooPSJrvHGzACMd/bSoDSm1X8gPBeeTdEaqFTigc0CgsrqNsgcgPXbjV/UzAL24VjJHvJksCc70usm1FU8J4yfH7zFpNEgwWpD4zsWBWBibB48aKuS3yaBNEOz6GaJBeHlHLpZcccLqG83xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWvcKd0MW0dnLGmYdj6T7gq1t6duWd5iJxJIS3WL6ktfVUQDMuPfksdvALu6?=
 =?us-ascii?Q?wR60osKlfdmV9V98fdTR0H93XW1ge27Um6W5RyZUs3A5MXTek5mTveHr+Bmc?=
 =?us-ascii?Q?JlkgxjHEpH3ujgJ8qYCwnnKZqnxjCc2tn4NP0kgugQNHMBguM8uBOfIFKPuE?=
 =?us-ascii?Q?WwModM8orizUXAXywR1UbEH+sXnPezN/niHy6gw4VMYQOfhyGO7jWVMxVHQ5?=
 =?us-ascii?Q?UyAwWHjgviWK5JGHfqw5EEZIhbmDMq59WifIfF8xPQigz8la+ekPUDRCI9Ma?=
 =?us-ascii?Q?M89OkOd4GUrAU9FSg5kbt//JOudJm2corRWsZQNmh54VwVtl73o/JcAIkDPc?=
 =?us-ascii?Q?1JIc0fd7Ax95R0FA1KTuSq8/YAeDwCSRJWAVzhQHMVuRAbdMVOBHvIV2upBc?=
 =?us-ascii?Q?DkUjh9ojYhYKDqsOiQOMzXlhDnNIrL2J1BdFjrTpyVcw9+Pja3JqP4Ydrjp5?=
 =?us-ascii?Q?kRPBsi2wgFbIL6SuxVpDgCDpTURofyLngxRjePTh6x2jYrAODHxvH+GeLtQn?=
 =?us-ascii?Q?Jd3JO/8Uim5ZiFi2KxV8XLVj9IyD+s1gL3I/OGgcC4G95TUHfmhZ2cquTJYG?=
 =?us-ascii?Q?S0KnW0Cg5emQDRyuBALKQ6/Szq6EPAXIw+vG/Ev0TWoVbcRRN4NclZrxqlfO?=
 =?us-ascii?Q?IYaq5IHUM856MydM9eKrFdZ7WVUwyzo+qtCDVYHecHt7Dp/za3PcyZ2agfZX?=
 =?us-ascii?Q?33hGfN/E8C64/17ayYaWXFA6z3QhyPoPCvftT/Qbn7gjdoR5OK4czi6UHGxa?=
 =?us-ascii?Q?WiMyMTM09XRCPv5HQ+OuXAwGPQsQBThgxuhNh6VMWsMSpQdkq6SFb8e/cR1/?=
 =?us-ascii?Q?bnP5q72zUoefAWnFzu3iAmSw5bqhJ40BrzywpQ9TLXy/C1WsHl2SHRbnsS6b?=
 =?us-ascii?Q?vmCpEuuT5B5zK3i/B9jUzo/f1GgqloAfrs2ScDlV5BnLnc4IqJJPXHquAgKL?=
 =?us-ascii?Q?e52ouOYVxiLHqYPgHRNumeWqFz7tiOcI8tNrvbV1bpf8BeXQHHOyHd2p1vu3?=
 =?us-ascii?Q?V3V+8ig0HuhHtvlQ4s7jFOrPVUYAFpBIl+RLMyPja419jlverc3jQnOym0KV?=
 =?us-ascii?Q?HOkfgXajrFQZdfbDikdYdPfMW3xWBOQN2EWUy8HocypTtHFFJ3JMYj64z+M2?=
 =?us-ascii?Q?DgXHw4rhUCHexgF28oxRmTVJRW+atOELx6ntBJiL6hRZW/2AIu3AsTAJOByw?=
 =?us-ascii?Q?Bb4DttRpYSvGyEn/PfIZCMHhyanSeNbBNyY+v+yACuRlnCvGZNIqqj4VrIyp?=
 =?us-ascii?Q?wGshCtm4fmHR/I7AlMuoWTRSWMwqBNxmosE8gSw7t0H7L6oeOT7DDV15QPYA?=
 =?us-ascii?Q?aIL0F1XAeN4l41veyVlFETyN5cVDO88WCoV01xzPrPb2d3aWe591DPQ53QFi?=
 =?us-ascii?Q?M4LXnK0Onwx6kv+QEanYeRAAF1sjS50U7xKKtMP/2F8ya8e5+x10FrB3bfhu?=
 =?us-ascii?Q?c0tV3SAglSkBLjQv4yYXyWLxE7sxKxV7t1eEENF9SgtGx01dsizZxSd/FYmN?=
 =?us-ascii?Q?CECStC7abwi+gmpx+paTmUtzkmx4PFYh1tFZw4Wuy3fGUREF9e638wZ8RT5/?=
 =?us-ascii?Q?qgeAignM+oZ/4ZPk2rBULkdW1lsSxw1EaC28Hc6L08Z0MkF9AEf1IN7Gx183?=
 =?us-ascii?Q?dXhSQF4htvnVBDlCaeMzLI8zGqfqQpUysqYiXeWAdPVNTnbC9aCmRJlvmtSB?=
 =?us-ascii?Q?pDXM4HP2oUQw4Xef7XwU5Ig6WqIbKhFm9AMKJHwRcw7NmWrDzfnoJDyl9u5u?=
 =?us-ascii?Q?Ve71dvxB+Kbg/JXcGZbAx23Ex3fVKlU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdad06a-596e-418c-9f5f-08defb987642
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:37.2332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pcu1oi29v4Fqh81D5G7+eh2Tqfa99Ems8pWF9Z0lvWsZPcPh0aUQW2qmnjACoW1Mf41CK76OHnd5RE74RAyWnOThmuFsj8B1O7m/UfgqXrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5475
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move it into a new OrangePiMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---

 hw/arm/orangepi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d84443bb7b..0e149ed6c9 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -28,10 +28,18 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 
-static struct arm_boot_info orangepi_binfo;
+#define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
+OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
+
+struct OrangePiMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
 
 static void orangepi_init(MachineState *machine)
 {
+    OrangePiMachineState *opms = ORANGEPI_MACHINE(machine);
     AwH3State *h3;
     DriveInfo *di;
     BlockBackend *blk;
@@ -98,10 +106,10 @@ static void orangepi_init(MachineState *machine)
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-    orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
-    orangepi_binfo.ram_size = machine->ram_size;
-    orangepi_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
+    opms->bootinfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
+    opms->bootinfo.ram_size = machine->ram_size;
+    opms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
 }
 
 static void orangepi_machine_init(MachineClass *mc)
@@ -125,4 +133,6 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
+DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
+                        orangepi_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.53.0


