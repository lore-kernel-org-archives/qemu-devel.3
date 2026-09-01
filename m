Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7044EC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jev-0008Da-9b; Tue, 01 Sep 2026 04:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jeq-0008CS-Ek; Tue, 01 Sep 2026 04:15:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jem-0001wa-Sn; Tue, 01 Sep 2026 04:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDv+PQdrx1J9T2rm+YopdH+ZUhvI/pdMhCDZaVryPIZjotu8mDZqNGe4EERAQff9ynxTYf70bV6AYYvAd4ysND7ykqsU0EQUnLatSqXOLatRtTJ4b5wtKS/WbVgr+IjekVSOaYF8pOsKxkkFna+KwQQne5ekHSlweTvBZ2yk+DdrQna48wR1+hxN6v+5hT2J0mf2xRIlzj/b9AJoC9OS//Hl4jJBeLVsl2FqCNcSshpq3vHkFhmsa8O+Gug356SjWf8nHTg67tyhVMvsBBkDRJHAZT8dkoVTtwfF5LtoAheWUPjdKAbeTNKzvqsf5xM3ysJiUkLerOOek96ETnudsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxInRsbdRo1LuZlV22DyIbk1DRJuvScMstZP/+9O02I=;
 b=CD+ICgSHpmzeEIElips3u8xXwhj4McqnP7r1zCWJVqqUD5jsbehUW6nAz0yFD9lBls/Hw/+hE93eNNmGMSM1jkg7rJfp6zVK+9w+gx0+F2ggU4Ldiid1VZexZtKLwl8qb+yliRqb3t2uA1afLplEMVyHAR3BACbfurQv7bbebuynFxqE77PqwG24HkhjxAM18Dnb7+0FeuAAmdP2x5zaPMIj/ufF3rkuekikd8mOL6eKg3BXxwzgaYdqosyByISL5MCVs2hl8J87K+Mjki3vbKJLaE7aSJHfyCc9WLlDwh9I7OBjt/e9R7bDWltXNwNtFZ/NKSSOq9/67muQVyKuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxInRsbdRo1LuZlV22DyIbk1DRJuvScMstZP/+9O02I=;
 b=grTPyaQTBNO1MquIYa+vz6Q1kx9QFdppOOyiDxD/1oRpwJ2vjj/zOvXXc+/shVYkGfBApyFRL0IaXzRbHSPiFqIWPBfOq9G6wT5XcXI7aaqCpVgRA34suTDpSNblLXCjpHvmKLj8wq0PIyEGvnqcmwfkg91hEKFDsqsyGxTjXuD+s/uL7fDMPJFjZ/27lOPY0ikldzZ2g0CS9dvmsh14flmWTYuVcz70EcUCdpYJtj8oQ7FPfIoDGfpcr2zSFYn1UboQfIpEBPnmvHCJgE/4ZSzzoqHjYc/gUmLeZt+R+tWMJoofNnc3xcXF4rAZGUubYxv6y3l82aoM1Yc+X8yqiw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:15:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:15:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 1/4] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Topic: [PATCH v4 1/4] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Index: AQHdOeoPUevW+H16zU2hl2eddEkrTQ==
