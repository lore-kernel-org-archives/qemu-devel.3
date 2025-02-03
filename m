Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A571CC02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 05:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tep3o-00069z-On; Mon, 03 Feb 2025 00:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1teojc-0003Mt-JW; Mon, 03 Feb 2025 00:18:47 -0500
Received: from mail-psaapc01on20711.outbound.protection.outlook.com
 ([2a01:111:f403:200e::711]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1teojY-0005Bu-Dt; Mon, 03 Feb 2025 00:10:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euYsH2B6smMZ0kIB6pG8Q+fpjKBWPyjnU1Wb8AYrYJSFEIH4I+oElL/8URsi9IkCHG7HhuMgt23bpMT95fLUjS2Qo2tRNIup/kiKlGQznDztsp9zKeh31H73eYjAPb7X8CC4UL/lxg3A7EVwVp/TWCMI4Vka+xul6XYq/ZTXMaRgK6w6LA+A+wCljekxqkDxbspQS2Apjn+zoCMR8IXqzfbO9p2XeLu02Z7YShiTMOVOml/HfsW5M25ZIXxrzf83DO3iIrYArwsYJnVt1hdN3lENr5LaXTDfz3A2gKvLjwEwbRwc0I3e43FFZLt7fs1QwTiDTgCxQUhfqHql4mlfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpt2rMbo5/w9vH/VKE8xJ+t/Sl4maCvdimOk21ilswE=;
 b=x/qH65vVrthdOhlSxSXZntD6hRFRFCGNUtlgPnUMhbUUUvCG2TCZopaTFTTv4Ia4zPvGteYPGBcaRHS6ni+nurAEiJpDBo8dAtq6WEnbao/d+tsFpM/faMqkeD9wYs0kSBDGbTf7SDhyo5wpntsxFbQTWNp/rusdfJf35zAFAFJH8Id/cP0M9t2ezA4LtJk14Nn8AWZddsM+yJxcHZvw3Nc6nnWuRFu/UrCzsB+qngDgmmqeqDYxRyLkqdUjtcRUDjwmZnYBSyrSi9DL4mc4r7XGBL3hmOw7LuorsJMOms5coQrCTfNwhLtJbjlYy9v5nZIKUxpXpGDgBadYUYD5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpt2rMbo5/w9vH/VKE8xJ+t/Sl4maCvdimOk21ilswE=;
 b=gQiy+wHQFn77qJZRVwmwFSiL5XYUNuCLpfzYvECW0PPQX3r2XBA1GJ3EkZsPRtvfBA4K2x7xOpKBuIUW+ZJ5i2mPop/pHNSzmo8hRCzKJUVqv9z6oH0Ox0/m1uDi4iinbZa+bJ/COW4moWqCzTFbOdXb6OBL4g45JeK25uKLJs50t0fR25Fpv4HrnD5pSNnreOYV1OdrSQxvAlEs7JRVu6bjsy7oSRTL9Fs50f3C2PUnYMzDK7uyR++JRiCKJeb6cQlETps1Yf56w3e1cJ66XjUST2GH5tDBaR3XVyVfE/J1dMCo2keU8Zd2qEgfqZYT+Nxiu2CDL1BcOFQInylLMA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5818.apcprd06.prod.outlook.com (2603:1096:301:f1::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Mon, 3 Feb 2025 05:10:45 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 05:10:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>
Subject: RE: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
Thread-Topic: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
Thread-Index: AQHbLHi6iQlWBzxBEUm/weEIg8hbq7Mv9wuAgAWiEAA=
Date: Mon, 3 Feb 2025 05:10:45 +0000
Message-ID: <SI2PR06MB50417C90BD08D97756EF7AC9FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-3-peter.maydell@linaro.org>
 <74cefc5b-a9d0-41e2-b654-985ba225e6ec@linaro.org>
In-Reply-To: <74cefc5b-a9d0-41e2-b654-985ba225e6ec@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5818:EE_
x-ms-office365-filtering-correlation-id: 3cdfba42-2e98-47c3-4e10-08dd44111d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDVNb0wwY0dWYXlWWkZxcHJYTXFPNENZT2FnR3p0aUF2M2dzUFRrU2RDaEYx?=
 =?utf-8?B?RkhOQUdwL3o2TWtOODlkWms1WjNQbVFmaWprZzU1SHVHWXRERTJyd0tEUWFo?=
 =?utf-8?B?VVR4RWVjalQwQnJZQ1BXelJSSWszS2FSR2VpVFJkYityOTNkMEh0RUsvYWVQ?=
 =?utf-8?B?MmNwa2lOUW42QWZqZ3FlL1lxbjU0Tkw3UDdCN09jakN0bjZNUVFQUmc4aVdu?=
 =?utf-8?B?Ly9YaWFDRk9vQ0lTV3MvSXJYc21rSjNtUjlqcmpINXVZMEc5eVUybDArYzV2?=
 =?utf-8?B?L0FWYXZPakJFUjJ0VWlqNmtaR0plZTQ1TUUrR3hXb2JRQmcycWk3NHljcm9x?=
 =?utf-8?B?UkhVOFpuYVFQeHlSUUJ4ZFQrZkZqbksrVmZHWGw5Wk9wU055eWt1TUFFSkJq?=
 =?utf-8?B?TWlXbFdVcW15czRJVU1CYXZ5Q2RycmN0ZStJODFBQjNqZDh6WWZ2c0p2azQ4?=
 =?utf-8?B?a1lXRzhjT2JHaXhMRThaTHNsYkdIMEhwRmdpb08wd2hIaWM2S010QUp1VkNN?=
 =?utf-8?B?dDFyS0pydVgzQnBYc2RQZUhyVFFuYUovZ2lGZ3Y4bEJYK1dNMm5FVmVuT1RB?=
 =?utf-8?B?OXozNWtUNWI4bi9kSDRLUitRMWthREVWcHE1bHFkeHFVLzVRTVNwMlZYOHJW?=
 =?utf-8?B?dDNHS3lLOWxWcWFicE5XaDAveXVLdkpCaVN0WFBPL1hPcW5FUkRabzVEZGFn?=
 =?utf-8?B?dnE3S2pDcEdXenZ6aU9KcGFMYi95SWYxWC9UM2NVZEpPcUE0MENMbmhRWmFi?=
 =?utf-8?B?TzJrTlhJUkF2VFNFZm5TTnhsTVJqU3BKdXowQ0FnZnhHSEQzL0FML1p6Rm5H?=
 =?utf-8?B?eGx2U1BvbzhHc0k1WU1DVk1iZUpJWUF6dEVrZU8vQzFBc0FIZmpyUFp5Y1dF?=
 =?utf-8?B?REZ0YXhneUttV3h4Q3NEcVJYNVNqcUdodnoza21jVXM0Ty9nejFnVVh1TmVn?=
 =?utf-8?B?UC8wV1RSZWMwSGhqQmRDdEdreVRLR1JLTGxsT2RvcnExMURxZmZjN0YwQWdw?=
 =?utf-8?B?bEhkOGpqK0N3OHpjOFo4dmh6ZDMxYnlUVzJGaTNMa01XTmo0bktBdkZsWUw2?=
 =?utf-8?B?UUJRcUl2L1NHTHlCYzAySWZiQ05DTjVlamdXY3NyTUZuUkJrcGFIZFVxYnRx?=
 =?utf-8?B?QkxVZEdKRnBMSDVXcG1DeEdjb05CM0k4UG16MklNc09tY201N2xVQitTdFZv?=
 =?utf-8?B?ZXBvMXhzNHhyelVjSkJ0N1EvdlVRU2FXUWtmWUMwSlNBaldFT1lTL3pVa3Fy?=
 =?utf-8?B?aHhOczQ0REVXcElaNEtJTTRrWE5nNTkzY2lYRFVTRUpyZVgvVFEyd2c5V3pj?=
 =?utf-8?B?OFZiVWd4ZzYxWmJZQ1VHSitOMXhRYmxWT1VaczJteXVSU2JGbzdmQ2swczRC?=
 =?utf-8?B?VnArRHY0QVdMWThSMExVWmFZV0hVWUl1aitqK0o0b1FIc0UybXB6Ym41M2ps?=
 =?utf-8?B?SGNkcDdjRXhwbDVvN2hoTmJLeWtvVVB6UTZ2b3AwWjJVMHJpZHIvSVBWSG1F?=
 =?utf-8?B?WWREQ2tYWllXbVJuMUNtOFhHa2ZVL3gyWjRvc09xMzFVeUZSY3kxVTcybFNs?=
 =?utf-8?B?SmVFOVVUQkxtWVFxdmlEMk9XdTJqSDZ5c3NqTkg0SWFjQ253K1dNN1k3eVll?=
 =?utf-8?B?bFQzZy9SNjVNZEp2b2VLOTBNb0tCcmlIdUxiTldobVZ4eTF2eG1QY2kxWXlE?=
 =?utf-8?B?d1gwS2dJQ3Z0RVd1SkpFZXoxN3VrRGlCbXduSC9qaEN2ZzVFZWpTZm04czIv?=
 =?utf-8?B?bWNnUHZPRHdlNlZPVE9CVUZXVDdGcVFGQjVTZkl6dXp5bkFmUkxISW5SYitK?=
 =?utf-8?B?ZjU1UVlOQlJSdlMvTnBNeE03QVlaTFBvT2RRbllaR0VqR0pRTi9FRXB1QUxX?=
 =?utf-8?B?TlFLWnJocy92MEo0aXJKbmdvanBMenp1Q3pES1lhbUZURmZHWWZQQk4zdG5B?=
 =?utf-8?Q?TvpXeovUemeQxzSQ8ba8MuwjetfYjrk7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2h1WFdJRm5ZR2hqenpuc2tCREdOVzhDNkxuOE90aG9nZGl1UWVEblVHdHlw?=
 =?utf-8?B?ekl1NE9ZVUNDZndpeWoyc21LMU9TZHJOVitWTm9TUlZxOVpxck02TnB3N3p4?=
 =?utf-8?B?SGFIQTh3TDNlbTBCRENDRUlNWEM3NW0vVjcwMzUrWS8xeTZ5WlJ4d0cwbGhJ?=
 =?utf-8?B?bmVnZU13bEt1ME1mcndtNzRpYjJTUkcxKzcwdUI5RmlDT3JNaGo0a2pIOWFU?=
 =?utf-8?B?cW9sbFhoNzJNNXJoWXVxSXcxb1J1di84cGNTbzBTQkMvVU5hbmgrOTJ5WmFP?=
 =?utf-8?B?QlgxeFpXV3FhVDJBK01GMmlQelQ4SERHckRrQVdpeFJWYzBCWTJDSHdGK2NN?=
 =?utf-8?B?VmpLNE5pVEovNXorMGtwMlhDT0VISFQ3K3lhRmF0ZTI2QjcvNjRXT3B2Q3V5?=
 =?utf-8?B?SlJSMXNmZ3RSVEdLYngyZzVpUmpJTVRvRTFqWFVRZDVDY2tmVFRmR1RLYUkx?=
 =?utf-8?B?NDBKVGcxNklNQTVjYW9LMGYzV1dzMU5mcTVaQ2VnTGZOblRWTHVUWCsxZ200?=
 =?utf-8?B?emRPUTFjNWY3Nko3Z3N1cWFEaEZRcWxIaSs3ZmF3UjhtTjZZdVc5WFYzRGRz?=
 =?utf-8?B?MWZtMDFoU2lja28wamJDM2ZaVnVzeUZaSUFFejNMU1c0bVEvQ2szaU9VTGxD?=
 =?utf-8?B?MnduRHhwdVVrUG9QL0JHcXVVUHBscnM3NWJrQjRXSDIwbzVEV2tyVDdWU0lv?=
 =?utf-8?B?a0VEK2Z4UGRSYkJuc0RNQ0hNZlJqR1JVcVMxNkJqQlZTUjZyUXFHM1hJUlY3?=
 =?utf-8?B?ZmxsWnJnUEJUK292dmdkNUxQK0p0aVlwTVZheVhBMVBZL1I4UHAwa2lQNDVJ?=
 =?utf-8?B?NlFLVTBJZ2cwck9QMmxEMG4zSm1rK2t2c2NuU0pMOGE0YkMrWlhSNytGenk1?=
 =?utf-8?B?TXNOaFVTeWRZbGFHNHh0dVpJSWd6bHBYV0NxS0RxYTFXeVBieE5UbkMySnZs?=
 =?utf-8?B?S3hrdlM4WjNlY2kzVDFDVllwME9zendtTWdHM21DQlFBQUViZmVUNVpFU2N4?=
 =?utf-8?B?ZXk1eitxT1V2YjV5SCtoWDZybzQ1L2sra0dwWXI4ZU1PSnBDMllObjg5RDR5?=
 =?utf-8?B?TmFQM1JjN3p4d01KT3k1eDdjQUhES2VUanlRbWRNdFIrY21VRnNtOHFINC90?=
 =?utf-8?B?clo4RnJ3RTNEdmFtT2lWZldMNzFGK3dOOHhSOEUvYkV4cGM3MGdGUXN1UVRi?=
 =?utf-8?B?N215NlhpM05BM0lwbGVGZHlhanl1ZnFMVnJlaGJKYVhTYmVPamptdzl0QzMx?=
 =?utf-8?B?S3FURmVtR3lVOElvbVZOdG9KTEFwck1ZTUNPR3A4ajYvQytUeC82VUFjTzU5?=
 =?utf-8?B?L0Mrc2Z6V1BYalBJaFR5NTIrMkRHbExCc09hYnBVY05oL2lnTVptZ2UwaG5C?=
 =?utf-8?B?akd6Q29Mb2d5NWMwcFJTejJ2dXdDSE1JVlhpK0RBRlZ5cFpvVWpHMjNCbWJC?=
 =?utf-8?B?SUNxbkVJZVlxWFY3QkZQbTNRYUlIQTI5RkF5NnpKdjVtbXFNOHJuV1ZPTUpM?=
 =?utf-8?B?SVZYSkNXbTQyM3VCVy9OWTkzb0JVK1BwL0xScGZRdUcxcEZ0Q3loZVdFeDVw?=
 =?utf-8?B?a3VnTUNxSy9xbG90dE5aNXlWYTNUR3lyemxQWnZjbWhnNXh1SUJ2ODlqcTli?=
 =?utf-8?B?encrQzhvMEUyYnJXb3lRMHRPdWRWQ0NtT0prOFFYUTZzL3hsMWd6V1dnOTZN?=
 =?utf-8?B?MlRrWGJrenVBQnpHZWw1WDVwVzR4a2lmVnJlZVBqNjlUV05zVEVJMVJHVkpV?=
 =?utf-8?B?MmRFSzd5L2NGdE1qWTRYL0VwbFVOMmZsQ3p0QVNlSEhQVHUwbHhSb2RsRFBH?=
 =?utf-8?B?VFlDanJNR1hISWk1MllTaVloV3VNZkd4ZVVmMTl2NFdyS1o1UzkrVzQxSTRP?=
 =?utf-8?B?Z2svWVc2eVBSYXdtUkhKdzJSNnQvMXVYRzFWVEVRZkRzUmU5VjVUYUpGbDAz?=
 =?utf-8?B?ZURtNUM1VU5nTFVVSDgxSVpPQU0yNmZFbm5ZdDBkQzlMSTZJRmFUbDVRWlB6?=
 =?utf-8?B?Z0NCM21HTEp1OXcwM0hNTUQ2QUdERk5XTVcrUWFsUk9sclhpYlg5cGdLOUdo?=
 =?utf-8?B?dzAyTlRqdzg1MUdKNGcwSTlaaEViQVczTmpheVBQWnJjNitQZjBrVEhFUXgv?=
 =?utf-8?Q?li0x15Hr/ntyrwTeid67r7kMs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdfba42-2e98-47c3-4e10-08dd44111d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 05:10:45.0958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl4SZxJp+MMTsgH3i8lmMOe+npwPyZFpKdRf4nWlogBw4uecfCwxyCfLqfPRJMs4SaCLCyXrocbiIpMsCgBpe6SQyQqk8ohdPNOBu5kHhgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5818
Received-SPF: pass client-ip=2a01:111:f403:200e::711;
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

SGkgUGhpbGlwcGUNCg0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDMwLCAyMDI1IDExOjAzIFBNDQo+
IFRvOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEPD
qWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29t
PjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3Qu
Y29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzJdIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogQXZvaWQgaGFyZGNvZGVkICcyNTYnIGlu
DQo+IElSUSBjYWxjdWxhdGlvbg0KPiANCj4gT24gMS8xMS8yNCAxNzoxMSwgUGV0ZXIgTWF5ZGVs
bCB3cm90ZToNCj4gPiBXaGVuIGNhbGN1bGF0aW5nIHRoZSBpbmRleCBpbnRvIHRoZSBHSUMncyBH
UElPIGFycmF5IGZvciBwZXItQ1BVDQo+ID4gaW50ZXJydXB0cywgd2UgaGF2ZSB0byBzdGFydCB3
aXRoIHRoZSBudW1iZXIgb2YgU1BJcy4gIFRoZSBjb2RlDQo+ID4gY3VycmVudGx5IGhhcmQtY29k
ZXMgdGhpcyB0byAnTlVNX0lSUVMgPSAyNTYnLiAgSG93ZXZlciB0aGUgbnVtYmVyIG9mDQo+ID4g
U1BJcyBpcyBzZXQgc2VwYXJhdGVseSBhbmQgaW1wbGljaXRseSBieSB0aGUgdmFsdWUgb2YgQVNU
MjcwMF9NQVhfSVJRLA0KPiA+IHdoaWNoIGlzIHRoZSBudW1iZXIgb2YgU1BJcyBwbHVzIDMyIChz
aW5jZSBpdCBpcyB3aGF0IHdlIHNldCB0aGUgR0lDDQo+ID4gbnVtLWlycSBwcm9wZXJ0eSB0byku
DQo+ID4NCj4gPiBEZWZpbmUgQVNUMjcwMF9NQVhfSVJRIGFzIHRoZSB0b3RhbCBudW1iZXIgb2Yg
U1BJczsgdGhpcyBicmluZ3MNCj4gPiBBU1QyNzAwIGludG8gbGluZSB3aXRoIEFTVDI2MDAsIHdo
aWNoIGRlZmluZXMgQVNUMjYwMF9NQVhfSVJRIGFzIHRoZQ0KPiA+IG51bWJlciBvZiBTUElzIG5v
dCBpbmNsdWRpbmcgdGhlIDMyIGludGVybmFsIGludGVycnVwdHMuICBXZSBjYW4gdGhlbg0KPiA+
IHVzZSBBU1QyNzAwX01BWF9JUlEgaW5zdGVhZCBvZiB0aGUgaGFyZGNvZGVkIDI1Ni4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgNyArKystLS0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgaW5kZXgNCj4gPiA1NjM4YTdhNTc4MS4uN2IyNDY0NDA5NTIgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVk
X2FzdDI3eDAuYw0KPiA+IEBAIC02Niw3ICs2Niw3IEBAIHN0YXRpYyBjb25zdCBod2FkZHIgYXNw
ZWVkX3NvY19hc3QyNzAwX21lbW1hcFtdID0NCj4gew0KPiA+ICAgICAgIFtBU1BFRURfREVWX0dQ
SU9dICAgICAgPSAgMHgxNEMwQjAwMCwNCj4gPiAgIH07DQo+ID4NCj4gPiAtI2RlZmluZSBBU1Qy
NzAwX01BWF9JUlEgMjg4DQo+ID4gKyNkZWZpbmUgQVNUMjcwMF9NQVhfSVJRIDI1Ng0KPiA+DQo+
ID4gICAvKiBTaGFyZWQgUGVyaXBoZXJhbCBJbnRlcnJ1cHQgdmFsdWVzIGJlbG93IGFyZSBvZmZz
ZXQgYnkgLTMyIGZyb20NCj4gZGF0YXNoZWV0ICovDQo+ID4gICBzdGF0aWMgY29uc3QgaW50IGFz
cGVlZF9zb2NfYXN0MjcwMF9pcnFtYXBbXSA9IHsgQEAgLTQwMyw3ICs0MDMsNyBAQA0KPiA+IHN0
YXRpYyBib29sIGFzcGVlZF9zb2NfYXN0MjcwMF9naWNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgZ2ljZGV2ID0gREVWSUNFKCZhLT5naWMpOw0KPiA+
ICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGdpY2RldiwgInJldmlzaW9uIiwgMyk7DQo+ID4g
ICAgICAgcWRldl9wcm9wX3NldF91aW50MzIoZ2ljZGV2LCAibnVtLWNwdSIsIHNjLT5udW1fY3B1
cyk7DQo+ID4gLSAgICBxZGV2X3Byb3Bfc2V0X3VpbnQzMihnaWNkZXYsICJudW0taXJxIiwgQVNU
MjcwMF9NQVhfSVJRKTsNCj4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGdpY2RldiwgIm51
bS1pcnEiLCBBU1QyNzAwX01BWF9JUlEgKw0KPiA+ICsgR0lDX0lOVEVSTkFMKTsNCj4gDQo+IFBy
ZS1leGlzdGluZywgR0lDIGhhcyBBU1QyNzAwX01BWF9JUlEgKyBHSUNfSU5URVJOQUwgSVJRcywg
Li4uDQo+IA0KPiA+DQo+ID4gICAgICAgcmVkaXN0X3JlZ2lvbl9jb3VudCA9IHFsaXN0X25ldygp
Ow0KPiA+ICAgICAgIHFsaXN0X2FwcGVuZF9pbnQocmVkaXN0X3JlZ2lvbl9jb3VudCwgc2MtPm51
bV9jcHVzKTsgQEAgLTQxNyw4DQo+ID4gKzQxNyw3IEBAIHN0YXRpYyBib29sIGFzcGVlZF9zb2Nf
YXN0MjcwMF9naWNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LA0KPiA+IEVycm9yICoqZXJycCkN
Cj4gPg0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBzYy0+bnVtX2NwdXM7IGkrKykgew0KPiA+
ICAgICAgICAgICBEZXZpY2VTdGF0ZSAqY3B1ZGV2ID0gREVWSUNFKCZhLT5jcHVbaV0pOw0KPiA+
IC0gICAgICAgIGludCBOVU1fSVJRUyA9IDI1NjsNCj4gPiAtICAgICAgICBpbnQgaW50aWRiYXNl
ID0gTlVNX0lSUVMgKyBpICogR0lDX0lOVEVSTkFMOw0KPiA+ICsgICAgICAgIGludCBpbnRpZGJh
c2UgPSBBU1QyNzAwX01BWF9JUlEgKyBpICogR0lDX0lOVEVSTkFMOw0KPiANCj4gLi4uIHRoZW4g
b3VyIGJhc2UgSVJRIHN0YXJ0cyBhdCBBU1QyNzAwX01BWF9JUlEgKyBpICogR0lDX0lOVEVSTkFM
LCBoYXZpbmcgaQ0KPiA9IFswLi4zXS4gSmFtaW4sIGlzIHRoYXQgY29ycmVjdD8NCj4gDQpDb3Jy
ZWN0Lg0KVGhlIHZhbHVlIG9mICJpIiBpcyAwIHRvIDMgYW5kIHRoZSB2YWx1ZSBvZiBpbnRpZGJh
c2UgaXMgMjU2LCAyODgsIDMyMCBhbmQgMzUyLg0KDQo+ID4NCj4gPiAgICAgICAgICAgY29uc3Qg
aW50IHRpbWVyX2lycVtdID0gew0KPiA+ICAgICAgICAgICAgICAgW0dUSU1FUl9QSFlTXSA9IEFS
Q0hfVElNRVJfTlNfRUwxX0lSUSwNCg0K

