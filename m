Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0A6C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgb-00043u-NB; Tue, 02 Jun 2026 01:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgR-00040D-Ms; Tue, 02 Jun 2026 01:29:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgP-0002gD-MV; Tue, 02 Jun 2026 01:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2wfneoWCZqBYhil5H+s8E8Uxc2phtvo/g2IPtBtJpwm0H6xY4OFBqd5V91x86/jfGyFnyQwS86vSnzKVYtCDcP49uscJfeo78ROF9Gjl2IRF/n+q+m4UwGBB8L+dgw3k2lalv9ZRzCgfs2DamS54hKz4U2bxPlcQDdCbw7KwcowMSjMfrSxT5BnAH9/aojMII3OweP8g9PInBVvbeQ/EQMMYYMLGtYCue67L8TT7YvHd2h0GK+DHzx4+zdIvNpZhH/DI2ykjo5BrwYfD/IdnaU+2TrDeglLQMHUQW/FoVrWM1vZC9I07hw8PyBxJfRDP9m49vmOvvciTGuF7nTV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73fYVtAkqFYcmsWlUq3FwusTwkE8fjgS/ikDnU8ezRE=;
 b=rpjLKRWcJOLpUwfJz3B7bL1lxXExRvFD3t8lf074jOgt0K8OJoettr+oJnGGIgCg4KwBwSQgg14eK30GRz61x2knuDJZ3/96NFLdufWNH+n/3B7rT3k6L0Mgx7x/X4HP2F/YWRTdR6mTq/ISfwMlmhX3UbYQDWJlD++OIiClNhAIhzCr8RSCNq8vrf4UCPdizZQ9tn5sbiqPPbx3/D9ZZX7BKJXSuC+P9e0Lta7NMLNch4/ITQ5KfCi0Ytu8k63ixy7Ryid9K61pTsVzFbmR2uz4JCqGpa1yAXZvLrc9jjb/vuWt7qUVX6Vyia7DWO04ywmnmLQe466DNQR37sPHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73fYVtAkqFYcmsWlUq3FwusTwkE8fjgS/ikDnU8ezRE=;
 b=WuSUwijK3JaSm54IQsSKz2lUqup2hbO03r0GJg/4cHKdcPZoH7g8/3cxy4xudrGk9fas7h+zSbTdq14OvNKIgKYvNpg/TwqfYaBalG74IuUtdL441JxlGFszAhlsqVtFkwYRUBoV2bvgOW4h//HjNs+j3jAcWPWEaleExnt4o1IlrgDuNqH0sFyCxa6pVus7uOo04V8hm04uQ8oYxtMXYCrmEw6nBEkGkE6ZqKojFGK2nf1h0c+mhF2LYb9KBZwTuwjT1/6w0zLNBJe0ECUXN1IvKZtbbUjTSz+ZZDfsdGjXkstEJS5QUEosBrl29EZ6BpkgDyLVMfEkzfj+u8kavQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Topic: [PATCH v2 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Index: AQHc8lCqXQYkF7vSPUq9WdALtqsNsw==
