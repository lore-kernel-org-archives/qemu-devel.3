Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76B9CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcXP-0002SE-7N; Sun, 31 May 2026 05:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcXK-0002OC-W1
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:51 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcXI-0000Eq-2E
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlKtg+V7KOFV1EfSIPMHB+N1iGtZ8hQyFxkm+P6/2eMxDkv8VitvBlhblMjFBZBSxVnhLEMOREnYQ5wcI+aYfkoueDeAuzaqc6dXx3TDzhW/lxNAjvTderuFFqiUoonxqCl0NmwJ2hkrsF3/HawTN8wnB/ZpAsh4rQmzYEsCs6AMIn6MVHLsh+MX1LV/vtC2cYtiuomYlVEgyAmxTXKtAlwtmjDbsxmCp5M+80jUSiZxrK8NkuitR8uSFXmRRitemoButkRFPRDvgV5VjEwUuqo2RvFshK0kzxKNMw9HpHUjuW8Fr3T+S1wq4OapofRcfhgaiUWvpPLY4jp5uUL+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHJf9r6xp+H6jYi5fu8rsVg3OCVdJ6mVVz8WoMz4OjE=;
 b=juuwn11tvIfvrWuEiv5lxCZJ/bQCKvyrcjcF/jHj6G5MVYTxpM24zO2bGjIuf4cpiW/5oC4D1ZJ5V9bnOpljvWErw+yUx/HLF9mJS7awXY5rmuV9/fgAyvoAp5M6EVd7COfLUEl6MtrAh+hfVCBXpL6rRvzxonRT4P+49Iia+9XZgVfRxZMn1ANOtpzrRsK0+kpDn4iw3ZR6IdxWAcNyh5wLELXqV0SakMV2/jQhWnN63WqFAe7XddtfwlwYR+oIa9bvU+m+x0h1piy6LQFSfvyEKjv49urFvAmSYMr5oll0T0Ihb2OXXUtSJSLCF4qFiFzOEo+vIw2D1hsJklFibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:55 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:55 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:01:01 +0530
