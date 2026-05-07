Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00402CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoOo-0005ty-5m; Wed, 06 May 2026 22:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wKoOl-0005tk-Pa; Wed, 06 May 2026 22:23:35 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wKoOj-0007WB-9q; Wed, 06 May 2026 22:23:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrueApcX48t5mFPsncSEWVGnQA4I/+rafufedBjE3rcDGIRhIekh1U6QzAgFW6DMSIgfDaJSleOLK5k27XESbz7sJD9GISf363xL+xdBWCUCQu0zgjdAzNsHxHC1Vxrlpz0EvcABiYdBOUrePAGOHyc3MWwu2affz341qIL/CqAZVigWuMBo+2jgzJdh1lWEvxYl04mO3D4tJjvXnlxJHu8L9Kfc8VP1U2214QQlWB2hZK6zUSTjjg8ZuVopAd0nBEj2kYae8nzsIOTlvBmWM9RTupph2Vim3DUQfeko4JEfDIHOFWw5ziAzlC3lhdXemcPtI3Sj/LPTbQcJuzcfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoLouexlEYi71RVoChZhvPBwsTgq7YOjmaGiPN0ICO8=;
 b=gR2Qizkuw24/ztNjYyo7aiV+mE+L9RrTfUpDdRaAeIE2HaCahVasDCIeES/R73gsoe2DqCvtTz63IiOT9J/ymAGcqUQDcAa9Sj+TLhY89v/9buEd9wabbCT01sxIow2gVXlfkGE01mjll4bKVfVBu8ZtlESA4uw9k4gfkMPYFwM3SSlY502aZFe5GOoda+b3gY4+6lkpdhnNkxTksfY+UwwjCgoNVkMOH5OA0jFlwoWdaxZNxbreQ7im5ZfEkzxMROmsFGWhd2IAWOQYshMhIQWb2otmLxa2wndL6KdHALVDMw0CpPC3emE9bW5tDHXpOCCmiOW4nrGWYdqq8/Bf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoLouexlEYi71RVoChZhvPBwsTgq7YOjmaGiPN0ICO8=;
 b=bMMmjUPK/shPQuFUNZzUOxOCIvipXYsMbgUFKCmvoRBJHOoUu3vD6C3LzbjjePQSNb/DihCw++kx7JQ1ha3L7KHDYDCasvDK1cvQJy2d5SLzJPWtH0dOSYueI+aO/F6LdAYgH0iUzYJ/3eAI+igtwhvYTJks3kSrSn7az/bxHBYdDMmqcfCP4qr9OLLwVoDtjXUB/kxyNitYhWEEAe9E0R0PR5f6rqspVG/KIWHzS7mNDLPTLdjwKr0VT1gIeOW7973EzcHQHjiypjG2U6sxJbZJ1BhY0hjCHup8iNZixDtG6enpb04t6huh670Gxf//9yXj+hkBRGGEJDKlLfSkvA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SI3PR06MB8682.apcprd06.prod.outlook.com (2603:1096:4:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 02:23:25 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 02:23:25 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: RE: [PATCH 0/2] aspeed/hace: security fixes
Thread-Topic: [PATCH 0/2] aspeed/hace: security fixes
Thread-Index: AQHc3A3Oh7FlffJCMkWZCI7fMOfVtrYAmp0ggABUzoCAAOA8wA==
Date: Thu, 7 May 2026 02:23:25 +0000
Message-ID: <SI6PR06MB76310110CED0DA90BA04A784F73C2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260504213421.710035-1-clg@redhat.com>
 <SI6PR06MB7631B46DF67C1532B154FFE1F73F2@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <7d05a03d-9f29-4b7c-90ce-b61d23e5d07e@redhat.com>
