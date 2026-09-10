Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA35C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqg-0005Qh-9m; Wed, 09 Sep 2026 21:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqb-0005K7-BI; Wed, 09 Sep 2026 21:45:05 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqX-0004BB-3V; Wed, 09 Sep 2026 21:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1JrpIeKbIZZJP8N46MXPpDOKNq9o4J43V5ubPdo9epyLA7UE80ZCsmTDBkr3lM+EHnX4xlC0DVmCWTjrJbaYKPLP3665kMAf5CRa3LLnROy1HAdrpXhOFJlwLl4Dcbk4S9DKvSU6gQroBMIsG2T1DGIK6N77JFLq3iGjOwKlyZ54cBG9lwwOgVxjmHysgc5bDy8tTasFRKim99L9JLr7jfEl+z+vuOK0l12HJuxfaVLH6GXFNoKnQu8e/Aivnob/H8qghGyDRKqkZ3oHB/B9uFlX9XbmBcbAs4WLwx7NyLTDKxJm7DvwB83TgSH8QHyjtHLWBF7hF/uX9jxToetWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8nEhIKqmwij8yKctNZvWQNWjYDIQtpoqt9CpQhX6Rw=;
 b=PgQ5j+M8Sd+1x5enVrdWXCGHSgpwwisYEq4kFy/iuS1S0j6R6etYqtabD5AQJuOwILoFM9v01x14ND5ZrC8/jAkF1SQYN/nJScG0uWrI3n0eaNHYkUq1mSkwDR4jSSVcYD7B8jQyJ7YN1gIW7GRjsnWNr8HCxNwjzghcfCZDKt567pLuROMm7KWEJrAdVYrzwENpnhu5+7NeJNohqLMmPMsntptMLsl4pGUbo1osLF6ah/8/c5tDqj1LGi8529zsxH6ImRzORfNlJURT40bKd1xXAgllUZ/sUBJ9jrEIN9EzBbnis9sFiMfceB1g1HjdNitPrPISqd7wNldJjikrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8nEhIKqmwij8yKctNZvWQNWjYDIQtpoqt9CpQhX6Rw=;
 b=bVcfLIuvEAEq8Aj8co4GleqUdnoyPMLDwrurufwb7iF9w3CeyTOFBvx4Asu+37Nwnx1M+ILrRlClBDcjkDihv8mLIuEoXdlgAsa1kpR+8R86dEXGHTV9RSNsdG/Xg8WRFU15UENcsYi98zj2iTN4Dyg5plJdqQNdhchMzeg0Ur4oDI2oM9AEj+ENNaJAzSQQyyKbAp1mN4mnDsz8FQmYyXzutoCj7/etY0hQKniiUKa4C+0mKCqM/qmVqVTAyJpV3Lri3QG2UDW1N1ObSKUtmwCiEvgPUm7GFxk8Iv2ZzH87TlYe+zSYdRJqcGkD7feKJFFhZFLWyH81TjgGqmLMGQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:51 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 3/6] hw/display/aspeed-vga: Add ASPEED VGA display
 controller
Thread-Topic: [PATCH v2 3/6] hw/display/aspeed-vga: Add ASPEED VGA display
 controller
