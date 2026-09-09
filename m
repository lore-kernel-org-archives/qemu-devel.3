Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF1FC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PX1-0000zn-KJ; Wed, 09 Sep 2026 17:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWo-0000ya-5K
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWk-0000XU-Fr
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JI3Bl4013481
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 21:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EZqQ5JYYnmd
 J85rMgpUXB3OQ7aPO0YYpI5JTE9zBSaU=; b=eZLl7c+duvqOfF2hcOyiXSuJip9
 vZqBNrfJV3vx65d3U2NwXX1ssHDzJAPKnBEVIjGSq3uVn/KKuqK4M4jmmeT6KoSx
 VRw7K4Zr23adYYEvuHG8K69WGHJUueBHF3393AlVfaedvj0t+McmeUvv2aXq4X/j
 JbisTziqNmO0OPu67O/WS5d0K6PK2TpfVw8pSVHdzUYN58ERt9UT5/lEjMkpObUd
 FMIBrF517PoyDEjdj/AUTg3X3SQsa+SZ9aMUeBisYMAsTdnGEInBOaD5odx9KdZN
 O/Wnz8bVrrkYUeEmNR5j09kXlZFZhbtuG5JC1DUJjanZVzdO0TDUWjPmeMQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyh8k0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 21:08:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939d677af5dso54809985a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988096; x=1789592896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZqQ5JYYnmdJ85rMgpUXB3OQ7aPO0YYpI5JTE9zBSaU=;
 b=J8A1q2ZBzGr3q1FVrSJyd/zEdz9paYmVN9orGdj3HJKniuuEXB3R+TCCT0EY8q6lhQ
 I0NhE3ml7O4hE74kQy8xdJ5VX5a1PHeEthyz51gC/dHlTkg9E9CMuW0sX7hY0+/XIHPu
 cDyJOdLTTtRnqRkBmqIVOhNUpwSRn6eK0tbpkh0tOmrbLGWgHeM/W2bTrp/fHC2T32YS
 w061qrqoHsW1doc6+cR+KqL9rF5sRA3k0MT5fV1ihPx31w1hsZBoDRFuRO+NUZC9Xz8i
 V4jAYZh+nTkRwf9Z394YUwEE/ZqiLMEvIYIBiI0BtkH2KdbD8tmz0NIPduoRNL8DpHrU
 sPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988096; x=1789592896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EZqQ5JYYnmdJ85rMgpUXB3OQ7aPO0YYpI5JTE9zBSaU=;
 b=OjUigX3AfUg5rUdxjArDLwQCraxgCmFANM8XrtaEtXzQctEvRhAqnHjuzGyLMgnJsS
 lgVC/an9lsCW30SFzTw2eSVFarlQtA1i4K2ca2v6bNS94WU6WBZqZ8+cZXrNJE+dcOr3
 BvKqZe5b7jmsP2pjsaWYUZ5wEdFNTRsRLrLY8AYQT8Tq1lgH+VyVuZQualyPHOe/kGDb
 c+vUrBdyq7KvFXItkJmFOKU5nec9k7JoIoZleBsYvXeAr5au+m93NXoldO5ziYrEhz5P
 A5TadCQHOg8mrsRJQEhgFMDemf/4YNqpTj0RqihbSGsk3+TgCS9Nk/U2C+2X0Qsr77ys
 6zxg==
X-Gm-Message-State: AFuF++l1de1ihEGy2VSAZOVJZUBQVDZBqcbGYN/KTGIEKMnIn9KM4tuz
 KaaGOkSYkBoNPQhQjBwW+Wpk+cYoN9bFBEzLuarpeMM9Y1lc68OSMShxvuxIGYXwrsbAJ6YMyhO
 h2iTcWrUwQsW3kO121U/D1EEOzlADrsnyhlZfGbEO+LfQq974GncXT45PfKGpA8fWWQ==
X-Gm-Gg: AYBFou1tBROWADmxWkUTzWSBw2qkm272iqOlYeepa8eS64jSFer1vSxuXQ/Kr2hTCjh
 40nYsnszYyHcljeB1hXsGfi66wdCAbovG+18vaJkFC2O9SjE5nxqkmZIvfxjR37j2ShEM0Oo3J6
 n/RKxgbER1pm0sb8xTLOW8VgWrz6XinagQAzUMOwBiJHcN3T1lUdgvZzRGlIUFE9caz0xWAFTne
 sI8OrtkDNcglhiGMbN6D/w/f5/7KM7wZemJg4/eKySdHWcLrquJNsCVCCAzV1ZcwtdMrAp7OpAf
 Xzjx22IX+Y4hFNUCeotFooWcIju/lqk8MS15zzfAayDIzS73yHPXQy9r3cu4w4wJllCS5vaadn3
 UpVmve7VBtJWpUBjIrWVtUB6anmFz+1sLgJ0G
