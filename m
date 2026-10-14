Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21921CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnl1-0007Vm-SK; Tue, 13 Oct 2026 21:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjh-0005oA-7p; Tue, 13 Oct 2026 21:24:56 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjf-0006vq-NX; Tue, 13 Oct 2026 21:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+eIeAABmqx/lxY/4EErfmEkqtip12qD0MGC7lQC12RS1PbQ2evqUcfo6lcqmolqV2OzRc1baUNQMNzuRIrP+bgiQidgtHLxt1HHoCxSIZT1V3qnhS4unboEKct2xlr3XwO78jrHc220lL3Bdg7OpOLGnj9L2Kl/A9l3IKPsbIIkKbCLIs3Y7QTIXbwAzCxMxedLi/TSE26fX7bU/7Ae51NnE65eES48F+naeYk3H7Ai3UrOLDAGUeXWOOT70hKo5pb23xNuVUvqP0+GOZghdN7X1eG3l658osBDMzOvAapJaNHjeBytEqARQUtK5sQKO2yiZH/fmsf7+PR02V5Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+EHnpiqqMPBFirAVcpuieI+/CDqbB0sidivjTvbn5w=;
 b=h2A8IssUJtN3GpVWfwdj9HWMi72Kd9aF2KOdC69amsyJEil/Rst9dvoO9GtrHRTlbujyrdVGU+SDTr1yZ+Ukt82Yn+qgDcpmJPRYDNR0DH7AOKDSmTX/bvHYmd3IGgKycPXW66pOrmmB/vPEeCKxYWviKV0AKJY/H9+BWqdL34Iekg28UHc02EpFqfjnb8I4LV42lxuL02uamlB+Emv8BlWIfeQu+kXr2+Qa0bM3ifFYavH6/HL+CAkiN7PAo7nnZsKBnJiL8Iyq6VBO0eB5vzIZuaYAYP7zKgghb0i7Ve2TWoRbnV7djVKARtBVpCzoDnrcbb7OYbtFHknS3uU+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+EHnpiqqMPBFirAVcpuieI+/CDqbB0sidivjTvbn5w=;
 b=IU6EyZMoe9O6hH0GVxPrkeZ1aP/0tj+hPRRmlDMnZSAUj4Cn/A+8VreCd4iiC8BG483ll+nxPGSavq8lmqsxtoMieO774WIMAkh9zwzTNYx0ySUMdFkDCFJ9eSvw+8vM27sCYQb0Squfh73xWwmwGmbAbWZxyYKzAGjAJK0CHUf+vvBEixc8mE1RiWMMnCrgMxsHCKzI+A1sxRfkzpIzyWzUXCcTRu+3JPM4NCQjL9flGb2Hz0mgThcRnPBTEuXL9selfc/zrklN3N2sqZW5JCxwgP1lFUEYb+c7zzWxjwZw8R7VgPcGDMTK2rpqAsR8vu4AghaQwhQmqk6/qr6Fdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYNPR02MB9225.apcprd02.prod.outlook.com (2603:1096:405:3b3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 01:24:45 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 21/27] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Date: Wed, 14 Oct 2026 09:23:01 +0800
