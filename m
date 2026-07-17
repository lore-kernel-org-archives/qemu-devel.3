Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FABC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDG-0000Z2-Dk; Fri, 17 Jul 2026 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDE-0000Xy-B9; Fri, 17 Jul 2026 04:46:28 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDC-0003vk-Co; Fri, 17 Jul 2026 04:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFH1H5XPIRde/wi/0E29Mxc1YCOlttnoQfY3DNsc0xr3D0iMqVJJU+wFeq007fxo5kBrjFkyCXhC4Ezd1dONa6fLre19EvpzD3ILqtzQFvYpPYW6ZVZUy1JPuSOnhQGU0JAyHa5cwlifnoCaNMa3JaglOvERQTUoUW2LSbzEIrS7qZx9tQGGNSVTGsb4XBsKg6a5PrIVlBTf6wJByG3lecTJM4rIyEBjvPVT3Xg9U6A38Ijnd/zNLP74GHNFkf1bxm6YkW+AENcOVih+DtIZXQoziYBy1DEmS0fuXTi7FvJEBQggSOUpExnrgBrr5ukdQaUVxerUWFS+4pbs7MRxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyKKYN90mdpRteDX8L33Wt65GBO4e91s/klb3HWPZXA=;
 b=cthBk7nM5jkW843DhY6Nn0N1VPZ2ksjfbDqpiuh1esemwSxSU6BZZQX8Cw0uvVusNUPHqFclh3gVZpSMq9iJY5fhcH3za/5oNpqXyXfAJu/SLl3dBtRyI5M0+vcZKjnmSjZTQAGU33KQP7EQod4kJn4WPP/DbUWOXM12mDGV1kuDtBnXuuXytcl51rYCcQKMfQHJYU/BMAzv8n8433mvHI/MnGGFnU0Uh5BmJjkyUEs4dZnJPAmqmSbt0ukqkVp9cRhXWShYPXkOS1J/vsLcjkw7FvNKdaV6203iDiY87pqjHloDXcwre2IdWIg2Nr6dB/iYf/CxFlE69Hv/ABhVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyKKYN90mdpRteDX8L33Wt65GBO4e91s/klb3HWPZXA=;
 b=p+V1VD1EBQsFMxcWogtt8GXCTJJGWYQ6Q6vWCpoeh+uVJCqKMwHAQMAKQzDjtZZ47pS+BavK/5SLCIVp2teQZc5uXH/SrzM3nTOF+tlWNbHGVn4vdT4jN5za1sF6R39v9Z+guABnDIGFzCL8Twr54hhtBL8lMUYMZWCnpcxcPik6nDBFG2jDaRmXxYUAfrekGK+f+z/mXuEcMq09yRBvcZDpIGUYgWaHAuLx2Tu67Xck67R2NO8FmGXz+cA8uFnAI41sNxB4AQJ3paxnLoFPxX+hB8uoVHkTLR+XYchwQqF/CPnmafJ05lX2mJsVheqEPlQtFI92zPFkoKY+eGCg0Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 7/9] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Thread-Topic: [PATCH v4 7/9] hw/arm/ast27x0: Share FMC controller with SSP and
 TSP
