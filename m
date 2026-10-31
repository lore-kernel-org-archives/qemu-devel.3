Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47289606A322
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=jZsRJq8F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3vd-0002eJ-Ov; Sat, 31 Oct 2026 03:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3vc-0002cj-AK; Sat, 31 Oct 2026 03:55:04 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xN3va-0007eR-HO; Sat, 31 Oct 2026 03:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siV+sDcscSmo2Ck0lC20mjWdyHq2sR5c7sKG5fMhfbuMommj/SxyWjtc6ujlYyHoHsyDDpXGLEZrIe117bEq6OxnDJiKT19mmnWtZs4cPjmJkDYYp3OVhU8Flnf/LyjO1IZYCmIemxD9Zdbx/eY/LI0Q/bNfrO4JU/uuIGsDUsNryj6Z+oW1ThYtIJiaNVeSYji323KesYhBR/vYhC+FqV1/IjcFAXvWdCas+uzKtrsbvelxVGUzvIwCH6tllFcwIlmRsoNu+6NChpd2BGslm7/qbJtFicxCPCTqoY6gcJ39c6saDxjpvWw+R2csOYXZ0aEW5YTHjomoFwvdC1NBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH2KRKynvdUv0C3yJMboUHpzHCF/jl/ikfSwsjcmcqM=;
 b=pLWyqQQlcriowxFtbkiPJbXFKjKdyJ0QJP9+EN0T6zW/Qw2TZvzlbYqpN5rSMsmQGLxP4pxfFayYNYCsjvm5zt7ipmX75X52tOGbU6PFRUz4WtbCMqgDU251EuZ0GOvIIs34D59bLv/jL8f7184uX0G9OZStXWj4M9T3slbfvnU0sWd6DOpm+IoHpezYniofk7Hr6SeILR1n4PpajWDZDJ6MysFvWSg300HHxDAyyzGejE8l7xDyApUBE78mwLgGQ1NRjanbFTWk7QZQ2p3FPiIseXjdY+EZH9sFmE4n5GLITExbNQnvuEvzrtCzBbEsinJISW1/CY2t42GVrSmKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH2KRKynvdUv0C3yJMboUHpzHCF/jl/ikfSwsjcmcqM=;
 b=jZsRJq8FTqeSALsdwdjU3yFJHoWBessAqwPfcDSQESNIc3xMyUtHVSIO14H5yQPVPaC4HD4iXBRH48yTfGphToyEu29qAd07Qijx2Vx+BbrD4PoFWoeTUrdf5yOb/m0pDLJ9/ojx8FFpKp61bxWee3s396q/XOt4TambHotLCujzn86x1PtpJYUghlbqsJQ3tjiVmrsftXOZkCl7OUWcao92L2Iq53p15pv0BuDc7Uc33jWTIGgY0wFyzVKOm4oZiC+JaKOv9TvfggBHirIotYC4HSzTPqjr8iPbD3aZnppo4oS1cq7lgQA2FFle3FW+N4Fe4feqNlx0CtbuvEx9ww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB9051.apcprd02.prod.outlook.com (2603:1096:405:39a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 07:54:54 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 07:54:54 +0000
From: Chao Liu <chao.liu@processmission.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 1/2] tests/functional/riscv64: boot K230 from
 qemu-machine-images
