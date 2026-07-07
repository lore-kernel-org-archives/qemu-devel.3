Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F16C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gq-0003ln-Vs; Tue, 07 Jul 2026 04:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gp-0003kU-4L; Tue, 07 Jul 2026 04:35:11 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gn-0008Pe-KQ; Tue, 07 Jul 2026 04:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4T6Aoi5FppYnxuag6qD08pggX4wLJpQvebqipoi5EzPJ/SySsOeX0lqHiwn5uGQIYxzHofE1gO5/Oh/5RGn0f56W9Inw/taDfl/bdxJkihKv8ndoePK3EaWVx0oQeWjXoGzP1cB0LpUVfWtQfOlO4Ik84FQYiaaar9+VzQGaBJ+dR+v1tTz3iq/+DG9Vm6Z/mdj1gDYZGPbyU739bBgtwQ3rEMrnUvuN25sYX4FFSU3taOFd6d9hcn3hErszsEJ6kr/y+9AOvSfqh+2Y/0pR1gFAvYH+TzL5vZU9ymYbh7aBaf3KKSDDcq3UkWFnWf8O9HvyUUdyAkLLEyYzNh2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8oSy7eptbp7jfJZQ4K/chjbEl6e+MXXWg111tDRCwU=;
 b=Y9LK+ApY4tvfLSFdDgGLuENW0I2dolVBDBg72cOhsKO9QML71ZMKa5wGNoRsC7n+ZVRjJPyVZiLg1Z4UF3XZFwvKolN6/UZKozjziBD0vuzBVJYPMGiAVTDlWW/T5v3VtfhUqrvGTfUjhQy1mIM151n6kHAWHE8OqbRVJ6+kUiMBnNH9PGPv5GXn75/mauShTxAYzeT/9TVrJnCg+9wvZoXAqjtZnLkIsVznXu0bV9LIO8FIPqyQbecQ6UtGB7+2423lgOHQ/PMU4qyGqidgvu6A3VAEo5UFOXN99DMB8OA+UObWANfDelsqCS+KJQtX75vqDFYP7u2g4DshnHbMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8oSy7eptbp7jfJZQ4K/chjbEl6e+MXXWg111tDRCwU=;
 b=jAt4egHb5gjcWyasQnU3cmMo7qbUlx6L6BCxR78uFBf1oD0IG2qLRwbknZCIwsqWCkcWLmfwiiVEyGZb9osdQYIb+RP2xqVFrvEAtcVtQaPRBT6AomB9l4748GTnbPHi6s77QSYiEP7g2OGVdQ8viL3xrpE58Min/xpGg17dhmGRRqGvgrHAT4DBYv43y2aulMph7Fk/NFxL9jUihhsjEVIs1GJ3m9A9TCBBNiLBkpegN9ZGI3vyO0ofx+MBClCrAATJjZZqZsuLvpZWtBdtuGalMd8SDT03pVj6kMTIVn5JIwCCLjNt8YfV5h3rUZqrPvYCTBLdTcyglS/VJjIGHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:01 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hao Wu <wuhaotsh@google.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 05/10] hw/ssi: npcm7xx_fiu: Correct the dummy cycle
 emulation logic
