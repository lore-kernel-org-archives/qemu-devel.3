Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2643CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcXW-0002VW-Un; Sun, 31 May 2026 05:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcXO-0002SD-NH
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:55 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcXL-0000Eq-Cy
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlUiVC2/3zSj+PqfGa7kHXNRvdGIW0+pP99vhXmUWvLOpmkG0kv6d2moVaONSKlNj75A4A7/LdetuYxI4C3aXulv3Iv0dml968qWTgTeuflyDU4bgQ6B/QV7akoU4goXxgVw4u3kw5gD6ZjCxFhyi64JUy8Pm9akwz9RTzhl8oLDKO6UOEg8a7f8nQ1T62rzBMaTfYe5HmNriI72eoPZshnN9fmX1opxZDv6A2YR9a+A4C0pwZ3PGbKmj0aPf71hUX9E32wdt2GS7z9OE3EkS0tMcf1N6DUzDrLd1I3CQkhrLaaOstyl6lOv5NibpD+q5pzHXtAAyMjSHd5WXOedYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJdJTbBqRSqdX/+mUYCZR4hPt7qnh7E1UAqJQUc/tes=;
 b=bo45HmZOhS4nVFMoHWYi9fYMdNBaqHmAojohDxUcoyRQ8D9jGIQO9IhohFM3yWau0FhDvX7Wkd1vqow2QFGXvUc8FePvXRwxGWEukqWwtk/0r6qCbEFl0goDV+jFBrge9+iVq2vyhN5y6Q2a2T/HdNWj0ZySAw3BTXu/W8T+XpTIEWwz/E3Zkfd1eE5MNJmEU6DRF6N7wFQqYQFP4QkFf6/OF8G/zOlelPQAdabMyZVWGJJ1NKYKxKBN9e/6WyYSB/cWxVvUSiRLFGiAFqXT7E+mUF90zutA8igOCMgTwxPf870/xbg0Qz3R/wetBqcwBxcy8+fp1LeP+AzePap8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:53 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:53 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:01:00 +0530
