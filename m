Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92714606A332
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=VgsujJtX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeMc-000214-2I; Wed, 04 Nov 2026 12:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLD-0001Bu-3F; Wed, 04 Nov 2026 12:00:05 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLA-0002Un-UR; Wed, 04 Nov 2026 12:00:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK2+oklcsC3yB74u2mlORnO3euRxS0xlh6GiqfmkPYD6vUDQ12CxOpx8BN7wIUQVZDE1ACOaKbGbNY3dU1MsE79I+eoOwSP/5emqq/+KaLBtOTMtdyRJvetg6IS9hivTqmEhY7sATUptc/BKrZhHrLdCS08vmhHsaaRrBBaKzvQ+SbDQCbojKOMRlCRbzULrqn1PQj7OKl0KBUX2gRpRsr1eZgKPxabv8/3OdCaOJ6btFbiDadAuqEJpxzOseVp+KcaF/vq5G8Z4Meqdb/NZ7hBsii50bKJkOceIUyGa48v4KNly3ON602ad06630LiHTR+n92LHnDi7YNidjhfbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr8d47FLrEoNkCblBGshe5O4yFUURKfqAz82+hpGQ+s=;
 b=PScgmZpCHCAGx9rx9bL4Bco08x9ZvWLXLKSWc1p14M0CsywQ+OKC9HZiQMWWdzEYlHy5d2YdXJ7dh42YVezeqtYQFX6yr62WjkQksnGdxK7sspUVnCAycjfNQSpqnQFAEdlAbq8c1Ch/p8RqkLERKPzVDBO056G1DEFlDe38WAHvvMoZ2MGc0I72zfuhLtWkFR/IPG1816CKavGPDIyFH+5UXT62HQKc6kjFSUbjnNS/xevl0vDl2zJH5Tarx6vhNyxRc7rRgsZIRF8hbvJWK1Rqn2Ktqi5aC74xKGf90Ny3iadlttU3u5u/E5ZnQfT9mmhfzJbqys9o6h60LaS6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr8d47FLrEoNkCblBGshe5O4yFUURKfqAz82+hpGQ+s=;
 b=VgsujJtXt9363R3WiP37IoWwqqWSZ/XIROFUesVHVEMhQQVMIjSJlPrGt+3Qo39wcYxUbBS1rscNASUViGVsZ6oilLv/De59Ksi+PVif1xXsfW+oJwPzzE8e5S8kFh+dUegeKxUsXE4X+0LVFqe/JduAPClxNQiG3rtPPux7uUMBhXTrx7ZiYm3YmGtMpzpve/FIfMoImWO+58H0dtn0NdStINj8vWORmEIeSpVt1OcO+v432iU9CJgxyVumaB9Ds1ptC/No7tTWyEtDxBz1ToxEWpfe4fDs+R5CnV4olVRynicugNS5QMFzwNKm6QvBFulJfmVcG/d42CpYnUSp0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by JH0PR02MB7899.apcprd02.prod.outlook.com (2603:1096:990:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:56 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 08/10] hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and
 uSDHC
