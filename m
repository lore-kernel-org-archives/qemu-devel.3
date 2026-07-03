Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E38C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXTX-0002RX-8v; Fri, 03 Jul 2026 02:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXTV-0002QO-Iz; Fri, 03 Jul 2026 02:34:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXTU-0000tj-1B; Fri, 03 Jul 2026 02:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMp33tuoNKBx7MEi7woDrhnybZLx24FersbmbVC8BKxyKUwhV8kAyNFCNLg15oWjbKw1aD6UvMNkRO+neqZ7hBrRqV669pvxhp3Wf5dhU4VRE/iy1zHFhGKxLLefJt8GjzcAMEA6fNruRznPgKb13jJX0wt/82dyA9cgDGg0nAwsuT8as/Uy83LZaVA5J12glBysM9y5wcnMx9bWqokeE+2VEoz666wdEBDBTBV/oCBLD4nV0YdI/9jvTI1O9RVdJ9uRc1j7y38qlAmr5azUNhUQX4Spt4aDP4LBqf1mimATz9C/yuGV8FovcV0Nwkkz0ramp3IGpVrmWvZsMVpGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2JkLFvv44EAQZCEkHG4nHPSTm1gEizTOuCws7KNPvY=;
 b=mHVCLpGVngaKi3bM3esko23zV5pF/vENtC3LjlxEyrKHeSUnSiKCGjWGK6bHGPMXBEU2S0In5fdm8A01DGBJBGhgTI1cf5FhDn7kIZeH4XPs+Dz82euxCDGWEalVdGgTj+VEBQ/bwWIxn5NXEL7KRriLcm2/tOs8lfaGojefI89FOwXbkoSO6IjyMBHVcUkjOggLh3AxwNKI1qHR1R500SQ/jOEn+jcA5GUZHMfW/g7jWW/XvSMLLYqicdR822UFFauiuK033Cxtqau25wZVXMGG+tTuY/INSB324hk49FPDt01fU9x+Se4gpvQatH6qmkUXT5CoHYL5Z5oEVLwEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2JkLFvv44EAQZCEkHG4nHPSTm1gEizTOuCws7KNPvY=;
 b=kXL3l3XlB4IbcKyIFzQJ59fBBCzn/QG1f5nc2sRZ0v4MLevp1YeP3K3j81uXuVimNXirA38I3OGLQn0MTQXSWnRfJ7+KKm3mkRw1Vg6MBJWt2Q26+tRvpcu+IETYsY+je3zgm4gUHOzW8TjDQCNlRbVmS/u4FeApzry4wyO4Ch4xvTzysfrlCdS3b50CAvptTbxjBhImkFAI4BuAFRtepGHeycXdKuIxCQI646TUnywlAqDfHqOjwt+Ye9AkfbWjFe8F2quGTA0Ywj/ZKxL7w1x4zDKI85Eeq9yHJnR9roBZYHXNZCXyZXCt1Kl5NL75n6tHgAuP9X5aly/rzDPC1A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5819.apcprd06.prod.outlook.com (2603:1096:301:f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:34:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:34:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 16/21] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
Thread-Topic: [PATCH v4 16/21] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
Thread-Index: AQHczhpU3cM9Z9mdvkCBPFNuzI8AJbYqOYyAgDGWDeA=
Date: Fri, 3 Jul 2026 06:34:04 +0000
Message-ID: <TYZPR06MB49802AA9733CC4AF5D88FFE4FCF42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-17-jamin_lin@aspeedtech.com>
 <f27d1402-3e75-441a-990b-92a146d0648d@kaod.org>
