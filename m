Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53261C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsVs-0005Y2-Uz; Fri, 28 Aug 2026 05:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVq-0005Wn-Hp; Fri, 28 Aug 2026 05:04:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVn-0003UD-Mr; Fri, 28 Aug 2026 05:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kojB5Ar8e0Xpi+eNP8OA04B9kuYVmmObCoX69ULAafSnPSRLvnGreY/ttkZ6KMv9zaIWLRIexHosxB+E+sI8VsEhasLVU84YCu3xaKSS42TfCDyQAE2vdnz8miCAwm465jYnQ4u3ZNI4fA6El4YHmekPzPlOtNEZqiXpsoWgViIIGZYg9UhNWHAVMJutvfN0WaOknWR1dY4NV/fI1wOdMCHbJZCCMDJzxGMjqBxbEmbEvfmNE0BL3DnXfIDc3lX7TSprhFAGDVu1w9SoPLjN+V9bk64TFuufzex7kmHY45mfMItXhYB0OKfSwgtm3qc6jFaYhQsVQckMTGtgRfyboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pioYsUakRgq6zWr898ZjhuOs50s/xEcSLIjdGxDZS9Q=;
 b=m3rb8eiCAMm41VP0QL1dFrUfhzxn8YspJmQTnSTN9hLaVd8WXIbax5epTfUd4B56xTnvRSubC7UoTvsePS5dcS850u639nIeuKerCywrKJOmfDkvtnjgH1/OmWJbyDUJ0eFtn4BBwPm3FMdhnALZnggxPjhL6HIkhONthxJgPW97J/Gk93yKeo4NQ8y4APnAbYQacyp/LX1Eoo567A5SLDPF3dkN51M69+wMb/gVKfVMNMhJXLfJwmJW+g+bJmXI/KSpVC0JeiI0bCYCjXau63lkT9ZQIN/QfxCRFEDmp9+n4LVXRV4lVujnNagx1Vy/dbko0LYihRL4a+b8zYwlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pioYsUakRgq6zWr898ZjhuOs50s/xEcSLIjdGxDZS9Q=;
 b=f09EQUx8Yz+LuZCBW1FgatKBny+1UrsRzAPvJrO+5bJDKfKL4vdiw6Yqeo42L83S2DCTNwwXdgPQUM4uZgZRSOumsQnqpbc4fpT/RSFUConjQIxtNSnwKog30E5EtkRK9Q2MX17racAxIpSLMpS1Hdw5NoC4KsY4IqVF7jvFyYvCmYXaAKxlHGvHZ2ekn2IEQAaqm9DNBKkuUBpnziFLAWUnk1L4q++6yDXKvMOOM2gh4DZac3Kn5Mk/5VuoanypJQ1q094kHmHCV+ojM1k8UlMCGx13NJou4nOvwKs+pz1DlgtBZvlmuwylqUguoonjUq5+9RH9SVqZvaYkDiEZdg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6209.apcprd06.prod.outlook.com (2603:1096:820:d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Thread-Topic: [PATCH v2 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB
 device
Thread-Index: AQHdNsw0QfINOzBp0USUkeNuaEZqIA==
Date: Fri, 28 Aug 2026 09:04:16 +0000
Message-ID: <20260828090412.981841-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c95ea8af-bcf9-4dd9-8f5a-08df04e35821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|6133799003|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: R9bewM8QcSyZpifBD1K667Ccnr2AbQeUcyIM2V88ZoAxek3sdxPUdYWUKDmTrU7TqugblAswgpKRlIWra28mNQDCP/z5JEU653ypxpXB38/FKYHlVX/+15eZgchTKPeniYG4wkT83CtRpsZIKgxoMthrCpgjVNOOKDy/cW7CNVvAQOb548qeHH6gylpUwpqogAp/dM98abOU/18GYRMM9JGh/rGyMpJ5BEfc3GTHNBJqHyeXdzbUxh0vrU3jpUfN3g/lt9V57YwgnluIQYjBOqDwom8D5ilL4OH2ti1+GZ2+u9w0F0+QXH7J0g76yQ5nJbgp2SExojiisKHqc7RyNphmkA7TeTKDRFwU1+twwLARa+F+T8cxmS+gwDTtvR0x9FMOxu9vzYkrFC62Irgj8uFYYsvEaGRn4zi/Qi232EcdxidK26nGznUH8m0JullORoVuskOm2xloZIG4S6v6C6CSfXo2ZliRi4vihXb2B7CX42aiumPkD+//0A9cqpixzZIUKqJGOff81omppIQEoa0W2GcfgQqMmvqZRQt/OZB/emY5/TdwWoXd4T7xMN2Y8O5AWvYJO0RptLZydB0B86gzt2uWpRwnJ24E3zP6omxmc62+axqa/ICnEtAiQVtYV2UPr0vyFjOydNjMcIK/23SZvoz2o22fyIiUD+clr2B3jEnSfwQsyPqXcj0Tt/eSHRLZolGk7MjLzv/hlEnvDyQe8G/nnlsy3HHXF94Ic6B04JavY0asXLSoukUWcomb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dYhpLYAEGrPULLEb0hTyNG+7vWnV2hwPTiGhKTDMWcaChbhMrBZ5ikd45V?=
 =?iso-8859-1?Q?HcnXcnFNQe+YvzPwOKfgECeSW0YhXx3cQVQEH8VCkNow0CMpQhZ9YeKlEB?=
 =?iso-8859-1?Q?f+WZJt9GE8FPnaPXhwODuOpdquYunl3m+ADigvt5aPvOeSq/MRW5eUNoKY?=
 =?iso-8859-1?Q?see38nJqe5AXu+E64PXab0DOo4rsDB5kf8BWwboGPu/a4HpQ0ok1+yV2dX?=
 =?iso-8859-1?Q?P+mWofYapnKa3cfawBwyAEW71Giun9wbMMKSURd9FlzbEFYtXs0YK0YMf/?=
 =?iso-8859-1?Q?4WPq7MICE6CvtFCCO7wbz5QQtBN5AlDtLBdLTwVLjwEsMxLexLIC8EmDkN?=
 =?iso-8859-1?Q?UWrKunybiNhXcRu8Iiiwe8VzaxLJpFHJM0cJj2Gnvnaopfrq4qWd29JTNH?=
 =?iso-8859-1?Q?ZzJESQSmErBlK1+dI9pi42Yznj4CdEF7trWrsLQECO0R0OKCOzu2JU/WJy?=
 =?iso-8859-1?Q?0qP/QfbUnYd2f66HWl7AqIuUbZV7esu9dm6ysSOdz3oPmwqYs46qDje1QN?=
 =?iso-8859-1?Q?NyxrnxP59eT7F82VPOIbXenbvDLQAVNukGRDYueY+WsJZSdtIhUQJFmGq4?=
 =?iso-8859-1?Q?Wong1uvSDkiYnAICYEJ+OdQeQLWITBfZWAV8TI+Z6/HtzqYj4BflbdbfhB?=
 =?iso-8859-1?Q?Q20Arks4D3eqTM7YGq8Bbb/gwtWQ30UBj9Pc9FZLPn79jLJpaKwxyfA2PW?=
 =?iso-8859-1?Q?AjgTe7RCwyjxRmOOpRgUIj6+OBJ7TvNp3gVJRGlxRazpRzmMRrwv08+VVq?=
 =?iso-8859-1?Q?DgcjpfuLLoM1bme/GrSkZSYNYKf3BjPx36esCQrQAXbCI+IF/XXNeCm5cs?=
 =?iso-8859-1?Q?Gr9B8QgflbdH8G7q2g3DIllEgJ12xzXEx97KEbxJYlKWcAhgZe5yJDRQKB?=
 =?iso-8859-1?Q?yRKiH5bo94cJPF4n75yYNOC+YGGoweQUUlzdhrYnjh2Amw0vt+eFSK9zxL?=
 =?iso-8859-1?Q?/PQgefoBIMR1jjB5jkY762svkb7LjEl4ymk+bUgzddVTHPKNKAWMYSE0a4?=
 =?iso-8859-1?Q?3olRJ6f4ptLtkmtPwyEFx+C6K4KuO5oX4cqf+38CKEZks8u150bTfNlXdR?=
 =?iso-8859-1?Q?3PxlmDiCedgA9Kd/307TUvTOAwyH9bio2JR3tyiVCjT7C8Q6dct2/m5CRP?=
 =?iso-8859-1?Q?C3vdV9D/00oYCaUIYfMCZGub3Xk7kIVm9tlT22wzif4pehUQZxEI7y3Ogd?=
 =?iso-8859-1?Q?FZTcfW4xqyuD8QGU4oJLMzNWte0jBNnWvTtsOagAzomZ2RYqZezVPrV0ud?=
 =?iso-8859-1?Q?krQkBOFLhLoWqW2wXS40QsH1Z91rcCBDm16n0prvZtIhW3k68HHuNX41kT?=
 =?iso-8859-1?Q?AFJ7Bs23VWJypd/19e6GcaGxK0TJ47J66oWBHk6GoqXRs4QwqMkms4Y3Oy?=
 =?iso-8859-1?Q?ieJsyjDi4QW26YuBO6jmL+9OdvY6rjg2rDxbmn9pPPf5tYKzyVWkaxMDS/?=
 =?iso-8859-1?Q?JxU03cFktoaZqFwM2Lu+3Mb2KqKp71d82nDJ/5azpD4oQxXmBLPS5qkjhr?=
 =?iso-8859-1?Q?8isindot+i+77/naS52jFyLFAe6nlcpxzytKuxIpgDJFl8Fk0aciShEiRo?=
 =?iso-8859-1?Q?u/R7/amTinwiAKDiAWssFUNwAbjSvmWYICGkaWktfUMuKLgA/wnfmIKo4n?=
 =?iso-8859-1?Q?31Vy97WDWYe0YY5GsONf2pGoFpBP7Z0GLBb7Gtmp4Tp2lzDDh+YFaJmbnF?=
 =?iso-8859-1?Q?906byDnHTgAsPIY1ObCC4C7NE+T7OCZ+Z0PsjxjiLAjKwRHHv/GfkC566h?=
 =?iso-8859-1?Q?Nd8AkYh/UxB29zAxX12KwmVnE874AkuGbpJexOKMkqykhnuyukZDpayD5s?=
 =?iso-8859-1?Q?jjjyDdnA+Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vH/M3e/vWAV84vJIBJPBCeLwOXnzh8Lp9ir4G0TzGSRPPReE0OysFlZY/ACEcpt027RNAQ80qOG+CPYRcX+yWr/Lxj8nOi4gVD1HkJZyI3L31Rv7iY4e4uz+UdfYCfdiHDjq5vVycFpEQ3IXQ61ljONhslCAtLkA7ImydS4DhIO7v6KGGqNb9qaisLvjmm4Oduk8dedOEiisuqflPEw8vOmqM+TjKcx2B7uzrnb/RdliMp+qzu9bIfoEtTvNKmwH0SnPaAlWEn0Fs0HMqeeyG40xm1yvXg+KrfrUqQFYAgru6D4ENdWgorE+5x9DJjVONVLrkWgYHGeDiKbRyN4W+A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ea8af-bcf9-4dd9-8f5a-08df04e35821
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:16.5872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCJg3bWXn3E3uOGl9tR8CGEenpZle71yfsbzdKh8pRZE7JzPg45V6236EgVAebvJ+9XU/qHrh6lwdn1tDV8g+rVC/6fEF+Bv3LoaUOD4y10=
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

Present the UDC gadget side to a USB host controller as a USB device=0A=
(TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be=0A=
attached to any USB host controller bus, not only the BMC's own EHCI. It=0A=
links back to its controller through the "udc" property.=0A=
=0A=
This patch implements the control endpoint (EP0), which is enough for the=
=0A=
host to enumerate the gadget. Host control transfers are handled=0A=
asynchronously: the SETUP packet is mirrored into the SETUP data buffer,=0A=
the EP0 interrupt is raised and the host packet is parked (USB_RET_ASYNC).=
=0A=
The guest gadget driver then drives the data and status stages by writing=
=0A=
UDC_EP0_CTRL; that moves data to/from the driver's DMA buffer and completes=
=0A=
the parked packet back to the host.=0A=
=0A=
SET_ADDRESS is the exception: it is applied synchronously, because the host=
=0A=
controller keeps the transfer bound to address 0 until it completes.=0A=
=0A=
The gadget connects to / disconnects from the host bus when the driver=0A=
sets or clears the upstream-enable (pull-up) bit, and is detached on reset.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |  28 +++=0A=
 hw/usb/aspeed-udc.c         | 360 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   5 +=0A=
 3 files changed, 390 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 58fed5f9a2..ab9d016c61 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -10,11 +10,19 @@=0A=
 #define HW_USB_ASPEED_UDC_H=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
 #define TYPE_ASPEED_UDC "aspeed.udc"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=0A=
 =0A=
+/*=0A=
+ * The gadget side of the controller is presented to a USB host controller=
's=0A=
+ * bus as a single USB device that delegates back to the AspeedUDCState.=
=0A=
+ */=0A=
+#define TYPE_ASPEED_UDC_GADGET "aspeed.udc-gadget"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)=0A=
+=0A=
 /*=0A=
  * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
  * per programmable endpoint from 0x200.=0A=
@@ -36,14 +44,34 @@ typedef struct AspeedUDCEP {=0A=
     int index;=0A=
 } AspeedUDCEP;=0A=
 =0A=
+struct AspeedUDCGadget {=0A=
+    USBDevice parent_obj;=0A=
+    AspeedUDCState *udc;=0A=
+};=0A=
+=0A=
 struct AspeedUDCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion udc_container;=0A=
     MemoryRegion root_mr;=0A=
+    MemoryRegion *dram_mr;=0A=
+    AddressSpace dram_as;=0A=
     uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
     qemu_irq irq;=0A=
+=0A=
+    /* gadget USB device bound to this controller (set at its realize) */=
=0A=
+    AspeedUDCGadget *usbgadget;=0A=
+=0A=
+    /*=0A=
+     * In-flight EP0 control transfer (host side), deferred until the gues=
t=0A=
+     * gadget driver responds via MMIO.=0A=
+     */=0A=
+    USBPacket *ep0_packet;=0A=
+    uint32_t ep0_setup_len;=0A=
+    uint32_t ep0_offset;=0A=
+    uint8_t *ep0_data;=0A=
+    bool ep0_dir_in;=0A=
 };=0A=
 =0A=
 #endif /* HW_USB_ASPEED_UDC_H */=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 85786a2e12..b944f72fdf 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -8,16 +8,26 @@=0A=
  * Models the ASPEED USB Device Controller (UDC). It implements one contro=
l=0A=
  * endpoint (EP0) and 4 programmable endpoints.=0A=
  *=0A=
- * This file is the system-bus side of the controller: the MMIO register m=
ap,=0A=
- * the interrupt and the soft reset. The gadget USB device presented to a =
host=0A=
- * controller (and the endpoint data path) is added on top of this.=0A=
+ * The model has two faces:=0A=
+ *   - a SysBus device exposing the MMIO register interface, the interrupt=
 and=0A=
+ *     the integrated DMA engine to the guest gadget driver;=0A=
+ *   - a USBDevice presented on a host controller's bus, which forwards ho=
st=0A=
+ *     transactions to the guest gadget driver by raising the matching=0A=
+ *     controller interrupts and completes them once the guest gadget driv=
er=0A=
+ *     responds via MMIO.=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/log.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
 #include "hw/usb/aspeed-udc.h"=0A=
 #include "qemu/module.h"=0A=
+#include "qapi/error.h"=0A=
+#include "system/dma.h"=0A=
+#include "system/address-spaces.h"=0A=
 #include "trace.h"=0A=
 =0A=
 /* Root / Global registers (offset from the controller base) */=0A=
@@ -51,6 +61,7 @@ REG32(UDC_EP0_CTRL, 0x30)=0A=
     FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)=0A=
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
 REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
+    FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)=0A=
 /* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
 REG32(UDC_SETUP0, 0x80)=0A=
 REG32(UDC_SETUP1, 0x84)=0A=
@@ -70,6 +81,8 @@ REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
 =0A=
+#define ASPEED_UDC_EP0_MAXPKT      64=0A=
+=0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
     bool level;=0A=
@@ -82,6 +95,176 @@ static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
     qemu_set_irq(s->irq, level);=0A=
 }=0A=
 =0A=
+static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)=0A=
+{=0A=
+    s->regs[R_UDC_ISR] |=3D mask;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * System bus device: MMIO register interface (guest gadget-driver facing)=
=0A=
+ */=0A=
+=0A=
+/* Connect/disconnect the gadget device from the host bus */=0A=
+static void aspeed_udc_set_pullup(AspeedUDCState *s, bool on)=0A=
+{=0A=
+    USBDevice *udev;=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!s->usbgadget) {=0A=
+        /* no gadget device bound to this controller */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    udev =3D USB_DEVICE(s->usbgadget);=0A=
+    if (!udev->port) {=0A=
+        /* not attached to a host controller bus */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_pullup(on, udev->attached);=0A=
+    if (on && !udev->attached) {=0A=
+        usb_device_attach(udev, &err);=0A=
+        if (err) {=0A=
+            warn_report_err(err);=0A=
+        }=0A=
+    } else if (!on && udev->attached) {=0A=
+        usb_device_detach(udev);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Complete the in-flight EP0 control transfer back to the host */=0A=
+static void aspeed_udc_ep0_complete(AspeedUDCState *s, uint32_t len)=0A=
+{=0A=
+    USBPacket *p =3D s->ep0_packet;=0A=
+=0A=
+    if (!p) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep0_packet =3D NULL;=0A=
+    p->actual_length =3D s->ep0_dir_in ? MIN(len, s->ep0_setup_len)=0A=
+                                     : s->ep0_setup_len;=0A=
+    p->status =3D USB_RET_SUCCESS;=0A=
+    trace_aspeed_udc_ep0_complete(s->ep0_dir_in, p->actual_length);=0A=
+    usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep0_tx_ready(AspeedUDCState *s, uint32_t val)=0A=
+{=0A=
+    uint32_t txlen =3D FIELD_EX32(val, UDC_EP0_CTRL, TX_LEN);=0A=
+    uint32_t data_buf_addr =3D s->regs[R_UDC_EP0_DATA_BUFF];=0A=
+    USBPacket *p;=0A=
+    uint32_t n;=0A=
+=0A=
+    if (!s->ep0_dir_in) {=0A=
+        /* Status stage IN (zero length) for an OUT / no-data transfer */=
=0A=
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
+        aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+        return;=0A=
+    }=0A=
+    /* no control transfer is waiting: nothing to send */=0A=
+    if (!s->ep0_packet) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN data stage: copy from the guest gadget driver's DMA buffer */=0A=
+    n =3D MIN(txlen, s->ep0_setup_len - s->ep0_offset);=0A=
+    if (n && address_space_read(&s->dram_as, data_buf_addr,=0A=
+                                MEMTXATTRS_UNSPECIFIED,=0A=
+                                s->ep0_data + s->ep0_offset,=0A=
+                                n) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: EP0 IN DMA read failed\n", __func__);=0A=
+        p =3D s->ep0_packet;=0A=
+        s->ep0_packet =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        return;=0A=
+    }=0A=
+    s->ep0_offset +=3D n;=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);=0A=
+    if (txlen < ASPEED_UDC_EP0_MAXPKT || s->ep0_offset >=3D s->ep0_setup_l=
en) {=0A=
+        aspeed_udc_ep0_complete(s, s->ep0_offset);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep0_rx_ready(AspeedUDCState *s)=0A=
+{=0A=
+    uint32_t data_buf_addr =3D s->regs[R_UDC_EP0_DATA_BUFF];=0A=
+    USBPacket *p;=0A=
+    uint32_t n;=0A=
+=0A=
+    if (s->ep0_dir_in) {=0A=
+        /* Status stage OUT (zero length) following IN data */=0A=
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+        return;=0A=
+    }=0A=
+    /* no control transfer is waiting: nothing to receive */=0A=
+    if (!s->ep0_packet) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* OUT data stage: hand host data to the guest gadget driver */=0A=
+    n =3D MIN(s->ep0_setup_len - s->ep0_offset, ASPEED_UDC_EP0_MAXPKT);=0A=
+    if (n && address_space_write(&s->dram_as, data_buf_addr,=0A=
+                                 MEMTXATTRS_UNSPECIFIED,=0A=
+                                 s->ep0_data + s->ep0_offset,=0A=
+                                 n) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: EP0 OUT DMA write failed\n", __func__);=0A=
+        p =3D s->ep0_packet;=0A=
+        s->ep0_packet =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        return;=0A=
+    }=0A=
+    s->ep0_offset +=3D n;=0A=
+    s->regs[R_UDC_EP0_CTRL] =3D FIELD_DP32(s->regs[R_UDC_EP0_CTRL],=0A=
+                                         UDC_EP0_CTRL, RX_LEN, n);=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The guest gadget driver drives EP0 by writing UDC_EP0_CTRL. Translate=
=0A=
+ * those writes into data movement to/from the deferred host control packe=
t=0A=
+ * plus the matching ACK interrupts the guest gadget driver expects.=0A=
+ */=0A=
+static void aspeed_udc_ep0_ctrl_write(AspeedUDCState *s, uint32_t val)=0A=
+{=0A=
+    USBPacket *p;=0A=
+=0A=
+    trace_aspeed_udc_ep0_ctrl_write(val, s->ep0_dir_in, s->ep0_offset);=0A=
+=0A=
+    if (val & R_UDC_EP0_CTRL_STALL_MASK) {=0A=
+        /* Gadget stalled EP0: fail the pending control transfer */=0A=
+        if (s->ep0_packet) {=0A=
+            p =3D s->ep0_packet;=0A=
+            s->ep0_packet =3D NULL;=0A=
+            p->status =3D USB_RET_STALL;=0A=
+            usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);=
=0A=
+        }=0A=
+    } else if (val & R_UDC_EP0_CTRL_TX_RDY_MASK) {=0A=
+        s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_TX_RDY_MASK;=0A=
+        aspeed_udc_ep0_tx_ready(s, val);=0A=
+    } else if (val & R_UDC_EP0_CTRL_RX_RDY_MASK) {=0A=
+        s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_RX_RDY_MASK;=0A=
+        aspeed_udc_ep0_rx_ready(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* The upstream-enable bit connects/disconnects the gadget device */=0A=
+static void aspeed_udc_func_ctrl_write(AspeedUDCState *s, uint32_t val)=0A=
+{=0A=
+    bool was_on =3D FIELD_EX32(s->regs[R_UDC_FUNC_CTRL],=0A=
+                             UDC_FUNC_CTRL, UPSTREAM_EN);=0A=
+    bool now_on =3D FIELD_EX32(val, UDC_FUNC_CTRL, UPSTREAM_EN);=0A=
+=0A=
+    if (now_on !=3D was_on) {=0A=
+        aspeed_udc_set_pullup(s, now_on);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size=
)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
@@ -104,6 +287,11 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
     trace_aspeed_udc_write(offset, val);=0A=
 =0A=
     switch (reg) {=0A=
+    case R_UDC_FUNC_CTRL:=0A=
+        val &=3D 0x000e1fff;=0A=
+        aspeed_udc_func_ctrl_write(s, val);=0A=
+        s->regs[R_UDC_FUNC_CTRL] =3D val;=0A=
+        break;=0A=
     case R_UDC_IER:=0A=
     case R_UDC_EP_ACK_IER:=0A=
     case R_UDC_EP_NAK_IER:=0A=
@@ -116,6 +304,16 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
         s->regs[reg] &=3D ~val;=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
+    case R_UDC_EP0_CTRL:=0A=
+        s->regs[reg] =3D val & (R_UDC_EP0_CTRL_STALL_MASK |=0A=
+                              R_UDC_EP0_CTRL_TX_RDY_MASK |=0A=
+                              R_UDC_EP0_CTRL_RX_RDY_MASK |=0A=
+                              R_UDC_EP0_CTRL_TX_LEN_MASK);=0A=
+        aspeed_udc_ep0_ctrl_write(s, val);=0A=
+        break;=0A=
+    case R_UDC_EP0_DATA_BUFF:=0A=
+        s->regs[reg] =3D val & R_UDC_EP0_DATA_BUFF_BASE_ADDR_MASK;=0A=
+        break;=0A=
     default:=0A=
         s->regs[reg] =3D val;=0A=
         break;=0A=
@@ -175,6 +373,7 @@ static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
 static void aspeed_udc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+    USBDevice *udev;=0A=
     int i;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
@@ -186,6 +385,21 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTy=
pe type)=0A=
     s->regs[R_UDC_DEV_RESET] =3D (R_UDC_DEV_RESET_ROOT_MASK |=0A=
                                 R_UDC_DEV_RESET_DMA_MASK |=0A=
                                 R_UDC_DEV_RESET_EP_POOL_MASK);=0A=
+    s->ep0_packet =3D NULL;=0A=
+=0A=
+    /*=0A=
+     * A guest reboot resets the controller but leaves the USB device=0A=
+     * attached to the host bus with no guest gadget driver behind it.=0A=
+     * Detach it, otherwise the rebooted host fails to re-enumerate the=0A=
+     * driverless gadget device; it re-attaches when the new driver assert=
s=0A=
+     * pull-up.=0A=
+     */=0A=
+    if (s->usbgadget) {=0A=
+        udev =3D USB_DEVICE(s->usbgadget);=0A=
+        if (udev->attached) {=0A=
+            usb_device_detach(udev);=0A=
+        }=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_realize(DeviceState *dev, Error **errp)=0A=
@@ -194,6 +408,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
     AspeedUDCState *s =3D ASPEED_UDC(dev);=0A=
     int i;=0A=
 =0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_UDC ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+    address_space_init(&s->dram_as, s->dram_mr, "dram");=0A=
+=0A=
     memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,=0A=
                        ASPEED_UDC_MEM_SIZE);=0A=
     memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,=0A=
@@ -218,6 +438,11 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
     sysbus_init_irq(sbd, &s->irq);=0A=
 }=0A=
 =0A=
+static const Property aspeed_udc_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("dram", AspeedUDCState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+};=0A=
+=0A=
 static void aspeed_udc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -226,6 +451,129 @@ static void aspeed_udc_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->desc =3D "ASPEED USB Device Controller";=0A=
     dc->realize =3D aspeed_udc_realize;=0A=
     rc->phases.hold =3D aspeed_udc_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_udc_properties);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * USB device: gadget device presented on a host controller's bus=0A=
+ *=0A=
+ * These callbacks run in the context of the host controller. They transla=
te=0A=
+ * host transactions into the controller interrupts/state the guest gadget=
=0A=
+ * driver expects, then defer (USB_RET_ASYNC) until the driver responds=0A=
+ * through the MMIO register interface above.=0A=
+ */=0A=
+=0A=
+static void aspeed_udc_gadget_handle_reset(USBDevice *udev)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+=0A=
+    s->ep0_packet =3D NULL;=0A=
+    s->ep0_offset =3D 0;=0A=
+    /* The EHCI host is High-Speed; advertise it to the guest gadget drive=
r */=0A=
+    s->regs[R_UDC_STS] =3D R_UDC_STS_HIGHSPEED_MASK;=0A=
+    trace_aspeed_udc_reset(s->regs[R_UDC_IER]);=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_BUS_RESET_MASK);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p=
,=0A=
+                                          int request, int value, int inde=
x,=0A=
+                                          int length, uint8_t *data)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    uint8_t req =3D request & 0xff;=0A=
+    uint8_t type =3D request >> 8;=0A=
+=0A=
+    /*=0A=
+     * Reconstruct the 8-byte SETUP packet into the SETUP data buffer wher=
e=0A=
+     * the guest gadget driver reads it from.=0A=
+     */=0A=
+    s->regs[R_UDC_SETUP0] =3D type | (req << 8) | ((value & 0xffff) << 16)=
;=0A=
+    s->regs[R_UDC_SETUP1] =3D (index & 0xffff) | ((length & 0xffff) << 16)=
;=0A=
+=0A=
+    /* A new SETUP clears the EP0 STALL condition */=0A=
+    s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_STALL_MASK;=0A=
+=0A=
+    s->ep0_packet =3D p;=0A=
+    s->ep0_data =3D data;=0A=
+    s->ep0_setup_len =3D length;=0A=
+    s->ep0_offset =3D 0;=0A=
+    s->ep0_dir_in =3D (type & USB_DIR_IN);=0A=
+=0A=
+    trace_aspeed_udc_ep0_setup(type, req, value, index, length,=0A=
+                               s->ep0_dir_in, udev->addr);=0A=
+=0A=
+    /*=0A=
+     * SET_ADDRESS is delivered while the device still answers at the defa=
ult=0A=
+     * address 0 and carries the new address in wValue. The host controlle=
r=0A=
+     * keeps this transfer's queue bound to address 0 until it completes, =
so=0A=
+     * apply the new address synchronously as the transfer completes.=0A=
+     * Completing it asynchronously (USB_RET_ASYNC) would change udev->add=
r=0A=
+     * while the queue is still bound to 0; the host controller sees the=
=0A=
+     * mismatch, tears the queue down and enumeration breaks. The guest ga=
dget=0A=
+     * driver is still notified so its state machine advances.=0A=
+     */=0A=
+    if (type =3D=3D 0 && req =3D=3D USB_REQ_SET_ADDRESS) {=0A=
+        udev->addr =3D value;=0A=
+        s->ep0_packet =3D NULL;=0A=
+        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);=0A=
+    p->status =3D USB_RET_ASYNC;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)=
=0A=
+{=0A=
+    /* Programmable endpoint (bulk) transfers are added in a later patch. =
*/=0A=
+    p->status =3D USB_RET_STALL;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+=0A=
+    if (s->ep0_packet =3D=3D p) {=0A=
+        s->ep0_packet =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)=0A=
+{=0A=
+    AspeedUDCGadget *dev =3D ASPEED_UDC_GADGET(udev);=0A=
+=0A=
+    if (!dev->udc) {=0A=
+        error_setg(errp, TYPE_ASPEED_UDC_GADGET ": 'udc' link is not set")=
;=0A=
+        return;=0A=
+    }=0A=
+    /* Bind this gadget device to its controller */=0A=
+    dev->udc->usbgadget =3D dev;=0A=
+=0A=
+    udev->auto_attach =3D 0;=0A=
+    /* The ASPEED UDC is USB 2.0, so it only runs at High-Speed for now */=
=0A=
+    udev->speed =3D USB_SPEED_HIGH;=0A=
+    udev->speedmask =3D USB_SPEED_MASK_HIGH;=0A=
+}=0A=
+=0A=
+static const Property aspeed_udc_gadget_props[] =3D {=0A=
+    DEFINE_PROP_LINK("udc", AspeedUDCGadget, udc, TYPE_ASPEED_UDC,=0A=
+                     AspeedUDCState *),=0A=
+};=0A=
+=0A=
+static void aspeed_udc_gadget_class_init(ObjectClass *klass, const void *d=
ata)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc           =3D "ASPEED UDC gadget device";=0A=
+    uc->product_desc   =3D "ASPEED UDC gadget";=0A=
+    uc->realize        =3D aspeed_udc_gadget_realize;=0A=
+    uc->handle_reset   =3D aspeed_udc_gadget_handle_reset;=0A=
+    uc->handle_control =3D aspeed_udc_gadget_handle_control;=0A=
+    uc->handle_data    =3D aspeed_udc_gadget_handle_data;=0A=
+    uc->cancel_packet  =3D aspeed_udc_gadget_cancel_packet;=0A=
+    device_class_set_props(dc, aspeed_udc_gadget_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_udc_types[] =3D {=0A=
@@ -235,6 +583,12 @@ static const TypeInfo aspeed_udc_types[] =3D {=0A=
         .instance_size =3D sizeof(AspeedUDCState),=0A=
         .class_init    =3D aspeed_udc_class_init,=0A=
     },=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_UDC_GADGET,=0A=
+        .parent        =3D TYPE_USB_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedUDCGadget),=0A=
+        .class_init    =3D aspeed_udc_gadget_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_udc_types)=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index ed05304520..098c3d6179 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -383,4 +383,9 @@ aspeed_udc_read(uint64_t offset, uint32_t value) "offse=
t 0x%" PRIx64 " value 0x%=0A=
 aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
 aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
+aspeed_udc_pullup(int on, int attached) "on %d, attached %d"=0A=
 aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x,=
 level %d"=0A=
+aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"=0A=
+aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t i=
ndex, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bReques=
t 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"=0A=
+aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val =
0x%x, dir_in %d, off %u"=0A=
+aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"=0A=
-- =0A=
2.53.0=0A=

