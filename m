Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F6C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFQnQ-0003Ge-0b; Thu, 15 May 2025 01:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFQnN-0003Fy-Re; Thu, 15 May 2025 01:06:13 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFQnJ-0003oO-Dg; Thu, 15 May 2025 01:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVR08KGyj8rfg2YjcHmP0V11W8vE+v+voDfB3bcdMfE1A3SNdq97PaOv7RO/SOUoJOim23mCK4UTCSDSO4zbkwYvLTwSyYaYjHHENoKAJo2xUnfd+A6Tz58bzSrZZFqF/sandvgpud+xT4sQYPDT2mCiH0j2z5P2mIcv11/McdS9SIV8dLW6hz1mNyMbjHYrnzPe0lXtwihf3Bvvbtai6vM3oL5gbNn6j7gB8KA5JkuJ4vVKNkBCRZc1TvhojD4Id6MvAZD0IWhYUeI4C+6zQ0oQLdHq8IuZuSVCPecg++sYTJtAh9YTuIUMeMNSU5S/KqzHXuRWL5UbF9FaRkLCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7SuOeFPMZwsDBlzMluE91cHtWXdyc3neWrF70F1JK0=;
 b=Q3bHgTjfE4dna6E6bx36dcilEA8nUsKXn3EmBZ2jTXqBuoQLLOQuoTd7Lml/z10CoyOx2CLLbQ7/VHREiK0bK5ncoVev9R3/+zD0Owj796QlGJm304oKJRMBNMyQi+KJvx3qjoEfQX496DDCQ27Y9EMktiRfVrss6vYdUeUoKsW4Cnk/4T6O3tySfk1JfL83Ffk6B3kUWUUhw1haQXh+mXbI1hjTrVMelNlbJG5wkdyBFQBxPOa2SwrU4VlTX/b5l95493Y5Hay3QJBSaHmAaAXYZgo5vvMaMfhoMpiBP8AcxB26/kgD+50y/xGsBocW4YhAZeU75gNTzDVomn/XMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7SuOeFPMZwsDBlzMluE91cHtWXdyc3neWrF70F1JK0=;
 b=OWfzlnnsEw0eHiams2K4V15bH+A7sX6QGew4iyMOFhCOXN2kbUH1KnT4Zp1Fsr/RjB8s2ohgbGZEzsUwTOzL0tVSt0G9hgwyeKfQobbweVlBqAEesHp9Quf6XZGpwyCMExrVwPtYeOzB2Nhda4qD5pH02Jy3WMiy37lhk/eNLgJP5cvPbSvcVBQR1pSXFSlfOehxQZSbG908PF3+ei0Z9Dcs7c1KkM2zjj5WhI1D8sDNTWjDwNhtbplAlPSFUXhMKUCEHenqwX6DaNNDZElGC+eAbnMKe40Yj+UpMEMw5sDvjbD4qrZO+DjhfoI89ww2gkEsg7bCfl/0x8LOCK3gFg==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TY0PR06MB5609.apcprd06.prod.outlook.com
 (2603:1096:400:31e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 05:05:57 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 05:05:57 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region
 overlap with vbootrom
Thread-Topic: [PATCH v2 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region
 overlap with vbootrom
Thread-Index: AQHbxK8iOcEwevI8KECiwbp6ei27nrPSHpWAgADyNvA=
Date: Thu, 15 May 2025 05:05:57 +0000
Message-ID: <KL1PR0601MB4180A20D466DFAA909A8425F8590A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-3-steven_lee@aspeedtech.com>
 <395b5586-67f9-48db-9830-c4ace0b85e47@redhat.com>
In-Reply-To: <395b5586-67f9-48db-9830-c4ace0b85e47@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TY0PR06MB5609:EE_
x-ms-office365-filtering-correlation-id: 49d06135-cb7e-4722-3933-08dd936e2d37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OXd4WnpVdmxaUGpES2hTRzlWelhnQW5mTFh2WlVRRDBKMkUvbExuVGpPUkRm?=
 =?utf-8?B?ZXJZM3pYTEZ4T2ZKcDlGOXVOaWxmZEhLZlFoNzd6a2pvTURXcW5SK2ExalVP?=
 =?utf-8?B?OVZ1VHpRUDBhRXhKdUYra2hmYjB6TGVSN2RYVjI2TGJLRGFIazNvbjhkTmt1?=
 =?utf-8?B?V1VBZythWDFtRmNEU1pCV004WVFsc3FPZjhTM01rY2laVUJGc3A5VnZXeUxP?=
 =?utf-8?B?K2s3SjZQOWJXVDUzVVdrVi92cjVLZ3k0Vkk5SDd4QTVYdEl4djNBR2xyalpr?=
 =?utf-8?B?UngxV05oQkt3U3lMZWpmUU1YRDM5U1RmQXRNLzRCVXNUQlI0YkNCTkp6S0No?=
 =?utf-8?B?UzJ3SVFuYXI3N0JDQmV5Y002aThqeUtlZWpBa1hCVFZVaVpHYzZLdGZuODF6?=
 =?utf-8?B?djFFTHZocXFHV0FxbGRCR3lLZUUvMFN0SysyT2xsVHBMZVd4WEZvVWtDZVVl?=
 =?utf-8?B?RXJFVzVCc3R4VU4xWmdtczRCK054TGlxVmZFcjg0cGNzaGhiOFNrek1tT24v?=
 =?utf-8?B?U1NkQ3ZLOGFFVUg2TG1yOSt5cCtIREpBSUd6V0VVUDZhTkgzVU5wRC96V2NY?=
 =?utf-8?B?NkZKYmdSaENsY015RWphbnpPMWQ3WlkyNkloS2FnaFZvRE0vbGo1ckM5eHRO?=
 =?utf-8?B?R2pCQm9UZHpMOGkzRGN6MHUyTzZJSCtqRnIrZ3dIT0NCb0tndlJGdmJWKzJY?=
 =?utf-8?B?cjFQaGZVRVppcmtaMERjaGJYMHUvM3VnY252L21hM053RVBzR2gxSVZlOWNJ?=
 =?utf-8?B?dm94NWxzUnBWYTRUV1V6N255cFNxOWRucjZERTFtZXkrSUZVeER4bEpxYThs?=
 =?utf-8?B?WmUzRnRucnVWYXRoczBYamFiM2sxako5UVQvSjQ5OHE1K3BZb0NnbDZYd3pt?=
 =?utf-8?B?ZnJrOFRyTWYwbnVyTDdYVWJJdG93QzhINnVEeHZNRGVWMWd6TmwrZFpyWlZZ?=
 =?utf-8?B?Z1BiZmVWQk1rUjZVQzRRSnoyZ09VUVVYWUo4cWNwbzFaOWdEMUJBNWFpRy80?=
 =?utf-8?B?eWpzeERGOXN6bzZNQUVMN1RHckFSRmx3TjFMSkNkSER3Nkk3U09INmdlVzR6?=
 =?utf-8?B?dDEvZXFobk9HTWJVYUhLUnRXV1hkTnJRYWFiZ3VrdHFkTzBxWDhFVmVOb1l1?=
 =?utf-8?B?ZnJyNTRsbG5Vd2ZsSVdXRzdQOXdzbjM3Y2toRFppbXJXRXhtdStUZzFrdVhJ?=
 =?utf-8?B?Y3FQLytnRU0xdWd3YmQ5T3FhN2MzSUwzQlp0WStUMk1JNmFvZkk5RDBDWit3?=
 =?utf-8?B?UStnekRTZnRBVFV4UUNMbGZtKzhweXdYczFPMm9KYlhleDdCKzRya2NSb2h6?=
 =?utf-8?B?blVIK0RHMTFJOEFLeEkrK1RUZC9JZ1o2Q0NyRDNTSXVtOFE4aU4vVVhkV0FL?=
 =?utf-8?B?MWprSnE0cVZTdG1pRUlGM3pxN0sxMENPOVBmTVNFK2d3KzJqMXJHZXRrT2RQ?=
 =?utf-8?B?bTJ5c1NXbFRhOC8yR1JsRGdRaXZEa05VY1BJZVcxUW1xY0xYVTQ5bHFQMTl0?=
 =?utf-8?B?blgraTdGdmszZFpjK1VmUkN2Z3A1bkhuVDN4SlYvVHMxYVFpWmZ0aUhqcXkv?=
 =?utf-8?B?a1VxVE5VL2prSGlybitTNDIzRlhOcTJsZkNzZjBPSWlpWmV3a0JwZXkrcWRh?=
 =?utf-8?B?OWpwNTBpVlU4WU95Q3E3S2pHMzFDQmNTTU5DZFhlNUxyamZuU0tvL0MyMERt?=
 =?utf-8?B?NW1vdHdvM2VsRE1LWEx0TVRVa2F4Vm1jQ3V1Y2lIZ3U1L3pqMm9peFdJQlh5?=
 =?utf-8?B?NWdDMDZlZXpzK0EzdVVUOE9XMk9acTZnaTNTZktuanpLY0ZaMklTTTlMRDJO?=
 =?utf-8?B?ZG1tR3hOeDV0QWRrMDhhUGNQTEJvU05HdUU4c2t0NlloTkxNSFJUZC9uWEdT?=
 =?utf-8?B?VmJ4YWs4eWRYZ1pqSnloUVppTTdWWGVNekhOY1hWRktpakgzdmxSRmhGS0Ri?=
 =?utf-8?B?YnVjK2UrQk1qbzNJdjdjNTVscW53cG5NT0lvTGFtalVWZEwyei9iZ2puVzZt?=
 =?utf-8?B?aHZEbXlvREJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDQ3UkxiZWlpRmpmc2Y1WDNBZGdFMW0wYmhpbFJ0bWdGK0xNQUh4eGxoaGFx?=
 =?utf-8?B?L2N5cU84dU9nam95Y3ZMaUZpNVhzYUpMMEhGM1FNNWpIcEhqc0JBMkR0czJl?=
 =?utf-8?B?Kzh1S0F4RFpwcnFwNWRvRlpTZFo5VGxYUTRwYU11Y2wyYktoVnlpSCtIT1JX?=
 =?utf-8?B?VFgxaExJR043OW9Pc2dsWVhUdUZ1RG04cEdua1dXaTRqdE40Zkp3V1lFQklG?=
 =?utf-8?B?cTVFVm9oaU5JZjVUODFST1lUUi82a2xDcWhsa3lVSXNiam1xZ3ZCOHhhaVVa?=
 =?utf-8?B?U3RKYkpqeWc1N3lCVm1wVnVOSmFwanU0NWxtUmpVWDV5SjlSd1RqVkhySDIw?=
 =?utf-8?B?UTJaVWZOVU5VWTlrNkR5YWtkK2k3aHBnRjdNNEFENEVsZjlvTUNTWThCZjNh?=
 =?utf-8?B?Mm1LK0k5M1JjZCtOQ0xKZFhhSkY0QlBtRndES0hDZmlrT3pjQjk3NDdGVjMy?=
 =?utf-8?B?VEViTWRtMy9xNGtlczVDWU1ib240SHUva1Z2ZCtrSHVBVDJoNWZUYWdSdDRB?=
 =?utf-8?B?eVpaT0VjRTFlYU5penpiWW1XWHNEaFB5T1QyeVJhZ0NCM2JPSDBvS2dTdGUx?=
 =?utf-8?B?NTJyRldVQklpZ1RuNVVJNkNhZVA5VXJ4RkJhckhnL1FLUldiYkJ0ZWhpZThC?=
 =?utf-8?B?UXdkWHB6U0pLR01yRHVjYnM0dEk4YnBKQXZsSUJROVdpalJRaUY3MW5XZjNW?=
 =?utf-8?B?L25PRHNhVXIyN040ZWVRdUk3Z252VDZqRkFrd3gxa0M3bXBJemJrdGZveEUy?=
 =?utf-8?B?OEpIK251YWc3c2piWllQVUVQc1EvL2RRcUo4UzN3QTdxQ09jeFpLbEdhREw0?=
 =?utf-8?B?SzJQM3BVZjVGZDVNRmR2bHpHalJXZjhiOXJFRWpJZU9yZnMxRGhrTXF0Vzlx?=
 =?utf-8?B?MGpSNzdtZ3BGTzV1ZVNmWlhmVlpNbnRtNUY3ZGpMR1RoMkFKK3JMM3d2aGgx?=
 =?utf-8?B?VjNkN0s0bzFrYnpyU3lYSFdGM0VaR2JOZGJLVGFjcG5hSVhUNDVqMFJreTlV?=
 =?utf-8?B?bEd4d2QzT2Jkb29NUmlRMVFQQ251blhEcTNPS2NnOGlCdDgwRWM1NjFjcE5Q?=
 =?utf-8?B?amp1Q0NzdHV6M2ROblVmclVMT1ZHeGRMK0ZOMXgxeWd2TjJZVXVDdyttODJR?=
 =?utf-8?B?WW5lTjQ3V28zVnpYUzBmYUZ2TVoxLzhVWDVtUDZycGNXQnp0YVJIaE52L0pX?=
 =?utf-8?B?aHVtN2RpM1hNRHBKUTRxT3ByTkZiMlJjaXN2bzZ3L2hkVG0zSy9Hd0NoRTNO?=
 =?utf-8?B?c3pTUDJDbEFmK2plWExGMTJxUENYd0VQRzc1cndhRTdSZ214b2xBRWlTTjZv?=
 =?utf-8?B?cW8yMWJaMEtpbFc2NnVLaWR1cTVjb2pXMjIzdHRVOTBxL3VETU9OeVV5WWtE?=
 =?utf-8?B?Vmc4SkZwNGphQUJFbGlkQjlYM0dpcy9wcmhUS0V0QmdnVDE1aEorWFlNbDJI?=
 =?utf-8?B?UTFmMmd6S2t4MUVlcEdTTkh2RUNoZHB6dnFNMkh6ZkxQYXdwZkllY09CcEV5?=
 =?utf-8?B?Z3hhZU9sczN0QlVCNVBhUGdBZWlIY1V5UXY5Q1R2djliOHdoanlCdHZWM21v?=
 =?utf-8?B?Qjcrd2Zna1lmQ3BqR2h1U0Q3SERzc2pERmUxcXdhdldmMERZNVlaalhyWWRy?=
 =?utf-8?B?eGJjWXVaL1ZzOTZtNWJpVUdSQ1JkQkVHS0VmbXJUSmdBa252NVk5U1M4NGw4?=
 =?utf-8?B?eEFERzc3a1BXMHMxV1FLR3RVQmdCQVNvL01FaVBIL05mZ0lXTDZ5V3Z6VnNN?=
 =?utf-8?B?NlVJQlhZRkI4eGFMN2g5K3pENGMrS0UrcHdTaHc0L292OXJuMWVWVXhXL2tQ?=
 =?utf-8?B?YThpdUxTQTdoTER6NTdzZW03d01kOEtNTVI2bXZnTitpbGNyZGxiaWEvNVdC?=
 =?utf-8?B?eFlaVzdRQVovOFdnOFhqRW9QelM4VEY4bGJWaFhoQjBDc3dzU2NLVUN1ejND?=
 =?utf-8?B?bHU4WGhPNXIwOWdvVUxwZ0ZoVWFNaUdwM0lIWG5pdSsrVzQyUE1lTDJheFlh?=
 =?utf-8?B?VnFjWm5vZnl0aXZUaTN3bFpPRUhkU3RYb0xtSTI5cHUwYUxqU01sRjBrUjVm?=
 =?utf-8?B?MEdqVmxHUGIwdWVxcXRNeEI0SG92d1VkZTN0cFZ3VEhrOWRzejYrc0x6azlH?=
 =?utf-8?Q?cIQ/2A1Cfi+jUR7eX1CHhLInJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d06135-cb7e-4722-3933-08dd936e2d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:05:57.0524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psaOYnj8S1l4Fmz8L8DO8hmpSiBe48jYaIFBWUApyXnYhc/fB/EaXdkm4Me1S4TDTc6ZqkWt2iS2+cmwO4m2tx2AVunTleXMSP8O3g4G5/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5609
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=steven_lee@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE0
LCAyMDI1IDk6MjggUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNV0gaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwOiBGaXggdW5pbXBsZW1lbnRlZA0KPiByZWdpb24gb3ZlcmxhcCB3aXRoIHZib290
cm9tDQo+IA0KPiBPbiA1LzE0LzI1IDExOjAzLCBTdGV2ZW4gTGVlIHdyb3RlOg0KPiA+IFRoZSB1
bmltcGxlbWVudGVkIG1lbW9yeSByZWdpb24gb3ZlcmxhcHMgd2l0aCB0aGUgVkJvb3RST00gYWRk
cmVzcw0KPiA+IHJhbmdlLCBjYXVzaW5nIGluY29ycmVjdCBtZW1vcnkgbGF5b3V0IGFuZCBwb3Rl
bnRpYWwgYmVoYXZpb3IgaXNzdWVzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGp1c3RzIHRoZSBz
aXplIGFuZCBzdGFydCBhZGRyZXNzIG9mIHRoZSB1bmltcGxlbWVudGVkDQo+ID4gcmVnaW9uIHRv
IGF2b2lkIGNvbGxpc2lvbi4gVGhlIElPIG1lbW9yeSByZWdpb24gKEFTUEVFRF9ERVZfSU9NRU0p
IGlzDQo+ID4gbm93IG1vdmVkIHRvIDB4MjAwMDAgdG8gcmVzZXJ2ZSBzcGFjZSBmb3IgVkJvb3RS
T00gYXQgMHgwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RldmVuIExlZSA8c3RldmVuX2xl
ZUBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFlvdSBkaWRuJ3QgcmVwbHkgdG8gdGhlIHF1ZXN0aW9u
IEkgYXNrZWQgb24gdGhlIHYxIHNlcmllcy4NCj4gSG93IHVzZWZ1bCBpcyB0aGlzIEFTUEVFRF9E
RVZfSU9NRU0gcmVnaW9uID8NCj4gDQoNClNvcnJ5IGZvciBub3QgcmVwbHlpbmcgdG8geW91ciBx
dWVzdGlvbiBhYm91dCB0aGlzIHBhdGNoIGluIHRoZSB2MSBzZXJpZXMgZWFybGllci4NClNvbWVo
b3cgb3VyIG1haWwgc2VydmVyIG1pc3Rha2VubHkgZmxhZ2dlZCB0aGF0IHBhcnRpY3VsYXIgbWVz
c2FnZSBhcyBzcGFtLCBzbyBJIG1pc3NlZCBpdCBpbml0aWFsbHkuDQoNClJlZ2FyZGluZyB0aGUg
QVNQRUVEX0RFVl9JT01FTSByZWdpb24sIEkgY2hlY2tlZCB0aGUgZGF0YXNoZWV0LCBhbmQgeW91
J3JlIHJpZ2h0LCBubyBkZXZpY2VzIGFyZSBtYXBwaW5nIHJlZ2lzdGVycyBpbiB0aGlzIHdpbmRv
dy4NClNpbmNlIGl0J3MgdW51c2VkLCB0aGVyZSdzIG5vIG5lZWQgdG8gbWFwIGl0IGluIGFuIHVu
aW1wbGVtZW50ZWQgcmVnaW9uLiBJIHdpbGwgZHJvcCB0aGlzIHBhdGNoIGluIHYzIHBhdGNoIHNl
cmllcy4NCg0KUmVnYXJkcywNClN0ZXZlbg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMgfCA0ICsrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IDE5NzRhMjU3
NjYuLmJiNjFjMzBjZjQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMN
Cj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC0yMywxNCArMjMsMTQg
QEANCj4gPiAgICNpbmNsdWRlICJxb2JqZWN0L3FsaXN0LmgiDQo+ID4gICAjaW5jbHVkZSAicWVt
dS9sb2cuaCINCj4gPg0KPiA+IC0jZGVmaW5lIEFTVDI3MDBfU09DX0lPX1NJWkUgICAgICAgICAg
MHgwMTAwMDAwMA0KPiA+ICsjZGVmaW5lIEFTVDI3MDBfU09DX0lPX1NJWkUgICAgICAgICAgMHgw
MEZFMDAwMA0KPiA+ICAgI2RlZmluZSBBU1QyNzAwX1NPQ19JT01FTV9TSVpFICAgICAgIDB4MDEw
MDAwMDANCj4gPiAgICNkZWZpbmUgQVNUMjcwMF9TT0NfRFBNQ1VfU0laRSAgICAgICAweDAwMDQw
MDAwDQo+ID4gICAjZGVmaW5lIEFTVDI3MDBfU09DX0xUUElfU0laRSAgICAgICAgMHgwMTAwMDAw
MA0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1t
YXBbXSA9IHsNCj4gPiAtICAgIFtBU1BFRURfREVWX0lPTUVNXSAgICAgPSAgMHgwMDAwMDAwMCwN
Cj4gPiAgICAgICBbQVNQRUVEX0RFVl9WQk9PVFJPTV0gID0gIDB4MDAwMDAwMDAsDQo+ID4gKyAg
ICBbQVNQRUVEX0RFVl9JT01FTV0gICAgID0gIDB4MDAwMjAwMDAsDQo+ID4gICAgICAgW0FTUEVF
RF9ERVZfU1JBTV0gICAgICA9ICAweDEwMDAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0RQ
TUNVXSAgICAgPSAgMHgxMTAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9JT01FTTBdICAg
ID0gIDB4MTIwMDAwMDAsDQoNCg==

