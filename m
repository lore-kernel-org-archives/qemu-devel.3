Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C9C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOb-0007iw-Ds; Tue, 22 Sep 2026 05:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOY-0007gn-00; Tue, 22 Sep 2026 05:02:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOW-0002C2-5j; Tue, 22 Sep 2026 05:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq4fHjzSNQ6l/p6UuzyDNm/WkEbwLbZo7zAQxxxYYetABQouFJzgQJfVjnnA2h/wpP2Vxja53mG5uOhgJJS6ZV3BW6X+OUJHTFSsV4cmwEhdIizY+BKd/at6LNf5l1XubR5o8foq8IJWH5XFkqPlOzzhCEfXK3mC8hnXjmb9ySro2zsQ3hnHFcEOvJ84rR6WHA9qv/niw+4xHB9p+p5RHPPCil+ofnaM9hKWWm1jSJbSVOAEv5z0BzVQZ7gq3R5Q1YNB9QrVynsnVd1w/2Do73C91qVnyY4QgBJVXZBc5eTcszMks5KUT2MR41PmUiij19ICgSr2hJFfzPv6VN2ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/x/oDfZOgXCh6jMRafjWduMNrsHyu4OG8lf9qexVfA=;
 b=J1H6Y1WpvKAZHpElxl5cuFnvLYAShuATx8qNuufN0Gy7XH1qdliSWnumuRYcBFvpcUerGaStTfU2pOix4d5UClB6M4M4xNayaXOkiVbpx77PoMSPl4t3OhmCMVoTxd2shH0O/dEo94ZAyBEQhpjr+ylIgMMqg9relSt/QUk7urEVeniV6ATG24VzsAy/6pGYGbPkvOWW9RN8OwCFOHdz54xXdblj+u5dJOp/W0pp09g6F5gRFlcnTLVIHM92+TaH6X/BeqRXOFzf/sRqPa2VpUkaJZAHdsbtDi7sWGeMTi31FgC3OGRmSgnDy65j6wv8pgHaVZoW+V7IIQUMucr7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/x/oDfZOgXCh6jMRafjWduMNrsHyu4OG8lf9qexVfA=;
 b=bmqPmRfyTAcc5tpU/gqOYJeGap6/h8r0Gp7J0AClb2boHuJe5Gjk8gb3/qMjwFXHBUC5XpFfFuutPmwa3bffUsyPQ53xMxUDoXFTAP9YoBl7sQyr3xsT1NdlwiJiLg6nKmf0bJ+Lo92qqOZwLHFIs4cP03e2ZRSAS3NbD1InQkJM69zXV7YwZvmc7LiCocTFF85zb70l4Foz+aENDiDTX8QaPj56GBLj+zr24q8eX3Dq154htERMkYSwr3HGbHItUXEoMlo7nQl+3NZvPOJhAbIM1EKCJBTZ391Rk6OsjgRbUqXHJunirO+w/WWFUAZTsmwdE+J0O089R+ir6JaCmA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 19/19] tests/functional/arm/test_aspeed_ast1030: Test the
 usbredir server transport
Thread-Topic: [PATCH v1 19/19] tests/functional/arm/test_aspeed_ast1030: Test
 the usbredir server transport
