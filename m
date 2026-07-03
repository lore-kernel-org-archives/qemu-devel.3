Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D6FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYYv-0008Pi-8d; Fri, 03 Jul 2026 03:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYYs-0008P5-GE; Fri, 03 Jul 2026 03:43:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfYYp-0004IZ-T9; Fri, 03 Jul 2026 03:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+8hz00UJqw95byPRF7WTinWvxBk8BJ1OAT8hAYDZX6bvlZ/KXknM529eH97kG4hJDEiaedpxqFKX9zeKhi6T8pxyrOp5f4/7xtam7EQ+aIJsdjBRuMw5ZV1yuyrawrNSGZfwI3CPVxtKs2yG1G6U+nFfPVuv550onkephZk8DDvzbGkgdI1n9aVKtDxaxKo4iJXlgZwjK2UIrOox1rFr2llacsvZUqh5CZDphEWJpk+6rRCiWY95XnSFaw8MdYS9zGxxNk7zwED+i9UxenAD1j/ySqQZKjJ2y7hxgxEQsG9LVv40y9cvRQARFTOq2jXAmjnKsTmhUqMahgVxna0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACQomwcUMaoq6v3qUveMqIjAUks77wlVHs+ESOLSz+s=;
 b=jmnbV9fzNExupuo7g0Sdb9P9M+PXq1gyg3jjb1jLHr7XZO9slmmuGj3cI5KgalzW6420mRzsWMmPyHCR69SpoJks8f/ARKcOhnhVUQ8fMKIr8mNfdkpKYoiAgHLDGVNqwuTsr+eC0rvq/ZoULcRnKrXl2+gLg7bPEtfo6ZzGweb13tdNAUP0frx337JXENdlrsJLN4++1Tg9yIQU3fqkGzOUfoVYjB4v7JjJ3++qV9e9vV56CX/bVKw/h82wQstVtamh78BnQJAdAi8AAZZR3Pxo7fTfOwRPSA8QM0AtsGPfc/aSJbzGrUyy+dA9ldIxF96BzeVST1mfFagN9ThCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACQomwcUMaoq6v3qUveMqIjAUks77wlVHs+ESOLSz+s=;
 b=OcrcWpfNRX74M4rkWFP+fLOVG0nxf6yV0OsNRK5RQ0aFos5UqREPdhkqzDx7sxL2cQqSgEgtj+p1zQvWXvQMOz2Emvoqlk0eUmcwVmB4tED78UnjFxJQ3uQ4T6c908uk/1TvgOvNRlFo7jlLX8PaxF5FjYzdELTejwwNyMmzgKuF/VAsfOL6tz/Lfa964lOybGBafm7WuYBPstf4rkjCKFkdKrLzkJ/ggDSCVMyZzxZN19prfYirfAaB/Hl+BI2iUVGzIfWBJ1eKwtKSLI3nkkjNQD9FKOPJ2fO+hHq50zo7TzlTlBR0SnST+vBaG0zRuVgYjiAiSkTAZAxD2Zw/IQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:43:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 07:43:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/3] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Topic: [PATCH v1 0/3] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Index: AQHdCr+mvboIi9lrIUWzCkH9wS5uUQ==
