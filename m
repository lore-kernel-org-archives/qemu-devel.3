Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09056CA5FF1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 02:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDY4H-0001vZ-Qw; Sun, 04 Oct 2026 22:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4F-0001vD-BK; Sun, 04 Oct 2026 22:04:40 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4D-00016h-MN; Sun, 04 Oct 2026 22:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/hNcPtiJqHb8DdfedWSaX0nzGHu9xhC5QqXz40u4OZLaNLNVQypAW0eEiyPqLS2VffSW3LIDxdZopFYWKWq2LuQWj/46BbvQPAkUG/on1VtRcX/fPsheZNAJCMBfi8aUfi5JputI6/w+gVMa8ZSCYjmjz4j+b6ore/0DCkDtTyvsf9owLCQHRjhpKQDikiR+2wsnXvm2m52GpEXaFj8gX5dysPelSmx7FFfeBxPMXaGYl6/Q+enRmzv25vPY45QeiIAvesSrnEX+VbEl3pqk/0oO26osKxp65PLsGEfBFV3b3CNL2jd2dOLz/TLpzsZKHws9tcmWE0PzEiT4zcRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8KGOJ+MzAOhBnIwOk71AywVflXDotEUqCxRt4EHmxA=;
 b=duVTqDYM2OdX3MH4l/OX1QpPLI7UUjQgOJiQj/NkTiRXifGWAeMnzhgtgQpd0+uFOfTUPGOba1ZujXt9xzRzgwnis67EveB3x/BH+y/kM0R7uGrX2g+TBRS8pLMh/c67amKpkLpsFJydL/S49pBuRh0UblUobQedoUkBXZHEyg4YKjVxGVwbvr7IyNA16Czt3bwAn/gx+XUJXPY1uf8VORG8hteppmp6i1k0Fsk9BB9g4kj+pOy263SGjZ7mtnZ8uc1NqiTNAfL6ZjE06xNk3h3wJZRhZ1CXU1ieupVs6N8juHxf2K0ql/QiOWa54EgDWaa6+dOxWOMX76V9tlts6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8KGOJ+MzAOhBnIwOk71AywVflXDotEUqCxRt4EHmxA=;
 b=dMifNpk7+Zqwi0VIuM7qAnUyDthgiJLvV9rGniDIMh6OAvtneQjpTVVzvu/74LrSRFdoua1Pedulw2rvLO74wqGTJffuyO62NIQxICcTKyhNyKok2XBg8V6w1wWtakbLLOoFLU1orYxucJn4m63XnaYkJhn2HLLRILHcyy3bgkz7jRe+bYldOM7d169h4nl79W+vSXxXOF6Ue4gAFxdFhR3utrZb69C3yv5AP3+teybDIizR4GEoo9cDGV5jL88PXxw8mE4uiQ6ZaBvVCfwluFXaoW2KycyAzQA5Tdt3amJtaBOOyf/Y7Nnqvmqhc/mKKMzw2gocsKV23luPpqhZtA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5833.apcprd06.prod.outlook.com (2603:1096:400:32d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 02:04:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 02:04:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO expander test
Thread-Topic: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO
 expander test
Thread-Index: AQHdVG3aam/kyjNjPU6o7ye/dCCf4Q==
Date: Mon, 5 Oct 2026 02:04:28 +0000
Message-ID: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5833:EE_
x-ms-office365-filtering-correlation-id: 86da24e1-655c-4e78-759c-08df2284fd4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: bCPOn8jIf+FLyY82YsLmHFbBV8pUhnpvl970NhIuaKdRrOt0eNRV38UMSYbVF/5rs0iVXEYQ3uzKL33ZIQAJicOZhUMaJCG2c60rxYhvEgj2KCfj8DVLxht5J8t9w+bsSczh0YHb0IzS9U+OobDCKLXk7eoPkS/LGgGWVTqbYl/9b4PhtrByM2IXil+DpujsOh9gPuDb2F8zviuGx5rQpuerBrwACrGf/bmnX1e0vb0VY1KDbgFywcyGqADWHR/0vASO6nqtQbP6tCO18sMMTvOGF/U/BQpXosCjazj68Pk20d1KFV3l6RgY6SXEX1vcPvInPg6JJYkPSm8nYit5zqK0YOG+/2e4zrFM7wrkvPN5gw7hNMEt54Q5rZGy2bLnoi8qAkMzkHInFAFimavpk2oXzfqRNdgMUjloCM0/ac7yRJmDDoDZeBcRNIVJLMhfZ9HIpPO2zs/v5EbZiuPckaQzbD9ZxBpGsEvhjJ40MigQGm4OeL2PbpP/zSBs0GaAvzI6+RIJ/tfGV7MRSkwWfXMPl69hRx+LH9jfIvE50XMirFRVV00KhdpGoBujynSGtrzPLUjS8qATSNI/KqB28zdFX1yioltJWkF5TTV342PsAjbp0O6T9YJB2ToxPeKu6DXofGx3VYJE/vs8Ic+F3a67anBh2THwHN37yploYv3Tly7ReWmvAH6CLX8bxYTUDa6rKqENd/vVYI1kr3+mvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AYxoBatAbevrEj6XpxHdG1k5ZHiZx0+tp75l676iBrk5w/ODNRXaFXhkaJ?=
 =?iso-8859-1?Q?+ld+lpzCp1Wdtj44tts4CZVjhjLKb5ihlY3nfQEYBAegbIehehTG3QFIcH?=
 =?iso-8859-1?Q?k+z9ZKHA+vN+7aMiQU4UWBtRejqBLr9HsSVznom+49740FKKt5VGYn7raX?=
 =?iso-8859-1?Q?S25BhH4o87jsBPqoHHK/PGM3AieHSaXL/nCbmWQpTA3WNNleJr+OQMGaMl?=
 =?iso-8859-1?Q?FnIRN8AOSM9nftH/F46ahDRvL4AtuzlW+n5fQWAYNMq6g0DJAwHBkxvNGk?=
 =?iso-8859-1?Q?YPuA1enhZ048kfW064LIVvKFLRg4EZHeGcuhmi8WqaNIII2TFvP5sjEkdo?=
 =?iso-8859-1?Q?EtfU0dZuDv0QnU5+agpj1NpfGO0IAfx08FPXEWJNBGtSzw3P0X3opMgvGm?=
 =?iso-8859-1?Q?9GgR15J0DrXIUOh4qcnFXKKncM2Ast/8P59owfh1ABBG7iEm/fRIRSIhU9?=
 =?iso-8859-1?Q?l8RKoRJiuXEAVtYZnmk1VwSAXe4ssdWn+BixKODJBzh0mJv+YpeaNCEzwR?=
 =?iso-8859-1?Q?mFI6E6u3JQVWqaoOq/0wmp7bFQzZx8Hkq0uai6Ah7wNC9jj+8YGQliPLKO?=
 =?iso-8859-1?Q?8jXtYwrjEfPT8rXcaScZmDRwR+XKRGBylh9XwyJbq1holNu++AAfqVbEd2?=
 =?iso-8859-1?Q?rf/iZbG9LO91O97rmf0B7rgfLxvfsBUg7b+icFU+ygjb8ZEjbi5ksFgGAY?=
 =?iso-8859-1?Q?ujCn7A9VJEIIBZs0ozrp8aXE6WVui5/gqdFL/2YkjGTw+PtTUIP45Z87dD?=
 =?iso-8859-1?Q?b3qTH4KOPVG6jlL4NAlAntq665hiL8oosRmeqaUAFqEee8IpV5uZvQk3lb?=
 =?iso-8859-1?Q?dMGqAyp/6DkJB5dHWkf/ReFrDmQCLi3MYGpmv14WefaTXYau7+EmVPbkrr?=
 =?iso-8859-1?Q?vmfaRlb4JGtv0Uv2afxmW1Q/Jg8t5qkLagcbZHtZuCHU82XQEj0lw+w0TG?=
 =?iso-8859-1?Q?N2Q8e0QTS3EzPcnSAvQe/UCO9fBJqbGubR9jR8CPUWvdqB2GJssDLJWeEH?=
 =?iso-8859-1?Q?b5DHNoT1U5DgQ/NEMJfJ7T+rXT0Zo1Gd1e31vTsI8CvApIEjvnAdzR/dZK?=
 =?iso-8859-1?Q?F0bv3spxxTDlzt5H7GsscRzL3QbWdY+nxcrxPNcNFZRpgQagdNXzzENMT0?=
 =?iso-8859-1?Q?QFdd65EwWJ48OrQdMhdpcdnXoWl9XbFh79pbUnuVjhdHNhLc4fogQUAE8k?=
 =?iso-8859-1?Q?pbI0eIDAUpp38vYDHsbSYUl72O5uOohh1SMXDvREMq9KpiT74T2HRUdHAB?=
 =?iso-8859-1?Q?LYDYlJarRZ+Gebmlkh1/4ouq5OcR2XHrnlkB1rzACn1KKf/vXXM4RSeaga?=
 =?iso-8859-1?Q?9HVfhPpQf2zFyYTcMLtb5XmTNcbROROQryk8m1shTEruvd/y7AviCDbTA4?=
 =?iso-8859-1?Q?zB6paLFhTN8TTWM2scDLnNFqplS1bgadW4vzOmodYMV6Y6H+DKLj0O2GOc?=
 =?iso-8859-1?Q?0lXJeSKshhG5wVcLO/SaZuFs671zsxXVP6i2S5wLMp3X0owj89tckPnP3a?=
 =?iso-8859-1?Q?p66dicOh4+LwMMSrHDoLbvpkGh3vlN3Bi8feeomRF4wR0b1mj7Iw46s7DZ?=
 =?iso-8859-1?Q?FXEvJkOLqDqIrzSBMEz7aymq5NAcyEZ928M9fMgmBK2cNA/YFWT4y6LlsU?=
 =?iso-8859-1?Q?ShGggg7rYuvnbNN+q1VeNg+1hx/EMtlSShJYssGYZZmRT9xr9Z/a7lLpzS?=
 =?iso-8859-1?Q?jOg1PDAT3xqmsK/w2qeJVMr5uPEZ2zbzshJqKwq1ZIB1Lp/z3n4e1rQCoF?=
 =?iso-8859-1?Q?yw9qXAqf+jaY/IfMzhxThIFrjokuqqG1LPTsg9LKiKIqfJ5nSoYMQRGtVp?=
 =?iso-8859-1?Q?KdfjORkxIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QGrgqZ/mXhiqGMiKQX9/q+zPf/Dl3HQ/mAK1dl4VYs2eNnIYwbYygyToLVOGln/gAAXOtNBrMv/FvW5882UgwOkhiEe0H5a6905iSAU5yAACFSo4cHNfRHsKxJqBgeGYmgpjuG6zoLWWMxNzSglVXtjdMtTZU2g9ziSS0WFckIAlw6OLAFxBN1Y4CCrDUHhcNhmyiWfGdctL/9i01E4mpdpGGSNYiag3bfSfNNzfZS2cyQIcCLQF6nyhzPeWJOzbzbCIACdRxUfn5z9NqlcnDo9Adn1Jd0XtWh3FRUZrpg5rCLgToZ4njT7sVfoDy2mw+5cV0zffVbczu7a7aSd0Gw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86da24e1-655c-4e78-759c-08df2284fd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 02:04:29.0391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvtnnp7TFt4uYpRhkGLC5QFMou52wmd/Cnt81r3F+tTz1nR2kJojtM5UqTJMRuDitnvIs/RzRI8+IA4gqIKoGKfiP2yMwz8NlBbo09Ba/+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5833
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This series is split out from "[PATCH v1 0/11] hw/arm/aspeed: Use=0A=
unimp array and table for unimplemented devices" to make the changes=0A=
easier to review.=0A=
=0A=
v1=0A=
 1. sorts the ASPEED device IDs alphabetically.=0A=
=0A=
v2=0A=
 1. Split the device ID sorting change out into a separate series.=0A=
 2. Fix the IO expander device IDs in the correct order.=0A=
 3. Add a functional test for IO Expander 1 I2C.=0A=
=0A=
Jamin Lin (2):=0A=
  hw/arm/aspeed: Sort device IDs alphabetically=0A=
  tests/functional/aarch64/test_aspeed_ast2700a2: Add I2C test for IO=0A=
    expander 1=0A=
=0A=
 include/hw/arm/aspeed_soc.h                   | 176 +++++++++---------=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   3 +=0A=
 2 files changed, 91 insertions(+), 88 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

