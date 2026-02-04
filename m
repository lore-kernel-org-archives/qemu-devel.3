Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95724E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY96-0002ak-2t; Wed, 04 Feb 2026 03:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY92-0002YI-Gi; Wed, 04 Feb 2026 03:21:52 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY90-0003UH-U8; Wed, 04 Feb 2026 03:21:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiDI+jL5Ke6j0c1kapVY3rb2CI3t6qweNSIrDFbTpEy8LWUY/Q4HzgPOF1slUet9roAzUO2EvfXD0QS6jkI/5eqHJT1dUD1nJPAkHteX1S9jGn59yHNTSkfjl7TFVchnAJ5MCtyoonkMYSW2gQClnva10ipycV7Gjkd01hcnEZH7hu9tlhaRp1IACV/ZVSNrUp+M3DF8hyxJmZBisFHIOicsUzqKbHDrWuPjcC1NuaXylu2G72FnQSCRDMKGt+RP6wVu7hD+RPtUv6tANVUrQpm7Yg34JpLZuf7sbCbDoCgnRAHGtBiLv0m9f6aC1WKxn3FDb9+h20+RnlQxU82E2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVX6/obo5ZRqf5GG4CtzKyfsp6QzHAATWkG6gpHueOc=;
 b=gCogizKfoyY94D7TD8VwBJg5CBMljWtgX9Hjx3SiYRLHw//OpU9wvE3GOVSjcn7jZrYAd6JcuSqCszVrXL15vW8vIeW1jwwbatZu8wntbFGQ1dpi3Qwld486612A21k2Q7KU2QtKbbbtgRNec3Y0tQChUtNAUX1pcgRjnbhlGKNzLj7+lWo8Oeps2DaopUVTPI7ZGEISW6GgrUaap1yIkACjvK5Cp4ltemsUBS+nQ9du09bXWRjoyl5bRbM1le1TswTXjcg0TyiDKtA7U7BL/mUXTrE2AAYr0zwRTYiTvrQtDe/3FaN4/ANavsN4HsEKoxtiOWb3iWaYfgHmOLzD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVX6/obo5ZRqf5GG4CtzKyfsp6QzHAATWkG6gpHueOc=;
 b=jD6gwxCEqrhQ3xcmhHCeBwOB5T23nbgHJEm2wEzaZolK7wKjD4IN+rU13X5h3bhcMRL+CUUizMJOv55e+yDwvuvSqeDFbSjnaEzkdQfXJCCXSwkU4aI+5mB+7L2jhAm0SQV20HJYf6oOciYTDFpZCNBRgsfnLC36QQAxXUaRaWUwcMkQJ+yqYxXH7N5C4e/XLX/fN5tOWL7B6qS894CDoah2qbyGldmJWkrewvK2E2Nj7kApXRlrQRv7/XRtBUNrF74ajN8d/Gqrbi5LYINgfNRQaasMBrSFrHGD+xMFgot3bmKupomlN26BbXvTLy3CnL+e6OFWSxKn2l6eYQ7Wyw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:42 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:42 +0000
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
Subject: [PATCH v7 19/22] hw/arm/aspeed: Enable AST1700 IO expander support
Thread-Topic: [PATCH v7 19/22] hw/arm/aspeed: Enable AST1700 IO expander
 support
