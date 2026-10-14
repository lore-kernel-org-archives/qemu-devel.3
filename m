Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D5CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3Z-00077P-1M; Wed, 14 Oct 2026 00:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2z-0006d8-E7; Wed, 14 Oct 2026 00:57:02 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2x-0008Iu-De; Wed, 14 Oct 2026 00:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGbETKvUIf5jAWs4V2qAXgJqSdKdVrXCLd74htgIzyamdxcdOGl6Iz4jXuXzaPatgngM41eg+YO+OEmfc1u+OpvzTxlsdBxqZjJ92rJy6MKQ3YtkSbogRq0eVvfEnxxji/BXdzlh6ZenXrSJBFC8qKJxy6EN9DaDEjAcUFYaHYW/c/DgF0BscRNZ9zKywSgGcwKFT0DcBW0s0xuLeL6pO8R//w47nZR/qTsRTBybsFfarsGrPer4Pyvgx9IQ+tjE/mSGjnDjz+RJbHOkRvGHH1dI39YJ84nhj9EIN5EtZtv+iqCP2BSTJRWufc6bV1cEpq2gTlBHhNrnGGlY7FUDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myu6Wj/5XOUXMIPupmukpRDoWxcuXytWSa7Kni2PdBw=;
 b=hoYDVM4i4c2YfafatlOofmTc4NHz351/7l4uhUtmfDL06/iEhSl3M0wkYFUkwJyNMSeVkiTV+N2YlnuDHBn4w+FoVeb84DsRfSE7+6wRDF8PKkLT1oIezZvYeKqRI/kRrdIWTe1n+L/ErfC/V0UEGQLzOdIVeYDn7h8kDqTbbyN2cUMkgkUY2bsgiONOCFsQIrLMlbjknoq78EHV0XX1RRppnTYcuJDWCNJVyDvD9NO0ADMdBXXcDBznZTcpYk/H92luPVhSTYvtHuuNbeKx4+UyB/CjmbozD3bfcQ7aa1UDDSujkEcw8i1JQoNu6RL7JcGyLrTR8hbTcexxYFyXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myu6Wj/5XOUXMIPupmukpRDoWxcuXytWSa7Kni2PdBw=;
 b=OeaTw+PJoPDmqDVQAiyvvoh2zfihar9K7KuelFu4vFN3sYWftZSbfGObpkxB/Ne0z0XnkCVTK9vuCu4meNboqQdT71ej5dYX0Gsvhp/dOeCatTXrP/fdee2IELTKXnLJ17QMeQXYLvJZ2ogZOBURSFLdPMjzb399+aFajX/GLJzpYExnFsJS2zNzFvd9GT3hXjBRCkdEUR+3LNp+SFyZFaJgwWtotD+C328DOb5YSpMjD7wtBxM3iBqGK/qDHsvsdcF3nXA8AZEtZUgOV9mVvNlS4XgeXvWP+sSELia1LIQtKegOE82UlYwJJKkPuM2BuTCAAA80xLR9jtTeLC9AAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:43 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 08/10] hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and
 uSDHC
