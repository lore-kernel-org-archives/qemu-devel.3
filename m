Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE4CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESx-00021n-2r; Thu, 15 Oct 2026 01:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESg-0001rQ-1G; Thu, 15 Oct 2026 01:57:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESe-0003Ek-HG; Thu, 15 Oct 2026 01:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeVzvJPfzuhEuFVlflv6bx7Mp8Fpfw94dIH0ENirKUvYYUqKYJwNA2JaqiYNl1okPJzl/BCBZL+ewK+RA+rxWxIJzZet1xD8uQyREJ7kqX5ZTpEt9C6tZcRZxYCDGm1Sp38faJ12WBHpDv40KBjz6V3uIMCgqdSGHAQTJ+NmSe7mSLoqPcdRgFPjs80t9vxEi2jm09slPQTcY5fm1ctWA8Q7GXAJEJTrvNbF3OGBWqc+THQT7BAZmtaAhgBozM7RtSuU0tK/XaPipAuEcm2u1zM3Q52BaxRgMeK7EUgoUsxafHLqHPf0jddkxpsWTp2peeK+8NieEb3bLZvizeBA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK1n33dY0Ap6ewFhzzI37fzA6KhjHHsd8TeIPyls7E0=;
 b=EhU2buCLE8z0qFKJtA/lT5W4hQ0/8175dlMaYpISGZOWy3rZ0TDOFbyXkn4hx65oBtD8+lVEjt0N9E3SpGiMjRrz5kXnNF3DY+fwDYNw7iPiJfK9vMkaLFnAI/z82bdR4ApGcOECYJSYB1s5UlnFkfF0KUJGrWN0UYR+UVwMHTSU0LKzAiHDeXEn7QN35TUzTFUy9NCY3/5YKAZrXqvxqTInLOcl9MAj8q6Jm4ojGf8ZckUpOMoC+ihcVF5bOYlzrIpeui/QuL6gucn/flMqoxSe5icb2DumXNO4cGtcS5Hhkc99ClSwMDerkj5WPmYiN4c7CoT/shrG5lFKBHXDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK1n33dY0Ap6ewFhzzI37fzA6KhjHHsd8TeIPyls7E0=;
 b=Cb3ZQfBnoB1NS+hveLsWR+MHtMawnvMT/uJsGHNOt8S+XB/mumeC+tcGHZ7xx3lOaf7r3mXm0+W5Y5d3vaoWpgJNP9hHKPOzpWDPCsOrXtD/CpfdewcePqrOYwmeyjqBoMo8NMSqpVGvuLNCnMy4PP1/QyohpgqT35DNyPmokKtGCrWCKG7qCVXhNSYXMPXQ/ZLLJRAclEcpYSh1+JLtYBElBYXMNqeGb4Do5Q5YB05sysAZ6R9p2JibevMXwgFfxWnFOhlsTE5wE8fIMrn1v7z1cwRpGprga8qeivBgkCPYxJHNsr/BsT0dj4QCj+YFe+vujAwr2WMsmaLqcj+gvw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5380.apcprd06.prod.outlook.com (2603:1096:400:217::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 08/14] hw/arm/aspeed_ast1040: Add FMC and SPI filters as
 unimplemented devices
Thread-Topic: [PATCH v1 08/14] hw/arm/aspeed_ast1040: Add FMC and SPI filters
 as unimplemented devices
