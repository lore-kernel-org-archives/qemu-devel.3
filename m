Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B2C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yDA-0001gK-AH; Mon, 31 Aug 2026 05:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yD8-0001eq-Pv; Mon, 31 Aug 2026 05:21:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yD5-0004pf-DE; Mon, 31 Aug 2026 05:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EldgJdQBQXZ+yyzMUXtS1UpbWSqXgOyAvlA45v7CtWjJxoS++nQ6dFMwz7KcVUzUlJVt1sMMBEYj2V5qLXmAC4MDiWNo4e8koVWmsZamfwTGcMoebSqQbi+kJv10S3f04iljZTEAoBRBAbqETx8AGuVRVi5RxFoNVlF+hN1B1Mg/Dgio5fNJtQ1QgNEAEA1iH8hqxBubOsWGJdP5tuwolysmrNyPKxUk4YhQDTarZk02V+Z33NDfaMzkmD1bU+3Sq6oWnfCXqichABs9lWe5UUF/3dQmxT2ANHqqzyrcSD++I5Cd+g65GhiAbmq6TfjpAr5BN8bbQ/vwsATcDzI48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM6sIbs6ScavmOL15Znye+6UfvicmG1rYq9Jz7dsFC8=;
 b=hiX88m5aq/z+wMbBhrkIcPQfiU5PBSOxD9Ql6dzfxb3iO5rPNcFZpnZP/ZaXUupRL3ndcAd4NCMBcO/4FrVvebvzNXp0B/VD0FQXaFtpCKpPJ6fAhErK+TUjFI7IE+SE5WkzxKgXXG7/L9XKiu2U9PW03DP1LUzFEGFDwHkzmbk5ZhddBR0lPD7/qJMmOmFzM38Trlr0ObSN3piNPV/0uT81Rtk3frZ4cHQnIH+4KBc+PzuekfVVut8Y5cs4a0pDRTSk6OuGBEDzNhTlgHU+wznGIQL3BKa5E6SAI6WPQYv2y2B3J0T3MpRunwvyK9hwvdgtVVc6GhmgXCyJi18roA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM6sIbs6ScavmOL15Znye+6UfvicmG1rYq9Jz7dsFC8=;
 b=dw3uEN8ytlrI3CuEjw2G+jwBSNQ2SPMQMUC2QuYADC7nCZyNzLftldjUTaRxH1Tnw8zSfIJiU+Acq98h8JtBaL1U2UhneS5xec1d41JCqZ348V1wcPMu9CsAWwfivkfyd4UnIneFfU+xOZJwikYXes4TZcNsF5+9uMGcW4Ll74g/4xrE5xma0z7BhssvSqjsKue9vD3KboCAhzaTrE2x7FeLl9HdSOXnknYtEx1s85qNj2PgITuWvvG5/Ckif6+ia1XFhWkh5UrjPHKy9505HSiixGg9BT64yZVNzNnWiZvwOFOMceArW6SaFVlJTGoYZaWe/u4iKuBzzDTTRoxgLg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5933.apcprd06.prod.outlook.com (2603:1096:301:11a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:21:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:21:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Thread-Topic: [PATCH v3 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB
 device
Thread-Index: AQHdOSoahnLgZcyL2E+qxvbSuSCwBQ==
Date: Mon, 31 Aug 2026 09:21:28 +0000
Message-ID: <20260831092125.1022201-3-jamin_lin@aspeedtech.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5933:EE_
x-ms-office365-filtering-correlation-id: 318ceef3-9b65-4e9b-9bed-08df07413d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|3023799007|38070700021|6133799003|5023799004|10067099003|921020;
x-microsoft-antispam-message-info: 7ZyEYT05c+paShlhA70PTpB571tTFWF0xT/EmGE9rCw53fFe2UwF3pjElCMqyAzidRyfqqFOHeV//alv3J1CNCqLa8MSXrqjapHZxKEnbhTede9GauUZLj05jKJhQVkbFX76wsJ4eIqU1unwRGK8xTfWv1XuxM2G6CQup7jJyk7YxX2TIcaY9fnPWCg/lXJuaarOWpzDe/0NHhbms2a1wZ1m5NQYnX3FDF5qdycVlERsRfyZnu0uemQQnME6nSmCbMLBxOGNzZlUGfHLComjKgW6oeQK/OCspzja2xgAv4WbyS6MKn/yloKqrei3mE+BZ7Vk9yqxxtrT1na7yAXGLBIckqq3yTVX18ctwi8B6VDR6KqWsHGYQsCroyLx0SBTwxYnnAHpiUl8e530Zb6WOy9pZSWS3xf7zHFONvgGMEnd/4Ew+GqJUJ7O5Rj8a1Q2mYmsZAydrahuTB98h7bDUmuGMtRfGp5RU6xsjrRYcqwlVOhpyB0y+XJa0wj5p2J3YqOvXMHuBme2QA6Yc1Aph4+ax/1YRvR94/DhGR582ffoAKNhGB+1JbobSfVuFHv27hAw6cYNP+xxzRnCxfYUpHdzANEDZhUQglOjedDqGCCWCJ1jcVusrzHdO78BCEmO7ZWH/KpC/8iy/ryB75TGIggFG8Wuv+YN6TjhYic0lU3chI0a6gpboyeQsbaM5S6TqFjoMBULsCCyblVSfnhxfhK/DcNLXH4EMgCdE3NZlhK46Ip0RjKLpDvYtAZk37Iw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(5023799004)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+EdBwlw5KmH76Bvfi2ZUkD3Hgsq6DyeOlkeHiBTlfZv+S71yxOoAyR6Eb/?=
 =?iso-8859-1?Q?clC6fPVVFcqAoGC+woO01OrpCyVl593AKVCOsMyWP7ZajHSBTyZZmE6sTX?=
 =?iso-8859-1?Q?+2cbUfZpFuNwvhhw7ivMY9ig2ESvv03mpFXRFWDFoYDu+rIKL0+ARkCQl4?=
 =?iso-8859-1?Q?p4UwsZ3TxsYEojh8LkAxXXqUGtRjetixvMARFGGfeAV3D735jk493lZhpP?=
 =?iso-8859-1?Q?Kw78wEysxY/wh3ZQpt9yLpD02yMGiBJrDHmCkliRc/3m+Toccd3ydsDHYE?=
 =?iso-8859-1?Q?4u1pTjn4gsC9Hwu+2ECeOXBgT3sPEJAU+jpxSyK/NCAnrCSy0zaUzZs6Yf?=
 =?iso-8859-1?Q?BCW0djJZe+kAbpThStkta8WkasT4p0LegPOUCK6Xc+MDURfJEPUGM4j0AJ?=
 =?iso-8859-1?Q?BnVAtLFQ2Yu6EYJ53XHT95rtnKsxrwMI0uDdKUtRVzfIyeqefjSXk4dKLo?=
 =?iso-8859-1?Q?HKgL75H4DI69L+gBv3QZMIux2dNIpcbKjsjjgaemsTXGAGhysXR6wL1TNt?=
 =?iso-8859-1?Q?HtbD6utDpvwJrR2YhajFV1GZafm/rDXwzbCzJtLV4RJnB/pTefD0zZA16B?=
 =?iso-8859-1?Q?pYGrRPDURpNqbzUwFmtLB87NhFiwqysmW0b7Z4NEQFHVBNcUnTlqh1xkX8?=
 =?iso-8859-1?Q?pRvpEkgwk5TYZaGQ5i7JcPeHHEm9aV43H1HpcBXMZiimxl80XP3z7IIuuv?=
 =?iso-8859-1?Q?AADkXnuwWfT1l0OAVO7f9ZjFPGoa22fwIiOp77sRa/41y5Vr3/XvfEuHx6?=
 =?iso-8859-1?Q?kH9gMhvbHy4RC93OhHkIDTzAhRHKmPpDb0zPfOweizBDs45DDw/3cJR3Bb?=
 =?iso-8859-1?Q?aIgRLDdaOPaQk7UQ71D7vdaaEPx7urz4f7WGgG9Wzz5EYyDqtf/CR5FekX?=
 =?iso-8859-1?Q?rjv/W5APRRKS9C32I5SPI5y/jAiVJ6eFAKEa0hH99RDVCGWfVVDN6Q0SOx?=
 =?iso-8859-1?Q?9d3sBMnV6Xsg64lMUvWw4XzgnZ1nj5ZfuY7Ezj1H2IZ6QGds5uqU5Cpmu5?=
 =?iso-8859-1?Q?mwG+02WXgJl/YQh/eP/0lMbYEKBf1dv+FXLr2exYZDya4eCkC4ki0fY8ia?=
 =?iso-8859-1?Q?vaCTsVPusbQWLg1DM6nGYWkYaGU9kVkRD5bcUzhwmvTD1nNmUiscaEi4Cq?=
 =?iso-8859-1?Q?IyziI8loovNoxWsa1w7UpZMQSjJgl/Gcp4tPpWQhO2wG6GdrTRWM+pZk6x?=
 =?iso-8859-1?Q?aWxZH8mzXRBzOBhOjnqqe57yD5QUuAigaNmVbJIIRjA8+RFJ3AXqmNLWd7?=
 =?iso-8859-1?Q?nhp/4H8VBMGr36uBrKqEHYtBwhW6RkbIKNcMyaZuDuu+DxcI/TpdaS5TI9?=
 =?iso-8859-1?Q?amGNAhMc9g9butLLPB0Zz7F4re5nBrCh6r+UDKFtDsBOQJvBre3lYOLr8d?=
 =?iso-8859-1?Q?R8aSZ3TfiOb37yN50P2AD31uduNex4JfMSznJB30pjDbtrByZ6HVlbIrrf?=
 =?iso-8859-1?Q?VzT27TrL8609JRjuZNH2k/YI0Q67wrMBbxCxBreoofi+Q6s6feVKJCVkbC?=
 =?iso-8859-1?Q?tC1WoaVaqxUwbMKRaMHjIsyWpuzazTaxEiTpKLhKGGo3EEPRE49lIuqAQk?=
 =?iso-8859-1?Q?ossZPoVQTq+4zpY52xSz9gHw1dKLD6weEnE9UrhxzRz+Pu/5XMkEadGhJe?=
 =?iso-8859-1?Q?g18azM2OztY3d6BHlHxwPFrl4JYhR5YICko2GmvYS9GxdiuWCCoOdOXDoE?=
 =?iso-8859-1?Q?00GgehLytyrTyahoiXoBxraBYp1uP7TJo4UBtIi3E16N68Oy+MkCA3uOkM?=
 =?iso-8859-1?Q?yjxogixztQkgaNgt9H/cKcA7f4JGZ5Lw7STlpFpvV8WnjdVlNIxG7+GwKv?=
 =?iso-8859-1?Q?wvLVp10rFQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: igIx/3uOWB2dfzXQCbagjhmlZ7PMEHvROwD9KuyOvMQtvGp1wJ7fHFHptGyN8bZRE0Gp/gfAHqXwzTcCgOV8Gdg3J7ngP2VmRwLrnlDCQWWD0WSSu3wy/Xo48kbiuER4v7rAc/RtyBYNo/dnvV2Z3WN3c/BIk12NTUl6YXv0YxRanhvfxK7wflDt+Woc9IaTngRvgszcesd4NHF+82fQrchtrSLbO+dEp3HFSzXyFiD+4rmRYFWwJCkempjteGKd4JzCY0Fs3vcMiCWBuGC6hYp5/dG+eCuT5+NCJwZu2QHZmdz79yTS8bbGvhpooIzZqTNRziofv1CnCjxDsYHqVA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318ceef3-9b65-4e9b-9bed-08df07413d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:21:28.5226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEFyHgluZcKHO9WJPIcSkln7iGbHrldyeGIaWlbC7n5xFP1nLhnDWRduC8qYsTux3V8IZX4v9WhowpnL4QEWj/dDb9AxTdqmSV+WVxzD+3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5933
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
 hw/usb/aspeed-udc.c         | 382 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   5 +=0A=
 3 files changed, 412 insertions(+), 3 deletions(-)=0A=
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
index cd773e979b..70a2296062 100644=0A=
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
@@ -47,6 +57,7 @@ REG32(UDC_EP0_CTRL, 0x30)=0A=
     FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)=0A=
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
 REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
+    FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)=0A=
 /* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
 REG32(UDC_SETUP0, 0x80)=0A=
 REG32(UDC_SETUP1, 0x84)=0A=
@@ -66,6 +77,8 @@ REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
 =0A=
+#define ASPEED_UDC_EP0_MAXPKT      64=0A=
+=0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
     bool level;=0A=
@@ -78,6 +91,176 @@ static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
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
+        /* Status stage OUT (zero length) for an IN transfer */=0A=
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
@@ -100,6 +283,11 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
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
@@ -112,6 +300,16 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
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
@@ -171,6 +369,7 @@ static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
 static void aspeed_udc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+    USBDevice *udev;=0A=
     int i;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
