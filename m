Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE0BF46C54
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mDF-0005fr-Gi; Mon, 06 Apr 2026 11:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mDD-0005et-Lj; Mon, 06 Apr 2026 11:50:03 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mDB-00021U-Tf; Mon, 06 Apr 2026 11:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYJU/wd5fSZRdGfmLSaW/yu8TKTjfvyr5fZfRZO/zB7iJ+sJqCittVbfmXKW4IaRDxaQsu2tUcTiNOv5zQ03R425Ge2lyrH2DpIEsbkgjr+jHpTfwRJbisHPZgVDJ1Ge6XYJXEYQS4OlEKeE13iw4CVo+6e4pa6pF/03CL0UY9DaUmf8I/DzjZTvyM32kLOEuCV84FJpD4dAnIcojEJsWlOSv8ZTuICS4X1//uuRYd3LpQk2ZZM4kq4MYYrs7w8QHcQFkMQk/cyhkmedq7w46HKQxIjgsQ4lj+TcX3ABeeOZqgknGfLAQOtK1ExaN6BQjMVhAZGStQv9z8RrtBpIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8RCiRCN9qIN9MxuTsL1AqvgLxWkKHPm0sWQZ4MLQVY=;
 b=fEeTa66fxSAiHJuXprkuCVVjRTqY/9qgk3jD3M6YFsASzidQ73sA0dC+wYZMW4e62l6gVCOtkpPmagvM7N1Jyv/3Hb1q8i1fQaybuo0sQaqODrvVuuOnORZlfzmGL29XBfaU/d0z/79xdlRQiCKoSdjdKwYgjrILk2UrAK+2IIC1mjwsMBspl5aLbxLmjSz+UCmRbJEom57Nc6dcF6q6fhaVN7fP1IFSvkS0otUyAHhm3aspdxXQdaONlR9XkJ9Z3OSfHEuZhNj2b45ToAuMjcAdunNVWBd8uL4quqYZffHZ8UWQLBg3Ewb4/hijb8j9qV4icvnftgppvjYkRab/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8RCiRCN9qIN9MxuTsL1AqvgLxWkKHPm0sWQZ4MLQVY=;
 b=lwY+kZjYoCcHKdgag8vVVzaK0u+/cHA54cSiy5fuPhcZcOmfSSWjriqxWqrSHYYntRA2rU4mgieY8ZzEHYVK2zHB2cyyDzKR6/bEcS1/Up/Qd1otMBm4I7b/ed7NZ3GqMkG8QpZv1PRO3pmFONg0BZBSJpwyXWdDN2WoznL4Zd/N0aO00Fmh/U9m+uKX2sdMptOjRL3jv4ati1YYeS2oroNqTGOS8+5V97vGRYLc72Hbv4LAO9c3BtA35u7CS4DYFFx8Va1cw3Kf3ff7R8SpmJBVYjeOtgXHqSJ4tWx0exFQZoRirBZET/N5gm12jqIS17zcoNRrCEYAGChwXz5k3w==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:43 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 7/7] target/riscv: Add test for RISC-V BE
