Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214A8C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tdC-0000ow-LB; Fri, 11 Sep 2026 01:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc3-000096-Lg; Fri, 11 Sep 2026 01:15:48 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tbz-0005jL-KF; Fri, 11 Sep 2026 01:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iusu3/toJ/LxivgO7QZP8ahzaax6gRLwcEkHUMFwHzn8nEgI4OjVbcmwHC8LegJimvhz2h3yKuXA3zVVRPyoSv8Nbe/0+OlhO38iV6vOzuc8qo1NXLvaM5gkM2SreHwa1u52FRxVNL3pU99E5prhA0+Ibc4laH+SmbheZDvzLX8HbJn+ivdKyIOab1fNbfjQ8GI4M0dRbz52l0nput+GoxbdYA4r8zeWtDCxLqTi0phinJUXNCiPAAjhhra2lPv92ZY0m+qLi+hALXs8LHKOofuRnU/ly6ctrUiPKS6smKJpZtW7Y5epURSUKFuHYVOIWXEJ+Pv08ENGwqeh9uBOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A32sha5WP3PIInBQaMsB4FdC2rQZ9N+00i4f7q2SKeM=;
 b=dhXva6jAmz0UFh17wgkpZ8rrTQV/BqrSkCPGl7+stNO5Jv7T/PurV3n3nvDPja8oErZ9TQbXh2kBXOwQpbv2T5eofe1M3f0kwgGLZdG+zS9aLFCM7Owc+IW6mZpFSXvlSQAYmW+J85nSbmdWXPCAsnDfF//aOTidlNQssR7jGq83B4aGobIwpvygbr7LrHT8V8JfKqauFLKXDkZZUh5yUu60llDOvonDdYWv1eGcH0u/2cMvgwBWvLTC2ChJ7gx0Nh5CT0broZFJEnGiUjkzGgzG8p+vL6PF4qrwlJ0wEWkhDmeqYOAKM3eqimZgIwBet21n0dN0xi4AWalVNAprnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A32sha5WP3PIInBQaMsB4FdC2rQZ9N+00i4f7q2SKeM=;
 b=XaQrjx4EGMetTLBukk9Mvp698haMfL1bGC9VzGbw6kT0FQGysyr2wfDaIybnr1z/lN5ZlEuy3TMSxbsGILV/u8I/V8sc3oX928qPgwvgtkwuxAuy+XuZIjRDDOa0oI4/lR2UAo6/mulF0/GdnntqxJ3FeKvkGdV0EYfmhxG4KA9JNhho1pYyWqxIc3kDtxKypl2APPwnz2U07OiKFuwHq5pkEvEZmsTaCAL1Zdwohcb2YwReS0w5IFrfm6w+OEyEw1zW/le2UE0x3D7ChVb8xjaN5K8EyOtKHbrYU4MJx/1HGJ01HwWB55mYb949bGFkih+p4GEqgGSWvcRKSrV/6Q==
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by PH0PR18MB3815.namprd18.prod.outlook.com (2603:10b6:510:22::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:15:38 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::90) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:37 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 9CFFF40BFE17;
 Thu, 10 Sep 2026 22:15:35 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 12/13] docs/system/arm: Document Axiado boards
Date: Thu, 10 Sep 2026 22:15:31 -0700
Message-Id: <20260911051532.2378501-13-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH0PR18MB3815:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 958f4fa2-6859-4ac0-977a-08df0fc3b714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|13003099007|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 1Zvx2iBNZYBg6C+GS90CchQP8gDbirqRrtokcN8d3DJ68g4JoPFBzTiHFWI22KFqdbQOYwg3LDOn/iD6AiMylyIEXkcmv9TiMdmC1IvPD9axIiQRmeVbeoJ1Uji9gNZ0tNDgz71x5SBs5d222P8A+OSCfx5/cxXN0tlqSii1QVqmb0St7h1PL5GwKK/s1rDr8E5CidAzNlnIh3TxntreilN0/GijupXg1+dReGhtpafFz/7xfpQIJUxNonshNEZ8sQnQJqyAHyM6qKjweBLPxZCipj7/BlnE6ha0HNpf1Iz0+ZHvQQL6+U/CagHDUhpFNhGCtGTCq8HL2E/I2+9glAbR5wCoi+LzT/7NIS1iZMzcb2sENlaKckLGc7ENp0n5iUdwkrTFa4vumyxcxVwK64i3h8sQkUfxpas3/AJecgAE0OJa6i55PsDBRjvMcUSulgQaWF+oGS0H/laU+I59H8BEVm6NXX2YGNBn2F2m/gWFIJROhm6CFhQDWMJnLKpR46GPbHk2LrTFUbTzl1X9dkXwzuc5+l0l8dHcOGVXlscDdRRBU4ykGJ3e2Z/bYMjsZtFsLaLZiMvzmkR1dusoOYpaodTZruEH46GxyEP+b4zLtz9hwm7hUNp2BDm00pKMB/MTjEZuLBNz+mzHoEJOYkE1pLGctOPEsWa/48cfbXi3W0MguowwRX8eYDMsyVLcDQni2Y4b8W33/BltulV+1Q==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7uWNhXk9jaMi8qJyfompJzf76sVtXpMLtKO0a/B4LTN9oMx4Gl9zuM6bujj10XSYDUFdUZZjD1uvSyprua7hzdF8vhlTjMy9BeU0ng+tw+3Rhj6y9/vALBbwCrexT07/BzzVeMaxXCFHakyYztE7mys49LisSvtsz3bsK1T6Sj0OqL2lX3/Syq6JXvnrDJ8/wqRaSU6+6KfeGrvIklKdF4s8RKYVrIWyJvmh84bYp6uwFOmFbLxZ/acuq5/StUoSVb5hJo+c5X+vzFNm+/A5UBeG/N+THgVSxWHiPwTxZa6TuFY9GU/5h/YiBaVMThNLAb4D/go0tzhXs0W90jkOyIeLs4yLiAfd8tw7qS9qlNKi9K1Zq35vfxembuwRV7/AdIjnTrZEJ5KAq0OmpjtWvxwuMFzzLl8lKOHwBJi9TRrks83DXv1YXIoONkP8YKi/
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:37.3636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f4fa2-6859-4ac0-977a-08df0fc3b714
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3815
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
index 38317cdd63..d55f259a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1311,6 +1311,7 @@ F: hw/*/axiado*.c
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


