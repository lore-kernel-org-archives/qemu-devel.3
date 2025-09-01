Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB035CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n4-0003xi-HM; Mon, 01 Sep 2025 06:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mx-0003uS-F1; Mon, 01 Sep 2025 06:29:28 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mu-0005Km-TQ; Mon, 01 Sep 2025 06:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImC/dDzDXRij5qmfJfl9+KujSqnfymnBsvPEVoa8Z6cOfIdvSQKdbiO2ULZc9UXfA5hUUpRGeGLkENF2CsT8N+1lTH4sWeX04U3AwC1a3dape5QrKMBXuuJIvCSHu58VXJJRd37zWdYEU07Z0J8Krw/jIcgJsLTrFoAoOOJWxlqfI53jqra0vFfNBNyXKgP35vUFCPqHjTzc/WnHePMNQqM12xtJkqOwtLEvkhWzqOswBWZJZyJTSCplMQ8NtnkZrbDiqmPhKaTFqDEUK4860cyJhE6YzYjgRncCrpKI+YtypAs0OUZQiEm1eH1tEXw3gTFN24fkiF3ZA9ReUbN+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avqT5+jyHhncYFJbEI3LW/O1Q8p33xRREnpbQkKzkKc=;
 b=HKPRQonIyhfLz/S3DkoRSsf0MEXuhXXCZBsLJqmYw3o90R1oU+W51E2/alQbxlEtKPVYqFHwdQPLP7s+SRvP5lCjY+mPSlVnId5VoFFpa4r+x1cMi/VPusacuv1Jg7ue/TOd971UJR/UI8onE+r9l3xd4SvulaknlM/g343BkcfssXrRjPy9792KDDtyRCEDv50SXEnKO/towC77Nyj4etF3MuZAWtRq+417Q/4qmDWDpuG64WoCn0/P0XJblftFqrcxmyJ+LW4EAFKDIe1sQpKmVh3DSNHn/HxfgO+DDxW+sIWH6H/a+qxERBOZks1zWPHZI3ytkEakaLQ8DQJMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avqT5+jyHhncYFJbEI3LW/O1Q8p33xRREnpbQkKzkKc=;
 b=P0y9CokgsjCz2W3t/Jg11Aa/z9ABh9aGWeFfjPa0UWWFyzrPFaQ592MV4fV3pwug7y5E+oJhnEGY6yzJaaI0cK8Lj2We2YQNFPeJ/6s0xVhL/h2WLotXAFRurEikCdGB/V1ZjyqKAT79kCi8PTmlxqRRE+4Db44KohrAv0UBmnVAwdvjlUq3vLUu2mNPs4zZsTGLrytPC2gdDTaxg0FVSZYxHicHdpHvUSP8sq5H+tCT5Zc0W4MvynZcaVFPPW8ZuZe/LAsskSPgSKw3Gt5GhSGNrhzNQMD3tmYvisZgWRrQ/a9tc9F2Ak08v9XjymTg8JUgmlDLB7gpP9DY+GWgPw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:06 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v7 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcGys9jAHnEop+WEOTn9cM8PXdSg==
