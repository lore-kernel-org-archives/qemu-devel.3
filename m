Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2E2CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjJ-0005a9-OR; Tue, 13 Oct 2026 21:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjI-0005ZP-5T; Tue, 13 Oct 2026 21:24:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjG-0006tZ-N8; Tue, 13 Oct 2026 21:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pitV2ZK+JwVA/NboT3AbsX4tF3Mr3u9N7fRxUDZsxAXHhJ28n1yvJviYc8dTH/+vIBQhSKBmlb/6JxcDEXMqlqRKNNQPgjc9oo+AS/iT8nbPDEZaQsW1NNd2FzCLgM4CLNHkSJRhtV4QaEIvVLYgLXbhC98pdBUmq0vvijQTJbal78zQX5McMsW5e7oHJ4Qs1VbiALOAKr/zkfQYlV7Wm4e8ZhlYKJ9SR1YVlA3aEMYUOMA10RQ+JymlGCEbLJcqk2Su33o/ka5ZLCZkkJcLi8qyUVXGJFKeTEzW1Ih3mOctPYptNLlcaRO+3qHfBPkDO4YN4UIsRg274KbijX8uXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IEGjE9GbGxoYKfYyj17eRSIkL85nkDRIfh5Z7TBQ8g=;
 b=yaStqC8a8C6qzDdBIMo0mxi1+ht08LpOFRkLTGy2WtnB7tqjF8YvcM9hslLsUwAygHmp+QfrMfag6O3ncWHIRh3Cd6NjX03PgS0u9mp4DdY4Hhibbd/MAyQRrzfAuTz+c2kAlhuMRKNwVshKGc8Em7oG+JKqu66izXZoLrbOmLbDOhjzvWyOf+M4pQs1KGVtBsW1qewYfgLgnt1CT7sRMJRhT1wWiP47gxM1mMjlg0UoE7ZVjEb320pDl864lVH+2rS3z1zjuuxZgJb3FdaaLY+CGivXIF2apYvQ6c34SaJOdaakFsdtHPz8Qi/Yn6ACws4fskNdtVK5J/NJdUcPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IEGjE9GbGxoYKfYyj17eRSIkL85nkDRIfh5Z7TBQ8g=;
 b=d+xQSkB3Q3sgHXX/X0pOf0+qMeG6WaUosf3uMXJRIzRzphe5soVm/VuevJdGNFqNJUMhsjIV+2SNX8gvCILTrcmArddx681XVhkLCibI7jHl7RCiwEWnCzZN28Xm4lo0w5oBKNMiPsLBOTk0zrVilxHMtcjEK7gmm8x6iFT4DnNM6oBfKFNXfMUZncI2HsedEMgZbGk8AHmYcGMNjMsnz2h7haskccFy/yRux+m70ftd7S/ykr0z+ggCbkBqEaXYd/p3hqxCtFAxPgA8CdTr19860zM5rFsVs+YAh65O3jpTS8F2s0JrRqanh/ElkoRrpvpjqsC7pCVuyS8UcM8ydA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by OSQPR02MB7959.apcprd02.prod.outlook.com (2603:1096:604:297::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:23:48 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:23:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 01/27] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
