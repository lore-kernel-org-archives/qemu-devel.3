Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CDCA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD395-0007Dp-Hk; Sat, 03 Oct 2026 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD392-0007CB-RJ; Sat, 03 Oct 2026 13:03:32 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD390-0007C3-KS; Sat, 03 Oct 2026 13:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox20Hi6Nfwspw3mJzCVTBS4XbH/LAwlbZZVhqJUbAswLORfpdOpS78KwGb13/YFIIWJMGwGRqqLvDYz4KtdOSToAqLPf7rYXDvmrX1s4ToEZtNGpDMytaAiRTmav/zrswcNH6RyGPmo23iZKSMamWm7wjlQYSaZdS3e/bL5x9zaHe023hpFE9FXLRP7jduQCYbnR3kgmlOITxhp/++QBK9o+FMHxUFlnlr0n1Mkxer5PJm3Fns+BSSVyJMVRI9aFWLuzblAboGHgm2MW3YIAyFPv+wuIU2srYXY1sA4vIxRMFw4ZYZbsFHPEIhDxpioY24bacK3Za6ieucYNAIxsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cF/iFg+G6KhGDsFbCEr0inKuedS0e6jhOZQjejKnLA=;
 b=ZxPv1bwWpvYGtxOZohcAvze9fdBAmbF3SMqY3rdANpMbXrhUIXLNI4t1ur9/IBLWo1R46gANgDPUj3X9LI9J2ih7VDXNhj3FDT7EGKDZ2m8BAiKPT5Q4k4NhMkAhO18MsQmDIfVGtLkN5w+Be3QJf4rC36oQhZZblr5uP4eWrpJoBaRftZRcAuAIlmSFR4FTqkCQqlMH3DpHh+tZpXsZr5oSmlqpdVB/09cDHKSja0AKK+pdSAFdehLfkU+B+CXttaO5JRP0yJZ5xofiynxbf3J9B+5VYSZCrelQPAW608JgBYhGMel/FIprak4yOMDixERJ+FNkjEoC2p8MiCSlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cF/iFg+G6KhGDsFbCEr0inKuedS0e6jhOZQjejKnLA=;
 b=CJjdCaBeUG23t6eIaci90SmVZ6tq6OspJDZ9APlZz+VOueLsrpxH6rwC+9ncde4/r1TjgkIfWn4zyHmzZMr7U7eSbCVRm0jCTSxVghXn+xQ2ZO+gqYSKNLzbmwhcEbW0IcO9PotydsQkiOExyBfwgaYdG12fZwG9p/6oMWD/w3TWo+IXmokEIHPBQBErSXnIG9zcy+wcLf64WUSy3Z2tPkEPar5nTyTwOirFQgOu8ijg8sLbfeyCTcsqWrQEp3ZRM/Sr6tOcIdJRw+fdINClrC17wrBluditeyQ2o6EmflNoqv5mXjCjJ4Cujk+uFV9OBM3jy9fvXSoPovTUGjaVQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB7371.apcprd02.prod.outlook.com (2603:1096:405:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:18 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 09/27] hw/sd: sdhci: Run ADMA independently of MMIO
