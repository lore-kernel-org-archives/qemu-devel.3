Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBDAE83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9Z-0006fY-11; Wed, 04 Feb 2026 02:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZB-0004Y7-Pd; Wed, 04 Feb 2026 01:40:45 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZ1-0004HR-0Q; Wed, 04 Feb 2026 01:40:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX+eC1oLaDvNHk/62WJuiX02o781C8rSRa8Zh2RWuYURISISD3TRm7evzNoT6fOkkaIscx71FzoARSHEOuWJNSiZR55CxDLtTgNZ7PFv/YURA4qtAhNDbe3zF3ydurBlpPBEI9kSpK+PfPIls/0dd4bhYgVRA63T34xboIDDJolIqQUUdtmuWPJA1dKSEstOz1mwpDl5KmQFlx7rgzA7yq6V/V2nIRDaLa5LtLumoyKEH7gQ4AmU51cRQ4OmIdF6oUl75GClMCDA9WDOoDV7rSZzCU3HwA6k+HBzBfVuoWTFC2oM4lc3/9ZWG5EwV9by43HUlt8HRyrwkuvAlXjmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xanY8lWWj1o9pHV4DaF+bwhx77T/jfPF1cnYyg/dbTU=;
 b=So3RxvEv25SylaJV5xzz3d3Gbbr8CVs3xmBWHLXJbpVvc0hvywGCF4C2ZPxjL4r8IyuKIsIrxbzm+g151hFgTTMVRqKgzT0MEtISj5HQ/R8dzXcIgQhyZlMMnrafg+gtoM4Z+pZ1hFqHTrvuznzpUyb/XPw5hPgdfysPt2OvBYratuGgxXvSyGEkZNgqsNcgX3uaFWr0OYku83oazcmJ6LcyWEZxnCqlyP/Fl1mG18i/9gab+GLi5bogbsxSpfXIJQHRL5JTRGBxhj3O/fDZ3N1K8+IeZsVUXyj0QMMGp+Me6TnBSgYOxRrEGDWeNcfL61yRRp+s+9XvcDJlV+wjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xanY8lWWj1o9pHV4DaF+bwhx77T/jfPF1cnYyg/dbTU=;
 b=g5mbTNGLXsc2BOpRlX1rgUxnChFBRiH2E7yPMwfXw2yR+ihlosLbWC9icMMdTduAhpEkzmnsIgem9xsk1HKCrnsFADLbCj1DeHE4gpMQUHjRDwuCEnm6rl8CKh9tg5dVMPcM0zUsjL97Yexl7ysOz+mjT+pguEZiF0h7GMLQy2zu+gx1HrGe+gG7LmLRIkLinDwfQV/Zqy8xzyGvptGyeAKi64yF8szQMNJUK5k0HBrSCkFHw+bV+4YHkkgU2v3EUveW0kPIqYtitRu7qNx72OTYh9DPCkHxF2NtdifMDej7ee1vEmDB6PT/HrsurvJEXyKpxGuwL15T5ZCfHnpXTw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:26 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:26 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 06/22] hw/arm/aspeed: Integrate interrupt controller for
 AST1700
