Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D78606A334
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=N0ceGsdV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8o-0001ns-2w; Wed, 04 Nov 2026 10:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8l-0001na-Tf; Wed, 04 Nov 2026 10:43:08 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8j-0001Gk-MV; Wed, 04 Nov 2026 10:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sId+/2AhUncRkmWiUPJCAT4MKbBF7Yef5Sf24GZEiww4uV5AP+7SfYtAY9kLZ0fBwxIGUER6C598w4qg3uS7DRXJ9cvSr++7N5GI9mKPTtJh36GJ6olNWEhcFROgfZ8DYQKAi2+5isQAZhZxdggNFyUf3NOi2G+5KUSlgL+sHzWvv2aetZ2wxsYKL1LwtNKmk/9eReGiS9oWpys2RlQa2+BpKUUln4WKwRJpmL0xjYrTwlPtYoWsf0amxF0enZQDPYFRnvhtU7ZX9oTe4eX7d/J88+kAeNkLit4XzWncwn1/Qf+unxM4rRnx/9/DydID8AXnXttaE1kCOkWN6roQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fX15NyMg2FUWXvrzeSgk7xRqMUxSwpaCZcX/lV7Uv8=;
 b=xv+AgrbHZGSFbdnulNOy2twhAAwg5firXdz2f2/uxpyakOwjaSZKq2bkiWb0l6J4WooIWaZTzeIEYJrhKU+i74185i8D6eaQpz4+No1HZMOIN/IlEK46MWBXP34qDZAyQGgKLDTdEyDLTuHVQjoP4uSEXAbtIkIViQQ8ILDT3z8SIEKZnQcJs7O+mnJKUUCkxKruAkCw/5vvjK+FsGZKvxlucFI3tv17ZL3MCZ8BQ2zGODUbRov8czOW5UpRSd6iXCWa1F2ErFNmRsDJI2ktHfgmC4XsMSa0+on8sCJ3IILPc95VPUEqWcxndQZuhoDvI3P2/7ceAnT5DzE1QNlZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fX15NyMg2FUWXvrzeSgk7xRqMUxSwpaCZcX/lV7Uv8=;
 b=N0ceGsdVR7HeqO28QW3J/ROaY6G9KXD5mzQKZw92DTDkkPSHzceZkncyt5Wuug2Xkt0VumX679nFS0XWdgOhNl+xPV0LJFRgep+TRE9GCblNsNuXGDYuGIkSyWVn8oP5L4dPVOGH5qqs2JzVXUDru7e2Xn1CIEkDcInyt21iCtjyL2Jecu+D+tytAFlhetv6bsaLfj5SD2vMapGl/cxBN1Nn8YW0852afuTCXJw84CkgscTGVM9qktzgEpOY5fjwq6aQl2Nm8+LqHsFXw5k6UnQcPUq9bqEogNhSxQHhuX41HhfTvPA1lZAnejFCerC+XOxT6qGZ7DD50N/R0R8fPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:55 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 16/26] hw/misc: pfsoc: Model PolarFire SoC serial number
 service
