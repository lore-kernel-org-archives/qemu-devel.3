Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF7FED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhj-0003iY-LV; Tue, 14 Apr 2026 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhg-0003g3-92; Tue, 14 Apr 2026 04:01:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhe-00060M-HO; Tue, 14 Apr 2026 04:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe1jUv9/kOWMJ/CTMIFLsnWVBVVeWAa/nezrrpTpaED0ygUrhUU24mdnjpL5bf4iWBQWqglgkiBvlmGrtpP7pnIWJN+WjhXJ5INNebZmv/24x8yoVlUjlythNDw/3z0C4Xik0l5GeOjYtbRL1tMbFBecMxoohyfdP+JuPX/oDFwTmvXDIAPRf9a9BdsE0RGUL6E+0pi3fTKZN3BVWPczTVjZxj4V+FuwSJAmc5YG4F6sVNJvU53CgC5NtAG+B7YdBM4DWVMerHS4qfwBHGbc0bzceuTfMq7DXfRB8EVl17H5hfr58x7hS207RdAznU6qpFQ8OP2yz5kJwzp+C3Ff1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+BXLo1w2+fDyW521IkHc+Zp7jJkmj+YQyW9uVoszJo=;
 b=WRAXxi19XquZYa5FEGLcziqOTQbLdGZfpiq3RkAYDRuysd2Wmw2ALxPo3Ykb5AJYalixPre0o3/SnPd6O0QgHyCQmQrjgMr2zhJba4HmYGv1C5GdwoRvnGPLKuZ6a98phu2mtuPKQslj8gGlZHV295vCYF6YXBINPaE/RA2VF0UjeEjq7M2w3whRHqKWwhFOtkz+1RKo3vrScFfAiCmmuenyy1GdPnHaQiK19l7akYKTfAyqdkcGgKlW+1qA7zQuRE4hbZOfYY9/1/9GqAgqPQOXGXvnW8HM67seiVn0zOeP0qYSzMCUvc5+RvlhAtQVptT88o7IbdECEvD/bsw0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+BXLo1w2+fDyW521IkHc+Zp7jJkmj+YQyW9uVoszJo=;
 b=B592FG0hwf2a4iWjAvFBwCA3gnC4bXqQ49iPBmIXCnFZTvwdlLt/HrvKAJZr/0ibeZ7H75eZZ3jg7hONYIGwjkloofiQsgg8qrpkLuYDcw85MFvIwX2snqrrvT2mGtaacYgcwyk/bOQ4+64SYxbmu8jBcbtdBiWiT16T7bI4RmLjbh3Z6uh8y1vunBYVutzU+er/h3HtlOiNTHuxtNLYdgizF4BnHE9wB0Az6M3mki3Zz1IHNfpb12sv4RJYJQ9nu/ArBDhi0HM7MTSTRa7HsOgMy/qvqIlFlLZvFRFpcTsooigazgH15FAVyNkReN7VdncDYJDc42CC1fVleh921A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:45 +0000
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
Subject: [PATCH v2 16/17] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v2 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHcy+TM4Eexl7bBWEOSo3UyOpE3uw==
Date: Tue, 14 Apr 2026 08:00:45 +0000
Message-ID: <20260414080025.3005916-17-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5cb22094-b2f8-4271-56b6-08de99fbee86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: oM6ARDgh32FBDRICyaY2I7JQ5wATXF/yKJWFiPkhFze/C6GEUw6CmNJ06DQfu2TBB3MUuJxEnYFYR3AdZ1/8rZ17lSVzVXmwlD26P6w/5v8+nSbhr7jT2syKfAl2JjLiMOTMBKrS7axD5MnXmHsF+5DSEzpYzFpKQrUQEcdI/MCp9Ap7gpHObjDzgY/7BM80FRb9MulwK+4FSbquiSLNAchl63fJVD7nF8APtNYTmSw2P5XbmvIevqaPL/XmdxS5Sfu1pTb22noLL9g+xnOIV8UsVLcffuHo1OMvv0ouQUqfbp1de33N5SJhYhqVCAzpwx8btD2UlXxphLREBEl414DfwdGowGwHOGAuxMAqQoXIKV+xhbOGPl7MEOAV/c0/opfhhJpsWOKf4TpCnglIrnTro5vjsnaNHXdWr21OrkxDjG4OfhVhjNs0PvMoFgeqTaQ9/oZ/sL0iR5czfC+35gAy5QJX6vubh3oRJsR5N9B1NbZKdNk2eiGtwLUdf8SJpIrNzjheNtXQjAYjmgiRBjSv0qEkSOO3HUybbV27xMhZ2ZReMjH3TqsQipn8bau4w1iWzN5e7mEKKWAEjGYHECYcv0HIJX/6Fu005LOdSUANZJW2ffOR3tGPX49Gwm4Vv8NJRGNKteDhaHEONaoLF3p7r1W/hDXPeCuIlFVAhJ6FlPJ5ktbkUttC3vwGjVubx5gaJ8QS8maT+mwk8BlDe3ZrmoNr6uGtp2CTaC9K/ug/HgczxrctAvfytrtGxHyKUdFtioVND+EmXCy2oxMCEObd2NEfVGowAIyBluL3i70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SmVsZaBORM16coLY3FkynIC0SUY/jJzut5ZSJzYdJn75HO6zPeSV0ZqoMe?=
 =?iso-8859-1?Q?75go7KEOTrX8wAQPaOcS7VovSMJPzjuY9nM3QM8+76OGDfTvmNqrCKPrTd?=
 =?iso-8859-1?Q?MngfF10UhmNaGeDRpJM59ej47SAT0bSho8TvY1/ohY4kfkTldAYvgLDaPg?=
 =?iso-8859-1?Q?TXofUpLYqxHKmdcS2CvU+2bQgTm7Mmcv3g8xyMpbCgwUKWVsNCzupZSZ0d?=
 =?iso-8859-1?Q?MaSzfpRi0o3XNn2RJJ5ifYOaVz6aOeFGh1rrtXTFTITMMTD24rrukgDtd1?=
 =?iso-8859-1?Q?kipoVt3FIf/glzS97/blyMkrzYqRRfic7xVeE5pXjAm6uEkVe/HKjo8G/L?=
 =?iso-8859-1?Q?LDapKG0akWkIWnRKrkaAH33htq5q6knbZ/qHkacGGf2hB+Y3vGX8hNjCXb?=
 =?iso-8859-1?Q?UdFv/7doJzavzGkQ34IWz5kJ+6ibYyc+5/Gl9bgg9N8fI/bqQRP3VZu5Ad?=
 =?iso-8859-1?Q?DzReTEcIR2JLHZ4NAVmdIm03WvCeJLyDUZPkYOX4of2Mh8+5ZpYcHw+Ffb?=
 =?iso-8859-1?Q?A/DIDovNFMbghqTulgQGjxJ1B/cfySSamxloX6B4TyWxovrcKXWqURslN3?=
 =?iso-8859-1?Q?muwnL7jdeSAA3O4mWYB1ndrI7Tea6F3yyssqMh7vT8QjjBkc+FmLWWhqNq?=
 =?iso-8859-1?Q?ynLz8GmrB4w5nFMEu82fMtAI8OONk/AHBTCje/lVISSGaiBmgh7JfuF1fa?=
 =?iso-8859-1?Q?YzPIYRjwHGCGGYjSguvaygaXGdtyNOg2bdukt4m8DyVxTrgTW2Wnt98JHZ?=
 =?iso-8859-1?Q?a1iRQKWOKsrkdreIVJ+he4P6bVCYvbL+kx5XKOvs5cw+uR+gqo+9wqWMFH?=
 =?iso-8859-1?Q?7Ollu7WnwbE/Jw7+4jdjsdMr6fZgvbQVAebUR7kDwNr8wxE1ziyA0FzDIh?=
 =?iso-8859-1?Q?29CvBHloGPepWE8HfXkER8MMN+QOgErW10MzqMYXoIlG964VDX2o5aQA4o?=
 =?iso-8859-1?Q?Ga9GnGUidMPLCIgDgVqZ5s7v0JI4SvsPJdGr+OkwpsF2VkEnvFrvrEcLQR?=
 =?iso-8859-1?Q?bivPzrdndf25B50LMV6pdPgYTvP+h1Dw/rb54RiahtzkoPia3OnMnGIPoW?=
 =?iso-8859-1?Q?Cn8DETCiKQH0fz81BSZdQ2dnEI00KwowhYQ+5Gh512wUNpO3SsHEDCfH+I?=
 =?iso-8859-1?Q?MA5qXZEoM8KwtLsz0jwoaCDlGMu3jNKWvwJxw5DuGTn+l2EvhqnEv94YuD?=
 =?iso-8859-1?Q?rqAnNiyE1IRVoO9SBPbrXpyhkpqaDt1tSzeE9xq4cnUbkw5eO39cWdXMXX?=
 =?iso-8859-1?Q?whNq9aXCF2WrIKjr0CsU97z8hwHoCRFB010mjJJQt5arytHYJbUCLkTdVV?=
 =?iso-8859-1?Q?9kEGMz4vOyUDp5fMJn6R10xekJgWfjItF42EbprH81IZyyC1aaPvlWoF7t?=
 =?iso-8859-1?Q?m9T7IvxyjCoLflS/ak0bs+zhOG4FukZvT7mfBcUDLWYXuMaGl749LQN3cm?=
 =?iso-8859-1?Q?EHByW4QKmNJsvuda7uVsRz3GB1rBpwv32JDelxoInaYABSnc9jnhxmM3OU?=
 =?iso-8859-1?Q?XOgvtGi41229Anp3cUoAegJcRpMPAI/RaVg/HjCrlMDSDRTlype4TAgR7W?=
 =?iso-8859-1?Q?l0he0JMrFFAMKtZHU/CR3Z0ieX5fXqljilkJp03JiBlCpdCr4+hU4kX/KT?=
 =?iso-8859-1?Q?bue7dbfN6Jl/wDwkA9/LGIS7BwITvDI/xWX16Qv7g4lnLCBddbI/hc7xQj?=
 =?iso-8859-1?Q?o7oJ40GdBQuSLOVJEEjsD+ayuWvHCywNbfWeFCPV7+hceCCVuYQna3h+H2?=
 =?iso-8859-1?Q?5DI4iFKLYONC4ns7j0i30IVCs9uZVHIDy/G9Oa/rGsCc/oUl7c1ULoepGd?=
 =?iso-8859-1?Q?bU0VsC6BYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SByREud/eFFwxD2L3NYh09vjhVtbheSAAMiz6FivfO6dGCgRsNBYupdhi/DSJo5rI4hS4AMSkltKw8rbOEeT9m/EigfOwYAhSIUjTGi61SgiM9CBpKSOwdwBg01KjRXdJqTd66QnqmY/KZLAF0AHOakxQLZEfyz/ra2Fr/qSzq6yyicxuSKgo2H0Fv0GfCwsdTxlrhVhrLaVUv0zPb/xVbx4jaIYJtO8TPotc+H1q/MXPwm6POudl3xZpXwx/yVc0EWQ/nCc/OmWhW6W2CQXxsMBBgBl/rt3G826k3sU89PIX0J+rtlOgeVJqMFoWRRoTNWMcSJXvh0kR4pER+0h9Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb22094-b2f8-4271-56b6-08de99fbee86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:45.0261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kB63DbSeXr+R/q37jjOsTuOZygUTz+0dyleKPBcIAU7/ioLkwo0H90QgqjBFL+l/JBagD94rbmvZu/cinSZm0nxcjrovMKygutDoYG3F3jU=
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

