Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92CEC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLe4-0005N7-Ay; Mon, 04 Mar 2024 22:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLe1-0005Mo-SW; Mon, 04 Mar 2024 22:39:09 -0500
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLdy-0007wo-M8; Mon, 04 Mar 2024 22:39:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSidCqYoPJw7eBq4VaU7Gcvcmb4WFuvajhWpC40hsDpgOhp9/ID8Z5o/YtbRZ6u9xQeqUoaLBgh2FhWNUDhbSaHWvEA98et9VvXLS4DyuA8LZ64NA3cqE3jbgC1Yx5XtFGvccHKy0xDpglyk129rukrU11QJD414TMFv8Gu4n+aeTkZOhtCHNv2bgg1U2VM8U+/gyF0XnoKqtwemMVCq0i4J/I1Om/Wi4mnAxxM2K5O8D5lfBD9zVUZT+TjkFmHZArZzs9Cg4JKblTPCMRb4pAWQcbI0WA4tFfLjKNiPIpblTNd/vuAx9FNYcz1YbY5SkgO66fEtOT/JkYe65JPAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsLOh19R38YN/lfP/uQXXEcktyug2Gc5ZbgeuJoDHAA=;
 b=QOSp+MfEHbRYfybnN9M5vG1uZAgQqa4ppfoJ9AZPTwju1FpsJtOYcXgm3/QMmHz9/ZRAvZ6wTjqPFCNn/12j7SNaUDc0V+H7WfRFv60ZCKhEXgYsnvWjvZLfWb5EYYHybsKrEs10gaUyGLE86HyffoerV655OX1bL5hKkImMGJQv3nuGQn7EUMPjl6R5f7uJtH9Y1CWks0Bj7milNbezq/QlyoeZ+yoet8dca1ASdRqBbMAw6Il6unJQJUw/qVlQQEKGRvEaDE21dITngA3MpKTTw0ZlqDl+oqUFGyM+z6uE9DghCM0p8CljigTPxarhaPiQ9MCQTn0Rj4yTfkFucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsLOh19R38YN/lfP/uQXXEcktyug2Gc5ZbgeuJoDHAA=;
 b=RBiS6jJCdcbzEfPNU5jQHn3z3wZ5Ejd5qhTN/v9ThQykphxQDkd2ZHNFHdmTD4j7dm3NAF3xoyU0KVgAr9hCof25K2zsRFRnmzpN/Cp62rTL36ZYvSZP1Xe7KpXt+uLv7ikIWUQemBk3nXXHvja671fLMz79hrLrWxTHfOeWn9wFhCBmfvIiy2dIrJ1YJ8O4ETkq/CqjleTYYmHCBKHuGTU9QBESYtAPzK+inOHLIL6QNe471aIGQg6tcFGBNh3XX45m8qRcyGlANuCyBcxZF0QcPaf3ll70CrdlL60bg1nznmqzPJyieN/O4+q7hfzoFK999aCoKI6LkWsSwCt/TQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 03:38:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:38:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/9] Add AST2700 support
