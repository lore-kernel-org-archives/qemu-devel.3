Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8CCC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXCBK-0001O5-3d; Mon, 05 Feb 2024 22:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXCBG-0001NR-5p; Mon, 05 Feb 2024 22:31:31 -0500
Received: from mail-eastasiaazon11021007.outbound.protection.outlook.com
 ([52.101.128.7] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXCBC-0000Rn-Nl; Mon, 05 Feb 2024 22:31:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnmf3wtYCZihlFSi+TPGtHcje5xTAtoCj61xel5ZTQmoDGRqPKcCB6FfG4Z6gwHsu5ybelCEJho1bHo+24YYAMjSn0BiwUaQazfoNIxsqzDxAzlZJsD+Lkmd8rGsKTFT32SFdKRJb0v4hRKDFLIrZDoTu3j7XNoht7E5hG7T5ztZE+FGFPnsRnHSLQKPRuyKVrMpExZwucFQY4/N+UZ5kM4463ylS7zMhNuHlsmQOJqHbgfj1qvMvVI5EyANVaQvD8/JPXQ0KiwtLrr0hS7cdG3qV57cBC/xEXNj6nAN9BRNpt7pMatatD5vjR4JSIqWGsF98MnwPPtxk5T408X80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDOqTNeg1bx7WJRp+yjaaOnRxg0Gp6X7bz+cLyOrmTw=;
 b=fSTYIjds+/9mCTv9JQK0ie/kIUWTs4R34rylGayhdLQU+BRdn+WbaJkJWD7Iys0zVdqME2DniIg7rpo4NONhsMYRhMNu11NvVGTvqktekPDArg+GIE6I/1Zgj0844xytV2ivvm3vf2q4nnLJ3XuVNhE2sFGH38nTmj9iomtfg/+p1sc9taOw7xw6Hns9AFKx5V6NW7OHIpXq2Hus003leg2WPWzd1Z6QG0VNjTrYSgwTPdql5NtISiEOMdrwahkjBMznUribPmRnlNbgFe0kWUAcHugDEBCxrf0eVa9KUOd480gt3iVM6i6wlwCOH8W0GlzFfxF8pZ6aUkhJUUJk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDOqTNeg1bx7WJRp+yjaaOnRxg0Gp6X7bz+cLyOrmTw=;
 b=AYla90bLbhloB2BhlWin9SljuMSRE3XhWpr0PH2271+wj2HZ0RkUqhNt8+PxIlJuz7jG7Jtr3XbIbrJCg/IW+9Momz5vvtt6zgXwAXDX2XZSaR0onguaKNE31WSk4yO1clw9JWl1fAOgX/QLNrdqmGCIrNRDac3s5Qk8IxoMpMSZLoyMNP76laeim2h9rYNJ92zZ4WrAUxikUson13/Mfzjl1r1sJoU/2r0Azsm4joCRsX5vQfBUB59pnau06WTEcmdkLCooVhUfgr6oIRpOI/uipCowYMpilWbPWAsUTMdAxyS+7nTZ//iAB8lSRfU8qqnu+wh6j0P0fdluzU4EaQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7040.apcprd06.prod.outlook.com (2603:1096:405:3e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 03:29:49 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 03:29:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Topic: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Index: AQHaWBO1pIX+mXoppkCs9A5dfg25WbD7kN+AgAA9OQCAANX3QA==
Date: Tue, 6 Feb 2024 03:29:49 +0000
Message-ID: <SI2PR06MB5041FC68062741DB853B979EFC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
 <30e7e323-369b-4ee3-994e-a6cb9205a4f9@kaod.org>
In-Reply-To: <30e7e323-369b-4ee3-994e-a6cb9205a4f9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7040:EE_
x-ms-office365-filtering-correlation-id: 1845ad3f-f215-407f-f0a9-08dc26c3dfc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wOhswADb4temKgEKOTtLMse/leXlQ62Vgb37pK/sQ2lQ0qokFDJy9kImXgtwMKJ9LuvDn2yqJbVwjWfq4YXjYU2EskhRsQejrT1+BrfX5KaklwJqaYKjiMoBSJx2FRwpQTNqor3mjHS4r47rU2QlUvvLP5zfU+4xSCJWIYFgrslIkNt5hTatQy4DoRj7lVqYUdk96ixO+sRBPcjY2AZju+tUq19gfzwwqItG3xi1mHkNOuVE/UHXPI7zNq5p27IOiuNvrjGtsxyV2LdwM6g+pBGbPYJl5qR47ELpQcvVbZOQeku6AelraTPnlJTYORoxF5CbtEybyf7dvdoh8cL4cfywWxfFmqYlDkLcwwoe5liz7SsCYBCkoXC4ga5rMx7ZjYZv3t2bKVU3AafzMmlOxZ/UPPCAdvK6uLwoyexUn7HTxV0g1syr1LbEI71om4D6KS+tQfqnE9yuQdgIaFf6CfcVQJ0qqpVU3b4ludpyzmcCMovuWHBPF6cQmsygHB5JgWEmmX5alS1gwC705iApnbIqvJKmIQPk7nqY5vVbbqgHhoGGbZ1fxDNdqfuN/R7JUeK+7JavAMtgrifPIvJ8isu418ZVKMfHlZrXkcxEO4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(52536014)(86362001)(8936002)(8676002)(4326008)(5660300002)(966005)(478600001)(107886003)(6506007)(33656002)(9686003)(7696005)(71200400001)(38070700009)(26005)(110136005)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(2906002)(83380400001)(38100700002)(122000001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm4vY0dUYmtvRDU1RnRKTGFUS0tBbWZEd3YvVEtITGZ6S0U5Ny9Hb1pmcDAw?=
 =?utf-8?B?UVJZZENrTVBqOGhOY1g1WTFieWV4RjU5Yk9uT3oyU2tTU3FHZmIwdzA3T1Ir?=
 =?utf-8?B?elJvb3NlaklKSTE2ZUxldWJOK0w0UlVjSk5xcStSTWZ3aDR6UHRvc3NMUkVU?=
 =?utf-8?B?S1ZmT2REb0l3QnF6ZGkvS3d2a2p4NlZLR1hNek1Eam9ibDlvS0M5SEFHMEgx?=
 =?utf-8?B?WHdnRDNaWWk5bFhIU3FKcGRibjVWSzE5WndOenZ4TjNGNjd6S3dYdlYySGk3?=
 =?utf-8?B?UjhXRlRrSzFrMlhsdC9GUXNkc0RaVEFPRWJsb0kvZUJMT1k1dXFyZk9TT2FC?=
 =?utf-8?B?UFNTamJEL3R6ajUyaXlWN2ZwVno3OXJEU3F5cmIwalQxVzRoUUxQdlNxSTRl?=
 =?utf-8?B?R0FKR2xnQ1d0bEFqeG4vYzJKTVNQR0ZhM3J6NThJbUxiY2dFOU04cFp3OXFp?=
 =?utf-8?B?VEdOOTNIa3RSWnpmK1RPMld1T0E3TTVIMkFDM3gzcHJLK3MzS0duOXlyMEI3?=
 =?utf-8?B?ajVyYmtPUForWkZaNDdUdnRyMmZHRmplREZ6bmliUTJXK2o3MEh6dXdEdTUz?=
 =?utf-8?B?M3dzTzBwcjdjbGVleFBHVXFla294Q2VVWCtQV01xajJFT2JpTjBtNWVUcGJT?=
 =?utf-8?B?cHpoWVBIcnordUVpRldUbnhXTlhacEo2dktqVHdoM0p6Ty9DNHZNOWV4UlpJ?=
 =?utf-8?B?c3ZTN3FUVFlZVHJOb1VDOVZrZmRFQTIyOEk3K1gzeHdVbU0yWmpYaG95T0c4?=
 =?utf-8?B?SlNlaEdLclVxMTNBUW1rS05iMUZoVmxqVEJXLzV0KzM4MDdQb0FKYnd3M0VJ?=
 =?utf-8?B?Q2FLNGdrcVFJOTZZZ0pUZlplUkI1V2tiZVRhNU9KbUwrdzk2YVNrVnhHZ2FK?=
 =?utf-8?B?ZDhIYm13bUxMdEJxaG0wOGJpakViVUsxMVVKaC84QUE5MzZSRHBHUnpTbU54?=
 =?utf-8?B?TFU1aEovTVE1aUQ3cjJhbFVKUEZDMUdpbUtsVysya1dPaHBlWHNnQTA3Vncy?=
 =?utf-8?B?UjYyVUhxU1pFR2hOOGFXTS82TERSZUNDWklsL3pZV3dVaXR5ekx2NGk5TWQ1?=
 =?utf-8?B?c09jcnlObnd0UzM4UHpXLy9jelVtWG9GcWtSRmFEVDkzbnlSRC9iSi9wYmNZ?=
 =?utf-8?B?U3NlUjRZSWJQcjBXSzIzM04wSFpENEhyOWZkbGNTYkdPTGhsMXhsT1pzUFlv?=
 =?utf-8?B?aksrNVc0SlAzTUdyRHgycjJSekh4eVJ6TWZ5a2xRaDFUT25HOTFmK3c2MFpI?=
 =?utf-8?B?S1YxV0RsUjk1TVBOWG41bHlsY0plSis1bmxzRkNyTGFyUmRlMy9Ta200MXNN?=
 =?utf-8?B?cVdSMEJKaGY1VlVNaDU4dnFmay9aaW4wR1dwbXRwUElyMEEwVlNFbDNQNHQ0?=
 =?utf-8?B?WVlOVzNqOFZQNldhU2NEMW9lMFJMenN1T0JBNFdWd0ZZMUxYcGphMjZTcGMv?=
 =?utf-8?B?Vm1RdkVUaERNM2x6NnFBa1BCalZ4U0U2OWdERitZL0E1bWR6djJudzlWQXgz?=
 =?utf-8?B?NlZ2WDdoWThmcXZjZXdCdE9XU1h0ZTJBb3BvTjd5TWVTVGF4bUl3UzZyZG9F?=
 =?utf-8?B?eXRRcXE2djVlNStqSTIxYkx3TVhaRG55N25mYndqeFhrZk02ajI5VkZyRXVH?=
 =?utf-8?B?dDZzMDFrT2ZZRitCWFdXRThkelR1RG9YaDMzUWM1NWZFYVNSQ1NPdDVRK3BM?=
 =?utf-8?B?bmx6cU1nZUhZVXZzMVhGc3VQTVlDckVVclp5OTlnLzNyTVlUSENZSDE5QUFZ?=
 =?utf-8?B?NnlSWmg0MHkyT08wRHk1bDgwNkRHRVptUmJOVzZ1UjZvR0tyRzFtL1VBWXll?=
 =?utf-8?B?b2ZBMEZUWHpyMXJoWWR3VUJCVzY5cGlOdVVxYnZhVmkwZnFySXdrSTkvbHlB?=
 =?utf-8?B?WS96QWZwdmlpd1ZMZlVGM2Q5bmV6ekV0ekkzZXlaczU5cXg1eVgzUUkxNUtn?=
 =?utf-8?B?TkhkZkw2eEJlL1BxNTF5R2cxYitsUGpFUjBDUFl2KzRGZko1OXBpUGJKYmhs?=
 =?utf-8?B?UzFXL2x2ay9za0M5V0lpc0VheU9OVFJFaWx3dkc5SHJQWURHVUk5SEZJSkJh?=
 =?utf-8?B?eC8xbmtFT3dBbzJMNkgrcUZ4aGxaZXBBSjNubmdBZnVpMUhJVU5ubXhYa0Za?=
 =?utf-8?Q?cenXUBp1aCcx7QMHbHqha1T1+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1845ad3f-f215-407f-f0a9-08dc26c3dfc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 03:29:49.4028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEavBM6MtMijD9fkQi/a2A/PZHBT4BPdlqjCZSWQGuUe9EqNhIJuWzvmrUeEOoFW4AyzHiXj2cEP6jRuG1th+yd6jOKHsfojl0Sb5d6BZg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7040
Received-SPF: pass client-ip=52.101.128.7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLSANCj4gVGhlIHVhcnQgZGVmaW5pdGlvbnMgb24g
dGhlIEFTVDI3MDAgYXJlIGRpZmZlcmVudCA6DQo+IA0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29t
L0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42L2FyY2gvYXJtDQo+
IDY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiANCj4gCXNlcmlhbDAgPSAmdWFy
dDA7DQo+IAlzZXJpYWwxID0gJnVhcnQxOw0KPiAJc2VyaWFsMiA9ICZ1YXJ0MjsNCj4gCXNlcmlh
bDMgPSAmdWFydDM7DQo+IAlzZXJpYWw0ID0gJnVhcnQ0Ow0KPiAJc2VyaWFsNSA9ICZ1YXJ0NTsN
Cj4gCXNlcmlhbDYgPSAmdWFydDY7DQo+IAlzZXJpYWw3ID0gJnVhcnQ3Ow0KPiAJc2VyaWFsOCA9
ICZ1YXJ0ODsNCj4gICAgICAgICAgLi4uDQo+IA0KPiBJIHRoaW5rIHRoZSBuYW1lcyBpbiB0aGUg
RFQgKGFuZCBjb25zZXF1ZW50bHkgaW4gdGhlIFFFTVUgbW9kZWxzKSBmb2xsb3cgdGhlDQo+IElQ
IG5hbWVzIGluIHRoZSBkYXRhc2hlZXQuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHdlIGNhcmUgaW4g
UUVNVSwgc28gSSB3b3VsZCBiZSBpbmNsaW5lZCB0byBjaGFuZ2UgdGhlIGluZGV4aW5nIG9mDQo+
IHRoZSBkZXZpY2UgbmFtZXMgaW4gUUVNVSBhbmQgc3RhcnQgYXQgMCwgd2hpY2ggd291bGQgaW50
cm9kdWNlIGENCj4gZGlzY3JlcGFuY3kgZm9yIHRoZSBBU1QyNDAwLCBBU1QyNjAwLCBBU1QyNjAw
IFNvQy4NCj4gDQo+IExldCdzIHNlZSB3aGF0IHRoZSBvdGhlciBtYWludGFpbmVycyBoYXZlIHRv
IHNheS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQpIaSBDZWRyaWMsIA0KDQpEaWQgeW91IG1l
YW4gdG8gY2hhbmdlIHRoZSBuYW1pbmcgb2YgdWFydCBkZXZpY2UgdG8gMCBiYXNlIGZvciBhbGwg
QVNQRUVEIFNPQ3M/DQpJZiB5ZXMsIGl0IHNlZW1zIHdlIG5lZWQgdG8gZG8gdGhlIGZvbGxvd2lu
ZyBjaGFuZ2VzLg0KMS4gYWRkIEFTUEVFRF9ERVZfVUFSVDAgaW4gYXNwZWVkX3NvYy5oDQoyLiBS
ZS1kZWZpbmVkIHVhcnQgbWVtb3J5IG1hcCBmb3IgYXN0MjYwMCwgYXN0MTB4MCwgYXN0MjUwMCBh
bmQgYXN0MjQwMCh1YXJ0MCAtPiBBU1BFRURfREVWX1VBUlQwKQ0KVGFrZSBhc3QyNjAwIGZvciBl
eGFtcGxlOg0Kc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI2MDBfbWVtbWFwW10g
PSB7DQogICAgW0FTUEVFRF9ERVZfVUFSVDFdICAgICA9IDB4MUU3ODMwMDAsIC0tLT4gW0FTUEVF
RF9ERVZfVUFSVDBdDQogICAgW0FTUEVFRF9ERVZfVUFSVDJdICAgICA9IDB4MUU3OEQwMDAsIC0t
LT4gW0FTUEVFRF9ERVZfVUFSVDFdDQogICAgW0FTUEVFRF9ERVZfVUFSVDNdICAgICA9IDB4MUU3
OEUwMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDRdICAgICA9IDB4MUU3OEYwMDAsDQogICAgW0FT
UEVFRF9ERVZfVUFSVDVdICAgICA9IDB4MUU3ODQwMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDZd
ICAgICA9IDB4MUU3OTAwMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDddICAgICA9IDB4MUU3OTAx
MDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDhdICAgICA9IDB4MUU3OTAyMDAsDQogICAgW0FTUEVF
RF9ERVZfVUFSVDldICAgICA9IDB4MUU3OTAzMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDEwXSAg
ICA9IDB4MUU3OTA0MDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDExXSAgICA9IDB4MUU3OTA1MDAs
DQogICAgW0FTUEVFRF9ERVZfVUFSVDEyXSAgICA9IDB4MUU3OTA2MDAsDQogICAgW0FTUEVFRF9E
RVZfVUFSVDEzXSAgICA9IDB4MUU3OTA3MDAsIC0tLT4gW0FTUEVFRF9ERVZfVUFSVDEyXQ0KfTsg
DQpJZiBubywgY291bGQgeW91IHBsZWFzZSBkZXNjcmlwdCBpdCBtb3JlIGRldGFpbD8gU28sIEkg
Y2FuIGNoYW5nZSBpdCBhbmQgcmUtc2VuZCB0aGlzIHBhdGNoIHNlcmllcy4NCg0KQnkgdGhlIHdh
eSwgSSB3aWxsIHNlbmQgYSBuZXcgcGF0Y2ggc2VyaWVzIHRvIHN1cHBvcnQgQVNUMjcwMCBpbiB0
d28gd2Vla3MuDQpXZSBlbmNvdW50ZXJlZCBHSUMgaXNzdWVzLiBJdCBzZWVtcyB0aGF0IFFFTVUg
c3VwcG9ydCBHSUMgdjMgYnV0IFNQSSBkaWQgbm90IHN1cHBvcnQsIHlldC4NCmh0dHBzOi8vZ2l0
aHViLmNvbS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvaHcvaW50Yy9hcm1fZ2ljdjNfZGlzdC5jI0wz
ODMNCmh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1t
YXN0ZXItdjYuNi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaSNMMjI5
DQpJdCB0aGluayB0aGF0IHdlIGNhbiBkaXNjdXNzIGl0IGluIGEgbmV3IEFTVDI3MDAgcGF0Y2gg
c2VyaWVzLg0KVGhhbmtzLUphbWluDQo=

