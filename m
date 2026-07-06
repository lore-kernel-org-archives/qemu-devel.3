Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68538C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeys-0004Qn-Co; Mon, 06 Jul 2026 04:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgey2-0004J8-Ha; Mon, 06 Jul 2026 04:46:25 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexm-0004bJ-Mt; Mon, 06 Jul 2026 04:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5kdzznajawNa+/ZCylJL9H/gxtOsN6AugJtAnxwPi/JxSYYvy3i44Bg6F1pkpufqyUC6glaYzux8qnpEDROAy8TAw4ug6JEIcSEflzlxQzE0mhkAmVaXUUJN+D4vvRZfxvdDgMfRKUC9pwzxo/DFPw8fldylzsBSXFTf85S5Msb8WnNnXmjnoqUBlbzEiY+KqevgYOOEKOmWO1zEyqCuVZ/leV46yJaMf2YEExi/8QRv5ddrfve4TbGJBh2CseqV4C4pZo2B+Dg0XzgqrDQ/4klK0iht2LJu3EnaCAfwZNQVkpaMbaTbbQcDL3OtibwhITpSzHeqULoCeMSZh2syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SJdgXrVVKGozOG1z6Gfjf/h3vp0XYDFmNqk/PxwYlM=;
 b=kiIxszkgjp1kBQnYefsRfkJqXtFguo4Dofnk0xbYq98aj04cMxxPZ2GbBTJnXIUqKc9sLBMGGK1pXlx4nFmdFujYlrk4ig/c/kLDrMwxn+9Lbw5xZyVai4gHN5GjVB5Wh/BojzxkRCcBFCUsdWz5kHtP8cMVorUPoAXeKfCDiFhRTh10CD7DaXwRrOg2j/+SZcX6I25XybpgIklVpW1tIsYeK792JQiIrpb+vY/EVcwu2vNsZfzoIR3l4ZzYZ472caBtH4izeA0oSsXmCjayV1hxcWXU7PUmfAJbCdhvrXxaFPRJy62y5EY/MOe6E31K199GY1GEG4sxCtNxz93ziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SJdgXrVVKGozOG1z6Gfjf/h3vp0XYDFmNqk/PxwYlM=;
 b=eXXQ1Z3GNvPORXJ2Zs2qFy/7NhkTlpxpSf8g5jWQ2EgAEH7ZF+LYoe6YBrTbADHlQlOvm5KcdNHmusU4hA7VShNeYNxTEWcqBP2xVD4dZVAj2zJmml5FjQMjV6tPJ7MsOoutBTz3Lv5gjFPeOkocPvQ+VgNpQ3EVQOabsYTnbMB/iM7pCJtfLV/NVCHDDLMCUahat9sUiArbSD5noC09sqe5T5IXapzxXNLHDM9tihet4VVh3EIxApYK/y0LNuGokc5BfVvxWIx9NLf6szTsosuWzDlrA/KohK4zwt3LTlUmXQoSgn+KDN/RcGHjkGOZlrDIP0xwvM+gcprKN5tmlA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:45:46 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:45:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/4] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Thread-Topic: [PATCH v1 4/4] hw/misc/aspeed_scu: Add separate reset handler
 for AST2700 SCUIO
