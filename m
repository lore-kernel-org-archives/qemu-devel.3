Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8330C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6E-0005N1-F8; Wed, 22 Jul 2026 22:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5r-0005AH-Qc; Wed, 22 Jul 2026 22:23:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5q-0002ZN-0L; Wed, 22 Jul 2026 22:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5pcjgEOmVVz0+nssDNBUevAf7LddiUo0LFVWWZMKpjgsfC+f3m9tzs5BV5TtKkotLp43ZbWOrTAcFVGeMHdoVzLQMfFe1DsnypjL9YON4FAZVrRV8COFb1HIpaKxGIFAWlAgAj2HOeWjCAlC4+Mj4jz94Zt+TF+PbdIjZQ+FHqNJUubq3FzDXhC0j3K9bc0Ns7FTxBnzzwXKRVGFWHPl5JjSUd4punsiE3AGWbjX1d3DdPEjjhK2opH2yCW/7AptJ+MN7WbQW6iDtu/aWMauCSguAW6MUnAmd9AqRvT66Hs5LKfxol6Qb96BKZ58KS+H5L7QdaGElxqWL2/ASZItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNcprsVEnRb9bXUzjAFi8+LjloDllA7bwu+mx9f5/94=;
 b=jaxMxRMslCH0sSmtsWfY8J/h14G7t2pxjyTgHlgIMZ305xmViuxVB56nWWyzRb+LzC+T4p7UYyDQmfxEewp24AcmCQo4uyLOMmwfElHV8cS/acEwp2MdS1HBwJULkjoZzQ8EBGWn+6YnNch9MMmISSeMo/EqWD5nxsOTfRvo7nWES8JAmfgLfWUclwie7NMOZaVpQCzx3ZZJdZZUzDzwpU8X7Ok9nwbWaVJArSQlfBQrzNHSzJ1oOWDTS00K7fysqCIOC3cFiCqD+G/O+upGllZaBPwEkC20Oa8YBuVfKGpSO3qyeQdS5uxF/ofEN456/LeRJGTuO8Kngf5p2MHO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNcprsVEnRb9bXUzjAFi8+LjloDllA7bwu+mx9f5/94=;
 b=BUNWS/RSSZQX1mgFYbPTb2kUVb0MYc4kP2/fdJBtaarFBtyLhZnwTBf77mOHICXo8XMx7esypFnapTZWmFm02tFQQdRE92GO02jRWMWyWHaRFb7Yk0uIcm8YwxO8u5p7QqmtNsmHWYRFjegNTVEbUOX+WRvjAf7r0K6Lbz93FpPm1aOQqY0V+pdjSTtqhuNT3VXPwhRcZy4mKUd1Dgq5sNCyf1ddUx3IYdIg4y7RQYioYiyOEvFD5Dq3QP3/3dt5JoWUZ/Tzwax5y/iwvcyAvxj3B6TzXVLdd6dxQr6YQtoT6WApT+v8XfCwx8eFT9b6wbbLmmSNTJn60wuOFWeupw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:13 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 10/11] tests/functional/aarch64/test_aspeed_ast2700fc: Boot
 SSP/TSP via PSP and load binaries from DRAM
Thread-Topic: [PATCH v6 10/11] tests/functional/aarch64/test_aspeed_ast2700fc:
 Boot SSP/TSP via PSP and load binaries from DRAM
