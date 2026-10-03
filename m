Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799CACA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Bo-0002xV-Ok; Sat, 03 Oct 2026 13:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39T-0007Lc-FE; Sat, 03 Oct 2026 13:04:01 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39Q-0007Ds-NH; Sat, 03 Oct 2026 13:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW4zFq3g+8u2u3CYGQQwKuc4dRUNshT2LrAz0Xfxuu8+3VQJVbH7HTog9cx8eFllTd66+C4sty8FPCeeYJsnNYMkNjWGYp4QJc23xQoPLeR6z58561N27zsXYokSM4gf2sj6hxXx+IUEqggFxvxmYekyzXL/rHAyMK/81MenDw1EcP/YwNUA95Flg3dhkYWMfpd6EzxmC+53HL8/uXknEKvAXCd/b/oAjnwMuzqkciLA/9qaEZha50Y8Y3eCkl61ssfH+wiWh5ILer3Bav8ivGrYFSeh6l6L/8jDbhEY4GqWuVotnthCgPzJHwIep/C9ybHwzqTgDH9yP7FmeXHeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kU65P7L6y4LNJgp0wA8UCT8S23elaLvYcl/IHaX+DE=;
 b=r6IvQYSFuKZ3b6XXyfG+6PhigQ+fHLok/SBLdpQhmuB2ti/zLAUN+44akAggzeHQuSo9YR9iAgtPrCw9if45IgqYZzZmNGFDrpuRYmjZi2yxs2AGNhaBs9s3u6I5bvWI0J5Vc8dkfj+X5NatnvIFBsw06xfubHyQIwJuJKYS5oQS1r0z/zAse4V/lXICzzfoszwV0mC/YAzjAAOIcKkZgYkLSdfMugUDUexxbJxnPp2rAIije+UhIb7AcZZbXdnTS7EqjGRxeU/4t3Wjqi/yitcZ7G5KdwobZKN3E/pCwXEAbrw0AzdO4D8kf+ju8ETfUQXiF0nH8odKl3Gbhibvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kU65P7L6y4LNJgp0wA8UCT8S23elaLvYcl/IHaX+DE=;
 b=jl6kk18V+4HW4WwxVr2iNAI/FbwBFIEf78yEX8HOdAeaLQt/GeGFnqprvIozTaFTcosnYSCfiBn8EvjesUocRkZ3UaDu3n/vQFHlZ8mmRWjvvu54VnRhCcZR1ZY8PpgEF//Z1F683yf/cQ+IaoYVGGHSxugALSQkO8tmtOv+OFcxEB+BRQqARunW14ZxAzM/wV3RcH8kYz9gYZ3P+4GbBX9G+O8E3SgeAgCZVqKJU5fR/lBplf+e9A7eVkEpmwQVqliAfviGajSmNtakDMbvv3/q0FE6ku2dxfB1mTKOc6UiHP4A3q+VgmLp0b+iff+F3kVSwI/50xYEYNJBq28vLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:50 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 20/27] hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
