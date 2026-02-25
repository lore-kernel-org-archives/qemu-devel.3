Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E286F5543B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OS-0003k4-HI; Tue, 24 Feb 2026 21:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OQ-0003jB-PP; Tue, 24 Feb 2026 21:12:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OP-0000Tx-C8; Tue, 24 Feb 2026 21:12:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzvC0/Dmi7HdiQk8iguz45cJ57mUHzE0KJVc+iDd4Bmtbhi2lEBi/98aa8kVBoZfZ+YJhXj9lH70KgYIa8kk6ofjwae5v/1GOPQ20ALhbZPfpvHckvBzVzcIxiymtktaWk8giGsLmdLEmo5bentrl4Yep43z7QdCBj37bHF2Cw0VBt5gTYcRDSfmvlKzpccBsEhu9H+qzUPeH6uhxGocJAItd/cY4KRa1bGihfzQcnyK+8i0i/Y61ywW1fw+mdLfmYBNtveCmO6n/PreLitnSEtoUeCa+48IQ5Tmohxr1q2abrilwF4FdfjUfQLrOFr344UVP5lYXs/xp8tHDptZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t43UqlfXy0cDcEiZE9jRMrUVBqY+jgCB3a7fbVzgYnY=;
 b=ZXTAnkJR/x1aMZmaRhEhGAkKnJ8bWZQxrnBFxWFXXG6N2m5EwI2fDN9IrBSM8bTZBXp4HhzPvo3UGCuFP7j8voh28tPjZHqkS9QAYxgPllTnNTQ+HY8dYf5Nws8/7k49JjExXN4fel4elqW0CY8RKxviH4cPdqkuZ/qiOFMxdbJTL2zfzM1xotlFUYHxp5gN5whmsa3APIjig+Dhs1RLjRpLYzUe5ovlgsT7FW5TwXmbO8Xn8crWK5TjuAm6y7TKmVl0uc+aYLoLuwg0D7SK73RlPMi6ETQKck3+9yC1pAbM2QrVDHRNR3RDrOombycXqyMvWnp1Yo9wzshxHgjgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t43UqlfXy0cDcEiZE9jRMrUVBqY+jgCB3a7fbVzgYnY=;
 b=hDJnAlTMdEGJ6E/2iZ5s0xBnTiBoPiga0Aq+KG4XgPdOs3xX6LfE2R4RuAvDA8Qq0odWuhQYObo8EY8+whCLYFnM0F8a1ltbDBpLZfNmBffe+TxO7QWRAyFakeREWEm9YgNO4jqHTK3uXcnhN1Jh2GCJ3rQOS06b4Ip4hMeT2+5Qh36DcpFXxbY/kJsbpDfMi2YUsWRlgrpt2hj14e4gfnyybmw+aYHphl+jfRDz7Ps/17cfYRQE35ss6TAra+/UP3tcTlJaPLqNFOr1l/vwcASLBwlF2Jnb5u8wtu33Xlw23L8p9gswS580Zhvwu+umf0TvFAOdhg/Y8MbCuNUpHQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5702.apcprd06.prod.outlook.com (2603:1096:820:b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 22/22] MAINTAINERS: Add I3C maintainers and reviewer
