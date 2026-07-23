Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF3C4453D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj63-0005Gy-OZ; Wed, 22 Jul 2026 22:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5g-00055d-EQ; Wed, 22 Jul 2026 22:23:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5e-0002ZN-O0; Wed, 22 Jul 2026 22:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGG53X6F5MfYDTEp7OWqXRQYExqwwlPYX6mwhd/NvL+/bZDSc0/NbAM5fi9l+nNYJnhbbk/eOSfynS7kNhbxPHwragncADK8zPmIFiPwN2Fm0lmyo6TdoafK7xcfYwq9E65vUSsflNAvisCi4T19Yy1GMslMOS4hJ95L+h0A7x9CP1DC+xNGoK03VVCEvQFdLqsCoNshO9N9nhdtiFjhTW9j6O5VoFEESr3vJbpMRQF9JBOV3CmzDAfPcF/qZ9um/q3JxRrdqao4ORBiYxKojDLWLgb95Vgg2D1gEqyqTPB60S9Mdxy11Iyox6dp+7tcNNr0Ib2EEEwlbwEFKYrFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfQiUQ7MirJ/eXxQUKFqsP+hRwXttRle4J87NMHziYw=;
 b=JyNjTf5r+QelgR0Xsw4QIWe2a0A3MggFh/PMOxMw3WbwZhS+JBMiyQIMtoaUTLj3iJxOutfYaWHoDV2AHF5tskMOIEg+QGGwjY21i0wUXN61DhwNIQ9DvQE9drmKnezdqoN71AEosZfld6tU4pGCp/keHyzIgeJTqJSSxZoR9TkQYIBV2ffe3LHO+0zfVF1MOBzgElNDcfK/lzWewLBeMaJyTFjQYuHv+rI3njeIk05dX1mhkfZ2SBbWdTpDZ/oqMuKTCYSmp0W27FRkNTatybj9EOkvU/BMJppRYaDIzAzEDBF3MraX2fESG7HPpbxrAxdnKOSB/P9HbWctfR3OyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfQiUQ7MirJ/eXxQUKFqsP+hRwXttRle4J87NMHziYw=;
 b=Nt8jAsOfBdFR7xGReUCHCEHExQnw+Ar+jldxxZzlZGwDy8kGT1Br9BgytlNgVKG1J9/LinKFvPBmdeMhFKDDxd6eUTphThfmmymI0GmnveM59urvjeEkXJ9gSC5DoYCwVO3NVbbp5X6Yw0tCqqdhvApXRTZ0pn6TI2Ywm6AfS9kxFCfR9R9WP/AzOthEw4xzJw01nqCjro8DdBG/du1HALfxFud4O7Ncm+AbYJsYVGRs5kh/J73fcvyg2xjty9lnQKrsSd9jPM/lAioR2ACwhti9q0lYKxd3FBXrkiORonG8oT9e0txKFxZqRy+0XWynpp0N27ssdaWx1MBVZLX3Zw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 02/11] hw/arm/ast27x0: Start SSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v6 02/11] hw/arm/ast27x0: Start SSP in powered-off state
 to match hardware behavior