Date: Tue,  7 Jul 2026 16:34:24 +0800
Message-ID: <20260707083431.219671-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a6e815-8da6-40bd-c4b7-08dedc02a2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|376014|1800799024|23010399003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SG0dGLLCYh8UMUAt92bng9A0am4dW1oDxUlpmhnB4tgmDvd8cvLECdlx7NkjHfjqHvJ1Qgb94bcjbNof65hGxUPpsJ7Cp0gGhiXvKLZLxH/xGcAlPa5tMiP3dRTuaaJ/VB8NVEshTqIdr67WqaGJVMekO2HvF6l1VqoDpXlFLe4Zylj09GWuSDtH+8bkeYsd/Wo0O5k/KFiIb+nmMhq98sY2CDoVbT9dEdyeS96GOQPR4fNnChmo4TLkl/8+Yw0zPBn+Ei6xLdVAb4srjkbOz4iUkQUNKiFc1t8pSqVzZR1jes1G8hUWofoydec/pOVEA+FB6bUhazp9y944qPRszpja7wjUOoVCQeJDplNEql7/ZU2HvxIMZWVq74oLF7A3oHbSej2B6PBY5uWsxh4+3x+37Zk20M39nBXDk+kcaR3yT2iWNe6tq8b6u/YMxgDb98GfI+VA/A9tDOqgcnmaM4cupBW2JW2gxL6R76iTlLBXlR4CelJ7RBV5r7E1kO5B7mSnhKjxhWy72UOnoVWY6ZFzMsh+iVg3XGi/q4X75vQA5gn8TIjXNrw0/fRVx+fTdKwofU970kdz3sr+jSPxoMS97uwpIxmHcRBcfvpFFpLoGKmf2MwOEnXlDotPeML1Iigef6iWJyaZQi/OzJZd0ntYSPLfU4dSZDUMr1CG/Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpRUg14P9xFbqbA3gZWnOUxpMq8IFFW9/RKhGUymuiI0BRlLGt0cHvdRaArJ?=
 =?us-ascii?Q?92K4xvIY/H3WAy5M0Hb5Lc6ua7d/iL0S79/8K2ZETz8GxMyigjr/z3aGpON8?=
 =?us-ascii?Q?G9IOPdY2N1GMJAhOo5JqrRV98x+xZTUka6K5DqsGnwBy2/Tt1D8xxEub1VD5?=
 =?us-ascii?Q?1chiRcLvwYGgoJp3iav6WmN3kqeHBz9IXxhwdF+fk3ILPIggT7X4Ybs4Xc4o?=
 =?us-ascii?Q?IwSiyHYRb/lJrdpyWqTg+NWTa5V8KTDI4kOp/1DaVIO3+C8MrFTua9TyuV7+?=
 =?us-ascii?Q?gJq6k14pwaA6H6mGPXpkS+KGt4Dq63kn82qE91pZ0vWwBOSBZ0VMU6JiqFmT?=
 =?us-ascii?Q?q6HQuWMF2tPXK4FkLd7U3k0euSOhvs8b/1YsIbzl/Pgi0EmQp/et4gYfTvqq?=
 =?us-ascii?Q?Qykqn4QHMB1M+A6Ullc+z5L06XOPWnuNetPwMQhoCTOvX5qYC9bp+0AYBHD5?=
 =?us-ascii?Q?nDtp8KTXOPQeEocUsiNUpEVnJeLUFmts6G7hZiCpjGyprlaB9JdYELBo8k6n?=
 =?us-ascii?Q?9MfNYiw7BnLrZtkFjXFXdcN2Aqjy+awF8VO6UbWvhXXa/xqotxPUsJqBEZF+?=
 =?us-ascii?Q?tSqJ4v35LAmoL7TRabsbYyKCJR1/BX4GAESxaAOvvyUaqL0QEfp7vGmSaQoE?=
 =?us-ascii?Q?EVrG2DjyVGp3rYDCj7TGhA6t0J3OFJDyUVn4FChlpYSDqgCBiFvUrK9HCNiH?=
 =?us-ascii?Q?DVk/dK2zXzZ2l7v2O4GXSR82DqvJZR/+0gWaXzmnVoU91+Ra1HQtd9MPc1IM?=
 =?us-ascii?Q?SN4jDPMJtidLwTgfZxi9YgH6/uwe/Q3UUKUc07mYyivbRk3Tnag198Z759qG?=
 =?us-ascii?Q?QQJQJtqM5PBPFEdnis3+chP5BB5qW7Mz7pYhHbB02NU2ZPxSroL6zpeJULgv?=
 =?us-ascii?Q?J9aFKhCisrfzdNK7uhKL7SqajH63seO7g9Zp4/qftbXUdRIlFCDpnGxu20fd?=
 =?us-ascii?Q?/fEFhys9O8LsnThGQya2BtbqZq71DB6e1r5Ah9TRxBneBowXkddgoBCrtdX+?=
 =?us-ascii?Q?y2ZUWajBDxzr2+T6WcbPgbpSVjpxftw6mKnuKplthhrqWmAz99rkOhVOOebV?=
 =?us-ascii?Q?KvlXZlHEwKz+0sARG2OsdbyhJG0dMhnnkTERTCmrI0oVldp8YS4iRgKY4Bnl?=
 =?us-ascii?Q?k0vpcbbNRo4ONgyQmfJw6t6tdnRrPzkuan7EP/TrlSjMEbpsmsBr3amjXFuI?=
 =?us-ascii?Q?Yvf40nMnPk8+y9wt7kiALMm0sRTbs/0X53CAgKU78lIJGM/OXRes7zKuS3c/?=
 =?us-ascii?Q?BjqIuysDaCIOX4MGesHQW0eweTTTaS2WkWYRAItz/VxLpc0awgSey4HBBLzP?=
 =?us-ascii?Q?MiGGbPwY4zXUFE20YpxE9BaBm9psMs/NmAT7+zTNgWVKwKUkw+G18LAGAX+L?=
 =?us-ascii?Q?KajrzrHyv8NCkmI3kGfCfRNXNtyjGhXdZT3HrP6Wnok4NhHReZT9i2/Nic+x?=
 =?us-ascii?Q?Q7DQD1ncEIcyIrtfvpxuCL80avgx1yYYP2h27KlSgSRgDwpe985VN+vigtzA?=
 =?us-ascii?Q?AnBCOs8p+AGZvQbDEHcPfdfa7OZ4Z9DimrHUkVvMjpR78xqGxDbjEuU5lkVT?=
 =?us-ascii?Q?4nWkY1a4EefChAVGpJcwMsneEtqRIetD9HS1aMju3yF5iwbpO6DYtL6NksQy?=
 =?us-ascii?Q?d1rXG8KXA673jG9Sc3zgPuGvwtAtzWxoWp8V8M3+qLCTzyMJbtTam/QoiDgN?=
 =?us-ascii?Q?uakBinz80psn/K4FrXZIMpsDuhIekXtrl0uZkG8G0sNyzktZNmXvbJNUtabv?=
 =?us-ascii?Q?yVv9wrEydZQX6ARzwBGbGX6PXyzCYeY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a6e815-8da6-40bd-c4b7-08dedc02a2e4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:01.4984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEbJBnENpne7oVztVUMfUWk0pcahkjl5WqS8D+iwCNgGrNWSIhmV9n9DmUk3mIA2B0CjjXRwBOcqi5PVfJbcId1U4sRUjL53W9hoKQgL5rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
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

