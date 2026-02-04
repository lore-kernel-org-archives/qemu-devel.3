Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6010BE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8d-0002IJ-Gq; Wed, 04 Feb 2026 03:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8b-0002Dt-0h; Wed, 04 Feb 2026 03:21:25 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8Y-0003UD-0K; Wed, 04 Feb 2026 03:21:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7DEug+k7h4IxKA+x+1+h/F54/uLQl1z9MpqdZAnzL+6AxAQxejm9eZXU25+yYNBjcB+Jjz7CF31bGH9QTryoWp0EwYkv3zZs9h8c6g3W8BFYSS++nv1DOa74SVUIL7RMkwodKkHuegtwjjQYC2+spPg8hlHvE92SxDPdyVX6CBfiRfp1XOUfjAbWBwr2Ry2wVQt/Zrnc+Exe2KYDuYWAQheW+/1S5g4gdRq32keUhgDz9i62Dl9Vr0e3OHLXmWz8SKrzw7w18YGFCVsibwctmKZRV4of60BJKAY7pqSAjNQTZutz8sGJ9U5DmdRkVpTVvvzD/uqaUwINdkzLLtLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2GlpAd2RhNtPx3id5rH5oiKaOqrXjtccJLE3qnO4Zs=;
 b=hMkNHfbYgMnotnQBIutjDcv4JSTjT1oidCGwBTc44T+pDOaQ2WHoIlGmwdtgpPu8yP2MW/QyElHzyB4Oxa7UyhTRWYMK49lOi7Dk7vqovVDVeO6KDiw+es8vE0JdkPku6dYU0MTLDHf8szaz8xKdAkWGNZ05PsXx3x9FEZwxPNjFnoaTZqBBE+xhgVM0e6i3oUw8UJhOkIi7vpBglXJOfbFvzePh3GrRlDcFiirGfEEI4yZpbvl+2/vLufC6NB/rc0ek9F9DZ/Q3TySkZjFgs6BnPoMLLvZCmP3RzQs5CP3W46RVx0tIZNgprsVMHQs5C/NFpxy/UIJSno+T1+r83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2GlpAd2RhNtPx3id5rH5oiKaOqrXjtccJLE3qnO4Zs=;
 b=Fi5fopVaSopDcHMbXenrGvf7EN2uonGQEs7A1wgbl+M2Jr145Zzv774rslWxmHlleduj6LqjptOjyaeM9iHVferzL+uYbIRFxhvwdsWojkOgkDmgUiTK5YByk0K/UZ9AnUB0uEz8gkOl1tzOPBtT96nyNZgiIQUHMJl+ErhLC/bo0QzGRo2pCI9mTs89k6+va1ptW8W20DBThjuHoh5bgfk907S0HwOaKIogccaWKVOAmrzB4GL0gPnES10U7MDUrPBHmFacNQ8/pfzxBjF6lYk2RKAOKy087SSQR2vMOiRkYEO+cf6JkDeFVcSsnWZNcAX6dNvX/h+spqxqUleNuA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:14 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:14 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v7 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcla86lISGdP5ib0y1nfVf2vJxOw==
