Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D314FAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSr-0007fl-3M; Thu, 23 Apr 2026 01:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSj-0007dh-I0; Thu, 23 Apr 2026 01:18:53 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSi-0003M6-0R; Thu, 23 Apr 2026 01:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uenQIbujha2X0qzTHr5XzowF/2d/vZtDsfSTq7huuI9Xr3m+/D1f/2cK2CicxuVQGJgZf+mtVxE/ghvoTNDTPRB6ZsHV0vJccZ9+Oi+Uzw5UVA58xMur84uWC/a/+63j3p+JDZhrC6WvFR63Trs1/a1RsfbQPI7zPx3bYmpVp0cn9B5kq8SVcPgrBLCbp/hlb7xdDfj4QJwnsZP0h6ZTAO36Hkru8zoHx0qsin26E3gcB934DIdKaEn/4sewRRsAo1BUBJlIp4/s+a8tCLhFvC37VgdJ/RBWBV9/r0PucNaFK/fIIgszcll1+lhGcdLD78fhaKj/B7eqftvcMcfyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dj9t1EGJUE4WwLssl8evgyQCqIAmWbSCs43jEXn8Rc=;
 b=RIKfVvcYdiC0y09YRSpcqPVv6doNWx6J4PJ7LCTOPS17EtZBgGzoho2IK9ACX+BRPQVjFTot7inPOxHyhAVX7BUFbN5o9XvAP7hXVClGACOWEszR0TfiB9Zs7JgABZEQnwnn9aZe3l6KCpwewTOosT5FiGQ8Jf4EBNdik5eo1JYJ6ILUlcxgM2jTAiVKBfrA+pU2IiUVAI0AKCBdYvlLY1VvZ4qahBDx0XSF9vAcHQJYaj0b5HSVg037V6rfEjzDNpAn2H6yrBLYIzTN4vBPL8Foqk3MpLiXqpHfvbysAfYNDiDnu4wAz8p6BKc8rfb62b4mKFoUd6CliON4wDGK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dj9t1EGJUE4WwLssl8evgyQCqIAmWbSCs43jEXn8Rc=;
 b=KAC3xvWT6ZtgprSesHAI/nAyWYC6neyLeh2FFPml43l4E9Ld80s1PquZqlR2FV6iqbRcdvMVXMJm61sNwEZqkHHI+qlSoNcRgNcdLJc/tfJJEm7wiRyc6tpkf0SIi5DAubHYk8oDzdgoYmd/ek+4nLrXzU+HwLBWtV7L/4zFjEXA6+oA5r5U0UuJOAC0dg4IPCIMJYSp0HwOPs29ioKqzt93tMXxbtB7C2Zyd3EFPZ/joAffYl29QKtJS8FapXifKx5cng4K0LhcTyIOSQeuH7kE0DlpqbWnUKUiANMFOFNZy1WHtYy3yY6CQY5knBd6HA7zwLz7Ldghj1XCOsEzjw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8111.apcprd06.prod.outlook.com (2603:1096:d10:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 05:18:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 17/17] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v4 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHc0uCcXIlxUlwMKUSfdSHr0xkLCQ==
