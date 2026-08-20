Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2B9C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxsw-00029e-FR; Thu, 20 Aug 2026 04:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsv-00029J-2E; Thu, 20 Aug 2026 04:12:25 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsr-0001n5-J9; Thu, 20 Aug 2026 04:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fww/J8p0vXIPGo2k3W25HBSluDQ/HdqUSIHrVwKgBWsPlUkBiCmZEI7G7v6S6OGsBNfCrE3NnjjZGeCkBYPcnctDWYahSTwJiU5w443UJ5O3VpCCTpK5IVW2pSxGRhkXutI2sZRWe+1WwuqMUOOv0GCsCGe7bREFg6xh7GVdi6c1dbPlSYT1odfCj9QEhCnFnd22/Ov5w+dQzCTjYGDTMq0eEb2gB6TjONsdTqF5qyYK+1uZBHIy6dZ3fRLGenQjRy+TFQ0kzB8lHhAHri5LP7jXzqXNc/ow7kxqOLztKHdeQ9wMkVphpE4t3fP/xBIeSVmtsapYO3fcU0JlOT4d8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q1pGueYLUyYTXY4N/1a82fyMGH+6fLDGpvDo7WfpMA=;
 b=vliDdyTmqtNsC2kjBl55INI2qsoFIQynEBYhoVWUkOQtEO5my/qLUg+jG7TP/QmX8KYneMiGU73EGHsH/rl+eU96sv4U5yIFPrkUFOt6Vk08tOKF+Uk/Agk11AZFjMCQQG4B0CPYjW5k+APL7t2xPyR+/DPrGBC/0+uVYEnd69a4JufuXUfQyP8Djh071xq3QWl3Du1EyVtBSYYz9PSTV6JsbT4UASV1+loYm4japZI2mFCO+mglbXFOfVQREZ7c4DoGuoROyDrH/OvK7d6SnC+VTDbkxkn+0DBp5lFuz/+RrbxWaAP+HTn9XCUv+Q7ldC3XUawK/4MNLMrUGKKw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q1pGueYLUyYTXY4N/1a82fyMGH+6fLDGpvDo7WfpMA=;
 b=pdTsjK2Aczxwz/B3F1klxCpnOb0YcnO8N7N1efRCa1UspzxsADgZWMVER+EhoChGjusmgZ8jVIKy9A/sgerb6tVum2PDXBb0vUOLCOtlXaY3YbBaExyXmqNLY4AYuujxnBcewXHu/p3O/vPwlUqVYza+g98dfH1QFBgXCRPdh4gc0IP4LwAz3E9E6quZBWylGXubMk8bhtze67ZI88BZYHGfr6nEHersHOfSykDI1BVf38veIjSQAUkvBp73wbWu+L6X1wJjkmEQyB6LP2yCZUu/klyQRh+S8u9HuXLsYSW89t3Ik5XhDh3Sw8O/nz6rXmO70Q/6JmBlzGmPwNS/wA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5661.apcprd06.prod.outlook.com (2603:1096:400:28e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:12:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:12:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/4] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Topic: [PATCH v2 1/4] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Index: AQHdMHuYKgbwzsHZCEaQi7SLQU0AFQ==