Date: Wed, 4 Feb 2026 08:21:14 +0000
Message-ID: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB6055:EE_
x-ms-office365-filtering-correlation-id: d8b30fc1-a8f1-443d-92ae-08de63c65cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aXO5YejvSlaPCmZwek25gTebtQa4RohS99qNkWq6j4bTS2tBmEcex3wyGj?=
 =?iso-8859-1?Q?zvrJ28W2VUdDEjIqUMPPPQEccO+Z0a02rbzflA1iT4dfDiygCiLdCo/EPU?=
 =?iso-8859-1?Q?ic/ZfAsSJLqdvSLkEPSc1IsfoJ16BiJFB0+vxpk9jPhpP0l7YewA1FffMN?=
 =?iso-8859-1?Q?ifKUflyZ0igUXV9y7FV5/ouqA6RjmafVC4a2psRmVQkdFcjkgLhTkCDb6D?=
 =?iso-8859-1?Q?kC069I1sRt0FGHSzAx3Aoe0DJEaA5DAnyKmrq77usjLoQl6O1kkX8We+7C?=
 =?iso-8859-1?Q?wARwlWITYxpV43kN9D94P2dC4sKHvR/Mo1Itr4kditNAhr6QfEi4FsC2yY?=
 =?iso-8859-1?Q?foVIrWEW2Y0kAjammEDaQPsmYvItWbe73/BOuThYVDvhcP8EnB2Vz92zCg?=
 =?iso-8859-1?Q?br8HuDItCqiKGVaggW3YjFbhrtFwgz0Td6wZWfbYnFhbYQTfRNNdycZElf?=
 =?iso-8859-1?Q?KWjIl5//RmcOz4yHBaF2O3DkjBQbJX0EUeZwzjriqY95khh0Ex/J0ygW+g?=
 =?iso-8859-1?Q?obpKSaigm7KOtJl+R1WueP5nStI0ksei4seS+tUi8h+5zOfT1SCg2L4U0j?=
 =?iso-8859-1?Q?7iA6UYb8sks7qjmZk65Q2Gacef/mcLrfLFb1l+3QIUmfbvEKR8sdW2km5b?=
 =?iso-8859-1?Q?2RH60RPTqSO+8DYDCh2HPtjrJ79fpsYiGvjF+4/HGpOrWL7ARhaYsMVRSV?=
 =?iso-8859-1?Q?uAurvCp1G1aT0Ob5gVaCbQXI1eFLrbFtGdoUjNo1d0LkC1DWxRLzNT9HaC?=
 =?iso-8859-1?Q?IgkGryAFEDmA3EGC0XODFmQ1gXVkK3SgK45Y51bRGWln+soykBCkZGest/?=
 =?iso-8859-1?Q?e6GF2ZL351tSzFmDA5WvdTcg2YxANujYP/pl+5upxtUcoLX/aDuRwCkID/?=
 =?iso-8859-1?Q?fYSroWscJgOQhI/D6T4auop/kou0mMhdfh/aytEHI3YMHokPm1OwtyllfO?=
 =?iso-8859-1?Q?5z4BhvcftZt6JQpIW1ZjX1fXVXd/JPvoSrmXPB46swl6p+hcjsDrnDp30D?=
 =?iso-8859-1?Q?+Ta4pX4vLb8dYqIhYcm9Z5bXj1KoEucWWY28C91HL+nkHEgs777/j9YKbo?=
 =?iso-8859-1?Q?6DqjiKbe6MrmCRmbONUXjBvyCzjIxGO9Bq6L6ONRvR5mR41a/BXnd/qlL4?=
 =?iso-8859-1?Q?/8/whpLkf/zRy0devJks8FWJ+qirihoNoJcmmrg+saKA1E/hKu1r03yQPZ?=
 =?iso-8859-1?Q?l3jWhLP736L69rxpwEeg75n3ecBQgYhtL8jXifQ6MoAjlVoIztiPZ5sil8?=
 =?iso-8859-1?Q?NEqIP0kpTBpqFnp7X8/IygLWcb0UcEku0ILezlHZHqO9SdoFLEuO2kY0sj?=
 =?iso-8859-1?Q?DfxEKIAmJyhDDPtnPl5R7t5tBRCCzHvKd9slRc0YdCnURIZ4G4ShL3han6?=
 =?iso-8859-1?Q?u7PwC5IKlpS9MSjLqKqFNdFNiqn/OETsYDcFX80qdmUW025JF3phjm/s0F?=
 =?iso-8859-1?Q?3P2P5k+l9jdueFSadgBOsz5QQIZMc8mIP+FioSe0dzFt3APfTw/B3oc/6A?=
 =?iso-8859-1?Q?n/W8g1f0WkxQYMcH9ZDkMmdxB/lywf/iidBk438k0dbtqpf3q7I3cCm0dC?=
 =?iso-8859-1?Q?TzQdJqlf5fB3UR/f+V6ZHGGBziLn/n8I3oAZVt8sBu5YxeZpxmed4Qt6+1?=
 =?iso-8859-1?Q?LNCyDEuHVdpy88dtoYFVYjTU2dHo75a8IIOQzFAUHWI4bxTc/1ljCbWtds?=
 =?iso-8859-1?Q?CfdOtV9enaHxzt49etDTCSQT+T0MyHYe+ekjUu1Y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KIodUjeh5W9d01Zr2DvXcZw/sT5AvRiKdvWhn1oyBajRvR7qPVtCmgf8RY?=
 =?iso-8859-1?Q?N6btEniHCq0X6ANxn27pc8zBELVCSBGhOnaHRZXnKr2tq/WYL7TNNoavVH?=
 =?iso-8859-1?Q?s1PL+wUPikQu1h9KzzVtn/+fN6/La7IrZHCEhFDh96P1o9qphAMm0rpMbt?=
 =?iso-8859-1?Q?nBaO2INrO2eecZMtLJLQW/B2KwtWbNPvKPoIdQjJ07Xh29jh0wMY9o6ea+?=
 =?iso-8859-1?Q?5z0bBc1mH4HXk6/l8/fdK63d1iyxENExU76yi2RQRRhCec5Q2JwL07QIM8?=
 =?iso-8859-1?Q?8Id98F3+4Hea6GQC/EuS00Y4jEJ7VKIaaeUZPv9sRVR5iXUQVSZWXohWVu?=
 =?iso-8859-1?Q?erhcVIywLYfL0iNgKmbT8g4COk3Lfgto/yPhdrX/iECRtsIaioj+4T67jS?=
 =?iso-8859-1?Q?9gd8Leoq3Z5XaEUcUDBEsD7Lg8oDTwkK0G6SL02enRqA9SA3eQzpDrxf01?=
 =?iso-8859-1?Q?YS5CsScgBQLXWXZPPXGgJdy2ODj6noy7mS49250dsitCn1iLKABdFVXEqe?=
 =?iso-8859-1?Q?oKuQmzTNhqv0Myat8PyAHlB0KZ3dxA8rrnbGOUi2urwW4xwsj04+B4r8iw?=
 =?iso-8859-1?Q?FyZeVkkkqW7piyzTtOPaNG7fpTGdSbs3tmEwi6imcDcWT4CNFMa0jj6pSy?=
 =?iso-8859-1?Q?MO2JPDLYciXeCbJ9RUgTeN4Ru6PEheqddf++I+m90Znu74qEXnt6aQfd06?=
 =?iso-8859-1?Q?mcBuwZWJ/fpiq9SnhvuKVQBIloxh85OjREgNrQIEtmjlrXVifL8sSfg3PF?=
 =?iso-8859-1?Q?BituJVeBO1mTXEmN2MfY65S7uZsanY5YgjaeQageGmxhBXxtsdJtOHeaUa?=
 =?iso-8859-1?Q?FRmSEIpwPSDbPs5YXdPruPtHiNnzxyslNcv+6154FefzkhHkJhj/0apx/7?=
 =?iso-8859-1?Q?n3LPNAod5otDRpn0DMnxJ2vF5YUQq43dcwlQXcOSqh48GRvjrdfIHdV50I?=
 =?iso-8859-1?Q?0X89upcY4KQJXBWXLteDUGMlZAagpCSim5MsP7AJxD0cSnce/DWipE9m/O?=
 =?iso-8859-1?Q?QmyT8QAQt9AF9j/C+ThDydyMi3TSg4q0fXMMnRmbQ6h9MBYis+s0KJCyBE?=
 =?iso-8859-1?Q?euCTsfrLakkm78Bq6Ddj0gt4f6XI8znRdnLlgNEzl5rf85cc3RsIcpZe19?=
 =?iso-8859-1?Q?m7ra3GAqyEZ8LTlrnWUKRymoDBVUzaXs7iwZGonb51/VONbPVtSM8rBNSZ?=
 =?iso-8859-1?Q?eUZzw4V8uFsqstnfOaqHLLL9nlAsChqJVv30OXRlHhcRqp1gGJrfX4xKeC?=
 =?iso-8859-1?Q?VGDB3ME69z/rnVorBpbVC1/NTJzYFr4soIqgczUN2AMBnBL55IH+rifMrN?=
 =?iso-8859-1?Q?7DFcM7c/0lH8nMf7YRnsDdBWt7WhQ5whHOWTfWPWCKtEPgrLBvuuQmBaJB?=
 =?iso-8859-1?Q?wpKq53i+Ti2tPL8+CvgQtPFJo2JOHeEz7OmDtHLjK7JifjANZOlt038X2i?=
 =?iso-8859-1?Q?CKK2pHmvF9c7i+IQKoA4TjKmwKWlGp1EaKZsoeu/+CNxS/JT/1AwAXvmM3?=
 =?iso-8859-1?Q?M+TreCe9xDrdSQ82A+77lfMw5bP5FoQvzJGt6Hy6hA+EXHGXZ2RCk/3+M1?=
 =?iso-8859-1?Q?SN3lJWfxbtklDB9HwEQ2IyD9VrcfTcDySAehYmiQNtlc1OSP+162QpczM0?=
 =?iso-8859-1?Q?r5km1cP+H5Y4OSpCMH8zdpaiZNduJhjvZbX3PBh6rVdDhGLHwU+jcQYWiB?=
 =?iso-8859-1?Q?dpPyWFndUzxUY0RfDaI41ES5nGEzY4f3vjabHrGoA74p/fNNS/zGeNa3+m?=
 =?iso-8859-1?Q?qDx570KGCfYQoTLbsIf5Q9mGQi9Bz5i0pxnjwtPPIVWv7ENXP9P0eJwOCM?=
 =?iso-8859-1?Q?aiPZlmR0QA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b30fc1-a8f1-443d-92ae-08de63c65cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:14.5200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lA3D5OabP4giPzRQ63IoBgOugXvLwd3JUd86zMOE+Fo2mgNGc6/1DVyZZOBE7UkTUXmVPiem+skWIQWGKFqsQ3k/khG+QxTt4WnLawEZlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

