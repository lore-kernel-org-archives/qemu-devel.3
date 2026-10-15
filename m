Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE635CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5S-0004hj-I8; Thu, 15 Oct 2026 02:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5B-0004dn-Oi; Thu, 15 Oct 2026 02:36:58 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF50-0006YU-UX; Thu, 15 Oct 2026 02:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaQwBWM3dsDAYd5h0JO5kz+LEloPfm+iU3F5Q201eU7EnZmldqMWpJcnf9WzPAB3Zf3njjwNYG1FYn1ZXzBTzn6PkzmX7YQBa88+iGWl40tNrTO5hR3BBiOfWsInlnWe7IQkuucVRvhlgOTIRzlvI4IGhf3o1HocgbmoGp1/Y/T62CoSCmADoHs2f0Ov1VcQ7Qe2hhd24O19xuUe+w8IE8Ga9pi04ZreaOLsYU2bjFV8edB2J46KcZFcj1hObFK1kjO2AYgx5zwbTyMD5UosKEk92IpByKNivbzXKtm2QIAqJr7aEN5yJ2sI/ACM2Y4CMffm/HdaXL1QZvccLknp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlw8kgYLx58CqV6UXOaMqF1DiNYOCIX2EuyjJHKiMO4=;
 b=N46K5Wt+27HRmOT2IQG8RbLbrGC/0aQW73ooAoFGg85lxY87/y4/JTfbDgsLZUF9zJz8VzwYSrFcS6Twaw1wjV8/0sYq5+EPlfSWq2vZqFf+00G2ESNqubmxYLuAi5hyaeuxZjWEQLgTPQqyQPlLZU2nPDx4iBNPmdc9QHAFY9tHujxhY/swfZ1KRL252S+mbk8xuO5eQGRi7OTN3roxPvW3gKk9xAUT9go+78lnUy00taMOSXpN56Cww9k+3jTweeKCClBREVgqJSBhN+sIh9C6zeig6JJyha/Zt2bX4wppfyDgWHhmQ4mjWzVOm9BrIgsKSWz1+trdResVmVCT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlw8kgYLx58CqV6UXOaMqF1DiNYOCIX2EuyjJHKiMO4=;
 b=dAlWtdqzrs8GuL99o4MiADZ5ZYZvN9eVUMH8/YBywsyZoBKOZF2tshK8Kq2FuC7TkqRsCt3f0NfaP+I3xRSBbKDfur2ZeJ7m8FH3vPLB7S1USmm6wdjmWaLOtNQCDpvHlKovUOCtUuWKAc9X/UZfA+2LVc3N2n6eWtj+418EGKdA5mUUs+Zz0V6azs7WpCtwzdZVWMdvvURRxOhP7bvnkhLXe8Su/BJkgurgSi0LwVkZpjWCANg28/2VzNwfUcl1ucs2VeauuU+zx6UD1D0bXcS6mh63EQ6c9wKxS6fo/tDc7gcWMew0waaShBiKgksItMTYJjZSSqGdyTSTdlDZ5Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SG2PR06MB5107.apcprd06.prod.outlook.com (2603:1096:4:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 06:36:35 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 5/9] hw/arm/aspeed_ast1040: Add AST1080 QSPI filters as
 unimplemented device
Thread-Topic: [PATCH v1 5/9] hw/arm/aspeed_ast1040: Add AST1080 QSPI filters
 as unimplemented device
