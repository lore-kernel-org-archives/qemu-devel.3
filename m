Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AADC4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm47Z-0003zL-MD; Tue, 21 Jul 2026 02:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm46a-0002d2-4a
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm46Y-0004UN-65
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L2TJ3w092429
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BWLwBmsUZ0g
 qQ+SJaw2KLoRPhk8YOH8CBqELd3wjg7A=; b=nNAbYFHFClAx81Y7Si8XydIWn2f
 FnFQjpiV1VTpMGzCfM/4V2dVe7D8vKMCWatIcE/Hq7u35FxeE1iiC9EUZv7cTQdM
 p8zrageVhFBcc5jVceiUEDhz0w3aY95xsBcnQcm2WdardwB9pgihODbec2+R8DuM
 S7VmeXQp+ua+wsSwhEp0yyxG1m7fgVDmSn7NPLLTWVmYhSVMk3sxoMY1pvYjq1Pr
 J8dT6gAbnK9yLHkyslc0CMqyy4Bd+GBnL+vkmuoVBRDiHFr/vxCSbiy7vBCZ7aCW
 kYCvRnNr5WpCk25xm3HdEf7caClL6IfBQLGiRE0OGKJM5ypmyYPNk00ydHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a8w7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:37:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf2308ef97so12252865ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784615844; x=1785220644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWLwBmsUZ0gqQ+SJaw2KLoRPhk8YOH8CBqELd3wjg7A=;
 b=K0ojm719Q4J2nZKGj5EQJeOdneVoIMUeF38Pf1fNiFu87270IUkxA8kGgI/zTrCeo+
 NcsoGoPLblGaBdTGme1tWTB0mtDOBiRtgLIu1HI9DmBh8lgfndhHJPkeehgC6uVCwPVB
 jrYk5AouluPAXilROX9Km2treLyzeUDlXJdVA+TyxcZAxLaDsdEHhbhvH1uqhQfNNJgM
 ywKxOivCDZw1sLCBTDKgYtZe+5WTxzAvcDoqGMhTaA3SeHlosKrzs+fYxnaQ7lCxSkKt
 HQh4bD4N2HJwi8h0pS5Fmk2vhHOR1rJsib/QZ6MSgow8GUfP6P7usN+Cc3GBHNlpDfZw
 pLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615844; x=1785220644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWLwBmsUZ0gqQ+SJaw2KLoRPhk8YOH8CBqELd3wjg7A=;
 b=AbrqqStGbhosybtXvEwRleRZeBBU+B+HJf+GiY/bgo8XY6jJ2oA1+PmOakrLxjM+xy
 OcEJvlzBMjAqWeJk3/92mXEPg94+eDkjzkdfzZea79peI6xEthgFi6qTC03XFF86ClZx
 pwE1bv7lQk9iTBWTN5W+6Y0oaNqDSaz9o+Cw/KWwiOASj39Ynfr7Bnhj8PLU9lU39uul
 hCxLJXWx/6wxSeXpKSDa8H8fk6bZFHA30PEvgTSZh528qlGhoiyenhcQg1FfYSb9WRbE
 0Q/vfNxcJ3EQzgxRuJZVoQRHqfgKbqm6hWG+NCy1iCKQNYKBjdBkInq7HflC33NpzUv8
 1CZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTnA/0UW+wKIiaHmak9GMyHlSMEkwxdqhYkbRHYI1Up673k9qi9cccE/r1hhOtHQn3yFKLOH6TW2aq@nongnu.org
X-Gm-Message-State: AOJu0YyCMriW5uHKsjitrlQVnvIvQVbGNogzyjfT4tiPcar0PWaXgd1h
 B71aXbil/ScRIcGoc6XnqHPHAjaD3mqv8Em37ppaD29nKNYl0ctbuNUERiJbF4T6cTZIhlQe9Wm
 jayZTT96oPSeyk9me8JirgEASZXzzHlD0hrnzZgh9Q1TdiZHpOtA5g6qBfA==
X-Gm-Gg: AR+sD11jn/XB4sRa+9IsPBNjPJTK4bLB0CECk086mBxMtox4xp89uyqKES0pQBT21tr
 rU4gxmenG1ihXlnA2EXgmJt6wUQ1dLNEG9YbZXpilHJYtmN4nQfC/83yHOBEgvhq2q41L8rF03l
 KnHY9ZFo83XE65wwoBLgxrCp/KrI58MEfd7ZiC+pc/IzRpTM9Zr3cc/n36Ifv3WAHyckEnYPAD1
 LSXL7XkVL2h7OKaNEJOh9/EAmCm7yeIpbyriC1YuxNK6pQ4cWb31kn+4sw583aJBarZYYLJb+rl
 zposuOQAiVtufvbmErFdb4B46VMLk2zYYWWg560hrbxVusXHNUs5R9rCrSBkM8J4RVKEDiqqvLR
 uuPEnzWwFhvF6pu2FbOkOFeIMSjZAEed2qYRl3Ou6Y+nPu7TLK1OgjZH+Rno3LUZNZ9t3HMkXpb
 ab85UvdARDjQj/1P3mSCt7Ra2GTHS8zhY=
X-Received: by 2002:a17:902:f78c:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2cf34667e9fmr137902405ad.0.1784615843983; 
 Mon, 20 Jul 2026 23:37:23 -0700 (PDT)
X-Received: by 2002:a17:902:f78c:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2cf34667e9fmr137902245ad.0.1784615843548; 
 Mon, 20 Jul 2026 23:37:23 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb8a4sm47161380eec.14.2026.07.20.23.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:37:23 -0700 (PDT)
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
Subject: [PATCH v5 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Tue, 21 Jul 2026 12:06:36 +0530
Message-ID: <80175c70a9fe4392fb4638c248863e3143c26005.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f13a4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfX0kbYvqjUYoVQ
 tvRH7SOSMEHUcwsRzU2K0/ooL8GEgJ1OSV0vltV1j3m0v456D+GBuT/elRt1qCS+bTXuhnTVIeS
 uHGxjW/mJahFAnYi4w3TxzydTHeNMfvlOwMfziRblEZEtNOWtQ9V/Hkndfy2dRbYZcipm5RxYh8
 viSAvmCsIfSiKMzZGaRn5aH442p69lcnfDqPcWllyZHwHbt1WWTgwc6yyT/2xxFHwqf1VVZyTAb
 2b+UIyLtHqyxpAmD/bfAUbDZmyA0cdD+NMoVvgkYXdhV99/LQW9ElKIqGw3aZsfXmCnoyP5Wxaq
 TFLbVvkqLzJwSD76JtSyyBqvWfa4043YbvVgEudYtXruX9rVGLALprcRzS5Ie7s4DHC5zD4U7tB
 etOFBex+UaOfih0NeQ/COAk0Esiwhk4gE7XuXeNcBAC2RdKDKm/2cP031Vtx/dbOw2zk/xMBOqS
 JwnGlm8LhmCpMldyFpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfXxhVlkvaqFtb4
 it4LLCmYodLJ5CQldOFcIGBpQm0GCMw8NyrjrtZ9GAvVrM3/2wXQlo3w9ztKGjjxXpXNXcEHhR/
 Fmxv33bRHhySNjq0HxPif/0ajGBjXCU=
X-Proofpoint-ORIG-GUID: qIzWSpIgsnHUt7EFjEiqniG769m_t7Ru
X-Proofpoint-GUID: qIzWSpIgsnHUt7EFjEiqniG769m_t7Ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210067
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
index 0000000000..1c199da301
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


