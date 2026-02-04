Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F5E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8k-0002NI-HG; Wed, 04 Feb 2026 03:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8i-0002MX-MQ; Wed, 04 Feb 2026 03:21:32 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8g-0003VZ-HM; Wed, 04 Feb 2026 03:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0PbSAAXXZ0A5hEXDtVA6EwEHNU5jOsUy+A0BqNp9VNgOHZSid9aEVt9gFbTLsb6XnlDwJVFEKAhycu7D/TDN34sKgY6EV5e0Xa3riCGWqcdUq5Fk/FJ33hmT61LdFNtwP1YZ9K6qlnGm0BIKgUuAGehrFw9bouI81HhMFHBIUha+34MK8leZ88kXx6B2IgZs0jFRSYYKCRYd176KDWpaRpa/y+8cQWooHO1hnKlbUB1BHN8yDasodsZvBTOtgbfoo8UhXLdjZg2YZdn70zWu7b8bckQOOVtw6u1Oim9FmuPYpf07SBr+xw09tskpjzP5bunyuyG4CD/i8s5QwDuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WZwN4e0t7fSSCyysokDhRbRVNSK4DOYfXttx+CbIzk=;
 b=E8UW99Pf0s7jdr5aYri6Evps7cRkiIoSZO3uTLoevQWnu3mB2y193LMkLxjC76dTg5q1RGGiyDrMN4GkM7jlCIBKugCvc/MV5bVrpZk3hhKi6FBAmgviDys06jSSVzQ3F5kmsDCYiMBaPwcxCwlj3i5Eg0r3qUhpKc8XP09Wk8vq6v/9WKYBXowHjSyWD7J2B2Lm4vBSkjeI7yo0lbjVymGkZqgFc89zfqI/lfXApegvKBNAFPcRE+q9HlbtBcXASdhKuJnzOOSkQvXuPZOvcQoKQVs5ndWNWhWvH83+NvxHnZvEuxt7iwc+3L5xi/Ls0ETuN21bwF7d3gs+Lp11Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WZwN4e0t7fSSCyysokDhRbRVNSK4DOYfXttx+CbIzk=;
 b=r0w9jeWr2s/X7rY1JrnpqFBwkjXM3pNwoQJH5RoVD/HneTpY6wY+OMqB5qaFc8wqeysKUp9wsaI64AVFb/BMp+7UZ2FtkKx+q/a54YAJqvH/t1UFy/VNtK0PNS59m00FQHY/Cw8jrhXJeZiE/4XfwN9qFC6U9Imeq6SnIQX3fKBPiZABj3/vEwTP+P/0ymFkBA3nacIwNC9r6vQNQmVKNU4uFAgg3rhmOyPIVRyRztDSvzSKESfzOfv7tOCo2WCwySS8LBIgBDTLQdCgwvNWPfOhwuZQ2jjdtsKmP2Dpv62pNcL78v5Y6MiQsRV36B5uUrd/E8pFUr23oYHVgTa5cg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:18 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:18 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 03/22] hw/misc: Add basic Aspeed PWM model
