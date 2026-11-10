Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F1606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PZ76ePee
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEa-0008VJ-Hr; Tue, 10 Nov 2026 03:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEV-0008Tq-TL; Tue, 10 Nov 2026 03:29:35 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhES-0002yp-QD; Tue, 10 Nov 2026 03:29:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab+h6tixHQAef0iDBsUCOztmYQSeiarnhKbL0PdAKwQhEjIlFxnoYfHZoi7d88B6Lj7jBOJZIGH4wnbd3MBSkzzyqLPkApXBB6h8pc82tXOtI2VB61Aqk+pIMwkS6UbuBVUazvZ5bnBF3c13Aer2bCiZC3+NOi4mu6gRN9AwqD7BiA+yJwuaZ0yqhmX71+xEuODiGXk3S/w+o0N+v/fbxIQIQ5giezh0ne0SV8CWBPQTa2saRRs35X71ufLfR3MncZTifbjB9HI5zNLa+LZCGsHjQACdJxSlQ2zlR1yYNbeHX9UQYIkOp2kc2KYRK/8k7b59bBOplHOfGtLjCeWCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89Z2gzHRD9RDeaBHcI6WlTVNc78WurFDpRUvVjAccTg=;
 b=y8D4Glas2fj8IzCyFnnLaO6yueyeg4BXWAN42433adxykVOENmCrJ3nUzUHsVbXvV0FrdV4zx3IIM2vWxky90DifQ+JRaO+v+0SZwBb6bKLz/qc9cuY9LfbUeeJR1glrC61nvANIFFH6rTf0czjOI98xhFoljU6zQ/vO8lnK/P5RytWgtp0rmgmGeWcrocSuCPdqb4r6yHqa7OWyfPAPYQ3GkUauxBlnhUaEZCGeHbjf4dOTsegDdrhP10jP1LMJz968oAUS16SkL9/IRq4gBDQbKDksG+w+fnKvsVu3S+PfpUGrIqwT9c9hnv//g/fB6yvcGdraqMiKlN291Oay7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89Z2gzHRD9RDeaBHcI6WlTVNc78WurFDpRUvVjAccTg=;
 b=PZ76ePeeLkNhtfasU3w89ONVbs1Abc30feIXDCKItBzEhrdzoa9PekXTI+5seik6sPSeIS4SoxT+jepx75jl9YZhpPVf4fzF5i5nFUTX7FoqEgpNIXVZpm0mZd+ZFmVQoIIAFgn41B+ij4edBLGiB4Nzy+HuH+IZODcSV2ZuzrC2vbd8Z0cpOx90R5+d0jTwuosLwfpOg2DYmhOmz790AafgNCiSl7+VeT4lwMSBBDrayjMry6F90SM+9K2zA+sICunaae5b5xCQWVQrkKR2RvuPImVXCECRQDc3b4cGGUeAsxFCcTXGKYFiGo5vBD6emGDezQudvh5jivjEZdgFzQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 08:29:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 01/12] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Topic: [PATCH v3 01/12] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Index: AQHdcO2Ulzo3bXLcEUKdznnHNY1cLw==
