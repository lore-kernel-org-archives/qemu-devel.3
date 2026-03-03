Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A71E67A70
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQ9-0004yi-53; Tue, 03 Mar 2026 01:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ6-0004wn-9E; Tue, 03 Mar 2026 01:39:50 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ4-0005rC-Qn; Tue, 03 Mar 2026 01:39:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPcKVr6xqNVD+5Hu+YuXQYwLYga7hnkzHTsro4K36O2rLw9/7Yb9LXOVFmAEOiNRtFlTU4ran7GnopU4ODXFOMchAExSRDQ1JDRHRDnvlU8Em00OjnKmafpAAXo76iF3253FP3GnMkCf5bnxQNpwNrrt1GjZuBjCTv0G/JW1ySudiRHWXl/JbyN2dzE8Rtyh890oFrV7rsiP7uc1+zIMRoM7PkaiCfns0t7m6z/IPKsyOr86WdfJ55T0S1gak/4iE5vY8IxW/+DFhIoosnqY4ZJ86Hu65EaPaHs8M7dC+ZMGFQqxpQoi2iuYU34EvuAhmAzhovGuYWAzPwnt4M7dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAQUjBS26j7cTRY6lEjyWiTM68fcueOkJ9SFtRRgSmU=;
 b=AeFJvfQfo0IxfHXKZYup3XOwHtH5X/T1CRCQ9vJllgLjzKIO4aow9tKOJSFSUfHPzyX3/5lOMytivG8CNsXPC9ZS9QFqSFV2Lk1yUlOzekOWZzy1yDZhl0NqB11mEC8kbLj5EkLAOOQwK7TC8x/63sQ8SKllKgxbLqKarlGiTGy3j8mhOTMrsyTEg95j0AXYllUdj5ICAc/WBEQUdEIW3iIYV7++JnaJYTyZaWCx2PKXr3KE31kVzls/aJidCkt+js/zNAcCg18VI6m63q1l7nDs/Vy3dEtKp76VPVNsdV3sfvAtbM88hfzbMjSqafbwzHIXG37DtrWMclQ8h+2zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAQUjBS26j7cTRY6lEjyWiTM68fcueOkJ9SFtRRgSmU=;
 b=TpfPQQXeAjafrDfa7/HbDJEUsSWkI+rV0VrKkPPMi7HuP6QwnQpGbV6YAT60oTAkWcXJXt3v5g96jPj6Yh0UfAEVTAv/5AzQQWjLkO2oCrOeUQOit5/qiaD+XPC1KYIAGQrwgx4brmW5qUw/mRU0r5RLJwxGn920WZfxWGxG3+6vPHbP4+narNAzXPlOeYD/dwB8OdTPkggA1t4hLJNv4oybODTneC0uDEpU3tLlcS36GFH7rgMItRQFb5hzNOHaE+WbFFPuiaiu8ZTBE9zI/7rHeR066ewYWqwEcJzsp3clheLc/t2blXr29X58iO1jLZa1puSdiJqZJOj5vme4Mw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 02/10] tests/functional/arm/test_aspeed_ast1060: Update
 test aspeed-zephyr-project v03.05
Thread-Topic: [PATCH v2 02/10] tests/functional/arm/test_aspeed_ast1060:
 Update test aspeed-zephyr-project v03.05
