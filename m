Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B57C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0s1G-0005WM-3r; Sun, 30 Aug 2026 22:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s1A-0005VV-Rr; Sun, 30 Aug 2026 22:45:05 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s18-00028Q-N7; Sun, 30 Aug 2026 22:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMTIQNa/iNPlmZ58OXUGPuIujFC9gJ8HZ8cDTHPMwLYnwVxBqiDZQwsQtJTyDDVuO4pvqS6fiXD/i5TPvpLvkElZXRmbi0We8a7QzY25svnqOuXyodV5nuoWF1Z+iUcCLyl2zBUV91shTqBxikpwDWc//+hHq4lWq+ZwnjA+UYNnM39tJUgaimj0faMfJnintfKPBSAohoH9zZmKNfKPEz8aBHcpD39N+bYF3l9TAfyLzpnBq3oolgfSBA3QuD0M/t1WP8mRo4MC2n3z3CtSx9Df4bDnMmu4zlnSTH523QROjjFtYfBdpK1BK+4IEh+jWUvD3g4GDUvnAAEcclaoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ7XSjjdaUE8XTgoAT2Aee3PZfUKMX8V10EYZjrJx9Y=;
 b=qeShCLu9SYO4Epn00RCAJvyOy753Cplx068m+++iQseYKjvRRFrwlVyHJMOOLYF+WETeXmWHd/Cj/9X/7qwtP+bFEkSVUZwQ9rdq5SteSkb65J8iKFE9NT+zrJ8e565OiL8qUa/JGxUxD+Ox2QoZIUoxQhKU3wuF804ZSBjYKUP0Aa/+1jcad/caltFG6oYwbYVqtU3OmeV4HK4sVaBD0V1k8LlWuJyI9rbjLW8L13KEdv/ivfj2Gl1AFHoFf2Quv5XhHaVBSDv/M+lsscCQB/haP/2OGRRK12O8xSdaCRfEHbUU1KLkkJgP14nFbjONfwqxGdI28JApFL61qv5D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ7XSjjdaUE8XTgoAT2Aee3PZfUKMX8V10EYZjrJx9Y=;
 b=D1MKUWiER6a6F5S7K7p/znkoX6bsElqDQEXZhEzKf6O7yvB2fvK2SiVRl9BviBM1Rv9u3vHosBKQ87wwgFOxRd/4cAgB17zAdcA85SIfklxKYWD73+On9dn7NozstOmp5SB/P8QvbnFCj/NuOw7x49PLjeLQusokuGo3iXMoCaQt863SOgfIP+i3PR8AFLFr/w3sVGTXcHtnoj7/wmCg0I15SzadkmcmMBbxALpzL3RSxUznJdsy79LrmkWdhyEktyy8sHL/DjvdXz0fQi3iF9H/i4GC7l4xl1zEmjqUxD9jfMruFLp1pHmOxOx0CaRCMnV673JYqKBpGFlTCCu1Ag==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR0601MB5822.apcprd06.prod.outlook.com (2603:1096:820:b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:44:52 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:44:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Topic: [PATCH v3 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Index: AQHdOPKy2dMXJokUiEyyd/5+ULRnDQ==
Date: Mon, 31 Aug 2026 02:44:51 +0000
Message-ID: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR0601MB5822:EE_
x-ms-office365-filtering-correlation-id: b1d168a6-8e88-47a3-9b95-08df0709d4eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|366016|376014|18002099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: i13VzR2mJPbc4Njn2RZaPmJZxPXYN3+2Sppu9lb9pZUNUT9fgPFXc/3WPPhHhhKPLYdhn0paRLtMZPF30l4Il9bF2yqlaSHtNI9ZOs2p9eFqKoMHHm0y9UyNn5OdR8uGVX9A+z9RVqeqy3hkc2quONwcitivvYgFw/S6svRJu7Bf0Yek8L8ZYB60O14vUiT1B4C0BCiRHx9n+u3HkXTGv9kLwQnZ3YZK4fbOe6n+y1AQpZd82hKpFmijZFE660yJPbGVI+XaJMa1GKwKOLtQdVAbVBnIXHPWN6ekITFsnWGQIYGG1ej6KnKdZGrcEhBMIcFXUbb7+mNo+oMlAWml24P3ihUJIO0KzXUJ5tv9VSb3QxehLlR6edJab7xqdi5wlb2FmHzJ5jHvNFSRaWeBoWP6JDFTvkX3ZNm3OhM3vJ76iqDSz94ELKTyQ/TLLgxU4k2nvvRPPKNQCHhqikBjTEX8p049tIXODsHfsLu918XfscqrqLqDTssoJEAxhiDQnbAeUZkBv++xrWmWhr9QSkO43V07OHCyJ5eXeKYYDlzSH8DDB9Q1wY1SVahWfKs82v5daxmdQk1IKdRxIottYwDDmHn7oBx/yl1qc3jtjReEdm/DZKEdTvX62ylXIH9qxNmcZ+lu1j+eqVvmqeAikmFIUkx+TLHw+2O/bNJFs0iL4eMIFACSK663l+v8h7D5rXndKpVejuzikkvXsbH6Ppc4iRjnOc/ka8+Nu8Gm3py5BT6pORpwIE7FbXIKGNIL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(18002099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XPdzto3CMqhNH0aqwCLV24MpGvq92nQHbxGV21pcrQ8n93f1hTqdUj90Ad?=
 =?iso-8859-1?Q?UR3M7Q64WpERBd9LzQNRtv7nLVqY9JAjHAks8V+2f/jGR38wAv/Y5FB2mc?=
 =?iso-8859-1?Q?+Omn01fsehXJ5rCZDydFjI7ZpzCfwBDfcFWjSDXvYGf0d30MijLqPUXQrQ?=
 =?iso-8859-1?Q?JPniGchZfSlmgJf5ROdZBu5AKL6nsEOQOLWErR6gxAXBo6O28cwn7XBoWP?=
 =?iso-8859-1?Q?KvVofrB8ZERBXibeQbCZNazafI5K8AggBM/pIinuadJon1V/YJhULUSAzH?=
 =?iso-8859-1?Q?mDbaTVqVRYkFvJaasbzgo4AMck5VL4F/VzulQZv+7GRyFxpbwQ/7ZLzQ9b?=
 =?iso-8859-1?Q?FqYiP3i0HNk2+JfTzIZHmvnvSx6CXPd/LwaZlW3FGSddLeFTmsAD4DioY8?=
 =?iso-8859-1?Q?ssD4LdaYqvuzzse8x09HysA10LHZaEnLLdiEMfe98BKA3K6+TfVFZPeDA6?=
 =?iso-8859-1?Q?8F92IAninmG3lp4Z38miCWrXp+8s+mTHXU8sHEowviUn0JY5EYY+mzfoty?=
 =?iso-8859-1?Q?oYZFDS4bNp3Q2K17MbpFebYRvMCDp9HmGktGyKXTLogEY83O8SI3A1LrLR?=
 =?iso-8859-1?Q?St+jhjLdz3OUI3VD7JDajjrtkxvNskWD36p7QrcP7TB18i/5bSRQ12Twu1?=
 =?iso-8859-1?Q?0g4jvDkIYxhzcsYnA/H/ee6XNt8ijr8U8+fsuRRyZksHwOV0UeNl65TiVs?=
 =?iso-8859-1?Q?VaYcviPPrKYD6EkXcTwqvfv/9kbgJbSr3UKQViWyykq3CPe3HVXWaLMmyq?=
 =?iso-8859-1?Q?Tn7IapPp+7WViLa5wi/P2/eFEMFBbyE1mLPBCcHwtWpy7mbEBrhJqysJ8Y?=
 =?iso-8859-1?Q?2M9e8Vfc70rWsvguDWUh5hF1Y6H0qO6TYS6TgwMq/uFF6auuG+zbcVSECi?=
 =?iso-8859-1?Q?RNaOtGTI78Q09IJ4OTvUyUfIUo73ryThc3NAcvpJDXGWFlgg+bU9/9zzRs?=
 =?iso-8859-1?Q?Kat9h2t9xVxxvEKjLlkvO6NKS0FzqoXVMYq9Yg05wfBaiSj0Gj8OzTdlSU?=
 =?iso-8859-1?Q?UdX6ihE5KoOM6gpyVFE1Y8+1I7AQjAvsqxSxFp4GFvytAS0AqzkLsGBklb?=
 =?iso-8859-1?Q?KZjGuU84F+E2+ysQn+fS/yOqHwK1EraQg4rDgwAEqNPTKMjpbjdMaTOKeL?=
 =?iso-8859-1?Q?HNIec31FqFWZzwlyZXxeYHbNPZ3ZGY5acCsv7a6Mx6/3sgWxLB5e3fQ6cC?=
 =?iso-8859-1?Q?Z5/KtwZ0mZvEyJPs+h07uhvnS6NTSjuhG5BJkcqGz4cgggh2K6iECHDeMU?=
 =?iso-8859-1?Q?DVYzfj/mdLaLmxx/v/sV6q59id7PJA2kI85F2uB6FOpWwy8aZC+B0AvBRq?=
 =?iso-8859-1?Q?3IguODY0fsA7awWN6q85YMqktT3oSYmLxUkSO8lSe9OJsh98xOfRDqU1gX?=
 =?iso-8859-1?Q?RDqiC0cpjuWTELKDkqDd1f5FNJDvipV+RlsJnPjomKrt5hKwFb0isPvwKF?=
 =?iso-8859-1?Q?+YKnPwCG2hcN013EGrJQTqDUYNHBgjetLrf14M+P29mskJg5OebBcj2rdQ?=
 =?iso-8859-1?Q?5A0Lzp8Cpd6yorP+euiT3x4Gycp4d8E8kccySoS0/3Hq6LX4Wr1J1OvuQp?=
 =?iso-8859-1?Q?vikf0kuqZ+MyZdxYeMtKRa5lGS/ND1ZBD2Ny/x4vw9nKrZYQkYYzyK5uiD?=
 =?iso-8859-1?Q?hBRGQ+Xt7ezSHYKaR0gMKmO3tlD/J0aniZ3uE4XaFkzo+54wQnCvWBNEKn?=
 =?iso-8859-1?Q?JX6ZRknqVYyR14aQv/Wwnjw9F+N43Bgcr01GUUh8bIE++SY2I5iTWSBhud?=
 =?iso-8859-1?Q?+icDQGrp7hVrap0yHhdIhw3875yCcflGRB9jZU14QGdaPMF13ZbYNm4Guk?=
 =?iso-8859-1?Q?tNVtG7c88A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P6bi7h/7PLNdtzr2H6uMzKQxtTp7sjG22/PyozbKjgTdiJGusm9+s1CSxnpfpHYL2NVs9mCt9NP8cy+lXDk1CLNnaHdpbiDTfBivApdzoYudFngeVHPIPEiSQckdPUdx29oAjgJJ0T33xJjcD0W5XUJjhftve7nMxE88DuSwWUU4fuOtPz3RUaHSNkEy7yrjh6jQETCGDNUk6RkBQEwCZRg7MQLI6l9BVshbUOBsbSO/sjRg+r8pde6jgU9T7tSPXKP88Q6gG2/HmYP6XqLSH24nE+obv8BhI8pjhuYF8/IO1MDGFSmyW5/xk0Z9igPAMsp/fXppn2Qp0aXLRqKBwQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d168a6-8e88-47a3-9b95-08df0709d4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 02:44:51.7635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/6fu6ggKjxf2jL0/S2EpebNyCVVMlA6hYI042uFBoury843titMnOV9N3xRp/lcimspdt7T9Qa796kDUzxH3ogVYa0EsT47wJNWT5LmR0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5822
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds a model of the ASPEED ACRY engine found on the AST2600=0A=
SoC, wires it into the SoC, and adds a qtest.=0A=
=0A=
The ACRY engine performs RSA modular exponentiation (c =3D m^e mod n). It=
=0A=
DMAs the operands (data, exponent, and modulus) from guest DRAM and writes=
=0A=
the result to a dedicated 64 KiB SRAM region.=0A=
=0A=
Guest firmware uses the engine for RSA signature verification during boot.=
=0A=
Without a model, the guest starts the engine and waits indefinitely for a=
=0A=
completion interrupt, causing the boot to hang.=0A=
=0A=
The model uses QEMU's generic akcipher API to perform raw (unpadded) RSA.=
=0A=
Raw RSA is currently supported only by the libgcrypt backend, which can be=
=0A=
enabled alongside gnutls with -Dgcrypt=3Denabled, so a build does not have =
to=0A=
choose between the two. When raw RSA is unavailable, the engine still=0A=
completes and raises its interrupt, but returns an all-zero result. This=0A=
allows the guest's signature verification to fail cleanly instead of=0A=
hanging. The qtest is skipped when the selected crypto backend does not=0A=
support raw RSA.=0A=
=0A=
Although the hardware documentation describes both RSA and ECDSA support,=
=0A=
ECDSA is known to be broken on this hardware and is therefore not modeled.=
=0A=
=0A=
v1:=0A=
 1. Add ASPEED ACRY RSA model for the AST2600=0A=
 2. Add qtest for AST2600 ASPEED ACRY RSA model=0A=
 =0A=
v2:=0A=
 1. squash "Add the ACRY model to AspeedSoCState" into "Wire up the ACRY=0A=
    model"=0A=
 2. wrap the ACRY SRAM in a container mapped at offset 0 so the device=0A=
    addresses it by relative offset (drop the "sram-base" property)=0A=
 3. build the scattered SRAM byte offsets on the fly instead of caching=0A=
    them in per-instance lookup tables=0A=
 4. write the result with address_space_stl_le() and check the MemTxResult=
=0A=
=0A=
v3:=0A=
  1. Return early when the DMA read of the operand buffer fails =0A=
  2. Replace g_printerr with g_test_skip=0A=
=0A=
Jamin Lin (4):=0A=
  hw/misc/aspeed_acry: Add ASPEED ACRY model=0A=
  hw/arm/aspeed_ast2600: Introduce the ACRY SRAM=0A=
  hw/arm/aspeed_ast2600: Wire up the ACRY model=0A=
  tests/qtest/aspeed-acry-test: Add RSA ModExp tests=0A=
=0A=
 include/hw/arm/aspeed_soc.h    |   4 +=0A=
 include/hw/misc/aspeed_acry.h  |  39 +++=0A=
 hw/arm/aspeed_ast2600.c        |  34 +++=0A=
 hw/misc/aspeed_acry.c          | 456 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed-acry-test.c | 396 ++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build            |   1 +=0A=
 hw/misc/trace-events           |   6 +=0A=
 tests/qtest/meson.build        |   5 +-=0A=
 8 files changed, 940 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
 create mode 100644 tests/qtest/aspeed-acry-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

