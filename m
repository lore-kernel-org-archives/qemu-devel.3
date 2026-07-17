Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F330C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDF-0000Yj-LD; Fri, 17 Jul 2026 04:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeCz-0000VS-R9; Fri, 17 Jul 2026 04:46:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeCw-0003vK-Vt; Fri, 17 Jul 2026 04:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3NsB1yceOIOGnngoGa/4iPKZ2GkUOLiLUCuRbiiV0UFPBNhaG+rNhdihAh8V/P/Nx6WyIM4TXHHb/uwjDbAICzGhSbuNP/h/U07yNSu/jFZpSpEI7r0Bdp8E3oXPaVg6H6OC+eTopJzIjJdUxNywNFrm5WwzozmGHe+mkLuYdKru/RnbWvY54kp6LDIPSXuZnRs8S7tdMjh/ZLDQhSYOS/c3LUpmcdeqVl1C0tK3K7xih2hihoFKBIIuqm/8WgEz2tYnXSKdr4Ec47IzfA5fu4782weti2yYb9BKGHgCaPvbyH0UxwuWRqITocpQ9miIidZ4NLfgvdHovJWdIkYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTV/ITi5t7UVevEhbKYTiB3/+A2/fGz5a1Z0KFZxszY=;
 b=RgDo5WZuk3LO7AVFBg9tqL9dE1O+BQurmFuIJZMianvKWxcqSU/6WAToqq5fk4qskR4mqGSB8XuNy3oR/Qh74RjkbEj7JNkuvoY4AgOZi0TS88ijN2PYmZfMk2tS9e/++84xNrVVJ2YddesfTe+82ywTuLvKsQMz0t9PtLRdB3kRJe7RfZEoKoRAKKNIFsTHieyJleQyBCrhq10dRNQW1TIG8lVZWVm8qJjwWb5Ha4KRPkF99S3gnbPrKUXDJRYZg/aWOmsKCVE4tUgnYCctFatEzYHX4s2pddfArLYjq7Z7oWe1XI1Y2YQs+a1HJEBGfXVgbPVq0N8DMb7oTPKc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTV/ITi5t7UVevEhbKYTiB3/+A2/fGz5a1Z0KFZxszY=;
 b=P6eQNfEXJ7Ej1n7rYxWc85pElgJSkvTXD3mQmqftJ/81oYRA3FfgRuJzAA8CenavuN4c/zy+aYSvnZ6LM/l6FAfcbzCJKzdeTy5RNMto+AQUk1d2eCjXmKyBL2Mk896ZZ0wPocmFUUytMdmWD95SG7GyPaUtz2Ny8N928nPyBJPZBmBI4c6nwyD7rHHJwhzLYDEvzflUJPce8A79AXRs0P80Pj0yFvRQ+YN9W7xoxkzIFwO57Wdj20SkF3odjYgd0uOjLOyQHpY+fUYdhelEFvXGiv5+QuL+xm4z9t4ydTXpgcD78gsnpOY/sp5aNuAmDghUyjpI/eMNDEf2X7lcoA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by OSNPR06MB9025.apcprd06.prod.outlook.com (2603:1096:604:47d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 4/9] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Thread-Topic: [PATCH v4 4/9] hw/misc/aspeed_scu: Add separate reset handler
 for AST2700 SCUIO
