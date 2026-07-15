Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBDBC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNj-0003EB-R2; Tue, 14 Jul 2026 23:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNa-0003BP-M4; Tue, 14 Jul 2026 23:33:51 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNZ-0000rT-6l; Tue, 14 Jul 2026 23:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1bMXHtXNgQk26GNWXpC8Uw3cCCrRoMIzHvwryA21K3LPVymcpczynJJ0iTAWjAk/NMApWoOIXDDL40C9SvXV27ZI5NveMSIAJ/HvpkwMdNrakgtBZudmGqgCyZj1KOgl1j2ULVWy5mp9iJxYsz1q0p5HvtAFAsszv05AVeJvL6lqcGHwaLoCeR7lTCm3UdN65CgjUerbuc1vy9F9WUzkfySIB/ppkV4xrCRd/dUJF7hjGA35IPVY6EWQW5kLIBmyxxFeJcszdRtHx0vKxsH6eSqYOzugixMUQQm7ZhDKW/p5NXi66Lgp5U/sRmV19GOe+0IGgGJkioS3jyKRiVTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo/0X/sP7KOxrB3v8Kz0RC+hKyUFyDa2nND+3OsxO58=;
 b=x7YAcb7vYaNXYBtSDT/pn3r1sTkWN4oGpgy9pBQX8OBPElbnva9QRcFS/wQt2C1E3H+tK9P5iiXCTXsMzlJkiAtGmiX1+2/4nHQmwNZu1qVTjAV/L7LDgBCjhu2yLfRMf6nZXZzXE1oK3FfkWSeOKWvC4NBQnlLZWJAGefEAAsEwe2wqntZ0kEv+Az4b7NAYIgcMM9dVn5p3mojc/TDEkkBOUqtoJ1lPie6cbsASu3L0KJ8RIJANO1LqpnLNvLQgBYC/M6Qn/TtC/SPa2b2aFjPia+jFRWn5hSI6dBlEG0bxgDXZrFNUo5AT3rH6L9F/njD5CZxEr0ipXuItcNvX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo/0X/sP7KOxrB3v8Kz0RC+hKyUFyDa2nND+3OsxO58=;
 b=cj6GyZ3f4aCCw3PAne0ZHpyImZ7+CNmNrAEgTnKkjNCJbiulNp2cdISeD4FZ+JvrdGZ2HsZb2hgzcPUhfjg3xEXAJrdlxANej91zLeILKFx9HWz3aA9UTvCQGAXg0AHgNM4eA+uwLBJPkW5x6cchlySZHKtK9NPYfPT5kAqMOYs8uat6JTx+VtTy4+J2gbtg0F8X3UXxteuhyccG2SU3oUvvKfI1b1Zt4wgxgSEi+6Hb0eOnU1edzQ6C78RNbGE8y3vgOtN2o/GlqgAky4CnCtoX3HGIM0O9Vjz5RpH4Ta/IIZNXKu0glffy/V3gi1B9MxB56dUqkfREYlZ+xny2JA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8766.apcprd06.prod.outlook.com (2603:1096:405:3cd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 03:33:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 17/17] tests/functional/aarch64/test_aspeed_ast2700: Drop
 the AST2700 crypto self-test workaround
