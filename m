Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D1CC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkX-0006q6-6Q; Tue, 13 Oct 2026 21:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjt-0005u9-PD; Tue, 13 Oct 2026 21:25:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjr-0006wT-Qa; Tue, 13 Oct 2026 21:25:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRnWFuRx0Okg16m3CK7HCWCp/CZLRZutSaT4RVXz7X4aJltGIhNGlhdt5PTc4ETCfI/XGMmjz+Q0HPtr0BpMT/QlybxNM/dIylj8y2JMA4W2H+Gdvvfa8Jx4UqFjqP5YEoZ5M5FyA7rSL3q8hCfFppnPiSuYAksX6twT9wIy8td1Uvocwj4XrqPMWQ0KxyIirJkunpUtZv5T6vlUJhoSk4MGvx4ftHtatHHZvIqMXcbWNtOZiDLTVpZNuZpnR4CdR/d5COSIZMwl9YpEXb5HOI/Gl8jP037HZvuBdYJxHp5pV4vFPDfa6NjE40s58L1E7FeGM1iRs0b9zzd7jCyDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APRUewbPHwWvoYgOxz8YtXthyVxO0MricxWgt//UwWo=;
 b=qyMVJQkf0Q8Ygy91ZQhm2J9XzSwc8irIJfZTYAe4vBFwlw54JnlEASAAMw2zyUrCyjTPFzW38C6xTjmH9BfzRhE/F73s3wMzKoQdSGtNII1WYCaJ+Ck02wNWAvbOFvcJBg322SRNZ1RR/GWzd2kvqSsrg5qJTPml828ZeCEMSgutHgwAjQU0EWyxW4coa68b0brrw0od1TZaUa1GD+mar7SGjWI5RHPPOzuVf+y20oyRPCOoqj41fuyFZkg+PYyIygbfyuuAvDIrhYERkCb/E54ZhXHWTyKRyUTOMeeYZ0bg80hVTiqNzyre9wkHgrwbmpkwHAk+s9Wu+ACU3wlEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APRUewbPHwWvoYgOxz8YtXthyVxO0MricxWgt//UwWo=;
 b=P4GXHX7THuqHz+P8hcIBnNCCyZc9qO3ickgHTkQ0dUHW5yPsmd4mLpjPKzld2r2kX/fX+Ohcy6mkV2fKltT9OQEyG5d3te3qpG0Df4ZZlx0JCrJInjV5rYtBJhtt8YCv6xTHg28fJhSj2Z4BiGqpR6SKlomzmxGxbTNc6yyJQRdO5/82AUMBhncJjmlvy5Uco3OD2y9eEfLG8G3QgiV5dfROyK6Evg29YyTXh2KmDUzeNSr9QPBk2RO0kFz9kE6/bIsX37MGYcDaChPWRZApqqMnPpmPJY0uXrbeqjWptUtptuXeI5gqrl4hGcihxx/DhBQ1gIHkzFpaPWf3zW7lnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:24:55 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 25/27] tests/functional/riscv64: Add Icicle Kit firmware
 boot test
