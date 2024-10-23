Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EADD2E008
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3RO8-0007ok-3t; Tue, 22 Oct 2024 22:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3RO4-0007o2-RN; Tue, 22 Oct 2024 22:46:17 -0400
Received: from mail-tyzapc01on20723.outbound.protection.outlook.com
 ([2a01:111:f403:2011::723]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3RO2-0003YS-8Y; Tue, 22 Oct 2024 22:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOvft2KM9GU8ttL31GvvWJEMuu5AXnUwj/Pu9A4EFBhZZz72NjXGqyxnh+3svTdS3eSrDuf+7/pplFk8M/Q7sjUraXYY/E5AmxrlX4kIxz9Ru2s3wH3O8x1g8PT7cZjmzHofyEr5lgkJIiQ7IMsLraLAHR71QsQ9VySkadMEA/2OMeomSkqi842asTK14yRfudlTnCUtX6h0zvufGwFJV5pk1kvKhIwisjRTtSV0QzKVR8NwmqgZYWBWqN451+/pWB8rZKpuU3DyEv8OROgfqGOOUPFcOZAwbf7I4Gd5YIPvbXlY6oNqqW4grRkSI6tNFVSSF82ccFPJzMJpCMnBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGkTsmWwD1tlm8qQc3uwVbRQ+6H9jnd5Qn3Y8IP5hSY=;
 b=eNuVZTlihRDGIkdSAXjvT7wgDRq2O7PGDvBmr9HLBHU0ZXFwucAiwdEygBGqcOCpNSK7RNtOX1gg46OjH3nhVEgeOYqyGTOwRqgSJeHlCTKfLuIpVrxIJmmpYreK2t7nLKYCiE3lZRI24wDX1W//zl2BxhEwbby77MfoS7EwqWCv+5dcwhSJSXwPGY2Hk5EwOAAt9DicfH9RBeqEYw++rkM16SDYr/0jDKVRnwuSSXcCYqSQzc2QgiJEshD6vmLvUyr0kBgScgHn5tOiZDGltkFYrZ7S33qEXWyHMe8QUJE6NYpwC2Hez3iFMKY5sMtsdJ1KcmdqmCkPFxzGH32Kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGkTsmWwD1tlm8qQc3uwVbRQ+6H9jnd5Qn3Y8IP5hSY=;
 b=AcpNih1nqZYh5Om6uqzI9JtTVvcRyXUlg9gvqEbXs/ZRgdMo7dANY0/rI/k89F1YZCdM/4IdQy/JE0VbxHzslpWWpg9LwRc7hMxgXWjFNL4YRGM2DGUalDvhove5TQiI8vzNcZ9o6sJVL+74Do08riKE8tvLJoyM71+xe/yMkCURnHJny+UBGclNhk1Bers1t5eAL3GxtTO4Jefj8dfXtmVY0Ebesp0sX9DWzPWmA0AeZtrknhNDIrbQzm1FPI2g7SB6AL3cFp409hyyX691z5rkaG23yAt3Dsfb/yBTTjgoBc54gNz84b8A181vVfZ3IjdYgDi8VmuOybIQAhH8SQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5407.apcprd06.prod.outlook.com (2603:1096:4:1bb::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Wed, 23 Oct 2024 02:46:06 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 02:46:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
 controllers
Thread-Topic: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
 controllers
Thread-Index: AQHbJGacdxuY7+0jikCm0QDc7o2fGbKSlxWAgAA4TACAANANsA==
Date: Wed, 23 Oct 2024 02:46:05 +0000
Message-ID: <SI2PR06MB5041D0605EA1EC813A09F48BFC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-8-jamin_lin@aspeedtech.com>
 <e1803cd1-f4fd-4d1a-a8e9-5a5ed86c59e7@kaod.org>
 <6118d5bd-342e-41d3-aaf5-4ce9715a9ea1@kaod.org>
In-Reply-To: <6118d5bd-342e-41d3-aaf5-4ce9715a9ea1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5407:EE_
x-ms-office365-filtering-correlation-id: 9ba42334-fc0a-4fe9-b19e-08dcf30cd732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Tm54cTFQSVBDOWN5dUJkRGxvTEdOem5taFhsZlFnZzRSY243NjIraGVrUmNI?=
 =?utf-8?B?eVpmK044YVVwNG9tOUZKMVdFcDh6WGZ3SFh3KzkwUmc5TThRVjNQbVl0bTJl?=
 =?utf-8?B?R01qamJXU3BuanhNN09wRkwwdGNLVU4rR0pCQlJxM1VQbWR2cnVsYUxPeHNj?=
 =?utf-8?B?NWtmMEdSazQwNXVDWUkva0liU3FpTTZyMXByVW9mRlZ2cnJ3UlNLMEZFQXhZ?=
 =?utf-8?B?cG1qRU9Id2xHQmoxeXpHQm5vb3RPcmMwcWZVand2bVN0aHNzUTZueHhHTElF?=
 =?utf-8?B?aEIrb3dEN1RYcFJqS1ZVdWI3MjJGR0o5b2FQMVREUFYxNmhNQWl4SGlCMHJp?=
 =?utf-8?B?S0pjeWxvRGdCZ3Z4N2JLVUdpRzlLMHVYYXNWNEVHVlpYc09LOHppU3k2TnM4?=
 =?utf-8?B?djRzdEt2V1pQcVVGZGVZZnp4NVBGMm9LbTBsL0U2R1RGRk12NTArRVRvMHlX?=
 =?utf-8?B?YkVHSnF4VmZaWHpFWHFvOVdaVkxLZE9WTHdGWHBDN2gzd1h0ZWJMMlRob3hJ?=
 =?utf-8?B?SC8rRW1kWDB3cjU4KzlOeGs5ZzFqc212NHg5N1pIVm5KQnVkdHN6K1Jsd1lj?=
 =?utf-8?B?SFRuUGh6dFdocTFFdEM2UXB0Mm9tYzlkRWVZd0ZuOEJvSDdWeE9FaUlRV2Vv?=
 =?utf-8?B?UUpyZElNOWVWYUVrNGkybEhMZXU0RTIvWFZlVC96TlFmQjhMdE5zbUN4YjVX?=
 =?utf-8?B?UVU0RXlWRkt5N0pnSGRVTGsvQWdBcEMrcW5YTVhRV3k1TzJ5Q255MkNZL1BF?=
 =?utf-8?B?b2hjeUo2RDdKRXFHY3RqSHJ4bFJzd0ZjS1drVlhUYVVkb01ySVcvNjdYdE1T?=
 =?utf-8?B?MXpXcDlGY2IxRmNGbTJCTy9BazVvOEJDYnN1QjFMOVlGQmlPYTlKc3Qwc3Bz?=
 =?utf-8?B?ZWgvUExWSkJUV0VFRFJJbEczTmRHa255V1BsSDFhRDJEMUxLUmtlN0Q3dlJi?=
 =?utf-8?B?ZDdXdUJUaytGcExQdVRxWVdVV3M2Q2xjTkR0enlUcHIwYmV1c1ZIV2ViTXJW?=
 =?utf-8?B?Vk5SK2F3a3o2UUZnYXlySTBIMTdaZytUSEpKRVhRdGxGM3NHRXhnTnRuYlFS?=
 =?utf-8?B?SzhjOFdYbE5yK2Zqcm1mZUJOM2tuanJPODRCRmJNa0I5M0xiWU9CV1JiMCtZ?=
 =?utf-8?B?U2tYbjBwMm50TGVwNExjRWxwcmtpajBZQ1RkSUpTUHFlNnhoOFlaZHQrQUhK?=
 =?utf-8?B?aWFJMW13K0UxTTlYNkNHRlVuenRrMGNNYjkrTHN4TU44M1UvMjNmSTNseFhQ?=
 =?utf-8?B?SlJBeHQ5Z0JscFUxeVhnd2g3V3dpV05kZXI5Q2lyb3g0eUhNVUtkUFNhUjA5?=
 =?utf-8?B?ZTROc0ZId0VsZFZrbW1QU1BqV3A1Q25MQWh0UHJsbjFPRkJ1eHhtY1JyeUp3?=
 =?utf-8?B?V09ycG5wUDhCdTY3cHpKa20vTE1xL2txN1c1UDYrRjVWZjhBREJHalcxT1Ny?=
 =?utf-8?B?elNoUXZjSk1BdThuQ1RHdGZsNW9wQWoyRW4wdVc3ZTlCNGZIY1JuSE01R3Ar?=
 =?utf-8?B?T1NjQVFoZ05EUUhtRStaU1VMWU5WbTZjWFJDRDU0OVd0emNoNEkxRUJXbmdo?=
 =?utf-8?B?cWw2NVpDQWdtd05tSU1URHdoYjZ3cnRpbnRYK2lqcW5qS2RBZFlKVERYVlRG?=
 =?utf-8?B?UEJEenNZcFliTW1teFBLMWI4VTIrcHAwSFZZdmJhNVNqUUppSEU0VmNlY2tY?=
 =?utf-8?B?NU1HbDRpSHdpemZnbHZKeXNMaWxlV1lsVlQ2d0tYUFJyd1pIbkhETHZvM1p4?=
 =?utf-8?B?QmpNWVpER2M4Q3ZYWGhYTzh6Uld3YllhcVVQQmtGck5sc3hEb1BKVmFuTVFX?=
 =?utf-8?B?TmQyKzJuU0ZDWW5IYWkwUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGRGY0F5U0dHUDJiSkdranlTZXJYaGtNaEpXQndGc0VxV3JQbXliVGxQZmVC?=
 =?utf-8?B?cDlza0hqUmVXenNLOURFV1VOT28xY2JDSVBGejg0VHdFd3ZQejdqVWl4UDJM?=
 =?utf-8?B?bVovOVdCWkRzV1p4bnkzRmtLbDdKNUc3VXhLeC9nN3poaG9QQVgvVW1tT1d3?=
 =?utf-8?B?TUh6K2UxTGxramFyRDlCYVdXekRLREdrbFdncWNKOXpPOXhGbVhyZWJnTWRq?=
 =?utf-8?B?N3c3NkRva3J1anEvL09aV2JmV0RsUW0zVmFzUlJzS0Z2c0cyYUNBV0JJVWFE?=
 =?utf-8?B?R29seHYwSjB0TDE0KzBUNDA0L0UvbVNCUTNzTGpGdnBFUFUzcnRUY0cycVJu?=
 =?utf-8?B?MmFzQm1tb0xYR2F1SE00dHpGdUF6amFLNEVaaUJWWjRlQW5wTGYycWhlcGlp?=
 =?utf-8?B?VjNEYzNOSmR3RU5uQTdmemtvZTJ1NlJkWHNFUlJqdlhyKzc3VURndXBxYmZV?=
 =?utf-8?B?RWJLWmFJU240RmxpYStCRnMxekRjQVBzSWtIZFlZemlnSm91R0hEelZ2N28v?=
 =?utf-8?B?UU1vblBlU2hnbzNxSkhlL1VmU05vQ09NWllOSnpCeVdNR0NxRlc2cVZJVnZJ?=
 =?utf-8?B?N3FxQUxkNVNSQU1NQjdrSDZ1aFFRdVdnN0s1QU1ERlE1eTNEbmVqUjhEN21I?=
 =?utf-8?B?anpGYTB5Y0V5czJuN0ltaGhPUk5hQTlBcHBOVkZiUXg1Q3d6ZzlIT1p4emx0?=
 =?utf-8?B?SC8xSkhPR1ZiQ0dDSTVOWDRUTlpZRXp1KzhHUmJPK2tUbEI3UjVjUHhSanNn?=
 =?utf-8?B?a2ppNU5tN3V3ZVNNbi94RFZDNkR4RksvSlF4aWFEME1SSWFwVGNQdFM0UGlG?=
 =?utf-8?B?enFCRDFNTGxxdXdyYmJNdk5XdjEzZkxtSWZJb3RiSXJUVkJkcUsyMHphOVpj?=
 =?utf-8?B?SDBrSWtPQVBnNDZSVXJEcmM5UkJUcDZ6M29kNTBwM280eG1lYlFZTmNyOWdJ?=
 =?utf-8?B?UlcvV0poNDB6ZlV2NlNDOTVQblpPRFFGcFpnM2poUWtTNldRdk91REw5RlRk?=
 =?utf-8?B?Z3doaGpGVVpxRzRMSHpIRE1lOXlHeDJUQnFzdGNEWGprelFPN1h4WVJyREtj?=
 =?utf-8?B?MFJLUlR1c1VkemZrRWFVUXhSdGZXMzhaRmZyN1UxTlVIUis4a2JoZVJMVlAz?=
 =?utf-8?B?akZScVdmZG5QTldJMjRuYmpSVGwrRmJ3clVERitPTUt5R3k3NURkbHRQYkxX?=
 =?utf-8?B?VEd4Y3lSaHpZQTBEeGVVN2s2TTVReER1TW1FWXdoUTRPL1QweWh4YktEdjdJ?=
 =?utf-8?B?QWU1bkpOVEhTRERUNjZqQm8ra3crR1JFL3ZpeGx2eDFBdVNLdWhIR0RWV08y?=
 =?utf-8?B?YUFjL3d2ZFRjejd3Z3V3RzRSSlgwYlMvYnpMU1p0dFdPQmhHMWVWVWVsWGFE?=
 =?utf-8?B?K0l6ekxRc0ZoYWZ3NElxVjBJK3VjSHVCZDYzQmM3eGVST3RrQkxxZjZpTGh4?=
 =?utf-8?B?cHZhOTFjRjNOMzhGeEYxY3QyMHRka1hOK2hwOXZ5VkZhc3NaQlY1dEo5bmZT?=
 =?utf-8?B?VlM2bGtHSUNtWEF0QWNub3kxQ1ZmZk5nWndBSTlIZlRlS3huQytmK25IV1hx?=
 =?utf-8?B?Qk1VVVk1ZnpLSXJTa2pwTXJFMkxSUDJER0czMGZnaytDT0xVQk9vVmFlSmps?=
 =?utf-8?B?RmZtZmhmcFVNbTVOckxPdjQ4ZUZzTXRKSUpJdStlOVQ5UkxWUXhOVENZaG0v?=
 =?utf-8?B?ZTNMMGFSQXlCd1UxMnlSemhvU3hjZysxVTFURHhPeDFqT09saXdsbHEvSWVp?=
 =?utf-8?B?RTBvKzNaNGMyUFpIVGd0OVdKa3lta0dQOXhkQnl4cHhSWFFlYlU2blQrYmp3?=
 =?utf-8?B?TzVvSVBrQ1JxWHBIdDIzUWs4cnVuendHdTBIWUpuU2xib0tBZU52RDBKQ1hn?=
 =?utf-8?B?Z1E0NEZXV2lwMjNuUTg1UkFVTkM1VStCVFljNm93UEc1ZHovZVVZbWVpSjNu?=
 =?utf-8?B?ZG53K2tEcWRxQmhrbGVseGFhOXJsUkJqTWRiakFUYU1YL0ZhTW84Ni9yYUNV?=
 =?utf-8?B?Z2RBeUgySnFNWHNBcE1YRG5kZFV3MFVCU21CR0E5TUVlQnJoU3RPMXZuRzRU?=
 =?utf-8?B?ZVRJd0VJdzVZVzZGM1g3em5QajQ1Z1g3Zkx5TlJ5aGppSmlMOWxYblgxSXB2?=
 =?utf-8?Q?K0FNsfagwl/3qbhAhpdzk4aA6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba42334-fc0a-4fe9-b19e-08dcf30cd732
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:46:05.5160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URdgaZ1bYP5kjrtA6zytp/ONjQW0qy4IEJaFRBccSSNoxpei4NpSrTPFPIpIgPDfZehn3JsMpo8Nd7gVmPXVQUg9tmZcLo+GK5qdjWQ8vPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5407
Received-SPF: pass client-ip=2a01:111:f403:2011::723;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMThdIGFzcGVlZDogRml4
IGhhcmRjb2RlIGF0dGFjaCBmbGFzaCBtb2RlbCBvZiBzcGkNCj4gY29udHJvbGxlcnMNCj4gDQo+
IG9vcHMuIFItYiBzZW50IG9uIHRoZSB3cm9uZyBwYXRjaC4NCj4gDQo+IE9uIDEwLzIyLzI0IDEy
OjQ4LCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4gPiBPbiAxMC8yMi8yNCAxMTo0MCwgSmFt
aW4gTGluIHdyb3RlOg0KPiA+PiBJdCBvbmx5IGF0dGFjaGVkIGZsYXNoIG1vZGVsIG9mIGZtYyBh
bmQgc3BpWzBdIGluIGFzcGVlZF9tYWNoaW5lX2luaXQNCj4gZnVuY3Rpb24uDQo+ID4+IEhvd2V2
ZXIsIEFTVDI1MDAgYW5kIEFTVDI2MDAgaGF2ZSBvbmUgZm1jIGFuZCB0d28gc3BpKHNwaTEgYW5k
IHNwaTIpDQo+ID4+IGNvbnRyb2xsZXJzOyBBU1QyNzAwIGhhdmUgb25lIGZtYyBhbmQgMyBzcGko
c3BpMCwgc3BpMSBhbmQgc3BpMikgY29udHJvbGxlcnMuDQo+ID4+DQo+ID4+IEJlc2lkZXMsIGl0
IHVzZWQgaGFyZGNvZGUgdG8gYXR0YWNoIGZsYXNoIG1vZGVsIG9mIGZtYywgc3BpWzBdIGFuZA0K
PiA+PiBzcGlbMV0gaW4gYXNwZWVkX21pbmlibWNfbWFjaGluZV9pbml0IGZvciBBU1QxMDMwLg0K
PiA+Pg0KPiA+PiBUbyBtYWtlIGJvdGggZnVuY3Rpb25zIG1vcmUgZmxleGlibGUgYW5kIHN1cHBv
cnQgYWxsIEFTUEVFRCBTT0NzIHNwaQ0KPiA+PiBjb250cm9sbGVycywgYWRkcyBhIGZvciBsb29w
IHdpdGggc2MtPnNwaXNfbnVtIHRvIGF0dGFjaCBmbGFzaCBtb2RlbA0KPiA+PiBvZiBhbGwgc3Vw
cG9ydGVkIHNwaSBjb250cm9sbGVycy4gVGhlIHNjLT5zcGlzX251bSBpcyBmcm9tIEFzcGVlZFNv
Q0NsYXNzLg0KPiANCj4gVG8gYmUgaG9uZXN0LCBJIGFtIG5vdCBhIGJpZyBmYW4gb2YgdGhlIGFz
cGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoKSByb3V0aW5lLg0KPiBTZWUgY29tbWl0IDI3YTJjNjZj
OTJlYyBmb3IgdGhlIHJlYXNvbi4NCj4gDQo+IEkgcHJlZmVyIHRoZSBtb3JlIGZsZXhpYmxlIGFw
cHJvYWNoIDoNCj4gDQo+ICQgcWVtdS1zeXN0ZW0tYXJtIC1NIGFzdDI2MDAtZXZiIFwNCj4gICAg
ICAgIC1ibG9ja2RldiBub2RlLW5hbWU9Zm1jMCxkcml2ZXI9ZmlsZSxmaWxlbmFtZT0vcGF0aC90
by9mbWMwLmltZyBcDQo+ICAgICAgICAtZGV2aWNlIG14NjZ1NTEyMzVmLGJ1cz1zc2kuMCxjcz0w
eDAsZHJpdmU9Zm1jMCBcDQo+ICAgICAgICAtYmxvY2tkZXYgbm9kZS1uYW1lPWZtYzEsZHJpdmVy
PWZpbGUsZmlsZW5hbWU9L3BhdGgvdG8vZm1jMS5pbWcgXA0KPiAgICAgICAgLWRldmljZSBteDY2
dTUxMjM1ZixidXM9c3NpLjAsY3M9MHgxLGRyaXZlPWZtYzEgXA0KPiAgICAgICAgLWJsb2NrZGV2
IG5vZGUtbmFtZT1zcGkxLGRyaXZlcj1maWxlLGZpbGVuYW1lPS9wYXRoL3RvL3NwaTEuaW1nIFwN
Cj4gICAgICAgIC1kZXZpY2UgbXg2NnU1MTIzNWYsY3M9MHgwLGJ1cz1zc2kuMSxkcml2ZT1zcGkx
IFwNCj4gICAgICAgIC1ub2dyYXBoaWMgLW5vZGVmYXVsdHMNCj4gDQpUaGFua3MgZm9yIG5vdGlm
eSBtZSB0aGlzIHNvbHV0aW9uLg0KSSBjYW4gc3VjY2Vzc2Z1bGx5IGF0dGFjaCB0aGUgZGVmYXVs
dCBpbWFnZSB0byBzdXBwb3J0ZWQgU1BJIGNvbnRyb2xsZXJzIHdpdGggZGlmZmVyZW50IGZsYXNo
IG1vZGVsLg0KSXQgc2VlbXMgd2UgbmVlZCB0byBhZGQgImRlZmF1bHRzX2VuYWJsZWQoKSIgaWYt
c3RhdGVtZW50IGluIGFzcGVlZF9taW5pYm1jX21hY2hpbmVfaW5pdA0KdG8gc3VwcG9ydCB0aGlz
IHNvbHV0aW9uIGZvciBBU1QxMDMwLiBPdGhlcndpc2UsIEkgd2lsbCBnZXQgdGhpcyBlcnJvci4N
Cg0KcWVtdS1zeXN0ZW0tYXJtOiAtZGV2aWNlIHcyNXE4MGJsLGJ1cz1zc2kuMCxjcz0weDAsZHJp
dmU9Zm1jMDogQ1MgaW5kZXggJzB4MCcgaW4gdXNlIGJ5IGEgdzI1cTgwYmwgZGV2aWNlDQoNCmh0
dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvaHcvYXJtL2FzcGVlZC5jIA0K
IGlmIChkZWZhdWx0c19lbmFibGVkKCkpIHsNCiAgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcygm
Ym1jLT5zb2MtPmZtYywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJtYy0+Zm1jX21v
ZGVsID8gYm1jLT5mbWNfbW9kZWwgOiBhbWMtPmZtY19tb2RlbCwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFtYy0+bnVtX2NzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MCk7DQoNCiAgYXNwZWVkX2JvYXJkX2luaXRfZmxhc2hlcygmYm1jLT5zb2MtPnNwaVswXSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJtYy0+c3BpX21vZGVsID8gYm1jLT5zcGlfbW9k
ZWwgOiBhbWMtPnNwaV9tb2RlbCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtYy0+
bnVtX2NzLCBhbWMtPm51bV9jcyk7DQoNCiAgICBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKCZi
bWMtPnNvYy0+c3BpWzFdLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm1jLT5zcGlf
bW9kZWwgPyBibWMtPnNwaV9tb2RlbCA6IGFtYy0+c3BpX21vZGVsLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYW1jLT5udW1fY3MsIChhbWMtPm51bV9jcyAqIDIpKTsNCiAgfQ0KDQpE
byBJIG5lZWQgdG8gc2VuZCB0aGlzIHBhdGNoIGluIHYzIHBhdGNoIHNlcmllcz8NCk9yIGluZGl2
aWR1YWxseSBzZW5kIHRoaXMgcGF0Y2ggaW4gdGhlIG5ldyBwYXRjaCBzZXJpZXM/IA0KDQpBU1Qx
MDMwOg0KLWJsb2NrZGV2IG5vZGUtbmFtZT1mbWMwLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4vZm1j
X2NzMF9pbWcgXA0KLWRldmljZSB3MjVxODBibCxidXM9c3NpLjAsY3M9MHgwLGRyaXZlPWZtYzAg
XA0KLWJsb2NrZGV2IG5vZGUtbmFtZT1mbWMxLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4vZm1jX2Nz
MV9pbWcgXA0KLWRldmljZSB3MjVxODBibCxidXM9c3NpLjAsY3M9MHgxLGRyaXZlPWZtYzEgXA0K
LWJsb2NrZGV2IG5vZGUtbmFtZT1zcGkxYzAsZHJpdmVyPWZpbGUsZmlsZW5hbWU9Li9zcGkxX2Nz
MF9pbWcgXA0KLWRldmljZSB3MjVxMjU2LGJ1cz1zc2kuMSxjcz0weDAsZHJpdmU9c3BpMWMwIFwN
Ci1ibG9ja2RldiBub2RlLW5hbWU9c3BpMWMxLGRyaXZlcj1maWxlLGZpbGVuYW1lPS4vc3BpMV9j
czFfaW1nIFwNCi1kZXZpY2UgdzI1cTI1NixidXM9c3NpLjEsY3M9MHgxLGRyaXZlPXNwaTFjMSBc
DQotYmxvY2tkZXYgbm9kZS1uYW1lPXNwaTJjMCxkcml2ZXI9ZmlsZSxmaWxlbmFtZT0uL3NwaTJf
Y3MwX2ltZyBcDQotZGV2aWNlIHcyNXEyNTYsYnVzPXNzaS4yLGNzPTB4MCxkcml2ZT1zcGkyYzAg
XA0KLWJsb2NrZGV2IG5vZGUtbmFtZT1zcGkyYzEsZHJpdmVyPWZpbGUsZmlsZW5hbWU9Li9zcGky
X2NzMV9pbWcgXA0KLWRldmljZSB3MjVxMjU2LGJ1cz1zc2kuMixjcz0weDEsZHJpdmU9c3BpMmMx
IFwNCi1ub2RlZmF1bHRzDQoNCkFTVDI2MDA6DQotYmxvY2tkZXYgbm9kZS1uYW1lPWZtYzAsZHJp
dmVyPWZpbGUsZmlsZW5hbWU9JDEgXA0KLWRldmljZSBteDY2dTUxMjM1Zixjcz0weDAsYnVzPXNz
aS4wLGRyaXZlPWZtYzAgXA0KLWJsb2NrZGV2IG5vZGUtbmFtZT1mbWMxLGRyaXZlcj1maWxlLGZp
bGVuYW1lPS4vZm1jX2NzMV9pbWcgXA0KLWRldmljZSBteDY2dTUxMjM1Zixjcz0weDEsYnVzPXNz
aS4wLGRyaXZlPWZtYzEgXA0KLWJsb2NrZGV2IG5vZGUtbmFtZT1zcGkxLGRyaXZlcj1maWxlLGZp
bGVuYW1lPS4vc3BpMV9jczBfaW1nIFwNCi1kZXZpY2UgbXg2NnU1MTIzNWYsY3M9MHgwLGJ1cz1z
c2kuMSxkcml2ZT1zcGkxIFwNCi1ibG9ja2RldiBub2RlLW5hbWU9c3BpMixkcml2ZXI9ZmlsZSxm
aWxlbmFtZT0uL3NwaTJfY3MwX2ltZyBcDQotZGV2aWNlIG14NjZ1NTEyMzVmLGNzPTB4MCxidXM9
c3NpLjIsZHJpdmU9c3BpMiBcDQotbm9kZWZhdWx0cw0KDQo+IHdoaWNoIGRvZXNuJ3QgdXNlIHRo
ZSBkcml2ZV9nZXQoKSBpbnRlcmZhY2UgYW5kIHNvLCBkb2Vzbid0IG1ha2UgYXNzdW1wdGlvbg0K
PiBvbiB0aGUgb3JkZXIgb2YgdGhlIGRyaXZlcyBkZWZpbmVkIG9uIHRoZSBRRU1VIGNvbW1hbmQg
bGluZS4NCj4gDQo+IEFsc28sIHRoZSBudW1iZXIgb2YgYXZhaWxhYmUgZmxhc2ggZGV2aWNlcyBp
cyBhIG1hY2hpbmUgZGVmaW5pdGlvbiwgbm90IGEgU29DDQo+IGRlZmluaXRpb24uIE5vdCBhbGwg
Q1MgYXJlIHdpcmVkLg0KPiANCj4gSSB3aWxsIGRyb3AgdGhhdCBwYXRjaCBmb3Igbm93Lg0KPiAN
ClVuZGVyc3RhbmQgYW5kIHRoYW5rcyBmb3Igc3VnZ2VzdGlvbi4NCkphbWluDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+PiAtLS0NCj4gPj4gwqAgaHcvYXJtL2FzcGVl
ZC5jIHwgMjEgKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
aHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4+IGI0YjFjZTllZmIu
LjdhYzAxYTM1NjIgMTAwNjQ0DQo+ID4+IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0KPiA+PiArKysg
Yi9ody9hcm0vYXNwZWVkLmMNCj4gPj4gQEAgLTQxOSw5ICs0MTksMTEgQEAgc3RhdGljIHZvaWQg
YXNwZWVkX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gPj4gKm1hY2hpbmUpDQo+ID4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKCZibWMtPnNvYy0+Zm1j
LA0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBibWMtPmZtY19tb2RlbCA/DQo+IGJtYy0+Zm1jX21vZGVsIDoNCj4gPj4g
YW1jLT5mbWNfbW9kZWwsDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtYy0+bnVtX2NzLCAwKTsNCj4gPj4gLcKgwqDC
oMKgwqDCoMKgIGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoJmJtYy0+c29jLT5zcGlbMF0sDQo+
ID4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJtYy0+c3BpX21vZGVsID8NCj4gYm1jLT5zcGlfbW9kZWwgOg0KPiA+PiBhbWMtPnNw
aV9tb2RlbCwNCj4gPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMSwgYW1jLT5udW1fY3MpOw0KPiA+PiArwqDCoMKgwqDCoMKgwqAg
Zm9yIChpID0gMDsgaSA8IHNjLT5zcGlzX251bTsgaSsrKSB7DQo+ID4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoJmJtYy0+c29jLT5zcGlbaV0sDQo+
ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYm1jLT5zcGlfbW9kZWwgPw0KPiBibWMtPnNwaV9tb2RlbCA6DQo+ID4+ICthbWMtPnNwaV9t
b2RlbCwNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbWMtPm51bV9jcywgYW1jLT5udW1fY3MgKw0KPiAoYW1jLT5udW1fY3MNCj4g
Pj4gKyogaSkpOw0KPiA+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPiA+PiDCoMKgwqDCoMKgIH0NCj4g
Pj4gwqDCoMKgwqDCoCBpZiAobWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lICYmIHNjLT5udW1fY3B1
cyA+IDEpIHsgQEANCj4gLTE1NzksNw0KPiA+PiArMTU4MSw5IEBAIHN0YXRpYyB2b2lkIGFzcGVl
ZF9taW5pYm1jX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gPj4gKm1hY2hpbmUpDQo+ID4+
IMKgIHsNCj4gPj4gwqDCoMKgwqDCoCBBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYyA9IEFTUEVFRF9N
QUNISU5FKG1hY2hpbmUpOw0KPiA+PiDCoMKgwqDCoMKgIEFzcGVlZE1hY2hpbmVDbGFzcyAqYW1j
ID0NCj4gQVNQRUVEX01BQ0hJTkVfR0VUX0NMQVNTKG1hY2hpbmUpOw0KPiA+PiArwqDCoMKgIEFz
cGVlZFNvQ0NsYXNzICpzYzsNCj4gPj4gwqDCoMKgwqDCoCBDbG9jayAqc3lzY2xrOw0KPiA+PiAr
wqDCoMKgIGludCBpOw0KPiA+PiDCoMKgwqDCoMKgIHN5c2NsayA9IGNsb2NrX25ldyhPQkpFQ1Qo
bWFjaGluZSksICJTWVNDTEsiKTsNCj4gPj4gwqDCoMKgwqDCoCBjbG9ja19zZXRfaHooc3lzY2xr
LCBTWVNDTEtfRlJRKTsgQEAgLTE1ODcsNiArMTU5MSw3IEBADQo+IHN0YXRpYw0KPiA+PiB2b2lk
IGFzcGVlZF9taW5pYm1jX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4+
IMKgwqDCoMKgwqAgYm1jLT5zb2MgPSBBU1BFRURfU09DKG9iamVjdF9uZXcoYW1jLT5zb2NfbmFt
ZSkpOw0KPiA+PiDCoMKgwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNUKG1h
Y2hpbmUpLCAic29jIiwNCj4gPj4gT0JKRUNUKGJtYy0+c29jKSk7DQo+ID4+IMKgwqDCoMKgwqAg
b2JqZWN0X3VucmVmKE9CSkVDVChibWMtPnNvYykpOw0KPiA+PiArwqDCoMKgIHNjID0gQVNQRUVE
X1NPQ19HRVRfQ0xBU1MoYm1jLT5zb2MpOw0KPiA+PiDCoMKgwqDCoMKgIHFkZXZfY29ubmVjdF9j
bG9ja19pbihERVZJQ0UoYm1jLT5zb2MpLCAic3lzY2xrIiwgc3lzY2xrKTsNCj4gPj4gwqDCoMKg
wqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGJtYy0+c29jKSwgIm1lbW9yeSIs
IEBADQo+ID4+IC0xNTk5LDEzICsxNjA0LDExIEBAIHN0YXRpYyB2b2lkDQo+ID4+IGFzcGVlZF9t
aW5pYm1jX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFt
Yy0+bnVtX2NzLA0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwKTsNCj4gPj4gLcKgwqDCoCBhc3BlZWRfYm9hcmRfaW5p
dF9mbGFzaGVzKCZibWMtPnNvYy0+c3BpWzBdLA0KPiA+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibWMtPnNwaV9tb2RlbCA/DQo+
IGJtYy0+c3BpX21vZGVsIDoNCj4gPj4gYW1jLT5zcGlfbW9kZWwsDQo+ID4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtYy0+bnVt
X2NzLA0KPiBhbWMtPm51bV9jcyk7DQo+ID4+IC0NCj4gPj4gLcKgwqDCoCBhc3BlZWRfYm9hcmRf
aW5pdF9mbGFzaGVzKCZibWMtPnNvYy0+c3BpWzFdLA0KPiA+PiArwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCBzYy0+c3Bpc19udW07IGkrKykgew0KPiA+PiArwqDCoMKgwqDCoMKgwqAgYXNwZWVkX2Jv
YXJkX2luaXRfZmxhc2hlcygmYm1jLT5zb2MtPnNwaVtpXSwNCj4gPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm1jLT5zcGlf
bW9kZWwgPw0KPiBibWMtPnNwaV9tb2RlbCA6DQo+ID4+IGFtYy0+c3BpX21vZGVsLA0KPiA+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhbWMtPm51bV9jcywNCj4gKGFtYy0+bnVtX2NzICogMikpOw0KPiA+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWMtPm51bV9j
cywNCj4gYW1jLT5udW1fY3MgKw0KPiA+PiArKGFtYy0+bnVtX2NzICogaSkpOw0KPiA+PiArwqDC
oMKgIH0NCj4gPj4gwqDCoMKgwqDCoCBpZiAoYW1jLT5pMmNfaW5pdCkgew0KPiA+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgYW1jLT5pMmNfaW5pdChibWMpOw0KPiA+DQoNCg==

