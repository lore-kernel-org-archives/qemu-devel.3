Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA6606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=LzwcPD4e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSi-0004RJ-P5; Tue, 27 Oct 2026 22:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSf-0004PV-00; Tue, 27 Oct 2026 22:32:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSc-00082E-Jc; Tue, 27 Oct 2026 22:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1FQQ8Rm9oZp3hTRNg/EidoWXYMhe9mt6Qhkcm8V966VRNhFDovM/pIsHhjRctcgihjyrGAH+onkqWb0lhDrJwra9Mn+Q4CxpOpA8LhWpul9+Reyj32Vp3N5qn8QDAFwZw3FgfPvHYAZi+0L1Jt8uSJQ6h5ioKRmFJ2/X4jnR4Aofza5577/XcL3xUldXWdEKEBy0Criec+odig7gauxAaMNx/YuvX6WO+CAHEuXQalmlz0yS1TXKibOoEAPtkU2V9R434BCuhSrwrre24aHhqND4eAkD5Vzrsmv1GYJj/fNdQ4XK1shuC4ez9zTZJUP9xKzSLFkzZEofv3ccvkn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3OOT6xCZKoetIma1JWV2AUHrG70GL0t9ubyILX+GiA=;
 b=HxpO2klDONOaEyB2CwdC3bOEXFIC3mtVd9MsaAs4Fv+2YZgrjAcLAHgStmrXj5JNqbC4hUtsBCujUwl9VXNzdQCY382EFgNL06qHow50qiskse8YC/ow2Sja+MTLJzfoj3Iw3fgTxKRFUCi0OPOm6vflxDQ4bBOrijydiD1JCMzzVdxCzPUehNMW8j9v94C/QTD8DdeXGhrvGLX2nnfsp8noOCbGNyQcbQzGhhK/m1CQIcZNyLbVXQ2WpHevh54T9kvCUia/UVBwGIER4sBNdX+F2g5RqPNxqACptS7idXcQZ2J3/j9mLvgagrg/F8wRv1Sy/D+nfo79M06K2m3agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3OOT6xCZKoetIma1JWV2AUHrG70GL0t9ubyILX+GiA=;
 b=LzwcPD4eo/n/h/zf6mlLzjA/be1CE1QI6bhaZOG5WUjJnQpN2EGiAAVLtf173/HloaZpmiLhrU2lDa4SNbp0pSxv7VTqhE6mxw8bWmQ8/TIb5zBFI3yi2zh7R0wGMaMlwlMT/UNCAVC7ajTknV2/ornKKEjiLNUlqc/vbIvR+zmUR7smUWBjTRsBEPA3FOkStEvjDRynPqQAsV6itmSWa4ervXln0hS+5R225Qhv6cqSraIvpqfexw74lmfAeXfQbCzYXeToLbhSfrwFxi6CLVl0ccn/xHVqsDUaKZA/8OmOuy88rixDimJ/RINKr2AFyEdY574CarlQ95NWgcPjQQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:01 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 06/13] hw/arm/aspeed_ast1040: Add FMC and SPI controllers
Thread-Topic: [PATCH v2 06/13] hw/arm/aspeed_ast1040: Add FMC and SPI
 controllers
