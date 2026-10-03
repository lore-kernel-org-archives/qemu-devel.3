Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D8ACA5FEF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Av-0000jy-Bu; Sat, 03 Oct 2026 13:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39V-0007Lx-Rh; Sat, 03 Oct 2026 13:04:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39U-0007Ds-6j; Sat, 03 Oct 2026 13:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0+77mrKImMr7o6ath8+Hg4729o9r4KX74B+rPdSb+fxqNeiOpjAG9BYLLgAPRDrNHRdgZb+hHny7ToCw7+RtYK/5Ux3DfaQSleg0eweUIf+aPmnEXmOvIr9ve1zTqbfLpfyVZfxcR7PgcTacdG0gRgIAHe4NrtVNbDaCYguBKA360HgC5ERte0/UpjhunL78poJsMfugWiMC7c9HuKqm1UOzP4VivYRJyympvHKrbQylaqQPnjHy964F6R8VV6FkWLeh+Ywl3wTtUw+lwgC7stJfIy+4KFXbKKQCVn131MtVcCHzt/A0a1Ki0Sevwy+M5YcCsTwBsbA9oaJbd0fQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89iqCNNHUDuuovl63SEla+2eeBXGO3S5+OFTMr+AgTI=;
 b=kSJDXdD6ubbrwPN/DT48WlJg2zNrjykY+kxcqI84z+YGXMdFj7kWUAkjb/L4J0KDqcgkHu6CnHDUwjipWcGTeyLfltDPhtXgEeTGSCed5fdh/wnuVuOIYJvIROHiPjFEbijuoo7P5QMC0SJeDGqH5YBO/Y2gezKviQtl77vjlGu8E47aoHeSvBQaEBv5THTKWOcy5+yUR/Ggy1og7yvbAYMMroVgyT1kXE6uCKubTxtllIla3dXGYR8IgwT45xHSAMs/SlmrZPdamgQzRsP7UMiy9BwisZWQ89USSjEUX1tw3QA3Ee0LF7g0u8aW6d5P3Lwf88U2rY4g25A49/2s2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89iqCNNHUDuuovl63SEla+2eeBXGO3S5+OFTMr+AgTI=;
 b=FrdAmT539qIjs9A4MFbzCttr4FtWY+U2LX7R+9tIMKGAMM7mtrEcMhlEWs7d3YxwL90+TYmRCa3//h79tB9QvNORcvp0cxChahDppBfWuEmo+B06CTki3MRRPzHdBVKamK8YfKHGwO0NMIXBfF3LesoJeG50Wxj1RDgmhmknqIR9dBxPS5DsFX6frgmiEi2I0s8Pd+ZxwORE3WAfxyvnuBK+2Hyhres9WJTgP86jKyA3za8CmwNq+akU8vFIwYANJPfUgzy5O1GPCtnik4do2jzCOtA+oa3nQ9IuMnDBxC///FRF0ii0pcrnOSi11j+i41yFj998yXWM31/kEMZwZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:53 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:53 +0000
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
Subject: [PATCH v3 21/27] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Date: Sun,  4 Oct 2026 01:02:11 +0800
Message-ID: <20261003170232.2450916-22-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7fe99a7d-0ab8-4569-d103-08df21704de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: d2jkUqoDmsTW5XMFPqFD5uECqFTtLH3l/dycHwSpUPD4GuVaX5qGCydF6FBKgqVirEl6sQCFSoTMZFp7vSmXVRwdQOmdX3hO4DduyBg7W9FSZgwO57tA8a7tYMIA3fWQIQO2ftTlIRQJNsOh9VnnHm/PMQtEgIxZAHy6tDTX/TCH37O06Hdon0UC8Qb1njQzmrSvivoBxgFwvwmbaIgK1/3eOzQRR4f1fRLAFHvAeeaAzIClfHnSk8ogvtuWRUgcC9hdddl1LmGIn8pqQvpaCr2rN1bzzMP5FS+6ATSAumIhbWssMOJfsS4Aw01jqySWHRX6JRGEEfIJwiNiSyI49SdwvxNMnttOPxG/pIy5VugCl8YQ5itl63sG+4u2c8Nu9FetBqkFW9RosqCbF/Hctg7BB0DdWur9+a9lSs6YRLQtRFn/JoTlWyQSj9GtufU4tZ/t6lXLLkoNerrQ+79t2eZutykR8xApR5UQMCYxZM+FcURK2uBK5fSC7kRkSpSLDBRm/jpdeeSZv8n+kY6J3XFfjtiYmj1CKgVAAAClKHCjC6gSpvmU5mQd2zcEBrlCFGffyJfcjloC0KL00ZovjomsulbhsLJWU9Pj9SE/+Y6W/BvqC5fuN4Q1KTSpuX8NQH5F9cCyU75IswSxzxqOOpag1CY5RLlmsCg5YsQNFAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rafUMI0b6nRUN22uzJB3zMtiuXdxeoUkkRRXo9McRbosd8Cv7OWSoTuvxgJr?=
 =?us-ascii?Q?SatfOv6kRw1FDKryteKiomDpSvTyi5Bo0FCNoPK7ntqy9zh9M7puZb/GczSS?=
 =?us-ascii?Q?ZBh0V8YHqVEOBLb4uGojChANOnsK+fyk3lclqxA5Kt3ip3eM+aGZlIfGneaI?=
 =?us-ascii?Q?1pGm6Q8quhFsXVWOI//cAibRjgp9uhp2QTRu8csAh5P21uRqFdNAYlzHUfR3?=
 =?us-ascii?Q?clOATUzAYc0Suve7P1du7qFEl5DSfnq+4cF1iXtEkkJh/KQkKZyd45h+9d7N?=
 =?us-ascii?Q?DUr7qjK0iTCWsTpKhMSajwE2Hp5J9fUOhKqWU31fUhqHw3hFlZK8qRF4oISC?=
 =?us-ascii?Q?T2OwpvPJAvCnIoTV9qufcUwxKRZe937oKueeik6a41+MtBMkYczGfti+6FlZ?=
 =?us-ascii?Q?IUzJi1HgklQVtDI9lo4R0eZaTa6C5P1mYxfyyOa/4CkcxqYh1V91DCjI80y9?=
 =?us-ascii?Q?mUBjnFCt/VHR0lR53G5byVdWK+JCd2WWHG5tUIBqICR9AzTBo7BE4r8t4sn1?=
 =?us-ascii?Q?4FdAZEbIuRcG8EHAib56mWF85h9yfr0kIxNMEskFhiX2jq9F2PuTGTRBnF/J?=
 =?us-ascii?Q?CLIlWszWJ7+Uvb7vZaGtt8xC55k0+nO6om/CCVGgEHyl06sf9PRfpAQwwYmJ?=
 =?us-ascii?Q?akG/bwiHsfdE04w1yeHLpi9mDSuo7QzOz6bweFT3ERP9mwjc2Xfv0n6XDuhg?=
 =?us-ascii?Q?zGZPNoVMEbePcncYY18kCG8EiaivauLjV1ZxMofBZ5Pq9qMSBT+9XOwKCATu?=
 =?us-ascii?Q?rK6SXptPav/Rsev4LgW3AEhtfrfgX3nR0ioQvXy5OJ0mRl4D+OxaZCZtQFZZ?=
 =?us-ascii?Q?ZISyQsWas2eMZp7j+U0e8WUE1/hVaLkt8yfZxUw0Ae7n6dxHVgNWYLHV6z/F?=
 =?us-ascii?Q?PEHaXzFdQ6bqnvEtIuWwHq+Ln1lOlLiuoMfXKpPQpBSlEVwNnvyo1f7FN3yx?=
 =?us-ascii?Q?mVLqkF5cGCOHswjI/MKkSpcBrhHgwABmBTetih0SkP1ioUkbn05OQNtnfBS/?=
 =?us-ascii?Q?q5DwZOaBGNCnPCbeNyB95KxbfR27nGLLc9Yq/9fZBok170exIoKsaI2k5ls+?=
 =?us-ascii?Q?+IYFd2hhwV5AiYFLow5cDumh/xFvA8py2cEP0RvvYnEEJ2fsJYvQUr1Vyol2?=
 =?us-ascii?Q?7CP1bp8fFa4+pJRFOFV+Qt2HLLP3IZLzJ0AsUvXJR84qGP83hrrc6Q/ggmMj?=
 =?us-ascii?Q?O0z9p+Rhn1/bccWsEvicINBEbIJ9i1VZatAOoBveUM4T08URnSHZ0EX3zHuW?=
 =?us-ascii?Q?0wyXGOb/WrLZBRp9TrLNlycm6A8f6Qs3SP2Lr8QS+RRa04m2hqoldCNxx6pw?=
 =?us-ascii?Q?C3LnRBvQPRNnko+WrKtEW4fS0+63UfSoHKAosAlR60fUH5uUyDbam9/pdCSm?=
 =?us-ascii?Q?qJo1BiwGQZSoQ0fPPIB4QLB88QaGUPsPl5mytap5MnvSTJAFkISNVsW9nVs3?=
 =?us-ascii?Q?dyrpxPGWeee4/A9NHUT1h2jq3v0Qc6I6iTazpIkP9f7/oppSHaf4TawobOYD?=
 =?us-ascii?Q?bRvBN/2iorNDHSVPGq+rqoXX9ahEvNho2Ic9cxmoC7shuW5t0+gUgbUyFEBP?=
 =?us-ascii?Q?+/1yknhBWLkvulstb9tHwQpFxXnkyLqtzclwwFV01LEqpDLgXEdlD00sEQ9P?=
 =?us-ascii?Q?bsMjKCWpnQs8YVKIPWqZcTyvlTob8i4Ral6swpEhNPX8RNJhbEgiMcgu6/+r?=
 =?us-ascii?Q?3XfV/4c4ZCTdmQnrcRkg8kJ1K+MCs2PaJsCYEvra4KmNM3CouOptJWIf/iXu?=
 =?us-ascii?Q?xG70fBh70xmW4F3kO8QqeRmpGl9Cd+M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe99a7d-0ab8-4569-d103-08df21704de7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:53.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go3vnNvJ94Kze5mRU4utriaIAXJeL0yfjp3cvPrAnjW6zQUU5qpC+1N1847eAIEvkqg/ExMEE6qsUGbrYH3eoG+sJ+5E7H5hZD02X6IuMzw=
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

The Icicle Kit has 2 GiB of RAM, and its firmware device tree
describes that fixed capacity. The model currently defaults to
1537 MiB and accepts any larger size, allowing configurations
that do not match the board.

Set the default to 2 GiB and reject every other size. Update the
documentation and L2CC qtest command line accordingly.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


