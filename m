Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60299CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnJ-0003d0-DW; Wed, 03 Jun 2026 00:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmh-0003UE-BL; Wed, 03 Jun 2026 00:00:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmf-0002OB-Cr; Wed, 03 Jun 2026 00:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXInN2fV8NUcb8M4dpYXq1qaz2vcuMTFajDP3ci6NHifw7SzPJDdVdNUBVfJlg4n7l8VAMq+WTLXfpkNcINQOznE7rqhTUY0NQ3di7sh3Ab9waqkYqruyHSVnqq2aAh86iTz+3aLTfFPVkxamav5wXZiL+Ma76EV5URFP9JWw0tZXB4B6al8mKrp7YVSPeRzmADAQmX/Z3SHW5dTV4l+in2mii8fXstVZnkrW91a27Ym+7nd4zL5IT/iqLAc/bAzILYiUKvMkzeuaf7+opsIRxRpMUW/kr2vWMJnJLo6sdwLbHHDAXIjcw33iLPAa4cVaZyLTlOvZ3xmLGkif1Rf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwqQTMcIbbeGHj4DzMKq3QP8GMmsA7i24EFJRkLzc1I=;
 b=P+nVQWU+IBicnhB3/ZgH8Be9uWYIPhD9of5J6ylNr48xXjeV/X/4HvmUto21PisDj1kSvX7vY6F3bMq3NotYImdSbAf8oBRThWAz9yXK5Ogr9/5iQmLjRRDq/cTLnfZla1BZCWiZfCLi27lFFg1pCEoG17TuKc1h8E94lnYt+hsfb/UkR38GLCKnvylLDxM6hJjt6E5NYfKJoCboOGRjL9O+zRwbwGOK24DIgShOpLkusnftri1d4v9pdey6JuNOSdsNlRew8n+xGEyJzAGeVncAyoHiYh1aGmXWctO5kbJjS/Q5QPGxVNwFl1VBIjIN3ZPOBOrbWrsF0SA4mb3OsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwqQTMcIbbeGHj4DzMKq3QP8GMmsA7i24EFJRkLzc1I=;
 b=WQkOGz/VOqkDWCVwQlnmWiuqnTSt0rHqyGaWPFoq/Z0OjS/b7CbD/9MFMZ2U9QBKwW9dBVoQ0oKpriqxkZ64V1i+Xq6W1SrpzhlGGfKH9t5sO3ybO4QN0cn33qveIwac0DkXi6G3va7Wepr+MkZ9bvTgQ+H3ulcvzIcQBb3MtdUmHd969BWltyZLJUZBfcDNsw8uCKMYE0woN+t05P6h/clelOEKw2pYOyos4KeiZoP317zoQ+0YHvbKtvwgSBYYq36WfOQvsRyydHVHx2qeG8Wfe5hWmwmZ8jx4p4RNqPMhx2GqDWuyZ+T5kUG3hfi5W+6cSmQ9b1mP5ZLwDzuRvg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:34 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller
 model
Thread-Topic: [PATCH v3 05/10] hw/arm/aspeed_ast1040: Reuse AST2700 GPIO
 controller model
