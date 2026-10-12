Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E843CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mU-0001ks-3v; Mon, 12 Oct 2026 02:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mP-0001j0-7o; Mon, 12 Oct 2026 02:45:01 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mN-0006MT-De; Mon, 12 Oct 2026 02:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM/6mPccPgP9eUuu/8m2/KSONo6Gv4IrPB1I151pzQTguMpCRalSzC/3PdPmbLekfPABej6+bJw9fBng24C2fzKtylzodtNse4KnxUkZK6YjXFx0Lrd2dwHCnXpgAYr5fsXgyNBax7PiU8AslHZ+5KSsdmdPamSwcULvatKiocsNiFI6zDZ0CUopmilpVfOrlnOb3XvnTH65ZZe5mZFqGi9qgbAoNtKXepXwQmeA8052itQpFkd3rkI2a18qVRT525QDs3LL/2NuBurnrv5k13p0GC0Ee7DeMVfID1/ezN1pFYs4HN1J7AAXKw/4apulLroY7124C2dYcWu+cmNfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHni+JWHMnmTvjF6Qba6EqDzI3YT46Uh6pXr3+JFu4M=;
 b=wvrvkLvw9vPxcosO44kRZK1yFFrYARqgWMN+PUb+4E8UBw1aCBGweRTKTlCxh12zt/IOByS9XL50D0Ncv5M9o/7QUUMItLM6F72oDT34xu1kvyyeJVDcvPM4Q3jtDSVHqgKvqXdDdLdd6ojHxOqwTplozqzsBURhlVybvfwc/6cqjQ7O8fmHmFzGBVYvfuSxM3HeUPaFdP2TxxzB871t4tABYTZKsSdg+rLqeaiUfdsZzl27WjlMzN/mx+59896DCRhzRil2EYs9pILVNQ+QuxKzKhbexckZL+C3cUFAeYl2q0AZN7epLPOWncgW7T1C3kODA93Kn+d9YQoOW/h82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHni+JWHMnmTvjF6Qba6EqDzI3YT46Uh6pXr3+JFu4M=;
 b=mkmhRuz0rTNkviaLjg+S2VtsJYKByTzfp6zsTfeysKGOovHD/s8SXKoWZwewbSnIIVTfSr6rgBsZu4ooyq5rGL7V9XdgOaoRV93H3P3nx/UiyetDElKfT5/mSxSPDrxkbddeZEvf+Zf2RfNoHVqcetQKi2BWdIPWWqTIhvY5ghp1w5ZNxggc1Bau7bv9zMQAbxN2NMBibvhoMdkweY5yc6STHFbNSAnkIYviNR9c85gMy1KBseyoJzT3VOxbLMFJ/66Xe31V/GRHTqlyrpFiPVvfafE0PpDxkwwpSSjmkfNIaBbOsicfyHXSWV1EiB48rTdIc9wltASdYhrvd1cE8g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:49 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 03/12] hw/arm/aspeed_ast2600: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 03/12] hw/arm/aspeed_ast2600: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUt0k7GyQbC00CUBhE97SHkVg==
