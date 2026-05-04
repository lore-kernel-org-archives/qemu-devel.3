Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69E0CD3424
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRf-0001cz-Cy; Sun, 03 May 2026 22:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRd-0001aw-KS; Sun, 03 May 2026 22:54:05 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRc-00040F-93; Sun, 03 May 2026 22:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhzWXtst9he7BmxXzfUogO86P8/3jPkdlBqT5MzpjwxYEJnIPsks7dGSLinNUN664T3MlBhdGD8bD85B6aKP1ZcLzweKTQ8R13zjOSs1o1li7BGyuOIyeCTmmp0hJH5eKdYZF1OB8nI7kh1r9YdJm0FWIfe8YqNo2qN8qD7d7Dbwi76yorqYhfvaeAi4rM3KLsF7BfqcP3pvmKYhLTXuipHAgvv+GUAs4I/LqfJNUnoWmTZPTC0LkBg0B6EIu2tz2VT6wLxR6G8BvQ5PRU2kc9vdsPMpHGXv6XWffbIpumjWHiyyH0utf34v+o2nevw6bag+RdiTlUjDwyAvhXlOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8opvPGofLR8dFt/07zzM9lGCEIygy5c1ByGEPsBwMTo=;
 b=BGPc6GnjKreIAxvvjWEBsZEXARMJEQo/0vy08aoyBbaUAl85SfYav5KATd8dDfQhCXkrWjbBMZiKwQAFbcXRzqeieNjtkNavUYudKEMKYothsqkO0V3DIXAfeFZoZHJQryARE+Uy/WL6B9JX2fQvze4HB1ufCH23Zg9Ez++yp5LpjB6fKbnHDrTnKh3uHRDV4wgx3DcVQECtDgoQjFRvkEiio44kj1sgc/Mk8ckURcV64vexD1QqYvqHKbP6PD5ShKT52opsq8aETZZgExZlWC/lHQH8mvFgQEw39eA6fgDRCLAW0le3wj+SOvpvZAlCcBCdZqXQVvX9gZMEWEBTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8opvPGofLR8dFt/07zzM9lGCEIygy5c1ByGEPsBwMTo=;
 b=AXmRz1M80U2jjlPzaiN9Q+RNB96uuuzDdBzK+Ag1zfVu85PhqkGMQ6aXH+w7kZgC9qDcY9w5jkUr2sXB17USNd3AaBMVg9uWmoDbTxnUjjB8fN7wH04GVwwFxOsqlR7alkUpf38Aa/ZoPD71Bp0mwBlp8j0XRPUANWGoPaIdeMQQmXKjSIIxU/8VQUoXZHF5V/hvXli1wA3ho3wCBpA71F4eLtHaroo+2OU8nSpQGIMTptI5JsQkDg8UGQvPE0aMXCaitzykCkDk9qsWAAU5A+GsF+u+42nX1li4tqsk/2icmEF/c+yNw0zWqIrtA9/cjhMmmWS72MBYrzDGNPdmdw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 09/11] hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
