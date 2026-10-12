Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD4CA9EDA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mO-0001iw-W0; Mon, 12 Oct 2026 02:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mK-0001iU-Bi; Mon, 12 Oct 2026 02:44:56 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mI-0006M1-9h; Mon, 12 Oct 2026 02:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt7tlEYfybBhsLmUwXSDnJwpzqNne0L1lCTmYpVgAuCcGl6PQtBo86pmF8vj4PPO1VgNfaXjmYIOkTJFzT0ijBJcEaagXiPChWR/zbvLmJD08f5pDVP5RuuCpQ80Wypum9pywMbweonkHziuwa0GKpieAGhRRKnv3vRRUDI1bnujfc4X6eUqBI/y4tnF5S6Ug2OMhZBDO17mrPf/OfUQREPNqw54Wybv91Mzf9eMQ3BOLZMGPVOBv7dTtS00aXl3U2uQdL42PCRnGwk8V2jchRNW23f07Oh/1Ema4Bg+cRGL9ofHMmlyOq19e06ZMfQKt2OUYE8Gw8O4yZGxqb3gEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHQcjjIFsKLs+Vev4ri8qrPxCMe5G9Yf12M5FybPQD8=;
 b=hJ5o/Lj4/259qjM8s5zHKQLbCKxsH7/J/NA7KCT6xnOleB3wowAc+NzNxTfk2I3X7Q7M0wb+HcIErLccYoIX1FOJ53i1zVbcUxICRWOQCO/glpzb7lf5hpx51jleJa/v2uDjBklgMr4PxGOJPKSLck1VaW+Dc7/MfVtxp1DNT4kp7HsTF3eqPVpncVBPXX+Yd2e/Y604C3ylNr6qvzaTuDoPvj4f99OKGAVVOaz7QnCbOLQWHGkD6AAqMvofAMDJFhBT2sUCSq4ZAW15V0czFdSOJDuib4QsOauHP1rP17J/7RU1wXPIBVjPAcvKRnt4tEPTzivjq7Wj8oCnqTiyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHQcjjIFsKLs+Vev4ri8qrPxCMe5G9Yf12M5FybPQD8=;
 b=NtR7137DuL3JZCt6Jjt6oNXR81fH4VrbpRR5qwV6SGaTQge1tMyAGwrIN/pNzuBZWFW/R9cYLuY+/NPG5UAGcOOB261dmzpk/O7RIyy8HuHCB5aMzPjbEYOtMVOUtZxQLhUisc05ZvuF855EUFvrewoMYNLvQV7RNImdUcUu15AV3IVQZcpzH0XGe/eOYcbsUQVnFoo1Du5Rbg3uyiOZ80G+AA36EX4IxDkYHZTL5Tny+jDjZRxR1VRjmfJKe+9YM2sk4GAIEV89Xjx4T8S63pXQ0i6IBqVPjcDix43zHEylzh2b9lyRhoagT3BX+9ef6DA7FdjHRD6orGUlVF4U+A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI3PR06MB8707.apcprd06.prod.outlook.com (2603:1096:4:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:46 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/12] hw/arm/aspeed: Use a table for unimplemented devices
Thread-Topic: [PATCH v2 00/12] hw/arm/aspeed: Use a table for unimplemented
 devices
