Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D2BC48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLAF-0007PW-4p; Mon, 04 Mar 2024 22:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLAC-0007P3-Uu; Mon, 04 Mar 2024 22:08:20 -0500
Received: from mail-psaapc01on2072d.outbound.protection.outlook.com
 ([2a01:111:f400:feae::72d]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLAA-0002q9-39; Mon, 04 Mar 2024 22:08:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar/Nk1xBm3agTV/F8mM1Z5t16Tsd39Me3kaHs/413f0rw3/V8tbsCiIMKrfQXS9dze86k5yO5uaE9iP6sp0B6i1OB3XTQS5wbwzjB6xNhN3zefWLS7NWuriik/HY17n317eGgTKvPeJxdA+SJdUNdFM8vT34JYsMQiUZLFW/f6Pg2zOMB6zcCGWI/zRSfH5vVSroF5U8qM92V8xRjgGqDkA3vBXEB2xuid0JFemlI4l0oo5zGKZAGIVh4TlPRIjCxnaYJMu6NWmfln3CwXYG5S7ZJ6Ge4n4aCz7uLTGcM/z2zvAltXy2Jhylhl2FKHlXOszMzdfXPAmsm+5eLW2p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE3U60ow941scL/28KvFlI7LWa8I2qoBhLYRMjPxkm8=;
 b=fYcClIPms1xu5lhyKho2q3xE085T7OrDiCljuzzlVm2w8hyceRRxO/mtgZeLlQDDQeY/QCmt5AeVc2cR3olJg5c0sf72QTbsEeo36Z+/Av/aeHBSfP/dKoz9LXMLzVnK9/DLf3QN6pE60Eu/T34NKimiA3jBpthxhiD9jZhdxu6K4+jiHzds15SCJlhqKqFW4p4E4MYo+myd0CrvxLoMJacAvmqxJNeGSeD/Ljret66vkMfAJG3OV2ePAsXC9PwpET4yn+Kda/wvVIyGIUvWBnN3xRJHloyQfNX/OSgBEqtSI1BmMcrbE7FsXRPW1Yt8LMgc8KPWYxPjoQdz0wgcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE3U60ow941scL/28KvFlI7LWa8I2qoBhLYRMjPxkm8=;
 b=XES+/3lCyihqt5qBSdu9pkX0CTYEDW8KQqYRIGJZjMI5qFkyEHjoO9iYggMQJbvZ7GD696fsoJEPaHa4ww/hu4lwL917gB7W8vgWeJr+fy7pFRWZJGdH1w0zmWjtKS3tLLYyo2dKimAj3HIobno5tTsXWcLBNAIa0Q4yfg75NBBwrRsn07hX2aNtT0DHznjVyKJVzNtq9vvFcln/OkPCFfhF6KEzRPi48OJc+nbEUj/XbETgh94rccx8502EuulYqVSGdDMeDHNd2qfoymorHfNvsXH2oMFUW/6rT1I2UjRvY3ngwgNDLjEyChCVmCq/FpkwtpzIxxziXI/tJB/acg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.34; Tue, 5 Mar 2024 03:08:06 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:08:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 1/9] aspeed/wdt: Add AST2700 support
Thread-Topic: [PATCH v2 1/9] aspeed/wdt: Add AST2700 support
Thread-Index: AQHabhZ+FqnzO83pVUe3iO4n9inkxbEnpWCAgADS8tA=
Date: Tue, 5 Mar 2024 03:08:06 +0000
Message-ID: <SI2PR06MB5041C973CB228EE09F4B03DAFC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-2-jamin_lin@aspeedtech.com>
 <10fc74b2-7bab-4c97-9e55-8e73a38b7440@kaod.org>