Thread-Index: AQHdQMX4G13TTNraW0yZzKkhBaFqVg==
Date: Thu, 10 Sep 2026 01:44:51 +0000
Message-ID: <20260910014447.4110781-4-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: bf38aa89-b289-4b18-bbb8-08df0edd1b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: urLPB81fqa6ePWnkKAe9xZLv+HllEXSZp0P/hb7WRqeSmurEVOUANG+s24Elg4okguK14E1T1a0xLX+0FmtzWf+uYI3aQSHY/S05k1tXdbvAnoq77hP91qoELHc+VEV99MUggUgU/ngoce2puF+ZZcpg85AUYafxHmSuhpdRoHNQEwPlkabG6MI+5DegIeHqrFPX35Nc4NI5gtcTpov9JwuoXli9+BzqRmSP6NiKQ3PKp9uIlmZa5FJuESA33Y95U3yl9iPQbARPoJefSBBP1Z6Lwkldv2wlC4scVCGlSbaOqMOk9ugguCyWwd6BW5/376i6+4lodJAH/ss5hru8MljITUtTdT3D26atgFnyKnHrR+zE9mTwB9RSvsJi7xEJafCwBmP2r0m/fVaesFXgTffYR6j3KhuIc2yo9vpTkP6TKi3Xemrv27KUiO3j5OLospIZblga1HczSl/9fI3y7tDUIG8hyco5MnK16DpsQEpQfS6ScUBmiFdWoDfYJV15gN/RrlIxp2Cb9gc4GjGecEFZVAh1Uf8ZCE7ui6ceViAt9Q8wY9dKpKs6+TR2hLx956CAwyyVGMX/BUvmuHqkKQpb5/Ww0m7OUQoYKrvnuSj271vKvRJD6xmdEAnnYgjCjWKG7IRqAu+oNSg8vYn+/9QPn7tdiZJIqr5HX7DTsCVjTcbPXZDeFwKyU0QM/b/vax1qjzrDvUf88K8ABUP0Xz1SNzWu2gOlYo3LS574IqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tgx0/nOOPC2JUyR+qAxYveW1iBooB+keN2av6Pqhgs7NKArD5fy09mI324?=
 =?iso-8859-1?Q?au6i0KIx8FCy3KcwRiXXMzHpJP2Pg8cPDtfnBLmMlyr0nDQ18qxbJmdybk?=
 =?iso-8859-1?Q?cTKXx5qF3LygBxBRFMLTA8kfx9qt66YONsgn0ZQOfh0jwqPA1U7c7DG+gM?=
 =?iso-8859-1?Q?1+izexv85/zBYFnjOre4dXi+xOGWdGtYKTra4NPW2ja8cEOeylCrAoemxS?=
 =?iso-8859-1?Q?QU0Jga3BpotM0kt6Pc3d4x5PrEOumKVZB5equRX7BL6xVU7FG6bSXRH9xy?=
 =?iso-8859-1?Q?N6nOc3a3bFmuqYBsapYtMrNR0PHZiqBLTlHKnpyfTD/wSdB61VHKsrs0NZ?=
 =?iso-8859-1?Q?JoNrAQ15nou1bKjh1vDaiWqjVUEodsqO7NnPHuKL2suxVoQrlIptzUVXoi?=
 =?iso-8859-1?Q?+8v2ao4wJXTIYQHmyorDNGziPNMHmWPyW1wTKCJcoPOxzare3hs+4xC2Ev?=
 =?iso-8859-1?Q?r6gcaOuNAL6lyPgXHg4i5dktcDstgW4RtZ7gFupeVgetj8T3DzgNJ1zsg8?=
 =?iso-8859-1?Q?DKUoxRyQ6eqiiHKYfcpFk8RyIaK029VkVPNyP7RbrUadqbBoJWBLSyzIxI?=
 =?iso-8859-1?Q?eW1iI46w6IjAHDZUtpyLkARoS0yHRNQ63G0oQbSyth+LqZ1nDiQnoBZ+f9?=
 =?iso-8859-1?Q?B3bzaN3ekhnYOKI38kUAGChtfLTQaFuEdMZ86Kzqy6F2MnCCYpkmhnOqIz?=
 =?iso-8859-1?Q?2lESvBPGbfXJJUBMDdxbEF4stA8bvNot7+9I8h9QGePP8oQFoRit8TzZDY?=
 =?iso-8859-1?Q?2V6eqMDE29DIPLwN4v32qnxCcap1dBdoPJGccaOFppxI8G4Efx7YUy6/Hi?=
 =?iso-8859-1?Q?trRqeaZ2Loh24B756OxA6+ksRYQ6ga2PwpRbW/+GSJa/AaHQK5obN/iY/H?=
 =?iso-8859-1?Q?ml1g6YLbyWVOflinJ/bDpsi/27M2ykCFKAGArgkalSllHfc5m76B/3Wlyz?=
 =?iso-8859-1?Q?knkMMJy05kF3ePdKy6qyJv0Tyi1doiPrtj2VvvjMvUdx2vzo1SZe79ow4o?=
 =?iso-8859-1?Q?8FMcFoYZqsz3G6hPPe1eIv8INQm+sw5wG1Q1mYsLdaK2yFcRG5da48iHYY?=
 =?iso-8859-1?Q?tkGyyTaWicrNpDEE4KHtwJlzYDxbRVhaU6v0G9kk6EYqL3+uBc+Sl8PoCb?=
 =?iso-8859-1?Q?zOMXsy7i2bzWNVuvQuJHDgnUY9XtB9dnrM6NT9+tTCOuTJbXh8KCDzvlBb?=
 =?iso-8859-1?Q?+AkTqCVjcTFFFjIYTmUsxWJMH8J+yodE8WiBW8OUrCs5/q+mwjlFDCX06w?=
 =?iso-8859-1?Q?OEmKG+Q1oezezQ6HhKOALXrfqZ9xQ+JFKUWhw0y4XY3/W/qz+F3o/VEfTQ?=
 =?iso-8859-1?Q?ZoEHRUeIVdXMsnXw261zjmmGptZnlY0ZQNsrRQX+pbdjObJIVKIVoWfric?=
 =?iso-8859-1?Q?0h9yXraHieEGENqUXPtl7a3YeUS7mjJ5thtqvGU5ruk5BbrhGdu02QK7hl?=
 =?iso-8859-1?Q?3ZXQstK4gyuXNwV93RPdRT1I2V0AzDXCwnTeO3Vh+iEJJ83tevcvuJY1lG?=
 =?iso-8859-1?Q?REWg+k+qmhFAq1NB00jovPDih67UGUYEhksTipLkb5piQncDfMlO1okL+I?=
 =?iso-8859-1?Q?+LpUO+2u7xqqLz651KlOwb7/eDXYD8mBwvL+X5/keg5q/y++ir7nrEd3m6?=
 =?iso-8859-1?Q?qHcarmLONOJvaW8Z+6PKq+QSx1hKs3rA8q6z0FGQNNhZHD8vYqyuZFhmOh?=
 =?iso-8859-1?Q?PTb72pXJY+rL5LX+mNjbjj+KXVaNjITTnOWvuqOhn1cOG4HbiB+H1KpSca?=
 =?iso-8859-1?Q?6rey5oNN0X4QQlQeCAR/xGPSCOmPOPuFwKaMJ5wjTDzwDSQgIievXxmTcr?=
 =?iso-8859-1?Q?GzfbO7iFQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gQEKWmoCSah+XMIFt9R9mUdY7rl4Kemj6vSwuzqBhuSLI6F7SYApSZQ/CpvkBPaYU8RGiBkjNMPKFZHEuZrCuwnRuic3BJj4gdaAuM2gKwkfWebjTXC+a6ICyYBYE8DNvqE0XDxEu7WET/Zn7p+ouEr0Utr+OQeMwxnbvpNbPJyxeh7l/2BjpiAPmCXfR9ISUEI5odmJK6FEYiEiHEGJbLQeXybxjC+3NcNMhoejEyDpMRXdYqVyXjSgV/bqRmhWb8KASkMBawWwNGJmZp0VwJd+XHOI1upE/Q//E97NEQ0Ke5xk2VfvIF8+uKG6HDLFPtn7n+67DshDbrYugbpRBw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf38aa89-b289-4b18-bbb8-08df0edd1b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:51.3837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NN+Gu7w/xIagygwFyR1cKFIbExU6qLk5G5E7Cnb+cluHqD7qYL9Zt6SlhN/7h7B4rj/koUaez1gba20lrEf3n+OYvoef9FQGPfQ9+gSPjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
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