Thread-Index: AQHdSnESvaoOW9LDRE6jBve2Ld0n9Q==
Date: Tue, 22 Sep 2026 09:02:19 +0000
Message-ID: <20260922090154.1792077-20-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: babdb6e5-4e89-4d25-e244-08df1888350e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003|3023799007;
x-microsoft-antispam-message-info: 8ny58op4CZOCaQATWZoJqZXdBm/vopmifFPgsOFRoiWfkUfr47D3Tabb1df0vJZ/ifedpQ8IJyB5AtDMfBmmUO4xtus5QFfiLMe5VrX5RGgaaHQz/YQpDtDiAN/L2Pu5pqQVsq09v2VtQCg1/ZBBCM8XAqxkd4MbgYnYZMldk/1TgExJMAGhOW31aPtLizSYILFTAhPfmvgCSNeOEKUe7AuhAQxIrK/Ne24ZiQZzCges1kS4iBHGmaJXgWe+JXIUZ/2P1e39AcCdmOo7SkETIjvsyMJG7AnQ3RAtPpeQLVKdIV9tIR7JpVY/78NfEKOqi4en/jF83HtH/1eRXvTVMRzXdZ8ZzkVwy1Pm2Lb7SabNh63PIe8HB4Rr+whAt+cwGK0XUtRtXnrYFh4X1bZbfQjdoMAjNOPU4M9UmY90Cx9x+QbgvprR8jAtaB83vg0g6XsyPXIvFgjx9Twf6QQYakUaUE5SqYwVMgGepNyiowfXox2wYpGsF2s62wc3gh4uDQeDZUQUJ151kGmPZ0FdfUOHu2Fmrw5uoaVEgwhaHEpKZ3k35SeBpxIzWWA2Jhjnw4vO6fepr7D4Cs9fpKOAyC4x3FCSyPO9WBlqEExUbyhK4cqb8rr3rl7pNw9Btg673Cps0xDa/jPrJe3WG+3CfwgfP4A2fXgmbc9GfxqE3lSSu6YX6aIRONKeiVZi1q/T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gEVx1UuL2BLAjC+iLGaM7hcdg1wE+MM47lD0wFddrDO32bYnCkZctvy5pq?=
 =?iso-8859-1?Q?J/MFVeBFGw1N5UvKCak2Gon8A8tHB3l4p3r+FvraZGTL7PydAebipaOJbH?=
 =?iso-8859-1?Q?RCWfByE9ziNwhHXqISm1mxEMigvu7P1qOM3gS24t3LLXv6TEsfs2P8VpE6?=
 =?iso-8859-1?Q?5GkQsWvRM+4J1EDwMELGyT1jkfOLjFhC7w/GT5amihioxliXb5Y2LZ/Trt?=
 =?iso-8859-1?Q?SkHRaJ3sgiVlXYRgSaQT/FzLFUotr7AVPxfkPbfJWXoX7b75J7sRSobbwy?=
 =?iso-8859-1?Q?MyzDyyiRY75Ed5VirnletXV3EZZiqcovRpwlxygBBagf+fcs98qplJUOyL?=
 =?iso-8859-1?Q?mm8SDZXBnLxAe1cG3nmicib0NLwA1oMouHitLxsP1X1g0/0ThW7lq1hbHJ?=
 =?iso-8859-1?Q?LYSHIxeXOn02ZSVQ4IsvyiAPvxNB+EztHOC46EaAv45H5leM+KEqLvjz7m?=
 =?iso-8859-1?Q?WlPbl86+X7nAWloPlCuTExf7NH7FOdy78ugTjvvQw3tvevesqlDyMpnZzT?=
 =?iso-8859-1?Q?PzJ8LRqNUoKdGnRK3JsFqbn5EJcIm7eVNCsCoUF4+3xsU2nPvSMxIC8SdF?=
 =?iso-8859-1?Q?DxGweyY3I3t1dU+J1Fd0VuWjRIMTkfgIyih8XjtWa3He0wEf+9CIdO10Gp?=
 =?iso-8859-1?Q?TL75lov6kkeZqaiXIchU2hdSD7MTTWg+Ny22+XUqDjl7R73tQVZrEWNbU+?=
 =?iso-8859-1?Q?+Idwkv6/y8WCoL3jeudymXNPLH6itEWhUMtp/cuVJPQIb4ODSkgxd4rwKI?=
 =?iso-8859-1?Q?hGBMigIggqFGWbmt7Q8eM57GGBqEMTNAZJpb1y4/E3j6weFQRSGBRI0yP6?=
 =?iso-8859-1?Q?i60e3wqF+CKQlNxbnVASQDctK1VmApq1H5wBAATS6U/qx8h6nme/Nr3z88?=
 =?iso-8859-1?Q?NyQLdp95R30mDzOTqicObi4kHY/+YL7BDLlr3HKVGmAJR6mEMPluItJaek?=
 =?iso-8859-1?Q?64IcqcKBIyzfUcoz+EAyg5dfCz2lFYr4USLDJUMphyRBdIOFl6Y3XIrXCS?=
 =?iso-8859-1?Q?QBe6pPPOwXXN13HrRb1/T1LuLgPtPachvtxY5xSnxkLoVqYdp0fdV33nxX?=
 =?iso-8859-1?Q?+ctZ9j8kjJtMfBcOIfbhm5DFQ6JL9WCPB3PFr79jgLm/1TMMteUd8cVdy4?=
 =?iso-8859-1?Q?aGxF90PK9cJuZH1lPYgUNaxaakDxr8G6jPdbs+mMm7aReoAvp62cQfKqbf?=
 =?iso-8859-1?Q?uzRsrGUPmgsyiBuipDGfV+pCD2q1fYlSpaoOgwmkCarPNSwSUxh3pqudd5?=
 =?iso-8859-1?Q?Tn/dHcrGo8uD6LJiiiNWco6v+ehbP+01U3+P1hXm/1NcmRohEkleyKfyZr?=
 =?iso-8859-1?Q?6C/MK66stV10FjsZ27/tKQAP03XNnmItJmRratxlpmdgCEYjJ5rovhQOjY?=
 =?iso-8859-1?Q?SlMCV9y46yj6S9iVoNI6b0gk3hkq79lnZ2I7fclplSLfUdTP4s42DZwm2o?=
 =?iso-8859-1?Q?uQa14JyYvFBHgHHbu4NrzYDpHmIu+h6D9PvjvNhJzLQ7PoBq8y61bNlBYt?=
 =?iso-8859-1?Q?jliRIHBGkV0UmeRlANUMK67XKXCZxvRVhxjiq/UGjDyguF7JrDEXU3EjRQ?=
 =?iso-8859-1?Q?ULME0Ybs4nq6vgK2SHtGAM6yGH55bvyvY4z18VVakE7oRwCP28W7scIoQh?=
 =?iso-8859-1?Q?1uK0uQfV6OC6FyBahaLkmAkN5aTABSw3G3immKnGTrK9tqgUhYyJi49l/j?=
 =?iso-8859-1?Q?uia0J8B2A9QcrAbaVii1NlOcQzrQFXrW7DophjI4WVQwXUo99XVaram9dF?=
 =?iso-8859-1?Q?ED0D9Q0VF0pmgjWipeyoInFDLcUZ9A3DxV57SK7Yy4YqNnGjwiuu/up53U?=
 =?iso-8859-1?Q?yNjm2FxIOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t78XAvjAp9j3g26zjbS1PVViuFZ+/oI/ZwGYQVf0s+GBjrMcv8flNbQiX8mWzpollTIXQ0JfU84CedYqfQsmPFWCCNXXKmadzofLg1Eyg2EoyzNYUTeF44/fIEcdMsPv04Pv3o92vXd4B5rmkefqNb88qerYtNOZDq2exEdh1kDdGVkPendGUyrGkiJdolca3fEK/PqLhWRcuXyEyKdR9lpwUldI/PVFrG/Bthqe7hR0rSaqfMoms1jHEo5XeJK6VZLWLMqdPbqvKGBpyFekn05L8iYX9ilAtzTzJQirGT1ZFKmxXjnH7FRmlSMt5rAhmX6sKVylLwVNBgQQYLLZmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babdb6e5-4e89-4d25-e244-08df1888350e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:19.4343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuaN3kvOyX2MGk4fuDY2A3+btbbRcdVrCmia9wcPnrAKsgUK7nlxYLMGkqAN/xcGqMu17UK7UaTa2vSEAkbe5k/VobL2bFLsV8k21zLsDzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

