Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0184CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9B-0001xq-F7; Mon, 25 May 2026 00:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8h-0001jo-S7; Mon, 25 May 2026 00:42:07 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8f-0001Iv-Tp; Mon, 25 May 2026 00:42:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgU2DX0vRt2EraxV/+7cUUsT8z/+eXZqIczUn1Dcpm9SXITXEEfZzcRFvG2kCy9bdsG6jMUuTR6gOdZ3ZK9AYoXwxLaVqTvWdhn7CFubYpX6CC2xWDEXuLOObf5UKwcSw1Q8CoBRTVxr3Entk3vPpEmNtqklv7TXWpxL3GMeO9E86std1RfZfur5d+FvwpufP2m+QS8kGoprz7k1GKjISBAkhQk8TqkpWeqw/Mf5izLI4kjJY5Z7AokAw/TOoNHDFVZt9m+dQqGNDafv3g/NQKv0qJhym6w7gTwcP3+Ndfv0UtoN6lYkCszRsbhRmNE9PITO+oL+q2f6U3ZeuLrHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXASGfNiKoHt7yU72RDNDS1ZfsB2aiyEWcd2N5T2bXk=;
 b=Pq9Uml+rL9efigZnWWuqzPfj0QREVQD8K+VFgZgBSSjjjKQysyuYn3DxHsUOoVFQxu642uthTVr6k3nPho2ZxXTwxAcXktlaZdx4rTbXZhKM+QGzcvjr2Mg8ZXBWDz1CkZee3s4itMq7ji21NIa9cdMelWyLyP6XrB59f5V6HiBaFEzkI338NF7HdPUmUgQsaQaSWE38T9cVyJxz7N6JTSNO06oyHIx7snN02EnBBzjw1anIkyXlanNrBkxY4QPNq2uw7lSwb6BoA0AZpXJGmaJNv3aUtobFXn8qKDxZJkOJuf3SFn83Va7YtTuAAyh20/uP4phGL18VYPcfokYvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXASGfNiKoHt7yU72RDNDS1ZfsB2aiyEWcd2N5T2bXk=;
 b=hzmRJ1kyGV/5pOzdZXSM8Vo6s1y21B7sXav9x2IehmNAHOPkZGHAsJzicK7CpUaEhP0RiRm1Yj4XGTA6D3glNQescjA1qTh8xS69vk2CshGWqElOlP4ZQ+Rz28kawHXNMLLl57/L2OoItJXQiJJIkoQpA3DBHmkXrZek0CEy9UlFnwC9E7dR3VT8ar4EBOj1XP3tJlNN7TE9vjmVAY3eO5RpL9fcNWwCJAQ9V4LiQ4ArPpX4FSGFX8wGZepcL7hT14Hx5SRHNAT5Scv2W7qH/CfA08Wyv503R+Ix3EFmU10/qYQy1G+BtTUIjHE70NaO65SoTXfqVhS+kKc07MrVGw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:57 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:56 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 18/23] hw/watchdog/wdt_aspeed: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 18/23] hw/watchdog/wdt_aspeed: convert to use
 Resettable interface