Thread-Topic: [PATCH v7 03/22] hw/misc: Add basic Aspeed PWM model
Thread-Index: AQHcla886NoXzRJzb0OAWGU/laoKTg==
Date: Wed, 4 Feb 2026 08:21:18 +0000
Message-ID: <20260204082113.3955407-4-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5bdca3d6-3e36-496e-daf3-08de63c65f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5Y+Qqz0hqnDCzu6rVX2X6M4nl4jk56Lmue0aev77joxRvJvaMCCpLtIaOz?=
 =?iso-8859-1?Q?wo1MOGQxgvj/kDXANP8vVV6XOAvEayuZXy60xcStoq41BZnd7Hmuhnkbwb?=
 =?iso-8859-1?Q?rQPdV8dPRng0Ey/bK0dwTRE+UEDkFWa7JURMnR5Jvj6xtcaCimeOxf0mRD?=
 =?iso-8859-1?Q?rK0bD1EsKF0uBrA7XX63NpyUdkjVNWbPap0AQ9X2sRY3qaJQvMMGbgDHBh?=
 =?iso-8859-1?Q?FXEsmcNElbH1Kdl5wYSapZwi3/OOjnpiAtBWTyqr7OC7pWSv2Vzu81yg2q?=
 =?iso-8859-1?Q?mmLBnjUXdVLziT2w+WhZ4sJNjHJGJMvxgBjIak0KY5jATKYxOKt1Yu18W/?=
 =?iso-8859-1?Q?EOEgrIsbohIaTaYdCBohDzxGpXr8Ls9g+lLsfIXRzxB4Jbb/yVxmDuTLjV?=
 =?iso-8859-1?Q?MXuobzugJRq3InX4bwc2WfNKvJ2heovKHod7zDVlGcpg9/I5cwSM9ONMVK?=
 =?iso-8859-1?Q?iE9xHe4bx2UqpHX7q4GKme9Y42/LsAqAnSjXbqKDM4tcoEbt/pRklQGGu4?=
 =?iso-8859-1?Q?P+F4hS30KKEk3QCjuW2DEKoPRvBj3wXz95pghZZp3Yy9KcdjoVTYh3r+1X?=
 =?iso-8859-1?Q?Fh4z3kK1pW4Riy1LSVsgdJlBiGevQ1/oC7J52DsMWcSJStjzqTF4nczftG?=
 =?iso-8859-1?Q?/0GbtDzZ8Aj5CuxbTtiQS1RsdCr4uz1P6bGJJJbwUWqNOUGA9G+vVDe/00?=
 =?iso-8859-1?Q?EKY5Hicqo27pfgEFcqNO/xFfHKP1qSO0nzEGsh0bLwq4RNRCe8cGjsyqyb?=
 =?iso-8859-1?Q?uDjmrCRCoYA6EaUuWp7EUNkr6k9OdApA1U9v0k3fQrQKg6FB84U4KSsQZW?=
 =?iso-8859-1?Q?rN9BAMXi4tdKQzj6UGblKjPzGufUo3cd3Izec9fA3UViI/cFT68IU7E27Z?=
 =?iso-8859-1?Q?baOu47Ra7cpX+W6vyOJJQ/gaHKMOFj41uA1deVjfnHG3K6U9s4dxoFuYWZ?=
 =?iso-8859-1?Q?hJAAshVZMoPBP22g6ZtaZPxI0WeZEZ1nE05LMIiXhpGUx6DyGME8aCSdZC?=
 =?iso-8859-1?Q?ZjZP8ztuohPhWVkyXOzQYyPRlCo17i97ZzEvMHQ4GPm9Zj9SY0P5ZmWzdG?=
 =?iso-8859-1?Q?kgPf1U2nK8X6NMu3z+TfiCZhHqwZQE7KFAatwqkhlBiZd8ctjuddsJdRAl?=
 =?iso-8859-1?Q?xCNpOWf2ieeBMzrqedhcHRSYXY1kC0Skwo4hZoritex47T0Ki5ZVFiGCJ2?=
 =?iso-8859-1?Q?aZFg93yK5M+nPvN48qYOXOivQ9rxFdYl99aWLjHunuqr6LwWOzKQMDkQrt?=
 =?iso-8859-1?Q?XkYuciUwbV5Xj/lIONnOh8HWuO3glhtvjmVY0/82OvqNWVDZMq3SkUEKHP?=
 =?iso-8859-1?Q?78DYWQXOG4cJn+XMuDE/9Ekaz0u1L68MR+fOcbp0xfOjE984TBq3grqGhp?=
 =?iso-8859-1?Q?JRAeLGfuBZRGQ1pyHY5DeQLgkHn53GXPhaICC0BDlUeqtmUvye0eCjaAis?=
 =?iso-8859-1?Q?ZmlLAgnZCpzGdo4KQD4vIm1j5MBAdP0uOJZsgmDK/Gt0Z1HAf94kNfTXvT?=
 =?iso-8859-1?Q?FHNtRG6aS2Utx5UY11fWnexPgAFCNir4fb20ggoLRergWjvYyhIHpq8GMT?=
 =?iso-8859-1?Q?ZJ34PJh/Pazl54TicKSZWtq4FFrKNXKX9KO2KVhHaAY42/OcvlXIF5049N?=
 =?iso-8859-1?Q?DHcFXdlVdjeOgkkg0fsJ47o4YQz8r1YAQnAf2G9I3yZBkK/asbQ+LlzqWa?=
 =?iso-8859-1?Q?E9xEyNC8hjKQZaUW02s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sGrh7myWkir718kXVGWUmlMenCS4TYC4VpPAczk10KzY20xiOpggDyA+2T?=
 =?iso-8859-1?Q?q0tSZjGt68HBCeERQtxjExRAP+udDTwYnbqAzKaI88x61dFSYto8lS9Uss?=
 =?iso-8859-1?Q?6l5XOIDlJIQ83t1DuMutPpe/463CCwFKmuuXDBQeT3tOoevgxZFm1sQloz?=
 =?iso-8859-1?Q?R+hFQOxzssRBJPwrqA3Htvv19M3SpOqC2w7pZ7XtxToIyNxA2QG6MDydIB?=
 =?iso-8859-1?Q?iGcfZoiLdMGOzfSwoOu9b+hpgwz0b3WygdYQVrb7iQV2GnIcm1U13E3EzJ?=
 =?iso-8859-1?Q?z5wIPrruv3R3CfDVgLUQi6K/d91NNKhdzem9F6MJmt+28+s+07/jqnFHZ2?=
 =?iso-8859-1?Q?xW9+ZrLyKCx7XXq5N4u7XVJzYUvsLNFyQtNio2OxWs7arIOUalxilYyU+t?=
 =?iso-8859-1?Q?xMS4k4+0Bs8bN+Al3nXSIziHVXETJQUnKLFNevP5bN5oEqiqxnb6dv5HWF?=
 =?iso-8859-1?Q?2MrzJX6Xi+cXSBX6W31peXoJmL+xLW9MrdsL/QGpfKi4j+5Td2uiUhg9dl?=
 =?iso-8859-1?Q?hjVBtH6ygb3LNzr/tTobRSyFw3x45Tw/kWPdW2pKgVZd431VsUtVjeNzcX?=
 =?iso-8859-1?Q?kb94RiviwM7PxCgRSfLYkscOrIbbFFT4liOjW6n0Ht5kmI1MpBsPOsjo5B?=
 =?iso-8859-1?Q?q7/Hm1s/Lttuq59HTqOvKpo7WxvxF+u+JZH1T8NjayG+5D7LKCWjH1gaHA?=
 =?iso-8859-1?Q?x/2ybdRv++2cfgt8N6sAHLIOnpy99vIDlMgmG235hOtn8yN5rViDcjYeL1?=
 =?iso-8859-1?Q?Qkx3KxjuQe39NMNf2ilDg1iYWu0Qkrsm8RhraA+/oEGL+eXpPHZslkNqFR?=
 =?iso-8859-1?Q?vYEXVPxJjFqljQf+ThBSbe7mblL75oOhebChli9SgDtHtv7+e2MXualPN1?=
 =?iso-8859-1?Q?y5WLKC6wyaxnka50naAlswhPbfEHPi2zYa7yiJj+3ajtVBSY6mTKJXOx+1?=
 =?iso-8859-1?Q?E6pSSAhJZ7JAgIe/vWYtSDL921lHT3tgQWkwl5AbLqdZEqa7yheDG+XePH?=
 =?iso-8859-1?Q?XnC0Fz4bSgmWgsLuaqHxcQQJjoYn5McUXQF9Ag9cqmgVMa6OO7gOqd/JCi?=
 =?iso-8859-1?Q?uqJ3Ww9rMkZVRKPh+y0ohhrLoZK/xWNMk1fuoY9x06Kn4Kt4homAFpjSUQ?=
 =?iso-8859-1?Q?aaF+4yR2Mf4HLWOdnNdi4oZE0JVOMWONRsdo1iYG8nKzE/M2moyja8HN+a?=
 =?iso-8859-1?Q?vIM2NldCuXe8Wmkf8CRFnh9kmx2fpcJqA9616XaEm9j9rVqXXgf5CLKtQi?=
 =?iso-8859-1?Q?lrGrrNvLluLlzFPsyx3KWMn1kZ7B5XbUE9VD/YbCw6CxXgRiltRH3r3URy?=
 =?iso-8859-1?Q?WYdftPRDnhg1REBkyWMOkRp0yyeE8GCcmtqfEcIdS0obb04oLgn7IO2Uvz?=
 =?iso-8859-1?Q?jxLqG/hMqjDM2wPwVWQhvDRitvdXAR5yptJVxNzZ7RUdD+yP8onTs88UEa?=
 =?iso-8859-1?Q?e2I9lkT0f0+TRZBBicFxsF08ZPGAq3YPqtLtTcUziV7Sg65idHcRRLbqcZ?=
 =?iso-8859-1?Q?aBeh5wmZP6b7EhWWErO411IKZil36UFr7festafbevl33AHEJY9wFmCB0Y?=
 =?iso-8859-1?Q?TBUf+ketKnauNn5n0q/mAp+Nr0pws5wHUoDXjfxBqikxsjNT/YvQ4c+yor?=
 =?iso-8859-1?Q?QJZKzhyGqfcb2Kbi94kQrVV3KUHmMyPUqXMDLLivg5V24gQNwqCb4PLRD+?=
 =?iso-8859-1?Q?NaW4Hm/geFUCvg0JJ88iCwXSGGZ0Dq8SIxzj1U79uMJ+ho3dGJslepRM05?=
 =?iso-8859-1?Q?eRVY+T+l0x8sRw1luN2Duba0POU/weqyhXIfpsIFaFXJK7HsmXW2xvmWZG?=
 =?iso-8859-1?Q?JMa48heIkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdca3d6-3e36-496e-daf3-08de63c65f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:18.7881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CY+EbRVIxUqfZo3ZlbU++QvkHUkFSUH3yHI7SmSX4OtovAc18jOQ8KFO6ePclvS7z6ehiNL/ii14KDIkjAbSu+4xazjsfI4P2KRjpAdu4qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
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