Date: Tue, 1 Sep 2026 08:15:33 +0000
Message-ID: <20260901081531.898176-2-jamin_lin@aspeedtech.com>
References: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYUPR06MB6151:EE_
x-ms-office365-filtering-correlation-id: 3e8c3912-ce9c-4637-63a9-08df08013325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|3023799007|10067099003|56012099006|921020|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Hqg+++1bMIf5QyE65bzWIQCuC/8e/A6ZMZjxBTTNooD2+qrXRfveBNClNmSmjwsKAlnrIOoqJSEN4p66bsrW8uQhnxhgIPJTozeolyM45Fistno+JimqWbxYHSdlckh3vvzdR6uDvDDtGBmzwHn/BrFCiLftmvkGpgcWTTNzyuxT51d5eeEG3zLXa/BmMa18L0/wyfrllBBTK7oQn7QzCMK+yj4yXqS6NyOtGfohil6h6x1Liw8hfha3HT8X7p2BkG5yhibSniVx1N+H4fEAP4Ryz0Rtdmp44lCXn/jTfZN7RwBHUsXN/dk1IjsKG/FmuYG9ckiyEKgyOl2JMrrAV7m7U3S+1g2QF94YRjQsBSgTvplk//aRT99xvCKIP/gU9zDfL2qJ6sudih5Vo9f52syKEEb4gplbtRNZLaQg6tJL/b115sP1SVWb/ROTde9AWkTL5Qi4W9g2sOdOryE1NFF1yRkUxv7iVwnmopm6ooxShz85R9OngkZNBK8W4qIvy8uco/koqDnNTCMLRGcgUE9NRgCsECZR5f+3DDNNs+GJqtylCQCpVS7+SJ/Rf63J27Ca4VWsab8zMuqR4ozUk1Hd8ZZ0rorY2IuGlx+O2HW4jPztgxCTDKgTzp8vWR9W8PbAhoH8sPYGM6IXK9iM9e4o6Sh18/vXmzFFaYKe4NDua5WbrOTzcYWSfSNiuewTAV5XX2yhn0IcmwasL77V/m9kFZrihCcQpAE4OIwHe5g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(921020)(6133799003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nmPY87t9qHTT3GaNc6B87SkOGRX+4XmZLV/m/i6YahENvQZRKr32mWFqOc?=
 =?iso-8859-1?Q?U8XGUP5kGE4ytvHliTEDrZxwSJMglaXZfyzX2t8vZVQk7149sVvyspX1OX?=
 =?iso-8859-1?Q?rXWOeX//nO44fYahn4kVpEUDGoNg6jm9tmF46PV9uZBUM6Z/zJc2RBbh87?=
 =?iso-8859-1?Q?4qgw2mNsCT0fADhYVyV4vbGi1I634MV7zGTaMN2iayQZIC9dlvc8Ki4ry9?=
 =?iso-8859-1?Q?DZrmyZRRy1evPokNo5F2nMblothtkqwLaJJuDDH/DYKD8fxVNRjGbM7imu?=
 =?iso-8859-1?Q?7YIrMn7Fz3uBTjNJ0FdpFTrbO8vQXRjyLdXlmaqTxKEXyHyYqeVvx+Vanc?=
 =?iso-8859-1?Q?9rAhYwBR6zjczGJ5oaUdGkDt+2yOxhews81/Q/qL4NoRLNNRcrvHrcvKPu?=
 =?iso-8859-1?Q?PXoqK6B7y+HT49TUtbWvztTS7h3vR3jfHgpE9iP6WZKBeywvbuDpuyagKv?=
 =?iso-8859-1?Q?mybhnya6W+mO29/COwZTNkRmKDBIqRd8eLR5iVbkEmwa6VZl5YCnAq8hbr?=
 =?iso-8859-1?Q?S1uhbsOiFUT9IrBHh55OPfys1s7WBek66+066KB9uca2PHTydVS5YlGLWX?=
 =?iso-8859-1?Q?naLGLJ5M+ZTjK8MNbFiPZGhK7KBTvT6dC1RUQSCZ2c3Ajnyxn66nlj5vzK?=
 =?iso-8859-1?Q?xQbQn2pHomKA5wspDuCr+0lgjeaW0H0Qvefv3QfqgoMrl200xuRD7ssOqf?=
 =?iso-8859-1?Q?FBeFxlT2GaeWum3+8fPRWIINfgi9g/bSOCaI219/oy3HeP0yFnAdSGWKuM?=
 =?iso-8859-1?Q?jJZln5AOgSd8kgACIAk43BgKtQvPz01MHf/ps3M/WfvJONC6YgHdWGUAy+?=
 =?iso-8859-1?Q?avX2ez7hVDFcKET5cTyjg+7WYf8vSYwu19Pn2o3hTnyjRMpO4VOuLPisRq?=
 =?iso-8859-1?Q?bYgs34KauQSLvWrM+Id4AoK8cG+3doAnmci+Hjd0l0q5uJM6uOMqXCotK3?=
 =?iso-8859-1?Q?CW25MYIaooGjnechNuws235WVCIqrAH+Am1NZIOCws8jFcvwur+6AHLbrO?=
 =?iso-8859-1?Q?VnF+PmOIEf6j+89b9XzvOMXyNi+JmYHXBZJBfrxK3pg8Fsz86J4wgu3A/J?=
 =?iso-8859-1?Q?R/ZtZslGtX7CiRFhY69XIsxe/fCSHE9iiOlaITvUE3QVEnTlRZQ3VooANl?=
 =?iso-8859-1?Q?lsMa+kYJOERnVg6sYvEkHpfqlnLzsmMem57wQB6SgT/67r+TwmAHGD0Xqb?=
 =?iso-8859-1?Q?dHnuR/c5EWOQLMzBT2N1gAkb34qgUzVc7DyaOy5vUHqliKth8MglFJ1kvS?=
 =?iso-8859-1?Q?jirFi2fVJXSPAhb0kJiorZYd4K4SGqPltPb7tAwe6UosbKb3wNM/HbeuZY?=
 =?iso-8859-1?Q?XtXFQ/vGFj/rR5dYjRxFEFc2KpaWC9XnSxejGG7+jZ2aUpKzMV8g1mmBj7?=
 =?iso-8859-1?Q?4T6rdv1g3Vcw5TPVlFDpJBXj6r+iipR+QQUlb98gqDi9vCIrpifYeUSTYW?=
 =?iso-8859-1?Q?cZlJRbwtNVBHMygqeQ98IBQAAYSfT4E1usGvdq5xi7ll53WIJgWphOtLL7?=
 =?iso-8859-1?Q?mwX6HyxD7Xv2LD9cHYSh+KNBrX6E5LKA5v58I2xNu2heGxBoBqrrlDWUGG?=
 =?iso-8859-1?Q?fLbeydL8rsWk9mHii0i+5jVKgpBKGF6sTSey7UXeLxxEU3pI2LtxvNWf4k?=
 =?iso-8859-1?Q?lLflTTdCIf7YoHn7iylfC/CWxCmmJobauKli+Etn9Egwnhg+gD0DWsob4n?=
 =?iso-8859-1?Q?+I+TAmPT/qKgKF8sDIgMAihD7r2bEic5PzoRdsCn26vR8DtUq0FYFpNall?=
 =?iso-8859-1?Q?X52PEbP61Qo8y6WznJRViUxvPqCppBN2nsw1CgZ8V8YVvPKPCMFoaW33Bh?=
 =?iso-8859-1?Q?C2TLcxKWEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5pAMuxakZXiXncjgtxiLaUz7k4U1AzdvMLcLIRPQpYKChiUER47jwnQTaIomixQCEIaeYcc1x/DYPZuXE22LpQ3kPISjS6atc2zpHtmRz3JPAZ/MrL4RZfm3v4WQ2N4vP71/ZkMwb8Vxx1F9h048qUvM5OrmpvsRAfCshXvALzXIH6gxtekS+eC7Cc3ssc5TxEhTYWSu3cc4RNezgtzdwjlXuY7ML/PC27Q9alQcQPVkkwq2Lo58qTYZcDMIHkzqVTb4cjLmH8zenKJySXgMAlickfgWyFHTySqj2Hn7VQI8p4m3uJdoebY5z61G6s93SpPVq70EiG6kXFViDlbyVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8c3912-ce9c-4637-63a9-08df08013325
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:15:33.9848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo25/2V6IGCwTr1BFAm6XNfNCaqwOnEWlq5sFVtV5lc64aa16s0xQdTHxC0CKa37qLkqGjEJ83y2qXSBPuQUNmZyyN8tfnMhqMzqSMIm+3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151
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