Thread-Index: AQHdFci2KA6mWk3eukCzHQZV5WFyvQ==
Date: Fri, 17 Jul 2026 08:46:09 +0000
Message-ID: <20260717084559.3477061-8-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: 81d46050-c801-491c-8df3-08dee3dfd974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: zXPrzqKIFtC3GR8e79S9IPHOonpkdPRY0RuC1h5dqMD/HuYMrws9iZGzvLos+IlnqRMvVdAT774GA7bL2z6MWOGdVg0wbxDgdQ9LWKjS2goVJspAm6k0r2xFPOUFBdinYK1NnalWsdDIQKm7TwRDkmQWGfsZB0qYYegnNLqKG6SV8oNKWVGnAmYEicJrpDgPgVpwmQpRJMYmhUOYvNQmypgQznQAHNP8dBHBJQL45nF3lpE3+so1TWLUZ5C4Ao5Rp24opIzE7o1YpsVuAgWASQf60uZaChAS3DFBIlNWKel6nYz/mLVLFRN96VeUHkbliIMEprA4bpiz2SdAfMHIRKYcb+rjbTgff5dJsCTgj7DZhL0Ts4bmDFHZR4+wkefFBsbRH6sNBbxb6eF/m9dHgDtPv81Qfkd/cSSb58u3jRjIuC42LK8LHgCpXwN1qWMrPPu23k65sLi27ddxbun7icLnrqGpXIp0+wsWL4UgpqGIZy/WluJ2yFscjhJIkw6xStI+uqyFuhoLmUKwF8Jd8VJyR6YOVE/czF84EbLdZ84S9mvT3jHGE7EcPBwbMOedSjLOrEjbpVjfycgRj6oIc6LtmseC0OH1GVyqVPyn+QyYd0yfi4dbdH4Cr57aIv/uy2j3m1kRsEbw+IT70DllWuTeBD/1MA+r0/9YNTkYiox3W+7rbRUE5yM8nRwpU4b1R5ULxWkWDCCqCfmwZeNLpTHVr2/0jAmi/ei1yBfHT0Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?/0ughBA3ibQRJDZVgOfmJLFSJC/BZDzplcRGKdbi/EMnKv6a8AcjxYkw?=
 =?Windows-1252?Q?HrMRdS0fgYr+YJSkxlk4SwRQdNZVhP6q2ENufKp8jiwuB1Evs8x+3QeE?=
 =?Windows-1252?Q?mUhR6yTjLvHeZYoer+aMsAAxzfemYHTuyzwGCwBcqrnIf12fznpbPKHX?=
 =?Windows-1252?Q?CI3h3ndSp1YGJ+94kI7kVC0k4cakkkukPR/l6e2fFS6Lrfwi1x8i+2aZ?=
 =?Windows-1252?Q?xz1/O9avbm92rYqsVSqyYMEOo5xetB5n3+4qgMePnTQF9Saka106MBU3?=
 =?Windows-1252?Q?mzATZcIXxPojAPm1XT0p7ivpZ9HD6sTOyPZ/+xKNra3Wir1uQIZ+dGvL?=
 =?Windows-1252?Q?l51beDbv3kAfxRMAbV0AFeA/5Y5Q4rD2aQX8LLXiaC8GMDG6f9ULvUgq?=
 =?Windows-1252?Q?EEH+IqkSM8a5ev/n2gYyL8VaviR3V7qvgBXG+et/bXxCj7xQRZKkhkH4?=
 =?Windows-1252?Q?02AFdOFMZoZTgq9X9UgRGsW6yuC6AmVpuD54Hfs+/kvn9iVwNgLejxVn?=
 =?Windows-1252?Q?v6xI2zmPFKZGC7ijvMCM+FIMHlOJsJ9CSMEXc77oUMGE5YaNQ+8Q1EVw?=
 =?Windows-1252?Q?yrVn6RYIpypTIeqV24vKYNCUo5mt/+ZlPcImstOT0tpiMIcXy+J18tjz?=
 =?Windows-1252?Q?IlbiDWsWfPWonHhka4ZBAD8LIrz7da+v3u/6MtN+nMTBaOX1IwVOhbAD?=
 =?Windows-1252?Q?Ji+N6D8k7wPZuPEWRxTWYLZd8depdNzm5OudoCtSMyhCn7/ZP/SAKPG3?=
 =?Windows-1252?Q?KcXWWp9yZu8psMMp0a3wpUIQQyszOlK4Bl2mIg5ouPvOm+j0oyn41YWM?=
 =?Windows-1252?Q?YwQ2iLNHQate2VNukaqrD5oT2i4zXjbcvdGe3r7u97fnCt1qzZLI6E3O?=
 =?Windows-1252?Q?z2q3XbWVtSS4VxvZ9JdctaesOwDeOJCCODRMgwuVXM31L7MXv7pWZRMv?=
 =?Windows-1252?Q?GW4A4ATODAC6OVzCRUJbL8xMgydyTn5wn1nf5G8uJHgFOunmXk6Wy8Mw?=
 =?Windows-1252?Q?Z0dlTUlqYdmWaa23L7a0sC/3UceRXFFfpecIMxCsvbrwTIv8ar9sLtye?=
 =?Windows-1252?Q?H3Yd8sOwSf2sUtS2xcWlDrLGwlBPRdVnwTQ4GQuHGXq/LLPP0OheSxGK?=
 =?Windows-1252?Q?fLBl26YUNUlQYKUoSDpB0NDg/oGhb6qFBhiRoAJ9zsCXbzYTeFM/nfCv?=
 =?Windows-1252?Q?YgOa8nuY5qYdrnnRoUFOYm3y0pnWLSdbUTcx9gPTDgqqdd78jieQ6+ss?=
 =?Windows-1252?Q?ThEWh+K4AG4SOWr/NbjzNCHgfLywLOUV+8bNKyWkgYQUplk20VkmXRg4?=
 =?Windows-1252?Q?ySgdI1G6lWrQOh4kcsYDVIaHkj7wlulyzTVnClnDwfKpeQ0CVbBOSOd+?=
 =?Windows-1252?Q?RRmIYXD4gZXNjxU6LaQk/MmbSxCDdMi+5ffbDY3d7fdFp3Ymeu0JXrYu?=
 =?Windows-1252?Q?PEDl2+DOPxds3NbW/Cxm+NvHVeAddq56i0WEqoI+SYmOWw5RMUSKyi/r?=
 =?Windows-1252?Q?JTD3WMIbpxqu92b/o/qzV4vl+aVYwJ9GgS1Cf9rTHLCAAH+2vcTyqpfy?=
 =?Windows-1252?Q?WBHT5QNDYbh1LYRBFWEH/aBdKfHhtviGsLxsAj+tfLl0S6Ik+pJ2wOZP?=
 =?Windows-1252?Q?TgPazGYjqz1A8zOS4Lu6rNPNe6SJN/9xgSj5ONZUdicjckmYNI7SMluf?=
 =?Windows-1252?Q?a/jaR/t+n/3P5Hynv19OSN91DEG4y6ouPhxcnk/Sf62xtEeqN/+1gtxX?=
 =?Windows-1252?Q?CumGx0GWy3VVMby4KrvsM0iUSX5VcbApRgN6dfZ3CZ7SgsLIeKMmn3zw?=
 =?Windows-1252?Q?LUpZ6gms3A5cYUseTopwpBlASd68vB8Yan6DYvuVFOhF8v89dCfcrrNh?=
 =?Windows-1252?Q?XzxlzkcxPtLv3Q=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XepGTFbMx+ravnTpIBOVQUaeXrqhaLikSEOCMJXWO67hYyWhtglp8rPgvWM0lTMSRohUyAnmDdDbenanIo6IbqBSJb0IuZrRDkuGrsR0zMjwru0XtnTLCXQnwQ1YqNPI+WhH8OgjICwiiFExoTDIIq5N14zwwK9+oqNUOgier++GRe6CxjrgNvIwPF+pll5U3kzIqqV95Xz75D3h+Zb/KJmQlq+hV64fktB6YzucG2lmDtsSssRmtvDJ2zDhVVS785RQh2HxL8OUQbDuznEK5RJE+YqiYxOxve2Vts2LCV8r6toyD1tRsJADrVVqNb2rWgg1vjjqj+yD2zWHbDff5g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d46050-c801-491c-8df3-08dee3dfd974
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:09.8214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUxaLz79t3Op5iZvqx/lx72oFKaWi19rSNYPIZpt1T6NMYs30FE/cuUGr8lt1dyzNAK6LtPt1ldNEm4bB7ZQJydkIlZumW6hKQgJt0vz31A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
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

