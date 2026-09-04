Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F2C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a1c-0002zi-Gk; Fri, 04 Sep 2026 15:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1b-0002zS-Rx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1Y-0007kL-T0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HIGis016220
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 19:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BS+RfMy0mOE
 +ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=; b=NEzUH2u1WyzqZ2lzsWqUGCupxtH
 WqwuIuoIQbwoz5WkeglOmSlFOrVv7z4tDek1mC53sJO2v7hNYkgITtH9g+zOYwmc
 5lNdYDRjz+I7fYS2NeFp3iJTGxIuNzxRIeQwKXPfv1/ekP1shAzgG20Fqbyf9KMG
 vhraXvsfo4uH3OOKchxeYgd9KT7y92S0799XCE5HiGE6T+kwyx1cw89lzgvKEGau
 dwdodlULyM5/ZVYYKhUKJwPsdxnnEmcwTDqEkNueU5JNC9Cbj8W6bqlS0j9kl1gw
 2ePIPDcoEn+144qU9fxYhzDZhe21MxJ0RuvQiRzfH3GHvaefV/eep+N/cVQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd3yke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 19:56:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so361263085a.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788551791; x=1789156591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BS+RfMy0mOE+ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=;
 b=Yds27wD8V4TNYZkzKHd5gRrIy2sQ2PkD51iQ1Mi9YdGJ+IV2McjcRPh/47iXaggohr
 AOvp00pfEX6IBLf5+SqNc0BsMiKJIxoNrOFGzuFUgyDCxWlSaBLCfbLiqHNpw9XYifGh
 yiYqDUderaHguFDsmQyLbz9TlE0CESsaFRBO/0GoiY6GjwzUISyyBGSgnDPw80xdfUQZ
 a+g+Ymx8P3QZfsOd53tfxNXgJ8wIAqrp8DSGieuomejuw4J1z6hEgF33pn16Scd7ZJ3A
 nhGtKx4eAWZ0hSFNukVycUb7fPl3lucFM9akdULZcKXznaAk9IaRPVjrK8CpgG1uGchX
 gmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788551791; x=1789156591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BS+RfMy0mOE+ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=;
 b=gNnNrt7dyqTx1isEzeNt10NaWLdsz/f/1RjrI207iYnlmC1c9p7qSyK52m8YLaLpDj
 B9eGQwsxaUR+h65AG2BYoP6ML2N/4O6sw/tQa+lq6UIX7UGLji7A7RRBIWxirXvIBIgz
 8iLyHlPoUQLYQ3QB5LaXZ2aI/ydPzjbHiw6bOzVcV1DpIJMeYbTlDWjRhufj2Hv5MJ9I
 Fp64gFQyvVZThx0U0qhNNixOikANkK3zptY6e+avx3kl2rK6aZcMan5yA1UjGMC9HqIY
 v5cRFvT2VqT0ik/adKZHEiG5DQg+7qq2/+mqOfFFqv3CfqdL9HDs5p6rVm8a0VjeOAhj
 hZtg==
X-Gm-Message-State: AFuF++nmhkpL65AO7uzCzHA/r65YlNdNFFMDHQy9WZ2s5YP80cxXzpGS
 syRnQhEeqRlwxRlIuZcfX+2ppTKbuIJ6C0bjhn+B5uMcmyzHkXG98vxttBAlGFnepDKBOtzxSCu
 H9G704cF4m2WlTj82HAAeMPamywhrPNH+Yx0C0J0mhbw66lHCUKb72MWAPL2n7P9aEQ==
X-Gm-Gg: AYBFou24VYw81Zp0X9ZHsJPvUl4Ioy5qhSx5WzDfKD23s2cwe6oPBjqj7tfAYN5/PWP
 SKldyD6rnRxye0YCoexbM1FV6+tdVJ4sMF3dJ6IplpdOrDPMDkuHj7gKdTDrj1bqYwDOQCbd51z
 TtxE7wMWEJ5gOsGpS1v2nsqtwN6jI+BrhfRjYO9jwndFu9cyYWi9O4wGqRHNVvLe2dOLOuvD5Y/
 YTxyMBazZ0GpTTq2/C8rmyFJSmw1CKh/SIdBCFsCY2UWJtQNomBErRYCBXd4Kd76bO1S7eDtrjG
 kY3SipPzi/TQ99U5H3Pos+60S4DWuL3/HtSUyehJHeGgqDBFxa7b8YOKkQNG9g4XJWCR5nIe0Ji
 aZqoD51qp+5+AQhF1h0KiXyN/hymaF5WQ0c0D
X-Received: by 2002:a05:620a:8316:b0:939:6dfa:4975 with SMTP id
 af79cd13be357-939804c27a2mr761215285a.52.1788551790794; 
 Fri, 04 Sep 2026 12:56:30 -0700 (PDT)
X-Received: by 2002:a05:620a:8316:b0:939:6dfa:4975 with SMTP id
 af79cd13be357-939804c27a2mr761208485a.52.1788551790090; 
 Fri, 04 Sep 2026 12:56:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406871b6sm29117736d6.32.2026.09.04.12.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:56:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 4/5] tests/functional/riscv64: add riscv-server-ref tests
Date: Fri,  4 Sep 2026 16:56:09 -0300
Message-ID: <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: njgl73bOHVZUHZJ0vS4vtYSTXqzfQjN_
X-Proofpoint-ORIG-GUID: njgl73bOHVZUHZJ0vS4vtYSTXqzfQjN_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfX23lt0Em1kYIh
 LNN6hlPk8ziGo5ex7ZaVX76qgH7YO83o8XJx+4iCSKOmUMaxVlGim/HOP/tgUtpf9wu1TMd1+MX
 s5/SNA5e3iTT30Knja4rGUB55jRxzRY=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9b226f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=JF9118EUAAAA:8
 a=QOu4sXKRH9_VvCpQA3IA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfX7NHEgM3jPBzk
 eeUnM8NfvXyipBU0cTHfBA6hTNMOU69wx1OexK+AYfBl/x02lCiGrEh7Rsglf61NUhhvhSw6YsG
 B7cJDS6BxzBqOkAn+mYHhx/eqr5ZK2VBLHVFbUDZbEv6vEbSSROFDrkdVinXHlVfBNBlGO1NsvL
 sm6H/RzbQJqbQYZlgjgOYAfWCdUCbPaBQJUhx6wfDbLW9HUjAlC5rQ3jvxAfU5PzcFS0asdh0MH
 JatOhc8ol2LlwK2e4dipZsH79JppxJrm5pNJEh25qT1rv6At1P1CcNauPH/zqwWMGwW01nF9nFQ
 WjxgMtGVD3wyras/29G5vLhhuQqGvIzoHj/cbH2F/OWRqFEyqJdC5ZQ2eLaGV2EkMI8AIv6Z6en
 +OXbMAMx4Bkae5Lcm0zsEdMoSmTv69SF1xZEC1gtnOfugtN+0nUdRqfMbrY2ZsBI4+A3DgUxZS1
 69Dh+gctT0WwJ6h6FtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


