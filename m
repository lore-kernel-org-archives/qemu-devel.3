Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E0DC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDq-0005RX-Ap; Thu, 23 Jul 2026 11:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDZ-0004ab-J7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:20:14 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDX-00085x-34
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:20:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXs+LkknaIEoVHg4y26frxqeDoURRhkhzZ4LkXUDbhuVZhN/UN8aU5WvWR4Uk11CAu4uhUg7tXAshTUhRVf7tCV6Lt1mC2Z4ptrebG4pbjGly9GkowgtsGkUkfrt25FnnfXvo66supColA2d1ukT752QdcRg5NKXRvt9pzgSNKx/cX2Ajd/AyVTDTkjt+rYoeNTCfWMQgrx1JaayilXEZ101ZBTBhuKd3wo4ZpB3QOdMq3QvQTC+muWMnSyb6RM0CdC04JlzNRmn0SXcNr/7j3Y0h9Ofx6UuseMtOwEZOwh2zhVGscNlWaLx37AZZgSo7Evj120Qh/Kx8qPYj9QogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVzoya2/6sCmKoTE7/fcejn9pLd19yjkvzqx22ES6O4=;
 b=rGXhW6vNO0xlLIOIrQrxO1g56wWtldI7Y9ynw4bnjxYUNwyNlLZvrObATs7n8El82UfX/G8xhmQbXV7bo4QRUDtkiafOR973CLcpLVIuRrfMDJu1T0R386T+v5xrnf+B29qzLGXtF/kwQCIcw+Dlxm8zm6+y088FMIf779Z7phtac/Dg2E6ZrIwG9xytlSaxzT8R1xrKrZRkD3qplSOb6xaT6owge0Gxn8Sce031WiHQTWJWGdsVnjKpdyTxi2t/DFkBtkM0rVbeOmpl8rY5u8rfP0bMT/yJlH2tb8OCVvE6veG8NkW65u9afjvIlm8rmq6aIge0sHp0USF4+ghwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVzoya2/6sCmKoTE7/fcejn9pLd19yjkvzqx22ES6O4=;
 b=Za2kOipOUzVXwy0O5WMaqCjRn1KlZFH7F1PkIT2XZHGgOCeGQ42P3B5vLs9SCTaScHbUUF6qT+NsEtjApYirsZa9rGspcd/0g1TzOtYpCFtRLlxgGWG4fU8Um1bhJzuRO2PdRgxqZF97RokVBy69PtN8LCIyanlZyNy5t/cQHNUr8t8t83Oks3LzgT6RlPJgVF3AG/EO9GJwVuk8JXQCR5vPWCZDkRMX5z0JquyoVcVFQTdXo09T797qaMDFNQ+kCvP2f9okMFzTTsyJEvrud2N1xZRjClikGSQEjxmGpJaZj6htNLlKERDtWEd3QRddKSHZ/KeBHm+VUskEtRcxpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:50 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:49 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH 26/26] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Date: Thu, 23 Jul 2026 23:18:53 +0800
