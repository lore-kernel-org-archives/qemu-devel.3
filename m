Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC196CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mZ-0001nm-Bk; Mon, 12 Oct 2026 02:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mV-0001le-Sp; Mon, 12 Oct 2026 02:45:07 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mU-0006Ms-3u; Mon, 12 Oct 2026 02:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4YFnxxYWaxZsEhQmGm+LxJq9Yjtgzb3o17QBTrmaxgoYHob7mQA0gMIYUaxgRY8tNcKZouqPK8IcIviVQnzSStEmqV2Ftj9EWfzdxrQptHyCrqgfmURTaL7cCIhjqfUoAV531+soqV3nFzdynfKE7jv9FUeBh+JLFbVq8mf5v1Q4KEWG8yYwPK7WbmpKq9jDk542191fvlXD/et7ZQpQckn1B9kwX5buSER877kJiDvTl/9sVskj7Y1Sy4YCbp1DIYHaOemuP5eLcEjZOcHpZRqQGW7PclBaV9rgXx3l99ZUqUOIQKVMPEJwfKVyyy8CPMNdnCxbjVGa+CmocjbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Flyzn2w3QcXPMyX7Q4UatH5pwSRlwqH6VA2vmBc/1l8=;
 b=TWBHnA2CIJITU7r7TuY7dY0tSvdZvUnGq7TgU7b64MUNCcBkwVSueKwf/FcvD1OsQP5QLGwN1OD2ObDG7lRG8R5FcHsZY0EATWZs5qfNapVGSuqiNbcU0CxXnF45oIKv8FvvxL+Hqq7Bv70iCoUlyw/QuGWjclY0wmcznIc6M30c5RR6h3ZcGuCECL3zYOysdgRJIWdmQdOlGi4PBzwZqcRreYCdcgI0GPSfrJzA45pHhMHrK6pcVrJ4RdH20G78Ds1Sk9UJejC+/fJFyB+6Q4sCOgn9CNgErWsL07qfJgp36RM2DYHSD/GOOkI/HBW3cXCKl2FektX7fpxbLxjKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flyzn2w3QcXPMyX7Q4UatH5pwSRlwqH6VA2vmBc/1l8=;
 b=rnc2TVVKx/9Zdyx0twERTYxMi7w5gcHUXoSg7AEidf7M+hzEXlCKkyJgDxatDAbXp7G3QjQq2FLT2ssc/MonDcvxRwxHIKyn+Bt4g7/iY8SRE9iKYU6pSOK+hHm7J/i7R3CrAl6ZTXji98sLb++FwGUAOSFlK/fMFcBQdY3UBwEDGmnl2Opao5si5/tO9ZB2tjG9MswbPhkmSnGTS3WHj4Trf+dfQYdSvERggoo/7TKEo5Zw/WckdYGdmX7tbvMzoU4QNszLYD/P/U3BnO6i+WnHFSFdS4GsynsheUKmgGuB2I70drcXyxjsJ9/hLtTYb11xUGhAU+lB2KhSa8c6Dw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:52 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 06/12] hw/arm/aspeed_ast1040: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 06/12] hw/arm/aspeed_ast1040: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUvQomWQHpOzEWIZfeM5a870g==
