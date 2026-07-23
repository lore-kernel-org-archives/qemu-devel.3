Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525BCC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvD9-0004Bk-10; Thu, 23 Jul 2026 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD5-0004Aq-7Z; Thu, 23 Jul 2026 11:19:43 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD1-00081v-L0; Thu, 23 Jul 2026 11:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZafuETjr3t/Bne/RGzmqvgxPHmVB0BxmmwGS1OAspZhMmhwkxEkRX1XmogajMF7YXUfCfIhDLcpYU02NfAkGV/w34B54SIPqMu1puXWgM9HgB9URi1HM6bGgfSKOBhllUR13bGwkWjTzMNU1EHp6o20lnSpGg+51XiUQqhxX0dWRvUADDnBwj3PK6242jVBfSA1OSL+qSu4wCzuj5NKAWYM8oBwSRG9bR9T3BK6aE0Dy2Mfq5U/TWqzybwNRcKPTuZqaQ9gnEL8JGt5eFZXto2rdbTY8vj8IGaYTYHX7mBfh/HGEp0WWCCC7gR8CaD4yKd7blS0a/ZvMxzLtdzogSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNCBzkDO1fAiMAC8JrbtkNMAd1gWM0VhYkBiE7rxsG4=;
 b=O/FEUms8KVyhI6mjRm0NpO3LjetLOyKOrEoL3WR5Ac0bhXUKipV1kGsYd4/8MGgRunWspGR10htBD20ckQy5gis8IwnSqFY7sWxuYKJztHLNUkgwd3sDRkitj+h1mIal6cq2XLCebNWWf9FOgLRLgbT3BBRNZ+yuCNnI4ipntom7pEj2lZtisWIqLuAkaID4mmwMmHv4wo+5DcTLDqEWQO5RvdCAV4gst2UH6Xyk2fDSsAcm0HJYgYla8o5PktIKYifWi1Ranbyk66sdYJRqx5WM6stPBV52wwenG2j3qE7HnHlGUPSrJIonHXNtE94o7OApIvKO1BW+w2xlfJ7ZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNCBzkDO1fAiMAC8JrbtkNMAd1gWM0VhYkBiE7rxsG4=;
 b=M/Z6U8YSMM5Jyifuk5dQuTvoIb8WTO/jU7cYGmZcDSoTd6J63Wir7fu3epKLqLbNJm18+W5r4brpvKsQCc42E3w+KQa1I+/pogI5gaP3NthW/ZVCszI5ZmxeMx7WkhTeSlDxSc9sy/HanxkIOAZaQi37fVwauPERBQ/OfmBr9AznMp8NoYOw1J8rPNlyofXhDstqFh82/fzNko2/2bWlio2eqme7MQJKCSW9hcxnTH8EabR5/QiHw9OjGFTrvcO4l7DP+msfhyCYiOZ98iF+gbhM9db9uBbygN8n7b5F/zeosWi2SBE6C8GVCjIy2Ym9Q/idps6rJd7kLcSjTk7T9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:25 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 09/26] hw/sd: sdhci: Use version 4 system address for SDMA
