Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1AF8E4A8
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZt7-0002Fi-Lt; Thu, 16 Apr 2026 23:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt5-0002EV-Ja; Thu, 16 Apr 2026 23:28:59 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt4-0005q6-4z; Thu, 16 Apr 2026 23:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxDNnCPhBUQHfhYXDYhtEk77mQ+kT4KqiFopWm1+3dN4aafhZ5J1PSTZh+UeBwHnuaQRsujvmnxrgJ5iEi1no+cOa90+6LU9flFYCiwRmKMLkN7pjfyk5XNEYHMzwEnDaLS9UbPXtL1LkReZHJ76cNShVl6Ndo2VJI0+XM4JtiBbUMOkzYRIOFRdj0sp4T6LTabigfZOYt3++twrhSzLQ3uWw5zSi/m40KC1/ATUXQcYa6QURL5wXEAUyaDKq68DZDdw213P4SXDZCw1bazZM8rAwVf7XNSSPdZesPPX486C+E67F6lsKM+u9LRix99qf06RJKYIINlLs9I15GLEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14vDysdaVQ5MIdNZeJNc8+7z29whl9gMON17QSCxlSM=;
 b=Ens9sBe35iEIKWefPmwkDpQi1E6bdH51/u7ExKM9f96IVZm1nhQQp6eANoI6IN3SyFnhmk3kCMnOJJADw0PB3taeIjfrzHo4Q/1UHvWch3YDH1TVVl9GeY99pWhDiM1HYQJamMQ9g3u1tPmWBH2oteA+D9uTGUCNRN90iGADXtmOVzSpc22brHMkJ/DjRd3DdUXoGB8w+uv/tqQRUdkjzPMDskE9nQQtWcpg+OW2vvq/HOKpuw87meNQ/6nZ+I7FAcAD9L1FiE44mU/rFWFnMQ5XdXiBytXlJG+y/27iG2tJ0N4AOSgosFHVizrDbOwepsjTVoC60Gj4i3kd8Re2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14vDysdaVQ5MIdNZeJNc8+7z29whl9gMON17QSCxlSM=;
 b=YDImcAdI7cw781fFJNoSzm8tNcofvI4K9r1OEXvxMZI4n/FHWyQOt3ggISEnDCiS5yH6TUx7LwIyWXOt8+aJ2JEDJqoI+wt7FnujR5BOnG2mq6aVxm5rcmCTyqfMAYpmrIG6llc6+JWvmrZ5DrnuHMaibovY7H65+FEyZyWU07Nfnjuy6Ai7BDoRkBWgYSFfVNWJmH1WXLsQUbbh5XJheZXry48E1lZ1pQ6wiGuTzA80zViC0JCqu7I9q3H4UsRd9jKm+hfMCM7skt6Si8Okb8bM3nzKwhHK8Z6wz+meU8avsw3SKv+cmT+4UpJSp/gZcfBi7xuvLSE4YmNQ4zpxxQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 04/21] hw/arm/ast27x0: Start TSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v4 04/21] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
