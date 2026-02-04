Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD405E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8e-0002L5-NP; Wed, 04 Feb 2026 03:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8d-0002JF-MQ; Wed, 04 Feb 2026 03:21:27 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8c-0003UH-12; Wed, 04 Feb 2026 03:21:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMWVBbzjLED57Mv0gV81AHBjqXVEab2JxSs292oJmUZbeyWWnohGW9f68GDfCWeF1j5zmEMk7PnPJDuv/cc7fUsag7hJb/kcAbOtLq1VKmzUmylhzjxlLPoFhyWcWuwaV8CfAJDwiIAvvjkROKjHiMhrBZM9CuGnYqhF1x1TloXjpsgcyN2GX9mEwngIdzNmawq1kdGelTGJSb3WDV9oJRT2skPVP1BHq9OXJCoELzbvfJ/zHA9SPp8X8x2aSbn/FSzpzBq5V95IQg8BErHvNv1t55ZJYtvWbTFGtcFcKQHLWFpxww6JQBvvXHCb4yDHnyQGZNsuNdDk/ZeLEwNt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBe2+NdL23PxdV3dFB1aDbRXJg0ojr1Xs9XMbJB6agM=;
 b=KF9ryrBrvvsHVtsvSNrtmrstx2teb2BoUVurjBM5ahnxIbYVOAbI658kZl72ShI0fsmi09L/95IDlpdqiGF5dvrqJ9zwJ0JJiEwCekFYz36/EBIBXirj0eSOsynUmfINIG7zyePsQ49UkFIW9xgFdn0/TvaPhhENLZU3B6+MRoAmwVvGPnHxHLorSnpBL8O47YzU+UoSxdJ9tblSGvqxb+5cHs0fotqZ1qvy7DHb0o2B4BifwyVx20m2qI52VWFQR+l3wNnDThNnqsytMA55bx2KgxsBc/l4KoT6hwh46+cD7wLn6grusiF7GCK0qCyYZ0qEiqHX3uHKtEja1PuLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBe2+NdL23PxdV3dFB1aDbRXJg0ojr1Xs9XMbJB6agM=;
 b=EFz0hEfHSxJTRsO+LKiTG7Q1gLujwEf438wJ/+MHnHZ/PZTYYzmSFmez+3YEdaoRIPducq7VBEqF7RDOYiWJonImzubi/6o9eIzFuhi/Zxf0ICB3mlan5Hv1JiceR8vutNFxDkVE0aAoZUN7xX2tJxyuIOySM/9t74dFACUUBOC3yOLGYLcLYlMY2QxgB8R43tGrGWq3m66w0aEWmSh07Kncdrq9vkyYLzhLcLfh2udy9aPXCPB56PNFRn6/uH+h4pa3CxEsBXPd4EziFmHLuPfVuPOnB5VMq2bvO1Xh98QcthHUTPNk5EL2yVGNHnigaJ0JJYutoK80dWe2q8kC+Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:17 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:17 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 02/22] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
Thread-Topic: [PATCH v7 02/22] hw/arm/aspeed: Attach LTPI controller to
 AST27X0 platform
