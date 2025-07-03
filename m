Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAC9C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEbb-000475-Kp; Thu, 03 Jul 2025 03:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uXEbR-00046U-Us; Thu, 03 Jul 2025 03:43:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uXEbP-0004gH-GJ; Thu, 03 Jul 2025 03:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKV2rrM6oDZRjuvDWkU8JXvlqHwAc1JnR54yR4H7oe4Ax3R7/SDhUCRzZhSABzQ8KaQp2Md61rn95YTox3C1EPhHZKyb0F2L76AyDMC9ZxXHesRShhqBL1BAF4Okkrxj7AL7F/bduxwWR6Yfea3R+JrrFeJGwK6TiNcULsrJqLwQMeHVFXPh0mNFQEui1j+6b4jcJ0U+FfTK/RLMHyAtIB2lOsaFFYVOmEdKWnSXsqqfdKVT6Z25HmoxIAepLl6khxwoNjwkWRDwIjPrtRL0lCpabiFlmLXUEjz1aUvLHUHeXD0Cdpbfu3LPJQ1vQSH1n8BEAfKkzg9qM54lsiBVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOVjTfM8lPOuepbXPThPUFgzNLKPE1kGl40fZJaWTd0=;
 b=lEudRlqLC6tuMzVSrCBJqSLstCfuVqL/y1NBxgQbLJ9Efp+8zYHHcH0DqMHjVNroDrfIv5TrkIp5iobyJTkiZtTNKWRpM++zHdSHlLu44GlDun1ZV6k9JEpa0FHlAHZigzdppm4ogJvrzUrQq72/kL8KlwAi37ZLG4cog9DYt7gWcZGrz+8cSe9P+CSezuBI9XGsl3yNnr7aX6uV23KabPfBz7SKVTMAcbm0KT29RnXe9dwXlT/pB4cOuJgg9pWGb4h3pc083E2yrcH8FFbGGPOZ50eeVI+HcxB0aSc86NJkv1H6a9aEf05MSOMZu3e69Ht4dWiZikuKKm72+pLa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOVjTfM8lPOuepbXPThPUFgzNLKPE1kGl40fZJaWTd0=;
 b=opUZtIioC737EjaQ9aNT4x+si01xNuAGZV6w/4F/IBhX5jhGC+MSkNTbM7bxNP2yPVmI0PTloQUwkFTGSvI3FYYssKsvIelfRBcK6O/iUv+RHZ7x5cDmDZE10c+4rKw4hbYZlBSUSiRt3x5yvIJzjT88MlishAsYqqs5mYSmmR+Vh3xsnAWVdXP9HDVU82g1XhnGeCpeBppWOicgMgE5RGr0LOdfNwS6YGf38+HKGBNqcMjTAH/D9I9U9zuU+N0KqD6U8YHQTjj2iGzGW4Io0cVPIY7bFFP1tl06VH0CO8vEgOHnU43SQ8rsfzyb8vsjPntQJGLRs+h8Fne3bzwnwA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6324.apcprd06.prod.outlook.com (2603:1096:820:99::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Thu, 3 Jul 2025 07:43:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 07:43:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 00/18] Support AST2700 A1
Thread-Topic: [PATCH v1 00/18] Support AST2700 A1
Thread-Index: AQHba9K4uIwzG6e2E0KIgXebc6jl4LMwjV2AgOyWFICAAeBlEIAAXb4AgAGikUA=
Date: Thu, 3 Jul 2025 07:43:14 +0000
Message-ID: <SI2PR06MB504167DC9727E91F92198F84FC43A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <096e8152-ec19-4b2b-aa56-dd566ce7bb6d@kaod.org>
 <9534dc4d-fdf6-418d-b5f7-9bc7f03bf7ec@kaod.org>
 <SI2PR06MB504195531936785FFA2CA4BDFC40A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <f4b1f8ae-691f-49b8-847c-19cac9445668@kaod.org>
