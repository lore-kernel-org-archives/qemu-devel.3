Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78167C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAO8-00055N-KQ; Tue, 04 Aug 2026 04:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANo-0004rc-58; Tue, 04 Aug 2026 04:20:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANl-0007YS-OR; Tue, 04 Aug 2026 04:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjkIjGqbmH/K1eQ/omLn06lecZy+UGCxICWv5TnWOg16IyAQdCra10VsrtZxWpDJS0D/iwIRVyJeB4JCTdSKApJpKLbAnawUsEBQIA1YnkrgpZC0yvJw5vKLHBo6dp0t6QDNEGTrfZ+9m6RWhoSVHO1odEWbg3xZcN8kKCu06QyvIv6POs4siT6zsUpux3o3VvxjEJijGC6EePL5kL0AkoOfS1/dwdYFElQLbjmKkNPDfnSiCpmkYu0YJzLZKYA1wVnzLpGHkfuAFesjRjzVZGQ0j28oX1X5W4Fd9SDuzieQ+OOBAQSb1DGo1NZODir1fS5jq/KshsX8bln/Y1NWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRXmFD5vtpq5V6+bD4ElCKkYelikBEYvMNuYwNUuZ5k=;
 b=oBHEJHAjP4zJoWtdfKmmhniI+MrJ5suQrg0ZgwA0LrcwNDm85mmm1XVk8EheeV81Yxa9VHGVtOsvt5Y0oixZfihufhWzx1JJu+g9dACOS8ErBtSm5s+mUgueCRrIlHf+gWiLj20qKPcQKgUgHRycexbG2+7Di383GQAgehAPtBH2iFvciSszvgUhhmX0p4ZKtyvJB/miKAKpZ8ojV9NAznQP+SOFKkQylak2lEKJXKnoGgvMh21SCY9aEyhJ2gk+G4XtMtJrTX4YwkuAVpA+KoZesqk6iBW85yZlGj5ojJB76hpkdGS0w2N8cDOYcZlEDka5RlUwksI6WAG5zfGA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRXmFD5vtpq5V6+bD4ElCKkYelikBEYvMNuYwNUuZ5k=;
 b=rroMwt9wE18niwDy+EOkcJLQmUR/NYWqXFOHmwgfv9asqq6pbDOQdPqvRl/58FjgvhPAbI8AmOaQ0xUcrnmiDTWoml3AOsPajPjxERwFV9L56oKfOKFgIkF6K/fYgIb5takbxd2H/oSnJXU16F5khKmctum1AEHeYvqe12X+BQAM/5BcSM5YQqBPfRjSXkkIBSiBTGSnRTK+JKezQR5T6Wt0sCQAtL5lkJuvFLwLHbSro2Cg6KjVA+IjUqbHztUZWrN4nVaUWQMU9i11G61qalFyOtVrrXJ4ZuOu/G2SoymZWYycInLyqzP6s5N+/15KIYVPzSsRvF/SHqEat3+F1g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by JH0PR06MB7014.apcprd06.prod.outlook.com (2603:1096:990:71::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 7/8] tests/functional/arm/test_aspeed_ast1030: Update
 ASPEED Zephyr SDK v03.08
Thread-Topic: [PATCH v1 7/8] tests/functional/arm/test_aspeed_ast1030: Update
 ASPEED Zephyr SDK v03.08
