Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21FFC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDi-0004mv-6t; Thu, 23 Jul 2026 11:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDS-0004WO-I9; Thu, 23 Jul 2026 11:20:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDQ-00081v-P6; Thu, 23 Jul 2026 11:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHMcdlq0xP3oRXmkQmGaRPvAh6qQETTeFmHCqA+Rf4PkwFtp3VtduRZ0/dhWDqdjoEMf/siXpxxZ2NB3vt7/U51LLuilnlcZZOAcczF2hLfkpurTOmy1NdwTwiWMPyRjhmDtRmJcxH4+79KDxfr1ag+x691+PGuvGUXGJn2oF/b7nVR0bOVD1QaR+Jow6ps7CxIryOZ4JM2xfZv4jV+6ofw1Nbwan7sVdB4gcDxwG8OIXY+/Vs7gU2yJdE4QZRxP/Rp7HT7ztOth5NZiWN/nDPo2wKD5xDZU0WhpUxjMf+KM6AgjLfqK6L5V1yLSFRewDYyD8k0S1ocj9Fn6jCCF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7vgjoqLWfwU7yW7j04l1GsRqedYCi01zm5n9lHEJQg=;
 b=lC0IgXLdfC2YY3jPboUJhKl2osBL7QAGTWOhIslUphh/5FiwJamwGxdKnr0wjZD1CYFEDFC+RS7VsR7oyMcZ0ZSLltaWsyndzAwArbmBZdKbuHw8J1i6skO2+8TOfBZrayqJ36Qu1Jhc4ra+pZiFnnFieHOgaa4Lt9PbObFHrcAC1vBT1HRpsIP2KaUmLWA6eSEALEqIjUhgu1armPhu4nNHXV4heaJulevbwPaeeYZ/TbyrlGEb14qxW08W4KSrhtvL9DCjoE9qJ++9Y6PNKdnxMwdKe5CZGUCgc6uD0md+Cv7I3y/t0ztSZGnGUVrxXjzJ0zXJwj4FjIC4Nn8rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7vgjoqLWfwU7yW7j04l1GsRqedYCi01zm5n9lHEJQg=;
 b=rQ8lgHZe3CCuEpaAXS3bQfhWXk5JMx654Nhn7031rInhSavvpyTBysAckygC6brxlaPB+L8jIOz/WvIOiw4ZQMsW2xURvWL33WsxiaohPl0ODMd6DvzcO5hxF/TcIH/s+6VcIcKbeTmH7CjcNcMi02/B2zjwCUet+sjUqJaSfJloeQRAX1WYDRV+0oB46DwUDOUkC9/e/FxrKNvXlFXZZak8xCmDWp0CqZBnXmp5OAlYVQzmzUkExVrSNgn3N9QXp0Ffx1960SISIVSDqFen7Lzknc6DzXI0LGJsq/8iiU9xJbmMFnbhJtc8fUG9eUAhNzLf6qHwf9LpJoN0g0ayGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:28 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:28 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 11/26] hw/sd: sdhci: Resume version 4 SDMA at buffer boundaries