The host reaches the display controller of the ASPEED BMC SoCs as a PCI=0A=
VGA device. It follows the IBM VGA 1.0 specification and adds vendor=0A=
specific CRTC registers that describe the linear framebuffer.=0A=
=0A=
- BAR 0 is the framebuffer. CRAA reports its size.=0A=
=0A=
- BAR 1 is a window over the SoC registers. Only the mirror of the=0A=
  legacy VGA I/O ports at offset 0x380 is modelled.=0A=
=0A=
- The legacy VGA I/O ports and the 0xa0000 window let a VGA BIOS drive=0A=
  the device until the guest driver takes over. The bochs VBE ports=0A=
  are left out; the hardware has no such interface.=0A=
=0A=
- The extended CRTC registers carry the color format (CRA3), the line=0A=
  offset (CR13, CRB0), the scanout address (CR0C, CR0D, CRAF) and the=0A=
  mode overflow bits (CRAC, CRAE). Until the driver sets a color=0A=
  format the device behaves as a standard VGA.=0A=
=0A=
- Blanking follows CR17 and CRB6, which is how the driver turns the=0A=
  CRTC off.=0A=
=0A=
Reset leaves the device as the BMC firmware would, so the driver does=0A=
not try to POST the chip. That includes selecting the color I/O=0A=
addresses, without which every access to the extended registers at=0A=
0x3d4/0x3d5 would be rejected as belonging to the monochrome range.=0A=
=0A=
Port 0x3c3, the VGA enable register, is not in the common code and is=0A=
handled here.=0A=
=0A=
The AST2600 and AST2700 differ only in the PCI revision id the driver=0A=
reads to tell the SoC generations apart, so that is a class attribute.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/aspeed-vga.h |  49 ++++=0A=
 hw/display/aspeed-vga.c | 490 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/display/Kconfig      |   6 +=0A=
 hw/display/meson.build  |   1 +=0A=
 hw/display/trace-events |   4 +=0A=
 5 files changed, 550 insertions(+)=0A=
 create mode 100644 hw/display/aspeed-vga.h=0A=
 create mode 100644 hw/display/aspeed-vga.c=0A=
