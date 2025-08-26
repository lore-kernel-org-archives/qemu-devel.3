Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8897DCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyfi-0004y4-5B; Tue, 26 Aug 2025 14:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyfe-0004w7-Kv
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:45:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyfW-0008T4-5I
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:45:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QD1vk2028616
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GZr6fKIuBP+
 n56Ge2gnAV7k/J3Lgs0gnOtTgNmdTKt4=; b=GhKunerxvNicJTn52Mb7Ju8u12X
 M5B1uJ9ixKLxuoGe5yjWj8M/5uff4zCoBvNvpgOQod93WjZLdVjKeVFVivuBKOSr
 TQy89oX+uvD1HD3MdzoeOObjFKGSKc3ZZMZ/lFdkOFPDdSeW/Av4NAOkUcqVlJvo
 0eQcYgxQGwt4zEuEb0McdLuGr2N9CmEvgL0wUCfSanNf0o3yOiZTfVHJvcPDl/En
 X7TjiDeb5CPbmC0HgYfMIr1grUNQLcT2fhMI1ar6IDollCRD3rCg9+nnUhG2HxPN
 zSvkvWTCMGV0ZLgVviCj+mn06BtC5xfdJX7cvA8oA/nDQrqdhkGySah///A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we1v99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:45:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32326e72dfbso8654620a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756233913; x=1756838713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZr6fKIuBP+n56Ge2gnAV7k/J3Lgs0gnOtTgNmdTKt4=;
 b=PsBUhDmp9o+nVyfyAqhvyrgkZMwlpgUs6CibnT0dtD7EU3Gy29syifBsLy+wGCZyqp
 zvyACuqbPSxcA8+TsgqXZ5yH0TZUINyskbWS+nQtRRxB8LoA1PLrIGBxF6aoSSSGKAqV
 R5BhC39pgoplK7fChVKPK6wInwYAZXWeEg7ERH2g5zHKAFhOLP1GiTdRDKf1dP6Zgydb
 wFdMkGenaNUv0az//x7K5+qcxMHoKzRsSZZCHxh60nH7BgEQ0RMvO7FMYncfmKDeZ7nH
 TgVjYLbcsVfe6qahTHX587dBx/006M1R+/UTnVrF+g0WGWNvsGW8zazbs2xpSiqLKPbe
 Rtxw==
X-Gm-Message-State: AOJu0Yz/R5ZS8pakAFHit+TAxL3VlKpTmtPNjh/OIDO0oGk91d7//2h8
 IAXFSiLLPQ4xGys8vL9yLyrRTIH7ODrDELdLISip4zKZ70FN5CfMnAvGFyTt7Vt98XCRKek7+dO
 i7PlMvEdBHsVt7VczMQ9kvfLOhtGFFtBOFtVdag0skDMQ0lIgJ85R6xjdwwa6+ssCkweU
X-Gm-Gg: ASbGncvNona96QnfXzcrN+roMYnAFWiR+YTyLhzH64LrmVSUXgkpZAaUrZ+XuE+i3on
 ONajtw2GME3oL4dd6dasclHISDOfKzQpndltoITKlhYOuPqXP9w/ZkMbr3p46F/3NLL5kyrQ/B6
 MTbM6IZdL/x5DbleAvJoND7TIUsX0o52aMpzxnoAqm4K+vGmCYJq6Hn4PD5xoaq7XKPhN+QeOGT
 khPaOqwjqIr+p2kb2atGY9dv3FeZsjFJ9BZ08jX7AYif9TcHqm4jq/Ka/bHF0weyIYhaoYgJSxx
 irN91q+04hIvXUUc2bOtyUHS5IetAOoRp7wwe/uOqhOvAKjEzY9th5UDMTntLxzFS8CfqjLGxAW
 QupNhzdJKyjkZC3I=
X-Received: by 2002:a17:90a:d60d:b0:324:e3cc:d224 with SMTP id
 98e67ed59e1d1-32515ee54c6mr24462178a91.4.1756233912679; 
 Tue, 26 Aug 2025 11:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw59f7XyhG6WglB2EH1+eozjdh1SVOUOxSaVdHEa4Kj9otQLbtySDs+RdCaqDTriwQqcrgYg==
