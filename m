Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5804C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 01:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfBA-0006jr-9e; Thu, 01 May 2025 21:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAfB8-0006jZ-0J; Thu, 01 May 2025 21:27:02 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAfB4-0002NB-0G; Thu, 01 May 2025 21:27:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4tkWU3nDawLjhY4/mJ5L3PrswtvOQ6hOSZsCAn2M15YbPZI1BmCDZPVPv7bQDcz4PCK6lzshRMYqwFtlzJBwPfcZuHzOMzaJSFmSqDrbuXKwbZYALWIwgxaHR2wwZuYilPIji2foIu9VWbp62gSI+UVprrMJL4t6CNNdhTfuQIWfjLGLs/HhqIBMCdNYza1aTnCbklqB3S1qJ9UnjsnCFysoTj98FseAbuyxCa2G/Q4yNWtP35VGcagkSP7nYKbKLSU5bjeR98iNxZVSbEClrqBWeY8JRO2zYZf39+OachgwN5RglH/49NEI2R7RGrTl3jZRDxeCFmY64kAm4Lw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YsQ4BvEVPHLX4RosbKDSTPcP/IScSudHSuYt+EQTXY=;
 b=dtPs4bGNDv/20dSIT6OxSVnDZ5BWhRy9dIaQzRdQVmyYDKjzHHvctWT+qzaXY0sCiIkN7IL+MWcN24Kk1kxhTy44ph8anXzSpcwy4V0ceYX66YJmqYLRODt6fV0b/m6mFiETV0hNLrG/jgJ/2d1bEFwm8G6LpiQ0eKY6t7qvt82MX3oEIwGviTi0NKlUqK+UGsK3UI48D2x2w6tEMrBaZpw9M/o6CBT5KC8wVqDbZF/OSJUiFcci805jwBeOqNv4mNCN+m/lcWTfkPCSnx+VFVqAvcFQr+blv2Ms0cPQI0zrUoTbJk1qej2LiDVPY4AAr15k6qJ6xwon84/fX1LL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YsQ4BvEVPHLX4RosbKDSTPcP/IScSudHSuYt+EQTXY=;
 b=TEvMzhad1rk621vvPs2Kc4VWufrDVGBfLwUs9wtyiE51ks4ilTy/awCLjk4f80JHfkc8UrfaqgfZR+49knhbCouhzBiWOwgAerq44d/EDTC7m5iCvWP8aaWlO8xUGBx/BB59On2WB89tX/dGC95/hx2Uoe1G7um+rrNCKytdC2RcNspaIHeK/bmLORpuWXMQPImpza5+4ZXXSLeZBHkV4cFqUX4abMGU98iNJeNYwSg3fymc8lic0ni55Kf28OzbqW/YApAVlNwQDNOBIrxSnqiNB2WFII1H0m0N71jF+XyNA5rWk+0MwQpG1JypubCqZAqvrSF6pO5eD6RILumLcA==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TY1PPF4A2CDB296.apcprd06.prod.outlook.com
 (2603:1096:408::910) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 01:26:48 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 01:26:48 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 8/9] tests/function/aspeed: Add functional test for
 AST2700FC
Thread-Topic: [PATCH v3 8/9] tests/function/aspeed: Add functional test for
 AST2700FC
Thread-Index: AQHbuOfENHSUVuZt+Euxi8QhXbZfOLO79GYAgAKbKTA=
Date: Fri, 2 May 2025 01:26:47 +0000
Message-ID: <KL1PR0601MB41806161725933AAFD074548858D2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
 <20250429091855.1948374-9-steven_lee@aspeedtech.com>
 <6758c398-7827-4ca0-b36e-acd2225dbfb0@kaod.org>
