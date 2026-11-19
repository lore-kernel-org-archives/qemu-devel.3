Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE118606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=XABZ9C1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN9-0004aJ-VZ; Thu, 19 Nov 2026 02:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLd-00033v-C6; Thu, 19 Nov 2026 02:14:22 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLX-0004LM-Hv; Thu, 19 Nov 2026 02:14:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIBioe7PowVY9wtPdbkJX7qWNucwO7UoUri3F/zaRDDYpbcAKEU7r5ectc7qvf0HQ1BoYX4FU8xb7y0zGySmEOFfPh0ibbG6Ym9AriVsLv3heFLiDQfsnXKl0EN66GKptOzrucjPJCaoSwNxUsSp0tr2bKvAE9B6+D2NRMno1ijYwh9L+ylg3OTzH64qQAkE2r8SU6HpqaCDMOgKyY+1OOOX99w6UMBo6LNzlNg0N78ajePD93baXK8GYM5SMCM07fuvpseG9HZyGAS0mrRdqJjxoVmvhEXy92woolfnU7BT2I93tQDjxwvhEy25wow8yJsnUMZcZpCIv5GzmLNsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHhluVH6j6S0eo2IiO7izXZjcbE0/fpub3EnhAI6Ugw=;
 b=uii7IprFAlpMrS3UXsy9R2/DHcMFEAwumbg37l2902njqZwrmaUGwuTNvoxMYog/K1HtMs80uxmmMOnKE0LmhIRB+iBir0zGlOLO3QxUggQGjNRU9O6FFNaTRIfEXPBzRYnyxT+fGqpc2lKBk5OQuVaWJlUhB35z7+DHPsF4tCX5RkDUg1DUHP3DFwEn4DbgFkut+alG40ZTuaiIP72RmS+jkjgp6emCLETJArbNimLGZjkz5bwmcZrePwePZJWcRzd7M0n6LuY3Z/kLf6LQgcYOxRv2xH3DOZJz+JNWlEy75zev/h2FK4MVV41TplugIEEONoOluKExXgD9gxOa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHhluVH6j6S0eo2IiO7izXZjcbE0/fpub3EnhAI6Ugw=;
 b=XABZ9C1FndjuYLdRGfe4djENXEZn21Mtf5/zCBGBZXbtl2SA71CwDm6nOoGSqKROjI6NEwXLcMTrOpvI+atPbq76sTanGIwiR5V1iYPgPBkwakApSLBc2ZkpS2EoJK6MzdTakRt1jDoKrvKmtif/elqX9g1RoUwnPX8jpiHH8mDavVlRxBe265E0SBhoY03GRBE5vgcRODruXrV42K6anqNY6hLTiHP6JshIoR0980R5Q0ad2o7ShN1kAR71wCXy4RihYljImLnLHACE2nQxb/cl8vbvPR5qWfEo40ytL/WIEqvKCbZpL4BYWW6d0gkBB1LwRPrrqhCKMVTrBdaR2g==
Received: from DS2PEPF00004568.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50c) by DS3PR18MB482736.namprd18.prod.outlook.com
 (2603:10b6:8:438::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:03 +0000
Received: from DSM2EPF00000010.namprd02.prod.outlook.com
 (2603:10b6:f:fc00::20a) by DS2PEPF00004568.outlook.office365.com
 (2603:10b6:f:fc00::50c) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Thu, 19
 Nov 2026 07:14:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DSM2EPF00000010.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 19 Nov 2026 07:14:02 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 049B440BFE17;
 Wed, 18 Nov 2026 23:14:00 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 12/13] docs/system/arm: Document Axiado boards
Date: Wed, 18 Nov 2026 23:13:52 -0800
Message-Id: <20261119071355.3520249-13-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSM2EPF00000010:EE_|DS3PR18MB482736:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7d3a14e-f12f-406b-c421-08df460cb0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|261009223027099003|18002099003|13003099007|260925022911599003|260925021311599003|56012099006|260925021911599003|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6sG2VWeC6Ulhm1DaEiYjHRMtXEU/JVE6vaHOy8gj3fGYu3n26z/HRz9ydgPIdS5oIX9DyclOeOVdjMdRUtJfmFmafB0hplC6QdjjiRD7SS8PhOUTTUWTTj7NXyX/7es3LOFkHOd2f1NOMpXPIYMddISyHLlh7+TW8CR3XNt5Hxwcd7M+O55utLxENVVSaI+sznzRap2+AXOsbW/ayy+mdVKezS62Z743GaDV04piCZuNBRAH8HKTeKG6Q0KU8LeaEaf9kIo08R4OPemN0yEOCN54PvRHPxu65opOyxXkfG1/sGBn0XlmdN3tcXD0/tG8/VIIeTsNOA+kJJza3+uoC6VxOv8Zr+GTKvHCf/wJEW6MyyEU9s3jqf0ugDTXa1KceKeu99Qi8iZ7yIBZWwWidsAlH64l6tF/r9a7L/xXOC5AM2GOIek1V0u8XR+hCfkwDAMbnPWHSs1pxvFxhs9xmG0LSnmmF1GtU7d9Gxk9oVLCZYG8acIo4363/xCLGiLWeAR4As7FprOWctp2replsdQCZzvejERSuq64wvOBg9MZ6uka2V1hp4F03jIvwpu38xx+v+7JH8yfB2T6ETtz4sWh+Yhpd86dQFu57sQIs1QOiIhnG0/0GC4kZOnqFFv2c/3rIa+mzeUl6mgJzBqhHrC6/l4plJBDzIsRR+Y2BPVyHBfwfEqXAirmrgmSvlBowFi7upnPSxRvz3qGcin+EQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(261009223027099003)(18002099003)(13003099007)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ulyLgG8D7VRTeLQogujbwiCuQ3hs8rnXWhczk5zrar1aqfPFNBKB2FKZkKLhL5fKigp1gbMFMVYfa09DIRpzggh/vnhZoGQep5sSyFsjY/+S7kmfJ6hKFcXLaQCgzkXsQxg6dpDTOfrLc1Lbox8yr/rl5HVBf8Ja3NtnWHACe2zuhd1/f1XrOX+OzU6JxU0T/Fqt8pk/H2+EvdlNekqb41jgAtD13ys/xf94Q8mosYnS12cpS9+8LhKZvPwZNa9CQof7d1KjZeabTb2wv8YGLy4gg0MpI4dorKMS85CXvxL9bocssZjbaQvMaIT7ZDt+QfftjOwodeiNe3l60Ao3gLY9z9z8igezp/fuOOWKreBCq+iuNCVHQGmoJE/LM8lmzaCgpmB/IfWHRCrycqjWG8lnoR8TEeh3z6CZurnWj/Ht9uvEUAhX3IY44vvYe+U
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:14:02.5127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d3a14e-f12f-406b-c421-08df460cb0a8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DSM2EPF00000010.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR18MB482736
Received-SPF: pass client-ip=2a01:111:f403:c007::2;
 envelope-from=kchiu@axiado.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 MAINTAINERS                |   1 +
 docs/system/arm/axiado.rst | 128 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 docs/system/arm/axiado.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e5f37262cf..53e15069ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1333,6 +1333,7 @@ F: hw/*/axiado*.c
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


