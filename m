Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77CECD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgb-00042N-34; Tue, 02 Jun 2026 01:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgS-00040K-So; Tue, 02 Jun 2026 01:29:01 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgQ-0002fW-Mg; Tue, 02 Jun 2026 01:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuxKw/ZQLL/vV8AWWdgEylncxD/tm453W8TTpG4qMHAiYnkg5z7G0szzkeFRXLcljT6CjuqJhYsGDFu2lRBzEOglp+z/gJRta2822KWJf4CDTnEATXe2bqEYNMHtb++EWirm3Gm7XNlYJZeiSY8HqmhvhrkOD9YlkRXQH8eIEJt+GtwH67Aw/52NnFJJnCbePblENHwZwELF7gbd6eRWpGQpeIuugCcUahKmjtQ7aDTmS5/t58scu93O4FfCUPM/fNuUluzdW59Kex4sRgylOO9hreYfvorSRpdAlHXypoB5I1KX4xg2/phbvYDgAX+pD5qoG1L8hhBLOQX9wDsqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/w37WYK09FTwxaQXZZH5wZ2TjnhflZvP1M6boyz9bs=;
 b=fYMTo9yqkw4MarjyJ76EHeYj2K3sDqisF+RCInwtr8trWMYkS00T5UDcFXacovwU8ZoWmfp4sBPL8aLn340FbdQIMBlL6tom5d3ydEKAiuP60xwUXLhkwBG1BuQdh/k6kNoshKaevXq+vjoQ3y1m2/BGCkDQus22NlmmFpYQcAA/XYeZvjE9y3owsljcQFFlqhWDWHuofiAnqN6/XM6Yq0XdZutpaYNBUP16IpuOm+yrJNQJq58pMlS7MKsUUtxEGRHoREcYy2JgyxoUyj7cftj5pLw0RZQqRNb54NjymQ+9Y4Bz1oPjbdQ22C0usibxxqiLletNeZfhGHmhFqeHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/w37WYK09FTwxaQXZZH5wZ2TjnhflZvP1M6boyz9bs=;
 b=gdOw/1X5CabnFIoULNwQZZqbWtivOqc+8HQkV+bHwOB+qgY0LLYOvlkOVr/9pCtp2bSFdEZqlWsJB1AO8z/T9cztdpzh1YIKap5zrKYyKXxaDuaZdGg86ebGEOhe7szEYhxaVZGbZdYGNK5Nei8J5m6vFXH95nidrYDFS4AWyHKaJDupVSqe+KG8u0jzFvwXSyilsBsR8rcmk8Cq/aAHJZLCOWskH2gOpyQ+bWa6HTJpqkAe1UVRa8KtN1dU/cM/7utgm88K/J3HvP+pcYFqHR5c5uQOUhpis8s7PoHiUxzLZROHds8m6P4EjRyRNPtf4Nyj++CGvHjTUmPGEvm6Kw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
