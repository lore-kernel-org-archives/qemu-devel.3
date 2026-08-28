Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB64C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsVo-0005W9-E9; Fri, 28 Aug 2026 05:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVh-0005UD-Vw; Fri, 28 Aug 2026 05:04:30 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVc-0003UD-Tm; Fri, 28 Aug 2026 05:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgvBu9jKkREnI6kL/4R4DmFvniITQZakKcRB5REDytpKgo7tmL8lMNqurVqYC+s2GKeRnUQTXS/auL011khP2Ea3bdeB8ac2QsK/xt8wfmC9kSLdwLLUfaqvO1y3ykNnDLKkAMnlw9BiKM4LPBcS7dcaSBCW4PVNz7wTTFu633jW5JI+WmbenQm9ceFG27c0vF6yyzyjvZUFIY5PayOrjw13X6RY21UHpYWPcU/oT1GHcHwNtJ0HknMi0NXiCGrmZV65cbV4C0HWgSCUyZLesSOvzmZj/6SV0ST0dX5xnQ/5lmiaRraz2lIwYD1wQsMjROebyJ3nEJyntMAFsnFiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6IZlubGuClecVsd46mdG2HtqCVMlmGOFnPNrIwbPQk=;
 b=foCPNYR0rTOOSN4WlCehaOo7wAdf3KsSkkTbfGtaWfXnJMrLbhwHvRfBdw7s2lkr1Hq3+/TFZfAAR3NdvVr4fccOFO+1dMWdrvdY1gDu+RbtqO6LMfxiSoMHyZPiWmKkNuapBdYakLN2yLIyPhUjrLG/XZkl0ynjjp7mX/w//UgZhgVUAGnpxjLpQYCs8OLqYl7uD/ThbWkwg+f81HMLBdV2pQIKASvzqJpdJ2K3zNjprpOxZDxAAMuAQ8UEicQHdo+a3VjNedEv/UjyXfZh1L/8xTgFoEkUhGFuz6PRdYLTfn4ghbyoQwTTL55N1YyHEeZrGnHV75AIRLMAFZPLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6IZlubGuClecVsd46mdG2HtqCVMlmGOFnPNrIwbPQk=;
 b=k+GrWskLWXjYR7wjr2oAPmTTlwsECgu/922Urit+e/eyA7bmtZ1VS31MeOoK5GZlyDdZnC5GWsH8LkrrxJt/SbiZq1wfPdX00LdobD4rE/S7FyyLe6za1f9iYV6Wq0KJOMJbFEpiZhu+ZmL5VMKSdZA9kOqnF8vLG4X2v/pbk7omc8NcsQtgO74DFv/BXXLxCOyyLRWeAvkI89+vvfU+6Mx3NRD9APFu5p+iZ5mt1un3Daxutce7EX+RCcUbkzvzjKCTHGdO1y0USECu7C022+VIBa94g8rDGDdlmMLoHQKXmFXltMhjf1Z+tEovfCLMW13rVOrVHVBIx4Wsce0mpw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6209.apcprd06.prod.outlook.com (2603:1096:820:d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:14 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Topic: [PATCH v2 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Index: AQHdNswyW9zsGJ3nNU2vIZEAxhFFHg==
Date: Fri, 28 Aug 2026 09:04:13 +0000
Message-ID: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6209:EE_
x-ms-office365-filtering-correlation-id: e3e47987-0753-48e0-e0db-08df04e354f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|6133799003|3023799007|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: GOVxUnThG3NgkKKES5xOskzqpchTLZIkOFIClEl+tlJV09vOH0vgpDymhGvdBG5nYM7ybLyS83uwdYFOwktMKsGiuZ98k+nLN8wcUBEgp0jtB1BVMhRAFWwM3raSH3sjAHiia5QMO7yTVzCHzVpNE/2GUt1REiKk8SMUiEpYQBsqNMJmFOoRapO4R2GbsvOHJe3VFayXzEnCQr8mEDWo6wCgk40mO9MsMIXlWo44o9mlQeDc6WV8E5ThDDG1DU4643JtsHlKcUzyM9MAiJ6levgNSG+JKwhAmg0vMQyo9RCOUc7PMB8MXoqESSyppMAp7EsKHdPmOKsorMl9FdhYQSYiO+2z6BCOsXpAqgOi6AO1N8iwf+iGODol9U6FsYYezu32gCNSh2iofNypFyrdUB/88gsp9bC2iRZj8/Sg4vPZtPjkf6Fg+KA7ph+fGauF2OHfIIjzzlUdeVOAuNIetM8+LKmHxzPFsacFVJlmnWMNBCOGciHEMLLBICnGkD5vm+2ZCy1MWmDHr5prudejeeO1XbctEhaQBC4BGjvBmNYCeGSeQ6bVwBT3ln8V0r9J/qyG5LlmatYaY/rC1Khzf3RSQlWTpBX4NfhlBP3dtME4+IHntp/lrZLL5eCHGyGLhf2M6gFurtLO/A7tDW5xyEiLuKyrpnJuy8YmWRCH6+36+ULmIB9UaIYKr/qdvLIIK5BGXelNl2v1DXYEJnlAz1fGUGz9q8SDfGMq9xTS50k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HfAuY3ymQUsKsEr+MRrvS5iHefT2yw3yFhi1/PXjHe1c5K+RFEgs1M8Ta/?=
 =?iso-8859-1?Q?JTqSKH5JtTIWHkEyrWOiaIqDAk7ZeiuocsZxdzumadNuTiPlHFA5VITxxS?=
 =?iso-8859-1?Q?gN1SGLk443bJIvY9Q5gNZW35Mf+e0AQZFSecS99+j4r2nm+zilg0mDIDJ1?=
 =?iso-8859-1?Q?9E8DfTYC0a+MH0sHqmWjZnaDIY0EzbuY0sk5fIP6tcvgz+3MgrZl68eLa7?=
 =?iso-8859-1?Q?1oDsS/uNu8nfgY9QRscmIpnEXup08tfgxA2my7FP1WIPju0Q2ETcp7lPOv?=
 =?iso-8859-1?Q?isMALglIyLjPPu9smPa0uWmpEvqUpGRnI2LCeljyWCKrkR7ApNBNjJsHBO?=
 =?iso-8859-1?Q?tya2ICVvHQ5DxSC4MYmOelPmpaXgi4rXcV64qGUPe0C2AnOsTwi9+wzGXq?=
 =?iso-8859-1?Q?/PtlbIdDKtUmLSqwZJw8Meof+6vMNDOtlT3JnGUfmazSJda0SENTxJaZi4?=
 =?iso-8859-1?Q?Gpxpt6NaDsbGq5NeI2jabdmM6Z2fWJDFXUu3PDApF0gr3HaMYdSJmNn6+b?=
 =?iso-8859-1?Q?i2s6TcfUoTbf71UTP0EIkgbOjgY6PhkoOJawNfoT653uao5tL7uIp08qWe?=
 =?iso-8859-1?Q?B4n4iY4+f5NMkM5OtVn+bTz6nFV8v36IbQikyq5t3qA4RJK1doMpOyaRr0?=
 =?iso-8859-1?Q?M/gsPiGsCzSC8N4GMTUiDgxzuvRo4cVKPeqJSmrUbYedUj8xmEsvQtSMjW?=
 =?iso-8859-1?Q?uApcrNIUrhH1luQDCAdSuQJWiXUci8YuBIzsZbQZ7hRGFVsPDA4kTrR8u5?=
 =?iso-8859-1?Q?pEuDtERgROORSZI08owxAxfboy7ltn6KKtYUb7aXvyL1KmV6ofw7TblOqM?=
 =?iso-8859-1?Q?sUcxkzdiPW6zZgY1n2z2EmEGyK6dL/P3ZTwIbEa7RbIFb9IRYrqa4KPic0?=
 =?iso-8859-1?Q?dZ1lGNL9IGwzd2DSVQISvzMBZMyOWC+IbExy18BRAUgeYwGuQnk+HJljz8?=
 =?iso-8859-1?Q?kzjydOWpDAv9dSt8dDi5W9a+sCCdNh7giVDluFqSrDH/C+BQieOetTfDze?=
 =?iso-8859-1?Q?npbrhxky0gNgAmlzrqg9DlS1zkRU5CJ2qJ7NBl/iIOs9U4IAigQoSFD5IH?=
 =?iso-8859-1?Q?MPwwonFnizJcmFuv+n/7BJCKifZY2x4SXZ6C1J/7PN+yvFLrXektgU1aHb?=
 =?iso-8859-1?Q?xyO3PmQQE5YoM3DIXi6IAitaBqEDxEycWWZrPM7IaLYGXr8d34h5gTmyM5?=
 =?iso-8859-1?Q?arwDBcz5JC8pCysK2MfkmDM0G6w4yLYE82oaJ6sdnPrOA371vW7qIPor6H?=
 =?iso-8859-1?Q?df26ryADSGmUatIyTRIiG8IyC6EYqdmnkqWnLioEEA+ikjnWBis6HAIkV8?=
 =?iso-8859-1?Q?Yc2gIY+jNWCE05/lq816Ox/VaTfZcywSXWXLt3epEEfLQlwNgaRmP5BWRH?=
 =?iso-8859-1?Q?dRgeymeUbd9SGIeQCwerY7PzyVJrcOtb9PkvenQxPh/hQ2S0XuVCjeN/nS?=
 =?iso-8859-1?Q?S4IXjx9FHsb1x3wnt26IQXaMoH1YTdAKHv/i3xT+ngJ+tqGDZYPvv6fDRc?=
 =?iso-8859-1?Q?rkTot5XtnyvPC2sH4RdGp0C2PbZ0qFPDV2Z+EJ7uOIhKLAk4qwhVvMHM7K?=
 =?iso-8859-1?Q?VlV6FUxJ3/44fTSmMEZKEFrmOi7aY2pJwafOk/Sf5J/qDpo4gP1irESGgE?=
 =?iso-8859-1?Q?tFBphO48J0b3NOpdXfgr1v/E92zd82SZ/e8GFjQxLmVdC4QMVxmxItiXem?=
 =?iso-8859-1?Q?EqfgE03e9RZLcrb0p8jhmVbU16wrBCMmnjI+XK/3+/h15W0KTbi3iTnCH5?=
 =?iso-8859-1?Q?TC5vch3cjwHcLN/Oci2XTPwYYxKaQCf30jXGxhXT5G8blIJZ9uq6xjkeDx?=
 =?iso-8859-1?Q?+bIh3USHIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: smCqB7AaS29W87H6+PcaNTLWX+h2Ybi2WfBWaG9zC+oK44WCI+qlgpmKDg/pyhESTY7jnJbnoN/qnerxJ6RCBYh4R1kOqiBJcilNZ59skL7zHG+8xV1EGLIL825SsaNTMc+1VXzOYDKBq0vDzl0dgSsV9cGH6ASBu3AY2hB9FYN2br9SggfGj7Uxx37jQ89bmi+uMdMkGmv/zYGvFyhM8B+YxfQOWXIE06Kqx2DvV7/IOMc4CJXgJpTkyJlA+P85ya6GUWcuKVKGJIgb1n1xPM4nYlab8mUpofbgIWqxxPBpGCIQ6Nyi6Ogx32vaBQoCYNiXdE2TdcqjDocdiWuAdA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e47987-0753-48e0-e0db-08df04e354f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:13.9619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOklFJ+sv6VkiNyWUdB0EuZo0h+GrMQ7BQPUch38FFF9YDeqioru4xIVRAJPtdtfnLyz9ofJlHucReWeve6cHobt5vc9t3fHw+I+tnOgS/s=
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

This series adds a QEMU model for the ASPEED USB Device Controller (UDC),=
=0A=
driven by the Linux "aspeed_udc" gadget driver.=0A=
=0A=
It is the first step of a larger plan to model USB device-side support on=
=0A=
ASPEED BMC/BIC SoCs, which has three goals:=0A=
=0A=
1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host=
=0A=
   (EHCI) controllers, so this series targets the AST2600 UDC: its gadget c=
an=0A=
   be attached to the SoC's own EHCI bus, letting the guest enumerate its o=
wn=0A=
   gadget and exercise the UDC end-to-end.  [this series]=0A=
=0A=
2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC=
=0A=
   needs a second QEMU instance. The plan is to redirect the UDC gadget out=
=0A=
   of the guest using libusbredir and attach it to another QEMU that runs a=
=0A=
   USB host (a VMM, or an AST2600 / AST2700 guest).  [on-going]=0A=
   =0A=
3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media suppo=
rt=0A=
   in QEMU.  [future]=0A=
=0A=
This series implements goal 1 only.=0A=
=0A=
Design=0A=
------=0A=
The UDC is modelled as two QOM objects, because a single object cannot be=
=0A=
both a SysBusDevice and a USBDevice:=0A=
=0A=
  - "aspeed.udc": the sysbus device (MMIO register map, IRQ and DMA engine)=
=0A=
    that the guest gadget driver programs.=0A=
=0A=
  - "aspeed.udc-gadget": a user-creatable USB device presented on a USB hos=
t=0A=
    controller's bus. It links back to its controller through the "udc"=0A=
    property.=0A=
=0A=
The SoC creates the controller; the gadget is added on the command line, e.=
g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
     =0A=
Test result:=0A=
-----------=0A=
The default ASPEED SDK prebuilt image does not enable the UDC driver, so=0A=
build a kernel with CONFIG_USB_ASPEED_UDC=3Dy first.=0A=
=0A=
Start QEMU with the gadget attached to the on-SoC EHCI:=0A=
=0A=
  qemu-system-arm -machine ast2600-evb -drive file=3D<image>,if=3Dmtd,forma=
t=3Draw \=0A=
      -device aspeed.udc-gadget,udc=3D/machine/soc/udc -nographic=0A=
=0A=
In the guest, bring up a mass-storage gadget and verify enumeration and I/O=
:=0A=
=0A=
1. Before: only the host controllers are present=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
2. Enable the gadget=0A=
root@ast2600-default:~# ./usb-storage.sh=0A=
Using UDC: 1e6a2000.usb=0A=
[  598.582205] Mass Storage Function, version: 2009/09/11=0A=
[  598.582635] LUN: removable file: (no medium)=0A=
USB Mass Storage gadget is enabled.=0A=
Backing file: /home/root/jamin=0A=
root@ast2600-default:~# [  598.876395] usb 1-1: new high-speed USB device n=
umber 2 using ehci-platform=0A=
[  599.070035] usb 1-1: New USB device found, idVendor=3D1d6b, idProduct=3D=
0104, bcdDevice=3D 1.00=0A=
[  599.070821] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3=0A=
[  599.071448] usb 1-1: Product: ASPEED USB Storage=0A=
[  599.072687] usb 1-1: Manufacturer: ASPEED=0A=
[  599.073384] usb 1-1: SerialNumber: 1234567890=0A=
[  599.103625] usb-storage 1-1:1.0: USB Mass Storage device detected=0A=
[  599.136326] scsi host0: usb-storage 1-1:1.0=0A=
[  600.230921] scsi 0:0:0:0: Direct-Access     Linux    File-Stor Gadget 06=
18 PQ: 0 ANSI: 2=0A=
[  600.243758] sd 0:0:0:0: Attached scsi generic sg0 type 0=0A=
[  600.263452] sd 0:0:0:0: Power-on or device reset occurred=0A=
[  600.289381] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0A=
[  600.297896] sd 0:0:0:0: [sda] Write Protect is off=0A=
[  600.306379] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0A=
[  600.424608]  sda:=0A=
[  600.425526] sd 0:0:0:0: [sda] Attached SCSI removable disk=0A=
=0A=
3. After: the gadget enumerates on the EHCI bus=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 1d6b:0104 ASPEED ASPEED USB Storage=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
4. Mount and verify data=0A=
root@ast2600-default:~# mount /dev/sda /mnt/=0A=
root@ast2600-default:~# sha256sum /mnt/testfile=0A=
3308890a1289f6a327c014537523e8ebd0833301af3d25a7c5893dc7050d2c70  /mnt/test=
file=0A=
root@ast2600-default:~# umount /mnt=0A=
=0A=
5. Stop the gadget -> clean disconnect=0A=
root@ast2600-default:~# ./usb-storage.sh stop=0A=
Stopping USB gadget...=0A=
[  669.866439] usb 1-1: USB disconnect, device number 2=0A=
Stopped.=0A=
root@ast2600-default:~# [  669.968156] sd 0:0:0:0: [sda] Synchronizing SCSI=
 cache=0A=
[  669.969307] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: host=
byte=3D0x01 driverbyte=3DDRIVER_OK=0A=
=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
=0A=
The contents of this scripts=0A=
---------------------------=0A=
root@ast2600-default:~# cat  usb-storage.sh=0A=
#!/bin/sh=0A=
set -e=0A=
=0A=
G=3D/sys/kernel/config/usb_gadget/g1=0A=
IMG=3D/home/root/jamin=0A=
SIZE_MB=3D64=0A=
=0A=
mount_configfs()=0A=
{=0A=
    mountpoint -q /sys/kernel/config || mount -t configfs none /sys/kernel/=
config=0A=
}=0A=
=0A=
get_udc()=0A=
{=0A=
    ls /sys/class/udc | head -n 1=0A=
}=0A=
=0A=
stop_gadget()=0A=
{=0A=
    if [ ! -d "$G" ]; then=0A=
        return=0A=
    fi=0A=
=0A=
    echo "Stopping USB gadget..."=0A=
=0A=
    # Unbind UDC first=0A=
    if [ -f "$G/UDC" ]; then=0A=
        echo "" > "$G/UDC" 2>/dev/null || true=0A=
    fi=0A=
=0A=
    # Clear backing file to release image=0A=
    if [ -f "$G/functions/mass_storage.0/lun.0/file" ]; then=0A=
        echo "" > "$G/functions/mass_storage.0/lun.0/file" 2>/dev/null || t=
rue=0A=
    fi=0A=
=0A=
    # Remove function link from config=0A=
    rm -f "$G/configs/c.1/mass_storage.0" 2>/dev/null || true=0A=
=0A=
    echo "Stopped."=0A=
}=0A=
=0A=
start_gadget()=0A=
{=0A=
    mount_configfs=0A=
=0A=
    UDC=3D"$(get_udc)"=0A=
    if [ -z "$UDC" ]; then=0A=
        echo "ERROR: No UDC found in /sys/class/udc"=0A=
        exit 1=0A=
    fi=0A=
=0A=
    stop_gadget=0A=
=0A=
    echo "Using UDC: $UDC"=0A=
=0A=
    modprobe libcomposite 2>/dev/null || true=0A=
=0A=
    mkdir -p "$G"=0A=
    cd "$G"=0A=
=0A=
    echo 0x1d6b > idVendor=0A=
    echo 0x0104 > idProduct=0A=
    echo 0x0200 > bcdUSB=0A=
    echo 0x0100 > bcdDevice=0A=
=0A=
    mkdir -p strings/0x409=0A=
    echo "1234567890" > strings/0x409/serialnumber=0A=
    echo "ASPEED" > strings/0x409/manufacturer=0A=
    echo "ASPEED USB Storage" > strings/0x409/product=0A=
=0A=
    mkdir -p configs/c.1/strings/0x409=0A=
    echo "Mass Storage" > configs/c.1/strings/0x409/configuration=0A=
    echo 120 > configs/c.1/MaxPower=0A=
=0A=
    if [ ! -f "$IMG" ]; then=0A=
        echo "Creating backing image: $IMG"=0A=
        dd if=3D/dev/zero of=3D"$IMG" bs=3D1M count=3D"$SIZE_MB"=0A=
        mkfs.vfat "$IMG"=0A=
    fi=0A=
=0A=
    mkdir -p functions/mass_storage.0=0A=
=0A=
    # Make sure old LUN is detached before changing attributes=0A=
    echo "" > functions/mass_storage.0/lun.0/file 2>/dev/null || true=0A=
=0A=
    echo 0 > functions/mass_storage.0/stall=0A=
    echo 0 > functions/mass_storage.0/lun.0/cdrom=0A=
    echo 0 > functions/mass_storage.0/lun.0/ro=0A=
    echo 1 > functions/mass_storage.0/lun.0/removable=0A=
    echo "$IMG" > functions/mass_storage.0/lun.0/file=0A=
=0A=
    ln -sf functions/mass_storage.0 configs/c.1/mass_storage.0=0A=
=0A=
    echo "$UDC" > UDC=0A=
=0A=
    echo "USB Mass Storage gadget is enabled."=0A=
    echo "Backing file: $IMG"=0A=
}=0A=
=0A=
case "$1" in=0A=
    start|"")=0A=
        start_gadget=0A=
        ;;=0A=
    stop)=0A=
        stop_gadget=0A=
        ;;=0A=
    restart)=0A=
        stop_gadget=0A=
        sleep 1=0A=
        start_gadget=0A=
        ;;=0A=
    *)=0A=
        echo "Usage: $0 {start|stop|restart}"=0A=
        exit 1=0A=
        ;;=0A=
