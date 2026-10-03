Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B579CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD38y-0007AF-O1; Sat, 03 Oct 2026 13:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38q-00077T-MU; Sat, 03 Oct 2026 13:03:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD38o-00075o-SV; Sat, 03 Oct 2026 13:03:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ/S9txC2GKGLTWIAfB2tWkO2JHRau0YxXGm5d39zsIOHUvJq4i0IH4aaWgKGkXka4tOu3jSu7sWfQhams6cbJTzDnGcQzIVZZufRE4bLH9ujZ3pPF50aj8jaQeu88BIZc96mq0IorZ8up6IYmyrRosDOaiuL9h0eTO27Caf45fDTzqKqNsSoKc1O4gfamQ/Q0u0fdEHtxIq7of3ncojHK0KPRJFf7OxZ+/QItnoqJ/Kuk7pcD9q8eWfg56ZQVj3nn9BgIgDa00zFwfZfcIoQFkEZ2ORFxkcbFih1Egm7h4oteqntZMbDOAlqevsXqvGBTkRpHsf726UjUQVghjF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AboAVU8aqSSz3t/m24beydHb35iJAv+KSTRMRMyMkA=;
 b=u5ohaUwfYLyUGS5icuE6uH+sRV3scDZ7HG5VifuZkUaAO+6PKbAXqyqSIuRbYt80EbMgQFqvO/E1935FUyydpppW7f6H4QSqwasaApWPNjFJ6ihgaou1a49NK/oPSINYrWnD/4fO0RJgk0ytGFLSFaRAQ9pTHTT+BUpD9Po1rhsgW2TPCrxCnz1PvaUd5FiKs65RyTl2SKGWw0t4UBOZaoGLVLmdT48SqKEy1Dwqmvg/8QpWMcMJRlOATBXM5Ka0t7QR07cHu/mVVORZK+VMWNeBZwrTr4E+cVoSid1N4gdO17TmfhdspONSl7A+f7hio/F77vHp0/fwwn+qKz9wCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AboAVU8aqSSz3t/m24beydHb35iJAv+KSTRMRMyMkA=;
 b=bMma53am+jBJ7F8xDLz7Chn31B3b9r4N4S9n2LSk+27LLzQPn62vaMioD5gMKOw19ECPuvzR0sMK6oYsnpoEj8EtEOou3MfS0ndy5onLnw6rBsNekKvrxIrM0+9bjVKfK0Wrx59G8dyGDBX4rdYJ22fWjq0D6p7zHDdZI5nwVsaA+Z6kznFlRJkalQOT2CnG+RzduQzZO5J+zzb1NYOOOwOLQc1Yb81bMIpf4cfBNH5sH6ChkYokLHp0UIlb8W/NRdJEC4aGzGU19fDS/s5Xrij8/Dnk4RDHFnIuI6Sy2kqti2yTkoDAY/4FePXaQZY8VJ4ZZl63glcp4M0Ri834lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:07 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 05/27] hw/riscv: pfsoc: Map the SiFive L2CC memory windows
