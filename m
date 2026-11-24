Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA5606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=D1PyeKfU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjUv-0003tS-27; Tue, 24 Nov 2026 00:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUq-0003sE-Im; Tue, 24 Nov 2026 00:55:16 -0500
Received: from mail-japanwestazon11022096.outbound.protection.outlook.com
 ([40.107.75.96] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUm-0001gQ-Qv; Tue, 24 Nov 2026 00:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzSN2nXVDuzNNv2ldbxjAQKDczfRGD/CGBjAF5c7rFSWYyoBY9CHefXQAr0ewBu6u8pEwZ0+FMA3dJoaUdqmQDY8o6HeSXYm27lYhVjwqQslXkrF/QhbQbs/Yd3oDv3ay8ScM23vLMBNL1ysFnYx6puHxX5XgEztLegstmCsIL4i357yLHAIFigcvmoJq+4gyl5KdyZ931UIV39A8ufttUYj/jjZ/BX5iivLPWqeFKj3R8jkTWBP7VHAKlSQa2uThgvGCv4b48Pbc1QbmqMQMtMAZp/PSxl8ux3z1SXG4xy+mV0dj0PAt0VQ4tCG2RYNrjZFCchU8APazVBMUY/Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAL5+AHYglwFgJXysfLPC2VekhvE7tw9J+YLIhG91h4=;
 b=NGkUZC5vg50PSJiCTDSYQZUCJzbCvqd+FHA5htB9wHg8xNFxPUro+gQm4V0plZl6zJX/CJTDT/Z1AqdHE4wFJS/5wnwGDCcBEu1sv3hUwxB+1FcXmXe/ZcDRIFseEHVofYQnsXAbyG3C8zaprS/9gXs1wdByl6xk/O5rOHfQDJAtr4hAOKQKlVZp+WfDKmRklCEOWbUfBnibvtzlobFIP0zhvgp9DSaQLXgyGQzo0SuJlRhOlq239sUQ7EXXojoJ+R5DxmfH18cVyq57skC2LPvFZCfD/Mmm3E9GH3mXqV/Gegb/ZN6o/VRLXEtysfGd+GSMpjHfNQ5uBg58PTJX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAL5+AHYglwFgJXysfLPC2VekhvE7tw9J+YLIhG91h4=;
 b=D1PyeKfUEuSPQkd98302x2kK9y8Jp/fA8eY7UXZILW30wy3/i3s9acEzLgPQmf3xqSSoO/EXOxnNFxuwk+bfVKghGKrakxOxkIv2VsyJiIhAF2W9THj7I1kpMwEmPHYAA/V+agNKrcm47q7UgDLDOztoDefdPbMYcfsM0kZZe2+h7mPkjwxR/6IklI+Nf09yeWTdjzOGOF0CCyApXw4AkTDtJM5mqPVQ/G0s+k06RTikmPA3Ytps31u078ul4s+G4gdD/H3f/xc7wpQ5YLOi3EhL3X/+znD+WVfDFrcnruYYqJ5hxnFVoJZSe1Uz5XaBr6qhL2l3DZ0jO6yGAqYPSw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB7038.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:52:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:52:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 10/11] tests/functional/aarch64/test_aspeed_ast2700fc: Boot
 SSP/TSP via PSP and load binaries from DRAM
Thread-Topic: [PATCH v7 10/11] tests/functional/aarch64/test_aspeed_ast2700fc:
 Boot SSP/TSP via PSP and load binaries from DRAM
