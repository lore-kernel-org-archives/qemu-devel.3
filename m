Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2348EC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmn0-0008UE-BH; Mon, 20 Jul 2026 08:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wlmmv-0008St-PO; Mon, 20 Jul 2026 08:08:02 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wlmmt-0005tM-Sq; Mon, 20 Jul 2026 08:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKsZHufBgsIl4p3X+WSIb18H+uDXOclBTVkMzcMxQqVR3Bhxy80/RG3mZEk3bmPlTJZm941j4psRJBjM4H7Bkahew/Gq/XoeYXLnt4IubFMCRnmyLALzFD0V5onnMi2CwG3CjBKG35fsN65O4lspMKJfplFRTf3ej0oWOgZgtudNu1nFKXvmxlmgEzdOFgxIshJwLBhHpT1SmHC4/spTJBVxnFV2Y/F2W7Xmxs4vEYfTugS+nDNhzfRPvQJTsRQzjZvtN+G/QTKBwtQsk+bMb7WuPyY0Ddi8VPcLcxGF4fStSsQ5Waw35PF/T/brZka13bqFIBGJBnVDZhNNxvQOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMLZ2EZn0m0FbMOCKFQs9isP8wTYVnMP9AGXbyGS+kg=;
 b=HfgUSktGNun8NAYpE/gpE/ca8Q32g/d/18lFp/qEEQC0PzfrWA3j88dZYy5svzhXD6Zu7PzNf/CoaL7oqhugtyr/FOYq16RsDFeAUMSCJTRbvRsU1b+1JDJVu8+oS3iVD7XE316+WRVCP8F1XEzkZ3uwridkRIpdjZMNd9fCxdbO/XG3Ykxf+As28E3Uqq+KeSuT9u/mlWELGBq3jvTT1O046xSiBxI/pBs4osmxNl8/VHbyNWSaAKu00Uf7SpHdgl+QqLbbgCi5xI/ph8MHas0xeGEZ/bMN1pigYJiqRQ6ogN0AC+iK/W9Du2QNY17Xf/jRdSzCwUIo+1mKR14oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMLZ2EZn0m0FbMOCKFQs9isP8wTYVnMP9AGXbyGS+kg=;
 b=BKysS/+pE0hdKaMesmyklC9mMTWLXQBknyLlIEpeNovWNtzR7flk+Kqeb8MEo/zOuIOdyLrIHTGkkSn0w1NQoqheArWY4aBVO4bNjQyCHfjQBQfcjQ6TTdUvtQg5Bu5KG1Un9zb0mlgzXp2N0Nh3HP4IPlZPKwPIAFDzm6447TEnCDoYGKe3qYK9GqzfqyIYgmmlnKXfczavem1W90QtFd1YYwgEPIAetf58ACNvgvPF8ZD62coBjDTYkq9K6E4QPTGZzVcAsQshYVVRZfQZg55cbM2L0GAi/kxtOk7JVu+8i9oS5XpilewGOtIB5RzS/xjjhIzq1byEpOuArzKuCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB5519.apcprd02.prod.outlook.com (2603:1096:101:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 12:07:49 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 12:07:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH] hw/net: cadence: Return current Cadence GEM queue pointers
