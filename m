Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxHE-0003RH-P9; Thu, 21 May 2026 02:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGl-0003HP-Be; Thu, 21 May 2026 02:52:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGj-00083B-QI; Thu, 21 May 2026 02:52:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLxC9po0tu9t/nb9tiPeZgvtUaAEAjkD1s8w6+/57kis5EOsQT3goMC5TXN7fRnf4HP3B/e/WylvlZU+TWG9FWP38+nwqC5ktiiOXammeMv4GJWn++fCVWr2R+hDvkddX5WZR65WLr4y3E3CZmIk4cG+ESJnwm2W8vHrBdAXG7VPr3Kf1ptuxKGh6WNRL7bQXGB2+vBD96ur/qWGMM3muoSn3r5nRlSbo2mAaikY8OgQ93L26kvYwctT6z5jmn7wvnBLmUgRdWp8+FxXiOuZVJ7lbeq/BAdkutAHCaudMAtaMjF7RT162P782//qzVPm/e4qUbI0EVVpFUk3nq9/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuMa3Zy1/JG2Pc5lIPwPmKwYfXujwVwUhukfIAyyiV4=;
 b=nmJQcaNyeEbleuosMGAS+xHABfgo4YubonjP5XZKLuZ3uvlMLm/GYReIoe6XLxEcn0TBlQXFahGk/f9jtCYJv0tdzGHlNUkZ9vWcej4CgROxb08KxitCIlFDh5vl9WxdKKS6uAZ+dFUUoIBAWNNKqPmPxwXTNc1hExXfeGtGCTfCjUttei8zfTxk5I7gix3g6l2OOJuVFBODOb2mmWcOaCWCAwKA5pTcEjn4joSTQRUjwzEVQNJf2CE6yFNoA5C0SKDUsi5Bml9eXWeFcDtnrvTSEnrLfHcvJfdsuHy14Y4Os35UIU1z/QC4SUlEMOvA7oVqO8lkWdoStM+d0m5bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuMa3Zy1/JG2Pc5lIPwPmKwYfXujwVwUhukfIAyyiV4=;
 b=jPw1nv2z2a32n3yv7WnM0DKIzCrqooPyl1U9ZP8LF4CKz4jxc2DKLXTUuZhX/vrAiaD5+s2KDpKuH3wiev/lWv6jTjp6LQD5Rfj3wwWKlRTMyJdMdFdAJtxPyz0ihS5mq9ydESHXKEkFQ5RnVwZSkDMabB11f/5AjEDQicuc0EEQG07jZ8rJMGEeh3CY2UK4KPERMuyaYZ/O9uThy3Rg0B362aNAm0JT3xTVWV8pZxZbpURcnHzECErX0hOSxGx9K86TbzKcPSuyu9Kkgp8rb4KlSzRNLa+IrFgLnmab69XeCmwDJ7qHQ3HkKK87j2HoDNCRUrSIe1Wdc8OfKXb+qQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:52:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:52:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/4] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Topic: [PATCH v1 4/4] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Index: AQHc6O5Y6WhPqNo/U0yF7Y1TsizpuA==
