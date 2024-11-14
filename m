Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21A7D65C57
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 08:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVVF-0000Lo-T8; Thu, 14 Nov 2024 03:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVVD-0000F5-NH; Thu, 14 Nov 2024 03:46:59 -0500
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVVC-000753-7v; Thu, 14 Nov 2024 03:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azusGiZwG6Bo/Ih6RzZUdCuOKHuL9q/qs7lINrduv1jM+oa7+l94YpMjIZe3uoi7Z52Rb2GzOXe1BABqfd3wGV9hiPi9L3cO+LgFOa9gv0xtZGZpqOqq7swpaZrGBz+EBFRO3KB3HuwNBcbyjEN1dZAcFR1b1rENhUzsOaXdf7jFznaciZzhUmd8NtUU/7SP0pc6m17bMpIf8dD5VyptnjgAl6m3Yo9cWdbonjhLLjP4XEl3OTaD5Wel3oU2K37Q/1k7Ss8mcgLXcxYo357S7WxZIDtVjXGQaSnAEkzmuwZoKSZdx0mCmJW2VuoltlIP78h1SoYsugVn1uotiUPxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNogND9RLV+S4CI3D4QBhQedmb7xPG0n7y+qbrMGQcs=;
 b=JCxFyFAAGfflZuLDMbcyqtiXCpmmbP3mgref9RnDUghqEW2AbTl+kJGU5qZ8aeXu43qf0ARGzXSSxoE6QetTuNZo+FtLpkB6zhoCFBsF1BSQCIKakpzVg6YMI2vjROkXgsowkDMqFgNpxsWoNDvT3xrtSVREYzxFuMPxbhpqCQdS/RmYEIOZVQ5X+pL3nzuFmKlHD7e1foDy7AFrVt3rDQ7rzbzHyuWTi97UcpaLZtrwfrlSV/5XaMqhx6oxZ3WF05T3+/xwrsKVU18XXq49SW44w/Bx5+T0WNOpDiiB16LqZz5cw4V9w8GLMSZ3b/BAw1zhiaIq5Sq3J9diOFhuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNogND9RLV+S4CI3D4QBhQedmb7xPG0n7y+qbrMGQcs=;
 b=OzOOoPfglxy/h69hGNFeEwDKG8/odg9MpranlSXbCpWbBs5f96eR8Ttq5DcnVI2MUHmkIvw8FWgf/fNbpAG4jJUJJL6TjPv8yaeNHJ0BJDg6uHeWfl5W28Qieaa6fabhR7/bMdSW+v3lKY9zKWhbOFX+m70xVy1tCo2TX4vNbsuOT03Gt3MAMO8rbQfmJLD2oxF6hOuKG6oZhq2ghgKpaOdBXjL7gZRvjS/a2PghR53l+1nD/bHeM6/kb1Jf+8J6yUP4ojG+JLjoHlKOamiY05Eku8EpofHv2DegCURom5nNwxHuLfWsexKsDStyjMvYq50XwAjzv86koOAFZrJMqA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5362.apcprd06.prod.outlook.com (2603:1096:4:1ea::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.15; Thu, 14 Nov 2024 08:46:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 08:46:46 +0000
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
Subject: RE: [PATCH v2 2/3] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Topic: [PATCH v2 2/3] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Index: AQHbLmibceduxWhEc0uXOmgk4ueSQbK2cvSAgAATjVA=
Date: Thu, 14 Nov 2024 08:46:45 +0000
Message-ID: <SI2PR06MB50414B2667DFEA996DCA12E4FC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241104032104.2784183-1-jamin_lin@aspeedtech.com>
 <20241104032104.2784183-3-jamin_lin@aspeedtech.com>
 <01d12ff8-a570-4876-af0b-add3bccd12ae@kaod.org>
In-Reply-To: <01d12ff8-a570-4876-af0b-add3bccd12ae@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5362:EE_
x-ms-office365-filtering-correlation-id: 50673c37-d40f-4145-9b40-08dd0488df02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?b2VYcDNNd0d4SzBvUmlKKzIzYTcxbmxQMFdSMTZHNXRrNkEybHdWY3BYZzht?=
 =?utf-8?B?SlY4UThUT1VJS2M1RWtyUVpabFVtYlJTZUh1UUdIZHJZKzluK1hjcnVLYVha?=
 =?utf-8?B?REZKTVdrM0JUZ3QrSk10Zlo2bXNSRGRhdE9kZ0FIUzRoN3NjaDRXVWJPcWVW?=
 =?utf-8?B?bjhXTkRNRjRzc05DMGp1a3ZRSFd0c3d3dlFRS0xNYm1ua21PWGF4cEttTWJy?=
 =?utf-8?B?cnF3M3NVNVBZME1NV3JxNXIvcDZtQkhyamp4aEk1TXR6QVJxdVQra1JTZ1E1?=
 =?utf-8?B?OWhZdGxXWVI4MjR5TlljR0lxTllRaTZrSXFWRUZNRmloeUtMaE5xYTJQeURq?=
 =?utf-8?B?VjMwMXFCMWxVM3hmbjhPK0lBYjVlcm9wQ1FrVG1LeXpLcS8rc2Nic05nTVYv?=
 =?utf-8?B?MFYwMU51RGJaS04yNWo2aTN5ejhsbFJEVnluUkRnWFF0K0JSajg4cldGSEoy?=
 =?utf-8?B?aWxLSGljYnlrQWRDU1RTNXNpSkNTSk1QamtlZi80bW9uMk1salVqWVBqcTA1?=
 =?utf-8?B?WU83dnlVNmNVUnNlNWVwWmJEclJpVFNUaE10OXVzcWo2dUZHRUsrNmNrNVdY?=
 =?utf-8?B?SVNDVkVwNXFMc0hNR2NqMk93WU8rMlNTdGZYTWUwL2NuZVZUNjZ6Vkpwa0tL?=
 =?utf-8?B?Zzk4MThvMDdEbVFtNjYzdXFZZ1JsVE9TR3FadkJ2M0t5eUxZdXVDbk9LNzJM?=
 =?utf-8?B?YThxWWVhTk9UNU5NYUZHYzh6V2JIaDh3eE1QdzdvaE5BZUJ6VlpicmVmSXJF?=
 =?utf-8?B?ZXNyWXN6ajhWdWt3RlNQN2Jvd1RLeUlDN2dTT1F2VGlnSkl6Z1hDaEF2bW1Y?=
 =?utf-8?B?d1dPVGdzN21OdUFFeE9oZ2g3ZEtlRVVjRlR2dk1yc2s3SDdCYlJ0SHdGek5y?=
 =?utf-8?B?OThpUmY1Qyt4NzgyNnBpV0pGT20zMm9OU1lSN0Z3VXgxWi93dVRiT2JvdEJr?=
 =?utf-8?B?a0I1cWUycXhNVmdkZmY5NFl4blZYR3g2MUJqM0JiT0RHZ0ZrWm03L0dPbWRT?=
 =?utf-8?B?dldmTnZ5bWh5UjRnb1NQU1FHTVMxeFFKdlF0cm15YW40cnZEcmtXUTdJM202?=
 =?utf-8?B?RmQzbkdHeUNvdzJ3SFJMakIyMlpOTXpleTMwTXlVbzJjY3NSakNMbU9iL0hL?=
 =?utf-8?B?YisxM1pta1RUMlVLczRBNUNybzFBNVYva25teFFlSEI2STJKQVpQQ1JXOFpv?=
 =?utf-8?B?aW9zQ3A1YjhaN1piNmRWV1FGeFBzbUV0RUp2WUZ1SGtlNEZxSEhHLzB1TVVH?=
 =?utf-8?B?bVdadjBtSlVSK01FMGN4cWl4ME1hT0tFWDQ5MlE4R0RONXlxdTNvaGRsTjNv?=
 =?utf-8?B?U0hWZmJUVEVTVUJDUmxPNjhpNTFFMnhnbWN1cGR6MTcwcUtVaC9oZDdycUR5?=
 =?utf-8?B?bUFLd1JJMVhQNnJ4TWZSMFVEMks1VE93S0VUNE14TEcyL3RESkt1RlVlLysx?=
 =?utf-8?B?OE8wcHhNQi82MjF0T2gybGJsRUhDcVkvZ2VJOGxhTmRjMVVCSTRQMDNvWkJ5?=
 =?utf-8?B?VjdXc3d1bGRqMThxTHJ6MjZYdS84YTB4R0Z4MEw0SFdjejRXRTJPekMrbnl3?=
 =?utf-8?B?MkdEYS8yTjdTQ1lGY1FXakw4SCtPUFlwZE1SeVU4MXlHQ1JHMFEvV3F4cTBn?=
 =?utf-8?B?UW0yK0tsNDVqNVRSYmd2Ni9BOVNaTHUyTExidnZrTCtQc20xeEdxUnFVY1Zi?=
 =?utf-8?B?RWtFZ2lGZVZMUnFFWHpWYzRONDRrVEpaV1ByQTcySjBkMFZ4U1MyZWZXNHpS?=
 =?utf-8?B?am94dUdCajhZUy85L1NlSjNmcFVENWVtb1BBREtUYmZQRmRkcHdaUVQ0YXNB?=
 =?utf-8?B?MHpQMWdXKy8wRktLVnZOakZTaldYV2xOQWFmMElIdEdleHVNZVVINWs1ODBl?=
 =?utf-8?Q?2yUSUeaeruXTn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhDTHFkbXZjd3hrZndidTRvYlVDdlpnVCtLOXRGRVYxNmNNWjBUaXdJdjgz?=
 =?utf-8?B?dllDSmk4bHozK05MbWJ4OFZFTUV3WWNjU3Z2a3ZGZjZwVHhZamtqOHRHK0lG?=
 =?utf-8?B?K09jckcyYksvcUtwaHBVejVjWHFMY0x1dHh5K2NxUHE2NzZUNDd0OXF0ZjJt?=
 =?utf-8?B?U0hVNSsvY2sraThmSUZrcGgvcTdXeUNER3VIc24rOVdZeGtzM3MzSXU1TUZV?=
 =?utf-8?B?NjU2V0ZER01kam04QkZkUjVHZkdLSUMvM0ZkS282QXJnTk1HdFplbFJ1VDJx?=
 =?utf-8?B?OHFxNExkWUQrOFdNR1Z1U0tWcTFyeC9DajlFTTh2QTIwUkZCMk9FbTVnN0Q0?=
 =?utf-8?B?UUlmdzZrOEpONWZCbVNlMDVOb1ZUYk5wYkNPR1d0SDNHZXh3Q3ZQY3VHR1hk?=
 =?utf-8?B?RXUrQ1MzVzdDakQ5RHFSTVY1RGNiVElqWEtOcjJTSzFzcElxdU54UDYzc2VV?=
 =?utf-8?B?MzF0all6VjJQRUtLT00xZ0FUWWg0dWJlUERma3BvMFdKQzU2KzNDUHhteTVv?=
 =?utf-8?B?K1VORm90bVMrVW94SUpNcjhLaUJvZ1RvcE5vMWZ4K3Z3eEJLd0ZXQVdhOE5a?=
 =?utf-8?B?emRwMExCbE1iT1VRL1FtQlc3Uk5jMWUzMWVib09DTUFOR0pETmNOSUZxL002?=
 =?utf-8?B?em5XbW1vSFBQcUF0SlgwTmdZUE5McThweXJHSW5rUFdVakt6dU42SGVEcW9K?=
 =?utf-8?B?SFdicFJwL3pwZEpYclNrRTQrRkdyYUx4YUwvYTc3WHAwUWNIeTRIZGtXb1J4?=
 =?utf-8?B?dEdoMVVaN2l1UnY4WWlDZUN5Ri9nWnZNR0k0VWM3WDJNK0FEVjdtRzNwOUls?=
 =?utf-8?B?bmZCZXBQU0ptc1dtLzZVVjd0UjJwMWFsYUZuSXh3R3N3OUIrVzFZWm92d2g0?=
 =?utf-8?B?dXhVdVlRVTM0T0JXR2JNL0Y0bFZYc3NSTXlZNE9xRmZhcTN4MkRScVQ5N2NO?=
 =?utf-8?B?dGsraElISDZvTDEzRjdzK05EdG1BTVRjS0JrYXQvdXllNnJRdHJVd29XRmV2?=
 =?utf-8?B?ZUl0TVdyV2xUbGdEbVFnQmRteUg1YmJ5N2ZZdTFaM1FzWExkREFUaVpmUFpi?=
 =?utf-8?B?YXBFQXF0T21tTUJwYWVnVHBNeXdVTUcrWk4zVGgwWGZkbmNaTnZSMnAvbHlT?=
 =?utf-8?B?VEZWOWpTNWZ0N1NsMEEzVUhNVlQ1cms1T0wvUGpaODZQeWQ2dEE0NFgrNjZS?=
 =?utf-8?B?aFpMQU53akdQMWxDNGNBRGlKZGtlbzV4QWZYQVhRbGZIcTltUHA5RHhrYi9I?=
 =?utf-8?B?a210S0RZVzVubXd6Uk52R2JkdkJIT1NvMWRkL291RVBLWFFVRXEwa25GT2RM?=
 =?utf-8?B?YnRaR3Y1ajQwbGhCTG9hL2lGZmo4aXk4YnNXK1l0cEN0bFpoZTJUV1BGcldn?=
 =?utf-8?B?WTAxL1IvUVo3d05vSVd2cHljcmVUUVhITU5EUll3QkQwajZNbXpZZTIwY2JB?=
 =?utf-8?B?SmFtYWNHb3U4Wk9qTVA1WmlDRVJnbit0a3JWR0x4b3VmL0l5YW01eERUZzVI?=
 =?utf-8?B?Vnl2NnZ1L0F5U1ZiTlFjTmQ2WDgyR0VQRTEwOHUwRlREQlNYWmhaWWpnUjhC?=
 =?utf-8?B?c1ZvOTlxUnFNTGFwdFFIMTNUTWxIQ05hQjNxcFg0VlVUYy9CME9ac1ZEVENW?=
 =?utf-8?B?aDg0ZDF5aUJvSkhKOW05cjZ5V0NPeUhxdTFUM0F0cFJIWVg1UXJtNTUxUGY0?=
 =?utf-8?B?R3JheXBWZlU3aVJpNitvU2RGbEdUcWhuQm9tSVh6SDhJcHFjS2tvMnhpNS9U?=
 =?utf-8?B?eEFSMlVGT0tiVUZEVlB4MXRSeHJvRUFseURMZlpGdTZlQ0xxSFdrUVVKOHk5?=
 =?utf-8?B?NEVpemgyQmxCdktxRTlmclkvQ01hWTJ3MTZrTHkvUFdoQzRSZVM2RU5qZlla?=
 =?utf-8?B?TUtpbDA2UHFuT2NpRk9YWllJMy9NRW5ieXRGZ3dRTlhHQWVoeWM0WnJlTzRW?=
 =?utf-8?B?RVhNTFg4YWNhQmVvWTVQLzJpYnVHTXE3VHNacjVpV2UxaXhoMjVleUR6VW4v?=
 =?utf-8?B?VG9EdldXeTY4cDFkdklXMTUzL1ZwS0I0TXNIYWFZQmlmSjNDZndKTWJnR2px?=
 =?utf-8?B?anF5VFpWeVZvZWxhdUpjYzZ2blEzQ0M4OW5CZVZiK1VaNFBvTHErN3VzakEv?=
 =?utf-8?Q?NgF7hYtWzpxmJYYPtqnE1Trm4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50673c37-d40f-4145-9b40-08dd0488df02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 08:46:45.9828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MLCvYWUKO2fMdC3lx0Rj33Qt5sXmTa/4BLG99HeJssT1VbfeaoiEtmgM+DlBwAitFFADMso61+Zn2Fkc8nkxmnKI3GXOwNM1rbLlozzmJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5362
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IA0KPiBPbiAxMS80LzI0IDA0OjIxLCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gVGhlIFdyaXRlIFByb3RlY3QgcGluIG9mIFNESENJIG1vZGVsIGlzIGRlZmF1bHQgYWN0aXZl
IGxvdyB0byBtYXRjaA0KPiA+IHRoZSBTREhDSSBzcGVjLiBTbywgd3JpdGUgZW5hYmxlIHRoZSBi
aXQgMTkgc2hvdWxkIGJlIDEgYW5kIHdyaXRlDQo+ID4gcHJvdGVjdGVkIHRoZSBiaXQgMTkgc2hv
dWxkIGJlIDAgYXQgdGhlIFByZXNlbnQgU3RhdGUgUmVnaXN0ZXIgKDB4MjQpLg0KPiA+IEhvd2V2
ZXIsIHNvbWUgYm9hcmRzIGFyZSBkZXNpZ24gV3JpdGUgUHJvdGVjdGVkIHBpbiBhY3RpdmUgaGln
aC4gSW4NCj4gPiBvdGhlciB3b3Jkcywgd3JpdGUgZW5hYmxlIHRoZSBiaXQgMTkgc2hvdWxkIGJl
IDAgYW5kIHdyaXRlIHByb3RlY3RlZA0KPiA+IHRoZSBiaXQgMTkgc2hvdWxkIGJlIDEgYXQgdGhl
IFByZXNlbnQgU3RhdGUgUmVnaXN0ZXIgKDB4MjQpLiBUbyBzdXBwb3J0IGl0LA0KPiBpbnRyb2R1
Y2VzIGEgbmV3ICJ3cC1pbnZlcnRlZCINCj4gPiBwcm9wZXJ0eSBhbmQgc2V0IGl0IGZhbHNlIGJ5
IGRlZmF1bHQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBh
c3BlZWR0ZWNoLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICAgaHcvc2Qvc2RoY2kuYyAgICAgICAgIHwgNiAr
KysrKysNCj4gPiAgIGluY2x1ZGUvaHcvc2Qvc2RoY2kuaCB8IDUgKysrKysNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3Nk
L3NkaGNpLmMgYi9ody9zZC9zZGhjaS5jIGluZGV4DQo+ID4gZGI3ZDU0NzE1Ni4uYzY3NTU0Mzg3
MyAxMDA2NDQNCj4gPiAtLS0gYS9ody9zZC9zZGhjaS5jDQo+ID4gKysrIGIvaHcvc2Qvc2RoY2ku
Yw0KPiA+IEBAIC0yNzUsNiArMjc1LDEwIEBAIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9yZWFkb25s
eShEZXZpY2VTdGF0ZSAqZGV2LA0KPiBib29sIGxldmVsKQ0KPiA+ICAgew0KPiA+ICAgICAgIFNE
SENJU3RhdGUgKnMgPSAoU0RIQ0lTdGF0ZSAqKWRldjsNCj4gPg0KPiA+ICsgICAgaWYgKHMtPndw
X2ludmVydGVkKSB7DQo+ID4gKyAgICAgICAgbGV2ZWwgPSAhbGV2ZWw7DQo+ID4gKyAgICB9DQo+
ID4gKw0KPiA+ICAgICAgIGlmIChsZXZlbCkgew0KPiA+ICAgICAgICAgICBzLT5wcm5zdHMgJj0g
flNESENfV1JJVEVfUFJPVEVDVDsNCj4gPiAgICAgICB9IGVsc2Ugew0KPiA+IEBAIC0xNTUxLDYg
KzE1NTUsOCBAQCBzdGF0aWMgUHJvcGVydHkgc2RoY2lfc3lzYnVzX3Byb3BlcnRpZXNbXSA9IHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKSwNCj4gPiAgICAgICBERUZJTkVfUFJP
UF9MSU5LKCJkbWEiLCBTREhDSVN0YXRlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgZG1h
X21yLCBUWVBFX01FTU9SWV9SRUdJT04sDQo+IE1lbW9yeVJlZ2lvbiAqKSwNCj4gPiArICAgIERF
RklORV9QUk9QX0JPT0woIndwLWludmVydGVkIiwgU0RIQ0lTdGF0ZSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgd3BfaW52ZXJ0ZWQsIGZhbHNlKSwNCj4gPiAgICAgICBERUZJTkVfUFJPUF9F
TkRfT0ZfTElTVCgpLA0KPiA+ICAgfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L3NkL3NkaGNpLmggYi9pbmNsdWRlL2h3L3NkL3NkaGNpLmggaW5kZXgNCj4gPiA2Y2QyODIyZjFk
Li4yNWFkOWVkNzc4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvc2Qvc2RoY2kuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvaHcvc2Qvc2RoY2kuaA0KPiA+IEBAIC0xMDAsNiArMTAwLDExIEBAIHN0
cnVjdCBTREhDSVN0YXRlIHsNCj4gPiAgICAgICB1aW50OF90IHNkX3NwZWNfdmVyc2lvbjsNCj4g
PiAgICAgICB1aW50OF90IHVoc19tb2RlOw0KPiA+ICAgICAgIHVpbnQ4X3QgdmVuZG9yOyAgICAg
ICAgLyogRm9yIHZlbmRvciBzcGVjaWZpYyBmdW5jdGlvbmFsaXR5ICovDQo+ID4gKyAgICAvKg0K
PiA+ICsgICAgICogV3JpdGUgUHJvdGVjdCBwaW4gZGVmYXVsdCBhY3RpdmUgbG93IGZvciBkZXRl
Y3RpbmcgU0QgY2FyZA0KPiA+ICsgICAgICogdG8gYmUgcHJvdGVjdGVkLiBTZXQgd3BfaW52ZXJ0
ZWQgdG8gdHJ1ZSBpbnZlcnRlZCB0aGUgc2lnbmFsLg0KPiANCj4gSW4gY2FzZSB5b3UgcmVzcGlu
LCBtYXkgYmUgeW91IGNvdWxkIGNoYW5nZSB0aGUgbGFzdCBzZW50ZW5jZSB0byA6DQo+ICJTZXQg
d3BfaW52ZXJ0ZWQgdG8gaW52ZXJ0IHRoZSBzaWduYWwuIg0KPiANCj4gDQpUaGFua3MgZm9yIHlv
dXIgcmV2aWV3Lg0KV2lsbCB1cGRhdGUgaXQuDQpKYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
PiANCj4gDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGJvb2wgd3BfaW52ZXJ0ZWQ7DQo+ID4gICB9
Ow0KPiA+ICAgdHlwZWRlZiBzdHJ1Y3QgU0RIQ0lTdGF0ZSBTREhDSVN0YXRlOw0KPiA+DQoNCg==