Export the AST1030 UDC gadget with usb-redir-server and import it on an=0A=
AST2600 with usb-redir, then check that the AST2600 enumerates it. That=0A=
covers the announce, control and enumeration paths of the transport, and=0A=
the UDC model behind it.=0A=
=0A=
The two machines have to come from the same QEMU binary, because a=0A=
functional test gets only one. ast1030-evb and ast2600-evb are both in=0A=
qemu-system-arm.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/meson.build            |  1 +=0A=
 tests/functional/arm/test_aspeed_ast1030.py | 52 +++++++++++++++++++++=0A=
 2 files changed, 53 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.=
build=0A=
index 61b00932db..cfbd376b0d 100644=0A=
--- a/tests/functional/arm/meson.build=0A=
+++ b/tests/functional/arm/meson.build=0A=
@@ -1,6 +1,7 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
 test_arm_timeouts =3D {=0A=
+  'aspeed_ast1030' : 720,=0A=
   'aspeed_palmetto' : 120,=0A=
   'aspeed_romulus' : 120,=0A=
   'aspeed_witherspoon' : 120,=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 83a96ec322..d1d059c83e 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1030.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1030.py=0A=
@@ -6,6 +6,8 @@=0A=
 #=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
+import os=0A=
+=0A=
 from aspeed import AspeedTest=0A=
 from qemu_test import Asset, exec_command_and_wait_for_pattern=0A=
 =0A=
@@ -68,6 +70,56 @@ def test_arm_ast1030_zephyros_1_07(self):=0A=
                 'kernel uptime',=0A=
         ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")=
=0A=
 =0A=
+    ASSET_SDK_V1103_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2600-default-image.tar.gz',=0A=
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165'=
)=0A=
+=0A=
+    def test_arm_ast1030_usbredir_to_ast2600(self):=0A=
+        self.require_device('usb-redir-server')=0A=
+        self.require_device('usb-redir')=0A=
+        self.set_machine('ast2600-evb')=0A=
+        self.set_machine('ast1030-evb')=0A=
+=0A=
+        ast1030_kernel_file =3D self.archive_extract(=0A=
+            self.ASSET_ZEPHYR_3_08, member=3D"ast1030-evb-demo/zephyr.elf"=
)=0A=
+=0A=
+        ast2600_image_file =3D self.archive_extract(=0A=
+            self.ASSET_SDK_V1103_AST2600,=0A=
+            member=3D"ast2600-default-image/image-bmc")=0A=
+        sock =3D os.path.join(self.socket_dir().name, 'usbredir.sock')=0A=
+=0A=
+        udc =3D self.get_vm(name=3D'udc')=0A=
+        udc.set_console()=0A=
+        udc.add_args('-kernel', ast1030_kernel_file, '-nographic',=0A=
+                     '-chardev',=0A=
+                     f'socket,id=3Dusbredir0,path=3D{sock},server=3Don,wai=
t=3Doff',=0A=
+                     '-device',=0A=
+                     'usb-redir-server,id=3Dudcredir,chardev=3Dusbredir0',=
=0A=
+                     '-device', 'aspeed.udc-gadget,bus=3Dudcredir.0,'=0A=
+                                'udc=3D/machine/soc/udc')=0A=
+        udc.launch()=0A=
+        self.wait_for_console_pattern('Booting Zephyr OS', vm=3Dudc)=0A=
+        exec_command_and_wait_for_pattern(self, 'usb enable', 'uart:~$',=
=0A=
+                                          vm=3Dudc)=0A=
+=0A=
+        host =3D self.get_vm(name=3D'host')=0A=
+        host.set_machine('ast2600-evb')=0A=
+        host.set_console()=0A=
+        host.add_args('-drive',=0A=
+                      f'file=3D{ast2600_image_file},if=3Dmtd,format=3Draw'=
,=0A=
+                      '-snapshot',=0A=
+                      '-chardev', f'socket,id=3Dusbredir0,path=3D{sock}',=
=0A=
+                      '-device', 'usb-redir,chardev=3Dusbredir0,bus=3Dusb-=
bus.1')=0A=
+        host.launch()=0A=
+        self.wait_for_console_pattern('Starting kernel ...', vm=3Dhost)=0A=
+        self.wait_for_console_pattern('login:', vm=3Dhost)=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=3D=
host)=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc',=0A=
+                                          'root@ast2600-default:~#', vm=3D=
host)=0A=
+        exec_command_and_wait_for_pattern(self, 'lsusb',=0A=
+                                          'ZEPHYR Zephyr DFU sample',=0A=
+                                          vm=3Dhost)=0A=
+=0A=
     def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
-- =0A=
2.53.0=0A=

