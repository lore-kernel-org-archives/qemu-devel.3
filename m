Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F01C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAO5-00050R-3J; Tue, 04 Aug 2026 04:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANq-0004s5-Vl; Tue, 04 Aug 2026 04:20:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANp-0007YS-CW; Tue, 04 Aug 2026 04:20:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUrOw9KZJ65abh6Xf24tKGHcs5DvbxjUA+vh40DKABHtlrzM4/HmjMvSuftl8bdtP4x58ptMqhpZu9GqNB4svUcfg+j6xPOz3yDBVBqxQq6wsjgBUF0P0cBcTMsxWjHCVhGKcNNiTmLRTBzR5PsKqXA/bmjcM4GHihXUG9M5kx4owM8+p3dtmR5Fe1gLqYlnZG0P37Mh3gCzZi7MnFZa0Eb52lbbp9j/z7jwSIC2M3OetWimUf65C2BnJbSggadL9XtzKPtRXslLX5UyC1aY5pX5KFU6qtEx3hFip7Pw91PYnE2AykzcH89jRu1E+fYQPIRV1EYnWAZR4ef18Pms5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUq4I8Eu1l4QFIeXec3hgW8rDnwHqXZqFN2KUSuD2Zw=;
 b=uFZ3vZ1+dBCV0p6OtmCv2DggqFBZh2t9urskOb+pEWTUhwCtIzgOZ1DPF3IyDi+WZfr0RAEzHvZqoo2QQHNsr1Zrvk0lbeQWP4df4AXcVwo6r5KBJgika4VuHCqWLQGFWVzCVHOdWGrc7AwD5E4Tek+vj162dcy44CPr2MkFIjNJniL+jS/kmYhUKQs5T11eJz9uFJUpdhPIctUdQ2nOQwGT0iHhe0ZI+Yb3nlyRso5/mnjrL5gkJVoCRrhr2Vz+CTNUK3d2ighLjuF42feP21DXsDjFDwIfkYAJ4TTbp0/YpvYSOjpBbfUFeGIRiARaCc3SLbqNfZIgidTUxpzIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUq4I8Eu1l4QFIeXec3hgW8rDnwHqXZqFN2KUSuD2Zw=;
 b=n+SDCo06v3g67mqSRQVPlc/qCsNRZ6AoyGSUZk3Y5nj0lk3Lmwg8eKOYWKmDUjx56HulAXyu5Hp/h7wXeThItuSUuXAsnaV24t9jJe01mFrLpavhRnCiLccal4uE3mIZX/SihuZPKE3qAF3VTgCtmSkt9nPwi59aCJAx7R3cEaVslf2h3NtE6uM1OIg8lTa/Stle4DZEywuvDs/6qHnG05aUMwnpw7fZWOYXS12jE79FF2figP2VVpDYSdS3KdLZWu8qgB9fZUbxVPcOkI6s8lZxtvGtpIbaQUFBLCPFG+bjQAJzN2lU0XNmrTSEPv7fIJh5WZi/9j8fQxNCeA+w+w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by JH0PR06MB7014.apcprd06.prod.outlook.com (2603:1096:990:71::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 8/8] tests/functional/arm/test_aspeed_ast1060: Update
 ASPEED ZEPHYR PROJECT v03.07
Thread-Topic: [PATCH v1 8/8] tests/functional/arm/test_aspeed_ast1060: Update
 ASPEED ZEPHYR PROJECT v03.07
