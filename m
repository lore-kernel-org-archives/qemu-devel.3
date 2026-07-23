Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B7C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDn-0005H2-8U; Thu, 23 Jul 2026 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDX-0004YZ-1e; Thu, 23 Jul 2026 11:20:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDT-00084Z-Au; Thu, 23 Jul 2026 11:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkxZEaNqvqXtaj5sdaGORNU3LsSpmfrxnYNTMyMbwJ+UIr4QO45iMNBZSP2JLmXIZVOsBdE9UgiSaLkFTY/E+lnMtR8LOPC1Bok7rXLjcsIbua4LI9LrEYi5UyeeLaCZv22EayPKa7U9d3yU6qyPavidCgrbJzIqeNtTH9M8OvNvjSSjNXje6TBnBjQF6+eqLveoLorgfwhk5+CUPaTntDcL0SK2+7iCVvSnPFSLIUHfxSYAKDliPuNBaScanE/eGHzEa8P17gqV8FCTPnzdCOzy81Noq4f9JU2b+7ZUUXeTozOCFareXDHM8uEVo7UX3kZHvu6+cUTwGtNthzsZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iusH6Id3cScyZBJ70MHQrkKT09UZhEY5x2BOiKf1HmI=;
 b=Btf915Zb8I/WFuIH+55aQ5g/B6kTwQfqbX4WDTA+G402b/a7rIKL5MSxQ5ZzLjJzpM4XFa6AG1v1NT0sdpqA2ec+lTpyiBBoGKhKGrvS+feuZyH9ALWA17mU6pML7a78NxtvnWhCFC0clvxRPL2POw+ufDAhrxNI67lV6RuShqrXxKKhiUGuaytc+vVaiy49CFzmHp5YILy+wi5j4nLuONfVoGk6kGn++xaXh67++q1QauU2qQtMC/Jlep+1ymZ95EYg7FTLZ8Bo5m6TaVPIJ/2YTIqE6qqY9fMSOSGwd+e3HbrtdifJ+26gVHi6FBIGWJgk7RGGHJXboCRe3Tyh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iusH6Id3cScyZBJ70MHQrkKT09UZhEY5x2BOiKf1HmI=;
 b=TJEfn9UjenlqBSCCE2ZLE+GStRS3ab7uzxFronHo1dcEjTTUdGKnqGNZy9zUP7oROohjOIXdxukOShpZ0ZVsNHnd8vWRrNcOBuZyE7I74+5a/xZReq3UDBN33QIJ1MKrOyKW2dr0lsmHK6EpKkuij+rrh+cxgxQefbRwXgv3HJ0VdAFckrA0frEupccwJs0g9qIfB4ytikmL2kT5zRoirB0q3v1G5q6kPiOkv9Ogx/P6c+gYTfEdYqv40r2ujLhOZW1Tz+wI/vWN/H2bmrP0WX9AHEbM1zTX7oG7twmRYTgHDjP+ySH+zB4gx2w61gtuaTR3QNXOKsdXrPdE4nLUQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:48 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH 25/26] tests/functional/riscv64: Add Icicle Kit firmware boot
 test