Date: Thu, 20 Aug 2026 08:12:09 +0000
Message-ID: <20260820081206.3353463-2-jamin_lin@aspeedtech.com>
References: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5661:EE_
x-ms-office365-filtering-correlation-id: ea08431c-ebee-4e67-7c35-08defe92bb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|38070700021|6133799003|3023799007|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 485IQ0QS+Sp+eRlJlXtwYAPl3TURsJgDWjYyeV7+y+l4b/sTf1cvv8kIY4FIw2nr1UDa3EGefUuR/kPPKl+/BJc9foZwIpbkNC3R0m+tupyPT1TWYp4faR0UuBM2SKo9NBbK4YDZoue36elyJkj36jwUmLENzKes1F4zNl7oZjrNp4gVexD+1rWd85ffAbB1y9lyy/pjtfg0VCwzb7UWmGEoTDulIM/Rkh3Kd4+Fab0xfBG52mO/diqQrndXi8M7CPfOOCBEu0kHVBuoJ9ejhtdDjbLPk+4ePvdKWEwz7jF0TGLy09nT6Lb3pr1g5bsuWe/75VgoCFleyoJiYz0oWTgn5VZ+Jp5aL1ZoXyo9FALaNoieNCIiaTLYJMrfbjMDsKwuJFhISeebk5K6e7eTgxcm7F9SYt43aYSmOAxlDdE2J2uzavEZ9c2Z2LASsWbfqag5EC4atIqNvukNRBKd278wKsl8ifyskyflPNYyoaMzjzZ7C3m048RMp88KnU5nS+YwLD7hq41MqG2J07+GkZbf7KliHU4A/avrastJFj94AE56ImFq1DUnozSYAuduotlxF7c3hwHaOKC+3ntzqBRAY5DCzNwtNWQZshUaUmPosqU8P92wsk/d+HypAnZNDyx738AnaYGkLEuSE0Do7qdoFexYXusV0pKyUJeBj9l0moth8pxwk8aPy5FYSQKR75/A/AN7Sn/q3kfiD8SexfpQ9H7mTmHFZxG1pbI8ifI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(38070700021)(6133799003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CwZDtQuvigbk42neAJfvJV+EoNV7EUyzx9+IIzxWs6G9CcKfetjEqgp8qt?=
 =?iso-8859-1?Q?F3A1dzGq9ujUyutL68/pGmVaPKFwM6JkuVlQcwws4a4+4ByEHuAFHgOZXW?=
 =?iso-8859-1?Q?7h2GNXMOYgD3XsFnCa8VbjUq59xhp87vzliyhQ7n3CX9vacKhlbkIks2E8?=
 =?iso-8859-1?Q?IIvn2nGyjlB4mjLRHRVbmFyTFrHCm00UAVZt0ocKQZG3lpW1s7JHCvdYDI?=
 =?iso-8859-1?Q?QmWWZjYjiagph1OmlAh3ajmX+SlYi75ox69w9A0FTY4ObmKDGx2ZECCIjx?=
 =?iso-8859-1?Q?2vphi8qLqzmzveJp7oJarSGVEwCh3i7HzhlxkmJ232OHnRdXySwiN3StUl?=
 =?iso-8859-1?Q?yFQDxvE1S3GDchrm8PPWPS2GxtSqiqtnBTxTVOxps5ibWwmaGDbIZXybMD?=
 =?iso-8859-1?Q?AwMZjUOnooINaR6AdKT5iQhawwZSj2UhZkglIQ9ivqXkh+3wj3/JffUzQD?=
 =?iso-8859-1?Q?ASPmsNPeHZVJGWzbza0V6a5+Du5Zd5r83wYAgMfC3tAOZU7KhHvPNt1tgo?=
 =?iso-8859-1?Q?AHmOAfp57ynCSSNIGQN/84cdlUkvhtTpwhbJPY6VBnUrsCiF/NIQxpFbMH?=
 =?iso-8859-1?Q?3b6QS2oxfXgAMHXd7OwY+JamReFLk5eOXnwh5F6hla82XfRGCi8rNggzOq?=
 =?iso-8859-1?Q?BKnqh2p9eM7OQd5Cb7Id1vOkOR3+4h1kTkFic6Pspxics5h8zjZX5iAktP?=
 =?iso-8859-1?Q?MQJG3ypo+nOhglF9R6KZ7SUaF9oWzD4ano26vrySQzpc0wgk6oEMDLcXgh?=
 =?iso-8859-1?Q?J0fX4Cszy8W1+TgjyrMhX+CM30qJfzehkAVTxrwPGhqtO397LVhQwhgca1?=
 =?iso-8859-1?Q?8fQvB6ZX7pHSWysoVTN+iWucbKu/3rEsWrrIebeldCW2Jr4sS0kEJs3H6+?=
 =?iso-8859-1?Q?8uUK/8CxfrB0vvJSdOmMNjUHrPuDsr9jJtShCqlMblKmzVWqK/vcqVGdEm?=
 =?iso-8859-1?Q?rkxh4wEkUPSMln0lQrdvnd6jLBDTVF5as0Tp8re0JlbEMTwxHQ16QUr33b?=
 =?iso-8859-1?Q?qy5k0ubF0Bs1ClqwXqUYJuZiX/MvioZ+GnHB6jo/5m1wRVviiZQrcsRGD6?=
 =?iso-8859-1?Q?APfuAqschbJ9qiSdzUk9mRPirScbwam23e8A9NojeP5FA0rwMEMXvlOnAU?=
 =?iso-8859-1?Q?HDAfA0FnFnsZKGYWFjlx5sMAFK9MirwHkX+KeurOVOdNm4lHPzjKKXw1b6?=
 =?iso-8859-1?Q?Of3pYeo178ntPG5E04CcqymFvoVINeKBj5w85Uq8azmrk1gfRBvBaU0nLC?=
 =?iso-8859-1?Q?FqAzjnaj0baHA6G/A0vQIzDpbZxVtmeWM42rOYpRj4918kkCLqMMS8GVTr?=
 =?iso-8859-1?Q?scZFvp9a4MiNkUOhuIPB9NsAaf403h8GSXiZt5S4clVwHmMOC3wJ3XHUx+?=
 =?iso-8859-1?Q?aHe1Dk/sA6mFG4FQUXNJQnBsvdKqC+sIgXp8/1CcOpyfZMQ2/FK9y+bFpF?=
 =?iso-8859-1?Q?rxhRUyKMNj3kpeCuYG99CKcRfz+2YC7t9E2zgV+IBtxv80sNwaDqxmHoSW?=
 =?iso-8859-1?Q?UUobrXzq01hGvfxJWW82RndZiqmSycjGU9UF8x7iUkXXXIJDVe2tbiB/5q?=
 =?iso-8859-1?Q?NwL2Nrn6lrQtLK+3fMpr8w/Zu8pV930IgrDC0z7wEc5NJvlWo1t8uYXdVw?=
 =?iso-8859-1?Q?8CaFBzxUAsFLE4cIQU6x2fIGQ4uTdqEneaAGV12wPxP8XFPaPiXzGU5CHi?=
 =?iso-8859-1?Q?cAED7fUr2qfAGawQ/Bxoh7KfYuygjsqo53rf5vIHnRg8qrd4fBwnYzWhgS?=
 =?iso-8859-1?Q?3H1MaWY8wQ5n8cO++gf44gbK/yk3EWtHhuZWMD/vWv2WEGSLphvkM9T/OG?=
 =?iso-8859-1?Q?kECKwVEKQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VpESvpR9VkiCzWtBCtqpJ1BJosiv7MYhLFi4m6matoFfCwoa84VuRIsyaPzIA/496/UVOqF9i+5cWQDio5t5A3HfEm3G++J+NT1jPtvJmxo4kiDVdoGnO6yuN0bts6ShoxUoqcBryVi7mbIq7vfyLur6E1m4eueAmhv0eYZtpSU36ckba/Y01BwBSpoCU9kYeQQ/VoeFKjKnNnoc9QRCYcP5lRNH1WCLFCd2OPbaPKBK6xauWOVX4mjWOu49xGNKuKW5H3DIrrAeAu/Tj0yKzy7488KQtzWW3C6Ywjqn8IlXS/1K30DBKcyIiHgfpJyFsEdghtsUJbgjGcuidbZgOA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea08431c-ebee-4e67-7c35-08defe92bb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 08:12:09.2183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwHit2yK0/obKJutGxDUobAZrUxt/hrKntN3ntCJmUs0Nz+qludjC/lRoh0DsWSnifKqKyMk+S8fu8f2H3JNN9BDmP9YO3yw4YG6CcD7Kik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5661
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

Introduce a ASPEED ACRY model, which performs RSA modular=0A=
exponentiation. The datasheet documents the engine as=0A=
supporting both RSA and ECDSA, but ECDSA is broken on this=0A=
hardware, so only RSA is modelled.=0A=
=0A=
The engine DMAs its operands (data, exponent, modulus) from a guest=0A=
DRAM buffer and writes the result back into a memory-mapped SRAM=0A=
region. Both regions share the same interleaved byte/dword layout:=0A=
repeating 12-dword blocks of [4 dwords exponent][4 dwords modulus][4=0A=
dwords data], index 0 holding the least-significant word/byte of each=0A=
value.=0A=
=0A=
The engine accesses DRAM by relative offset, so the CPU-visible=0A=
address written to the DMA source register has its top (base) bit=0A=
masked off.=0A=
=0A=
The modular exponentiation itself is delegated to QEMU's generic=0A=
akcipher crypto API (crypto/akcipher.c) using raw (unpadded) RSA,=0A=
matching what the real hardware performs - PKCS1 padding is handled=0A=
by the guest's software crypto stack, not by this engine.=0A=
=0A=
The RSA public-key operand DER encoding needed by that API is built with=0A=
crypto/der.h's generic encoder. Raw (unpadded) RSA is only implemented=0A=
by that API's libgcrypt backend (its nettle backend rejects raw=0A=
padding).=0A=
=0A=
When that support is missing, the engine still completes and raises its=0A=
completion IRQ as real hardware would, but produces an all-zero result=0A=
so that whatever signature check the guest performs on it fails cleanly=0A=
instead of the guest hanging forever waiting for an interrupt that=0A=
would otherwise never come.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_acry.h |  39 +++=0A=
 hw/misc/aspeed_acry.c         | 455 ++++++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build           |   1 +=0A=
 hw/misc/trace-events          |   6 +=0A=
 4 files changed, 501 insertions(+)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
