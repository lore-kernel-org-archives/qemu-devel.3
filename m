Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0006CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxHE-0003RC-DH; Thu, 21 May 2026 02:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGi-0003HO-Ss; Thu, 21 May 2026 02:52:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGg-00083B-P9; Thu, 21 May 2026 02:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNu85ffMdgy91ESU4GxIb77M3mieeIQgaZfpV7r0W//URAt2F6DACQseUXIpoWeM18RUyfXhUEY6CHQva84VgiBRg98We82Ev3Sn3Dpn/XabI1OXc7OXO1h8LJCoFUyLw5gAAdrj9lBayIOGWrOY0TjgVfMP7cOWOkSe9jbtDpl/XAYHrWllXn1ze0vKzdsMcv9KZy/997CshAypjWHvcyiTIenK+J+QLOiqNyFEgCkO2m3H/IkroAgIG7eJGvzRUPeVPWnEBQXa8a/a+YUbhAOFRB/LeJteP0HE4Wso7zYi37uTmyTOkp+0HdbwLmOtPdCFh6wv8rdLDniO9Z47uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbX5OqKV0dVPGrmzjpa0DD1S7iQGQZhQHsQoJ5Wa8wY=;
 b=sPK/7BHCmPbnexb1pQFor+eHXfC58w5a+7RR5npMX5katcuSmwKJvUcqgrOwlQm8K0BZ4YFbjPUDFxDyiqCmUOQC+mZXnfJdX+0E0XgcobUmBKMMvZn7bI/ZQAxxbHVIxyHLL9tPev7Mh7TAOuPit/i6nhheqWqbBcV6H7imaYBokmM5dvS3HEw3YtMue+F10h0Y+sDe9GjErHVbz1fuwG13gIm8XVXsHz6yWK1fcSVCgqrssS+Z0upSZ4IUj6erMhgAGJkzCjLkyv2Smr9I0/yIXr0Uv7OSpCzbXsnfxI8kawjqGkORnDXa7c/TyG1/gM0e+JvJjKxfuaAgkoddsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbX5OqKV0dVPGrmzjpa0DD1S7iQGQZhQHsQoJ5Wa8wY=;
 b=ZVX3ELWXz49yG+J/NWPPGg2XIYQD6wO/RdYD1HjIp6RC1qu55e3eb7BsYGqkhpPQyZd6x6Dmeu1d2iuZ4cDgh6kf48v+R/eHyvWLjcco3OPJH0tfemd7EeeBI8afEd49WPMpwHD/fRusndM0XJMW4vUOTXpOk8mpxLY6taAOSqK2tx+62QqeDtBE8bL2stBvKwAm9Bc1lOKI6zWmxek7gNNA61eyzYuK6B3tQjVHAwfbvBZstgp5qbLoevEXX/9U7l3xJKAbTOUHCi4DpsvPUrDHgngYAWNmIk/NZ2axECBMY5XpMPfJQaGAfPRWIE/dpr38RReXyvkVbE8wfHTbHQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:52:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:52:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/4] hw/arm/aspeed: Introduce AST1040 A0 SoC model