Hi all,=0A=
=0A=
LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM=0A=
2.0 specification (see Figure 2):=0A=
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf=0A=
=0A=
LTPI provides a protocol and physical interface for tunneling various=0A=
low-speed signals between the Host Processor Module (HPM) and the=0A=
Satellite Controller Module (SCM). In Figure 2 of the specification,=0A=
the AST27x0 SoC (left) integrates two LTPI controllers, allowing it to=0A=
connect to up to two AST1700 boards. On the other side, the AST1700=0A=
consolidates HPM FPGA functions and multiple peripheral interfaces=0A=
(GPIO, UART, I2C, I3C, etc.) onto a single board.=0A=
=0A=
Because the AST1700 exposes additional I/O interfaces (GPIO, I2C, I3C,=0A=
and others), it acts as an I/O expander. Once connected over LTPI,=0A=
the AST27x0 can control additional downstream devices through this link.=0A=
=0A=
This patch series is based on the aspeed_next branch including the below=0A=
change.=0A=
Ref: https://patchwork.kernel.org/project/qemu-devel/patch/20260203020855.1=
642884-2-jamin_lin@aspeedtech.com/=0A=
=0A=
It introduces a basic LTPI controller model and wires it into the=0A=
AST27x0 SoC. The series also adds the AST1700-specific LTPI expander=0A=
device and incrementally connects common peripherals on the AST1700=0A=
model. For the I3C block, which may cause kernel crashes, its MMIO=0A=
region is modeled as an unimplemented device to reserve address space=0A=
and make the missing functionality explicit, ensuring stable guest=0A=
probing.=0A=
=0A=
In the official release images, the AST1700 functions are not included=0A=
by default. To test the AST1700-related functionality, please include=0A=
the following DTS files for probing:=0A=
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/=
boot/dts/aspeed/aspeed-ltpi0.dtsi=0A=
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/=
boot/dts/aspeed/aspeed-ltpi1.dtsi=0A=
=0A=
After including these DTS files in the BMC image, you can verify LTPI=0A=
functionality using the following scenarios:=0A=
=0A=
1. In U-Boot:=0A=
   Run the ltpi command to trigger the LTPI connection and display the=0A=
   current connection status.=0A=