Date: Wed,  4 Nov 2026 23:41:43 +0800
Message-ID: <20261104154207.641511-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf9ad11-a41b-43e4-3251-08df3a8a4b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|260925021311599003|260925021911599003|260925022911599003|56012099006|261022105027099003|261021121427099003|261009223027099003|261021130227099003|261021123027099003|261022075727099003|261021135927099003|261022115727099003|261102123227099003|261026130827099003|261021133027099003|261022113327099003|261026121527099003|261026140227099003|261026135527099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pzR8y7PzLOpe/MCR0oSQrl/ezsqNNs1M/l/MRDbjrq15vME1+WVQV/UqhMCgDjUSRWOBTsXXuDntO0hzHpMnk5+7Jlh7ojhuPYs9sYHr1H7fMC/I3yH5nISlBbP5txp/nedBfbGUq5TflxqVwoDtS3wSZ7Q1wnxyriZJm7Jk7hYXKC6tT+ZgQK2Mt69XvmBr5MwgY+oWzxyloyj1fhtMe3QubGX3Xk0FOV/zcrEL3lwlivkQkHaqoipYyDYkoTM4FsWCsKwqKwGeyuvsmY2YYFm9yAIC864VQccCcAon5svKrLy2eJ99u1kUWG5vqt+gw8K8JuxLx+Y+NKCvMRu4SYiVP5iUTusKBBsxipKLc4IeQCXpaetXK+u0OpjPF9ETLg0olbanP/2VNavEAC0mKNdx8T4sk355tvRRiaYphXyWbBfeX6wuatKyj7lAXCoEizn4mm1a/wkxjqqvDpfr98oaOy3uhBzV4rHK276CNTKVi4xAtPKMyTtQZLWELpttZSLSnlYXjDREJML1Xax1SDynSDkpJPtMbLIlsg25jN48J/Us0WK/6IC/HIFNk4UVLEs1RB/raO1+0wi5gMShsea3gPvhqO2lExha2RvTeRnCQv7bDT9dl0lDgIJ0JNHqjtlTzL7t2ANEiA1ACIv7vRiprtnIWL7g1tNJ2i5qXGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021130227099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261102123227099003)(261026130827099003)(261021133027099003)(261022113327099003)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk5oMlptY2g1YThqT1ZwM1FCYW9rcVNiSEp4VEVMdE0zUm9wTTJaRkdDaldt?=
 =?utf-8?B?ZXVFQmJqMU55VStaaWdjWmVjV29mdCt4TmhNbXdObnVnT0xWWjR6UWxFUDdU?=
 =?utf-8?B?ZEE3WWE2a3BIWXZmenJ4L0hEazRDRVQ0UWdiWHN0MHdYeEV0bGZTdnk2dFZs?=
 =?utf-8?B?T2p6ZkJ5NHNUWGh4blY2ZVRkK1o0eEdNUHBRWjBCa2ZlRmZjUE9hSkQ3dHpY?=
 =?utf-8?B?YUZwVGVMM1VmekJhZVBRclNTanNXZmhGTHZPOUJaaUk5TUlsN3UrZTY3aHdD?=
 =?utf-8?B?QWFXY2RUa3lPZjJZMzhYZUpRSUtuUXRDdnd3K0tSWWQyTlE2a1QzWEIyNlQ3?=
 =?utf-8?B?YndUZ3kxSU1YWnhXMVlKRmE2OTVGWXAxelR3aWdDRm82ZFc3WnkwUnVpcWlR?=
 =?utf-8?B?VXBqZUc5RmoycndJZDNNZnBOaW1QMWpXUHo4YmE3bnJRSDVyK0NhTEEva2No?=
 =?utf-8?B?Wm54WUZLMjR6NmZvTk1KM2RZK2hTcVZCZWRxYWlkd3dFYU1SVlNuaUJBMmJS?=
 =?utf-8?B?VUFrZlgzQThPOGViVUZoTGIxT3ZOMXY3WVFIazA1S2RCMysyaHU5T3BGc2xj?=
 =?utf-8?B?RkZBZjVEN2NhaWtPUVdGb2xVV1BmTmNRQitFenZqWERmNVZ4aFU3RjdHN0hw?=
 =?utf-8?B?cWEwWnc2Zk1aNDdZQ1pCN2RBajNTM2pJMlQ3eGhCcG1XQ3hnRU0zcXJUNUNo?=
 =?utf-8?B?QjN5S3h6K1pQWTNINE4vUWY0bnZsM0YrdVI3cUlScWw1V0NhZ1d6QStFN2lO?=
 =?utf-8?B?WkN1RXlsTThFWi92TjBNQllkUVkvME83Y2FMM1NLYzc3dTVadFhOdkxadWlW?=
 =?utf-8?B?aHduRDRBNW1iNDFRWVhoTFhoRTJTbGxWcnp2NnFkK0c0ODdBNXFqTlgzK0FQ?=
 =?utf-8?B?Z2RTOGJOSlV4UVQvODZMelk3UktvUG81d0lOeXFIMmdSUzUxUHV3MERIcUJR?=
 =?utf-8?B?TmMyV2FzNnpmSGk1VmFNbmJqMkdwd2dCYk9wNEFER3FjZlgxVlBGTUw5TnVq?=
 =?utf-8?B?WUxIQUdYLzhiSmloR2pmTkplQ3N1V2NNWURlTitlbm1Db3lYRXY2Q3VWdDhJ?=
 =?utf-8?B?S2pySnhCd0JkRFFTeG1jNWZqZ2FOTkF0MWlsNjI4aWtBZGRhTmRMdTU2TVF4?=
 =?utf-8?B?R2xLdU9XNVZqaFVMaUg2dERtenlidURMQU5sSTAvMzZZZ2hORTd0WUI5Syth?=
 =?utf-8?B?a1lYVktJaGQycEdKT0NMY2VtM1h4dDJIK3hUTU9pKysrWVY3bk1xQ3k4TnU3?=
 =?utf-8?B?ZW9sV3JjVXR6VllrQ2xiaGNiNStWUDJRSXIyYVQydjNEeWgzMGNwaFZmdzhI?=
 =?utf-8?B?NkYwVnFpaXFYN2g5bEdQNk85TWc2d1kxRTlPSDVLM2hBUW5nY2hkUDZxdmxa?=
 =?utf-8?B?QVZ0NTBtWjNSSXYrSmcwZDBWUUtkVTZKWlFqK2sxUnJQcndLd0FTdmdINnps?=
 =?utf-8?B?T24yaDNPSUppNzlXYTg1V1dDQlJFWk8zdm16WE9XWnZQc1cxQ2ZRSElDRUor?=
 =?utf-8?B?TTVOR0xiZlFNVldIMXg1eWd3c213RWxUaVU0SWt6ZzZCd3J1QnJkbEZsNEtO?=
 =?utf-8?B?amdKeklEN2l1dDdidy9aZUxwc3htNURqWGxwNmxmQ0dHZ3ByakVUM0hzQnNE?=
 =?utf-8?B?OEMrR1BsRy9aeDNBVEsxb1BlQmNkd3REV0hhUis3Z29tU3R1WFZMUmxQWGJa?=
 =?utf-8?B?LzdyTzBXbHhYcnQrRkFmV1RrNFJmOVo5VS9vRG9Ra2Q4bVZQdHErOFV3L1FI?=
 =?utf-8?B?QXJwbzFYcVZXNnA2aC9jaUU5T1ROUWFLQXRJczZTNEFqL1puOXpNVkx4Qys0?=
 =?utf-8?B?eHArVnJxRDJjRGtQakNCcWRyVEhUa2xFdlBBM3dxY3FKTlpiNCtYZFg3NUVT?=
 =?utf-8?B?cm95em9YS244cWp1Z0VLM3ljc0pXdUVLems1czIzUnYxa0hjUEJGTjBPaHFj?=
 =?utf-8?B?SEJ3VGhBMXByYmRHb0xpUEttc1NkcDMwa01jYVdaeVh5L3h3TU5OQ1FYNjcz?=
 =?utf-8?B?UWh0RE90QUNPVHo1OEw3UG5tczBzTXd6MTAwMXdVcStmemJKL2VoMm5ZN2pY?=
 =?utf-8?B?VVc4Tk50WEk5VExHTFpqbG82ekUvc2xsVDBaM21rQlJ2c0xQcVF2TTBQaUJQ?=
 =?utf-8?B?YVhubmVsOExQdTJGRlorYUlBUkR2MW54NUJ6SitCakpqbGlFWTMyTmJwV3kv?=
 =?utf-8?B?WU4rUTRTMHpaZlkyQ0N2a3AyWEVqWm1hOTU0RlFkaFM4bjdNNUMrYS9TVzFx?=
 =?utf-8?B?RnBTNW1TTjkxTkxrbk8zdFdoVGM3NE94dUp3N0lLNFZXMjgzVSsvV2hxOVZH?=
 =?utf-8?B?eFdaSUZHejlmREtWZkt2VDRYMXN0MjF6bVU3QzFRWlkvQVlwU2J2eUdzT3F4?=
 =?utf-8?Q?9VpKf8DeeFX2fHwY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9ad11-a41b-43e4-3251-08df3a8a4b13
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:55.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEQQtRok7T2fgnIrDlo27cqXaDzsjSICIEVZ9EKVBcF8ovmkIyl7QaJd5FRQB7Cz1LPUBLxZC2JCFxCZWxAEV+3zqlQkhQf+RwnMTdIfxPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot requests the PolarFire SoC device serial number during board
late initialization. The IOSCB previously rejected every request, so
board setup could not complete.

