Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55E9CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHET2-00026E-5T; Thu, 15 Oct 2026 01:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESc-0001p4-Qi; Thu, 15 Oct 2026 01:57:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESb-0003Dt-71; Thu, 15 Oct 2026 01:57:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhivegv1cVxsmyNnXeWxqqCu9qT1r0C0jm4azLgYGJreXN35sQbSibCF8Tk76NEApreABLv2lOypxhMjcpsGAhHt6rIHcw0ESCTfbNbTQh33sqgg84pbx/UR5A0R4KLFEBMjY398YT0BJyp+8Acg1EwuIn8oS6/BoLqohOR+GsA7AXNeWtfXrjJ65Uy2mRCzLcpwt9vtonnnx+F40Gkmlx4ywRVQfClIElypi2G8jPxM1t13Re1kOIPFHqbhEXK0xsYViWsv36eAMCSOmkwg/uw0OZWp3lCLr81u2H5cWxNwkghrKalzOWLzog6QiskRxKijrhTdDXk5dadPVyKGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3OOT6xCZKoetIma1JWV2AUHrG70GL0t9ubyILX+GiA=;
 b=j1SnL/1A+dhOKAdq4QshmzYX9/igEnSV05yWj3d1d7gJwu1nvoVNg5l+Zi+PQsrydKx3sv+tei0xq1d4N4ZIdQKs8/GhzMIERK+Q0jJFuWCNaLw5IhzryvKKZT2ag+n3bcOnkatuj4SKCL8iWupDEBZLEB3Mu1WkMQlK7gHFE5GSgE8A+lYfgrYKnpyrXrMke2cGI90PCyNtKPuSc527Amqla5IpUyw2Gm59aL5nTchsJD49KZo/sJV0mXxYtod+jI1RvJ227AvflQD/BO/Sg2o7CYZcXL1wqExKcAFXnMGFINa94zw9ZrQvmZimQa32Q3W+Kr99RIib9edmC1c+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3OOT6xCZKoetIma1JWV2AUHrG70GL0t9ubyILX+GiA=;
 b=IZ3W9Ia+jimB1AuzUiNvdS2K1SztRPwKbtz23pFjytxOn1awE/ZV1znMExPRRBNh1BHW6yk0QdB6LtcsAUlq8uSRqmsAQrYdDgj4Evqp3WT8K50rERhV0fbpgeNkS39LXU1f7YB0d9sKydaD4b1nZX7tNi4fc8w2Y0sjt8FGV5acGHghcNzc5foDnlcDNp9H+Jd/XjJgYXyJphdEB4DMoOWImD37pmE1izbT1FeJkJCb6Bb6naugxCmICvxJZqKl3Gan6eYWiVrl4meq1Bl7twrz+kwBhxS6khUSrRZwBPGpXMqRg2x8P4bfmCMA0jwX1E8tM8l6Lee6vqV0XyOK6g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI4PR06MB8777.apcprd06.prod.outlook.com (2603:1096:4:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:57 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:56 +0000
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
Subject: [PATCH v1 07/14] hw/arm/aspeed_ast1040: Add FMC and SPI controllers
Thread-Topic: [PATCH v1 07/14] hw/arm/aspeed_ast1040: Add FMC and SPI
 controllers
Thread-Index: AQHdXGn5GhZB2LLUrEeVVWRt7kkwFQ==
Date: Thu, 15 Oct 2026 05:56:51 +0000
Message-ID: <20261015055642.106204-8-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI4PR06MB8777:EE_
x-ms-office365-filtering-correlation-id: 5188dac3-d81f-4bea-e72e-08df2a811e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|56012099006|261009223027099003|261009221227099003|921020|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sMpzB+47ISFiouMVqvsd5yLT1B2S8KPt3ix/7KF6Sto9M6Biwi+3JLpIZ9k5qQZVi6meURj1SgKOdkJOCJe2c+OJkgr3ul5dn6qjuwjVOk1nHkWGvlkTw1A5GuMKSlTCqhWUFwe6shnVKpblxUbnJdlR8HVkkDXbzsutMq4dX+AaKhzeDQ/jF7gRW3TZyTevapBZmfQz8G2gj1231bwebdVbCBi/cEJImky91XhG+GB2rLYIPwgXWP+VayA9HSSx1y5jdtKB0WS0FAzqdFUE5amErDgRT+hoRWtr5VPUHBbxBrhl/lo/RakleIwQJlyMU9QzruiKz3KZk1eY23I7J7TI+BqOXSTJlXcvTHiu7wHvwBpyZguX5bqbSn0pMJeptelgsvA4VZrf14bAMpZCbKy37LZgzXXdcjzrf05mVZjC4wKnnHq5tTGfOO7X3KyI2Fp8GdAk4ucHS1FkNCzyCfFngMfUVw00JPJlGBWZMWhjWUsjGbnwEHLDEksNrfWyLaHb/aoisS2EEYfvuoZcSiYL2JuMxTSqGGmZ26sZyIV0X8TdBw2Hv5RCkCo2l+tHgxkNXxywvvpy/6tjFy520cSfaHdK7FSnx5AmaiADza0BhQeZFGGn6YkRK+wtETX98o86B9o4RhPhSuvSMLv1/uBGug6Iu7NWo8Xv0B+/K/fsBq++0MkpxBp+zkl7EqHASRI/cP3pzGy1FJvj4mNE/wRYeXtemoHwoyEWmQyRqzk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(261009221227099003)(921020)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KiOrg200rka0dx9I/L/6QbRES54G8BH7x2XkNy8rWwwjyYJ2kl7KSh5yuF?=
 =?iso-8859-1?Q?vZz3x40b8xpfcE9XaC+8tFzz/taQv0hDosEbIweEaT3rL1ntqNn+tmNziZ?=
 =?iso-8859-1?Q?/LyLyNWDK6H1Qm7wABp640q5qnMOPmu+oxaHJKXTetjnq5wsaMvz0S0uxl?=
 =?iso-8859-1?Q?bJeYdl7ZahEUsXUwGiCrcAUEYBmj1kYi4MX1Gh3LSel0ueRhy9WM39KgTU?=
 =?iso-8859-1?Q?bcYyOVUxRW/ZFvvz9y8w8U3kRx+oaSZrPaLaQHh9wsIT5dtBcEGLDAKtXc?=
 =?iso-8859-1?Q?R+zD8TL2Y0wangdyFPa/BFqt7QDrb+p/sRvzGFHCX7RgPT/DuFXpMtIOCx?=
 =?iso-8859-1?Q?1iFbxnJmT1mW13Aylx661flUm0WPS+aYNyD/FghZ8bw/T7mf6KX3jTRGG1?=
 =?iso-8859-1?Q?GnYlmQPmMaP5UGxa1ti8i1PFQikB3HD88swGuUt14kcSgVwvUNa7fH2yql?=
 =?iso-8859-1?Q?c0Hq7K5/ozICgLHV6aimVMDeqL1oYjGu08b8J+AvmdUyvtrtPuPP6jCIbc?=
 =?iso-8859-1?Q?gbDJnwnmEe8pjYl92PcJNaF2URqjbVz3tnK7SYBFur7C/hTSm/pjLbVaxA?=
 =?iso-8859-1?Q?N6mmEigHCwk4JstdAmb0BMfRuT6Qd8qIQb87Xov9l8b3uKIMedCLWyTSao?=
 =?iso-8859-1?Q?0Fj/9LyBCMFhfWsvQqJW1jfo6ukabOexiPRRNf8wRZcZeEUOgH7RZvNcvg?=
 =?iso-8859-1?Q?NbXogUA4g3BSRTZOIk8PJnD8+UNKS2WDf8f6G6KhEQJwtNzh/W0xXfsXby?=
 =?iso-8859-1?Q?tYn3cyRxWJmuAd3o4Uo4gzLaVa4Rg/1m9W0AOnumWRzzBKbsIog81mAq7a?=
 =?iso-8859-1?Q?nucVT4rrMmEdR/ME/O57ACSNIMsNtWlQu9YoYCBQ7Vj3ltj8Wudc9gIZ+9?=
 =?iso-8859-1?Q?l24SGHo4ekytOLomUFl8bl/M1S/lnVzSaurBnJnzvRcC+WeFn9qg+xOHgl?=
 =?iso-8859-1?Q?rGUPQRg68Ujtyzy+ZGdLlIqT9PhSvDHmxuIexB6+7MhNxGvikJmRwB8Pbd?=
 =?iso-8859-1?Q?bMsW3zwFoFHblfrF7xF7RJCncw1mvdm8jI+glCQrT7xDe6u2G5PhzCijRF?=
 =?iso-8859-1?Q?gBed/z++U6WnBqj/Q+0hLUxQ85F9MgYrPjh/UnqrkYaQfYqX8Q2j9/YxJd?=
 =?iso-8859-1?Q?WS5exPVhTnNx3QIsP7d94UgFg0if8XSUG7w07VZjiCBfGz7M61uz6L6v3h?=
 =?iso-8859-1?Q?8EJxBAtNJDumxOQfIf87W3XMOOHjhbYHZJ7gxYr8fI1kt7GHYNRmBSi2Rr?=
 =?iso-8859-1?Q?H2fBrGFr2ekC+B3hp4EAGhN/b7w7H/Z5E/6tq16tBWYWbE7fjFEoSNC/px?=
 =?iso-8859-1?Q?bUuGQVZFbMDH+tv20w/a60qU9jYDgGK9oaFgK1I0mVNSpuL3pmz4q9KnRL?=
 =?iso-8859-1?Q?jgqR7mN50KdPsU4I2cgfGbnIBxriE5SY3JdcB0wdHArwj6pgg1hkQiGg/w?=
 =?iso-8859-1?Q?06tb0cx5eR51C29h0ARQ1h+ko+S+Uar7KXnekdy54XpNMaqJx9tG+nOlKC?=
 =?iso-8859-1?Q?CjLn5kZwR9xOB3UaT5ftIYvPZBAHUK2y3zAQVqOwcPUlpmiNFhz22jZsZ/?=
 =?iso-8859-1?Q?pNY84H/NpgrKM7xMDFtP0y8x5m+LjAqjvvf3EQ94szxHpbnD/koa49M7Uo?=
 =?iso-8859-1?Q?9bIhztZXH5xMQUZ+BkVvSNDStshduHP9RuY4pBz0uvPvkXuFAwmw5JXg6V?=
 =?iso-8859-1?Q?wmhc5PF5U72VkwQyIrvAnhbkvYAV8qI3Ws25HGAyDTivktrep3XpITlb6Z?=
 =?iso-8859-1?Q?j8udqkc9G9cG084UzFg2D1gJ8XD+wKKu5lwvBmALHMyN9HXiKzL8u2skPs?=
 =?iso-8859-1?Q?dwnFE0guNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MZVijkMdl0TDBpQUWXmoFDOON1VKuZ7JtIx+3kaPC/6ZicN1NrYD1LO/e2p66ETumCgMGvEGpt9bzChP8UgE8JOniPmUgPn381C7yD5XUugqUMXTy0/x3IWHi5Eq95NEWTQiU9iyOjb3lke2uFd9KsLzQlK0AChTTUVm2cZbKBR/yIBtQz2FY8b4VhsTxxEDGE0nq+Q1KYeC2OyctmDbLqss7BX6nHEC1IXxdUzm6G6jT3DEBnlO25aCNrd2dgxzNA70MGGPauRp7MOKA89iSfZ3urmXkTBQX+w/De4x5Y1t48+7P//yarMez2G2xgOc1cBiZi0HYtdlJHWj730vOw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188dac3-d81f-4bea-e72e-08df2a811e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:51.1851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dews/eJ91MwB/D7DfQLaAy6XfCd+uVO7fFKtUeuTpqoCtJaPFXdOzwelAxmZNLVNj5h0DOKnJOnmLrlAUp1cdV6lqFYVH21V1ZPqEDin5K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8777
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

