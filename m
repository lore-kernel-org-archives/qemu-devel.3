Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D2606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=iu8AhM76
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeNU-0002qj-Pg; Wed, 04 Nov 2026 12:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLI-0001Cc-89; Wed, 04 Nov 2026 12:00:13 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLF-0002XN-Li; Wed, 04 Nov 2026 12:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBlRRMNALaD+VCZo9Ylrv/axP7VJDyLJxNfR7Iu4LqYR58bon6An1dwY58NbODW+9S+zpTDex7YqBqiMD3+l2R6LWkAHZq6ijcxpTGm6aSDGh2K/ydRhvPretHgaljjepsGCOcTBbqC3p6ll/0mrZ3xS9lVu3p/CrgAJztrKJVcxrFB3TEPlEU8s28XD9zVdh2PJyrDNo/Ctf2RbaTgedIcbzQfoMp8NAAUIk+5BobvqmsDBPxS2kfAZYsbWWADcvHz5ffSEtdyjAGyfmcKNZrpWYyfLIJgVlMiGdp7q6n339K+lpCsbPNZWSq2mFAGDJyEpYcOHDBQanaC6GzyDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erg9iBoPlKPxoQdftl87QP+gMFiHU/rnH4iIjuegXuw=;
 b=ZwWRnNZhEJXpe6Fh4X3AjgUX7pUVE5sW8avgUVzPFk0BQYYWlq2zn8otVqs69dByQVaJGjYbmsws6V0530jiW+rFICZAkfGsJnybDtXHiaJ/kLmgMHDsuBRNAbv7J3RKfVm9moqB+AWrneEUDt/zwCtNrRH9jp8URPJl44qrHWRotiCtMp4hBY7/3OJRx7wg1WPpG2hrxG4ilK2xuMqIfiZRSoYZ4ARjkHiKj5wNAhriA0LwYmIKAF5z/fi7TYQGGEYTvxt3NK/KHn9bxMKH0c4TXEiWFQDPGTuXUs8tDuTKPsuXrIAoUM3dGK8zysYsqj6vvKKJc536sCbSE//voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Erg9iBoPlKPxoQdftl87QP+gMFiHU/rnH4iIjuegXuw=;
 b=iu8AhM765R4H2zLaTxfw083QNO0w4oJPKd3CeuhthATP+sk0lNOZizhlqwcTxTF0C4rSLBybVY7bVFccEfW2l3aGlRUzH1FxSOc752LekS1n/0hEMu+nyoNrz06sJO/sVcQxZOu/j77R4/ZSKaDkvzdUBI7pSgPWanI9uneoFmVzOJjO/Er27NrG8fAIreNHotl2ZxmUtgO2oehBLUnkv9JX7Ttg7K1Ujc72/gPlNYqnI1aIyYrMFrhFZ7VJKyI6JjTmQGPyCq59WezY1jauKIqBkPtm5+5aWpGQIafFcZ0nh4++mbx1+lY2gSItp12h+ZQyBmZcqQspwAHNW3EGJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KL1PR02MB6355.apcprd02.prod.outlook.com (2603:1096:820:cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:59 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 10/10] tests/functional/arm: Add MCIMX6UL-EVK boot tests
