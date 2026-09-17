Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A81C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74bL-0007r0-2N; Thu, 17 Sep 2026 01:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74bI-0007pZ-Ae
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:24:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74bG-0004EH-9A
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:24:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H1Ul6n3402909
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1+In/cvQ2cr
 FU47QWnxhi9qaB5KyaKv07iFRG1s7Qiw=; b=c2gcMwS8IStQd8Ug6KQprZdOaef
 KCNmaMVU22T8liOuZ/lTUY8fP+H0JlQLjjYSVxaBLLSZPwYEY7OKmFc3uUsmUKR7
 rcwNXXmPcDzkauGnnpa9vzm9iqmuwyBalcxOZeBOF0wnNQXdtrwglo370MLDYaaa
 bVmdURlyyCbrqnOCoxK7/iPc4oy2VUlOMUv6Ji+rN2DCF5wbplwuQJHo0uSLAqZm
 p83hMgKiojiSLsJYcBCLrS9NQMxWdaBy6dT3LR63LAbjViPbPD8jSO02+5huSoXs
 TGF9YBjOqiUgiHeVdfPJAXxAAI+wFDQ5eDL2i9an2lebHJf3x+25Ey6uzQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d2pg6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c4292d5aso85328a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622636; x=1790227436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+In/cvQ2crFU47QWnxhi9qaB5KyaKv07iFRG1s7Qiw=;
 b=giWlOIuLbLaGDy2qDlG06anacUdgcwJqhZR8HYHU0h8pY5CWhXSKsGdKxEigNYtjt2
 tuHpAcScIHF7liJPWQsRS7Wo6N4MbIwK3bw4VO7YIcvDUSvO9lvxZTUKCH7LRrMW0jvB
 taZAZmRhcz2ylGT6dj/lyCgrhwUUI1zDs7Q8LPhtceyaYsKi8QYcUgnQf2KsUsASWGhd
 nlOUN0V9RgobxEXB2zbNbHkNDsp2yvPxUZHgDzViqMLz1orBs2hBxcyJ0jnPOR5uATfG
 CDOPOzMlfkxeHA7fH8wgVH/U51KEYLjhfpf8S+XYgsZHj49tRb9/qdylzuStpupMQUn0
 E+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622636; x=1790227436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1+In/cvQ2crFU47QWnxhi9qaB5KyaKv07iFRG1s7Qiw=;
 b=aKAfCdNK+/mmqgndh8CDBzm8fGQuM6xDej3kWeN3Ke7X/nzR4vxZv9P+qHahkCrAXo
 O/mpptBFixEuweO/V3R4Tc+O1PFvBDi3s247oCDy7gb5Pa4+BGZaaUb7T2BGKAMGpIHV
 Z7pALw53JyDFDXNwsd3LgTganXz9/o8+3hXUiwu04AdulOmlKdvcj9mewIyYRxLm+tn/
 0n7oOgo/DLVmXC3wnoCfF/6tDgOnRXMvjy2UWvJqkp3pZ5ah4vHmMiKxSl+4cUt2KVxK
 DTuveq2ga+O3VntKWuQtEqi0J63QdIRHPtv1C7ArS0K43OEcESeD8py7s/8M9E545gRj
 23jA==
X-Gm-Message-State: AFuF++m0q3wLAZ+97KY+1k7J1GA64h8yYKEvkXob/QshpVruR1favjEy
 HjfmqeTYIG1Vix6k1mmGZTWSXVwx1z0JtSSM/X56B54IQqDee6eUaNFaqwewkDO/FGfpollF93L
 Xnp9z3PAnY4J0I+BmqzmOVPfs2vx5F4lOF3XyUXfGBIL1nExfq7VSlxatkZBxuQDkJw==
X-Gm-Gg: AYBFou0f5Xi0d8SULzPSPT4m1IQRQG3vYmS3/BZU1fKFn7TL9wkLP4NjYJG98f981iq
 FmiHw6FxtmknaTbKEnZdlyFIdgddzEvWHKRxkNR1z3JH/w5+0VIEqR4YrtoBCMxoJyvTPhOUvac
 JZesH0n1UoEmwe1kZ0PQy7t7qkcXTvMgYCFQCDUJueG5RecDxKEWPwhjKfl9xtm47F5lNKMw5iH
 3sXIY5sdlLwgGLUVS1qO6i+4qe9c/szJ7htsAPlyc1SDHW6TpfamSTmFjIRWJ+K6s97BGiOCTG2
 s/NRedrf9oulCpoEUhJ5awG5iPwrG6q438+L6cCL4mAi/xf8j6CQiak4oREtJopHSK5oxBzrVWG
 vo7jH7snRzQle4/x8z11r8dAVJiNCdW2/9Cp9TWvcdgSEBMZBj4M1eLEFJYP7QdDeh7ePR27xuo
 2YqSJ7G1vZpKi0dFO1Yb195euN6BcyTVA=
X-Received: by 2002:a17:90b:50cf:b0:39e:345b:3333 with SMTP id
 98e67ed59e1d1-39e345b3d5fmr3538804a91.2.1789622636096; 
 Wed, 16 Sep 2026 22:23:56 -0700 (PDT)
X-Received: by 2002:a17:90b:50cf:b0:39e:345b:3333 with SMTP id
 98e67ed59e1d1-39e345b3d5fmr3538772a91.2.1789622635580; 
 Wed, 16 Sep 2026 22:23:55 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:55 -0700 (PDT)
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
Subject: [PATCH v11 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Thu, 17 Sep 2026 10:52:49 +0530
Message-ID: <20260917052250.1041262-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v1C7OOQoqzdXvwwGE1AaKRz5bub6SVPp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX1Jx7OXXfcfHc
 EydXWeouSclcpCGW9UGDX4i4KZ5L7mFD9YU8JQV4UDHqBk+dDmtQjVxAZDbTsrYL96c3CQExFH+
 ex4ZWvzTOLpZGkHsnewKzhHAbHmEJgI=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab796c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=rFS5Cn7EypwXJqSoKdAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: v1C7OOQoqzdXvwwGE1AaKRz5bub6SVPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfXy3ymU+tBqLI+
 i+1mZk3Yv2+aImf1DXHeaeYcKjgCmh392uFAaWG9cAjw6wktSMKoXeGEbLJRT0nuZX64Nvg+gXm
 mGf+a3I2hCDgBE95Avn0m3UlsQj8mv1fNQyd5UZHWLB1/C0M7I+wVxV4xHR17BsBN/etD2JS1kf
 tkx+vxELmFut6GqScT8owE9gDRmXwFEr+zrNwuIoyaNIy9+vHy8CoghlamECMdh7GnXpHawSieV
 CV5KGmNY/YwMVPfIHVUQ9zlWTjphnSKjpOUXLCp3qpTmSEMcbYg/VM35tPBOau92sAHJmlGmE3V
 xV1ID26ASpcPa3ky/2maTx64XBgmohME7hmuWboPR7v7vNNequ+cGOyugt/VAz5nrlyOzstxAgm
 n00BTfBSYw+af02EbL/evTx/CHXLiJV5EKRfUPUcgK83irw5b9bxXjxE07FpM/iGGFb8N7yt+rf
 /VEzd5dB0DHlDTKwjmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170068
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

