Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D35C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszff-0002JI-3S; Fri, 14 Mar 2025 03:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfd-0002J1-Fl
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfb-0007eb-EI
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22398e09e39so37229655ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741938085; x=1742542885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMZ7bGsdyUxFQzv8iAUGh2h0oRF3xPj9mgSB3AvlNs4=;
 b=e1fVJY8VYMfg2zMMpiDrBUCC8I6NU5NBA3jw/dX/eyIBiAIwWwId/Y+dKqbGTo/sju
 mZCysxQwqGZxpEDYQRZJsjjJapCSOLmN30c1PRAjj8B3LfqGYPBzbSFo0z+XEtR5X7mm
 6ca4UXFuKRzh4iSxsVUWpvrYJt0gBacKHpEn4aWb+KbIUDbt2wKOHWfahVNKtmSleBhb
 S2s9aDc7CkL0WQnewiYIy5k57SrOot1CGqArCcZI3K8rKnB7Lk64prx3jsQCxObAtxxf
 Bp0Ji3CC9EMd7qr0Kp9N8a1s5iaRTyAn40tWCTNAqmn2tvXPONbuv7cfrK6ea8QHroDo
 WdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741938085; x=1742542885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMZ7bGsdyUxFQzv8iAUGh2h0oRF3xPj9mgSB3AvlNs4=;
 b=dWvRIe+WJdQPp+4nnM9DdVC0aJwqefYLAI7fVQIenK8yEU6Oac+5l5mw/j3ZstXVfj
 LOlWHaoW2yLgaqqD8liE5F+clQ6xlPxyqWcMiXqAWH/3RR9CI08ozCu9Q3HSXZ5LXioq
 FlJ32WxK6Ysi6oVOKWOJS1XCFlpaCwW9zCGBV4dw4Pk0/VBkhzG6yNxIzQZfaYBCqua1
 7utbk21Ry+eIy/SaRvSFGwv6605muJjsqVhjIJUg5aj0CiUSgZ9RaTg4zDtmk3mHvmaF
 GNVMxlQG8flh4DBeaTITnTTCzk8ZuObEaMJZNIndHoVUh9jsUU/uBPGG8OM2LxlfK8Gp
 oEWw==
X-Gm-Message-State: AOJu0Yx0zgBMxxxe1cU07+33AA77VHEq4eHZ519Z59Tc8BNzx00INoxW
 K3isxWpMn4Zu7rWKf4wdzM46bBDkvOS7om+lFPNdldNRnBLW/HlsTtDd7WDp
X-Gm-Gg: ASbGncsBD5B6cEIviKatdi+wc517zqbeydZ782yR3mGEb97hNaPHPWrkXddJzAWoje+
 dly4iJG1WSK+78zl7Nbkn3RFDwRw9F+hjmtXBtFNCARMfjG0SBrKrgbWel3Hb7SczlJSeqsXxbd
 l66HU6ryuF2pdIUYWngiHwaHEKxG6W6zFNpixEpuTHfyiNPRShKyUjyJE46Ubj65zItsXNL0KnE
 2aQxAdiSKlFXvKGoIHYCB+y9bDwJydnNzbIETWauPvKI3EX3RgI4WlMHfDEllzRCSKrwg/WkPlJ
 5YvbCTzA9ufVwyxwEUiqZhZtVm37Ha34pe3goZgqfItXvhY=
X-Google-Smtp-Source: AGHT+IHQsrUB93GnZ89Twk7TIfBFKkudFgGaKaEvucHR7zOh38yvjsOUdWoTCYBffiHvjxZR/paIjQ==
X-Received: by 2002:a17:903:1a2f:b0:224:1001:6787 with SMTP id
 d9443c01a7336-225e0a19badmr25968245ad.4.1741938085293; 
 Fri, 14 Mar 2025 00:41:25 -0700 (PDT)
Received: from wheely.local0.net ([1.146.112.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688857esm24322315ad.17.2025.03.14.00.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 00:41:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/2] gdbstub: Add phys_memory_rw_debug for physical memory
 access
Date: Fri, 14 Mar 2025 17:41:06 +1000
Message-ID: <20250314074107.992163-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250314074107.992163-1-npiggin@gmail.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add an accessor for gdb physical memory access mode which sets the
the .debug attribute for the MemTxAttribute, and also returns success
to the caller.

GDB with PhyMemMode will now report failure from memory accesses outside
valid system memory addresses, and it is also able to write to ROMs as
GDB virtual memory access can.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/loads-stores.rst | 11 +++++++++++
 include/exec/cpu-common.h   |  3 +++
 gdbstub/system.c            |  7 +------
 system/physmem.c            | 16 ++++++++++++++++
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..ac2e0d34d67 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -481,6 +481,17 @@ would ignore the write attempt).
 
 ``cpu_memory_rw_debug``
 
+``phys_memory_rw_debug``
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Access system memory by physical address for debug purposes.
+
+This function is intended for use by the GDB stub and similar code.
+It takes a physical address and operates on the system address space.
+Access is performed as in cpu_memory_rw_debug().
+
+``phys_memory_rw_debug``
+
 ``dma_memory_*``
 ~~~~~~~~~~~~~~~~
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3771b2130c2..6429dc2331e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -181,6 +181,9 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
 /* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
+/* Returns: 0 on success, -1 on error */
+int phys_memory_rw_debug(hwaddr addr, void *buf,
+                         hwaddr len, bool is_write);
 
 /* vl.c */
 void list_cpus(void);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index dd22ff0fb3a..79fcb30f6f0 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -457,12 +457,7 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
-        return 0;
+        return phys_memory_rw_debug(addr, buf, len, is_write);
     }
 
     if (cpu->cc->memory_rw_debug) {
diff --git a/system/physmem.c b/system/physmem.c
index e97de3ef65c..aa78b0d514b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3743,6 +3743,22 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
+/* physical memory access for debug (includes writing to ROM) */
+int phys_memory_rw_debug(hwaddr addr, void *buf,
+                         hwaddr len, bool is_write)
+{
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult res;
+
+    attrs.debug = 1;
+    res = address_space_rw(&address_space_memory, addr, attrs,
+                           buf, len, is_write);
+    if (res != MEMTX_OK) {
+        return -1;
+    }
+    return 0;
+}
+
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
     MemoryRegion*mr;
-- 
2.47.1