Date: Wed, 14 Oct 2026 09:23:05 +0800
Message-ID: <20261014012323.322790-26-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 759a9d57-73d1-4f36-bfba-08df2991f40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|260925022911599003|260925021911599003|260925021311599003|10067099003|261009223027099003|3023799007|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ye+tF2EA/VScdqAJJMCmORTgnQHUVvyvLCSApL0dqA4eMMTXU9jzLcMpo4N4lQ/0/AORJI0pD6oPh/VzOcbYjCKEwKLCotU7NFF+278wBHizW+OLXe/qdqfLPfs8ho2mAh071ukmTprOz0CpKg+XR81QQP5p8YeA2MiwhMtb5Prdy47V8/x0j4XEdlJAhCy+3aV5pioI/UhL/AVXSKJDWU5V6M9j6uOhoyAuR2tdxcXd6Ze+nx7di0MiKmf5bmyyg0kYRiC0Qudb+vCpTx+rjQk9XdzAuZt/SfE99xCnjlqUjxmMon4YJ+sCqm+W12bdqtH7FLwNDDgni3mc4K0w20c9PW/5s7HT2iBkd2a0XiyZP+xfeP2muH+1Gy7cp9oIG52+ETbK+6/TeYM0Oo3aGOSdNieuloIdOMCSXdspghsD0GXppMe1pPpS45sYzVsmQOON0p8jPA/0JAWkYcDdr1kZgWtB0RjZIU3jc09z0AxYR6DBmNnDdtfjr/04nYy77EtvMJBDX1w298jGvzy8Pw6nBDsXUYFIJNH8xfVq9BiCfm9NODKW8Hu6cpXz2qahCXbr7tEGm3++M2OeXyd14my9/6VZzfDZgU2hN433Oa6CMIac4Sg+L8MXNryKyiBSEdB8vkjCyzagW87J4uRDOnJRn0GbI+5QGH9p4S5Dsmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(261009223027099003)(3023799007)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XYoM4wo9kSp4T8b2AZoBdXpH3P7UkqXHES6Cceg5MivcCjo0X4PLzwSH6fRu?=
 =?us-ascii?Q?itWQNHpMmu9po9G/5AzJeVhzS+mcza6Tqa8i3AozwnnfHL0Z+Qt4cuLwf9w8?=
 =?us-ascii?Q?ANQGjfivf0cMv6moqsm/Ke+prxe1C6gdrXVl3J0RUR0Rn9DxCb9iknr0DXhT?=
 =?us-ascii?Q?U4lL5peixMmmDw4Y03lfTNBBNoILVgf6BHSTrtAEhzZxx9OOjjCPUt+NNCip?=
 =?us-ascii?Q?Ym6GY/48h5NL42FZ8fMBTzhhjIVypA8ZPocnHQCIHjkmelxEnqLFEMQx32S+?=
 =?us-ascii?Q?mm8n1qQrT9yYmEQGniqHFuGNfxqXRdytmaYQzWhNswnrkcEtd/UEFsIIqqJs?=
 =?us-ascii?Q?xk4tmTxZ49rHGxE2a7mNDOtasMD7gglaWAC+If2inWIKOd/xT51MDgpcepYS?=
 =?us-ascii?Q?1nZnGihBiWGYP0alClHR6NRqgKrAtzpstjQgil/SUTtCITsyELQt+cFxMg5l?=
 =?us-ascii?Q?sP8DyNL22SvvJOjoPV3EjTL5SLXqzNYOYFRms4do4b44/sXGuqnRsxUZMp8D?=
 =?us-ascii?Q?4jXl99iZCVnvFn7eNs4kHWD/9K8xGceVBGcCR7xNNiq1RP0sYbbryUGRBz9n?=
 =?us-ascii?Q?X9rjCYi/+VhcRm4hPrWCfXdrZZECVnOjefe6Qe2frNOp2CcllI/aJLyaj9gq?=
 =?us-ascii?Q?E8gXYM1y2dHLFiAUeNIk3hBbOMD38IbJQeAW6WUxsbH5eEn/TIAVXp2ztAj2?=
 =?us-ascii?Q?VYR2lACb+CeqSn+Zk6UmRKLBS7dioVtzaXlXupYuXliaDjT5liWfAHMYl5zU?=
 =?us-ascii?Q?Nnl8l0K9MK0CGzN1skL2WZvqFUx8idPz9JcYTNOoeus/ldG4zXOm586sEAJP?=
 =?us-ascii?Q?uCTWRRGsznT8zIicSn/ZCnBMgi6C0fepDvjzkIHEIqPslABJZzYL3gGoDx55?=
 =?us-ascii?Q?3Ddy7UTV1ZD6UO9kOcJ4fDCmXeb9eujIZO13u3HtsO85TNuprZPIokWbasBd?=
 =?us-ascii?Q?u4o4KgK+Opjx9zww4lJ3gtaWa+cjAVSyEqRyrs2dVSZ/KbB6pKXKw0Io+uIx?=
 =?us-ascii?Q?LrmEJD4UL2xPG101os4YfdlcnavYQhRdp6HK1ewfcOAEsXaTmCdz5682eV+4?=
 =?us-ascii?Q?GngvdhhveDGDw8h2ClaYLOooJJyzZ+BBNJ3LTBm6+yXpHWAC+yRjPBAe9zPB?=
 =?us-ascii?Q?CjgU9FnEIZ9qtEd9cKvTUhShbVNnjQ7VdDU5PVGEnss42mnzkuOF8BfcmGos?=
 =?us-ascii?Q?twfGQrxaXG+hFvzPQ6txcW6esMVY4SckLKWaNpqI+BtkTCZXk7flepAKrjPC?=
 =?us-ascii?Q?oegf0GsVyouRPfqUkpF2gsu7w+RQSmNU23zcoM/X6ooBPgqusXsZHhrLFWpC?=
 =?us-ascii?Q?0vRzMnrXJ6n97IYXR1zmjSXyJAJnoCshIlSAppL9fbIaQJ3GKmvrvJnP+6p+?=
 =?us-ascii?Q?afW7QLFwwrSqqf6AGUHbG7F/A1kRzuwJweybPC4LHUeway6ak9BJnCQzye4F?=
 =?us-ascii?Q?HkeqkzS2DziUSWWM2wB4wMHT//On/nEiuO0TjvrTtYAeAtJrhGbGpEaELe1s?=
 =?us-ascii?Q?1F1REc3TFK9/lLwe429Eye7DysbIT/9I4cMwECa9SpTo3yZtkuBqkF237A7s?=
 =?us-ascii?Q?4OemYd3e5IF2WtvbNYnUj3BVu/v6PG86vqpooxFG3xPCWR6hChn7e7CIjSA6?=
 =?us-ascii?Q?7xulA6kIXqNhNXnJ7WABXjqorgV3wizPSQLS2Q0yRJlxULe48+MVluU8wW8X?=
 =?us-ascii?Q?XnPU6ViKTy6qXr4QOhLq9xQ4tKGmZ5LJkoU66tVJthRW4DvcBlhpipitqFe5?=
 =?us-ascii?Q?/hJ8RmIiw1YURYbpCd1dC1ZItysggAU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759a9d57-73d1-4f36-bfba-08df2991f40c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:55.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMy/nspCQdwaVzavHj8GV+J8jp60CtjRQf23oK/EB+uOKJ383XzMPsnQojUHpHrkf8QB+OYY0s2w72fBdau4LdstGwtLFV1vjsClorQiCZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222
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