=0A=
diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h=
=0A=
new file mode 100644=0A=
index 0000000000..5ca80deec4=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_acry.h=0A=
@@ -0,0 +1,39 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef ASPEED_ACRY_H=0A=
+#define ASPEED_ACRY_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "system/memory.h"=0A=
+=0A=
+#define TYPE_ASPEED_ACRY "aspeed.acry"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedACRYState, ASPEED_ACRY)=0A=
+=0A=
+#define ASPEED_ACRY_NR_REGS     (0x400 >> 2)=0A=
+/* Max size of the "data" (message) field within the SRAM buffer. */=0A=
+#define ASPEED_ACRY_DATA_MAX_LEN 0x800=0A=
+#define ASPEED_ACRY_MAX_BITS     4096=0A=
+/* Max exponent/modulus size for a 4096-bit RSA key, in bytes. */=0A=
+#define ASPEED_ACRY_MAX_BYTES    (ASPEED_ACRY_MAX_BITS / 8)=0A=
+=0A=
+struct AspeedACRYState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion iomem;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint32_t regs[ASPEED_ACRY_NR_REGS];=0A=
+=0A=
+    MemoryRegion *dram_mr;=0A=
+    MemoryRegion *sram_mr;=0A=
+    AddressSpace dram_as;=0A=
+    AddressSpace sram_as;=0A=
+};=0A=
+=0A=
+#endif /* ASPEED_ACRY_H */=0A=
diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c=0A=
new file mode 100644=0A=
index 0000000000..1f53074648=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_acry.c=0A=
@@ -0,0 +1,455 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * The datasheet documents the ACRY engine as supporting both RSA and=0A=
+ * ECDSA, but ECDSA is broken on this hardware, so only RSA is modelled=0A=
+ * here.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/cutils.h"=0A=
+#include "qemu/log.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "qapi/error.h"=0A=
+#include "crypto/akcipher.h"=0A=
+#include "crypto/der.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(ACRY_TRIGGER, 0x000)=0A=
+    FIELD(ACRY_TRIGGER, RSA_DMA_DATA, 1, 1)=0A=
+    FIELD(ACRY_TRIGGER, RSA_START, 0, 1)=0A=
+REG32(ACRY_DMA_CMD, 0x048)=0A=
+REG32(ACRY_DMA_SRC, 0x04C)=0A=
+REG32(ACRY_DMA_LEN, 0x050)=0A=
+    FIELD(ACRY_DMA_LEN, DEST, 16, 16)=0A=
+    FIELD(ACRY_DMA_LEN, DATALEN, 0, 16)=0A=
+REG32(ACRY_RSA_KEY_LEN, 0x058)=0A=
+REG32(ACRY_INT_MASK, 0x3F8)=0A=
+    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)=0A=
+    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)=0A=
+REG32(ACRY_STATUS, 0x3FC)=0A=
+    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)=0A=
+    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)=0A=
+=0A=
+/*=0A=
+ * Total size of the interleaved buffer. Data is 4 of every 12=0A=
+ * dwords of a block, one third of the buffer, so the whole buffer is 3x=
=0A=
+ * the data region.=0A=
+ */=0A=
+#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)=0A=
+=0A=
+/* Dwords into each 12-dword block where each operand's region starts. */=
=0A=
+#define ASPEED_ACRY_EXP_OFFSET   0=0A=
+#define ASPEED_ACRY_MOD_OFFSET   4=0A=
+#define ASPEED_ACRY_DATA_OFFSET  8=0A=
+=0A=
+static void aspeed_acry_hexdump(const char *desc, const uint8_t *buf,=0A=
+                                size_t size)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_acry_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The interleaved buffer is a series of 12-dword blocks, each split into=
=0A=
+ * three 4-dword regions - exp, mod, data:=0A=
+ *=0A=
+ *   dword in block:  0    1    2    3    4    5    6    7    8    9   10 =
  11=0A=
