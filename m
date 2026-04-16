Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0F3F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsV-0008MY-VE; Wed, 15 Apr 2026 21:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsI-0008FI-5U; Wed, 15 Apr 2026 21:50:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsF-0007jV-3L; Wed, 15 Apr 2026 21:50:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRbgHicPU9/Xvfil047tbDFYeYAgQTKIGoUgJenKfFiAfv6WEOaOdr1W2AbJmg4821sEx79NUcIDVMDLuY0rltITwmQFAF4b413SLJdEGaoTaylhUdDMBaN4FrH1yw2N4dfrohY0bXXi5GKLz7wSt6pA7RkjMLiVO0Srd4YVsM3zlpIvFCkhBbZ8J9/0kE76qWDBI9NAdUkpEREbEj7WOOKHT2rUbXJMyUL5BAMj66azwAq2LsZCgjQ3SI/fNv0TK5RFUjY37y1AzfoSmdQZNvBaYIXCI5qo/VQZXEVwI9iMZCsIYwVMJ22wgmQBrR7/l//4oCpi8AVxnnKs/I19vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeVKA1gQtxE507eUBEjViUYlF2RK9kx3HlJM9tWvWpY=;
 b=UFQxET0UTbu0lS8hnQaodx8Kshu29OP6zftZJ1z97XXw1j1dnPZ2PTcqdN2Tg8fIKhwToo/C4d16kzs+DdvscIvI/HvCJJx6avk0YU2DxG/gZyrqKnYfC70aBwKg21eOSpii/VL3mrfbuO1dBuY+vQryCTuYGIxSwVhGthtKnVOKsZt2obOYp0YfhBn/hyONIMaBW5DjSGzYe3r3I4ZU6n2qbb4p6OU1Y6C4RfvIMTHR+/sll+VKHdkcbiXbow0mU8NCi8yo8+S2/kUYqmTiv+M2IG0TJY7NPITSIgmWA73odcnnMkr1is10TsnolRJh7P/L4A9FW4yNmMdB1wbl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeVKA1gQtxE507eUBEjViUYlF2RK9kx3HlJM9tWvWpY=;
 b=byKXmVztetchWS/8jAkuWpOC9fu+anlUrWF4mLA3jU8zMZn1pOYE9OyQei9GjQm62exDxTPOVrctM81MTYI+2BckEvXUfHkiBEbSUBQytXOVPR20x5BSEvHfjO/kq5RCoC2Au4TlrKKXSBDofdW+oPTnTdcx8dfh+NCgpdf9o4Pc7Hs+hpTtwl1ltdfyG3D1J3FICEmpAUdZxCiu365DLT+FVp2+caVOFn/M9qF7dexlL1ntYitsfLcd/9amPmWtEoFofZaHz35ERF/1G7ioBxRMOTzn4xwzwuS8HnkKPZSE0SBL/QcP6vHvj9ov9QTVGNZuvI86lhAXn6ca783jQg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5738.apcprd06.prod.outlook.com (2603:1096:101:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 01:50:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:50:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 17/17] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v3 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHczUNYayfkLJXS6katQHX8eKzYdg==
