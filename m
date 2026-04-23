Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB1DFAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSI-0007S0-2i; Thu, 23 Apr 2026 01:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSG-0007Qm-HV; Thu, 23 Apr 2026 01:18:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSE-0003DU-Gt; Thu, 23 Apr 2026 01:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UByi7naDUPFNYOX4FUXm+p1hgpoNh9g1LOPAA5CwVAKYAUpDBPLiIy/BOTOPThcOxRKOGyk7bs7rQ+sYGBb5P1sGv7Vek3w3ddi0m/qRw5uGr3weSxflfOJrFBxvt0eocd/UMAntVLKgLrOs1oMVXOvSSuFmMhekbhHvW7c298Gcx8XKHQ9uHCdljUQc0vWXOsOPQgOvESRgMLeTSJjOfpzNCusexvtAn+q3U+erQWJOHUM7HNwACf3+BJIdC2TrXxg1zy4++V1eInCa3wMG2kUnbfnvEiVmHS37GWjWcEm72XFJyksNP+YBBv90xQqVt7bVNbys0//tG0pcDBvuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLnu5u7DxEgQ5GaT5hrWW4BFD9Nj4zSz6MJdDP2QXps=;
 b=klpxhEnhQCBVfMt0LuNWEQT+CC3TLV9YUzLfROLpAe4ZOHuhfEy9d1hkGrhBOLXxaRz0Q0QiRL33V2brMQt1ylbHmwgF+Oo+oX4USdONc/TD0LUb0B61mrZD7s4aaccveB7yAvHefZPTpJvZRpSvQL929InHLfhZS3JhgWy4rkEr0og7mBJk9aYzScZWIf/lW1/DUGLdJblwSeo5G47erMF9cVLu85ibn1qmGX0BPLlHpDdgzwRrtmmwfSfFtokvq8fVcSIx5Y+/fB9hoG2pcMPPI9kAYE42dlYoNIucX7hes/qAXAdc+Kl7GY08Rtl0a1HjsvWSE/qS/57/35FNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLnu5u7DxEgQ5GaT5hrWW4BFD9Nj4zSz6MJdDP2QXps=;
 b=icdhc6zCBCzDwwaZEDdDHbpa6nL+1h8pcVGSRbEOzvKvLDuFbFeiUl432ycWmcXfP1H7U0fWpuDR2++07um0LNpqgllRFXTU777K/BGIMbaswpD1SOWmb8yr2qs53LwV/OsssAthqEnuldY23Ljb02gXvGVJ4QVPUleEEtvRcWeoBUXsA7F/GQTqDTOYnWQbtx5uJL/awbNDayLQu2MSaICFmrBGFcQU7JjQxlrStjt3p6wpLXKqIQSQu4ig0T7MwcuLjuxe4Q4TwBFX0EeTuuOoTINsHSYEKR/9au4FDyF/z/G7Eas4J7Hw63qA/L6NcWhpUVK1AtIhD54K19NzcQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 05/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
 qemu_log_mask(LOG_GUEST_ERROR)
