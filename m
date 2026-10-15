Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795D4CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF6B-0005Wm-Mh; Thu, 15 Oct 2026 02:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5H-0004eY-ND; Thu, 15 Oct 2026 02:37:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5E-0006Yb-D6; Thu, 15 Oct 2026 02:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve/mMHggAkzG44JJ5dyUiTrfpyerysCccjlvLgmCerRAndJm5eWFn0nklaY11pjeE5ahUAhtm2k9gDtuaNtGUk4nFsJxaWCQZjAKa3Z9p6VEjS2oLjVFykDgR10Bh7cZDFYC2DUyeGRsE3W5dQZQFzJm7uovPZoMtlg8Hm1v8fhFaqtQYXaQa22QppV0eB6rYm/aBdL3c65A5A20B5GM7hbE2vqEGQ5+XY51LAsiW/da75+yz2udjilHReHyd+6ODw1kT9Fz8L+5o3Fq83whfyb0qZLcL+IXY8UeSYkpFqFou9HTS9etu2IT/noTsTBRoI6zbuFthK92kqoq0S/4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEt+ecPQxs8TuuTXe5VFuWE3qfRK2LFNkOoeFX5aL6k=;
 b=N+V7GiVthMh7VCkgZLAVr3/gbjj2r7w9NaudFNrQfUfdAWECQt8zuJci2aNu7w8JBZDdEUPl6taXW5IBDVt16H1EE1r6F2vEjC6TF4JA98QZt6sqs26AxsPNjQpV32CwZozB/iO/u10QCDlJoga6aK5aK4ztytjfwOF4szDNbu14cLdfzfdG+PcwSjO5bRztNxmCce5MW7By3kd/crKMtRr51X0o9HxXKRn/mBYEp3YPf85L85broJwFYJbP3EdQppvRRCO5Jri7FoXY8tomE+bWtLbQiXMOzUOD1DE6zL6uFka5IwmfSOi5CIir+ct5WED4HWxojaLiyI99VhWILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEt+ecPQxs8TuuTXe5VFuWE3qfRK2LFNkOoeFX5aL6k=;
 b=NCfpfLShfCkXZYjelVqUW/UM3zNzlxgPTfRde/JRMW9jiEeG4ec3QZgfvJU58c7QCCM2rvSL3M8v9q8neoUcdS8G98Gy9mNYgAxW4Kqe8f8vVkqzXA/49aAcMuOWvm/r3bqTSDC1xHRb+tp17KRSky8/98zYOW8jf7cd+qErPBJNOtEvxcYHRYYbyGieZ1FxvHKZ9W9S8I6VaSxlenHAb0O6QbA1zSaxTWNkcT8s3Gjjc5Mg8epCkTgci1YjSzcni+3C8zK0ErT1E3aIp60SL962uMK5pTMbhZ2qOrPuId3PPFAy6phqemveixtYK8zP5m/C7NaTU/kamHdOV8t22A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYPPR06MB8051.apcprd06.prod.outlook.com (2603:1096:405:318::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:38 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 7/9] hw/arm/aspeed_ast1040_evb: Add AST1080 EVB machine
 support
Thread-Topic: [PATCH v1 7/9] hw/arm/aspeed_ast1040_evb: Add AST1080 EVB
 machine support
