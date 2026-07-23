Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7E2C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDn-0005K4-RA; Thu, 23 Jul 2026 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDg-0004gI-84; Thu, 23 Jul 2026 11:20:20 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDe-0007zZ-A5; Thu, 23 Jul 2026 11:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5U5JdZQI15SWyn+XI+5qZOgqD/HnRRzhVpDJJB6Pa6/0zvWHC3QbEJed3xwy5IICQ2NQIWAoHdiG8rQecKL5tM3jbs82ucd1xbmTP2EiKpKtDkA8DmNysbJzu70TUfQhK5xmwXDZ7oYmAErGesfjOROlWepGwHbicFB1J7erKZiy9O6GkFOlRQ5w5Uh4Z1SmqsuuDTdZfjHbbWHfB18rWTgaqvz9jpjDI3Uzp0GK8TVQyiMeJsPBMCCs/0nWqeuUjFxEtcy1k2oGI/RnIErZFOZE3QOr11mQoxBjxxVzXhGD4ApvL3pKkY7rVxsNUoQHyvlhuDmK6VkhCn5c2pO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMpX72i14kkrHIkhHt2lgJWfFBFnNQSxja+H99PeKwY=;
 b=WiFcLI15JW5yA0CqVYkyGAx4QUEJQfmJlWAuoRZECFUQ15vsIGq88ieHIRPl/aX58hh/GVmerQf+R6vMg5LJ/+w5rxDj8clUhv7ZW7dNjz307ESllIHqus3Wmb4UUVvjMWZW77Kur6dyXACMIuEYMiRb2fzbdknk7DOT7idO/X9D2gCX/kIEOd+NlQ7AYSlsnMdeGUbecj/TSzeMkcAm9iiWGw7xS3XGsVmTkj+a9oZV8hhe2xyaVvDIaqemAlEn+GWZE4PsuOIZF08CRQT7k4LHuPDLNxL7mTCnJfIvFxtmT/ELKLMsoQMPL+VlvYDvtfuDa9z1LDvKyCAhFbX7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMpX72i14kkrHIkhHt2lgJWfFBFnNQSxja+H99PeKwY=;
 b=WAECSlr3xJz8RxvvurzKJTnThKr3slIlrPR+aGjNLftkVyQLmtHJAPCMkenOyW6WB8RDShg7cH1CVplJGFvpyPELyyEkcyRdSydIpm42s+qf2LgaurxUC+0kCPiOP5Q8vv/+SeNklQRz0CI2BlhW3vYsiagYj9/HLYyVuDu2rp6y1osyasDr9VWbQMT6bLqZjg4B/OS7L3lkMh56qTSiGQSm1Df7T3rdFnzMorttGdmgm177wZWhUCpj0u1ii568sSrz+/mpv1n6kqoIl1dmI7pc/+Nxq7oM8jg8Ob2pWXlQAJBWTLdzGJHWTmVrEx6ufAqEhxAuShpvNO/up5l6Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:30 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 13/26] hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