Thread-Topic: [PATCH v1 3/4] hw/arm/aspeed: Introduce AST1040 A0 SoC model
Thread-Index: AQHc6O5XFjwe/7SkkU6GD4dyjSgfEg==
Date: Thu, 21 May 2026 06:52:08 +0000
Message-ID: <20260521065203.3713466-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6028b8f3-3d2c-423f-20f8-08deb70579eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021|22082099003;
x-microsoft-antispam-message-info: xriSvBk6Sf7IkDyduDqi6k9wfOAFlh274knQz3xz7Y6ZITxCJ2u3OHVoFtyLDQ0oxgJAEP/M77h5wOVS3SNLHXQIts1Sg0b3enIStVXUtGx25PM+y95cxH47cwxWzukhBx6cJ4+J9nQ+dA7K12yI1yJBZErsMZfUwpE/wXovlDwj6kgt6eYfIYLycZb2LwGMsJHh9VmaBlcN7uN3r6Jgrp/ofYdAU/L2onptSL/198P76V2FxZUb/R747wSubo+cRWtJPNwcNmK9yUQA5mBcvAftgoaNQwEPSd2u1eOAbJer5YwtisaDEmEjXHdf/eiM7Q8DH9QuAx2Ttw3Rn3RPv861+XLWkMvtwKI4AFKVBzeu/nfA4MgxoRwjrAFzL5wvWjY/0dQGLuRpRPW5CvGVUOP9g+kdCdKYAL1q91G3+rEBv4x5pVF045tjEFLIa+UqTPSXRpyoS5U0j4t9A8VJytJ9A7fg8Y0V12WIwCrR3b75cjp++tCgVMXmjwVvJ+IH6XxI1c2PwZIBDg8Ncmv0VNwy1n13bjqJJGBoKeg6f0ARpLFgwjbmQhRIc8BbqwsKD6+7xgU8Asj8WAoaIoFrfUFKEi4ZwJK5cIbTfP6i0n2kboBwOeE0NJZ81YK5PcMizFdT2uoyDB4Wvk7e2kVWaqS+4/c3QaGBQpGh/rc1BgpvOHNAQD1YflOB0tBFVhPjeBKeSMhLPuOd8GAH5NJ2DXFKTB/FHWQr38gksJWhNICWjMMpyJ6GMurDA6RlqtDL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+YF8B4vqXoyHazeWz+WwDDy429ZfkQLAGQoa+Rumxuy0Ld91Nlm0BTJpYD?=
 =?iso-8859-1?Q?S+tfJjBMc3EGKEumGk/UUqRq4jIsT8wPmGZx4qLcJhrmAdzS6VSOqXIc6l?=
 =?iso-8859-1?Q?ZM3zPMEc8VR0sfFTS5kvnOsmzfXegIihKVcYu1V4OEvBsfvZZXcDYyAB4d?=
 =?iso-8859-1?Q?3r87woELWGaBZfiAY3exi9SJzmwxIh5TTAAkOWFX3Qec/aDl20CMoqr6qF?=
 =?iso-8859-1?Q?jssTvuxRgJUf6L85tGF1nMp0hrTXfhuZNdoaIdhd0M67b6MYBzVVF6w6rc?=
 =?iso-8859-1?Q?YCWaa74JPjq4sU1oFpFrz/C1cN39nLxj5eubWyk+w4tx5dA5P15k5GNqRx?=
 =?iso-8859-1?Q?3kQPcO2A1CLU4WmhhJr+tCHYWRaE5561eY1WkFy5Bfx0z97CpYHEuYHNCD?=
 =?iso-8859-1?Q?+fw9whqpc1KhpoESTKtaNqCG0DWTm/pxFpNY3yqITqsPUvx5gXwasdSjoq?=
 =?iso-8859-1?Q?KSwPIyGS8jWc/YJkzgiBagS0IHK+riPNNFTMuTvQgClRlqmm5wnyHMPafU?=
 =?iso-8859-1?Q?f6fuJ8YNyKuq0y8VjqMi5TEyX54fzXYYL0A+swUP/tmoWiyxA8GLQzzVJP?=
 =?iso-8859-1?Q?+lbQVTkunwoKAPMTqEvMZABOy457Qib/EUdob5eEIEA3dPGGYX6RdbW6lu?=
 =?iso-8859-1?Q?mpWasldlJ3zH3p1Krz0w/yPvz0c4vYv6/m4ECJbkzc0uoh1F5WmEJaBLqv?=
 =?iso-8859-1?Q?dcrpaJFkFd5wgBlapG+QbMHtM48uV/GDP7ExjZ70FpK9F7rihJo3TIFbGn?=
 =?iso-8859-1?Q?E3/OEdVLAmb4UzFWcrDUSKwSbNCbkF2I7MuarBA1PUyez+8I1ZwlQvLC8j?=
 =?iso-8859-1?Q?tEflkQXTUOfiwQka54/z63peKJTpd743ZB12zEjMIuXNqZBe6i8K0oKS8m?=
 =?iso-8859-1?Q?Ll7O8jL/k9+BUOsRw7h9W+X/UoDPJNDVzBch5WFuR9rSm2t6/W3akF/CZA?=
 =?iso-8859-1?Q?99qowI6yNzaMkLxEvJN3O/4jTsKZBeJqsLpU8jWtiJv5Hrpf74DGxW8TJn?=
 =?iso-8859-1?Q?IT9vLoBud5rTIDNB02gqXhVZg8kWyDb3zEZ2zeYwC/9D53wg6vzd/poVWI?=
 =?iso-8859-1?Q?Vy8Llgj7VkukIPz6ylxOp0ofuJ3dCDyacM6mcWMUKBNAwrEYlwWjEXoztz?=
 =?iso-8859-1?Q?KiUEjyM/L6eRGjSlyEfaSZjco5LYuAArDB/3p52vFtwWM21ogZb81a65C3?=
 =?iso-8859-1?Q?HbuOM4Ty3lo3MSUqTfNN9qJIxU0GC+9MM1Rw6H2df0oFWVfUOzaDKNcA1l?=
 =?iso-8859-1?Q?LG7C1jxnRp+qsiMZZiuux0zHAX2PCJI48RdweKuvqksmUoHiuRshoIiOhZ?=
 =?iso-8859-1?Q?n99qAhjcECuYIo6/P3KfhdFSMHwVl62XhSjSWBX9I5mWP5qAWCFF4F/Rqe?=
 =?iso-8859-1?Q?ICTPr966fN9vz0NOqV9KmFfdzrw0IEgqyUWW7RUB5MhiX3xvFJdLyq4iG+?=
 =?iso-8859-1?Q?EiUMENC3vFH9sKLW6+mrKfCBXvpWGG8u671V/8wLj7/OqFu8yS7tM4V2GE?=
 =?iso-8859-1?Q?GBBLZKlj7HFF11YI2kfqTWcSISoJsNdkeJCLOcWzrZ2QXAw0AgUYihUAfi?=
 =?iso-8859-1?Q?u+d45UUF+wKGtK2bysAuB91agwRQ/AjgZlkRjLgoI6s8mC+vyp5o60+40K?=
 =?iso-8859-1?Q?7KJVvVChNeHLKVZou0AsQV/bdBBxZxB9T1rqOEtFun5GdYxkXYStwLfP9+?=
 =?iso-8859-1?Q?AvRVio+z0RABH9+Abv/OpPJ5cN8Zd4hqBwHf4WA9lwx/umCG6Nw48IaaWi?=
 =?iso-8859-1?Q?pUXSILYVMAQ8vOoLWjJOV5ImT0xR1falzearSHzUGzfxoI5E2Zopjrk2kn?=
 =?iso-8859-1?Q?r9lJL7zHdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: exgUeJQkv44qKHWCh3KhwjxGWxABEHCwJiFtUi3jNOXp/6lzvu+Zw5V4mgTdWPZkMANS0T6FefFe7UjwjkP4NQuQQlj75MEBbR+7gLsLWCzLsA6uCY8em/KoI7Me2ueEnWtfk3hXPpQOsayk8YET3yL3mS8NdDgkaUaPA0GOwaRWPNKmTvouEdgUSdQe7zyjOqN/Ij2MjmKwUW+UzsRjkL9eGOeP7N98VF65v47ZrkIzlNwdUDM7WVwRJhDuniEbl/2qM8BDrkCjiZ+6cPoOXd18AIJn2ioDQar3fkKrgtl54XiyQMSMn9WvoYbTy/Z+0aeF0AvQ6XT7GDPF6/4GAg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6028b8f3-3d2c-423f-20f8-08deb70579eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:52:08.0904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IPpn967cbSAbnz6XtapVbRXokZOudPJ1C+95xa1FaXR7IqM1Z80X6yPIy8vp3QxH0IiinOFliuwFFE4fee7vsOFeIqFy3ZM8Nc/OoywH2o=
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

