Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C543CC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnlH-0008QJ-K7; Tue, 13 Oct 2026 21:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjr-0005tp-2x; Tue, 13 Oct 2026 21:25:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjo-0006vY-G7; Tue, 13 Oct 2026 21:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b07t9oZou7Ft64poqTtGsymwxtEPRZLcRSXx7+6pjirUhlPhroGH/SF6kDm8thMvuc+dGNiTB+7kcHwK1CrbVH4Q1V4nR+J7tmpVlyL9c5QLsF0YbSloqU9Vj4kDnJ6n1EX8hFN24ZyYBZxDqZZ0bTW79PZMRrr10oKCwpeF8QFqQkq9rFyCwLXh3n25R0B5mgOyEeOY/3fcrmzzyISiV8ic4NDD6NH3cETckuGDLbxcg/9aSsXqwgFTr62+9uQabcSWrFciDJ42it6XcQ5t0DeNfGlmo2anJz9JX/LpyYZI+GBxc7IX+sd+K0nCf2ZrJqiyOYJxTET9VtlzSun3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vILELYVCnl1j630SPRp0gvHDgrvWkWwPsbitr5QGU5M=;
 b=qA+7TNEm9Oo2n264pGV9kCa7a9xr9iQlLC8OtnqwZ6wVQQTLXf5NsRrjjGL3NS/NqNS/+2KyBu/s42bY4IBkF9mkQbVqLDS3IKFs+c5eFD+a/ETSbcMJRjGIlxvNszyjHcgjFTvboIWKhqgC6esNTQRv6mKfOnZFEqfC9qJA0uHRBGOfykG6n8ViQ6h/evtx+5ccH2YdfNiSAu8iEGsE0ig1k9octv5fpgx2NAWupR/08FsY9bIkUNyGEsyg61zO2qY94PQ/O1NkoiKnztqigrSNkvctSBRiCZdFRFwHd0LYznh61uf9udiRi5NES/VkCzstG3g2sfQLfWxz0Zk2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vILELYVCnl1j630SPRp0gvHDgrvWkWwPsbitr5QGU5M=;
 b=blml/6sYiLDrS4GsN0L8UmmO8KU/mPhMkaV8fj8A0uBf7m4WwJGTXSY7q6e7uCOYJdSrK+HFdwVkIDAMxoK4vygQnfhjcmNeXRwvqGgiB5EqSQhqvxaBGg6gT7IdpD2PtPgcyv7jH5wIXOtEuj5/5t9lKPo0AKEJm7P0k/siTgLfga0TOTwrVUEccOdtOcoFXANCeFrCnXy+GpT6mZEGblevpXD1KiVAUwaZjQWOV5iW+pltYAAjpO1tcCsziFq7FELo6JPXuQwCINi+HmrpxyRix0UzRnN6854Mf2mbL/I4jqddWDu8itgC7jJdeNBLAiQfsrlZx2uaEEkORm44+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:42 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 20/27] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Date: Wed, 14 Oct 2026 09:23:00 +0800
