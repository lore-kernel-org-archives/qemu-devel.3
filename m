Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6594C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJc-0004vl-QT; Fri, 04 Sep 2026 11:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJb-0004pL-5n; Fri, 04 Sep 2026 11:58:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJY-0004Sx-Dt; Fri, 04 Sep 2026 11:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2oXHyMbDaHvfag+m3TMRzh7Q8LqIojx4KccRiq7VNWSBHCBK43OVrcz+DMMvzuULGXPnjsXN9+IvknobjHUp6LQvnQuywhHG3poOsqh5SmgKDrUTABiTetLnkTwkD8nxohiopz0iyVmEpuPggYd/u2ecv6NK7i32ElRXoQfHTVVvSLN5L7qQqZqsT0J+Qr6fN0bQG/KBNbN0h/gufMcbaiCtkK+0H8uc/ukHLCudgWAbqQd2+6SwzZjBpoY58XBLAGa2RXF3OQdMGzH7aRu/a65DP927vCkncoxvEhPCvh2r5aGNO9Kt2h9SSxFYjnoeJgPxhAN0UsMfKgThGOUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao2NhYVZz69fcw3o3/8zWJ9KCibUchqA6HlQAhdzj1A=;
 b=GZY6c2IglIBhI/izUj1lShfR3KwJk29vDwU1X6ELFygat2fyDyOTAAVO1ptcvTu2vEQAt0NJ6dElB2dxpW1wXLZ5MntoF+6Etu4ZzYBlbjnpkxsUnJ+1M9+33teQyOvTWw0Wbs6gWkpMWed5q4Z2q1FDaQXSY8BepFGamIHDurzdmvsmIe4Tj/AjGstCE6cFUlA6XOcJ5Zn5AAM0n/gu7sOVekOgsfvOuYQhsLTAKJJNHFrMUoFn0d3ZPMUPhCDFJDkUd4CRYpvxUE8jLqg1jb0nh/lbsMvNPpqzm8uwcAZb0uwhmS2gYcplKEWT9UbnLaI6NDv8/Mg6FAzskIZkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao2NhYVZz69fcw3o3/8zWJ9KCibUchqA6HlQAhdzj1A=;
 b=pL8ik0TW10L3ZSx+TXD7Q2oP71mj4aCZKhipa9NGJirDtqpEwwZ0ugEtaOMkgv83WZ7opblHelpGah9HOBUbbaJ334R/dBpRvZaq8aYO1oI7UuFt3vNwa+A+MqwqQsN2PnRs4dJogqohCgIhWYNBTPm7y6F7QjUNjRULcDYXDu1FoWABa2noMmIpP5O7gu104201ap8RgOxRoo/Nt59vBD7oAQiWbZxKNWPGicg5Re61qkySstXNiCDAvNYDJg45/NNBnrfPr7/k8rJp6Z3SplAg8lSwhCZW2knNMzv3vBIsDjJvxly5NIMgrZAn8Bv6tp72H2jKnBBpze6TyHVSEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:41 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:41 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 09/24] hw/sd: sd: Keep high-capacity memory blocks at 512
 bytes
