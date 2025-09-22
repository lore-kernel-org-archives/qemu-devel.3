Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A4ACAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gyx-0005b5-4G; Mon, 22 Sep 2025 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v0gyt-0005VV-0e; Mon, 22 Sep 2025 09:53:27 -0400
Received: from mail-francesouthazolkn190110001.outbound.protection.outlook.com
 ([2a01:111:f403:d207::1] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v0gyp-0002RW-PJ; Mon, 22 Sep 2025 09:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZnDg/+IFLJ+9WkDFV3Ean8d+swtdDa340UocmrEpJNBvEu5tXpNzpDIadT8y2JB1n6VKab8oGkyql4rBST036UpcShQmybdJXhPxphng7k3ngmVKcW+l1FyThhU3hfBVb1iydXUrDZK+Z2gBQsnYMTZtk75riPjOmnbte7NEpf150snNBYR7PcejR6WbiyO2i2wXOBmnK9In5m6uz96tET/ZlKgII1TdG1oPCRA4edYImBjjMvB+G3qPNucPzER1W4igaSHNxMq27e7O+lZvD567uvj1l87lu0b7PfgqQkBgb6jmsQQMwQvbuiuCnleBoVTG7GTGfOdiWr57VDylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa2yoL5C/nkbxervRbJoPDRnsVt5zUjHXCShEqQZzlU=;
 b=wkcuQw4Jwk425xUM5MF2itdXZZuJjuKvYn8miUeBKtG+6NtOCiZuIaOytnOoCcPnf6OxRV75vXyT+FClcobGuiAR3R/RTpGoxraVxzpTxrDs+p1JR4tysssMiWDODz1CF+639AN20jUXeogVtVuUMh7N8eb07p7pC3vhg0Oec8BTRf+LVuIvV5G40Xi+D5v1zwMYCXlMC4nS7uK68f93bSIn/7UZ7eh8U5BJ5HNyX9Vhny9AnzzMVYmChxnL/Xmn5RtOneA4fDGsWbDV0WlcGWVpHhZMRgFUyFAPYxix4nqQY3Fd54Fj4alIPM7Te1uqsneJ+RBr80aAHe5uI31sZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa2yoL5C/nkbxervRbJoPDRnsVt5zUjHXCShEqQZzlU=;
 b=cQjPQoZItu2qV4ylm2nuePXJQbnj0X1MHugqWZWFiSp566aPAoGGKHKjV3Ch1K2WKEeNLYBwx5bOY1+isHNSd1U/Df9wSei+ITzsCAorFfURcqNvNm7QYnzDCXfiA8UZ9fnGRmWpsEGLxfLLGhwDKAM7o71wVzSwovqfSvh4oDZ/K+u2X/q39CUF7HWaM9UU85k4jbBnyntzy+grkaAYb/98osb9tMTC9rxQVXfMnd6v5m8yPw2jJA6IVHJd8GRQph30VWmCkqMPCb5ya0E0csCLBLE73Uya9eGzrgbp9gXNxv2WeR6jsbNrvWSAKi9Tw7vGQCLaJ6K8zKQtGTbXXw==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by GV4P195MB2721.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:28b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 13:53:12 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:53:12 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] ui/spice: Fix abort on SPICE client connect
Thread-Topic: [PATCH] ui/spice: Fix abort on SPICE client connect
Thread-Index: AQHcKnD0JExuOLRl50mSeAPDIkXVzbSewnoAgAB5D4A=
Date: Mon, 22 Sep 2025 13:53:12 +0000
Message-ID: <63C0F33A-64A6-435C-A246-ED4003EA4EB2@outlook.com>
References: <A759ECC2-6B53-4B3E-A005-7D06BA403FCB@outlook.com>
 <CAJ+F1CJg9wjcs9SuNfA-gyfUCSs2w9j9kZ-fRuO=tLLwVMY=7w@mail.gmail.com>
