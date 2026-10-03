Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F258FCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Au-0000dZ-Nc; Sat, 03 Oct 2026 13:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39K-0007J1-26; Sat, 03 Oct 2026 13:03:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39H-0007Ds-3a; Sat, 03 Oct 2026 13:03:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQVfVQwHUlyWbZQ6rX+ChuPo0V/Wqg7JCr4hDilrOny9X6jewFqduAGL61jJjXkvHwDismM7maNN1GhezdYceYfT7mtohl2QJdpSAd7VimKXTtgSfBJRcntf47INB9GNKHXdxF3VVoR7+ANz1Yky6dEIqim8IcybcAYf0z6x8rN19W2iJP/F8wewfixfvINYk3pxOdCtduSAzxqudpDLQMw0qtZqSVoaRkIIk2LYcQQy816M/3970n6PWlmPNIwhGHfnKnRIkmg3XsVktIS4zJMqLCEuErx3p/FvmlYzMd1hGvJ58r57aBdtnaWSZ4JqtA1k1+0wLVDt6BIJ3N5pLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgTSjuotx5OAydQiFIgVXtnNwk9gtuVfKleNV4zPH1s=;
 b=yR+/cUPrFnRVKB6o4c6F9IL1o31IN3a+2X1y613NQVzqt4NLGJp9qu33CyESYkB07uYhVHOApAaOifpXLvKgZ/z3RTmOYjmBcdvN9YnsVzmCzmL/I9VmixbNGEHbTieDs+0TF1Xm9NZqarPR7PSj4a2abl12J+zsMTn0KuiLkB7QRR5CiOdpSIsYr7CM6RAitTZSTOJGWAQeD6beGLeuZ/kaGtE9DPk+FD9XCtK78cNVB426CpAvyrLVl6iebeLGUPFMD9PEpba3KoYa2YCVqtIkZO1l/SSdVXJirL/ei3UYW6pIrgkJYGhyRryEAxTHZPtFWiDCXGR5gvcJJfBO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgTSjuotx5OAydQiFIgVXtnNwk9gtuVfKleNV4zPH1s=;
 b=MLMMRfENCtFzObVE7LPuBofiVRv1OrqkkSadhxf4CS2HRmfUgqCoSEpb620O3XHgB+LuX84vwv4ziYSFAWDA/hpdtSAq+QvfwPnyyT51A9X7VuGo4+tuPFFqaj2+TgPZvmXQ/T3kk9TxYco4ITXUwl4TekkZqjGY9dl/gq3qL110pJWQ0FS9gXN/vJcf5osfwb8+6nvLT5lkeuVaX6YqnGPzyepI3uMLIbUOlSW4NkUVw2EGHiY8Ng9PrQl8ZtHABJ5n5LLWZb5dMZtNfga5zg/qC9VGJyUhZNjly2/QUt6v2xL+7fjGKe8OLILvVVgeega2do3TdzzBnOE6a+qDNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:40 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 17/27] hw/misc: pfsoc: Model PolarFire SoC serial number
 service
