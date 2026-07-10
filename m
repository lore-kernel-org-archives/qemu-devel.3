Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D19C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAF9-0007MN-8B; Fri, 10 Jul 2026 08:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6n5-0000ik-UH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:41:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6n3-0001yg-Rd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7eeKM092342
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rjxxoo+6u2b
 LA22O+8/iQdDj7+Ze0NliZ003o3atnfc=; b=jw9qIplK44ryamyoek6CaBMx1Dk
 zKfBuloNC50CDO/hSLgrRhZp557/cooqBbla6n3Dl4P22Y82QfoK7g/gKSC4iY6g
 gLkdA52yCnhHT1TKUl09uhg9iVgh+HY7p3ETMAO5iT+w8RfEF8SRH96d4rQjombV
 QcOr6Qu7qXOY4F5pYZs9+/zsp9+kef7mx3KpBLYRhS73DcUm+P0Z7AyyN5gCttoG
 9ThQhxtxMSI6sg/QYx1DJV83hNNxLrb9iwlFlqf7x2k7SNmXo8zQ2DK0bVCLeQMz
 cIuY4S9IXL0bE/BG1gkpMdoyZliDVR1sZnHtlatDnk8UmLNsGZ4h/U2oyrA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbsup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fec882754so188137a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672846; x=1784277646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=VxXFMMW5TZInaaxPo+kTH9BQ+TXeLHOEGe5ud0nBUs40Deh0N4bbypuw7+bhxR9mJd
 lftM9WkMlzgb2Svkt5b35e14JpN5NUAErUsiPOk0/7cOFCzehdKZ3N16IidUoKIIPwIu
 JD2JvE+nndwkXzl2UeuOqSrCRykX36hxPn29b0IuRAp/vVi0cAV8YL8JOqUW81o3oLTo
 DHpQjVL0dQ7YRmDtGheiNGlmEjDaHTkoX1UxTryBgt2CEj1xRpacw25jhlwclIxYEfC6
 djPVhLPCvNYge2vVsqmGEZHATMjKaZRG/peknJi502WezWhPDrqXnxLjMrsCiLNVenST
 I8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672846; x=1784277646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=D2eGOocg9lzIt/UiaicLvHighAn+eY8bqDXguKN3syk7EbMb+PIPHxBCJcqxpf3qXw
 8C9N3Le2KKseKgxKo2IX8iIOOszCeqienXshWUwk9/JBAtjWwIoNl4UDJJBTrtyi/yMP
 SKPIIYDTk3XxajyUbsHx7ss8vqrGCB/qpYdXiJ+WFzXa8hHF4URRWO2TfHQt2JmdbSqm
 No4m+cqoCwBk6wJ8w3eDik2rUzuu3lrCVEominCRvq4pO8Y0yJL4ecwVA5EJN+RgJbFj
 vFkiIOU+fvIWTiFo1jzr+bILJRH7vby7yzQv5hgQingltHZ7Q0Ihbrq5mb8Y4zKYebgl
 ffaA==
X-Gm-Message-State: AOJu0YzD8dkOHm/q4zDWAi5jB/2YQFi7W1ppnC417QyM0XVv7x5qpSuB
 FOmjx0pyRPBXwOqMeOaIoZqkinM/1uATOgN9W3MbPu2x0XjqSWeCoQ6AZRNrcnbmetEdyZ6w5in
 ZtV7UGcuu9aSyxIo3CpIsDsx84MyhglFm39rO7hLL0XtvSIfWlfZDLa4qdFovnSQ+HA==
X-Gm-Gg: AfdE7cl99EIl79UKRCCH0t0M4fZ/icpbtzb3Z5x+wSA/3Y+hj+4IbkQOWs+yVgZfcsx
 B6TV5n7gMft76qBwU/OFxGvxwQOpA1HhngOdGGnEg+YbmiTr/DBYRjH/QSRB+VTl9ECnH3UsWVg
 ZjxmMfrrN/S0NRvr/ehmMdMRmU0bmo3Zk8LyvgIEmmV+9aZR7zkjJ0R3Rx9jt/F4mVkNmJ2F6to
 sH4x98N9BP7zZ4Pdi5ZVeFB0UhCTZnZ8btXQT1N0WAsARIKtKEPLy92CykvCnlhOybz9xafIeW0
 MNzwh2NQ1PXbIKCvwq5f5oZoQFnyB6ZOjq18g1Xi6iUlvG+FX4svuaTRKcwZXlNUSkccfhcrRaG
 douqs/Qfrnasrjr6agdAZWaCObA+2ZzBqDzM99gdPWuHAKb6LyYP0Wbjab5N59cq6wcq7HOMYTF
 C4aBiYnMRFAU9R6ptWQm62XKa1tG/HBkpEMvCaGLHzNA==
X-Received: by 2002:a17:90b:3881:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-38a1c1b0a81mr5988410a91.0.1783672845808; 
 Fri, 10 Jul 2026 01:40:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3881:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-38a1c1b0a81mr5988385a91.0.1783672845271; 
 Fri, 10 Jul 2026 01:40:45 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:44 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Fri, 10 Jul 2026 14:09:52 +0530
Message-ID: <f2138f531f42071613f2c71ccb34fe0548677924.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfX81pWcI6WemYc
 83DzMO1WXUxNR/IP2MMT5c5WryjWvhDudZY3Cl6Z80n3i0EHyP0s/u9k8+MFZbTNPlfVFzqIAmb
 sl7/17pyyHgANVJsmUzdRf9XJqcX3bYj7o/1NBKazdRZ77dqJ/9sPBJVkcPOnvMDU6UMf/jQxBP
 MfAFyzAQTFb07j/VCv0QllNQttk/fYu0BF8YpXMC+Kod3E8c2l7DbWeIJJQ/N0SZI3pD1Da0TV2
 /9EcEYzoMlouIRRsxlH1u2oUmOMcd/9iWpuhpz1yLeAl8geFt0uoSvxBRC8KVvQ9V1D1uHJ7MmT
 P3RaewxRgudbtQwwdszOAYzTkP7w8z8+ihXUQCNnzWSipveu1eInMNBhIeV2P0tv2mGwt9DBDLU
 NhS54nNt7oXxwBVB110N4PPyzJejHaEYTPYHvkD2A3kXHSHr+hnmbBxTpnwt91zM/kH8n1aCAfE
 ENI8OuAX3M9MyXmBZ6w==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50b00e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ctRzefi-bK92N-ivdCW5Ve4rJUBKm8lY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfXxOMtDq0EDOt6
 zkOM6wiDBceqnLH+Ot1dUkz+w6Gn4fLybjVp9CC6hcaU977ZfiZg/FltRPYsVgyamatLLZ4VbJ1
 kJkRTeuUZancmu3tVicn6pZVnRxvznM=
X-Proofpoint-ORIG-GUID: ctRzefi-bK92N-ivdCW5Ve4rJUBKm8lY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100082
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