Change send_dummy_bits() to send_dummy_bytes() as the FIU register
fields are programmed from spi_mem_op.dummy.nbytes, so they already
describe byte transfers.

Verified the changes by booting OpenBMC image on `gbs` machine all
the way to the Linux login shell:

$ qemu-system-arm -machine quanta-gbs-bmc -nographic \
      -drive file=image.mtd,if=mtd,bus=0,unit=0,format=raw

Fixes: b821242c7b3b ("hw/ssi: NPCM7xx Flash Interface Unit device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/ssi/npcm7xx_fiu.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 2d5bed005a..d41d877cfb 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -150,7 +150,7 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
     NPCM7xxFIUState *fiu = f->fiu;
     uint64_t value = 0;
     uint32_t drd_cfg;
-    int dummy_cycles;
+    int dummy_bytes;
     int i;
 
     if (fiu->active_cs != -1) {
@@ -180,10 +180,8 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
         break;
     }
 
-    /* Flash chip model expects one transfer per dummy bit, not byte */
-    dummy_cycles =
-        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
-    for (i = 0; i < dummy_cycles; i++) {
+    dummy_bytes = FIU_DRD_CFG_DBW(drd_cfg);
+    for (i = 0; i < dummy_bytes; i++) {
         ssi_transfer(fiu->spi, 0);
     }
 
@@ -305,20 +303,13 @@ static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
     }
 }
 
-/* Send the number of dummy bits specified in the UMA config register. */
-static void send_dummy_bits(SSIBus *spi, uint32_t uma_cfg, uint32_t uma_cmd)
+/* Send the number of dummy bytes specified in the UMA config register */
+static void send_dummy_bytes(SSIBus *spi, uint32_t uma_cfg)
 {
-    unsigned int bits_per_clock = 1U << FIU_UMA_CFG_DBPCK(uma_cfg);
     unsigned int i;
 
     for (i = 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
-        /* Use bytes 0 and 1 first, then keep repeating byte 2 */
-        unsigned int field = (i < 2) ? ((i + 1) * 8) : 24;
-        unsigned int j;
-
-        for (j = 0; j < 8; j += bits_per_clock) {
-            ssi_transfer(spi, extract32(uma_cmd, field + j, bits_per_clock));
-        }
+        ssi_transfer(spi, 0);
     }
 }
 
@@ -354,8 +345,8 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
         ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
     }
 
-    /* Send dummy bits, if present. */
-    send_dummy_bits(s->spi, uma_cfg, s->regs[NPCM7XX_FIU_UMA_CMD]);
+    /* Send dummy bytes, if present */
+    send_dummy_bytes(s->spi, uma_cfg);
 
     /* Read data, if present. */
     for (i = 0; i < FIU_UMA_CFG_RDATSIZ(uma_cfg); i++) {
-- 
2.53.0


