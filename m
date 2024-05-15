Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D2C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IUX-0005Fk-Tz; Wed, 15 May 2024 13:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUU-0005Ex-41
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUR-0002Qi-VG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f44d2b3130so5953626b3a.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715794350; x=1716399150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk+ySqx2GWVrBg6FqHG2e9b1M5JzmHbk4G1MUS+6KS8=;
 b=QzqEA9WaJ0mM4XUjLXERKJ42QKuJ9SMuNZMzkmOu6GLw+qJCX5Hlgukj1LHuI7pId+
 d03/lCX/yCZVHEDUG9O/ScmSj6aCCQggatAta6LA47nhz/YQKVJgUwLlT1EeDa67dbcd
 C1D4/biVjMEvpt7evAtziGVb4nZXv374PtE5TnFEk1SRHHzTEXnoKcz5a0jHX/xpesjl
 x3jWLqkIClus4norGC/NlGbEmAFdAgMRQvtSJL1mjMLKLbfT6kRR+KruBF9KI3/z1G5w
 4s+3Du2w7Ey65Iun3ALv1TiHKKmkl8gXhXfhNTIxzw4hr+xl9G2m8sVwlRVxuMjUV6HA
 ryng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715794350; x=1716399150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yk+ySqx2GWVrBg6FqHG2e9b1M5JzmHbk4G1MUS+6KS8=;
 b=fVZsiYzht3FLucG1JvwsVhQKLhEzg3fYnmWFpK+oCTSrWwvCBO/G81ZlgACgxB4fy/
 Zre8nuDAA3RUJ9/3WCmpZCADHXWkEvZ+E1f1QL3wx3djxafl1AL7wi6lDPU6GeCr3Iu8
 9rLPXBo6wGdAMuKrrUNEExH/v2Ua4b0k5QvVFNGhdnRg38ANtYm3WanK+/Af9e7rmmIT
 riyqpPqT7g14AsvmqEWp2bPZeY5xJfQYAwh1o/ER2e6D8cF/aFT+nUzkJwK5MIpzrYX9
 nG2oPFwGXSjAQ7AGMrljNpjdITM3tpOLmbAZs11Pq7Qk1qgdItQ8RIIOwMWsXtY3bjlX
 aehg==
X-Gm-Message-State: AOJu0YxfGBmbQm4j8jmYSMDP3OZKECSPUT6JMb8wm1UgiWAXbeI8bDwU
 SnrpsgAWEZoVmsiT4RwcYZzoM199MF+5WNxNDA2rBBpY0AnyiVIo3cpSoAaA2ELO0EBhWsM86gn
 pnVQ=
X-Google-Smtp-Source: AGHT+IE5KBa0NAt9ILd9epLkCMpE25x6hBD9IWfzhSIiA0gh/toURLx0YkCa/0TCFBDVIOQm7nVWEg==
X-Received: by 2002:a05:6a00:3994:b0:6f4:3b76:ebf7 with SMTP id
 d2e1a72fcca58-6f4e02db452mr16724323b3a.20.1715794349751; 
 Wed, 15 May 2024 10:32:29 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:224b:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm11365133b3a.6.2024.05.15.10.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:32:29 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 4/4] tests/tcg/aarch64: Add MTE gdbstub tests
Date: Wed, 15 May 2024 17:31:32 +0000
Message-Id: <20240515173132.2462201-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515173132.2462201-1-gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
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

Add tests to exercise the MTE stubs.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/aarch64/Makefile.target     |  11 ++-
 tests/tcg/aarch64/gdbstub/test-mte.py |  86 ++++++++++++++++++++++
 tests/tcg/aarch64/mte-8.c             | 102 ++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..d2e3f251eb 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -62,7 +62,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
@@ -127,7 +127,14 @@ run-gdbstub-sve-ioctls: sve-ioctls
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	basic gdbstub SVE ZLEN support)
 
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
+run-gdbstub-mte: mte-8
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin "$< -s" --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
+	gdbstub MTE support)
+
+EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstub-mte
 endif
 endif
 
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
new file mode 100644
index 0000000000..6530f33ad8
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
+    gdb.execute("break 94", False, True)
+    gdb.execute("continue", False, True)
+    try:
+        # Test if we can check correctly that the allocation tag for
+        # array 'a' matches the logical tag after atag() is called.
+        co = gdb.execute("memory-tag check a", False, True)
+        tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
+        if tags_match:
+            report(True, "Logical and allocation tags match.")
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
index 0000000000..367768e6b6
--- /dev/null
+++ b/tests/tcg/aarch64/mte-8.c
@@ -0,0 +1,102 @@
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
+    if (!(argc == 2 && strcmp(argv[1], "-s") == 0)) {
+        return 0;
+    }
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


