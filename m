Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB791CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Au-0000ec-Ov; Sat, 03 Oct 2026 13:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39Z-0007TU-FQ; Sat, 03 Oct 2026 13:04:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39X-0007Ds-86; Sat, 03 Oct 2026 13:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGOy6p4IjNaDmYYCsTf2E+CgNXEx3SJNEHCcleXIFyKmQmu2YPVvWURce8M8gTd0z60PoggNbPFcj2qIbugo0wcY7k8AF/uCM/VgADKLU7NxIdMYrCO66u58sgw8OHEosizPdwcq7WJCi+m9vcKJLgeY/xzh/uQJEUVYT2ZgaiUoizkfeOSkCaxCRRVc4/Txkv3P1hTGi6HiMDg9ZFA1vksTVoKVkLPVq5m/FaRrNiLrnrEABvpApj0gCX2a6iS+MpE9LCjGuPb6S3xR1l3+jk4gb45Zr3KqKCx/2fyt5LNGXbORLurS035dF69sODw/u5sCfUzGvQ0bbxy8zrhXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YK1wgEucN73Rfxncz276/NTQDi49uCwF4pOhI0p36c=;
 b=DtlcuoQoFLne9eQT3tBRScPsasHEnlJVxjk2Qy85aO9fb5XLP9XBJxKb+pxU6PJZryc0O48AwoVjb/i5ZsRohQshn6aQXIuKEQz1jLTBV6Ebn76cG7XuuCCLpJV3iMwua18ozoyf0nD7Z1vMCqQ6eq+ToZIDdDpmfL1CN8OTxTz/QajrBXvmxTrMdfsnhZzR01K0d22yG0pNDimznF3h7f/EHTL/NhPo2xJZP4FTdRwnHT1g2tjJV2LvMhxbtxcESTOV/3VTvKxgfbUnKknevP2+RF8EV54xewkmKVVcyV0lwwwx0O9jk9qaG4763CYFIyWIhg77U96VBUcBjc09pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YK1wgEucN73Rfxncz276/NTQDi49uCwF4pOhI0p36c=;
 b=bM5cXYeOswxIaEgISgGzeFmSyWQ9DgFs/rbWPpM3Ly/rY9FZXLMPI6h7hrFLVCTxgDlz4HisnWGnVamwHlxL0RHAofw4O/sVzu+S+9UU6kQlDU0D5HzdvT+hBjKuquIA54Hg8l9EBYFFmp8TNo07x6cQ3Y9jM0sAyVRs1ZW6BJksJryg6fO1n9zCy0JX4g3peTobzogUkRTIe3ZcKTaofaj9dCKxRHIUrRj3EcePEVilF47YSj/lJzPcz4X8/e5MUK7Ry+k3UVwal5rgSLnoTncwqddYbG/fDvzdQGMHWmPiasMUoiyolJwVyVKnPwTnN0CICPooaLupJFu+50emzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:57 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:57 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 22/27] hw/riscv: pfsoc: Default Icicle Kit to five harts
