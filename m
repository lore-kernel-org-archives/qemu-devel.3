Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lqJ06JVC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fv5865Eb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Sv-0000eP-2b; Wed, 11 Nov 2026 01:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1SR-00005T-2a
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1SO-0000nD-2R
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:18 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KRQM3959068
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XnULDxJNLVI
 GuUlQMbNfMF8Lx8SNYxJmQC0ceMKTdcw=; b=lqJ06JVCAaxWGe0mMr1oxzGlR9D
 sEHsn/d24Z4ncaUyt7SX5QNvJb2Oxnd1yUZoqeTg38YDhHALRCTrQ4vwcHE5qfJs
 ZfFXd0TgFwSlpJqZApdwZrB1rlJ1vZ6Ceq0a1bCzPoGTYwz+wJVsDZtfFwafGBLF
 c3Rs0/bgmQxFG9KXz7sTuy576ms/p30/lo2BtmJ/vwLQJXqpbLU+AbafHXOKDYAP
 0HzBYE/f31TClEQXGSxtb7PAplqEcky/8dOd/OARyiMe+QAqM/V23QrtXOSqNgAb
 DAr1cxap53N/P27rzu5vw7bML+cA+eRKEGTvNKRu001Ys+UxlfuGUSs06tA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b323su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-339628f2bbaso34843eec.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377114; x=1794981914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnULDxJNLVIGuUlQMbNfMF8Lx8SNYxJmQC0ceMKTdcw=;
 b=Fv5865Ebtsirnfnrt2RF16Ey/dibBx9ZSjS/RwsKvQMchemTFjw0mIykQmDBFttiiz
 1pS0+3m4QV4ijmAxnRWwhP+T/Bmn+fOP1kt1rEQ/WC8TuEmWnfnH3KBEcJbnnid1zhri
 uG8ChW94cBlAZQHvhTULDtuxz0e320QkV2qU1/SSPLEWUlvBxbnEjGdRXPdwgEIHmzdb
 n0gWVxhneQzAoaxxpHRX7z9gLzgUvYpEeJQnpcY9i5TZae6IG7e2bBb9JwB0NchGVYsA
 u0ur0WhtMtaTe+yYHcy6K8UAMyzGQ00HG4qJKFFvi17BXkDdHSBKp3BmXo4oWBq5bgcg
 WVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377114; x=1794981914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnULDxJNLVIGuUlQMbNfMF8Lx8SNYxJmQC0ceMKTdcw=;
 b=b/4V+QFxKBwelXCDLP5XA1+wvl5OKyFTqkjlRJvSNdiS048brwqj5MNPox/vDPZtwu
 Dm1o9G3B9dnHE4dyhefggSXm7E8MYMS4FeDUvjK0zKiTKw1/15Ti83mRa9/HYdf/ytdM
 +hQrZkoS28Jij57DlXEOg/pgDM2vQMctE9naXpFL6rnz7jNY/UJYxknWU1kWmvYQA7xy
 /NsyuPSXQj+i/WqyOWnbAYIvX1tA5rR7s0NQ4igD1yOfWepPz/XP5cc5isSDNWFlN1wO
 FXo6qWYeBIpDcl102nmhmC7rXrxtroGX50bFw5iaOGc61ytNIbfuawQbFIBPJyvdu14U
 dBPA==
X-Gm-Message-State: APuU4Z+2GKbnSeKGLX9kSofxvLF1P3wUqu1+ff/Vvipr5zFtXYw3WRzA
 X9wem21iyo3fbJJPVrru+mKEk3QFbPITm+aqygEffcFt66WIFzDJZF16visrSGCcFZzRj4ZE+hQ
 dt9yirIyTEufMkJnrhkJ9ai6zjACXh+rDa2u5r4XVaxDh920UHRZpXAaBLb8Yt0hO1g==
X-Gm-Gg: AYBFou2psJL52KMGaQh7/m2PSV4TzOAVR32XM+ALPk0rbbUSZR1ZKIHRPO/r73G58/H
 HBMEZTHCIi5dVmCwJXas6jio3J4+6RWg+WDEnVTelkoG4b2qr0NrJlPNreHawO+eON6NCAEzF+l
 Pi9LnqzfR76dN5q/WLJXIz5IHA+bwtIkHJEpbxiXehYaYZQFdXwxR6IL7Ug0U8HyZ2uEdkY1lMO
 hnJ1JmaxdBDdCg+w/kRBygTfHjXyvd1tQ1h0cq1DNMt5tKhepCCt5KEzHmDSdxp73+g9eCFP16T
 VrlfhwUYUd7VgqeK8/gqzzG8/H51gtwsOr6IFsyOuK/W8Aa6whwRADj0sR0niGl+3kmZDcIVG/q
 LygbHR6qjIwmsYdpRlBA6opLzD9vIIl+CK13m8JaVqgxKeYqO4N7ow5p3m56hX1zkuVhQF5v7Xf
 ZD7cvK7OnR9S87xSfwp4v15LobyxlDshViLbEG+ewMUmuqrQ1Guw6JePhwZIpT51r87E6lN5kUR
 ZUOcKQ=
