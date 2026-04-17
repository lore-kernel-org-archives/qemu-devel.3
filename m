Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF733F43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg3I-00016S-Oc; Fri, 17 Apr 2026 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg30-0000cZ-37; Fri, 17 Apr 2026 06:03:42 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2x-0006gN-6r; Fri, 17 Apr 2026 06:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0A4ugAS6TgrU7aUSDxUjDay+wNu/ACLhZm7AX5QWkdpZ5fKHIG65qLjzrf9VQKcVT4j0/UqWa5EkrxjWgc5hO+eniS+pPn5NibergfSR2nqy2qyFH+bu7VGPkwgq6Q9UzBJdlUMQqiPvaWN4TrjC08pH6mFjqLNWBBXlTVImXNWGDI/TSiW8bUDOvW2x4B1iFxiQyk3Q4mYksSpg6/EfqH5ry6/fmETh7OgDaLyTT2SAil4WWw68Si1fnl926Vpi1Z3azOrXBguey3KvcKrxj5ZFGsLJqIoNwZX2zDbWk26Dk52J3QbQMkenR4aPEgo8b4kax4JJAbM+D+0CHSi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8RCiRCN9qIN9MxuTsL1AqvgLxWkKHPm0sWQZ4MLQVY=;
 b=tgvKqdiiuMhUTxYf6STUoEAsPeFHhR95lmsZVWGUcF/9N/vTdsfAGE2y/vj2EvSugoNgcsCc0wJSvURp+xHYODPemoizyaptJXNHCYn/3oxyyxjhjTMqozIqG/8wOSMnhE+Ky8isJ12IfCufrMb9WoIpyuvcRbxH0f0ACXcD7vNNHgRVlm4FTMnI9njIL3sJ8skLoNXtiGy1+dqbf/kR0s/T/KOK3vIRhEA7KcrP4G+rXJKMAN+df23Fid9a2TuG+Ge19N01U4S7UiFLTSz9PmrxKSTu4QUdkdK4eoVqqFIx1Sh4P2NfGIWAK/5ybQ3jEXLH7mtyVueD68/A3bYVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8RCiRCN9qIN9MxuTsL1AqvgLxWkKHPm0sWQZ4MLQVY=;
 b=K4GFV/ZWkqneaY4Aof4IYyH7fMpEYSkAF0cXSkcNwwUtB3K6O04F1m1gG59Y2iUSvwDWZaoZjEO/OnCeYE1BXAtKqLY+sQcCnu93fAbZhge5DhiR9if3YrfrgnXWf+5ChXuhYtlcFKOjbw9jLBrlQYFXBHU6xbvf4Kr8stKJdEIfKxddrHfyneNgMiVfxwP8E+8YJGX38/aQCSddRX4pgzxiFCt825WyUyb43FFeIbluotJuFqWBTxdcM20Q+5ODjt4mYCnCncYGYa8n9mzreskYki4NBk3i094COCZX89YAVZLYuDIJVrNVwaoekH09ItEi/X31kBviIEfCIwTzjQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:14 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 6/6] target/riscv: Add test for RISC-V BE
