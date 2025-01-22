Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA49C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVK5-0005Nl-BU; Wed, 22 Jan 2025 02:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVJo-0005H5-UV; Wed, 22 Jan 2025 02:38:33 -0500
Received: from mail-psaapc01on20728.outbound.protection.outlook.com
 ([2a01:111:f403:200e::728]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVJm-0007kO-VS; Wed, 22 Jan 2025 02:38:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqpBcCN3TWBpKy42txRskdN1FgvCQPPNc/6yDNsQa+x675W4ud/iTBh9fRFuP/kaOzXtG9v3lElzwebn7JtLb95+oDHgQ8W5v+Wt39fJvYmROp0Jy03uQ7jfkGgLO3DrjzB+o27Z+eX2hL0jeeuaoAHrg3q+aLPk44LKZBafN2tZWh1qfbxzKBt8IVk4LDY+MH5JaoymiCQuDp4+kl33v4vWMHHHOF8z+kufLy4GQKpDkQu1VgQbof4sp0Wo5P5mT10YgCr/6fDU0y0kZ4IcLz3t+xn80ZXhqs+gBaOBilElv6GpXJlqxAuz1n2TELCPJYj2gHWol0YeA1qLd2pgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtOajKAYmOVVNDwH9id3yCarI18yWJH/D6/UYngjWXU=;
 b=Rk/+WUZQddXF9IkazqA/5RimBBxqq6Uq/Q9tQfic//Y30E50pEeffjXjjCyE2QPCl3vqSh1FVLEOiZhDjnJDTj6OIWbConTptcepggiWClxqblHRvl/e4AGAfvUVe8AMEA5/Jt78eaf+wgcxpFChCWwpqh3gV20ibZN0BvKfCvgmVU5bKUBqRiLfMvF3pERpklaNrjAcDQEE23Cm4QMDuPc0HUr58tqKh9Q+rjyhRMMTJfQVmpCITTiWxRlr/2/IdNwpLMxcLQZ1L5Ogw3V3xFcif+1Fkv76nbcktS2aIRGHp4oP+Ne4LunUPOMmfzPq03LMTKdmc+O5SVTj9Sy2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtOajKAYmOVVNDwH9id3yCarI18yWJH/D6/UYngjWXU=;
 b=NShyaJEl+6EgxCGaueuco1tAUApIc9DKvf5Meskf6+mICwyX8XnMPCWgoTKujJr68/1fuZYsCrqENByjv3JDMrwAE95Eh6OWK+t1GWZ52gr7eFKdCDduviOd8djXFouRt+E9+2us5wujxcQhfFM3TOIYk+7GHbtZmmExFGviAWgU+w0eAPlHm73remjJxdcoBojV7mXPaZMBpPWehFRJKQQ7R7EErhqjrhByfYJHQDwX34Uh6bmTTTMdUGGVFork5TvjgxFpSQiijp3XmHIGebKZdqsROfiUnDIfI0JER3VHBX7jjAhJ1/gCCvB8GI3nt7+D8sN5ZtPw+pJoHuaoWQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5989.apcprd06.prod.outlook.com (2603:1096:101:f3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.15; Wed, 22 Jan 2025 07:38:25 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 07:38:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Troy Lee <troy_lee@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: [PATCH 9/9] aspeed: Create sd devices only when defaults are
 enabled
Thread-Topic: [PATCH 9/9] aspeed: Create sd devices only when defaults are
 enabled
Thread-Index: AQHbbJyjMWQ/QJteIEOkXuwBjnB6ErMiZ9bA
Date: Wed, 22 Jan 2025 07:38:25 +0000
Message-ID: <SI2PR06MB50410C00EE13E11DCF519EECFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250122070909.1138598-1-clg@redhat.com>
 <20250122070909.1138598-10-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-10-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5989:EE_
x-ms-office365-filtering-correlation-id: 5873b1fc-966a-402d-8f75-08dd3ab7c142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WCt3RnFPNFlrc2Y0UFlvbWI5dk9aeUtTRkFTVmVKRmw0V3BLM005TWt2VGNx?=
 =?utf-8?B?MnJmTDRrdndMQllyQW9OU3lOTDZ2QlpLUzNwOVR1NllZYTYwRVRYWDFvM0VX?=
 =?utf-8?B?UTVERjRaL0RUalZvbVg3WGpYOGphSEkzeG8wVXNkaEYrdGp4VWZHQlpJQ085?=
 =?utf-8?B?NE5ERHR0ZWNuU1B5NFpPaDhldVo2d2hjSnB6SzZFUmlhbkZ0cFo0OTJVQjd5?=
 =?utf-8?B?R0N0eHoreVBzMkZ1OUVxY3ZuV0ZDN0Y5WEZhbUhhSU01VmxaOTVLM054VEdq?=
 =?utf-8?B?dG9GT3BxeDZ3OHIra2cyQk9JQTRwekU2NlBBUytpdElLeFZFN0REamFySjJG?=
 =?utf-8?B?T2NmQW03bFhuaDZGNENBalRyQnd1eFRDT0YvN1d6YWI1ZmhzTHk0dVE0d0NP?=
 =?utf-8?B?VGdqZENUY0RRaXpPYUlLY2tWRFplMFkxRWliamk1QzlIcmh2KzFwUW1sNFVJ?=
 =?utf-8?B?SU9jM3RCRmJ0Y0NPSSs5NDcwU2dPZnRhVWkrVkxIQlpXZEo1RWs1QWFrUFZs?=
 =?utf-8?B?Uks2amtlVC9VUTNaT0tzQzYvU1o1aWhERHhWYTIzL3M3eUUyUU8zaDNPQXRr?=
 =?utf-8?B?ODBoOEpwV2FmSGlQRTQ1ejdrTGRpQ2ZFRm9WWDJjSG5wNDJEdUdKQndOUjVQ?=
 =?utf-8?B?K3BIeW9IMUpWMTJlK0FCYzNuek1IVjlCK1RYYlUvVDZRNUFTNGlZUEJEbHVH?=
 =?utf-8?B?M1ZSOXJ0UUdSb3o0RWJwcFhaQUFBNFB0V3ZnS3ZHakJBUHduNlhldGY1NlVn?=
 =?utf-8?B?eXUzVXlLQWRYS1d1VzhSWUptUGtuSGJDT1hDQlFYRGxkTjBMc2NWZ1A1Sk4w?=
 =?utf-8?B?dzZPQ09xNWFiNTR5WjVBblVGcThRNFN4Sm9EeVlwWkNwa25FanMrWDhzQzJl?=
 =?utf-8?B?eHRjQ1F1aGg5eHBwZHVQbThiek56c2ZIWDlKODVvTXBqbCsydU0rdXNKcnBD?=
 =?utf-8?B?cnJOdTFwYXB0U3JlMWxsaDZvTlZ1RG1nOGFsbHlNcjhnV1duUzZUdHBSRy8y?=
 =?utf-8?B?Uit4dDBmNGFWOUNXcHJxZlpGM2Q2VlJubndpN3hVREhFcTB1WDFyRWlpRzVC?=
 =?utf-8?B?STI0TjM1Z3NQUHlrTG00Z01UeWNDeFlxc3ZKaHBkems1QnBreElDZG9iTE93?=
 =?utf-8?B?M0JPUFlOeDJGR0VIaGFaZ1Bnekw2aVh4UitFNHVZRGFoT215U3lJWkQ0NWNT?=
 =?utf-8?B?cFM4OU9UVnF0NjlqNmtIVHhvQnN5cWtpbWl0b290M240RHl6dWREaW1oSmwv?=
 =?utf-8?B?ZDZrcmpLNkN1U3h2eHpDemMzVG5CZFhQVU03aFFuUkNLbE1oakwwZ2NxcGVN?=
 =?utf-8?B?WDBDR1I3VkI4eHAzRDdyOFRQQXJSQlVTQ2ZBN1I5Q3FQL2wvTUE5WDVhcGVL?=
 =?utf-8?B?WjFSRmFKOG9HOVIvZVlOM2IvcU9aL3FUaHN2RU5Fb0phdUh2MjZkRVVNU2Er?=
 =?utf-8?B?STB5N3pIVHo3Q01RUk1Wd2tsT2FTQjM0WDFhQjZyTUdQK0x6UFBLbm1GSGVP?=
 =?utf-8?B?Zmx6NnJjdnMyZmpiUlQ1czlxSlczT0wxbWJzbVVKU2QzQjV1eGZENktiVU1n?=
 =?utf-8?B?MWd1aFdzUVNHTlVKbndlTVY4WlFkdXZzWEd0NkF6L0lJQzV1eExNZ3dsUWgr?=
 =?utf-8?B?ZCsyQ2ZEdS9Dc213amJoZ0RYVVdlcEc3SnVYWlRicHZJVGFPamhzKzNvOEJD?=
 =?utf-8?B?cG40U3hYeWIzalVaRHd1U2pldjlvdnh1Z29Gd0tNd0VoVzQraWhGbGdiNXE2?=
 =?utf-8?B?bUVqM3ZkSjdQd0ZZa3ZXbFFpSWJGYWovZVlNZzdjL0p5NmE3RE50V1ROdm1l?=
 =?utf-8?B?TUJuRk5SbDBHU3E1dGlHNUNjOCtnK1dsN2JRZFpHZW9xeEN4bnlWNWlNUGtS?=
 =?utf-8?B?RmJLOVlvNFVsK0lDVXNacVpuclBCL0dkVy9rbm9WOE5KSFNuUlJWR3RjcFJZ?=
 =?utf-8?Q?zQ0MpFDY5XU3VfuN84TOcp7q+PSp/MRK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS8xb2R3OHdQZGo5VE9oSjdKWk1vZUR5cS8xRDVIQThFeDliV041Vjh5Rkxn?=
 =?utf-8?B?N3YxcnUxQnhNTmZIbytZSmRGUmJpMHF0NmltcUtHQklQTDA2NzlMYzhjQmU5?=
 =?utf-8?B?UjBwN3JSSkpJTVZoVjN4VXEzNlJoclhqQk5sREVCa2xVRUFWMVNqT2cwREJI?=
 =?utf-8?B?M3pCYllBeXVYS2tWdVNQbXJWMnVPdnFtUjdQYnA3bDhIQmFDUGt2NTNTaXFr?=
 =?utf-8?B?Z29rTGh5RkFhNzVrSUZOUi9mOTRsMjFEWGlYSW1ZQzNxVWRDa0RYamM5dXgy?=
 =?utf-8?B?MzNzOGRvb1dIbXFqVmlxSk1vbnNpc3pidWx1c0J4VkdCWjVwV3BtT04va3J5?=
 =?utf-8?B?c3NTZFNxV2NFMlorYy9xeWdmWGx4YlMwZjhuWlRQbDE5c3U0NzZEZHdTUWxx?=
 =?utf-8?B?VUdpTUJZTlkreW1zckFmNk16bTg2TitaTWpQdlN1TU15Z3lnS3ZLSGxqaXUv?=
 =?utf-8?B?K3o0dElLRitwK3ZEUjJVdm9tbjRkb2taWUJLTitwbnI0eVBZaDd1L25kRDdX?=
 =?utf-8?B?Ym9CeUp6QzU2VG1ObmlUY3RJTUsvVXVtSHkxSzNMOU9zMWRlQ1g1K280c2NM?=
 =?utf-8?B?aktKQTR2aDJjZDlyVEVuMHg0L2xiRFl6YWZOR0oyZFdEUUxFVTRnbElkcTdm?=
 =?utf-8?B?Q2NpMllYYlA2K2paNzFsQUhrUXp5MXNmWG5tUDk0NnQycUMxZmZmcFN0WDg2?=
 =?utf-8?B?aTdJb2tyRzJmakN2NXRwV3RRWHNBcjN5R3FRdXFoWkxERit1aXRsZlZmdURP?=
 =?utf-8?B?WDk1R1BtN2wzeGNhU3c1MVZhQk9heVJMb0dvTFhZd25KaUpVY3hKWHA2d1ZE?=
 =?utf-8?B?NndvdkM0ZHpjaXRPSHdZbnJvTTJmY1dLZU13dVpoZHAwdXVhS09lNVJFNUV0?=
 =?utf-8?B?K0hDVHVsdjdtYnlEeFVNOENzRzN6ajlJUi9HcFNzVGhpWGJqenMrd1N1VWJB?=
 =?utf-8?B?aFVPNWs1cmpKSEhvaERyRFRpa2hqS3V3aDl4QlVDUWdRQ21oU1pzVE5aNitN?=
 =?utf-8?B?bWRaazcwWVIraDRpZFhQazVDdmdtODQxR1FYOHMyQzdka3l1UmxKSEU4a002?=
 =?utf-8?B?TUo1YUU0QVV4TkdQeHhyWU40ZEwyTGFSQks1NlRERXpkZHdFeExHcXh3UnIz?=
 =?utf-8?B?UUh0cW9KUmZjU05VYm1UUnJuUE1mbFExSXBELzVXOW5mYTFNTWNhNkJZVEdO?=
 =?utf-8?B?Z0RvN0JEZ1Vvd0VBY2xHY0tkYjJsckZteDkrcXp1S1VQUm1GK0VublE2QXJM?=
 =?utf-8?B?Y2JVMzFacUJUbXhRQU91Q3grRGUvY1cxczd1YWRXS1M4K0d2RDcxTjlDbHZj?=
 =?utf-8?B?TG9GU0htTlBKNTlpVkZLVVA2eHZ6emJQSFZmeFhSdkZpWjhUeDVNT21tUFVw?=
 =?utf-8?B?bGFLTWZ6Z0xPY01VZFpadWdhVVMwRXNOcktCcHpLTGJhTURHc1ZLUDJ4Lzls?=
 =?utf-8?B?clBOUGFGZXFqb3FCYkhTNnEwSUp5KzBPcGxxa2Q2OWhjdncrUDAwSDVQTkJV?=
 =?utf-8?B?TURLdmJpM09zVFFuRzBTM0ZSeERiNDZ2VWFPSDNsK2RNWGJUV2R2ODB3S1RO?=
 =?utf-8?B?enlJc1JBYzgzYnEzQW0wdzZVUGRkS3BURnVhWGNoQlBPamR2cFJBTVMvaW5s?=
 =?utf-8?B?aEgrVlByYXZURmE0KzY1MzY0TDltdWNGZDV3K0k3bVFReUd1RnVIT0ZpdHQy?=
 =?utf-8?B?NmF5aDFjRmg3ZlZ0ZmE2QUlES1FHVHZJZlF4TmIvOTh0bERyMWh2bnF0V3pG?=
 =?utf-8?B?TTJ6eFpTcVVza21nZEpjRlB1Qjl3cmU5ajF6Z0lnbnd2THhkbWYzalZqSmY4?=
 =?utf-8?B?RUV4MGZ4UTBpZDFaaXF6V2tRbzE4YjJhdGxrSHlUczA2cjgrNUxlVlk1TUkw?=
 =?utf-8?B?UEsyc2RTam9UTlFieDlwZW1icHdDRWl1dFNGRWRCWnIveEgxTC9INE0xNjA0?=
 =?utf-8?B?YS9EWHQ2QUIwVG9kVjR6dFJEcnl1RDRHblA2VVBYbU1jYkZHenNKcXI1YlNV?=
 =?utf-8?B?cDJMMVBJU0h4ZmlYeUhNZTR4K2JkL1RYTzdRbEFBZFcwelFuT01mcDhKRDVs?=
 =?utf-8?B?QURsQ2wrNWNJdTRJZk1jY0R4Q1NYc0J0cFdCOHJTUXRGNkprYlMrQjBmMFdz?=
 =?utf-8?Q?oHRBC8gaE94odFLGDUxuHJ1pu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5873b1fc-966a-402d-8f75-08dd3ab7c142
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 07:38:25.1936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIRSqqblEOBsZNGNyppcQwdxLKfweXqsGLS9OGjbzJ705A5F3XtiLMQMEooLc7Dn1LoCcjWWkIoodZj2ghPWKiANNZ1XQQ89bHsJcuDiKUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5989
Received-SPF: pass client-ip=2a01:111:f403:200e::728;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMiwgMjAyNSAzOjA5
IFBNDQo+IFRvOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2gu
Y29tPjsNCj4gSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBTdGV2ZW4gTGVl
DQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggOS85XSBhc3BlZWQ6IENyZWF0ZSBzZCBkZXZp
Y2VzIG9ubHkgd2hlbiBkZWZhdWx0cyBhcmUgZW5hYmxlZA0KPiANCj4gV2hlbiB0aGUgLW5vZGVm
YXVsdHMgb3B0aW9uIGlzIHNldCwgc2QgZGV2aWNlcyBzaG91bGQgbm90IGJlIGF1dG9tYXRpY2Fs
bHkNCj4gY3JlYXRlZCBieSB0aGUgbWFjaGluZS4gSW5zdGVhZCB0aGV5IHNob3VsZCBiZSBkZWZp
bmVkIG9uIHRoZSBjb21tYW5kIGxpbmUuDQo+IA0KPiBOb3RlIHRoYXQgaXQgaXMgbm90IGN1cnJl
bnRseSBwb3NzaWJsZSB0byBkZWZpbmUgd2hpY2ggYnVzIGFuICJzZC1jYXJkIiBkZXZpY2UgaXMN
Cj4gYXR0YWNoZWQgdG86DQo+IA0KPiAgIC1ibG9ja2RldiBub2RlLW5hbWU9ZHJpdmUwLGRyaXZl
cj1maWxlLGZpbGVuYW1lPS9wYXRoL3RvL2ZpbGUuaW1nIFwNCj4gICAtZGV2aWNlIHNkLWNhcmQs
ZHJpdmU9ZHJpdmUwLGlkPXNkMA0KPiANCj4gYW5kIHRoZSBmaXJzdCBidXMgbmFtZWQgInNkLWJ1
cyIgd2lsbCBiZSB1c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2FybS9hc3BlZWQuYyB8IDQgKystLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5kZXgNCj4gNTNh
ODU5YTZlNGFhLi5kOTQxOGUyYjlmMmMgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0K
PiArKysgYi9ody9hcm0vYXNwZWVkLmMNCj4gQEAgLTQ1NiwxNCArNDU2LDE0IEBAIHN0YXRpYyB2
b2lkIGFzcGVlZF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lKQ0KPiAgICAg
ICAgICBhbWMtPmkyY19pbml0KGJtYyk7DQo+ICAgICAgfQ0KPiANCj4gLSAgICBmb3IgKGkgPSAw
OyBpIDwgYm1jLT5zb2MtPnNkaGNpLm51bV9zbG90czsgaSsrKSB7DQo+ICsgICAgZm9yIChpID0g
MDsgaSA8IGJtYy0+c29jLT5zZGhjaS5udW1fc2xvdHMgJiYgZGVmYXVsdHNfZW5hYmxlZCgpOw0K
PiArIGkrKykgew0KPiAgICAgICAgICBzZGhjaV9hdHRhY2hfZHJpdmUoJmJtYy0+c29jLT5zZGhj
aS5zbG90c1tpXSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRyaXZlX2dldChJRl9T
RCwgMCwgaSksIGZhbHNlLCBmYWxzZSk7DQo+ICAgICAgfQ0KPiANCj4gICAgICBib290X2VtbWMg
PSBzYy0+Ym9vdF9mcm9tX2VtbWMoYm1jLT5zb2MpOw0KPiANCj4gLSAgICBpZiAoYm1jLT5zb2Mt
PmVtbWMubnVtX3Nsb3RzKSB7DQo+ICsgICAgaWYgKGJtYy0+c29jLT5lbW1jLm51bV9zbG90cyAm
JiBkZWZhdWx0c19lbmFibGVkKCkpIHsNCj4gICAgICAgICAgZW1tYzAgPSBkcml2ZV9nZXQoSUZf
U0QsIDAsIGJtYy0+c29jLT5zZGhjaS5udW1fc2xvdHMpOw0KPiAgICAgICAgICBzZGhjaV9hdHRh
Y2hfZHJpdmUoJmJtYy0+c29jLT5lbW1jLnNsb3RzWzBdLCBlbW1jMCwgdHJ1ZSwNCj4gYm9vdF9l
bW1jKTsNCj4gICAgICB9DQo+IC0tDQo+IDIuNDguMQ0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcw0KDQo=

