Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B3FCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnj3-0005TM-T9; Tue, 13 Oct 2026 21:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj1-0005Sv-I7; Tue, 13 Oct 2026 21:24:11 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGniz-0006ql-Q4; Tue, 13 Oct 2026 21:24:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrnZDSz7skC49irDQ9v1+MHzr29V/IHvDqZahAmq419lwE7BJ0o7bqP6eQpjI4uN/zY8NNs4E0cdv+VpUdbhAEY/NBFgTE0UlkKPlt9c3L7AOARFwEpz9xTEZ/Ddt/Ab7/82QAhJNdz9Oy2tW1bQ81DPDPKDZ/2IDiVvHktjH6mtYwMonSmfL3U/YXh9hcXMNMW9nYKMW54mQkAq+aFA4HS4czwMnJygrU9iyRI/iJOVTMyH9SJJzkDzaEUGGO0dyuuNcHDNrRePkRDsHY9FUvYbv5lD4pmNCRLpicYx/BWhPtn023v5Y16xZcIFZAgZCYh/rwkczAjr1qcxfPPjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFpJ9JRgEBO+VaHtLo7Qedad+cMHZycM3aypk00REtU=;
 b=HrIXFVoQtV5+2357MdktkiPDGV9kFDDSfb6+fRUzQADOlviH0KaaYAyf1ClDoqE7kQWl7wrUQyYVfM1iDAwDp1OxOQ4KyTKsZCqgWv32IDxPEBnka3bjSe7hGwTZXcnu1o6JZkom9CGXfXLTaLz5vy3iLBVwNohhvSttAYA1biK2U+1CRcYpkfx5kJqUcmy+8ThMTxOqFptIsgdWNUwda0Z2FYZCz3vFDFoeGiF09kicu1GOrQoug6WWSlAPzX54p1kCvlCHvArtiejx5TRbzClyySOJ7aSXq7N4G8T+hrhNoSOskvFS8y3geLNps6/BQCMyFWzxJ9oLv367VFUf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFpJ9JRgEBO+VaHtLo7Qedad+cMHZycM3aypk00REtU=;
 b=cdK4QGnfXAxFnZRktKYgXc6KhhvS0DQvzbBw8gXtnK6gWCePRZKlFPYYJAh81MtSxGKfIh7YYya8Ug7oiV9czSCHcfO+ptsToEKYVktGVU8P8TgGX8THF5xwyy4dC1Yq+D3Mj8c1ROHt4Jf7F0lah3FYZMxu3sNyEMPNglvDwQYy/Bzy+zfbLjMwltapLGqKKBVeUfz2vC2Hyo1XTGm5wzhv/qOlBAqryXCvraWfbYBLpmDVwkUjKuVMpddTmcz7S6WlqSLb6FFuFIxRfA1S+exjFHhLtJgOYACb5saRIJfc4GYG+MjGuWxDvIFfsDdwHUJ3GYq/9BJ3YYTVvNH3YQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:59 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 05/27] hw/riscv: pfsoc: Map the SiFive L2CC memory windows
