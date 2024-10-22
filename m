Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6DBD1714E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t33y8-0005L5-7r; Mon, 21 Oct 2024 21:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33y3-0005KL-TH; Mon, 21 Oct 2024 21:45:51 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33y2-0007BU-0Z; Mon, 21 Oct 2024 21:45:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LADINolJZ23ooIEiZ3L1TUQ6qdR8WORCfPoLNmS8vpdNVxVeSg5l4DrRffh7TvKTdF636QwG5JfnpbFpMe2Nq08r5ZInaV5pDeNSGiFmxir/zRHDhVZVbl/33Wu/ZjD0y9wKmq4me1GgxLx5nbMw8pbADi1+9rpgjyui3gF5XWNxub0WsmudNgPuK3vOXK0lzdHnWtt7aLiE5fGimQ6GuhjNCo0Ns9jE2SJV1LF1e3J4zVfO1DRk6lpHZ4Rr1N2VF4optYvnsycCkc36BvBG0ZYTww21vGiC8YFtOEKc4+IaHK+qAFfHQVkzFfg9Vtit9B/Dn8P/J21+hTyMr7fygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLuYn6WQ6HpQ4A584XREBKZJ7IUw4oRFpL8E/AjXeok=;
 b=QJhuTdxhpKAB3d/UVreAEi2Xw3lupNeLzaiKBdbaOsWvj0pCMnN2GL1Ru1er0+kc7i8WUgbwh25RgY3Z00TldcC8j+n9XJ7iN+VGSFEdvrrgJwLt6SaFWYCVAifm4EwJizHmCOuQMAumwelRyVmw76XEBSozOLWwycA4zVpCIAmyzrZv+wh6FW9YD9xvF923pPprh9e80RuNsKCe517nnYVGJhjsJ3LEHSAqySzDf5ep6E+gywj+dhHIdT02OCDAPTiObanHoj49vq3Nge4YK6pIxscwdIiYjaL44+er8AOG/n2CAlP+MO/EfEhO4X4xI2r4rZBJs0+R/QaGJ8MLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLuYn6WQ6HpQ4A584XREBKZJ7IUw4oRFpL8E/AjXeok=;
 b=fk0U3rWziKCFA8YWtd9gxfkN4328rly5rC8uCmGbKPeJXPy07K3iiHqjOnzid/bhJJkDGuKmU7EBxQ1rRn9ekkaZHFjeKhqZLHP0JFm+e4CLKcRGtEc/kXSnDNQQUsVwuRL5r7cKeNtQLPB72wMAvGBLf/u0vFt+qqLabdyrl3NaJyq5YKQHVpfxlG1kcnMKESzdQyIk6M8768GwFkx4UeEsWY4BicALqv5XoGLrWNh//plx0fmh3PfbGilO0Skl5OC/E0AYiyxJyPNu4IzZ/9sk5GKVwA0LqPreqWUg08E7dcINMRcnDoBRNeREiHXhYkFOcoPSwVjhi7X1bJ9wxA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB5370.apcprd06.prod.outlook.com (2603:1096:400:1f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.14; Tue, 22 Oct
 2024 01:45:43 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 01:45:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 11/16] test/qtest/aspeed_smc-test: Support to
 test all flash models
Thread-Topic: [SPAM] [PATCH v1 11/16] test/qtest/aspeed_smc-test: Support to
 test all flash models
Thread-Index: AQHbIR79Icmd3KnXX0eKCqlWinj/MLKRKkEAgAC294CAACRUYA==
Date: Tue, 22 Oct 2024 01:45:43 +0000
Message-ID: <SI2PR06MB5041E41727CEFDDFAAA280E9FC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-12-jamin_lin@aspeedtech.com>
 <777c3650-5e02-4ab0-a900-ecb0e425b935@kaod.org>
 <df7845ea9bb3b4841ba18dbeb10e9b109a28af51.camel@codeconstruct.com.au>