Date: Thu,  5 Nov 2026 00:59:20 +0800
Message-ID: <20261104165927.678833-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|JH0PR02MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 529e5f17-5c8b-4db3-63a1-08df3a950d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|261021121427099003|261022105027099003|261021123027099003|261028144727099003|261026140227099003|261009223027099003|261026121527099003|261102123227099003|10067099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: 9MfWr8hndtOrmDoh4bi8wzo3lbBxdRZaMmuYIngAZ/+l+zm/3tfRbLcqmTc//lAD2RIuANd9koAxE2KN3jWrIyCzuT3h3IJUTXW56CecEA0UzuRwEeXijYBibKCuHyp5sI7HCWGJhXcl19SvYPKzxFsTXdFAhUDOCwY8z2ZRhe94N75QBMD60HQM25oueDwvGSrOsfjIPsmZLGXBXfKGB8Z5lgcCsoE9TTrxNjtWcvdbPb+FJ2d1g4+/wyU48FWUjcioU+3NgbOHjKfSC5Wg3bdwsdujYz8+ySE1S1NkHC3+FDwiN1oH/ybjO6J1kuKag+3cnRvOOB3hBlalgQOVhsMhUjwFrhqxjjMWJ/a65xm+DEJNsl/F9wi+Bnac5v9JWISel7qlDIQirLRS6XVnU2PCi7tlGAPWTbiuUv2SULCCs/d3K65zLaAwJg/rNoEaJJVaVYahbo+eZHK2tpWlIEcs8sDe0MW4x3p5GChyflsC31gvaniVWm5H6rIKAaSVqpz6mAaFBwLD2G5fAiZe9Q2xhKjzX0Eh0vLvgjtxWJJoiP+zmemM1LiWKJ/0vzGEYbPAqUWLc5UbtJiv2oOcJvGnF3imAp0iaMrR+RCkiA8QaceHIC3cvpv79WT6PdiJuWOVbLwb0gNNOFhPRBibPffkDrcuBaOS6q9YN1lyjyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261028144727099003)(261026140227099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(5023799004)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xWh8cowpgtuBp701eKT78FNAJELOBHPYCX6e/nS8iPrA4IBFLAUkzdvhzGAs?=
 =?us-ascii?Q?E8JJvES+RoRvAySYUabFdOxGp5sV49ov/fSrOMOt1sYWCH86i/j+b0EVr52+?=
 =?us-ascii?Q?HTnTwK4P3XAR44L/w0eMSdZqCTBmwf4HhitG5evonLl9u2xXiUchvJBbEvxd?=
 =?us-ascii?Q?dcvFohLpA+MxRCQB5eBqeqRTVF3V2IipO5n6ggiiPdp34y7yI+HY1sRKs/72?=
 =?us-ascii?Q?tQ8lScUuN0lh7ltcUopTSGZ5g/6hahS7Pjw5JIQ/r2QidTlW8XACm3lzh0to?=
 =?us-ascii?Q?cVmTuxWyL6bx/Pb5pnZEtlROan6iDOWd/qCNYUWtZfjKEWaZdIk+BGby4uSd?=
 =?us-ascii?Q?VMm3v3p+4SJZDNNB89CZ1BDtT2DMa7KqZuKKT6WgsenezqU+RWkXxBwWweUh?=
 =?us-ascii?Q?v1KvtBsq3llO9uOeV1zxG6oB1nOlBtoCRdx2loQyoZv6BDf9iI3j2oRhdPib?=
 =?us-ascii?Q?S8sMfXdR1wNywzsMLfpO5RPK6iV5XcsYbHg2MscDrg1tKQwcPv9ec3LjYZER?=
 =?us-ascii?Q?Mk+4ilfq71Zbq47ayybellL9eYYx+/EbbEzL/JwoxaPhT1OGuboa9IcFYzJy?=
 =?us-ascii?Q?CqCIQ88SQT71zTWfGN9k1/1LMoPdCXLz45rYlikqc5pbakYGyJQETDidBbam?=
 =?us-ascii?Q?Y/mJxUW99E7vPZ3KFvS2FLAfmdeP9L0iEMp1xeUkse47CCsD0KjTmwfW8yBo?=
 =?us-ascii?Q?ckbybpqCLODJ0PLbg+YX/WCNLK8v/X7ikjQYdJ49dQLOssAu+mJgmlEaYN5c?=
 =?us-ascii?Q?6N5eywBzY/FXP+zMjBvLvr+4Q+M+WGpUo/P5A1iRu0iro7/OS97pTkDy4AMI?=
 =?us-ascii?Q?uwL5ZivrTPCGl/jU1AKx6Z89MRuLV4aCS+GFB7YTiow9Djd2PnVD+IPmEpOY?=
 =?us-ascii?Q?8nBkjmVppsYdUJzyOd58KZ3d1OO0KpXASXf8lPaqdGDALn5Uu811LvbeeDHW?=
 =?us-ascii?Q?He440Dnx94hZrIqJSl1H7ovyK7mC7frfRardhurWfQANIN9oly42ekXt15+k?=
 =?us-ascii?Q?sTnKbZ9Ib1eLyhfRO0g8u7nRBKXCydFt7bSb1tx2zLvX8ve++ezM09/kzlbi?=
 =?us-ascii?Q?iGfTCYfDpE4yhZdnzhRArX4Qo3ME/51JOojsPWxDW4Vp1QiPsS7MCHAiMbdI?=
 =?us-ascii?Q?NK12LfawiO6YqNThr3SHGv+KEPc7xLUOTlPrF5qUsoKVUFxqqQW3eKq413q+?=
 =?us-ascii?Q?Mch+c2bGC7WaBS8KLm0e560KPeFOe7d0WnMIXpLiEYCEqZXSMu6rXS0CSr6q?=
 =?us-ascii?Q?65AJqk4Pg1KqJ8xub3c6AZcd7R5GeA/7rIx2LVh8jICDc33aoFmbZujZrb1N?=
 =?us-ascii?Q?blrFmQsiXW7y+8bAJNwW1MxzS4n9GDNx22x3AJUG9HNrUsZrVIV/FE65ugoL?=
 =?us-ascii?Q?A/C6+bWMIl4bT5KgTyMNdxSCdQnFfTlL+xhWivgsDXv7hUDGkib0JrrJrDdj?=
 =?us-ascii?Q?n+o/YkWBED1y1U3F2TCavbYqhwKCaJ1ORwOWgh2ZcnwuNx/ehs7++o/rzuoF?=
 =?us-ascii?Q?DnEO4+RYnlZyaHczvLLzaH8PbTfYdV62azSYoHtrgTXTQ94+N55la2oMwlld?=
 =?us-ascii?Q?WzrkC1Pu61axe2kSOGJQu9SHjOlRjnfbsrcyFpYEPUlh1xmTrN4mVQAredJB?=
 =?us-ascii?Q?ogW2cFWzo14nL2PvG7pNNvZEf/AvdgD/3nLhaV1YjrqfjyXBQuPztjRiINxr?=
 =?us-ascii?Q?4aNTuiekAxUnzTQLyzoRNcEyX2e1Zh/LTy4T3nr7rv5TD/nnUTpXAR/6IYsx?=
 =?us-ascii?Q?Ox7TVr4c9UZZA8HCX1qoQ8y9RN1E1g0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e5f17-5c8b-4db3-63a1-08df3a950d1f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:55.5463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5IJRTMfAhSZvtE4nHidAv9wcKFqQzEhJSHVZaI3uJtZ1v0svr7xMtRYrumHNBuK1waz/i6swmyn9NdE5JRdsmLrrI6OALo8n1JDZw3ndfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7899
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