Thread-Topic: [PATCH v2 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Drop the AST2700 crypto self-test workaround
Thread-Index: AQHdFAq6wZOaw0LUaUCZCSfN5uAscQ==
Date: Wed, 15 Jul 2026 03:33:40 +0000
Message-ID: <20260715033311.1648424-18-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8766:EE_
x-ms-office365-filtering-correlation-id: 4f6e0ee2-a7c2-4fb5-faea-08dee221dd25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: EBvf/F1HsVwhpI0h3zNnIBiAeQCmz4FIXRPGGoppexXKN6pmKXt6IIRsyISqcEEZRNgAHpxvs6vPP5pZbwWcxnpRQTTf0CLNe6LXqkF+anidB2zQHr8jdeuOkXvmn16uh2Qaj25GCXdFFpooOPis17AwF1I5H6+n6f+V0liyuXcV18vVeqajdbrbPKtQQo1NNr2vd4FbZBr4bAPplhYc0/Kwx8TnM7KfW78KQJllsuDfYKiRThPko4UnJVs44hQ0QEPyXbiXew1GFVL4uTNcccw6E3p7pI3Va6lS8Ms+oHqeBBJDKU8zosK8BgEgtpaaT9HKsPlWwIw7pV6D62pd85GkyBZNTPKUAH51SxyX1ckP9Ol+NZvF8g6y6003kQvTqIV3xL1RnnxGhgHL3IQKvlLPM3klddzK2J7JSwF0vCj80fRl/rgBbXcQYIxg7g2/4C5dKDnIXWP/iCRY21O7CQw+eB9ZX6kcAsD0NtcNB3sDaikm0EMWjqOpDezIjkNHgLIm1zeykgrGIEN4JRDfIJ7htPS7rn+e0+Y4X5RW+P7MZvBeZbjpDOFGRv2+X/WW6hEBxh3zjDtLzLIJ6CqD9qs6ViDfUzAIiDHKthJSl4ehi7Cm9zHA6UeLDe/UUnlx6PEGvrBdPLBkaC9DNg+wRjN76GvR7Aewtitw87mX2Lu9X2/8c+XIPNbf830QZv5Qn/IQrQQvFwlf+/h/FE/oso+RiT8row3RAKAAIjFfG2Whhzezz80ObDkm1WK8HRzs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kt73Za2oWa/Kc0W8/abRl5gEA++rMSSaUt0AnpPBO4yNCCNB2yZuVaHiu1?=
 =?iso-8859-1?Q?ksecTX5TVP5E3myPPhIcvk8ZPwln8zM4as1TGtgjfUiho6dJ0AXAIBVmsL?=
 =?iso-8859-1?Q?8uEkZeLiMkBP9PYVxCteq6ohGilI/6F0sTp1URUc9T2aE6l+7kk4OLy+5s?=
 =?iso-8859-1?Q?//pfTQj6d0b5TvmR0hmWWiw94e4+Hdet8K3ECLtvVoEcWS1Q2ZUdUu/XcF?=
 =?iso-8859-1?Q?bFlNit//vNG0WZrXBJgH5L4gXkojPrvpU2PVvGwe0I21eVTttX5KQtAHmG?=
 =?iso-8859-1?Q?2zrs/pf2hm3BpUPjDB1c0FTEI0AXbYuyAoqAVND2RGo5akZzrcwmjUdFw/?=
 =?iso-8859-1?Q?OQncUE0kG9QzlhnBYiiEqKR5yF4cCtFpSh3IwZ8rWXUj5wjjmMoo0eSk8s?=
 =?iso-8859-1?Q?ZILTrjzYxBKI8mkfqqBY5nKTcA7SA3vFe89ycHt8ELbP33PMu3oGUO5sJF?=
 =?iso-8859-1?Q?/6oxy+fAkX6aiENX/SKuF61MH858gnzCa2vOIAtxUllbms+mzwkepsFLML?=
 =?iso-8859-1?Q?X67bFB8pQH2QncfTtK2Lc98f7qVWJv4oiZhlBflsI6noBXQSjsWkmtSWkd?=
 =?iso-8859-1?Q?bPeXNKCiomf1ZXd25VhPNp5RF4w547cTSYSXu544z5hXKEP4JzkVyQ3SbJ?=
 =?iso-8859-1?Q?EE5wg0RkXUHXx6x/Bedq1dOQBAMAguMDvYl09fftaWRNjWF45TvN9e4jnN?=
 =?iso-8859-1?Q?s0zYt92qYE2aFu2gDRDAkn5D38PViO7i9iG4Y/OadYRI+6CgtGMtYiqnit?=
 =?iso-8859-1?Q?MNIVQjAKLN8pC0VXMfpIxTs4UCozhO7rViXm9NhNTQze7TYdT4ezCllIR/?=
 =?iso-8859-1?Q?g5qpBvMuZhzBqW3wBbQiweHgbtzY1O80J68KO7D75KaogfvFi+mrxs4szM?=
 =?iso-8859-1?Q?2/zhx/+Hwlo5H/50GD/OkFj2yiYMAkwbJjN7xC9USPmxSWCVof4n2WWetr?=
 =?iso-8859-1?Q?r5VbCehhny5/EX869n0DKS5knCvW97Y+icCC4x0gQ/y8EqcxFXdGKkSzZJ?=
 =?iso-8859-1?Q?HuBNYIKRyjHOLNfnKWszVbuB/llozTbbO3o24GoiJ8IUuLf59b4zLWi88Y?=
 =?iso-8859-1?Q?V1Vsu7TSgnH+aWxfV7HlEXEBwbhYK1gS+TlhFo25XiCFHLtE9cSDxA9RH3?=
 =?iso-8859-1?Q?6nNAFuqx4xz5E9d8F0RZH2NOuxXhOmUgjtMiBeLF6MJtZg3YVdVXBvXwn1?=
 =?iso-8859-1?Q?suSLrEFT4Q54DrXCuIW9joVCWgnoyIhF9lGOYnOQPf2i1s7VPy9duEwD7z?=
 =?iso-8859-1?Q?D3oTt7Q5O5j9XUchsJ37HzFN8cc7tAa3v4AS+/P8wrndlPvJvswmeCxFuc?=
 =?iso-8859-1?Q?kr3L9YwZA5hXquckSte6KO5elCwPv+pPmF75Q4vzZPenu9o4SKZxlr+1np?=
 =?iso-8859-1?Q?w6g04Zp866yiYeOetkubKshTpapM6s8mu2pPZdPGgNrhmeW0X4lsx1TO+e?=
 =?iso-8859-1?Q?0z9uz6ZW5soqTyjdZ+ileRHGvzizDI1Mkx36WoRlmGNKTAej2eGFu0lFPu?=
 =?iso-8859-1?Q?jP+Gol/ncvfYAzlUzMBwbWR2qL+6UYkHzTR4tThpmW6EfSuOzFTwARYP97?=
 =?iso-8859-1?Q?m1nMO4fO/kOvJk6hA7GRXM/uwMgV1jBARA4gsxXmMEV5vrTQ1a48OHeh1n?=
 =?iso-8859-1?Q?Wi24WZimy/dDwXyEGJ8habhkNqUUztolfPjAE8HK9CHu10T09WGkIsmQfz?=
 =?iso-8859-1?Q?4WSA/ZIHc66UOfAIhCeVbdS3cbg668a0/04UQoxDyfYLXrcmMIjdIkYi6s?=
 =?iso-8859-1?Q?SyFOdesfS47smCRVlLhSRunIGcpFgoQNSC0GBS/RCLy66dM1ymfNSJs/bd?=
 =?iso-8859-1?Q?xNL0Q9gvow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IeZs3+AtBPdf63yccNhNLIw8x2WnSfYUuWuGbxlnDxF4ZZR+FONeeMRY93mcYbjDyhGfR5lSBaV97qzFByuwUALaoEbJE1NP/zOyT88F8OZdd752bvydcYatGj3Xm/ATYQlQKBHtE9f3X6KfEcBG9pUJ8/3PTKyZQGF+WVerI26L66rmEHqNrvCbyJJUaHv8/Wl1CwECUR+CB5iFmLmy65Gf2zRqryCWv5blvILjdIXmpvYG2tX/K0/kkYPoqzmfWqupz1Gzw42P7UOdYcHVnQHRPKG7xmfgN/JSpLXH1hmQ8X7TkbpVnLpdqgJa3/VC5hOXCtiGuDoumiTdc4pMFQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6e0ee2-a7c2-4fb5-faea-08dee221dd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:40.4196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNGfSmBf/sjsHUndvxpYToQz5C4pwOMFDIBdfmqnGURJWBGAZyvWiwv7bvFi+/9zCHcKnx9VeulUg6U79+7K+U1F2pHBpNutW6G4Tb5El3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8766
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

The AST2700 boot tests appended 'cryptomgr.notests=3D1' to the kernel=0A=
command line to skip the Linux crypto manager self-tests.=0A=
=0A=
Now that the HACE crypto engine emulates the crypto command, the=0A=
self-tests pass, so drop the workaround and let them run. This also=0A=
exercises the HACE crypto emulation during the functional boot tests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 5 -----=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 5 -----=0A=
 tests/functional/aarch64/test_aspeed_ast2700fc.py | 5 -----=0A=
 3 files changed, 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index b0c08854da..bc535449b5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=
=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
         else:=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index ed414999f4..5aea0a9dd0 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=
=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
         else:=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index df889134ed..1648fa9dba 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -27,10 +27,6 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -47,7 +43,6 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
-- =0A=
2.43.0=0A=

