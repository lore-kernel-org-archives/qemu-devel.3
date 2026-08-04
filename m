Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEA6C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrANp-0004r3-D7; Tue, 04 Aug 2026 04:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANh-0004q3-1y; Tue, 04 Aug 2026 04:20:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANe-0007Xk-Nd; Tue, 04 Aug 2026 04:20:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPYVrrdoS1s82I8mEsYvAOYiig21uWP6fzgh7pBdN47X8z6FBsg9+PndKSWQWwJD8nw8ZS/FUaJ+cPL+iii7lZZV/nw7OuyF/m9jkmAxE2PCjfSgwfbyJptyAp2qP7UrW+F6D3v6MU6VVkGvRMs9VACDt/SeS2ce4+Csreg/PDcpo+loA9r6bfeNKyJjunRzVVAm6aSVEr89csRT52mZ+oU34R+mqDjX9wtT2XouilKVtPjGKyZExuK7DXPWhp0CGQHe0tZaBjN3IUQzeFpCD+mbnS6fqgGM1xidszLilVXFtFXMnMitAGsp3GXPvyg6fW9s7XZnCPcXu1UqpQbA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoWl1cu8zxDwGWuGUWRCeTqB6/mtWvXFbZZSK090344=;
 b=RNVJTmA+SGFWiZNtoenwSGauzz20OsHmASb1uLYWMQSxegYYxK3nIDYE05lI45XqRzEEHQLElgtjzRdlI1+/gLDTFv3fGBTou0vLNTuX49sXoRQxxxeBVXtqiaed+4qqLlmpWf6qoAm3On9g0N5bwv8gr1Pg0hLcHKliwa72DnaG9dYORcx2sa++hO9SImDYBnKn6iSkFRdPhxWLHRIH+ZtXNTHqx1xIMor8oUHpNZ8Sdgr38yWISK8y6lMN41RJyPhxzfa/9l1/M+SMWav4eCoZCkL3B50CwLXTwOh8Rf8vq/N08s9op48b7+tQE4SBZuRJ0jwC/tbVTGH5bEUv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoWl1cu8zxDwGWuGUWRCeTqB6/mtWvXFbZZSK090344=;
 b=nhOgwTAyQ6GA0FY3DvYOOaRAeOMfSyq5cYLcYBn4OsvhhSCZc8hv/aCEeuYAMem8AE15WIeCFO3m1oLtPhkpRMgMVK+nnoQ0dQwgJF6Jg8ErasijnADq6QQmq3Tpp3PbrwwAd2VS65KdJpt5vDEapokL5Tcnp002KBdLqj+Prw/fcOXDsGgii8bFCWOkV4dHgcoadF40OCpjyMg5IyOO7mjSu0Uaq+TahF7QWw2vzePjkcZNJgI+LuDSt6Gq2sg82CN/p/VnWEpZY+CZjVbKdof0S1quCY+IvZLUISIo6Z5SGfrcDQVVUhh5j36M3jaZmGLK124g/5V+wTUQ2NF8qA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:19:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:19:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/8] tests/functional/arm/test_aspeed: Update ASPEED SDK
 v11.03
Thread-Topic: [PATCH v1 0/8] tests/functional/arm/test_aspeed: Update ASPEED
 SDK v11.03