Thread-Index: AQHc8w2H/mIBz3J2DkafZ/uzeIRRcQ==
Date: Wed, 3 Jun 2026 04:00:34 +0000
Message-ID: <20260603040027.938816-6-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 1cf63e56-e8e2-4131-8962-08dec124a9d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: zNocqC1+9u/h2FQfPzt4tk4DT757J8AajntWwwc+DJgcL1y3rCvv90a3EGntMSJmxoDehQxFmGljRfBOCXVbzPRgwdSqfLvvKh7xhgr7Sm0F1poyiRCG6S3Znz1qQskOedtoigjW9A1ViTsEuV+QvEUFN6J4s9iznlYxqgRJZkA4KFil5RfF9Jfr6DtS+z01R/S/qTUHAdx6B7BKEGPA5HBCPn7m6mNZvHSmVz24RWOaAgq2eMX82XXAi+XaRpkGOVWerALEX+zLiuuZ1vGMzSAPP27yzjtg3yKoKCUNXZwPLIyJGGcj+F1j15rmWVwINx5369XZnAdintGwpNGej2T9jVj6BpDUhBWU8MeiR5oGAkMmNVoedUCuSmuO3GdlUXDNgKC+YMXhblZY77t6xCJLKAqQW0BBvY7visGvmizOS9DSpvKRRPjezlRr/L2T5Y7Sz4vxTjCuhkxs+xJMDJs0vkAfBxsH4mwu64+3bFiSo1uWp9fchiXEgFTrW4z4MdAd+OyONWx+z1WnKofe5PuqCo37p5WFqRnIIMKqsP6WEUEr1U7SLB+X7Hb2vgKk97nHbQAWh8Xb+diHvb6x7jJf9/hWgKYJ4Be4t0CzwHVg6/+qqJJTLSBUzqwSHL2ctnf6RYi9CYRDIYpKnPfkOqVVkrVPNgB9/6XzHHt1/QHKZoDVrhWYqalob4suc4qJhnu3pYm+CUt4Cn685DA79ziVDHjbIO6Pg/CiekgGmiEqxDfyL8AAGnh73C5zGe7V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bqhcEutB9k/XWG1b/m3TjZA2Es71A5ZSu1st60J/05U7F7emnvrAm3Me2U?=
 =?iso-8859-1?Q?fpHFd8aZ+kvy2zqePO6b89Mkfctosuxg8U5+TByJ0poYxizG+pdxWtEgYF?=
 =?iso-8859-1?Q?tA5+2f9ErTC3KyFEPUq09HZKeiT4QOr2qD0oSg/Ja3GLriiqUvTXSJ5bLP?=
 =?iso-8859-1?Q?tR8tOMRF7KLZMIsknjgP8MeSC9qrOHxu1fDOzhRDUfnRfNOzj0N2TUJk+4?=
 =?iso-8859-1?Q?QR46RZ52G69sgufe3/YFNXUjuYuZzegi8v8uo2IA135Bu9U19PkydVqJDn?=
 =?iso-8859-1?Q?OP1SP1CPQI5HDnEeV7hy7R8caoZp8sNnmK1byve7rUiAW6BdCKHsWEI4/c?=
 =?iso-8859-1?Q?rxJfmlJWOwLmIMOcqaDBm9dhTRlhASPoeKukg7GEQUBEPCJA/dIO6Ls4K7?=
 =?iso-8859-1?Q?zo4AH9w+ebL0OJ3jIAjmQIvw9gyyoXrE6QpgBwJgf+xZbU0wS8hoj4OBau?=
 =?iso-8859-1?Q?fbluds7Hboxd02b6aNSisV252EF2HldEMXAMSg1c1+2NFiTI76TERPbX9K?=
 =?iso-8859-1?Q?EsV4/vNSaLy2+8f/eRxLtOy8Vpn80SxBLs19re/HdH42TcbNf20aEduRY/?=
 =?iso-8859-1?Q?4GdmTuHIMfaIQQZmvONvnieVo4n8047hICgTonXwGdlKIq2lRjhTj2CS7x?=
 =?iso-8859-1?Q?NSmwZVm1SEHBlSFNKmQI47Se2z4KDbuwPwXjOoUcoaCPao0d3+L6w22YPP?=
 =?iso-8859-1?Q?TjYm837ur1xxv3C616klWrimuTae93zRIsjrMy88yPJLopy4UkXrb6rkl6?=
 =?iso-8859-1?Q?7SJsOWw1CB6TnLo2E8M9j8fOHPWJddk92a8rpBaHbNJqQuyvxst7i6J37S?=
 =?iso-8859-1?Q?PCKTMvENEpqi5sUgjh1SMNPscNADbcHuz9XsS/Emz3zrJlcH5Ydep2TuaW?=
 =?iso-8859-1?Q?zny7X68u0pIQMUhKxryfJ550aNKK9mpwhtH93rJRNGNo/gTaEnQA1iBIwN?=
 =?iso-8859-1?Q?DY50Sp0XaHnkFGJUu8FTYq5RXz/WBhk5qm6dVWJvITxMCjRmou1ZxfzyEf?=
 =?iso-8859-1?Q?DkWynczLFvieupmVHmafTdeQ1akfpPL2Q1a6Q80AqT6SAnId1xqpo2v1kt?=
 =?iso-8859-1?Q?tIMRPyL/SCqUiloeYba8xgr0kyG+aVXmsRYZZfMM0Fr93nfbHzm8VS115w?=
 =?iso-8859-1?Q?5Uzq+SYLjwWVOrjXOZw6/9ZPg7tIqpMbjk+RVqmULd/WRR88voqp5dAa2T?=
 =?iso-8859-1?Q?87JPI05Ba0RZzyuMhwP4KS9ppiasF6skoQE1CMSVs4MUB9VHEm51sG/JEh?=
 =?iso-8859-1?Q?NheAo4x9eXSi+wT71M6TNo5Q8FYUPWKl0CgN07AL/lX119j2RgYvSHErZU?=
 =?iso-8859-1?Q?DIK1mML3kvbL0lbBxerKqKYin5whpBxDcVuGNGMjn0VSfrmSrlCE7m5i1E?=
 =?iso-8859-1?Q?xkO+1Vt/24jIoQ/0exZl2apxaapE8gg7J6I21o3gGPnvh/ZJD3IRod1XOM?=
 =?iso-8859-1?Q?GMXILuDTzc465sLxucGXPIczmmj7iAG/W+c/ZIWGTc4n49l2W3eNU6j1c1?=
 =?iso-8859-1?Q?KVxkwCXkbHX9O0YDtvI+dtzMi8NBJRmSxYZpLl7TcDWoL9dQE2Aa2sFBXZ?=
 =?iso-8859-1?Q?WYAmYS87pHVTDDRVCK7FmY8pbvogWYcYqXiisyemcx40X2+uuilQ7/ItA2?=
 =?iso-8859-1?Q?0CB4jiY7ErpvMBK+nhKInwhXeOIZ0U51vPUyiHwfYi3FOew6vR8V/v1UnI?=
 =?iso-8859-1?Q?HcJZpPyeLiuSXa4/vO3bwh7zmSSe04ykqwqJkRbCxRcm2Yabej2chjISgS?=
 =?iso-8859-1?Q?O7ShfTXTcGiV+oawZs3NWb2qWusCPkVFgrAeaR4/4EVmiiLqBHVsQihGs8?=
 =?iso-8859-1?Q?/Zg+XYIP6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CpvSHxQR9GQFq1AfcsZvz2OYkfoEXadODUhd8UhXXrIAf14OQslCTbTMsFFaT+tc8CK+YHPm5v8+hWV69DjChjtv0JTlillkuqcoqsbHQMaLtbg79LVgGIAaDvGugA0orbW6G5j27B1+d+lsjg3TFPkad72CFRx++3lXj6+kvEMlwyzDR0P4y5Eb+SX4qrxF7/O/CjG2bVZwGIZ8VxRbebDYUHCZVyE3cm+EZI5sKM9RVWarEEdI9XIwpM/r5TstvyeDC558s5/fP6v5CeSOml/LiydxUDnorfgGzeJPHZv/AzJqFj1GQOGchzhNEc0lc0AhTP5oFJD0nc6WnVHSIQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf63e56-e8e2-4131-8962-08dec124a9d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:34.5392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2Wwox0Thf+grvTNGonIKqbDz5cmeK7YoRhsT8McpIGWR1l08TuC+i5rFtY0vcUuh2NIS2NYKioxeze4K/G9dCctNx9N4URqcHIvZ8WFwKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
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

The AST1040 GPIO controller is compatible with the AST2700 GPIO=0A=
controller implementation.=0A=
=0A=
Reuse the existing "aspeed.gpio-ast2700" device model for AST1040=0A=
instead of introducing a separate implementation.=0A=
=0A=
Add the GPIO device initialization, MMIO mapping, and IRQ wiring=0A=
for the AST1040 SoC model.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 9ae0a0e7a4..c6b22186ce 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -111,6 +111,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
+    object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -211,6 +212,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
 =0A=
+    /* GPIO */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                    sc->memmap[ASPEED_DEV_GPIO]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

