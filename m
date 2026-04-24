Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DABFB44C6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBZH-00061L-RY; Fri, 24 Apr 2026 04:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYV-0005dA-0s; Fri, 24 Apr 2026 04:06:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYR-0001kL-JL; Fri, 24 Apr 2026 04:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT5xGuIBSQ9ep71b5cQnRAdwgGrRNsx1urAqCQ/DLiQfuc00srBiijwYwPVg6tgx++OTCAOwEwyjNfEQhZXVR0xWuwrKNxRJiH5+NvEhER2f+pUp+wkxG6W+/XCear89lpcPqjBbtpmYNWN+PSOsy+5xMGOnyYdUv3M3yzBzn7bBnFRVysyaw2ERLOSwQrc2WtPuTMYx4sq+/xm6bwfH+A39XnlbdKiuQP05TyL0mNkFq+7/2nErv/SCkEoW7Ou/PGT9LkoVpK6UTVBoYLVr7xTj1WLuRI/GlrB3ttkoNBmW7r8tiUInZ4sK/n1VSbY6Y4fKkHCxrWu88plfBVYgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=N7YDuL6CvAyTHcPjyfl4FF+UMptk7HcHjXl7+ajZRjyyKF9rqNZif5N/jtguuBTNZRMxUwaA3NZ2YQ5dAA76XyuUoeGz/TxH9LM61ZyNiO4FnzuPwf4fnPWB5OIFHODgwwz8GX8Ehsl7cGnZDyoptBmQML+Y3afDb92tafO0pVLE2OXrcjRzPQXOPHI07xQI5u12RnqZNtz0S6HDdikC71TsXvi0NxlnYE0fgWw6xi39J+P1ddSB5uWaimKQe8u+riH0Z7Puegx1aOQVwe2sxrFUk3oWVEn93tMHn4xFCf7o0vXnzHas/kIq0McdL3hdT7fOnxDm+itzYYI/iOLMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=LloM3a/NYnBpAjK90TwQ+0cjVBW2hWGsE2DZqtglN13aqJioVUlAf5QkGwwyYKLdk5hAzpp1qz/P3uRDs+9jhplufgFIU7/0C1TKs2JfJfBOL4ecYRRIzF4QVo0eUMewvE9uTKDjulKzTAv75Y/v11VGuifWtRvxeQ7MNkszvBMY7EIgTxW+4qSvHkruy1/3zDYBQRhi4GmQ05Lu0sXWpksjIYrP7BKQ9Su+9Gh7AgxY1SJrgyfV7a39fxntmqnJoAHNZmyBmUljq3i6IXdlh1uKaqPDJAxfnGBPhqN9Qov3bPEcV9CkNKwDtOM45Ew4LpD7mbbhvFyNNl09xBZTuA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 18/18] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v5 18/18] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHc08Eginn3ZDFXyEanqc+WYbWdeA==
Date: Fri, 24 Apr 2026 08:05:33 +0000
Message-ID: <20260424080508.53992-19-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: ad3d6730-8782-4e1a-7810-08dea1d842ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 9zfpTmqjZgqu5R5MKEJT/Ut3E9UweZsWOpK4JTTdV4cfTW5kVcCw4Z0qpLuVuCwk/cXEu2ZpZeup1YcTtnBuqgun6Nl0fUDlR1OZzRhxO9cvQdLhwmAJsjRPxyZoJNC0unL7HPVVOFwzg3PsUG/MDCgBFu90kv3+kDx76hzBHGfKZJLrFYhkJlGerJEP3C0W/swWnpKvgKOcI8gqWmAg2d7csqRkeVV1rZLpYG88+cnYxetz0I2etE8rJXkvoFyrBGq1qUM3V1nmMkq4sdbA5o7jOnCt/EtsVjM58iYxCctop8MeDs7vJ5CNFVxgxXEGHaAeU50xoFpCcQrh1mO2GQ5VzNgI5vZBai1jyMkHoCPzL7V+IepW5m12G/hGtsZ+RmYZcw/twyEUxSVLRqCRLCVrGXaoCdBnTtsN5g6lZ+u+U6iaxnxlhpKZE9NIgHRu3EiOGwUUPGu4RI4QhH0g2B34W/u7PPpq2R0tV6+iqtDCryU1fS6dGbTjdJQCRKB6rkexOidxfA2GoRfA7lu0nzk+uJ7RLe2TROI9+J3aP7CBTixXRMjc4V784vG8F94RNKA4aUY69Ah76jOASbyd1ksCDam1mC+NrkSx+fkKBItJjhLX0AxNS92w/BX5F/AduFxUQUnBYSqSwlB4Gwrr0yVIB4Ari4I7WUzC14X1D90cFIqSXHmq33Y3F/uqix04n/eOCzrJz9Ws8t8lLSsgHZnbn+ccEBb0UIhWUzemYowIfmvnJUPGwwzGm0VaLlawOxYbxmRUDX/O3mx3iEB/SnLrsDHc0LwhmmSDlZ6G1jbmn57TtGKmuLsOj+ULfJxG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N1ynEwzBMgY2ieA3YBpS/MyO84R/mwOg2HdDOxcGrr60+LVsYlwEPweQDE?=
 =?iso-8859-1?Q?5YTB4YUT373nxukvYrVKPGRj6nIHEJudRfRvnNqNeWDqeOrl5KXpc63/q+?=
 =?iso-8859-1?Q?2xQyU97Kz7c5JnxazxBQZdxTc2wnPqd8OtescRik/z2HaSde7bLjWALgHo?=
 =?iso-8859-1?Q?RU73scwe74GyyZ8oAAnzJr/ybEynbdOEFjNYv2jB45Ef70wH+Cs7jqyJfX?=
 =?iso-8859-1?Q?waF80gHMBwiDnjmK+UcWfvQrw29GDTP/qt4raiFAvY5sq3OsCzVX3fYWPp?=
 =?iso-8859-1?Q?F4rvQvOi7hZ95lkHAC0mGPX8qWKykkCQ26CdSuEqIfdyX7+/jN1mz8ggiZ?=
 =?iso-8859-1?Q?yfT9mth0itvGEi17KiTJLyO2GHmHw/q/XdviuwsRzxvDn56axQj1XVdSAR?=
 =?iso-8859-1?Q?OdAh6Ws6gbBQAyfdAqk7xACI0SkMi01dLsVJWiMruTLbTeFY2ty/tk4jcY?=
 =?iso-8859-1?Q?rlcDzNpY+278iN9QsgexYpeRs8YmNJ37d2EU8ubeHrzGll3z/aOIvLG5Ha?=
 =?iso-8859-1?Q?7wE+pqzkAz3h6F3+2FyZpu5dout4M/2n2LGedwStc+xDwPEBKGnSPksCDM?=
 =?iso-8859-1?Q?Re7EVbwSfMUabqkPWxBH+cGCq3McgM0dBqXxzN3HUPhm8QckBIBBPRjRxi?=
 =?iso-8859-1?Q?PfRnhhNYFgj5Q+PFh+RBx5R0A+oRoiqFzOhkLGw9AUbqUSWlhwJeZo2p6u?=
 =?iso-8859-1?Q?6ncRVa3Sj8QszseHyYaqaY1BnDxp0IoDoJnZExRfLIhzVT6FpZggP/Qr+F?=
 =?iso-8859-1?Q?io1qjG6S4Y7mnQtIArP/QFtcu3UfUKZ6WFaz3c1HoPCzyubsi8T5VbVxVd?=
 =?iso-8859-1?Q?ncqv28FfxM+YFZ3MCEHgmTBQ3lITPeZq9AAh2o1mxdo9ArOofKbinltcaT?=
 =?iso-8859-1?Q?EoIJGRg+1vaUwjWyATckAzopMHRJfabwPW1FsozB3lk2puy2Y9WCX1a28S?=
 =?iso-8859-1?Q?nYVMQqqBLsTrnz4NiygeJ3Su07KS29S8Ecfqrt1Lu5J0fghe6XFCBh9Gc8?=
 =?iso-8859-1?Q?Ovi1BAsKf4bkvkOP/KWXMwEUYwIdl2ha36o1oLb7dJpkvHhMJ922ziF2Cb?=
 =?iso-8859-1?Q?l5pDTADyWe7Eagcu00EUc2aXbBC6VIljJ0GJVcDrY2i9HYFqgVXDn3AAne?=
 =?iso-8859-1?Q?x+2EWS7uq6keEprvXiNguJTmMzpUdbgKASZOD6tR9cnwyi92D6x6KJ+q8F?=
 =?iso-8859-1?Q?WFjguRjqeZntScs79XBpEa4EOASNtkFHMzjguYn1pazX/uHt3/WWOjKedb?=
 =?iso-8859-1?Q?cHTtKmK0YZU41eTmT1Nd3PJ9ogy49C0kg+Ff8+rlgRJakSZSx7CiQluENj?=
 =?iso-8859-1?Q?k5IJpbXXjbJBVHtrcZssb45TzNpVArXF2g+3cBkI2qoOX03lUlJHmNEJ3G?=
 =?iso-8859-1?Q?VtbYYHr6U1geH2vi3MPwx7aDigy4MKzbphyKWY77hDxAvIgnnUs0KplOGH?=
 =?iso-8859-1?Q?euDDeNcNThAOeCLxKR/l7cPQswJYR/qT/z4tIXHt2HDjJvu4kccTNm2eIz?=
 =?iso-8859-1?Q?rj82U9CBhCTwioCdYQI8+RMbvH3LDR6MeEAreNa/Xtl4ekI4a/YGJcz3//?=
 =?iso-8859-1?Q?sBE0hNnGhgy+xRHk5xc2CgR2w+UR1Ff5/wlB5kDAlO8q7XbcV7L97DlGSS?=
 =?iso-8859-1?Q?UFT+J3VhyfuoxvIfAU4l7rRu0l9CCwdWfHOeFjn2AkzA0vFfbU/MVVWq8c?=
 =?iso-8859-1?Q?Yh40LcMHlZh3+key6WxIipbhNz5gJuwGWdptuQddpT9A+nNPp/xYPUpaVQ?=
 =?iso-8859-1?Q?M8apA7nkvwMRmJUQzC9m2hBPqGMQdNAzWcy/DofrMmGEDJNTWD7kTpZZAI?=
 =?iso-8859-1?Q?OXXrl6/XcA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rj3iHxOC2xP5oLT2sXeWOVyZpEOF8SaTe47s/8AV7v8sj260kJN813bl0vywHi49FbaVDDZExEUdgXtTV4d0pLTiu93C2bigZQgQHIvRCfQSFH5HgL601M7oOC8//G9gS/iwh/QCYpWGN2X0u4JWYQCLdqJwaZZXmo30PTFG9L0txxddV605gKxM+CuQMUu6HMPEuQpdL25kwNmejSX6zJZjLvxDp+L661Gbloh2GB/Jf77QCjmUgOtqw16PXpdpiOnBsn//hDashOpWX6U83nZUGY0wPB1MnCGqOpR1Zj9QYNq5aBdpnZvqz7J+z9YzH/IXpEftTlSkTUNyEQVCHQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3d6730-8782-4e1a-7810-08dea1d842ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:33.7106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1+ksIcsqMB8zoDP95iseI8Eao8Vzk0EV5NthWepZp/61OhHtq5Mo85mTEMwZk95GSQufVm9Uxgo4sLZl4XQsc8MKaeVSt8cOtL08hsx+KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
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

Add a functional test to verify USB EHCI support on the AST2700 A2/A1=0A=
by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
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