Date: Mon, 20 Jul 2026 20:07:31 +0800
Message-Id: <20260720120731.2022475-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0197.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf062f3-fbce-42d4-6c7e-08dee65783a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|34096008|1800799024|10067099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: G67pe2C1G7Yodd5a2t/UO1QRnNvW4USwkvGYb/Asl3Zt6kkvhYcOco+iPr1b6NK240Z+ErxMB/2+/DGI9UYGr0Hq+k3IjlRYHV904ZwFOEt6ZH3a9K2CKLdk3y8FbxmTKmeb27ueiNqJzmu2cDcM2GrebIyHck9pIzkmM5pyQzp8/+5D72YyKklz4paYl8s5es3SnVCvaPjvPq2g3O8IoX3G9kM5F31DXJoWQEwxeRLaFe1lr0HynVMoz61bdlIAriCBIyfvoZZakwhdxXi+7XI68+Xt0lKv1n/4CKOoHMh5rjQynt21nTKgUjxby1b0ZKIqJ3hEJzd33IqjxwI5vJ7Ghkl1HjL/bJ2kwYkLRzn6B7uWrIL10rUXyeWPf0Lc8q3Hie/9s4b7q1NPDgmbvD4Zp2z/cf817hWH1UksiUrjFXk6W9KM7dmrxI3lDbAzVCi/+QwN/9FR4Oq7upwzPCcZER27wpWFXIc8vEvSWtqQzlQQWB/6k5osI296QT1BboL7Sc6aGtRiqMuf4GkaiHNfpa0kZ3b7dwIiR/K7fXT7BoUTLVszPbrq+XhEuCvv28VYrg8M81g1sdyNsZiJhmAE+bF/jEqxX2rgI1POKwjkQwx2UFTjdJ4USV8+cZ6gW4hC/KXWN/WzTRR9i2x9RBTj93wcXr736Um3R+YMGgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(34096008)(1800799024)(10067099003)(56012099006)(5023799004)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2pbUW4TJIwNBZC1W42aYdMaYTheT7rei/ekqKyBLPYuID9h+cleIf4v7Y8i?=
 =?us-ascii?Q?aHfV4dBoQ0JLzAthg8xbx7yZCn6lEbVob9J2hqKVplQO7wz9Og8qpnmuOPrX?=
 =?us-ascii?Q?+t4tX1FPF07MtdJKo4MxkRJeyWZ2omGWkwbawKd6gyQVOWqOzEdPrTKPKY0D?=
 =?us-ascii?Q?TD8p8t/0apMzjAW+PcGLnaRTjmb2N62u3FMdmYNzTYMLJfkXSZwe3Gs05mHj?=
 =?us-ascii?Q?gyhwCMkQppalebRAOX+7/CVHq4EhEpH3T6OqNN31/wmimncLxjksxTBp1v46?=
 =?us-ascii?Q?jhRehfnyuannyrOi5U1HYmZxx0Q/WYsnTrDnUDgprnr7zUbVHUpteF7zO19z?=
 =?us-ascii?Q?vo2QRVVAwwEaYSz8gV4Mb8wueH0xuy/SD5WqiXLMFeO3vojlOFCA4fd6Svmu?=
 =?us-ascii?Q?fQMi027J91NMFUjqlC3ATG1qNciIkQlaX3QRkfYhzCJBavrVyxMxQLOlHA8e?=
 =?us-ascii?Q?h0qAIqVWrJF/e2QtW0pIGVuhYs7AY7NSZ+lwegCRYzKTkXphVRdKCFsoqoKP?=
 =?us-ascii?Q?9Ze1btBjm9F7Qgv+J4GaIvF2FgD+UTR0+RpGTyNTEgtrqRm0bRpw2NZmo6+h?=
 =?us-ascii?Q?N7Paj6+NPpM9L6wJtammRDv0TxC0+BI6X2UY28retT7Smxw+38lmxouQmEoo?=
 =?us-ascii?Q?Mlm7gN4aNZBV+WNK64AxWrBBlY6vfqN1xTQ/5aByPDR4+ogfPzw/TkX1+vy5?=
 =?us-ascii?Q?Du38JqA7ueju3lpWUhUpxp6/ZPv5eI1HWReq+nm1ybJSWyXAvBXQ8M+Xytm6?=
 =?us-ascii?Q?hTXhmfn0IgFcYoByzu6GePqsE87su46jTc1ofVXwc0B5l3J7rslhSWQ8Vjit?=
 =?us-ascii?Q?r2rlukwXF7XlegCnZc3l/YSIHgbe12xv1o7BEDGN3Duj/WPIz2+x0hixoeAP?=
 =?us-ascii?Q?zK0DPYTBg1MN4ek9lNX9m04peW3ISbcZCBVxzveot/SlvQAT0zypBxveVwT7?=
 =?us-ascii?Q?mVoXVzIhBFrwrfWKgfwTCNbI8adb02sqhobz1yHSDlBpki6tVmTkxoLCFNyK?=
 =?us-ascii?Q?EZVPcTVUP7U4xOjZ8WI4jNpaGz1skzF928huvPpOQCSM3ZHE7JqJ+xhCa9BW?=
 =?us-ascii?Q?xY0W5o5qH2hk5MuVtmeWCEk6+xEunnmkPffKxLUvfbcI8X4SYEzLzFD2B54X?=
 =?us-ascii?Q?/OTTForNIK6tL5G05mUSYJXeAvLmcsgGGXosPV1V366G39TK2pMSznguE/bN?=
 =?us-ascii?Q?lx7F6ieNFYR3ZVUpv0+SJQNo1K7GwXZcq4u9lm5mnWu+2beOMKofYPlG3y+j?=
 =?us-ascii?Q?y4nnOjToT4V1xT0CWKpw8x176O6cuR7cpIeCjaW3axfwaq9DekPyVNSqnoSL?=
 =?us-ascii?Q?5o77nS7zTC/NV9QT2shD4FYTmXrzHIkCzmsU6ae23pVReRD0bu7bTy7OOpZq?=
 =?us-ascii?Q?AuN1WDkP735O8RMlzr0mLY0ZBYC9ou7gd/+OuDU9Cqv+m5xi1YvBLzvw7hPX?=
 =?us-ascii?Q?DyJcP7atVtLhwCH4aV0HuH0AWnsv2T9fkYTaFviuvV+p4zGnHOIinAg34BmH?=
 =?us-ascii?Q?JqqqZVnj2QWzByLhAz3OH6EIMJrEIldw8ccIkQix39GnemwQsATzeOXXsAim?=
 =?us-ascii?Q?EODX5/RzOSDThzf1D//xJ2CZWxbXaHrxYxpoyjbwb+58ogCOot5ueHkjBYSg?=
 =?us-ascii?Q?2loo2pS5Sw2nBYlAgARHvGHIrUXI6KRqInQ91KJRpP8PRko4omyLs5DhZzoC?=
 =?us-ascii?Q?0akBB5HwO/x1IrR+9L1J6lwzFmVD+3khzrAXT1JwHdPnCYxPe3lpN4bW6pI0?=
 =?us-ascii?Q?sbe83yc4NMBvzMR5jE5X2PdMDaOaEto=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf062f3-fbce-42d4-6c7e-08dee65783a2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:07:48.6710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4Bph/lIGX3BkWOSKOpwnfObt8j31ZaixHFjiigFsE+7+5eq/1npifjiHVm+7xuTUuUiKgSSV1dtgo31LstiiQhvfFtGYo6bq0SxoAMK8Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5519
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