In-Reply-To: <6758c398-7827-4ca0-b36e-acd2225dbfb0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TY1PPF4A2CDB296:EE_
x-ms-office365-filtering-correlation-id: 67eef99f-b18e-45ba-5856-08dd8918685a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amE0UC9Hb3kwVjU3VzdiajdzZGpOUTcwbTdWbzArdjJjRnBSQlIvcW9wenYw?=
 =?utf-8?B?bXRZaUNGVlJBYUsvUWpqV2lwVi9jMTdpbkZSakpiNGJKYkZCNnFQY0RNL21J?=
 =?utf-8?B?THdvbnVUd20xQ3BkQitTS3Q4Y3JJcEVVWlRsWThKTFJ5Y1g0UWxMYUpGbFhu?=
 =?utf-8?B?eDNTc2k2NXN5V0UvZEx1ZVhZK0dQMi9jalhrOEZjdC9sUUFPNDFRUFUvdmU3?=
 =?utf-8?B?QjlhbUpjY2h0MUxtenZOZk1tMFF4QUZKMHc3VGxYaUVwYjNXMldrNkIwWUFw?=
 =?utf-8?B?YnBSNXRkaXJpQ3czTlczTGZRNUpiUGVzVWJDZG4ySC9OMUtHTmNNZjExK3g1?=
 =?utf-8?B?anVBSnV1dzdieGJRRGpuaDNQSDZ5THZVWkkyOE5kemt5eTVQWG5pdUVickha?=
 =?utf-8?B?bklFZzFqWUlCUis1ekVHcnhCTm9wUlNPNkU3SlN0L3V4b1h5ZjVrc1dPWmRm?=
 =?utf-8?B?Q0hnQkc1VElFci9ncGZsSXI2V1B1M3ZjUm9zR2Y2TDk2L1VUZkFFQ0w5RTZn?=
 =?utf-8?B?akFvTnk5RHUyalhpSnNvUE53WWE2RzZxS1A2aUV4aTE0cWVmZ0dCenNMSlNZ?=
 =?utf-8?B?bHNKa2NwVTVNUzFZckFQZHhmdHRFcHlOQ2RtSkpKR21BVzFTT2VYMmtmazdQ?=
 =?utf-8?B?QVZ2QjlRd3hVcGxoMmpzc042WGhzK3J5T2tnN0ZEUkVpbEVuVERnSkVIVVpj?=
 =?utf-8?B?RDFIL1djNnptNTlKMWFnOHoyQjhyQWIxa0lueHJxaVdpWWZ5bCtOVk96RmNN?=
 =?utf-8?B?V2gwZUs3Y1Rzdm9hSTEwVFVMeldCc0xyMkpvamhuSDM3RnVpcXhDeUdqWDFh?=
 =?utf-8?B?Z3lhSEJUZThFUE9kcS9JczVxSGVsSFRPQ2hMczdDNUpwTjZ1Z3hLR0NaUm9O?=
 =?utf-8?B?eStRcUJlU0Nzelloa1NGejRwZjU0RkRFa2ZXeWFIdGhhWFlLdEVGakhzYk0w?=
 =?utf-8?B?WUZ1YTZCYXN2SUZpYTR5YkpkSmZOV1l5VXEvYjFENGZJS1BjYis0TVBDN0dw?=
 =?utf-8?B?dWUxU3VoR1UyRFh0K0ZKZDNwZldwa0RPYklsK281V2VLWHdlU2pndTdib1E4?=
 =?utf-8?B?czdQQ2hWQ05GU1dndkhDbDdhY0RFZGZUYmk1K3J4cllOUEt4bnpaVVhtRE1Q?=
 =?utf-8?B?alhnbThhcU9PNWxjaC82YXVhNVdYdFdvU1V2T3hUTW9TN0o4S3dNMDdQTURp?=
 =?utf-8?B?VENNYlFmVnQ2LzZneFJseDc3eXJRQWxWN1lqRHprYzVDK3NuNVNSbnhFb2Rs?=
 =?utf-8?B?UkV4MVhJYWgvYnBnNVlnS3MraU5zL3dTQlJQUnk5VDdiYXZjc3NBVEplSnd1?=
 =?utf-8?B?THU2cmNLOGEzb1ZnMzVtczJkQnIvRGs2V3FUQ0pTKzdUYTRGYlFPbGV6ZTJ4?=
 =?utf-8?B?d0ZFODZKNFRzZ0Rkb09majM1R2Zjc2hkVFBienE1SUlISC81MjB0VTQrL1F0?=
 =?utf-8?B?Z1h2SnF0aUZ1bjRBYkRlZTgxUzhsaEdrYTdKMXgybmdxZHNySlZ6YkFsR2Yr?=
 =?utf-8?B?NDdTcktiTHZlRXYzVWZoOW9VRUxjTVJVNzNIemNSSzJKSDNFZmJUMGRWSS9C?=
 =?utf-8?B?UlNrcmFuNVJWY3gzem1xRER4ZGpwYUxPYllIU1R1UEJKR1E4TjVORlp4VWZG?=
 =?utf-8?B?UGRLRUlrSWN5dTBkYmp0Ty9MZDNFY2xjekQ3N3ZzZk5tVExhRndZMXc1TjEy?=
 =?utf-8?B?eU9aSW5qaFowczlJVGRMTmpNVDBaNUxTMWtXWVVGWWtCaWNTSHUyZFR6VkxR?=
 =?utf-8?B?Rk8wL2JyNXBRbVBhYk84YzFDOWd4ZDQ4ZUo3d0pkbnY1L29qS1ZPZWJHODZp?=
 =?utf-8?B?TE5zWStxQXB4bnliRGJScmZPUFpIVUxJTS9idzQyVmpGNmFNc3FLKy9UWWw4?=
 =?utf-8?B?REUvWGdRd3NyaXNNdmk4ODR6MjdEdGIyVUlxV1pFK3ZRS25ZTkZLVk12TnpR?=
 =?utf-8?B?akZNdDVsdEZOOXF3Qjh4S2tiV0R6OVArT0ZCTWxBc09wVVQvQmJEQ3NnV2xX?=
 =?utf-8?Q?W9yboJrtkRorp8NudmVDgZHzpOjJ4c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJDK3RpL3hGUFMzRkloY3ZyWjIyd25XeHVtb3NBMFl2dWRsTWdoTXA5My9R?=
 =?utf-8?B?WG1tVnRSNHVHK281NHJFMkorMDlFTVZtTEU3VWlLajFvMktaRVd5aFFqd3h2?=
 =?utf-8?B?aVB5SU12YWpWaUlPSUZXTEt1MDFsMlRJOVJRYW93RExuOVl1RUJobXZZcjVw?=
 =?utf-8?B?UFk0OHFDMXhEVkFNR2lETUMzVXhyR0taZXRhMFBWTE52S1d4bzdIY1VSQjMr?=
 =?utf-8?B?M0IvTkpVYjlJWThqUmx4bktxUkdjeUNvYzVtTDl2TVJjbjhvaUNYV0hrcGpQ?=
 =?utf-8?B?eFNzUFNaZUsvVDJlMGt6bmRIb3pMSTZQVGorbjM5ZjZySmJsa0F2YW1oZVBV?=
 =?utf-8?B?VDV1dkhyYXZoL24xWGlwTlpEZlhnbEJ0emh5aXFxbEhJeXNLT1Vpd0w5Szhu?=
 =?utf-8?B?ZituRk1BYTV1ZzhCUXVRRVYrdVExVW41TkFpdWkrQjJ5a0RPUFoxY1FrYTFR?=
 =?utf-8?B?WlYvejVpRi9pd1NWN0NHOVFwZTlWSzc5ZGZzQXdLL2pUNWlTTHRTSW1BQXFL?=
 =?utf-8?B?WnVUcGtBWHRFb25rSWZBdnUwbm1zUFZWdDdBMmNBTEdVcUt6aWdaMkJEKzJh?=
 =?utf-8?B?KzZLZ3FmbXhWQTZJZGs3U2Y0d3VhZ0hjRHlXRE91cjdJREkwOFNXMkRZeUtW?=
 =?utf-8?B?TndJU1VLTGU3ZC9qbDhhOHZBZE8wZEpoc2Q1cVFtdFE1em9jWC9EZ2V4azNn?=
 =?utf-8?B?dldqYXRSczJXalZmR0Y1ZWRNYmc0QUhXblhwT1RJQ0hmY0hJdUh3RnlsWEdF?=
 =?utf-8?B?STZSeVkwR1hKRGRzTmd3TnZjbjdNelFlVTA0RE5kdWh0TnJ2NXh0a0ZqeUtP?=
 =?utf-8?B?SS84YWd0MGk2TUc5T0dnRWpkaFd3Q1ozVWh6alFBTnhGRVQ1Wnhaek1JczN0?=
 =?utf-8?B?V1VOZ0xkSDFLL21zR0Q5MWpWclcxUjZBVURpNmtFZVltdFV3WTZDZy9lNFlq?=
 =?utf-8?B?Wk1oRnc1cTdOa2paNUlwOUVicWd5aGs2MkthTkdrcE1JNXR4eGtCSktGY2Iz?=
 =?utf-8?B?cjExVXpORVFJdW1tdUdYLzhOdDgrYklUUElvQ1kvZWJlMm1lRkNDVGkwMHRU?=
 =?utf-8?B?MEVod21uQSt4Y09OWTlWVVordCthM1QzVGpLTWVMRHR0Ykc0aXR4OUExU0d3?=
 =?utf-8?B?RFkxV1pTM1JwQ3daeFVhRTRRd0ZNa2s5bG1wdG9GMGlIV0YvUmZuS2p3V2dB?=
 =?utf-8?B?a3grNHdCeDNYYmlQbjNMT0pha0NpWlJ5bTNpRXRVUXVXb2ltWXBGdjVHM25o?=
 =?utf-8?B?enVOQWt0QXF3OHJ4NSs4OHZQcXJmU3BUZ2dCWU43b0pQVHZrSFNXNkdMUHB3?=
 =?utf-8?B?Vzl1YkNsTk9HempTN2FCSzluS2JzRXp2YXlaUkFGUm16SlFRV2JJNHdsdHF0?=
 =?utf-8?B?N3hEMm12cU9TS2J4UjdUTmNzUDNEZjlETVc4TU9mNDJQRTZYem1MREkxK2Yx?=
 =?utf-8?B?ci9wN2Z3WklNbko4RlAzQ3lMM1JaSHNtSHB1b2ZDREtIMDMyV0JOcDM1WVRm?=
 =?utf-8?B?TVpZOEVMb0FqQUdyMlR1ckdKTUJqdSsyYmd1VE1jTGwyTUwvYTdpcGhXWDh5?=
 =?utf-8?B?UG4vTm40SjdEc0tWMUplSThaU1JuY0ZVYm05cWZzYXZYVC9tS01wQWx5OXFq?=
 =?utf-8?B?RkhXNjNOMERCbnNoeDNNZW40ZzlaM0UrRHhFVHVPVlJKR0lDSTE3SGhPSkla?=
 =?utf-8?B?WmVJZjNTcU9PNHpzZ09SVkpwOVBUOFExZ1lray9Jb28wMU1EVW9Ca1Rlbkla?=
 =?utf-8?B?UlRFaUc2UytwMW1CbkQrZWVwWkIrOEZ1UGxqd29KcVZRekJtOW5kU0Fub2dB?=
 =?utf-8?B?SjIwVFhJVzk4WURiNWxFNDNlQnozOFRsblJJZ2YrWThzWm0wMXpoY3JGNmFs?=
 =?utf-8?B?a095YnlXNnhRREpNbkgrR05vSHl6WDFROWExSHlzOXQ1TkhjamN2N0tJTzRx?=
 =?utf-8?B?dXE2MVFWdzQxQ0E0R0JiclltTFBCTCtFZ24xL3BvTnR4c0NnT2tDNldFRGxw?=
 =?utf-8?B?OHNDa0lySW0yWnBHN1BlZnNrKzVidDAvdk5vS2ZKTFdLNFJKbER3cEw4d3pY?=
 =?utf-8?B?dmdZakljRjBrQWIxdzczN2ZzYzFyQ2V3eVgrNWh6MkhDNTlSY2tWaFRWS1lX?=
 =?utf-8?Q?r4WSzhjvIoUk/032Jtv4bWRPA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eef99f-b18e-45ba-5856-08dd8918685a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 01:26:47.9382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEIJQeTEoOBFz68KEKCcxsa9iMwH3dZvQHySg+ScezFbEr3P0YtGPCueEZBW8Je771BX0IuzDmJzINYtKdDCCt2uHTOmboyw7CR04h19cig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF4A2CDB296
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMw
LCAyMDI1IDU6MzUgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDgvOV0gdGVzdHMvZnVuY3Rp
b24vYXNwZWVkOiBBZGQgZnVuY3Rpb25hbCB0ZXN0IGZvcg0KPiBBU1QyNzAwRkMNCj4gDQo+IE9u
IDQvMjkvMjUgMTE6MTgsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+ID4gQWRkIGZ1bmN0aW9uYWwgdGVz
dCBmb3IgQVNUMjcwMC1mYyBtYWNoaW5lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RldmVu
IExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEllY2VkMjQ5
Y2Y0NzE1MTVhMzNmOGY1ZjUzODZhMmY1OGQ0MzFmMmY5DQo+ID4gLS0tPiAgIHRlc3RzL2Z1bmN0
aW9uYWwvdGVzdF9hYXJjaDY0X2FzdDI3MDBmYy5weSB8IDEzNw0KPiA+IC0tLT4gKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTM3IGluc2VydGlvbnMoKykNCj4g
PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3Qy
NzAwZmMucHkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFy
Y2g2NF9hc3QyNzAwZmMucHkNCj4gPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2Fz
dDI3MDBmYy5weQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5kZXggMDAwMDAwMDAw
MC4uZjdiNzkwN2ZkZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi90ZXN0cy9mdW5jdGlv
bmFsL3Rlc3RfYWFyY2g2NF9hc3QyNzAwZmMucHkNCj4gPiBAQCAtMCwwICsxLDEzNyBAQA0KPiA+
ICsjIS91c3IvYmluL2VudiBweXRob24zDQo+ID4gKyMNCj4gPiArIyBGdW5jdGlvbmFsIHRlc3Qg
dGhhdCBib290cyB0aGUgQVNUMjcwMCBtdWx0aS1Tb0NzIHdpdGggZmlybXdhcmUgIyAjDQo+ID4g
K0NvcHlyaWdodCAoQykgMjAyNSBBU1BFRUQgVGVjaG5vbG9neSBJbmMgIyAjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOg0KPiA+ICtHUEwtMi4wLW9yLWxhdGVyDQo+ID4gKw0KPiA+ICtpbXBvcnQg
b3MNCj4gPiArDQo+ID4gK2Zyb20gcWVtdV90ZXN0IGltcG9ydCBRZW11U3lzdGVtVGVzdCwgQXNz
ZXQgZnJvbSBxZW11X3Rlc3QgaW1wb3J0DQo+ID4gK3dhaXRfZm9yX2NvbnNvbGVfcGF0dGVybiBm
cm9tIHFlbXVfdGVzdCBpbXBvcnQNCj4gPiArZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0
ZXJuDQo+ID4gKw0KPiA+ICsNCj4gPiArY2xhc3MgQVNUMjcwMGZjTWFjaGluZVNESyhRZW11U3lz
dGVtVGVzdCk6DQo+ID4gKyAgICBBU1NFVF9TREtfVjkwNV9BU1QyNzAwID0gQXNzZXQoDQo+ID4g
Kw0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMv
ZG93bmxvYWQvdjA5LjA1L2FzdA0KPiAyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0KPiA+ICsN
Cj4gPg0KPiArJ2MxZjQ0OTZhZWMwNjc0M2M4MTJhNmU5YTFhMThkMDMyZjM0ZDYyZjNkZGI2OTU2
ZTkyNGZlZjYyYWEyMDQ2YTUnDQo+ICkNCj4gPiArDQo+ID4gKyAgICBkZWYgZG9fdGVzdF9hYXJj
aDY0X2FzdDI3MDBmY19jYTM1X3N0YXJ0KHNlbGYsIGltYWdlKToNCj4gPiArICAgICAgICBzZWxm
LnJlcXVpcmVfbmV0ZGV2KCd1c2VyJykNCj4gPiArICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xl
KCkNCj4gPiArICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctZHJpdmUnLCAnZmlsZT0nICsgaW1h
Z2UgKyAnLGlmPW10ZCxmb3JtYXQ9cmF3JywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICctbmV0JywgJ25pYycsICctbmV0JywgJ3VzZXInLCAnLXNuYXBzaG90JykNCj4gPiArDQo+ID4g
KyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiA+ICsNCj4gPiArICAgICAgICB3YWl0X2Zvcl9j
b25zb2xlX3BhdHRlcm4oc2VsZiwgJ1UtQm9vdCAyMDIzLjEwJykNCj4gPiArICAgICAgICB3YWl0
X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJyMjIExvYWRpbmcga2VybmVsIGZyb20gRklUDQo+
IEltYWdlJykNCj4gPiArICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ1N0
YXJ0aW5nIGtlcm5lbCAuLi4nKQ0KPiA+ICsNCj4gPiArICAgIGRlZiBkb190ZXN0X2FhcmNoNjRf
YXN0MjcwMGZjX3NzcF9zdGFydChzZWxmKToNCj4gPiArDQo+ID4gKyAgICAgICAgc2VsZi52bS5z
aHV0ZG93bigpDQo+ID4gKyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZShjb25zb2xlX2luZGV4
PTEpDQo+ID4gKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiA+ICsNCj4gPiArICAgIGRlZiBk
b190ZXN0X2FhcmNoNjRfYXN0MjcwMGZjX3RzcF9zdGFydChzZWxmKToNCj4gPiArICAgICAgICBz
ZWxmLnZtLnNodXRkb3duKCkNCj4gPiArICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKGNvbnNv
bGVfaW5kZXg9MikNCj4gPiArICAgICAgICBzZWxmLnZtLmxhdW5jaCgpDQo+ID4gKw0KPiA+ICsg
ICAgZGVmIHN0YXJ0X2FzdDI3MDBmY190ZXN0KHNlbGYsIG5hbWUpOg0KPiA+ICsgICAgICAgIGNh
MzVfY29yZSA9IDQNCj4gPiArICAgICAgICB1Ym9vdF9zaXplID0gb3MucGF0aC5nZXRzaXplKHNl
bGYuc2NyYXRjaF9maWxlKG5hbWUsDQo+ID4gKw0KPiAndS1ib290LW5vZHRiLmJpbicpKQ0KPiA+
ICsgICAgICAgIHVib290X2R0Yl9sb2FkX2FkZHIgPSBoZXgoMHg0MDAwMDAwMDAgKyB1Ym9vdF9z
aXplKQ0KPiA+ICsNCj4gPiArICAgICAgICBsb2FkX2ltYWdlc19saXN0ID0gWw0KPiA+ICsgICAg
ICAgICAgICB7DQo+ID4gKyAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQwMDAwMDAwMCcsDQo+
ID4gKyAgICAgICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICd1LWJvb3Qtbm9kdGIu
YmluJykNCj4gPiArICAgICAgICAgICAgfSwNCj4gPiArICAgICAgICAgICAgew0KPiA+ICsgICAg
ICAgICAgICAgICAgJ2FkZHInOiBzdHIodWJvb3RfZHRiX2xvYWRfYWRkciksDQo+ID4gKyAgICAg
ICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICd1LWJvb3QuZHRiJykN
Cj4gPiArICAgICAgICAgICAgfSwNCj4gPiArICAgICAgICAgICAgew0KPiA+ICsgICAgICAgICAg
ICAgICAgJ2FkZHInOiAnMHg0MzAwMDAwMDAnLA0KPiA+ICsgICAgICAgICAgICAgICAgJ2ZpbGUn
OiBzZWxmLnNjcmF0Y2hfZmlsZShuYW1lLCAnYmwzMS5iaW4nKQ0KPiA+ICsgICAgICAgICAgICB9
LA0KPiA+ICsgICAgICAgICAgICB7DQo+ID4gKyAgICAgICAgICAgICAgICAnYWRkcic6ICcweDQz
MDA4MDAwMCcsDQo+ID4gKyAgICAgICAgICAgICAgICAnZmlsZSc6IHNlbGYuc2NyYXRjaF9maWxl
KG5hbWUsICdvcHRlZScsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICd0ZWUtcmF3LmJpbicpDQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICBd
DQo+IA0KPiANCj4gQ291bGQgdGhpcyB0ZXN0IGJlIHNpbXBsaWZpZWQgd2l0aCB0aGUgcmVjZW50
IGFkZGl0aW9uIG9mIHZib290cm9tIHN1cHBvcnQgPw0KPiANCj4gSWYgc28sIHlvdSBjYW4gdXNl
IHRoaXMgYnJhbmNoIDoNCj4gDQo+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11
L2NvbW1pdHMvYXNwZWVkLW5leHQvDQo+IA0KPiBBbnlob3csDQo+IA0KDQpZZXMsIEkgd2lsbCBz
aW1wbGlmeSB0aGUgdGVzdCBpbiB0aGUgdjQgcGF0Y2ggc2VyaWVzLg0KDQpSZWdhcmRzLA0KU3Rl
dmVuDQo=

