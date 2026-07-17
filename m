Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A230C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDG-0000Z0-CZ; Fri, 17 Jul 2026 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDB-0000XM-V9; Fri, 17 Jul 2026 04:46:27 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDA-0003vC-02; Fri, 17 Jul 2026 04:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7jdp9URkRRWGvMkob534SI/vigN99vdIhhpSNxPK1Feq7e+5StkECYRLD40cMlMVsEsGxy0SO0uveJSCKgwsXZJ01/VShjGEn9bAHz/WPyvywHyTWJRYLntmpGmYqPvtFkTnm2Bp8EcCr3J/a3ObBmqrmqMoOxEJtSdeuz/iLibHTJ2y0udOHGXCbP/N3xmSBYDugGvf1PngZgzahYpQD+ujg8v9yaJbIgQeZLqNUrWBU/UPyk8cD+m17r1C0rKjB/cw67ohzAluJ2KOs7v3HHeGHpCVJK2IqZm7vP9pNli4OViO6YIDmNQIejNBKMeDSjv/ljy4jqt27+ebIbnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NsZPU0vp5g+L+ZwYkgzN0/vSqDgJxWBI/lwu9OovNo=;
 b=YfcWUqNiejdlUF2Q8Pd9Q+FsU/+vUByVkROO9wFPi1OwlRzqHgIIvfh4vQXV8eKVHkIuW0HvubHPbhULaQvq97YG9a4hWNEHnaEBKssMx/HUCy5x8uh6Yz2BZpe51krOpc713pw0p2PAUteyK1CpA2cTqoIejuZwHtGab5qV8/XpEkY43wOCsxFRpKOVChnuXB8spUVxa2yuKz9fglNqoz2rFz7F4cNsB2R1Rcv3qTCc8sLddlWPsX1IXGnrpJXVsypB7393QaAsIbPDZI8Gleki+h0XZVwGQozcOZtwfR0cQy2YBzs9OYsbIEuIo+kbSzjrWoWPP63jfuXRxyX+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NsZPU0vp5g+L+ZwYkgzN0/vSqDgJxWBI/lwu9OovNo=;
 b=SXA9tOngXvi0xyqDNdr8lCciUGNcWAj+Gx3GBgAgb/aYch8GP7IfhkqGPaohTJ8GYf2deOeB/IqGzI2kWlugTmcC92W2DwINLdmhCyPOcKRlFLQOMQ9UR+qmP1EFeIsGH5Y/59MAzvG6MPWCf6Upf/t/BXuXpCLtkLrXB2PoYNA07LkCAP63u9zx4aKVaTfPGPhYdccInkk3rRbR2fwFAy3iUPOTlqLUuTphQziau17sX4/VmVM1t0+DQhP46xk0ukkD6NvooiHBRF59DG3O5bMJocKztBi/LLboaYo6+gaefimhrK8F5cQVjz8gax/5T1ZpaAOjLP4h2fjmhTktjg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:08 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:08 +0000
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
Subject: [PATCH v4 6/9] hw/arm/ast27x0: Share single SCUIO instance across
 PSP, SSP, and TSP
Thread-Topic: [PATCH v4 6/9] hw/arm/ast27x0: Share single SCUIO instance
 across PSP, SSP, and TSP
