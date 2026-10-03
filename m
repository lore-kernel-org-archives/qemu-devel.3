Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E761CA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Bt-0003aJ-IT; Sat, 03 Oct 2026 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39h-0007cH-JO; Sat, 03 Oct 2026 13:04:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39f-0007Ds-SI; Sat, 03 Oct 2026 13:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caamxUI9lQz9/KfU+CncYn1F1CTWxVSAo3Ha8Y6DbNFc3pj1xczxE6vRm44i+QtxLWssVudG6K3fJlaCvr9dq/etp9XO8LFiX7tWEd3k70UzLMi/Kv9uFfdE/PguTjhGpFm9Ii301gHzT9fsPA3oc8o0i7VulyLSm8LeoA0WkY6foEdA1sV4NeSLj/1ziDZswK8AOOCMQ8tj49pzBrDJnzZlS5U2h6F+3FITwcJmnYxEnEP3LcSyY9NPq6N0w7RG/2YpDee5zSpsaE35wn3SPSXjjVmcVae9BxjFXX4qI2uGNtx11X0qKjF08WCzf6uv7PG+UXHa61Q1GfBLh4Fv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AraiGi19F46OZxrWkJb+WZTaPvFtnkfQaNUUilD53kY=;
 b=wXiIPLE/DalqMc+fhNMhc1zYFSvVrFUDE8Nz6KcdU/9VooJCet+9Mo2SJ7rS9lN2BcpejF70UsIrmPAAt0P6xoqJvLhvdVPr68jh05Eaa2BOb5fzP7aCGUbIcEO1l/tI9G6eYO30uVC1jyzSefaxrAL0A+Q9EDjSwKqyJPdv36NRQ48j90atXW3YLgFok7W6aCxc93KmO+bzeWUsdH8M7aieclh3htq7ppd/69gs9QkouRSRiDoBj6H/n8prFPWG1uhXfh39cJDKtrEZvy3HYbZsrK073KPxlndGvn94Cnx2ERMs/W8ibn9QE0UapuVSAy8L3tWu8GshW0g/2Qv2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AraiGi19F46OZxrWkJb+WZTaPvFtnkfQaNUUilD53kY=;
 b=tPZyFjZL13ngOPqwxEcBW65j0nOfktsH8fsNRpV28OuCeTRSc5APAn0v6kyqekHeYW/m7HahKeFpqt2OQ9FuRXyMBAzdGCR3l649ZbzCpRv5PQvCW0ds/dX4ySsrQWTRYEOEOFDUESAXExbpM7m/2n2A7v9gLL917eTNuEL/l9LRYZL53o8D9F9kR4aBfNSG7DU7nb4HrJc8C6YZb9qSZA0glGxzzociYSnnFEfArRg3L4v1p5SJHOZao+x6zTsayUAFXPafgnW6HcHx8AQdxCdcrLyccPnzgmutq0I/fHdygAl/6yuukkf6codEbKwg7CJKwqvUcxxPqFLAxXwtGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:04:06 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:04:06 +0000
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
Subject: [PATCH v3 25/27] tests/functional/riscv64: Add Icicle Kit firmware
 boot test
