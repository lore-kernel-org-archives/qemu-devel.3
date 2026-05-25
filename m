Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AFECD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNuN-0001wI-JA; Mon, 25 May 2026 01:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNuB-0001uU-D8; Mon, 25 May 2026 01:31:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu9-0003BP-F1; Mon, 25 May 2026 01:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epPR1HjDOOY87spf893uYujIzwfabYQvTZoxOJy0Z0NEiOg2tJnBqS1WXKmFjMHMItmyZuH3uqvciMFNSCflhS+JxmAML9XwiCAUHQc/l2wC/bT4l5VP7WUESynsa1Rct+09EKOj1aLJVF/RNc4ZjBp+7kHn8Vql7mMZSPM+SK2VI43fiJIrOBDGksNPbKX4QA4dHOz6F4M9f1A2m2ji1n7Mg9+KpI0WqkoV3bN/tqDbolMoPHInuE3OhMfxtZWKvGwkHcIJpJny7JS+KXTkxXnZDBgBzeUbja9jr4nD39MvhomJIed/xEZqAFhFPray6Pg4kLqmIhblTHLXv8QN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGRea8zpVAzrv9E//ZtjkKDWTKjp4qVgQik8z+zXfkc=;
 b=PJXJcMUjBaqNWyMlZgN6+pRaVLYLzjDsIygtVaz/GEqyJRG3I3TQIjHTduIG8lmQsDuChlb1qv51y4vLbK1jtcqln93QCdP9ZftrIGC7ABzCEr8lfItF9EbIufrMJEYGouhmvC4y5VYUIEb0e494qGOtzYjhIX+VevksFAVbZgX0Pg6YIVzpn9+UBHTAuXF9BufY/UQll4lcCQxoNXM2TG2dnQ5ct8vAUrj4TXiwJ3uOsCWL4hFRQqQH7gjM7EVg4eyyk6T/7K8QGuYoWQIIULmNxC6dHjAwUGerkjIrZJ+4xCff6xWvKJrmE+vLBheXt+rrJ39YADWB8M1Tvze9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGRea8zpVAzrv9E//ZtjkKDWTKjp4qVgQik8z+zXfkc=;
 b=MqUIqwMP7MeDN0HjMJ6ybdqwxXCYOL55wd9ss04w9V1z23tjV9geN1MNhwTXmQZh8UMH9U55+DBBeievOmTt/CykJE62m3hrAfRn5wKT8HDtRRuadV6+lE0YDrVVlWaOssYR2rUc1lQwfwwkPNME2BTMPMW1a2dxcIr3Pd/3+7FyMIm7WW9QaRmuRvrZlNgrph4px8RBEXfLwXmc5L3tTWOydn+BT76Tit28jWHzBz3rKF0LgQJz+BRtW7+zQMbMGA2hQFRXeZ1OKgoMsLfs/qhCnybHayUCDnUWW5H376OVysNWMTcoVSLzezMPdNdc+RrkW9UieZFnoIC4pzt0qA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/9] hw/arm/aspeed: Convert SRAM MemoryRegion to array type
Thread-Topic: [PATCH v2 1/9] hw/arm/aspeed: Convert SRAM MemoryRegion to array
 type