Date: Tue, 10 Nov 2026 08:29:19 +0000
Message-ID: <20261110082917.240329-2-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 64b6eb3d-0ad3-42af-fb1e-08df3f04b72e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|38070700021|261102123227099003|261028144727099003|56012099006|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003;
x-microsoft-antispam-message-info: 9s7nMkkyGpJvh8LD5th+DVuSiJacj4BGiWHGvr4qwqRJGUXy352QobtuZwFJAWUz7DEjsoSkBjwX/5MOcP53OIzlU3SZ6XDeUH6YpT3WgCFyChrvX4krNYygPn2CjO/L0RMStlbJ3CLXBEFV59omBwr77SYKoWzRQhiU/0OFY+dyRBHwWC+gWQLDPfXPapUB9Gctdo+/rOpMXIKKjJMOF03U49vIk2Dx8TY7JkYbMSX/So5oQJ+k9SF/5aVcwPtg0gDCmS8D3iB78/6IlqZXYe91I0nz8fR0ts8WuAJ/WmElRRPz1n+3D1U+1OmeCgO9EWA4Wr3ucl7SNlrfrtcTwLWY9I7CZW+qPFf/2El+89LsmKFeEm67gujYZoUElmNmRzBfIYyw6gZnxTeyn27athHLT7hlggGcAwOFUGjSwHHjPwvLCMW2weRVjYx/CyJH9QfPXQM3wVDWZYWgIvv3xq0NClrJ1jwm+hW4qALO9mn/wBskNsOmyWcnvkOcyoRIw6xZbOTso/TYjKtq6f4066roQ0AX7t2dALgYvprIE0QmWPQb58z2BnlPuHDCZjTqQF7K1/i/kV1jFNdfQ2/SYKBwPIWPCSdBPLyOeCIMzh4DhiTRXSOE7SA6tyrA8ZDZ88YgdKFGtHvoftBLEzOIE2O66q1QVEUG96ELeF2nmxCFiaNBz4IwPDVtuXzNCVKXUOx6FHSRr/c//fDVcd/NKBEYiwIH9yCSiIsch+mrlxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(261102123227099003)(261028144727099003)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h8gj1b0wHwPnKewf64canSFuswfnYJIet4eEPgM3Pxk8IhMz/bYCDkHe3o?=
 =?iso-8859-1?Q?Pj8OD7Q+cNidCTu4/9k4hcJ3pXUXthLp183HBewcQlk99WOIXKRNSgJe9+?=
 =?iso-8859-1?Q?8R0akSZyTxl8yl1pA/SRPvKC9994RxRQZ1fUuunyZeerVoyFw7L7e7MgHH?=
 =?iso-8859-1?Q?mQmT8fqMTluYvn1AoVeqRCcOj5PqDxOUUZ2Af5SIfp71Jem1mAQJ3NiE0/?=
 =?iso-8859-1?Q?I+pDYb0bNbv9+9KppfBOvfo34zPUMRx8eEb2zHOujGDT7AnoYoDLFZQ2z4?=
 =?iso-8859-1?Q?SUvGaKl86nRN2Q+GxJb/ly1I1zW8Ahs9vQ2BSGuRYTDcOpt0QH5dO+sf6K?=
 =?iso-8859-1?Q?f8pwzNJ8k0AwlWdniaFhgO0PO+DaSS05JEeekMlV3MDcQnll4HNZkXmIGA?=
 =?iso-8859-1?Q?xW+ulRYFGkHopKSzuSSL4UKMLtbo9jA7cCwIkgoYFJ8ZY27o9eWvbWgQ6X?=
 =?iso-8859-1?Q?VtIMsbQ61LvT2+Q8ZnGoEzu3zFWwLPfOfqn9e5oiq3YOSxAzf+YfUsf0aL?=
 =?iso-8859-1?Q?UgTnC/DYzI0AGKELFlnmT4/XG0NB2by3Qx7NtBIvxydCi7Q6I26OIGPWs/?=
 =?iso-8859-1?Q?k4rgtMxjD+KB8GmAw2QHBc7oYNl9G6KiORUeHuePXEkAWo/mVpPPcOZmM/?=
 =?iso-8859-1?Q?7yuVUsNt1FFUxLM2pdl1CftsZQBkpB8Yknv1PowtP5E7F/xoYOldU6M7Df?=
 =?iso-8859-1?Q?r/U0MyIAnZigr6emIx/iqAGDTuX9T+Sl39CTgI/WesbG6YqinA6MRokkhf?=
 =?iso-8859-1?Q?W/FyphcaYjLBkwyOoOofVMp9vbP27Aedouk75rdELVxAdik4eWYWSFzt91?=
 =?iso-8859-1?Q?rxrM0uHhvw5FkxOim7Pw/K1Jih6oVNhOyaB+AU1iyiigHyyJmp1LpMzlrS?=
 =?iso-8859-1?Q?KnpAoZr77jfQlNjz2dS+9fX8Ttm9F931SOPDU2JqLtAerNDvRRi5z5nDux?=
 =?iso-8859-1?Q?p3A7C2PN3fCM6hTlvb2xhUQcguKOEU9ufDkyy7BvpPw6C64iTDq9lzvikX?=
 =?iso-8859-1?Q?i2sqmmalhHVdIOihoDZUgO7zCL9PG2gLGeNKiXLUbD2ZsV7heaen5BoDpk?=
 =?iso-8859-1?Q?o3dgUYM2O3hsDV/KPl2liZ/fRXCnDD6t9vZoVAqgnqeIM6lmG14RQ5JtJr?=
 =?iso-8859-1?Q?xlE1w8fi1T4c2Q13TUqRGarVTQfyKexwtWTu+45TXSvLi6ITr/G3Mxdu6M?=
 =?iso-8859-1?Q?KwqWrC4a1UwOQlR97AconreVZ5feXyzTW1NDe6B/amG7fLMPlvt+6X+VG/?=
 =?iso-8859-1?Q?FqETdkhce3+Z9og5UtfqD9eMw2w+lK28beAv4yVQnnrpodISzfQsQhwpXQ?=
 =?iso-8859-1?Q?dD6MeocQVxNiO8BaGoT0oE9NI4JUmiw4s/Gv6wkJhUoYruESfi3jBDdu/a?=
 =?iso-8859-1?Q?etJh346SCkSka+xD0c4REe0/LpDq8jQfn8vwOS+FPy1/krmaUHDYOTb+bT?=
 =?iso-8859-1?Q?AhaI7ZtvjaTB8x+Yzk7mfeXiGIPmJHWXTcEt8IZxdyRG2UBfrfwTXRPFDq?=
 =?iso-8859-1?Q?BkXJ71UQvLEZmej7+h3rbIy0f/uLyvciJ8IsD8+0Euyotxr65D9VzSqVyP?=
 =?iso-8859-1?Q?d0QHBuZmEngi2p4DS/PrqC3fGzZSCQFQJaVmuA9vxt5DxP7hWGc/ScitkY?=
 =?iso-8859-1?Q?Xo46mSjq6z3jZDdRP1aCGrJDooDr/nI/blNn1JCQwf8jyd3yrCy2D8BMuD?=
 =?iso-8859-1?Q?KctRDDE3G+CLXl6ovq37BnL0zVJcrCgtPiwt77s1zvg/MeVpgv3Y+toUof?=
 =?iso-8859-1?Q?SkCthxxJDNZUjFmI9QI+rHZSXztnOvEdWVPSRqzkBGQFOfCQ4L4Qipihsd?=
 =?iso-8859-1?Q?mzc8vZV83g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b6eb3d-0ad3-42af-fb1e-08df3f04b72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:19.5506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2xYeuCRnL1NEnr8dFkblQnqA816RnyeAU24EK/M4Ewdd5M5vzeVs5skzMY+ir9LGxJLqG0kusuqiyZddqMnIiUkBvt6d0p2G28FPpTp2vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The controller registers need a 4 byte access, but the 8 bytes at 0x80=0A=
