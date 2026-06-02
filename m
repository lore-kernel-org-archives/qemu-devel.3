Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBCEC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgL-0003yH-4T; Tue, 02 Jun 2026 01:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgJ-0003xL-2u; Tue, 02 Jun 2026 01:28:51 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgF-0002fW-Tz; Tue, 02 Jun 2026 01:28:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkN3YOWtjsD4Y9HBvAXLDcuYMan3mu0AhtDTWsD3jqSDvjxtKgwNBOw8XsfyEgOIoVqMVxwg5FSvVvzpvTNLJ+L8yqpyrcDRJ9LNBL1Mt44+e98hDBYupvIbnaWNq9U783C0cuh+E7wBwAwYLKwMLzIBi4eSmDH9MKSroVg1JjzSrigb+E2cFN+tO3ble5z9H/vopwF8MkfdASP9vTKJYoGyxRzT6IA+0ocOW3sReenUPKpDcbmhoF4tGnvYERU5tJmI048m35LEdPE7TQrXDhiVf+mxDRohcrt53JP4YWycbQi9GBKoBHkA0bJi5YsnFLCHsp9DUlvKP2QiNR5EoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrTG8zd2buClBhqaHE/pk14970IbTzF4v20Qqgtdp24=;
 b=MYDQUNbkbD2f427+vLHDSm4JehblvGcTUyZnWpwUDJS4HSwPR8gQelCcoG+ikQ3I5bvV/Zz0DVwFx2O+zXGFNTFS3eHMSfABA+EuN5zfUTQLpmae4i57MLAataJA8484fuQhJMpUGNdNt0TQ7Uc034S0jpUxvLq01C9M9m29XCKRr8AaeDLPTQJZipsdoa6u2sIQ4eBkMW3dqHuzs7j59H9TB984LOd/tqGq5CDfxYyb93DW35rqkgblS8xOIleJRSAEABQl2M38dcKdQH9QCqAkoypHnMTnyRPFWYefaZSQqmV6WSUiXqf8KnIw/+FjZqzsOT5YlWNU6rkpRe5YOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrTG8zd2buClBhqaHE/pk14970IbTzF4v20Qqgtdp24=;
 b=UGWqJEkEhOTR7WbtQGUz1VWdJ6yIas6qcik0KgW74qqaa4LBdN0AAr4fnplyRr4FFfafugeZIzt7YHWaPnNWX6nBXHVP2E32qKQVMJ8OvAhhVs+kCfkRKUzCXeEpmV6mgl+nOGiw5Nf0KpvBpGW97yQ59gOTKxRLa4SQ0ykQ1/Yf5QH4BM9tZdqxgfzYhCQROCLpBtxoiAFpMDxa3CIKgQwK0rwqgI422RMM1TGZlc7+pcm6Gj5qP10muDhJws1EGXisVBBmrLaZLZbLnR5bJdpn+B/zroKVOjxhBwgybYZJKJuwhfsIJQK/KA4PaGHtgwvd8GkQrWtLbeUl7nLwqQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Topic: [PATCH v2 03/10] hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
