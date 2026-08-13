Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67833C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRQ7-0004AA-3q; Thu, 13 Aug 2026 05:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuRQ4-00048b-CG; Thu, 13 Aug 2026 05:08:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuRQ1-00005g-H2; Thu, 13 Aug 2026 05:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q++8jB9kyBv3IwRPScky9XDT4wiUToQN3BGd8QOyQdASyG9nYyL6xwp8RbjylDTtdbpMdhXBsNrei0XXpxxWH1yFPcUFUDat14gCq7FDo1KNJ+YQF1owZqNBN6cdXh/MhNuadP8dU324r6O6qhFqDdnXTQaWP4yOVyZgGQqp1FUDxhiFUteDu5Fq+IqqJZgJ46SgJr14504/3bTqyVhF1DwMb6FREaNSnNdfn51JdxSADJhtGBZJ95XKr0JweAuqMc2DnNqyPU7ln8Asc1XxzcavmG1gvGmuwk8TxYmBCDXBMloxq3T/Qn0DF3CigVIjegLJJ9FZWAPpNBA4AsWhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2LvB8cXW90fmRotYjpmwY+QotpODc/pogZ16h42gM0=;
 b=k7IfYsfqFtaU3LXOE9j+U7pkqXp59XFC3ld0xuBh2/fG8c69d8+V3IKe6SWIk2svFtMeey1qQpVOLmNKvP7utMR/AsnZFP+3DPTcgBN9M6aVzhyuk/izux7hNwliScLaLllGbZtPt6njISA6e93MIWeB+mc82hBweooNR2ARDXxlXHdBV2KvKDVXLjq87AsrMiIrT/tFQhr1OUYiGz1wklWLvswnkV1bMhX/u2aUvs6DwsdQZzbqvB/DVrX17tXAu9jpjlXcEztBx/a8jjqEaVZr+EXSr1MHfuQxm30zgK5lI4qEmxx/q0gL/G/ezUlTLPBHboEDKwxE9V7qPjE9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2LvB8cXW90fmRotYjpmwY+QotpODc/pogZ16h42gM0=;
 b=ooNy4+mhGhmiiOEqDNOHxTce2nizEBBgueF7hfYVb94Y+JXLNgGXnZzvLvwpD+CoSIj4MhzzDOiFNMeGF2B6WDHEtZleQQMicxyqyFefOPolwxnXTWLkBsr/gLwYc5JuktvlhnrDeeBozpKgWPMG0mG2JdeVyg52/qEzCyqmfsFQNqeXdrlVqg1vikOxbHQP2dThWRy5w1OQ6qjElwhMzfpCWFJ8va8YvlZ/CTMISnXd8W6wmhZWAd19RyrJViZK41b410II9iDmNsNliuTMn1RRfHUcdwrcaAqzWnAUBRO8jiAKQXFGWMqUZayBeOrmlOyZ9C/xWrMo634Vpsyy7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:08:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 09:08:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "Mikail.Sadic@ibm.com"
 <Mikail.Sadic@ibm.com>
Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBus
 block reads
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
 SMBus block reads