Date: Wed, 14 Oct 2026 09:22:41 +0800
Message-ID: <20261014012323.322790-2-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|OSQPR02MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 88642810-6c26-4830-621f-08df2991cbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kl91wh0CwnZvKZoFMRCOnvFGwuFFh5ZhEMsW4U3/QIE+O4s36ZTTssFvVr/j4OVu0tT4IzYXIvuZbEFSAa7Z3t36qSSDvnvX/bVHDAq5iOig3h6gf1nnqIcY0u0b+kLo8phVvoeb+k6VG6AaoaReVPVGQZIqgZo7t7yhjT0u2Qq++DG6ir94SW/lNblUoH+x8GbIKRJ7QVk91l4U+ystsAKDoMHHqEjDY7pMRiQVMnhN+2xlqCBmL7psINBO1IC+AO+62Re3MUOkyRbVRbnf98neWW84x0M6hfne5y6RMsO669p89DSP/EGTHTqXSSjyqsPdB+qBrNas3YzIwmvS8WCbS1F0JoYUgX4x/Ae5tQQWA2B2F8oQVKFolrNauwlBiX12qPamvi77QRXFeWhRJ60tWPd0cI4pqwu9ekxyfX8d90Xl1EfvGByzpgj8Ya2ROm+NcZXGdYGjCvq4MPol0c0fK7W3mfMtoNokh4+N/o4n1qi2jmWnDV22OBAL69j5+dcyFB3hd5xtENFvazKym/OWsR7LRJ+39IIcj5nUI55SSIEvVC585Y8Sl2yIrMbuz2KfempfQmwNXxYJvYdZ54xLVWbDVU5oTtc3/bEDIIqjC02CI8JyHB557A6RcoFLyfeuBAX6soQs6sqOBS1LTaxB769p4WBzqEQ+3Wlq+Ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGB+yU0l1uETQbm4vLVBpbumECzEy9E08yOxdcz+7aeYDKHezPufCL1nbwil?=
 =?us-ascii?Q?cib6EmMpgIw+hfqqZFqyhZy3loZrt0Nm2RZp5NSFGGgAniuXVj7kVj2Kj6NY?=
 =?us-ascii?Q?E3X1aoRqaUCerXIH3yTDsM6riAR+vE8xtc9evAMenMTrVzYP1Rk8ek2PsrUo?=
 =?us-ascii?Q?aV8yMRM1V1jp9OKtCdExtfINlJm9jWKlihJn7cQjxwzs9FwsjOz5cVjoP3JT?=
 =?us-ascii?Q?egmo4uicFyTHBSwBVKYCcsFBATqWEL66FFFLDh7KF6SARHuR8C2SwCyrd35A?=
 =?us-ascii?Q?IATJrENha43VS9g6pAWsNbpE0kkrTbBZTe5r2VvuNEehOLSxmxZiA+LnhrPD?=
 =?us-ascii?Q?u+Y+ItpO0eQpx0E6nWFeHzq8UAW/Qp5RXWDxPo3xQFv4ORb11UOmT0V/6sS9?=
 =?us-ascii?Q?2m6uWBbFHeGvHF6CCDI6WdF4lOemcz24bnFbNql+57MgQDRrNQlHWGmJXD/d?=
 =?us-ascii?Q?q6Dku6o7ErPNbaMkQ5eizxNZdBonr3XQihZkU1HEvjE/lEFDKYsIva19svFn?=
 =?us-ascii?Q?Lcit0DVo9BFohkpQPdK8pTyqXxjagTg/CAh7R6u4fPDvCo7UAlf6NEP+lSH5?=
 =?us-ascii?Q?2vW7lD1REr61szU9s7foz5UldbCvdIhdfEQ4ziWajfWfvodHU2oGpYNdFCEZ?=
 =?us-ascii?Q?hBaZwYJVHTq18zqDBhxI3Z2uEGQCI6rtPyBRvnLmMxdENUcr2bl7FowV5qT3?=
 =?us-ascii?Q?WeQxJPLVawJoui5KodSTTuVOyeWZSVcbKukchPggGaYuLc+xY3Jt91qgGhQQ?=
 =?us-ascii?Q?mjxiELk8+wZWio5wRCkOyJejp73G1nWKmbhGL24zVpTYXvaW0gYu8PuU4R6F?=
 =?us-ascii?Q?iW/jE6mDW8Ja/NeZKWBNvSRwNRXHenKz/K9JCrwjwRRHCFfBRwJ8jdYsRyJA?=
 =?us-ascii?Q?qupAPXIA1Bai+Yr2aHvzQ27L9yRjm9ymPMETBDqKW4or9vUHaYi5RI71aR+a?=
 =?us-ascii?Q?F466lwd5Ke3ecFLLU/rif3HYOEnZSMCPWGs24/QXu7F2FPPnrD5wlNB99spD?=
 =?us-ascii?Q?YwdVyS/6fc15WdgRhcE+p8Rl9NoRoab0BAuUdKCMPD9OAQtTDg7qPHuTj1Fh?=
 =?us-ascii?Q?le3OzS0dXssM9KU5XW1LIE/Hm+c+VDUtaqNbeL4jE/ovLM8cyC/HA6ArLlCe?=
 =?us-ascii?Q?XezoGwZlc1fgbR/ShPfZnZ/m+WnhHVvpUeq9OMeBXdxWhqgtOeiF+aezWzHk?=
 =?us-ascii?Q?4twvzi8BeaxloqgWXdnOjY4E8xkY3ILgouk8lWnq9hUjEQAdhinI35qdwm2F?=
 =?us-ascii?Q?XZC78bCZYnHMGzwdJOtkGiOXoukQS884chZEj6US5xnAu2y1OH4pHPlKQC8M?=
 =?us-ascii?Q?xyYhJZ+q2/aCoXaKce2t5lTU2NmPbC33omOS8z10gTFPYmqkMJCJlProuR+y?=
 =?us-ascii?Q?P8WVARx6iGvGkowxe8EbLN3RNX37LfFsvhfC+95rcTr32aNJ5sdfeWM7zXKv?=
 =?us-ascii?Q?lLpfJktQCvng9Bv9MY/WUgQ09GaFWxqz34hAtFW6/50YXVz6mnzgSdLv4NIP?=
 =?us-ascii?Q?Y7XHITa2FsLH/W90PscjHwmI31afB2CHPB2Ru+9bc/lPNuB6o8ZoxzfhOsvf?=
 =?us-ascii?Q?Bx/XJenyMIZpa6tjPvjslJEhZThHs0t2g1VxtlGCzlY/54dPxrMSGjaZcEh/?=
 =?us-ascii?Q?D1BdVn14uTn1vimRW6VD/ujQ6pqVsSojJsP1vj/YUdGqZl2cN+Dxmzbwef56?=
 =?us-ascii?Q?fII+bmsy5YLDQ032RuwpoHZUU0ZXoMNLxyA8EPHv+hfNiyIoLyUkhbVs1iNr?=
 =?us-ascii?Q?N50eKkhEyc3ZnNTVWpSKy0KkeZhxEM0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88642810-6c26-4830-621f-08df2991cbef
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:23:48.0410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCOaab9ZaMYd5n2AiwLVkvB2/A21yM9wFOw+DqwmklfReZN+wxHur0eegwPuCD5wZCaP6gk8M+mM+14kir2OVVk8luihoB5R5JiRHVTSKcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7959
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 hw/riscv/microchip_pfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index edd29626fa..cfba2990b6 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -95,7 +95,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,      0x10000 },
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
-    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,    0x2000000 },
+    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
-- 
2.53.0


