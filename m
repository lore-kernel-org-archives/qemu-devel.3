Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0725CD3424
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRR-0001VP-Pr; Sun, 03 May 2026 22:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRP-0001Ub-IJ; Sun, 03 May 2026 22:53:51 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRO-0003sY-4N; Sun, 03 May 2026 22:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdicvdyH8x3p+TN0SOTee+TJqMA03uEtamXaJAhh6QzqwJOzaWeNGtNb3lu4yphWobUdUigGhGfgT0XWYZ0lRCtWFniIGYcS98oG8Jyk49NMuWRD62zb0mhdyroZ74eTEf1UEPtJaSUDTKW/MeGI3DhOvxUIq8O/ARdLU/KNWuBVxZW8ASx+RWpujZd5VaQ5qXSinZda+FmVzlqCzuCRkaEcx+gzKnnLTHXlabBuPAIfjqHzDA9KKrtpuxzzogrxRnqKxFqikCKz5695jZNmHKU7VM0ium428nJkcRODibX2qVW8t/HsxLb03q4+D4lsM8gOsEWBMJIomqUA8EHRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=j6uo18o6IVG3RnnoZImuSgcrD1j6kW/ghk1D0Sj7vnn97f6jTNEsT+l7D6PNVD0lwg6xI2KESD/pPgpnPp+RQgOTB15d5MprmKA0wUvama02DLqxnIobcEJqrVbNaMVd/EwDNZyy+0Yh4kZbgQAwwHCPxP+gPwVYXwi5/4dcWfaRVdh15vj6g7W++KoejTGiAO3OvyyRmlBbQTjm3/BzW+t1dElEwToGnHWbDPo/ZGmDWS/Zv+HjoTVwp70OD8j0M9ZicA1WwrZqqtdLj7dKeWmgmoMeYDJLDQO7Zvh5XneU5nyn4W0Hl0F/R2662mjs2oLRkTdDKs30Gw/WnImi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=gJJfhahve5NATQQS2bn40MhnLjmSh5qaS8UrCJ+DA9Fc0ygJNaZKxozjRfwV4nRUQXDt+wEhHX2SS1kITdWzTqUBAWgZUZL5fH0/zOk6SIb6cNdaPpz2CY+VjqABnAeGAfk9gNzoljvbIdZQJBT9rpkxnmaMGST8v0EHhCEV/1hZ/9XxeuMw6Yolbn1aInb8o+15WuiNd4ezkiunNE4kXuH0Mg3InFN6GDr7rK4KrfN1mdSYHlZtCiV0oIxhhGZrVGPQtDvJuCSD9Ue/WhcPL1XXaMtMbTcplkXooRytfb5XInxkKvP6n8u3HlPTjf07sFp9bNvo2Xua1c4W1Hz89Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYUPR06MB6098.apcprd06.prod.outlook.com (2603:1096:400:358::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 01/11] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v6 01/11] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHc23E4qRAVI95nnkuEmU9S4CPmgQ==
Date: Mon, 4 May 2026 02:53:44 +0000
Message-ID: <20260504025342.1452605-2-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYUPR06MB6098:EE_
x-ms-office365-filtering-correlation-id: cefc48b5-3fbd-461b-34eb-08dea9885b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: 0v/5FNgXJ450/BVPOBeMAOVrrKeCCW/MRNdaiSxLI1zSq5EOB/hwT03X9QkZSNQXV56MM7mQHRa1RsD/HdspO1PBr8ntlj2K16vmEDOu0ZQHYhLut2PmzIydDHh9wNz0z87aC02/wTu1wBY5UDfJ6U6UDMmvyTc4loDPw/+GdWBATZlsVoF3xwaYq9F3sJyduxY9REdPbrlAXzHBe3u3x67mahIxpBwapH0drlQKP90CMg9pKmNQe9Z12/jjQ+W5K89Svt/CsLRbLOGQJKQW82JqOomCX36eNkxVnpOPm14jAvhQEgA2ZBq5QFga0pYtuBoMuHrI00kI9BG17hotKcijP/VBv7BU/9ofD0CyKI6z22dlXSrUp0PP8A3pE9XJmb7dx5e4FMJEU1urNzriN99QyvIzJdygJ/jPFAdFfuQw74y/RE6pxC/intGQ+VwSEqN0Za/AcjTbod3TCIacBKALqsioTKBIZFt/VQ3e84ZoaA3uNVcXWCeMCFnOZaaR3w/dGqugjeyZOGi6T435mCJQ4s1FXgnPKnFG66gzxA3hTbUpDe8Qf0gPdTeK0bDAaA+1H9OViMM12XZE1LJPqezKV8TTtJ2LFw7o+F1BRoEjfcd7dqZ9QgHHx239oAsIfxc0KpjApKQ0xZRmstTjGj2jrx+MISQeZKvu5mNQBFOYPJ19qGuKcPkGNVDXKP50syNzUpLp9jbEKMZ0XVwZNfk/TPk7TW16MyrkG6gmuMkj3V2ll3gSDaGAgXTRWD67u2zfWAc002Ee341B3IhiBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3zpZAGOheuOvXBQNEa3VgWKEr3QKXRr2FSvDfzQ8tKXu/mhJB3KXpuAQ4?=
 =?iso-8859-1?Q?vmNG3n4hoUNGh9CMW+9bC3u1G9JuQtHxugQ+E0T2l/hnNTGX3UB12W2fEx?=
 =?iso-8859-1?Q?QhbFdXw4nt9d3GwCzSCqddsdYVxRZzmBfWbFdx4rUx8Or3NOjgqXPvxDJE?=
 =?iso-8859-1?Q?3VukTuREYClHYMQbjCCOGspOhsjmOJkXZ3vv2+W6lZvPQPA6jBq326UrQD?=
 =?iso-8859-1?Q?6WflLVKhw6j7sNa53mxz7doEvZdvd8ga4301qupb9MpJ4YhvB0Ftl6Ome3?=
 =?iso-8859-1?Q?RTP9Q4x5CR8LWgz0V8HGAA/Vqlz2Xlo4CI9D6gQQYE0fq6Mj8d4equxjzb?=
 =?iso-8859-1?Q?W9TFRfOlHGexmVFfsZKUqaGDQIrHJhJSoQaKKC9Ba0q7HAcEkOO+KhrEdY?=
 =?iso-8859-1?Q?FS4qT87zQmgCi1x2TRpT8DTjspD7rSjw9GNvxlEx73IE9pBOGuNfA37svD?=
 =?iso-8859-1?Q?A4aXrLf+Gd9OXTnhFmdXt8LOEh9NV9GlZ5gxQEyKIWJvj+IgqPAacPxUaI?=
 =?iso-8859-1?Q?80xSuODx63eIBDJ89y5JCvMM6shC4wJs270/DCkrbTRfb5NCi/Jj52j/z0?=
 =?iso-8859-1?Q?5gN6cQnGFrJ18tKrEUT4OvbDgrI7m5W4UbDWaJQEaaiOIAmDUGj3GFj5hT?=
 =?iso-8859-1?Q?zFAXoRahjgZms1LoNhfFei9uS6A+PSqfLW3O1JZPye/Kp4JfnbPoBT+NEy?=
 =?iso-8859-1?Q?2bm9yyYtMYZH8gk4UzHRG1OcFXYlR65Ssxi2y5s4cAtgkLGbhnqR3/2GnB?=
 =?iso-8859-1?Q?dWnMOcwOs/1vY2RH4uH4gfe+XiVs3x9z7uJZwH+s9pTiIvW9XkTBve/dUD?=
 =?iso-8859-1?Q?UycsSYpI4cw45VnAYDhYLk+5l929xHzHJZ3XdEnhKlParTBigK4hjorEX0?=
 =?iso-8859-1?Q?ucnmr2UxEWWhN/cvAeNqKmCIV6CIKdQz1iopC6Cvgcr89ZMKpUHEr1jVsP?=
 =?iso-8859-1?Q?arGgLC9gCSYZHzibEVXHyXooVJqhMznDXpQV5Z+iHm3ahpYF1KSsulV846?=
 =?iso-8859-1?Q?ViD37EpHNv3lIv/9xVG7BiIeIMxs2qTRZ5/uSmHAK/KyK/EOyY7WdHFa+p?=
 =?iso-8859-1?Q?TKpQzKyBJgBPuM/0YqJhmW/cNokM3XIcbRrbxMWA6nvMf1vXY9BHeucHmc?=
 =?iso-8859-1?Q?XYc8SX2ROTpE3Q11wJyjlbl6+AiqTyM+nU+kM62gl5LP1y0SV8WGjTrs1K?=
 =?iso-8859-1?Q?XEVXb9nFqKJ7MAzDRVHmH2cswg9xsmnVduiZ4YY/LgqxMZf1AbrviKDGP+?=
 =?iso-8859-1?Q?HEea/3URNeu7KHIbXxwfW2MTYKzqM9/O7Wmyfr5wifYS+PgbW5E+YjYxs5?=
 =?iso-8859-1?Q?EQiRLMlcbC9Cg7lSS/WSvwRNG8c8IJof6u+YWxslc2V1a29++lusDApSDM?=
 =?iso-8859-1?Q?tB7jCAYhdvOPyMfPGNZcpdxAai1bxrft2AMJPIXxGLlM1waSO/NbBq7V3G?=
 =?iso-8859-1?Q?5BoAqTsm9LC04viA/bXmcT9h/4CGHlHYItXMJS09X8QQf3Hy1ojAs0G5MX?=
 =?iso-8859-1?Q?s3bwQxg9hruY0oviqhlmuUn1hbshQqob69HaYf/ELB8VXY7nFUJUg1NeEd?=
 =?iso-8859-1?Q?N2xpkIHVuUP4rKFmz6f7yWtJ0jxG/kW1HRcFhr//3SVTrmRB5Pm8gyCM/p?=
 =?iso-8859-1?Q?R4l2H0s6XQ62r3R/aZYXNuV5J98GVP7mwMXGGoeaHI7UzLUdF32ZqZG4Wj?=
 =?iso-8859-1?Q?xzjIpwQyLGYfeaaOpP4xOM6iq4z69X31sXkBJq10KI/d9pog0yquLe9wRT?=
 =?iso-8859-1?Q?raW9qtrrtxWG+P0OwXxAsl+x8OXQUGyxx5XGKVzAXApcNI90Nt5Iu3+jOO?=
 =?iso-8859-1?Q?qwEJIjDlOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b7mVO5LVEaAqtddH0rJrG+eeGP2M8NAMFrbcms6gRYS7sAg7kTHT8IGv1/U8uJCJUYLu20OxsuzXsrFHip8dpZys+2cY9jUXx+KmHbSNNg8CNUGUP6LRfWjBiG0yBvySHYBIXDofL1VmLs9sTYs5wkYEjMgxKOhl0YCEy/0Hc9qU+ND4uuMNCLFJaz/uGqDoMQ3GUfw8Lck5g8dBUX3uiITy/irx7aUYgh3yCaWRerOejsecelKaWl8zHkutDYaVNVRakj+T4OQ6E+coqBrBW7hSdp1RSdKN1dKgeubZNeqHvTWFbbajw8TLwcfzfQWgO/71QXd0PY7BgP0qLiCdEw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc48b5-3fbd-461b-34eb-08dea9885b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:44.5732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdca0m3vuDnUxB80gTDXqUtRONOXAkX4EIrM/Gy74wZJj+2QvSB44O8Jvps24lBdny3iLZ0HqaKMd60eq5Td0OrOJFwVcjDv/gvLS9W0vYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6098
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

Add a functional test to verify USB EHCI support on the AST2600=0A=
SDK machine by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index d787e90d10..01548dd135 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -40,6 +40,11 @@ def do_ast2600_i3c_test(self):=0A=
             'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
             '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
 =0A=
+    def do_ast2600_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -54,6 +59,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.vm.add_args('-device',=0A=
             'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.1')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default-image", "image-bmc"))=0A=
 =0A=
@@ -81,6 +87,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
         self.do_ast2600_i3c_test()=0A=
+        self.do_ast2600_usb_ehci_test()=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.43.0=0A=

