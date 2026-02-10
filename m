Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA82E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdj7-0007lw-0A; Mon, 09 Feb 2026 21:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj4-0007lD-O8; Mon, 09 Feb 2026 21:43:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj2-000297-GR; Mon, 09 Feb 2026 21:43:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO4RdH6FweAWrTO5KcVaE5boca6o551W2AHAJLyZuoWkgevIy0iEdbSamnB3LQz25GMms1aQOwoOt/B3jM/GTaRiqbiID2R/TWDCCPSoP2j1x5vlOUB2DJSuVoLU4+0PBSXyRCx+KnIIeXlBcMhRbuqGHJku6ctuVpFwOgMNn7muMdbWH+axzgUPY6SUHL2ZligH2HcOK7QRmS8+x55MIR6605FqZpBD9W+GejE+Zqp3qg5E2SEyyRWpWaqBAbQzvixXs1p4TuOX1OV154FtZPDgy3GK0I6jPZ3UHjIr/m9e8mBh/CFPQPLrCwhvnrBSlaP/bmu/YS6OonqP1qKrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rcdek5yOqQa1KyhSjAriVp3zVdGeGBEbl+InaDw2DI=;
 b=dSedqKqlvH7/AhkFj4pUrR/2bUiULqLnPKWeuEHGSwFmBu1OIFrR3YZRp/6zxIlJZusXYuu8oyPKCaL8LpkRYVy777tmRs3vISSqqAjFihjVQP4J5qApILZtKE4m6QgM0Rrik4ncwIw3Qjhq1Mhl8m2FkHde1QVRI4UhN0xyY7bp9OvIL/J13aVFBqyO89Pz0kKStcnTHvTAvAcz9HvlrhXtl65BuW849qMuFr29pwLCeCFIYNuiVDFCPxJyquHt1r8vsG72yTt5NklYG7ql8ngNK5Egqo810+1N4K0zuljYrumrNLF97+rMp9KkdJYXonB3/5x0Le/WIDcRiU1J6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rcdek5yOqQa1KyhSjAriVp3zVdGeGBEbl+InaDw2DI=;
 b=Iy8ytnUAlCso9BDfqlzvLD3DntnPuPhALjGRkavoAsuos28tLG2ZWOb5zUj4sn71HjZQrYywFjvf47nPDDnpXIskFCN1B/Gp/E+KQ6tWGyCxRp/N+Htr8PmFxgL3vcl09c4vdwk34ZPd01DL8fr7ph0asPtwhQ6CbrtT6CKGh8oHTRNnJ0e2bAKkaa7SRwzd8bEEUpLY9I9iWGktDsaxdb6qWPMfxMrX7NbK8mU2t/zkr/uU8BOrIMHMlw/ecSQODqe9BRCPWN/69JZFwSmcCAbBOxfxQGKnuMBz8z+ES6ls2JtmAD2LFUN+JiGUxDDVQJZKUBacItPem+maa+s5bQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB7118.apcprd06.prod.outlook.com (2603:1096:405:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 02:43:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:43:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/2] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO
Thread-Topic: [PATCH v2 0/2] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C
 MMIO
