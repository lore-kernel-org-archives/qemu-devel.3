Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60784EFB811
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLa-0002O4-5R; Tue, 24 Feb 2026 01:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLX-0002Md-Ao; Tue, 24 Feb 2026 01:56:39 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLV-0005Mp-Hh; Tue, 24 Feb 2026 01:56:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcBQAl6LCh6K23KjcyCpQYUQCthLLsu9ZIsl3jybladvGb1wxsTY+23347AF7jn1rOpP6kuhGZ40H2U0Af0tVqgpzLxrUWuNgF0SczYaTetJyMrDaADULSSuDAGf9UqdRj8Xw9HoEsw4hIzyVaESTWQJlVGdd04ywW2nxTWptODBbro4One9JRMSWfGxyIlZ87ivLb/pTdKtvY32qqekRV94Ooc+yokAAq0sfAnO1oSpBXBFLS9LBMTLa/KSCo/tCkrWbyNE1PQgoE5NCVyGJf5MKJ36acTZ6uPsqyOqUdYMidfqPWAKqshAQwO/oOO/GA23KCK4+v58bdJWgi7E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR0Cc2aY9xLxkrs1ykzGpDtSU7if/X/AVBKZ+S9X9NA=;
 b=WExGLNmLrN7eHZC4w0MhezJBE+uy9NOIwebhSK7qL6HereOaxZyMo8uqDubZoZxcRs/VOPZ4eQT6h1iWOn1jScPN55fcOj6O90hqU7tvxmuhzAviJUGxfQrjGBtwDkdv8WvTkQqnjhoedgjmlKQhVEhT6cNIYhSEaW5iG94oZBu7QrMAFz61GKqAqmyOVu/y/TW3qlyJcjWtNITvJ8+kxWDCTGqFb0xCbgLCi41tTjiVnumjkxmVp89P57UVKhZPr+cNuw0TtWLPArWf79jRnBSTmaOlQrOd6LSy0i4RcQDeoCsiowVRhdhyGvWh5k28mfnLSsmecg9JqesXCgPyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR0Cc2aY9xLxkrs1ykzGpDtSU7if/X/AVBKZ+S9X9NA=;
 b=D92QgUQ7ro5A0nPSo87ofVXloeouctrJyTVCMb6szh2hNnw6+jWnoG/eCQfl4lHn9YkQ4XdykmdQqPTQpLU/lQ4nUbclkYpcsob7vbFq9lgTuzkEJPfCCgqiVGDTxBnZXz6Ig8ZkJirdxLQcJKjQZBJj2tS4tiFE4W4l5pdft5Qx3xEvIu/8YgNeAT6ftnArPtDrRUc2Rju9gp3WRYIw2RIy6e9R7HKdgAaUcDidMV04PsYXKdxFJXbv0pHtQOGg+t6ug91t+kZ+cPgROTRwloLgG8WeM9ulZBIYTluslfaZRteBEv7SiIOXlY9gqTFsKyG0jqR26bhufLNoNvXmjQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 15/15] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Thread-Topic: [PATCH v3 15/15] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Thread-Index: AQHcpVqs8Lll/k01tk6nkgzwydrVWg==
