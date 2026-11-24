Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C2606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=d3aQJ2d7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVR-00045f-Fi; Tue, 24 Nov 2026 00:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjVM-00044p-8D; Tue, 24 Nov 2026 00:55:48 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjVK-0003F1-Il; Tue, 24 Nov 2026 00:55:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sssWP/+mbKUtHl8H4vmElbZmPhFKHfHX6M9JYzkkdhiOGLnrDYKZV0FJxuj8eq8jpI89Yw4T+gnIXa8E13m0glY+jQnic8gOX0IlHM5q/C+1u7GbQsz4w+f4fkvRWn8WudimTBVvvQ4mDxlHovgiSz42FMJeppGNIEtkAE5A0Jz9x4Ogfgv9emjB6fs8JXwsoX2xjWWaxwgHT8El7GXJgpyX/yvj5uSH40PdY+zkWT6Mez8C49urCW2S1Oz6BOtYVO5q4n0hasUDwYyRwiPmUNR/MZfx/UvYltcfElwHozrSrcRhbdJpCJlrq0u/HXfR+bd9qJT5NRbN8rg751z8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgfFswja/aUGLrLQ/Fp8Mw53b5cJU17OnF2fcbtAhjw=;
 b=f1tz5cFQXNBTslu1oJSWjmhoBiFV9k/WAqyRbGhqF7FPGVLuI/NdaB9tdTxmtX4CddlcI0D2Cbazva23Y8wEs23CEIgI/Nt6Zg+QnkipW3OtHb0oyKoJbZgQV76mNONmsIxVvQNo5fH8t5CtQG7YKQQAsmaDXsj6FTYWPjiI5vQU+q2EULs/W0v+Mx+H/xvXRNIdxDevV9/DkOCEInzU0w7tN2CiFNV1k8uq2dlF4JG7USWh8nVkbNNg5mA8JQP2Qznifsg/Jf/opwYtm50HDw451Td669IIxzzx7WI10+5faxG5XazbQYIvo+SUnzTmaS19wR4Fu6ZbkYPY/Oecew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgfFswja/aUGLrLQ/Fp8Mw53b5cJU17OnF2fcbtAhjw=;
 b=d3aQJ2d79L9D588TFJvxMznV8sWDcoz/jaVE07eCw721yyQVMsiYqy5rGxBDlpFNh7WNCy0sNmDnbne1ptkHkNLfb9PGGKee5iUPZVvGvaGX9s/WtVwjJEjEOSdsBeOwiuMiARgQ8TBKmfi8jT7ZpbQTTlq6Z1tDb2Thecu2RvY0Fgawe52PESj+J35El1mWgiXHRiZtosNtYR2kQpwUlz2c6XTjCDYJdj84lz3W06wf+lqFC243jwTutXHZV4lVaMWPSXquqET5bNDuKKrIg94LfBSxxtapHUGPYZ9qNFSy+cB4T7vFzAhnNVjEol6ZuXJDTMkzZqn5FDkTWF/mIg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6497.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:52 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 01/11] hw/arm/aspeed_ast1700: Correct AST2700 SCU to SCUIO
Thread-Topic: [PATCH v7 01/11] hw/arm/aspeed_ast1700: Correct AST2700 SCU to
 SCUIO
