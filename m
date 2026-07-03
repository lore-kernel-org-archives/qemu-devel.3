Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75931C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeL-0007Ti-8a; Fri, 03 Jul 2026 02:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeH-0007Sc-HA; Fri, 03 Jul 2026 02:45:18 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeF-0003vj-CJ; Fri, 03 Jul 2026 02:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq3VBVEx7gXrIx9wwUkcBz+3VpyQsMK2xcYtLlvfsE9GRzXHY6zPgE6jEScCUdtsgxYn8Z5wWKphned2gqLYBGT67qGBYM7BGP4euyhsX10mPPp3k/Ou+iie+c+fBynWEy5QQX3rdCAgtCoD/aKy4oShZ0087rAkbJpc/Rkp+fsgLyEJUIgTCubm9GZZWsPDfgO4IqtnbeXIgnPLrst8Pb6wVy5BCu4JXgYwBCB2fwLKtK0NI5SKIpmETQeK3BqubGLze8UDY94EDSgsYj8SGZyH++PRVm/X53rel9+7UrVu6+oi/liaMcs7hKLExz6R7cwwYOmF9Tx0Dxq8prtPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjfi7m0P7FXal9On10hvIiuWE3Fn0lAeGsXCzn7JvGw=;
 b=M16pFDdybHHBqAgCz6oZciP4XS2jLAv2JwXyE1siJgPN6ExBEImDfqDQXEGDRcXjzJrPBbZ2nqwfb/Skn06OxLgUvkZYXhSamo2dNiwMcTWOctfQLDMpniRZXmt1TgNAxMABx8RhyR6XdLvIo9aOlgzDTNf9gPmCs4resjie+hXsEg89dg67ufrJe5yYC+/qgvhNiP3UrxMs2riAr72WQmKG7MYucp371Oye2bi82BJMxsNdIdBGrERGstuBQUrm7F8TO9eYS2/yXyyFDbWl3iwYFmfNGY7auNZApKCh+C3yi4/Tk2LHY1Z0oRK9ZdWEiZ/9A6boNFjeaLXZN3PznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjfi7m0P7FXal9On10hvIiuWE3Fn0lAeGsXCzn7JvGw=;
 b=QmX3V1wAWFrY8KlOHsoXjsD/+HvUmR/tkPgROh3lUCOTx+e9CZoYNGKV8QDzCMwkBS192cPlNS52bCfFIhDqd+StWv2mMTX8oREhVMI1Y0/6wAc735zzNwSV0OyEZMq3bGGKkaBr1B4uDDxQ36c5MK/OkwFukpm3GiUkCJM9ZWjny2UW0vCOW4QGTUiyCJhmHeCgIJS8AXzMNNINiKoH32tiSXbMb+u9BjHeiLyLnmW18hCKwIRkWINfFXofbbaR6S6AuSVvI17FBkWNWRvvtHWbD1AKToWNHF/UPUNW21CxlKNtytLN9t4e5na6lSttzRA6V0npQErhlHi9/+oSGg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/5] Split miscellaneous changes from AST2700 FC series