Date: Sat, 31 Oct 2026 15:54:32 +0800
Message-ID: <8ccce284bed69c31ee16bcbd95d562e2861bd636.1793433265.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793433265.git.chao.liu@processmission.com>
References: <cover.1793433265.git.chao.liu@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: f70d75f4-0533-400b-9ce8-08df37243fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|3023799007|10067099003|18002099003|22082099003|13003099007|56012099006|261021121427099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261026121527099003|261021123027099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: TpOQyqA3U3CrUDx6etMqqQ5/DB/2kH8aRWoxqee9at6Yj32jUnHTAs/vSm/8yHBvt1NzkJG1Y3QBhWuNoqjp4JAdW1lgRWSvxLblP/GSkE6ULC6FBpa/ApTIU72njL8bjoyHp39Rlv/ztI6Cba+0W2GifXnkG6uncdj+3E/9OoT/x6XZ8B1VJXjoIZ8MHg/AqYC2PU8J64z0Zck431GXWjblZQqiezByb2ikumYmcEPIXcGzwa6dP3UOBhfXSFHnt1eyXocgBaZOaZyxWaDjRNQhVM5Up2/690jX/ehv1xDszq+KBD/+XeVZa8kxoj9amQwna5OiNp290HWCQ78oZ456wQAbgIbMTNQKxdGvULtsPN6cDLU+VWq1/kMsqtnkxYV86rt6y5arSbVedMHULiRB+YnK82rIJQYCvzZBLsfrXNWeLUB4azbfYOaSuz17HyCa4gpj7dRTJAhYeEpqn0zmUG2UXuUyHl6B6f4J/g3JyF51JKDTX34T18hGaj4GT6y4YIv/bnpdb3bkhaNMXpGWPnIRdyyV3dn1t3mVwK0AftgXRL+0WrvEBAtwCXjee+W6+hT66uOqOxPYh/QPnco1YKFGuE5pS1enOuV4DrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(10067099003)(18002099003)(22082099003)(13003099007)(56012099006)(261021121427099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdOw6QIQcnLADDBgvtvExNhbS43Ss40J/hp72di9ZCe05+Sgg+/cuy2FfZ81?=
 =?us-ascii?Q?BcAbyCHezoPn7Fgq6p1q1lQyUWYJ4ly1oTzfy1xBWthWC9LP+xyaCWW4TOCe?=
 =?us-ascii?Q?Zvbqz0ssI8S9ZaQs5RVkzvW04x2mFEjEZzbJC8FuBJFfXf8+cLam50AMiilx?=
 =?us-ascii?Q?EwafHdb5hZ+Ur1pFUIZNgsubblwEC44E4lsV+f4iB0kZNvUoShOHoJwvms66?=
 =?us-ascii?Q?6tCYDrtuQktDWKUxuYdlXgQeGzXkA9SsUc9/23ALyH/opOhLYHJYGejQxNEP?=
 =?us-ascii?Q?RYne3nfqWrLwkcrfJk+imm1U6Jrx9cpgav1pBNp7YXCDHV7xB+92qSlUnMoT?=
 =?us-ascii?Q?t1zY95PYHgivhfqYP9CW5av+MySjP2lBqEnbNvH50coLq/llbxu268tglY2K?=
 =?us-ascii?Q?gaeqjQF/BfEl93P2wlChfyumTIOYoExyDahbK9GMf4R5wTHt92maIPesxjdS?=
 =?us-ascii?Q?7xm2nrmKTjVWOy/mf30bRi0Vgv7o1LH0W5tTIs0zRxxbgbsxr2/AkfNDn0ZZ?=
 =?us-ascii?Q?/8UMvfEj+Ecq1XDKWR1tPXlI3DyhNB9IAFjeXXePr5InPBT60jGTTBMoOgDH?=
 =?us-ascii?Q?1Sk5AHLzqsvgCjimcprTOselYske2cSzzf9D3I01iTKzKOh9v9Itbn3UhB6r?=
 =?us-ascii?Q?UdLRBgm+EPWcTnSDBRUjpc0GPsFc/cTOoHsZjmWhGqGBStQSh5dOz/VawUu6?=
 =?us-ascii?Q?SXZiqSEbZUbqio7Wl8JlKoDPCWRFt33ZLQ1YGRWp/nP5GBH50W9iUCD3fe4O?=
 =?us-ascii?Q?hXLNC/VUiWU0s0XaT8wbWq21fFlTxSc0ckiNi2VknYif+4FwABGNCeWiehsy?=
 =?us-ascii?Q?UZvQszibw4BkwNSZK7mSE2wOI2suFOxzTZnmD8hU/a/4ewRocG9o/yi/TUDS?=
 =?us-ascii?Q?MUTOmcnOuILxVhaplIgeXUgs4jqa5FS62UzgSTDYD/+VAYd22fQVwbMse0Lx?=
 =?us-ascii?Q?5o9JQjAH1oXMHZy6cz+U0qZLxgfO4csZ2Jstgs96mXWpCpEeSxcyo8ZuRWtT?=
 =?us-ascii?Q?AeZiUpB/i6eU4IZSpzKQnsSrI0/m/AnTxetUylAaz9WSA0yD7Vmz2808dBml?=
 =?us-ascii?Q?NbBdf7utYxjFj6oCM/nXA+qQfe5qsrkFmXIXcxHPA3TYKnmgZQKDf777I3tb?=
 =?us-ascii?Q?zJ4Fvn6qfdLIW5m9feFmXQvtg1lxWgubVluv+VJWlDQXsH22hbCJP9RIHRMq?=
 =?us-ascii?Q?zGNQ9uDf7CRqkrVVgO49HgFEdFTtsDScT3WOWYu4Xmt1k603BXcWdGT8jbYC?=
 =?us-ascii?Q?YuxbdRVqenP1x3fcHsJQMRVm5JTL1hb+8NkHUn4/eO/U6vCjNo8zeRfLBWU1?=
 =?us-ascii?Q?sZCeeeLkyVRdvhhzS3UeBBPlgAmjaZnOjUQ5s2Eo4279yqz9sBl+T4kwUiFJ?=
 =?us-ascii?Q?JS/c9ZXAuPA84TfKPlc3voUCxMhOGl+MrxUepJHxR6x3eYCwCJhEfmFgiWzN?=
 =?us-ascii?Q?3IyJUmcDJzFo6Wc4B1uWz/mdTUIbKxbVxIArKtPwUtvZpCAQsMSG/NTqvrID?=
 =?us-ascii?Q?pSMa2pKRL0CFrk2llIifNHAZIqD+J7PwV+AFhFctMjIUu7iNBI+lh7/h99Hb?=
 =?us-ascii?Q?jfP0siCHBOfoH0r5+Nnh6jcrTKYB01ioafl8NRTs4Jg6f26AdEhUGHzXhI09?=
 =?us-ascii?Q?gqaAOLZUIhvwPjFBuaEhBmcguK3LwbdVE7hWfoOcpRZUhCU5UwoewxY7G/Hv?=
 =?us-ascii?Q?p3oIgSLSwzVab0DZ+/cKnH4GWRcRM+vkgby4Mkfu5YIM6ZblgcGUiTAaxtoG?=
 =?us-ascii?Q?lNiF+/kxZ4qjKsW6DK8CIT03EVlIKwI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70d75f4-0533-400b-9ce8-08df37243fdf
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 07:54:54.1458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QFDJ4OnqTdhP6UFPNMOjIGJcXoFuQU2qewhGDh48Zr8Lh/PwkfoUxu003c8rmLog9CBopwIk7bPJLLDtsKZ1TB/UTCSEFLKw29pCn7tsNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB9051
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fetch the prebuilt K230 images from the processmission
qemu-machine-images v1.2.0 release archive instead of the
zevorn/k230-boot-assets repository.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
 tests/functional/riscv64/test_k230.py | 90 +++++++++------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

diff --git a/tests/functional/riscv64/test_k230.py b/tests/functional/riscv64/test_k230.py
index 6ccbf2d581..c2a3f44849 100755
--- a/tests/functional/riscv64/test_k230.py
+++ b/tests/functional/riscv64/test_k230.py
@@ -11,96 +11,64 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import Asset, LinuxKernelTest
 from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import skipIfMissingCommands
+from qemu_test import wait_for_console_pattern
 
 
 class K230Machine(LinuxKernelTest):
 
-    ASSET_KERNEL = Asset(
-        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
-         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
-         'yocto/direct-boot/Image'),
-        '3a44970213fa68ad318d308518adfc0bf4bee72ed1b2926f9b468f82ef7d7829')
-    ASSET_DTB = Asset(
-        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
-         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
-         'yocto/direct-boot/k230-canmv.dtb'),
-        '5050240b48ce0988c73eaefa73e4945a40abca503cf488d22a3adf6ef50bbe4c')
-    ASSET_INITRD = Asset(
-        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
-         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
-         'yocto/direct-boot/rootfs.cpio.gz'),
-        '4e1869a99a232ee60324f71f3a9e84a79b03ccabb5b73f8a727c5ff5be5c0914')
-    ASSET_UBOOT = Asset(
-        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
-         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/common/u-boot'),
-        '0915b9a92a7c911846a8cf691866ef14ef050a51d04209f884ae8e9ec33f36d2')
-    ASSET_FW_JUMP = Asset(
-        ('https://raw.githubusercontent.com/zevorn/k230-boot-assets/'
-         'c3c32fb46e8307c5063f13e8f367c98bf9273cd1/'
-         'common/fw_jump.uImage'),
-        'cf7788e470f1d6e8c85491ecdc2705518db1b6af54080e8c7a3464bad0d902b7')
+    # The release archive contains Image, rootfs.cpio.gz, k230-qemu.dtb,
+    # u-boot, fw_jump.uImage, and boot.itb under the images/ directory.
+    ASSET_IMAGES = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.2.0/riscv64-k230-v1.2.0.tar.zst'),
+        'fde65d0542127486078121c1748c7edacfe9d3ca29b5c2bcc93c67485139385c')
+
+    def extract_images(self):
+        archive = self.uncompress(self.ASSET_IMAGES, target='images.tar',
+                                  format='zstd')
+        self.archive_extract(archive, format='tar')
 
     def wait_for_linux_shell(self):
