Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB68C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CE1-00019d-G6; Thu, 03 Sep 2026 14:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CE0-000194-I1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDx-0001cH-Jv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2rlm1698730
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BS+RfMy0mOE
 +ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=; b=GIfCd4oXoM9M/VHjh+hjxkJf1Pf
 wWKaNB6cMDyX8b059R94G640Fl2xrcJ6tCPwZb7Wlrl1fW68Z5c+U5pGR+vrpYca
 /FE9QAvWIsf+/E7h2JLx/RDR45CXcZFO/RPmg2WD4+cRMmAGhAuTxY0IPYpqdDwp
 n3PvCOEHiMBhiuL4lXJPbrjpPLf/TTuiGc90BGmpKclxq8N5kCqU9z07CI9Up0dU
 uY/Yue8jSBXXcNQpdMAZO7nph+nNHnQUyAao7nQFky3qMiC6Lz2CB20gZuSCgbR7
 0WZFvXexT9M6EH8OoasZSCYdTEGXbrUEo7jj2DLdV9cIYydrriTvSR5LdMQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvguf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90c8da50f4fso2783326d6.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460303; x=1789065103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BS+RfMy0mOE+ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=;
 b=L5RUyazVyKS4uc9/JUZ21aYUoZN5O5AXZAWu7YqQi7jDz58kaZoqcIwgJoaaM/hVJE
 /Q1GgcJHL3n/CiELrELvfU8s8pZJstRiUQoUi/gUfyOns3wO5dkP9vie33F8zjh++W1s
 5HidPDENF6OCEIzaDBF65mS077e16Hq6Z25RVRXbC1gNo4r2r9Gld/7yPthoBfEXbJW4
 Jv5p6vhEERP1njfyjjsND7ctbDbbQbMij0Oml5a4Ij8RMHoHXwnetYFUleB1OUVVGtC6
 EyKvvTdgehbe+3Eh0J5mbCwrLitI24LjuLq943QdeVMgdxDKzeRRnROd2S/DxAYxmuDU
 CIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460303; x=1789065103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BS+RfMy0mOE+ZYz8zK17/pgZkLuA1Nzqm1+TnjWCQR0=;
 b=sxv5lsC9VeWwi/e8sdROIHFj6iRa0X9WYNMqYUpk+dvki9q5xlEyEDc5fz2MrxA+sz
 RKAHedQf+aWk9HOvmHOhgImBucJVJV64sRBR1ufJXORwEX0PAU+L/Huv7xk6TRMz7W26
 w5a2HXWvVf03kdFU8tjcxR4w8wYF+SIqF3TpYlU4PAwIYgd9sKKsQUeT9Ua8ilYs9sdf
 e4VwUtEujuwDV4d3J00w8RPXD5MYdZ7SnddF5LlOc0TJ8kNjFjQmeN7VmFKqvzs+GzEc
 SkiGMgY2QrCo72pMdU9GiV7gXt/wpZrvGf+3Fyh6dhuYWTpIYKqDvL+J/8mJEIu5WpKB
 kuMg==
X-Gm-Message-State: AFuF++kpTQnrv3/7tClAnDoW2ex0m20qqCEUjS1O0+V34IeR2A+rwH5l
 i/TPMohPYUfo//4MBpZAWP/At0xR/BuMxHlZpuxTjcnrfzixHQjxwLQb/YRu3fuZRXs8Qc17mQ4
 rCjCOk1GJmZ8XiU2vo2kwkoFdRouwc95sDy1Nwd5vPKobUN+lXvg2dLE2g7H+5iDlAA==
X-Gm-Gg: AYBFou0SH5VtWFvjyclVM1ienI3hBTAemRJW/HcQwZGMjkKoYYaDjRu1QGApHYzSL8+
 3pjiiPGDmCr2oFpP87Cu5J0PxH59K1839ZcUb8W4FNjmP9ZP7bZ3SSvDG1rsJhzAhl8Ugn6Z3l7
 N1rG9GkyyeadAzLY++o6Eg8goEOWYRQMqOjTih2hFIH7jmSkYpYAp74I4u3gOe6iOQnnnzjFnnT
 WlPRnnKgxGvzwebzbF4o+8JQhmG1fG6RsgYX+UEnCsVrJ3lwivsPXQ89v4rxZIEs3eec7MIWx/R
 KOmEuVqJRmbwxv6DRMjkJYzbfBubGv3gYNP/b2gYz41nYoeKz0/wBIXPo36mMhH8WVagP7fdjmd
 QgOAjYj6szBsDPXHvtoiC9+I0WzVUwRlyeRL5
X-Received: by 2002:a05:6214:459e:b0:910:3453:66e with SMTP id
 6a1803df08f44-9103f0df285mr11661446d6.32.1788460303057; 
 Thu, 03 Sep 2026 11:31:43 -0700 (PDT)
X-Received: by 2002:a05:6214:459e:b0:910:3453:66e with SMTP id
 6a1803df08f44-9103f0df285mr11660326d6.32.1788460302380; 
 Thu, 03 Sep 2026 11:31:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 4/5] tests/functional/riscv64: add riscv-server-ref tests
Date: Thu,  3 Sep 2026 15:31:24 -0300
Message-ID: <20260903183125.682865-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qw5B2IZYZTU88DJh8uDGHXclPcXcL4bq
X-Proofpoint-GUID: qw5B2IZYZTU88DJh8uDGHXclPcXcL4bq
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a99bd10 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=JF9118EUAAAA:8
 a=QOu4sXKRH9_VvCpQA3IA:9 a=pJ04lnu7RYOZP9TFuWaZ:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXxBf3fDXr0Ay1
 11GmU+unzCKqkaTwVKY4hkGPsgu7K9+JlsADoZoX0RdEms5/mFIhL1Hej/uzfjrpRBb9nM7p+CX
 wpEmTCElDnu8mRmyJ0LN6ts0n3vyMh4kEeCHokFYHMpqqOfe8XbnrsWEH06fpRdgsZeZM89KHN3
 jC/XnAKvZGvHYAjnPAFBs26Tn8euEgrZZ3qdp2iM6EUS84VPMBGI+xqygBXk66bdH/A/NPuPR8O
 ImqF4HIqkL+FzUyZG4Qxs9GRnclnJ6omyREPdKoJ3hiKr03QfGRvEPxy+FHvPblQ5b2RGQOaSX6
 POS6Rqe365aMStnuzAFnP+E2yym+Mzd/jlSY5ioSHDn+xJglxKXTBYbIa+kv0k6Jbi71YN4wm8U
 GadvJlMSWflKBPBRb6PjoSnHRCC7Ppx7fIsIIHg09bd33toLP4MoCcpfdvejhWt+nKmYElsN8QE
 qzWXpkS4hIgJnvZaArw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXzBa3JP4q6mgM
 qwT8jV5ANbB0Um7OCpOkr0GBt72PzuvHfxpTWXX+ghUEWgFNrdmqNp8dGmWmvCpNd5mWzqnzT3I
 fVo5bboxz08/cx657Fus65/ugklVmP4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030162
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


