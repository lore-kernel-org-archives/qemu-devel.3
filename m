Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE9FCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5K-0004g5-I4; Thu, 15 Oct 2026 02:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5B-0004dm-OU; Thu, 15 Oct 2026 02:36:58 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0006Yb-Mn; Thu, 15 Oct 2026 02:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As/HcToaG0BiStqYCpzJITbt2INCRk6Yx3SekMg4DMRun2yq0Y3PokipSC0aTaG6g/kLpVu84SD1BImioQehw1R1kFJMs6D4YkvXBsHLfjDMJD5ug58igfd6f/n99vO71nMDxQzsCZ1/e9fVLpk/OsuL0cc6XUT640lsjfdZxxRz8wG0DHYRG47G9cE8qTjLWugf+5X8VSQyXxXW8Pelz90swEj+EvWxhT9cTP/+zWQc6oiuqDJYJrcIht5tcxaqROmYIp64g2L+XuIjMkF2NFlxy93xfsgbyODe8/BRNAu4hrpDwwIB+drPVe6BBGEGRDSJbY5wAkhdlNtL1dkOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25z3SEOLoPJ3UPSHXSrm1iaiKQKp8j5/nmHIsfpvvTw=;
 b=acvb55wmU2vjt3uNXcfw5UH7a093DOyOTKdMenGHsFTwm/xVPCpQah9W+iS/I7LhY9fN5sLx1T4B55Y8afP8yM6XlOOkZgnW2QOc4Jft4L4IrVLXPaKOJaADkoeMQhbTB5rQIINpcY+wAGwRRfuH2e9tq1s5iB760NDR+e15bJQ3mZKH92PWNnGwNfdOqd5Aj2YQYOeGCN8YoALAFx2AByN51HMNyDbBO7mmaq5YtxmSgUnA/njFH9zGYcSVJPYDWGdg8Sb3ANYj1wRNE+qCvbrXGINaMVkrKqX2FM2pvLeh9P8zJn0fVtHO94B982LL3WNYjtJ4fliPZI+cfu5CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25z3SEOLoPJ3UPSHXSrm1iaiKQKp8j5/nmHIsfpvvTw=;
 b=bbfHNTzkRuNr8mMczUbEefjahspzi4RFU/sab9T3iBzzP/tORBLzhI2wQaVNx3BptDFig4hjRUMvDxxWt8ulEJzv3+HADqrA8ZtnQWeSwHfL/4+lKnYsfQIKmXW0okfybJ+FXKRjmj81KVYjGQBa6e0sG3xEzPFIf2ou76GOpz89Cq1d5vmpAVbB2MAvxWBzB4/T4K/o16VU7NY8Hrkaz6Zf3Xdmsvd6+3/So+Xz4AYo+mgsHmkT744KFXIsk9d4Mi4NA2AjUVv6Rrr+SB9KWz0bOUk7oA+3yjc5eh8cii3hGtu5yMpFUGnNavBxaJfUXS+glwIcV18bBCrhTQhKIw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYPPR06MB8051.apcprd06.prod.outlook.com (2603:1096:405:318::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:38 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 8/9] tests/functional/arm/aspeed: Add AST1080 test with
 ASPEED MCU FW Hub v01.00
Thread-Topic: [PATCH v1 8/9] tests/functional/arm/aspeed: Add AST1080 test
 with ASPEED MCU FW Hub v01.00