Thread-Index: AQHcla87rnBxrCRn10Wf9zJBCFNOAQ==
Date: Wed, 4 Feb 2026 08:21:17 +0000
Message-ID: <20260204082113.3955407-3-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 7c3cb3d5-5dc6-4b3c-af43-08de63c65e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ouVtC/VCpnp+eciYadFyLB7H6LCj60TXBPCSr348AW+iN02OAcUdaNsa+M?=
 =?iso-8859-1?Q?aozuJFJ9xQH8QT98+rBvickvJLERIxTe6eFLnrscFJXw89U6/EMYPRpzFZ?=
 =?iso-8859-1?Q?vY/G5wNSLPnxPN719x005+3+W/fram5BL7sJyT2of3j3N0bm210CKbcvzI?=
 =?iso-8859-1?Q?zM1TMQXdKrSh/Owc6T8AZmLXro4Yn4jyxZeznPKnhbZk9nnqPOsE4Ghh7s?=
 =?iso-8859-1?Q?CPUWduGDrk7nGlRaAMfVdntgdDQqec+RtDBkXlIWXlC5CS7BflrxJEiPmH?=
 =?iso-8859-1?Q?C8ylLOgLhPlnWBQJBVssOnAevaSi8gJOAXoClwPOuAhN9CfBq/aJiYe7AO?=
 =?iso-8859-1?Q?E31EsuBjkBQ5IBzWTKCwioqeX0Sa0Uf52UUUOl4Ix5FO/L24VTHO/mtHQj?=
 =?iso-8859-1?Q?JE2OHc79VzM+ZqxVVQbIt2I9aNzAuQmVhGob+YqMwo1dIarJzhohkMz3oi?=
 =?iso-8859-1?Q?0TInKU0gMc0Ytgl5o0zR2VsW8cDA/ue4qb6arVhHKIiMRPEqCwwGd0k9pD?=
 =?iso-8859-1?Q?NguMUGpA8aeaHeOgepCLHyxfNdSiciikzHHh3tmgaX6otLafWSHpLyCP88?=
 =?iso-8859-1?Q?fcO1TKLqvO0YVTx+QJkAOdql3RwfNDSJv6iI43eQEtq35JGNn/PPGHsFNI?=
 =?iso-8859-1?Q?CV62XZ93GjvXRo9w67fSVZmDqsRwSny6woiuaIGja/rG9v9lZVZvWFPh1H?=
 =?iso-8859-1?Q?d8LoprQ4Y4t8YPVDuB+X8sxfYPz7rrbRtwtrNnJuI12uvT3BNCRGiTIZOw?=
 =?iso-8859-1?Q?9auCceX9u9UVGu7T6cG8wUZrM8ZcmApGmHh+NCRs+qYYejnSJ/yvTxvjBt?=
 =?iso-8859-1?Q?l50jlu8B8qnw3jaAnr6/DUJBX8J4lEyuWb99I2zRrwanSS1oTQ8Fp2Ic+z?=
 =?iso-8859-1?Q?vwKpcurF6ger1oGk3AHA8V2frs+7ZXZYSI5E6GmLavRobsShlOYyTyPeRx?=
 =?iso-8859-1?Q?cBmBw2TizrgpZ6yTBEcKeIuJhlZP5Hxw02tBlUFDOHwOX72Rs1YrCtojjk?=
 =?iso-8859-1?Q?CeoMNzihfwzj41D74U7HYAvoI155ja29aultibmfioO0EwBTAVZLlTw6mA?=
 =?iso-8859-1?Q?6XXyUTMtJ/UgcAyVp4ui6ZA+8EfzneCCv1anQ8po3rrBL2Yu604EeBLtKb?=
 =?iso-8859-1?Q?4OQNeQJRtikyB3XLJFinekgp/wahTC9kFFtPXHBLOv3bpZNDiRI76agLko?=
 =?iso-8859-1?Q?m2pNLEhi2ilLquLDZJcIKJ8gGHrJEcsga3rk7tVb6QbXEU3C51kinr2nRD?=
 =?iso-8859-1?Q?/+KNzoWOd4iGVDd363v6XRkOm4Rf9o8r2e24FTdzYBP1TLuL7vsWsFSy7L?=
 =?iso-8859-1?Q?r+iVBY1m9ynlRVx/JiIjfgOHZgnCwc3SyyzASdbFG5Izt4ICft3kC2EOnb?=
 =?iso-8859-1?Q?0dq8cXzZZruPQZefNu2pxq5/GtwIm3lvWcAcyEtt8K6Ig2aa6FdmhVxzML?=
 =?iso-8859-1?Q?ZT/TsgYPxB9fiR4lVk6CtO0X9BGp4FyrD9QuwZfSHLeKng6O7jaOrJhY61?=
 =?iso-8859-1?Q?igfF3R1BYh3brZA9gzQP95y97JviwRLk0PpsczWZZQKiAM9cZyYWxMg3pf?=
 =?iso-8859-1?Q?5qofptggdVSnYaTFsjFrF6XoS/ngxjgGKPK/7L6NxlcfJWDv8ySRcGLyXt?=
 =?iso-8859-1?Q?h/6RWp7DmooNCNGMNMT32BnpDqFlYgdEysBkSJs7s5pewISrBnnnyGsdkX?=
 =?iso-8859-1?Q?OBaCIVQCo7zDpNSLPsI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IFqIZzLAFxO4W4Ok5/qaAbvyfXXMrbVp/vLOmzuoq/U9Q2c/ywQiEbSh2b?=
 =?iso-8859-1?Q?Knt5k/zwjKE9ew6WfFvbLdKL9RK3wc4n/7VxJBh8EtQBks2cLdL96kENXI?=
 =?iso-8859-1?Q?kUZDGLFmCemJ2lGJ5yVc05jrb7eQv+y9EyJJyyDqAmlX8J9C97l3kYkvOn?=
 =?iso-8859-1?Q?OBVbi1A0E72q95xiRK6dES4P+Cepacs6AXEa6ScUxAfMeOIGZwVjQs8bP6?=
 =?iso-8859-1?Q?k6gEtZ7KiakjU4nLgPvWxqWPfFt+D6MC7vkz/ZEgndqCHUGzsBu1+19u+f?=
 =?iso-8859-1?Q?c5zD2o6PspCfyNt5pmSfwOD5RXpymew34ZldmWrGXfGjFX9xpx9Hry3JbV?=
 =?iso-8859-1?Q?hToX0R9sB2vZWLy88bEg1TvQJE7VCFOzOxhqUmOCy3a8zg0gSDkXtgALkP?=
 =?iso-8859-1?Q?1VHuOrsK6OBwTlAhoYpYGnpizlIzcPGgBtEuwfVZAHHXUwcN3eO+gfx7rw?=
 =?iso-8859-1?Q?ZewUrAApY/amQa9vhOHXPe7m+lQsJjLyLkCc1Je8gZ68d9EUf10jNyikPq?=
 =?iso-8859-1?Q?21YRfB2S4FPAav0V2OyAg/M5dT8vJWYRZEgvKB3ibnjlhgib7TcBDuLfiT?=
 =?iso-8859-1?Q?u2DiB0gmew4X4dmHBbl2Zm/TdR005L1SMdyH8IcmeWrDn91xuyHNBAXLqd?=
 =?iso-8859-1?Q?W06NPk0299Fitl3nMx9YB1x/cbHQi5ZVConl9D/Kzc79q2Lio/2VtakZBp?=
 =?iso-8859-1?Q?iUaKrb9vpXSv9d6piVzyMnLGKZnbPndp/uQJ5aSDZCoPDb4DLV09JglDo1?=
 =?iso-8859-1?Q?5zMartu76r+AvHqLsTbhsRqcOnKZ6jNWetoLn3FdQLFCxNza1GlUiW5ywr?=
 =?iso-8859-1?Q?hDNsPXOOm4pBy5yE1W6OlfBXUhs+Imat1JtZWFTMf0/hK2DMPd8/BOg5vc?=
 =?iso-8859-1?Q?wBy1YXUNYsahjO1g36u0a7YUIORAlD1UEU5mwU6m0PzIPJOboD1VTZDd+H?=
 =?iso-8859-1?Q?KzZWDrSP30yVpZC4jyYRC5ejloz/28/ciilFdT9Lm+upz/NDrKsSk6ZA0Z?=
 =?iso-8859-1?Q?KK9PSCplLWXfboTbNUiOWroK4fw6UwSUlhCA24O1mfqfLEK/YqQpXKGG1a?=
 =?iso-8859-1?Q?VlAJ8PGnXOo978zhuBHmPPBt06QozKRsVR1ypKDn2GqOK1PtHl0+oQcql8?=
 =?iso-8859-1?Q?PapNzS7bpRXou/rPwm41xMHLgDuq7bUY9D/hb0TRNhjVkjGDtJiHYUPQ5U?=
 =?iso-8859-1?Q?B73fD5Wp30gN1lXp3eivoA3/xfNNQsGSB4HoUAgnBejaGXdZ2e4BaJmG01?=
 =?iso-8859-1?Q?HklbxoftXdPHd+kZAQmZ+Ktkmf8frfCaa/S6Wi2iol9HBTv01j0AYWQdAy?=
 =?iso-8859-1?Q?ybuUptooMLHA+Rn71GO6h73lqVDE6b0cdo4tcLE76Qb68gBTKa6F+7Dv2d?=
 =?iso-8859-1?Q?tIXujV7Nre7L+ch55iWefQRC4dGGlcEHSQOzUzs8yCfverGVJWeZffVgZS?=
 =?iso-8859-1?Q?JaQD0A6tnHsZDt6cdA9vSEUvvM39FtnKXQNGc0IVDyhGlLpZZgCHX+UjMD?=
 =?iso-8859-1?Q?rpBOmA0MeNdRIymEA1Li76fJUZpwyqtar9itMFjZDTLI/a1mHu783PLWLU?=
 =?iso-8859-1?Q?GagJZW+HkVHN0KGptET/50Hs+cDVGQlX+8YEFnoxYhPop8r+R8FSbyG2vQ?=
 =?iso-8859-1?Q?afA8YNbpT2fSvWXHawgPDifqsCqEW3erBWuGQTjMijYB2ts25VqrTWjmkw?=
 =?iso-8859-1?Q?QoixiYsJ56phMTMOMeaHw7dJFOCwHmOFMvojcbMofJZUh5GAHy6jB7RdXt?=
 =?iso-8859-1?Q?aSj2IhSN3CNE72vsW0Z7UqUdUpRKiJ3NFBmeHHV6pRpU493wEZq5lImir/?=
 =?iso-8859-1?Q?Df6G/bhdNw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3cb3d5-5dc6-4b3c-af43-08de63c65e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:17.2636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UP1J11D5xCEvXoMBFtzTNw9Ps/6LevkcX9GHGI8DYtTStMJmVFzHSAZFQz+pWiRERpFbpQqd08Btm8Nm3AQp/azkoEZb8XgRFu2eZwiZ5R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Connect the LTPI controller device (representing the AST1700 I/O=0A=
expander) to the AST27X0 SoC model. This patch sets up the memory=0A=
mapping and device registration according to the AST2700 SoC design,=0A=
where the LTPI controller is exposed at fixed MMIO regions.=0A=
=0A=
This change only handles device instantiation and integration,=0A=
without implementing the controller's internal logic.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  5 +++++=0A=
 hw/arm/aspeed_ast27x0.c     | 21 +++++++++++++++++++++=0A=
 2 files changed, 26 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 18ff961a38..bca10c387b 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -43,6 +43,7 @@=0A=
 #include "hw/fsi/aspeed_apb2opb.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
 #include "hw/intc/arm_gicv3.h"=0A=