Introduce a ASPEED ACRY model, which performs RSA modular=0A=
exponentiation. The datasheet documents the engine as=0A=
supporting both RSA and ECDSA, but ECDSA is broken on this=0A=
hardware, so only RSA is modelled.=0A=
=0A=
The engine DMAs its operands (data, exponent, modulus) from a guest=0A=
DRAM buffer and writes the result back into a memory-mapped SRAM=0A=
region. Both regions share the same interleaved byte/dword layout:=0A=
repeating 12-dword blocks of [4 dwords exponent][4 dwords modulus][4=0A=
dwords data], index 0 holding the least-significant word/byte of each=0A=
value.=0A=
=0A=
The engine accesses DRAM by relative offset, so the CPU-visible=0A=
address written to the DMA source register has its top (base) bit=0A=
masked off.=0A=
=0A=
The modular exponentiation itself is delegated to QEMU's generic=0A=
akcipher crypto API (crypto/akcipher.c) using raw (unpadded) RSA,=0A=
matching what the real hardware performs - PKCS1 padding is handled=0A=
by the guest's software crypto stack, not by this engine.=0A=
=0A=
The RSA public-key operand DER encoding needed by that API is built with=0A=
crypto/der.h's generic encoder. Raw (unpadded) RSA is only implemented=0A=
by that API's libgcrypt backend (its nettle backend rejects raw=0A=
padding).=0A=
=0A=
When that support is missing, the engine still completes and raises its=0A=
completion IRQ as real hardware would, but produces an all-zero result=0A=
so that whatever signature check the guest performs on it fails cleanly=0A=
instead of the guest hanging forever waiting for an interrupt that=0A=
would otherwise never come.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_acry.h |  39 +++=0A=
 hw/misc/aspeed_acry.c         | 481 ++++++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build           |   1 +=0A=
 hw/misc/trace-events          |   6 +=0A=
 4 files changed, 527 insertions(+)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
