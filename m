Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26F9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgW-00041z-VB; Tue, 02 Jun 2026 01:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgO-0003z3-P4; Tue, 02 Jun 2026 01:28:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgL-0002gD-89; Tue, 02 Jun 2026 01:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aag5AcLBhe1yZxwDMTjoWTJFrCBvgzqhgnQ614YzZgAPz3hIvoqbgsIaepn7t7WW3rgpJL+7oZ8ol3uEuiflKlE2NCSaBv5SVwGsTvInFRI06557bhRj3fb3P/uRyTaXdQUAnx4Jr7w8OBle36M9vFBfLUMabNPVTupn0GVqDcF+u4G3x8VdQ4oDPTWmg3tXppkBkLNr5auOEJRnRhcL19akvBsN7FioCZaVIuKO9kryEi3aiHLD96lFBWnd1Cqwl6/kUd8y6lNdTB8yTm2KSuLKXRooBjjzf4ejZvg9kmyM20eHNK1TDp8Jzr6zTIR3UCuzyhzNQxJfSNyjzxbpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3OsqHROOE6fTpnLl+1tLFFrsZTzXXgi1xiWiyPUlGg=;
 b=CytEcxTnV1TU0gy8p2+d7DFrin0JBoxMA0Mmmc31oh2SUIF5eyZdv7xMIj3mAciqFDox+Fb9i7VmCM0ebDpPkLtLx6DXO5JC8B99zoAG9tYtQ/NN/uaQ0/312JvYMwW0uF2St5fpvMdoDkfiTrZLbQfHRPiqBOIDfxvFFg23exVmWC+Npcu/eU+8aVrWKnMF/6U8xK60tT2JFmLXzjjsqP9j/q4yetwVruKNX7w/hVQvaTko3gkHxmfPZMjFF0OI892cDuYc+tnS0u2i2P6oOqtvx95U/22QNUHEq07HY9AYbTqekI2mRJ/WxxhZCDT8JF+gLVJ+Fixr5ohpr2eMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3OsqHROOE6fTpnLl+1tLFFrsZTzXXgi1xiWiyPUlGg=;
 b=NOjDXtOikq5qk8jjT1y2cPHGqP51R9Tkn7lFtDy2ZyheJTjcjyCwAhqicGAp3tfEBbzw4dbJAlogUrraOh204z8uOP5NSdPEK+mFqhiakaHJyjxDe8hU1BpPnpjsV9zaJtZQGBxAdIL6u6s+eu+bpSBn0VSVLKoZFfwItthLUlD6lPsqCozxXiPKEoWRe9/y7rd5+xT68eqc5oqGe+a5HUrOCP5jN4HkBpF4RuVJ7N5kKLeUX4bLC1TBuPuDlzHcb9UpeUK1QUR724UL40YozVGIss//s7yGy8iHM/NyBDnqo59F+GPm/SaUW30ZLYinTNMc2GWn1O7XsWDUh/UuaA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller support
Thread-Topic: [PATCH v2 06/10] hw/arm/aspeed_ast1040: Add SGPIO controller
 support
