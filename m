Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC7AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv0q-0004Cu-89; Mon, 17 Aug 2026 06:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0o-000431-5j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0l-0006EO-9p
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dmGk1058538
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qRRwiGrsxId
 dxqlNmu4g0WsWnr2EbhJrohLUTwLE9dc=; b=BXOgW/nr1fJ6M9Ou909GkLQ1/kO
 YZ14QS+9cM9ISsJul6C9lOE4BquNy02YLZxlegx6JMDCXdpfv3lGZRtTWtsLjACV
 rBCq+56WySavxAkBYEit29LjZn6yALHCL3V+xoSitQYLygUcNKNOgvqR7tmCUFWX
 l9v7DvAmDhdQ/47CnIwwwxFcnNa7WjjCCTKxYrEMaP/vJUx58+mkO0531IyWP2FS
 KMdN/jG/mnQmwuIW9nWy4hdAFM+79HYzNT9FJJXCmCXOmY6eXL7iqdKF82eCHpcB
 ILsxEf9I4XVrJ9wrPuG6QZA/y4RCYA6vi52sX0c193q62U4xWQO8oTdyeKA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30gqe6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:56:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8d1600b3so960706a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964169; x=1787568969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qRRwiGrsxIddxqlNmu4g0WsWnr2EbhJrohLUTwLE9dc=;
 b=Ocq7rPTl1eeQQIdDWaFfh0YuIAGE/VjY4UNDAKrUMqKJ7n6y8M+iFiOyALwWSI3LDZ
 WY2ep5i9YVyP0660dv4ibPO5vqUNmNS0LI+lrplctyBOVZcWKiYqm982th2rvIp4ELEu
 wel1S5WD4jg03ak7u/yDxFKs3o1CXNvENKhK4GjFmUTfM7yZA/OS1LgHPWohnvYL9Lsu
 Kzz/ddH2U269ely1rdkl/wjASOCobnVyYVSdbjnZqFQqqUdbT//+8cPdrxMKJMKuSz6O
 lESlLaMhSfxBLlQ26gylyU2BFIJbBpXHEMofuBRrmN+eqYn/7nl391sRyCjQam2xL2zN
 AdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964169; x=1787568969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qRRwiGrsxIddxqlNmu4g0WsWnr2EbhJrohLUTwLE9dc=;
 b=g+MJ4wdqUdqKgqdGAE/h8ai+eunxzJUDY3vLhGINeY2T15mqjG9Yf+Q6G3HqSdkjOH
 z/mcSRPhwwJxiuGKTu1WgbJV1aAuG48M85qoep3vOg76CeBSSX69yFpQSz5q8HzywoZh
 EOFngjcmXDyFiqgmZvj/Y7iGXNmzYmhnQPfJTqdr+v1mN7zfjoxjKTmlgmIfwKTWG4Cp
 itLLmA6UHJZro7+PEy+f6n6omSN9KfQ1wOgoLqPtWSz5vbJOE8UmXN1Prqz1IczVgqp3
 58M4spdj1ZxvQjRn+8r2FJ0xcRA89P1OP4xYMCQUft2dC+KJ/Z5TJ0b6CAPwWs3qYiPE
 oxZg==
X-Gm-Message-State: AOJu0YwG1w6Z0e3MKz/8XXyQr3mASAyKGAXsbIeJsCfQuKDTiV5MnfJ1
 +viCi43V4gwgbZjfsTwfEa3L4cIGeL3a5u9K+tL6FB4BIGjO1KK48bpGZtUDB/3j4kKj/3ciAcv
 vf6RNB1X6v5L4tp8G7SxlHtV3wYrlvvsOa2tm4x7Yjtz1yorkz6Vf4FlG+58O3/Zz1ADL
X-Gm-Gg: AR+sD13kfxVQYDIo4fqylzRaOqu3bdaOdMqMLcHkiiJ2uUmouzlu8N5L/0q/VGNNuo9
 nFXo9joNzSNueDe/RqOBA8etZRmE+iC53Rn3n41Kxy6tO1y5f6s15lkUBvu8qomqFqYEgK0VHJi
 JyCwm4v3eSSOGcmp35svxKcmoqLBSbYxQ3kEQC4RilpBTfXK3hMTeUWE4r5o8Mt9uw8qZsC9GO/
 uNza+5nw85Peuouhlgp+wDpJM71MIiJXTyWEURsH8fvlFdLN1v8ze1AEOw9Kqzu9QmAx/5z03wa
 Y8VOZ8/OkgSdpClu+lf6zFkfTqbmmV9rei+fFhqitjuO3+0Ej5bghUVgs4k9IvVngpPsq1OZoyQ
 ZbkAUrIS/nRxwJSwGpWiDxsCaii8P8vBtTI/k3uHOPq6f4t9zOgNol9RtwW3kXLcZs0tTOUGdeN
 hFVPnqFunteMv42dSEMoObMancM1o8/m8=
X-Received: by 2002:a17:90b:3907:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-3933bd12631mr17031215a91.4.1786964168562; 
 Mon, 17 Aug 2026 03:56:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3907:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-3933bd12631mr17031181a91.4.1786964168035; 
 Mon, 17 Aug 2026 03:56:08 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:56:07 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v9 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Mon, 17 Aug 2026 16:25:04 +0530
Message-ID: <20260817105505.2607506-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX0k2YJMLR02XT
 O1HnJXv9zMmbeyeN0FmhLL/UMs1qniza5nYOw77h6ZrSE/t8HoXm6gNlbv7X+eRHy1rlyOjylK1
 zYz5XUMHJ1wfQE9tsk3Nb5Qh96GQJ1psxUC/U6xCU2JGUoXq4ZtXqoVe3trx9F5GuwXeojGHvXN
 PCeYGQdwCKz/Ah/g4t3aGf8stcZ6A6NpOeTr8T9zSO4duB6SaSJnwArsbC+s0GBGiWchc7gVkcE
 D03ziQ0EarWW1m6fF7zBd4NulH5ZYBgCde2yaeifTtxPcLMSBESF7IiyMfCmZTwAjZsapG3NMMo
 JCp2Rgl9iXYkNUuureidJNfxa2E/8dTrzP9eVDxnM6REUVCf6t6gjaX9WP6ljbN7hkdcoe1Kz1J
 5FqwQyqc5EYUNdKqZxes3Nu/8ZYI4tHuriOttS5hslC3VcmXj4fvFTnrgIivQiVKXhs19BfBJkn
 i7zYu87dtHkZSmsr1gw==
X-Proofpoint-GUID: fPhrz1Vad0IgdKhcpjTS8mCuanhzCBm3
X-Proofpoint-ORIG-GUID: fPhrz1Vad0IgdKhcpjTS8mCuanhzCBm3
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a82e8c9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=rFS5Cn7EypwXJqSoKdAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfXyjs5eJ5s2mcU
 I3EANH3gT9qH/SFcCdWKAyGcDG2xWTOz526EKqvI+Iv2KJMsm3y7UgDGeoEuUkPB4XZyG2lZ36i
 JBfpIdRn+5DqvU8O/aIhE4P2iDwCpQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index d1a3e6c2bf..1b35ba8cd7 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -4,6 +4,7 @@ test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
   'tuxrun' : 120,
+  'rpmi_virt' : 300,
 }
 
 tests_riscv64_system_quick = [
@@ -18,4 +19,5 @@ tests_riscv64_system_thorough = [
   'sifive_u',
   'tt_atlantis',
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


