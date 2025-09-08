Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14011CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgc6-00081w-0c; Mon, 08 Sep 2025 14:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgby-0007zv-CX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:29:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbi-0001BV-64
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:29:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GKD8R022423
 for <qemu-devel@nongnu.org>; Mon, 8 Sep 2025 18:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5kvK2Zbx18K
 SbtZ55xiDNMiC1rLFrM21UQJLE860tI8=; b=cyzVlUFwVlleO/KxB+IHCx7gHwR
 /pRtKwUGG4dyqX3CRomGGrhC0rtLEYL6f99cZ643DduHx2LGYowFzw5Ru89yyj2v
 2MOOGjRQgoZnbl+zMfAJ4dL89WTILR+JQzVlydm+sIrKv0QWxUhCgsNruQ4Ws02b
 85sTna4PU/ziOX/KpSla9gf2lbZgfGvjxKCFInpPwkjAUN5W0H9FLZTo2Inz2WOH
 Pbl+f0IdxNv9Z5N/3COt0ESGMbWAwkmLZPI0gOVCfj0oF6qB4XlGYjW4Q+pL3NjM
 HRoEbiMIb/H4b+Y2v0db8GB6rbI5jkg24mNUTyfWVbdBce3zyvpxyZ65yYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc21kqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 18:28:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4c949fc524so3686516a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757356119; x=1757960919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kvK2Zbx18KSbtZ55xiDNMiC1rLFrM21UQJLE860tI8=;
 b=v55j8Q0OaoO63cHWouaG0gq577VvYAVZzYkeY+/L07hr6jHTyQt/zKn1Rtr18/p59k
 kxqhPJqt8VozouHKjkOMoor3ygZ9EUA9sBtCK4GedeV2RZsQPqoTSO8LFarh4HF/YW09
 cfJc7xtTupx1SPBK8pQNUQpvviBi2YBXDxQZZTnZ6fTZ/5gp+LS3h/5FFdbh/odLJz0v
 XU6M2m6R0RvrAaqOjpAY/X5ko+Zaqf1omTeuu7ut7zyI0hNATQYNZtjzcWHGHoxHGHuG
 7OMfjXBjo3wQn3+Nmeza09497VnuOSzyy6aAVihhDZoH4jw0BWoBcwCCY5+WyRWVkTYw
 rrug==
X-Gm-Message-State: AOJu0YxknWliam+woUfCF32vukpPRrzdFSCGctNkVxxUzpkWOUtjiVMt
 weF7nOyf1Cvds9FmU4LG6WH9uAqoQfYUySwA+2kv3rJTg/o8Saxdy2OOTkG4fCaqN9GxwoY6IMn
 apLH/hP15o7pxEMUOYk+kii8GZm3tqBp39fLs5s0QvUzlxnWln7PJ6rfFdIotzoftiEd2
X-Gm-Gg: ASbGncu9SsVupbN8fvj9OA2sA96+xySsB5+WuxDVRdkjtqISW/kxypW4wqIG9zDwUOz
 hi2jwRJF0RW6bsITjPkBttIblaAslbhoQbHiTGKjuAvNmfTTrW59ih6c8Oj+JK49k6bRJ+y34kD
 YGurq85yEFObkKy8xWiumb4AvQnvgIPAY77Qahg9pBUs8wonCirh9xlF/LgwjwnzwNGgHPenBxf
 9+RC10c5vZe33d4VX8J5Wae7Ni5BrITfqJSCuI5321aPxa0cxek2PizXHItwWgqhl3YiR5wmymL
 SJAZI5NkVNe7bzJHxpmlTnsxYtqqONLAS59BXFd2NR/M+iug9zg8aPMGbiT0WSZpgQXuUPyMxJA
 73U4vM2eZG3QgOZo=
X-Received: by 2002:a05:6a20:9184:b0:251:e4b4:7a37 with SMTP id
 adf61e73a8af0-2533fd956b8mr14460962637.19.1757356119326; 
 Mon, 08 Sep 2025 11:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFum+csjEs7j5pwEm3dPD3XQBJuekdLEcDs89Ufxyf0P01sRmq1HZiknm8O7cElTbz9htywzw==
X-Received: by 2002:a05:6a20:9184:b0:251:e4b4:7a37 with SMTP id
 adf61e73a8af0-2533fd956b8mr14460916637.19.1757356118804; 
 Mon, 08 Sep 2025 11:28:38 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4f9c35f391sm15480164a12.25.2025.09.08.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:28:38 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v7 3/3] target/arm: Added test case for SME register exposure
 to GDB
Date: Mon,  8 Sep 2025 18:28:34 +0000
Message-Id: <20250908182834.2476277-4-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68bf2059 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Z_9JEIKELzp6YBcrEJoA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 6PLqvX07JmQ4gV7kGloOKvF9CPjKUGor
X-Proofpoint-GUID: 6PLqvX07JmQ4gV7kGloOKvF9CPjKUGor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXyeck0vk27c/o
 eC3w77tj9QXrSGE+9LWBp/hG2oAfLbUOsCNY9qd20mJ8K3AXZGcl9+G4r4rNtwzgcS2G03SO6pj
 0SjJ6rI4gAtG9cw3wyHAe73z6YGZk+X9ArUctdISyYoIxcgZd7mYI9OQnUxtbcEFBQeGiQbkQA7
 ssWe7GtEcryHCtnMK9zDl+ejbekenGerZoRuwepMZqId0gm21qo/sYPkSzoOC9U8sT2cF+lW/YE
 IU49IN8y68O4M1MZwGaITDoH6pNYbsFMWBHLdo9B4LdQ4YeT9EZzRdhE/9+BavbjG85R8RjqtwT
 cdgxMlUv5+qwMJArRxmHynESyVUxeTsktSbEkDjpJWNdZVRGXfsLwqA4ENx0S1LZVW+KRlXCvPH
 AT+R+aXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Changes since v6:
