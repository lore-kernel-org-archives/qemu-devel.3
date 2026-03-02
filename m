Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DDDD58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEy-0000Vc-0J; Mon, 02 Mar 2026 04:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEq-0000Pc-VX; Mon, 02 Mar 2026 04:06:53 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEp-0005XC-5q; Mon, 02 Mar 2026 04:06:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0pvkADF1+TBeMLrYBVhWDV53OyP80xQI+oPbd5HujezNZEp+QQLm3biHM6QEVUTqGfwoOjGY7yzS+T9g9hbP1kSSpt05AG/twyui0VbaMYBV2DqbMJit6n0cnJi6h56UZaktOgrArSjA6o6GWyfcnXAd2fy0uBDaerXTkj1xkXQRTNHR6H3K/F2BcNA81m/IDCyw5FhZ5ru2LbjCzbBpoJIpKzta9eWAYGYVFYrLs33QHB8g1sofewTknw8pnFsozl/JmWecBwGCVBcR2fDqtMBTrmJYaXhklKiZ4hClNMBYX0jQAaF/1dNFWJLsGI5x4Jbjnbv/dkFNf13OeKkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryUBMFnih8KdC1w28YPm0l4l1O1Klv2Jjpp6rAinyTw=;
 b=M1c2qOMF0WCgNt0GMcTxGNDRnNwv8ZxV9pm+BCkpWDpuNAoS5v/9DFGNRQnPHa78j+ZfgpsfYPHHACpLrohj/NtFmDkFrqg65kinFB8nQXOiMmB4IoolhqnTTZqdvZlixp6G1SdS/npcu1NNAgBwvz94ii1Wlb2TBYhrZISEC4ZcBCQWKWaD/0zlirjLJcuXx28UuqoQUYfrkStdB9BB5v2d7j8YgiabqSUjdPlYL4t/gg++tegfh++W08O51Tk9zBpVqAjNaTYqcTvRhSlXC7HGzt+37sy0w0P3ZA3XmNcUXTpiG187uV+/FYOdvatwcmgNol+SOVwq+7h0tzwaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryUBMFnih8KdC1w28YPm0l4l1O1Klv2Jjpp6rAinyTw=;
 b=RgNBQdYJMfIMbtphMGZinCpdLOhVv7U34NBefFQY0eyHi3bOFCzhz7ca7N/kZIIQwV2loEfrJVfOWV8+IKQ0c29iWH3K9jTfKV4GevwxL480dbdHW8wt5jmz+W4yRCk+ysC8viEzuGoAKxpK/+uA0MNLz4/5viXh6c588sbVPOO48cdqjGqvv77r07ebtgsMZ02d4PApsa7GbgB7LM+1IU6kzy/bgmTCLwZ3VHR9kjPH5zzXU8yCgLNb0//qqudf/MZ0q+uP0jL85kxiwU5f+A69+jkkt3pP81sTpQZRu+SF0XNRdeCw3ckYdFPMuqXzv6yR1XjAYPkRm3o3sXZBlw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 09/10] tests/functional/aarch64/test_aspeed_ast2700a2:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 09/10] tests/functional/aarch64/test_aspeed_ast2700a2:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPg0A0Srr2O3kezI/yKU3LJEA==
