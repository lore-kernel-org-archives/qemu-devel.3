Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6318CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAl-0006AX-P2; Sun, 04 Oct 2026 05:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAD-0005v4-Bn; Sun, 04 Oct 2026 05:05:46 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAB-0005jn-AH; Sun, 04 Oct 2026 05:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpfaySq8CkLBjCRH5LgMtnUxj63gh8VYJFrkXZG/9ZmypTOM+U9bgpsLhZxQg9ZiFyw8RomcqNGDl7tltelV+o/DJhrOITkC262jTVD0J215vcckO/+NV9O1q5uxaIe7ShgWU2gfpWrazRIJspFwkGHPQHKFcoKuekUwAzySmnGjUQIA8v0JhIJ5MVL0LxPVWW3Duv5iHf6QfTPduMxAw7ecLHj6ZhyzYNT6/wkI8eh4qr/Px+NitjznWxyFz71jLOmGndGbDwJ5GeouCAB5+YMkRw2GT149kDb/j8k7yZ/YbyCkTEAA7inn4JGC8OPG8Nwqhs+QvRJVacBRcaLuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEsZkl7N1xK2yq3RJ/nXM1R9cXX9j5d62z2rnKHRR2U=;
 b=yJhi85hwaq8JwwbJsbxgPSROH2vyZVctbRpS+YDwqF/w74hOVjd1hoJtwoZSqBMsoyQHYsesw+e3sak0r4i1cuLf4KcGp3qb2OEX0yU+oW6t2lE2w9QWnEBcQgjNSQqM1Jtxd+nYOtFLx2koVkZ/WQFBaXPwuw+ZyBH9Ea6m3sPbQrEOFe1kKwU4A72+/V3wzqraB8/5TrYXoETkan33yfygTmkQhNFROobDfVkzvx5C9RzkqMtHt/KYuAcKq9g8L6Nbjs6Coii0Str1c1bj3gk6CGy5ZWV/yw4+k3A8coNHy+Xo5seKmtrnGfbWpVKD9E715S74Oaubvyh/bdePAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEsZkl7N1xK2yq3RJ/nXM1R9cXX9j5d62z2rnKHRR2U=;
 b=tPAn4iJ/E7fcWfloP450ZkEKClqRhimEEUrl4x3seXaSzuwTL/rDswh0QW9q1lLFe2g+enTCHyxME0JcoBuTVyOc8a5KUWac0Y7wlcBOCiyo9gAG8pBTJhaETKZ7BAbSylxjNR898pj7lt763CZ51oE4CoifER1/nftr+oKbAah+vvawFhLEbDooOvNVf5xKEq2AOU3FlDf0a629rSP35VBGiGM2G3WLR35Xawz0dVRNkGitncAIGVtrN6trDu0042La2ehlBUXINo2QgdKuasuznJUModyrpefTSNG7pCrP6ui6J80muCP1kc9eh0BO6rE23A/OYQUiZDFdsgovVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:33 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 08/10] hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and
 uSDHC
