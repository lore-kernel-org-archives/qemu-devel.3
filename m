Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999F1E67A70
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQ4-0004vq-Kb; Tue, 03 Mar 2026 01:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJPy-0004ul-39; Tue, 03 Mar 2026 01:39:42 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJPw-0005qP-6f; Tue, 03 Mar 2026 01:39:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtIJgi1JD3/lbiA9F7DWGb0gG0O5rT4t6cyReo4iEFDd+b9lQhszTOD4Kw24xoIE0rOQ0VsTRD1rfHR0WwnGg+h1MIwPoHOhTnJ0qziEcjUdx7/jEAhJoJmF9/4hM5vx97hAcRCLTPsxddmAcMrkywahLrW8YBoZtAPSuu207vU70QnbYCH/PVizFrsvBTxzcYBpPAlfTfU9WvYgKoTXxz/sxnYPmU/TcKqG+q3guR9IRRqWVc7tJUpgP6ha1GDccDirW9UHGPdyVAY+wb8mMA9ceEy9k6hdk66jE5JQmPph2W4LNDyClr4YmvW0CsParDHz65mamEWtjZe0k4tvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/qLWNw0RWQsZHhIDNGLXfz5QIrgOug/i1dzgLLup0w=;
 b=PU5gZFbLz9BDxKb6xGslzGt2+/F1ICJ9b5R4b7LMwr244x2hAAxZeTQpS4CPUGh0C4PJxIlE0z4msfULy/mQWeeW/qqongLlAa23EtH/6icav2ArDUS6LkPQDvnjZ5vFML3gHsJcCIucaEe8IBTYTe2p3BM83M0t71zZc+hjuXFMdLR3WdHxtvlhZzwR2zKAekZRdqzNImzGVi/Rf0ANoCu87owwvz8fSC7THdh2jPly8RMjDamcHTlkan+XZv+WF8aAbxREUnoEgwGT7NrUDyjYFADO78OhYYxqE4phlYOGxmyKEksz8QN0zwB3TBmrfGlk+ZXIwLqYcZZj/R0s0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/qLWNw0RWQsZHhIDNGLXfz5QIrgOug/i1dzgLLup0w=;
 b=iAt5L2J8fm18cH08KR4341eYTNfgOOlk1jh/NanmrLZy1/8c1sbe/7/NfLzPzqbDYVO16brA+I1tldHETuDpz2epqQBDVM0byrvb0ujzs3nD5mWhbg8Kv2BQnwPJV/5do2Eyq45V5lNLy+qVhtcxQQJYj+P4TA4/+Nb/YzuAGT0e3rMz0hYpo3GCRAP9ajSVrTIYGS/eg2So4IXyofTwl1d8gMjh+tWidxAerId7sR1oCnV27K+ZNTZosEvNNq1g/iqmrEvQhDJrXeSBtL9Ej5EL7iR3hYH6vZXftlQJrXBZMriXmNrWhAKwQdOGkSg0k78eVTmcPtbULPr0kdkciw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 00/10] Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqth+pgCeRQI0a0G9cBDcM9Uv9Q==
