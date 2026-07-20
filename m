Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591D7C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0i-0000Au-Vs; Mon, 20 Jul 2026 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzo-00089P-4L
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzm-0002zr-42
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHBqIn137357
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0w6tx+8j8t4
 kqbTNNIJcJZtiimEXu2ymCdfEox6WgE0=; b=D105omONb6d17qo+oIzbwCYiTKl
 CLelYfIClyEGSG1qM2gTWlb6kT4GFR3b1nNxPgyTXuaMfXnqPgdkDQi2QKd+DnbJ
 iOOnC9k8d1Mt8EN2PTJhgMmf15NW4lmdv/bRkmuH8pw6VFbGRheHoumNTSWIpnzz
 sVIPVPJLSNw6YFAjPZnJxt8ouHfVK5mvO5pD6gCxn7SU+2X4W+Ya0w3AvaEYReWq
 Q80EHke1B7uRw14V9E3VHO+W+nfXojhAxGQ/bGDRGSQT5mTD1QsTAWzUVjpbK2Bi
 ZuMm1Ze/nlbNKjqjbut+lwwTIEqt3USheDqDyWlLzoavmdmgPvbeJadR7mA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5r4ar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso97987a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569285; x=1785174085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0w6tx+8j8t4kqbTNNIJcJZtiimEXu2ymCdfEox6WgE0=;
 b=RiP/N/Dmhwyr37OSTnrShtQ2tWtl9Tt9/GRV63zAynD5f5Zisw4H9OvL8MLKPQk6nd
 JdD10vbhcposL6m9U85daF5jKITHqBW6x9vP2kqvWf40WrscTSwHFm01kWTNUIo4nVD4
 yhbamqXo4tviuUqeMRlM6R78N+LC6k8r/90qDjV6L132X4x+GaUOkm8AUXolgC9Y5CqM
 yvbQpmVdFJVMqM7+W2jCWflWgA+PBMXZWdDsdh4F4FTat+aviZPifL9p0npAQBxhpbMw
 awzQ/mWiNwcZM5PPFYKY4ubx9QOnOZRoo/guISCnRPrpFrGpNtTnrAEpDnV1hsQMtIEz
 L0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569285; x=1785174085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0w6tx+8j8t4kqbTNNIJcJZtiimEXu2ymCdfEox6WgE0=;
 b=D2JQjYwQXh7Qw2dzw7dk6RQ/QAt+i2zgIW5ig0myeOMvIcsM4mWHZLixIS7enplheO
 /8/TGcG8OwSt8qJLjT1t0N9QX9+hFJJuG7vedejtMs1G83L+IPEhLy8eSF2uLblAGP38
 vCrjoO2RdgSfaCXjFU/yA9rwhpC8INas4J2YpGzrs48ihZV8xMGWccFWiOPe4SfyEOBQ
 KP8zX87kzVv2fRHqUZzarioCn28kaPcaQcnnHsONlST3WkDrMwLNMe9YO8/be4DPpW9Z
 S/A30Hq6gSeImkmQKFFQDKgo7Lc35i13WAyPmwjwwSkoByqBBeMZOL/Sw6cG+HPeSIsG
 Cy4w==
X-Gm-Message-State: AOJu0YysR1zeOKsl4nTMxcwKFv+a/WKHyOZYMsj8EqHGHNRHQoYdu9xY
 25B8mdOxG6vSj8zHpEWTIMd6OROQvenW/LaMdr074kKnqrDGJ+smxBSDQHvZUv7Fajo198R64dX
 GYfQozhaMz4rPji/ojwBI2j1rqBYPvuw4WhiKM+n5UEquzNidUX67aYF5bnqnZLTveQ==
X-Gm-Gg: AfdE7clcuBX1VW/mQdiiUxvLi6P+2iWC1Iwaz7jDHvZhFf1bACNTiN7POyOU/As7Q2y
 na7NSA2xsCPdKiAMyFT1UtAq0J/x9R6DhgqBALYGw2JqtIWZxi6xki8qYA7HFwXXUXuQfADml/I
 qMK8GvSkhmqHJkz0NCAiMxZIJc/tEvtp8lmKMRKmtJCm8PsWKrekKyi4FENFrNzcYWb+GKVxidg
 czXc2sRGtng/Nx4U2urk98l421p1+oXwUP8GfmR7LeaQg7JpwmcP86nfQw9QW1uug+ewditN5HF
 RoOieyj+wBuiYhQU6qaTnqu+jgUBAboaeKZSBpasdBqcba9Cb3mLopHPNd2qep5kvIfqC88cM35
 ztztd3PMaJc11fHcUfUx6xUj/N11zdpGSpwQCqHVyemUsc8LlG88441WmpLzQMLY=
X-Received: by 2002:a05:6a21:1519:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c3ad8b2a79mr16926439637.48.1784569284693; 
 Mon, 20 Jul 2026 10:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:1519:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c3ad8b2a79mr16926407637.48.1784569284220; 
 Mon, 20 Jul 2026 10:41:24 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:23 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 13/13] tests/functional: Add hexagon semihosting systests
Date: Mon, 20 Jul 2026 10:41:09 -0700
Message-Id: <4299b53256dfab6d43bc9c591797b50710b8af6e.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4IdllDx6XKwbhLl5cnUtD6l6-dtSkYk2
X-Proofpoint-ORIG-GUID: 4IdllDx6XKwbhLl5cnUtD6l6-dtSkYk2
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e5dc5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=5vFef2XoAAAA:20
 a=EUspDBNiAAAA:8 a=CTwKznjAqPD_lkGzSfAA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX+bNKkUZml6NK
 mP3Aick+TViB+F3OnEDRJbYFNscUqG2D3o2sLuOLcZkYC0h1lHuNVlPFTy2YWlWG0xAggof3ihT
 GI2HR052F+Uh65Ha2klWirBbdTPxjeU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX8xYwfWM3Ox9K
 BULcJM4Tf/OC5JELLqq8s9KjPAaDXY8hf/xydhh0Tx7x/Mr8YwTC5nF2okMsXEMMoM/dUHfq51X
 MAIzFOMW/0PAPmI9Npy2mWFtXBSG54sejo1wGoLtFDh1h1/PyvNnUBCg1UFBCVwrJhAUPjw8+7n
 SY2PiGobFNKc7aRDEqJdVefjDABg4RtV8HDc1tZ2zWt2ztvx/wNh9RZtrpQ6YqdjN+QefR6t3Qh
 MA6hY7dVKqUfs0NVVZLrhlhpQKBEXisRNxaHfP7lFxlQf1PDqnFxw7L4CqEfYQV5ZzeyxOempck
 gSDOljUyVAxToNVZte7iZRpVKgdETTP1yZlGjd1vxFM0Uc4oqoh2MpIubJurCY/TT+z28wVvDc2
 4fNHn/EGwLAwE7mLTRQhtM8wbjFm6V6VpXVGxaZHpbZNlIwoRetksndQvFRy4/SwyG5Xx7atA/r
 LRy4Vde7YGBW/dWHWcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
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
 tests/functional/hexagon/meson.build      |   5 +
 tests/functional/hexagon/test_systests.py | 110 ++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100755 tests/functional/hexagon/test_systests.py

diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
index 2b5a1a8f264..44053e64676 100644
--- a/tests/functional/hexagon/meson.build
+++ b/tests/functional/hexagon/meson.build
@@ -2,4 +2,9 @@
 
 tests_hexagon_system_thorough = [
   'arch_tests',
+  'systests',
 ]
+
+test_hexagon_timeouts = {
+  'systests': 180,
+}
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
-- 
2.37.2


