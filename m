Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2100CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5p-0004tI-Kz; Thu, 15 Oct 2026 02:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5B-0004dq-TZ; Thu, 15 Oct 2026 02:36:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF53-0006Yi-38; Thu, 15 Oct 2026 02:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWyahopojccBsa48z7A9ZI0OpT/cacdT2idh/0daq6kB38G4Y68xlL3da9UlXezTgsmoQ02EsyOp0F00hTTKnlY41mTWH9VIYKe/s0JU+IyUazKtA+G8P3GAzjaLsK+epSBVAhy/0lEyTvSBSxoJOf1y9ob+fz23/mjN+r0ZuetotirqRoN10slcz9R9/3Y6e1+jVj09WdbIJj7MCtDd5JCKgy8Zsrnk0yoLQKHvd4CK0KqqsPffkIcahIWdXdZKMNxrHaxA+xRGndImXIjeNSkC3IaeycfonCQRWIPtqpCWxEBZEV93RSxyQQmrclfLf/W8H4jztsGYU6l7wIUxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6G8SDkmdU+7L6pECbPIS6iLOI5wMGOWOwUzPRadnmg=;
 b=hu1L8sFiuchGfftztL5PbtTwywj5ENlz9BOh9B3jmW+lMggnAb4XHJNuMYCgUeACZhXxt9ZXBpJ9INREuj0En3EumWv0DTFQsY0jE7D43PwA0cTkrleXyXsewV23OqANyQuMzFx2sYZqmA9fPkhD3VOeNmWm5XAnWC1DEGN8N4+C1cG432CCt0x7ne1fTXWBjQ0+/rVdBWnCHLcVio17Xaju4LiF2v4GcaYVjtNXKxrEU47nF4aNjwNHwmeXgi6d7/S3PMnZPv1GvLDG1aztTdb9EvmBcIk237Sp9YoaqC2BtL+ZOvdkD6nei1Rij+dOvm9mpY1sSyqOMqjC6cVQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6G8SDkmdU+7L6pECbPIS6iLOI5wMGOWOwUzPRadnmg=;
 b=RIEzuU4W4LFMBQ7dW+I4LBRqMFbMsBIrcMtZ0h0eCda4pWmi3gZV/lkfM25hv8OZI/lCTGIdaVvrgsm8BBHH28ZCDk9S35ftwbBhhzYyAi3Zy++lJwmZF2iBNlOs2xXboSqqQO40gvDFnloJOhzVA2+sfZ3AuX++mOZJveHtypasYPc2hW/KVxoI6oG2nq169Xrl6WhuZ1HweyjdhuDJlXNEGZ4krcSj+Ma+Zgs6DQS6mNOylFNilAu2TjUTR6L9r41FP4CeQm4O34ndTQ7uqB0o0anza8/RlO81YhPoi+TJPnia/MVxRT4yZ42VkPIjwEqY3HRpjcWX4KODJtTvYA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6967.apcprd06.prod.outlook.com (2603:1096:990:6c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:39 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 9/9] docs/system/arm/aspeed: Add AST1080 Platform Root of
 Trust evaluation board
Thread-Topic: [PATCH v1 9/9] docs/system/arm/aspeed: Add AST1080 Platform Root
 of Trust evaluation board