Thread-Index: AQHdI+oIv3lyz55ZCECVNzMU0Gidjg==
Date: Tue, 4 Aug 2026 08:19:56 +0000
Message-ID: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: 0f4a3701-6bbf-48e7-bfd5-08def2012b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: BOJHD47KpreHkXQFJLkMzD3gAHqFG6+ntOCb+4AzDBPEx+wKd8oTL1bABFUQZI+msbKdY1L978wAkAAJbYJlkYa9/yl8DRM5pxP2EhP2w7RgzYEqsK/aeQzNS3Mo5GAzWZsWopPA1QE1X5WveHRU7md7ptwgmExq3fqTdnw40b8fJpx1SG+R0onQNp72g0ESrN5rF6daG/HkMxebV7nNUZ3LF4Hp8KIXCZLiNrtCTFe1+a2OmWZXbR58WfKEXNAIl6JeTM7BoigX7atG6awyEfInqPxJhtTpnQRFC71JJwu193LJ2ob2P/4C0v/a1WFRPC9B7pDnPHWYUd5JNKLvafRMNsKUh6JU5FKMutkSTbzaPq+nQFe5Z8J4QNVxbTYCWm0NhMY9g3dw80RQVnMLGeQJIO91mBCCAfy2uh67tTry2lgomeA/+2FYb+FjHSGfA2/AxZrtnR3TKGRrV+z4qLhjFU/CJK5dcc+kvn6UUNCKJqWHZgB1lHSkBfPUMOwDwqr9m33XjuNSR6YJkEVABZsdLba4gzXBsg6d1rABMKc93nt7GsBuJN3DoIYspNZTq9VcEoqWWaQBiZHc05mSBfjzXpjU46D28ub5T3ZcuJjp/te91ya7kc41qQp4oJGENsdsQCeNil5lx6FlWw1IAEJdu2DmJgLbSYaOeLb/UO7IYkzH7DVFp/5Lomio85QLy4TSEycgwI/g1ZjlgSMwP/OD4zfUJl6LYiCf5BHtOR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P6dBdogAPDNeBNjOqfQsPov4CTmyupYNcBjg2/fTO4vb81Go4uAMmkZFLA?=
 =?iso-8859-1?Q?oHcRO2b3AALWzF4bTCjENL6apb3ou0PBsxiWIs2mdNG4N1VTTB8pSd5tLe?=
 =?iso-8859-1?Q?LuRskDoByVnfI0yPQbrQ83Q/FWgjKMMqYcCvlII5Ztj1cPyS/RhuLBgQMW?=
 =?iso-8859-1?Q?niH5WOgbtELc9+1I7jyH930tfHC17Eayo+iLTxpdfTpRj7EgGBTqBF6WPD?=
 =?iso-8859-1?Q?K5kZ6tN5PIaBPoGcIwhC7RnlpPl1XM5P++9gzCePPBTcl46XkwFbDCtIc0?=
 =?iso-8859-1?Q?ER0ojoq86J+CXYUJEIAUZN99NRzKWUybC60DhQfI8YvQdcK28EZ/+TBi7i?=
 =?iso-8859-1?Q?DnTpICQJfQ1knDx/RBDvc9G59OETWhxFqwWc1aQI5Ckn2146cCaKQHu0yO?=
 =?iso-8859-1?Q?3zlCYf0S2N2ck/pF/rTBLiCOct5XMuIiq6F4xCRr4Vbz7o9VXQ9WkXzJIw?=
 =?iso-8859-1?Q?p66e7ZM7aZtygah9Te/r27mPG3r0rkoo9WSGg3hAbBgfGhDTotOqwOfZgD?=
 =?iso-8859-1?Q?qY2r5ffdl89iQ6LTTLpE5yOhdb0OJXkWESTvUy8xz5cjRRajIkn3uHoHv2?=
 =?iso-8859-1?Q?XfeIv2/QFR99LBOkqK8moLKO0SIBZoJVo8gDY3JHV+yWn2M+2EyU/9ppel?=
 =?iso-8859-1?Q?FglETUcny/qQQePZJO/UsRtaQEV4cjK5f/e3qE3aeNI06v2Lq8D6zWBKIa?=
 =?iso-8859-1?Q?igx0v/rFrx2GOPE+WhiPZuV+oI7G6duCEXk+TqrvQUsz8xisU+Q1fGTSTa?=
 =?iso-8859-1?Q?z37LeW3Gh9imwZR6R6yKK/bRXSCAVTrVNTIilBu9P/UgwwPixdavlLVS/D?=
 =?iso-8859-1?Q?dASkzCk73mQT/AUEfSs9+kQDA1fOiyOGHpgtC6ryN74FFOl/Gs/AD3d5SX?=
 =?iso-8859-1?Q?fWiKvJEnfIk6W7kqLrAxTRMm0f6VPLCCEmTlL5vRYF6vNa6Thkl2mrUsQM?=
 =?iso-8859-1?Q?niVxxQk4qkHxSrM5HhLOUTsUG0f1N/D28GR5tJ3WtZlr+oOOHNdhoZtkaZ?=
 =?iso-8859-1?Q?P8PTkkbRHEw2oK4NnM91m66Efj7CW8ecSjXyxmqPqjK10GTX9m8nuRhyOG?=
 =?iso-8859-1?Q?OWj6CKGUfQt3+7w1FVMkx+GRM7hQSDLBs9UrbjcEoK3n64bBkdU7pt5Lk6?=
 =?iso-8859-1?Q?mmy3d7O2G1BSn6sTSlQVRpaJRvckwRPys39baVUEUAQvnT7kkf6nzX6TFG?=
 =?iso-8859-1?Q?5Co6seXy59ucMlodhxdLKUWzLutsMjTkJA4JltmhFGGfGxTLMbXBMMFKD5?=
 =?iso-8859-1?Q?HMitCDuz1jNjxzAH3G8z/AvIE1qxjuQ65Y7zOs7QTP4W7FhF6izu3st3xX?=
 =?iso-8859-1?Q?4J1g1l8L2Hev7PUDldBmEvbLumV8xSBoY/f3uQ1yLR3bzjv77rp42hvqJX?=
 =?iso-8859-1?Q?9zK4e3OXcw1fV+v1KuMtpAU+QUaU7fH1aDc3csqOMp4AluMvQoF4XLyLoG?=
 =?iso-8859-1?Q?dhgNHCO8mmtIPYLiDN2JMNJOKFn3JT9MpFp6o6pkwdLe38UiI6SBF8P2DR?=
 =?iso-8859-1?Q?FqLDuqTnjOm5G2NEMmUFiRCyJWzsPSZ53gwhGWugOL8/opkVVbIk588hmF?=
 =?iso-8859-1?Q?QyCVthqyIV9akdsspTGdmvB4TFLtzeKgbtkoVdsXWhmtYy+8Kwj4oS0bDL?=
 =?iso-8859-1?Q?jPKymaaOWw9zEFvrt7yzjLblnkjaxikRk/iRcu1ksZkOhlN4ZmBJlqrNaC?=
 =?iso-8859-1?Q?inBMZPQ0gQd4ZnNyjJmljCxUald8Q39e8obmPaPAF1hwTUCAtwtRBtskY4?=
 =?iso-8859-1?Q?dvWFg5TPL4Q66aPag8YIpstscm0BF+nQIHM8T4ylOv5sbGaNuYR/qn1Uxw?=
 =?iso-8859-1?Q?/+RZ1Zkm/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cn1L0xSrxveCc3Ed8fBCfF/FKcx9T0ahrg71KMdXxcv+YDDNlE9TgvPWa0cAQzY4trb0aTdiw1XzchaWOMfzpe4JzOe4VHm8vKtgEg3KRrGFPeQ7WokQVXSieX4U2jB4PN868wo4G5kuOkMeUD6zhl/Wt7Ip+OPRcvTgS1lSPse9FRTFY27pedyNAZHy5PIXhFvt5/+lAhhRLnF/GHJqRd/zaMP72HydaumQBzW0usE7yUoG+uAPH1JhV35wBJ5EyJZTlcksU3nYAcZgO4TVdkc/JyM08RKAGQK7VymFSUndSUtzTE21Ig5rM4bcomX1prvhDsNyQMqyR2mwZ7svuQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4a3701-6bbf-48e7-bfd5-08def2012b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:19:56.6401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVpLt7x9L1MMmVEYPD8c/XUeX8+4ojU9CTdB+PStMeQiv0RUGk1vDSIO5Y/KTsP0l+Fm0BQEenbbCtQ5hwcLWsAfgj50MJ+InA8eNkxOem0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
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
  1. Update ASPEED SDK v11.03 to AST2500/AST2600/AST2700.=0A=
  2. Update ASPEED Zephyr SDK v03.08 to AST1030.=0A=
  3. Update ASPEED Zephyr Project v03.07 to AST1060.=0A=
  4. Support the I2C master buffer mode to AST2700.=0A=
