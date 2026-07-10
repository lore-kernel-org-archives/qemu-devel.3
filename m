Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0C6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAF2-00079T-Ga; Fri, 10 Jul 2026 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41b-0002Sh-PR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41Z-0007ri-Ih
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mlxA3721282
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rjxxoo+6u2b
 LA22O+8/iQdDj7+Ze0NliZ003o3atnfc=; b=Hs4QfUhnA3IMkHvhftDELQVhll6
 +bYw1yZ8BLl03rsgcldVYqQWfs5CQG9LIHqqf0T/yXGLeRkP+nH3v/4zh/D0p2eq
 b4+P9Z4//fuIT2BTcG4q3EO3jipxA+3UXkGQ0eEDCakoP8cnz3PSQYBDlV3jOfsu
 NVH2CbubISlFbcYuiPcyh9Ln7udA1MXX7jqPv6vGnMzKytV38bAX7m46iKL6LMnk
 A8yHtCEw5+ohEDyiios6WRbOczGTG4r3Mpbv3FvIWHjeNLi2B6q4W9I7ONMpEQjt
 FF5/STPcAwWVmMLvb3AHyj93zsfLF61zoV8WkNTpVx2TIsyukeRgwBuJarw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9gtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3809ef6efdfso207655a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662221; x=1784267021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=jyePH7O3Cs10a0qhxy4Rz03WJ7yUvcZf52rYN1po4dHS8mHDmmkp9NkltX++y27bXA
 De57iDvEea8cCijEKGQ0XADvvEuQ+XRM+U7BGFqlyHEnji1bm45Doq8QhKyDRJ0JLYET
 rowIl3y4tPrWqVV93aVoQyruk7lcRZC/RaxxJ/hGzximv/1qalRY0EEiBTimU9DmAqkJ
 nwB8pUGet/hNDoEjuk1iWk26RaywByD53KyqqaLvovUWD8D8p/Q5JgFG51GY0wH7dTQI
 MZF4hk5fGGBlwbK+FZa8/onMePL+RS2gWsQalbXNx4XhSOEn9m2PR2OyTBfmlsKYROZg
 7MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662221; x=1784267021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=a3Vw7z5bJ48nSHx8d/y6S77EFl/XO0QsPDrm6eiDxK1HCeOvA5LTJO8TSf1qfVkstw
 kdrDi234KjV6O9GCkbsnYWqFVLhudm9UITh6n6svPQZg7g1WlZgR3FjISfv0Zj0TVZom
 HooI9NtFhBjVQLgYwJZtdW6N5sx/B781cS8+58FpM7BFO7e+bi3jIT+SMroPRZt6jKx2
 ab72BI+Jd+HB9PdgcDdIBytnD2MI4SYVxtbILFom1PfxEwTpabJyHnb2N2RjoHzH/rZa
 dd0F+w3u9+ympPCiih3mgcdqoJK2pffl5S7sl16tpUyO4lFT4VDpuJjp35FlEfV43YdQ
 y2YA==
X-Gm-Message-State: AOJu0YzRcq+RdiS5qygMzhD3R5qZJCL/M2mIf/Zzam2cqnRkT/MP4RVz
 bXGJgCp36dRcsrhkvOUkDZ6UaDspEJavXmaGiZhlqq7ECTj5Y42BZEPYl7ZSd5EXcQ9lXVTDGHM
 sKHnAYsLD/tH4NK27JLSFnBuNq11I5kKAG7kXZBfTLqBRHFg82x3YZb3y8mA8PQzbQQ==
X-Gm-Gg: AfdE7cmrDQ1Y83pnM3woOfA5rSv2CBF3it0lfjnXHzIGJ166pV6auIjeFwoADn7GZpV
 3jCvNk/gxkrRy+l8MhAZpS336Efo9tY89dZ7oJ0v66f4k/dm6kKx0JXj4wFln5/Ujvm1uO8GUWT
 pxmXKeD9pHG3tvxZfVO7gSFUuAH6YZ72H8wUES++5WNYFUWmtLYTmAQhobSgbcqQM3lJLZiLfde
 lNkWT6FXaKxWxVBjlLfadUR/ZXnz6RJetISt1JwNV/1yPBZUyo5C5wo84nD34cMMqn07xxQq9KS
 eWoTHb5DuDANoMvr8IM254qtDLzGfv0NSUHa939bdfOzgkKToXqvPdEQ6wMorE/PRKwn0tbKsRS
 s5EhwiHDSV93ZJTobDy6t+sHpRze1wdD7hfRdsIR9HZKCLEhWiqUqKGmE5EmjSRAAGmIfTwksFc
 Yz8KDfFErQ+ElfRrIBxjwcHM3vHRoX0H/iwXZw/SaK9A==
X-Received: by 2002:a17:90b:2d08:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38a1f1dd5c1mr6019599a91.1.1783662221138; 
 Thu, 09 Jul 2026 22:43:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2d08:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38a1f1dd5c1mr6019575a91.1.1783662220546; 
 Thu, 09 Jul 2026 22:43:40 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:40 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Fri, 10 Jul 2026 11:13:18 +0530
Message-ID: <f2138f531f42071613f2c71ccb34fe0548677924.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a50868d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: eAEotxK8Gs4RvhWyPiLJtpT0wGZuv4Ig
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfXwCxCroDfRjSi
 ZWSFapaWIjRn4HS8a8/UzAhzFBt3KNGfkqb6FMG3d4XZR2GKIQ/gj7eojV/LsFb4r3IdvNdcwSS
 87vJRz2M7/ISVO/N+C3bsX/m9h6+2i8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX7ZceXqoxecRY
 zours+mPo2nTFLv7UXple3NMeEX3bVVZXouzxqoIUu+CxYvFHRZRXdu2sbQMtJn/5VJYo54Gusw
 oB8CAGsZrI5GhnfJCiQzbsjQzK1hF6tu2V9cGCdPnBi4nmu9aGEgk604uZXVHO9G76rR11dcJ0y
 xCF2h4MT7Ka8niQ3ZWGTrAU02egMVH7bxwyhxQuChD2ar0pigOZciXjK/HmCNf1v8OOdBlCLbeq
 r4zzxTy+puNPOD0PQtugfHHSowIIPEjt2N1gb33xIXMpF98z2fHbXr0vZL3uLlsNLQ32GUoS9yR
 TZh39TOHhGV6anm6+SloPuxTqsPiDJVoeWe7QR2sb8qX8f2ogwuMkbLnio2t11bXJay+vOQT2nW
 Er49oxaWEhUWLLWf8FlRS0fNbqWNGDGmENkdHo+TAS2mxNWr0gjln+ToMLpBQQ4GxXhuRwezKrp
 GWVFZ1U8wQrwf8vnAmQ==
X-Proofpoint-ORIG-GUID: eAEotxK8Gs4RvhWyPiLJtpT0wGZuv4Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100052
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
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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
Message-ID: <20260710054318.jzkFfEGk09TA9WFgL8K6GKvZ9-am8MXUOysHQYryLUo@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
system suspend, and system reset paths.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 172 +++++++++++++++++++++
 2 files changed, 174 insertions(+)
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
index 0000000000..c0f96f7d8d
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python3
+#
+# RISC-V virt RPMI Linux guest integration tests
+#
+# Copyright (c) 2026 Ventana Micro Systems Inc.
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