=0A=
diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h=
=0A=
new file mode 100644=0A=
index 0000000000..5ca80deec4=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_acry.h=0A=
@@ -0,0 +1,39 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef ASPEED_ACRY_H=0A=
+#define ASPEED_ACRY_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "system/memory.h"=0A=
+=0A=
+#define TYPE_ASPEED_ACRY "aspeed.acry"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedACRYState, ASPEED_ACRY)=0A=
+=0A=
+#define ASPEED_ACRY_NR_REGS     (0x400 >> 2)=0A=
+/* Max size of the "data" (message) field within the SRAM buffer. */=0A=
+#define ASPEED_ACRY_DATA_MAX_LEN 0x800=0A=
+#define ASPEED_ACRY_MAX_BITS     4096=0A=
+/* Max exponent/modulus size for a 4096-bit RSA key, in bytes. */=0A=
+#define ASPEED_ACRY_MAX_BYTES    (ASPEED_ACRY_MAX_BITS / 8)=0A=
+=0A=
+struct AspeedACRYState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion iomem;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint32_t regs[ASPEED_ACRY_NR_REGS];=0A=
+=0A=
+    MemoryRegion *dram_mr;=0A=
+    MemoryRegion *sram_mr;=0A=
+    AddressSpace dram_as;=0A=
+    AddressSpace sram_as;=0A=
+};=0A=
+=0A=
+#endif /* ASPEED_ACRY_H */=0A=
diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c=0A=
new file mode 100644=0A=
index 0000000000..41eac7295f=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_acry.c=0A=
@@ -0,0 +1,481 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * The datasheet documents the ACRY engine as supporting both RSA and=0A=
+ * ECDSA, but ECDSA is broken on this hardware, so only RSA is modelled=0A=
+ * here.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/cutils.h"=0A=
+#include "qemu/log.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "qapi/error.h"=0A=
+#include "crypto/akcipher.h"=0A=
+#include "crypto/der.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(ACRY_TRIGGER, 0x000)=0A=
+    FIELD(ACRY_TRIGGER, RSA_START, 0, 1)=0A=
+REG32(ACRY_DMA_SRC, 0x04C)=0A=
+REG32(ACRY_DMA_LEN, 0x050)=0A=
+    FIELD(ACRY_DMA_LEN, DATALEN, 0, 16)=0A=
+REG32(ACRY_INT_MASK, 0x3F8)=0A=
+    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)=0A=
+    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)=0A=
+REG32(ACRY_STATUS, 0x3FC)=0A=
+    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)=0A=
+    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)=0A=
+=0A=
+/*=0A=
+ * Total size of the interleaved buffer. Data is 4 of every 12=0A=
+ * dwords of a block, one third of the buffer, so the whole buffer is 3x=
=0A=
+ * the data region.=0A=
+ */=0A=
+#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)=0A=
+=0A=
+#define ASPEED_ACRY_BYTES_PER_DWORD  4=0A=
+#define ASPEED_ACRY_LANES_PER_BLOCK  4=0A=
+/* Each block holds 3 regions (exp, mod, data) of LANES_PER_BLOCK dwords. =
*/=0A=
+#define ASPEED_ACRY_DWORDS_PER_BLOCK (3 * ASPEED_ACRY_LANES_PER_BLOCK)=0A=
+=0A=
+/* Dwords into each block where each operand's region starts. */=0A=
+#define ASPEED_ACRY_EXP_OFFSET   (0 * ASPEED_ACRY_LANES_PER_BLOCK)=0A=
+#define ASPEED_ACRY_MOD_OFFSET   (1 * ASPEED_ACRY_LANES_PER_BLOCK)=0A=
+#define ASPEED_ACRY_DATA_OFFSET  (2 * ASPEED_ACRY_LANES_PER_BLOCK)=0A=
+=0A=
+static void aspeed_acry_hexdump(const char *desc, const uint8_t *buf,=0A=
+                                size_t size)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_acry_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The interleaved buffer is a series of 12-dword blocks, each split into=
=0A=
+ * three 4-dword regions - exp, mod, data:=0A=
+ *=0A=
+ *   dword in block:  0    1    2    3    4    5    6    7    8    9   10 =
  11=0A=