Thread-Topic: [PATCH v6 7/7] target/riscv: Add test for RISC-V BE
Thread-Index: AQHcxdz8KefIOhZRcEG13lsP3GIgKA==
Date: Mon, 6 Apr 2026 15:49:43 +0000
Message-ID: <20260406154935.144674-8-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: d743d4e7-e976-4e34-419f-08de93f41f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: vFkzguuLJUyMUhOuaAntEnV02ZMLqbnbOVVDnaJM8ROudw0wEe9fRPwO+z+wtywqifffh1vN8xKn5GHbmiXTN7oMVvnzDq/SVZgjiXwLj43VouEevgc0TNTGXY4XMi8QVidhXDl8MDd2qlf92rkE90CjveaZ2wpeFdv0hLvHHiKl3y3upsFdFa93aGjC95RIo2xEiNI909qL+k+gL7HyOA2uIbYM+NtDwXb51182/rRFVn7TgwAaZ10STkYI9MxXPTCT073f4JyQ27Nw3Nukcb2AvzOwvox9FtbEquZIAP93fLwAoltv13Nf/NeHrqW/0uvMa/T27tJdrt0nQVYBksNY9NcE1kmJRWiB+UCsHWZxwdjqTrFTNcDK/CKr+W3j2TVQeLr30fEWz9wHgsCYUa3vv/YdZzl//1PGsaPi3vz8CkCtCyDZ5byHLzP/TOfTq1kpYMk5Nhgphb82I2y8LMgM5UU/kL/86dQis8lWikkRyu8EJ/KaKm5pM0VWij1QqwKXczOImSPnjrYQIPrLbY9cQXJi2AFtkC+7X2j5tXSdIxl2a7ZVY8oJNPIrpgWoenjqJSmg+HSQVjPxbLmPN8g1WAiEr8SA+tk871dFDcOCqVxfDWrheP0E1ZRR3baCrT0MaJONEkZRjTkT+VTQvfdLd/V0dtj0Y5qKYuOiuT3rrt2kF9aY8IrWYI+xQwGnqWV3S2mHn43WoF1GOM8PESeG83CYYryBf3qysH1jwKlODG/9QNR/RlARQ/QfjvRdBxAb3exTeeyyx7N81zBuBL9fBO6bh64yZHgkHzv1zG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fsgx04LHZTXtDjomuLC1QeV+zUFQHPwny8ap//AzqDdQOwPpMPkzUGriTN?=
 =?iso-8859-1?Q?26iliN5njPfe2KDW2orYlxaclhdipUv9JUh6xpW6sGoMT/SQ84bg74T29S?=
 =?iso-8859-1?Q?4jEPnkRSJ8rq3peg1CtwwjXjHwTYxmnLOm6TprU/uzI/AP31fYBWqLFyRE?=
 =?iso-8859-1?Q?J8C/IFw4E/vsvsRZ9tfRgHw8zKJGx0QTIBput5PlEBHmN9hDaRBGUKxg/L?=
 =?iso-8859-1?Q?15i3zBLF4XzhpdhFRdcoqAuipv3Lg4tnbpZp5xoHoiId+kINfrNUerzyo1?=
 =?iso-8859-1?Q?5tOzqGCtYLXBCcCAIhSKq5Guxb8/DJ9fJvPmmX3SbKU7gWwqBjDNJG++z3?=
 =?iso-8859-1?Q?Goj7qC0ctvkXPJ8SyqrBDPJ77pZ5PRP+aPefn637GOW31ZDvSLwb4BngAR?=
 =?iso-8859-1?Q?6dOtI4/QEuvcM2wQWpKUcryqt8vSiWW8RNKTTruv3ltUVMJmBBRpBhbHvq?=
 =?iso-8859-1?Q?rh/HUiB5pm9yRQxWRKKbTF05lKbMTs9eXCK+OG+53DIHKXvx3ZQi/Oealw?=
 =?iso-8859-1?Q?DaTDEABjrUhj9vvMvFMrx688tje+rfkn4L13ZSfhXi0RCAzQGUYx3H/XMa?=
 =?iso-8859-1?Q?9d6/HfL8TOVpquCbdvd8artOXqn0yQ9nbPT7igrmSL5zdjpCTHMwRCNPxs?=
 =?iso-8859-1?Q?4J3R0+lYQoBLYCY4YLtwc+y3uKjiEa6P6QqC8WkNrzePiWhDFxkBznjuKQ?=
 =?iso-8859-1?Q?VHaOGBziFfMQ2BbrMAlTo4qkbH24PZOW1DdyJUnyXaqC6oaOn1ISyDNAsG?=
 =?iso-8859-1?Q?yNK8eo+nhnHBCeuVHQta9nCzm8xZEWKwsJvYebkZq4LWsSmDbVX4wXD2qW?=
 =?iso-8859-1?Q?84m6Ci+ONh28g56zo66bQ8pfGl9FVTnQGgQsNzv9S830qNwlVud2/fFz72?=
 =?iso-8859-1?Q?CSaGz+kJBpGaFykYBfyCH3T4vbXftoEwSzQPy/E9lyND9vxyrgmpKSH4rE?=
 =?iso-8859-1?Q?45N6/uYI8CYHb91BFevH7KJkZIDoL/DpW4iDFmDVpZSdoH4SnPZ48LJYs1?=
 =?iso-8859-1?Q?4Vv/23rSDCstfmgq7NeC4+pdMsiZOr/rpThRuWynuPiFqhnMI85CRpihHc?=
 =?iso-8859-1?Q?C/0W6lyNNlDcIcMsfcFLgZAuZPu6TAGbsQBXxFMg+gnwpSOPS6SuQ0H2lJ?=
 =?iso-8859-1?Q?q4GTEyAc1BW75tXLru9dTVic9G/Rfi62w/9ThLay7vHUCiUcUTkNZEpDH1?=
 =?iso-8859-1?Q?7iPbIX5R29R4cnoqJUuSJMKUeD5wE5uzfbN37eEwltJQAhr+bL2vw5GNxh?=
 =?iso-8859-1?Q?ngP8a5Xb+JKug/htNoh0tdn4eBUeusTO0AoE5P5u8DNs2Ep0LUp8Zu78Bo?=
 =?iso-8859-1?Q?mwa9Wzu1WEPWMPIJ4PxyIjk+AdkUoipEKpP+DLiBZN4o4ym6HRj7FRrgKV?=
 =?iso-8859-1?Q?puybyA+Ze2eENMYnqvKwYQE5irkvHL3iTM5h0W/lUK4KfeUtG73ZTYoMiA?=
 =?iso-8859-1?Q?oXGqBTl1G1GHxpPEpi8IgWaizuXrpxgkHC/LBAv60j4yL9z1ikhQ7+CyLi?=
 =?iso-8859-1?Q?nS9dN25aDIT/PmABzDogD5D0OGUkVsxUe6hL7/NZNS+HpAIMO0Hs9OI0sh?=
 =?iso-8859-1?Q?hVBYQ6lvPy7TzQojbe4UUCP+iBu8izAcxiWs0qrXUCIcc7Gi0+2lQnFKRy?=
 =?iso-8859-1?Q?yNA7LVwwaCUXZLtk1vHUkyVnhSvzh09jd5AsSMw5ZBSEuko3W+paAk+W0p?=
 =?iso-8859-1?Q?RxY3KoYUi8qmFnwxhZ7qmemfV2bWm6i/pKfaXowcP7woJeNywD5GywbZha?=
 =?iso-8859-1?Q?pgTDCKzgNc8g4U0J9Tr0AFZCS1dz3OJqiIN5+6A5oVKmutpBaLMLcdxk0D?=
 =?iso-8859-1?Q?nyRHX8NYwMqTqLSGtVfd/NWXygewkVhshBXl9vWhytfBbMBOxwE9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d743d4e7-e976-4e34-419f-08de93f41f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:43.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLArOYmd4eJ6Wx4mlOnKABVINOo+6sOiB0n5k29vOAoQcIC8QULOQNl4/HisIQvpsqC3nV9bSdK8tkXT9W4XVzMsOhLzlR3vgaRr9DEv8+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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

