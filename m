Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=myY3yaSX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtXP-0001lk-F7; Tue, 27 Oct 2026 22:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtXN-0001lF-NX; Tue, 27 Oct 2026 22:37:13 -0400
Received: from mail-japanwestazon11022134.outbound.protection.outlook.com
 ([40.107.75.134] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtXL-0000AG-44; Tue, 27 Oct 2026 22:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWrOoXBQMpDXlzVDdbr/lPfcQ5J90Wa2kexrnxbIPjcENwIf2nj8O8GCX+CSjAXaPwW+a1skII9/Q9NPUImrp1mpJ8IVz5fdSGvijPIwwxdvKJqOmPmsht6COTJ/sfLwp5dSLXTAjZCMryjEFWc0urLB8PIKvmBhdwdvSAA/nPLjJn5pJHG4w3V5C/6nmthM5kEblEW5ZvUFi/3Ka88Nm3XjsUXhISH5IL6lnYeX78j0NOQfl5IllArw4zPwmSLcvZ3ojxHNJfEWtUZg59z9vdw0azXUeQz9kfLbFboIgQ2GPwtJncPi2UxK/CiEIKYReeY00h9kayvd/KI+zF/VXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vshM+yQYNUhy3JpCzJsGxRipAW7Mv6cCpZ/KGInPwoo=;
 b=obvIM5/oeHH5O/9WqaKybri2w4hVPqKel8W0We+Biejw0HntEFGMfQvyvvLzQH7h4toscAR6xm/Pxf4WBtrCDtNTacZ1HVShTmjnviZHzIpvm37Q/Uj3ww8VmZGXsuyGJ0gEVTH0vg1AaNkozBYGv029XJ2qNP1j3J6sqsumhdaxiFs+Ax4Os6ZsdFqfHheMIWUWW6ATwJQ7uAAg57+0xpus78UymMH3AMU4e40Cgxg35lXcJAv5nGJrabrXcOaemrsFYfTJRdum8cRsIkrT4o51MPMb71vRXCooCg3Y7IZn0h8TfKuIWtO+pWBqw8LerwQhd0Z59sq8JJt5fo1oMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vshM+yQYNUhy3JpCzJsGxRipAW7Mv6cCpZ/KGInPwoo=;
 b=myY3yaSXHojhfGx67HN7mF3wxSJ1G8mauaihxdLl9MduVD/oGwXI8OCPMeM0avd2c9DOzp73YT8QJqCTh14gkKFgoAJJhYKKhCrIMahKCSB08VS1zpL/p+aCrkV4ftFVMoEgJVhYkfGx/xxP8LO2zde7vqeHr1Lj5QFLXLvEEyLEshCSieoj22DxJQ1EgqXDWoqnVB5yGZUm/i3bTdhBAKtHgxl6TKqLGbfUaHEjYhWM7fZZXSRVJTRgFTVwLR1VmcgTASMRz6UiMxPHFps10LOrDJKOW4cy6zDLUsqBXwLgnufRQTqzOj6g0k8hTUqGH1hHztNSENKqK6PCr/v3/A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:31:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:31:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/13] hw/arm/aspeed: Add AST1040 FMC/SPI controllers and
 unimplemented devices
Thread-Topic: [PATCH v2 00/13] hw/arm/aspeed: Add AST1040 FMC/SPI controllers
 and unimplemented devices