In-Reply-To: <f27d1402-3e75-441a-990b-92a146d0648d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5819:EE_
x-ms-office365-filtering-correlation-id: a8bcbace-847f-4b35-e7af-08ded8cd1384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|6133799003|56012099006|4143699003|921020;
x-microsoft-antispam-message-info: RYEHSIvwc104OKcCA4xPexKqIMopNB84jKw/I0Y7T+4a96EUTCUc6NeK9VpJS20iv6ieFIFX2yCPOITdG39ggPmMPUU5m63DW8ugSATOMX/LZi3sBTh+v6HalVZJQQmG5Hjqye2zzVtogjJqqdtLXdL1odK76YixQ+1+iORaWW9MHfXN5BEtBk/5+a8CuBkGt0+xSIDozyvGFJjCSTJzyhxUS+zMY7Aj1YeG1LAIuSfZm7fz1uNoM11LazlJ59ArNtnliGhlWZ05HesHhkSqcXva8CvzpLoBhKc/tyCT7Nu4ErNOpqlE9/9vOtuj8RQZtwWY2DD/9X9/eh+wBzw2zgPomWBkjW3/Pn24K/62LVwwB5YgjYR1mH/JZysFyisA4ZoPS9FcaKmX1C0qEBUjW2cLgi8dcJqsA1L6EhBZ3GeSKoJ9/hNRe69b2ujuIpIiJNl9dqL8C3kVVLr+Iaj6uxwLGeSr7yw9F0sYQlNZOpOCskgqxxQByeA8QFcX1PR+k9O8JS9RxgYosOytGlWmYVh8l1kFjbCrl1qL8ZcdIlRgAbtZVgu6Lc38Rr9Cyjbr1jw7i0bwB1wiiNU2x/z8D7xHg/6H2XiTwptSXvt4NbjQMyAVZRDqBQmCm6RDRebLzgBOq8l74CB/hZIZBzvf9QVinXRS8CPImx2/KXN38r3K0ZUFlLqmWjrt/kf7oJ/cLFkkHsfNNCgYmC8b7gaNVlOAaiQ9JZlWt0YRWHCvpuYFobZNYBO9CXNTcPIA1+Iq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk14SWVZam9VK1N0akFyUXNBWWVlYmR3eDdPQ215NmNoc3Q1RU5rN0xSaXFV?=
 =?utf-8?B?aTVoUkdjQXlTSjdtYldkaDBsU25ua3dTVUNxSVNwV2JqNDZjY0I4VC9vSTND?=
 =?utf-8?B?OTF0eGI1R2RLZVQ3UEhiaTF2VUU3V0duYlFFcDVQU2VKTzVmZjI4Q1M1ejZs?=
 =?utf-8?B?bWNYTEszQ05YZ2w5ZkFOcE5GNTFoWUp1ekgyTW55M2Y5ak5xUkgxVDNUVXVI?=
 =?utf-8?B?c1VYMnNmMHVlRmhrS2lnZmFDMGpwcEZTWmNEYSt3Ly81NzNkQ1hEaHVoMnpa?=
 =?utf-8?B?clhRYXl5bVpZUDhWSVgzM3ZwS2pCdWxhU3gvckt6U255bVNGbjV0QVZQMGVN?=
 =?utf-8?B?MHlrNHk0ZitpdDdUT3BYUXQwblIrTGVCdmlxT3VoTVhkbjBRd1JpbkpwKy9x?=
 =?utf-8?B?NmJ0RlNXOGRjcmtCdGxBTGgwYkpRWW9nUGVwdG8wVFc3aDFaK2oyaXcwd0dE?=
 =?utf-8?B?OWhYbEJrRFpYcDJBYmJVcTVDR0Z2LzZrT3lsUmtXOEl5dkJwUEErYzZqQnNn?=
 =?utf-8?B?Q2pMbzhEY1dPc0l5RUtSOEpEUXJVTHRRSEtlci91eEYyMXZ1UEIrb0VzNUhp?=
 =?utf-8?B?ZG9mc0gzMTJwamEzRmZ5WXFFZjE4Y2RoeUsrYkdPSzc2cUtnR3JTdEVOdnRv?=
 =?utf-8?B?UGsrNWVwTGZtSkJpU2hlMi9lVVlFY3F4QjZlK0NITGFvYU1TZEJqY1lWdFZ0?=
 =?utf-8?B?ODhYZFlkTFV3ampwYmVwcTc5Y1hJTE9TdnJsSTZBZUtOdmw4b3cwRE1taERR?=
 =?utf-8?B?RkpuNm0vc2JCbVk4dVFiQmlOMlNaSjc3VmVJRGFodUhmWXRWQVI0Y2crOC9r?=
 =?utf-8?B?cFdjaC9RREpHTk81QVg5RlU0N2M5d2pKL3RIUmVXbm4rYWdvZzVUalZ3NnlS?=
 =?utf-8?B?VkZBa3liTVNSQnAyYXc1VVFHclhRaVV0R21sV2JnbDBERitkMzhYL2ZPemww?=
 =?utf-8?B?U1N2QnpVWXViQ0lGQncwMi9IdTE5ZEcwZDB5YlpabVk0SVp3eENqUEhxbnht?=
 =?utf-8?B?MEhpWTJrZnFPVTdqNTRBZGpoSzl4bEMwb040UnpuZFBSOUZWZzhRd3EwN1d3?=
 =?utf-8?B?VXhkclc0V2pzeEp0VUxXbThtc010RS9PYWFKZk1OT3lTTjQyQzA5ZWhxNmg0?=
 =?utf-8?B?SVlyUUJJSEZtQStPQUlCZXNvRjJSblIrdytxd2ttZFl5TklNV3JUUHlxUGFF?=
 =?utf-8?B?Rkc0UmJrKytrUzhWR09Ib1A3R1M0Ym4yQUlkVnBaYW9lTlpiUVpMY2paUXFp?=
 =?utf-8?B?elZIdXFEdDd2eDhCVzVsOEIvM0NFT0JMTVU0R04zRS9NR0ZBU3hEQklVV0Mw?=
 =?utf-8?B?aE1ZMjQ2NnM3cFBYSk52YlAzSFh5a09sK05LUVFXMkhwTFJKQUVFWTJQMEdp?=
 =?utf-8?B?TEpyc0JFYS9iS0hycW1LRm5TRjZ5WWx3WlhERWR6S212aDJuMVV6a2xacTl3?=
 =?utf-8?B?VDZ2cXA3elZyN2VQandrUHBpaVY2K0lLNlJ6cnA4TlpsL3Ywb2ttdEtXSkZC?=
 =?utf-8?B?WGJlVzNuNUVNODNYQlovaXBvY0FPSExiZGUvU0t6dzdZQU4xTnltd05Gc2h1?=
 =?utf-8?B?MEpqNWtudWZib3g0dFJ5NTRtdE50UEk3cUp2QmdTRnd0bWkxY0ZNOFpSWW85?=
 =?utf-8?B?Yjg1QU9vcWMvZkNmSDR6bUJJbE82THdrM1I1S0pnbDByRXdtV0pxRTRaT3l0?=
 =?utf-8?B?K2JxL0ZmeUswenBTMCtOWmNrajUzS2g2clhZRE9nR3kwQjVGWmxzTy9BTi83?=
 =?utf-8?B?cnBkM0dJTWZzUFozKzRhOC92ZmRSMEViRFZUQWFiTFI1MWtZMEFnd1ZsOG9D?=
 =?utf-8?B?OXpoT2p0Q2x4WC9tNi9NR1NISWJ1WkxwRENpMmkwaEtFWnZpN2VOVHQ4R2tM?=
 =?utf-8?B?WkMvc093aEJac1Rkbzc4c2t6UzZXWnU3MGh3akFzUEFTQm1tQnp2QVJ1L0tV?=
 =?utf-8?B?anB0dkRqL0FsQkM4RnhpTFgxcVVOaXlXQnlhT3FJVERla0VNOG9Ud2J5bDIx?=
 =?utf-8?B?bFB2Tm4zeGxzRnpFVGFvcDEzbE5OU0xxdzBwNHprSjRIb2M4SDFaazl3TU5m?=
 =?utf-8?B?enVpdGY5MEVDQkJ4VXVuT1o4RHREZzVSNCthUWljcldRcGh1Zk9VeklyaXpI?=
 =?utf-8?B?b25xL3VFeVR1K1hlalQwNTBDTHhhbTg5UVc1ZnFmTTBhbTdlSC9mbmV1U2hm?=
 =?utf-8?B?ZUQzQmxWdjFXN3JRdGk4QTFnT3ZiS2k4ZUIvWkdxRk9BQ3hwREhHcGFjai9O?=
 =?utf-8?B?ekxZT2E1c1NHYThPdUVNQnIxL2kvVFVCOHJPWmpHM0dBZkxYNnZlK1Fla2Yr?=
 =?utf-8?B?TDllTjk1ZFN1ZU5QWVpIeFBxRFpGdEY3cUhkYi9OZjlMcnFPZmVPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oECxcDizMr/aF5C/T01s7z/O4SbA/Ax6XBWrlD3nL9pmVpyzTyxsX4w/sPiMhlo+5jactsU/pr+tLISOHZKXRbF8w2KmXW5mY/cZ+Nrm24P9Og4mVOAwFTdhMpYBZnCGdAnw1Fh5ol0KIVzVMbtGEHCn3JrF4SfQSjdOIXDHRDNA5zxyBTzKAfRduL7kksENENgghcbRckRJua0KsSRVAPnUQt6QEfnT2rgNZ5PWSYIRT/UcmKaDMfoi6K35iRdxqYd2rOm5Ob63olmACtAKALsZbXy41QsZVKj7YUIM95WF6bO7RI2/KsLyFCTg+n1YGPdTeEqcQclU6u/eEO1e+A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bcbace-847f-4b35-e7af-08ded8cd1384
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:34:04.0423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gv7PIniBnA6riSJtdQFb/6UE81gWHZ4OEnxJ1mThfblp/Z4CSK/95sc7cFqsy482zrxu8FMjBcfBY+IepnZfYTHUEp2tkGDLYaaNqW2IZuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ2VkcmljLA0KDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNi8yMV0gaHcvbWlzYy9h
c3BlZWRfc2N1OiBEcm9wIG5vaXN5IHVuaGFuZGxlZCByZWFkDQo+IGxvZ3MgZm9yIEFTVDI3MDAg
U0NVL1NDVUlPDQo+IA0KPiBPbiA0LzE3LzI2IDA1OjI4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
VGhlIEFTVDI3MDAgU0NVL1NDVUlPIHJlYWQgaGFuZGxlcnMgY3VycmVudGx5IGVtaXQgTE9HX0dV
RVNUX0VSUk9SDQo+ID4gbWVzc2FnZXMgZm9yIGFsbCByZWdpc3RlcnMgdGhhdCBhcmUgbm90IGV4
cGxpY2l0bHkgaGFuZGxlZC4NCj4gPg0KPiA+IEhvd2V2ZXIsIG1vc3QgU0NVIHJlZ2lzdGVycyBh
cmUgc2ltcGxlIHJlYWQtYmFjayByZWdpc3RlcnMgd2l0aG91dA0KPiA+IHNpZGUgZWZmZWN0cywg
YW5kIGRvIG5vdCByZXF1aXJlIGV4cGxpY2l0IGhhbmRsaW5nIGluIHRoZSByZWFkIHBhdGguDQo+
ID4gUmV0dXJuaW5nIHRoZSBzdG9yZWQgcmVnaXN0ZXIgdmFsdWUgaXMgc3VmZmljaWVudC4NCj4g
Pg0KPiA+IEVtaXR0aW5nICJVbmhhbmRsZWQgcmVhZCIgbG9ncyBmb3IgdGhlc2UgY2FzZXMgZ2Vu
ZXJhdGVzIGV4Y2Vzc2l2ZSBhbmQNCj4gPiBtaXNsZWFkaW5nIG5vaXNlIGR1cmluZyBub3JtYWwg
Z3Vlc3Qgb3BlcmF0aW9uLCBtYWtpbmcgaXQgaGFyZGVyIHRvDQo+ID4gc3BvdCByZWFsIGlzc3Vl
cy4NCj4gPg0KPiA+IFJlbW92ZSB0aGUgZGVmYXVsdCB1bmhhbmRsZWQgcmVhZCBsb2dnaW5nIGZy
b20gdGhlIFNDVSBhbmQgU0NVSU8gcmVhZA0KPiA+IGhhbmRsZXJzIHRvIHJlZHVjZSBsb2cgbm9p
c2UgYW5kIGFsaWduIHdpdGggY29tbW9uIFFFTVUgZGV2aWNlIG1vZGVsDQo+ID4gYmVoYXZpb3Ig
Zm9yIHBhc3NpdmUgcmVnaXN0ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IA0KPiANCj4gcGxlYXNlIHNlbmQgZmlyc3Qu
DQo+IA0KDQoNClNvcnJ5IHJlcGx5IHlvdSBsYXRlLg0KSSB3aWxsIHNlbmQgdGhpcyBwYXRjaCBp
biB0aGUgbmV3IHBhdGNoIHNlcmllcy4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiBUaGFua3MsDQo+
IA0KPiBDLg0KPiANCj4gPiAtLS0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX3NjdS5jIHwgMTQgLS0t
LS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9zY3UuYyBiL2h3L21pc2MvYXNwZWVkX3Nj
dS5jIGluZGV4DQo+ID4gMjUxYzIzZGVmMC4uMzYyNzMzYmExMSAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9taXNjL2FzcGVlZF9zY3UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX3NjdS5jDQo+ID4g
QEAgLTkzMiwxMyArOTMyLDYgQEAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9hc3QyNzAwX3NjdV9y
ZWFkKHZvaWQNCj4gKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gLSAgICBzd2l0Y2ggKHJlZykgew0KPiA+IC0gICAg
ZGVmYXVsdDoNCj4gPiAtICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICIlczogVW5oYW5kbGVkIHJlYWQgYXQgb2Zmc2V0IDB4
JSINCj4gSFdBRERSX1BSSXggIlxuIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgIF9fZnVu
Y19fLCBvZmZzZXQpOw0KPiA+IC0gICAgfQ0KPiA+IC0NCj4gPiAgICAgICB0cmFjZV9hc3BlZWRf
YXN0MjcwMF9zY3VfcmVhZChvZmZzZXQsIHNpemUsIHMtPnJlZ3NbcmVnXSk7DQo+ID4gICAgICAg
cmV0dXJuIHMtPnJlZ3NbcmVnXTsNCj4gPiAgIH0NCj4gPiBAQCAtMTI2NCwxMyArMTI1Nyw2IEBA
IHN0YXRpYyB1aW50NjRfdCBhc3BlZWRfYXN0MjcwMF9zY3Vpb19yZWFkKHZvaWQNCj4gKm9wYXF1
ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICAgICAgfQ0K
PiA+DQo+ID4gLSAgICBzd2l0Y2ggKHJlZykgew0KPiA+IC0gICAgZGVmYXVsdDoNCj4gPiAtICAg
ICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICIlczogVW5oYW5kbGVkIHJlYWQgYXQgb2Zmc2V0IDB4JSINCj4gSFdBRERSX1BSSXgg
IlxuIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBvZmZzZXQpOw0KPiA+
IC0gICAgfQ0KPiA+IC0NCj4gPiAgICAgICB0cmFjZV9hc3BlZWRfYXN0MjcwMF9zY3Vpb19yZWFk
KG9mZnNldCwgc2l6ZSwgcy0+cmVnc1tyZWddKTsNCj4gPiAgICAgICByZXR1cm4gcy0+cmVnc1ty
ZWddOw0KPiA+ICAgfQ0KDQo=