Date: Mon, 12 Oct 2026 06:44:52 +0000
Message-ID: <20261012064445.2571633-7-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 9a08ef8f-5756-458e-35dc-08df282c51e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009221227099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: NEGTXm1Xa/mGkE0oHZxX1ctBcCuWRwOqRDJigHxFl0GfA9YRF6lptx7tsorQ9jqVlXKT7+CbZtQhoJ1tBHgu6vXZTyc+vMFqDfVLXycDTuhUf9GhTirUEslOfxaBwlmFzS/QeeUQWAYaqvsIgdaaKXZOcGqU9YSH80mt9IgooBPbtrt3pAQdHHMihTRU5KTdlSp8jn/cBKy4bvKpxcQTUveHa7DyhOteCT1JXEhSEHIvnIJhPm6NcMLjTOHW+oBDaHmNlFw4gti8lqplycYLNxDGCGXJ27oQf5ec/Eci6B7BdyIWh8XaslI/ETLFg23COSgGaQzjuwP2e4EwOadFhRAAZtYWoontJkLzp3UIz+zpvBlj+7A2LC4oHt/j7OaVSsUpCn6h2kaviSzaDnSbhe5zo74ijvGiPZPKlpySrf92bCuhZ4YvjXgyQMAuINCXSwSb2zg4ZgOzuNezvPCfX28OpYBnKLeCmy9mYs3KUCvauwWYhohN7Z9jWuXdvI2xP6vC8pQGV/5LYI8v4VliYOZVRvsvvs+6VUhwyMaIomQaLHJasvaNCQZZkvxQVdzobKqS/3VaAQLUjNhtJ/F/l5ux4esm+R00AvIZjsZ1Ww7xLqQ7BIGdmYF1rPFripu3FV7QRYNgJG1xYLl28WJML2o7z27CMUsc1LeS59lf0xHhCqoCrEse8z6YGSN84/YAni+A2qFHBb8qDoNn+63XzTSCAoKIWi/gANQ3AZSOQyM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009221227099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KVe4B5/179DJlIZhPOCplIyz+cevZODX3iQjEuZAUYqOITyQObS44Dj8Ge?=
 =?iso-8859-1?Q?/M+bNt9eHaFGicywv++LZw+CGsYXcGhKjiH+DhJgA6ZQ3/BhqnDj1PSm5p?=
 =?iso-8859-1?Q?WSaYrG2TI+kCBpTQXI/DfZaa94/p9WI/w+cg1Dj9VXhr10bHC/QKVgML9j?=
 =?iso-8859-1?Q?OzdGhvpHWUZVjQk7gRC4Ftcv3JEj/qZdYNNkSi6JbUEeD4FJHD2zHu4C/m?=
 =?iso-8859-1?Q?ZYhF1Dhe8KbqByhsJ9IYjWwYLRx+Od63pDg+nGq8+H+Dob0zT0P9RkqESn?=
 =?iso-8859-1?Q?1Wc/V5TQVtOKgqS015vGvWsengbLxCT1+vwlxeeHEk1hqGB9c0SSnIlOOD?=
 =?iso-8859-1?Q?20wfKoBX7NmPISw5fZvd4Vn43+UgMpEgRF1U7WfPdQ4d6oDXlLBbHAtO9f?=
 =?iso-8859-1?Q?CCEJDGjdZBIs1LifsFCQiBqo7PdlGyM5bCM40ZEc5BxE2U+ECJxdrtDE0o?=
 =?iso-8859-1?Q?bp91pIgkIqhE1zpXfMe0DsBOik96aLYuqs6DgG+3aLcVWE6KX4apd8Cee8?=
 =?iso-8859-1?Q?4s2NGueDwz0QkvWJVdGssB25MDZSHvg2SSuNjFSU4hH3LPK6Me4VNDsCfE?=
 =?iso-8859-1?Q?7tY0ovaqcMGbmNBGXJyeJ0YZ7Jrmp3tyt8NiCyA5uqpGq/wDiPQj3E8H9Z?=
 =?iso-8859-1?Q?RXaCfUtorLAuj/hRQq7L18/kkB/fO7LbOmQqlAN5VH/7nHjBM3ctS+9diS?=
 =?iso-8859-1?Q?2BMiECuQbrWidlXgR/AqIkpIsptgzeJeiXRimyOO8yJY0O3MCew7t1EeR8?=
 =?iso-8859-1?Q?oLgHNlJpL962M1D9Xv/MdSx5fFFfmduoGWjKSLMU8g1o8Jzt2Nl8+5EfHo?=
 =?iso-8859-1?Q?N+jyoWLeCY0mwdSVL1DKVgODevfh+MsKZ08BfcspCjI3eS5wuoCkrlXSbe?=
 =?iso-8859-1?Q?jG3HfYDRaNUW8izoXPbePd6sd17zEsA7ZdhN2KuWVTnriftWIBnNraWu/G?=
 =?iso-8859-1?Q?JmXhDz2OlAh1lehw7/WjxGbJTut2xRH0+AMFnt/tFFkye3FnG0J2KvYpqS?=
 =?iso-8859-1?Q?fjC2jd1ViysZWAYUFHmNJcFDknRFHjfJQk4JUp2TanPs0uk24ToKvBolC4?=
 =?iso-8859-1?Q?hB2vadv8uCXG6cST0nNvqM8JCzwmuqVKqCcrxpUusP6NJR9wtdrPsYtTPS?=
 =?iso-8859-1?Q?0dEdIJLkh560M0hdDgtFwJfwDyZ9gDbdPsyqou/G8197xSXeGHN+cLUP0b?=
 =?iso-8859-1?Q?m5gjBOf8BCdxV2obusvk64F0KqsdO9KaW+5mJRWYOuFVoQeSVifNRt6B4Y?=
 =?iso-8859-1?Q?V6QjvjHdr1K9k2WF9wu0uo972KzkjQ4fbiQQulp6CvKsfVBCgWfmVatG3G?=
 =?iso-8859-1?Q?JbsMUZV9T6tLKR0Ft+9L1vz/AVMmOpQIOMFcGetDAhmDU9J1Y2lcpqruak?=
 =?iso-8859-1?Q?MpTBoNSP/WskPJGk5gLYYbqOrlt0ajddSFKJ1grsJkNytfMw+xJskLSei8?=
 =?iso-8859-1?Q?WJ4NYxZcjd1/ylUeRr1A91KGwGYRQzReRH1iRmjq89E8gaF4CgVIqoCyMM?=
 =?iso-8859-1?Q?zFfRTFCmBz9kxR2oXS6qB0zQ/1my6OonLpjwGPFyA6kfsDdLTtTWPhYke2?=
 =?iso-8859-1?Q?7qo2IWAVB4JRqhZxdSU5y89B8/pZhqxKW6lgEDjLJdCkXeV/exl5Z68pHf?=
 =?iso-8859-1?Q?1/abytdLR9iiZnFUHiPy9Cr+StF6GVR7hIWQk++aYZ2wZ94G9HMlEkhAJw?=
 =?iso-8859-1?Q?3fMNem8y7vuvEqQU+ojk7XTp8ao7HK1Ze2uPhI/VlOy+zNDNrymv1KQbl+?=
 =?iso-8859-1?Q?INkuPkhzi1baUlY2A3c0uKpGBgDt/gUYLU44v6jg0jrOYC1CCza6v0V+lW?=
 =?iso-8859-1?Q?vU0ElpoDzg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hsBtJcgsSKpv8crMOfUBr9we5hkenSVQT3EDY+oWqIH7kFVQ7KBmtskhC1hcFsxlApfTbCduA+wjyJVgkzKdssaMO21L2em4AR0yvnf+QZBqLmhnJ9ti3HC8qOgTltcKTV2WhzMax8oERD7TzkQszYI5ug4Gx36gFtXgNozHV2sxYh3Kqhba3i3GcO547aEREoxdnpSEL2V9yHX+G1NOJe950uzs/5pGcPgdexQYcXm8X1JOGj5lQYbm3XVh8Lk/mqWNZAfaZW/Z0iqDGebO2oEOjsOBCxdm7IFFLk2j/Fv+oZFTI0+0G+gMygHDxxMoWRv5l9/yBHpRXus2Qpvrxg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a08ef8f-5756-458e-35dc-08df282c51e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:52.7521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqeGaZ4vVYBkavzfbS9Yyr3k/WRgL/cp82Aje5Eg+5wG2mwmJnIe3JnRp+GJ80F//a9XOkVoxqZuZCAB3fHKYci1ROEyUK4D1YY+oDWAdIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the unimp_devs table in AspeedSoCClass to describe the=0A=
