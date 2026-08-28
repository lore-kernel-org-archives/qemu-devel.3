Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA54C61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsVr-0005XD-7O; Fri, 28 Aug 2026 05:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVk-0005Uc-GH; Fri, 28 Aug 2026 05:04:33 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVi-0003UH-O2; Fri, 28 Aug 2026 05:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vytwkp/8P0xgd3TkYOC37AE8axUe/r2ImMUHRN/OeRPiIRMOQUYZlOZF7y08nACxbGxpN/32s+0tj4+LJ0h9ELEPrFTIIXiPT6gAs0sE0rVzXNT2X/VrEJUVRk2uaQuEFXSoReKjKk62Pt9BdReOKZme2334abAjxkAhuNzYlkRDHNJbmIG456H+USa/F2LrJx4CjzF4oV6Plz11EeHh0G0ueUEON2UjOq7rgONQpBj+syy+dR66vKhSsW/Ok8m/MjbVe7SndeZTa93amJwdVhGCpl7OHvqMQphYv+MnK9/CT5Onjzu6J1wkRG1RpJsf9asng3PoqxiiIHT3wJL9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weREDUn3KDA8soE83KlybWR++soMjB3/vZy1Sgo5jRU=;
 b=DiecZrQZ2hGZ50JtgiJeqrmVQZV9Z+7+hPscARF7VlRlNClsAbbZXdNgo80yOMiRQVdXNcI6ysEXZXdGbmmEAMN7dDwGQIP/QMJng7DUF9x16/nPHYOpX0PaI3anS2DxxB45h6PnqM8wteQjuDbdZgTHREZ1A+fcvbzI0ybYbYfRRg/HHkvh84S/j9mKUVKi0JUJj5mfhJ2qYCj2VS0imKZLT5TnXW8G8HytUYiJog8THegyc70ju8BpoeICXegJGEDyIzvOVW6gohrAnRXa7KdeV+4fIyCQvAXqCah5tbAz4WkNW5aAq6rTYZnJO7vp6vJ8AmK3OcOiLJpQy9wq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weREDUn3KDA8soE83KlybWR++soMjB3/vZy1Sgo5jRU=;
 b=UIo2p4wQYcvWFxwW9oT99QaM7MEhKLJVa5ATOe/++RuvAcVH6zROoMan54OfV0XaJtO7T2PNKhHxC/Sb3aX5jkFlXoxpUdNCDCYTeFqBOuCsvNS5T4YWj+/34CQ50XdT0r6u8k/5lblVxOf/h+MpmnX/LxSZG4TYjE67uEZ+0orkE9+cuHgxHDPyYyqd/6g85TjJfSAlSRvL6dV1HhizqzYTktJakRZ8xLmTl9lPmgIHIIFve62gHTqhwHEQkQQD8rms+7ADgZnjDGvW/6RxydqBGKVec2cxj9wnEMeD/h2Q71NTJH7Vi0hXXQfohwwT8LigMb3Y7K0bkNQ58NTNDQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:20 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v2 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdNsw1n7tMj9PI6UGWFcjm7LEdTA==
