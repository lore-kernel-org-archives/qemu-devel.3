Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2273CF433D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsv-0000YG-6Y; Wed, 15 Apr 2026 21:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsi-0000NL-3L; Wed, 15 Apr 2026 21:51:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsf-0007PV-OE; Wed, 15 Apr 2026 21:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7SJMGWkvYQ8s7h1dTe1nC2CLgMRmtTSnR9rRC8ZZhYvLiuEuj1Uo0xSBhUr3cnvenjlAYv3QavXUrMXztfTFeZnQVa8qQ/uBrBWKfvptwAHatf38gQv+WymWyiNSqMI34b4iNaPizlzpV08MQmAKbGk+4roLmjaHnvmumgBJdFlCjQhzqKFk+XLtbGqnGdElJvtbxEdqYp7YsKpXVMYzlRHcFLsn7H36/vy16F7tUjdqzLwPrZXTIYfCvHHZGQWsvcEwsqHuBPzZ6eKiANsF32yGWBAqrjs+m4CBW9nQjTBCuvzwxodUGHpfr3TH5SF9tyZqEoYNHitpAAeFg+qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+BXLo1w2+fDyW521IkHc+Zp7jJkmj+YQyW9uVoszJo=;
 b=RpFSXLOGINpeRF9fPLViKM6ah66nis83M5GIKj5RneQjTyyfFDu3tytYF+vkAroUHlzxW8ZiCwcYrNMl1tiIjiGlKZGw6rjPKEIdMNZs/una6ZNNIUkf4G3eRTvUqcz3fXdoDxDnw1n+ToZQfqlHCx/uDIqbya3bu9jTvHq39Ck56NtCCChgmTsMWbGb/0gtzOFEuyJ/ISeZcerNirdpS3aBGGwxIF4w8Ek4rjI/F7qXSzCUkVKMiRxn+UX4jAuFowJhZ7m+khCNWgGemrSY9ztmPj5SkZ2OKEnNg3fX+dV7QhwlNsWp+ajvJ50nDT+HkzQNMnY+9QLEuW3UXO6TQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+BXLo1w2+fDyW521IkHc+Zp7jJkmj+YQyW9uVoszJo=;
 b=I2LXuJFhACuZWXxyEC03l+POaSOy16wnmA/UawH8f+OJWwf1Ugt9EK/eYppdvWRQYAevpUgDR/MIZpdnISTe2Rs0pKTMyPh2afUFWlTzWeAzTHLn3rz+eGssPvugQHmo5mCnXN2RV0SoVratYo8CJOkXEsPtPyj2jm35oj/zPP6MULLiXC0/77jAri4lZBI0cdGnx/2161GhDTk2cK04GgRk9f26MHD/v67VYY5j6f1b1H23z36oRdi4uKUmGUKRYOIRh3kLhwGI4TqosHp6GBHMoWuE8+0ps08OozSRsU4xrkNFK9W5SIIenrmXQn+sbncafT+eXE9TnXDYHwYPqg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:50:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:50:03 +0000
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
Subject: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHczUNXa7m48IJ56E+5bAyC84EEbw==
Date: Thu, 16 Apr 2026 01:50:03 +0000
Message-ID: <20260416014928.1279360-17-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 97c65d7d-bd21-4085-044a-08de9b5a7a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BIBaTOFZ395/pImctAtZ36glM2TSrzDFPcPwIh127tQMlJzeSs9sOQzefR1YBj6FzDBmgzGkVaLyS03iU5u8MhidAEub2MMoe2uM46WHsYwtn/XJtpiyibE7O3vZirnD7gmcyRLBaEEP7tdwF3TfgpEvtFKFgWcwhgtBG2uyEfSMY6cH/+hbCynjzRW4ZH4ovAoA8zKlaMejAVfIPEci2R4EtFgttwdL082Kn0tnd/1RRWwLZ5+7W5DNrXhbjU/mlAvvpIMkh9GwDeAeS9XFYecaBzi1USwJR1Yxo50G4iC3Lj9JysDKO4KysBRp+GEqkVCL0X2Yt7qsg856Lu9uWAUuDFxjtU6nMJWU+oPkr3lqvSoWploxSzMq+xFFjiHGZFLsmD62d0W7II6M2N0o52R6YMVqmvSv+fZELseoSMQzDbfiC95rlNJ032qpKQ5SuPN/oYQfhh+fwm7uuFjxFTbwcvDI0Id/cC4t/auEBAUnzpoP9zsDZuKoptwn9a0FTutbYUJI+pY0rGniMFGHYwPHRqdM+iQ61HA4UWqhJDcXkDmUq2n1wU3pIA4L2Qmf9pD95fzIb0xJD6meLTgfnzgpiM1zTeWP/93pDoBp9iElC+pSPJcrKVJJK9nwR40Znu9bBCF6BMajwyxH4v1r/4Yw0fpUVCSDMzLI3kTsEKNlDlzqBYpJ+UIDneQqD5Pd79B49M2YHPyyvECAPVyoT/Wqer2tWWUkNJM5zAf0sxJhsVvu84plezxjaEmw5rbK5E6ZM+Q0n0L5FY2UkQ2utN7WNPfwKreghgmOPGJcDrZXwsvpkyGYbojSUWQzSzPK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rq+bhXcST1OhjnDRfcojxnMSqS/K3Q0HeKD/fTWMUKgHqcpy0OOobjac9H?=
 =?iso-8859-1?Q?ikJArRW7/6EAWClHhkXuNc14a8T7lRPSHSEdkyelsk8KTjrXi5kvuyxp0g?=
 =?iso-8859-1?Q?+v2O6/MJheQtq5lhBZnPOvp49tY005XyExB07Of9qovB/6vCmtD7xheAAB?=
 =?iso-8859-1?Q?FOBv40VhlNth+U+auryyGD8GChubcK1bKHNPg7EOs5unJbjyT4Ij5ndNhX?=
 =?iso-8859-1?Q?V3b8wm+1eAmlXwNo/Dy43Ft6jQwdl8aQqVTAjYwBq8C4Tz2LGIUZ8t1X0T?=
 =?iso-8859-1?Q?AhiecIuqTBFlWbxcfTNa4bdr1r8w1z8QDFb115ABwK2v26Zdkz5ESlNX4P?=
 =?iso-8859-1?Q?x0PiAvy3du/IzEF0oAw0Lq87eX+ZLFDF17YBK0AO5H5WUNCaEzUH6sXEdL?=
 =?iso-8859-1?Q?bIlm3SrZeATktFg8XdIh94J+KT8NH0LfbkrKhyjAhLYWvNTR4RosuTy0m3?=
 =?iso-8859-1?Q?UdWtuOveQ8W3S70zA4k45JrRrKMH7GdzbzoirCw5p/kkUL0j4z9qbsKybe?=
 =?iso-8859-1?Q?+j1dmuFPGCTSF3o313hTKXbfeJ2JgXtR94f1F2R+clEpobaN6d2+aoScp6?=
 =?iso-8859-1?Q?BZ9JZdyq3XNpfxs/VYEp5PYP8bs7+FLG9/3Y+BUCvFqBuHVNpei5YaX0PW?=
 =?iso-8859-1?Q?SLoRrDLJ/4jV1+0TjJ0is+KGe6GIqXoLU5BSz3/O/jb7AEqDx/Zel5kFaM?=
 =?iso-8859-1?Q?WgNFBErqQuWOcvaIDqAVS/b55z2ShaEofeeCvcYSVuouyS8AolGHyJZ9Q+?=
 =?iso-8859-1?Q?0XRmiKeHnv6U32AGzhLZb3oCyAcfVejwMC+IDYt6zqKcIhldpRjr2uYbKZ?=
 =?iso-8859-1?Q?FAkFwszm4c50sBe0xAfwkFcS+mpbmNyMeDog+RTjidByIG/Ot0AT6EEgyJ?=
 =?iso-8859-1?Q?R43dhIOsNdPg1g+6mj0UMIrz9iBkaVfEnbxb5n9pFnRBZ2NXXyy6wuvVkh?=
 =?iso-8859-1?Q?5F9pIAM1G2WUSlt+48G9bZRYYJTWlUNhDGpXY09W5iXvjsc5bRr2HdO31A?=
 =?iso-8859-1?Q?n18nREAL8yrvqHdKYMBT4tBU5whukJfTK0X9MZ+BODzxfTHm9tcPpXi3z8?=
 =?iso-8859-1?Q?ytWUZ5OSzX59iXfX+sfZydH/uPEmoh0sbzurGFGNGQnmtaCFSn3QvPGOsa?=
 =?iso-8859-1?Q?MJG/e7ZbNfjf+LuetaazYJ1MJ0LiDlNtHKhq/xB1BvvWr36pJQ6y4v0u1M?=
 =?iso-8859-1?Q?V/3QsFZDAj58owlA9FRHvQHvqx8mgFmysjfd/2DiqfOTvfoIdJVunGJDJS?=
 =?iso-8859-1?Q?NPQse4yWHRWZnSsDC8UNDsBnJ4d//Mu6A5fWgmnISDLpE4Kz0jSNnUUsQL?=
 =?iso-8859-1?Q?aXqNHHpoMVFsEv8Pi7C6B1KT/oKERf+kMFwE8YK1kYZpczDri0/FlEVjzS?=
 =?iso-8859-1?Q?RomYlAZtJ6nfQ3NR3YGPf3MDxJQtxFPsfoL+j7oJM+j6cyUo5zEH/sb7Ej?=
 =?iso-8859-1?Q?QmftXhhy9GKGN3Gz3Wdj9xJUv5GVO6yuh/AZN7wNYwNXwFJnuER0/Aa9ry?=
 =?iso-8859-1?Q?mmwdsP59zo6TGreuAfxNYlzus2M1ltD+EV8sy4Vb0KtUYDlAvgSDGigT2j?=
 =?iso-8859-1?Q?dgqb1JNp40u/G38TcWCEL46dGRDh9s0mQ8ze4pkzT5zzwG5GiKrMBwYlmN?=
 =?iso-8859-1?Q?c8QjaM9I1fW99U4Tj8yB+qDCem72ZDlN2wm7O0qeebWsWt0ZXcsu1VFtBC?=
 =?iso-8859-1?Q?KxO8hLdvSh+QNijf69ByULL1skDCf0muerCMUnGM6gKSJ+gGtfL6CzTBKO?=
 =?iso-8859-1?Q?zGuIe+3DYu77s/Yfd1xoPSbMrEUC93bBha5jo8wwp1WC7nxY8E1jwGMMvO?=
 =?iso-8859-1?Q?Z7yQwx3Egg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ExkDoDIcWt3ZuxVMYAusMsMGRgPcDefBaMi+FL10XfueCKiOupvit82UMSgE0B/F0wp3ZbTSuQdjwIKANUaUzCAsBwllaXPVPxFYurdw6iveUoP7AfQG9AEBMw+EfKV19BvBRTc8RyuRqbr4jQyDg5GnvCgN5B+Fl9PT9H6m/o0kPH0BfQ0JEzY+Ne80NHwpTHeOes8Cj3xnbmSeB1uNgmnTh7aYE7S1SGTsn+OZzeDycfeww/rXytwtqlUxHM/C/EZNBeHn3IbWgTC6VEiX+OECyxSTAiG2wolBG8cXXPtj6SFDP2y0Bv1Njb1Z2NouNmP5fFEIRQ4V3FrUAnBKtQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c65d7d-bd21-4085-044a-08de9b5a7a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:50:03.5918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFBdhvsHDkivG6fTMbW9zigobitGEibpAP1uk8O0m31KSxTQh+oTYm8dvCoSeDBIeBK2OqQNcAWBDMcLol7LGjye46lpDXsFzmWOhSS/l08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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

Add a functional test to verify USB EHCI support on the AST2600=0A=
SDK machine by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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