Thread-Index: AQHdGko2mTjMc4J4x0OGdnFHAzPEpQ==
Date: Thu, 23 Jul 2026 02:23:13 +0000
Message-ID: <20260723022300.4174471-11-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 7ea721f9-ccf9-49aa-01a4-08dee8615910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|56012099006|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: SnSIgjIKO4Zbu9k/VFDJqhMi0tzGvKHQkBRKfYIFlqle3u2tQ7gfLpojHhsGoWDbXWKxplBWI0NoUoBGQxvsSwTZS4xDWe8qR/bTWQkEXvtDF51zlEscWabVelt+hPkiAtAtFfBwRPw5PcESShmY+0wTTDPUg3jTprJa6Edk4dlSrGwXZokGD4yegp7EEmI5YWSyasFE3TGvbqclOHu8Eexlt12vFccTDJ9yAH6sVZuqFYnOExFZCva3SQTb7mAcor0xDyX5V2s8zQ6FEJ0guPLLHBZ/17KRPq3JdT/TPIBuXjY2ee0UrywkpdJy6Uek6bGiThP0Q2/2BWddtamB0M5Ic63BIV2t5eszK0H9GLIfVaQeh6SVgrY5pPG+Eh3S0hIblyRdSTlZQar3XR499sBdp0ZjvfzS3n5srOOHJnluiNGEhkdgBT1wlBCsqr+CNXztSoO6VLv2OVJoTmTDDgXoZmKOeuLaoYJclvXJ+2quLA1ERKXzMHQZtjKsT6/eSG+2O6ULH9MRAli0KaU0Tu/j0Wfx9raSgHvDwjcKyRH9LtLETZmxkgacv9s6YpXegM7OHfjhZm9wwK0pnn4Zxrq6uHkqUljYPQROvk8Llr3vKO607//8mmTQjTj/pYTWDle2ksDfWOym80VsL/Z7KL/W4VintvFvGXCkEm+qh3vZLvIG/xR9mGJ0IS5LAJMu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sj3UYFhcj4m6jRE7HLjFquvXfrNJLfejkUZpq5L2cq/rP1idLAiWV3DfdX?=
 =?iso-8859-1?Q?e7AhghSAEkJvBpgbLucb8dAO9TKsjZOICy781tzGPNSS0HOCnFLfDhgKVu?=
 =?iso-8859-1?Q?zH7ANVwnNIQw8WDVp11Sa+g6Nsj11vYe8ZCIuMhuTl8DUvuYVP3nnGqvPR?=
 =?iso-8859-1?Q?Y/0ud1A06mYzOxzZJ5143UXqg+RI9vHiBVFmnwea5xfgr4bN7GaPMuq1Mq?=
 =?iso-8859-1?Q?Y500a4irDxxeDp6OyGoms+/NNzmKy6tblF+6qWoz8hErzS7HrdcMG2hiAi?=
 =?iso-8859-1?Q?jWIDY1AfJD5nWItkT2cv/IJ4esT6T0ryMkVqzmQRWgZVi/8yR5W0biy7bX?=
 =?iso-8859-1?Q?FyJi+L5yMC94I68qI+3LlhUqps36r/ImqKSxxUYeLKN/krjwPGsYSyFtWc?=
 =?iso-8859-1?Q?odxI38XRNGDuur9D118HUla9ba0h5uv9gsBdWYKab8qLqOfQX24SnlOkJM?=
 =?iso-8859-1?Q?0Vkp/mzCP9fO0LPsjNJg1dG02pcHeJ7V9XcAKU/gH57nTTCq3513cQ1vwk?=
 =?iso-8859-1?Q?4A3JbFVHwxSyq4n5VXbvAl7J/DG5byytMkTpQSLInGwEXKa5OB6NxGmYq4?=
 =?iso-8859-1?Q?EXO07/OUU6hrsruKUEkydGwheGrXcX8AtszL7B/qyym4FjIeeFj2kXuoJl?=
 =?iso-8859-1?Q?5wVMNq874VR/wdKUSshGMtb4hr2rfo0W3Y/4GnYK3+oZR+lELLNNqA34Ja?=
 =?iso-8859-1?Q?UDI+XABvNvuNdun8XUMK4l2XCpfQo3KCQOsrPavyVyAmbDjBCgPRhSKv9c?=
 =?iso-8859-1?Q?q2v9abJsdq9uRAvEgoASyM9UD+MBH4aPdF6kj1mEiQu/GEnU2FJ+PavpjW?=
 =?iso-8859-1?Q?1aISAsF53GJ73jO5Or0jMgSKlE9tgnJ07e1tMphTwEE3TQkLk1Vt+DeRcN?=
 =?iso-8859-1?Q?8ha9Sy20eQz2MxkuibZTCth47CejxvGgoN3ynO8db+RHHe5tEjhhaAFr23?=
 =?iso-8859-1?Q?+v0VY5KLyFxPP7KeXiTC0A+Vz2OEIIC+Bdup7+I+VQytobfRWKf5geYx2k?=
 =?iso-8859-1?Q?OMbY4Ym87s/OkHq1dypQsKN3XOUKvgtNt6DR5soTv1CHGYL5t5FPDxNUeD?=
 =?iso-8859-1?Q?/0i8VmvnOWQCPP7IfK2O0PxoNzO5+rw6wPMRzXlkLQCk7l1BnLwm9a5VuJ?=
 =?iso-8859-1?Q?4D/7EXACpu3PztIRUSn+V7dz+QQz9iiFhMvpIXEu3wkc8oi8Wcnoxx/cv0?=
 =?iso-8859-1?Q?9bC1Bn7rNcsD3O41hQKsY2butaa48FgroUZy0yGBOCentqmv3cTlkQ0zui?=
 =?iso-8859-1?Q?5PquZB3UKU9JjXiC22S5TN9k81rf5cVxAW6+zMaVfISO3naZwfA3CMHryr?=
 =?iso-8859-1?Q?A4laks4KsCUKnYtkrc7lb5pXq6hdmFbZDEkCoA9OebSgkAXmmiZOJY2E4H?=
 =?iso-8859-1?Q?ahmHZFj7N8bPwlwwMw3D/DDaQdmKecDvgbda7uo86V2sqM04PWAs2sBu6z?=
 =?iso-8859-1?Q?3+Qmf+ttpEvJHQCsnoa19Ij22IUtrVd/rTkam07070VmYT7TVvxtT+vmx6?=
 =?iso-8859-1?Q?A3j8Xrx2fwvhuRd7/Z3gbHC2GffijlBDfsLMpDKKZJgkJt6k3pT5e5c6kO?=
 =?iso-8859-1?Q?c+qbSX1QVxf4LOHbXQtSoi8d6C2XeF0Qwc+B1vz1TghKGsy/ZRLcn5n1dT?=
 =?iso-8859-1?Q?Hvqjmo92G9aSdGAeLpjkXFE2hs5iYwqbovSRt19FePY5g8k++QH/PvvOM2?=
 =?iso-8859-1?Q?InDDAwXFhEaL4EWd9q/sUdhXTvt8dkPDfem+v5fTRSQfMdkrJs9fr4oViM?=
 =?iso-8859-1?Q?DQstwWM0cOk0LF137uphF3CP0XdF5kw68e+mIDC0SvYVaDKGcAaaazPc2x?=
 =?iso-8859-1?Q?moZU8so6Yg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p8Lc9v4u3Ai17ck4puUJHZgDjRysqVGiwtH0bpkVLds0/XjwFA+s2pi3/aaRV7oB0pg9UuKP560CwTxp6MdknIoarMyjiVfM2gDJlIV3ztfx0D7gnMjkYg5jw3stY6EiEXsjFnf5/UZgA7QNBbsS2oLntWodsM2GMnLlnqz7MUFUCfch67lFumoMr6mL0LxpuLA+N/B9wzOSr6rtklOndgH2SPzTu4lHkUfTx+7c+deTYzFsOKePhL3yCK2swH3XlRs2sioVdHo+gM1G3mNuiyCmRmz6GUKXQUXgy5YfRnZSrZaSp7KZ6skYYjJ36KRSBZJ28scpu+AC7R/m2n2utw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea721f9-ccf9-49aa-01a4-08dee8615910
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:13.6840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjU7faevnT5zhfBXhAS8AEGQ0+A+zuMFJyIN9kwCy84lf1aoARmGx6xyNTkhGQ6g7IW+aqylcPNsujW6bQS4x7phn0jHvKCq/owa7E5rXWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