Date: Fri, 28 Aug 2026 09:04:19 +0000
Message-ID: <20260828090412.981841-5-jamin_lin@aspeedtech.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PS1PPF2A261C07C:EE_
x-ms-office365-filtering-correlation-id: 3d94d387-e28c-466b-0bcc-08df04e3590c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|3023799007|56012099006|10067099003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: 7lBu4BwTUVxt2QDD1rmIQ2u0tsm20g2Rq//OY+RV8wflzv8nx2i7rWkBO/GFNcKw3jGBxHVNx/KpDFPCJTaLteW1ah7r5PYv4aWuAb6m5BQ8NBWK3y2NHiQ0OxnFmIU1yMJdzbfY3pE3C0L1a37pWtskIXf1jVFihclgXTp6nhyOqgg/H8BWLsFLzzSC4gMpUROx0fJ0fFyxCSRS5IDrhLvzarMgdOL3vNKtRPPg56/IEpqyuBZEmzAR9wv2sJDKeATxGfa818sUDQQecmBrm7NvFHCGcdEBvM9hOOdFZL8mDVeuF9HInzpMjWmWb3NnxeRqb98+aZ9dyLfgoCindvw+vQjnwDU0CXcs0yzkhtQetyCfeOe21ZL3a5mnHE3aXE0d96vSMloLfFiCPFKIiLuTT7iWOmhHxbv4fkBVfrlrlOpIKHOzzRRbkcGUZMyv6h11dYfZIzZ0E2iViGB7/of9lHJGtfmxrTBi4+2m6TT54NhD/PtIi3obiabOxH9ZzEaWOKrDfhQM/RTHRhY3qBhP03mEnVnkEUa2E/CWZFi+W0xvK/rzcy+PuMBVSDZOvFvNgdPP+XHqhR22DQisgovGD2q7ywFoydVkJ+cC0WE9ksPFRVt9T9mYQFlIgr9Bju0KbmiWAQm2uFiz8VQ1N1SS7NgPX7ecO0sgj1q0RTwOwQe5jNprYxl1iRfvUD9LMGGWZOTGsD0QhYlpcL/vRIBudzEsPIo3mH7C6dE//0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(3023799007)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9ORuVgborTGJwdwwgq8D0sDfknrPzqxBOitDf/rVJZym/wYgqquK3Vu0ur?=
 =?iso-8859-1?Q?R6PCbmi3rEnI3inXbXvdmssX8AgMx4LUc+MO4UlqGNPoVDuFy2wd2kuxW8?=
 =?iso-8859-1?Q?Yel2EzqM0Om1WdhLRsfiBcIHTepM5AYNXxi/hOriwdZN1LyuhoFrGNh9RQ?=
 =?iso-8859-1?Q?ij2PUD9llsVEyx7cIrobCsGPgkdgVbSah3sD9bO083I0FroXum6t0QKxIo?=
 =?iso-8859-1?Q?ii0u79bKVzDkSH7lYJAhRxXF8WWtXIQ3GJ7JLlwosJ3WzmVQSFPvEWryLK?=
 =?iso-8859-1?Q?it8N21qo3pUmpOj4ozyVpf616YrUMjPcASKptwjgtJ0OTOL3ubOurh7NuL?=
 =?iso-8859-1?Q?d+/jni/xMOr8CP7Qt42+7b0suuXSFUZVCYNMSv+ZZq5MC0DW+HwkzBAK7Q?=
 =?iso-8859-1?Q?GzfbLrC+vz38pn0xQsqsOXolCfDmonX9vIZrod1ryK954IhrDdVwi2nRrz?=
 =?iso-8859-1?Q?epyp7JtgJ6M9F8nANLb9jFqgSbZ8YdQrnCWQ+QvqYmfYNR7BsNPWhmZwAl?=
 =?iso-8859-1?Q?1eYxqFfKJTdBkwQPiwXg96hVZTMDp+lMKu4N5gHdKSe9HJgrgR6gTlZBrW?=
 =?iso-8859-1?Q?0xlpSuU9Y8bFhtKLOnHUbR2/ucB1hnygIwiqwp/SW/j3+rHGvnnBWEbyFe?=
 =?iso-8859-1?Q?pt5vN/r6oN/XXkd2RaU/dau95NOtzJKs2gqL7FfamijqMnx1yv3I03kPj5?=
 =?iso-8859-1?Q?se61HC1YXs2CI0oBixeAhKjnXMzE/D/ba1oFEprmhBp+IGRSKFmayAof9e?=
 =?iso-8859-1?Q?ryzcMAcHvAQ9bSvo1LSnFNRxo6W0/RhzAx3gJaTs8YWbd1G1TmSvOXgfLn?=
 =?iso-8859-1?Q?JugSWaJORdIofW7zgKrkJOAFZdzZ2cYy1R/TP1scIdwli4zeAlJ9Jw2Us/?=
 =?iso-8859-1?Q?kO85DQXfbYUPz7aQUW5kXUKCUsQEFbKDG3Sgve3shO8I8tkhUa//ez+1gb?=
 =?iso-8859-1?Q?1+luBTCDVdy32SPyaLcItuzKj+IzcW9TN6/ZSneTcrrl5vtH+x9tMCL/rf?=
 =?iso-8859-1?Q?vkvIRoAlS/VlEtoMBdy8xjbHw9Mftc/MoL1M0BnWamMdBuvQidU7jNYHPB?=
 =?iso-8859-1?Q?0e82olmpsbPEf97Im0egHWh75/YuR8r1zKxFCRAlUYkk3rF9Nnc1aN0mk8?=
 =?iso-8859-1?Q?wOtZHlyG6dg+dBtSBtYlqJkwd20kkdPvibqFa2VA2JUUnNq13ZAetAc+rW?=
 =?iso-8859-1?Q?VLZGMXcV+gRwnZuTFrO2H6rGfok68FG1L/IflXcHEa/XVemDSWxfqPjXnQ?=
 =?iso-8859-1?Q?sLG16EgntOnob6zApk+EsOZCHdqmdARAcBQBKqjAdRP9Sk7/DH46714qPG?=
 =?iso-8859-1?Q?IdxHXmwLdt+8nSmrv1MVEvVE14nia7W/Cp1x0I0RwlrNqgKwcMECSO1dos?=
 =?iso-8859-1?Q?H4aN/LCnV8IFb3H+qQcWKbGGVQzajDdSBNW18pTO7EqPkiM1cVNcpmcSGQ?=
 =?iso-8859-1?Q?botGxMc1II/HiF4EdrdsILVwI8fcEdgQB8jc57IqwWaux2PgggrPX5vWDE?=
 =?iso-8859-1?Q?Bv0XpNoH9YUNyXncEZj83b4PyN1LXlVb3KgiHzuHldo7i5EVhv7SkkcrTE?=
 =?iso-8859-1?Q?W6PIOe22SQWAe5rxToNCyblzMGm/jjqRcCIeyW+HZQbeBsbDXXTx1b6bPY?=
 =?iso-8859-1?Q?oWdafmh4cAPlmzQGaz5py1hYe7LzE0HNHoIhX9j2njYtXtRKKN1zp2PWY3?=
 =?iso-8859-1?Q?ciqDRWtoDWIO2bIOXWF1q8IggAhUxjXHFpRwJ6pGyWdGTpWxQ0cuDyWvV+?=
 =?iso-8859-1?Q?b0sl2HDsfjdvzpj7xG+54oQVHx9TA6rp0sf36jkF0TA7xHKWA6gfRKksDP?=
 =?iso-8859-1?Q?HduY8Uz50Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2X7/azci8Q/rWox+Zn/XR1hSF9U03086mF+UmM+ThguLe45PQB709DzhlHIBwWySRVXZWin2r0ZtgHF2FDrI8rKqEpxAORNhYEKZVusE4+YnmbHgIP4nhfkmEslTFTq3Ber36LcflFyO8YX5BcTOXKHfC0qcPs2Nk9+jzmR9JSgzThVvHS9tXzbD+07+vhtc8kt8QMJRI9PDwA9fbk+MrIoeIif2eqbAY+wGlWxnrfxhsC4EjI6KRvEvNydniRkAYy/8bZ9NBdhOvoPje5GeNHO5hIPy3V0qM4HVHjSkByoh35UOqA/jngHa0Itf90aM6NTqDAWX3A8jLqGxMj4XnA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94d387-e28c-466b-0bcc-08df04e3590c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:19.5204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LQSY+UR7s/lzplw8iQ1p5jE8foWPYfqhf1sW2Z41nZsAHp1lA7eplyI47uvejDzzfwp8heiICCpql0lebIXdbFylaRYr/vFa3Fi+NJgSYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C
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

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC=0A=
and map its registers.=0A=
=0A=
The UDC and the second EHCI host controller (EHCI2) share one SoC=0A=
interrupt line. Route both through an OR gate whose output drives that=0A=
GIC input, so either device can raise the interrupt without the other=0A=
clobbering the line.=0A=
=0A=
The gadget USB device is not created by the SoC. It is a separate,=0A=
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a=0A=
USB host controller's bus; it finds its controller through the "udc"=0A=
link property, e.g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  4 ++++=0A=
 hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 38 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..fe7b31e42c 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -36,6 +36,8 @@=0A=
 #include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/sd/aspeed_sdhci.h"=0A=
 #include "hw/usb/hcd-ehci.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "hw/core/or-irq.h"=0A=
 #include "qom/object.h"=0A=
 #include "hw/misc/aspeed_lpc.h"=0A=
 #include "hw/misc/unimp.h"=0A=
