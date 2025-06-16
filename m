Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38786C71157
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 01:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQyeG-00069t-7h; Sun, 15 Jun 2025 21:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uQyeB-000696-2d; Sun, 15 Jun 2025 21:28:28 -0400
Received: from mail-japaneastazon11022130.outbound.protection.outlook.com
 ([52.101.126.130] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uQye6-0005y0-Td; Sun, 15 Jun 2025 21:28:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPTLHt+iqUI9Gtiu4hsQOAziRI2tJIsUhrSksbNxLPx9RJYYGY1tkodG3E9kcfMyzZ0ZkrANH3j6sojQId1uYGvi8jlEc1HyThz0giTgUvhOShCLL/UdM5KkqMo4IS776HlpL/mhdXXpmkHP/B9KRniiw5gmAbUWYSXiedW4wXvW4wTuftyTwdkfyLmORweFthKAJvXvl4eLMhjpENVTZc8a+844qu0XPxSWJt+bo5hvvQdEvsviS9fvJp6PWGvfIxQ/m3pn5miXT8AswP/w6CJmwIH0uxttu+8cwC81LRRVirfOg6HH2z4DDTLJPz1jq9HMgFxzrfpdZPP3pPiSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYn3JRFo/HEjnpVA7AFVpmJDrxX/S763EMEb8K8HU5o=;
 b=eZ0kHO4MQXI9sbwZa6xSSbml499aZDvWv1jMWafQ3BFhladvrOCZ/fdKQffHURRM2A5JPHCzsDDzkXMVdVwtS+n3/o1Nan8XJHMKxUJm46/8pGa6aWEX3cmz8B9LaomBOkWTmz4Lz/o78r8rG6FKJxWRqMA2jdog5jE/Sq3BgHLlyN8LLTjyQfo6HJ1ZoKWMyPPhi7dIgv1h/XLuwvyIjEk+SqkN8ZGT9je4yx10DLKceCVq2kRLlch/dVnc7Mf+ar0QoCsB54CUyMpdnk6moLXlbL7WHibV1ULUETmNaiMoiamWCp0fYpTYBUBoIyPqSM84TuMFqgh1Y5Z4GXLlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYn3JRFo/HEjnpVA7AFVpmJDrxX/S763EMEb8K8HU5o=;
 b=L+8FxwQyAl7X37CyUlHQm0OSTiFPKj1+iP05kR+kWFFLSn+Xk2dv/woiM2K/uetsYtwcoRLh16hbW24FehbapF8QvNw9ng8z+OpxgnOuTe1fLcZzlEiU85TjIrNb0pmgMAsBTCUclvP8lA8CGKXUtX+nB3+Fxv5t0hkLiAoZ4G3xKJBYad/9THgk1+C/i9xVJwgnaCUEPrCrYwvlbLtNmdZUSaQCEPg+Wqv8zM+jB6AA1td2j/oCw0w9bwU3MY2MRhmzyUoR2eT/qOFnrb+rrStfOyI2vpD3HdImKSZj9PXoiCOis4DWz/yW24sDvfq1mJdJyJDg3wveL4GMvgTsuA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6315.apcprd06.prod.outlook.com (2603:1096:400:40f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.27; Mon, 16 Jun 2025 01:23:10 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8835.025; Mon, 16 Jun 2025
 01:23:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Tan Siewert <tan@siewert.io>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v3] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Topic: [PATCH v3] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Index: AQHb3I+vHBMJOAWNRkqNXHngQxtgxrQFAN3A
Date: Mon, 16 Jun 2025 01:23:10 +0000
Message-ID: <SI2PR06MB5041D80DCEF204AE7BC9A785FC70A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250613181906.50078-1-tan@siewert.io>
In-Reply-To: <20250613181906.50078-1-tan@siewert.io>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6315:EE_
x-ms-office365-filtering-correlation-id: 73e59d39-c5e6-441e-b95c-08ddac745b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5w3niFyIApuPvWrljKwf2yDgL20iw/6cMQZ6pQ0GbfN89iEnZKR7K/a+CO?=
 =?iso-8859-1?Q?On6rm12E0YRnTW6NX/w++FnnLrxluihshBBwwEBAIcubZz6nuBy9BxEyeI?=
 =?iso-8859-1?Q?8cfKTgzZ5gG13htn2rzWNrbcZ48I/gY3C6RrDVOXa2EnGXxn1T7vmJ2qCG?=
 =?iso-8859-1?Q?sDKhJUA7qSq1sZlyxQ7qDaNJ1g01LfmXvW/fHx7lvam7q7hHUntO44LkcB?=
 =?iso-8859-1?Q?HsO7WFfkz16MaoZftOcBx+EZ8O5OA/3Bfrz/H/Ib9QWlUpUSaXwIC/xebU?=
 =?iso-8859-1?Q?Lu58VvbIhcdtc8vvmMHlO3uhS81HS9t5x7dfoBoS3DsIcmRdOkXuueGs5u?=
 =?iso-8859-1?Q?2rpoSZEnrylmJQV2p2vSP5BsORVma8kBe0Pj5JPqDP3rCdj2G2ZbFMvs67?=
 =?iso-8859-1?Q?iYkM1DYoRxAgvLAPg8so9RpsZBFOdSZI2YtaAijDKFTk8mjKXUXqxeJ+/g?=
 =?iso-8859-1?Q?DLnavDXvEdFVnLj3rzI9U9ozWabFb25ppNIWkDPFLhNt2XkW9fcG+ghEyT?=
 =?iso-8859-1?Q?2PfNqZuw8K1xwZbKlEarTeelWG2960o2+SHFT8rPBIehxrx2wCdEZRa0Db?=
 =?iso-8859-1?Q?UFZw5ydQSfg7o7UI/diT6/6JvkeeL7A3VoHhxT2Uw3bHf5bIl+++SIRi/5?=
 =?iso-8859-1?Q?hHO1kfce3SP6WFVx9Vs9Vwh+cysucdLDisgORY1GRZyEqkAXfOwQo/Ruqe?=
 =?iso-8859-1?Q?M8Z46QX0DKTgqRF+Cwvbbow7gMYZHGsBNa1xmCd2O8Yrjrl+AUwllMa9fO?=
 =?iso-8859-1?Q?NknAMXM0xhylfmsQo6z+iEAqfa8K18KbVVsq5zaRbeXrcRVwk5FilnN9q0?=
 =?iso-8859-1?Q?roMkdVXRvdcaogYmIyEVAI64kivmu9yQ8gzIP8GaBu7J1ziGAG0YSLD7Ky?=
 =?iso-8859-1?Q?2Hoftf991319IF32wyrRFykUOkM0dIBzDVX168fFGQmQHOSk3ayDzDm8sF?=
 =?iso-8859-1?Q?d3q2OYGIyaCLWiIbifSq7dNk2MNID5fuvNkI7n4WeG4hO85NDlXbNG0tK8?=
 =?iso-8859-1?Q?hXA6ob+sJExowDVbkXNQvqW/YqBt69eOYN/P0KGx56PDhfMsdpUnl5kNlk?=
 =?iso-8859-1?Q?0It845e42cwnjscw85Bl1E+hHcrnh+1yjNrJJfEGW1yfDaWwGs2R1WQdOq?=
 =?iso-8859-1?Q?AV7QTRTd+Er98Cv9B33FdHwb62NG+m8NiITPeZQFHHM5zkjwpNTaMssheT?=
 =?iso-8859-1?Q?Vx4J6YxvdWbs2mDCaSidCT6HHQIRClbyV+Uq6PeamW6GV54E64IHwjnjvt?=
 =?iso-8859-1?Q?FnB12Qa0z7X24h9RV2Yev9PzdiPb+EQQybnhHPpvgFtDqXmKiRX2xRjAOl?=
 =?iso-8859-1?Q?+wz/5pL9EW0Fjq+1PHhcWF1mikPMUS0EiazyfQzQuLNvDFt8EJNYvZDMI7?=
 =?iso-8859-1?Q?xA6UndDjejCnyz5Fr2AaxZQ86XYBoG/4+6aX4HIKm7WJ6aQof7IEPp1hr6?=
 =?iso-8859-1?Q?5oX8zKOliiZiiCgjh1XLGg6/8hLE4KYHUuRb8oTw0+CqRtaMhjIniHKf2x?=
 =?iso-8859-1?Q?kexyMsu4ZX98Q88e6uja9W7XbeudgAD8qyRM7p6sB2b4k919PRP5kTgSa6?=
 =?iso-8859-1?Q?dIOIxdU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MgdysdQoCN2sIxemniFRITsDkTAVQjfR/Rr2RTd55irJV1EWCoccoKHRgc?=
 =?iso-8859-1?Q?xezckH2J9WYfKaxK9lF5hN1iEkQBdc7DbyPXqReMw91w6bm0icyUvpWJ+t?=
 =?iso-8859-1?Q?t+ePrsdXFW1dgM320sQ3CpaLOA6mWzAiKjJyetieG48GvdK6exPOUWe7z/?=
 =?iso-8859-1?Q?Ciui/cj8TZempoeLFqw81bsKZ8eWSl2wlcWRUiczGZ5E20Bb5ymFqwD8PL?=
 =?iso-8859-1?Q?BWKSeSjxCPBWeQn7IqQAA1VzJix4O3P6dJTKs1jyd8fFCsgbal39vFa5jG?=
 =?iso-8859-1?Q?4frss+eqYhrDpjuT30OTphwRtd/qdB4cxnjKSYL9jhO2cgo57iES+MtbvL?=
 =?iso-8859-1?Q?62hA9ik05x/c66DWfLrhK5pAQfMjcnkcH32SMOG7rVeFat8C0/Qocp3Q8D?=
 =?iso-8859-1?Q?y1DrS/3tBI6eMFhaYfDJIUDWWG4t1L7h14KTYJTB3EQXuEuj/RF3drk8JN?=
 =?iso-8859-1?Q?y3d4yE2H+yLZhku2hPle/ZayciLxR1HfRrkS2f9JAC5Ax9nsb9Ubg+5nBK?=
 =?iso-8859-1?Q?TCXDnUngXzWGsTtOoPDekRTmRBUhYhyCP8+UbzJEEMKtcl/kOWtNBtyQbi?=
 =?iso-8859-1?Q?JTuNQckLwYBH6CqVceHug180SLG4KjEoBfeR3zCDD7efPNNCo6v3aCN/xu?=
 =?iso-8859-1?Q?/vyMRlkcRYsmG0P+7xHeRKy35ZPuWQJeeQ+Xt/e6FSqwnkFG3nMvCIYhhF?=
 =?iso-8859-1?Q?QRxw0ZPI4Y79RRxkpNaS9gPbymNyXrmBj2PGCZ0cziIXFiqvxzZxJAuqHr?=
 =?iso-8859-1?Q?fwdOTIib9+x7tLYHl9VGn3LOvtrCKzr2Yz/BQVIMEW+I67+wsoYkfmyRt9?=
 =?iso-8859-1?Q?gkrgeqIqm/0klQcWcbReKH66yPsg0rdZ7xvF1l7NtoZD1owHot5x/UQCxH?=
 =?iso-8859-1?Q?1fiB2B3RwCd79+GxqEFlSsVB9ekF8RTcNcr60Dh7HPgULkyFkdpHu3Fnla?=
 =?iso-8859-1?Q?tj1WMe9TCX4zq7cAxNYkNRb+ny7dRA0IQUaNnXsLTdZ4R6Kut8Zs88XrhI?=
 =?iso-8859-1?Q?F5kOQ15513ms5ZMIg/ZS11mWpbSPoY3zOkdtkEVZ4ucQuoDIVi9HIfSqHq?=
 =?iso-8859-1?Q?FzJFEOC24NUofRz0p6wH/uE4HXybod1bAATvgiAt+ywuZZccttlK5O5BCf?=
 =?iso-8859-1?Q?uMVQZdZbpTUmI0e6b9nxfSmCbUYgzT/c81DtWLts1ezTYcoeRMPC3onp1E?=
 =?iso-8859-1?Q?wrxodYNjx1aLCQzEZzFNnLymUTTW7rxUN2C8OSmDVWEMTsAaLkw2gNqlJl?=
 =?iso-8859-1?Q?fg8yuV9K+yHibenKckMAJpQ6itvzjWz0E5Rg2i7od/we55W9gnLaB/UkWZ?=
 =?iso-8859-1?Q?YZXG46ktvd6ABblTCp7cc+ev8wWZgYdSqkKIDbWoRJdA3iWi51q+iaYaoO?=
 =?iso-8859-1?Q?gZPsomqxOdEIM6MVY24vSBrEtbCOn6acXyU9lcgC8WmP6cNypKbXvC5yXu?=
 =?iso-8859-1?Q?LpSbt9ZiZNUjUfU7SVXOUNepqT1SrfekMxy3khuQL+ipAZ3Vpf53bnnyax?=
 =?iso-8859-1?Q?hHMgkrtAc8Z9lgrMgly9H/tGt1fL7IA/2zzFgDLJr/LG6m1C1ifPL8XIlg?=
 =?iso-8859-1?Q?+qvq8Y4eUvDSyN9fz/SenyI/13qVi5aC8/EJYU0SS+HAFhx1PSKVnLu207?=
 =?iso-8859-1?Q?63kC6bbEfDzZWxHyBjZ6suvVbQXpp3bRSy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e59d39-c5e6-441e-b95c-08ddac745b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:23:10.4926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOeaDh+uyRf9SYozXapLzgjb8+qc9lvdbw0ZEtlBqEMhAzLNdbrT7XpILhdMkQ3Gfg55yoJqeOnSRGyGGbff7YBIwYsAbzXeGS8ZI9tUN/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6315
Received-SPF: pass client-ip=52.101.126.130;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> Subject: [PATCH v3] hw/misc/aspeed_scu: Handle AST2600 protection key
> registers correctly
>=20
> The AST2600 SCU has two protection key registers (0x00 and 0x10) that bot=
h
> need to be unlocked. (Un-)locking 0x00 modifies both protection key regis=
ters,
> while modifying 0x10 only modifies itself.
>=20
> This commit updates the SCU write logic to reject writes unless both prot=
ection
> key registers are unlocked, matching the behaviour of real hardware.
>=20
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
> V3:
>   - Change logic to unlock both registers on 0x00 write, while writing
>     to 0x10 only modifies itself. [Jamin]
>=20
>  hw/misc/aspeed_scu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c index
> 4930e00fed..993cb800a8 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -91,6 +91,7 @@
>  #define BMC_DEV_ID           TO_REG(0x1A4)
>=20
>  #define AST2600_PROT_KEY          TO_REG(0x00)
> +#define AST2600_PROT_KEY2         TO_REG(0x10)
>  #define AST2600_SILICON_REV       TO_REG(0x04)
>  #define AST2600_SILICON_REV2      TO_REG(0x14)
>  #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
> @@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque,
> hwaddr offset,
>      int reg =3D TO_REG(offset);
>      /* Truncate here so bitwise operations below behave as expected */
>      uint32_t data =3D data64;
> +    bool unlocked =3D s->regs[AST2600_PROT_KEY] &&
> + s->regs[AST2600_PROT_KEY2];
>=20
>      if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -730,15 +732,25 @@ static void aspeed_ast2600_scu_write(void *opaque,
> hwaddr offset,
>          return;
>      }
>=20
> -    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
> +    if ((reg !=3D AST2600_PROT_KEY || reg !=3D AST2600_PROT_KEY2) &&
> + !unlocked) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",
> __func__);
> +        return;
>      }
>=20
>      trace_aspeed_scu_write(offset, size, data);
>=20
>      switch (reg) {
>      case AST2600_PROT_KEY:
> -        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        /*
> +         * Writing a value to SCU000 will modify both protection
> +         * registers to each protection register individually.
> +         */
> +        u32 value =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        s->regs[AST2600_PROT_KEY] =3D value;
> +        s->regs[AST2600_PROT_KEY2] =3D value;
> +        return;
> +    case AST2600_PROT_KEY2:
> +        s->regs[AST2600_PROT_KEY2] =3D (data =3D=3D ASPEED_SCU_PROT_KEY)=
 ?
> 1
> + : 0;
>          return;
>      case AST2600_HW_STRAP1:
>      case AST2600_HW_STRAP2:
> --
> 2.49.0


Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Thanks-Jamin