Thread-Topic: [PATCH v2 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard
 I2C device
Thread-Index: AQHc8lCqSxHismjzOkG6W4XZ3+fb1Q==
Date: Tue, 2 Jun 2026 05:28:39 +0000
Message-ID: <20260602052827.1535299-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ef3258de-170e-4b14-20ce-08dec067cd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: PuK3NwxtL6ktUb74cWCr4y46zmM/H+PWCy1DJzDLHHE0XnVuL5DiEZsTgYJrdospojsoRJtHrVywgPD8ZWXvJSHNahOP+yV6vALoDpE77XE4tyBxVsP7X2Ykltt0PYG08xX4BKAYClaFW8zsAXVeoqifX643I5tnfuuGCxoJypcr7Xm/JgA3G2fRr6Mm2wivfCKSCczHaH0AufRnrUkMe9Wt/cD1XdnbhbDB75bY9n64SMtZ8V0GHTGs8JyemH9Qru3yEw8BeLfvi0vOST50CV1j/XYx3jZ3/oi3TdLBxQroi4j5jlRoSLtWI6N2/A+PHCZvurAEOrfzyH/rJ6PjMujdXICD3PuKqdwR5KdS9UaLswglokbBj/dK9y2bG///htJecXliSGYfYysOh0pAtS7fND8C+7r7imVcUHFRZFbo2JnfDTOHMyh4Fvkw40AR8qsyM3hA//XWk++7Iw1L8iESAwEpzbiLqJKOHA22gqB79IIB9UhTgsk4hYJMIN9FBy2YucQbQD5v2S+pElNYva/BxC81Fn1xKisGNtM3u3CrDQHjwobUQY2+Rte+7aaPhYrF3BCc8l7wfWXxQ590+Qcw7GNlG3LqYYiCrmI3/KTV9G82XgF5BknmjvVrSfb/u7r7ZcXkBjlAOqvHCka7ey1eZj72s7Sm6s4+VU1LbI16CSQY2QPZdgjSfFmqv/wqIIKj2zk5vM/KDOA/uBcPaL/UoaUwo8VHlbqSygWF+YQiUfuRwG+KnhQFkYgF2wUM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UCOoCswmUBwXFHz7pu6OkBFDq6Ms7wo3jLVdqj2jDN+x4NSTuHLtXAC9R9?=
 =?iso-8859-1?Q?jAeeZW/GfSGaB6vlN69T0SUj6b0ziFPAvH3uYfypc5jv0IAzGtwGbtpLVx?=
 =?iso-8859-1?Q?/n7KE4XrCCv/Ff+2qMFD6I8Do9ZMPTEksmLjKsRNwNem13zgmrr35bkgmm?=
 =?iso-8859-1?Q?QB7pwvxkLE7uTuq6IQZpzTfELiBpxpIBUwIEtJTfjjuKLf182YTybZse1m?=
 =?iso-8859-1?Q?FLfeLXYz3uPFD3tAACHHBZApl5iW5yH8mQdQAgFGUAqSH1iS/dKbSErXHz?=
 =?iso-8859-1?Q?Ja1z1/nucmIGd7DEGQm4llQD49XTdlOeSURwOzqj7IOodltqrZ+/D6UAxq?=
 =?iso-8859-1?Q?+V7b2jPhynB5pAgHPdl+4IDxoj2iKsbSkMEcMnPekqCLkox2mY4lFJz36N?=
 =?iso-8859-1?Q?waUBzGH4SgIIhQ7IUEqAUPV1vGMQX3q5YJh4yoZ+6fijM6TTwsrE5zFN3Q?=
 =?iso-8859-1?Q?3A8vjnFOyTm31iktNDCpC2WS5a9P3mCKqaPZw6wTQ0tPEupg3DXGVUNYwj?=
 =?iso-8859-1?Q?tWUq4ZzgCBagFLxl+ZQ9KKMJyTRD8mu6+PByqrKWJhmLK0I44uC7kS+Qfd?=
 =?iso-8859-1?Q?AQQfNc5D41mojwcwd6UIFV4OAmz0kVZVhxrRXnqLR+7mCQW7bS92V8Db8x?=
 =?iso-8859-1?Q?5v/RVkBd6AfIYny4699EyIsVnqPwrhqdPwn1B+BDt6CQq06j7SkDw8agXR?=
 =?iso-8859-1?Q?qYPyINafaqc5PiztDX+6hSWsZOqp/RJj3t26hXPKe0HfvEhbpiG4puoW8N?=
 =?iso-8859-1?Q?DcHiD06sNo6wgheiaqB3n4grOJQauBwPzgFsox0b2sWJap9sMJgqWEtzT6?=
 =?iso-8859-1?Q?zUewRuC+ka1vDXOUaev2Okd6+MsgvzV2L9q49cfvcOSzDVhneZcx7zftuy?=
 =?iso-8859-1?Q?HcFTRxiN0asjs3kE4T0+H+HNqmbMx5pCU9H+8geKS4Ok4nQ8k0PJMl2jvj?=
 =?iso-8859-1?Q?P4lwTR6hWMXWGpiMVGIoW8cSAcEEWtZnQ7Cug/xlGDrb9Km5+l1jcyq6nH?=
 =?iso-8859-1?Q?quGhRYtLLiq2B8yp6+ZjrQx09WtyG+UQSKMyjfG2YPNJvi3NW/rpPOLrqv?=
 =?iso-8859-1?Q?D+LgqVCIGF01cwXTEMXUqoPbEUgbP81opNLX9ejh5s2HACyxw20ctNuJwd?=
 =?iso-8859-1?Q?t7jjeQ/D/W3KJJquv0LuDIFM9POm5ASjNvivf5cf7PlRnIiBVI7TnI7h91?=
 =?iso-8859-1?Q?spFtru1Nb28BqCy34Smc5ffBfhvwAJvDjBcMYq3g4dSux7d75LafSnn3ab?=
 =?iso-8859-1?Q?39FXObvDblZ2z7HyBOc9F8Kc6Hf/+R9sTX3MNGtYbm2tqkxfVOHU5sgWme?=
 =?iso-8859-1?Q?o6begNIAeo3nUJQVyNxWxt14PVnsi/29oAQRPUswgLwSluz6wvi0d414BO?=
 =?iso-8859-1?Q?UKo4jQvuGkQ6MvQNaDBeFyB6lZdQ+45YNBbcjsmGV6yJgVTiDlUvm+xFnW?=
 =?iso-8859-1?Q?NMEV+ySWpW4g5XV4xZ3SBkiQLZBJruz2HL2kYGLgb9Je+pL5cF3dfXrzxF?=
 =?iso-8859-1?Q?uQuwp0g2UWO7FXApUPReSsEo1XGoBWPCV/rGVmNf6xi+2sa76/BMwGHTFe?=
 =?iso-8859-1?Q?rcJBxHtbHMpaMlrG8CZNBXJ7Xu3cz+rxwXZ5PKl3JCEMYlUKKKMkmMAo1a?=
 =?iso-8859-1?Q?eSJG28ONeMizbdCQITzPYTFYE51VZ9l/sGlhIeVu9AyJEZVuxp7i9YDIHK?=
 =?iso-8859-1?Q?5pvKpHaX7qIOkaUVP9rJR7EMq+ZSnv0IUlxkBw+4LI8wLHTFqsR1Hfa857?=
 =?iso-8859-1?Q?4tMIw2i2hF+WsOPqIrvAu4sXBjKbT6hpjNeEPh48UHR5FdgGmmiaVkKWY6?=
 =?iso-8859-1?Q?PUu2R0ULig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rl/1W2B0ANQMM2OQFtCi1LEb4ND//Gyc3PkaRjZLTNPHfwI/QT00def0EniHZ6zP4qU9slmKoaGamxuU3tow40HMVhePOxE+L4nmqGBmKmbW6dAx88NwecOIBDxa7sB787+NAhnh1qYgy1IXuDO2vwH1Z/b3v1el5bWbhchC3F5TDnaGye1G0Rx9VqxBax1A+VjwYgUvDK9m4w1Wc20Ae+GXNKF4uHbh4zE8jP2LAA+yQN2KsfL0oiog7h3VGBlyMQypLaUOCLrSZFOS4oL0eDCG/zr7t4yRGGnJbUZZqNVdQiC/eKQC13ZhAU/fhfYAu3hmisEpRwhCEvcz1Lwatw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3258de-170e-4b14-20ce-08dec067cd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:39.4497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+UdXGZSNppRv/Q0nO5mEZcVPPMks2jC89gRKeZ9SoybATHPlfb4+eo5EJZX82iMq/AfFlxQZMdTecSDZNBLVlFxd7jMUoPfkddGxqUJOBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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

Introduce onboard I2C device initialization for the AST1040=0A=
EVB model.=0A=
=0A=
This change adds the initial onboard I2C device setup flow=0A=
and instantiates a 24C08 SMBus EEPROM device connected to=0A=
I2C bus 0, matching the current AST1040 EVB hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 18 ++++++++++++++++++=0A=
 1 file changed, 18 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
index 1d9b55247f..66f08ccbe6 100644=0A=
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
@@ -38,12 +39,28 @@ static void aspeed_bic_machine_init(MachineState *machi=
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
+=0A=
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */=0A=
+    uint8_t *eeprom_buf =3D g_malloc0(32 * KiB);=0A=
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_b=
uf);=0A=
+=0A=
+    /* U11 LM75 connects to SDA/SCL Group 2 by default */=0A=
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x=
4d);=0A=
+}=0A=
+=0A=
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
                                                   const void *data)=0A=
 {=0A=
@@ -55,6 +72,7 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectC=
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

