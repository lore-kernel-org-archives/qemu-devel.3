Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C85C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAFF-0007V2-6Y; Fri, 10 Jul 2026 08:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lU-0000OS-IJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lS-0004Bp-0w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mh1B3847273
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UWnqngjifCh
 P51DpkO3ronTqKQpkH0m2237QEE2Dlhg=; b=GkYfm7FrZLmjphEkw+KD08Hgrrc
 Vlk4NF6Sihy/s813z2d6FZ8EbNN1BjE5/ZyNbXUJhsW/btdSS1FW7B1b5Dhpf9Ia
 2UES4tdlDnNmj0e9Hnme0WX48ABN9IkvShLhyHCZX+G3ZOkbhIbcPkKIff75Mshe
 iapoq6LERLVA/9cuNDy6GwWj6Qs7GUh6iziQx8CCg51JSA+QhGJL1YHPEKDNXyd4
 wUrfrUAcsw+mqAom3uKBxNabH97Dn9IdSOhOZVi7WMGexuR7bUWnspjg0I2CAqVD
 PwiJ4zWqo1Mk+3qZkqfZMtCL88Ny4hEV4lk91E/r690VPGHEpjBd/yMBuJw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte1fws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:27:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38459087607so274199a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661224; x=1784266024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UWnqngjifChP51DpkO3ronTqKQpkH0m2237QEE2Dlhg=;
 b=UyEUX8twrO4erNXZ16Su+rZZb21wrKWOd+9P7zteR4PivqEs+z1+ct1D4kOF3FvoPX
 PjNsmx1i4FNYW+xRWVlc7yhUtogeSyASLwpHj0xmKJFZtZV1ZKI0sgAM0+zuLz5TnpLg
 M5isWkRA3hV+kMJA5uXM6m4+liZgYULV2C7vtVvNYWMHAetiYJtNHAUbUuvTQMKXKTzk
 PRjT/BjCGQqk6ZzTcwSmwe+JYoQ7/0eJf5bHnh8ORmOnMKASBkQ5SC25rq9mJTqBSIFH
 +hXa3XtIyyo5y46jKIwonBEEPLDcVPwoZoHQBN2zUuBAEQU2yDTIzPB8eX5MhlN0O3WH
 dqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661224; x=1784266024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UWnqngjifChP51DpkO3ronTqKQpkH0m2237QEE2Dlhg=;
 b=XLHXO3JTJTukVp/mJbYQ29ekju6GlCJQ0Ia613vBbWxo8qru8ula+EdDADwbylkRxA
 aMC28kT23J8vPyH5lmwzf7Xj9mofHYS6HPz877tEzthyfbay+JqAbfGGj9x+SlczI3Gg
 ECPpl0U8kvFEsc5le2diwf7bPbN3BSTlfQgH0HihmDaLoohAiQDAd/Ir24/hAqBt4eyd
 +01+ILm0GTSX/L7LX9erz/9oOE2TidIlG8NM5VpZsKEc94hHpTsMr4ZpmYhg+JCrHMIt
 oyIxPYZ6CFeuXp5Aw65w7D/wwexshywCHwyrz5936p+ToQ2EletUxs3f+ER5xtd8lQZJ
 IdOg==
X-Gm-Message-State: AOJu0Yzss/cuzlmF4GSxoKo8Wlw3nvfw7DqVMNMgOgmYEIT094WcxLWV
 cFrcVUaWET0abKGtvJ4ORJpaALLn1DyXJSIc6TvPLdG9NBvoH+rGaDG/7gRcrn4Tk6UWEwCJKlY
 dfulgJW2M6NAzpZypJHleyvHZDnPrq+R7F+yeX1hXI+l3z9rp6mELZyiJSCkuyANrPQ==
X-Gm-Gg: AfdE7cn9r/IQsu2VnrX+nSU77ERY2hqeCP20/zTwYNCWo0xMlGCYE8S2y04rUaBL5tH
 k3Ysm4K2gWJXN8kkaENZw8DBa6BSugiJBYrnUEKv0sqgkuk83tcGlWecBRblMqg58PveziMyZY1
 hH2Q/lLyrwHWj9/PS3bQtRG/3xd3dCMGb+cogdzJQMI0dqV/Ez+FxPWmZhULaXuSiDNd4X12W80
 p0cLs3QTWTYi+wbMgWLQeTqCZWtdmRz6jmf2GeRrBEfN/HqOfr0Q6BGFEabRi27CauoKHtBbdAc
 0UYrY0bMCPmA/jr5ggAlnyfOl5jDSiafcNGlSO/S/mHp/k2fYm5MB1x7adbLzRdmIKeewhZOr42
 rTZBtev+a9vkR1cTidbu6UHcdzdGx3sMGbZFfi/mQBTAblwrLuSVN5WvdHLTOz1hRTrS5yV47Ro
 luo6F5cs21dVIaYIAE1zC5Fokd+3AIwJ7M936EdPwLwA==
X-Received: by 2002:a17:90b:5886:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38a20e414e7mr6163470a91.3.1783661223654; 
 Thu, 09 Jul 2026 22:27:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5886:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38a20e414e7mr6163439a91.3.1783661223069; 
 Thu, 09 Jul 2026 22:27:03 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.27.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:27:02 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Fri, 10 Jul 2026 10:56:42 +0530
Message-ID: <f2138f531f42071613f2c71ccb34fe0548677924.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QtWTQOQ4WPFlhY2D1q0QQJRPbMyHRsR7
X-Proofpoint-ORIG-GUID: QtWTQOQ4WPFlhY2D1q0QQJRPbMyHRsR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX8IlGK9eQlzR5
 aWHu46pICjh+LhRi/eapZA0dQNekiG8dyS/dGW1i+JzuWEMI/2VDoktgiWWE0OtXbjoh/rIMX7J
 vOXPtd60a46AaKNGnBAs8E7EjcBT6q8peG36nO5cVXGvkha4Gmp8e53HJvZXRJyO6s5FGjUMIzn
 Yrr4RGX3rxOuLKO03tNllHFYFw7HLjjeOOJMY5tEgbVPvviuJGAEqw/P4oxC7s7B8ukHcg6IdCE
 YVNmczV0ohDyaC8fkJuyVsDmgC2pbNDrt7vkgJim1RV2l3ONAAcmm+Tv8uO9MF7ZV4AxquWBDLI
 W2W33dmZk1r4m7ZdzNiW90aJ3xSOCdvzauivUmOs2HA8GncFyCMUX5rHZfj/VZDN5pZMSIB54Zb
 3tEXaXfTc1XX4wmwqkarXbdqThVNwTTxuOkJsKCmTdjYpv4m9ul7zvDShXy+8PR1PHR/zFjkwyA
 EdzljrW99uBpBSKzrUA==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a5082a8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX91j+Vxfaz3v4
 PHAyhjdpIUUEDF6mPQ5bGYmcoZYF1phySVDVKZWH+HPaxECcUKXn0P5DoOmW2FkfZkJFP2wibSC
 LW2LXy5g27cPxoss3bLfzZo0bWIwE6k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
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
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>

Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
system suspend, and system reset paths.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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
+#  Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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


