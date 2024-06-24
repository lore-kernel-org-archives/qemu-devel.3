Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E493C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIe-00034k-16; Mon, 24 Jun 2024 01:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIY-00033V-Cr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIW-0004b2-Ey
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so876232b3a.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207082; x=1719811882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iJ/HuUc4gPL6Bek0vAIaSv9Lqxnq8U+8yqS5vGEFYg=;
 b=eYjMn2CWiLEcp4eQqYjzpDdl2xu0/w9XyDEs7XABnPfGq535BFJNkCNI72IO2wJZnY
 04smpS67nJUqqdsPl7qV6fCSjt/j0JN7pffyf+D2GlsWNtLqceuAtl3dvL1l3XaURxCg
 AM0xAGwSAB5Dq6hwsZ5V9yqj8hpQ6qflADI06RxznkiIN/Iwyfrdhf20p3mwnCvTXJSn
 CH7kKTqV14QzdJ7WEHc1F4LiOx0WXDpJkCHXw8WS3sANFzGDniXlOduf5Rs20CY4hmU9
 mKK+JJazKEfgjquVGDfPMj0MaN73aw8qPBJmkZovQNTZ9cXS86ggcKPxUWIBz62muEpJ
 Sz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207082; x=1719811882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iJ/HuUc4gPL6Bek0vAIaSv9Lqxnq8U+8yqS5vGEFYg=;
 b=QUn1DsTusL0HDFKv1WX2pgBtY3rmLZtTSHu8pDi07IgaArbWWrfS/NUe8M3nQSps+6
 KfbIbaunt0gGiAm20wlcnEYCnIcgK9kMVmnx1UhsDhADYrmFSuz2Hrq1hMKEx7oPKTKc
 AnMLA8YojEGD5+mV41QWdG1c2wBrFyfWQHS7+H+tH/VD/cvTDPopAytrrk657Z4jLwf9
 zily3o/T6inWTab+a6BEUWg9/Kmsxx/mg+19jC7+92ge5/L4GG0pkLB2S1Wc3PDKiRww
 mUmE0e1u2xMzKybph8NkG+izmF7ubhnJJYIBwcQmO/1k+pGevIcJLFM+l/m75RCEiu0y
 hsnQ==
X-Gm-Message-State: AOJu0YyuFnBM6bDMsBBOq4RMYiBzyC7qMUTHNRHbqSirsi9MBkC+HJ6n
 mwyAfaQqj4gO7NpzXI/925m3YJNaSbqyxKecIhW0pxLc1cDKG1OKRz2g9zv2Sbb2GcVqs6p4fH2
 1g4Q=
X-Google-Smtp-Source: AGHT+IGPkcB1mPLKWHp6ccRvEoBXk8TjRqXZktogzEcLg2V8o4EwD4BVV5t9ihpE3nPE9NM00BN6xw==
X-Received: by 2002:a05:6a20:4da6:b0:1bc:f67f:604a with SMTP id
 adf61e73a8af0-1bcf67f7e5cmr3830998637.30.1719207082389; 
 Sun, 23 Jun 2024 22:31:22 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:21 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 5/9] target/arm: Make some MTE helpers widely available
Date: Mon, 24 Jun 2024 05:30:42 +0000
Message-Id: <20240624053046.221802-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
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

Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
available to other subsystems.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 54 +++------------------------
 target/arm/tcg/mte_helper.h | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 49 deletions(-)
 create mode 100644 target/arm/tcg/mte_helper.h

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a50d576294..da6bc72b9c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,6 +29,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#include "mte_helper.h"
 
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
@@ -50,42 +51,10 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
-/**
- * allocation_tag_mem_probe:
- * @env: the cpu environment
- * @ptr_mmu_idx: the addressing regime to use for the virtual address
- * @ptr: the virtual address for which to look up tag memory
- * @ptr_access: the access to use for the virtual address
- * @ptr_size: the number of bytes in the normal memory access
- * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
- *
- * Our tag memory is formatted as a sequence of little-endian nibbles.
- * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
- * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
- * for the higher addr.
- *
- * Here, resolve the physical address from the virtual address, and return
- * a pointer to the corresponding tag byte.
- *
- * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
- *     that the page is going to be accessible. We will take watchpoint traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
- */
-static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                         uint64_t ptr, MMUAccessType ptr_access,
-                                         int ptr_size, MMUAccessType tag_access,
-                                         bool probe, uintptr_t ra)
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     uint64_t clean_ptr = useronly_clean_ptr(ptr);
@@ -287,12 +256,6 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
     return address_with_allocation_tag(ptr + offset, rtag);
 }
 
-static int load_tag1(uint64_t ptr, uint8_t *mem)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    return extract32(*mem, ofs, 4);
-}
-
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
     int mmu_idx = arm_env_mmu_index(env);
@@ -320,13 +283,6 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
     }
 }
 
-/* For use in a non-parallel context, store to the given nibble.  */
-static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    *mem = deposit32(*mem, ofs, 4, tag);
-}
-
 /* For use in a parallel context, atomically store to the given nibble.  */
 static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
 {
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
new file mode 100644
index 0000000000..6a82ff3403
--- /dev/null
+++ b/target/arm/tcg/mte_helper.h
@@ -0,0 +1,74 @@
+/*
+ * ARM MemTag operation helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_MTE_H
+#define TARGET_ARM_MTE_H
+
+/**
+ * allocation_tag_mem_probe:
+ * @env: the cpu environment
+ * @ptr_mmu_idx: the addressing regime to use for the virtual address
+ * @ptr: the virtual address for which to look up tag memory
+ * @ptr_access: the access to use for the virtual address
+ * @ptr_size: the number of bytes in the normal memory access
+ * @tag_access: the access to use for the tag memory
+ * @probe: true to merely probe, never taking an exception
+ * @ra: the return address for exception handling
+ *
+ * Our tag memory is formatted as a sequence of little-endian nibbles.
+ * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
+ * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
+ * for the higher addr.
+ *
+ * Here, resolve the physical address from the virtual address, and return
+ * a pointer to the corresponding tag byte.
+ *
+ * If there is no tag storage corresponding to @ptr, return NULL.
+ *
+ * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
+ * three options:
+ * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
+ *     accessible, and do not take watchpoint traps. The calling code must
+ *     handle those cases in the right priority compared to MTE traps.
+ * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
+ *     that the page is going to be accessible. We will take watchpoint traps.
+ * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
+ *     traps and watchpoint traps.
+ * (probe = true, ra != 0 is invalid and will assert.)
+ */
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra);
+
+/**
+ * load_tag1 - Load 1 tag (nibble) from byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ */
+static inline int load_tag1(uint64_t ptr, uint8_t *mem)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    return extract32(*mem, ofs, 4);
+}
+
+/**
+ * store_tag1 - Store 1 tag (nibble) into byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ * @tag: The tag to be stored in the nibble
+ *
+ * For use in a non-parallel context, store to the given nibble.
+ */
+static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    *mem = deposit32(*mem, ofs, 4, tag);
+}
+
+#endif /* TARGET_ARM_MTE_H */
-- 
2.34.1