Thread-Index: AQHdFci29aPijPy6VkuwdqCu9zor6g==
Date: Fri, 17 Jul 2026 08:46:08 +0000
Message-ID: <20260717084559.3477061-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 0fdb5285-55b7-4ad9-af7a-08dee3dfd894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: 87ZKDfGE22aUD+I+NVGJyvZLunRf+uRgPuHsydsRMJlFsC+k2BztZAmtKB6ebRGK7XMoMxcVbj7ThF/PRrtHdQSdw8VQZKqTaWB2qi/Lq02AZ+ipVKcsIBha2pe8jD/RkJ69CKJ0l4UewKA1M6bIwbhRPaE5h1qO8cH8OZ7iutxygkDYdekcy1qk7mwI0S5NwFi6j2Bqe4yM0Ejirw6JIJg9gr3etkqfyVhN0rx1n8XmgNrnV5T6jmdEolMshw0MqWmrZpqhs9XPCUtlZUrKqB27MVe8Uzapo8WkCw2LXvAhlAWF1PeVmTC5/EQgHOkLMYihX0kYN8ewNm/njy47DlLIeobBld66/HvH+v46cZCahTS+i55xbWVSQ0rKWZWGSEZoFCj4B6g/+EfiYNZM6yf7o4vn033cPgg0fP7yIzn77+wOiV3JeJaP7wreFfFPp+r0sHeNdOLSEwCLVnw3nJ+xD6k4i+eILqTZXjTvI73h3jOAbpuo6V1Kssq2bJP7b5QbTbr+hYq+yCaW6QPSQoEqr0VH/Rw/tIVOEBTuOjkNcin2dFp3l1JrOBbDeAjz9VZqIFXEBKKJV9pr4pl2/RZgLCV09Te6ETlB7I77wc0ymAOC4+1JxWvucsnj6AIk7ODoSsfatpG1Lg+umb6oOL+XqncMG/dITHK9myvLx5Bj6U9dRjVeHobupBiOkTPJaAr7huNZOdhl+pdDHE371m24yhGjaEOVu18BVxrwNjjX0yE3fOYY4vWFSn5MnwYH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ZLMpOj0QY7faEVRZoGGE3gksUvqsCnOZZM8ci0d6feSntx4ubVMJmkBg?=
 =?Windows-1252?Q?H7StqWRlIds72PNJrNO8wXbDyXxOCObKkDfeC1D/cRoHajZzAwltRXf9?=
 =?Windows-1252?Q?9MQ6d34cue/5KbGSoJGXAXiYeWhwY8pVkiqIGTWxKDas503FPZUfn/1+?=
 =?Windows-1252?Q?XUb+WFwsfrqhsoUwiRfccUu5lFTsqQ7iPLxXHgAVntWtP7mB5bWtqNTH?=
 =?Windows-1252?Q?yu0Zs1E4F6VFZkPmpjX0guqO+I/tArUKhK642t14XJm6APZsCOlwrEod?=
 =?Windows-1252?Q?ORP4JLVEKDn1V2mnIkweZQL5NIUDPqpEsIeKTEzxQJYO+efaph8DYJG5?=
 =?Windows-1252?Q?g4fY93WgMd9FWuWCB13X7/k4LrjMJqaakwjy1pAYPLavR700ffQxdsdw?=
 =?Windows-1252?Q?xiJUXg+0RKInANjSgwKMJjtGiQ3UyR260YPT7Gy+hcDGI1WkFzsUdNPI?=
 =?Windows-1252?Q?MX7s1qGIG8aZJlpLP4ROeF9V3ZkT6UmOV8cpTYwX7rJlFYCz4WmNB/nN?=
 =?Windows-1252?Q?oFelmPI+gHIZRrf7Zsco9N8pp0e36VhVnIMqoZ0jcBkSeRHxX0GTbo5W?=
 =?Windows-1252?Q?brQCVcqc+rs/ftRHSvi1tU0NKrAnVfiaVCqlp5mrQgYLyd/u/FRmISTf?=
 =?Windows-1252?Q?dIbp7EpRh+nezeBOGDXM+r7ml++3ItnTiA++DY5N9feZiIB4BXhZwtlL?=
 =?Windows-1252?Q?qzH8mRKYAWst4Y5pWk2AcRQb7Y+++MgfP6WA8rEzCYDTub4Y92qen0ZH?=
 =?Windows-1252?Q?pBu+wAciAtu8pOOneC47gR373ZfaXjd0VDr7ZXj1H+KcOIo5MYKSDBmr?=
 =?Windows-1252?Q?Hli6g9YpvFTYE63jA9wQ4ArGx3Z+jHRddrqGmBMTCETb1nSxPNqu+rBt?=
 =?Windows-1252?Q?sBQAgOcO7UfSsOxKTDupdEPd483IZDvSQl9mpDWAGhfeTWHPuUjBq+o4?=
 =?Windows-1252?Q?9/4r0vDs+zzYvYcuLuvpXP3SbruiGSM4IBUIkxt8yxqpqWevGenFnzkp?=
 =?Windows-1252?Q?O9toLCDNdE0sRiFRBNgbfxElO2mHG88mxHWkGbipUqETRh7gCSD34jms?=
 =?Windows-1252?Q?q8Qf4B59/UXupU5QMO8MUtuYW8M/Zr9Q7bsAq8UpHKR/8GLKmKWxcRuF?=
 =?Windows-1252?Q?01mlIGAiMJqQYwBgBviCq1ESosbFWWPgdzMJ3QmTXDjRxu+g8PLhYka+?=
 =?Windows-1252?Q?a1LFHra5YJQ6ksVp5KCU130vRlgcx67gNu7vQCMdqjqp4DwDNSyQENIg?=
 =?Windows-1252?Q?ad+N+rtzGwNGlgCU4sZ0deATz5EXbv8ugPElFyqnomrBJ7hQV5umYeBy?=
 =?Windows-1252?Q?LrzyGDYXTVsJF0KShcJQKA+qkXVbDqiaixh2wJ/PJ6vMXiIvbN4iBLYi?=
 =?Windows-1252?Q?6l+Kq41KD3T8CBfEppzYAJV2RADF79WA1TTuFJFdpLLK360+Td/D8+UF?=
 =?Windows-1252?Q?YCKo8Yulkeu2Qiade9BiRFJ++syPtYxpE+K1LmN7EcLQH6BhaN8AIJdn?=
 =?Windows-1252?Q?yULQ08mk00DDg7eMbJlentUGvi6jDhCzp+dtxyt3W42cNYVeUFqaHroV?=
 =?Windows-1252?Q?TUm+SzG9KKes6mAk7z7s7tSiugx7+w1EH3MfR1LqcTWJdsjYNn1JoIQu?=
 =?Windows-1252?Q?f+mWnhLyS6fMiBRl9Sn6psNzskNgLLDUqwlMwcWkpoKKIOkUg7ZxJUXo?=
 =?Windows-1252?Q?wEhy7aO1xcXlEfgW7XFd8QuF4AICmuiBW4ykAKRQqWARcZ+PnAQovCX/?=
 =?Windows-1252?Q?/8/nJpQE3w2cTbQcLPh/FjmSmiNMdQWWzeO2avCYCk6Z+TjSFMRd62uG?=
 =?Windows-1252?Q?PUF+q0OTqAG/mTkBcJk26S0QSelv1y2Iq3sLpDbRzoCkN++nVZcmSaK9?=
 =?Windows-1252?Q?ER8dunyZ/3tqZw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lz1enrtsnuhSgsL11GVxf4ORnsjsyrkgQ5dP2MB3LN2s0k/MUy/4FJR3q8JjPcBYkJuT7lm3jD678Cr40BXYGahSqs6zUSfLCyLad89rAhRhGL/3VFez+J3wTicyK8o+MthpG4+HYeNWd4Ljpk9w7v1P0smgELojZ52QOJq2m04c/XOLjDOsVJOxf3qssnkw54WzxEi2gYo1KrxLo8cF/dM0B6MyX1hllIYx/evAzyAsButD6eS491dO0RqiC8kJyRoS2+MoaNwhx/yWwmMIEM6PL6wa5ynj5PeYWfCpWVMmcCGj3ux8GnRtS3u4vr9h4UhhV9LFlAf2V8yYeF4muQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb5285-55b7-4ad9-af7a-08dee3dfd894
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:08.3622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNOptCJGuxF6kXYay5MPs13uJZKa+p85j4+g0qA037QXRZlt9LpwnIz+ZkrZSwm9LvMIU/OQOSD42kCr5wVdm5Zqf6erYcFQPNGyeRtY+aI=
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

