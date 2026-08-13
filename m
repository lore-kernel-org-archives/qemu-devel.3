Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF5C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOrt-0001R9-7t; Thu, 13 Aug 2026 02:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrV-00015v-Lu; Thu, 13 Aug 2026 02:24:21 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrT-0003FQ-PI; Thu, 13 Aug 2026 02:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASZGaZ7TCJd/qervH5YOWsscEQ5WuYAeO43SEanB39qmSbckbMVuaJW8ugpBNiQLyVQBTqHFExr35TWqOIECMX0qNlWPiA/6fDx/Ggc5ITt7Mc5G0bSHTsnVXLzXKAoC4IoAF2h8UePlzQyOgkxSGris9wybqWfQ5ZfZllF0EVZAvephWhhK0XpiCwTtpLuqekVEJEOteO2ZzUUhaUWKjgZ4o0w+Cf7fRlwb9nEFdV7UgSVmXXMOuXQFJekIvpMLPlzoBwyAQZjjFhDyRUV5Oet57B/NZ8D2Wj0DBwX0f2LgYNIR/xCR2uifOVElU2mQlF7NuXZLSclbX2kq88rMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dF71o9a371y2KHVCbzKeSfpKJO4OzKPw43aypIsA/s=;
 b=GMzYy5MD52Qu6al5XgoB/CrnID3sw8DOQ/odb/kWvpBO5ozZzlfJOjCIzYTtqMMNY2QDomPovl7GZZcDxM0+ArNkcRMsxSHCJ/2bfAZMfHwY4OaFUVN0e8+bhaLNyR8v5AhPcOkL3NZDbHIEOtvkaZOvGBJZJzIoCBtn7FvRKNpDXJFAkBX0+8nhZ/xpy06xM3nxuUe6d+pfrGo52Dtri1fReG5Rrlb5GSk0VE6t9mHGvBJD0BRIS55xR0yW/iqlZ/QwJ67AXrDK0faWum+8GLVb8ClIwKUS+1S30HWLhBD0lvmNZl2q9v85ju7eIytSyJjLIX1HMoF/qKeRV9aEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dF71o9a371y2KHVCbzKeSfpKJO4OzKPw43aypIsA/s=;
 b=gXWowRPPasyJQy3wd3VcokNeEa00ZHtA6qj8266TrpcC00Roj9P0p44n9MyHsxkI8DzP/vXSkWEVREP+ES2/EjSu11zsxF+G/TrwzW/mIjDCaDOGyZGy/HaLLbJ7+WoEU4poMbrdQ9YBy7roolpNIkPl2pEA1mFtMoZWZ6phtkz9vuaTC3wh2txnD6DdV9XviDH1oVedoG5SBLYfCzahFpow2qYaYLMqNrGTN3q5yQ63uvlNcwJpkP/We0Em+Tvfr3xPG3bfoVfIro9HLJR4sYkocTQJig4yiYeCKmgqgdNuOhPG8hKmxol11RANZDcm2/qp8o7H21diTE6W5Mffdg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF56FB370CE.apcprd06.prod.outlook.com (2603:1096:d18::496)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:24:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:24:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/5] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Topic: [PATCH v1 2/5] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Index: AQHdKuxWsnkTMk2t2ESx+BlGnkb9cA==