Date: Sun,  4 Oct 2026 01:01:55 +0800
Message-ID: <20261003170232.2450916-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: e37dfaaa-9c25-448f-0cb0-08df2170325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 3QhPpIrtH9R2osEzIsXg3nl7AifuQTw3/5kGXKrJsY2jQzg0dmjDt9XjBKcbXENN97F0mqUXzJZSmmNsothPQSBlEFGjUdPydDqxskY8uqxni8U3tgGTAjPH6eyuzZuA5hA9I5ZMLliUzpB6HsbqFp0C4XsROZnAIjRxSu0FuLNGOQIZ2NucUx/wvXFoT7yzDHExkhq6s5d9BF78DdrxALP2iQEshlzt4ySNYSuy8PdJemg7lDQKFm1a7cDRq6Xr2z7Zmhqsqwdkfs2gfTbw04on7ocETD3wvVUsNcT9t6x5LTyCNeWnAtVv358qtbswWoguO6lmlPw7z0aUMv881CO7l31WgTwSjNkEEfv1CNaKElIRZeRH5oeATv06WkT/nZLrDPOVlBzz7GEf6ihOMcjxY3Lp+I1xutP8JcgnR3wt2HpjEimQnS6jm7gYtGdVwjP4sYvNRLOIZKxsWfQ6IKAs3ncoivuv28AGmHlnrUAZVHYzIaZA4qIBs/CYVLU5IKv1GRrnu9i7TS4pbzWwaoo5tF+6/SnfyM1e4BUm5bhoN6HNQmx5OJff2d14esVrxVdhv+7gnDJ2U3aF9dKr55MZXcVaNGGQIDpnwxf45vmicU8ZZBlRZQ+jQdAlmlNA6k4CKe7PSJH2rrUwhx5Z2dBNGp5vFsCwz7y5XdsR0rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHTcPzBQ0oRLUH0fi1nGlQvSCr2DCR+oxXPwXbPlYFMsYePiowLdQ45kyY0s?=
 =?us-ascii?Q?Q+nFEhVJm5f+2FkmTYHmeMi3a7LEhoLhEtDBOJZGDkcV/kiom0+6fk5y7txJ?=
 =?us-ascii?Q?zdPRhYhUkL/XlDrR3ejRNKRJEcKxfu9H6HuMujFKdqeq9iiq53ZfTLsSwNx2?=
 =?us-ascii?Q?0xfa4V65nPM+WiDcdKE69WuNtyfhEL83UyPtYAHuSy4lwFqxQ1dUu3+Cs3eY?=
 =?us-ascii?Q?qqtDl9x7dSVO6Dliy8KQcfFpsWYT2/UwTHtEU1tCBh9+u/jRE31sl1c2mqSS?=
 =?us-ascii?Q?6a5fvQwPp6DJrDeOzymi3Scm0Z/XReuGFT23FUQiv9bv5gr3//uqT7u5bvLP?=
 =?us-ascii?Q?feDgvNJ7L+aA3P3lvCnvGDhCciWbvGOQ5QbVeKSnCAojOLso8K4R2WmAfTjF?=
 =?us-ascii?Q?ekvg606XpDzaM41I2k8cpqv1Xpx7SPvCfevmLyJqLeCVt4VpypQAUXFbL3x5?=
 =?us-ascii?Q?B3/zm/UTLAiA+U+QZCsbWFLNW5U+UUEdgwnlycm0NnA9gttnSXoo1aiL5MZY?=
 =?us-ascii?Q?5ok3qj14dwHwVlaDs/cgCBcYRVw374EGxYUOf5xbqaInbMf63Zlfoz3iq8ZN?=
 =?us-ascii?Q?+1Wfk0RS4z1LsYgxhxT4y6PjHjdaTq+Y1s+W0E87M0bJex7cURgUbfX6hbg5?=
 =?us-ascii?Q?a36+BGWeSi/BPJyt36pmOZAI2fEgkFPSbhoaosDophBfwbmz3rVuIw6y2ejP?=
 =?us-ascii?Q?DMTzEiTMiayzHVCUu3NlIueGVwwa9qkgbNZexwbSGG2lvA00RWflMo3F/Ga+?=
 =?us-ascii?Q?mItslrfkkuAfqTHiF224AzITHWoL/+PF/PdWiS+Nxb8VD5ye9rew21DBx2U+?=
 =?us-ascii?Q?83GNXorixahkvAz3+rU7Ogp43lP7C8Nue9fBfg/oRle6FgCobVgRS5cMl88O?=
 =?us-ascii?Q?HZbBda1NjWr3TpDlwclrCTKgZRNS+kYUDo1u3ovSMAMMXTnfirigORDiZjib?=
 =?us-ascii?Q?mAUAW2DvAmDtgRx3q7O52CUAiz9EUBM/b0Ywk/p1puWsKlxpnRDVAJHt/0UH?=
 =?us-ascii?Q?m7C3J3808uWbso5ftgp49vq+EFx1sBNs9dVnj59ppTQxvs7an3KaYCIjDYcB?=
 =?us-ascii?Q?vMadlRI/1tK2yRVQvJiE+b2K92oMvewMC/wWHVclfx840Fh3Y7gauWe9JVPU?=
 =?us-ascii?Q?qUcexRsu+Gh29h1H6MOi/1hvQwKYo4kv+we9jBq+k5fOw8wdREGSWazeebf2?=
 =?us-ascii?Q?ETL1VpdMagLF4mdkmPB5SV6clZD0us6kz3IjAqIU1BD5FEuFqWkr8QK6itpt?=
 =?us-ascii?Q?5fQ91ZKnT3znY9qx0QD3qoLu06uWROVTyVP8WpBVkyKHAT17VvASXGpAdWfS?=
 =?us-ascii?Q?Vy02rIzovx+eI9REhzdhVn2k4kT5m2+41OCBz8QMFrdHVRDRg4U729aMbsH9?=
 =?us-ascii?Q?hjmIgNw/7MTXlc1XG4Bck9IKcJNFzfd6rMLfisqn9gt6JzrYN8I4yyX/pyfX?=
 =?us-ascii?Q?EsS0RhvKpJNmWyqKxnuE4z8ni2dhqUN7sguvwbJ9rCUzsFOgFX+nsAjRq/2S?=
 =?us-ascii?Q?uP2Jxgnm+wz5aU6T5dtJ7k4Ign/K2BlHK5R5sHdIkM8EJkEJd3H8gaIqQ5Od?=
 =?us-ascii?Q?idVUWEPDDSPRf9LdNZDGfmTqSYFZcWJHkGjB4ZeUWzYqa27DpOnNNA236ZOp?=
 =?us-ascii?Q?S4NMT/2OvuBBYr/TzW6Y58TwMG8PjOwt7UwcbMNnCWw8QNujqxkJK/N9qzAJ?=
 =?us-ascii?Q?J5o0hrw5ZU2NPCv66LitL36VpAqUG3MwcFr2O7ifJL8YFmzB4Mdtfhsqn2as?=
 =?us-ascii?Q?pCl4c04qnUrMbq6RBp6VQpc6Wg2BbzQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37dfaaa-9c25-448f-0cb0-08df2170325a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:07.6048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVKdmtDZP5AKzoHeA6n374h0qC3q0bc+SSDYO3KNQ+ZW0kGcXa+SZ8act181yrfq3DLDQmieN0YiIBcSq2m5ccMjyXNI7JfRGQRDw9Vf3b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
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