Thread-Index: AQHdXG+E7gzuFJNVwESXuCG1yw4uHw==
Date: Thu, 15 Oct 2026 06:36:31 +0000
Message-ID: <20261015063625.186708-6-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SG2PR06MB5107:EE_
x-ms-office365-filtering-correlation-id: 1cef0a80-2b6b-419e-5c36-08df2a86a827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|921020|56012099006|261009223027099003|261009221227099003|10067099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: 8cNnSjkEmfKK8xVAbljnlPmraUwXtqTWZNYS8zRCOSTqEXPuIGG4l8RHXZ4DEEX6Em5jXpJ492bl+sGVFDPn4M7UG34LLlSIw6z2LZSwo2ZoSdfqmgZA+fDrEV0nsIJPZKgSoT8XKWZi30NoKXvam0+Dqv5U0i4XgXJLL7Z5pZr3d9sKXww2kNNuibQZW/3bzZUBYI3/Ep5KWEL13w3QNfSdhJ/K/F+cazG5EKavM2T2tMUpXmvIN37wmSaGXV2983gtZg6SWufUfW19DRegq+y3RALib1zkIYEkRQPWU/pKT3gNFIBioG7hGEBj3cq4Cowlf/Hofq525CDw0ZWSNqDnT/oHDrEYge5LA+xlgtQJQ/E3fGNhE6OF/KgoFyul1DBf2IZGQ8TVzzSDKLMr9kiPNWDT1x9UqtLKAbxf1ecD8ICmm/shjNEz7/7sXmqltWvb/LBtikztbIDMuSwQ8Y3W2loWVFV3g5Ac4ZefDNrxxqTFOjoZi2RCqgzAvXMQNIGkVvzB/i3d8qav/pkAU3a1fEvyhhFLbkD2UKgfuKET8CXAuh7LV457jz9EXGiBQNBXqnhwuQE+r8kw6twnk06Q4enByZCloLoPAV029swa3Uo1bWlLKgiX6CjtnqiaYHe1FEqbxiEHMcR562AnVyUK1AMgSpnEfgkYRtrX81rIZ6ohcpDzf0FlKy82/f2BipfOwZhqcWZKrcXEmadDSQc76x/l6mo9JAr1SUAuvcsR3dIostygh+YVZ90ooQPQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(921020)(56012099006)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NQOPPcDNJ9/UmBDVLLF3cbKeEMxfBNwCGdakG1ZYHMOgbYffxRyDKthNkR?=
 =?iso-8859-1?Q?zDK/Sr/Yx13ZFbpDSmeP9P4iPP0Cfs9OOvcksSsLaph/KO5rXHAVNeIWFE?=
 =?iso-8859-1?Q?/iCvUsRy3H8eh9ryxkHJmMK7sFYWaWN0W7TQJPKlZgcT0LZAzFx+H/H7JY?=
 =?iso-8859-1?Q?48XZoOF93/g8sdB/H/B97BBS6GHAUhuVa/fSU3bNqXqXRSuu1XuL6/DFoD?=
 =?iso-8859-1?Q?8kqXItJjgaoVU15fq0LSqqvdFE82o0UP2hPBH4g++f9ZI/Oj92Nt2TPMob?=
 =?iso-8859-1?Q?GKJWuCEN//PYKE57E2hO0OKZmThOKm8JP+0G5WmwPki4zAGBqIP/htBhQ/?=
 =?iso-8859-1?Q?xe0nKLgeDV17N6/bgQc2ozN9KTa674Sf7RVPfIzUJMWnluW2JqAc8FkRLe?=
 =?iso-8859-1?Q?GXzzlZy6S27gFUvqgRYXr67QOYtOFJR4eqS0+oRHOsHlkeVhuMO3Xabbet?=
 =?iso-8859-1?Q?EdhGP4wFjGvG0TdUA33XCfPegSB1I3Lec5TmlKohRZTcRZrj21nMxhcdIl?=
 =?iso-8859-1?Q?jI0Knyaeca794sQYQD8rpASShrQfShFYMQi1lqNzpm+E86NJIUINJjYX3E?=
 =?iso-8859-1?Q?EREUQAQzUG2UpfoPAt5wtk14XtM+xgUJoYCLygeH7wlV3rS5HPt4Q+FaWr?=
 =?iso-8859-1?Q?Ty+j/pFyGRGJucJggg4IxfSBw743DgXQ2NoaGue43mGFjf3wdSnJHE9wB6?=
 =?iso-8859-1?Q?5vz1FMN5uYIhJX5QcLaaqWeV67+ZYq7HPmoqwM8rUI+/KqLgDuVE3nxR2Z?=
 =?iso-8859-1?Q?L30bohSZHbATpGGCiG0DaqrAoyJNdwt3YYE5XeRUzzxTmNXHYFBta0WUDn?=
 =?iso-8859-1?Q?5lViBz+AoMBRnNkN4thTBxhPglVKKvrDbJEJGZUQc15yxAvE5SFxGGropU?=
 =?iso-8859-1?Q?R74OEZ6HF9x44peyLW2S861yAIYazzsb3UKZVYW7L4nTwjBbQmbCc/KBcr?=
 =?iso-8859-1?Q?CLgYOM3MOYtpZzDGw3JoD/GIpfX8XzgXNgR3LJkjsNSZvbaTPcaFd9x5eI?=
 =?iso-8859-1?Q?N1dlbfwIOYxemUoUBI8zkM5QccLxX+OlSLaPAHUDTLCjM9xvmlBmDHFcjT?=
 =?iso-8859-1?Q?6vT862X8D7K6QnE2Q/vGA413OUcViltdISOrqxjxquZbF0Gjwf8aKnzlm3?=
 =?iso-8859-1?Q?13IR85uzvYIn+DcUNT6LQ6lrQhzw3s/RPTmKCURZfi+lKD+TuaxIWYD+QN?=
 =?iso-8859-1?Q?7gGN3LLS6qr/PQPvgsi19SPW0X1cs52LffCfKzEkA2HOapxa1tikMabQUk?=
 =?iso-8859-1?Q?30nTlREdKzzmiwSqyHUU286Es3rX3hAvNzK9tN+ZG/pf1NaL7vuJQDenwT?=
 =?iso-8859-1?Q?D5/ICXnEGflSvNmVpLRYcqaBdD5u62c6zAL/rH68eh22opuhGC1Da1c0QF?=
 =?iso-8859-1?Q?k9dJWn9s+KxeaaE3Ox7NKqLb/nhDJvqKF8np9XyUvymQG1mAzCjLRJ0aam?=
 =?iso-8859-1?Q?m3coO08Sx23Scy99Mi7mmNnKQXGBAXwDbfhV0jOUsLulGVPbyHHr6z8LED?=
 =?iso-8859-1?Q?SKU2efF0ZO9pSNLGOwxQzLZsNH2mTrSGLrzCEWwiOceizqppKnmtXdrBuB?=
 =?iso-8859-1?Q?hAOr5J5vdEZ6Njwv64ln43kXPn02uhdUwnPEBWxYVzThQ1QFFKvV0tliWU?=
 =?iso-8859-1?Q?6yITBqEwlBJ7lOD8f0dBlgQ5bpw9jmrgw2xOpdIEwWxcpLOj/R3dIl8bFI?=
 =?iso-8859-1?Q?//lmy99qtuYt5eZRGuPEzl5jGTkNGIh4FTMJVRwfMHcTYoGaky1UoGCdI3?=
 =?iso-8859-1?Q?aqI2cPMwHMNvIVukwZ9r2p1/6Qm+smZHiuOke1e2gTRgcRAfLMeA/xN99x?=
 =?iso-8859-1?Q?7jY3KeryXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ygpSW+fktodsLsZBxSRY3ocbBZbQR2wc1XGeFOYL4tJxJvJjWd5Jkmap8rV6qyx654C9MH7TWPqAuzFlhdkI69icv55wVHBrWxd4n28QmkvImS4clwwPnpBE30Qval226RvUQO4WKN+MIBCIybyLrsCjphmh1t91YbnSkUcN9MyS8+Xm3nP3jOpBlYcrbZuOKPgqKgrfuPUeWj5R6Pj5GAb48iUCvFhHgtNVI8wJcvj/FZnnAYRP3Q03j/dhkJfDUs1mqWjyWAuVTJWKHE09Jo26TYS3zQedlHa4ikb6eeBAw7nYiiGrtt7er0XSffZSNWlnpgHCQ8qDpwFL4dSWmg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef0a80-2b6b-419e-5c36-08df2a86a827
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:31.7989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LwkFNCaZYg0ajibBmBhs2e1NLuHu4lch8tKOD9n3BkmG1zpQKfzFpWKrqiN01leZ2HgiR5XFbXOFcrQ67A9U2Bo0afFoOh213/hIkf5mhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5107
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