In-Reply-To: <10fc74b2-7bab-4c97-9e55-8e73a38b7440@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6935:EE_
x-ms-office365-filtering-correlation-id: 2c0fbc88-1f1b-40ee-d5fe-08dc3cc17ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 134wTAHAfr8E3XLpufG6uj0G0yBTcJXkC0LxTqNHFZfTb8P9F+hLG0XUqEa3Qu8f5hIZtWIxTEEvQIXI0GhE0F0ei+WFm4tub5Gr/f6WQAQ3kgxc7wNy872+IQ4J3jpsm6ZjjEQyiir4D1zmvoJejlUnS8gsLil739JwpWttiIAeW4OhMDUJ1rD6xJfiyw0W7pMiDzEajc/rpN1qAC3QMFH2cFTrIJg07agupjV8O5oIk1H+xVYmhzHys4HloF4ZZ9En9mrqc/vbC3C58GLxudY14rWDQtZRm8P55md1TgacHpSlHHftIY2/j/1Ztf2MPr6C8ShJsVe1iSsAj1oed9Al3DzhQ5NccFpk82fPsqruqskoCOkMmmRIdH1oIschQrP813oxXL+DrT3jQ09K5YfyWCArq4socqQ6aH+B4ZGfRKZSf2ZBBbSTJ9bRmpZaW+tJ7aaY3V6I8NtIQBEy7hKeYV9gYUjsuLEwje6xSmxj8Maz/FXSrzLeJufgeC1Zse2bfxwEvnE6jmz+sOqwcfAHZb5G3K5pOqtqZ4hOqPGsZSzqwYA5yzz4TRqmbf1UHJ010jH3HJxg2e/dAli73ofMevx55kAqOnp+LefpeCAFX1vcf1jS6HmZ6X1Vcffrt65sVYqibnNnm3xZ+mJ3jxiwSn/jyaGrOpHinAF3EVxkW2lUif1QZ+j4mnjeW6BD/YfO7VyjGXa4vjGlC3YekiEMaEdYmOtyM4MRjwVfPgY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejY2Z25ha1BqaFN5ZnpZUllpTHE0bXJjUFJPUlNVRnc2V2UzOFBRTlZzQWIv?=
 =?utf-8?B?SEJZcVdFOVkzWTBERkxIWlFrQ2JxeE9Fa3dsNTI2dFlPSG9hdi83WGlkOUt1?=
 =?utf-8?B?UmdsMTBieEtaMkdyN3VZZ3lQSjhPOUNjNmxJb0pKNXpVU2VLUkdXOER5eDBz?=
 =?utf-8?B?SmVRRTFOV3pTMmZkNTBHblZNT0RpV1VPMENmM29OdlNNYTRQQTRQMWxaUnBE?=
 =?utf-8?B?R1d1MUh6UGtmRlJjUm9hWGNZckN4cTdnVFluaGVOcVhIWTR3RDZmZnR1VHl1?=
 =?utf-8?B?RDJoVGxPZ3JybnhQc2ZoRFU5bk1CWDBqQTRuWGQ1NjNDY3ppZ2VHVFRwMmpB?=
 =?utf-8?B?MXIzaGU3MzQ2NC9Db1h1cFAwSkx3NmpIUVlQSGxqSWZnR0pyN2NPQnE3TFkx?=
 =?utf-8?B?M0RMZC9GblFtZHdYUUx0R0VQbWZ6MmxRVnQrVFhyTGFTL2E4d0R3L3lzeWVB?=
 =?utf-8?B?YUFWWDZlTWtxd1lSZjRyMk1keksxVGJCak9PK2FYVDFBZ0JLZEJYcDZmd3Iw?=
 =?utf-8?B?bWgwZUE2SUVRdHJSYitsbGR4RWhDUS9RVHkxQXBjaGQvODM3R1FKcEpuTS9X?=
 =?utf-8?B?MkszVjhodHJQcERJSlJYNGVaTW9xY3NvQWhKamE5OUlvUGIrVUovbGFKREJK?=
 =?utf-8?B?SEVyYWdUbGFiK2dLSjJqQlp3M3BKQldJRi90alNyOW1qZm1DTzY0bnJ2Y1Ez?=
 =?utf-8?B?SGxaM2JSRWJFRXF5SGo0c2xhbS9UMzdKM0k3MWI1RjNQay9TbG9NVFRvSmVo?=
 =?utf-8?B?OWxucHZHYzFWOUFaUHZsTmlmWE04V3htOTFKa3I3NjV3TCtVOWI5cGF6SlIy?=
 =?utf-8?B?dHJwcXZ5RlEwblpyekZNOUhYSmxFSERLdjl5OXFHZFJPK2pVMDl1czNpYVpN?=
 =?utf-8?B?dG1Ba2FRTmQ4WWRkTjdvNlk4MEV4NmVJMlhaN04yOG5sWUtWRFlPb1Q3Q3cv?=
 =?utf-8?B?bENGNXFsRWxic21hZ2R3SWpvc0xlYStMbnlIdGt6Y1YyMkNLeUd3YUVtYlc0?=
 =?utf-8?B?VE5WWjJkcUExbHZvaHRsekowNnlXekZhcW1zRTJTeFZkTkNIVkhZU3hWY0VU?=
 =?utf-8?B?NE1nVDZNdVRUbjJFV0VBOWxtbUU0eVYzWGZUNzB2QzE3RjFja2RuOHh2T0pP?=
 =?utf-8?B?NXc4NXQrTFIvWTJFc090UHlPNk5ncklia1JTS3R3eEFCek1FWWJJcGxQY1Fz?=
 =?utf-8?B?Z1ljcE5ybC9NVXR3Y3FjZVM5K1ZUbjQvZkJ2MzZOOEswYmpGbGM4SGlCclJQ?=
 =?utf-8?B?bEpkdU1ldi8zbDE3dm4wWlp1UlhzTjg3bkpQbnpKQTFxY2ovTTdNL0NHZzZw?=
 =?utf-8?B?TXpUZHAzMmVFKzNuRUZieWw4YjZrRTFvQ0Zjc0tjcDNZQU5sejR2cjI4Z2NY?=
 =?utf-8?B?YVltZVNyaW9OV2NzWmhOT0svUEVPK2h0NzJObmE1NGIxL2h6TjJIMElpRTNY?=
 =?utf-8?B?V09iY3RoazMzd3lnSzlnUUsxY25ZdnVnd2FRMC9MaFNLU0xHUEFyblBFQWxV?=
 =?utf-8?B?OEt4NXpUWGR0c0plZ2dUSURGSTUxdmRidFR2TzJITVc2YkJkd2lQVUZzY1VN?=
 =?utf-8?B?NVFVK29BODVIczBaSUZYRlVobDB2UlRHbjA0L2h0ZWxnd1I1S25MdDBNNDgy?=
 =?utf-8?B?TStSelh1cURWU2RXcGd1TDFBYWZWZjZpRDRCY285TlNJclNLbmJVNk5Xa0dx?=
 =?utf-8?B?dnBDSGM2TE5GZmxCSGpsNjhWVjV1d25NZ25kQkxDTTVxaU1LTU93WXg2ZFUv?=
 =?utf-8?B?d3I4UTI0WTdjaTJmUFpLcVZ2RFlVV0N0azFFQk1DS2VwWVNFNWJaYTdERml0?=
 =?utf-8?B?UHNEN2M1UTBDSEVTRFNCemoxeFVrQ2xWc241ZGhmaHhXbnFiQkpiK2t2dEEx?=
 =?utf-8?B?QzUrUDJxcW5qRDBFV1JuaVFpYzdVUWJMd0kwYWVoc3g2Sk9tMm8zM2dGODlC?=
 =?utf-8?B?N2lwRWhXUzBYeVRMajVIWXhKWHpLdk1zR3MvYmtJV25QK2tsbnZ6R0dxb2hI?=
 =?utf-8?B?Y3pZUHFQR3FacjJYWVNzeXoybHd3dGJlcE9ObmlGMHM3bW1lanNxN2JWRDFW?=
 =?utf-8?B?TU9KLy9MdXBRSlBJTEZzZGxVZTFxOC95Y3gwdTRQYng1OUlwZDNhMWlTcXhG?=
 =?utf-8?Q?JhOtC9Rk8np8UO6jKwrNe0LtM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0fbc88-1f1b-40ee-d5fe-08dc3cc17ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:08:06.4118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbJam9+sjBh0lkHkUZpofQl///zsDUE9ypzPxSNTSvez0LXnnk7kUbTuh8lSvABUxDkEeDDcsuccT895EB9pcVkVKNf7Cgzh6uLfx4t11CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6935