-        self.wait_for_console_pattern('meta-k230 initramfs starting...')
-        self.wait_for_console_pattern('~ #')
+        wait_for_console_pattern(self, 'k230 login:')
+        exec_command_and_wait_for_pattern(self, 'root', '# ')
 
+    @skipIfMissingCommands('zstd')
     def test_k230_direct_boot(self):
         self.set_machine('k230')
-        kernel_path = self.ASSET_KERNEL.fetch()
-        dtb_path = self.ASSET_DTB.fetch()
-        initrd_path = self.ASSET_INITRD.fetch()
+        self.extract_images()
+        kernel_path = self.scratch_file('images', 'Image')
+        dtb_path = self.scratch_file('images', 'k230-qemu.dtb')
+        initrd_path = self.scratch_file('images', 'rootfs.cpio.gz')
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-initrd', initrd_path,
-                         '-append', 'console=ttyS0,115200 earlycon=sbi',
+                         '-append', 'console=ttyS0,115200 '
+                         'earlycon=uart8250,mmio32,0x91400000 cma=0',
                          '-no-reboot')
         self.vm.launch()
         self.wait_for_linux_shell()
 
-    def test_k230_uboot_boot(self):
+    @skipIfMissingCommands('zstd')
+    def test_k230_firmware_boot(self):
         self.set_machine('k230')