2. In BMC Linux:=0A=
   Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by=0A=
   the AST1700.=0A=
=0A=
Any feedback or suggestions are appreciated!=0A=
=0A=
Kane=0A=
=0A=
---=0A=
=0A=
ChangeLog=0A=
---------=0A=
v7:=0A=
- update mail body encoding=0A=
=0A=
v6:=0A=
- Remove redundant [*]=0A=
- Fix checkpatch.pl errors=0A=
- Update the test script=0A=
=0A=
v5:=0A=
- Add functional test case for AST1700 I2C=0A=
- Corrected the From attribution=0A=
- Fixed incorrect DRAM setting for SPI and I2C controllers=0A=
- Refine code structure=0A=
=0A=
v4:=0A=
- Add missing Signed-off-by=0A=
- Fix checkpatch.pl warnings=0A=
- Refine code structure=0A=
- Enable AST1700 support only after all devices are ready=0A=
=0A=
v3:=0A=
- Add PWM model=0A=
- Integrate the SGPIO model=0A=
- Fix I2C test case failure=0A=
- Refine code structure=0A=
=0A=
v2:=0A=
- Separate the AST1700 model into a standalone implementation=0A=
- Refine the mechanism for assigning the AST1700 board number=0A=
=0A=
v1:=0A=
- Initial version=0A=
---=0A=
=0A=
C=E9dric Le Goater (1):=0A=
  hw/misc: Add basic Aspeed PWM model=0A=