Thread-Topic: [PATCH v7 22/22] MAINTAINERS: Add I3C maintainers and reviewer
Thread-Index: AQHcpfw3Bh28mn3Rr0eCgeEf1SafXA==
Date: Wed, 25 Feb 2026 02:12:40 +0000
Message-ID: <20260225021158.1586584-23-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5702:EE_
x-ms-office365-filtering-correlation-id: eaf0f61d-7a9b-41c2-8dab-08de74135a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?biRYkzJS7g5JSGlyxBMBfOKyETZdfAuBw218YP8xEtFKz9rlG1TE/CHtkz?=
 =?iso-8859-1?Q?LEOig+wY+XAPvqWcdNYAqtFx2t7Xk9MdvJaQqWGrVVEdNvYHH6GLQyJhnY?=
 =?iso-8859-1?Q?m28pf9EON1vIK+wgCzUBbcCq7kvNfBpbEwPocJI7JUtp8lYaNKc5YX2saW?=
 =?iso-8859-1?Q?/eZ0SZgZ3ft6LLAmF6JWBOSJTg9gwN6+XBG2X4ql1L2QI0fM/kQvYWZSUZ?=
 =?iso-8859-1?Q?Y9q1VUN92kXq+4REXzNCqzZa6xGqnYIhu9DTRZsHSJw5G+jcdSkGHl1WYL?=
 =?iso-8859-1?Q?Z8w7ccGD7jQT1NvVxb2H2TnxZGAQqPPOK907Y0Vhi0xrU73Z98W+nlaL/c?=
 =?iso-8859-1?Q?SxfwerLEI9XDVB7FNvXrBx+YhMni0Rdln/Oyr3F9nTXZSaV+xbLfgKQK1I?=
 =?iso-8859-1?Q?seYuDudQEmeBCJxCrI/esTYfs99x7E4FH1Ldzk5Q26Jfh2XwMFIacG21Fn?=
 =?iso-8859-1?Q?G46gNcbuIBOov6xb3Utihz5631UOMv2PeHCEQ/hBGPAwuR1yXfQ44qIp+G?=
 =?iso-8859-1?Q?n68XQFa5MwamjmLaOjvM4Gvzz1XZMWe+wYFisBA1TroU7eKy9rqw9W9Fvd?=
 =?iso-8859-1?Q?4SsG14gO5kAZTjoIUdRJceYok3tky+xTexVzTT/ny03eubD3An5YO6rNHH?=
 =?iso-8859-1?Q?QQwWNihmA8FGZB/hqTbP05EkibCMc9sytOYJkKVdaIpkN7evtH0wNR8Q3D?=
 =?iso-8859-1?Q?nSAJDkOh8bVJAQO0WKNbnoTiUIf8Gy5p9ZD+YhmblPmXm/rv+jI31cWrhc?=
 =?iso-8859-1?Q?XoLoS8Ywo1f6DfR9nttVtin5YBDGrWZkHtpmdzYJYC9AB4Spck7UsOa7OM?=
 =?iso-8859-1?Q?x7anZXB+Rx7ChiAbybZyT3EtubKOeSCLGZJI/f9ywsPjdV3qAFSicDXxaS?=
 =?iso-8859-1?Q?ICUcTADyJT0kTLMM6faiHlMhxDo/y0EwURz6z33Bx1IU8H9pzuGXTuw0ZR?=
 =?iso-8859-1?Q?xNF4ZrNmaxVHPlu2dEcNcgTc3QwNW2z3pLTZSLdgslw1W4yORfuuG7Ks7L?=
 =?iso-8859-1?Q?frnF2A/KXaJoYwEWH6Vec4pltPT162j/GxZ5tN6uFcgzKv/VHiO1eqBoUZ?=
 =?iso-8859-1?Q?MdVh1EgeylxIqwySlCXeWGMQeX89baFOzi7OUI05iGsv8kOwf3I+2KPfFe?=
 =?iso-8859-1?Q?K48xrkX4WQzo7xtDO2fruJqfq20M+v9fBOzZDjLBt115FMA5PODK6PjKHP?=
 =?iso-8859-1?Q?R7aXahb4VVT42FNt9vwv9p9iaP/VUis/KsuXKnV3YU0vVmNByCQKQAMv8c?=
 =?iso-8859-1?Q?wC4MZJLzOztQ/V7ZLLj4+lP/RAiPgl0r6dUJy28JrPQB41kZdffFbT9GA7?=
 =?iso-8859-1?Q?+4R+JnnKWxE0Zrg+LRpj3kKP/aTTXyIp/1ce05P5XXVZs8/dao8pRrKhIs?=
 =?iso-8859-1?Q?V9gFu1kQYehqOIZArCXTUfTPFZB7UEU7uP8uQRHmUPb+4EUEjr3egzxXF1?=
 =?iso-8859-1?Q?MVQ4bHPPhsWlaGaU0aIpJ44VAH3mY4xKs9FMnfZXwScWiNUGoFcsqcR5QM?=
 =?iso-8859-1?Q?pdT1U8y4ZWw1RYKNqdXnTMGKBzy958nOF98ynHqL4D2owO2pEdMm5u90rs?=
 =?iso-8859-1?Q?Zw2sAlPb6aL1VK89Ct/dUH59ckGmXyjNz5afE+UVQRXHw5QGqnPyiskChl?=
 =?iso-8859-1?Q?Xem+Iyy6EqgVtg+T/1ZFN6e9tv4w9LNrCCfefqykLua9VMAGcXzYUy345M?=
 =?iso-8859-1?Q?LYlthTwNPEXD9qhSiUz/hl75MOK6Hgt66FleIRMp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n8edgxcwQuOGuve0iqk7sfXU3sLvxJlzWiSSpPKReaIPzlYafU6To5/tMw?=
 =?iso-8859-1?Q?Iggh4X7W3AqmDx2+Y4CVhNGj/tEvrpfJGJVTzNnMv9WP4WPPGTXIM6AgRa?=
 =?iso-8859-1?Q?U8f5rjEOMsTLJfBVo9sHCciKc+pJveaqG8gCHsamty9rYN1THsdiAvyj59?=
 =?iso-8859-1?Q?DmlcXHwwPq8yEy/auzYz/yRNmpezU48HAqc6hojzX/bEa/yyw8p3CYDTXY?=
 =?iso-8859-1?Q?DifyXw1TIliDb7n1iZ5lO2eI+eRxpwlTjBNUE8LtLeE9loFtD3x74I0y6Z?=
 =?iso-8859-1?Q?EV8B+i1HpBMIwN8pr0jbAcNw+KAte9PaPUY8JPHTYgetPw6g8wQpkETZiX?=
 =?iso-8859-1?Q?s25IVPbjpvgE28Akcl47nhuFe9C4jdDm6ZJwNi7Ry5MGmzvw/it7svhScr?=
 =?iso-8859-1?Q?am2yaT2jUfzm+TF6RLvhL1SWK7Me93n5E8n5yJ3IuE44favUzBxrXXm0EX?=
 =?iso-8859-1?Q?7h9ssyt/RpQgV6/L9IEbKR4rfgfpRBQR+JCFdD+amMSyhNqiqxhxDWe/iP?=
 =?iso-8859-1?Q?gnFYXjUgnJG+AK20M/DU+D9m6SzJQ5UIdEyjHqjpE17N/L7dNNFP5J0TQd?=
 =?iso-8859-1?Q?4UW4aWkrh5DLePe2l0Y3SiC3mZxCZCfOXIBwiHt9cbDkpT4EYrJ+yrU2DV?=
 =?iso-8859-1?Q?xP0kxMyZ7vKxbBtvqn58hO8Ju8ywfzJunIBOq8IjHFIU8mShxlLRUHxNMJ?=
 =?iso-8859-1?Q?FFM3dSD2EvzrRm+3qJMGt9IL20vARJCFDDhhyYOmp4TUCxALrYGZSGzrNO?=
 =?iso-8859-1?Q?pxFoHUumMH3++g6dJddE83xHOwYYx4GdC7/Lo1p4teJlh0RXlyGj7qRNPx?=
 =?iso-8859-1?Q?p5S1Ro/KX0l21qlCfWVGptW9mc3AwEWGc5AD9DHaKdwEBQTK3M7HB6HjlI?=
 =?iso-8859-1?Q?7h5rzDwJPuknW8yKgZ8jrDI/fr28JTI6UR4JCZ0YgdS2H6SST2Hohj+FDU?=
 =?iso-8859-1?Q?G4K294DiGlDOlgfv1La8zWyx4wNbYzTJWUG6WeGO8uE8Ibxsm/664ioA0R?=
 =?iso-8859-1?Q?HsyGhR8ejQCI1SUvvo8Imov7BURQ7gQS2eEsrM75BmFyZz5Ns6rFOFMbYv?=
 =?iso-8859-1?Q?uZ203LCCUjKC0jPEX4VVkNBqxD4lCkPUXimuDpghv05CfpFjpl8BwvEj+j?=
 =?iso-8859-1?Q?LrhDqOFS7DNFt+7rzt8NnjohL1GWpOmdq+1OwsdR8WS0B06R9QVC7JYO1l?=
 =?iso-8859-1?Q?Cm/flkmQvBzILiWyxWhPRp0GmJYjffhfEKwVKrLWXcW6W28nF6r58ynkYI?=
 =?iso-8859-1?Q?OsMfGf4xYPZLAOE2d+M+KoWbT7U2S1fjvwldADLjFYY64o/kxgqkHZn3lY?=
 =?iso-8859-1?Q?+cq1dE4D/RJ/yexay3Ta555odyegV4ueQxbzG2BeEuIXWhpQFAwAqfTpFA?=
 =?iso-8859-1?Q?3m+4y0/XaWHmZlr/0lRhS7w5L1mvffGkeLfJtK+Vq1i59ErKLoNfxgA+Hh?=
 =?iso-8859-1?Q?Fnm2S6BShC1x8uxcCCyahOYNtn7jowYuhtbubzMcMwTIt9WMMTst4UZWzu?=
 =?iso-8859-1?Q?tG+GRLqgadvK6/2776Kelxt7I1MOEFAStcUVodmoXiXVEmmxrJ5FuwPPkr?=
 =?iso-8859-1?Q?1rSGz+3q1fdKhgKBpuz9nMPs0PNNlUEqVHezeii0jeHzErLukDJqI/6/Gj?=
 =?iso-8859-1?Q?PEZUvomimZq/2DE//Z9I8shYL46rZXn99Xl8729loKSOPuFxZQ56MROAXa?=
 =?iso-8859-1?Q?lb8Ty8caero8PEyRObnRp9pxHsUUyOQze+d6RFB5D+YxBy20oGAbtkVpyP?=
 =?iso-8859-1?Q?cQJvV6+b2r0CyRafFf0no9244koKupEZcxNU0zEFbNaXalp9A1qVvKo8KP?=
 =?iso-8859-1?Q?WqpXRgzBzA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf0f61d-7a9b-41c2-8dab-08de74135a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:40.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjkKmjyTrnL8lJMPMrVZIzxk3TwkCj0MYeRLsu4v8/nYyw1QgCV1HzEtwGm8fyN0QSIYIitI3C7MgnI037M/jNopNmHdDbdvFJnj8zM6pIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5702
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

