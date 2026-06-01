Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8796CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjg-0003J3-GT; Sun, 31 May 2026 22:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsje-0003Gq-AB; Sun, 31 May 2026 22:50:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjb-0002Y8-Gc; Sun, 31 May 2026 22:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piSBh92CvL2m3UzgRD8vPi/y+h+tjnVRVBXZymkTpAXuwygEVY+ic40Sibn1yFFana1/R/2bM1kadHQF45Aiscs8/ns8ldtRZXnO4JX1pIdM9PucREwr556gHN3WfhD6doG3qgCsGZx+s7cvVLkWrc/smnbDsgmZlOps6523O7byVPxVuzkP0ITrEWKwa5sk27QK4OCHhqM1N2fxnGE+zR5myxN1imrX5aT5ZqMX9EVV4gWS94JRIntGT9UxO1didlGxyqTPtI65QbX2h7PLZXMvU9EvGCZMTp5b347Dt9wcIGD2EwMO/HUxsYNxnAGtPlJweQlTiBYJZI32J61sBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMBXqgTWgKB8XBO+4bqW3LdD1U46D4GW2t1IhssiFxg=;
 b=GFLjP1kPLMvJnIfAr44DW72qGKfzCM+9OePfL6RqDnzCH0SzDXBX+6chkaYRKVaYSNNjfB3WAvTxJyYTwkXy1O4GWHA3bLfVkkLU46jhyvsVI2R5ZA3MMdXnADzptuLwvtXvhSroE5+vd+rwaRmDWQDzbuXsc1oY+RTeJ9zCQsoT3GtFItuV+D+tlwAhvH7faPX+i3Fh8dR3OFeiJ3CaXrTf3ctxvpEcU07AtgNrpZ05emTol24ZKDs+WHH67BkCBAocgo78CictByxNlMbZzLIBvrRZu5BtMTH14xANR8JsCo52ssevlZmGNPWK1kYbKp7Cs0SBM7cjCMkmu0jV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMBXqgTWgKB8XBO+4bqW3LdD1U46D4GW2t1IhssiFxg=;
 b=gL1bkVBMvVGUtC6fEAkDDt5o/kQYkE3UDZTieqt9Tvgn81xi6bjtmMsJ6TFurhT4qkGiUF3JQUX3uLIVTTLk1m1DjTyEMfdSskPM1CL7G1eG8lcuar63fAvxpCRNH9RmCS2LARe2a4PV3koENupAVWt3aColOt8C7rm3Q3ZghlSR5Zh2bX42qVzRd6TtnsggKvx9N8KZzN0C0o1nJ+173owst6bts0jWcKaqB5/N5s6F9U7EqSwXxBH202up4rE7/ykmFcWuTyjGX8K7vll0vWk9BgMOOLPknKZojKr4f0CPjReslXLW6LTKcMP4w/lideNXcOxLOYWcrtaGyhEmDw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:22 +0000
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
Subject: [PATCH v1 14/24] hw/intc/aspeed_intc: convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 14/24] hw/intc/aspeed_intc: convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFjQYJQZ8HkQEGygoYsI53uWA==
Date: Mon, 1 Jun 2026 02:50:22 +0000
Message-ID: <20260601024959.2347639-15-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 79cefba2-33da-4ff0-2676-08debf88864f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: W9HcPFXfVOt/fpYPMMo7WFBEPTVAis4Qr/dI+0KgrjAQDqbQtnOvfm5TNvbkTi9KK18n4qd7tLtHMjMJS0wtemKVCBKkldDqS0zf3NGiQWS4xxut3deRdIEU7QWCjW774vLhLbMIhaoaIlmxO438AJRBP6pRFBVbU3JkO6cODk/M/7tyyelsu4GuOudTlPQOKDbf5gYz8GKBStrp/kgYBVLY9y2BIazq1FJ6AuUbP4p/qb1lDCattOTaZNMUJ2fu2EAXBIcAlaaUJRuHfnI92ew/AdRlxgiTIyFXAoHaUvMLI5f/oBOBtbN6jvUBwZqCyiMJKbq9lUIQFmvaLC/gUfu3Csr0Engk73yq9npWpeOiynKT8/3V2ptqP4znJiN+ZGh8YH2urzPxz2Z4Z0nNDZswWiPmKwUCVCVeuBwSbHFQoEPKoCZL6M8mRip7hiAl68coiINios2u95Rg3xAaP0zseIhzweEwtcl8/og8mRiWZexvnY42Qy9ISbp6ZrzD+5C+AsqdbuFOLc/ryXdUr5rBLCA6259qQbHeB0xLtA/e4OkOrqxA1w1qJZlVzgYqO5F6ZHOofRllIOtMRPm6x/BCKVPPfoxO1JUYh75JnEP1r3dEPDLcm8wbEOp2NBF8YQgCcp+tNSYUE7Z7IAoELRMMJ8GxSbpuX4R28704KZxVQtN5hiP4FBamkBuVETqXQ9o07blofv5jxiWVaNySyCuliPLcJU18BxfnQTQy5ujcIqp+gmjVsQCrmRQ5ajPX+VJ29aOImZhFWS/cm7KpmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XvYvI73f7jU5xk3B075kcIdYBOzWx5FCqznN7vehQuWyu209DSMu0xOi5K?=
 =?iso-8859-1?Q?1ua5yXD9Z7z/jaRnE7naTcopMd03hSFINRjZP7oW8APmZ0SsOuqnE3BLmI?=
 =?iso-8859-1?Q?6eT0VaqTz7UoIdk+PKwsplFhmX6qmTnCaERCdqdJMzVME0yNJFRVTVPcY8?=
 =?iso-8859-1?Q?6IY3Xa8LCdVLY14+SKWimMfbYOeat6Btbbt6oDxnOBCkmUM5BxC9F/vMyt?=
 =?iso-8859-1?Q?/xaMIdj54EQfaKPlQIem9dio51l8xCVUi4UeheqymcLqw7hNFNIuH85WhY?=
 =?iso-8859-1?Q?OXjPyl54lOlHEEoDfnIjfdnNqYnM60MvZGtxP1bWLc8PhPdncTIS5sdh9O?=
 =?iso-8859-1?Q?M0R4NP+G72+pQRZ0mIlWWB3ioBevCPcaDmYLph9g13yMCr6x8w7KLSb8GK?=
 =?iso-8859-1?Q?53auCOGXGZ+RaERpzK8+9fYvBNyOZtocuM5j7jdeUPSiwLrv0vQhaR6uM9?=
 =?iso-8859-1?Q?8gmD9JD4KFzaBDFEhRa6pbu9eLHX+jt/odBtJC4DXfBt9C92pvaOOOzbe+?=
 =?iso-8859-1?Q?ee72R9F1deF2Us9OpwRUIemdLrUlzPiJVbY+nG4jHlNp+iDEEo3FweV9tK?=
 =?iso-8859-1?Q?+er/wFfrpcfDL5ynolGfhn3H6h0rSRb4l28lDEhSYkMiPumERAnE6Xh28R?=
 =?iso-8859-1?Q?/kFWLHSu54o97RILuy5MVgGddywq0OeA06l/7i+qp9v89zRqg3DbFl0M1F?=
 =?iso-8859-1?Q?UYoISDSZ/ApqXIbCuFmnLbM3uyPctRZtpMlRzkWgy/ZzAit+rxNxvoYShi?=
 =?iso-8859-1?Q?e4P6aWoKawXR3KZaDzQ/l6ee92EZ2Km4kF+8RA2GOl7h+FVDGGjEVpwg6R?=
 =?iso-8859-1?Q?LCIK+DghLN+8A3jGNG0DGqxsGqYN3O60mabW9b1ExVV1FVlK2vO/5Dcz9T?=
 =?iso-8859-1?Q?CS8KVUAAi9CJ8k0LjS5wVKXu83TVrpUyTGc89Mwy2m76yjIbaE63t2sptX?=
 =?iso-8859-1?Q?Sw7XJ8HyLZoOSfPlGgt5OZ5Yi4aVjLUiCSKpMJjXETPu5ivPlmSn/koakk?=
 =?iso-8859-1?Q?SigxjqyUVx7C/hkR/heAFw6c7RfF3yHNdi8yDMivH0Kkl856H7SnqVtTO8?=
 =?iso-8859-1?Q?IosM3U0fu6uxk7u9mi9ogwS9uYWiu9hjXBcH99YLG4SDo5UOnDosrP9cv6?=
 =?iso-8859-1?Q?2ZlBLQBQ94ykXUuscemAHF/mDSZU3UM/kU4xtTGykaHKMO47V5BDk/Pk+S?=
 =?iso-8859-1?Q?b7iE2WcdS/+3zMYNiyTNkfhMdOQa9z1OHdalzw3Jjc9zVGrJjgTlseWYTW?=
 =?iso-8859-1?Q?/0LCmc4HvnQH2r7j8TNC2TVAzymsNOdCW9XcifiXzFFNyHpFoRMmavLnS3?=
 =?iso-8859-1?Q?qePSXe2n/9tDmLqxlfL9hw6L/vag5vnXyIY8ALEEZ11XGtAN3DZYSVzjm+?=
 =?iso-8859-1?Q?SmVOjoKrrs2gOWT/VNLzjzjJVY4g/5x09wlwaCSVlu84zxEE2qdeNiJG0p?=
 =?iso-8859-1?Q?uqMmMY5aaFELZHtDErXoy7cSVCFYujEtHXf1RN3mU14vUAE+pGP5zQPB1R?=
 =?iso-8859-1?Q?C2txNXQX9/Cy0NHbT3cfwE+gv6dCXysop1TLQEuGJuYr7stx6lUKPXbhIH?=
 =?iso-8859-1?Q?Mvzkv33OwCm9IJdZluiUWjTHeUL296aVdAIYenp408g7EeUtfFX3RIs2aB?=
 =?iso-8859-1?Q?74OmMz5M0czpLfcQYWOxi7ytPH4Fyuvl1M32UYQdxRZnZYnOzSjXU3Kkgc?=
 =?iso-8859-1?Q?UUH++3kNIshr3BXN/WzGpF+2HDADgdB1jivkW75rkHCNXXOh7DaJ9eHlrK?=
 =?iso-8859-1?Q?/eWiSzTdvJ18yICLYaft+jwSsDPCmKb+c7lLCxvKulMzV24eO5bnS04Nd6?=
 =?iso-8859-1?Q?DMGo4wCWIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tu2L4/FvtLwuWHcSJGy6Zjv3mnBv+mcu2z/f446y7AnJbBd8uKFz7uil6UYbGgjR44DHctJbNXwuhmHa++PBzgNrjRwQz8xCrqG65Za8EqXJonCMdeqmj0tPISg9J/jnD07GHfhhh7oU+IEJeDezwa7/Jid+ZaP3ngi+k4nzxWLG/KDSjVY7P8glc732VLGFzv4NQXGaUqMoy3KLXW8XWOQmM1YeH0+GzwIlJObeuKYoW51gl2yjfUjhKAVQkWbZ9f5DVDJ6QhcZlVSlcSLQF6BLtHcEb6BwroVixsqxElcp/DcR7QBOMK0xv7oNfAVvFrV/qf/MG6evNmHL/9V+YA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cefba2-33da-4ff0-2676-08debf88864f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:22.2399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVrwKWGqOwZi2kc46G0ETIy37Gp9iu7QXiWrU1wkGpdkCcv7+A5/7VsRpn5QZkg184ptA6AwyiPUUrW/kihIq6c3oLunOr7GJ7maeo9eVw0=
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
Inline 9 standalone TypeInfo variables (aspeed_intc_info as abstract=0A=
base, aspeed_2700_intc_info, aspeed_2700_intcio_info,=0A=
aspeed_2700_intcioexp1_info, aspeed_2700_intcioexp2_info,=0A=
aspeed_2700ssp_intc_info, aspeed_2700ssp_intcio_info,=0A=
aspeed_2700tsp_intc_info, aspeed_2700tsp_intcio_info) directly into=0A=
the 'aspeed_intc_types[]' array, removing the need for separate=0A=
declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/intc/aspeed_intc.c | 121 ++++++++++++++++++------------------------=0A=
 1 file changed, 51 insertions(+), 70 deletions(-)=0A=