Date: Mon, 1 Sep 2025 10:29:04 +0000
Message-ID: <20250901102850.1172983-8-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: 55471fbf-da16-448e-ed42-08dde942616a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5VLMIwDvL6O4/zp5InsBuLUrr4I8+3Lhh1RLLxVFvxJHKrim+RYyfw7FLj?=
 =?iso-8859-1?Q?lYs7BSt4F4qEIbdThbsYk3viA7Uxf8YjEbPkNJ3zT/VmdcSVmfMk6+htm9?=
 =?iso-8859-1?Q?0BoKBxch4Bk/365kmZYDScgxUr2r2nUlrCwmYOSgPOVJeSnUfaBViqTSFx?=
 =?iso-8859-1?Q?8OOG7cg9AIxZ9JuFJvQm1M7x8u1kevCQTcQT9DPj00xypD/ftCmbj7ZVAC?=
 =?iso-8859-1?Q?b6FgnCtqiW/eABJM0Y7GD9Ac9Ls3nXc0z1FIQ0xpWIkvRpVxSHT0AlOiHK?=
 =?iso-8859-1?Q?Y5b879TySIedWId7MvAHYH9SezpuDxwBAZFro2cw7p9Hf7NhJTLvWP3IMz?=
 =?iso-8859-1?Q?5bh3OvZ/I2KtzHhn3ViZ3i0rdl6F+CTieMOJIaGXF+57ERgMC5PyS1zG2u?=
 =?iso-8859-1?Q?o8isytUZj94gwCRvqvShmY2p4dDFcVPBW1qIkBWyZzByY0cEChWL8EBarH?=
 =?iso-8859-1?Q?MJ1+i16YtwcFl7c51hXMCJJKlfeSXU0Ej5UzD+Ws35CMfU2agDtFJm+ZMm?=
 =?iso-8859-1?Q?LkTyb5tYWkTTl6hIurBAIEh7Hl7iG1VtzPzLNPN5kdaUMPwNT8BpLVPt1Q?=
 =?iso-8859-1?Q?HuZbLyO9SmyZJnmIoUaxtA83JixkbksxWWyCjWrzuKFKwmTPGjtRYjAhmR?=
 =?iso-8859-1?Q?+Z0Y3e3+KSAxZO/buV5Tj2bKR4NN4rnS7SICuN+vC3vbtsE2bTWXRLgPIc?=
 =?iso-8859-1?Q?ukcG5YzuR6X1OgSCBuYeo7lXlHvaK9vjJTXVfxXxmlQLz24EbqjhHA3s+6?=
 =?iso-8859-1?Q?pIs7k1SEQKahZRU4ZvN9kzsQxAHuxeTCik+NEqDu7cjroiWFfJinUbnO/R?=
 =?iso-8859-1?Q?nvgaWsQ/KUv2uKllvz7+/W9AmztVrldkUmLurB4jTncDq58Du7Jgse1uR2?=
 =?iso-8859-1?Q?IinwQYDa4bc8Bj/J1t3evrOlnHLzX3ZyrcCHG2uz7Fzs5Gd75va5+ehxFD?=
 =?iso-8859-1?Q?E7I3hR2e36Apqx+fvM0p5b8R3qcD93HuX4+sBNsEvW3HBAKqoUnlIpmNFn?=
 =?iso-8859-1?Q?kEevD5qz94TQhfNLsbOFiaxtzswbDEvO0fWARbFHR5fZyEcZoL0qMIntlH?=
 =?iso-8859-1?Q?c5+h4a7Z8KGG3QZw5BybtoWopzsZUY3YZ6evxMgyg94UWF/NftEgT+b9xe?=
 =?iso-8859-1?Q?h+m/deHKLwuvIXVshmS2xPu+d2ixWUNgsF7PUa2KqHW5ZCo6dBJ8ctpTOM?=
 =?iso-8859-1?Q?a6KYIcKBaA3EzTlz73S4UDzw1EjL5ouo9iXkp6O3DkQAdGEzi1wp4XCvQQ?=
 =?iso-8859-1?Q?8GAosZFLQyB/bPmdiqpER7DGAufPIuZrTEN+KnjOzNoRnZXdkpU/aKHwTO?=
 =?iso-8859-1?Q?jVOXaD4m3xoyLm264W5jovyg62OQzlcYpyGmTN5yGmEzE/szDFkghCWYdO?=
 =?iso-8859-1?Q?dLmn/cDUkFvXFd3wdv+0UQ7lRqX2/foCGfrVhbJNUOiCvQYJux3yPLY6/4?=
 =?iso-8859-1?Q?l58HBFpSf84HqDatmj5dAO046IHopIF6+pzzRs+ZLch+v1/l+y8A60D0Lc?=
 =?iso-8859-1?Q?EhaMAljzpb76qUHAyEUP+d1ZgzcyKxlb8fZcKc8cgdaG7uzGHgp9CvUdy1?=
 =?iso-8859-1?Q?JUyHMmw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NTDyubDGHPglUbalj1xvqwjb08M+hL7OreOlS3NcXqLdvluFChyWEvwy9j?=
 =?iso-8859-1?Q?pL+UaJYSlSs6j64Tz+wF5BQ/fiA6bZg2T36W1zn5Id1kXzlCLcWhLcg9hS?=
 =?iso-8859-1?Q?VGZ6XJPY3QzXIBlEz53fzcb9/gGLdmwflPC+WCZX7LMWuuCIG+EmTQgqGe?=
 =?iso-8859-1?Q?cLVj4qM3cdY/SQknRF618wJlDXrAeRvHY7MIiXaWrEBDFzVaZVJ6qspGae?=
 =?iso-8859-1?Q?kmfBBDXASuicuISxnEgxSCJL88MWGa6obwsHBlRrDm/n+O6jwQILtIaEd1?=
 =?iso-8859-1?Q?pSgTZPWxHhBej5KHfw7gtVzCGNmYnQ8Fwndqfkw46gBGN8Eh1Vx9wHJBjJ?=
 =?iso-8859-1?Q?pQzyEjZMJiODL3Gu89/aBKG/HZXTY1kfhdI8wCnKkBD+BZ9HJrpkneumue?=
 =?iso-8859-1?Q?AQvco7+JAShY0QYSXQBiV6vTZoJPA7/KFfP1CZjq/XHhkoMobKtLDkzZIr?=
 =?iso-8859-1?Q?1pRphw8QSAZSgKm8Vrw75L5h8Vj+obQa8Vi1I+PtEt87XLmycSalBcehdQ?=
 =?iso-8859-1?Q?viC5uR7P2PfD9cSmQY6OwGzzngsWg/72i1UqlfhzMQyBKqmJcxOtJBUnGu?=
 =?iso-8859-1?Q?cqgAynbVlwXDBV3qn4epUmMImS/71Biku6s3K0FYuMtHAiEqmVzpA0+vp+?=
 =?iso-8859-1?Q?KYykGytIPIyeOu5PcKBeObXGws3FwlLP3XktKwBRZlORREzjRcl8JVaPoP?=
 =?iso-8859-1?Q?teKnrpfBIPRqNYCBbpM6UVwTTQqwnzshEbAhVfJFvyEO9y8/ai4tnRmpu/?=
 =?iso-8859-1?Q?KQIEAEfHqNdfuuaNgDlZRmVQdhzHWwrwokwdbKFW2bHYbDuLHvxFj7vU9d?=
 =?iso-8859-1?Q?UTEoNYnK2PmRk3UtAxgvWFBpgQD39+f4A5ySAvtUuw/iswDmILx/9N01ix?=
 =?iso-8859-1?Q?3+NAPvoAP+GeppRXAHssPJZ8gGpdeKgwER4TbklZMxAtqqOgj5HH8py9b/?=
 =?iso-8859-1?Q?MgiyQoSJ3N2j5cZue8IK+86zSiXJ1A4meZ9t3HJ2X97W6W+k3P2lpHWYQq?=
 =?iso-8859-1?Q?ejI9A04SY3DPDfPlqaURQhCPFL3fmQo3XM2q7uBp9yNgPSqF5W5awA4+ca?=
 =?iso-8859-1?Q?mY6NVYGnFv/QO40OogAyiXqExQEjRyOs1RmWBWsZo/7FXBTSn/b4LD7CyJ?=
 =?iso-8859-1?Q?evNhcnlkDekE9b6zCdItUhEkvHK00aCGAHg/MALbP/jZmMlpUD+IQK6Qsz?=
 =?iso-8859-1?Q?d4VjMysNxhbtQDWdP7QUr/RlMHw/w1QyB1r0f12g4kKUc1GxAwpQBtNDJK?=
 =?iso-8859-1?Q?ehDrOOIpgvwGMWB0YB03Nn8XKH6o0fxgcj4ME3XqVJ+vX5Y+nUjAlOxg/J?=
 =?iso-8859-1?Q?5z1R+0yWupmeAj9dTNdq1gTyt0U0Hrzsp1+ZjFgzRjz/JkU2yWQcwgsqF9?=
 =?iso-8859-1?Q?vqbCaOr39sQRhflBKoegk8w5uudWQvAByatKgKkMPd91AkOcI13WRbJXzO?=
 =?iso-8859-1?Q?IVK3l55pWKtzINDflCluw0ML+U90AymUpW1e/34r4NUhsuhyKogmUB+8v3?=
 =?iso-8859-1?Q?UD1RgFxeh+Xt7Fw4XRQ/4EGkeIdicpAowL4jEEcsDiPLjuncyUOMO2AvXN?=
 =?iso-8859-1?Q?2LC2Sf8gzRqzjwUNO8wXdE4L8+gEX5XkZYZvA8A7f4qB5x7SuO7OxSYD7V?=
 =?iso-8859-1?Q?C+QoqCqRt+9EpePrnwBSvZ0n835X32+KWMEqIJ/B8G3+0NDLkhTfFnyw7I?=
 =?iso-8859-1?Q?EKSfX5K1H+fwP+W2rx8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55471fbf-da16-448e-ed42-08dde942616a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:04.4317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbwzY/W3bUs3j/pz/zaMgl24IE/4P0nOy1mgenXklTdmvqOrmR7Jm4APA6M46bxAVX7Y/hNJX14XcEVYgxeffwR7gXUkouJGhPDzW5ZQjJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a22a5578dc..969cea0fe4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3296,6 +3298,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..f35d477f27 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -39,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 620c59cc28..d0c1c9fd19 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -33,6 +33,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -49,6 +55,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

