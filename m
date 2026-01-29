Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB55D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 02:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlHUu-0005pL-Ly; Wed, 28 Jan 2026 21:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vlHUr-0005l3-Mh; Wed, 28 Jan 2026 21:11:01 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vlHUo-0005aj-Cu; Wed, 28 Jan 2026 21:11:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GauwcJ1GehL/fXCouol4oQh4Ctyfl3CRnzLUafMJyzQ05+ZWhHMEwMdr+jSNhuKLLDqT6T4nYlABNqaKEIViRFBTw95TPlIWOD6FJB/Ht3jY0bFhk1jUWgCEMMjGTnQK8pMPsNw+aG8NCdyhoUVSWNhMUG9gXKUiEt0nNZbdU1g9VZiVhmaN6nl2bB1Z4XkMJA2zeVqfJmilnQzxTGe/rsWX4xFr4L1+eRUKlU81yLBkIGVWNbUDAJJLHBMM1d79iHxWCx0rv0l7bM9ZmFnWezJHfShRhCRcdw5Go8UCcLZHmTOITr60Hje1cAnx/t9V7/HcAd9Q3zazlzPNyBWy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSWMNCXyhfOtB4axBLTnoGcQ2MMASV8k5O8QDSQPudM=;
 b=TIIjdn5f9QRJyrwdafDrMJTFEHXoGG0MxSGn7ut0Pq5jACnq4T8A1iItxoHdhVSr812Xc20zaAbnVWdFH1fJ455LW41QAImdWZm6a174AJZOLnXMIVha1h359teOg92ssH8HkV9r0S5m1aVCsQXhEkhjFMChopK1HhCknVfeK6Q56YmovjaKHsydGNfiRGN4/hOzg01aIXeGxfwHJ3nVtYxizICECYyiYJciC39crJjtYYfbXXtKiy935piiVhAnKIVwrT5Kz4RwTnlLYqAymwfNP9U0njP5XN7pFvx7IGdHuQph3UwenwMLSov8BY55RNrTWa769kYYAGx/AgVS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSWMNCXyhfOtB4axBLTnoGcQ2MMASV8k5O8QDSQPudM=;
 b=WSVHNOcv4RB+9OE8Ypox0MF/P1bYn1YqUyv2eklhAper+GbALgXTPjoIa8v4T8u44o/e3EypKXENA+55RZGSsboasDAuG60/6LoB5L0M92h0Cl6xsuwFZyYlyZf5T+o4WPaSzLxhrMHZ2KGXqBHOzu1iPy+MflBf6OgXNeISFBEMmKQoDz4WXvdBgXba3SH6LwS58ZjxetIJmCb+X/oE27v4KmIrCrcUCIgkyoLWrlx9HUunD0HhxtdYbbSuYXWXmYeVZjV6+Drz2g1jLY8CtAc79rXxJQmkY0qb06Gz2i+87RGS3KtQ46lJHjb5aE6pEFyzUYACxWfO44wvFH3AkA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5974.apcprd06.prod.outlook.com (2603:1096:400:342::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 02:10:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 02:10:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H
 root-bus remap and bus-nr property
Thread-Topic: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H
 root-bus remap and bus-nr property
Thread-Index: AQHcjzxfYKjqUBqrZUaQy69YNV85dbVnZ2QAgAEBHJA=
Date: Thu, 29 Jan 2026 02:10:47 +0000
Message-ID: <TYPPR06MB8206EB053D7CCF7DC44749C8FC9EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
 <20260127032348.2238527-4-jamin_lin@aspeedtech.com>
 <a31bf0d7-6143-439b-b347-3d1cce81be9d@kaod.org>
In-Reply-To: <a31bf0d7-6143-439b-b347-3d1cce81be9d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5974:EE_
x-ms-office365-filtering-correlation-id: 99861731-7595-4b94-7524-08de5edb9dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K3EwdmFPemtxSHVxeDdidm41ak5LdnlBSmRVYWd3SlNTTnlwb3FRZ3Z6U085?=
 =?utf-8?B?MlFXb2dxbVJ0QXlKdWZkYzhJQjdzZ3JSUGMzVWFvK2IxOGlQMVladExtMGx3?=
 =?utf-8?B?Y1hkMlUyek5lK2RRNlFMNVdwaVVINEhNMnRBNWgzVW9PK0tmcktRZmlyL2Rt?=
 =?utf-8?B?T2psMG44b3VLTEZxUDFRRTNVYXlLZjJjZ29GZFcyNDV4SHMxYzBZYzRwYXRK?=
 =?utf-8?B?ZVE0UTdxUmhXMnlyemlCT1E1Vjc0dDFnSUZxY2tyOFJJd2FHMEVSYnZSc0JP?=
 =?utf-8?B?RXpPdDB0cGdHRk5PT0JlSHRRRFA3OXkzYU5adDNvbWdmaGNPMmhhNUtta0xx?=
 =?utf-8?B?Mk1sbTFSaUFOZUIzWkxlT09wekQxNGFiRlRVU3p3MDVDbkZnT0t3N2h2dWU4?=
 =?utf-8?B?R0ZYVVVURTMybGpmSlZsVC9kSFRqUEluQ3hNelZwSjI2Qko1b2tHMDFFVURJ?=
 =?utf-8?B?OEJiRFlEc0lyblQ5WDNGU2NIZlN0NnY3V0FtamREWVFSZGp4THBiU09qL3Bw?=
 =?utf-8?B?NlNUNVJEbnpHZk0vdHdIN1pRMHBTY2pudXlpTTVob2l3WVBkc0NXa0tMRDBj?=
 =?utf-8?B?NEE1bDZlQUlYYUk1cW9YN2o1b1gyUzRRbVNwdVNIZkhRSFBPQm1ZRHZzTUVx?=
 =?utf-8?B?NFFYVW9nc2lhalBPOEFtOVgwaTdkcDRtcDBHZXBjU3B6SU0veUt4MFI3MjdE?=
 =?utf-8?B?WTRVWElmVGZ2R1laUzZqbmw4eERSOW9vVzgwUkNQZkQ2NUJNT1hGYjY4cXFx?=
 =?utf-8?B?eWE3amhNdEJUQklkVC8zYzZ3Wms4S3laL0NNWkxVRTJUaERUK1k0dUFxVDhU?=
 =?utf-8?B?OTlwKzdtQ0IzWllzT3R5d3JxZHhQSUZqK0g5L3ZKOXphMzZ4bENDK2JkTkFN?=
 =?utf-8?B?clJNZ3FmTjdvOXUzcnYwVVdUaE9qenBEMUFkREZMNFI2dlBrcll6OC9lcnA1?=
 =?utf-8?B?d3R0VXc5cW13UkpMcHNGcWp0Wlk4eGZDc0JMNndzUHZtUW1QSHpCVzd6UXhu?=
 =?utf-8?B?S0F2YUFGdXF0Zm92Mm11SjhiYVZsOXZlUlFCNU1ycW1rY0xxbEdPbmp5cjRF?=
 =?utf-8?B?TEdlbzV0V3l2NWxhdzR4dXJ6WVR0NndhK1ZVTnFadkpZSkhFQlRqNHlXQUVu?=
 =?utf-8?B?cm9uWnduMmNidC8xbjMrWDA4NnJZcDdjeC9xZldvUlJscm92OWIrQzI4bmhB?=
 =?utf-8?B?UHBTb2IxcXlLaDVHSE1mbmR0bkNwNFI4Zm9FejRaQVoxNzFxenpveThxc0tC?=
 =?utf-8?B?c1VtVEZRbEVZaGxnK2pZMDhOd1psNjJUV0FmZjRibFQ0L3YwMERLOUZmZ25O?=
 =?utf-8?B?bHVBdzNWRm02VklYei9Kc1dxMjE5S0FGVVFvR0FLa3Fmd1JNNGZ6djNvMlFa?=
 =?utf-8?B?K1lVNE1YNk1VbDV1d1hsUDIzYWVhMFJwUkJTbC9SRVBpT25mb01OUHhudC94?=
 =?utf-8?B?ZDFQQWJGbGNIREZ1N0J0cVYrOFNLRzN4N2JXejhUbXlGaWJEbTVVN2JaTncz?=
 =?utf-8?B?dHJSeCtIeEl2ckJQdUJSZGN2TkFUSVRTZDVqQjFaSmpwV2NXaFkxTXB4eDRQ?=
 =?utf-8?B?NnJHd1gwRkIvSWJ0K1lRbUltRWo1bS93Wnh5ZUZ1UzNDc1NtZ3pWZzYyK0JU?=
 =?utf-8?B?OFhHY2xUMGlvUFBTaW00VkFHYUpHbi9vc2h2ZnRvT2pVbDR6d3pOb25JaytK?=
 =?utf-8?B?Z2xXZVpwcEkwYmE0UkVYWnJmT0d3cEE1YkpCeTJVLy9UQkZTc2xVVXd0T0Nj?=
 =?utf-8?B?cTBYTmJvdTFCamVUTFpiaU8vYmduUzd2bVBkS2ZUako3Lzk2eHJ4WTNzelJw?=
 =?utf-8?B?THZ6U3o0NVptSGRBdmlNNW4vQ2hhY0RLdDI4aytHWFJXV2lJbVBMeWo5Z1lE?=
 =?utf-8?B?em9jRVlUT0pJaGliU0EyeC9Fd0R6ZTZKMU92MlFWMVZVQngydSthd2NkdUxD?=
 =?utf-8?B?dnNIUzduWC8xSzhEcktLZTNJZXdVSWRGR09ybUw2R013U3FyNU5FTEZtT3hQ?=
 =?utf-8?B?ZGl5MUJ6U1c2WnVXaHhYYVN2d1V2dVlmS1AxcjJ1bW9hSHpuaVc5N2paVU8x?=
 =?utf-8?B?SHhmb3RlNURtZTh6dDQ1RndicThMU1hEd2Uxa1JjZjJiY1JDTDR0azVOK284?=
 =?utf-8?Q?lDYAl7+5A0qE4q6lokpVw7vlt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5ZR1JBKy8rcnZRK0d1SWxNQ1pRcTFGa2x3YVRIYmthV3dxcGN4dUdYN0tH?=
 =?utf-8?B?OWt4ZEtZOGllQi9qVHYzTkpDZnp3ck83N0tGWFRIRWlyd2tKWnNRZGxOVU9L?=
 =?utf-8?B?UXlwcTFjQWlOYVhYRjZucHlhdmRiTFdpMGJzTFRqRTZYMXVtbDN5V1FYT09r?=
 =?utf-8?B?ZXVReEMySTZ2QW5MODFydXdBdVltRkczZmRyT3JGR2dwbkRGSThtbUlJY1Ux?=
 =?utf-8?B?OEI2SHg4T3J0UnlycDJ2QXdmZ1VNcTRScWVBZ3V4ZXhSNjEyWEsxdm1SR0Zq?=
 =?utf-8?B?YzJVc2VyZG5rbHRRd2s2SzBhQ1dMa1NhQXpJMTBqbndZaGJIR1dSdlkzQXNi?=
 =?utf-8?B?L1BNMzQ3cU9IRlQ0QTFWTXhCUEZjSEZKRjVocnI1UWNnOWVoOE1kKzFFRmxx?=
 =?utf-8?B?TGQrVGt5TzVsbVFRSmJMcmUvN0pNQVhVZlYydmV3T2pzL0xvSEIrUm9mN0xa?=
 =?utf-8?B?Yk54YjNvS1BsQ3ZrQUgvRkNnL2FobEhZbnc5bVFnbHZ0OGM2UHJzZ0dYVksw?=
 =?utf-8?B?d2NxQUpRVlhnWUgzdlFMU1VlYllaaXp0ZFJMdldlVm4vWlpVZzdLTzFNdndN?=
 =?utf-8?B?QlpVeGQ0Q3RSbVBDcnJrZEYxc29vc1MxYmhxbWdFcFhMTkM0aFBTVlRndmxx?=
 =?utf-8?B?aHRWZUpVME9RRXhlRXVXN1VxeG5TaDhoOGF5VXhXK1FQUGJIb3hjaU9oNExS?=
 =?utf-8?B?RmluM2J3N2pGYi8wcFVXWmxKNE5iRm9wODBUWFpFQWhwS1Nkb3cweDc5N3p3?=
 =?utf-8?B?SEx3VXdIdndKWXhKbGVoc2EwMVN5SUpueWh4Mkd4OWNMM00vUWxZcXRLN1BL?=
 =?utf-8?B?VXdpak9GNm50TmNZbGM4eTZXRWZhS1NFcStwdFAwM0UxTloxaEFuQ29sM0VU?=
 =?utf-8?B?UDJVRG1pRGxBL3BtZHd1RS8vbkV3di9WS2ZMYVRjSHVtUHhvd2VIaHJrL0pi?=
 =?utf-8?B?dlNXbDZFSkdwcEFkb3M5b2ZZYndPUnBFSkNNbnF4SXhUUWwzS1lYN0dEMlNZ?=
 =?utf-8?B?SWU5WFBXR2hvUlUrdDF6RTFzNTdlSXdjQ0dhVHRGZGdyZ1N1c3JkZmJTWnRR?=
 =?utf-8?B?b21RV21mUW55aWpWeEQ3YlpUSVdYaXRMcGRjTUhQZUpXOEhIaEJlcWlza2Nk?=
 =?utf-8?B?VGsrS0s5T1J6eFhZVWlyZjBMdlFGakEwOXVPUlduSWZkalFxRXpaQU1iSnlN?=
 =?utf-8?B?b1dTcndyR0sxK08zaXpaNTNDbDBIUTd2dXVPNnRxQ3g0bFJZTWw0NVM4VzRh?=
 =?utf-8?B?cWRZam1hRVRoMnh6YkkwMkU0WjBYMURjS3RoZm5rVXBkeXdhZ3c0MkNRcHI3?=
 =?utf-8?B?US9xZE81TVBVZG9WN1dXQ1lOaEZZeTNxS25lb25qWXkxMFQ1ZDNUZ2R6VGlS?=
 =?utf-8?B?RmhNK0V1eGVVSEVQNURpRVNWMDhFM0p2S0JET2NJbnYybjU0TXlTRmY4RjUx?=
 =?utf-8?B?aC9JbEJrVHRreC8zOG4yTVp1Q3UwRWs5U0xudXBpOEpyMHdvNEQ1NWtNVzhT?=
 =?utf-8?B?UmlVcVMzN3FNUVhLaXllS3Z4UUdGUUFBbWh6SnJZYlB0UE12S3Z6bW9XVUpK?=
 =?utf-8?B?ckszbDNPWTVJWkkrNTJENmtRalVhU1ovNW9pNXpJU29qNHFPUnBpcW84QlJv?=
 =?utf-8?B?ZkNDZkorYTBmbDN4UmNBOE1uOWtlU1ErOVh5OVUybVpOS1h0dXpCUWllWjFS?=
 =?utf-8?B?NW1xcUpaVDJSQzVDVC9GN1EzSy84TEtQODE5Z1k0blc4aWtYOFpycGVqVXpu?=
 =?utf-8?B?WEd4dXFidFFaNzZuYXRFSXFpdURvYUpseEEyT2NKS0Q0Z2lTYzRva1VaL0xu?=
 =?utf-8?B?OFMyUmVKdkhGdk5OcW04c3EyR3VwTXRNajBCVUFhRTNoUDR0WHZ6MFpDZzZz?=
 =?utf-8?B?NE9kNjlGRFduSzhmM3Y0Wm1KYkZqM3Y1d2xPRzFuVkJneXRMRXloc1hSY1lM?=
 =?utf-8?B?SEFQM2MydHdSVmtKMFBjdkFveWVpUkVkTWhjd25GZlk3czVtck0rV1hGMVM2?=
 =?utf-8?B?Uk1VcmhXVU9OVGZBdlp6a3ZQclI0enJmeXhRTnZVR0dBYTdYdGtuT3JpSUpR?=
 =?utf-8?B?b1lvL0RmTTcvcFAycStFUTJqU3o2YmFxMmcwUW9rOXhKbE1RUHl1Y2dMV0RS?=
 =?utf-8?B?U2Z4bmNYTzNSeFE3ZytmSDF5UUdJc3VQMlZqbW1sNVBLL1E3MWk1MTJDS28x?=
 =?utf-8?B?Lzk2a2NWTzdSdkV4US9vdlllZ1hXV0dnZ1ZqeXljSHROeHVsVi9rWlhQUHVq?=
 =?utf-8?B?TVBhSmczSTEyWEhxZmVPczdRVllHck04S0NlbjFrNS8yVG54bE5kZE5Ia0d4?=
 =?utf-8?B?d3lvMk5neHFtZGszWWpWcEltTDg5RitNdjJ2c2dDZUhROVNYS2hnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99861731-7595-4b94-7524-08de5edb9dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 02:10:47.1614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7lgTcVnTkL1Rgdp2aah4EgQm0Er6bJgzJkaAv22t2+DTCZmKo7aqmsfrZFgsEM1q1TrKC2UBSZPkNYn7D3piDrEa4/cJaulrMcrt3uD9Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5974
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy83XSBody9wY2ktaG9zdC9h
c3BlZWRfcGNpZTogRHJvcCBBU1QyNjAwIFJDX0gNCj4gcm9vdC1idXMgcmVtYXAgYW5kIGJ1cy1u
ciBwcm9wZXJ0eQ0KPiANCj4gT24gMS8yNy8yNiAwNDoyMywgSmFtaW4gTGluIHZpYSBxZW11IGRl
dmVsb3BtZW50IHdyb3RlOg0KPiA+IFRoZSBvcmlnaW5hbCBBU1QyNjAwIFBDSWUgZGVzaWduIHN1
cHBvcnRlZCBib3RoIFJDX0wgYW5kIFJDX0gsIHVzaW5nDQo+ID4gcm9vdCBidXMgbnVtYmVyIDAg
Zm9yIFJDX0wgYW5kIDB4ODAgZm9yIFJDX0guIEluIHRoYXQgbW9kZWwsIHRoZSByb290DQo+ID4g
cG9ydCBhcHBlYXJlZCBhcw0KPiA+IDgwOjA4LjAgYW5kIFFFTVUgY2FycmllZCBhICJidXMtbnIi
IHByb3BlcnR5IHBsdXMgYSBjb25maWctc3BhY2UgYnVzDQo+ID4gcmVtYXAgdG8gdHJhbnNsYXRl
IGJ1cyAweDgwIHRvIGJ1cyAweDAwIGZvciBQQ0kgZW51bWVyYXRpb24uDQo+ID4NCj4gPiBMaW51
eCBtYWlubGluZSBoYXMgc2luY2UgZHJvcHBlZCBSQ19MIHN1cHBvcnQgYW5kIHVwZGF0ZWQgdGhl
IFJDX0gNCj4gPiByb290IGJ1cw0KPiANCj4gV2FzIFBDSSBzdXBwb3J0IGZvciB0aGUgQXNwZWVk
IFNvQyBtZXJnZWQgaW4gbWFpbmxpbmUgID8NCj4gDQoNClRoZSBBU1BFRUQgUENJZSBSQyBkcml2
ZXIgaGFzIGJlZW4gYXBwbGllZCB0byB0aGUgUENJZSBzdWJ0cmVlIGluIHRoZSBuZXh0IGJyYW5j
aC4NClBsZWFzZSByZWZlciB0byB0aGUgZm9sbG93aW5nIGxpbmtzIGZvciBkZXRhaWxzLg0KVGhl
IGNoYW5nZSB3aWxsIGJlIG1lcmdlZCBpbnRvIHRoZSBMaW51eCBtYWlubGluZSBzb29uLg0KDQpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wY2kvcGNpLmdp
dC9sb2cvP2g9bmV4dA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjUxMjE2
LXVwc3RyZWFtX3BjaWVfcmMtdjctMC00YWViMGY1M2M0Y2VAYXNwZWVkdGVjaC5jb20vVC8jZWIx
MzY3M2I0Nzg3NTI4ZDYzNmFmYTQwNzkxYWU0M2QzOGJkMTE1MmENCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BjaS9wY2kuZ2l0L2NvbW1pdC8/aD1uZXh0
JmlkPTUxYWE2NGQ0YzE5ZjBmMDBmZDUwY2FmZDM3Y2MyMzI4Njc1MDUzYWINCg0KVGhhbmtzLA0K
SmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPiBudW1iZXIgdG8gc3RhcnQgYXQg
MC4gVGhlIHJvb3QgcG9ydCBpcyBub3cgZW51bWVyYXRlZCBhcyAwMDowOC4wLA0KPiA+IG1hdGNo
aW5nIHRoZSBkZWZhdWx0IFFFTVUgUENJZSBzdWJzeXN0ZW0gcm9vdCBidXMgbnVtYmVyaW5nLg0K
PiA+DQo+ID4gUmVtb3ZlIHRoZSBidXMgbnVtYmVyIHNldHRpbmcgYW5kIHRoZSBBU1QyNjAwIGJ1
cyByZW1hcCBsb2dpYywgYW5kDQo+ID4gZHJvcCB0aGUgY29ycmVzcG9uZGluZyAiYnVzLW5yIi9y
Y19idXNfbnIgZmllbGRzIGFuZCBwcm9wZXJ0eQ0KPiA+IHBsdW1iaW5nLiBRRU1VIG5vdyByZWxp
ZXMgb24gdGhlIGRlZmF1bHQgcm9vdCBidXMgMCBiZWhhdmlvci4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAgaW5jbHVkZS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5oIHwgIDIgLS0NCj4gPiAgIGh3L3Bj
aS1ob3N0L2FzcGVlZF9wY2llLmMgICAgICAgICB8IDE5ICstLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuaA0KPiA+
IGIvaW5jbHVkZS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5oDQo+ID4gaW5kZXggZmRlNTgxNmVh
My4uMTQzYjM1NjU5MSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L3BjaS1ob3N0L2FzcGVl
ZF9wY2llLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmgNCj4g
PiBAQCAtNjksNyArNjksNiBAQCBzdHJ1Y3QgQXNwZWVkUENJRVJjU3RhdGUgew0KPiA+ICAgICAg
IHVpbnQ2NF90IGRyYW1fYmFzZTsNCj4gPiAgICAgICB1aW50MzJfdCBtc2lfYWRkcjsNCj4gPiAg
ICAgICB1aW50MzJfdCBycF9hZGRyOw0KPiA+IC0gICAgdWludDMyX3QgYnVzX25yOw0KPiA+ICAg
ICAgIGNoYXIgbmFtZVsxNl07DQo+ID4gICAgICAgcWVtdV9pcnEgaXJxOw0KPiA+DQo+ID4gQEAg
LTEwMiw3ICsxMDEsNiBAQCBzdHJ1Y3QgQXNwZWVkUENJRUNmZ0NsYXNzIHsNCj4gPg0KPiA+ICAg
ICAgIHVpbnQzMl90IHJjX21zaV9hZGRyOw0KPiA+ICAgICAgIHVpbnQzMl90IHJjX3JwX2FkZHI7
DQo+ID4gLSAgICB1aW50NjRfdCByY19idXNfbnI7DQo+ID4gICAgICAgdWludDY0X3QgbnJfcmVn
czsNCj4gPiAgICAgICBib29sIHJjX2hhc19yZDsNCj4gPiAgIH07DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMgYi9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jDQo+
ID4gaW5kZXggNGZkZGE5NTkzOS4uNGY4OTZmODU1YyAxMDA2NDQNCj4gPiAtLS0gYS9ody9wY2kt
aG9zdC9hc3BlZWRfcGNpZS5jDQo+ID4gKysrIGIvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuYw0K
PiA+IEBAIC0yNjgsNyArMjY4LDcgQEAgc3RhdGljIGNvbnN0IGNoYXINCj4gKmFzcGVlZF9wY2ll
X3JjX3Jvb3RfYnVzX3BhdGgoUENJSG9zdFN0YXRlICpob3N0X2JyaWRnZSwNCj4gPiAgICAgICBB
c3BlZWRQQ0lFQ2ZnU3RhdGUgKmNmZyA9DQo+ID4gICAgICAgICAgICAgIGNvbnRhaW5lcl9vZihy
YywgQXNwZWVkUENJRUNmZ1N0YXRlLCByYyk7DQo+ID4NCj4gPiAtICAgIHNucHJpbnRmKHJjLT5u
YW1lLCBzaXplb2YocmMtPm5hbWUpLCAiJTA0eDolMDJ4IiwgY2ZnLT5pZCwgcmMtPmJ1c19ucik7
DQo+ID4gKyAgICBzbnByaW50ZihyYy0+bmFtZSwgc2l6ZW9mKHJjLT5uYW1lKSwgIiUwNHg6MDAi
LCBjZmctPmlkKTsNCj4gPg0KPiA+ICAgICAgIHJldHVybiByYy0+bmFtZTsNCj4gPiAgIH0NCj4g
PiBAQCAtMjgzLDcgKzI4Myw2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9wY2llX3JjX2luc3RhbmNl
X2luaXQoT2JqZWN0DQo+ICpvYmopDQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBQ
cm9wZXJ0eSBhc3BlZWRfcGNpZV9yY19wcm9wc1tdID0gew0KPiA+IC0gICAgREVGSU5FX1BST1Bf
VUlOVDMyKCJidXMtbnIiLCBBc3BlZWRQQ0lFUmNTdGF0ZSwgYnVzX25yLCAwKSwNCj4gPiAgICAg
ICBERUZJTkVfUFJPUF9VSU5UMzIoInJwLWFkZHIiLCBBc3BlZWRQQ0lFUmNTdGF0ZSwgcnBfYWRk
ciwgMCksDQo+ID4gICAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJtc2ktYWRkciIsIEFzcGVlZFBD
SUVSY1N0YXRlLCBtc2lfYWRkciwgMCksDQo+ID4gICAgICAgREVGSU5FX1BST1BfVUlOVDY0KCJk
cmFtLWJhc2UiLCBBc3BlZWRQQ0lFUmNTdGF0ZSwNCj4gZHJhbV9iYXNlLA0KPiA+IDApLCBAQCAt
NDkwLDE3ICs0ODksNiBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfcGNpZV9jZmdfcmVhZHdyaXRl
KEFzcGVlZFBDSUVDZmdTdGF0ZSAqcywNCj4gPiAgICAgICBvZmZzZXQgPSBjZmdfYWRkciAmIDB4
ZmZjOw0KPiA+DQo+ID4gICAgICAgcGNpID0gUENJX0hPU1RfQlJJREdFKHJjKTsNCj4gPiAtDQo+
ID4gLSAgICAvKg0KPiA+IC0gICAgICogT24gdGhlIEFTVDI2MDAsIHRoZSBSQ19IIGJ1cyBudW1i
ZXIgcmFuZ2UgZnJvbSAweDgwIHRvIDB4RkYsDQo+IHdpdGggdGhlDQo+ID4gLSAgICAgKiByb290
IGRldmljZSBhbmQgcm9vdCBwb3J0IGFzc2lnbmVkIHRvIGJ1cyAweDgwIGluc3RlYWQgb2YgdGhl
DQo+IHN0YW5kYXJkDQo+ID4gLSAgICAgKiAweDAwLiBUbyBhbGxvdyB0aGUgUENJIHN1YnN5c3Rl
bSB0byBjb3JyZWN0bHkgZGlzY292ZXIgZGV2aWNlcyBvbg0KPiB0aGUNCj4gPiAtICAgICAqIHJv
b3QgYnVzLCBidXMgMHg4MCBpcyByZW1hcHBlZCB0byAweDAwLg0KPiA+IC0gICAgICovDQo+ID4g
LSAgICBpZiAoYnVzID09IHJjLT5idXNfbnIpIHsNCj4gPiAtICAgICAgICBidXMgPSAwOw0KPiA+
IC0gICAgfQ0KPiA+IC0NCj4gPiAgICAgICBwZGV2ID0gcGNpX2ZpbmRfZGV2aWNlKHBjaS0+YnVz
LCBidXMsIGRldmZuKTsNCj4gPiAgICAgICBpZiAoIXBkZXYpIHsNCj4gPiAgICAgICAgICAgcy0+
cmVnc1tkZXNjLT5yZGF0YV9yZWddID0gfjA7IEBAIC02NTAsOSArNjM4LDYgQEAgc3RhdGljDQo+
ID4gdm9pZCBhc3BlZWRfcGNpZV9jZmdfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAq
KmVycnApDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFwYy0+bnJfcmVncyA8PCAy
KTsNCj4gPiAgICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPm1taW8pOw0KPiA+DQo+ID4g
LSAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJnMtPnJjKSwgImJ1cy1uciIsDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcGMtPnJjX2J1c19uciwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gICAgICAgb2JqZWN0
X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5yYyksICJycC1hZGRyIiwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhcGMtPnJjX3JwX2FkZHIsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsgQEAgLTY5MSw3ICs2NzYsNiBAQA0KPiA+
IHN0YXRpYyB2b2lkIGFzcGVlZF9wY2llX2NmZ19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBhcGMtPnJlZ19tYXAgPSAmYXNwZWVkX3Jl
Z21hcDsNCj4gPiAgICAgICBhcGMtPm5yX3JlZ3MgPSAweDEwMCA+PiAyOw0KPiA+ICAgICAgIGFw
Yy0+cmNfbXNpX2FkZHIgPSAweDFlNzcwMDVDOw0KPiA+IC0gICAgYXBjLT5yY19idXNfbnIgPSAw
eDgwOw0KPiA+ICAgICAgIGFwYy0+cmNfcnBfYWRkciA9IFBDSV9ERVZGTig4LCAwKTsNCj4gPiAg
IH0NCj4gPg0KPiA+IEBAIC04MTEsNyArNzk1LDYgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkXzI3
MDBfcGNpZV9jZmdfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQo+ID4gICAgICAgYXBj
LT5yZWdfbWFwID0gJmFzcGVlZF8yNzAwX3JlZ21hcDsNCj4gPiAgICAgICBhcGMtPm5yX3JlZ3Mg
PSAweDEwMCA+PiAyOw0KPiA+ICAgICAgIGFwYy0+cmNfbXNpX2FkZHIgPSAweDAwMDAwMEYwOw0K
PiA+IC0gICAgYXBjLT5yY19idXNfbnIgPSAwOw0KPiA+ICAgICAgIGFwYy0+cmNfcnBfYWRkciA9
IFBDSV9ERVZGTigwLCAwKTsNCj4gPiAgIH0NCj4gPg0KDQo=