Thread-Index: AQHdXG+Gi2wbtpmd3ki5GGvAJIyiUg==
Date: Thu, 15 Oct 2026 06:36:36 +0000
Message-ID: <20261015063625.186708-10-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6967:EE_
x-ms-office365-filtering-correlation-id: c4ac82f3-d5f7-4d18-ec1b-08df2a86aacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|921020|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: nSgoy88+DtHwaGR927ZHsA+nyPUhE4aTRuY5d2L9n4Pn2SXcFirKwlByjUSwkB/xXrEQzSo3P0ke/gg98K4r1pdVbVBOly3O6oN/y5bIIKOijZodTq9khnUp2GnYMBhNLmD3/HAzJev3xMEz1AcYuIgEkxDMV/B09mLBV2ctd0i3qNnsKdl8ciXKbWJfl5I44FmwENI3wBoEURd/hyDeD/P5G+L9jAwPJVp2B/vw2auVqwlmxEbqe1jB/N+3in0OPKnSWw5hOhcuMY+znISL0sRXM5M2kNy/31CY0h+s18Xl8ewEnx1MYk3RJa1gAz8kYlTeF2RGbg0uoy5jAFf6rUWp/Ywl4ISGNnWrpk99m98I4oyCUfPKEdep8SaWd8wtRIU8JQ8LqpBGxgmDQPVlt43ZhHovu9TxxUbkg48XhonsLyS3h4knYrRTKiZ9d8z/39neDyBfoVHymgTLxTGJiSIcotnX2jPfCsd0NkMNzGcOWK/dR18JJNdFL4iW4WXe9cko/pVjB8cwa4bN4fHddYJDewrQoZqVYQu/HBgW7MBj7CV9aX+vdOYEZRuzr1WZ18bdcMWMfqxcAwWynsxaejnoQKkG24B9biWwOCNv5/o2V4uMRoAfWl9ipRcOttR4isnE3+Q91q6KLCoj2P4MdxC0IDU/QqCayUb5rcWrWs6einE8Cb4IzSpszB5jOcVSaJmOTqps12d7nSxK4sb81JORC0ynb96fjiCKw8Hp6QQIukan0DjlkoeXJSoBO8YW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(921020)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OgtzYJDVDBYkyTUxV4vxFMTJopGSMN6cqFKEH8oU8y6mQG5u882swfRny1?=
 =?iso-8859-1?Q?0DEbadTR6z1dgZVfRfIS8Hm3ZKZGUsqmLe1uh8+Ds58CY80U8f9mZ+x1eA?=
 =?iso-8859-1?Q?qsBckfpDFZpy3HpNYTY1UnwqNQrelPqK5hQsKipZHzmqTq1DhBhLUr5D/W?=
 =?iso-8859-1?Q?JRWAI1rM/xhpSSglewF5oHbj6VObjYFlLR0wXTGzUZqRoq8Vw6sEs7kCDb?=
 =?iso-8859-1?Q?bYvEHBXwstjDT49DBk5yPpElsrxGJ9HOrsuCf8m9I5nREdd7ANLCvrZCEB?=
 =?iso-8859-1?Q?b3VrTWyYknLaOJ0eEZNKo+9Kq5P4teM2MmI6n94ujjpM9jNpohnWkKtWNN?=
 =?iso-8859-1?Q?ZTm6eC5ynVnRAvAR2GOxOLOyHizrLrcgndUyo0y75RXGignkBj8UtDU485?=
 =?iso-8859-1?Q?aWLDcoLtp4UbiBMIbmqm/e1jsrJlNChhA9qHv580gJP2j+rM3VzW19zyYY?=
 =?iso-8859-1?Q?VyAiFwfCE5SCQj8o0LYvVmUTYLkD66otv+xaxrJqkEDriKiU97GUU2LoZF?=
 =?iso-8859-1?Q?F08QK6WFZPemUN6mOoarhkTkVpxfF77gn79rS7Ffeulqc/sTYmkUoQ+uAp?=
 =?iso-8859-1?Q?S1HSHFJaGACpxwd57gYjqdiU6XoDcU3lipoc+pkulCcEYDUGsrYzPBqMK9?=
 =?iso-8859-1?Q?sfmLI7jmpnInP/dHN5A/97Vd3Xbg5IozyX53rZA59nTL663mR7UmjHwFW7?=
 =?iso-8859-1?Q?EASgUCJso9ZCNtpbBzNFQ59pr0CUNH0S8OCCg3zyya7xLAGuCKn+uZ4FU7?=
 =?iso-8859-1?Q?+YapSW0J4TGpAtwrU3sv4+ORP5/WAUpYqchuAQGGUUSK+Oi6khHg7IteAN?=
 =?iso-8859-1?Q?ZoS5DeO1PUXMN8qso8z9uAkcJ5mIfE81CA/4HvLesnQkLCFeV8ZoCnCS1a?=
 =?iso-8859-1?Q?8gWyPXYsmi93tjkW0pnvRwdpEtF4wTyHgwdsoz9PRKFPWAL/I7tlL/Ja6z?=
 =?iso-8859-1?Q?J/dzM9CsSbdmrNSxUJrl8EYmhR2hRQ/4hNz9hTyZv/tR8fN3xvaOP67ysx?=
 =?iso-8859-1?Q?MmZ3lTqmC0bqvmpep7Q1GiVM5AwGf2t7sVonILLcrIAFBH1JB+/2KGj23n?=
 =?iso-8859-1?Q?UNK6hP+6SNOdMQCAANEZ9L4tDBfvKLP7USzYq6b4ilaBD6KgWNq9NfEVZF?=
 =?iso-8859-1?Q?pFQPNbXTp6sdvW+i2dNZImBd/R5Fd0zxENnKeLwIZSINr3pxfo/6s9Rtq0?=
 =?iso-8859-1?Q?INHvWCRR9+9VfKEONgxeS/zk6ZESnquTTei9MFgaKo8eEcXM08kBR9UM8Z?=
 =?iso-8859-1?Q?ooQ2YQ8F3PGfy9dvuqVFUR3OQMYD7MQk1321aCCsPQLDofzmyH43w9dLC4?=
 =?iso-8859-1?Q?BcL7lmn1CodEkcffAUcZC0oYFVTIIcEec1RWikM5iDpu2YUb1TK7TBpKN/?=
 =?iso-8859-1?Q?rWlXpw36MctpMfee5vyqAcOw5XEPPvuFtTW++MdQtCyNTyZYa98ME0+n4t?=
 =?iso-8859-1?Q?qA01N0b8DoRzXvOBTVC95T3PcFiiX7DktHwXP5kROn+qKNh2repU2bYMG5?=
 =?iso-8859-1?Q?ituupfvmgJBwXWdc4OvFafljVKX+6MFTVXxB4P42qYMoAbfKFjt9X7XYCl?=
 =?iso-8859-1?Q?/UrJhbkbY8O2nTick01dJu3L5NagVsbcYcdREhBzN0QhT1KUzz8iWg9G/o?=
 =?iso-8859-1?Q?VBiAo9kSFknsgut4lgBqyavhZBH6LGnqWRBH2tPEOq4qCRoEd72so9zrD2?=
 =?iso-8859-1?Q?BJ0Crt1QyUbs/S7FYqORo70NegJcZptpWqQw51PyORW+Ql7KNvNggH4m25?=
 =?iso-8859-1?Q?wwAvlfCOO9rO5NpfJH0JtsmC9DGNrhwSLClI3MYy1B5YYM6spQZ3vdPEsE?=
 =?iso-8859-1?Q?wZIVhEh1bA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QLWPYYs8rMhJ9vAFmctLZxiPWlpEyPdeIic6/GKNhkEW4dOWbTxokoTmUadf2K6IPr5c8w5OcEiUIJGc5InT6/vzdCIhbN90iYazhETMLVq19bf9fav5Av7xY98DAAxiPlLXqk6HIOJNJeip8zkcHFrsHu8VGI6zwsq/lnTBaifDv9u1Xl5CUwbifPiF5joswAZ8qd6r32Ia7cKHr89FXtOCXKB2Y3wvKbBGwt41B2ngiw5qX3gRfURfOMKVcSQVBlvuW54fLaHQoAdMhJiZTO1FYzS5zD/z2Ux8R54Saso/+dXZVcT56kuxp+rdXT8Enw80BZU+1pevVDZ/8Z7C6w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ac82f3-d5f7-4d18-ec1b-08df2a86aacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:36.0734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suZmKCngIR+Ebm+BGQvSnQumEH3z1DitSNJT2jAkFb1KGVt2S3kN5hMFsaFEbLhJt9zq/g2iiS1xIVJSsDLpiy4cUL1v+ZwjjcQCEtfgEuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6967
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

