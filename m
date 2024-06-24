Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC090C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcJ5-0003Dd-Ue; Mon, 24 Jun 2024 01:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIn-00037A-OU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIk-0004cI-Fj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so3295325b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207096; x=1719811896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2omjNcQCl3bA8iJpJioZJa0qVBvqhzbaUByrAv6rKE=;
 b=ifXYgzgqXAHT0ouUWJ69j35ch0AkofbRd066msLQIaZXw85RFEy8osK3IyVCix0aKb
 ufyru8lMMomxuF0bV4aPBFtAf1jlNUir/qzVlFo+ZrdtTxIrNbVtwn/A6q6ir/FgZo6N
 hDcGclExfoQo6rqyJ565kL8kfbFHqTgAFW9E+PqI6Bc4MIKA0uoegkBvmvIgAVDN43Hi
 rXxxAp0lKYct6C6jpzj2rxOscBrMW4b7ggu437slQJphK/FFff24wwjw6jFBUVZav7TG
 n5MA0chqdxSgg0mGJ85czeFCcd8/Y7WU+nMAABLdVxgo5TUrGrTvx5wjErD3t6UOmM6F
 lQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207096; x=1719811896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2omjNcQCl3bA8iJpJioZJa0qVBvqhzbaUByrAv6rKE=;
 b=dd1U5F28ar/UsqQD8VUP86gA1n7lTUx2QLrDZGI6nkduogW1jexhI63/QDMHSCBG5V
 3H+SPkSyzuQnO++air3lqCkHjV5fUPm8o0XHZlbKDfPyD/pNHWVkTauUfhdMdHEYcptf
 xV8G77t3enWuehdLqlKOEx7oktn6+M7gruJyM+aqthZ4fXmg6a2PS00MQH1S9Yqpvf16
 8A8fIw1oaTIki66imlXVjwisfDvlVYATXf/1zMD0Y50XmQ8f8mfaAWNeQCFeL0aNbmJR
 /r+Bg5kZWXyDTK87vGZqMiBVGzYDR0VRoEjC0NwVqmt5IwnuxQ4GuCejnPZscTCzSTxC
 dmag==
X-Gm-Message-State: AOJu0Yyd+f1IsKE3JVUwUl4qg/MtVkxEWIjT7g8l4xO1t5VF1oSA5VP2
 POraUQkEDrzGkC3yaSbkLj4yUKucbIe/SXceAvym55YgaBXI6Elt6ueBaYq+3EYnhg0LnRhsiv2
 ymso=
X-Google-Smtp-Source: AGHT+IGg3a4aK8Py/obPeH4OZ0j+q92brK4YPvgSnmYflfZfroSsEZUwswy2ZjbFiYa5BgiC13TKjg==
X-Received: by 2002:a05:6a20:92aa:b0:1b6:dffa:d6ec with SMTP id
 adf61e73a8af0-1bcf7fcd63bmr3516852637.46.1719207095495; 
 Sun, 23 Jun 2024 22:31:35 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:34 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 9/9] tests/tcg/aarch64: Add MTE gdbstub tests
Date: Mon, 24 Jun 2024 05:30:46 +0000
Message-Id: <20240624053046.221802-10-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add tests to exercise the MTE stubs. The tests will only run if a
version of GDB that supports MTE is available in the test environment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure                             | 11 +++
 tests/tcg/aarch64/Makefile.target     | 14 +++-
 tests/tcg/aarch64/gdbstub/test-mte.py | 86 +++++++++++++++++++++++
 tests/tcg/aarch64/mte-8.c             | 98 +++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

diff --git a/configure b/configure
index 5ad1674ca5..975fd89412 100755
--- a/configure
+++ b/configure
@@ -1109,6 +1109,13 @@ if test -n "$gdb_bin"; then
     else
         gdb_bin=""
     fi
+
+    # Does GDB support MTE (Memory Tagging Extension)?
+    if version_ge ${gdb_version##* } 15.0; then
+        gdb_has_mte="yes"
+    else
+        gdb_has_mte="no"
+    fi
 fi
 
 ##########################################
@@ -1637,6 +1644,10 @@ echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
 fi
+if test "$gdb_has_mte" = "yes" ; then
+    echo "GDB_HAS_MTE=y" >> tests/tcg/$config_host_mak
+fi
+
 
 tcg_tests_targets=
 for target in $target_list; do
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..f306e3d257 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -62,7 +62,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
@@ -128,6 +128,18 @@ run-gdbstub-sve-ioctls: sve-ioctls
 	basic gdbstub SVE ZLEN support)
 
 EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
