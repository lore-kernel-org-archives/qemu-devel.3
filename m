Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D31CD6E61
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjc-0003FD-BV; Sun, 31 May 2026 22:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsja-0003DM-3F; Sun, 31 May 2026 22:50:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjY-0002en-Ef; Sun, 31 May 2026 22:50:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yr9ealxWk7NKWqY1nTjES81UQBclznA799nHN06dyGTnZIxqaze2+PI/1mnxYMPyn1x13k3RzcZUtJY7lb8aUmxwS+FzoY/OalpzfW4WDphXA5UK6r+BQCsQw5XixlUSkzYMvY4xwe4OgejT2A1GpXEYKxvONdGPdG3jIRcWnjSwsg6rRcoTL9JPr7hZulkWxuyzjrZ1WBMc3odOFES1hfICkcuDuRWWwkc3XVfwBzqzplFLT/ghnmgzf5LmRo2IS20FQLSAu0TI6dECDCIWCZFI+9j/uHJLpuVhppC/GUTVaRFV1SXDdwa9T83eusehHWn0lyr8DeIwQXKNIPVpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GQjNs25sQ+VxquNDVkkZxcYj3y6EP8v/cbBMMSFNCI=;
 b=KdTY0mFPcDhV/6TPjhKUxIVqEgaZLdygS8X67XvfdYgXG7grLQ5LstN4b01SmbIvFnJCiJiJUyspaprqT1xripArH1EPeaF4pHUwH6nD7KKVK7odHFnoLNoi62jjcJHeH3oEMscB3oJuu9EamYSghLth9/0jN7KEbsgOHXqf3YjAdmurAu04c75Qup7e4fTj+2kELpmCE11Cli545xxCETwWsEhDQoIsi50VA1evYGiXQCfV6M2AMWKsRH014Km81ivXroZDH/h8ysUtEKaAsdy8XYtwtTVgxrPg8/1gmZl/qf7DI/7H3nDWk5tFr7bbtG9k5BwRaR95vEx4vr8khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GQjNs25sQ+VxquNDVkkZxcYj3y6EP8v/cbBMMSFNCI=;
 b=L6tubJj+hNL4dPTIDDszBZEDkunHZ2TdaGjPC6uw6+dN8sYv5yo6m45j53dgyQf/X9to8SKGTJVGyb6z7SAEYnGLHhlIGkJK8Wz15acDCYcdX67EKj5g+DSBRwEvSqOSaRktnUxbuPx2+vy4Pu4JSw1R5RFrn1nwiiQcMv7B9k+lYERgm8Y+FYsgtxN5m2zqBdtjFj+0DctKUMogi+YyjpB7OvqUd/hGoKruCmWBLkp5bv1Ktm1ihAtRLCsJ1wgrfVpSGNDSHeq6j6IYo02lnp+p6djg5EuLjadVITcA+AKImq/saEYBki0qE/F+Es+87+WJg6sRIOxea6d8HTIfkg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/24] hw/arm/aspeed_ast1700: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Topic: [PATCH v1 11/24] hw/arm/aspeed_ast1700: Convert to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFhmn3/1eEV/U6UTGuP79r/+w==