Subject: [PATCH 10/10] hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB
 machine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-10-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com, 
 Andreas Konopik <andreas.konopik@efs-auto.de>, 
 David Brenken <david.brenken@efs-auto.de>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb3e04e-cce6-4c04-f275-08debef77478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: X7GhuVVrS2ItU0n7Qd8WGVlu80Zx0ewa954pKmUQErAGhvePpE8BZwK2ZlbggQIg3htnpGsSunMt8/xjNjL87tVAY5mAysGq9ZiZ7CXeznIKC75sh3E0PT2/r5ipSjIe/TWl9lyCm+Uhyd3ikqEuwI/ZmsrsPTzbSirZctuOAatD1ncjRiY1xVZpfWVH0lsl1bGp0DLqOeJqiKvXxF1SDYGQ/DldIPLJaj43Vnk0rJlQHuCT2wQPGsvzSmxscaTpYcFxPAxPSRujhNB4R6pVPsVNFXXDHQg1JUe5BrcJ1SKgu2W+XMeG8NR3h1sv0+a5OdrAaZ0TM6HIB4lvVVKjtXSeqpKBuhwGnu1UJia/7BMB4T0Z1+vCWps7jRI0aagkmKXbP8UdUk+0OmOTH2mavbCEr9DKOcvQMq6KpjiM7te40p9nB4XZdHjIxC+Up/oEFywJWvEpp2HX/RFB/CyS7whsvKPCuh3ps7sWIDjPl2VlJ76cf4aeseHrFTVvmapqfGi4kDlbyiwtcYdSAv3bnU5kD20jd2WIU+vF6P9XQyvaXPCIoNBA0mq/iXTeF2dotGynHGmfG+66OmDBXJPEJAWyKTNs/6muA3MvRim5cnlNWuOMAAI0+xq7M52/XLjoTmkbMGY4bwz59HepGS/2EYMSjbOvENfrUkzqUWY+O220tGnVJZL4qZ5x9wj0fpSSPs75rFgoOk2KSq3OPF7rzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUs2N2dtOGNUeWd5U2dpR3VrZlExWlRiMGdCVXFTTHF6Z1Y3V1FBWE5wVW5N?=
 =?utf-8?B?Mzh3aFZJS3l6K0IwT0t5RlF4OERObHNQR2xmaUhKMkJFZTlaN0lsYTRoUVlY?=
 =?utf-8?B?bkUwY05wZUNTSUtMVXMzRjZCcVY2SDM3WG5HbVNqSjRENU4xR3FQNXBxZkdI?=
 =?utf-8?B?QXZJaWJPdzhKeE1Bai9iU2xvVGNPSm9iY1lXbU1reWo4Z0JBaGxRUTdWZldW?=
 =?utf-8?B?Zy9RZVRkYlBnTDlkNFYvME9QYlZrRUNHOHI1cTY2S1o3RGd5OWZ1Tkw1a2Vh?=
 =?utf-8?B?Zmc2SVpQeG1TUnJoMTBHU0puYVVvaVVWeS9RWTF3eWpMNmJ5dEpDZFpOTzdz?=
 =?utf-8?B?N1hEZWNBRGdmcE1sQmFmTldnaEtZWVR6aTd3ZS80VVpYSTRHL3IvdmhDTFdj?=
 =?utf-8?B?ZGR3VEUxeFN5MGpNaDFiTUtrNHZTYno3UVNjM3pWOFpLZk13ZFE0QS9hdUhJ?=
 =?utf-8?B?dlNXU2x1UnJ3RFI1MnE1SGVZZkl5UlBnaXI2aUFtai9UbkEyeG5zNG1pQ1Rx?=
 =?utf-8?B?amdGeTlTc2N6Qitad0Y2OHMvYzJQTTRpU3JhUG9XQmpNSm9xRy9sT1JwL1hR?=
 =?utf-8?B?OU5BRERQSkNKK2ZDY3lRMHRiT1lWa2ZNbVNCWjB5QlRQbGEyWWtldTZBUUNm?=
 =?utf-8?B?NitNYm1pd0dsZ3MzQTdIZlBac0FKdm9rcmlaZUFDVmJyN3dGM3ZEbE5WTENu?=
 =?utf-8?B?VGtoTzZVWW1Kcmk0Zms1SzFQT01qQklEa0lRV0tpdlh1WndWa0hPcWdYY0dK?=
 =?utf-8?B?V3FUZG1sUlhycTh5TEVBV3J5RlBPMVE3TEUxa1A1NXlpc0x5SkpBRndqY0oz?=
 =?utf-8?B?VE1RNnVDTXBhblpCRWR0L0M5UWJYVTUwRVBLbURyNWwvRTF3aWJLR0VyUkZJ?=
 =?utf-8?B?Y3ExTURUQ29KZ1N2WHFaOWx0VHk1NkJnQTZLSmVqNGVyckk3LzdUU291Z0FD?=
 =?utf-8?B?ZFBsb2h1eWR6RDRKYWN1WjgwQmROUkErNXEvSml0L3BQOVpEMjNhck51Y1Iw?=
 =?utf-8?B?SUVYbXNnNDZ3SStkUzJiOGYwaithVGlsMWZ4SkNKVmg1Y1Q4VUZneUtsT1R0?=
 =?utf-8?B?Q0dSYmJpQzBIMXVEaUhwLzFYNzlwWXJOVk0xWVNrSGdYWUFrMkJ0L2ViaXBa?=
 =?utf-8?B?b3R2NnVWUzdLZVpxUXJuYlJxNmlMYUJtb2N5Q3NSNzJMM2JDVHpHZzdLMDBZ?=
 =?utf-8?B?QXhOMHhpL1cxOWpOdGptUllWckl6REdDZ2VqU28xT1BDK3Uwb0ZaWVcxbGZC?=
 =?utf-8?B?eVFibmlwdmE3MW9VdE9yTjdmcmY3NjlLeVpaN04ySWZNeTdlZjU2T09YaFV3?=
 =?utf-8?B?UFM3ZnNybS9iZmh5eGZEdFZUU3VFZmsvQjJUd29yVk1kQ3psVE0zdlZTOGlS?=
 =?utf-8?B?VjNoQXBwVlZDREl1ZnpQcndvVEROdjJ0aUNraE5SaHR3dnlWRG4rTGNkd01L?=
 =?utf-8?B?SlNVaWJ1SjVWL3VJS1RQdTAwZUk0bFhrMXVrditVWnpaUEdxVDZ2TENwKzVX?=
 =?utf-8?B?VzJVY1VXZEFsOWFnMVVjT3pLZGlNT2VCdzdWY256RHU5ZE94eFNiNWJOVU9N?=
 =?utf-8?B?aVh0eXBjSGcrZC9RN2Vlb1ExQmNLWFVMZ2FEd29tamVUbmluNC9yZXpZNFlY?=
 =?utf-8?B?bHYwSjJGMXI3QWV5Z3BKbDZxQkdxUmxpVi9HZlNReTVaOWhudlh1T3dUSG00?=
 =?utf-8?B?Z0thVGdxRVYvTVJJQUxHQ2Q2alQxUUpPQ092bXByTjJ3Z1ROSXpkQ2x1dXd5?=
 =?utf-8?B?L1BteTlzODZXUjU5RmFaNXlzTHd4Q3ZiT1c0QjVvQ0lxR0VLWjZyb1RaSWdm?=
 =?utf-8?B?b2ZGUG5Wb1cwZWdmK0pzVkxaS1h0QXdIdmw5RkNyaDV5cmNnZ3dqN3JTT1Nv?=
 =?utf-8?B?RG81S2VrSTJPR2hyL2xralFuN2ZiTWFzWm5iZWVuV212MFVuR1dqWGVYekll?=
 =?utf-8?B?cDExc2F0WGlJZS9SSktTOGhueFYvenRMbUJDdzJiM2hDdWhRWXFEV2N2cFZ5?=
 =?utf-8?B?dThHUHVPcjV6RFRic0NmSUVnTzBiOEhYWXJtWWtIQjIvVHkyUnc2anlsdi9z?=
 =?utf-8?B?OG1VaVRrRkI3WW9TakNCdFR0d1FTbnJEeXpySE1uNkcyZk5Wc0xvSEVzYmMy?=
 =?utf-8?B?R1UzWGU4Ni8xYzJGZ3N6Wi9UaDlHWDY3ZVp2REJDVldkRkh1eTBteXNsOEdr?=
 =?utf-8?B?UnRHZXMvYlRNeHIrbXF1UmpFT1V6UklJNkN3R1NBWm5jK2dER0FOa1JmL09v?=
 =?utf-8?B?eWtCa2pHb0RGcHlYeFZhZHpINEd1MnRZb1ZPQXkwZnEranJlTnhLbis1Y0dt?=
 =?utf-8?B?WUhRcy9nME1mdDFFa1BMZWx3YUx4Zmx2NTJRU3lpbStBUEJPTnNGUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb3e04e-cce6-4c04-f275-08debef77478
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:55.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSG/aSjQ3A5fJ0Wn28xiek2p4mSu2P5XD34N7zZMNDOiZx/PsG+QNHpsvDdR4MZtrEGCjDVsCGc4rUWSWTrEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TC39x SoC with the TC397B memory map: 6x 240K DSPR, 6x 64K PSPR,
6 flash banks, DLMU, LMU, 4M EMEM.  Only CPU0 runs.  Same
peripheral wiring pattern as tc27x.