Model the System Services control registers and byte-addressable
mailbox. Obtain the 128-bit serial number from an optional device
property, using a deterministic value when it is not configured.
Return an explicit failure for unsupported services and reset the
new runtime state with the rest of the device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Decode the seven-bit opcode and nine-bit mailbox word offset
- Bound serial-number responses to the documented 2 KiB mailbox
- Mirror the current control flags in the status register
- Use default access sizing for the control and mailbox windows

 include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 156 +++++++++++++++++++++++++----
 2 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 9687ea25b1..aa108d2d88 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -25,6 +25,8 @@
 
 #include "hw/core/sysbus.h"
 
+#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x800
+
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
     MemoryRegion container;
@@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion cfm_sgmii;
     MemoryRegion bc_sgmii;
     MemoryRegion io_calib_sgmii;
+    uint32_t services_cr;
+    uint32_t services_sr;
+    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
+    char *serial_number;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 09b702e520..850125c8b4 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
@@ -37,6 +38,9 @@
 #define IOSCB_CCC_REG_SIZE          0x2000000
 #define IOSCB_CTRL_REG_SIZE         0x800
 #define IOSCB_QSPIXIP_REG_SIZE      0x200
+#define IOSCB_SERIAL_NUMBER_SIZE    16U
+#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
+#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
 
 
 /*
@@ -186,33 +190,88 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define SERVICES_CR             0x50
-#define SERVICES_SR             0x54
-#define SERVICES_STATUS_SHIFT   16
+#define SERVICES_CR                         0x50
+#define SERVICES_CR_REQUEST                 BIT(0)
+#define SERVICES_CR_NOTIFY                  BIT(3)
+#define SERVICES_CR_COMMAND_SHIFT           16
+#define SERVICES_CR_COMMAND_WIDTH           16
+#define SERVICES_CR_COMMAND_MASK            \
+        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
+#define SERVICES_CR_MASK                    \
+        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAND_MASK)
+#define SERVICES_SR                         0x54
+#define SERVICES_SR_CONTROL_MASK            0xf
+#define SERVICES_SR_STATUS_SHIFT            16
+#define SERVICES_COMMAND_SERIAL_NUMBER      0
+#define SERVICES_COMMAND_OPCODE_MASK        0x7f
+#define SERVICES_COMMAND_MAILBOX_SHIFT      7
+#define SERVICES_COMMAND_MAILBOX_MASK       0x1ff
+#define SERVICES_STATUS_SUCCESS             0
+#define SERVICES_STATUS_FAILED              1
+
+static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
+{
+    uint32_t command;
+    uint32_t opcode;
+    uint32_t response_offset;
+    uint32_t status = SERVICES_STATUS_FAILED;
+
+    if (device_is_in_reset(DEVICE(s)) ||
+        !(value & SERVICES_CR_REQUEST)) {
+        return;
+    }
+
+    /*
+     * System services complete synchronously in this model, so clear the
+     * request bit before exposing the response to the guest.
+     */
+    s->services_cr &= ~SERVICES_CR_REQUEST;
+
+    command = (value & SERVICES_CR_COMMAND_MASK) >>
+              SERVICES_CR_COMMAND_SHIFT;
+    opcode = command & SERVICES_COMMAND_OPCODE_MASK;
+    response_offset = ((command >> SERVICES_COMMAND_MAILBOX_SHIFT) &
+                       SERVICES_COMMAND_MAILBOX_MASK) * sizeof(uint32_t);
+    if (opcode == SERVICES_COMMAND_SERIAL_NUMBER &&
+        response_offset <= sizeof(s->mailbox_data) - IOSCB_SERIAL_NUMBER_SIZE) {
+        /*
+         * The descriptor contains a seven-bit opcode and a nine-bit mailbox
+         * word offset. Return the 128-bit serial number at that address.
+         * See section 3 of the PolarFire System Services User Guide.
+         */
+        memset(&s->mailbox_data[response_offset], 0,
+               IOSCB_SERIAL_NUMBER_SIZE);
+        memcpy(&s->mailbox_data[response_offset],
+               s->serial_number, strlen(s->serial_number));
+        status = SERVICES_STATUS_SUCCESS;
+    }
+
+    s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
+    qemu_irq_raise(s->irq);
+}
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
                                      unsigned size)
 {
-    uint32_t val = 0;
+    MchpPfSoCIoscbState *s = opaque;
+    uint32_t value;
 
-    switch (offset) {
+    switch (offset & ~3ULL) {
+    case SERVICES_CR:
+        value = s->services_cr;
+        break;
     case SERVICES_SR:
-        /*
-         * Although some services have no error codes, most do. All services
-         * that do implement errors, begin their error codes at 1. Treat all
-         * service requests as failures & return 1.
-         * See the "PolarFire® FPGA and PolarFire SoC FPGA System Services"
-         * user guide for more information on service error codes.
-         */
-        val = 1u << SERVICES_STATUS_SHIFT;
+        value = s->services_sr |
+                (s->services_cr & SERVICES_SR_CONTROL_MASK);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, offset);
+        return 0;
     }
 
-    return val;
+    return extract32(value, (offset & 3) * 8, size * 8);
 }
 
 static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