Thread-Topic: [PATCH v2 0/9] Add AST2700 support
Thread-Index: AQHabhZ80NsZdPcCS06nm6q7xNA2S7EnvEKAgADDk8A=
Date: Tue, 5 Mar 2024 03:38:59 +0000
Message-ID: <SI2PR06MB5041140DFC668A43DBAB81E3FC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <5e09c627-01aa-46cd-b367-b537f5b61e03@kaod.org>
In-Reply-To: <5e09c627-01aa-46cd-b367-b537f5b61e03@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6219:EE_
x-ms-office365-filtering-correlation-id: 0f3aa79c-176b-40f9-6810-08dc3cc5cb47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xp7UJiIFSXHOE50yAK7ycSq1c16BCE464PVYOB+upwuiqo1C4yl2OXDJgbsvHK71mr7pdyGjRc2ZD/+8afoOtzdicc/mU1EhZNeVhktp3pR9t8fGzw3IjSc0pv3ch3vd3CXIuHpUunzbNriX+zh6hqL43UylxtZl43QefgFjnLtWWSC6oOzdaMu/FWngqhkew0IPwbHXuyipLRO40AVpQE3SkYauzijmG65vcZINQQXIrrbJ9ZGL1F+FIHqLWe3xLqUeYY7Onj+9pjt1FyElF0JcO7e6YjNtvbLUU/dvs6TypTszyTU/cN8lsRtT257+6szzLTA0RZH8y1Djnm8NZESPUogWjNeYl3M6Dr84bndrvQihgoOgZT7CARfJHOtVxtspXB95ozeeuw0i4JaDS6/51u5U8PvBd1Mu/2E7vM26eLW57W32w/c36faeJ76q5IfZL4OZeRFEP+GgSJhbX95MggLpuDT3108poTOFIzUDam2Wd1OMajQnJmDxoe2xpj/7qfPzCU1dXa/L7hMdWpLPJHbpNSiE/wSiYXgIe1Yb03nrzPy1z5RwiszOrpso+O7kidznspiQAKNPZVRyR0sTB1j2eEklO0XcNn3spB0cdMBMbLsoJ8kqCOl52VgNljmbEPFvWt1NRr9n5cU302UFlKf4XpCyrrKIVD/aao0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxWUjZSb0lFNnFkdTk0NzFVOElkWDA1RVB2T2Jhc0p1MmlkWmJMRXhBT2Ry?=
 =?utf-8?B?eE15bmlKNzZGS3E5NGROMkRiSGh2d0I3dmx1OVhQamtSajhkeStnRjZqK2VJ?=
 =?utf-8?B?bmFXNnRrdUVvaXBVZEl6cFdHT1d0UXlJcytaVkJuZ1JlZEtDeXVCZm42YnF1?=
 =?utf-8?B?YXNGUldRUi9kcWNOb3JQRVc5OVQ3ZUFKeEpSY2R2ZWxUblJFM1hJWjRxWDZH?=
 =?utf-8?B?THVCOXdpVFJtWXJCNFZPcG5CMDllTmtqcXlrK0hFR2JVckNwaHJpNktkallr?=
 =?utf-8?B?R2QzWFZHMk1LUjN3aEZXdC9OWVpnOWNZY3VTUitmWmJqTlA4WEIyOWlKQUZ2?=
 =?utf-8?B?QTloeXY1U0s2WW9KUHRNV0kwaXBmR2pleTBNWlkvajVnb21rcUJKV1N3eVZL?=
 =?utf-8?B?TnBLazV2N1QvWWYyWkxDd25jMHhjQVB0Y3hPRU9zV3FjUXpiYS9wbWRXL09w?=
 =?utf-8?B?dGE5Tk9kNnpNS0tDM2owOHllMVNSQy9uUFhPV1pQREEvL0MvVXlyQjVveWZ3?=
 =?utf-8?B?bkFLRGVkdUlXRnNmMEZjakRQYjV1UlVTS0t6ZVNWUHpJNURtSnY5RTh5VnBl?=
 =?utf-8?B?MEJiS2JvWHhzYm93b01zWHdQaXFHaXlBL0xpSVlZWTI1ckZQWVY0aE1RUVR4?=
 =?utf-8?B?Y2JSOWtZWlowQXdVU0hHTUJhbnFzUit3WGQ1Q0pYRTBhdVVpeHV6MjRQYjZh?=
 =?utf-8?B?Nzd6SnNxTFlxUDNrandhYjk5eEE3MFNLMlpZM0dSTDFGR2JWWnJZVUwrQlhB?=
 =?utf-8?B?MndOanUrd3Q0TFh0TzBMb3ZwbnhrVkNtLzdPUzRuMnlZdU9zWDd4QjdvYVI2?=
 =?utf-8?B?SEhYQVVQb2FrSllFNTEyQjRSZDRjRkJxZjRsUXpHN0V0RThYVzlDcGZ4UkVp?=
 =?utf-8?B?THZqbUcvQzFud0NLVklLa1JHNkdGWDRRQmt5S0NsSkt3SGlrQkgyRkJGTmQw?=
 =?utf-8?B?Um0yYmtRQ3EwRlIrZDJCRmV5NVpxUmNwZmczM0xGS2xPelpDWEFVajNQUVVY?=
 =?utf-8?B?cmdjMnExOTlsKzBCZ1BPRXBMdGxvWm95S29HdzRwT0hpSVJremd3S3FZc0Qx?=
 =?utf-8?B?NmZEbG5aY0hDUXRHcXNHMUZGQXZKZEtoWkIvc0RqaUhaVndZOElzYi9oRzJz?=
 =?utf-8?B?REFjSDJORnZLUkhkVGNjR2MvU242dFlxekxoQlN6SmNrZUdmRW96QnQxMFh3?=
 =?utf-8?B?ZW1RK2ZFMjZlRWFPcW9pNWh6dWNWZTh6N05zRExjNk4rSFVRNVRBbHA2WDly?=
 =?utf-8?B?eVZZd0JGME1iczUyTXNtaE5xYnhvWHRyWUlrTTJqWURBYTFuSUV1R0tJOGhF?=
 =?utf-8?B?aTZoMnN2ZEJoZVhZL20wOW5YYk9SbUhOMEdHejhyQ3g1NzFIOThOR20weDds?=
 =?utf-8?B?V1dtU1h0WG43ZTZKclZBaU1wTzkyYjYrV0FoRUgwMjZHYzhIcVV3Y0pRcDg1?=
 =?utf-8?B?N3ZFbTZlK3QzMUlabUJSbnpqRFJuWjZTdnRtTWpKUndtdG5CYUZxcVF6THhy?=
 =?utf-8?B?Z09TbXkzdnBBbTFZSGx5UnppbzhKSFNpOEYzTEhVaTVzUjZiMFgxa2V5T3ZX?=
 =?utf-8?B?UFVlSUx0QmFnc2hLZ2lEWi94OXdtQzJNa3k2dlNkclJGenVoK2pLKzk4T0M3?=
 =?utf-8?B?ejErRzFaNGdyallRajRQNUhtck1aZ1FxWHhybG5SV3p0N2crNlFQc2pOblhG?=
 =?utf-8?B?MThEUGg0U245bGFYZ3cyVGdaTDBlYVhCVkluVjhwb014SWhseWhGU0lJd01H?=
 =?utf-8?B?Vk16RXhmZ2pMZ0IrZkxGUWhMOHp4bVAydTZ6MGtMUjNrMFNWQ21oT2lkQWhn?=
 =?utf-8?B?bEt4d2JPQ1U2b1ZYUUVlaDArZzVqb2ZpSjlLUXZrWkl0eStxcjFUbk9iR241?=
 =?utf-8?B?aWVpZDlOakY5cUV4R3hLalo3QXJqUmJtTTFDc0ZBcllYK3dHdDY0YzNMdDdU?=
 =?utf-8?B?ck9qcm8xd3Q1Zlh5bDdUL2svOUtoUUk0NzFQdGJOenNxblhtOHdKWUxzTzI3?=
 =?utf-8?B?YnJjT0NvWEFrUitDbjRZeVJGZzQwQVdpbEdnMzUzY0hHNk9OaExlRWFMRzE5?=
 =?utf-8?B?Y2N4MlY1S28wK2cwWTB4bUFnN2toYy9lN2h2cFZVUnZBVnR1LzBTR3M2M3BV?=
 =?utf-8?Q?H4C0/AGjEjjDqixayi+yzSrm+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3aa79c-176b-40f9-6810-08dc3cc5cb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:38:59.5989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ki1FedkBHOcFZUSHMENLCcXmlo51br8gkuUlBvqDXY63jTYkFnmEPXIOL6c1R/AUs2Nz/OX3jcf4mTydRitdL7dMkgvN8V6KshdTh7+O+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMjQgMTE6NTQgUE0NCj4g
