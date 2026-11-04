Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4E606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbxOi1Q/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fugmv1RV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTDA-0005et-KF; Wed, 04 Nov 2026 00:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTD3-0005T7-NN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCy-0002Fb-Nb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:51 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40Rlf83867864
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dSL6nfK1EWQ
 YD69SBse0aWzzU/cjJiK6qtAlh0W5j0c=; b=IbxOi1Q/Sytu1JMLZ7uWU/G8G67
 ig5XAhH6chG0YPPoMSyORUhcHQ9hHPqujpsL43H8H1JzPAsh8BW5JJbBXP8fd2dF
 Xzv+EQftoSwC7SkvInfMDDtDHJF98fl8p6aAhiCfngMZoi7P42hCiTa7P3d05s1d
 VweT7NPNf5+ICSPTIuAgTzQcyJY8ZxWGl7SFwhsEG1QaFgk8CZYEABxwRPLbxe9r
 n0pqa0Y0WwpcJ7ScC5q2BtTtH3PoIiAjM9vg4Cs+0i3NK9P5hd0MhLSPlzk1Q1vz
 pCO9Xe+IeqtxLG0G/SYUooqFWoTeZgaDymGlS7T+BGwa/KKhn64+LQwIRfw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y206j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35d7e79abedso25143eec.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768796; x=1794373596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dSL6nfK1EWQYD69SBse0aWzzU/cjJiK6qtAlh0W5j0c=;
 b=fugmv1RVsKjHAlavjT1t5Apf139gKkiqtGk2Ssl+YxdbGhLTdRjStZhWq2NFbohdhh
 gTcOirTrFWnUzEAIrU6wrnX08yboOUF+eStNogTrxbDe1fVGvGeUF2/tlXAB1eWGTIEr
 w+4zXYs0NG7g0ArRzR3q5ZFz/FXBGwN7d3wb+GXEFQrKOUqVVndlQwcEpcPsmtCUG1c7
 +/eOCXS9GC6kCQqycCgKDLjW6InxW836tg91g+FavDtn7udJ7TYO7FBkii/l88b7OK/r
 TNIUvvw2DU4mQhTlXxvwY+tWTKIEyGWxEjdcwjw80SUdjJ1TK+Dmetgv7KhYAzANnlVK
 wy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768796; x=1794373596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dSL6nfK1EWQYD69SBse0aWzzU/cjJiK6qtAlh0W5j0c=;
 b=f2zkWRY3+Y1bItXwiFcDTuMFKvBX0PlNYxtd7YaEgb8LZawTuBOYEW2Az3VKKGpj2v
 Yn5AizUiPBRG3OpOIencw7uP1KHxKZSBek6Jic52uwkQmWEMramXuaYlQGeDdqXEyYbm
 /P/vXxnmPUxQ7N7r/mS/wo0vpe+sIZbTwHaRiE5jGWmiO+I5CFmdb6nUu/prMOQ5GaNQ
 Wz4iMILfba+MDWNXsKsasnZaAAUh12aGyWePVVPkrnEC2MOo+s9Okdr5GZDtDKkhFqit
 JcBoUZZXl0g5X/zzYywTQkVBLifffs7hZ2/dHeQ1x9CEd4D5qhvq17KslxdIJz0WFL/a
 Zvag==
X-Gm-Message-State: APuU4Z8Mwt7EQQeajyE1gDZ1RhzirBe7V20unBYcNVXQXw5tqyLS6i8d
 gyUfeekO5T9tu62VRVVPRKk1Iia/RY6sc4h+SgG2Ui9Y/XSYrid2OL5cy1HX5F+H9++PDUn4lyQ
 pfRcHo++pKg+gF1LnDBosW+sf1mw77p3PjZ0Lkpc3oqkkgJi/4TbzNR5vCyHCAfXhZw==