Date: Wed, 14 Oct 2026 12:55:58 +0800
Message-ID: <20261014045605.399684-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5578d7eb-bd62-4172-f816-08df29af8a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|22082099003|18002099003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: fVthhIUVxvbDmrPseQ/umEMnwaDXULHKw2zJVJJr6p02RAnSf+LjxGQApZjWEmtponv5Hw98/XHbJKuizc+NU1afZ//LV0pgtwgwgSOnYH4FJzalBRjj6FgYCSewaAjFDTECIdiiKLev/aDQVmDn3RSdX/c/ncN6PYyhJ2xgi3rs9drUWwK+Krc7IpJrYQ5h5tZi9VykfCzD0QjIJc85uXfum+SqF9CNGpoP5QIDgfTieUPgn031py+feQHS73oejbjTQdzq0EXsTqWsDGhew9lBSnbbjE0jWyu5WRj2apmv/wO69CARCkkqv0YZVECfIjtOpBV+kddOefew86O8FTMpVCg27C3lqh0GGpSgZ1dvVDDKIZmAe0+bw/jzPDL46YzBBrKPXiEec1RoICXGZ/K1rGri9I1qYm7UxJXPxkZOin3e0NpiowUH7gERLA40uX1wdElmQ6vao20+i0ntuRai9Ufsm6+frJX783LScmM6Notlj2TRwjflzkX5pOCy5Ini3esNqMJnrxSEz1/JEU0mKVG1fw6d2ob3hb3L0/kca8WaNcXrBm6fhHCgTLhFbLiS8QZnK4gmctIJazfati9mjFHSJD/MWSJsI9mVYAC9QUHtnbUIzpU1hjmxnU45/B97CcfvgxVey2x5DdTwevPRYafbBamYo7PTeSH+duo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/SKsj5787RIKFbyr5Kd12b26J/PolX/mtyWtWLqHwDgpP4N2GB34FWt7lb2D?=
 =?us-ascii?Q?I3+SqrkIUfRon0xIK5LMF2w1Hnl7fK2MJtvPPNZ3ANM0Q6I+cSV/NASR79ON?=
 =?us-ascii?Q?ZNAjOuhcnLW1qvnpvD5nK4/cqGNB2YehUk8xsAhbZ+Pu+TjKnGyxUhmWPyme?=
 =?us-ascii?Q?1eb7poDQyajItSALF8FwgfOwxcz0sU0L4ddOvBWARiTGk6YyYFOGtinqyw4u?=
 =?us-ascii?Q?+Y0SRSYOboqnMoZQx8VcZiE3NxSlCFJaeXtCpbX5LHKoaDrffwoxHv7gD4uy?=
 =?us-ascii?Q?R64Ff8Ult5d0Jd1Q+ZkR1vzEvHQspLVDnkOWikppwnpcozjIKnf2nOLQPHdH?=
 =?us-ascii?Q?P3rKbrCDyGwHisiagN5DlfyK74TYMlRBjMO4cV03W5CdozybYsCIqhqWYi+J?=
 =?us-ascii?Q?LgH+t/yWKpfvp3O+aNvG9blx7Om09ulwSdruWbpCtLa3W6Iv8HZ6tLtf2pfl?=
 =?us-ascii?Q?lYfMQfEOwYlxS8cSz5zVZ+ulNPMyyPJiSRLXHjBe1hBwcm0VpXFO8/AhMs5d?=
 =?us-ascii?Q?t9UAdU1sRgiqplEgQVkGCsqAa8JMbJJOU7GTXR8bm42F68tVIBZQ6Qh7WbXZ?=
 =?us-ascii?Q?Z+ApXBuZdjNAGJGVnwnSOsqFnz2wxPceotC97QUnzxFffChabxrjBCdHliNR?=
 =?us-ascii?Q?9weQF1KW8dbc7yiQLI2F0wDziFrcP0p8mc6oys3tv+kZvf5fM/U+wPsOY467?=
 =?us-ascii?Q?whcdmWYxjDABNrOtZG6vWF5Bs2n3jV1VujO972M5jr8N2R3vgHYUfGQ7AoZf?=
 =?us-ascii?Q?3wlDi/mTQLl06tjBwuT1DkCiVSSR0+9poPi/BHAC8s05PwRhOhfZUPDg1QAb?=
 =?us-ascii?Q?y1dtnGghzb9DIL4r2RPWK+OhzEMC9139vxjWDwK3H5Uk4IUVXx97vo3T376o?=
 =?us-ascii?Q?p/dyNHNkBaL5qt7ezscXyX/b0Isd+ueYvMQXk8jipM/lM2ywwHo1fQQsskX6?=
 =?us-ascii?Q?QrTcwxULatwwB+UMJ79uj3qFPp1pW8+l9dzdAb2SJ9gF1yWMuMxI2wCYE5R/?=
 =?us-ascii?Q?5LYJjrK7Ep581a/eGhIqMaGH862amtE6EByAAjRY4RAj43CALD26sA1No95g?=
 =?us-ascii?Q?RmSI1hzytucmvn4QghwnIqEMCg6QrO4vogRq29Z+CL0aFlFCnfPdkl7EfSM8?=
 =?us-ascii?Q?UghgWfoipGg9JKTyVKYAMI2Sto6LEQEZhsGg6Y38CQBqxbnrPofAf3O9kJ1y?=
 =?us-ascii?Q?AL2SOQntjL79NVcbeI8CeSgrmElnYM3ZC2ppYBOk9G4nKSc1ZE1GDxup73M4?=
 =?us-ascii?Q?plKBvv3cfP4lF9gq3JO/nqgo6HgzKwq4xtQh0uk8JgWZin49AxRRum1RQovI?=
 =?us-ascii?Q?z3LOB2LKG90XQgVXDTV7nzJYve//OljwYMMrlQfif+9xwPh1LoenhELna/1c?=
 =?us-ascii?Q?evFkE9wqJ+QJl9dqeQipb/DI9d5SV3uxJMW0YChWNHCJShbk8wS4lGpZ5fZN?=
 =?us-ascii?Q?Tejhniqv6zngbfa4N3xEqpwRFU1zo3oWQI0Cpl5E0lxzVnpkwn9JTkpo9III?=
 =?us-ascii?Q?eWsn9u8Fm9Zr7We/9keLNvpeXpSFjKe2sxIHU3JruFmK8TfI3c+XFy6Y4RQF?=
 =?us-ascii?Q?a0ulkrAydtFDAhu+l6NB3sTlfZbMT0GxOeFrXr3dBXWjW+wX9cDE2AxOzlu/?=
 =?us-ascii?Q?VOrp0Bqk4kHD1pYvEzi+8IqHP9tswL80mprSPt4H881FlX5mBRvoVdESjfw0?=
 =?us-ascii?Q?5bo0kUAZ3oMrnxjEpZrJDsPswxw6Ar10EUwE1zMRJ2FQh6xxjIrRe9jnPHTN?=
 =?us-ascii?Q?aHAzRRYbT4fBBrXekyMVuC38eRB2nEw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5578d7eb-bd62-4172-f816-08df29af8a51
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:42.8388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0CIgR2Heb7o7xHi1WZIl1/JXliBhQeNYtFpaqz9syOremREDTP+UkU1sWyxskR55QjhpGyJElZef3DKfq1GGGT8Gd3yhxkxOt+JFIR5eA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
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
index 9a33899b64..5f11073984 100644
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
 
@@ -2194,7 +2193,8 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
-- 
2.53.0