Date: Fri,  4 Sep 2026 23:57:28 +0800
Message-ID: <20260904155758.3833179-10-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7e12166-b740-4095-f5cf-08df0a9d6429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|5023799004|56012099006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: RgfgCTIyW8lilQhLi5yI0HOMHfWsuOoCGbzFRsGEN9qNaZgg1Zo8jGcKY0BQPx31bWwB2ePy3KOz6KulKslXWCwW1wGtF9U/UB9gE9UtFz9afl9uUhRRNOix+uyvOGtrUglvxYV34TAjVIgLdtKS7w1heyQVmMRpINxsrCrAlbdYRnURKIH+MRlPRFyTk9hFe5uc+9mj6nn/82p+V4/m67ZWg6hcqISjgbnux0VDLZ+8R4pqAQuQ6uvjAtmr6gIido9G56udXmjZTZ4YnuASBV0z88K24Z+WQ3h//3hJWIJ5a0VrkXi7mT7ymkm4/XSgIK3fIZqhCa5xLdbTLY72IBqFjvUTowJZBR7inpiyRZMoJ31kUgCh1UJMyurIfljbhbAhEmEsv5Tkz8iej91KoUqcn6Z3/1ZCHWPIsPluSTdeOBfr4gl+JCQGc1qNtGJY2M75pstIwRAYkUE41aiHpMiNJA/IiVGo57ndypQyzAR63rdiftistXP3gRtcGJLq8qgYt2GSK8PpgPKoiAI1Q/PZ40dU6dsu09p7e8er2J2rbHHouRjaPMRYY7EalrbT9i+ipgZhYeHy+j56LuSlQaDqGhhibxmFY+Bg4aulMrx4alKQj96rakKp2UpzN8rYUMd4jdLL0nYkIWqzaPy3xnqCKM6Ic6XtGa5i256Bm4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(5023799004)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpB7j6xwkeoabjnE7j6Mzsci3SwBfCa0VD3+8zXqzFabPJSyR5x2QatWlztM?=
 =?us-ascii?Q?5ex0yPlh0rvIe+xjlR2zNoYy023WUvGtgXdyPLaBAnPDHV3VYF9BIj0EN3ih?=
 =?us-ascii?Q?inFQEa6KtroOYyYyR/U9O1/VvpTtARfT/SOtkTsf1GTVG9Yn8eI8/lhbB2Mc?=
 =?us-ascii?Q?2ZJHqOYwHzRJn20CeH/wqz/CtFQyXnvuQBGKFEHJHrh/bj7ddu4+tza7rD3u?=
 =?us-ascii?Q?8gLs8wdmNhmpsHKczdAds5HoPc09NLWcKLLoe3ZzdFXQMb/bJD0zYf3s+rYB?=
 =?us-ascii?Q?QVNuGPmw1WIWTJO/+yORNLmvtkt2YVzOhXPBdA+QZW1n4PiKzuZ+f5u5xKrt?=
 =?us-ascii?Q?3H5Hc7ftPdbK/JVE6kLQJrrrgjl2sMCly9JC7BgWOPhCdfkiakX9N4o7VVRe?=
 =?us-ascii?Q?UgSBX4i5EPcK2MzXlrxRDqesUY1TKAt/1u+z37pMKPxtriQ6a2Er1DwAuX+O?=
 =?us-ascii?Q?ou38syxyfWDgVFanEuAPfk5E+RonaMegrY+Pl8jkZ7Tvy6yIvpKA0KLbyqLa?=
 =?us-ascii?Q?960IE7ZkEBFRh2QUMremqV7sSnAEALL9Pc/gr3MP6/kEk72Mhxl2km4rHf36?=
 =?us-ascii?Q?7NMgXYjnyDssPetaG+leNeWL6N4+tVPfQONdZGcOyuchq8I8Ms3joOK9wE5d?=
 =?us-ascii?Q?87fEcuexsrMtvTLAPy4UavhqfyeYT0XtAuf0YlBGYdmhuazhvEUmXFOoR+lO?=
 =?us-ascii?Q?G6q5Cw9AA4liHOAi0fFtXtOT5J0lvY+MQcM5sjbybYNHsoOzvg14vcmyvLqt?=
 =?us-ascii?Q?3XjT9rrvpJsOw7a33pG5iEYEsNusDrkWtYELHW+9BZrPFV2sHZFP/kJlB0Br?=
 =?us-ascii?Q?qmX7+y4nLcWJcqDoNDi/7ZSmsQVrwI6TzB/eUNJW7dK2edKL71URyKSbLoSu?=
 =?us-ascii?Q?YRB8jAguf1nvGU89j+F+UjeCSJDLgSYa6xXeRcs9AHZGEnW3GVAGlbGPXPI/?=
 =?us-ascii?Q?bD1/6qdoA53PQrhxUIt9bvbF3TI3k/NViH1hTq1r6xgCBvuyVr9lYlteeERX?=
 =?us-ascii?Q?D7y8bnfddUSzoO5LAJ7ul788hQ/Uvami6nPXZAz6W97MIpykm1qRO6dtjZ03?=
 =?us-ascii?Q?OpNht35B3GXu0bjyZx4MCK+c2nXaY2jWdEzV4JjZJbCKLeXv8J6TelCTqJEz?=
 =?us-ascii?Q?AIBoHyPrX8aKSt6C5kNXJ68ustsKOCXqIKY+imHSkZ/Y2TuGYgfCINQCtoiD?=
 =?us-ascii?Q?JE4ZocOoCcg+alS+Wm5RhVIe909bwX0UOjjAGNhWU8aLla8EmQfUkUrEb27+?=
 =?us-ascii?Q?K+aU05XcL+JAmENJYaeUydWnHce+fG23Zcw4IegaBOqrVd8p8zobtv8s9j18?=
 =?us-ascii?Q?Po1OJyDBV31YxihVxpifK7HmGhwLcnIz3QN41I+m/v3alAX4Q+iwSK7Kmu22?=
 =?us-ascii?Q?zwezGTQECGqyAwxklXSGPxaoDGAefywK4l1x+TD/4weApAINq1HSr90e+hhD?=
 =?us-ascii?Q?t9FXQ0TE3gAPllIMkJ8vUPqOKAKHk1U/mz1h/VHFvixw/MDIcHilJrftc7HB?=
 =?us-ascii?Q?Wlfg3wcF8807we2L5mjLqmPmOgbvcmeH2wGWUeJs+qbTL/6NRZG55VJ+EpGE?=
 =?us-ascii?Q?5d+99RNl4tPs/Dlt2nwm/OfxpGIFlJQzsM6Pd71B9IZeSlbQ2H65bI1PbE5r?=
 =?us-ascii?Q?hLAGLrM2LfQnLFy3habEUl6GI4NKMeyh8ONgiKqCBy3lzvX4S77jC80nNTZL?=
 =?us-ascii?Q?eY64cmstGR4PHccyMWec9Xuj/BWfR6F5NBOVtgq7owHMFp5IiEU3v83U+qOE?=
 =?us-ascii?Q?3LoIr0vQs/dsFg3p/PjxWOG7ZRVOSQU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e12166-b740-4095-f5cf-08df0a9d6429
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:41.7831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VVPLTMntJRIVie5frDDAUGyBXjRH+88hTnEdwjn90cOD9urvIKbSYN7wI+7tppvWM2tx1y0FQy1uz6mp1Pgq8qm1nkB/lRTmhLFdGqSHRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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

(no changes since v1)

 hw/sd/sd.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b1b3b1226a..0083b8e064 100644
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
2.53.0


