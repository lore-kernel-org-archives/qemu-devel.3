Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26107C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i8b-0004DQ-DR; Wed, 02 Sep 2026 06:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8Y-00046o-0r; Wed, 02 Sep 2026 06:24:10 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i8W-00073z-0g; Wed, 02 Sep 2026 06:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbNri2SgJgFacZ634IoPS9LLjTSaNRXpY2/Aze2UJ2kJfWUc1+6VqGDNH4Wzgd5LQAd1+z2uemJ3f/QSYnLDH+0/RvF/OivUsDnPY2u4Fwn1J5nvapB89B9QPzkgXEmG3dkCSKTCXEs/GQriyf1rth4Ze1NaCp/5mtpsUA+yNdmTUOp9UxOKEVTlSbiWfjc/pkTG7xRZOjJJwwJi/tDXGXbkN7Fm4kiyaOSmsAp5l8yc9Y8p7blwR9rSzE9SBe6Z1O1AAv+iR0DeiFDOKcVBgSuIqoxeHcYK2I4DGk8w8APWO+ln43x89jAGBC9rrLkQ5iiJXu2gVcvVSFDwu/pnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq38r3dev09hPmPbQeKEQcmm1XmLPKG4paT81CIfM8Q=;
 b=faOOzDX290xSLS4O4xawKdb0nBIjf9HQDB+VoM7tLSI8BGL16ru76WDz6BT2gMvH20P72kBhVzPxa/7QkjMaMd56KCS1/hgtX3zm/e0Ka52/TifHODSU+M266o/1pP64sTeVOxwoTcf/NCCqsHbAQ5lxlvP+yZ/wYgADL76aYqqKzQ+4wa6DGlQVa1CHQH80PlLoyJKqhEutvfubzBer2ba8NhndYctxkhAlx4j4m/jNNfyTIoht226i8RtdzxZrjs9iLau1GB/uliic2kGNLrbw2vKPgN6/wrAlW/Okjt+Nefg0OhxaZH0CobURwn9O4o7XeiWDMKeiTZQ/WJQZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq38r3dev09hPmPbQeKEQcmm1XmLPKG4paT81CIfM8Q=;
 b=ZzITwnv4fDhvFkORgqMyTjnjPI4r6j6K5ZYLL6LzfDK8fL5NEt+fNan8JWvj2qHsNs91lOaZ7DIFZ2Q8O2eGxJmwhZ3BPfASrBf3yWDf85ZKF37JAOFW4MUU1dm3Pdcjv0aB130W/7/X2BtEX4L5ShRrPoDOB7HG6J/4jRgwzY13GjIKKWuGqWFDliuCWBbJwMk08aLErPFSK/JqBnx1/RgsauaT0QdMNfy0JuXEa9Gh6/0QckA96yoUQaCY+prbT5xEpVjhBgwjCvPOgiPnB0EhTEuxG/hPONPbgi9AVYRL6hclcPiOTPf0tIvObXdbmCXYfCKB+MReLYvEDZTD6Q==
Received: from CH0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:610:11a::9)
 by CO1PR18MB4746.namprd18.prod.outlook.com (2603:10b6:303:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:24:01 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::1a) by CH0PR03CA0332.outlook.office365.com
 (2603:10b6:610:11a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:23:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 59A844186B53;
 Wed,  2 Sep 2026 03:23:59 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 12/13] docs/system/arm: Document Axiado boards
