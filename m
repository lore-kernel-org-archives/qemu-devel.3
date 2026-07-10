Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAsA-0006dI-MP; Fri, 10 Jul 2026 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArT-00069C-9a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArQ-00063d-NY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAmWBi615136
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rjxxoo+6u2b
 LA22O+8/iQdDj7+Ze0NliZ003o3atnfc=; b=Lw4mOV87v3rlzbyBZWS8mn4sL69
 +glB3aoIxAm8haOs8PAZGly5t8JeKP1+bLud2mUtx+qP2lRR0P/7xaw/uWAKoP1N
 OGZixGmpO32kDfTReVY8iLz2jglFogqqAh5rki3L3UQGhs11/V2JU3DTTN3lO0Py
 okfzrSxmpNgNQGCLKxNCtEPcTI8zXmlpNtjdr9KbJP+QuqXtsaualOVBmO9FjOAW
 o5kNdSNolJfSyZYyPWETi5AXTKul0ax2p8YlD1FuvJqAdfRWl3nFTkucHlhPco6y
 OLGPn7P2rmdyeUaCTIs6EHe+IFF767avReFtmFgJnqc6F4Ggc+67IcXEq5Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte35ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38459087607so396613a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783688502; x=1784293302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=EDBneiT7Vhzxw+Mm9xuM40i6rdb1OR3VU+YKVhG1bUIgLiqxUYRI5mDCSiZ9BX7pVD
 1iyRnUuyIeSzmetVK2Icu9RqcXaanG2i50yKp8yNPIlw/PvwdrBOfcGgtLE/jrNVWQMA
 RCGbo2sDH7rXzGprqDdjqk3khOPgOp4mkvpt9qK467PXCSiKjTVVLz2ybIGowTulmLD5
 B+AVY8kKI2W8+aLmk5ntl0uSRfKIl+jcNbaGVKhsRfr6Tqp+R4qLwYlL++Ah5v0sAPil
 YXbb8klfBghwsr4y3Q7l9AgzKbDdjUC84n/6NivXm9uXGZouLYSWr2h8ouV9BJsBqkFf
 7PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688502; x=1784293302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjxxoo+6u2bLA22O+8/iQdDj7+Ze0NliZ003o3atnfc=;
 b=ZcT+MYGHrm6kNJ5cewmBdmzQ2oFu95CfU3Rf/FLIvq3Tki6Q1nJZBdw/2UG/biWmKR
 Kf4hVncy05h2i5ILrQPjoBXM43NZ+8wkVvOy8gu2Uq0FK4exDs80xqifS6UNSpWlleQn
 OkV3G7duToUGEHHbWjs+MENNhtiCy0jTOh5RvMZPOV8aD6evvke0M63Sm4Tf4JFgMlyD
 iy/S5aP8dGXGAhqINMNZFogACALXWxsUtB5iLTLNnh6HM5O+kYAwLfr341Hz6AphlLRw
 5Jkn2DA9MiqBTe2xDmZQzJgxWJ1yZtG2YD7WC3L7+KPZtEQXDRRDI2IOMenG7d34tc0/
 lVUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQGWzih1lnk6PN/puqEnsneaFwDFUvupELNwCPxJ4yGz/rGaDXgmuGF27CC9kh47tvohZAb77CRV1f@nongnu.org
X-Gm-Message-State: AOJu0Yx/9brqUwsKaL1K9a4BzC6YE0lwp1brul/CeyJ1H82TAQzMYAfI
 1g4K1Haofu5qQzxEXHqWv2szfFGlSTMNiEk9AaMyZCdFA++XDVCOgI9KDUc2R84S/A/BOK6BcVD
 q7TTiaE/8iNURnjjYoa+s+mqLZhhQRm/WYtXT08DR+jrvYFVO8E3UUl8p9g==
X-Gm-Gg: AfdE7cmgl0tlccWKWk1p8IoSXplNsBbq29dJIgjtxEgvfcSyIH5Ur94SJsCK1LNCcyI
 Bwsv2aFoiYAyiPgAUPJSjI8LAFvJodlb/p//AI9iEXSHiNJMoOgJ3GP4+6g+R5w5iUN5ltu1AWl
 sH1tQKzoukE7VxeTudxSZn6779LgW3dUlmaBqfNJ0nBbmUovXScVGdzAQhbolCStGEpcmufF5/E
 WdyirL5DxmARafCIgkV6ZKCBxwl+uh/1c/D4wyIn2vr6UnUkJE9o+Ow5aJfrUHjjlIwYjbcVjZe
 e3jUv93xAX9g1aAzw3zvaBYYtZAK77wNoBi+yjvl7Q4jzEMgBQjIRf4UnlQmJnOSRQkXYOsQUjd
 GI4AQnB7kFrY7S/zk+q9Hwhj/c+VFBSNcSZSt8wfMPeRyEfzqIGfB2F38Zkfk5zqKfwShZRjlQb
 6ZUSCFLRUXo4IMRBDQKdIcna+YjP//n9lFSrNAFxJ0cw==
X-Received: by 2002:a17:90b:5886:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38a20e414e7mr7515604a91.3.1783688501985; 
 Fri, 10 Jul 2026 06:01:41 -0700 (PDT)
X-Received: by 2002:a17:90b:5886:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38a20e414e7mr7515550a91.3.1783688501265; 
 Fri, 10 Jul 2026 06:01:41 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm9611839eec.6.2026.07.10.06.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:40 -0700 (PDT)
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
Subject: [PATCH 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Fri, 10 Jul 2026 18:30:44 +0530
Message-ID: <f2138f531f42071613f2c71ccb34fe0548677924.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4DJTWATBEjh7Iyfz4iXwJ0p1xXmLFDrg
X-Proofpoint-ORIG-GUID: 4DJTWATBEjh7Iyfz4iXwJ0p1xXmLFDrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfXwyXaNVJDDwN1
 VMnFadTX8JbV7hIo2/vTpt7WmM84/L9paMY4idT2l3WdOPFZs00cYxr4T14BdGXVdAwUAPj79RG
 yqg+Sn+DibHYUifwCud05t5X+BFK9PGBzlcO3SOw+0xU5yFx1Sf9qUAh6UjpMCjemqZsy/Lsc9z
 j0e7skDSYcd5ANoNTRnnJVvtWwYI9LS7zcwmFurB1pNcZvLX0tAOtXWEQuhhsEV1lXjI4dBCX28
 5ZbLZlHEWqmAFRuzrLT/sp0GOMZYO8e2O8ZoaYXBD11ZSBVpqmZo3wptrGlTANHWc2pe9esCtmT
 /y/BwWaBcmOPqsmzK5PcZ961pvI1F9PlVO3sEhZg0/8tK887ujqR3BxR7LjcD42cKqKzbenMHry
 UcmmCvLqHzFvOpw9bnC/cTceLIgEf83dlkH50xvN5p6h1OWpztSgu2IrHh+6nSo+bOgLknmLVYz
 k6hzLEFDn1JwECcGGjg==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50ed37 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX9O/Ir52W+pDV
 L6Dl1Tilcbzf50AqBC3KzuY2ZsyzwT5i4opsDHYHw3OUhdK+Q7xlEhmsqLJHOQORC7vvqLcRwAT
 crjSvKsoPoriOXhqENyPDNygR9dwi1E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100129
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
Message-ID: <20260710130044.B2FfbLv1O3KXYIAcGmSMesrNjdDSmSsrvf3fJOEr_rA@z>

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


