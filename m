Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06049606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NDWRD9Jk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVF-00041m-Dh; Tue, 24 Nov 2026 00:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjV8-0003wW-5T; Tue, 24 Nov 2026 00:55:35 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjV6-0002om-Gs; Tue, 24 Nov 2026 00:55:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFT3DWVB1dMOff5GXiI3wsk/Fiqy3LQTr77rtTQtgXqJXewVVkeIxGoQWb3XjxsFsM4uTn0/QLS5s3OhnH5YKysJThL2WEEqBpugU0Rd148d70x2WFQB7dRAx18ziafGb8NEFJedSoKHZBtkWm9f92sfIOzKN0ANGqBSUFkgt6GcSCjygWiu2un+BXC/odKElOwPwK9nQE3pEYHUe0iKclPpzLpC/amlWPgZ3Q3at9CnlVaSOlUMZWh0XMKORNPmhbM4SuBCGaiNwm2YmBT1qPxCba0F1YPlVhUh+JSNiznGRX+xQdmwJ5kH30ZqrmgHtQSHWar8w22M5PEpWnJBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAP2mY0JtMAPSqlIeX0ksCTYZdV0pdqYKJAgYTOZo8E=;
 b=PfGsGPVfZoECiUskyiVUVpra2VOKIEg1mzE0abnfQDr4qfzDYkfW/tvgQUSHjdMCU30V7iNIUY34WL3K1PmlkL0o/rHGXlnk6eFNuLnSL2a9Fuv6fV67VbYpdr2MfEP/c+UNum3mB74W9cJy0HoSAd+c2P3HLIUHKLYJj16tU+BqMXabC3A1hPG0sWEvG6OOK/mjdVtAcyEOPrYgMNO+BSMZGy+IC0WG1+TbS2h6IiGx5Cef11NDzkMjFdH3rhyy4RVH7MYWWnEwrmxqfB0g/KiFlwjUdTbRtLgsKvWw7iJTAIrsi/nUMhKvPmnJTDIEdiwwJ+uuK8WDE5Bfu87H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAP2mY0JtMAPSqlIeX0ksCTYZdV0pdqYKJAgYTOZo8E=;
 b=NDWRD9Jk864e15yqAN+Knh67m4Ex31ezXDgJxoU7oyisINJTvApWyRM4DnDb0hAo/17zuoU8rzoBvEhdM25sYex+WmUTsfvDC8qw2R6oMiZtBUB8GMxh0O2gjEhOuGqYjtpEWUvZf1aHyuZlY55kHbTlx+B+BYm52U9/vBA3A/Wi1dhy4L/ldLJFEd3e65BVeqSy98QkGTHfgS84YeYT+OsGw0eLPBI+jDk6DfDU5ajAcTiZeBS6rCjZcfgKlt0MvekCp9pRyemLEeKz8YFqAOu4COT8M31o8g/LdSBtYChG2UmUHFHo4kuCpfwq7bodCIi7Xur97kpxcWFaf6IRYA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KL1PR06MB6591.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:53 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 02/11] hw/arm/ast27x0: Start SSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v7 02/11] hw/arm/ast27x0: Start SSP in powered-off state
 to match hardware behavior