The AST1040 is based on an ARM Cortex-M4F CPU core. Since QEMU=0A=
currently does not provide Cortex-M4F support, use the existing=0A=
Cortex-M4 CPU model as a temporary replacement.=0A=
=0A=
This initial implementation provides the basic infrastructure=0A=
required to boot firmware and run a minimal firmware shell,=0A=
including:=0A=
=0A=
- ARM Cortex-M4 CPU integration=0A=
- NVIC interrupt controller support=0A=
- Internal SDRAM and SRAM memory regions=0A=
- SCU integration=0A=
- UART devices and interrupt wiring=0A=
=0A=
AST1040 SCU behavior is compatible with the AST2700 SCUIO model,=0A=
so reuse the existing AST2700 SCUIO implementation directly=0A=
instead of introducing another identical SCU model. This reduces=0A=
duplicate code and helps minimize long-term codebase maintenance.=0A=
=0A=
Several peripherals are currently modeled as unimplemented=0A=
devices and can be added incrementally in future updates.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 246 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/meson.build      |   3 +-=0A=
 2 files changed, 248 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040.c=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
new file mode 100644=0A=
index 0000000000..615f9c4e15=0A=
--- /dev/null=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -0,0 +1,246 @@=0A=
+/*=0A=
+ * ASPEED AST1040 SoC=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "system/address-spaces.h"=0A=
+#include "system/system.h"=0A=
+#include "hw/core/qdev-clock.h"=0A=
+#include "hw/misc/unimp.h"=0A=
+#include "hw/arm/aspeed_soc.h"=0A=
+=0A=
+static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
+    [ASPEED_DEV_SDRAM]     =3D 0x00000000,=0A=
+    [ASPEED_DEV_FMC]       =3D 0x74000000,=0A=
+    [ASPEED_DEV_SPI0]      =3D 0x74010000,=0A=
+    [ASPEED_DEV_SPI1]      =3D 0x74020000,=0A=
+    [ASPEED_DEV_PWM]       =3D 0x740C0000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x74120000,=0A=
+    [ASPEED_DEV_SRAM]      =3D 0x74B80000,=0A=
+    [ASPEED_DEV_ADC]       =3D 0x74C00000,=0A=
+    [ASPEED_DEV_JTAG0]     =3D 0x74C01000,=0A=
+    [ASPEED_DEV_SCU]       =3D 0x74C02000,=0A=
+    [ASPEED_DEV_ESPI]      =3D 0x74C05000,=0A=
+    [ASPEED_DEV_JTAG1]     =3D 0x74C09000,=0A=
+    [ASPEED_DEV_GPIO]      =3D 0x74C0B000,=0A=
+    [ASPEED_DEV_SGPIOM0]   =3D 0x74C0C000,=0A=
+    [ASPEED_DEV_SGPIOM1]   =3D 0x74C0D000,=0A=
+    [ASPEED_DEV_I2C]       =3D 0x74C0F000,=0A=
+    [ASPEED_DEV_I3C]       =3D 0x74C20000,=0A=
+    [ASPEED_DEV_UART0]     =3D 0x74C33000,=0A=
+    [ASPEED_DEV_UART1]     =3D 0x74C33100,=0A=
+    [ASPEED_DEV_UART2]     =3D 0x74C33200,=0A=
+    [ASPEED_DEV_UART3]     =3D 0x74C33300,=0A=
+    [ASPEED_DEV_UART4]     =3D 0x74C33400,=0A=
+    [ASPEED_DEV_UART5]     =3D 0x74C33500,=0A=
+    [ASPEED_DEV_UART6]     =3D 0x74C33600,=0A=
+    [ASPEED_DEV_UART7]     =3D 0x74C33700,=0A=
+    [ASPEED_DEV_UART8]     =3D 0x74C33800,=0A=
+    [ASPEED_DEV_UART9]     =3D 0x74C33900,=0A=
+    [ASPEED_DEV_UART10]    =3D 0x74C33A00,=0A=
+    [ASPEED_DEV_UART11]    =3D 0x74C33B00,=0A=
+    [ASPEED_DEV_UART12]    =3D 0x74C33C00,=0A=
+    [ASPEED_DEV_WDT]       =3D 0x74C37000,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 0x74C3A000,=0A=
+};=0A=
+=0A=
+static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
+    [ASPEED_DEV_ESPI]      =3D 10,=0A=
+    [ASPEED_DEV_I2C]       =3D 64, /* 64 ~ 77 */=0A=
+    [ASPEED_DEV_ADC]       =3D 80,=0A=
+    [ASPEED_DEV_GPIO]      =3D 82,=0A=
+    [ASPEED_DEV_SGPIOM0]   =3D 85,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 92,=0A=
+    [ASPEED_DEV_I3C]       =3D 96, /* 96 ~ 103 */=0A=
+    [ASPEED_DEV_WDT]       =3D 112,=0A=
+    [ASPEED_DEV_FMC]       =3D 121,=0A=
+    [ASPEED_DEV_SPI0]      =3D 122,=0A=
+    [ASPEED_DEV_SPI1]      =3D 123,=0A=
+    [ASPEED_DEV_PWM]       =3D 125,=0A=
+    [ASPEED_DEV_UART0]     =3D 135,=0A=
+    [ASPEED_DEV_UART1]     =3D 136,=0A=
+    [ASPEED_DEV_UART2]     =3D 137,=0A=
+    [ASPEED_DEV_UART3]     =3D 138,=0A=
+    [ASPEED_DEV_UART4]     =3D 139,=0A=
+    [ASPEED_DEV_UART5]     =3D 140,=0A=
+    [ASPEED_DEV_UART6]     =3D 141,=0A=
+    [ASPEED_DEV_UART7]     =3D 142,=0A=
+    [ASPEED_DEV_UART8]     =3D 143,=0A=
+    [ASPEED_DEV_UART9]     =3D 144,=0A=
+    [ASPEED_DEV_UART10]    =3D 145,=0A=
+    [ASPEED_DEV_UART11]    =3D 146,=0A=
+    [ASPEED_DEV_UART12]    =3D 147,=0A=
+    [ASPEED_DEV_JTAG0]     =3D 162,=0A=
+};=0A=
+=0A=
+static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+=0A=
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_init(Object *obj)=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    int i;=0A=
+    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
+=0A=
+    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
+=0A=
+    /* AST1040 uses the AST2700 IO SCU model */=0A=
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);=
=0A=
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);=
=0A=
+=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap=
1");=0A=
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap=
2");=0A=
+=0A=
+    for (i =3D 0; i < sc->uarts_num; i++) {=0A=
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
+    }=0A=
+=0A=
+    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
+    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
+    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
+    object_initialize_child(obj, "sgpiom", &s->sgpiom[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(dev_soc);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    DeviceState *armv7m;=0A=
+    Error *err =3D NULL;=0A=
+    char name[64];=0A=
+    int uart;=0A=
+    int i;=0A=
+=0A=
+    if (!clock_has_source(s->sysclk)) {=0A=
+        error_setg(errp, "sysclk clock must be wired up by the board code"=
);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* AST1040 CPU Core */=0A=
+    armv7m =3D DEVICE(&a->armv7m);=0A=
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
+    qdev_prop_set_string(armv7m, "cpu-type",=0A=
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));=0A=
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
+    object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
+                             OBJECT(s->memory), &error_abort);=0A=
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
+=0A=
+    /* Internal SDRAM */=0A=
+    snprintf(name, sizeof(name), "aspeed.sdram.%d",=0A=
+             CPU(a->armv7m.cpu)->cpu_index);=0A=
+    memory_region_init_ram(&s->sdram, OBJECT(s), name, sc->sdram_size, &er=
r);=0A=
+    if (err) {=0A=
+        error_propagate(errp, err);=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SDRAM],=
=0A=
+                                &s->sdram);=0A=
+=0A=
+    /* Internal SRAM */=0A=
+    snprintf(name, sizeof(name), "aspeed.sram.%d",=0A=
+             CPU(a->armv7m.cpu)->cpu_index);=0A=
+    memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size, &err)=
;=0A=
+    if (err) {=0A=
+        error_propagate(errp, err);=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],=0A=
+                                &s->sram);=0A=
+=0A=
+    /* SCU */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+                    sc->memmap[ASPEED_DEV_SCU]);=0A=
+=0A=
+    /* UART */=0A=
+    for (i =3D 0, uart =3D sc->uarts_base; i < sc->uarts_num; i++, uart++)=
 {=0A=
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],=0A=
+                                     sc->memmap[uart], errp)) {=0A=
+            return;=0A=
+        }=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,=0A=
+                           aspeed_soc_ast1040_get_irq(s, uart));=0A=
+    }=0A=
+=0A=
+    /* Unimplemented peripherals */=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
+                                  "aspeed.pwm",=0A=
+                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
+                                  "aspeed.espi",=0A=
+                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
+                                  "aspeed.udc",=0A=
+                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0])=
,=0A=
+                                  "aspeed.sgpiom",=0A=
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);=
=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
+                                  "aspeed.jtag0",=0A=
+                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
+                                  "aspeed.jtag1",=0A=
+                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(dc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize =3D aspeed_soc_ast1040_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev     =3D AST1040_A0_SILICON_REV;=0A=
+    sc->sdram_size      =3D 16 * MiB;=0A=
+    sc->sram_size       =3D 512 * KiB;=0A=
+    sc->uarts_num       =3D 13;=0A=
+    sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
+    sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
+    sc->num_cpus        =3D 1;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_soc_ast1040_types[] =3D {=0A=
+    {=0A=
+        .name           =3D "ast1040-a0",=0A=
+        .parent         =3D TYPE_ASPEED10X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast1040_init,=0A=
+        .class_init     =3D aspeed_soc_ast1040_class_init,=0A=
+    }=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_soc_ast1040_types)=0A=
diff --git a/hw/arm/meson.build b/hw/arm/meson.build=0A=
index 80068f70bb..fa3a848492 100644=0A=
--- a/hw/arm/meson.build=0A=
+++ b/hw/arm/meson.build=0A=
@@ -62,7 +62,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_ast2600_gb200nvl.c',=0A=
   'aspeed_ast2600_rainier.c',=0A=
   'aspeed_ast10x0.c',=0A=
-  'aspeed_ast10x0_evb.c'))=0A=
+  'aspeed_ast10x0_evb.c',=0A=
+  'aspeed_ast1040.c'))=0A=
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: =
files(=0A=
   'aspeed_ast1700.c',=0A=
   'aspeed_ast27x0.c',=0A=
-- =0A=
2.43.0=0A=