Thread-Index: AQHdXG+Gxe9VnVovjUiy8K4wOa/hjQ==
Date: Thu, 15 Oct 2026 06:36:35 +0000
Message-ID: <20261015063625.186708-9-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYPPR06MB8051:EE_
x-ms-office365-filtering-correlation-id: 800a8c9f-8c71-4c24-8f47-08df2a86aa8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|260925022911599003|260925021311599003|10067099003|260925021911599003|3023799007|921020|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 0jANynBEMOF4y4ZwYnRDga9xFt9WTAUbgVI4qCQYtcozNt8Gcf3yqAcy3PzgiQotPLbPF0EQUTRxBNoVtEXc8wpwa3fdPOv/LJADY/cMQezzpITOCF5K3uwqCrsWT0Uwc4OzNd9JeU6zV2TzX8i7Pgvxfd+rD6ePDnxIZy21Dp2WpG5P0v2TBgEQzpo2MjD1YEaECV2zb4fiCUij3FHdM2T3mjXfsZdRnQ08aq3GO/nRl8i7V6AmoMHxtoWAJZIdQ63MIfb4c1lEBwuYH7pFAj1W5epmjQBVShT0l5z+YorVLVyUuz+a58cPyVygse5uhUikXupGmUT1LIiW8f4ozkxJOtSvVOhytMYGoP1Cx5H6/zWUDe1hoAXosc81mi4SocMYIkNR5BgAnJGKiVl4V6bcIBUX1NiGoAIyWib1e/zMLKbiIVGWQ3PCBSpHrMU3DmPsLYDW6yJXuNjoeHRx4kLmwen3O0WLBXw8Iu7QCvw0wiYwV9OJg/JQkylvTiV+0sv8FVZRaZvMudTa4cCi4FrFBRIYeJaVUj9RGHSpfInZlDErQVnc9nZrAYhsVh7NOIAdZBQQqFGRYRiKPPJWs1AIWIWSPrnoT9skins0ChfTXZ6ZHiCAOR/HxLeUVZH3IbspvUiM/6rKLTMIwt1nvPYD69x14ucDdFkr7ERaS7nCbxuraEYmVkJOamdcroxqcK1Nt5p2tG3ca+BJRw+VWVlflWfA72TSEwtuTHrZj7TuhumEG3wa5180c6B2gSG3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(260925022911599003)(260925021311599003)(10067099003)(260925021911599003)(3023799007)(921020)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1ne1BdC+EA2A78syR8dnZ5t0YWit4ZPSEYaQm6iP2bymmPSz2nJDwSt1Y9?=
 =?iso-8859-1?Q?SD0sPc8YqL1cIecz5IpRojpj4+xoYiqqc7kwT9fqEaK/ySC4MHnzdCV3l8?=
 =?iso-8859-1?Q?Va2nQoh8k8R+FcIWyMJu0JOw3GCoFJHDn924nukP+yuxhcY+nMnS9pfXNt?=
 =?iso-8859-1?Q?oaJkPD5fCLWNciKOeBT3IOygDWnyXCrlSJkTd741b50xewkfEyZnhoj9c+?=
 =?iso-8859-1?Q?u0MzRtuk3D5xhzPkG4W2ZwZg2aUzc+yp/3rHfu+xGsG+TJ5coqPXGcOTnQ?=
 =?iso-8859-1?Q?lNgb9L6Izb8HyfrzSAUlPJeYLm7x9flDjx69u6KaDSvYZYh5cwyQdb1XJd?=
 =?iso-8859-1?Q?VJvFZlJ7CbnMDrwl3uyHJTjvapI7aWNmKGXzE052OsOx5reIv3wxJIRkWE?=
 =?iso-8859-1?Q?ah895YbuuC5UXNYGC2iLjP18lhfdvwuEM/pxtegIKXAMKqvVEBcygdSG6d?=
 =?iso-8859-1?Q?Mjs2fM3ozLBF0UIZ++zkES8CXFcSRnkdtw+BW/cydlSlw7dHkvAA/EFYzf?=
 =?iso-8859-1?Q?rAZxhoJ6Q7K1vO6oRnJW8l/Sdls7GvnSzYmArXFq5sBdCpOEZeT64twBww?=
 =?iso-8859-1?Q?sKN4JAW8wNEl7wDD3zfKk1bw1k78P5AQj1Ga6P3vbeflVwY3niNWVzO5YX?=
 =?iso-8859-1?Q?AhEqmEWmJArLTL+nS9b2W9SyIckEy2HRKeT0Nhb0xkwPyYnYqAX9Qpwo+H?=
 =?iso-8859-1?Q?yMOcDTf2ey/Ro7fS85CymiAJ3jWHzy6zaoPlWBn/Zea2+CcDaDB/0rFABk?=
 =?iso-8859-1?Q?i5vQ3LrlNAnBRSpGS+9xsIieudJ3dBLJ4bFhPHQ1BeDtXeALE0BwsFxXlv?=
 =?iso-8859-1?Q?Zbs6q40y9Sq/jenQkvK7zgVvNTikim4RKO3mPqa/9OeDJe1IO8x/+W9qmD?=
 =?iso-8859-1?Q?2tmUbjSb7Kg93ZJ0tVgYC5U/oWSU8BHv8wSLiTe3GI6qTVf9q9I46/vvu6?=
 =?iso-8859-1?Q?0H/xPFbR4YdmZVt4UWLqcSpVyXU2JZvpJlKai6ZxEiKgzrCAGHj62GVr6D?=
 =?iso-8859-1?Q?FCkjGIMBajxWbVGyFYX8JLQeL7Pt5uLwjcey7KfZSr3LyihbP7Y0WNdcPL?=
 =?iso-8859-1?Q?o2y7k31AjynmNrJ4zhgUG8i8R4C0cJgagdy6xs6bOPybX0T8akAnc2eItZ?=
 =?iso-8859-1?Q?7KVD8cTxwRdlrOmG/pmrr+guiUM6KD0WzzSJ1LXUzlMzF0jf87vhICZ5PM?=
 =?iso-8859-1?Q?RTV3qKOmk3FAiu2NJ3OooP4pRxgUPl8BVAVbrL3HKK1Twn/lvTr+JRSs/z?=
 =?iso-8859-1?Q?4C7FtSaDEC14A+ueExhn9qX59YF/b7CfaAwDxcH4/wkAG8JZOqrkMihgLU?=
 =?iso-8859-1?Q?0YqPpBr1cYuiKmKXz6PimCw/Sq85PNlPhcSC+itzdkWFKYr3O7fQe4mNOK?=
 =?iso-8859-1?Q?SXJHxzmi37gjSQRl8rh6sV+Da4vnbMKaR94RJdtel5ydq/j/IlltAk36Cr?=
 =?iso-8859-1?Q?NuxePzlntq5y9VrGBfLDmv4O87gYxRH7uUa5bb48J1GuH/0pe/+vBQEndh?=
 =?iso-8859-1?Q?nhoSVgRijRwoWwC2PRWq8VlIleeJrmKqqVHpegnNbokHtSQJoaYg4YIWae?=
 =?iso-8859-1?Q?TYsQPpuYqRyafEXpDVQ/2PHN8Pn5UhEX6D7J1fPd0/hArlWq6U61nTWhM+?=
 =?iso-8859-1?Q?i+vVKWrkkkRei1pDvGkOGJW/64GnlE3oilOdnsJlq3WS6WU3CTQhiILC2b?=
 =?iso-8859-1?Q?DxKsGikDBFDvEcye+Ho7Ry7GYx8kVi9i5w+FkQjg5V9oE3sDqmLISNnCOD?=
 =?iso-8859-1?Q?lL5e2ZOqObUhsHl5ly7JQJqysHbQ+CYrL/GfJGHj01VU747OfQmO6dLzgt?=
 =?iso-8859-1?Q?Uiypa2iYOw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2L9dHg6cqGE2U1MspfKzLsUi2mOUOA/kE/DYQAJQASiMUTdQUnjXvCTGsL4m5TZQy67diL0gfsWE7LUqlGpmigJTsfB6SualNzZM/38vLE0HOUrsQBBJGd3dMh0Q8G5ZTnjROhr+wROb70XO3mgxaLTlUmJl0dzzwy2mLVGujF+tAaXSt432x8WtwpEXDZqnIs2qyHy1T1CVGN/BOO7SnqPkiilaEwgQdL0AtuVvvmewNL9aEAT8gYB6l++YjT+UMAm6lT9aqks7H3hXs5rtJMUEH0Kpu87915PzFog6pdrX8LhSNcEmsktAAB3BFZv8sUeK07n+QnytTzGjm7goRg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800a8c9f-8c71-4c24-8f47-08df2a86aa8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:35.0753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJOhmnKcl+ckuUrDgW/YV5ZNY+MHa07Mu5pooVhrlQGW/lNmseba/eSDJoaEnEj29COdEiNk6ogR5sf9n/A3HEnuqIyT7P3CN7oMzPN6UiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8051
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