Thread-Topic: [PATCH v7 6/6] target/riscv: Add test for RISC-V BE
Thread-Index: AQHczlFnQUhj58YbwkiHr8IkU7Ix+w==
Date: Fri, 17 Apr 2026 10:03:14 +0000
Message-ID: <20260417100302.162260-7-djordje.todorovic@htecgroup.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AM7PR09MB3736:EE_
x-ms-office365-filtering-correlation-id: 23e770d2-02d4-433d-5ced-08de9c688a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 2yzoAmbIPL2qf+CYfAKHRwZh8MVCFBLzvMPI8/2frb7G/BbWeFZaWkjJzYm95iCa4rXNKxLa6DeoDghgk0fWiKUHOD8jzlohlmM0AfQZFR5WtX1pkRvVnID877rNONesqy+F7rNPzBVVQBFZZ4Kwqozir2njt2svF+m8RIYHP6qRN/Kg5nC5QGqVk3Z4e+eFh6mpjfmQImLKJTrDw3HYY8qkwD8CUKOKc7e8sRyVMaY5UZthjbJNviUE91H3E1sY4T2cER6QDIUITbQ2iLnXxsJ9ppYcFC9ADy+P9EfrRIOLLkDbHM9Sx6p2lj16BN89xBONaz3uUPiuLLnUTDobohgael+jdpiQ2OCKXyxJkSeLLVfK7YhcLVafKSz7LFTMFl8sjIiFg81oCYiWvPc1PFemNO/h/vT3wWaFgogmtUAEHUQYQdoXz7T2iYMD8MbRKz4MT1o39JAyiSMThOi64iKpdTSrQbu8bmhpwgeEVG807tX0HflZITZB9kNLTmPsiIWBaQooiX37WU3HokHOw3i3XXlMY95CYfFtJyw4z5PcyHfURNNOfNupEMphxLuIlV2Q7QtF+rPB1crigTooW6YIyuZwfr4cqsLHC/lF2EQ75viFe57VH3AOZ3nEGC9XEoFocXkgsjtWAByjM8uRozQ6ph4/5WG870JIIvugfyg2fu/UA340RG3O/NB6zXAUgw2uE6SK3ViHRF0dOrP9WMk1qhK3Rai0VBIsTyzr2B5slvMj+qEYyQaAOzPgpuJPNO/Z95557pq4+lsvrJZiaGtrsWgO7RNCZqoBbfoPT24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OIsa4tKkNmX/h/3/fr1O/B/itMGIiCKEzRxhsrbKJLUFmbEiNiRvWE9a7w?=
 =?iso-8859-1?Q?jkp1CnqY08MNuf7lU6nHzbtAmlkIdlYf+JInAeAyAokukNDCqYcUzrsk5s?=
 =?iso-8859-1?Q?NAtp3FE/JXxgKafX3Dc9tVu4NKaKokrfzEe6AkAeHgcyMm92CyanNHo+Zi?=
 =?iso-8859-1?Q?5KTPG9XpCMKQNidQ4PIrc6MroQ/Vin16Ds/eSqTzlyvPgbGaV0sV+dTHhi?=
 =?iso-8859-1?Q?gpBZtf3wUPOJrpk7xIOsGEATdbcwqX4wBgyP5wBXZHY9iKo/5RZeST+KOx?=
 =?iso-8859-1?Q?2IsdpLsKIMAFcCwd1zm6dRm70IV8tuxXGEIbevCVHAD5z3e8Py/5+W52fd?=
 =?iso-8859-1?Q?71DhLb1JLR1z1H47X7SrvXNRE0+fgUJmXVEVZMFNxcS6ULtBhLlcUf7L0L?=
 =?iso-8859-1?Q?A2k9mvO/ErlTVVLf5Dq2EKX8smqVkBS9zmlOBQ5bHsuZIqSLrSxVs+mOI+?=
 =?iso-8859-1?Q?s1P7avqT3O2R273wFVOkBO9TkdH4aLouN+bVXeaNRJQP9eCUrdP7bT90sC?=
 =?iso-8859-1?Q?VBlPb/NgL6M97svkuIUmtdMqMMDHL/4EWliqVlz7ACcVacJxAJoLYWpWmw?=
 =?iso-8859-1?Q?oFZsgYjOvxSRmNrUsfReg47qjzHpXC8AotZbvEyWa2bTurqndEuap4RUBm?=
 =?iso-8859-1?Q?bQ2hSwuDz+PmnO3rCLsMcGPN70PpuKgnxBsmFd8/eR15QXUq/RLn//eWqy?=
 =?iso-8859-1?Q?ZCjGuNjyuDzmw5B6usH8OWrnO8T0uZQUQXkluSl2MoGL9mRzZdlBycmEQS?=
 =?iso-8859-1?Q?6pne5LNv6cOGYml+P109Rt6PMRVnLRnyXEoyDUMQ4RtVPoO7zTcr+cvSYo?=
 =?iso-8859-1?Q?/BlJFkm6iEk+HB9DQohqUQ+C/zTnxTf53iTGuy7/i/pjRtDUjDDs3j2b1n?=
 =?iso-8859-1?Q?sFsMag92GZ01bPMIR/dUFWh4U62mXKUaGSwqPpuEKN/n8pq5O5ca6TPB0x?=
 =?iso-8859-1?Q?IpB+UrV16PyOMSpe6eMZPZZ6+NbTe0RifOH3aKGnVFxVP1BVn6cTqReP2P?=
 =?iso-8859-1?Q?dVL+Tms+20rblbi7rmWEERp1zC4BajBh3tU4sdnIxbvHW/pr8Hu29bKx94?=
 =?iso-8859-1?Q?IZPr/HQozWuaYV451amfl8boxUxYbESa0EfbFqlDYF4ckw0KiU4A4Jv990?=
 =?iso-8859-1?Q?yGvpR7Zr7nrpVtv0kCx3psNqDdsRcAjrIBhOd2KMT3/+uMVgInIwArjIYl?=
 =?iso-8859-1?Q?NKEayRH6c114+aWOgQhPpr0PJSOfJmsc+G3QoVskUrCk6tEEd26d/2QkA5?=
 =?iso-8859-1?Q?/VqKczjde+0gJpxSJsn2AzmNrI29mFVpPTIJqWCs0NOJAoR5K7uiPv8RPe?=
 =?iso-8859-1?Q?GCF22r0QSHlZXIJ22QzVY04XdJHMDIZByH63zGByiqI5ufXBQRSrEVHJg6?=
 =?iso-8859-1?Q?Rd7rUIhhY/PKwn4vmC8OLcajaUmvlcIDBuyN4vR02O/WRwZUZTVZvcShM2?=
 =?iso-8859-1?Q?UdG65umZt6FnmrRr8HQTaUJYatuS0D4l88i71FDIxON20KZ5eyOBzNgVoS?=
 =?iso-8859-1?Q?chT5ictsNFZs0dlbSpTM1B90kNti+Jum29LJCAD5XVB/HlpNRnj0XaJ1u6?=
 =?iso-8859-1?Q?e2Y/SeGjgLtUsbVtI87+AEMWeRLDZxWYmGgwQoRgh4txSOxgggmGEgN6+D?=
 =?iso-8859-1?Q?LFnh0xj6ketlvxj6cFWKD0JImp5yGf2ZAakq4IGFzcdD0rZLch1tFDphfe?=
 =?iso-8859-1?Q?+PqJYA6OKVqhn1y0bv0LPKMos/fU4idnVstcpRxGnH/kPhrM1DIamy/5FP?=
 =?iso-8859-1?Q?51UExhxAbkFzRaiXogIEcccii5BR5cnkJEhLHjw/iofJdgKDhXa36m18pv?=
 =?iso-8859-1?Q?6ptKFTnyNQY5+bP1/nuUG8AYeq3k1jg+hslMgF7nyCKmasFG1oqi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e770d2-02d4-433d-5ced-08de9c688a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:14.3798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1lbcldTy712YoDpYb5sGpq9IC62LRBkEpfMpssFBtZft8TnaWSoR9h6cGFNT5M+JVSUYKrEn+5hvQEpZ5t/w1RuSZO5tEIKUMv6BnyaTDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3736
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