X-Received: by 2002:a05:620a:2809:b0:939:72cb:bae5 with SMTP id
 af79cd13be357-939d7f8c7aamr173913385a.28.1788988095860; 
 Wed, 09 Sep 2026 14:08:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2809:b0:939:72cb:bae5 with SMTP id
 af79cd13be357-939d7f8c7aamr173908685a.28.1788988095410; 
 Wed, 09 Sep 2026 14:08:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040646d59sm151811336d6.8.2026.09.09.14.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:08:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v11 4/5] tests/functional/riscv64: add riscv-server-ref tests
Date: Wed,  9 Sep 2026 18:07:54 -0300
Message-ID: <20260909210756.1767711-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfXzgDc0mGSndc0
 J8AZOtq7Gxmyv5BM/mmiRbLT8xmVs9tF5feQaPtoDe6klHZ0NeYGP7WOXdW1bQfsr3ocJoURJ7d
 MM2jXREIBGMzYMwUYUVvCZFZ8Wi5IZvHZPdJXY9oldeawTYIKOtx34flxHuN/iyB1Zfj+ijhN0n
 GdK5eyAQ+pBEXv/lNlsQk/8whOHHv59m/l886mzDq/L+5608o7OooT9F/Hm3npankvvYZXc/D+L
 KbhbXSV6lQxG0xwNAqHiof58hZ5scf0swgyr2psKFoWWUb8NzW1/y/mmj+iVeBOABY2khiIleJU
 TaqgxUa6Z5kFYfiP6ks+hd8Y8eKiAJWd6wqtAFmmLLw9ZMB6O+paWjzZ4e1BWxlmCMFPXGkuJ6D
 HiAKxJGXMH6ac7ivYmBN1t5qlvIvQk8Ae8fPyFEpWXMPnBuJWX1o8A1KRzk0YPG4KxdfaF19C/l
 njG/M5h0lAxs2hWSjLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfX6rBKwRm4iCy8
 YPstuXbIeoBPvfgOKVQ7rdc0Q+dzHMD0Kooeh8QAM55p06kIEyCupkLsj1n4NN1uEskHqaY2erK
 GxL5UybAceaLN4KhjEv+MlGFMeW2xH4=
X-Authority-Analysis: v=2.4 cv=YKgKWhGx c=1 sm=1 tr=0 ts=6aa1cac1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=JF9118EUAAAA:8
 a=QOu4sXKRH9_VvCpQA3IA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: sg8DpF5FB-na39PROvFk6_BUAAzbLAMl
X-Proofpoint-GUID: sg8DpF5FB-na39PROvFk6_BUAAzbLAMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090237
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add tests for the recently added riscv-server-ref machine:

- a new test_opensbi.py test.  The idea is to have a quick test that can
catch trivial regressions that would prevent OpenSBI to finish;
- a new Linux boot "thorough" test that will boot the machine up to the
buildroot prompt.
- a TPM specific selftest for the riscv-server-ref board.  The test
will be skipped if there's no 'swtpm' in the host.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build        |  2 +
 tests/functional/riscv64/test_opensbi.py    |  4 +
 tests/functional/riscv64/test_server_ref.py | 88 +++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100755 tests/functional/riscv64/test_server_ref.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..2d22e49efd 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
+  'server_ref' : 120,
   'tuxrun' : 120,
 }
 
@@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'k230',
+  'server_ref',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index 0f8beb7e7a..367e131164 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -36,5 +36,9 @@ def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
 
+    def test_riscv_server_ref(self):
+        self.set_machine('riscv-server-ref')
+        self.boot_opensbi()
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
new file mode 100755
index 0000000000..db3371fafd
--- /dev/null
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+"""
+riscv-server-ref board test
+"""
+
+import os
+import tempfile
+import subprocess
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import skipIfMissingCommands
+
+class RiscvServerRefTest(QemuSystemTest):
+    """
+    Test the riscv-server-ref board
+    """
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/Image'),
+        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
+
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
+        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
+
+    def do_test_boot_linux_test(self, tpmstate_dir=None):
+        self.set_machine('riscv-server-ref')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.add_args('-append', 'rw rootwait root=/dev/sda')
+        self.vm.add_args('-drive',
+            f'file={rootfs_path},format=raw,id=hd0,snapshot=on,if=none')
+        self.vm.add_args('-device', 'ahci,id=ahci')
+        self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci.0')
+
+        if tpmstate_dir is not None:
+            # Note: code taken verbatim from
+            # tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
+
+            # We must put the TPM state dir in /tmp/, not the build dir,
+            # because some distros use AppArmor to lock down swtpm and
+            # restrict the set of locations it can access files in.
+            socket = os.path.join(tpmstate_dir, 'swtpm-socket')
+            subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                            '--tpmstate', f'dir={tpmstate_dir}',
+                            '--ctrl', f'type=unixio,path={socket}'],
+                           check=True)
+            self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
+            self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
+            self.vm.add_args('-device', 'tpm-tis-device,tpmdev=tpm0')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: RISC-V Server Platform')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boot_linux_test(self):
+        self.do_test_boot_linux_test()
+
+    @skipIfMissingCommands('swtpm')
+    def test_boot_linux_test_tpm(self):
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self.do_test_boot_linux_test(tpmstate_dir)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