Message-Id: <20260723151853.2143177-27-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 994f1e24-430c-44b2-7ad2-08dee8cdd676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: iAFSA6MTwYbdOmFM7oclmP6pSl+fafI7O4Gpq0B2hILIaiz3T1On5I0dKWeWt/ACgTbo6zhvovXz6M/GRq9H6qDdGp1XbuEW6xhO5RcG+asbzfx/gew95to9jYnDIl1xtm8NvdTw/PpQnQeP1TrU3HlTmRR/tJUUAR2NXbmhYDBhQ0U5WFCjrqfhPx3+g5J/wyo++2UXeXzidnF2lLcQv9sdlAvHJZj+24Xl97leSWL70DxlVCJzqQI+BE9TptXFVX3Zlwufv9Mp8pveuwj81Vyu/YJOPJ9eZYkempFW8biFEJo1T3ldHD4ib0BGHVPTv8r3FbDM12X+BaRBHwH09JHnFbKQyMahIj1GURNq8B62V23g5rncrYQAjkhoMCv4NaQq6zEHcfUsRM6Dd9fEwIPYJhs5nvqz48sdGr7L6W0CtDsS/7JHzcZA107u+Z9JTg1tuTR/RHyD6/hC6DfGxh2RbajswDDCxGtHdtz6cSv9NjjM3Lcwi4JTXHeHxskDcM1oTwV3v/h2ZFzuHGQRSfpWqTeHDJSOfhKTI+FcI97P5nZ+fH2+z0pmxFRFvKH3B3ZN+6eHTuwwC5gQ/yHTUrlRI93QmbRUEXtkgHHVJIOxMJw8M8WKKLCGD7FefIWHdNcijvrDIsFQl4eP5bxoa1Bnc3zJfZrQtk+HdZL1TdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMsZHsteeJRhCTYZczBpoOr4qU2aC7W1FAdK1denQwCN8LUHKqU77cZq7Qq3?=
 =?us-ascii?Q?UFYMtfaCwVVZpIjbgi+RrPIu/wxR/L9xMhqHJErgDm0vegmJAaW46MJ5FIdL?=
 =?us-ascii?Q?3+2CZi3/Drvdm7AY7T/RyRpJA1oC3LFsqyDCXVF4fhJ4bBZbgNtA6/Uw738i?=
 =?us-ascii?Q?1xoBlPiQ9VWFCq80nyQ3XHvGEisR2vKY+EZuYmAHC1Jeyvrlvbq7SYbbJvS5?=
 =?us-ascii?Q?zrzc++9cd7/KWDjVcAdBUXFXTjC57Kek/OqlzWIZ+GWDDNJTKhPgkbRMOTrH?=
 =?us-ascii?Q?N5onn08gMV/GDljsGXfxAy6zYOw2xCz3/GKtnIdkcWGIHsJrOSz33gVxjvQH?=
 =?us-ascii?Q?A82yFk9afLB7oNECtibQbOyx/DhfIqwiQIqAmNgO7HbSuAlSswlhmF2rbVFe?=
 =?us-ascii?Q?cx8zQB7NSbFQI1XlZ4PtIljfV8VEQgykPvTg5G0HMm5Z7zreMNgEGCRAgmMF?=
 =?us-ascii?Q?LrKzFxWbsP7dx+WxEkx/w7HD6h92q67lFCizJ5/ymxl7bvBfLq0QDGzQ94BU?=
 =?us-ascii?Q?4yed6Z4tYi+UuAIshfp6Pn9z6i8B00rBitZGuQ1RtqgzzulyPhea/InryJ8p?=
 =?us-ascii?Q?HwQzmvNDVtNOyNmeR2tiPudhfSb92/12twUUlTK0ymeUGbKAjBGjYr4K3skJ?=
 =?us-ascii?Q?5XGQTJ6m5ubTrKqkdq0Xi+BlFFtAfqr0DrTA0l34tw1SvmiMBavzSs0dYch6?=
 =?us-ascii?Q?t0nyRMj5QUU4qFDZiL3KnCqHY4Q03nZ9S22Ly3gRzS6Q9nmsjER1/LraCcFH?=
 =?us-ascii?Q?2lW2NNvxFYVljJQQ6xPnuPfOiTYxdCOaTB7WnnAhTx/iMndvB7SjsZvQZ0FL?=
 =?us-ascii?Q?huJCh+jn3GxWI1Lz3/LnFF8tp+mlSoIkqmY2P1EtFb/SuQPPvTnUK6hOw1by?=
 =?us-ascii?Q?txq+VT8tRW9KGilx5XH6i2eVzHWrRf5NHFB3+DRJDUKwHt63YOaIFh/ve+k7?=
 =?us-ascii?Q?CSf2oXaCuF15oI+ju9lBrrANfwikoC+xxdep3mzCVnpUqgeB6AxbvyxNn0Oi?=
 =?us-ascii?Q?unkaU0BldAHz1VN/j6UHbr8PENcOVR5UyXSy4eH/XigduqPX6qC+mbAxgQYs?=
 =?us-ascii?Q?8oKhsGbvXFgLEnSoVkorj+EKr5X5osM34yVOpeJq0J++8pwr9ZTVKgzRqpUm?=
 =?us-ascii?Q?RxYtq3jBCqrpCQHUAkdZfWki7KGwmxJXPNhTZ6Xp0Z09yZOlBVubhOQszlZB?=
 =?us-ascii?Q?YAZUmadSCimywnDu8MX5ciwra8ApQcsDSCpffr2pDuXYUwkC+n/UleHjUX1J?=
 =?us-ascii?Q?84Jqit7KrPGM65qgDE3mIuspuLyAJiqIjhGEMvvev8fxco5T7rlEcSwbc9ov?=
 =?us-ascii?Q?n0hLPhyb7la88hFnul2XIIuOYdijnz0prgqQUtJkGnVu1okYiX6aKIlN+v3j?=
 =?us-ascii?Q?UCaolnWwWTwvfA5m8rfHgB51QboZIsCD22u1V6zgFsE9HL/87VcixPB2KqUW?=
 =?us-ascii?Q?uxYvBJS48Aeu94/N4o7XHhW8JaYpb/qx1FU64y0UIRnIbOueWmLgWahyIWtO?=
 =?us-ascii?Q?4GLWVPzJgGxZz7ikwH/rcz7lIkkXmbGOR9d9wjCRIOvZ+y1WdicI2FotAzCe?=
 =?us-ascii?Q?u74iynfIYBcU5pYLBTM9xXDmdmr62nYlJ0QfEs9LqBdhB1rj3DVvlN+NCX1Z?=
 =?us-ascii?Q?sfrZCeoYFI3k2lsTy2jwHAjVB71L/VcpqPQxYdlT1+F3QdnCCWVmazib7N2N?=
 =?us-ascii?Q?9BQbQigaxlGdA1csc4LXsHeE2mmAMU39a8o/hYImg1Jalxoy/QPI3WlEL2mB?=
 =?us-ascii?Q?BLGozRQr0HWTdJMB7TTJJSWkkL9wEmU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f1e24-430c-44b2-7ad2-08dee8cdd676
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:49.8831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dVII6GvlzzJhkZ2T29BBshoOJTDUY8nliEQYtrbwMYYCRkBAofWVsq9HNNFCU+nSeZdXVhYI8LxbxVfyaBR2lWG9Q+4xNH8Ctab22dCIc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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

The preceding Icicle Kit updates restore HSS, U-Boot, and Linux
boot. Functional test coverage is also added.

Restore myself as a maintainer and mark the machine as 'Supported'
to reflect its active maintenance.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 800a2f31cd..9ed60d14a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1761,10 +1761,11 @@ F: target/riscv/xlrbr.decode
 F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
+M: Bin Meng <bin.meng@processmission.com>
 M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
-S: Odd Fixes
+S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
-- 
2.34.1


