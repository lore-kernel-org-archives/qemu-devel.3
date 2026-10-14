Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D1CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjL-0005bn-N9; Tue, 13 Oct 2026 21:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjJ-0005aD-NV; Tue, 13 Oct 2026 21:24:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjH-0006ql-Vb; Tue, 13 Oct 2026 21:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuXddMXm90uzm32J1U0dTKp1NO+lP1TpFFkwCE8gdirQlnBwEnJ9bGOe3hFYa2fjl+3kM3hqwm9c+4PRRja+GjVNbnGRT94/wB1m9KjxgrgIqZNqTofX/bfYJWLAFrAMRdcfJ+ll2HCJ85rUdTMYsoit8lE02VtaIzO9hbC91CKXXtVbU4M6XbwXDa2RciYUCZhimoNPTLt5u+VdRsBKqeM69GdzRdHxnYm9T3i7b4yhEW4cWd2u8VUrHUML336oDKrumfBP7/+tj1XBbObX7BhSJJ8YPvfM8ODJu4bR4Hmll67Oh3HUzThi4hA7oSIyM2utKqCMoWfMfiHqz3H/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WO3Zj9WgA8ZeigeRpJPJ3gv6Bua7z25o/HvqHq1QvQ=;
 b=Sw5qRSA/Sia+U9SuMQxZ+Yj+3uWxCUGkzEm4J1lOmprDL2fRy+Av+7RzQ/5070uzKe47nBwRitnLKkBX/tW5ppXIwZ4wHUZofI0TVJ+8miUlWjf9sfN5ghAdh4G9lclsuT+X0OUfluPADhPUX5EtVooJocCjrdMdm3DHbBbP8XmocuGMbeVbT1WWAhrl//VTCZELwHOci1PRDktST/5CJMrzGLHiUV07jxBurq86vwhjqiHZJ/L72Gq88BTjAdqCxNnFTC289YwKsDMrb8/ImJYVCjA60/+xbhxX77N246696PxRngin8tF8PL9DYaV3eBc9gTsVDydAGjzYSArbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WO3Zj9WgA8ZeigeRpJPJ3gv6Bua7z25o/HvqHq1QvQ=;
 b=WrEtIzl5aLq0NjAyiSnpU1z/eTlUsgNK+vBEVymwp0pfErL6f0LQoSO+nKxNoHh3GNGxdXhRDZyjnzSRSQONI0O7p3bK0lD09NxFkziDuQIoaqNlw92DXNu6EpVO2kLZxx9AzRaRGLrbaVVkQ6Cxf2fM6RfQGBXrhAI7DQt2GVw3smYT/PlBqnJQ7Gvm2xAhHHcSzehwpPu7KlpFNgaJiNQ1km084jLxZcsUeXByRrFVPz59MdHAJiv8Wh1lLaOtmceOAXedwCRREzDA6TswrRWl/fKr3IrHE+cvWKFJRklphAqHHx2Ia2EuyqaRb2qX25WsrTM5/2RK6ma+Bq/cqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:15 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 11/27] hw/sd: sd: Keep high-capacity memory blocks at 512
 bytes
