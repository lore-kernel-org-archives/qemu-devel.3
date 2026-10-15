Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20BECC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5t-0004vf-Bp; Thu, 15 Oct 2026 02:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0004cu-N9; Thu, 15 Oct 2026 02:36:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF4x-0006Y4-W7; Thu, 15 Oct 2026 02:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3fmCqU2j3bKZSMt4TKaJ9+brOOykjCOX27+6gnSroe8vbLFoo7OvVr305phEEPBq1gLwVXgfOI0O1A9wrOaOr5hC4BHIRhBoDgUScN5STCgm03TgsPv7Zro13HDQ/GQC2u2IIaOgPSeeQYXN1APVJZSCLT1LgaUTENKT3Fh6GMpu9g3i3kkdWYoqkXHYdva6ff9xL04kt9CErIz/hDtnev2JXcreqDoKaUqrQwE4Z/af9liET69LyHtG8UrcE2SrgpdL4bZX6GlKcYOmNrP2zVDFLxTFw0T5u7t7nSgVYLhNZMkYtTTBONuimL/hLzw9cf+DWVBFdAEu1hKUtFIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLeb93mluW0tfAb06+uzEG0Ii5eotzno5vMYsWqY/SI=;
 b=JjXBMfa561HZ/pdS88rFelojfvAMt9Hq7jm95gXFSfeX3mLpozToVyDgbYJHwPuZcZzumW7FpcX7fW48rKPbfnn5Bq68MDeMtO2jBQiEGOxqYL7jtRSIrMngSaHXx4Vc5uuI9XnIa3GEIqFxPF5gFTjlqby2S49B8TXi8fET7UrRAiz3+8+px+ilxYlNw9b+iTJJGgUcusuYwMQFd/GATl7SsaOXNGlwg9N2cDDgXC0vDAazs0p/mAwURHbqB9a5+7YC0nTfXG41GMyIvvdK7Sj4QZeMHjzV3EkQQvswp7+gI0HpGPZpsErQDQJwFCcx+O69JidqMWX6Ex2rwmp2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLeb93mluW0tfAb06+uzEG0Ii5eotzno5vMYsWqY/SI=;
 b=YffObNFaOxzXu8Oe2cfEspW4CHPORaZhLeOxUlgAD+jMq8KD7vnHU7SaF6ToBaVaaQ6+nziphUi0SrSPr/wGbq7hWU9n7Mq60qLubdEe2+kSbWtKJ1wQweRRpeLv8iwwh9cLPMJPztE1bWAn7/wPdgzP81VGGudeWaBwe3z8KlRmjyKhywCLN4O0NZaz6HxY1TqO+VFcRh+aHC6+XkjEcf6bHILPcyV014NQeo/+DjzuL3UZt8L8j9+8FumAlo3Jb1jJzQOAmP6NN3F0XlWjypFzXRAh8UNbxbA511mttM43zI1AxHuAdzTcu8wt0s3m1PkpSoOL0b7P9CEA68z8mA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8944.apcprd06.prod.outlook.com (2603:1096:d10:88::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:33 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/9] hw/arm/aspeed_ast1040: Add AST1080 SoC support
