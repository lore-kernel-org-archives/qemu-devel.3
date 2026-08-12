Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2FEC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6JP-0000XY-2Z; Wed, 12 Aug 2026 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6JN-0000VB-Vk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6JL-0003av-Tp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9g9gA3453006
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1mrPj3BYgC0
 3OriQkGkLMkfQhbSN5F1fAEDruAygTJk=; b=IurQ+0F+kio9Ohg2l2e0rVGRrJX
 o4EUxqRD6Hqk3lAZAz+wHwuWvVIrOneSItjvBUEpq4R95O3fx9WG1sI78pI7x+Qx
 BcZe/eDrU+vfb3d4+GP4EETadlY3UZRUtZS4C02poFRJkF/qXnRgxDw3eVDHOGcs
 Ha03UoS2vseYKDZV1ldWOukfQveaAx9uXnM6XCbKqpNOlodhbygZ/2ofvPD1FED3
 hiKkx5P7rC7GZWIWQEivSRA3Wyix+hFpx6mm+0Tkf0sRisa15x0h8hSuVE8eBs7P
 nHSmBdWxp3GBAeugNSo5y06jRLVTeLQLnLFsAuTfM46R9LGkRZER/1ASRCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrh6d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cca0ed258cso3016925ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786530940; x=1787135740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1mrPj3BYgC03OriQkGkLMkfQhbSN5F1fAEDruAygTJk=;
 b=F32DSumfhwg7vNslvO5hy5c3Gzf/dh+2CcRlmBaECDaCUlXnMPk12cQmiRmiXBjYvQ
 d8SICvd7YYCSAbnsgR9c9mIgGRHXJB6jYyGDRKCh7QODl0skMYmRbUvLQABnp/JO/eFs
 BVZMV8AH22bGJnc/i5V65kRsBEiYwlAvS5k6FJ08loY7Jm3KMzxzQik9DDoahMy9B/F7
 dhpC7kSMs1EMkGLqhBOaEQEbPCnuOoRVgcPbiy9JcGtImUybNj+46i63Np56dz/7fMFA
 SXzb8rHm0gAlKdy2yaYgruMiGvduGe4UV6Tmofpt6zPGFIBbeme8EzKSB/KokbfjeNXF
 /wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530940; x=1787135740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1mrPj3BYgC03OriQkGkLMkfQhbSN5F1fAEDruAygTJk=;
 b=Lr5drBVAhpiB5zATDkcHgPNBsUDtc2tn6NycUEjjSrRNc/Km8mjzpRmclq2VP/rVMM
 Ya+i2U32GNFsk7Z9F6Y8OkWKFjBKxuCJkrbnz+195SsPuZB+URyXwnPPXmrMjS+V2atP
 N37Ei0IJpLgJh7DJn8j+vdm4DYjVmQfUj/6Wv+Li4nWognsEm29vkWwOF5FWJiEYO9Dq
 cl0VIE8ZTxPEAUYHUGFZgb8M9PkAp/817IaAW36grkv3iu+n2vsgcqb03VPdkD6NcqXy
 rcjUX+0aJ9vKQHmr/jk42ri8Eb3P5Aud2lF9T0kDB4uODTuc3ys3/v4EDqSH5DqFG+0D
 mo0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp1NLuRss2LNvvf3IRTi9tupIOm3odbK6txHbOJxALzm04hXABVsP8m22tGwkOmafsHRyWaIF5VHJH@nongnu.org
X-Gm-Message-State: AOJu0YzmMTkaZJ652pXcT4oZTfKf3XEd7dLJFAVsZlaxdSj+D6TGaf44
 HC73kbMSVXb8M5ZlPOJbpoJk+w0owFxK7sscPZJMIKinb4eEAHIItEJ+JGHXBYl3OZXRgfApFAK
 W7ybhqHSlyZrEyvk1Qm2xYYbazb6IT4pEcfZDmBcnP/eAxQPtYGJBO7ue4Q==
