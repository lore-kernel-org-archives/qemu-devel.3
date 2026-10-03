Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A7CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Bp-00035X-GY; Sat, 03 Oct 2026 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39m-0007dl-60
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 13:04:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39k-0007N1-Pn
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 13:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNsAN9ROKDe4WDEJB0egepRoPuK20rsoXFkfq4yExoX6D1t5oeAsvP0MDRjYG3EO6/XWhAEhLLx09N/di1gJa89iaZPCSMnuC0ZWChlw6Q74Sav4SSqAdQJzWRAxjFuoIxPELHclnpnYw81l+RsVH12cW9phDhsZphleMze+e2BBr1SVYuNWBYyKwdzRjw8PtaJzDfSKzSC4vmkErdRFMM8EWNafOsdkbIbQmlYlKn116gmWevesn7/K6ca+B+ugh69kLRwCUYMGlRrZbSH9TVi4UKR20UL/V7/uM4E4zAnBP3INqb/2vVK3Oe6z72LLyA5qKGOi0ZymXpc0qwQiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21JSIg4tQTbCRcTBxzQrX4H07Xcz6zi3RalRDOBmfa8=;
 b=kPK7ybYwu4DCUrbR5sY3yui/GjqtgNEobbDsm7qguce+k64F/X61r4T00AGRBcv7llRPNpcwTzUNkN9NZanAG4+XlchHtQgI0ZjwzgXwSEJkzkNbB1u19mjj2R59mkk4G/qvUDQoy6i4k2N1RLzyAbqseAzi/WPVD92vzXdoCrakJmMq6jS3nKsd1wkvXk9kntqy5M1cVZNOxKk86ohR7h1CLtkp2uDqc4WxNCWfcyvrLmrkfT6PVgMiPChDHuDPwK/dPHsZNi2NCoUZsSaRwuWhaOAdk84F0NXxZSkweR/xwHPznDClxrzkTlrOy5jtXlqEocW2WbfssJ7Hw89lsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21JSIg4tQTbCRcTBxzQrX4H07Xcz6zi3RalRDOBmfa8=;
 b=C4kLYyWuvsJEfpw0pc/8Fs1yjG3I7bJdqzYCo+GzwCBBON//StmK0D6Ha8zwDmsVoy+XsR0ruXi5Pm0GaVn376DkA0bwR6uo6Q6qE8bgFzZ+TJRUb0g26AN0rqcw8K3gZgJFvqQV0SqfA/uoVVrG96haxP6qHJoPqruyePf1wSXmKM7dM3FqSc7kWFAwrU5X0SICzUO0OEshgo+YLSKZ6XEHwb2PGZlFoznjkhj5k3xOwSE9qEsE6McHEL8H1cb1iVo3iXt3Ht/hZV3uQ6Ux6dtOtPDcfU+GTBuP99UcqYnOIyAjzeregohlN4w9/MOUWg2H9VNYB8FFsrFym38THw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYSPR02MB8007.apcprd02.prod.outlook.com (2603:1096:405:8f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:04:10 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:04:09 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH v3 26/27] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Date: Sun,  4 Oct 2026 01:02:16 +0800
