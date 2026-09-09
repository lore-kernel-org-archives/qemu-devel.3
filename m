Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E842C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyG-000446-Dg; Wed, 09 Sep 2026 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyF-00042n-04; Wed, 09 Sep 2026 06:56:03 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004G2-S0; Wed, 09 Sep 2026 06:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBjr3+gZ1OXpte50OTKXl+A98idIqDQsqFhoUaf6U2dLwEDE0ThL4Ra6SEgFQD5dcEpBzLcS2jx05fjW5UUg9YtnSJxZb9V964iP9Uc/x9hVx4/vP6FiHqlEe17JDyQ5HGAVdOrLBygf7qkNl0FhhLDYT1ePB6ucH07K0y4xy11wSE7OUd9c9/C6WYywtP32fiNY/TaIX/Afh1wuYz6I+uhMt2w36xFE9RwRN7wkJuxx5/qpQkjyo+7saSpFcC4BViI9DgsMvwFEglyRaJDQPtGs80dAsg5bBvBu8mZdu7MGP32fNGb/OepiqWcCovedmMaDYYjEb+1X2kFmnLuI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrugOcEFdPTH/aJFd2JczSiputl3RbDTjwVzQkg9U1A=;
 b=nXRcenzSx9oD5yA3Ta3tqJxsX9EqgbyM1Qzf1m8OjQWJ4CNHQGgElewTusnmd8NMLH6CGFCq4dEDCqaIUB2ZtWbc9igjq28HO6UL3bpnPsd4Qb56zRLApPL0AbhoAzidupULBTOfJiRSxAPfske08tbS7lQengO3TZ6jgPls4LIUl9L+gqSFZjTB1C7iZjQwpWjpi+c6tH+Gd9jT1UQyfXySUeDA0ekUXnvcOfyNUWqtsDGPWx0vwpRKbVLGDskT05PZtTcEmTVD4iQoOhxY1+YvsaGFjU1mqLijyBi+f2TCp714ka0XXMiH0f5ti+PM0FI5XmSsa746A6BOpFEbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrugOcEFdPTH/aJFd2JczSiputl3RbDTjwVzQkg9U1A=;
 b=X550GkFn9UYh129tXHGyXID9dNEoJFVI7jUlvlSVBaLAVTjfuLpElDNcg/5mYuXdl8xaS8T82e7GCMfhc8cC5FdyicJ8vVnMKfrG1UYF5w7kA9Czhkgz5wgBoNSg93gavh+tO3SGaMfTkyW7rvB3TEnEpbyD8/wttC6Au5w1GlIXZEIuQewuCbUAm8RfNDdc0Bx6a7H4VxoEkg6hgS/r0y5KU2RYQsBSGjDYFs7m3IHDFud7KsKFNOorC3HC8FsyVWgh0v1tg0m4nqk0FjNtWb9oviKvCU071gPLPF5SygNWs+iDPnGApxz5VjF4VIaD+D18rMxwez7z5gMvMD/6xA==
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by CO6PR18MB3908.namprd18.prod.outlook.com (2603:10b6:5:352::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:55:51 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::93) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 10:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:50 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 05F3C40BFE16;
 Wed,  9 Sep 2026 03:55:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 11/12] docs/system/arm: Document Axiado boards
Date: Wed,  9 Sep 2026 03:55:38 -0700
Message-Id: <20260909105543.1478008-12-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|CO6PR18MB3908:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2dce7048-a27b-48f1-ec0e-08df0e60e9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: eZdlqmQjVAvYj2a3aiX4A2DVAlTlgy0ubwQAjJWV79dBiQUAn78AyXLL07fjuONV1G7HniE/lk3egnFEq/1DEPfaP+oiURm9EYbo7mukKkMQO+eFiPdbviOl2yiG65dSgMxAC6AzjsJKdp3LFrU9egbkOSzQgnRIgSWTmaqXtW9K20aULP/EoMMNw0WwqjEz1uhVAIIlXL20xp41KJglj8D3/wwGdPPLMI0mMPrn794mdqDwKv/qT+xX8HK0MrJVtX04GGU7Sf0qSsumb5ktv5/3a0wv2q4uMeBg38gcbqIm3PUoaOsxWD8Mn/MMHI+8Neq2b0XZ+3DcL+qwui39SfzOX4yM8zkq4M9bzu2USn7cCbvgm6AR1sFtpG8pXRv5Odk1eH8PRwuPy4loHZmm7+D03viMHpq7A0WeoTiBiWf3qinZxW9Ev/U3IJm/qhQv1VWOs/3drD45dUg3ZIHCBm18s2XirBU7qP8SEa3BFqdcwsUk6rIdmCuOMxS+RFpIRiv1vOzFDmXM0YRt6yNOau7PrcVZDkf9V4IuBy0CeqocBGJGstFWjfPLOoFVYnryd4blz42pZKg9sMdUtlaZNzCTU8rVJ0/I6Q2XFqwh/syw70nDKkLOe3zxMNEW3DiQ9pMqUPVC76poYacQRJBCG/sD5a0JJocRylilcQrxwK76WVYQ5GbM31lR/JFonrCF4MM7yttadht9uY/K1nXzNQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cVA9YiM9gif2rNN1zDxEVDdFYSS0h1fa7OZVbUGs2KKwZC+lHuA64b+JmVMx+3skqMlbOvE6byKreaFTyH44Gfu6403qOkr49rOLCxUusERtjJiJdvOFZF6JgKkOolADLNtw+R0fidMirrAxh6dvwCipW96WoFFKtOHi+WYmRUIplymdpgZltfqW81Xbqc+QcutiZTtYAdfcyTFr9Rg8KLAX6++2F2oIrfk2J6BF8h5B1ZRJp6jNGiTxTP3xHqY+UXj/0SEvlGJClvlwn2NniHIVzsN+mmWDEdIQUGGU4TEBuk208EPDoX/JWqoo+rgpAt/Dbq5kHHd5/wa1S3Ub4S2I8FSNTH3F8D8paIaM7cuZ4x8MB0TA3vl6FIgBLY8x95p8N0HgNhMo/l48jSHzC6wSdJXsqDzzOX1trBUd/qWuanaFG8kwnU/XYmuBFsvq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:50.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dce7048-a27b-48f1-ec0e-08df0e60e9bc
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3908
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                |   1 +
 docs/system/arm/axiado.rst | 128 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 docs/system/arm/axiado.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index deddcc4eed..4cf9831440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,7 @@ F: hw/*/axiado*.c
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
index 260cd7e4d6..1b038b41de 100644
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


