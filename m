Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B0BFAD40F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSD-0007P6-Nc; Thu, 23 Apr 2026 01:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSB-0007Ne-7f; Thu, 23 Apr 2026 01:18:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmS9-0003DU-NO; Thu, 23 Apr 2026 01:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCqoZVWuOlSFCqY3t8PceFPV1lxdwX6GmeM4QbpZ9RrGVPNfMoYWsSwe8JoNPY2mt8sd3TZUvy1s0/bOVrUaPvG53rR6UyiCXzZGzafHxjnArn0msayPjX15OlJMuGU9NqxycJdwgEszx/gqqELRqjHHTeZQledd174K5uvao56WP41inMm+11kEgXaJDyyjeGgi6pUOhioPr+YriuFms+hCF+tlGlZmDlzjNJyFXWBAsIZaFaGd9EN70Mw6mZhO5UZ/YpWIBtMvDspp61+bTb0Y7dc25tJt0NUTf5LKjgMaTY87DnSHJMoaLI626IfKDQEnA+VmCV6uNg7tqZZV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=ASq9ae2WA5UO9A2Xx1OYc3H3cRHLw1USapN2fV2ewUsUfypftqp5KtPDaUozoPGvhnDg9M/m+towPhovRtMibaDwZpNL88BcityO1vBXg7lA/ilJkeNNAMPx8JWODPz2x61kwOEM+SbJIlccqirdWOyHlTqf9gwV8bGjkuZUN2g02pROK0H0yBGiJIn8bfFlV8a6n/rQfd1/P7qyZOR4Wga7h3KTWkgy7NPIs0nod+AKbmrkxCq6hLWaC6nivE+BpnDfKaghKlnxJeZcB3GKVc91L5wE6bPIcXgr/j0hoM3FbwePYcCrl/OE6NX9qj1g1ze7BDmF6Dk/9YjbbiQGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=luJ+9HAjxjeXtAIlmgm0DQbxoUYBfvym+DaSN3tS4GqycBa2HyDX60Sq/KZHtJVU65tP0rI8ezklvG0qWv+/pIxsqihMJlg4wB1QKh4CmHxmGKM1HYHDWpjrOH1bOZhaVrXYA9Bb/yM0LEZ6T8nk34Rv8Tfqt7Y1oqN26xQ3SplEW8+9P8lpVEzFY1RQjjGfT79/YMvcVFCUpwpsQcW87wUD/Jydit5HFjDGlAGxVB6UAA1I9L3QBDtNGIw5JyONSSRl7hq8UYR3TC13ViKC3PBkgtad0A/U2vVmwhBwo/UFgmVzCQzC9bYiwCCfr0wo9CEhkgOxWFPBWBNHgp5+YA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:06 +0000
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
Subject: [PATCH v4 01/17] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v4 01/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHc0uCR4MubAmOl60ShKk5GImgtag==
Date: Thu, 23 Apr 2026 05:18:06 +0000
Message-ID: <20260423051804.362095-2-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 158df808-41a1-46bb-be4f-08dea0f7b3ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: KA9qmnbmjeoIrXO9ZeNeRliP2lllplGPPrsNjq/Pf1V4d4McUpf1Vt9S7A3G6y0ewNXtBval0JjqPr6pwSAPqq4rnErYn94lOPZTnOyUTz4wgTP9jLWntY3P+EtzNXljmgOJi6QNuy6MnuwGhuiSQWpecW4suAgSqMqYSa9LaTy0ry303DSB0plRhew+YuAq+IpkxZbSW4F3AE6zs6f2eTdT1XSCKbIxqOTafjGCjsoKkG/9IsTg53e/UB89J0Z15JnQUuWGVLe5Al/24i0nA0RdsYKIf62nWqeL3XsOskcntDWcCYM6A7Zolb3HHR4MYajsXkGoMs9yJqZZgS3gIUb5hM2GjX+kq5GmxHS+E6nUZvmhj66sYNyfVnuXflzgfRCLHqlatYTGulEndfYyOsupVgin+9xY6bqURdGyvbVAVF7VJAb9lz96mZbcV7QmFBiupOb/Ni8vw3aBqDvTMpNlGh8/Bc6KNUl1PsJ4aDQcumQHi91/Uiaz256KCXkGSq7DcUgMPswE8Fz8UXjmJEyTAyeG58C0VzwQG2Sd/mxRg+g/WmlCwC6Mxdm3x82O//N8mTMfWVksT7R21xH7rdLwa4q/OWbhGzpZB4/qG52bi5dV7AgIBvZsvkEkrBe6c2SxALVAEr5PVyh7MNel1Z77EuB8WBsw9jJm2jxx87BWKEM2QcQvc7MGMIcvBSX+xuVvWzcTMOll3VeNsOcm3wWpFxBaWA2U6Q4JV+i1TpFyxxtYIWqNnryjCjbJPhVSrKEybFqMuAiNuISTZVB/47cun3lxkyBpKY7joWkjNYqkow6gCOVSFrp+SoQGmJRo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KwP8p9d//FazrvEbZLmXBN4y9cO3FCN+wdBcewicoJS/BQwJDIWZCqK/Es?=
 =?iso-8859-1?Q?A8nr1Ifk0z0LpGNO6boqq7DSH0cnJW7sbPpRFW473uNi/1bcXQVhrxLDtZ?=
 =?iso-8859-1?Q?FYIDeFOO1ZHzy1jvoIrNrxQGhXDsMNWaXwTLucXu8WhOupqBZ/7Xthks3k?=
 =?iso-8859-1?Q?yxzIM8Rg0D/ib90QgLerDa7J+89vyfdh7j6VMXt9KaeMwaTi4FF1QuQbSL?=
 =?iso-8859-1?Q?0FNrvp1NpS8UEljKbgUtxkGw5qibfg1+LhTTv5sKOlhWk7W8jYW3RT/htQ?=
 =?iso-8859-1?Q?EeOWJr/f/51sC7TZpiPMFj8gfPe/QD1HXUY11FajrnxaQ5zhPd50DT8tsd?=
 =?iso-8859-1?Q?Dr0iKq3Kz3M+g1zMa1rdsItrpMvva7ZqzNebcgkxuQUqxS6NhzY8Kbf/1l?=
 =?iso-8859-1?Q?lE2APO34FO8LDQE3Ja0aBFKoZjQ0KVoE7DniMRJqn3MwfBbWqEoJ6p6DMF?=
 =?iso-8859-1?Q?DEJKszAovvrUMVdTpXhCbIfEHEK+ZrAl6evg0mqpqwXdxzAZFSMplj3ixg?=
 =?iso-8859-1?Q?VlVuud6zFFOsiU5dJbK2m4l8rs1z/Lq59FrmG/u6Gf8/uoO0O4cBoGbjnc?=
 =?iso-8859-1?Q?0SDghtqRVDgrYCUb2vlNoGBUBONRDxsXw3ES1IpE76m8SClTbX5Dac6rZU?=
 =?iso-8859-1?Q?UiuZtiVEqWxbfn4YyNInPCpJ0vFnDWYlDX6O8lllMBc+Cb4yH1N94lWfQr?=
 =?iso-8859-1?Q?zVvRRSNjOXL8Gn4XIwCp2xRin+7lcXn1+UkF9Te1yMA0+0fXVQ3vy4SEfZ?=
 =?iso-8859-1?Q?kfLwETzE+CNqmzIexfV2TD9TdCc1BdiEpl9xklp7SAggl/0xYUDnmEYfJX?=
 =?iso-8859-1?Q?g9xB0q7ONsgxKQovMaLd88NdZ2ahOMa/5zjXgEuNbEhqL2jKGHoDSy1zrr?=
 =?iso-8859-1?Q?oMOwjQR/mg/hny9z88gl+hAjyUgO5DmLcJTBq3fqZ6e5rZM5jTtIjFnNmH?=
 =?iso-8859-1?Q?n7FbdwClCPVbHoAITYoRqAOJGnJh5UF3iPKBUL+boJJYqZz2wELEfKPcFj?=
 =?iso-8859-1?Q?+gwUGKqBltcHYIfzlnhn9kGBgFGomj3+iX6ZUjltHm1QDpTC84B9hxBoRN?=
 =?iso-8859-1?Q?O8zRTjCo/rSOgt8AYjLAPeduBhrYu1g0ZFz9PR9AznK1t0v9U6Ek71ka7Z?=
 =?iso-8859-1?Q?6jVxiIyPqx8HkD5wwgk+OCAMhen6gdlkweyijh4bb28WxMnJC6rGumoEI6?=
 =?iso-8859-1?Q?Mo4SoLwh2TPEJi9fInm9XVrsdvbC2yapXT+0rYYgZUcK2KU7YreLhP3061?=
 =?iso-8859-1?Q?2AV25bBMTg7yt68Ia9FYn21U5+pSePZ9bCkpP1UjW/qz59G7ROPFBHRt+z?=
 =?iso-8859-1?Q?ZjvGxX+k4nNvtDJjLQrjMBTtg7sXkY/H0hIV4JXrx2ZI478TlcF8pSJpXr?=
 =?iso-8859-1?Q?uTfcygYFS3xCwp3FQ9aTmBgXe+TaP9h6VXKzgLwqVVKwiPJ7j51LTgO4vr?=
 =?iso-8859-1?Q?o+4XQUuA8v61ArsibalBMJn9uiMOzy93UiQok+MPBFq1jADgRIy98V+joq?=
 =?iso-8859-1?Q?QsA6SO2eV+tCVyND7Wlp6HFmbHHW0kmQsqpZ1OBqdRZ1t7cnXml6tMdWKZ?=
 =?iso-8859-1?Q?gVEv8L8Q8i9UfDtt4g8lQ/vifMXtBzyY4COVpSc+r0x35s5lsNZg2GFf/Z?=
 =?iso-8859-1?Q?gdH+r7oNhjY7fU8HGcU2nqTpiMEM8oMKzN7ZvcRejOHPVp9UHC9NWwKrkA?=
 =?iso-8859-1?Q?w7L1LFkRxqO2p9vBO2qrYZpabEW0H3eDqS7VuDlHQF0+d/8Znhjcc73S/p?=
 =?iso-8859-1?Q?wavQFVrBx26NX1kyVIDu5fNtpZXn04mvzhqY8LsME4lEH1+LzwdEkPRP4e?=
 =?iso-8859-1?Q?YNfsoVytgA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VWPZhENCgXj8/HzerUZS/OXfLCcIj56FL6h0cGUNrNHAzqMRIJJoubJH3cbQkQuUPfP58ALOpqg0xF/4kIhyyqZYNPxLcUdy2H0tD9EykBlp5XglrNq1AjIobS4ruFEX2XtruZDjspM36PrvIAGCMDM7bkNw+xugOL/sdsDTSyGDhKHl0qAHwIJwClizIzdOH2cMKNRERPHDwuLIbbqeQ9w2P9f9agfl4YWcuPrhzqtkTxgqOmSYyUOTE9sllNv+lWVe0/im83/5H94fhlE79fnIuCUk6agbSIUndFHJSsBDXF0CtmvhfkGEoEVL+QM7Xa3qnZ9JBEnxfOD1KSiGXA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158df808-41a1-46bb-be4f-08dea0f7b3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:06.8929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOhHnTWLOeYpKvPSt6z1huYFQhQjno4oCNQ54lhm/GOALnz543VThy4tQhmhOE24khlBrhFyQSaZwOu9sJDi3/wHJ+nni331ZhtCfGyuobY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