Date: Sun,  4 Oct 2026 01:02:15 +0800
Message-ID: <20261003170232.2450916-26-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fcd59a8-7736-4d3e-7910-08df2170558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|3023799007|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 6+B2iOGPSqmCFgS72yeXCQHG6Jc1M/wLNO/LXLTvg79igEmYvbJLRCjHfOGHQ/gmijB4uGFA+Io85Ln1wAgDQb0a+ZSWJKh3UERtUOM+t4PUAB6p5hEhFs90dQ9UMtCus+iWg5ESjrbMC/+ccr+qTLLlcpLlzdPTF8zbpIGpLR374JXDj2I5PEBLUvee3hpxKzvdS9ySU9DU3kkZXC0ZnbKT5ptVdfC4GTizppkn5keiBtXnl2q0Hp8kRZoQEjXTeBWqvrYb/bvhsm4H/qkInxefkB0Q01TihTLcSdYGHCre3AjGmM9iQu3VcvcmclKxJkzh0n6zmLwLeudebPPnHUaWrrttwFT4aQE6ykk4lhzACuFHfY/dhizvZ5dU1EL3UTtThccyzF5N49WEgVq80OudKUUW6E7A/3h7B8y5ehsX6TnEkZOxt7JJ5dmRnE+aA3G2RTHACQbAMfn4nyjWKUjaADATsya3WpnvhtIDquBm0llTszZj706AxkxiE+ezawprq11E7GFXLG4gOejPIjRryLAlUpfFfh+E3W4OPGpNpM2THgdfMWcP3FwwyH9dvfutVvXmrknGA2su6HOQ5+G8m+kOO5MIDVj/e6wnTKP1xwnKibNbv9/KsHrLm8o7ebExR6enFKO9IxGgR+PzyYf0ukmcty48hyRqqkeNueU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7I4B0h2DvaIneRNt9lqjYEyaO7fZiw7bRIMpe60neZqPfopdcqHKxy0gstA?=
 =?us-ascii?Q?FKdYw9e67oyczulbEaxlP9m1OJTj/G9+U2IfsGYVnK5AkouVJhQNt9UBRYhV?=
 =?us-ascii?Q?2Q7Y7QRMVNO8Me01rsIBKrG2+DG+iWp/95p0g2ribvrjZ4xoLW0R6x1UF5FF?=
 =?us-ascii?Q?iZdellJGQpnX8jdKTWF0P9hzS5Eg7gTFiAckza9QK4m35n5fMSAsIAGGGU7f?=
 =?us-ascii?Q?sSdLi5D5TuL1xmeT0Rg1hEEJNNl8gIRqm7gP3W7ZC4IfG/uONjnjgrkDJyi4?=
 =?us-ascii?Q?I2WFcV2w56ByNkWEyw7pBuIAGZfXkplE/5nSCPdtOtoRPl7MY7wCxlb2UoVy?=
 =?us-ascii?Q?V5VI8rzMTGNro4/4rG6tpUssS/0erN77drytH1bufF64rS7vdH9PwnAECBYC?=
 =?us-ascii?Q?LFyCjim1CATP5Dbu6g6Uloyplb2OXXgWP41co/kq4+DbOjVeI5YEpUP30bcP?=
 =?us-ascii?Q?A7GfcaH9vcaa+iM+JTsu5M7696gBUno6VJz5pSvWV4dYraUBVpo1nyU2FhOy?=
 =?us-ascii?Q?29HKGdPoI54NS7MQWczX5+znTzTKjslqw+wnbRiyS7KjkicWJFSCEF4QuzlT?=
 =?us-ascii?Q?hYtmSdG8cDj1trQoQgQ7QMdB+jA+nSgtsRYE5UIlVSBZdMwP7j9dMZnF7hJD?=
 =?us-ascii?Q?vK5kmTPjE3UqnTvryKjAa8l+oPIjpDpghNqu4KZzWHBfr6smTF9a+1QmbNVV?=
 =?us-ascii?Q?gG2ZeZiEkYCJcduB48TCfQeGDIPeZUQrXTtdMijD6USItNy49hG/rKGiTryF?=
 =?us-ascii?Q?6TEi6YhV+HXvk/xBE3vtjopx8+A2atkiI7cG97ctYVFoRBi2HBzvtUO+4HuT?=
 =?us-ascii?Q?xzGd7DfcTP2Eucgun+HywxRZQ2QyUP3Ojlfz6HxOnmOQ++hPxLAhDUd72fre?=
 =?us-ascii?Q?acH9groGkJAL4MCWcDj36eWYM73+QeC2JHbfyFwQWCouqKMzA9D42is++pOK?=
 =?us-ascii?Q?D7CW8HBhv+sb5jwRjpr7sGyoq7Lj71+zEr+YTx5358gJTjAmdT3Apz/xzPtt?=
 =?us-ascii?Q?Q05FwWSfSQt+mtYbWnODuVMcA/aBwtnpANGWdec+xaA4LeIddAHTQu9x0Vo9?=
 =?us-ascii?Q?5LKifQPSHmh5KvMhc1bKuhjTjTuWp1R/Yet3WlZWLPJ4KSl8mX68rGepZlYo?=
 =?us-ascii?Q?3rHmCPtiUDmVvUEOOTQOfYJeXHQMEr6m4X/V4xMcGICNPARNyVdDZObjbztE?=
 =?us-ascii?Q?PdFQwvzZF/VmjWZF3pECjhXrWPZR9TUakLZ1NZ4zPtHZbFvlw1ER/yTCsrJW?=
 =?us-ascii?Q?3xG676Aag1ogOUoreuBmMqZTMzZyaWxnhFHBo8dKgSW8/W0jlNW6F+wrrIlY?=
 =?us-ascii?Q?N5ECDRaK9ftV1ftzI+xREX89IrtrRXkxh1faBvlVSy9rODVnmubhFTb9VYam?=
 =?us-ascii?Q?Om7TxStjjtz6mk1ZQh4qe2Z/N2joxN0W0SUBab9Fir4k5GQVjJWkF+Rb7fQv?=
 =?us-ascii?Q?HeVjGzBx495tHWzbID+15TuSc8V566fCpC4yrSzuiCHPyCbaYQe6363axmID?=
 =?us-ascii?Q?ttuKsn+Q2rulyF9sufSoPmEOX5Q/el5pxS9KxkIyM4UpGrVETy5eINFedf1J?=
 =?us-ascii?Q?+OTEgLC4OE+0tOivSF7Lhj+4r5JyfIobQC4V000MgSdCNvPHQ4rDBszmgaJD?=
 =?us-ascii?Q?IPAfXk1eGJS+XPNX8a69l+DhHMTXYpKJY5TZaRwlI4WAQe1ZGe6eQGC7wbh0?=
 =?us-ascii?Q?wvOFBvw2fRBVKXjEiZfu7k8KU177Je36Ewinok+ulfPbGfdd/U3ncv9vnnwt?=
 =?us-ascii?Q?luY9lifWjo21IzOV5W9ZWDirVNDLFkg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcd59a8-7736-4d3e-7910-08df2170558b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:04:06.6438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf7cv33XyR31dnVJ5oQlj7bZJtIh3UsPyD/DmNd2LlsrqspznPj0t3egWLvVcQ/pWdrBiZkdkXp+VPLlFlVSbAlcVdZDXb+6ypojiz8hbU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 MAINTAINERS                                   |  1 +
 tests/functional/riscv64/meson.build          |  2 +
 .../riscv64/test_microchip_icicle_kit.py      | 56 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tests/functional/riscv64/test_microchip_icicle_kit.py

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
new file mode 100644
index 0000000000..559ae1f651
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
+         'download/v1.0.0/'
+         'riscv64-microchip-icicle-kit-v1.0.0.tar.zst'),
+        'fe7eb3ee737fd15d6d5a8480822b070923ae4d611b19ed03983e11f35b6aac04')
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


