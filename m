Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525FCCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkI-00067e-U7; Tue, 13 Oct 2026 21:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjk-0005q4-Gv; Tue, 13 Oct 2026 21:25:00 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnji-0006vq-0o; Tue, 13 Oct 2026 21:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSX9xDMyMeAlNq5C6vEVHOEgTI2tSUn6WO3bBmKeN8lU0B1vhd6tuT8NxABI/bMJzZXX47Jpth9vke6pKp8KG0ibKQEiZUDEKvxwzSLflNeE9/JwrcnZPw2yuFJasqhcbbxKU6+e0v9udwnfXiE600Mm75YCy3oOXCKg27GGrFWzeUIlsgD6a2MYFEPJPeGwQnJqaWOOr/AzYq0NTmrH1BXthqMws3Mq2WzngzZdYZfWLi58dBKa+P++Yc0PeAFzglRFNI+gYtvHUFvUEx7Wv3TpvK0gX0urcosuhInjlQBiCGjxuDRHkaADiwsailERmuqXnn6K+jtBpXh2hJJlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMG2g42Bfo0zJu9pe05IBLFa73jLqvIBiTF2gesWqQU=;
 b=G9HGcmlH3TS+gHQcBC6pGYE4uq2XnrNkFC/+mKOUPBpNvkFhh2l1DJyZq3PMLm0/T7tf7X5HiDLYYPin976qQv3TGn+T69wJd6JOEWfJZAOncS+m4Aoo4N01BFozaRzHBs3EUFD0WyTFxfcYywSkyUhpbGux6tLTpZXDBxhMyRI6cYHxvryqODikNtno7hEFutzJsbXlVa6mkDsO34+L/I7E16cklWms0FEDsnp9iSGditDUvn4PnFU79dFKrJ0RRsmZB2TXDwVAROiJa0aVQdlcBxI/Td54flXWIf9gPT3w7E1xjfjeap95NJCzpvlD5mQlVrXvOsKOykp5ZV02mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMG2g42Bfo0zJu9pe05IBLFa73jLqvIBiTF2gesWqQU=;
 b=L3q9pj7IS4XsOBOmGFjxQNGO+F4R1R6VAJ2lYaRw+tU0ZkBn5aZWjy5z4iRahgjIzaMOGkcN+hg0znCTnhgBlXJGwbh3XuZPfkp/HYmiz2upuo7bTVvjzxocXN+0ztPiER4SLOjVxf/ODzKgC3vZJnoANeCgBgg30H5roT+1b8eiDCueWyWyIJjjSclkfKAVntAjX8LQ/oekrAuuEyr4Kyn+b+Z+2JyTj10P3StoPiHZOdD/P062I3Hu8JP0Pfi6EGuw40jIQw8dcX0lOnttqDvbrPIpO7R4FLCdbHyuoKp7TiMTM71mfOklrDccdqMfHA4RlMKnHh84QfU4t65GDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYNPR02MB9225.apcprd02.prod.outlook.com (2603:1096:405:3b3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 01:24:47 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 22/27] hw/riscv: pfsoc: Default Icicle Kit to five harts
