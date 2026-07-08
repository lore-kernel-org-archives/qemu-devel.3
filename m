Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4E4C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSn-0004Jm-Ij; Wed, 08 Jul 2026 05:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSX-0004EC-Qe; Wed, 08 Jul 2026 05:20:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSW-0000QA-2m; Wed, 08 Jul 2026 05:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdSJ+lds9GCz1ZuqfB2gaJrlLgRL71ChaB8E/U9Nfar5g9oJ/aYVPe6FrODBNvfBvtXcBSITN5D6HRBfEVamgscYeCJiTcAXRqdPyooofDZx8iIXUXwEus899/2VUmDYe6CNNIZgkVSIlooZjM/ToyQtVE7zMqOe/5dY2GW60Hox6j02xIJ+U4gDFZEUhIyOFyBtA6Jxw8RCf88kHTLFSTVWqc8BEJ2Ify97UkalUqNUHySx3TvTMGyp668KEeIvHHqKNCwiXU7hgspO7IJNNZAp/w/2VY8y7/5viOHHrNMm2CMDUyca05k3nrIXcSbfx2F5dr3C5cTXiG2J838p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eGrAplOW9/dRSu2NIlOoUmykCOwhi6A1wzM2wISqP4=;
 b=jldjECB6eEba9C+2D2Ltp8+G/6+WP7NPYMo6sPkCG7OMx0qbSnIsw4SRv18ggIhE+G/lIVMfSfZyvT7icGWNGhsJbjgYRRdQVHau+YoG9RhbinF1W2KgAqa2lPMNaPRYAp9izV6bo8I4qiDlxmDZN7v/33O3BKFYQbn/vk2YYtUxeD+OLETLLyp7Y01yrUcpl+8Ij8XXjTDuXOT7UnoSQqfhlsTNPuIu11UZo9aO/PKrjz2wjO0H448e54d0DnlBehxHWd/RzzYCmvK/5LCj9SV/eCOUozkyLc/O8vozxFV030TtPsx/VgamW+ud3Leo3Cr8ux6Sb7xF2pRRw37mwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eGrAplOW9/dRSu2NIlOoUmykCOwhi6A1wzM2wISqP4=;
 b=EJpfI1EXxbgYDdmC401TZTbZbLT6V94qtfAXxrmj/e/n1Wj9n/oOSQjtAt7XhRCMdTZxk4BWV4Z0wSlmz4GkF4RqYJgbTVRChT5ZZpTAejS/8882Tl6QFMi9TgYhUezX1IdS9J0WM7/MBjmiTbno54ked9siyS7pSiboYf/8vXAmaCaomRe7kH/4gtPvFOSlFlfbgNACn9jliCbPmBmGTS2Ve1mBBKZMK5JFVIhKeXypPtGK8rllUBkUWC+nwh7E3DwNP6P0kMLaZVuEScy7HpX47Hh6TvajKd0v8AWX1ymOnRtl4JfTbydySP4G3ofEoLyC9ASvhsKi8Td146n8lw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 09/10] tests/functional/aarch64/test_aspeed_ast2700fc: Boot
 SSP/TSP via PSP and load binaries from DRAM
Thread-Topic: [PATCH v5 09/10] tests/functional/aarch64/test_aspeed_ast2700fc:
 Boot SSP/TSP via PSP and load binaries from DRAM