Date: Sun,  4 Oct 2026 17:04:53 +0800
Message-ID: <20261004090500.3082641-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8904b09b-0fdd-4b1d-b1e4-08df21f6a563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|5023799004|56012099006|260925022911599003|260925021911599003|260925021311599003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ow3N+wuuU1VEWT1mQlANZs82pnfOvzUsYVRxK8EY5IB5OVOUcOjkLXENtmDmTSyOK35R6Oi5jxKUuAwmUvAjEX+R/I3Xpc2shljDymotBcPlHjw46HEK++P6XJOo2xeE4GsFeKIhDFg0o86z3gZmA9JPODmjZQxBx4OAQ60Ca5vr+dzhqDhIyeLrHGjwmhcL8HNTu7LOCTYsn1BH/XE14Fgmyx/BpX6cza+z0cJVfB1HpHXxQZeD/O5zwFEhVeqv0xXBErZIKAg0ydRPZTcHIQLnViR3D37gzyqzdnt81JYYOuIXjFydCpFRCJSp2qB1JKZCiv3dXPIO78rn/Iep7ZGag0VcM6zP+xbhq+0JyM1SwFVxO9VJfg4W/uyH33Ab58RyTJffjZ1RsVNj1Twt8pqppJQIhl/wFGYqRO5EulImZjURgYciRsMGjh+kdiAbuZsppN1/oXADlizaxeSh6Jcd6j9ZPlN1Z9M1SlQlav7dQdTQ7gt2FjXjdjYwU0fCNj2atrZD3Rk82iXTs9GyA7GG5fhCntw0f5ntTzCAprLwdvdddBrHXrZ5EgKjdmQSMJW7k1g/z4MytrVepDGcUlxoAnZ7jk/sTgYCDnetwOEpIFqBvqj8Kp0YRzuzDH3Q3MJW0tJdIMqepcWltqKj78lH8kRwMH7LYpoJ+0u3rHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyM5ax8MwVdw09ycMAfW9A/tdG0OMk/3O52JggwjvMPzisDtdMe4fOnW3QhA?=
 =?us-ascii?Q?cmeGIOR4XA5aRl6Y135NcdnsD2Twy29ALV/BZYh79fTc+aeWEqzXrspOyNF5?=
 =?us-ascii?Q?Zou05+ZtcLMF/PlMEZTNSJpsGo2KS7R6JmmkdXbLLbKfWr3Lqb23DCHmIHi1?=
 =?us-ascii?Q?Eazl+uzVbJUveR1/ZOMySL5PYA9FOX9/ZdiGPKOmDdMRD+CxzJC8eTSai9wV?=
 =?us-ascii?Q?HCs+AeupMK7pVS/XDNtCnHdfqApV3uJaZHVT2mOQksBWFQs70G9Tx1WmzkNH?=
 =?us-ascii?Q?wVdNauO8D7YdGgNIKZUy9UvXWyIgQu4ZjVkwcFHA7qmrOnVuWNpFYihwQkUX?=
 =?us-ascii?Q?nFUDzDt0zfQDkZMQDkfIKkzgvb/1edqQBYJtHWCWItCjCyh6C2TKYytGoimK?=
 =?us-ascii?Q?gtdo1TpceQKo8nQWEJHqX6DNFwj9WkcDs7JbfJAcymipgHD5Fyw+4Trt8BsS?=
 =?us-ascii?Q?ChxwIk3XI3Bymfrzka6QoaISU9SXAiq0ekWpsGXCd6zpKEaxDlLfIMvgwtzn?=
 =?us-ascii?Q?Z4EmPAS++buaue9J2dSdpnmdeHFDSmisEbcj33D5j8GL60eyiDQk2rH3lPmu?=
 =?us-ascii?Q?g7+sV7Oi6rLCcOpsUTE8UbfhRQhJvFqXrgPWV/dq09YOW+c4XNzPt51rVwrQ?=
 =?us-ascii?Q?vqFc9rqHrLoE8uPK6Rlm+GRHKyCkKjb12yOpXZuFPEe8w0Hv6Je3nud27oMG?=
 =?us-ascii?Q?YszakKu72txPllcei/7Tsg2GF+Lf2Q2sOmN8sVjO3s3t/AnbxUeU8oxfPTmL?=
 =?us-ascii?Q?iKa1A79REE0ySmAB3MqYwgMmhcx53d+2XcpIVGzaec5Rn7uKS0qbtZG52NHc?=
 =?us-ascii?Q?gOewrjMrOGOGviN7ZLxhsEGW1hjc1N+z9ODe5UhoXfouD9oYYOBepmyfliRW?=
 =?us-ascii?Q?ifTq1h7BgkKA7QXhcDS4LqT0hy+QZKh3ZqRH8ov9MmPVKkxOns2ZnakWRbT5?=
 =?us-ascii?Q?zIR+lIdQr8zOsjLbLl9WSxvhpuu4E+ZwONgAmTXccQ8NsXcNQ2WONbvjkJO3?=
 =?us-ascii?Q?0ALv5lRln3Z7V/FwdFqH5Masa7C+dWkvLoclEcagU2XJrxuBvT2T5nAD/bdu?=
 =?us-ascii?Q?nV1nxIJLY5HrZp/a/7PPsmykFr0+RMN8eVq4gVQAWo7no/nza48/YPMKXORB?=
 =?us-ascii?Q?/52sO4um9luRfdQLcW9Nh9ckecvtRToV1csg3uKVHMpBKwhuxTeqONkoerNq?=
 =?us-ascii?Q?E5Lekb4InFNocoFIK1eb+ZLgIJBIdU5zSToV6HzFWEsgROqBZIsksXLjEKki?=
 =?us-ascii?Q?XH6riSefdAaBxRBmQuftu8qFj8bNhXJowspEzfPKp34UgnnhJ6W18bs9Oizk?=
 =?us-ascii?Q?bj4UQ9gqekNaLs5CSHhlfQl+G/Dv+4IPa/YBjMFeMhVPhReUjvQyHwMJXTZi?=
 =?us-ascii?Q?kgK1LlN+TwTlBGH1rfliMOQKBaiQLdETArYQNUEnJLBrssTnDx4/S8ujRXqz?=
 =?us-ascii?Q?xOW5IGwHUFdkVSizruCdiZDx0hqdSUXyt9WwCgFE5uPquWt9sCXi6C2Ww0pt?=
 =?us-ascii?Q?vqL9t2kKgdp2VyhoFgWKKvEb/SQEnX8YOCEBpLIRQAf3EaAmX3YD8BXyMw/j?=
 =?us-ascii?Q?VUml7DuViLLCimUYU/8xHPCRucSTbQKY7nL9BvMa5BiQiQVH8mvjnlD8AIB+?=
 =?us-ascii?Q?PkyM7ZTHy1BcYfi1zTaZXsdTOHRudBQQVMQ5++oWBmmfa/dv/MfA853PGpFq?=
 =?us-ascii?Q?e0Iew8Un2cSUf7XDsDYNvhc20N/X1GUrY0iunc4b/RxF5fhixCc6JSPwX/Tp?=
 =?us-ascii?Q?ZgD1kPJHnjo8lDDfTTTfGJW9STMCTcQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8904b09b-0fdd-4b1d-b1e4-08df21f6a563
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:33.1599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P6c0qEbdcb9M6+1EVXiLAgkqy7oLRNs0Q6u7r5//Hi3aZp8rEPZSn9zo6+avuaaWGJhEOUPMk+BRnyi7udaPRDrKBOU7pc3iQRzpgKT3QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
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
T4240RM (Rev. 4), sections 15.3.2, 15.3.13 and 15.4.1.3
https://www.nxp.com/webapp/Download?colCode=T4240RM
IMX6ULRM (Rev. 2), sections 56.8.2 and 56.8.13
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

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
index 3bcad3e518..6289176628 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -687,12 +687,14 @@ static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
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
@@ -704,8 +706,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
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
@@ -721,7 +726,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
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
@@ -746,7 +753,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
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
@@ -2017,18 +2026,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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
@@ -2056,7 +2053,8 @@ static void fsl_esdhc_be_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_be_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -2081,7 +2079,8 @@ static void fsl_esdhc_le_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &esdhc_mmio_le_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
@@ -2203,7 +2202,8 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
-- 
2.53.0