Add a functional test for the ASPEED AST1080 EVB using the=0A=
Zephyr firmware from ASPEED MCU FW Hub v01.00.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/meson.build            |  1 +=0A=
 tests/functional/arm/test_aspeed_ast1080.py | 37 +++++++++++++++++++++=0A=
 2 files changed, 38 insertions(+)=0A=
 create mode 100644 tests/functional/arm/test_aspeed_ast1080.py=0A=
=0A=
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.=
build=0A=
index 61b00932db..ca04fd9dc0 100644=0A=
--- a/tests/functional/arm/meson.build=0A=
+++ b/tests/functional/arm/meson.build=0A=
@@ -36,6 +36,7 @@ tests_arm_system_thorough =3D [=0A=
   'aspeed_ast1030',=0A=
   'aspeed_ast1040',=0A=
   'aspeed_ast1060',=0A=
+  'aspeed_ast1080',=0A=
   'aspeed_palmetto',=0A=
   'aspeed_romulus',=0A=
   'aspeed_witherspoon',=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1080.py b/tests/functional=
/arm/test_aspeed_ast1080.py=0A=
new file mode 100644=0A=
index 0000000000..76f3cc0983=0A=
--- /dev/null=0A=
+++ b/tests/functional/arm/test_aspeed_ast1080.py=0A=
@@ -0,0 +1,37 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test that boots the ASPEED SoCs with firmware=0A=
+#=0A=
+# Copyright (C) 2026 ASPEED Technology Inc=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+from aspeed import AspeedTest=0A=
+from qemu_test import Asset, exec_command_and_wait_for_pattern=0A=
+=0A=
+=0A=
+class AST1080Machine(AspeedTest):=0A=
+=0A=
+    ASSET_ASPEED_AST1080_EVB_01_00 =3D Asset(=0A=
+        ('https://github.com/AspeedTech-BMC'=0A=
+         '/aspeed-mcu-fw-hub/releases/download/v01.00'=0A=
+         '/ast1080a0-evb-v01.00.tar.gz'),=0A=
+         '7c8a95bc51945d70591b20f1a22f8fffebc2b164e6fda47f73ff67f37bed8d87=
')=0A=
+=0A=
+    def test_arm_ast1080_zephyros(self):=0A=
+        self.set_machine('ast1080-evb')=0A=
+=0A=
+        kernel_name =3D ('ast1080a0-evb-v01.00/ast1080/ast1080a0/evb/'=0A=
+                       'zephyr-shell-module.bin')=0A=
+        kernel_file =3D self.archive_extract(=0A=
+            self.ASSET_ASPEED_AST1080_EVB_01_00, member=3Dkernel_name)=0A=
+=0A=
+        self.vm.set_console()=0A=
+        self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
+        self.vm.launch()=0A=
+        self.wait_for_console_pattern("uart:~$")=0A=
+        exec_command_and_wait_for_pattern(self, "help",=0A=
+                                          "Available commands")=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    AspeedTest.main()=0A=
-- =0A=
2.53.0=0A=