Thread-Index: AQHcqth/7ZZ4AH6iBEehxSL/DPK7ow==
Date: Tue, 3 Mar 2026 06:39:35 +0000
Message-ID: <20260303063930.2878300-3-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 05b8a747-eaf0-4836-5ec9-08de78efa2b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: UV9pv8dyv25l/gRuUa7qs4G0aYm16tNVLyj5S5jh9a1OBOaGxStiJq3Qn7Pp/bBQle2XPzJNfQyNtt6Gqs6ngzCgrgvfZKq3MlTSYAj0fBwJuiIfH4TulsHbDdf6xRzJSi7l+rOYSj20ViPxB3R3gFP9Ur4sjqIpqPMbZGFB9MmNpv7bNJkx9F0reUNcWuKoQd8bhriLRg+JU2fpO7so33p4T5Yp29zF0atbUVt/R1yq2ibMhnlECaSZJxvpL2czEB2YQs2yI0IbzzWQ6R21w91c5Znm/5wjbT4bpcNqIcPNgydeh7D1StLj9A/8he7MA5DW/DTxCRyNxuT94XuuFMzgtl5B/J0Vtiu9te8BBxLiXw5a/NjNVHlYJR31iYTXoZ+fxDJqPyWOqH3KaCJJ+XuuCZAHaNaG524mJvrcN48vyYBSRxNbWErTT7xIZeRMZbdmufoUMDZSyN4ncWzRP/zlEMucTAsEI8BT8VpLOdPm9p4JdNpG/J6qnLipW6wvSeHrwBL0Cpf0zcLePaOHtxo1x+rpyZDBeJQ+8ZT2azqTIMqMasEzI3WipQBsPwDeAupW1BicknH8HfP07xtclYjwjKqYwNRGla1OSV5bG6Y3BiiaMxNvw5Gm3CWUk3+Sp8v+C1XkJPlU5fw5TlwsPn7WUbsQa4F8KNBPOVovLj62LAubJKuS52E2unofvb8g0VaOMBkhL8eiBf4kVGYjv1WWS/0BUHZRTMw7j3GirGMEkquUniLaxOkS077KUm7lQekUP/n2Xp+ePDKHNe+U+MnarhlOu8elCa2m+BGP9n0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3fJ9x1MrL1jygbixgNLgMp/XHKNa8m/XOT6Qx38zFMqnYC8GFfzX4lwl3n?=
 =?iso-8859-1?Q?1yeLVwIWB2cluJafAApETtjsS823LFUYIJ2z4Kv9yASsOwHZFDcxZlYy7c?=
 =?iso-8859-1?Q?RRNQ5wmMCOu6JCDot/7NZGF+8cM+j6yOblfqnr0VbbLQYyCul1TBjuSr/a?=
 =?iso-8859-1?Q?oJlGGHJ024LcTJuZ8k4fibeq9C9AyymPp1FhLiQyOgG3eJL26mhHZ0CkYt?=
 =?iso-8859-1?Q?9htVPxQkV7TLqe7JR6+kz8/XVra642LAE9hq0Fi881p67AKZrDwuhxXmfD?=
 =?iso-8859-1?Q?N8iQRBtATIWBsmAEE3+1bQ8wYP3urVhxo4MLnT0frqXWv9VYb5QjoSAeSs?=
 =?iso-8859-1?Q?sXv7/JAnReAPR+WuIxSUhswv1gNWmomv/OTGLtAyB7Or6INDkZ0CpBIlxk?=
 =?iso-8859-1?Q?UddMZly3O2j25lRSeBKElxTZGP17ptk1B47DXsfonfjRG2Xl9CP3r5BjQF?=
 =?iso-8859-1?Q?FPD3ytJatiRXrAvLuQV4essC2zVa/jntZdEcVqj4UMf/N+7wGNMT1u8Us9?=
 =?iso-8859-1?Q?ahQ/Ad6QMQtv8x8dYyxZP9PAAPG6Whq7wVEbzdG/ahdUUApKN29QB+uV5x?=
 =?iso-8859-1?Q?kLbGh0bhjgAeE2uU9ZoDl2UcOjDzCrCn6eRedCzwQV6kS8duthU9Fb+9s6?=
 =?iso-8859-1?Q?ryDTQK0xiYI4EOiSHZwL13TDuTbhl8oqm7l2BlfMkHHdWBNORpPWvKoEDn?=
 =?iso-8859-1?Q?PW+rn/VMI8Xh29YGUFjxrNvJWME3cxEC5JeJHJFMZata/jUeyl4O4IQuoE?=
 =?iso-8859-1?Q?LI5nW5dVG127whBMmobrChbuan9UUsTbZPmEsK3KlakS0GWx3ek2GrJ+tR?=
 =?iso-8859-1?Q?ct6VFZvlB96MZuIdLZs2t8fo4rI9KDIgtagi7Ln5JtUT+aUZkWU3CzLINB?=
 =?iso-8859-1?Q?q5vJG2wGYoJFSIBi6xc+n6O0iBKAMsWHNBLan+aP/3mec0uhZEDTD85OpL?=
 =?iso-8859-1?Q?i+9XReZhQvMbZcG3o6hJ5/X6zthn2UBaORwd+4PtPYqL/CW+Gt/zompDsd?=
 =?iso-8859-1?Q?yp0xh/OHJI8FyUiROE4c9QlrLvXCBY9joQVG8pwOa/NbR3Ubv9jUyhOWp2?=
 =?iso-8859-1?Q?E2UoltGRdTfvRm8tRTijlG58Qody3LaJgmCjMzd81+odkByyGVKYCSfuGy?=
 =?iso-8859-1?Q?y4jeMpEuW48zfiwPsLKj3AsmhAwFZwmELPef3bfJj4h1AciXpwMeJY7s0i?=
 =?iso-8859-1?Q?en9wW5rVj4zml5Vf4Rw/q3k0hFfYBOCZIkdUsVBR7zy/fOLr1dpspqAKd3?=
 =?iso-8859-1?Q?yh4TXRbS/GdzgoRKnkEusxDiJvnCLAUL4uAUAji6YO2A83PP9ko+sNGfK1?=
 =?iso-8859-1?Q?Xpu7bPLpET82h80AfiDn9/i/cv3AcP6OOgadI881oNS+t9iNCIn57gmMLB?=
 =?iso-8859-1?Q?ybPTLqVM1HS060PaE9HJeI3d0jZN2NGxmq627X+dDzjbnuOJL+xyAagePn?=
 =?iso-8859-1?Q?uYwbsDC5YS4u2u+0sXdPXhOxph4zzFFwzQWiB3hmD+whuEfxrIdNJbILxv?=
 =?iso-8859-1?Q?NgX0PEZosvIqCg+Y9cizlbF/r8UAgzsPmtFcJR+Or36KPiZ4B1KKQ+Y8/o?=
 =?iso-8859-1?Q?uU3uXhpebiIdKaiUE3DCwh5Exn7HJWgi7DP+U7FRMYuAhMY6rM27rTai4H?=
 =?iso-8859-1?Q?QNLkHW1PHQ8Upfkv4oVaQgwQT2cKhn2B0rbrhHHIex78rTQGs6rl5KeL+v?=
 =?iso-8859-1?Q?DSLwTXNqsF4hOsPwx1PzyB6zOusSJhXI0kG7vaqmjoF5hp2Lj9SlZ83Mpk?=
 =?iso-8859-1?Q?sF94Nv0gm88MVp2cGStFVgLVd6aLWVagGiX3asajc80gU+yr75srhUqYRa?=
 =?iso-8859-1?Q?ZNYqb+Xjyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b8a747-eaf0-4836-5ec9-08de78efa2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:35.5169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FGh1aNGOf5tBf2ACrSMYI9eTHPhPZuB9BGGfyUwtnLOjeI94qKbE+pvYxBRuh2SxUjdCiQU+ckvuriKbirYPG2RzdnWlc8tlDLhALTK9iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------=0A=
 1 file changed, 7 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional=