Thread-Index: AQHdI+oOEEH8DxZ/ukG/oV/r7eW93Q==
Date: Tue, 4 Aug 2026 08:20:06 +0000
Message-ID: <20260804081955.1563537-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 246bed81-dc7c-4756-afb0-08def201334b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ksU05EBLlpb9GoUUWijCrD21y0xYrY2pRK+zM/TW+VM7B/BJef01gey2DmqedqL2GctjVaY8phlP6IpuUHOLcwBkqsY3Otbe9mi+ZTXLWtIFhH1h5OQYOXaCuyxXZr30fY6lc4+Vb5aXP7Sci3Jr/RdIYnvxk86xXdJnXRkuRp2utuOH6dZ1IvezQfABu++YpXaasTcUOXnEe8xeKmTXGesg4WtVY8yvXtZ2Ey7N9oyYZ/CeyIoZt/UzAxcqX5FM7tIgvySrKdgf+25kEINjbH1C8X8CCTYPn4wLa3ikCV70/uejFSG+P2wafXAfkRsiHQbnHgRCoq1+89KLCoqwHiU8EEFK9tfexh+5fqO3D6+Sb0+ZcGTwqHkLHDW7MmqbvrbL6dyMqxCqMPm9PvR5Wyt/BLydNkIWpZeh4k5p7B8K+dsBXtOF1RcGcDp1z2P12lt9Z2pSLitr61K88grBaja9WoHZv7Ymc2TZfmz6PvUeLpB7yBqgWsfYpapLUAzc5yodB2kJXxN3nYzO4cEiPTt6aBQnb1yJDK2b9KDnbFbT039PTOY3N8GaorgFGYVlzzKrmxJC+arlhsKqfZZDOJa2nOlGZFo2DsQ4oaXj9BMC9Z6G/tWdGBGzIr+1MQZaBNvOA4YdzCxIxIHubzXqbwV84mhaPEG8ycJgQ1xrzEqhOR81ob2yOLchxCMVsxzm+za4V7tic5L1Bm+vzvV4HbL+D95szERO1n1JRt6C1tw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v5OFCk3VnDXVjYDGpAc12yjo5kPiNAhCRS66u39j2OpBRtofIqCHkuGdE1?=
 =?iso-8859-1?Q?A49yI9B+Eg3f1AwllxQlb6Tl6IqmH05R3IVKmczcsxWo+dneIs/SsJ7LiH?=
 =?iso-8859-1?Q?+EZUozFRhphooelYL3xq0OkE0pke2GURxCJTkRB9J0w3p4BtHgME4VqiEw?=
 =?iso-8859-1?Q?9xAEgjhHIOfPWqeldpSPU4iPwxgozmpkvPFV5PD37JN6AjX60MJFtIecRZ?=
 =?iso-8859-1?Q?WkcfTWROlA5TXryiXCSidnLVy7cMbq8299DHZQc4282tj2JkvB1wpUogid?=
 =?iso-8859-1?Q?1ePaKMqQr8bYSuZxQFIrK26cXswd3K4JejYkHV/TTcxOigc0qMtHCxXaS4?=
 =?iso-8859-1?Q?iPBRjDaV5/BZAgHkvuiFv1s3egnlWCMLB6SL7d8WpdKjFswteojFHihNta?=
 =?iso-8859-1?Q?tRFSGLFWbnxeBlC5EoH5lo6nORL7o29ewNFuIEpc1yggWahrGVXY2XFeEO?=
 =?iso-8859-1?Q?HySEz+sKMXkspXB8qTgZeigPSqVFqgMhdZpbJ3CbAfznsi4hvh3YB6ig84?=
 =?iso-8859-1?Q?JFVQxhHKHCDbGDsX3zAC1uTv4hScpatQiG5lmJT2LBu5kAKarIG3s5TDi3?=
 =?iso-8859-1?Q?3i2evDU6/U1iIV8LBtx3ZAlOsTIiA5DVXkLFLImltOZ/fdNzUsLrksUFyG?=
 =?iso-8859-1?Q?Ru/zuGphYTHEalBsJ2x8xNtaVYwFyItFgmbO4kPXXjXy8iQSNpHy4Ltk9e?=
 =?iso-8859-1?Q?GUgqI25C6b1ULOVIll5cJL4nl3dyeNmjpV+AfKE5MealqnFc5xqigGpspE?=
 =?iso-8859-1?Q?DGhiJT62603lGliHN6itVsHZdhcuAdnKU00ShAXOMlti3fagGCnEiNyNcK?=
 =?iso-8859-1?Q?N4a9uSbgxFyrZCYhXRY/7ZJkjy9xdLcu7zHBdOJooQ5RByCRgi72LEswl1?=
 =?iso-8859-1?Q?NZ9k7NweFt0tKG4rsARRDduw8uPaHj82soX+a95WW2kXnvV7Kd3TfUHb66?=
 =?iso-8859-1?Q?NMhB2KwzAWXtcXO9XfiPBE4dNeo8rfPyFKxG7wx4l6yhPWpR1Gwr3h2Pm+?=
 =?iso-8859-1?Q?JxMyCaziegtZSllaYFRAk3opmQLdr+HGkuRp895FhRH7dLHBLi09wpRz4/?=
 =?iso-8859-1?Q?NlLHoAe+qGzElz8HNXISkh5FRYV3X2xpIUhaBF0vbP4iS6XlK57ukjnlSH?=
 =?iso-8859-1?Q?mC91uQmgkAETPg/n1OljpGhEJMcP3T6NRmDoth2hWtTFbaEHF1ZP4dvmh6?=
 =?iso-8859-1?Q?qIrVxsyu9ir3L3K0et0J9bzAar91xuBFmVTVF9tSEZFfEzqbEwZ/C1o8Bg?=
 =?iso-8859-1?Q?Y0C66dRg24Oy+M76xBKwfX0CWRwVVzLl4CLsoqwNn0xjifOlQ/G2u3LkM2?=
 =?iso-8859-1?Q?8NV9fyerwpIs9RFCXZoU7pxrRwjK/tPC7f9c7NQdblIqOcYoyEqqQxjNAI?=
 =?iso-8859-1?Q?Or+YP2Udo1CzJlhB2KchDKnq0o90gsR5i/puEROndGNi1U5HsYV7Dw7XJz?=
 =?iso-8859-1?Q?E3goYMrHhd5VGaLO41A1JcrJAR0Z2PY178XQIYWUWG3Fjj7A2SPyZTSvPP?=
 =?iso-8859-1?Q?WZsVBpzTgHxnrfbOQlU9H1AS6BDykEC1QjNzprdvskiIRLoLSiMnVlpBz7?=
 =?iso-8859-1?Q?D9HxbI/bZ1RyV5w6u6jFLd3WaEEa/BdHaH/iGqGoYiJPzl9adVBZ8c8wF9?=
 =?iso-8859-1?Q?XdkQ2yAvsZv4YlT020OkIMaE+j8otyXNWLHxbPuym4MMKCus9xJo0IfzEw?=
 =?iso-8859-1?Q?vEFExwWsh+5u6MCi/yK1xlW8PiUQaEq9kRdXuMa7FdISBhyLqgBwV1r5pT?=
 =?iso-8859-1?Q?VtYoC5Q6ofx/jpjUlgz1Jl+hd0DaG7pPERID7TWFazjls1DWxTC3ydGUYs?=
 =?iso-8859-1?Q?FDD6g+RbRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MjaPP07Iq6Iii9/t3AI9rV3lNC44SVRHn4WLjX0tIv9uYQVipnxhX7ubzLDCMtvxWbGG4DaFqA/0MGg1pYWyU8erYD5104NuYSanW4sHhJXIf3HF2ePnBbenm5EV06P7S0mLh/6FKwTnZGAyGE13RK420A3LfDLYv/h36Mxtf1YQ3Qi4yq56Q+InZAzOzyDy4ctJJE7G5RCjy5PencINePVCWshZk6sJn7+M791YF4ryD1yMaz8Y4cwPUjKtoOShf+xKuKT1LXvo4uuFwk9fZfu/DXyzgLstMcMnbP827k95qV2RxqROaQyzehOTD8TADezXQndgHM+6ty6dRtqwjg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246bed81-dc7c-4756-afb0-08def201334b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:06.3772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLYx96ip8jXq1j9NLFZTVeP/heHsR3siJyiNh+d7V+nA9POWtb5u1q7V5bzABYk1+raW4ccvtsxydaLtK7WgSaTlZm3nWmDfvJRPxIfUvho=
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
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------=0A=
 1 file changed, 7 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional=