Thread-Index: AQHcla9KO2hoz44FCEekWUReH2F9qA==
Date: Wed, 4 Feb 2026 08:21:42 +0000
Message-ID: <20260204082113.3955407-20-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8187cde4-a1be-4df9-7d95-08de63c66d66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Zxvm4Epfc2ChEBMnM2p2x5CN8cV+HflvEEX4HeAtgvRH2ZCp5wp4JSxvPI?=
 =?iso-8859-1?Q?gtg6vEw+Gk/PE1EiUErqsW7DWnvbax8bKXWnyWfFZ33IFUKoR3XA3bKNmn?=
 =?iso-8859-1?Q?u0Q0y63SgXSIVTYNfrs+h2lnMiVyj/xdYXnfKfNx+pU0PQaUMrXZhQJ7jN?=
 =?iso-8859-1?Q?oY0bQn84XtrIZLPH6Oign/DhmpTrVZaa/ytnWTSaAkj0REbYFE3tky0ltO?=
 =?iso-8859-1?Q?BuyfFsmpFZUCD54U3RAXbNvXCiNLub7QnSeGqhTL5hShzn0e8dUsHxamws?=
 =?iso-8859-1?Q?v+qJtMu1vU5oyI41dE1sySMJfyt9cCaiHzwqXglBZ9UUKbqNL4FOi6QD63?=
 =?iso-8859-1?Q?zZoiG59HbrN0MQ0VQAQ1MQNYlHsQYbHqLwD9qyL3gHR/q0QEjDv6HGwaXM?=
 =?iso-8859-1?Q?dPkA9Ado4QA25AUoV9exrGZmbUl/rZ6ohfcAS29LksbFQuM6IZGbP//E8Q?=
 =?iso-8859-1?Q?b9+GiLSiFJhn0qrlSpBBiz9QLPfAHLtUm2X3cS7hGWV978xBClUa1GtS2T?=
 =?iso-8859-1?Q?+H8dIG/EEHy5kLhL73AZtPK0W9Y/rMS8OuqKDW095JdhhJtKJjoUryi1Qz?=
 =?iso-8859-1?Q?M9XdzdkiZYPy3VjLIgqClq9RPxvdITEWrLVcZieIPdAAB1WtfJYpxddx2N?=
 =?iso-8859-1?Q?OYN0RY545DFwf0Ob+duYZtdW2FDUieAGYd3zGRK9ZPM/dsoiircGWsA/63?=
 =?iso-8859-1?Q?xPsNkpklPG0NSpcb4L0aaDqqze2iFCuZsMj1sOOMuJNN+m2OIcb/Tm0w6O?=
 =?iso-8859-1?Q?Z3vSq8BBozNl1B5i+b79Y0eA/CjZLJYQP57MHCz2dBaDecTDDFwLM8FUZ1?=
 =?iso-8859-1?Q?DV/FKHIT6jXc4feAUdrNzVMpZfW+45dBlWjrgkVO+LNQII8JWED8804Vn9?=
 =?iso-8859-1?Q?v35pxVC2avcbLUEdfwIcBmSzM+2upY52kkW+bVb9JZDcigLrXLMAJJ8g7n?=
 =?iso-8859-1?Q?Q7MrHBNqM3Y296e4ICEnmzZeqxVzGDvUFFh2u1qOWHMSq8Jds4iLsdu561?=
 =?iso-8859-1?Q?xJ7bLDh+SSfh+kvIfguV1i2Jds01WgOpUWvi5dcSSlZNh4927bFQHZuXUl?=
 =?iso-8859-1?Q?EiZ7xVqfy1XYyImh9SUcRQXVzhbe4N9fp1qFzi4fUtNrwgCdNfv69Vs01C?=
 =?iso-8859-1?Q?8GXspjVF7Ao+6Cn0hl0wHP0F4D5kuYwmsHXSnzMjdK/0WCwp1CGGhaeU0u?=
 =?iso-8859-1?Q?va4qWLlwktkys7gYu/s6TUmgoPVQmqMxIOT2H+54iBaXq6EeA7DBhCwR5F?=
 =?iso-8859-1?Q?XuRRje4i4FoEiIeZaTF8RP8JYwGIpKhiFIyge8VZyI/S3fJzx/QHXOJ0+z?=
 =?iso-8859-1?Q?o5H+j2lZoN3vLXwhAl/V+Aah79HAVCJfV+R/j6ydZ0OkOXXAjyu8wzvi6y?=
 =?iso-8859-1?Q?Dm02gK3YT80odI5hUUQgWhy3N0ANxxj2FW5vGn2wqAhfspWz5pF6Wjn8cD?=
 =?iso-8859-1?Q?fscyIcohzs12oa1idDWNHTvD6H8r1MabvznIsurwQrsXqa5INV6Whlfc2g?=
 =?iso-8859-1?Q?/aY7ZKxYbFi8Ojxoxd8rixY0LYEMisw3GAkQZjwlcbMXmlF4hPJceGI9Be?=
 =?iso-8859-1?Q?H5/uxcgUtai1hM6M7T/HWz3EXm086tqzJQ0DbXimqN77Cb1xD7bpFW0W57?=
 =?iso-8859-1?Q?low4sHIbtyiplxy8/ZKXq4ZlMGE4UVoNonvCZ/gVHIKrpOWbtvDDjLwhhh?=
 =?iso-8859-1?Q?/IJF/HBAp6A9t4wZTIU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yDqHqeZ3pWwgexFB/ns76VvqMVT94UtDkRDLmvTV+zxQwnAdfkWHxHBiBm?=
 =?iso-8859-1?Q?jX+8P2kA4xkLwmynVa+v5yVCbW/fYgz09N5dWT47PaK56YN/+gp8NZK3+X?=
 =?iso-8859-1?Q?uDQ8yWCNupb3CE77ANxW1DVeokg+aNB+5KQRrmKTCmf0ZgVHH1MQWoxDDV?=
 =?iso-8859-1?Q?WvITN6ZHMYjEvRLLBv20AEInBae0pLIbngbr0xbGozm26ePHGEe1KKmTrU?=
 =?iso-8859-1?Q?+wehD998OrlsNIHa7NWVKwnktxmcp5mTyqh94xMxZy3iz7WKn4BN+wKYeL?=
 =?iso-8859-1?Q?FDqMHzJY6SjpYJOZ5dHIzXuFemBMdZuBqj7xUXiLW6ORWgjpuDJDKJDgc9?=
 =?iso-8859-1?Q?X6t5ndfHrJl+VXJDO6+aRm0fWm2y9FukAoAdxuHxGqkOxf9Q0po0h4kEA+?=
 =?iso-8859-1?Q?LNL4faQeNQ7sJLYrTL6giwthvf6FqHfIxV1Mbf+LeVqk/9fu0ZTaJ4YUR3?=
 =?iso-8859-1?Q?UGupE/x/QEPPu2yoGl4AfxC2QfoNfTKM/kvYkvyb9ZLmwzw/MPX8aOeCQi?=
 =?iso-8859-1?Q?JUBFYwF3X2xKqxv6o4h8qNeWHpbwNkFDpQ+LCsiAFMPIec9nuu69SWC26W?=
 =?iso-8859-1?Q?B3QkdJf3Ho092EfrCiW+Ur1MouF03sPCefzMsV99glS+/W8X+o/f94vj8s?=
 =?iso-8859-1?Q?o8+gjOX6xmG+gQNmzEKmdI41JYeQE0BI/lqyZlm9+VrVAR/nDxeC/WrwvE?=
 =?iso-8859-1?Q?bmcALAfCr8dzrutGL2pSOwjqyXRe6kRkYxToQtMcgKMUUhJgVj7xDBqzKa?=
 =?iso-8859-1?Q?nFZxchxVEzVloswaLUPrN2oq8KQzLRROZZcv96p3e0LEVutKDgsukZlCv9?=
 =?iso-8859-1?Q?tQlQvUkokfd+3jn3vZ4ej22X72qTu+sPpsQVoH6bc2c+gT2Rymq+JVOlyY?=
 =?iso-8859-1?Q?cwFPLI7RDQFLrbMuUU8GKm50KxL6j+t2neT7xLSSH+UMhdHPubbBne+fny?=
 =?iso-8859-1?Q?dnwcLOVgW8ltVQ77uW9y1GxyNMjaNggOZfByReS8VCT3FKHJUPv7xKklvN?=
 =?iso-8859-1?Q?ZyTh9iPotRyShZ+Fngkm0xVvtKkjIFE5RM01529mZnnbyNJ8dLNkH7S9xo?=
 =?iso-8859-1?Q?pBWu8Md5q0O6o3j/OSyCrvUBz7x/GRpqme0iZnC03Sb69H1ArE+Gi1Pn6L?=
 =?iso-8859-1?Q?SJAi0RUiMJD8DQOHXXf8BiG4CGzEpK8S0GjKfxt+t7OfbF1fWd7Ka34Cxu?=
 =?iso-8859-1?Q?s1Pj/Mf80be1GUgtJKcjdYlTE13W3XNqXj3LjSfipRLr4eaUbbPN6bUaMn?=
 =?iso-8859-1?Q?QkGHqKthmMnBRYi1U3oRV+gYkOelbsH5icf8gkkGA/y9zDm9ZkSQ1xLG8M?=
 =?iso-8859-1?Q?NcZxyKLNylv+2oiTOUFrEwAFNiT+wRygH0l4G601wjk9bYUpmLqyM1SkqE?=
 =?iso-8859-1?Q?Vudw+P3cTesZTBgQvImZi+yEo+/FlJ2i1Y0z89OoG7Lvu9Pl7S8HuTNOst?=
 =?iso-8859-1?Q?3kiU/dZhIumJDRfEiafI5E0JkGH4Wc/hVKvNXdbpvCghWZsgD01QfCvkFf?=
 =?iso-8859-1?Q?Eo6HGyYmb+QVQnYHZGoCVriCk3VEX3TPoB1aBfPgKPRPpJ6zTdRCiYCBzC?=
 =?iso-8859-1?Q?TtMyLHhnIOBE94J4HHJ1Hs5xrJZkvC0fEtHtIXZ8LgSLNj+29xmv2cDg8n?=
 =?iso-8859-1?Q?QL2MG0KZI6T6QEdMRxRZw2UVPi081Fb8OMm/TelPGq3dK3uWbl/zfHvxnl?=
 =?iso-8859-1?Q?5upyadPmYq7U5z1XJGPa6qt5CdMRohkQNZNYOL2VLhNuY8jGNd0lIu3bO3?=
 =?iso-8859-1?Q?/acBw3K9iaL7mNirIJnP2yEcSdrF/Da/EUnqWiApWp1MLarEjiyvFtxTyn?=
 =?iso-8859-1?Q?T3DuutJEIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8187cde4-a1be-4df9-7d95-08de63c66d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:42.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnlIuhqjYgMirKWM7uo18Lgax7c8/UQp5yV0jHltpK1lbwshsOwwuvkpMLiev2P4a4+kM3mQyOMFXoUjGxUW/vdloBlDvAbpb/7AxAkfu+4=
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

Set ioexp_num to 2 to enable AST1700 IO expander support.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index d3b305fa7a..61790ea1cc 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1160,7 +1160,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, const void *data)=0A=
     sc->macs_num     =3D 3;=0A=
     sc->uarts_num    =3D 13;=0A=
     sc->num_cpus     =3D 4;=0A=
-    sc->ioexp_num    =3D 0;=0A=
+    sc->ioexp_num    =3D 2;=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
-- =0A=
2.43.0=0A=

