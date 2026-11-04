Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1C606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=g889/IHs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8T-0001XZ-IP; Wed, 04 Nov 2026 10:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8R-0001VS-Ik; Wed, 04 Nov 2026 10:42:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8P-0001E6-RQ; Wed, 04 Nov 2026 10:42:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUwivf92ml0KOg0u5eEg6H9e3G4ncjOg61iZj8EHzTplQ24yFPNamFXgCLI1WhfaLi5xuf77oUF2LX/3PIVVMfdx2YSLJU5i96+6f5/ra0i1THcGPAegKd49Lkgb2DNgOKfQ9UcghaCT1iBpa690Er2wB6NdmueABYcK4p6cYqxCCvj+aJnvwBEKvhztXdTTD2LuOxn4GhhJxMV0RPFNoAedNAppmog9PLyxR/u6U9Pc3qLFke4328ObZ26PvYa5hvso+4BfvFluRb6PvoLHr8d6LrNw9mPk+KkQD3ci63VWPuJc7ia+MHuOUdvN5xObL2sjVevyRX7PaDDry22Qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O25OuNDe/CCVAanB5hGOafrD2YPJ5A4fEdj+9u8JHtc=;
 b=XYLvNbi2eMRVVX9Ab7srnPJh18q3GnMoIsnUxAx/l3fcTpYuaw8Q+2d8p1edOhIgRiF0ylAFuJ1qgW+ujWlHfNmvfAk3xyvGqsCPoOdISz72pZSqQrabrcHMxRz4U8WBYKEEPNhws2tuZbCrWZOZZ5ozH4aY2CSxU51MRVvaqanF2kQK3WFwKPMq1N3RS7qZCdc5uW00RoVJRTV4xSllgT0AsCooF2y8pB5wN0n/N23iCooT8VWNgMXnXnlrl3H1JbF4acNRt6ulQSlDQJid8tSUH3pf3LxNZWdh4t/CP7N+x6+3yAJuGYIyqbgoeEHTWm6o/gtFTg6rpZSRv3GEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O25OuNDe/CCVAanB5hGOafrD2YPJ5A4fEdj+9u8JHtc=;
 b=g889/IHsNr0mbyZtcg9iUdpSsd4k6a6qgVUL65nzEk1OWSoW8kTqOw/s+p2VVoL4AeYD2gWLQwgNLEOxCWo1dwX5SEI7blk13gvwYp2uaEEAQ8tTomU1UrAgLPqhd4wA9s28EDgmfyplHDPGqvWHUc2AzZIPnUmk8CfcCW0q3sKfMDxv6nKCiYNHQoptews1ti7jS7jMJh64hjp3rXJAB3Ph9FoOcxx+7kw6Kepvyjj8uP83rJtRKrr6HV5k0t6/e55B3kP9pp5RNJ1IK55NQ/7PweBhldfriSCi55tIWXf1y8lm3YiwmOQzVDqQ005dQfANbw0Wj+SW38Bl641VgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:34 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 05/26] hw/riscv: pfsoc: Map the SiFive L2CC memory windows