=0A=
Kane-Chen-AS (21):=0A=
  hw/misc: Add LTPI controller=0A=
  hw/arm/aspeed: Attach LTPI controller to AST27X0 platform=0A=
  hw/arm/aspeed: Add AST1700 LTPI expander device model=0A=
  hw/arm/aspeed: Integrate AST1700 device into AST27X0=0A=
  hw/arm/aspeed: Integrate interrupt controller for AST1700=0A=
  hw/arm/aspeed: Attach LTPI controller to AST1700 model=0A=
  hw/arm/aspeed: Attach UART device to AST1700 model=0A=
  hw/arm/aspeed: Attach SRAM device to AST1700 model=0A=
  hw/arm/aspeed: Attach SPI device to AST1700 model=0A=
  hw/arm/aspeed: Attach ADC device to AST1700 model=0A=
  hw/arm/aspeed: Attach SCU device to AST1700 model=0A=
  hw/arm/aspeed: Attach GPIO device to AST1700 model=0A=
  hw/arm/aspeed: attach I2C device to AST1700 model=0A=
  hw/arm/aspeed: Attach WDT device to AST1700 model=0A=
  hw/arm/aspeed: Attach PWM device to AST1700 model=0A=
  hw/arm/aspeed: Attach SGPIOM device to AST1700 model=0A=
  hw/arm/aspeed: Model AST1700 I3C block as unimplemented device=0A=
  hw/arm/aspeed: Enable AST1700 IO expander support=0A=
  tests/functional/aarch64: Parameterize I2C bus ID in AST2700 test=0A=
  tests/functional/aarch64: Parameterize PCIe2 initialization in AST2700=0A=
  tests/functional/aarch64: Add I2C test for AST1700 IO expanders=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h               |  54 ++++=0A=
 include/hw/arm/aspeed_soc.h                   |  25 +-=0A=
 include/hw/intc/aspeed_intc.h                 |   2 +=0A=
 include/hw/misc/aspeed_ltpi.h                 |  33 +++=0A=
 include/hw/misc/aspeed_pwm.h                  |  30 ++=0A=
 hw/arm/aspeed_ast1700.c                       | 276 ++++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c                       | 167 ++++++++++-=0A=
 hw/intc/aspeed_intc.c                         |  60 ++++=0A=
 hw/misc/aspeed_ltpi.c                         | 193 ++++++++++++=0A=
 hw/misc/aspeed_pwm.c                          | 120 ++++++++=0A=
 hw/arm/meson.build                            |   1 +=0A=
 hw/misc/meson.build                           |   2 +=0A=
 hw/misc/trace-events                          |   4 +=0A=
 .../functional/aarch64/test_aspeed_ast2700.py |  65 +++--=0A=
 14 files changed, 995 insertions(+), 37 deletions(-)=0A=
 create mode 100644 include/hw/arm/aspeed_ast1700.h=0A=
 create mode 100644 include/hw/misc/aspeed_ltpi.h=0A=
 create mode 100644 include/hw/misc/aspeed_pwm.h=0A=
 create mode 100644 hw/arm/aspeed_ast1700.c=0A=
 create mode 100644 hw/misc/aspeed_ltpi.c=0A=
 create mode 100644 hw/misc/aspeed_pwm.c=0A=
=0A=
-- =0A=
2.43.0=0A=