Date: Mon, 2 Mar 2026 09:06:37 +0000
Message-ID: <20260302090624.987922-10-jamin_lin@aspeedtech.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: d1f3fb6e-f2c0-46b6-e760-08de783b0389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: 088Ii1PVXPVhPWUXo5oCjmOTEXHNHTIPxk4J1zdVXNB5tQHHScIaaG0tUL/ghAvgRvrKtdWcmbAPjYQwVDYO3Rum3Nr0nFSukjw1LDtJgLZaWRVFmNJ8gK1HPpxqgGcz1X7FEejPfK9Bxx/bllAQmr8Hj4S5FpQ/PMDThNe9spDNBBpBWs2y3dJqpgKHeQBHQpGXUy6CuOxesZ0pee9PplFc/G4fYzVIblGxhy0rOUS2k012HjuRC9ExjOUdsCfZ81+S8jF3amRrGNr8ckUZJ+6IVLW2tllyPa6/Oqhm5sGoTaniniJNVFLBcAc4b6g1IDZg9UTL5gmz1l+ZrDQTQ47yUh8aR/k3iKiNhiYM6WTbZtjv+Ib/y3AqTtO5pBfDaqc2+TgfW/DdWpAi+ZuLGlkCAvYVwcxuzdT/4lyOEl+ZaPsdBLwGHGcs9MF6+54L9ejLylwWJR3WJjRA+vSWzT8ZTNGDtrbmx28ZFp4SUeTCBzC0uEqDUBxPEtdLCFp6r53eqDc9chogHQfr/alHT5NRIZIF0iI7gt+Ku1a5GJ6uJCViX+/tTiP0zFIB2Kp7PEI/u5sxvaOt3QPTg8/zFBtiMR/h78vyDeMFs+nb8K9rN7JzBcIPrHSAYfGpfoXpc+HyTtqLPtDqGFp1QFrtErb9ORheG3qMC3wxCrIQOmomn5IbVNNqHGtmdzaTPc8TH2/ZswkYY/w82kMX6DmbABJwmo0DRnpw4wjA4KiNQAP+BeKGPAWHtgiva4y+Rucm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JtFbbAXBKr2a+i2rvT8PsNR/24hljCu3Ev+cM3tchOHcuWBCcmh42GFRrP?=
 =?iso-8859-1?Q?JLE/REy8Bqdvf4mmdTKzn2JVf5CmvFv/jD4krpKMfMYnvAlXKW/lZPRZA0?=
 =?iso-8859-1?Q?tWoWUbiJp2ucWVbse1NSBoLKyCqKaWA2FNarAXg0zJayKjpuE9H3UIjcj4?=
 =?iso-8859-1?Q?ICuzigFzHv0jB5QOdJcvFuJ/a4XdPzYbql8CsR5Z8XzCajCamowGLDHuFr?=
 =?iso-8859-1?Q?ohwXbxFWKlu+1mv6+DRWPIrk1QL1+Cqx5N4KMGmJJVxmSCww76CWQA4wa1?=
 =?iso-8859-1?Q?uocK0bcMMFL/199v7VvTeLtGnqpCEZVn2UNroTLAZWLhCxg/XOUG/RPOKB?=
 =?iso-8859-1?Q?JBxzPAQHpAclDSrWkSlkxe/aFEq9HwQBJ0xJHULHOjWDaOviol2ioV+NBr?=
 =?iso-8859-1?Q?1GWxN8loYMzzMxNB6RVMFS5ZMvbEVI04eXvH2DMzhENWlksCSgVQXAH4im?=
 =?iso-8859-1?Q?ZGy/d2dsf38ACH64n0sDXAow3onYajRCuWXJuGNKgXjoAUBy7xyoqfyIWg?=
 =?iso-8859-1?Q?D15WDMlts7JucPmzZOrnRsOwoUWCKivYLKU6e4kxA9sbaUI0gBaf1a4CO4?=
 =?iso-8859-1?Q?1GW5/mj9fADL4nFtfp2zJSBkAftH2JURzXP42hpet1dGdY3qr9WKl/Vxas?=
 =?iso-8859-1?Q?sxGQwHTaH1NmFFJ87/dBIPoKWtNpUQ+Kx/cdpAyj0RCYbnVX6hgufhsXIC?=
 =?iso-8859-1?Q?L4j4tXk+5EALMpotw5YrUQaBvgycWPZ45Q9zolf5o5gAbHHaNMkPEPXZxt?=
 =?iso-8859-1?Q?r06TCqAEIdAYJVIqPMdNgiZobCFB26U+S4ntTgUZqHpOQdXF81pQOtlFjy?=
 =?iso-8859-1?Q?SHOfrArjiSFCxp3HfqKfLjX6EN9YJ67YB1oB5xoWYP7nIAIznuOX2yYwrT?=
 =?iso-8859-1?Q?aZBoSA/DheB0usmohIYR1ywUrguQn95i4u4ccnqyPNHn9EghJ8RcEEk3sP?=
 =?iso-8859-1?Q?jF6PC1akMbHxJK2gslzPHR0jqs/UWPdSZiwTHUgmIlQ36v7pZSyk+QtC78?=
 =?iso-8859-1?Q?/X1dbydBV65mqfQ9+5TuAd/IGTewESPjSGTZFmvW66Jh6sHZedM1fyvAMA?=
 =?iso-8859-1?Q?kmgrBSVz2U96LhYQ3wJ5hV6DiaGr9feP3z7ZKvl6ZarvLw3Eb5jPuRUcit?=
 =?iso-8859-1?Q?2+GbEdLkkdrRUuuGaLHS+k0bjo0OzDb5brwrFDOQ95TB3HvcQ1r1XS5oPj?=
 =?iso-8859-1?Q?X6awLqeLQ+IKuO56WJEpTLz05MwDiOWPEaynGb5zkGxwjMRso0ZNzlXmks?=
 =?iso-8859-1?Q?Gyc16hl/7g6Zi3igDPUiEV9TGC4ZD1u9fUXj70MyD/+qzOPBb1/aA3CC02?=
 =?iso-8859-1?Q?l3h3VcRa/c5tMQ1BjzFt6HazAxMLD/Dtml9kqxsVS9A9P2vizGHjoqcbzy?=
 =?iso-8859-1?Q?Hv61IoG7p0WKVR9LckO+69iDHzO1JZQecX6ITAWOlE+4DzaPgPz7bhk9xE?=
 =?iso-8859-1?Q?I60deH2Vh2IQ90xHYq1Hr0Mske4rYfgtbf557DnbwHUFrbnSpt42o4RyT6?=
 =?iso-8859-1?Q?il/6EomLHT46kq6K9W6yD8/jVIwid69SGnRP0gxlelo41gyjlHQR8UWLfU?=
 =?iso-8859-1?Q?rNfRaYJgznKx98sKaFAZwIYj9/YISJd5a9SJJvZR4l9WIHrjcnWBiWcI/x?=
 =?iso-8859-1?Q?4MHqZaeXOAfK1Eol+iGq66sIogausm1Oj5UZcmzVcorfU8u5n/hZxYWcc7?=
 =?iso-8859-1?Q?mshZ6AAPqWafUIgl/oiXetGVHcXgOxTGwr1AQOTnBoXLlhIyixPISnp9aa?=
 =?iso-8859-1?Q?d/NBOs2xDEYO0RjhSo+7ECxCldH/RIXQk3n7T910yQzYfKIY4TKP0XZsKg?=
 =?iso-8859-1?Q?q8dsKMLlig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f3fb6e-f2c0-46b6-e760-08de783b0389
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:37.6984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odhEoCW63sbaB00lfEtWm8q9qnEVKf739wgNSCgxX/kuvUYDyRMNAD0s9zJyA34MlQ9gnsq590WlEKInQ1HYr2DuzE9qef9URlEtEXz265k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
 .../aarch64/test_aspeed_ast2700a2.py          | 30 +++++++++----------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index e527518a55..d32ef47ee7 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -78,13 +78,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A2 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
-            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+    ASSET_SDK_V1101_AST2700A2 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
+            'ce89dcd995cf284d41a6a4bd17a1b97d59939f0277bfe54fdaaf30e741ce7=
487')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A2_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-dcscm-obmc.tar.gz',=0A=
-            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb0=
2d0')=0A=
+    ASSET_SDK_V1101_AST2700A2_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-dcscm-image.tar.gz',=0A=
+            '13e54bbb81fc7801d0bd51361197766721e724cae73d4bf5a849695a75600=
ed0')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -150,38 +150,38 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-default', 1)=0A=
+        self.start_ast2700_test('ast2700-default-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-default', 1)=0A=
+        self.start_ast2700_test_vbootrom('ast2700-default-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):=0A=
+    def test_aarch64_ast2700a2_evb_ioexp_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A2_DCSCM)=0A=
         self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-        self.start_ast2700_test('ast2700-dcscm', 8)=0A=
+        self.start_ast2700_test('ast2700-dcscm-image', 8)=0A=
         self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
-- =0A=
2.43.0=0A=

