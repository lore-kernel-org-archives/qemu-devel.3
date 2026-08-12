Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A4C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2zc-0008Ef-B1; Wed, 12 Aug 2026 03:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2zb-0008EP-82
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:03:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2zZ-00016S-6Y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:03:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62f7w2190469
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ta5LTNzAZrA
 zJqdRzCKFQ0YzsHuk9SjovfBbe+YZ3q0=; b=X4PTBOYGP4ESKIzJ5oM3ItEXujZ
 8oANQjYqT+qAmmEE1svPURgCA4pn91kDGy9202zAQuHUVB0I6Z869ocCc5z8njsL
 tKz9bTwBNwoxv6eMtRnNJqVaeRnQY02jNKEWSt27MS3wMdbqoh5AJIj7U4OuEVB9
 hETZ7loCL/trQXRizTwwOTu8ypyxLs4TFXv/2fwVAMUycdspkfmwsyFZbVcn/ucl
 OGtpwpiG9NgYpVwCcT89EuBef754efIfOFjuX0NQtTJCgvyftmAwCo3LfL+naCv8
 GnzgN5yXl6zHFt6LRpvS+s4l5AP4UAIHmQqbuoJoeB4GmJVB7yaaAV87axA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g3x8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:03:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c888c687c21so19741a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518181; x=1787122981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ta5LTNzAZrAzJqdRzCKFQ0YzsHuk9SjovfBbe+YZ3q0=;
 b=ZJ7pxAcvhUib5aEnTGloEfbuXDAEApjBr/D6WUsNCoOX0bZPJ7oUH7+2y8Z7jSNvz2
 rYk/k1QsCJt93JqQQTVkdVnWWt77+nPhjhOJ/E5Fj4AOOCqQwSbp/0EVUW0Pm70oyc6d
 zTEOw4kwAM5D0FlzI2Tse25tNDFG/3D+dgu44bJINSupIw3R9iISgUbJJfnSrw5hARdA
 DA2P2+WtFqiNGU8pxG9mqp4NTVliLCn+wi7yhz0fgLYNGD4GLFUnRoKdAvaKQkTpbtQ0
 M9fC4jExHyvuIdYnYlbBwaqZl5b8C4Aa8O+cI8oX2vnHCCc/8jGUr8fSrS5W62VnNP3P
 Y9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518181; x=1787122981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ta5LTNzAZrAzJqdRzCKFQ0YzsHuk9SjovfBbe+YZ3q0=;
 b=q1xDzJjYjDg+Ag0BE9u7tGDyB9ClW5kA//BT/KSENkEkG32PqhbAgdEFpSXJBgXTMw
 epKk6kZMBaQcSW1RIb+g4NsJ+RSq69v3h24jnrQcuaX8scTaO405NiG8H1IFZrIeU6FH
 z9o8+fKG05uumfVP6L7URFO8EXSlTz0elJM/1HNZ+/J7ocDBIEL/SrTyVH/7f9Q1PhSp
 1de5h/ImD65X6bZ5JS70Zx98F2hBQ4kJdKf8k0XL8h+f/dPC0W0N4G+UdlKO7NPhfB4W
 S5xrGPFLDyQneuIQkV4RzoBO+ycpPkHawvjJGE+XKdyfnXJWPUGaFbvDF4ojKMZUS1Zv
 rPug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2XaHDTTxWHK/F7w2ldUuOSij9nYti+dj7RvpE7861jGlgI1VLaJ+gjObCYIo/+yeqRcREqMyJj+cv@nongnu.org
X-Gm-Message-State: AOJu0YxOx6WqE0A4c0s7A67Y8KJEe+xp+LGulyKtsOna2Bn+YOcQbgpY
 ngJKJGgOOxWxpHMZGr5RowQcsRWP/EeZtd4cz903kADm67mzh8K1N0lRKlKMaaOA0uHywML8YU2
 fcOHHGp012cRLrWc8vN81Y1ZqhfRkZakQHgA5fTDmJAdh8WjPB/mWH3n9Rg==
X-Gm-Gg: AR+sD101/SqyPvyxFPYOBH5CSm12dSAAl28oarepHvZezU+xGK1YDPYNpN2UWpqT8D3
 DyXKPSVZ/CFqgEl8X6/Qfdm/wkmCahmSG3K4BzJJcq9YhuN3JqRIIs6u6cFtkt2Mz5QPr/auYyC
 hRy4RzjhRaBALPXO1SlfR7IdwrtCcIXl+d2KHp2gDGw/EquJa83ej5tlphSXYQtKZu7wypIIiBT
 m1T/ORJaYYzD+nuJTDrI/P3l99PCqsysakpzmlQvUhhWjY75jQ8M9ro1/58MQLT9ZTza/kEKGtg
 WPJ4GxDZ7Mbmx3n9OiIVErNWTjonA56cpcoXFClRz9bmNmo/MAaJM/8EFQI9XCCcdQXyN7NN3bi
 o/QvaymfRjKxsocoTvH44PtENjR4FcMIYeNQtgJzAmdfl553LndRi9FU9NHvJ9/ZSbPRDKiikzk
 /Lh0BOOXGKsNfiL1DSEy8fX0EvzMuqjnQ=