Thread-Index: AQHcmjcLuDXXD61xzkuM+Dm8CyBnGA==
Date: Tue, 10 Feb 2026 02:43:31 +0000
Message-ID: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB7118:EE_
x-ms-office365-filtering-correlation-id: 46499f62-10b5-4474-b6a3-08de684e2dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?h6Rl2n0LV+bwZrZTIwpsux/8scLqfqptSUz+olpOQwCnbbjVDiJrYTet7M?=
 =?iso-8859-1?Q?p8C84GBfHlQB2DoDwqPtmsyemVankCdhaI/VMreKRFF+Tmy1LEMT12KyMw?=
 =?iso-8859-1?Q?4jzIqMcdAFPZ4qktm1AmJCXH945Xe1OB+mbmNq5IhdyFDi7pd+PlXgReEg?=
 =?iso-8859-1?Q?kAvXE4xK8xS3RgtUxF8KIx8BSP6Z38x2Ws58QF1FQXIpkhOdM1NdN017NA?=
 =?iso-8859-1?Q?czIviSGUtX8533P2XHdJV+Je00rRfBZtD6czUBDNX8afLGsETz1iegJW90?=
 =?iso-8859-1?Q?+6u8qEYsQ4Jq+KCkh9K+wPSX0IOFBnTpuKKA1njsD8CQtfqIwNoa6DXPv3?=
 =?iso-8859-1?Q?T2pJs1TQHXZgnodHBT+LvGTxr/9/yk9mWUVSDKg0PyFIoe3JVEJ9KILH4c?=
 =?iso-8859-1?Q?YJRVvBECwC/5AXOlh94dicWMZwR3xNEA1JLzBVVgfVn4ALZLH6E7L4TTcX?=
 =?iso-8859-1?Q?EETK9Jp/m/tvQ8Bp2I2/6VOBDWy1F44FpMtTavjCSMOsgTpGj8tRcto3HW?=
 =?iso-8859-1?Q?QYlOBIhEQO717vexryyNW+iLWpvTQQh48doEBrAk88OSqmbMm0xc+4Ek92?=
 =?iso-8859-1?Q?sVVgb5CUemOlK37M3z9FEKH0eizZa3PBv/bRgjlHowGmfwQoGeDytoHXDz?=
 =?iso-8859-1?Q?rVACbkUQmJI29iQa6GUHDvLq2oyOCpWHbVM3A5AUKeTf5zBZMX5EKXgRBd?=
 =?iso-8859-1?Q?ppsB2Km+MH9lvY1lIA8Cka4vu5tYBYkdAQY4fw4/hZ4/oO59PGT1nVXWjy?=
 =?iso-8859-1?Q?/6nnkZzTRGXtWy63PBpe74e4vNn2HlXsot5y4tTja+wsGXKJxip4xT+hjG?=
 =?iso-8859-1?Q?qvybrWex+cWseacKWj6253ee9praVmhUmJvrZWefCMC9GmLIvxakn8UKdI?=
 =?iso-8859-1?Q?tGeO71jz6L8zOTDUuW/r4R2ESph+jJwuKCxBCrrSNNPZ9pj9lEzY7e5bpX?=
 =?iso-8859-1?Q?rAH0CqLUTyP1NsXRZSEnJPxmtubUH5hr8tPXlwATzItrGjXpenFrY2AUd8?=
 =?iso-8859-1?Q?Yrp+8jtRYoR3iY2DGaY96Y9NT6oAqzeiWwgRDmczNty7C3ahplfo8hMM7s?=
 =?iso-8859-1?Q?vROgztE7qEhNR4cySgdslzktsSNyXun6BDLMxKQlPRD8Op5qLN/vyCAUjx?=
 =?iso-8859-1?Q?cioyVthiBqce4P4fcnUYS8zFDuHNdLWoteqLHfQm5OzbDokMAr0zgcS1d/?=
 =?iso-8859-1?Q?j+wBFjQ3BHsxgbD4aDTYi3faXG+UOMkjFitoIi3U0bm1bCI8VDb3MYfNu2?=
 =?iso-8859-1?Q?Bi6bEHyuWJpfvMIlT7iF+RnR7B1V4XOlixGNQ4Yzf4IMXjJRyvxjWDi94E?=
 =?iso-8859-1?Q?2m5G7AXjRnNP86Yxu1nwKnuMLpZGIgJvW/j5UdnvRWgeufA3V0aZh9IPYR?=
 =?iso-8859-1?Q?/57nzuFQYaAtAQV8jTbeG4KXeIiy1OG77O4wraSeRz74q8yAj6P08o5fIC?=
 =?iso-8859-1?Q?8X2pe7my58psvnC21tPyaV2vyL0OeyfS1bOTwZIsx83tzuTMmmn7P+X//T?=
 =?iso-8859-1?Q?yVybpWEdbFvBQxDaMHNqG2HR2Q+fppx57U9lATa1gBM+Cp6d2fyzyS7zw5?=
 =?iso-8859-1?Q?f+rhKoaHJQIAEQm7jnSCQoC16vZjbawwVRWjSzhQAZ+2ezgpQJue+7ysOq?=
 =?iso-8859-1?Q?IbGDfEfX1NIpcfpk60XRR3+DK2NhwSQD9vULekAblOoKRqujMf+FiLuus9?=
 =?iso-8859-1?Q?r+y2Tdz9C25c5qBNlAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SkiqDGJw4pV30dHexB5WGGisFQxL4vzaieVRF2VgL92xS6DvL1w0wv42fR?=
 =?iso-8859-1?Q?mFwYDoGhz4hDQEROChCDpwJu5HROoBlh2wtINTXQDnEBKmhqrtJN3XL3jR?=
 =?iso-8859-1?Q?R/zdGIecZWp2KMw2hnKzkLi4naZMxZwFzdPuvYrc/crCjED1tidkOMD9Yd?=
 =?iso-8859-1?Q?1/frYyQfcBhCxCL3u0N7fbQtFGWbgMRqnCd5EFt+NeG4Fsn+BLUbCLYNZX?=
 =?iso-8859-1?Q?yQaGZ3kKl7N3IFzQ0JVqouER21SV5DyvFp/HpxMgoPv+uBo/PRhcpLL/sQ?=
 =?iso-8859-1?Q?uYQco061H1juFCiXOjLI+BuNudc/1mVyC1TtzWahXa7ejJmzE3Mf4gkHB5?=
 =?iso-8859-1?Q?9omnqxt0gVlg5X1bfyvkg1nqJSWNbPqIf8C0PxCYrvH8spZpnQ27uWbE/X?=
 =?iso-8859-1?Q?piLaVXSgMLFyJ7MZD5KUFaokdjMPv4QsszXEtoiRXVKlVbKqXu8b8OexkN?=
 =?iso-8859-1?Q?P92GYeJe7uUPTQ0XX/+6kvA6hte20qhleHJ77iui8TxF/of3pH3+a042FZ?=
 =?iso-8859-1?Q?ItdSKqrwkHdIB/vQQA3En6thsSzMKUGz+IChbj/RAavckGQPN01UgWlkYU?=
 =?iso-8859-1?Q?OskOOEh2elPs3lGye5rW0TFIHHFpJrpklVjv/KxLY5gvesO7iDkfRYKIxc?=
 =?iso-8859-1?Q?//Ja7qqdqz+D7HWeQPD+uaxbTuegx536n++FMYEx/ES4kxvgj6R+9/bje5?=
 =?iso-8859-1?Q?07dFcaqKsUF61J+2Cgfrlr8b/Jwd89BlSNLnEEvoS+UQQK64oM+3fC2s1i?=
 =?iso-8859-1?Q?TO/BQH4MtL2+nVFwcsX8bIpz7yGtijVOqIceT97YKMo3h2JnP6wAgYWpOj?=
 =?iso-8859-1?Q?mKuqQrvnzvm/nOWOdJCb0hZXfRqfJZeIX1F7nV+MezWnKTGkvanygxJewn?=
 =?iso-8859-1?Q?nYYx8IrMJdWgJGEvdzK7Rj0vKGlCjHK6KPvZNkyEpNQLquwRRh+EcX1/c1?=
 =?iso-8859-1?Q?JN3HgRAANz1kSpkhAONSKnP7AmUu62AS25BdUK2jUEGgnVkzDW2hBoxNUy?=
 =?iso-8859-1?Q?MYIlfTEoVCDiEGASnbioriUim8LUXhBmGVIgFUZLUkPSClP/ffI9j89rsr?=
 =?iso-8859-1?Q?GInehPk8k+AIabF2EOAFV2cjQD1tsQqB1uZYW80lAYFADaEGpt432BaAm7?=
 =?iso-8859-1?Q?iehdSW2/tnha6pIkAP7dBvSc3Rt+WiWD74hsxSmVq3+DgE/D3jqYXiTw4p?=
 =?iso-8859-1?Q?syYXfNjcQPIvBixcyNeEr/EdVb+WZqpKI9VRLxNZgVfLhs+ZbOMn4aSRQt?=
 =?iso-8859-1?Q?oBa6Fkakab0LIgNQokssYRUc5Xpmom+ay1/pB2R+3qOzX7tILLH7uLUhjD?=
 =?iso-8859-1?Q?8MVz1IAhJwgXlDvgRJJRFJ/Eh4/FTyy3NEWlE6Z2yYLFZPLbkXwTN5UqWf?=
 =?iso-8859-1?Q?9bva7ziXOPWbknzlAErC8OOg6hmXnUsgWkcYxOlxXrdcHXNm3QKxBfxyVH?=
 =?iso-8859-1?Q?Tk1zqxpNfieelGcqPUHDhI/bB2Sp/JHwZ4lWgKLFni5Q2V85Ld6JVf1pj5?=
 =?iso-8859-1?Q?IT9qTwAi8EPe75V8BoDXiepoVyMpHkAZ3GSdwKpGYJZsAk0BZL4yFLKcv3?=
 =?iso-8859-1?Q?GgVUK6+flJ01vA0/lRBPojXQido5cHfKnLMwbDJ12ow4hofuquKtxIVxco?=
 =?iso-8859-1?Q?El2jWVjfTkRJlUroU/BVuhJenzGuZ9SuNVo/IRhRprtZgrEakMOMAzt5WU?=
 =?iso-8859-1?Q?WKuJJWE1ZE87gQErXZQmspbEGQCTj7WImnvyNaGublTYitGsUbmL0PTcNO?=
 =?iso-8859-1?Q?SH++Iv6dqqfrIyyLYyX5cwZOTkoHYacVsvFD+W1+/T73sV0vMbra/XTmoR?=
 =?iso-8859-1?Q?13F2P6ICcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46499f62-10b5-4474-b6a3-08de684e2dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:43:31.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6jSsQtia1F452i9Yg3/1LFmobG6/3ogEFTxwAMOz2Gy+FRPbkw1SJL24TVCgBJ5pNieEgA4Yv9+CnvrEhKjukktXHBK6ROL8qRRucp0cxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7118
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

v1:=0A=
 1. Fix Out-of-Bounds access by using dynamic register array=0A=
=0A=
v2:=0A=
 1. Fix Out-of-Bounds access by increasing static array size=0A=
 2. Increase I2C device register size to 0xA0 for AST2700 A1=0A=
=0A=
Jamin Lin (2):=0A=
  hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers=0A=
  hw/i2c/aspeed_i2c: Increase I2C device register size to 0xA0=0A=
=0A=
 include/hw/i2c/aspeed_i2c.h |  3 +-=0A=
 hw/i2c/aspeed_i2c.c         | 58 ++++++++++++++++++-------------------=0A=
 2 files changed, 29 insertions(+), 32 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