Thread-Index: AQHdZoSCEPa4lIlnskiQGaMjmyujHQ==
Date: Wed, 28 Oct 2026 02:32:00 +0000
Message-ID: <20261028023154.48395-7-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 3c070eee-212f-45a4-dc1b-08df349ba577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261026121527099003|261021121427099003|10067099003|261009221227099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: 7Pkdmy1YtXrSDE69rKLrhfuygNG2x3B1jhj4fkF+iF1WpDQzIC3izId0Gh4Rpc0pgy+vY7ZPmemZ9NMVowZk/yuVtfp/zp/4luNaQ3n8O1YaMFKfJTXsi6cL29tOWkuTlCruy4kGoYSi7p9WbDzRTpFYy6XRl5FirXCtv0ZIm/zTOj6pSuAGqJxSqq78PxF/d53smZlLGlcYFImgY8ugf5MWuKjQ05ClubfSqTWwhJjqmG6qw0nyRuvrJpUFg3/0V55K7RIJHMZG0goxEgv4GOvT+JxbicKEV5rOOq0zvOildYvEglnKDxkLoYT1kaApbKqibN257+pSiP24eSAPqYAqPgOrBe7OqsXJ8n4sqsQK59kGDiIsXTKwe8hbWZSJ47hSeSQnK3Kg09q7svcI6PZE9XtEn2PN8ABCQsZCrDHesvmcCvDkfLaOx28cm+ChUy2HvVePBDiRN4QA+CKfusf7ayxd/dKVqP3cXcuQwtIkQ69sXc7Yn7HzwDZfyJdE8DSxneX3NnqjtJO1Q+9PLLUfnMNSWj51wLSzl3Mu9T2dQ7uPBcTHG1pd0ZQzNBxIc9SBtjncou0tTHTOvzZB0XKH5D86VR3JWZAGY6aGiTrJBW+B8x2N+L+h4tu+/wNFmSJZicZUMi7RkTWr8EOxdNomwfnkHjDgZDF7d3/CVsYSQyglF5hfTMgJXnpFcsYMQJBumDh50tOTtruVLtDyTaxB5Uf+yyaYeKwsQQly6YQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261009221227099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VTUDTNJAk5l0UDKdCNKMtYISoKRuMZellmdD229mkQbnrTMt71owd+jQC5?=
 =?iso-8859-1?Q?Jss/H1+0on0ysGAhWUOxNT4p4qf9ozf8YgLRM4Yc3Lp69X3CiT+fm7tdVN?=
 =?iso-8859-1?Q?HjSARjAEAOnOsTVmBc5IO0i1FzkMtBA5EIwtwBLurcc8igeKiw/BsVIRIE?=
 =?iso-8859-1?Q?pM9S1qqdlmc8zRcvmuqbEYF4yX2Dn0WxEM3vW4YZnmZb3ntzUlZt9NHNUi?=
 =?iso-8859-1?Q?AApt/PWbCvH8ZLZeWlJoSAXBMkLqKnsqJCPcz9PYaIbTcZRvdp5p2k066w?=
 =?iso-8859-1?Q?7tSoWkS2xVjWT/EcSl0Y5c1gpGft9crDvJkIkOnVZMo+OOKplEgyeycwfC?=
 =?iso-8859-1?Q?gzIypTrhkA27Oeb92IZfxOcPirDBcCbDyLVdlObv/EWIpBEJNj/co0Y2cA?=
 =?iso-8859-1?Q?tFbgVt/mQtuM6iZTdRqs1YetV96VTYPb/AasFfI7IGKPZU54e8Ljom6VL5?=
 =?iso-8859-1?Q?4ZRB8L9c4M9Chd/HBm8PehdwwXauDr6Qy/mWtpacmIM1EBqgk5UtcpWh72?=
 =?iso-8859-1?Q?H42UBNDIdtm/SzDD17PI4qjkoLH1GlZ8biQGqx2fqpasfabf6SGVr1zw1O?=
 =?iso-8859-1?Q?iIjCbrS6FSE1ummDAEh0FOxK2oP+96MMTUWjHtImrepQW92id8If5gIJ4C?=
 =?iso-8859-1?Q?ECqWjs399Y8Ft3vj4rljAQsANlChSrUa04g2ncQqeKl2BwtXAy6gjHHhyl?=
 =?iso-8859-1?Q?h+KvT0Fd4F7DqwdXQD7pv0HRRPcxjunGkAIJi8K3+++pRxreT0luI22fmz?=
 =?iso-8859-1?Q?8f8Aj7maotVl2v54OmJW/jWnSDj3jK+EAMw09JDGFFv7OkglME3/pLPos5?=
 =?iso-8859-1?Q?cAC11d7JCm+UL6kyoijqZRZv2hE40SyIupPKZv5rVNxTLjVYPcbT3Ya6nY?=
 =?iso-8859-1?Q?+WjrySBQzqfTMW3B+Se4APHmCsF3var+auk7P0FHok7WaNPnXP7wg9ad8i?=
 =?iso-8859-1?Q?Pr3gGyVMpEW8O3sXzp1QkJPdyQJnhRjBIOKbArfhc3H0wknm57MG2+dsmq?=
 =?iso-8859-1?Q?gtdhIizz0y0laPtmgyBg0S1naUExw4h5Z+L4miDDdDXxOK/i4rBf/9CC7H?=
 =?iso-8859-1?Q?RuVw++gd1r8mgNGv4/RQCR0UNiJLBevgd6W/jwWIdHdSGo+w21coOL6DTS?=
 =?iso-8859-1?Q?0SmUpvmhHccTPqs0ffa2/FWygPuULRrC+xlD6hvCHgz7RgCO+tGZugsBV/?=
 =?iso-8859-1?Q?aSzas+EZh2n9zsesbGbroxKgGcKojbwneRAhXQgdrAwgtOgZI1WUB1IAGD?=
 =?iso-8859-1?Q?ELWD7krKIEfK6xHALKq8FSLoiN3VWK4t8WoVQKK2V6V1/ZQc06C3aH1MKA?=
 =?iso-8859-1?Q?35WFz94jSb/mDZFi9aPC89ubY3I+aOg1ACBcWSs4Tw9iDGXklJT7KTiFZH?=
 =?iso-8859-1?Q?4+rw3kieE9MXBopwrKcXfDnhT06RhJObHMJHeLYOnRBn53fTAPR0qf2slk?=
 =?iso-8859-1?Q?sFFChM2sex228fKSZnowt7WS1n0Z3KH4Ako/40R8fGaiPFqWJdK21N5gX7?=
 =?iso-8859-1?Q?avVGMIfxe0DDqFRtIQTkKp2c1VEskdWgSPvsu1LqlyXZaGLRlEhjJnVVzw?=
 =?iso-8859-1?Q?PQkUcJMjH7rM/CVoofTS1Hvp4ezmuUUIkS/d/q8RfZNfS8fzaxes41JjK8?=
 =?iso-8859-1?Q?iViBeN2Yzyb/c0EFrZZb07dKpwZvMzTE7sVqj3fgfYgLT790f06BOmZ9Vu?=
 =?iso-8859-1?Q?s95dg1SDS4Z0FlknKmv+Kf3qDCpix6W0IeUeuDH1Y/E7lkuL/VEDy4aot2?=
 =?iso-8859-1?Q?aOoYFBk+t5UQgAOM68vqugM4qaI6kCelhzda8Ge4Or1LsyBGRYlVmTPZwP?=
 =?iso-8859-1?Q?1M/ILC1eAw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c070eee-212f-45a4-dc1b-08df349ba577
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:01.0098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0lZANDVHPCxhJ+PbotCFxdPZZPqoNPrzixmYcKkzIV+mhOY/5AuOHie0t1kT7vB3BfRMAOcpY0lGGDUvkXpvfj9ktxmTqFIrTVdM7LQAas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the FMC, SPI0 and SPI1 controllers to the AST1040 SoC. Map their=0A=
register and flash memory regions, connect their interrupts, and link=0A=
the DMA DRAM region to internal Hyper RAM.=0A=
=0A=
The AST1040 supports two SPI controllers, SPI0 and SPI1.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 38 ++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 38 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 0b078f10c4..6e3b6900e0 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -103,7 +103,9 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
     AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    char typename[64];=0A=
     int i;=0A=