are not registers. They are a SRAM buffer holding the EP0 SETUP packet.=0A=
A read or a write that is not 4 bytes returned the wrong data, so the=0A=
driver saw a broken SETUP packet.=0A=
=0A=
Introduce a separate SETUP MMIO region that handles 1, 2 and 4 byte=0A=
reads and writes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h | 11 ++++++--=0A=
 hw/usb/aspeed-udc.c         | 56 +++++++++++++++++++++++++++++++++----=0A=
 hw/usb/trace-events         |  2 ++=0A=
 3 files changed, 61 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 7701c1aa34..42916c0bd6 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -24,11 +24,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=
=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)=0A=
 =0A=
 /*=0A=
- * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
- * per programmable endpoint from 0x200.=0A=
+ * Register map: root/global block at 0x000 - 0x07f, the SETUP buffer at=
=0A=
+ * 0x080 - 0x087, then one 0x10 byte bank per programmable endpoint from=
=0A=
+ * 0x200.=0A=
  */=0A=
 #define ASPEED_UDC_MEM_SIZE     0x300=0A=
-#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)=0A=
+#define ASPEED_UDC_ROOT_NR_REGS (0x80 >> 2)=0A=
+#define ASPEED_UDC_SETUP_BASE   0x80=0A=
+#define ASPEED_UDC_SETUP_SIZE   0x08=0A=
 #define ASPEED_UDC_EP_REG_BASE  0x200=0A=
 #define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)=0A=
 =0A=