The AST1080 provides three QSPI Filter Controllers (SPI monitors) at=0A=
the following addresses:=0A=
=0A=
  QSPI filter #0: 0x74c15000=0A=
  QSPI filter #1: 0x74c16000=0A=
  QSPI filter #2: 0x74c17000=0A=
=0A=
These controllers are only available on the AST1080. The AST1040 does=0A=
not have them, so they are added to the AST1080 specific init and=0A=
realize functions instead of the common AST10x0 G2 ones.=0A=
=0A=
The controllers are not modeled yet. Add the register regions as=0A=
unimplemented devices to reflect the AST1080 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 8 ++++++++=0A=
 1 file changed, 8 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index c641f84fbe..e5c8d15dcb 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -101,6 +101,13 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1=
040_unimp_devs[] =3D {=0A=
     { }=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast1080_unimp_devs[] =3D=
 {=0A=
+    { "spim0", "aspeed.spim0", 0x74C15000, 0x1000, -1000 },=0A=
+    { "spim1", "aspeed.spim1", 0x74C16000, 0x1000, -1000 },=0A=
+    { "spim2", "aspeed.spim2", 0x74C17000, 0x1000, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
@@ -408,6 +415,7 @@ static void aspeed_soc_ast1080_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
+    sc->unimp_devs      =3D aspeed_soc_ast1080_unimp_devs;=0A=
     sc->num_cpus        =3D 1;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

