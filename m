Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E483CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjF-0005YV-Q9; Tue, 13 Oct 2026 21:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjD-0005Xt-G5; Tue, 13 Oct 2026 21:24:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjB-0006ql-8H; Tue, 13 Oct 2026 21:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCQk67VVvSuEZLTh8r0EaRSaqq83K+7i6sADz8SBZsta5W17HTp99y0Rp7Lbr1cOktFVzc7PMEgNuQuHEGueJIccieOy73b1vn46RhEkVXvfFPxSRdMZPrvEEspqDBgQ52vv9sCu8c0l6aiwGsDRCC6/b1xXchFuMkiT14CAk0a7GRr3SsPmuBi0Vj0vzgf7IVYJ5uEBtQjvjGQ9SoiCuXSfykLackQeV18D3pKHqdoNiyW//RsmP3MF+ILimdgEzESZYZYZx3OOjmW1OTRII180FoDbeEnFAmT926lYJn/wv0HsjPBabr1ITTClIOSMZ3CNCsdeK/Nf54HomtwDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r/w99dZwbKT/pClZGtSSvKoAZ4qGmVWd1cVYae2L+8=;
 b=xJBtpzyLTD9SFR0H5yEb2Zg4qw1CQFsIkq2vKzYH2Kc4hp9wDPMOEeCjiTkkCayeiGtB4wmLQWU20lwSxVc1DgUrmHzuka8fFIrrPWqty9KDUMTNQY+GfCBaduEsPcqpAGrlUM0gFpf4/e5W+BGCH7MpnE1+e/WeWX7MnRNXonnZ2B+tJ4LE+u2Rg7yZ5uEv7r6CIXtJhYW5cFaJhoi0+Nh+w7molROvwk78wUSLy3f3otQYZXn9Q1h+WeaHHb33elpcnctAM+N1b26XFcT03My/fWd4o4PNviHqKpkb7fxxCxV+izLfP4lVdq16ud7Z0DQtWVnJ05j8Ec9b3tMYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r/w99dZwbKT/pClZGtSSvKoAZ4qGmVWd1cVYae2L+8=;
 b=eJAZysG/c5clGyrEPjPpYR9UxJxyFkLsZl6pjgplkmRYmLw60xgDV3Fo0wVFNY3zY0KmnkhUVIDvJtTUYVWNy8GpuFdkZyycVb8c3ZmYM9qe4xX6yhwADlJ6yJG5i5OvEHAJhLd6/mxZV3PUGz9I7IOjADSY7ECqj4AjQthggOVaKVyT38fTUZeuO5em0GtQVPXcPB4MDd6QrqgxriedflcP9LHPcUxZcVIm2JtVH8vwELqt6YRUiCj13WJOvaNrErD9gtKFiase/g71ew//hqeiBTg8OBWh7GXkNoMeZ5hybLPFgZSjX7d6dEC1elA9sOa3X6w2MopSvtbDuVXNOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:10 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 09/27] hw/sd: sdhci: Run ADMA independently of MMIO