- added functionality to skip ZA quadword and doubleword
tile slice tests when the detected version of gdb does not
support SME tile slices
- added functionality to skip ZA quadword tile slice test
when the detected version of gdb does not support casting
gdb.Value to a 128bit python integer
- cleaned up testcase and made it more compact with additional
comments
---
 configure                             |  11 +++
 tests/tcg/aarch64/Makefile.target     |  51 +++++++++++
 tests/tcg/aarch64/gdbstub/test-sme.py | 125 ++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

diff --git a/configure b/configure
index 274a778764..8de18e755f 100755
--- a/configure
+++ b/configure
@@ -1839,6 +1839,17 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
+      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
+          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
+          if version_ge $gdb_version 16.1; then
+            echo "GDB_HAS_128BIT_INT_CAST_SUPPORT=y" >> $config_target_mak
+          else
+            echo "GDB_HAS_128BIT_INT_CAST_SUPPORT=n" >> $config_target_mak
+          fi
+       else
+          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
+      fi
+
       if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 16ddcf4f88..954bc3139a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -134,6 +134,57 @@ run-gdbstub-sve-ioctls: sve-ioctls
 
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
+run-gdbstub-sysregs-sme-doubleword-tile-slice: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_doubleword_tile_slice_test, \
+	gdbstub SME ZA doubleword tile slice support)
+
+ifeq ($(GDB_HAS_128BIT_INT_CAST_SUPPORT),y)
+run-gdbstub-sysregs-sme-quadword-tile-slice: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_quadword_tile_slice_test, \
+	gdbstub SME ZA quadword tile slice support)	
+
+else
+run-gdbstub-sysregs-sme-quadword-tile-slice: sysregs
+	$(call skip-test,"gdbstub SME ZA quadword tile slice support", \
+	"selected gdb ($(GDB)) does not support casting gdb.Value into 128bit python integer")
+
+endif
+else
+run-gdbstub-sysregs-sme-doubleword-tile-slice: sysregs
+	$(call skip-test,"gdbstub SME ZA doubleword tile slice support", \
+	"selected gdb ($(GDB)) does not support SME ZA tile slices")
+
+run-gdbstub-sysregs-sme-quadword-tile-slice: sysregs
+	$(call skip-test,"gdbstub SME ZA quadword tile slice support", \
+	"selected gdb ($(GDB)) does not support SME ZA tile slices")
+
+endif
+
+EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-doubleword-tile-slice \
+			  run-gdbstub-sysregs-sme-quadword-tile-slice
+			  
+endif
+
 ifeq ($(GDB_HAS_MTE),y)
 run-gdbstub-mte: mte-8
 	$(call run-test, $@, $(GDB_SCRIPT) \
diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64/gdbstub/test-sme.py
new file mode 100644
index 0000000000..bad80f9925
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme.py
@@ -0,0 +1,125 @@
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
+DOUBLEWORD_TILE_SLICE_TEST = 0
+QUADWORD_TILE_SLICE_TEST = 0
+
+def run_test():
+    
+    # Run the requested test(s) for SME ZA gdbstub support
+
+    if BASIC_ZA_TEST:
+        run_basic_sme_za_gdbstub_support_test()
+    if DOUBLEWORD_TILE_SLICE_TEST or QUADWORD_TILE_SLICE_TEST:
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
+            report(int(v) == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+def run_basic_sme_za_tile_slice_gdbstub_support_test():
+
+    # Test if SME ZA tile slices, both horizontal and vertical,
+    # can be correctly read and written to. The sizes to test
+    # depend on which tests are requested (QUADWORD_TILE_SLICE_TEST
+    # and/or DOUBLEWORD_TILE_SLICE_TEST).
+
+    sizes = {}
+    if QUADWORD_TILE_SLICE_TEST:
+        sizes["q"] = "uint128_t"
+    if DOUBLEWORD_TILE_SLICE_TEST:
+        sizes["d"] = "uint64_t"
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
+                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
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
+                    report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+
+parser = argparse.ArgumentParser(description="A gdbstub test for SME support")
+parser.add_argument("--gdb_basic_za_test",
+		            help="Enable test for basic SME ZA support",
+                    action="store_true")
+parser.add_argument("--gdb_doubleword_tile_slice_test",
+		            help="Enable test for ZA doubleword tile slice support",
+                    action="store_true")
+parser.add_argument("--gdb_quadword_tile_slice_test",
+                    help="Enable test for ZA quadword tile slice support",
+                    action="store_true")
+args = parser.parse_args()
+
+if args.gdb_basic_za_test:
+    BASIC_ZA_TEST = 1
+if args.gdb_doubleword_tile_slice_test:
+	DOUBLEWORD_TILE_SLICE_TEST = 1
+if args.gdb_quadword_tile_slice_test:
+	QUADWORD_TILE_SLICE_TEST = 1
+
+main(run_test, expected_arch="aarch64")
-- 
2.34.1


