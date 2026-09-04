Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E74C79F8E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJY-0004aZ-BY; Fri, 04 Sep 2026 11:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJW-0004Sb-LF; Fri, 04 Sep 2026 11:58:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJU-0004Pg-Db; Fri, 04 Sep 2026 11:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9rppCo9YgmUdxgUuF617I4qy0dYk9+K7HqiGvvHYKGbybYPxhG4jXOeUZI3eYbi1/zaYbN25wSwqEJcZNkAAYAzs+NGqNUUQtXrHAOAGxIUHshkehUKV5gJZveZF+Db3uLwVAYtRmzql6ZcpWuFzzvQPuWdU9HLkkyywqktdRZna60TlTC48mcFApcMC9M1jaw3KIHpN5YTozJ3+pe5B16lmgL7T87rA/sszhOkW3ivyo9spStiMzfT9r2Tt3J7PAQ01teCUAzUUsJ6hiDxkV5BiG9bRW6gkXP6giBL+r6LqwZOJ8FNnjIugkz9qt9LNVFl90t3QV+N/YK0B7yimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cF/iFg+G6KhGDsFbCEr0inKuedS0e6jhOZQjejKnLA=;
 b=e7q4+HkN7lQKC0zDUa6pklPZF4HRtH/Nhk4ZPxsV8NhkFuRculTLos/qLPDxalM0Vcdcv1a3mGPrzA56lZzjib2OYc10pq645r34gl+uPFqkU6jCtKwvPje1Gz8PLxCXBhEft564OFTb35HrX/JXCy/Jep9BHxbyAEsmK959MlU0dK+MscnSqfSwqMH3O8JoTXPYyRubJCH2JqCBSBjnYuKje1o6gzQoTuzTnloPp/8I73yrj5F/XznwXrX8gfydpeUHkzqLQa3rIf97WVGjTbI5DhCDZzqiJn/rad8Qky8XIM6teBXaSEd5l+eM6QB0ZaWQfGrf5aGGeGNTePXVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cF/iFg+G6KhGDsFbCEr0inKuedS0e6jhOZQjejKnLA=;
 b=DZQZTlceFRE6nUoM7+hKXhp6NXjaYLnA40wxC/jpmrF2Q6Cba5ifxdlLGv6j4nS4mZecZkFqJFlb1Lc1QIoorGoGsXvk44T8gAMoGzcmX+YBnz7xHAQX7SmbNh8AFYJ2jBiUdV7I2QohIaxotLfxNnCoeWiOtLa2PlNmwk0Kv5GuAqS5Xxlt1XkLY7ojb+7ZoGHmSw84Qpef0t9pjBbK0J81yQGmGesAPI4fQmq1BLxTSOg5iSmT/3qRBg40TYtvI/nR00YyvdCfyoRzxR+DwJgY3HlMcfkF/i6mUsXJ4/4sVFuyTP/WUbpnzd///K2npUBr0BMrMPRcbw4U8NUUgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:37 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 07/24] hw/sd: sdhci: Run ADMA independently of MMIO
