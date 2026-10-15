Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDBBCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESV-0001k1-G7; Thu, 15 Oct 2026 01:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESS-0001jB-JL; Thu, 15 Oct 2026 01:56:52 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESQ-0003Ci-0e; Thu, 15 Oct 2026 01:56:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UviK3TWZ11Q2R0GMYHh1mItFbO+9UE6OHJa4IX9xlNfhKQMiPUtk0Zw/OPFu3hCWBtIBEExWOr1tunTIbs6d/b/52SIvPpr4WXYagt57NJArZIRYcZ9PfQFkGA3wBU5SkaHdqqSWbPyxHfaHtTwykOl+z2DvUCOWoYFqr1KDO3+DyAZuEXsuOnJBaPG7uDScEnH5ZKvc18sTsdSdtq13c2F0KhZb5uCBLpwDPOeVrwM3SyEJazPa+uxP4Jsh3YwAVErw/elT0ckIThjyLWpSQLCphEpgSzd8l+B2WNOU6aLdJN6cCkKuEtgOSdWQ2vfN6XyIWh6xjDJ9GJTePC3pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X//fO9mwIIeqh1eEKo6f8lqah8Tj85x+S0SWjtFHhI=;
 b=iQ+N6nvFU0fi3VienAIl6IX4cP9O5PZDefdx5NWtyzu7xVDCix9ByS1poUiipnB0xPUe9CukoCAezzsuJZVLnkS0pxtZATMnBB7qVZw+U4wxSxHACJ9s1QbgPvLlMadmY3Z9+FwoiYVy5gYstwlg7HqKB41ydDnz3opFIYXIL4jzefy+fQnpihYCSElAy1Vd2xrQsUxjlxH0YCmMo4qKxUiKow71aLwJNDcf/4p8mFinw96k0eMmoVcOoiZtUzAGOnfoDdp75qAQjBJg9wuFoikiPPXMYRSE87+USqoV6xP+VVPclCekKsgZYJsUrqvxpeufYPY4iREIAjqqzsGKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X//fO9mwIIeqh1eEKo6f8lqah8Tj85x+S0SWjtFHhI=;
 b=k1gg7E6OELnROHACUGyK75cDVQqTaUYtjdO6dBGR2z9nkt+sbtL5wdgnHmTIpzeuXNiLLGdNQ2WjtvRybk23h0neui7QmB1e+Fv65ntuIcM3XjLjsBbZFgGe949TRXmswy4RAisRqIZqbKnBGqkq6ZQsZ3iRx+mwfjkI/IcOMxKpT6zJCVEVNXhhL6yIgKezSQwOe+mruSiULwPhsgpAcPecrr1WRjJ0NJZ0ZeCtB80PnG+qrh55kyKLuTFn5yKHePoSawgli97rj/eqLoJc2eBYTnVQ2sPQ4/Uq2jQLkq7/ffKUz58nEhCLHTaafp4YUVF+kCkdYAFq2XBf4V5W8Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5736.apcprd06.prod.outlook.com (2603:1096:400:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:43 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/14] hw/arm/aspeed: Add AST1040 FMC/SPI controllers and
 unimplemented devices
Thread-Topic: [PATCH v1 00/14] hw/arm/aspeed: Add AST1040 FMC/SPI controllers
 and unimplemented devices
