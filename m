Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05577606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=hi1Amg/R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY4-0004oW-0D; Tue, 27 Oct 2026 23:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY1-0004nh-8E; Tue, 27 Oct 2026 23:41:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuXy-0005ca-Fw; Tue, 27 Oct 2026 23:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSEWj45ZAh+KU95Zy/5Ep3zXXDTizGIUMWKCBmPXwAL1a1+PJhKqBUrS5XBSjbzgqqVe1nDUBcCS0aJawx5Ty3RTE6xeIbWkymGDTw7SdqilkN7yi7nATjtIlk+SSGuI92qWn6EV6dPsABG85G9Lo2GO5htrHy3hhKLBHKrnkWzlO54K4r1L+O4+NlmHwChR63jgCjtfoNi6G8s3mE5VYrasd2Xv3VJ2g+3kfDZMrS8kV+QAoIXj0ATb1VYT8FI4Xmae0znPnMsuLw2HZ64nL8FKfGT/P6pyl+z4koBxS+xUsTRsuo9afM96DdiPj1w5Iup4BFZMbS+o9NqPbNwQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFBOGxP+dCZVtQ4PkPaQcbNKDomk9xYcsLsK18o6t3A=;
 b=Uq3lIHAMhZCqFOaPYkaHDTomHxgQ62KzL1Bp6XXn0cX6WWCXeLlm4AkGlfjbBFqPrVeOFrn6AE8gIREkt9fCuLlOoDp1yV7PggQ5DHuj2Ng7bn6BaejITusEXVZaRs3wmXEqxbBlU7C/eYuGYPWRgaWHMmSzPLWGGGr5mvwlzci3b5k9sS4lOgmF2QkvVyejOPkjRNZw01JKEPOwxtd40lqoDKKKayf1/J+m2WdCrPlF+6Lip+awPzxjdgnxfd3myBQrLDZKO+YCWAwSogh3FDTm6uFeZ8V8u21sYiv91Q/uHGqwdHkIGqsSkwOGbJaF9hygzpCcefMyr5C443kn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFBOGxP+dCZVtQ4PkPaQcbNKDomk9xYcsLsK18o6t3A=;
 b=hi1Amg/RBZn4kmexVi6vyWLknmaAzQq4bQEvFGnhK6MB/+Cs95yk0Jf74hjWhXlfpNXB2tBwyqNDxwb0wwv9YqNGCmrYGpzMXWOtlYaOkKtvNFbCNDOsmDgbk4Wo4rof5g2q201uj6xY0w/svj8MHrmrHtnkOiIGGXsVBwqms0XOdVO7FLu5uQoJZn5e5ASMuLlBn0nDj7cnMcMMkaaOS81rflPaTplukb/VaD0iqqkHcFL1VPDUXPVrfFoyNif/wN9daR1wBFtwiDx3cu05eg/NZeGpeYj4XM0D2AhJOGmoKKNJGxZew+AyKQUlqcWAEPkKhDzTnZkdc4UtCtxOKg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SETPR06MB9120.apcprd06.prod.outlook.com (2603:1096:101:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Wed, 28 Oct
 2026 03:41:43 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 2/8] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v7 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdZo4/4siN0Gs6/0KEqy8swPs++A==
