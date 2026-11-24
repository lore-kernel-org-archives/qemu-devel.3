Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FD606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=U+Dsoauo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVB-0003wF-88; Tue, 24 Nov 2026 00:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUu-0003tV-Vv; Tue, 24 Nov 2026 00:55:21 -0500
Received: from mail-japaneastazon11022078.outbound.protection.outlook.com
 ([52.101.126.78] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUt-0001zm-5j; Tue, 24 Nov 2026 00:55:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLFVlruE/avslJJ6T0ITT10+N8C2+8EmUIlsY4m/vZdpOe+y8ml6oYEf7wpVSHq3XgkRoxTGGE1AQqbF+DyR51cmnxxvmfH42+73+EpXpXR4mL7F+N7m9X47bt+dIF0pKa1CeUWrvPmLudFLM4JLJFDWk3mbyDMLUuOkDxEEDHdflSKKOtS82zo9K45vmSmLwvI6PSqqcOns+dJoYdF8aGoHhn6pCdHJXxYiPXqXdI5stfoJwXfJgvnc14x4HcQfnHsyYpSyKGBZCoKfC5mH6wZu/tEbE+SXpokHR6MAafObj4qeQFb+c1hyiRrki+UbrP2NFcq9ILuSY0lC2C0FMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrbzBAJhfL/secX3d09BajtsL6h9qmzKL98azMu9qLs=;
 b=Bx7XkrZT4pDwfFvOQ+qvrEyOPRm+QJzpFf4oTwxuFz/0OKsWo+JNGgqFJYMJcDSdjW9KBo7ESUx6FyLcaxez5uFakT7jryXtDZbvI3ry9Di+tsS0SfYh2soy11pOj80juiviaUUtp4+jDUiVT1Q24kA7PCUeNLX8gaRNpNzzdZI8/CHOrn5lw64vunCOydRg6lc1OyhHDG8jrNGnb5pNf2/ND9OEsJM+HFIEnweCkKYOH/bhatA2L3Cktp8ceF/6/wQVIfAFtFblNANz9MN1lXehLOzDOpb4LchDA+Fp3CeYSAuHQ35QHq1+8uTJbkF3RVL6hr3TNw+7AjGTfv0+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrbzBAJhfL/secX3d09BajtsL6h9qmzKL98azMu9qLs=;
 b=U+DsoauoLv247k9iw0/QVdBoJi3//hAbciiWnCEjZiS+M/4O3CSXe32r5IvM2h7aPDIsrvU9fNDTgNrIVbgxFKYiB1EG5Waaj1/iCrm5cMcGi+9MLzwq33srTcbSh5MYdrhwjZggOeGsg8r5G/QyWiQfWv2aNbz8WHZem6h9O2vikCIbWQ4fJwtkoy41ymJ+17QysEENF2ZWcQkcAUm94ZocIOqsCPgwHck2zdL0B1z1xs4qkplpAg/4Qq6FJvOUpkOFwcxl4hOTWto0CEhId29FE7Rn6wFSrbOnVy6gmenIjYZbZx4pm481jWLMly2Z4ErRn9jaTPTVTem2ZTXTnA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB7038.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:52:01 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:52:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 09/11] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Thread-Topic: [PATCH v7 09/11] hw/misc/aspeed_scu: Add SCU support for TSP
 SDRAM remap
Thread-Index: AQHde9fsw6831mS5CUaStas7cSq8ow==
Date: Tue, 24 Nov 2026 05:52:01 +0000
Message-ID: <20261124055150.1328856-10-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB7038:EE_
x-ms-publictraffictype: Email
client-request-id: 140b9387-033a-43dc-9ed4-e30a37ebeee0
request-id: 8a4c307e-0279-4f01-0f3c-08df49ef0f44
x-ms-office365-filtering-correlation-id: 8a4c307e-0279-4f01-0f3c-08df49ef0f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|261102123227099003|10067099003|56012099006|261022075727099003|261009221727099003|261009223027099003|261009221227099003|261009223327099003|261009220027099003|261026121527099003|261021121427099003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: USEVOtEXgXFhHETOaH8hGOQ0wfvpil4faJsICaNZh6+Wxh8M6+FvOK8ugrD3h21/9hi5afo70HGP2opluhjJGMLPOULdUu20crMCONUsC2rZGwZ3Wphz3qxhVLPFxnU5ZNdwX7axvkGiJHjV4CSDScJeHvJObWDRt9vZc87W5jsbGcRzMGZD/lnGywMjcfVc1SoQi1yUcv+m1OZnJJ0JYvlGAlXKaz/sJUSQFE97YJDYpjLjJPVjhG8RYv6ZUtlLDmMy4ZJZ1+WuOuk9WY+WkHo42fMReKOVsp/WCX1XvcsWouID9U86xyMYYAVitB1fBNOxBaR/O1Bhw61UJcJG0/OHhfoU35ol0P/xXXvFusUdnrIHy6v86H1dKKhGfelDnESKSgEEWb2Pbfpnsmd+IQehk9yoOejKfhbRzCoEmUAlKR9e26gDplEuvlFXD60nAwMs2T1f9FSZ0A3avrG2NkuDWEwmsW2tFCtvOkDTfvbhoQDsn9f5+Rqd8VNQCGqUpB8f+iec/bZXignaKjY2lrn/UZF5KVPB9b0WvUYnDezX28OX2yh6qnFO4BnhAAoDgscV69xfB0HCZccbOVB15uKS1xeUU2OIOT2DKbCl0IdxTg2vT8TdrRkv4o3DXze9ybARdW5fXUvJsNQoLgs+bT0s+XOZJvEy6UmoeTYFxMeSwNUuGn115yniSD28US6Eww9qzK/wimi8Li9aM5jyDs11JCxSJjky6VGecIjmBRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(261102123227099003)(10067099003)(56012099006)(261022075727099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261026121527099003)(261021121427099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RWZD95Bz5RGNHVPsZpPJLh/nCYZh74+L8T+SKi4Q3vHWjuDly6kicCUVTL?=
 =?iso-8859-1?Q?0DQZkQiEk32hvTUGU6sToTG9kkatcwYXUOTmP9UCHJaFEYQ/kk36j2SbYa?=
 =?iso-8859-1?Q?0YEcnETF1FXDIlN2aCTkNoYQ5Byj0InUSrHmTqMQDy0pRorTB9vYWXVqzE?=
 =?iso-8859-1?Q?NrsMIFo+xgmwTB11YtkqoN4Yga1uJ1kyeIkfyqe/9JOY9QoSSbMaYgsXpr?=
 =?iso-8859-1?Q?j/ArEcQIh1Ma1FzLGOw/3A/8O1+Dzdoh6k60CJQlqI0OckXuxYvd76et0r?=
 =?iso-8859-1?Q?dKzCuHLhJx+RIjN7okyH0dHAXe+H8JHbpqD77c9Xl+enehHWIt+8Ke8hcf?=
 =?iso-8859-1?Q?nPxQ2FZ3FjfnAgczC/Gg6JWz9O1bUpZzNd/srLfV8GrMDKVGqiBuVIPmoY?=
 =?iso-8859-1?Q?HEb9eWcvuzDPsRGDiUbIlBTA7pzO/uEghxauZ0sr0Hs8uB9IpC9PdIoAO3?=
 =?iso-8859-1?Q?ZmeRbm0oo3XO9geKSa8DkkpyTMvl9CSAQsnTCwVCAYQ1rpW3i9jtiFFsVy?=
 =?iso-8859-1?Q?mKiUh6c+ScCfnF3qkiPPcQLMwkpqn8SUn8Y+O653EPsZXYI/1cMyLIsCc1?=
 =?iso-8859-1?Q?87y55d2zvGUTj9q83sAWYW9S827nVcW3kWa1HiJkpg9umHHAe1+jVqFlXj?=
 =?iso-8859-1?Q?jjNmArJQ6I9uTXAOOhxPhEuA15Qb8FnJW3/m6P2qU056WYc0TaWmr6PXcl?=
 =?iso-8859-1?Q?/OZDtf9wlP7yuFnqyG9EnjGSGSnVreUsZ3feUjoTm10xvO/7KqDTJEo7sF?=
 =?iso-8859-1?Q?65t04YzEf6p+1nIxt+kUWQHuGK+h6Y0HX7NGzW6znZw0GbfJDtoh9qWET4?=
 =?iso-8859-1?Q?+JHTqZJ9XtHelUbRnso3dXGz7kZ43H9yOfMgBahSO/Ugk0Z21R9AnBuoPa?=
 =?iso-8859-1?Q?iXjEN6C/PkeCKIfbPLczVHtkg8bqsWc3Rk3oGVbH3nlsHOGtb/915Ck5Ms?=
 =?iso-8859-1?Q?Pr5xC7Zum07HFdq3idGRa/RzfVpQ0g3R1o/HmLHuelEH8KNY5edSTRDBFV?=
 =?iso-8859-1?Q?1REqegV/Spy30nWhRWBxR2JW1C8p2RZCT8mlcXNovjiW1EHD1e7hJnNltk?=
 =?iso-8859-1?Q?JG8mKHIEjYYzRGxHEhx/bvOl2hXS95UWYEy2GGM6Y626mrcmgFKKlKdsXg?=
 =?iso-8859-1?Q?aGD7WmwZ5d1qhhgkwQNVUbdTOge13jCyNXscK81rJuWpOW9IyUfU4F0eGC?=
 =?iso-8859-1?Q?n1Y0HIrfii730FxNLR0SIX2QsEFZsuziQVCuQxcAI7pwNn9RLWhOuszpWp?=
 =?iso-8859-1?Q?1DIP0IwR95gOYo+YukCJBj1e7UTwO4jQZNOPuax2gKIviK38+QyFMTVsGm?=
 =?iso-8859-1?Q?rwRu3cVmI6XUILPc3CnBCykN/tbF3r+pG2tTAnxATCjyWeyNTxhZVU02BG?=
 =?iso-8859-1?Q?NwqrR8R2074dDMuKd1cewRZI3CTchkRqaemfNl1zoc45PIAqXp61Vewuqt?=
 =?iso-8859-1?Q?KaEHBiXjefrTfe6ecEpBXZlRpgiE4sUX+bq4FnxhyUg6MHl1/rNRI90nm1?=
 =?iso-8859-1?Q?9E7knc45ezTPS+PjGqjc5UQ2f0S8pEJ3lzh1zwO5zR7yDyPjj8KYCMavXA?=
 =?iso-8859-1?Q?NbHfoJWryU85Qrmlf0mlB/5v3XC3q6rQAP5QhPaFBp4R9BkUrRhTmtIzGh?=
 =?iso-8859-1?Q?Dj1wN9H1KrgNISOo/+g5UlCQkLIWYZeDTZs1hdYxB7UxqaR3KNAoNSyrFg?=
 =?iso-8859-1?Q?Qhe/yDFbiKlq97DOlrOBDEqlj6SR3/hixbUDus74QuVMrv4rIoxZvnvgIS?=
 =?iso-8859-1?Q?dADzKxB4iZfk5FeZs9mAdtDnNIcH9zAqdgRTioorD6Kb/Ua61F1J0P+pR6?=
 =?iso-8859-1?Q?8+mx/Wup8g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c307e-0279-4f01-0f3c-08df49ef0f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:52:01.2011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUzTDfy6OB1E18lU13tRs0IORYbpT9W4wlQsUxD2grztyj3r8IDwQaslZKjT35sMTPMbSoNKlMClDn2wxzAqKpsgjACjYzz5zZ2E6xJplh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7038
Received-SPF: pass client-ip=52.101.126.78;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds SCU register support for TSP SDRAM remap control and runti=
me=0A=
activation. Unlike SSP, the TSP does not support configurable target addres=
s remapping=0A=
through SCU registers. It only supports setting the PSP DRAM base and size,=
 which=0A=
are then aliased into the TSP-visible SDRAM window.=0A=
=0A=
coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) t=
o TSP SDRAM=0A=
      offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_TSP_CTRL_1 and=0A=
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base=
 (alias offset)=0A=
and mapping size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        TSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000         =
       |=0A=
|   remap base                             |------>  |  - fixed target addr=
       |=0A=
|   size: 32MB    (SCU_194)                |         |                     =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 32 ++++++++++++++++++++++++++++++++=0A=
 1 file changed, 32 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index a9c5c9bacd..9becf308d0 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "qemu/units.h"=0A=
 #include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
@@ -164,6 +165,8 @@=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)=0A=
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
@@ -1028,6 +1031,27 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         memory_region_set_size(mr, data);=0A=
         memory_region_transaction_commit();=0A=
         break;=0A=
+    case AST2700_SCU_TSP_CTRL_1:=0A=
+        mr =3D a->tsp_remap;=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_TSP_REMAP_SIZE_2:=0A=
+        mr =3D a->tsp_remap;=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_size(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1107,6 +1131,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
     [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_1]        =3D 0x42E00000,=0A=
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
@@ -1152,6 +1178,12 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->tsp_cpuid >=3D 0) {=0A=
         arm_set_cpu_off(a->tsp_cpuid);=0A=
+        if (a->tsp_remap) {=0A=
+            memory_region_transaction_begin();=0A=
+            memory_region_set_alias_offset(a->tsp_remap, 0x2e000000);=0A=
+            memory_region_set_size(a->tsp_remap, 32 * MiB);=0A=
+            memory_region_transaction_commit();=0A=
+        }=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=

