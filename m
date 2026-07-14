Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC87DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY2U-0003Cc-Fr; Tue, 14 Jul 2026 03:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2S-0003BW-R9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2Q-0003fa-Vf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SfTs3887535
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SAwiSPzNecI
 WH7dGTHRFj1S68/IHtuU2S4EkHwOsoo8=; b=oOOigcMCFQs+uoO49kKN6HME6Fy
 DzUW5IZdgtd8IYepO5CG8VhNHSlC+GKgVg+Z4RQZ0zgfB3idzxTZq3/B4OhLHkNl
 EJhlEspuRmPtSU/djIV/pVivXNoEwKymA+aJDaQ3u26c53IPLKFj21Si5v14KOUL
 7zr2b/1tmC235Jm85PpwX5oATAynxlsDGGq4A9YV46fFcBEmJSbZhUVJM55vpzqg
 c3Z1SV9oTppcMLvPlQ6H7H9UzcLU7/j+xrlBLSx+AsihGBavcjkTFhZ/15XZ2kWh
 9b/oXAfDeQ3lvd+gu70A6zZ/bs1PgPvMYUBDSpV2G8OTg7NSqyTj5dMnB0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4984j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380f3670853so1309339a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015915; x=1784620715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SAwiSPzNecIWH7dGTHRFj1S68/IHtuU2S4EkHwOsoo8=;
 b=VxdLFkWFsxb8kh+9nEeVcoEOkj8/K3W8pLyplG/0AbxcYoElVcTVRFdP+IEYiTdyGV
 eRkH6gchWICY7EeXqAHWQdsjVsI4uB4cAZ7PKHWzURFonKmqk1fnwqpTLdT+9Ocb8io6
 pD5iQKj6JSGkx7CRDRyKlOt8ee0wZYH222oxR8bXpmCUZU01Cc06NI58uqpcscsVHyWj
 zPlRf+gsqFDJ7NKsCaHuvoAaYIfXeEqG+nBfz1HZfiKRj86G/QGfQsq/LVGd0cKT0HL6
 7OCzrHvzDJwYGcmfFjTGm1oNdzfmodl9d3AC+IEaXQpZZ5AU+pb7WOmCG97bW4IsADpP
 tzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015915; x=1784620715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAwiSPzNecIWH7dGTHRFj1S68/IHtuU2S4EkHwOsoo8=;
 b=Gko4+Vc0VCsy/WxGMklH7Ay78hqyBJEAM8ABGdzas1PN1w7DoOEa3cr/cY3hIm3r84
 VnvKN6xRvN0M6F/WNyKDCMWmebqiDPe/On6yVxDq8bliYo/alB9kUzqSlpgBHKWfxtPV
 W7sS/kU5VTe+fQaEbBOYY2IEugiqYmO0/veMURZAdWmgRMO4AAERj3rxE4Etpp0CpoTG
 +JqHApm0YygwUNOyc3vVrxKtc5Ii5x9B7GXdIxJjH3+zJ5PsvxOrS8zwsv/LO5W6ajNv
 OKyv94dxW9qsJpCLg/h0/NoTGDZAcM6jsldKG3bDzm4kaUvB0Y7yD64lwaAKm0rn6RXp
 uiYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKM3mVY8gHiDf3P6ruh3qIga2vy1kursSDhZyfEte73ZwzD2orcfG7jrFqlqU2HUerj/nUmNF1Dj5U@nongnu.org
X-Gm-Message-State: AOJu0YzSWLdMbNrY+Ac43m8eBPDN5fze+sCBrbu2IAWqeg9Ejamca8mu
 tRdSf1lyTseCnpUDUGov3qbnWXZ3zysjjdnZmDqvJC6ezy/N+PYbbPVrCfiaHbRfOGqBxXa3Fsy
 VQntMjJmqBeW/5yQIPRixRsE56HEpFS0rWwB1pDLIUw9dADSsxQCmsR0qDg==
X-Gm-Gg: AfdE7cl2nTmt/brI95W4PQ+8yHWakj8pTISGZTDJBEwptRbo2mth4I+y91Uztlkh5oW
 zpouj+ei3aEkbmMMSA5jP9Wgv/FYOemAZw5xqxesA4UJ/sHBgm5+eXSs07LcdtbACxeo6cqVDT7
 vyR6nMbirOR1WL0HKjZ3h9KUDl3P76e6mXbzYZD9XDTyFirSgP1GvyoycOenDFbZ9PECd4I+juh
 Ne5o2EvW17Agc/nQbChipk7BerkaCY3UDDM+N6YJWUyVY94MvGNADqS2nYPVWqXQiTvzesJG9s/
 JP/raixdRZdLFFoSe4Lo3+rqSqGWwfaiDNl/p+ZsETJrIHHYVGO4LHsldzsky0WnV5ApO8xu3RJ
 XKR+pzHCw7kAJnBmV+qaGz/vd7c/yMS+21R20hOBvNr6iDHq3te0LetTgHGp7r1zzZWpXcV+u6L
 iI5B9tfXw8jUeEY2eW/SQ/jT9G7i4ZKGCm5MJDuLzx4Q==
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id
 98e67ed59e1d1-38dc780f503mr9919980a91.5.1784015914775; 
 Tue, 14 Jul 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id
 98e67ed59e1d1-38dc780f503mr9919960a91.5.1784015914291; 
 Tue, 14 Jul 2026 00:58:34 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:33 -0700 (PDT)
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
Subject: [PATCH v3 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Tue, 14 Jul 2026 13:26:59 +0530
Message-ID: <20260714075659.2258023-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dVxtCYi9L0BmFG-FbT1Nq_XsYvFEf5HJ
X-Proofpoint-ORIG-GUID: dVxtCYi9L0BmFG-FbT1Nq_XsYvFEf5HJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX0AENv9K8q/Qo
 TEJSMQZKuQSqu5THHH76X/9fEpLXTGEsbdhtX3zaO5jfHv+nIx9AykxFlE89MoU8q544w4yp2Hn
 sRDA6Q9HZGn+C+t0/rtealfcgEgp4sYqIe0XfNsZFVWUaIorvLhUyP3ygSuFIStZIeClXrMUyEc
 JenOD1Ri93lMhhnfqwErq5uJTVxW+E7IxMz9mrLO5631sPBIdd5qnyyArW9Iw3DrhWSCsppHPWt
 lyLqCGwpF1E9AL3bnNrGWrjAAg32TcGoF59Pp+msrLok3z1gXhVUtIFhzcAFXkSlWyYQvBiMOiy
 PrYCMBTwTi0DPS4ksh8tsb40MXxZEALmQZ1Z0gdgiZlcgCgs0t0t/aaBRCjW3HRoc0Wmy14CLtd
 bgGqc2wwpT8OV19qaLYiUQ+arThNI/LXF6S5HbSxh8DCoXBgwPX+ZT8qkbU2mOHqcuB6PGa6mQY
 csBo7e07uMI9dbskDKw==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a55ec2b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Cnp7e1vNUpDCZbjFkkcA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX+DRgnJx4XVzp
 Q3xCnvnoVhuxWyyvFDbsyE0/vH2BKgtiWDjCoxoAoWd5Yhr+yTxsZ6OkwnCe24CStwvpxLrIiqG
 Yt4V+XKRZYGFPb/pQ5sLt1FxYnr/fvs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140082
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