Thread-Topic: [PATCH v1 4/9] hw/arm/aspeed_ast1040: Add AST1080 SoC support
Thread-Index: AQHdXG+DjCguOhKjGk2HEKtC83yx8w==
Date: Thu, 15 Oct 2026 06:36:30 +0000
Message-ID: <20261015063625.186708-5-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8944:EE_
x-ms-office365-filtering-correlation-id: 802d034b-d4a9-4829-bee2-08df2a86a710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|38070700021|921020|261009223027099003|261009221227099003|261009220027099003|261009223327099003|261009221727099003|56012099006;
x-microsoft-antispam-message-info: GpY+MJI2Tp4XmETwPxM7rqPZ9QIvDLHho0YC3j+6glNUTKotRH+XCDyBXjKO2xy8Mrq9wgXUKIRyuGIWnvmwVEo+7VUQE4epeZ0RbZaBqAG2Rq7lDJurPb9PG5CHCyqEwoRWIQLHGEIpY5ofFvjauioxrSuVAy3Wj1y4xk0FAa5knh1Zqp7h1JUrGTAHyYoZuvj+lxVgL9OkOOiIdGJrJ9ZxAm1Ts+uWN+lLRW9/cKTARXnfKFYr7qjBKCcFCS+vOm9iBvpAkGHvS/iJLsLG7F1i75lvkq19Xr68uBOxr0mqvNouOSo/lvIu2EpU7/4BirGk6LJRSpfwp786NFeCZ2x5ToHbEGHl47FzPYeWqlRtv5SlDJD2XvZR0/789IMuVdrK5EThZ9PImh6nvg73/bnLq14XOuRd5TeFUB5wcH9RfDUc/0A1zZrYM/aIzSVP5YJrJdHOrKGTu6exMH55yJ3lpXle9JjWwswpm8r5bsoPkuh/DDGDePyMSaJs9vMm75Sv7vElS/ogaawnOiBsnC5XWXWQ+Awv0dc8iZWlH1K6uyWhrZVgzSCAosNMdTHWdkwRUhWPHqvoqUyFwJ27yJLJupVXkikarPjDz2QhNSu+iMX+6lyP3LlBUxXoBeRhxaFUWPJEmNuHAX3QPaJ37e7lOB+9WdraMRB6ZOuG4HNNA3Bpd6qYQqZqA9SF05HCrmxWADGJHTpstUFu40Ejv9tp6xnvE+SL1S9FrWC0NA7w7SQddUc4m9E6O2RwFeT6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(921020)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009221727099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZjDc1LNsuHcayIKFhLXkRFtbxJ+UGYG2wiNe2q9CFn6wlOalsnBMEPPdTu?=
 =?iso-8859-1?Q?MnbmkjSRav7IU1ejTzSSBN61wTvACFKjPJsRegb7GXhac6ieNNnSgeNs80?=
 =?iso-8859-1?Q?rF7qBUGPP97DIuP+5ocWNwgRoOgPMal+Lh87li6TnFlHr6M+CsDUMNusM9?=
 =?iso-8859-1?Q?dl2WtVLp5jPiPGwJeHM8KTvXPSFiOJNUvfjUFnhEF3vuY2IutnbtT89G+i?=
 =?iso-8859-1?Q?OqjxXrcBxqj74homt6LTbP3CCx02Y9818TIpHnJTSt9yqSThlgHAlgLDnO?=
 =?iso-8859-1?Q?/3bZQIchMPBEAtfvTr90wSIeeHkAar/LGoAGODlbb39DhB6+cDn/koggM+?=
 =?iso-8859-1?Q?kgt4flG207iAPvScaf4wyrqcBMhQnHtEqALT+9lDpRByKFMJvi3lwTb4G5?=
 =?iso-8859-1?Q?ZNdv497YqpWNKLD/XYoGgtSYgFJNo52ITvKLZ7ysCAYs49hlEZGxa+8AtO?=
 =?iso-8859-1?Q?fUquW42YlyhJo8QgLuDI3XfGynYLhEuBsmPxEPXcV7f2/wJfwHdAKmr5Vh?=
 =?iso-8859-1?Q?sRYYyHL6sYERrVtMLMUBKxSzV0YKCV7Cf3Y7Gb70KUHwyVMmTXxfrhzjkc?=
 =?iso-8859-1?Q?vILaiMdnITwnsZHcZ//K3sObW/Jtl/g1yrneqGpIkWFuBoAgQitmmdQ2X/?=
 =?iso-8859-1?Q?6mPIQtTRwMoqgTo8DnykCFYFwMfmtYqM59WkRgH0dn6EYFffMPRSV/zcOI?=
 =?iso-8859-1?Q?q9Qp7wnsSqCmS2Edpc4EeImc8w1OGuClkAP0HkX4nreBMrVaqOYzgrlHd7?=
 =?iso-8859-1?Q?POOLZiDqaw2dghnf0O4UOnahJwZJZxHzVzTsmPDHEZo6YwtWvmvsbT4FLy?=
 =?iso-8859-1?Q?GvYb+Q8WhAEwvqJMj7GgS3omf5JFM9k4qSZBcQ4kNvSnz6+loWeZdHhFyi?=
 =?iso-8859-1?Q?xLMxp8YvNySRn4rS7CQ9xfI1eAbFxwrvyKr13fKnVlNHQ6xmrbxKqoydwK?=
 =?iso-8859-1?Q?kD3g55bchMxVOjnY5rsspJ1WrTe+hFhDVpx+zT8i8P9EY5sg3FjLgtDxdr?=
 =?iso-8859-1?Q?lQtBNA/l5cI4f3pEmJuvwbp9iGgggMKRkh7bTp4hWiryyxim8a8ZrOt52J?=
 =?iso-8859-1?Q?3mW0VU2ioWr0auYXo6p/SwzZBIS0egLjalUI5lVTwiVvBW30xh6oUw46Oz?=
 =?iso-8859-1?Q?t3+jyaVVUkUneFLNTmL19NjdLcAXjZ5R801y7QKtxFlP9BBTu8XniqbnxH?=
 =?iso-8859-1?Q?CFpw4diyrMkGN+1viZ1zl/1iGsaHAZSxDJbLThHU7I5ef8R9/06yXRce5U?=
 =?iso-8859-1?Q?gNZZbHzOzcCGY+5f48Xpp/KmWtlFdksX+0ojxCHD0wyrzAZhAyXmg07tJ2?=
 =?iso-8859-1?Q?laz7Wchgbt4jEdCqwRDwC8qpACFuY1uZmeQmdHqC41cP2PlzxmhEw0nK/F?=
 =?iso-8859-1?Q?cyQWd1elaRAbum4T6xKlSqMiZMIN85VYhLpzYfiomKNR/GOTQzHIRksLZl?=
 =?iso-8859-1?Q?Ex8M7KTh1nHRN7Efr9pCzXLm30zVKoz0RJtNbEA46PSPjcPQgN2CBaErHk?=
 =?iso-8859-1?Q?DDrnP2VkLeWj/NGJXPj1LTfALyncA2jUq8B6h4TSIW3UkBxxtUvhc/Ng+C?=
 =?iso-8859-1?Q?Kt1HkN6bJjAph+MTyvL7iorYXxkmfbmydnORIodvXie6en4O5abNX+Xkra?=
 =?iso-8859-1?Q?GsPddr2P6F7dav+fXWbsQqA7CLJYy4Zv/brTNheBJBJtYx8HufgV9fXkcL?=
 =?iso-8859-1?Q?XlW9cSepWfXDs05VcoRqw+F3ZenK2Q73Nsq//v0I6eIxnaTInEljiNe3fG?=
 =?iso-8859-1?Q?13ne2yHJFhYRvilAbfyLfrxLBt6ktB7XeO1X9EsDSvaOdj3r09kySoUhs9?=
 =?iso-8859-1?Q?2h/i28JBuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uHr/x56LGqedx8iQDQK5m1XptXz8JRIzSQcYuM2DCim0FMAf5NY/glcKkcgXhIEl+67vuSLEcwz8yPoY/6HSTLAir8Na4U9RQ5kFRjraepscJMpHsT1Lx72p9cpchu7xFNET8INzJ27qGUXFYLwxtbUrRm3Eq7FLLxJq4hCMhq3cD7dD7kZnMaLq6ZfiaaiGV6cBoiBtAdB2e6TuW1xgJd6QSnlPQfJbrvJ8gk8uUuU4ta1FqzteToeFhU5YVXzZnk2Ay1Ld1T+aHJcD0qCPkhb/WyiiubtplGfgs+PD+x2mG4CRbkByNziQvsXT+Eb03ELtTmDctAtZgMoNIG8NyQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802d034b-d4a9-4829-bee2-08df2a86a710
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:30.6078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 326BAH9Aq8kXgJMw2wCU0+cRtEMlKE6Pfx9njzhJ1qJvt7dpxIa2EVaaWsh5goMXz0Uwy+Q7qUjG1UKep4wJ+d7i1SDJ0JKXVn6+Z2enT1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8944
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

