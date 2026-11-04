Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1117606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ek3AFEa5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeLb-0001IG-5q; Wed, 04 Nov 2026 12:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL6-0001AA-ST; Wed, 04 Nov 2026 11:59:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL4-0002UD-0t; Wed, 04 Nov 2026 11:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fktO/uhLSTMrZyWzP7tX8XFddWJauTnxrq4GAfIyMZnzqvmjgasoFK/IReYVfz0VegrAzpaPjaaK+q+yj693kpbJWtCPdQspVu7MCzAswfHyj3D/ONJ5gkspYOUUGJ4a9TK8944ALBo56jBZg6iufP5UPz5Ym7A90bOl7j6cDrpvgfpdmyE2Zz76oT28Qd3q09VcTlxRThMYQVZpi8fP5RhaaHT/YMpfqDG5+9ClHGzxvuEpUGlNdH4nTOhAs4NgsXbVCKOyCxtP0sUDuDgxfvrq2c2JzyzlTxFTTSuys2+4KoEHE9P+oAfUUj3vTG/zkT3APqvR5NwpSq39CHIseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfqp58sV3qkG0HdUIoD/zL9wnRKW3nwU7b7+Ub1/sdo=;
 b=ihjrA6nDcAk0J+vi0g4Pm6VFchqqQZcw4Q2XwEBt1LttIT5k3e6eiQGUqoa5LUGBvTz9fIosgxQMQwn9fj3bwPsHdaoY20YSsxHji0gTjv6CBXMCARFM5REL4KSq5XrTqb2QbVuB9vwGXTg8uTRp8PewuGsd//KNtYsBAoDxuYvbRBe0sUMFv4X/vWNRnRMtsaNb+CmvUVuvSHNH4dTsL2222LaE4Yvsvm5P7JJEDYddLLay+hxJA7e/wKkSk48zjCajG8eBul+6BFp1l9lvJWx2wh0r8dglZFyoQXt+xDSXthaESO+PhT/C5qSaNfdyhj3clhNVzXXQj1bBsiiofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfqp58sV3qkG0HdUIoD/zL9wnRKW3nwU7b7+Ub1/sdo=;
 b=ek3AFEa5AY2IKcBwXHMSGq0UZ4jQZES0QAiN2OmUEE1P5rIqQxisRCubD9JmlxlJuKgwbO4Lufa0+9DzTmS8i1QFhMKf6ZCFzydwCRMe9WCo4TpiNxHL54i1l4N5WUVkQ38ayQhehLoUPcPw8RJm9j4lU8GChKt7Wf4k/zfHuT2D5KI/rga6dAVeDmBfiU2k0cc74rBhVmRQJXaFugHSMReA8hGyt9y7rMUBEyJYx1AAlJab5xXaIJ0ulW5ViBPf+z1jCH/mgc+Z6lTILHDGUqZY3O3I1O+PhbdOB3EJR5ZunCytii2dr+40r+W6f6Av1ERkO4GHefltVQNJYx4dpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB5848.apcprd02.prod.outlook.com (2603:1096:101:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:45 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:44 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v5 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
Date: Thu,  5 Nov 2026 00:59:12 +0800
Message-ID: <20261104165927.678833-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b44414-d8b7-4e80-cc54-08df3a95065b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|6133799003|56012099006|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: qkbBYiFHd7Q549CY0NEM3Rpg+/CWf+hqG42d5uQiKOY6seNgd7XAYr0SwUaMEpLW7963qyFwbEsKXVV3KVaVKBjesNqGqhbe058+C4gFiS9SZlZepCKiVI5TJqUiIyJO/E3slCSDMleLfJteRKaX80mRfAEkUl/vBIuNqoYjyEp4YvDbtiw4/554ZgLA4JlXmXMuVQBVhSArzeN6Vov8Zp0Fc4jgaXKqgQU4xW2o1F1dlqpVJRwalTkTfjIqe5GVtIcVFWF1NLsBRqedWmDYbscpTQg+2qQ9Wfq5eXWFHTRys18YXF7NdJd/L1tHIC8MeCMNj96DdBlxNAcZnVkuZvM8AKafMpWeKaTENXJKJaC3mQELn+wYzfqEqmjZem4PnBIbwuHiPfxZux9CNcKO5BT/2AjVAcexJvskGBGpOpIgcWI/B1zxxNYew1q/ahjwcy20nZxvdeySqMHiQKyAUYdVsy8vHX4h2YH5siJNYQ/KHWEVWBHHlHmxCMvVdSszlF0+ezHIpU3JXUoJEimmNYUQRQL3veKHTJSGdsFOOThHmHuEZ1X6Y2+9DxUI5mZ+PQcqJBhA40V8MQ54Vmh9cFh9IvylW5iGlAhLV9fW3qgQ8cfragwCenW6eBg0GEGfbXV11clz5MD6spW21aWEfajGRLQB9QAsTlkWkA95/WQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(6133799003)(56012099006)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBRU3R4R2hhTVA4QW5rRkVoRFY2L2pBZ0YwNlVmWW14azA4YUU5MjhKd1Rw?=
 =?utf-8?B?Rncyc2N3N3JGcm1mRDl6VTZ3ZGw0N2lNZm5qV1hSWGxEOE5sa2RuYXNJYlFv?=
 =?utf-8?B?dzYvTEQ3amw2dXRTcSsrbm1GVWt4Wlg2Q1NrNGZEeElYSldlYjNlZ0RFRGZ2?=
 =?utf-8?B?UEhDU3JxRzF5K1FSQXlBdXBSU2dnczlKcC9UdW0vdUJhQnBPbmxWRWYzbGJp?=
 =?utf-8?B?aXIrVjRCSGZETDdLdzFGdGd3SjJIUTRxQjBpY1hqRW1yK2pJN3RMaVlWRTJH?=
 =?utf-8?B?WlFRaXRrZUJ3eHAwRWZwRm1vcXpsQmEvVHlhNlZ6NzEwL1VnL2hSYmc4Z3Q0?=
 =?utf-8?B?VnhEUHRkaW5TTXl5bm53TXc2cmNVbDlEMTJRUjNxcVdiVVVSV0NTbm1FWHJj?=
 =?utf-8?B?cFRiY251cHB2bVU1cGU4QUxocVJaVVNVeXN1WUYxcmgvVmV0bHA3a1JqREhY?=
 =?utf-8?B?QnM4MldYMXB4Z2ZXczhOa2xEcFNvVk4rUGJsNUpjWVZsa3h3M0xDR1dmRTZ4?=
 =?utf-8?B?OHQyRWtKSlI5aUZ5QS9WZ1lpZDB4R3ZIcTRLaXZUWUxBM0lLbHU2Y3ZPVGY4?=
 =?utf-8?B?U3phZUU4VVYxZUQxRnR2R2xoRGlQZ2Rxd3RrYlUzVXpiK3hHeElNNHN2Y1R6?=
 =?utf-8?B?S0lpN2tXckN5TDBlb04yaWZVY053OWt1UFhac05yLzdlNXovMTRLVUYyaGxu?=
 =?utf-8?B?cHFJbUtENXRTVFRCUWtTMmtNU0NJc2RLemFxTnBUdlpHV1BkOG8yYmYyWkV4?=
 =?utf-8?B?dGZndlB2UUNMUEtlZEk4dWJUVHFKazd6UWoxR1FSdXBDMUhYL0FHQW9WY2Jl?=
 =?utf-8?B?RW9kamJXaGRYSHpQUkxpcWZoRFp0M1ZZdE1jWDgrMThjZWN5WUY1VlIwam5j?=
 =?utf-8?B?eTRkQkhFdGk0YWovSDRTMVNyaGVnbjNFWVBaRUZjTENKclI4Tmp2YUFOcnkw?=
 =?utf-8?B?U1NjWHlqeEY4VVpGK2dEUGlIYXBmMy9mTFRhSFlZbjdaUm85Zk9aYUZ1dENL?=
 =?utf-8?B?c2haYjdWb1UxSXJ4UER5Z2E1dzcrVW92ZEdaRlNEZmpiNWlKcmdrNVR0d2lQ?=
 =?utf-8?B?N0hFYzROeFJuYkpkeTRVVTdabENNSFd1RGhlWkJwTmZMOUFsb2FQV1BBeVNu?=
 =?utf-8?B?VlNEck9hWXc1ZTEyczNoOVhlcEJMcUszdUhnek9iZUMrcXdpczNjZkZTR20v?=
 =?utf-8?B?RFBGTmRoOHJMT0M0cEwxTWxGeENPczMrYjBmS2lwUmk3bHpOdWJVRFh3Znk0?=
 =?utf-8?B?bDVtaVQrOTFsTE9Vei85QjFMSzdMM1ZEQmxZSHh6VHg4OWZZUVkrZ08zbWdJ?=
 =?utf-8?B?RzJjNDV3NTI5RXA0c0VIY29VMlZxMmF0OVJnM3p6NG5aWVlkVkw2TjlKVkVy?=
 =?utf-8?B?RVErUko1bWxpOThydEhSY1cwc3plNWNRcjgrcVpQSG4xRHkvS1p6WU9Pcy9w?=
 =?utf-8?B?bVJIYktVODZrcCtYKzZZaUVQQjRJS0dNbFMvcDBoUTgxMW1BTVFGYzRFSnpm?=
 =?utf-8?B?N3Fjdi9GUUhTZnUvN0piKzlkZXlReURCNFVld0tBMVFES3I4YjZXSFJpYzV2?=
 =?utf-8?B?T3F5NjNBZjBNVzBrL3FhTnJxNFVVcnBUL083U2UzV0VMTmlpczduQzhWbVVM?=
 =?utf-8?B?S0REc2xWR0QrUUZKakRLT1gwRHJzdGVrZXo0K1dHd09EM0xtZVhLUE1xZzJW?=
 =?utf-8?B?U0pVVE1tdU9Mc3kwdS94R0d5d0tBWjN4UEJacXdjcVRWOXY5SUIxcFNuTmVO?=
 =?utf-8?B?NVFBZGZTcGhCSGUwcDl3d2NlaGtIM0VSRDdvQnByNFFzMFc4RGdLcUt3b2Qx?=
 =?utf-8?B?MzA2MzdJbE9jUEQ1OTBBNVVxOTJ6bEluQ1VzWUxuMEZ4WEpaYlJnVERzMlN2?=
 =?utf-8?B?K2c4TUlORGFDdlRueDFHTzlEbzU5WDFEUWVGcHEvUFMyYzA2eEY4TU93R1dx?=
 =?utf-8?B?NkRtblFiYnE2SUthbEdiSUtqZFowZFB2YTdZRGdYOXBEcE1DMnNITDRIRjRY?=
 =?utf-8?B?U1czak5HQkx0djZkd3RuaTRXbkhVRjFGRzFBbFFkcFlFRTNYeE5zclhUTDdk?=
 =?utf-8?B?QlM1dXNsakpxN1pXMTNheGljanh2bENBTlg3bGpic2Q1ZEtka2JjVEVZaytR?=
 =?utf-8?B?SURjbXBtSm50UnRoUGFiYThQNS9qd0dPTUVkajY3SFhRVlNYcWJIZkNyM1NE?=
 =?utf-8?B?S1BWcXVKdFpUUmpqZFVlNXo5WFlPSytocmNxeU9xSUQwUm1PNXd6K0pydHpS?=
 =?utf-8?B?ZEZKQ25uTXNxM0hvL1dkbWlmc3hTWk9yUU5WM3E4U2t2SkNvbWZtRm9OazBv?=
 =?utf-8?B?czhhL0pzbHhvblIvbUlBZ284VXBrOEdOWXRoaEFTNkd2aitGZ0dqanVsOUZ6?=
 =?utf-8?Q?ZaanslIrCq1GE6bE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b44414-d8b7-4e80-cc54-08df3a95065b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:44.2874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCnR955lKG9NSyVNNBHq9iqckyq6XSeAp4ULRKiCHGSnH2KO8Oew83yMR9eqMBbXGPBuvevUiYo1hGkh1Zm8J8xF9A0PsG5RNTrMIqSn3pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5848
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


The mcimx6ul-evk machine can boot Linux directly, but it cannot run the
U-Boot proper produced by Buildroot far enough to load a kernel from its
SD card. Early U-Boot boot test accesses currently abort or observe
placeholder values, and the i.MX uSDHC model exposes several issues.

This series lets an unmodified Buildroot 2026.05 U-Boot 2024.07 image
run on mcimx6ul-evk, load zImage and imx6ul-14x14-evk.dtb from USDHC2,
start Linux, mount the SD card root file system, and reach the Buildroot
login prompt. It also documents and tests the existing direct Linux boot
path.

Patches 1 through 4 provide the minimum early-firmware-visible state.
Patches 5 through 8 address i.MX uSDHC behavior needed by U-Boot. The
last two patches document both boot paths and add functional tests for
U-Boot and direct Linux boot.

This series is based on the v5 PolarFire SoC Icicle Kit series
<20261104154207.641511-1-bin.meng@processmission.com>,
as the SDHCI changes overlap.

Changes in v5:
- Rebase on the v5 PolarFire SoC Icicle Kit series
- Address the uSDHC const and opaque-pointer review comments
- Consolidate uSDHC write dispatch while preserving partial accesses
- Fix boot example formatting and use the default RAM size

Changes in v4:
- Rebase on the v4 PolarFire SoC Icicle Kit series
- Simplify the reserved page to a MemoryRegion
- Log invalid reserved accesses and explain the RAZ/WI behaviour
- Reference the U-Boot fix for the reserved-register access
- Make the functional test executable

Changes in v3:
- hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
- Rebase on the v3 PolarFire SoC Icicle Kit series
- Model the full reserved page as a child of a15mpcore_priv
- Validate MMDC RAM geometry and document supported capacities
- Translate uSDHC vendor clock gates in its MMIO handlers
- Cover partial reset accesses and migrate vendor clock state
- Extend contiguous SDMA completion to both eSDHC byte orders

Changes in v2:
- rebase on top of the microchip polarfire soc series

Bin Meng (10):
  hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
  hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
  hw/arm: fsl-imx6ul: Map early firmware register placeholders
  hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
  hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
  hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
  hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
  hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and uSDHC
  docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
  tests/functional/arm: Add MCIMX6UL-EVK boot tests

 MAINTAINERS                               |   1 +
 docs/system/arm/mcimx6ul-evk.rst          |  72 ++++++++++
 include/hw/arm/fsl-imx6ul.h               |   2 +
 include/hw/cpu/a15mpcore.h                |   1 +
 include/hw/sd/sdhci.h                     |  10 +-
 hw/arm/fsl-imx6ul.c                       |  87 +++++++++++-
 hw/arm/mcimx6ul-evk.c                     |   2 +
 hw/cpu/a15mpcore.c                        |  32 +++++
 hw/misc/imx6ul_ccm.c                      |   2 +-
 hw/sd/sdhci.c                             | 154 +++++++++++++++++-----
 tests/functional/arm/meson.build          |   2 +
 tests/functional/arm/test_mcimx6ul_evk.py |  69 ++++++++++
 12 files changed, 394 insertions(+), 40 deletions(-)
 create mode 100755 tests/functional/arm/test_mcimx6ul_evk.py

---
base-commit: 055648c36dd2ce8bf7a339f852ba01f063e23b4e
branch: imx6ul-evk

-- 
2.53.0