In-Reply-To: <CAJ+F1CJg9wjcs9SuNfA-gyfUCSs2w9j9kZ-fRuO=tLLwVMY=7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|GV4P195MB2721:EE_
x-ms-office365-filtering-correlation-id: e583ad0c-88d3-4e68-9224-08ddf9df5f1e
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|31061999003|15080799012|19110799012|8060799015|8062599012|3412199025|53005399003|40105399003|10035399007|440099028|102099032;
x-microsoft-antispam-message-info: =?utf-8?B?ZVgyTUhEanF2UnlHdHdxQ1M5L0FWVUV1SW82V0xCZ05UR0xmU21xWSt0eXFC?=
 =?utf-8?B?cTFOaUdYazRCMXdZMGdKZzdwMUYxdnNVVjBvMnIyMFYrU1ZWdmpuVTE2d3Nw?=
 =?utf-8?B?bzNQRHhleFpDaUtrTTEwSmdVQjMxODhnOFBJRUhOZzVsZUdhdVhSaEN1RFJ6?=
 =?utf-8?B?dUhTQ3ZSS1ZvcXloelIwZ1FaUmkvUnMzaEJqMC85RUxKVDZ5bWwrVWhiZlpP?=
 =?utf-8?B?WjZEVGpZck9OdUhveFhoMklPcEg4cm85dFRTejR6blYwWnRZMWVUTzd4WUpO?=
 =?utf-8?B?YlZtTzg2bnlkRS9sUmsyMU9TbEtyc0dJZ0gzV3U1UVYrTFEvUEdGaUJUcnkz?=
 =?utf-8?B?T2J6aVZFZDNLYWhDRjR1ZE1zcnhxSURobEMzekdleFFoNG5MVVVMSzNBcy9q?=
 =?utf-8?B?SUwxejlxalZYZW5IZ0JoVWI3RFIvNXYvN29EbzRoSUIxOENIdGYrSUZ4Ym5Y?=
 =?utf-8?B?NFpnbXR1VTB3YTQvanNLa2dWVzhCSzR2RldHQXAvZU9VN2gxZ2g5c2x0aEdr?=
 =?utf-8?B?Z09GSy94NFRIZGJkb05hV0hoV3prQTVBTytNcWFWa3B5Y2hZMW9KaUY2U28v?=
 =?utf-8?B?NUQyb2FYOUpmZXorTk1RVHdQNDlFTGlmRldNV3QzemUvT3lxZjVRVkpiS0o3?=
 =?utf-8?B?SVlxR1VXL0s5alFJcDljTjBUQ3Z5L25kQlpHR3NKU21QOHpkZDFxdzlNTkFM?=
 =?utf-8?B?VGlPYnVvK3hjSzQxTnQ5a1ZqTGZuTy9QR3hNK2NGSmdLVE9JdEV0MDRUSnc3?=
 =?utf-8?B?Rmp6bEgveUJKSVJHS3hHNTNJRW92UjhLSERiMmw5MEgxdU1qQWoyanBMWUV6?=
 =?utf-8?B?TVduSlZnQm5RY0NvYk1lVjArSStUNjF4eDZ3b3I2ZDM3c3gyVUV6dXVTbXBE?=
 =?utf-8?B?NzJBZjl6SnBBMEV5ck4rNktUOC9YbFNzT085elMxdWp2ZVlyaGdHakdSQ2Iz?=
 =?utf-8?B?ZVZSdkxoc0dPSVBBa1VIeHpIV0grQm1ZdzBCZjV2NUk1cHQxNU95UlVaT0wr?=
 =?utf-8?B?SG9mNndxRjdSclI0MTh4S3FhZHV6L3JJMXlKZFA3MTQ3QTg1MWk2b2RaUGZD?=
 =?utf-8?B?MGlrWkJYanR2VUxqcjZhMVhpYlVWY0RyNHUrL1o2OUVacHlZUFJqUXJqNlRm?=
 =?utf-8?B?QkNuNXFZYzRjdzRmUU9lcENGcm1wd1hpTG5BME9RM25Ic2JzeXlkWS9aRmtY?=
 =?utf-8?B?b0pjZjhyOTExRGhQaFBQU3VHSlRjVEFHTm5mN29jK25kK0U3NHZ5UWkvNE5S?=
 =?utf-8?B?Tm1vZlpDK3ltVU1obXBVbFdNSVUyK2ZTUG9CVWQyQmM2UG9rZmNrWVpQbEJB?=
 =?utf-8?B?c1REL1hKWXBxeG1CRGM0WTcvZkFvUm5MZWZzZXh3WFIrWWVxL2VndGhlVksr?=
 =?utf-8?B?WjB3ZUl5dTlOV0JEaFV2VVRSSjg1cFV2WlEvL0VaZ3ZPMUtKWFVLcHp5NWxB?=
 =?utf-8?B?VDE3Q1FhWFplL2c4YzlWN0NrTmIxbzdUbHhJMkdrNXhCN2hla1QzMTVmMW5a?=
 =?utf-8?B?NUFUajZpZUsvc1FsdHZxREt1S2p3Y243RzVlSnN0Vk00Y2FKQ0VObjd3bWJt?=
 =?utf-8?B?aS9HMHVtK1lzWVNSa1pzTFdiczNQc0JkaEtqQzcwOFd6NjU4cFR0SXNrZzVJ?=
 =?utf-8?B?a0NubnRCQTdKS1pmR1JnZVVmZzYxZVpqRDhlT2JreE5JK2hpdzZSWW9LUjM4?=
 =?utf-8?Q?FUOMUDZ1I1b7QVTs3Wup?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z29QYWdveVg1UEduc1laQjRPbFR1ZGk5NFVLcmpPRlRZanNQL1hFMStqb3N1?=
 =?utf-8?B?OG0vcW1ScFBIcENaYlpzdlpidDBqallwTzhNU0dOc3JpZ1VEM3hYak1CZm40?=
 =?utf-8?B?WFpVM29sOGpiZUIwaHhTZms3RUkwL2FSYXV0cHY2RjVYVlU0VEwrVm1wV1oy?=
 =?utf-8?B?NjYrcDkrZkwvejNLdzZVQlZaZ3RZVjAxczlmbjAzZTkzSjVHUHhJQlJ3Qk1v?=
 =?utf-8?B?eDVORUhmdFNCdlZ2bUIwUVdoTG9TTkZRd3RCNWFmRElLaGJZNEMzbTF2Vksy?=
 =?utf-8?B?VS96M1FGYUxHbHBrSTV6NCtXdm1iVXU2ZzN4ay92aG9aeHc2bTBVYlJCSHJv?=
 =?utf-8?B?UW1rUTVNbDZOaHZ1MG5YUHJtL3dQMGxUWnJzL1hzaW5xS1NnSUZrNko5eFU0?=
 =?utf-8?B?NUJ3Qy91andpK3BVKzFSZHNocGFkTGNBRU41UFc4TktMUGFoSU1MbDNjTy9X?=
 =?utf-8?B?U1hJQTBrMEhtUzc2clFXQU10RlBJanQ4THlpOTVmNGZNUG1NSGhNSVdPQWZY?=
 =?utf-8?B?ZVU2SWFsOGZlMldqWmhUZGpPM2g3QzVNRkp6ZW83cmxYbG9aR2ZLNmxGa2ti?=
 =?utf-8?B?YTZORU5LTVFLejV5aTlxMENPSG5MSFZoZ09UcFp3UGtLUktmZXYwMHJ0d1Ri?=
 =?utf-8?B?QXpJRk9MR0IvNlZCQUh3OFV3ZEM1QmRacVpENXlBNW1CSlpCcDdPbUVQRFhh?=
 =?utf-8?B?SmF6d1AxellpZUlTejkxMWRjVCtjQmw3Wk5jczZ6azAzSW1TbVRReWRIdHMv?=
 =?utf-8?B?Y1VPRDRaYngvdSsybzVGNDJIMzFjekdEOURNYVdkdGtQNC9GK3RzcEVFK2xC?=
 =?utf-8?B?VGljaWI3REZOMG5SWkJFaDdwbW5SanEwR1czU2pnMzdjNmk5U2FubGkvNXl0?=
 =?utf-8?B?YXJIWTJyVHZTd2dRN0xQMC84bGNwbURIeVo3cUNYN2dtR2JaeEhldE0rMVBE?=
 =?utf-8?B?U2JnM3JjNjJTOEZXalF0WnpGKzVSdlZRZnNSQjlmU0tNakRPalBFd0EyRm5D?=
 =?utf-8?B?ZWJPTzA0T2JPdFZCN3dZRzBGMzh5aHl1Q1huT0xSU3pJSHMwSU5TeU51cTFV?=
 =?utf-8?B?UGtzYWdheEZZWFNLZEZ0V2hZd215MnoycldvUVVVVFRYV3dhVXduY3N3NTVk?=
 =?utf-8?B?UnNRMG1tdjlMS2RvQ2w5cks5UWVzRkx2aDhVcjJsWVBPTnE2QVlYaUJpME9R?=
 =?utf-8?B?UGtRTHhVNVdBQmVraisyaytIUThWb3p2QzdUK2Q0MXptd01aV1pJNEhLeGJh?=
 =?utf-8?B?M0xOMDcxUGpmVi8vVTBkcCs2RUw3ZjI3SWRWc2pQR3kyWjRYcEVFRkFZNWpw?=
 =?utf-8?B?bUxjS2NTTUVMd3RSNGpzcjU1ZDhTUGMyZXB2Zk5oODRudklTVTlCQ3I1QVhq?=
 =?utf-8?B?YzNjS2lWSEN0ZjkxNG5uNnUzc2E1ZWtUNzl6d01QaHU2NElhb3hVOGs3Um9k?=
 =?utf-8?B?aEhxYlR3ZHoxVGhRL3F2RDA0NnN3dndIMFVtb1ZLMUhndlk2dVpzRzNsK0RK?=
 =?utf-8?B?UWdrL2M5MDlxVVpKK0tMYVJCeHNNcHNkaVNvYVV2QTZBMm5xNlBnQjZwc2dv?=
 =?utf-8?B?azY3RnBzTElZNS9lcnhSWFBmUWNIL2ozMEptQnY3c3A2TUxzbnJLSFVQSTFl?=
 =?utf-8?Q?pKk/MoszlAwqajHwBQeRcn/7VFy89Uyav5l0aZYGsOsI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09D1D94C96865D48BD7FF0B6DBE4946C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e583ad0c-88d3-4e68-9224-08ddf9df5f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 13:53:12.4895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB2721
