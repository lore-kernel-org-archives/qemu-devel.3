Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9A5CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5S-0004hg-I3; Thu, 15 Oct 2026 02:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF5B-0004dp-RD; Thu, 15 Oct 2026 02:36:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0006Yc-OH; Thu, 15 Oct 2026 02:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wicTsXTg65iRFb7XzAxlhfyAXnyYFwSwvyJJwPS41Oi5cKn9whgN3vcwyaw680xrgp2l03AKVd5dMdk6U9b+yCCAFtLx+tfgd6b4IaRpFnOJA6nJCVDh6X6pg5XyWnOAEg/N6D8f1vZ6C/qWbNJcEM4igw9qDIgghDDpsoOn8VXQfoOm+wvGc5YjGmlhGDbHlV63SadvrHwLjBEU6PsiadeOzEC6btqUb5pdkpbMuVcHSpyi6wR9K5H5FjzBd++XI5k68CswBU8snvEsLKxJGBuxYLah04oE3sMLilaJfkzqEk/8bQcp53fpQTo6xWt62xCF6DK3m52lIMiS6sYlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPGcNVb47Sy/q7tUaeIYZbzOquMPcLYPjo/slemNbrk=;
 b=iFKTTRsiruAnr1GNr4aVMmZ/vsFI15MIBijUs7M4BrGLSHGkjiF9wNVx1dsFzDFOIRvXEvTnFLM56KI3KM4ce0ltT8TIeSAxp45oQK67wkWvWOvWlr9fb6CspcLE1zbLM24qTKsdzZcJCmt71yxG/hcoSXKQRaZ2j1RGz6VLVDdI2Cz6Qqh8sPDlwf+E1T+xKS7PmP++32I9Vwq3J9HffMDjk1n7k/koeDun7O5stC2C8rbIaFQSqKrnwKPvWMkjB+yoqp5+Xz1NiqOW7k37LzACLgv2DUKMxpYXVut8jgYfJPze2mRk4GT/gZw+DgLm0ni5R4hGGiA5o2yadH4oaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPGcNVb47Sy/q7tUaeIYZbzOquMPcLYPjo/slemNbrk=;
 b=h5OxXAK+RBCvauFu3Y4boxl9X8Ci9CSEYjnyzhHYMEfunEpy0CPJcHZotNQBzTKET095z5PvAgdPmunCCkPZVX5Kaky3e7g3bEVrM8OtSQIC9nfK5AlEYq9CaHkwiuExggjYVtkUxHIZyQMxKiVWjv8O9ajL1OubGypnaUDNeg9mLRsEbfjzCEIGKK238VgbZK7tolQEbM3o9qNqqoHVEVefONT/C+xnDoyiuzKJv3Rp0cdEPJ+mpV9u0xOrbT7NgU+Lv/8E3ehOwkMOnSz/n+KHUEfsZ0LoUeG7Sxhl3pw/EcXeMAvXPS0HCiEkYqYzXC2BjdkuJsPIqkLAueK+EA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5162.apcprd06.prod.outlook.com (2603:1096:4:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:37 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 6/9] hw/arm/aspeed_ast1040: Add AST1080 I2C filter as an
 unimplemented device
Thread-Topic: [PATCH v1 6/9] hw/arm/aspeed_ast1040: Add AST1080 I2C filter as
 an unimplemented device
