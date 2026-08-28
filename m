Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3342C61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsVp-0005We-24; Fri, 28 Aug 2026 05:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVm-0005Ux-GZ; Fri, 28 Aug 2026 05:04:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVk-0003UD-7Z; Fri, 28 Aug 2026 05:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeDVh00SNFcyQXbL/yGzq1h+DiyP9/UDRFStHdiuDIQ6R+Zm3TlxJWdMituNhqANH3kLXrGLLT1FkUIWq3WtG/yThQNNhmNsbNYO/0dvz3/XtpHj9geafH/RnEt7eQ2FlCtQLAh8SeKpjAPVzrN8kldKpvXo/Sj9lBRyIcy84GRt5lhysWo/OK1/3AqzKst2xoukj9dzONV58iSOhx7BajlCz5WCghfcyxQvK6YnXaD0FuxjWadpdhenp51/4yDFP2ozGKZeh/Ak7WNgF6MXmZIrzgBLYmYOEVP++RXmFLCnoY+iX8c+2cHQtW5QVnEJcgu7/blmYofkG1D5HpxL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqkLXAN/QTGIiVQqvrZR0QiLo15bMy5O8BxaV3KScl4=;
 b=d57R+ZrM0YY2KQpfXpJMBdGXiqyfzEmns0ePu4ebib1teTV96qPCH/+SK4znlUL8ytM2Aeyi0uJ5DLiz2BAuklHU0joUK+S5tfLs0oAOVkI44Z+UFJG3/1x5ew2bnU2LXXvGuyjxoGXzCHosyNVvGDExT9L+CUbxfb1JL9TibMUuNSFK+dNhNiWqv/YsOv8yIaPj6gJk/B7nvPLX/np+4cSc5hzN52ORPUFbqmTdCf+fsaWykNAOaF+zNIz0etLnFP2UTTfV8m1h16KVhsN2QPv0wVEyJdXjpko+BNPHrLiTFwsarmI8t8gIjRAK1PbPSEHmUoNUGHjoCDAV18riiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqkLXAN/QTGIiVQqvrZR0QiLo15bMy5O8BxaV3KScl4=;
 b=aHEQkzydhlqk3viJm159GbuOgDoHrcK7drhUYg7zM1kqqQiYsHk6/3T87OseAHX7SYtJ9w3R+F/5Zn1ZXd1cIoMq/hKBfRdambGbEc5NoHhFZGQsKCis4dnIxoNBhK4m4fWc0LeEccYszY4XCIitvGkRJo/XKvLcNmk7kS5Nv/2XVbxtPHJAt16Fp/l5pQdhT9OjgI5IkEFxgrxlHQ6h5diXDjqPhGkAK7uxy7BBKeC4y1PHYFQNC6Hv7hY0YG9MFVB5wKnlNMf+CuN1TXAQel9fTgoDo7biyqkIWzaibiMGSG1kpMVeEl9l5dtFVh4IcMuyWpBL39ZaoJszfrY0gg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6209.apcprd06.prod.outlook.com (2603:1096:820:d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:17 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Thread-Topic: [PATCH v2 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device
 controller
Thread-Index: AQHdNswz0mCyrGXWZkWLdayQedzLlw==
Date: Fri, 28 Aug 2026 09:04:15 +0000
Message-ID: <20260828090412.981841-2-jamin_lin@aspeedtech.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6209:EE_
x-ms-office365-filtering-correlation-id: 6964b0e7-d7ef-4fcf-d329-08df04e355c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: o8N3OzevOTsCnEJPDz0V0Be3PdLymFUDn3YpjWC9FzJ1eKAguZpCjXmMKWMifj4VFvOC5/zJNK+EYo2ShrkDIOl7HozHPealfkLLpbenaaTauRCTkGO3EK7uOKIa3VLfCbAl9p1TFyQUF6sX+aij7b70tJaKWi8ci8hFSkrCspLZJWFqhPsM7dqDZZjsOFnLMIC0HWrgckkcJZJYt08T4p2wGeWHzrZOhGv6h1dXeIZ8QfPCvOJjQWc0EBViMiGEZtPxQ33XtQrVv3RVHXD5qyAUp9HpPPYeXM2+h+E7EpfI9cXPzl6WIBo5C1znYxp7DMQtKovxKSU66H24SGL7MqReawsj41uANwkjQuRLsaiNlPTP/EaM4qjqeg0PyHpeC0Ne3L3IhhPgGyD7U7Uza82UE0emqF4Vk1XOXeDqw6hEiipiLjQNneshEPStiWs4CqftJJ4BJxCDTQK1Z41upXAj1cb4uWwG13FbpBXBhSqfYQTorCL0l4wBr7q/bLyf8WnGmOIFyB1GfX3COeYG7RQc1SY98ni5rQ6WzoB7Jp2J40u0xv/OGXYYcGvItlMXqyWgEhmRZB1vAhCOb4bBIEQ1TNTFyj9MHfADnZc1Ots5oBbA8fdSiL37bvRoFO4e8DoSPIKQ8UV0Txy1D2c6y9KD8NLNl8EFXnBHhls4n6x5ZI6XFTCNta9BGRFbAi3NyWv2wwbVd1MS6wQqxJcOLWz9Blv5xk9XRZ25Z90s70GvYpsWUthOlkziuuXptjdW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hfroDS4ffQkIoNq4ZHvEeX3IpNjHvOk5e4AryJRD3H/yLZCPW4lHJ+uqjj?=
 =?iso-8859-1?Q?VQTWzst05asMUFjNSbbBND0/aTyuX52k4dNqiOpu+WnBO0ArjMRHfvShDf?=
 =?iso-8859-1?Q?FVb9BRNrGtyuAhyh+aXQNVZNymaCwAkqBOL9qfzMIfrJqI2G+3Sk8F+eGd?=
 =?iso-8859-1?Q?KYBZrZuYfqWEtogHU8AoSlDCscuj3+X0GYkwoPx5r1PrCnsEUDUpf8UJ/R?=
 =?iso-8859-1?Q?BAdOfak26H6vFSVAXHWc81OaWaVNJpWt1DaJQOeYlp+911an7ShSvzks2i?=
 =?iso-8859-1?Q?etQ9eGUsduOZ8/dDaua/PY47Y8zjHqAwGSN8blIJhwgovXvpfKf340uxgF?=
 =?iso-8859-1?Q?Bbi2Te/bckvSqeWLatg4nLkTmAgoVM6wIWNWoJJJp2Jsz61VA/9bIgICGX?=
 =?iso-8859-1?Q?5MgzSh+W6mBKGk0XS6WsdQo1dxLTR8MhQXED0ImX+EFvCkhtwbuP7HADXl?=
 =?iso-8859-1?Q?LweBNNPBpIy9kflznoAshz8iOUkAoked7odrbsO02/7kPzpo9te02g4WST?=
 =?iso-8859-1?Q?vtNv6cfluKprre8ehBR2W1JJ3efWGhF2DFWS9Yc5gAzHUoxc5O73tk+/wl?=
 =?iso-8859-1?Q?Be8xEdc/L0RCtIOZKZtWtaeAmVQ+hIimBx3nfsHCzGsZsixqAfjZAuculP?=
 =?iso-8859-1?Q?cdwc9o1+35qL9vU8Y6I7cavDL+aicyjUtHkKrP5YfMxaMFEpI7LaxT/sr/?=
 =?iso-8859-1?Q?Px9i1szERIaM91DA2QN53aMlskhkf3tSkk9wBc87kwiSTk9rGSD06atO0j?=
 =?iso-8859-1?Q?2jTU4IsuD9U1UvZsM3GcmGSNZ57vvig+KW3DaiX7gUgn/piN4rJPc6zjjX?=
 =?iso-8859-1?Q?JaX2/6zvea7pc1JGBya1V5816hqZFgtZb9IrW356VS1p6VM2874iWLn0OI?=
 =?iso-8859-1?Q?qwIdHzieSBMK6zRSOOmyKpQbM7lBt2bXR+IMC+xRkVbpv3c/aVqrIBEWkj?=
 =?iso-8859-1?Q?4zbEhILdl6upuKP8LrD7mlORSIZ7BE3PNkl4jWl/16KuOux7l91AWg/uQT?=
 =?iso-8859-1?Q?jflX2jJEB/a4Q3r75XOTY7PnlpWlnudExfKQUO4soWbKIdCF0wV+mJo5LS?=
 =?iso-8859-1?Q?v1Na+5vdrDQ+9JDO3wMeW1xKOu4kv5CIxDNKsAbd+Ygklm9UQOS1m+L/5D?=
 =?iso-8859-1?Q?xf08uIu6W6Mcn5KHCbMA+rF5wj9DNbE6XaebVR6Pv09b6j10eTJ+J1lMIu?=
 =?iso-8859-1?Q?i2faL/EacToPRdLlLxcMeURqr4+bYggvrvMP0bNEdzt45YLM3Tirc7Q6qx?=
 =?iso-8859-1?Q?7bzN5p2oTxxnkuIuyCwpactn6tbYRMg8vqQockPoApGMnuuXmY263amnSz?=
 =?iso-8859-1?Q?6pODzUqwtSKcX1ftNbPvxPaaRxu69Ttz6h1uODyXT4/lq+HwyOt3IGJ4Y4?=
 =?iso-8859-1?Q?ma1pzdwfkcXZvDjI6mWcu3sBtunrUD9TZAdkPa426Ohk6Q4CbPmNHy70/V?=
 =?iso-8859-1?Q?kNvRkdaWVc2du1nQSlczgUhgtCVrjUIoxKH/Byzkl/20LSlFMS/7UqDnYb?=
 =?iso-8859-1?Q?zk09cN60T62/nOUsuV3ByGHfTV5rjUE25r2qHRWDVGlDI3RW39pSlKXyyR?=
 =?iso-8859-1?Q?fdqD5n/aCio7Eu/X+DopmpB4INxa1mubg2735Js8sLNkndS5+Vqt9AqdwF?=
 =?iso-8859-1?Q?4VGhxVy7UNSw7KFnB6CUZF0z+EI//foc1Gn4jlro4egoVpmMOK58tFzWkd?=
 =?iso-8859-1?Q?t3pRW3mNhjUlOsYzjynzYMC21u5eJX3h0iuwsMYPjBPzrdglfa4HYYUHTc?=
 =?iso-8859-1?Q?32q7sQC5dyTpOHJF7tJOaMk/dpyVt1HNV3zUBTKhCK9l4oTG6HpbSVbMMv?=
 =?iso-8859-1?Q?y02Bth8cjA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pAqMS+LhT7B5Kk0Wy5R9hL4rmw9HIS15ELEBtlAy8UWJqCUw8EfJBtQQSlqqLpj3eb6s7iKSUCaX51q/Edg4OMykAMjfK8ldv9hsjTeYFArlubowtg377YzERSEU2lJ/G1vCqquWv/rkJjuuguZftASvci2WyGsTtVTol3SvKBDPRAVq5U1lbFhR+3Q6zLH7ukd81CRvvuEVvegTesA23t0WKbyuyreiWio2LAZOM+g2p6i4j0Rw+sxIZ3kDhKW1aT3i0DncIH5Pi4idfcbqViPpFIuIcKXf5w9U4upYutKWL+lkNZHZDJGxRefs2u9fVP/9AM0kDoSZslrEkiUiDQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6964b0e7-d7ef-4fcf-d329-08df04e355c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:15.2595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82tAopjnPQuC3TNAtQffCHieAvZXetgKHZ/V6fklxNu7rYSdEUSW+idWe5xapzI7u+l59R8sB+VTasyWcbQtyut5hGDJzw2DKPPUbpnxnaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6209
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

The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one=0A=
control endpoint and four programmable endpoints.=0A=
=0A=
Add the controller as a sysbus (system) device: the MMIO register map=0A=
described with the registerfields macros, the interrupt line and the=0A=
soft reset. This is only the register/system side.=0A=
=0A=
Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).=
=0A=
It is not the gadget USB device (TYPE_ASPEED_UDC_GADGET) that a host=0A=
controller enumerates, which is added in the next patch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |  49 ++++++++=0A=
 hw/usb/aspeed-udc.c         | 240 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/usb/Kconfig              |   4 +=0A=
 hw/usb/meson.build          |   1 +=0A=
 hw/usb/trace-events         |   7 ++=0A=
 6 files changed, 302 insertions(+)=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
new file mode 100644=0A=
index 0000000000..58fed5f9a2=0A=
--- /dev/null=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -0,0 +1,49 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_USB_ASPEED_UDC_H=0A=
+#define HW_USB_ASPEED_UDC_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_ASPEED_UDC "aspeed.udc"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=0A=
+=0A=
+/*=0A=
+ * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
+ * per programmable endpoint from 0x200.=0A=
+ */=0A=
+#define ASPEED_UDC_MEM_SIZE     0x300=0A=
+#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)=0A=
+#define ASPEED_UDC_EP_REG_BASE  0x200=0A=
+#define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)=0A=
+=0A=
+/*=0A=
+ * EP0 (control) is served through the root registers (UDC_EP0_*), so only=
=0A=
+ * the 4 programmable endpoints get their own register bank / ep[] entry.=
=0A=
+ */=0A=
+#define ASPEED_UDC_NUM_EP   4=0A=
+=0A=
+typedef struct AspeedUDCEP {=0A=
+    MemoryRegion mr;=0A=
+    uint32_t regs[ASPEED_UDC_EP_NR_REGS];=0A=
+    int index;=0A=
+} AspeedUDCEP;=0A=
+=0A=
+struct AspeedUDCState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion udc_container;=0A=
+    MemoryRegion root_mr;=0A=
+    uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
+    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
+    qemu_irq irq;=0A=
+};=0A=
+=0A=
+#endif /* HW_USB_ASPEED_UDC_H */=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
new file mode 100644=0A=
index 0000000000..85786a2e12=0A=
--- /dev/null=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -0,0 +1,240 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Models the ASPEED USB Device Controller (UDC). It implements one contro=
l=0A=
+ * endpoint (EP0) and 4 programmable endpoints.=0A=
+ *=0A=
+ * This file is the system-bus side of the controller: the MMIO register m=
ap,=0A=
+ * the interrupt and the soft reset. The gadget USB device presented to a =
host=0A=
+ * controller (and the endpoint data path) is added on top of this.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "qemu/module.h"=0A=
+#include "trace.h"=0A=
+=0A=
+/* Root / Global registers (offset from the controller base) */=0A=
+REG32(UDC_FUNC_CTRL, 0x00)=0A=
+    FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)=0A=
+REG32(UDC_CONFIG, 0x04)=0A=
+    FIELD(UDC_CONFIG, DEV_ADDR,             0, 7)=0A=
+REG32(UDC_IER, 0x08)=0A=
+REG32(UDC_ISR, 0x0C)=0A=
+    FIELD(UDC_ISR, EP_POOL_ACK,            16, 1)=0A=
+    FIELD(UDC_ISR, BUS_RESET,               6, 1)=0A=
+    FIELD(UDC_ISR, EP0_IN_ACK,              3, 1)=0A=
+    FIELD(UDC_ISR, EP0_OUT_ACK,             1, 1)=0A=
+    FIELD(UDC_ISR, EP0_SETUP,               0, 1)=0A=
+REG32(UDC_EP_ACK_IER, 0x10)=0A=
+REG32(UDC_EP_NAK_IER, 0x14)=0A=
+REG32(UDC_EP_ACK_ISR, 0x18)=0A=
+REG32(UDC_EP_NAK_ISR, 0x1C)=0A=
+REG32(UDC_DEV_RESET, 0x20)=0A=
+    FIELD(UDC_DEV_RESET, EP_POOL,           9, 1)=0A=
+    FIELD(UDC_DEV_RESET, DMA,               8, 1)=0A=
+    FIELD(UDC_DEV_RESET, ROOT,              0, 1)=0A=
+REG32(UDC_STS, 0x24)=0A=
+    FIELD(UDC_STS, HIGHSPEED,              27, 1)=0A=
+REG32(UDC_EP_DATA, 0x28)=0A=
+REG32(UDC_ISO_TX_FAIL, 0x2C)=0A=
+REG32(UDC_EP0_CTRL, 0x30)=0A=
+    FIELD(UDC_EP0_CTRL, RX_LEN,            16, 7)=0A=
+    FIELD(UDC_EP0_CTRL, TX_LEN,             8, 7)=0A=
+    FIELD(UDC_EP0_CTRL, RX_RDY,             2, 1)=0A=
+    FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)=0A=
+    FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
+REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
+/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
+REG32(UDC_SETUP0, 0x80)=0A=
+REG32(UDC_SETUP1, 0x84)=0A=
+=0A=
+/* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
+REG32(EP_CONFIG, 0x00)=0A=
+    FIELD(EP_CONFIG, MAX_PKT,              16, 10)=0A=
+    FIELD(EP_CONFIG, EP_NUM,                8, 4)=0A=
+    FIELD(EP_CONFIG, DIR_OUT,               4, 1)=0A=
+    FIELD(EP_CONFIG, ENABLE,                0, 1)=0A=
+REG32(EP_DMA_CTRL, 0x04)=0A=
+    FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
+    FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
+REG32(EP_DMA_BUFF, 0x08)=0A=
+REG32(EP_DMA_STS, 0x0C)=0A=
+    FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)=0A=
+    FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
+    FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
+=0A=
+static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
+{=0A=
+    bool level;=0A=
+=0A=
+    level =3D (s->regs[R_UDC_ISR] & s->regs[R_UDC_IER]) ||=0A=
+            (s->regs[R_UDC_EP_ACK_ISR] & s->regs[R_UDC_EP_ACK_IER]) ||=0A=
+            (s->regs[R_UDC_EP_NAK_ISR] & s->regs[R_UDC_EP_NAK_IER]);=0A=
+=0A=
+    trace_aspeed_udc_irq(s->regs[R_UDC_ISR], s->regs[R_UDC_IER], level);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size=
)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val;=0A=
+=0A=
+    val =3D s->regs[reg];=0A=
+    trace_aspeed_udc_read(offset, val);=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,=
=0A=
+                             unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
+=0A=
+    trace_aspeed_udc_write(offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_UDC_IER:=0A=
+    case R_UDC_EP_ACK_IER:=0A=
+    case R_UDC_EP_NAK_IER:=0A=
+        s->regs[reg] =3D val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    case R_UDC_ISR:=0A=
+    case R_UDC_EP_ACK_ISR:=0A=
+    case R_UDC_EP_NAK_ISR:=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
+    .read =3D aspeed_udc_read,=0A=
+    .write =3D aspeed_udc_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val;=0A=
+=0A=
+    val =3D e->regs[reg];=0A=
+    trace_aspeed_udc_ep_read(e->index, offset, val);=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data=
,=0A=
+                                unsigned size)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
+    e->regs[reg] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
+    .read =3D aspeed_udc_ep_read,=0A=
+    .write =3D aspeed_udc_ep_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_udc_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+    int i;=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
+    }=0A=
+=0A=
+    /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
+    s->regs[R_UDC_DEV_RESET] =3D (R_UDC_DEV_RESET_ROOT_MASK |=0A=
+                                R_UDC_DEV_RESET_DMA_MASK |=0A=
+                                R_UDC_DEV_RESET_EP_POOL_MASK);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(dev);=0A=
+    int i;=0A=
+=0A=
+    memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,=0A=
+                       ASPEED_UDC_MEM_SIZE);=0A=
+    memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,=0A=
+                          TYPE_ASPEED_UDC ".root",=0A=
+                          ASPEED_UDC_ROOT_NR_REGS << 2);=0A=
+    memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);=0A=
+=0A=
+    /* Each programmable endpoint has its own register bank */=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
+=0A=
+        s->ep[i].index =3D i;=0A=
+        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,=
=0A=
+                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2)=
;=0A=
+        memory_region_add_subregion(&s->udc_container,=0A=
+                                    ASPEED_UDC_EP_REG_BASE +=0A=
+                                    i * (ASPEED_UDC_EP_NR_REGS << 2),=0A=
+                                    &s->ep[i].mr);=0A=
+    }=0A=
+=0A=
+    sysbus_init_mmio(sbd, &s->udc_container);=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED USB Device Controller";=0A=
+    dc->realize =3D aspeed_udc_realize;=0A=
+    rc->phases.hold =3D aspeed_udc_reset_hold;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_udc_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_UDC,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedUDCState),=0A=
+        .class_init    =3D aspeed_udc_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_udc_types)=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 260d2f0751..146ed1a0be 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -536,6 +536,7 @@ config ASPEED_SOC=0A=
     imply GENERIC_LOADER=0A=
     imply PCI_DEVICES=0A=
     imply E1000E_PCI_EXPRESS=0A=
+    select ASPEED_UDC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig=0A=
index de95686720..e8c00f813a 100644=0A=
--- a/hw/usb/Kconfig=0A=
+++ b/hw/usb/Kconfig=0A=
@@ -146,3 +146,7 @@ config XLNX_USB_SUBSYS=0A=
 config USB_CHIPIDEA=0A=
     bool=0A=
     select USB_EHCI_SYSBUS=0A=
+=0A=
+config ASPEED_UDC=0A=
+    bool=0A=
+    select USB=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index ba55c28ef6..d4ba60a91c 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -27,6 +27,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files=
('hcd-xhci-nec.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))=
=0A=
+system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))=
=0A=
 =0A=
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))=
=0A=
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c=
'))=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 67249d69c2..ed05304520 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -377,3 +377,10 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_l=
en) "ep %d len %d"=0A=
 canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"=0A=
 canokey_realize(void)=0A=
 canokey_unrealize(void)=0A=
+=0A=
+# aspeed-udc.c=0A=
+aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " val=
ue 0x%x"=0A=
+aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
+aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
+aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
+aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x,=
 level %d"=0A=
-- =0A=
2.53.0=0A=