Received-SPF: pass client-ip=2a01:111:f403:d207::1;
 envelope-from=mohd.akram@outlook.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNCj4gT24gU2VwIDIyLCAyMDI1LCBhdCAxMDozOeKAr0FNLCBNYXJjLUFuZHLDqSBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IExvb2tzIGdvb2Qu
IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBvciBhIGJhY2t0cmFjZSBvZiB0aGUgYXNzZXJ0aW9u
DQo+IG9yIGlzIGl0IHRoZW9yZXRpY2FsPw0KPiANCg0KWWVzLCB0aGlzIGZpeCByZXNvbHZlcyBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMzA3MC4NCg0KVGhl
IGlzc3VlIGhhcHBlbnMgYXMgc29vbiBhcyBvbmUgY29ubmVjdHMgdG8gdGhlIFNQSUNFIHBvcnQu
DQoNClRoaXMgaXMgdGhlIHN0YWNrIHRyYWNlOg0KDQpUaHJlYWQgNCBDcmFzaGVkOg0KMCAgIGxp
YnN5c3RlbV9rZXJuZWwuZHlsaWIgICAgICAgIAkgICAgICAgMHgxOTJhNGUzODggX19wdGhyZWFk
X2tpbGwgKyA4DQoxICAgbGlic3lzdGVtX3B0aHJlYWQuZHlsaWIgICAgICAgCSAgICAgICAweDE5
MmE4Nzg4YyBwdGhyZWFkX2tpbGwgKyAyOTYNCjIgICBsaWJzeXN0ZW1fYy5keWxpYiAgICAgICAg
ICAgICAJICAgICAgIDB4MTkyOTkwYTNjIGFib3J0ICsgMTI0DQozICAgbGliZ2xpYi0yLjAuMC5k
eWxpYiAgICAgICAgICAgCSAgICAgICAweDEwM2E1OTdhNCBnX2Fzc2VydGlvbl9tZXNzYWdlICsg
NDY0DQo0ICAgbGliZ2xpYi0yLjAuMC5keWxpYiAgICAgICAgICAgCSAgICAgICAweDEwM2E1OTgx
OCBnX2Fzc2VydGlvbl9tZXNzYWdlX2V4cHIgKyAxMTYNCjUgICBxZW11LXN5c3RlbS1hYXJjaDY0
ICAgICAgICAgICAJICAgICAgIDB4MTAwZDExMjgwIGJxbF9sb2NrX2ltcGwgKyAxNjANCjYgICBx
ZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAJICAgICAgIDB4MTAwZTYzYzljIGNoYW5uZWxf
ZXZlbnQgKyAxNjANCjcgICBsaWJzcGljZS1zZXJ2ZXIuMS5keWxpYiAgICAgICAJICAgICAgIDB4
MTAzZWM1YmE0IHJlZHNfaGFuZGxlX2NoYW5uZWxfZXZlbnQgKyAzMg0KOCAgIGxpYnNwaWNlLXNl
cnZlci4xLmR5bGliICAgICAgIAkgICAgICAgMHgxMDNlYWE2ZWMgRGlzcGF0Y2hlclByaXZhdGU6
OmhhbmRsZV9zaW5nbGVfcmVhZCgpICsgMTcyDQo5ICAgbGlic3BpY2Utc2VydmVyLjEuZHlsaWIg
ICAgICAgCSAgICAgICAweDEwM2VhYWI5YyBEaXNwYXRjaGVyUHJpdmF0ZTo6aGFuZGxlX2V2ZW50
KGludCwgaW50LCBEaXNwYXRjaGVyUHJpdmF0ZSopICsgMjQNCjEwICBxZW11LXN5c3RlbS1hYXJj
aDY0ICAgICAgICAgICAJICAgICAgIDB4MTAwZTY0MDFjIHdhdGNoX3JlYWQgKyA2NA0KMTEgIHFl
bXUtc3lzdGVtLWFhcmNoNjQgICAgICAgICAgIAkgICAgICAgMHgxMDE1OGRhMDAgYWlvX2Rpc3Bh
dGNoX2hhbmRsZXIgKyA2OTYNCjEyICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAJICAg
ICAgIDB4MTAxNThjOTRjIGFpb19kaXNwYXRjaF9oYW5kbGVycyArIDI1Ng0KMTMgIHFlbXUtc3lz
dGVtLWFhcmNoNjQgICAgICAgICAgIAkgICAgICAgMHgxMDE1OGM4MTggYWlvX2Rpc3BhdGNoICsg
NDQNCjE0ICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAJICAgICAgIDB4MTAxNWI0NDZj
IGFpb19jdHhfZGlzcGF0Y2ggKyA5Ng0KMTUgIGxpYmdsaWItMi4wLjAuZHlsaWIgICAgICAgICAg
IAkgICAgICAgMHgxMDNhMzViMGMgZ19tYWluX2NvbnRleHRfZGlzcGF0Y2hfdW5sb2NrZWQgKyAy
MzYNCjE2ICBsaWJnbGliLTIuMC4wLmR5bGliICAgICAgICAgICAJICAgICAgIDB4MTAzYTM1YTEw
IGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoICsgNDQNCjE3ICBxZW11LXN5c3RlbS1hYXJjaDY0ICAg
ICAgICAgICAJICAgICAgIDB4MTAxNWI1OTVjIGdsaWJfcG9sbGZkc19wb2xsICsgOTINCjE4ICBx
ZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAJICAgICAgIDB4MTAxNWI1MGQwIG9zX2hvc3Rf
bWFpbl9sb29wX3dhaXQgKyAxMzINCjE5ICBxZW11LXN5c3RlbS1hYXJjaDY0ICAgICAgICAgICAJ
ICAgICAgIDB4MTAxNWI0Zjc4IG1haW5fbG9vcF93YWl0ICsgMjIwDQoyMCAgcWVtdS1zeXN0ZW0t
YWFyY2g2NCAgICAgICAgICAgCSAgICAgICAweDEwMGQ0YWU2YyBxZW11X21haW5fbG9vcCArIDYw
DQoyMSAgcWVtdS1zeXN0ZW0tYWFyY2g2NCAgICAgICAgICAgCSAgICAgICAweDEwMTQ4MmFiNCBx
ZW11X2RlZmF1bHRfbWFpbiArIDQ0DQoyMiAgcWVtdS1zeXN0ZW0tYWFyY2g2NCAgICAgICAgICAg
CSAgICAgICAweDEwMTU5M2ZlYyBxZW11X3RocmVhZF9zdGFydCArIDIxNg0KMjMgIGxpYnN5c3Rl
bV9wdGhyZWFkLmR5bGliICAgICAgIAkgICAgICAgMHgxOTJhODdjMGMgX3B0aHJlYWRfc3RhcnQg
KyAxMzYNCjI0ICBsaWJzeXN0ZW1fcHRocmVhZC5keWxpYiAgICAgICAJICAgICAgIDB4MTkyYTgy
YjgwIHRocmVhZF9zdGFydCArIDgNCg0KUmVnYXJkcywNCk1vaGFtZWQNCg0K

