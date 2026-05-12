Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91858CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgyt-0006vH-EC; Tue, 12 May 2026 02:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgym-0006nB-4r; Tue, 12 May 2026 02:52:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgyj-0006Ls-4P; Tue, 12 May 2026 02:52:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRmo/2sZo72Oo2A7lKhoctmGPvr2B5UH0TI5yJ+u5RbvI12wjnL5Yw+049Aba3yICHvwTCQc/iIz18Yk3pQvQuMJbBBisKu/LQzIy0EkJ5/WaO4GpyvizPafRBHJK5B52OgcbouBFpwNnYd8fZVbmnRja4NregKr36OKegK5GUnQ2NrPaILHrwlMFoEaDDkttkiow8pZmQGtE10mETWtv+V1RSDUO7HCkAbfo2Lif5K/dwOcYuDJVTQOYIFo9cmsVZkLAmp4C9JBGRKea4WCaMvB/8Ds2f13A/qRqnJlt27vgikRyuPMv4HAvEoqcQi/cmpG97Gs0E0OExkcnsxvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWK232r0q60axsRB3PdzBHHGwc0JGCwN2XHYFSacENE=;
 b=LWZkhE1fzePZHqASfuJkcTz+fwusUo6p3rBnhhcghykipyM+l1cOfuUBZCkbc55uSPu3cTI0VEkhAL3SdN4v14BJu/PChoolkFVLWGmyAHubXKTRkpsh22b9z2sMEWKjwOFEGJuv1Ckx6cJ4Zj+qIPy1kpEJbiMwqTsibOAzycLz0irrU8/lpllGb7duq87c52OHkYRbeQuR7+rwY48Nfh/RC68cAZcRia6d1c8dJs2y2hqahsxxU8KMVcnjChpm3HtIprz5nrqY9HsF2xKP3VCaslJ93/3fZfZfaB0rFY6Vq2NDsnuUjnqMjjYJaZwdaPcYA8JCKsXOHsk6xbKLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWK232r0q60axsRB3PdzBHHGwc0JGCwN2XHYFSacENE=;
 b=UUu0s2P3WZGGE+xV0/0JRTPTaXW8l81QluYukYXYgmk6Jh1r5R6D3JjlQUrRaqnSEvxfvc3assE3wXmBJWORGeYMVQKAC/qNwhhWQ2AQ1JtdU9vdWWURpMgTFOWsHYUZD+kLjhF7sWiYichgoACbhn9Al0DMZEGoQGWPFyNcxFmXhA/Kn1PS0fau600NOV0a+YwaPSkkBLNMeXpT5ZdwzbSOtrRSxXj+gz+d2p5Rt6E9vZIArU+D5QbvU9GakGK4OraWKLv26CrOhPgXC4XRcUHWcwyX5DPWNsn3bxuYxU7UJaFRj9xDA62/lM0+JQ3pkIaxQHiqR82TFn1tTF6iVw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6205.apcprd06.prod.outlook.com (2603:1096:101:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:52:23 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:52:23 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Topic: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnPl3aK51F7Y0aXhHDUgxk26LYIf7+AgAAZCKCAAV12AIAAA6Ng
Date: Tue, 12 May 2026 06:52:23 +0000
Message-ID: <SI6PR06MB7631741978A229F2B8965C5CF7392@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
 <20260508051619.3887383-2-kane_chen@aspeedtech.com>
 <341d0267-cb81-4612-99d1-c1edd5a395dd@kaod.org>
 <SI6PR06MB76319014B83F4B0E7F0FB756F7392@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <0a97a2ba-583c-4583-8aaa-ac9634683d11@kaod.org>
In-Reply-To: <0a97a2ba-583c-4583-8aaa-ac9634683d11@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6205:EE_
x-ms-office365-filtering-correlation-id: 292c6bd7-e0dd-444d-1eb1-08deaff3051b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9olQ92ciQcemeJWjwe/Qz7Udut4frj7vlsICPyJeYs+jCbqHVMpDv4UG8FXu7UNWEB5xwX5T1mPt7HqveP3bBGgbencjjeL+PGVwpVWa6z+1m59EXiFolcpLmYmNlNrvElk5BCrNJXVbc3821iHmsHmaXeCJ/+uXA+sLS93PEHA1S87xb5BSZhHG439zOsjeEfrIRn4gjbKg4leVH/UvbijfvU95WzlSv9qEMoN70IAul9amcAJr7pfm7wQHBkpIDKV3vFs/rR2DDl9JsBLP56HsDyiIFoOQQzOQtnsflOnhCM4ab9jKTiD9n3latMnKtmYLdjXg9cMHyV1dbJBFH3VV7UpQDtyjnCoXTMkyY7RfcgIgHavbTDD7g08GHZn6maCIYbklzDHj8MeXRg4wCMJ6dMYNMvLQ/6wQml0fMXDZJJ+GPxu+ENrdFOVSJMPfudQu//JJVQJCtmP+U9L2eZbxFzYuOMB9ICTW3g1ZGkmHFv0iGUr7xVpr/WczwRJVmk60ZDaYj4JEtm2Yz9dezHpO8EiYrzXA2R+myWCFYEdU4rq10Ijb8pRWFveQ3OsoCdNV3ZKbkLa3rSb93iaWvAgg7e0fwiEJpzDi8WCy4NMp9Fc4kLbrjEcTdx7U1R/99YW4IgGM0COeUtKMVFBDcsgQp0n1gfaAI6TE0lbnfeDEHgADBkLE6rNdranevv0qqARhpBKjjFipSrMFsg7Ac8CuUQ4TrtSfq1NrfTe2AJWNrr6/OAmhpBD1jY8MttW2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RC9sSjZid3JJZlhJaSs5Q1lEMzcrRlFPVldjQlk0cmVLYUw0TVYraFVvUnFu?=
 =?utf-8?B?dStXM1lldlhBZGYwNGtBazg5WTlsdlpjRDZ4RldnaUJ6WWJQNW1TYXI3aGV3?=
 =?utf-8?B?anMxVHRDdkFsM3N4c1hjNEpQaEN3ZkhLcXBGY25ueERCeENsbXdac0VVSkF1?=
 =?utf-8?B?UkZkMFlUaUN4Ymo0anlLUzZkQjBUdDRYSGhnZXpuOHpIOXpnejVpZjVsOTZJ?=
 =?utf-8?B?bFBvUk9YaHdmaVNNVDBJb2dYQ3pkVjUzU04ydmlnQkhEblc2S0tBMlZ2c3lm?=
 =?utf-8?B?THA5SjdIY01BYm90M0xqNC9vQkc1cndxVHZzQ0ZOL09BMWNXTUlad0tMaGVz?=
 =?utf-8?B?T2dzdWp0Uk5QNUVpaFdMMlA5TnlSZ3p1cEU1K2cxOGhmem1MWjJQWGF0QmtP?=
 =?utf-8?B?OVBaVUYxMUpsY3RnenJHS2UrdGIrSW9rTzFKUXFBcGc1V1VHU0xOb0xIazgx?=
 =?utf-8?B?SSs5aWlVd0hpQmJwczczcHhIVWE4U1FUei9yOUJrMHcxWFFldWJXaUozVVJG?=
 =?utf-8?B?bko3Vmk4d3J0bmFXNFM3SDd3RTFqVTdoSkNBdFV3Ukh3ejFwTm40VHY3L1VT?=
 =?utf-8?B?allHZTc1SEtBMVd2QWhiUUw3Q1p1QWxDVi9mWjJya2syNGJLWmNDUWJmbnFH?=
 =?utf-8?B?NCtKeHJ4ZWM2Wi9VOUwzN1JZMUFqZ3pRQ2FScTN0b3lBakFWVW8zY1hjN3Q1?=
 =?utf-8?B?cFMxS1hJa1hzM0J0ei9GVWdKVVczZUJMMUxQdDR6cUhGWmt0UXQweHZXTXph?=
 =?utf-8?B?NWwwdEh6QXduTVM1Q21pcWV0ZVdEOGc4bXJJWWQ0YkNPUytFZCtrQmxJcUVC?=
 =?utf-8?B?cTg2cXZLVU5XL0NxSGFoVGxlN1pnSktiL1ZLZEZvZjh0K1JPcWVIaThxNWZ6?=
 =?utf-8?B?bmU0MU80N0hzSlpuSFZpMVU1cVpPTWY4Y3NWWE5GSTZxcG55L0xhVFJBS3NX?=
 =?utf-8?B?TDN1dEROSUs2Rnh5QzZPN3NTZ2pVald2NXZuQ3ZodkluNktrMUdaajBNTzVV?=
 =?utf-8?B?bXdnWUorVzQzUndtdlVWNWlzMU03eHlJZFZPSENOTDh2d0szcFdNc2kvaTVz?=
 =?utf-8?B?SWV2T0wxUGFBS3VDakhrRWVSV1BiMnFEaTJpN1pzY1FzYW5heW15eFJxMCtO?=
 =?utf-8?B?YzdIeWpZdEs2SW1CMUNKckYzZDZQZlBIZjZxdjFmVzFMUXYvQ3ppaENSV2J3?=
 =?utf-8?B?d3AxODFVMDhsUlNSQ0IwUVllay8vd2gxUHNHZDFPbDN3aS9YakJWMlovT1JO?=
 =?utf-8?B?ZXpkUGRsZjNBck15SmtCaTY4alEvRnl0T0tSS1R3NCtpRnNEOXNsRDJqZnhV?=
 =?utf-8?B?cVJiQmgrSXVScTc1WDkxYmsvdERoMk43MTVYSXBOV2Y1VlVpZFM0UWV3TzZF?=
 =?utf-8?B?eHpqOXBrWk9XYS9ndmh6Q0xvcTUyOFI4UldvU0FrNjQ3ZUpSZUJPZ3BtbXVP?=
 =?utf-8?B?L0lITytXZVFNSkNBS0REODRVeW1HMnFlSURHeGNTM3ZscGF6S2dJK0FWeG5B?=
 =?utf-8?B?cnYyUTRGQkdubmF4MXZ3M1k3bG1ya0ViMlFSMjhKNHorbXNxYTFpVm9zRWMx?=
 =?utf-8?B?YzVPdW9tOTQybEEvdHV5UUNydE5TWTJFMFlkWWlJQVIzVmhPb2c1NkNkV0Jl?=
 =?utf-8?B?Q2MrOTdOZUhCREdvWFNTVkthMnNQdlNpWGplSHFJTkNGN0o5ejVMQUhwbGlY?=
 =?utf-8?B?UjkzMkRERzkybzJDdGNVZGt0MEh6QXZRcFVZK1ZYb0VYUHlMeEt2QWNzZTFR?=
 =?utf-8?B?bWNvbUc0TEJRb1RoNmk4Y3pOd0M1SjA1SjRwRUFnQXZvaUtNRC9rV0ZLZ2Yv?=
 =?utf-8?B?UmVTZGpXelh1UHhJN1dnZXhCdUxsalZYVUh6d1BxTzcrK1htVlIzTDgvYTI0?=
 =?utf-8?B?T1JkMTdTRjZSWndhNklsaGJUYzBLNHhZNHM5c1lId05YSTRvOE1GWmZBbE5Z?=
 =?utf-8?B?K0hkNmxYRkZpejdGM1FyS3RmVXdBVHVsNmEwWnNXRVNuVEtOME1PdGg3cUo5?=
 =?utf-8?B?ams0cnJhTkpVa3JvQ2poVnE4QW50ZEo2M0duTEE3YVhtcUU2NHBUZHZDVWoz?=
 =?utf-8?B?cmw1ZGFML1kvaGdOQ3RlemZXdndkd1NJRjdvL1YwUjlmQjNNeTVERUxIRlQ4?=
 =?utf-8?B?MkdESmNLRWJBQ213UlFYYnYzeUtPaVk5Q2doNTVObGxOZTZJODdOYzVUR1Mw?=
 =?utf-8?B?aGRrZXZMbFZxZjl0VFVlbVkyaTFNY0VOWDQ2a0g4SUJWZmtTMUxhYkU4L2Rl?=
 =?utf-8?B?QnB1SlVaZlJpOXo3MXhnUFlFUGIyTVUrb1Z3MmV0M2t6OXp3R3RodXp1SGVT?=
 =?utf-8?B?YjF4Q2xSSTljZ0lTTmE5Y0Z4NE16K2JKYVRqeTN0VHNTQ3BmekgzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UNRg8mh9KwQishXuIileN3TC0ofwXiexozdiEWAEqys0eeQbZ3yotFl+YqVkqJoaLsM+pMcGcC0lOxgscoJjjsZgiGmo2hJBZfbbWceFjcPD7cs/0bPmYsNu7a8vMjCM2vc7Kep3FGohu4PkVxCKeYpLn/Br+yh6xEO4Wn2ARDXm2i821bZOj3GET2EB8bPgjh6Vcti+vxwY57VM9noWpfYKHLwrMMHiMuMa+p05ZfIcxQl0fu/LoPl2v8sNeOEWRSBKzewgs3AGMH2zU0UgDcH6nygKTAO8P0KiMM/hN3/FkaR3Z7JYKjhXsW1ynslv2ujpiRfDILigEozhWb8Nkw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292c6bd7-e0dd-444d-1eb1-08deaff3051b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:52:23.0596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCHQcfbRtp7TU7KJyQ9ocjefu7Ut2OfUIHeky+//VNmqkhNoMKWFRlNBxA3nFtxBEv8p7e10RftSooAUE5U5O3A7waGkDBt3DHu2q5MUpv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6205
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTIsIDIwMjYgMjozNyBQTQ0KPiBU
bzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVl
ZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVj
b25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4g
bGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0
Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8
dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBh
c3BlZWQvaGFjZTogRml4IG1hcHBlZCBhZGRyZXNzIG1heSBub3QgYmUNCj4gdW5tYXBwZWQgaXNz
dWUNCj4gDQo+IEhpIEthbmUsDQo+IA0KPiA+IEhpIEPDqWRyaWMsDQo+ID4NCj4gPiBUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3IGFuZCBjb21tZW50cy4NCj4gPiBTaG91bGQgSSBzdWJtaXQgYSB2MiBw
YXRjaCB0byBpbmNvcnBvcmF0ZSB0aGUgcmVxdWVzdGVkIGNoYW5nZXMgdG8gdGhlDQo+IGNvbW1p
dCBsb2c/DQo+IA0KPiBZZXMgcGxlYXNlIGFuZCBhZGQgSmFtaW4ncyBSYiB0b28uDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBDLg0KDQpIaSBDw6lkcmljLA0KDQpUaGUgdjIgcGF0Y2ggaGFzIGJlZW4g
c2VudCwgYW5kIEphbWluJ3MgUmV2aWV3ZWQtYnkgdGFnIGhhcyBhbHNvIGJlZW4gYWRkZWQuDQoN
ClBsZWFzZSBoZWxwIHJldmlldyBpdC4gVGhhbmsgeW91Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5l
DQo=

