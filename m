Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C91FCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu8-0001td-Pt; Mon, 25 May 2026 01:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu6-0001qV-Ej; Mon, 25 May 2026 01:31:06 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu4-00035Q-9t; Mon, 25 May 2026 01:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMQ2AUAHJer7qdkJWynT5KgPQKaMo3sa/vL7tJaJckYY7Wk9e7hANn7UvhqESlCCkBLtu37stsgAKEYkumQ64cDKEHvT9Nq1oRxGumrIaqDL/JFrxjiTUNAiAlbanpzCKe//TcbkCebBp60qOZhLa2oZXfX26z7xuIMG3dX1t7XNg4rO9Y8s3Rga38TuR9SvAoXALrT1hQDZSjPHd3RxLQg7HvIzLyXC8COWyzHfBWpVTJIrqsPe6GHKP/6AhRBYQr2qyCZx2F/cfef1y/RZOWORhcSH++HVJTO3Is7Bt4L9TWQOLeT5+dVRyA5H/xl66VGgkmGLq8F6zYg6C50GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvZ17tvFz2QyR8Qy0cYZQAspbzEnGEl2NsdqE7osCtc=;
 b=GND27lJhrOb6EAanDEOO+a3t31YkXyfD5IL1GOEopLgD0M6+IQ2kDokv3rT45BInHabGSapGdn4+vUt47Y/QJs40Zyn7MmQZLyMlnEwG9IjxEXbHCUpUZ6k/87ywoMD3vQoo9hXt6fC6A6n7H6ncZTarb9VrPIPtuwppmWISYmdxY41v2k1Vng0w/LWRaF8Jnk968HLvS52D+J1B1ujqQRjsnfwVR4uYNW0YQ+tatEACSoX6+29cGmWviTli74y1UPluNGl6nzJ4z9/5v5BwqqAYz6JOjiW/j8c0dZ7t7UTDoI9K+J+1FKD1EVxlLMd7PwPG7Vew+JjYV7H00q96yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvZ17tvFz2QyR8Qy0cYZQAspbzEnGEl2NsdqE7osCtc=;
 b=GROUacCMewDkhEfBGuP/M0bGz79UpX6aLqQcD5VK7yim8HUUUGPeOfRZ5eCHmqjYt18A0cv3AtSPUXkqx5asV77Q6raVJrm7fl8EOTjkQUDpstLL5MZ42wRzp4ni71PvuOYNMufF1FAJwVkujm9P1mXA+K/K0NJj+vBhITlgosns6sa7UOSieDt0RdEBQ/bvvzsKLHi2CUaqh0E6EuQfUWdGHPv3RNCoWFMqNpP2nSZLoWND1TUNbD+TyUu0vmbUozaB1eygqL1/9pDGIjjUbY8zwg2Wuq0CHPR6wi4cjP/1YMEs5tMCUO005S2mTVzlR3uguVLIx1TURpM/hsoyJQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 6/9] hw/arm/aspeed: Introduce AST1040 A0 SoC model
