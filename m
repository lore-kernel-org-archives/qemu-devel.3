Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A72BC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x21z1-0005Qt-LI; Thu, 03 Sep 2026 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x21yz-0005Qf-UZ; Thu, 03 Sep 2026 03:35:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x21yx-0003L0-Ay; Thu, 03 Sep 2026 03:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOoLyY4XVonomkSG+Y0Sz1jxLdbm7zKOiMmZc5ye27eHO/fzLpHnV46r8xheoR3+fTc4xumqq3CdwEsdrdDcWfMugKVbVZW/anQ92kjWPUDNL/K1e9zn8DYI+K32kCfZJg9HA22OhXbgdPqcP9RSPBCbDQIKU+Y7ClB1K23doNQZX4A+11dl1BR9sNpwFiJxaOPdWnE3YG0R00k3FSe17jG9wgvnyG9w6eUZ2Q0kbQPVmpI87IVyyb348kiPJNRX6GBXQQ395Bw0K4OIGjkvraQ8+YOdj+/2W6x+Zml/UO3P3ZVJwaj3y9ov98xLSIFBkHPQ9l9GoWOlN/0gs/+Rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7cCO8sSUi6VDlAKgI6K1KbwX8BUu8X552SQwDA/dJI=;
 b=M+x7Os9dQzaUfbjOiqs3e+wyON1HwfUaGx9f9u1VmVuaJJ1SkhcA6zqyayjGdUhNATQYKtrQ//XtcGJyT4xShtLP1eMGyIg015NyEH0kl+eE4ow75M1bNu5MIOOf3vZyMKmjWGo1c8V632YDbwSl4ElaGlLZ8SAG+yG4p4EB+ufmWs66dmlIWKff/Yskdr6WlZmSIdvm3ASexUBdyS+pnLv3ydocugbGLXneo+Sxu6zojQOwusUDdUBp05jsqqdRH9hEdwyzrxo8+/62Zp3keDlYyMAIzqHUotfAZcuwCFGCtJYUTGl1okPueHIRVjDA/k+5fxB9NLF4GOLJZeokJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7cCO8sSUi6VDlAKgI6K1KbwX8BUu8X552SQwDA/dJI=;
 b=hV23kp7bynTyU4tRS7wpZJleEYwqJvtnxGBYSbvFE1eOnzCh1RFpguvKxxow+IZ/kJLuCJGxVAb6xtqzz6A+7T8jrwQeaIEy7e0H7WjqJiaPNcW6mZmD8YXLvYbGcqs4l5YX1exJGtWiVDwRT1hJOE0jJNMD3yAGjSaM5oqMj4SGYX1fJxv1tT3PnhQqwkihTGiZ83LGrWBBrzRrMGF6UgM5YrhtskPwWFJzhCQnVOnCWOGxELpHbpTqnpY+XKXfDRKk3bb5NHUmRU5TLctq4+V9ltBM7yfriHbTOaurdcYAk5OmzrVusBpA43W0c0mTkDJDgpGPjGTZc6xKBhnkng==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYPPR06MB7970.apcprd06.prod.outlook.com (2603:1096:405:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:35:25 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:35:24 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Topic: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Index: AQHdOQq+cBR9EwprsUu3rVJhF83igLa4AI+AgAD0sSCAA4KgAIAAAPYQ
Date: Thu, 3 Sep 2026 07:35:24 +0000
Message-ID: <SI6PR06MB7631B1B60297638BCF0E65F2F7B62@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-2-kane_chen@aspeedtech.com>
 <f60d0cb7-5981-4dd5-b65b-4a6e9b8a30ed@kaod.org>
 <SI6PR06MB76318928B02F6147B1DEC82DF7A82@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <4fcbb217-596f-4a9a-8b2a-ca7fb1de7743@kaod.org>
In-Reply-To: <4fcbb217-596f-4a9a-8b2a-ca7fb1de7743@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYPPR06MB7970:EE_
x-ms-office365-filtering-correlation-id: 19100f7e-042e-438d-6b6c-08df098deb06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|10067099003|56012099006|4143699003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: QEY9dAA95Au8Eed+cP0mkDjLzN6beFSKCShdGLvdezdsCJK3TXjvKPMqC19cXT5e51BIaIWi5TOaITLApd73XYonrm/Wik8LYPjh77cPBDyBDY9V+OuOfnMtUlhAu++SuVgpsMCguXktiPyBBtWtLv4Gs3IHO8d2FPOhzy2FXUMt/fFkog0NY/E/RxxGWtAHNqkF9YkvumTQaglECthhzrP7V+WSEA0I1ZvS0Pj76dgygdOjutw3VLmRboPo5Fhw+sihxiaADLBcQcCRLKhTcs0LEOi0goP3lqxiWVE7YTTKxkb+SRDQ59jL7y/nq+TxumKR0gBoZKWsnKQcXLqELzHLUQTq4SatmGv9OJprSnLp5ctsHeuF94GBIBiUubB1MGFz6znpQcp3X03J3H/ntxKYPCsEtt8E4gB3X6LEi3+Va6aZ72UHQaiMxmqIh/ytnnN2ya5IwpwkIE2xpfPGTRrZyCZioQS6xYhRkJ283+SDCwRoN9q8iohuh3QuODYUQ1VZ31p4S5dIBFpc0eTg+EuAmQ3xzCIVzQ2Q1P2a7eo7GuYm+K74ul2txsmUmKBFpRcwzVjishEQj5EtABeKmPs7pP+uyiu1mXCMspkdT0dX1V8taU6fliXk6oI9yT75I0d2ftNzyWig0VPbDB4tpKYQK34UMB10tRXErllf8gWZMTVgEz0vBeLX7sQ30GOcmnsViTWFTc2x/GbYUWVW91iD4/CEdDDD90M87SB3UfM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkdkM1FUZTIyYXR6M2JQRTVrQXNJSFNDYTlaT0pNTStGZnAzZmxDcm9UYXlL?=
 =?utf-8?B?MjVaa3BVSll4SFJBSEJQNzI1UmR1bVpxeDZhK1RTWHFyd1FPNHlUMDNSeTFz?=
 =?utf-8?B?QktXcnluVU5LUzNLUWJqREpNQjZTbFVtVWRLVW5LdXlFNGpzb0E5bzNzR1I4?=
 =?utf-8?B?bWVxeXdadUZTNExIK1B5R2pyTk9RLytUUUtYRWZPNnY0YVM0OHdtVzRUU1pS?=
 =?utf-8?B?WUQ2L3hldUlMVjBKcEo2MzRESGxGNFQrUXk2enppMDZxcnBZRHBIclhrVklP?=
 =?utf-8?B?eG1NOGNEclo0bTlBU0ltaEs1TDdYVzVGYi9xeFVJSW1CRForTlo4c2V0Rzln?=
 =?utf-8?B?NzZLZGNjMGttWWlERlFwMytETWtkRmF2Mi9JL0ZVQ1I4Vy9CRDNGT3ZNSTc1?=
 =?utf-8?B?YlgyQWk3TUZIVVRUbUZzNHhKQnpqeFNNN0dHb29Ud0RsbnhGdmhEbG5KdDl5?=
 =?utf-8?B?N0FKT0FBb1k2MVRTU2hwVlZhek5nMGUzUHRSZDg5RnFTNlpadXpCNUFBQS9W?=
 =?utf-8?B?QVAwQnJHZW9FbjF5dktUN291cjNMMnRWdzFjcG5BVGFUcVZtU0VxaU11cm5S?=
 =?utf-8?B?SFhQWHJPWU0rL2cyU0xPY09Hb1RrZEJ2aEFQQmNDNkRlQzBSRUxmaWFFdjRH?=
 =?utf-8?B?RG1MR3owWnl2eHdQcFNiNitMazhGQ2VRVnV0dk51RkpvRXVYT0dGV0xHT2ZO?=
 =?utf-8?B?QlpYcXhJNEsxSE82WGdXZEJEYzJoeG4rR2huQkJiYzBEK05PaTBEdjlKQWVE?=
 =?utf-8?B?Z2lINXEyd0ttQ3RyV2dCU1lBdTRYYVV2cjZoMXNBTEZ5TG5kaDIwQmlVSnRC?=
 =?utf-8?B?RUtaWVBXc09QT21Nd0hsajVjYXdVSTE4SDFMNnpUZnk5ZVlVMlFqQ2VyZ01N?=
 =?utf-8?B?dUlFSzNqMHB4VkNibkdUTGgrRjJha0docXJVb1pzZU1XTTRwc3JVY0lOR0xU?=
 =?utf-8?B?V09WMUxoQkpzdVJocE52Mk9wY0swbElZQVloU3VFMW9OWHdHb3pDZHVObTZT?=
 =?utf-8?B?STZWUXhKdlpjMmV3andNUlRhM25ybE9haUdKRWRkeDZ3Y01KSUN1ZFBJZ3ly?=
 =?utf-8?B?Tk4rS1J4eXQzcFZRMnhQZHVtMjlreHpOQzA5Wjc2Qno1UlEvY0I3eEZmMVdt?=
 =?utf-8?B?aWM0b0dvUU5Nb3VFRzdITEFhY1gzKzFuV2FKcktGZVpIbnI3NUxBOFVGNVRT?=
 =?utf-8?B?R3pNNVFmcTFNMVpyUWIyTGNhdmhSSmJGZ05DaXl1S2YzM0ZNTktsa0ZjeVZN?=
 =?utf-8?B?SFRpMUNCWVh5RjZVeWRPU3QxSk0xNDBQdE1pWWZUOE10WG9PbHZxL2hSNENv?=
 =?utf-8?B?ZjZlU05WRVVHbDJrRmVBRmlYSitsYVlLYzYwZmp4d1l0TkNBZGhnd2Jwd0ZZ?=
 =?utf-8?B?T2dkamtoS2RWMWc3VW9Ec0RSM2xpb08vZnp5ckJhRVRpZE5hcG9DcWo1OGU0?=
 =?utf-8?B?RG5OOVhKd2FmMHM3VGFIM0hOZ1RqM3U1d0NUT1F5UkhWTlhramFlTWo3TEx3?=
 =?utf-8?B?UEkzbHE4QjlJZkRIblJZbXNCSkVGM0paMW43VkYxQXRSUVZieWljV09FUk91?=
 =?utf-8?B?N1pRY3pvV21QeDJoa2l3RDZGK3ppVUUxN0FKQ3crakpqL2p5Nk1FamUyZTh2?=
 =?utf-8?B?VW9scHhEU1AvNUFDcUdZWDluWFFNWE84Mi9HZjcxcFE0VWl0VWVHbnl3MUJj?=
 =?utf-8?B?NHZVeFlXRTViQlFGRXJIVW4wWWRuVmtHMjV5NGp1bU8zNWFUeVhWUFcxQUd2?=
 =?utf-8?B?QjBHWGlCYkt5TE9WQnd0aEFmSEFhMEFvTFZVTjZwL0VmbEFUd1l6NEl2SVZr?=
 =?utf-8?B?OWdwRkk0bVd0TGV3UWd4RWRFS2ppVkRSdW1xKzJpWHhHMkx4VzlKc0lWV1dS?=
 =?utf-8?B?RjZPR3JSZjlBU1A3VVk2V24rcHVBZnR0a0hCTDVmd1g3dG0yQXVVc0NES1hn?=
 =?utf-8?B?ekNFQ0JGZEtsUmtSeEowb1huamc2T2duMGpMMGF1dmJBenlVbUozNTlGK0M3?=
 =?utf-8?B?cmxmd0daRm5KVW9QWVpEOVdKd1V2WWYyTm16dFFDaFVPYUdqem9qeDh1Tm50?=
 =?utf-8?B?cjlobXNjTmRRTk92Ymp2dGFyanJ2TXAwU3JINVpYMHNlZjN0WG5HTUNKK2tV?=
 =?utf-8?B?emhZZ0NkYkJweWU1aUlVWm13YmVwSWNkK3JjY0JZRVRMZkhWL0tTN3lCZVE1?=
 =?utf-8?B?Q1d1RWFIWkplWUE0cEVFSnBwVzdROXAxK3lFcE5hdG1MYWhPYlhvNmpzajc5?=
 =?utf-8?B?dmgwUStyV3o3R25xR0hqN3NmNjFqQXBKNENIeHNOVks3MUMrems2eFdwSlZ6?=
 =?utf-8?B?cWVDRitUOGlWZFVRWVEvY0xtUU9zR3owd0tuM0xJRmhLV1RFbzR2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l7lnH+63Jz/m2lukkCEV/JRVrPzabSOvvYQs4VLnn47MDAu/jpU9LH5FwK5yg0AYvl7s3oTEgmgr1Ht+FmMmfCPPFpDQPkzUlepZ6F/NG4rCEmYwxQ/ktiz9q/rp47FoI7NyyAx98USIWhC/Iz+5g02+z042qw518bIjCJMImkDF5L/2kEB5EmrSXTf3kC1FK+iXljReySCr/YCXqDvpqt5LZN4D/kQTNnmqouhtxFU+a1wJwXDrzi65sXRSdS/9DyySSiWWyX72DFyTgbzYge0pQ55DZhvjAJRg7ON9wc+BwV85kaiiBxcmtSWrPA7BvgQD+DE20JIr4rLlCMxEmw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19100f7e-042e-438d-6b6c-08df098deb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 07:35:24.7936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98DlpEC0mYcqKVK4Nue7pWqxfgrusLYrISUYZKhFbQYL0DQse9gh3tah9kU+dnAmTmo9a86Ki888WRiz9dVXCBPhHSy6a+3SZaK6NJFL2CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB7970
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMsIDIwMjYgMzoyMyBQ
TQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVl
QGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3
QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
MS8yXSBody9taXNjL2FzcGVlZF9zYmM6IERlcml2ZSBBQlIgc3RhdGUgZnJvbSBPVFANCj4gY29u
ZmlnIHN0cmFwcw0KPiANCj4gSGVsbG8sDQo+IA0KPiA+IEhvd2V2ZXIsIHRoZSBPVFAgY29uZmln
dXJhdGlvbiBjYW4gYWxzbyBiZSBwcm9ncmFtbWVkIGF0IHJ1bnRpbWUuDQo+ID4gVGhlcmVmb3Jl
LCByZWFkaW5nIHRoZSBPVFAgY29uZmlndXJhdGlvbiBvbmx5IG9uY2UgYXQgcmVhbGl6ZS9yZXNl
dA0KPiA+IHRpbWUgbWF5IGxlYXZlIHRoZSBTQkMgU1RBVFVTIHJlZ2lzdGVyIG91dCBvZiBzeW5j
IGlmIHRoZSBPVFANCj4gPiBjb25maWd1cmF0aW9uIGlzIGNoYW5nZWQgYWZ0ZXJ3YXJkLg0KPiA+
DQo+ID4gSSBzZWUgdHdvIHBvc3NpYmxlIGFwcHJvYWNoZXMgdG8ga2VlcCB0aGUgU0JDIFNUQVRV
UyByZWdpc3Rlcg0KPiA+IHN5bmNocm9uaXplZCB3aXRoIHRoZSBPVFAgY29uZmlndXJhdGlvbjoN
Cj4gPg0KPiA+IFVwZGF0ZSB0aGUgU0JDIFNUQVRVUyByZWdpc3RlciBhdCByZXNldCBhbmQgd2hl
bmV2ZXIgdGhlIHJlbGV2YW50IE9UUA0KPiA+IGNvbmZpZ3VyYXRpb24gaXMgcHJvZ3JhbW1lZC4g
VGhpcyB3b3VsZCBrZWVwIHRoZSBjYWNoZWQgU1RBVFVTIHZhbHVlDQo+ID4gc3luY2hyb25pemVk
IHdpdGggdGhlIGxhdGVzdCBPVFAgY29uZmlndXJhdGlvbi4NCj4gDQo+IENhY2hpbmcgdmFsdWVz
IGlzIGFsd2F5cyBhIHByb2JsZW0uIFVubGVzcyBwZXJmb3JtYW5jZSBpcyBpbXBhY3RlZCwNCj4g
Y29tcHV0aW5nIGlzIGJldHRlci4NCj4gDQo+ID4gRGVyaXZlIHRoZSByZWxldmFudCBTQkMgU1RB
VFVTIGJpdHMgZGlyZWN0bHkgZnJvbSB0aGUgT1RQDQo+ID4gY29uZmlndXJhdGlvbiB3aGVuZXZl
ciB0aGUgU1RBVFVTIHJlZ2lzdGVyIGlzIHJlYWQuIFRoaXMgYXZvaWRzDQo+ID4gbWFpbnRhaW5p
bmcgYSBjYWNoZWQgY29weSBvZiB0aGUgT1RQLWRlcml2ZWQgc3RhdGUuDQo+IA0KPiB5ZXMgc29t
ZXRoaW5nIGxpa2UgOg0KPiANCj4gICAgc3RhdGljIHVpbnQzMl90IGFzcGVlZF9vdHBfcmVhZF9j
ZmcwKEFzcGVlZFNCQ1N0YXRlICpzKQ0KPiAgIHsNCj4gQEAgLTExMCw2ICsxMTEsMjMgQEAgc3Rh
dGljIHVpbnQ2NF90IGFzcGVlZF9zYmNfcmVhZCh2b2lkICpvcA0KPiAgICAgICB9DQo+IA0KPiAg
ICAgICBzd2l0Y2ggKGFkZHIpIHsNCj4gKyAgICBjYXNlIFJfU1RBVFVTOiB7DQo+ICsgICAgICAg
IHVpbnQzMl90IHZhbCA9IHMtPnJlZ3NbUl9TVEFUVVNdOw0KPiArDQo+ICsgICAgICAgIGlmIChh
c3BlZWRfZ2V0X2Ficl9zdGF0ZShzKSkgew0KPiArICAgICAgICAgICAgdmFsIHw9IEFCUl9FTjsN
Cj4gKyAgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgIHZhbCAmPSB+QUJSX0VOOw0KPiAr
ICAgICAgICB9DQo+IA0KPiBpcyBiZXR0ZXIgSU1PLiBUaGUgU0JDIHN0YXR1cyByZWdpc3RlciBp
cyBhIHJlZmxlY3Rpb24gb2YgdGhlIE9UUCBmdXNlIHN0YXRlLiBZb3UNCj4gY291bGQgYXNrIGhl
IEhXIGRlc2lnbmVycyBmb3IgaW5mbyBvbiBob3cgdGhlIHN0YXRlIGlzIG1haW50YWluZWQuDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpIaSBDw6lkcmljLA0KDQpUaGFua3MgZm9yIHlvdXIg
Y29tbWVudHMuIEkgd2lsbCB1cGRhdGUgdGhlIGNvZGUgdG8gcmVhZCB0aGUgT1RQIHN0YXR1cw0K
ZHluYW1pY2FsbHkgYXQgcnVudGltZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