Thread-Topic: [PATCH v4 05/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Index: AQHc0uCUtNQZ7e3fhUa/Oxy4/dmvpA==
Date: Thu, 23 Apr 2026 05:18:11 +0000
Message-ID: <20260423051804.362095-6-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: e78e3033-ee81-4cfb-0438-08dea0f7b6f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: AJX68LQZ9m0BmY7NTg6aFJTWfuTc6rsUmRljJ4nXriOhk7Mo9OC+RHSPjE3B+M46KKS1zBTVVWpmbFV2lGV9pPd3bxvvj4xIYb/u/sPWQkQZOwQcvgsTLKgBIna0tjDGOcUIrIMSy/V/ka6E6e1nTh88NG5bCwvS4L70BwnXN7jT3p4V6U+pqiGTIqmYr1gOh99I1U7dMIzKl/vb934f/suIiBP6qMPnQnAVO0PdAIt+p+0lHyfhwkp9H76cvs5r3pqBW2s8gHzM9it/B5zjWmBrF65FJBeYH8ddB2lPHG2MXOuzy8BUIasbnYQyABPPVLkuqyaeol/LJ9Mh2UXv8tvPTVHzTbavtkwsW+LTuHeKOa8wHqXoNtAWGylTYnowveH+C5m9J8QOiCNnXisBfKA7hNpFNn2jFMP7+Ob/fRDNgY+3XN0hDnql6eOxVVMctzfrrsqKZTpfykq4zsYgMdJlYmMk4pZB7HBwejTOnv/bLK5VYpuscaDhKvccic+sfYrqohOcwZKFJrSrLpQTUHKzTJyBaub4yCpCP8Bl2e/vU3AI31ADIANDbsUvO44WEfXhi2YAV26RcD1ux0wmt5N/NLI52mQ2Kja667ll6VpBFboUSe7F6HF4nNNU7w6n3v5J1Qc6l22vU+e3uJlHiQdtcj0LcHjkrJQ0up+wDIywxg0aOLTPETgJz+r9BxtOLwMf8YG/O0pE2UwCOsltqIESFPSTfTyPCkBrF5l32Zt5aPPV+mqofeRw56VkXfDduBLgZB3OHt3z2aiWhdEheH4m5Y6LI1XxosF+Pq6Ut00iPgGb0d6OOC/q4hkeLeyx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dP4R+2OevbSLgsW07Gvl7U8gx124nGQ6Qat7npTMV0dJunjncXvbxWn67P?=
 =?iso-8859-1?Q?u4LpSBx/33ARdrSlw5gEOPJ9v2uvD73PNAkggD88csKPEGvotPg3ZJK06x?=
 =?iso-8859-1?Q?JkoR1I5Y0MC3kpin3SbViS1f3FpENrZRipVI+6R0m7z25WYIm/MIk+zlwE?=
 =?iso-8859-1?Q?7Wa8AnPcAm8PxlmS+5YIFyitn4YOzOBhM3/M27+x0fFv86uDCyv7uypUG3?=
 =?iso-8859-1?Q?pw9QcrwQ7TFqN0AOur+565QCn393DSx5gfrwxCkt72C101i92HXB2/XDtL?=
 =?iso-8859-1?Q?PAXgWG0QCYtgZS6h/MQeT17IxjgMnUPTUPxm7lFdozJQhvBNIw2kSJA1lS?=
 =?iso-8859-1?Q?VyaOAS7ENvS3vkTYec3B0tFd9EWdPhpX7pVRypiYI7apXQHxHXG8NNjR3i?=
 =?iso-8859-1?Q?oBXBi104joiZ3vakcr+cnE/CjWMBwGNl2znElnBzCL2Rnj3Edd+NlYiVY1?=
 =?iso-8859-1?Q?+/IEiFkXhXVsV10f+0RZeT+7/ZhI+623qXx5UxVREqRyGAEYKXwTE6DhAV?=
 =?iso-8859-1?Q?S0xuHhodrA8rIpmY77l59O3T6Jh9M/8zw4xOA9MSaoKEN+ioVB34aRtgI1?=
 =?iso-8859-1?Q?9wN//zvPeDFmuEVlo1Aou2v47EoC1Arbc0zjcRc7XyQESNpasGhVbCEkZ/?=
 =?iso-8859-1?Q?/DQcHTR6z9A6IGTNB3/tUSSdcIYjnyByPl/CFSY4U39dHwaFxFCfBgAc+L?=
 =?iso-8859-1?Q?026LpmjGQLdcX5y/B0XlpZYrv5A1uJ81vNs1x9NGRGj4qqx9aJB0/EF9uX?=
 =?iso-8859-1?Q?Lmc38lIkQxTDdVXqdpoByE0a7dxqlWJMn064VRQZrGT6BcpEcijhHxlI3f?=
 =?iso-8859-1?Q?Pg1vHz7YdYLsCUveTwPhBVMHp3DwXaK0vnMK0xtxEMfBn4l3V/2W9QXDGb?=
 =?iso-8859-1?Q?vHiNIdHI+9B5CIjnOR96meJVqt3fP/TXrhQW8DCjmsOs78L4v1jL96xeWN?=
 =?iso-8859-1?Q?dayj71Vw8TuTjSIc91JEns0tjdMr9vTFXP4F1jWiIB6669cpqBVhm8UWr1?=
 =?iso-8859-1?Q?qGG0zXCkakF3ak1f3ynpEiS/UdfScuVFAIMYE+a1rLTVLA42mgpWxSZzXl?=
 =?iso-8859-1?Q?2gcNCY3AFPd5IbCSp59Bf2S6NL8cQFwpFdyH61HycBFkoGzXTx7OONSMRH?=
 =?iso-8859-1?Q?ntYQJxOnjH8aunVrOTPT3R6rCd2jWcJaM+Q1GT21yTAdq333WnkzQJQj19?=
 =?iso-8859-1?Q?WOpUWRTY8oEZojaW/8c3xuzk7b48FM4alBfTYcIR4Vx0ULt/EuXnkF+N0i?=
 =?iso-8859-1?Q?KJgsw3J3+sAehBUAOu/FOcCCj75D/L7xJZey/vUnsWZX4hqb4Hs9KKDl6w?=
 =?iso-8859-1?Q?w1G08fLvYRJTwaXqt/s/k/xcQHfDZ4ZdpO09dl4faemTywdMirzb4+X+dF?=
 =?iso-8859-1?Q?+1z5cbqpwREVrQ7hPkVo9bcbthCzDtjAUz2Dd6vewVkGn//Aq9eOI/urpz?=
 =?iso-8859-1?Q?c5J7j3GeZBciAVUTnWO7Az19KiT+8+RBc5UJyAFr42hTXchWvas1MihQKR?=
 =?iso-8859-1?Q?hPc6PklEQfiUe47dj+M8Y/FgxQRVd9AdGO/eIKqDkhnBi9qySjSCIkdZ6s?=
 =?iso-8859-1?Q?T08zdIT2dYGBoN91SiDL3TFDMGyf+5y2rK3phYq0zNE7tn8b6K4Ha0aPIU?=
 =?iso-8859-1?Q?2IKo3X4nxaG9QtM4zrA6kIk4RaCQq3xK4yTa/2++oI98VGUF0eWTwkiCip?=
 =?iso-8859-1?Q?Ddn+0n/L6N0kwOnq2e1KhBQL6JjxQU7rZ9wTk1kMbLslUO3x18EeQhTG5K?=
 =?iso-8859-1?Q?5cDbCedqw6a05DZDnmGJ6sWUD6NWKRT3IyfQ6PQCMVzcK8fexWwXrShFVU?=
 =?iso-8859-1?Q?XAYdIHDtZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ml9Bf011rc6w9e2erL1Ok/offmb1sh9Bp9nrvxTZWWKIc2XbuMTd1pM2OxjCSpwWKcJO/JzJ1PeSolaZjqIw/9NRQx5SOYKX2nlKvid3MhUs75fXjhuG5n2V/gIOl6vgahoJxIkYcAPEb2oPXPPNbezZ+87rl3H0XjDrFERriXPpMkjOLffNm9/aJm+6vXFs3fcbOxcV27UQLwkdIaEaJlEa/ta7WAW7PYyp1TyuwWRUuwQPu7pUPe9qOF4fOKCTMbTPzzfltXB+LUtaWFM8lq34ygmDXOvsuHH32GoOyjTFwk5nzFwwtMqO9Isbb8urp3q+OIaiWAz16cfXXVqGug==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e3033-ee81-4cfb-0438-08dea0f7b6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:11.9161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vonMyzH+9TD/VkqHUiJCzNsh9a6djpOWu+c5BPLda/trPxmnJ0i7qtR6ux1rOq9PVElJkxEP5Xw680sexcCVesJxhODpPYrew3LHFpjAGc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Replace direct fprintf(stderr, ...) calls with qemu_log_mask()=0A=
using LOG_GUEST_ERROR in the EHCI controller implementation.=0A=
=0A=
Direct writes to stderr are discouraged in QEMU as they bypass=0A=
the logging framework and cannot be filtered or controlled at=0A=
runtime. Using qemu_log_mask() ensures that guest-visible errors=0A=
are properly categorized and can be managed via QEMU logging=0A=
options.=0A=
=0A=
All affected messages correspond to guest-triggerable error=0A=
conditions, so LOG_GUEST_ERROR is used consistently.=0A=
=0A=
This change improves integration with QEMU's logging infrastructure=0A=
and aligns with upstream coding guidelines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 46 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 25 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 7e0b767eb9..8acaedeaa9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -36,6 +36,7 @@=0A=
 #include "qemu/error-report.h"=0A=
 #include "qemu/main-loop.h"=0A=
 #include "system/runstate.h"=0A=
+#include "qemu/log.h"=0A=
 =0A=
 #define FRAME_TIMER_FREQ 1000=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
@@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)=0A=
     case 2:=0A=
         return USB_TOKEN_SETUP;=0A=
     default:=0A=