Thread-Topic: [PATCH v2 6/9] hw/arm/aspeed: Introduce AST1040 A0 SoC model
Thread-Index: AQHc7AeiOVn0aYf8U0i+aVjJmK/kmA==
Date: Mon, 25 May 2026 05:30:45 +0000
Message-ID: <20260525053036.3305181-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 88011879-1172-417c-caf9-08deba1ec57a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 3ehCu2rl0eiGztDLKa9r8bHgFwn3EA6AR1XO3BbaCG1AJHZF3DDiJ2xVb85XGEEbldwpCk5TEHsHkxnuRZ188cMiop/Fio2bFqxUZWzdvKAC5FBLDxfKXZBIU+an55IpWCNqczvUpa0wCAeZDI0MjKIRYfDjX7fpFFwxMj0s56sdE9Lv0riEApMQKCINv3y+7E2GZT4y11aHat7PkIstLSTnkdte4Zw1eoM9d3gLiG+jjBTNPicYSQA6sVSG/RvTsx6U/LWuCyT4VmxPv6YcJkDO/imxPXztd0p1QeitzTg6514xaKSFMw2auQTRBYF3yiQeFghlX7xduOTbPTsrOW8blCuLsMY5J6zndaCwE6U1IuRMmAU6MO7pBmJKdXnEssCRrXSIKsBrElWPLsje6EVZ2vf6sNQL0383bz9obs7+B9kl67WBePz2UpzkENDDREtoDSnkmY7H+CSLCIDdEzpy8+mGTUOHhniIE0itCTah1shsDW55i9zkfecZ8hB1Lz/YuLzDLici5hV+ralzO9haPihIuE38s0njY3C7Y9An7dGkf6GHagqmNe0p1sTT1LZF/ubFnA2tsu1gGxHOBu7eZuAOpHch0l1MbW2L+lIQB3zFvsm6l9BnFZLKMgRIEmdJcWRshJG0yUEdF0kOSgDk8T0oZWagcrVx5svcpQrvJUrNsigzOgDUuL2h5S/kqUyXAF3U/NtrJJTnFtGn5cpR8+UXghI5BRYZNaGEaN6eGbsBUPSCsBdRezlvYrd+z22sanraOwMpWcBQJRj4wA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lLteXcJCE3JD8TUEPMrqwciBsKokrtFSyXqyVFanzJgj2wr4GGEghEZe+J?=
 =?iso-8859-1?Q?zJTNaDMnqTH2w8uVV/kb1eNxvJVqO6o4wuZGfYmKbSIuKP6XTjuJ5dyrN3?=
 =?iso-8859-1?Q?SGM1hIdP7w/eDd9GM0Y9zaXtGSWtXKVDmraGuCGXyCwsRY/v33va32FQhM?=
 =?iso-8859-1?Q?1seWIgGKn7chmkXNOAzBGp/Ma9JhmgK6J8cMJ6Pe+GPYmbGIX3jkucWCB1?=
 =?iso-8859-1?Q?k0S/yEvKDLer/rphKtXR7hk9QwWr9IqNw9ePc/YsJwYX/uq3m3muWfmECJ?=
 =?iso-8859-1?Q?Sq6ap6ZSMWA96kMsRMjLG7h8lx5sY9mI4sGgyryEj13UaJckDfIN01pvde?=
 =?iso-8859-1?Q?sZEsU+PNR8l2Nyo0/zi4Y2H1cFu1PI7SSAlgyo706eREsnXKtDHl7YGk/7?=
 =?iso-8859-1?Q?gJv441qZcco4fHz78aPk/B3jTkGzORUROERQnjU6iI0wiGG30X1/qaWZyj?=
 =?iso-8859-1?Q?LoYeWz+V/jg4OCrXhdzVWPBD36r6Di0q0c6ZZQN8yBQwRlARxCJtmw9eFE?=
 =?iso-8859-1?Q?0AxOpjEdTDYOgLnJIlA+F3PUlIY8gsUvaI6HPEHxRRb7MBxRtF9/snhN9U?=
 =?iso-8859-1?Q?g5hbEmIV4BNytP4RBl/y4Up0/DuWItf5x9c2ZvgvjMmQsnxB08fx8HMq6Z?=
 =?iso-8859-1?Q?PbBGx97Gi5/UDSY4xwck6bKAqprxpUZ7tunEYFaCjskHhI2fikUdybiReQ?=
 =?iso-8859-1?Q?fUFclV10i3/IBRBLT8zCTZJs/u2uK9MtYP7lqCLKb0LKVuEdA+/IQM0WkI?=
 =?iso-8859-1?Q?Re5y08pe8CPeAIMOJxhs4CHvuCFsJt2yBoQcRabp4nunFRsupbrdCn0IZe?=
 =?iso-8859-1?Q?f96YPjuJS22Uj5sm4fQgOQHOd9O8iZm6j6oDUxdPwas6Fk6UB2U/vpwQfK?=
 =?iso-8859-1?Q?lVVZP5JLhHxnZWErbesHa8d4Ydd+7QPEIm7sl0jRBr/neqqANfbHXShar4?=
 =?iso-8859-1?Q?xGm0YQIKdpCs5Qtfa07RTkNVJi3Eqy/rcWp4ejzr+cyKyB/hkjq4b1kJ8A?=
 =?iso-8859-1?Q?iCtJs9Ud9YlRg4Y2uIGjxB4A493jlVqcbxwBDoKtSJYjOUfDNwC8QDs1NQ?=
 =?iso-8859-1?Q?S61bFCkReaoFKZz1XNmsd0Zzhq51UwcTIw9WKdhXtlG6+hs7UG0xIkV2iU?=
 =?iso-8859-1?Q?1h90km9r5fWVsB0JRImeoYUa9j1mnJ8YeUEu3wOWwcpEcJuxpCWnYawISq?=
 =?iso-8859-1?Q?wX/0diKnNZYgmboQTC/svwqYUy3IQ4yeBNPykaQd8LIp8jkrEsIOF+WIXQ?=
 =?iso-8859-1?Q?4bc7atAKZGse+kusTS1hTIOq+daF3mbuOsPlwwbUrlVgwY6m+z+darntpQ?=
 =?iso-8859-1?Q?DLt1J7TB/npF2RjytRQSEk8pCm1DkDuYtfaK2/o2zgLMKSBZv7Ad4ei4n0?=
 =?iso-8859-1?Q?aZW+nWswnFdmn/CvLHxRoe5qtGD8iOH/eTM5mRkOuhFb59JA3B3bvZIF49?=
 =?iso-8859-1?Q?akHQhrLoCqaOCcJGuhpPGPVDhi79mshN51ixGbIwXk0MfZkmmWDOPCb84d?=
 =?iso-8859-1?Q?Eoq78kJKOzrsOLDhILq3EfMero/SxovaaHx2oH80FleQ8IC5RwtmPL8j5j?=
 =?iso-8859-1?Q?xcoKUEeakGa0Gjpf/kas04VIVL2uZyLl9oMGvr4pUt+74Lk7KcOYued2dP?=
 =?iso-8859-1?Q?VHRpJZfPap0Dhc6Y63QPNwHOxq/qk+vGxHiT7klVn2t26MX7m5tK4L5miN?=
 =?iso-8859-1?Q?Vhwnt6JylbfNDe0kj89SQyrXd4Kn/pP47FujFh3+LCzwjhGFKDLLIyCjat?=
 =?iso-8859-1?Q?Pefvfe06+Et74WtUlK7VlHAGYPrFie9aars2Ko0au0+gzvuHPcnqwiEYH7?=
 =?iso-8859-1?Q?krFKWwVZIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EWivQ8weXlGyvJ/ooqJY0Qbxpk9R2mbgRVfzqoxAhD0O81f+NmihOYUEiHJE8xZX/DO96R0q/lRLhEIvQvc3yB66GsLgFvqK0vK/mrM0GlihIoB79Ng0cotP0JTYFtkobRtht5707U3/CZTLT7xnOX+gkMRIHFmxwlqFwH/Mn4P1hfcUJfVhHiV+15uh0/sc6eFk9yyD7yQYNW1oQI9SKSU1ICaBHd7FWcZ5Jh1uUGvR/kxQdMTyjALP6ydcMfYH2HYXnm34mH0DKIxaGMQPALXK7aDsDCH6e4aW5kEvGVv8G3h3iNfyiXtBC7as3Z65m/GMfdY0vHHCAjpNsKowBA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88011879-1172-417c-caf9-08deba1ec57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:45.7841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nSIAv0x/QPgGwMs46P/K6x9CsAYbwlMJSym25X/zukuME0blidyH3u2pQLmJ41wRBzW0bVFpQFSBFdlMN3sPWGEnwHI0xcqE4j59YNMKRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AST1040 is based on an ARM Cortex-M4F CPU core. Since QEMU=0A=
