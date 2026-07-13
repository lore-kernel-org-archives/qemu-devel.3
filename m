Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3548C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwY-0005mx-0c; Mon, 13 Jul 2026 16:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwW-0005m8-8F
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwU-0006Sv-Bx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9GJj2470611
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oy22ab/xlCe
 at2wkPKsuZ5LNgXAzntyzHrFtr8M6THM=; b=lISCpM/ckY7zzdNFWhxLy4lbDV5
 79cyJ8OhW7l3yi7DNpcyINziQ8hxmAnZTlz0r7Sr7KE6kmiNQpVLgNwAaGvPwbL2
 yc8ziHoaArNJh4Lr3iIHilQc9shYN4bm0l2dQlg5EUsFjwIpck0oFVlnT2RvvmLN
 xtpkL5uDuL4HpokmewT3VnRzA6vhwPb/ixFuUJb8exl49NxNjtPTiAupYXqFvwH+
 hThgPaJGMSVfuFsiVDEg2FZyQY2kqBuCvKaudenPNpIMHYQsUme7/J/kjbH8ue7T
 yT/5873G+PjHM7qe0Ef0TzH0s+gLOChvO7+BR9J/EnJrnjLLdFpI1gOTBRg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jrmf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso9022970a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973262; x=1784578062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oy22ab/xlCeat2wkPKsuZ5LNgXAzntyzHrFtr8M6THM=;
 b=XDCJVvZis2us+QDd+Y6h73qyNnL62yP2IvZc7n9/kabe/QKv6aniEo47aBj/EKBadV
 0W572Al+ykr66XJJa8vgg7I40486zLPFDadxS/KgRl+YuAIvVe/FTtmuULRrOTS43BmY
 2qn7E33ASSm81NZFzS7KTozLWF8X4UDY+6JW1kasTbYOwyvq65LhhjarFJC4xcknoZnh
 xDA5KMWzro/w+KSpN1Mq3xZyQYSIdI3x9F/XOE+qVSr8u3ZZvOUyHS7bn8pE7mllR909
 59TQ0tfpcOTFXjFlHZhz8Fy6WhJejrBtMSeDMu/4pyJYBuVI3rjY0g31fRlACTLra+Ea
 8/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973262; x=1784578062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oy22ab/xlCeat2wkPKsuZ5LNgXAzntyzHrFtr8M6THM=;
 b=VLFardiz/RAYRmFEFJ83sf2zi64fBcGeVA0LldBsmGjNCnwDtwGNpamF3nwBED3ObV
 ljSlv0oMUIJu/7igePyw7gCCU6+ZIwLfI/OpGNJK/STJZa3OIhp2o0KCrhaqbrgJ8UQK
 0si/6abInM7Wj637jXAq8DxX1JAkRFFGJQm2JyMNb17xndkcs91AfA1Dy69FC0/0tdQY
 6QFUJHzBxnueouCGnBATsZToWoGxiy5SvrdH1GrEPX8wLCjaEer9+CL3GtIkdLAlQp6s
 WFFCHCcn5AzYyoZu9nDJLq+agspCyBfzzyM7d6Lu6WgU53uW3eJjhgQnVFNYpkHmRtxR
 k5vg==
X-Gm-Message-State: AOJu0YwbPgjxtgpc1Knsi2Jb2p9YLLqEyFp9e79GLAei5HuDqLMhjhLR
 rIesQfuFfRFtnv6NWcacEPOLTMW7zUR5mEVzlI7FCh8K2TwBGCwk1a5cG8i13ioyz+LUPGCZo4J
 9tBI44MCAY8a2O0OZ7otZz+0wfua1f3DjrpVjEC9hMX9vo2fmF8GsDY6vRKIRc/I1iG6d
X-Gm-Gg: AfdE7ckCCPD3KWHBczmZ1QWahUYw/3LEfc1z8CdM1zyapOyt3gHjGuW65pf98BUZEE6
 oAm1B7sODf1kOR6Tnrus8CSAnDEjkrDIuVeQyK1c+NRAx6X6mkUQC89Di/+7IyrG9JOmEaX85qN
 7Mq3WzD0oNwgs/c38+ra9Vg0of4VzeDK1CLEtkqt592KOL2RdpcWycy/rM+Z2mP5f7cPF4Ep7sq
 EBzgYTwSUmdxr9ciVe9GCWnB2YFibPfJXsDMz1IF4FwOFDKF1RzBL2Qs+oG3aZaEesd2qLHgBwz
 wkC6TCUf/T/G0ziiMJ9Ffz6hUVP+qfB2F1HSQHbtvvHSNEyNkjiYbGqJOlcXVS1xMRSzaH42AqF
 ReY//IdwtXkQdZ3VVT6wYxRgPdip6CZ3poHXw3u1zlTq+NGWzWK5PCEge9cdsrgwDBFh4IVN68g
 ==
X-Received: by 2002:a17:90b:3947:b0:38d:e28e:a639 with SMTP id
 98e67ed59e1d1-38de28ec303mr6457042a91.24.1783973262500; 
 Mon, 13 Jul 2026 13:07:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3947:b0:38d:e28e:a639 with SMTP id
 98e67ed59e1d1-38de28ec303mr6457023a91.24.1783973262043; 
 Mon, 13 Jul 2026 13:07:42 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:41 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/14] tests/functional: Add hexagon semihosting systests