Date: Wed,  2 Sep 2026 03:23:58 -0700
Message-Id: <20260902102358.3039392-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CO1PR18MB4746:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66f0610d-2a72-4a4f-adec-08df08dc4dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|18002099003|13003099007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: gdCc5ddLYI+MNw6bqNb1UukgWNfk42PJt6vwYOFPFJ+FQHjauZH2a8EQEXf4MMkpj5Gb0Y3a8ckLR+9wr4Hz7/Y+d9zJ1vXYU/wc8cV6mLP1fL1q8znuCmdaXhmsBqIysR3UmNS1F5mwJ69iL6/Ufr9LeOaueugXqqQdtC7xNRpAA3LqC4cIxx2rs9/1mGKaYr2V7Ihrnlo7yypFpA0aAeB/4Hjxv5DX9RGhjTQY7rStR6YzcwqF7M0XMXtw1bMgSKJlZF5Mh+PvrH7NfjxxSNzkN5ZIVlB8Fe4CamWUU3fJ3evZMdgTUK5ZwBoNSkidCAAX6kACsgmLtAE+Ul6marBqcqgH0NGqfwtPdHp8HgVsoIwbPzlZsMs1y6TqS7UuHzpdFqlCPG6jk+0KSb+Ac/h2NBC/yfxKfP9KFKT/A6wiHrOcJnbIv72VgIQQ8KUNmz74gMqbF8CLmPrymQ/6q0IkLliM7yA3kuX6LTk8+nKAI+Fv+VK3vt2Mj61Y/0VlvgRYM84WP4H6TIYT48bCYVEZEd5tg9Dnf+QWR0OyxRZNxbV6fsqMCM1i1nJ2/5XIk8xHVdpT490a8iZiz6Mf9DlFl2abKi9xxRwfudAe57Sbc9C5qg4PUqFXk2Yu7/Cir+h7y2x1msKkRkymi2XdbPrd33lryoLPmMGISdMo1ETwWbL6BLB6XRC69XTlef0f3RzKgCFWyqm3yZqrRijb/w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(18002099003)(13003099007)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4UOj+wD65W+dpk6fX+J2CanPSvyvqSWqxUp8E3e0M1asnkoMR1wXQsNaC/qmvXgb6KUO6MBCSO+KChGq66bI1NgZWWkojC2+5Sz07sitCbAbjIP2Ln6Io//livZYGbnMY4ltoFPLBv6N7+GLBUkHsiSj6Plg2HVMNo2R+EYaodBm6V0BjfN3YB+vaRhB1cuYVucd+yJ8eYwMU/v7PNCynOjYseL4d1jVQ9MOYxecZEebqBUUTcItLAg1Aj7eekaba3/QyXElJI6MW+Zr7BSbDqICprKkmMMFRP2QsifileHbQniCnKAcF2eaaP/9IshM9msnaHxSlSJgMDT0HMTpd8t+6pVgRmIaWDLuKRr1K2xteFInM6f2tG7hjWi+4vq9zfbhNc48n0xzxou7SuGa0kIe5XhgNFDK6hi1fzVJ0ehlwg8k63f7HKzOq6QzDSQu
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:23:59.9148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f0610d-2a72-4a4f-adec-08df08dc4dc5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4746
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                |   1 +
 docs/system/arm/axiado.rst | 128 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 docs/system/arm/axiado.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 22c5b984eb..baa2d2efbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1319,6 +1319,7 @@ F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
 F: include/hw/arm/ax3005*.h
 F: include/hw/*/axiado*.h
+F: docs/system/arm/axiado.rst
 
 AVR Machines
 -------------
diff --git a/docs/system/arm/axiado.rst b/docs/system/arm/axiado.rst
new file mode 100644
index 0000000000..bceaa77d83
--- /dev/null
+++ b/docs/system/arm/axiado.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Axiado family boards (``axiado-scm3003``, ``ax3005-evb``)
+================================================================
+
+The Axiado AX3000 and AX3005 are Arm-based system-on-chip devices intended
+to be used as the management and security processor of a server platform,
+in the same role as a traditional Baseboard Management Controller (BMC).
+
+Two machines are modelled:
+
+- ``axiado-scm3003``  Axiado SCM3003 evaluation kit, based on the AX3000
+- ``ax3005-evb``      Axiado AX3005 evaluation board, based on the AX3005
+
+Neither SoC is supported by the upstream Linux kernel or by upstream
+U-Boot, so there is currently no way to build a bootable image for these
+machines from mainline sources. Axiado intends to publish a firmware
+package suitable for QEMU; until then no ready-to-run image is publicly
+available.
+
+Firmware download
+-----------------
+
+Images can be downloaded from the Axiado Forked OpenBMC Github release repository :
+
+    https://github.com/axiado/openbmc/releases
+
+AX3000 (``axiado-scm3003``)
+---------------------------
+
+Supported devices
+~~~~~~~~~~~~~~~~~
+
+ * SMP (4 x Cortex-A53)
+ * GICv3 interrupt controller
+ * Arm generic timers
+ * DRAM
+ * Cadence UARTs
+ * Cadence GPIO controllers
+ * SD/eMMC host controller (SDHCI) with its eMMC PHY register block
+ * Clock/reset controller (PLL) registers polled by the boot firmware
+
+Running
+~~~~~~~
+
+Boot a kernel directly on the SCM3003 evaluation kit, with an eMMC/SD
+image attached to the SD host controller:
+
+.. code-block:: bash
+
+  qemu-system-aarch64 -M axiado-scm3003 -nographic \
+      -kernel Image \
+      -dtb ax3000-scm3003-qemu.dtb \
+      -initrd obmc-phosphor-initramfs-evk-axiado-qemu.cpio.xz \
+      -serial null \
+      -serial null \
+      -serial null \
+      -serial mon:stdio \
+      -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic.qcow2,format=qcow2 \
+      -append "console=ttyPS3,115200 earlycon nr_cpus=1 rootwait root=PARTLABEL=rofs-a"
+
+or boot via u-boot:
+
+.. code-block:: bash
+
+  qemu-system-aarch64 -M axiado-scm3003 -nographic \
+      -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
+      -serial null \
+      -serial null \
+      -serial null \
+      -serial mon:stdio \
+      -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic.qcow2,format=qcow2
+
+AX3005 (``ax3005-evb``)
+-----------------------
+
+Supported devices
+~~~~~~~~~~~~~~~~~
+
+ * SMP (4 x Cortex-A53)
+ * GICv3 interrupt controller
+ * Arm generic timers
+ * DRAM
+ * Cadence UARTs
+ * Cadence GPIO controllers
+ * SD/eMMC host controller (SDHCI) with its eMMC PHY register block
+
+Running
+~~~~~~~
+
+Boot a kernel directly on the AX3005 evaluation board, with an eMMC/SD
+image attached to the SD host controller:
+
+.. code-block:: bash
+
+  qemu-system-aarch64 -M ax3005-evb -nographic \
+      -M ax3005-evb \
+      -kernel Image \
+      -dtb ax3005-evb-qemu.dtb \
+      -initrd obmc-phosphor-initramfs-evk-ax3005-qemu.cpio.xz \
+      -device loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x90000000 \
+      -serial null \
+      -serial null \
+      -serial null \
+      -serial mon:stdio \
+      -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2,format=qcow2 \
+      -append "console=ttyPS3,115200 earlycon nr_cpus=1 root=/dev/ram rw phram.phram=ramrofs,0x90000000,0x6400000"
+
+or boot with ARM TrustZone:
+
+.. code-block:: bash
+
+  qemu-system-aarch64 -nographic \
+      -M ax3005-evb \
+      -device loader,file=bl31.bin,addr=0x88300000 \
+      -device loader,file=tee-raw.bin,addr=0x88400000 \
+      -device loader,file=u-boot.bin,addr=0x80000000 \
+      -device loader,file=fitImage,addr=0x80100000 \
+      -device loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 \
+      -device loader,cpu-num=0,addr=0x88300000 \
+      -device loader,cpu-num=1,addr=0x88300000 \
+      -device loader,cpu-num=2,addr=0x88300000 \
+      -device loader,cpu-num=3,addr=0x88300000 \
+      -serial null \
+      -serial null \
+      -serial null \
+      -serial mon:stdio \
+      -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic.qcow2,format=qcow2
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index e34492402f..27b0634564 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -80,6 +80,7 @@ Board-specific documentation
    arm/versatile
    arm/vexpress
    arm/aspeed
+   arm/axiado
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
    arm/sabrelite
-- 
2.34.1