+ *   region:          \---- exp ----/    \---- mod ----/    \---- data ---=
-/=0A=
+ *   lane:            0    1    2    3    0    1    2    3    0    1    2 =
   3=0A=
+ *=0A=
+ * Successive blocks hold the next 4 dwords of each operand, so operand=0A=
+ * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so=
=0A=
+ * byte b of dword D is at byte D * 4 + b.=0A=
+ *=0A=
+ * Return the buffer offset of byte 'op_byte' (op_byte =3D 0 =3D least=0A=
+ * significant) of the operand whose region starts 'region' dwords into=0A=
+ * each block (0 =3D exp, 4 =3D mod, 8 =3D data).=0A=
+ */=0A=
+static int aspeed_acry_operand_offset(int region, int op_byte)=0A=
+{=0A=
+    int byte_in_dword;=0A=
+    int op_dword;=0A=
+    int block;=0A=
+    int lane;=0A=
+=0A=
+    op_dword =3D op_byte / 4;=0A=
+    byte_in_dword =3D op_byte % 4;=0A=
+    block =3D op_dword / 4;=0A=
+    lane =3D op_dword % 4;=0A=
+=0A=
+    return (block * 12 + region + lane) * 4 + byte_in_dword;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read one operand out of the buffer as a big-endian magnitude.=0A=
+ *=0A=
+ * The operand's bytes are scattered through buf; byte k (significance lev=
el=0A=
+ * k, k =3D 0 =3D least significant) is at aspeed_acry_operand_offset(regi=
on, k).=0A=
+ * Walk from the top down, drop leading zero bytes, and write the result m=
ost=0A=
+ * significant byte first into out[]. Returns the number of bytes written=
=0A=
+ * (the value 0 yields a single 0x00 byte, so always >=3D 1).=0A=
+ */=0A=
+static int aspeed_acry_extract_be(const uint8_t *buf, int region,=0A=
+                                  int max_bytes, uint8_t *out)=0A=
+{=0A=
+    int offset;=0A=
+    int msb;=0A=
+    int len;=0A=
+    int k;=0A=
+=0A=
+    /* Highest significance level holding a non-zero byte (skip leading 0s=
). */=0A=
+    for (msb =3D max_bytes - 1; msb >=3D 0; msb--) {=0A=
+        offset =3D aspeed_acry_operand_offset(region, msb);=0A=
+        if (buf[offset] !=3D 0) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* All bytes zero: the value is 0. */=0A=
+    if (msb < 0) {=0A=
+        out[0] =3D 0;=0A=
+        return 1;=0A=
+    }=0A=
+=0A=
+    /* Copy most significant byte first: level msb down to level 0. */=0A=
+    len =3D 0;=0A=
+    for (k =3D msb; k >=3D 0; k--) {=0A=
+        offset =3D aspeed_acry_operand_offset(region, k);=0A=
+        out[len++] =3D buf[offset];=0A=
+    }=0A=
+=0A=
+    return len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Return a DER INTEGER body for the unsigned big-endian magnitude 'be'.=
=0A=
+ *=0A=
+ * DER INTEGERs are signed, so if the top byte has bit 7 set the value=0A=
+ * would decode as negative; prepend a 0x00 guard byte in that case.=0A=
+ *=0A=
+ * The padded copy is written into 'pad_buf' (caller-owned, sized len + 1)=
=0A=
+ * rather than a local, because qcrypto_der_encode_int() only stores the=
=0A=
+ * pointer we hand it - the bytes are not copied until=0A=
+ * qcrypto_der_encode_ctx_flush_and_free() - so the body must stay valid=
=0A=
+ * until then. Returns a pointer into 'be' or 'pad_buf' as appropriate,=0A=
+ * with the body length in *body_len.=0A=
+ */=0A=
+static const uint8_t *aspeed_acry_der_uint_body(const uint8_t *be, size_t =
len,=0A=
+                                                uint8_t *pad_buf,=0A=
+                                                size_t *body_len)=0A=
+{=0A=
+    if (be[0] & 0x80) {=0A=
+        pad_buf[0] =3D 0x00;=0A=
+        memcpy(pad_buf + 1, be, len);=0A=
+        *body_len =3D len + 1;=0A=
+        return pad_buf;=0A=
+    }=0A=
+=0A=
+    *body_len =3D len;=0A=
+    return be;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DER-encode a "RsaPubKey ::=3D SEQUENCE { n INTEGER, e INTEGER }" (see=
=0A=
+ * crypto/rsakey.h), the format expected by qcrypto_akcipher_new(). n and =
e=0A=
+ * are minimal big-endian magnitudes (as produced by=0A=
+ * aspeed_acry_extract_be()); the engine does a raw modexp, so the guest's=
=0A=
+ * exponent is always encoded here as the public 'e'.=0A=
+ */=0A=
+static uint8_t *aspeed_acry_der_encode_pubkey(const uint8_t *n, size_t n_l=
en,=0A=
+                                              const uint8_t *e, size_t e_l=
en,=0A=
+                                              size_t *out_len)=0A=
+{=0A=
+    QCryptoEncodeContext *ctx =3D qcrypto_der_encode_ctx_new();=0A=
+    uint8_t n_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    uint8_t e_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    const uint8_t *n_body;=0A=
+    const uint8_t *e_body;=0A=
+    size_t n_body_len;=0A=
+    size_t e_body_len;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    n_body =3D aspeed_acry_der_uint_body(n, n_len, n_pad, &n_body_len);=0A=
+    e_body =3D aspeed_acry_der_uint_body(e, e_len, e_pad, &e_body_len);=0A=
+=0A=
+    qcrypto_der_encode_seq_begin(ctx);=0A=
+    qcrypto_der_encode_int(ctx, n_body, n_body_len);=0A=
+    qcrypto_der_encode_int(ctx, e_body, e_body_len);=0A=
+    qcrypto_der_encode_seq_end(ctx);=0A=
+=0A=
+    *out_len =3D qcrypto_der_encode_ctx_buffer_len(ctx);=0A=
+    buf =3D g_malloc(*out_len);=0A=
+    qcrypto_der_encode_ctx_flush_and_free(ctx, buf);=0A=
+=0A=
+    return buf;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Store the RSA result into the output SRAM data region as 'n_len' bytes=
=0A=
+ * (the key size): the low 'result_len' bytes are result_be (big-endian),=
=0A=
+ * the rest is zero. sram_as is a 0-based AddressSpace over the SRAM, so t=
he=0A=
+ * offset from aspeed_acry_operand_offset() is used directly; each data dw=
ord=0A=
+ * is written as a little-endian word.=0A=
+ */=0A=
+static void aspeed_acry_store_result(AspeedACRYState *s,=0A=
+                                     const uint8_t *result_be,=0A=
+                                     int result_len, int n_len)=0A=
+{=0A=
+    uint32_t result_word;=0A=
+    MemTxResult res;=0A=
+    int offset;=0A=
+    int src;=0A=
+    int i;=0A=
+    int j;=0A=
+=0A=
+    /* result_be is MSB-first; take bytes from its LSB end. */=0A=
+    src =3D result_len - 1;=0A=
+    for (i =3D 0; i < n_len / 4; i++) {=0A=
+        /* Pack up to 4 result bytes (LSB first) into a little-endian dwor=
d. */=0A=
+        result_word =3D 0;=0A=
+        for (j =3D 0; j < 4; j++) {=0A=
+            if (src >=3D 0) {=0A=
+                result_word |=3D (uint32_t)result_be[src--] << (8 * j);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        offset =3D aspeed_acry_operand_offset(ASPEED_ACRY_DATA_OFFSET, 4 *=
 i);=0A=
+        address_space_stl_le(&s->sram_as, offset, result_word,=0A=
+                             MEMTXATTRS_UNSPECIFIED, &res);=0A=
+        if (res !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: failed to write result\n", __func__);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_acry_do_rsa(AspeedACRYState *s)=0A=
+{=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_RSA,=0A=
+        .u.rsa =3D {=0A=
+            .padding_alg =3D QCRYPTO_RSA_PADDING_ALGO_RAW,=0A=
+        },=0A=
+    };=0A=
+    uint32_t len =3D FIELD_EX32(s->regs[R_ACRY_DMA_LEN], ACRY_DMA_LEN, DAT=
ALEN);=0A=
+    uint8_t src_buf[ASPEED_ACRY_SRAM_SIZE] =3D { 0 };=0A=
+    uint8_t result[ASPEED_ACRY_MAX_BYTES] =3D { 0 };=0A=
+    uint64_t src_addr =3D s->regs[R_ACRY_DMA_SRC];=0A=
+    uint8_t data[ASPEED_ACRY_DATA_MAX_LEN];=0A=
+    g_autofree uint8_t *der_key =3D NULL;=0A=
+    uint8_t n[ASPEED_ACRY_MAX_BYTES];=0A=
+    uint8_t e[ASPEED_ACRY_MAX_BYTES];=0A=
+    QCryptoAkCipher *cipher =3D NULL;=0A=
+    Error *local_err =3D NULL;=0A=
+    int result_len =3D 0;=0A=
+    size_t der_len;=0A=
+    int data_len;=0A=
+    int n_len;=0A=
+    int e_len;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                     "%s: RSA ModExp not supported by the crypto backend; =
"=0A=
+                     "completing with an invalid result\n", __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (len =3D=3D 0 || len > ASPEED_ACRY_SRAM_SIZE) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA length %u\n",=0A=
+                     __func__, len);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_acry_rsa_trigger(src_addr, len);=0A=
+=0A=
+    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           src_buf, len) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                     "%s: failed to read DMA buffer at 0x%" PRIx64 "\n",=
=0A=
+                     __func__, src_addr);=0A=
+    }=0A=
+=0A=
+    n_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_MOD_OFFSET,=0A=
+                                   ASPEED_ACRY_MAX_BYTES, n);=0A=
+    e_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_EXP_OFFSET,=0A=
+                                   ASPEED_ACRY_MAX_BYTES, e);=0A=
+    data_len =3D aspeed_acry_extract_be(src_buf, ASPEED_ACRY_DATA_OFFSET,=
=0A=
+                                      ASPEED_ACRY_DATA_MAX_LEN, data);=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("buf", src_buf, len);=0A=
+        aspeed_acry_hexdump("n", n, n_len);=0A=
+        aspeed_acry_hexdump("e", e, e_len);=0A=
+        aspeed_acry_hexdump("data", data, data_len);=0A=
+    }=0A=
+=0A=
+    der_key =3D aspeed_acry_der_encode_pubkey(n, n_len, e, e_len, &der_len=
);=0A=
+    cipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                  der_key, der_len, &local_err);=0A=
+    if (!cipher) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                     "%s: failed to create RSA cipher: %s\n",=0A=
+                     __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    result_len =3D qcrypto_akcipher_encrypt(cipher, data, data_len,=0A=
+                                          result, sizeof(result),=0A=
+                                          &local_err);=0A=
+    if (result_len < 0) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: RSA modexp failed: %s\n",=0A=
+                     __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        result_len =3D 0;=0A=
+    }=0A=
+=0A=
+    qcrypto_akcipher_free(cipher);=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("result", result, result_len);=0A=
+    }=0A=
+=0A=
+    aspeed_acry_store_result(s, result, result_len, n_len);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_acry_read(void *opaque, hwaddr offset, unsigned int=
 size)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+=0A=