AST2700 has a single SCUIO hardware block, memory-mapped at=0A=
0x14C02000=960x14C03FFF from the perspective of the main CA35 processor (PS=
P).=0A=
The SSP and TSP coprocessors access this same SCUIO block at different=0A=
addresses: 0x74C02000=960x74C03FFF.=0A=
=0A=
Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO=
=0A=
device, resulting in three independent SCUIO instances in the QEMU model.=
=0A=
In real hardware, however, only a single SCUIO exists and is shared among=
=0A=
all processors.=0A=
=0A=
This commit reworks the SCUIO model to correctly reflect the hardware=0A=
behavior by allowing SSP and TSP to reference the PSP=92s SCUIO instance.=
=0A=
The following changes are introduced:=0A=
=0A=
- Add a scuio property to Aspeed27x0CoprocessorState for linking the=0A=
  coprocessor to the PSP=92s SCUIO instance.=0A=
- Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.=0A=
- Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP=
.=0A=
- Create SCUIO alias regions in both SSP and TSP coprocessors and map=0A=
  them at 0x74C02000 to mirror the PSP=92s SCUIO registers.=0A=
- Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.=0A=
=0A=
With this change, PSP, SSP, and TSP now share a consistent SCUIO state,=0A=
matching the single-SCUIO hardware design of AST2700.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 20 +++++++++++++++-----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 20 +++++++++++++++-----=0A=
 4 files changed, 36 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index adfc3c4512..b77ea06e7f 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion uart_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
@@ -45,14 +44,15 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedCoprocessorState parent;=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
-    UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
     MemoryRegion scu_alias;=0A=
+    MemoryRegion scuio_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
+    AspeedSCUState *scuio;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 58d0b4d7cd..d14a42ebca 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -157,6 +157,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -187,6 +189,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 28bb59c8c5..fa492f1797 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index f5c4a02161..3a98bd232c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