Message-ID: <20261003170232.2450916-27-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYSPR02MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1fdf46-107e-4953-4138-08df21705722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qw7dIf8LSjzm46cpPco5fGvOcySbS2/ObE1jgBbenrMoFzPGlGQdP0WCbQpWLv1EnAF5S3wBc/qRNVA/5wtSIeAvLIfwQzpJcR4ZItLsw81EnExd+ZGAzUtfQ2ngWNpIQ0GsWNjCPX0wtuEK9sti6Tepzy/UFB9NqaJ+PRPFOE9f6C0c6tgwWRd27J8lKmnaiNc/Q8JcHmznSTEUDJE0K4fU8HxQwpLMSJhqQKaW9nxnf3dUSK+Z2PLPclIc/KwFzhp1YLXwn8oeK7M6ezVQPOu262SbUEpLc9KrDZ8Vyrcfd2ZVoeVQky4esI6IeHPmi3Fi1b+Iu1CBzOWLgoOIoWXpCpEqmNS1b4mX1Rv0nVrx/jOChtLGC7OlRc6uxXWTVJfGO2dCXIRL0OLQQMNTlHqKaRkON9/MoME+Et0ROejJJm4axTipBCxxJRfOSTxMzDDotBiIJ7nEvvd4rPkuVQSpEGrVCdAZ2Qd/lhHN8WAFuNLBx3Z1+HfpkzdbSQ0R9nbJ8WLXdWz6UWHBEM9+n1MjEkwTpt2Z3CI/0aSKGZs0s4GDe3XmV7pgLaOegFcokvl+Z2TITbPtqo+FxlX0T+VmpwLx6MPodx/+z4JZU/qKHtZHirfNil7sHdaCsc41SOPXjpTB86V0e9U61wcEvjyqIcCYwwH8mdvgrse+/oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XG71BCJ6+QKvDT8CPzaGZ9aFtFlPOjLfLnzOHmXHUl4RcepY4Bgd1SJ2xyDI?=
 =?us-ascii?Q?oRG5mA5ihf5nGEILqM9/C0XYrk6fKmCCieny3XzfO3dpV6E5p0fqJ/qGQNps?=
 =?us-ascii?Q?z4p71oGeLxR3snBNE7+1ydMfNfGG4efeADdqk9WoZvy50XGqxl5l5NIYjcFZ?=
 =?us-ascii?Q?d59z/cjkKd7k+oYe5uaLQ87iFhxECkRcltgzHPMbcfjGzFGC8ZG78RtqSUQ4?=
 =?us-ascii?Q?OJETjnwMh3FuTEs7jS9LyXS827nAUwl59jCazVe0aKfn4HMgGCBAbJCAhKZw?=
 =?us-ascii?Q?FXYJR9wrL0Du60jjlHmUrDBiE+R/1p+bZ3TcowuxqaBqam8xKHsdEc0TjxFc?=
 =?us-ascii?Q?mf8vxcR7ILAR3XryvVtR4LAMQhD3oQO8qk1p3Et8/jF7niXpeOQB1Wo2bhB2?=
 =?us-ascii?Q?JoX7NEsfAI6meGZuhXxlVz5iD+AFo4mWFNGNWpb/K4om26sqDGrSKdrakmT/?=
 =?us-ascii?Q?RzxYXCHd1kr8/6Lfmf0Df99l8+fzm0kGdkvG69Gnd8QXYn6HjM3A0rQ7w1Ds?=
 =?us-ascii?Q?Pr3gDEGoepGl07ePTKvPGqiXqI+saDEbhC3CKptn9lWARx8rOSRhn8wOs94q?=
 =?us-ascii?Q?5LmBXa1Bk3Smcm+v1JURv5WQiije/CtMF2ozo21qu/bw0YeQIHWeFau22Wso?=
 =?us-ascii?Q?de0m/zvpko5YYXcWNfIuhmimKF/Xwm213Y2fbyjv59gyRkts/Uzli+rvr37Q?=
 =?us-ascii?Q?sRNXnOJWTq0OHPAJhVhwS2o3bb7zXEzaTKgh4Y9vVaIezb5Oz+YL/xV2suO7?=
 =?us-ascii?Q?Euo+P1hOvSuQ8s6322Vr0Ozg3nQgOy5ttZFI8HnsUgA7/ODpZZIWfmP96nko?=
 =?us-ascii?Q?wf9qhPE6MzNZKfcun3JorE28PtZnm3n+rSWVwbtnMkNoI2PQu0XE+vxWDser?=
 =?us-ascii?Q?HyUUKtF996bJXLYxidYBtLLG19RYJrunbiNwg4d7qvjyfQzD/z4rpOqOjVG/?=
 =?us-ascii?Q?A76f0uJeSkuH4Q2L/0SwQL5/de1x2iMgSRF5f1BHUMTAvCtTyatTDYx919YE?=
 =?us-ascii?Q?G5q91y+FpYIxaTiTjfSFc1Ne6A8r3UIVOuSEOVTOO6Rh3T0WEBCHAK5Ej6Ii?=
 =?us-ascii?Q?F3nGPJvkcqDdlQCzGhKKbpCM9ZG1+Qww2Wkt4JWp29Z0QAXUQ97RM9wo+pgu?=
 =?us-ascii?Q?s3TZ9nFl44KPj+6WzkWWaumzUlwyOYaz8pu+C06uZdwePqX/3gafL18kLmkL?=
 =?us-ascii?Q?82FD6s79dJuwtXBSxF/Ea9av1JpNmkZ9R6jmi8unwC/Ila40AnPY0mmrfrh3?=
 =?us-ascii?Q?bKLwB4Bk6NTL4cTgEYEYz0cqa8L0dQhGAdYJNXvMCi8FmwtrLeJGLQJMk9v3?=
 =?us-ascii?Q?u0djt6pKDcXt+/8t5OXzIfM5u7KgvtWNNnhG1OQbAnZLqVLga6iyccsjr2jx?=
 =?us-ascii?Q?PL2+5fndv1W+uzVkI+VwXbqwRYb/woDN6oX5XSLSXxRHIEYY4ieZxiYqaKho?=
 =?us-ascii?Q?t+w/VbIIJ+08yenBO5P6qGkCacDTgtsitD4sTGuNdfB6+A7pNsEPptVoarop?=
 =?us-ascii?Q?t1W7EtFUs1MpEM4o+hoE7hZUz1/NxZqtLziM+u/wP7k1IhofCp6x2ABjg8Mn?=
 =?us-ascii?Q?pzLLUwQ28s3tzL8s4WIMI3QUYxuJLUGnv27sLowOz8nu5EUbdgOG7Xv/L3IQ?=
 =?us-ascii?Q?kdFfFrqkBca7KGMWj+XE8fHzJGloD8UKAQl4vuK1rro/k+4LDtbrBApmc1O7?=
 =?us-ascii?Q?KBSVlaVW7K20YTvZdBn4PF7mxhzpUfL/wyZfPHVBJX/J9+OuKBfpSeM/tmhA?=
 =?us-ascii?Q?c289H3aa1SkjIm5j7g81K947COm6Fro=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1fdf46-107e-4953-4138-08df21705722
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:04:09.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04QHrEaXfF5fMizlk0jg/gW5tXAd8J7Z0gwUx/i37e+4yHJCraxYwgi5kiUYPNb64AeV3L6rFgcfFUJ8us4ksWMjV+J2aCV0ChMSKIY+O/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB8007
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
Acked-by: Conor Dooley <conor@kernel.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

(no changes since v1)

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84e6423d89..0edc7385fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1793,10 +1793,11 @@ F: target/riscv/xlrbr.decode
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
2.53.0