Date: Tue, 24 Feb 2026 06:56:18 +0000
Message-ID: <20260224065556.3847942-16-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: af7b3c41-7b27-444a-3e28-08de7371cf62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CzxlbdjIJSTe+9jVIgB9xy247Y94daS2WJ2jjxB9AAzbEABaDj5hi4whff?=
 =?iso-8859-1?Q?TxYX/jF0RYeSbt9hOthadRkR2Efy0ubvZgvsVKBNn8m2BpqRUJDqPA/STs?=
 =?iso-8859-1?Q?cdZp2VjYNUyfqQkqNP51i9HYG6N67EHZrCqRSwxDsCzTkpulPvl2tYg3Md?=
 =?iso-8859-1?Q?Vvk3pdGr0Wb++TeBGk1Ex28k4AWnuywF0OoaLSO3uftYNuqbzcvt/BUuSt?=
 =?iso-8859-1?Q?VGnH1UTxDLHt5pHw5szGcvJaX2r2+4md+rWrsJEdd8ISBf+9QsAt5TC5Hc?=
 =?iso-8859-1?Q?50BCitLm2oG1bWcumw6vRcOSHQNBH2X4AXwrBD5COib1DTTfJYO6xmfpy/?=
 =?iso-8859-1?Q?B3FxJnEvJPLE0lwDnhyi8R465KShvjh+QLJsBF1utkNH2DB5dSyR63YXD8?=
 =?iso-8859-1?Q?Xk2nwtU/h5FHQfTfJc4UnFv5A+Wk637NScHzm2MjVcF2tsFj0F+9aimbFr?=
 =?iso-8859-1?Q?z/TBMjhrOqOsdNW5f4xOA+bkishc2YT1+i8T1fg9LT92egw13pNK0EjM4p?=
 =?iso-8859-1?Q?e7WJbZEpWKKY9LEStyc7pN78FBKRDUnwQrwR20mItEUi3QE46EoPqaZc2R?=
 =?iso-8859-1?Q?+ZiIJnCJ9t1MQEBMCZMkRKzJXy1rgQgMuhZG7w128s6XwW733GKgj5nju0?=
 =?iso-8859-1?Q?8a2mxbpn3/2sSaitPqIJr6T7f8yhiUJHy9z0Zw3YPn6fB8oVrBg/BLxmOv?=
 =?iso-8859-1?Q?bMPt1IEL0cp/q0NsyOotCaugAedR8VR95GESHHjoKp0WK8A+V0beoZCHEq?=
 =?iso-8859-1?Q?SPRKXNocuItjo64IOTDBRfNFFOWOIJn/416ergEz3FrdPQRCUJWpplLF+n?=
 =?iso-8859-1?Q?YQ/ZpM5e/6nz4XBV+qN4AiUcfgxdeVAdhubPgYnfiLrvCn5Z2hlWBYBsf3?=
 =?iso-8859-1?Q?oaZhgQmadjDEcrGy70wdFB5L7nDyQe4OmLoZFaXDIYiY1SVxBdCXQJxgWg?=
 =?iso-8859-1?Q?n/L9KH0oZxbXeI/wctFjMtQ3HUt0d9kGVr1GM+/gITkIzgXrLKqplJmzOA?=
 =?iso-8859-1?Q?UqyKy2x+D86UgsEK+z7orDnvT3OBKhuWrA3/DpyGEvlR/qpBua6Hx86Zxq?=
 =?iso-8859-1?Q?HnLFJusEAiPluIWSN8pZvzGLHOq98Ha1uh6LoYqzA9d2a4Qw01mSL3dMms?=
 =?iso-8859-1?Q?hynW5v51oOp+0Y0f8tCQtrs2wJBmgtJYU1JmQj9YvW5XS/9UbHt1eC+NPN?=
 =?iso-8859-1?Q?CIUO/OOS//+pA6xB8DIHCMa29eHAuLH9I/qQBxruJGBw6uyuLCwKea0utz?=
 =?iso-8859-1?Q?0dxLiOtRwRhrO8kc7UwMUAA6hXeAT6DuMNoWnIwy1HsarYRXN9xo2Ox6+K?=
 =?iso-8859-1?Q?y/iwOLb93J8DvAgcZr/cSAWj42VcR+iG5njW1X5fbRc4Los3yb7fn3tut6?=
 =?iso-8859-1?Q?lKbBmLNw1a+jXyne0bCfxoEXNSHWn3MnL7WtpFUHq4xaAZijmeji3ju+2r?=
 =?iso-8859-1?Q?Ms9VrYV4bjkpLoDX5RP6bbYWZbSod7DLaYSV3aAzdc1XzmViN+o2qduWAt?=
 =?iso-8859-1?Q?dJuWyz8z9lxoaHsE3K4Bfd4QLvd8CeDKsVSM+zms/nQdx0EIdGKjFVHaa3?=
 =?iso-8859-1?Q?wK7YUOLvkEByzG4ILCsxcftoA7RoNpKNdXFyP6oPBcwrVcVq1CYYYxbZev?=
 =?iso-8859-1?Q?YTZTMxApT7KPeY+PXYaXIM70+5rJ6UkQAgocWvDTwMzLwK8WAthQ3IW86p?=
 =?iso-8859-1?Q?CguZ9Hwk3d+tclgcqmYRpj6xzkHFNK6HcV3b+qcH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K8wWWHlIKhyNeRKiEUTTtmmu45/rOpxv31IuAeHdpKao4kL6qguqbk2dQ3?=
 =?iso-8859-1?Q?PdhbHRjbtmEPnhHLURO9G8rSS0oGJrlSiwG8lmv/EJOw6cW4e83iWLAjuM?=
 =?iso-8859-1?Q?grbwkj7bJdAhT+uiye1m3qZkCpOm6Sscr8qADqVSIQXxFMZEL+s0G714E9?=
 =?iso-8859-1?Q?NY5zfoWcmv5Io33q8GORtaeyoKdKdTxqOT16BcVCP6H4MHlrBG9ix5zQ+4?=
 =?iso-8859-1?Q?BFatQrFD7sDLJXVRUXZM52LUuaoh3YSHaxTlmfC1b/ih8Y1aOuCDFcwIvf?=
 =?iso-8859-1?Q?dUvgukM5NTgkTkTjh/RM8/jape76JZc5vtstxTuMtZak9iDJT+/pSyxQNY?=
 =?iso-8859-1?Q?oq7O4nVdL+xRO+hwb/PCACnx02awqDRDTgGlF8bc/cL082aMj6QtFsTdil?=
 =?iso-8859-1?Q?0qD54edaB5TQM00SJGqPMRaokh0An4HQELnnDOjz0xp6ZktL++vwVKj0Ff?=
 =?iso-8859-1?Q?SbUoXNMud/tev1eZlMSs2mRtAtRmo2gE8JNBxvEf4SUGyBDpZSM703AvId?=
 =?iso-8859-1?Q?os4Wjx0oxCqn1zooHUAQY6rlQKZDOsrJKjXAxvvWAG78oCrgrLnUdseIjg?=
 =?iso-8859-1?Q?d8+LEzHrPopvOJA49jI/gdCQp4aROIcrKzZn0z08cvStXMP6IUXWI6augj?=
 =?iso-8859-1?Q?k6w3wq8pFeQ6ZwywwLCfF7BsjJ8C5LCh/HGxKw+5+B78kGUWfEOaxRnU0A?=
 =?iso-8859-1?Q?CEh+3f5LvS0rPdJKT8O9Lan6ct9fSm0dMyGOvc37T5EZAWbCUlUQ9M+0NW?=
 =?iso-8859-1?Q?GsMxROmrLft9+A+cxGTzh19O1CdU9Pa9dSYkUEP4Z8WLxqWCU6zLB7Qupf?=
 =?iso-8859-1?Q?8VXaV2G+TD9z/d8lNcEAaRHQRMhV/JKfRvVzP5+DkDsAUOcOPYqRp7IlRd?=
 =?iso-8859-1?Q?4TkxLfRkrr5fIvjAHp38BResOkaXH/bS46N/Q2z8Ny/8d8ptVWd/n3QmBY?=
 =?iso-8859-1?Q?Biii4bxI/i4qhR5c2ECepEtuLXLe5Qyu+6WUEvGlvX2ge5B9lkrwOugZCz?=
 =?iso-8859-1?Q?ycl+UK6Vm93/bH1WIhaswmgCZPvx/OaoOR6xk4zJqweBBIdwtleKJsmkhs?=
 =?iso-8859-1?Q?8cw6w1ROotf5yUF9j2e9YrnDUV+KwsA3nlNWEEMe7vyY+7+7w4C8DVc4lf?=
 =?iso-8859-1?Q?7bCl1u+itSaGs4NfEGpQX9oKQVHVkFWt6W9upwekQMB/ZNCa1kDMqO2q6J?=
 =?iso-8859-1?Q?adOrx1uJb4EGt4EGH9SOSsGbotu+KeLTVv1fnkWY4XdekutX80m/jTngIa?=
 =?iso-8859-1?Q?CtMcOaw68Wu7SDl8kLbvSIxY/7oNlAf1KPbZ4dzfXtAmovu6zJ8ZqzOB0Q?=
 =?iso-8859-1?Q?gNeYimpkmGYV0qa49srerJbHsf2KoWGyqqIDZVS8YCIc3YFfFAhr23ePUT?=
 =?iso-8859-1?Q?wn2oFtxTzn+Fum1D9I1uMelX5ywCrqYludxCd12wSr0cebE0DAxN5RkakF?=
 =?iso-8859-1?Q?CO8OEdOhyg9npwzxYLS1XVP8xTwDrBt/DJryZWHN9OkrjXT9C2b9fcxPYr?=
 =?iso-8859-1?Q?6E4tt5hmZsBSeA171eniSNydccCxDTegtK+UeRdu0ucJuxQfuaCM9LnTGt?=
 =?iso-8859-1?Q?cad9N05bnOP0d4pONvRdj4sDYUVDs0Y9GfrCXP3qDkLrhZPBUYd+frwTdW?=
 =?iso-8859-1?Q?BwxTytXbhzAGTYkj+FPFoG2tmZcG/uSHLxr5tIS+Ym1seCLsL5BN4OZ/IX?=
 =?iso-8859-1?Q?5uCP04JOFr2X/aRwW/+SpPniAEEHA7WxhLzW7XHWjetcWlougeov12D6HV?=
 =?iso-8859-1?Q?dqWbDewrlE8R1CtKjOCuOdvLj5McktJOVwurcViDv/EUqOIGaxXRFnRrt5?=
 =?iso-8859-1?Q?6inxh40mNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b3c41-7b27-444a-3e28-08de7371cf62
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:18.0794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjXPlHiBts7FPBOrwdZo1ItIvLesDD1/1Ro2DTsfsLW9AXF7FCHAxv1mUweapjiw6f9QE8sDhgqPxpBQYq3huv+kIxpSDaAT9RvkPM5Cc6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 37 ++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 34 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index d0054a7dbb..0f83189e67 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -389,18 +389,26 @@ Booting the ast2700fc machine=0A=
 AST2700 features four Cortex-A35 primary processors and two Cortex-M4 copr=