Received-SPF: pass client-ip=2a01:111:f400:feae::72d;
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMjQgMTA6MzIgUE0NCj4g
VG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0K
PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2Rl
Y29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgb3Blbg0KPiBsaXN0OkFTUEVF
RCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhl
cmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzldIGFzcGVlZC93ZHQ6IEFkZCBBU1QyNzAw
IHN1cHBvcnQNCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gMy80LzI0IDEwOjI5LCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4gQVNUMjcwMCB3ZHQgY29udHJvbGxlciBpcyBzaW1pbGlhciB0byBB
U1QyNjAwJ3Mgd2R0LCBidXQgdGhlIEFTVDI3MDANCj4gPiBoYXMgOCB3YXRjaGRvZ3MsIGFuZCB0
aGV5IGVhY2ggaGF2ZSBhIDB4ODAgb2YgcmVnaXN0ZXJzLg0KPiANCj4gLi4uIHRoZXkgZWFjaCBo
YXZlIDB4ODAgcmVnaXN0ZXJzLg0KPiANCj4gPiBJbnRyb2R1Y2UgYXN0MjcwMCBvYmplY3QgY2xh
c3MgYW5kIGluY3Jlc2UgdGhlIG51bWJlciBvZiByZWdzKG9mZnNldCkNCj4gPiBvZg0KPiANCj4g
Li4gaW5jcmVhc2UgLi4uDQo+IA0KPiA+IGFzdDI3MDAgbW9kZWwuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+DQpUaGFua3MgZm9y
IHJldmlldyBhbmQgdHlwbyB3aWxsIGJlIGZpeGVkIGluIFYzIHBhdGNoIHNlcmllcy4NCkphbWlu
DQo+IA0KPiBSZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIGh3L3dhdGNoZG9n
L3dkdF9hc3BlZWQuYyAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
ICBpbmNsdWRlL2h3L3dhdGNoZG9nL3dkdF9hc3BlZWQuaCB8ICAzICsrLQ0KPiA+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5jIGIvaHcvd2F0Y2hkb2cvd2R0X2FzcGVl
ZC5jIGluZGV4DQo+ID4gZDcwYjY1NmY4ZS4uNzU2ODVjNTY0NyAxMDA2NDQNCj4gPiAtLS0gYS9o
dy93YXRjaGRvZy93ZHRfYXNwZWVkLmMNCj4gPiArKysgYi9ody93YXRjaGRvZy93ZHRfYXNwZWVk
LmMNCj4gPiBAQCAtNDIyLDEyICs0MjIsMzYgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVl
ZF8xMDMwX3dkdF9pbmZvID0gew0KPiA+ICAgICAgIC5jbGFzc19pbml0ID0gYXNwZWVkXzEwMzBf
d2R0X2NsYXNzX2luaXQsDQo+ID4gICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF8y
NzAwX3dkdF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZA0KPiA+ICsqZGF0YSkg
ew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiAr
ICAgIEFzcGVlZFdEVENsYXNzICphd2MgPSBBU1BFRURfV0RUX0NMQVNTKGtsYXNzKTsNCj4gPiAr
DQo+ID4gKyAgICBkYy0+ZGVzYyA9ICJBU1BFRUQgMjcwMCBXYXRjaGRvZyBDb250cm9sbGVyIjsN
Cj4gPiArICAgIGF3Yy0+aW9zaXplID0gMHg4MDsNCj4gPiArICAgIGF3Yy0+ZXh0X3B1bHNlX3dp
ZHRoX21hc2sgPSAweGZmZmZmOyAvKiBUT0RPICovDQo+ID4gKyAgICBhd2MtPnJlc2V0X2N0cmxf
cmVnID0gQVNUMjYwMF9TQ1VfUkVTRVRfQ09OVFJPTDE7DQo+ID4gKyAgICBhd2MtPnJlc2V0X3B1
bHNlID0gYXNwZWVkXzI1MDBfd2R0X3Jlc2V0X3B1bHNlOw0KPiA+ICsgICAgYXdjLT53ZHRfcmVs
b2FkID0gYXNwZWVkX3dkdF9yZWxvYWRfMW1oejsNCj4gPiArICAgIGF3Yy0+c2FuaXRpemVfY3Ry
bCA9IGFzcGVlZF8yNjAwX3Nhbml0aXplX2N0cmw7DQo+ID4gKyAgICBhd2MtPmRlZmF1bHRfc3Rh
dHVzID0gMHgwMTRGQjE4MDsNCj4gPiArICAgIGF3Yy0+ZGVmYXVsdF9yZWxvYWRfdmFsdWUgPSAw
eDAxNEZCMTgwOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkXzI3
MDBfd2R0X2luZm8gPSB7DQo+ID4gKyAgICAubmFtZSA9IFRZUEVfQVNQRUVEXzI3MDBfV0RULA0K
PiA+ICsgICAgLnBhcmVudCA9IFRZUEVfQVNQRUVEX1dEVCwNCj4gPiArICAgIC5pbnN0YW5jZV9z
aXplID0gc2l6ZW9mKEFzcGVlZFdEVFN0YXRlKSwNCj4gPiArICAgIC5jbGFzc19pbml0ID0gYXNw
ZWVkXzI3MDBfd2R0X2NsYXNzX2luaXQsIH07DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgd2R0
X2FzcGVlZF9yZWdpc3Rlcl90eXBlcyh2b2lkKQ0KPiA+ICAgew0KPiA+ICAgICAgIHR5cGVfcmVn
aXN0ZXJfc3RhdGljKCZhc3BlZWRfd2R0X2luZm8pOw0KPiA+ICAgICAgIHR5cGVfcmVnaXN0ZXJf
c3RhdGljKCZhc3BlZWRfMjQwMF93ZHRfaW5mbyk7DQo+ID4gICAgICAgdHlwZV9yZWdpc3Rlcl9z
dGF0aWMoJmFzcGVlZF8yNTAwX3dkdF9pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0
YXRpYygmYXNwZWVkXzI2MDBfd2R0X2luZm8pOw0KPiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0
aWMoJmFzcGVlZF8yNzAwX3dkdF9pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0YXRp
YygmYXNwZWVkXzEwMzBfd2R0X2luZm8pOw0KPiA+ICAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5oDQo+ID4gYi9pbmNsdWRlL2h3L3dhdGNo
ZG9nL3dkdF9hc3BlZWQuaA0KPiA+IGluZGV4IGU5MGVmODY2NTEuLjgzMGIwYTc5MzYgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9ody93YXRjaGRvZy93ZHRfYXNwZWVkLmgNCj4gPiArKysgYi9p
bmNsdWRlL2h3L3dhdGNoZG9nL3dkdF9hc3BlZWQuaA0KPiA+IEBAIC0xOSw5ICsxOSwxMCBAQCBP
QkpFQ1RfREVDTEFSRV9UWVBFKEFzcGVlZFdEVFN0YXRlLA0KPiBBc3BlZWRXRFRDbGFzcywgQVNQ
RUVEX1dEVCkNCj4gPiAgICNkZWZpbmUgVFlQRV9BU1BFRURfMjQwMF9XRFQgVFlQRV9BU1BFRURf
V0RUICItYXN0MjQwMCINCj4gPiAgICNkZWZpbmUgVFlQRV9BU1BFRURfMjUwMF9XRFQgVFlQRV9B
U1BFRURfV0RUICItYXN0MjUwMCINCj4gPiAgICNkZWZpbmUgVFlQRV9BU1BFRURfMjYwMF9XRFQg
VFlQRV9BU1BFRURfV0RUICItYXN0MjYwMCINCj4gPiArI2RlZmluZSBUWVBFX0FTUEVFRF8yNzAw
X1dEVCBUWVBFX0FTUEVFRF9XRFQgIi1hc3QyNzAwIg0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVF
RF8xMDMwX1dEVCBUWVBFX0FTUEVFRF9XRFQgIi1hc3QxMDMwIg0KPiA+DQo+ID4gLSNkZWZpbmUg
QVNQRUVEX1dEVF9SRUdTX01BWCAgICAgICAgKDB4MzAgLyA0KQ0KPiA+ICsjZGVmaW5lIEFTUEVF
RF9XRFRfUkVHU19NQVggICAgICAgICgweDgwIC8gNCkNCj4gPg0KPiA+ICAgc3RydWN0IEFzcGVl
ZFdEVFN0YXRlIHsNCj4gPiAgICAgICAvKjwgcHJpdmF0ZSA+Ki8NCg0K

