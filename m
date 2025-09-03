Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BCACA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 01:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utcc7-0002Kg-Bz; Tue, 02 Sep 2025 21:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcbw-0002J7-77; Tue, 02 Sep 2025 21:48:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utcbt-0005W5-GY; Tue, 02 Sep 2025 21:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdYnL2NyTVwEBPjlQj2s49b72cKlR+QTk8jz5CuSe8sxeIYiuo1yEt9uz4dsnjjDNjd4htqsOXcb5IaSZDkd13+hpaR9qyJFSjntuGemV9at4sXfi6tta9ll6XTv3BGjEIZLA4fXsfuebAC56mc/UL0kAcrw/FvpxPEtMIcB4AShb+fdnwhBoJkN1PJX2t+6eVlIy9megnAyoT/zQvLLi68vuFWYQdteF+9L3kdCMLtxog9zB25B9X+A7z4TwCSOw/OKvN8/QfzCSthTDJSFne2xKrWvoHKsakKFo2q0FnGAhjinO9HpY5swy36WIJIyDCSEAmtSqlameLqZQPY10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPedITPF953+u+Pc1UAolTDzdLYbD0CkbzrzVCbMijg=;
 b=jtsKqqV55XhhXjvNQDeYh2xOKg2DxpGvJBiR5iK8d0Okp74FVXu9xYsdB0RltutF7JW5iLSiX7beT4xKCfT6XOZFw7RGuwcIF9w0x/bIlV9AHQxzkOpxuZKcNnvayoZRdOSnBsgx3fDjslhIXx6CBYJq7jE2zMpfcC3qS81g1a2mzkpHihstr3EXLhIREw5LW0dYkqz0COwBOm8ARCVXyA+TnGGyYqZ8cblGXgVX0pJukW/0wbAIRjqO5X0kLJQ98YlM+rHT/gYojaAfwaqmxNYWqSfgpYiO0BzSItTPk3kcI0JUgG6iC6VRdCb8vOFUaP1CEIC+sjems0QvgIrenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPedITPF953+u+Pc1UAolTDzdLYbD0CkbzrzVCbMijg=;
 b=lIZu/VsUiG5BeMCBhctDq+YCKwNwRJhe578pFlP9V8qJq+tG56oFLeDtql/tVmuTGKbhT9HPugipslYs1Ay3rMc7eT+vVozQItkh/lL0aodn/D0smflVPtmLjPjQgrNIdauubBLgwMP+p24IIvnGuS+hSe4Jc/6VOcGlAtiDNVR8o/3IK4KcFJShQ7gnX026yuGX2FLuEodSwrGfn/EQG5jIsYj6TRMLKMzEw2x8ByD2qlEZFqafi578GqbwBRXeoAe/3jEvyC3S8x3w5OBPjDb0FLaOmfuR7UZrhFQdAcs1T5rECZHnm4U+ThGCOm1KQx1m+3ZWvGHJwBegQ3YOlg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5776.apcprd06.prod.outlook.com (2603:1096:820:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 01:48:22 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:48:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 06/21] hw/arm/ast27x0: Add SRAM alias for SSP
 and ensure correct device realization order
Thread-Topic: [SPAM] [PATCH v1 06/21] hw/arm/ast27x0: Add SRAM alias for SSP
 and ensure correct device realization order
Thread-Index: AQHb9syjvZjfKnLGik2YtNyUPYvNs7R/ziaAgAEtrtA=
Date: Wed, 3 Sep 2025 01:48:22 +0000
Message-ID: <SI2PR06MB5041EB11A060329CE58ED8BCFC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-7-jamin_lin@aspeedtech.com>
 <e537fe9e-a2ba-4154-8ed0-7ece4cce745e@kaod.org>