In-Reply-To: <7d05a03d-9f29-4b7c-90ce-b61d23e5d07e@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SI3PR06MB8682:EE_
x-ms-office365-filtering-correlation-id: c67b1afe-55e0-4745-9353-08deabdf9e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: l8PgOFWoo7uAJ2jwU+FWB/1WNknebqWxcSIWijTdbl/E6YmS40894KbF1l+DSliqfayi61IEoLJfzwpsO5v0FTYhXCNSrULAmbNQoW7kt/5rNwADOBBb5Ze8PqEnaUqZA5LUPwOUEb3hKGqX9wMBmYNiEtU+NIdVuDfVgRMIsML1QPrvpW0mPUNiEPrqprBGT4H0Z3+gyT6xdqxiBkqlg70UJQWARm30LC299KS5/mCQn6k8Ngpp6azA3bfsGOb2SE0VCKtcXBwwmnS2QFXo4Bhw/zNG9okvzOj7ZDMkS0r//iivVoWxykmBSC8Lg4vKaNjXOw3KI4ECo1CoKdpFsqYCMD180VJykwF3rODOxSA13l1GDUjMZDbpt8QubMs1WZaqdcCEuBufKIRNN2NXvj6TAuYhPCiX+XO2o6bYDYNiLbgOY018hSoAHTk953Y2sz3n0QU1zN68GEEk8bq6MI3U7DPE9gjqjCt9JeXHAx64IOMFRTQ60EqumE57z5q5sPA2Z0OKMvKjSVf1aQ+DOQc6myLVl7eGmNnJHOx3j4ocoWZYkBoaN/FhsBivbbelEIt3gRTCgxAWVG/l5bx71djw2WeffU3w9T5F2+XRAW6hRaL57VLD/s8aVtkAfxVDJmhc0LR9XVnSG197Z0xY46/tiAvFizLB0Ve1bjCrkLuGs/8+gKwQDiqyOM1cqrdfdqnGaYz/wAvjviuML6c15nbMiyOPcg0PAUJf03IJU34+/pKxz+xKrNtdTY0AoXdh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGJwbFo1WHVNaXROZUhwak9jMk1jNkptWUxUcWhDVmZOVTJ3VVZyaUk3YSt1?=
 =?utf-8?B?b25HQUhucVVvaTc4RmxwNVdMMjRYWGhpVVRVQTZ6MXZsU21NWHdrYVk4TXRp?=
 =?utf-8?B?ckpDeVN2ZGVHcTBBVFREaWFvNUpXN0oyQUxYWHlwbVFLRVZObkYxR0hHMXRu?=
 =?utf-8?B?YVRyemdtSnZnbkFNUnNmem94WUR3cS8rMXh2ckJhcTlBS3pFMGJGcTNOWGV5?=
 =?utf-8?B?Vzh4dkpHMVYwZXNKajRFYktWNUVDbXJEamlRMHJ5WEtNWjREVVZsSE15dzRa?=
 =?utf-8?B?Qk80Y2FYYXZscCtlS01ZNDFtZXB4alp1eHl4djl6ZUx4MlVLYm8ydXdaL1Uy?=
 =?utf-8?B?aHEyNEZYM0lvcjdlb2oydFIrSEUrQWRrb0dQdC9GaTA1MWIvS1ZGN3Q5ckZD?=
 =?utf-8?B?MnY5TVgzWGFtYkNpWDJQTXAra2c5UUJSQlVaWWgzeWFNVVF5Yyt6RjAyZGVW?=
 =?utf-8?B?MUhPMzZaR2c1ellqd0hqZTdZZzVZVUdkbHRVMjNwam5ZSVBSRnYybm9vRkc0?=
 =?utf-8?B?dm4xZUtBcURoeFh0ZGlEelVDSWtZRlR1OTA1S2NBRkRKWFBjdkdqYjlYTjVE?=
 =?utf-8?B?Z0pGVVoyaVFpQi9naEdBNVhzUW52a2M0MGluZGZwcU1wVTlVMjJxY3JaejFZ?=
 =?utf-8?B?RklPUXQ0eEZscEp6cW1ucWV6cnoyb1N4U1VubHQxMG52NVZQbGpIa1lSeUlr?=
 =?utf-8?B?M0NmWDR4TU9acm05K2Y0NmdINEJkZTJPclFDTldNMmF6ZW1SSXZGUCtSZFh3?=
 =?utf-8?B?SDdMTzZtRmZNTEs0aGJYMVNqN0NFV2h5V1NyR1B1MjdmQTVTaitndUpNY0xN?=
 =?utf-8?B?YmM0bGF0QTlCbmRmQTZJNUExb2wxK292Wk1LcXQ1S3dUaUdGMkZ1M2srWFhq?=
 =?utf-8?B?dzBFdDRTd1Fydk9QbStmUlJ5RDMybDdKZ1ZnWEdMZzVOOXNCY3BzTUh5ZnA2?=
 =?utf-8?B?VUU1T3ZPOEtkUkxzZVhSbWtMTEx2Q2lwTFk4TUxsNnB6amZmNXg5US8yY2g3?=
 =?utf-8?B?ZGFNeW5LUWNCdlMrQXdNU1NKZGRBTDNOSFBCU2c3UVQ5Ui9pN2hwU0I1eUlQ?=
 =?utf-8?B?YUMrNHdVd3VYWFpheVU5UHBXYjhqOXo1aFhDd1FNYVZxQXRvZTY0WHJTV09W?=
 =?utf-8?B?T1g4d1AxbWRjUTdFbTU2cHY0TWlZdHdSUm5JNmtjYjBRSUc5aEFldEFPVWVi?=
 =?utf-8?B?azJzRW9tTCsrMERvMVRPSjU1ZEtJLzVRdkltcEZ5STg5WjVON1FLR3ZEZ0hp?=
 =?utf-8?B?d2dOYUZtNVdQVkRSWjVuN2FzS29OVXV6ZzVuQ3cyWWFNMEhyYkJ1Y3o5ZUlk?=
 =?utf-8?B?VmlIdldMM0hiUW0yZ0ZIR1NYSnNtSHlKY1FrZ1BtOWpscEZqdkZBbHpEYWc2?=
 =?utf-8?B?NjRsc1lEcW1FR2RzcW9vZmJUWkJSZTYxWU9VdWZIQjEwUGNsZTgwWUJtRmhv?=
 =?utf-8?B?VXN5QkorSVJ6d1RNM0pLaUMvRExrQVRXZzRrQ05CSk03czRYNTJ2b1hUejE2?=
 =?utf-8?B?UWlQQVQ1MUp5QXA0YnJMbFpHSUw0SUJaTDBtaFFlZ252ZDcyZDV5Um1mK0wz?=
 =?utf-8?B?d213ZWRSQWcwY3dKQmc2ejY2UWdrYllsRWJidmxOMDZtQUlCTWpocThCZTYz?=
 =?utf-8?B?dlhpbFd6aVRESDR3Q1o5bzlsTENoSjdrNUdtZnhPWlNmOGY0Lyt0YkRXaTRB?=
 =?utf-8?B?YkhSSUFHN3Y5YkhkSkUzNEV3dHNWQ0M5Q2UzUXlUTHUzOGJXN3hZZkU5a21h?=
 =?utf-8?B?VXlkSVBLSWI0SllTeFRkTlhrTEJYUVp6QUowaGJkUzA1cTUxRXhib3lYRmkz?=
 =?utf-8?B?MVJXbU96VjRyZnNxNWsycEZZcHBtNHNDNEFQNm8wWW4rcm5jd3ZwL0cxeXF5?=
 =?utf-8?B?R2I4S2c0WlFDbFNCSWsyNUVoaGd6RGhBTVhOMjRvMzlJTHJiRGt3L09XSXdB?=
 =?utf-8?B?aVBFTkNWZXFiZ2dmMk5UR0FBOGMydm9SbFV5NkVuR1pNYTVuU2RRUUxwSlBJ?=
 =?utf-8?B?MHpOd2VUcDZpVW8ydUhZNGZhL2UwTzg2NVU2a2YwNWswQmc0eHc0SC93Qi9x?=
 =?utf-8?B?eVo0QzJ5eHFYT3lhdnpZL3pTdStOdnR6SjIxVjI1RnFyNktXZjYvQVUwWkhz?=
 =?utf-8?B?ZFE4Mnp2ajNVRzlqa1IrbzloWXJlUlVDODJwa0Y5Yk9MWXlLK3JkVjB6UWlT?=
 =?utf-8?B?MHlmajFFbGIvM0ZGN1MvajNET3N6N01yOS9JdzVOOTF3LzlqMHBaUzRzZTBa?=
 =?utf-8?B?VXVnK3ZqU2tidWZKZmlKOE1HS3JrcnNZMXo3N3JQUGFHYWdOYW81MWU5Vjly?=
 =?utf-8?B?N2w2TEpTdndralRHRDFYTHl0U2owVXRZT3RrMGhNeEU4UW1XQkgyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: edLEFiLLlVjuG1YfywIKK9KspXmSVMavgCsaNlurZtqv/QMbeLaoP8y7DFtfPw7BKvk7EkfyzwuTpuBxCBAj9M8PJrd+V6fWM4YCHwCos/KJv8xYec5pt5qddKGZBt/cAwFzT+VE8KWYsopVg8IEyYRs/kOfm31AalTSmI1WfgIsUUl5vZ343L31L0ftu318MHHpEnZ0APV6yBxAwKXmZ/961wvXcqYWBxlXah+/tfmC9guXPk93dzzvUJs9US6sa8LiYYxeTf67qhT0aV03IG4aF/TqnHikfArHiPJ4NEG2pYpihyJulTx4+gMfx39zCCOsTwpR+9hYT5X2rtrD8w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67b1afe-55e0-4745-9353-08deabdf9e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 02:23:25.3154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMyq1sWex+y+ewfzktUjy36/SpW7ofDpMMeCfK86fMHuI2hgiv2lzMFjOoplAglJIBJiloH7h6luWpq9D6zn2zfh0rnWIuSvC8puhsHYvf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8682
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDYsIDIwMjYgODoyOCBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBxZW11LWRldmVsQG5v
bmdudS5vcmc7DQo+IHFlbXUtYXJtQG5vbmdudS5vcmcNCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVk
dGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIGFzcGVl
ZC9oYWNlOiBzZWN1cml0eSBmaXhlcw0KPiANCj4gT24gNS82LzI2IDExOjUzLCBLYW5lIENoZW4g
d3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgTWF5IDUs
IDIwMjYgNTozNCBBTQ0KPiA+PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBu
b25nbnUub3JnDQo+ID4+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+OyBTdGV2ZW4gTGVlDQo+ID4+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBM
ZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+ID4+IDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+OyBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47DQo+IEPDqQ0K
PiA+PiBkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4+IFN1YmplY3Q6IFtQQVRD
SCAwLzJdIGFzcGVlZC9oYWNlOiBzZWN1cml0eSBmaXhlcw0KPiA+Pg0KPiA+PiBIZWxsbywNCj4g
Pj4NCj4gPj4gQSBjb3VwbGUgb2YgaXNzdWVzIGluIHRoZSBBc3BlZWQgSEFDRSBtb2RlbCB3ZXJl
IHJlcG9ydGVkIG9uIHRoZQ0KPiA+PiBxZW11LXNlY3VyaXR5IGxpc3QuIEhlcmUgYXJlIGZpeGVz
Lg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMuDQo+ID4+DQo+ID4+IEPDqWRyaWMg
TGUgR29hdGVyICgyKToNCj4gPj4gICAgYXNwZWVkL2hhY2U6IEZpeCBvdXQtb2YtYm91bmRzIHJl
YWQgaW4gaGFzX3BhZGRpbmcoKQ0KPiA+PiAgICBhc3BlZWQvaGFjZTogUHJldmVudCB0b3RhbF9y
ZXFfbGVuIG92ZXJmbG93DQo+ID4+DQo+ID4+ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jIHwgMjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gLS0NCj4gPj4gMi41NC4w
DQo+ID4NCj4gPiBIaSBDw6lkcmljLA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciBmaXhpbmcgdGhl
IGRlZmVjdHMuIFRoZXNlIGNoYW5nZXMgbG9vayBnb29kLiBIb3dldmVyLCBJDQo+ID4gaGF2ZSBv
bmUgcXVlc3Rpb24gcmVnYXJkaW5nIGFub3RoZXIgcG90ZW50aWFsIGlzc3VlLg0KPiA+DQo+ID4g
SW4gdGhlIGRvX2hhc2hfb3BlcmF0aW9uIGZ1bmN0aW9uLCBhZnRlciBjYWxsaW5nIGhhc2hfcHJl
cGFyZV9zZ19pb3YNCj4gPiBhbmQgaGFzaF9wcmVwYXJlX2RpcmVjdF9pb3YsIHRoZSBmdW5jdGlv
biBtYXkgcmV0dXJuIGVhcmx5IGlmIGlvdl9pZHgNCj4gPiBpcyAtMS4gSW4gdGhpcyBjYXNlLCB0
aGUgY29kZSBmbG93IHdpbGwgbm90IHJlYWNoDQo+ID4gaGFzaF9leGVjdXRlX2FjY19tb2RlIG9y
IGhhc2hfZXhlY3V0ZV9ub25fYWNjX21vZGUsIHdoaWNoIG1lYW5zIHRoZQ0KPiA+IG1hcHBlZCBh
ZGRyZXNzIG1heSBub3QgYmUgdW5tYXBwZWQgcHJvcGVybHkuDQo+ID4NCj4gPiBJIHRoaW5rIHdl
IG1heSBhbHNvIG5lZWQgdG8gdW5tYXAgdGhlIGFkZHJlc3Mgd2hlbiB0aGlzIGVycm9yDQo+ID4g
Y29uZGl0aW9uIG9jY3Vycy4gRG8geW91IHRoaW5rIHRoaXMgc2hvdWxkIGJlIGluY2x1ZGVkIGlu
IHRoaXMgcGF0Y2gNCj4gPiBzZXJpZXMsIG9yIHdvdWxkIGEgc2VwYXJhdGUgcGF0Y2ggYmUgcHJl
ZmVycmVkPw0KPiA+DQo+ID4gSWYgYSBzZXBhcmF0ZSBwYXRjaCBpcyBwcmVmZXJyZWQsDQo+IA0K
PiB5ZXMuIERvIHlvdSBoYXZlIHRpbWUgZm9yIGl0ID8NCj4gDQo+ID4gdGhlbiBmb3IgdGhpcyBw
YXRjaCBzZXJpZXM6DQo+ID4gUmV2aWV3ZWQtYnk6IEthbmUgQ2hlbiBrYW5lX2NoZW5AYXNwZWVk
dGVjaC5jb20NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNClN1cmUu
IEkgd2lsbCBzdWJtaXQgYSBwYXRjaCBmb3IgZml4aW5nIHRoZSBwb3RlbnRpYWwgaXNzdWUuDQoN
CkJlc3QgUmVnYXJkcywNCkthbmUNCg==