@@ -138,6 +140,8 @@ struct Aspeed2600SoCState {=0A=
 =0A=
     A15MPPrivState a7mpcore;=0A=
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */=0A=
+    AspeedUDCState udc;=0A=
+    OrIRQState ehci2_udc_orgate;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..21db95f5ae 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI1]      =3D 0x1E630000,=0A=
     [ASPEED_DEV_SPI2]      =3D 0x1E631000,=0A=
     [ASPEED_DEV_EHCI1]     =3D 0x1E6A1000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x1E6A2000,=0A=
     [ASPEED_DEV_EHCI2]     =3D 0x1E6A3000,=0A=
     [ASPEED_DEV_MII1]      =3D 0x1E650000,=0A=
     [ASPEED_DEV_MII2]      =3D 0x1E650008,=0A=
@@ -214,6 +215,10 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
                                 TYPE_PLATFORM_EHCI);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,=
=0A=
+                            TYPE_OR_IRQ);=0A=
+=0A=
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);=0A=
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);=0A=
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),=0A=
@@ -561,6 +566,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
                            aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 +=
 i));=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs=
=0A=
+     * together and drive that GIC input from the OR gate.=0A=
+     */=0A=
+    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,=
=0A=
+                            &error_abort);=0A=
+    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);=0A=
+    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,=0A=
+                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2))=
;=0A=
+=0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
@@ -568,10 +583,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);=0A=
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
-                           aspeed_soc_ast2600_get_irq(s,=0A=
-                                                      ASPEED_DEV_EHCI1 + i=
));=0A=
     }=0A=
+    /*=0A=
+     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it thro=
ugh=0A=
+     * the OR gate.=0A=
+     */=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));=
=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));=
=0A=
+=0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));=
=0A=
 =0A=
     /* SDMC - SDRAM Memory Controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {=0A=
-- =0A=
2.53.0=0A=