Message-ID: <20261014012323.322790-22-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 556b41e8-04ce-4647-459a-08df2991ed7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|6133799003|261009223327099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info: N9Lk9mx+bJVhQJTQd/RaWphZHaC9z96bbUL0Sz9NwhZ/hk5zNML94C0FnGZrzsA3tCSw2WG8j34/kWYIxOdXSUgmPOVSXU9FiOFMnL7xZxyvtSS93OEYG1S0eitTQ58mxqrBTOEG7TwnYLSPqHEn8cZxaIX/qIWUUPwd8KuNIeNQ5lgibtoysFkHxt1I7P2C4wGfjLIadISSPsrfkU1veXre+fHsDjp5ss94NDJY+HYQrCJCLYSLanvJO7aSs7K91FQiFmNuL9y7T0EXjQz/7iZE5KLj8zw18ifsk7vP+YYVOoeZPqX/T557P/6Xdcpu0sGe4J8rsCmeaFZ0X2zOf8jR5/TgH7RgLwKClBgf3byTHJ4qpIbkbjmwnCv+yW5/GxW5zYlwQWi5rsZwywQShmXoNdU8UVXKYd+LnC+eIZd1gO6J9dQlcRx2aa1iF78J8a+O2OC0Izp9W5Xbc4gt64fDR9urLB3Pm3lJi5kYbHdO/BETMu6X0/QgCtL3tMG6OyZ7j/72rmfWANLYpSo/dAr0pbzQ5H+582IwVr5NeTAbXQLdG0VeOCXvOg6XXF24WBDsdokWRDMZm2kT9+FLvRcSeAa35jLVvwp9VH6ABJqhjAKmZoLj6zn+U7e0TxUW9Z0dPI7Xvu/xtJ3e2yo+G9CqBta3CYs17K+TJixgP3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(261009223327099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqmOsNx5wChmhE28iW42klxsgF5PaVqF55npxgSj6ZE3NkAUPf8zfNFkARET?=
 =?us-ascii?Q?E0tPDqAREChddaNjm9v5hMSG/B9XliCZXfJCfs6pZ5UYRq8kBwJSFpYuSqkW?=
 =?us-ascii?Q?EStmPp7TLEQ4mpIU7yfCDRWc86Iu4/M5BPE95GVxsdOMY8z1KaBYCQdxY8t1?=
 =?us-ascii?Q?OKv+nibEX7iA+jda3A3g4BUJFcIGSskDeg46j3fFpHcr7nx1MmmskxksEM9V?=
 =?us-ascii?Q?ruv3iQ0wLbR1bDcUTdSmaeS+AXoDziaESRxgGm+AYTX09dkn1unhiv7QQrOG?=
 =?us-ascii?Q?yHO2nG3XefGB6TGz3xZyKbZkQtldpo/J8i1U7ZmjoF0EB/aJZHWFqaazmoVz?=
 =?us-ascii?Q?ZKovJG2LLedUrbCmbYml4rGXYCfzuPgXR3AZUXYgjkI3G6hzAWVx5ziwINgp?=
 =?us-ascii?Q?mUWi/GXWF/JeszSh0efU4nJKh2vFD7AcgdcBR19Cdo4XqMEAjMzQBKrD1cjm?=
 =?us-ascii?Q?ZUM7UA/AYgAYr+LjN7dgl9K/QJ6t02mmgfB6hzyQCuvWUCOUQn6N5sPxzQ9L?=
 =?us-ascii?Q?fLbik/5COQ65tpaBwS79TgMByLb2xVOZFNpDjwkOU8reflFfFUFxj7HZDbNa?=
 =?us-ascii?Q?tHqOaqh06u/tpY217yv8iryuDmXPgOs3GGtEutNZwhM7QrbAnGn/n63vJ/Fk?=
 =?us-ascii?Q?UOJvwOGDvOIEE/i8L2XOMRPRxrlKrhWdW1wmzj2utCPWK2ZHV/J7YPpAOaAV?=
 =?us-ascii?Q?bO7O+YOskPvzpmTZ7RL/DjzpOyWvA77kf0FoLjyia+6jXo4Au/EblgbAD0AO?=
 =?us-ascii?Q?iqqkoSwu/WKcI7FAcLzVNL7hwBLxSj1+CoZNUmVkpTF/AYkD/tTDafCN/RY1?=
 =?us-ascii?Q?Bks9tBkL3uuhxFwYWd+AZHDRQQgrxdrmk5xL/uK+4jcBpIPCw5DAPozfBRoN?=
 =?us-ascii?Q?Z/kApxnc9qZTHEvoRHEdXBSy8N1sBUr0/zKti65AabxrVilcj+Lso5EohtwB?=
 =?us-ascii?Q?yOS9j72ZDrISUIzfw4092NrscPShjscFXxbRqgeRRQHNICxW+C+ropjyBlY7?=
 =?us-ascii?Q?ld6HTJwqoNFS2bf4fiKqK1k1o3QjJ7Hgp7hfgVSdifFHGH3FooaGdT+tTRyd?=
 =?us-ascii?Q?YIjfHGLd83tKWhvFkxhIZY12LRNcx1N3+/3nj+sYLHUOEXsT6x0GuVoTv5UO?=
 =?us-ascii?Q?6qigJBIFZbztteSl2jh+ahjQZsRSp+PjZX+U6YzNH1YltoPRPv2nV3PwmQPp?=
 =?us-ascii?Q?V4vEMISti5aEo52bOBxF9soQPZO3vz/xZLjkvO0qmph/B80+sA46PEwuFLn0?=
 =?us-ascii?Q?q2FyCIbk8Nz0HCmFrZy1WVVovRNQddkZQLpeLVXpnfV4e6XJl9aGfhp8laIK?=
 =?us-ascii?Q?wFETvPhPAzP0w+wn8g9hyQzG7z0/5D2l0dtH/dUW9leb9RJIwNHQJF6pEmL0?=
 =?us-ascii?Q?queFcXbm7Sd2g1Iu5QdBD30PIkHpyo6dA94r7Qj4u3wiCgrKV/Fp4Ih1XQz6?=
 =?us-ascii?Q?OWwPFkPZQ4A8ljlmWbogPDubUHPZfPtVgG6SRXLUwxLKX1rFOAjs8GPMHrcW?=
 =?us-ascii?Q?bcAo8aw6i5O4YkPEA1ZhrD0PDU0DlNa7rDnsljSNQ1+1He8WKeHsjutVUvrl?=
 =?us-ascii?Q?4ofXUwfSIOAHzxGfBvn8HbwiDaSfhNv2fmBgkTRl2jpydmx4WBPJ/aZOhcDe?=
 =?us-ascii?Q?qiRoOecAwowQ++nyQD13xckumCm/mp2yIXTPTBVaKvOYR73bM/mnyIgT/PPk?=
 =?us-ascii?Q?W00DQkMPMM0AQkwoEE22V0sD7NmULj0W/hz43pCJlkEkYNq6ZW6LPUL82WXW?=
 =?us-ascii?Q?AEXe8sHj2XJqgg5rLb4rjOxO9/49qjk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556b41e8-04ce-4647-459a-08df2991ed7b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:44.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc6Xye2ETZMhCcoAS1vYkM98Wey3QVcsRq3isquSSmmqRctdmKatWdGefytiz43t1DSttBAbf/qSb6z6bR47PPsl0bOhmi9f+K4xAAahtWg=
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

The Icicle Kit has 2 GiB of RAM, and its firmware device tree
describes that fixed capacity. The model currently defaults to
1537 MiB and accepts any larger size, allowing configurations
that do not match the board.

Set the default to 2 GiB and reject every other size. Update the
documentation and L2CC qtest command line accordingly.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 docs/system/riscv/microchip-icicle-kit.rst |  4 +---
 hw/riscv/microchip_pfsoc.c                 | 15 ++++-----------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 7fdb96601a..b0ad24f174 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -26,9 +26,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
 
-The memory is set to 1537 MiB by default.  A sanity check on RAM size is
-performed in the machine init routine to prompt user to increase the RAM size
-to > 1537 MiB when less than 1537 MiB RAM is detected.
+The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
 
 Boot options
 ------------
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index eea2895a0a..855c719f76 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -541,10 +541,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
     RISCVBootInfo boot_info;
 
-    /* Sanity check on RAM size */
-    if (machine->ram_size < mc->default_ram_size) {
+    /* The board has a fixed RAM size */
+    if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
-        error_report("Invalid RAM size, should be bigger than %s", sz);
+        error_report("Invalid RAM size, should be %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }
@@ -756,14 +756,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->default_ram_id = "microchip.icicle.kit.ram";
     mc->auto_create_sdcard = true;
 
-    /*
-     * Map 513 MiB high memory, the minimum required high memory size, because
-     * HSS will do memory test against the high memory address range regardless
-     * of physical memory installed.
-     *
-     * See memory_tests() in mss_ddr.c in the HSS source code.
-     */
-    mc->default_ram_size = 1537 * MiB;
+    mc->default_ram_size = 2 * GiB;
 
     object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
                               microchip_icicle_kit_get_clint_timebase_freq,
-- 
2.53.0


