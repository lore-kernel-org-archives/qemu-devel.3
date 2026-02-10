Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FABAEA3F3F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplEa-0007V6-4P; Tue, 10 Feb 2026 05:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vplEX-0007UJ-V2; Tue, 10 Feb 2026 05:44:41 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vplEW-0007z6-HP; Tue, 10 Feb 2026 05:44:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H33/SM1hLHgui1mnQkUtoAAt7I11AyjLnvpH43xd/muyEXMAj7gz8A/eGutnm7LYuv6mIRltrZDQQjFsIxCqtUC51cEQ4g1waGHyKMvFFE6JYv2bGUaybm84GaglstPF3yLIS2rtqycvOrc9XlXiuJnJgWE/M14UHOF0C5rDw2ae5ds038IR6URHJ9lghvPy/Z3SjzLBC07v/5F/yxGMj8rIuIigVjMMR3w2ao2z/ebAULrmyOgNVamSL8UIYy6t36f+3e0YmsIJRFH32Mul1fp3D7y/G3eH0R1hZvRvsAEMYXKGwpJKtAJgavylwotxILS3LDAOjGZcmqksBERX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyacWF3sA0uP8RRbQC97ZMq3zWDlEs+ClBsGe2DnedA=;
 b=wy3zn7vtBRDJAKzCAjZ4xBqVL23sMWG7BZI32JzP82VAAmiMUHgjgbB4We/rC5mAz64qHpMERhH3nWq27y8GUbA7lgUl3lWwKiNmVz5eUtZ+0KQ9g/WkyAvYQBVA9Hxeo+GYD8uczyWVHPSd3jZWkQN5ZycBlZi24EhqBiVHMiElf28NdNaI6i3jgHW36hfxWyJ/0ZQendD99QdAzQxy4R8ojNOX6cKG/lfekEsPs037f9xzpzVVj6+2+EiqGE9voaKM/K0oazYy48aWQHawH6/qnXxOgHsyCsEPX5plxHmJdDhsD3MV54B8FvMF0R5w9zTtjjPkKsjJbH/S7drgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyacWF3sA0uP8RRbQC97ZMq3zWDlEs+ClBsGe2DnedA=;
 b=dovvqtzzIH6qx3n5S5JcjQ4buYnwKzq2EhoQPvB0rYJtlovVRndaepPgKj9C5yVlJrSIvFnJJQIVQbjB8vVXjD+V+14FxJNz8rYPSiwLPMS0aqtHUvmDUakDBWqXrra8mF0QSCOmeYKdsH/VqsGfZb2zCjj64RKlP/mQI6eYZC/779SwAmof2cQQbqx9ONZD+gxPFhATnhTYYQvXFfYfVBk50MjRx2r94VTxJBJgYTzHdreOMViRS/O4fQFno9ozgzLj/yysvRmBBL/zQRgQ8hh3FRswiyXFdxs5iC+fX6VjAY4m/AS6ZK4uopLhjSeBJzPS+GfzqN7/ePTK55y+ow==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by TYPPR06MB8077.apcprd06.prod.outlook.com (2603:1096:405:31b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:44:34 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:44:34 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Thread-Topic: [PATCH v2 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
Thread-Index: AQHcmno+PDcPaf0Z80SQUT2EpjOSXA==
Date: Tue, 10 Feb 2026 10:44:34 +0000
Message-ID: <20260210104428.424420-2-kane_chen@aspeedtech.com>
References: <20260210104428.424420-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260210104428.424420-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|TYPPR06MB8077:EE_
x-ms-office365-filtering-correlation-id: 09b505a0-3bbd-4134-ddb9-08de68916119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eC+s1acns8ikhPB4kOjs3kUN6EomxgkBjS3mjxW6Moqq2NfipgWTxRO/9K?=
 =?iso-8859-1?Q?IvqxwmwFKFqMQjJOsBvtLQvCoK/38nwcXsZdSrAOfG6LuLzIPr4KkwwbHz?=
 =?iso-8859-1?Q?vswjzexq5xjShYas2cTZlJnSo9mYSXdLXRmjHXcxCvBDbP6uJfBRpIpv5L?=
 =?iso-8859-1?Q?A2SQ8FaoQ1hCA7dBoU8nYbLp40GcUTd1R5Qt1g7vdkOBguD0ONx5YauIAb?=
 =?iso-8859-1?Q?OiK3/fjuHOS8SZagqVaKmgHb9BdRCksYTtoMsBMKWG8Gpq6mxURlriTWUX?=
 =?iso-8859-1?Q?TAg//HlCWt4c8RNLJegurd1Muj+vOJwKkfQBFeERSx1Mad/s/vXL6MBORs?=
 =?iso-8859-1?Q?We2teTH2NT7G79PtSz+ZWUUCoDr1k9F4zhxAUoNxI6DlYk87H2fUL0U4Nv?=
 =?iso-8859-1?Q?nKbAwYiljT6CgJvEkoPk+h2ApW+Z0CcJSVc4xAQjcLDKdcBewmQ199dgsG?=
 =?iso-8859-1?Q?RyROdxvWRe18e8a0SukFBLhWBwDHRrSs9xRA/GjGD30xWnkqm+LgCvkYqS?=
 =?iso-8859-1?Q?HndTLq/g40VWw6VZP4GbOd2Fu/1SN1xqVA5AbjbSqHRYHMQPvLvZ3f9RA5?=
 =?iso-8859-1?Q?qxUpZ0LuoZTMj9lc5Y/GjCpby3wjfsWAs1elHAdzVPRkx2HXeqtNB3TFUj?=
 =?iso-8859-1?Q?w9MUg693pCMpCrm5KRzAF5rtmgP8M1qZgAGtcM0trzQCPB0UC38+v37kch?=
 =?iso-8859-1?Q?XrBkVicqwKuafymsDOQ9dsLttjVYUfY8dnJAl3/hDRMTtoCvFek+zUy2vu?=
 =?iso-8859-1?Q?I9hZe0OUzyz7FKMiOKnUVi9JCcHE2QrfpkUhwol6cry5iAoqiptOqt8/lq?=
 =?iso-8859-1?Q?B8MiDePT/W1dj+F+/TpN/l6NHL6/zzHiuL8RP3FZHCqrVxRgvCuUmcSRDI?=
 =?iso-8859-1?Q?WuDET7lpd6xfV53Yl/BULWIFOGZceebcfVuBIg8GU8HdhScamhknwVeCjc?=
 =?iso-8859-1?Q?NPvCOR1Z1Dn5VlyHCaqRWS0qTjaZiujsdCWvdC121iBlvvg6ooMDMpLyRK?=
 =?iso-8859-1?Q?0Z9GQWBGlb8gz2Xk4pJ6VTXzJUHhBrzkA2Ag/9kjyfW1Yk7yqncVTDeELR?=
 =?iso-8859-1?Q?ASlyzs/C4rpeRjvpnrgSaswHYczUnz54o1YUZ9lmQ8V7mqoTTN8WSfimz2?=
 =?iso-8859-1?Q?+6fFy7/HYzGKjk8HT1t+FOd43CEFe3RsC/ALdBMrBBJOY7GtsNvRCxuttA?=
 =?iso-8859-1?Q?eQDixYQzCAtSQTaBNgm/uZHUYjsuYJesaptwrfiKAV2aRGf71CuCC8SvoN?=
 =?iso-8859-1?Q?osK0s11nfoYkt5piCHK/G7AHsPozVblR8poDe4s6eWW+SuxhNcfHMEf/J8?=
 =?iso-8859-1?Q?L0TqbITHAlqfJTwHb1VZjOu4mdB+X16kwmX7Gr7lwjN6JD8VB5s28Q8+RJ?=
 =?iso-8859-1?Q?1ZIg+IgUbbZo4spNq2dAipieiZO77J7eB3JyauK4zG7/SC/BtvPJ3DHO8h?=
 =?iso-8859-1?Q?cOiOIChQFjoWmkv/rVVw5hty8+3H0phqHAH/sqqbMA3DB86KJi2iW3w/kU?=
 =?iso-8859-1?Q?tuXEqs136P9tooWcB5+3BfFxPxyckonAMvxJV1NXJSeVrsOcF2yy+k/FEO?=
 =?iso-8859-1?Q?wY0/aqtgmpgbDwR31xrFpCElXjICtiHIZ6SREIjCg2fDXJ2vOW58KaZs7r?=
 =?iso-8859-1?Q?mE4QQPVEXNEjYjpj+hsaTYF4zIlNr7Ln33wONMQkr1KFXBYrzL8kDoh5n0?=
 =?iso-8859-1?Q?MXC4BMuE6PTqZNpde9M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uiH/uIUvpGBTU1MeSGX5qidLbToTxgcJ1Da13rHldACoEVknUWYRy8dyOH?=
 =?iso-8859-1?Q?SDPQPcxMGLa06S3EZhlIIP1WXaijA+y9gEXoXO0KjPQsdXn1yxD9K0UOWf?=
 =?iso-8859-1?Q?7lqv2HR1O1bCN8W3Op496qsVdMV3BRsimoDB8AHevDUi33vOvLKek3pL2N?=
 =?iso-8859-1?Q?gCY/kTjNAJBFJdGqLi0PGI+M0FLfDSNyQSdzsgwhc0+FpfYz0XDiU/w7tZ?=
 =?iso-8859-1?Q?NNyD9wv4xfIPH0IdkBxIAvh8DoM9FalxjHR5Cq2DuGplaCL05wrmgCfU6A?=
 =?iso-8859-1?Q?eBjEx2S7Yx7RfzT0wUTwTclHmWhBqqO5/RqhQGWRPcCceJoq767pQXtAes?=
 =?iso-8859-1?Q?JbI+tpeQUklPte4jp+x+l4cKZK71u7tM+ghUuo61XugWnK6ArIuaMkuspw?=
 =?iso-8859-1?Q?z/nA4AyQEv4o1cYha5TfoitMS0ru2ylkyQv4/vuIEM+qJvy6ddeGBX0cAb?=
 =?iso-8859-1?Q?C75gay/8plO1MFnA8RHqP9S3c/mnw5+fh85BWSgSTc0TGtM5eoLjc4oHlu?=
 =?iso-8859-1?Q?RAZiZIuxigoUnMjMCa9ti7I4YIwkUgcrTSZKfdaFZsKsIYSM3UBIKM385N?=
 =?iso-8859-1?Q?xVSRgEVrK7XuTIt7svF0ORykdfL4RaUFldPHhF80oOp5WeMLau2LeJ/45p?=
 =?iso-8859-1?Q?vMgvY+vE3sj5zxeLAl0sm8oeyv/nYe07to1prBc3pczt/sbhKczEI7VN2Z?=
 =?iso-8859-1?Q?99vD8j5VCGW692Fl+2OmqbIKRdZSDuRDzSnzUPyYZWk6xZDHH/zg3Yce0p?=
 =?iso-8859-1?Q?bot7OKwkFZkuJeC5Y0aywW91w/53OOWk7jbwfVE8ERDR7gy8N8bFx5uNOi?=
 =?iso-8859-1?Q?frWQX/ebMmhRc9CEs66Mc4dODkH40x4A7qz+RZlqUmArafeZcgBvTLQKrq?=
 =?iso-8859-1?Q?AlJr20Sb2u6GtousHxHD8r9tYRghtBmk+/C9C/mUI34r2hZQXtXGtITOOg?=
 =?iso-8859-1?Q?aIvqkvLUEXKp91Imv0oe74aFp0Eeh0m/xoASG+mBazxPxGs06gisyIWIrL?=
 =?iso-8859-1?Q?4kAK36/9m96ZJDi4BaNNC6tChqmTqPd2BlXwcGft9W4GKqR75OVs5MV1Xs?=
 =?iso-8859-1?Q?abUgSAgeknS6WCx11sF6lkefTS2xsPV4shxdrLyd04RD1Ai4bq4IedL72l?=
 =?iso-8859-1?Q?ndVi+og1CSmrQFWrRUvmNKw6lqi2deQvrqUXxeRaT1kbF0DuefNzSsUl0X?=
 =?iso-8859-1?Q?SAkMyhFNABp73T+0XEPB78PHn+erIazQCRotikGLeV/3SkWC26QPWBNK0o?=
 =?iso-8859-1?Q?5eCC3zgkH0Gvx/YkeyH14UEzurHxP18B7/jM1XTQP1CTG725HmLmHXSqyl?=
 =?iso-8859-1?Q?IWqsy1X6PAhzLbFDhsL2fvnmej3f1oLCRaywH81ZGHt7WetZR+2aOXUxhe?=
 =?iso-8859-1?Q?/sMBLjBF3D7Sfsec3MSa/Xn1gLV7+Nd4/Yw8tM8qLW2P2ayzyubkgJKibh?=
 =?iso-8859-1?Q?80G++KLGprOVJfgsZT0J9QkEP6cXNtz+7uhXNGtAwzbbfe7zdA6CEkKBZW?=
 =?iso-8859-1?Q?1r+0k3hYeM6DjlehLtDRsM4vPf8xGRTZ4j4WtYnlxewQNvB5FA/046Pxwc?=
 =?iso-8859-1?Q?vLH8zVxKrJ4XeQA8i9JbqXEIcMUSfkRNIbRmmJbfDSW8MEgI+ZYDiD3oF4?=
 =?iso-8859-1?Q?oU+QC1dEGGtve/JoqjnChPmTvoqPt1Bqw9YBUw33xQbEGQZi/iFaueNG3I?=
 =?iso-8859-1?Q?cX55P2GIx+VFMGKZeRY5OHV1QyAV6VfnZvl0DVN50GMKU/Kd6Elkra2pf0?=
 =?iso-8859-1?Q?hW/8VmoYkqR9f/nd/579rqa1TQ5FVWLE53PMQ90tzagYi8cvaqKdtYWVXc?=
 =?iso-8859-1?Q?EDHP/YbhAA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b505a0-3bbd-4134-ddb9-08de68916119
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 10:44:34.1451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTr/zwH1lvPpk81g9v+4I1jghghikDBTT6lOVxlel/p9tF2PLZZ8XwPctcjIbAbiGxzcq5zRXDrObxb/18EQbZe2fm6aSRudCyvTNeLlAfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8077
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Improve the OTP test script by adding functional verification of OTP=0A=
strap registers. The test now validates that OTP modifications made=0A=
in U-Boot persist through the Linux boot process and survive a=0A=
subsequent reboot.=0A=
=0A=
Key changes:=0A=
- Added interactive console commands for U-Boot and Linux.=0A=
- Implemented verification for OTP register 0x30 across reboots.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 35 ++++++++++++++++---=0A=
 1 file changed, 31 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index 4066532d5d..90f283ea09 100644=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -6,7 +6,8 @@=0A=
 =0A=
 from qemu_test import Asset=0A=
 from aspeed import AspeedTest=0A=
-=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
+from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
@@ -25,9 +26,35 @@ def test_arm_ast2600_otp_blockdev_device(self):=0A=
             "-blockdev", f"driver=3Dfile,filename=3D{otp_img},node-name=3D=
otp",=0A=
             "-global", "aspeed-otp.drive=3Dotp",=0A=
         )=0A=
-        self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default", "image-bmc"))=0A=
-        self.wait_for_console_pattern("ast2600-default login:")=0A=
+        self.require_netdev('user')=0A=
+        self.vm.add_args('-drive', 'file=3D' +=0A=
+                self.scratch_file("ast2600-default", "image-bmc") +=0A=
+                ',if=3Dmtd,format=3Draw',=0A=
+                '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+        self.vm.launch()=0A=
+=0A=
+        # Set OTP value via uboot command=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot:')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp pb strap  o 0x30 1', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self, 'boot',=0A=
+            "ast2600-default login:")=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc',=0A=
+            'root@ast2600-default:~#')=0A=
+        # Validate OTP value in BMC stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'reboot', 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.51.0=0A=

