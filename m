Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102D3C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxss-00028a-73; Thu, 20 Aug 2026 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsq-00028E-NT; Thu, 20 Aug 2026 04:12:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxsn-0001n5-Qi; Thu, 20 Aug 2026 04:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocqbkRL+tgfyYnDmMlInwjeuKhqp1nRyM833gjlEifw54LxH+iYcCyl0gwIOdP4xh2r4Xy7LP029wapeL3RPGfxL9RomArqXnbonvLSD3CftsygC8GfIrJVUH6n7+ljvI8b/deZZi+7WUzy6QbhJWFmgVsMOE+73/d6n5vopxjb3R/AmZM95up9jrowpFo9ht4yRfSivrgN1SmmmWUQE/T2SVJddSFjJksHF4Faq1FD4UOxBsBzuv4LRUEBZo4dsUr4Mb4vNSiurqU2V72aul52Zh/mcxAqHBIJ1zWA3danbYpXR0pnAkBCqK5IeWSKzHwG3aB1tmD6XQdde0fsydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKnQI+ujwK7/vnC2L8Te6vZ+MrVndSwpdVR4Sqv4Yac=;
 b=KKjr6goj/YC0/4yVsO6IT1B5QOu5+I0E6j6xnMCiFWB1gT9R2lzJpW283/3DEVTzKRUWNuvmJpUubAWBB0fRztdaDqbW8Hbj7/Tsl0ai1mc6jn/lqKBq0vLjJx7bOlkhlq6nqMY17DtlMJhuc4TgrIpBA0sYQpv9c0lPPbZmZ/VwHTEgexWFwmNSD0oUNhuBhYl3NGnFsf15LXRuVUAZHPowmIMi4+uM4VAjdcFvCv0znsZR9MRVpYQHJCfXfCGGX88v1EYENG2FiN6L93wXt27ssvo/RUnQWXfS7cHCZ7Kpgm2OuD7T992iwbZPLYXkNXbBSPp4vg2lGMSO2fG2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKnQI+ujwK7/vnC2L8Te6vZ+MrVndSwpdVR4Sqv4Yac=;
 b=X/o8nAOzW0SNAf6iLg87Dv0739Q2cP4Ght/BJUrQTUco8UhIR3lfGuCjltqEHi/peU7jAuKP3LBySif9NNAG3QMigL8CsOytqaDsfTG73C3ssu3vzNPeOHOp9N7HNFkP9Dj5zTXcpAuKffZ8hfwomN3YfEjbLewYyxioI9l9FJuYS7bgMcQaPQE7ek7HwUaCaIk2QCYcOtFzO5S55YqU6btqEEtMy5szBygf0pIFFACzjvyC8TSn4h4ZjXTjM6I4QHYnnjdTq3bnPvnkGXGoJvD+12jZypsmfHIOnlfH/L/3pagcq2DasAHgRspaNDtScL57ipRhcrzn4F8z9Xrw5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5661.apcprd06.prod.outlook.com (2603:1096:400:28e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:12:08 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:12:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Topic: [PATCH v2 0/4] Add ASPEED ACRY RSA model for the AST2600
Thread-Index: AQHdMHuXpSIZ1OOZOEyu28ge3J3rLg==
Date: Thu, 20 Aug 2026 08:12:07 +0000
Message-ID: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5661:EE_
x-ms-office365-filtering-correlation-id: 9c7b5b8f-deae-45e8-4a7c-08defe92ba57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|38070700021|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: WkgfW+rEwdQ9mhxVcRskV5FMlz21N1h+tKcVU/Fsan//UnZ/e/6qLOgO53atJVKRhtlOLav+hZiDUOHplpRWzq63rPLXAOKmTzJehU1ZuS0oGYClTbuQGC/+1Ph3MvG0t6pRV5OfCkYzjHPuXKrX17jDUJ9M0UX5afkPDOYMG/SvmC27nslVaQMQ3lOdNc6oWyz6nVTfmyUinnjHs22M1UqhtIotJgOQbq5UWmpPJC/w1KuvM+gI+Lxbvz8OlSCrF8u3JnVJWotvBvQ2zpMB6v9OTgxlI9Pximdtv0Qt5fNQ8Ijft20CmmO4cPxsiRZkdcYu0nlPD9W5jFbTUjNhRXZ4Lz52/ppWfoQNWzxY9um1KhUTeHponprx3gMMDZ3Nlb+xWBh++13U+Z1MVOZkyG9XyXjxSRec5XGRSGPQQqC8qCG3uMBQlKr9eK29ZunJMxR/Y7YJCeON2DWP90GuXKY8T50hSMCJ8CcK3fX7xNs+i7Ke9L8thLIJ6p98kpbsR1v80z7anN63YIksc/xJbkAYV3dAoLQtTLl3VSAjofhbROmq/wB2bCG4tY8nHX3LbcXUyLIvnwYz8X/tYWLgY7Txyg0LCOaPbIjxx3c4avVtPU8PQcCDHI65g+y5jlkreKnm/MWViYKay5SkpMcsSOYkbr8TXCeVZhCCeN+p9ApSqO3S/2KidVtvcDOu0WcWtBomfN+dPgufzVnkYz1V6Xx9WEj54l5hXzU0r/Nz9WkGKmVj+f+uFIV3DWMD6S3M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(38070700021)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X6KZnz+rHMtBHOdU7w1GbLAu7wK0lyNJ2wIgazlS5AW5cCbM2nraRfhyn7?=
 =?iso-8859-1?Q?F6vrlPod4NTXM6kbq8KTdUeHQmDU3VFtTxfoE8XRMTXN07Kfgb9hX7ydVc?=
 =?iso-8859-1?Q?DX4UG4WGHxWTQNx3EuOjAwRhlgzbxIILAenb97F7v+mMijMxo8HZceGI11?=
 =?iso-8859-1?Q?XDo/O1ySz8BmnO7t9pIGeTDpzomFLbStZ/vL/yZnXhGham2lZc16Wv2UwN?=
 =?iso-8859-1?Q?ym0Azzal5Pz3x0hMaTpGlNx9NcMi/cH4yf49PL8QSiCoBmB9U7LypaSvoq?=
 =?iso-8859-1?Q?1hzB01MnShiVod8oTd0yfFzHOgp1TirnOaeqK5O4uvGDnPHrk+kHovgoIr?=
 =?iso-8859-1?Q?MXM/A3R9kv0UfokQ67rnOl4uSv+JFdQL+fB6ye6yWfb9b+64XsTfJ4ui1f?=
 =?iso-8859-1?Q?C/Uc0wfPqTKYGWmGyPms14/+57R9JkhMqmzHHILv0ExXZrmn1LkNiL49OG?=
 =?iso-8859-1?Q?BdgRZEkRz1DViLta3EqFY+ztkF5KhNN/AGiwaw9lZM8A7uhNXtBNSCLXug?=
 =?iso-8859-1?Q?Iv+hv7s2RTkizKPnXvv7CTV05L/9qTKJp2KrfR0Unq47SDoswG99oNqO4I?=
 =?iso-8859-1?Q?eG8HTpJ0nWbmKd13gSZjDJlmsaY0JjwbchIuq+qwXkRHJJ8UeuxaGPLUWf?=
 =?iso-8859-1?Q?S34EcRMqnW1UKj4OZUDNqrwxxhIC6SheifLa5qbkivvpKP54OXUO8LhAkl?=
 =?iso-8859-1?Q?v4khO3UjTyVYnfjv5lfmcv2MaQCPkhQvzM1PACKogMA8QNP7gjcyi7LiqO?=
 =?iso-8859-1?Q?4jtxrVDI/7mAqFuc4No9USUGtgO8DGPdW5l7B/UivQuiIzSzC/nfx4olU4?=
 =?iso-8859-1?Q?rr6wh+GO68y3ROF564xpAG+rjzGhoVez4qPJRiiujHpRQhvkTDLSMG2rAD?=
 =?iso-8859-1?Q?HFm+MJ7B25qxFqak2n4s4itSuVS46i6THUUs0elsXW837GpQQ14j2NZ32v?=
 =?iso-8859-1?Q?+aYJKSOMtP9Mx0dKVB6g5/Y/R2isLagA0tM7zpEfY+e0zN/h1GldCaZXlc?=
 =?iso-8859-1?Q?WrjRiQYiVGJLaubEM6O1zaXo2H/ItQFGZVVYWTnj5mnWAX/5NVP3fcdmWy?=
 =?iso-8859-1?Q?oiXusioEspdWxkwcEWKFnkxlmmDRL997qtxzg1wufPSbh+k5lI073p/Nep?=
 =?iso-8859-1?Q?URhjyDzB/lFOT2Qe++Uoz8CndF13y8/wkvLdmhr/LQSZDrIK/kmR8Tkfj2?=
 =?iso-8859-1?Q?cGzDV3H2S/3JKudUgRJi063aksB+y8aPX9BBzyfpTogLb8d10cvH7DciW4?=
 =?iso-8859-1?Q?YqHdYp44yNmYiSnQIxrKcZDt1wEqxe9unon0pFWfL8YTKWbOcwAhvs9i3c?=
 =?iso-8859-1?Q?b2yB7N5XldOtsvF+Ab3auY1VuX+Euuezh4LbkpK2R3LWfrXD4rsuRC6bZn?=
 =?iso-8859-1?Q?/3ulC8REquZ6ebCKfCE/FxMpRqFNEhlWPfezN6AYncmo9imW72GVQA7bVq?=
 =?iso-8859-1?Q?83PYfkV8++6x9B4DQl7XVYLbSD2OY8SV2Smgm5Y381V2pUE29WHtL40M0o?=
 =?iso-8859-1?Q?KhTXp/uapOE5eFJvgubcBUX5TnJhciA5q9jIYzYZbRfSuCSUMWVJqn7m4K?=
 =?iso-8859-1?Q?I3FCbA0ZLXhk9AKHbSwp+CT9YCsAD4vdo64Kgr94oUvfRSS+XYEkRHQjKu?=
 =?iso-8859-1?Q?PRImGVSq24oj9KCSPoM/nCDaUA0lNMa9spBvqzzJ09ibeh2G19VWTFFLs/?=
 =?iso-8859-1?Q?6iE/8IKNCQq2GDd9SgUkvOc12Opeo3Kmt/4pLeITme5VLfgyLrVEp8FZpC?=
 =?iso-8859-1?Q?gUoQ5zlY/VoaqGoTvywVWXUsXyAbr24vw7rzL0ItQFPGu3L5dAfFVM4SWE?=
 =?iso-8859-1?Q?Q3I02fFXFQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YP7dJkBcWEXS8dROw6kkjX1FBLEN//0bhF0CG3t+TgGHibW40PKJQS6f09C7be9cjIDHLUNmoouRUovY5OxG/8uWz2veI1ZxtqFr8Hw8QrtOBAF3t1Z5jcg43DLltXjOBT5Adh+O18TDnp6qZxZr8rl2vcBV67KzhuCUsbOUG/vs/89v2n3DFJ1hd4cv8AzwXL8pxMIWjy6lGUbfdawbXhNEIU20lTWR+R81r44DEfxiA7dsYvmouZC7cP3xtEhYH2ykjQIqe95CtMoF5DZ8iTZTF5agBo9CO5Ew0sSfOaE5kTbgwnbx6AMZ8AOay1H0Ildd0bOA7EBy9e/q50z+gg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7b5b8f-deae-45e8-4a7c-08defe92ba57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 08:12:07.8134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F49KbmmYlwBOAlJFAm7QicPeKL7DAxmY8QCB0+JhPSBm4+kch8/fBeRBO3Tyk5f0dMu229JK+CYKEsnYSksJvEiAG4qMO5eE3RqA6+2JWWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5661
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
Jamin Lin (4):=0A=
  hw/misc/aspeed_acry: Add ASPEED ACRY model=0A=
  hw/arm/aspeed_ast2600: Introduce the ACRY SRAM=0A=
  hw/arm/aspeed_ast2600: Wire up the ACRY model=0A=
  tests/qtest/aspeed-acry-test: Add RSA ModExp tests=0A=
=0A=
 include/hw/arm/aspeed_soc.h    |   4 +=0A=
 include/hw/misc/aspeed_acry.h  |  39 +++=0A=
 hw/arm/aspeed_ast2600.c        |  34 +++=0A=
 hw/misc/aspeed_acry.c          | 455 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed-acry-test.c | 395 ++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build            |   1 +=0A=
 hw/misc/trace-events           |   6 +=0A=
 tests/qtest/meson.build        |   5 +-=0A=
 8 files changed, 938 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
 create mode 100644 tests/qtest/aspeed-acry-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