In-Reply-To: <f4b1f8ae-691f-49b8-847c-19cac9445668@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6324:EE_
x-ms-office365-filtering-correlation-id: 1be598e4-4d00-48b9-7edf-08ddba054480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Rm0rV3JPZW5ZOThlUllpa1RqTCtxTmtUTnViWHMwYmg2cktZTHRPeUxGSGl4?=
 =?utf-8?B?SWlSamcra2FEQ0doMjduQWQwaFphRWIzSklRZWUxZDBVYzByWGNoVjJSSFZR?=
 =?utf-8?B?b01ja0FBL1N2dEhwZXFBbWh1aFdxMlRDS1BjQk5oZmRNN1lOcW5LK0pIa0Nh?=
 =?utf-8?B?Y2FuQXVheXVOSWQ0L2FZNzY0bUFRZGZwZ0srQ1Jia1FlOGF0a1hmVmNTMGZ3?=
 =?utf-8?B?eE1hbUc3V0t1M0huaTJYMldIa0Q5Mk1CODJmaUhjU0lkaG5xSGtRUVcvdmJv?=
 =?utf-8?B?c1dwUkVSK2Vsa1FMcnJhd3JmeUVudUhYcElvaEorNmtxWUVVOUZmK1JXdFpo?=
 =?utf-8?B?M1QrNjRkNGMydkdBYkllekpkTU5MUjJjdHNrendGOW9Ea2F4bHQreCtKY1BV?=
 =?utf-8?B?cnpnWlpiOXM2K2VVeTZFWTM3WExiOUFzUWUzbEVNU3gvZGJ0RW9zRERiNTJr?=
 =?utf-8?B?ZllpViszaUNVL0RpZndyS2I4NVJVaVFsUEpkejNaOWdPUnZ6ZXpOYUpTWDlY?=
 =?utf-8?B?YUpRRFFlQkRRR1hyc2ZpZmhJVUFMZUE1SW5TQm1DcGtUaWNqTndPS0ptdU5v?=
 =?utf-8?B?cW4vTktPUnAxUDlsKzNOUnhpb05yMSt2Wm9JMEIyVUlObVpCalRhMFdiOXJ6?=
 =?utf-8?B?S3JBN054Ty8vd0dkcjlsQXNEWWtFVlJ6N2MwOHpxck9hSHUxZ3N0dVNUSnJm?=
 =?utf-8?B?aXZ4dTdYaDVjMzJXcC9HWHdHckJDbmZoNFdhaUNuL2JFeXVGZSt2QTZ2cS92?=
 =?utf-8?B?VjZFOE0vbWlhWHRDa0cyd3pUNS9jcXduSFVmeGtFT3AvOEFIT2VGK2NYNUtS?=
 =?utf-8?B?dkNnSURkYS85TzQ3WmdkemZXMUFPdjdGZ0VGLzMraUhDS2RFR0syOVFmSitB?=
 =?utf-8?B?ZWd4MDMyc3d2YTdEaGxPb2crTmxaRUxvSGxFcEZjL3EvdFM0cXBCdHg3YzFr?=
 =?utf-8?B?VmdaTytjc3JOaGVhZWFzMVBmRURjc3M5L2dvM1VPcHhGbzh6ZDJ0VkVCSno0?=
 =?utf-8?B?Wkp3Ull3T1lOd0QvS3dyVVZrTGtCOEpXY1F3dU13ODNPVjlEamdDQXY2L3hS?=
 =?utf-8?B?T2RVc1Z5ZHU3aXdXR2tGUG9nejVDT0xSNmFCbW1kNHdrTXVFLzBiV01qektq?=
 =?utf-8?B?SnpTcFVrZ0NpZFNLY3FrbDkwbVZNQUEwYWRRUDlCdHR6Z0ZiZlFDY2tXQzVU?=
 =?utf-8?B?SFI2VEhSMjcxb2tWYlZWQWtiaXppSzlWR2lrd1cyc20xdHRETXpEdEtTMTQ2?=
 =?utf-8?B?UFcxcG45SFM3a1ZsdTVpZEdFYWtSaHZQSTJ1TDBmak81S21seVhyNUJrNGgw?=
 =?utf-8?B?TFFzMSt5NVdodTJHbmNEUUlxek9TKzArVk9lTUd6RFpiQjJTT1k2SGdPdHZO?=
 =?utf-8?B?RUFWak1rSHZmck9pMTM5K1RaSUhMZHFoYTgya3hCZCt6UVl2QVcrQzI5dml1?=
 =?utf-8?B?bDNiWWQxaUVEYjRWaFVyOXRYcDNFRWFtamh1WldNRWJ6QWNwaXJZVUlrQ1R0?=
 =?utf-8?B?RllUM29CV1VmejZiVTN6dXY5R3h1REZWMFFVdzYvQVVnZ3Q1Y2RyVmE1cXp4?=
 =?utf-8?B?MXR0QnRFNnVKYVVoamNZbHRod250bHRiVlErVkppRDZyUU5FTUpCWmEzTzcv?=
 =?utf-8?B?TnZIUG9oT3RidlRrOEhXSm1na2FJYUttV2lhN1RSKzM3d055WCsyQ2xTaTR0?=
 =?utf-8?B?TUVtaWFOYWVDdkR2M2M4NnQ3M2tKQnpQUUJjNGRXblQrbUVORElvQ1ZMcTVS?=
 =?utf-8?B?dEVacWpBMUduT2EwanJjNGc0VDFGUDhZR1puayt1azljdXFVT0tGVTBML0ds?=
 =?utf-8?B?amt2OWltWUJrL2Y0TXBHbUkxbVcvK3pWc2VrVEdsQWEyNnpnVFhVaDlyQ2Fa?=
 =?utf-8?B?Q3hOaDRVZC93aWtjYkdLNEwxNmlzeXFlaU9FTFYyUlV2WFNmb2Ewczh4QWU2?=
 =?utf-8?Q?W/SOUm+/p34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJxVHBnRmhhMXhZS1JWb0JZSjF6amdpQURiZHlKdTIvMjZPQWtHTmFyaTc2?=
 =?utf-8?B?Z1hnbm9VRGlOQTR1Vk9WTGNwWHk2VEVZblNaTFVDN0tqQ0tkTWQ0VXd0UGhL?=
 =?utf-8?B?a0VXbjFCVEt3bEIwVVNmTVVCbTc0dkdnRnF2NXZYZ21DN2NCSXF6Rno5N05x?=
 =?utf-8?B?OUc2TnNlT25LTm01OEJrNmpGRXBUbUJ4K2xlZFg4Vm1NdXhPZ3VXMmk1ZXN1?=
 =?utf-8?B?aGxWVmEwRlY3cXpoWG1hWmt0NlptdmFSSEVRNFJrYXFrNUU5WmYrNnpVOGhm?=
 =?utf-8?B?MDZzbGRqL1J3djVwd1NTYlpCWHlHeFJkRTZNUXZXTm1GWVhJVUNxeFJXNDFx?=
 =?utf-8?B?N0pKbzlOMUMwSS93a3lidkZQSGhEQXgydEpmRWFCMUFoMDRIVWdhQUZWNmFW?=
 =?utf-8?B?czlsMW41QmJFVERSMStveXhMZTMwREc0Z2czaVFGd0lOaWlDdk5RV255UDZi?=
 =?utf-8?B?ZG1SWGVqUUFwOWRNVHhoMGxoWW9iYmRlS0JpbjE0VWxFVHlVbWxHcHpFblNY?=
 =?utf-8?B?bDAyQXg5SkxqVkJqeFRGcEZ0YndkZy80d0FsbWtNSWxXNzRVYnlVK0MrTEF5?=
 =?utf-8?B?alQreDE5RTJ0dmhuNXBYSlNZODZ6MG9jdVEvMHd2UkJ2SGEveitvaW9vWUZy?=
 =?utf-8?B?UUJ3OWxHNkh1R0ViQXArZnpwYTY2Zlp2L0g5QTlqYXFnQWFXVUdyVUxKMlhk?=
 =?utf-8?B?Z0hLTTdtWG10dWhXWFJoa2JRRjdZZGpXYmpLeTQ0WHpWcmJmY2hCa3ovRU1Y?=
 =?utf-8?B?a1BmQ01TNEo3TmF5Ky9HMytrTFNubllMVU0wR2FiOFo3SWFFSUhPa2xvMEFz?=
 =?utf-8?B?NlRJYWY2RkVHa3VveGJrNXhhRUJIdU44YTg3U0ZFWGZZaTlJUmJueVN2Yzgw?=
 =?utf-8?B?d3c3WGY1WU4xNDhqQzhKVzZMOFpHZElZNjZ2OW5GN3dEU0VscHYzTCs4TUhh?=
 =?utf-8?B?NEJQelg3RnhtVysxU2ZsZ2h2WVB1RXpWRWlTYnkvSTJ4ZzByU2g2dkhDQkl2?=
 =?utf-8?B?R3hoVThUZnJmd1Byemt6Qk1UZTE4ZHdnbEh4MXNxZ213TVh4OCtQUGhFUmZT?=
 =?utf-8?B?RnNab3RodmZtaTNSbXZaK2R2Mzhra0E1TUdRRklMODhzaWtUUEpFS3ZKKzlm?=
 =?utf-8?B?V2tDY1JYOTJuMGJ6bElpN0ZEMDE5VmN6QVBVclFLNUNBbVVMZ2p5bWtjVFox?=
 =?utf-8?B?MWhlMkZYcnA3eG1RYUtFQWZVRm4vcVVlamVoMFlpOCtpNURJTDZGSHFBcGky?=
 =?utf-8?B?NUg3TWw1MEdlQVJOZjVuczdiSmMyR3ZQdTNUcExDNnFPTkZsK3dITzFGTVFx?=
 =?utf-8?B?eEd6VGE2QjlZK3dEZjJ1R0Q4QXZDSW5OYVBIWElTa0EvL1VyUnJHL0piM2ln?=
 =?utf-8?B?YXVweUpaNEhVZUFjaElpUDUzTzVlZWJYSVlRcWlEd253VmFMODZ1bHI2akNF?=
 =?utf-8?B?WUNZV3JwRmJEbFRUbU05TkZid2h4a2tPUjZxSk1xUjZEQXQ5cnhFREhaRFNI?=
 =?utf-8?B?Rk9FUHZHamdaRzdzbXhhK1gvM1RXemJQT0t2VzIxbWJEVExmRWkwTi9PTXY0?=
 =?utf-8?B?NmtzYWNHVnR4eVVkMnhVQ1puUnpENmNCNU1LbThqb2h2R0hxcldHZlFmMWxu?=
 =?utf-8?B?MjU3eUk0cDZXc2NmTWVWbHJrYjRYOUc0b1ZqbWxJYVl5dWJscFVqK2pFNk9Y?=
 =?utf-8?B?QnVDRG9MMjVIenA2dEtmRVNXelVubUYyWVNOMTgzb0NoNEZ2QmY4RStlTzUr?=
 =?utf-8?B?akg2NmlURTlsMUErcGpPWlZMWG5NOFp1ckU2QWRFYkwwWDFYbW5QUEpNS1pV?=
 =?utf-8?B?ZjhleUlTQndmWTN0c2ZQUmtyd3RrTU1sMEdXREc2K3ZxcmxSQUhTcUF6ejN1?=
 =?utf-8?B?TkNza2ErV01ZY0VwQmRsWXhFakpoWHViK1dWb25LMkl5TVdONXRkVmx3Q3FS?=
 =?utf-8?B?MG5MNFd2a1NBVjB5UEc2c1c0SE9LR2JHQm5ZWUpKZGNmUkkxL1h0aFR0aDgv?=
 =?utf-8?B?R2RCVDI4aCtpbSsyVWJ5LzFUY1hsN3FnWk5XT0ZKV0U1VDZSUTA1UDRqVWho?=
 =?utf-8?B?am9JakZKanIrWlh6dmtoU1liK1h0WG1pbU5HUXIzUVNISlR5dW9qL005T0pk?=
 =?utf-8?Q?M3ISmQ18rLP+CUjtKFP4y7JpW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be598e4-4d00-48b9-7edf-08ddba054480
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 07:43:14.3182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhYQEiyGIcYS2OcshXXaRzIdDkMvYzq4Jgeb/5Rh2YXNIPU6s4+3dXU4DgZj9EpbG/61ou8yQ9uE+fm/jvCKLDBcXEhMZ05Ec9P8mlX3lLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6324
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAwLzE4XSBTdXBwb3J0IEFT
VDI3MDAgQTENCj4gDQo+IEhlbGxvLA0KPiANCj4gPj4gU2hvdWxkIHdlIHN3aXRjaCB0aGUgYWxp
YXMgdG8gcG9pbnQgdG8gJ2FzdDI3MDBhMS1ldmInIGluIFFFTVUgMTAuMS4wID8NCj4gPj4gYW5k
IGRlcHJlY2F0ZSB0aGUgQTAgU29DIGFuZCBtYWNoaW5lIGlmIGl0IGlzIG5vIGxvbmdlciBwbGFu
bmVkIHRvDQo+ID4+IHN1cHBvcnQgdGhlbS4NCj4gPj4NCj4gPg0KPiA+IFNvcnJ5IGZvciB0aGUg
bGF0ZSByZXBseSBhbmQgZGVsYXkgaW4gcHJvY2Vzc2luZyB0aGlzIHRhc2suDQo+ID4gSeKAmXZl
IGJlZW4gcG9zdHBvbmluZyB0aGlzIGJlY2F1c2Ugb3VyIGN1c3RvbWVycyBkbyBub3QgaGF2ZSAi
QVNUMjcwMCBBMQ0KPiBFVkIiLg0KPiANCj4gb2guIFRoZXJlIGlzIG5vIHVyZ2VuY3kgdG8gcmVt
b3ZlIEEwLg0KPiANCj4gPiBTaW5jZSBBU1BFRUQgU0RLIGhhcyBkcm9wcGVkIHN1cHBvcnQgZm9y
IEFTVDI3MDAgQTAgYXMgb2YgdmVyc2lvbiAidjA5LjA3IiwNCj4gSSBiZWxpZXZlIGl0J3Mgbm93
IGFwcHJvcHJpYXRlIHRvIHJlbW92ZSBBU1QyNzAwIEEwIHN1cHBvcnQgaW4gUUVNVS4NCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcvdjA5
LjA3DQo+ID4gSW4gYWRkaXRpb24sIEkgcGxhbiB0byBtYWtlIGFzdDI3MDAtZXZiIGFuIGFsaWFz
IG9mIGFzdDI3MDBhMS1ldmIuDQo+ID4NCj4gPiBDdXJyZW50bHksIEnigJltIG5vdCB2ZXJ5IGZh
bWlsaWFyIHdpdGggdGhlIHByb3BlciBwcm9jZWR1cmUgdG8gZGVwcmVjYXRlIGFuDQo+IGV4aXN0
aW5nIG1hY2hpbmUgaW4gUUVNVSwgYnV0IHRoZSBmb2xsb3dpbmcgaXMgbXkgaW5pdGlhbCBwbGFu
IGZvciBoYW5kbGluZyB0aGlzDQo+IHRhc2s6DQo+ID4gUEFUQ0ggMTogVXBkYXRlIHRoZSBhc3Qy
NzAwLWV2YiBhbGlhcyB0byBwb2ludCB0byBhc3QyNzAwYTEtZXZiIGFuZCByZW1vdmUNCj4gQVNU
MjcwMCBBMCBmdW5jdGlvbmFsIHRlc3RzLg0KPiANCj4gVGhhdCdzIHNvbWV0aGluZyB3ZSBjYW4g
ZG8gd2hlbmV2ZXIgd2UgbGlrZSBub3cuDQo+IA0KPiA+IFBBVENIIDI6IFJlbW92ZSB0aGUgQVNU
MjcwMCBBMCBTb0MgYW5kIGFzdDI3MDBhMC1ldmIgbWFjaGluZQ0KPiBpbXBsZW1lbnRhdGlvbi4N
Cj4gPiBQQVRDSCAzOiAoUXVlc3Rpb24pIFNob3VsZCBJIHVwZGF0ZSB0aGUgZG9jcy9hYm91dC9k
ZXByZWNhdGVkLnJzdCBmaWxlIGFzDQo+IHdlbGw/DQo+IA0KPiBTZWUgaHR0cHM6Ly93d3cucWVt
dS5vcmcvZG9jcy9tYXN0ZXIvYWJvdXQvZGVwcmVjYXRlZC5odG1sDQo+IA0KPiBGaXJzdCwgd2Ug
dXBkYXRlIHRoZSBkZXByZWNhdGVkIGZpbGUsIHRoZW4gcmVtb3ZlIHRoZSBzb2MgaW4NCj4gMiBy
ZWxlYXNlcy4NCg0KVXBkYXRlIGRlcHJlY2F0ZWQuaHRtbCBwYXRjaCBoZXJlLCBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC8yMDI1MDcwMzA1MjQw
MC4yOTI3ODMxLTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KVGhhbmtzLUphbWluDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

