Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E165CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw4-0008IB-2m; Fri, 29 May 2026 02:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvv-0008FN-Qi; Fri, 29 May 2026 02:43:05 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvr-0002Ht-SF; Fri, 29 May 2026 02:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI1uZm3Ljpholl3AVoOyvA2rmA9LFhN864OhUzuEFRu08kBkCNPiykKE3LTqCsyEiWVz6nk5zEUQEmq9LoXuSACZPjq+Bn49mmhMKcehXMK9g+wd0tJLwVhTasLQHuTggi28ZK/hbDSpK6x0HbysdSZqjAW/ic09YjRRp0fTENXlPcwGsu6ZRV3U2eWKJ86f5ZcwPYBAu0JoRjQmXEAHQ8wNRUf9NtUixqWQRcfF652rTj9Rq3zEJjL2tp6eB+2I1ZbN9n1atLFDltthHRiYzk4CXl43ydfrz/ICBlaGH8975wlytgnv2hbQoT01hHUNEQwy24mynsPegQGY1qwsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7k6vfcGMDeNS0+XgEFUmE0wi2OlY0OX2NuGsFfBPJ4=;
 b=QaHxcLRhzltItz46ADYmH3c8Kbeo2S84JZ2Us0lbii4U4SyIIQjqydxFyZMRcyjh/MzVJ7+nlTewOmKs/hOVeX2O9Q9n8mv0pLdYQPUKdb2ofU7pcwJQdo6o/gnMOfroWYTi5f3vfc95caU2NlKQYMO+jpFOZV71p0w7h9npDZXeyofgfCgckWnqHKxn/5TnyKLKf1MQexAyhNxBWQzCBSmwT1PrUgBh4Wqem4eliG6+jTH9hkTkVPcoogF9A/5hE643HUwqZY153mgHrp3h0Hg/6o35rRkpVFZ9hMwh4JEgVHuhSN+osmXr07Eq/TY5jIOvuR2OTNBmip+MVkjs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7k6vfcGMDeNS0+XgEFUmE0wi2OlY0OX2NuGsFfBPJ4=;
 b=JziHE+8eTx++UnqfZ9kYMIMwspMNcgb03bBFbvwd7OogWZly8En+/LUyX+mCDITtdozei5OMa3G21aCi8JQ1sPR1faey2Ou1F/jhBg8R2KGB95IuCB8VwhqXhWfQ3aG6a+cd99UamV+LuLxHk7wRvTY3DAl7NLGWQ2p3tzCpYffTWq6q0sY/xT/X+9y1LSI0OhkC8yVusrUt7E++honqKO+ZG2gZal2u/fM+t7kIHFHKs340U5wgZVbYXvmbp9cncknnRHDXXdyDNAGaxH92w/TjFJrsUhrPr7EsI834K38vidovfTlDnEoBiwL2PphdhFFQ0D1ywEZ1w9Pm4kE7vw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Topic: [PATCH v1 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Index: AQHc7zZdXsUvfc0aV0OUaWpalC8raQ==
Date: Fri, 29 May 2026 06:42:48 +0000
Message-ID: <20260529064243.2064188-5-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYNPR06MB8451:EE_
x-ms-office365-filtering-correlation-id: b44b8bf6-9b3e-4b10-3be5-08debd4d7fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: xPFI+a11EP8Ov7DdVbxKtdDrapCsnmb8sHve3HJEXAVu1kCKnkvEhLgUZbwAuQmMIPBz4WHyfnnrfVH19xrR+9wnESYGtHjEr6bhYqHDZAhKeZfIpl67GeBuSVcPOqrwRHShtzMU9Q+CIWs5DQm5HjyHEfXiBaoImg5OvaCt1YQZL9KzkjnvNvG29yCq+xqaoCluULnk22hy5L1IdNMipGdBcDgzrurRuxG3jFJBNCpw5b8pYAREQBZkakxZuY3p1woO4hBviEIQHyuBt0d5tc9xtp+pxeFtreqgy1F57FSmgbA65PLnuSc2NFgB3fGMykpFdSxbGXywRpGmqOf8KYxOv7IE2IZyEQ7ej28wD6hNsiu9KrMH5/+EdDuTLEr2VQaQfM44urnwAQvecnr+A8b1xK8lqHqOY1PJE23nq8MPYuBOP7aepkNm04MpB1mNE0TorBKylAqfrSsBzw25wf06HhLgENnpypZvGvGvOitnPEnHohFEi2/0+sszPFQK1wuXfBWQI8FRiu28rjUs/7q16alAXA60yXP+HtZnkPbobsbjWXhI1bYu/ht3EFRyaRRpnI96p77EIQIgAAsniwYWawGg5YDb+P542nN7bx8PI1bH3Iv1kcCDqfmT1mLZNQ/CvnEMtCRzdv0KoXe8RWrQApEIpidZgtYzcBDG7CKXqelfucymVUQZ5tGKzIgZaxJ1yQ5UmwOoPrB2LrasKq1iwQvIuVXqHLX6KHlj92wOIiehccHWhORCrmREh62L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aeluC2IYVRFjK+11qPVSnO65RtTFhasw6XsssZj12q2VLuiE4lLp3pAyCj?=
 =?iso-8859-1?Q?Scim81t5S0um1VvAbIahRKJGt1l1BO8gh7gcjCkpwIoRaY1x+wYYf04Ppy?=
 =?iso-8859-1?Q?W6ev41ggmgJEGDt+O8fQeI47iUesN3ELM9gUutN+c5p1tqmaN3Fj/Q+59v?=
 =?iso-8859-1?Q?4MHbeJ6PUUNloS4KIcF27QRFk9PPohSYB7B0IaBL93lT8dMW8AK6gA4opE?=
 =?iso-8859-1?Q?fD/b8Bz8Qg3ESQtOmvK9XE4rIpM358tE414WSaxq9PBNsVbUiKpfbhDFb5?=
 =?iso-8859-1?Q?IavzE3RCUQe3nZ1BPAZslA/v5r9YvMJ9WlXUYrTbkZeass8Toea+ylixSr?=
 =?iso-8859-1?Q?ZBhEZqKEEDEu02ph+ip/L1ZSr+VGsj6ZZ6TJDjcPNI1Jjx7A7LP30RXvdM?=
 =?iso-8859-1?Q?7OMhCSU1bu6DecEhIceDP8ZL/pjQJySWnLZWpkSPfczolq9EOUqIozdThv?=
 =?iso-8859-1?Q?H5Fe3363BQjy0XM/PsB5ms0LE0ukpsWF8Js6Ck05WjFkD6Ej/HZS03di9h?=
 =?iso-8859-1?Q?Fvs/ELBbYCL/ZWRK3i0UaAjHMJ3O6QChn5EOHZgZ2aLUNZtH9t8uhgZJH8?=
 =?iso-8859-1?Q?qyrNJZBbE+rrsyxhFC/h5yA0Z1kL7ikX13q/zkCp//QOh6tNn4bl3GJfMX?=
 =?iso-8859-1?Q?GLZyge5T1MAaOuKazhwUdOtomFkH/Il1XEpZXkt+8FmGQyDZtgQ3nmsD90?=
 =?iso-8859-1?Q?SxOpW2I/LZfVHmmbiMUKKTdn5LAm+vlnFpdwb0A2QZRRKWzf2CV30M6sAO?=
 =?iso-8859-1?Q?j0MoKSJpkGfbJQk/C9D+7HiztDQkuUqf4WKmNeuQkLQf8bfqseNITEi1AV?=
 =?iso-8859-1?Q?J1BmZCqtq8+6Ch2Ekr0lVMmKpwrdWjhzO98QZPeAdL7DZ74kXmzxRaK8BK?=
 =?iso-8859-1?Q?scRnHy8zfT0nT4eNLHy0g7jwmCF0faTrW/y5j9mwiuxiiD3AtwCkH0GR/n?=
 =?iso-8859-1?Q?Fd/XfFqxF3hG67EM3c+5ycMNgK4SldjR9KQAcBFQGJhHBIGJ4mHLj1D253?=
 =?iso-8859-1?Q?bE7f/wTb159NgewpN9i1oDSSYjTzY5wel42irj6HLesv7FtPCDEXdh50Cd?=
 =?iso-8859-1?Q?4MV0wSBj7yOAJCrluncHIqttI7MSW3eo1ZCyQ//LRvVNe87aeBWqFvV0jH?=
 =?iso-8859-1?Q?Ic5Yo3hAouVZmac+QnSI98paMv90W3vs2xBpGSAlYUIfSFNSEvtqDUIGcB?=
 =?iso-8859-1?Q?nCDQdYbeJ29Kp8ym67Lbm11dZpHUQuxqQHbvqCdkr3j8Z9okWtsqqY2AKD?=
 =?iso-8859-1?Q?VMA/kYW9IstJtGxeFGRfpfrk7Vu0w+VT+T8nUNKvNAZbGcrKdecS5jqIZP?=
 =?iso-8859-1?Q?OVUX9oBSwjrpvr+RoSEYQiKEqskrTU8FSxW0VvaK4f93nEWoxP3y93d4tj?=
 =?iso-8859-1?Q?B1Se32cWzsRmAlOvhpQvMsst9UizeqFirvem1eI/Q2E2gaub8Gqmj60GJC?=
 =?iso-8859-1?Q?mZuzrQcO8Oaahfz6kVyLFx7GGISM7VgsCNr234hJcfaKxT0B4G5i8RGiCe?=
 =?iso-8859-1?Q?jGlG6pgGEmhgZGnVGsgl4c3CXDnBFXok2CIevgn/Fiwa3Pxp8sDTTzDTml?=
 =?iso-8859-1?Q?hpT9gWl94Q3zhy6Bpz7LC+O196efZ5LiIqsK9lM0gIAIA67Hrg+o12kPtN?=
 =?iso-8859-1?Q?0fLWyUwMtZgbw3f+/RaDPZtD3M8VrhFxJrG4/WI83cL8fUpCyfNNXtksh0?=
 =?iso-8859-1?Q?nwxokTkkcxB5HmwT8GOTpYj7MTYfwmqTpVv3cpcyG94ZJ6qxBNH/cXy0qr?=
 =?iso-8859-1?Q?DEW0U8xWBXmcRNjzCjxRBWdSWU1dE0oFI1QWQ1vOx3mfQbSFUQiKECqmym?=
 =?iso-8859-1?Q?khNwOZkvyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jng8vdnDs80Sv92wHG5P28lmaKSPqg/aH9ptFkFcpGIf8DDAk/YbfomlVAAqsJKvlJFhW61EoYWk7nalwCdiUXzyz2OJWajwiyEEaFeRqn4bRcGdQqhcMoDVi5ntugfiU5x4gOiXQpjVRMTiPNeRo2mSDvkkFEqZfxP8YryXUb1N6oFfCucNr81mLaKhrGROvgeZ5xVZ1pUl5ZrFARpflDhZMDMZv1zPCKz/XUB+Ni+wrClq3eLuWJzhFuG8150JegQFUBliH/63KdOUXoUIjwi3EryHVAAD8ZfwGvBnP2HonpYQhmEL62hJsd5dddkG5x4oCXkfJclioyecaTnALg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44b8bf6-9b3e-4b10-3be5-08debd4d7fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:48.8038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LetE9jjmz7F7N5AA5m3H/RzghoEdb6PfKYp5NNfPPaP4mZECnfyG7mZt40bmCZPrijBEcx8+T+UHzuHnqPfVHt0D7+II51NofyxJTul+DV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
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

Introduce PECI support for the AST1040 SoC model.=0A=
=0A=
This change adds the PECI MMIO region and IRQ mapping,=0A=
initializes the PECI device instance, and realizes the=0A=
controller during SoC initialization.=0A=
=0A=
The PECI controller is mapped at 0x74C1F000 and connected=0A=
to IRQ 164.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index b736e690e5..9ae0a0e7a4 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 0x74C0C000,=0A=
     [ASPEED_DEV_SGPIOM1]   =3D 0x74C0D000,=0A=
     [ASPEED_DEV_I2C]       =3D 0x74C0F000,=0A=
+    [ASPEED_DEV_PECI]      =3D 0x74C1F000,=0A=
     [ASPEED_DEV_I3C]       =3D 0x74C20000,=0A=
     [ASPEED_DEV_UART0]     =3D 0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D 0x74C33100,=0A=
@@ -76,6 +77,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_UART11]    =3D 146,=0A=
     [ASPEED_DEV_UART12]    =3D 147,=0A=
     [ASPEED_DEV_JTAG0]     =3D 162,=0A=
+    [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -108,6 +110,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -199,6 +202,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
 =0A=
+    /* PECI */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                    sc->memmap[ASPEED_DEV_PECI]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=

