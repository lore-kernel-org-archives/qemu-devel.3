Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D99E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY92-0002YH-MF; Wed, 04 Feb 2026 03:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8z-0002WL-N2; Wed, 04 Feb 2026 03:21:49 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8y-0003VZ-1u; Wed, 04 Feb 2026 03:21:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nObBQp48YjEdTTJxlVdpiIUiwWoRMjNwaMrL2cqjStcOREgR2wvcF0sVA44jETZLjqGTCm4WavMnGnB/chhZq8eDSJWDtZmyDQjY1d689iQq891Zt/v49fs8bHfoQSH5KiyYMIhvyqUpPsodSEok3iG8JsOIqrxFNJOxGRLY9/Tb0bzjlCgfWCwGtPkfX4GzhEwRmrNfPwkW1HNRQ0s5Wq1jVkRNPbr46PrfrBre6fTMDlnfBXd/scYMK0HOn3RwgNcMTgquMeYwFqtF/PJh6PqnwrgKtPRf35H0/M3ja/nYLtbLQTy/fTilIpW+z3LZcxvX37o8clWR71usI8fiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3pA5GelvLf3N3IUOneWYbBgKk1fUiyPl2t/4kZac7w=;
 b=xzT4whCMTQbWsAEOcMwOuUExXOxlExdE2rK1m6wc9pSRWtbcYwxYnDdL0tmyt3t54fnR+QgwO5E9/c/fbTr8eayYFl61vMlrvMpxYiO8iz1X128743yCQaHJ/bjxYm+gMXfOOC8mQW6ZsZw3y7YL9ies2Ar9L5/zjXI0t3ID8yiJbs+Or07m9aB/SxTOH4vFMH3+wIVpBas2TWtAeWQmF6Gcbp6ZdOif4h1pT0mRdIc/ufjdkiij9GVnOjHCaSeKivXHf3TsuyGwQUPGMGXFvGuryPX/8fnLJdQeT19rUYarRm9azOsad1soP2LllhkoF+iDD8uHYKPzpeXO6tqmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3pA5GelvLf3N3IUOneWYbBgKk1fUiyPl2t/4kZac7w=;
 b=DKq5C8j9IbwwKcwqis9qNXFOkTxHuCEYYysrJFPZkCs+PK9O08ysdXdu39xJG9C4barRT79pKGG5QkBcUxNQMnjHvm79b2tg6+MfAvx3bSkjvxl7VYsgJxXWJT7+Nob69wcztY9MiPZGCM6KFYszWdoPAGc4m2sKzj1kHPhCsglL/SoqxvUPA1bkANyNCkQa5uzgxVnNRQb0I3I7/36CG2Qpigwl1AX+xplJJId0Wm4yyjpF0Mb6T+wNmqPjW4vrMs5sAD+kouA9KJDLLjOxrC9JRx34+fYO9XC1yB4qeqsuxxGrlQ+IW9EVP6Jwgo+KBMc7nSgLW12DyKr+3YO8tw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:38 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:38 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 16/22] hw/arm/aspeed: Attach PWM device to AST1700 model
Thread-Topic: [PATCH v7 16/22] hw/arm/aspeed: Attach PWM device to AST1700
 model
