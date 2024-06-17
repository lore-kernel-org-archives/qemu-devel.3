Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41E4C27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5rt-0003nX-8i; Mon, 17 Jun 2024 02:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rq-0003nA-Vm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:27 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rp-0003TN-1x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:26 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681ad081695so2948419a12.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718605763; x=1719210563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHrQ3G77kgCnmRSnx6cW7o5SiefrhlcrhIVHrhW0O+A=;
 b=VK1txVQS3Z5CJZzZhL4ptrvr1qjEl+mw0bBFfmhyDN01tVWZN8ePHmUnbaM0+O97ZG
 lNs+xr8u9lWqI1px7ByGNhVL736h/d24lr1A2jjDWLsoRhYKilpqEL8HUeErYOMIDx5A
 vtuE2DaMjxQ5m/BL83inSB7r777ul5xDA2vCDwIg+44Q2sYmqPKLTu/p7ugqxsu0qJDM
 WK+xjU5chSPBmyJjM9C+MIIn95Ry5ToceVmiLUEL/jmM7oey8OjdC5Foy1RJq+QlvOCR
 myvvJFeSRgSyuU0D6F1VvuLGG8LJNioGjgWiFpSumHUqCfnNiqDHaKDwFzAk8fVnc6R5
 mLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605763; x=1719210563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHrQ3G77kgCnmRSnx6cW7o5SiefrhlcrhIVHrhW0O+A=;
 b=RY1qStKh1o2zHMjRUTTW2E5KOT4WukNCWbhiUapckicm3kwRpCgifAT6BXO2vHDdi6
 bF8Oikd39zSvvNA5WkA+/pE1wVGbc50x2JykiO0pVnXNMuoLhVixXPtmpLRI3taz9ZGu
 VZxKpOmfgvi//BmPzwAwRo9dML72R1ZZWS0HKeDkb6VPLIxDDwOuW1bSO/izX8eSupX9
 InB1PVaP+LdfD3TmiDLz6RaYRnunEDm3Klqg44ZmQsBaALRewN6pY+wafxvoFuU3MkuQ
 hvduGJ5WYrjuQmNTbn57apwDSzOHzbTa4cXq4RxDX1Mo6rJSRW9EOOUR6MRsVIRaPN1Q
 rSwg==
X-Gm-Message-State: AOJu0YylKwPCTbVkSKUNmYMh6ZPKlBgvBLJAh+i4vrlOLtd2+ln1BIvW
 EfN0mr2u7rZNNjCPjhwafcjEUp8hslj3N9jGsw/JR+Nia68AZDy5r48RiXg1Dz7f6aKOEQsLNDQ
 o
X-Google-Smtp-Source: AGHT+IEstCCpnRiSKjFV482wNLmDYFeFWSLr/+eSXU3BYfEpUesBkugkbppWKLh6lgYjj/nWA/atVg==
X-Received: by 2002:a05:6a20:9190:b0:1b8:3f12:c8ed with SMTP id
 adf61e73a8af0-1bae7ec30c9mr9677094637.24.1718605763218; 
 Sun, 16 Jun 2024 23:29:23 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ed69csm10641863a91.14.2024.06.16.23.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 23:29:22 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 5/9] target/arm: Make some MTE helpers widely available
Date: Mon, 17 Jun 2024 06:28:45 +0000
Message-Id: <20240617062849.3531745-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617062849.3531745-1-gustavo.romero@linaro.org>
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 target/arm/tcg/mte_helper.c | 45 +++++---------------------
 target/arm/tcg/mte_helper.h | 63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 38 deletions(-)
 create mode 100644 target/arm/tcg/mte_helper.h

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a50d576294..e3d505e96a 100644
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
@@ -287,7 +256,7 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
     return address_with_allocation_tag(ptr + offset, rtag);
 }
 
-static int load_tag1(uint64_t ptr, uint8_t *mem)
+inline int load_tag1(uint64_t ptr, uint8_t *mem)
 {
     int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
     return extract32(*mem, ofs, 4);
@@ -321,7 +290,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 }
 
 /* For use in a non-parallel context, store to the given nibble.  */
-static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
 {
     int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
     *mem = deposit32(*mem, ofs, 4, tag);
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
new file mode 100644
index 0000000000..69ad8457f8
--- /dev/null
+++ b/target/arm/tcg/mte_helper.h
@@ -0,0 +1,63 @@
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
+/**
+ * load_tag1 - Load 1 tag (nibble) from byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ */
+int load_tag1(uint64_t ptr, uint8_t *mem);
+
+/**
+ * store_tag1 - Store 1 tag (nibble) into byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ * @tag: The tag to be stored in the nibble
+ */
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
+
+#endif /* TARGET_ARM_MTE_H */
-- 
2.34.1