Date: Wed, 14 Oct 2026 09:22:45 +0800
Message-ID: <20261014012323.322790-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c247fa4-4422-4f47-d2e3-08df2991d2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +JGvZ6QZWgUY+ZpvP56Rvw59EgRZ/4ooVgo7EV8uUCm4i1rqD32kSim9Ixw0VqThxWDtzx6h+YIayLOepU+ECPX/eHApfX0NKTUtS2lzykC5rNDjoqn+98ovaq++ZH+48RWZqS/il87S33P034WXgVrtYJVcJwf3psYG/ix2tJyJtr5EkhdloY/tFgTDUhM53DBdgBajWqSO8Ym6Wns/G4C+redmorzYzOWEizjOMkFiATF3jrhLHKdIUHBoDwUE1n5j0veIeWdyGnlFVJPxhYip6CWxuRORP/VCey8Wrni6vQYepgnLdLwz4OzJBAAa1KasKEECmeq0NNhtkgcgqQIEs+QfIqZ30OiCEuVSiefDqBCjcmdX+5MvSB9LTLS3txbzcAbajzkyy2rapCjh5Tu0LoKlWNu7pkada4TZgCCfafM1waGjSKbqoXBrHmR4XTuHfCkdhtpRVMcKTVDoxroJSwNbo6tpY1tTDdZqoCGTyUXwiGnu2UWzHPeawsFgbFpruh+WLs0yQnPVSfa+p3N3jbQ54NLQIKlKdg7+2M2JPweXZjDrlIdmlJnahOM1eM4OygjmI2i37bAV3AuMGwVucJJcI8gjymhkwZaGUHk79MPQafh4QYIFmdiuIaFaawTkE0d8LI7oDT/s9c4pd6DbRBy1Wk6O20/dbhT+xeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KyvfmlJjsCCZqHw9NeoDeJ7u1hQqzjf0i64DbMwIwi5eUxzxx9J8p2wu3dr4?=
 =?us-ascii?Q?HtvlPTJUJDdiSSZuKg8iQ+A7JtmCeznVusk5GNvfCeyCNK4s9ES7mWIZWJt+?=
 =?us-ascii?Q?pXWOkO8tTXdjziI66GY+2WM6gxB+evyUKBol1Ykd8WP18sG0oiTAuOsvCb+x?=
 =?us-ascii?Q?CvHhv2LAHHClFdR1NXIASDEmUhNg8Z+JUCKt86Fl1w3Okto3kWS7mRh2vbNw?=
 =?us-ascii?Q?n7GY8E5V8zDKjCpVUKsQJNHdQ6OMKONmnP1JqcjSeM4JGjOMFGTWuFeeIYf6?=
 =?us-ascii?Q?iDbkMWflmk5hSttDFn7OHyfZCgM9bRcm7JzfUZr+hJkTLNFmWYnxO3fIA9NL?=
 =?us-ascii?Q?CqoRwi8olq4Qcdi3laTu4bfLilUXbuf7dtX5+7pHEgGPPiJRlpE/K2Mi9BGJ?=
 =?us-ascii?Q?CrItb61rkhKt9a3sTFXJQp19TZukrOcsVqCOVqvVf2Yj8rglXMDs/AVRguxw?=
 =?us-ascii?Q?oc1NNVqs2QP7cLO9Si7xSve7iCDe5D3jvGD43eqEV06tg1/qnDfXyz6YipFN?=
 =?us-ascii?Q?fXZTyHZ3NpETgxsht9ppO4s9VmIUlqFPljJ+D7QpEE7Vbl1cD/w4HFgP7NeH?=
 =?us-ascii?Q?Y0MpK8yJQUCEvlYiWmR15oQlmkYiBV1lXrqGtYsMzd4hfmNp0FKNlShF5p9W?=
 =?us-ascii?Q?DUeNfAl2DpDZq5GO08l/Y5pKI1hbpjG991JBZTAf+Dm22K1JmoHy79gidglD?=
 =?us-ascii?Q?Y7tHaKg6evs7dFRzSsn7LhTzOfNEFAKMfuyWQSCaOAaKRBRo6VYtIXH/HuZR?=
 =?us-ascii?Q?XxvU1W17SrI307S9ZR4bPrW46RJj6kj3vzkVnZF0pu08EWq+z3PHvdAQY65j?=
 =?us-ascii?Q?7sSkGk/VO9D9TihpufLD7Wp64BYqdnT5zFzUDeXUUhDuobqTmW22d7eachwe?=
 =?us-ascii?Q?Z1rleGMWYvdcK5F8lxu8QLLZHuiOgIe1prHeiavNbzXL4OnbLSEtWtiW3bbJ?=
 =?us-ascii?Q?sotKTto+Onpgu2d9fHuYBatJUd4GBkKa2Bq85xD2peE3r56VlcMNfK4luexQ?=
 =?us-ascii?Q?Paikk/BL4KsY/eYt2C6sgCrc2dZsrqOOIaQmHZsoGoE7HxYBciI021Xq6fzL?=
 =?us-ascii?Q?C/3HBj5ypfEQS5dB6xuVbcKUsYrY8iz9n/z7DxoqpswpghQZXMSD9YKGI4wV?=
 =?us-ascii?Q?/7XNca95fPg5q/UBXkyqfE8uYfLsgFQ5ejrF0adefSFBpdmE1WrmfCill1Sa?=
 =?us-ascii?Q?uW4g72UKneXQA+WJ6UUg0DM170gELSDUSbgDrQBp7lHEF7vQssOVhSsY/v81?=
 =?us-ascii?Q?wL7lIWZlVBEB4Mq8x6QgO/DKKa2TgSKMBnM58mNBsfxQ9/PiLZkRoKZwQxp8?=
 =?us-ascii?Q?ueddJkuJSryOEcYe8wUCIPkTjM2t3Fu7fHlnPhw4dhW/Ny1yk7UwGv/4eSUi?=
 =?us-ascii?Q?rc9T3hMb12M+wTj1Mgl0tJ6/6MQSX9kUROJnBRsLQG3CqWo4EngDpJgMIMZS?=
 =?us-ascii?Q?gMgcGnWgKeDWt1XokiJmcUiqc1Q0Ua6lWloWnjiXFgHu93UKUGGQsfVnbagy?=
 =?us-ascii?Q?dB/oAeBnsPf9l+1UtuxnVsZAiEzizYeAqvTLiclEW4ZEt7B56zWxK8c3oQXD?=
 =?us-ascii?Q?TRFNOvMOs+SwIAFp9yboLcz7A8x0M7TkNEM+P99psPWxgps4dXQdH9i99cFL?=
 =?us-ascii?Q?+K4mFwWUgKTMz1R4eMG3bMD25viwV3LYB9dbmZ63BxzBRQt/UHgTwuLSevIp?=
 =?us-ascii?Q?31o3Rl7ZQRjJl2PWdl3h4ik8kBG2/DAVnVpXRRFfRzdxOEdPDFogfeVAQcZg?=
 =?us-ascii?Q?ddBjWcAL3MnVTs5ZkHIZY5ickyxMiEM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c247fa4-4422-4f47-d2e3-08df2991d2bd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:59.4157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXQvaXUPde2ZAGa61TAWtWxeLForBXY6efHl0OJ53ozF8vTzgLVwiPoNpQRw1mOXeHYKYqT2NFa3yysHiY2GfV4IrpwXEJefCC+XKM7BxPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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


