Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4682DE67A68
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 05:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxHrP-0002PB-UM; Mon, 02 Mar 2026 23:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxHrH-0002OD-Pd; Mon, 02 Mar 2026 23:59:49 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxHrE-0003IU-IR; Mon, 02 Mar 2026 23:59:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwXpct+fLywAtH3dsh5c4v/wQzwsHl5RzWrBMZpW7bH/ow8qTy99j1XNMxvKe+ekCx0kM+gPhbcaQZPF8YKKg+RpOnfFl19lPZwJSl1ramb/WndUyA1oGL/c3F9mqNYLpXsZUxmodAQRCnsB7doBVdo212otLdjSl8j1m7iUvWsBLESs3/9dH9U3sCnZvoQuF90cNtETNKHO4Db5O5i9v1C48XuZloF5wEW1Ku+RD24EKoKnJiSbFh0WDCz/zSx6gBqLgih1MZvBqCbWKE3quijQJ76bLxcb7Qo6PjryF71Tz/dw+kiybv42ZRxbwbs4c23dQ5nF9exghqc25U4GuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj+JECj9Jw+pGQEWdMegdkYv/HSTy7ZdzCjeQvgzTEM=;
 b=bW8+aOuGkT1krICE7Ud0qNvb3l9lSal5lmcF1qTkzRX2CXWYOr0E6rmE3fMCoxjRSsC6j2iugHof42cS61T/ABj2tzyAHEPnuCZJdsFLETDQaDDpRO4W/60P/vAZ/fm879VV/IYr+T8RcVwVXv1lrcJpMe1EkdsK3azb89Q39XjvUTFTQvQtT4rFxEWe8rhdTdsoNy9l/iEXKwh30XPELfh9EvVKk0f7BjVgH6Fams1rClx75LsWHPcAoEuVoraegM1ar/D2ICEjIBwNABULeyNNcbxXfu/epacUumHvnvjDoFPDRfgkBdxu8fHnAXbgC8aTs4ew3/PC32OjANEj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj+JECj9Jw+pGQEWdMegdkYv/HSTy7ZdzCjeQvgzTEM=;
 b=O0LPpKfJa70RYtPeq2GgqyvU2iGuNGOqAtldlOZcbMnrCiGpaDK2bdZUpFW7FzZh30DwMrA4j8Th3o12CQ6y+9OKOLa0kS1UsCBIGr7lP4v6EjrzuRTYkdftGGNTHhR3DAEGvRNLN15TVEIBK4RSTajd0t4tIHYQqe/8LCVppyJDHP7dn+VUmyCX6d9MD2WYd1BwSL5nFNF9DiZXEQO80npByn2wM19m83N7BPAE34K0Qe3FTgVbdiLcWeBD2g2rA5NvxGjIEHONV6lUjY1Zosy7INgkPyAu/hMuPe0qe+nquXlvR5yg3jI1E+aa9gF5ZyR80hKRT0qVjWdihqWUCg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8074.apcprd06.prod.outlook.com (2603:1096:d10:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 04:59:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 04:59:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPZc9fufOBn30qme+8Of+f8BbWcP/8Q
Date: Tue, 3 Mar 2026 04:59:33 +0000
Message-ID: <TYPPR06MB8206DEF9893F5E842D3386DCFC7FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8074:EE_
x-ms-office365-filtering-correlation-id: 0093f808-411c-4b5e-66bf-08de78e1a8f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: qFZdQ1zUJYDXsAFC6QxuW3g1HLUjPYlP8GEk7mdNDN4DHIW/zdcV29mIXbIQSJhAk3im9neCC04cVmKi4CmMspixK2flHiJZYrAZtJd5YFN4GcOjD5XEqOSJCG5wJtS3RC/LdDW/sjix9lvOKkQJEjYv1he2Aau4DOfonzKFA1bgCETJOAqEb7xW+oAdN9TVMaf26Q4LQUukD8nASU6BJZTsfpBX8uOIEeusuorLajw5shYWbm8EK/uctyqcLt/hOCK7aWXp+YivSFDuZqD650YnB9lOZcq7IYN/KkfZ8nxrxKS241bWRgKCfD/ve0+myUqBk9p9iYSUoTw2fHJ6JthcuoBJdiKyrcaoHBZt93u8M9qMTTrTKCthPOfrF1li4bdG1Sb3bSuLaoQN7yT0B3pkaM8U1z4dE1lFK4BnEGwDNQkJ8AffiEB1+NGJ+OzuFiJdjJeB5IaIL9hYI5+9JFvDCBYWKbN+er2E2yBWyGs9leF6xflByU0KCTDPRiXBIj3ZnwnuvuRW5xrCy+Bg7t1cfZhspTEHIykUXYEvSgQAHTFYMizW0Z/LIpxSpX+q7hvASHf1KBwRY4WAnmuLnfLpVJPcZD7MhZyZSEVMFxCTw9SKVP1oXf455xCVwzoPxk2wpoqP68Kwz6HGofipLKnk4qfLszUAbpt7yPJ5fdemOW0P9Lj9wwwAl0ylCFs7ERy/7biYHSAZ/npIAJu1f0XqFlvQqhzsfBnoezHDUc7DsQl/JGnC7gTA6kJa/e0IFcT1tJ2MoD9H3pSflAp12cD6JY3HQIsknBelkqPi7Gc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rPIOMWWe0I1x5Nkdc9bcml2+drUKabbIzA/ilijRFT2cwHqmUbPtWv4L8Q?=
 =?iso-8859-1?Q?bSQKmFLUi2vgnmcBIAL+Qf1+qovSmic8MQQDnOSLDLHi5rTz8kNveQj73t?=
 =?iso-8859-1?Q?VBAYsqEmVPJoVH6xYkxAtJcntP79Gs39RJiM8UVQsrf95C7O7tzDBmrMgX?=
 =?iso-8859-1?Q?sVnC5ezon+i0y5s1J6O4eqQlU2BVooqQJdiscwQV4Sy3LthJZNoJ59CoIV?=
 =?iso-8859-1?Q?jiFMc63hQfPZzwhiyHLeAGyPCA1B53HLTPnvziEI6sCnA4WDY3OYRdLHzG?=
 =?iso-8859-1?Q?uuq9I2IjtcnBBaLM75nc3oKYkWg0XLOLjA1ShLddIwp/Gwx2SfpsfllGL1?=
 =?iso-8859-1?Q?85MukWggyhiIup7qNloYZH3qV1tXNqnkp5EsafegIFk96/KWyuFEfjDvLT?=
 =?iso-8859-1?Q?BPb57Ht+ds9GykoByYcdQKN3yC09HEtLEk4WG7IdkTAUJoFuh5rSjLwUue?=
 =?iso-8859-1?Q?YxYvnXuxL8L5WTZ/mtdzntcWdAz9NiDSlSFxR+bSoxdv9SdRN2ZyJTtdUk?=
 =?iso-8859-1?Q?Lh2LngIFdB2OPKCUEW1izdlsPp8rA/B7tn6SKff0VjIj0/Mgq9n5r+HupE?=
 =?iso-8859-1?Q?ConjgAUOLksdF2gvoTnKdzioZKABLWGTClFjSDrVhb/Mn/87MCLUpJTLE4?=
 =?iso-8859-1?Q?09Q7z+HXBrw9rWKZ21PC5/RH8TmRHsOMyfpVeVV6YRDNye3v9ji3Tpqn6b?=
 =?iso-8859-1?Q?jAAEP9gPMj/4cOYSqVuxhgM9xNbUx+BOCFwU+UpRTrcziRQuhUAS5YagZh?=
 =?iso-8859-1?Q?nW7ChA/KgIkME41uycb6MjniUi7ceZoC9VnSTOriM5CFrrKOvHlc2IsMNk?=
 =?iso-8859-1?Q?ew2Z1aNY4zaFbTk0GLCJrZUFJZxXdMAB60KhuWDgu2+cGBaMUqpXhlqQJL?=
 =?iso-8859-1?Q?WHW6M98XqXRsFHT/2wjXQdiOPG47kTWVFaU1Gwc+GN5Fp1cEgLz2uXzLIL?=
 =?iso-8859-1?Q?FL63C9+SdD8lMPpCLrwTiuSQhkc7NGRxLpzj6+rV+XCFzGZ2bNnE+i6N1D?=
 =?iso-8859-1?Q?YcMmD6RNjyBzajkeMrHzcAuF0R205K02ncTKgohbt4qzCl7GLR9vzNyj7v?=
 =?iso-8859-1?Q?cyTwiFA+tf+CPSWUqqWCGm2ZLI7UkVpuABdJTit7m6eN8eCrV0OSLLV4XA?=
 =?iso-8859-1?Q?N+w8834vZYysaylv0tBlchytfNiB6mnWFT2b3BbUNtcqXlbQKbi+yB/rY2?=
 =?iso-8859-1?Q?LepDGiuqLkMULO0X5uu8BjBEzp924c953jtMbgJOsIL32L8UHJHqyRtxeJ?=
 =?iso-8859-1?Q?ccuE4189DCLpbViiIzElULjr44qzPWaJEXf9Q/5E9mobZ0Nuzx5LARwML8?=
 =?iso-8859-1?Q?hrjF4OyOzlakJhgOqiF7XdwCWZKxUdG18JoXxh0Daz75xvxRjxqVeb45Km?=
 =?iso-8859-1?Q?A1t0iG94zwATNLvjn+yzRNyYCf9hAqvXH1ZbxdcLSBAQwiWeQ5aJgaMPQZ?=
 =?iso-8859-1?Q?esEtwgg2Wz2uwFS36SpGmc7SHH8bwS2+yE4YtxTcf5CijFLzwVGAoOjDTq?=
 =?iso-8859-1?Q?54C1pnXWbpFFY+VH4/JAsHqpK1id0S2iXuOSSjanXbDB9aVY1IKZfnte5x?=
 =?iso-8859-1?Q?iRDEQ3osEpkS/b1AIiraKTCFgytynDuHtj3fa07QQK5Oy3rCjSEiEqO5+w?=
 =?iso-8859-1?Q?0DoOpOmRt7tGxX92mOtPM31My88LXaV2Gls43KDKglRfbaeHx+FshGwOLm?=
 =?iso-8859-1?Q?nq+wuXEJFwIwo/EEFekV8MIU6LuDP2HRWhFGizykDwpiT1b7Nv2ozDz26w?=
 =?iso-8859-1?Q?6JmkZ0yuhgSfonHxrLx0jymSDm9SiaOEXUydDanMUbz6+qo/s3/rbHOlKA?=
 =?iso-8859-1?Q?evBrCZLD5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0093f808-411c-4b5e-66bf-08de78e1a8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 04:59:33.0451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOV0WXFIn5SkehyItWof2xQpV5F/c2mZkxLKMnpwDQbVAfnbM5JGjRe+umSOZjFK58ylk8uf2okUNREJa4KBFn/TQNr6EqItEhUi0SGjABY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8074
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

Hi C=E9dric,=20

We have updated the AST2700 DCSCM tarball due to a version issue. The AST27=
00 A2/A1 functional tests should also be updated accordingly.
I will resend version 2 shortly. Sorry for the inconvenience.

Thanks,
Jamin

> Subject: [PATCH v1 00/10] Update test ASPEED OpenBMC SDK v11.01
>=20
> The series is based on the aspeed-next branch from:
>   https://github.com/legoater/qemu.git
>=20
> v1
>  1. Update test ASPEED OpenBMC SDK v11.01 for AST2500, AST2600 and
> AST2700  2. Update test ASPEED Zephyr SDK v03.06 for AST1030  3. Update
> test aspeed-zephyr-project v03.05 for AST1060
>=20
> Jamin Lin (10):
>   tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr
>     SDK v03.06
>   tests/functional/arm/test_aspeed_ast1060: Update test
>     aspeed-zephyr-project v03.05
>   tests/functional/arm/test_aspeed_ast2500_sdk: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/aarch64/test_aspeed_ast2700a1: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/aarch64/test_aspeed_ast2700a2: Update test ASPEED
>     OpenBMC SDK v11.01
>   tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED
>     OpenBMC SDK v11.01
>=20
>  .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------
>  .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------
>  .../aarch64/test_aspeed_ast2700fc.py          | 18 +++++------
>  tests/functional/arm/test_aspeed_ast1030.py   | 12 ++++----
>  tests/functional/arm/test_aspeed_ast1060.py   | 14 ++++-----
>  .../functional/arm/test_aspeed_ast2500_sdk.py |  8 ++---
>  .../arm/test_aspeed_ast2500_sdk_515.py        |  8 ++---
>  .../functional/arm/test_aspeed_ast2600_sdk.py | 10 +++----
>  .../arm/test_aspeed_ast2600_sdk_515.py        | 10 +++----
>  .../arm/test_aspeed_ast2600_sdk_otp.py        | 10 +++----
>  10 files changed, 75 insertions(+), 75 deletions(-)
>=20
> --
> 2.43.0