Date: Thu, 23 Jul 2026 23:18:36 +0800
Message-Id: <20260723151853.2143177-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: a3301436-e819-4144-d8a1-08dee8cdc801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: s5iyvTFlw8fZ2tY3CU593DBRjXm16cgFWbYsTevugH7j3GG1jB9vXBRqO1mcITo73DBBF9UOwxI+kfIHLCYFLGPqzHHjEpDuTClQLpK59RHBWBzQC1zVQhiVZvRFplrJ/WpAdxOR9Tr+qdMUb/UuooAMf/XTjyUApSEzUgmOe0HaFsJRJY8Z+/3rZhSMwsuGTy80vJuXIHHaLlI1Ga7l6AMcOV7dpn33ZeWCMS0QmsPlX4qXQXi9hXSgtLz9PcNFV8mBUf6hUvpuQm9SbGMHGEpWZIJKPEdSIwf9LwtBB+VgEOuV7ydjNaNT/83HtRnLfaVYwKBaHg0gthE1ESsjhj68HnjyWXkNEYp65PDTGY21jsQsKLGL+aoibcWP0hRulYuK4ldD+r37gF++RmcJuXyAsNaPXJ8Bs80lmxB3QMF3IVJm36AHiAA5pnZOKA/Dh7Z5UAX3069yISYHjTB9Bi2GdhARGUDg4GpHElVrWJ6G/Kp3HY0oa3r3QsoVWic7CouFixJDsm3EedOpVkbgrC2dgUP1uazrNEeiEcKWByseYljHnmVdctSiRQqs9id/FfIxsvezradSb8hDUV9FTe+bBHGZGbOVdtxPBde+Rd5I5oBZ+eMLONLlbdEnyIkyIGjV1PsDRl5lTnz/taLZ/QhEx9coIQRJvPZ6PK5MjbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7qyo5gz7UdEKOT107OU/4DEjvVKjizawcSHeLiRsFgY2bxoo4mWHdRFrT3d?=
 =?us-ascii?Q?2ncOjcpK9cIS7KBf4MvbJjqiaHhdv1heIL470XmEsTfkMqXWp92+4uQiC6fA?=
 =?us-ascii?Q?5x2BptQ1JoE9mv3vdOOVHTIs+qVkOPDc112l4yAjDJyhpxKj5qKF6KhzQvBh?=
 =?us-ascii?Q?6154QXId1Xslw8qs4VgzdMz+YUhKmoZf5aX5VtXkXEqBf2SNJDKqFseCzWRF?=
 =?us-ascii?Q?tksS8DUcyDJqMRjyeijwnw5pnJUZIBO/Irzohe8NHrVqo5kO3lyT+JKupoj1?=
 =?us-ascii?Q?l457+SW5OVgziGFu5SklpfhozJC1vIt5m0TX6g6R6feJlvmWbWOUV5cB70Ae?=
 =?us-ascii?Q?75ChBKxdzY+KGX78JJ+LKFvaVc8MDOyqAc2IZoYKauXMo961y0RXLGA4R6eZ?=
 =?us-ascii?Q?eOszoqZCCDT7dYiNW3xQ1KCL+dsnaQ7xzT/2mnRHD29msfftsstK5MkfJbhV?=
 =?us-ascii?Q?em8cirmkykP/qsLxC4pKNPQ/T1iZPzUuAmfXaCLpst2Aa9JacKcxgGqVLk2Y?=
 =?us-ascii?Q?PIy2CMCqQFxRXHsO8bFnxKDaK2IRILXqfk1BUhW3wL69vXSOBFDg8Qi17sxB?=
 =?us-ascii?Q?/GiY6fgQng4zHs1qfXZ0ITx2FUabCMCSTx9g3zjH0FmyqLs/Da1M0/VH8AfW?=
 =?us-ascii?Q?xUACmrX7B9m7/k2dLvh6vn4cI72lW08W41TXDkG02lwsU0AzQ14CkLHd27AA?=
 =?us-ascii?Q?y4us6mOcu1rHzv2H6zVGAj7/cTexJ5a/097gw4sIrgnPr01cEzMMjiXEVxtQ?=
 =?us-ascii?Q?qPXBE3oyojxQ2QLc27XwxQsba9jXjmWJHBHCv5igJFMF7ArJacTiZ8GJ1VL0?=
 =?us-ascii?Q?cQGDj7QP/dYxvAzSX7YGlEmJtVhXDKVLfDbQdY1FRjhAcdOg10/QDxZjgcdd?=
 =?us-ascii?Q?MPOx2b3RDBz4O8GC4BBbr0uzlqNVWtZlErioXeRmC1FxPE96edZaJpBmI7U2?=
 =?us-ascii?Q?FF479+L6aFOLqyRe9x3P8vs07tmey6N+ZjqKgtr3bLec7B3nro1mmaBWZGla?=
 =?us-ascii?Q?43ltO2Tn0ExpaKhrb6ZsUsuKtND9E8SpGOKutzc2ill+OgWoiNIVL9JARfyg?=
 =?us-ascii?Q?YsQWGLzkdUqU1rD7efLQVcKclRQEaa1hn+Ty3ek9mg4pk3KFcHc2VMEP2tia?=
 =?us-ascii?Q?YrXFYfyVRp6mqZH99wrCwPFrn5i5Zt8TYu8Bx59tY3dhfLa9w8iCKQglysUk?=
 =?us-ascii?Q?Ri5nk3O0gOSZrFDV/yB0owBGLVz4ZOI5VyJgSEy6sb0Fp01zLG1tR8od3AXh?=
 =?us-ascii?Q?+sD6cHLXkWqBUyOxPpay+2eZ3CIAGGRUO6EHRaRmxoxS8L9lDdxcScagWlX8?=
 =?us-ascii?Q?fj5GP9pVP0kYp6GbkkWlsj6JZpgi4/tTObzZgblx8FFkdR6MPDEq0WudtMH9?=
 =?us-ascii?Q?mH3qkofeZNFx2ScAZSmMz7nvCNm0SWsKfSW+yYqZzktdLcDd/uD57aEnvVOI?=
 =?us-ascii?Q?BydJynXusaz4aHztgqjLwKzboLytm+1+/jCOv+lRG0mWiLfteQNhYPNjql5X?=
 =?us-ascii?Q?PZ0FNCK7kwPw9uPuPBYlwsS/U6xuACOEga7vi27tSD7wag5eQL5SQAS9RC+V?=
 =?us-ascii?Q?FoMZVoVjyJNPv9ON7PFn60AEj9yqhQvHI1cCPwk/+SVa6qUyVaCrcPTOsARu?=
 =?us-ascii?Q?8dp8kptFvJWoehZWdkiDPzXXsyyJ5milKAZM2nj2+/mdHuiz/Gt8Ra25DaQk?=
 =?us-ascii?Q?xespYyHjcVEnGLX8rHEUVddB9P12RB+b1xdxdr9tU3JDqJgx5whnrhfmPfEY?=
 =?us-ascii?Q?ZasozvjOppTFcw7cNaXdltXBQmYJv7E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3301436-e819-4144-d8a1-08dee8cdc801
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:25.6413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6N/kV8cjlYybbposY6zH2IjaQ8weCbNZhEOroJmWZNcbp/F9kHpE3f/Q0USpt8EN7bO0gnY9LNDTQq1oOQJ90+GzGJzeuzQhiWH+cNxml4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
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

