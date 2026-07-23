Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F70C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj5m-00056L-Nk; Wed, 22 Jul 2026 22:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5d-00055I-S4; Wed, 22 Jul 2026 22:23:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5b-0002ZN-F4; Wed, 22 Jul 2026 22:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzre/lpDM++L132hqKrVHplzkncq002tE1woMVol1z1LJNm/Cnw2yKM6K2znL8nAlO4KTQaHct8wb7WJBhapFdgZi8te9DwMOCmciW0FhjrAASj0S4rLvcowhpssTj8zeJIrrc2bA3Cducq0d7CQBKxytG2i9Pb5sfODYIiNR+ubSZLLIpA4l5SdCudiyMhiw8rcUs625lqE72nm5pXFWSM00TFU7fKamRj7FArk7mutvuHv/8Lq/qHEKlVZwku3eFCk1vv1wTIIc/kMgzghcnV+bcv7YuzMia7icEdTUYiXi2pFi5wd+Ku5OI2V+XVQRR2nFjzKCU0xr2K+2XiVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5ymyBlr+bzBJ78pBuJxTYdY+seMPv1XtBxTK59C/UQ=;
 b=Epddt5kuqBcPrJa5Pl6ugv47Lz7GQ5mGJ1N5IdHmJwKPW9YRuwE8Y93ZRElSUYOGi+HcCRNr28pzA0cAwuEj0SsJdU4x7dWiJdWUcPvTixhuWthFMcC9Sru6neKDTOPkYFj5aFSGpYuWWIi+66qX8BpbZB2RwpMAOqQgSS2RH5GnxCLsZZqa5rGzXyinGrh3RYN3s0C7mxNOnSScsrpZJwTMxQrzCHLt/t3Bg0B6YJJOXAyqOGImToCLLUBg1R67x6cK90AztnHLwzsSiE2Xhny/MYTY6YgJgKFV4+cesG3I/gpYlD9JDxJTO+2Ax6mVMGVhDjI3US0UTHZwbb4PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5ymyBlr+bzBJ78pBuJxTYdY+seMPv1XtBxTK59C/UQ=;
 b=mGOC8FlyxsBX6drf1klobiq7GADjNAEy71zL1+b/OTeuXanTAEtP4T2PSDkwSvToZgQwBQrrqF6CUgQVg2FDfA1k84t5UMUIyzFN4Of75TdAI+ykxccbTjGKEE8jebMNy0D6DLeVktMg+4zQ9LNmKPfWR6zkK2BFOlfxWaPHynRT/q0FdQfrlx/AHjyuvc/gcLUkgWJu0xzTNB0DTy6k3Rs03Ga/2+bExE4SCTf1Lo4dENMHUzM6wIwEQDqHXD+XJLys+4YgcuZ/idCVq1N/ItCtPVMsQpI8pzJ0f7FxfNdUrEnMn1JXqkCilPH4J1v/WGbqOcDjxQr3lkcIoHQ8aQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 00/11] Add SSP/TSP power control and DRAM remap support for
 AST2700