Update the Aspeed AST10x0 documentation to include the AST1080=0A=
evaluation board.=0A=
=0A=
The documentation now describes:=0A=
- AST1080 as a Platform Root of Trust processor=0A=
- AST1080 Cortex-M4F CPU frequency running at 400 MHz=0A=
=0A=
Also add the ast1080-evb machine entry to the supported AST10x0 SoC=0A=
based machine list.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 8 +++++---=0A=
 1 file changed, 5 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2d51ceeb84..be74ee39fa 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -441,8 +441,8 @@ Use ``tio`` or another terminal emulator to connect to =
the consoles:=0A=
    $ tio /dev/pts/57=0A=
 =0A=
 =0A=
-Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast=
1030-evb``, ``ast1040-evb``, ``ast1060-evb``)=0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+Aspeed Bridge IC and Platform Root of Trust processor family boards (``ast=
1030-evb``, ``ast1040-evb``, ``ast1060-evb``, ``ast1080-evb``)=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 The QEMU Aspeed machines model Bridge ICs and Platform Root of Trust proce=
ssors=0A=
 of various Aspeed evaluation boards. They are based on different members o=
f=0A=
@@ -451,9 +451,10 @@ the Aspeed AST10x0 SoC family:=0A=
 - AST1030 : Bridge IC=0A=
 - AST1040 : Bridge IC=0A=
 - AST1060 : Platform Root of Trust processor=0A=
+- AST1080 : Platform Root of Trust processor=0A=
 =0A=
 The AST1030 and AST1060 integrate an Arm Cortex-M4F CPU running at 200 MHz=
.=0A=
-The AST1040 integrates an Arm Cortex-M4F CPU running at 400 MHz.=0A=
+The AST1040 and AST1080 integrate an Arm Cortex-M4F CPU running at 400 MHz=
.=0A=
 =0A=
 The SoC comes with SRAM, SPI, I2C, etc.=0A=
 =0A=
@@ -462,6 +463,7 @@ AST10x0 SoC based machines :=0A=
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)=0A=
 - ``ast1040-evb``          Aspeed AST1040 Evaluation board (Cortex-M4F)=0A=
 - ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)=0A=
+- ``ast1080-evb``          Aspeed AST1080 Evaluation board (Cortex-M4F)=0A=
 =0A=
 Supported devices=0A=
 -----------------=0A=
-- =0A=
2.53.0=0A=