+=0A=
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
 =0A=
     s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
@@ -132,6 +134,13 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "wdt[*]", &s->wdt[i],=0A=
                                 "aspeed.wdt-ast2700");=0A=
     }=0A=
+=0A=
+    object_initialize_child(obj, "fmc", &s->fmc, "aspeed.fmc-ast1040");=0A=
+=0A=
+    for (i =3D 0; i < sc->spis_num; i++) {=0A=
+        snprintf(typename, sizeof(typename), "aspeed.spi%d-ast1040", i);=
=0A=
+        object_initialize_child(obj, "spi[*]", &s->spi[i], typename);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
@@ -268,6 +277,34 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
     }=0A=
 =0A=
+    /* FMC, The number of CS is set at the board level */=0A=
+    object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram[1]),=
=0A=
+            &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_FMC]);=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,=0A=
+                    ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_FMC));=0A=
+=0A=
+    /* SPI */=0A=
+    for (i =3D 0; i < sc->spis_num; i++) {=0A=
+        object_property_set_link(OBJECT(&s->spi[i]), "dram",=0A=
+                                 OBJECT(&s->sram[1]), &error_abort);=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,=0A=
+                        sc->memmap[ASPEED_DEV_SPI0 + i]);=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,=0A=
+                        ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_bas=
e);=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,=0A=
+                           aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SPI0 +=
 i));=0A=
+    }=0A=
+=0A=
     /* Unimplemented devices */=0A=
     create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
@@ -292,6 +329,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->uarts_num       =3D 13;=0A=
     sc->sgpio_num       =3D 2;=0A=
     sc->wdts_num        =3D 8;=0A=
+    sc->spis_num        =3D 2;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.53.0=0A=