=0A=
diff --git a/hw/display/aspeed-vga.h b/hw/display/aspeed-vga.h=0A=
new file mode 100644=0A=
index 0000000000..4b0315f699=0A=
--- /dev/null=0A=
+++ b/hw/display/aspeed-vga.h=0A=
@@ -0,0 +1,49 @@=0A=
+/*=0A=
+ * ASPEED VGA display controller=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_DISPLAY_ASPEED_VGA_H=0A=
+#define HW_DISPLAY_ASPEED_VGA_H=0A=
+=0A=
+#include "qemu/units.h"=0A=
+#include "qom/object.h"=0A=
+#include "hw/pci/pci_device.h"=0A=
+#include "vga_int.h"=0A=
+=0A=
+#define TYPE_ASPEED_VGA  "aspeed-vga"=0A=
+#define TYPE_AST2600_VGA "ast2600-vga"=0A=
+#define TYPE_AST2700_VGA "ast2700-vga"=0A=
+OBJECT_DECLARE_TYPE(AspeedVGAState, AspeedVGAClass, ASPEED_VGA)=0A=
+=0A=
+/* BAR 1 is a 128KB window over the SoC registers */=0A=
+#define ASPEED_VGA_MMIO_SIZE        (128 * KiB)=0A=
+/* VGA, offset 0x380 from the BAR 1 register base */=0A=
+#define ASPEED_VGA_IOPORT_OFFSET    0x380=0A=
+#define ASPEED_VGA_IOPORT_SIZE      0x80=0A=
+=0A=
+struct AspeedVGAState {=0A=
+    PCIDevice parent_obj;=0A=
+=0A=
+    VGACommonState vga;=0A=
+    MemoryRegion mmio;=0A=
+    MemoryRegion ioport;=0A=
+=0A=
+    uint8_t vgaer;=0A=
+=0A=
+    /* saved standard VGA handlers, used while the extended mode is off */=
=0A=
+    int (*std_get_bpp)(VGACommonState *s);=0A=
+    void (*std_get_params)(VGACommonState *s, VGADisplayParams *params);=
=0A=
+    void (*std_get_resolution)(VGACommonState *s, int *pwidth, int *pheigh=
t);=0A=
+};=0A=
+=0A=
+struct AspeedVGAClass {=0A=
+    PCIDeviceClass parent_class;=0A=
+=0A=
+    uint8_t revision;=0A=
+};=0A=
+=0A=
+#endif /* HW_DISPLAY_ASPEED_VGA_H */=0A=
diff --git a/hw/display/aspeed-vga.c b/hw/display/aspeed-vga.c=0A=
new file mode 100644=0A=
index 0000000000..bf74a0c8ce=0A=
--- /dev/null=0A=
+++ b/hw/display/aspeed-vga.c=0A=
@@ -0,0 +1,490 @@=0A=
+/*=0A=
+ * ASPEED VGA display controller=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * The display controller found in the ASPEED BMC SoCs is exposed to the=
=0A=
+ * host as a PCI VGA device that is register compatible with the IBM VGA=
=0A=
+ * 1.0 specification, extended with a set of vendor specific registers.=0A=
+ *=0A=
+ * - BAR 0: linear framebuffer (VRAM)=0A=
+ * - BAR 1: SoC register window; the mirror of the legacy VGA I/O ports=0A=
+ *   at offset 0x380 is the only implemented part=0A=
+ * - legacy VGA I/O ports and the 0xa0000 memory window, so that a=0A=
+ *   plain VGA BIOS keeps working before the ast driver takes over=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/log.h"=0A=
+#include "hw/pci/pci_device.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qemu/module.h"=0A=
+#include "qom/object.h"=0A=
+#include "ui/console.h"=0A=
+#include "trace.h"=0A=
+#include "aspeed-vga.h"=0A=
+#include "vga_int.h"=0A=
+#include "vga_regs.h"=0A=
+=0A=
+/*=0A=
+ * VGA Display Controller (VGA)=0A=
+ *=0A=
+ * Offset 0 from the BAR 1 register base=0A=
+ */=0A=
+=0A=
+/* General Registers */=0A=
+REG8(VGAER, 0x3c3)=0A=
+    FIELD(VGAER, VGA_ENABLE, 0, 1)=0A=
+=0A=
+/*=0A=
+ * ASPEED extended CRT controller register indices=0A=
+ *=0A=
+ * The CRT controller is reached through its index and data port pair,=0A=
+ * 0x3b4/0x3b5 in mono mode and 0x3d4/0x3d5 in color mode.=0A=
+ */=0A=
+REG8(AST_CR_PASSWORD, 0x80)=0A=
+#define AST_CR_PASSWORD_UNLOCK  0xa8=0A=
+REG8(AST_CR_VRAM_RSRV, 0x99)=0A=
+REG8(AST_CR_PCI_CTRL2, 0xa1)=0A=
+    FIELD(AST_CR_PCI_CTRL2, MMIO_ENABLED, 2, 1)=0A=
+REG8(AST_CR_COLOR_MODE, 0xa3)=0A=
+    FIELD(AST_CR_COLOR_MODE, FORMAT, 0, 4)=0A=
+#define AST_CR_COLOR_MODE_FORMAT_32BPP    BIT(3)=0A=
+#define AST_CR_COLOR_MODE_FORMAT_16BPP    BIT(2)=0A=
+#define AST_CR_COLOR_MODE_FORMAT_15BPP    BIT(1)=0A=
+#define AST_CR_COLOR_MODE_FORMAT_8BPP     BIT(0)=0A=
+REG8(AST_CR_STRAP1, 0xaa)=0A=
+REG8(AST_CR_H_OVERFLOW, 0xac)=0A=
+    FIELD(AST_CR_H_OVERFLOW, HDE, 2, 2)=0A=
+REG8(AST_CR_V_OVERFLOW, 0xae)=0A=
+    FIELD(AST_CR_V_OVERFLOW, VDE_D10, 1, 1)=0A=
+REG8(AST_CR_START_ADDR_EXT, 0xaf)=0A=
+REG8(AST_CR_OFFSET_HI, 0xb0)=0A=
+    FIELD(AST_CR_OFFSET_HI, OFFSET, 0, 6)=0A=
+REG8(AST_CR_POWER_MGMT, 0xb6)=0A=
+    FIELD(AST_CR_POWER_MGMT, VSYNC_OFF, 1, 1)=0A=
+    FIELD(AST_CR_POWER_MGMT, HSYNC_OFF, 0, 1)=0A=
+REG8(AST_CR_SOC_SCRATCH0, 0xd0)=0A=
+    FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_BY_BMC, 7, 1)=0A=
+    FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_READY, 6, 1)=0A=
+    FIELD(AST_CR_SOC_SCRATCH0, IKVM_WIDESCREEN, 0, 1)=0A=
+=0A=
+/*=0A=
+ * The ast driver writes a color format to CRA3 when it switches to the=0A=
+ * extended mode. Until then CRA3 is zero and the device behaves like a=0A=
+ * standard VGA.=0A=
+ */=0A=
+static bool aspeed_vga_ext_enabled(AspeedVGAState *s)=0A=
+{=0A=
+    uint8_t format =3D FIELD_EX8(s->vga.cr[R_AST_CR_COLOR_MODE],=0A=
+                               AST_CR_COLOR_MODE, FORMAT);=0A=
+=0A=
+    return format !=3D 0;=0A=
+}=0A=
+=0A=
+static int aspeed_vga_get_bpp(VGACommonState *vga)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    uint8_t format;=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s)) {=0A=
+        return s->std_get_bpp(vga);=0A=
+    }=0A=
+=0A=
+    format =3D FIELD_EX8(vga->cr[R_AST_CR_COLOR_MODE],=0A=
+                       AST_CR_COLOR_MODE, FORMAT);=0A=
+=0A=
+    switch (format) {=0A=
+    case AST_CR_COLOR_MODE_FORMAT_8BPP:=0A=
+        return 8;=0A=
+    case AST_CR_COLOR_MODE_FORMAT_15BPP:=0A=
+        return 15;=0A=
+    case AST_CR_COLOR_MODE_FORMAT_16BPP:=0A=
+        return 16;=0A=
+    case AST_CR_COLOR_MODE_FORMAT_32BPP:=0A=
+        return 32;=0A=
+    default:=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The ast driver turns the display off through CR17 bit 7 or the power=0A=
+ * management register, not through the attribute controller bit that the=
=0A=
+ * common VGA code looks at.=0A=
+ */=0A=
+static bool aspeed_vga_is_blanked(VGACommonState *vga)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    bool crtc_sync_off;=0A=
+    bool pm_sync_off;=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s)) {=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    crtc_sync_off =3D !(vga->cr[VGA_CRTC_MODE] & VGA_CR17_H_V_SIGNALS_ENAB=
LED);=0A=
+    pm_sync_off =3D vga->cr[R_AST_CR_POWER_MGMT] &=0A=
+                  (R_AST_CR_POWER_MGMT_HSYNC_OFF_MASK |=0A=
+                   R_AST_CR_POWER_MGMT_VSYNC_OFF_MASK);=0A=
+=0A=
+    return crtc_sync_off || pm_sync_off;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_get_resolution(VGACommonState *vga,=0A=
+                                      int *pwidth, int *pheight)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    int height;=0A=
+    int width;=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s)) {=0A=
+        s->std_get_resolution(vga, pwidth, pheight);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* horizontal display end, D[7:0] in CR01 and D[9:8] in CRAC */=0A=
+    width =3D vga->cr[VGA_CRTC_H_DISP] |=0A=
+            (FIELD_EX8(vga->cr[R_AST_CR_H_OVERFLOW],=0A=
+                       AST_CR_H_OVERFLOW, HDE) << 8);=0A=
+    width =3D (width + 1) * 8;=0A=
+=0A=
+    /*=0A=
+     * vertical display end, D[7:0] in CR12, D[9:8] in CR07 and=0A=
+     * D[10] in CRAE=0A=
+     */=0A=
+    height =3D vga->cr[VGA_CRTC_V_DISP_END] |=0A=
+             ((vga->cr[VGA_CRTC_OVERFLOW] & 0x02) << 7) |=0A=
+             ((vga->cr[VGA_CRTC_OVERFLOW] & 0x40) << 3);=0A=
+    if (FIELD_EX8(vga->cr[R_AST_CR_V_OVERFLOW], AST_CR_V_OVERFLOW, VDE_D10=
)) {=0A=
+        height |=3D BIT(10);=0A=
+    }=0A=
+    height =3D height + 1;=0A=
+=0A=
+    *pwidth =3D width;=0A=
+    *pheight =3D height;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_get_params(VGACommonState *vga,=0A=
+                                  VGADisplayParams *params)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s)) {=0A=
+        s->std_get_params(vga, params);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * GR05 bit 6 selects the mode 13 shift mode, which is packed pixel li=
ke=0A=
+     * the extended modes. Without it the common code picks its planar=0A=
+     * reader when it draws into its own surface.=0A=
+     */=0A=
+    vga->gr[VGA_GFX_MODE] |=3D BIT(6);=0A=
+=0A=
+    /*=0A=
+     * line offset is in units of 8 bytes, D[7:0] in CR13 and=0A=
+     * D[13:8] in CRB0=0A=
+     */=0A=
+    params->line_offset =3D (vga->cr[VGA_CRTC_OFFSET] |=0A=
+                           (FIELD_EX8(vga->cr[R_AST_CR_OFFSET_HI],=0A=
+                                      AST_CR_OFFSET_HI, OFFSET) << 8)) * 8=
;=0A=
+=0A=
+    /*=0A=
+     * start address is in units of 4 bytes, D[7:0] in CR0D,=0A=
+     * D[15:8] in CR0C and D[23:16] in CRAF=0A=
+     */=0A=
+    params->start_addr =3D vga->cr[VGA_CRTC_START_LO] |=0A=
+                         (vga->cr[VGA_CRTC_START_HI] << 8) |=0A=
+                         (vga->cr[R_AST_CR_START_ADDR_EXT] << 16);=0A=
+=0A=
+    params->line_compare =3D 65535;=0A=
+    params->hpel =3D VGA_HPEL_NEUTRAL;=0A=
+    params->hpel_split =3D false;=0A=
+}=0A=
+=0A=
+static uint8_t aspeed_vga_vgamem_size_reg(uint32_t vram_size_mb)=0A=
+{=0A=
+    switch (vram_size_mb) {=0A=
+    case 8:=0A=
+        return 0;=0A=
+    case 16:=0A=
+        return 1;=0A=
+    case 32:=0A=
+        return 2;=0A=
+    case 64:=0A=
+        return 3;=0A=
+    default:=0A=
+        g_assert_not_reached();=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint8_t aspeed_vga_read_byte(AspeedVGAState *s, uint32_t port)=0A=
+{=0A=
+    uint8_t val;=0A=
+=0A=
+    switch (port) {=0A=
+    case A_VGAER:=0A=
+        val =3D s->vgaer;=0A=
+        break;=0A=
+    default:=0A=
+        val =3D vga_ioport_read(&s->vga, port);=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_vga_read_byte(port, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_write_byte(AspeedVGAState *s, uint32_t port, uint8_=
t val)=0A=
+{=0A=
+    trace_aspeed_vga_write_byte(port, val);=0A=
+=0A=
+    switch (port) {=0A=
+    case A_VGAER:=0A=
+        s->vgaer =3D val & R_VGAER_VGA_ENABLE_MASK;=0A=
+        break;=0A=
+    default:=0A=
+        vga_ioport_write(&s->vga, port, val);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_vga_ioport_read(void *opaque, hwaddr addr, unsigned=
 size)=0A=
+{=0A=
+    AspeedVGAState *s =3D opaque;=0A=
+    uint64_t val =3D 0;=0A=
+    unsigned i;=0A=
+=0A=
+    addr +=3D ASPEED_VGA_IOPORT_OFFSET;=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        val =3D deposit64(val, i * 8, 8, aspeed_vga_read_byte(s, addr + i)=
);=0A=
+    }=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_ioport_write(void *opaque, hwaddr addr, uint64_t va=
l,=0A=
+                                    unsigned size)=0A=
+{=0A=
+    AspeedVGAState *s =3D opaque;=0A=
+    unsigned i;=0A=
+=0A=
+    addr +=3D ASPEED_VGA_IOPORT_OFFSET;=0A=
+=0A=
+    /*=0A=
+     * Byte by byte in little endian order, so that a single word write to=
 an=0A=
+     * index/data register pair updates the index first.=0A=
+     */=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        aspeed_vga_write_byte(s, addr + i, extract64(val, i * 8, 8));=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_vga_ioport_ops =3D {=0A=
+    .read =3D aspeed_vga_ioport_read,=0A=
+    .write =3D aspeed_vga_ioport_write,=0A=
+    .valid.min_access_size =3D 1,=0A=
+    .valid.max_access_size =3D 4,=0A=
+    .impl.min_access_size =3D 1,=0A=
+    .impl.max_access_size =3D 4,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
+static void aspeed_vga_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedVGAState *s =3D ASPEED_VGA(obj);=0A=
+    VGACommonState *vga =3D &s->vga;=0A=
+=0A=
+    vga_common_reset(vga);=0A=
+=0A=
+    s->vgaer =3D R_VGAER_VGA_ENABLE_MASK;=0A=
+=0A=
+    /*=0A=
+     * Select the color emulation I/O addresses, so that the CRTC answers =
at=0A=
+     * 0x3d4/0x3d5 where the extended registers live. The VGA BIOS normall=
y=0A=
+     * does this, and the ast driver only does it when it has to POST the=
=0A=
+     * chip, which this model reports as already done.=0A=
+     */=0A=
+    vga->msr =3D VGA_MIS_COLOR;=0A=
+=0A=
+    vga->cr[R_AST_CR_PASSWORD] =3D AST_CR_PASSWORD_UNLOCK;=0A=
+    vga->cr[R_AST_CR_PCI_CTRL2] =3D R_AST_CR_PCI_CTRL2_MMIO_ENABLED_MASK;=
=0A=
+=0A=
+    /* VRAM size, no reserved area */=0A=
+    vga->cr[R_AST_CR_STRAP1] =3D aspeed_vga_vgamem_size_reg(vga->vram_size=
_mb);=0A=
+    vga->cr[R_AST_CR_VRAM_RSRV] =3D 0;=0A=
+=0A=
+    vga->cr[R_AST_CR_SOC_SCRATCH0] =3D=0A=
+        R_AST_CR_SOC_SCRATCH0_VRAM_INIT_BY_BMC_MASK |=0A=
+        R_AST_CR_SOC_SCRATCH0_VRAM_INIT_READY_MASK |=0A=
+        R_AST_CR_SOC_SCRATCH0_IKVM_WIDESCREEN_MASK;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The standard VGA has a bochs VBE interface and this hardware does not, =
so=0A=
+ * set up the 0xa0000 window and the legacy I/O ports here, not vga_init()=
.=0A=
+ */=0A=
+static void aspeed_vga_init_io(AspeedVGAState *s, PCIDevice *dev)=0A=
+{=0A=
+    MemoryRegion *address_space =3D pci_address_space(dev);=0A=
+    const MemoryRegionPortio *vga_ports;=0A=
+    const MemoryRegionPortio *vbe_ports;=0A=
+    VGACommonState *vga =3D &s->vga;=0A=
+    MemoryRegion *vga_io_memory;=0A=
+=0A=
+    vga->bank_offset =3D 0;=0A=
+    vga->legacy_address_space =3D address_space;=0A=
+=0A=
+    vga_io_memory =3D vga_init_io(vga, OBJECT(dev), &vga_ports, &vbe_ports=
);=0A=
+    memory_region_add_subregion_overlap(address_space, 0x000a0000,=0A=
+                                        vga_io_memory, 1);=0A=
+    memory_region_set_coalescing(vga_io_memory);=0A=
+=0A=
+    /* vga_init_io() fills in both VGA and VBE ports; only VGA is register=
ed */=0A=
+    portio_list_init(&vga->vga_port_list, OBJECT(dev), vga_ports, vga, "vg=
a");=0A=
+    portio_list_set_flush_coalesced(&vga->vga_port_list);=0A=
+    portio_list_add(&vga->vga_port_list, pci_address_space_io(dev), 0x3b0)=
;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_realize(PCIDevice *dev, Error **errp)=0A=
+{=0A=
+    AspeedVGAClass *ac =3D ASPEED_VGA_GET_CLASS(dev);=0A=
+    AspeedVGAState *s =3D ASPEED_VGA(dev);=0A=
+    VGACommonState *vga =3D &s->vga;=0A=
+=0A=
+    switch (vga->vram_size_mb) {=0A=
+    case 8:=0A=
+    case 16:=0A=
+    case 32:=0A=
+    case 64:=0A=
+        break;=0A=
+    default:=0A=
+        error_setg(errp,=0A=
+                   TYPE_ASPEED_VGA ": vgamem_mb must be 8, 16, 32 or 64");=
=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!vga_common_init(vga, OBJECT(dev), errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_vga_init_io(s, dev);=0A=
+=0A=
+    s->std_get_bpp =3D vga->get_bpp;=0A=
+    s->std_get_params =3D vga->get_params;=0A=
+    s->std_get_resolution =3D vga->get_resolution;=0A=
+    vga->get_bpp =3D aspeed_vga_get_bpp;=0A=
+    vga->get_params =3D aspeed_vga_get_params;=0A=
+    vga->get_resolution =3D aspeed_vga_get_resolution;=0A=
+    vga->is_blanked =3D aspeed_vga_is_blanked;=0A=
+    vga->big_endian_fb =3D false;=0A=
+=0A=
+    vga->con =3D qemu_graphic_console_create(DEVICE(dev), 0, vga->hw_ops, =
vga);=0A=
+=0A=
+    pci_set_byte(&dev->config[PCI_REVISION_ID], ac->revision);=0A=
+=0A=
+    memory_region_init_io(&s->mmio, OBJECT(dev), &unassigned_io_ops, NULL,=
=0A=
+                          "aspeed-vga.container", ASPEED_VGA_MMIO_SIZE);=
=0A=
+=0A=
+    memory_region_init_io(&s->ioport, OBJECT(dev), &aspeed_vga_ioport_ops,=
 s,=0A=
+                          "aspeed-vga.ioport", ASPEED_VGA_IOPORT_SIZE);=0A=
+    memory_region_add_subregion(&s->mmio, ASPEED_VGA_IOPORT_OFFSET,=0A=
+                                &s->ioport);=0A=
+=0A=
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);=
=0A=
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);=0A=
+}=0A=
+=0A=
+static void aspeed_vga_exit(PCIDevice *dev)=0A=
+{=0A=
+    AspeedVGAState *s =3D ASPEED_VGA(dev);=0A=
+=0A=
+    qemu_graphic_console_close(s->vga.con);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_aspeed_vga =3D {=0A=
+    .name =3D "aspeed-vga",=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_PCI_DEVICE(parent_obj, AspeedVGAState),=0A=
+        VMSTATE_STRUCT(vga, AspeedVGAState, 0, vmstate_vga_common,=0A=
+                       VGACommonState),=0A=
+        VMSTATE_UINT8(vgaer, AspeedVGAState),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static const Property aspeed_vga_properties[] =3D {=0A=
+    DEFINE_PROP_UINT32("vgamem_mb", AspeedVGAState, vga.vram_size_mb, 32),=
=0A=
+};=0A=
+=0A=
+static void aspeed_vga_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    k->realize =3D aspeed_vga_realize;=0A=
+    k->exit =3D aspeed_vga_exit;=0A=
+    k->vendor_id =3D PCI_VENDOR_ID_ASPEED;=0A=
+    k->device_id =3D 0x2000;=0A=
+    k->class_id =3D PCI_CLASS_DISPLAY_VGA;=0A=
+    k->subsystem_vendor_id =3D PCI_VENDOR_ID_ASPEED;=0A=
+    k->subsystem_id =3D 0x2000;=0A=
+    k->romfile =3D "vgabios-stdvga.bin";=0A=
+=0A=
+    dc->vmsd =3D &vmstate_aspeed_vga;=0A=
+    rc->phases.hold =3D aspeed_vga_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_vga_properties);=0A=
+    dc->hotpluggable =3D false;=0A=
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);=0A=
+}=0A=
+=0A=
+static void ast2600_vga_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    AspeedVGAClass *avc =3D ASPEED_VGA_CLASS(klass);=0A=
+=0A=
+    DEVICE_CLASS(klass)->desc =3D "ASPEED AST2600 VGA";=0A=
+    avc->revision =3D 0x52;=0A=
+}=0A=
+=0A=
+static void ast2700_vga_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    AspeedVGAClass *avc =3D ASPEED_VGA_CLASS(klass);=0A=
+=0A=
+    DEVICE_CLASS(klass)->desc =3D "ASPEED AST2700 VGA";=0A=
+    avc->revision =3D 0x72;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_vga_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_VGA,=0A=
+        .parent        =3D TYPE_PCI_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedVGAState),=0A=
+        .class_size    =3D sizeof(AspeedVGAClass),=0A=
+        .class_init    =3D aspeed_vga_class_init,=0A=
+        .abstract      =3D true,=0A=
+        .interfaces =3D (const InterfaceInfo[]) {=0A=
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },=0A=
+            { },=0A=
+        },=0A=
+    }, {=0A=
+        .name          =3D TYPE_AST2600_VGA,=0A=
+        .parent        =3D TYPE_ASPEED_VGA,=0A=
+        .class_init    =3D ast2600_vga_class_init,=0A=
+    }, {=0A=
+        .name          =3D TYPE_AST2700_VGA,=0A=
+        .parent        =3D TYPE_ASPEED_VGA,=0A=
+        .class_init    =3D ast2700_vga_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_vga_types)=0A=
diff --git a/hw/display/Kconfig b/hw/display/Kconfig=0A=
index b3593fe981..c5253a08b3 100644=0A=
--- a/hw/display/Kconfig=0A=
+++ b/hw/display/Kconfig=0A=
@@ -48,6 +48,12 @@ config VGA_PCI=0A=
     select VGA=0A=
     select EDID=0A=
 =0A=
+config ASPEED_VGA=0A=
+    bool=0A=
+    default y if PCI_DEVICES=0A=
+    depends on PCI=0A=
+    select VGA=0A=
+=0A=
 config VGA_ISA=0A=
     bool=0A=
     depends on ISA_BUS=0A=
diff --git a/hw/display/meson.build b/hw/display/meson.build=0A=
index ffecedbf70..f15e9c28a9 100644=0A=
--- a/hw/display/meson.build=0A=
+++ b/hw/display/meson.build=0A=
@@ -18,6 +18,7 @@ system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd=
0303.c'))=0A=
 system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))=0A=
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))=0A=
 =0A=
+system_ss.add(when: 'CONFIG_ASPEED_VGA', if_true: files('aspeed-vga.c'))=
=0A=
 system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))=0A=
 system_ss.add(when: 'CONFIG_VGA_ISA', if_true: files('vga-isa.c'))=0A=
 system_ss.add(when: 'CONFIG_VGA_MMIO', if_true: files('vga-mmio.c'))=0A=