Thread-Index: AQHdDSPWrkZvoV9KiE+QvT9fW/hI7g==
Date: Mon, 6 Jul 2026 08:45:45 +0000
Message-ID: <20260706084540.1988785-5-jamin_lin@aspeedtech.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: 0388d37a-69c4-452a-fe35-08dedb3af8b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: Y/Ey27PKax4ckkWK2m0j7AEcXBZP4stNP02MxyJiQwNCrRYpLKsED6U227JZIzaamjUUs3ctOgya25hT/XflF5/U0IAritKYkM/1ipF10Sy/noKy5JbL/ClQ3HKd2Zt3Iu+pdSgscsWjfpot0rAK1PUAHiTe/FXlq+PM7wd/4NNwGavtftHZ8unUB+l+OdFaEmVpbHAH4433GMxF2j1E3eJ9fJKAxXokCDRpqe0NoKDzD6nuHT5+gl2C1Zt6Wk8HEhagm3nqpbxpzgCy7QSr6mq145DHsYiIo5iUn/owN1mg9BvRuifxVI3/5aabT5OfgXcvYPpyLZ7qbiJMumsqJzEglKKybwTV5TZ/VwWOV7wk9SPnfBByFYtdc3ssriKIF6Hhv12DHI2TkIlVXmZPGsOEs1hoxZhr9gui5yD/PhwKgHpzE38NthwqCCKe/qTgQ8F57vwd8Y3e36U4VY8q0hhSfyOJ3I0L3Dwlg74vLsLuTUCWdxw7A8Q5+bzs5OLcPZ0tBpdn0vTvHCt5i6A0oGljCpO7OoTGOvlPtMiwF4RA5n6IQ7wcQWLQFIFL7ArJXxPJNNb9ZT0kQsG9DBvjD5TwyAeDuzZvqo2Gg++CnQwPSl92j85lFAIs1Ev7By+I4SyakwhuQf2xVFMyvKJ1iTE9DdueIJDfboodjbjl4D37U+VJSapBjDOUvUSQ4gloIFxRBuGog/TKVe0jfycXisvoJeLKGSk64Rs1ol7/VfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RnL7RowHYea7wF9pFwnMvSnLBMKK2YgfZXoh4JNIoZy7lpSpD1bAt+b7NV?=
 =?iso-8859-1?Q?IBe18oIAoTlDaiYvKVgZswpzOUQE56ap+P9wLU6X3Z5dx4FWsLabQ6EUR6?=
 =?iso-8859-1?Q?X6ouTaVuO8v+VGhIdOIrk2aiHlGZqLAWY1YqhyzQGNT4QWvuEUlXiN0YAN?=
 =?iso-8859-1?Q?QXAeJTWK9c8R7zItRYcDnI1InC0RL9NUmsk7Wwxyvx0xJjtdXGgF+WayZj?=
 =?iso-8859-1?Q?+tw0K+Yh7e1vKHpONM2fUwttWGi1FIV/PqYfmBgyuzMcSNF2PIiqZzW0UR?=
 =?iso-8859-1?Q?XuYiowMJDzOjYQp6TGu5bw2H2tlqf2UnIGBqBLjG6H+X2TeQbpQlLKlgj/?=
 =?iso-8859-1?Q?uwdVHL1AA3S7xUeQDMAK3ZmW/1AdZsEpxQDABFNOArMkDS0/SsRlvnrS71?=
 =?iso-8859-1?Q?Fh8XvwRJ/keAG2wdFkYoxq0gh4a3axeJpEfs/kttI0FTEZAf9YMe6tHuYI?=
 =?iso-8859-1?Q?mlZq5d+8ppR4dmQpR7U0NhmWmobKAenlg9kzMBtUkrgUqviwD1dP8A88ry?=
 =?iso-8859-1?Q?PNi5D1r4rtfuC9hKabIHtgSQgMV9dTZN2+Q5+kj+UXywoZ7FM9I8Mar5h5?=
 =?iso-8859-1?Q?jserDHjbd80njU7YlDn5c8LJ7pWhbcdWmOpznEKSjPhOPjZYCcZXXU302c?=
 =?iso-8859-1?Q?qV9rEMXAtzCmpZrlGMLt1y9A2jwessnnFH0Gv3YVv4+iCeS+LOuyH7N5yO?=
 =?iso-8859-1?Q?/OusWxQtR794TsgNS5HPyGqj0L8p7rf8NLsaxRTN6eLPPu4YSsQrtH4sWB?=
 =?iso-8859-1?Q?oH66GbI8BSNBEaSYieBPdX8ozlI1AM5GFovqdEtukdEiXdil8HEfyOHRmg?=
 =?iso-8859-1?Q?tIw5QpsbH/miaNb+KajZKKMNPrLH0acRKQ23a36njVExYuzTgvmcvtSCvh?=
 =?iso-8859-1?Q?6Knc7Kp2xeNDNb1q+1rWuhrFfU5dMkEchkNwJqsXbKnPE0QL/TVdutQq2n?=
 =?iso-8859-1?Q?R5k7vx4e5ux37MJg7W07csIzaLQQ46lIdwfrnUQzJxBhNpTtSTA4gOZLB7?=
 =?iso-8859-1?Q?/Jf5+IIISimnJdH+BASVwFb0aIGEc4/qCu3oVXhNZpSK2/406oTb1Pb3SJ?=
 =?iso-8859-1?Q?FLMheqk7SGbxxSSzS+9r1NguejFYc7zotUhm1aqElQQXxrRJMkHOq+Roeo?=
 =?iso-8859-1?Q?SDkbTf6XKzO+fn3l7K8q+sgS9rxqNazvmw9XS/XVMTcmIXTW/JTKIcGfuc?=
 =?iso-8859-1?Q?sweaVUH0AwiPz9U/LAdYZoXn0WIXQfnQ+CvnuhVZ2ICq3NoZaAwOLzeGrI?=
 =?iso-8859-1?Q?g07RzWhqp5WJ5sKKOt9O+XSukBoxf1CVQa0T63E5XpiyJfP314dHzLamFT?=
 =?iso-8859-1?Q?ifWRFiGXb0PwGhx9b7W8FgskiR4gbQ1GW7d+dtZ47IKFXdcEaZ//un++p3?=
 =?iso-8859-1?Q?UpOmlbO8yJMyCBFAg2gGuPJ59obpXLkg3UGuQK7586mXdzQFglxZxeXVwT?=
 =?iso-8859-1?Q?O+0une+ksAGGF/druUR4cyMJ012dc26HVLbmXEj6u3eeAbNJ17R7iu7wrX?=
 =?iso-8859-1?Q?Yv9HygmEisP5CB7+tVxfdDVSq7t2cSHst+FlITscoqHTrkKpWnNbmUlJZi?=
 =?iso-8859-1?Q?DGQMjY2c3EIxXh4N5gU1YIqKyV0G+8AkPfx0t0du5aWwbVALi1r97iOtkv?=
 =?iso-8859-1?Q?XPRyEULfiGBUC57k8GVQCQpmHeBywqcFY4bWkO0NyvteuBv1MYMMlpfiBW?=
 =?iso-8859-1?Q?8JT50Ki5/UNhNRjoYB9tW5v2bR5qDLBex8oqTYLqILeAHAe9lCLVNJPKjg?=
 =?iso-8859-1?Q?/D2RbEG9cfJVbq7X6J/RN3rJ+Cc+9pNbOcgEzOSa+0MbdrJwKvuq9L1xnf?=
 =?iso-8859-1?Q?EVntooncww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eM1uxkpz9dJI54MFfuhkwG8K36NRkvaHySucWnJplHbTfDoud7riNClAmUk7uue15eqSDi5TGkVvq++AUtoizrw97qcQW69lOhswxSJhb8jgeO1JA4nj1dTyv3LeUgd/OtnCFNwak0QtpcOb/O5FZrA8t/cu/w6fPjioHLQvT7kbZot4cJeOpX7HFsWN+5xi0dY7WAj5y7XP19adYoqSxwQzK3KI1rdK7adavmfcUMfS1xAM4IFzcI0ECFwqGeqdVJTt5xsJN1wyO8DIlXuWwORFCtWvtiTvUBUI50a55GDxDolievIdjtRMQjCMXisfRdPJQZWhEwe0seBl/XXUbQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0388d37a-69c4-452a-fe35-08dedb3af8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:45:45.9925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtvi+804T7kvpCvhCASP2qCqoBC/F0KKdB201I4VxD40B563s/CeWPbpjRjCABeP6+Ktb8VkTX5af4NzeoGA1QwF/NuqxB0rJP7/btYTqVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
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

Introduce a dedicated reset handler for SCUIO.=0A=
=0A=
Previously, SCU and SCUIO shared the same reset handler. This no longer=0A=
fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass=0A=
and will handle coprocessor-related control in future changes.=0A=
=0A=
Since these controls are defined in SCU (not SCUIO), SCU and SCUIO=0A=
should not share the same reset logic.=0A=
=0A=
This change gives SCUIO its own reset handler and prepares for upcoming=0A=
SCU-specific functionality.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index efe1d6315b..ca93c3699d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -1069,6 +1069,16 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AS=
T2700_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCUIO_FREQ_CNT_CTL]        =3D 0x00000080,=0A=
 };=0A=
 =0A=
+static void aspeed_ast2700_scuio_reset_hold(Object *obj, ResetType type)=
=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
+=0A=
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
+    s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
+    s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1076,7 +1086,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass =
*klass, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit I/O";=0A=
-    rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
+    rc->phases.hold =3D aspeed_ast2700_scuio_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets_io;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scuio_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

