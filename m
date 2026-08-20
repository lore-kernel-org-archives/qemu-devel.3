Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F235C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxsz-0002AN-45; Thu, 20 Aug 2026 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsx-0002AA-HE; Thu, 20 Aug 2026 04:12:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsv-0001n5-Tf; Thu, 20 Aug 2026 04:12:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC0ykPPa/TFmsPmbJPTIuCXFtYXUhc2lDeb4Ezg6ZnaPoWCrIFdAxo4GSI9WILT7uuB1lLzT6ehcUOHCJ9IuUv2trA0lXMrEUNwsekGqheLbdxwp+TbfGgTng6XMgVP6B/zvlC8lGAPeag0s5UWe39PNunTOm1Hh3ZaiGOBYS5sHrbTgHbsHxuWUx/cmBf9yXvVxOe+CP/ZAV+0EK7lVHrhreBXgO+BA9XSEW/cyh/G9CyL3tY+kjOqKtRt6inkqiA1clb/bugZdmuumkABM0tey//tAhY9tdAz8DQAVC+o/neXKxAOkoKBclPWwaR0zw7zgfr9tA1uxz85FJNRAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fhox2ooPUmSMZsC0tLODgxEE406q5EtnYQQSBAvUvI=;
 b=oPVlS+TpWzQllUMO5eL4tWaYgrPx1p/A0ka6mdg4lz1DI2HsrVWBJiyJ6JqgZqcabxgl/EvLcXeD+cURjf3OQpUQ5R/glwyxwZApWN+dZJH3GHg6i6wXlkY+9ln2ATKoa/o7ucJ4Rc8Y17I93YTLHnRURVTcqKuU43rUxr3A++JMUWDYU0l/Hirz/HAtBfCz51S3a6+2fa7hhJRjy01UoJ1UTgh2guHXUMxiyybQJuT6v0gN3pu6/eaVACb40eiIK4ezsXYfFgFy1u+J9vNP0Ax2ufmA/I1ICWxV7dwFHm31z775Lsi0yrLt05YJ+qPcpV9eJgwLIy7ej9zi0ATwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fhox2ooPUmSMZsC0tLODgxEE406q5EtnYQQSBAvUvI=;
 b=XMETOM2xO0myDp9GxF+5nZySHP9zk78jcoab2vwUkZoxjbnt9ywsq5WOidOHWGSYoSP1ss0nQdrY0Zb4h5vlXU2HjFzHSg560OAPxSwpvZjFqlw1shGo+96j3qrbec1Ss3CLy29MKzp5uVkR8v+i1Nm8iInLWnW9ojrIkyJY+G1RnmKJxgE/GQtZLyo3vow7D+wh2jm8IDoE/4Xu84TUGIOL+k94edKk+m15YRZKxMgz33fcrMSCv3/uFDRq19BIqLp20HbyRPTB/9NHY15V2vMp1UZOdS2g/DRhAssFmszA9D5G/wazowk2+sULq2siXbLw0GTspJhxnZcYj731Vw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5661.apcprd06.prod.outlook.com (2603:1096:400:28e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:12:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:12:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Topic: [PATCH v2 2/4] hw/arm/aspeed_ast2600: Introduce the ACRY SRAM
Thread-Index: AQHdMHuZ587zIFAW2UmQTW4ECNe6Eg==
Date: Thu, 20 Aug 2026 08:12:10 +0000
Message-ID: <20260820081206.3353463-3-jamin_lin@aspeedtech.com>
References: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5661:EE_
x-ms-office365-filtering-correlation-id: 09d7e66c-0ad8-4942-5b0e-08defe92bbf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: a1R8NpmXeqQ73MNfyHW38dPO4zFbSRBmzW4w0UsB0NP2neRlPI/htRx+C4/5auccvPk25i6lpth6Jq22NYoCkaLW9hOSyM0NVoBWDWK+aoscz0oq/X3dCk3n7ylBjXFaPobibTHs7U1chB+mLhXCUJlxzv58Gf8JubCmBXfIlbKzdk1tGJHhuXBT1UCnWul/s5G8MW0JLLQUzZekm3qIT63EiXvO8U0Fmg/Tn8fEKkl52aCwirDaa7X+DlJ0XXZYcB9XMfXmUnBY0G8ATMmlirpmuMY3B2zB3mfzkk5UmlkaR27WSYy8ktBb+n3+9l0JsQBX9QPeL0/7fajN7YGJ0haVEWdRTd5yBSRxzqHiRWQeq+rU51zN6yvAn2Ey2KJ60isFzN2x5O6dQKJj1btLwrRfE1AuwQ68rIAdjF4rmuigrPsDvee/3cXrLLQx6WwBgWV46P1eviHBNZfVLxSTr2r/wJNUqKYpgxg3uPl497as94Ans0JDpIMfH0iXCEdfPIp+8TywEN4lZqvanRHNESyMomsQdxieUkYVB3OWzYDeSWdjIBDUtETHRNvVyMsrTtWZ9gptE9Lg7VfgizHr985okUQ0SG3LmNuNzQWPYbhGONhyrxMFi6D8J8cgJg2/oslgD2Mry2tI6VjWjXQplfss/jU5vn2A7JmxZ+kgNYkf/dA4DUGAxFaHcrP1qPvP6c+FjYV9pyJIfgADKrlLX/xPeY0JG5Z98LuhOUqmcnTH5Qe0+UknYxp0oykfBkKF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ImOQZZ83G/r1kMn56kfsfIKuGKNObGgYZu9tjx6/k5+rS7Pofcsewst55D?=
 =?iso-8859-1?Q?oTyo586qnzF+6riExOPq72VLEPNib6JK8LWMG8kAnDIfiOz7yd0D1D/zI7?=
 =?iso-8859-1?Q?j2Mv2LCd478nNMaDB4O69bNghK0od1gU1LahvFn1XE7luQRNHChx+auZpK?=
 =?iso-8859-1?Q?93QtLNiOx8Hf+wqVZL0ULBtX7u6WBENVyua/2Wg6vb7k2PW4KiOW7pun4W?=
 =?iso-8859-1?Q?i8aHyxenOA79E9inI0Q7aLoQja4y1RGVSAotOUuzu/h2BE9DyOouivFPfo?=
 =?iso-8859-1?Q?Jn4sTZZokV6AV/x88aVSJqndLjro3kFCHXihPfo+T0KtywVov40L4P7mpb?=
 =?iso-8859-1?Q?NxSp5D6vxbzVbJIEDA+CaBijgDqBZSCPd7OX7913pAAoN315Dr/vwoMhFa?=
 =?iso-8859-1?Q?LReFJpJZzzeJhsmccImR84Z+VjO4aDF23L5pJO21rWtx8nV0bLVpqk5/lY?=
 =?iso-8859-1?Q?wTvmITAeYJ0D101AF57gdsBPQPCKSzSAdv80xuQ69JaY7T7GRS9x7+oxAJ?=
 =?iso-8859-1?Q?hCnDSvDhiXc9wTAkupgEPtxz1FqeFagTYa1Vw5xNy1V+s0hOydIZO7P2st?=
 =?iso-8859-1?Q?sdw8DdGZ/C9Yh13hNF2XQOlO7fO1fCuwE+bCGh545z3jMRy+UQ6t+mTYhp?=
 =?iso-8859-1?Q?dYcFfQMpDvt4f0AT4QXu0mfJLTL7Am6o/KjRspuCFL6f9Fzvv4rk9WehRI?=
 =?iso-8859-1?Q?BjNM+kx7dZxUtkqnMUffwGSUWasQm+dvhEkWeziUYKBMs/MRDpsPe8PuF5?=
 =?iso-8859-1?Q?UYhC3DkPY8RM7AljS3nizLcPK9QgNSFXi+VuVc2LPHusQyMvAlp72pb6lQ?=
 =?iso-8859-1?Q?3nEso3iLfnclo6g5I4hWm6YriW9iYfeb7kNU5r2wrvaEZr1SwaLNJ9/830?=
 =?iso-8859-1?Q?GgtpwiIXkDIspm/KfdwZMFZr//og2zCL8nXDwmoXDmSsESBjujo1yfudRg?=
 =?iso-8859-1?Q?iydP8+A5JAHv4wDmNJ7JVju/qzduM+y1XtduiNxJCQrtwIu1sAWmzTR5aC?=
 =?iso-8859-1?Q?VfDQQ2rxVylI6QTznYwA0yXALoxbeL0Yyw5hJSX9rhEGe9VJQ3M/dDCods?=
 =?iso-8859-1?Q?uzWuklh1wcd2jasLlGvWnlir4t0s1men3ywshvjlZekXKiUUldD3LQ1apX?=
 =?iso-8859-1?Q?BKnjzZrNbXAm4sxjSwthvRo9R70KEsk7oZjZbTUbqCm+vRlKRy5lQKTVCU?=
 =?iso-8859-1?Q?vngGYZ9vLAK8pFif280jQOamN6tBtzXCeZ7GBF9Gej9zH+zg02njbkr23p?=
 =?iso-8859-1?Q?ozKmY4saeMbUTbgrwJvhnMKO8wv7SOf0RxD9FE6PV5Ltg+aFt1CwEqU7Ok?=
 =?iso-8859-1?Q?xdIm9r7ff+Mn2/yNNcny2O1/A5ueTo3XCFrsGDxbShyKqnlHouZWRUGbxk?=
 =?iso-8859-1?Q?Zq4D8XT/qwDu2WReKVvGKAXLD50Gq8uAp6T01CwVV7/Zh1vtluh5px+ZYC?=
 =?iso-8859-1?Q?3fISTDApjpziCygjIQP7kyhe7gHkNZoaSuOBxI1XtOTfT8bV7l5IF43yAe?=
 =?iso-8859-1?Q?bTKFVuwr0ISgSjEaxJCHWrRAMN6F0UqOPESNUX+QUaAjFeabv1d3Cakxm2?=
 =?iso-8859-1?Q?s36GtCJ7qcyOi8lDNdNTxuA6QmTr/X6Pb5gGd47qA78DjvpPmglSvgBQgx?=
 =?iso-8859-1?Q?iivnUb92vvqGE/WrcNpb/BJlxTyXzt8ODBf4+EqiusQ4kG5tRm91uGzRH0?=
 =?iso-8859-1?Q?eK5G90gClHBxfPZFBYNq2UzEBwPzsV+FzjGhG0fJlIZFjJbbVpMotUGzV5?=
 =?iso-8859-1?Q?uLWpqXZQG2exX5sWt0Wty9FWJHALClK/XIBTussZ46zVuSL/jC8YhemOjV?=
 =?iso-8859-1?Q?9ytUj96MoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FQOjK6k8gVjWU/ie3K4zW8ak3CGz7zZjkU6CXHorN5pqkT8EBExI75atpov05C++Rjy936zF5VXjtQnUy0Z9dnDmEu7ov/h0+UX/C3am705Cyh9ic+tSVaofbN3HfrklSmm/aNd7NvbRWHwEAjuMqkU6hBIS3r5Qjt+XR01clT/D8YPReGBU1JNY9d8gtvLylPfqw3WJc2fEIe7W25l1wjWDN6tY/3x7yfqi5d64FmRDY/U9ZqRJjz5hmJoK86m2+jan9jncBeob1pPYogSUWGb0QTniIYRL00mMQfrkDTIYpSYeGyx91UOEB0qbIPO7uGqmmpve3RqXlRuUi+JStg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d7e66c-0ad8-4942-5b0e-08defe92bbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 08:12:10.4581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp3uQ2b65tA/O4UdhY0Q+KUEEca/Bv8zOWyi3nZzVaasED/FARAe6jtfvchQQ0VgX5SIPb6QSpnCQAGs666UABzSn4rRigqJQ8ggyuhOwjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5661
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

Reuse the existing SRAM array convention on AspeedSoCState to add the=0A=
64 KiB ACRY SRAM region to the AST2600 at its real-silicon address=0A=
(0x1e710000-0x1e71ffff).=0A=
=0A=
Wrap the RAM in a container mapped at offset 0 so the ACRY engine wired=0A=
up in a later patch can address the SRAM by relative offset without the=0A=
device model knowing its mapping address.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  1 +=0A=
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++=0A=
 2 files changed, 18 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..46e7854727 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -69,6 +69,7 @@ struct AspeedSoCState {=0A=
     MemoryRegion *dram_mr;=0A=
     MemoryRegion dram_container;=0A=
     MemoryRegion sram[ASPEED_SRAM_NUM];=0A=
+    MemoryRegion sram_container[ASPEED_SRAM_NUM];=0A=
     MemoryRegion spi_boot_container;=0A=
     MemoryRegion spi_boot;=0A=
     MemoryRegion vbootrom;=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..f23a51c8a4 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -8,6 +8,7 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
 #include "hw/misc/unimp.h"=0A=
 #include "hw/arm/aspeed_soc.h"=0A=
@@ -24,6 +25,7 @@=0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
+    [ASPEED_DEV_SRAM1]     =3D 0x1E710000, /* ACRY SRAM */=0A=
     [ASPEED_DEV_DPMCU]     =3D 0x18000000,=0A=
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x1E600000,=0A=
@@ -361,6 +363,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
     AspeedSoCState *s =3D ASPEED_SOC(dev);=0A=
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
     qemu_irq irq;=0A=
+    g_autofree char *sram1_name =3D NULL;=0A=
     g_autofree char *sram_name =3D NULL;=0A=
     int uart;=0A=
 =0A=
@@ -444,6 +447,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory,=0A=
                                 sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0])=
;=0A=
 =0A=
+    /* ACRY SRAM */=0A=
+    sram1_name =3D g_strdup_printf("aspeed.acry.sram.%d",=0A=
+                                 CPU(&a->cpu[0])->cpu_index);=0A=
+    if (!memory_region_init_ram(&s->sram[1], OBJECT(s), sram1_name,=0A=
+                                sc->sram_size[1], errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_init(&s->sram_container[1], OBJECT(s),=0A=
+                       "aspeed.acry.sram-container", sc->sram_size[1]);=0A=
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
+                                &s->sram_container[1]);=0A=
+=0A=
     /* DPMCU */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
                                   "aspeed.dpmcu",=0A=
@@ -765,6 +781,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2600_A3_SILICON_REV;=0A=
     sc->sram_size[0] =3D 0x16400;=0A=
+    sc->sram_size[1] =3D 64 * KiB; /* ACRY SRAM */=0A=
     sc->spis_num     =3D 2;=0A=
     sc->ehcis_num    =3D 2;=0A=
     sc->wdts_num     =3D 4;=0A=
-- =0A=
2.53.0=0A=