Date: Thu, 23 Jul 2026 23:18:52 +0800
Message-Id: <20260723151853.2143177-26-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ee280-1258-4608-d596-08dee8cdd5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: uekLMgVMKWTjdDysFT23lK7jEf3rsjYWQimyUHovRJm1ouTmIVSjqrMDnuj5cisnEY0n1xYFTsOCpB9Dbgy7WjwAWwn4PHYi1hr0UfdxoTIfzdrE6GH9CuUVEu/Gz3WQNr+uzWHX/L8Q233VOacJFdyvbZ4NMdl43EmuJAPbnvYfjEl2e7kn7sXaUtOpyo4CNTy2s2vkqwNylFn8XZGNP0QKWBRK0r4Ad2SpRdMVnU1clxH8Tk8JhqaEThSjFnBYzi/5v/e4IHBSOLFicR8tntRdyRm2/qopRWcJ50vNOVqHmre/sJ7tjYNB2p1ZrUM9hsBefrS1rTVch/NiVTYIQZ2g/uInjvCtiz42ssUYLCGOGhiV0zuybX+a17zIsC0I7bYRLMx8Im65e0phLp0WwmbHaNGOcFnSI9rmP+nPMCb7Fpn6wOUno89G5/OYuZoNESwt9nWiBKrirrl8eOJ8LF/drlnNgk7X5kl0u7PXuxpJ5ORGY/53OLwB/qfBeq6/oFADdVj4xwq/RfFkJShIrlZ8nTovnH0mWC8P+WMFBzGDX5b8pekNSEJv2KSeXitQh8YDBoxf9tohC80J+rbj9bO0PQyJTgY7xbaSjL0Tll5Svqp4xM24t+E2eCYBxYij94FY5Mr7oLcIDC5fMfk0evlfKMOudVa1dtBi4fb66NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPzJYZ0WL4lDLHH1KrC4c+dNhoFenLYpgRYF/L8ZZhxfDuyMvAgplf90XssG?=
 =?us-ascii?Q?NurVZZvFAhA8OpCnUwsSoMoVND+XxqXeX+35BLctILYNrrwC16aNO1/IiZoB?=
 =?us-ascii?Q?JkxdYuKflOAFc3Qi0MGc1Ozh3KFDELdX6ILFFvLkLHnheUiBKAHQEq2yO5Kl?=
 =?us-ascii?Q?Ld3te59CMoiu18TMIDu/N3TqqSHa1/jpkjXSVtMGKoiJ8w+SUdJ3bpZl/FyU?=
 =?us-ascii?Q?A01LpnM3f0ucoIeW5EF6Aw56Z7zTtRU0D1aUkOu8liYNcplijaubUD6gdUJn?=
 =?us-ascii?Q?UZvehAaDONlWFxKUniMTII+/+4p7TQUcLGOihBQ//Fo2ZRQyxm9piQ1iOLml?=
 =?us-ascii?Q?6i//nHAC93CJ9P9Ix35c9nZhzmUmW+at37vkcZCkMbM5ZTS4NeIbYRHLyXXV?=
 =?us-ascii?Q?A+HSwZsQUthAl7+C9Wuliz3PM6/9uty/bB+5/QPqsWMGWC04JduoLaL9+7yi?=
 =?us-ascii?Q?nWNvr74I8txeB4xMkEtyyQU7Y8WmYSSHiOH5Ct/qaZZENT97gf5jgEM/4hsz?=
 =?us-ascii?Q?HDg2cMYZ5mfnoxNEpWcV+tomZP0JXROcPK/4YO9vWs1+TaX+sPIAF3XgDiZ6?=
 =?us-ascii?Q?CpMuXW6DoXpEqRvcFpf/b3F4PAXndxlZYfs1tu5uPxgkYy8ZmKU83ynZ0t6y?=
 =?us-ascii?Q?zOb4NJnzoBbRW5Moey7HcWESESxnxv/SsHqrX6cNqLxqi8zUgqMI8+k5Oa1d?=
 =?us-ascii?Q?ekiFvomQTEWl837YLK6oKphNsfyHRSuOLHxUT5GOIrOtZ17QKZGI0YBQK0+4?=
 =?us-ascii?Q?2bhBy+2X0pBND2bqqMj13OVkLGT976gLPbxMgVuvtoSqGV0Z4vJtDjvxD8W+?=
 =?us-ascii?Q?jQRiMZELLjvXyxVa/0lHGBb2rQB5UpIQ7kVI+PUfB39m8BlRwV9sjprbtgcL?=
 =?us-ascii?Q?SMo/t2h/U8AqZ0HlSQQYwDwUmKY5YevL2uCDthfDLZVS9wQmam8AyCPBIn5d?=
 =?us-ascii?Q?ZRpylD8qZvCY/PdwmT5ilM3Q06gmFPd0kv85PzV07kOmaQVMacCciaTOHkQX?=
 =?us-ascii?Q?up9jCQw44m4Q1/G2+m4RV+FXXfLJu8qdAY1JoChgAKkmyWqL8ajP8DPVM0L6?=
 =?us-ascii?Q?bYs49hd8N5sj3A0XTHXj8qP9WB9hm6y4EIrk9kJrakksaRbOizziMlf/cipI?=
 =?us-ascii?Q?1EsvJPCz/vjCjcuoaA1uDTBuuyFloVeFDJ8AgGSqOaDXMIudZM9R4SAWq06P?=
 =?us-ascii?Q?FSBf4ZdmmCvF+z8uOdtnBhzcQC7VT/awVK0LL8a/xOyUNibrgKx+7FDclRf3?=
 =?us-ascii?Q?rIoz3oUuaYbHhsBrlW02KUnA8bZ/jyvfupVruN0jmSHa9UeEVTthHSBJvGso?=
 =?us-ascii?Q?Fo7Ee86hR92wvOdLr1WAKUNdn/BxbKlxkYlCmxMkR3fG2GXKB/eUzlcdwVZH?=
 =?us-ascii?Q?GuyPFgc/USowX9z5+iMB5iqU6yl2o5tGVTm7pTivBYAu7buNbGaPwMpjXVCM?=
 =?us-ascii?Q?9RzAKCIymyHSU7nhlPwzGcD9hYGvWFy9gc/tVXkMsScpMm/zQHSoXPb2x61Y?=
 =?us-ascii?Q?gc+K8ztswDZlkBtMFqtj/HSzrqu+Nm8R+Ygn2bDPonNgfZaJpz1qBy/TECCP?=
 =?us-ascii?Q?YwFj8ULvLTs2VB9KHO03PENVz/7vRxF0phrrUCJSIpe2mqK6RRFVYlMcvWpq?=
 =?us-ascii?Q?2kgReVJlS0WfKAyJl+GuAtJ2lXRUwwD56F3A8l0p9ezQOOK4n8SKflVC/tKd?=
 =?us-ascii?Q?Z8xwAWHyReuphG8AvPpp5aZMhTlXJ4TxyK9D4gPH+zmUGXQpSxwSYZSth8HN?=
 =?us-ascii?Q?2cdHZF3odKjpQUx5GcGJ+ZMAKEVwaq8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ee280-1258-4608-d596-08dee8cdd5ba
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:48.6517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P/7usnrMGsGeSxK/KNjQWIonqqE1/nVipjEBR5fnyGophRfc7GZ9GVKgb7jr0uujQd3X1LYqENQkYqMpwm7MmIDS2HkkAKMmjAOytaR5AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add functional coverage using prebuilt HSS and SD card images.