X-Received: by 2002:a17:902:ef0c:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d3456ccb29mr26131495ad.2.1786518180986; 
 Wed, 12 Aug 2026 00:03:00 -0700 (PDT)
X-Received: by 2002:a17:902:ef0c:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d3456ccb29mr26131185ad.2.1786518180581; 
 Wed, 12 Aug 2026 00:03:00 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm6796627eec.7.2026.08.12.00.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 00:03:00 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v6 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Wed, 12 Aug 2026 12:31:32 +0530
Message-ID: <20260812070133.3059679-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BdJ51GPllE2GJPjHkhXLTNUaSAKiiC_7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXxQkJRI+NaEKt
 zbJvsfB+h1f4vovOsEfpPgKmycBjLIiHJRW7KgmRHwv/nppGYl+e2AdwfXedSKUsMwGJSkhG/gH
 s+AlvrMJjJxkU4Q1yeTyhF+Nub96yeg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXwOPBoU3bnG/2
 HNmC4JpG1Y2fS9jNsCnh1sk7W9YIFI07lSf9nHdOCu2eRfHfRoqPsFWJopxp8nLf6M95uU3Q4L9
 r2Vz3waLE5D6TZMukqbZa27CTmGhQ7dvPZ9ZEc5oyV1tS0+S9HDRfj4GGYVJeB+B5YDaJr5A4Fq
 UF8RRJeK8WSFHZeV/zWGrozU/ACWh4vwI0SEzwmxYmmq2xhbv0NtFbzaNYOM80zz+j3d1yQ78hY
 +hKvnmVCLs9hFZjV6NitLTmb52nF/xjuwWHceBFEq7PCez8f8kFizABZxtYWnJjDcPn4CSxqyhs
 3/17c+Yy+tr5TmG+lkpsKUS6o6oPP4frE1eucqCReWm9eTqt2IjvlvOPrl+goKhidPoQc021oL6
 PXA07ogIisyc3UMSTE7FjgKYc/rjEceTY/6ECRr1t472iI3vuHhWOMQnwCI0LALDt879T3RV1lu
 GMLh6+d3t9wMFS7Ny4w==
