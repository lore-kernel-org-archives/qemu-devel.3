Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408C0CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD397-0007F5-Th; Sat, 03 Oct 2026 13:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD393-0007Ci-Lx; Sat, 03 Oct 2026 13:03:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD391-0007CD-9T; Sat, 03 Oct 2026 13:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPKPivIagSFAWko3vDyinp8Gl2Q77b0+jr8D4Xmn6cQ3A1YD0CrG3PV4L4zDuarR1qvsDGR+cgVHlPaeQhanPHPUI1Qxa7Y4tgejA5QabIsbPYQ+P/ezDQ5/YphBickv19ULEDBmy5hxd9MPOp61yVRXRbvjprAQD6NwjXeMLM6wDePL4nBDkHe30agh4dFYkg4Q/12s29DfRymGxMVNEUBgWlZwaZPo2wiNNzRi630PGyzhYcNQEQFkyY8ePAo9scoBi9h0C1Y8pohkYAYAJRGrmne9mVCGwRuHf0UJs6PSyOQHzFfD9oBK0+ID2YFdRoFQjAyE8RK5raJTUhkGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPkpl1EP/X8ZOXj4mJpQvJ+HRZtUoIVC3AgP0kGtxuA=;
 b=YpuBxk1HdEEoXnCf+EE8pQ+EnYwnFgstWihlgPFmAsTT40+OeHFJPaPyoqB8zs6xFGJD0SrDgiAN31EqxDu4D/tmuHzG6EpplMm7MGg+qMSmAZIyTKQeVvU9v9PVX0piBrbQB/Uf0ItU5yLT+J3/HlveG/FAaV9zSH15CKNyP5Oilf0W9dONVrkKAeDljFSD0LZyHqVn3Fn0bHRLwfpF7HWJX4m2mduBQotbDhbz9s5wVtFBuaomTu0G8kARKG376t8dnQcpx1URwrwLS0YGp0kFsCh5KPD8MH3IG3q2hte1jFVfig/Lf6rWyrnfVc5Ztija1qJZH5pjOI+IORmPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPkpl1EP/X8ZOXj4mJpQvJ+HRZtUoIVC3AgP0kGtxuA=;
 b=UvXC8tdHWptUx1f/kPOr5ORWysFGKLTuDzKx6EBsw/CrJp52B04/go0bGMohzsBMB3xskBjo/5m9P1iihTIEOiFMPsKiiLdsdj5doTG2fJL5609yKbRSQ5cinsMQQrOOjtVztDrznTHG1E9LKL3ycONm0qwyiuXnvIEtbjiSyw9Ykrc/SKJdc/iWdeSTF6NUkjkglFzAvVl2IXVI/oUAoBN87sLOL3Uu1gk8HnNQcaJ70ie+mf69OZeiQTyOLXie8Gml8Xr+ZXZn2hO2pfBO7uDL1leIf83VWMlG9RqCXAs2b6sjmQVirJALFjfGrqwY0cZSG8VQVeSXK+dlW0GHsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB5788.apcprd02.prod.outlook.com (2603:1096:400:1d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:24 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PATCH v3 11/27] hw/sd: sd: Keep high-capacity memory blocks at 512
 bytes