Date: Thu, 23 Jul 2026 23:18:38 +0800
Message-Id: <20260723151853.2143177-12-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8fa5c6a4-38cf-4e6f-630f-08dee8cdc99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZSBOG7DM9JPq67XaXmmsdyR6UIAyty1nebJhfljX4h3BEbUoTrFDLeuJ1h9lbzumFtv98dFr0Hak9Zgznw6/BS4t0Qz+PJjMKimmt/IYl/i6GiTe2y8+s0l8n71ilk3ynWYdBXHqwrj1HjALSQWngefhzFCN1GygQ+0z32fzAP1UoSVqjb670kB5zmJsDTKxYjvUGO95+yRN/LfWm+UhLs4Jij5OLrmuEU7FTkFT1Yx4lUdujdYfypTtNqnVsTposx02pI8NrjQq8wKGXFOAZ+YQsBj1rsYBA/HdzmnmKzE11hc2nr5jb8jvwWbBylxyFRHjOuMJCdVqP7iaiBjTJfIxDB4y/IWmNT0NvyDz6h5mPTietbQTdxHdfXVEXnBHDQTqVNVlo/rsfrmh/9LzgUQz8m4rVTSTaXfL/DZr/bO+uc3BwL9rX91j+Kx18fPBDWqzFaO23ruE3Gm+1j9GjoBDElnQOlnZJKeY/1cFTIcEOa4g0xbS918+N/njGBcCJKGLQmvP5noUM+nO+leyknSfwLp7ZIX2Ax6VsesBlrL3ztNuisD/k4BJnSL1CZk/i4YkAjeUUIIyukvAJ+AQSArCWdfjBfaKt+Pw3aADkHkrtTT+g3L8SwBKmMFTjvU8DZ34M6GgDDCQQScgph49kKMheM6K8fDSbWmvwDdlqkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Yev1avE9QtFxfjACbh5cX7jTxh0simbwvY0YzbxK7WB5TgUSqPxCLwCJYV8?=
 =?us-ascii?Q?B7FvhnAhI33sZMv98jB8obnrDeW+Jf6Dayr+uBxdh84RfFi5+VUBFcJqRyNe?=
 =?us-ascii?Q?EpAtxpmL2P+jNdjcBVg//DGKqAOoSGzltOJhSrmKriZpNWxwKI/sMb1VN2r/?=
 =?us-ascii?Q?5NDoUvtimb4rjh8MWuvvYKxUa7owr55hGmB2V6ECb0VBaf8Vcj0RFw2aQGGG?=
 =?us-ascii?Q?2F+WYuKZ/yJ6wABjqzxTej23ByYeDXT+TeJZc1q8HlmvEoU8i9T+JskmYAvd?=
 =?us-ascii?Q?OpCwsvFlP4TIgx5yfm1Al4XNHuXlWV0FhVk5ZeMhCtt/lDUdK4I/fxs/lxYG?=
 =?us-ascii?Q?BHi4Q/+i6GZACekkTdVFZrMyolNh+x5JQd/wZXKVAqDrmmAiOl3ekVoV41rd?=
 =?us-ascii?Q?c8aW1no1bcnhazEMN9VSPcPxRKJPlkrbzRskAQKNvrCun6XbnDB9Giqpv7ox?=
 =?us-ascii?Q?/ex0dZ+0i+jnWvNzJ6GPqdl5NvxsvtxMpQ8a2GJaHO/Sk2DUE5YrLRmOpENP?=
 =?us-ascii?Q?i54GheVcwBAuZpmNxYI+FpS7zSJLHLb2A5NGdoqAf/UvZZDRuKMtFE3HhPD5?=
 =?us-ascii?Q?g87Og5eh7SYykLbtrvCPUVD3IWJdA0QkMhj8WgkWt+XYIzdj/SryIMY/d/Wu?=
 =?us-ascii?Q?p6hQyVNIj21hzjqE2rVfZ1hzivfwOUaY4I+vrHGj9mjdrsVI1zCL47vu6WdN?=
 =?us-ascii?Q?R2h7SYxZ1M/c3l829e92Q15junirSOb8tYbX4c1LCrcAcAQvjv/habQiL+ty?=
 =?us-ascii?Q?P4DAR1fN+g9qp1cVsPtJC0OMR6tG3Qvbo35MN7DYU6aFSWyi6ePvbYzdZikX?=
 =?us-ascii?Q?Q60zcrJWJd3X5JOYbescuBKq45YRDnIcIrSgYc+fdV7fk2Y0hoRuqWbpweLQ?=
 =?us-ascii?Q?NTok2rjzquJbk0KUIq/AVJZROdBe1q3IlgQRRYIXZ6LEEltXhLR+xllqBHkz?=
 =?us-ascii?Q?eDrWqUOxh+/2onzfY+B8aTUFXIW+EEzZEg4vtARtxC+scHUZ6vRKlzpCdX2g?=
 =?us-ascii?Q?OKiFABrQnRWowL1e6g0fbXdqKjAKPDUOnyMKB7Q/UGR6eeO3S0GDyGJgsfK0?=
 =?us-ascii?Q?9tshhWxRxoQVk/J8FL1bCmqRTs7oUkj1TZrHEOe9NcvN1S5SUXaH4PHkvvW8?=
 =?us-ascii?Q?QhCCk1KPXCf11y7uMIwMcoCm/vMKxYuvQ5GWywMYwYooMgTHCYMDtjmMTMUw?=
 =?us-ascii?Q?UQUdL0xJK0OR6XlWu7nAAx8Xxnm4kNP4bXnGSQXQv/uHT9m3GS2R9t1NhG3x?=
 =?us-ascii?Q?AjpuwUmdfquUUzcHCl/EqBiUbTkSFrJPDaEKcJN8aQa3guRzArXShUhgrmFS?=
 =?us-ascii?Q?xwoO4HshDkT6bqZGZar+Yph3TlfxkBXQgFSD/BuBj1YJQxx/Pv/e814rby/R?=
 =?us-ascii?Q?Im6MyReaft8h4V+opZHdwhNoYOgNvMh8E+mLBIf526QqMVkzlT38ipqtevbj?=
 =?us-ascii?Q?k+k4wNk/PP3gBA8dSmNZgTNcBE5tNMs1rlI6vd+5c8ufepQwRc6Z8TEBQ7nS?=
 =?us-ascii?Q?6E/3fSeagvRTJOStiCD/O3Jojrdy2Bnm7Sqhvr9Opv7DtWlkbOGA7T0o50T4?=
 =?us-ascii?Q?eIGgf3U9Dwki6hvagAfmyfaCFH4HyJ7BFabfv0uNpLKIJjTGk/ZX+ffjFKWF?=
 =?us-ascii?Q?INyw6IgzkKTPVv6FBI4LVxq6JUtG9tzKI+VdftLhayimOiRBQqd+bCbPUwB2?=
 =?us-ascii?Q?TE9FxbSB27dm/TANEem+ClM2n52+NzdW7ef10xOmHXIq2c2Tf0yMmGDddY3H?=
 =?us-ascii?Q?Q5HmVR7AU5NNxuLwbkidpev5hv1W0Lo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa5c6a4-38cf-4e6f-630f-08dee8cdc99c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:28.3174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+SoBTkc0/GgOHHj69yaYdFzoA78og2gyxPznRjk3iPH3ZzY+bqoPD1uvmDu1wV3Gfmq6lyYG8AUor9TAmLYLAPsoXBlOYs/YdfDNT3zgA0=
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

