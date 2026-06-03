Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FC2CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnT-0003jW-QS; Wed, 03 Jun 2026 00:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmk-0003VL-E1; Wed, 03 Jun 2026 00:00:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmi-0002QB-8O; Wed, 03 Jun 2026 00:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjk89yH+FDpAimZRdT2IguEZH0Y8ALMnrPeyNnZRN6ExQr6o3uMqILB/D9DjsJeqm6IuLrKmx0XNpKqkcmjYsAz8m/oH0EgaKf5bfCwauNJKjbwSGNf9cA1Uh9ZVJ/jTj+H/9lPBSSHkOEr03HBg02n/W9xuPbGO+ooYd9LHT7hLX4/f7RJVLnZKY/1u1fS+Nk6Pq6fDo/lvlLHfnE5mtqyX5fLeDoDMLo1TOKmf66jMATj+oQaecgIFTQCR3abe2S9e0W16hRaXXs6xE39qee8UfnnDwZhfEQO9G+thDbq6wJMcWTjPpA2gBzzT3pVQORiwC0hUYz6El4oXVTYNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIelT3DAsZBBEGovpzku52xURAfztS/3rxlL2t6NuHs=;
 b=xykIlHGnpa8w9w7dutHuaD3HL7NCqFMlcoV1ZSLV8IsKAzrbWEWgd1c64pULGU/AWATG1GrF8l+R2mFgTCpQCqfrspRChnP9FZHg8RdaqSGa7mhQJ6ignUx5wuhewVQ9I21/DRvkr+ZBolOOS23AXz8dEouhnM2nvuS6mAYzR/FTbP38XKCRvwgsd4RNkOX1TYLgFFMh6DslKJXXHn0I3rRGbY1TG9CXTTb/XXVgLMCAakLX5XPjAKePUcM1w8VKp06ST9H5NzCLkGPvmQf/A/hF7qPseIuZLikc/rbGLXh1Mqiu9WxpCoxuommdl0UoNgZahj7o3CCeVd70OHeWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIelT3DAsZBBEGovpzku52xURAfztS/3rxlL2t6NuHs=;
 b=XTzSakKZeQkSNeZXsMJXsJWF5cCNCrRjcUSeUTURZ/pS5jsKn5tVzUxQL75hXAV5Zi4P1icQjwHpiEtL4u37/TXwNkK/N36dDd1iKvu8naCbvc+XtMl0F39lNMy8qXucF/PZGSfJpUhhac+a2z76IHtYMPXzVziVyVsdDTyuxgbb/l5CmjbU17u0QARjgFgwCpttJOXLZbwcOpXePKod3vzwLbmxFEwjkAkyNym+q4n+lyUvEQjLOsL9Ft2aeYDA5n6cRvuQiwGoQSB6BkMxOGDTLd7FAgRqt0y3UjBqT95F8fjEzU98yk8PdUYfcxh3a3nu5tNhmEgW2k/BPQxj2Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Topic: [PATCH v3 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Index: AQHc8w2IbH1X7QM+S0u/7pVmG7PTaA==
Date: Wed, 3 Jun 2026 04:00:36 +0000
Message-ID: <20260603040027.938816-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6b8add72-3437-4633-38d0-08dec124ab2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: Jt5QfW8Pc1qOdwCO/0ISu3YH8Mb/7FVVgxM6tCAJy0C6RjfsAdohhKBLXqcXm5myTKQXBdoG8oF+2igLodV4FCpqTxfuh55t7FShlp1eT+aOLWe6JYPdxu7N2emkHLSjidpyTNlZRfpyq/fqixbUx0Cd8iooshmQWa8OoIJdvR4Ox+IAQ4LUTtTEfTvMt9rlj1Asd/15g940rb3nmSW+cJlclS2hTQmyYEbD7Bp0zEgsNFvBasAKo3XreCEEYfj7vKmnqjEwWlPdoyAvOyONIp07rFplQJ6iTtII+b5r/jO2+nLHpa+zuYcTGflegC0TWX54fpQVbrVl22ujqbj2fSPp74iB6YQdYXeGvm6xlmhyBcWDmSIhWFMouQ0cfecovMPbIUwNHLlfXo7/6mrH96DoSwoNpsfItiXojnf633qmasJFRn5kYKQlFpEQw1mUDLteyV1VGYJD3uStx3mGq+WUTjAj1FhXIRHpJoIb9DYsOzZK+G+exClu4o6WxOLiCYCl02LWyU/Fg3s/HxblS+dtDOKpiYYnGrNakf3qILMwyhpOkLiIP80X+ESt1lfR89mwks3Sf0dRdW4ljl3+HN4Z4tLcp0+wmV46LiEoz6cmp+2dUXdqABT1wCMr8/m7KIb4kCeCKSje1APuGYkChoslI5UFcpB1wiNEouR6SH5bjgRjH9wZbZ7diiahOEdJPX0K+NRvx2+19ZouBdoRy+jo4Mf1/z8/yP9RuuuLDveUqcsmMi4fMqNl9v4MGbgz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tUhFq9LBxhSwxwx28hjwtevhwSSR8wUz9vpfmn+EgTqMUQ9DYZY2qxdKmK?=
 =?iso-8859-1?Q?Ghy1qKNbIXlAOYMg87N+s+riDIDigL1esDFA2PaAELOqr5iiC0asSxMal9?=
 =?iso-8859-1?Q?+zRdnMgg5Ba2mLI2pGDcVok6LPvUIsQINFodNysYnulRDHaPKkG+kf3dBI?=
 =?iso-8859-1?Q?ZfvWmNJ6mUWJHFwSI9fH736Plr9gfmu1neh0e+x96yuDzbybAEtIZAXblS?=
 =?iso-8859-1?Q?SY8Hosfn/ETY7NRzdaF3BhmdYrr9mrtXhHeS5Auw1QipUcHwkDyf8/gFSh?=
 =?iso-8859-1?Q?0NAIPxzyNqLcJLkOjCIy3pg7V70L/rEnS+Ic5qLg40UhMj4Vqeioiq/Qp3?=
 =?iso-8859-1?Q?NXZ1feXTi92iUjHSN4Vs1oscbXHSS3KJQ2ve+BkHhEc6ZRyMaly73DJJ2C?=
 =?iso-8859-1?Q?zKfJtfVHwLFCpNzRU00A9mt6klSPiJPbVRmAIPNfJNozTCpXn4l2p8Mdtz?=
 =?iso-8859-1?Q?pry/C+Ejwyp2QKh+oHo/KdEVd5ZDYjC2bpHYumDgKTkqB4IWZzgZTnWPFs?=
 =?iso-8859-1?Q?+GIil9/RyPDtei/MWWDfLHm2fOMei79DeLqzOoVUmeWUNfbSpIW7vQQCko?=
 =?iso-8859-1?Q?nXgNDFgwKMS+3sMddJFvB2Svsyul0lp1a6YK8ZKZTknLnLuJKMVZdGs88y?=
 =?iso-8859-1?Q?JVLgVOO808EkMO1STkNpznvakjwjjGjo/InDF0TIoIhxKdH5JNVbQM76Z+?=
 =?iso-8859-1?Q?pBJR4SNwa/1ECvitzTjocYlRg0DSekBV0GS72J6QZpZSYvBOcMrqdZFhLr?=
 =?iso-8859-1?Q?QEROG6qF/WPKouatw70Zkc6eLgp+UawZ28qoFypMsXHriWAfvtS6hGtWVy?=
 =?iso-8859-1?Q?bETewGTujhBT650ZsBPksurpSun9nQGWtMVjmhXx8qyik+UHv9qSnOx9Dh?=
 =?iso-8859-1?Q?gVt8SpMBzw8H4HF1EWTfBqypyYiW8XZ85pL+PPchrUx0vgJOdZ1XeRZfON?=
 =?iso-8859-1?Q?fp833YMqrqqNkmNitsK+QmrSR22iJjmCDaF7M5eW41WVc8Ur8L5fbKZUpY?=
 =?iso-8859-1?Q?4T/hSw2oSU/dD+CkIXi9lHWo0pEXQsZ4ILTk8M5qzlf8e09eR6ST3iAvxi?=
 =?iso-8859-1?Q?s4SK3IF2azlYDjiUx7GvXgE1ootunwxY8khq/simYu/QHQOOaLFocMSvqU?=
 =?iso-8859-1?Q?iITRL6U3md0WrAlm2Bx/hpdAZ4DKoWHORcrevhQl8+FlPlD+cCeelSyE67?=
 =?iso-8859-1?Q?3IlLrZnDRMPGDgGLlALM9ud4w5vQgjWK4L9e2SWSfADAXtPoBk01P5KbVm?=
 =?iso-8859-1?Q?dcBS7/aGZDxn9mRvYsEZdG2RucN0USvRCwbk7SHrh/T2yfoMVXLf4OE0ap?=
 =?iso-8859-1?Q?tXAqMETNIqsnwckFDbJerui3xQFRcXEjVPVNETFUnQFqJWhW2ycoFKqhC4?=
 =?iso-8859-1?Q?ftzdfDx7hmSarbcCLdZmZJSgX0CIc2krX+BaDyMOxfw8P0KkbYNFmGCJ78?=
 =?iso-8859-1?Q?XaNOrp3VmNr6+EGN3C3WzQe49HBHX69mLkOAvyKrldnTbmumh9koOGEExU?=
 =?iso-8859-1?Q?wgS9bLLorK3Ip5yqpB3x1+BSb65axH1LILhXH0Cc7crg53Q3xRqewfZBjk?=
 =?iso-8859-1?Q?3+VjNVUJcIJ9qIZu877XVe4OgDEqVAJ1uDEIsVFBzThPfQ4Af5AozumI/0?=
 =?iso-8859-1?Q?7ChyzorA24Eex/1o1hjVwvrePm9QauDQsB7IJ9LN7js8dQORrFy2Vv7Nd7?=
 =?iso-8859-1?Q?Mqcg1BTktyiYb5oIIwU4QA5IJyZExvl2SAoz8rmrtlwQEa9+1R6STIkEtt?=
 =?iso-8859-1?Q?N7/Q8iNiseMmOh3KyCfSOaV4cx3iAhbFzNzMsq5duvOwyKmrDwXTocMsOT?=
 =?iso-8859-1?Q?Qt5llkWFQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ie+VMjNO2paVPgDQz2O6Fbd9fIvXy5YU9iNHFjy1PS8H85NFbxrbd22V4PgDn4soqWTo+ivg/PXP1VzZyrDSyhaO0qKDjsolqgzyu9JYOlIaOUCM0xXVEAJ4wqq+CIjMKS9P9wY7FY9snRXUJ9bpynSdlReUOBDGXtA9kyMAjTiEx5ObFMkmjnHssH3GwVg6dOWVOMlYafwGhjfe+QMoFJPYWDgji1obihxMvJ+k6Y3K02hzXF6TiW1CoIUl4LWIZ5VoOfzCqNyg2twSv3jilzxwlFiuwX/loilIjytIHBhE4rWqV+g6tCtLJIkK1br4X3AXvY2NmyY8PnA9cpZKeg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8add72-3437-4633-38d0-08dec124ab2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:36.7459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/OyIMC67++t3lsOpVBBRxRg2L0yVl2PxglFhTBNb/oI3lU18Q2UHi88IavSBew8uLC4oiLdK52+VQE+ITDDcn70pb8HiFPLXfI4ZRw+Tz0=
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

Introduce the AST1040 I2C controller model.=0A=
=0A=
The AST1040 I2C controller is compatible with the AST2700 I2C controller,=
=0A=
including DMA support and the 64-bit DMA address registers. Set has_dma64 s=
o=0A=
firmware can access the high address register and program it to zero, as th=
e=0A=
CM4 CPU only supports 32-bit addressing.=0A=
=0A=
AST1040 has 14 I2C buses and its HyperRAM is limited to 16 MiB,=0A=
so restrict the DMA low address mask to 0x00ffffff.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  1 +=0A=
 hw/i2c/aspeed_i2c.c         | 33 +++++++++++++++++++++++++++++++++=0A=
 2 files changed, 34 insertions(+)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index b2e4d2fb9d..156998e7c1 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -30,6 +30,7 @@=0A=
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"=0A=
 #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"=0A=
 #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"=0A=
+#define TYPE_ASPEED_1040_I2C TYPE_ASPEED_I2C "-ast1040"=0A=
 #define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"=0A=
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)=0A=
 =0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 856d5dc1db..27afcaecee 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1654,6 +1654,34 @@ static void aspeed_1030_i2c_class_init(ObjectClass *=
klass, const void *data)=0A=
     aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