Add an initial PWM model for Aspeed SoCs, including device state,=0A=
register definitions, and basic initialization as a sysbus device.=0A=
=0A=
Signed-off-by: C=E9dric Le Goater <clg@kaod.org>=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h  |   3 +-=0A=
 include/hw/misc/aspeed_pwm.h |  30 +++++++++=0A=
 hw/misc/aspeed_pwm.c         | 120 +++++++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build          |   1 +=0A=
 hw/misc/trace-events         |   4 ++=0A=
 5 files changed, 157 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/misc/aspeed_pwm.h=0A=
 create mode 100644 hw/misc/aspeed_pwm.c=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index bca10c387b..7b08cca908 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -28,6 +28,7 @@=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "hw/misc/aspeed_sli.h"=0A=
+#include "hw/misc/aspeed_pwm.h"=0A=
 #include "hw/watchdog/wdt_aspeed.h"=0A=
 #include "hw/net/ftgmac100.h"=0A=
 #include "target/arm/cpu.h"=0A=
@@ -88,6 +89,7 @@ struct AspeedSoCState {=0A=
     MemoryRegion secsram;=0A=
     UnimplementedDeviceState sbc_unimplemented;=0A=
     AspeedSDMCState sdmc;=0A=
+    AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[ASPEED_WDTS_NUM];=0A=
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];=0A=
     AspeedMiiState mii[ASPEED_MACS_NUM];=0A=