unimplemented devices, and use create_unimplemented_devices() to create=0A=
and map them. This makes the code easier to maintain and read. Convert=0A=
AST1040 to use them.=0A=
=0A=
This also fixes a type mismatch. AST1040 used the "pwm" field=0A=
(AspeedPWMState) to create an unimplemented device. It is not used for=0A=
that anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 40 ++++++++++++----------------------------=0A=
 1 file changed, 12 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 57ffc0807a..0b078f10c4 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -81,6 +81,15 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast1040_unimp_devs[] =3D=
 {=0A=
+    { "pwm", "aspeed.pwm", 0x740C0000, 0x10000, -1000 },=0A=
+    { "espi", "aspeed.espi", 0x74C05000, 0x1000, -1000 },=0A=
+    { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },=0A=
+    { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },=0A=
+    { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
@@ -123,14 +132,6 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
         object_initialize_child(obj, "wdt[*]", &s->wdt[i],=0A=
                                 "aspeed.wdt-ast2700");=0A=
     }=0A=
-=0A=
-    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
@@ -267,26 +268,8 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offs=
et);=0A=
     }=0A=
 =0A=
-    /* Unimplemented peripherals */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
-                                  "aspeed.pwm",=0A=
-                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
-                                  "aspeed.espi",=0A=
-                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
-                                  "aspeed.udc",=0A=
-                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
-                                  "aspeed.jtag0",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
-                                  "aspeed.jtag1",=0A=
-                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
@@ -312,6 +295,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
+    sc->unimp_devs      =3D aspeed_soc_ast1040_unimp_devs;=0A=
     sc->num_cpus        =3D 1;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