Originally-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Originally-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/tc39xb_soc.c         | 366 ++++++++++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c           |  32 +++-
 include/hw/tricore/tc39xb_soc.h | 115 +++++++++++++
 include/hw/tricore/triboard.h   |   2 +
 4 files changed, 514 insertions(+), 1 deletion(-)

diff --git a/hw/tricore/tc39xb_soc.c b/hw/tricore/tc39xb_soc.c
new file mode 100644
index 0000000000..f1d696efff
--- /dev/null
+++ b/hw/tricore/tc39xb_soc.c
@@ -0,0 +1,366 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Infineon TC39x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/loader.h"
+#include "qemu/units.h"
+#include "hw/misc/unimp.h"
+#include "system/system.h"
+
+#include "hw/tricore/tc39xb_soc.h"
+#include "hw/tricore/tc27x_soc.h"
+
+const MemmapEntry tc39xb_soc_memmap[] = {
+    [TC39XB_DSPR5]     = { 0x10000000,            240 * KiB },
+    [TC39XB_DCACHE5]   = { 0x10018000,             16 * KiB },
+    [TC39XB_DTAG5]     = { 0x100C0000,              6 * KiB },
+    [TC39XB_PSPR5]     = { 0x10100000,             64 * KiB },
+    [TC39XB_PCACHE5]   = { 0x10108000,             32 * KiB },
+    [TC39XB_PTAG5]     = { 0x101C0000,             12 * KiB },
+    [TC39XB_DSPR4]     = { 0x30000000,            240 * KiB },
+    [TC39XB_DCACHE4]   = { 0x30018000,             16 * KiB },
+    [TC39XB_DTAG4]     = { 0x300C0000,              6 * KiB },
+    [TC39XB_PSPR4]     = { 0x30100000,             64 * KiB },
+    [TC39XB_PCACHE4]   = { 0x30108000,             32 * KiB },
+    [TC39XB_PTAG4]     = { 0x301C0000,             12 * KiB },
+    [TC39XB_DSPR3]     = { 0x40000000,            240 * KiB },
+    [TC39XB_DCACHE3]   = { 0x40018000,             16 * KiB },
+    [TC39XB_DTAG3]     = { 0x400C0000,              6 * KiB },
+    [TC39XB_PSPR3]     = { 0x40100000,             64 * KiB },
+    [TC39XB_PCACHE3]   = { 0x40108000,             32 * KiB },
+    [TC39XB_PTAG3]     = { 0x401C0000,             12 * KiB },
+    [TC39XB_DSPR2]     = { 0x50000000,            240 * KiB },
+    [TC39XB_DCACHE2]   = { 0x5001E000,             16 * KiB },
+    [TC39XB_DTAG2]     = { 0x500C0000,              6 * KiB },
+    [TC39XB_PSPR2]     = { 0x50100000,             64 * KiB },
+    [TC39XB_PCACHE2]   = { 0x50108000,             32 * KiB },
+    [TC39XB_PTAG2]     = { 0x501C0000,             12 * KiB },
+    [TC39XB_DSPR1]     = { 0x60000000,            240 * KiB },
+    [TC39XB_DCACHE1]   = { 0x6001E000,             16 * KiB },
+    [TC39XB_DTAG1]     = { 0x600C0000,              6 * KiB },
+    [TC39XB_PSPR1]     = { 0x60100000,             64 * KiB },
+    [TC39XB_PCACHE1]   = { 0x60108000,             32 * KiB },
+    [TC39XB_PTAG1]     = { 0x601C0000,             12 * KiB },
+    [TC39XB_DSPR0]     = { 0x70000000,            240 * KiB },
+    [TC39XB_DCACHE0]   = { 0x7001E000,             16 * KiB },
+    [TC39XB_DTAG0]     = { 0x700C0000,              6 * KiB },
+    [TC39XB_PSPR0]     = { 0x70100000,             64 * KiB },
+    [TC39XB_PCACHE0]   = { 0x70108000,             32 * KiB },
+    [TC39XB_PTAG0]     = { 0x701C0000,             12 * KiB },
+    [TC39XB_PFLASH0_C] = { 0x80000000,              3 * MiB },
+    [TC39XB_PFLASH1_C] = { 0x80300000,              3 * MiB },
+    [TC39XB_PFLASH2_C] = { 0x80600000,              3 * MiB },
+    [TC39XB_PFLASH3_C] = { 0x80900000,              3 * MiB },
+    [TC39XB_PFLASH4_C] = { 0x80C00000,              3 * MiB },
+    [TC39XB_PFLASH5_C] = { 0x80F00000,              1 * MiB },
+    [TC39XB_OLDA_C]    = { 0x8FE00000,            512 * KiB },
+    [TC39XB_BROM_C]    = { 0x8FFF0000,             64 * KiB },
+    [TC39XB_DLMU0_C]   = { 0x90000000,             64 * KiB },
+    [TC39XB_DLMU1_C]   = { 0x90010000,             64 * KiB },
+    [TC39XB_DLMU2_C]   = { 0x90020000,             64 * KiB },
+    [TC39XB_DLMU3_C]   = { 0x90030000,             64 * KiB },
+    [TC39XB_LMU0_C]    = { 0x90040000,            256 * KiB },
+    [TC39XB_LMU1_C]    = { 0x90080000,            256 * KiB },
+    [TC39XB_LMU2_C]    = { 0x900C0000,            256 * KiB },
+    [TC39XB_DLMU4_C]   = { 0x90100000,             64 * KiB },
+    [TC39XB_DLMU5_C]   = { 0x90110000,             64 * KiB },
+    [TC39XB_EMEM]      = { 0x99000000,              4 * MiB },
+    [TC39XB_PFLASH0_U] = { 0xA0000000,                  0x0 },
+    [TC39XB_PFLASH1_U] = { 0xA0300000,                  0x0 },
+    [TC39XB_PFLASH2_U] = { 0xA0600000,                  0x0 },
+    [TC39XB_PFLASH3_U] = { 0xA0900000,                  0x0 },
+    [TC39XB_PFLASH4_U] = { 0xA0C00000,                  0x0 },
+    [TC39XB_PFLASH5_U] = { 0xA0F00000,                  0x0 },
+    [TC39XB_DFLASH0]   = { 0xAF000000,              1 * MiB },
+    [TC39XB_DFLASH1]   = { 0xAFC00000,            128 * KiB },
+    [TC39XB_OLDA_U]    = { 0xAFE00000,                  0x0 },
+    [TC39XB_BROM_U]    = { 0xAFFF0000,                  0x0 },
+    [TC39XB_DLMU0_U]   = { 0xB0000000,                  0x0 },
+    [TC39XB_DLMU1_U]   = { 0xB0010000,                  0x0 },
+    [TC39XB_DLMU2_U]   = { 0xB0020000,                  0x0 },
+    [TC39XB_DLMU3_U]   = { 0xB0030000,                  0x0 },
+    [TC39XB_LMU0_U]    = { 0xB0040000,                  0x0 },
+    [TC39XB_LMU1_U]    = { 0xB0080000,                  0x0 },
+    [TC39XB_LMU2_U]    = { 0xB00C0000,                  0x0 },
+    [TC39XB_DLMU4_U]   = { 0xB0100000,                  0x0 },
+    [TC39XB_DLMU5_U]   = { 0xB0110000,                  0x0 },
+    [TC39XB_PSPRX]     = { 0xC0000000,                  0x0 },
+    [TC39XB_DSPRX]     = { 0xD0000000,                  0x0 },
+    [TC39XB_IR_INT]    = { 0xF0037000,                  0x0 },
+    [TC39XB_IR_SRC]    = { 0xF0038000,                  0x0 },
+    [TC39XB_STM0]      = { 0xF0001000,                  0x0 },
+    [TC39XB_ASCLIN0]   = { 0xF0000600,                  0x0 },
+    [TC39XB_SCU]       = { 0xF0036000,                  0x0 },
+};
+
+static void make_rom(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void make_ram(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void make_alias(MemoryRegion *mr, const char *name,
+                       MemoryRegion *orig, hwaddr base)
+{
+    memory_region_init_alias(mr, NULL, name, orig, 0,
+                             memory_region_size(orig));
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void tc39xb_soc_init_memory_mapping(DeviceState *dev_soc)
+{
+    TC39XBSoCState *s = TC39XB_SOC(dev_soc);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+    const MemmapEntry *map = sc->memmap;
+    TC39XBSoCCPUMemState *c0 = &s->cpu0mem;
+    TC39XBSoCCPUMemState *c1 = &s->cpu1mem;
+    TC39XBSoCCPUMemState *c2 = &s->cpu2mem;
+    TC39XBSoCCPUMemState *c3 = &s->cpu3mem;
+    TC39XBSoCCPUMemState *c4 = &s->cpu4mem;
+    TC39XBSoCCPUMemState *c5 = &s->cpu5mem;
+    TC39XBSoCFlashMemState *f = &s->flashmem;
+
+    /* CPU scratch-pad memories */
+    make_ram(&c0->dspr, "CPU0.DSPR",
+             map[TC39XB_DSPR0].base, map[TC39XB_DSPR0].size);
+    make_ram(&c0->pspr, "CPU0.PSPR",
+             map[TC39XB_PSPR0].base, map[TC39XB_PSPR0].size);
+    make_ram(&c1->dspr, "CPU1.DSPR",
+             map[TC39XB_DSPR1].base, map[TC39XB_DSPR1].size);
+    make_ram(&c1->pspr, "CPU1.PSPR",
+             map[TC39XB_PSPR1].base, map[TC39XB_PSPR1].size);
+    make_ram(&c2->dspr, "CPU2.DSPR",
+             map[TC39XB_DSPR2].base, map[TC39XB_DSPR2].size);
+    make_ram(&c2->pspr, "CPU2.PSPR",
+             map[TC39XB_PSPR2].base, map[TC39XB_PSPR2].size);
+    make_ram(&c3->dspr, "CPU3.DSPR",
+             map[TC39XB_DSPR3].base, map[TC39XB_DSPR3].size);
+    make_ram(&c3->pspr, "CPU3.PSPR",
+             map[TC39XB_PSPR3].base, map[TC39XB_PSPR3].size);
+    make_ram(&c4->dspr, "CPU4.DSPR",
+             map[TC39XB_DSPR4].base, map[TC39XB_DSPR4].size);
+    make_ram(&c4->pspr, "CPU4.PSPR",
+             map[TC39XB_PSPR4].base, map[TC39XB_PSPR4].size);
+    make_ram(&c5->dspr, "CPU5.DSPR",
+             map[TC39XB_DSPR5].base, map[TC39XB_DSPR5].size);
+    make_ram(&c5->pspr, "CPU5.PSPR",
+             map[TC39XB_PSPR5].base, map[TC39XB_PSPR5].size);
+
+    /*
+     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
+     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
+     */
+    make_alias(&s->psprX, "LOCAL.PSPR",
+               &c0->pspr, map[TC39XB_PSPRX].base);
+    make_alias(&s->dsprX, "LOCAL.DSPR",
+               &c0->dspr, map[TC39XB_DSPRX].base);
+
+    /* Program flash (6 banks) */
+    make_ram(&c0->pflash_c, "PF0",
+             map[TC39XB_PFLASH0_C].base, map[TC39XB_PFLASH0_C].size);
+    make_ram(&c1->pflash_c, "PF1",
+             map[TC39XB_PFLASH1_C].base, map[TC39XB_PFLASH1_C].size);
+    make_ram(&c2->pflash_c, "PF2",
+             map[TC39XB_PFLASH2_C].base, map[TC39XB_PFLASH2_C].size);
+    make_ram(&c3->pflash_c, "PF3",
+             map[TC39XB_PFLASH3_C].base, map[TC39XB_PFLASH3_C].size);
+    make_ram(&c4->pflash_c, "PF4",
+             map[TC39XB_PFLASH4_C].base, map[TC39XB_PFLASH4_C].size);
+    make_ram(&c5->pflash_c, "PF5",
+             map[TC39XB_PFLASH5_C].base, map[TC39XB_PFLASH5_C].size);
+
+    /* DLMU (per-CPU local memory) */
+    make_ram(&c0->dlmu_c, "DLMU0",
+             map[TC39XB_DLMU0_C].base, map[TC39XB_DLMU0_C].size);
+    make_ram(&c1->dlmu_c, "DLMU1",
+             map[TC39XB_DLMU1_C].base, map[TC39XB_DLMU1_C].size);
+    make_ram(&c2->dlmu_c, "DLMU2",
+             map[TC39XB_DLMU2_C].base, map[TC39XB_DLMU2_C].size);
+    make_ram(&c3->dlmu_c, "DLMU3",
+             map[TC39XB_DLMU3_C].base, map[TC39XB_DLMU3_C].size);
+    make_ram(&c4->dlmu_c, "DLMU4",
+             map[TC39XB_DLMU4_C].base, map[TC39XB_DLMU4_C].size);
+    make_ram(&c5->dlmu_c, "DLMU5",
+             map[TC39XB_DLMU5_C].base, map[TC39XB_DLMU5_C].size);
+
+    /* Shared memories */
+    make_ram(&f->dflash0, "DF0",
+             map[TC39XB_DFLASH0].base, map[TC39XB_DFLASH0].size);
+    make_ram(&f->dflash1, "DF1",
+             map[TC39XB_DFLASH1].base, map[TC39XB_DFLASH1].size);
+    make_ram(&f->olda_c, "OLDA",
+             map[TC39XB_OLDA_C].base, map[TC39XB_OLDA_C].size);
+    make_rom(&f->brom_c, "BROM",
+             map[TC39XB_BROM_C].base, map[TC39XB_BROM_C].size);
+    make_ram(&f->lmu0_c, "LMU0",
+             map[TC39XB_LMU0_C].base, map[TC39XB_LMU0_C].size);
+    make_ram(&f->lmu1_c, "LMU1",
+             map[TC39XB_LMU1_C].base, map[TC39XB_LMU1_C].size);
+    make_ram(&f->lmu2_c, "LMU2",
+             map[TC39XB_LMU2_C].base, map[TC39XB_LMU2_C].size);
+    make_ram(&f->emem, "EMEM",
+             map[TC39XB_EMEM].base, map[TC39XB_EMEM].size);
+
+    /* Uncached aliases for program flash */
+    make_alias(&c0->pflash_u, "PF0.U",
+               &c0->pflash_c, map[TC39XB_PFLASH0_U].base);
+    make_alias(&c1->pflash_u, "PF1.U",
+               &c1->pflash_c, map[TC39XB_PFLASH1_U].base);
+    make_alias(&c2->pflash_u, "PF2.U",
+               &c2->pflash_c, map[TC39XB_PFLASH2_U].base);
+    make_alias(&c3->pflash_u, "PF3.U",
+               &c3->pflash_c, map[TC39XB_PFLASH3_U].base);
+    make_alias(&c4->pflash_u, "PF4.U",
+               &c4->pflash_c, map[TC39XB_PFLASH4_U].base);
+    make_alias(&c5->pflash_u, "PF5.U",
+               &c5->pflash_c, map[TC39XB_PFLASH5_U].base);
+
+    /* Uncached aliases for DLMU */
+    make_alias(&c0->dlmu_u, "DLMU0.U",
+               &c0->dlmu_c, map[TC39XB_DLMU0_U].base);
+    make_alias(&c1->dlmu_u, "DLMU1.U",
+               &c1->dlmu_c, map[TC39XB_DLMU1_U].base);
+    make_alias(&c2->dlmu_u, "DLMU2.U",
+               &c2->dlmu_c, map[TC39XB_DLMU2_U].base);
+    make_alias(&c3->dlmu_u, "DLMU3.U",
+               &c3->dlmu_c, map[TC39XB_DLMU3_U].base);
+    make_alias(&c4->dlmu_u, "DLMU4.U",
+               &c4->dlmu_c, map[TC39XB_DLMU4_U].base);
+    make_alias(&c5->dlmu_u, "DLMU5.U",
+               &c5->dlmu_c, map[TC39XB_DLMU5_U].base);
+
+    /* Uncached aliases for shared memories */
+    make_alias(&f->olda_u, "OLDA.U",
+               &f->olda_c, map[TC39XB_OLDA_U].base);
+    make_alias(&f->brom_u, "BROM.U",
+               &f->brom_c, map[TC39XB_BROM_U].base);
+    make_alias(&f->lmu0_u, "LMU0.U",
+               &f->lmu0_c, map[TC39XB_LMU0_U].base);
+    make_alias(&f->lmu1_u, "LMU1.U",
+               &f->lmu1_c, map[TC39XB_LMU1_U].base);
+    make_alias(&f->lmu2_u, "LMU2.U",
+               &f->lmu2_c, map[TC39XB_LMU2_U].base);
+}
+
+/* TC39x interrupt source indices */
+#define TC39X_SRC_STM0_SR0      0xC0
+#define TC39X_SRC_ASCLIN0_TX    0x14
+#define TC39X_SRC_ASCLIN0_RX    0x15
+#define TC39X_SRC_ASCLIN0_ERR   0x16
+
+static void tc39xb_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    TC39XBSoCState *s = TC39XB_SOC(dev_soc);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+    Clock *fstm;
+    Error *err = NULL;
+
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    tc39xb_soc_init_memory_mapping(dev_soc);
+
+    /* STM clock: 50 MHz */
+    fstm = clock_new(OBJECT(dev_soc), "fstm");
+    clock_set_hz(fstm, 50000000);
+    qdev_connect_clock_in(DEVICE(&s->stm), "fstm", fstm);
+
+    qdev_prop_set_chr(DEVICE(&s->asclin), "chardev", serial_hd(0));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->ir), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->stm), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->asclin), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ir), 0,
+                    sc->memmap[TC39XB_IR_INT].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ir), 1,
+                    sc->memmap[TC39XB_IR_SRC].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->stm), 0,
+                    sc->memmap[TC39XB_STM0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->asclin), 0,
+                    sc->memmap[TC39XB_ASCLIN0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[TC39XB_SCU].base);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC39X_SRC_ASCLIN0_RX));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 1,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC39X_SRC_ASCLIN0_TX));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 2,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC39X_SRC_ASCLIN0_ERR));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->stm), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC39X_SRC_STM0_SR0));
+}
+
+static void tc39xb_soc_init(Object *obj)
+{
+    TC39XBSoCState *s = TC39XB_SOC(obj);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+
+    object_initialize_child(obj, "tc39x", &s->cpu, sc->cpu_type);
+    object_initialize_child(obj, "ir", &s->ir, TYPE_TRICORE_IR);
+    object_initialize_child(obj, "stm", &s->stm, TYPE_TRICORE_STM);
+    object_initialize_child(obj, "asclin", &s->asclin, TYPE_TRICORE_ASCLIN);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_TRICORE_SCU);
+}
+
+static void tc39xb_soc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = tc39xb_soc_realize;
+}
+
+static void tc397b_soc_class_init(ObjectClass *oc, const void *data)
+{
+    TC39XBSoCClass *sc = TC39XB_SOC_CLASS(oc);
+
+    sc->name     = "tc397b-soc";
+    sc->cpu_type = TRICORE_CPU_TYPE_NAME("tc39x");
+    sc->memmap   = tc39xb_soc_memmap;
+    sc->num_cpus = 1;
+}
+
+static const TypeInfo tc39xb_soc_types[] = {
+    {
+        .name          = "tc397b-soc",
+        .parent        = TYPE_TC39XB_SOC,
+        .class_init    = tc397b_soc_class_init,
+    }, {
+        .name          = TYPE_TC39XB_SOC,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(TC39XBSoCState),
+        .instance_init = tc39xb_soc_init,
+        .class_size    = sizeof(TC39XBSoCClass),
+        .class_init    = tc39xb_soc_class_init,
+        .abstract      = true,
+    },
+};
+
+DEFINE_TYPES(tc39xb_soc_types)
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 23f11cf0a1..c16a6bc8f7 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -64,6 +64,20 @@ static void triboard_machine_init(MachineState *machine)
     }
 }
 
