Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcnH-0003cH-JH; Wed, 03 Jun 2026 00:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmi-0003Uw-Pq; Wed, 03 Jun 2026 00:00:54 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmh-0002TF-1c; Wed, 03 Jun 2026 00:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6RFtM+NVcMHsNP4W781MPFxfYKMrx6AeThilA+1uDMH+/CPNu0be39Z9ljIfnRWfIvsX8REIpdzHmc6XaDk2IgYjYXXzNQNZhRe+XLk78vVKmuogVNIhc22BDUeSFS9NEwU+2T1im/50Eb3p/PAnY/3DQyFxhNmcHH2icIusdGOigTk2n1BcphHFWKQcp2HyUABYcC0nIFV185ven33ax60gUkbxNIdP4/HgYv5sOGxHOy5C/P90LEiH9eGs+HEzwmOdRghOkx9LUVSXI0h6V0tkQuIGF84psam1inheojWQldg3cjqgT3dlm8aLzOueYDT0RRbXe2pUaFEuqAkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEabOOpmy7KfIDUNwx/GfjFQSAwECGx002H4pMACHmU=;
 b=buOebZq3DQfnpkC9vkJOphvwoehwodI9E6cJXKT/g/R7bUW2n8WA0VCuOA5HF2kugUmjwT32wZtTtPBje0ms/1zf9NoJKwxIKWgZYwhr4ggWYmOQCTftC1ZOcabPOFVNPPQ4OT/KbH0aI0rPH0eNCEOMOt1RI8Ekd4fawsWFqdBfUmIrMt1Fi8gGPgr6mihlhKaUdnYqcSey3FFwsjLuHruRhcle97Ilou7fte8GTI1+ej+onGy0u55R9N+20F8Dmg76UpJUaywMyoCayNA/A2NDh38lxJxrq4YxtVYFY2T4m5Y+nv002/+aRNBf6kc1+J2yGiA5QAn74M1ObcWFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEabOOpmy7KfIDUNwx/GfjFQSAwECGx002H4pMACHmU=;
 b=ZtIXYYYh9GCU8v9vsbOWg5MfjhRNTI3b604yarOQw4aqd519eJvXfpf7aOm6BO5jUze2N40MAnKj4bGXMggYBaTUz52Gn3VOIRogpXR3h7V0pjP5nYKCT/NhMSlkPESQCsL8M/6t5odFCP0jZpTTVCcm0LKC/uPpur3einMilkda+5DQazK6t/gePFenlWESzgtbE84nQXDX8Z/Xx+Daqjt/cdq2gpK7PgyOrBFunayCxzZ7/wCxIWW5d2yDKeUeTzLpNh82sb8snLQ0w2WB1mCzWBsG0sJD2z91ny8ogKljhVkEKmYbHfGV860bAYQPRocq84+RzTwCkR9PXiap5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6623.apcprd06.prod.outlook.com (2603:1096:820:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
Thread-Topic: [PATCH v3 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard
 I2C device
Thread-Index: AQHc8w2KuYdW52pHfEOixv6RcigWkQ==
Date: Wed, 3 Jun 2026 04:00:39 +0000
Message-ID: <20260603040027.938816-10-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6623:EE_
x-ms-office365-filtering-correlation-id: 9775ee7e-2bf1-44e9-8ee0-08dec124acad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|22082099003|38070700021|6133799003|18002099003;
x-microsoft-antispam-message-info: +Kvw4TY+QsEhdygKnuqjHzpboAOOhuwI8MVBJXyJ5lIbCl/ZIRIFu7j1796qX9yEEnoPyQnF8Hwe2KzfbaQOz1aLTYBX9HuiMqM+wNEizbAJC6+7ASP0D+QotQBBLlvU0IIdOGQ3d08XcatGmMMXqwDRpffZWoJquX6iyuZyC3u2/rIsj5alfcrWUQos+MrAfx/wQuLGHRzKPoMFMcflt3IROknSNWO1IdLuDOcbU8Rox6PGnstNirNJZ05DygYpOkrIwEDf4IjjcPaw3kMGvH3IeCHl/7bSO5rZfq4vNyFEYnwIw/V2QJp3ClGj/CFLak+rJ/lExvfyCNO2oTfrIhUu5k5cFgLh8xvbsjRaMuxVmbFAarkwYsq675gBQPFYy1v8Cn+3FBZ2r/MG48miPsPnspGbryJcl00X4T63Z1Pii0LILZClYlrA+yt/9gF+3F6IyiJNxE7AITlMjWcW/7lSTVfLNAjtAXJhexRaezdu4TbDlZe7ZQ3uTERsvkHXJmHsnol2kfv9lo1zVKBUM4WsBXJus2jRtMpAmdTqCcWAiRnZ++fWbNkfQAt3KCffvfyQjKbOPLFjyUCLJCLunaIfUU2/Exx16/e+eWUowYolu07JX8omDv7tiVfzaMTdG+10qWx1c0TfzOUCy4GLKXguojc4HFjT4J2BEYK7D+yXf6iQHSzuB7xP5MamAAlyxuiJmm1Qy/SqU9lmcTijqPF5pGKcF2kgLAagg6w81n8II2bS0hdqSKdSPaB1MQ3U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(22082099003)(38070700021)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QKFqC4RxaVvHdS/jHiYPdTL8Mi1XUCOaVIbVyyo1JseWhP57erZ1p79shx?=
 =?iso-8859-1?Q?YlXds1dliGgZ2owZ1LdDtyrhM7DNtRDNzge5nkZOKMP//TVo3tdUP4BhPA?=
 =?iso-8859-1?Q?vpiS7HpwHS16aAINvLsBAABmhQ6SIR58E61rfg7nMkSoWk6O11dn8JEejY?=
 =?iso-8859-1?Q?1aHA7xSS2mWbmH1c0mCkstblRUKmpRCvbiYugDzOutdM5qCiewRYxXBk9E?=
 =?iso-8859-1?Q?Rrt7neqziYW9BjQ8Zw/KadrbiaNYLBAiwpmAnnX5cGharaNJA/oQimpMWR?=
 =?iso-8859-1?Q?cBsJqy1quLYpfEx+6U6/pysTa4zI/+OATXpFDi7ppnwebSSrgFxdLYwXVL?=
 =?iso-8859-1?Q?+m4L4kw+eD8IuLP06tYtyriud197i2WoGFJPKJjMl+eOzT6xZI+6avgyca?=
 =?iso-8859-1?Q?aFSeHxayzPJmHIy2Ielu3Zp81ZwtIdKIvjgx0psSSug7JvDo69uJrfz+Kk?=
 =?iso-8859-1?Q?1T0l338YXN+3LA5EZFiajwtjtaGE2QQV+UV5IFP4Mwu3A8NP/maSzcHCKI?=
 =?iso-8859-1?Q?XW5Ii98jVyHnogTbjHoz95SY6FoKs3p1yJPhrx+G9TmWQM1UazExrS6JYL?=
 =?iso-8859-1?Q?P+nW2/o9dj/glsYSWOsLbc1ez3fL6fSF05C4bbbCmT/gkGpaK2lnpiuxFE?=
 =?iso-8859-1?Q?VmUt+J8lqT7+txTXWEzuOnRIENW9FGoZsDy4e9H8zgsevyZ1MjqzvgOQ6Y?=
 =?iso-8859-1?Q?6ZWRUXUWNYDDn0nKLsuGveIaPohGTIHhduFvXr8jzL0G1ljRvApuFekQ1f?=
 =?iso-8859-1?Q?PeEhb4PXHEvI3gklaR2PVMTx0+PyboOF1IIPYXzxHd2k7fagRjr97dpe7P?=
 =?iso-8859-1?Q?Whv69iA2DQALsSEWZskDfD3BQy6gyM1zJeyzF6IOvIoKQJvgAZQkhv/290?=
 =?iso-8859-1?Q?aOpLXGWAHWGDpLYzfj2lMZ+sAJnMVn5PAiQpzM7ijQ6U21+B7+2fMdcP9b?=
 =?iso-8859-1?Q?pgzXWgF9VTvceqfdOnMx9uIlg658pwXGX2h2rqniK/NXgWjt9PYy3DciJX?=
 =?iso-8859-1?Q?TeWvWlMMmYMMBnk5BGqQj0KJ8CapE9k4g2eEmr8Y6+YyI0niJWX/Fzse/x?=
 =?iso-8859-1?Q?7exxt2uusfxnbS+uqpHqGK3aFQKz5zHk8Ccy03eQSH3GozGY5ZVrlxcsho?=
 =?iso-8859-1?Q?hcNQsDU5A/8RDm0QFuOa74+0p9ma6P7l8I2R4n5q8W0ESSLB/EU7+GAzTM?=
 =?iso-8859-1?Q?/ojnoX47M1hcELtpMzBGSgtmN1gFPUUraYA0+BYibhpa5mguTeRFBrW1OM?=
 =?iso-8859-1?Q?UxbW+6bBhVwkSpzOoh92qwFIRO5H0da44KGhUutr84bQ7Serz4TyN96F3Y?=
 =?iso-8859-1?Q?tO2NkJvk+gC5EvrPB2aiWLUtHYrZjKtf5vqinlNuUnxgs134RO25/hr2bw?=
 =?iso-8859-1?Q?402b41BDrXc3zxCZQmlg2cule8J1SCdMr8kw2Uzc2c/kTKHmvCYIMgv4kM?=
 =?iso-8859-1?Q?OS/gMKpb+S9Rn6rKgDK0xwhDzZ4+Go27aquSnc7h8AYnsCjNCM21LUOLwA?=
 =?iso-8859-1?Q?DhIngfc//zm5ih3SLW7xNFsWwWErRG8oD4/AXNjLaqw4LNhRWlZxteoAQY?=
 =?iso-8859-1?Q?knPQWM9y26zxc74zfeEoho2suGELsw8b9qob/ksUgcG11fpVfyJeWuJwVx?=
 =?iso-8859-1?Q?SQ05GlUtQZ9Ik7sSSkyLtRhxuQ1LR+jqbHcl0Ne4Rqo6lAydaldPl5kSQV?=
 =?iso-8859-1?Q?L9+2I+88spH+8YiK47AAxHLP6oiAuePaOl24iV5G2dIqqt6azvhFclaJGK?=
 =?iso-8859-1?Q?Jy/3kQaIEsGefb4Gvdv+O6ZD+LYCcvtkO+yQojUOS8WCgB+2fpsUP/ynRf?=
 =?iso-8859-1?Q?EtS0NkzBdg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fxUYN3k65eHFiDNISI5zCxsPW8LqRU6Z+AlvtiThm+kbQmXFjIiPemWtK5iLQjWbhTuUDGtecTA4v0hJ6lIJne/SAFeHaWPbMpC2PYFOR2sj5uydBPo8E7WnVcT0/EoiiAq6ZCOcKweemRrQ71uNIBArxqtBP7BH+4F1vt/zzm06C5GlCalvfLtNLJVf+E4Hh4V0pQ2XdA6IY9AjgBE+GUY+0hxZcCuUQk39LehRN3h+hEoYKcmlVNlsnJefeROzdYvi13AZ+OHha97y4NaR8lsD7em6Sh+dLvGYwWLw4C+Cge/vvJWKt12LI6YMqVku6UmqnW/cMmUn3TEBi+q9uQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775ee7e-2bf1-44e9-8ee0-08dec124acad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:39.3071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J12Q3TTZUvivltxMaEWBZziWzaHTqPMAc38IblExC3bcNyfKpJfrE5MXlFiKc/RYpE/1ZoJe2MiN5QKah4kBiKUFAz3ir/m9Ebgge2GoOgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6623
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

Introduce onboard I2C device initialization for the AST1040=0A=
EVB model.=0A=
=0A=
Instantiate:=0A=
 - A 24C08-compatible EEPROM at address 0x50 on I2C bus 0=0A=
 - A TMP105 temperature sensor at address 0x4d on I2C bus 1=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 15 +++++++++++++++=0A=
 1 file changed, 15 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
index 1d9b55247f..2b93d4dfbc 100644=0A=
--- a/hw/arm/aspeed_ast1040_evb.c=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -14,6 +14,7 @@=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
 #include "hw/core/qdev-clock.h"=0A=
 #include "system/system.h"=0A=
+#include "hw/i2c/smbus_eeprom.h"=0A=
 =0A=
 #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)=0A=
 /* Main SYSCLK frequency in Hz (400MHz) */=0A=
@@ -38,12 +39,25 @@ static void aspeed_bic_machine_init(MachineState *machi=
ne)=0A=
     aspeed_connect_serial_hds_to_uarts(bmc);=0A=
     qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);=0A=
 =0A=
+    if (amc->i2c_init) {=0A=
+        amc->i2c_init(bmc);=0A=
+    }=0A=
+=0A=
     armv7m_load_kernel(ARM_CPU(first_cpu),=0A=
                        machine->kernel_filename,=0A=
                        0,=0A=
                        AST1040_INTERNAL_FLASH_SIZE);=0A=
 }=0A=
 =0A=
+static void ast1040_evb_i2c_init(AspeedMachineState *bmc)=0A=
+{=0A=
+    AspeedSoCState *soc =3D bmc->soc;=0A=
+    uint8_t *eeprom_buf =3D g_malloc0(256);=0A=
+=0A=
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_b=
uf);=0A=
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x=
4d);=0A=
+}=0A=
+=0A=
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
                                                   const void *data)=0A=
 {=0A=
@@ -55,6 +69,7 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectC=
lass *oc,=0A=
     amc->hw_strap1 =3D 0;=0A=
     amc->hw_strap2 =3D 0;=0A=
     mc->init =3D aspeed_bic_machine_init;=0A=
+    amc->i2c_init =3D ast1040_evb_i2c_init;=0A=
     mc->default_ram_size =3D 0;=0A=
     amc->macs_mask =3D 0;=0A=
     amc->uart_default =3D ASPEED_DEV_UART12;=0A=
-- =0A=
2.43.0=0A=