Thread-Index: AQHdXG+FMkYnBptJPEeSWca1uO3RPQ==
Date: Thu, 15 Oct 2026 06:36:33 +0000
Message-ID: <20261015063625.186708-8-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYPPR06MB8051:EE_
x-ms-office365-filtering-correlation-id: 67ecd7c5-7c5a-4749-6a47-08df2a86aa2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|10067099003|921020|38070700021|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|56012099006;
x-microsoft-antispam-message-info: MA3Qy0JCl5H2/9p4spINjkljIy54zd1lVeBZ2rXv6f5M/1oERBrc2/YMEa9tz0X1XK3l1ROKAze9kCnYIUPC+OY2wyMczm/MXTDTNy6d8hbKDu2NTc/FhtVvz/vw+QJemiMgZYp36rsipO3Pg9SvM6/ifWoQb8AEzTQNP7D2BIIraI6kJv9RJ80eaCiqxuJTZOTmyjagfu9vWQgZwbbzltQXRBotQbStH7l+SxV0hDc0WCwONTLsFKRB2QQAzvXSZxdVgViXh0ZUyV20O0Jz41bFZt2uaVSvEv3jhnIrbXTi3G18+Jy+3igzcIBgo1g08aY7y18EBT6tdhjOZ3JEdpBq+fAmqJvKIdDkMyHBe/qOCVPr22xuga6cEI6KcmRAQ4X7qDId92tg3E+84H/y3PdWWv9zbxNBY9E2fdfeyEqZzs6emkqxvf6cBjbGokJ860JSuQFp8qxCawC6/b2VFvw4lOy7ab/rPUdnzerNpB3w3yttBjq2Of1zX2KVugl/7fV0OTE7Cap8bKmCZW5vkyIlmudQe13F7hg8MCH03iyhti9wRA3w6yAHHXo6cGF3Wpu3UdStoIW/j6CpKRRGHNt2I5OKaAihpUoIr/QsEg30FDRFHrzF1Xn9waC9GPEic2y0FC2oWJQOb/p5u9g2h3KYn8OCl+6aNSTMPWuu4iSqvVwyirTyvXPFSp+s1qe6tvqe8S4ON/vrGO8Os0SyzGsip3hxy13IZ2nTk0KcSgxDUJUbn+yqfv1jNS5ep2XE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8lyLXCnqFXb/m4k7qhOWTUST3RSiIsIHmR25hjdPc5uHYfeyk+aGaD4ZUR?=
 =?iso-8859-1?Q?ycenFwPJJqRLDCuv0ALt2sj99rWS4etE1TuKPYO+odhuUcHSJuRLz81o0r?=
 =?iso-8859-1?Q?AtcC5YexaTChtMqAHLiBzr0/URNjFaoNwioOvO77JobhLCJUTtvMT6T0Fy?=
 =?iso-8859-1?Q?bTKabAhNTaUZOgrEKNFOQ5M5E8yBcFaNnEjcnuPru6Mg6qt71k5/DA/ED1?=
 =?iso-8859-1?Q?cgfHv84atqGMafMwph5wkajXRKS6kNL883wdGtONsTJ/ur1QvTf6DquKbO?=
 =?iso-8859-1?Q?bdK1tYoZJouQS4U40x9eDOXgZ8hBqMadlPwo+feVwTqIG+6PBOx4idVO9S?=
 =?iso-8859-1?Q?9kuDFTEIgs2hfaPqrIX/51lp67/ZUiheyHkNrtW8hOmP9ocxgl0VBtkJU1?=
 =?iso-8859-1?Q?V+JD/tWTLHTujntOuyChQZKtSpGx5yt4RNGku0wCNFOs6mxDRTSfTa3x3T?=
 =?iso-8859-1?Q?BAB9kGLtqxYwPvOaZ7Npq21907dVLLozfnFUPeaKvG0CvOPrEEFUtWRMj4?=
 =?iso-8859-1?Q?qGxncTAkttV0no2s0bzXVwbHOr4U5BHtYCxnj6oGCu+uO2ShEqIQQJxJPw?=
 =?iso-8859-1?Q?IWqpLn5Z/ksTj7IOEKC0NOWT1RnqYUCdUUCvRgDK5KtnGy8t8iZ5y3KkuK?=
 =?iso-8859-1?Q?Atu+yrV0yKva9xbSr6FjJnRIFUSMHHjMaEnRlR7cRFnEWkdx2kjWTMCWd/?=
 =?iso-8859-1?Q?cmILRGWRnk0JvoO6l92gTs7hn5IKpt9EXnyzuqv66vq5AVtt1PRBr3bYg6?=
 =?iso-8859-1?Q?4jfz8NqpiZr20dHu1R8ntyF/79ZWCcBSSrZDMO0a7GOw+RnXBFkppaVwoR?=
 =?iso-8859-1?Q?sAPuO3diTzU8Mf1xYX6yl8rJOfSYZggz+/dGz0tSyaNYyJcl1pqpDyT2Vl?=
 =?iso-8859-1?Q?CIsFbeVOIoROsRdGXmLjsRwEEp1mJvLilnDVdq15S3Wh0yrEeOaLwi8mHv?=
 =?iso-8859-1?Q?261p7FLAlDgM/QuYIKhhh2zHM9s4dnYQfNJouISdUuse9Bm4rmwxgdKUby?=
 =?iso-8859-1?Q?qYrG3Vv2h/hg22zmxdhNNt6A8/mF1etS24FD6ycJWQakqtcrUg1ALsFsFt?=
 =?iso-8859-1?Q?4sYF2CLWIBBCum+moysQgPyAqGIlHZntQiqNBuvVL3WuSna2Me8wxlREDM?=
 =?iso-8859-1?Q?ubqXGQhvsxusLSqYM0mTSVAslr34S8rL2t8bWq8sxHrgiZ/Ss/AJFp2IAf?=
 =?iso-8859-1?Q?PJS/+gbOBzkGsxMefvOF+G0ZKTaJ+D1zYgjFkO2ZYm91OIl/40zZuaVjqL?=
 =?iso-8859-1?Q?iRImKyrg+V5OmfwuVi1vR+nr8FwXbAw5Oq4XSU0SeZBHCUF3BkwPDv9FIO?=
 =?iso-8859-1?Q?PAHbPllhHqumW2JvpJmgPczxW4GVZMiXZp67U7+4w2aJYND+fvvRXFJwgL?=
 =?iso-8859-1?Q?XO7I96peoCfx11u6nPie5Tso4oZAx41ky/0/Jb8go6EKQLOfczaENKRoF3?=
 =?iso-8859-1?Q?XfW+9rVwyZfU+0DA9CxjEce8QTDyoCnChR3HL8sFZ/PiqEQBvhiWyQJm+X?=
 =?iso-8859-1?Q?yjlFMy0z9qCboKTLQ39uyR49Nmc9leN25CrPTiszaSTVdH558gdUSNFkyy?=
 =?iso-8859-1?Q?1pwzxUJBRF2Vi2LlqGRm92zyfAL4kxZAEDRbbN+JLHGZCRd6yNc0eL+JL+?=
 =?iso-8859-1?Q?NSaOIICcMmfb+PNk3wIv897ByrA1ghGDFV9+GucXW6M2RVRD2sq2OShqo9?=
 =?iso-8859-1?Q?n2ufrU0+jAKGWnwoGgdMnAaQG2JK8bNydgvmOxf9Rfi8bjxEK2amiFsIGQ?=
 =?iso-8859-1?Q?hxLNsPoeMwkd2ksBnQg2Jph4LdzwyjYW8mEz2N5d3cGJ1ir/A1brd8d7VB?=
 =?iso-8859-1?Q?RLLY9LfIPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3qoer5rHZSQELPDsvy8AtMxTSz9P7RiwYd0RAH5kGUym59cQqLnfLAjYkNAtvVpPBP0L1eYRfYLcyyHmJPJShfPPuqOs2VKWKUYmI8a1dR3MOgc+GdBhXUyl1Ig41R3cpZ2BKEYjIguk7HInsIh1TGQ4CijqGQQx43fzMpKy4qlCQtragGQ6KpCtaLFfCy9EXcq9y9Z5e+1J+8cw9i8sHYEoN1ZcXqWPaPFN3sGaa3DKMRTQ9efzIdJdZ9WCUl40LleXzFIEb0bVow2NZ991I1QdncQbrPWtPw0irl6hsoBpKiiXxh6PjMHFQPMHI4ZHtYM5J8yuAUFCSdfVVEGWMQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ecd7c5-7c5a-4749-6a47-08df2a86aa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:33.9684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqkvLQdQpZ/6arrsEajIVFlWaMHQOEl0C0zVqQJAgOSSf6M3xaUtrWYySyWz7AfoYAxzn4NUVQJIE0aok0ixpKr41Mx7w1tXpGViIpa3vUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8051
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

