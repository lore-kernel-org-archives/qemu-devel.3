Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FECCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 05:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIgkf-0005fH-Bi; Tue, 11 Nov 2025 00:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIgka-0005dh-Gv; Tue, 11 Nov 2025 00:17:05 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIgkY-0001n2-4M; Tue, 11 Nov 2025 00:17:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZZ+lsBPXfWgPuqRWQkG6hu4Ze9IR9EwR3F/kQIb6+ML0H+YVb3t74/Pg1zfJACzE5mes4p54QjnmC3RzxxoVu6cJ7YOAud5Hlvpvi2xiAreZY8o6nYRSdU0KSOjSFxfEX382Xt2rZCKn2QLVUbXx9Q6LCqqXqXxas8q8+qzac2Nc2mc4RXXkGGH9yCBhHh+KWEoFLphODE+CsGPiFfPdSKhi3hpSEHyIv7whGSCxPJeHMlBn4YCVKl1WTv9E3rG5+nfkGtFIeWgDuRDt0VyMd4xSLKDZSivrBAATMuc4B60+2ilLrg5EZjZnEN635a0g3kRpekvYmvtbQQZ5bwUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq4Go9lj04WDGkvjRtxbRWOWH1qExbzkeL0jnpYMbY0=;
 b=PhejqhCVEUGubMlRVT5IW7aoCr4v3OULeboxKsTzB9lwWwJt3KiGh0UjaJMXh7AwfPSidugCToTm9lJCnOrNB9MB+GmCvM4KmTSHmxDhsHGds/tit51/ujYo/BFsh/OuUglPdBlzxzfxVH+bbn4Xo8WTwiMKwd5xbS81adHov6EqRooX4LFrhHDlsh78laxfTNWu+WL42SFaOBtp0UJgKmggy8QDNzHcyQh8Vb3UYk4RPHQ7wVQsy8QN35FAZFoIU51Px/B2IpKoCasogvPrybOp9GXcGxpH7yNC7Q8QZHLQ0myz1JAUT3rpVCDBiS3HdnYQtM6LscyiuiQBsTZhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq4Go9lj04WDGkvjRtxbRWOWH1qExbzkeL0jnpYMbY0=;
 b=jRoiz+mAznEtokmRhS8PnfEBHRrMHscMutEv8X229QlTjvAJgrN5kKdMGl5vGnwxBOr/UPmszkOaTHcSiElmQ7tXemB5p4LrBV3ImG50osEgkDuMUMENvO0Sk68BNUmLYEZ/WrJYhj/72OA95aDm2R4dFBeylkxhRX0FUdGHjNu0lfvYA7soyhni3PzfL5hHDDMCLlSq9e1atp5stTGJrh9GHDX+H9NhTCAm9rAqs9ae/pXjzfpn4YSCjJrQAI9wQykL0vbitAMgUlhSDnX7MTPmt8kC+NTo4d0UOfizU3wQjktcAJG9xhxrYpIKzO2f3wXDo7gfs4OnHLGBXJH3jw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7352.apcprd06.prod.outlook.com (2603:1096:990:a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:16:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 05:16:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 08/12] hw/arm/aspeed_ast10x0: Add AST1060 SoC support
Thread-Topic: [PATCH v1 08/12] hw/arm/aspeed_ast10x0: Add AST1060 SoC support
Thread-Index: AQHcTvpKCV9vGmIzT0i+mnlaqVHv1LTsBvoAgADvlsA=
Date: Tue, 11 Nov 2025 05:16:49 +0000
Message-ID: <TYPPR06MB82067BDEA2D420741BD31185FCCFA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-9-jamin_lin@aspeedtech.com>
 <09d88466-8ba6-4548-b2d4-dded9bed37b9@linaro.org>