Date: Thu, 21 May 2026 06:52:09 +0000
Message-ID: <20260521065203.3713466-5-jamin_lin@aspeedtech.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6044:EE_
x-ms-office365-filtering-correlation-id: bac90052-9453-4aaa-620e-08deb7057aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021|22082099003|6133799003;
x-microsoft-antispam-message-info: 9EJZ4j+SnyWuL0Rz3Wu7ceFmdPZ+r/vrltPo2MauPNrfnvDmhib9C/eJwqwb0Wx6LiN/gQMrR62W6GWlrLOBvkNuqNPORkNF1vqttu9wCuWIhapOf8mZ5rR/judG2yqW1vCQkTFUWU7ymQXa4xtJK1L0wo7ETZUS02BkrrC/abfTHGd2nVfm4ub150QUfEm9dkiPJOkW1CRYgdSj2pQqDARJ7vrMnDlAgsC6cjDAKhfVacI932bPBzDtXYE3KOOyg08XMy07aGRXbSADgoGMIlwUEVhjn6PuTIkmXyflxFui6Isfg5l8bhuD4dztybXSNxYkAUuv+ppLhbt6jGS6+HVh+S6xI0vvuCnTJqWc4N8NspVXgG0Io2dbLGdFGgL2L9RtdK6QhuXdIgUjdW/5GcswtLqtpnTcV/6+VviLtz3ao7qbcBzIzNgmQGHMt04CvXsE5ephh9ieUAYfXD7FMHBKemmkOOGKFuTRVAa2Dt0RCJaFnjGb6BWUoJpARBfCUWGvJircBMNLmfK8fdGDAlme+ghhh1YgAMtlbc3tAcWUL0BcytSAQRgMsszoiLGg4d9Yd1ZKYZq0uSIen2mWDuuxQlvjW+5XloySsngpwY06LwrfX9d1xd8F9567IISPg1MhFW4nwpgSKgbmoU72aB6rLAbi8G7Vnxu2DsjA7a2T5FItDZVxYy2MqNxSGQxgDt+zsdz7PO3dyfn94BlMyF7z1a7tA2A4mCJVgj88iGnuuhhzU9OsoASWxTr8mJoU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gkp2SUc5EBbDeWtgZHFchqRJQ+uf6tYgTSqb+pTA8os/TPBDY5UJ9JO3aL?=
 =?iso-8859-1?Q?9X7hdP2GaJmmeg+ROYvJJWVpC9a1H9F44f023bTrQGVA6fUHoeduVPXd93?=
 =?iso-8859-1?Q?DKTvzks4n0t8EqnCIV3GpPJjCuJQKTObYjsFbopGLURxSp7vKTceQhtcPW?=
 =?iso-8859-1?Q?v5iw1cv2tjNSkb/kPpp+dpSkYN1gV/dSBtQL75zzeUAb6P+AizarHn3nfO?=
 =?iso-8859-1?Q?T43Ne9TXVDTuGm/++qYBEwQ5aqcqqgzeym5dtDd4FOOgZxgD2HyXporgEn?=
 =?iso-8859-1?Q?IEKqvumNRDSud9R7UdCJ2IswhAJen0yLm9J4yNp4Wct6E92l4XVu1ZqD9W?=
 =?iso-8859-1?Q?xnY2ItoH5y7PqJvRqGLyXVF585qCK8bMI2pb2rF9bRxPIFO5LptrO3nEwN?=
 =?iso-8859-1?Q?c7sXpjEUeD2lr3T03d560DHbwgcw6paOsgwk1xA9lc1LoqOr8JVeockdTP?=
 =?iso-8859-1?Q?7pc/uFoaaADVg9F7yhXd2iEb+3FF10qrjDjLsh1RfVKqVAlQHpgLTdrml4?=
 =?iso-8859-1?Q?+PwfSy6KS2wFcoK46jWv0EfUV5njZ3aF10eRla+mMAhaQAQOEuN7S6IKPt?=
 =?iso-8859-1?Q?uxroM04yoIKFxEtPtrw8Diri5ZN2FZDHOVFErGnOhOgOl20ghPuO88FIm0?=
 =?iso-8859-1?Q?7l1pgZUfrL4nhWS2aENSuhDcKEl1vd0E99bTJzF8pDJZZtFyg6DyAmvRZR?=
 =?iso-8859-1?Q?G1GXz9TrgIDJgiypUBcN7X0PPLhwfj+1P9gBQkvlw/yuZKW/7bEbpQaVhq?=
 =?iso-8859-1?Q?hTrBPC2AJrup2mUl52FLBsC5PMZztw8gwtvwHrSoGUz3L3XrwNgP3fbk4E?=
 =?iso-8859-1?Q?wgXTXlW4q11EC0EhqdvWCSp55DcBsUnJKOoOZIr5+Asu6abQDe1kPHYbnZ?=
 =?iso-8859-1?Q?d7mBSPrIoTGbelWf7/JHIromZ1C5fp8RpW0gVVS67Xztw9d6BjPpegIvgR?=
 =?iso-8859-1?Q?+e7b1O9h8t/Ilu01hDX5/WMb6cMneWM8nu14Knnw8OygnXzHGos8YuOIx8?=
 =?iso-8859-1?Q?SMgBrtsq4FZ+9oy9Ae1iaQcPoxl/bkXcZW+JLPwBHuih0O77CTqsWQkDZq?=
 =?iso-8859-1?Q?F9MU8HxM8yqKs3QbeT/jSQRS9hG9jjLlUYBLCuh5PqJrzWZriqRr2LNwZK?=
 =?iso-8859-1?Q?cKPIypJW+t4qlHBc/9N28/6if2BTcixGC7glNoQOR9G1zL3TR9re8JET9n?=
 =?iso-8859-1?Q?FIsqPC0FVaspXhfExSzGVU9Bg7xYu36lAJEmqiOTqKk7d8ApxZSzl2/nnx?=
 =?iso-8859-1?Q?dfoElq59fUxWC60lzWy8Z1I+JF170NH80TZzLXVXUPIyeXTmVrIOInJHGt?=
 =?iso-8859-1?Q?ZngUCXkNMugCnja9hCDPbb5fpsHw3dg0ppQMkfSsQ7Y1KAHJqKkMUiJFkv?=
 =?iso-8859-1?Q?reccckvBWVACnK4JCoHlxiwNP7sOTlYeBFsQDcIZ0Z8/cT59HLHYF0L2Zg?=
 =?iso-8859-1?Q?trrMH1NAgcmyyO39W0nLxhbW72wr0An+jYqncbFTeowhNdHCixZ98MFiQC?=
 =?iso-8859-1?Q?G9XX+T445opG2c+CH/ErdDcYr0PpZSoFeEwBmg0V987OYGWikDCwxgqJv0?=
 =?iso-8859-1?Q?79eGBLSYy1QzC+GeuBOFnNISyVrzGlieg3+/eIJ+EAuRVXqSDepYdl0fDr?=
 =?iso-8859-1?Q?SxgCAoq8+mnU92yovH5WPAE9xnEJUJTPxeU94qQkug7jkmD+WUUqQReHrA?=
 =?iso-8859-1?Q?ABBsjrb8Yenc0OOKGHasvIbC9di+Rpj82Ty5tauJbk2bUwMFh1UgVT1iuP?=
 =?iso-8859-1?Q?aLZMDWwAsuZaBeICol3NHY110i/Gqcy/NBqbguHedeOBr5UEpT53aQj33Y?=
 =?iso-8859-1?Q?9CRb/O3g6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TRn7T0eansTsjWRk0k6vFiVncWFENkfzbsT+SINgMkodvw07ood+3buvXL0yMzrt7aCGkDsSDs5whqzWM4w0gHRg5kD8FN+LA1KvalWtXKFUbKFwBSNofX9tIoG6lyx1WqqQIWdKIMltGsdOV88R3yslXsqYtXtfL3K12nB+/QCUkETEIM6AtNHm+7ytIbO8lUAgNjmqunYwhHxue5mzCT+WCzYHInZMD1lbbF1g91YCY5v8NV0R13XpQjw8jV6HQ3dF5Gw8820NMf5EIsQNkpjL+9KCFTv4o2gae+VcEwSBLH+zsUePVzCbgqksBCqlnFcDa9YFpolcBEgSoPHwNg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac90052-9453-4aaa-620e-08deb7057aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:52:09.3270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrm5KIQMNRWQ8b+WDCV9Xw+pwywsH+0tlZ6TnfTRzTRC2ZeAXgORfyixc9uFazOFXcz6e4q6l/NATIewibCjL5YIVAVVxSJZcv7zErPGsMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044
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