Version 4 SDMA selects its system address from the registers also named
as the ADMA System Address registers. Updating those registers does not
resume a transfer that stopped at the configured SDMA buffer boundary.

Resume 32-bit addressing after an access completes the lower 32 bits of
the ADMA System Address register. For 64-bit addressing, wait until an
access completes the upper 32 bits so software can update the low half
before the high half without starting from a mixed address.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 00a4b9b0e4..8d85e1551c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -786,6 +786,12 @@ static bool sdhci_sdma_transfer_active(SDHCIState *s)
             SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA;
 }
 
+static void sdhci_resume_sdma_transfer(SDHCIState *s)
+{
+    s->sdma_boundary_paused = false;
+    sdhci_sdma_transfer(s);
+}
+
 typedef struct ADMADescr {
     hwaddr addr;
     uint16_t length;
@@ -1257,14 +1263,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
-        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
+        if (!TRANSFERRING_DATA(s->prnsts) ||
+            (!sdhci_version4_enabled(s) && s->sdma_boundary_paused)) {
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
-            /* Writing to last byte of sdmasysad might trigger transfer */
-            if (!(mask & 0xFF000000) && s->blkcnt &&
-                (s->blksize & BLOCK_SIZE_MASK) &&
-                SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
-                sdhci_sdma_transfer(s);
+            /* A completed selected-address write resumes stopped SDMA */
+            if (!sdhci_version4_enabled(s) && !(mask & 0xff000000) &&
+                s->sdma_boundary_paused &&
+                sdhci_sdma_transfer_active(s)) {
+                sdhci_resume_sdma_transfer(s);
             }
         }
         break;
@@ -1401,10 +1408,23 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_ADMASYSADDR:
         s->admasysaddr = (s->admasysaddr & (0xFFFFFFFF00000000ULL |
                 (uint64_t)mask)) | (uint64_t)value;
+        if (sdhci_version4_enabled(s) &&
+            !sdhci_64bit_addressing_enabled(s) &&
+            !(mask & 0xff000000) && s->sdma_boundary_paused &&
+            sdhci_sdma_transfer_active(s)) {
+            sdhci_resume_sdma_transfer(s);
+        }
         break;
     case SDHC_ADMASYSADDR + 4:
         s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
                 ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
+        /* A completed selected-address write resumes boundary-stopped SDMA */
+        if (sdhci_version4_enabled(s) &&
+            sdhci_64bit_addressing_enabled(s) &&
+            !(mask & 0xff000000) && s->sdma_boundary_paused &&
+            sdhci_sdma_transfer_active(s)) {
+            sdhci_resume_sdma_transfer(s);
+        }
         break;
     case SDHC_FEAER:
         s->acmd12errsts |= value;
-- 
2.34.1