+static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 1040 I2C Controller";=0A=
+=0A=
+    /*=0A=
+     * AST1040 reuses the AST2700 I2C controller implementation since=0A=
+     * the AST1040 is compatible with AST2700. AST1040 has 14 I2C buses,=
=0A=
+     * and its HyperRAM is limited to 16 MiB, so the DMA low address=0A=
+     * mask is restricted accordingly.=0A=
+     */=0A=
+    aic->num_busses =3D 14;=0A=
+    aic->reg_size =3D 0xa0;=0A=
+    aic->reg_gap_size =3D 0x60;=0A=
+    aic->gap =3D -1; /* no gap */=0A=
+    aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
+    aic->pool_size =3D 0x40;=0A=
+    aic->pool_gap_size =3D 0xc0;=0A=
+    aic->pool_base =3D 0x1c0;=0A=
+    aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
+    aic->has_dma =3D true;=0A=
+    aic->mem_size =3D 0x2000;=0A=
+    aic->has_dma64 =3D true;=0A=
+    aic->dma_addr_lo_mask =3D 0x00ffffff;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1703,6 +1731,11 @@ static const TypeInfo aspeed_i2c_types[] =3D {=0A=
         .parent =3D TYPE_ASPEED_I2C,=0A=
         .class_init =3D aspeed_1030_i2c_class_init,=0A=
     },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1040_I2C,=0A=
+        .parent =3D TYPE_ASPEED_I2C,=0A=
+        .class_init =3D aspeed_1040_i2c_class_init,=0A=
+    },=0A=
     {=0A=
         .name =3D TYPE_ASPEED_2400_I2C,=0A=
         .parent =3D TYPE_ASPEED_I2C,=0A=
-- =0A=
2.43.0=0A=