Date: Wed, 14 Oct 2026 09:22:49 +0800
Message-ID: <20261014012323.322790-10-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: a64377fe-8d60-455d-3949-08df2991d942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +0dxDfzRLBv3pkmq0gVCBPYntK87YHg9ZhE3NWhfZKQVN5fEF2YOHXQYRaPAQNvFhfCil2qmAKVsQVCIkuLtjyJT/NbUeM+fLefIS8Hr3VJHgh5Lk27Gh58aHVl59pgo9on83gUg+WLimQYlU94r9ySc6RS2ZQPnzukTJzrtcyou01A6Ps7nQDMdxR2kVQOjtW1EkO2tHLkmo+loj69oC+0eglewvAZ0a2PpCfKpZgR2iAT+UboLDrCCAwFtz6Qi8JRZ0pPd9JwzGaRN5T8jX5q5mctw0yIefYP13l2OECUYA7ygbzwbX983I05aui/5yhQb0TG54UozE4jYS7CNRDH/V0YXz2RffVGVjg84yeakvVko8XdQrZsbBPMu0tpmKnIjRHc6OnnLz4gis5YJvFjqhpviLjRzIcoZf7LvTI3wW/40/jf2GfIq8c0okA15Sl5+ze1ETnASds1Z9H1v88LTBeOfdrMDs5LZDX4b3HVMrzlqTjWn7WT5SiQcHj5Q7iyLxo+HgERv0xyxmx9hgDC3dIfvE129bM7B/HkuEMap2oAIMHPn8mk+Mzol219z5K32vWJL5hMiH4IERdP/FIpcPej0akEF3ZCx7IH4+SKmygsCtjnMfXBNyJzPffiagFZVuXzQQHEGU6oFHA/XxFPqFPjbc5PNC+G89oEae1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUIgOUwdelkISQeolgRIUM707Kxf64/gzloJGCf8SPGIl3D4qCV6lmpSKmO/?=
 =?us-ascii?Q?VCK+n93jVCUbqT9jvqQiHQtZ/sX+oyPSk1/W77C3ljfIGbeLnBPNmfij0MK3?=
 =?us-ascii?Q?93wAXd795T0fhT/NZzqjODQ04Duu/EP35/yPlbWjbGg3kef4loFQ57LHIRdZ?=
 =?us-ascii?Q?Ei1TVQC4wpYuGX2WClFwH87w9tvWcjh1t4MtlO3zcG5AriphEkMc1QM0eXaI?=
 =?us-ascii?Q?iNaGSJi04AkirPO1nNK57fy/j2LTGC1RGUTLLOP220/kriwD3FfQL3Ya7Usy?=
 =?us-ascii?Q?b1XTrflVNrRnEanYslbVytXiCbAo0OKY91BOu2zIq76+1lRuckZh0ZdeyrNN?=
 =?us-ascii?Q?JtxcWkJ9EDLMb8HfuZe7JJpmB4jzAg/TWjZwUXsvmwtOKXUrTx9W0vOQD6GX?=
 =?us-ascii?Q?ZE/E4E4L5Dhnnuh6RMA4DesWA/Jawz18S5vc5F4tOKhi0wZl0siat/aspE2L?=
 =?us-ascii?Q?LK2NhdWt2jkGRvIQm8C5mjCL1W/Jc9V7o+E2/BNpOp4CTj/S1dF8JkrEm6Z9?=
 =?us-ascii?Q?YABCMRffYqmfUd2puzIlpFUb0rZL5t2IhAWolEVelTcWYSWxJ68XiM+ps6qQ?=
 =?us-ascii?Q?e1VI/hGKIdDU+hLHUIlJo4u8GBWdkOpn0XMN4YDLyMA7Qq3XMXISwZxXNN3W?=
 =?us-ascii?Q?XZ33LeI7PMl23DBIDGtkfSQqqMaGeE9aHTil7jiSYi2e2as8npHZGxxOmNVF?=
 =?us-ascii?Q?M97DMmDKl0Bcab2MneWn4ve4h236f83MqIzAbDzOhfHrBxaeyctX8xOAJbff?=
 =?us-ascii?Q?6RdOBz4z68uz217oH67H6mfZjVh1GZc0dbIQ1F+iWwuAPex6zoZj6WasNh+B?=
 =?us-ascii?Q?l3BlHM6TtYWX4gdhpMh61IGlyNSM0FkmDCEYdriKHBUllbxOifWE0F8gbd10?=
 =?us-ascii?Q?7sjY8KbUgnnNKAJI6Xc6+bZLHcbo4+LH8Gk2RKIcJ9UHwUfPUoq6BTH+aObP?=
 =?us-ascii?Q?fdoTrAXW63yuFqARDAKfwMlKYt8DxW3XVLNtkpPTLTFSqQBgIKvg/vJQurHW?=
 =?us-ascii?Q?2sFue+YYwguYLJTyGUhg9azc4YWX0HFsOy5kb3sL2d5HH7GhTJejZ3E1jFEM?=
 =?us-ascii?Q?L4Xy8FakSYe/DJX/sO5teH8ve4R1F1+ETQ22VOfiGDcid+ykHpEnR65rGYQy?=
 =?us-ascii?Q?oVw9Hr0XXDfh2Kpi+h+yT/ZgZfrYjOYcuN0BUnfezilw/2OOnqntHAvsLxIF?=
 =?us-ascii?Q?r9Svj0x/x6i/EHWmOY3qtl4uHjtwFsXibhPfPKv9an3gcskON40pzDfK5QAD?=
 =?us-ascii?Q?ULSkNt9aZZVlvhVqHLEN2kruvVv0y47/dMOKhhbNHBclHA5xLQLTPvyGMWes?=
 =?us-ascii?Q?2odR4qEZ5z3pqkLBbXDHiHMfBdpdnWIFyIqWsHWh5n1p7B1S6qPUrI+OR0Td?=
 =?us-ascii?Q?lZatggCyMLYuhRltJlLkxqYHVgjPLusZc5n1OlvzTqSOOldwilpygzRZGqtj?=
 =?us-ascii?Q?EXCpvtmjSbIEvsZ3RNk2Hkn2vBlmJY25ZL4cX9MIPorONbjYol9yyAr7KvHM?=
 =?us-ascii?Q?TxrUKrr7BKYdFwEMxSN19dA72A6MWekWSARsHBw+oYC9dltBG0IZbf42uGnZ?=
 =?us-ascii?Q?SxeLN8nR+ObQcthp+z06gCU95HrsqME3D+reqdYEw+WFOT5batQ7HzYZzsJo?=
 =?us-ascii?Q?uRQ3YP64newQH+3/pXZzkYhrt+wFtiIa8/FLh3SO8FDt16Rmhj9Eb8302xvs?=
 =?us-ascii?Q?V2tmHSuKLLfwBdND1vEvgfabt/zi1rp60wcp0SaQn4ixmodV3ZFl7qd6xxXW?=
 =?us-ascii?Q?PbfFBiyoWSXRWKQ9pxjgU1iFYe4HpDE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64377fe-8d60-455d-3949-08df2991d942
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:10.4383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrTOXh78zzvJAg5DeU08I/jIVJPwGsqeEDfhWIZa94n40Og6lrkYfzR/unm3hB3PIFjmThkeMlrs6j6fepkGjSJDXRRWFnhTocUejaBdSPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