Thread-Topic: [PATCH v6 06/22] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Index: AQHclaElY0Rc7SwRnkyWJqed5+Q0dA==
Date: Wed, 4 Feb 2026 06:40:25 +0000
Message-ID: <20260204064016.3515639-7-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: c03f1b18-6a51-4393-a40e-08de63b8479d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/gSgSrOWy13bLjgOuvO9gJ88zbGseVIT6Q012D2wbB25GzFvWEvsSvLA9O?=
 =?iso-8859-1?Q?8nOZMQ9ea4PryWRZDA/s5yj1z9bjNiDUqeo8vBEBGGjgp/3+DKAv232rel?=
 =?iso-8859-1?Q?OgN2i2N4YNGfpkyFMaS4otZ17du3ozdwh1eJPM9PKaQP8UIDnxwPrXSWQD?=
 =?iso-8859-1?Q?aYLMz1+x4FvyOaVjEO6X1UREpwKo2OQsWzPt8QqPjlzi6Dbk70oxXgb+M3?=
 =?iso-8859-1?Q?Wsot/PQpv9Njk0ACwz31C0oFQCn+rDhsZmvOg3c+3DzLCd3IpjIsdOmac6?=
 =?iso-8859-1?Q?UbddihmjjHfuKt5Ypbpvi13+n8FoebmMYgQlbdc8A8U4HIDkUHVV6xZ7X0?=
 =?iso-8859-1?Q?6RKFz/pOeJYRP89a6Df/sziDs1oOOqbF/FEqOs3IO0o/jKA7RsxF1Ve/gs?=
 =?iso-8859-1?Q?SL2/XIWBzZE52L/aG6Egk/HWArGWP+e5+l+QtmWGH6D64x3AWJK330h0sG?=
 =?iso-8859-1?Q?490DSt5PlCb8sGYUuORXjiaGaJYv/amQkCv0sTIksXgo8ceULxKepF6CTv?=
 =?iso-8859-1?Q?9J40D9cndM1RCRuVSftJfhkz35IRFvLFIOEYKarMYC9RmB5KeUpCsGo7gW?=
 =?iso-8859-1?Q?OqV3zoy6pjEMjrmIDAvAwXpTXzuFWeAZsfYY68EX3Ti2RYjEi+RcS9rShM?=
 =?iso-8859-1?Q?Uw7aPzy9n2bx+Xy5ih6e2Smooz+mtPUf09UYrRtzU46BB2bajAzlRRbuW2?=
 =?iso-8859-1?Q?//SBkxaF+GyxfNjBDMy2Ex4aXfil9JSVpDO5c3v95uvD8wnjQncqayj3V2?=
 =?iso-8859-1?Q?ujdHB4qzXjoVDrLr9m5xT3oZ2gOW9VxMRQyHrHAQjrbmmBZgnxuUXUJoWB?=
 =?iso-8859-1?Q?OG7a+9oGH32fR4dKfVwlejZ5Xu+8taNmsZfg/1ajoGaFppWfZ5xN4Y3zud?=
 =?iso-8859-1?Q?gEi2EHH2ji/CW9VJZE9UTkFlPKlK/geAHwLd67Xolkyuz4en5RaJ+w/4sA?=
 =?iso-8859-1?Q?khUqdLHX/5qlEN8IqENGlyfZtCrCOK3K7T0YachDsNr3Mj/SBjI51PB+1B?=
 =?iso-8859-1?Q?DWJ1sRBpmWG9XB90EhTK0rrhHpcUN86eGSFjKTf+Ch/woyHEI1FiDNvitr?=
 =?iso-8859-1?Q?R0g42pzqeuQ9z8b3EoRNKOyZvU7GGSFROoiDloGGssPDcX6rmAR8A+zpYu?=
 =?iso-8859-1?Q?2T2RgvZi16shOjdoH4mXnq8QHSGPxByap7uPpsfIuYp/hf3ZWlwBgBAguF?=
 =?iso-8859-1?Q?musx1P6EgH4PhmbuFNmW1/xAbAxhG++ePiAGyYn27UsNPgyhgM/ZAfUo0l?=
 =?iso-8859-1?Q?8KM2+AtR+qhBr/bGjJnWedsnPHtxvNg0Pkx4UkjQEP9N7whp93i0IibORt?=
 =?iso-8859-1?Q?CmtKcYKYbxfMKd83Di95DoUZScczb8k6jtNC/kq1r06swYn/hs2zmfCWft?=
 =?iso-8859-1?Q?exxZB4ozS5P/aCxCo5nVfKrbQENa1NrNKt6slkty3fZ1ZwExZRNqeSqpdI?=
 =?iso-8859-1?Q?PW+7fXJHULMVtTen9H0J3krIJ3NuhfWAE8LVHGfD4yZfKcWEexcIRDbK83?=
 =?iso-8859-1?Q?AiZIT5fnRrE1z5XMrWfMIObWM8Ey8HrpZOTgJBkBqcEq6QEt0yWA/VL5sj?=
 =?iso-8859-1?Q?K4qUoGznMVF2RhqzMHqrhNuucmxQZEU+zcJu/ikMHy91o5lXuIXwiD+0ec?=
 =?iso-8859-1?Q?lR3hNgFksKy2pga2TWifqugSCK9zV5wtZv4BfORnm3jm6pVl8YI01tfiiw?=
 =?iso-8859-1?Q?rE1YFNmovgqKkAHj2Uo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3Pctv+vNqFZADliO4pHm7nXVRnGBXxCVW9rrpBwoMPMCWuITGh7T1CEbLE?=
 =?iso-8859-1?Q?XRfBTuKbdQcqZF03MYPcyeyvzjoSjU4R1CCVfWRNUmTYOnIUEdEwIWjyhS?=
 =?iso-8859-1?Q?xNXSNXVvd6pLpGe2xUKVJ7TUjqf73HmAXg6BqQ0V/1iZmM/qYUumJpnLB/?=
 =?iso-8859-1?Q?LsEZjSi+gwoowvCM4Pg2qGO3uVAqswVxGk8WWnKijl9mZ7k93i9G4o2jj3?=
 =?iso-8859-1?Q?u5vZo9G2Vt6K8PYghvl1vkC2GXxtzYClR/NBiV3AgvrHrpDCC8UEMaqRmh?=
 =?iso-8859-1?Q?epLQ1SKpqVGfkGVpJurUieYGIjNtsODXOEBjPCOsrSjrJTL1nOgnWGZEoP?=
 =?iso-8859-1?Q?GSwQyh6FuMLqZJZXGTmJ9WIF1TWRBmAtvHJR+hZ+gb2f0pUL+z1mu0POFg?=
 =?iso-8859-1?Q?8MTBs2gxryhNdfu+oPbnDtsaqbjHBZIjL8mYFnB2NUaxpkxpwtnp4RQEvY?=
 =?iso-8859-1?Q?KJdg93xVzSQnNmeqpLMhluIvEH7xUvwUHZ9FdcLitw1SOmLMS7sX/ZiPxq?=
 =?iso-8859-1?Q?6s7+WfLXdljuQynJPQ22S/84lU8FHENVN7kEtS3BN8x3GqlOVXph+sW4am?=
 =?iso-8859-1?Q?F7rKceWRV53sU1JLaX1/TvVi9N1Ifm2OXBmYoRTawy+t+hRQolpzOtVsT4?=
 =?iso-8859-1?Q?YZG/BR7FRKAGgqUu3OOj3aKZUC/8fTz0tPBdI6ZU+P0ZBOCD1HZb6WphYR?=
 =?iso-8859-1?Q?8T1VTdqPkDaTv/2Yk/8m1s0vwCz6WW0b1PxkACaTZgtgbEzv3sjSMozsKM?=
 =?iso-8859-1?Q?0LTM8U7qwZqnrg9vmuDXh7dTfLrvSPkjKH9S+CX8X416Y1C8bgkF21VDcv?=
 =?iso-8859-1?Q?rCUEAnGY1E6EMGCZ/It3Gx5Q8Zx4xAggqC3HR2I4GiTkMXIhKEt5bnp33f?=
 =?iso-8859-1?Q?4lYB6GfMrNyynsfQ2dWVi5WXYrAr6rYZyzCAwdpB9rc5xIwbEAg1TOVdxo?=
 =?iso-8859-1?Q?jVR5UKW6e17z0nmJXqtzQEejZtj5fsToLcTgBmS6TsOgbLbo4JIXyQoO+E?=
 =?iso-8859-1?Q?koVgovgMwlJ2arNh486OOB/TkIxwMOLkbq8CrNy7uWMdJGbNwnAv8RSjPm?=
 =?iso-8859-1?Q?IPL3fLFbm9CS2F4sy0sUOt0RYFLN7h8WP7ghcphhF16saqVhfwEuMzt3ZK?=
 =?iso-8859-1?Q?xA5FxMCMbjtJDj/xt2JwH7qDdPfNmcvJ8q/VaUo337UZgUbzTzeypyeQv3?=
 =?iso-8859-1?Q?ffZ2FywhWVoRuNRqfo8PgRYWOGSK0ghRzy3XAQppE4eSfULc7jztsp3f+9?=
 =?iso-8859-1?Q?tNgIFpufJee2L4rNDFS5RGxpvqbNFKbj1DHV3rT9Q30Jq72cOojCb7c0qp?=
 =?iso-8859-1?Q?5zKeS8HjiQpVy2b+zgIE/SDoF6VVMjuONhum0STM/xpUs9lXy2YhlsXWs8?=
 =?iso-8859-1?Q?ZH3NOs4bX3SNvUlUQNVkCGfijLLQYkYrG0SOrTEMZh29MJ+2rLMVTt6AD4?=
 =?iso-8859-1?Q?RJEYsQC4GLHBp0fLzQkIGkst8UUNSlSyLlEHkkJSr/4Tr1yVl+3BC93LIR?=
 =?iso-8859-1?Q?9qMHmon/KLLaucUOxQGeo1SWBzccn9kjeu3GobRoFAxVy1RKtDJjb7AF68?=
 =?iso-8859-1?Q?THkDrw1vfIOmyHDA2nY03b6I157OJF9cbpFYENN6oUXVllob6mG2CGySuI?=
 =?iso-8859-1?Q?ccxUcuL4taNaJ0G3YeoIkZB0wRgbZEJet5F6WEzyRnwq2odcSJsVPTT59I?=
 =?iso-8859-1?Q?3iEoxhmjHU/KO2l+NOk9I7JPQ02y8gqipCK/vQfP9ehqFl+hghia0Q+5nC?=
 =?iso-8859-1?Q?cxf0w39aGSRQzmG32BLaiNuyCfOUytxhl/MTBs8gRO971mQFAUpg9n6PEv?=
 =?iso-8859-1?Q?7z3YlghB2Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f1b18-6a51-4393-a40e-08de63b8479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:25.9003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcnNNWrTl5inGeoVyl3bUDRK7Jd24fEKYzjl10RXZfXg85VO2hmlND4MRJYXQR/Qv/AZ0IyuE+RfdbLL0ZXiLUGd4lKDnkbgMWXliGJ6ZeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
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
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:16 -0500
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

Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling=0A=
the propagation of AST1700-originated interrupts to the host SoC.=0A=
=0A=
This patch does not implement interrupt sources in AST1700 itself,=0A=
only the wiring into AST27X0.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h   |  6 +++-=0A=
 include/hw/intc/aspeed_intc.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++=0A=
 hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++=0A=
 4 files changed, 104 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index f19bab3457..b051d0eb3a 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -58,6 +58,7 @@=0A=
 #define ASPEED_UARTS_NUM 13=0A=
 #define ASPEED_JTAG_NUM  2=0A=
 #define ASPEED_PCIE_NUM  3=0A=