Message-ID: <20261014012323.322790-21-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f870e4-f5e2-427c-80c2-08df2991eb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: pRAVEmmZGREqySPnzLBH1jZlZjCTRX9XVlyXGj/my9LOytyqSonx2F5zssDRPkevXebnw7FdnI54442Ui2GWVLMpeIMuxJS8iG7IA7P3QEL1MIq4KnudVOU//rbNYm/J8IHwhHKqWZxjbdKUqS1d1mjhapweQ65sUZ5FKk0CHmzXSS8sIc4Bh2oY0BPiS2FaHIv5+sWY41gLra7q0cIpfowpAbutm+hqk50CuLQy/rP79TvBJ5o4mvlnCs1BFRA04hLxl48dFUYPwpV6KZZofTue7S43SDP+hR2IF5i/yIxpMTXX8pyQgoPtDaPpsCZwvtkBCCUKqkQf2qeJOv6QzI7R40wBulP0X6Mma4A9rQdgucUr/ITn/Bt745UPsI5cDY+kdjYSp67CLzFkH95zIwue52ZQJP3EyyXTIw4kqXIMbLFpyd9RCB3jGoSZEOo925DilijHrrxtmRuouStWue32e7fZRadnxcB6fEIiUVz5NrBJI93OsMyAWKMWahZ4u0O4giRGfAauwENXtPnwfC3RhvZICTC9ixbyS4h3Ii+3sxxAdY1KsfUp+eegLYCWWSYnfTsBGETKM2+oFcmr4ZvBboB+GKngVHiAWqi2WwA4ApCPof1LXNbTHILkmMyqz7eoy7b+DJbxhelQuJ6DJxdIl/2kp3l6+y52pHYa/9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijtqktSCUN23U1gBDIaKmv0j9YmoicBlU9EQiiNcGZ0Tk81zSEe/UXXoCELe?=
 =?us-ascii?Q?YtdrYpNzDKq2GlW00XDoSAIwF2NXZvAyo8Qxl/jSaFlgP/3+9S6XZVmNQuUA?=
 =?us-ascii?Q?Qwing90sGr7fKYscsGg77fetAwP+Irvlfo6FR/xT2YgO+CYvuAIItjvG1r6L?=
 =?us-ascii?Q?a9pNcHZWASQnpsBcDZm/ZyhpCZZ+6hDy5aOfvTW8c49sFTuSYqE/jgK3I28I?=
 =?us-ascii?Q?QdFoAvmSWEzXRbzpjLcgY/x6P+BhP5twjVGj7IuDp0WlB8nZ0dRQHg3EV7vQ?=
 =?us-ascii?Q?25c9UQKJc7IuldTTxjIvAPeLYbNcSqtCxxfFu9/2Z+Uj2+qyU7nsKxfG3hUO?=
 =?us-ascii?Q?/TW1pmVACz0gwwaUXeLVhT5ZDEAnLcW+hgjMyLjXm6uvQOc0srteN81YEmul?=
 =?us-ascii?Q?oBQ+5cRhCQcXRmDk/BFFOumlVsE4XzqLXNPhztVsRG1M0j+Iqf3cP49052ED?=
 =?us-ascii?Q?mVvuB/4Nk4WP7QkbMPrEy/+73NudBugBPU3I1FSCHpG95vYIdXKWVLpQ0Xye?=
 =?us-ascii?Q?O3RjO+xZjq/ISKcgj3YebP6+55pqlzy96K9hqu2X/ZSPRI6sAnjsTSWxZZc9?=
 =?us-ascii?Q?fUC0KMUmMYMOOV9oHO54pOvNHDHFcw5yUvceyAwDMyyEMox6vZr/WkdZ5k4K?=
 =?us-ascii?Q?WwNboqFvxKWRhdm1WN3XlQ34XjpCTyWnCBFETCxxRjmRJ9NdP4tNMXzmlvLr?=
 =?us-ascii?Q?JTfoEvf3MdfN8k5YeIOfo7LWc93bJFPXFeTc16/xlT/v3VMN4XbV2SZHy/Kw?=
 =?us-ascii?Q?0q4Znz2FZnyAJNgOw7EV0nxCumN0xqmVd8OfI/2mv6GXgOghgZg/BucUUjIB?=
 =?us-ascii?Q?BcRkwiTWPL0ModAMmuzMLMDosNAGzZE95B0rGsZUm/cSrZt+UunGekdsvWWf?=
 =?us-ascii?Q?osA5s3MIxPcnngpxJ++VhS/6y2o7HwC7JUIwOlowWxqv5BHW7I37ybLHqFxP?=
 =?us-ascii?Q?zfR4zPSgg+jz7/Yh5Kqb5I0Sjp+Qcll8MrqXLnmNiMWFBlybPEGlYgu9Ux6p?=
 =?us-ascii?Q?2SLix1QBatX5juy/vg0IgU+BhQgIN3OIofOnIsG0udlVCtJATQqLFjHra8Jb?=
 =?us-ascii?Q?B32Xv7J3qtAXiHgaoHdomaV8K4d7hqaLM5KIEHBOACqwJeIdni++feJvEcNL?=
 =?us-ascii?Q?6lL3kN84ra8uZMKL35bWCIWyKs9yMdm3aX4PGnVtyTzSzSJwP2wWO5PxB0w4?=
 =?us-ascii?Q?Bo8MJB198V/jkSWhyczSt80ZhAgfFmnRsfHbSx+SEqwuFG1B3GfI9V5W1g5V?=
 =?us-ascii?Q?tZCWVv4Vs/QPL6KJrPiTRPxYpG0ATNRkcMIpsPuyy/jjKCDfchoUyJx2TNBR?=
 =?us-ascii?Q?VQtf4xPG4+mii2wuF+bPluaVxTHddVKsx3WHA2gRB6whd8vC1KlozkwwuevP?=
 =?us-ascii?Q?HMl4qK9zdmhbakKgZAz/89U2XM4RQbqkSr21fGYd88jMo8ZC3c1pJX0wy+Uj?=
 =?us-ascii?Q?kJ71xGQOqo86efdmI3uZ8Jzd7mVgVrdaK0ny44Je/1UdSuLZu+vKmh/cCpRP?=
 =?us-ascii?Q?o96u4LqL/yuDCxI6QC2vMUl0eW+NzgtQdz6e84vr24u9So9SHZURtV6ZsjSc?=
 =?us-ascii?Q?KX5DhvkwwCjz/YJXKQLU1Yk7pGI2nNfycve6sVqgO3VnLGAoKpevzqIgM2cR?=
 =?us-ascii?Q?Dl61PU8EvM8P/uyT04OA/pLscn8G62H0s1K3L5cjANaIK2AFs6cYRyIEZvWJ?=
 =?us-ascii?Q?Nn8jBtKGD1uHfpzZhr96NLsPlKB9H09BRHmz1PA0xVcgN7xkwQiSVU9UpT9t?=
 =?us-ascii?Q?dqMQ7yHrBo/gGn+eDAJMHQEaqUXaZBw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f870e4-f5e2-427c-80c2-08df2991eb71
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:40.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMsMBCoYj7//I/NgQaymeVT4udNpw//BZKot4nDqF/Dt450DwWm9Mvj/d38knA5mtGQiPug7QtvUND6/u9NENU6AUhNfVRElBdTCLiAMuoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