Date: Thu, 13 Aug 2026 06:24:03 +0000
Message-ID: <20260813062359.425268-3-jamin_lin@aspeedtech.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF56FB370CE:EE_
x-ms-office365-filtering-correlation-id: bf6996f4-bd4f-4f38-6489-08def90378a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info: mXSJr7bhYqqegfUHnkBx89mGCzBZvhepYBxPGsslYp5dJuMlVgv1MhK3ResvJl4tX27Yo+acJatEdU6t6njpRyrrFMqxYlb04SlxYdRDdFsl+X1k0bgzYzhglQ1/cpJb7O4us4nonx6hLpcAVlUzIg2CPsb2saVlP/x9MF133hvxjnSj62/h9C7AMs9z4u6hdtVAdHSnn8RrWORTOXAL0gxvYa0Zc5nczbrB/gGIDmivALbAEapJ/XCd6sEkE8/rR/Yv3jbjsKqoGL85KcAWpTQYIAoH/IrfeiXxWkWaaWZIN9b5nYOg4dvUOa0WOj8oS4aICPSz1g5RuEjY2zHemGojrgHSCNq0TKTRi/U+zV4byFuelLzT4Pfr5FTLedX8RSVhqWcEpwW79Ozh+Fk/Es3q/40aVFkPR6b0SFvKMces15asuaTPD46W3xgOaAp+oZHktNy2AiAfa4NvUN8hZMeAmetk2NJtWR3ucmcyZd4aK/obVbQtT2/sMs0hAOMvCaoIXF08cQvLhPRTJMbaeL0+pE7ccFaRqRVXfUdmm0/xBCL1X8zu7b3i0al6hNWI2jk4spcdvkxr5K4T4zeL7PpupsVjK+z3yjSLpD2U2hkaT0iCYhsGcLFT+CGHDopFgRMUd4rmRpjwuJ1CJ8lDiF+oGpgkFT7yJJ00ASHW60hd5dfFDPLfeOrP55DqFQmjHsDE1LrTpCiT2vIEuxWGvUb90YJaYan1axR3UY8c2N4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/u0ept2itRm9I82CbNL99qVuXqGiz3EPY4b+l3YU8MscFnM+Mw/0O5gkwa?=
 =?iso-8859-1?Q?ZtDHr6we72GKLj7ZVTcCcdbq1dP8ZssjCYCcdt9iXQ6e7vjhN5CegdTjaQ?=
 =?iso-8859-1?Q?XCPZJJinEQYybWru0DN4+MtC5uch5dssV5JEFUqAYmHJqSeA/oEqYurTxj?=
 =?iso-8859-1?Q?Cs5hh680VNg/PWiZrXRHHuAPb/CklI/7BJwNcXz9vjOHy44KpIGy4e6b8+?=
 =?iso-8859-1?Q?/jP6La8xpeDmytjOyVttWIrmNvYoBXJzMz6i5UhpghX6GV4OFPktd9yaW0?=
 =?iso-8859-1?Q?ILjg8/iQQNcYH2FqpOr8Q0k9IWxvxFjKv5ud3+5Y5pvL0yAY4dQWM2ciVc?=
 =?iso-8859-1?Q?XwqLy/tbpMsVuoyqZmWWbb+CkCng9icG4d5ZFJV1sNPMZ/58mbDqTpXsqj?=
 =?iso-8859-1?Q?VK7yZmjYmHpy4v04PeEJ2Ek/vSF2ZAQoYNGr05tIHM1kdCoYfVz8V1+xDl?=
 =?iso-8859-1?Q?FNdwLhN8g9+0qFDA+y7G79jQ2DlgKoNXKalecGFgU22CR8ul3jDKR7LG7J?=
 =?iso-8859-1?Q?i3A2r0m2bBVlUOBjeueCpdZWkPRtd4Z34JHd0JZEVemG7JCLNzvHTNYJhs?=
 =?iso-8859-1?Q?HneYQjq56arh4Xcbt8RE+S45KH3aIgpp0DAPOthg4VlXzM1pWfFE7jacfJ?=
 =?iso-8859-1?Q?O0RU82Qri3Cm0oW5sQ3xalb1quEHW/9OzHNJv5QN3YE+8bnqRyDnnP4ugf?=
 =?iso-8859-1?Q?MjkCKVkYGQpD8BHVzvm/v88iwx+7nO6pauPhvEmawaeW75qgMPAGzBpX6B?=
 =?iso-8859-1?Q?WiLwA2K1AjahlHULjTJQnG7Bnh0PmfEiL5OtwzzJjZQB9EyJMPqy6Rrnlm?=
 =?iso-8859-1?Q?rYLycLdAqJi0zL2Z1o55emHuTd5mM7231HEgRvLgPfRk3ZKaufdGPcT28W?=
 =?iso-8859-1?Q?oTvYgTJgzPJuhD8h4xIwkHZYMbnAaspSgFiWza7iYU0aO7m4VqxLVL5Ctl?=
 =?iso-8859-1?Q?qeXa3ZwslmyAGcQK/MJCvFV+uQvtF4TvwGK4ocqjEGERZwgPCKrs2qcYHA?=
 =?iso-8859-1?Q?5k/2IYHcBgAaeS5Zt61DlGhT35XG1p8rw9VVyXyAfJPa768vWoASxZqEn5?=
 =?iso-8859-1?Q?JtyCydEME9MVkvDx3fO4Xz347PEe3W5BO2U5Luf0pcIULkmYSSpj/hA0Ha?=
 =?iso-8859-1?Q?SgJ0MY4SlbjcTx0TJ3I57Em2BwxR2ut5wDDguOazuUUlmq+/O+FHCu8wWb?=
 =?iso-8859-1?Q?aJBIfykqSyDJqDfTHNY2oLIHdqMv09Q3aShQPPrintglwE8HW9TkoCPQMY?=
 =?iso-8859-1?Q?u1tAreFuMNf2hzDmasAbwZXuA/JVi5w0OJ+CAOBruhwcbnQR+do4tV8o/6?=
 =?iso-8859-1?Q?i9Q0cYB8pitMs3VQDiuk8SfALOGBS9q8PDjs9yGxQeJKEKNVOY2e95rnSN?=
 =?iso-8859-1?Q?OWqStAcPYgX52ZNPpV9YlFckplLoxCRqVxK44kExAF6iqEt5MdUKtajxGU?=
 =?iso-8859-1?Q?ItSLa5x14y27ciiwTc1c9GgeegRRdzHfJyuPHEUgH8agXUWgvd44Fg8Y9H?=
 =?iso-8859-1?Q?d2Z383/sKNbx5pbr4lMc83Ncry1MrlsGZqGEbnEZ6By3wirGcOaS/8KBWT?=
 =?iso-8859-1?Q?RrNjUE35Wqb08FVk84Tj3ztBftAcSk+QZo+DWPuNU7fSM6/vOe6l1SS+Yi?=
 =?iso-8859-1?Q?xJP7lN4jS6DO/dM+sqx413g868vyBTpV8CSpIXuH6SHy9FDVOWlQXeONtU?=
 =?iso-8859-1?Q?NUeJJliVccjbMdShxantrvieOj8Ms234SUU6a5atUnWN6N+3+SouYZ1TCd?=
 =?iso-8859-1?Q?diYUK0xRkLPw7+QZ9bI9OTpXUW/kiK97EXcj7m88pqrR2eD7fHAKd95Izp?=
 =?iso-8859-1?Q?OWPuvkQcqg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j4egQX2XfvJRPr4Qvz5oeqEmLwTzonapkcLLEB4ShK9zJcUqqgFv5WgYNfNrdHsAgW96KdaW80nTWqZqhddE4NR9k7D57bI4Aq+lmY3yIPQizAGSv37X3jY8dIIwLgAeUxl6pknu1PP2RtMDB3sR5d8QzQlrC5EmeAQE8mLbsfhU5rLWv6VN0VkZtpLp+zb/8snJA74yKxeDbOhbAKkggpRu38SAB0n1yiIloCjgcnxS5k0d9EeUT9HCpraFYIEifn3qG8Uz930MkXR1cPhkKoPciASLSGt4gYORbv28/CcKDMipKyKNRTii+ObQNZ547a5STii5plywJS1kgl+QTg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6996f4-bd4f-4f38-6489-08def90378a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 06:24:03.6873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7jshUQ91999Miang8JW6/WhQ+7Pw71nhVA2ljoskbmz2pRgampy6n225zMFU9EdDdJ7oGBxY7s74C0JfL88qeOaVlCZGco1GDS4eDvZC5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF56FB370CE
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Reuse the existing SRAM0/SRAM1 array convention on AspeedSoCState=0A=
to add the ACRY SRAM region to the SoC at its real-silicon address=0A=
(0x1e710000-0x1e71ffff, 64 KiB).=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast2600.c | 14 ++++++++++++++=0A=
 1 file changed, 14 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..3d1cd8e2d7 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -8,6 +8,7 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
 #include "hw/misc/unimp.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