Date: Thu,  5 Nov 2026 00:59:22 +0800
Message-ID: <20261104165927.678833-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KL1PR02MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f30587-e583-4979-8732-08df3a950ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|260925021911599003|260925021311599003|260925022911599003|56012099006|261022115727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: OcLAhLWgI5o4weSzIaVVVVbks6uQ093FO+x72miPYuuI/JyGJfaI5BZ7ACTmEzxVbKDH9ZSkIsnh2BY5a+7xn8FmFFKxuBzmhquPMMo24J3BowzWe2EBfj0emEzCfEJy2sM9V6N5oZh59T1j5aMKuH/DX/1FicSMd7sCz1VpzpAzVEPDPWCVyGk4JaGPWWoLxGJRYcvyj0wS2LRXmQjIqA4v/GHUFFMy2YfsO/e4O20VvKQJ/CCc09xrN2z0Ak4Ab/Gu31Xr2SUepR3mmOKn9AFpBi5Jtel5dr5YtAChrjYBn7ZdsLqFXCrM7rzVBz+deoL/xt8BL0G8e6+mXadoBcMmkKKUu6oZeMlBh4AgIXGY+QJk1Lvle3aZSt22jXCXppvnEMFT9fsRhEBqxqVd4HmY8qNd9t7Tr1cvRQSGo5J9L8ptEfArv6AVnvIyeMT5u013Egpllt2MZdKw76BFFqcy9BqrcW0xq8oVjOMO17nignxLRJlSALWxnUcSXnjx2Yk/jDTt/ZLhKnlY4Yp2sB7WhptPQdW+ZCQtDk5tuIzFFURjwWS6C7oOYXUu4ka99Ly0QEy/0shgu2nLOo2dEqPVL65TGLdKSSBLVB0wlBotioE/DN90v4OfVuNYQZwbJ3u4fF98UErm9P9m74g7XTvbiCME4NcQqVCesugKuTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(261022115727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+gnb7NUUzn4Gl1TuReaKh9agbFtxRg580HqTypUid+sp8PN4BYWACW/kx2+?=
 =?us-ascii?Q?IwiTMEDUHULa3LNMTofrqA2I+Zu81JPXQB174mtwSwv/87uhF+/RFcLd9cwk?=
 =?us-ascii?Q?WdFa5PYEN25vWIv2lTur8/FZcaJ6XA7WlzPELKP8nKR62csnx/u0gRKCI5V1?=
 =?us-ascii?Q?lgVX/8Nzk7TvXjV7MNsRUSip6Ayd2rbjrV4fmcnCGFPmEImlr8cldDWVaXr4?=
 =?us-ascii?Q?iB9+9TCBcu8oNhqyiXxsySCa2GTtJp01ut38+HJu8s/Y1gMG3Q7dB0vJHB4G?=
 =?us-ascii?Q?Eo8OoVvoeD7V+EfuDqKR7IpVe2E619a/VCScDk3QDG6jZ7gtaTofBjNk22Ih?=
 =?us-ascii?Q?EbpJitpSzG39YJYkP2kYLpynBU685lAhuUkOU96r4gLDTVyAxHNyZ5SF/2Oq?=
 =?us-ascii?Q?PKQOhKr5nTP/Bb2afhWWEPUuf+tfl4Tf46s3FzGpZfVb16vG8L5MIP8B5zS1?=
 =?us-ascii?Q?t0Ejn0dB2f0QTHLWQMmQeIisPZF0GNQCDny318zV7pV0RZLS0P2f13JmCYX5?=
 =?us-ascii?Q?C0g6Fk3lvZURXlTsGEAK4QN5G5FEmazYMc1649KPcvpVmifBWOs/3MGlii8l?=
 =?us-ascii?Q?yEUJ1GAt0N18HUscAfN0JMAZbepKkq+WSla9qG+pWrkjsP/6p9T7pCdX4o4t?=
 =?us-ascii?Q?+2jOmBDdSu4TPj+mR/Qizxu+86F+3+ng71I5y8KlIz0qH/zSK0iL2ZRSJkrQ?=
 =?us-ascii?Q?A3Y2dNKirfYjX/LRdi5gEirwrYyzpqrmgdA0yKi9OhBZWF+a+H3MnspRQgKi?=
 =?us-ascii?Q?DIyhXX0naLkAuHGIlfjIcST3jnZ3ZM4T626xjOKfQgTftBgsD4LVreQ+7kJl?=
 =?us-ascii?Q?HG2So1ybZomYnU0NxwiPxGHcaJJSU4YFvL7DNwPWmBcpRSWDdi1usXQFZDcn?=
 =?us-ascii?Q?5sFJWkldcK13iF6VM/tW4dESHmN/DtzYZpomVykDBGYAHqVNF8OaPrmubLFQ?=
 =?us-ascii?Q?8M/TgFJtoYqruuHqosIUYPOHhGb8zjE79G/3WkbeNfPf037Jo2JuG4uceb9n?=
 =?us-ascii?Q?2D7U32sqBf5H+ll5UQizjsw5BQGdbt1yLRIgD573v8BowiFLXu/n41yvaJol?=
 =?us-ascii?Q?C092Bof0+/5vuUxlGmmC3E3H3IpEl2iSbubNy3ZzjmEArmWfN6zt0erOtAAI?=
 =?us-ascii?Q?iFz1I7teAlyDA99DUncZLPSOq6vglOYR8VN7I4fn/wqXqPMyDHeiTCnSgzqk?=
 =?us-ascii?Q?qHOIxgUx2ONyAKBBlpwXXhvVFruuulUohNRHeO682+hPO8BNKxhvhLjgQFdn?=
 =?us-ascii?Q?jq9HOPaaCGZUJ+a6p5IKEEPow9yv9yLGmhfKUiBaedL/0VtQym1OqvoUX2Xz?=
 =?us-ascii?Q?6qRQf7iJJPYLnNVZ6pcqMdXaV8OGjnGog2yKyzK8ydBmP6nnHsj74NeL/uXl?=
 =?us-ascii?Q?tE0lMyh5IyfNStTY3KtzCAbvhso0NA5EORFosshXOcclwZMKhM4LSXLNcqck?=
 =?us-ascii?Q?/Oxi12ONUqI+HfqPTo1mWtEmy2+HotWGN3tR/nK0KKclobN3yloYFs4sTsdu?=
 =?us-ascii?Q?9RLtXxdsLSSV2tt2saeuLf/QcyK6mZndIY4VNSq7Ams5EVXzk5w8SktJcv0A?=
 =?us-ascii?Q?KyvduLph8qKxNrQns6sJm5HDuC5SJ1YO/aTINayTaoucKHTnD6bmWm+S2XYO?=
 =?us-ascii?Q?/WQ2/o2jJtqEbPm3KkpT+IvoNCcoAR+30ql8Jk9mc6MSdJyx4K5pS+jXqKaE?=
 =?us-ascii?Q?FHPkoxGx2kuIL9hQIh1f1v+RrpPekROG9aL0G+LUtBUeE3by7uvUw471FR6k?=
 =?us-ascii?Q?tbdq6Nch55kHd6ShtZ4024aMioLJ1PI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f30587-e583-4979-8732-08df3a950ef6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:58.6379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo/ZDLsRyC0YgenlqW8BUE9Nh4fZuCGQNJauYLkGVcZnY1NqXtBm9FGftWXASOfvnZtOimOsjyl3P6Nd4LaqOUxHduD1WBMb1/R1vXrw9QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6355
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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

The MCIMX6UL-EVK machine supports loading U-Boot proper with the
generic loader and booting Linux directly, but neither path has
functional coverage.

Add a versioned Buildroot asset containing U-Boot, a Linux kernel,
the board DTB, and a 128 MiB SD card image. Exercise both boot paths
and verify that they reach the Buildroot login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>

---

Changes in v5:
- Rebase test registration alongside MCIMX7D SABRE coverage

Changes in v4:
- Make the functional test script executable

 MAINTAINERS                               |  1 +
 tests/functional/arm/meson.build          |  2 +
 tests/functional/arm/test_mcimx6ul_evk.py | 69 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx6ul_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 54bf840cef..b3a18cb32e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -940,6 +940,7 @@ F: include/hw/arm/fsl-imx6ul.h
 F: include/hw/display/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
+F: tests/functional/arm/test_mcimx6ul_evk.py
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 72c7afc84a..39263ba83f 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx6ul_evk' : 240,
   'mcimx7d_sabre' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
@@ -62,6 +63,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx6ul_evk',
   'mcimx7d_sabre',
   'microbit',
   'orangepi',
diff --git a/tests/functional/arm/test_mcimx6ul_evk.py b/tests/functional/arm/test_mcimx6ul_evk.py
new file mode 100755
index 0000000000..0b4dcd5a94
--- /dev/null
+++ b/tests/functional/arm/test_mcimx6ul_evk.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the NXP MCIMX6UL-EVK machine
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
+class MCIMX6ULEVKMachine(LinuxKernelTest):
+
+    ASSET_BUILDROOT = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/download/'
+         'v1.0.0/arm-mcimx6ul-evk-v1.0.0.tar.zst'),
+        'a08f2b5dae139cf73cfa601c9df9316356a07a5dc59c74d99f30ebee61c405fb')
+
+    def _prepare_images(self):
+        self.set_machine('mcimx6ul-evk')
+
+        archive_path = self.uncompress(
+            self.ASSET_BUILDROOT,
+            target='arm-mcimx6ul-evk-v1.0.0.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+
+        sdcard_path = self.scratch_file('images', 'sdcard.img')
+        self.vm.set_console()
+        self.vm.add_args(
+            '-m', '512M',
+            '-snapshot',
+            '-drive', f'file={sdcard_path},format=raw,if=sd,index=1',
+            '-no-reboot')
+
+    @skipIfMissingCommands('zstd')
+    def test_uboot_boot(self):
+        self._prepare_images()
+
+        uboot_path = self.scratch_file('images', 'u-boot.bin')
+        self.vm.add_args(
+            '-device', f'loader,file={uboot_path},addr=0x87800000,cpu-num=0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2024.07')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('buildroot login:')
+
+    @skipIfMissingCommands('zstd')
+    def test_linux_boot(self):
+        self._prepare_images()
+
+        self.vm.add_args(
+            '-kernel', self.scratch_file('images', 'zImage'),
+            '-dtb', self.scratch_file('images',
+                                      'imx6ul-14x14-evk.dtb'),
+            '-append',
+            'console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Linux version')
+        self.wait_for_console_pattern('buildroot login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


