Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF6CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcmo-0003Vg-MD; Wed, 03 Jun 2026 00:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmg-0003Tz-2G; Wed, 03 Jun 2026 00:00:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmb-0002TF-TG; Wed, 03 Jun 2026 00:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcCS+45VUJCEy1kua/q58hilRAqXXN9SAY93jf+wckzZoPHHLiXnnYgMMAr4aArjKNNBkJwtfP7QArUinYWeJj/QwF+FKU/rT9kuVcez4N2TYv8TAMACI/Rub8D54oTGQSU92EYMdFyCCSSS33mNvmAEuGAnKuqffJtwkOz+S0Of7dqFLcblHKDHRrsbhHDekyZy76OtlSZhbRdF5RV/jYAfRmcIzK+0JCJUUs1KL+oOiQtYHynx8cZVLmbFatfSJ1udslhUuBCFpakI3vOd71smDEKg/SbNI1KWM6Eo8FelrH2fY2j8UBtE6U/7rxJlp/lteinP53JlFJoXQJij3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73fYVtAkqFYcmsWlUq3FwusTwkE8fjgS/ikDnU8ezRE=;
 b=gJjwhEB7+Is2rptGKeOqaeWu1Fkyen3ulL3fdKf3BQNkzubBjn5zX96kVtZKkKgBCBknqKu0KPd5hqBTcM55O1O1zgOAmFXyb4FlXyxWqwYHoNAWIYNJ5ULb/QhkgGHh/60C4a4fUFej5DXXQJUJbB5rBEAAQdV8mL10tSTmR3dTmUB67Uxy4wpnuQ9uctMhu/f2KotHSSxchfoB3OAZ5sCRQszQNa3DvkiOsTNi+hA4rtGine+hrk5vPpz9Gp4/gLNimokFw4CsweDqVVbaf1Ire48ozEfBZzm7TZDgbjqgOws6J61d0ouJhmmHbmbRJ6XHNddTX3fNF6XRast/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73fYVtAkqFYcmsWlUq3FwusTwkE8fjgS/ikDnU8ezRE=;
 b=qwtwg657crJABfL/bP1n/kwYzlWC+qay+LtLS5mPvM6zZRT9O3Xi1g8kZ1XvMViylzrUN8B0K7pTExLQ+mRtdoMSOqyGqvm+SDAXcf+U/Ngj31VM1JbfPk6RMXnS3NEE0EcpfEx0qe84kG/u3v88KdbPmX9kG7fMQrYdUzEUU65NUbOW66I9lr3WCaeXTKPtQt0fvrQWtVTGnCb6b81oXBnAHGAV2oceZW0ModmwZbzo+pLd8eJHnsjpu/UCsZH0nFO6W+2lQlDOP2ERBufl9BCe/bPSKpVckKyFG46lAv2zMvEmd/b0u75OJEHbyZNCZ7cyKst5z9JinQnr5qXODA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6623.apcprd06.prod.outlook.com (2603:1096:820:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Topic: [PATCH v3 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Index: AQHc8w2J6Y+lbiPJ7UWuQLa/rqiBuA==
Date: Wed, 3 Jun 2026 04:00:38 +0000
Message-ID: <20260603040027.938816-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ef583521-dfe4-44a8-62d8-08dec124ac0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: iD42sN64vQ04nX09xGJw7fE0WrzzrxM6i8MDiqoy6++Zhp9WORl+zg4UR//HLmMBXO9SaAoWCzO//iqBK46aXrv9+XscefAN2qMWrDKqV/q+2S783ohIAYFYKLW+BLu+cVApCN0f6mSenDqN2uxH3IZx9cGb5gPzyKcbTH1j8jDO09ObvOTYkf3Pvnglkv1NJjtS+7pKTL9iZwzn2Ko91l3l691oF55uqsD69uyF0w6lSJS4PkpmtWDivBDMQxl0ly9kv+Qd7dlw2cyiyt2QSeq6FqYuGE7/pSMAvwjzwzt+wZLrnY2RvIujkj0PrEROVKBgWA9Tfng6slo5k1yWGXHV0f2n553H2VItel0bmsTy/WAZ4OOIRLE1vashaZqeru8Tl4rwxPSfkJziALTDXnL24tPOZICHYajWQ5HW6iOsdH4OcOG6d2jZ60bfW8e7Sd3Ri9D2gXUKfI/a2m0LJk/iRr6igc4tpe87bIeXY0jmkHcFWjtz2db+meoUJkH/IrPIHscG37adrueeSJDzDq6yzDFiXYjz1zAcNCPgIn6E8BN8k2FqzfGAaAdvP2L0VLGK7ua3lGTumrp1T5AEZ+u0keeRUQOR3ogYCY9iDepK1umkADG7lRR6cIAuk+PMyAGOiakG3BrdK6CZaGnLpvRZwz2k7UkMeygLp8XBGLQqvv2uEsgnBY9AHuJ5Bsp9YIhf+wrBI/Jgm2a9gi2MoYBWk7OpxlIvioPtp0fY2Q2g+EcpQXtKB5MEmZpfHSFf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VPh4rLWvFYHIyPuRMHxlbNxgnvaErV+xdEyvatSwbwFAN8HFiGkQei3hhU?=
 =?iso-8859-1?Q?WBVxTZ7yJe5cUN8CqjlGjhTEeTr5+RNJoS56LaBKE1MtfktnYtx1rMbG0N?=
 =?iso-8859-1?Q?W+w0+5FohafpEkzf6rWLmjfQCV0f57FO/lC5+dkojSEuVjoAeGc0Nbc7Tx?=
 =?iso-8859-1?Q?K1r9tr7Iw4Zx4KHfLOoWzeIN+213o1J4FV5Tj4D9XvMW7/dmVc17NJLqZi?=
 =?iso-8859-1?Q?wgZnWX5LbqvYOle5vxUwfb/g5W1gMW6eKl+hLdeLqLS7qHCBS6wu+vLrao?=
 =?iso-8859-1?Q?usw0tzRKv45jZelSrIVg3rC8RmCtyjTEtzhVfafLxtPkvHz+9SY6s9H8Ln?=
 =?iso-8859-1?Q?wnc/tso/JIY0GrU+pqUQ7ryOYBkjhKhgmFIyDEIjWSm1RWbzBZxOi5wb92?=
 =?iso-8859-1?Q?2faHRABhkDzrZQFMZl1X4q2Wktu0i8mj6TJFFLuagrqbl1Hbv6rQWKTZNH?=
 =?iso-8859-1?Q?h56jmwsxNi1MkJ/DjdGjdxl2f5DKJqVnhdK2fXbiEHz1iQ2WD5iMRy+WPg?=
 =?iso-8859-1?Q?EBAFKKG0e/HYH2ORz6V1thriibkRlg/tjAzLLp9nwfydCT80Q2ionPftkv?=
 =?iso-8859-1?Q?Pbxv2z4YTyVIL5UQokxmvjPeATgyUO1zDq1ARDvB5WPCndH9wUawxDTgiG?=
 =?iso-8859-1?Q?BZOHCmNIzjHF0krMIcp4SsksSS8eZbqfPYvhtiGk0EnbwfLBlj66Xxu/9d?=
 =?iso-8859-1?Q?2bwLaw50L1e9Y6Jj7eyGGGE7wRNijYGkG0N3Ttn1zfOe1kG3hABu2LLTL9?=
 =?iso-8859-1?Q?6PWoQJwvdbAzV6DFHR4Cugv8Q5yk9b1J/bz+hbHmWanfz8he8jeItigdK3?=
 =?iso-8859-1?Q?Z1ZEi8vaQjXGD/Y9bZ6KhOhhy81JOxI303FzYmwiH9npWmPU1GMN111M/l?=
 =?iso-8859-1?Q?g87kawqBk2c915HghLIPLg7gJjyEh5q9IE3T4uja0OaaQVJIoGdykPuNoZ?=
 =?iso-8859-1?Q?XgfbLf0sZljiV8cytn1XfcKXZaWBfJq0VT5t3j2vYzWNYW/Le5QMrSXYxB?=
 =?iso-8859-1?Q?yFqiaZETZEpBMxpvcnIcLZxXGElc6RVzG85lOhAoVqG435p9DqRhwIKt9U?=
 =?iso-8859-1?Q?f0hYdxTF9+4Dpw8gchemHbYzoVmqM1/592BNBWoF22RX3cuKdhTqKbTnI8?=
 =?iso-8859-1?Q?PLxVc2Xx41PVZrn+18PQomC1i1iFgyjnHrsQdO3cYaG7dxitJDH1rsG16i?=
 =?iso-8859-1?Q?F9Zn8cK+a3p4d9WS48KbbhNh+JtrL0ujwsHHtWzVtHS7fOdZqWmM5D2/r7?=
 =?iso-8859-1?Q?OkFoUIcdP/9Ec6+35Ro13PlobwF04xkIyevYJzLma32bZBjx2TGKRv/sry?=
 =?iso-8859-1?Q?by5e7zGlxEXH+ZLHg4sBX7wCdtWKrYwkylzbqivq4BIdyQqfWdB//zVl2N?=
 =?iso-8859-1?Q?dH4t27/HTQPUtoCmo2xXjdmhv6DvDnRn3ZrX2PLU9tYSMhZslzTh8msSxY?=
 =?iso-8859-1?Q?s32PROGhiOAUx6cHd8jGZ/tenSDtQSx2z3h9BRQ1MOZAiB8T0weUlZx3al?=
 =?iso-8859-1?Q?nPYa5x7AMirl6SjHWclZ9D/Yo2GDxV0Lq4DIZB1nv6tSBJJN7+C117VpwK?=
 =?iso-8859-1?Q?H1j1u6kxxU/adw8vXpkHdNR/vd5woE++9mYASWKBRemrcl994vlMgN2YkU?=
 =?iso-8859-1?Q?5BGbIxb7qMen508+S7H9XjmG2Xtbxxr2VaWw3Zg6uiGPCZx2BrDp/1mNSs?=
 =?iso-8859-1?Q?1PWaVw9oqf/SXutNFQnbE3bW4p+mMDlAnQZ/Y0TBVRRjKQ2dgeoB/x4Zq8?=
 =?iso-8859-1?Q?7hXcL3EUQFywJz6sYPnmjurzNLolmZLGDvZ1+7l29wqUf1QWThY5eq//eP?=
 =?iso-8859-1?Q?hgtSDNOkOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y1+zmoU+X8xEWByWnzZSnr5p83Q3oqnMsucHFySl4tiLxxmL+dY1K1mkJOO6roBPEI+jguVu/CXPCjYJTt+gNZxzOvQm6SJ5Y9C9B/LP7uQVknJbGQ3sk0/9XACxNTLh87HWq8YBpif9bQjzded5B8veMfDNbjlZjF7dsUXskxnW9sHb8w43OkZ/isZAT68U6Q0F/fa2Rp+9/eyFyoTy9P/kBGpSvTa1QyXS5ZAhpODjngT7a1FyUeOWLRM7N2jD4Ld3jIZFNS6cDFNANNBEHRlWtwcbnC8lMjV+SjHAqe6PxtadFLUhZeBgOwDlUHmXh3uI4jzYPGvsyk6GM9XkeA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef583521-dfe4-44a8-62d8-08dec124ac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:38.2180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tW9HJbew4qEFwn/Ngw0mki8H8JQa3r6HdV1r0ns7qrjiYZUGqGh22Z5Ep97f8ULYKJLRpw8yAr9N+/In9JX28MU4/vRxJ2FccQ//rLkRW3s=
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