In-Reply-To: <09d88466-8ba6-4548-b2d4-dded9bed37b9@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7352:EE_
x-ms-office365-filtering-correlation-id: 36eb044f-d27d-4b60-41f4-08de20e184d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bDZidTdBMFNZTEEzS2QzZ2Y1YmxZMk9sQnFBa2F2cjJnUlM2cUVuU0phMk1W?=
 =?utf-8?B?Vm1ES0tjRTlhc0FlVVpFODE1dGdqeVk5blBtWnVyRXY4WHVuSlN4WFRzK3dH?=
 =?utf-8?B?NFR5bThpT1dZTWtOWis3UDg3Q3l2WUF6ZmZlRzlYd3lYQnQ1OGQzUzVhQjhX?=
 =?utf-8?B?S2x4b3RHUW9MT0tGRVJrM2hNUTF6L2hmT0h5eW10QXpIbUdZSzQ2eEpjM2hx?=
 =?utf-8?B?WEQyUkVjODZNVFlrc20yYVVSbGpvTWprRU9ENC9jcTg5SEZYUVU4dWpLN1A4?=
 =?utf-8?B?RmVLTkl2eWVPV3BabzJRaTBsNWRTR1BOSmNZbGpBeXo1ZTJZbUhsaXorUk5U?=
 =?utf-8?B?RUF3ejVEUFRua1gweTlnVHovZG5qSUF4SkJGSmZSeXZzbUNuVHVZY0hPaTR1?=
 =?utf-8?B?OVFJdUNFYnljSXFHSk92SUR0amNCU2ZRUXZoM25PdXRhTlRxMHAzN3JKT1pu?=
 =?utf-8?B?anFoSzRKVHNMZllLK3cyUkIydkMyQ0IxQ2NXSTFlN1hMR1NLZ0krdVlSb0s5?=
 =?utf-8?B?RjZETUtLVCt0elJoQVlpbWx2djBkaEh2NWFLV3NNaU1mQnNETDRyOFZUd2hY?=
 =?utf-8?B?TVpaV3labkowUnRoTGp0TmZoeUFtcU1Hb09pZ2xRM0hrdnRSOExXYkFsVTQv?=
 =?utf-8?B?M3J5S0dLSklsZmt5K285VUJDb3hnNWpmYzlkRVRWT1hTS015OFV6UERPckdp?=
 =?utf-8?B?WUIxZkFqWnpHTERvRnZubkdrYkN0TStsVkxIdlJkaHVSZ3JKSjVuaHJBNytX?=
 =?utf-8?B?NnpxMkgvRHByYWRTZVVxd2RXaVZiM2UzQ3d1NVJUb0x3NGdsWCtOZmNLZTdq?=
 =?utf-8?B?NyszcUFNYmQvZ3FBbW1qNVZUd0pBUzh2cjc5MURGVUlMTkw0aE5JS2VwUDh6?=
 =?utf-8?B?QXlBV3FYMDExUXJFM1MrSGp6Y1hSZlMyMmVPd3E4L2RNOVFUSExDVXBZS3RD?=
 =?utf-8?B?SFR0OWdUc1QzNTFTaHhTVWI0L0lwTW8rV3RYWU1POHNkMjdjM1N3dk96Y3Ns?=
 =?utf-8?B?R2JFVjQ0bUMvTHdwMzAwa2IrSHpXdW9Vb0RlYWkrSVI2elBRM3V2K1NGak5Z?=
 =?utf-8?B?OTc1N2dtcWVDYlkwc0R5OHJxOUp1R25VVmJuSjlpZ2RQZ0t6VGlGL2l5eitn?=
 =?utf-8?B?cmhGNUFhQ3BNbHlxYVFvMmJsQzNyUjd4c3dCRVZiTkV0NWY2NHp2NjUvVlV4?=
 =?utf-8?B?aTdOVnh2RnRxZFpQZnJhM1UyUE44TitJMTMvU1NpU1RIaXRJQWh4UzBaM1FR?=
 =?utf-8?B?RVFvZXhwVEp2S2FtZDlIRXhLNlNXNWhoRVRUYk5wV0VHMjJxWDdVS2hJMndk?=
 =?utf-8?B?V2IxT3NKeDcvM2hhZncwM09FK0ZqOStJZDNFRXpUL3FzNkYwb1hmUWlacFVK?=
 =?utf-8?B?TnpzanFuVzJTelhHS2VYeDBLZDRtYmY3QUNTSWpMell1NGpmVk8zN0RyemNx?=
 =?utf-8?B?a2ZHcWFLeko5RWpGTlRmcGFNbjZsMzN1WkNhN0trQVVMUm1XYm0yNzFZNC8y?=
 =?utf-8?B?dVFReGZKN0NPRUZ2ekJKM2ZBMnB4MGt6MFhxQmo3YWtjc3dXcXBMN1JWWlpk?=
 =?utf-8?B?OWVmMUM0bkpKeDZQYUJvdk1BKzZ3dS9DQmU4RlQ1VlZRR1hhUTY0Mnp2U0R1?=
 =?utf-8?B?UUxORUd4Mi8yZmg4SVR4anhYeU1vNGtmbWt0WjBnOFVCMjF2RjB6NVhSSlBs?=
 =?utf-8?B?emF4ZGpaVEdKZ1pCU2txcGFYK1pnUTI3Y3o5MVZGS2IxdjMzVE1RYm8wN0ZO?=
 =?utf-8?B?bkJJTmN4WGgwTGs5SmpMbXVOaXR1MFo5dlBJaE5VZGRib0lHOEFDWkczZHRH?=
 =?utf-8?B?VnN6MURrbHdVdlpNM3o5MmlaZjNKd0plS1VPYUFxaUROQXVZa0NtYTlVZ1hO?=
 =?utf-8?B?U2ZnOU9vYk9vTHhpY015L1VVbjFkdGttNXdyeWNOeVlEaUUvMjdFdkRQWEh2?=
 =?utf-8?B?NDJIZWRMVHlIZVRhMCtBRWhQY0tuY2ZSZW1KRWdNN20zRGNCeXFNQVdnT0dI?=
 =?utf-8?B?ZUtHS2xWaTZPeXNyb3NkaU56VUJOUEU2TkdMdllWMWdSV1lGSFNWQk9JSC9k?=
 =?utf-8?B?dnVMRzNYR0RxdG9LY2Nlc0JTdzRJY21FSWp5QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjV5L1NjeHhGbGxlVFJxWDgwYktnOGw3WlRtMWlEeE8rSU50cjJ1c1VSMGtw?=
 =?utf-8?B?ODJZenljVUZzVU1WSGRtS0JOb1ZZNStiQlZPbGUvKzl5WFlWY1NHZTBoKzdr?=
 =?utf-8?B?VEtIYU5ybHY0SVlaU3BoY1R2RHJQcE83VTVSWmNjeUdyYWpuQnNtcVRRV253?=
 =?utf-8?B?OThQREtWbTVLcGk4OEdUK3ZUaThsSHpSTTNsMHRCYUJOdWhiQkRJdFQvczhz?=
 =?utf-8?B?OTdjcXFBL3dNV1YzWWRvNkJqSk5DRHhtK2tyRkZ2azEwY3BUWkdYaFJQWng3?=
 =?utf-8?B?TitueXBybEVPRUJaMzZVa2NrME05MWFRTGRoY0hxNGpkdVdnaElMMkxOdnVj?=
 =?utf-8?B?KytzcnY2RVY0R0I1bS9LcmNhb0tvZzdyR3FnOWJ1bktXMTlJY1laN082UjVr?=
 =?utf-8?B?NDd4YkZoTnJBUVA5SHB4VjZJbHdtUHl0Z0ZLbkpYbGk1S3NjMUQ4UnNhaXpy?=
 =?utf-8?B?UTN5dENsbXVVWk9HSmU2QWFybDJ3Y2hVNEk5YWNOOUlLWTcvZzY1VmJXam1t?=
 =?utf-8?B?MnJuMm9rV2VkUHcrR1dzWXdFb3lzUXZkTDF0V0FLa1NybHFwUzVoNFJ0d3Vo?=
 =?utf-8?B?WHNSTytsc2FKMUQ3aWNhNWF4cnAxQjVtSnVRRmN0ZzJTRjhzTDFtaXl6R3dh?=
 =?utf-8?B?TGxoeFhZeVF3aTEwSm5FNUU1a0dnN0t4M000VkRTZFlDTHg3R0wwQytrb1Ra?=
 =?utf-8?B?d215bFIwdVJiZkNCR01CSXJESzdsVWwxZ0JkK3BlL1BnSklrK0tBVzFuY3A0?=
 =?utf-8?B?dXVVYmNOcnRLMjZld1hBMzJHeFFrbVFaZHdWOWVmMlp3Qkd4Q0dHSUw4aXpY?=
 =?utf-8?B?Nk9qMjJjN2pCRVJrYWQ0RUFxTTFHNGJGTTVlWUVRSHp4WXlJQjhEeHpkNnl5?=
 =?utf-8?B?VElud0tFT256a1lYTEtmRmc1UlRGNVRKcnZWZ2h3ekFmZnJVSXprZFJJbFhZ?=
 =?utf-8?B?WTUzZUlVbGZOVmF6MEFwcHpPQ3RPQ2ROdC9vSEd5eU5lTWUyMnR2a1dYaC93?=
 =?utf-8?B?K3BZeUtlMjR2Sldyb0pCT2htQUNsWmM4NUE4WkgvQU1oaTRFYUpmY3gySEZS?=
 =?utf-8?B?MHFmK1g5YVhma2Z2QlgzUlNTTkl5QS9VOUFkVlA3TE1xWjExd2gvZjNXdjZy?=
 =?utf-8?B?bEFCUDdUaEZGOWozMW9jUlJqQkp2cXlpcU9KaklTTHAzdmw2c3Jnd2tXdTFX?=
 =?utf-8?B?QW9Yb2d4UUQ4TTlxa3hPWDhmVnZvWHZjTHJWejdVbC9mTmpWWjVXQTZudDNZ?=
 =?utf-8?B?M0hseWxIeHZQbno2b0g0T2lSK0FENU5abW5mUThJa1ZuSW55Z0lHYU41U3oy?=
 =?utf-8?B?amJSdHBHVm5tVEt0R3U0K2JpV2lZOG12SHVCRjYzMWpYR0l6c0FUbDQ0TDlo?=
 =?utf-8?B?QW9ZcHg1NnpTTXY3eXdHUzRKTDdrTklBOEJEcjdLTVBTcXd3eDNvYXROTXdQ?=
 =?utf-8?B?VThLS2l4cVlENUlqb2pxVkVYRnZXZWpWT29sWmhmRktBd2NYZ1BPWGtpeWJr?=
 =?utf-8?B?bHFuNEc1bjE4SkRsN1FVS2hyOE51bFh4TlRjazZnUVZXK1RmTFhsWXZMNmRR?=
 =?utf-8?B?R2Z3cnVIQW8wSTFiamlHbXRyR25KV2J1MW9CY2ZkaUZRcmJLRlRQc3FCcVZl?=
 =?utf-8?B?NmV0UFVPOVRvTFAzbW1oSy81MU9FMzduak4zbjN6Mml2MEl0a01UM3JGaDFK?=
 =?utf-8?B?cEZ5NmNKMkhJTE83cTJoeWUxbEw2c0Z4Z1dtbGg1T2RvaDdkWTc3SXBsV0J6?=
 =?utf-8?B?ZWtYc2tEczBmU2NYeTdpMkh0SnhMek5OT3JKd1o5Z0JXOXNUT3pVcTMrdFY4?=
 =?utf-8?B?SnU2R1VDQVBJVE1DVS9GM1BBUkh6RUJTVUNRZzhPdWVoQlVRZmVxK0JUbi9w?=
 =?utf-8?B?NDNBWUU1c1NjMXpBWExuTGVZU3hidXdKdW54bkhpVEc3UUtuS2Qwbk5WcXNG?=
 =?utf-8?B?NzhMWWU4VTJ3OGlGeVZGcDNMWFZOWWFqVTFMOEgyMTlhazNWY1k2Yjc5WVNt?=
 =?utf-8?B?WDJ2Ukc2VVZydkswbFArU0JhOE9sWlBPOFN6TGdFTUg4RklFdUNldm55bXp6?=
 =?utf-8?B?UHpUV0tCejl1d0F2eDdzSXVicFVYL2h3ZTNsQ2VlaHh3UjVnRGQzU05QVis4?=
 =?utf-8?Q?eUR+pERfmcPnJ4R5rDrzwbMlI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eb044f-d27d-4b60-41f4-08de20e184d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 05:16:50.0083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/7noIGDsxHVEArsmvt+GqvWzHuoWfbyx8hNtVi6muwcZuglTevK5i58qSMsItZ5raSvbf1FxPgAhWAvxYL0IG+6SN2rvDFRpYAvMVu0gdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7352
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOC8xMl0gaHcvYXJtL2Fz
cGVlZF9hc3QxMHgwOiBBZGQgQVNUMTA2MCBTb0MNCj4gc3VwcG9ydA0KPiANCj4gT24gNi8xMS8y
NSAwOTo0OSwgSmFtaW4gTGluIHZpYSB3cm90ZToNCj4gPiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZv
ciB0aGUgQXNwZWVkIEFTVDEwNjAgU29DLiBUaGUgQVNUMTA2MCByZXVzZXMNCj4gPiBtb3N0IG9m
IHRoZSBBU1QxMDMwIHBlcmlwaGVyYWwgZGV2aWNlIG1vZGVscywgYXMgdGhlIHR3byBTb0NzIHNo
YXJlDQo+ID4gbmVhcmx5IHRoZSBzYW1lIGNvbnRyb2xsZXJzIGluY2x1ZGluZyBXRFQsIFNDVSwg
VElNRVIsIEhBQ0UsIEFEQywgSTJDLA0KPiA+IEZNQywgYW5kIFNQSS4NCj4gPg0KPiA+IEEgbmV3
IGNvbW1vbiBpbml0aWFsaXphdGlvbiBhbmQgcmVhbGl6YXRpb24gZnJhbWV3b3JrIChhc3QxMHgw
X2luaXQNCj4gPiBhbmQgYXN0MTB4MF9yZWFsaXplKSBpcyBsZXZlcmFnZWQgc28gQVNUMTA2MCBj
YW4gaW5zdGFudGlhdGUgdGhlDQo+ID4gZXhpc3RpbmcgQVNUMTAzMCBtb2RlbHMgd2l0aG91dCBy
ZWRlZmluaW5nIGR1cGxpY2F0ZSBkZXZpY2UgdHlwZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3
L2FybS9hc3BlZWRfYXN0MTB4MC5jIHwgNjENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QxMHgw
LmMgYi9ody9hcm0vYXNwZWVkX2FzdDEweDAuYyBpbmRleA0KPiA+IGM4NWMyMWIxNDkuLjE3ZjUy
ODVkODUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMNCj4gPiArKysg
Yi9ody9hcm0vYXNwZWVkX2FzdDEweDAuYw0KPiA+IEBAIC0xOTAsNiArMTkwLDI1IEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF9zb2NfYXN0MTAzMF9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ICAgICAgIG9i
amVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBlY2kiLCAmcy0+cGVjaSwgVFlQRV9BU1BFRURf
UEVDSSk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QxMDYw
X2luaXQoT2JqZWN0ICpvYmopIHsNCj4gPiArICAgIGNoYXIgc29jbmFtZVs4XSA9ICJhc3QxMDMw
IjsNCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogVGhlIEFTVDEwNjAgU29DIHJldXNl
cyB0aGUgQVNUMTAzMCBkZXZpY2UgbW9kZWxzLiBTaW5jZSBhbGwNCj4gcGVyaXBoZXJhbA0KPiA+
ICsgICAgICogbW9kZWxzIChlLmcuIFdEVCwgU0NVLCBUSU1FUiwgSEFDRSwgQURDLCBJMkMsIEZN
QywgU1BJKSBkZWZpbmVkDQo+IGZvcg0KPiA+ICsgICAgICogQVNUMTAzMCBhcmUgY29tcGF0aWJs
ZSB3aXRoIEFTVDEwNjAsIHdlIHNpbXBseSByZXVzZSB0aGUgZXhpc3RpbmcNCj4gPiArICAgICAq
IEFTVDEwMzAgbW9kZWxzIGZvciBBU1QxMDYwLg0KPiA+ICsgICAgICoNCj4gPiArICAgICAqIFRv
IHNpbXBsaWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiwgQVNUMTA2MCBzZXRzIGl0cyBzb2NuYW1lIHRv
IHRoYXQgb2YNCj4gPiArICAgICAqIEFTVDEwMzAsIGF2b2lkaW5nIHRoZSBuZWVkIHRvIGNyZWF0
ZSBhIGZ1bGwgc2V0IG9mIG5ldw0KPiA+ICsgICAgICogVFlQRV9BU1BFRURfMTA2MF9YWFggZGV2
aWNlIGRlZmluaXRpb25zLiBUaGlzIGFsbG93cyB0aGUgc2FtZQ0KPiA+ICsgICAgICogVFlQRV9B
U1BFRURfMTAzMF9XRFQgYW5kIG90aGVyIG1vZGVscyB0byBiZSBpbnN0YW50aWF0ZWQgZm9yDQo+
IGJvdGgNCj4gPiArICAgICAqIFNvQ3MuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGFzcGVlZF9z
b2NfYXN0MTB4MF9pbml0KG9iaiwgc29jbmFtZSk7DQo+IA0KPiBXaHkgbm90IHNpbXBseSB1c2U6
DQo+IA0KPiAgICAgICAgIGFzcGVlZF9zb2NfYXN0MTB4MF9pbml0KG9iaiwgImFzdDEwMzAiKTsN
Cj4gDQo+ID8NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9ucy4NCldpbGwg
dXBkYXRlIGl0Lg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IA0KPiA+ICt9DQo=