+ *   region:          \---- exp ----/    \---- mod ----/    \---- data ---=
-/=0A=
+ *   lane:            0    1    2    3    0    1    2    3    0    1    2 =
   3=0A=
+ *=0A=
+ * Successive blocks hold the next 4 dwords of each operand, so operand=0A=
+ * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so=
=0A=
+ * byte b of dword D is at byte D * 4 + b.=0A=
+ *=0A=
+ * Return the buffer offset of byte 'op_byte' (op_byte =3D 0 =3D least=0A=
+ * significant) of the operand whose region starts 'region' dwords into=0A=
+ * each block (0 =3D exp, 4 =3D mod, 8 =3D data).=0A=
+ */=0A=
+static int aspeed_acry_operand_offset(int region, int op_byte)=0A=
+{=0A=
+    int byte_in_dword;=0A=
+    int op_dword;=0A=
+    int offset;=0A=
+    int block;=0A=
+    int lane;=0A=
+=0A=
+    op_dword =3D op_byte / ASPEED_ACRY_BYTES_PER_DWORD;=0A=
+    byte_in_dword =3D op_byte % ASPEED_ACRY_BYTES_PER_DWORD;=0A=
+    block =3D op_dword / ASPEED_ACRY_LANES_PER_BLOCK;=0A=
+    lane =3D op_dword % ASPEED_ACRY_LANES_PER_BLOCK;=0A=
+=0A=
+    offset =3D (block * ASPEED_ACRY_DWORDS_PER_BLOCK + region + lane)=0A=
+             * ASPEED_ACRY_BYTES_PER_DWORD + byte_in_dword;=0A=
+    assert(offset < ASPEED_ACRY_SRAM_SIZE);=0A=
+=0A=
+    return offset;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read one operand out of the buffer as a big-endian magnitude.=0A=
+ *=0A=
+ * The operand's bytes are scattered through buf; byte k (significance lev=
el=0A=
+ * k, k =3D 0 =3D least significant) is at aspeed_acry_operand_offset(regi=
on, k).=0A=
+ * Walk from the top down, drop leading zero bytes, and write the result m=
ost=0A=
+ * significant byte first into out[]. Returns the number of bytes written=
=0A=
+ * (the value 0 yields a single 0x00 byte, so always >=3D 1).=0A=
+ */=0A=
+static int aspeed_acry_extract_be(const uint8_t *buf, int region,=0A=
+                                  int max_bytes, uint8_t *out)=0A=
+{=0A=
+    int offset;=0A=
+    int msb;=0A=
+    int len;=0A=
+    int k;=0A=
+=0A=
+    /* Highest significance level holding a non-zero byte (skip leading 0s=
). */=0A=
+    for (msb =3D max_bytes - 1; msb >=3D 0; msb--) {=0A=
+        offset =3D aspeed_acry_operand_offset(region, msb);=0A=
+        if (buf[offset] !=3D 0) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* All bytes zero: the value is 0. */=0A=
+    if (msb < 0) {=0A=
+        out[0] =3D 0;=0A=
+        return 1;=0A=
+    }=0A=
+=0A=
+    /* Copy most significant byte first: level msb down to level 0. */=0A=
+    len =3D 0;=0A=
+    for (k =3D msb; k >=3D 0; k--) {=0A=
+        offset =3D aspeed_acry_operand_offset(region, k);=0A=
+        out[len++] =3D buf[offset];=0A=
+    }=0A=
+=0A=
+    return len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Return a DER INTEGER body for the unsigned big-endian magnitude 'be'.=
=0A=
+ *=0A=
+ * DER INTEGERs are signed, so if the top byte has bit 7 set the value=0A=
+ * would decode as negative; prepend a 0x00 guard byte in that case.=0A=
+ *=0A=
+ * The padded copy is written into 'pad_buf' (caller-owned, sized len + 1)=
=0A=
+ * rather than a local, because qcrypto_der_encode_int() only stores the=
=0A=
+ * pointer we hand it - the bytes are not copied until=0A=
+ * qcrypto_der_encode_ctx_flush_and_free() - so the body must stay valid=
=0A=
+ * until then. Returns a pointer into 'be' or 'pad_buf' as appropriate,=0A=
+ * with the body length in *body_len.=0A=
+ */=0A=
+static const uint8_t *aspeed_acry_der_uint_body(const uint8_t *be, size_t =
len,=0A=
+                                                uint8_t *pad_buf,=0A=
+                                                size_t *body_len)=0A=
+{=0A=
+    if (be[0] & 0x80) {=0A=
+        pad_buf[0] =3D 0x00;=0A=
+        memcpy(pad_buf + 1, be, len);=0A=
+        *body_len =3D len + 1;=0A=
+        return pad_buf;=0A=
+    }=0A=
+=0A=
+    *body_len =3D len;=0A=
+    return be;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DER-encode a "RsaPubKey ::=3D SEQUENCE { n INTEGER, e INTEGER }" (see=
=0A=
+ * crypto/rsakey.h), the format expected by qcrypto_akcipher_new(). n and =
e=0A=
+ * are minimal big-endian magnitudes (as produced by=0A=
+ * aspeed_acry_extract_be()); the engine does a raw modexp, so the guest's=
=0A=
+ * exponent is always encoded here as the public 'e'.=0A=
+ */=0A=
+static uint8_t *aspeed_acry_der_encode_pubkey(const uint8_t *n, size_t n_l=
en,=0A=
+                                              const uint8_t *e, size_t e_l=
en,=0A=
+                                              size_t *out_len)=0A=
+{=0A=
+    QCryptoEncodeContext *ctx =3D qcrypto_der_encode_ctx_new();=0A=
+    uint8_t n_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    uint8_t e_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    const uint8_t *n_body;=0A=
+    const uint8_t *e_body;=0A=
+    size_t n_body_len;=0A=
+    size_t e_body_len;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    n_body =3D aspeed_acry_der_uint_body(n, n_len, n_pad, &n_body_len);=0A=
+    e_body =3D aspeed_acry_der_uint_body(e, e_len, e_pad, &e_body_len);=0A=
+=0A=
+    qcrypto_der_encode_seq_begin(ctx);=0A=
+    qcrypto_der_encode_int(ctx, n_body, n_body_len);=0A=
+    qcrypto_der_encode_int(ctx, e_body, e_body_len);=0A=
+    qcrypto_der_encode_seq_end(ctx);=0A=
+=0A=
+    *out_len =3D qcrypto_der_encode_ctx_buffer_len(ctx);=0A=
+    buf =3D g_malloc(*out_len);=0A=
+    qcrypto_der_encode_ctx_flush_and_free(ctx, buf);=0A=
+=0A=
+    return buf;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Store the RSA result into the output SRAM data region as 'n_len' bytes=
=0A=
+ * (the key size): the low 'result_len' bytes are result_be (big-endian),=
=0A=
+ * the rest is zero. sram_as is a 0-based AddressSpace over the SRAM, so t=
he=0A=
+ * offset from aspeed_acry_operand_offset() is used directly; each data dw=
ord=0A=
+ * is written as a little-endian word.=0A=
+ */=0A=
+static bool aspeed_acry_store_result(AspeedACRYState *s,=0A=
+                                     const uint8_t *result_be,=0A=
+                                     int result_len, int n_len, Error **er=
rp)=0A=
+{=0A=
+    uint32_t result_word;=0A=
+    MemTxResult res;=0A=
+    int offset;=0A=
+    int src;=0A=
+    int i;=0A=
+    int j;=0A=
+=0A=
+    /* result_be is MSB-first; take bytes from its LSB end. */=0A=
+    src =3D result_len - 1;=0A=
+    for (i =3D 0; i < n_len / ASPEED_ACRY_BYTES_PER_DWORD; i++) {=0A=
+        /* Pack up to 4 result bytes (LSB first) into a little-endian dwor=
d. */=0A=
+        result_word =3D 0;=0A=
+        for (j =3D 0; j < ASPEED_ACRY_BYTES_PER_DWORD; j++) {=0A=
+            if (src >=3D 0) {=0A=
+                result_word |=3D (uint32_t)result_be[src--] << (8 * j);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        offset =3D aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET,=0A=
+                                            ASPEED_ACRY_BYTES_PER_DWORD * =
i);=0A=
+        address_space_stl_le(&s->sram_as, offset, result_word,=0A=
+                             MEMTXATTRS_UNSPECIFIED, &res);=0A=
+        if (res !=3D MEMTX_OK) {=0A=
+            error_setg(errp, "failed to write result to SRAM");=0A=
+            return false;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static void aspeed_acry_clear_result(AspeedACRYState *s)=0A=
+{=0A=
+    MemTxResult res;=0A=
+    int offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_ACRY_MAX_BYTES / ASPEED_ACRY_BYTES_PER_DWORD;=
 i++) {=0A=
+        offset =3D aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET,=0A=
+                                            ASPEED_ACRY_BYTES_PER_DWORD * =
i);=0A=
+        address_space_stl_le(&s->sram_as, offset, 0,=0A=
+                             MEMTXATTRS_UNSPECIFIED, &res);=0A=
+        if (res !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to clear result\n",=
=0A=
+                          __func__);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static bool aspeed_acry_do_rsa(AspeedACRYState *s, Error **errp)=0A=
+{=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_RSA,=0A=
+        .u.rsa =3D {=0A=
+            .padding_alg =3D QCRYPTO_RSA_PADDING_ALGO_RAW,=0A=
+        },=0A=
+    };=0A=
+    uint32_t len =3D FIELD_EX32(s->regs[R_ACRY_DMA_LEN], ACRY_DMA_LEN, DAT=
ALEN);=0A=
+    g_autofree uint8_t *src_buf =3D g_malloc0(ASPEED_ACRY_SRAM_SIZE);=0A=
+    g_autofree uint8_t *data =3D g_malloc0(ASPEED_ACRY_DATA_MAX_LEN);=0A=
+    uint8_t result[ASPEED_ACRY_MAX_BYTES] =3D { 0 };=0A=
+    uint64_t src_addr =3D s->regs[R_ACRY_DMA_SRC];=0A=
+    g_autofree uint8_t *der_key =3D NULL;=0A=
+    uint8_t n[ASPEED_ACRY_MAX_BYTES];=0A=
+    uint8_t e[ASPEED_ACRY_MAX_BYTES];=0A=
+    QCryptoAkCipher *cipher =3D NULL;=0A=
+    int result_len =3D 0;=0A=
+    size_t der_len;=0A=
+    int data_len;=0A=
+    int n_len;=0A=
+    int e_len;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        error_setg(errp, "RSA ModExp not supported by the crypto backend")=
;=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (len =3D=3D 0 || len > ASPEED_ACRY_SRAM_SIZE) {=0A=
+        error_setg(errp, "invalid DMA length %u", len);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_acry_rsa_trigger(src_addr, len);=0A=
+=0A=
+    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           src_buf, len) !=3D MEMTX_OK) {=0A=
+        error_setg(errp, "failed to read DMA buffer at 0x%" PRIx64, src_ad=
dr);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    n_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_MOD_OFFSET,=0A=
+                                   ASPEED_ACRY_MAX_BYTES, n);=0A=
+    e_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_EXP_OFFSET,=0A=
+                                   ASPEED_ACRY_MAX_BYTES, e);=0A=
+    data_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_DATA_OFFSET,=
=0A=
+                                      ASPEED_ACRY_DATA_MAX_LEN, data);=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("buf", src_buf, len);=0A=
+        aspeed_acry_hexdump("n", n, n_len);=0A=
+        aspeed_acry_hexdump("e", e, e_len);=0A=
+        aspeed_acry_hexdump("data", data, data_len);=0A=
+    }=0A=
+=0A=
+    der_key =3D aspeed_acry_der_encode_pubkey(n, n_len, e, e_len, &der_len=
);=0A=
+    cipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                  der_key, der_len, errp);=0A=
+    if (!cipher) {=0A=
+        error_prepend(errp, "failed to create RSA cipher: ");=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    result_len =3D qcrypto_akcipher_encrypt(cipher, data, data_len,=0A=
+                                          result, sizeof(result), errp);=
=0A=
+    qcrypto_akcipher_free(cipher);=0A=
+    if (result_len < 0) {=0A=
+        error_prepend(errp, "RSA modexp failed: ");=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (!aspeed_acry_store_result(s, result, result_len, n_len, errp)) {=
=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("result", result, result_len);=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_acry_read(void *opaque, hwaddr offset, unsigned int=
 size)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+=0A=
+    trace_aspeed_acry_read(offset, s->regs[reg]);=0A=
+=0A=
+    return s->regs[reg];=0A=
+}=0A=
+=0A=
+static void aspeed_acry_write(void *opaque, hwaddr offset, uint64_t data,=
=0A=
+                              unsigned int size)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    Error *local_err =3D NULL;=0A=
+=0A=
+    trace_aspeed_acry_write(offset, data);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_ACRY_DMA_SRC:=0A=
+        /*=0A=
+         * The DMA source register holds a CPU-visible DRAM address (e.g.=
=0A=
+         * 0x8xxxxxxx on AST2600); the engine addresses DRAM from offset 0=
,=0A=
+         * so mask off the top bit to get the DRAM-relative offset.=0A=
+         */=0A=
+        data &=3D 0x7FFFFFFF;=0A=
+        break;=0A=
+    case R_ACRY_STATUS:=0A=
+        data =3D s->regs[R_ACRY_STATUS] & ~data;=0A=
+        if (!(data & (R_ACRY_STATUS_RSA_ENG_DONE_MASK |=0A=
+                      R_ACRY_STATUS_RSA_DMA_DONE_MASK))) {=0A=
+            qemu_irq_lower(s->irq);=0A=
+        }=0A=
+        break;=0A=
+    case R_ACRY_TRIGGER:=0A=
+        if (FIELD_EX32(data, ACRY_TRIGGER, RSA_START)) {=0A=
+            if (!aspeed_acry_do_rsa(s, &local_err)) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,=0A=
+                              error_get_pretty(local_err));=0A=
+                error_free(local_err);=0A=
+                aspeed_acry_clear_result(s);=0A=
+            }=0A=
+=0A=
+            s->regs[R_ACRY_STATUS] |=3D R_ACRY_STATUS_RSA_ENG_DONE_MASK |=
=0A=
+                                      R_ACRY_STATUS_RSA_DMA_DONE_MASK;=0A=
+            if (s->regs[R_ACRY_INT_MASK] &=0A=
+                (R_ACRY_INT_MASK_RSA_ENG_MASK_MASK |=0A=
+                 R_ACRY_INT_MASK_RSA_DMA_MASK_MASK)) {=0A=
+                qemu_irq_raise(s->irq);=0A=
+            }=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_acry_ops =3D {=0A=
+    .read =3D aspeed_acry_read,=0A=
+    .write =3D aspeed_acry_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_acry_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(obj);=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void aspeed_acry_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(dev);=0A=
+=0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!s->sram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    address_space_init(&s->dram_as, s->dram_mr, "dram");=0A=
+    address_space_init(&s->sram_as, s->sram_mr, "sram");=0A=
+=0A=
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,=0A=
+                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+}=0A=
+=0A=
+static const Property aspeed_acry_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+};=0A=
+=0A=
+static void aspeed_acry_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED ACRY Engine";=0A=
+    dc->realize =3D aspeed_acry_realize;=0A=
+    rc->phases.hold =3D aspeed_acry_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_acry_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_acry_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_ACRY,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedACRYState),=0A=
+        .class_init =3D aspeed_acry_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_acry_types)=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index e86d9ad6b3..3912dc2bce 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: file=
s('pvpanic-pci.c'))=0A=
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'=
))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
+  'aspeed_acry.c',=0A=
   'aspeed_hace.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index c9a868b3ef..bbec0d2178 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -331,6 +331,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offs=
et 0x%" PRIx64 " data 0x%"=0A=
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRI=
x32 " status 0x%" PRIx32=0A=
 =0A=
+# aspeed_acry.c=0A=
+aspeed_acry_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
+aspeed_acry_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
+aspeed_acry_rsa_trigger(uint64_t src_addr, uint32_t len) "src_addr 0x%" PR=
Ix64 " len 0x%" PRIx32=0A=
+aspeed_acry_hexdump(const char *desc, uint32_t offset, const char *s) "%s:=
 0x%08x: %s"=0A=
+=0A=
 # aspeed_hace.c=0A=
 aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
 aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
-- =0A=
2.53.0=0A=