Date: Mon, 1 Jun 2026 02:50:17 +0000
Message-ID: <20260601024959.2347639-12-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 909ca02b-1552-4187-ae53-08debf888393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: KVSRikPybB6DFadohUCCSM56zHVcyhRRqkCHRfh3eALi9+AXyEyxy749UWi+yjYVozbgqBKJU6/S9rHtVJLn9PfEIDysjyvT6vkiZ8aMfCb6X0ObnrLd446K/Klr3WTBQ9UAedjq2tK1NhMicCLkbr2ZojauwGz9BBunm3hxLaFfsugQU9cYVTMVxF0anzcXyDvGD0klzZJGf54Q4ypVhHmcvVgAmecWhIKsCQcmNV1fMSDUSwYPEIlz9SbMrz+wSMfWEkyfIcfoupmHnJ0+cMj/W/Ij9NKPB9AiAV+Ko6Oyb4q1ha82fhf0MJRY0fv/0/G/QQvsfI46Y5NyuVH8RyGdWnu6M8fnoMCMvcIZJSzZ7Tbc/MX5CA6OwRGpCG/l/AGNxr1eNiVGsUkM+S8oA5lYJ80RyicdNKgFwkpG/QaeiatMsAhtjhn+iGxl5d8HNOx/LfYb0mA5lQ8HXb0snDBmdEX2/ATK9edJQOUuOX3mpxQTlQNfBVDVIhpTAST/XjwrOD/hn41bDE0vhrHXyPeczUIn3fDyckzwJl3P5T54B2IuJuoBera4iBvtzFBQdE5Ht/vS/RTvi6QnMfvXh+bCk31tQO65pSes7gRTp84jk3kEkorofPUvZZaKreRrLag8+yXI7KvNOyKZHEyq88EaAQcVEICbSwwFab4/hcgda4upg9XptDS4stvJE8JvFR4ITouHWShCfv5+DYnuvkzfvy8KMz+M6yZIQDbdZFKBvPh8+ImHnp+S8vs68pcgUV6zYEaPx0TLQZVeCImHyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Yc4hVw+Xu4EBh4MCCLjMk9bf8ymgBOzMZ87OGX5uGZi+5e6kIRe9BNYzNW?=
 =?iso-8859-1?Q?ZGC6q8VE2IsJE2n+mmeHz0+PpFybVI0iSu/+8BLrh8UD6r+lwZ+BiD2JrS?=
 =?iso-8859-1?Q?0ZVOivVF+siqv/Ny20pk+QIXXcIK/QnKMCxuXvZRprMlKFxLed+jN5MUiz?=
 =?iso-8859-1?Q?fw2dMD5ym3v5hJphylJ4bpiGDi9sQ7WyTzJftiTnQJeiSo/sCQPd1ADMOP?=
 =?iso-8859-1?Q?QrQ/oB67EA82+yra6YUKv5eosaCFpZWI4XwFLBCUu7kuKnPNYaKKDs4b63?=
 =?iso-8859-1?Q?lMbB780+XzXN32vhthOXiMbB3QvgXfeXbtK8jan8ZA9Noucnzv7dLszF3b?=
 =?iso-8859-1?Q?z95ww8cHeNhtPB1bgQDwvoVvJcA4nw396YELq7e9n6NX1clIb1FZhGIh0Y?=
 =?iso-8859-1?Q?otoIzzwhiiny7YVpOh7nWuuQn5yQmaL6SrROva4kRwCgADk8p+DtLMXhkc?=
 =?iso-8859-1?Q?9oc7+q1R1pxGbazijWB2bnm7EK5uiFnjo2amNWRxqh0VFIeM6hhrknevUI?=
 =?iso-8859-1?Q?hyzOa9u7EclBNcJcc0JwE7GR0wBVg/tWyz2jaV/IIgLkmNowV/08f5LuRT?=
 =?iso-8859-1?Q?2I1rKjo+BPlICM9z/EiCb18BhZvSgcc0ux3br83pagfZedgYOb1DG+UJ17?=
 =?iso-8859-1?Q?qKxD7jo6oF1Nc0Ur26WySySe7r6fJxW0xuHWPZqvVbjwseecqLZYdtvPww?=
 =?iso-8859-1?Q?RiJS8zdhOzG2UrK3I9Qj6FVH4MIUkW/z1KpMJjJmLpLrC3YUbT22rDfjeM?=
 =?iso-8859-1?Q?ZBDzCyD7I6WXlk4s8qh+X00ioD0Za0qchXaPf92NIKlISXx2FWax9qL/HH?=
 =?iso-8859-1?Q?uMug2xyosXBnva29k5YZ/WieFx76rAZvrbB1vsvN75kvCOqBg52z1F6AaN?=
 =?iso-8859-1?Q?go12T9FP2wJwZgdqxNTz/dEts14zbmS/wJJqgtOUZxgypzDTe+v7BF8ovL?=
 =?iso-8859-1?Q?YBRhpNz4yAQHKbJ1ObLM34UYXzlQGaA5nU6549sWBsF8lD71kbZLuXUOCs?=
 =?iso-8859-1?Q?jLO/WTM5HiHTuIRmJZs4GyYDsdU26591nARpdE8l9Qi4Xf/K7op4xtleKj?=
 =?iso-8859-1?Q?22BEH+lY2J8kJHZxQ0gLv4T5S6wV0uotRHTJCb6s/4IGIDb6+ra11cBjla?=
 =?iso-8859-1?Q?e9+wtlWAsUj5yGp7u032gYpQjb37+kGHYsPbvOwlYihA4+MA3Us3fHzsN5?=
 =?iso-8859-1?Q?Asi1/fIo3oeKf71cdmsjuw4JkCDgDX7h7T/mov3zbR5BRkK2yzqJcVtt59?=
 =?iso-8859-1?Q?M6W/xaMxewGJZTHOnS09okjKKWyKeaS9CcO2+dErRHGGLYNQl2i1Lg9mXe?=
 =?iso-8859-1?Q?pxIu0IR1LU4205ej2Zr/2g/J1Xhsc/AmrijUIsURwsXn1/Lg5SHJ4CRM4P?=
 =?iso-8859-1?Q?YuzX7SAncZjHSNJWVEqZh7wDy/UbEG4SFB1/zOx2ioDuuq+/DGNVjXXvfy?=
 =?iso-8859-1?Q?C/QmWeQYgSmfruoKZGW4XFFCtNKcM0bzGMZExMfFgKJ6U764gaSRvB1R3m?=
 =?iso-8859-1?Q?Pmfp4rS4sYOg8VLGbafQRht+XV1fxX37le0hOGpaC9SeDSau9yf2q6b3of?=
 =?iso-8859-1?Q?FvQc6K9xHZpRBQHlH/lCYOTPoOpt5kzirMFzl+iS518ManEf+k0kCm8BTv?=
 =?iso-8859-1?Q?pXMazcqzyCD8kym1tfIWVqIFWE7Lb261LlfYV0RkzJUVcDJuTmxqlf2IAa?=
 =?iso-8859-1?Q?fVyuiwzcrY8T8/l9Ax+hTMmTdAh/nv5sy5b9sL0nUNKow4yM7oPt0DhAX5?=
 =?iso-8859-1?Q?6AhVdC0NcdeznrUeoLEf7Ib6S79tCii89ZmUyYF+P7S8yD+HSzfv0l7+bg?=
 =?iso-8859-1?Q?qaHc9D6dng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l41+IFdjK51DhGog9D53jBpjVCOCNxHTYF3+f777unyFZn+6R2TcwIBMC+fDn7+9A2A5V5raVgi7BDcvPiINjwAsL5LYbVLI9dM8uMufRJvgBA3+Rrc1I8TjcwCU5q5B2l1PInD6BLjl5Ktv5If+zY+03jVFSeY0+gLuak4UkGhCxiAR8i5L8j2n4SkuKL5SXMFYgvarxApxVG5lzuuk3Mr5x3FpbZzg25OG9r8qPt2I/xLXAE3QlwXspN99O6x1cUrvDtf1fCe5mqteXETQIAF8Yd+TXrP3tUAx/BG02MbRM7QovzyChoyJAm31gmIAChiGgyn3x3uH5/N95cx5iw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909ca02b-1552-4187-ae53-08debf888393
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:17.7100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgM3caCyILUUx03YIw28rWSJEp/8Cp/qlsXPOvOvfXStDch4n4zubo3232VT9rPzNT+LXoTSQ2bdwEXCtWrFTYeZnevqynXNcRjVnjt5PZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone TypeInfo variable directly into the=0A=
'aspeed_ast1700_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1700.c | 21 +++++++++------------=0A=
 1 file changed, 9 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index e90302c11b..5af5da5b8a 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -260,17 +260,14 @@ static void aspeed_ast1700_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     device_class_set_props(dc, aspeed_ast1700_props);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast1700_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_AST1700,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedAST1700SoCState),=0A=
-    .class_init    =3D aspeed_ast1700_class_init,=0A=
-    .instance_init =3D aspeed_ast1700_instance_init,=0A=
+static const TypeInfo aspeed_ast1700_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_AST1700,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedAST1700SoCState),=0A=
+        .class_init    =3D aspeed_ast1700_class_init,=0A=
+        .instance_init =3D aspeed_ast1700_instance_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_ast1700_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_ast1700_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_ast1700_register_types);=0A=
+DEFINE_TYPES(aspeed_ast1700_types)=0A=
-- =0A=
2.43.0=0A=