The common SDHCI core pauses SDMA at the selected buffer boundary and
waits for software to rewrite the system address. Freescale eSDHC and
i.MX uSDHC expose BLKATTR without that programmable boundary field.

T4240 eSDHC transfers the complete block-count times block-size range
from DSADDR, and DINT reports successful DMA completion. Its BLKSIZE
is 12 bits and bits 15:12 are reserved. i.MX6UL uSDHC also completes
the contiguous transfer, but uses a 13-bit block-size field with bits
15:13 reserved. Neither needs the synthetic 512 KiB boundary pause.

Enable the no-boundary quirk for both eSDHC byte orders and uSDHC.
Remove the artificial boundary encoding in their shared translation.
Keep the standard SDHCI boundary handshake, block-gap stops and DMA
error handling unchanged.

References:
- T4240RM (Rev.4), section 15.3.2, 15.3.13 and 15.4.1.3
  https://www.nxp.com/webapp/Download?colCode=T4240RM
- IMX6ULRM (Rev.2), section 56.8.2 and 56.8.13
  https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

(no changes since v3)

Changes in v3:
- Enable the no-boundary quirk for both eSDHC byte orders
- Remove the synthetic 512 KiB boundary field translation

 include/hw/sd/sdhci.h |  5 +++++
 hw/sd/sdhci.c         | 42 +++++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c5297310f6..7bd39bf61d 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -113,6 +113,11 @@ typedef struct SDHCIState SDHCIState;
  * busy.
  */
 #define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
+/*
+ * Controller completes contiguous SDMA transfers without the standard
+ * intermediate buffer-boundary stop and address-update handshake
+ */
+#define SDHCI_QUIRK_NO_SDMA_BOUNDARY     BIT(1)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f6419319da..cd5ad04bee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -686,12 +686,14 @@ static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
+    bool boundary_enabled =
+        !(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY);
     bool page_aligned = false;
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
-    uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
+    uint32_t boundary_chk = 0;
     uint64_t sdma_address = sdhci_sdma_address(s);
-    uint32_t boundary_count = boundary_chk - (sdma_address % boundary_chk);
+    uint32_t boundary_count = 0;
 
     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
@@ -703,8 +705,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly
      */
-    if ((sdma_address % boundary_chk) == 0) {
-        page_aligned = true;
+    if (boundary_enabled) {
+        boundary_chk =
+            1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
+        boundary_count = boundary_chk - (sdma_address % boundary_chk);
+        page_aligned = (sdma_address % boundary_chk) == 0;
     }
 
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
@@ -720,7 +725,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
-                boundary_count -= block_size - begin;
+                if (boundary_enabled) {
+                    boundary_count -= block_size - begin;
+                }
                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
                     s->blkcnt--;
                 }
@@ -745,7 +752,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
-                boundary_count -= block_size - begin;
+                if (boundary_enabled) {
+                    boundary_count -= block_size - begin;
+                }
             }
             dma_memory_read(s->dma_as, sdhci_sdma_address(s),
                             &s->fifo_buffer[begin],
@@ -2008,18 +2017,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, value, size);
         break;
 
-    case SDHC_BLKSIZE:
-        /*
-         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
-         * Linux driver will try to zero this field out which will
-         * break the rest of SDHCI emulation.
-         *
-         * Linux defaults to maximum possible setting (512K boundary)
-         * and it seems to be the only option that i.MX IP implements,
-         * so we artificially set it to that value.
-         */
-        val |= 0x7 << 12;
-        /* FALLTHROUGH */
     default:
         sdhci_write(opaque, offset, val, size);
         break;
@@ -2047,7 +2044,8 @@ static void fsl_esdhc_be_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_be_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -2072,7 +2070,8 @@ static void fsl_esdhc_le_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_le_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -2199,7 +2198,8 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
-- 
2.53.0