Thread-Index: AQHdXGn5BCa5pTCYLkmNY+8xN+HsdA==
Date: Thu, 15 Oct 2026 05:56:52 +0000
Message-ID: <20261015055642.106204-9-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5380:EE_
x-ms-office365-filtering-correlation-id: 7ccb9321-0805-4d89-7c1e-08df2a811f71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|21046099003|18002099003|10067099003|921020|261009223027099003|261009221227099003|38070700021|56012099006;
x-microsoft-antispam-message-info: SbEuVN/cE6I/vGu2t3ZMWWaNGg8DUJPoU29WJwn5nvFeD5NSc1rrABKW/oAkxgBIhWC32QXia5nU8ds20g/fuF14TSHuo98dNuoV2w1KN8jx6AEmwLaP4/6FiiFCJYxF++kfaA9XK0Us4CaHbZk/dmMcsgqNVQg6PZ0r3O5a2RvM6QrbmWKG8oC8RlY2DudoamxVCxbbLuf0yjcK/6sN1hmMSParulxej0o87ZOD5R185BZqgY9km9Xsn1SJff2QT3hdkB3wg1p0+IVO8rDi6WEoJb5M/OrI9FFHmHY+EiSO4gXD6ty4lvCTh/LddxggqQdvvtEaBvwjGX1gNhwPfsRtf/LDAkv1/VV3nxcCOgALwY9JfI47a1WPkzJOsCBCxIHUBvreHwMsQKmQn7AvCQr4S8PF2e6SZPCQ0/p1W9gv9ltwLWmBGnDZv/QkOOJAaSf89eN8KEUIKLxazgKg29BrND25f+UsfIBXQkukoYLrJ0pp2VuRtVkppEexukxPjCfDSOfHUULi+Eh1NNl2N8v0hHSycpDOYmob8HsYU4h/wDV4Zc3Ti+/xMXoeD3srt519rqGEgLD0cW/es124WP/Ar7dHYbsxART+BpmJjh0TOHpMf2sEoceT3+OlZd6nJL6Wx+2gURBgtWDn2wsIxOVQryk/U1LN56Wsj7bmVNa6dQpE5jwSKL2nWMNokcxTW880a9+NAyK3ChReLKWo/RUgDAEnXXu2sLQhxtdQtiE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(21046099003)(18002099003)(10067099003)(921020)(261009223027099003)(261009221227099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FYJmdqD2LSA4BclU3CAguehhrf6eonG2/JTJ450uf3sqzrR6UepaVUPoqb?=
 =?iso-8859-1?Q?6uPVcgNl/CsVFk3xoC4VlnWeyZCAhywy1vfPTnOTZ+QqWDy1hgnsjX+BkN?=
 =?iso-8859-1?Q?EyIPhm5q8ymow1wvTgTqieaQRN9egmCQOfrUUIdOLQtVJwadTsNcvgAeB/?=
 =?iso-8859-1?Q?HMp5PO/qloARJMwXA516h+ULs8m+tK7jD/WJ7gbTQPGR7mspitO3HoQjEi?=
 =?iso-8859-1?Q?LpVCReZEtyJkXNm4UoGTqTQynYF795292iJ1CYI+dAn8QUg3bQeXuUuKST?=
 =?iso-8859-1?Q?y7b6yYzemyC5lUKP5Vzi9Nl++tN0ZPEOOU/LtqsPRxHWKH2n8GdsgpkkNg?=
 =?iso-8859-1?Q?7lL2hT2apXtrfRXb98EFvipSBe4T0M0YwF/hQsW5bfXCX2mPHopPhvYmgi?=
 =?iso-8859-1?Q?x0wz/MveEyAv8IcW1f1ZUmx2QFCOJE23eIXuCzjINX7Wwou7r5PzM0bEeH?=
 =?iso-8859-1?Q?EjRB1oayQxj25TGovAUtrQkOOwgZtsBvm7vQ3By2g5tCCJ7y22Hi6VbtvR?=
 =?iso-8859-1?Q?a/fbtCtD83REtlj9mCaCRpT19ukn3Zku6oIkD5GCwftNd5Z8qyhT5a+1pa?=
 =?iso-8859-1?Q?jaQm18redr7oCLLpIpXa7dFM/hZFVoWO3oQ8T1NslJ86K2M2fxy48crjjO?=
 =?iso-8859-1?Q?DiFwsG3q3dV+FX98puDl+YBuJ1ePv3xSMKdkUzbNd44Fxe6/OuQt5P8CjG?=
 =?iso-8859-1?Q?XoyBrLn8cgjw0vpeiVghsih1PaUSxQMte0lZpqyafFqZ4s37N+Dc3wDmnd?=
 =?iso-8859-1?Q?xPiqeE/+IKfAone5g/KuoSi50ackNmPukaTTpQ9OnhXW6ewD+v9rczhOHP?=
 =?iso-8859-1?Q?sHaJMVRHe+1XIZCdMhCET5ulD6PDw6ZBUunv4jADk6bNG6HcVaufk7b6vq?=
 =?iso-8859-1?Q?EK6QpQ/ycHgBZpUO/ljnOXi/70Htq5FBYv739VIinQ9DTTuShpIFf6rZf7?=
 =?iso-8859-1?Q?2uk8pOs312IoXClgAW3b4ewue5VBgtqrm3EU/VV8ec2+VWCNeQc/iTkLNT?=
 =?iso-8859-1?Q?+WzTEJWNQVgdvYEi9KgBZNV0cp5lzWJTGut4Ua+MCFn9NH/zLXAEDyr/5C?=
 =?iso-8859-1?Q?lFegNpiE6vfsRzpoJgHuc09OTKfTGuROrgFqnCttvfcJRBqytwoWZca1CV?=
 =?iso-8859-1?Q?Nt5UqWWg8wyvmYT/+eYKcXhqHntgWJGntm2oj9+yvft+93fv8jHRYEJ59q?=
 =?iso-8859-1?Q?dT5WapZVfFHEwLghYhxOBMPm2QTlhrWewbcYOeev7v8d+AX8HPKWSRnvNs?=
 =?iso-8859-1?Q?u387tkNk5kMaygxvreuKq1rHkZcLs+A9jK1soh7wQw9xvUJtUaWsoG2h6L?=
 =?iso-8859-1?Q?rsybVfAKUyWV267hCONn6mYKgSk4lBeCCc6+9PzIReRbz3ez9MY4UNiqx/?=
 =?iso-8859-1?Q?O9gobUoPFmJAxM6Zr9pjZiPWrwInVdDR6z3WjTudWUeaRYWjhbAu+b32jc?=
 =?iso-8859-1?Q?awoF7+kzOsak0NciY/imEic39O7Ki2iFQ2DMd5a4oLmpEG57bw4ryEb5lL?=
 =?iso-8859-1?Q?2ATyet1NCkbtSyWv0rbKgYulwKQs3fBfigG+XZeNzrkJfD7TWCqnqfpbuN?=
 =?iso-8859-1?Q?+1VfRKXJWvqhbndMPJCjcpL4bexeSWUPFRraOK18sTRdSmf43A1+v5+CgW?=
 =?iso-8859-1?Q?7TVhvCS+rI0k6jj76ZqytgSyH020nm/p2DziTxJu8/ZiSI+eFKB9wiz3ny?=
 =?iso-8859-1?Q?hS8YBwke9l91DhN41Czjopd7MDALmsSwB6hwQ8WKwGNSG4Mt9qr0RaBheK?=
 =?iso-8859-1?Q?DgJCz+BqLQq1PnyJzE35BULXLa9O+6GDtrS4+P1CA0J+Y3bmxwM+3lMezI?=
 =?iso-8859-1?Q?+Lg60FuqKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: azRKedRefoc+u+WKClLvg3ntIgUm5knVbNgNMbUSWuzW2MKKe1mRj3AEax8aNEvzkyEjqIXN8972Vpj+8g4g8A97SMqe4pPp7Uttuz/fvZN0/5ZOU5YzwFGrzyV7CH34YZc+oBWSCrttgfpZcc9jmuCm9GYxwH0jhHJMlc9dkxhm2I5mZaYkOkXeFWk746eb41szeCrqQDtNB/t+JJvGxNWKrLF4/AWJj3rY7bZjX6kTU2UYHb81o8frm9+yzXLwOTNNwwkFBtD7nwFs+APbC+BEV7CyWfqL3KWlkMXzEsf8u7SFkaUITF1A9kAOlb8x1T1OkpBYx3NBpY6S4NekFw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccb9321-0805-4d89-7c1e-08df2a811f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:52.3137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByEBWNdf9AGkgidehm/Dlwe5b5ui1b6ytQjbQaKGYzXwjPH5tGLcFuWgRPxZX1JnyjYqom/k6+7JPKIGRGv4WkNHgEP/99M0ZQugqF3PULM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5380
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

The AST1040 provides filter register regions for the FMC, SPI0 and SPI1=0A=
controllers at the following addresses:=0A=
=0A=
FMC filter: 0x74000400=0A=
SPI0 filter: 0x74010400=0A=
SPI1 filter: 0x74020400=0A=
=0A=
These filters are not modeled yet. Add the register regions as=0A=
unimplemented devices to reflect the AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 6e3b6900e0..5eb091e675 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -87,6 +87,9 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },=0A=
     { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },=0A=
     { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },=0A=
+    { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },=0A=
+    { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
+    { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