The SDHCI model processes the first ADMA descriptor batch inside the
command MMIO write, then resumes pending batches before every later
SDHCI MMIO read or write. This makes register access perform bulk DMA
work and can delay a status read even when completion bits are set.

On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
19 MiB FIT image from SD. It can report:

  Timeout for status update: 00000001 00000001
  Timeout for status update: 00000003 00000001

The status already contains the requested Command Complete bit, and may
also contain Transfer Complete. However, reading the interrupt status
first executes a pending ADMA batch. The MMIO read can therefore return
after U-Boot has reached its one-second polling deadline.

Turn the existing transfer timer into an ADMA-only engine. Starting an
ADMA command arms the engine directly, and each timer callback runs one
bounded batch before yielding. MMIO reads and writes no longer perform
or schedule ADMA work. Keep PIO and SDMA synchronous.

Cancel the engine and clear ADMA activity and error state on DATA or ALL
reset.

Mechanically reorder and inline existing functions per review.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>

---

Changes in v4:
- Drop the unused ADMA callback forward declaration
- Move helper definitions before the data-transfer declaration
- Merge the ADMA timer callback and batch routine

 hw/sd/sdhci.c | 146 +++++++++++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 62 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f72..0c5b0ed984 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -277,6 +277,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool level)
             }
         } else {
             s->prnsts = 0x1fa0000;
+            timer_del(s->transfer_timer);
             s->pwrcon &= ~SDHC_POWER_ON;
             s->clkcon &= ~SDHC_CLOCK_SDCLK_EN;
             if (s->norintstsen & SDHC_NISEN_REMOVE) {
@@ -348,7 +349,33 @@ static void sdhci_poweron_reset(DeviceState *dev)
     }
 }
 
-static void sdhci_data_transfer(void *opaque);
+static void sdhci_set_transfer_active(SDHCIState *s)
+{
+    s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
+    if (s->trnmod & SDHC_TRNS_READ) {
+        s->prnsts |= SDHC_DOING_READ;
+    } else {
+        s->prnsts |= SDHC_DOING_WRITE;
+    }
+}
+
+static void sdhci_schedule_adma(SDHCIState *s)
+{
+    timer_mod(s->transfer_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+}
+
+static bool sdhci_adma_transfer_active(SDHCIState *s)
+{
+    return TRANSFERRING_DATA(s->prnsts) &&
+           (s->trnmod & SDHC_TRNS_DMA) &&
+           (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
+           sdhci_get_dma_type(s) != SDHC_CTRL_SDMA &&
+           !(s->admaerr & SDHC_ADMAERR_STATE_MASK) &&
+           !(s->errintsts & SDHC_EIS_ADMAERR);
+}
+
+static void sdhci_data_transfer(SDHCIState *s);
 
 #define BLOCK_SIZE_MASK (4 * KiB - 1)
 
@@ -405,7 +432,13 @@ static void sdhci_send_command(SDHCIState *s)
     if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
         (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
         s->data_count = 0;
-        sdhci_data_transfer(s);
+        if ((s->trnmod & SDHC_TRNS_DMA) &&
+            sdhci_get_dma_type(s) != SDHC_CTRL_SDMA) {
+            sdhci_set_transfer_active(s);
+            sdhci_schedule_adma(s);
+        } else {
+            sdhci_data_transfer(s);
+        }
     }
 }
 
@@ -848,10 +881,10 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     }
 }
 
