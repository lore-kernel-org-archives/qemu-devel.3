Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248B5C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ren0m-0007lr-QJ; Mon, 26 Feb 2024 21:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1ren0g-0007lK-A8; Mon, 26 Feb 2024 21:15:58 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1ren0c-0008Nb-A3; Mon, 26 Feb 2024 21:15:58 -0500
Received: from mail.andestech.com (ATCPCS33.andestech.com [10.0.1.100])
 by Atcsqr.andestech.com with ESMTP id 41R2FUt0063864;
 Tue, 27 Feb 2024 10:15:30 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Feb
 2024 10:15:30 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Tue, 27 Feb 2024 10:15:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.40)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Tue, 27 Feb 2024 10:15:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fld59hGfVrSlg8C+6GGYLI7FTgtP1sBsNAr91SH5EUmlY58w7TxicO/pn+YvZI9FCMdO+Q5UBEz91awT0YeyxFDw+s73EL6F70E8oZnL7JmDVAdEx4ZG9Uf00vcWsmsVxbI7OR4vWgHYuAUsORkIqjSarlYTRjBjUaRkDYpn6GQF1UOVt+uhCRx+MYRah12qM8cJ/3g7LgRXkQWuAC36Iv3v5+MgGQzx3Iv5v9pDfwxQ2fPMlviHVAPtBkDsvAeWy57vcRJ3lX1MYx/XlbQR/z7RMkNfbNhWMtwE1vUS0qrJkc7rz/RgNxTZF4auwYB43ebJ+eHmhoAzOQQT9+H2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjHCq/h/8dVEPmn/3ZfdpVNf+HXylXJ4pTiUSibRRz8=;
 b=jcI7si5rUdL4EYtaPYw4khlygcr3Fkl5qbaMnbYPRutEwG5Js6NA9/BtKHDS9RLptuegQLcPHlDzWrNMEWbRzy3kS3YLaYqfob83yS+ggvsvRSjJfy9LTRJ1kIjHOJmVBOUtVoqB0L159FAGBKwwjwHS2dbyTitYdjt+V834CXemCDqElWS9uXJxylcNPQduNKGVJhlleOPprmjZHHe0P8r1qg5kHEoKaOfDIG0oNys13eqQCNWnVW4oinBzDnpZf+1p3FuroJ0ZL0V8kN4D1gu6SNX9fQ7rmDx5j21xLW+qt38itwwy7kBenkK6zCosog//aAGEOmzQ/4dn1buP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjHCq/h/8dVEPmn/3ZfdpVNf+HXylXJ4pTiUSibRRz8=;
 b=Cwn8XGDZS7fWg81o0kU4LWQC/aNM29rhvEjW0ZPZ+649yYHKlZ5aZxSL98TEJueHjKuqh37PZ/ESyV4I0mZPxN+8kz2muuT+TjufodSswMQ5hvSv3r3r83rO2A6K1vLm8TGHXCdkHJkbNXcovV67Pn/nk/H5bFvb+6mRstMVoayWnDFKMWU0FjSU9xtyQ7Z+Fe868pu6oDsUrVksvZbGG8X7EKvRbDSmlh3Ml5UjUJwAbjy2AnQz5RTMl+5u40REhCbXoklVxr1XpIBnqoy/3vA7dr4KG7nY3NTbEWYm0iy1nyLwdOaiMhjdL0JDNEB3ogp3S/mf7R66Z8NDRTgcVg==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by KL1PR03MB8240.apcprd03.prod.outlook.com (2603:1096:820:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 02:15:20 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83%4]) with mapi id 15.20.7316.023; Tue, 27 Feb 2024
 02:15:19 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v3 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Topic: [PATCH v3 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Index: AQHaaIKgW+ix7nbdGUe7E6rWZDSY77EdT0yAgAAlD1A=
Date: Tue, 27 Feb 2024 02:15:19 +0000
Message-ID: <SEYPR03MB670054CBDAB9055D0CE7AFC2A8592@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240226070825.51120-1-alvinga@andestech.com>
 <CAKmqyKM9914UJ-Fta=b-xuVoy8bQOWsZs=HqC4TsA9DUa69cXQ@mail.gmail.com>
In-Reply-To: <CAKmqyKM9914UJ-Fta=b-xuVoy8bQOWsZs=HqC4TsA9DUa69cXQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|KL1PR03MB8240:EE_
x-ms-office365-filtering-correlation-id: 0e402d96-62fa-466d-0dcb-08dc3739f1f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihF9UbmsxklzloEKVg1qd9W2OigizKwJccR2JarHfKYffw3XjHJ03UzBI+lkDYfe/k3OyBeHZONWD0imAaLo+542z+Jha0Aocvak6Iunyg3k/aM8BMd73fvbZNsmprRX44M8QdNdNQe3+5OCWS4U2xeXspbJtULpX15riiiuQHry7AhB7hLuquUlm/2w6BUtAX772qlJD+3Jf//obUYSm9FM+SPO2Bckbvk4pNJqa16Dr/SfTVnyP6iXcckX/F4oZg90cuchn8Omd9OzbcrBhoPFNNwoHUA8ZLmfQ+YC6E183DGjtqMD2GUYqzDHLadlxJOR+In7re9sFy/tYQk7FwodTZ63CF5Xd3BitadaYdd3r5Qu4Y6yX5tUHEzj3kqHZw1RMIKkT//BzL3+kIukjJErD2KNVdsQqILqM4Vzjqf2AqeCwSuu26IVVK+KmhX6PQBxQjiaaaB8REfUC6DZwpfDM1mMlBgVolsHuCuL/aIvTnv9SVA080xMuMV42bQAn5XGLJXotlkl95lSR9ZQXwpKVV4vVbG4diZFb/X4Fo/MEK7OFw/D6QSYzOnJMeQxp91EegAbmQHzpeJgm58FiGjW+Li5E6S2lj9fsntyc/RR0kBMjYUZs8WG82hAR59V7z0+y0/B3OmG3gLv2lZCIWBZqT9ZeZXaTUk03tNVqVs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(230273577357003)(230473577357003)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2phNUxXSkJ4YWp3ZDIxSStXNlM5dzNTenhIeTBrT0dRQXlKSFBhNm1RNm42?=
 =?utf-8?B?RmNZZm1nTFpkdXo4OU9kdVRRQzNhK1lQYUVBTi9HbWgycmt2UkRRcVE0MStO?=
 =?utf-8?B?NWt2STAzbk1EWFd0NnlyQjE0VnN1OXBGSDFXUnJFQXVVRUplQjU2cDlhSDE5?=
 =?utf-8?B?Mk9IajhRM2tHWmxmVGRZdG04L1FLTVJLb1cvNUpVcEU0aklvclYvLzJTQWl1?=
 =?utf-8?B?WHdlcWFZRWZkdHlLZDBib3UzNkFET1BXdm90b3NXK2QwLzg5dERySVBuS054?=
 =?utf-8?B?emorb3ZNUWN4SDdlcnRNZnRuWTZYVWpXamk4WXRNa1F1NENMa0VaVEdhOTJk?=
 =?utf-8?B?aUZTSUpQWEVGVDU0ZVpzNzVDSUI2YTEvdURsNHNkMkJKWXdJOGFiRDhrclZn?=
 =?utf-8?B?RDBtNkR0WXdKdG9RL2p0WXV4MksvMHNZSy9pMDFkNmc0Z1pLQVY4NFhvQTJZ?=
 =?utf-8?B?Rm44WW5HcmZzamhPM0VvcFd2NW1oeG5Wdlk2RG9YU3dnR0N5dWxnVTh3czZQ?=
 =?utf-8?B?R2dWaXNPTGtITGNVeE05YjNaVlFwNWlRWEM1R0hQdjFua3lxWjRHdFdwVmhI?=
 =?utf-8?B?Y2ttTDdvcGY2RW1iYjhnRm5xR0J2dDF1WVJ5U1VTYmRmN0syM1NXZ2UwL1hy?=
 =?utf-8?B?QnZ4dml5czVIdUhxR0Q4eEJtT2VmV0lKK3B4SzJ5VVFUNG5sbCtkVzUyK3JX?=
 =?utf-8?B?V2dVZnFGY1A4SE96Uzc5Z25DUmVna2c3d0U1dXd1cWVNcE1QRWt4S2xmNlJG?=
 =?utf-8?B?QUh0TlcyTnJuNllQT1dKK0p1aUxOaWgxOENlcU5HNVFWSUdHTlZsaWVZeXZ5?=
 =?utf-8?B?NnFLQjhFR3BvZWxBRFpsUno4SkhZYTZyR29TaWhVbHhOL2RzeTRYVExtbzc1?=
 =?utf-8?B?alFHMXkwVGZ1bFphT283K2JPR2x0OUI3QUVkRlJJSWxxUlRuUTJBQS8yU3RD?=
 =?utf-8?B?dktkTTVJVGk1YW5MYlRIR2NJd0pXdUo4NVVaRk1YU3pMY1Rvd0J3L0JQeEdt?=
 =?utf-8?B?MnRRV0ZSQjlMSFBQc3pwRm9wRlJuckR2Q0ttV3hKbHBHVWZTRlNid3orRTNM?=
 =?utf-8?B?WE5tQU9NYnJFZUxVVDIxNEtHSGZPVGJwQlpwam5BcFY5ZjlTOFhwMkhWYnZa?=
 =?utf-8?B?NmhJbW9KZ0F6Y0lRYS9QdGFCTDk1S2xNZ0RFcTJDaU9DeVpKWmpGYWR4QzJM?=
 =?utf-8?B?UldYNEZXWm9uWldtMERYeHQxQVMrWE9GeG8rMnFLdVcwNjZpd21OTVhNdXE5?=
 =?utf-8?B?NkRGMXYxeXIrWHQ1UDZzWGREUm90NktCZUMzMXk4US9ObUhNNnRUQ25FNUV4?=
 =?utf-8?B?NElOSHF2QkpobE9PL2ZiaG95QkRWV3U5RjBoQ2Jib29KNXlKeDlETDNSTVdi?=
 =?utf-8?B?RlVwalE4TlZkN0VyU3lYR20zQ056aDFLMkx1QnFjV0RGd0c1MHN5dE9mRllp?=
 =?utf-8?B?aElFZ1JaSUNuaTd6Mm03L2U0OUNFcjFhak10NEl3ZEo1M01nVHVtWHd3aW4y?=
 =?utf-8?B?R0lmWjNXVGJCU01jZmcrQ0oxQ1laQktYd1RYSkZQUGl6bGV3cFhqS2lxNjFZ?=
 =?utf-8?B?NVdndzUxRjUvL2JxdjZjWjAvYkNYcmpnblVENjhRUzl4azJuWHNnMlh0bmNz?=
 =?utf-8?B?UGZRbjB3Z1Rtendtc1BkT2JjOE9jMTlGUHdBcHV2VG9HUFlrY1BqOTlGWlFR?=
 =?utf-8?B?cmFOcHJKZHVDWSt3cEw3WnV4cHNxQnhNeG9NRFlIT2xsMXRocnlmNlpnTjkw?=
 =?utf-8?B?ejVmK1JYYnFHV3BpeEVRR1lpVG9BYzFVRDBCOXpYbUFnZXJOV05Cb3BHMHg5?=
 =?utf-8?B?di9RcUJ2Q2hLa3NKMXJ1UW5hVzR0VmhkczNucE0zdGVZRXVOS1YzSHFQdmZz?=
 =?utf-8?B?R2V5VzdiRVFzeURwUUsyOTJUVTZZS0tubm8wWTVZSEdoQUYyVCtoaWptNXlM?=
 =?utf-8?B?c1VvMStEdU03dVRiOUZObTNvRnVFWCtKVW43MENSQWNlRkdOdnFzd1hKemF1?=
 =?utf-8?B?QzlMVTFmeDJIb0d3Y1IzRS93ekI1SlUyZGRzMStUSWNucGxETjl1NWkydk1k?=
 =?utf-8?B?dnNVTFRHOWh5MFpjQUtMOUFncXBrUVhoL1g4RGttMnRvYnFuZ2ZZWkJnYkFW?=
 =?utf-8?Q?wzDfH0e6A08JY+uz1Ex73VfoV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e402d96-62fa-466d-0dcb-08dc3739f1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 02:15:19.1532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veQByyvdAii9dsHLUmK5ondRzVYhVFvSmFJegWtGWLRw24xAdiYAxYkUvlXIKdWdRQ8LBxKj4vp8aXqFbRZPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8240
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41R2FUt0063864
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZl
YnJ1YXJ5IDI3LCAyMDI0IDg6MDIgQU0NCj4gVG86IEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWT
suWYiSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9y
ZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBhbGlzdGFpci5mcmFuY2lzQHdkYy5jb207IGJp
bi5tZW5nQHdpbmRyaXZlci5jb207IGxpd2VpMTUxOEBnbWFpbC5jb207DQo+IGRiYXJib3phQHZl
bnRhbmFtaWNyby5jb207IHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAwLzRdIFJJU0MtVjogTW9kdWxhcml6ZSBjb21tb24gbWF0Y2ggY29uZGl0
aW9ucyBmb3INCj4gdHJpZ2dlcg0KPg0KPiBbRVhURVJOQUwgTUFJTCDlpJbpg6jkv6Hku7ZdDQo+
DQo+IE9uIE1vbiwgRmViIDI2LCAyMDI0IGF0IDU6MTDigK9QTSBBbHZpbiBDaGFuZyB2aWEgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBY2NvcmRpbmcgdG8gbGF0
ZXN0IFJJU0MtViBEZWJ1ZyBzcGVjaWZpY2F0aW9uIHZlcnNpb24gMS4wIFsxXSwgdGhlDQo+DQo+
IFRoZSBpc3N1ZSBoZXJlIGlzIHRoYXQgd2UgcmVhbGx5IG9ubHkgc3VwcG9ydCB0aGUgImRlYnVn
IiBzcGVjLiBUaGF0J3MgdGhlIDAuMTMNCj4gdmVyc2lvbiBvZiB0aGUgc3BlYy4NCj4NCj4gV2Ug
ZG8gYWxzbyBzdXBwb3J0IGJpdHMgb2YgdGhlIDEuMCBzcGVjLCBidXQgdGhvc2Ugc2hvdWxkIGJl
IGNoYW5nZWQgdG8gYmUNCj4gaGlkZGVuIGJlaGluZCB0aGUgbmV3IGV4dGVuc2lvbiBmbGFncyBs
aWtlICJTZHRyaWciDQo+DQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBzdGlsbCBhcHBsaWVzIHRvIHRo
ZSAwLjEzIHZlcnNpb24gdGhvdWdoLiBEbyB5b3UgbWluZCBjaGFuZ2luZw0KPiB0aGlzIHRvIHRh
cmdldCB0aGUgMC4xMyB2ZXJzaW9uIG9mIHRoZSBzcGVjIGluc3RlYWQ/DQoNCkkgaGF2ZSBjaGFu
Z2VkIGl0IHRvIHRhcmdldCAwLjEzDQpQbGVhc2Ugc2VlIHBhdGNoIHY0LCB0aGFua3MhDQoNCg0K
U2luY2VyZWx5LA0KQWx2aW4gQ2hhbmcNCg0KPg0KPiBJZGVhbGx5IHdlIGNhbiB0aGVuIHN1cHBv
cnQgdGhlIG5ldyBTZHRyaWcgZXh0ZW5zaW9uIGluIHRoZSBmdXR1cmUNCj4NCj4gQWxpc3RhaXIN
Cj4NCj4gPiBlbmFibGVkIHByaXZpbGVnZSBsZXZlbHMgb2YgdGhlIHRyaWdnZXIgaXMgY29tbW9u
IG1hdGNoIGNvbmRpdGlvbnMgZm9yDQo+ID4gYWxsIHRoZSB0eXBlcyBvZiB0aGUgdHJpZ2dlci4N
Cj4gPg0KPiA+IFRoaXMgc2VyaWVzIG1vZHVsYXJpemUgdGhlIGNvZGUgZm9yIGNoZWNraW5nIHRo
ZSBwcml2aWxlZ2UgbGV2ZWxzIG9mDQo+ID4gdHlwZSAyLzMvNiB0cmlnZ2VycyBieSBpbXBsZW1l
bnRpbmcgZnVuY3Rpb25zIHRyaWdnZXJfY29tbW9uX21hdGNoKCkNCj4gPiBhbmQgdHJpZ2dlcl9w
cml2X21hdGNoKCkuDQo+ID4NCj4gPiBBZGRpdGlvbmFsIG1hdGNoIGNvbmRpdGlvbnMsIHN1Y2gg
YXMgQ1NSIHRjb250cm9sIGFuZCB0ZXh0cmEsIGNhbiBiZQ0KPiA+IGZ1cnRoZXIgaW1wbGVtZW50
ZWQgaW50byB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgpIGluIHRoZSBmdXR1cmUuDQo+ID4NCj4gPiBb
MV06DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2L3Jpc2N2LWRlYnVnLXNwZWMvcmVsZWFz
ZXMvdGFnLzEuMC4wLXJjMS1hc2NpaQ0KPiA+IGRvYw0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9tIHYy
Og0KPiA+IC0gRXhwbGljaXRseSBtZW50aW9uIHRoZSB0YXJnZXRpbmcgdmVyc2lvbiBvZiBSSVND
LVYgRGVidWcgU3BlYy4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPiAtIEZpeCB0eXBv
DQo+ID4gLSBBZGQgY29tbWl0IGRlc2NyaXB0aW9uIGZvciBjaGFuZ2luZyBiZWhhdmlvciBvZiBs
b29waW5nIHRoZSB0cmlnZ2Vycw0KPiA+ICAgd2hlbiB3ZSBjaGVjayB0eXBlIDIgdHJpZ2dlcnMu
DQo+ID4NCj4gPiBBbHZpbiBDaGFuZyAoNCk6DQo+ID4gICB0YXJnZXQvcmlzY3Y6IEFkZCBmdW5j
dGlvbnMgZm9yIGNvbW1vbiBtYXRjaGluZyBjb25kaXRpb25zIG9mIHRyaWdnZXINCj4gPiAgIHRh
cmdldC9yaXNjdjogQXBwbHkgbW9kdWxhcml6ZWQgbWF0Y2hpbmcgY29uZGl0aW9ucyBmb3IgYnJl
YWtwb2ludA0KPiA+ICAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBj
b25kaXRpb25zIGZvciB3YXRjaHBvaW50DQo+ID4gICB0YXJnZXQvcmlzY3Y6IEFwcGx5IG1vZHVs
YXJpemVkIG1hdGNoaW5nIGNvbmRpdGlvbnMgZm9yIGljb3VudA0KPiA+IHRyaWdnZXINCj4gPg0K
PiA+ICB0YXJnZXQvcmlzY3YvZGVidWcuYyB8IDEyNA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgzIGluc2VydGlv
bnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiA+
DQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KDQpUaGlzIGUtbWFpbCAoYW5kIGl0cyBhdHRhY2ht
ZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZpbGVnZWQgaW5m
b3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQg
dGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhl
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSW4g
dGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmV0dXJu
IGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWluZyBkb2N1bWVu
dHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5b3UgZm9yIHlv
dXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9O
IC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