Thread-Index: AQHdWhUrrD+J4XRe+EaNz4FMQh3dwA==
Date: Mon, 12 Oct 2026 06:44:45 +0000
Message-ID: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI3PR06MB8707:EE_
x-ms-office365-filtering-correlation-id: 7f0054ee-8bd5-4b39-ef98-08df282c4dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|921020|38070700021|261009223027099003|261009221227099003|56012099006;
x-microsoft-antispam-message-info: 9OgIPvZd6WA+3AAHI84cBbedzYgbYv9eQ7RnQit4uMM82JXOI8tyD+Sw+anqHvfO5re4HjOtnQqzDKulBz4LnUcV07xOSqIbt22djp2ySiVbK7V2O6HxtcaNRhE5PtMj0kcX/2Fd05mH8qHxrjxOg1Je7y0O1KzmdF1vEp0bVp32lccuNUeiKHmdvI2CuyN1kxt3uO1gILJx1vxqknXENbXveXzAJQUzT3onX1UrmzbFzpIxfXc00PnTa3wd6LbwxCV+vFogqdT8DpBlqW66E7MXawOxzko+Y52L9/RwSljgWso2xS4WK4uO86F56luT5SZSmqZQrjxKm5tgBaLe0jsvLbpjV/zBdNMdxpOPdmiknOxAkCUBiLcR/7HQHhHoqU4HDLTLT76wk0IHhwZ77JOwBcJdPig6eZ9CV5JwJVujn5x7RhvdmENDFn3J63DJFrPVQQCab8lhtUSJsQ1/ig3rQ6FtdMX/jpRKbgqRAmeoarfUzTU0W8hJqVUEgT5LKuQMyG5Q8cKKZXOriQ3oriuCzYkFeiE9K+1UCpLna3hJi24b2ZoZ+iSq7itZMyI6z/jFvEmGfhvxHa+CT/+aKMUdWJ2CGqVNe1Cav17v2JPzcSX2RgSvFNWk5L2Z4DlouYarjCjV0q84dFI9HyeTMn36YONvpSWRpidV5gz3yj4+sMOt8Gq3KGqHqHacN4gxMNPJ/9oplDUPE6HmJbsVYhQRXJbGqe3nVKcwucQvnafxij9VIycaTp4c5y44aeNs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(921020)(38070700021)(261009223027099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bSyiBM3xe0wJjz5m5jYlz0kj/U6y7ZIXa9D8UnVbhhLmk/f/njLDrS6W44?=
 =?iso-8859-1?Q?g61cgknsxZ6N/N8fAu3sIFdZJi2Wasx73FVdxvNGmf3RH8YoPgQPH9tBcI?=
 =?iso-8859-1?Q?12Tg4jOS03oImg+wXPSLk5qwcTM0I2F/U5tuoMgeXlSBCHQdVkviZSOceW?=
 =?iso-8859-1?Q?wjGlF7TjWEaaqvUNzPFaGUlEI/mDgkpBJDs/QNe1sgH4edYKJZY2US/n0t?=
 =?iso-8859-1?Q?Kpbg5oWangPoHXxiRK/VAjbuSflSpdOYjaS4NQeJ7qZfB7/CARWdl2HrDl?=
 =?iso-8859-1?Q?6RVyFF81sDCYJcdyd22UdfI+0EaX6h17ljta+Jn8CmAw9mvuAfo/9GzLX0?=
 =?iso-8859-1?Q?kE5wUyLPkljHlmmNLEC2mUuV+rOwuSh12K7vweYfjcOh/N/phA8bya2p2S?=
 =?iso-8859-1?Q?DVdNke/bQPGiwMiE5CmDp4EXZLeFQhGO+1MN1/rHnVIWTmCKcxKan1W2G2?=
 =?iso-8859-1?Q?2es7VHM0LMyLxqJk+kWSlfBn2MjZsnT+ZVSfFDE/HE481BzchEkU7x6EED?=
 =?iso-8859-1?Q?eEQVrzmLI1pWu7dvXhh+AtYfJzDtMnI3asmyjb0DUrFIRhAgrSjPxSYEzl?=
 =?iso-8859-1?Q?81CkGjPHBMPdFES+teJdOdnnEuAhwAntnzZkTriHp3KM9qSSh6ExoUDXsU?=
 =?iso-8859-1?Q?H3j+YYOL3kTL1iOSvmmHOjqyQptNdtMaPN0MB0jy6iE2QHlXJRtYbNF+cx?=
 =?iso-8859-1?Q?xkoOoZ89iW5ZVVDuWRDycdpRpbT2EnXn5IcVDV4+EbVzd5zQpRO3wJIy2Z?=
 =?iso-8859-1?Q?g4jYISdDAInIR9X/Gp0nDlwVrASnZGT9+PpEU3M9X28f1YR1aXW8QCUd9h?=
 =?iso-8859-1?Q?K5uXiu9QzKjrIHDD7kB3pYAqWor3nr3gGTwij36r1+f21sQtPspRA9vxr4?=
 =?iso-8859-1?Q?GjnwtLvGAT80Au0EG2iVijAF8A4dnUz3acTav2NHfQaYSOcEGjPQkRB/jS?=
 =?iso-8859-1?Q?+FykHvPWkfRfBDbpWLWKgjU5bufS3/sYtiBMMRYhkDGMg1qsvlLPzEDTH7?=
 =?iso-8859-1?Q?JXlsnSy2+dfBJNxyQhhSCDScto+n2bCGOqrI7z/V0uf57aBTdMmNWq8jrp?=
 =?iso-8859-1?Q?D9kX8WNE/7R000qMOWI1k6lwliUchh6uBkv4+1b0ljCCkh8odC9F2yi5yf?=
 =?iso-8859-1?Q?DlZ8SSJH0hKw1hiLUbeRjUix9pKZ65ZHd92Od1uu21GCHtF+t9z3n5e9z4?=
 =?iso-8859-1?Q?8zpcCCb85hhFUQUjqaqtqEqgsTxVLnEvdItU4rtHKG22F2V0u1zZMgXdQD?=
 =?iso-8859-1?Q?CzMJ1s+6za5U7zcDe/nqTqXtmraO7CU5fJy0ysSau/MGye8sMqnmRV+D7p?=
 =?iso-8859-1?Q?G27FXC/xmWLH5xeG2bZ2VU8GiTQ35qq7VULUii5XPyvzd9OEBSgzeFcheM?=
 =?iso-8859-1?Q?rv4Ev87zX35dLFHg4VvQxXJk2shoXyYPgkxkUI+OZ3MIYW3KkfDIiKiGP/?=
 =?iso-8859-1?Q?NFtvNknSEM9QQ62WJjaMPRNfayrlsMYxIYF3IIVtXc29F4Q2oexmUAwkY1?=
 =?iso-8859-1?Q?qKu6kjRNFDmevYyU+gM+q1rHsqBVb7XbXgmhS9CbbJxaRLMoMo24NftyzY?=
 =?iso-8859-1?Q?MeU88Cgn7klZx4TkbGYByetSxGLaA3PvJvVdgQApgKLwMW/rJmAGZaB5gp?=
 =?iso-8859-1?Q?qXBCvlxH4X9Hkb+XLAGlK3nu5cuXhyzoz315Mq2vi7PuHFsHR0QOXKpUmw?=
 =?iso-8859-1?Q?ObbBUWqnvKS1O0sutrdBxnDldI4noR1I1pr6lN/xEbMDeEVTqifsQ0MqgL?=
 =?iso-8859-1?Q?2+n7lfHXa8Wqc+/xyp/AuCOZ1wDSshrshZ1q1a6fIoHlUT0BprLVnpd+HP?=
 =?iso-8859-1?Q?18kFdh4Q9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bQP1EPMNL1hb9A/d5frrO8mT4CswYu+Bd3vrkruQmDSGFhRdCQTLKCBZ9A8PpRXl5zEi0XSCKRefx+jObQR6jPMYvfuWk2VrkqUEqL5nyFplLtZ+jPKxkjvWzcIAL09dXLHv4cXBdiE/lqiPtoly9Hon9GJ3tqXFYHP/2ywnJaznu8xLB0eEHUzM4vhlsrMDctS8RfjN16DIGZK8qcWwNz0n8p6auZ87Kt+YKQItSKqb5m8+ylVcWvh5DoLkcwYpLW4QGDJN+hpZ9XSconsjeXjiS39UwA/kiMIQ0wBw3h8eEfQ7Q1M7LZI0pGhdVHsJ9w5UHqnd6XySt9M4vulbgw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0054ee-8bd5-4b39-ef98-08df282c4dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:45.9300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3yYSSNMwjlnTVpTUqFdVe1GAvnmbCd7pk/1V1zDVG+9TrVFi2rcr5omZqnsbksoL8v//gEiRhZhn5+j0pDCuRiQFnUugcTlwhNe8ByAaao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8707
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

v1:=0A=
 1. Use unimp array and table for unimplemented devices=0A=
 2. Sort device IDs alphabetically=0A=
=0A=
v2:=0A=
 1. Add a common create_unimplemented_devices() helper and=0A=
    UnimplementedDeviceConfig in hw/misc/unimp, as suggested by Philippe.=
=0A=
 2. Define the unimplemented device table at the SoC class level=0A=
 3. Drop the "unimp" array and the AspeedUnimpDevice table.=0A=
 4. Remove aspeed_mmio_map_unimplemented(), which is not used anymore.=0A=
 =0A=
Jamin Lin (12):=0A=
  hw/misc/unimp: Add create_unimplemented_devices() helper=0A=
  hw/arm/aspeed_ast2400: Use a table for unimplemented devices=0A=
  hw/arm/aspeed_ast2600: Use a table for unimplemented devices=0A=
  hw/arm/aspeed_ast27x0: Use a table for unimplemented devices=0A=
  hw/arm/aspeed_ast10x0: Use a table for unimplemented devices=0A=
  hw/arm/aspeed_ast1040: Use a table for unimplemented devices=0A=
  hw/arm/aspeed: Remove unused unimplemented device fields=0A=
  hw/arm/aspeed_ast27x0: Use a table for unimplemented devices for=0A=
    SSP/TSP=0A=
  hw/arm/aspeed_coprocessor: Remove unused unimplemented device fields=0A=
  hw/arm/aspeed_ast1700: Use a table for unimplemented devices=0A=
  hw/arm/aspeed_ast1700: Remove unused unimplemented device field=0A=
  hw/arm/aspeed: Remove unused aspeed_mmio_map_unimplemented()=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |  2 --=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +--=0A=
 include/hw/arm/aspeed_soc.h         | 14 +-------=0A=
 include/hw/misc/unimp.h             | 21 +++++++++++=0A=
 hw/arm/aspeed_ast1040.c             | 40 +++++++--------------=0A=
 hw/arm/aspeed_ast10x0.c             | 55 ++++++++---------------------=0A=
 hw/arm/aspeed_ast1700.c             | 21 +++++------=0A=
 hw/arm/aspeed_ast2400.c             | 25 ++++++-------=0A=
 hw/arm/aspeed_ast2600.c             | 44 +++++++----------------=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 44 +++++++----------------=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 44 +++++++----------------=0A=
 hw/arm/aspeed_ast27x0.c             | 41 +++++++--------------=0A=
 hw/arm/aspeed_soc_common.c          | 11 ------=0A=
 hw/misc/unimp.c                     | 20 +++++++++++=0A=
 14 files changed, 138 insertions(+), 249 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