-/* Advanced DMA data transfer */
-
-static void sdhci_do_adma(SDHCIState *s)
+/* Run one independently scheduled, quota-bounded ADMA batch */
+static void sdhci_adma_run_batch(void *opaque)
 {
+    SDHCIState *s = (SDHCIState *)opaque;
     unsigned int begin, length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
@@ -859,6 +892,35 @@ static void sdhci_do_adma(SDHCIState *s)
     MemTxResult res = MEMTX_ERROR;
     int i;
 
+    if (!sdhci_adma_transfer_active(s)) {
+        return;
+    }
+
+    switch (sdhci_get_dma_type(s)) {
+    case SDHC_CTRL_ADMA1_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
+            trace_sdhci_error("ADMA1 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
+            trace_sdhci_error("ADMA2 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_64:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
+            !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
+            trace_sdhci_error("64 bit ADMA not supported");
+            return;
+        }
+        break;
+    default:
+        trace_sdhci_error("Unsupported ADMA type");
+        return;
+    }
+
     if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
         /* Stop Multiple Transfer */
         sdhci_end_transfer(s);
@@ -956,15 +1018,17 @@ static void sdhci_do_adma(SDHCIState *s)
             }
             if (res != MEMTX_OK) {
                 s->data_count = 0;
+                s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
+                s->admaerr |= SDHC_ADMAERR_STATE_ST_TFR;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
                     trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
                     s->norintsts |= SDHC_NIS_ERR;
                 }
                 sdhci_update_irq(s);
-            } else {
-                s->admasysaddr += dscr.incr;
+                return;
             }
+            s->admasysaddr += dscr.incr;
             break;
         case SDHC_ADMA_ATTR_ACT_LINK:   /* link to next descriptor table */
             s->admasysaddr = dscr.addr;
@@ -1012,50 +1076,15 @@ static void sdhci_do_adma(SDHCIState *s)
     }
 
     /* we have unfinished business - reschedule to continue ADMA */
-    timer_mod(s->transfer_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+    sdhci_schedule_adma(s);
 }
 
-/* Perform data transfer according to controller configuration */
-
-static void sdhci_data_transfer(void *opaque)
+/* Perform synchronous PIO or SDMA data transfer */
+static void sdhci_data_transfer(SDHCIState *s)
 {
-    SDHCIState *s = (SDHCIState *)opaque;
-
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (sdhci_get_dma_type(s)) {
-        case SDHC_CTRL_SDMA:
-            sdhci_sdma_transfer(s);
-            break;
-        case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
-                trace_sdhci_error("ADMA1 not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
-                trace_sdhci_error("ADMA2 not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_64:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
-                trace_sdhci_error("64 bit ADMA not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        default:
-            trace_sdhci_error("Unsupported DMA type");
-            break;
-        }
+        assert(sdhci_get_dma_type(s) == SDHC_CTRL_SDMA);
+        sdhci_sdma_transfer(s);
     } else {
         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus)) {
             s->prnsts |= SDHC_DOING_READ | SDHC_DATA_INHIBIT |
@@ -1098,21 +1127,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
     return true;
 }
 
-static void sdhci_resume_pending_transfer(SDHCIState *s)
-{
-    timer_del(s->transfer_timer);
-    sdhci_data_transfer(s);
-}
-
 static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = (SDHCIState *)opaque;
     uint32_t ret = 0;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         ret = s->sdmasysad;
@@ -1235,7 +1254,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->norintsts &= ~SDHC_NIS_CMDCMP;
         break;
     case SDHC_RESET_DATA:
+        timer_del(s->transfer_timer);
         s->data_count = 0;
+        s->admaerr = 0;
+        s->errintsts &= ~SDHC_EIS_ADMAERR;
         s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
                 SDHC_DOING_READ | SDHC_DOING_WRITE |
                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
@@ -1244,6 +1266,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->sdma_boundary_paused = false;
         s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
+        if (!s->errintsts) {
+            s->norintsts &= ~SDHC_NIS_ERR;
+        }
+        sdhci_update_irq(s);
         break;
     }
 }
@@ -1257,10 +1283,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         if (!TRANSFERRING_DATA(s->prnsts) ||
@@ -1521,7 +1543,7 @@ void sdhci_initfn(SDHCIState *s)
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                     sdhci_data_transfer, s);
+                                     sdhci_adma_run_batch, s);
 
     s->io_ops = &sdhci_mmio_ops;
 }
-- 
2.53.0