Add functional coverage using the v1.1.1 HSS and SD card images.

Boot HSS v2026.04.1 and U-Boot with five harts and 2 GiB of RAM. Connect
the test console to MMUART1 and let U-Boot start Linux.

The complete boot exercises the SDHCI controller in the DMA modes
used at each stage. HSS uses Version 4 64-bit SDMA to load U-Boot.
U-Boot uses ADMA2-64 to read the boot script and the large FIT
image. Linux then selects 64-bit ADMA for SD card and rootfs I/O.

Check the machine identity, kernel ADMA initialization, root
filesystem mount, and login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

---

Changes in v4:
- Use the v1.1.1 test images with HSS v2026.04.1
- Add the execution bit to the python script

 MAINTAINERS                                   |  1 +
 tests/functional/riscv64/meson.build          |  2 +
 .../riscv64/test_microchip_icicle_kit.py      | 56 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100755 tests/functional/riscv64/test_microchip_icicle_kit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 12ffbd560e..84e6423d89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1810,6 +1810,7 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 F: include/hw/rtc/mchp_pfsoc_rtc.h
+F: tests/functional/riscv64/test_microchip_icicle_kit.py
 F: tests/qtest/mchp_pfsoc_rtc_test.c
 
 Shakti C class SoC
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
new file mode 100755
index 0000000000..ee627a87a8
--- /dev/null
+++ b/tests/functional/riscv64/test_microchip_icicle_kit.py
@@ -0,0 +1,56 @@
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
+from qemu_test import Asset, LinuxKernelTest, skipIfMissingCommands
+
+
+class MicrochipIcicleKitMachine(LinuxKernelTest):
+
+    ASSET_IMAGES = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.1.1/'
+         'riscv64-microchip-icicle-kit-v1.1.1.tar.zst'),
+        '226e4322e5ec53513eccdf16e4e967cdef7d57a0ba19431470ca68b883457538')
+
+    @skipIfMissingCommands('zstd')
+    def test_microchip_icicle_kit_boot(self):
+        self.set_machine('microchip-icicle-kit')
+
+        archive_path = self.uncompress(
+            self.ASSET_IMAGES,
+            target='microchip_icicle_kit_images.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+        firmware_path = self.scratch_file('images', 'hss.bin')
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args(
+            '-smp', '5',
+            '-m', '2G',
+            '-display', 'none',
+            '-bios', firmware_path,
+            '-snapshot',
+            '-drive', f'file={sdcard_path},format=raw,if=sd,index=0',
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
2.53.0