+
+ifeq ($(GDB_HAS_MTE),y)
+run-gdbstub-mte: mte-8
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
+	gdbstub MTE support)
+
+EXTRA_RUNS += run-gdbstub-mte
+endif
+
 endif
 endif
 
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
new file mode 100644
index 0000000000..2db0663c1a
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -0,0 +1,86 @@
+from __future__ import print_function
+#
+# Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
+# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
+# operations, hence don't exercise any stub.
+#
+# The test consists in breaking just after a atag() call (which sets the
+# allocation tag -- see mte-8.c for details) and setting/getting tags in
+# different memory locations and ranges starting at the address of the array
+# 'a'.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+
+import gdb
+import re
+from test_gdbstub import main, report
+
+
+PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_1 = ".*(0x[0-9a-f]+)"
+
+
+def run_test():
+    gdb.execute("break 95", False, True)
+    gdb.execute("continue", False, True)
+    try:
+        # Test if we can check correctly that the allocation tag for
+        # array 'a' matches the logical tag after atag() is called.
+        co = gdb.execute("memory-tag check a", False, True)
+        tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
+        if tags_match:
+            report(True, f"{tags_match[0]}")
+        else:
+            report(False, "Logical and allocation tags don't match!")
+
+        # Test allocation tag 'set and print' commands. Commands on logical
+        # tags rely on local operation and so don't exercise any stub.
+
+        # Set the allocation tag for the first granule (16 bytes) of
+        # address starting at 'a' address to a known value, i.e. 0x04.
+        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
+
+        # Then set the allocation tag for the second granule to a known
+        # value, i.e. 0x06. This tests that contiguous tag granules are
+        # set correct and don't run over each other.
+        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, True)
+
+        # Read the known values back and check if they remain the same.
+
+        co = gdb.execute("memory-tag print-allocation-tag a", False, True)
+        first_tag = re.match(PATTERN_1, co)[1]
+
+        co = gdb.execute("memory-tag print-allocation-tag a+16", False, True)
+        second_tag = re.match(PATTERN_1, co)[1]
+
+        if first_tag == "0x4" and second_tag == "0x6":
+            report(True, "Allocation tags are correctly set/printed.")
+        else:
+            report(False, "Can't set/print allocation tags!")
+
+        # Now test fill pattern by setting a whole page with a pattern.
+        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, True)
+
+        # And read back the tags of the last two granules in page so
+        # we also test if the pattern is set correctly up to the end of
+        # the page.
+        co = gdb.execute("memory-tag print-allocation-tag a+4096-32", False, True)
+        tag = re.match(PATTERN_1, co)[1]
+
+        co = gdb.execute("memory-tag print-allocation-tag a+4096-16", False, True)
+        last_tag = re.match(PATTERN_1, co)[1]
+
+        if tag == "0xa" and last_tag == "0xb":
+            report(True, "Fill pattern is ok.")
+        else:
+            report(False, "Fill pattern failed!")
+
+    except gdb.error:
+        # This usually happens because a GDB version that does not
+        # support memory tagging was used to run the test.
+        report(False, "'memory-tag' command failed!")
+
+
+main(run_test, expected_arch="aarch64")
diff --git a/tests/tcg/aarch64/mte-8.c b/tests/tcg/aarch64/mte-8.c
new file mode 100644
index 0000000000..9fffd7b737
--- /dev/null
+++ b/tests/tcg/aarch64/mte-8.c
@@ -0,0 +1,98 @@
+/*
+ * To be compiled with -march=armv8.5-a+memtag
+ *
+ * This test is adapted from a Linux test. Please see:
+ *
+ * https://www.kernel.org/doc/html/next/arch/arm64/memory-tagging-extension.html#example-of-correct-usage
+ */
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <string.h>
+/*
+ * From arch/arm64/include/uapi/asm/hwcap.h
+ */
+#define HWCAP2_MTE              (1 << 18)
+
+/*
+ * From arch/arm64/include/uapi/asm/mman.h
+ */
+#define PROT_MTE                 0x20
+
+/*
+ * Insert a random logical tag into the given pointer.
+ */
+#define insert_random_tag(ptr) ({                   \
+    uint64_t __val;                                 \
+    asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
+    __val;                                          \
+})
+
+/*
+ * Set the allocation tag on the destination address.
+ */
+#define set_tag(tagged_addr) do {                                      \
+        asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
+} while (0)
+
+
+int main(int argc, char *argv[])
+{
+    unsigned char *a;
+    unsigned long page_sz = sysconf(_SC_PAGESIZE);
+    unsigned long hwcap2 = getauxval(AT_HWCAP2);
+
+    /* check if MTE is present */
+    if (!(hwcap2 & HWCAP2_MTE))
+            return EXIT_FAILURE;
+
+    /*
+     * Enable the tagged address ABI, synchronous or asynchronous MTE
+     * tag check faults (based on per-CPU preference) and allow all
+     * non-zero tags in the randomly generated set.
+     */
+    if (prctl(PR_SET_TAGGED_ADDR_CTRL,
+              PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC |
+              (0xfffe << PR_MTE_TAG_SHIFT),
+              0, 0, 0)) {
+        perror("prctl() failed");
+        return EXIT_FAILURE;
+    }
+
+    a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (a == MAP_FAILED) {
+        perror("mmap() failed");
+        return EXIT_FAILURE;
+    }
+
+    printf("a[] address is %p\n", a);
+
+    /*
+     * Enable MTE on the above anonymous mmap. The flag could be passed
+     * directly to mmap() and skip this step.
+     */
+    if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
+        perror("mprotect() failed");
+        return EXIT_FAILURE;
+    }
+
+    /* access with the default tag (0) */
+    a[0] = 1;
+    a[1] = 2;
+
+    printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
+
+    /* set the logical and allocation tags */
+    a = (unsigned char *)insert_random_tag(a);
+    set_tag(a);
+
+    printf("%p\n", a);
+
+    return 0;
+}
-- 
2.34.1