Date: Thu, 23 Jul 2026 23:18:40 +0800
Message-Id: <20260723151853.2143177-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73701471-54c8-4648-ce1f-08dee8cdcaeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: WaHj3PQvpZ4NZCN5d1rQOsVGkzD0Dhe26AOBR7gLKfPyaRumbF+1FRBYgWeyWjZAhzewu9xvaWiBmWnwKkFUTlrYy5PN2+5mSe2EFG7MceXWabkFz9MC8eI/OSMY4UMrw0QzR6agR1rwR5mVO04hAO+C8SEF+I0OJ9XiFkT1xVFsrq5kKgbGxRrKDO5NQauROwFXnVSwmWdvGZDYjeMNFiBgFL+mdCT1jLoDFUgG+q90kUmCamuT/LDEyGhyJrRdFWaAHymTV7w1Iej4awaVlDHrpJMMBAzXQwkmEY9VJEtR7ocAIuSBSk/qHu6Ka/SrCMO/L/K0kNPis3p8rODmhlwwlpk8jAVRJSeiWUBrOt6aPWwB7i2j+nPw2X1PU7khP6NSvpE0Yhd1Xxu9jvdo3+RbuIwezOdsP7GKTmhPnmYRhTt3+Lwy2Zj4U92B/sRHn0t3+0FafXIMMiHw8NYTZLRRjiAqQj98DkT4XEApBCptiATEJkdXvE+81wYaAxj8+NIoMps+vf0/+H1ecCebikQ7h+7tbQdwUOnAE5ADc5XmNFmLvRCGIq+3saeesf7ey8P0UaXpDhxXUmJTmmYivELAjvdYNv8ah9t55bTkXhblSK5jw0y7ToQoVZjB9PyCFrvJIidpi/oQ9fACKO2mUiDwO/ZKO9bAWKvvjsslYio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(5023799004)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6q65ZeXISS4Z3PRPtd3favpF+AtE4/ZDqcwA3ZAOwpk0Rh3BqaFCAQ8apN9I?=
 =?us-ascii?Q?tN514PbBp9IkGaIafoNo2nvy2yB8pFB/g0r/fFf7tGDF3A9L3E6pQ2PwXoDu?=
 =?us-ascii?Q?yvs/QMVpqSUdQHeWsjsdUBiJvnjoNtuifgfw636U26tfjC5XTCQCvc7F5yuv?=
 =?us-ascii?Q?qCH7IRCdYheTE8aOvWKeTk1mwGEcRVUtHhfPZHKyU8cP8V/rukXZvK5K9xMb?=
 =?us-ascii?Q?UR8+QNPnFMb5v/QRsOFNMGN9cYTW+BQAGUDkM7dvNwEdvhV3WSFsgwHuYnxv?=
 =?us-ascii?Q?2jYVc6DRH5dgR1SILgNiylLSbLf2P31DqvYkg0aIyj+V1U+ekyiQHMiJ/tti?=
 =?us-ascii?Q?PfYuRBIla+V4elG9eqqHK0QXhm26HSdabHcocjeNoGMP5o7HaOK+WeAVz4Mt?=
 =?us-ascii?Q?7fePyJtWCG0zvFKny4qDU/k/66pfXFltc3SKKy+YEMFseiDtbTazgztlvLxx?=
 =?us-ascii?Q?yNZYO6LIw6q2l568TF/LvquJeR9msHaSfycBtWZivC0n7QRYSPsc7GhxK4Pu?=
 =?us-ascii?Q?x/2NCg5mFQWbEanv7AnNFA1jTja+EAbFOCLIJR1DG4p/LzGAagY2lFM/YS/l?=
 =?us-ascii?Q?Il9P2F3q4lrZZxNrsjcRy2TT8zzjra2gSOxfTZHUtyr5b45TCM3WI84DaKCw?=
 =?us-ascii?Q?D2bG/OVhxkeDbQ+t8oU7+vdGJBGa7sxP1OqGo8xFLuO8Op6CJM9moq4gJeh/?=
 =?us-ascii?Q?eP082hfD5/tQlUHY9QnzG9VSbW9oi62nmE9Udunxwn0dHVfCxrf5wDwNLrMj?=
 =?us-ascii?Q?zuZAwHf7iX8fRxD4wKzS1G23WUyOkIHOpkLUSDD4tAYnmCCZjR821Jspbk1f?=
 =?us-ascii?Q?S6wjwxNbXr/3jXRYok09kiImL801rijefpZVHX0XKUWpMQPvv6SZWBMOEnqZ?=
 =?us-ascii?Q?zTAPg/umwPAn2mHluikF7RmPVRPoH35U7Ig6VpOEp/5K2GgCAk2aKlR8uPGw?=
 =?us-ascii?Q?dOT6aPGdjvGGVogaGS35ut+7vteaejEBjtq2kcTrEHitm/c4iAWoMRfgCA53?=
 =?us-ascii?Q?Z+r12wJnOd2QCm6pFFimhVYDkIAYWDT7wJVeh2LyMivispWM3wkWL2rbW1Vg?=
 =?us-ascii?Q?Cpc1X5quA920ftzun/VlmOuBRgma1Wp35W7PVocBx0/Tnkv/tuhQBlBFIUVf?=
 =?us-ascii?Q?M3dPtcKh/G7WPTmUXieeWrR8Px+fpvhmNQoEcgygNs0j2NvelCBlXuIenuqO?=
 =?us-ascii?Q?UkYZQobiVrTWaCy7qXIJOiBzJjcvBvwTAbINye9UZbw0oUzPrfFw6/q1NToq?=
 =?us-ascii?Q?re43QU6fw5xOoukubwX2yyibTJ2vS5YkTJmQpLzE/qolXt42O8oIHyqibHyL?=
 =?us-ascii?Q?n8R+Ld5SC6TLW87QPPHKEXTxzqHGpk8QC2sI5h+DA1gbdROwFvCD0UjkFIY1?=
 =?us-ascii?Q?3O8wPYSJLBzCMvue/TX5apQXlb6On+ZyNCk0GIrXp/PQeF7cnFza82HEmNiT?=
 =?us-ascii?Q?tLTkdZ5Dm5oO55cH5gRloRmZkoVkiX+61RIBRPGR9XFtQYelziUTfQujMoJ0?=
 =?us-ascii?Q?1Q5WcutauXnBFTAE1mKvQtWzhGC3jv+I83IN73AP7jsAk1L0nNgx3u42/ZEM?=
 =?us-ascii?Q?RMM67Td5Gpa3OCOi50CankBA/uL/+53pqXxai6XWTYptcKszIgQOvcVOrHMt?=
 =?us-ascii?Q?9re6JxDji2QwsPFKhInFhUQnql+EvL/pzeK28BSxg1f6fKBWmMONLjJnI7sh?=
 =?us-ascii?Q?+np3mwu/6cNR3m+sDQaQvv722B2glFrZKvkMHpi9La+KA6W83Yoznhkb7Xu0?=
 =?us-ascii?Q?dIvP9X82U7TpcKzf91L4ZsMXQj2IMaE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73701471-54c8-4648-ce1f-08dee8cdcaeb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:30.5365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmNBNia9TPdRXy6VOC6jRgbocm0qs6EU/m1nAs0FUjXVadFzgvDZie8a84CKmbrPorb1WaupXtm9orUBCPVNhM+YU4eShzxyOtS6dn5xMrs=
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

