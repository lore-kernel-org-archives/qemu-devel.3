Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CFC55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAO0-0004vH-K7; Tue, 04 Aug 2026 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANm-0004r5-OB; Tue, 04 Aug 2026 04:20:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANl-0007Xk-2L; Tue, 04 Aug 2026 04:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPlGvT24Me5+rALzXuh3YC9TUGmWhbEAi9dvn4Idgkt2UDt/OOQdD23JdgReezXMUTxU37bh9BnXGpdR/MOh/r1dgY3J68H+SwIWWSC0ckVYHiS132uqMt5Kv5d1UYxptT0SQYBd3HKVisEpmYMJ/dzo6mIH69+LZgLevVCkjkfWhEL0OdyJnN7GW1RwwExKZsofn2+Xxc30k1WdN+x1X3S7BAKvS6HBFJ0faWdzMqiE6PyCYO8Io9uKjxwNBeDskIkTkeQuPy/Z0bJpPDbliGSeXCDRB/rKNLMbiTGlIivjHr0mDx4SACXFMzAUilp0Sfa+tqUCWzp+Wa5FNoRrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpGZvcx8KsI0katkkkPkqEMdxe1k9/rM7iTN7Jl+F2I=;
 b=MZY17T0iI7BG/jO6rDiwXdqP7HwCOYiwwK8Nbe22zTbsmMnzp2tw9kqLyHQX9Z9o8pPSe/LFv4GotLSrWyB/E4wrk7sP2/LfS/tOO+d3H+V4IM0POVQdU2vJpBCMAFqcZN0ppESyte/M0aMUzYjWntSdEd1V799cSG635/vtqBoS1k65tWqOpGGBaxmu/5Ov4RRfaBVbiVDyytGVYNpfJCnz9jWk20SaSwpH17G25sSgxBkCatas56f/TXyo96xwJfk5UtAzGicweruyXs8KFTUvf4zEZ5EYr1fiOAn9i66lXOuZj+68hMsncrk8aE7Wsc63fosM20Dn1C3T0CkqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpGZvcx8KsI0katkkkPkqEMdxe1k9/rM7iTN7Jl+F2I=;
 b=PMjJXK1T7VPJs1fnexaFKdtiK1lMiiX0Jk/CS1putjXj2Btox/szyYMHIj1+xnPCmSz+zf7Kk9DDFwI+6tL+xFAj2BQIBZfg3GIanEtLvR7kitY3bG8Uellanl37OM1YkQ227KYV+DIE+AqoqhJqDfz7ceGUKMWF67HGBgGl9Ue/YaMAQDGOdsCZ30yXBOlcWO3iqE1aNNXmX3ETHWi/jVMKZeUNzjFqeh8kdqzMvt8lK7vzioM1155VwWVKDrTU2MmyqpUjGygmMeCwWJ5Pz5P2hTfLhcOAX8XKADJj+gK34zYYA+HwmwZXQ0EbNwJatSnVbUCNPiA4OIpd1Zm2zA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/8] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 ASPEED SDK v11.03
