Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790FED58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEw-0000TZ-Ge; Mon, 02 Mar 2026 04:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEq-0000No-6q; Mon, 02 Mar 2026 04:06:52 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEo-0005WZ-FF; Mon, 02 Mar 2026 04:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfu9SJ+a1AizmfCxkhVvuC/CTED+4Ycf8hty5MRf+g6+ihrx//4zUunO5gS+CVnT6i4vw0HNMjQ2DjabO7R6xQcoUHjE3O+3+/wZlsIxS847rl5XQ6jhPUvtq3NpdeS8aoW1yxcYsnt7NQ71Nl7TW0C18Mg1SMQxnUMxyXOh4Gz4j29vFyaaDeXlw2jz6HBtR6IUQx94qnHModdYMguRuvAC8s+18KEMkj2o9eGDzfgfwWrPocF+ZQLlj5PBE3R6SHwfWQ+qFLW55Tte6uW1IA4Nw2IROHxC5dYXrF3qEU2tEuj2j1p/MQQ8x9ZThpBuEFE+D02K8KlhovYYCrz6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss/LBOtd1BR4qPccbCYGU7C13fq4Hd37y/tcDegXPJs=;
 b=CYG9r6uGJ+Q/SIQvhuDKxyoCZx6KGqAM4faDJVsweVpaR4hBbb20AYEPZCR7GXamYcXiJriKUyVFhNvWakj6fDvjaly8n3YL8ez7LUd0qgO6RgPGGe0vFI4rYbTMePQWsL5syFll6z0jxSyObxVMRlwtoL+09LqJFoYfDk6yFdR4WYvn51FUt/azORRw3BaAWcIS9AlD2tKYEGh+yn9eyZx7PfHGy38zGKGqy9/0tjHrUiJsR9UYtCC1QZuS9LBDkt29aJsCza4YQebFHo/7/1bKeMP60/sIHW9BRaCAifIfxr/VbpWr0lZtg8vx/BcfDOEJZre608Zn+OC4uMRH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss/LBOtd1BR4qPccbCYGU7C13fq4Hd37y/tcDegXPJs=;
 b=XF5mNwj79iuEkwB+eCQzKzxnD3L8N7GpAa8mnG8+X84t6dB9/wm5AtD6AVgi6ySDyP5CBrb6PZaFBd0aK0Yv4jpuOHnxe79nOoA/5IdA832qkbRvGKnO5ln5x2O9W3APaC9iR2jZ7mrA/m3CHX4t4Lv8Ffc/UKQgTDHiMUpWvoPLPQDAIXybi8zfB2nuSA042CybdZT2WIc21CErvujYTqluNfjLPo03kyV+hAYtffp42RzwV9a1WBbhUfcFw5Rhy7ibx5GGTOzF14ltcMCo+jzrsdRngfmtv3MBI0GmsqXMdthCHrXVmUsUthRKWdcb+/fgeww/SDLQfKRoFVQJSg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700a1:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700a1:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPfe+lNkVpajkWW2a08WrLctw==