Thread-Index: AQHdI+oNUMFKL1SUCEaIFu3/OZtUgw==
Date: Tue, 4 Aug 2026 08:20:05 +0000
Message-ID: <20260804081955.1563537-8-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|JH0PR06MB7014:EE_
x-ms-office365-filtering-correlation-id: 8b6b371f-f2e4-4660-6a16-08def2013045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dW8TyC10IiBrDYxyvraBf1bVnP9vXH6J5FEOuspxtY8SZITkk7PKdQ0AA8tjwadjHPU4cTu5z/o2fqoTEqjw2+Ni03JEeo4BQt9xPMIf0hwtQaG8OmZ/HkJrM3SKB4uhHFbhhFBLmn3dFIXpRl0ZYWB9zU7pWhiL9xR+5GrhbS6Ouopwaagvax2sw1wUgN1jGpQhSgmyOVeDFJz3ag/UQ8aWMPIMYMuxldK7FKyCbXV24NB2AjJt24tKLfXHbEWNanhYoP7Wat59WjNThWPMPIlwWnom7yG6U0ieskKkuHfyuMjwK//FOFandU+AXzVaFpAXPKQCRA0p7ycW5tPYht/RTz08wueNWzjyrYqrzXlaTW/w1W0UdIwpIzkEqWvMFHxlnlIAd8sFJu5zf1Ld21K/B03qeO0czbKIwIyXXpozSPp2dxqdKQn4VraaU7r0xjItd0YxBRnuKecNXojY+CII6DbAOyrUdOxwEFFke88kdovvQo7dQks6pKp6nisv8KMs9wRj7FsWCyOcEuscuojr2jB7lH4WjHfzBEUkdems0exNNC84clYil6Q0yQH9Ewy6x8rVBKR5MjZg4MyY1hv6taj+Ojv7FcmCQgxLIXqnLSGk45YfDJ8o7uIvDgMFQP74uYUcerDDVBM8s7fd/ZWzPhr6wndufCbDSRQt04Mx3O/a6TJr2EDidJ4lj+Sr2j+2j4vzluAAZ8NVkNYS3ZDch56fZtz/KIUahc8aE8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TWcc/hXvumzU9eXdf14ZOq9ClWud3RSP3Swa7OUFb8DaD1wsWM8mHkxT4n?=
 =?iso-8859-1?Q?kQFS1dfcG6xJlHnQu+iVUTWdKWKELnr74yRZtFw4UK7tHOPhDPzzO4q/90?=
 =?iso-8859-1?Q?Qd9mKBGYUezU2lTWpnQ0fUvMg65FVOlDzj//Sl2lgUZJWx7HAydkCwLvM6?=
 =?iso-8859-1?Q?FxR5/bXs5ZosLf8mhSr70UbdJEL5rcmu+ZeivzjUZfPWjL99osmErSxAHe?=
 =?iso-8859-1?Q?IU5qB9NpXC/GQ+5FlMgvCaryiV+VZxwYq11vqbwD9NKuOj7gRKZ8SaDgXS?=
 =?iso-8859-1?Q?4ffDz8SdSedFAGBHcGl2SoaY6+qtZix5eXpD6BCg8sT7y/22Xcy1f7cYPM?=
 =?iso-8859-1?Q?ErQMiPKiJBLhnS1zWryAlKtENmeNyXQkuvxeDHzKVMmuS6gYDAP+cMzo/q?=
 =?iso-8859-1?Q?JbJepF2dBEcfuU2Mk9Ph9ItHtCQykEdYOvreyt5OrR1BjXYYXkPHQSKvGM?=
 =?iso-8859-1?Q?QBpc7NfIsJnqCrnYgrY6eN4rKE4ym/Zl65qcHmYvEELEPuW5BKuPSnIbh8?=
 =?iso-8859-1?Q?4XlJ05lKa7mUgURvaT3J5qwm3zDR1s+P2gffIieTZ6CbxKjt+p4Q8gTX7a?=
 =?iso-8859-1?Q?/y6WAU0nh9MY2c7sHkt9rCGXyAiCBbgM52mancg15AI76RWUnYjEeHTz+M?=
 =?iso-8859-1?Q?FQfoQRIPTsnMkUywhSCny7PZg/h1UdqoQ/az6Ky1MbiIvJ1555tDLLefWt?=
 =?iso-8859-1?Q?b9p1fNdx0lASteMKf9rumo1FLLt4eT+swBn5OmHtQCEB2/gBs9zVfM63lQ?=
 =?iso-8859-1?Q?EKMp06GcZbfapR/80sUwtHGzcLiX85xmdtnQ312oWAmXEx5g/DdYHelqKA?=
 =?iso-8859-1?Q?BbSmjHd246hT8BjPGZXysdg5eENHi3RawGnow2M6EHfTGgfOquLuvbJYvJ?=
 =?iso-8859-1?Q?SWS+Pjmj3i9tGcsQMHemKwsLNB/BXwyxGnIU6sKqkUCGBLVQOiPzScyfmf?=
 =?iso-8859-1?Q?1pwymBeDjOrkURvj65GMg10YuStVa1gRcFwlrOTuvA7CldPb4raaTLSbv8?=
 =?iso-8859-1?Q?yMbIeqwORfOgeWx9UREoX1bwcaim+U112TNI7M83dVy1vVWT0ql+iv3sy+?=
 =?iso-8859-1?Q?sL7KpfwIAZiHp/3WJsEWkINXOYrHWo4Pn1p8BKTiS6nJVbWPCpeGGiIPPP?=
 =?iso-8859-1?Q?q95yGkaq3mo44I8x+s1ST/H1yIBxqV2kPYyo0xk6DXV1HASZRikaMR3Ia9?=
 =?iso-8859-1?Q?S+hXGYy9IWS+LUteEIeXvFm9yDe4JC5xUudt1Cbwbq10O20SgV2n43fFbq?=
 =?iso-8859-1?Q?/HjSVRt+4BcTCuZ+RyvsUk/9OnhfvnCgHvmeD6HtWFt5WIvuSr0PaRhDs8?=
 =?iso-8859-1?Q?SXwiErXKzJmrr6f3Nacdkpn4w/XTMBXFFcOuXTuPa25IRup4bq8RBAd+N1?=
 =?iso-8859-1?Q?800X3Zy/CdAT3kqyuq2RX2QgX27pWjy9FKh3VXkgYOQ7ASSJZrst76cpKT?=
 =?iso-8859-1?Q?6aeM5ZJim1KbMt4U9w+O5VT9uID4+1pu1nT6CYh/5/R0+e42ilefKC+s3c?=
 =?iso-8859-1?Q?qiI/zalKSgqAPwJde0hkF5Dc9wSt6XnkI/agsAvxnRiaFhFdFr4YRDfs8X?=
 =?iso-8859-1?Q?SejMulKJfarV3tU4cRu1uxhSDcmtBQ2EIvLf76/H1Hj0attL7IJDBy7c0R?=
 =?iso-8859-1?Q?/WoFb/Lf1DbblCf0/uYMUXCKoi8pUAZrduDrtFeAQ4ehJypGMN4dHfy5sO?=
 =?iso-8859-1?Q?jX+8qxb+tAXMGbl4fl4visgOJtooq4jo8g2xcxYXFgjcbKOPDYuoX3tJtD?=
 =?iso-8859-1?Q?T/BGjV4X+ts4kUyQgabRkpqPDLp44oJXGWdsylkwhu4XPUW13puol4DdxQ?=
 =?iso-8859-1?Q?au2yzKi6lw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d6pPXOxpM8Zj/uG8FPS7mykOWsmIQewtXDzK0Pdd0d8TAtPi79aDrtIa/ZaMN0n25LsV4wZk6lDw2R8oX4bI4etc0D25Tm8PQjsd4DZXpLlItPCRND1YuVJUqOTW4Fit5VkvINPj0fmGZ6CuADDgGz2U35MgOamLbmqFOln97RB5lTxtZZ6sWpRg8h67AfMDWOaxxQrS1m6ihi6jU14PY6MD5Z5CnP7mP5a1m0zx85mbuMrLT46SS1sXkqZdLdHlu/TZDKylDybzhqVXQ3/dSMWB4FMiUsZbIwUuwcDjm07FjXmnU6WttneYThh6yiOP3xbs5nmr4iy9PfxDy0fJDA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6b371f-f2e4-4660-6a16-08def2013045
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:05.1747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PrPOfZupwnaeVmn7Z2HsIUdDHNEYcbP7jXmO3hkYp0ipXKcgYdRCaBXJ3s3+LuZ2t8Q3nGbvVstm4qBIPhBrzuVXgHUW8PDyseslhklaDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7014
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1030.py | 12 ++++++------=0A=
 1 file changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 03fee55b5f..83a96ec322 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1030.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1030.py=0A=
@@ -12,17 +12,17 @@=0A=
 =0A=
 class AST1030Machine(AspeedTest):=0A=
 =0A=
-    ASSET_ZEPHYR_3_06 =3D Asset(=0A=
+    ASSET_ZEPHYR_3_08 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/zephyr/releases/download/v00.03.06/ast1030-evb-demo.zip'),=0A=
-         '056f37fcd9f165308cedca3a08f2bed37ed40c0a1402c4fa515613b80a369f38=
')=0A=
+         '/zephyr/releases/download/v00.03.08/ast1030-evb-demo.zip'),=0A=
+         '9eac3691bc7bce1b912bbe2ae4e36608a6532ff8d607f4d1e44b88407a48d4e5=
')=0A=
 =0A=
-    def test_arm_ast1030_zephyros_3_06(self):=0A=
+    def test_arm_ast1030_zephyros_3_08(self):=0A=
         self.set_machine('ast1030-evb')=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ZEPHYR_3_06, member=3Dkernel_name)=0A=
+            self.ASSET_ZEPHYR_3_08, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -72,7 +72,7 @@ def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_06,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_08,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