Thread-Index: AQHc7AefNLeYbW/z7kWx1H1070s6FA==
Date: Mon, 25 May 2026 05:30:39 +0000
Message-ID: <20260525053036.3305181-2-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: 803d9e72-ee2b-485c-4217-08deba1ec27d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020|6133799003;
x-microsoft-antispam-message-info: Rw9Sv/6tElO9g9C8GSvzg/eTqQ4qOTKEbrwV0o3xflfL2OUjg4rj/wHnDfacP8O65FmKoQ8p0AlDZabMMQbctDZU5U5sFs0NBYlwzXDt8H3Bm4E8YTuegkbIhdWFxDY2R6zpnloQ8krC3Aj4fItKB0fcKKilplAdWMqra2wgCqYZHvJgFjAEv4m1pf/d+7sU2QHNTZZ9Yryxz8lmyNUFWIoZDwlhXbpBuzrSX/njX8n8XT6OY/Y4y2mk4pdO8xbeep4RteSRJPN765ZUzGIlZz7zBFOv5Av/SV+alJPpbwyaObQX2sHigHID2PzjhURyfZX0fiutNxj5KfHjgo957bZ1zbRoJMSqQYwIORIwrr7zGw3obqATfGjNwphsJT5rNAKB33/75oJo69ZPVVxEZJgD9mvMZO8vg825gPdY4QU82jd72+FqekPcwsaq8pfcB2M3382vkYqvdhowhUwTifnktXaIUR0dIaZuBn8BTHuWVQ+m2cxgpsi0lPOzNxN0Xjn9DGOmeBEGpvji/t1iGn0amItRjKM8x4hvOJ0xEDbWnh042fNNmXB05I8EDNjMTtrWegJ1ExO04eRBceClgfBY1gP3RimFf2y0oSj1quA87Pq9hhSAtkphrHZsTVg2jDfkAU70cWifVi8WAkyscS2P7svJPUp65ehvDsLUtRpYonKZXkzjgjyb5IyV9LbnsKuxYifTdQHI/RKxoYYHizq6OEaKgsSJlMUMo+V4J618RntqDOmCDV044z3g8H+MYMgVwyLixzcARgfhUiFoVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G8xrbV+ZKYbeJaTbPh8zXKzNatvJgmqWh5G6Xn+X+YJbWmhEwkE96DuVoA?=
 =?iso-8859-1?Q?evbGfLf8sivgOd5YshlbakR+l2J7VP9CAzpfsBJSKd9EQAbAZuDrDdB3dw?=
 =?iso-8859-1?Q?p/nAQOggl+IlCicXOcjqz22b/B1uZ8vf+h+n/odi7nSKuUDIfczLuzAU2R?=
 =?iso-8859-1?Q?ftleqQiYERE+Kx4xEnoLvrQOnHqZ3EboCkcskFpdJk/jTUcRHkCgW9EaCr?=
 =?iso-8859-1?Q?tBZ8LLRPM1w1NCVXc2t+i5ZCb64xLg8nhsquAbixDE15BZlKXhfFKZTIEG?=
 =?iso-8859-1?Q?jCRW29o6dKeMbPyWTfBWJ6Pgeb8N7cxB22l9GRK13sVP2f9dKixuRumggZ?=
 =?iso-8859-1?Q?QW3xbaCPjcsTPS8E9mr1yEKYkyAD2LpnxI++dhBwlYY1nonrGnPii7hPj6?=
 =?iso-8859-1?Q?TQh0dMES6D1kwOs6C8dOUs1I5PrqOETEFE3ro3BRF3bSI2Gpho0YhyGjhT?=
 =?iso-8859-1?Q?gbtVJK1NQ1M7zqNLZXjKSL8xsmjFEwJLpP4LzrHCEW7ugVunkEnC30VEA4?=
 =?iso-8859-1?Q?EgMgvLkvBiymR13G/1pXvKtraKTYWAhMWvQNfFk4Z5cn0cTIxnHGKTZA8+?=
 =?iso-8859-1?Q?NBQ36UumHtQYDADWTc1GqovYLExfK0F5ghiKFHtHeH14FMi5HEWjOSTVhG?=
 =?iso-8859-1?Q?scH7F85t1CRzMgVEVh6pLnLS0Or916MWWNG3JjiO219TqC2RK650FoxKxI?=
 =?iso-8859-1?Q?XS0fRPjZZt9THIhiAiHUCRi5XKHp/cbvNjozQFV+0X1nwJxKKBzoNN334v?=
 =?iso-8859-1?Q?9Rf1Q4BD+/qgkyQSiTVGWnir+AGEDllROG1kJsIsbvVdmBc3ZtepOO3DzM?=
 =?iso-8859-1?Q?+QLAM2+4VKqar6lRtPlKgN/NuH9RgLApWWOqDfQudUsxWawoOTe0bk90fG?=
 =?iso-8859-1?Q?iliB1c5cF2pce2E2ZX3cW/t6wJOWY0kR7UsP6LHhpfDPlfFpv7iYp3Anm4?=
 =?iso-8859-1?Q?UT+An0vemXteGb1W47r2NsV00qJViLeSv+E5NWFWBvbmaxh3Pl1FjZXMZW?=
 =?iso-8859-1?Q?h1KpqUgd0CH2lfAR88n5ogVP2Shyqm4EbsJ1wUTVuJcopFk2PFZoXsjPS0?=
 =?iso-8859-1?Q?xgKaNmy/8gO0MovC2Ex/HpssfP0uvNeGlgdNdZ9/ss9CJUwEFIWnG08/2i?=
 =?iso-8859-1?Q?AuY8k3n236ueBHLaRWXk01YxuuFxGFMqiwd+HUzlOL9bW3C98vTdZHsjGM?=
 =?iso-8859-1?Q?WxWqX8gWjsaFmaAYAKf6DAJEG/DTM074M7SOM0Bk+RZTXv/zE02LHHpbIn?=
 =?iso-8859-1?Q?ZbHiJymu0U3jYrr12RuPp1MALFsbO3mGzXjtm9gkaauTBIRFxQCknlgBoD?=
 =?iso-8859-1?Q?MyfuGQ2SLH19rJaPvYhFZTHfWHRnxl/9Tgkc1S7RuHkA+OfCJMK1GD+kZM?=
 =?iso-8859-1?Q?hjUzRRmEt4SptHEiq48/nftR9XrH5He0IE14zS5Jq+Lt0E4G2AiVjLqUXK?=
 =?iso-8859-1?Q?/YL1mIvsKtyHo3k2yHYyyBp1i6dV9XDhPvM6ULBtQeodNs15NoyfQ+t4+j?=
 =?iso-8859-1?Q?iEgL7T+4oNQ26vekBrCslBwIKn6WEdTay6b9Q7Y5N+Y6t+2vAasfmm/3DO?=
 =?iso-8859-1?Q?28Q9G4qYhnpB5XuWWN3FI40ES27GjQIikcAthaLM/cdKGzIOwpqvTmYeRF?=
 =?iso-8859-1?Q?KOGt0uhKvsUNTAAU8u/wfQK3cMp4j4RnUNT3ypQ5RrXZSbERsC3cp9hgtE?=
 =?iso-8859-1?Q?XABYpPKtE8dkgz8YxCmwhJX+zsKtPDNP4U6Ho0GMyMEMFoo7NX5+XJONjc?=
 =?iso-8859-1?Q?DMNp1PAE6NXM+kz61FEqGdHzzU1bA9JEQqvtaltyWXje4Dli6C/6+BYxvi?=
 =?iso-8859-1?Q?6PiTu5/Jaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PEc634xlBmR5+8Vm2Vfi/QsKxW+Hj90GcC8ikjl3E7Tb1CP9lGyQpQWblaNGNPzYuV/AeF4KWakHQN9nuqtCl/0KJbhHi3iCLj0JB+oFRQUe+uGxxST78tMyuQ0Nnzr71uHQQMjldQGy/zxqdzS+e5QYUgG76tA2JP3TK7/cWF4xQqAE04InfobvR1D2iICUV6yptLLJcp9+6ZW7CR1gJPldCFyis40nPMwey6a8VWPLSqalMHX8C/forIVb/wWH4ccbcH7oWonVTZav6sm3b15fuKElAplc1d9CnVcBHWBmmrBGubYvhOh4U1yHfwo/d97V3DLMutws0hALS1Cx9w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803d9e72-ee2b-485c-4217-08deba1ec27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:39.6977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brpHDYr4yUHCfkB/H/D3/yunk9iYk63qhNIJxzGrjGUmw/2NK3Rc8wsQku8nlmqYlZ/2QBK3RlsAvCqAgHJpybkuaSr5pGvWJOr82FSJtBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
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