X-Received: by 2002:a17:90a:d60d:b0:324:e3cc:d224 with SMTP id
 98e67ed59e1d1-32515ee54c6mr24462136a91.4.1756233912183; 
 Tue, 26 Aug 2025 11:45:12 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276aeef8b8sm220661a91.21.2025.08.26.11.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 11:45:11 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v6 3/3] target/arm: Added test case for SME register exposure
 to GDB
Date: Tue, 26 Aug 2025 18:45:04 +0000
Message-Id: <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZrORalPsGNMt0Xhj5evq91Ay7LZxnbsL
X-Proofpoint-ORIG-GUID: ZrORalPsGNMt0Xhj5evq91Ay7LZxnbsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1tIW7kj3Jnob
 0o2RrD9Sb9Zl1Y73+oDN+ED/7s6weQY31gTpOkzfbNOsGQZOE4aEI4Bzhw0M0wOfe5sSP8bR1FY
 6GiKG6JL+QrhjddoMjOC2jPs7p5kmblSqo8rWDFJRpOW+KY9sKkHgk4RHIYTAvV6yAnBm/9pEgI
 74xIRw8wUvs9wvrSZ5qh3+t+EvfP/+pIL+z4URaUiuhGGowhJNPMHQu84bpq910HihXsPCkO3P+
 GAOLkXll749St60+Ta5WOh+U1RBvK3TXBFzwfBxbkOlEkaM8R0lzQBjLvKKtELK/8LNMru6Qd1U
 D+k58GyPDMO9deCHLrNwvlV4ESEVzj8jiIhL6rhzjTsWgbjUwuKHJR+frpDq9hH/hIx1URIF4/T
 dEAhw/F5
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ae00ba cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NuJLd7iFDieCY-iTVAkA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds a test case to test SME register exposure to
a remote gdb debugging session. This test simply sets and
reads SME registers.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v5:
- added copyright and SPDX line
- added functionality to avoid casting a gdb.Value object
to int when testing the za quadwords to address bug found
during review, this change is declared to users via a
warning message included in the test results file
run-gdbstub-sysregs-sme.out
---
 configure                             |  11 ++
 tests/tcg/aarch64/Makefile.target     |  33 +++++-
 tests/tcg/aarch64/gdbstub/test-sme.py | 165 ++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

diff --git a/configure b/configure
index 274a778764..9e2ae174dc 100755
--- a/configure
+++ b/configure
@@ -1839,6 +1839,17 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
+      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
+          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
+          if test "$gdb_version" = "15.0.50.20240403-git"; then
+            echo "GDB_HAS_INT_CAST_SUPPORT=n" >> $config_target_mak
+          else
+            echo "GDB_HAS_INT_CAST_SUPPORT=y" >> $config_target_mak
+          fi
+       else
+          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
+      fi
+
       if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 16ddcf4f88..f9304d29cf 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -132,7 +132,38 @@ run-gdbstub-sve-ioctls: sve-ioctls
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	basic gdbstub SVE ZLEN support)
 
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+# SME gdbstub test
+ifeq ($(GDB_HAS_SME_TILES),y)
+ifeq ($(GDB_HAS_INT_CAST_SUPPORT),y)
+run-gdbstub-sysregs-sme: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_sme_tile_support --gdb_int_cast_support, \
+	basic gdbstub SME support)
+else
+run-gdbstub-sysregs-sme: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_sme_tile_support, \
+	basic gdbstub SME support)
+endif
+else
+run-gdbstub-sysregs-sme: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py, \
+	basic gdbstub SME support)
+
+endif
+endif
+
+EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstub-sysregs-sme
 
 ifeq ($(GDB_HAS_MTE),y)
 run-gdbstub-mte: mte-8
diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64/gdbstub/test-sme.py
new file mode 100644
index 0000000000..e27a37631b
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme.py
@@ -0,0 +1,165 @@
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from __future__ import print_function
+#
+# Test the SME registers are visible and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import argparse
+import gdb
+from test_gdbstub import main, report
+
+MAGIC = 0x01020304
+INT_CAST_SUPPORT = 0
+
+def run_test():
+    "Run through the tests one by one"
+
+    frame = gdb.selected_frame()
+    rname = "za"
+    za = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    for i in range(0, 16):
+        for j in range(0, 16):
+            cmd = "set $za[%d][%d] = 0x01" % (i, j)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+    for i in range(0, 16):
+        for j in range(0, 16):
+            reg = "$za[%d][%d]" % (i, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint8_t",
+                    "size of %s" % (reg))
+            report(int(v) == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+def run_test_slices():
+    "Run through the tests one by one"
+
+    frame = gdb.selected_frame()
+    rname = "za"
+    za = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    for i in range(0, 16):
+        for j in range(0, 16):
+            cmd = "set $za[%d][%d] = 0x01" % (i, j)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+    for i in range(0, 16):
+        for j in range(0, 16):
+            reg = "$za[%d][%d]" % (i, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint8_t",
+                    "size of %s" % (reg))
+            report(int(v) == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+    if INT_CAST_SUPPORT:
+        for i in range(0, 4):
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    cmd = "set $za%dhq%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    reg = "$za%dhq%d[%d]" % (i, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == "uint128_t",
+                        "size of %s" % (reg))
+                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+            
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    cmd = "set $za%dvq%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    reg = "$za%dvq%d[%d]" % (i, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == "uint128_t",
+                        "size of %s" % (reg))
+                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+    else:
+        for i in range(0, 4):
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    cmd = "set $za%dhq%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    reg = "$za%dhq%d[%d]" % (i, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == "uint128_t",
+                        "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+            
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    cmd = "set $za%dvq%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+            for j in range(0, 4):
+                for k in range(0, 4):
+                    reg = "$za%dvq%d[%d]" % (i, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == "uint128_t",
+                        "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+    for i in range(0, 4):
+        for j in range(0, 4):
+            for k in range(0, 4):
+                cmd = "set $za%dhd%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                gdb.execute(cmd)
+                report(True, "%s" % cmd)
+        for j in range(0, 4):
+            for k in range(0, 4):
+                reg = "$za%dhd%d[%d]" % (i, j, k)
+                v = gdb.parse_and_eval(reg)
+                report(str(v.type) == "uint64_t",
+                    "size of %s" % (reg))
+                report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+        
+        for j in range(0, 4):
+            for k in range(0, 4):
+                cmd = "set $za%dvd%d[%d] = 0x%x" % (i, j, k, MAGIC)
+                gdb.execute(cmd)
+                report(True, "%s" % cmd)
+        for j in range(0, 4):
+            for k in range(0, 4):
+                reg = "$za%dvd%d[%d]" % (i, j, k)
+                v = gdb.parse_and_eval(reg)
+                report(str(v.type) == "uint64_t",
+                    "size of %s" % (reg))
+                report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+
+parser = argparse.ArgumentParser(description="A gdbstub test for SME support")
+parser.add_argument("--gdb_sme_tile_support", help="GDB support for SME tiles", \
+                    action="store_true")
+parser.add_argument("--gdb_int_cast_support", 
+                    help="GDB support for 128bit int cast", \
+                    action="store_true")
+args = parser.parse_args()
+
+if args.gdb_sme_tile_support:
+    if args.gdb_int_cast_support:
+        INT_CAST_SUPPORT = 1
+    else:
+        print("WARNING: The version of gdb used (15.0.50.20240403-git)\n"
+        "does not support casting a gdb.Value object to 128 bit python\n"
+        "integer. Thus, the testing for the ZA quadwords will be done\n"
+        "without int casting. Refer to tests/tcg/aarch64/gdbstub/test-sme.py\n"
+        "for details.")
+    main(run_test_slices, expected_arch="aarch64")
+else:
+    main(run_test, expected_arch="aarch64")
-- 
2.34.1


