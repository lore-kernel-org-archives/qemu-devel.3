Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E98ECD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsja-0003DH-2T; Sun, 31 May 2026 22:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjX-0003Bp-Ub; Sun, 31 May 2026 22:50:31 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjV-0002Y8-UM; Sun, 31 May 2026 22:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz0OhhI3NKNx/cOTn7UUm4tMwjeqxD6plQoLMGCWNbsxWIE4k1fUcVcmXZAuu6yOxpUV9OZP55hq7oZyQep0CRwUrfE1nQplclO19HsjOn+L6YByRX1GJRuJKWhCuaaoq3HZtRrmzdU3wuPp4oP21VR2ZUCH5IW0OJMAcUruEE38rgx4sWspewvBH28D305YS7c4NK9/G38Hd/lAdBS58ztzep+zQoygGXDF76DQ5+xre5rgYd8+GuE/WPElSg8pVelrqC4/75qW/00WVAKI7oiqFa4Uv9QLiw8SMbd+sOhofpPap7VWBiydzHiWiDaWrldMrQyIFPgRiNw2BALgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt6Ue/ROXQw5ENcHw+1rfVY5PtHbIMRb45cZc5XaWnU=;
 b=Aiilg+LVs4FaO9u/vRBcLOG/U8m8Wnaz42PrC1U7DsagXHkbbhF1a3/38rTzwM+qiaRdssjhRHNs9ld2AUPgl4ia98/DX30mUJD+cFSxSbFPsuK4x7dKLX+mucjexz3JxA+7BDsVbIcDd9MVBSVE5CTRxQGuu3UO3S6iGHuYT6gJjiE6op+YAXQeNEBHX7T9eGITaaxem5hUX5Q/+wNNPnYQZv4O9yGZCa48ageNEbY3tYynMISoJqYticVXH55LUcauS/LsyYVtWEHsfOaVhFCpOO8/LWVYdrN/v2YAomDlAMDeYDpv3PmyFW0LQQg43GHu2PgsJ9M59RJhKOwhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt6Ue/ROXQw5ENcHw+1rfVY5PtHbIMRb45cZc5XaWnU=;
 b=KyQu/b8YcX41rm5s8y4R5vs3gPr+U3RqOTDKItAdDzr0yYfaJl8t/jkFM2M+rzL3UczHtnS6tCt3u86glzstkEujNJlD5DaUCOwnM3QI9BSbImAi8Rtt1vUNxPlbWD59D6klmNeZJQp0huYi8cBKYTDBgtpMIA/DYfAIN+KBuMXrflT4BNTmF4R2IqePS4I81C11vmjh+GbSMfqd9Y3p+epJJZtPCk1EjNDj4nrq4pp9Skx4xpZ5wy4QKwoZ+zPRT14SibXKRDsCfsp15E8FwWZwWi5cmlbgLCIVPTGjif9m5WmDYIa//hUjjy6J7HQRYCJNyWANIuWmFf3O6EYzdA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 10/24] hw/adc/aspeed_adc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 10/24] hw/adc/aspeed_adc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFg/u8mi8TcR0211Vqr6en0cg==