Thread-Index: AQHdKwJqkWkcyoBADkCDJjjo6H+Egbabrw9g
Date: Thu, 13 Aug 2026 09:08:00 +0000
Message-ID: <TYZPR06MB49802BFC78FDFB21489FEE83FCDB2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5684:EE_
x-ms-office365-filtering-correlation-id: f1686201-d14c-480f-6757-08def91a5fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|22082099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: 1viHVglWIO1B3IM2HzzKSA8ugxApz0usXsoYN52GXse7PgNQ0iU81yFh34mhb9beK4h6PMoJMu6MGBG9naSKj8fen93rOtvaA0dZGGjJFY2X4ma0SfKPLJ30Ga1jPihdBhpENxNmlPctC1yA++x0khb2HJP/xKZ/0rugrpANTdzA9N7dF/NqOWqluQp5Z4GwF6CxaqgRHQRoJDEx0QZM/dZf0dbszvq2tmZJNpJVO3B78Honpnelx608ZlQ6stx70KYSju6nP7uqWVM2W9i865sY50p52LEOuqdX/WO1IpT408EV2t6p90xP30TLYrDxOKUiVgk+ucufreg0fmII74Hkvb0hyXaJ+fRrjZHDbudf1pvj8XxQG8u2zPDshLRj/05KHP3DyM/ziqvze3SspGLsdbgWCGGQASqL+/UOC6Yv7Jel2SpWUfvZqifQQAWUtMtCOD2i5BjRODAZROhLXiSDLvFzau+CbGW+OLxqDe7lh+OAWJ/BVeEYanJDZbM7ba9OC6tfpP77bGNZJuMgJsEvs8h1976up2qfSZT5CBlfjQrI5Fot1HtPyfGA2VwgpEtLVMPD/6aQ9F/VRPk+C6IePK6TBhSS2GPR2yo97sK5ceW0RPLNM9EoatsC4WjZna+pYmjT8YHoYVYMg2hVs7z48SiokN1ElAT3dh7BSIS8GYjQbhRolysqCh0XXcM2V3MvnvdC+wir5oFZgohwvkWu/E9SW/3K8uOnWsUMmyw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NLFpWJFX3hhmZCIx7m6XPxc8TzzbzYE7BQoHaWY2mFn5H4ZZuap77JWWtC?=
 =?iso-8859-1?Q?vT3KdaUYfNEvPapeNFItvN4Z/7ubF3NEa+wU1gAeGoKTi0uN2N9K2v47gc?=
 =?iso-8859-1?Q?l8iETPyMpkTUUCwGh2TKCZTh/uXkTDO0S3zRy8/GP1zmEYeVN4l5sm3vha?=
 =?iso-8859-1?Q?VnlnxngHp4j0dT92//TOqI3gBEl2th09fvk6CIUhCCG3A9UKcIGvsoBG+4?=
 =?iso-8859-1?Q?RumcexxMkCRj8qO9X3v3w8pn9+jOLsdXp6HB25ACkHSjpFkBDCTJnaL+sL?=
 =?iso-8859-1?Q?qfrYcjV2pRBJZVoSzg5Y2WaukdS2hAZ2OmG3kOJmyEzUd61i5ZX9SP39Ce?=
 =?iso-8859-1?Q?JZFvfDqpWo27ykMooRZEv7FSsrjk5Cj1FhCnX5wxaANeCr9XP5MnkGx/tW?=
 =?iso-8859-1?Q?xNZuqDdvHPPwLZpJad9BWsp3U8tlUlj2kTpxvfq7dCUpQKID8w2g9ansU9?=
 =?iso-8859-1?Q?n82WCtMFEgwUuA4ei5QKBHUjrN/awNiwxN0AIKHnaoiTZbSI5oTUANwtNx?=
 =?iso-8859-1?Q?huesZFFVkZWEGFGBDxwKQSy6ErMGNg1ESavASsN8QCUOrHHyYJrBH7iqyj?=
 =?iso-8859-1?Q?1mj8bFDHHBTGFERcNCX/yFTyPQ6cexotPaLmLV3Kvypy5VOdr1o35H1iVO?=
 =?iso-8859-1?Q?h67KG6kTe3C09LEthyW+bE7dtB7hc4kdhUDEMqbcJjvTJGz5lX0DSrJEIb?=
 =?iso-8859-1?Q?oblcvoHzpRuJ6GEok+lqRA5VpNNRzgMIrPCRCXc64PDeanN7sVpAS8KCkU?=
 =?iso-8859-1?Q?9RLR5ITxQM+P2giePtlFl5rel+jTlX+k9AFBmI9lVo39P8BAjcMR93jaly?=
 =?iso-8859-1?Q?tZlXvVYW0zyL13HqoVp+vtcYeHZ8InG46ThBXDap9b2FFFhjQDUPMGfMTL?=
 =?iso-8859-1?Q?w2EbfbecJEsrVEqaX1uUwsDYi8Sv34nkzGV7+aBDtBgWGTq4myrOaD/dUW?=
 =?iso-8859-1?Q?yrJGd0oPXhZi2AGaIFZTfLb5Fe4CBWYiKsWDaZMOHC3FjkwG9JszQ01ImT?=
 =?iso-8859-1?Q?NMBeB15+IAMhR30NtDr0/Yogfp4YaHev3IGmnphXP97ZTdlvuWJpmbbKQo?=
 =?iso-8859-1?Q?O9j4kye+uPzbWOwVBxQwk/yEJS3a2LMGE0Z+j48Q4HCSYyyA78VnBcSXGM?=
 =?iso-8859-1?Q?ORW99RdF1cyuWTAvlc1Ybf6O1xtyDQRvk17jZ+J0fKMe6nWCfWgZQpUmYu?=
 =?iso-8859-1?Q?GyU/7O78sz8wAFuVrDMHgjZovlvzns6O67kNkAWGyGTvCu1+LGBfVI6qgx?=
 =?iso-8859-1?Q?f9Jb+ZpVU1JtYcqHJN2fnQH/ocjXvMtBYGR4EdidB0OWp9gD4rryDJinlA?=
 =?iso-8859-1?Q?Q0NN4PxH1AwQ86DyvgDp6qfW6MQCcRsNKjiQNie9XR7ZQZuMoerQRmzuAc?=
 =?iso-8859-1?Q?iiflSzl1GOSVPnYSYXpw+7XWJT/wKrwJxX9q3f8xB3T1krWRWFvEuCYgAo?=
 =?iso-8859-1?Q?5THThle/ZF89BWVMEpcLuCRdvpZxkRo+e/p8/i9IkfazKsy1dy+ibdHR5U?=
 =?iso-8859-1?Q?7aY3vrNmgRufguwoFdL+HWyW2YYC0KURXtnopr9KF/ib3pILiWUTXwqW//?=
 =?iso-8859-1?Q?kYChyjwsZPz6xDiQgmEHrkb9nC94m4hGcoUInsy2U1bw5gbtwqyKxdMBQb?=
 =?iso-8859-1?Q?l4OaVYPN08ZDt1DIz3txjmIovYaryQ4jcT7zLbFrLXfTNSL8l0oelp1fJf?=
 =?iso-8859-1?Q?5AvCEKgs+yLgOnXC17EPqTVFclyCyS1lEhQL1qFNEbv/1fVdHFcU4SnFnV?=
 =?iso-8859-1?Q?NuGA2wo3ViOBsai+xrkWEv1F4mmsxU86wslcFIGpX/W+KPL97o18aeQ/qB?=
 =?iso-8859-1?Q?vah3Jpm8uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dVjudPbk+k4qtMvs7HuARq3KubxXhRcEdX5LRS/x8c524Y340BtmGKpvMN9XD4YMFnX0mQpxl9y44q54DUizUKkss/sswuFUlnFN3/XeCb2/JrxAWKSJ15gvSl+GHuj1GVJpU3xzTEXMJWYdXVurtW1CROi4WmhZh10JzAUxL4VRQX3uAUkAVmNWS1aTQ/btHZbieqMJqbm7kfINkUjvVwlK0r+aJi28RCWt8ZX+2FwnhLYdAb2B1sTPCa5jCOWhkvbPWY4uZafIwsoKTiqlPV3AfPft/Ydb8Gib838CQChW97bfjp+wI8teyXpvbaI9J4/eQ1qXnI3ZWio/iy+anA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1686201-d14c-480f-6757-08def91a5fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 09:08:00.6636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Jbyw9b7ZJBRFMHNhXWOt/4nnW59ys0EASq12a6tCQFx8EwqcGIXSX9tSPnuAlV6zRmXwOjwpxk5xaa0ll+RmZv3Z00r6XLvaW6PZ36rGio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