Subject: [PATCH 09/10] MAINTAINERS: take over TriCore and add peripheral
 file paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-9-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b661ea-23d3-4796-072b-08debef77358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: YVjqZaOWI1mMm6rvYz+fQjriYsW+B8fANrRBxXz8a4iIItoi9dN57Sgn0CT8H3LlIMxExSDoEuO4AC4gQXAtlFHU2hYn5HyKcu5YCMCZdey9ztD7wBfRKY1EFVGSsij6hEs73eH+ymwvdaiJUEbcFdzhJvAUgmscn0299r45/ha6OCRPkvNc0mFZa5XnMhN8QOgm/gy65FkxU1yxb+iOfECa0sQ+Ex+E1GRKpVhi6bTEEaRQ375pryPsRjjBEwi4WANzRRi1p3WpwZcbUfDInJOsRayZ5w9PzVdHGcRYCGkwP/wMQrtPF/z7W6Roeh0HNPBYK2HOZ7XrDgNVSTAOqSWsrrNpOUFoZ/JjeEAhTOPcu+VDVlVn2tps//NaT8kJOnoViKl1UAlHQbzUwksVE77T/n1lx9QqDQ1LW5J8mnSABiiMx2yaQT+OhSy7I4Z6NTITXesYw0A3oYewfVbcppd/yBgRwlodxBFKAabaDeDX5MN1lIK605uYk16X61FMa3k6YCrhfFMu7H43Yo9KqtmVKc8UV1LTOdRqG0GpvogLk9rJ2zHh+L2Q70N+Vxz+iTnTsNiKwzTgA+rboX3sBhOZHSuUo6qH3bYn/FSxl7maWz9m7jDnLm+M+mnQuwRRAN5M6liD/647OOO27OYdTyCOGzUHU122XbUlAhx8N8+/gAZyIaac+8rEwSsAah6S7FFgtzx8Ex1K/FyGHf2jkbaPmM4OtzTf5acSHryMcarry/ZCRKg/jokl/lXfFZj8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFuUGI0ZmhjS2hDMy9vSFRDcGM3bVFnUVlTTGUxTy93bE5jV2tJNEEvemNz?=
 =?utf-8?B?MlM0NDZ1OUgvWmZrdUtrMlIxNUxGQTI3QmFod1hZZ3BWbUZmUzVhcFJWUHFX?=
 =?utf-8?B?K2NzQ01rYUtNdVExSUhDcEJJZUVyQzFIdVlUT21mSVdoMXM1djd1TXJpSXdB?=
 =?utf-8?B?K1FGVW1oNXFFT2ExS3BjVFU1MW5sanVENldqdHJSbTRWWkc2VC9ra0VGa01R?=
 =?utf-8?B?My9RT1BrSnYrM2Q1S3NQZ01lTWJSZWdSRVhwc3NQOU1yVmpubEh6K096bTI0?=
 =?utf-8?B?U29Pdlc2Vno1OWxUNkRFZElWcS81MDB4UG9aYmpTWWU2VTkvdU1HNVF6K0Ni?=
 =?utf-8?B?c2Uyc0VzcnpqUkx5UHJxWDNFVlVPRWJpZ2FLRkJtSjBMaFMyeTl0dG40bzhR?=
 =?utf-8?B?VktaY21vNkhMQk9CZGN5bXl2aHNaSDJ5MlVZWG5TajhEbktMNlhTdGVkSkEz?=
 =?utf-8?B?UnNNci9tcDNKTnpIVWc2cTRrbUUrTHNmZXAvYmlZeDFMak91SnkrdW9wWmls?=
 =?utf-8?B?TWZRL2FzaW55dGVEYnRSQmpySzB5VVBCUlBuVldBY2ViSFJQVmZrOXlvanhU?=
 =?utf-8?B?L1gweHFhS0dpY2ZTeTV5TFdRam8zOWlvV3NzcTQ2NzhIRTdaQjJ1QWV0MnNW?=
 =?utf-8?B?SkdqZVhjbzNFellxZzF5UHBoRlF4MEFySlB2TGhvbEhiUkJzY2NzUEhTQjVU?=
 =?utf-8?B?dTVHaGhjZW5QQjhEODIrZnJnbUhYeURVKzRUSFloYkxZRVJQNnVQOU9zL2Q4?=
 =?utf-8?B?VHdLYWROV1I0TDhCUXVrUnFYN3RDYi9HRFJPZnlSd0tIVWxtRjJsK0dsZi9t?=
 =?utf-8?B?L0FVZ3R1YTlseGF2ZjNpczBmWWFYTXNwbjVhR1BjQ3JJeVI3dnFDSkRCbXhI?=
 =?utf-8?B?aUN6cUdVazhHUWNaVTB0eUhlNWp6SGR5SmM5OVBIMnc2WVZoQzJjd0lIcTll?=
 =?utf-8?B?bGpEcFRqTVdjd3RSWWVaVGdEZVZhOERGR21oTk44WVprbFppUUExREh4Y29E?=
 =?utf-8?B?QmhTRWNjUkNVaXNLcm9jNWNMclpFUDNTZkVGR2dqTW82WkJWVXBDUE5OWkhB?=
 =?utf-8?B?Z1BjQktkM01LRXdwSjNCZE5JSzFHU0JiNTZobWJXSTk3RncxUS9kZWlvYTFt?=
 =?utf-8?B?aFJqMEZybE1ydlNSWjN6Vk9rVTFYRTN6YnlVVmlBYVR0MHJ2bE5nT3BWaHEz?=
 =?utf-8?B?K2JIYkJQYWp5R0lldGQrY0tpOXlxYS84L1phNytEb0JyTzhadHRwTVU3aUd4?=
 =?utf-8?B?SWd3NFR5aEgyZFBhVUlaa0xiM0pSWlRZWTJpLzhVT2x1b1dOWXNsaUhoZVJi?=
 =?utf-8?B?S1BjZmYrVVpRdzU2Y3AvNXZJdWZaeXAxU1VqOG5Oekx0MlNUb0NxT2QrVkU0?=
 =?utf-8?B?YTlINWhCOG1OQUxSMlhid1VXY2NRT3FJQ2Y4aVBjVlBwZzhwbk9mVWp5ekMx?=
 =?utf-8?B?RVJVNjVacTFjNlh0aXlQNFoxRlc4V21CWXovNmJRMTJURlBRMDNIZTBoRWF4?=
 =?utf-8?B?WTlnUDVTR3RVakFKL2FVUy92ckRJNkdyQURYcXErSHhaNXBkMlZ2UFFUbG1k?=
 =?utf-8?B?dVZnZHczMHJhMzBtcjVXWmt5YnE4djZ6MkprZnA1MEcremJRV056SVp1aTVE?=
 =?utf-8?B?c2tIRUpFZDdDMnZpWjFFVndVUTJZcUF4N0JtY1NtWVhZcTczZGR1enRZelNm?=
 =?utf-8?B?UDY3NzhyemR2UFpLU1c1WkpGZnZoa3RQd1h2RUl1WUZzVUVLYUgxYWpocTJa?=
 =?utf-8?B?SjV0R2ZlVitaYVcyV1ZLa2lBQjNIR2wxS2c0NnZ2dzhHZkhRRm5kcWcwNGVQ?=
 =?utf-8?B?YXNuUzRiUkJCS0s3RmpsZ1UxMDJXNXFKSUxUK0F6emQ2MXZoM2pScllWR3Qr?=
 =?utf-8?B?Z1BGeDhFcTVvTndqNENxV2NBdUQwMkRHWXlrVWZTc2JVUHFjRmtuOEExWE1m?=
 =?utf-8?B?ZkF1T0IzZkNwY0pKSndTM2w3OFdmWklSd00zSmwwRmJOUW5GSjFzVFkyMEow?=
 =?utf-8?B?U1liZ2JMTkVOMy9IMWlLZkdaa3JLY05zVE04b3Q1aXREQmZWelFnSlRKYTQr?=
 =?utf-8?B?VGF4MlQwU0RidDQ2NUphRml4bi85eExKZGNvZ0dROEEzL0N6bndwMkhkZUFR?=
 =?utf-8?B?eE5ZSmpqOEpZNFFpVEtQNldiTmxidDRQZU9oM1ZxcmlDVEJ4L0VYa2UwSWVj?=
 =?utf-8?B?QU8xTTFPNnBrSEd3endxUXQ2SU9SYzh0YjhjMGM2dDBpeXlnOUJiTVd2M1hy?=
 =?utf-8?B?UGhiMTkzc2dKTGlKSzZvZWFrZGx6bnpCNzhURjVmK25oN280Wm1PVmJzY3pl?=
 =?utf-8?B?K3JBMFYwNVJYNDdMNkF0VjFpSVFWd1U2RGZXeHVuYVpOYytYc09Gdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b661ea-23d3-4796-072b-08debef77358
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:53.5306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLo5vIY+1vJCyx22cncVisOGPXxnYcDtGIOjn7Ejwlk0oGse+/vFpfJnk27wGWnxmJHtTe5B/FqbADFxPbGXcg==
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

TriCore was Orphan.  Add maintainer and register the new
peripheral files that live outside hw/tricore/.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7752917d8c..489be83fb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -454,10 +454,17 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-S: Orphan
+M: Parthiban Nallathambi <parthiban@linumiz.com>
+S: Maintained
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
+F: hw/intc/tricore_ir.c
+F: include/hw/intc/tricore_ir.h
+F: hw/char/tricore_asclin.c
+F: include/hw/char/tricore_asclin.h
+F: hw/timer/tricore_stm.c
+F: include/hw/timer/tricore_stm.h
 F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 

-- 
2.47.3