@@ -220,15 +279,22 @@ static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
 {
     MchpPfSoCIoscbState *s = opaque;
 
-    switch (offset) {
+    switch (offset & ~3ULL) {
     case SERVICES_CR:
-        qemu_irq_raise(s->irq);
+        s->services_cr = deposit32(s->services_cr, (offset & 3) * 8,
+                                   size * 8, value) & SERVICES_CR_MASK;
+        if (offset == SERVICES_CR) {
+            services_cr_write(s, s->services_cr);
+        }
+        break;
+    case SERVICES_SR:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                       "(size %d, value 0x%" PRIx64
                       ", offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, value, offset);
+        break;
     }
 }
 
@@ -238,11 +304,62 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+/*
+ * The System Controller uses the mailbox as a byte-addressable shared buffer
+ * for service command payloads and responses.
+ */
+static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    return ldn_le_p(&s->mailbox_data[offset], size);
+}
+
+static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    stn_le_p(&s->mailbox_data[offset], size, value);
+}
+
+static const MemoryRegionOps mchp_pfsoc_mailbox_ops = {
+    .read = mchp_pfsoc_mailbox_read,
+    .write = mchp_pfsoc_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
+{
+    MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
+
+    s->services_cr = 0;
+    s->services_sr = 0;
+    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
+    qemu_irq_lower(s->irq);
+}
+
+static const Property mchp_pfsoc_ioscb_properties[] = {
+    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
+                       MchpPfSoCIoscbState, serial_number),
+};
+
 static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    /* Use a deterministic identity when no serial number is configured */
+    if (!s->serial_number) {
+        s->serial_number = g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
+    }
+    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
+        error_setg(errp, "The serial number can't be longer than %u bytes",
+                   IOSCB_SERIAL_NUMBER_SIZE);
+        return;
+    }
+
     memory_region_init(&s->container, OBJECT(s),
                        "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
     sysbus_init_mmio(sbd, &s->container);
@@ -265,8 +382,9 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s->qspixip);
 
-    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
-                          "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_ops, s,
+                          "mchp.pfsoc.ioscb.mailbox",
+                          MCHP_PFSOC_IOSCB_MAILBOX_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s->mailbox);
 
     memory_region_init_io(&s->cfg, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
@@ -343,6 +461,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Microchip PolarFire SoC IOSCB modules";
     dc->realize = mchp_pfsoc_ioscb_realize;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
+    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
 }
 
 static const TypeInfo mchp_pfsoc_ioscb_info = {
-- 
2.53.0