Date: Mon, 12 Oct 2026 06:44:49 +0000
Message-ID: <20261012064445.2571633-4-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 739ff9fc-d32e-4c9b-131f-08df282c4fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009221227099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 9S99hyfrgPGI5CKTOLwQWwiZaM2dBOfNBZv9nA2fUtnZ8vY73LtS4JVqXBbGgaaT5P1XCbZDgIIcUt0zwYP7WoUwAkGy9UlX8MRJWK9xqgU1xj83VU7SLo7FinzFa/EQHPulltyxFeIpVw8IT4x4Ox2FYKfVTrqgwSuRBnFOXtKAZE4gO+BxLrY1BoTEQ8vcchWeT6PxIEtPI9g7GJ3hEoceKe5YJ3h1LRTqrfWI+F0yxQuxKMndK7iRVefSpOkY9alsN5cNh+anhlqnk+t2nYzZrjgIyvcanBjKxwE+UlEJ/hBxnQ2YK3q6WMbiP0gvxChYVJ1tXC6hK4YNii4rhhXvo5BBLTowzrQ+bH3r/JnBHWsqPUP9dcfYFDA/JdlYRwUCOq0RgVib6W+nwyV8grTQTadV43i4eRPSv2kVQTfoty6kMkwDTmrsKWPJ2A40zvmZxdkVlCHv+u8/kMzVTkMicRvTXwbCVL+VpqQxlWhCf1oMwwOMicw4jBBk8rYl1RR8DXz5KUm03YQHhHVi8wOJ3Agg+H2KEjt9JI/3yCPqBhgRzbHLN+Ncusjq3ScKR4V2zMEqt2Z/NMS209IIXHMHGlQnNDQlDJCUCGrU/M2vb/rbHRwoRuiEgnacgMN7xiHKUhkHc2fgTroxoUAbTT+6wkhum8eMj0mT5xiGjiguSFvjESRg7KG5Nn9SBdCponaGQOcH649txw9pEypg4I6p5u3o1Ckju1TIBMqzbLjLE1Ro8SK8vwSrsahfJh0w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009221227099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hbAoNEQ3xk441EwI6T+7HIVl2OrF1pDkV+tgrQJ2tUE5uX3nepAr+hCnP5?=
 =?iso-8859-1?Q?wHL5hU6MU0b9Xcr3p6U3YwndR5+0z8jPYOJXyZaht4EFmBB3e5oNHzC0w5?=
 =?iso-8859-1?Q?69u1HgPMKtwxy6ttOYn12yAwT5gPkFWBgusagFZBUkEETE8u80GQmyqec1?=
 =?iso-8859-1?Q?IlQ6lE95A2LqKYfwR4zP46Kg89F/yF0RCSVTO7+LKVQdekBPisx1mYKcJQ?=
 =?iso-8859-1?Q?65QbF+j7vEjqS9031YrIvkLYPfpLIcdix0vO65Q2xeW1U4QWyGFjwv0UKf?=
 =?iso-8859-1?Q?/fKhmM3p4N+9ntGfRrzqgU223F9LJ6z/dukqCYpS3eACGwu27Zr4YmWuL0?=
 =?iso-8859-1?Q?X+HDfTUhzjhgAxTLlSe78TgdLVj8I6r0tL5ibH9/a2z4OfwVwpofKDaU01?=
 =?iso-8859-1?Q?0cSiJzZuJZfv94LMDTdBOEviX+niq7lGl1Ek7yJ6S7Dv3l4cLF3cVWRfn9?=
 =?iso-8859-1?Q?VgsWCGbA0VVaceDrmKDNBd7k0c9RVK9Ex62gOZqLkXZzUE4eL6C6xUagED?=
 =?iso-8859-1?Q?zcOFZWEJebNENW9kfgwBBzmBFfAgkjPci5cFXvLfiIOW/xKb4NcKkwFx7F?=
 =?iso-8859-1?Q?G7HCmPUcjB0uyqSTfmUat8ZuSz1yjbTemUKEO/hZDpXOzMfMzs59S3U2wI?=
 =?iso-8859-1?Q?6D25kHlZe5d+zteumfreIRV8rVDhjNWsFQ2Sl477AD4Q4f5fSuNM53ZA4d?=
 =?iso-8859-1?Q?IcfOYbVDr4FSa2xJXA94Zsvd1U9XW74l2xGdrG8QMU1h4axn2CWz/0NEOJ?=
 =?iso-8859-1?Q?vdUsbiwe16NlDpK+iMV3Cy7kPv3ObELJUENboDZwQTY9JTQxMnWRgcfLEb?=
 =?iso-8859-1?Q?+zY5X1uUkGqHu1jYBOLPE0DRtCeK+Qbk0hpx0GGSMGPL/z6bY3A9VDWuR/?=
 =?iso-8859-1?Q?4QApenCwzMG3x9NvDylZyfBRZPxeZ67MfRfx06nleEpTNKVJ1tTaKvf+KA?=
 =?iso-8859-1?Q?3TXJFymM8ofTw1tUdUyZRWrhXJcqF62ayeHq9v26cgUD/eRC8pMRDgWAIu?=
 =?iso-8859-1?Q?JBd+RsrpR1sN536VvW2zTHTD2CE+O4ke9MvWLmqH+PstoB1TbRLeKEYBGM?=
 =?iso-8859-1?Q?yVB0Voqbwug17RGppGCghwJjOm1AfhsZhnBO/pOBW+/bQ4BovQ54j/Eqtq?=
 =?iso-8859-1?Q?ihgxwur9WfvH5bbrkQKctrpyvz7ukO0CPuRDP9qgU5qF91uLVs/YqdJZG2?=
 =?iso-8859-1?Q?3smH69DGctCfZhBhg2CU2Of6YpYHH/s/b/3QVQaz+nOmvxGvDiBk9J1nWb?=
 =?iso-8859-1?Q?XwEV5HQAV4GBcXMfYgb7jspM9lBGwsD3zHiDdpeZ9LbjXOdlHa3Kv4yOlf?=
 =?iso-8859-1?Q?y+OpHsBMl2KGjX91C2MJpMJJHVUdcHTfXE7aGbZptXmcENTin0fOXjb0aS?=
 =?iso-8859-1?Q?TvJS3JksEjti7k3MaUliJTFACNTweZmDYDFMfrgSkxOfIXx+oGtbfQcKp5?=
 =?iso-8859-1?Q?a9Ni5GtVVacarAi6c9y9lvEuh3bFufWjmQlH82e1ekxefT3a0zMYQLa4Fg?=
 =?iso-8859-1?Q?TVda0x5fQRRXygAT/OUt7cDestYYFJMiiL/7RnOZC5sOxY1yfO8eu7+meB?=
 =?iso-8859-1?Q?qdmbOnOKsltBzAcn23/ib5Qq49oIHB76c2xJJr2uyEtfPBosDF470+8Zkg?=
 =?iso-8859-1?Q?53r7fzr9uMDBpK7a+FTFr1S3MLdSm/pCqc6/KJza38iuOlUFpYPvS6h7gq?=
 =?iso-8859-1?Q?Y22GAPzlGhWyhyLj8pGcTQllH6EDJz+B1Ci0ZXJO1++z3KuwkfBh1wyC46?=
 =?iso-8859-1?Q?Lz56mj/5I+lCy8v8oCGzQ6UgK5DaIUhhjbgGbjwAQFa8VVtvJ26aWJ2/3G?=
 =?iso-8859-1?Q?FPDJPDLtuw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XkhxTmUEsSV5eZzJEMmIoiDVKTWFiyslG80deELks+SD137RyR2dX0gnqtcFatMKMKHHJqSsCxOhpksd3Gz9yidOzcMBQ1tN1EUuoLqWVzxd5fDtyfpL9/8ap5+hd7+uKU0TgeOxhKPjEnX2qpCw8VP8IfQZOuGsTiBf9aA9yExzAZVArCkXq3dWEdLjcC2XQsJYU5o0Pd++RYxLypjGuF0brKSiuQITb35ijNrrsTlsmvE9SyAHwSH4BO5mdlnbv2WyKfuXxbMyzRtmnMxYA2xsjqvPopC6E9qME7gZmP/bMnfYLRTHsJPfPompzyvnyjDZ8Kn3IyDF20qMa0AoeA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739ff9fc-d32e-4c9b-131f-08df282c4fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:49.3089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKhJEWQ2Phief9ygQNApB0OC/NUW6FKr3Wc3feVUMm7gD6tkeHCyzVs6dugA4RNqvSlzdEFzIYF4ozdB79IYTLv613Ck1zKch71p95WD4Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the unimp_devs table in AspeedSoCClass to describe the=0A=
