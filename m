Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C887C54791
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 01:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjUFr-0000Q6-2c; Sun, 10 Mar 2024 21:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rjUFo-0000PC-An; Sun, 10 Mar 2024 21:15:00 -0400
Received: from mail-psaapc01on2071a.outbound.protection.outlook.com
 ([2a01:111:f400:feae::71a]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rjUFm-0004Gf-3U; Sun, 10 Mar 2024 21:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft3fKwgIs3ZB/oKeEtgW6X9LXSlvjLpG2s6gX00P3GSoMW9u3Dnh6uU5lV6e8pWeKrPZfSaVdUypaStLHIMm/FCt89BQFcK+JJTuySn1isAPcnTWeOA6gLANCO/f84iz3IPLeOX3Ac9ZtX+6D0D2TFGyRSpTs/phlLP41vDv97iq4K8zO2Bf7XpoMFKdqTHAVh4zQ5mB3mNJz/3JFF+mXUqoiLUzuV2H4GvV2DO/DNZwlyDwe1HEv2GPVjyDOwWJLJj6/Bx2POyTOX0vexOd/zKIcqhDUQrjzFes2AvccLPCzSlYfG7i1lpyU12WhhOxN8aHlaV2upTlxjvDv83xxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rObt3s7XPEb263Z7EGuHnRoLtVJEmgUv6NZX2FPWCPM=;
 b=kd1FwYYthgmNtL6eKJazgp0pJXH07WdKbEJ+z/T/rG1L1lkaMzOfsXmak1+SlIgQucBwR13OF2O/jRGj8RM/RlF5mkqj58jbPuFHu8lslasnR9fVZp79IOzC/uxZ32XmxNlgssmQGbwzwgGleHGYw73HI1PhpQEe1AgSEqbZLpNoL3pIZcuVHkwrJGQrcnKUwC5P36wjUSqr1wJAp1A5zSQHTHg9sxuIjZ3u55ri9DlAayp52MbiK3xlYwP/priHH9VpepV0FFMZvJKRVg/PvvtE9KOjgdJVRipUtS4jGOrPTiD8XKXcXiWa+xgM509jiD593sPwHC/vQw5ipewQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rObt3s7XPEb263Z7EGuHnRoLtVJEmgUv6NZX2FPWCPM=;
 b=DjWdZBmx43Ja07wxamzxypf8KdPgn2V/DJjBH8xMpTv6WffC20yYiCnMrQRPcm0gEs6Y6SaqfbimtlwzOEjZPoVt13/b3QDEx1n11F0OKYItpgs8lFNMofVpWj+fDPLkHCcfB/rsPPy+fBLbOd3G7iFu9NjWTY4X5iw7lQTkVy91Ff+g0iPaBV9+KDAZ1C6V7aSXyuFYoLhVGH6pHzrGgp2+udg+cGjXq20MYMdSiEOdDR0CgoRL793+kLUc9bps7Xemmq3aNjpqnF4GvFLAvezoTySScnuII3eWbiKSMkK5JniJHYPmEzS96A78vPDaYR0WOgw23nm95RIfgH/yXg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6099.apcprd06.prod.outlook.com (2603:1096:400:356::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 01:14:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 01:14:46 +0000
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
Thread-Index: AQHabhZ80NsZdPcCS06nm6q7xNA2S7EnvEKAgADDk8CAA5xOgIAFqp8w
Date: Mon, 11 Mar 2024 01:14:46 +0000
Message-ID: <SI2PR06MB5041F8BA7F29ADFAD2B559D9FC242@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <5e09c627-01aa-46cd-b367-b537f5b61e03@kaod.org>
 <SI2PR06MB5041140DFC668A43DBAB81E3FC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <bd9e5103-661e-46c4-801d-5afdd629d5cf@kaod.org>
In-Reply-To: <bd9e5103-661e-46c4-801d-5afdd629d5cf@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6099:EE_
x-ms-office365-filtering-correlation-id: c790ac92-f64f-44cf-8726-08dc4168a43a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JCE1idsgNzX4LAYAO9TXCbGXgvRgp9tX3rZ2tMUtLWb2EPGXC61ZOy7439odrZeCKIEkU17bf4dDmr281L0eKxWjgEn2w/y207B7NfNHnJS3LZj/ZZgB4VRLjlcyB8+AS8Oz3dCeHo6iP/RxE+U617Rqxvc39gn1PUVTAF9Z5N6Ug6v8NqKNye/dRTCjaIzRftCjjysVOwTWqv7zryVwcQKMTOttN84iKoi9j5zaM4gHXL6zabOpxpc4BBOgv5xGlYMqrhWnd1D2OzVGk8cAm64mp3BsqG8R5z5vOxkhNrGFBdO0+B/Mc2m+7NZACKKi06kkmgHHoAKDSn8HdTugzb88xHO249jZdLPRRKvdeJGzdJu72VoWYNknZAxtmPNDked3Nm9/VkErbOeB4LuNeAaF/qR21sG+pDnk/BeTnijytasTBMihEN63QwkKAnLsILORqIPZ6enS0c87XBUOmo3ueA4eop4uMqRxHt4FrbwxJVE6yDzDti1vjV/WJ/AizgO3+2943/NMfGFkt1C3HSWSAcJ6uVguPD5O37HMxOkWGVyx2BCyBDOnTxANl4V8wnwTday9PQWldtxhp0j0fEnt/m7gbjhkgZoL7cKJAgxUkLv99FFYdHJc6PuPnQ3fBpBKeExC481NiU7w9e9DFtyrWdGVvwKPdI9xL5/WTxw85hoDaEtEn64aWktU3zK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGk5WlR4UDJ5dnJDM0hIL2RHaDJLN2tyU0Z6S2JvMU5ydTBndzU3TUR2R3Jn?=
 =?utf-8?B?eG43dE9BNWdRV081SmNyNllMWVpIcVpwdDRoeFpNRGR6cFB5elVEQ1AxYjlm?=
 =?utf-8?B?YVUxQ0NVS05nMTdvR25UZzh6czhaamJVTlpHMWtwZmpRQlpZTUYvZ0lKSTZK?=
 =?utf-8?B?VEtmQitFbWZTVjA3d1AxU2U4YUdsSEVPSjJUNGVLYU5vOXI2ZnBLYUhZWGNE?=
 =?utf-8?B?c0ptRHJFOUJVcm1pQktSbTVYMkNKMmt2SnAwRGtvMGpLZi9zTCtoaUpxZzMr?=
 =?utf-8?B?eC9WY0JoVDR1WEwzdUFvb3pWQ0ZPOGNXK2NneFBBaWEybllFYm9icTEwZlNV?=
 =?utf-8?B?UmVUZ0pSand1UGVEbmtNZll0bGJ3TXM2TVIrU3JvRnRDVWJWbWNmWW1vTW1a?=
 =?utf-8?B?b0NlMXA3VG9tR21xVmRVcG4wV0JtZ3ZWdmlGZ2ZrampreC9xMnFKUHBoTGdR?=
 =?utf-8?B?SVlsSStRa3pFQXd5d3BBVi91aFJTUHNTTU9RNFdMeWlZUEI2WTVTUVczUXRu?=
 =?utf-8?B?czZQa0oxcE0wSzMvRmZQL3hNWnNVdlljTjc0bzU1cWdzSFZSbFZCNHZqWDZD?=
 =?utf-8?B?L1F1SFFlV2E3YmJtM2NPNkI2WUxhVWxWWmtzdGt3WWxTYkNOK0o2UUliWG9u?=
 =?utf-8?B?YmZPUkhDT1FBWDA2Wm41amp0bUNMUXI0b20xYmVqMThNaEZNZHFtZjlmQnor?=
 =?utf-8?B?Umx2bjl1RHJ5bGhtZVBzaW40QXVFcFA1SEw1NXVIV0E1bVlpLzNLY05rcU5C?=
 =?utf-8?B?TXlza2VVRUhLMGw2cnh1UWlYYkZvUGV1eWFVV0NTaS9TZmx5T2Y0RUJuY2xx?=
 =?utf-8?B?V1lCRUZ0Q2JiK2xHbWR5Mkc4UVVQS0MwSXlIWnEyYU5BaEVwZ0lPaEEyLzh3?=
 =?utf-8?B?dHI4bURVVnlsTEw4YmtIZEJWR1RQWFVHeUFHbGlnYWtGb2VxcXJXM0g2OE5y?=
 =?utf-8?B?TUZqbnJJTVdPY1pydEsvY293Q2RyS0xpamFQWjNsb3E2RXorR3BHUFFLVTR5?=
 =?utf-8?B?OGs1Z0QvdURLMldRcHY3c25FRjkvYmcvdDhCWU9VSTlKc1lSVkRGMTA2eis0?=
 =?utf-8?B?a292ZGE4TDBzU1dEL1lYRlF4QURPeTlSdThxQWxBTXNKZHJZck1JN2JLNzZk?=
 =?utf-8?B?a1owek1VN0pRWDdqd2NFT2xGYlJwcW9jTUJlcGlVejhsK2d2RFlVWm9VaUpB?=
 =?utf-8?B?ZXY3ZDc1NkxIeFd1WVhpYWRXdHh1NUtzK2x4WVRwRzdiekJwZ2tpS1kyd0dL?=
 =?utf-8?B?ODRpb1hNL28rM2hWWkZRWUpPd3JCMHg4R1M4TmNrUWJNMUhIU05MWDB6MWlT?=
 =?utf-8?B?d0ExZFl6SzgrSzdCNThkVWtIMUl0aUhicGkwL1EwTjNwSmtKR09pSUtZV1Nh?=
 =?utf-8?B?UHpEOEIwR1cxd2JOeE5HTlJaaGpSelQxa0UvMEt1bFR3b1YxckhEaDlVaUFy?=
 =?utf-8?B?VW9XZ3NzYVpFYzRLaXovL0VaY1hZSHZpMCsrS0FmdWdhalJlSzRTQ2VZOEpx?=
 =?utf-8?B?UCsySEtLZ3l5eWZTRWVSc05kYzUwZmREZnVrWEpnVVdFcFIvL0pnMTN1akJL?=
 =?utf-8?B?MzhsdGJzRTl6M2FSeGhhbW1Xa0t1Zkw4emtVeDhwQUJIOGpLVG5QWHhxc0tm?=
 =?utf-8?B?dGNucGU5cXNCeEI3U0dIdCtrNmNKN3V2VE1sU3ZzVmNwSDFNbVpmZkZ3bU1W?=
 =?utf-8?B?d3ArWUJoWEc5dml4bi9sMWNEV1VKN05ZSHVXWlBNaHEzalRJT1VvWGQzV0JR?=
 =?utf-8?B?UjgzT0EwQzlLUmZ4bVZnNXJKMDkwOHhBcGhKS1Vma2liUElFRlB5OTRLNU1U?=
 =?utf-8?B?Q3doT055eU9xMDNDWG9VNncxOVJKYmY2KzFVR295UjBRVGdsYnFTTkd6YTR3?=
 =?utf-8?B?Z1p3K1BKKzB5cS9rb3JYZDhZTEpIb3VnNUY2NkNlQU9oVmhWOCtZeDhnQ1Jx?=
 =?utf-8?B?eWRyZTc0eFNqV3U4YUx5NUxOQ1pzeXFmYUFCUWhGY1RLcUc0V3IybDNVTzkx?=
 =?utf-8?B?N2wvaDR6bkJXUFQ5eFNycURpUHUzWG1vWklMeHd1OGJKZUc5Ymg5aDJUSkpp?=
 =?utf-8?B?UFUvTEV0OW5qL0FZYkJ6blI1NU13eVE0NVlHOXlqSVBBeGZGVHVUbWl2TFN4?=
 =?utf-8?Q?e27UzB4vMI8Jy4YbDiqEv6hev?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c790ac92-f64f-44cf-8726-08dc4168a43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 01:14:46.7122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/nhe45tTQVVrrMegpHnAfvkaU29FnhHkByFgNSpSwZLVjBhEKuRq551XjxbTVe4NNeGheNtZ+Pp3va72R3aRuWoEVfmkETFiVzO9m5GoxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6099
Received-SPF: pass client-ip=2a01:111:f400:feae::71a;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNywgMjAyNCA2OjQzIFBNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwN
Cj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29k
ZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47IG9wZW4NCj4gbGlzdDpBU1BF
RUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBo
ZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC85XSBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+
IA0KPiBPbiAzLzUvMjQgMDQ6MzgsIEphbWluIExpbiB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9y
Zz4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCA0LCAyMDI0IDExOjU0IFBNDQo+ID4+IFRvOiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPj4g
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEFuZHJldyBKZWZmZXJ5DQo+ID4+IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4g
Pj4gQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47IG9wZW4gbGlzdDpB
U1BFRUQgQk1Dcw0KPiA+PiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0
Y2hlcyBDQyBoZXJlDQo+ID4+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA+PiA8eXVubGlu
LnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC85XSBB
ZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4+DQo+ID4+IEhlbGxvIEphbWluLA0KPiA+Pg0KPiA+PiBP
biAzLzQvMjQgMTA6MjksIEphbWluIExpbiB3cm90ZToNCj4gPj4+IENoYW5nZXMgZnJvbSB2MToN
Cj4gPj4+IFRoZSBwYXRjaCBzZXJpZXMgc3VwcG9ydHMgV0RULCBTRE1DLCBTTUMsIFNDVSwgU0xJ
IGFuZCBJTlRDIGZvcg0KPiA+Pj4gQVNUMjcwMA0KPiA+PiBTb0MuDQo+ID4+Pg0KPiA+Pj4gQ2hh
bmdlcyBmcm9tIHYyOg0KPiA+Pj4gLSByZXBsYWNlIGlzX2FhcmNoNjQgd2l0aCBpc19idXM2NGJp
dCBmb3Igc2RtYyBwYXRjaCByZXZpZXcuDQo+ID4+PiAtIGZpeCBpbmNvcnJlY3QgZHJhbSBzaXpl
IGZvciBBU1QyNzAwDQo+ID4+Pg0KPiA+Pj4gVGVzdCBzdGVwczoNCj4gPj4+IDEuIERvd25sb2Fk
IG9wZW5ibWMgaW1hZ2UgZm9yIEFTVDI3MDAgZnJvbQ0KPiA+Pj4gICAgICBodHRwczovL2dpdGh1
Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcvdjA5LjAwDQo+ID4+Pg0K
PiA+PiBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9k
b3dubG9hZC92MDkuMDAvDQo+ID4+PiAgICAgIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0K
PiA+Pj4gMi4gdW50YXIgYXN0MjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+ID4+PiAgICAgIGBg
YA0KPiA+Pj4gICAgICB0YXIgLXhmIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pj4g
ICAgICBgYGANCj4gPj4+IDMuIFJ1biBhbmQgdGhlIGNvbnRlbnRzIG9mIHNjcmlwdHMgYXMgZm9s
bG93aW5nDQo+ID4+PiBJTUdESVI9YXN0MjcwMC1kZWZhdWx0IFVCT09UX1NJWkU9JChzdGF0IC0t
Zm9ybWF0PSVzIC1MDQo+ID4+PiAke0lNR0RJUn0vdS1ib290LW5vZHRiLmJpbikNCj4gPj4+IFVC
T09UX0RUQl9BRERSPSQoKDB4NDAwMDAwMDAwICsgJHtVQk9PVF9TSVpFfSkpDQo+ID4+Pg0KPiA+
Pj4gcWVtdS1zeXN0ZW0tYWFyY2g2NCAtTSBhc3QyNzAwLWV2YiAtbm9ncmFwaGljXA0KPiA+Pj4g
ICAgLWRldmljZQ0KPiA+PiBsb2FkZXIsYWRkcj0weDQwMDAwMDAwMCxmaWxlPSR7SU1HRElSfS91
LWJvb3Qtbm9kdGIuYmluLGZvcmNlLXJhdz1vblwNCj4gPj4+ICAgIC1kZXZpY2UNCj4gPj4NCj4g
bG9hZGVyLGFkZHI9JHtVQk9PVF9EVEJfQUREUn0sZmlsZT0ke0lNR0RJUn0vdS1ib290LmR0Yixm
b3JjZS1yYXc9b25cDQo+ID4+PiAgICAtZGV2aWNlDQo+IGxvYWRlcixhZGRyPTB4NDMwMDAwMDAw
LGZpbGU9JHtJTUdESVJ9L2JsMzEuYmluLGZvcmNlLXJhdz1vblwNCj4gPj4+ICAgIC1kZXZpY2UN
Cj4gPj4gbG9hZGVyLGFkZHI9MHg0MzAwODAwMDAsZmlsZT0ke0lNR0RJUn0vb3B0ZWUvdGVlLXJh
dy5iaW4sZm9yY2UtcmF3PW9uDQo+ID4+IFwNCj4gPj4+ICAgIC1kZXZpY2UgbG9hZGVyLGFkZHI9
MHg0MzAwMDAwMDAsY3B1LW51bT0wXA0KPiA+Pj4gICAgLWRldmljZSBsb2FkZXIsYWRkcj0weDQz
MDAwMDAwMCxjcHUtbnVtPTFcDQo+ID4+PiAgICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAw
MDAwLGNwdS1udW09MlwNCj4gPj4+ICAgIC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0MzAwMDAwMDAs
Y3B1LW51bT0zXA0KPiA+Pj4gICAgLXNtcCA0XA0KPiA+Pj4gICAgLWRyaXZlIGZpbGU9JHtJTUdE
SVJ9L2ltYWdlLWJtYyxmb3JtYXQ9cmF3LGlmPW10ZFwNCj4gPj4+ICAgIC1zZXJpYWwgbW9uOnN0
ZGlvXA0KPiA+Pj4gICAgLXNuYXBzaG90DQo+ID4+Pg0KPiA+Pj4gS25vd24gSXNzdWU6DQo+ID4+
PiAxLiBRRU1VIHN1cHBvcnRzIEFSTSBHZW5lcmljIEludGVycnVwdCBDb250cm9sbGVyLCB2ZXJz
aW9uIDMoR0lDdjMpDQo+ID4+PiBidXQgbm90IHN1cHBvcnQgU2hhcmVkIFBlcmlwaGVyYWwgSW50
ZXJydXB0IChTUEkpLCB5ZXQuDQo+ID4+PiBBZGRlZCB3b3JrIGFyb3VuZCBpbiBJTlRDIHBhdGNo
IHRvIHNldCBHSUNJTlQxMzJbMThdIHdoaWNoIHdhcyBCTUMNCj4gPj4+IFVBUlQgaW50ZXJydXB0
IGlmIGl0IHJlY2VpdmVkIEdJQ0lOVDEzMiwgc28gdXNlcnMgYXJlIGFibGUgdG8gdHlwZQ0KPiA+
Pj4gYW55IGtleSBmcm9tIGtleWJvYXJkIHRvIHRyaWdnZXIgR0lDSU5UMTMyIGludGVycnVwdCB1
bnRpbCBBU1QyNzAwDQo+ID4+PiBib290IGludG8gbG9naW4gcHJvbXB0LiBJdCBpcyBhIHRlbXBv
cmFyeSBzb2x1dGlvbi4NCj4gPj4+IElmIHVzZXJzIGVuY291bnRlciBib290IHN0Y2sgYW5kIG5v
IGJvb3RpbmcgbG9nLCBwbGVhc2UgdHlwZSBhbnkga2V5DQo+ID4+PiBmcm9tIGtleWJvYXJkLg0K
PiA+Pg0KPiA+PiBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBHSUMgaXNzdWUgYnV0IEkgc3RhcnRl
ZCByZXZpZXdpbmcgd2hhdCBJIHJlY2VpdmVkLg0KPiA+Pg0KPiA+PiBUaGUgbWFpbGVyIGlzc3Vl
IG5lZWRzIHRvIGJlIGZpeGVkIGJlZm9yZSB3ZSBjb25zaWRlciB0aGlzIHBhdGNoZXMgZm9yDQo+
IG1lcmdlLg0KPiA+PiBNYXkgYmUgdXNlIGFuIGV4dGVybmFsIGVtYWlsIHdoaWxlIGtlZXBpbmcg
dGhlIHNhbWUNCj4gPj4gRnJvbTogYW5kIFNpZ25lZC1vZmYtYnkgYWRkcmVzcy4NCj4gPj4NCj4g
PiBVbmRlcnN0YW5kLg0KPiA+IFRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIGFtIGFza2lu
ZyBvdXIgSVQgaGVscCB0byBmaXggb3VyIHNtdHAgc2VydmVyDQo+IGlzc3VlLg0KPiA+IFRoZXkg
YXJlIGZpeGluZyBpdC4gSSB3aWxsIHVzZSBteSBleHRlcm5hbCBhY2NvdW50IHRvIHNlbmQgVjMg
cGF0Y2gNCj4gPiBzZXJpZXMgaWYgdGhpcyBpc3N1ZXMgZG9lcyBub3QgYmUgZml4ZWQsIHlldC4N
Cj4gPj4gV2hlbiB5b3UgcmVzZW5kLCBjb3VsZCB5b3UgcGxlYXNlIGFkZCBhbiBhdm9jYWRvIHRl
c3QgPw0KPiA+Pg0KPiA+IFN1cmUsIHdpbGwgY3JlYXRlIGEgcGF0Y2ggZm9yIGF2b2NhZG8gdGVz
dC4NCj4gDQo+IEZvcmdvdCB0byBhZGQsDQo+IA0KPiBwbGVhc2UgdXBkYXRlIHRoZSBkb2N1bWVu
dGF0aW9uIGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0Lg0KPiANCkdvdCBpdC4NClRoYW5rcw0K
PiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