Date: Mon, 1 Jun 2026 02:50:16 +0000
Message-ID: <20260601024959.2347639-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 7e2c60b0-b207-47bb-1f95-08debf8882c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: VPn7khYzEq8AWp8owFUrB0XHK9uFohXLSdvbgp+VlQP8FSZ6I8EcMLhzSTGkBjiwXzUiy0DAlox/Re5Lluna5MbR3+a2PpGM4Si2JREHBmiQsMerJoBtjuMzUhPccGDcMmIH/BW4Ea/urVVNyaojlREECF5MZYsoPjK4hjW6uS+9FNkmhEaA501O1o8oUxv48jFq+E1HMiBWowEPsRdOGUGvI7WGXtWBgVBSe17WmtFdx4ZktRfaNa49UzDUyJ43LewNOmsMNol00hx7Px1fF7HxPlyxqbu6am4O+qlJIC/VmTa4qIRfGJCZT+bpN1GBWEzBolXAlo1KfVDRjQBWc6yeva26DhK+zLad+as5al6fNz/sc0rWSRetXV/7O8FP1w6NPiqXsWibQrjCZNwXvJHA3svOHjUtctdrWleMikMKMIFYmc5xQDQFSMNLK3nORWrgyu429+8ahL5vw1DwMx4Zhi8VDhMPZG/tb7Lc1xrcSA7azWtjIjfMaUyK47DP/FtOvm9dGzMsJ4b9ZXtzekmk221uVUMRe+DgmCXEvAL+AAVcYlQfPLQZA+FVkQ69BMhsyrrH7H3OPa1stDRclI2DX8yQW9R9juJs2MP7aG35hdx9CJsneOWiZ2S+zbqA4gvsR9sJItAdGbrVU/YXl3aIOFUe32EX5i1snydTJc3TifLs3fhCFFv2v6fXlDFjZFoMw5nHlZG+ds75N55VK9hjXiRCf6sR6qUBSB/+MRyj3kINmn5exH/X2y019ut0p3pAYOr3MIfzUQgC0sZaDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?npcsCsqvPGlbcOWAi72lpgqqDDMXJlFfLsJ2vJkKbuwZsHT1d9HGrUsGxb?=
 =?iso-8859-1?Q?ltsN+bv3kKOkTvmYnYR6AB4B0PurqG+4rl76ZlGtPSIuRvCs1o+Et8xX/q?=
 =?iso-8859-1?Q?FbOSp2S4Q6trs0Z588qc/TtdLm24je58RtkTjdg5tGzg7Udhl4FQiq3gZu?=
 =?iso-8859-1?Q?g0Yl6MWa49eUaCHz87Oce3cjcfQgSK/pAx5MTL4rrAbEJ4tGyM4Dem6gI9?=
 =?iso-8859-1?Q?uv35Z471vtOJQb8o+MakZY/56gy1Jtnt+RvtIZ89VcqW43zx3GjT4Q20LP?=
 =?iso-8859-1?Q?Ow8P2iXhAjNv0jF79tkZQokdG97XT1AJoTNHJThD57WaFEWpQ75+4wMI4N?=
 =?iso-8859-1?Q?RIDtWJAOL2ovi4zdrrroq60Kww4jRSuP2WxVcki9MH0hKa6EjzCU9hPpfq?=
 =?iso-8859-1?Q?BA7BeIpklraT+jvMKuFXJojcYeV9UiVNZMwYU4M77i8ZZjQLza6LByWfBz?=
 =?iso-8859-1?Q?msahhvYYNKfQ90I3IDbTKFbYCpHfNJ7oBYM9jo2SBTupPIc5OJkKWEpEJ5?=
 =?iso-8859-1?Q?vHFeQWIbgw6hKRJGUvkG5FM2vK/HMaZA8mWQFzJTsuvv08y7PoZ+9x/FUD?=
 =?iso-8859-1?Q?as5x/6DFDHHCQDuzKcKZSA0DmOAlHBqMLEHpolVLtoc24bJOB7eAjpW8XQ?=
 =?iso-8859-1?Q?Or+MuayIgra03rjofjaQjUg+6eUyMKo7YQByCuLEJp+3VHTSqjL+kaqSuA?=
 =?iso-8859-1?Q?qamGlQ6ecFeCgGqYG8XPPmK2SO5lOVPLtc6oWWdYfYnlCGzZJYFGwN1jET?=
 =?iso-8859-1?Q?RX046Vh81wljWeyfGO1VqOlA3HYt/rxooNEZYSt+O0zF9qIHeTV7kQXEal?=
 =?iso-8859-1?Q?LqUU32VZq19G7S6BnGhncCK3HDCRjEf/3HIoRw69op/G4qs/S15BPZVaBc?=
 =?iso-8859-1?Q?LQo0ItiyaFGcjgPt5NLF5zkJYrWKSdFMiJD0YkwH4EdzPO8PKSs8Ebq//A?=
 =?iso-8859-1?Q?7Hfz2bQOJ/tWlfyeUrj/VEMEhgDbBXzkKcq8CLcQLtUjb2LYW8sYnO4AW8?=
 =?iso-8859-1?Q?iV2VbksVQa4p4CerBliMPtjdekrTDiN2hu2VrjPsP7OlZ/cgPceJt0u2MR?=
 =?iso-8859-1?Q?bwmdG0usas4q0LHh31/i4HPvZlzoR2rIy5bnVEp++i9SeC2u7fUPEB6MsD?=
 =?iso-8859-1?Q?c03XwPWVMIC6WqJJsh2Oc6X9gTkSH/2vHMti1otIe1/BdimxQE1RTz8vX+?=
 =?iso-8859-1?Q?YsOOjJDn+/ESuxYk3TPjk7CgfPg5Mc7mnptjxMNjLSuf+9SbsYgHpJbepQ?=
 =?iso-8859-1?Q?V6Ethx2gJY2cz24eaeCM2Ee9dom1z75zpINAvLH9P1xknMZOcwSpoHFwHl?=
 =?iso-8859-1?Q?F8zJUDUK/LnV0OiyTuvinQiaFuzHnvbt5njrReIwAx6IRS95JLRQ2ElWAK?=
 =?iso-8859-1?Q?aLFYej1+5HP9GLFeAfMOkKT1b2c3koWn6FnjeVkfX2UD3LklC71tg1+81k?=
 =?iso-8859-1?Q?E2iLomzws8oEUBjNKzAL6juzEajLFcYPCP7raNo0YYWwukKPNz4Sh6/0vT?=
 =?iso-8859-1?Q?8XQhGOtsxXpW+Ii2ZTX07YESoowSY2Q+WI7hSrl45ee5QsYalK1O4u2vAq?=
 =?iso-8859-1?Q?8dVzr8cmXcrxslm1dAx0MPi/AhHneBX4aSUoQC63NVRZ9P0lNXjGIhVn3/?=
 =?iso-8859-1?Q?37DKfsDu4y9t0drFEl2YxrSyXSyvCuLYSaaMI3ri4pfVjXy6z0RdhugeEu?=
 =?iso-8859-1?Q?m8yKui7uqKiMxOuvOnCQTKRHSVHHgbj5d+2QFcWyca0TwcnubNRxKKj+KA?=
 =?iso-8859-1?Q?9x0iO7LfVriQl/rjW/AaKH7vgR2d5vsE/4KP0VaUty/fWKS5WkC+/jfHN4?=
 =?iso-8859-1?Q?HjZ0LN5wYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rl21rE17Ekd2t4P6PG5vBStsU1MJFcDn3zIprWa4kZVBHdHoOAWym9rxMavdRHlBDCmu0vrKt3+JKFMVpkx78O/iLxmia2s6bSXhibpoOu1X8nDb8FoiZcPBwbiCWTzhswYLWBbdvFfrA/bm5xiLCRB+p2hZLzSMcB3IiPRhDGPZa2mLdOQIYGKMIqizp1buRLHRfvoIdsxllK3CPo0HIKW23ZtijQCnhydgUx0KtFCrNQhFKAaMfntXhV7qoUkqwpOW2pfI5ON2C99Xx9ZyiNjxGbP6yBspDu/3I5InvF6r76F4RjMam88xrBEpxXKZPkH/+BqEf2Bt2GVYPiDIJw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2c60b0-b207-47bb-1f95-08debf8882c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:16.3046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzxqRenr0ZYLSKp4XOQ6P262qeIX4MORdyJpx+tQUSY2hSdgVdeFjI4FhQb/lvnghEkho9eaCZWcral6ARNE8Lco7YQDN5mT7GNpVlZ3IBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 7 standalone TypeInfo variables (aspeed_adc_engine_info,=0A=
aspeed_adc_info as abstract base, aspeed_2400_adc_info,=0A=
aspeed_2500_adc_info, aspeed_2600_adc_info, aspeed_1030_adc_info,=0A=
aspeed_2700_adc_info) directly into the 'aspeed_adc_types[]' array,=0A=
removing the need for separate declarations. Note that aspeed_2400 and=0A=
aspeed_2500 variants carry only .name and .parent with no class_init.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/adc/aspeed_adc.c | 95 +++++++++++++++++++--------------------------=0A=
 1 file changed, 40 insertions(+), 55 deletions(-)=0A=