AST1040 is the next-generation device following AST1030 and is=0A=
primarily designed as a bridge/BIC controller platform. Introduce=0A=
a dedicated AST1040 EVB machine implementation for firmware=0A=
development and validation.=0A=
=0A=
Although the existing ast10x0 EVB machine code already provides=0A=
a reusable minibmc initialization flow, AST1040 requires=0A=
different platform settings, including:=0A=
=0A=
  - Different SYSCLK frequency=0A=
  - Different internal flash size=0A=
=0A=
To avoid overloading the existing AST1030-specific helper,=0A=
introduce a separate aspeed_bic_machine_init() implementation in=0A=
a dedicated source file.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040_evb.c | 72 +++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/meson.build          |  3 +-=0A=
 2 files changed, 74 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040_evb.c=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c=0A=
new file mode 100644=0A=
index 0000000000..5851cf6967=0A=
--- /dev/null=0A=
+++ b/hw/arm/aspeed_ast1040_evb.c=0A=
@@ -0,0 +1,72 @@=0A=
+/*=0A=
+ * ASPEED AST1040 EVB=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "hw/arm/boot.h"=0A=
+#include "hw/arm/machines-qom.h"=0A=
+#include "hw/arm/aspeed.h"=0A=
+#include "hw/arm/aspeed_soc.h"=0A=
+#include "hw/core/qdev-clock.h"=0A=
+#include "system/system.h"=0A=
+=0A=
+#define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)=0A=
+/* Main SYSCLK frequency in Hz (400MHz) */=0A=
+#define SYSCLK_FRQ 400000000ULL=0A=
+=0A=
+static void aspeed_bic_machine_init(MachineState *machine)=0A=
+{=0A=
+    AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(machine);=0A=
+    Clock *sysclk;=0A=
+=0A=
+    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");=0A=
+    clock_set_hz(sysclk, SYSCLK_FRQ);=0A=
+=0A=
+    bmc->soc =3D ASPEED_SOC(object_new(amc->soc_name));=0A=
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));=
=0A=
+    object_unref(OBJECT(bmc->soc));=0A=
+    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);=0A=
+=0A=
+    object_property_set_link(OBJECT(bmc->soc), "memory",=0A=
+                             OBJECT(get_system_memory()), &error_abort);=
=0A=
+    aspeed_connect_serial_hds_to_uarts(bmc);=0A=
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);=0A=
+=0A=
+    armv7m_load_kernel(ARM_CPU(first_cpu),=0A=
+                       machine->kernel_filename,=0A=
+                       0,=0A=
+                       AST1040_INTERNAL_FLASH_SIZE);=0A=
+}=0A=
+=0A=
+static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,=0A=
+                                                          const void *data=
)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->desc =3D "Aspeed AST1040 BIC EVB (Cortex-M4F)";=0A=
+    amc->soc_name  =3D "ast1040-a0";=0A=
+    amc->hw_strap1 =3D 0;=0A=
+    amc->hw_strap2 =3D 0;=0A=
+    mc->init       =3D aspeed_bic_machine_init;=0A=
+    amc->macs_mask =3D 0;=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_ast1040_evb_types[] =3D {=0A=
+    {=0A=
+        .name           =3D MACHINE_TYPE_NAME("ast1040-evb"),=0A=
+        .parent         =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init     =3D aspeed_machine_ast1040_evb_class_init,=0A=
+        .interfaces     =3D arm_machine_interfaces,=0A=
+    }=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_ast1040_evb_types)=0A=
diff --git a/hw/arm/meson.build b/hw/arm/meson.build=0A=
index fa3a848492..9b75cc7fb1 100644=0A=
--- a/hw/arm/meson.build=0A=
+++ b/hw/arm/meson.build=0A=
@@ -63,7 +63,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_ast2600_rainier.c',=0A=
   'aspeed_ast10x0.c',=0A=
   'aspeed_ast10x0_evb.c',=0A=
-  'aspeed_ast1040.c'))=0A=
+  'aspeed_ast1040.c',=0A=
+  'aspeed_ast1040_evb.c'))=0A=
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: =
files(=0A=
   'aspeed_ast1700.c',=0A=
   'aspeed_ast27x0.c',=0A=
-- =0A=
2.43.0=0A=

