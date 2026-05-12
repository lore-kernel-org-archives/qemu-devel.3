Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB4ACD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdHd-0000dY-8y; Mon, 11 May 2026 22:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMdHI-0000ad-Hu; Mon, 11 May 2026 22:55:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMdH8-00014B-Bu; Mon, 11 May 2026 22:55:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysOMmRjK1h97zIdBxyDmIvMb+0XfntD857iJvpWewk+46U1+3l9d85bC3VUOTYv3eikg8pLdBNE9P/5PnuGb0KtLQm+bVmFFWNaLjkvAviYue1MeLOtMCIMAaLOYlaxREx29CNlTTCqUfcjsgI1J/xGuYZfXt5w8st2EPkSIAH3IfNlbFqYCMT/pm0d52fcjNZrTXgK7ZIiHLLOnSbVpQO47IGnE6s8r7knwmAEuK30c22gnn/ZN9yt4aIfWM0YQBVl3RgO6r7uQs6VZFoPOEUYxJkF+m3quYI6EM2pyt4mlrQ7UQ2WdS5nrW4gw4Q/bFHQ3h9we+bAjKts48LYYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzDshNCE9IPt5zoIT8naXJ47OBaoVwSo/+MGCjK6/Ns=;
 b=HhHCirRSSKN1UFNPQWqdiozgsd0ZD+gPNd+z83XHkhUW1P5eJ6aqjhxaTZ+OrskT3+YdKM/qAwgbbKt9gHUnUwImQKSDqLYSNbml44bjtaNItNpW+JwVMofyOiCJm0K6t33oef8OHHpiKMHkpBfp0OMm1fKeLUptWX3yDbNdeoFz/YzczUeCoQgC8VYe1ot9AbwAVih4Mv7qBCIJf2YDolnlp3+bCJAo64G2F92kI5XfI96QxUnEGNGva2+xvAhglp1RstfKV/O5gmQWrVaw9pyJRPNtpcFg8ytMNAXhX1RDQsLkRlxx/JOXG1UtoHX/ycHO6fWbE1TZ6qbZNoq40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzDshNCE9IPt5zoIT8naXJ47OBaoVwSo/+MGCjK6/Ns=;
 b=NK9NkTWkl5rXeO7bUuLcp9rSaTyVT5hOroyovsui43NQgSvLuu3SXb8MMe8zPEO9deKoUumG+Qkt8yZw7ER9+Iv/kMijVDPD7gLDpEXXqb6E7xG8adirH+Tg3TuMdwMoW4VP5cJeX9dw6ogYydEU0WBJ498uq113qUr/LpPHSJ039fMmmJ8xLgKSfzi6RUOVLFzpb3CvyvwpGWyi9IvF1QUQqd9nb+jcNcmmAHEa37+DnY0iRkvxe8fu4GfWukAVxfIr3W++EJ5Q6VxlzPmOw/tGoxlcZR/RcnDMEVQsLc2uX1IYm6vyEJK0uMmwgKvyzmI3QUjA5q421GnKbUj+Iw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6519.apcprd06.prod.outlook.com (2603:1096:820:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 02:55:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 02:55:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 0/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Topic: [PATCH v1 0/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnODjnafroHF0aYs2O+Fxx0jrYF3NaAgAPbETA=
Date: Tue, 12 May 2026 02:55:06 +0000
Message-ID: <TYPPR06MB8206B38ED6B333B5B7DBCC0AFC392@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
 <885688b7-5d54-4466-8dcd-e7c0bcbd05c3@kaod.org>
In-Reply-To: <885688b7-5d54-4466-8dcd-e7c0bcbd05c3@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6519:EE_
x-ms-office365-filtering-correlation-id: 5db07e20-b6d9-4826-6120-08deafd1df64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: B50TPt29OBW5pgiIe7bV9WFNQoMYwthAMhtcMXvwDRqfGo57hViXLqnZ6Shqv2QXecAY6M3eZRaI1nAk9SiaIXGLful55J7UPuoa32I4ev7Ot0NWrA9VaqpA+jqFhgUxS69W6qeMyFh2FbW5a1iooeQKS+Q1R4tsyQ8cvtg9YDuBuqmcJy9LqcdzPgBX8W7M2hejuvrhcEKGvRagQUYItYT42RsXi87Kz9uu1terrTBegIG63Vf2cyHkI7v7N3v89Wv0iXcc4WbkXeu95VQQH0Z3CxLO9CBUPF8H4k1JPZLU54ZrVDgqNej29PKsiosibntPNosxykIsgC9790aQH4CCqSAIrWr+eF1S1cfTJFU4UxIZ6HHiqQjjXnjGPbUun0yxASMkRmn4FXVGqDdXNT4rzAwbVEU8xMrSn11HaJvA0IAGGfpCaYeBpr+qEHziOyXO3Wn+RE2VdGJkSTpNu3l9WRKKCxdL5ntVkhYhUT48K5firLhmcJdtuVKP3as7KK061BhyCiSU1eOKW52GbAYWtwoosNKE8faqT3BYjZNPPiEGAspgsMYme8us9kE/1MajrDqY0URrpbaLr3D8jxo2mbOrc29T3IAJJVmAeACm1zdmsRgp5CVh8UmDrq+HMwp8OqIrdQzSJofOYMX/lYRJzmiuYDEEQL9mGQEqDFTLUbIa9Zlbfq5aHlAc8LdYxo4GRk7NVhoDJjJ0w1ZNdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhocS9EcW01bkROaVhUK0xJbGZKWnVPNjdTMUtLRm1CZGdrZE9tbVF5Z2o4?=
 =?utf-8?B?eWljOUxUalU4UmFxcjVWRm1aR1Z1MXI1ODVMRmE0UHBSMkRibVYxRjhPNHlo?=
 =?utf-8?B?U2N4WjEydDBKZkt3TmdBdG1uQnJiZVpnNmxKQXlMbk9la2RNd0tScVN6UXVl?=
 =?utf-8?B?RjdVU0RkdVBSVGFJMU1kWG5UZjhJWFNYd2FrNmJCUnJiTmgwdWNLbzdlSkRv?=
 =?utf-8?B?WW9tRm1DSlhqZEN3dlBkcjhsNEd0MWNlb2VuVFVkS2YwK1BYcFlKbnQyN3BP?=
 =?utf-8?B?VU1peFNDMEFBWTZudXdNaGk2eUVDUlZCUjJseVl2enFDKzg1cXg5aTZDWVdG?=
 =?utf-8?B?SFdzL3lLWmdsbXI5Y0RtS2FzZE94UU1Ja0RVZkVBZ1JxNWEvcEN1SG5OcnhH?=
 =?utf-8?B?cGpHVVBBQjRmNFdocXJ0RnVKR08rMUwvdmhBN3gweklLaHBVbzJjSE5HMTlG?=
 =?utf-8?B?cVRWc1AzOXZrVDRCWDNsSVFWSVpVdVVjTzRTZThVNlRlL2RjRytUanBEM2xO?=
 =?utf-8?B?bGlYR05DM1Z6NnpscnNnWVlkbVZsTkIyb25MMmhYckpFNTlpQ0VDOGNZWXJO?=
 =?utf-8?B?VGJaUlR3cWxBUi9sZkZiM0NzQ1E3T2NSdTZicGJqMU1qcEsxaElQWG5oR3JG?=
 =?utf-8?B?Y01sVXpreW1YQ3RtRmY3S0M5RTEzek1yK3RFTHQ4aE5oOERmdzdXWUMwSldw?=
 =?utf-8?B?SVRVcVJaWldQVi9jbU84RlVEZGVqS1Q4ckNvRFZSQ0ZrWHNVSmduaGtWQnRv?=
 =?utf-8?B?SjZidlNtQ0Yrc2k4OHJ5c0hqQ3BoR0c2UWJwNUJaQUxPcldVeWYrVUFqYnh5?=
 =?utf-8?B?ajNqbDB2NnJtR1dab2IvVmRyTnBKMGVpWit2STFGUkhLc2FsbVF0TW1FbmJu?=
 =?utf-8?B?U2xLbE0rRWlnd3RKVFZFMXkzWUNwNWkwZkM3Q25OQWxSSjNhT1llaGxiQyto?=
 =?utf-8?B?WjhPRlM2WmpxdFloeDFpUHhwbWo0MlBvQXdZUm9EMTV6QVhLVGx0S1A1ZDFL?=
 =?utf-8?B?QUxhZGt2QXJ6d2l6eDRHajVKbjBIdStiR29wdUtnUWRkZ3cxU2VPa3hKanoz?=
 =?utf-8?B?OUNleVNERHhwak9yUnJnTUxaMUczeVVNVFZhTkJjc0pseGVjSTYrRUdEUnl3?=
 =?utf-8?B?b3BmcFNvdG9WcFFNeDFWeDQ4ZU45YmY0RU9tQWd5dlpzeTFScGI1V01OZy84?=
 =?utf-8?B?ZkxUb2N1dGM3QXlxVVhsa2h5VHlnaWtEMmN2VDdPblp2OWU1VGcwcHYzU2l2?=
 =?utf-8?B?OWxwNlBydHd0SGlrd1hoaGdXWExLalYrMzdKSEl5N00wbkQzVUZOb0VyNTJl?=
 =?utf-8?B?WTdlVWJZSzVlOGh0V2V4UGV1LzdXWkg2M1BjbXpwMW5oWEYyaDlvbnlkcWZ6?=
 =?utf-8?B?VUQ0NDNIQWRzcHliamo5S3dyTTU5dEx2d3VZRUFTa2xzK0RoWWx0S1hBYXhC?=
 =?utf-8?B?eUNEQktmdUEzOXBoVVY1Um1nNFQ3UkRrYlYzbzZHemtHcjNGYjVMSjMxTXBT?=
 =?utf-8?B?Q3pEb0kyakFWdU84TWxBNnJZbHRIYmxUTDVnTVlVYXc3LzJWMmVLWFBmZDhr?=
 =?utf-8?B?TVVEejBUOTF0dkxPT3M5WW41Y1QydHBuOUVWaXdscTVNbGZhUlV6YmY0RGdD?=
 =?utf-8?B?Sk9nZm1sZ0ExV1lBbjA0eHBURSt4U1VROFI0bzBXR0M3MnJ3aEhmdHNVak12?=
 =?utf-8?B?bDlSYjZSNy9CRHBnRUFqV3Z0MDhyVTlGN0tHdllXd1JUbTJRZ0s0WDgwOTNP?=
 =?utf-8?B?am5HTUtpbE8vNnB2cXpub0tXcHY3UFNoZGg0a21EdGFTdk5CcURHNjJvSW1a?=
 =?utf-8?B?d1JrdS9iWEt4WEpOMzM1ZzFac2tKMmlxQ3FBdzZkOCtEZGtOeWdDOFVOeHRU?=
 =?utf-8?B?VUE3V3M5SmhOUE1uZFZ0aEwyN1VCS24vK200N1JhdUFDWmZXTytwRDUxMitG?=
 =?utf-8?B?WjQvd2lBeUp3MWFGeWZZQTQyOFlqZGVDZEpBRDVLR09NemZtUlEvQmdhbW1u?=
 =?utf-8?B?aDc1WC9ZMllYY3ZFa3haRUdHME1ETjRndGZRMjhpWHhTa1pQUzVHdE1Xc3BP?=
 =?utf-8?B?ZG01OGliUDJ3OTdTWCtjZGEvUE1jNStHS3owNEVDckNFWG1XMDUyd0J5V2l1?=
 =?utf-8?B?SWxDZnVNa29uK0tLQ3ZHcERqd0ZYZEg3V0Q3ckUyKys2L3RIVDlYL0VpL25o?=
 =?utf-8?B?eGMySi9SdTNETjQ2dE9HZGlqZkZjdUlZUjFwaWh4dzFkd1R4VDFtUUlvc0Qw?=
 =?utf-8?B?OWVrOEhjRVo0dVZ0YzhWaTI4cS8wL3JMdHBLYW9YazFEZHR6OTBaRFhVd25Q?=
 =?utf-8?B?ZytudVhoaHNvM2M0NVMwU0tLei9jbE5oaFB2UVJzdGlSUThNVmFOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NavMC5VujkmNnhHhsVlnwL3Rkuf1NAu5xL1JkohGjGUCAbOVcKWq/KoP9Hid+epEiECRhS5LeRX8iDOByi2D+42ijsmF8zVTal0/Z6mSIQPVj6WcqqVdlzJAANzh033jkkhOTMt/TwgbWsApbRFkIZnJ2QbsEzb5CHiD/nxfjCsxzjcP8A5DnUchsGbQTS1JDASQeX+xC9XGSKyO7mCcwPVav/RspH2SOMPNzs41N5sQt0qc8DiB8PofRto34UVsQLK7mUn0EqnWYSgUmQpoVq4IU82qSGGbEMtKgA5G0Bfjc7gTu4+JQt7LYodAGq3z7yGd1zGW2uFEEiUln0auBQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db07e20-b6d9-4826-6120-08deafd1df64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 02:55:06.3604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+CxiWPREODfcm6MYSgmYLLLveX1fcIRWWtpx3Ngd8p+7MbfcpoOEYkfKMwzubY6V4q6bL+Y1M1QPjjqbRyl8O0UI2i5vVQOwqmNOqtaKks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6519
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvMV0gYXNwZWVkL2hhY2U6
IEZpeCBtYXBwZWQgYWRkcmVzcyBtYXkgbm90IGJlDQo+IHVubWFwcGVkIGlzc3VlDQo+IA0KPiBP
biA1LzgvMjYgMDc6MTYsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBEZWFyIHJldmlld2VyLA0KPiA+
DQo+ID4gVGhlIEFzcGVlZCBIQUNFIGhhc2ggZmxvdyBtYXkgbGVhdmUgRE1BIG1hcHBpbmdzIGFj
dGl2ZSB3aGVuIGFuIGVycm9yDQo+ID4gb2NjdXJzIGFmdGVyIGd1ZXN0IGJ1ZmZlcnMgaGF2ZSBh
bHJlYWR5IGJlZW4gbWFwcGVkLg0KPiA+DQo+ID4gU2V2ZXJhbCBmYWlsdXJlIHBhdGhzIHJldHVy
biBlYXJseSB3aXRob3V0IHVubWFwcGluZyBwcmV2aW91c2x5IG1hcHBlZA0KPiA+IGlvdiBlbnRy
aWVzLiBUaGlzIGNhbiBsZWFkIHRvIHN0YWxlIG1hcHBpbmdzIGFuZCByZXNvdXJjZSBsZWFrcy4N
Cj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGludHJvZHVjaW5nIGEgY29tbW9uIGNsZWFudXAgaGVscGVy
IHRoYXQgdW5tYXBzIGFsbA0KPiA+IHByZXZpb3VzbHkgbWFwcGVkIGlvdiBlbnRyaWVzIGJlZm9y
ZSByZXR1cm5pbmcgZnJvbSBlcnJvciBwYXRocy4NCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwgdHJh
Y2sgdGhlIGFjdHVhbCBtYXBwZWQgbGVuZ3RoIG9mIGVhY2ggaW92IGVudHJ5DQo+ID4gZXhwbGlj
aXRseS4gVGhpcyBpcyBuZWNlc3NhcnkgYmVjYXVzZSBzb21lIGhhc2hpbmcgZmxvd3MgbWF5IGFw
cGx5DQo+ID4gcGFkZGluZyBkdXJpbmcgcHJvY2Vzc2luZywgYW5kIHRoZSByZXN1bHRpbmcgYnVm
ZmVyIGxlbmd0aCB1c2VkIGxhdGVyDQo+ID4gaW4gdGhlIGZsb3cgY2FuIGRpZmZlciBmcm9tIHRo
ZSBvcmlnaW5hbCBETUEgbWFwcGVkIGxlbmd0aC4gVXNpbmcgdGhlDQo+ID4gbW9kaWZpZWQgbGVu
Z3RoIGR1cmluZyBkbWFfbWVtb3J5X3VubWFwKCkgbWF5IHJlc3VsdCBpbiBhbiBpbmNvcnJlY3QN
Cj4gPiB1bm1hcCBzaXplLg0KPiA+DQo+ID4gTm90ZTogdGhpcyBwYXRjaCBzZXJpZXMgaXMgYmFz
ZWQgb24NCj4gPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNjA1MDQyMTM0MjEuNzEwMDM1
LTEtY2xnQHJlZGhhdC5jb20vLg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IEthbmUNCj4g
SmFtaW4sIEkgbmVlZCB5b3VyIGhlbHAgaGVyZSB0b28uDQo+IA0KTG9va3MgZ29vZCB0byBtZS4N
CkFkZGVkIHJldmlldy10YWcuDQoNClRoYW5rcywNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQoNCg==