Thread-Index: AQHc8lCmxu7DCQWv5kKOP6uKyFOM2g==
Date: Tue, 2 Jun 2026 05:28:32 +0000
Message-ID: <20260602052827.1535299-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 51930674-8fa5-4a57-45cf-08dec067c941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: XhTiIXFMf5vQwYowX9em1C2Ug5n/tn/56x1FMCHv8okJ6y0ujgCrg6DWlqt2mHwSGmRJuVR3N+VCDFdQ0IrALyxaDrkshTGuwRQHThu88RWyUm+32f6a30SZuoV60YGEADQ2SvRfcuedmxQ6K4uganYdm04HQQwmIbnB9YD6QfBfhivzos7kZJHX0ZZEJ/vURfyyXTo5vZAk/A6xrtAU7LkZbQbpMyr8UUWekYybAgch7Es0x97TI3s/zVkkfijB/S4G4DF5J9rzvwaOw2eoDmNpnojRETaNo15G6XxqTW0vqes/CvX48epmS7ZUvG1qXur5wJVw/ywBKVSQ5el4dK5cYEkwIdJSM//Zs/jKGMl39W3nbpWnAf4JWgsyymb0KNYI5+fUvYwMKJwQuDiHlwJD9zO+jot73/ORQjxzxWQzz9uRVEW5bRQxrEO+Gt/YOqgPPJOXXtFtwa5WszTSjbTH40pGHbPN0BXDmydREi9Fx9bWlPudN2LOT5Md4r5AIvfcJV7Z5lO+FeHA66atZO03ZEaqDmAL+z6x22cFQa0fZl39BfqK8anxbKA1xadGPnD7Bv/tgYaXYdJqh+2WEVu7Xw6fBHTeQFSmKWNNLWPimtMbBj5n9D8URTpcDKp8w2TRnJuKNaQoFY9BK7RNjHMFtaF+zPPP0QEimddRZPsKOBrKKjgWdJCW9B3rEj5xZXnPWsml/bYcqi1mnyY6Vc3iP/D5vQkTiL82K7CnilP/XDQL8+6T35DibJk8xlQs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BW23tkvL6jSdhbMyddEj1IY/E2PbRpYUKfS0qgV4akcU3YhvBQT9gWTqPs?=
 =?iso-8859-1?Q?Zjo4BLACrz2ebiQ9kDcKNZ86tCFOplFXx6PrJrL3z6zDf+o4YTkz7cDpOX?=
 =?iso-8859-1?Q?5XGd5WoQymRTVPahxoMJiMQy3xTn/eCqxKyKUYedeziVIYvm71GSOiQ1BL?=
 =?iso-8859-1?Q?ixKUxTdCY8wu+NKpvtaNF8tejse6u6Cmt3VelHRzMl64Ofd6EldXO0zgyU?=
 =?iso-8859-1?Q?ayG/lkYiNJVOVdAlpjjDgPuvWVtRsD1DjlX3MXq85GlhMYyb7Wf8itScxh?=
 =?iso-8859-1?Q?NOkXbz6BqXMx+dRzspVDmeFsWDQJddEcOO2iej9Q6xqphHs9xsX4S68me2?=
 =?iso-8859-1?Q?tjIDQANzp0C2toVSTjsVGO7gBrknIGS7gUVO52T+xHSRG9i4yWnfMwvk+M?=
 =?iso-8859-1?Q?FpofrKqisspZYxY6MiW4ra4UqS0Ox5zljqWwWSH5hZmP2wyFRl7XZUcJbL?=
 =?iso-8859-1?Q?Qo9cZMidjg7Oyp59T8p6jq4h39tyWPsPfN4fSKWeKdMuLVBdJsnxg1q6U7?=
 =?iso-8859-1?Q?389Pj8xcDB231SI2RpshXldJp5J7nm6r9bbvyuV37NoHor8RJQlZ8khCK/?=
 =?iso-8859-1?Q?y+4XR0pBHv9tGR7jaOvWkd+aOmh3PGMCbSzWplYPfHV2A6dQeLyy3aw/YE?=
 =?iso-8859-1?Q?Skkm0O29S5yvMSB3FMtlSL+GO8yFkrSLVKr/lmQBWwirlvdWuSmpfW0bHE?=
 =?iso-8859-1?Q?Tx/H3YFGeoVmmKL+8C0Z8e1cgdUHXREQKxCL064JSoK3vbwUv9ALyEqiHL?=
 =?iso-8859-1?Q?YdUlXz8wU7eSr0yRcJnaH19l2eiRW0z1fZDjDedvJ5Nl2JVuN498sw1psr?=
 =?iso-8859-1?Q?QM0WGz3O0XmkeRMHk+59OS/IdfPD7mkDQjmT4CVBtdK6YxA4VnCgobxWX2?=
 =?iso-8859-1?Q?++9uTa06y3FzgpmOtwUnX/6qcTCunpJPclhOawfq0f35yCrt0HeEh1PaMk?=
 =?iso-8859-1?Q?srrxowcQ6sc7BrSf0RpEnUgR2ul7cevH3LwkHVjmoD7DI879EuUa9bjLV+?=
 =?iso-8859-1?Q?weLYPXcNSadYe9BsuyamQYBKgqwUFDnqiSJfmhyRAT4rbU7nNVp0GyRb0Y?=
 =?iso-8859-1?Q?52HPyjRi6hLb+LzGkrToOOJbjD3QSwW7yLqj3Qk1FabnwJZog0dB+hkWwS?=
 =?iso-8859-1?Q?p9XxC/7/EUET/T4N4QnvOdmpNUPIZc+1PzrvC6DTLOtzGPqBmLma2n16KM?=
 =?iso-8859-1?Q?gcMm+LCF1aagQNv7fUFexOB47jleI4B03TLRfKHPm7xviTqognwMK8Cpln?=
 =?iso-8859-1?Q?xzBqHplVYB6hqjhgkJoszgCUWQrbYp7JiCsgrNJORCboeFU5imd2ICvDSd?=
 =?iso-8859-1?Q?KvUXik/ox2wS4vytGc2xTboHVl+ryuJoXrsruocvWC38hVzPszyi/XyliE?=
 =?iso-8859-1?Q?qZjJ7+Ma8PwU4e7g3FX57z97cGQlEhtV5P8wUN5SpnNAI8OnuAME/9/GIB?=
 =?iso-8859-1?Q?Jp2dK4GdEJEZSGWXiWrTDL1VFED/GiL2P5/zJSqNVZtrmIb7hhN63f3JBk?=
 =?iso-8859-1?Q?wGAoQggsGrqeNSPpsu3Q2qVPCw5olirfom6JjnBKnIFxDHP322bhgcCHXD?=
 =?iso-8859-1?Q?1x2MoYH89hrVJkVSwzjnTfwS9GRifkkx6+YaosTU9VSVZd9NpemSc5YbCx?=
 =?iso-8859-1?Q?4k+M+KK2i6xImVo3dQAgXyRyN4EXkyKqEd1deex74evRvFNGdZZkaLJK3E?=
 =?iso-8859-1?Q?TI+awsQqCxkAxPVsLFV295org3e/5NjWZ5jMOJHQlq+DDZYttb5iZHZ2iY?=
 =?iso-8859-1?Q?gxREzei4lZoqJPeHCTG8G5BVqMgkENkkq5dx5w9Wab5CEfukqs+6LbXSv7?=
 =?iso-8859-1?Q?/GyXfdhFdA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oL2bnUZz3SHE/DrIc5Ob2MdVa8QXt3cQDOVcdX/+oyiyhhr5jh/u4ZxV8Ng4tbHG8XEIKB0C3LKI7RUSOYrx0cFN08Q+MgCQEY1+hofDz3NdU2b8nOr2d1Z4315EeHt3HLKThgCYY0PJM1SSKxT2h/Q4PR3yXMhzH+pw8NyBRt6VrJg6ICUgVo9OorCHfd6xVJI2Pr8E0sUalPAYBj1A4yYUy28VUzivbgZFGdeUxd6j5YS8U6qGdeHNWnoEJkL5LmQUG7jlO6kdJDZPG2MzdKG5nm9BegWst9gHqPhGoZTOQkN8acBXWSafFAqixbZs4fgzC6SkB6whcCUQpJcxgg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51930674-8fa5-4a57-45cf-08dec067c941
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:32.3473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vasCPwFfQFGu11aqBPmRLTGg8aIsh1SrR4MBug2IrQPpGGgMwb7gGofhD+Bs+vF3KuSCT28yKtg/6gDodAYaXd9WTk1AWMG+T8ISiWKNddE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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

Instead of introducing a dedicated TYPE_ASPEED_1040_ADC model,=0A=
initialize the existing AST2700 ADC device directly for AST1040.=0A=
This avoids unnecessary duplication and keeps the codebase simpler=0A=
and easier to maintain.=0A=
=0A=
Add ADC device initialization and realization support to the=0A=
AST1040 SoC model using TYPE_ASPEED_2700_ADC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 8efcdad8f6..b736e690e5 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -107,6 +107,8 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -188,6 +190,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                            aspeed_soc_ast1040_get_irq(s, uart));=0A=
     }=0A=
 =0A=
+    /* ADC */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ADC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

