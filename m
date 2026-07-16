Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC0C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUx-0000zg-0X; Thu, 16 Jul 2026 14:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUu-0000zJ-V3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUs-0001Zg-Qm
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZQqL385140
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k6SVOa8fvZI
 guPrY0scd3d05A5ZS6Z2+l60kihTlbUo=; b=TbT/PQZYmiRntq6GBl7wDushh8q
 S4bxEExLi7XAShkFoRGLD0D43NOxMILH9GpHmsqWChgFj++8uUyunBJcbKQ0f/UL
 62ang/RnwsxEGydpQgZNyACcsyDGHTAGEx8t3NwnmzXdnD2kvEjc0LU9S7K223TC
 NV5NHAL0gs+7E0oLegU/k/oV80k5A2PIlWEfe4LKnFu26Tf1td2OY2m7Ho1RC8+U
 i4gE12tRfGuZasxqAfjl37XOMhu3EX4SzRJBIS8pgZp3bhBOh9jV4stRnI1iOZan
 f2eAC7bw9eYmO8Xj6RoV5Xq32uqA4G6/6nzODrHWKS0/9DJtBMsQPFqqjXg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6g3w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc101287aso7950371a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225265; x=1784830065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6SVOa8fvZIguPrY0scd3d05A5ZS6Z2+l60kihTlbUo=;
 b=ZxybRp7LvMWy+QI/yGp5We/kd+BXSvuL7YOaYZlsgXKJrkelRa14SMRFJXpbI/q1lJ
 ET6C1nLeiDqcbAmrqn/1dBPJIjQ4s+LTnuE1+WFgwZVy0ei4rLndVpEuwBc8GZJyj/ON
 mr8D3fTfi7iPHn7oYBxDIvpdTf8hJCVVYpkc6XmSKm0lUsVr25N8UXZ9FETU6BDLYsLy
 PbsfpEEUwE+Sp8uUG4K3CTBo6zRDsqD82wD0kUOT/Qn+Tc6ucUk9aitGqGPFqDpAAMJd
 Zi5vXNC8Wg1whRbVvlmFTtN/LFwQAYXUacRD5BIyZAFTXF7luQ/t3SI58gZ4w3ClAZiK
 dlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225265; x=1784830065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k6SVOa8fvZIguPrY0scd3d05A5ZS6Z2+l60kihTlbUo=;
 b=pbgZu13U6yzm3NOW0LIsk2CdRbyIwtcJ+1Sgn7byjEl/p8XCHkWsaP9XDw+w1EOsc8
 dsCc2ayxDONX0uTe2bMLICsf9q4v/GeGBIZQ/lfFXX4X4EUNjWrQcWdYNOY92JbablS5
 0j1pxYwTQVyECR6s9Syl2RTKL6H+htf0IsXu+/PzdkgQy+WxSs0/g74vcwu+3seKUZMX
 ZpDGVeP42PCZA7WcLEiS3+mmYztDde0BUG0cyR4/WQRB+w3Jm+pWU5bHEhIRSuIZh0oD
 688Za3nd1z2+oigWO03TvJgKALM2Q2uU651qelJN1Gh1O8DcsJOKJgyZDvzv4hX6joWX
 KHhg==
X-Gm-Message-State: AOJu0Yyz/kGLU5iwPmjZhMR+1rSUIuyaZHfCs/OnAPQgumuKzLvKwqCt
 VxC5RUebRJMmjhrXthCO/GQen2o0ARgywrOFVnuYAofG7qrB4zCanBZ951sjRki2I7tZVd+iOhD
 OE7hFf1tg+1UzyRG618mZRtQ34nTXupJW1lexrL/OBoDbRIH8SWEdGIxdoadrnjzRtw==