/arm/test_aspeed_ast1060.py=0A=
index 833cfb8272..d7158259e6 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1060.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1060.py=0A=
@@ -11,18 +11,18 @@=0A=
 =0A=
 =0A=
 class AST1060Machine(AspeedTest):=0A=
-    ASSET_ASPEED_AST1060_PROT_3_05 =3D Asset(=0A=
+    ASSET_ASPEED_AST1060_PROT_3_07 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/aspeed-zephyr-project/releases/download/v03.05'=0A=
-         '/ast1060_prot_v03.05.tgz'),=0A=
-         '63b36d7420290726ca80477de254474b7cb79539a42819bb1fe2665d598dadb5=
')=0A=
+         '/aspeed-zephyr-project/releases/download/v03.07'=0A=
+         '/ast1060_prot_v03.07.tgz'),=0A=
+         '55a7f51f0b77051a0ef2ada993a16c5033768e1b8e8be3babfc52c303eecd07f=
')=0A=
 =0A=
-    def test_arm_ast1060_prot_3_05(self):=0A=
+    def test_arm_ast1060_prot_3_07(self):=0A=
         self.set_machine('ast1060-evb')=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ASPEED_AST1060_PROT_3_05, member=3Dkernel_name)=0A=
+            self.ASSET_ASPEED_AST1060_PROT_3_07, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1060-evb")=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_05,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_07,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