Date: Tue, 3 Mar 2026 06:39:31 +0000
Message-ID: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 3c069dbc-5f4e-45d9-891a-08de78efa092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: HYP+ensprkaRs3047ywOD9zN7fSCMMXcfxvjqoYHIJYpbP8HABSw9JYpjtsJl3MOci2BA6QenNjz1kJN1GOgCM26I0xJg0kr7sKDgqVW8FPSKRCWXTOLBG5YcUJbWaqWqmuJjTtApM1i6w+TZ2UhnV2640Bf8g67FwvQCwL6yXZh78L6YKSw5AW3pGKjsyqmKRElNYJOMOfuxe4itFN0vzsZbsGnveuUIMw6U6+M9Y5pKwA/mdkZgURoArrGjXx57RyNmSayJa0kIpH7HGmSHba54Pux8AwRTWBh3VmEhSCnctdNCwWyNe3OYr3xJBkkKsu4DICTeiyqQEjSUMdAfKZJSj4OeLafYVg0AS3x4uKqX81x1WwYKVwlZvX1XcU/Dxc8ZioSX0bd8FOG4EB3yvLCBJ2RW6/MLStsoUvOHgRYqC9qG5BXzL0mb5coP09UrU+Yk9tdZjJQRGKzo4DeLV2t/e7TUKMHbKkEp3iSQDMbWSDH7ptAMYA8uoVeHdnxmAlUCZ+2ePufV0eglSqsw3Sx7J+H6eiJOjrg9LcLTgYym79yaPQEolZEGk5i9z/QVdisVt4IlzOybKAxWP6aj5cFGjm1jQgImEkbuFzxiSr3wZ9GGusepDh19lXCovH9WgfVQX2jzsb4UOXJCGishAonjnuLJAXPNNws7W62q0ZSf5feKAe+QQIi4WpEmfjZKABgcYMoU0ZfuHv2f7npC7zLEbbrpi9yFCi1b4/BdGv3FL+ENQDP2HwudoR/1xjkriKOyvchTQE7IX9iKfvLU2vbfKMqGnKxQxd9FiBCr7o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GkYIdAbNqqmXmMluy1VWmvY4LzM2HgZD4FXP/qetc/wAihkgqby92vVQdE?=
 =?iso-8859-1?Q?7SK7O4FTmXMseddW2jh5R+JYQCX/hlc+DBSS2g2b2TONg5k+2E2MGVwYQN?=
 =?iso-8859-1?Q?L9IlcZMPkPo8nz1OdrZLNQHRFX2exx0590oomFCj2FQub7yH0S2PO0I9mF?=
 =?iso-8859-1?Q?xQirVICdSpcjwkh4a7lEtgVDBeYds5Jy5c/tj96iKoD8oTQqUiQmbxu9/P?=
 =?iso-8859-1?Q?pX5fPs64D7VhoSSnWz/tzJ/v2oLld+K3DQYxAOIwtNU3Q7PHq2hRVY2jCa?=
 =?iso-8859-1?Q?W3VaO8llr5F/e0A3QfM+MskOqKPDGJgQs8R3cQ/NfaqCds2CNqbj+QFuQH?=
 =?iso-8859-1?Q?jUaPBhCYadUSD8HXR6tL0wTjuFoVxx1hf/p218gdyyl/oONqaf6XUrGPQE?=
 =?iso-8859-1?Q?C/4LImdj9FKDcSPtBzzpW/ZYN13mYmJBQ9FiNMyOLeNz0FnwORU0jTSoBI?=
 =?iso-8859-1?Q?UCvQQiXex6eqVJCWT03kncHVoPjlQGP2tMtBVDiR9LurCWGyA79o9rabyB?=
 =?iso-8859-1?Q?x0Xt72BXDzTVHUQTin1/6YUQxzf6TMQByWbZjdQNgyBIt7pRE066kUN0sR?=
 =?iso-8859-1?Q?hqeLZWp+FJ8bvfJ3vdzpaMmfx/FJoA0x/gj75aqg6IEfidtcPuEGf1hem2?=
 =?iso-8859-1?Q?1P1lGXl8uJDYAHc+iHEjUDRAbRc2LHgroxagwdnjaVsoKfqE5PTJRJQvOK?=
 =?iso-8859-1?Q?tB2ZjxC/f5ioBuVDFJgb6A/gJDTYgIn9xcUyVxvfkhLJPM3gRMe1Z7J33y?=
 =?iso-8859-1?Q?46G9vf90Ax1bJOsPWBGzUmmrHg1d65NYYLU6673onpljJ7hjU+jdbEMLNg?=
 =?iso-8859-1?Q?7cr30y4delmZxdI4PLfr+mDLpItju9Nfre6a8IIa0LXgO2Yrdc7pzlwg7h?=
 =?iso-8859-1?Q?EC+6oXizr12z7K0LIsfStM68ZIYr3gHXOMe8Chnc+EgYEDlPNVlPSrqQWW?=
 =?iso-8859-1?Q?D1Yw/qw7K95Z7XGsZKIT++MXB5fsjD7S2uxtvhswq02h2CbOyYuScvdtCW?=
 =?iso-8859-1?Q?uLIbOhl+J8V3MYI1fB2hMw4dhMzfhc6b+Cpq7vvaTl8lVeuj1KteUmCCpS?=
 =?iso-8859-1?Q?IYtxRFM344kLeecBuKWEW60i8n3lSUJut5cRyH4aYLv5lOeoUzY8Q+sqA2?=
 =?iso-8859-1?Q?2961/YsCK+L50FkzJEQ5J7fd6rVJwGMcWzmN1udegc3bp1A6Y8CQtdUqHc?=
 =?iso-8859-1?Q?6G7jgVsgBgZxZPBZwmctHgL4GvAu8DzMQwp3XGUYX2Jt4GimkAfi8/LLcJ?=
 =?iso-8859-1?Q?oLg35U+ZUhnEV2JY/9dSgbRkJiFB23d0NIoNGwa3tl3C2PvRZuG87Ly21P?=
 =?iso-8859-1?Q?MeFKGJwn0+VGKrVnrLsM0hok/ZvQ9caL5hwT64CadYxOznei1lvQ4juimW?=
 =?iso-8859-1?Q?LpPgDMchEjU+Hk3kYSJkB2VB4Mm/hQf8At8LNujCrRTfG8itw+ZpvZhFmR?=
 =?iso-8859-1?Q?AUVQxGcs01I8roF0NrYDcXLfhs+fe2eK+6Ycgw62CfDyiamBiuXkULSMcc?=
 =?iso-8859-1?Q?O/b6DzLcd9YcnCGyFFa+Ba1l53SUEjZMVVeI2hu69gq616Y2oigRfVT5Ua?=
 =?iso-8859-1?Q?6C/SUrI6COfqMSgWzFztC8mhjYhgdHz62qAkVRiqly3KkHpAbKhuI1LgeU?=
 =?iso-8859-1?Q?DNW6d413EZo6lAsdAaBVv52ZIFraAlB6c5pbNKF902Zx7vGjtdfYGIHk/P?=
 =?iso-8859-1?Q?0z5dbPPNjLPjF0S/LD4IfkfzaLBCOa3IN1QS3QDPYwoQ1VOKUpbFJ7J/nY?=
 =?iso-8859-1?Q?D1lIaApOoP2prBmuc7Hunhz7gJCeB8pqmyfqt1TjPvWuFzanec2zNOoqtF?=
 =?iso-8859-1?Q?s1pJ/qOSKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c069dbc-5f4e-45d9-891a-08de78efa092
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:31.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnNX5P2llIROaDDdJI8w6wIsSDzVd03BA7QhoZvJMwWVWDqxdtOciaGtfX9MeMOH+Urrh0ANSqXtbGRjaI4O80iHrDDeoSDQQWNaWUaMylM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