Date: Sun,  4 Oct 2026 01:01:59 +0800
Message-ID: <20261003170232.2450916-10-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea86b12-79f4-4359-797c-08df21703901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OMVGGOAbUnG3JU0ZIB1QlpVzVRICAipHwZoPRNmZYw+7oq0hQIPUoiMnrXkSvv6s/ID8yE/Lw2Kmz0YKJKgOawLE4Ty4nqdqzJ8AOPAfIoz9H6B5zeIdZXFEOjzw9KxRWhSOaLgUAnOfBvs50NiUlIVOFb+Mng6AOrOdErL+h3yk0rDO/rKfrIlLSoYkVO4vVTm0iF316JbAoZGXZQtpRTW6hdRSy4hsIhKiYXf457l9cuwiMr/9geevAoS/ceHbCJss4oP+5rSvrSQ5ycnJCxO8MNFA05NzmgIcTcBnJmnPjpQP7Q6A1194d4qpoAsCcgT/5l8uFqtW6Ph73hsA2O1aSXgmJdXmrfRzUlYyWL7zl1LBmXwt5ganQ8SLElec67zVrDT/YcQhyRCUkfGzukJckyTqFGwVA/7U/cCIYIYRvpKYP+A583HrGRwvl453f7Y7WFxVeLkp4yXqtIn4s3W5GRp9XF6eA9IZBi3+OLynoo68HgdsSs8sfXJwE6+JFqVxNeIwJqZ4A69zwfxXHi3zFlio4C0lYdTIZh3K4wYZEY5/EG9I1+MEPCM3mbHkgK5aiKLeANQFSls7CaQLHY+6kFx8T3M6jv0IuTj+czvddYAlGGMnA3glivgFmUCjEqGJ3gHlOOCevoxBk6PUe/h3CWouX/YcCt2VKQAd6no=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOEUxhROG113HbGcUPQk1EiezC6EuhA5TJ3CHaBGWazCKL/vITnAKgbo8D55?=
 =?us-ascii?Q?AUAx+dYu2bpFpKBGBtyj4vvV+QFGkyt5UK7P6JNCivhf/kwGeyTyFW9l/LfX?=
 =?us-ascii?Q?512ig16IpueeDafyVSGOuKilswwMqpOR8ZgL9p3st2faEdipWH1xNJqxEaQO?=
 =?us-ascii?Q?00MKqOFshTOGwzVYygJzZBDCT68fT8II83Z3MN7pZQEPmZjXMH3FJ2OUGvhr?=
 =?us-ascii?Q?IrmnUOc9rDrGreAqrBJa3f/rWNj+Zt4PemBgR9u1MH5t7YF0AKDATjLXdl62?=
 =?us-ascii?Q?Sdu+fj8p4mn2dzUvQrBv1P0kpxDloGZftmUsJo/KC3ujN4t2UBi21MT2+z4i?=
 =?us-ascii?Q?TK5m6xBlWoxmrgD0bNURUZT1lPcxXFccqMtMJRYPTyFlQl8ezL4f0TiJvvJ9?=
 =?us-ascii?Q?k55GgecW0tUCzTDxxJ9ZHVKEcn1/YrKppBi4Lzw8efB1E2jhZR2v1iYJAARg?=
 =?us-ascii?Q?O9FaZI1wNLbk/kap9McHbd2c5SR4CHYZXauxOH3tKtU/hwsRquHqQhhmGggt?=
 =?us-ascii?Q?t/pmTSOoOh2l9Evmq37XYRy0Y4tfw0hBjXhHoSyiX+qfEl5OtZIyVHW30rbe?=
 =?us-ascii?Q?pBeoNPdFrhUhzqe6NAO2Zi6HUqx7m8ZM5VL8UkHLvA2jlyswj9xUCLCHEHKe?=
 =?us-ascii?Q?+0myS1aDSNnrKOw97rjW+uJmpQg6IgyUpdDyDvuCeyrsrZ37J2xyn8b5MuhF?=
 =?us-ascii?Q?O5BMu5GuP2M521Il9V+CjM5f54gV38mJr2zXgLGxcWBXmxbclNwuCLdGgcHL?=
 =?us-ascii?Q?YCHD2pzFPZiHTKH/zyLSFLnUnbLm9OoC0fJrCzLXuI7/uIB3Iwg3XtPbra5N?=
 =?us-ascii?Q?BjoYLvJVRY4MODhmuEnKz5r2+htpGhgqFj6FvROd7QGxqwleD/vahouaNl3g?=
 =?us-ascii?Q?WK9D/ekXe0/1321SriPP+nzJOlREOMw4zccnypduS1Nv3u0UYLBbs4+UkPTy?=
 =?us-ascii?Q?nxlUYAYoAd5vQfoTu6TeVaiegGWDUtT+cELSikI09hzilRDicn4FDT5ttLet?=
 =?us-ascii?Q?N3SLfFHt2hXmY1n6ekZOMkkRaeUUkrwN5fHJuAsPF7kTtHY1c8AOvWfZDJ/e?=
 =?us-ascii?Q?RRPOQN+a+IleOFtPDZPfv4sxfr0peQj/q4vheCRQjxNdeNfmqBzwuNV1rW/c?=
 =?us-ascii?Q?/7xbVIE7iusiVcoPacQcn3Aag2j0wiA6lP6RlsNNJ20kMcKq8QTkPtGCAm5Y?=
 =?us-ascii?Q?rFl/S5Fg5L+KWHXHVB7ca/Vcu9BT5oQxWya5k4aVDYmuYN/zL80YYJRZutHi?=
 =?us-ascii?Q?jI5MBNwDkmQPWket8XsR2ad4UfiBR/Q+It7TVt9ZnZk4HBd5QICW15W1dJm2?=
 =?us-ascii?Q?IbYjK2qEp5S6rZmHflflukLk/IUeyqxts7wXoXlFxaKsLON6fQTBZVPUAu0R?=
 =?us-ascii?Q?6SsdXgcdrVNYijLvuHy0WSsJUYZKdWlZx2rsjU2W4BQlLioCoXOKCNqH2pjb?=
 =?us-ascii?Q?fgcjvy3wbVHbeoYx0NKN/9MskzmrghnbixjXnwJYmTPk3HlrZ3IhVpCzIJ9X?=
 =?us-ascii?Q?8nnGJpjhOmJ/74jHBSVEsd52m/9YOYn/0gAdB/nXkBW7lMtI1mP9WwOwJlC8?=
 =?us-ascii?Q?+Wvee4MIokFGLhmhhtRGf8kiI3hBVer2vYq0XpZ7Bk9grGbAfHeukngRbHct?=
 =?us-ascii?Q?bnj3+dTB7x2h/XWChghAfro+NbNRWqGDYncW/ynYoe1A5f/gUOlhF/gHd4S9?=
 =?us-ascii?Q?HQTLmdlFk2+UCW/h1m7w0S57EpST9TNPTZvbrhYqj2pWwWtfTSKlvmTIq4iS?=
 =?us-ascii?Q?33IOiuVu9bddzi2c7xON5B082euKWrM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea86b12-79f4-4359-797c-08df21703901
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:18.7620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mmm910uYmzHH8eh/gwEMzguCM7xtG64knEd14vf7Ae/RkyAQ8HJnN8yTB/wMeSXkZBaN9ASV9RdvfOR6u9W1TlvreikDI0m46qtxHASifU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7371
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/sd/sdhci.c | 143 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 56 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f72..14c312a691 100644
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
@@ -348,7 +349,34 @@ static void sdhci_poweron_reset(DeviceState *dev)
     }
 }
 