-        fprintf(stderr, "bad token\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");=0A=
         return 0;=0A=
     }=0A=
 }=0A=
@@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
     }=0A=
     if (p->async =3D=3D EHCI_ASYNC_FINISHED &&=0A=
             p->packet.status =3D=3D USB_RET_SUCCESS) {=0A=
-        fprintf(stderr,=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
                 "EHCI: Dropping completed packet from halted %s ep %02X\n"=
,=0A=
                 (p->pid =3D=3D USB_TOKEN_IN) ? "in" : "out",=0A=
                 get_field(p->queue->qh.epchar, QH_EPCHAR_EP));=0A=
@@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
         /* not supporting dynamic frame list size at the moment */=0A=
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {=0A=
-            fprintf(stderr, "attempt to set frame list size -- value %d\n"=
,=0A=
-                    (int)val & USBCMD_FLS);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "attempt to set frame list size -- value %" PRId=
64=0A=
+                          "\n", val & USBCMD_FLS);=0A=
             val &=3D ~USBCMD_FLS;=0A=
         }=0A=
 =0A=
@@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case PERIODICLISTBASE:=0A=
         if (ehci_periodic_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: PERIODIC list base register set while periodic schedu=
le\n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: ASYNC list address register set while async schedule\=
n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
 =0A=
     while (bytes > 0) {=0A=
         if (cpage > 4) {=0A=
-            fprintf(stderr, "cpage out of range (%u)\n", cpage);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cp=
age);=0A=
             qemu_sglist_destroy(&p->sgl);=0A=
             return -1;=0A=
         }=0A=
@@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
         break;=0A=
     default:=0A=
         /* should not be triggerable */=0A=
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",=0A=
+                      p->packet.status);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 =0A=
@@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
            p->async =3D=3D EHCI_ASYNC_INITIALIZED);=0A=
 =0A=
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {=0A=
-        fprintf(stderr, "Attempting to execute inactive qtd\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd=
\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
             p->packet.actual_length);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
             case USB_RET_SUCCESS:=0A=
                 break;=0A=
             default:=0A=
-                fprintf(stderr, "Unexpected iso usb result: %d\n",=0A=
-                        ehci->ipacket.status);=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "Unexpected iso usb result: %d\n",=0A=
+                              ehci->ipacket.status);=0A=
                 /* Fall through */=0A=
             case USB_RET_IOERROR:=0A=
             case USB_RET_NODEV:=0A=