Thread-Index: AQHc8lCotRTeV5O6f0mL/H1WU02onw==
Date: Tue, 2 Jun 2026 05:28:35 +0000
Message-ID: <20260602052827.1535299-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c217495d-0a6e-4754-8cda-08dec067cb68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: r+nbN/Tmmz0eTjiGkJ4UJBRnCluQgIPAKrCzoE22J1uQdCxLFd/aJ9Ps/Kad2r0p9ZJ8udHSp0rt/246TJ24cbKEoEria3qhkZDOFOvBSCfJJu5OnjA2NWIBTgB/0xj8HF/4NO1KY7dgCot4RQRnG+ObJycAptsjXzVNh70yjuJWroUAODGN+8Bf0yvSjJeszdcOPS5KcwYIxlrUfZPvrEblaqrj0gaRTuEBsGh+CPeyu4niItBVBo12PuDcU5cpOQty6Gat9h+pfJim311r5kwDKeNXp6z3bUopl3TuzK7AWEKzlUxPSuX3w84NDnMC8lqT7fIf8vftlGLUeq6oa/hpto5IPdfLf5yla49rnIlSuywmBt23RsGWnLkXdMh1hhf/QT4bBdSwapdnnyC2WUZ7Uuo0GL1k/ASE7N9TGBvKRC8pGv1XME8gN5xCZsd28tejYyPTZeurHGZEIDyqGSExMnK+M0XIbgoz/37rHTsOa5pVXKq8SAQxOAhtG8hf9fDYr59We2Ds4rryyvpTLEOg5W857sOrH3+Rc8eg5lKhUkMNqJN3aoYVQgakFFAKolW5JcM/vMyQQSFbazf2lMfSFc8PPnEKFhT+bi3T/EuqqxMlusNT2DYy77FKAisbW7x2JLErYZ5WgzcLsQY3rqo/L5myrAqA8VF8hZhKqvHsW/zyJZsEA/GfYv0DAs7OzA/Lm+ZM6gGmSWfqP62ZxXMvFcfMmnDtSMGmNm01oJ+O7JMTVKqOvi+wGAHzRsFR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PKuGIcjAsR4rsPg31aIXy4LPB4b9aHW2DYMcgwPCy8mEQVFVjciLXhA0s6?=
 =?iso-8859-1?Q?UknaLTE7lVpLNfSscJfrf2fPoYE8YGt1nRAtTk/KCjwHQR5nA/CKcLgXWT?=
 =?iso-8859-1?Q?CXl2FHjCdPSl58qzuTLqpVH8ObrEeLynkvrHuYE2xKS8GtGkq66CrZLV6p?=
 =?iso-8859-1?Q?Q70yVj8hYVfpGBTMsxc5kuN/zBz24Ze+bpcuke+UDPalOZi/P3Z0aTdHrp?=
 =?iso-8859-1?Q?0V0O+5M69nXkirXZtBtMGK+u9zfQ7tDMkbeJRX4t2hUCzMGeI3o2c5KkYn?=
 =?iso-8859-1?Q?D5CC2hywadsCMwOD8KU2k2ve5Ao5ivUBcC1rrn0gmiHIKgc4+JDAcOSQUH?=
 =?iso-8859-1?Q?ltFiTEIw638d0N78I9QIc+yMRRgZLWclk1D75wMsRElGPWWewnbk+jR7xK?=
 =?iso-8859-1?Q?Av7vMKK/r7CkgxBFxbgWIWZnmJqkbhR+gXyEv+nVQyRYxUVa6JqGw+4J3h?=
 =?iso-8859-1?Q?3AnKwdDDBOnBsuoWjpsEaeBaUTW5g9s1tTJP7obtgGpOaIYFheQFBf2D3W?=
 =?iso-8859-1?Q?4ZKQtcmZrex+H3b3bNAQkkSnSsWUy/kdsj1wk3KYcO4LOdsbA7jykCy0V/?=
 =?iso-8859-1?Q?xaFdpmKs/90Sd7ythF8JHChracGitcr2q2aSai+6Lqf8O1LLk0jyfJ+C44?=
 =?iso-8859-1?Q?8EmQR8FupGzONLJYamVYS0VDm9ubx3jQo7pKcjfH/Uze83UCFznOCMQhlW?=
 =?iso-8859-1?Q?nPdP9LY+MyEiYtj6XlIkL+BvGvdlmcE4YnXml7RyzRZpphJwtejj9WJkGY?=
 =?iso-8859-1?Q?vcIxxvkju55lWx/Mu4ab4yzsqoqmTNY8IQQARwFdIwu7EEo8AEqWgpC+hH?=
 =?iso-8859-1?Q?WQFyLJnEH4UfRF+KPsZeUzOsi6PHSU+k5zs1TX6LM/ser9F0F2RpKzCTwG?=
 =?iso-8859-1?Q?Da/fGu5oz36lb2QRyI3XZUWUK8LvVMCTLHmEym8pScUyfGgOBwpdtA1Aop?=
 =?iso-8859-1?Q?/lAnt5tvTR7Oj/Q83pjPBWSDLGPnKVsIGsO0jNmTFu6PYzLnz/yTfzpYoo?=
 =?iso-8859-1?Q?LIlp+7GR/VGs/lHUUKbqK6pPZxG439NaYKk8m+AqVJ0AE9vCQU9XP6FI8J?=
 =?iso-8859-1?Q?+jsRJscNcI/oVB708sFUfa7AL5SDKEE3Ju9Tyqom5J1yoox8zokb+CbH/f?=
 =?iso-8859-1?Q?QyN3q0J1w/BumuVu8ACIMdzvZb6YmlK+L2S7a4yb59euo7sdreEjmkLk8E?=
 =?iso-8859-1?Q?F++e8lJuNf7DUETuOsLcASNpis6AnL5uBeYcV+0WkJXErDXauQx3BYvesd?=
 =?iso-8859-1?Q?Bn8xP3HICUp0YMw8VkNqaoSnJiqZsGg3Yzwt1prhS6XcPTDx5FHSlh2aeN?=
 =?iso-8859-1?Q?uxVK96ZuMkD7yytiz0QjjGpT2/dyTMuawXlmMv2jyg84QzU/5tOKwYC4DX?=
 =?iso-8859-1?Q?7DptPd9DIOs8SEvQebZmYnW9r+12us5yudWXiHXGSyG6cQtyeYrzEQ8nwc?=
 =?iso-8859-1?Q?ndmzTvsiaj6n8DEwEf/Zl+9wHSERUKIshaNCxKHgt4ZzYlyfbQbauLlE0q?=
 =?iso-8859-1?Q?kngQntfFAfnt7Z8EqjeqbS/ArdojEU/PuI3ewncZbH6egXpmVzik1uW+rc?=
 =?iso-8859-1?Q?mZoGUZSYv+yzAgr3VJyLGeB09fCyFKlXrnLMbU6PHl5Si0cptwX94esdwR?=
 =?iso-8859-1?Q?3WcbrFYt8brNkfIx/Tbn8uyDQ8a5OvIXZdpA0RDQQI/nYc/zZzxAl6KkzI?=
 =?iso-8859-1?Q?BuQsfDS1S49kUqkpKeVX+/pILMq2yYdxF9TEA+mk7aq+inJMImJbBBtT0m?=
 =?iso-8859-1?Q?5Q8cGwVZ9rFV11nclpepo8W6rX/Kx0LZ9Dr48E0tF4E3+PPnPV/2wRvSNF?=
 =?iso-8859-1?Q?C/1getdRcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VyZhUTEEZc6bKBq4W+VNDOih8RB1UOniRvV54SQpKIoXIR0wdF/47ZRwCQifyFDyo/+akWujShWO1mXytEWgwykGgj9O3dCjD/00cYnmSknNWbx129DLQGV3O4mr1wuPkBKSUOfaE7TMmFSSx+8A42SFuQ+H0p+vPPw94pyfaPcXnzyMQET7Yp5h/lsd+ig7bS2T/xclOUFokIZqJZBsQs7JLTRbwoaYlVe+oD+rAfCEox0qTxyy4F/PXtUjhof/vYFTIKcRAnMX+DczVBqtZvN7yVK4QZPceNUTro9sbGBaDmjGk054XmAouf1upUFYp28j1Br+gh5uaNec/0Qh8w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c217495d-0a6e-4754-8cda-08dec067cb68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:35.9390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLgedMBAfVr8/DWukTPCT7EkL7z4CywL2xjD++1Pcwt4rrITVw7TwoEla4wZiuIIQmGBJHI2edqqSS6F9qwb0D986YpmoFk0v+CazESHMV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The AST1040 SGPIO controller is compatible with the AST2700=0A=