Thread-Index: AQHde9fn0gbI6lxI3kCad50UaUS7RQ==
Date: Tue, 24 Nov 2026 05:51:52 +0000
Message-ID: <20261124055150.1328856-2-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6497:EE_
x-ms-publictraffictype: Email
client-request-id: 15124880-f5e3-4900-8503-1c63c1cd938c
request-id: 8bbcaa39-fadf-4b27-1f4b-08df49ef09f2
x-ms-office365-filtering-correlation-id: 8bbcaa39-fadf-4b27-1f4b-08df49ef09f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261021121427099003|261021123027099003|261102123227099003|38070700021|56012099006|10067099003|18002099003|22082099003|261009221727099003|261009223027099003|261009221227099003|261009220027099003|261009223327099003;
x-microsoft-antispam-message-info: IdIA4hH88rLuUSNMJi1gSsQO+uisNaSASKF3uYw28b4e6JBABf2gONtd8kvlivZOVnDoa0ej9ZmQdRZYZ3zl0WTZQ6ow5y8VNEb/sDLjMTKGtVxOYqKhnGqpltininglSSXRCG9p8xWf/fUAY9AtCjBLJITeYOKlx3HaGsBr/+nLYIxaD9gQ89d4ylW7LLcaByESknTODa81crJ5+mPWeU2p/KgfJt4CPEDKs5q0LxqIZwlQhfnuPrU58JaboK1Mn43+V8CGJrPhJ2ll5IKsbdl1u2odL5Xm1xUtZ7sc6yyLIQndEZXaew2H5DWbrcBmvWdHZPq36iv6jTiAVc0HXoGmxO0d6DZHhVAQJLTabYElouexBHpZWp2wXran5x2vzNwC6LEVwbNofapj8Vj84mpTnVYvRQmiDyJA5qcGF50R4SEKW1WXUGRsOotLLnrvFNy/ru//WMx6NZ8JfI0TE5nI7b974gqfeG3/f4UOd+eYAs0iz1rdbWHR5yluzydDjY8S0kHM0957j2deTUefCyqeg6VnIPwEQmpEi9XynY6Mdm0brf5DlwJCjw3sqcC8lHoe1LjNzy+6DipzVRDOhPFU1UmxubT7JP742bGIEIB0lGZQwMfpNZyWO89VN0Mx+Eko7Fher0ZKBqlU2sl9h1yYh/vXUtIma1Ix/WP5RC+VN89Yu+Ovncyuj+RQ8lJCaSolcTAwOalNayc8GkjESFThglhpzSEMPbaqVQtxPZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261021121427099003)(261021123027099003)(261102123227099003)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009223327099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sss9/OoG/zzS2iXcJa4qK9tCO0SC5pBPL1IS1j7QCoKtHj74o64AOIsrFy?=
 =?iso-8859-1?Q?4qcKfE1B5tZ97YrVVFxWJgSFfrRm20kxZxw6cBXTyxjp7zj+CHfkezYaKu?=
 =?iso-8859-1?Q?fOPHS4Bl3tHoPfojBdNviUEZuahKzlV9yn/VR6kHXh+AAHF39V/8kmLdWc?=
 =?iso-8859-1?Q?FQxO6EH+QBeV5bO7QQiX1ZC/N9idlhB6VCD9W/lk6OsjbKvHkSOMsK9UTL?=
 =?iso-8859-1?Q?evylfrVtsxNQEkYvnLAcmLMl3UjQ27nzLZp+ggCHxdn+gMDF85xa3OI1/V?=
 =?iso-8859-1?Q?rFrTmOQRPaf0e5FULlRq12RK89KW6U9MvVHXI22hdtKLI+4S7NsPQYcPUK?=
 =?iso-8859-1?Q?YmuT5nds/B7/JdN3RPdDqSCkxSzNkS+etjt4SOb+w2MHQEp1sfFrUgkW6J?=
 =?iso-8859-1?Q?wT3ET7081kMBH2KlZ5xc7BLBDtQ5R7ArdPpq0DhNa+gWwr8Sq76LuhrpDJ?=
 =?iso-8859-1?Q?JA/a+YprQ5n07l0pmU0z9sG9zQJ6PTG+dOpApEaYbcxIgr5J2JM1pNuHya?=
 =?iso-8859-1?Q?wdJz+bD2N3eIX9eGW09cxYputrORIDlJ/Hv221SMS2IKC3CtFegz68IZyk?=
 =?iso-8859-1?Q?C892pETPJ8vt1KNq46i/Zx8To0qzV6dbNFjo7TckcSknahf516ylQmHy36?=
 =?iso-8859-1?Q?uKK/skWGERSOnE/OTLj0MAbt5zc/5jzyyYpVQRD5lAeoZI73h+7oWOKcz4?=
 =?iso-8859-1?Q?B4VHl+8AV9nw+Vq5ekuWfMD+NFkQsKCjdYdjJ39AvBR4D7YGgpoecql2xa?=
 =?iso-8859-1?Q?K4VJPI/CzCkzROy81EgfVE8sNwIEoV4a5fU7wRZhSaowxefEh3++em4vs1?=
 =?iso-8859-1?Q?0Un8YuXTvaKQSzY25RGNhh7XRnMrcsAe2j9IjeOISOHInhTuc6b1Xdo8+b?=
 =?iso-8859-1?Q?VBqwdG9no9nUw9eqqjcSSK/O+y+x2BwJNXyfd6cqQH8r97fIGnkxHYxBcu?=
 =?iso-8859-1?Q?p3kbDLO80ZLDSxTKMPpE26xmV0VlLU6QgcodZnSVpSIZU+2wAsNe4O+UIm?=
 =?iso-8859-1?Q?PwHt9LBUU706dM9dtdvCn/JxEho3i62FAOEwWyWdjc7LD+hUTvh4HQ5T49?=
 =?iso-8859-1?Q?fpKBEkdQswd8isJXaFZk+ZMitbI7Mp9qh0glyoCMyNNjmS9dJeG7db7JUz?=
 =?iso-8859-1?Q?Gk6wIZiwqFYzrU9ssxMOdPK7idTPdTebHn+fjBQePW4KADgjSL71mvJT+K?=
 =?iso-8859-1?Q?tV/cI97vpDZ8rkWhMZSBip/XAf3dXisVKp9FauUAjjlfYlSsfAZw+IvlJl?=
 =?iso-8859-1?Q?nDrVqK7xj7kHwVIkC1kcKc/je+xO2CQtjKbLhJxbolcylbKxBSJvQGsn28?=
 =?iso-8859-1?Q?srzcubunqemPhCz6N21eyCLZVtNNU9cTi+s5heJMbCJ7RSaU37sxNQqDxX?=
 =?iso-8859-1?Q?buS5Y/7s1lf705rL+5AlMWWdUzrFQ5/mjQsV6yeyGayz7p5Z/1QRK8Ax+g?=
 =?iso-8859-1?Q?o99cAXEgnmlGG68FFWB349/tcdxADMZp9Yeid6myhzr0ow1kuZhFgVDQZK?=
 =?iso-8859-1?Q?tRy/616WfA593B73E7A1aIyqh1gp/mxhtbSNS2nz5aKrn56Z4kA4Kva7kM?=
 =?iso-8859-1?Q?Bo20+0tZWXce3MC2XVLL3C3maKSspa8ETqqFM4fhnMWGsRRNmrHzUCuvXi?=
 =?iso-8859-1?Q?bnXNfXYPOBBjMtzw8R0++8WaJSvWHUtWdoRIQum+cXv1fpGbvwKD4Cn2u5?=
 =?iso-8859-1?Q?/WWyl291oF3D0aq8jObAuz6S6FfgBbiqmy7DJwoj4QbbxT4ykI+uiNze/6?=
 =?iso-8859-1?Q?I69PVD3+cRIgQKjw0e+5q+FrrxRZDd28YBvWjJBKpx0r2xpiKiG/TDgU3H?=
 =?iso-8859-1?Q?BOZVM0sr9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbcaa39-fadf-4b27-1f4b-08df49ef09f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:52.1703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpCZciNK2x3koAVjMmq9G4CYgQ+nGXB6HnpzjrBdSn6dLqzZrrBAh1NSwRTq2neGuMt7OgopIdaqpCPbVRFNnBUt7gP7Wzgkuaepm1IUipM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6497
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per the AST1700 datasheet, its SCU register layout matches the AST2700=0A=
SCUIO (I/O-die SCU), not the AST2700 SCU. Correct the I/O expander to=0A=
instantiate TYPE_ASPEED_2700_SCUIO instead of TYPE_ASPEED_2700_SCU, and=0A=
rename the "scu" field/property to "scuio" throughout=0A=
aspeed_ast1700.c/h so the type change is clear at every call site.=0A=
=0A=
Fixes: b500ab00552da06566a505a397255f4c031670aa ("hw/arm/aspeed: Attach SCU=
 device to AST1700 model")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 +-=0A=
 hw/arm/aspeed_ast1700.c         | 22 +++++++++++-----------=0A=
 2 files changed, 12 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index d30483c88a..878d9d5420 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    Aspeed2700SCUState scu;=0A=
+    AspeedSCUState scuio;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index e5d5bf4056..d92d9ee46c 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -21,7 +21,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_PWM,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
-    ASPEED_AST1700_DEV_SCU,=0A=
+    ASPEED_AST1700_DEV_SCUIO,=0A=
     ASPEED_AST1700_DEV_GPIO,=0A=
     ASPEED_AST1700_DEV_SGPIOM0,=0A=
     ASPEED_AST1700_DEV_SGPIOM1,=0A=
@@ -38,7 +38,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_PWM]       =3D  0x000C0000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
-    [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
+    [ASPEED_AST1700_DEV_SCUIO]     =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
     [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,=0A=
     [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,=0A=
@@ -112,15 +112,15 @@ static void aspeed_ast1700_realize(DeviceState *dev, =
Error **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0)=
);=0A=
 =0A=
-    /* SCU */=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    /* SCUIO */=0A=
+    qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
                          s->silicon_rev);=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scuio), errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(&s->iomem,=0A=
-                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],=
=0A=
-                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0)=
);=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCUIO]=
,=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scuio), =
0));=0A=
 =0A=
     /* GPIO */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
@@ -175,7 +175,7 @@ static void aspeed_ast1700_realize(DeviceState *dev, Er=
ror **errp)=0A=
         hwaddr wdt_offset =3D aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_=
WDT] +=0A=
                             i * awc->iosize;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
io),=0A=
                                  errp);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -206,9 +206,9 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-adc", &s->adc,=0A=
                             "aspeed.adc-ast2700");=0A=
 =0A=
-    /* SCU */=0A=
-    object_initialize_child(obj, "ioexp-scu", &s->scu,=0A=
-                            TYPE_ASPEED_2700_SCU);=0A=
+    /* SCUIO */=0A=
+    object_initialize_child(obj, "ioexp-scu", &s->scuio,=0A=
+                            TYPE_ASPEED_2700_SCUIO);=0A=
 =0A=
     /* GPIO */=0A=
     object_initialize_child(obj, "ioexp-gpio", &s->gpio,=0A=
-- =0A=
2.53.0=0A=

