Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB90ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhk-0003ji-Pv; Tue, 14 Apr 2026 04:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhh-0003hL-Pm; Tue, 14 Apr 2026 04:01:02 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhg-0005tv-3v; Tue, 14 Apr 2026 04:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGeMyeAS3w13CWK/trv+cVvO7duOfpk0A+mDkzmWbwIA+Od/IQFHBFBDopj40ThH6vlWAvc+VvPlLfEodqiYd7h8K+GPtAzy1vVFN2rUjH8SSYxO08Cr4fLLC5XUHxiOu3RDDKHj2vDTN3xDczT2oQtWdnHZT6RIyxwdj0SdnkWFLH4tvGehiEwnhINsIt+mssZh2vAnMtXVt65gU0P81XL9iAZ4rWspmD9egUrqNoe2xs3ZD4OhcDs4xI10pNPF2sFM0cisjR3flhid986sBP+ScT+vHfuaFg9xwSdf0nyUzX677x0a/X4GMnUKY24yGpNbAB+JQcb91A1UwHgAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeVKA1gQtxE507eUBEjViUYlF2RK9kx3HlJM9tWvWpY=;
 b=cxgLubJXV++pfu5WLWcvezgSI28ezg/fDwsezwyI+vI4vdezX6cR9PZJ9Vt61D8BBsn4BGcAD4h7WZk6xk9IY790/2o+slXH1ghpLS6rGX5lZqDpo7mw2U+uO7ww4PfM8KAspN6fQ9S7LiwvZBu0MzFjGy2W3YuSWR1IkB4P4/2d/3+wWxvu8tj5H9yc8Xj71cnMcAK7KleLrJtYIrY+GmR1ptfZjv7TaFswgH61jfd2BYLdM/QV03rF+3O4T7l4JRNioIEYG5tdHlw8QTjlNSeurzxcW6+OZq0HIalqDRbKsnW6SOJfGflvfJe8/j1uK2WRE9yBYKuqALJdW+b34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeVKA1gQtxE507eUBEjViUYlF2RK9kx3HlJM9tWvWpY=;
 b=ahXQmJlGBxNMPd5dvwSd1n9nv77f40DG1a7tWmCzofnjJDF7qNWEa76LW3SQ7pjnOrnzrvYT0JX3CdnOGxAaVczwe8yaqdlj+gw5OjrAudFGc6UAUmaOZu8yDng6meiPD1siTMvs8+kshzNzT82bnTPLvwcKnFjoYufvOH6vErWKlpkZi49L2kP5OgzN/n1RwdV00EqUKj5cJu6gmCtm5mknuAI6yL1ilT4KWz65++cJoVFS0GTS9MPw2xaaT3yDVJgIlnqycAjAdLr9tMLbddNTS4df72Zou7Q5c0F9iorAOVVmgSGGkx7QZ7MLCqJfGK8zn+HWVyWmwm/odO0KbQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 17/17] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v2 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHcy+TM6C9nRA56W0e5kCkXK3qE1Q==