Thread-Index: AQHdFci0CMdhQo9LqkKpmqx+uohXPg==
Date: Fri, 17 Jul 2026 08:46:05 +0000
Message-ID: <20260717084559.3477061-5-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|OSNPR06MB9025:EE_
x-ms-office365-filtering-correlation-id: 562adc0e-aa3b-45a1-8241-08dee3dfd72b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: ocFMjJJZLX+QVE3RualoEtyIq/cnXwLWE1qeP/iuIKxpCFz8dicV/bZA9k4CAKZ2lHtWDpDRfcGNSOPM02wRtGdIyq9se2WDuqRr/sKfclRrSqCu4eZMA+xmvupfxrmJell0p/Gc9yUmlJ272SFO93RcLqYiPCks+mQYP2eJJVwN7bkHix80MPIM5k3JByT0hhErvK7xpxCGJykR3yhPml8uD3cDT9oC3Zk+ePxz/uQJ79tePa1YI4EtMakBhsY/LSdskC1GckI0lwZUJ8B/1mwdSZqLSu4mVpeqUK4fdSsuhpzkHGUiNhwQlYQGr53THxYRQO6R+JFaDp8+4IbLPYJXIBVdu40jlmIcnfk3QB+twgEURz0AlPcTlixDI5O/YBCme6GxPvqF17g2JdYBLir1YQUrjAFGwW4SxF/w0nBjQKH3UBLdnQV1yCmUPQxvQeIssbWqvF5KIVEMBmWBjBvshyT344OZMtZnYWbzL1jeIV23rQFRDfO/J/f9HX4wvo0bfnSrKqUqtnBe9DMak2IbB/h0/Uramg09q7SJb3P27c13PVxKrSh2utj+5GNh3ZihqmQ+IXvVuYCgc8AcogQqFcFoLHEeLO5W1XJ9Kci1/i5djgychrJ2vSJGy03yLdyhCwUNeZf22bKjju+2ttr9diYuYjeiSKFnj+AXM8z8R9ab5rysBe7J3ALS6Js43Ac63jweimqvfCOCrQ8bfuSYQ5MRwKVvOQ1+qa92zSG6DqXqZjbqep+kjywQ418U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q5MSJrpyhkAt3rcMY89Pn8z7IsGmZ97vgt9nRWyqOYcyIo52SQINtncZl7?=
 =?iso-8859-1?Q?iI3yFbqz8fnW2k5O+YbG8Wfc4lzKN7xMGNTA9WL8oTliVAzADeY1up/4Hm?=
 =?iso-8859-1?Q?ILO/VO+m3a0MKGImTrVwCakqoeBQY1CwKn7ZjSJF0oryI5AMINtmQ+ctws?=
 =?iso-8859-1?Q?q3lcCQ6aBS128bPDEpILvsSD+bfy5MrO3QbnPAaOHn7DbeP03wpR+wIRz4?=
 =?iso-8859-1?Q?6MEs+T4aWXeEt76j23P8mu01GbZ0JJVpKLXcS5UgidWVgUpUfPxF9ThGOj?=
 =?iso-8859-1?Q?OO708UncFemGvGpZDDnzcnUPS6JjWX8tC+urhJNQI0p2lYUoifhnqsysOm?=
 =?iso-8859-1?Q?rR/kL1s6fIKrdgvgzkqwHIuAeg6lHC5pebRKqM3+cot4cnGL3yKPAsBw3P?=
 =?iso-8859-1?Q?8ETcLV7AXIpN/Wx7w6YMqzmMMF/wGhYoAXD9gju8nf1UCOgnU5yUMCLEio?=
 =?iso-8859-1?Q?5hEktBPj0kWVxxqivdZi8NZjG1P6YlCnzH5a39wXKkUGfzuUFfpFiKAi0a?=
 =?iso-8859-1?Q?dGXUghV2aGLxq0u7BQFyoenPRSO6Vn216RCG1qefUWElrOLGGGnDyRK6QZ?=
 =?iso-8859-1?Q?sen9nOidDCMoRUSjFYX6BQrf++0jzmNjc6cCLoGpNCZ6Xhw1SJeU0H4pAm?=
 =?iso-8859-1?Q?5suHRo2I3O5vk+DBLLjFHOsM+JBDWAI4ub0P1NaCgiFfsBXvHrJqmE5BS3?=
 =?iso-8859-1?Q?tmakeonVppHoe5UWmNF2rsf8rN3IDnhEBLFTJvzYNH2eenufgvbN18kIGB?=
 =?iso-8859-1?Q?JpGAvabkpwJsKkWWq46b583HbdbbBGG9ZoR4ZL6ZX8rR2ZtUjsV/c/eyZY?=
 =?iso-8859-1?Q?296WeATWE6w7BZZmZGzBs3xBFOCSFOO+EU0Cxna2w7PxILehFx9O5/u730?=
 =?iso-8859-1?Q?DXDwYmYXB+ua+bTOVEALChquSxRvexLbzDOs9GkVLCYTgiv4U9Sh4/TJ/x?=
 =?iso-8859-1?Q?LzmmntiCkzw+qVpkdns0mbAM5dQH/LhnnHk2IQ0ds5C9FjPibV0EB3a8u+?=
 =?iso-8859-1?Q?NHp0Y5tQ0H7hBqVvz4konWVDI3po87PiBdw+Jng1T8I0aBQw+9/4+I3Xds?=
 =?iso-8859-1?Q?DcvFaH8sOtW47b0/ROeA0gxP93qb39SbmD9MDEHhHvCGZwPkOpENYjK+K+?=
 =?iso-8859-1?Q?y2XJWEjGLIPmbUl4m0AkiNsqASr6xAdslqTFWPWnVTPMh4f35+SuXcsH5O?=
 =?iso-8859-1?Q?esQmD3DVL464AvZG6iaD/8PZV0QEHWbBmHvFZg+KoErYwte+MTN8ydg5ZH?=
 =?iso-8859-1?Q?rl3zNUZUDbrh9NPOBlaIlzqCHtbU7A2FJDmZ0GxnnB/Dlh2nNs9g6Ko7h2?=
 =?iso-8859-1?Q?jM6SYptgqcSRr87okT+3vyfJXldGIasNnr00l1k4AP52/QV8aa/UaZ5frt?=
 =?iso-8859-1?Q?Ec6IufHyD7zK6ysQGYT5m3wmJkW/siqkt4NgYRTwXbm5B4lR7QLzdFv+K5?=
 =?iso-8859-1?Q?Bx7uOWl6rkGmB0C9IqD6PlpZtEDuC6xMhCJ8nUfsMNsovgD4tvltA9KADA?=
 =?iso-8859-1?Q?UCr+a1selTfE/Kqf9O/5ANPxyXcQzJjUDytp5GOO/N/LaTiBs9s49RNuI2?=
 =?iso-8859-1?Q?zhzssaNRG6HyDdqOVbDm0oAMFgzRkrGsHio/ICt8+NMsu0SpSRSyQJxEDR?=
 =?iso-8859-1?Q?SDyhZWZqpaTRyIFTfzc2bo+9/eahr40umVSNN1p9ewdkjXVmiH731irfc1?=
 =?iso-8859-1?Q?cKIiHXkvUixIoQeQb3vPEAfFA0jbhxJN6VKtUFdnrQYyIVS1OZ50/baVzZ?=
 =?iso-8859-1?Q?hG1lB2RATbK4O/ngGMLiIvmZc/3vN5RX+NI4Lx42DgTOZxSVZSM8d/YNpm?=
 =?iso-8859-1?Q?kv5RzHGryA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L4bMPxpzXK9znElRL3V06qLPzCGVHRQ30nKHR3NDzrAXEnkxmDU0MmbxIKhukQbsDHHPj4nf2kVW3r3n25DwTAGyHz4Dh/NOEktSYe1eXt/l9lrfO0+sIarXdyv5jeCazGBtmfrRELTWZZQYtzvkjC/TSprXeGzysyJFeO5hJXkfRpe//7DZ99V6rqJ0z/8RURx3PNFuMpbHJFpXt4ShP+VOVtzE9UZ/6NeheFykO080PZEQRUH2OOaPyVAAFyQ35yUaz91QkKUWn2RPoXfgt7jjvl5fm4x7HYtHET/4ptJhuk33EGtTs8R5tiNc15zheHrz5b4fjglnhQaxEExXYw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562adc0e-aa3b-45a1-8241-08dee3dfd72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:05.9788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3y7UAPqI5AwFTq9x2yTciweC8ZB8dpTKn1ceVwpIgxOX9FZSQZdMQuLaPzV/az91dgJv32fyvRgI+uj435paRt03i6Ylj9SDzT1d85sRH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9025
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
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
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