Thread-Index: AQHdZoR/xXOvP6uOZ0eF+yKn61vddA==
Date: Wed, 28 Oct 2026 02:31:55 +0000
Message-ID: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: 902a0c56-e240-49b8-f4cd-08df349ba1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009223027099003|261022075727099003|261022115727099003|261021123027099003|261021121427099003|10067099003|18002099003;
x-microsoft-antispam-message-info: jDe3kg+HIN8ndej/vOvMmFCQ2b2P5BY0vBm9w8au6rXlG8pM/X3Jlcdez7nRvPrukmhvYDqrC467zniDwZWZSLC+TXpTSr1P6QUfNCP4Zz08Pt7umMaLD2gGbq3EYJF5vhNl+um6mAHPU17bOL0B0AKTp4elXbJmoeBb0givB95Yni61xtPIuycBEiGRJtjjewGhbxeGWBPdCwxWM5VY3XhMYwkp4ee0lQcuJ9+zJFLh8+dU92jRooRR6CMfbwlihboqyT9IsNwfXa/Nb0RyXdJ52lovpesm2a3O0Ir20HJ5HJoXn1jXBr2KBra3Njl5HsVJSkkl0hqhEMTtGdXuA3PCFp6O8uCUCLma2yjUq7ubfygHGfhLwmm0Ot+oxYqUlEYdIrOEsE8XrG6xR8T0QcRrdRhemDcqoMgzHL+6nx46fIqQZUUsjrWUnmSuRwNiORLe/NAkinrSnTYCknAEoUxgZ1M9oGOFZymzLoeMAkXKMSVRB9L2Eqkk8AmAEiuVKFJ1F2NYTb80Wo4eDgrtR6kfclOkdpc9JpbKJqOP6Ms+hWpopvlLYe6R1bxGGooO3gF5Ke4SfR/c6sO9raGMHdEEqWUGs4vLx87LTPmlcP8bZqhMiY7BuHlYIQriUWrhPtaY8/O/MUQ9kdr/cP5Di1odoybjTmcJj5C0W6AuPZf+CUbJtWcw/TOAPzLX+R0zmPwGC43Alu+9V2FDovgcSrtzh14abACPKbzcsyFvV4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009223027099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BT2ZVW7lzEBr84Dy0N0/VcR+uxm5jesETUP4gTvEyNDEMbhZzOMY6S8d/d?=
 =?iso-8859-1?Q?Hz4qZdqchrGnCeivNHyFJf3JZ9mytSlLzUAxV/wASaRyfrw0VCBqXxWLRM?=
 =?iso-8859-1?Q?XkDqWyhss3QXesU0+PT9gWppBADKUCcayvgu2/PEcP8F+0d2r+B4BY1UQU?=
 =?iso-8859-1?Q?KfAp9JmqwoO8yvZ9p4ZyR0ZQ+yopfYaO+8sW2iciwKsca88TDjx5QFsPqa?=
 =?iso-8859-1?Q?1DiIRVhvfG7/0g6Ga1eXNjaf7e61fYTR+x34XR+vX07Ask4bLDNDA3HQG8?=
 =?iso-8859-1?Q?z20O1smMOK9v0XSSlB6plklQhELMSOoGNvjbPxNJeWiXLqGdMtVYE2qfSM?=
 =?iso-8859-1?Q?yhe6ukNmWGk9y9GMxwcg3Mkqt23+FQIQNAWp6eABTxoODV0GHUUQfLqkK6?=
 =?iso-8859-1?Q?LedaTda8d5rB6nXWiPvxP1PQSeRm5PIC+IZqpMVIPOTgQa7FugfPlprqcL?=
 =?iso-8859-1?Q?dwdZiCWz0E6QBl9ohFhnKDNvidwxtlZQbt/oWQvPDLwWLMEFelqCS5hNfw?=
 =?iso-8859-1?Q?0NdOJA7LypaYa8iBQD+oC997CtkHyyiI8/zr8HwFu8xsQ/mD6uYQH305Dr?=
 =?iso-8859-1?Q?hE41surs3ORIzU2nuH6FDjEQrYU5T/F/oKPrenSdi8vdnFKygl/MZsWQ5T?=
 =?iso-8859-1?Q?cQ9P8HULCT1yNoOMHnh3QJDoJbV4RmQl3ZpZuhTX9Ti8eoxLAUJyyKbCdO?=
 =?iso-8859-1?Q?Aw8l/fMJ1aAoAhkZoowIlIrLmAP+pds1mIntJuQy8zApkn0ywht5dTgvkM?=
 =?iso-8859-1?Q?gBz472siXR6m+D6SRBt/Mn+heJdsa9Y/vxRUUudPCoVfZOPNb9BYE5msDb?=
 =?iso-8859-1?Q?lJUfeHO/VFAKNoNZvW3bVmEzv4RgdSxWy1YSH/TbgKI/loA0g/mDYwOcWK?=
 =?iso-8859-1?Q?I4e9ps6Fso0hWy2hi8JqhMtuoU6l7cRULePdz94BdK3k74dcHpj5Q5TMr8?=
 =?iso-8859-1?Q?PaGCwI5PN5KHyucu4qU9f+OTyo8/NdP+NZD6x0+dwMqoWm6KqSf30F+z2M?=
 =?iso-8859-1?Q?cPZ5owG8gdO7AbdmMS3xVL8XurUGZr7FaNX00sDIKm1z+ObRVjaAK4noGD?=
 =?iso-8859-1?Q?ukzCzHaUaMAqrsLa9CYVnK4IbBxmxFqy1Jj/YqjamRbms8LfglZuliDaJD?=
 =?iso-8859-1?Q?S3CvDGEZhwQwABUtnh3opp2ZRWhxjaZpHihSepXysJZN0qnjs7DtfZ+cUV?=
 =?iso-8859-1?Q?4AriHQn3s9n32xwkdlIQFnTrnHPiI5pRrKAQzXWJH1JVBiDZmZZGr1QuJg?=
 =?iso-8859-1?Q?dFV/zDAYfvaTSwZbh0tTQTsex3o7PqYGg7fDv1frs8Ymzf21iy/MEfBVBF?=
 =?iso-8859-1?Q?Q8bSSRWi1C8sfPc79H2UbNZqTyOmIpMkAtJBWFDwDcOPsyO16mxsXkfxmp?=
 =?iso-8859-1?Q?giBBo6BTNk98BSk2hMjreopTpddxLyK/sFmohLHqKQw5vDrnuwkIYcBI2k?=
 =?iso-8859-1?Q?qluTWShzSXJyf+p9sTky6KbDbTPwU1NR9Q755ICFY9532HNb8r9ryh5LXU?=
 =?iso-8859-1?Q?Wg3twJ1dDyhTlIse5wT8PsbMWezSop6DDWHfL5Qkzdt5I/Nl+k0YCL+xkN?=
 =?iso-8859-1?Q?BY5XlB3LC6vNFyokjkQ19iVDr+GzJHZJ4a9CGa3/ymWpRUaLyEYEQxlWBc?=
 =?iso-8859-1?Q?7PiHQeqycPbiDR/JSGQSJUWykgfjQxQzQopSu5vwV3mczRRuJ9FGxm1td/?=
 =?iso-8859-1?Q?X7WzvHHVmQEqNI3mRnKXT0JdsYTrMzmDJV5rPWR4DyX+FugFyrJec2UhSY?=
 =?iso-8859-1?Q?WtVv+XqzVe99PAdP8CJM/bmTpJrhWkvaqoEZAEzd6QQ/ykO7FUnLTsmpnc?=
 =?iso-8859-1?Q?sq43ZlEQ5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902a0c56-e240-49b8-f4cd-08df349ba1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:55.0807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0OLqaAXU+I26jCD4OC3sGWMm1Q+A+kM+QGKqZcrB5fv6WaUlqcjbZvt2j3nNfbMpPjZTVOK7GxbZ1ENb0KlhPjLPOmgtPcVVL8/iMdaou0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