Thread-Index: AQHc7ADRp75PPdeazEufRnlyP/6ryQ==
Date: Mon, 25 May 2026 04:41:56 +0000
Message-ID: <20260525044129.3133916-19-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5617:EE_
x-ms-office365-filtering-correlation-id: 0041daf3-e258-4ea6-4906-08deba17f3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: wGh6NuR4J9H5E7TCkCsTp5z4hwZ38nSckxXfeq0Hq6pN3g3T6IcGXiPTDcF0f874vxHEiNAF4lY++bQX7MRyuXK9PtE++wMzZp1kInxL17IvnNbZnMWm8FvFahKceNPUR18fNlebZv1P2ElRw1Bu8J7q3UuRb/YHlLmJJ/Xu6rQ47lxQpvMkgGr6PIv165LjL5RWrTQFVVzGevMg5hVi7PmmiOggzVtF5+h9NWvsccKc382t8DbMZmF76JWCT1lG4Njt7hlj7Dd/A5RWbcKSWD0ONN8vqunDE2QQfSEf/Zbb3J0jQ5JMayJugYx06Iq8qAlZREiUe0/8Wa/eha3JYwlAkv1YmwvZHhNFCj/1LMt3FcA+rlCZdwe16SMU+rKQHTZ2gMvdOLjdZL0Gvf2C+4vEZL9ZF/J2ZOIFB8LSuwbbasEHvPAKk8k7pPBSPQxaQ2DChpWxa2ApSjgxmZJOdpJQHuDOOcy8jBXcrR9+oejEdQw2ofo/cLDHOE/GnXQQzyvvRWISFTYLzho9talhQlV/6WuY+nGTwcVwEQgLdpM0wcVOhsepKEbJRQuLkR6mNiT8hOMGQA2pIMornbyZprm0H2S/1ogsKPDBKdBcpGTkVVXjcaEi0h+ytYBMTKp1m4F6s+Oj0VnqhSIXFO7tH/BPYhysOylMY29KkOh6eLKWAeycxKzyUKVIzQPZPi+E1jriUsvQ7bmaGClPFRNqi0uD6Ujghc3IHPt3H8InvmC/Rqam/zzHdOOIa/GNQkQOOsPz+cxa3aqu3PeK1bqS+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X4vhycMzbOZ8DvG6LsOWuNhaG+Q8H3bLGYqMm4m6vfUJW/WVS+7vSztjvV?=
 =?iso-8859-1?Q?THcHHFMgO1fmQcaWXYm5X18G6Pm8FSpSkkmooQVU/jaiekYJv8PsNecrUX?=
 =?iso-8859-1?Q?sIztKGYZK9V923Ot95nmtg7RdamsBaoqO4gctBwytE/X9V3FyHVrQRiJ5i?=
 =?iso-8859-1?Q?HHUc7grX4MXQSTqgMqyckPJtQLNu78aiRU5fZ1ceKK1WUhcjJ4HNGNI7ov?=
 =?iso-8859-1?Q?WFBkM29VeQAsxtt1/gyXw0mATtxkT2U1sIa4R4LYGAT++OqEc155d+rtRD?=
 =?iso-8859-1?Q?43tPj6+HxD0UBB0UqU26l4tA5lZcK3nAwzOc/DwSSyzCM40fGejHyJf7OK?=
 =?iso-8859-1?Q?TKueHXbZzGTrWYaZqQk+8WiXvCd0hl9tMaymk+yRkMFsJGIMHGeTY9BJWu?=
 =?iso-8859-1?Q?kZSdyfPZ+Dfktff9wskpWfvmKJR53aJRn6gYE3AqIS2sn6nhi9xoOTqVKr?=
 =?iso-8859-1?Q?8TDw2zEPNZifTr5YHuWC0U7CtZ7+4QO0LgCFkEeBwf7GM0MOqJJFYQQEdG?=
 =?iso-8859-1?Q?dxfRGDoZmCYzrBLZZiNSExnzF19NNb6EpR/pIxot6z9Xgzp76pAsY4iv8m?=
 =?iso-8859-1?Q?U90/B6gYKGO9W3aXT6mrHV1K+XGKwOb8FuUeHKi3T1Ou6UMpM2d+AdSgM9?=
 =?iso-8859-1?Q?QEI3Rje59vr0eF1zi7f4R5I7vyBmA1QdDizMtMYb4kAKqoPpVVvlW5t7Is?=
 =?iso-8859-1?Q?pv0BMhsiBu80uoz2WbrR2qxtn3dXerd1QW52JsSeuNjSg3TDmKDrEFFahI?=
 =?iso-8859-1?Q?80rw1QJMbDcIc/2GrOFEh0QXwtMKjoxaRQ4AUcbRz5XGvss9S/1sngoc32?=
 =?iso-8859-1?Q?Ctg7EBRIorf8rpPtvovk/CRJwi2QJgL4gFxqAuJ+kOA62fhp9/61MnhBs6?=
 =?iso-8859-1?Q?5IXuERioj5ljDtFrMfUKqHHoPZRXGmocaAc88fog+i8rjB0UkGaHWeD95f?=
 =?iso-8859-1?Q?sjilMDsbJ1Od2raXTo/YqYCyags9ZF1IL58FYKK2xdp8heXnm8zLTq115y?=
 =?iso-8859-1?Q?PK6ZNyLh8BOezd4j/pT8zUmMCBCZav+2HpFTDIzzPZm+9oHQWPmZaR2MCx?=
 =?iso-8859-1?Q?+nNGSa1YF91c7YMrJXZ60xHDL7Qp9sUXr1oniYd8lM0kFl0LDXigPek3Ea?=
 =?iso-8859-1?Q?ThfoMAlBUUCmP8A2GWCmx5m+PcfpnUi5BmNnELIq/nvKuf0tL89r2LBnoC?=
 =?iso-8859-1?Q?Ce1WgBeptWvDLwqfxz8Myo7hwV9PdBd2nMBlzBV4+ESqGSAWYykMLcG7/9?=
 =?iso-8859-1?Q?DYpVtLkeuGRf10j8zyh9bo1kiOaR0DXQOE6vCLAcnqE9KAEFG+vyQhdRSO?=
 =?iso-8859-1?Q?POjDM2/+hxBLDeHbDGT2xYVZRwthlJzI5ZdZt0QhY3ouzfC2CK9sZDqisU?=
 =?iso-8859-1?Q?cEfuRM2bSCc3wCNuPCFEQqv31U0LU2BKPNJUDHElZBXxmYbDDDBEWo7z0+?=
 =?iso-8859-1?Q?NLzHhC6aa0piSFS4JbWfx/TNeiYO6y0D9OC2yVvo00W7zR6OT1S2rb922w?=
 =?iso-8859-1?Q?R7qt+LcDOdCBWKxOpGpkZOIqC8O9wX5bdSSFHKclq8EhFuhR1AiB+uy40R?=
 =?iso-8859-1?Q?+bR8UQw8PFBdRvIADc0ZJSyiRmhiuvnXmZJ7igmEFFsaY/DmCcn3Eat5IM?=
 =?iso-8859-1?Q?yEJ+htjQHpbllpt+2SgicTk9goJg0681af/mC9bzk4EnNC++6RKSAZTudQ?=
 =?iso-8859-1?Q?RbQUxJsjtSRU2KRlenMIfo/0/AKezgpBvEFFQuzQHtQ+q5a2Tzz4B4ugHg?=
 =?iso-8859-1?Q?CwlalJ3N6aVozVzeDPIP6Zo+YXNzp5BdEfxQhfVh+Qq7mx12tBj3L7OQyn?=
 =?iso-8859-1?Q?dGqQsd2htg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j935PCyKw9r68gWYhc9eh7Hd/KBCW8hnFB39x9uPHn8HgcW02cegryElS5s3PTM0ApC/ifU76HhbJxwIV8iFUT/TzyDtjYsTCEbKv47g3BlgC3ZHJdDUWcluBD0hQRxvK1z0M4Pn7Z3rmmmPIV6z4dyYOL7rPmQ7DTf6WRkVnllLUm+TyI+Z/2D54E4EEW/GJujmVKVrZ0LTLoTTG48QZLunJe3q3ftHIiW2np6KH9AnQ8NHSngbP03FesH6j239+MXADThhMdU8hGDxdS3M1WFvHTLDfCihCVoU6BR1q0KsTG2i8GFXM+rUwVId9SfsNPxVe32O31hZyuVcwgOK8A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0041daf3-e258-4ea6-4906-08deba17f3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:56.8775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwipsp+rXhHZ/AT5Zc5ifaxJ3pIljn8wRtmgbwK28YEQsFsqo4OiDzeag2Xm+CZ7VB8CHP+nycUj+KRjGRO2D4qSyzPtpzkgCIHCyA1MKwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5617
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/watchdog/wdt_aspeed.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c=0A=
index 26506f3c33..ae411593c5 100644=0A=
--- a/hw/watchdog/wdt_aspeed.c=0A=
+++ b/hw/watchdog/wdt_aspeed.c=0A=
@@ -247,9 +247,9 @@ static const MemoryRegionOps aspeed_wdt_ops =3D {=0A=
     .valid.unaligned =3D false,=0A=
 };=0A=
 =0A=
-static void aspeed_wdt_reset(DeviceState *dev)=0A=
+static void aspeed_wdt_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedWDTState *s =3D ASPEED_WDT(dev);=0A=
+    AspeedWDTState *s =3D ASPEED_WDT(obj);=0A=
     AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(s);=0A=
 =0A=
     s->regs[WDT_STATUS] =3D awc->default_status;=0A=
@@ -310,10 +310,11 @@ static const Property aspeed_wdt_properties[] =3D {=
=0A=
 static void aspeed_wdt_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED Watchdog Controller";=0A=
     dc->realize =3D aspeed_wdt_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_wdt_reset);=0A=
+    rc->phases.hold =3D aspeed_wdt_reset_hold;=0A=
     set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);=0A=
     dc->vmsd =3D &vmstate_aspeed_wdt;=0A=
     device_class_set_props(dc, aspeed_wdt_properties);=0A=
-- =0A=
2.43.0=0A=