Date: Thu, 16 Apr 2026 01:50:04 +0000
Message-ID: <20260416014928.1279360-18-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5738:EE_
x-ms-office365-filtering-correlation-id: b49b69e7-1c3c-4c75-a8db-08de9b5a7b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ygcQ/WI820oeaakJ3PHHWHbBHVv6ZWhWmX2rKzq0ya6ikA0itaNt10/e2xDLyzk8dR4xbI5lK/1FxwsSz+r690nIlIvR9uVmISWgB3GoQ+8ugevnJk267tXed38WzsjxKW0xluwK4dcPmHD6oIo1Zdm11aDe+TLUPmS4Szn7sK0cjP5ZwehfZYzyTsbj/ELmZEc3Ck3hrR7IX7c0S3iCLeIqFwCCbZxcyyczcdfZ2WHZsSfZgALgLKEzELvF8lM/1BsevXm61fib8XjB2Wmavc9OjyOp8X57erDgLOfIhLG6NF4yVX482hcgUS1G97sNM6F6byvVSsx3KtsxJJanGxQ3W+iRW/nyjDky1QN2QyeetThK1TowHk6CaHkXPsd/n/5JK5Uf9bwu5C+7ZN9kSx6Ij97GOJLLKF5VNZN44cJFe5Ae4Af0E4tA/dGMW3m+TTwTlJg06vUVfeSX0rk75UX8MGsUa8qw3epbNSAiBAAOOGlcljPb3xd9MluKR9I/Mhgn49sMIFgHMgs3PwA15AdPuRM/Kua6FnN3lUmjjQyNhVyLTzcjjyEG/c3zxGQ1JTeCflNcQkzUUHY2z27QI4hHzffbtIwq5P0nUFEedAni024FgcM5Uib6nVzX0x0TeX8hmCmdollxFUOTtaydDVFoKhHzUgNv4GU1PsFu4WMg+i9+ULac3lgoNvMS+8WEOjt/sgcNzmdvfdMjGJVaW2uG2rQ67+ukl11c1Ys1e9tlxFx6RSnLNYjk8+ea7AFH+e4GJ76y1MTBJ9ddi2yZsryrINVPE9jSgXW3QvqIv2/JaFRnAibqP60Atzbyp/GA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LbO+xw2w1+uKVREn0nB1RRJgRMe/avZ5IbhElif6xfnDS8nouQ+V0P68CL?=
 =?iso-8859-1?Q?lWhtXaaJBzqfGm3uHiUAFxyzcOJLPAXFGyvkFWev9Od9TE6cXULw2NVUlV?=
 =?iso-8859-1?Q?0LIvs7LLNORQIn6ytAeb9NoJmOE/qnqhSt+H94IJbnRkP7Wid4XwIvj1fX?=
 =?iso-8859-1?Q?91pZ2lp6PBrltcz37X5TWTragmhCWSSPNyGkiF2ZVX8pJZs3It8VJQ9X+P?=
 =?iso-8859-1?Q?3qGShs74XKBCvU6cqPNSXL7Brzy5wKfcgNyJGljxULTnONdlGYVsqrTeoe?=
 =?iso-8859-1?Q?tUhIP2O8wQYRjiSNDrsVIQivHlIGBYCKqG1ao1MAvtjyk1z8W3SbUlAtL6?=
 =?iso-8859-1?Q?8Sq2AUR82/wBSRnEJ8+rLoTgT01YDW2p6B7pgTGLg5jj6FkYU+Gb63sBJw?=
 =?iso-8859-1?Q?DGaaFNNx0I93fU2Sek4cnF6SA+5dDy4W0Orv9lUtOIYAITLFIkF8VPlEGP?=
 =?iso-8859-1?Q?e6N1Xzj8CvM9sI3cDWr60WjnwFxyGGDKER5s3bzYpYGTALQ0LhG/VU028k?=
 =?iso-8859-1?Q?NVHIY7SWuA4sMcXTWR4E0uOrDdDapSm1xw2mc26k0muHYxMshJar2Fd7pC?=
 =?iso-8859-1?Q?H3kjmJN6RA/ox459jM6FYZk1Eg+Bdyn7aH3vumWgqvBsssCrb/Zcx3hpo/?=
 =?iso-8859-1?Q?tB5RZuc/8Q/wPSp9nl5OW+z9lKcpt/3fxZAu/yvpwDK+oZ/bInGckg+gmq?=
 =?iso-8859-1?Q?4tPtS5hcTraa+VhTcwuQ5V4/29SxWcsLv2ZE3VMawfWU5dyVnbjugADqt2?=
 =?iso-8859-1?Q?2fJeMDHcYw8ESXtL8C/qRHjunATkJQcPux2G7AYHvDgcgXhKz8p8CD0Qg+?=
 =?iso-8859-1?Q?LhUfCOIxcQyLySwxDFmslOwPPUundxkyo2v1fzkHxAVDmOx0WWlk5WImy9?=
 =?iso-8859-1?Q?cLvRVvZFyCmmYfVmpK+w6kSS+oyJd6a4GilGqHCnzpAgK3QE80IaYMQBMt?=
 =?iso-8859-1?Q?iaTK6zUBOO9mrSz9RgiiAw8diFx/Yl8+hf8WqWwXmXRg/TD5TdmTAunIN4?=
 =?iso-8859-1?Q?FLex9KbfW9xZ1htL5uvHwFF7ivpI1PzU+1C1ijXF3XKroKyvHSiJ7Gsk+r?=
 =?iso-8859-1?Q?YcUn0dPfMT32gL5V+ZF8fzmNtNb8zY14JtwyQZp+rkzi4Z75EjlIjG7fT1?=
 =?iso-8859-1?Q?LXCir6HrpazTfuCf2Vzh+q0qmjE1UL24GeBPl7gNq2nSTI2jvq1h6/W+ps?=
 =?iso-8859-1?Q?BtBsnTrSeHlDldZsiQl/TgZdMOI9NrOpB+TVXTrvUEBpfNx3RMOHH97izG?=
 =?iso-8859-1?Q?eORw4wPZfqPuAX2SQuh8vjHe5yzQkqeuPWA8cWt0EiaZqvxq101Tjh/Wlv?=
 =?iso-8859-1?Q?XPGEWWKG0l+blImammBsU59XHMJZ8TGrer8baRvc54PLqBzlkvHNs0bEvo?=
 =?iso-8859-1?Q?pWbpkRLBHZ3YWEWD6Tdy8kl9apqtoNa1KdyCa7qpfneC5Hp8Ld7f9jYTqK?=
 =?iso-8859-1?Q?SBmwcFPc1J7bQH0WlM1Z6TzxCU99JuWxpN7i8sN+Tdd++cj9BBoLS17Njj?=
 =?iso-8859-1?Q?ScYf6RYTDlQwwM3kBLrTG6G8zoow0Ne9Xy04gQMmc+gnjr8+SBqe3YnTuG?=
 =?iso-8859-1?Q?/msUwsMHkkLmSMQzBgKu67BaYMwrF3jy9ghNo4B7KgEduPvIiPLGStDIvw?=
 =?iso-8859-1?Q?blzUACYJuFYNRWQXZmc9dHBAFUnGrdEWAZUgkFZj/6M4nf9m5Z/ObIn5So?=
 =?iso-8859-1?Q?Of55XxDHZ0GsMeHXVeAfrebTbD+QQoXUaJErB2HrULbwdS6rQb9oM/Z5mI?=
 =?iso-8859-1?Q?9A03W4aIVqKOFr7OxaGf2hQNTqCn1G2/XSXY29MTHY5VlQ1WPl5orCAKKm?=
 =?iso-8859-1?Q?xZmSa8ev6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NWJFmxj8eXEbCkHzoSVVjM+fWZN1cBwdvZSOfNjAnEHbgHeG683S8pYhOe4ClDF16IOz4VOeIfa1VfAeOvZxBW1IPQpslPmFltCs0Zb3HCYyWoB4Hugb1xg6yAOlWloEoLGS93JNpSLDjpKtlEJHhT8fi/zGnOON+Zhf3Zx8pc6toMzPfPVm5PyTqEo+4bsHGGggMqoE9BgbwW8+hGveaz4+sV/Qplj0D5EXx5huizzgEB0NU9qdt2Y0nlRRpV7B5DxfgcTn4FWlkXi2s6F6M5XSa1f9qDJqLcXN5lFgiKpfVovWqAUCbT5+h9I2x/WAJ2XXdTA+jd5KMTJswrpqJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b69e7-1c3c-4c75-a8db-08de9b5a7b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:50:04.9484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AO1VKrD8TYTBGjK3qekraeZz2xZN/MOMISnErJBE0GdtZGpnuJ70X+HdXpE5Lw1mYppU9KHG+HEIh5ONnGe6XY8uEs/YMiQDwzCD0K4veuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5738
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Add a functional test to verify USB EHCI support on the AST2700 A2/A1=0A=
by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++=0A=
 2 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index b0c08854da..42b8b200cf 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -118,6 +118,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -161,10 +166,12 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-a1-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index ed414999f4..40e0ad81ed 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -121,6 +121,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -164,10 +169,12 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-default-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
-- =0A=
2.43.0=0A=