SSP and TSP now boot in a powered-off state by default. Enabling them requi=
res=0A=
the PSP (Cortex-A35) to explicitly set SCU control registers at runtime. Th=
is=0A=
behavior aligns with real hardware.=0A=
=0A=
Update the AST2700 FC functional test to reflect this behavior by enabling=
=0A=
SSP and TSP from the U-Boot shell before booting OpenBMC. The test now=0A=
programs the required SCU registers, saves the environment, and boots the=
=0A=
system so that SSP and TSP are powered on when the PSP starts.=0A=
=0A=
Additionally, switch SSP and TSP loading from ELF-based CPU loaders to=0A=
binary images loaded into PSP DRAM at fixed addresses, and remove the use=
=0A=
of snapshot mode.=0A=
=0A=
Changes include:=0A=
- Add enable_ast2700_ssp_tsp() to configure SCU registers via U-Boot=0A=
- Remove snapshot option from QEMU command line=0A=
- Load SSP binary at DRAM address 0x42C000000=0A=
- Load TSP binary at DRAM address 0x42E000000=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 29 ++++++++++---------=0A=
 1 file changed, 16 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index df889134ed..c0204ceb6c 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -23,7 +23,7 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
-                         '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+                         '-net', 'nic', '-net', 'user')=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
@@ -31,6 +31,12 @@ def disable_kernel_crypto_selftest(self):=0A=
          exec_command_and_wait_for_pattern(self,=0A=
             'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
 =0A=
+    def enable_ast2700_ssp_tsp(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootcmd "mw 12c02204 40000000; mw 12c02120 1; '=0A=
+            'mw 12c02224 00000200; mw 12c02160 1; run bootspi"', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'saveenv', 'OK')=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -48,6 +54,7 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         self.disable_kernel_crypto_selftest()=0A=
+        self.enable_ast2700_ssp_tsp()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
@@ -55,16 +62,6 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    def load_ast2700fc_coprocessor(self, name):=0A=
-        load_elf_list =3D {=0A=
-            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),=0A=
-            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')=0A=
-        }=0A=
-=0A=
-        for cpu_num, key in enumerate(load_elf_list, start=3D4):=0A=
-            file =3D load_elf_list[key]=0A=
-            self.vm.add_args('-device',=0A=
-                             f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1101_AST2700 =3D Asset(=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
@@ -123,6 +120,14 @@ def start_ast2700fc_test(self, name):=0A=
                 'addr': '0x400000000',=0A=
                 'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
+            {=0A=
+                'addr': '0x42C000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-ssp.bin')=
=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x42E000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-tsp.bin')=
=0A=
+            },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
                 'file': self.scratch_file(name, 'bl31.bin')=0A=
@@ -143,13 +148,11 @@ def start_ast2700fc_test(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,addr=3D0x430000000,cpu-num=3D{i}')=
=0A=
 =0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
     def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-- =0A=
2.43.0=0A=

