Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06168C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yD1-0001QB-GO; Mon, 31 Aug 2026 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yCy-0001O4-Pu; Mon, 31 Aug 2026 05:21:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0yCw-0004pf-L4; Mon, 31 Aug 2026 05:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpj86kminMMaSqYg6E/USR0qFAFpvR3ifsvxP0NDOuJeHiUJAIkDfvyl5w2FZT8YnroO5mKLDZAmrrkXR8SSPI/g18QyoLHITo39u8GKG5B1mVhwJ64PLKczRsV3n5WmOfQfhVeqTsLyBQDRkj8Aca0hT7v0auYINPzu1UNfMeV7SZSdtCY1p9VgmS3DHt6umRZeS4y14QeE9pDyBMYRdeTBTNGIEStBO9HqygWwzbwnw4C4Px34TeV5bnOEfp4a1Ms4QD8sfgFOGzUKo4DduI7oGcmvlDLSr6RP6GWc1hge8dSRlJesOVnMULimPu0cZ3CUtbT9VqJZUjRhmJjejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x+utEdhk/JzXJRmUiv6DaKV7CnlRsfIWgLDZkvMRBs=;
 b=QeMLNO0hqFQh6/ie9AgTKN1snc/ZHa41BFsFT7xfXTkGfokHEiV6oOCovHqADrSpeoNkt/jUcBZGS/jqMR4xhPkEObvy9vJBzbilqAmfXS68LVBYeVhz1+WkXZGlT2v17xOT0qBt5vn7bzUIWl14/mUHHw5wC1n30Kgqvvd42z0taKmGpyP12KBj7ktJrNljW7h78R+5A17CHw/xIIQhkEFFh+CXQ5iwezHnyqsgGFpi6+OqnR7sPZK7gMAKedAwZBfnHY/vUKSO/DiM3ayjuSx0tTHK5g1YF/U5+xNBU/dMdKDyGMWaY2n3upc0IjAXQcx3ot/bLdKgsYdAT/fSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x+utEdhk/JzXJRmUiv6DaKV7CnlRsfIWgLDZkvMRBs=;
 b=G5KUP6cz5JUKvmacZ1nN8/Nh8NyGBr5Usx1QSUcB2TAokkvdc4KwMqn3k1rKEiblr0zQ5cxPX2+V1zwLbLZXLlR1B8Qqf2l7O1cM02kx32Mp2pY+IxgMNO6sUJJDn/f8LGmGN22NuXVh3wkIoOIAxmhCZb+WhAaYDFnlnPVCK8Ro+R4xOBXsDe5DssUNEy61wN54ru4nC9pF+otSw4lq31C1D594kOZ6dJOXGarHtUWJ5N1uuK8WE7/NTI6iXMRfrXw3Yh5eKsborVAWtpycrlm3RDY9Z+63TsIwg7UBlPBHkRhe8dAUzq13pT68qkKK3queXh/2cYSQPZJMy4WISw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5933.apcprd06.prod.outlook.com (2603:1096:301:11a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:21:26 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:21:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Topic: [PATCH v3 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Index: AQHdOSoYnqb6ZlquekezQlRBBqE7Ug==
Date: Mon, 31 Aug 2026 09:21:26 +0000
Message-ID: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5933:EE_
x-ms-office365-filtering-correlation-id: 8f760efe-789e-4679-6d2d-08df07413b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|56012099006|3023799007|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: UI+jin8XZ0A6gGvjT1xrQVJdxhma++upumsoepzbGwT2e5S1I+ElMsKIgWITqeS0TSiRpj4SBaR8e/nCdZeFxcUPShA4fkN8cOl/RtMorR5mSNB4q2aZzsy7VA1Cfpd8NH9pmqBR8ctgOnnIWdXBpEVXcFYr5C/4BmVSLPgVNT/NdtQcqxQdh7Xx39TlYuWV4hQ9Jr/qvETkhRes5SKejwWpzVudgF6eCYJYZBCIYA+g9g+Req0/sMMyctwNqyvp38P08yH1TW3VyW6din0dzIVKYpFn8yxt4ksUj3KnIjApHJSFg8FZIqv4SGUdeq+b0SlKUqc62JHxCtsSRsc7UDCcKb++gj4IDTEMmRX7r/HBHv/SfUr/2fDeLmOHZ+57Jed0SLjEsQV0vIuPexZ6t0xBtx3OmB9wnF303e+1fMw51hMdl0tImefaUONq5uCVGPhmL6DCWT32KG6BjUIorjQK+sD5k9fAQPyZyWqXJPLEa7MRbS9iuW9PNsVWWFR/qpZD1bBXyfH+ukhJXWkSty6MhY/2haQH6dPUz2idUqFk6wM1oQEYGT4gkUleWIwH18MWSaShOiQMrYcGrEaOLs2tHGlRxZRrfNW3ugEt0vuelzt9tOrnjdoCmydSqmNB5Lye3Uy19xE2obc73mEKhFUE54W2Sid8tW9AdvoAhcqQBknYR9gGYs7j2/B4KJFab+qrh+7EKq8uMofOLsEp2e0hSLKOMGHLXs85CV8rfRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gWW0T3nxEV22jvtcURJmuJC4WRjkukWwVTswvuMKAwMrQOEhN6oVZgBcFD?=
 =?iso-8859-1?Q?RvbTYxKvxdpAStbzjISnIK3KVP2IUhIIQR1QrD0k5APyY0aSrC9lxB/LR2?=
 =?iso-8859-1?Q?CJHN/Sos1ogKuVy+mxAi7PF5+CNWN9Arwt5Iv9A2nKma1sMSKCWoL+pmdl?=
 =?iso-8859-1?Q?+mgdkI2quw+qdcqoRRVrnex/NV+3QR7kPSN7411cJtwActINoInEn11Se9?=
 =?iso-8859-1?Q?f8FwGVdAz54zIh2QcK7AoOgEQZPsk9LOmVRI9slG1GAZflosz9fj7R4nzZ?=
 =?iso-8859-1?Q?ZyoacJyyN0zZQEm038qTgkLWrL0leP8wW5Yd+6ihHUjaMex3Mx6fiqjMJN?=
 =?iso-8859-1?Q?o4eBlIsF7MTdxPaIuqp23pfyMaJJsDOzxK60QlHe/z8odCkazkC3ZItgP+?=
 =?iso-8859-1?Q?ka8JAg03F1AbRdCSXmOaWKIioxHfSK2kbhEMoRZSWPr7dtiQTXLQzdLYSk?=
 =?iso-8859-1?Q?nxfLMxG6Snu0OcaeG8C3ZSOZc7QoqSyhMgQIuSGzPW1MNVqvS1GscSgVht?=
 =?iso-8859-1?Q?RmDZMvL+wIVshiBJLi2QHZdO+kBkByGK1i4zioJ2sfKIchgVW3PdczUCYW?=
 =?iso-8859-1?Q?YhBnq46BGkJ82zE0riiv7hBnBPBegRqeC51sDQS42EOmp9kk0c7q0fLSr3?=
 =?iso-8859-1?Q?w/HoQ0Ms+Ip7EznEBLla7JT8wZBD3He4GxjdIsPvrh5ZYIVLHH339wMcgn?=
 =?iso-8859-1?Q?4HW931KU7hn6XcLx0oGOnMc4VPC4E1YJfoIzfMipAw0WCXYDrREM5PP3Cv?=
 =?iso-8859-1?Q?yg4DEqF21tb6/oRxlTRTA0VswMTuiU+Y1uogW8Fv34LfMXpSZYAd72psQG?=
 =?iso-8859-1?Q?nOfG+KOe+iT5juEZpZkBPp9Vqtc7bfFqTpMObtFVgS4Xv7fV6en2qcIswp?=
 =?iso-8859-1?Q?HZdHD3LprljAErjTOy13eYQHSxXQ/k9b3F4Lko1GIyJfBsSkAWJenXoVJy?=
 =?iso-8859-1?Q?wsAt2OsP1r6dEVHq2FcEhVn1uPBR76ld8ZPG0bCoKdI5L96q4R+P5w3l6m?=
 =?iso-8859-1?Q?dN/sn/7ki3HN8MQ6TYPPlrRk6WJMBH7x60r5aNzxhWCOoRuhfWCEn1imdd?=
 =?iso-8859-1?Q?ztPtacpgTwafCPae+KoMWFUjo896eQYkPOvWoT3d/Ldpk08+ViAKukRxaI?=
 =?iso-8859-1?Q?jXKDlHfPVpGC3sz33vh4g9/v4JS6iaXwSdFfWC/Nq+tmdeu57Ods9cYNci?=
 =?iso-8859-1?Q?QGiiAOMrhTnQ+1AJxBK3j12StixZ3zEq8XnC8XJnlAXqIeOEZq/+RA5zqM?=
 =?iso-8859-1?Q?dNisUuLaEVhqkN6dE8X7qScxGX/rdaZOmailk+QTLyMRO8DlmrWLXNrPTP?=
 =?iso-8859-1?Q?6LXuEVi59ZsYb7f51Ezn7jYa+H/IRKDRYftAf5D5J+fJSRm1L3+CDg0kJ3?=
 =?iso-8859-1?Q?0u19/triocUO8meTpVZD83GqBnZQR6wCjtatYb4DhAjtkUgBb8KhozP2Rg?=
 =?iso-8859-1?Q?25JZWLBSR++ObGvWXkqqXCG57+94jVRF/7wRcJIoDs3eZC4hMMw2far2NV?=
 =?iso-8859-1?Q?mgZ4zRZEsMSM0VB6asG1589RAm6cR6XiugOePN57ALnR/zgem7pOQWvT88?=
 =?iso-8859-1?Q?6LdPIHGvY1t3PknRA8+z1fji7bi6ANO7XYkm9H2Dn7oIjMNBoU/U8BEqXR?=
 =?iso-8859-1?Q?i7IDi7qX6y7qDezWF22AC676k4Uxd44NxNKfB2PTpVjmUj1ykPvLTX4Uvt?=
 =?iso-8859-1?Q?3BCiLbvKxMjyb6D8XXhlqP6YOmbywb6PRjJRE0neSgyPow/1Blk9U+wkiS?=
 =?iso-8859-1?Q?fY2O/Fi7pXTVTgsBvaHNj8Y0e7x3suGHinh9N39hlK8/tC4KD3suNVJflF?=
 =?iso-8859-1?Q?1ODtfVNjiA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BXeR1nHo+szNSAHLMom3DFx5P+7kKfVxqdA29nourwxyZ+J/7j3qBFPejekgcLH9B/FGiLDyBqpC+Jc5VuqokZ30UU88Lo0XIdRoYPP7fyVI3Lt/bzb8Etz+EM4xRNMLS+SKDMlOJXR1wPqysU6lM4It8kT4mIxk8SWIeh7McaiJeF1W9Dtp2XixWIOss0QJVSP/KiSSZhFCblRG+e4dOJFURgdSPPzQfn43Jf4xO6KnhgffaeKuRnn5Ow4ftGMqA3m7Y6kb+7TTIvSLpEAff00TPBUDwthrycU2CtIrk2UdL+fHZJK40yS3aOonZNpO7Rh4kwrRrLAAtpZSyaStAw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f760efe-789e-4679-6d2d-08df07413b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:21:26.1580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/cAsDdb3GeIQMB9m3OiG2S5adWQ82aUKctEFiHAxWfHTBfasK3wJtRDEi5wDHzQ8buLQUIubwRy+AB9a6IoSg2VTMm1A+y782sddp5rw9g=
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
v3:=0A=
  1. Remove unused macros.=0A=
  2. Bind the gadget to the controller via a QOM link property=0A=
   ("usbgadget", weak) instead of writing the back-pointer directly=0A=
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
 hw/usb/aspeed-udc.c         | 1059 +++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |    1 +=0A=
 hw/usb/Kconfig              |    4 +=0A=
 hw/usb/meson.build          |    1 +=0A=
 hw/usb/trace-events         |   16 +=0A=
 8 files changed, 1204 insertions(+), 3 deletions(-)=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
=0A=
-- =0A=
2.53.0=0A=

