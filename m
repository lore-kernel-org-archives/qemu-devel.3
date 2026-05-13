Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC66CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2Ns-0003pf-M2; Wed, 13 May 2026 01:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wN2NW-0003gJ-Th; Wed, 13 May 2026 01:43:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wN2NS-0006xR-4d; Wed, 13 May 2026 01:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGM9ohp4csz+3A/X3/qr59i0EvI6UIEVtmuQV9oD+6L/v6cqc68DqXOUjTVHmtKs1LfToxmPbuXllZEiQnU5bqGXgmucTnBNjC2UBsAl+N8IcIrbu2OKd8JAy14v8v6gTXml0JLTaDU76JpNxV901GGmBHnxu/FOaGkxCsm0MdcVnSaWEQ26dW1mptzi2BogD8D7qkg2epr/b1QgmpLwF+1m/Zon9/qRXzSrlqKoIqniXO/bLmW8dX+m9syb0pBG2Ssa6HbVKwDwAsh0hA5V+AnKniEh+Xd79KrKf7AP1pRsnqNbUWwUiU5mzYHVH5oTfiSB0uYxB9G4MD9KqKbsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORafwNh7Whk5NM+fy0gUwFsARVD8+uzSloyZ3Xt+owI=;
 b=xCMxiAdSMIZ0Ud8gM1SwdHDWsUyVh75SgXHbZVYfdspBaDCvbwrATO/cHbrDo88iJhA3hI1nUCog9bJfmgxe637doer/YdW5iXpxrKkC9fGeOh/M+4f0QsUWlIMIvQFiu+YF0SvPso9Xy44BB0I22CY51Yl2V9P+M7mu5/LDLowQsQZTi69Nw0aBIjv5s808HXMhVMk25zTrYmUzO7RfnEB0K8JlbFIn8kBpO744s7ERd3J+5s5yd8UFndt5MBYO81j8HLtFG9uqUA0ytkZzrGEaPi5aeSmLyV0HWYKzoM74nkUCGGjXC597My92Sm7r3FOo1NS0rh5Zm/xpxl/aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORafwNh7Whk5NM+fy0gUwFsARVD8+uzSloyZ3Xt+owI=;
 b=Wn7YkJ8goD5a3egF512qcfnCff2uVqGaLqjZIzSSNwrEX5JOtT4sy/EE3gt4okXATV3AqbjFudDOiwAVOQ2TPeeYhOgQg88bZTT/WLqN+YGPXkhwmM0im5Ac1j3pBS6uzT0g+shCmzIjXDr8INDTf/8uPYfrt4fDZ8ZDVYJ4vIpchJLfi3Ise5dCawonsLPP0bv8stC9D2ll8GqIKvhmWYTdhiXSyDb0PDj6YijvmCZadbEvBLquWwjYWOvt22ury5TYi/xU3iQ4iNibe/CtVA1xnrxwzpdpRwu3kr0WKJgsPGL4/JbdADvVmNSaumgHbs0bo0+CqfR7sSVCZZ/KBg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5766.apcprd06.prod.outlook.com (2603:1096:101:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:43:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:43:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
Subject: RE: [PATCH] hw/misc/aspeed_scu: Fix AST2600_RNG definitions
Thread-Topic: [PATCH] hw/misc/aspeed_scu: Fix AST2600_RNG definitions
Thread-Index: AQHc4pqtaobPs8eQi0WTEkwJStajgbYLcSBA
Date: Wed, 13 May 2026 05:43:14 +0000
Message-ID: <TYPPR06MB8206E78368A38031947092C1FC062@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260513053749.132759-1-clg@redhat.com>
In-Reply-To: <20260513053749.132759-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5766:EE_
x-ms-office365-filtering-correlation-id: e30d6840-0915-41aa-b9d2-08deb0b2870c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7d+sD8Ul7HV3Xv8CuJpgVleocjbLieR9vHsPyLerffB3xe9H4tZu0mHOPxD8OS+PbdBVfH0dd7tnAO/ie0Dt6Flp/aIgDzvV2GVuSxCUJYiKP0FIXBhDDQV1Azu2fZvkqfpE9a1UtKTqiXAIPQl+aZYH8Z9IGLgOOT21YuseDhELFVjGUzthJPZ1/ii2EC7ywTbtH5x9hCiyVRhgMjiivCYjxGeKW1q4x/H6HKWpKaPlaHB3GdZZlOED+yKOVFQyre8rZTqTA5REwxUAr98sydueKbSLYYG7ZwWgiGVE5M5SswRqvtYByUbo/DMQ2Gist2IDvuqfzb3QDrwSpniyQete+0egy31mlrw+W2NuKyIACka6lKzpH7+UcxOFYbxFXRcO2uLi2rQF69Mbc1GMbCWq+xRq8sFYzKtsW58vdy2kJD0QfEk0w04vuYyac+Bwssk+lAhvtYzL4Z1thUvBteFd+hkdjm4qcTz6YfnngFtVe5IDZEa7ou5Xcp1LZg/Gx6f5RRgneEncbQXrEuHHUHpy77ig2xU9vvunYQipwXJac9U/mcC3B8vke8wxrJm2Y771Scyqj4i9+zCEUCo6WEIqouR5GM2xz/ki2yt9PPhl9LcIf/YI00TszvLiZzfaP3+nw99PlfrpaYyXmXzPDxeEkOpy4PJGgSVBMSWEETaf7LBSmYNkh6LLOIUuV81sL4VaZyap3c3WCEgDrlf8r0Bw0GDWNqvjYVMOM4g+mquTEoabdDUbrqOo8gGkEqkz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdjVDNzUGhDMjJJRWxrRkdVT1BndzhnU2hMRzJ1YWJ6VWplUy9KaFduYmhK?=
 =?utf-8?B?ZkdkSmdJN1A1TCtFeGpHOE1Jek5GbXJXbjNzQ3NrOWZPSjZyRlpLUDJBNSt2?=
 =?utf-8?B?UHNyNmVmYjc4TjlMY0J4UkQ1YmJkeisveW5TK2ljd04wNlhpUWZxbWlFOWhG?=
 =?utf-8?B?bzJrNUJLTGI4OWJERzJ5eHk5SndPWndobEZhdEROQ0RUam9sTWRIWDlmTWMw?=
 =?utf-8?B?TVM2RkNrY3RKaTNlZXQvb0RtcS8rWmN4ZCthK0pPSi9Ha1ZZeC90ZDNnSHdx?=
 =?utf-8?B?WGlRM0padmJmSm02U1Q5bGxQTGRlWElJSEx4OWdpVHNnYnhiWUxJb01aZVpQ?=
 =?utf-8?B?QTNJZnczQm9KTitmZDV4NTh0K3dHTjZDbVpaS3BvWUpvQjY0YnAzVnBpaTJt?=
 =?utf-8?B?YmEyZDBidEZna3Z3Qi9MNzdKOE5lK3o3Mzh5SnlVYkw1bUxoWEU0UnhpMlBu?=
 =?utf-8?B?d2NCanB4NzRCMHpWS2xNL1RoUk93Y2x0YTRYV0RPVlowTENRUFZGMnh0WlNU?=
 =?utf-8?B?SGVuZE9tY0swZm9BWDVlUnRQdHVzWld4ajJzdmd5ZDlwUmc2Q0JvQ2hHYWUx?=
 =?utf-8?B?MHdnOExVUEYxN2hUZW8ybTdnWFBSZWZ1MllXVjI2LzZ6VURQQ2NyK2ErMzkx?=
 =?utf-8?B?YlZuQ1lNMUVEM0J5d0UwQkU0WGFoQThTZkxaNGNCMDJpUjZ3NWh0RGFDRGtI?=
 =?utf-8?B?TVRCTzEzWU1KR0FQWFh4YTdRVnliZ1g4WlAxUFg5QVVhTjFEL01CaG9xWVp6?=
 =?utf-8?B?cnpQNkF6NW1ZTUt2czhYckttTjZRbnZBcDRtSFNhaWRkVU5YS0FQaEllT3lp?=
 =?utf-8?B?Z1Qxd1hVL1NOUyt0QU1RRmx1K1Y2VFp6ZE5oNnZ3cWduZ3NaZStRaDgrM0s3?=
 =?utf-8?B?NzlVUkQvQWRkNnhVSUFOTzdkSFVFMm5nQXZjdStaYjkrUi94VktDa3dDMXFR?=
 =?utf-8?B?cU03RGZnUlgvUXpsRDFneUR5SWZLOFdRN1FYNUxsNjJ6SkJrMUMwTDU3bEdB?=
 =?utf-8?B?MUJQR0hDeDdMWHRjMVFmSUFFa0VmVzB4M1RxLzJ1aU1ZeXljOU13K0hHNjlZ?=
 =?utf-8?B?N0tRRVhUTmYveGE1ZFYxbVJnVzN2OTJla1hjaU5SSUU4WjNGSm1NOC8xTXN3?=
 =?utf-8?B?QUNSSUhhd0pOeHRjTDU0V250RE9sbUpVOXVVdnY5U2ZhcDJDQUZVMkVQUDNz?=
 =?utf-8?B?ajNSQUhBY0RsY3VtcUZrRWR1Tlc2MmViTWpjblJWaXNyK2xydmhaUHFURWRk?=
 =?utf-8?B?M003bDgrWm43WW4wQzlTMmZqK1MyZFhKRmMwQllOaHllRW96NHJMeVBiTTlv?=
 =?utf-8?B?Z2duYnozYWhzcTZGV3pFdjR6RkJOazQ1T1NjcDBTdmMyUWxmRnhFQ005WEhW?=
 =?utf-8?B?MlplbmIyQnp0VFpGTjFrbUFnRkpZeFdkdUVPbFhqV0dqR2ZNdUYwQkZPSjdy?=
 =?utf-8?B?cFFhMEI4YWdzQUFKWURNdGhXZ0Y3bzgyRXZPYUU4SVFuN3FRTVozNjZucXQz?=
 =?utf-8?B?Z2pyS2RQYUFhRWhKOU9HQWg5VzlMcitBcCttUTFvUGlFVXBLSlFZelBrbHZX?=
 =?utf-8?B?VXZTWlRWWkhWK3RmWDBpVUhZRVI3N0N2UTFXUnZudkJidnJzYXNjajBtWE9x?=
 =?utf-8?B?UEJsRTFxT0hTWWk2RHVNQ1BnZFNZR3JHQ3Nmb280ZmRHc2hvMkEzdXN0ek1i?=
 =?utf-8?B?L24wbnVlZW5CekVkOFAzSEp0ZCtRNC9oclBVYlk3d2FaQU0yK2JhMXU3c0NF?=
 =?utf-8?B?RUFmKzY1Z0J1elJPeGFuNmFVaGhaZThVWmdxd1l2ZXpwYmJ4QkRHek5NUDhh?=
 =?utf-8?B?eFh0dWwrRGxRNHJRUGFnWXVQR0R0b2VWVWw1OEJSRHA1TkM1b3dXKzJ4Mms1?=
 =?utf-8?B?UnVZWnQ2S0dNckQzbTFHamtsS2E1ajRPSTdDWDkrdFlmVjByZHQxaWRpYlJW?=
 =?utf-8?B?YWlCZnhSZGFZTndFV1hVa0pKdTRTTXo1eWpKcVltaUVoUTNReVAwaGlQVENo?=
 =?utf-8?B?MjhiaWxLejYxUVRCa3hxL21TYkxqdGhDWkd6Q2ViNFEwUTBNUzVWT3pNVERV?=
 =?utf-8?B?ZzB5VWNIaTg5aGxJVDZmamxnSmZESGRSY0VHZDhrRTF2S0Vic2JnSHkza1BB?=
 =?utf-8?B?YkRsVjc3NFVsOVN1Y1BiTkpYMStZODZYK25Ja29YY0V6QWNBWXI0Z3RXNnlU?=
 =?utf-8?B?SUJveFcwNkNObzlUR2Y4OXg2RHdEVlh6L20wb2NrUkVoQldubE9ablBUQzVS?=
 =?utf-8?B?RkZZRWZpbFpyaVN5bkpBUTJQRUkrREUybDZTaVd3SzJkeWJPSUdPNUlMSHE2?=
 =?utf-8?B?K1JtS2xUUlVORzZsclRjOEdyelRub0FSSGh5N0FUV3o4a0g1OStoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nIEGFHmColU9uJNtXQNNGmwRM1V/t28dTuTfAuoK9VC3M1yUAxYO7Y++eviRpBIw5g88iW7UV1W1vUeGC3zi3NRkNeKGbLumXKaEPcKL7kc5DlNmWnwjGjjWD7gtAS7WQoM6N3WXwsZ5cUpLPo5/wakqw/MBtkE1dDDkMn2A45E0Otq5ZGu8Rkb7mQ+f69j/3UCLIOVTeVjXhdtYx2v9dDyDbz4e3x+NKQSZSgEaoenp/m+zxRDN1Q52QnI6X8Xylpej2LFqfzLcWQMIvBturl2P5uUZGZ5akw39/L6vc03rafJMC8u1AZkB1u2WHnkOqzajyCe87Uuw/+Lk6JJwhA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30d6840-0915-41aa-b9d2-08deb0b2870c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 05:43:14.9166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cU6N6Hs84D3b4qWCuz39xMS4BkJKUTN3TjgmZprqx35R7jJwhK7B0LPT7UkOGsPvVm6cLDviG/KcvcmGegBU/tx1xuVbSRoCv8Yc/uZPbJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5766
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFtQQVRDSF0gaHcvbWlzYy9hc3BlZWRfc2N1OiBGaXgg
QVNUMjYwMF9STkcgZGVmaW5pdGlvbnMNCj4gDQo+IENvbW1pdCBlMDljZjM2MzIxZjYgKCJodzog
YXNwZWVkX3NjdTogQWRkIEFTVDI2MDAgc3VwcG9ydCIpIGludHJvZHVjZWQgYQ0KPiB0eXBvIG9u
IHRoZSBkZWZpbml0aW9ucyBvZiB0aGUgUmFuZG9tIE51bWJlciBHZW5lcmF0b3IgcmVnaXN0ZXJz
Lg0KPiBGaXggdGhhdC4NCj4gDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBSTkdfQ1RSTCBhbmQg
Uk5HX0RBVEEgc2hvdWxkIGJlIHJlY2hlY2tlZCBvbiBIVw0KPiBzaW5jZSB0aGUgUUVNVSBpbXBs
ZW1lbnRhdGlvbiBhbHdheXMgZ2VuZXJhdGVzIHJhbmRvbSBkYXRhLCByZWdhcmRsZXNzIG9mDQo+
IFJOR19DVFJMLiBBIGNvbW1lbnQgaW4gYXNwZWVkX2FzdDI2MDBfc2N1X3JlYWQoKSBhZG1pdHMg
dW5jZXJ0YWludHkNCj4gYWJvdXQgdGhlIGJlaGF2aW9yIDoNCj4gDQo+ICAgICAvKg0KPiAgICAg
ICogT24gaGFyZHdhcmUsIFJOR19EQVRBIHdvcmtzIHJlZ2FyZGxlc3Mgb2YgdGhlIHN0YXRlIG9m
IHRoZQ0KPiAgICAgICogZW5hYmxlIGJpdCBpbiBSTkdfQ1RSTA0KPiAgICAgICoNCj4gICAgICAq
IFRPRE86IENoZWNrIHRoaXMgaXMgdHJ1ZSBmb3IgYXN0MjYwMA0KPiAgICAgICovDQo+IA0KPiBS
ZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVt
cy8yMzUwDQo+IEZpeGVzOiBlMDljZjM2MzIxZjYgKCJodzogYXNwZWVkX3NjdTogQWRkIEFTVDI2
MDAgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVk
aGF0LmNvbT4NCj4gLS0tDQo+ICBody9taXNjL2FzcGVlZF9zY3UuYyB8IDQgKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9taXNjL2FzcGVlZF9zY3UuYyBiL2h3L21pc2MvYXNwZWVkX3NjdS5jIGluZGV4
DQo+IGU0MTYwMzU2ZTQ0My4uOWQ5ZjQzZTZiNTYzIDEwMDY0NA0KPiAtLS0gYS9ody9taXNjL2Fz
cGVlZF9zY3UuYw0KPiArKysgYi9ody9taXNjL2FzcGVlZF9zY3UuYw0KPiBAQCAtMTI4LDggKzEy
OCw4IEBADQo+ICAjZGVmaW5lIEFTVDI2MDBfSFdfU1RSQVAyICAgICAgICAgVE9fUkVHKDB4NTEw
KQ0KPiAgI2RlZmluZSBBU1QyNjAwX0hXX1NUUkFQMl9DTFIgICAgIFRPX1JFRygweDUxNCkNCj4g
ICNkZWZpbmUgQVNUMjYwMF9IV19TVFJBUDJfUFJPVCAgICBUT19SRUcoMHg1MTgpDQo+IC0jZGVm
aW5lIEFTVDI2MDBfUk5HX0NUUkwgICAgICAgICAgVE9fUkVHKDB4NTI0KQ0KPiAtI2RlZmluZSBB
U1QyNjAwX1JOR19EQVRBICAgICAgICAgIFRPX1JFRygweDU0MCkNCj4gKyNkZWZpbmUgQVNUMjYw
MF9STkdfQ1RSTCAgICAgICAgICBUT19SRUcoMHg1MjApDQo+ICsjZGVmaW5lIEFTVDI2MDBfUk5H
X0RBVEEgICAgICAgICAgVE9fUkVHKDB4NTI0KQ0KPiAgI2RlZmluZSBBU1QyNjAwX0NISVBfSUQw
ICAgICAgICAgIFRPX1JFRygweDVCMCkNCj4gICNkZWZpbmUgQVNUMjYwMF9DSElQX0lEMSAgICAg
ICAgICBUT19SRUcoMHg1QjQpDQo+IA0KPiAtLQ0KPiAyLjU0LjANCg0KUmV2aWV3ZWQtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpUaGFua3MsDQpKYW1pbg0K