X-Gm-Gg: AR+sD10hj0RT6tPRtOzEcXPj1ncfDDUx/Rh1w6/RtSPRR9ZY0Vs7cnLu6VXPRsgtNPj
 6iVdpWU7OEJsEuetOn3ZZlbL69tDuu15es1G8xbLhCfAC4rCRKb7LsYOgGHEeMJOgXgg1D8P+HM
 RDcON67lKOGaB8wH6LseTQrMjR366h5gA+k58l4R3bYPo7ooO3nDkTquIHxn8Nt2ileFiTE1MSq
 VTby99PDiQue03qZKYBMZjfIZzHqp3kBN03+6HcmYQDyWO71lEgb94uSALTHCXPUarBLUtHkZyz
 moSsgqvqSvlmh1t4lADfTTvkPnPfPjNbi8PzGtKORkHN4ef9eBOjhklx9Kae1ntdmvO2Vb0p9kV
 NpA+FSeSeq6sAbadMvmeDWneviEIrdj0tebDLc6G6+IP5p98NFa5mzQ1SriPsjDTAp0MVkyVG7H
 94ltKmOjocIgpdKyoC+PdhnIXFvKanTb4=
X-Received: by 2002:a17:902:fc8d:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2d345663205mr29877185ad.3.1786530939745; 
 Wed, 12 Aug 2026 03:35:39 -0700 (PDT)
X-Received: by 2002:a17:902:fc8d:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2d345663205mr29876695ad.3.1786530939182; 
 Wed, 12 Aug 2026 03:35:39 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31d6aec3947sm6910326eec.17.2026.08.12.03.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:35:38 -0700 (PDT)
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
Subject: [PATCH v7 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Wed, 12 Aug 2026 16:04:44 +0530
Message-ID: <20260812103445.3451960-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX4KALS4gciWIq
 akK+53iMuRQU84rH0eN66YDo05evf3rPieKIILLvwcQJ6F0SmoKqXURPsNVOoZQgKcJDZENnExF
 bEHZ/jQcDygv/tfUOyfCyxflZrv4x7ChPQp+RrNdb2QplEkMYPTB5H7VZ2G/eh6/naAzKJvK8rm
 XLzaaoGKD1sP1oY+vnQSUwGUeTTzIb37tSJIjpqjJbEM50r2qwKrpc/Zx21hpgdMvtUmfRG116n
 CNyklZsJy2Spoj3lfMmLjXlqyfafuDVw/tfWkJX/FtfVyuTL8a+maImzy2jV2AquQC60bUhSpHS
 4m3aB5lrn4E6t31cHSRb/h37NXW/djBw2eVBJhnXcxKiehxKiprFrtwgkGfJJLc3uC5JgnkJjHV
 X4gGxvwYCyF9JUZjaxRYvYd9cPrCLCeSW7YGz2wBqX8IZOiLY240SSr3ycE60wki/btqxWB2vEF
 EdH979mmcu5/dmiKo3w==
X-Proofpoint-ORIG-GUID: hicPyJk1CMcJkVOtX45T3_2t-_OUe6AE
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c4c7c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=I-e7-QPJdZBCABAvL70A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: hicPyJk1CMcJkVOtX45T3_2t-_OUe6AE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX53/DD5spCqJ0
 RqCQdHihhouwpTAXd+pHZJieg/VBmS/FgmPm7PxstJ7TIemwXf9/I1WR7/+tQ2p6FEXC8Xv3IyY
 YhpEUvhB/b9S0b+iczUlhL1KD8JRq6s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/functional/riscv64/test_rpmi_virt.py | 184 +++++++++++++++++++++
 2 files changed, 186 insertions(+)
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
index 0000000000..831895103c
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,184 @@
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
+            'Platform Reboot Device      : rpmi-system-reset',
+            'Platform Shutdown Device    : rpmi-system-reset',
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
+    def _validate_reset_reboot(self):
+        exec_command(self, 'echo RPMI_LINUX_RESET_REBOOT_BEGIN; reboot -f')
+        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_REBOOT_BEGIN')
+        wait_for_console_pattern(self, 'reboot: Restarting system')
+        wait_for_console_pattern(self, 'OpenSBI')
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
+    def test_linux_guest_reset_reboot(self):
+        self._boot_guest(smp=1)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_reset_reboot()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