In-Reply-To: <e537fe9e-a2ba-4154-8ed0-7ece4cce745e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5776:EE_
x-ms-office365-filtering-correlation-id: 0b3f3f59-e7f6-48a3-cdea-08ddea8bf740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?UXlIa2tLaTlZd05RcjZPenQwdGZqVFNYSHU0c0J4OTVxWDNuOFdlemltSTk3?=
 =?utf-8?B?U0hxeWZ6QUwyaC9KLzE5NXRObWFxaXozQk14WncyNGZ1aHFtMW5lRUFxMDls?=
 =?utf-8?B?SUp5K0dTbVFDMkhsSWdQeW5RTjE2THAycHZRRHZxWFF1bnZnc2huUDR6emRK?=
 =?utf-8?B?N1lCRnR3STdBOTM4N3F0Wkxaa2M0RklGRnhSK2wycFM2RW9MdDBvK2o0MHo1?=
 =?utf-8?B?YmdPQmYwYnRRd1Z3VUNVYmlsYW9UdXRUd1hjNVZuZXY4OHhFUEZKMkQ2b20y?=
 =?utf-8?B?d0dsUVF5QnpEMGNaZTlQV3lJanlSY2w5VFBkYTNpRStzYk0weHFNRjlPL2tv?=
 =?utf-8?B?cGY1VTE5elFCR2MwSWh4M29TVFZCWUVXbERJT0tJWE5SQkRWS0d2STE2OEdl?=
 =?utf-8?B?emVxblpOdHRQRXRJRWpscGZKOVdmc1RYRUtxVWZBVzY5bmpUZUZ2Rmx3Yi9M?=
 =?utf-8?B?RVNQZVd4dDhUTFhQUVl0T25FRWJaKzhVWWkzdlpidmxZV2VkR0dmRkRWNUVP?=
 =?utf-8?B?VXpGdVdQNmlScjFBcWNWRHI4R01hOVJ0Z3F2N1N4dlpSdXpDamxZSmNPdFRS?=
 =?utf-8?B?M2RlazFsaFRpSTNGWjJYM0Y4Z3ZoWXJONktLSktYeDhncVNCcno4K3FlMjBW?=
 =?utf-8?B?ajRlckJ5OHlqVjRydEU1ZVc4d1luT0NUVWNoQUhTSVc4eTZEdDdzNCtpdFpL?=
 =?utf-8?B?UURzbG9Od0R0UnR2alBuZFRTaUhveERqWmFQNDNRTjM4bE1BNU5CbUdNclkw?=
 =?utf-8?B?eUdEdFl2enFwN1VuSDNpSW95NEdzcU9yTDZFMmZBME81UEdSY2ZHdjJWZFZY?=
 =?utf-8?B?dUpEeHFNOHkxc3JqbE5aejRycGdIRU5NRE5Ec2Q0Y2I5VG1TQ040RFBodFpx?=
 =?utf-8?B?WnF0dDdnWFYxSGR2YjU4eVhzVUpRS1hiM2tsREZhVTNjTzJ3ajhMak9HbHhD?=
 =?utf-8?B?ZmxTZytWYjg3UGl4MEM4SDE0MHNERmxpUXZIZ2RKQUVDeWg2OWlMV0N3UzJ0?=
 =?utf-8?B?UkV1cmMyRENmRWRxMTNsUGd5MkpqSVFpSXZYbW5zOFBxaEd6bTZtRnZ6eW5M?=
 =?utf-8?B?QTcwcGJLNEM4TzY3QlhtWkZxMFFPV0dyUU4xVzFJNmM5Z0Q3WlZqbGFYaXdQ?=
 =?utf-8?B?bjQzNEJKelM4VmdtUGg1enJKSjVkK1pwYzl5dlZhQ1Vqb3ZCMEJHZ0RqeGRG?=
 =?utf-8?B?VUZkL3llaDA1d3FDZ2RSWnZXejNzUDBJdnE3OEFCS3AvTFFNMEhYQzNFeWhZ?=
 =?utf-8?B?QTJud0grc2JtUTBxZEJRV1A0Y3V2TUF1YWttQ1o0TkZnZzlLTnFxbUxxY1Nu?=
 =?utf-8?B?YUh0elhDb0VnRXBDMVJ1b1dxR2dRaHNvMUNWNXNsU0xTNUVqV2p5bU8vNzNw?=
 =?utf-8?B?THduSWhyVStYNmFkcXNxVnorRjZ3SWt4ZFN4TUZ4a1d6R2NPcm56TzQ4djA2?=
 =?utf-8?B?NUM2b05taTZ4SkhNeUsyemRWS2ZucEU2Y091R0U4ZDNXaUhYcGU4aC90dyt0?=
 =?utf-8?B?L1laVEhrbjRkMUV0THpCWFR5UWducjJnS3h4ZC9tUGFId29GQnFYV2tGbkdJ?=
 =?utf-8?B?ZXVBdytWVXZRcTUvK05SM0hDRFplTU52UnNzbk5HUzRpRmxFV2hTcXZHaUlD?=
 =?utf-8?B?ZXdITit4aXVLMEllYUF5a3N0Mkw4eTl5Y3k0VXVaSkJrMzRSUlRMWjAvUE9B?=
 =?utf-8?B?WGMzN2pqeW93OE9CamEwbTJYSU5zUGlHQ25pOWpsWlErZExHWTNVYjIwQTVG?=
 =?utf-8?B?bkowOVZiVU9OODJTZmFOejNDSVd0RGNMYjhoSU0rUnRjZFBnZDhZZFJDYkoz?=
 =?utf-8?B?cEUrTDJPa3gwbEluZENZMmJnWFBxYUU2VWJjbDNaQUxISTFsazBaRjZIOWJx?=
 =?utf-8?B?N3E1U2J6WDcrdzRqcFRCZmg1bzAzNzA5ZHovVTVJYkVuRktpcUdrazYwNG1O?=
 =?utf-8?B?YzlBWmtBOTgxSkJzQUtsT1R0VmJIWmNkaWdTWVpWb1Q0UHlRRGtSc2s4OU1v?=
 =?utf-8?B?SlY0R1EzT1NvbjdOeHlEeGkzZFFjTy9Db1l0ZDJ3aHg3bkNEN3YvcWpRRXdT?=
 =?utf-8?Q?MiGoLw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE9VYlNGS0VKWVZiRmFzY3VudFB1Z1BoQkZiMGtOVzZYRG4yVkRTcExYR2Jl?=
 =?utf-8?B?SlMwZlJ5ZUxVOGpoSWZDb2NzR2xWU3JjcmFuUUlHL2sxTHZIMEM2blV3WUR0?=
 =?utf-8?B?dlJDZS95djFYNW5SZUxwNTByaFFtdFVNN1hwQWZDUC9lS1h0aDhBS2VOMkw3?=
 =?utf-8?B?clJORDZJQXpRZDBacW1yd3gyL2VCcU9vTGljV2ZLWXVnMGVYeEJMaGg5cGJ3?=
 =?utf-8?B?NWZ3cmVDTGdlT2YxSm1GTXd1SUhrVnJFRWtNc05NUTgzOXNFVnFsSHpPZVZ6?=
 =?utf-8?B?YjREa2tpZk1rQkZPSkNIL3RsYnJuUlZ6YzR5RHZPU0tzNXdTVFZoZnR4NURR?=
 =?utf-8?B?R3FrR0dEL0RRSGdtMU9qdXFBaFVpRjBiSVhIOHgvSmNxbWg3Y2F6WnF1bFpV?=
 =?utf-8?B?SFVyRFlmeFJsSFVhc3BLQmN2dFczMkp6a2NnN2c4QWRMWFZjRS9tV2MvdG5I?=
 =?utf-8?B?QkNvenE2QWd5UVJhY016OFIxanRLZGRMdmlCaGk5NXUxY01aZjZQbnIxb1gy?=
 =?utf-8?B?QytzWDVaMHIrZmdXVG9oc3Yyc3YxYmticnZlaDhIbjJzZVplWTRnWURyekMz?=
 =?utf-8?B?YUdnZ1BLRjlXTzBQTlBhK29WbzlIeEFtdHZJS2t5LzJnc2UzNGhQR3hpa080?=
 =?utf-8?B?SmFMMURGZW9QSlcyeCtqR0pYa0hxQUhKS1dlVDU5Nmt2eW5KL1NtUGV1Q2tw?=
 =?utf-8?B?RGZMTFVoQm9lL2xzTjFwMXV6djNKaldqQ2JiYXpid2pEaGxTOCtPRkFPVHV4?=
 =?utf-8?B?VDR4dzhYNk14cTN2N3BaN2laZHpRbjNQOVRLN0dDL04yOVllZ3hwaGQ4RExt?=
 =?utf-8?B?WnlsWTFEN3JsTDF1MnFQOTRUV3YrblB1WUNPUDBLVmg4WVUxTGZkT3kvS2lZ?=
 =?utf-8?B?a2JpZTUzSGpjWnNsbCtzR0ExTGpwbUxJQ3FmMEVNOWFiOUczRTdHYklzbGFa?=
 =?utf-8?B?ZmpVbjBVQlcyb2JBMGlsUkpBTDJWS1BPOGNJL0dKQUd1TUYzWWNUWUpTQjBl?=
 =?utf-8?B?aEl4cXpmNGNybDJ6TTF1OHoxeTBPZ3htb3FTUFVkOVBWc0R5TCt6ZVd2SUFH?=
 =?utf-8?B?dTFzQ29yRVdaeGh1ZVU5aXR1N3ZOUFptTk0xSEdIUVJrRVBDL2srbzRtVFli?=
 =?utf-8?B?QVhwMHpaejFPYy9oUUJxcCtwRXVIck14MW0zRzUrdnVXcnJqRHM3OTlKSG15?=
 =?utf-8?B?d2JOSG9YNFlBNFZKVHYyUUx2Um1tOVdaK3UzcnVxVHVRdUxCTGJtK2x2aVZ4?=
 =?utf-8?B?OWtTZjZ2L094RWRjMlVkekNXb0hQZU1LWFJiZTJaUDNDcTl5Y0JsTlJLSVFO?=
 =?utf-8?B?LzNoTExDV0ZnODdQSDVpT0JYN0h3WE55MjJxcFluWTFiejlJWHFLd005dUEw?=
 =?utf-8?B?bTMwMlhxY3BybXkrbjg2WThscEFBcXFvUGZxWFg3ZWM2WTBSSmlySjB1MW1q?=
 =?utf-8?B?clFLSnQ2OEl2T2UvWHFVa0Fmd1Z3Y1BSa2VHczlVQ2RQYzVtNjdOQjJCcC9Q?=
 =?utf-8?B?em5JUk5VaGVMKzZ4dFhmeXVZdnhQdzNYd2FEZ0xjdVc4eldBeGtlc0Y4anBM?=
 =?utf-8?B?MXpSVEU4VHUwL0htWFJIWk0wdVZ5TkZidE02bXdaSmRrYUJYR3l0WEpOb2JQ?=
 =?utf-8?B?dnRkUUdNc0VhdWI5ZkFXSWs0UTdqdWpEbWVoYTNBVlpZdTFWcDZwRkxncGVF?=
 =?utf-8?B?V0VCNjczQUVlUTI2NGQxZm9rY05PYng2by8xd09HejVzMC9kRm5MS0l5bksw?=
 =?utf-8?B?RFh2Wm9GbWZSb3cvNHowRHBYMnovOFd0TklnVkJBcWJqb3A4bUZYbXIvUUVv?=
 =?utf-8?B?bmp5eXpod28zQ0cwUW5qSHRHSk1Ra3V1UHRjWGZ3R2plQjlENllqY3psWGtR?=
 =?utf-8?B?Mm9PUG91a1J2ZjZEbDh5czZEVUpYbTJGc3NCNzArMGUzNjNtek5FN1NCTDBW?=
 =?utf-8?B?RDU0VUFSMzUwZnBvQXFmTHd2bTgxMDVpd09DZVRSblpTOTM5YTNuQit2eFEx?=
 =?utf-8?B?bXlmRklLcEhIeHRLaUlNOGF3NEhYL1lFeGV6MTVuK0p6b3EvbW1xbGdYY3lv?=
 =?utf-8?B?U0c1QjBTSVdVa0JWKzMvQ3h5QUJtZHdycmtaUVZEUnZWMUI2alB1R24vOTAz?=
 =?utf-8?Q?mpvwe884xxDwaxgPESDtbfZnu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f3f59-e7f6-48a3-cdea-08ddea8bf740
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 01:48:22.5618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XeE/VfwocNohO1alin1L9TsYqAsxJG27AdcaHZphrMwQYMrcUBdoJZ76j42CD1ueTI/JLLK5lMODaDPl5YWYh5EwFqQ5HWnYoB/zSGinT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5776
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA2LzIxXSBody9h
cm0vYXN0Mjd4MDogQWRkIFNSQU0gYWxpYXMgZm9yIFNTUA0KPiBhbmQgZW5zdXJlIGNvcnJlY3Qg
ZGV2aWNlIHJlYWxpemF0aW9uIG9yZGVyDQo+IA0KPiBPbiA3LzE3LzI1IDA1OjQwLCBKYW1pbiBM
aW4gd3JvdGU6DQo+ID4gQVNUMjcwMCBoYXMgYSAxMjhLQiBTUkFNLCBwaHlzaWNhbGx5IG1hcHBl
ZCBhdCAweDEwMDAwMDAw4oCTMHgxMDAxRkZGRg0KPiA+IGZvciB0aGUgbWFpbiBDQTM1IHByb2Nl
c3Nvci4gVGhlIFNTUCBjb3Byb2Nlc3NvciBhY2Nlc3NlcyB0aGlzIHNhbWUNCj4gPiBtZW1vcnkg
YXQgYSBkaWZmZXJlbnQgbWVtb3J5IGFkZHJlc3M6IDB4NzAwMDAwMDDigJMweDcwMDFGRkZGLg0K
PiA+DQo+ID4gVG8gc3VwcG9ydCB0aGlzIHNoYXJlZCBtZW1vcnkgbW9kZWwsIHRoaXMgY29tbWl0
IGludHJvZHVjZXMNCj4gPiAic3NwLnNyYW1fbXJfYWxpYXMiLCBhICJNZW1vcnlSZWdpb24iIGFs
aWFzIG9mIHRoZSBvcmlnaW5hbCBTUkFNDQo+ID4gcmVnaW9uICgicy0+c3JhbSIpLiBUaGUgYWxp
YXMgaXMgcmVhbGl6ZWQgZHVyaW5nIFNTUCBTb0Mgc2V0dXAgYW5kIG1hcHBlZA0KPiBpbnRvIHRo
ZSBTU1AncyBTb0MgbWVtb3J5IG1hcC4NCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwgYmVjYXVzZSB0
aGUgU1JBTSBtdXN0IGJlIHJlYWxpemVkIGJlZm9yZSB0aGUgU1NQIGNhbg0KPiA+IGNyZWF0ZSBh
biBhbGlhcyB0byBpdCwgdGhlIGRldmljZSByZWFsaXphdGlvbiBvcmRlciBpcyBleHBsaWNpdGx5
IG1hbmFnZWQ6DQo+ID4gImFzcGVlZF9zb2NfYXN0MjcwMF9zc3BfcmVhbGl6ZSgpIiBpcyBpbnZv
a2VkIGFmdGVyIFNSQU0gaXMgaW5pdGlhbGl6ZWQuDQo+ID4NCj4gPiBUaGlzIGVuc3VyZXMgdGhh
dCBTU1DigJlzIGFjY2VzcyB0byBzaGFyZWQgU1JBTSBmdW5jdGlvbnMgY29ycmVjdGx5Lg0KPiAN
Cj4gQ291bGQgdGhlICdzcmFtJyBNZW1vcnlSZWdpb24gb2YgbWFpbiBTb0MgYmUgcGFzc2VkIHRv
IHRoZSBjb3Byb2Nlc3NvcnMNCj4gdXNpbmcgYSBwcm9wZXJ0eSA/IExpa2UgZG9uZSBmb3IgZHJh
bS4gVGhpcyB3b3VsZCBiZSBzaW1wbGVyIEkgdGhpbmsuDQo+IA0KV2lsbCBkby4NCg0KVGhhbmtz
IGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCkphbWluDQoNCj4gVGhhbmtzLA0KPiAN
Cj4gQy4NCj4gDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9z
b2MuaCB8ICAxICsNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYyB8ICA1ICsrKysr
DQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgfCAxNSArKysrKysrKysrKysrKy0N
Cj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBiL2luY2x1
ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IDNkZDMxN2NmZWUuLjliOTM1YjliY2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gKysrIGIv
aW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTEzNCw2ICsxMzQsNyBAQCBzdHJ1
Y3QgQXNwZWVkMjd4MFNTUFNvQ1N0YXRlIHsNCj4gPiAgICAgICBVbmltcGxlbWVudGVkRGV2aWNl
U3RhdGUgaXBjWzJdOw0KPiA+ICAgICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBzY3VpbzsN
Cj4gPiAgICAgICBNZW1vcnlSZWdpb24gbWVtb3J5Ow0KPiA+ICsgICAgTWVtb3J5UmVnaW9uIHNy
YW1fbXJfYWxpYXM7DQo+ID4NCj4gPiAgICAgICBBUk12N01TdGF0ZSBhcm12N207DQo+ID4gICB9
Ow0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMgYi9ody9hcm0v
YXNwZWVkX2FzdDI3eDAtc3NwLmMNCj4gPiBpbmRleCA5NjQxZTI3ZGUxLi5iN2I4ODZmNGJmIDEw
MDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYw0KPiA+ICsrKyBiL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYw0KPiA+IEBAIC0xOSw2ICsxOSw3IEBADQo+ID4NCj4g
PiAgIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX3NvY19hc3QyN3gwc3NwX21lbW1hcFtdID0g
ew0KPiA+ICAgICAgIFtBU1BFRURfREVWX1NEUkFNXSAgICAgPSAgMHgwMDAwMDAwMCwNCj4gPiAr
ICAgIFtBU1BFRURfREVWX1NSQU1dICAgICAgPSAgMHg3MDAwMDAwMCwNCj4gPiAgICAgICBbQVNQ
RUVEX0RFVl9JTlRDXSAgICAgID0gIDB4NzIxMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZf
U0NVXSAgICAgICA9ICAweDcyQzAyMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1NDVUlPXSAg
ICAgPSAgMHg3NEMwMjAwMCwNCj4gPiBAQCAtMTkyLDYgKzE5MywxMCBAQCBzdGF0aWMgdm9pZA0K
PiBhc3BlZWRfc29jX2FzdDI3eDBzc3BfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2X3NvYywgRXJy
b3IgKiplcnJwKQ0KPiA+DQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TRFJBTV0sDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5kcmFtX2NvbnRhaW5lcik7DQo+ID4N
Cj4gPiArICAgIC8qIFNSQU0gKi8NCj4gPiArICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lv
bihzLT5tZW1vcnksDQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TUkFNXSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmYS0+c3JhbV9tcl9hbGlhcyk7DQo+ID4gKw0KPiA+
ICAgICAgIC8qIFNDVSAqLw0KPiA+ICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19E
RVZJQ0UoJnMtPnNjdSksIGVycnApKSB7DQo+ID4gICAgICAgICAgIHJldHVybjsNCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAu
YyBpbmRleA0KPiA+IDY2NTYyN2Y3ODguLjkwNjQyNDliZWQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0K
PiA+IEBAIC02MjQsNiArNjI0LDcgQEAgc3RhdGljIGJvb2wNCj4gYXNwZWVkX3NvY19hc3QyNzAw
X3NzcF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgIHsNCj4g
PiAgICAgICBBc3BlZWQyN3gwU29DU3RhdGUgKmEgPSBBU1BFRUQyN1gwX1NPQyhkZXYpOw0KPiA+
ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzID0gQVNQRUVEX1NPQyhkZXYpOw0KPiA+ICsgICAgTWVt
b3J5UmVnaW9uICptcjsNCj4gPiAgICAgICBDbG9jayAqc3lzY2xrOw0KPiA+DQo+ID4gICAgICAg
c3lzY2xrID0gY2xvY2tfbmV3KE9CSkVDVChzKSwgIlNTUF9TWVNDTEsiKTsgQEAgLTYzNyw2ICs2
MzgsOQ0KPiBAQA0KPiA+IHN0YXRpYyBib29sIGFzcGVlZF9zb2NfYXN0MjcwMF9zc3BfcmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgIG1yID0gJnMtPnNyYW07DQo+ID4gKyAg
ICBtZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMoJmEtPnNzcC5zcmFtX21yX2FsaWFzLCBPQkpFQ1Qo
cyksDQo+ICJzc3Auc3JhbS5hbGlhcyIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXIsIDAsIG1lbW9yeV9yZWdpb25fc2l6ZShtcikpOw0KPiA+ICAgICAgIGlmICghcWRldl9y
ZWFsaXplKERFVklDRSgmYS0+c3NwKSwgTlVMTCwgJmVycm9yX2Fib3J0KSkgew0KPiA+ICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgfQ0KPiA+IEBAIC03NzksNyArNzgzLDE2IEBA
IHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICBhc3BlZWRfbW1pb19tYXAocywgU1lTX0JVU19E
RVZJQ0UoJnMtPnNjdWlvKSwgMCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgc2MtPm1lbW1h
cFtBU1BFRURfREVWX1NDVUlPXSk7DQo+ID4NCj4gPiAtICAgIC8qIENvcHJvY2Vzc29ycyAqLw0K
PiA+ICsgICAgLyoNCj4gPiArICAgICAqIENvcHJvY2Vzc29ycyBtdXN0IGJlIHJlYWxpemVkIGFm
dGVyIHRoZSBTUkFNIHJlZ2lvbi4NCj4gPiArICAgICAqDQo+ID4gKyAgICAgKiBUaGUgU1JBTSBp
cyB1c2VkIGZvciBzaGFyZWQgbWVtb3J5IGJldHdlZW4gdGhlIG1haW4gQ1BVIChQU1ApDQo+IGFu
ZA0KPiA+ICsgICAgICogY29wcm9jZXNzb3JzLiBUaGUgY29wcm9jZXNzb3JzIGFjY2Vzc2VzIHRo
aXMgc2hhcmVkIFNSQU0gcmVnaW9uDQo+ID4gKyAgICAgKiB0aHJvdWdoIGEgbWVtb3J5IGFsaWFz
IG1hcHBlZCB0byBhIGRpZmZlcmVudCBwaHlzaWNhbCBhZGRyZXNzLg0KPiA+ICsgICAgICoNCj4g
PiArICAgICAqIFRoZXJlZm9yZSwgdGhlIFNSQU0gbXVzdCBiZSBmdWxseSBpbml0aWFsaXplZCBi
ZWZvcmUgdGhlDQo+IGNvcHJvY2Vzc29ycw0KPiA+ICsgICAgICogY2FuIGNyZWF0ZSBhbGlhc2Vz
IHBvaW50aW5nIHRvIGl0Lg0KPiA+ICsgICAgICovDQo+ID4gICAgICAgaWYgKG1jLT5kZWZhdWx0
X2NwdXMgPiBzYy0+bnVtX2NwdXMpIHsNCj4gPiAgICAgICAgICAgaWYgKCFhc3BlZWRfc29jX2Fz
dDI3MDBfc3NwX3JlYWxpemUoZGV2LCBlcnJwKSkgew0KPiA+ICAgICAgICAgICAgICAgcmV0dXJu
Ow0KDQo=