Date: Fri, 3 Jul 2026 07:43:33 +0000
Message-ID: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5040:EE_
x-ms-office365-filtering-correlation-id: b20412fd-7368-4946-603d-08ded8d6c8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|38070700021|18002099003|3023799007|56012099006|6133799003;
x-microsoft-antispam-message-info: Wo0NnKtcqbMhWO4HEfmK3ORgjiLmgEMqPYblBl/SrDfxB1ROL6RLi7DWMD1/HEZIR+kzqnXFjZbmfKljcsxmuuJGtgAcYr/3TBjUHqgf93rxj+zFfDqunM7gBVYkWvCVO/+b0H1l5JunJlC5q04Yj6sVEo2GjsGfFdAjwqHcamDzfxj9ZHxH2Gejf6yNXmJzdMz4O+NnUvWO7QwJVcArSK3Svugjvn70D4q7n0YKwJmvOccNkN4M5uyb3eaOPDmpHUqAD3127hCf4s0f6FY30h1pvZ8UvOIIgUQj4ggXDaOWC06xJeTqUa36QBE6Qlk3j8Hq3X3qKBkS7JLADwUdFn3/JKuxsYnluK6nzTFgBv2DcD0ICyDvJXjs4AQQKa+nSfAugjx2/2ncIVqii6cu/VmRKmSs0UWPN+km7J3paPn1JnZmhdL+NYpe+QThotFCcOmrChRzieVVUyr5oLnzvBwHuUlWob9VadPlu5Xks3R6Z40ZTPPzSqWukXxVRHivmgT9BKLOb9bgco7HrJDHobAdNusGmMRwqT1toXdihoG2fVHuCd3URB9qY1lsYRVX8L88O3nE+AY+KdmXmqO+HrVY70E1d2PR8am9DfSk5tFJiNdMIo9t+glwwEcgdWC/j7rMOa834ZlASmgQPoYeyLnSuRevdlRamxBsvG0RK3rVSivUk0FG2/eKe3te3io9zXottOB+JXVyS+YNtdiq/ah3kmieyQG8mZeWkh4o7Ag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(38070700021)(18002099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?184TvHJRmK5b8Jx3D4nLWv2F2SBPSr2toIouv1VIbCattEUDJ1lxVAiJBt?=
 =?iso-8859-1?Q?/VtoG0z9wEKXMcH1oNzFBNVHXbn9uALJeCQc7yHKYNwHCuGAnrIgJPqCh7?=
 =?iso-8859-1?Q?bnODuMi57TQpl7t1XF+3IYJq7GJSo/ZsL1Hocd/uw1zuuj/pU4D8UypwZv?=
 =?iso-8859-1?Q?RSOyLCTwuKDOXdRxlOHy6RQt+Nxc3dBosPGVSERw3d/GaI+jZCjY37CRsb?=
 =?iso-8859-1?Q?46j3E9LgP9PFO9HUFmz6ZS10bTwQREuxn0hRAyKEQLJFciR8dXvKPtqOIL?=
 =?iso-8859-1?Q?0dFdZbpKYHSa+T9Gx8GkIGlbNgp+zSydN0M/W1q/YiZkw/WQ6KfyzzKOXg?=
 =?iso-8859-1?Q?b8WjgFsh1BKVZjYNuIbfF8DA137f6oGhVwVCi8i4DioxcDhuo3rRoOOlvK?=
 =?iso-8859-1?Q?qgxD4mmUIoqC8s7jLtwQoSy/SBHUjvfmz0ZhNJBuid0nl3EQOcJhkqF+A1?=
 =?iso-8859-1?Q?5k5szIBsygmWx+1OIZev+tIzFGFUZA38lxuAFJOdGohQt0gFys3yAwt/fh?=
 =?iso-8859-1?Q?y2tWwxP7gW6m9b692hknbKTOJ2BfqUKgxSOD1DL0GAoemEMG+UudpvvEgK?=
 =?iso-8859-1?Q?h4tOMWepZWprWPU8Wj+hsQhGxVPUggtIBcFNXbMtZDToqhxS0jabTw+An+?=
 =?iso-8859-1?Q?K7tUhPolL9+tSqehJHB7yh4SvUBZO/lTjtlpAUG8uL2Z5REbJzdcDiu6er?=
 =?iso-8859-1?Q?kT/j2Pas/4hNL9+J3JEBndtKBal5+HF/kntTwj3SxShpSUXU2gOT2Ek+PU?=
 =?iso-8859-1?Q?oEIQyx0oZliF6cdewrMlebSUgpVT9UbNgXikFMqjn8dye+BUIG4lQLK+kf?=
 =?iso-8859-1?Q?HEJG9jY3o4REFP5/jZUtKrhfED5aHJNGwU4FqDC/Rqq5tpcTo7xgAfVlZP?=
 =?iso-8859-1?Q?pXp8EIHFhdsP2XuA/0CSXH4K/H8FC4Mix2YEmgnCHrONwIMsD9Isuts7Fl?=
 =?iso-8859-1?Q?PxhFLFQCdxDWuO5UMbfqmlCxUUwkra9njBQakTOHqcoaeLPFnN9zRY1xfu?=
 =?iso-8859-1?Q?fdqIOvtoMQSBxOlHCqzz5GIzTVGC1sN6AibXK2TFohD0goASTteq2GHhNZ?=
 =?iso-8859-1?Q?f/FBnViSJ4C9EWVHZPvNXGodU+hEM1DOmDVnMlRFJm1UPRjVB246mcdCKd?=
 =?iso-8859-1?Q?x2NvJetSZjRZ1uNJ8JgJLHf6IEeM6t1lCL/l16sGxyvFKZ6z9O/JBSvggH?=
 =?iso-8859-1?Q?rOb0EuQ4J7VPR6zUTa7ZEYFsOcN/Mm5LJtdxabl32UI97cJRHVp8wHyDN2?=
 =?iso-8859-1?Q?iZhzdhx1RUy8zmKnsPNCcoh9FEYCpmsoDm6ujjxY3NDwi3Y9BTqJWQt+e7?=
 =?iso-8859-1?Q?/9oCIq20xHB7xj626tzRJe2qLp7iw8WNnl1+B3y4tuHQwMCte5jssW6U7J?=
 =?iso-8859-1?Q?JRIPj+FdCpf13Cg+uFiqPpJGhSoOqZ/i6QQPzvso2VssYASyam1FYvvlLi?=
 =?iso-8859-1?Q?qtMduIUrnewDMC5tfo8yv/TiHcPghBQhUwJ461uWgcuH9D4603m9I4PQdC?=
 =?iso-8859-1?Q?0N3DywPeFCPsJ6zHbLzsqFYZCgiLPvFX6gShBGiFHY2P8i62UMZsfN87oV?=
 =?iso-8859-1?Q?LTCMJb7FXS0dgX1Y7WW7FhzB5ouKvwWA9FzI0eTqgB21OFIydfG06fVPmd?=
 =?iso-8859-1?Q?AmICFyEy/M5tMCh3LnMubaA9AuCdUXJAlDYQMfjVjHt0QJYx1XNGyPVraW?=
 =?iso-8859-1?Q?tRHGsjg2yBnXA/bLKi5uPLd8fKQ/7yaEl135WpWT8pxDK8/0zWRQb55VH7?=
 =?iso-8859-1?Q?HWJYMy5PWTGF/0kKxyVsH3ThnhHTWcQA6WLix9kDjcL1LQbk9IR1jOJa++?=
 =?iso-8859-1?Q?ZDudoUxBvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a6Csyc0PT/NpUSSF5Bu6czaWum5C5MvfaQY/w+Ugq4byuYrRrA8OWMqa2+XY4hwC0P+I+BhS78hpX0zpWEQunAR8uB6NIFGvISwJMwmWWnDHwCWCZFkh2/rsN9SaGVSTqn+cM0eY1m3s01QRZY3w5UuVDy1HbVI8g7/4kIEtEbfTloAhN2eWLr5GZ1npvK8F/eB5NlzApONZmLOWxUL3svW9EUjKC4cVvzITIXYm5T2vRNlE/yA3d9X6mNzqoJLHrtgyGr6V/wp1aHBvvhMbxtYGspSwgo8KGnD6DA3lQQFTpkKMLrfKvmHvsLQoetWoxDAkpgp8iECJ39SBtceMKw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20412fd-7368-4946-603d-08ded8d6c8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 07:43:33.3764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAsJlsPE0j7tsGuOoR9NwuHdU8nlBcX/uJAuUHhU+O4EryO8ntGl9/tN+WqsTCAo7R4xjdfH5gnYcF/fmXIPssDb1J05WzcKvwvOqejUxWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040
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
Jamin Lin (3):=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC device controller=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device=0A=
  hw/arm/aspeed_ast2600: Wire up the UDC=0A=
=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/arm/aspeed_ast2600.c     |  13 +=0A=
 hw/usb/Kconfig              |   4 +=0A=
 hw/usb/aspeed-udc.c         | 930 ++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build          |   1 +=0A=
 hw/usb/trace-events         |  16 +=0A=
 include/hw/arm/aspeed_soc.h |   2 +=0A=
 include/hw/usb/aspeed-udc.h |  84 ++++=0A=
 8 files changed, 1051 insertions(+)=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
=0A=
-- =0A=
2.53.0=0A=