The Icicle Kit reference design maps the 32-bit cached and non-cached
windows and both 64-bit windows to the same physical DDR from offset
zero. The MSS Configurator User Guide describes configurable physical
DDR offsets, so other FPGA designs can instead arrange these regions
sequentially when their device trees describe that layout.

QEMU models the reference design used by the tested HSS and Linux
images. Treating the high windows as only the portion above 1 GiB
leaves their valid memory nodes unbacked with the board's 2 GiB of DDR.
Map both high windows over the full machine RAM and qualify the source
comment to describe this reference-design configuration.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Update commit message to mention the DDR aliases is modeled following
  the Icicle Kit reference design

 hw/riscv/microchip_pfsoc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 38f4e7d799..eea2895a0a 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -554,15 +554,29 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                             TYPE_MICROCHIP_PFSOC);
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
-    /* Split RAM into low and high regions using aliases to machine->ram */
+    /*
+     * Model the Icicle Kit reference design, whose four CPU-visible windows
+     * alias the same physical DDR from offset zero. With 2 GiB of DDR, they
+     * map as follows:
+     *
+     * CPU address     Attribute           Visible size   DDR range
+     * 0x0080000000    32-bit cached       1 GiB          [0, 1 GiB)
+     * 0x00c0000000    32-bit non-cached   1 GiB          [0, 1 GiB)
+     * 0x1000000000    64-bit cached       2 GiB          [0, 2 GiB)
+     * 0x1400000000    64-bit non-cached   2 GiB          [0, 2 GiB)
+     *
+     * "Low" and "high" describe the CPU address windows, not the lower and
+     * upper portions of physical DDR. Other FPGA designs can configure
+     * different physical offsets through the MSS segmentation registers.
+     */
     mem_low_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
-    mem_high_size = machine->ram_size - mem_low_size;
+    mem_high_size = machine->ram_size;
     memory_region_init_alias(mem_low, NULL,
                              "microchip.icicle.kit.ram_low", machine->ram,
                              0, mem_low_size);
     memory_region_init_alias(mem_high, NULL,
                              "microchip.icicle.kit.ram_high", machine->ram,
-                             mem_low_size, mem_high_size);
+                             0, mem_high_size);
 
     /* Register RAM */
     memory_region_add_subregion(system_memory,
-- 
2.53.0