Date: Tue, 14 Apr 2026 08:00:46 +0000
Message-ID: <20260414080025.3005916-18-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: bcdf09b0-a1cc-4405-b934-08de99fbef1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: sYnQ3C9V5ssZ36E1B94oXO23BGsmaK1TW8j+8d5N7pjb1GNS81ssQ58kCM31AMYjl1tIsJYHCdjhUmEujgthCFZfJsfB6wgIvStjMDCFvM3IAxxjQ7EtWfkwG9+guVsn88GdNHKU25OHRVeP2WXE2ZGOAfJw7wTSEANb/mkFKOWnneURU5FGMw9CZB0GOdtWqc9DykdJeI9Ft6qqewsqEHxDM9s+vgSqbCGjKFt9+S/w537s3Quh1QXcTgFhO4XNjQSEwnYrVV8kjzSgMI2+Ztn7GsRmUxsazhaJfG8/Ge/0Ia1aEcB36phYN6eAFj6BRXtkdq3BSvsFr5yK0oI8D2T/Fh2JiQ/WDV+YK+qchENL1tXreb6yRe9oeNWz9HpePxIqyW3lJmXwx0pbzs5g9h6LT5dD/hWnUagkD0TdINpqzgSb7LpapV35PyeHK70nrI5l/FhLF5rpTXwfept4g4Vb3ue5P2ZHoFtgZZNmYfBcT1SrBBlagR05AfC7Uf1Wl3PHhlMhi9D85Ytf0UsYaMbfPBvZUh7xmyOBBFR/mlrrgub9AZJsAxy57+FFb/swtZulOb3Km5VoOtfl8cj4CvCRo1R83p/a4yUpbafRpNwfB6W1kGOrie1o1CYMKcr1120dJagITac/VMhkRJOkEZxVknDAdDNWVBjGd4ROO2YslvMD7URIUMiNGrQXq7l8iZ1cO/VQbM93ukJ+yM5hEFWDsJhXxHs2uX9VAdNBD4hnnG4duR5tFZ3PpZH4sYnd0bXv3kKRV0hlWMjyQeogcdVDRfK7F5+z3EGAZhzyDXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jMO2THY5TzTauTaN1PHlkSqGOyAATNqfSIyI1RluoQq5qM/bfcUwveOo7F?=
 =?iso-8859-1?Q?JdcROb8i2LTp9gw4CyklMYf/9ujqITqJyBf2A7GxltOPzXWfjMzgPRx8Oh?=
 =?iso-8859-1?Q?kPF9SPiGx0mwaaBa7eQgXbgqjml/XP2ocsWsF58lxlJwc0F6wg+NW+rls8?=
 =?iso-8859-1?Q?nOAjuUcJSR9tzmT1mG3q7pT9L4JsOKt1hp4ytSER+RBEdnRwBNitOR2rXl?=
 =?iso-8859-1?Q?l68+y+PHnZEXyBCCpKnToBJGZQNjC9VNyiNxvD4epJrFJHFe+dux/BrIIa?=
 =?iso-8859-1?Q?W5m3sP1BvocrYDPMgGOGnK2fJXbkXlCegRvASVaN6Hw690/F0PP87p+XZf?=
 =?iso-8859-1?Q?Yg+TPdZ0KsU21EJhQycZj0XjpWo/Q3PQWXci+JT+Jdm6DdJKikkOPACRZv?=
 =?iso-8859-1?Q?CSLQXvtE4zyHB5Wln+045L4KFy1WHmMzVbZG6oUEx0LycYQ4fIPM7LfDoU?=
 =?iso-8859-1?Q?pF09bvW8z14ZRsmWBJyz0j4fpOXSUiBJg9fBoHSjh5lCc4CQ2+i+sM2ZPs?=
 =?iso-8859-1?Q?FAQeWMHRgzpBNoDQqEdgDJlA8IVU9J0ck/sy3BW7tIZd1jV820pSAUN39u?=
 =?iso-8859-1?Q?/zm9dx8Rp3/ih24h1ELUf0j6JN/4CoWioP8fYMTI5X0WgBE9mtan1T2u6A?=
 =?iso-8859-1?Q?wHFdAQ64fXnnF056ZzzZr/y+jMZOWMGzb7ewELBhLcErwqMiaDuPV7m7XX?=
 =?iso-8859-1?Q?W5otsZc4JLsMKZ+Cui9x6lROnJTQDl9wDetCwPAJpDTMyfnFkefdmzfh0f?=
 =?iso-8859-1?Q?HMWOFzohgvRbH4OHGuHxDXp38IpWmizFELq8oXv2+0UFOFcKKpCOr08yFi?=
 =?iso-8859-1?Q?4gr/NjQRTCZvpfTtxHRQWg4BanYCstVFPlMwG3kG8rwB51/vvTRTncGCn3?=
 =?iso-8859-1?Q?98tltewejwWgc5fJqVd4LRFDKYkryFT7nCBb7NG6fECC1gwkrncN5zY1ZI?=
 =?iso-8859-1?Q?XjLO9QPQebMGZk2kOAZH7r4ZQr8qghJmmfMwtTHr9lms6OgH5kMl/LATnd?=
 =?iso-8859-1?Q?0N/TcOC0YzKlb6YCM51wSDTiASx18zCXo+p8CKWDlyiWPbIjSykLjYRSBo?=
 =?iso-8859-1?Q?DXzrCScAtE5EaIqV8hw9/U52ojHuaNpbTlLWrzUcOC4ON9dedUs/+2LUox?=
 =?iso-8859-1?Q?qHFIP9a4hZd2vfqlBLY4jU+BTDICKxmLjYdHxcI5vFJttxlzaDhPgDqhZF?=
 =?iso-8859-1?Q?oaV+2o8DxiIRKnGm23y5TUAWB54jt385qdIwi5o0RS33gVMQjYt62/xQ6b?=
 =?iso-8859-1?Q?sOmasc9hiFG1xD/QUcj+Y6jSYFiE2uW8oDk3C3ABYZyL6bB4lPM/zwH7j8?=
 =?iso-8859-1?Q?kOPJNMznMVNxLYhOli6aWmgaU6jLOE0zq5UATNYlMfZdCgTFIuLfA5YdIB?=
 =?iso-8859-1?Q?SB6oTGGeP9XRvI41h40FEDPL9fr2OTr9YH4icKqqw6vs9JxaDEw5j7CN0l?=
 =?iso-8859-1?Q?NQ63TB1tndH1Qm419E4q6uCPuQ38tkt5yOBeSvPTORz6yN22g21K1QeWO+?=
 =?iso-8859-1?Q?JVP3tCy3CwBurefDHmcnVcTZCbGJiIIGGjDavpYS7Nvz5xKoOPtq0CVb5p?=
 =?iso-8859-1?Q?Si/RyBTHUTZrLW8LNHorQ1AYSRPCPOxf4ATGWfnD6jm3WF9Q5vJQX7kgHa?=
 =?iso-8859-1?Q?wREuLUHVtLlFlqgy3UrvHuGi9UtZo5HjbToS7xiDfZNel61XqtWsWsdud1?=
 =?iso-8859-1?Q?xqcM5AkSpJb27VDTNTsE4ZCaYOHZJCv9dhN5NW6T+405MvtcRsa6wYA2ZQ?=
 =?iso-8859-1?Q?ArtLG/wDaeA5pxOcRbYTVVbPvSe8VafbGQSJtdbUwlD3kM0aN+pMNgUfNe?=
 =?iso-8859-1?Q?2Q4Kh/oDig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oR+A7bJKndutIxSUwpqYxMqTt/MiT0QHoB7GR2mcxcE4wzOT1DcwjZq4kl6ulpGzz8c41Z4VHFiRHuTows4j/NEugI8vxtuAUU0E+E6E0bwncM5eZtrJZGKviHq6X2eInODmTZqa9paHneuiM+SgL5bHd5Ev7wMKUDPIRmjgb1Ngo9lE5Sk0gKt/8lQjWyajq2Zx2uVzqG1kM2WKWvGNy13nrx6mhVCRdqwfvYtJsDACHh1snpnGPoMmgsZWie//IsOUHqMejS8BgajgYZ4Ja5AxAQRmnrtzHsxFjvVHXhcPzeNVhhuK4pYDTeNIMg4nmuyxD/7VnWQmjqX48300Pw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf09b0-a1cc-4405-b934-08de99fbef1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:46.0819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzR30WLDgHZYm2LBI0nTNiqNd1LGHWhi6JPZkS5nJFin0egMJ+aygEGDOr+rFkJxsPBdPNg1urFpga86b2faHKqH8qJkUQiHe+cSaMm+j6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
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