/arm/test_aspeed_ast1060.py=0A=
index eccb4252d8..833cfb8272 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1060.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1060.py=0A=
@@ -11,18 +11,18 @@=0A=
 =0A=
 =0A=
 class AST1060Machine(AspeedTest):=0A=
-    ASSET_ASPEED_AST1060_PROT_3_04 =3D Asset(=0A=
+    ASSET_ASPEED_AST1060_PROT_3_05 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/aspeed-zephyr-project/releases/download/v03.04'=0A=
-         '/ast1060_prot_v03.04.tgz'),=0A=
-         'c0319df55f5b7a547efefc5a6ba374b881223d5fe1a776bfdd36f97fd1f31d50=
')=0A=
+         '/aspeed-zephyr-project/releases/download/v03.05'=0A=
+         '/ast1060_prot_v03.05.tgz'),=0A=
+         '63b36d7420290726ca80477de254474b7cb79539a42819bb1fe2665d598dadb5=
')=0A=
 =0A=
-    def test_arm_ast1060_prot_3_04(self):=0A=
+    def test_arm_ast1060_prot_3_05(self):=0A=
         self.set_machine('ast1060-evb')=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ASPEED_AST1060_PROT_3_04, member=3Dkernel_name)=0A=
+            self.ASSET_ASPEED_AST1060_PROT_3_05, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1060-evb")=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_04,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_05,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