Add functional test for RISC-V big-endian.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/meson.build       |  1 +
 tests/functional/riscv64/test_bigendian.py | 57 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/functional/riscv64/test_bigendian.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index b996c89d7d..d06d6ea112 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -11,6 +11,7 @@ tests_riscv64_system_quick =3D [
 ]
=20
 tests_riscv64_system_thorough =3D [
+  'bigendian',
   'boston',
   'sifive_u',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_bigendian.py b/tests/functional/=
riscv64/test_bigendian.py
new file mode 100644
index 0000000000..9e0b3b7db5
--- /dev/null
+++ b/tests/functional/riscv64/test_bigendian.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional tests for RISC-V big-endian support
+#
+# Copyright (c) 2026 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBigEndian(QemuSystemTest):
+    """
+    Tests for RISC-V runtime big-endian data support.
+
+    Uses a bare-metal RV64 ELF that detects data endianness at runtime
+    by storing a 32-bit word and reading back byte 0. Prints "ENDIAN: BE"
+    or "ENDIAN: LE" to the NS16550A UART on the virt machine.
+    """
+
+    timeout =3D 10
+
+    ASSET_BE_TEST =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/'
+        'riscvbe-baremetal/be-test-bare-metal.elf',
+        '9ad51b675e101de65908fadbac064ed1d0564c17463715d09dd734db86ea0f58'=
)
+
+    def _run_bare_metal(self, big_endian=3DFalse):
+        self.set_machine('virt')
+        kernel =3D self.ASSET_BE_TEST.fetch()
+        self.vm.add_args('-bios', 'none')
+        self.vm.add_args('-kernel', kernel)
+        if big_endian:
+            self.vm.add_args('-cpu', 'rv64,big-endian=3Don')
+        self.vm.set_console()
+        self.vm.launch()
+        expected =3D 'ENDIAN: BE' if big_endian else 'ENDIAN: LE'
+        wait_for_console_pattern(self, expected)
+
+    def test_bare_metal_littleendian(self):
+        """
+        Boot bare-metal ELF on virt with default little-endian CPU.
+        Expects "ENDIAN: LE" on UART.
+        """
+        self._run_bare_metal(big_endian=3DFalse)
+
+    def test_bare_metal_bigendian(self):
+        """
+        Boot bare-metal ELF on virt with big-endian=3Don CPU property.
+        Expects "ENDIAN: BE" on UART.
+        """
+        self._run_bare_metal(big_endian=3DTrue)
+
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