=0A=
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c=0A=
index 18b74898e1..70655800a4 100644=0A=
--- a/hw/adc/aspeed_adc.c=0A=
+++ b/hw/adc/aspeed_adc.c=0A=
@@ -304,13 +304,6 @@ static void aspeed_adc_engine_class_init(ObjectClass *=
klass, const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_adc_engine;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_adc_engine_info =3D {=0A=
-    .name =3D TYPE_ASPEED_ADC_ENGINE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedADCEngineState),=0A=
-    .class_init =3D aspeed_adc_engine_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_adc_instance_init(Object *obj)=0A=
 {=0A=
     AspeedADCState *s =3D ASPEED_ADC(obj);=0A=
@@ -408,53 +401,45 @@ static void aspeed_2700_adc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aac->nr_engines =3D 2;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_ADC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_adc_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedADCState),=0A=
-    .class_init =3D aspeed_adc_class_init,=0A=
-    .class_size =3D sizeof(AspeedADCClass),=0A=
-    .abstract   =3D true,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2400_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_ADC,=0A=
-    .parent =3D TYPE_ASPEED_ADC,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2500_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_ADC,=0A=
-    .parent =3D TYPE_ASPEED_ADC,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2600_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_ADC,=0A=
-    .parent =3D TYPE_ASPEED_ADC,=0A=
-    .class_init =3D aspeed_2600_adc_class_init,=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_1030_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_1030_ADC,=0A=
-    .parent =3D TYPE_ASPEED_ADC,=0A=
-    .class_init =3D aspeed_1030_adc_class_init, /* No change since AST2600=
 */=0A=
-};=0A=
-=0A=
-static const TypeInfo aspeed_2700_adc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_ADC,=0A=
-    .parent =3D TYPE_ASPEED_ADC,=0A=
-    .class_init =3D aspeed_2700_adc_class_init,=0A=
+static const TypeInfo aspeed_adc_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_ADC_ENGINE,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedADCEngineState),=0A=
+        .class_init =3D aspeed_adc_engine_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_ADC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_adc_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedADCState),=0A=
+        .class_init =3D aspeed_adc_class_init,=0A=
+        .class_size =3D sizeof(AspeedADCClass),=0A=
+        .abstract   =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1030_ADC,=0A=
+        .parent =3D TYPE_ASPEED_ADC,=0A=
+        .class_init =3D aspeed_1030_adc_class_init, /* No change since AST=
2600 */=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_ADC,=0A=
+        .parent =3D TYPE_ASPEED_ADC,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_ADC,=0A=
+        .parent =3D TYPE_ASPEED_ADC,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_ADC,=0A=
+        .parent =3D TYPE_ASPEED_ADC,=0A=
+        .class_init =3D aspeed_2600_adc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_ADC,=0A=
+        .parent =3D TYPE_ASPEED_ADC,=0A=
+        .class_init =3D aspeed_2700_adc_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_adc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_adc_engine_info);=0A=
-    type_register_static(&aspeed_adc_info);=0A=
-    type_register_static(&aspeed_2400_adc_info);=0A=
-    type_register_static(&aspeed_2500_adc_info);=0A=
-    type_register_static(&aspeed_2600_adc_info);=0A=
-    type_register_static(&aspeed_1030_adc_info);=0A=
-    type_register_static(&aspeed_2700_adc_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_adc_register_types);=0A=
+DEFINE_TYPES(aspeed_adc_types)=0A=
-- =0A=
2.43.0=0A=

