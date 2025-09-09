Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CA7CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0w2-0007UQ-V2; Tue, 09 Sep 2025 12:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0va-0007Oh-F3
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:10:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0vJ-0001e8-7f
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:10:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LQEa020147
 for <qemu-devel@nongnu.org>; Tue, 9 Sep 2025 16:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=obhecAcaWf1
 AiFkb7ZGuTlnLmsM1XQEOi2Z4/adR2Xg=; b=MRRC+1OoymkN+epNu/N8NslnQvk
 LlRT4AomcibZEuK2pQsZI9T89bwZEFHqUnE5xce+pEkCcrDpIa8JwtAD9Mhck56w
 FRCHXB2PBgOMxcL+KbK5OxEwKaba3MMvBcESHpckFjMjPVPBW7viR79foWlWj7+a
 Z+5s6mKL4uZpTbmiefFvZ1k/9INzYiUkDPuXFNPf/04epOUsrojG5Of1PU+aA4Ux
 VlBItbPMkd8rnwndrTakAXKd51Hy49CU8SSLbW6oL0ezU6cWW8y5IImQDmwGpy6b
 CBYZ7X703/TNwn+OcECYQJEwou0ZE0iRopykyCE9tc1Gf1gcPE0l/jopsrA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a8rg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 16:10:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e3db861eso5374711a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 09:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434219; x=1758039019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obhecAcaWf1AiFkb7ZGuTlnLmsM1XQEOi2Z4/adR2Xg=;
 b=Gm4jrZud4Tfz9dJSilO/UwIto8RUJGU8RV4F41ppnSJIPEAjeKtFBb5q5AnNkaGCEP
 9W0fIdgCpsHvUUPVivarbcVFHdnca3MJBty6d/YFUYr0galqn1rxX5CypdePwCmCfjaY
 3eGaxSd4SAB6bkwsZ6s8453gPVXnU0RaqxlRt4bR3CqoGCLiRxoClQZUoCpM0/cVkHGS
 matF8B3XIlo7TcLMGhL2SGGolMeSxV901RVQ1g7K3wEdzrmCrQrPKTqwNMCpJ75WEQQZ
 bl5RA1Sd3HhIKesa/B9k8zKPBBdBAZpnfrvc4QxnU+80Hi7sDR8+eY50oEOPckQtxE3i
 PQ1A==
X-Gm-Message-State: AOJu0YzLfNLiQCaV772krFH/psyaN3YI2BmJ/1TY9PwLLdykzVIP8yYA
 qBgF7KpdnwmU+wmKQoOr2Tg0RPbii3bk5AEDktHRPW5hxyKQ+bPNUzh24hzVEZ25CLaT8Rk1ioT
 oqIcSMJtw3+fNgFbInPEhFZm8aplBmNbMPPW8/6dUCrLsq9by12P4DnMA/iQDYaOPG+3A
X-Gm-Gg: ASbGnctEeqWeIpAXwPMHY85C2v6A+e3lbo1cdbq3SudMRgRxx5KcAX9IDdoQoiB4vOh
 EuuT0SU/UJyeuqju8LKrSH6KB0RGzNIVf/lE/cKuZLcpH4uI0fj7aQ7LhOKd9pJuN0VW7HNJyeg
 q6OWPzU4tTxZFKvr7/mkhg0v7ZJXBi0PZ0Zgmx/S4mrD999K4WCwAPLfS1X8zmm7P/6PUbZSXnN
 zp/OcLB4zotFfMFDfEgkkSbWDvTC/lf66l7yn/o6aFhgrVvnEI8pMMnAYkWAfsBTV4baNLnLVWH
 mAmkKRox+US/M+gmQ+zLVKpI+/MLFydG+XY8SeT1FZOu2aK86R5iL/Ine9LENUTdqc/gSer/fB1
 oCBYdeqqcm231YlI=
X-Received: by 2002:a17:902:f684:b0:24c:be1f:c1f9 with SMTP id
 d9443c01a7336-2516d33d2demr137694665ad.8.1757434218531; 
 Tue, 09 Sep 2025 09:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7uXqTcCHtKK+IAStDMTF/GyKPFW+DXhncOW9Gln+4mzW3hRv5RzMNOwV9jK72QS7ToE4pMA==
X-Received: by 2002:a17:902:f684:b0:24c:be1f:c1f9 with SMTP id
 d9443c01a7336-2516d33d2demr137694095ad.8.1757434217799; 
 Tue, 09 Sep 2025 09:10:17 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a43a9bcsm1794975ad.89.2025.09.09.09.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 09:10:17 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v8 3/3] target/arm: Added test case for SME register exposure
 to GDB
Date: Tue,  9 Sep 2025 16:10:12 +0000
Message-Id: <20250909161012.2561593-4-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c0516b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xJcYWlU_UAsFVtOlWloA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: DyI5H061f-rZ-a660mXBvjPzFGwBOB3C
X-Proofpoint-ORIG-GUID: DyI5H061f-rZ-a660mXBvjPzFGwBOB3C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX8CpZxVgWhR/3
 RIvsifcLlML4GSgRqRHKi6Zj/IzO3pGpS7MqylA1z/4xN/7sxub94YF+ClbmcToBgc1GZewODQf
 R1owl0H7lcKk6esJrjGyECJzAflLS3ueU0MNfyn4Wa7Gl5wLp7bzvgzDXIDLHSLTBrbdikRdpWo
 Bvu+a0vnpaKcMmyOwTZaPWumjuAf1Bcyjjw7RNYN6E0IrzFyoy7Ph7A5tVsRZNW9Lxn3d2Lqzl7
 EO9JzGnQf218CfraYgCQOLfBBVynyeACgWthRVBNshYdamy/TvZkj/VwAFUZh1uU6dvyrtZ8sxy
 yHJJ17X0xqDyQwy4YuHNVc6keOGQe6CAjLCsV781Bjxrgw/nEKaz9h92w5ne2cLY5+mFU5zcTuv
 ESvEzUxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Changes since v7:
- removed int casting in test and removed checks for appropriate
gdb versions which support the required int casting
- merged quadword and doubleword tile slice support test into a
single tile slice support test
---
 configure                             |   6 ++
 tests/tcg/aarch64/Makefile.target     |  29 +++++++
 tests/tcg/aarch64/gdbstub/test-sme.py | 116 ++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

diff --git a/configure b/configure
index 274a778764..9aea02cf6a 100755
--- a/configure
+++ b/configure
@@ -1839,6 +1839,12 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
+      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
+          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
+      else
+          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
+      fi
+
       if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 16ddcf4f88..41b31c9353 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -134,6 +134,35 @@ run-gdbstub-sve-ioctls: sve-ioctls
 
 EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
 
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+# SME gdbstub tests
+
+run-gdbstub-sysregs-sme: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_basic_za_test, \
+	basic gdbstub SME support)
+
+ifeq ($(GDB_HAS_SME_TILES),y)
+run-gdbstub-sysregs-sme-tile-slice: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_tile_slice_test, \
+	gdbstub SME ZA tile slice support)
+else
+run-gdbstub-sysregs-sme-tile-slice: sysregs
+	$(call skip-test,"gdbstub SME ZA tile slice support", \
+	"selected gdb ($(GDB)) does not support SME ZA tile slices")
+endif
+
+EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice
+			  
+endif
+
 ifeq ($(GDB_HAS_MTE),y)
 run-gdbstub-mte: mte-8
 	$(call run-test, $@, $(GDB_SCRIPT) \
diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64/gdbstub/test-sme.py
new file mode 100644
index 0000000000..ef3a4fcaee
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme.py
@@ -0,0 +1,116 @@
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
+BASIC_ZA_TEST = 0
+TILE_SLICE_TEST = 0
+
+def run_test():
+    
+    # Run the requested test(s) for SME ZA gdbstub support
+
+    if BASIC_ZA_TEST:
+        run_basic_sme_za_gdbstub_support_test()
+    if TILE_SLICE_TEST:
+        run_basic_sme_za_tile_slice_gdbstub_support_test()
+
+def run_basic_sme_za_gdbstub_support_test():
+
+    # This test will check for gdbstub support for correctly reading
+    # and writing to the SME ZA register at the byte level.
+    
+    frame = gdb.selected_frame()
+    rname = "za"
+    za = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    # Writing to the ZA register, byte by byte.
+    for i in range(0, 16):
+        for j in range(0, 16):
+            cmd = "set $za[%d][%d] = 0x01" % (i, j)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+
+    # Reading from the ZA register, byte by byte.
+    for i in range(0, 16):
+        for j in range(0, 16):
+            reg = "$za[%d][%d]" % (i, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint8_t", "size of %s" % (reg))
+            report(v == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+def run_basic_sme_za_tile_slice_gdbstub_support_test():
+
+    # Test if SME ZA tile slices, both horizontal and vertical,
+    # can be correctly read and written to. The sizes to test
+    # are quadwords and doublewords.
+
+    sizes = {}
+    sizes["q"] = "uint128_t"
+    sizes["d"] = "uint64_t"
+    
+    # Accessing requested sizes of elements of ZA
+    for size in sizes:
+
+        # Accessing various ZA tiles
+        for i in range(0, 4):
+
+            # Accessing various horizontal slices for each ZA tile
+            for j in range(0, 4):
+                # Writing to various elements in each tile slice
+                for k in range(0, 4):
+                    cmd = "set $za%dh%c%d[%d] = 0x%x" % (i, size, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+
+                # Reading from the written elements in each tile slice
+                for k in range(0, 4):
+                    reg = "$za%dh%c%d[%d]" % (i, size, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == sizes[size], "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+            
+            # Accessing various vertical slices for each ZA tile
+            for j in range(0, 4):
+                # Writing to various elements in each tile slice
+                for k in range(0, 4):
+                    cmd = "set $za%dv%c%d[%d] = 0x%x" % (i, size, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+
+                # Reading from the written elements in each tile slice
+                for k in range(0, 4):
+                    reg = "$za%dv%c%d[%d]" % (i, size, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == sizes[size], "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+
+parser = argparse.ArgumentParser(description="A gdbstub test for SME support")
+parser.add_argument("--gdb_basic_za_test",
+		            help="Enable test for basic SME ZA support",
+                    action="store_true")
+parser.add_argument("--gdb_tile_slice_test",
+		            help="Enable test for ZA tile slice support",
+                    action="store_true")
+args = parser.parse_args()
+
+if args.gdb_basic_za_test:
+    BASIC_ZA_TEST = 1
+if args.gdb_tile_slice_test:
+	TILE_SLICE_TEST = 1
+
+main(run_test, expected_arch="aarch64")
-- 
2.34.1