Date: Sun,  4 Oct 2026 01:02:01 +0800
Message-ID: <20261003170232.2450916-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: b365573a-d146-43e3-bced-08df21703c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|5023799004|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: dJFENFzd5F9Eks2MjIl/tmHDXjg2ovnhLDMkBec7BFVmuHx/Oi4XNzyKZ9TeZWo+0ptVnLNKeyjpSfeJQli5hW3sNmBelVzVgnQnwQcqThlTWI0gz8H9vb71lXo7YRBPR1rCf3988SCxTh39iu7cvf2xOE+b1eLuagqDSlG2sS7tirkR/JY+26FIz1zcPrSr+jvwJnnKQmMeCKd+7kdfhamwc9+l9K/GumWYVKq6SeQ1rcL7k+Z44Ywt5iD+jqrNBmIFBWP2FC8ev1LSQsQH9BuWWIkAWpSVGgNfSAGkGxjYFJXqVTgSr9ZDIkdAYK3HqYfPBIAaNYKKcoO2nfQYjZmelGHG61wm4X0WZP7NTh0M+vC7RS0Ie9CBw72rt7alKgQtNI7/QCj0TvAs1doi1jd1Oiq5x3guHEV5bM6uKj+grH98Lseugkq0jvtmKgx5KbsLiQxYJAm/eMBZI2yDmwFcvIyd5lfhfB6A7x5xVSU4tzmpguLrvwGjmIIGFt4voGPLAv19SAMooIu1k3YISU/PJxOXyy50+r8ipv5K7g7ssU49fLJiUZo13eYtiBbx7uEZX1Y40YVgsPeEiZ1oTDqAy/hp1fChK7TI8coqEzaqwXdJ/7oaJUkTAfeqavfQBP3olR2JxNfasmU31s+/3om0lhsHCfRvyhJXY2AVRw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(5023799004)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJQUzJEZEpEVEl0WkZoL2UwcVBJZGJGMGdkT0RDNmxPNGYwTVY5M0xuQjg3?=
 =?utf-8?B?b21oRExzU2R4QVByYUhBcWYrN1kyUGRzcjllMWdhLzFiRmp5NHd4ZVVpL2RC?=
 =?utf-8?B?OXV6VjJFK0NESDVJNmdYVy9VYzZ2Y0xtRkZBVHAvSDFMdTRDWTNtSDBlblFo?=
 =?utf-8?B?d2pnMkc3eTV6WkJIVG9YaU41bktQQnI0dTRrT3VyQUYzRkdBQXpBM2d5clp3?=
 =?utf-8?B?RW1icUowRmU5eTdpUXhseG8yV0l6Q2lmMzBObkNHc2JiandiSmY4MXdPeml1?=
 =?utf-8?B?YW5Jd1dCb1F3ZTRsaTBHVDF5MzFMN0NsYVpZVHlwSVNZNFdxY3J3bkpzeTAv?=
 =?utf-8?B?ZjhnQythYWlxSXhSVkhiUFNsN000Q2tYNVlpWm9kSUdTWHJGSG85YkNxbWV4?=
 =?utf-8?B?SmxRWEU1cGV6N2RmMXRCajl5NXpLbk9KNytTUGNwYUY2cFdDYzhxNHF6OEpm?=
 =?utf-8?B?VVdNQnJSNUZBWDZrcjUzVnE4OWdxT3lFS3JuKzlkNXlaemVFdFV4ZVc2UUJ1?=
 =?utf-8?B?SzJYWjBoY2x0ZEUwNjJmdW1rYzhSbU9xbUoxVFN4Z0d0L09ycDVPOHR4MzFz?=
 =?utf-8?B?N1VJbmpXZEJJd1huNUZqSnYxM1R5aU5LLzREREl2czd1UXhRS3hBZUxKQm9r?=
 =?utf-8?B?bHZBMDArZnhFZkkyVUlKWkFqQTBvVEMrOG9tQ2JRaENWYS9NNWJFOFRqK3NJ?=
 =?utf-8?B?Zjh6Vlp3QTYzQWMydFJ0U1ZuZDdWNVByeDFmeU5yOFJjTmcvNDJFSjJubkp2?=
 =?utf-8?B?R3F2Uk9NRzZyMVdOMFk4NzZINzE4T2pvcDB3UXczSUZhNU4vWGtQSE8rcTV4?=
 =?utf-8?B?c0RGY1pGZ01EQ0RLQlYxMWZWZCsxSzR4c1owMGJ1a29LdmxCVDliYXR5OXhk?=
 =?utf-8?B?eTVWcytIT3o4RExla2xEY1BwekhidjM0M08xUUZCSTRuNGgyNTZxNTRzMjJz?=
 =?utf-8?B?bENsRmRsVW9mYW1SMTJNOWFsd1d0aHVGOWQ2bkRsS3IvWVFmYURiQllSSi92?=
 =?utf-8?B?ZENkZm5QS2VaUnpQUFZCdHU5L0hJUTU4UFlwR3R1NnRCNnpIUGVnUGdIRjQ2?=
 =?utf-8?B?KzVzY2lMc0FTa1RORzZ4NGhST2JzN28xekJ0R0orOGtqdm1WcjJiTlQ1L0ZY?=
 =?utf-8?B?ZEU2MkVYV3lJWDZWZWhFVzJVaHNGV3lYYkJhMldtdmI3VlRzS2xSaHFZZUgr?=
 =?utf-8?B?VmVacWpOY09nTlBSa3p5ckcyQVJ3RTUxcXphR2d4YjVXNTUzV0FjNHVlWnJs?=
 =?utf-8?B?OUkvYXh3TUtMSUcydnpwa1B4T21QZ2JYN09RQ2hwUGxCNG5JMWxDTTZCR01t?=
 =?utf-8?B?K0xzbk5xcWFvTG52SE5BNTJuWk8ybXVEVzRFb1gxVjErN2pUS2g3bGc3ODEx?=
 =?utf-8?B?bk40bU5IeVgyNmFCd3RBeWorUzN5bm9GRXh5ZFhRUVZUbk93NTdTUEtqc1FH?=
 =?utf-8?B?Vm00dlFQTHZqUzhFakxxbjU2L0pwSnRZbFF5SnBYN2J5RGIwNEs2NmxmOEZB?=
 =?utf-8?B?WEt3YXVzbDRBZDE0c2I5NVk5d1ZMbThzRFh5N1pYN0EyQ2xITWhMbzdXVU93?=
 =?utf-8?B?eDJZSVdPRFhWWU12b1IwQkRiM2dzb2VqZGtlaU4zdWdPMEFLcUZiampHeE1O?=
 =?utf-8?B?UW52K2pNUCtEd3UvVE1uMFJ1b1JYN0ppME1EdDBtMVdBL2d1KytwRytrWnpl?=
 =?utf-8?B?V2RBUjIwalR3cDRrblF1cFhneG9LaHVjdm01VWJlQnhRZTJVOHhicEVWTWVB?=
 =?utf-8?B?Vit5WHQxejN5SzhOdDhpdFl6R0ZHNkEvWHJIMmt5YzFUZjU2NjhPNTIxY1lE?=
 =?utf-8?B?Q3NZUVRONVNrMnp0cTluWko2OWxQZ2UvQ2h6dWJYV3c5Tnora3ZFWFBMeXds?=
 =?utf-8?B?K2VabmFSSHFzMm1mcnFhd3paS1JzL2d4bVEwRlVjaTNPbHhxUzBneHhHNW9Q?=
 =?utf-8?B?eVRqaytSNWxtcTNkSGZCb1pDU3M4MHZQblZHR0xlL0RrQVRNQ2ZLZzl6S1JB?=
 =?utf-8?B?cjJSN3N4cW9sQWdHVC9JdTRJYnVEcWNhWCtvSDRCelRpTXB6cVVsZXNreHFF?=
 =?utf-8?B?ZVUrbzlVZDlWQ0JaeTRXajBBVEViWCtTUi9rRXhWblRQOEhENW5kNVFBaUNR?=
 =?utf-8?B?dDZiZHZwT3c3ZnBlMXFlbVpNc0hvUEo1MWpOUGVVM2NYOVVzOWV5ZWxUYTB1?=
 =?utf-8?B?bGhBZnlLMXVCaVNHUjZqaUlTOW1pSnk4OVRtVEhvOEhtNG5PZ0NtT016WVpz?=
 =?utf-8?B?MDRHR2kyVE9zbkw4ZmF2NFdFd0lidEJobTc4NTdWNnRpSzdXUmdRNVI1YXh1?=
 =?utf-8?B?RWltVlBWNytSYk1TNCs0cDBWS3pxTXlBQ010TjRId2o4OEdjdGZsZXhaQTdE?=
 =?utf-8?Q?7HxrNYWbOh/JtFmU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b365573a-d146-43e3-bced-08df21703c35
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:24.1424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+VmbJ0OeXe9TqV6wQQWQ+UPlN0ozqu5BKfxpTog+JMWbQfHH6Q6GB9PVrRDZ4JzrgNCD2U6VA3SL/VwugbSrmHx414NVxYVipy9e80WRWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5788
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