Thread-Index: AQHcla9Iuj9mfmU1V0e99uu0rmfjZA==
Date: Wed, 4 Feb 2026 08:21:38 +0000
Message-ID: <20260204082113.3955407-17-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 397c9add-05be-43bb-684a-08de63c66aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/AumT8mr709vgPbvsTCWFp6xTtWZcdPhV/AUyiCBDL7k25KFaBD1P94w1Z?=
 =?iso-8859-1?Q?o2Th/nnifx4QTQj5owlTZ5bWt2X4TXET0YEMUlXnXp01rWCcgXMQP/SDn9?=
 =?iso-8859-1?Q?AVof1znkDb3qtTsPtsi7bRXrNv6ln8i4shTgPYwszTEfS6aIs/q/VVqQ82?=
 =?iso-8859-1?Q?INKTa3oYIliPygIZvoySQEa728w7lWM6kGzmca4r+ywLTCUfM7L2MdmtDU?=
 =?iso-8859-1?Q?LLuhEgToeZxdpLzEsLKtXm1vPby6obK2rlZRMO1FXws+O3P4NF06rjHB4/?=
 =?iso-8859-1?Q?pglzw1X2u+aYoZEfTUaRuGKzfBiPDE1/g4/l8ynO3mhN44mfSxn8gtY6pK?=
 =?iso-8859-1?Q?kiZ4FGhNwS+Rn/ueYydRrPvUfZm8llhcid1swBZgEkbwICk52VT6f/tNSf?=
 =?iso-8859-1?Q?pt4Ocp8rykI/lxhRu7U50RAYCzu4cp5mARRaJdk8EwerDxOo8Sn/qTBY1d?=
 =?iso-8859-1?Q?7w51iDDj/8k9ZPYUS82gqkQwJjA1Wg8vEgpnz/Joqom3VMh8RAnwB34UO/?=
 =?iso-8859-1?Q?N3pEP2SBqcxmTibWARqYpUwZLC5MV1MtnRA1kqjnNJvnhBOl/VaY5vuTJA?=
 =?iso-8859-1?Q?inR5mh05C0aOjzkAoGjCscXY/PNLLgBBQ+xht+l72wve3I3wCW0U4Fe9YD?=
 =?iso-8859-1?Q?Cg+tRCAjqQyK9K9x5P6brXBbxxan8Eb7XATP+EQ9SpJcVIzsGt3RST4DHH?=
 =?iso-8859-1?Q?PeUGjEMZiz7ugl8ajxOoLgrmk/G01hGFqBK6/PyQarX39SurJ81X+DBRfo?=
 =?iso-8859-1?Q?v3QPXjeGq0jOdlecWAgfwonVb/fWAvtyKcxJYVzzVCDlz/RXYQ1G5qqqS7?=
 =?iso-8859-1?Q?uNR61U8bmWhk/brp6r9lq8WMVKtCiT4VTUlTDNUa3qmr1okz9rvuzInrCq?=
 =?iso-8859-1?Q?pKIUVxg3NGGqZgb42RMbWVBfH5P4EMvh6S7iz1ntkhDSUUoTmadPMNRTbi?=
 =?iso-8859-1?Q?7EjD9uPEDRXaznHDvC+5JdOAALmjSlieH9ACewSYn5yRhQ8zaJldLSlbeS?=
 =?iso-8859-1?Q?XzGspb6wlcjKzlb96hDD0m22x90cDmgLW/fkupHjl4wyidEwPCrQHlekUC?=
 =?iso-8859-1?Q?KTwg7DrSYkZ6T6phDUnQAy33iuRa97gzHGbrCuWM8RwhfVW55EXf6uxcAb?=
 =?iso-8859-1?Q?4tf+zxYiigHUsXYa694cUvIeuWH2oWsmCrlXtGB7YadZ4/K8IR6SsFdLMz?=
 =?iso-8859-1?Q?8E1Ud8oDg3bE/RkVIw/r7laOXC7bRpoT14xnLzwmJLSqa9PlrWZBglTMq6?=
 =?iso-8859-1?Q?I04hNVnn45mVjzNAfXO/9D2zvdVT+3cEgErZQXOAsaYXy7VT3+IbqqgZyr?=
 =?iso-8859-1?Q?EgMmuvWNqGoGNoYgnBAJ1Asg31iXyj1Ak6fTBRm4IciqNtiL3YOZUE0jO9?=
 =?iso-8859-1?Q?qSmqS8L0jO/nO/fyqHE5vi9v2lD5q6Ioa9UOuvkAXpXwxOHV1mHvWrc/Qe?=
 =?iso-8859-1?Q?KDdc7wU2DT3TgkstLzW+WQLCKQzw7iXUJhOrnFv/hc5B9Gcyr4Ct71YeF/?=
 =?iso-8859-1?Q?I2PooaSw5Pzgw1XE4SCfVZy0fqdbVVjYI+1Gzi2jDU0nbTXnfu7t27lYUi?=
 =?iso-8859-1?Q?hkpbKgTI4CaGQ/v7VIuUBIoFvxEKdMHwly1yAYT88lvvhm+3cFRaJf/GSS?=
 =?iso-8859-1?Q?xUvaPPle+UeHAvoAl4a7iD4ouCBZdUyYgvJPOrb98SbHvmopj1Mfl7hOSS?=
 =?iso-8859-1?Q?sF0h94DmVDEtG/zUb7U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h3Y4RF0Ean9t2Zocb5VNQsZ34b4JhhVwjt+y/j6OeI9x+pI4P9pEqq92ig?=
 =?iso-8859-1?Q?kVg+QFkQieDkv1al+li38OoVIbbyMviJAa+GqbnwxaHDBCiaLpRPS7+kg7?=
 =?iso-8859-1?Q?6Md2VMtPvJrC5o8IFlvZG9sSF3xlw+dbvRpcO+MT0uiJGOHWp48okaNiEl?=
 =?iso-8859-1?Q?SmdomJQP6Ps2wmf9bEOKYxEwdfcoNmcBhYR8pYG7z36zdZh3dsPmQsN7eg?=
 =?iso-8859-1?Q?hVL4CKM3Jrz7uU4o8/MsjG7SJeCwoF11t99vTQ+piFMk/MAbBzG8stHS5w?=
 =?iso-8859-1?Q?ZccZvFNG6iPvPIKcaLA+2SKI29xj3u/hpOILjfLpa9kELouYFhuFMwPgKF?=
 =?iso-8859-1?Q?NCbGWs2KiOvV90WOszmUB/lxpvzm7EvPO0hfuRIPlZvq67JTHAaxyO6I2+?=
 =?iso-8859-1?Q?tf00a0GfovOSU0U8Uzc3Fivl0ttiJSKWgNsjjctOiDP/kudc4CBC3wY6Ay?=
 =?iso-8859-1?Q?s995L4V5UFJCkiGnyGKIr+ypO/3B1hFX0EP0uy8XeMYbT1FY27De8LWwRC?=
 =?iso-8859-1?Q?zH/q/jTH2q7lf6cE+MsmcWJHKsy5IfbPjjr1OivaywiVbs5J8bq2NxLWxN?=
 =?iso-8859-1?Q?KbNTDpAH+7v3EwnpgT/OViiZLA5A7XeuHIDFkNk583tdGP77zS2CSAPKc9?=
 =?iso-8859-1?Q?5pW1Pfs7Leg5buorN9zaKLdnBCIs4i2tt/TWX3U/vjeMgnCNdQ0YislomK?=
 =?iso-8859-1?Q?vrmRTtVKQWBfS23l90NuWZYzp9xJIj0zQXsdVaKseieme1jBNm9vSfo5qK?=
 =?iso-8859-1?Q?O3N5ZynJXPaEHg7MBwEtU4xzRBN7U/IzBs12/ooqP0hrvbpINPNK0hlqqS?=
 =?iso-8859-1?Q?JaD46hvvn7LgoeXhDmfq7gHzDTnK1Ovns5Queb0yU+8F4ifY/qcv0L8Ark?=
 =?iso-8859-1?Q?xFIrUMCLsS05Mq2JBxksoQ7ZuzFKjrP3bpF+odEBd4KYSRC0JhgrV2/5Uz?=
 =?iso-8859-1?Q?21pyjH8oz5vbiO/Vm9KgvipSb0Jjc5J6s1Bc9G+syNFITQ/JCwNiz5l9dk?=
 =?iso-8859-1?Q?W/hnaDcEmgJ0JBMz7QN1f5qvoompxB0uz6jIrZCwTgEhQXBTylVZH6Hc3p?=
 =?iso-8859-1?Q?zxPo/t6ec5DCBQUmXzFCy56HFDdvI5siqAL4AJoZmZ9wZ5tlKy0ye2wnfZ?=
 =?iso-8859-1?Q?63/PTe9oTgKyhA9wwtDRuAtJxkPO06gFnrDrJTVfC39vgxTyhzm9GwhxDT?=
 =?iso-8859-1?Q?M3RNFuWAtXbkgVwX4RznpAPc9VxvSL0+PLlJMIZoGhkUHxW5YzCyXPHCXw?=
 =?iso-8859-1?Q?KTXnmkgwrCLngOSCpU6gUwRPmy9QoCZsRfxWb6Yk3Mh5upatn73DSOKTEy?=
 =?iso-8859-1?Q?YFE8n6KyxF4y4pM4aSO1iyatYjcOKO52vuuw7pH1maP4gzGROEce65rj6p?=
 =?iso-8859-1?Q?5eLEv4Z1ZpPM85CMXi3i1bfaMalw2vc3e1VblZ0w0lbNu/AFimPY6xqKHm?=
 =?iso-8859-1?Q?BAhWYlO4heFHEVhUPHbn8LUhHY+8f4KJgC1dHSGwnF05FvnJf83zbEUhhn?=
 =?iso-8859-1?Q?8Qe7aD1drEjGrz2+Uskz3y/TRvUAq0JSaLBNUPD70nc2I4Kqs3g/SZh+FA?=
 =?iso-8859-1?Q?qTNKmhUEIok6SnK2L+fED9n0KaXSkLOrNKGLuAyFnjdIbO9X+U0WQTX02E?=
 =?iso-8859-1?Q?uPjQLmjMDikkBgWBkd/QBKRkGGSvfekNhE+2KEdD+PurOPlN6P2fF+DVbr?=
 =?iso-8859-1?Q?0xSFq8n1q9RiGupfoXoEvo2GFJeLT8Qqqq8LNfGEtPvGyJ56JpFPHpd1fP?=
 =?iso-8859-1?Q?EvaQVkEbmM+IaJ7XMjyeTSa2BqM5otHUwjXKq9NW5gCVD8sNqqriIyksNa?=
 =?iso-8859-1?Q?nXIjLjSjTg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397c9add-05be-43bb-684a-08de63c66aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:38.0643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4GOFigzieiGK9PQJCObrREgZxxQyfEwmlQohpxFSX3dtnDZFERNdUhiGCqIAqawMpRdrZl3AACoI5wdlK/skZZk2cy6JkfJygJbgNZEI7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Connect the PWM device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 13 +++++++++++++=0A=
 2 files changed, 15 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index ee0c47d173..8db513a38c 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -14,6 +14,7 @@=0A=
 #include "hw/gpio/aspeed_gpio.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
+#include "hw/misc/aspeed_pwm.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/watchdog/wdt_aspeed.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
@@ -40,6 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedSCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedI2CState i2c;=0A=
+    AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
 };=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 59954eca99..c0b288a0fc 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -18,6 +18,7 @@=0A=
 =0A=
 enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
+    ASPEED_AST1700_DEV_PWM,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_SCU,=0A=
@@ -31,6 +32,7 @@ enum {=0A=
 =0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,=0A=
+    [ASPEED_AST1700_DEV_PWM]       =3D  0x000C0000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
@@ -130,6 +132,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0)=
);=0A=
 =0A=
+    /* PWM */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pwm), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_PWM],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm), 0)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -183,6 +193,9 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-i2c", &s->i2c,=0A=
                             "aspeed.i2c-ast2700");=0A=
 =0A=
+    /* PWM */=0A=
+    object_initialize_child(obj, "pwm", &s->pwm, TYPE_ASPEED_PWM);=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
-- =0A=
2.43.0=0A=