SDHCI version 4 moves the SDMA system address from the legacy 32-bit
register at offset 0x00 to the address pair at offsets 0x58 and 0x5c.
At present QEMU always uses the legacy register, so guest SDHCI driver
with version 4 mode enabled uses an incorrect DMA address.

Select the address register from Host Version 4 Enable and honor 64-bit
Addressing when reading and advancing it. Keep the existing offset 0x00
behavior when version 4 mode is disabled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 63 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4aeed120bf..2116995dcc 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -201,6 +201,7 @@ FIELD(SDHC_HOSTCTL2, UHS_II_ENA,       8, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ADMA2_LENGTH,    10, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, ADDRESSING_64,   13, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 71af1f8c57..d2132035eb 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -598,6 +598,41 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
  * Single DMA data transfer
  */
 
+static bool sdhci_version4_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4);
+}
+
+static bool sdhci_64bit_addressing_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, ADDRESSING_64);
+}
+
+static uint64_t sdhci_sdma_address(SDHCIState *s)
+{
+    if (!sdhci_version4_enabled(s)) {
+        return s->sdmasysad;
+    }
+
+    return sdhci_64bit_addressing_enabled(s) ?
+           s->admasysaddr : (uint32_t)s->admasysaddr;
+}
+
+static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
+{
+    if (!sdhci_version4_enabled(s)) {
+        s->sdmasysad += bytes;
+    } else if (sdhci_64bit_addressing_enabled(s)) {
+        s->admasysaddr += bytes;
+    } else {
+        uint32_t address = s->admasysaddr;
+
+        address += bytes;
+        s->admasysaddr = (s->admasysaddr & 0xffffffff00000000ULL) |
+                         address;
+    }
+}
+
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
@@ -605,7 +640,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
-    uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
+    uint64_t sdma_address = sdhci_sdma_address(s);
+    uint32_t boundary_count = boundary_chk - (sdma_address % boundary_chk);
 
     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
@@ -617,7 +653,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly
      */
-    if ((s->sdmasysad % boundary_chk) == 0) {
+    if ((sdma_address % boundary_chk) == 0) {
         page_aligned = true;
     }
 
@@ -639,9 +675,10 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            dma_memory_write(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+            dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                             &s->fifo_buffer[begin],
                              s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
                 s->data_count = 0;
             }
@@ -660,9 +697,10 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
-            dma_memory_read(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+            dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                            &s->fifo_buffer[begin],
                             s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
-            s->sdmasysad += s->data_count - begin;
+            sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
                 sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
                 s->data_count = 0;
@@ -695,10 +733,12 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 
     if (s->trnmod & SDHC_TRNS_READ) {
         sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
-        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                         s->fifo_buffer, datacnt,
                          MEMTXATTRS_UNSPECIFIED);
     } else {
-        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                        s->fifo_buffer, datacnt,
                         MEMTXATTRS_UNSPECIFIED);
         sdbus_write_data(&s->sdbus, s->fifo_buffer, datacnt);
     }
@@ -1365,10 +1405,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
         if (s->uhs_mode < UHS_I) {
             /*
-             * VERSION4 is writable even without UHS-I. Preserve all other
-             * Host Control 2 bits when UHS-I is not supported.
+             * Version 4 fields are writable even without UHS-I. Preserve all
+             * other Host Control 2 bits when UHS-I is not supported.
              */
-            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK |
+                                   R_SDHC_HOSTCTL2_ADDRESSING_64_MASK;
 
             hostctl2_mask |= ~independent;
             hostctl2_value &= independent;
-- 
2.34.1