Date: Sun,  4 Oct 2026 01:02:12 +0800
Message-ID: <20261003170232.2450916-23-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce3e3506-5d04-4313-714e-08df21705024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 12AReaaPhITFm9MRwz/AEUQdtLrkBYl7hgKiVAJ5Qdip2LpZNnaEv8d4rGAYotfwCdFwyJ612SEoXtBw4vlgMJjTAibkqdLa835vgZAcbijSLTl3wqEIYuaxVszFKQdlRbpLK/MGR2pqekVB6Z/Vfi1SGjpGGW7469Is5gORW9Qg618ZJ7LWcMWwPuDgl2jRNqBY71A11rAiXfRpbDW1btq7y+1fNJn49YhZCFMPzHZx2EWFIXEgNMHIPuD/0Wt616caXhjLfahqTqMmB35yEK8BfmkHN3sLYFkca9pE++Ax7j1bINPJdJk9CLi3MaBc9sNJiaCChiITgEnRu0v9b2I5SGoLKuWiSwcjcq6sDbKY1MzObQVSav/yMWo/XNTQ5aQHMFxLB0nfvOXyYUjUspETQeI1Ve+fJkLeG1F1MgVS/BulPeIRMoJh1/N1/y7JMVWptpgD4wxDrA3+7VC1Yp/Y8gfBUde1y4uQ1+HxHNlwCl0l1QHNNLlDxoQF2J6U+/Og153uVn7xAfRu6/qV6RKDNFzJ+z6xi++uG+3dkn7V2JWUuiwFvlAjh5kGOCzaTdAQXxUJv8H0NUOIqKCJu6XHDrubO+9ujZOAS8vtmrA6G85JTIGwm/LxdmZR6/evWcCp4uij//OfX0UuqagLavHGvDnYgcsAXdDB6milLQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyEr35GVUPqIhO5haDAJonK2JuAReJlqZwnen85A1qRTEZG8YkRdN3X3iiyl?=
 =?us-ascii?Q?ZsVILZL3gDSq3JxfaeVgZpeprpxkgB8N41ctsoMLCVpn89YzLo8mlsuXf5OP?=
 =?us-ascii?Q?Hu0L/uU+lfagoP2XHBY73i/GA7vs4nQa/ZqngnsYkO8BqqNEjJeEQn9jbMY3?=
 =?us-ascii?Q?712EBI/8hXcI3KUczWFSlt8tE7GTxQDJolW5tKNDZZXDJrZm9uY1/7n4nqSV?=
 =?us-ascii?Q?TkAHsPH1r5JCvdRqgdfgsyFgA6QP4aROEnInTjGEl1bulj3pZ7l9BSs/PB0T?=
 =?us-ascii?Q?LltrI65RkkBOlDTiv0yPap/XcYDVY8qi/28AyGRvM7UZ1+9hrcI3Gm0atqzT?=
 =?us-ascii?Q?9kjo6eCeIKNKoKi7bULlyCJV1Yl6jKm63JXAC637Bq8JfTPh3o0fMls1kJgl?=
 =?us-ascii?Q?yvCSWlLOId8g4P4Nsmekf4bGr+f0yYyrO+oDuN+58ZSyhQWsBXFyOimGgNPK?=
 =?us-ascii?Q?Y8Qf5yWndtFYdQWFy2t6W17UWr7BVcgVNr/BGeLzS2ICcZ/cVYCUj6oBkAIl?=
 =?us-ascii?Q?P8kTWzlIDkC1+TytOw+4n5ocw2iusurxg0TCglFP+py/7UyQEQiv7/wRnq6f?=
 =?us-ascii?Q?fz7PCRAicI/R4PXfzhX5Kj8LjradLgmEbLuPUzjiJDqjDcCY4vvzC9UObd26?=
 =?us-ascii?Q?MS4y8RWxLZIVS/qT1iZ3Ydlz74evcnV1DfHiRk8PkczCWXuk2f77U/cAosY0?=
 =?us-ascii?Q?UgG2z3FAwMJRgWHIm6b3xYckT4nqleC3NpYTYP1oz3aEv1deixDr5U3/FmAj?=
 =?us-ascii?Q?NEljjJ/odKfOiTtyINm7SbViR6iUENuD90LEbZjou4fuMYSc9UK7K+eQfoJ4?=
 =?us-ascii?Q?c5I5J/yn4XEMvXtncGGxpxUUNxse2DPS2phglaTKu+wv9KPCmGKfDcFmy7Vi?=
 =?us-ascii?Q?FCQ9l2HfdHUh5sA4yEIFy4C+6xC/dggIjtJG04rpMD1QnIn6Vr+BKqIXOKG1?=
 =?us-ascii?Q?QGTC4mZjE39BPTKUzy1+ngHTNce52w7AbXK9r+W4+hEiJposqKxR/4mROd3C?=
 =?us-ascii?Q?7CdAh28khD9Ih+O+iOx1P0p2nRfwnBgW46S4DQ9VjloS1BxzZxJii1CzyJaH?=
 =?us-ascii?Q?C7KazS9TjShuFtv0DAyyvZxKzH2+hq2keVXklI+NFYzAqbK0CCpmBKDG0LYT?=
 =?us-ascii?Q?jiU07INntfB0fXK+c+WQlsyOxJnk/40gtNeAa5dLJP9xC7b3ZBTU+M8M/J3F?=
 =?us-ascii?Q?5lwrzGiExfHC47ZPWq/CEhFVTHTxlhgnlCEZxyAx8rd1jov4IJl1WMTS685R?=
 =?us-ascii?Q?i7fMjfJKzqJ5iW3vVMJFKT54WKHWakFvDfGxBLzoDL84RDVdqGSOi1lrLKuS?=
 =?us-ascii?Q?ezrGTn8aIwoMAC2CABru/cihlrn82v+ihSQv5wfvuNlkHkh7J7eQgpMB8OGJ?=
 =?us-ascii?Q?jWHve1G5RF6/WMpkbq6oLIbQUl3JbRQEY2afjX/9ybOFItLV905NO3NuCFrd?=
 =?us-ascii?Q?wUndIHkDT38OV1H/jAqFC6GV1Oe1xOkkUFSRzVeyVOdB8wKMgKiVaA9OnHJb?=
 =?us-ascii?Q?IGrPSq5zOlBGUUxql9b0sOREF9D9Y98v9d7hBJCQB/hYGAMKd7EEDt3s1FX9?=
 =?us-ascii?Q?FRCYli+DHQqPQvlWv01lBUMwV8T9/69NQAu9fnVpCpm0VSBJIeni0e5NYRU8?=
 =?us-ascii?Q?9oj3J96VxuH9zzxUGFW1MNQsPZkWT80ozR4HywGawpgmMumT0r9CL7M+e3mm?=
 =?us-ascii?Q?gdp2gvps+ABxZ6uRECmrxDSmrIfqaskf2R34leDnTG2IK3tcRPHllSjLuALv?=
 =?us-ascii?Q?QBJFdQL4dEbJXMmyOwbCOc5NwJwHeyM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3e3506-5d04-4313-714e-08df21705024
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:57.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gtbdOjSc2raBjyDbAXJmZEt1itB55tggKiw72p6qHxrH+fY67lIc2bRFnKKMUlgvKHAaWVqQIuUgmWa+fx+w3AAgODLyNLT7760ca5Mxs8=
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

The Icicle Kit contains one E51 management hart and four U54 application
harts. Defaulting to two harts can accidentally boot firmware and a
device tree that expect the full five-hart topology.

Default to all five harts, while retaining the existing two-to-five
range for users intentionally configuring fewer application harts.
Document that firmware and device trees must match the selected count.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Change only the default hart count and retain the minimum of two
- Document reduced topologies and matching firmware requirements

 docs/system/riscv/microchip-icicle-kit.rst | 3 +++
 hw/riscv/microchip_pfsoc.c                 | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index b0ad24f174..138289a913 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -27,6 +27,9 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 1 SDHC storage controller
 
 The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
+The machine defaults to all five harts. ``-smp`` may select two to five harts,
+with one E51 and one to four U54 cores. The firmware and device tree must match
+the selected topology; the HSS boot flow below uses all five harts.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 855c719f76..9d8e5916e7 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -752,7 +752,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
+    mc->default_cpus = mc->max_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-- 
2.53.0


