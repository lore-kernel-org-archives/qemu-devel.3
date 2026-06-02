Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C4BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUG6U-0008Vs-QC; Mon, 01 Jun 2026 23:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUG6S-0008V5-DV; Mon, 01 Jun 2026 23:47:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUG6Q-0008IH-Rr; Mon, 01 Jun 2026 23:47:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpMM1r2j4mRjUDRHwp5d3d7TUb6jN0/BYKWSOF/hd3yZbaNb0LTzLz14PobBPG6G2HFCxG24cf1ESUtrYI4pPZsad7tmJa8PDnt11ubBgHTWhW11lqYp4msPEq0lr7ghWEMEyYfegYw+oIk1HPqmbBxs5s9EToh+9VrmqA5LaJQEVzz3V0T50v6d+VMK/8/Fn8T3c1n8mPtg14fauWBnbPq3rvimUtmTOpNp2ekg4u7oiUG1Juz5WuP9kYwmxM9VMnduJeXKIG9YrPG6uNvOff3UkF0NG2HqVkQCM2vT3HanEaC16LnmO3OvXM8FagffQMO/jhKbGjQ4yYH81c3H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpUR+zslI0Jb6Wt5vVRVoP+Qc4bXqToa+JRhxSys6B4=;
 b=yTeGklA0IPNCU3CiYWX7XXbTPQm2BIPJ7sMd8yXjHFiZmfcia/LUeyiRbIqxqQ2z30+fgjAyIj1UFt68T+mvfj/XTzlOA56qk6zDQQUQLYkqIhu5G2gehDmnia3cbtRk5XIQBKHImohXIeeQChj0K89xRooU9z5L+fEB8mLN1xQFQE0Kz76T7kIldoCnhTQ9mPr73TvvGWK2Y9p87sp/ODABwQYupa6ud4K4XDeMP9Y1E02MW5EOdP3dhB/RkF+ZRz6rKv0pA+8VvnP3aD/Z2pwRiIMJj0BK9tNQYFmZZnfIsL4DtzVDKK2awnB0skBxEAAyv9h+KGER/RPXnVyrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpUR+zslI0Jb6Wt5vVRVoP+Qc4bXqToa+JRhxSys6B4=;
 b=iiQmfc0c6vRDg4zcCxlwQAjRrwOLNEl3c7z5PBTx1d9U6hZ5I7kXFbWiTA9xkuECZVvC6TCxuvM9pC5WiHINDh9hWJrums7FAuljPD+uZlc9OojoDsV+4RJCXJ6vnmiYJfwnRQT2TUcaJmhaqT/mOMlTHkkstXcephMg9WxQW6uQkliPvMGIEYICn09Iar2PP3/3EvfwvYSD9TGfrLfoe8TlmB0kt5xCkW6DFJlbXNCmsLir+GJWhiKHrB0t127J3z8pqbM25pj+7j13xHXTRgNiDpOD1GvFr48LbNTZL4RsGwb+KBvrQ2lyj4b+e5vgC3+MnB91uaUTYMUwr8Na6w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5267.apcprd06.prod.outlook.com (2603:1096:4:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 03:47:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 03:47:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
Thread-Topic: [PATCH v1 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard
 I2C device
Thread-Index: AQHc7zZhOIvpzBPIukWFXsINZP3HIbYpr1MAgAD3LbA=
Date: Tue, 2 Jun 2026 03:47:35 +0000
Message-ID: <TYZPR06MB4980683927FA7976600273A3FC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-10-jamin_lin@aspeedtech.com>
 <deca1d33-2a68-4033-a26e-091d1dd7d260@kaod.org>
In-Reply-To: <deca1d33-2a68-4033-a26e-091d1dd7d260@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5267:EE_
x-ms-office365-filtering-correlation-id: cf0fd906-237d-47dd-8bf4-08dec059af69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: eVBylFD1fOOsOXC+x3uZygCPh7iyh22Fp+XxJMEOQ+XoJujq05z7oGgbDWBJ4WbwNCxFvusnKBJPleqnLh/CQ3nLoeJcQItV53koe6BJRev0SNJhqcG/hni1Hfn7xLDCIwvqwx7lR0Ehy/AraqiTb117Ni8KqXI3UlpHNQ/70MkbAEYyrJ/QlUlZmEHHZt0GKpEOnXtxZWUacNQmf1WXplUUgJfK8nMVwjWuhmtMHLTPzsBFaR9n4Wa3pZTKbH3V7FXc4AXfwhPzMobmkOwea1kAANwxZZAvCusKZwKkoeTz/rb2pRrvJEiXLm+FKJXsuI4L5OLG/2bsm20SsTrdRsrXz2y3LvFVw6f/1tSKvRjT/dXWhTeLD4r5CJ4qH4iIMStdVlzu3xZKpjlQrJVxtQN1qsEAg+XWWLlarcayaUOZzKqNgjHoZ75ayW777k0+WEMwqGIE8C+yoxrU/giRDbjvkSQ+o9yMvvL36Ize3CDtgL/UKHUU8cc1dsJvfWuC76iBeqLICNOStJ4acWqahDY1vUsIfVDVA0r4VoLX0dNQm+qrZ1iJO1l4w+AkeenyKIx2/NyN/l9o+CBRNr+IHxP5DzA8IB0ByO7PDjMviX7pIuk7Tuo/ujn7jYz2hg94BMpCt9Nc0mk8HbmIqH/dbma07SLjXJ9RsdkTteJtKiyXtJPl0vS2c3a5hO0CQqeXdIShYI3J1++r0K/7gNyu2WECyzH7aIA/FLE4Do66NJN8oDpbU+Jm8AMeBLzaV5Iu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi9GTzRpVHhxMnZBT3MxMk93QzJTSVp0L1N0RTAwSTlab3ErMEVqRWR2OUtj?=
 =?utf-8?B?dWF5YjB4ZWI4OVNyOGluTjR5bWZZRzM1WE1XcTJNNXI2S3poYm5RV1NRNUND?=
 =?utf-8?B?SjE3L3h5K2tjazJBZWYxbk5UUXl6TW5vbTJLTTY1bkRBSW0vNHdlSU5pYVNJ?=
 =?utf-8?B?TjlDU21ua1NjTWNtQVBRNUsycEZ2TUNuME9xQzlBaUt5VDhaS3RzT2tyS2ZR?=
 =?utf-8?B?R3hvNG1EdHZDZGNobEJZclA2SlUxdGtUN3F1K2dLamVWeUhnYVVBTWVDSURt?=
 =?utf-8?B?N2pBWXAzNjRub3V3WW1qb0hOSE9pQjdXclNWUEllY0hHSGJsck11L3ora0VB?=
 =?utf-8?B?ZmxtWDJBMkVBRTZzODJ1bXJFZlpKeGtyd2sya0tyMnljOG1UTXEzMHRuRTMv?=
 =?utf-8?B?bDNwcnp2a0cyM1Z2SnpNZUoyNXZoN1N0MCtCY0Irc3l0eG5PMWNJallFMVVY?=
 =?utf-8?B?cGR2YjlFSW5zMjgraEg1TjVOVUFtZHNpMVhtSTMzUmY0ZVBGV0F5cXlWSXZI?=
 =?utf-8?B?Y20vbzhXemZCQ1JuMm5zckllbkdwc3JaM3gzLyt3UVJFNzJFdmlJL1ZLRzA0?=
 =?utf-8?B?eERBOXVXMXFpUGJBa1U4Zy83R0xtV3VadFVFZXZYcjFDdVlNS0hpS1lQb2lF?=
 =?utf-8?B?aElMcEJ4MEJ6YzM3bDB1ZC81Vk53aEQ5Zmd4TjVXdWFtVEJ5djE5aWlaVVha?=
 =?utf-8?B?Y2p1c2IxVjNCNGFZZW1XSDNKT24yMEpwYWJGWUM5SDdSaW9jM1B6YjZTQlln?=
 =?utf-8?B?eVRaZ1N2bHVha3dib2I3QmJmaWhhekoyMDl4cU9WSERRaWxQNTgwTHBndDd0?=
 =?utf-8?B?ejVseDB0cFRuYzBiNzBGalB3N2M2bnlpVU1neCtTQ1pKb2RoKy9QUXZiY1dR?=
 =?utf-8?B?eGhlaWcwVVhSbUxDMzRibWpydUpId1NWTzZRelY0SHdiQTQ4QlNvWlRQbE0y?=
 =?utf-8?B?d0lWOWVkQmRpTUN2QTBSV0JwTmRhRnJUdE9Uc2lwckk1NExMTUdsdkVsQi9a?=
 =?utf-8?B?aVpCMnRDbmoyMCtBSHVxMVZpd0hKVG95eU8vSFA0OVRwV095Y0xCUVdnT3Qy?=
 =?utf-8?B?d3AybDVJa3NaVnVsZC9VVTJRam5LMldKbm53OTFycVphTnNnWXVRTVQ1T3R1?=
 =?utf-8?B?bndYRWcwd1IxVVJwNCtnZFNFcndUcmQ0bVpzeUxqeXNIMHRtNERwRkRJQ09w?=
 =?utf-8?B?UFMyN3NYV09aRVBwc20xalY0L3kzTHM1c0NUdzlNdHc5RWVwcnVGTThZNUg3?=
 =?utf-8?B?WUwwMXdqMjVvRVBSUDMxTGVsbjB1WTVtcDNjK29hWWJNRmdnU0NtbGV0WGoz?=
 =?utf-8?B?MDBhdHhVNGx1UGdsQ3o4dEF1dnhrRWh1VFlxRGFPUVJwREZQdkRzVTVIeDZu?=
 =?utf-8?B?M01RSTQwZ3dqWWlIeU9IY0RwbHhBb3FrTTE0VllSNlhJRVEzeXVQd3RPZ3ZW?=
 =?utf-8?B?RDhPVW9aVlFIa1VqbXdkYy81cmpvd2lXeVA1ZHlHUWxHU2JhQWd1Z3pQbUdj?=
 =?utf-8?B?ZCsxZDJLbXAwaFE3TUdTandicUdLSVBtKzVlVlhqQTZOeUlhN2M1TjlTQS83?=
 =?utf-8?B?MEdUZHQ5S212WTViaWU4bk53TEp6REl5QWg2aUNSbHdZSXRwYStVYlFtWnk2?=
 =?utf-8?B?VUJ4R0NleGl6OVRVK2tzK1R6WDB4L0xtN1pzOTRSMTNIWE9VakxNRktvbWFV?=
 =?utf-8?B?UStZVllkcjJCSEIvQ1lGNHZKeDlZWkZSY1NCSmJXb3ZFUHl5ZlIzSnVRSjNw?=
 =?utf-8?B?V0NjdXl1a2l0ZzZHeGxkbDhKTXFnYkNPQ2VxYnRQTW9KZkZFNDdZcmZxTThE?=
 =?utf-8?B?Q1lhMjJpV21XTXgyVDk3WFJpUWlCaERhNUw1bEh3US82VHN6RWFBZ2ZGR0pY?=
 =?utf-8?B?a0hOMlJiS1VKTGFqeVFNcjkybXlxbVV3cWpDMFgxSjgwWXdiRTVaQy92SE92?=
 =?utf-8?B?RGNvenB6cWFudmVYY3ZCVXJKV1l3VFZVeVJhWWJLYitCaFFYOUkvZEswN0Nn?=
 =?utf-8?B?QTJWK3J0RXZrRGU5MXRYT0d1SmpkYWh5MndmbDZhL3B2RmQ4LzF5b0R6bmVz?=
 =?utf-8?B?L05rc0hndUt0cHBCRklENnlrKzY4UnJPcGNiWExLYlpvbFNoZkFkYjBTTHJt?=
 =?utf-8?B?eGRJVkRxQUhqTVF6SVF3R2hOUGUzVWFkTmxaY2N0N3dOWG4xNVZKTjdTVUMy?=
 =?utf-8?B?aWhzazIwQlB4WVhNd1cvZFZlWHNhakRhbmhnWEZZMjNYSkxGVVQwTUI1cVY5?=
 =?utf-8?B?OHVxeUo5YXVYRjlMYkkvQkh1bXM5TUR4cVAxSlNzWmRCcXhydlkxa3dlQkRE?=
 =?utf-8?B?ekQrU0Y4NzdrazVoeW1rWHF5MVFjMWdyR2FmYjJCeFRCR1E5T2Mrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MMRFNL9hUZgcUv9NntHZrCYO7qPTWk2KnL5ixK5DYcjnKQRUUfKoVgxdByrSScm/RzvAI4JvAi7zF60fuR1BNr6U4ss0NXCA/BS5yuBu9fcvKT0geeONHwSo5WDoJrBacukuF4nT9qOgaRoCnspikKj2ZhA/JBQOLraVhXkx+RDDVLPu5XTsU0KGa9OZsmojzBRr3mnI/jh3tYGlpNgVwt2t2+ThkFenpBAP53PWkGUCQ4ZeS935QiyxB0Ef/TcuRW/gADc5d0nxpDLxWlrfBP2Ich1fmoLRHn1H4C3VBYlbJ5S4drZR11D88ZaLW0F9D/CPDPoxUuhjzPUeldZXQw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0fd906-237d-47dd-8bf4-08dec059af69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 03:47:36.0169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxQ5Ot0fOrz86a/+rXgI3b0nRC9IRL94aFGguWADziSX+mkNcWEj0nhbeVeinPoRo6b88n6Q7e3H2+VH7wzpGW3eAZWumyyhq5BMAIDbGTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5267
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDkvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0MTA0MF9ldmI6IEludHJvZHVjZQ0KPiBvbmJvYXJkIEkyQyBkZXZpY2UNCj4gDQo+IE9u
IDUvMjkvMjYgMDg6NDIsIEphbWluIExpbiB3cm90ZToNCj4gPiBJbnRyb2R1Y2Ugb25ib2FyZCBJ
MkMgZGV2aWNlIGluaXRpYWxpemF0aW9uIGZvciB0aGUgQVNUMTA0MCBFVkIgbW9kZWwuDQo+ID4N
Cj4gPiBUaGlzIGNoYW5nZSBhZGRzIHRoZSBpbml0aWFsIG9uYm9hcmQgSTJDIGRldmljZSBzZXR1
cCBmbG93IGFuZA0KPiA+IGluc3RhbnRpYXRlcyBhIDI0QzA4IFNNQnVzIEVFUFJPTSBkZXZpY2Ug
Y29ubmVjdGVkIHRvIEkyQyBidXMgMCwNCj4gPiBtYXRjaGluZyB0aGUgY3VycmVudCBBU1QxMDQw
IEVWQiBoYXJkd2FyZSBkZXNpZ24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4g
PGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRf
YXN0MTA0MF9ldmIuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVk
X2FzdDEwNDBfZXZiLmMgYi9ody9hcm0vYXNwZWVkX2FzdDEwNDBfZXZiLmMNCj4gPiBpbmRleCAx
ZDliNTUyNDdmLi4zOTJiMGQ1MTU5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0
MTA0MF9ldmIuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0MTA0MF9ldmIuYw0KPiA+IEBA
IC0xNCw2ICsxNCw3IEBADQo+ID4gICAjaW5jbHVkZSAiaHcvYXJtL2FzcGVlZF9zb2MuaCINCj4g
PiAgICNpbmNsdWRlICJody9jb3JlL3FkZXYtY2xvY2suaCINCj4gPiAgICNpbmNsdWRlICJzeXN0
ZW0vc3lzdGVtLmgiDQo+ID4gKyNpbmNsdWRlICJody9pMmMvc21idXNfZWVwcm9tLmgiDQo+ID4N
Cj4gPiAgICNkZWZpbmUgQVNUMTA0MF9JTlRFUk5BTF9GTEFTSF9TSVpFICg0ICogTWlCKQ0KPiA+
ICAgLyogTWFpbiBTWVNDTEsgZnJlcXVlbmN5IGluIEh6ICg0MDBNSHopICovIEBAIC0zOCwxMiAr
MzksMjggQEANCj4gPiBzdGF0aWMgdm9pZCBhc3BlZWRfYmljX21hY2hpbmVfaW5pdChNYWNoaW5l
U3RhdGUgKm1hY2hpbmUpDQo+ID4gICAgICAgYXNwZWVkX2Nvbm5lY3Rfc2VyaWFsX2hkc190b191
YXJ0cyhibWMpOw0KPiA+ICAgICAgIHFkZXZfcmVhbGl6ZShERVZJQ0UoYm1jLT5zb2MpLCBOVUxM
LCAmZXJyb3JfYWJvcnQpOw0KPiA+DQo+ID4gKyAgICBpZiAoYW1jLT5pMmNfaW5pdCkgew0KPiA+
ICsgICAgICAgIGFtYy0+aTJjX2luaXQoYm1jKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAg
ICAgYXJtdjdtX2xvYWRfa2VybmVsKEFSTV9DUFUoZmlyc3RfY3B1KSwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgbWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBBU1QxMDQwX0lO
VEVSTkFMX0ZMQVNIX1NJWkUpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFzdDEw
NDBfZXZiX2kyY19pbml0KEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jKSB7DQo+ID4gKyAgICBBc3Bl
ZWRTb0NTdGF0ZSAqc29jID0gYm1jLT5zb2M7DQo+ID4gKw0KPiA+ICsgICAgLyogVTEwIDI0QzA4
IGNvbm5lY3RzIHRvIFNEQS9TQ0wgR3JvdXAgMSBieSBkZWZhdWx0ICovDQo+ID4gKyAgICB1aW50
OF90ICplZXByb21fYnVmID0gZ19tYWxsb2MwKDMyICogMTAyNCk7DQo+IA0KPiAzMiAqIEtpQg0K
PiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBkby4NCg0K
SmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4gKyAgICBzbWJ1c19lZXBy
b21faW5pdF9vbmUoYXNwZWVkX2kyY19nZXRfYnVzKCZzb2MtPmkyYywgMCksIDB4NTAsDQo+ID4g
KyBlZXByb21fYnVmKTsNCj4gPiArDQo+ID4gKyAgICAvKiBVMTEgTE03NSBjb25uZWN0cyB0byBT
REEvU0NMIEdyb3VwIDIgYnkgZGVmYXVsdCAqLw0KPiA+ICsgICAgaTJjX3NsYXZlX2NyZWF0ZV9z
aW1wbGUoYXNwZWVkX2kyY19nZXRfYnVzKCZzb2MtPmkyYywgMSksDQo+ID4gKyJ0bXAxMDUiLCAw
eDRkKTsgfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5lX2FzdDEwNDBf
ZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkDQo+ICpkYXRhKQ0KPiA+
ICAgew0KPiA+IEBAIC01NSw2ICs3Miw3IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9tYWNoaW5l
X2FzdDEwNDBfZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICAgICAgIGFtYy0+
aHdfc3RyYXAxID0gMDsNCj4gPiAgICAgICBhbWMtPmh3X3N0cmFwMiA9IDA7DQo+ID4gICAgICAg
bWMtPmluaXQgPSBhc3BlZWRfYmljX21hY2hpbmVfaW5pdDsNCj4gPiArICAgIGFtYy0+aTJjX2lu
aXQgPSBhc3QxMDQwX2V2Yl9pMmNfaW5pdDsNCj4gPiAgICAgICBtYy0+ZGVmYXVsdF9yYW1fc2l6
ZSA9IDA7DQo+ID4gICAgICAgYW1jLT5tYWNzX21hc2sgPSAwOw0KPiA+ICAgICAgIGFtYy0+dWFy
dF9kZWZhdWx0ID0gQVNQRUVEX0RFVl9VQVJUMTI7DQoNCg==