Date: Thu, 23 Apr 2026 05:18:26 +0000
Message-ID: <20260423051804.362095-18-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8111:EE_
x-ms-office365-filtering-correlation-id: 6e924ee1-099b-4149-1e8c-08dea0f7bf79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 8SoaTAfg4gsorpeYvEmyhxVtb/9iXxBYeB7/SlFk1EGJMF5m1RCbHKnzxbz2CO/6uNw5wA6SON/oNQrWP/ODJz6QX4bTD0iRWZbkBSUwWyBwcXHS7BeWEToSQIHT94/Df2OqYTgWJ4YMQpi2Y5eyBtpKC8TvFM42+8TbkTLIMJuavktanxe/oWYaYinOYgA6uBYfJphC+H4ywypZ3mjKWOneX17JJ+IbgSFyFWXIzOpOidwuIA9a4ClY1pMjLHsPABGDm8+hUKnIcUXPnhv9MLfagxJSimYiqaNt/pJRqtqR/wdtml+MOtpf+h8LgpEvCbX30tcxYJZEn8PZ0Ft5aqTnN47jj5Ks6kkN0CqakOLEwS6hWe+EdkshkmBbCvKArt8FvFeWZ/7JdDpI1AXAPke9UyMwx/f7e27kKxW1GXPg9WUn5Ll2a1gJUdX1S4z6BSkpStHg5hwuxPyUCzRKqTC3ysNDQYmXDs+Ohb2me7ZXQmaW10IBfENWCK5zyJpvY9dgqQv8eh7atEcR3wy61izow3O19cczPJ+cNWnnhE6IsCm/IGzutSVBwaQZRQmEFUMfWLhtL8Rq6MiuHH4x1akorOwZJ8yFTil51aalXmNzVPOsnJLJQD42yk95TW3zVzPvokUj0Yms6o/7u/LUvwP/t3LjGKDTJHHuOj0Bsm+0Is17Jr1UYTVvNlJaI6bNM/AEPbY9vyrnDj0S63X4hAdnO4TiPkWMeOP2kt3BXTrtjL76oiURGDWirJBO8ffS/Np8HoGo0rtrtufV3chGJ/vrY0mR5FLvnNzWG1OQ6um8D72X+qla3ZaDh+qCPrJF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gPFhgYQ801L4o0//IMj9nN6ZGd4q82nbA0ow1jA55dfkT0/bPVzr+PtT73?=
 =?iso-8859-1?Q?k25j305TVotz/hFpcb7iDEHa8o4Idgixglan0nxSKIt3dMnHBDviCGQcgU?=
 =?iso-8859-1?Q?RYU+6WG+aN1zUPpesvXzfS62zywBwDVqyaRZkpVT8V+bnszmpO2a35NHkG?=
 =?iso-8859-1?Q?iGLbEPOqnd0BkgULI8Nx2nVB4rAabpwq/of0JP8T+O84DbI0/QAPeXpRYM?=
 =?iso-8859-1?Q?ZNlzvmT2UWqb5Xzalz6fqpHp/MVBFFYBPZ1IHNewUIPoRWVD/AiEFClDJI?=
 =?iso-8859-1?Q?zIrGawUKHeZWt1rPlCgowj3YH/o3OnY18xU2yf9jrn44JixspfIeh8gqwh?=
 =?iso-8859-1?Q?liF/MbPGg/QuHnzyr8M8+6RCVC7uLKrBYJJiR+LFuUgBhujdXsUPbzhUiT?=
 =?iso-8859-1?Q?arjPhXKjmvgfL/8fVO2Tg5Qc0K/6RLtgUjYgWPzx3nVs3kDXrzVdSnutGv?=
 =?iso-8859-1?Q?6Vet8tyD70dSecgKtGVIF3ju1qeYIoLV82OKpDGcs13mhFCETi1/0ELJiG?=
 =?iso-8859-1?Q?2iVWjokUKIqd+JevGC0ZGl8Pv53ebahzSqPj9SNDdaLeV3eLGnkUuTIBSf?=
 =?iso-8859-1?Q?i8SqGA1nxcqjaNWQyt9KYKm5vkN8gP9BpW+yplvesEYJKiiEsoUw+s/7j9?=
 =?iso-8859-1?Q?/RVasYFQhaReG+fWP/YYOt6Kq3ev5nVaS9n9az/M6QE+/mK/+inuAy204B?=
 =?iso-8859-1?Q?qnSn+VekVFWwh0mBiJXKq5mch9aqRIGnB3d8mhQp9p5P/VJ/CymvduijAC?=
 =?iso-8859-1?Q?WSGv0XPRYssVleVBEM4WSFpS149TUT6kD98RGat5yQ3qA7fZb8a4UZ9S+1?=
 =?iso-8859-1?Q?eykwUsl7PKxsx1YGgReDXJ5HEbZ32MDZAkyuQmwIQBqf6fXZDpeulwURcw?=
 =?iso-8859-1?Q?rFCE97vajDuLVEazJVtSh9dBSDbdMcbrLDos5sBsjiQiUN6D2tIGkFXxBT?=
 =?iso-8859-1?Q?A2ND0KbezU8TveJ9XRvJwQRGQQIi6NhnQR3z6kdwvWbW0bLEuTJ4IF7Ly4?=
 =?iso-8859-1?Q?jeqmpIJGdmYZpFkOE6mxY8hNUCMugwPcIUKKtK7ynY8T+u+1aRRxdae+CN?=
 =?iso-8859-1?Q?i84IuewQjx+hNYjfGDhkDfd3dYFE2Hq7Nb15u4kk/18E93WUQkX5ORL9V3?=
 =?iso-8859-1?Q?p5cUhHFBVsCZikA5jUgo+g1Hxzaatmk3x+WjnM/HNM3m7nbfUVmLmUfXQi?=
 =?iso-8859-1?Q?YZdxQu84WlU+mFTA/RT2vRtz8Wpe+HnJBzi15aeIPx1PElHQXSJyXPpN/h?=
 =?iso-8859-1?Q?zOKWUuEEFWOLsoi4JuFaqXedpX2duxkwVHwl7emAaKkY6xz7BgLOhStPOL?=
 =?iso-8859-1?Q?al2L2IRQerc8p/xgKmxOojyQvmVICRF5l2Nbyh3q1gMxi0kv+cRYmmgKut?=
 =?iso-8859-1?Q?qlNM99mHc2vgFIPhWdX/ByieSKu5jX8BRu8MMGV3GPrgvCHvPMsrQKIbeG?=
 =?iso-8859-1?Q?8nf/QUTKaXyAR2Khd6SGbgTQ+j+kUBsw9M0qV1uH57ovP8Blk6nHz3wx18?=
 =?iso-8859-1?Q?uuovqSNIAcpPVlLi2rDC573EYvgoJ2pprJLskvOYfmMadYuKyQUiLaN6xm?=
 =?iso-8859-1?Q?bryofIa9us+JKmH/7AeEO+yTAaIZBMYGPLBHCzV/d+0dneJhN+GNIju3Mb?=
 =?iso-8859-1?Q?bdhgiC3PjaZxJYS0jUSnJy4SveanfNxZ+yIZG/eG19DSujO5NRXim5HKwC?=
 =?iso-8859-1?Q?UXGcDBe9VOlU2XIjfZjbzIAEtzv4f6EGCHdtDOzv2ovP2qjoHUrPcWSz7x?=
 =?iso-8859-1?Q?etEQXPXiHkC/YDs8H1oJbou0Rtxj00FrN/xy47huCLaOQS/PD0zFZuDnY9?=
 =?iso-8859-1?Q?pWoo2B2guQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f4qicsG42K0ejV4Sp9fM/p9X2YiFB9LvDluNBo3ez5q7nNInsiR4q7E8dbiovUANJf2sT+pTOhAIPgd0rz9FBcmyRYJvEjKmp0WxMXlj5JFc0JWKvmqsiliXrQjCGA/827WWfzpbEAp5hVkaipId2WLg4UPx1ERl+63AgU1qVKZE9y6XPGphIs/E2b+VX2uuNZKiZpW5j4snoDN3lpeyCxAKKjOflPbOpXl3rXJxrwvb+FeoWVcn89IYMz2LTG9LR3vS+1TLwbL5+NkClyuBoep3c2rXUrpu5PyVZws7klmXhoMg/Kqv6a0fEYGRzG6FzG4+wxXPzeIlH/SdcGS+mg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e924ee1-099b-4149-1e8c-08dea0f7bf79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:26.2709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IARuRKhKGIvVtsWm9epTf5Fy8juFOyBnAJyt8B4MMOwTYkuxfs0CugDSynN2hgINH94SUn/12mCScRyECcOUnPuc6lxDDVObfrkBdJXsHl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8111
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Add a functional test to verify USB EHCI support on the AST2700 A2/A1=0A=
by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
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