=0A=
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c=0A=
index 3892809430..5a36fff520 100644=0A=
--- a/hw/intc/aspeed_intc.c=0A=
+++ b/hw/intc/aspeed_intc.c=0A=
@@ -758,16 +758,6 @@ static void aspeed_intc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     aic->reg_ops =3D &aspeed_intc_ops;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_intc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_INTC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_intc_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedINTCState),=0A=
-    .class_init =3D aspeed_intc_class_init,=0A=
-    .class_size =3D sizeof(AspeedINTCClass),=0A=
-    .abstract =3D true,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] =3D {=
=0A=
     {0, 0, 10, R_GICINT192_201_EN, R_GICINT192_201_STATUS},=0A=
 };=0A=
@@ -788,12 +778,6 @@ static void aspeed_2700_intc_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intc_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_intc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_INTC,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700_intc_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
     {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
     {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
@@ -817,12 +801,6 @@ static void aspeed_2700_intcioexp2_class_init(ObjectCl=
ass *klass,=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_intcioexp2_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_INTCIOEXP2,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700_intcioexp2_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
     {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
     {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
@@ -846,12 +824,6 @@ static void aspeed_2700_intcioexp1_class_init(ObjectCl=
ass *klass,=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_intcioexp1_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_INTCIOEXP1,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700_intcioexp1_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] =3D {=
=0A=
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
@@ -878,12 +850,6 @@ static void aspeed_2700_intcio_class_init(ObjectClass =
*klass, const void *data)=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcio_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_intcio_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_INTCIO,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700_intcio_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] =3D =
{=0A=
     {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},=0A=
 };=0A=
@@ -905,12 +871,6 @@ static void aspeed_2700ssp_intc_class_init(ObjectClass=
 *klass, const void *data)=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700ssp_intc_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700ssp_intc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700SSP_INTC,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700ssp_intc_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700ssp_intcio_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
     {0, 0, 1, R_SSPINT160_EN, R_SSPINT160_STATUS},=0A=
     {1, 1, 1, R_SSPINT161_EN, R_SSPINT161_STATUS},=0A=
@@ -938,12 +898,6 @@ static void aspeed_2700ssp_intcio_class_init(ObjectCla=
ss *klass,=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700ssp_intcio_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700ssp_intcio_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700SSP_INTCIO,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700ssp_intcio_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700tsp_intc_irqs[ASPEED_INTC_MAX_INPINS] =3D =
{=0A=
     {0, 0, 10, R_TSPINT160_169_EN, R_TSPINT160_169_STATUS},=0A=
 };=0A=
@@ -965,12 +919,6 @@ static void aspeed_2700tsp_intc_class_init(ObjectClass=
 *klass, const void *data)=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700tsp_intc_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700tsp_intc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700TSP_INTC,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700tsp_intc_class_init,=0A=
-};=0A=
-=0A=
 static AspeedINTCIRQ aspeed_2700tsp_intcio_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
     {0, 0, 1, R_TSPINT160_EN, R_TSPINT160_STATUS},=0A=
     {1, 1, 1, R_TSPINT161_EN, R_TSPINT161_STATUS},=0A=
@@ -998,23 +946,56 @@ static void aspeed_2700tsp_intcio_class_init(ObjectCl=
ass *klass,=0A=
     aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700tsp_intcio_irqs);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700tsp_intcio_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700TSP_INTCIO,=0A=
-    .parent =3D TYPE_ASPEED_INTC,=0A=
-    .class_init =3D aspeed_2700tsp_intcio_class_init,=0A=
+static const TypeInfo aspeed_intc_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_INTC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_intc_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedINTCState),=0A=
+        .class_init =3D aspeed_intc_class_init,=0A=
+        .class_size =3D sizeof(AspeedINTCClass),=0A=
+        .abstract =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_INTC,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700_intc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_INTCIO,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700_intcio_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700SSP_INTC,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700ssp_intc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700SSP_INTCIO,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700ssp_intcio_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700TSP_INTC,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700tsp_intc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700TSP_INTCIO,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700tsp_intcio_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_INTCIOEXP1,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700_intcioexp1_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_INTCIOEXP2,=0A=
+        .parent =3D TYPE_ASPEED_INTC,=0A=
+        .class_init =3D aspeed_2700_intcioexp2_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_intc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_intc_info);=0A=
-    type_register_static(&aspeed_2700_intc_info);=0A=
-    type_register_static(&aspeed_2700_intcio_info);=0A=
-    type_register_static(&aspeed_2700_intcioexp1_info);=0A=
-    type_register_static(&aspeed_2700_intcioexp2_info);=0A=
-    type_register_static(&aspeed_2700ssp_intc_info);=0A=
-    type_register_static(&aspeed_2700ssp_intcio_info);=0A=
-    type_register_static(&aspeed_2700tsp_intc_info);=0A=
-    type_register_static(&aspeed_2700tsp_intcio_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_intc_register_types);=0A=
+DEFINE_TYPES(aspeed_intc_types)=0A=
-- =0A=
2.43.0=0A=