Thread-Topic: [PATCH v6 09/11] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Index: AQHc23E9LuUcfcQZ7U6ogE/V6lW0Dg==
Date: Mon, 4 May 2026 02:53:53 +0000
Message-ID: <20260504025342.1452605-10-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: f71cb072-32f3-4d2d-8e84-08dea988607d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ihesalkcCW+4b4XAg1rYf0uaqGc1eSBToGZSPtAAhU/+OIW+Nm/KqND7rAgIQuGAF85KKqHXJiacX+vP0+ZVCFTxBdkNV2LTB/YYUulfiPLf3vIF10OJqbFaDXJBJEBnON7BcbuGVd0yNlqUY7dntTnrY7VRQ6dDz4/FIPOk9g5ryfMy5L4DUqnWJ8ju4JmPX0IM25OeNeh5cIT4qMcaJgXegvJ/jHIkuKFvK7nYq1O8JfRzF8DcMoMeHJhZoYgzB57L8mfhc0AwAS+oj7zwXW981PobES1qetW8e5f3pQpzd0sk1BQTHHblp/4W1Vyw+3D5+krx9IO26AXGrLQ/0ikbtKhtiCZl9IUwbtaOKFAdtm2kegwuqJmv5SFp9EQNPMsNWeH+AbpwjYR8HH2C9217a26tHHmwAWm3BuFSJpQLg8MCEIbtMJHTw/fp/cpRJcLdBb2DCiX9cgHQd57HCyeHnNJXHbHBBcDOKmW7iSpK3SePLSMC2we6jwY7vRQ3GyigR7TjGXVypliNY6GLQ3PPt/lrdAY7jAfevly+8ZBEjxqVEZc6LIU7K5eiNGvknY2YtoLYuHYNG/lFeOFnJX+Y6NfLGMh+GN2v4p4tH1Tj5CqVytQu2rGpLZC5KNp33WC3qbPiBViOUwLxuL1Sqf/J0NHXF81NCCFACoClM9wBRl4B5ScXmrdYpY9Q7hAeBJLYhxdfg0sP8fMVHEE1TgQ8xQC6VrXynNm9QLLKqrcw+EbQe6erlq9IbZgrIb51I1cazsu5eLbFU9YAaIUFUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?afkdZ207GaA505ozeRErpwbqd7mU6zT5FJrqxzGYFJx7rYtl/dc0oYZGvv?=
 =?iso-8859-1?Q?m3xAhUVKpqMnulF+x966dyj1WwdomnF46Sk09JhtR9Sml7LXzwmOgRWzrV?=
 =?iso-8859-1?Q?IkA1vnERBxRrjN8vdnuX/12URzmw2i+AJZvHu7KmqeP5g3hm+i//erOPjl?=
 =?iso-8859-1?Q?0QvZ7d4xgtW/4VMmSE5HQpH0RV930YNgLmQSG3oKEKGyYZc25/h3YmVkRC?=
 =?iso-8859-1?Q?azknvanGb12bHyIIaXX/99cotMYubMSbqqY4B7BSFQuF3dXpoawWjWsSXJ?=
 =?iso-8859-1?Q?GyElu6HdybkV665CijAL9B3GrK3aqdBCL4NidCfoiR3xKDOcOrzUblIzXj?=
 =?iso-8859-1?Q?ygaPA/+J7FTDA4B0rbTYy7jgv9JEZpOEcKMBNEHPK/vav74DloacLcYcjj?=
 =?iso-8859-1?Q?GR4Yjey3aLkiVCXSci5sW6jERHieIhCKviV0FlZ+JFEkbnlOZs/oSlukDC?=
 =?iso-8859-1?Q?i0qbZyzVUDxlUAsrDJxeMAsMfHnWiyfzEbEoMID+89sLMbjYvICb1P2FVp?=
 =?iso-8859-1?Q?DnHXpBGVmYtk+fgEDvwbgQc4KZV9TEa809ZiNQa3J/TC3E3Hw3cmG+4ORb?=
 =?iso-8859-1?Q?3sbAb7mfvUm8nolKXIJmsxcAh5VSIAwoBnj8sP3X7KS5AuI4lPNn/MxoZv?=
 =?iso-8859-1?Q?LFyL3VGuKkh9HfcNXYRcIL1OEfn0RMu2ha1tglaFz9pgQWC4FcR1Me1yyu?=
 =?iso-8859-1?Q?UBQB78V95DXCD2qiLiscwg3kBD1g1Ac4OnL2crorBD18B01NoG5dOnR8+B?=
 =?iso-8859-1?Q?pLJxJfzZosQymdFBLFS+w+AdryGFd4Xu5LEVCyxZAGJjXHhvBAXzDN4KoV?=
 =?iso-8859-1?Q?Ia3bAEjx1vxTw8Xs/0yBLBCjHGD3kU/fWrSNjCDpmJTC1wIr2mU/hIzN+n?=
 =?iso-8859-1?Q?qNljQP+oPpQ3uuGoC1QaRp3NhZaoTGnGvGVS5b7e6PnsP/TAv7ApAFVyS3?=
 =?iso-8859-1?Q?GcpApPJGIn9AM4PDNJamtK4GuZQeH6XZXtrT+pajQrPEufK7rQ68BFyPKr?=
 =?iso-8859-1?Q?P9q7r9snWJjUBuNQXt0BljxO0Oa3233x3VWanmJ6es40uKL2FUlZbV4gOL?=
 =?iso-8859-1?Q?iFA6sEvooM4BCxjwpsdeD8sqjXFBqE1hb6f/8kFX1W2rsl6qwTA/7pIP1k?=
 =?iso-8859-1?Q?aiimBd71W+Bm4FKj9hgKqJeLtV4b2/GEhI4f/Gihcco88bVqm0kLtPIR6c?=
 =?iso-8859-1?Q?OlZ3sc5n8xyCWQfRqFWqkTFpxvfOmP1sNPAobfXEHEYzA2IGLiTKhvjkZk?=
 =?iso-8859-1?Q?xm6o/DQM+wgqfPp+ZQXlB93LK3v4XUvxIMR0nKWH32J/OPjXhqFjc/0l5s?=
 =?iso-8859-1?Q?4/zzh3P/F9hlszfgLr2IdCkGNCd+iIkRgvXabm2UtIJCgiLctV0muMx3l7?=
 =?iso-8859-1?Q?8wHDN6gN8j5gpjjokIzuB53TSsOPVLDxkGMmwK8tozX+YOi6pwcBVmttqe?=
 =?iso-8859-1?Q?DbaWRsarvF3vRyFIoxyWtZKjZ+49KQZJAczVoj0O3pFlk4t2JIz8HGM4Yf?=
 =?iso-8859-1?Q?1m5ylMrjto512VscmGSMDhiYKSoez9felOTlQKOZItyvUDHiAuGlGxRCIf?=
 =?iso-8859-1?Q?7SCXoi2J116AB8O8eizs9sf9wQc+poJtFDZjaEBkFQj3ia8QcAAJMyLrg0?=
 =?iso-8859-1?Q?8qVqBFonac3OW1QICuBih2xYRoRMonTNd9LPOLGu9jl+0d4q+zB7O/uE+B?=
 =?iso-8859-1?Q?5XPPHphhOWz4BqRIPevM82aaI6bEsWGt/OTxMfuVo/6klnm9FNkdUvhCF4?=
 =?iso-8859-1?Q?pIUB4CFyq31cXhtG1ey3thj0jCjYVgGw+9xTxgs3kEDxJUHUAAJ9TRQj8E?=
 =?iso-8859-1?Q?Od7UjAT0Kw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NbxtKRtLh2UaK1GByki5E7Ob5pQ5oqUQ7YSxrkTZDmq2dw67++JRewJGpaUg0jw0JPZ9MxHNhYgANi6XN0UVEHEnuUozHp26/K/ZKALXQIzCt6Ea1jd82VwtSV16/DvTVPB+HAaBzf+lbeSM3DBss1ZBeU+nP0BrJmGbWNQJggilRQHeOiFveeq7M3Sp/qnIdWb2xevHuaa0v/wtPol5Jn3TGoINVSUZOkbkQYq3ZysmJ98Q0/hnZAdQ+LFtPGfvt/BRM9cVaG1FRgzjFjWPL6uiMKqeDGQa7DxlgB6KX+I2K+bHk4Sb3UBy/yw7VWFMUzmujqdQK0rEyOgQnz4u3g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71cb072-32f3-4d2d-8e84-08dea988607d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:53.2230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHEBwlFlKv7jabG8WV8nS8u7i3bzz/rhfZKiZ/HLJ+wjnhxtxu27TnKQTzA/eVfaS28RU37oNgSsAQeL7SoM9K94pMAWRfxbWbggl63H4Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

On AST2700 platforms, system DRAM is mapped above 4GB with a base=0A=
address at 0x400000000.=0A=
=0A=
The Linux EHCI driver programs the segment register to zero when=0A=
64-bit addressing is supported. As a result, descriptor addresses=0A=
derived from the EHCI registers do not include the DRAM base=0A=
address.=0A=
=0A=
Descriptor memory is allocated through the DMA API with a 64-bit=0A=
DMA mask, allowing descriptors to reside in DRAM above 4GB. On=0A=
AST2700, EHCI queue heads (QH) and queue element transfer=0A=
descriptors (qTD) are therefore placed at addresses starting from=0A=
0x400000000.=0A=
=0A=
Set the ctrldssegment-default property to "sc->memmap[ASPEED_DEV_SDRAM] >> =
32"=0A=
so the upper 32 bits of descriptor addresses are adjusted accordingly. This=
=0A=
allows the emulated EHCI controller to construct correct system=0A=
addresses when accessing descriptors in DRAM above 4GB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..ea527479e6 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
+                                sc->memmap[ASPEED_DEV_SDRAM] >> 32,=0A=
+                                &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