ocessors.=0A=
 **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary p=
rocessors,=0A=
 **ast2700fc** machine extends **ast2700-evb** by adding support for the tw=
o Cortex-M4 coprocessors.=0A=
+There are two methods to boot the ast2700fc machine.=0A=
+=0A=
+Manual boot using ``-device loader``:=0A=
+=0A=
+In this approach, users manually load firmware and assign entry points via=
 QEMU loader devices.=0A=
+By default, the PSP begins execution at address ``0x430000000``, the load =
address of the bl31=0A=
+firmware. The SSP and TSP start in the powered-off state and must be expli=
citly enabled by the=0A=
+PSP through writes to SCU registers.=0A=
 =0A=
 Steps to boot the AST2700fc machine:=0A=
 =0A=
-1. Ensure you have the following AST2700A1 binaries available in a directo=
ry=0A=
+1. Ensure you have the following AST2700 binaries available in a directory=
=0A=
 =0A=
  * u-boot-nodtb.bin=0A=
  * u-boot.dtb=0A=
  * bl31.bin=0A=
  * optee/tee-raw.bin=0A=
  * image-bmc=0A=
- * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)=0A=
- * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)=0A=
+ * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)=0A=
+ * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)=0A=
 =0A=
 2. Execute the following command to start ``ast2700fc`` machine:=0A=
 =0A=