currently does not provide Cortex-M4F support, use the existing=0A=
Cortex-M4 CPU model as a temporary replacement.=0A=
=0A=
This initial implementation provides the basic infrastructure=0A=
required to boot firmware and run a minimal firmware shell,=0A=
including:=0A=
=0A=
- ARM Cortex-M4 CPU integration=0A=
- NVIC interrupt controller support=0A=
- Internal HyperRAM and SRAM memory regions=0A=
- SCU integration=0A=
- UART devices and interrupt wiring=0A=
=0A=
AST1040 SCU behavior is compatible with the AST2700 SCUIO model,=0A=
so reuse the existing AST2700 SCUIO implementation directly=0A=
instead of introducing another identical SCU model. This reduces=0A=
duplicate code and helps minimize long-term codebase maintenance.=0A=
=0A=
Several peripherals are currently modeled as unimplemented=0A=
devices and can be added incrementally in future updates.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 254 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/meson.build      |   3 +-=0A=
 2 files changed, 256 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040.c=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
new file mode 100644=0A=
index 0000000000..8efcdad8f6=0A=
--- /dev/null=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -0,0 +1,254 @@=0A=
+/*=0A=
+ * ASPEED AST1040 SoC=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "system/address-spaces.h"=0A=
+#include "system/system.h"=0A=
+#include "hw/core/qdev-clock.h"=0A=
+#include "hw/misc/unimp.h"=0A=
+#include "hw/arm/aspeed_soc.h"=0A=
+=0A=
+static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
+    [ASPEED_DEV_SRAM1]     =3D 0x00000000, /* Hyper RAM */=0A=
+    [ASPEED_DEV_FMC]       =3D 0x74000000,=0A=
+    [ASPEED_DEV_SPI0]      =3D 0x74010000,=0A=
+    [ASPEED_DEV_SPI1]      =3D 0x74020000,=0A=
+    [ASPEED_DEV_PWM]       =3D 0x740C0000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x74120000,=0A=
+    [ASPEED_DEV_SRAM0]     =3D 0x74B80000,=0A=
+    [ASPEED_DEV_ADC]       =3D 0x74C00000,=0A=
+    [ASPEED_DEV_JTAG0]     =3D 0x74C01000,=0A=
+    [ASPEED_DEV_SCU]       =3D 0x74C02000,=0A=
+    [ASPEED_DEV_ESPI]      =3D 0x74C05000,=0A=
+    [ASPEED_DEV_JTAG1]     =3D 0x74C09000,=0A=
+    [ASPEED_DEV_GPIO]      =3D 0x74C0B000,=0A=
+    [ASPEED_DEV_SGPIOM0]   =3D 0x74C0C000,=0A=
+    [ASPEED_DEV_SGPIOM1]   =3D 0x74C0D000,=0A=
+    [ASPEED_DEV_I2C]       =3D 0x74C0F000,=0A=
+    [ASPEED_DEV_I3C]       =3D 0x74C20000,=0A=
+    [ASPEED_DEV_UART0]     =3D 0x74C33000,=0A=
+    [ASPEED_DEV_UART1]     =3D 0x74C33100,=0A=
+    [ASPEED_DEV_UART2]     =3D 0x74C33200,=0A=
+    [ASPEED_DEV_UART3]     =3D 0x74C33300,=0A=
+    [ASPEED_DEV_UART4]     =3D 0x74C33400,=0A=
+    [ASPEED_DEV_UART5]     =3D 0x74C33500,=0A=
+    [ASPEED_DEV_UART6]     =3D 0x74C33600,=0A=
+    [ASPEED_DEV_UART7]     =3D 0x74C33700,=0A=
+    [ASPEED_DEV_UART8]     =3D 0x74C33800,=0A=
+    [ASPEED_DEV_UART9]     =3D 0x74C33900,=0A=
+    [ASPEED_DEV_UART10]    =3D 0x74C33A00,=0A=
+    [ASPEED_DEV_UART11]    =3D 0x74C33B00,=0A=
+    [ASPEED_DEV_UART12]    =3D 0x74C33C00,=0A=
+    [ASPEED_DEV_WDT]       =3D 0x74C37000,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 0x74C3A000,=0A=
+};=0A=
+=0A=
+static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
+    [ASPEED_DEV_ESPI]      =3D 10,=0A=
+    [ASPEED_DEV_I2C]       =3D 64, /* 64 ~ 77 */=0A=
+    [ASPEED_DEV_ADC]       =3D 80,=0A=
+    [ASPEED_DEV_GPIO]      =3D 82,=0A=
+    [ASPEED_DEV_SGPIOM0]   =3D 85,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 92,=0A=
+    [ASPEED_DEV_I3C]       =3D 96, /* 96 ~ 103 */=0A=
+    [ASPEED_DEV_WDT]       =3D 112,=0A=
+    [ASPEED_DEV_FMC]       =3D 121,=0A=
+    [ASPEED_DEV_SPI0]      =3D 122,=0A=
+    [ASPEED_DEV_SPI1]      =3D 123,=0A=
+    [ASPEED_DEV_PWM]       =3D 125,=0A=
+    [ASPEED_DEV_UART0]     =3D 135,=0A=
+    [ASPEED_DEV_UART1]     =3D 136,=0A=
+    [ASPEED_DEV_UART2]     =3D 137,=0A=
+    [ASPEED_DEV_UART3]     =3D 138,=0A=
+    [ASPEED_DEV_UART4]     =3D 139,=0A=
+    [ASPEED_DEV_UART5]     =3D 140,=0A=
+    [ASPEED_DEV_UART6]     =3D 141,=0A=
+    [ASPEED_DEV_UART7]     =3D 142,=0A=
+    [ASPEED_DEV_UART8]     =3D 143,=0A=
+    [ASPEED_DEV_UART9]     =3D 144,=0A=
+    [ASPEED_DEV_UART10]    =3D 145,=0A=
+    [ASPEED_DEV_UART11]    =3D 146,=0A=
+    [ASPEED_DEV_UART12]    =3D 147,=0A=
+    [ASPEED_DEV_JTAG0]     =3D 162,=0A=
+};=0A=
+=0A=
+static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(s);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+=0A=
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_init(Object *obj)=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(obj);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(obj);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    int i;=0A=
+    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);=0A=
+=0A=
+    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);=
=0A=
+=0A=
+    /* AST1040 uses the AST2700 SCUIO model */=0A=
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);=
=0A=
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);=
=0A=
+=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap=
1");=0A=
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap=
2");=0A=
+=0A=
+    for (i =3D 0; i < sc->uarts_num; i++) {=0A=
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_M=
M);=0A=
+    }=0A=
+=0A=
+    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
+    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
+    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
+    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "jtag[0]", &s->jtag[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "jtag[1]", &s->jtag[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)=
=0A=
+{=0A=
+    Aspeed10x0SoCState *a =3D ASPEED10X0_SOC(dev_soc);=0A=
+    AspeedSoCState *s =3D ASPEED_SOC(dev_soc);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);=0A=
+    g_autofree char *hyperram_name =3D NULL;=0A=
+    g_autofree char *sram_name =3D NULL;=0A=
+    DeviceState *armv7m;=0A=
+    Error *err =3D NULL;=0A=
+    int uart;=0A=
+    int i;=0A=
+=0A=
+    if (!clock_has_source(s->sysclk)) {=0A=
+        error_setg(errp, "sysclk clock must be wired up by the board code"=
);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* AST1040 CPU Core */=0A=
+    armv7m =3D DEVICE(&a->armv7m);=0A=
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
+    qdev_prop_set_string(armv7m, "cpu-type",=0A=
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));=0A=
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
+    object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
+                             OBJECT(s->memory), &error_abort);=0A=
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
+=0A=
+    /* Internal SRAM */=0A=
+    sram_name =3D g_strdup_printf("aspeed.sram.%d",=0A=
+                                CPU(a->armv7m.cpu)->cpu_index);=0A=
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
+                           sc->sram_size[0], &err);=0A=
+    if (err) {=0A=
+        error_propagate(errp, err);=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],=
=0A=
+                                &s->sram[0]);=0A=
+=0A=
+    /* Internal Hyper RAM */=0A=
+    hyperram_name =3D g_strdup_printf("aspeed.hyperram.%d",=0A=
+                                    CPU(a->armv7m.cpu)->cpu_index);=0A=
+    memory_region_init_ram(&s->sram[1], OBJECT(s), hyperram_name,=0A=
+                           sc->sram_size[1], &err);=0A=
+    if (err) {=0A=
+        error_propagate(errp, err);=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
+                                &s->sram[1]);=0A=
+=0A=
+    /* SCU */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+                    sc->memmap[ASPEED_DEV_SCU]);=0A=
+=0A=
+    /* UART */=0A=
+    for (i =3D 0, uart =3D sc->uarts_base; i < sc->uarts_num; i++, uart++)=
 {=0A=
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],=0A=
+                                     sc->memmap[uart], errp)) {=0A=
+            return;=0A=
+        }=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,=0A=
+                           aspeed_soc_ast1040_get_irq(s, uart));=0A=
+    }=0A=
+=0A=
+    /* Unimplemented peripherals */=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
+                                  "aspeed.pwm",=0A=
+                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),=0A=
+                                  "aspeed.espi",=0A=
+                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),=0A=
+                                  "aspeed.udc",=0A=
+                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0])=
,=0A=
+                                  "aspeed.sgpiom0",=0A=
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);=
=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1])=
,=0A=
+                                  "aspeed.sgpiom1",=0A=
+                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);=
=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),=
=0A=
+                                  "aspeed.jtag0",=0A=
+                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);=0A=
+=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),=
=0A=
+                                  "aspeed.jtag1",=0A=
+                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);=0A=
+}=0A=
+=0A=
+static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *=
data)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(dc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize =3D aspeed_soc_ast1040_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev     =3D AST1040_A0_SILICON_REV;=0A=
+    sc->sram_size[0]    =3D 128 * KiB;=0A=
+    sc->sram_size[1]    =3D 16 * MiB; /* Hyper RAM */=0A=
+    sc->uarts_num       =3D 13;=0A=
+    sc->uarts_base      =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap          =3D aspeed_soc_ast1040_irqmap;=0A=
+    sc->memmap          =3D aspeed_soc_ast1040_memmap;=0A=
+    sc->num_cpus        =3D 1;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_soc_ast1040_types[] =3D {=0A=
+    {=0A=
+        .name           =3D "ast1040-a0",=0A=
+        .parent         =3D TYPE_ASPEED10X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast1040_init,=0A=
+        .class_init     =3D aspeed_soc_ast1040_class_init,=0A=
+    }=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_soc_ast1040_types)=0A=
diff --git a/hw/arm/meson.build b/hw/arm/meson.build=0A=
index 80068f70bb..fa3a848492 100644=0A=
--- a/hw/arm/meson.build=0A=
+++ b/hw/arm/meson.build=0A=
@@ -62,7 +62,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_ast2600_gb200nvl.c',=0A=
   'aspeed_ast2600_rainier.c',=0A=
   'aspeed_ast10x0.c',=0A=
-  'aspeed_ast10x0_evb.c'))=0A=
+  'aspeed_ast10x0_evb.c',=0A=
+  'aspeed_ast1040.c'))=0A=
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: =
files(=0A=
   'aspeed_ast1700.c',=0A=
   'aspeed_ast27x0.c',=0A=
-- =0A=
2.43.0=0A=