Date: Sun,  4 Oct 2026 01:02:07 +0800
Message-ID: <20261003170232.2450916-18-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e118267-f1e0-423a-ed90-08df21704624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: kVrFgZ7PHweLQbZ0kFkZJ6M46BeVkeJPvpjwk6P2lkxLp3JcKATLhfhME7mmU7KnpftsxlFYL2EeUeIJvwh4w1TO3B9fPvxvDQyFoW9tP9WIbZd52icpYBFjEkc9wXC1M6yES1IMHv2G0XAMGRI+Vm9fqPAP73ZjBLzAt0L2xTmhrx2Ge/sYPEQ7MrsuupCKUYKqwPAxhnP/VIu8Hz/LUmu8TxJFDKqNNadlQ/K09N71TbzjHlODiNQSyHKbaKXbwOgGTHYWqoWkHy0TmuuocRgBRIq2jfLvvEl0zK2muYNkktTItxB+TdyTI0WMN011wLGB0LI61XMksBhaSKbGEQ4TDQ/C1Y7pmrGwTxkdQ4YYurm9rgUDgAqUG8fJvfLjU6cPBV8Ax9KX7n7UTubQzX/IQ2EnMiDbwW+pX4LiFfkyWIOQBp7mn3SXKNMYJgaPt9+l7sB86Ckiy+/Kjh7Uj73Il8AoJLxayRdVDGEC/J0NSGONQoyhmWR7Ypuns8m7hLNPl7z0rwt+XERzomAcWu2T5iiODnmyPfeRaiOF35w73MoRRzqI6ikj93NDVjPlVVOqPj9DValuFzNpDK0x5JRXTC0C3r2IFWoBjlgrhAINKQKqhEjTH/ZEMpVHYXvu0cyzp3H86RftW5Trzg4tCjnSVG4kz/wJPoGz0oF1/T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVocG1UVTJ5c3p1TXFTc3BWVDlNb003eElCYll1d2ZmcFZZS1hXMUxWWDJw?=
 =?utf-8?B?Y3FtRndRVGNpQlBld2lJZGRmTVhwaWJwcFlPTXdjYVlJMUthZkMyeFVEb2lo?=
 =?utf-8?B?RWJoby91eHE4UW5UUSs1WjNBdGk0R1RJUEFPV004WFE3VkJucjhuT1gvWURX?=
 =?utf-8?B?MkVjRGtHR3kvVU44L2JJNXlaL3NqeHk5bHltV1F6ZjZrUkdSelNMeXgzK2No?=
 =?utf-8?B?czAyVnFsVzhERXpUSkJDVUlQdkYrbzBFNG51aVVSb1ROeUFaaWZ0MjVOV0dY?=
 =?utf-8?B?eFdBWWJVVG5mM0VtUm8xN0EyNVk3MzZnSW1MR3VHVWYydGhuOE52N2ppc2Ez?=
 =?utf-8?B?RDFaRWZTRmpHajJkalpNMUlGMzhYVWhNM1BOQW5LU1k3azVJOU51WG1KVEw1?=
 =?utf-8?B?YTErNVVhamhLR0dWdGlkUzFjc0RZU3FRTzM3dFp4bHNwdGlDMEdJQy9hcHlP?=
 =?utf-8?B?QlBCbzBLMkE1VVA3dUU3TTdnSUx6M0JFbWhNK3JPOWx3RHp3TWY4NGQzZzd6?=
 =?utf-8?B?anRtSTBjdHJneW42NHVZZ2hxSnJrWTVEYUUrcnBvbWVzdFdNdThrc3p2YVIw?=
 =?utf-8?B?NFN3ZGdqeElqa0szcE8zU2lQbnNZWWVNQ2E1NHA1Q3VZcG5vSkV6VTF4M0lG?=
 =?utf-8?B?TWNQYUVnTlhoMXhhaXlPa1ZQL2tDR2FGV1RNMFJVN0EvQVg0N2ZwZ3FOT3pQ?=
 =?utf-8?B?R2s0YlUzTGZSNy9pOHBWWmNnalNmdGM2OGF0Vm1INUUzRkZVeGdLWHVQTlZR?=
 =?utf-8?B?YlplQS9nejlGdlFzT2xwc0ZlczNmSW1zTmVUL1p6U25IRzRaamhqdEJhbzl2?=
 =?utf-8?B?d0ZTU1JpM3V0UWpWanEweFE5UXdreWdTRml1MjJhbTdnNzkzc3UvT3o4ZmNw?=
 =?utf-8?B?RFhaTE8xTUl1SWF4Z2NhNmVONnpLeHVJTXhNaGlId1NPNzJ3bWR0RW9jMEIv?=
 =?utf-8?B?TWZDL1dTYnF4Zjd4WjhnU3Z6OExLWU5PaXp0UXdtNU0waWI4VFZ2ZVM0Vk5i?=
 =?utf-8?B?enhZWGVrVkJoSGpvOStzT0RWaU84bXVoSWE1aVVMZ0c5cldBK0dpUDFRM0pP?=
 =?utf-8?B?ZWJlZ3lQQ2V2eThFYjVCUFV3bERMRlF6K21NVEd2SHNOalE3OWY0cXk0anZC?=
 =?utf-8?B?cC9lSnNwY0dxZXVEbnNZZjVxdDAyS0xjS0xMaWlIUTBoN2RHM0hRUHdsbHFo?=
 =?utf-8?B?L1VDRG96eXBGSEIvZ3E0T3NIaWd3QUFGcnBBTysrVHh2Ym5pTXUyVFVRTXMv?=
 =?utf-8?B?RFJhNy9EZjFINDc4alpvbnQxVXNTbzlXdExmQmtJWkVDYWN3NU5YbmtseUdu?=
 =?utf-8?B?OURRNVFmZktIVWZ3c3Y0SWEzU0IvRUlGOTAvOVNYRzBTeXM5ckRFdzVGd2RM?=
 =?utf-8?B?Q0FnY2VJNEIvREYxK3J0UUNmUW81Sm93YWQ5ek1sd3IrNGZSdTVnTHYxeVhY?=
 =?utf-8?B?Z3lmU2ROSklFUXBBSm5rUkxucThQRXZRVUZFOXVsM1NCUXBaeS9EV1UyUHkx?=
 =?utf-8?B?NUlTNTlQVnVpRFp6TFRvK05LUHNrTkZhVkk4WThxck8zb0doQU0rZjhxNGN1?=
 =?utf-8?B?RzNIVW9qSytuVEVSMzh3K05tUmtZK3NjUjVERFAzeWVmSENWUWhZcUZpdGhF?=
 =?utf-8?B?RE1LN1UzNjBaZVBjODc5cDgxSW1XbjdCWUtVMkJtWlZ2bE9QU1laNDJZWmo3?=
 =?utf-8?B?bnpVOEtIY3B1SU00TENIN0x4Skp3ZlV4OGg5ZUZLUHNGeHFlOEZIaEx3NzJJ?=
 =?utf-8?B?NWNvNS9wTUFxNTFtaUZnR3dGRGpNdlhjQm9wOXFFZ0VTMTd2eGFhbmRMMGd0?=
 =?utf-8?B?ZVlVT2hMNlc2MXVpYTNGbmVqZ0dTZEFFcUxjdlh2WE90RWR1ajM1dUFBcTF0?=
 =?utf-8?B?Y1N3Q2VpK1BWYnRiRjlxWm5SeTZRQXJzbzJYVW52a0xVZG5Sa1hjQWxudjlF?=
 =?utf-8?B?dVM2bGNmMzA1d0VleW1Cb1ZLRzJSRUE4K2FWUFQwSlpxT0l4bDkrNC9ablZs?=
 =?utf-8?B?QWYxSUp6dnovWTV5VVl6OGRlSWFNNHZNcEpsRkErNUI2WGR2cGV3VVRlT2pt?=
 =?utf-8?B?NEk4T3VWajQ5Y3dUc2pacHh3bVFxQ3ROTGhsNnppWWFWT3dodTd1SUJIRHNS?=
 =?utf-8?B?ekFvU3hkVGp6bWRTL2pUQ3BzQWJpTm1xL2hudldOZC9TaGF2VjB6WGFCZVJX?=
 =?utf-8?B?bHBQVnJrUVFJTlFqeHRPSXZBd3VNakhKY1ozcEVVdmc4V2VGaXlRMmxoeVkv?=
 =?utf-8?B?QS9hN1lzdXBDSVNZM1FhblJQNmtWdFBSUm5pZDdwdUJTY1pSdWRNM0F6THo4?=
 =?utf-8?B?c1lrcDlkOEZpbmZSR1dwYnYzLzhlVjlEcC96L25tQUtjMW4wRDVWbC9JSC95?=
 =?utf-8?Q?NBeBz4/Vujwb0rQk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e118267-f1e0-423a-ed90-08df21704624
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:40.8011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAk61ymRCJOuvA5qpTL4pj8S4lz2D7RNEgPPa2Wm0P2TD86NPClEOAEScuWKCwYM6zN2JJMtr4aJNOCUjUvWNkPkZooR4TvdNpZxz/EUo0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
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

U-Boot requests the PolarFire SoC device serial number during board
late initialization. The IOSCB previously rejected every request, so
board setup could not complete.

Model the System Services control registers and byte-addressable
mailbox. Obtain the 128-bit serial number from an optional device
property, using a deterministic value when it is not configured.
Return an explicit failure for unsupported services and reset the
new runtime state with the rest of the device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

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