Date: Wed, 14 Oct 2026 09:22:51 +0800
Message-ID: <20261014012323.322790-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: ba854baf-3000-4770-fb23-08df2991dc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: utbZgXQkkTSli7HWpQaBcdgnlrcz/W6HX5KGRqvnC3EY4YJwOYzPLfBWyfkqfaPnHuq0rqLlwiroBmyc5KHgCf2bDPCQMm8iS83bRlGfWBOE9Qrwj/LI0PQ6iticDIBLB4TpoP9835fcMlxZaD88Py1qZpZraRHgdxHvckCdv3lAB6LXcS8Tc8FSmfUZvii1Px5lGxn18MkHfPYW2ZuT8THwu5gkzpwd4ObQ3LR/Huk47AHxzoUmUPAaTIE3cPKpnNWQGj/ZUMvnFWTsQWOvWFgvjyxXcG02gjNNv8x0lCM+JlAoK+MPBEZjBy14JU/xu6a4wbZWSs7e4WZMxbkmaThRMHxNW/B2Yw5ViZWuoaEXeTPrueCIONH2YhEoz/+KrdhnOIcsGj/tmxljmepARmOUsp8PjcLt9rZU9o19vvHD5y3KOXC4h8uhhXSj13Eg1sFgwbSa897MJiUBTd06wELKlak+n+f4BOj/E9HAp+CkmyrV1dHQ8epQ4WfRGxZUhrHJa+2xjPlxhF2s5QGCIuCCDKlnWddjPNhSFmR6yhLOReLafxeosCY2HeGdBCAYIKByKqeg1m8ASgu9OutobABZveomPYwnnZ4Vk+GmifRRS72aK8PAGduheX9l7VFQCjx16uu7bw/zSGzLV1srUlXOrVLStR3hA5nSen5EHUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9vSjE4SU9uYk55d0tWcTI0N0JNTkZxdlNqVVdRRXpHTjZ3TnZyaytuV3N2?=
 =?utf-8?B?RVZDb1VacFFRMlIvdkdRSXUzVGRzQmw2a3ZtR2pzQys0akpOTnhFNVBUM1U2?=
 =?utf-8?B?bkNDc2RDWS9zbWdVRS81K0Y2S3Frb0VaZzd6R2YxUXZkbnRPS1pJZlFYUmVt?=
 =?utf-8?B?V2F6Q3VtMVJXNHhqMWJRcnVEVlg3ejljYnBsM1g1ZW81YVI5ZmNnbU5NK2tP?=
 =?utf-8?B?UHEwMmY2R3VRNlFTMkV1bVl5V2hQbzR5TjcwRVd1bGVEa2ZjMC9QVjFWOTJm?=
 =?utf-8?B?TjJQaXZuSWZsY3MvTVdSWG9mNE5DNlNVNVlBdXlYN2dkdncwQnNKRUkzUkJD?=
 =?utf-8?B?ajdEWFBYZGdycGJYYmEzeXZZRWxjL09UdS9GMlcrbGxKRU9ZNnhqMmwzbGR3?=
 =?utf-8?B?NGxucnk2cmFUL0g3djJsNGpEbmp5cGs0MWYzaW50bXloZytucTZVdWJCWXY2?=
 =?utf-8?B?eHd6MGh3Q2JIMHREekplSlQ5QzRRa0d4bmYrV1F2MlJpa1E2NVcvcXRFMmZR?=
 =?utf-8?B?azNWaWRIZTN5YXoxNnFUMS9XNGF0ekdmdDNzcWtCY2xiU3dhWmowQnlLR3R6?=
 =?utf-8?B?MjRlVHh1eitwYU0rcDFpaVBGdkpDWkhPdDNRYU44SUlaYnpvK0sweXIrbHFm?=
 =?utf-8?B?QzBYTVlNam00aHR5WTZFRzBEMk9saXFqa29QaGpLYlpHbFpkMW9uT0xZOEFI?=
 =?utf-8?B?VjlQQ0oxZTFYT3U5UXlqYTNJaDE5YWpha084U1hobng5TElVU1pVbW9sU2dC?=
 =?utf-8?B?OWp5dHVZaVliSWc0SVQ3WVY5aWJjVnkzUHhKOWxWOE5aOHJodkdId1NnYlAr?=
 =?utf-8?B?Ykx4UUV5L3N1YmRMVllHZ3pFU2Z6dm0vUXJQa2Z1NDdVNE9JVnNEZjE4VHFr?=
 =?utf-8?B?N0ptWVdFTXorNFlURDdjYWM3RE8xNHJWWHc4WkhZUEpVdDNkUE4zR0EwQ29M?=
 =?utf-8?B?eXF1U2ErakJxb2xBdENPdEhHSWRDZy9CRm5JT1l6Y1hPL3Nua0tOTExjZ3I1?=
 =?utf-8?B?eTNlWGEyVng0eHdCUTdmYVlUdlgyM1lhNHlxY0hlUUpPYVNYSXAzd1pLOW5T?=
 =?utf-8?B?TFJHbHpvRElqbzNyYm12QzVPQzcvTEgwVjVvU0F4aWlFZVVEcncwdWZOU3Rp?=
 =?utf-8?B?ZGNjcXFqU2FtbjdkdlcwN1A2WEhzRkR1b0pTNTU0em9lczhqUUNRS1Y5YWFu?=
 =?utf-8?B?SWVlM0xaU3MzaUVxNlIrSWFKcnV0bjF0MXBqTmh4NFBkOStKZmVWYXVteTJB?=
 =?utf-8?B?RVpLZC9CdkN1clFKQmVNa0k4V3RwRFpUUDczUEo3TU1ERXgwZzRBUlpleTlZ?=
 =?utf-8?B?MzlBMHB0bk5Hd2sxbTgrWm83cjhLYWxtTWFjS0tQMTd4aVhLOHdtY3N2OHFE?=
 =?utf-8?B?SEozOUtrb0xXSmtIdm5iaXptZ1FLelhpS0tYRmJMSjE3Uko0L1V4TUFhZVFr?=
 =?utf-8?B?b1hWbms5VXBNSC9PVFhnZWhiTGhZdlZNdWdGT3lyb29zaTJGbmZScUxIME9Q?=
 =?utf-8?B?NmtnR1NnR1p4eklsaXY4ODhWSTVBY2JxTUNzcHIwTElvL1ExczNvUHNTWEJH?=
 =?utf-8?B?WURyWEwvUTlFSjQ2Rk84ZHlzbk12NmozZVpkNHUrdlNjUkpUTm5GYm1DejFD?=
 =?utf-8?B?SVM5U0NsRUlVVktlNG9LcTlWNVV3MUpqcDh0THdwMlBiMkgvSUNGeXppaThK?=
 =?utf-8?B?SDN6K090a0R0QlZjNzNycGNhQ1pyY1dTWjhzTUlwVk1KMGhMYzBRcDFwQVpt?=
 =?utf-8?B?VEFjMWQzVGRFYW1wZHFFQ1hZR2lsbWRsOWJOdEFRVk5sNklZWG1jMVpldFR1?=
 =?utf-8?B?bFVBWjlreXBZOTRDam45amJ3Z0pVb0tBNG1Ta1BXc21OR3IrajZweEZTNUJt?=
 =?utf-8?B?S0pNQXl1OVE3WkM4SlkvZ0FVZGpFZlEyMkp4eWZpRkFjZVdZTTlmWmpkRUJx?=
 =?utf-8?B?Ykp5VlRZaElQR0hzQU5hU3BSME04VTBLajZkd2pvYS8wV1BvWktraFNUL2pZ?=
 =?utf-8?B?N2hWa1k2Q2N0YUswN0I4N2dUbUNnWDVSdER2dlVNTkdDQXlsdkpDZkhKSjB3?=
 =?utf-8?B?VzFCTVZCdzFVU1VsME8yUGg2MjVTcGR0QzlVWDcrUEF1RlVxWTREMkhJZjRI?=
 =?utf-8?B?dWtNOEV5WlprbVZWazZJTGhDQmQzMzZBenRLenJuVDhDaDVKZVc4VnU3V0l5?=
 =?utf-8?B?b3pIWkptRjg5c2EvQzFUOEhyZEtWdEtxaUxONVRHOVFDaTI1WkxGNVpBaWh6?=
 =?utf-8?B?R201eklwQmd1MWR2Mk1MVVEvTTUzRHJqRkhDQXVKTXlWd1AvOTlzazBnYzB3?=
 =?utf-8?B?ZDVQaVlQQ0tybjI3ZUltSURQSTl2dytlKzNpa0dtN3dvRDFZZjM4UU4zcWF0?=
 =?utf-8?Q?arMuWB5rnJq7LNl0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba854baf-3000-4770-fb23-08df2991dc6a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:15.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0fiUNiNTOhZchNlUVzXhK2NFEI8NDq/i5UTqCGNHEb+zIyB/0X+ZzxgakZ+do/Zot3oRcWye9F6c0hvnOEw4g7z7g241cm7G4eCO5LZzmw=
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
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