Add a new machine definition ast1080-evb to support the Aspeed AST1080=0A=
evaluation board. The new EVB reuses the same BIC framework used by=0A=
AST1040, as both SoCs share the same core peripherals and controller=0A=
designs.=0A=
=0A=
The AST1080 EVB machine initializes the ast1080-a0 SoC.=0A=
This enables QEMU to boot and emulate firmware images for AST1080-based=0A=
platforms.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 23 +++++++++++++++++++++++=0A=
 1 file changed, 23 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
index 486f0f6a1b..9da8021653 100644=0A=
--- a/hw/arm/aspeed_ast1040_evb.c=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -75,11 +75,34 @@ static void aspeed_machine_ast1040_evb_class_init(Objec=
tClass *oc,=0A=
     aspeed_machine_class_init_cpus_defaults(mc);=0A=
 }=0A=
 =0A=
+static void aspeed_machine_ast1080_evb_class_init(ObjectClass *oc,=0A=
+                                                  const void *data)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->desc =3D "Aspeed AST1080 Platform Root of Trust (Cortex-M4)";=0A=
+    amc->soc_name =3D "ast1080-a0";=0A=
+    amc->hw_strap1 =3D 0;=0A=
+    amc->hw_strap2 =3D 0;=0A=
+    mc->init =3D aspeed_bic_machine_init;=0A=
+    amc->i2c_init =3D ast1040_evb_i2c_init;=0A=
+    mc->default_ram_size =3D 0;=0A=
+    amc->macs_mask =3D 0;=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_ast1040_evb_types[] =3D {=0A=
     {=0A=
         .name           =3D MACHINE_TYPE_NAME("ast1040-evb"),=0A=
         .parent         =3D TYPE_ASPEED_MACHINE,=0A=
         .class_init     =3D aspeed_machine_ast1040_evb_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name           =3D MACHINE_TYPE_NAME("ast1080-evb"),=0A=
+        .parent         =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init     =3D aspeed_machine_ast1080_evb_class_init,=0A=
     }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

