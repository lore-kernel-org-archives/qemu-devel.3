Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB332D65C57
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 08:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVUc-0008Jl-5r; Thu, 14 Nov 2024 03:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVUQ-0008IV-Ud; Thu, 14 Nov 2024 03:46:11 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVUM-00071r-OT; Thu, 14 Nov 2024 03:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvT1MNWglGpj7H1+VjUEreyh83MFtg8yzbqLoWtBlxLTz6pxd6znE6qTrUOo0MplGLCskDMOYkhGcsLf0dPxx0s/5j4fagnz2f599uzAY9IspjnHPAa/6Tewo71gRgNyG0+ALcFf+GSGlaOTGKj4MQeOpKSbuby9VptnECHQNSXEk3UekXzOGvOifvhdFRZVHj6cmZ8z1NJvGn2UzBmOIGtbNtgG2gsiTwS/270KFXY3fu2IijN7TwWC2hZcGufpaI/AIWGD57mN6hOK8bg/PKSh/obwVv9Ls4rHcCTRcC2XJWY3EGLSmo10ee9qr1YRUzqtagpYpni7N4pikPqoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKK9TLef0WWBWoy9oanj2AHbLFo8dV2LS6IZEJc3EaA=;
 b=FCEokVhU92X5VXHC30O9rReGWQesfjNd5qLmzYLjDq2UKZDvFdIweP5yS9xRdlvjsZTPJdi3DDVstwfz8i6UBciO4uXEhx38s4RY0gJQAdnWX1oVfiVt52hyKzZHkrv4ldSx9Qcr5bLbiHRjj1xPV4U4/YyyG2KuMKMJt8zs+Tij319o4Qx+/J8QPdiiUg9PGSy6j5ccgFMIqCxGQimHupD/rQLEPBrpMz/5Sn+TMLvMm9zOmYOM/kWTtWaD1C+1G1106x+dGV9PiRAnL1ObAp35YponSsQkjE6oRriPKH1XdGiABcL0jxcht6yidbKY67VFELzuWAA+CLC5gETaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKK9TLef0WWBWoy9oanj2AHbLFo8dV2LS6IZEJc3EaA=;
 b=VbLQXtug1jIt9pzNZQk42ip38RMlBiLDLTA5gbNcQrTX0xiZtYopYzIbmKNqaWK9eU0Aev5TejJT4k5BIv73cwNRcXw9s0i8r77y/dKLd3afhqex0CP9BDnpj0Vz+KBW99Ko8mlDws1e+M09VEq0i0ci6MTc/oakWqCWEJ9uL8Ru9XOIbQnBtIhs+7P02Q2UCQJLYEGjG/dL+FXQsFxdP28swj81eOwfjSUoJN38qX3BpX6TAKOSadqCf2bqdNVlwfEu+6uEWDAkf1qeEiPNXlNkxHC3Q8JDhrq5XMAVm4qzkf9U151zfRO34XT8T0DsHD5jH6GolvMMwqEJyF2HDA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5683.apcprd06.prod.outlook.com (2603:1096:400:273::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Thu, 14 Nov 2024 08:45:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 08:45:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Topic: [PATCH v2 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Index: AQHbLmiZMT2YxHXqk0eeoArAYt5rn7K2UB+AgAAhegCAABSqsA==
Date: Thu, 14 Nov 2024 08:45:56 +0000
Message-ID: <SI2PR06MB5041A89D8FBB840655EC3787FC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241104032104.2784183-1-jamin_lin@aspeedtech.com>
 <SI2PR06MB504180AF88657AD3846E0A4AFC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <3e74f358-6ae2-499d-b016-f2819de4fecd@kaod.org>
In-Reply-To: <3e74f358-6ae2-499d-b016-f2819de4fecd@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5683:EE_
x-ms-office365-filtering-correlation-id: 317a50ba-4793-44bf-c508-08dd0488c16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?elkvTjE1R1lMSEFHMit0VW1jUGtJaW5rVFpwUFBpbHBQVFJZSkVRQ3pKQ0FB?=
 =?utf-8?B?M0twbjBkRmd4bzA3RW15bFFVYkVLalR4TnJOOU9nMjRmSzYzTzI1OUp5ZUNt?=
 =?utf-8?B?VHlhWk1tNE0zMW95RGVtTDI3bTNWQWU1UnJITExwZlA5SDhaTGJmU3pGRTBw?=
 =?utf-8?B?cmtVYWVWZ2oxTkIzc1RtMVQzTnduQXRMQzBPTG9YTm9idFMwSHE3akdlVFI0?=
 =?utf-8?B?NFRHM3YrOUx5M2xTRCtGVUd5cEY0RlZGRTh1dThXQ0dMcDk3N2trdUo2bDhq?=
 =?utf-8?B?NHJGd0l6UlpuZ1pPdHUwTmhTYnVPTG52UDM0WTU4ejlyMTloZ1BoUzY5bTVV?=
 =?utf-8?B?aE9pLytyL3E2aWpMUUdrb3hOQlNyWDRNU1V3MWtGTXRxOWIvcnh1VmpmK2pT?=
 =?utf-8?B?T2VOdjFrTnRuZHN2U3U1aXNiZ0wxSjdDWVZqTkZQYndKbkY4UXdYZUpYZDhJ?=
 =?utf-8?B?MkpKSG1BNGtnQmtuWHBwU0pMYzE1U21wOWNkVGQvSTkyYnh2QjRyUGVpRys2?=
 =?utf-8?B?QnkrUTRjNmJWcFJKeHpiTnZqOFBUN0R5UjlHNWFpWW00OHFZUDZXRzkvZU5o?=
 =?utf-8?B?N3RUVEVyaGZJdzFDUHdkaHUxaWo2aSt0d09QZmg5WTh3djZsVzhMSUgrSWhr?=
 =?utf-8?B?cjZUZDcrYW52a1ovUnlYeXFrTWxVemw4eWJhS3VYcWhYTkFTS1NYZVB3Y1NL?=
 =?utf-8?B?Z3FDWXBRSnoxM3QrbTEweHZsMzRLR1BQMHRaNGU2WkRNUE1TMTY3WTNYcGRs?=
 =?utf-8?B?Z3JGTGVvUXpUUWoydVZ1MXdrL21MSVBnTkppSzU3SzMrVFRHOW5zR0Nia2Zq?=
 =?utf-8?B?RHFKSzN3M3Y4NmsyNGoyZWEremxSWUhiL0hCRWREYzhNTUdMQkthY0V3bnR5?=
 =?utf-8?B?eVZ5RmR1Y0k5LzZxT25SS09YTktHUi92YXdXaW5IUzlCL1BUSmpHczJLcEhi?=
 =?utf-8?B?d3BDeXY0VmllK3Z3MmxNOWR3QzFidGNQZUxGTU5abVN3TEU1SXl6NUNDM1Vs?=
 =?utf-8?B?d3hwTmg1V2RYTzVLWWg4Q2NWNzBIL0o4dGd3SFQxN1VUUTlwaU5NcUJZbWdh?=
 =?utf-8?B?Tk0yV3hKeVc0eFo1bVhjbHFKS1l1SldBRkk4VlpSQmlpcWw2MFhkUTJEZzlJ?=
 =?utf-8?B?UkxDSEUxYUEyeU90aDE2amMxclNINU4wMEhQUHBYblJsVXprU0QxS2xkai8r?=
 =?utf-8?B?UjhLODdnVm1teks2bG1VcXBSV2RJdGpCbU4wd25yZnB6dEJ3UUVxU2VxTVJQ?=
 =?utf-8?B?VU5odVRUWjgxcTlvWkcwOE8rNlVWR09ZZlgvaGVuN2hvOG1LVU5lZzB0cXlk?=
 =?utf-8?B?Q3FtRUsrdThMTVl5NENLMGlxQ0MzYmlxeE16MkYwOEZKWWJzVU1nckRnVmNX?=
 =?utf-8?B?cDJqdnN3NXZ6dVJMUnc5UFRjNC9pb05rSVk5cFVsNTR5eHA3ZEt2RFZCbXIx?=
 =?utf-8?B?Ung3WTJDNmNUWG9HSFVMa1hyTHZVUDhhc3VQbm5RelJwcWlGWnhLUGZiTCtH?=
 =?utf-8?B?WUViV05VbG1ML0RYQkNtV3JoNCs2ZkprT3RZSVl3M2toY1lTOHo1VGlKVnhx?=
 =?utf-8?B?Und1RmVvREg0S0J6R21kNGZKVU1wK29PUHU5UzRmWDY1L0g0QTRQVTB2RXBz?=
 =?utf-8?B?Z2ZXbmxWMGJ1cFhqK2o1UTc2cWZOWTBiUjFaL2xLSHZ6S2txLzNhZ2xLYTNI?=
 =?utf-8?B?RkpqYi9pUnR5bkUyRFZnWUJ5cGNkdnRrTHByT2FiTDJpM2VGeVI2UDRCMWhk?=
 =?utf-8?B?RUhPQ29nQXBEbW9odDZGS2JlRWVicFQ4UDhCNThpTDJXb2NmdFFyWG9KTjFK?=
 =?utf-8?B?UVFZdUlCS2dLUzJVaGFoaHJEclJvdjVqMWlvb0lsaVRGQWp4UWpNVTBPUG9T?=
 =?utf-8?Q?e9utrjKl3+OBo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2FWazFGeW5ua01aWWl4M0EvOGwzbGFUM2ZvQmlnTGVYbGJCbDg4SmVUaVIy?=
 =?utf-8?B?czQ1Nko5STZVbjdWakJSbEtNYTZjQ1oyQ3dhdXpMMzlxOVluNW1uY0loOXJ4?=
 =?utf-8?B?aXcxY0hCV0hYcDcxbjBseGlYeWRDVlh4TTlndENSdnBtdFdpay9Dd01sWVhU?=
 =?utf-8?B?QWxLSm1aRDhjaitFa3lsSituUXpFOTB0Umx3M0xsZzY0U2NUMUFLbUhxQXkz?=
 =?utf-8?B?TldIUnIrT21JeG1VNjJTeVRKSXVRb0dLaWZ1NU1ZRzF2MjVzWElJbUpEMzlZ?=
 =?utf-8?B?NGVkYWZIRDFhd3NWZ0czdW4xSlVKM0o3azQrMFJWUUMxb1hCSkJmYllDSFc1?=
 =?utf-8?B?MEFYMVdBTGpUdmx0T2JxMjRKOEpnK0g1S3huLy9FczB0elcrTEhueWNVdkhu?=
 =?utf-8?B?WVowSWxucStFTVNrNlkrRitqOWRrSUphZ1VVZDZMUU9hWkdsdnFFNWpvTHR1?=
 =?utf-8?B?b3IwSXdJaTUydmFzQnBIOXM3WTBJR3VWOTZ1K0lQNHZpQVlxU3lpSW9oREVM?=
 =?utf-8?B?YU1qbGtCZzBBUWYxbnhoK2hFUFE4Q0M4WFVQODBtWjFaMlZuRTZ6Ukw1VTNR?=
 =?utf-8?B?OXYxMGZSUjhIOTduT3NVN2pzQ2ZER09ta2xwR2xSaUc4enF6dXRMSUwzYUt0?=
 =?utf-8?B?OUpHd3VKRGFQMStpWnZVU1dBMnRDc0tpdUlLYURMUm1DUEE0YTBuRmk2ekpQ?=
 =?utf-8?B?NU51YVBYZnovUjB2aWt5c0JwcFA3NFg5eEdrZVl6Mm1JbTlXWmJLcWRJR1NH?=
 =?utf-8?B?N0xqZS81Vk5IbGR2VW1ROHViVVF3b0crellSNGwxckFFY3YwRzdzbnhQR3Fv?=
 =?utf-8?B?VG1XSXBEWU8zYUJ4cmlKYWxvTG9lTnBoa3FVNzJZRUovMUllUWw0WTB0bnVv?=
 =?utf-8?B?NDRCWE1uc1RscVRxZDE0THVndHJnR1RkY2xhUStYNXEyOGZOU1B2WVdMZXJE?=
 =?utf-8?B?UFUvcnVFZFlHQXIzN3V2VkNRZjN3NkVkNXB1QXg0N1FMbm95WGZuQ0tVNWV0?=
 =?utf-8?B?K2VYdVQzbktCVWp2d1VlYVpFMjJkOUFUNk1iT0FPcGE2cStkeWQxd3JKWGRj?=
 =?utf-8?B?cktFOXpTOWNhTzJONGxjZXUvQUdLeDl1Qk1uS3YxbGtPWmRBRmRJdXh0REkr?=
 =?utf-8?B?NXFsb0IvWXkzc3JIaWc3Vno0ZlNRM2VjUFFYOExqeVd4MnhDRFJmWStsOUZW?=
 =?utf-8?B?VkpTem9tN0EwOGRnOGczTGFDRldpUTdKV2NDd2c4K0p5NUxMK29sMlpUcHJo?=
 =?utf-8?B?THA3eno2em1zczNTWDA1YWZGMVhsdnhtbmtmR24vWmQrUzhFQmNUR2RxU3Rv?=
 =?utf-8?B?MnJ1ODJmbzhjbWQxa1lnUlFIY1FtVTlwUHM5YkZFRUlxVERCVFJRdHF6bXFV?=
 =?utf-8?B?MUNKdnZCaWZqdlNkUjVicUk2bXF5Q0JRSmNldW5FdVgxVzNmTG9kQ2YxZ20x?=
 =?utf-8?B?TDFidDFrZ1FkczJuTUVKMHVFVEFCM3R6RStVWlowZlNvK0pwalEvWkRmTXZq?=
 =?utf-8?B?b0NnaS9QcUN3bkkvRnZaNXM4MDNXak56a05PYXlJYTZTTkZaSHVXM2tuVjdH?=
 =?utf-8?B?akxGRTF4d01iZmtsUkNUTnVldEMzcHdpQm44VWV6UC9KeTdHLzdIQkxWQ0dZ?=
 =?utf-8?B?M2U5amZLb0pneUJ3bC9qRHZTOWNncXphV1Y1NG9PNXB2M1FNeVR1MXplV1ZR?=
 =?utf-8?B?SDl3TU9EaEtqQ0tGZFpxbUhhNWVIdnJhcEczUjB5TTUwRi9tYlk2OSt0c2dO?=
 =?utf-8?B?amJmcHVjR2NXdC9GajMzTWV3WldwVkh1cGJWcTh2U1ZDZ2hHOExabDVNQXAw?=
 =?utf-8?B?ZUN3TGZCRUs2aGduaXM3ZVNZZmc1WnN6U3F6MUpTN0YyNkVDQk4vVEpPbmEx?=
 =?utf-8?B?SzdvV3NLaCtneldvcGhGbTF1T1l3dVljTDlMcFFycGFXVWxXM0tKeVlZdGRI?=
 =?utf-8?B?Q3BtV29GWmt3ZzJvS3NuUlN6enJkU1g5VTQrQ0JqNXFhSWQyaEVrUmJQb2Vn?=
 =?utf-8?B?dXcvcG5NcTRUNERONXNodWNYYmU3RDdaQXFsS1RpZkZ6Y056WnJLZG9vUk9J?=
 =?utf-8?B?QnVNSkNycFp6S21OUngvTTVCUDVLSndnTE10RzlWMWorbXlweEU2OWxZdlhU?=
 =?utf-8?Q?jhvedsY0jOOOb7vBKYknnJRkU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317a50ba-4793-44bf-c508-08dd0488c16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 08:45:56.3312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c13AiElaBZdWrf+Szj6OhFskp8KlmizwKwmLaBS5bXE9caKyEhgmZ3cZH8sxG5sIMYJHFEgAB+Lre27jtCWDDBAg9pnYDI/S4Vp2EqFC6QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5683
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLA0KDQo+IA0KPiBIZWxsbyBKYW1pbiwNCj4gDQo+IE9uIDExLzE0LzI0IDA2OjMy
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ2VkcmljLCBBbmRyZXcNCj4gPg0KPiA+PiBTdWJq
ZWN0OiBbUEFUQ0ggdjIgMC8zXSBJbnRyb2R1Y2UgYSBuZXcgV3JpdGUgUHJvdGVjdGVkIHBpbiBp
bnZlcnRlZA0KPiA+PiBwcm9wZXJ0eQ0KPiA+Pg0KPiA+PiBjaGFuZ2UgZnJvbSB2MToNCj4gPj4g
MS4gU3VwcG9ydCBSVEMgZm9yIEFTVDI3MDAuDQo+ID4+IDIuIFN1cHBvcnQgU0RIQ0kgd3JpdGUg
cHJvdGVjdGVkIHBpbiBpbnZlcnRlZCBmb3IgQVNUMjUwMCBhbmQgQVNUMjYwMC4NCj4gPj4gMy4g
SW50cm9kdWNlIENhcGFiaWxpdGllcyBSZWdpc3RlciAyIGZvciBTRCBzbG90IDAgYW5kIDEuDQo+
ID4+IDQuIFN1cHBvcnQgY3JlYXRlIGZsYXNoIGRldmljZXMgdmlhIGNvbW1hbmQgbGluZSBmb3Ig
QVNUMTAzMC4NCj4gPj4NCj4gPj4gY2hhbmdlIGZyb20gdjI6DQo+ID4+IHJlcGxhY2Ugd3AtaW52
ZXJ0IHdpdGggd3AtaW52ZXJ0ZWQgYW5kIGZpeCByZXZpZXcgaXNzdWVzLg0KPiA+Pg0KPiA+PiBK
YW1pbiBMaW4gKDMpOg0KPiA+PiAgICBody9zZC9zZGhjaTogRml4IGNvZGluZyBzdHlsZQ0KPiA+
PiAgICBody9zZC9zZGhjaTogSW50cm9kdWNlIGEgbmV3IFdyaXRlIFByb3RlY3RlZCBwaW4gaW52
ZXJ0ZWQgcHJvcGVydHkNCj4gPj4gICAgaHcvYXJtL2FzcGVlZDogSW52ZXJ0IHNkaGNpIHdyaXRl
IHByb3RlY3RlZCBwaW4gZm9yIEFTVDI2MDAgYW5kDQo+ID4+ICAgICAgQVNUMjUwMCBFVkJzDQo+
ID4+DQo+ID4+ICAgaHcvYXJtL2FzcGVlZC5jICAgICAgICAgfCAgOCArKysrKw0KPiA+PiAgIGh3
L3NkL3NkaGNpLmMgICAgICAgICAgIHwgNzANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0NCj4gPj4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWQuaCB8ICAxICsNCj4g
Pj4gICBpbmNsdWRlL2h3L3NkL3NkaGNpLmggICB8ICA1ICsrKw0KPiA+PiAgIDQgZmlsZXMgY2hh
bmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4NCj4gPiBD
b3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggc2VyaWVzPw0KPiANCj4g
V2Ugd291bGQgbmVlZCBhbiBBY2sgZnJvbSB0aGUgc2QgbWFpbnRhaW5lciBvbiBwYXRjaCAyLiBU
aGVuLCBJIGNhbiBhcHBseSBvbg0KPiB0aGUgYXNwZWVkIHF1ZXVlLiBUaGF0J3MgbWF0ZXJpYWwg
Zm9yIFFFTVUgMTAuMC4NCj4gDQpHb3QgaXQuDQpUaGFua3MgZm9yIHlvdXIga2luZGx5IHN1cHBv
cnQuDQpKYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