Cadence GEM queue pointer registers are programmed with the descriptor
ring base, but reads return the descriptor currently being accessed.
The model tracked the current positions separately while continuing to
return the configured base.

The Linux macb driver uses the transmit queue pointer when recovering
from a used-buffer interrupt. A stale priority-queue pointer can make
the driver restart DMA before that queue handles its completion
interrupt, causing queue 0 to repeatedly raise TX_USED.

The primary queue has had this mismatch since the initial model.
Priority queue support later copied the same register-read behavior.

A single-queue machine usually handles TX_COMPLETE before TX_USED and
empties the software queue before the restart check, which kept the
issue hidden there.

Return the current RX and TX descriptor positions on queue-pointer reads
and clear those positions on reset.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Fixes: 6710172501be ("cadence_gem: Add queue support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 hw/net/cadence_gem.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b568fa3392..39e3620ef5 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1469,6 +1469,8 @@ static void gem_reset(DeviceState *d)
 
     /* Set post reset register values */
     memset(&s->regs[0], 0, sizeof(s->regs));
+    memset(&s->rx_desc_addr[0], 0, sizeof(s->rx_desc_addr));
+    memset(&s->tx_desc_addr[0], 0, sizeof(s->tx_desc_addr));
     s->regs[R_NWCFG] = 0x00080000;
     s->regs[R_NWSTATUS] = 0x00000006;
     s->regs[R_DMACFG] = 0x00020784;
@@ -1593,9 +1595,22 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     offset >>= 2;
     retval = s->regs[offset];
 
-    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset*4, retval);
+    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset * 4,
+             retval);
 
     switch (offset) {
+    case R_RXQBASE:
+        retval = s->rx_desc_addr[0];
+        break;
+    case R_TXQBASE:
+        retval = s->tx_desc_addr[0];
+        break;
+    case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
+        retval = s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1];
+        break;
+    case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
+        retval = s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1];
+        break;
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
-- 
2.34.1