=0A=
Jamin Lin (8):=0A=
  hw/i2c/aspeed_i2c: Support the AST2700 master buffer mode=0A=
  tests/functional/aarch64/test_aspeed_ast2700a2: Update ASPEED SDK=0A=
    v11.03=0A=
  tests/functional/aarch64/test_aspeed_ast2700a1: Update ASPEED SDK=0A=
    v11.03=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Update ASPEED SDK=0A=
    v11.03=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Update ASPEED SDK v11.03=0A=
  tests/functional/arm/test_aspeed_ast2500_sdk: Update ASPEED SDK v11.03=0A=
  tests/functional/arm/test_aspeed_ast1030: Update ASPEED Zephyr SDK=0A=
    v03.08=0A=
  tests/functional/arm/test_aspeed_ast1060: Update ASPEED ZEPHYR PROJECT=0A=
    v03.07=0A=
=0A=
 include/hw/i2c/aspeed_i2c.h                   |  2 +=0A=
 hw/i2c/aspeed_i2c.c                           | 79 +++++++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700a1.py          | 27 ++++---=0A=
 .../aarch64/test_aspeed_ast2700a2.py          | 27 ++++---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 21 ++---=0A=
 tests/functional/arm/test_aspeed_ast1030.py   | 12 +--=0A=
 tests/functional/arm/test_aspeed_ast1060.py   | 14 ++--=0A=
 .../functional/arm/test_aspeed_ast2500_sdk.py |  8 +-=0A=
 .../arm/test_aspeed_ast2500_sdk_515.py        |  8 +-=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |  8 +-=0A=
 .../arm/test_aspeed_ast2600_sdk_515.py        |  8 +-=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        |  8 +-=0A=
 12 files changed, 153 insertions(+), 69 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