-static void sdhci_data_transfer(void *opaque);
+static void sdhci_data_transfer(SDHCIState *s);
+static void sdhci_adma_engine(void *opaque);
+
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
 
 #define BLOCK_SIZE_MASK (4 * KiB - 1)
 
@@ -405,7 +433,13 @@ static void sdhci_send_command(SDHCIState *s)
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
 
@@ -850,7 +884,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 /* Advanced DMA data transfer */
 
-static void sdhci_do_adma(SDHCIState *s)
+static void sdhci_adma_run_batch(SDHCIState *s)
 {
     unsigned int begin, length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
@@ -956,15 +990,17 @@ static void sdhci_do_adma(SDHCIState *s)
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
@@ -1012,50 +1048,52 @@ static void sdhci_do_adma(SDHCIState *s)
     }
 
     /* we have unfinished business - reschedule to continue ADMA */
-    timer_mod(s->transfer_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+    sdhci_schedule_adma(s);
 }
 
-/* Perform data transfer according to controller configuration */
-
-static void sdhci_data_transfer(void *opaque)
+/* Run one independently scheduled, quota-bounded ADMA batch */
+static void sdhci_adma_engine(void *opaque)
 {
     SDHCIState *s = (SDHCIState *)opaque;
 
-    if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (sdhci_get_dma_type(s)) {
-        case SDHC_CTRL_SDMA:
-            sdhci_sdma_transfer(s);
-            break;
-        case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
-                trace_sdhci_error("ADMA1 not supported");
-                break;
-            }
+    if (!sdhci_adma_transfer_active(s)) {
+        return;
+    }
 
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
-                trace_sdhci_error("ADMA2 not supported");
-                break;
-            }
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
 
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_64:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
-                trace_sdhci_error("64 bit ADMA not supported");
-                break;
-            }
+    sdhci_adma_run_batch(s);
+}
 
-            sdhci_do_adma(s);
-            break;
-        default:
-            trace_sdhci_error("Unsupported DMA type");
-            break;
-        }
+/* Perform synchronous PIO or SDMA data transfer */
+static void sdhci_data_transfer(SDHCIState *s)
+{
+    if (s->trnmod & SDHC_TRNS_DMA) {
+        assert(sdhci_get_dma_type(s) == SDHC_CTRL_SDMA);
+        sdhci_sdma_transfer(s);
     } else {
         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus)) {
             s->prnsts |= SDHC_DOING_READ | SDHC_DATA_INHIBIT |
@@ -1098,21 +1136,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
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
@@ -1235,7 +1263,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
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
@@ -1244,6 +1275,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
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
@@ -1257,10 +1292,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         if (!TRANSFERRING_DATA(s->prnsts) ||
@@ -1521,7 +1552,7 @@ void sdhci_initfn(SDHCIState *s)
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                     sdhci_data_transfer, s);
+                                     sdhci_adma_engine, s);
 
     s->io_ops = &sdhci_mmio_ops;
 }
-- 
2.53.0