X-Gm-Gg: AfdE7cmMg/izXO2grtSZcj29Bk1CvdXG/YWDJ8pOR3Mh0tPwumyuFpooc+DjdLdGd6f
 A4V8oJUE2CNQimuX8mLDBiL/tCNJQduRaO0x9igwacSU/AvdcsnkNlbxaTmdDTjtIHhnFhFEGLQ
 dJlQhd5RyPpV15WXzqmAmlyNjnCHnW1Jd6tuclZiEJ7NdnsFpfD9dAgeQ0piZrN4UqfwVrqt10f
 CmSb8ZXZ4I0dG35JGrI6WPQz8UpYfcZ0vuGH276fbd+Q0+eTdq/vk/uBvshZ+tiz8RkE4g1Q7p3
 2Oso95bGpKiTWzMikn/iDey0zbXmGDu2cnnB63WyZm4ASJj+IoRLHxcvbMy087gH/wF7xq2JEO+
 dPfmxrbQ4jSEyUnbqfFBHk2+Xv5ly7Qq80szXMs0lm986hUGyNGGrX7CFPqcgE5g=
X-Received: by 2002:a17:90b:55cb:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38e17dbad69mr11758902a91.13.1784225264741; 
 Thu, 16 Jul 2026 11:07:44 -0700 (PDT)
X-Received: by 2002:a17:90b:55cb:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38e17dbad69mr11758860a91.13.1784225264138; 
 Thu, 16 Jul 2026 11:07:44 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:43 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 14/14] tests/functional: Add hexagon semihosting systests
Date: Thu, 16 Jul 2026 11:06:58 -0700
Message-Id: <87a6d2559c3e07846787eebc12e8d928c95af4f6.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXzrMOvrnCRg1Z
 mB9qbw7SLF2V/wAQLhE6Ypa7u72hPCxcK8F3EohWB3qtkjRXadvkVgPlP+D/pWQoWnviCNYLRir
 0dTNdOUx7R8GZ+p5KUDc3rqG09FJcE7h08W25PoXtWjsiy6i6RO6n4DsGLvYYHJ+/beRl8TadQK
 5BKid2FXZu5uWZyM9ZRpwXDV9DIoVTlqdRW16COugkPuRgcv4YNlXNhmpEw9MuYL7u3sX9GIkEV
 0swEnWxYbApArIVAUrqoqjNOjKAbqLzfFp8RbZBj4XPZuJXkuZog6lYgO3VeoWCLTfOrEnOkqxP
 o+t9oaNBwt9TAab60yCKo3Wggk8pZUNSIv2Otea84DRGnBnJxfjSvymgm7PIq4tJiBJfrLYSDl5
 oSAUX+snuARAFi+EjEu1ckfx0r2JCqEEruaZuB0JbyxbD4lqj/sEZW/boHAAnTLM4SuTncrAXZm
 CvCzNfWciMyuzP/SXGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX7wDyEpScyy3t
 0lLMuKsCpLDZyYdsZJQ9/7aj/FaoVe/gl6/UGu6kGHQGDsCemje30gXZ6clB8yn6tLd6rBGYa48
 v/IPMxVOuqi3FLQ7Ce7dh0rCxDpM9Bc=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a591df1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=5vFef2XoAAAA:20
 a=EUspDBNiAAAA:8 a=CTwKznjAqPD_lkGzSfAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 6vFo4sQhMTLzqXiNzfPkv4OJry2cIJlF
X-Proofpoint-ORIG-GUID: 6vFo4sQhMTLzqXiNzfPkv4OJry2cIJlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/functional/hexagon/meson.build      |   9 ++
 tests/functional/hexagon/test_systests.py | 110 ++++++++++++++++++++++
 tests/functional/meson.build              |   1 +
 3 files changed, 120 insertions(+)
 create mode 100644 tests/functional/hexagon/meson.build
 create mode 100755 tests/functional/hexagon/test_systests.py

diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
new file mode 100644
index 00000000000..6cd684b0df7
--- /dev/null
+++ b/tests/functional/hexagon/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_hexagon_timeouts = {
+  'systests': 180,
+}
+
+tests_hexagon_system_thorough = [
+  'systests',
+]
diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
new file mode 100755
index 00000000000..8977aece43d
--- /dev/null
+++ b/tests/functional/hexagon/test_systests.py
@@ -0,0 +1,110 @@
+#!/usr/bin/env python3
+#
+# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import re
+import time
+import unittest
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+_TARBALL_BIN_PATH = (
+    "systests_standalone_package",
+    "StandaloneSysTests_6.4.0.2_v68",
+    "bin",
+)
+
+class SysTestsStandaloneTests(QemuSystemTest):
+    SYSTEST_TIMEOUT_SEC = 30
+
+    ASSET_TARBALL = Asset(
+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.11/systests_standalone.tar.gz",
+        "b5777aa65245de7710a7a08d717953c1362be7c8b60d9014c9fee8b17610ad1c",
+    )
+
+    def setUp(self):
+        super().setUp()
+        self.archive_extract(self.ASSET_TARBALL)
+
+    def binary(self, name):
+        """Return the full path to binary *name* inside bin dir."""
+        path = self.scratch_file(*_TARBALL_BIN_PATH, name)
+        self.assertTrue(os.path.exists(path))
+        return path
+
+    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
+        """Launch *binary_name* and assert it exits with code 0.
+
+        :param binary_name: name of the binary inside bin dir.
+        :param extra_args: optional pairs of (flag, value) strings passed
+            to set_vm_arg(), e.g. ('-append', 'myarg').
+        :param machine: QEMU machine type (default "V66G_1024").
+        """
+        self.set_machine(machine)
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", self.binary(binary_name))
+        for flag, value in zip(extra_args[::2], extra_args[1::2]):
+            self.set_vm_arg(flag, value)
+        self.vm.launch()
+        self.vm.wait(timeout=60.0)
+        self.assertEqual(self.vm.exitcode(), 0,
+                         f"Test {binary_name} exited with "
+                         f"code {self.vm.exitcode()}, expected 0")
+
+    def run_console_pattern(self, binary_name, pattern, *extra_args,
+                            machine="V66G_1024"):
+        """Launch *binary_name* and wait for *pattern* on the semihosting console.
+
+        :param binary_name: name of the binary inside bin dir.
+        :param pattern: string pattern to wait for via wait_for_console_pattern.
+        :param extra_args: optional pairs of (flag, value) strings passed
+            to set_vm_arg(), e.g. ('-append', 'myarg').
+        :param machine: QEMU machine type (default "V66G_1024").
+        """
+        self.set_machine(machine)
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", self.binary(binary_name))
+        for flag, value in zip(extra_args[::2], extra_args[1::2]):
+            self.set_vm_arg(flag, value)
+        self.vm.set_console(semihosting=True)
+        self.vm.launch()
+        try:
+            wait_for_console_pattern(self, pattern)
+        finally:
+            self.vm.kill()
+
+    def test_fopen(self):
+        """fopen reads a file passed via --append and verifies its contents."""
+        import tempfile
+        # The fopen binary has a short cmdline buffer; use a short path.
+        dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
+        with open(dummy, "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("fopen", "-append", dummy)
+
+    def test_ftrunc(self):
+        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
+        ftrunc_path = self.scratch_file("_testfile_ftrunc")
+        with open(ftrunc_path, "w") as f:
+            f.write("valid\n")
+        # Sleep 1 s so mtime change is observable
+        time.sleep(1)
+        self.run_exit_zero("ftrunc", "-append", ftrunc_path)
+        self.assertEqual(os.path.getsize(ftrunc_path), 1,
+                         "_testfile_ftrunc should be 1 byte after ftrunc")
+
+    def test_access(self):
+        """access checks R_OK|W_OK on _testfile_access."""
+        testfile = self.scratch_file("_testfile_access")
+        with open(testfile, "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("access", "-append", testfile)
+
+    def test_semihost(self):
+        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
+
+if __name__ == "__main__":
+    QemuSystemTest.main()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c158197c4b7..c7362dd00ef 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -14,6 +14,7 @@ subdir('aarch64')
 subdir('alpha')
 subdir('arm')
 subdir('avr')
+subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
-- 
2.37.2


