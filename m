Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CC1C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBtX-0005Jx-8L; Mon, 05 Feb 2024 22:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXBtT-0005Hm-1f; Mon, 05 Feb 2024 22:13:07 -0500
Received: from mail-eastasiaazon11021006.outbound.protection.outlook.com
 ([52.101.128.6] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXBtO-00054D-PN; Mon, 05 Feb 2024 22:13:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3KjBDbWHmuoqW7FGbK+h2SeBMi8XVWsIvI8M/2byGTp9NZin/Emzp7wVdiyfG2TNP3MzDo4TUHXpU2KMGcRrb/ED69mpcdsDaigGJdCp3bZnhfVVa5xpfhdXDiBHJwGv2UI/ayYNFUL5Sk61bKXzld2lHI3B3F+K0ojoYWU4ip8ZSwK0GgKjiWDVzuvg151HOsiIT/snEKbEs48Wpb9ksqp9MRUd/S5EAEaQBYacRsHKa7CaTo34z8eTes/od0IIWArwpnqGg7+98YlcbXia2sI+NeutU/oIkmDmteRBSouiYClqccI3QLyg6qznDi4+biQaE+sQr5QM5z0IPcR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv8yzpeQ9SVpjfT78dBEnK+bwQpsx1aP07+UY5/gK5E=;
 b=M9EgTn5GUcBLn/Sni3p3WMBs6k7IA0RSNv3fBZl/kfODtwM9veqDUty01JXwcMls7lm8dZE61/RKoQIxVjIQjZu+jZcBqpaFNO9MeGVDergzUqc4PZi9Y2Tn5V9SvQbVUfaaSRokuO9MJ4/gLVAgrJLPAAA/KPGlEPoZkFbZQOadRDHS//DxUintA+98yDiwbQPhoo9djDY0dbPAmkEBHcAOq8W49qWkGOxP23Nvk5NDiH3x4IWbBu+yYMdasdWXKCqkOz3nybINEka1MS4TzPfhC6Q8S9WmU0vKDwENBc3r0BwYI/H3A1WTS+9LpmHVo1lVnoP1g8+PtN0QyVFWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv8yzpeQ9SVpjfT78dBEnK+bwQpsx1aP07+UY5/gK5E=;
 b=qatiyywbapsh1yW4FJIOzw1/Tp8gyjZgjl+3j6c86XnplhiA1ekUKQIMQ31MrXRFxz2AqwYOuEPS074bP2ozljZ+AbcmmKd5uXsnS33ZKu31SVbFbLs1DKR8rGqN9D9xghbprhQppF0wOVXZvh/bQaVGThm0/ldtmTdiAC+ptN69HL7hJo+w71DXS0KPDQl7YJToBIysu5baFuB1R/iFkz4PcoE4Xh/MdB062cK88G4MxjWBPfPM9CDnGo5Sv/GvNP/i/nxGYstMEE8uVfjK7LlNhuScwo+gO2G3pT8W4RXzwvqREb4Ukrms/PZmcdoMj2A+yroKi2mA3c3WWkrPFg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6683.apcprd06.prod.outlook.com (2603:1096:101:16e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 03:08:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 03:08:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Topic: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Index: AQHaWBO1pIX+mXoppkCs9A5dfg25WbD7kN+AgAAp24CAAOPSMA==
Date: Tue, 6 Feb 2024 03:08:49 +0000
Message-ID: <SI2PR06MB5041B14996B7E258F54AEAF9FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
 <da2708e0-c3f3-4e11-af24-07817bc0cdfd@linaro.org>
In-Reply-To: <da2708e0-c3f3-4e11-af24-07817bc0cdfd@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6683:EE_
x-ms-office365-filtering-correlation-id: 22bf8203-62ae-4af4-9aeb-08dc26c0f109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5V7GXCssVvgQ5MPQV+iA1qXMAp3tF73L5o8ZOa6aYU7s329EwezgasmihWRBKcQQu/OO43Iw/5rFkhrr36E6ygDbUoqnQKi8nQ3YnCxN/Mgs7iPbI7f/LlRT9475BaTIiLN5hlLhto7qubH0oEKfV45Uq38dY3Sadp8XNvAcmz6pBdVwd7QKHyljtkr0li5/4NoRtajy3K5WBOJs9NMVsn6fpQIwAlcxl/2888L4tjih5j/RGczDejTTw4WOez1Voio+LoeFcFOAHebYgzVWEUyTUdOfb4KLPTfvQXGEGLG1r8xfsibSXn+oKNLHwMt2F7Sy5pcOUCXawo6gp+yodXVYtknFaSS8lgE6Ma8om2lufyDR5bO+Gc2gGPtfI9akftiEEvF8yPIwWcUYvwUd+H3Z9B4cicx2sNqIkVT8FFDRrdgx9Mv/8abZbpwK5RmNf22mWPg/SH2ymmq/t8xV9zj3Pd/ppTP8OHco3A/rRkaLqQNIQaUkI3JhYD+N3PfHX9Bxorf8XBQYIh6L7M2k9fRYvkiCtWfzs2qhzzhoShKExfhO/uisUv9+YP0hYE9tQltwarFZJPTv0kbv67GJrzRifC81dh3bj4GE6rMkI4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39840400004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(33656002)(122000001)(55016003)(7696005)(6506007)(53546011)(38100700002)(83380400001)(86362001)(26005)(41300700001)(107886003)(8676002)(52536014)(4326008)(8936002)(9686003)(71200400001)(2906002)(478600001)(966005)(38070700009)(5660300002)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1ZMWlNnK3pBMUkxdjZsTUFKMFFEZGVPUHVFQ1lZYTRRajVGS282V1p4SUJU?=
 =?utf-8?B?cXRoK0dZdC9ZaVBRL0xKWHpRUUVIMERiSkliMWF3RCtRdzNuV3BFTTNjeS9l?=
 =?utf-8?B?L2J4L2cvcGE0Q3JzV0h1T1ltTGJGcnVud2YrTHBVL3RMRUN2aHVCVzdwZm1G?=
 =?utf-8?B?Y01FV0JhU3BKTkovSXVkVk1XaEYwY1pyUHE1QkNGRzhiOEYzVm1lVCtHT1Nl?=
 =?utf-8?B?VEdrMkFLY2tpWTFPS0dlbzdqVm1oWHAreXNKYzhram9uYUpuRDNXUkUrZmJP?=
 =?utf-8?B?eWVTRXlSOWxGMEtZemI2QUVYUzBOZld0T1lFTkx1NTNuN2VwTUx4eTFwdGk4?=
 =?utf-8?B?ditDUVFrRFVDUXJqWURZdmdVZkNqOFp1UEkvMVFsSHVrRk1ncDZVV2ZSSFhp?=
 =?utf-8?B?RXNTWlM1WjNGbzNVL21JUGVJeVFqdWlyRWh5VjQ5QlVjTEpCMy9GL2hhK0FV?=
 =?utf-8?B?NDduWFcwVFJXMUkwK0E5cjdobFJTdGJWWmExeXJtcmJ6d2MwNDc3M1JJTXVC?=
 =?utf-8?B?RTl6aWQrQmloaDFSTlcwYlZtcExFQ2JmUmRxVjJLY3RjMFBBaUZJM0MxNTht?=
 =?utf-8?B?SkYzYTNhZHhXeVVPeGdnc0w0b1JnN25LNzQ2MGVDOEhSUHZacEJaMG5MdU1J?=
 =?utf-8?B?bENGTzJON3dwYy9FUXUrUUlvRkZndUMxVmZQOU5ZZTdLUGVBZ1F5Yi9VbFRk?=
 =?utf-8?B?VXY4QjdHa2ptUWxCckxVQW0zdEFyU1B6K2pRUFJFOGg1Z2JUYzdNOG4yUytm?=
 =?utf-8?B?NDAzNnBtUVNXVFoyTjduM0h4aVVnMVVRTXhHREJmVmFWSWtkbXhBb3RJUExr?=
 =?utf-8?B?OTUxWVQxMFRONUgvWnNGZUx6dGZqQTJTQm8rZVB2MW1CRTliS0dEcVhjT05z?=
 =?utf-8?B?ZnZPYU00d1Fyck9kcVFEd3hZMGhBVjRsR0JHQ01OL0NSOE0xN3hnTFdyZXQ2?=
 =?utf-8?B?NmllbFg1UUJOVExsMTFSNXZ2RDcvVTlOWGtSTjNtQUNWZlJXeXJIOWJDY01p?=
 =?utf-8?B?WVJVK3krUzFvRHhlWDRBT1pvT3pOL3JJa2VlUFRxN0pIRkc4a0I4UkVUejZv?=
 =?utf-8?B?L1Voc1BNQW0wOXNRZUlLajk2TVo5MTQ5VnpPWUFiZW1SMm1KVTFXNkNEVjBy?=
 =?utf-8?B?TC9JcFlDdkhxYTdETUN2K3dZVHI0QnhydXJjTXpYWk9UdUdqY0o0ZFA0dURp?=
 =?utf-8?B?cXdCc0RidEkxYmlEMGdzdEdIZDQ3Umg3VUYwRmlaZWlSVHdrTW80SjFqWHA1?=
 =?utf-8?B?Z2x5ZHNmenZlVmUvc1AxQTRIZkhqaVBRMTNoN3VKU3N1TzNnNGRPZ0VnSVdl?=
 =?utf-8?B?c0gyVjhLN3N1Z0xhUUdoVFRwb2xrL3lhUWFJUW9CSGlxMHlzTnpUTDhZeFZK?=
 =?utf-8?B?QlBPM202ZElXbm1JMGpBc09ET0RYWjVxV3FhTG1yZGs3MGE4VERaek9HZFdM?=
 =?utf-8?B?S2ZtRUlzRS84VXZTck95eHQ5cWw5T3pXT0dENmVoM3g5R3E0VGtHaVBTWld4?=
 =?utf-8?B?VVh0RU9BQm5BOW9vZ2k2QzllQlNpQ01lWUZwMVlCeTFESmJqNmhPaDNFaUhI?=
 =?utf-8?B?am9iVVpDZWk3TUh3Q3dwUU81dVV3S1VHVmdiTUhjMTlORDVUNSt1S1ZCS1NE?=
 =?utf-8?B?ZlVFWjBOVndEdnp3MHNBUVN1WlNDVG4zakNqdzFhM09FM0orelY2UjFOcndE?=
 =?utf-8?B?Tm4yRllqR0dES3FWNlhPYXJIRkhTc2h5dDNnb0krbDdSbVJRVVozbzVQb2h5?=
 =?utf-8?B?UEI5NlNZRjNTRWdobENWOTh5M25lMDZsY0FCeHFyS3pIUjNPcTJ3bUN5Zm82?=
 =?utf-8?B?dGxFdlY2N1pBVWZjVDd0M29qMjZuODBzTE5TRmttR2Nwb2RwTlQ0UHdhMFJX?=
 =?utf-8?B?VlRzVFBLSEx3ZTQwWUFlcG1KZW83ZU5UekZseStiYWM3a1pMYzFkcEFhS2tC?=
 =?utf-8?B?R2pzM3Rtdi84NytPSisyLy95RWpVV0tmWWtQSThpc1pScGQ1R2tJZVA2RGZz?=
 =?utf-8?B?ZURKWFhwSWE2Q1F4K2tKWHFISnZWWWR3aDJlMVlhem41ZGhEOXhzMGVJQnhz?=
 =?utf-8?B?UHpZSS9QRHdxcm9sLzJjVnd4TjNvM2N1Wmx1T1E4V2lEVExZRWJFYjhWVDFp?=
 =?utf-8?Q?sEuDlwb5GPViB460Nqau8IrwM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bf8203-62ae-4af4-9aeb-08dc26c0f109
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 03:08:49.8859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 714ESsuyv21a2cDubADkLuwwexxDYr3ttAtEilxuVhZTbCjQCoaNFoQZP0A+CxFYqmVhfsTUjGztrck83m/0ejussG55KardFcUkAKUOkNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6683
Received-SPF: pass client-ip=52.101.128.6;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgNSwgMjAy
NCA5OjE2IFBNDQo+IFRvOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1
Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpB
U1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBD
QyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9s
ZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjAgMS8yXSBhc3BlZWQ6
IHN1cHBvcnQgdWFydCBjb250cm9sbGVyIGJvdGggMCBhbmQgMSBiYXNlDQo+IA0KPiBPbiA1LzIv
MjQgMTE6NDYsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+IEhlbGxvIEphbWluLA0KPiA+
DQo+ID4gT24gMi81LzI0IDEwOjE0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+IEFjY29yZGluZyB0
byB0aGUgZGVzaWduIG9mIEFTUEVFRCBTT0NTLCB0aGUgdWFydCBjb250cm9sbGVyIGlzIDEgYmFz
ZQ0KPiA+PiBmb3IgYXN0MTB4MCwgYXN0MjYwMCwgYXN0MjUwMCBhbmQgYXN0MjQwMC4NCj4gPj4N
Cj4gPj4gSG93ZXZlciwgdGhlIHVhcnQgY29udHJvbGxlciBpcyAwIGJhc2UgZm9yIGFzdDI3MDAu
DQo+ID4+IFRvIHN1cHBvcnQgdWFydCBjb250cm9sbGVyIGJvdGggMCBhbmQgMSBiYXNlLCBhZGRz
IHVhc3J0X2Jhc2VzDQo+ID4+IHBhcmFtZXRlciBpbiBBc3BlZWRTb0NDbGFzcyBhbmQgc2V0IHRo
ZSBkZWZhdWx0IHVhcnQgY29udHJvbGxlciAxDQo+ID4+IGJhc2UgZm9yIGFzdDEweDAsIGFzdHQy
NjAwLCBhc3QyNTAwIGFuZCBhc3QyNDAwLg0KPiA+DQo+ID4gVGhlIGJvYXJkIGRlZmluaXRpb24g
Y2FuIHNldCAnYW1jLT51YXJ0X2RlZmF1bHQnIHRvIGNob29zZSBhIGRpZmZlcmVudA0KPiA+IGRl
ZmF1bHQgc2VyaWFsIHBvcnQgZm9yIHRoZSBjb25zb2xlLCBvciB1c2UgdGhlICJibWMtY29uc29s
ZSIgbWFjaGluZQ0KPiA+IG9wdGlvbiAuIElzbid0IGl0IGVub3VnaCA/IE1heSBiZSBJIGFtIG1p
c3VuZGVyc3RhbmRpbmcgdGhlIG5lZWQuDQo+ID4NCj4gPiBUbyBjbGFyaWZ5LA0KPiA+DQo+ID4g
QVNQRUVEX0RFVl9VQVJUMSBpcyBpbiB0aGUgZmlyc3Qgc2VyaWFsIHBvcnQgb24gdGhlIGJvYXJk
cy4NCj4gPg0KPiA+IEkgdGhpbmsgd2UgY2hvc2UgdG8gc3RhcnQgdGhlIGluZGV4aW5nIGF0IDEg
YmVjYXVzZSB0aGUgQXNwZWVkIFFFTVUNCj4gPiBtb2RlbGluZyBiZWdhbiBmaXJzdCB3aXRoIHRo
ZSBVQVJUIG1vZGVsIChjb25zb2xlKSBhbmQgZm9yIHNpbXBsaWNpdHksDQo+ID4gd2UgY29waWVk
IHRoZSBkZWZpbml0aW9ucyBvZiB0aGUgZGV2aWNlIHRyZWUgZnJvbSBMaW51eCA6DQo+ID4NCj4g
PiAgwqDCoMKgIHNlcmlhbDAgPSAmdWFydDE7DQo+ID4gIMKgwqDCoCBzZXJpYWwxID0gJnVhcnQy
Ow0KPiA+ICDCoMKgwqAgc2VyaWFsMiA9ICZ1YXJ0MzsNCj4gPiAgwqDCoMKgIHNlcmlhbDMgPSAm
dWFydDQ7DQo+ID4gIMKgwqDCoCBzZXJpYWw0ID0gJnVhcnQ1Ow0KPiA+ICDCoMKgwqAgc2VyaWFs
NSA9ICZ2dWFydDsNCj4gPg0KPiA+IFdlIHJlcGxpY2F0ZWQgdGhpcyBpbmRleGluZyBzdGFydGlu
ZyBhdCAxIHRvIG5lYXJseSBhbGwgZGV2aWNlIG1vZGVscyA6DQo+ID4NCj4gPiAgwqDCoMKgIEFT
UEVFRF9ERVZfVUFSVDEgLSAxMw0KPiA+ICDCoMKgwqAgQVNQRUVEX0RFVl9TUEkxIC0yDQo+ID4g
IMKgwqDCoCBBU1BFRURfREVWX0VIQ0kxIC0yDQo+ID4gIMKgwqDCoCBBU1BFRURfREVWX1RJTUVS
MSAtIDgNCj4gPiAgwqDCoMKgIEFTUEVFRF9ERVZfRVRIMSAtNA0KPiA+ICDCoMKgwqAgQVNQRUVE
X0RFVl9NSUkxIC0gNA0KPiA+ICDCoMKgwqAgQVNQRUVEX0RFVl9KVEFHMCAtIDHCoMKgwqDCoMKg
IDwtLS0gISENCj4gPiAgwqDCoMKgIEFTUEVFRF9ERVZfRlNJMSAtIDINCj4gPg0KPiA+IEkgZG9u
J3Qga25vdyB3aGF0IHdvdWxkIGJlIEFTUEVFRF9ERVZfVUFSVDAgaW4gdGhpcyBjb250ZXh0Lg0K
PiA+DQo+ID4gTWF5IGJlIHlvdSBjb3VsZCBzZW5kIGEgc2ltcGxpZmllZCBBU1QyNzAwIFNvQyBt
b2RlbCB3aXRoIGRlZmluaXRpb25zDQo+ID4gb2YgYSBtaW5pbXVtIGFkZHJlc3Mgc3BhY2UgYW5k
IElSUSBzcGFjZSA/DQo+IA0KPiBMb29raW5nIGF0IFRGLUEgZGVmaW5pdGlvbnMsDQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9BUk0tc29mdHdhcmUvYXJtLXRydXN0ZWQtZmlybXdhcmUvY29tbWl0Lzg1
ZjE5OWI3NzQNCj4gNDcNCj4gDQo+ICNkZWZpbmUgVUFSVF9CQVNFCVUoMHgxNGMzMzAwMCkNCj4g
I2RlZmluZSBVQVJUMTJfQkFTRQkoVUFSVF9CQVNFICsgMHhiMDApDQo+ICNkZWZpbmUgQ09OU09M
RV9VQVJUX0JBU0UJCVVBUlQxMl9CQVNFDQo+IA0KPiBBcyBDw6lkcmljIGRlc2NyaWJlZCwgd2Ug
aGF2ZSBURi1BIFVBUlQxMl9CQVNFIC0+IFFFTVUNCj4gQVNQRUVEX0RFVl9VQVJUMTMuDQpBcyBD
w6lkcmljIGRlc2NyaWJlZCwgdGhlIFVBUlQgZGVmaW5pdGlvbnMgb24gdGhlIEFTVDI3MDAgYXJl
IGRpZmZlcmVudCA6DQogICANCiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9s
aW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9h
c3BlZWQtZzcuZHRzaQ0KDQoJc2VyaWFsMCA9ICZ1YXJ0MDsNCglzZXJpYWwxID0gJnVhcnQxOw0K
CXNlcmlhbDIgPSAmdWFydDI7DQoJc2VyaWFsMyA9ICZ1YXJ0MzsNCglzZXJpYWw0ID0gJnVhcnQ0
Ow0KCXNlcmlhbDUgPSAmdWFydDU7DQoJc2VyaWFsNiA9ICZ1YXJ0NjsNCglzZXJpYWw3ID0gJnVh
cnQ3Ow0KCXNlcmlhbDggPSAmdWFydDg7DQoNCkFjY29yZGluZyB0byB0aGUgY3VycmVudCBkZXNp
Z24gb2YgQVNQRUVEIFFFTVUgVUFSVCBtb2RlbCwgaXQgdXNlZCAiMSIgYmFzZSBkZXZpY2UgbmFt
ZSBhbmQNCkZvbGxvdyB0aGUgSVAgbmFtZXMgaW4gdGhlIGRhdGFzaGVldA0KVGFrZSBhc3QyNjAw
IGZvciBleGFtcGxlOg0Kc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI2MDBfbWVt
bWFwW10gPSB7DQogICAgW0FTUEVFRF9ERVZfVUFSVDFdICAgICA9IDB4MUU3ODMwMDAsDQp9DQpB
U1QyNjAwIGRhdGFzaGVlIGRlc2NyaXB0aW9uOg0KQmFzZSBBZGRyZXNzIG9mIFVBUlQxID0gMHgx
RTc4IDMwMDANCkJhc2UgQWRkcmVzcyBvZiBVQVJUMiA9IDB4MUU3OCBEMDAwDQpCYXNlIEFkZHJl
c3Mgb2YgVUFSVDMgPSAweDFFNzggRTAwMA0KQmFzZSBBZGRyZXNzIG9mIFVBUlQ0ID0gMHgxRTc4
IEYwMDANCkJhc2UgQWRkcmVzcyBvZiBVQVJUNSA9IDB4MUU3OCA0MDAwDQpCYXNlIEFkZHJlc3Mg
b2YgVUFSVDYgPSAweDFFNzkgMDAwMA0KDQpIb3dldmVyLCBkZXZpY2UgbmFtZSBvZiB1YXJ0IGNv
bnRyb2xsZXIgaGFkIGJlZW4gY2hhbmdlZCB0byAiMCIgYmFzZSBmb3IgYXN0MjcwMC4NCklmIHdl
IHdhbnQgdG8gY29udHJvbCB1YXJ0MChBU1BFRURfREVWX1VBUlQxKSwgd2Ugc2hvdWxkIHNldCB0
aGUgbWVtb3J5IG1hcCBhcyBmb2xsb3dpbmcsDQoNCnN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVk
X3NvY19hc3QyNzAwX21lbW1hcFtdID0gew0KICAgIFtBU1BFRURfREVWX1VBUlQxXSAgICAgPSAg
MFgxNEMzMzAwMCwNCiAgICBbQVNQRUVEX0RFVl9VQVJUMl0gICAgID0gIDBYMTRDMzMxMDAsDQog
ICAgW0FTUEVFRF9ERVZfVUFSVDNdICAgICA9ICAwWDE0QzMzMjAwLA0KICAgIFtBU1BFRURfREVW
X1VBUlQ0XSAgICAgPSAgMFgxNEMzMzMwMCwNCiAgICBbQVNQRUVEX0RFVl9VQVJUNV0gICAgID0g
IDBYMTJDMUEwMDAsDQp9DQoNCkFTVDI3MDAgZGF0YXNoZWV0IGRlc2NyaXB0aW9uOg0KQVNUMjcw
MCBpbnRlZ3JhdGUgMTMgc2V0cyBvZiBVQVJULg0KQmFzZSBBZGRyZXNzIG9mIFVBUlQwID0gMHgx
NEMzXzMwMDANCkJhc2UgQWRkcmVzcyBvZiBVQVJUMSA9IDB4MTRDM18zMTAwDQpCYXNlIEFkZHJl
c3Mgb2YgVUFSVDIgPSAweDE0QzNfMzIwMA0KQmFzZSBBZGRyZXNzIG9mIFVBUlQzID0gMHgxNEMz
XzMzMDANCkJhc2UgQWRkcmVzcyBvZiBVQVJUNCA9IDB4MTJDMV9BMDAwDQpCYXNlIEFkZHJlc3Mg
b2YgVUFSVDUgPSAweDE0QzNfMzQwMA0KQmFzZSBBZGRyZXNzIG9mIFVBUlQ2ID0gMHgxNEMzXzM1
MDANCkJhc2UgQWRkcmVzcyBvZiBVQVJUNyA9IDB4MTRDM18zNjAwDQpCYXNlIEFkZHJlc3Mgb2Yg
VUFSVDggPSAweDE0QzNfMzcwMA0KQmFzZSBBZGRyZXNzIG9mIFVBUlQ5ID0gMHgxNEMzXzM4MDAN
CkJhc2UgQWRkcmVzcyBvZiBVQVJUMTAgPSAweDE0QzNfMzkwMA0KQmFzZSBBZGRyZXNzIG9mIFVB
UlQxMSA9IDB4MTRDM18zQTAwDQpCYXNlIEFkZHJlc3Mgb2YgVUFSVDEyID0gMHgxNEMzXzNCMDAN
Cg0KQXMgeW91IHNhaWQsIHVhcnQxMiBtYXBwZWQgQVNQRUVEX0RFVl9VQVJUMTMuDQpUaGUgZGV2
aWNlIG5hbWluZyB3aWxsIGNvbmZ1c2UgdXNlcnMgYmVjYXVzZSB0aGUgZGV2aWNlIG5hbWUgaW4g
cWVtdSBtaXNtYXRjaCB3aXRoIGFzdDI3MDAgZGF0YXNoZWV0Lg0KDQpUaGF0IHdheSB3aHkgd2Ug
d2FudCB0byBhZGQgQVNQRUVEX0RFVl9VQVJUMCBhbmQgc2V0IHRoZSBtZW1vcnkgbWFwIG9mIEFT
VDI3MDAgYXMgZm9sbG93aW5nLg0Kc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI3
MDBfbWVtbWFwW10gPSB7DQogICAgW0FTUEVFRF9ERVZfVUFSVDBdICAgICA9ICAwWDE0QzMzMDAw
LA0KICAgIFtBU1BFRURfREVWX1VBUlQxXSAgICAgPSAgMFgxNEMzMzEwMCwNCiAgICBbQVNQRUVE
X0RFVl9VQVJUMl0gICAgID0gIDBYMTRDMzMyMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDNdICAg
ICA9ICAwWDE0QzMzMzAwLA0KICAgIFtBU1BFRURfREVWX1VBUlQ0XSAgICAgPSAgMFgxMkMxQTAw
MCwNCiAgICBbQVNQRUVEX0RFVl9VQVJUNV0gICAgID0gIDBYMTRDMzM0MDAsDQogICAgW0FTUEVF
RF9ERVZfVUFSVDZdICAgICA9ICAwWDE0QzMzNTAwLA0KICAgIFtBU1BFRURfREVWX1VBUlQ3XSAg
ICAgPSAgMFgxNEMzMzYwMCwNCiAgICBbQVNQRUVEX0RFVl9VQVJUOF0gICAgID0gIDBYMTRDMzM3
MDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDldICAgICA9ICAwWDE0QzMzODAwLA0KICAgIFtBU1BF
RURfREVWX1VBUlQxMF0gICAgPSAgMFgxNEMzMzkwMCwNCiAgICBbQVNQRUVEX0RFVl9VQVJUMTFd
ICAgID0gIDBYMTRDMzNBMDAsDQogICAgW0FTUEVFRF9ERVZfVUFSVDEyXSAgICA9ICAwWDE0QzMz
QjAwLA0KfQ0KDQpUaGFua3MtSmFtaW4NCg==