X-Gm-Gg: AYBFou3o2sRUh6brN8qOpjo+LNlMmHJo0wHl9XZaYFmXFOTiuwvYJ1xx99kzhJZFIcz
 6vZFpHxEWNFmILL1bGrBNvU6natdXvnHhT7civRY06/nEBgkPiZC5EG6v1RKOPQH7a2AclDVdpj
 1GX0OX9so9MxGYTzoZjeUM6dz7DbtUG2nXQlsrdQdMDzOYTDOfqjACHPLDtmpbeqDvsP2VyQxvY
 WbgKxDg6FY8vgx+ViPfNd0fAvajAi7PaXsRE0lNxG8LmRrOQkWx420vpStG/oCBMjLui2DYMpqa
 i4yShaRHoZ3hbc6gJ/0yvGYkW2QmKH1k3JWvAmPgnoslGNiyCSa0EY/nB3cRcIr+dP6CgY3A0jp
 j9ncE9oy4oVqDP0fg5ORJ87YY5CyZsbXqwKNW1DcYREFnN0P0xnZe7Qdy5whawIgP96hrvnkDaq
 hZf0gLwPywCamp93ipYTDMX2ccllG8fh+0+oXrt8oYnZU1fixOq8u3HDEJQpW9EywLDrw3VZJVi
 5MriDay
X-Received: by 2002:a05:7300:ae18:b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a4235ceddmr31093778eec.2.1793768796156; 
 Tue, 03 Nov 2026 21:06:36 -0800 (PST)
X-Received: by 2002:a05:7300:ae18:b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a4235ceddmr31093732eec.2.1793768795525; 
 Tue, 03 Nov 2026 21:06:35 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:35 -0800 (PST)
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
Subject: [PATCH v14 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Wed,  4 Nov 2026 10:33:23 +0530
Message-ID: <20261104050324.733555-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5bmJ3XPZDLHD_TlJuuXmdW-XTHt-2Ae6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfXw6jTyI0N579W
 iyuCRCvmsT8yclzDLEGuVulOhCLDME1YihKvzf1Em9MInWyQYaPx1xtUDz4K3UU46tnB//S511i
 zhWZu5t/LIe7XTbUrVzLZl6+i7axDoO0zBXpXhFUdHIIH9gO5MAEtGiXgajJ//Z7QkwC70UNlR7
 c08GW+CoQ1N2V//SkIo9lBquUpAvBPV3saqkRhLacLkfyeIpjsmSLpn1uq3VdL6356YeI2hxUoN
 sH6MIgMPKs+mnboj7awbfVPJuE8M2kOD35/ohQlXGktBLZnh0xBNbjiG+nXRBsFDZKpLowP2tCU
 kbEFUSNVQROKNGW+tVxFFnnC1SYsHxivmJ0vFaQUBkB/NF0UKg298SrzpfvbN8us+8EjUSOlDrV
 ZkKCNmXdhxswHO1i26F20jmAnK3mrRIWaztT+mP22ocdGg3ir5VLHzJC+8+WY53iaPgE2V6sKqz
 2NDQZmdQPm9eZeI58AQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX5jaXjXpiQoWs
 IFlnV5Wds8YxeRhivskl0ZW6eLG7+fCbUG1h3aAp1deaCkO/jWyO5Cwd9f0zk6EYN8Xnv/R41Lm
 9U5uWAep6DZvG9u+H3J/JKRuGlOPJAg=
X-Proofpoint-ORIG-GUID: 5bmJ3XPZDLHD_TlJuuXmdW-XTHt-2Ae6
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeabd5d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lsuYGQq57gzD3Ej6WjEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
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

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 268 +++++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 211ea9acfc..565f4a9dd8 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -5,6 +5,7 @@ test_riscv64_timeouts = {
   'k230' : 120,
   'server_ref' : 120,
   'tuxrun' : 120,
+  'rpmi_virt' : 300,
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
index 0000000000..1e098e8b33
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,268 @@
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
+            'else echo RPMI_LINUX_SUSPEND_FAIL; fi')
+        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
+        wait_for_console_pattern(self, 'PM: suspend entry')
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