Date: Tue, 2 Jun 2026 05:28:38 +0000
Message-ID: <20260602052827.1535299-9-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 7524a10f-fb8e-4f6d-0683-08dec067cccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: PmTTwcQiJBgD9KYBtD3lk0dY8rbXH8z6V99F4TsVo+QEJb0mdpYRFgQmGXlJs9gZYvZbxQMb/XgBi7vGjImTXtyp6uR7ltzgSUiPsWFxgVZ55EvzhUgED/abyU31X9P/dIxntaDJnFwWZiFOHeHbLT8XcYlk7i5jggUTsTjyWSRQMuHK3aquigfvXSwPVhzhbnJTJZxlCBME/d38qmx4Tlxbr/EW0Lh9k8l6AxxFFv3uKf4BwO0QgDmTzOLzNxlMmZq/1dWIBtGYodJGho4zYG5vOrtld/bQGDU1yIvWsPaY/vQnsY/P+bg+vykWsmtFeud1PqdgVDJfs+Uj9/Vclg83l1Hi8iYHbaL7qkz2vDsopo4yrLBGpwQtY2PUDfVUEb0qNBVM22F5CCOLpnYV4JsctkTl6GnbLCKuA2zY8u5jdouI4w/Djc+r2FmEdcsKVC4ask2UY21se2KhcjdJ+xUEcHUHC9Rjf89rQTYAYbHWfpyhe2Dju2KBcuBrq+jOl2vtv6BkVmCOR3RrEd+APwqNvlMFA/lIUqEPvZwa5A8pt5Ol7xHBJwWnmvfd1LLi8OFCBCvYjI9IacCQtCVjtzwQ1QV5R3qgHbhIQLOdLIZ7ozWJTMmhpMhhTyPM0/j1B35nmWSjdzOxERPhmzBlXTxUwhQdAXPtE21pkLJK+lOAfR67BNQN20YI18BCW1lJxsXiR8RRQpKw7GuEWwicifNAHERiVpKdOj5vkPWAMvuH4oxEiWobsARPv8/ZI2z7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T5hswvt40s+1ozvV5qLr63XQJzaTHCUNLbaBFnqp2Hc/hAyae2gaUmXQpu?=
 =?iso-8859-1?Q?VW1XBdaCFhza4JvorX5d1BD/JEtY5ilFPFv3V+fGqiHpsoUWiKoTzxnmq4?=
 =?iso-8859-1?Q?3KH1+PbXQvASwCc+t5T7yM9WIU675S1Dp+AfInpNFCp9IkkTOn6MAtHaU9?=
 =?iso-8859-1?Q?CcUr+NegkRkdnxqZ7Gk12oImaud3uZsPNHP6zxRQgm2+/4TInqIwxIV3WK?=
 =?iso-8859-1?Q?3Ciqda0ShSPUcja7RY8gDDTeCEoIy2vTtbsu7yRnD6CE64wfJSiAZOBNJC?=
 =?iso-8859-1?Q?aiydqCZKhoy+stm0FCED9eNfvkP9vWB3xcTkFlFSEEo9ZEsVDL7e9bY09x?=
 =?iso-8859-1?Q?umQlwMm0cAN9XYldqXeZkxKetAR2hTNBSA+JqNUwoEz2iMuSjlq0Esru7B?=
 =?iso-8859-1?Q?DZIBk21BH1ZgMZPfyiaUN5huz489+h5A4+H2Mm9PxgSn8jRg1vcb1hVl+K?=
 =?iso-8859-1?Q?FpC/zs/zX10TfBTc+kJ6tH3YRc7RKcxgvyc1tKwg1pyIIcsclfdUYmyQc8?=
 =?iso-8859-1?Q?DBTf+bYpEoinwr5WUpvMEna7buobU262hX/55OZ16HCKxxL5WuwdBmY5bn?=
 =?iso-8859-1?Q?ChqSTGGNyhboDsHdpuDiuMmlk/rq7ZIjx0zjoNLszvBjXVAOb1hGGCrq9R?=
 =?iso-8859-1?Q?1fbTV5/r1rqWlGxjbQnRzPbg1QalmntNf3YajcRMm8H+FzUJkoNns2Y/Su?=
 =?iso-8859-1?Q?NEu2NGWW2kQWJ1wTaWV5SHUFoGfdN32mcFOs6NqWUDJobfY2GkYJgAyuuo?=
 =?iso-8859-1?Q?p28z4phvO9RN2eDiydjncqJCTlh7i5ujxYwnMcTr03Z7Zw5dabYKpcL0BJ?=
 =?iso-8859-1?Q?c49cQBdP9PDDDhV0VpSc6ST7l29opwKf8gqowIT76XDUEOpsxsLuQ7UA+4?=
 =?iso-8859-1?Q?WxEdumCtwE8Rp3RXGaK3EpokHPHTtt6QjQUPFJ5r37gkfReNXKkF5dMUCD?=
 =?iso-8859-1?Q?mQ8X2t9pInf/9xbuSufRknbU02cHkOx8jOsXA3ryPRByy2w8nTQ60qRCm2?=
 =?iso-8859-1?Q?kDJd4FkVLeXlMLf3HCRJqwvcRePtk8/ZFJofXwlwMGUmP1TVfW0ShHbxdP?=
 =?iso-8859-1?Q?3RsPnIB83ZJ5pZPN5sfzc7GPsI8ZXPVYESZF7CUaZnp80HpiN8GcjcjAju?=
 =?iso-8859-1?Q?DKjFB+cSoxRG1AYLp/fJSIZrCMj4D5FMjuNi0DGu5H6a/4uvUrQMZbyvP3?=
 =?iso-8859-1?Q?Xxwqg2nVSxVjg28U2/D1C1DZmfZQHg+ZCVY9lB4SK0yG230DIEsDWbHsZY?=
 =?iso-8859-1?Q?SorO5smOs4eQQVHxxXLUscCHPi2EmybJ35TirDIV3CnZiEVBCDnE+YwKFV?=
 =?iso-8859-1?Q?5d9dL39QdCo9W8zjlar2KE0nkjSnK3SXzWNu63QkKC50NxjrU+TSA14LUA?=
 =?iso-8859-1?Q?ZB4iNaEaXx3DsmCEBv8/4LC/J3jD7k44JQ4hoWnZ4JempvZ34OCox+es09?=
 =?iso-8859-1?Q?KRf3jhk4si4sFj4IK6IAUpU7GGHig0Bgq4HF1MtDLlz2PLXOplPfoOS5AZ?=
 =?iso-8859-1?Q?4BNaKXCoaEZihSuV3KSQT2a60ePby9xsEu6ML78DUVgPsdJXRtC5I0DMiw?=
 =?iso-8859-1?Q?cumodLILCTSaBdubeeE4/QxgZKPYmpy5JO9kb7uZn4wBwh7IABHwkpHno/?=
 =?iso-8859-1?Q?L0mTcJNa2iaozc3zua7a6vmBiL+jpK+MQGTc4KC0IHjRCg0++AkeUEjAgk?=
 =?iso-8859-1?Q?iunnQJyB+0cJj2y31dDFVzrDQCyrEaAtJ+GtMuNcqgnMrCgoj3gLICN5dN?=
 =?iso-8859-1?Q?0iFAEzRoRU1PCICt1q2J8YUBTcdvFVE3GL0+2W1Il/9GHbYIxushCz5Wqc?=
 =?iso-8859-1?Q?WnoZJLX4AQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gb00nLSkf/34VuOsXCXsFdcZW7RxfDNL0xO5/bC/j4wc7KcNIoRf40B9lc7CQYd7e+KadI2ZSl2y1dbUjmcsNsNppkftvDzppJcBKIaiq82eBhGBNL8nbB48MyDaiV4Cd8QzRWROaABZrh64QwSLJO+oaSnctnDL17z9k/gt9XOYwhY7ht5/aFqmz3PDbMD+KAypla4ZAaeNViGJ8SGcNz6TXn3Bad+d0Q1eprtjsBkFkIKFSIf3tDIDpn76Pu+qSnqoAKfDjxlyIrKn8s04fOxeHZ9hkNu+9DqXR0i0aak08/DzDxaAQOQX/a/prnQtQakOcJuyh+1zbSC/MxFp5Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7524a10f-fb8e-4f6d-0683-08dec067cccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:38.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rV33sU5qhoZKff6J3Oa4gwEaLyNtZBZfvdsqfeNoPeXbooszwT51OT/4f3+TTXmyzOVs40lQV/LGbCooYhuyMuQOCnE6IGOq/GwVYMVucwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Introduce I2C controller support for the AST1040 SoC model.=0A=
=0A=
The I2C model type is selected from the SoC type name, allowing the AST1040=
=0A=
SoC to use the corresponding aspeed.i2c-ast1040 model.=0A=
=0A=
The I2C controller is mapped at 0x74C0F000 and uses IRQs=0A=
64 - 77, with one IRQ assigned per I2C bus.=0A=
=0A=
The controller DRAM link is connected to SRAM1 (HyperRAM)=0A=
for DMA support.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 77211ce1f3..6d1cb9b102 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -117,6 +117,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
                                 "aspeed.sgpio-ast2700");=0A=
     }=0A=
+    object_initialize_child(obj, "i2c", &s->i2c, TYPE_ASPEED_1040_I2C);=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -233,6 +234,21 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + =
i));=0A=
     }=0A=
 =0A=
+    /* I2C */=0A=
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram[1]),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,=0A=
+                    sc->memmap[ASPEED_DEV_I2C]);=0A=
+    for (i =3D 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {=0A=
+        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&a->armv7m),=0A=
+                                        sc->irqmap[ASPEED_DEV_I2C] + i);=
=0A=
+        /* The AST1040 I2C controller has one IRQ per bus. */=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