Thread-Index: AQHde9ftMr++Jq1BekeY6Uf4xVxBbQ==
Date: Tue, 24 Nov 2026 05:52:02 +0000
Message-ID: <20261124055150.1328856-11-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB7038:EE_
x-ms-publictraffictype: Email
client-request-id: eeb5145e-f3e3-4350-9074-cf468dde126d
request-id: 9e19af5d-ec18-48bc-7f97-08df49ef101e
x-ms-office365-filtering-correlation-id: 9e19af5d-ec18-48bc-7f97-08df49ef101e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|261102123227099003|10067099003|261021123027099003|261021135927099003|56012099006|261022075727099003|261009223027099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 77ozloZ6ebGVhoqyAPUBrVxTxxb5hWV8znsHr4r2gVkdzoSkgV6w0tbUgm7BoQfZsiWMHTzduB+XonvD+0VflGzA9WhKDAnHQgD0TviIxKN+L+UwgxvcNsa57wNvx9RYD6t2TiVWqOy1GwbHizFI2wIsqp51xYZToZYTKvE8iA8FJQjmY92ynGrOqdgf4AynOH2DkoAf6MYGDSCm89j4EnmP9ZGYaC2qQAyjRZaGhroO35vppYxhdvhF23cmsg3ZAnFMlR6aKthPYAL/hzByaRLgeS907UgqN6DTalSPGyfBss2qxmr0DCgUVey0mJUK1lHNYWCgj0fBOGF6zbffSQPzV/WbqlpkAecT1Zl5MEASOV72ftfgovoJQrSPsTf3OgZ53tTMs0nEiFIzM6fKFcXN0zBJmMsjjs9Y822hOf4h3cjJUHGDCazi9qhklah4rtQjkGkPsr2uhIkgWGR1BtLRD6LR6dcOpNvo6QXkzDzEQdWC4ARHkMcl+QNFBy7GGBkwNW7rpYVxp8OUhQNW+anMlbxNASu7KpIoOP1/UaqjLBvFGBjO+744iHxEcb0rKunaVpEmIhf36ZIUelAvzuZ/KPajmWJNlcNqnUd65b4mB6O7NpTx9FCW4hCvvjDUPdWjLwPisjMqrOsDmeGXd+rhTg30Blm8GKwBwgfBre0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(261102123227099003)(10067099003)(261021123027099003)(261021135927099003)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ifFomzPww/45sf/Md1tSeyYOTVCLbSrwoSn3UZsnu0rGZDIDes/SX+J19u?=
 =?iso-8859-1?Q?TyTsOeBFHrcMsAybgqC4CMsO+NwdzJG3ibzmaHVUdHl/3+9tdrVI4qlX1N?=
 =?iso-8859-1?Q?7N63t5ju3yhhMr6oTT4XCtmg29gCeT0Jd2mhKt4aDvKvmEFYw1LvQYPsTy?=
 =?iso-8859-1?Q?6YklwolLvwUMUwTGcmjcmP1eHRgwqEl3R7g3clZI5KhqzsCsE8/0fqnzqQ?=
 =?iso-8859-1?Q?7keumHGviTmZSDc7pfnAvBDNVpRKGmAUDXq/VyPX+v3nWZdG/NJ1y7nEai?=
 =?iso-8859-1?Q?D3EhANYjSCZKfNJsFCYaLQWpfloZpzAtkHhA+Caf/GuiXjAh3fODtQEdvO?=
 =?iso-8859-1?Q?/acGHjUnb4uLA9KkpKbbd2ky9jlgDLIn3VmHrmaWCsfeF0kSTG0Xa1dNf9?=
 =?iso-8859-1?Q?dRHlgbtXQ5928RKJYYUtc8035jrDH1r2gH8CU1DlLQ5AIabvKDIwu4b2CT?=
 =?iso-8859-1?Q?F40ZH/xeBpJdJgvVAfJaTDeJUcY9hFsWLW3SrYHIAZ6oU2ZlfUuVMfYXMO?=
 =?iso-8859-1?Q?FPOrg9VEkRSQT0o6hSN30cGDlthS3/DcaJBVlEeNji/uHZxPJXwXHargOR?=
 =?iso-8859-1?Q?EJKuc5ADB1hMsxOS3QzflpAO9R2RlFzMy7/958VGmT4Mh3XupTI6Z6aC7U?=
 =?iso-8859-1?Q?O6ySHAu80vNSrd0K0xdNI3P8mSdVQTvTDvnCZkSb3LEbhZUkTtmytiS0Kr?=
 =?iso-8859-1?Q?LM2REqC2Vc1OrrgPMQfmVL42AbUNwLuL900iPDXTIyk97Zx7DVmNazUV0J?=
 =?iso-8859-1?Q?0f5+oVFnalgKpkZdQ0u311eQripwWraC1ro/REgtzTsmZ2xJmykBNp827R?=
 =?iso-8859-1?Q?s+3P5SOpB4wYouQvwWvsWSjvDk/HrHSA4/yMrMUhJe1xqOpq6ulkZ2GOmq?=
 =?iso-8859-1?Q?6qUCnhuo7w/pvCkNu8S86mhS/Dksk21Xp3bA6ziQwaxlEuFJhgPzBRFqAz?=
 =?iso-8859-1?Q?riHJIN5V9wl88ZWPHuRXAuzxiz/HuCrrXy/R/5Ft17SfaWOZcB7Hz+EhRZ?=
 =?iso-8859-1?Q?65KhhzUsmv+ThcNX0rolXc3VedIrP5+urVwH2RbNQkgwDmtxgJlcQnROTI?=
 =?iso-8859-1?Q?gQ34+aLFytN6Aym0HiYi49pIoMu/NJhmlM73pe3l2GrXD9WEVxTCSPiW37?=
 =?iso-8859-1?Q?phGGjVl3UeT2gQXWDbZudO1A6QrJWCENi0nSGnm1+eeFD5TWyXzPtGFDbK?=
 =?iso-8859-1?Q?bhBc+ttjgPyN8u4pft19R7ftvgTS56TYZntORch++3VQmk61nioch9CzMj?=
 =?iso-8859-1?Q?agf9UPZTwYPz8vgheD1rg6yMvHwCWNPrPGY6aLDOpN/KL0J9tzQ9DQWuDX?=
 =?iso-8859-1?Q?jQqwVTeZuKSLwZlaRuWiWApmtUNxdqZaag2sBHN9XmKOp2vbunulx8uzmH?=
 =?iso-8859-1?Q?ZQsySiCK0TFGPD/1AmsT8BSMPLNwx4V6n/Ryql0sCnBui3c+yKpQFRuki/?=
 =?iso-8859-1?Q?QXz9hLSrG8EG1CuJloaiRzA5utYIzvqgyeC2EP2TV9me8CBlXuGAhoBHuo?=
 =?iso-8859-1?Q?o86UTzU+6qEJIZEI325tnDxEfkP/DKfBhzMC29Oarn59AJt6q1dVaGcybi?=
 =?iso-8859-1?Q?NeZ0hGb15cLGaolegqo3/mZ7bRzVWilrSRWk1F6zVo/Qv+EzZZKqrchufX?=
 =?iso-8859-1?Q?Iv/2MNLl80xmpSJTzGgvKDEwzrZ61vjwwfW9QkfxeAjxauOo7y1Fo2sWJE?=
 =?iso-8859-1?Q?yhwulPpMDxyABUJ7if2uETggCeYHgfVczZFhYKlCayi9BMlRk6a/wKeYoc?=
 =?iso-8859-1?Q?1CSvZyM7lAwAtjVVubnUDidCkGdjGEVZF5IAh5fb0SlJwlWc/2MENpjh4P?=
 =?iso-8859-1?Q?SHwOhfK6Tw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e19af5d-ec18-48bc-7f97-08df49ef101e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:52:02.2120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEmDNoNUrV5/m+ppMnG00DG7MmjXqgJ1VoJk/PYomMS6Eyd2EqmqSvA6LTm8zPLOlfpmkFgRKsKeYdPzYNNHYDfP716KMvRZ4WCSBfbS8Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7038
Received-SPF: pass client-ip=40.107.75.96;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 704477d7c5..09e97d5a98 100755=0A=
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
     ASSET_SDK_V1103_AST2700 =3D Asset(=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-default-image.tar.gz',=0A=
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
                 'file': self.scratch_file(name, 'trusted-firmware-a',=0A=
@@ -144,13 +149,11 @@ def start_ast2700fc_test(self, name):=0A=
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
2.53.0=0A=

