Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D28C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3oq6-0007x1-TU; Tue, 08 Sep 2026 01:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3oq4-0007wm-Gy; Tue, 08 Sep 2026 01:57:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3oq1-0007TE-Sf; Tue, 08 Sep 2026 01:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ2PzBwKnZbznVDyP3Ms0s2giY916IH5VcyPg0kH4Mumc+lQhVc2MdGSEx13mJo/A3Ox3tmSHgvPqcdeBt7OKm0JI+XCxVZ0RhnHXJ1vGOnP+07MMHcTcx5S+11JLfdjOQGQbgN7sehu5ORiUcziROVricSgSTW4840wYPotTUnmiWEc5q7FOoDbF0lKZAozkndEkVl1JWHA5qWqycSdZ5Lzy5vsmkhxUv39mCtextny+OPNCB63O5K6ttHQIEurnoUtijVAitj/KUis/ION/M3AJSvlGiLQjMPqrRqQCbOdloL2RpdE/qQzFCpwZ0gekt9j2t8jlaQBsCI2QE926A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sunJlL8GQTDoUfwrL8fvkp4J/BIUOV+Ip3+8X3jbD3U=;
 b=LjVStAJjtN7joc0KAPEBtFKnN1so640X1WNjOxkuJXd/sDC3lcXVs4tSwm/RfKjoFGdGbQBZoeZS3w1xmM5ybF+jdbqoCynorayw3esaCJFE4OQllxBnuH0lALJYM4/41OBSPjwJ/Vb7c3MWzXhnszKODJDEd9FK9ybytVJfPwieT0HNYYGGriWP89TuRZYMvcjS/Znph7JUoPSFyS8ZLQjS2+M4N/eNx5JGOF8Cgb2kMDWRGn2omGaRczglT103OCZGICFCKeQygk+pwMMbUIPLBoYbwfFqkTGJd7amIx3Wo0zvkdQsjQ0i+tvhHhQPGpNKuRvocgBmKreF+PqW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sunJlL8GQTDoUfwrL8fvkp4J/BIUOV+Ip3+8X3jbD3U=;
 b=d1xVD9UZPVAGaxcWC6PeYBbT0bLrpgrameiyJcTsC3/KonKJiXIb5kJ3ydpvTBFPk4afK8TL86Bb0KXIKQtdskgtbHZn+dYwIG/mHENL9tyjbWlEGdATb812yPn4kBVIVH4NpWbsCOE60tIPvywZzFwZSk2HS3FTc05F5vLEj+zLzzh9V/oiJHZDFLaAe3Oxw4JV0g9V8LLqhSXFlBWoM8wUIkY6/iYMpHjyeo9ME8QmzO/iqZf4yZ4f5Bl8ppDzbniLn1Ym98mFU98a9fd0nxt+w1lFmx0NyiBqpjE0QyMbdV7q+QcelM9B8kuNkkR4U1cokDwzu6Li+l6FmdBpPg==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by KL1PR06MB6792.apcprd06.prod.outlook.com (2603:1096:820:ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 05:57:37 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 05:57:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Christopher Boker <Chris@cveasyai.com>
Subject: RE: [PATCH] hw/misc/aspeed_hace: Fix OOB read in has_padding()
Thread-Topic: [PATCH] hw/misc/aspeed_hace: Fix OOB read in has_padding()
Thread-Index: AQHdP1NHYIjCV+pLD0ugMtg7GO2+GrbEKzOg
Date: Tue, 8 Sep 2026 05:57:36 +0000
Message-ID: <SEYPR06MB498957FCA39E8798E2098A1BFCB12@SEYPR06MB4989.apcprd06.prod.outlook.com>
References: <20260908053101.1149625-1-clg@redhat.com>
In-Reply-To: <20260908053101.1149625-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|KL1PR06MB6792:EE_
x-ms-office365-filtering-correlation-id: 2bcfb67f-cff2-4841-3013-08df0d6e15a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: Pn/Z3qJO4+p3NzasdJhFWTVR8wh2SqlInHEKHmbBe5A0tJVM9bh4nMM/cBnx2GuU8On+t/vo56ab4nLUyom9dqmHJHsg6m5QWvEHrUi4w+eL+8FgOI7bP3eZ2Ojb2C7ZqMX2xUIl5H3sbaot5gKawumOzVRsD10R+uYxqrvvA+lwGkk2UZKcpLbK+92ufhzuZBHFINz8prkLc0pSkruBY8gJAZy0eeQXuhDwAXrhuHBmgwoQysKcZx6EaxdMf4NwLRpsCBjiHH9IyiWeAqVntbuNPsI/Fli6FUNPmde3SStsgX5ZSGIaIx0CuK+kokJ0UEHgfgjctTdZHqb4lFcQA+fXVVCxH+7KovIzQGYMTjIEH940QW3nXpImcvllLe77OAe9ZeGao/Y9sc4xyWhNC587QurU7F4WUYh9EZYkzBaseMBcTLlw+VNCCNhx9qeXNhLJ/AEoaDZmsg1tAO9VjKgS4UItkxIGQuf5c1xcByfCJDPCi4wHFQH3+bz38GypdHLeQump9TsJ9ZkSaMS7mbzVnaVV28O9MpdJ5ubTgqhaeAGe0Zwg44jJcYvdTnEIiEq4glpwW/ycz564W3g3Js2MudhK6zKd25aVUykc2NuOPi39mE/rTbsaz7PikwT77jx68+3kiv4Jn1h4KoBVDFlt/E2cn+TlVRfveP5j4OdSnpx4ZzUIRfevPkFV6iHywsdo67qtCzSILDzYi14uQzVZ8Rk1I1WQCMnr5j+tgPE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFRMytCR0ZFUUN4WFZlNUVhbFdMbnl0aytWL3ozdHRqYVVmN3dhL1FuYTd4?=
 =?utf-8?B?bzlGTGF4STZzNjhUQ1o1clNiMUI1dWsrUFZISEZIL3lSaHl5cUZkTTdUeUVv?=
 =?utf-8?B?QWU2MStGM0kxRjg3bHppNHpTWTlYQXdpVENrSHJ3dytZWmdOOXM5ckxKVlJy?=
 =?utf-8?B?cDBSWFNkSjc5VTFSRlBBM2orK21QdWZHTmY1S2JMMjlUMjJSS3ZVMnZVcW1G?=
 =?utf-8?B?Q0VsWlJTbVB6Y1J0enJGK2I2N3FBOGp6MnJRZWJYMGc4QzEzZGRoMkIwRG56?=
 =?utf-8?B?VVJjNTlTbTB5Nlp0UWtMTWFQdVpaOGYxWmJ6UnpXS3p5WVNKemdENm1rUTZx?=
 =?utf-8?B?a0psRjhkUCtPY2ZkbmZWMitEaG1pSnN5TXZ5TXdiZXByRVNIdDh6ajFwK0Zw?=
 =?utf-8?B?QW16eTc4eUo1dVRDd29RN1BkeDJJaGhpemdtUFp5M25FNWZLeFV3Mm5maWhL?=
 =?utf-8?B?eFJTK28zN2k2MG00R3ltRVV6a05sbzBneXp1amxONjNMR25IZFQrNDlKYVBw?=
 =?utf-8?B?NDJNSjVhWkpvaGN3WmxDaTlTaHNWRWxuMzBZVzY2TzdsblVJZnEyNUs0LzVR?=
 =?utf-8?B?R3FUUHRBczIrZ3FMV1NXTzYrNVVtWThpcEhGMmJhUm1wWTFTV3BkRnlyN2RT?=
 =?utf-8?B?dm92SXdtUll5WmxtMUd0QUpObEFLeW9VL3RVUUs3M25YVjhsM09TMU9qYUhz?=
 =?utf-8?B?a0g5M3pWbHEzS0dldWxMMDFXMEpsOGpoQzVpSzZtT1BXV3l1M1FvM2ZkaUJ3?=
 =?utf-8?B?bWh6QkRoZ002ZFB4NW5Ka3ZNRnpJWFduS3hiVW9wSU53MFp5THdEOFpLcEQr?=
 =?utf-8?B?WjVNYlBSclhuY211dG4waEdXdzNZdjlzLzB5NGVUcGhGRUxKallGeGYyM1Vq?=
 =?utf-8?B?YURyb3Z6SU9YaWpCZHBmbFBlUjB1ZGFBaXVIU2xiZjRaeWQvOEtlNmh1d1hj?=
 =?utf-8?B?bnhMTWg0SFozL0RSb0daNGFya09PUTZoT2lzbFdGbm5Fako3VW9pd043U2Zp?=
 =?utf-8?B?cnJFNE5ZTjgvUi9sMnhQbUdTQVNVR0o5Zkk0d0dOd3k1NzJadm11QU5yZjQr?=
 =?utf-8?B?U1Rkc0R6RXhRM3JOOEd0TnE1NXlLMmlGN0xhVjNGQjZiamVPZ1BEQUwrR2l0?=
 =?utf-8?B?aXJvcTB0dE02SVFyMDdCTGNEcFBkbUhHL3ZWeldJYTh6LzljTGRnZjRKR09T?=
 =?utf-8?B?Zm85a3RZcXFlWXRkdjd0eHBWVzNIWmhSNGgyY2lJQVNVRWorM1o4d3BXV1cx?=
 =?utf-8?B?MDRmb3M0SVdVdHlJSjRLMVBhYXY4UG9ZbFVGdU53elh6SlE0VktqOGNvMStj?=
 =?utf-8?B?RjZpL3pKMGppU3dnVDVZanFSdDVyRjlzWmJCL0YzR051dWJWRkt5RWMvaWp2?=
 =?utf-8?B?enZ4OE5GbE1zcmtlREEwbnFxZm1UUzhRLzBMZzFqVG5kYmZOdTZmeGhvMXYw?=
 =?utf-8?B?V0JXNFV3MURJUlYvQVpIOVBLSHBEOVNYbG5sOUh3QXdNQktVcWR6dEw3b3J6?=
 =?utf-8?B?ajFHSWx2NWtEQ0dlSXFWeWVlRW0wbWRRcnBvQ28zeTF5OXFaSS9OSjYxUEkx?=
 =?utf-8?B?VXFaY1g0VmM0dVZtOVU4MEtiLzdWcGVZSisyWEhzWThJRnVJMlNCK0w0aWxt?=
 =?utf-8?B?RGExYmdPVGR2Q2lsOUpuSURQa2QwSFd1Ky9NK0doUmFPS2lRVmFaOEp6R2Uz?=
 =?utf-8?B?Q3JqbnFWQ0NVQSt2b2lpR1A0OWNkQk04RWR0TTFYL1M0Y0VIVCt0MTgveXpJ?=
 =?utf-8?B?dDlqZVo2UHVEYVN6YkVPWm9HbTBLSmc2Z3J4ZUluWWlsSnRLQUpIN1BVSGhj?=
 =?utf-8?B?ZGxxMHdMdWhSVy80QUJwSWRWaGhiN3ZzM09hSWoyTkFRdHdrSm00eU9pY0hl?=
 =?utf-8?B?VnIrTkVtbkhJd0taSHkzZTJqdGRoUTdQVFVzdXJaN1JuMHlHM1Fvckd1dHZl?=
 =?utf-8?B?TG10dllxeHpNcE1lK2JDdHJJbFFHcEgwc1RBQ3lsMWR0ZGM2VDNycitoODhY?=
 =?utf-8?B?QkdiS0t1NzR1eGZQbjQ3SUVhVnRBMWVBMzBmcVVrWVhGYzdya1ZjNHF4bVhm?=
 =?utf-8?B?ZkhTWStCdmRYQlBOUDB6cFU1ZkFDZ29UTTlNS3ZWZFBFTDhqNjZsTCszc1BL?=
 =?utf-8?B?TDRQNjJnbXpCVVVpeHZuMkJhKzVqaFRQbDBxRzlXQW9meW1acFBFZmpTa1lG?=
 =?utf-8?B?YUxweWtpeUpqQm9FMCtOSDVXQWFmYVJFRUJpN1p0bFgvUnRobmRVb1BnVjVa?=
 =?utf-8?B?bjlqb1lRc0g3VXU4WTY1VmFWMDhqMmpTWDA5eEd6dkxlS0doOWNjZUJHMUgr?=
 =?utf-8?B?eGNJdkJyOVBsdEZBRHpLOUYrK1IySEpPbTB1VmRRYjZOU3RyTy9adz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TOTRp/VQqUoCGjC5OJwE+oXnOuRN6fG6cvnZJ+bO+xnL+mZdoWFyRDVPVhDrRKv7QeZySH6zlnxqRGijuM6UvSYGZLQ+bBh8hzYDJzRGnkwpNlYoJSHceossMrepEOkLQB6GbRkd+i//4lUENj4aZIXL5fQ6gcR1SeceQfdH4EKs1QR/LcW0QLKtYMafb6Lk5KgHmkQkmKIpBQSXdebVA9AjNhfHbaboKU4yd1Ndfd1t/q06qOP5vbFO3kZKAKV8N+W4UzyG/1cxE1DJF6THDZZacOVhxL39uFTSUhhGoQe+Fyqv7kLkBngp2nF0oey3eTWmCIMqwKs7IqPyw3bOdw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcfb67f-cff2-4841-3013-08df0d6e15a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 05:57:36.9979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUIinb72PIjttPLOs7g4Y2tz3QzcQAmnlrPvNS/uKu9k6t6NNvBOOv2UyD0gS1HeYA+fxWERG+cFXrugmZqT0whcw89V6vtX9xBTjXz2MZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6792
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGh3L21pc2MvYXNwZWVkX2hhY2U6IEZpeCBPT0IgcmVhZCBpbiBo
YXNfcGFkZGluZygpDQo+IA0KPiBXaGVuIHRvdGFsX21zZ19sZW4gZXF1YWxzIHRvdGFsX3JlcV9s
ZW4sIHBhZGRpbmdfc2l6ZSBpcyAwLCBtYWtpbmcNCj4gcGFkX29mZnNldCBlcXVhbCB0byByZXFf
bGVuLiBUaGUgc3Vic2VxdWVudCBwYWRkaW5nW3BhZF9vZmZzZXRdIHJlYWQNCj4gYWNjZXNzZXMg
b25lIGJ5dGUgcGFzdCB0aGUgYnVmZmVyLiBSZXR1cm4gZmFsc2UgZWFybHkgd2hlbiBwYWRkaW5n
X3NpemUgaXMgemVyby4NCj4gDQo+IEZpeGVzOiA1Y2Q3ZDg1NjRhOGIgKCJhc3BlZWQvaGFjZTog
U3VwcG9ydCBBU1QyNjAwIEhBQ0UiKQ0KPiBSZXBvcnRlZC1ieTogQ2hyaXN0b3BoZXIgQm9rZXIg
PENocmlzQGN2ZWFzeWFpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L21pc2MvYXNwZWVkX2hhY2UuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBiL2h3L21pc2MvYXNwZWVkX2hhY2Uu
YyBpbmRleA0KPiA4ZGUwNWE5ZDk4YjMuLmJmOGFmNzEwMzM1ZCAxMDA2NDQNCj4gLS0tIGEvaHcv
bWlzYy9hc3BlZWRfaGFjZS5jDQo+ICsrKyBiL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiBAQCAt
MjI1LDcgKzIyNSw3IEBAIHN0YXRpYyBib29sIGhhc19wYWRkaW5nKEFzcGVlZEhBQ0VTdGF0ZSAq
cywgc3RydWN0DQo+IGlvdmVjICppb3YsDQo+ICAgICAgICAgIHVpbnQzMl90IHBhZGRpbmdfc2l6
ZSA9IHMtPnRvdGFsX3JlcV9sZW4gLSAqdG90YWxfbXNnX2xlbjsNCj4gICAgICAgICAgdWludDhf
dCAqcGFkZGluZyA9IGlvdi0+aW92X2Jhc2U7DQo+IA0KPiAtICAgICAgICBpZiAocGFkZGluZ19z
aXplID4gcmVxX2xlbikgew0KPiArICAgICAgICBpZiAocGFkZGluZ19zaXplID09IDAgfHwgcGFk
ZGluZ19zaXplID4gcmVxX2xlbikgew0KPiAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAg
ICAgICAgICB9DQo+IA0KPiAtLQ0KPiAyLjU1LjANCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpUaGFua3MsDQpKYW1pbg0KDQo=