SDHC and SDXC memory commands always transfer 512-byte blocks regardless
of the length selected by CMD16. QEMU stores that selected length for
LOCK_UNLOCK but also used it directly for several memory command paths.

Route single- and multi-block memory sizing through the existing helper
that distinguishes high-capacity cards from SDSC.

This lets PolarFire SoC HSS validate the complete GPT header and locate
its boot partition instead of receiving only the eight-byte signature.

Fixes: 2d7adea4fe57 ("hw/sd: Support SDHC size cards")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sd.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a30c541df0..7832117a58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1975,18 +1975,20 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
-    sd_blk_read(sd, addr, sd->blk_len);
-    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+    sd_blk_read(sd, addr, blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, blk_len);
 }
 
 /* CMD19 */
@@ -2025,13 +2027,15 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
@@ -2045,7 +2049,7 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     }
 
     sd->blk_written = 0;
-    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+    return sd_cmd_to_receivingdata(sd, req, addr, blk_len);
 }
 
 /* CMD26 */
@@ -2372,7 +2376,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "READ_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "READ_BLOCK", addr, sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2392,7 +2396,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "WRITE_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "WRITE_BLOCK", addr,
+                                  sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2662,6 +2667,7 @@ static void sdcard_write_data_dump(const char *proto, const char *cmd_desc,
 static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
+    uint32_t blk_len;
     int i;
     const uint8_t *value = buf;
 
@@ -2678,6 +2684,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
+    blk_len = sd_blk_len(sd);
     sdcard_write_data_dump(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, buf, length);
@@ -2704,7 +2711,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
-                                  sd->data_start, sd->blk_len)) {
+                                  sd->data_start, blk_len)) {
                 break;
             }
             if (sd->size <= SDSC_MAX_CAPACITY) {
@@ -2715,7 +2722,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
             }
         }
         sd->data[sd->data_offset++] = value[0];
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd->data_offset >= blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
@@ -2726,7 +2733,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                 sd_blk_write(sd, sd->data_start, sd->data_offset);
             }
             sd->blk_written++;
-            sd->data_start += sd->blk_len;
+            sd->data_start += blk_len;
             sd->data_offset = 0;
             sd->csd[14] |= 0x40;
 
@@ -2810,7 +2817,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
-    uint32_t io_len;
+    uint32_t blk_len;
     uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
@@ -2830,11 +2837,11 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         return length;
     }
 
-    io_len = sd_blk_len(sd);
+    blk_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name, sd->current_cmd,
-                           sd->data_offset, sd->data_size, io_len);
+                           sd->data_offset, sd->data_size, blk_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 8:  /* CMD8:   SEND_EXT_CSD */
@@ -2859,22 +2866,22 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
 
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-                                  sd->data_start, io_len)) {
+                                  sd->data_start, blk_len)) {
                 *value = dummy_byte;
                 return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
+                emmc_rpmb_blk_read(sd, sd->data_start, blk_len);
             } else {
-                sd_blk_read(sd, sd->data_start, io_len);
+                sd_blk_read(sd, sd->data_start, blk_len);
             }
         }
         *value = sd->data[sd->data_offset++];
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
+        if (sd->data_offset >= blk_len) {
+            sd->data_start += blk_len;
             sd->data_offset = 0;
 
             if (sd->multi_blk_cnt != 0) {
-- 
2.34.1


