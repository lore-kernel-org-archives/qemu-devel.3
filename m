Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF8CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnU-0003kT-Hu; Wed, 03 Jun 2026 00:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcml-0003Vm-Lv; Wed, 03 Jun 2026 00:00:56 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmj-0002TF-OJ; Wed, 03 Jun 2026 00:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAljzf+ovqIBg/aMgrIKAXGvoDerooS/cbxaFBqkcRehAGsxE+L8EiTSYn07PrZuv+8iwp5xTYD3g0AF+kjSzn20HndjHi1wMpgXvrImDmNjLPeJN4R/sKaCB66ACuM8i7Q/htMbq9e26cd0sBGv8w6w7SApeIrBwZ++rXz8/qWlgDu/NuEW7Bhym7pl0X7apix30sOht1bU8xdWue8UcBwcLeHrKQqAy1tYmeUVkxSzXj+V/akYgDTF008mfE5vEAge8hBhJqwyPh3mVLm1hbSoUqCul3ws3cjOghXJhPOd2AgXJZQWz0RO2HUcuedU3NSn9Z0deEIjYIzXRrqTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sQFWHVUXY18uniuXWWtKF9n764bQm6UVtavQBNUvvw=;
 b=auBw4zkaZeYWosbr1qeByU1PrePTG8uWQWwDQHSikRoPpCuaxxbzzNtwh0e0FKHKoDVbzRIf27ynn2jcdkWZ0BPU41/6tcUzDryDRtuMwenKR8dZyXvI6brFBY9XoqXmXuzNIpMi5Ig+NC1g1xLFu0DAs8mCIYf4VoW1uoPGp8ZFiSOYh4woaIyKZYL214CNVX83sn/czDncxLfWp+UsoF/t841kgIgDyhZxsn3jBGt1miPFg+KplYz83p0nizu96Yf7zfejJqUibCk/P4QYuqbKe25cuM/ygdMZfPv9uNtGPTyONhYW7uySToBE6LyH+jFTH+HuppeqMZUKSzVIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sQFWHVUXY18uniuXWWtKF9n764bQm6UVtavQBNUvvw=;
 b=OxTo0Jrt4/ld7gneL8zaISqIgKR9u84iZHzSfKA+BbdUZC2/qrqDf2WYzTSqENIvPGSIR4ZGjQU8bTKQZ79V1lt2k54Bndw5/ovjAzSkEIOEi/Sfer64SRw8wDeQMMJhJWfQHcW6QN4FP2t6ZKMW6SSCWkeO6VH3NJ70c7DYThuovkBjRhTxtBJ5eNwieSVhY9TPpsz+6UdmiTQDHA1BpZv1ky+ftIfV0AgQ0HGVGMGVtid4eYv4wVcgoZUuH5wWZSGnFVW0xwqDwVS8mDUUqrLQsqxrEHuVamKU8FoGxFc6LIrkEf35DuyjtegF5MjSXcecnwYcR4SUgh79mGrvrg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6623.apcprd06.prod.outlook.com (2603:1096:820:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models
Thread-Topic: [PATCH v3 10/10] hw/arm/aspeed_ast1040: Reuse AST2700 watchdog
 models
Thread-Index: AQHc8w2K6kz+QXIADkeBNNhItaAviA==
Date: Wed, 3 Jun 2026 04:00:40 +0000
Message-ID: <20260603040027.938816-11-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6623:EE_
x-ms-office365-filtering-correlation-id: dec1e443-2d93-4651-f6f3-08dec124ad5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 7ZERHbSGhKlXif85prIHUGc9AuwcMk427S9wP/9GNPk/Yx5blY+vut2633UCSNzWdGaOUa8ayaYoaPLKuYAynymcKkAXuO9X2VsKjSuCDlUfEnrtEz8gxjimzsZJWjfr4uU8pwwVw7hgccK/4oUMHcWn/yEgTcz4A7/Dm5ozrl9YGNs3GPMb2h2KbiNzLmIYCPHOJRr7sH+iXZeY+WzCfgG46ZnrxjMuy1o0fQnko9ZvO6hAztg5GGMc9YjEC3mVIV7eKwRXskgNDClPaaaCzCgI9bZGytuTkO0gkL2f6rPLaAmXr7oZJt9wUtPc/MT+Y/dW7k0pz6wIJw5ystkMovmn0Lm0dD1d3XVyfDhDkropjcxJ39pnbTMGdPBIcjROTXEWKwB7rGlEQr9I/RA5Jh4FAPXZZyAdnQ8kl/RT6NvTm+jEKS/Cx1d05f0KxDsrgagEs5Xq4smkmy4rplGc97ZnlGYW4q/tDhENKgDhDFF0BgKfN3liD+YUj/wJZm5CAeMX7NRbOY6GYbEtCsk0YjYAwNICjHSwEgSeJUSqQOZQy1Q5F8OcBWsItIvsJK84FExSNzbFh5mPtRw0OjhrGJiF2RlDpUrogYVltSxuLFBjDF/o4mrM4bFMuFXknqkgvaI8VYCvWGsUPPS/MBj6Yw/cEIp16Fg7+VXLqj3nDJ06Sf9ppghakQHxZ7+ufrAgLFMm2r0N2XH67Rdf1YlZXEsDzfoDlc/N04r4Zs8qUwAb2+Lp7VHJ5Youc4HwVd/T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/NmfV48HbUgOebBReZ5VGQmg6VlHADPxeDuSl/0qLwV3DD1CsaAkW6q+yH?=
 =?iso-8859-1?Q?7Ui2LRBYCJrdOF7fO/nvf3ZQVx5KsvxsuRo7ZZXkxCJbVMQwWAuzXnSFrT?=
 =?iso-8859-1?Q?jMHnwd+YtPOrLOLfCjIHYkuPXc2Ee1RRRoo2Mlm/HlTwZX3/D8DMWpoR8V?=
 =?iso-8859-1?Q?CXOa1M6bnNSrp2MxcuVZG9kor2MMgzwUamwxIHvTizqun7LIOst429zDuJ?=
 =?iso-8859-1?Q?QQDbWDF6ephK+FKl4eZvCLnO+tnmUeysxqJ6yzIBhnKKi+0DCnxGiujo4U?=
 =?iso-8859-1?Q?T1J/1N5XP3YkB1z1HclZ8ui2+ecGwY+auNeMhTG8VxnlSdzobVyksJXo65?=
 =?iso-8859-1?Q?Au0NENCOyHfqCxq5nyzWuyZToN/lFQoadYkNJGION50fMNmos7mz/ctE6n?=
 =?iso-8859-1?Q?jh5qnty81l81si9Tbnj/o/9FlEIzoC6UHVupEiTK+Anvf8iB6G8q961G/u?=
 =?iso-8859-1?Q?JJ31rroGbPXNVJki4NoXz6uNHiOhI9Ubk8y/L9dMPyND8k6GDT/qT3JM9V?=
 =?iso-8859-1?Q?xsIROl+B0Hv2qw2hFIqlNaNFta8uVB/IryZcygOx7oYiVpKmPoC1LOA5ZE?=
 =?iso-8859-1?Q?w2ncOyzAWtYADhhPGYrZDFCZWtk9/dTMjdL+j+xQLC03b3H73nPgcWnQSU?=
 =?iso-8859-1?Q?6SOqAzlD+g0zgvUAL7/0oHsM0a9gFKSnAlrC5Peab64zMHuRqsDM9/3YIh?=
 =?iso-8859-1?Q?TEI+X+2Oyp5mlzcjTB9Op/gCq8ww5NzapNwadoVhhZNJ7ZXck0FnK2mfSp?=
 =?iso-8859-1?Q?UR628QhUF7u372itNwtsQbV5gQzB+DyunHDEK/OIcmXSpVY7901ELmfQH3?=
 =?iso-8859-1?Q?EfEZzJPiDD2bcXf4oD/TBO1CNGyTOpKscTg7/7QYSLCVg0C2dKJjFFs+Yz?=
 =?iso-8859-1?Q?mh8cJdz/7Xnpb2SXi6/KL4fScCEvqUmoZ1SF93aYxAaI8JYcMWHdiuM2Bv?=
 =?iso-8859-1?Q?m2vTEINyZaovlKnWvi1aKmMkPK8955hxUgZ0CFaPbL1W9t6WX4pKqU1pg6?=
 =?iso-8859-1?Q?Yp+/cSNNSQkhDSzWxAeE5iLBSMoOXeBCExYyTgcsqE/5WdhnnICL09ny+k?=
 =?iso-8859-1?Q?meD7+Kfj1nVLaMeCmR88sp3D5LppY59a4Y083S0EDwOypldpbGSkN2FNbn?=
 =?iso-8859-1?Q?LYjO/aJ/MFqrKatHKOoYuPph1/9Or3uQ9mpsAzwZpbf5ktJMEu4KKx3Ue+?=
 =?iso-8859-1?Q?vVjrLCCZJ3RjMXZ0ZG9f94b+nluS6FXqgc0OtNbbyqBBdDbAGjYXGA1CmG?=
 =?iso-8859-1?Q?M0BVAwEKDmrVOUq61YMD0CY2evWu2uAwNayHGmRXjcOFDAIPcFaORpU3YJ?=
 =?iso-8859-1?Q?qJHoX5Ql48V5JIIzc95H+UIs/p8F9c12mPl/2ihR56RQBlo9sNGi2KeP2q?=
 =?iso-8859-1?Q?42f5kgK3LMGQdaLUTYFE29aFY7h0SWG/UxtUD+WwqXuBnI6lF8i22A/B1x?=
 =?iso-8859-1?Q?pjPF5kpUKmI+d+Fg/IpJpUpUp1d7Obyjkzy6bqv4XMik/LeKq47CVQ9n4J?=
 =?iso-8859-1?Q?KlpTDRjjGN0i2mAHQJSibsTjpyWMh10nl1XyR96NtjVCU+MMbKhXWjF0aD?=
 =?iso-8859-1?Q?x8kPlvYgvhrVf39PjP4PCBFiZK4TKxVkdCyzZgNLwErWwWJx4xlKC6kxzu?=
 =?iso-8859-1?Q?ArjVYr/Qa0KTWXqeh45Ek/Iw5k1iXN6ffENKGcyr3e5WTDg0hembeZJIOv?=
 =?iso-8859-1?Q?f1y5mTWLUEoM8Q8aAPseLEUijyJXUyjn2tnLFUhbVknLkEQFOpSzSaK8hp?=
 =?iso-8859-1?Q?9Dnz/z2QsTXAx14hvVVlnT1QIcQuJ34D3raWedewRy4aauRQiqRrFN4+8u?=
 =?iso-8859-1?Q?Nv5csw5RUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: geD4eUqzzAoqB1Gl+q4PtE3I+d0zbGDNy5K14PXfNFqgIboy+8I7KTrf6J1kxekHvFSNzXUZTAAC0xUpBsis6xoZViC+p9Rl0fOLcaOggtJNgjo423WupiA3MK++s2o7wvUh9F94LA5Uon6u3s+UQpyieRFtmzDhwxxX0/6HtdzmrARCXJHoYdgO1W/Yna+xF6jpwKOTyJub/Q1yzQ/a6C3nxkrzfo8t8jUD1z97oH6BIHWRbBF8IPvLr5X5ILtATPHI3ZSBpgPsxMEibv+ccbMx/Y2QMHi8ZMJAnTIoIswl8cTjMqsSkMIaVTaurkt5P6bN/PKVjOsiuYHM4OZ0zg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec1e443-2d93-4651-f6f3-08dec124ad5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:40.4374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz3lvRQ6mf7GzPY0o6JZJm5zIEUvP2JYeUV/8fPTs/4W8EeyrD5iPhLsD65gZCT68uTSI6+ivH6Ab8dRU0UZevQxPZp8fkaqkZ2uwMpay3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6623
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

Instantiate and realize the watchdog models for the AST1040 SoC.=0A=
=0A=
The AST1040 watchdog controller is compatible with the AST2700 watchdog=0A=
controller, so reuse the existing AST2700 watchdog model.=0A=
=0A=
Configure the AST1040 SoC with 8 watchdog instances and map them to=0A=
their corresponding MMIO regions. The first watchdog controller (WDT0) is=
=0A=
located at 0x74c37000, with subsequent watchdogs placed according to the=0A=
controller register space size.=0A=
=0A=
Each watchdog is linked to the SCU device before realization to provide the=
=0A=
required reset and system control interactions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 6d1cb9b102..57ffc0807a 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -119,6 +119,11 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
     object_initialize_child(obj, "i2c", &s->i2c, TYPE_ASPEED_1040_I2C);=0A=
 =0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        object_initialize_child(obj, "wdt[*]", &s->wdt[i],=0A=
+                                "aspeed.wdt-ast2700");=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -249,6 +254,19 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);=0A=
     }=0A=
 =0A=
+    /* Watch dog */=0A=
+    for (i =3D 0; i < sc->wdts_num; i++) {=0A=
+        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
+        hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
+=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+                                 &error_abort);=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -290,6 +308,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
     sc->sgpio_num       =3D 2;=0A=
+    sc->wdts_num        =3D 8;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

