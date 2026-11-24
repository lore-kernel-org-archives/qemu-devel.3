Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E2606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BreKejRS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjV9-0003vr-Cx; Tue, 24 Nov 2026 00:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUp-0003rl-P5; Tue, 24 Nov 2026 00:55:15 -0500
Received: from mail-japaneastazon11023076.outbound.protection.outlook.com
 ([52.101.127.76] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUg-000181-Vs; Tue, 24 Nov 2026 00:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twYCgKvsOPufF3BuISvWTY+EShfKtWY0UIMtxIvbE89dXFrkjClfuaeujGvMt/o67MwyGfq9gJshol5uKnZa12/EGN4X5DFjd6Fzf+9ToggIx+dJzcv+AuOUzM1U2/QfmbeKNTWtpn22X3nWEO8DZCa+vbpM+5ArVdoZNEBJI5uCt0a5ZC5EHPjksHyXDIXJknWhlWPFnGiSlQ5wkJL7pesI/erGadYhRg4JTp81xSggY85bgXtbVvVXalYW+oTCVFN1tCLyzz6jsedeA8+thH1InuUMSZEq/BFTaL2fMBsrgU9j0SwIE7vrxv8aW9V4oDq+5ggpy5Q3CseqyOIgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFfERvA1/EZn4J2mGh93Z2mufLFv+miUXCSiLJ5NMI0=;
 b=bSVInYaiJEzzCIMBoI7+xq4G7qv81d26UMoUp+yM/hRuuhg43Jkv8MqlgodmO36b5MUBcCM1GjTUTIlcogePl9buk+EKisgTzH/Hw8KGFrrBIWyJ2JYAFgMUrLEZdk5VnFglqHPsBIu5ISSf1w/beqAMC3GOopi1vKZZMMxLBZ+PUYnZ1NijUiyxCgOOyBY5fH/Zn21CxxAUKCxVaJCRNNn8T9C1S8Fw85FRLoiLkqO9GDX+ASudU999S+0PztJz6utWtdbwBuy7BRY3/lbseZIxu/f1zotvKsyF5zs+1O5bIop1y55ILe+RJz55RbtVzQKWl1eLOTUuxyfeEzbR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFfERvA1/EZn4J2mGh93Z2mufLFv+miUXCSiLJ5NMI0=;
 b=BreKejRSkHwHiUr6f1B87PT3LJcmTB6N+9bRt3hxdj/1ON2TjI9sy02rJx9L9+xI61w6Y74dkKkt9zaMXaTZfESZEofInd1ajRJj1JUFDh//L4egDraQt+rM/SWEtnr4cUwzLn3QyoaLKiVvnahecuvUq+k4Bp6zl1l3I6MIsn0AqA9kBdXrfr3c9kvpSvcMURQ+DGLF/EV+t3P7CLQZdFQPvTPvnMLXSFjTDAVsOuQHixkmbi7xlJbsdXZ0IotUq+1Nk4JcExdoz6MJdpHF5igY0tY2yGIQ3BdCuFPukeA2mUlQeuVpLGhVKTweK3VA2hn9FR7Rto+YTr6hfpu8HA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY2PPF5F53593E2.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:51 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 00/11] Add SSP/TSP power control and DRAM remap support for
 AST2700
Thread-Topic: [PATCH v7 00/11] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHde9fmEfC77B6cZ0eFMrR5+x3TQQ==
Date: Tue, 24 Nov 2026 05:51:51 +0000
Message-ID: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY2PPF5F53593E2:EE_
x-ms-publictraffictype: Email
client-request-id: b5613723-5819-4555-9523-c6bbbe37d31b
request-id: 1520bfd0-ddc2-419b-8eb8-08df49ef094c
x-ms-office365-filtering-correlation-id: 1520bfd0-ddc2-419b-8eb8-08df49ef094c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|261021121427099003|56012099006|261009223027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|261021123027099003|18002099003|6133799003;
x-microsoft-antispam-message-info: RG2+oeJZMau6u2SdM/Qb/0lfBctTtIAeQIej8vVPc8Uc3e8NYmG2EciSmsM8XLpp9Hi9U0oM4jeCphQG/R4JYbWjwPIUgGBQ/Ga031HsUWugzz4qlMPv5HKrjWZYAie0kgPjTt+/LuurstDtuLNXnJb83v7YFaoUKS0LVnCykF/IVSe5F8HR0Scgx8YCxGMbZA8mc1uh5ZyEFjdhD7qGoBixkGLS8A4xeBNkIfalCcrKrItUjXiUJhsiaDPTIhwLR8sv4qSSAe1MW/4RDJUIXErgx0Hi3TKl3Ze37iopYxmWXKBJSsIkaGasOuRffi7C+fMIftY/ItEnpm7qWl5VfRcozM+96pA1kiLTd9gfsut8UC///3y5crKA5lWlyptil59U/wGErsq7qHr9ozFoKsSI0vhqtnUOIvo8jNgntO0QVd0ygR2gSZ1vEqpdFjF7Fk/NzvcVNJmy+la4Z8eK+/DfU27wDv2rH+O22JLWaJzHMPeCOUNhX8/0NNOCeDLs999RROf639M7pQdOhjwqhjkzHY2YmkL/5LKlPoME98L53u88vKMsPb5GYMwLtjsv+kP6LpB1iNO4lwSmlG4+UKzUH9mNkjt9dOFSoK0mb/Ucur3vRrb5vf87ySHaXX912FfyVDhaBdIba8N5TwaKBnsvelnHHhpXOfaj3JKnI94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(261021121427099003)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021123027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZzZqHlooe2zO2rI6fZJE/mqFwfiRwyLKxI+En3kENmxl6MFZtHgprJyaEd?=
 =?iso-8859-1?Q?ISKb/MNsW/Kl6kiqugXtUltf/CAxxv7sx8gij4r2atGaGaG+b+d1cNmLNT?=
 =?iso-8859-1?Q?sBswzBnsmBqC1g3tQJAT5hIquQBDcQapCZBr8kcxHelmOzBWdBri5aeD3T?=
 =?iso-8859-1?Q?dlI3INk54wnXOUmfNTl30YQMEVynu5goXdNcFk/1aP17zeVB/6JAXOOYhO?=
 =?iso-8859-1?Q?19xj0Oah61/x1ydEJwSfanwM9kT+cQeK0tNA41Vxla+0TUXp4Chz7CXLp+?=
 =?iso-8859-1?Q?FllJCqF7eo59APiwcSYIeCTlVxK2Ix93PeuWqOZswcMdws3tHbfuo4SpWV?=
 =?iso-8859-1?Q?8qPsmA7HThqUuibQLek7GUy1mGVkKO2yUY0rCbzL9pPg52fMSgqK9CGZJN?=
 =?iso-8859-1?Q?kUtAvuP0udxm4g8RfRTMkm6wMRJft4wtvQ9kY2ul651IzDSfSoMzxgxO2G?=
 =?iso-8859-1?Q?MTFFY14PIl+iYedlXB8G260bJvkZbflfVxqqa8vFhpl/mlMfjcWOESiPw9?=
 =?iso-8859-1?Q?TFOKqDfv48yi4Dk6TwHvITOTvzuSlxKEy7vfWQuGXHrP/DK+3uC1wL/Lrb?=
 =?iso-8859-1?Q?msfy/8uT8MwEBWAZnR6Q0MFYwkQzoGt0oVZfNo6+3nHkaplXIKfm64TxTa?=
 =?iso-8859-1?Q?4kFe+IZ6ePu/MyJ2if5V4zH5J9KTTAl9xikfnMsVZ9mjGzU662azxd7bVm?=
 =?iso-8859-1?Q?bJMqUgDjGDUZEPZ43nZR/V3gwxI5dpsPmooPar9wMXNNXO518BB6tbDW+D?=
 =?iso-8859-1?Q?1E+BstmSvW3a2HB1SIeNfroAApFBKUgqhStiMZFNtcdoTXY/lbw57+Gnsj?=
 =?iso-8859-1?Q?actof3KyUkFjSewZzOb52pCTR9FvsCqvni7BbM0auJTxd6nVXu0hACMg2I?=
 =?iso-8859-1?Q?GYCJxYkQHVgfHMcGAm67cZ4VGGjd9ZkakOCDGBliT/lqld5gCYC0Df6z7X?=
 =?iso-8859-1?Q?N6U8gwhol4Ma67pMZdn9q2x4LDUXtR4orua7agzEc35ppoPThsMl/jKJwu?=
 =?iso-8859-1?Q?cij0jA4bKDqK9/1LYUx/2sYUS8gOmCMvxCcT4R6bQ6aiCdrBfSNoBNUVJX?=
 =?iso-8859-1?Q?E4O4eeR5+f0HiUV7n/EjtYDR7UiBlHy1f8SEWfxgkB62SvDilsB8Tr2bcl?=
 =?iso-8859-1?Q?lkO6yOpWVI3TsDSD+xwZDoOSOk1CP9dAZyB2xY29Ejjv3whWJ9X63wVvgx?=
 =?iso-8859-1?Q?vFP4daMgSY4Tnvr7sDKCwpUEz16QhDqKzDYBd1pkyXUDEINOHD8ntT14c5?=
 =?iso-8859-1?Q?+8VhtihHfyqvG+fQ44CBmWp7EoOfQ6kFn31smT1h3jQAFDN1dC5HNQvTfd?=
 =?iso-8859-1?Q?gq9STybFeKtWtqFzoRrW5G9QR36Lyj4F9LdfHBWuk4Gp0vQbnBsd1eGYzp?=
 =?iso-8859-1?Q?D+pIfzK+WzzBgIpGFUhXXhMnJ+3gu9e1dlWQBxWFZwHn+FLFgx3lcOjM0I?=
 =?iso-8859-1?Q?j8DXtNU4TpIuIk9z5qpkhBxqRyTTwsz5v7ddFWxuS2+pkLdJreKDcBRjLE?=
 =?iso-8859-1?Q?7m6gl/ek0GAoCDtmcYsHpsaarufaUNaV+VSKV1/TQOYg2ZXiSJ4XIU86vI?=
 =?iso-8859-1?Q?DMWyutLVzRmOFFsbWqR8ZQ+AcrgxwbILKPYpEQzLldECuITglRJcHaSaza?=
 =?iso-8859-1?Q?wCeq5k4CVm3/mkCCm73RZM8CAvDbdeJIhSqkx61Yg4OYXZLZR1meg1z1zy?=
 =?iso-8859-1?Q?iP1CGn3HkWm5kyULdzTacavhTzliMOnqeEypX7FiiKDLzPracXW+8UY6Q5?=
 =?iso-8859-1?Q?RJSjnCO0I8O4xi4gsVtzQQ6KN1WsWWAt5yVIMr9K+u7cCxI27ziuwUpisY?=
 =?iso-8859-1?Q?6rJQXslH1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520bfd0-ddc2-419b-8eb8-08df49ef094c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:51.1036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTWh8qXitXf0sgtsYGWWIFR2t/gUb2IPvYPWS6fGuhzX9Kztk6kkjFAgK12JBaQF7sxonfo4da9neTTRvfbDIQR+erD3cUcv2FlADpzSLMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF5F53593E2
Received-SPF: pass client-ip=52.101.127.76;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series improves AST2700 platform support by aligning SSP/TSP=0A=
power and reset behavior with hardware, and enabling DRAM remapping=0A=
required for proper firmware boot flow.=0A=
=0A=
This series depends on:=0A=
[v4,0/9] Refactor AST2700 SCU preparation for coprocessors=0A=
https://www.mail-archive.com/qemu-devel@nongnu.org/msg1209540.html=0A=
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
v7:=0A=
  1. SSP/TSP no longer write into the SCU; the board wires the remap=0A=
     aliases and cpu_index after realize.=0A=
  2. Drop the redundant AST2700 SCU realize wrapper.=0A=
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
 hw/arm/aspeed_ast27x0-fc.c                    |  16 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   |  31 +++=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   |  24 ++=0A=
 hw/misc/aspeed_scu.c                          | 259 +++++++++++++++++-=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  29 +-=0A=
 10 files changed, 397 insertions(+), 35 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