Thread-Index: AQHdDrsJJNt023T1Z0OHExjbxtcFVg==
Date: Wed, 8 Jul 2026 09:20:37 +0000
Message-ID: <20260708092023.3826159-10-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 73d52aaa-a706-4e1a-d452-08dedcd22c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|3023799007|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: T1mB39QpQ1A0rQC7kNWzJhbAqtwWQIWC2pLzpTZgHXhN2uuXhZXjoNPu2o8OeWmViSlu/9YoFZAExJmXbQxIhxNf6naDjaIaU+TG1C9wubNL80BboY78C9RpVTPiuMmgIq1pU1BlGawTDV2tyMXF2APdnDzLjHUtxAE0GMjDk4+KRNfUkOVifc2z1du7W8JAnA9OgzyAIAJJXGduoonRTMfJo1d+srSvCdU5FlxD1/5T+G/S+XEXP//scbCMYx55+7pG3CUzq9dVnpJNfF/CSOGs9c8XHjRKjndVwU/vm4L8ito0SHzmOSvt529TII2kgBFNnb/9b3mKZRUPv8/koD4n7W2mN9+cfwNtQByaDnaInfPGKf8/ucbQblyu6VpNwUyA0gPFQpcJnhripmDTq4NS/3mCcPgx6zLQ20Rd+U9rwx8fTAVkLZmA4QYo8g0kSeKrmYVjTRqcgewINsuW+mEnoc1utx29e+7BkSvUmxg2dl5kR99zV5x/8FbiS/YSnrCiuKsNuAMEPWoaV51kn/ZB624QgbQ85f6xSSbm9Vw5axT1/rkBU2x1O8E0ritAQEUSW0ex3GEc8VbN8MfuhV5Z5CUIpa1fWrQrHlfP9dF1W8Z5bR1RI4xeloRaQYOZEifwMagkmBeQuaaJqV/I6YdWHdJI0K3ZRXU7IlGzZYBuOZZmxTGgHHxzeqslQypF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hFNXIT7wtn6n0RekzHwhNGH6jXSHERMInyRtOZBgVBgun+LNlYpPcAAI77?=
 =?iso-8859-1?Q?Q2Y45GDtqM2il8AM6F4BXg7VRhL35pHP3R3kwF9295smauZNHvJX61XfZA?=
 =?iso-8859-1?Q?Qv6EQUaQOsAnD/9/OU/r/GIT6gg5PD7HxfokUTDOg+UlmmCbBko023pehH?=
 =?iso-8859-1?Q?gswEPXwb1VRs9b8tT8jJ0fhhCJt3uSjlXBBW4KEksGC86qu+qiQthdbXBw?=
 =?iso-8859-1?Q?VoTgSRWcm5EaQXtfCLY4W2AWK0nUcQLvBFBfYqhi5PiaTtJNHhwWkdgveb?=
 =?iso-8859-1?Q?WJUyh/K5dGj8taKsKBX7pnxtY+j8D0axf4wxJGW/mCKp4vr3BTlitH2cWS?=
 =?iso-8859-1?Q?FGxGxfu980ZH8U7PVa9KWMNd5ttAWRq592+3xzS8y2dYoiqbBHRr53PqYc?=
 =?iso-8859-1?Q?W6lu/iarbwr06pHKf5rlyoQZwNzOBdvOnfuk0vhPLM9FukZRhYn1f3smfu?=
 =?iso-8859-1?Q?i82QnGfrXRhbJji8ChWTK1kInluWAofJVvaNdI0JTSEyO0TieFJjyV52XH?=
 =?iso-8859-1?Q?F6tMQTNqsERL7RohBzZ+PEg4wc5QkR21u6Qn/gwklX2YSIEaU0bEjLnarO?=
 =?iso-8859-1?Q?uP1m5JpHKUKQVEcXBZNgMwIpzhGeht2heFOqOcqqhllsXoK0NQC/7BC6ZG?=
 =?iso-8859-1?Q?lmWElBKeT1KKU+JZRmPghBLp1oZa4JPrPZtfQSqds5uciuXbZlonWmNq2Q?=
 =?iso-8859-1?Q?u3718tiyYXQv7+vRqlu16K303YlAPbEBUdV1BmPQJcT+PQ8qy0tFB1V9/8?=
 =?iso-8859-1?Q?77EmGpkDlcC/OEJAYGxoHijEVVaHveequYanYXsYsxZoxZwhlv3DXlsI2S?=
 =?iso-8859-1?Q?Y4klc7Y+OsFVKdqDdYkgVSKxKmiM4h2Cnxb74sZkw2xeY+TyIPNoFTJP8/?=
 =?iso-8859-1?Q?RtqzHgunYxlQieS2S+VRcALxzAKn016KJzeEZTFil3d0EVnkfYaxLw62gO?=
 =?iso-8859-1?Q?lm8sMZLvenObftHy9fWjp8XCZ2gVoOV4yu6m1sCzvsAU9XzieYYCvi3SB0?=
 =?iso-8859-1?Q?605WId7X1npyBaNGEfSOQwkV428RaNR0TAXkFWrcLdZ8w/Es7TeOvNhcn+?=
 =?iso-8859-1?Q?jzp7Qa93PjjucksIF6VXoyqc9XkGL9A4qDfAp8259XViFERy2pNr1786aE?=
 =?iso-8859-1?Q?q/PeFGLG6cJJwW+4RK3enMQx+HhoET5KfMtiW/KyBv/ntRku3TKpkJFjpR?=
 =?iso-8859-1?Q?tfUbTK2PZ9RVjm2don0C7PPhqH1WXnhHfSU5n+qxfDOlHmiG62e9/T6J1a?=
 =?iso-8859-1?Q?eNCF9WY8ryHx73uS4dnkAPfyHit+nblUEz0+EtDzkbnxii8eQl4ZZmSliG?=
 =?iso-8859-1?Q?4UsQObYzLEgL6EIXat5pzhwQZz6bsRkGh5EYiYRLXKxVko9RdVpDHOx3Wj?=
 =?iso-8859-1?Q?+n6O8voQ1MAw0g74Xvy88oir5eEJfPBX7IvpvyJkhbs7lpYO+HLDR2z7RY?=
 =?iso-8859-1?Q?l63vFLNEminfDkVGdVglb8itV20+DiOKLRf+34NPspD8xmah7CpitGbFDk?=
 =?iso-8859-1?Q?rfkcWfpGKQP1xmIX367uVaevlrEGMfl2fR3LFD4Yoh7SEZmefBabloq7Kf?=
 =?iso-8859-1?Q?iYH7Buuw+hD08kD27LUAaLzDthQzhlGcWpVZBvF5YSQLbJO5VGY2JzkMxl?=
 =?iso-8859-1?Q?+Q0eiFHDx4hf8xNSogEBI4EHd+OjTdRjb13LdjY/Vp8R+X/TApZx7jNRgu?=
 =?iso-8859-1?Q?nTLB1qgN6UbRPmARB6xC/eqwQ1ARiND7OxF7yiAfox4yQQa5ukXhQoSoA5?=
 =?iso-8859-1?Q?F+npYm3RbbfMAPnP5G9+Q8r6fVwbM0oyPGoZGMcZqzUniHdmj/qBYgV3s4?=
 =?iso-8859-1?Q?cnVCgfSzsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OY1X4lxcHjSBZvzN0wt7ODR35sK7wdh8NaEavyX4lmbLcc40bDDO9vAxI+YPGsjt8b17qg+Zavjc1SnuzwIdzAP9w7niz+JN2Quj5qYTYFG5PwYA1u6YSiZw8bTZzvmsE6mso8vtIztxlYOyXDkBNYhaniyIdH50TMo2V2vgEGY3YaTKpgProUdRPCfPfMtjydk3M56gugii+6WYOGhCg0uY7SLcUYDav9kJfwvqSzpzotDY7xCD9mWkp0P73s/kH6CWnbX9ySHnqidpgSMYzaaI26ccfSV4L4FDslhWfP5wdeizscCdTWqOtBMUCXGPXgXCgtGxa7i3I8nyPBT3Lg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d52aaa-a706-4e1a-d452-08dedcd22c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:37.8434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKsWbJSoBzJB9jRgOG9MPHjZvFJV9A7A0CZ2PXA+nPkJ1hrg37qj8vsbMMySZUu5meofC3vuBbS2TooVDTbdcDqDHFsVe6yFLOlpdGg7vxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