+#define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
 =0A=
 struct AspeedSoCState {=0A=
@@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {=0A=
     AspeedSoCState parent;=0A=
 =0A=
     ARMCPU cpu[ASPEED_CPUS_NUM];=0A=
-    AspeedINTCState intc[2];=0A=
+    AspeedINTCState intc[ASPEED_INTC_NUM];=0A=
+    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
 };=0A=
@@ -288,6 +290,8 @@ enum {=0A=
     ASPEED_DEV_LTPI_CTRL2,=0A=
     ASPEED_DEV_LTPI_IO0,=0A=
     ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_IOEXP0_INTCIO,=0A=
+    ASPEED_DEV_IOEXP1_INTCIO,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h=
=0A=
index 5d10268fff..b25ef4a464 100644=0A=
--- a/include/hw/intc/aspeed_intc.h=0A=
+++ b/include/hw/intc/aspeed_intc.h=0A=
@@ -15,6 +15,8 @@=0A=
 #define TYPE_ASPEED_INTC "aspeed.intc"=0A=
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"=0A=
 #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"=0A=
+#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "-ast2700-ioexp1"=0A=
+#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "-ast2700-ioexp2"=0A=
 #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"=0A=
 #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"=0A=
 #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index a05112e2b0..d9866c2c3b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,=0A=
     [ASPEED_DEV_WDT]       =3D  0x14C37000,=0A=
     [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,=0A=
+    [ASPEED_DEV_IOEXP0_INTCIO] =3D 0x30C18000,=0A=
     [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,=0A=
+    [ASPEED_DEV_IOEXP1_INTCIO] =3D 0x50C18000,=0A=
     [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,=0A=
     [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,=0A=
     [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,=0A=
@@ -446,6 +448,10 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INT=
C);=0A=
     object_initialize_child(obj, "intcio", &a->intc[1],=0A=
                             TYPE_ASPEED_2700_INTCIO);=0A=
+    object_initialize_child(obj, "intc-ioexp0", &a->intcioexp[0],=0A=
+                            TYPE_ASPEED_2700_INTCIOEXP1);=0A=
+    object_initialize_child(obj, "intc-ioexp1", &a->intcioexp[1],=0A=
+                            TYPE_ASPEED_2700_INTCIOEXP2);=0A=
 =0A=
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);=0A=
     object_initialize_child(obj, "adc", &s->adc, typename);=0A=
@@ -690,6 +696,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *de=
v, Error **errp)=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,=0A=
                     sc->memmap[ASPEED_DEV_INTCIO]);=0A=
 =0A=
+    /* INTCIOEXP0 */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,=0A=
+                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);=0A=
+=0A=
+    /* INTCIOEXP1 */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,=0A=
+                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);=0A=
+=0A=
     /* irq sources -> orgates -> INTC */=0A=
     for (i =3D 0; i < ic->num_inpins; i++) {=0A=
         qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,=0A=
@@ -1006,6 +1028,21 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         }=0A=
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);=0A=
+=0A=
+        icio =3D ASPEED_INTC_GET_CLASS(&a->intcioexp[i]);=0A=
+        /* INTC_IOEXP internal: orgate[i] -> input[i] */=0A=
+        for (int j =3D 0; j < icio->num_inpins; j++) {=0A=
+            irq =3D qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);=0A=
+            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]), 0,=
=0A=
+                                  irq);=0A=
+        }=0A=
+=0A=
+        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */=0A=
+        for (int j =3D 0; j < icio->num_outpins; j++) {=0A=
+            irq =3D qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);=
=0A=
+            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,=0A=
+                               irq);=0A=
+        }=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c=0A=
index 77fae39205..52f2f946d5 100644=0A=
--- a/hw/intc/aspeed_intc.c=0A=
+++ b/hw/intc/aspeed_intc.c=0A=
@@ -793,6 +793,64 @@ static const TypeInfo aspeed_2700_intc_info =3D {=0A=
     .class_init =3D aspeed_2700_intc_class_init,=0A=
 };=0A=
 =0A=
