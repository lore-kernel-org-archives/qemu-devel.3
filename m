Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E89C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKN-0006sU-6K; Fri, 04 Sep 2026 11:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKK-0006ia-Mp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:59:40 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKI-0004ae-BC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:59:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeTftw0t4iUxPnoPFDNR3eP75sx0q2ZtperBxjA58nM77f8Hu7DF6IW8FQumeu2AwBhUa5/IZc1WRIOKdsu3xmz8NOeNaWp7UExoXNbT5zixr6Wi1kKna5FmNw0Y0lXS0pUKVzLNUGOwfdH3v9XQbYMC8whKNkauFHWEmrUvfou1zH1vWSqPoJ5ysViMC7bqW0WHB9L+VpjhE1RLYEa5hSAQWY1bFI4NHFCR795l6zljzVnNMkrk3rEaqRlgEo7jL4YvKiS2SeJNiI53XuAnMD3qvX4kYdWjTn0tssAaxlBKvYqRSfMh02SDTuUS7ZOLP7AZKG4G7F3Fmnl8vYLGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH+6aCBKi454AsIqwVnF5k6uB/Rq9OmB20wKyKEMgV0=;
 b=yyqz2aqRhz+8R92QUX07NX89Ly0TqOXgoSKu/EM8J6BmmGz0+avqRqXypjoM+rjfqqObjSnQ5ByRbUcwggMp7j/pFP99swcjCUxBBYFyUl8UzaKWnlLpGVXYwiT5xUhKI/TeyO8MhZq/RUwUDtEMerydHdRuk8vnBiyEFwsLMxSTj86DuyS9xpWmaN2CI02XmmPmj4o7+izlt4Hihlje07j5ycj/tmRCcbC+Z2PGHoj5y9fLH/G7rZhvgVg8IQUZGWkQI7/a8vJWRCKoVLDXNv+QvcshFTNmb38+gjMuNuXkMqYiwwTuhW233rX8/RFXOsBAInXhS5/2s6XHTU1c0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH+6aCBKi454AsIqwVnF5k6uB/Rq9OmB20wKyKEMgV0=;
 b=Xr+DUN+G0JG9JsPZ6RPZVvvxtHsoVI0eVZyLqnidkZY3MRhzn7BxWvoD5mwIKNytowYrdShvlERfpNjaicpszD6LsCBaSGtoHc4pzOcVZ9z5d5A7cUiSkxKjVXHduPjlqXt2psQQ2eEmrvAMsnrYg6bFqbbe+F2wE6jkTdeA8zz7E8djF1HYs2goQ8mHERLttRP165JUM1m3DncEn9XhjV6rYkn3LQC8NuDIuAws4uKae+OfxtU1+f3eeMZVeTpNWPx7IHweAt2gFgHAZWDItun7Sw83Pvgt6X8EUnYIP0UGr0+gqd87MgEuSDq+vdkNdrfYFX7XjM973gEY0jyl+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 23/24] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Date: Fri,  4 Sep 2026 23:57:42 +0800