Date: Mon, 13 Jul 2026 13:07:22 -0700
Message-Id: <da280da8fec576b2cc59e7bf48a2845312ee50cc.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qZcxUOwxVwp7oTWXWQic1WbAk1ubIN1H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX5MSBd5XQmMk/
 a+raieVZZtd5tUQ/Vx/kGr96pIBDJK/lB+qKqCyGSqnsP5WSIFDvCErIotC/52bj6j9MOQLe4E2
 g0nyIYlFLW829cylGSiTYuSJltsNfYo3jSPtmqNzb8sDhVBRPF7qgAdzmZUBVdhgIMWTdmsEk+u
 0jpET+srPV0kZ5AHBqnGjCUF9VeXrmmasfz62C0HWkCxvIBKGcGKoEynYEKd2FzLN+rKtyB1JBo
 EZJNlHqVEknuwIv9JyroxREwPPLJ5vMzLthg5UBKO4XDy/fTdNK0Ig7Zh8FQ2Cve2pHRQfGmxRz
 5QzzaZmxlkJgUpm3oNU244rAI1hq6CqE6jU0Syog95fupNdKYh84uKm6xUp7ToGsQS2/P491HnI
 FqCR4an970SFm5h7+A+Fpa6rN98bDKA9eMn+EVroyf1fV+EROgnjGDbgfKhMVpP4FkTH5Dlw7VR
 iGXG3yqHGY3QrwpsQPw==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a55458f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=5vFef2XoAAAA:20
 a=EUspDBNiAAAA:8 a=VJmjIbDfMbkIIiVV3KYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: qZcxUOwxVwp7oTWXWQic1WbAk1ubIN1H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX++CwaN2O51Z4
 5U2dSP6uQYYKbSTMpuk23peAQH3Y+30TSZI3ikLSC0prdEtUJaStldeBjvokMGUe1TziRcOJgZB
 o5Ioy2WgIF35OEiWHrnhRg5h+k65O4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/functional/hexagon/meson.build      |   9 ++
 tests/functional/hexagon/test_systests.py | 133 ++++++++++++++++++++++
 tests/functional/meson.build              |   1 +
 3 files changed, 143 insertions(+)
 create mode 100644 tests/functional/hexagon/meson.build
 create mode 100644 tests/functional/hexagon/test_systests.py

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
new file mode 100644
index 00000000000..b20b9fc56cc
--- /dev/null
+++ b/tests/functional/hexagon/test_systests.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+#
+# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
+#
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
+_TARBALL_BIN_PATH = os.path.join(
+    "systests_standalone_package",
+    "StandaloneSysTests_6.4.0.2_v68",
+    "bin",
+)
+
+
+class SysTestsStandaloneTests(QemuSystemTest):
+    SYSTEST_TIMEOUT_SEC = 30
+
+    ASSET_TARBALL = Asset(
+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
+        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
+    )
+
+    def setUp(self):
+        super().setUp()
+        self.archive_extract(self.ASSET_TARBALL)
+        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)
+        self._orig_cwd = os.getcwd()
+        os.chdir(self.workdir)
+        self.addCleanup(os.chdir, self._orig_cwd)
+
+    def tearDown(self):
+        if hasattr(self, "_orig_cwd"):
+            os.chdir(self._orig_cwd)
+        super().tearDown()
+
+    def binary(self, name):
+        """Return the full path to binary *name* inside bin_dir."""
+        return os.path.join(self.bin_dir, name)
+
+    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
+        """Launch *binary_name* and assert it exits with code 0.
+
+        :param binary_name: name of the binary inside bin_dir.
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
+        :param binary_name: name of the binary inside bin_dir.
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
+        with open(os.path.join(self.workdir, "dummy.so"), "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("fopen", "-append", "dummy.so")
+
+    def test_ftrunc(self):
+        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
+        ftrunc_path = os.path.join(self.workdir, "_testfile_ftrunc")
+        with open(ftrunc_path, "w") as f:
+            f.write("valid\n")
+        # Sleep 1 s so mtime change is observable
+        time.sleep(1)
+        self.run_exit_zero("ftrunc")
+        self.assertEqual(
+            os.path.getsize(ftrunc_path),
+            1,
+            "_testfile_ftrunc should be 1 byte after ftrunc",
+        )
+
+    def test_dirent(self):
+        """dirent lists a directory passed via --append; output must be
+        '. .. fileA fileB'."""
+        dirent_dir = os.path.join(self.workdir, "_dirent_testdir")
+        os.makedirs(dirent_dir, exist_ok=True)
+        open(os.path.join(dirent_dir, "fileA"), "w").close()
+        open(os.path.join(dirent_dir, "fileB"), "w").close()
+        self.run_console_pattern(
+            "dirent", ". .. fileA fileB", "-append", "_dirent_testdir"
+        )
+
+    def test_access(self):
+        """access checks R_OK|W_OK on _testfile_access."""
+        with open(os.path.join(self.workdir, "_testfile_access"), "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("access")
+
+    def test_semihost(self):
+        semihost_dir = os.path.join(self.workdir, "_semihost_dir")
+        os.makedirs(semihost_dir, exist_ok=True)
+        open(os.path.join(semihost_dir, "fileA"), "w").close()
+        open(os.path.join(semihost_dir, "fileB"), "w").close()
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