+static void triboard_machine_tc397b_init(MachineState *machine)
+{
+    TriBoardMachineState *ms = TRIBOARD_MACHINE(machine);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_GET_CLASS(machine);
+
+    object_initialize_child(OBJECT(machine), "soc", &ms->tc39xb_soc,
+                            amc->soc_name);
+    sysbus_realize(SYS_BUS_DEVICE(&ms->tc39xb_soc), &error_fatal);
+
+    if (machine->kernel_filename) {
+        tricore_load_kernel(&ms->tc39xb_soc.cpu, machine->kernel_filename);
+    }
+}
+
 static void triboard_machine_tc277d_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -74,13 +88,29 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
     amc->soc_name   = "tc277d-soc";
-};
+}
+
+static void triboard_machine_tc397b_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_CLASS(oc);
+
+    mc->init        = triboard_machine_tc397b_init;
+    mc->desc        = "Infineon AURIX TriBoard TC397 (B-Step)";
+    mc->max_cpus    = 1;
+    amc->soc_name   = "tc397b-soc";
+}
 
 static const TypeInfo triboard_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("KIT_AURIX_TC277_TRB"),
         .parent         = TYPE_TRIBOARD_MACHINE,
         .class_init     = triboard_machine_tc277d_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("KIT_AURIX_TC397_TRB"),