Add initial support for the Aspeed AST1080 SoC. The AST1080 reuses most=0A=
of the AST1040 peripheral device models, as the two SoCs share nearly=0A=
the same controllers including WDT, SCU, GPIO, SGPIO, ADC, I2C, FMC,=0A=
and SPI.=0A=
=0A=
The common initialization and realization functions,=0A=
aspeed_soc_ast10x0_g2_init() and aspeed_soc_ast10x0_g2_realize(),=0A=
introduced in the previous patches are reused, so AST1080 can=0A=
instantiate the existing AST1040 device models without defining=0A=
duplicate device types.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 47 +++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 47 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 28abbe7010..c641f84fbe 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -162,6 +162,11 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast1080_init(Object *obj)=0A=
+{=0A=
+    aspeed_soc_ast10x0_g2_init(obj);=0A=
+}=0A=
+=0A=
 static bool aspeed_soc_ast10x0_g2_realize(Aspeed10x0SoCState *a, Error **e=
rrp)=0A=
 {=0A=
     AspeedSoCState *s =3D ASPEED_SOC(a);=0A=
@@ -342,6 +347,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast1080_realize(DeviceState *dev_soc, Error **errp)=
=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
+=0A=
+    if (!aspeed_soc_ast10x0_g2_realize(a, errp)) {=0A=
+        return;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
 {=0A=
     static const char * const valid_cpu_types[] =3D {=0A=
@@ -370,12 +384,45 @@ static void aspeed_soc_ast1040_class_init(ObjectClass=
 *klass, const void *data)=0A=
     sc->num_cpus        =3D 1;=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast1080_class_init(ObjectClass *klass, const void *=
data)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(dc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize =3D aspeed_soc_ast1080_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev     =3D AST1080_A0_SILICON_REV;=0A=
+    sc->sram_size[0]    =3D 128 * KiB;=0A=
+    sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
+    sc->uarts_num       =3D 13;=0A=
+    sc->sgpio_num       =3D 1;=0A=
+    sc->wdts_num        =3D 8;=0A=
+    sc->spis_num        =3D 2;=0A=
+    sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
+    sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
+    sc->num_cpus        =3D 1;=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_soc_ast1040_types[] =3D {=0A=
     {=0A=
         .name           =3D "ast1040-a0",=0A=
         .parent         =3D TYPE_ASPEED10X0_SOC,=0A=
         .instance_init  =3D aspeed_soc_ast1040_init,=0A=
         .class_init     =3D aspeed_soc_ast1040_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D "ast1080-a0",=0A=
+        .parent         =3D TYPE_ASPEED10X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast1080_init,=0A=
+        .class_init     =3D aspeed_soc_ast1080_class_init,=0A=
     }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