Date: Wed, 28 Oct 2026 03:41:43 +0000
Message-ID: <20261028034140.367393-3-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SETPR06MB9120:EE_
x-ms-office365-filtering-correlation-id: 0d2711a1-de96-44fb-6680-08df34a5624b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|38070700021|5023799004|260925021311599003|10067099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|56012099006|261022105027099003|260925022911599003|260925021911599003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 4Jiz8b8euB/rvZ7xomx1GCtwtFeV04I/d8vls5IyitJwnSRVPzngikATnJ7lxM+AKUckXH1QuMWwMZ2ORNSxz06GuJb8cGXmuzGCkQWogS4dldtRkemn6RqbHI/AoU0yeaMb1Z1Qa3vHTBKIQnQgwt/LG9tLgiI4aLdyoxvstDO5FdFqMNPcMeVzuwnaJoFwr1iQr9lUe8Y2di4c9vLgc4eUMSCMtp7/unsuJBq0xBcl8lh8zZruKAzYuh59jPwJnRlMeGePyUpbQLnGDg2B4EToXTuwLU4y2ozMm/i5rzMYD3kX0m1HX/BmwCmdw+8TrA0ldc65pdrhjZS+hOSqEOlLFG7ycBFu5Tmb4Bkh3SMsiTcNVAz+WEX4JrgcO42qiG5NtVnsuVKGZzz/99pM18wzAShktgEDRo4QIy0XKm4OKWc6fZmktNRaDHfwpJpbe29thr1LEA3WlSrqIr/qJsmCQvA4u/HLA5AungvafYU/N5A6/HuSrFA9Eh9Ilj73HK/Mre7mDDgoOyzZgUWitkJhWwrio2nIBTNGnMXdhMFu3+MllPLxXZBWi/m5q5p12ByR5KgVyDO/NTR7wqGcKSkABDkMvtpNdsTcsF0MSBuIGWZUQMa+Q0fE59WjMWd4JvrAgq8MRIXTJUlaJ6rq53GaweyPqfCcMfILRTul0kuADHB5D9okx+ERzIFuYnXARg3tuF5Uyi8SuytS7OB0VdOawv+gs/SGJxyTUEMCBSE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(38070700021)(5023799004)(260925021311599003)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(261022105027099003)(260925022911599003)(260925021911599003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YmQURuHa0rwmY2ytUJPfXjuSpIuGhv7JbxB/X0dSp4OWSrAffKsi34XEFb?=
 =?iso-8859-1?Q?ODofT9i2L73g0duTHcW7l/skSpeH8Nni1CSgh8m9eEhx+2yTD1PJkAA+CG?=
 =?iso-8859-1?Q?wer0KwYCdsyG4vK1muJRnKlaZ6HNo+paYE5TQ0woy9G9eWdw2XuY6lLz26?=
 =?iso-8859-1?Q?uxk0AcvlIExr/1yS1LmTTvnmDOUZh0bwCJXONYEmtPns+DjEEnlYw0bZ+o?=
 =?iso-8859-1?Q?2ob3LL1+vq/dAPte9m8rmW04Gu+Mwd5WBIMVTsv52fzKpCh0enRLZocHZX?=
 =?iso-8859-1?Q?F7baVlKduCcE8CJGzvcXR7pnZMtIVNPTwbX9FO58MUglWIqiAAkbxBbhvo?=
 =?iso-8859-1?Q?FGp3O8uHrfZBjD8XvsLaFlzJxUK2sO8JmbYRsHag1nwmKM32dREYfYy54M?=
 =?iso-8859-1?Q?KlOF8pAsq8nv5kqALap8QeGYpfV7Bn3WVLRZcwJJegRuiNBVf/BFilDzAf?=
 =?iso-8859-1?Q?XLjwe2yo/6rv3bVjcdsE4IjiVVk1y8B+4+9NBvag/QLb0j8XFzTlP/ubDS?=
 =?iso-8859-1?Q?7zP/igakUW9qYA6y4fJMPEyj+jand0ckIG61phPuP4+dxfx92fWdcijzDG?=
 =?iso-8859-1?Q?/+BzeJSjftbwvM4EzH8bGDYdzCf6lj3ifnmgNirKnIsSyCZWzmGvY9T/p3?=
 =?iso-8859-1?Q?A5Ufxncx2BD5vnN8wthV7A1oM3J645knNXZQTHOZd39hsDrcBJ3A3oBQ/K?=
 =?iso-8859-1?Q?0LCfWVvMSSeX+KsdLESUr3OXkBhuPR/pCV+/HUJeunUoOjUoI6U0ezYldd?=
 =?iso-8859-1?Q?UHzIPWdngxXerpNslFgGkvofk0fzYVN7njB7M2gvpphyeUfqWS0oBCiLZg?=
 =?iso-8859-1?Q?CabkfgMOWBU4aDLcbHZQE6ufttN3IFtlBFjrMo0Lk6jcxuy6KYcw1mdPhs?=
 =?iso-8859-1?Q?QvA6icdyzM6fDnwTyBKufrteAm2d0475aos34AzMiIPKPd3xaJ6IoGcjsC?=
 =?iso-8859-1?Q?uBWG4QfGTpqp9JPpmAHNMlQa+FeBLbY5nOesN4IiEBSx0g969i9DyUo9TZ?=
 =?iso-8859-1?Q?6NCLOxwunUkTHsH1PVaBwu2zrLmQlOAOuBUnwRvmRXICleUKM3ADN2hsAr?=
 =?iso-8859-1?Q?ls4WiBLvTQfm63FTuYvWzTOWwfxVdcaMdKewmVJI6wfZxG33c6bpw0yKMr?=
 =?iso-8859-1?Q?Qi20WKetVk06NB5BiUifyivdSdLgkXrJ4sSH2FmRUAIZbbSZ2TOide10nS?=
 =?iso-8859-1?Q?DtKY3W2xNfgQ+Wff2Qi1LEyd0PDqyGIRyLV7P6/kMn1b05npOcIHj5Ctee?=
 =?iso-8859-1?Q?cDcC1Vd63LyCjOT+gbY+zpOrIdkIx0k34jaV2UL8Sbu64ok41D5ChEXCNU?=
 =?iso-8859-1?Q?HZxgJYpPb7vKdc4242nmuBri5uyJzabs3XgQTRU0XRAbqQDauxWE/akiza?=
 =?iso-8859-1?Q?sU9VqFR51uwhKdlouMB/9d2LDxGCoqJPxGJhzzE1p/H3JrYHlEBbTaemff?=
 =?iso-8859-1?Q?3R74wJXAVuiiFwceR54XRfo8kmpo0UtbPwGdmOGgPYCJpFhZ+s81A6y0V0?=
 =?iso-8859-1?Q?ezZZoahoJhAZtCuuBOdFdfYXstxf/DdaJZBHoc2BFUUKL08vvrru3Lo1Wb?=
 =?iso-8859-1?Q?GSXgiQJI0iko7amRgEtTm24fg0MoqNoK2voAvUaPeCnChedDnUFqjxpVlm?=
 =?iso-8859-1?Q?NuOasgZOKM1NRTZkzMEe2UcE4ZuuEk78bEVboLPWqxbzHsUKL4nu5MwuPT?=
 =?iso-8859-1?Q?8RnD0wJTGitKGrrMmKE6W+WjIz3liNW41HH7cQIcDJ68+2KrTxpUAUR0/r?=
 =?iso-8859-1?Q?/E65PwObPi6ErtUU4cUUwpmHJV7nDTmPpEzQfewUcSGLHExOXZjhNJZHXv?=
 =?iso-8859-1?Q?ZQ03g9s58w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2711a1-de96-44fb-6680-08df34a5624b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:43.2749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ7O8/BucRV4Z/P+Uw0igWfmIluhV3H16bB+2bDRtpnIEe/3b1QFNLu8+BEVvab7mXQiBadSKJBBFEd/6lC7uLvWxDAcfzu+aJbzul+Nll4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9120
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add "x-usb-redir-server". It exports a USB device from this QEMU to a=0A=
USB host in another QEMU, using the usbredir protocol. The other side is=0A=
the existing "usb-redir" device.=0A=
=0A=
The name has an "x-" prefix because the device is experimental. It has=0A=
to sit on the sysbus so that qdev can find the USB bus it provides, and=0A=
that may change later, so the name is not fixed yet.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 142 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |   3 +-=0A=
 2 files changed, 144 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..8399bc2349=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,142 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     x-usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one x-usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 429dcd6a24..0061b935e6 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -78,7 +78,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.53.0=0A=