Date: Wed, 14 Oct 2026 09:23:02 +0800
Message-ID: <20261014012323.322790-23-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYNPR02MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: be959a66-d8a9-4e74-0191-08df2991ef86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: V570B9f8Fm7B2tSK+8i0/2jt/xC1g+hPmU8mrutDmAcDoKClSpEsdj138wjROl58t9a7Ngrd0e/6Co70sH9O50qaohSi+E8DeILPtyLJnVwBB6bOjQchSVGs6V9pj3Dq+eifpRKHRPfZdIz4KszUza7LfnjeQSi47uGxOsZ8+KagyTpvdpBfKbjSH9P0eP5MoZE/pMM36srIdtZYTEAHIz+IZRgX507/atN0l41tQMFuVeQLzj3no67trd/74pdSAn9Ehc6ERZDaF1MpD1TZUhkm6bT5b+W9mohFvI1gpdPNNiBAwUskYbzXpnpgV/11pyjdwgyR3FNtIBM7Eqz1a/AWa+STuBacXyIxXSuz+7CFpKwYU4DZKkUxHITdEFqXFLBb20PXfu0u/vit8NuQID5VYbHhxwuBkdZDOfyF2mLZ8STrGAHdmwPkwllgUgm97pVRj49M/3v+N+0boTbONdyuhGhn/JLER1hWHOfJGfcGlscmg7T4586o+du2dixveNwdq9En/VGp1LXrnhPLYjNKTAMTMHUqaydv8mmE6hLMuoRWZIQjqHOb/qkiov2l1mZYTyn2NKcvVItMKbLBWQLfO6eVD97sS7gZzw+zRhQdqdtrv0nJYgc+B3vE/DSeOd1V3hrc2cvregAyqp/AyNtMClZrUB4gQO+0P5A3dYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?boDmFfbN8Vl1lUjxrjlvcIY9IYQefj59zIjygHgvtQ3I2VtSgbkVfuSB7onX?=
 =?us-ascii?Q?Ut+qD6TrmEjT10PvjJJ11+Obxj56KUd7qGuuWpeKfpuCcx/PMP9WLiGDV/pg?=
 =?us-ascii?Q?mEcV6uhy4wfE2nYF00znyX5AhqBVG+wTrcQvxJJuXRIKkdb4l8YBCeCmVvDT?=
 =?us-ascii?Q?q78bsEilTxnm/mi/tSQc5+tE69/IjnDhSWvadXnN3+s8NUk9MFaT5+b4Ta9Y?=
 =?us-ascii?Q?ooPMbKK8yq1hGZZtfqnNbW8dIbHzUjtqtL5jAalxN+++M5IeJy1k0qomBiik?=
 =?us-ascii?Q?QuOIzYFPozyTam3HhcHbEzvFSsBieXwwtfGb81g2ikZzTQ00bEO0myDj5Zdg?=
 =?us-ascii?Q?IAuoXQSGJrvIOvAUtm8w0rmbXdiRTGXr34bCMoivSHEBy3/de3WdpFBQznqC?=
 =?us-ascii?Q?ajIgaO9D/t7NSvCyxWhgIVJb1jaiUTqcHHL0CcJbupo0cyk6O8lEnYH47zAj?=
 =?us-ascii?Q?OD5dB0nJUM3ksYk/5wCQhb73srzLAoHq2IDOYYCCuFvNs2eeNq0U/uZ+dhuB?=
 =?us-ascii?Q?ZLMxJ/EK9EsY5tmHvahjrnN61VbIlKX6LyW8gKI4/efC62CMNZUidusD2pf+?=
 =?us-ascii?Q?fVVGao7P7l+8op6PlQ8Gr6eUfZuU1xJqQZQQso+hrIOwmVH5EDes+V54QThN?=
 =?us-ascii?Q?xEnlqrgJmgzvFU635XeCkq/MzBI6lIULzEvohlyfVlzypWgc2YlUR9QFN5qU?=
 =?us-ascii?Q?jC37Hhc3eI1nkpNkAjDYNsfTRHwqyhaRKQfgu5GXpnR8jaDOp/Bol0IkyjQh?=
 =?us-ascii?Q?nGFJ3CI3ePO43/2U2Mjfu/UJSjyd6D+ZoSOF93Y/aJFBSfobQxfd6te0hfi4?=
 =?us-ascii?Q?ICAY6okMihVltAhjL/vOXwWmYzvXwGtm9ZgvweyG8HgUKxR43YzgvANRByNa?=
 =?us-ascii?Q?7om5Am7U6ohIjg0V8VCnE6Iv95NSNnkPVrfRXN+YlmTTvvni5s2j86fS8a3/?=
 =?us-ascii?Q?TQ9giyeMtyWMd9RcF2eb4SGXqofajHjR4bsgexPTb3TpwhzlxINvaOVyP80q?=
 =?us-ascii?Q?1vf2Da9rarxWQczY0pRk/YDqHVwLrjOsvYqgbs6OeWM8/VY3QLOGZh/C2/tx?=
 =?us-ascii?Q?moBAfYCIbpduckD93jtPWt3scAWxoNL0hXttsC7ftK6Id7LyPoiNLf1fDzP1?=
 =?us-ascii?Q?p5Ht/zbkrQmCBkWFcGTHZUjw9ktDRvv68RxEq4jIVCxysRa38NRZZEKWXwpF?=
 =?us-ascii?Q?mt/1HBJyaW/aRaVSF4reVDMToF+rx+9+hGSKitGz1Smm0IvBogL0ucUlzplp?=
 =?us-ascii?Q?9XTpvo42JijUkUP+OWKKHuMBz5OHKpV5XxOSOE4u80arVf3ieg7Osl5fb4bH?=
 =?us-ascii?Q?HDLQH3u2cpMZsXmD4ZLn7pw7rh4DPVpIbhCey+JhAymreJXde5A9hDv3Sm8A?=
 =?us-ascii?Q?wEALwnpfMgwbltb8g5I6576w3oX68VWlVGSivjeXdKJeWG8e3O5n4FyUQ7w2?=
 =?us-ascii?Q?J7C34XzQ8BfhFecXW1zay9xejvhaKeF8vZMI/YHx+B1+KPnGBksG4DoQvukc?=
 =?us-ascii?Q?yKKbud4FBQxtZuAZMaV5V/nbNCDhTzYePyErVgLcdi8B1gxmQTutatXkFQ6Z?=
 =?us-ascii?Q?uC6jqBkDzrcFmRkkCG2BpIVn+Cky7al6PyJH/KSwNEgCGZ5l5Cy2a5cpW+u6?=
 =?us-ascii?Q?GauiAHT/u/prg9qbF+FY5JCLlkWTRDWYv6JEn4T72MmWRJ0yjyBtYRIHsZY1?=
 =?us-ascii?Q?9yibcMXuqugMo+TOAUq8Jia+/CCqd0WgmcL1BXDFHGeKw9NfXAkscKMO5XW+?=
 =?us-ascii?Q?r5RSH9F1u3h03vMYrhkoLUhIaCIfMRo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be959a66-d8a9-4e74-0191-08df2991ef86
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:47.6921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lXd7jOk/maJAtO1pCRFDCR0kZdUpw+qJncXEiuZL+ELHQs/rLKspDjtF5voAg5o774s9SiwqvsmTQiUYz2b/LouTQaYflKQtf8oCgDScNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR02MB9225
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

The Icicle Kit contains one E51 management hart and four U54 application
harts. Defaulting to two harts can accidentally boot firmware and a
device tree that expect the full five-hart topology.

Default to all five harts, while retaining the existing two-to-five
range for users intentionally configuring fewer application harts.
Document that firmware and device trees must match the selected count.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

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