Date: Sun,  4 Oct 2026 01:02:10 +0800
Message-ID: <20261003170232.2450916-21-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: f648d47d-5bad-4a35-30c1-08df21704bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: uM9/cMHDWL9Lz6BjxI7q9AOo52V5Y+3oWsOyE9Hns2+xMa7OVSQoGsMj/LhYc+x4SNRnSEDC3gk6TXueyjThOftiTKHeVTZDn0ty9jkKGSPuz7M8jVG7y7uBv1Ua89YMz0MyS7TGupqqciHcy7rJs+cfAik5yDBDfnQizLPTxS6RExmw76Cp8jL5L7ozZgcUywog4a5PaMrPNWqqowcA4buOnD3ACMN0NeXTYAp2f7XxnXb6ta96c+dEFhZJQMesge3phyW8CbvOjVGgQ0WYwBLAH4CqOe2XmHUISAI8jZHYw6cnllz+lUR/jYMLWxKKBbGURplgfK03wA5nt+DhXf0DWtM6RMOr7DHQpNPMmHL9ed2taOSKMlL++MdrLvg1lXHi4/K9w06J9KBd+hLtl6PoKZvnVz59fwkZDQ3EHRZgzajppntFzvj7VEv5azlqmj/FaxD2c+qZprnVakAym5cM6e76SZFHanmV7UO6PDMh292NGe3hYQ6sqEpWLhKO5DE4m8/EjEej/wmMAs4HsM4jBbYKSi7xOXgQPupz0IWWe9OxrFECas2vVVeCLWcCUHAO0Tj7wl1tQNUqrbf5Mtdj4jgafluJPlAATl/qyp3lBJ10mWQDq2O+tFm5bdSbFR1hHtuFCBpATEWTLYob0fnuec/ekcBmO0GDS/e8rK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?innT41JqPhUl4XRij3SB/ql2lWaPc0i8lU2bl8RVMJk4WglgtfyJo7sLJ3Gv?=
 =?us-ascii?Q?3yYG2pRYLpDWRgm44cYttiRPwQ6Fcm29qv5qj9Xa0lUExLDFwYhPQfVn+WZp?=
 =?us-ascii?Q?GtC5+pjMcP2GmatnFc0AlutpXVw8UVtzVGHHAKu4DVb42MKVNLmny9kcAw6X?=
 =?us-ascii?Q?JH4YNcRCR4b9c41VFwzrCRTkxcssCQV0PZ2cqQgQXkV2CBbTYRsTNxyTj/De?=
 =?us-ascii?Q?B4xlVbHnJeNGlKuFNwfOkv61mfij+O9QkGEI/VxZ3vWEVLPTfAO7vCtoi+Tv?=
 =?us-ascii?Q?MltVb0ZZf3xl7ENfmfVt/t5AXNun2mXbuAAopWGU9a68pfz53eD+XHq9RoCF?=
 =?us-ascii?Q?ANicJm2g4YQdVpI7rHMc+qvIlrkP8O/QyE4e48q07QdcCFURWvzNarpTCizJ?=
 =?us-ascii?Q?ExG/OVeqkC2A2wbxtu9jLs7fjRxCASo9FqDly2cs3LSp2Sg2H1qquDYK+J9n?=
 =?us-ascii?Q?K6EG2vZwL5tsG6s7giaCGpKxseZxKdcb5G4K0OKjuv/Nyxh8nqZqvic1l76n?=
 =?us-ascii?Q?pMfw2MY/bykf1n8KldeWJ1UtUQ4X/Dr8vvyJ1nhn3GPfmvGpxtOUh6OnY3d5?=
 =?us-ascii?Q?fUEdXtzcslcLjasNnIy1BebK/GVOI9UFvK+uI2UcP0waVuvmMbN225lZgODN?=
 =?us-ascii?Q?1E6EiWViKSmb37TBHia12xU3uj8YOwj8tbkcWHlFGXJRNEZO9+np1FOrRFaO?=
 =?us-ascii?Q?hwd5p+Bj/+7GQ1nWV0HzcvWr+oFEzJyr7Le1+PctO2mJ53A7n1in07ntBuZU?=
 =?us-ascii?Q?rkwcYWt5V1kxqbIokNBu0nQa8UCMVZzI12lw2oNg8iDsIVlBsk0J09ctFYx3?=
 =?us-ascii?Q?hWV7KWaXP3jVXsFtVCtXujEz9EHF9tDHuIqpfaj1G5DvqzEwBdLII1RPHfV8?=
 =?us-ascii?Q?r+rfXDtdb7lSUN63pOIfx/rYcc2D5uTD0TGDEi0ke0e0qrLAoiiN9WDo6zb8?=
 =?us-ascii?Q?oFaTQmyTW4+ghHeZdIXPodj680gf5mvQ2HUIiCrsJsOI+6fL+gDYFKWAnJT/?=
 =?us-ascii?Q?Qz/FUA8HuTnSO6CSVhMVzZ/UQyqAGN3ujX97VtT0War4ExYs/Y7e4lyRx3FK?=
 =?us-ascii?Q?R08F2CPHY+UsIm3Xg3NEtX/+qnKkxYX2e3bZLJAQCZ0Z40hkgV612592q+Lz?=
 =?us-ascii?Q?AKBnCMJC30mocYNHdmNVsCk3l99QuUZDo3Ph3Ta624Hdm3orOVxfwxO4f/AM?=
 =?us-ascii?Q?jLE5e+vfSgJpshgdpZ1o1OM5AeMAQN/JD6emA02q35a/SpwZjs7DFlWU5xab?=
 =?us-ascii?Q?t/sP1IXcFDW75w39AyYJLDLzn33ZHgIsqEu5a0WDRFeCB//GTV9VF5gzFL7q?=
 =?us-ascii?Q?vyKhUK2sUkTNqPnXPPSV4sEABWzDwYS8lUfdQD0qGkpBoRDKfErls6xX6jWg?=
 =?us-ascii?Q?6B+6xo/IzihdgILMZP4AXl3TKjQIC0p/6ipHA/8tDzCAdt6Rn5QU3+Crdg3b?=
 =?us-ascii?Q?OAu12DDEoWYSo0bnKUKPNnuCrb0wa6NdtlKrEyLgSgw2L1FpMTYkNn4hmBfz?=
 =?us-ascii?Q?ODGWiHA2/5L6CnWO4QrBmsb3o3LeaZaOdnC1gnqhblcqWDs0/chGZEUKc65r?=
 =?us-ascii?Q?bMcbAinaXsUUpVyGu9+RfAO6NjQEe+YHZuSP957UXnpgL5YgRSQKydNM4QJN?=
 =?us-ascii?Q?L55TuC9P3COsGVcm4QSxkwAZVf2QytzFTyRxUaCNdq4vi8I9UJJUjzMFYnph?=
 =?us-ascii?Q?kW1P4hcC4fRdEGoYeSvwz/VLIX/gzlADh1l+KwIg7/ML0yzNHkpJd1XGrHa1?=
 =?us-ascii?Q?jinScK+s8R+ZiTy3r5T2G8gUzrRCXKQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f648d47d-5bad-4a35-30c1-08df21704bb1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:50.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt7Va613TKsoOVllT0U43j88QG7+qDOuiDcEzTfSvtWBTmw5/0SY4mchPN2ATl5GFJF41PiEI8QnD+JeQf0GwtiUhx0XuMAvEp9bM4/jEHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
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

---

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