unimplemented devices, and use create_unimplemented_devices() to create=0A=
and map them. This makes the code easier to maintain and read. Convert=0A=
AST2600 to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast2600.c | 44 +++++++++++------------------------------=0A=
 1 file changed, 12 insertions(+), 32 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index 1a10d0fe1e..ebaf07d312 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -19,9 +19,6 @@=0A=
 #include "system/system.h"=0A=
 #include "target/arm/cpu-qom.h"=0A=
 =0A=
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000=0A=
-#define ASPEED_SOC_DPMCU_SIZE       0x00040000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI_BOOT]  =3D 0x00000000,=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x10000000,=0A=
@@ -149,6 +146,15 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_ACRY]      =3D 160,=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast2600_unimp_devs[] =3D=
 {=0A=
+    { "iomem", "aspeed.io", 0x1E600000, 0x00200000, -1000 },=0A=
+    { "video", "aspeed.video", 0x1E700000, 0x1000, -1000 },=0A=
+    { "dpmcu", "aspeed.dpmcu", 0x18000000, 0x00040000, -1000 },=0A=
+    { "emmc-boot-controller", "aspeed.emmc-boot-controller",=0A=
+      0x1E6F5000, 0x1000, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed2600SoCState *a =3D ASPEED2600_SOC(s);=0A=
@@ -282,13 +288,6 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);=
=0A=
 =0A=
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "dpmcu", &s->dpmcu, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "emmc-boot-controller",=0A=
-                            &s->emmc_boot_controller,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-=0A=
     for (i =3D 0; i < ASPEED_FSI_NUM; i++) {=0A=
         object_initialize_child(obj, "fsi[*]", &s->fsi[i], TYPE_ASPEED_APB=
2OPB);=0A=
     }=0A=
@@ -382,22 +381,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT]=
,=0A=
                                 &s->spi_boot_container);=0A=
 =0A=
-    /* IO space */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  ASPEED_SOC_IOMEM_SIZE);=0A=
-=0A=
-    /* Video engine stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),=0A=
-                                  "aspeed.video",=0A=
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);=
=0A=
-=0A=
-    /* eMMC Boot Controller stub */=0A=
-    aspeed_mmio_map_unimplemented(s->memory,=0A=
-                                  SYS_BUS_DEVICE(&s->emmc_boot_controller)=
,=0A=
-                                  "aspeed.emmc-boot-controller",=0A=
-                                  sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);=
=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 =0A=
     /* CPU */=0A=
     for (i =3D 0; i < sc->num_cpus; i++) {=0A=
@@ -469,12 +454,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
                                 &s->sram_container[1]);=0A=
 =0A=
-    /* DPMCU */=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-                                  "aspeed.dpmcu",=0A=
-                                  sc->memmap[ASPEED_DEV_DPMCU],=0A=
-                                  ASPEED_SOC_DPMCU_SIZE);=0A=
-=0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
         return;=0A=
@@ -838,6 +817,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, const void *data)=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART1;=0A=
     sc->irqmap       =3D aspeed_soc_ast2600_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2600_memmap;=0A=
+    sc->unimp_devs   =3D aspeed_soc_ast2600_unimp_devs;=0A=
     sc->num_cpus     =3D 2;=0A=
     sc->boot_from_emmc =3D aspeed_soc_ast2600_boot_from_emmc;=0A=
 }=0A=
-- =0A=
2.53.0=0A=