Several kinds of RAM are supported across Aspeed SoCs, including=0A=
SRAM, SDRAM, HyperRAM, secure SRAM, and generic SRAM. In addition,=0A=
different SoCs may expose multiple SRAM regions at different MMIO=0A=
addresses.=0A=
=0A=
The current implementation models SRAM with a single MemoryRegion=0A=
instance, which makes future expansion cumbersome when additional=0A=
SRAM types or regions are introduced.=0A=
=0A=
Prepare for future SoC designs by converting the SRAM MemoryRegion=0A=
from a single object into an array-based structure. This change=0A=
introduces ASPEED_SRAM_NUM and converts existing SRAM users to=0A=
reference sram[0].=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 3 ++-=0A=
 hw/arm/aspeed_ast10x0.c     | 5 +++--=0A=
 hw/arm/aspeed_ast2400.c     | 6 +++---=0A=
 hw/arm/aspeed_ast2600.c     | 6 +++---=0A=
 hw/arm/aspeed_ast27x0.c     | 4 ++--=0A=
 5 files changed, 13 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index d7b3647ca1..e6942b2936 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -60,6 +60,7 @@=0A=
 #define ASPEED_PCIE_NUM  3=0A=
 #define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
+#define ASPEED_SRAM_NUM 1=0A=
 =0A=
 struct AspeedSoCState {=0A=
     DeviceState parent;=0A=
@@ -67,7 +68,7 @@ struct AspeedSoCState {=0A=
     MemoryRegion *memory;=0A=
     MemoryRegion *dram_mr;=0A=
     MemoryRegion dram_container;=0A=
-    MemoryRegion sram;=0A=
+    MemoryRegion sram[ASPEED_SRAM_NUM];=0A=
     MemoryRegion spi_boot_container;=0A=
     MemoryRegion spi_boot;=0A=
     MemoryRegion vbootrom;=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 41a4e82c1f..3e478f7520 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -240,14 +240,15 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCS=
tate *a, Error **errp)=0A=
     /* Internal SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d",=0A=
                                 CPU(a->armv7m.cpu)->cpu_index);=0A=
-    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, =
&err);=0A=
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name, sc->sram_siz=
e,=0A=
+                           &err);=0A=
     if (err !=3D NULL) {=0A=
         error_propagate(errp, err);=0A=
         return false;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
                                 sc->memmap[ASPEED_DEV_SRAM],=0A=
-                                &s->sram);=0A=
+                                &s->sram[0]);=0A=
     memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",=0A=
                            sc->secsram_size, &err);=0A=
     if (err !=3D NULL) {=0A=
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c=0A=
index b1b826b7e0..d79aa832f3 100644=0A=
--- a/hw/arm/aspeed_ast2400.c=0A=
+++ b/hw/arm/aspeed_ast2400.c=0A=
@@ -281,12 +281,12 @@ static void aspeed_ast2400_soc_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_i=
ndex);=0A=
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_s=
ize,=0A=
-                                errp)) {=0A=
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
+                                sc->sram_size, errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);=0A=
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index efb1d8c063..a69103de89 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -437,12 +437,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_i=
ndex);=0A=
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_s=
ize,=0A=
-                                errp)) {=0A=
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
+                                sc->sram_size, errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);=0A=
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
 =0A=
     /* DPMCU */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..0fb5e4b24c 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -778,12 +778,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* SRAM */=0A=
     name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index)=
;=0A=
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size,=
=0A=
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name, sc->sram_siz=
e,=0A=
                                 errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);=0A=
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);=
=0A=
 =0A=
     /* VBOOTROM */=0A=
     if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), "aspeed.vbootrom"=
,=0A=
-- =0A=
2.43.0=0A=