AST2700 provides a single FMC controller shared by the main CA35 processor=
=0A=
(PSP) and the SSP/TSP coprocessors.=0A=
=0A=
From the PSP perspective, the FMC controller is memory-mapped at=0A=
0x14000000=960x140000FF. The SSP and TSP access the same controller through=
=0A=
a different address window at 0x74000000=960x740000FF.=0A=
=0A=
This change allows the SSP and TSP SoC models to reference the existing=0A=
PSP FMC instance instead of creating independent controllers. An MMIO=0A=
alias is added in the SSP and TSP address spaces to map their FMC access=0A=
window to the shared FMC device.=0A=
=0A=
This ensures consistent FMC state across PSP, SSP, and TSP and matches=0A=
the AST2700 hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  7 +++++++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 16 ++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 16 ++++++++++++++++=0A=
 4 files changed, 43 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index b77ea06e7f..acb8b06457 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -49,10 +49,17 @@ struct Aspeed27x0CoprocessorState {=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
+    /*=0A=
+     * SCU, SCUIO and FMC are not owned by this coprocessor: they are=0A=
+     * shared with the main PSP SoC, and only aliased into this=0A=
+     * coprocessor's own address space here.=0A=
+     */=0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
+    MemoryRegion fmc_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
     AspeedSCUState *scuio;=0A=
+    AspeedSMCState *fmc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index d14a42ebca..058cea42ed 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -159,6 +159,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -191,6 +193,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index fa492f1797..e03653086c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 3a98bd232c..39ba062a20 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