@@ -410,6 +418,8 @@ Steps to boot the AST2700fc machine:=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
        -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42C000000,file=3D${IMGDIR}/z=
ephyr-aspeed-ssp.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42E000000,file=3D${IMGDIR}/z=
ephyr-aspeed-tsp.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -423,6 +433,27 @@ Steps to boot the AST2700fc machine:=0A=
        -snapshot \=0A=
        -S -nographic=0A=
 =0A=
+Boot using a virtual boot ROM (-bios):=0A=
+=0A=
+In this method, the virtual boot ROM (vbootrom) handles the full initializ=
ation sequence.=0A=
+It starts the PSP, which then enables the SSP and TSP by programming the a=
ppropriate SCU=0A=
+registers, following the hardware behavior.=0A=
+=0A=
+Execute the following command to start ``ast2700fc`` machine:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  IMGDIR=3Dast2700-default=0A=
+=0A=
+  $ qemu-system-aarch64 -M ast2700fc \=0A=
+      -bios ast27x0_bootrom.bin \=0A=
+      -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
+      -serial pty -serial pty -serial pty \=0A=
+      -snapshot \=0A=
+      -S -nographic=0A=
+=0A=
+Serial Console Redirection:=0A=
+=0A=
 After launching QEMU, serial devices will be automatically redirected.=0A=
 Example output:=0A=
 =0A=
-- =0A=
2.43.0=0A=