Received-SPF: pass client-ip=40.107.75.134;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1:=0A=
 1. Fix AST2700 segment end address decoding=0A=
 2. Fix AST2700 DMA flash address mask=0A=
 3. Rename w25q32dw to w25q33pw and add the SFDP table for the W25Q33PW,=0A=
 4. Correct the AST1040 A0 silicon revision ID=0A=
 5. Add FMC and SPI controllers=0A=
 6. Add the FMC/SPI filters, OTP, ATC, I3C and Caliptra register=0A=
    regions as unimplemented device=0A=
 7. Update the AST1040 functional test to use the official pre-built=0A=
    image from aspeed-mcu-fw-hub v01.00.=0A=
=0A=
v2:=0A=
  1. Add w25q33pw as a separate flash model instead of renaming w25q32dw.=
=0A=
  2. Add the AST1040 SMC reset value table.=0A=
=0A=
Jamin Lin (13):=0A=
  hw/ssi/aspeed_smc: Fix AST2700 segment end address decoding=0A=
  hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask=0A=
  hw/block/m25p80: Add Winbond W25Q33PW flash=0A=
  hw/misc/aspeed_scu: Correct AST1040 A0 revision ID=0A=
  hw/ssi/aspeed_smc: Add AST1040 FMC and SPI controllers=0A=
  hw/arm/aspeed_ast1040: Add FMC and SPI controllers=0A=
  hw/arm/aspeed_ast1040: Add FMC and SPI filters as unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast1040: Add OTP as an unimplemented device=0A=
  hw/arm/aspeed_ast1040: Add Anti-Tamper Controller (ATC) as an=0A=
    unimplemented device=0A=
  hw/arm/aspeed_ast1040: Add I3C as an unimplemented device=0A=
  hw/arm/aspeed_ast1040: Add Caliptra as an unimplemented device=0A=
  tests/qtest/aspeed_smc: Add AST1040 SMC tests=0A=
  tests/functional/arm/test_aspeed_ast1040: Update AST1040 image to=0A=
    aspeed-mcu-fw-hub v01.00=0A=
=0A=
 hw/block/m25p80_sfdp.h                      |   1 +=0A=
 include/hw/misc/aspeed_scu.h                |   2 +-=0A=
 hw/arm/aspeed_ast1040.c                     |  45 +++++++=0A=
 hw/block/m25p80.c                           |   2 +=0A=
 hw/block/m25p80_sfdp.c                      |  36 ++++++=0A=
 hw/ssi/aspeed_smc.c                         | 131 +++++++++++++++++++-=0A=
 tests/qtest/aspeed_smc-test.c               |  61 +++++++++=0A=
 tests/functional/arm/test_aspeed_ast1040.py |  12 +-=0A=
 8 files changed, 278 insertions(+), 12 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