Thread-Index: AQHde9fo/fOWtiEqFEij1HCpQiawNg==
Date: Tue, 24 Nov 2026 05:51:53 +0000
Message-ID: <20261124055150.1328856-3-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KL1PR06MB6591:EE_
x-ms-publictraffictype: Email
client-request-id: 046b911c-67d0-4837-b101-25c723ac470b
request-id: efaf5b7a-6c8e-4288-2d1e-08df49ef0a85
x-ms-office365-filtering-correlation-id: efaf5b7a-6c8e-4288-2d1e-08df49ef0a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|6133799003|18002099003|56012099006|261026121527099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|38070700021|261026140227099003|10067099003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RoMcm4woVJgBSvEZOIWD5pz1OkG/ESgGUYUFItnelpz+QRxm96fRDPtXnU?=
 =?iso-8859-1?Q?7NrPTj0nCYakS5GLFdypeoJ41we2e/k8dxv6lj68Ki2R93BQafeABcHqPO?=
 =?iso-8859-1?Q?82jqcwTy3FEIwtD1YNxC/PV6A9pD9Forj0cAlnHgOZ+y1LT+FADOlwo/YA?=
 =?iso-8859-1?Q?rsnKHCBn9ZIpsRXoufEkB0Hcvu55f4eMAGA05i9ji4F1eu+rPlripIT9h4?=
 =?iso-8859-1?Q?U6T8d9Jeuj8kBVCCA3HVRu5eDY5WkZbbJ+mUnOb0cSQOOXxbKD1hgZ3DLi?=
 =?iso-8859-1?Q?NLsLN+kStFint4iU9m2VZyqR3+SxfrPmDCA+bw+ByAz6B/3vb7WzKghwgY?=
 =?iso-8859-1?Q?t7Zh4kaYP+1iqo9bL/mSCcJFXRWufW3gGHyUk2DqU9iVIC+65U0dy33Qgn?=
 =?iso-8859-1?Q?ceGgV7+7KulY/m3BGDiZWLn8pNdHdpXJjI3n08biQrmA4EUJq7RJk8lm78?=
 =?iso-8859-1?Q?s6LES8R+vqU3tM/WPNaWsiavgtp/jO22V1Qym6UUGWFNZvVgfTRtzyNrZu?=
 =?iso-8859-1?Q?txQw5o8+m95ECo3sQvm8sYeWrx1uGHLcnnCB8Fwjp4XRgZYlVQQvqLjmVh?=
 =?iso-8859-1?Q?vY2iGtpk61n6SQmbxEz/W1ZeNhYIh/OOiZBBk1gynBNM3MttvkLp5V1ggt?=
 =?iso-8859-1?Q?OvFyJCFbC7S0tGKBXIMe6xy3B7rlkuthcFxd4W5ZRALjNf/KAnzEgWRdXf?=
 =?iso-8859-1?Q?Z07R98PzDw8ZIU5is8DE0sFgZ0wXoVZrpP7wX+UCxESPxMdZFwVx2StRjl?=
 =?iso-8859-1?Q?fuzdLbk8iK2JTeh1BToLdt4NATcwuzPH1JvqbVC7HeVXMURqyJgEMerwti?=
 =?iso-8859-1?Q?dgcwul7D4tz+a0DIgHqRf+PPLfp/UII5r9vU4KH4Ixg84ezNmvqVauEUO4?=
 =?iso-8859-1?Q?Bz+0+ZAZAEInmid290bYHn0ncqfPGSUoHizCKeVhpm8hOu3yXu/SjB7O54?=
 =?iso-8859-1?Q?7CbIacX98+9ASzcCOiaipGoMWD35Y3wj7J83s0Sc1OqU9mUE2P6hzybEI2?=
 =?iso-8859-1?Q?b3gxUkH3ETQvkhNUlN2yNBuzhdAvp3yVYi/EytnSEbveh7HaIe6mN/Vp4/?=
 =?iso-8859-1?Q?79IG4KRrQVvZmqcP72K1nCaaa1mCmdRPUW4t4CykJmsebFwvvuHYlwx7pD?=
 =?iso-8859-1?Q?gaoNz/GlrK65xuLpLIQoPe3rX8mrSdc4xBr0JRvSFq7LWv+wSW7B9Xd/t2?=
 =?iso-8859-1?Q?cOqDSaJvF0AxEUNtCC0EDBX18vcsfV3Vy+VP3bVXKplxHzwSN4xbFwnyxH?=
 =?iso-8859-1?Q?bigyPHhZ/H/+I4OCxsAgXr6jzfRcJVAf6TV5LolWZOuBNv9WIg1L71yRiy?=
 =?iso-8859-1?Q?GcjV6P+RrC+MGbX2QlP/pPCHuw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(6133799003)(18002099003)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(38070700021)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MeMaa3q5IeHXDlhe6UKb3gSQ+4u2KoQiw9g4dtKUFTATq2eGivVfiLMjeo?=
 =?iso-8859-1?Q?BNlCDn//YMjT36SPVenrgWb1/pjmVEDG5338mjipCJlHDG+Vz99g+yNykz?=
 =?iso-8859-1?Q?4OclicE/DQYa4IznoHLXE2CcXEC9OSu/EX3BGsLQJfceeispo2X6H77nsN?=
 =?iso-8859-1?Q?6klrYetVlVU5gXy154wBdMbVG0OpcZ7Lv88s8wCjcOnF8lsrb2CclbrV0L?=
 =?iso-8859-1?Q?sY2V8792vMpXuJoiXTeWVMzWL0BRfRk5x1KDJPiyLmjAHDRMWOsohwN/2y?=
 =?iso-8859-1?Q?ZcwDYciFxuk4QxOnP2GNHYb/VXvxseBw5/Gc5Ft2isqOuaAPIQmJ4WFyw9?=
 =?iso-8859-1?Q?+pHzGqri5Op8lh8R5cXlSsFawfq0AULn+INXNPXHvCKYkBSl2LDabBfqQH?=
 =?iso-8859-1?Q?cNjNoleZk330VJMt4a38CnSXLtQf210tOv3nIPxn7bpQ5w4pe71LgJKAMK?=
 =?iso-8859-1?Q?slRIAYwOiu7TlVGuACY10TyE4XoIa/Dw9UZav7dCdMST4xCaDKK2EQf+kK?=
 =?iso-8859-1?Q?3xvFxg44Z/+5Y9Xl+RdoNZGP4wQtEo5KKO7Qcx9ieIOmCgJfwUUD3cmKhT?=
 =?iso-8859-1?Q?z9CCfUw5HE3/IE92OPi9gp66eXj2Jo/D1OGaVMDHrPJVCpAQdqb0M52FBu?=
 =?iso-8859-1?Q?wiTbWwpP1Lfh5TOhfj7Bx2b8FuhaO4v8mqcd7Ao+MPhHaLmVa1YN1HaKBy?=
 =?iso-8859-1?Q?J1Kj2Peh1uT4eQi3pJYu5+7fzpPOh+JFKC7O8hyWmP1DYckl9De1p1VKSk?=
 =?iso-8859-1?Q?e+jLE439Z0/wqjevDpRn0vZf0bcpSV+mbcHsSUSK4WMZWDe20nEOAQY1qR?=
 =?iso-8859-1?Q?qkmeWhFwSAjKz2MnP1eTyXYu4npnCTjZmaLRYiWGAU32fiOrdickfFIrZ8?=
 =?iso-8859-1?Q?5mM5IB5bznZSTEzVfF+pVk32/TxCMjEgw7xmvYtO16JGHX36rI34PqVR6s?=
 =?iso-8859-1?Q?qwU8i3N/cx9EqcgtqXAhsx5BN++0+JaRGPljZ8/41bz0CV41SZ+a5LiPk5?=
 =?iso-8859-1?Q?UBKiwnlHOxkDCT86Eb0+CU9FTWI2rG0Ls678pBisruUBuR3zRseoUaF90j?=
 =?iso-8859-1?Q?LAMj+1dkR3e97hC3844qPY6m5W+lgG1tJgfD+NMdNaw2C0tQ7aVOeGM5u7?=
 =?iso-8859-1?Q?thgPgINetjM+5bWehTuINlJftMwtFtLG4sdvSdRHtID89e7ckHNMXg4LIe?=
 =?iso-8859-1?Q?hgLswIBBETH7Qkl8fCG39+qWuXx50/umn/yEsbR+jpVYHt8ZANZdi+nzY2?=
 =?iso-8859-1?Q?bEnpbLLOzvHr+rn+LKhjaJN8MPFUOjCtdEF4cOMUfltLohDaorWr4hw4Eh?=
 =?iso-8859-1?Q?iAuaxlPGXwQ2krUXM3HrIOTUMFNMJFpGEe8TA95zz2A/OeqNuhyQUmk0kp?=
 =?iso-8859-1?Q?T5t0cxpVvcCPhkLqM3qtGSfTv7wkoLwopYkzrE2a/3Ygtr5oQAlL5W8TpW?=
 =?iso-8859-1?Q?hheAe3F8D51XnljgOrmzOsW/a2+c4ZuXIOjLV9ltk0T34WPJUh31AwXCQm?=
 =?iso-8859-1?Q?jr7/1YJW5fNF1jQGs8jyT/VgkaBJk6CCBfPPX3jBisivvASDlUNKTlE5TW?=
 =?iso-8859-1?Q?VzcOdMU2D6TYLqWGVgNj2gXczxFPmOhG68OCngirCTlULbcSBmsxv2CawJ?=
 =?iso-8859-1?Q?DgMeXD3y3MlQFiPHdomB8ahjR6CatZ798Dq1Z16SPmkkFdEkeYuVJYoal0?=
 =?iso-8859-1?Q?31RyNpOblRKNN5V/Lo1kf/MuiVax6F8yFe/RSKcPHMc9M+ZJtrOx1XIGig?=
 =?iso-8859-1?Q?nRTzGwOdgtjgWyS4MRhtjJrmiNYUVjlAMmsMth6FqSe7qgLEpwKmmoVZ7j?=
 =?iso-8859-1?Q?l91Mvd8xFA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaf5b7a-6c8e-4288-2d1e-08df49ef0a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:53.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+ZOrit1ZxuAXlFSTZRYKJPADe6xIEqHqe+YF8JMs5ugkewkqv2203ipv4w6pwxyrNvXaguK6jPrBc4DUou7GUM9t7dyQt+v8m3Z3W61kkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6591
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the previous design, both the PSP and SSP were started together during=
=0A=
SoC initialization. However, on real hardware, the SSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the SSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the SSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the SSP's ARMv7M core. This change ensures=
=0A=
the SSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls SSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 0238dc3672..8d333ef3c1 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -189,6 +189,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The SSP starts in a powered-down state and can be powered up=0A=
+     * by setting the SSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.53.0=0A=