Thread-Topic: [PATCH v1 4/8] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update ASPEED SDK v11.03
Thread-Index: AQHdI+oL3PapmFdsyEi/py4q0aA5dA==
Date: Tue, 4 Aug 2026 08:20:01 +0000
Message-ID: <20260804081955.1563537-5-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: 26d31f77-07ef-4dba-3c0f-08def2012e1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: JYQf+Sdy6WDPiXOGTA2cx4q7dBKqMe7EcjCnsczu6DuibJWGNd335ejV+TyeGhuFgZtKs0lzGH+rVn22oJr3wgFXME1YeZrXkRvUUXgnPWqEbqytj1jrQKrCR+nk1dMiL6bFxzfjHTv63r+BBqw3JE9xyJd8rBZgpoEXS0W8b5X/0cT6Z+fScpil0WW5T6ZwT7B+XWsc3p4jk+AoH5M7FkxogkEEvRbFw05emAstU2zUQKTaHiYRXLDDDMIF77Tn1/5qW7JTSKsmVSM6WfHZU6KTjx5pTSvrQOWfJwXd+++h8HtzMEsZBojskMX0MaOjHOxkg8dp7+Fj4iz1pmnCWU+pp+z4diXOjSMcp2go2RSAnM/QjNYrmfyB6tfzYCc8NxzlqPybSsygxJ8ljFQrr4pdqSlYFRq+qWRPlhAjmOIJRp/9hXjIJHn45KfdTowz8sqBk84hj/6PQxKRrYyPCGUz4pj1bFVnmA45McwWNGXtsSOXxKhpu9Gv7sdvd1Is5KN2cucePBr2xvWKVr2ni9RTtg994Xg6XVIfLWoYU6ev5IJlC7Y2nWvg2xoWSE5ilcmoHb/Q8H9dIm8j+sOkSmNwSe+2Dka8qBWARAZiNJtaerhoxwpdTZd6CyY3uNUakwecONC0h1g6uLj1Qs7l2WKqOCpQXpA9hI8uZJIyr/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qmd203inRHnepTsHYX2gTMnNa7vVLzbwJOTEzwuw1LY9Dgub11oCmlz47k?=
 =?iso-8859-1?Q?NLdv2iW1omz2mgu2APrqaOYJTAtpHJnHOUu4Cjx6eyZpRWJyGZbKcqLdM+?=
 =?iso-8859-1?Q?wy9pjuF/RUZhCMi/W3zWW8ougeUu6lvilJDsMqmhiuHnB/i40feCW8gzfi?=
 =?iso-8859-1?Q?/eiBAUJD0zabddjoY3o+c1GzVkMK4fTJJvngMtnUMWE8S2jepDR0OKPUAY?=
 =?iso-8859-1?Q?TMp50bGg/UwnLMu3G9dsdO4PoN17zEQAq6bZ+KI4x/nWcnMIPdXgFRJ5ix?=
 =?iso-8859-1?Q?xJzHti0fYCxFlF+VDjyVkK9/csuuDe9iCySe3K4NYT/5Ix34aKr6G2RYHh?=
 =?iso-8859-1?Q?MUS8eYWZa4vi5RVBq2cCwXyFEnhsloLvhC1qMgoUHitjcMHUdHm1tjpomY?=
 =?iso-8859-1?Q?VMlIblG6/7RJuoI/lvZAphxtkN4JVT4lPMkKxNOFe1626Y9TH+94WGHP6N?=
 =?iso-8859-1?Q?g+7lQL+gp3KshtiwIQHZmT2Q/B8stNjMDXyU6ZX2pcjHFVw86HK51xQNNf?=
 =?iso-8859-1?Q?OaoyXFF6bKX7zqOG7GOsVCtkDA7v1ES2LOjawkum42HYYcBLj1fTC0KnNe?=
 =?iso-8859-1?Q?9z0slO32ec7df8AMusBFAkxZ2WZGgc9zPmhC6opMrYQN6uY8tPGlag2RI2?=
 =?iso-8859-1?Q?oXjc2uDpLQc2iaZogiKFdVc0Vl6UJfOjyuS2CS1heTYGWsqbXsBkKql2oA?=
 =?iso-8859-1?Q?hcdo2n1hB7sL42a9ahm3YQCA2C82kPCZn9+5ZpAYig6RpRc6mQg1hlcSJm?=
 =?iso-8859-1?Q?U/KlH87GhYzkAyD9BH8+nNMizTuzR+pA4KracBcAVHXpF/cxyT/VSvIazm?=
 =?iso-8859-1?Q?/dGzLgGPgAQTmoRR1dFVlPphsR6og2iwQ3muyu46lq+xajA+uIeqv/JR6Q?=
 =?iso-8859-1?Q?LbxcMBeJhTyhty9j+66Ldin09ulR5soAyCJxdvp/2tid90i4UDl1fQdC/L?=
 =?iso-8859-1?Q?ZcURC5rz2E3y9v/W154Z3gOTMkO1s0tSDXuitvokQk/+J0FkQFoLpk6iFH?=
 =?iso-8859-1?Q?sWi0PKtQj5f7I7lx8Qff4cAQvmkY+d3ugoIerkvKdkwvrlHIHsd97mL7ZX?=
 =?iso-8859-1?Q?yQetlqM6sZJtpBk1HGmO2dGwGiQuAnP232070aJ+gNqI0Izy1MiLW8Edt2?=
 =?iso-8859-1?Q?E/l5mIivcF9iGFI97YgDmn1mGZDyxYa+RkNxweiAuZ2ZOfMxxSKhIIdfky?=
 =?iso-8859-1?Q?izggAR7am1826VXl/OfIEPd1Uz0R9ZvaLsWslp+IQTYLL0nEoNcCTyokjd?=
 =?iso-8859-1?Q?gCNiJlrvJrAFUO7kDaC88Pa7s0DvD/USSTLpxJG566UaO0BxsPb4hEH+Ab?=
 =?iso-8859-1?Q?A2rgMz9q90MMJwtkrfiJnHg4RLbRMmf8gbI8UUvULxZcYRDJNoam2vgrkd?=
 =?iso-8859-1?Q?zCv0ZRn0WXNggFx1ejxaDMm2ASUDK2ATfVPS1PSGHeORJeoEFHIJzBj19n?=
 =?iso-8859-1?Q?4xse9fljEnij1SQqiet5nF+Szy1pky1Lff1iLr9BwRB75HmDkGaR5QTYz4?=
 =?iso-8859-1?Q?vdIPtwXo0JGFolBAH8lP9zNWVceABWWgmyAoML+TKpI9SnxaR+mEI9uHxh?=
 =?iso-8859-1?Q?DxVCAlIVC/+TZm2lGzKGsFuaKn6A5VgW3szHa/f3s6ZtHLP5oY8Ka37Z5o?=
 =?iso-8859-1?Q?ZYaLHsX37Ilya1J9SrlrCi4lqJaKlEB6JvbuyEgFFCCFPkXBmfgfvlnxDm?=
 =?iso-8859-1?Q?mI/KVbjstJtIZ5+GC9MYR5khz2zaYMGOZ6As4cTL6AhHrCCLUFdWrqBXSy?=
 =?iso-8859-1?Q?AOtDIK61MIp/2qITHfkFiXF2VXDa3nYX7Sov1Q/BkMeqgYnqjPMoQqhPJE?=
 =?iso-8859-1?Q?DfIYFSUonA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nfjqRb2Wnbyp+DC8kIvjq+T8U0euPKTJ6+RgZCTr+Hhigw/R0/MbF9Z7u/iAJgxr7VYXs+TB5IMR3MuDrfvcQoPK8YQUzV8opUS/uwMCKapd4dJiq3R4aP6IAAkRZA0c4qvHNK2GFchPt+eXMObamw0X9uf58dGZ10ohGmbem1nSTbYra9NcR/fPe6bcglhEC8Tu/mEbI+XTIiEkvLpdJ5J0Jv8BSFc4h0fq79UU3B6Xe9n6R355XkbeP5scCt4yHqBkXW+mRGi3XR0c7CS2YBUjtvpYoY+a3EbfLH4s7qcDhP1AtFwuq0jxLkUG+TObcwKChzS9P8LY3fIR5KJzog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d31f77-07ef-4dba-3c0f-08def2012e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:01.5448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H60dGfXKV57SIFX6oLFOedwyYidSW3H1tm1dtrfi4/faGR+dJ1NHtwz82+2VgrOYrDkZo359GmwJDzE4QUbPgySbKdxDabuuQVeEfjceCzc=
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 21 ++++++++++---------=0A=
 1 file changed, 11 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 86270e6111..704477d7c5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -66,9 +66,9 @@ def load_ast2700fc_coprocessor(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
-    ASSET_SDK_V1101_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
-            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
+    ASSET_SDK_V1103_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-default-image.tar.gz',=0A=
+            'b91450d53da234591060cfb926fa30f7534ce20eaab766cb0f80ec332f8f0=
adb')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -101,7 +101,7 @@ def do_ast2700fc_ssp_test(self):=0A=
 =0A=
         exec_command_and_wait_for_pattern(self, '\012', 'ssp_tsp:~$')=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
-                                          'Zephyr version 3.7.1')=0A=
+                                          'Zephyr version 3.7.2')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
                                           '[72c02000] 06020103')=0A=
 =0A=
@@ -112,7 +112,7 @@ def do_ast2700fc_tsp_test(self):=0A=
 =0A=
         exec_command_and_wait_for_pattern(self, '\012', 'tsp:~$')=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
-                                          'Zephyr version 3.7.1')=0A=
+                                          'Zephyr version 3.7.2')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
                                           '[72c02000] 06020103')=0A=
 =0A=
@@ -125,7 +125,8 @@ def start_ast2700fc_test(self, name):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
-                'file': self.scratch_file(name, 'bl31.bin')=0A=
+                'file': self.scratch_file(name, 'trusted-firmware-a',=0A=
+                                          'bl31.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
@@ -153,11 +154,11 @@ def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_v11_01(self):=0A=
+    def test_aarch64_ast2700fc_sdk_v11_03(self):=0A=
         self.set_machine('ast2700fc')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700)=0A=
         self.start_ast2700fc_test('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
@@ -165,10 +166,10 @@ def test_aarch64_ast2700fc_sdk_v11_01(self):=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_vbootrom_v11_01(self):=0A=
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_03(self):=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700)=0A=
         self.start_ast2700fc_test_vbootrom('ast2700-default-image')=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
-- =0A=
2.43.0=0A=