SGPIO controller implementation.=0A=
=0A=
AST1040 contains two SGPIO controllers, so reuse the existing=0A=
"aspeed.sgpio-ast2700" device model instead of keeping them as=0A=
unimplemented devices.=0A=
=0A=
MMIO mapping:=0A=
- SGPIOM0 : 0x74C0C000=0A=
- SGPIOM1 : 0x74C0D000=0A=
=0A=
IRQ mapping:=0A=
- SGPIOM0 : IRQ 85=0A=
- SGPIOM1 : IRQ 88=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 29 +++++++++++++++++------------=0A=
 1 file changed, 17 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index c6b22186ce..77211ce1f3 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -56,6 +56,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_ADC]       =3D 80,=0A=
     [ASPEED_DEV_GPIO]      =3D 82,=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 85,=0A=
+    [ASPEED_DEV_SGPIOM1]   =3D 88,=0A=
     [ASPEED_DEV_TIMER1]    =3D 92,=0A=
     [ASPEED_DEV_I3C]       =3D 96, /* 96 ~ 103 */=0A=
     [ASPEED_DEV_WDT]       =3D 112,=0A=
@@ -112,14 +113,14 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
     object_initialize_child(obj, "gpio", &s->gpio, "aspeed.gpio-ast2700");=
=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i],=0A=
+                                "aspeed.sgpio-ast2700");=0A=
+    }=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
-    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
@@ -221,6 +222,17 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_GPIO));=0A=
 =0A=
+    /* SGPIO */=0A=
+    for (i =3D 0; i < sc->sgpio_num; i++) {=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_SGPIOM0 + =
i));=0A=
+    }=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
@@ -234,14 +246,6 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
                                   "aspeed.udc",=0A=
                                   sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0])=
,=0A=
-                                  "aspeed.sgpiom0",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);=
=0A=
-=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1])=
,=0A=
-                                  "aspeed.sgpiom1",=0A=
-                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);=
=0A=
-=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
                                   "aspeed.jtag0",=0A=
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
@@ -269,6 +273,7 @@ static void aspeed_soc_ast1040_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->sram_size[0]    =3D 128 * KiB;=0A=
     sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
     sc->uarts_num       =3D 13;=0A=
+    sc->sgpio_num       =3D 2;=0A=
     sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
     sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
-- =0A=
2.43.0=0A=