+        .parent         = TYPE_TRIBOARD_MACHINE,
+        .class_init     = triboard_machine_tc397b_class_init,
     }, {
         .name           = TYPE_TRIBOARD_MACHINE,
         .parent         = TYPE_MACHINE,
diff --git a/include/hw/tricore/tc39xb_soc.h b/include/hw/tricore/tc39xb_soc.h
new file mode 100644
index 0000000000..66af339db1
--- /dev/null
+++ b/include/hw/tricore/tc39xb_soc.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Infineon TC39x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ */
+
+#ifndef TC39XB_SOC_H
+#define TC39XB_SOC_H
+
+#include "hw/core/sysbus.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/intc/tricore_ir.h"
+#include "hw/timer/tricore_stm.h"
+#include "hw/tricore/tricore_scu.h"
+#include "target/tricore/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_TC39XB_SOC ("tc39xb-soc")
+OBJECT_DECLARE_TYPE(TC39XBSoCState, TC39XBSoCClass, TC39XB_SOC)
+
+typedef struct TC39XBSoCCPUMemState {
+    MemoryRegion dspr;
+    MemoryRegion pspr;
+    MemoryRegion pflash_c;
+    MemoryRegion pflash_u;
+    MemoryRegion dlmu_c;
+    MemoryRegion dlmu_u;
+} TC39XBSoCCPUMemState;
+
+typedef struct TC39XBSoCFlashMemState {
+    MemoryRegion dflash0;
+    MemoryRegion dflash1;
+    MemoryRegion olda_c;
+    MemoryRegion olda_u;
+    MemoryRegion brom_c;
+    MemoryRegion brom_u;
+    MemoryRegion lmu0_c;
+    MemoryRegion lmu0_u;
+    MemoryRegion lmu1_c;
+    MemoryRegion lmu1_u;
+    MemoryRegion lmu2_c;
+    MemoryRegion lmu2_u;
+    MemoryRegion emem;
+} TC39XBSoCFlashMemState;
+
+typedef struct MemmapEntry MemmapEntry;
+
+typedef struct TC39XBSoCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    TriCoreCPU cpu;
+    TriCoreIRState ir;
+    TriCoreSTMState stm;
+    TriCoreASCLINState asclin;
+    TriCoreSCUState scu;
+
+    MemoryRegion dsprX;
+    MemoryRegion psprX;
+
+    TC39XBSoCCPUMemState cpu0mem;
+    TC39XBSoCCPUMemState cpu1mem;
+    TC39XBSoCCPUMemState cpu2mem;
+    TC39XBSoCCPUMemState cpu3mem;
+    TC39XBSoCCPUMemState cpu4mem;
+    TC39XBSoCCPUMemState cpu5mem;
+
+    TC39XBSoCFlashMemState flashmem;
+} TC39XBSoCState;
+
+typedef struct TC39XBSoCClass {
+    DeviceClass parent_class;
+
+    const char *name;
+    const char *cpu_type;
+    const MemmapEntry *memmap;
+    uint32_t num_cpus;
+} TC39XBSoCClass;
+
+enum {
+    TC39XB_DSPR5, TC39XB_DCACHE5, TC39XB_DTAG5,
+    TC39XB_PSPR5, TC39XB_PCACHE5, TC39XB_PTAG5,
+    TC39XB_DSPR4, TC39XB_DCACHE4, TC39XB_DTAG4,
+    TC39XB_PSPR4, TC39XB_PCACHE4, TC39XB_PTAG4,
+    TC39XB_DSPR3, TC39XB_DCACHE3, TC39XB_DTAG3,
+    TC39XB_PSPR3, TC39XB_PCACHE3, TC39XB_PTAG3,
+    TC39XB_DSPR2, TC39XB_DCACHE2, TC39XB_DTAG2,
+    TC39XB_PSPR2, TC39XB_PCACHE2, TC39XB_PTAG2,
+    TC39XB_DSPR1, TC39XB_DCACHE1, TC39XB_DTAG1,
+    TC39XB_PSPR1, TC39XB_PCACHE1, TC39XB_PTAG1,
+    TC39XB_DSPR0, TC39XB_DCACHE0, TC39XB_DTAG0,
+    TC39XB_PSPR0, TC39XB_PCACHE0, TC39XB_PTAG0,
+    TC39XB_PFLASH0_C, TC39XB_PFLASH1_C, TC39XB_PFLASH2_C,
+    TC39XB_PFLASH3_C, TC39XB_PFLASH4_C, TC39XB_PFLASH5_C,
+    TC39XB_OLDA_C, TC39XB_BROM_C,
+    TC39XB_DLMU0_C, TC39XB_DLMU1_C, TC39XB_DLMU2_C,
+    TC39XB_DLMU3_C, TC39XB_LMU0_C, TC39XB_LMU1_C,
+    TC39XB_LMU2_C, TC39XB_DLMU4_C, TC39XB_DLMU5_C,
+    TC39XB_EMEM,
+    TC39XB_PFLASH0_U, TC39XB_PFLASH1_U, TC39XB_PFLASH2_U,
+    TC39XB_PFLASH3_U, TC39XB_PFLASH4_U, TC39XB_PFLASH5_U,
+    TC39XB_DFLASH0, TC39XB_DFLASH1,
+    TC39XB_OLDA_U, TC39XB_BROM_U,
+    TC39XB_DLMU0_U, TC39XB_DLMU1_U, TC39XB_DLMU2_U,
+    TC39XB_DLMU3_U, TC39XB_LMU0_U, TC39XB_LMU1_U,
+    TC39XB_LMU2_U, TC39XB_DLMU4_U, TC39XB_DLMU5_U,
+    TC39XB_PSPRX, TC39XB_DSPRX,
+    TC39XB_IR_INT, TC39XB_IR_SRC,
+    TC39XB_STM0, TC39XB_ASCLIN0, TC39XB_SCU,
+};
+
+#endif
diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
index c6be4dc3f3..bc84c26f32 100644
--- a/include/hw/tricore/triboard.h
+++ b/include/hw/tricore/triboard.h
@@ -25,6 +25,7 @@
 #include "qom/object.h"
 
 #include "hw/tricore/tc27x_soc.h"
+#include "hw/tricore/tc39xb_soc.h"
 
 #define TYPE_TRIBOARD_MACHINE MACHINE_TYPE_NAME("triboard")
 typedef struct TriBoardMachineState TriBoardMachineState;
@@ -37,6 +38,7 @@ struct TriBoardMachineState {
     MachineState parent;
 
     TC27XSoCState tc27x_soc;
+    TC39XBSoCState tc39xb_soc;
 };
 
 struct TriBoardMachineClass {

-- 
2.47.3