@@ -182,6 +381,21 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTy=
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
@@ -190,6 +404,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
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
@@ -214,6 +434,20 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
     sysbus_init_irq(sbd, &s->irq);=0A=
 }=0A=
 =0A=
+static const Property aspeed_udc_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("dram", AspeedUDCState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+};=0A=
+=0A=
+static void aspeed_udc_init(Object *obj)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+=0A=
+    object_property_add_link(obj, "usbgadget", TYPE_ASPEED_UDC_GADGET,=0A=
+                             (Object **)&s->usbgadget,=0A=
+                             object_property_allow_set_link, 0);=0A=
+}=0A=
+=0A=
 static void aspeed_udc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -222,6 +456,141 @@ static void aspeed_udc_class_init(ObjectClass *klass,=
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
+    /* Bind this gadget to its controller through the link property */=0A=
+    object_property_set_link(OBJECT(dev->udc), "usbgadget", OBJECT(dev),=
=0A=
+                             &error_abort);=0A=
+=0A=
+    udev->auto_attach =3D 0;=0A=
+    /* The ASPEED UDC is USB 2.0, so it only runs at High-Speed for now */=
=0A=
+    udev->speed =3D USB_SPEED_HIGH;=0A=
+    udev->speedmask =3D USB_SPEED_MASK_HIGH;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_gadget_unrealize(USBDevice *udev)=0A=
+{=0A=
+    AspeedUDCGadget *dev =3D ASPEED_UDC_GADGET(udev);=0A=
+=0A=
+    if (dev->udc && dev->udc->usbgadget =3D=3D dev) {=0A=
+        object_property_set_link(OBJECT(dev->udc), "usbgadget", NULL,=0A=
+                                 &error_abort);=0A=
+    }=0A=
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
+    uc->unrealize      =3D aspeed_udc_gadget_unrealize;=0A=
+    uc->handle_reset   =3D aspeed_udc_gadget_handle_reset;=0A=
+    uc->handle_control =3D aspeed_udc_gadget_handle_control;=0A=
+    uc->handle_data    =3D aspeed_udc_gadget_handle_data;=0A=
+    uc->cancel_packet  =3D aspeed_udc_gadget_cancel_packet;=0A=
+    device_class_set_props(dc, aspeed_udc_gadget_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_udc_types[] =3D {=0A=
@@ -229,8 +598,15 @@ static const TypeInfo aspeed_udc_types[] =3D {=0A=
         .name          =3D TYPE_ASPEED_UDC,=0A=
         .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
         .instance_size =3D sizeof(AspeedUDCState),=0A=
+        .instance_init =3D aspeed_udc_init,=0A=
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