Date: Wed,  4 Nov 2026 23:41:32 +0800
Message-ID: <20261104154207.641511-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a47740-f6b7-44e1-d319-08df3a8a3ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261021135927099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: OCPNOR7s+Q3AotXkemBfBdDOtmKLbsdv+pniSfxXmMTF2pkJRdxe+adtTJUV1fJTFiwb5T/1TbI3MPZxDv543QBRZ7ABYgbyF0ev63pk0YvknwAz9ELsvCpIH44DRPgyMg2mEQg6tg3cuQ23NUfpZ/qslYsXlcx05faZEP/ZKIQRYJaKpxTWfQSD/TiT9CTqRXxTpfP61G++is2tXlGD7RPnxtS/TT5VosQXhYNMWEtLGD+ODmFACkHfFQ4eHgzVIP+fWBA4UjJs3BxCSXCZ927kdss34igFtGCZfjYSZVSRx1pZv+ralus4b7t2Q73rcxDqffJbz4VoeW59F5T7lo8TElMn2U9OH5Q/pAEHK7gK00XCFLNrRLQFFGTPb8dnTCg74DcqDJD0zDsJFmBTW2+USt80UW1kq4aewY6NEnXHIiEYa4FBw+zQsKH6jf43CptR/jyrQUmQfVFbNn+MyaTRnZRtsX3F0IEBj5xwfZ7U0xb+1GPvgeZlrNuPrELyi/yscProUbzMIkZ9XrR+wUiA5mVoigOQljoDXuB/e9GN/41cM8AjaWXiNvqj6EjLuCFbu9FqionuLnsenp28e/6ETw+eXIHFzk2mjGEjbTRmopG9E12h6WxezdNVZekjwBAfpIYndJg2MuPu/BZ9YVyYa8KImhrmpTJmsl8jgUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KO9Xrur1OuNW1LSc8ct3UpPx99Npc0HtU55f81l6Y/mYl4FGgSueMiJ5rnV?=
 =?us-ascii?Q?gPW6G76VowVI738SauYMHjKyySOE73KJXQVCVJJ1QZJVp35NM/z0sRSel1kS?=
 =?us-ascii?Q?86wDI9/NNhMPkk6MSAaH3bkK5nNlZjC+YB2yO1KsFYrWATy0uq7FYjAHiCzO?=
 =?us-ascii?Q?qm7RQWc97Afg5xEhJSykzV4PtSKIp/6tHM8Fly36foxCCu9gQo5TmrrSkO93?=
 =?us-ascii?Q?bxPzS8RfwWPyMdnbFnyTyGbktJOrM9MYnE1plDm8MqkqBwPYPerjPajVH2Px?=
 =?us-ascii?Q?E+lk0QFblPlIowlTsugdk/LjcL3ZiW2XlPCgpUfM8RbP9PyArQ6ZOQUh3TND?=
 =?us-ascii?Q?e01bs6oqlxnY/RpUlRBq1k8Jh4UNfJsPWJMFOewFs9s72KF/5YzQVdtr2D4S?=
 =?us-ascii?Q?WQl4rjOyjXYQD1JLSd6WWjKm3rWrkJW3oSWEgARyJxPdIRLRaJzxoUYzkmUi?=
 =?us-ascii?Q?ZfyerkzSPjF8OprPQZihlhJQuc+w91hX7Im0QLSLD6iZ/vsaOwGUhA9QvPMS?=
 =?us-ascii?Q?cxmZoV6OosfDWOevUS9yTsCnRgY5GgbaKSxrVveQynZQXOnKKiRpX7q9oVA5?=
 =?us-ascii?Q?pgqdqFMOz7UPivyzH6O2Oxwc5ESriATMoW1tIIzt0o3Njis+NXsn/TDXq6mX?=
 =?us-ascii?Q?f1N7xBou6IC4jCWdn40tboQroCp/FYJFU8eAlMXO/59zEkclDddzI36zgBoO?=
 =?us-ascii?Q?Sa7vMQRKdW98I+jhlMpcgQ2t6nxepz89nOfpRWLncmi9C8tma6RdaP5f6yLh?=
 =?us-ascii?Q?FZ5vEOJzbX0jO4/4t4Y25Z96G8WdipT73HgqR1BBPsnLJBV/cRjpdJ7552HB?=
 =?us-ascii?Q?6MVITij0WSe1kOfcbbzjYWUwjD7NXfOHJVDYx6GYOLUaH6r+39/KDYEznRjm?=
 =?us-ascii?Q?GEzPfhZqYW4r3AeAJbiDT929gBulboToTZ51RKeFeWdMAuUEdW4M7dWMjbw0?=
 =?us-ascii?Q?2dYOlX3gfze7uq9Ft0TYFZqKOT4JLgrI2ATmJ2S036wxG5UwuglPt/w7tny7?=
 =?us-ascii?Q?DrJR7aiFgo6of06fMGI6fEsmC/z1IlX0GKIMbZ625hrmdzFrrBNlFiQ9Qy6/?=
 =?us-ascii?Q?rlTIysfwTbXDKJlf1JsNyFbRJsC8fhlhduOYq/qjq8P/zvX4GSYhcdF71jgE?=
 =?us-ascii?Q?Rvil8NIkr8QIvZOGESjVHfxYyrHTMiwewpElvbUm+5I2jEPpfJJ8l0WEJvFS?=
 =?us-ascii?Q?bUl0rhGaWl3ULB+k4gQ/Pq/gSPKSLkDnlJWcYM9ac11vpL1GLhfEybT1yy3L?=
 =?us-ascii?Q?zNv9UT4pJ044zqqBd2oBUksXtRluFlMsE5MOjW6DQ0R3xQyZAWhcVNuW0Osv?=
 =?us-ascii?Q?Icvqmy+X2trIo+vHQB6I0p+yyvNQ6qmC7U240AUhgNBr25IwMUco+4Zd0W65?=
 =?us-ascii?Q?a57yRcBTN3L95b/3kKHJj+U9U1PQ6ui6Vao9bGAWU9MD+UPL/EGrpq6dUhf6?=
 =?us-ascii?Q?DDGI1IlffZGiQrWQxX39n7CmOk3ne5yF6tAAxz5/J8rLDLSC6A5TJXxmrnQs?=
 =?us-ascii?Q?kptLwbdiMhLAmSqRDCKFewq0872ZGe5SEEEnIdu/oDtZsrMlUVCfdvvKXeOp?=
 =?us-ascii?Q?KpgrYO0O8VlDstmHmt0X2HweALm+t8Wgg42AiRRZzcSCzJE8F5FrG4tN7yrb?=
 =?us-ascii?Q?k+EOYrhVsKz5rpKU2Oxun3RvkY4XjWNteg3yKMeKcxHU1or+PJLUbDln0YHB?=
 =?us-ascii?Q?e5uXSM+vPU7hYY5KUWU7q4yqqeFYDv2jGz/8q+kFTeezyG7vLnvdPRKPUj9u?=
 =?us-ascii?Q?b2wy+XOMFHoqBbN6DLqr2k/1YTqFj/o=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a47740-f6b7-44e1-d319-08df3a8a3ed4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:34.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbpM9aVlJikBBLY/uzgtmNNrlUpnjc3TkeMcTNRtn4wWr3LfjrXnO5wb4EDZG3MNTIf/dmbzvGJALDfjDDKTTMXzBE4tMRALtuBqm/gjoN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

---

(no changes since v3)

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
index a91ca951de..d7613496f8 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -175,6 +175,12 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
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
 
@@ -201,8 +207,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
     char *plic_hart_config;
@@ -261,35 +265,14 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
index d89fdfcc86..a22ef994eb 100644
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