+static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
+    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
+    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
+};=0A=
+=0A=
+static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 2700 IOEXP2 INTC Controller";=0A=
+    aic->num_lines =3D 32;=0A=
+    aic->num_inpins =3D 2;=0A=
+    aic->num_outpins =3D 10;=0A=
+    aic->mem_size =3D 0x400;=0A=
+    aic->nr_regs =3D 0x58 >> 2;=0A=
+    aic->reg_offset =3D 0x100;=0A=
+    aic->reg_ops =3D &aspeed_intcio_ops;=0A=
+    aic->irq_table =3D aspeed_2700_intcioexp2_irqs;=0A=
+    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_2700_intcioexp2_info =3D {=0A=
+    .name =3D TYPE_ASPEED_2700_INTCIOEXP2,=0A=
+    .parent =3D TYPE_ASPEED_INTC,=0A=
+    .class_init =3D aspeed_2700_intcioexp2_class_init,=0A=
+};=0A=
+=0A=
+static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
+    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
+    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
+};=0A=
+=0A=
+static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 2700 IOEXP1 INTC Controller";=0A=
+    aic->num_lines =3D 32;=0A=
+    aic->num_inpins =3D 2;=0A=
+    aic->num_outpins =3D 10;=0A=
+    aic->mem_size =3D 0x400;=0A=
+    aic->nr_regs =3D 0x58 >> 2;=0A=
+    aic->reg_offset =3D 0x100;=0A=
+    aic->reg_ops =3D &aspeed_intcio_ops;=0A=
+    aic->irq_table =3D aspeed_2700_intcioexp1_irqs;=0A=
+    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_2700_intcioexp1_info =3D {=0A=
+    .name =3D TYPE_ASPEED_2700_INTCIOEXP1,=0A=
+    .parent =3D TYPE_ASPEED_INTC,=0A=
+    .class_init =3D aspeed_2700_intcioexp1_class_init,=0A=
+};=0A=
+=0A=
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] =3D {=
=0A=
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
@@ -950,6 +1008,8 @@ static void aspeed_intc_register_types(void)=0A=
     type_register_static(&aspeed_intc_info);=0A=
     type_register_static(&aspeed_2700_intc_info);=0A=
     type_register_static(&aspeed_2700_intcio_info);=0A=
+    type_register_static(&aspeed_2700_intcioexp1_info);=0A=
+    type_register_static(&aspeed_2700_intcioexp2_info);=0A=
     type_register_static(&aspeed_2700ssp_intc_info);=0A=
     type_register_static(&aspeed_2700ssp_intcio_info);=0A=
     type_register_static(&aspeed_2700tsp_intc_info);=0A=
-- =0A=
2.43.0=0A=