Message-ID: <20260904155758.3833179-24-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de2c2e5-7856-4c4f-8c05-08df0a9d7a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: XESt8q+SHRMJVFsjZcaRiKJQO6zCHTL+T+EVY0qhkCK0rgltCJYKGoL7woJO5ZpQd42BGEP71n4hbTIgxkdXgiPp0XZFXW8hILzfBER76uGoNCsZHve03gPBZf9OpLvc4I5D5DBTUCxJ7KUBfhOejeEwJrhSsDc7B/NLdytsAN4WZe/S/KdO0X7YnbQa53VP6ERCRIH1wVoqG6lvMgT5qN5yjCU8Z93MNg6WCUL1QHep7mdJF2fB9HJjmIbH67hq9enTR9qJhlzELgJ4itu3P0iqKT9l073P556b/NaEiLpslry6SlGYxM9JJZF3MEUQbE3D/XPP3CzH2SjI9uDkYZeQxueVeBJtAqle4EsL23bx+HFHlGLPLQx4v8TIOr1BegXWbZD7tHxjegVLJtNEqPQ5VH1nWIR0VXgy0tYXamgb/6UkmWL3sRum96QtgOj2+JyvmymzZAK3pcrYJcR9J8L0kPvo4JoTA3DhYHwYDWGl3DiHgGAIKvVVIIq7P8QL1uSgASPhKbH6L2I8wNpd1s3Fd8Mkjk+zZ/Z0krsJtmfZJkpNW2t8ArZ74sf0RDBw0ndOffy9aohwLrE70iiN+NhtjMM3mch0BsNbC7Dg9hGvbQ0HlufjEQVX6mAaDKG3pXzvTjs8kVMdeOFPcVAzxKBJyAoDKheD44BNz9ODUU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLeQTwEfC8VZO2iv//S68QxWE//LFFxSlSZ6KDBxCtn139XKcbX/Lq/S3JwG?=
 =?us-ascii?Q?JXBg0OT6ojgXzyNGFWph0bIEp/ZQzEALQwR+pbIYVxnFaQi0oSG+9iFbmQEu?=
 =?us-ascii?Q?ql5xyin1AL4Vv/O0Ra31IxZcSzP16+u5Ltm4CZdkY48rwAKq1TOMMyFaIFpE?=
 =?us-ascii?Q?rle1WGPhX/wU0pm40k2tJQ5vUhDNugPYnN9TXoWL6xn0v3UvWygohwWl8DWn?=
 =?us-ascii?Q?9dlkGwPLprMkPYD8ySS4V+/GfbWnwb9V/+U3W3jQmwRjql4HkITdoxrogJFv?=
 =?us-ascii?Q?THkQybxO6/22YaH0ot/+vqteIyaBmEOiBjWrA+MNl1HhYHMopWLpTt4KnfLo?=
 =?us-ascii?Q?S5vui8197cIUhZjrY+S8/u8V7/xG4eZETknvbxWi3gxu8lXvvT9Y+wVleQNa?=
 =?us-ascii?Q?EVUR4T8ik2/KdyI1YW9qL8mwDMOsFe55/sTfLyaWm7znC1wO3EgKi2gRwWEe?=
 =?us-ascii?Q?pn24F93xPRAxwmim7Zc6Lp0mJ5qOyN/Oq+KnpCc5CeDOg4zmxAoqiZlZ8btd?=
 =?us-ascii?Q?6r4olRWvuEQaHq9BKXu6w/2KyUuzJzntB2ZYYguD9yjbZUbdBczC9A9e4beZ?=
 =?us-ascii?Q?0gArioMUqcM13N5rHkA8yxsa8kt3tVLwsCuvbGkMnFzqzo+5nqY1NAXyROjl?=
 =?us-ascii?Q?R9a+IdHJUCbOvwXHGOjNkHezQ6MQEt3PYWaDqHwWkV+5XzHMo2hwpHbEm9Cc?=
 =?us-ascii?Q?vwBP6X8mxJKJDsCml2P0McLUQnIHLIX+7F2poFcyaCdtd7yTCKDca4kkNumU?=
 =?us-ascii?Q?hAB/ZTflgpGiUrsmzonAFvtX+idcPrhPbjRAUQOjl/WRUnpG1vksKnSud4nX?=
 =?us-ascii?Q?mi1U+l2Qw4Wz/jJTBLHrRObs9D23u8hgkfihFrwEc7hQ8bifOLEc+M57PpXm?=
 =?us-ascii?Q?Hz0XujiOEHXxQWO1vNfaHz5Dezy9sFSfU3xzteLX8/omEzfpxkq3oeq935M0?=
 =?us-ascii?Q?cWLXSETtFwTZxhn7FPdz1BJaIamjuzH5AqJ7beJdh/ifPx2nsKYtzGUWT/o0?=
 =?us-ascii?Q?RLiq3oUTTw77RZhIKi1bB/shr2Q+FGMzjOJ92k8VGzT3ivwmEg8DyjLFEsxz?=
 =?us-ascii?Q?QDE4ouA7IfBe5rmR7MBpw4BEX6MOZbXrek8IH0sEd225SwJxzpoxGexXw0xS?=
 =?us-ascii?Q?EXo/tYMIYoKqdghVX3v+WGgV7ngugsOHt2a4rSXcTD+w9fsyhYvbvDCAGali?=
 =?us-ascii?Q?BSS4pxKzRqdwiVlrbVmXUKcYwVcwvGEXLpLd6zepB/MweRhdhvNWf4ZSiDbG?=
 =?us-ascii?Q?sQr5zQXSDuuRYqDDjAsEU7OTJMKMrIVHUZxTDaQT94BGzN+gQRcLvrd69lVN?=
 =?us-ascii?Q?D/8qhs8G2i4LLivKQRomiPhi+DyzV4glOqavmSQE1nUxwpRa2QDXk7EeAl4w?=
 =?us-ascii?Q?XxEkuoBeXwLa2XuusEKPz0/qdMQjvYYjkS5jyMEQbNtuZ/c7jCEx/i9ApjOV?=
 =?us-ascii?Q?wQ2+EuVQoi36i1xjFHcBpTC5X+n1j1r8L/VVVVr8rohp7wWU8WMi+Exafa33?=
 =?us-ascii?Q?1lBSOkgso+KlmhRgndDJ6p7eaeO8WOioBixq7SvwJb2J7F/ldjJItw1TYFOn?=
 =?us-ascii?Q?QCa1lSUHKpglsmGSAGjadIBgwPpx5+WrQ3ElPqCRYZe2Gvafz1arwrFMkDjh?=
 =?us-ascii?Q?2x8XsDssujDpy+rpczFpCZRwLwngJAylCIIRMqdJ1IRZURTBl9oyHvn6mehS?=
 =?us-ascii?Q?WzbC+ikQ91JsC7vUCmhAIzBhMLjP4Y+IOMkotLKVazmtNf9769v9Z136lWIp?=
 =?us-ascii?Q?cmh67uliZtZcSUzZfCJEi3Ivw+P7jFM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de2c2e5-7856-4c4f-8c05-08df0a9d7a14
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:18.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKHVuucEzzpji8M9opE9Nz4awk9hVAc/dR4ZeSVOeQ0Ry0zQJtvWs6ANd9MI21EuAr0HOJGo0aIa/3hWdRFXkvTbZ7OUzwtar10aDbm++Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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
index 319b436480..e68e7eb12e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,10 +1786,11 @@ F: target/riscv/xlrbr.decode
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