In-Reply-To: <df7845ea9bb3b4841ba18dbeb10e9b109a28af51.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB5370:EE_
x-ms-office365-filtering-correlation-id: 04518f19-b741-447b-6898-08dcf23b3dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?WjhmaHN5Ui9WcUljeE10UlR0c3FTVXFXRVVERHpaSzVLcDg1N3RON0hoNTlV?=
 =?utf-8?B?V3lQSTV3d25UTnU0VjZnakZ5WTcwT1JBNERnNi9RTStBM0dXS3pWSTRrWC83?=
 =?utf-8?B?YU9CTUlhOE1MTjRDcExRM0ZOTkRraG51dDh1Wm9aNFhqTnhTbE1EY1NwdGt5?=
 =?utf-8?B?OEFrVlZlVmo2eC9ROHpUd0RWV250akMvK2l1OFhHejJRbkxVR1RjS3NpL1VN?=
 =?utf-8?B?ZS9WbEZZRUNCc2RWTmlUSktiQW0yODBTUUxRK0p5OWZrVmUvVnNFdWtlTDdi?=
 =?utf-8?B?WE1TNXNLUlVlZ0h1aG93TGtMT3h4aVJWNWQwUnlhUmlVTExwZ3BpbmxCN3ZO?=
 =?utf-8?B?UHBmRGRWQzlzbzBjQVZpUkh3RHBhLy9mY3dwV1dFWDJqM1F5VURzbTNFaW5E?=
 =?utf-8?B?YWFzQTlhNk5aRXVXMkJ2Wml5czRsZEN2enhVSjdOTlB4V0d4YXhETFlKbjZQ?=
 =?utf-8?B?TDdvS0FISldscnl0dkV4RGZTbENVUERXMFhHZWJSRnlnZEpRckdadnJaZjhn?=
 =?utf-8?B?MHNIWmhNT2NMTTR6bW9mVkVkbG5lNzZuYmY2MmpBNHFTZC9zUTFjK24rMXlK?=
 =?utf-8?B?eUhMeVhlbytRKzI3d0luV05KZTNGTWxTTHAvdnRZYTRiNVYvQ1JOTzlaYzFv?=
 =?utf-8?B?aDhObHFpQXBrYWY1WkdvUUVFMG5FNlI3OE9WYjdUbndJdzk4ODdnd2JXUnBs?=
 =?utf-8?B?ZE9nQk9LN2Q3Y1F0dlUxMXRDMUFJSHVKK3VIVFZyNVZFQW5adTc1dGp1eFZv?=
 =?utf-8?B?TE5BNGszajFEUDdaRjRVUTBZUzF2RkxDWXRVUHhLYStXN1FDWVZ2Ync0bGpa?=
 =?utf-8?B?TVJSNEFuQUdzaDVUdkZzV2pYQ0h1eUhkVlplOTZpSmtVV1JNaFRkaWYxc1ZT?=
 =?utf-8?B?RmdzSmpoSnc3SkhaRVdWOElNWUJTcEpzeUpXOCtIRDhTSVZNeWZ4V2RzTnVm?=
 =?utf-8?B?aE1QYTVyUXlBWEM0RE1jU2NWNG9hc1V5Y05PRk1MeFMzOGpSS3hCdFZkR0t3?=
 =?utf-8?B?d0JqMnYyRU9HbTBQVXAzemNBb01Oa1JGWlRpaTZPU3VtQjliSjZDajhEK01m?=
 =?utf-8?B?S25UV3FReU9GeGZMM0IyalU5Nkd4QUxLVXJGenVjSEIzRm54L01kdTlCMWt5?=
 =?utf-8?B?emI5SjBIUFpQa0pFN1pDdGZUcVBsVnM5TnRFa0RWV1BTdVhVeitvZ2lzSVNF?=
 =?utf-8?B?ZHJRS1dDUSt5akordXdEOXk4VGtabmFPZm5MYzRGTzBNMUc2d05zdzNWSS9S?=
 =?utf-8?B?bnZiK0w1S0duemlqcVB4QnhqdG5GWEI2V1AwOVM4MnBUMkFxRkI5WFl1WFpz?=
 =?utf-8?B?ZStUUFp1VlVTOXNDSlJteXhjcHk1VGdoZEF4WVh1aFcxMEJCVVJpaU9kMU42?=
 =?utf-8?B?NSt4d0RMa3o1S2hMb2dDbXRYWW41eEhSa3Y4NS9admZOK2pVTEh2S1lNMWNq?=
 =?utf-8?B?RkwxdGx6c2xmaldUR1c2Wm9JakFSRlVoMi9OczRVc3Jub3FQc3hZMlpEVUx5?=
 =?utf-8?B?RmlaRVRORWF0K2hXY2UzQTN0YXJLT0srczRLRk84b2VyZ3lzUjJwdGp4aXI4?=
 =?utf-8?B?OTN2a2VQOGxVa29RSmpMeUZndlVNd0FMUUg2ZE1acituZk1uNXNGL3BScVpX?=
 =?utf-8?B?LzJZUWtqQWo5MnhvbmJjWlVPdTBhbmtFWVdkR291NC9oL2pzUFl6N1BTaW8z?=
 =?utf-8?B?OFF3YlRDVy9OeEdNbXE0clB2cTJEcmF5VjFuWnlYK2FobDlQQkVzeVU4d0cw?=
 =?utf-8?B?UWI5enNuTzdlNHhHbWlla2FJRkJGLzE5UDNlSFhvZ09wMXZqWEJQQTJPVEJG?=
 =?utf-8?B?bkorcm1UNElmNVhCZ0ZLdG1lOUxOZ3FlbFBFUjZ6eWlVT3pCbXlNbmNqRFRD?=
 =?utf-8?B?RU1yanZpNmRzRTBXK08vNlJPOUVoS3g5VzJ2OXFJUDZ3cnlWaTNTRHBNMFZa?=
 =?utf-8?Q?pAs45rslipM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZStoRVZzbUgwSGNKaTJSd0Ftc25XTldVUFBjYmlzaEJPdFpjVFluQno4RFlq?=
 =?utf-8?B?ZGF3N0t3ZjBwTU1QY0ZKMjhaaXMwb3ZEUlMwdFo5YUhiREFmbWlESzRSUno2?=
 =?utf-8?B?djVLK3Y1aVo2RHJyZUYrOWcwRTlsOTlwT2pEOVVtSXNUN0xnMUlsc0luRmJh?=
 =?utf-8?B?cU9Vb1huZ1dneDFDdUkvTEZtVzJsMGNNenNSS1c0K1RZT29IbEEvUmJIaDlV?=
 =?utf-8?B?ZXMxQTVYS2l1YXN1c01hbkQ4ZlBTR204TVErUlVaOFFObTFFZStSU2hBRDUy?=
 =?utf-8?B?S01aTDZmSnNmcmN0a0VTcW5Md1hlMm1ibHdDUlRRZHlrYStmbHFEaFZkb05m?=
 =?utf-8?B?TjJVUUg4a1lqZklOWjY3NzdGK2IxbE01Uk0xMjlNLzQrZUgvT0pXOHhzYlNq?=
 =?utf-8?B?YXFMSXorRjRldDFKVFJwbGNCN0JuSUgvRElEbUEvVUcvbzljM0pDVXBGNHMr?=
 =?utf-8?B?WTB2aWJ2YTRlRlA4a1VYenIzaVp6ZDlUL2txVlhJS2NGZkdnM3hZcEFyZndD?=
 =?utf-8?B?WTZrUXI0bGZTR1lwc1lQL3dQYThaMThsYmZRNWNpYThlVUxzMVQ4Z1o0a3pT?=
 =?utf-8?B?OEJOMVYzUzJwOHVsSWJmdXVveTRwbTFaWnAxbkNqWUYxVnI5QmFFazgzQXc2?=
 =?utf-8?B?ZzJOanlzc05zNVVZaFpLSzYwN1NFdlR3N1VudWZDbjRGNlNoWkQ3VllPamxU?=
 =?utf-8?B?Ty83cFJpNjk4b3N0TmQ0RDhFVGhoN1poRlZjY2ZsYnlDcEtPajRlczZFYzQy?=
 =?utf-8?B?N01DdG5RUUlyUVdkQkdsNEJOQmNNNFNlM3pyZE5rWkpaNFlKZjA0NHFOKy9O?=
 =?utf-8?B?R2ZMNjF6cnB0dUd4ZjVsUFVlcHcxTGo4cUFsdzdyenJybnNxNFIrMmtVUjRn?=
 =?utf-8?B?Z2l0alFPZ2twWDZmOFgwV2hqQUhYZ3NlZFR5WVI3MWdpOGFtOTloMDN5OUEx?=
 =?utf-8?B?d2Z2Rm1ZRkh3Rmh0cHkxYUxZekJOUXpTSW9LNWdOODNxbzl4WStHVjNLWWxi?=
 =?utf-8?B?WHM3WUpndHJTV3JIcTVUQ1JURldHR1U5K2FyblF1ZWY0djhRYTJwZElTSjJs?=
 =?utf-8?B?eDdmdTlkNEI0c0k0cVlNN0grOEZKTjNyK2RqcEg1V3lVMXlVcWI3Q1NnZ2ZF?=
 =?utf-8?B?SWtJU2dhcFdMMFhsSHZUeTRoWENCVTUyekZMZ2dBbXpKOE4wR25tYngxUnh6?=
 =?utf-8?B?T1N5OU4veVlsekRKcm9lU3pCUVBsRUVYVldYQTdxbStLbnpFU2gvNElhNkYv?=
 =?utf-8?B?d0ttNDBCNnhjNFEyQlg4Zk8rbisxSEFMMis0aFU4Y25naTVPSlhuQTl5SnZ4?=
 =?utf-8?B?M1l3enluQnZndUthNVpPTkV4RFRLSDJFWnNhM3ZoamFaZmhQdzdyc2s5UkRp?=
 =?utf-8?B?NlVhdnRsdHRuV25wbmk5djdsc2g4RGVDUGJrWUtsYXQ2RG5YWUZ5OFN5RWZY?=
 =?utf-8?B?alorMzhWcHpSWXdEQzhDTTJTeHNXWG13V1hSLzREK3dlSGpZaXhJaThiQlBI?=
 =?utf-8?B?c24vVDJjSVI5ZExPcDZFc2E5aGRQREVhU0xkU0FJRHNGV0JsNUt2MU04MWIw?=
 =?utf-8?B?aXFVS2tzbE16TjBjNDV2T1ZhcUlKc2YvaG41STVvTXIzNlFoNHFLT2JXbDcr?=
 =?utf-8?B?YXdrRTNHaHRQTWVWRVFzeFZnNW96dDJHeFBJMnNCWjNhRHRhRTJNbUF3TXJH?=
 =?utf-8?B?Yjc3WEwyc04wb3NwNWN5aUt0TFhUUzEwNVByZUY3bDUzcjlsQ3ZmRDROOUtV?=
 =?utf-8?B?NDUwVDV5MFQ5dTU1QjJySFhIZkZnVjlDck9sR2xjQ2xOamhIdEY1MkluNWtw?=
 =?utf-8?B?SXBROGtITW5XcVBYUXp6SGZvUWhtQ1ZvOWNZWThZNG52SVZ1TGZrOWp1QS9D?=
 =?utf-8?B?R0RFUUxIQ1BkOW9yVW1ZaE1kb2lHbnlNV0dJc0ttbk1pbEF4MjZFVFdpaXRy?=
 =?utf-8?B?NkIwV2VuM3BqR00vV3Q5ckdTRzRRVUl0U21zR3ZJT3duK2VpUTY0dkw4WnBr?=
 =?utf-8?B?R2hjQVdKR0VtMFpxeHVhZ3ovQ3dyWExOc0ZpYmlwWWI4UGh5eDh4MjhENUVX?=
 =?utf-8?B?eURQWlVHQVZjLzNROTRxTTZkbUhVSXlVNnluSVZRQWRTSHRHbDZrcHNpSXlM?=
 =?utf-8?Q?swKOdbCDBIu5sRz9CMN35BLI9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04518f19-b741-447b-6898-08dcf23b3dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 01:45:43.6092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sg27ZyD47PxpfbkSk/XUg5d7B262IaMtTwIlNs5HVSqyVG3E2tNauDX8lVkTW6ih7n+Y/+CVws39PenPiGLqpO1m7hfTYKqCo6/LmEL8+J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5370
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQW5kcmV3IGFuZCBDZWRyaWMsDQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFs
aXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2
KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53o
rbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu2
6YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzp
m7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3m
gqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNo
bWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVs
ZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlz
Y2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4gDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCA3OjM0IEFNDQo+IFRvOiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUgPGxl
ZXRyb3lAZ21haWwuY29tPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBLZXZpbiBXb2xmDQo+IDxrd29s
ZkByZWRoYXQuY29tPjsgSGFubmEgUmVpdHogPGhyZWl0ekByZWRoYXQuY29tPjsgVGhvbWFzIEh1
dGgNCj4gPHRodXRoQHJlZGhhdC5jb20+OyBMYXVyZW50IFZpdmllciA8bHZpdmllckByZWRoYXQu
Y29tPjsgUGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IG9wZW4gbGlzdDpB
U1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47DQo+IG9wZW4gbGlzdDpBbGwgcGF0Y2hl
cyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QmxvY2sgbGF5ZXIN
Cj4gY29yZSA8cWVtdS1ibG9ja0Bub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVl
QGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2gu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MSAxMS8xNl0gdGVzdC9xdGVzdC9h
c3BlZWRfc21jLXRlc3Q6IFN1cHBvcnQgdG8NCj4gdGVzdCBhbGwgZmxhc2ggbW9kZWxzDQo+IA0K
PiBPbiBNb24sIDIwMjQtMTAtMjEgYXQgMTQ6MzkgKzAyMDAsIEPDqWRyaWMgTGUgR29hdGVyIHdy
b3RlOg0KPiA+IE9uIDEwLzE4LzI0IDA3OjMxLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPiBDdXJy
ZW50bHksIHRoZXNlIHRlc3QgY2FzZXMgdXNlZCB0aGUgaGFyZGNvZGUgb2Zmc2V0IDB4MTQwMDAw
MA0KPiA+ID4gKDB4MTQwMDAgKiAyNTYpIHdoaWNoIHdhcyBiZXlvbmQgdGhlIDE2TUIgZmxhc2gg
c2l6ZSBmb3IgZmxhc2ggcGFnZQ0KPiByZWFkL3dyaXRlIGNvbW1hbmQgdGVzdGluZy4NCj4gPiA+
IEhvd2V2ZXIsIHRoZSBkZWZhdWx0IGZtYyBmbGFzaCBtb2RlbCBvZiBhc3QxMDMwLWExIEVWQiBp
cyAidzI1cTgwYmwiDQo+ID4gPiB3aG9zZSBzaXplIGlzIDFNQi4gVG8gdGVzdCBhbGwgZmxhc2gg
bW9kZWxzLCBpbnRyb2R1Y2VzIGEgbmV3DQo+ID4gPiBwYWdlX2FkZHIgbWVtYmVyIGluIFRlc3RE
YXRhIHN0cnVjdHVyZSwgc28gdXNlcnMgY2FuIHNldCB0aGUgb2Zmc2V0DQo+ID4gPiBmb3IgZmxh
c2ggcGFyZ2UgcmVhZC93cml0ZSBjb21tYW5kIHRlc3RpbmcuDQo+ID4NCj4gPiBUaGUgY29tbWl0
IHRpdGxlIGFuZCBkZXNjcmlwdGlvbiBhcmUgY29uZnVzaW5nLiBCeSAiYWxsIGZsYXNoIiBtb2Rl
bHMsDQo+ID4gZG8geW91IG1lYW4gImFsbCBBc3BlZWQgU29DIiBtb2RlbHMgPw0KPiANCj4gSSB0
aGluayBpdCBvbmx5IHJlbGF0ZXMgdG8gdGhlIFNvQ3MgaW5zb2ZhciBhcyB0aGUgQVNUMTAzMCBl
bWJlZHMgc29tZSBmbGFzaCBpbg0KPiB0aGUgU29DPyBPdGhlcndpc2UgaXQncyBkZXBlbmRlbnQg
b24gdGhlIGZsYXNoIG1vZGVsIGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gYm9hcmQ/DQo+IA0KPiA+
DQo+ID4gU2luY2UgdGhlIGNoYW5nZSBpcyBpbnRyb2R1Y2luZyBhICdwYWdlX2FkZHInIGRhdGEg
ZmllbGQuIEkgdGhpbmsgdGhpcw0KPiA+IHNob3VsZCBiZSB0aGUgdGl0bGUuDQo+IA0KPiBJIGFn
cmVlIHRoYXQgaW5jbHVkaW5nIHNvbWV0aGluZyBhYm91dCBwYWdlX2FkZHIgaW4gdGhlIHRpdGxl
IHdvdWxkIGJlIGFuDQo+IGltcHJvdmVtZW50Lg0KPiANClRoYW5rcyBmb3IgcmV2aWV3IGFuZCBz
dWdnZXN0aW9uLg0KDQpXaWxsIHVwZGF0ZSBjb21taXQgdGl0bGUgYXMgZm9sbG93aW5nLg0KSW50
cm9kdWNpbmcgYSAicGFnZV9hZGRyIiBkYXRhIGZpZWxkDQoNClRoYW5rcy1KYW1pbg0KPiBBbmRy
ZXcNCg==