@@ -108,7 +110,6 @@ struct AspeedSoCState {=0A=
     UnimplementedDeviceState video;=0A=
     UnimplementedDeviceState emmc_boot_controller;=0A=
     UnimplementedDeviceState dpmcu;=0A=
-    UnimplementedDeviceState pwm;=0A=
     UnimplementedDeviceState espi;=0A=
     UnimplementedDeviceState udc;=0A=
     UnimplementedDeviceState ltpi;=0A=
diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.h=0A=
new file mode 100644=0A=
index 0000000000..f4104ada22=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_pwm.h=0A=
@@ -0,0 +1,30 @@=0A=
+/*=0A=
+ * ASPEED PWM Controller=0A=
+ *=0A=
+ * Copyright (C) 2017-2021 IBM Corp.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef ASPEED_PWM_H=0A=
+#define ASPEED_PWM_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_ASPEED_PWM "aspeed.pwm"=0A=
+#define ASPEED_PWM(obj) OBJECT_CHECK(AspeedPWMState, (obj), TYPE_ASPEED_PW=
M)=0A=
+=0A=
+#define ASPEED_PWM_NR_REGS (0x10C >> 2)=0A=
+=0A=
+typedef struct AspeedPWMState {=0A=
+    /* <private> */=0A=
+    SysBusDevice parent;=0A=
+=0A=
+    /*< public >*/=0A=
+    MemoryRegion iomem;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint32_t regs[ASPEED_PWM_NR_REGS];=0A=
+} AspeedPWMState;=0A=
+=0A=
+#endif /* _ASPEED_PWM_H_ */=0A=
diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c=0A=
new file mode 100644=0A=
index 0000000000..ee3d5884be=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_pwm.c=0A=
@@ -0,0 +1,120 @@=0A=
+/*=0A=
+ * ASPEED PWM Controller=0A=
+ *=0A=
+ * Copyright (C) 2017-2021 IBM Corp.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "hw/misc/aspeed_pwm.h"=0A=
+#include "qapi/error.h"=0A=
+#include "migration/vmstate.h"=0A=
+=0A=
+#include "trace.h"=0A=
+=0A=
+static uint64_t aspeed_pwm_read(void *opaque, hwaddr addr,=0A=
+                                     unsigned int size)=0A=
+{=0A=
+    AspeedPWMState *s =3D ASPEED_PWM(opaque);=0A=
+    uint64_t val =3D 0;=0A=
+=0A=
+    addr >>=3D 2;=0A=
+=0A=
+    if (addr >=3D ASPEED_PWM_NR_REGS) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "=
\n",=0A=
+                      __func__, addr << 2);=0A=
+    } else {=0A=
+        val =3D s->regs[addr];=0A=
+    }=0A=
+=0A=
+    trace_aspeed_pwm_read(addr << 2, val);=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_pwm_write(void *opaque, hwaddr addr, uint64_t data,=0A=
+                              unsigned int size)=0A=
+{=0A=
+    AspeedPWMState *s =3D ASPEED_PWM(opaque);=0A=
+=0A=
+    trace_aspeed_pwm_write(addr, data);=0A=
+=0A=
+    addr >>=3D 2;=0A=
+=0A=
+    if (addr >=3D ASPEED_PWM_NR_REGS) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx =
"\n",=0A=
+                      __func__, addr << 2);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->regs[addr] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_pwm_ops =3D {=0A=
+    .read =3D aspeed_pwm_read,=0A=
+    .write =3D aspeed_pwm_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_pwm_reset(DeviceState *dev)=0A=
+{=0A=
+    struct AspeedPWMState *s =3D ASPEED_PWM(dev);=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void aspeed_pwm_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    AspeedPWMState *s =3D ASPEED_PWM(dev);=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_pwm_ops, s,=0A=
+            TYPE_ASPEED_PWM, 0x1000);=0A=
+=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_aspeed_pwm =3D {=0A=
+    .name =3D TYPE_ASPEED_PWM,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]) {=0A=
+        VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS),=0A=
+        VMSTATE_END_OF_LIST(),=0A=
+    }=0A=
+};=0A=
+=0A=
+static void aspeed_pwm_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D aspeed_pwm_realize;=0A=
+    device_class_set_legacy_reset(dc, aspeed_pwm_reset);=0A=
+    dc->desc =3D "Aspeed PWM Controller";=0A=
+    dc->vmsd =3D &vmstate_aspeed_pwm;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_pwm_info =3D {=0A=
+    .name =3D TYPE_ASPEED_PWM,=0A=
+    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+    .instance_size =3D sizeof(AspeedPWMState),=0A=
+    .class_init =3D aspeed_pwm_class_init,=0A=
+};=0A=
+=0A=
+static void aspeed_pwm_register_types(void)=0A=
+{=0A=
+    type_register_static(&aspeed_pwm_info);=0A=
+}=0A=
+=0A=
+type_init(aspeed_pwm_register_types);=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index f7f1b0da75..d304a98498 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -138,6 +138,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files=
(=0A=
   'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
+  'aspeed_pwm.c',=0A=
   'aspeed_scu.c',=0A=
   'aspeed_sbc.c',=0A=
   'aspeed_sdmc.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index 4cee8a2b45..d6af2fcf85 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -299,6 +299,10 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C =
write: offset 0x%" PRIx64=0A=
 aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 =0A=
+# aspeed_pwm.c=0A=
+aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 =
" data 0x%" PRIx64=0A=
+aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx6=
4 " data 0x%" PRIx64=0A=
+=0A=
 # aspeed_sdmc.c=0A=
 aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0=
x%" PRIx64=0A=
 aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x=
%" PRIx64=0A=
-- =0A=
2.43.0=0A=