diff --git a/hw/display/trace-events b/hw/display/trace-events=0A=
index 4bfc457fba..fd4289d755 100644=0A=
--- a/hw/display/trace-events=0A=
+++ b/hw/display/trace-events=0A=
@@ -138,6 +138,10 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t val) "o=
ffset 0x%x, val 0x%x"=0A=
 vga_cirrus_write_gr(uint8_t index, uint8_t val) "GR addr 0x%02x, val 0x%02=
x"=0A=
 vga_cirrus_bitblt_start(uint8_t blt_rop, uint8_t blt_mode, uint8_t blt_mod=
eext, int blt_width, int blt_height, int blt_dstpitch, int blt_srcpitch, ui=
nt32_t blt_dstaddr, uint32_t blt_srcaddr, uint8_t gr_val) "rop=3D0x%02x mod=
e=3D0x%02x modeext=3D0x%02x w=3D%d h=3D%d dpitch=3D%d spitch=3D%d daddr=3D0=
x%08"PRIx32" saddr=3D0x%08"PRIx32" writemask=3D0x%02x"=0A=
 =0A=
+# aspeed-vga.c=0A=
+aspeed_vga_read_byte(uint32_t port, uint8_t val) "port 0x%03x, val 0x%02x"=
=0A=
+aspeed_vga_write_byte(uint32_t port, uint8_t val) "port 0x%03x, val 0x%02x=
"=0A=
+=0A=
 # sii9022.c=0A=
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"=0A=
 sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"=0A=
-- =0A=
2.53.0=0A=