Hi Mikail,

Could you please review this patch and verify that it works with the UCD900=
0 driver?

Thanks,
Jamin

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, August 13, 2026 5:02 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;
> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
> list:All patches CC here <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>; Mikail.Sadic@ibm.com
> Subject: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBu=
s
> block reads
>=20
> An SMBus block read takes the block length from the first byte of the tra=
nsfer,
> and firmware reads that byte back from a register rather than from the
> transfer buffer. The receive paths never updated those registers, so bloc=
k reads
> reported a bogus length.
>=20
> On AST2600 the driver reads the length from the receive byte buffer,
> I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as valid
> while the DMA buffer is not enabled. The byte mode receive path already
> updated it, but the pool buffer path did not, and the driver selects buff=
er mode
> by default.
>=20
> On AST2700 the driver reads the length from offset 0x84 instead.
>=20
> Add I2CC_BYTE_DATA_LOG at 0x84. Latch the first received byte from the
> three receive paths: the pool buffer path, the DMA-to-pool path and the
> DMA-to-DRAM path. Each latch updates the byte data log, and updates the
> receive byte buffer as well while the DMA buffer is not enabled. The byte=
 data
> log is outside the register window of the earlier SoCs, so it is only vis=
ible on
> AST2700/AST1040.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i2c/aspeed_i2c.c         | 31 ++++++++++++++++++++++++++++++-
>  include/hw/i2c/aspeed_i2c.h |  2 ++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
> 68bdcd0e25..e6d0eee816 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -159,6 +159,7 @@ static uint64_t
> aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>      case A_I2CS_INTR_CTRL:
>      case A_I2CS_DMA_LEN_STS:
>      case A_I2CS_INTR_STS:
> +    case A_I2CC_BYTE_DATA_LOG:
>      case A_I2CC_VERSION_CTRL:
>          value =3D bus->regs[offset / sizeof(*bus->regs)];
>          break;
> @@ -334,6 +335,24 @@ static int
> aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
>      return ret;
>  }
>=20
> +/*
> + * Latch the first received byte, which firmware reads back as the
> +SMBus block
> + * length. AST2600 reads it from the receive byte buffer, only valid
> +while the
> + * DMA buffer is disabled; AST2700 reads it from the byte data log, a
> +register
> + * the earlier SoCs do not expose.
> + */
> +static void aspeed_i2c_bus_latch_rx_len(AspeedI2CBus *bus, bool
> dma_buf_en,
> +                                        uint8_t data) {
> +    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);
> +
> +    ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);
> +
> +    if (!dma_buf_en) {
> +        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF,
> data);
> +    }
> +}
> +
>  static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)  {
>      AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
> @@ -349,6 +368,9 @@ static void
> aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
>          pool_base[offset + i] =3D i2c_recv(bus->bus);
>          trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],
>                                    pool_base[offset + i]);
> +        if (i =3D=3D 0) {
> +            aspeed_i2c_bus_latch_rx_len(bus, true, pool_base[offset]);
> +        }
>          bus->regs[reg_dma_len]--;
>          ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i +
> 1);
>      }
> @@ -443,6 +465,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>              pool_base[i] =3D i2c_recv(bus->bus);
>              trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,
>                                        pool_base[i]);
> +            if (i =3D=3D 0) {
> +                aspeed_i2c_bus_latch_rx_len(bus, false, pool_base[0]);
> +            }
>          }
>=20
>          /* Update RX count */
> @@ -460,7 +485,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>          }
>=20
>          aspeed_i2c_set_rx_dma_dram_offset(bus);
> -        while (bus->regs[reg_dma_len]) {
> +        for (i =3D 0; bus->regs[reg_dma_len]; i++) {
>              MemTxResult result;
>=20
>              data =3D i2c_recv(bus->bus);
> @@ -476,6 +501,10 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>                  return;
>              }
>=20
> +            if (i =3D=3D 0) {
> +                aspeed_i2c_bus_latch_rx_len(bus, true, data);
> +            }
> +
>              bus->dma_dram_offset++;
>              bus->regs[reg_dma_len]--;
>              /* In new mode, keep track of how many bytes we RXed */ diff
> --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h index
> 05937a7a0b..c8e6ea54ad 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
>      FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
> REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
>      FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
> +REG32(I2CC_BYTE_DATA_LOG, 0x84)
> +    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)
>  REG32(I2CC_VERSION_CTRL, 0x94)
>      FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
>=20
> --
> 2.53.0