L2-LIM consists of cache SRAM ways controlled by L2CC WayEnable, and
L2 Zero is the controller's scratchpad allocation interface. Creating
their RAM stand-ins in the SoC and passing a LIM link splits ownership
of the register state and the memory views it controls.

Instantiate the shared SiFive L2CC with 15 masters and the existing
2 MiB modeled Zero aperture. Let the controller own the backing and
both windows, and map its register, LIM, and Zero regions from the SoC.
Remove the external RAM allocations and the l2-lim link.

The device restores the visible LIM range after reset or migration.
L2 Zero keeps its fixed aperture as a RAM approximation of scratchpad
access rather than tracking the remaining LIM capacity.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Configure and instantiate the shared SiFive L2CC
- Map the register, LIM, and Zero windows exposed by the controller
- Remove the external RAM allocations and l2-lim link
- Keep the PolarFire master count and modeled Zero aperture unchanged

 include/hw/riscv/microchip_pfsoc.h |  2 ++
 hw/riscv/microchip_pfsoc.c         | 45 ++++++++++--------------------
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 612fd2b69c..18f5003850 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -27,6 +27,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
+#include "hw/misc/sifive_l2cc.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
@@ -43,6 +44,7 @@ typedef struct MicrochipPFSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    SiFiveL2CCState l2cc;
     MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
     MchpPfSoCDdrCfgState ddr_cfg;
     MchpPfSoCIoscbState ioscb;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 8106dbb3ad..d0d8c8f84c 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -174,6 +174,12 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
+                            TYPE_SIFIVE_L2CC);
+    qdev_prop_set_uint32(DEVICE(&s->l2cc), "num-masters", 15);
+    qdev_prop_set_uint64(DEVICE(&s->l2cc), "zero-size",
+                         microchip_pfsoc_memmap[MICROCHIP_PFSOC_L2ZERO].size);
+
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
@@ -200,8 +206,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
@@ -260,35 +264,14 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         iks->clint_timebase_freq, false);
 
-    /* L2 cache controller */
-    create_unimplemented_device("microchip.pfsoc.l2cc",
-        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
-
-    /*
-     * Add L2-LIM at reset size.
-     * This should be reduced in size as the L2 Cache Controller WayEnable
-     * register is incremented. Unfortunately I don't see a nice (or any) way
-     * to handle reducing or blocking out the L2 LIM while still allowing it
-     * be re returned to all enabled after a reset. For the time being, just
-     * leave it enabled all the time. This won't break anything, but will be
-     * too generous to misbehaving guests.
-     */
-    memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
-                           memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
-    memory_region_add_subregion(system_memory,
-                                memmap[MICROCHIP_PFSOC_L2LIM].base,
-                                l2lim_mem);
-
-    /*
-     * HSS decompresses into the L2 zero-device window and executes there.
-     * Model it as RAM because QEMU does not model the backing L2 cache.
-     */
-    memory_region_init_ram(l2zero_mem, NULL, "microchip.pfsoc.l2zero",
-                           memmap[MICROCHIP_PFSOC_L2ZERO].size,
-                           &error_fatal);
-    memory_region_add_subregion(system_memory,
-                                memmap[MICROCHIP_PFSOC_L2ZERO].base,
-                                l2zero_mem);
+    /* The L2CC owns the SRAM backing and both software-visible windows */
+    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_REGS,
+                    memmap[MICROCHIP_PFSOC_L2CC].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_LIM,
+                    memmap[MICROCHIP_PFSOC_L2LIM].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_ZERO,
+                    memmap[MICROCHIP_PFSOC_L2ZERO].base);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..46a499f70f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -21,6 +21,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_MMUART
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
+    select SIFIVE_L2CC
     select SIFIVE_PDMA
     select SIFIVE_PLIC
     select UNIMP
-- 
2.53.0