+    trace_aspeed_acry_read(offset, s->regs[reg]);=0A=
+=0A=
+    return s->regs[reg];=0A=
+}=0A=
+=0A=
+static void aspeed_acry_write(void *opaque, hwaddr offset, uint64_t data,=
=0A=
+                              unsigned int size)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+=0A=
+    trace_aspeed_acry_write(offset, data);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_ACRY_DMA_SRC:=0A=
+        /*=0A=
+         * The DMA source register holds a CPU-visible DRAM address (e.g.=
=0A=
+         * 0x8xxxxxxx on AST2600); the engine addresses DRAM from offset 0=
,=0A=
+         * so mask off the top bit to get the DRAM-relative offset.=0A=
+         */=0A=
+        data &=3D 0x7FFFFFFF;=0A=
+        break;=0A=
+    case R_ACRY_STATUS:=0A=
+        data =3D s->regs[R_ACRY_STATUS] & ~data;=0A=
+        if (!(data & (R_ACRY_STATUS_RSA_ENG_DONE_MASK |=0A=
+                      R_ACRY_STATUS_RSA_DMA_DONE_MASK))) {=0A=
+            qemu_irq_lower(s->irq);=0A=
+        }=0A=
+        break;=0A=
+    case R_ACRY_TRIGGER:=0A=
+        if (FIELD_EX32(data, ACRY_TRIGGER, RSA_START)) {=0A=
+            aspeed_acry_do_rsa(s);=0A=
+=0A=
+            s->regs[R_ACRY_STATUS] |=3D R_ACRY_STATUS_RSA_ENG_DONE_MASK |=
=0A=
+                                      R_ACRY_STATUS_RSA_DMA_DONE_MASK;=0A=
+            if (s->regs[R_ACRY_INT_MASK] &=0A=
+                (R_ACRY_INT_MASK_RSA_ENG_MASK_MASK |=0A=
+                 R_ACRY_INT_MASK_RSA_DMA_MASK_MASK)) {=0A=
+                qemu_irq_raise(s->irq);=0A=
+            }=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_acry_ops =3D {=0A=
+    .read =3D aspeed_acry_read,=0A=
+    .write =3D aspeed_acry_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_acry_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(obj);=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void aspeed_acry_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(dev);=0A=
+=0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+    address_space_init(&s->dram_as, s->dram_mr, "dram");=0A=
+=0A=
+    if (!s->sram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");=0A=
+        return;=0A=
+    }=0A=
+    address_space_init(&s->sram_as, s->sram_mr, "sram");=0A=
+=0A=
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,=0A=
+                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+}=0A=
+=0A=
+static const Property aspeed_acry_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+};=0A=
+=0A=
+static void aspeed_acry_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED ACRY Engine";=0A=
+    dc->realize =3D aspeed_acry_realize;=0A=
+    rc->phases.hold =3D aspeed_acry_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_acry_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_acry_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_ACRY,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedACRYState),=0A=
+        .class_init =3D aspeed_acry_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_acry_types)=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index e86d9ad6b3..3912dc2bce 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: file=
s('pvpanic-pci.c'))=0A=
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'=
))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
+  'aspeed_acry.c',=0A=
   'aspeed_hace.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index c9a868b3ef..bbec0d2178 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -331,6 +331,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offs=
et 0x%" PRIx64 " data 0x%"=0A=
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRI=
x32 " status 0x%" PRIx32=0A=
 =0A=
+# aspeed_acry.c=0A=
+aspeed_acry_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
+aspeed_acry_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
+aspeed_acry_rsa_trigger(uint64_t src_addr, uint32_t len) "src_addr 0x%" PR=
Ix64 " len 0x%" PRIx32=0A=
+aspeed_acry_hexdump(const char *desc, uint32_t offset, const char *s) "%s:=
 0x%08x: %s"=0A=
+=0A=
 # aspeed_hace.c=0A=
 aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
 aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
-- =0A=
2.53.0=0A=