Thread-Topic: [PATCH v6 00/11] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdGkovqvcI1ghO+kie2du+p0VjDQ==
Date: Thu, 23 Jul 2026 02:23:00 +0000
Message-ID: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: b488a9b0-8ec3-4763-f90e-08dee8615198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: 2JR70P1YiBjKecQGKuKM1HqzD3p6WYhCbrAFsUAWZnIiOByl6aD19OPJ57chNj3N8bLwv3jPsjn6b5J4oVal6PGhS4l74mGAoTN0PeBo3oIfqp3sd5nuEzudYxNZ6gcxmxYptCYDJcV0PSj7fqnXWWhrkXFAFcg2ioDPDdEsQTQz5UKlvSGFSqvTOtSmS/fOwhKBaxZDFFHL4Jx6HKirxyL6/EGPmDLmw47aFu2qaLnGhcz5fM9hO8c30L5Fud/aBqHXyeBxXuwopgT6U6vk+vVSPwTe+VXMvQtPfDj1IdW64bdxz9AvgiH50hdib7dEtc4LJeWW0qLKrXBkybBzOkIPWkoJWSQmiFbWC3bMnFO0facxAF/7q7c7IbZPeTekr4Gs2w5Md1xfj4DcJfWnacnjSM/Dapdy/9L20ia5/RurfADaTaIkm2P2ncATgB+y3jB5Z68EcdqhuPMhUKnjyS13YL58RWO+XRRftErby+T0wY73+f1autlhHTMmIUYazD9MJwiMFoPMwtkCY86z+oxF5uJyEO/5BDYqW/xOpfbH0jj1X2MY7O6sb5FI+tLLodQBGiApLbFzkcTai1iBjKQANUU8WPgo/4hT/J0R761pAWZPUF8uJLVGh1uDSz/I8Tc053Bo5IQOlhsWTLotJUZiNqEJpmcafLeHoLvxkJhc0yy04svLibmKfHO+Z+G7BMbQZXETsKN6wrjOqEMGlXTclP80EnffTQz7PQWDOWCBQcGrR4Yrotr6PCsIRmds
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AKSW2s1huZfQeh4D1/0AMtT84ouWQjG+kA71XRpmjUvoYlIqoI2liC3GEj?=
 =?iso-8859-1?Q?q5RUs+yMp5v5a+5J6gZL/pUim5Ynp+jPzWwO4OQ31VnVnEiH51UFiEYd2a?=
 =?iso-8859-1?Q?w3u+mkRnIlW1NpESs1Vyk536nIR5JDthH2jvba3D9P3lxVoWDSuJzGslfJ?=
 =?iso-8859-1?Q?ptm/sZZz44nTgkL34FcUvc2VN7d7WIrIJpQ9uYksltfhfETCmF3EGnnshn?=
 =?iso-8859-1?Q?3/ZPUpiSRPU1rUVl9XAQoWl8VqmPez/T+SYM9x1CVD5tJdtjUzjWIOwNJS?=
 =?iso-8859-1?Q?8KDuHT2E8hPjlluSUtPx9mbqJ8yJpyCzd0UIysTZEN27dKHOrNW+26Ezv/?=
 =?iso-8859-1?Q?YYsvdlwOcWDYRqvay6CzE55a5gZHFEhZx6lLzG1XVPnfkl4x2spZ3Yr6A8?=
 =?iso-8859-1?Q?P9XGpZIcEpbrDvojM8ciptqDTD6soHHJlc7SdSeXztQSei5zMhYiobrHm+?=
 =?iso-8859-1?Q?rB4yaGhqHebCfl/XfhY4HaEUeCTnnSH+mRWPaH1Zp0ywJWDAQxbyTMS40w?=
 =?iso-8859-1?Q?P+tUPychuJIq4wnTOlcsCjxFjATk0ixqYbd+eRJd8agrBuWAFS0SI9Kmth?=
 =?iso-8859-1?Q?e9Xk7cNqOKXRSFdSpFdPLKI5SjAtU29X5FqHblYJ8xT1RC6PS8/BJNLqBl?=
 =?iso-8859-1?Q?HOfD5/5Ttv38uqBc5GouTRXd5oQoGQFFRQsYb6t9HESA/RgbNT+iB1dEbY?=
 =?iso-8859-1?Q?8FwxJoJ+SeCrhu+/J9BVdf15P9vN8w8UDkMsCykez3FzUO8PItiSvM8Isp?=
 =?iso-8859-1?Q?ZtRtJ2hv2o99x5B9MXiHFNSSGANHAWKD1stVzR0S/LWwyc3xTh21Llmyl4?=
 =?iso-8859-1?Q?NuaRkLYO37jT7ETBl5Us5aSEhCSLIWklFta4oW9q8NeevervbTftil00Xq?=
 =?iso-8859-1?Q?YNW0fWDBD8yDrS1/6uOp3+iy6ll0nBfKAI9O+8yhyYsz85L9qF8VLdE/QY?=
 =?iso-8859-1?Q?WFZNOWQKt74wbSJPchKixL1kM10pKwBjcQd4HSOEK7ffO8FxYlyVQIDn2v?=
 =?iso-8859-1?Q?HwnCWN7N19UBCZl895daYWLQsjEsjrkNlA5Mu3NiQdzO3l/kMU9dU2kQWT?=
 =?iso-8859-1?Q?0Tl4VWeirp/tFaH0Sv9sDWYEFDciYsscmvMpmhXurIyn5MqDUvWl1pJAjT?=
 =?iso-8859-1?Q?hw9wvmopVudfsljg6JIC5cgnwGnId6W4gdcyR6HZLEMgwP2jGmohml0uda?=
 =?iso-8859-1?Q?ig9z/mSn1iG+VymDLQeHJ181HvhfSKdnQFOkvt5/a2fM7z+K90imGjX3Y9?=
 =?iso-8859-1?Q?DdN7LCNfG868vrUp2KiFetCCakcoR+orIIW0siYAvrScrEqZuOtxdGOrlU?=
 =?iso-8859-1?Q?cllBryZxf5JfZnjpkaaXNUfQW9t/h2KGHO2i8RpNJN5CG7xKwfwcdSYspr?=
 =?iso-8859-1?Q?x+n/LS2dMfmOgsu8oC2QPcje8qrGuYAc0BGk2y/Uz2yZ5fyAoYKF/O9bbB?=
 =?iso-8859-1?Q?/+6QRsx5OUNCOQ9CLU4GK9iFanLfLOpJVSxZmZ/n3hYaAuW9Sb08Q+R8v0?=
 =?iso-8859-1?Q?ifFCUSCFcVNBAqytQgQyaYURTQMFDuwhLXEh0dsJ0HVbf9/9lsRr9T9ZHs?=
 =?iso-8859-1?Q?DmASkZACovU8tTtjK66/KWrUfBJ/HFHAS+Qq/ZRNt9yvwdBjhQyGpPRTFB?=
 =?iso-8859-1?Q?PYWl5gvgmOah+rXAXC8yMOZ15TGjjObmNKt+rv0rf01HxLk1u7FH4XTE7x?=
 =?iso-8859-1?Q?43g3xttbkr7q+X6g6n19s29GI6Fd9e/A5yEIDqB5zP6VcbVui6r7lhl/So?=
 =?iso-8859-1?Q?AgYSXpeCIYsIdpBs43zRex7p29RC9MOEUzXoqVdmlkdG8ycUyXd8DneyZ6?=
 =?iso-8859-1?Q?VxXcDizBmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K584uDBl2AVbEqqq7BuQfuVKVjSC3thbbTmcvXb5L5iBMIKFG7b2Ia3wp6zOArKLlpYauHSmnqgTxCbCAtZohAwUpFJ5gPnwekZQXds/UrOJ5jdgnW+kToQClJ0CsQ93bOFEe2uen6Yz9bReIED80Wsv560lAYVveKPy2sZqQyH2kSNuy0jZU7URq3nZL2iOb2sN6QwIg2+8gN5tZUHybwaLgb+LVxC84NoK02XG7VwTPZyXSc25TLTzAsIEf24bin+nkE9tjhby+EVWvW7nV4s2ODnA9Jk0yvz6ynOL7K0ctNgGKsTjLRTu7ehBn0IXT16p3VXD1E6tC2H7HXCUbQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b488a9b0-8ec3-4763-f90e-08dee8615198
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:01.1024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70WknWkmeIE7i3CmqRGYDBpMDdADTKPwqjESB4GcYo/bqsE99t6ZcqhU/PD+nV39PB0YOmDYLL4U2aaEwT5vfKmuKj9hgcm7vbCw9LvYork=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This series improves AST2700 platform support by aligning SSP/TSP=0A=
power and reset behavior with hardware, and enabling DRAM remapping=0A=
required for proper firmware boot flow.=0A=
=0A=
This series depends on:=0A=
[v4,0/9] Refactor AST2700 SCU preparation for coprocessors=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260717084559.347706=
1-1-jamin_lin@aspeedtech.com/=0A=
=0A=
v1:=0A=
  1. The changes move DRAM/SDMC initialization earlier to support memory=0A=
aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement=0A=
SSP/TSP reset, power-on, and remap controls via SCU registers.=0A=
  2. With these updates, SSP and TSP can be booted via PSP and load their=
=0A=
binaries from DRAM. Functional tests and documentation are updated=0A=
accordingly.=0A=
=0A=
v2:=0A=
  Fix "make check" failure caused by both AST2700 and AST1700 realizing the=
 same=0A=
  TYPE_AST2700_SCU model.=0A=
  =0A=
v3:=0A=
 1. Drop "Move DRAM and SDMC initialization earlier to support memory alias=
ing"=0A=
 2. Support SPI/FMC FIFO Mode=0A=
 3. Add unimplemented devices=0A=
=0A=
v4:=0A=
 1. Introduce Aspeed2700SCU subclass and separate from generic SCU.=0A=
 2. Add separate reset handler for AST2700 SCUIO=0A=
 3. Add AST2700 SCUIO RNG control and data registers=0A=
 4. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 5. Fix AST2700 FC hardware strap settings=0A=
=0A=
v5:=0A=
 1. To speed up the review process, move the following patches into a separ=
ate =0A=
    patch series, as they are not directly related to the main topic of thi=
s series:=0A=
 =0A=
    [v4,01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and sep=
arate from generic SCU=0A=
    [v4,02/21] hw/misc/aspeed_scu: Add separate reset handler for AST2700 S=
CUIO=0A=
    [v4,11/21] hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
    [v4,12/21] hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controlle=
r MMIO regions for SSP/TSP (Merged)=0A=
    [v4,13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO=
 regions for SSP/TSP (Merged)=0A=
    [v4,14/21] hw/block/m25p80: Implement volatile status register write en=
able for Winbond=0A=
    [v4,15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash access support =
for AST2700=0A=
    [v4,16/21] hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST27=
00 SCU/SCUIO (Merged)=0A=
    [v4,17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data r=
egisters (Merged)=0A=
    [v4,18/21] hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP,=
 and TSP=0A=
    [v4,19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings (Merge=
d)=0A=
    =0A=
  2. Add memory_region_transaction_begin() and memory_region_transaction_co=
mmit()=0A=
     to protect the transaction.=0A=
=0A=
v6:=0A=
  1. Move the DRAM remap MemoryRegions from the SCU to the SSP/TSP=0A=
     coprocessor state itself.=0A=
  2. Set ssp_cpuid/tsp_cpuid directly once the SSP/TSP's armv7m core is=0A=
     realized, instead of pre-guessing them from board code via a QOM=0A=
     property.=0A=
  3. Correct AST2700 SCU to SCUIO to AST1700=0A=
=0A=
Jamin Lin (11):=0A=
  hw/arm/aspeed_ast1700: Correct AST2700 SCU to SCUIO=0A=
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap=0A=
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP=0A=
    and load binaries from DRAM=0A=
  docs: Add support vbootrom and update Manual boot for ast2700fc=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  42 ++-=0A=
 include/hw/arm/aspeed_ast1700.h               |   2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h           |   2 +=0A=
 include/hw/misc/aspeed_scu.h                  |   5 +=0A=
 hw/arm/aspeed_ast1700.c                       |  22 +-=0A=
 hw/arm/aspeed_ast27x0-fc.c                    |   4 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   |  45 ++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   |  37 +++=0A=
 hw/misc/aspeed_scu.c                          | 240 ++++++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  29 ++-=0A=
 10 files changed, 396 insertions(+), 32 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