Thread-Index: AQHdXG+EeN5oktoN40CCS9pLN0C+qA==
Date: Thu, 15 Oct 2026 06:36:32 +0000
Message-ID: <20261015063625.186708-7-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5162:EE_
x-ms-office365-filtering-correlation-id: 628bbc55-493e-4193-437d-08df2a86a928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|921020|261009223027099003|261009221227099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 27Bzklriud7U5YZX6gGkQb6XCwWNKS8KJcU8BqyhhNfWkg6NISx36mnhTOqND+SUja73dwtstIG5L5jcFjbjqtmQZYgSU95Ex4SzpaKjxJJiT7UVexBEPhECjX4ImqgFrbPZS7GaMH6tyPAOrvosW/li/Tmski695OwLFwaTG9tbSQqCkQLAVqrYc5KOyCKHHQLcw/8PPerY5HPPMLGnE6RFWDyGRcfgu54VXuY7LWdlAfenVhrRC0OQR6ClFLxss2V5eF8R/rnmcObJM+eteKlhW/0MJKsRoq9KDFmTzHBlrqKK6SxsQQd00zmIgqA38C671X64OkxlAECJoxiQqZWe3p8zHfacjMfDaHFwkhRkPaaZBQTztv8zQOwnsWvbkl99AGD+LSPfaOphafegYhDFq3chRTg5VicfDDEFtG4Ueu8aFi6BVvrSjH37bQnSZGMD3/nNV/gLeJE4nyW4V59Kl8QYKvzcrBcQtLOWHv8rVQTPgXPra8QXozMYfr/MKqSQOpKizZyvrrciAu5jtEkpRL9AUnQDkeZ8BCPAg7r/3LQVdGyNPqgHvsfTSV4QzmY7pW7Oy3oGMQuR3Z47YKxn7uwPA66PMa2V4Sms6nsAnCzV/lxP0tnhd+mcHMeGjtYY9fdKPwYoDHSRHap+RaB6lbNjRHT1GkC2kY3uV9YKCXnKFt4VbjSDdRorLNdcW/a+/0WP0S5v84OWYRWvbBszwIxE0C22AuWqoiOlJPc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(921020)(261009223027099003)(261009221227099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oxiv9HtLkMQ+TA87Cf/qCrvA59wlopLuV2wl0ovYv4c54vjNvO8TTpQaMU?=
 =?iso-8859-1?Q?XppKeXGqefIyVBDNLUO+QGLhMz4ygC6kq5AdwtntVj3WPr/bc2HcchSy5s?=
 =?iso-8859-1?Q?M82WvVaEeGjeud/7+dVUINIqTY5hZ6s2hMu5BKzaneHpPBXlgfo/1KvdTP?=
 =?iso-8859-1?Q?mZ0Qn9ScycNyoyosYa5sZNHsj0V11ifHajWANauRMTLtuyZZtCI5GRgXVb?=
 =?iso-8859-1?Q?oknzI+rIs4nWVhC6ZyWsmaaEFOVKboeKF+bDE38kSp1TRhhX7jGFncxThC?=
 =?iso-8859-1?Q?J/lijSEcJXm4attHpNd8aOwnLtVxzqttzQNv5mwC0wTBGtAWEelyoy04DW?=
 =?iso-8859-1?Q?DN4mREPZf7xm4zIaQO3MEvWm7Ug7zeDFtmK+gtDECQyOL2e1oQTYM4q1s9?=
 =?iso-8859-1?Q?NQZI+5hXEzWTFLzxgLtEpbcHAnvN7ZIh8Z4L3IN1JXNtznAFvP8B+c81iO?=
 =?iso-8859-1?Q?IeBREG8C2zfFxJrtCdd2tu17zEG8ertLJWNR8nybXwP4CR754sxfHN3la+?=
 =?iso-8859-1?Q?/n7Xy/hpkR7PKkSr/OVaudrjDsTZmx0I7zSUSr5CQyapKRTFLilsI4VxXd?=
 =?iso-8859-1?Q?Lr0oq3cUkrFvx4+gVqMo0XkZi7fYJdLYN7kAOCaWHTTW93OCWoNyuKXMgH?=
 =?iso-8859-1?Q?i7hqWmtsgKHVeYtul1qUpOmyOzUtX3YGzDH6DZuX3xCWUprrjioMaTrWtL?=
 =?iso-8859-1?Q?6iN0R/ioIcYkX0dQXIuoeXk4rmyrRXPDHWD2Y0X6Gmkv8/O1SFMxW1wZkF?=
 =?iso-8859-1?Q?b0fag3VCXaIUWkdktcnMCsoaosrITj58pfcDbsX/BfLTASqHOrZNnUA5Yf?=
 =?iso-8859-1?Q?gsks4Kk2VE4HJGcaAu4Xb2x58vf5hFrlQ8QiY7CNy7I/RPa66gl/CdNiHG?=
 =?iso-8859-1?Q?u7CHH6mMjy6FrNIKbnEHur15ywoI/D4Gnn4aRY15RzoZGIZ4qzumC61IMo?=
 =?iso-8859-1?Q?aKANy/fUGIdTS2Ps0ceuB8swaNbC6oxtco9645y3SPmBXWj0Gim876VIaC?=
 =?iso-8859-1?Q?hOHTUejz272sh0ah+COKLRITm0hW9h3Sp0PAzc1FBHwWmIVjKtEbbjZfXS?=
 =?iso-8859-1?Q?cFo1JYQSzFIZFYsJcUAU54Ja1JJfTZvURUKlF09Q86/UACuvT7SCS/tl9/?=
 =?iso-8859-1?Q?oXgce2DGOtNEHHa0KDPzn2m1+05SZrF0JXhCasSzA3LWMq+ouwATKohnga?=
 =?iso-8859-1?Q?0pbCb2b4RDMoXRbwPQVY7M1WcZCGwilKXn+zglabPtfG/TCwOm8FDqnDhK?=
 =?iso-8859-1?Q?lfDQ5cQnjOhHlxoHD+GG/6X6fmEf9m8Ewef72KuoX3VgXN61u9oVYby+7k?=
 =?iso-8859-1?Q?7SuxQ/IPLiaC12DRYsXpUAHgAb43kFu48SkXSYudYfAIlxMk9SubbLQqhN?=
 =?iso-8859-1?Q?yvN+N02PrS1Psa3wvD/2G3r/ZZmshL+27sAdBII8cjGGEqKD7uUtH18oCy?=
 =?iso-8859-1?Q?BB3f9+IVcqzh+YN3yPg/fqvLDclOop/t9HAumoAmTaKSvrFFLgOQwg0HRz?=
 =?iso-8859-1?Q?3wcm4b/NtK+rjo0IOqmlj7GHzev+XEFibOAHzVb0v7MGUatwdkpIG/7D5m?=
 =?iso-8859-1?Q?/Tj+y1M1AO+eR8BKCmUIMefyB9mIWr3KOP+VL+/B+s0AzjKdgaKWMptM/x?=
 =?iso-8859-1?Q?clhAfS+piZ2d9Ox1FsLxlx2C5Uj5DeEHj6y4dqgsXGnsWfs3oBn7f9qHiZ?=
 =?iso-8859-1?Q?M5UQSU+aI36NZevRkITabdiZhNaYd8VqlgpW57oGbcfz6QNShNwdenviyU?=
 =?iso-8859-1?Q?sHaDJIcpTgG+2mJ49w4blXHujbUu9KWls5uVwisNATpXYzpaFVZ+orXQGk?=
 =?iso-8859-1?Q?y2Wqykj5Uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vgsd3cyPlU+XtpjiGqtMDuPIIuWTtw9dHTVKqxHcZk1VCwu7yoVEuhFYY/aV5Z+8xBvsMkdrJLO4/0YZmWqqQ2r6VyznoHshR2XKvzNhdoAjGk8bKgMioLQXkQwMpOZszPjhDNXY12e2kpnKh7FejV4g88AG/ymUxmVUrEhQ2qAZHfqbZETIVmoYJq8lyRl0qeUw5SHJz/XuXh0TGc0HKks1VGv61gb4dfsKPfFAZQJBL3r4tu5rJdjBLgabJL1z0NfdAc2WMTu6FJEF60eZR+yc1irtyBbzMlyHihP19mfCVQ76uOQMO7zx5Y8GgPjUZcoD64JUMgc5kDKumEKERQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628bbc55-493e-4193-437d-08df2a86a928
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:32.8900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIIDlwZnyr4eXl+rcU2/BChOoIeHsHoAAV0Zs0jXIvEb7h1brNBzRbbVEacyaeNqJJUUSUKgi6XdWtoRYo8x5w5goAdgIZSUPf14l+quJwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5162
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

The AST1080 provides an SMBus Filter Controller (I2C filter) at=0A=
0x74c14000, but the controller is not modeled yet.=0A=
=0A=
This controller is only available on the AST1080. The AST1040 does not=0A=
have it, so it is added to the AST1080 specific init and realize=0A=
functions instead of the common AST10x0 G2 ones.=0A=
=0A=
Add the register region as an unimplemented device to reflect the=0A=
AST1080 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index e5c8d15dcb..56ef6b1268 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -102,6 +102,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast10=
40_unimp_devs[] =3D {=0A=
 };=0A=
 =0A=
 static const UnimplementedDeviceConfig aspeed_soc_ast1080_unimp_devs[] =3D=
 {=0A=
+    { "i2c-filter", "aspeed.i2c-filter", 0x74C14000, 0x1000, -1000 },=0A=
     { "spim0", "aspeed.spim0", 0x74C15000, 0x1000, -1000 },=0A=
     { "spim1", "aspeed.spim1", 0x74C16000, 0x1000, -1000 },=0A=
     { "spim2", "aspeed.spim2", 0x74C17000, 0x1000, -1000 },=0A=
-- =0A=
2.53.0=0A=