VG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0K
PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2Rl
Y29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgb3Blbg0KPiBsaXN0OkFTUEVF
RCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhl
cmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzldIEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4g
DQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gMy80LzI0IDEwOjI5LCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gQ2hhbmdlcyBmcm9tIHYxOg0KPiA+IFRoZSBwYXRjaCBzZXJpZXMgc3VwcG9ydHMgV0RU
LCBTRE1DLCBTTUMsIFNDVSwgU0xJIGFuZCBJTlRDIGZvciBBU1QyNzAwDQo+IFNvQy4NCj4gPg0K
PiA+IENoYW5nZXMgZnJvbSB2MjoNCj4gPiAtIHJlcGxhY2UgaXNfYWFyY2g2NCB3aXRoIGlzX2J1
czY0Yml0IGZvciBzZG1jIHBhdGNoIHJldmlldy4NCj4gPiAtIGZpeCBpbmNvcnJlY3QgZHJhbSBz
aXplIGZvciBBU1QyNzAwDQo+ID4NCj4gPiBUZXN0IHN0ZXBzOg0KPiA+IDEuIERvd25sb2FkIG9w
ZW5ibWMgaW1hZ2UgZm9yIEFTVDI3MDAgZnJvbQ0KPiA+ICAgICBodHRwczovL2dpdGh1Yi5jb20v
QXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcvdjA5LjAwDQo+ID4NCj4gaHR0cHM6
Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5
LjAwLw0KPiA+ICAgICBhc3QyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPiAyLiB1bnRhciBh
c3QyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPiAgICAgYGBgDQo+ID4gICAgIHRhciAteGYg
YXN0MjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+ID4gICAgIGBgYA0KPiA+IDMuIFJ1biBhbmQg
dGhlIGNvbnRlbnRzIG9mIHNjcmlwdHMgYXMgZm9sbG93aW5nIElNR0RJUj1hc3QyNzAwLWRlZmF1
bHQNCj4gPiBVQk9PVF9TSVpFPSQoc3RhdCAtLWZvcm1hdD0lcyAtTCAke0lNR0RJUn0vdS1ib290
LW5vZHRiLmJpbikNCj4gPiBVQk9PVF9EVEJfQUREUj0kKCgweDQwMDAwMDAwMCArICR7VUJPT1Rf
U0laRX0pKQ0KPiA+DQo+ID4gcWVtdS1zeXN0ZW0tYWFyY2g2NCAtTSBhc3QyNzAwLWV2YiAtbm9n
cmFwaGljXA0KPiA+ICAgLWRldmljZQ0KPiBsb2FkZXIsYWRkcj0weDQwMDAwMDAwMCxmaWxlPSR7
SU1HRElSfS91LWJvb3Qtbm9kdGIuYmluLGZvcmNlLXJhdz1vblwNCj4gPiAgIC1kZXZpY2UNCj4g
bG9hZGVyLGFkZHI9JHtVQk9PVF9EVEJfQUREUn0sZmlsZT0ke0lNR0RJUn0vdS1ib290LmR0Yixm
b3JjZS1yYXc9b25cDQo+ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAwMDAwLGZpbGU9
JHtJTUdESVJ9L2JsMzEuYmluLGZvcmNlLXJhdz1vblwNCj4gPiAgIC1kZXZpY2UNCj4gbG9hZGVy
LGFkZHI9MHg0MzAwODAwMDAsZmlsZT0ke0lNR0RJUn0vb3B0ZWUvdGVlLXJhdy5iaW4sZm9yY2Ut
cmF3PW9uXA0KPiA+ICAgLWRldmljZSBsb2FkZXIsYWRkcj0weDQzMDAwMDAwMCxjcHUtbnVtPTBc
DQo+ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAwMDAwLGNwdS1udW09MVwNCj4gPiAg
IC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0MzAwMDAwMDAsY3B1LW51bT0yXA0KPiA+ICAgLWRldmlj
ZSBsb2FkZXIsYWRkcj0weDQzMDAwMDAwMCxjcHUtbnVtPTNcDQo+ID4gICAtc21wIDRcDQo+ID4g
ICAtZHJpdmUgZmlsZT0ke0lNR0RJUn0vaW1hZ2UtYm1jLGZvcm1hdD1yYXcsaWY9bXRkXA0KPiA+
ICAgLXNlcmlhbCBtb246c3RkaW9cDQo+ID4gICAtc25hcHNob3QNCj4gPg0KPiA+IEtub3duIElz
c3VlOg0KPiA+IDEuIFFFTVUgc3VwcG9ydHMgQVJNIEdlbmVyaWMgSW50ZXJydXB0IENvbnRyb2xs
ZXIsIHZlcnNpb24gMyhHSUN2MykNCj4gPiBidXQgbm90IHN1cHBvcnQgU2hhcmVkIFBlcmlwaGVy
YWwgSW50ZXJydXB0IChTUEkpLCB5ZXQuDQo+ID4gQWRkZWQgd29yayBhcm91bmQgaW4gSU5UQyBw
YXRjaCB0byBzZXQgR0lDSU5UMTMyWzE4XSB3aGljaCB3YXMgQk1DDQo+ID4gVUFSVCBpbnRlcnJ1
cHQgaWYgaXQgcmVjZWl2ZWQgR0lDSU5UMTMyLCBzbyB1c2VycyBhcmUgYWJsZSB0byB0eXBlIGFu
eQ0KPiA+IGtleSBmcm9tIGtleWJvYXJkIHRvIHRyaWdnZXIgR0lDSU5UMTMyIGludGVycnVwdCB1
bnRpbCBBU1QyNzAwIGJvb3QNCj4gPiBpbnRvIGxvZ2luIHByb21wdC4gSXQgaXMgYSB0ZW1wb3Jh
cnkgc29sdXRpb24uDQo+ID4gSWYgdXNlcnMgZW5jb3VudGVyIGJvb3Qgc3RjayBhbmQgbm8gYm9v
dGluZyBsb2csIHBsZWFzZSB0eXBlIGFueSBrZXkNCj4gPiBmcm9tIGtleWJvYXJkLg0KPiANCj4g
SSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgR0lDIGlzc3VlIGJ1dCBJIHN0YXJ0ZWQgcmV2aWV3aW5n
IHdoYXQgSSByZWNlaXZlZC4NCj4gDQo+IFRoZSBtYWlsZXIgaXNzdWUgbmVlZHMgdG8gYmUgZml4
ZWQgYmVmb3JlIHdlIGNvbnNpZGVyIHRoaXMgcGF0Y2hlcyBmb3IgbWVyZ2UuDQo+IE1heSBiZSB1
c2UgYW4gZXh0ZXJuYWwgZW1haWwgd2hpbGUga2VlcGluZyB0aGUgc2FtZQ0KPiBGcm9tOiBhbmQg
U2lnbmVkLW9mZi1ieSBhZGRyZXNzLg0KPg0KVW5kZXJzdGFuZC4NClRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uLiBJIGFtIGFza2luZyBvdXIgSVQgaGVscCB0byBmaXggb3VyIHNtdHAgc2VydmVy
IGlzc3VlLg0KVGhleSBhcmUgZml4aW5nIGl0LiBJIHdpbGwgdXNlIG15IGV4dGVybmFsIGFjY291
bnQgdG8gc2VuZCBWMyBwYXRjaCBzZXJpZXMgaWYNCnRoaXMgaXNzdWVzIGRvZXMgbm90IGJlIGZp
eGVkLCB5ZXQuDQo+IFdoZW4geW91IHJlc2VuZCwgY291bGQgeW91IHBsZWFzZSBhZGQgYW4gYXZv
Y2FkbyB0ZXN0ID8NCj4gDQpTdXJlLCB3aWxsIGNyZWF0ZSBhIHBhdGNoIGZvciBhdm9jYWRvIHRl
c3QuDQpUaGFua3MNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+IEphbWluIExpbiAo
OSk6DQo+ID4gICAgYXNwZWVkL3dkdDogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiA+ICAgIGFzcGVl
ZC9zbGk6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3BlZWQvc2RtYzogQWRkIEFTVDI3
MDAgc3VwcG9ydA0KPiA+ICAgIGFzcGVlZC9zbWM6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAg
ICBhc3BlZWQvc2N1OiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4gICAgYXNwZWVkL2ludGM6IEFk
ZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3BlZWQvc29jOiBBZGQgQVNUMjcwMCBzdXBwb3J0
DQo+ID4gICAgYXNwZWVkOiBBZGQgYW4gQVNUMjcwMCBldmFsIGJvYXJkDQo+ID4gICAgYXNwZWVk
L3NvYzogZml4IGluY29ycmVjdCBkcmFtIHNpemUgZm9yIEFTVDI3MDANCj4gPg0KPiA+ICAgaHcv
YXJtL2FzcGVlZC5jICAgICAgICAgICAgICAgICAgfCAgMzIgKysNCj4gPiAgIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC5jICAgICAgICAgIHwgNTU0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsNCj4g
PiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgICAgIHwgMTM1ICsrKysrKysrDQo+ID4g
ICBody9pbnRjL21lc29uLmJ1aWxkICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBody9taXNj
L2FzcGVlZF9zY3UuYyAgICAgICAgICAgICB8IDMwNiArKysrKysrKysrKysrKysrLQ0KPiA+ICAg
aHcvbWlzYy9hc3BlZWRfc2RtYy5jICAgICAgICAgICAgfCAyMTUgKysrKysrKysrKy0tDQo+ID4g
ICBody9taXNjL2FzcGVlZF9zbGkuYyAgICAgICAgICAgICB8IDE3OSArKysrKysrKysrDQo+ID4g
ICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICB8ICAgMyArLQ0KPiA+ICAgaHcvbWlz
Yy90cmFjZS1ldmVudHMgICAgICAgICAgICAgfCAgMTEgKw0KPiA+ICAgaHcvc3NpL2FzcGVlZF9z
bWMuYyAgICAgICAgICAgICAgfCAzMjYgKysrKysrKysrKysrKysrKy0tDQo+ID4gICBody9zc2kv
dHJhY2UtZXZlbnRzICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAgaHcvd2F0Y2hkb2cvd2R0
X2FzcGVlZC5jICAgICAgICAgfCAgMjQgKysNCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9z
b2MuaCAgICAgIHwgIDI3ICstDQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX3ZpYy5oICAg
ICB8ICAyOSArKw0KPiA+ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zY3UuaCAgICAgfCAgNDcg
KystDQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NkbWMuaCAgICB8ICAgNCArLQ0KPiA+
ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zbGkuaCAgICAgfCAgMzIgKysNCj4gPiAgIGluY2x1
ZGUvaHcvc3NpL2FzcGVlZF9zbWMuaCAgICAgIHwgICAxICsNCj4gPiAgIGluY2x1ZGUvaHcvd2F0
Y2hkb2cvd2R0X2FzcGVlZC5oIHwgICAzICstDQo+ID4gICAyMCBmaWxlcyBjaGFuZ2VkLCAxODgw
IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaW50
Yy9hc3BlZWRfaW50Yy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9hc3BlZWRf
c2xpLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3Ns
aS5oDQo+ID4NCg0K