esac=0A=
=0A=
=0A=
v1:=0A=
  1. Add ASPEED UDC device controller=0A=
  2. Add ASPEED UDC gadget USB device=0A=
=0A=
v2:=0A=
  1. Replace dynamic memory allocation with fixed-size arrays.=0A=
  2. Use an OR gate to route the interrupt signals from the UDC and EHCI2.=
=0A=
  3. Split the "Add ASPEED UDC gadget USB device" patch into two patches:=
=0A=
    a. Add ASPEED UDC gadget USB device=0A=
      Implement EP0 control transfers.=0A=
    b. Add programmable endpoint DMA transfers=0A=
      Implement DMA transfers for programmable endpoints.=0A=
  4. Remove unused macros.=0A=
=0A=
Jamin Lin (4):=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC device controller=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device=0A=
  hw/usb/aspeed-udc: Add programmable endpoint DMA transfers=0A=
  hw/arm/aspeed_ast2600: Wire up the UDC=0A=
=0A=
 include/hw/arm/aspeed_soc.h |    4 +=0A=
 include/hw/usb/aspeed-udc.h |   85 +++=0A=
 hw/arm/aspeed_ast2600.c     |   37 +-=0A=
 hw/usb/aspeed-udc.c         | 1040 +++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |    1 +=0A=
 hw/usb/Kconfig              |    4 +=0A=
 hw/usb/meson.build          |    1 +=0A=
 hw/usb/trace-events         |   16 +=0A=
 8 files changed, 1185 insertions(+), 3 deletions(-)=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
=0A=
-- =0A=
2.53.0=0A=