X-Proofpoint-ORIG-GUID: BdJ51GPllE2GJPjHkhXLTNUaSAKiiC_7
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7c1aa5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
system suspend, and system reset paths.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 171 +++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 5871211e89..619a0735fa 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'tuxrun' : 120,
+  'rpmi_virt' : 300,
 }
 
 tests_riscv64_system_quick = [
@@ -15,4 +16,5 @@ tests_riscv64_system_thorough = [
   'boston',
   'sifive_u',
   'tuxrun',
+  'rpmi_virt',
 ]
diff --git a/tests/functional/riscv64/test_rpmi_virt.py b/tests/functional/riscv64/test_rpmi_virt.py
new file mode 100644
index 0000000000..174c2b01a8
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,171 @@
+#!/usr/bin/env python3
+#
+# RISC-V virt RPMI Linux guest integration tests
+#
+# Copyright (c) 2026 Qualcomm Technologies, Inc.
+#
+# Author:
+#  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from pathlib import Path
+import subprocess
+import time
+
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import get_qemu_img
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvVirtRpmiGuestTest(QemuSystemTest):
+    """Boot Linux and exercise RPMI-backed services through guest APIs.
+
+    This test intentionally keeps guest artifacts external. Set:
+
+      QEMU_TEST_RPMI_OPENSBI=/path/to/fw_jump.bin
+      QEMU_TEST_RPMI_KERNEL=/path/to/Image
+      QEMU_TEST_RPMI_ROOTFS=/path/to/rootfs.ext4
+
+    Exact RPMI packet command-ID coverage remains in riscv-rpmi qtests. This
+    functional test verifies Linux/OpenSBI integration paths visible from a
+    real guest without adding probe hooks to production RPMI sources.
+    """
+
+    timeout = 360
+    PROMPT = 'root@tuxtest:~#'
+
+    def _require_path(self, env_name):
+        value = os.getenv(env_name)
+        if not value:
+            self.skipTest(f'{env_name} is required')
+        path = Path(value)
+        if not path.exists():
+            self.skipTest(f'{env_name} does not exist: {path}')
+        return path
+
+    def setUp(self):
+        super().setUp()
+        self.opensbi = self._require_path('QEMU_TEST_RPMI_OPENSBI')
+        self.kernel = self._require_path('QEMU_TEST_RPMI_KERNEL')
+        self.rootfs = self._require_path('QEMU_TEST_RPMI_ROOTFS')
+        self.qemu_img = get_qemu_img(self)
+
+    def _create_rootfs_overlay(self):
+        overlay = Path(self.scratch_file('rootfs.qcow2'))
+        subprocess.run([
+            self.qemu_img, 'create', '-q', '-f', 'qcow2', '-F', 'raw',
+            '-b', str(self.rootfs), str(overlay),
+        ], check=True)
+        return overlay
+
+    def _boot_guest(self, smp=4):
+        self.set_machine('virt')
+        self.machine = 'virt,rpmi=on,aia=aplic-imsic'
+        rootfs_overlay = self._create_rootfs_overlay()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            '-cpu', 'rv64',
+            '-smp', str(smp),
+            '-m', '1G',
+            '-bios', str(self.opensbi),
+            '-kernel', str(self.kernel),
+            '-append', 'printk.time=0 root=/dev/vda rw console=ttyS0 '
+                       'earlycon=sbi loglevel=8 no_console_suspend',
+            '-blockdev', 'driver=qcow2,file.driver=file,'
+                         f'file.filename={rootfs_overlay},node-name=hd0',
+            '-device', 'virtio-blk-device,drive=hd0',
+        )
+        self.vm.launch()
+
+    def _expect_rpmi_firmware_and_linux(self):
+        patterns = [
+            'Platform HSM Device         : rpmi-hsm',
+            'Platform Suspend Device     : rpmi-system-suspend',
+            'Standard SBI Extensions',
+            'susp',
+            'tuxtest login:',
+        ]
+        for pattern in patterns:
+            wait_for_console_pattern(self, pattern)
+        exec_command_and_wait_for_pattern(self, 'root', self.PROMPT)
+
+    def _run_marker_command(self, command, marker, failure_marker=None):
+        out = exec_command_and_wait_for_pattern(self, command, marker,
+                                                failure_message=failure_marker)
+        self.assertIn(marker.encode(), out)
+        return out
+
+    def _validate_hsm_boot_start(self, online_cpus):
+        self._run_marker_command(
+            'echo RPMI_LINUX_HSM_START_BEGIN; '
+            'cat /sys/devices/system/cpu/present; '
+            'online=$(cat /sys/devices/system/cpu/online); '
+            'echo "$online"; '
+            f'if [ "$online" = "{online_cpus}" ]; '
+            'then echo RPMI_LINUX_HSM_START_PASS; '
+            'else echo RPMI_LINUX_HSM_START_FAIL; fi',
+            'RPMI_LINUX_HSM_START_PASS', 'RPMI_LINUX_HSM_START_FAIL')
+
+    def _validate_hsm_stop(self):
+        self._run_marker_command(
+            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
+            'if [ -w /sys/devices/system/cpu/cpu1/online ]; then '
+            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ] && '
+            'echo RPMI_LINUX_HSM_STOP_PASS || echo RPMI_LINUX_HSM_STOP_FAIL; '
+            'else echo RPMI_LINUX_HSM_STOP_FAIL; fi',
+            'RPMI_LINUX_HSM_STOP_PASS', 'RPMI_LINUX_HSM_STOP_FAIL')
+
+    def _validate_system_suspend(self):
+        exec_command(
+            self,
+            'echo RPMI_LINUX_SUSPEND_BEGIN; '
+            'if grep -qw mem /sys/power/state; then '
+            'echo mem > /sys/power/state; '
+            'else echo RPMI_LINUX_SUSPEND_FAIL; fi')
+        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
+        wait_for_console_pattern(self, 'PM: suspend entry')
+        self.vm.event_wait('SUSPEND', 10)
+        self.vm.qmp('system_wakeup')
+        self.vm.event_wait('WAKEUP', 10)
+        wait_for_console_pattern(self, 'PM: suspend exit')
+        wait_for_console_pattern(self, self.PROMPT)
+        self._run_marker_command(
+            'marker=RPMI_LINUX_WAKEUP; echo ${marker}_PASS',
+            'RPMI_LINUX_WAKEUP_PASS')
+
+    def _validate_reset_poweroff(self):
+        exec_command(self, 'echo RPMI_LINUX_RESET_POWEROFF_BEGIN; poweroff -f')
+        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_POWEROFF_BEGIN')
+        wait_for_console_pattern(self, 'reboot: Power down')
+        self.vm.wait()
+
+    def test_linux_guest_service_enumeration(self):
+        self._boot_guest(smp=4)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-3')
+
+    def test_linux_guest_hsm_stop(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        self._validate_hsm_stop()
+
+    def test_linux_guest_suspend(self):
+        self._boot_guest(smp=1)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_system_suspend()
+
+    def test_linux_guest_reset_poweroff(self):
+        self._boot_guest(smp=1)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_reset_poweroff()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