@@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     /* section 4.8, only QH in async schedule */=0A=
     if (async && (NLPTR_TYPE_GET(entry) !=3D NLPTR_TYPE_QH)) {=0A=
-        fprintf(stderr, "non queue head request in async schedule\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "non queue head request in async schedule\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1606,8 +1612,10 @@ static int ehci_state_fetchentry(EHCIState *ehci, in=
t async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "=0A=
-                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "FETCHENTRY: entry at 0x%x is of type %u "=0A=
+                      "which is not supported yet\n",=0A=
+                      entry, NLPTR_TYPE_GET(entry));=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -2118,13 +2126,13 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             break;=0A=
 =0A=
         default:=0A=
-            fprintf(stderr, "Bad state!\n");=0A=
             g_assert_not_reached();=0A=
         }=0A=
 =0A=
         if (again < 0 || itd_count > 16) {=0A=
             /* TODO: notify guest (raise HSE irq?) */=0A=
-            fprintf(stderr, "processing error - resetting ehci HC\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "processing error - resetting ehci HC\n");=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
@@ -2181,8 +2189,6 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "=0A=
-                "Resetting to active\n", ehci->astate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 }=0A=
@@ -2231,8 +2237,6 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad periodic state %d. "=0A=
-                "Resetting to active\n", ehci->pstate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