X-Received: by 2002:a05:7022:7f0f:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1b3c02e8f3emr2376880c88.2.1794377113349; 
 Tue, 10 Nov 2026 22:05:13 -0800 (PST)
X-Received: by 2002:a05:7022:7f0f:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1b3c02e8f3emr2376846c88.2.1794377112704; 
 Tue, 10 Nov 2026 22:05:12 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm15067990c88.11.2026.11.10.22.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:05:12 -0800 (PST)
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
Subject: [PATCH v15 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Wed, 11 Nov 2026 11:34:02 +0530
Message-ID: <20261111060403.3777501-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af4059a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=lsuYGQq57gzD3Ej6WjEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX727D5NTIx9p1
 Pn+mR0+fITeDXrwk5MP2X7L1ELk3iBCoH9PJjhSiaj1yP/1/eurgdPRsa8lRlmKfQt4eoi5ABZt
 PrtbIVjxbcEXQeEJpSVk5Ml3TF3P4qBusxsr7uAp1WMIvGlY1uepcT5WoOAOowLLjHonjtNdoFa
 KGuDKtPKA53vEphnbrAhB9xqgTa6iYJQG/Xhf81ge6YL+q5z8byIbTLgTmQs+VGPEqMD8icuowP
 /zPN3roDv4YaVAKeCEEi/y90IY7Ec26WlAB/0pzm4dIM0f5uEguQKqYgpqk/eMRltHcC1Obr2lY
 8dZ9Pm7T0gROmBCA71y+ATXCnC6mdggox7FhyYO7EkQfRZy8Y15wYtvQDcDHmBc3itMhX8/qoTn
 00Pbkg7rR7S2tCbKf9ehsP2mM6NyaMQtseZlcO03DSU5z0cNye3z2bnlTLVy6ldo3D+zqb89ngA
 lAk4xqmVFm44zySFFIg==
X-Proofpoint-GUID: RzKQ-y_rtcCbO12WUCiHeyNOHGQoindZ
X-Proofpoint-ORIG-GUID: RzKQ-y_rtcCbO12WUCiHeyNOHGQoindZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX0eV5sjmgvANA
 ZnoPic84BgC6+Qu9yla5mpX1tE9Jv5mOlAdUgZfmbRWphemIyOoHpA1uwQiANQIfhsg1GGBKYGR
 ywJcEJL1tRgG+HA1TW/oZF77tpOXf+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110024
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
system suspend, and system reset paths.

Require completed CPU offline and online transitions for HSM stop/start,
repeat the cycle, and stop a hart running a busy workload. Reboot while a
secondary hart remains stopped, verify the next boot restores both harts,
and repeat HSM control afterward. Also cover HSM stop/start immediately
after suspend/wakeup and a fresh suspend cycle after reboot.

Reject definitive OpenSBI HSM failure diagnostics instead of accepting a
shell marker that only appeared in the echoed command.

Linux can report CPU death before firmware reaches STOPPED. Bound retries
of the subsequent online request, retain transient errors in the console,
and require a completed online transition rather than assuming that an
offline sysfs mask proves immediate firmware stop completion.

Allow the outer Meson timeout to exceed the test's 360-second timeout.
Fail immediately on the suspend failure marker, and split that marker in
the shell command so echoed input cannot trigger it.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 269 +++++++++++++++++++++
 2 files changed, 271 insertions(+)
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 211ea9acfc..b7c2a29ead 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -5,6 +5,7 @@ test_riscv64_timeouts = {
   'k230' : 120,
   'server_ref' : 120,
   'tuxrun' : 120,
+  'rpmi_virt' : 420,
 }
 
 tests_riscv64_system_quick = [
@@ -21,4 +22,5 @@ tests_riscv64_system_thorough = [
   'tt_atlantis',
   'tuxrun',
   'milkv_duo',
+  'rpmi_virt',
 ]
diff --git a/tests/functional/riscv64/test_rpmi_virt.py b/tests/functional/riscv64/test_rpmi_virt.py
new file mode 100644
index 0000000000..a5aa0f38e3
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,269 @@
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
+    @staticmethod
+    def _marker(marker):
+        """Build a marker without putting the complete token in echoed input."""
+        prefix, suffix = marker.rsplit('_', 1)
+        return "printf '%%s_%%s\\n' %s %s" % (prefix, suffix)
+
+    def _assert_no_hsm_stop_failure(self, output):
+        # OpenSBI may report STOP_PENDING before its state reaches STOPPED.
+        # CPU offline and a successful later HART_START prove the cycle.
+        for diagnostic in (
+                'ERR: Failed stop hart', 'Unable to stop the cpu',
+                'RPMI_ERR_DENIED'):
+            self.assertNotIn(diagnostic.encode(), output,
+                             'OpenSBI reported an HSM stop failure: '
+                             f'{diagnostic}')
+
+    def _validate_hsm_boot_start(self, online_cpus):
+        self._run_marker_command(
+            'echo RPMI_LINUX_HSM_START_BEGIN; '
+            'cat /sys/devices/system/cpu/present; '
+            'online=$(cat /sys/devices/system/cpu/online); '
+            'echo "$online"; '
+            f'if [ "$online" = "{online_cpus}" ]; '
+            f'then {self._marker("RPMI_LINUX_HSM_START_PASS")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_START_FAIL")}; fi',
+            'RPMI_LINUX_HSM_START_PASS', 'RPMI_LINUX_HSM_START_FAIL')
+
+    def _validate_fdt_service_layout(self):
+        self._run_marker_command(
+            'base=/sys/firmware/devicetree/base/soc; '
+            'if [ -d "$base/sysreset" ] && '
+            '[ -d "$base/hsm" ] && [ -d "$base/suspend" ] && '
+            '[ ! -d "$base/mailbox@10200000/sysreset" ] && '
+            '[ ! -d "$base/mailbox@10200000/hsm" ] && '
+            '[ ! -d "$base/mailbox@10200000/suspend" ]; then '
+            f'{self._marker("RPMI_FDT_SERVICE_SIBLINGS_PASS")}; '
+            f'else {self._marker("RPMI_FDT_SERVICE_SIBLINGS_FAIL")}; fi',
+            'RPMI_FDT_SERVICE_SIBLINGS_PASS',
+            'RPMI_FDT_SERVICE_SIBLINGS_FAIL')
+
+    def _validate_hsm_stop_start(self):
+        command = (
+            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
+            'if [ -w /sys/devices/system/cpu/cpu1/online ]; then '
+            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ] && '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_PASS")} && '
+            # Linux reports CPU death before firmware has necessarily stopped
+            # the hart. Preserve transient start errors, but bound the wait.
+            '(attempt=0; until echo 1 > /sys/devices/system/cpu/cpu1/online; '
+            'do attempt=$((attempt + 1)); '
+            'printf "HSM start retry %s\\n" "$attempt"; '
+            '[ "$attempt" -lt 50 ] || exit 1; sleep 0.1; done) && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0-1 ] && '
+            f'{self._marker("RPMI_LINUX_HSM_START_PASS")} || '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; fi; '
+            'sleep 1; '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_DONE")}')
+        out = exec_command_and_wait_for_pattern(
+            self, command, 'RPMI_LINUX_HSM_STOP_DONE',
+            failure_message='RPMI_LINUX_HSM_STOP_FAIL')
+        self.assertIn(b'RPMI_LINUX_HSM_STOP_PASS', out)
+        self.assertIn(b'RPMI_LINUX_HSM_START_PASS', out)
+        self._assert_no_hsm_stop_failure(out)
+
+    def _validate_hsm_stop(self):
+        command = (
+            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
+            'if [ -w /sys/devices/system/cpu/cpu1/online ] && '
+            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
+            'sleep 1 && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ]; then '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_PASS")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; fi')
+        out = exec_command_and_wait_for_pattern(
+            self, command, 'RPMI_LINUX_HSM_STOP_PASS',
+            failure_message='RPMI_LINUX_HSM_STOP_FAIL')
+        self._assert_no_hsm_stop_failure(out)
+
+    def _validate_system_suspend(self):
+        exec_command(
+            self,
+            'echo RPMI_LINUX_SUSPEND_BEGIN; '
+            'if grep -qw mem /sys/power/state; then '
+            'echo mem > /sys/power/state; '
+            f'else {self._marker("RPMI_LINUX_SUSPEND_FAIL")}; fi')
+        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
+        wait_for_console_pattern(
+            self, 'PM: suspend entry', 'RPMI_LINUX_SUSPEND_FAIL')
+        self.vm.event_wait('SUSPEND', 10)
+        self.vm.qmp('system_wakeup')
+        self.vm.event_wait('WAKEUP', 10)
+        wait_for_console_pattern(self, 'PM: suspend exit')
+        # The resumed shell prompt and suspend-exit message can share a line.
+        # Send an empty command so the console always produces a fresh prompt.
+        exec_command_and_wait_for_pattern(self, '', self.PROMPT)
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
+        self._validate_fdt_service_layout()
+        self._validate_hsm_boot_start('0-3')
+
+    def test_linux_guest_hsm_stop(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        for _ in range(3):
+            self._validate_hsm_stop_start()
+        exec_command(
+            self,
+            "taskset -c 1 sh -c 'while :; do :; done' & echo $! > "
+            "/tmp/rpmi-hsm-worker")
+        time.sleep(0.1)
+        self._validate_hsm_stop_start()
+        exec_command(self, 'kill $(cat /tmp/rpmi-hsm-worker) 2>/dev/null || :')
+
+    def test_linux_guest_hsm_stopped_reset(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        self._validate_hsm_stop()
+        self._validate_reset_reboot()
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        self._validate_hsm_stop_start()
+
+    def test_linux_guest_suspend(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_system_suspend()
+        self._validate_hsm_stop_start()
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
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0')
+        self._validate_system_suspend()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()