+#include "hw/misc/aspeed_ltpi.h"=0A=
 =0A=
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"=0A=
 =0A=
@@ -55,6 +56,7 @@=0A=
 #define ASPEED_UARTS_NUM 13=0A=
 #define ASPEED_JTAG_NUM  2=0A=
 #define ASPEED_PCIE_NUM  3=0A=
+#define ASPEED_IOEXP_NUM 2=0A=
 =0A=
 struct AspeedSoCState {=0A=
     DeviceState parent;=0A=
@@ -112,6 +114,7 @@ struct AspeedSoCState {=0A=
     UnimplementedDeviceState ltpi;=0A=
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];=0A=
     AspeedAPB2OPBState fsi[2];=0A=
+    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED_SOC "aspeed-soc"=0A=
@@ -279,6 +282,8 @@ enum {=0A=
     ASPEED_GIC_REDIST,=0A=
     ASPEED_DEV_IPC0,=0A=
     ASPEED_DEV_IPC1,=0A=
+    ASPEED_DEV_LTPI_CTRL1,=0A=
+    ASPEED_DEV_LTPI_CTRL2,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index e16183c3b3..bbcb6e0127 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -88,6 +88,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_UART10]    =3D  0x14C33900,=0A=
     [ASPEED_DEV_UART11]    =3D  0x14C33A00,=0A=
     [ASPEED_DEV_UART12]    =3D  0x14C33B00,=0A=
+    [ASPEED_DEV_LTPI_CTRL1] =3D  0x14C34000,=0A=
+    [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,=0A=
     [ASPEED_DEV_WDT]       =3D  0x14C37000,=0A=
     [ASPEED_DEV_LTPI]      =3D  0x30000000,=0A=
     [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,=0A=
@@ -491,6 +493,11 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
         object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abort=
);=0A=
     }=0A=
 =0A=
+    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {=0A=
+        object_initialize_child(obj, "ltpi-ctrl[*]",=0A=
+                                &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "dpmcu", &s->dpmcu,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ltpi", &s->ltpi,=0A=
@@ -974,6 +981,20 @@ static void aspeed_soc_ast2700_realize(DeviceState *de=
v, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    /* LTPI controller */=0A=
+    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {=0A=
+        AspeedLTPIState *ltpi_ctrl;=0A=
+        hwaddr ltpi_base;=0A=
+=0A=
+        ltpi_ctrl =3D ASPEED_LTPI(&s->ltpi_ctrl[i]);=0A=
+        ltpi_base =3D sc->memmap[ASPEED_DEV_LTPI_CTRL1 + i];=0A=
+=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base=
);=0A=
+    }=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
                                   "aspeed.dpmcu",=0A=
                                   sc->memmap[ASPEED_DEV_DPMCU],=0A=
-- =0A=
2.43.0=0A=