-        kernel_path = self.ASSET_KERNEL.fetch()
-        dtb_path = self.ASSET_DTB.fetch()
-        initrd_path = self.ASSET_INITRD.fetch()
-        uboot_path = self.ASSET_UBOOT.fetch()
-        fw_jump_path = self.ASSET_FW_JUMP.fetch()
-        initrd_end = 0x0a100000 + os.path.getsize(initrd_path)
+        self.extract_images()
+        uboot_path = self.scratch_file('images', 'u-boot')
+        boot_itb_path = self.scratch_file('images', 'boot.itb')
 
         self.vm.set_console()
         self.vm.add_args(
             '-bios', uboot_path,
             '-device',
-            f'loader,file={fw_jump_path},addr=0xc100000,force-raw=on',
-            '-device',
-            f'loader,file={kernel_path},addr=0x8200000,force-raw=on',
-            '-device',
-            f'loader,file={initrd_path},addr=0xa100000,force-raw=on',
-            '-device',
-            f'loader,file={dtb_path},addr=0xa000000,force-raw=on',
+            f'loader,file={boot_itb_path},addr=0xc100000,force-raw=on',
             '-no-reboot')
         self.vm.launch()
 
-        interrupt_interactive_console_until_pattern(self, 'K230#')
-        commands = (
-            'setenv bootargs console=ttyS0,115200 earlycon=sbi',
-            'fdt addr 0xa000000',
-            'fdt resize 8192',
-            'fdt set /chosen linux,initrd-start <0x0 0xa100000>',
-            f'fdt set /chosen linux,initrd-end <0x0 0x{initrd_end:x}>',
-        )
-        for command in commands:
-            exec_command_and_wait_for_pattern(self, command, 'K230#')
-
-        exec_command_and_wait_for_pattern(
-            self, 'bootm 0xc100000 - 0xa000000',
-            'Starting kernel ...', failure_message='ERROR')
+        wait_for_console_pattern(self, 'Starting kernel ...')
         self.wait_for_linux_shell()
 
 
-- 
2.56.0