Thread-Topic: [PATCH v1 0/5] Split miscellaneous changes from AST2700 FC series
Thread-Index: AQHdCrd8wMqGjIGr3UeNcOXWhrxpHQ==
Date: Fri, 3 Jul 2026 06:45:07 +0000
Message-ID: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: b8028490-03f9-44a4-2119-08ded8ce9ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info: SCvU7LiGTY88PLlBMdsbvIAErcAuKpnSTtouOltdYyeMMG0Ya6akWM77wuxDH7IffuSbE3CVqH1MUBt2fMjigmEBHytjk0h/9/Un3s+VnzTVyXFWVuV7FrWW+UAm656lVusBv/+RvFXbShdJBFwaKtXe3TqXEJ2zQlvPzVn9NeMP0IGEqja/7TK+SrTHnUd+Mnve99vjw8tz4i8vK+Q3Cw0bOBSU8mujXzKu66n+HFa1ZC/8kHZ5/gsAITNX8ghq7MPemlGCV77U0DQvi28MbeqtP4cijseLtKFWjjTxKTMiTgRqaNycnmHXYLC/hHK0VKUJHJ3gtf64Jg6BIkevwzuvMiWRCVCQgeD+B2sjlIFU9Kdndo97JuaSUz3CgJnGe+PyoMQE21N3ULkPADxI3niJpQPWELBZTRmErEHap2NRgb8/lRdq/YMwY2U9O7x16sqSKxfqANmi4U/7O8dnMx37Evp+YODq9Mf679CZI52lKIghS8k4kOOBU0YGIphtFV4j8Y6i9EsOI7zFPxR/+zGTklrizq2d/psPfEernTYKYNUqZF3tTdJVkUectZ9gEoLdbOKNEDvE63kZibcNHwz3YgiiKbYnLPGcSA7M6bDHY5Kkd5+bHXvOw8xzpp64rW4MO+sH0PMJ2ZgFVKo6RiBzBRuRm4LjI2ofx3AXoKzRqiMpCWn5JW5HGdtd4K4PNGv+epOfOsKa68gqGc5S1io7dZlDpqJ8Qru5x/eG8Qw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(38070700021)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t2YR61ras1N8qfscUiPMmh0Qirzse0rG8PSKGYpMvG7haDAEhVuDZkiO8e?=
 =?iso-8859-1?Q?uFu03wJutq8OGGm50w/Kluv6RfwRgn87/bEDb/8UbWzxlAAiR/d0d4f7pu?=
 =?iso-8859-1?Q?XcUXDe/QGb+Yg3FowSYeZM3i3FktwQCnEW2Gd9TNxqg2bfybsGlzah7fGK?=
 =?iso-8859-1?Q?43LKGyidkq5SgkJXpClsYUJTbk3t/62lKuUMm0Mwn0qQLPxw6xDHzSB1jz?=
 =?iso-8859-1?Q?9Z73Oq7Cyki46tOCVtupKpsTNHozG/yGn5ovAeVVAheAxIxXkfUvHFdbTO?=
 =?iso-8859-1?Q?vCTm0M+o7k98N6jMDtpovTAUf3Vgb9gMTdgld8V/d57vo8rZ/DvmmaPAMw?=
 =?iso-8859-1?Q?rwq5V60kAdc+ymeWS4k87006ecmwaXE2DGb3yvpURGRxQAQNQfPZl2xVQ2?=
 =?iso-8859-1?Q?ehLZoiVlZDI43CoTJ9ebRHMGaS8CrM8klmKUyS/3h0kKBL+W6NkIXMmqUT?=
 =?iso-8859-1?Q?EMMXj7lZ5u8ZRemLswGWa/kd5HEDig6Bfp9d1B08eT+9lfx8PC+p9Ejfch?=
 =?iso-8859-1?Q?6Zj4MupBJMN88lkxlAe7K0e3W96nBBl84Pfseae29xlsI5yhubiiqiAoXv?=
 =?iso-8859-1?Q?B7hh77e9RxnVzl91w9JWttOFKKuxL/ZcXY1Q94ajasF+JBvgiYGrQpOaGM?=
 =?iso-8859-1?Q?W2nqiWISzYPCKSqeWlqpPp1t3Tv98uiWAeIZknB0ncwApvNPB6PEQ+5G9k?=
 =?iso-8859-1?Q?Ol01l/gSEFTa4BPvyNaMn7c5oqWSIHvOyrTAnQXWmmUtkH93CKONTXCR5m?=
 =?iso-8859-1?Q?HeoFzKe2wJRogiBIoCnz4EFV/FDabAQdSTA62kQ8z1XQ48/q1SWcDUroaZ?=
 =?iso-8859-1?Q?8vmUNEp02Vpd++iRI5uF++kLXcxjzFzr7tCxPUNh+D63iV9hGHAxBO0Zbt?=
 =?iso-8859-1?Q?srWrH14js9lQS8zcjsEE4YgnJS/toI/iH6ct2bFmZt0bNNDoJLy1UVjVLq?=
 =?iso-8859-1?Q?U6r13QsEgs9AGm738iIqbR3/rG2xsEcNtkw6t85aOmLVPJKXyXfx0L6YBO?=
 =?iso-8859-1?Q?4fuDAIQc37a6PLFMk2t6GIG/YUefi2iDVA7aE0k6LxwTbPdBMGNvYrBlh1?=
 =?iso-8859-1?Q?NgOhXtqm4cGSLN2O3AYZN+GeVW8vX9DOHSN/AMw8zdx0EyFN6SL4t75ZPy?=
 =?iso-8859-1?Q?trV9Mf5JnABEBvjaiEpu6+AweY2gkDG9EVyW36dievoTUQikymSGT2Uld2?=
 =?iso-8859-1?Q?a7DcQYc+o/tLJ+mZrRqMv82d5BoRZZP6Fy3THC+/vOehTGMgX5YG892EfW?=
 =?iso-8859-1?Q?lytakdRC8ZwtpfqeoubhHyerJrWsCrmWwXU3O/YBVVh0Q9oApNDd+qCDR+?=
 =?iso-8859-1?Q?9LoyYJsqyzqhPrTa7BCKwBdtM+yZuOeyDi5ZwoxQTJp3lq0HnP1Q6HO+WD?=
 =?iso-8859-1?Q?9l/JYCYIIaLSg1pnLx84dlH2L2o1TsVX7vyzx8/PdNHUXnLBdUJS96Rham?=
 =?iso-8859-1?Q?Idfc7MeIJrNfRyp6s/7KbUMR0MOmSN3/pw/9EpUYPaqR4rQzhrywWCy0uv?=
 =?iso-8859-1?Q?gZC8EW4hHfH4uHl9e7jVglAuwHDM7Pjgop+89cLXdPCvtDIdV89SFOtEp2?=
 =?iso-8859-1?Q?vJwe07rqiq3d3eZ2aZ5vgo4aQeXq8IGqsJwLuBbtk4CYH9sGFwKzNzZGNP?=
 =?iso-8859-1?Q?dilks1pzzsJfFW5sEUeTdykrNcPoyCtxW322lZ6nv5ydeEoOqt9T28ANhD?=
 =?iso-8859-1?Q?bZcv2mOeH/TrPfdz4kB9ZzSrsunFOgp3uTkQF90R+qc4ThsDLWW6cZURJr?=
 =?iso-8859-1?Q?dv96eC38tw/lSex1WgIdSA69NwxPbw0B3wuxOCG8Ao0M1883NMWQQ/GTj7?=
 =?iso-8859-1?Q?+RguAIv3Cw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rtyZuXirXbSQ5zZBlXBVqAYiiAD46YqwuhI6LFAZUKVuKuFdbljuR+tD9HS/Es6d+mtwvbTzV10nnHW3QRju0FPaN5mO7+LFhsYGs0VxlvbQz/VdXufQJtY3S5XF9tK9/8enzv4bfRvr4cWIItoUqxvEK9p79O35rBhplKsGBaOancWILZC9Bmad3PZS306OULRCw11GHHb12//wNraPMGICbiWgOV1hKE4Iks7ZgHvUDNZQ1IabVJjKUg6auMSAM64VDqYDnLf7NNrLUR5HWSlg68mV0hZnrux9Rliofei0Dpi/9mYk1tgh+cZNDJJWWwyDS4JYX0FVVdXwDO+a1A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8028490-03f9-44a4-2119-08ded8ce9ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:07.3697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kIY+fqJMxod/tpR0ML3AA/1GFQXXVeZV0Jp4AEzkL4Fe5M46kH5TIECa6uBN2gpR6melwV0waTrVOdfkcdP/I0CxIe1NlV2DSOrTKTba/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

The original series contains both the AST2700 FC support and several unrela=
ted=0A=
cleanups and preparatory changes. Since these changes are independent of th=
e=0A=
FC functionality, they are moved into a separate series so they can be revi=
ewed=0A=
and merged independently.=0A=
=0A=
This series includes:=0A=
=0A=
Fix the AST2700 FC hardware strap configuration.=0A=
Suppress noisy unhandled register read messages for the AST2700 SCU/SCUIO.=
=0A=
Add the AST2700 SCUIO RNG control and data registers.=0A=
Add unimplemented Privilege Controller MMIO regions for the SSP/TSP.=0A=
Add unimplemented OTP controller MMIO regions for the SSP/TSP.=0A=
=0A=
The original AST2700 FC series can be found here:=0A=
=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Jamin Lin (5):=0A=
  hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings=0A=
  hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700=0A=
    SCU/SCUIO=0A=
  hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO=0A=
    regions for SSP/TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions=0A=
    for SSP/TSP=0A=
=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 include/hw/arm/aspeed_soc.h         |  3 +++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  6 ++++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++++=0A=
 hw/misc/aspeed_scu.c                | 33 +++++++++++++++++++----------=0A=
 6 files changed, 69 insertions(+), 13 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