Thread-Index: AQHczhpLpiyZnPziN0KYqhzBqDKf3g==
Date: Fri, 17 Apr 2026 03:28:43 +0000
Message-ID: <20260417032837.2664122-5-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 01636023-00fb-4f7d-04ee-08de9c316db3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Y5i5jw7rJH7ZVQq073ATPXc02BHLz28Q9hlSirsml+8p6J6eB+6cajqcSbwZfkn90MSxsBub8D+9L4/oBVSQ8pOo/yCar/OWWq3FXRReAU7QYMNxbKbzTPgroAMwy/RO3EP6SJYf/pntp2kklrz0IAuc0JnT9MZgsH3MRDWyH/xk6sQ1nIuJLPK1hOSPPiQsJxsIsZJP1ie0juvfTrMQr7E2zTjwT12Jk6PL9TL/LlM0VEfVYgkFlrS3kcL46wopn3s5eNg61yQmabjIXzTnNstWDpgLPoeCwuqI9CG+OwROboDofB57r3guKUKnrtV5IQBFqO5q3IfZcjM0lJfGwZlLCkyxySpFH2S38t5mAH3P+xTbVTD7pDp181DDVqk9F/WMlpiCYbzChJPGuiD9tW5YEbx9lX8uL+hjZoLMglQ+ZONPR69b/qgMhlIbxgUZ7OFDeR//J0aWVrdcW2om2Vd/PEke3dKORaKzeopc3M1N0DlXt699xrJm1VqnyYrZOP9ECZXl7beoJlgjIp1k5/BVV+YJFF0Drty9ieydonfbbB71isx049IDQ5W1xSe72ax9/h8lL1LGDXgvat76qHQ9byzNFWsiv4OeVebeO2BOmZL2nCyn6oqQWwT9gxjPKOfSTzkjR5TBWipQNC3cEdXPcXBV9Gui3uccdZwweL7MuGUx+dssBwlj4ilCIdL1+OwfB9ceStOzBpdB2rYnlhU4vAHgXEffUBf//yNQ1gdSggfiRfcqQndD6IxQDnUCCyb1IIHIYx3BGxpi6tNgUyM898gtDDjHNcnXABiis+atpCjCRI2rSiY5+0aniisA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1tDcxcfMWpBDA+bqIeF2ehSsV5ELaiQXKeOyVtjbyYM0HfAoUGkhDjKDWv?=
 =?iso-8859-1?Q?XK6B/cDx+KXyzrJWreqYUyj/YwKXgyJK3+iLLNYpeCzOodPETaCAp8gqp/?=
 =?iso-8859-1?Q?/4WZTFyuEAk0+9bA7KMobuzx9rM6tRlwomTftK91/6SsejdUmWuKN0oy3N?=
 =?iso-8859-1?Q?rK918LnRmmYQzPjONoehW/YlgtVHH5MEMaRXm5/OwGTwe7u0WFgVnCn92B?=
 =?iso-8859-1?Q?vLvx4jww4vbsfmITDSwUcgGOvH62sxF6JickzCkUsRYjBv9e1LcSKuxkuq?=
 =?iso-8859-1?Q?vwvjGYXxrxCRuec23DbM6afhfIAflW4EmPejUBlligjePpz68ChwSlZXJv?=
 =?iso-8859-1?Q?M8SuAQsxF6bOlSmigSfrGZGLfCP314xMpgVC8zNYcwYigl9jOq/FZUH9I4?=
 =?iso-8859-1?Q?CuFeVA7VqxVgJTw4FBh8W9hcU0Pd4Dc/1BKxU21usSSxNUDMwlWrjLft7t?=
 =?iso-8859-1?Q?HwDlF7dAuB5Q2NBFnvaVKslv5Yzo84BSaPUhHiboHKlloz5Fa3ZopDsWe9?=
 =?iso-8859-1?Q?TB05c1OQqWPN8hilEc93b5MgY6w3i5pdyXyFoMDSejQdczbV+pjbECr7SR?=
 =?iso-8859-1?Q?w0fT5i/Xj4d7y6oJf89/Jn7C0gbSYycfEh9o0q0bxswn6l+kAgxa/RHMKi?=
 =?iso-8859-1?Q?hoY949YB+oKzcAJuHYHl0tyqNnWO/9/8mkvTlgiwfti5yhahSD3x5AdpBe?=
 =?iso-8859-1?Q?p1Lok9KyH9cLqmCCiQLtEG3PcFQ1/Dhrc6AZq5hcF85ZSPGEtHFEywoPKn?=
 =?iso-8859-1?Q?ppqFvFWA6TsGoyyXZbFe6HPu0ZOqOPFi2z8PJ5unE9tgwsAO0FZqZxCkCv?=
 =?iso-8859-1?Q?tX78OUWgCgMGfiqXcCQUxpapQLSp3PksU4fvhDNeKtqHJyaU9AkHZClOd/?=
 =?iso-8859-1?Q?fzh9ZD/0IbSgMMeHzpwfgVQTW7XknY/buDYzbuz+ARo96a3ntvOJDQxRrz?=
 =?iso-8859-1?Q?KNEf6CNxhIBb4ZdDmWjI8x0Rkrve3uNItsMuovH19wXgj79U4e64zW99H/?=
 =?iso-8859-1?Q?xkDEuHwpW491wEfCp3DAQzfoxpwiQErsKCxBMJGHUgCOZF5JtC7tNMDjhI?=
 =?iso-8859-1?Q?HeoN91vnNlCiRL8jw5W0fVIqV64eGIUN23puTjQFDMF00I15I4n+D5hdoR?=
 =?iso-8859-1?Q?jj0txT0D1+yDhPpb8NYnxDyUaZluvNojjZgMnsnldzl7PyNXWBJgvPId3m?=
 =?iso-8859-1?Q?GXgLJ+OOh5HnhbW3IPrAv/uMRiFqu9aSa5Z+VhFeQqBdVQumWjLxdqdpul?=
 =?iso-8859-1?Q?uBEx9z6+6XcL61aFFIMMp0zmcCRrhYpObZTwVY8kAexl/7VLWvHCDwieeU?=
 =?iso-8859-1?Q?qtXnwRxMYBfPeRDMWBtIpzhbVHkRqb07MUutA0/8lgiTIqoOKs+a0imu0b?=
 =?iso-8859-1?Q?2KIFb84TaAJwujvOV3x49nRXAI6GVtElCK+bm6lbkKwsElcCMgic56xzhD?=
 =?iso-8859-1?Q?U73CmTxSDtmQox8fvpPSONXdibC+7fzmIo+lFEUbx7Z90prqVgrgmBvDsE?=
 =?iso-8859-1?Q?NFDHaxdtJr52j8Vi2pkPeV0Kz+vishlQ2kON8TLkUbugZ2cH/GB91pSSpa?=
 =?iso-8859-1?Q?KWXCQHyy6+BOajHwmAUCP5aiwQx2C4A8c1ekXt5lEpaKcbRHukLDJIyHnS?=
 =?iso-8859-1?Q?L0WrKkDyqUNBnSL3K21TbLFeROiwTcr+W2zTUXtkaogpP9ucHr9rBOXVpQ?=
 =?iso-8859-1?Q?Syz+1Nl2KkyVynrzX2ypbV8Il3hy7LXx7r6ahFFg3ClMvHH/MWjVzAcEtP?=
 =?iso-8859-1?Q?LVKRf36RkAUjDBap7mzQMNDMY3VeePDjiU/42WIy1wsDAOkCRaSow4Kd/Y?=
 =?iso-8859-1?Q?MVcXUeP0ew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OhVzPWmSnMEdjn6y17VwehxKa1k+ifQJc9Z0mX95gGcCdEhL/yEUExHXK8kF0CGULbjc6eOWw0m/sDRAqdWukn/vE7iDHb5zPAEths0s/28FbTbHJNRkcmC7vP0jGq9GsYlPNjhCF6+SqBT2MI3d7PNa1tjMVFfupq+x4bDYvJrex8SvNQ2c3s2Efq4vSHyWpF75vVETK5P3firV0DdPSnqFtaHBSWppg7mIXXfQlTNqrNh7C8iNQhYN5CezgRZfm0QfihejQedVtRqzz4mo6VFAHMwk2Diub6rxitY4hGgg986OLmKWkouizYvYrEhSQnzekKc8lCPVXt7YtnEaNQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01636023-00fb-4f7d-04ee-08de9c316db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:44.0353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2N1PknxUMDqI7mFHu+V65XtMsD/SqucOtR7N+81d+qs3ej5FEdbjQ1CUn3SY4jy6U3XqjA5QNJ781J9AXDnVS77ii1+GsdRsBUpSWUwxhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

In the previous design, both the PSP and TSP were started together during=
=0A=
SoC initialization. However, on real hardware, the TSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the TSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the TSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the TSP's ARMv7M core. This change ensures=
=0A=
the TSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls TSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 674307103e..b30f2afd62 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -166,6 +166,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The TSP starts in a powered-down state and can be powered up=0A=
+     * by setting the TSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