Boot HSS and U-Boot with five harts and 2 GiB of RAM. Connect
the test console to MMUART1 and let U-Boot start Linux.

The complete boot exercises the SDHCI controller in the DMA modes
used at each stage. HSS uses Version 4 64-bit SDMA to load U-Boot.
U-Boot uses ADMA2-64 to read the boot script and the large FIT
image. Linux then selects 64-bit ADMA for SD card and rootfs I/O.

Check the machine identity, kernel ADMA initialization, root
filesystem mount, and login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS                                   |  1 +
 tests/functional/riscv64/meson.build          |  2 +
 .../riscv64/test_microchip_icicle_kit.py      | 52 +++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bcc59f1cf..800a2f31cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1780,6 +1780,7 @@ F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_l2cc.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/functional/riscv64/test_microchip_icicle_kit.py
 F: tests/qtest/mchp_pfsoc_l2cc_test.c
 F: tests/qtest/mchp_pfsoc_rtc_test.c
 
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..cbf61d9535 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
+  'microchip_icicle_kit' : 180,
   'tuxrun' : 120,
 }
 
@@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'k230',
+  'microchip_icicle_kit',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_microchip_icicle_kit.py b/tests/functional/riscv64/test_microchip_icicle_kit.py
new file mode 100644
index 0000000000..a75803fb84
--- /dev/null
+++ b/tests/functional/riscv64/test_microchip_icicle_kit.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots HSS, U-Boot, and Linux on an Icicle Kit.
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest
+
+
+class MicrochipIcicleKitMachine(LinuxKernelTest):
+
+    ASSET_IMAGES = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.0.0/'
+         'riscv64-microchip-icicle-kit-v1.0.0.tar.zst'),
+        '8a8a831f5a1715503abf88386fca81c8e5edb303bff0265118f6ac35a725d27f')
+
+    def test_microchip_icicle_kit_boot(self):
+        self.require_accelerator('tcg')
+        self.set_machine('microchip-icicle-kit')
+
+        archive_path = self.uncompress(
+            self.ASSET_IMAGES, target='microchip_icicle_kit_images.tar')
+        self.archive_extract(archive_path, format='tar')
+        firmware_path = self.scratch_file('images', 'hss.bin')
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args(
+            '-smp', '5',
+            '-m', '2G',
+            '-bios', firmware_path,
+            '-drive', f'if=sd,file={sdcard_path},format=raw,snapshot=on',
+            '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot ')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern(
+            'Machine model: Microchip PolarFire-SoC Icicle Kit')
+        self.wait_for_console_pattern('using ADMA 64-bit')
+        self.wait_for_console_pattern('VFS: Mounted root')
+        self.wait_for_console_pattern('mpfs_icicle login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