Thread-Index: AQHdXGn03wcEq+63Vkq4UlnhEzvLTQ==
Date: Thu, 15 Oct 2026 05:56:43 +0000
Message-ID: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5736:EE_
x-ms-office365-filtering-correlation-id: de4b784f-6047-4ce7-0eac-08df2a811705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|921020|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: F+j2zwMa0maydsVzKK7nKl/saxEJLjgz9mdc5MaS0zKGhBFacB8xoThUE9IfrYDbEZDfy7qSzkyvf8TDEaYtFg2QkDTc9BeVDd0nFptiPwNO5lyoRH3zN6w8fllKzUy1tnRBwM2dL3TAS/qeRXCh8RnRJCVbnZW1CWxSpJcrnuKfqHKwFn1Sjsvfim5J0IwIUl6vvuACRdSFQaZ8HxY0w98GZk48+x/gmnhYGyCXSCoLqIhv+kAu5bIuv+MAmZy2wJrxi7avW/ZHLKjvKB+pJqaelfT+nErFhAHW0pk8LK6mV0J8MxSHrVsWN84U6Sudf+fr/Wat0Xz8HC19nA6iU/pt2hj8Evj8Yg2T5eBai78k1SLpeCiNRqK7WQMoFwat2v/TxN+vSmcOidW0usOY+wTq8usePJcWtTifA4eCSAcNrRl1duEi/65zodHsWnlPuv1m+K2H0cj28CmaIL6tfkOcxKycq7XVzMS7ps45TusA/WVxaWI5qIx9uZfCpxNXyNgIVPh98jsKXpf6+vekyQRuDg+eFLaofcuols77N9j8Xz/Eou7ySAaYwkYaRUFfYVCjXMfsPsTal/byHNGraYkceOPVYO46+UZRZYnwQMf0Kl+mgcB6eMEARIfBhB3G4iwddnLAGDNNw/W3lrbTP7P8Ss4IPrSY/wGz+kJgkQX4iaV+tKpVVbhuB0hYhplTfKmazYzMSbP/0VD7tcIYamO+lpffF1CrPdPAeVbNePPaanQD5fT2xF9H6dfY476y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(921020)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mL/ibhMw1yxdQ9SJn6qoZ79PygFoE+z4N+WEmm7lIZHTiuzag8TTk96aeY?=
 =?iso-8859-1?Q?OK61exM26L4TVnoauueuyR3D+qPd+NYFwVF2xzejHCkQRxcaBcsKAYKgXJ?=
 =?iso-8859-1?Q?zw5oT/G3dTiNajoUbW39LYP/rx6IZDLa5+3ACrfkgM2vw5RGEY0lE1HUsc?=
 =?iso-8859-1?Q?XNQFs4RWdk5Q04yQHDW+WQE4hOu/B2ln3+UG2RM52gYEUCANlm4+WK2I00?=
 =?iso-8859-1?Q?WeSgGyWtdlUgufVxzu187VnQiYl0YCikHoZykD0dWwCxk2hRt6XM21kt2r?=
 =?iso-8859-1?Q?1x2emLUJ07rHwDEs39uoUIQ0cOfk5FXYDWQrCJlPix+IpAh4ppjQ7lwB0m?=
 =?iso-8859-1?Q?0vvXLbUmCaa6YWUc9pqjZBxpnVFk3elSt2CJDStt+jKMH2PghO42JQ6Kgl?=
 =?iso-8859-1?Q?8GCAe/jWA+n8RHcfE9UgzgCTHx+97eOHh82NQbV5x4neKE+tfcfx7Gq8wO?=
 =?iso-8859-1?Q?9pLu+ex6EoAQ47zGzkCxpSxPCyLMlFxr501viXoh5P2LMz3xVnigXqgQAM?=
 =?iso-8859-1?Q?2IY4FLH4TCwgm5dE3gs1aP7L2m6qu9JlC7sV1H3L8BW/UREmVzUFqLtrTw?=
 =?iso-8859-1?Q?e9Y3Qdz7ZFAnqN3eblyK/QNksrk6xA7naCJay1gZ4vzfpqn12DKJJsiNOH?=
 =?iso-8859-1?Q?rvxEjtrYadHK7Vp5z5ToUSvlylbLM9kgpMBsxYUsY7OEBbTzNnS7kwALS+?=
 =?iso-8859-1?Q?5E/K0fvy3y3d0Xy3MZysHOi26vzoZcsTFFeQBXaU/rV8cMIxe2QbCW351L?=
 =?iso-8859-1?Q?fH1+hBGJiISnB6YbE8B2K7hqO28XPPF0gf5WHcaBkj1bG8snQe2HGWK40F?=
 =?iso-8859-1?Q?wJ7KjxYqo53T62S00wqlEd2YnxDXy9BCPZtHVWoe6BmoROt33SMHc0jj/4?=
 =?iso-8859-1?Q?tmE5EzLP6wXII7/u+4j+BVELQ0wlUJ2sjn+lELtsd0yuuHHbhBbCsTwhO5?=
 =?iso-8859-1?Q?YLAdP158wtQqdeBbCosZs2BEevKYyv47QHCyGBEb96Nr/RFmTzU0DnCEyW?=
 =?iso-8859-1?Q?geTwMwuqHLiLShKFKZxVLPmSLYDHS0I+j1Rf66teEXEUQF9XhLcvtvz5mx?=
 =?iso-8859-1?Q?NpYMR6tVnVoh6XH1rbhVSFAISYUyLjKpZkj+SY8xhRJ+6pL6dePfGxYrmF?=
 =?iso-8859-1?Q?VkIanHCAnpK7Zc/M3JNWtf4gucnasqpmgFVfhG/O9Mt5e5MsskCzJgKePs?=
 =?iso-8859-1?Q?ezGdPxwhVTVII4BXHmaie5ZHfmk7FaSdyCTVqY8CMvO5BDrAl3Gm/OSCSH?=
 =?iso-8859-1?Q?XlfjTm4L6Dt5Fu8BHylHX/htp5EN0AQIP1rbAoJR8V8mmzqwkZjgWkwhZM?=
 =?iso-8859-1?Q?FgBeq4kNdCb9LLyZPl7p+LKSiGJVKb4nYgeMiXgvWDQaUbRPs8jsaFr6Cv?=
 =?iso-8859-1?Q?YKK+DO/ydGSTuYLbO9Th0Mu+lQYnXiw0YHeqeRU2YeaCDdxbK81fS4eRcV?=
 =?iso-8859-1?Q?s89h5ur8YgT3Nrkxi0Z8PUA/svIpqReNVSlaMS9Odx4Fv9DwlqyzyyjNBC?=
 =?iso-8859-1?Q?zy8G73+tkfouu40K5c/v++FLA5Kbfh58Zf8GdF5l+nRNzfrb0KftRoBkpi?=
 =?iso-8859-1?Q?Y0CzniEiY3jqQGpBW16LHx+mVI0Bs0piFX6nWlyj2GpqR08Wi3BitgfsrC?=
 =?iso-8859-1?Q?vOM6wbAetWQWsxNrEBE/3rEo8sE6kbTPC+zaZ2dC0svv0oyL//pMvkBNLj?=
 =?iso-8859-1?Q?XaW+RbfGHItI7kGl0tEOMMWlyLOzRDngV63l0By/3DfWHUDsAtmfyOLU9T?=
 =?iso-8859-1?Q?Sm0AKGYfl1lNo0u5k1AEWzGrGEHIvZYC/3Cut3aZOCezFupUfXIJLRfsqa?=
 =?iso-8859-1?Q?UKRfptq8LA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2AyeIoSiNTi1U68t3Yb8f0fK/ppWdSmXvlE3gfvg8Xfp6UehdUkPlHRr2DSAWS1LFqkFfs57l2wUSQ6OLGQTr0/JncAOr2n39hJukgPzxtkvkw+4FgfvCks/Nzefz7tYyUe0jzYVBQf+f1TTLtL+IyKrS+oXoEZSj6dAiBPFI3yiDNdpHGMPDv/RvVNSLgjHD9y+1VNSsPVa0ipPTyHGzC5yUSFyVa5k+Wf0JYdv0MJiYXt8DK3EKOjpWpGv4iZvUCZ+ugEPSkhEaF+JruaNl32+3sWeiE/hM2oOOlDW1Rss4RUcnvq/AgqFB/KI4Pb2G0B4RrwCb01FUsLTyAxs1Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b784f-6047-4ce7-0eac-08df2a811705
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:43.5029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH4RTxpISwVs+TR3Fpw+hZdOxbJWvHk7cGIby4B2iih878N/tUt+YVPUePU72E06EB2FzwttY0o1cXb+vQIiMLlwJKLbn116S9UFalzTN6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5736
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Dependency:=0A=
=0A=
This series is based on the aspeed-next branch: =0A=
https://github.com/legoater/qemu/commits/aspeed-next=0A=
=0A=
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
Jamin Lin (14):=0A=
  hw/ssi/aspeed_smc: Fix AST2700 segment end address decoding=0A=
  hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask=0A=
  hw/block/m25p80: Rename w25q32dw to w25q33pw=0A=
  hw/block/m25p80: Add SFDP table for Winbond W25Q33PW flash=0A=
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
 hw/arm/aspeed_ast1040.c                     |  45 ++++++++=0A=
 hw/block/m25p80.c                           |   3 +-=0A=
 hw/block/m25p80_sfdp.c                      |  36 ++++++=0A=
 hw/ssi/aspeed_smc.c                         | 121 +++++++++++++++++++-=0A=
 tests/qtest/aspeed_smc-test.c               |  61 ++++++++++=0A=
 tests/functional/arm/test_aspeed_ast1040.py |  12 +-=0A=
 8 files changed, 268 insertions(+), 13 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