Date: Fri,  4 Sep 2026 23:57:26 +0800
Message-ID: <20260904155758.3833179-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 454f293c-8899-4e96-c8dc-08df0a9d614e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4O6gMXPrp8far6Ck+yi8OXTFJR0VGt4tRYXxeG0TjWpSWY+TQMPFl6iqUOJHwGSPuQet19kDMTzFeaRgroEwu+fHN3zvfX1XZBIWj6MGOpd+bhGPwuEARqY3cQa2mDRR7d1i2yNqRfc8tlw004MVaox0ndgt8jLC0omIaSXvi/+IgHqnGcw0AIya8JR5/fJjqHnox0R+bF7l8f2JoXuWYu0o2rF+w5rK/Gxwux19VSqjLDH4gtt9L5gYsWqCBssn+ublSwSzu5FgFUZ9gp0VZZ6oWqNJ80wM5E0KolJk9UcNDDrP2rQsXYIoUy7vecvzWky2J4ZZo12obAv4kGEXMXatvsszxUTFjZoDiLT/Un3p4CkPpptzYpXafepgpG+f8sRCN6R3xo4UOQ8oJM8WzzCroG2z6QrMPyglTs4Rim2RR/Ip5SDu/uuUtaQaxxph1bDgSAO1kX6IPuUDPOm8st6B/QPfjMHhLV4CY+1kSF/hZz/O3SbGDx5HZXJfqvXJU2XrSGJlMNVFzHIxUKzqfvBuTeTcIlowg6jffhZZCaSgCYUXIvQsugebUYyTyz6p1kFNKTReXFmaA+mivKg2nrHVg3eWzcKYzkkp7RwFkP9prcmcHXTQAFVwxUZT30FmyzwujYzxqF1g6r+E9B/ZaD5FFBknZJ/+0Bb4FgXfln0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BKiikdT6Xntu0rQrJupDjn5D6u1TT+hxLVyVRot5Zu7oEgpkJwyFjmTakBOY?=
 =?us-ascii?Q?rTyJaTE+qjVg7uvtt2AxsHt06TILLOQNMOxUugbDdfx0bboarxiGFMFL3Fuh?=
 =?us-ascii?Q?JMLf6+TFawjfzWc9Bx6pdJO7+DxtXKHqb1BtZvf2JXUZpz9NXhR1TGM5QB9Y?=
 =?us-ascii?Q?wog6W6orIIbRKIk5uT/XcXTOvs07QzgEuSs3gYGU85G1mbQg/aoRiN/zpSLj?=
 =?us-ascii?Q?wRZjnAXaSQUJDjS8jAkDJqPmhAOq/3mHWhpMYZut4cvkOKvnv3focArkSzTc?=
 =?us-ascii?Q?/ewnnGgN8yo8ZzzoJSRsyti+G3tH0WdMSkEovgg3gIXffHF66uVHBZk4FxLd?=
 =?us-ascii?Q?5hgAQ1wuck17zYoPYr0svZRiZu1nod8US7rag35a5BV8dIxd98OolNbEBhjY?=
 =?us-ascii?Q?VmJlUwnT/siXFtb2ErrgndWDYi/O009n2S262RU49nxlmSSwjo7G/qms+FdU?=
 =?us-ascii?Q?fE0W1M0WwyMlA8TlnpV9GFBtNdPAyDBfQ/K+xiyQ9XcC945XSRtXXHHTnUie?=
 =?us-ascii?Q?/Rt3pVDZXQ9w7S3wwtXlPoezFe+GSdpSKgy2QcGhC4R+QPfY46DtM230Dk+S?=
 =?us-ascii?Q?TC9rCjAqYTTHD/zegcaqJivu9tEnex3Z4dc3VYQS/q9oHBGXRAjGjP38BtSZ?=
 =?us-ascii?Q?wzrbuIOyFxpLuY9AyFNmrPC8iD7dp3hIEBFYuhy1zmTDYpMNPTc6L82eK286?=
 =?us-ascii?Q?LloHbphmO30qYEOMWWCuj0wpHlHxZ8GFa2tNlKNyHOXEc2JcepeZz+cibivo?=
 =?us-ascii?Q?iLedAlUnFICg15Iv6EzAoCSJxL5GLQM4XEZMLXyCjcTjPgxP4FVs2OWcTTE1?=
 =?us-ascii?Q?cFx3tx7zx+c21WNjHfkg38VN1za8QEJFFLR1/Q8ZK3ZKVdGaDd7OY57gcMiK?=
 =?us-ascii?Q?fd/TXlbfbWVVJPz/oLXF6U0riq/Gltsvc3KU5Nw8ZLRbR6sqD9y1xVDnO0Xs?=
 =?us-ascii?Q?1zkpqK3e857JzfzVnFmIuFu8jMnldGpzbzEY4ji9gMKyX+sqbndi6hOTQgbN?=
 =?us-ascii?Q?ihETiVckYiZyI0VyIebDShnPPPk8DvLfZmAXXBP/bjzNPZ4GRjeTknBfAqKW?=
 =?us-ascii?Q?H9sMCVV+8v/wIGYW6UiMSd326yH4IAUr4lYcx8XB7fiPqOLg8BtPBFSNnYRc?=
 =?us-ascii?Q?Zxy2WN3XCc1A5NFDVewXsLHuAnDTd51u3Igxgrb2wDb9JLmqdNtHwc2uC8ws?=
 =?us-ascii?Q?IAEkUePcY+Dmi3/YZecerGg34LvjARAAq94aWWNCIRx328KEKk/Cfk33YsNr?=
 =?us-ascii?Q?skioc8dCMJ/qYcZfKo93hN+8+U4ANwhZ+C521vID+ZLbCU/1izx0tB8nx5uj?=
 =?us-ascii?Q?tLpmKBL/sTybfuYDpoof+i4Qg/xem+IbCu11hLIH3MpDlOkmBosMB/vJjcoL?=
 =?us-ascii?Q?GjMUwjcHg/GsWOOhSxhHnFdvdPLsvErLTaOWzeMjy8K9rpa004Joh621+BzP?=
 =?us-ascii?Q?vEWGqfbGquzAlkQIbDQEiYcSc/1N+Cn7lKjc6O0vHTOiAdRZUeBXPMJmEcl2?=
 =?us-ascii?Q?BIfvw5Y2/b8Ddz3qku4EbxezCmDL3NUp0D1g+Qr+oaWuByGau2Tojg57Ov23?=
 =?us-ascii?Q?L/YUq5/IP4GapeBQxvGzLbFlq5bMWUOAzKCLNkT9+MuSSxbfE+vd6qMYZV83?=
 =?us-ascii?Q?z3vVXbEys0a5VdAvSnBSqfoSCEhIGZujbCdtpzfi0w3dWN/NZNctoK0cqxkb?=
 =?us-ascii?Q?K1VFQpEdmqxYf4U+jH89uF3vnyzkAw3LKMogHBhfyR82DbBvtyI7ALs37WRx?=
 =?us-ascii?Q?XayZcCIIRj1Kh01cjx3diWHXi4n28cE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f293c-8899-4e96-c8dc-08df0a9d614e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:37.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEbDPzB8PPLpiCSpTQRIYLnfBIukYHVNFdL3Bz84dnwI4OXRMxUoAeEQfY6JBVmdvxMN8RMOTMG+9YeY5rNJIRw5duKRV1xa4rpF82GvG2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