@@ -62,9 +65,11 @@ struct AspeedUDCState {=0A=
 =0A=
     MemoryRegion udc_container;=0A=
     MemoryRegion root_mr;=0A=
+    MemoryRegion setup_mr;=0A=
     MemoryRegion *dram_mr;=0A=
     AddressSpace dram_as;=0A=
     uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
+    uint8_t setup_buf[ASPEED_UDC_SETUP_SIZE];=0A=
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
     qemu_irq irq;=0A=
 =0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4c90b4f4c2..355512822b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -58,9 +58,6 @@ REG32(UDC_EP0_CTRL, 0x30)=0A=
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
 REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
     FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)=0A=
-/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
-REG32(UDC_SETUP0, 0x80)=0A=
-REG32(UDC_SETUP1, 0x84)=0A=
 =0A=
 /* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
 REG32(EP_CONFIG, 0x00)=0A=
@@ -363,6 +360,45 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+static uint64_t aspeed_udc_setup_read(void *opaque, hwaddr offset,=0A=
+                                      unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint64_t value =3D 0;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        value |=3D (uint64_t)s->setup_buf[offset + i] << (8 * i);=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_setup_read(offset, size, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_setup_write(void *opaque, hwaddr offset,=0A=
+                                   uint64_t value, unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    int i;=0A=
+=0A=
+    trace_aspeed_udc_setup_write(offset, size, value);=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        s->setup_buf[offset + i] =3D value >> (8 * i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_setup_ops =3D {=0A=
+    .read =3D aspeed_udc_setup_read,=0A=
+    .write =3D aspeed_udc_setup_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
 /*=0A=
  * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
  * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
@@ -708,6 +744,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     int i;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
+    memset(s->setup_buf, 0, sizeof(s->setup_buf));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
@@ -754,6 +791,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
                           ASPEED_UDC_ROOT_NR_REGS << 2);=0A=
     memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);=0A=
 =0A=
+    memory_region_init_io(&s->setup_mr, OBJECT(s), &aspeed_udc_setup_ops,=
=0A=
+                          s, TYPE_ASPEED_UDC ".setup",=0A=
+                          ASPEED_UDC_SETUP_SIZE);=0A=
+    memory_region_add_subregion(&s->udc_container,=0A=
+                                ASPEED_UDC_SETUP_BASE, &s->setup_mr);=0A=
+=0A=
     /* Each programmable endpoint has its own register bank */=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
@@ -918,8 +961,11 @@ static void aspeed_udc_gadget_handle_control(USBDevice=
 *udev, USBPacket *p,=0A=
      * Reconstruct the 8-byte SETUP packet into the SETUP data buffer wher=
e=0A=
      * the guest gadget driver reads it from.=0A=
      */=0A=
-    s->regs[R_UDC_SETUP0] =3D type | (req << 8) | ((value & 0xffff) << 16)=
;=0A=
-    s->regs[R_UDC_SETUP1] =3D (index & 0xffff) | ((length & 0xffff) << 16)=
;=0A=
+    s->setup_buf[0] =3D type;=0A=
+    s->setup_buf[1] =3D req;=0A=
+    stw_le_p(&s->setup_buf[2], value);=0A=
+    stw_le_p(&s->setup_buf[4], index);=0A=
+    stw_le_p(&s->setup_buf[6], length);=0A=
 =0A=
     /* A new SETUP clears the EP0 STALL condition */=0A=
     s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_STALL_MASK;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 36a870689f..7a84786fd0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -381,6 +381,8 @@ canokey_unrealize(void)=0A=
 # aspeed-udc.c=0A=
 aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " val=
ue 0x%x"=0A=
 aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
+aspeed_udc_setup_read(uint64_t offset, unsigned size, uint64_t value) "off=
set 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
+aspeed_udc_setup_write(uint64_t offset, unsigned size, uint64_t value) "of=
fset 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
 aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_pullup(int on, int attached) "on %d, attached %d"=0A=
-- =0A=
2.43.0=0A=