Add a new I3C section to the MAINTAINERS file.=0A=
=0A=
List Joe Komlodi, C=E9dric Le Goater and Jamin Lin=0A=
as maintainers, and Nabih Estefan as the reviewer,=0A=
covering the I3C core and related files under hw/i3c/=0A=
and include/hw/i3c/.=0A=
=0A=
Signed-off-by: Nabih Estefan <nabihestefan@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 MAINTAINERS | 13 +++++++++++++=0A=
 1 file changed, 13 insertions(+)=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 233d2a5e71..3b90a5f735 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -3933,6 +3933,19 @@ F: include/hw/i2c/smbus_master.h=0A=
 F: include/hw/i2c/smbus_slave.h=0A=
 F: include/hw/i2c/smbus_eeprom.h=0A=
 =0A=
+I3C=0A=
+M: Joe Komlodi <komlodi@google.com>=0A=
+M: C=E9dric Le Goater <clg@kaod.org>=0A=
+M: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
+R: Nabih Estefan <nabihestefan@google.com>=0A=
+S: Maintained=0A=
+F: hw/i3c/*.c=0A=
+F: hw/i3c/.h=0A=
+F: hw/i3c/Kconfig=0A=
+F: hw/i3c/meson.build=0A=
+F: hw/i3c/trace-events=0A=
+F: include/hw/i3c/*.h=0A=
+=0A=
 PMBus=0A=
 M: Titus Rwantare <titusr@google.com>=0A=
 S: Maintained=0A=
-- =0A=
2.43.0=0A=