@@ -24,6 +25,7 @@=0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
+    [ASPEED_DEV_SRAM1]     =3D 0x1E710000, /* ACRY SRAM */=0A=
     [ASPEED_DEV_DPMCU]     =3D 0x18000000,=0A=
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x1E600000,=0A=
@@ -361,6 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
     AspeedSoCState *s =3D ASPEED_SOC(dev);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     qemu_irq irq;=0A=
+    g_autofree char *sram1_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
     int uart;=0A=
 =0A=
@@ -444,6 +447,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory,=0A=
                                 sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
+    /* ACRY SRAM */=0A=
+    sram1_name =3D g_strdup_printf("aspeed.acry.sram.%d",=0A=
+                                 CPU(&a->cpu[0])->cpu_index);=0A=
+    if (!memory_region_init_ram(&s->sram[1], OBJECT(s), sram1_name,=0A=
+                                sc->sram_size[1], errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(s->memory,=0A=
+                                sc->memmap[ASPEED_DEV_SRAM1], &s->sram[1])=
;=0A=
+=0A=
     /* DPMCU */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
                                   "aspeed.dpmcu",=0A=
@@ -765,6 +778,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2600_A3_SILICON_REV;=0A=
     sc->sram_size[0] =3D 0x16400;=0A=
+    sc->sram_size[1] =3D 64 * KiB; /* ACRY SRAM */=0A=
     sc->spis_num     =3D 2;=0A=
     sc->ehcis_num    =3D 2;=0A=
     sc->wdts_num     =3D 4;=0A=
-- =0A=
2.43.0=0A=