Date: Mon, 2 Mar 2026 09:06:36 +0000
Message-ID: <20260302090624.987922-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 77349176-78c9-4832-acad-08de783b032a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: 58mjiN9iKjnEaXHlFl53zwMtxYN6Vch/xKHBaYnnThY7j+ZcKFrjKsyE5fJ6WyVIcxSM8DKlSY4L7j3l/tU9eV+l9fZTQFwzH3kMjI7RmDkr+Jz/oDtL23lA4YeIsQwItBoYr5L9e+NTiUwTCIOikV/sAQeAqMhqA7I+/0kj265rqPwF8tN/RoOi8eMbu1HdD90FzshBl5jGsNBjUW00K70Z7fLTUJckL9fWTy8XT5loMT1UM3zOArxYxYZ0CPV+QetOFb5rFAzMzLdAEtnNSi/sFnwneezk2k0izZZifZYVXJ99d7oSLzZY4xQOpAPAvnMVhcTLFDJfG/0ZqxQdrtIAYbuT5MSWFnZQXvIFHFJaNvJKGP1FRuRe0/vWo0iKB1U5KDi/19Ln6SMxeOXxewkqHH5cNUsPXRBW/cmDV8eK0zePRNma1j8aSxjIR6Vr7WKWw4MId3YxrQ4CA0fWZxUqP8vRhDnrne70RSR5vV4hINcZxN7MGhKh6AGTsQFTJlmanAP+wPK/3+wp5+CsyjQ9mgr3xEa5jjTGFaNQblT5Y20N+5bju+CmpQQ/kdlwxYYhWER3BxOHJV2hDF5mc/oF/m2QW+xdoN9zG3NBfqIS0DDHRCi/Lb5YDBqzKykW1cT8GjC1PKuoi7tAP+UY7UbRGq9OTkq8+seRL0gWFXLx1c5DHkIlb3wmOwSG53AVRSA2Bp04UIx7SXEaMuZuxo545VjAahTkqE7FacdxGQdxcRiUYVui/vOZlDktpYO6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UguBAOxZzyq85xGbsMRyDgK1jS+NLBEF60XFfIe1FFuZmmCABXumXeVehm?=
 =?iso-8859-1?Q?OOf/LQW0S0YhPXmiZq6lzVlQcp3Ggnf80aunrOOcq5GGxhx1CZB9cqZeEi?=
 =?iso-8859-1?Q?guemybLuFKX9PlfSxmPpLwvnhdfcyzT8S+0QXNVEwD7WqYagEARr1xLmpM?=
 =?iso-8859-1?Q?wNySNz95Yl6yMJ5/e/+xQxTqknmLM6NwEgLdlg4SHnT51HrlHa74ziYdsC?=
 =?iso-8859-1?Q?nlEE7D5JtjkRPH4ZuuQk1kom4dCs6V0OsJN/WGNnyIZDcXOKBGOheDbtin?=
 =?iso-8859-1?Q?k77L3wHCLBYXV9eL/EdBelWgJkk46P4rBQuf0o3JeL/7alAVXWZvORcep8?=
 =?iso-8859-1?Q?/LTP3r6NS2LBFXiXbWdpth8toF8FSlQdyQisPw7QsBbNicZYH61aQzo/A6?=
 =?iso-8859-1?Q?5U5mSzP/CD08T35vRTZJzLEm5vkPbWngB6ADw2AjDGtGVUpWi9glIm5HFm?=
 =?iso-8859-1?Q?mAk+F4xGS34gVWmYOh1OOR2CeR/y1RreW3JIPQ8e5sbvFJCbstB3GmNIxi?=
 =?iso-8859-1?Q?SL7+bg17tSGOb1oBOyx115MkD+34XLhDsVF5BVDxI3SomnubS7Fr7zDgaN?=
 =?iso-8859-1?Q?7F7BGqyUq+pKvWVqpTGo4IEs8OME4Ik6oqbuHPQwOKN4Dv/TMowXety4lp?=
 =?iso-8859-1?Q?Oax8j2ZqpzGxwU7Kb3aKSQWYtAkzr2q5X6Ng3aazYQ2rPNSfpmtUzMlQsa?=
 =?iso-8859-1?Q?UD5TIsQRB7m/jU9pE/vn2Da/+QRwNc0z+W52DDxUx3oMtuNiOVHBEWKSo9?=
 =?iso-8859-1?Q?Izsk/H9vtS65KBe4IrHtWAAkSJbK19VJPJrNIRgIDZdufxBWtPXPURsf9K?=
 =?iso-8859-1?Q?96CKXw06WueH+ed8Cjfd9TLFgzGUF3vtOo5XqidDwIqaS8L3JmqNNjKNyI?=
 =?iso-8859-1?Q?L75Ro00HvWHrVhscRS0mLmOuOjhXOCBHMelGh5dGVGKXJTdDOyQhoEqZd9?=
 =?iso-8859-1?Q?6UTPW/zAReQzCdr91ILYzHkLOADTJ89xZ5CH5NX2rC3XFMYBs+eTzz/ogy?=
 =?iso-8859-1?Q?XYILn2wbxk3CVQJUCsjqcCUcvKtuQEen00p+JXtlKonMowdndXcryUntz6?=
 =?iso-8859-1?Q?89DPkB8FSM/1cx+IY1wRAQhSxG6+Se/4oROXtOoU1L49hhy7RRjLUngZ7O?=
 =?iso-8859-1?Q?gtDBfZM9HhejJ0vMsHb9zfJ5gRyc3ThD6oF4ZYCuuz317KS78drT1FuPC+?=
 =?iso-8859-1?Q?Fb4VArN5iVQQlQbqKOzRkch90UwTtseFPH7IEDTHd9xAnhqomqOyxGJC8d?=
 =?iso-8859-1?Q?WZDM/6apiIUMNVPVrBQ10VEVUZzYgLNS/DXsfv3As7tMZ0DvVXEinyEKTO?=
 =?iso-8859-1?Q?s7fLqqCeLLtWbJxi37TwbmPT6Q7HXhgF4xWVbd5jjpPiAVwOXe2V7XSGxN?=
 =?iso-8859-1?Q?5y/re5w0imNTEICmYwaru2U86NQzki1/Z0OUBQdk3Gyoq3a19JyHarLWpv?=
 =?iso-8859-1?Q?mONCwxUqlXKECGrQSlKMyClIh8oLHhongIyWWaQzLBWKrtTHUOrvJGNCnF?=
 =?iso-8859-1?Q?g+i5cWRPmmlepC6HOFs4wgWdjN7amzC2CoaVcxd5o5NOq1FhOm2uC6mDmK?=
 =?iso-8859-1?Q?ipOcyARHeGvFVLSo39nU/7L4ZvrWIEoPFWd7fTxyjwAGlumrRSI7xDQkQT?=
 =?iso-8859-1?Q?ZIqp2+ScheCiLOFBu0iyBO+ccwiCCjHs2DGdzXNQWxFnOxLFn8jpcSFD+E?=
 =?iso-8859-1?Q?VOENC8NRZnQKRS4JovkyofcX2EesyMFpcvDtXK6EzUj3vSb++Z6HolStZG?=
 =?iso-8859-1?Q?j8A006IO4/WTCsLZUjQl8tJ48TMoJo0jWQOMkLfwSOXL1zBalDiM19JLbd?=
 =?iso-8859-1?Q?pU7BLJ7rKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77349176-78c9-4832-acad-08de783b032a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:36.2307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /liHXe59M+DPwfHMrbis88Kuyw8me9AHlzxlnXMBOINHbmwDV+Y8yVLJefBqdRxuUymZL97z+pWdxoFeOdhhu8kobDzphQ9wu1Q//UvUDFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
 .../aarch64/test_aspeed_ast2700a1.py          | 30 +++++++++----------=0A=
 1 file changed, 15 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index 61373ffe5b..1dfd79ed9d 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -78,13 +78,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A1 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+    ASSET_SDK_V1101_AST2700A1 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-image.tar.gz',=0A=
+            '859808828531a51931aad3b4e70b28143eebb3cde1838ba7d8e7a2b844c8a=
1ab')=0A=
 =0A=
-    ASSET_SDK_V1100_AST2700A1_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-dcscm-obmc.tar.gz',=0A=
-            '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd55=
87f')=0A=
+    ASSET_SDK_V1101_AST2700A1_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-dcscm-image.tar.gz',=0A=
+            'b23f955259b99b0d1e549919c0d4b17a6d1818637c4977e0007c2834be0e1=
d9c')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -147,38 +147,38 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-a1', 1)=0A=
+        self.start_ast2700_test('ast2700-a1-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-a1', 1)=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
+    def test_aarch64_ast2700a1_evb_ioexp_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1_DCSCM)=0A=
         self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-        self.start_ast2700_test('ast2700-a1-dcscm', 8)=0A=
+        self.start_ast2700_test('ast2700-a1-dcscm-image', 8)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1-dcscm', False)=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
-- =0A=
2.43.0=0A=

