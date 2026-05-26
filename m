Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F297ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt79-0008IZ-TJ; Tue, 26 May 2026 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wRt75-0008Hg-Ag; Tue, 26 May 2026 10:50:37 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wRt73-0002LZ-5P; Tue, 26 May 2026 10:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdP6oSn34MUDz8dKUXoh4Ln2PmfFss+U+Nz/P9GJFj78HWlZRof86NS+NlWBKTtXErok6/j31XiAibugFLr2QwvOt83HiSnS+2q0GHcnyKTNQzarB/NXYUQSf6kxZE6ovRELtNZ9fxHO6+AB98CWPnvsnl0dlvgk99KfNW9SnwBegOCjLvSVq/plF/ienrZxhx/I3YLld63xMPOLVsPIC3Z4SJ6qqlGPW23uwCWcyqiBrkRSJpIYaTqlxo5hGP1dNj8w3a7zHr1Jm6FZBgts5Hv5aeqBfDP17CcOmXHmM2kJXboNi5+qQ4OZc6DBVyvoZPpPcqcAGNXBzkI8VmS8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVRjLAb3Q1f8KAzs10cdisKnA0P9hkIEvPYraqoB8UM=;
 b=gPJVCh2EFNjbguDqObD7VkhN/Lev/7lmr+rLzlRtSJnB13NbrsUDVBnv14nlh7IDl48PRRPOfSBdXcfXX72PaLsTOINiGqvNIc00M4QVOc1iqLxKYmNTEdDm30NK7OYG4P543z4YbojUiriIG0mGsgz0j/fLeKQWHi4/edAziUr6GSNh4HpJBtMQRpmiFhFznpOqOz0JT/Z6hjH/+2W3NwvAcQE5UqPDPHjFh+cB6O3DyEO5NOEGrT13Rbqnp8d2oPHpCOl8go2QgSzq1St5Xd+y7sAqQItzzlFMkyG3YGHm/6o4WOamJJ3oS1NNsCn0Mm4yijPOBhDzvoTqkBqWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVRjLAb3Q1f8KAzs10cdisKnA0P9hkIEvPYraqoB8UM=;
 b=Ri4ZT68RuAtPJCYB5goARllAiAwIAHEvgj3Ynav97a7OGcCiw7TsCSczi4gozX6DwuD31H6utB8gZ56QLLbSHzLiQJhorJWUKfpmE6jqHCLSunGAk/LL9XZBOPrZfdANI07Xr4WZGvGV9NYDRKSBU02NB83P36sf2pe1Ebnt+k4fMf6VNLv9gNd5E3aNtDxmnP/YkFxquJZewPi+37q/vNawyFGNwdAcULwv8i4z3s6c173tLu1fm15C3VcV6WZSO0Yzv22a362yeHe7b5ufY6YxjSMbVFHL5FOpOSwd8Qkxur0CWWdhIBlttnpHs4TC0E94HytqsDK+fXL0wQuFqA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB7229.eurprd09.prod.outlook.com (2603:10a6:800:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:50:25 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 14:50:25 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>, "thuth@redhat.com"
 <thuth@redhat.com>
Subject: Re: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Index: AQHc4SGJJFFTewwpskSfCNpEFr+omrYXAcYAgAA1d4CACUR3AA==
Date: Tue, 26 May 2026 14:50:25 +0000
Message-ID: <16445d07-5045-4a98-956c-30a4f0247596@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
 <5d2b27bb-f8d0-4992-b8dd-719b7a17b516@htecgroup.com>
 <4533011a-4128-4823-bfd1-cabd3bd0e646@linaro.org>
In-Reply-To: <4533011a-4128-4823-bfd1-cabd3bd0e646@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB7229:EE_
x-ms-office365-filtering-correlation-id: 66346a12-1942-4224-e51d-08debb361ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|6133799003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: uDbwwhxf3zF/iJlQJ1LwyAzDdEyR2U7YF3208PzYFkyVkAUvFJhAFxXTwk7+JkLBhwboqE7L/oEgjh+aqC8qjrBGjDICxfN9VEo8z+jW9jNXCK6uoMU34P4/P+f/tGMGs08IXHbYTemRk1Qvwj4e8FZHBhYImDENRKP8bvkhJ9I5tgXlMXVRYvxiLan0UpHnvFNV7L57RsnbpO1VAfR7lfhvYX/iYG0NvzVl4/HD9+7NLzU8WhrtwRMzMd2XvjfSHIw30kDorxMsw2kQvqYVBF+z43RcXAtXFyY6ZLpCxgIMstpiU/FgzK4kz+S4/Oqqwfg7Xn08Bpx7ImAjB9/2+bSkhFIhatoMDG0CeMmkthPT5Wi9jQTAY/V/0e6XeUPvB1opwv+t0ZOFNYes1gaEUa8ETTx6vJuXW6pnbTsI9i2H+mefzF3lwgLwalLxgiFZO8pVguxWVP6ZWQfU9bf7Oqrk9wEVpZQHxOSg1Daj6dlsU4NSTbczlYREqCzWYiwE83kGf0drN8mOXspkgfRsDj2bpaC5gkWhvVaJO1L02ej84+ykp1JGjGO384Gsd2fdaD2H+ICtccnUrDtq+H38n7hBevdWjbfkePL5/8UuZMR7nbicjqn+fqG9VuK2n0kaxnM2fMtgqnyijBn4cyQEFyhqv82m6J05Tw5ewsWH+m1frU6YfwhODsybpik9MvNz/zni+AoOQWjg3X60R9WEYD59GuP/KIbNx2y5E738DBML5jltMKboyps1wypgW9Gg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enh3SE5SSkNOK0o2RDdPSStLaGZ6c3VPWCtIclJ0WnowSXdBdElqNFFOdXdx?=
 =?utf-8?B?SkEra0tWZHNGSlZuVEFLMGRySjBZNkltc2RPQytkLzJBWWJJT2R4VUlOU2ti?=
 =?utf-8?B?cCtRcUsrYTBOSGZGTVR6RUZlVXBPV1pkMmd0K0JQRnVIR2ZFOCtnM0xJaUN4?=
 =?utf-8?B?dWNsTmN6RHhXditBbXZrUWJaZjYyR0ZsbjVqS01zOVUya1VVRXUzbk9MQTZh?=
 =?utf-8?B?QXRKbXBJZEZOdkgvYkthK0gvNi9SalF1cThkRjB4OFRxRDczak1ONDZibHFz?=
 =?utf-8?B?NjgzdGlweHpjWjFIYVczdzZJOUc4QmEyMFBZY2J0dG1JYWxlNVNhclNwbEN6?=
 =?utf-8?B?QSt4L2FPWWprQTFobVlwK2pXUlNPVE9GSG90MksxM1hCb05IQ2h6blJYc0Y1?=
 =?utf-8?B?SElHaXZWSC9lZ2pQYi9KSWhEc0dzeUowcHBHVVRBVmZVQ0UyR1NJV1g2NE44?=
 =?utf-8?B?bjZ0aEJ3Z3J2MSszdU04RlNQVXRzT1JqeUdKSUd2TFlPQW1pU283aXp4RUJs?=
 =?utf-8?B?MDdlQzAwQXlGc1ZHVGRmNDRSVk1rS3BZWEk1L08yTmF5T3ZqUy8yUXFHTWVa?=
 =?utf-8?B?SVpXMUNOOHFZNmMybjJNZTlabC9NeXAvTk9TMjFlM2U2cllBelBscnplL2xI?=
 =?utf-8?B?VFAvQzk3SFkwa3hJWUtvU3QxMi96M1JoTHRScUlIampDN3djdjdmUi92SHk1?=
 =?utf-8?B?SWtRbDdaeEJkdTN4UGp6c2RLaFljTDdaekxIWTlOZFpreUZib1d2ZlRwNWRZ?=
 =?utf-8?B?cGQreGt0OThNUlNWZ1dlWGtRM2h3VFI4clZIR1FVdUUrWjJXc25DVDNIREww?=
 =?utf-8?B?aUY2b3dBK3dCUEMySDBLNWR4VkRuc0hnNCtoU3l2U21OdFhuRU5yczRoS2Q0?=
 =?utf-8?B?TE9lRUlMVm1hSkRBanZ6TkZDZjBhS0Jac1o2SnRoV2QxRGN1M3pNOGpIT3h0?=
 =?utf-8?B?NHlFTTdMdHdqMjhxTmV1eUxIQkE5disrd01WcWJ1RjFLODBpZmE2WFZDYkR6?=
 =?utf-8?B?ZW5uOVVtS0pkWUQvZVU2QkdhRFBGc25lNTB3N2l4aHRIK1h5VStDNU9Yb0J4?=
 =?utf-8?B?RUxvaXRiUGNFWHhWaXlsZjhPc2c3MDFxV3J0ZEg0TG1vd1Z0VUVYUUlYbGxO?=
 =?utf-8?B?dXF1dEszUlYwbUlzQ1FMdzZ2QzB3NjJMUkVoMUYwOEVvL1pTWEFFWnBJcXVG?=
 =?utf-8?B?dTFqc3Y3bFFmSHQ1MmpyYkM0VzFtYlA4MlNCTHZBOGVyaENjM2ErcWtwSVp3?=
 =?utf-8?B?WjRNb0xqdVpkQzIrK2ZRRVZKOEJ2WnpteWxhWEE3MGN0dEljeVdUZVRDSkly?=
 =?utf-8?B?cDU5bU5GNXFSREk5alVwMm9DOTVXY1lOS0NCSlRNQVBwa3l1QnptdmsweUxm?=
 =?utf-8?B?b0NnMHJ3UHd0Vk9McXpydGFZOFpmQ2Nxb01UUGFETnpwemcwNk0wYldQSit1?=
 =?utf-8?B?Q1pUTnltczA2alpJK1pPYmVNcDYrWURrUi9CMXlaNGMwNUU3eXlIWkozS2NB?=
 =?utf-8?B?VWdlNHlxLzdWdTMwdytEMDFWcmltaGZkSmlrWHFkT3oxTURseWVDL0Z5R2Nn?=
 =?utf-8?B?UTVLck1ISlNSeGtUWS82WjdkdXpoSWN0ZDBXQUxaWVdady9HbVNVbDJUMzNh?=
 =?utf-8?B?NGh1d2h0bWpPcXNpUEJOelhXV0xpZHE5MzcyK3ovOUVUL3g4dzZNY2VhcEdw?=
 =?utf-8?B?TXNWSlEwY2dUY055NjM4WEoyR0JtNVhhNjNsTXpHdXc0M3lqM0p0cjlNSitk?=
 =?utf-8?B?OUdSWDI3RlhHQnkxSUIrOWt1VnJnd1dZS1djRmpGQktTVVNtR2cxWmdaZkpm?=
 =?utf-8?B?R1pTWFpTUUYzbHNUODBsZnVsbFg2K1RvRUdpVkpPMjl5ZTFuUForS2d0bnZO?=
 =?utf-8?B?MzJoUW56MmtrbDVzZkJ2aFJxaXpWa1VnZkw2a2JUeHdwNnhpdllzbkVoTVhB?=
 =?utf-8?B?ZUtYZGFDbFdpZWM3M0l4QmE5cEJpQzdiVXJjNjM1ekxjMVlHNFUwRVJxQWJG?=
 =?utf-8?B?N2VpR0hkdHZLSWRKa09Gb0pxd0dNQlE4WUdxODZrSWRCQkRZMlA2YUxGdjlC?=
 =?utf-8?B?TldhU1dLdHlBbjRIZGx0VXZKR3dpc280dW9jbzFLNkNPSVdJWDRObE56ZS9I?=
 =?utf-8?B?NE1qcy9WUUFXN1h2d2ZSaUZRUWFsaGpXOURycXlydHFndGlHZzdwdXVqY0Y3?=
 =?utf-8?B?SkdnYnhQRmFndXAyMi9XY0JkVmVBSEhMOTFMOFRrYm5oVnkwTFdvV0k0MTFh?=
 =?utf-8?B?ZTVnYXRSWVR0L3ZJcWplTEF3SlQ5M0p0Vk4zTVdFUjJQOFhlYXM2ZHMrUGd0?=
 =?utf-8?B?NUFSZ0xEOGVmSXI0Qk5JVTh1RkVGV0F2WFJleTdsTkdQRWxsd2Fxc2RPSnQ5?=
 =?utf-8?Q?eAJErR+bQuaVlMhvbbzGvSXh7T4Ur9zmNoVlI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63861904232D9640A9D9F6E4C8986EBB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66346a12-1942-4224-e51d-08debb361ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:50:25.1096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3N/sBE2YO2cK/ni5n/AewSsgz17srFkoKOn2qkLQColRQ5/Ejy9zIyi+G+OQKdnW7JQjJSoK0YvG8Le7RnV2xB9zMGIGLLCccn0cIOQyyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7229
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

DQpPbiA1LzIwLzI2IDE5OjE5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ0FV
VElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0
aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4NCj4NCj4gT24gMjAvNS8yNiAxNjowOCwgRGpvcmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+PiBI
aSBhbGwsDQo+Pg0KPj4gSSBhbSB3b25kZXJpbmcsIGlmIHRoZXJlIGlzIGFueSBjb21tZW50IG9u
IHY5LiA6KQ0KPj4NCj4+IFRoYW5rcyBhIGxvdCENCj4+IERqb3JkamUNCj4+DQo+Pg0KPj4gT24g
NS8xMS8yNiAxMDozOCwgRGpvcmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+Pj4gUmViYXNlIG9uIHRv
cCBvZiBtYXN0ZXIuDQo+DQo+IE1vcmUgdGhhbiBhICJyZWJhc2UiIGNvbW1lbnQgSSB3YXMgaG9w
aW5nIHRvIHJlYWQgd2hhdCB3YXMgdGhlDQo+IGNvbmNsdXNpb24gb24gcHJldmlvdXMgdmVyc2lv
bnMgYWJvdXQgd2lyZWQgZW5kaWFubmVzcyBiaXRzLg0KPg0KWWVzLCBzb3JyeSwgSSBzaG91bGQg
aGF2ZSBtYWRlIHRoYXQgY2xlYXJlciBpbiB0aGUgY292ZXIgbGV0dGVyLg0KDQpUaGlzIHdhcyBw
YXJ0aWFsbHkgYWRkcmVzc2VkIGluIHY3IGJ5IG1ha2luZyBgYmlnLWVuZGlhbmAgYSBzdGF0aWMg
Q1BVDQpjb25maWd1cmF0aW9uIG9wdGlvbiByYXRoZXIgdGhhbiBhIHJ1bnRpbWUgc3dpdGNoLiBJ
biB2MTAgSSBtYWRlIHRoZQ0KaW50ZW5kZWQgbW9kZWwgZXhwbGljaXQ6IHRoaXMgc2VyaWVzIG1v
ZGVscyBmaXhlZC1lbmRpYW4gaGFydHMsIG5vdCBhDQptaXhlZC1lbmRpYW4gaW1wbGVtZW50YXRp
b24gd2hlcmUgc29mdHdhcmUgY2FuIHRvZ2dsZSBNQkUvU0JFL1VCRSBhdA0KcnVudGltZS4NCg0K
VGhlIHJlc2V0IHZhbHVlIG9mIE1CRS9TQkUvVUJFIGlzIHNlbGVjdGVkIGZyb20gdGhlIENQVSBj
b25maWd1cmF0aW9uLCBhbmQNCnRoZSBiaXRzIHJlbWFpbiBvdXRzaWRlIHRoZSBtc3RhdHVzL21z
dGF0dXNoL3NzdGF0dXMgd3JpdGFibGUgbWFza3MsIHNvDQp0aGV5IGFyZSBlZmZlY3RpdmVseSBo
YXJkd2lyZWQgdG8gMCBmb3IgdGhlIGRlZmF1bHQgbGl0dGxlLWVuZGlhbiBDUFVzIGFuZA0KdG8g
MSB3aGVuIGBiaWctZW5kaWFuPW9uYC4NCg0KSSBhbHNvIGRvY3VtZW50ZWQgdGhpcyBpbiB0aGUg
cGF0Y2hlcyBhbmQgd2lsbCBtZW50aW9uIGl0IGV4cGxpY2l0bHkgaW4gdGhlDQp2MTAgY292ZXIg
bGV0dGVyLg0KDQo+Pj4NCj4+PiBEam9yZGplIFRvZG9yb3ZpYyAoNyk6DQo+Pj4gwqDCoMKgIHRh
cmdldC9yaXNjdjogRGVmaW5lIE1TVEFUVVNfU0JFIGFuZCBNU1RBVFVTX01CRSBiaXQgbWFza3MN
Cj4+PiDCoMKgwqAgdGFyZ2V0L3Jpc2N2OiBBZGQgYmlnLWVuZGlhbiBDUFUgY29uZmlndXJhdGlv
biBmaWVsZCBhbmQgcmVzZXQgDQo+Pj4gbG9naWMNCj4+PiDCoMKgwqAgdGFyZ2V0L3Jpc2N2OiBJ
bXBsZW1lbnQgcnVudGltZSBkYXRhIGVuZGlhbm5lc3MgdmlhIE1TVEFUVVMgYml0cw0KPj4+IMKg
wqDCoCBody9yaXNjdjogTWFrZSBib290IGNvZGUgZW5kaWFubmVzcy1hd2FyZSBhdCBydW50aW1l
DQo+Pj4gwqDCoMKgIHRhcmdldC9yaXNjdjogRml4IHBhZ2UgdGFibGUgd2FsayBlbmRpYW5uZXNz
IGZvciBiaWctZW5kaWFuIGhhcnRzDQo+Pj4gwqDCoMKgIHRhcmdldC9yaXNjdjogRXhwb3NlIGJp
Zy1lbmRpYW4gQ1BVIHByb3BlcnR5IGFuZCBhZGQgZG9jdW1lbnRhdGlvbg0KPj4+IMKgwqDCoCB0
YXJnZXQvcmlzY3Y6IEFkZCBlbmRpYW5uZXNzIHRlc3QgZm9yIFJJU0MtViBCRQ0KPj4+DQo+Pj4g
wqDCoCBkb2NzL3N5c3RlbS90YXJnZXQtcmlzY3YucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDI0ICsrKysrKw0KPj4+IMKgwqAgaHcvcmlzY3YvYm9vdC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgODEg
DQo+Pj4gKysrKysrKysrKysrKysrKy0tLQ0KPj4+IMKgwqAgaW5jbHVkZS9ody9yaXNjdi9ib290
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+
Pj4gwqDCoCB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArLS0NCj4+PiDCoMKgIHRhcmdldC9yaXNjdi9j
cHUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDIzICsrKysrKw0KPj4+IMKgwqAgdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArDQo+Pj4gwqDCoCB0YXJn
ZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKw0KPj4+IMKgwqAgdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyOCArKysrKy0tDQo+Pj4gwqDCoCB0YXJnZXQvcmlz
Y3YvaW5zbl90cmFucy90cmFuc19ydmEuYy5pbmPCoMKgwqDCoMKgwqAgfMKgIDQgKy0NCj4+PiDC
oMKgIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2ZC5jLmluY8KgwqDCoMKgwqDCoCB8
wqAgNCArLQ0KPj4+IMKgwqAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZmLmMuaW5j
wqDCoMKgwqDCoMKgIHzCoCA0ICstDQo+Pj4gwqDCoCB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc19ydmkuYy5pbmPCoMKgwqDCoMKgwqAgfMKgIDggKy0NCj4+PiDCoMKgIHRhcmdldC9yaXNj
di9pbnNuX3RyYW5zL3RyYW5zX3J2emFjYXMuYy5pbmPCoMKgIHzCoCA0ICstDQo+Pj4gwqDCoCB0
YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnphbGFzci5jLmluY8KgIHzCoCA0ICstDQo+
Pj4gwqDCoCB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnpjZS5jLmluY8KgwqDCoMKg
IHzCoCA0ICstDQo+Pj4gwqDCoCB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydnpmaC5j
LmluY8KgwqDCoMKgIHzCoCA0ICstDQo+Pj4gwqDCoCB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc19ydnppY2Zpc3MuYy5pbmMgfMKgIDQgKy0NCj4+PiDCoMKgIHRhcmdldC9yaXNjdi9pbnNu
X3RyYW5zL3RyYW5zX3htaXBzLmMuaW5jwqDCoMKgwqAgfMKgIDggKy0NCj4+PiDCoMKgIHRhcmdl
dC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3h0aGVhZC5jLmluY8KgwqDCoCB8IDE2ICsrLS0NCj4+
PiDCoMKgIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3ppbHNkLmMuaW5jwqDCoMKgwqAg
fMKgIDQgKy0NCj4+PiDCoMKgIHRhcmdldC9yaXNjdi9pbnRlcm5hbHMuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSArLS0NCj4+PiDCoMKgIHRhcmdldC9y
aXNjdi90Y2cvdGNnLWNwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDMgKw0KPj4+IMKgwqAgdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjIgKystLS0NCj4+PiDCoMKgIHRlc3RzL2Z1
bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+
Pj4gwqDCoCB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5wqDCoCB8
IDU3ICsrKysrKysrKysrKysNCj4+PiDCoMKgIDI1IGZpbGVzIGNoYW5nZWQsIDI1MSBpbnNlcnRp
b25zKCspLCA4MCBkZWxldGlvbnMoLSkNCj4+PiDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQo+Pj4NCj4=