v1=0A=
 1. Update test ASPEED OpenBMC SDK v11.01 for AST2500, AST2600 and AST2700=
=0A=
 2. Update test ASPEED Zephyr SDK v03.06 for AST1030=0A=
 3. Update test aspeed-zephyr-project v03.05 for AST1060=0A=
 =0A=
v2=0A=
 1. Update sha256sum of ast2700-dcscm-image.tar.gz=0A=
 2. Update sha256sum of ast2700-a1-dcscm-image.tar.gz=0A=
=0A=
Jamin Lin (10):=0A=
  tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr=0A=
    SDK v03.06=0A=
  tests/functional/arm/test_aspeed_ast1060: Update test=0A=
    aspeed-zephyr-project v03.05=0A=
  tests/functional/arm/test_aspeed_ast2500_sdk: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700a1: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700a2: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED=0A=
    OpenBMC SDK v11.01=0A=
=0A=
 .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------=0A=
 .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 18 +++++------=0A=
 tests/functional/arm/test_aspeed_ast1030.py   | 12 ++++----=0A=
 tests/functional/arm/test_aspeed_ast1060.py   | 14 ++++-----=0A=
 .../functional/arm/test_aspeed_ast2500_sdk.py |  8 ++---=0A=
 .../arm/test_aspeed_ast2500_sdk_515.py        |  8 ++---=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py | 10 +++----=0A=
 .../arm/test_aspeed_ast2600_sdk_515.py        | 10 +++----=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 10 +++----=0A=
 10 files changed, 75 insertions(+), 75 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