Thread-Index: AQHdGkowOEb1PX8pQkCQAhnPdoohWQ==
Date: Thu, 23 Jul 2026 02:23:03 +0000
Message-ID: <20260723022300.4174471-3-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 6cd07884-3b50-4190-facc-08dee861533c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|921020|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Y0NCybDecO7dtfOZdEBVTN7SPHFApLbsIBvMPpwJ3uYj5VVJmDue0zBJyl8P4Iz31SeEVDWFh6YEtmuT13jvj14elSXscSHO+7GketDdJcEq+NrtDTQG8n8Y0oVFwTO5hY1j63qeB81PGRoFYDcRGyw+NO2SxN4TINzIZWm+59EGla79+Emx0nXnFQGvOW6rS2/+nPGedi1Nzr55k25h6i2qg3FZaWvh/K5yIB2va2m1mOVY/w598OmTtRvXCXx9W9zDudeJSw+frABFCnVEgaWavJO6KCH9ZN5zOKYuNe/7yMzzBnhkkiIw272pRkVLEnFQlcqX9JXp0evwnyvgXJ4Wd6dfDIjuPo7y904nd8iHcarbRp6LmQHmDBS+Xqlv+CwOT32XlCZcLTDMP0d1yq98fdBGOme4/o35f3/DvOdPFgy+FEk1L9BLDcR+xSf9nUQdBEYfdY6vMlZZigDgE65ckVYvMWsKBlBXQZFpLcN8B0DWPItrZ/PHpf6D3OgPTupmPhS8WADTd8UszMmYbwvTMImsaWvNM0zr2LR7HpVNEK1AND3S9jHcqCBD/OT64eW5tM23mEZoi75c88lx4V7pjE62a7y1NTPi3aV+P0xEOzmFHARNNawhoZi71Vwfbq76Ct7aZIJ+YwTmKksm7FsMzADasiCu1RscBld7Oy72Kjk1hw4EwOK5T0Ni0d+NzCpvD3XZoqYY7yXExjieX+lhwpi0Y8jmNIFCM/xtxjjot8HoaBv3tmWmD7uhYxf6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SjszjnD8PLKaWSF/M4FuAx1CYDhzSCsx2bRd7sHe3m3JBkjIL5QmxhuwYs?=
 =?iso-8859-1?Q?J1s5ZIKp9fVey4qcc1Tfv4VqlUWig3niBeJD1rHice7VD4jUN1tAKaEF+L?=
 =?iso-8859-1?Q?GD5ZLz9v1iiiBvNFFgSkeC9JptsL82nkb3TNhbh8IfhsBMMyu7SAmfdQtY?=
 =?iso-8859-1?Q?+vQCEJW3auza6rLZOij5ch5dEEK4iyqg49QakwOkr7/IcdnjQ1Nc93Z8l/?=
 =?iso-8859-1?Q?KZNhCWfVpXxa+1cOmc4TmV+aUSVkg8K6kd+ynHL6R6+NW7zt+BVrVjIQFZ?=
 =?iso-8859-1?Q?z0IxOEKfCpCNC7FP7bIMgUaHtAVcUNHy8QPBlay2nguu7iVmUm//AC6riV?=
 =?iso-8859-1?Q?GqqYTnVXcFF8yhrScDnNHRwGe7IVBzz26Tv56AcFvrA0+X0EOlVCwS2RsO?=
 =?iso-8859-1?Q?WsvI1xvMNSVZuk90a7/xx2m+bpRiXWuHrx1aPy9Y4gPG+QbtTeW8shibcV?=
 =?iso-8859-1?Q?V3lOQCJdTwaj1nzlK7+c1tXsVu4BTVZYUqJzndc5kLIUYh3OZR2Jp/EahJ?=
 =?iso-8859-1?Q?YI/Gamfaq9w2jN4Zjrwrhhp37eqiHRp8K7ka4tPe7mtDsyO/7D9fTfSF/O?=
 =?iso-8859-1?Q?qVoMgfSOxlzpBZr+nK93xBs1D6Iyk+vbeHvA7p+GZ9QCs6VN15ADelycuS?=
 =?iso-8859-1?Q?dX/B7ljcVrQ5eWGmhzXk8aZadqVYYht3ycYJymJ8eQmfDOCuJysEttLK8N?=
 =?iso-8859-1?Q?sFjRXNM2OIy4g4HNhNNwxhW2rVGEavt3a5bOnkuWAbzBZgTxW8qjpuAsLz?=
 =?iso-8859-1?Q?u1rbcl6gsJN8RZQsItitD1EgJU5V5TZZr0JgSg1vKTd1eHAgOxmB/ctcX3?=
 =?iso-8859-1?Q?y+k/Kd43SwVqpHLVS6vEMk4GZVdbspAXJNPbzbvf/0Bvj69XwqF/P/rBaJ?=
 =?iso-8859-1?Q?kyXLbMiyeMtFvKhJq0qr1sgapwSfFqGyIVWwBbuIWz33i6XCgRQVsRG50A?=
 =?iso-8859-1?Q?tS1XkypgU5EMCB63cXsrFfWOvQReav4g7dWcSyirc3IX0R+WPJKJQTSWh1?=
 =?iso-8859-1?Q?Ke5GZi85a92v0xTxwpby+QnkpipEfROuEJzBAk3ZwOLxjxz8jl+xQpJSS8?=
 =?iso-8859-1?Q?Lx9lxgXkxq4OxaC72mtLtUjK/5a78IK7bo8PRTKhT1nHWh/P1MMWMngqhR?=
 =?iso-8859-1?Q?TVR4UAjItea/gKH3Fswy6TRVVq6lyFifhHqmTZjdAPBVrIv/j+wmi/l/cN?=
 =?iso-8859-1?Q?8Y3aL0JV8N+HaNGNEWlugDHImbE4wV+GzhrGTkxfSZHWV0siCgjPJfsc3d?=
 =?iso-8859-1?Q?ii+Cim+Wf/ZHG5xT+A6QiOtRwCBXX9IktqvZcQ4Szja6swEMOXjge2I8e9?=
 =?iso-8859-1?Q?WUH8pHxuZyF6VnQjtkn/RLkklrsMtjH0Z1FTJlahH8aNAj/rNFCyd94cWO?=
 =?iso-8859-1?Q?oTPT2K/0vijDTidliP3KRPNiUdG/uU5dwA0g2TpiYpQ5qMITPzG4klmhUQ?=
 =?iso-8859-1?Q?Ro431l7qtHYnpRBKdGnPhuJQorQJVTMEOitGuCwcqYIbltpeTfB5VuDU2K?=
 =?iso-8859-1?Q?485atliWstvF6/tsDJpVRnVOHEin/j/DDO+BsIElYPWaV2fard4eMJatFv?=
 =?iso-8859-1?Q?bfY6KYh+VPmol29Q1mOwdHdgF1l0zlErh2VPK69K6xbNrroyTLMzPsspRj?=
 =?iso-8859-1?Q?k5cpQ6+odcXFHp4sn3XNr0QFch41ZEGGzDae68Cgb2uW8cCLFgkGwfgvPG?=
 =?iso-8859-1?Q?0CHyByNTGkab2FOW9lHH67Grpbz3hNSJNYUaFaXxN4Yct4MGxVWgK9Ru0I?=
 =?iso-8859-1?Q?B4EwdYij22ZYqXNfLOVeKyUbU7QThVbTe99erELFeeF6sqm766YUqEJNtp?=
 =?iso-8859-1?Q?sFr76jEy2w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CY2YxWn1yFD73jTyKxg6tKYncAitCOs2PVS/3EUklJgsRs/GK2XLZe2cnFmt/UXNLFPMWj3FbuR2eNODvgEnVOFxxBb0Zls7BJMT5/6CwZ0LoocldvcJdSO9K/S7KSFG1Bd8jwcF8hij913eivs1f1TVmmKrbpR6rv6lMHEq5az84U603FIBquOxlVxH6qAiCoBtc7YOm17mGz+5wP9oV/35gLwHIIykREbXPejza/HkXXQYXlF83LyTPJEaE0HKTJijN9nAn27U0gZvR27AM0zSOG2mswkpi8pmhS1nLCiXt7M4m1Ulr0lBScFJK/CevhHxD3g4nhzUKlKfeKIbJg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd07884-3b50-4190-facc-08dee861533c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:03.8658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOUuIXP4KuBpaTJASbpjubF24ioMhIplaVX7ojGJSFPfFWt3h33MfnDdL5mMXsV6P10ZreO2mg/Raa2dNigGiCvWlY/zS+AFtD5yYk00bAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

In the previous design, both the PSP and SSP were started together during=
=0A=
SoC initialization. However, on real hardware, the SSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the SSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the SSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the SSP's ARMv7M core. This change ensures=
=0A=
the SSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls SSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e03653086c..9c984d23cd 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -192,6 +192,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The SSP starts in a powered-down state and can be powered up=0A=
+     * by setting the SSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

