Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D21D637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTR-0003xD-Gp; Wed, 13 Nov 2024 20:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSn-0002Gg-2d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSj-0002ze-RP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso889975e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546955; x=1732151755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKGKBpB51JYn8fa9pIjr5nOqIfE0klwKIY58pnM7yzQ=;
 b=yNiImsWRDsx6DyLM8W8L1YX5g+13n6q2eBH1gVUCdB36VlznTMNM9/7Wyueo3IQZHW
 ULtuj4kBJvlmpp5tTwuriTBJPooBNt6wnSRooO6as89wqJJOILpFoWjSLUsSt6XKKXM/
 CwZOlyqecIAGAeORc0q/csEio1ifDxMfMygLA5jcSiA2HIccTArcis97wgB9HxPDDiiB
 tjihHDN8sJIRZ9OJXqG2+FniC3YVYxli1tyBuCrXBKRvfMixG0YBz5bpalLyLv6rQZ75
 24JEreVeDC92V+SjY4pLPIqwf8ut6Q7ZsboPnv3RKsG8tRRuPlMQTozMVkv9EsJE8I9L
 igcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546955; x=1732151755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKGKBpB51JYn8fa9pIjr5nOqIfE0klwKIY58pnM7yzQ=;
 b=D8U75EBPTXDeNQTvRvvWYenM2MSA83yXfjkH5BllQVfaAPTw7EFdw/qL29nHEpbo0v
 j/4fQLmqgNfOYSmcd5DwOZPuwXCpdFIxZ3MHFuYehlSi9EZTry8ue0HSBFOpAxxADCpQ
 EX33/T0bSMqRcdCw5KmYsZQmgJS9z76EN3+nGRQciJo99YgZXWdvtGgmJ8a44Zhhmotn
 2W/GkRBmv/QRUB3w8HpGH0nixwl4gNPq186gJnUqzBOKqHVfqBbD5pY+ijfEcY8Om5LN
 aPP6FWzfmL/z8Q7tntKctR+CYHpn7SYqtt9HVUcKxfuKPgTCAZQ+R69J9zB3cVo0jfPh
 KOrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQSyho98NiMxjhM485maXmccuBuEK53LwTcinNSReFGzO8TMM5kX2DUU1HPXN2oK+Z/kwUHGy3vb1@nongnu.org
X-Gm-Message-State: AOJu0Yy3B5izbTOS/9TJV56zDBLUpKXCaJ2BGE0mAGiarTiUPuGXZejw
 gL/EIa1Y6H9H+KWo9Mc9dqZpiXOGhLx6wSXW+cKU+UVXj/Vo38X3khVCOzMLKWk=
X-Google-Smtp-Source: AGHT+IGZeLWyySAwDHTHVjsW2SFDufD9UpueEyNXzGy6rQrK9O+R2MVoL8wOSZmjPebbfF+JzN4y0Q==
X-Received: by 2002:a05:6000:1ac9:b0:374:c640:8596 with SMTP id
 ffacd0b85a97d-381f186fc60mr19166319f8f.32.1731546955339; 
 Wed, 13 Nov 2024 17:15:55 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381fc0f5f91sm11245808f8f.62.2024.11.13.17.15.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/24] exec: Declare tlb_vaddr_to_host() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:05 +0100
Message-ID: <20241114011310.3615-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h     | 25 -------------------------
 include/exec/cputlb.h       | 26 ++++++++++++++++++++++++++
 target/arm/tcg/helper-a64.c |  1 +
 target/ppc/mem_helper.c     |  1 +
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 769e9fc440..eec47ca05e 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -69,7 +69,6 @@
 #include "exec/memopidx.h"
 #include "exec/vaddr.h"
 #include "exec/abi_ptr.h"
-#include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
 
 #if defined(CONFIG_USER_ONLY)
@@ -311,30 +310,6 @@ uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-/**
- * tlb_vaddr_to_host:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @access_type: 0 for read, 1 for write, 2 for execute
- * @mmu_idx: MMU index to use for lookup
- *
- * Look up the specified guest virtual index in the TCG softmmu TLB.
- * If we can translate a host virtual address suitable for direct RAM
- * access, without causing a guest exception, then return it.
- * Otherwise (TLB entry is for an I/O access, guest software
- * TLB fill required, etc) return NULL.
- */
-#ifdef CONFIG_USER_ONLY
-static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      MMUAccessType access_type, int mmu_idx)
-{
-    return g2h(env_cpu(env), addr);
-}
-#else
-void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
-                        MMUAccessType access_type, int mmu_idx);
-#endif
-
 /*
  * For user-only, helpers that use guest to host address translation
  * must protect the actual host memory access by recording 'retaddr'
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 07c4bc669e..4acc2c6235 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -20,6 +20,7 @@
 #ifndef CPUTLB_H
 #define CPUTLB_H
 
+#include "exec/abi_ptr.h"
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
@@ -306,4 +307,29 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
                   int mmu_idx, vaddr size);
 
+/**
+ * tlb_vaddr_to_host:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @access_type: 0 for read, 1 for write, 2 for execute
+ * @mmu_idx: MMU index to use for lookup
+ *
+ * Look up the specified guest virtual index in the TCG softmmu TLB.
+ * If we can translate a host virtual address suitable for direct RAM
+ * access, without causing a guest exception, then return it.
+ * Otherwise (TLB entry is for an I/O access, guest software
+ * TLB fill required, etc) return NULL.
+ */
+#ifdef CONFIG_USER_ONLY
+#include "user/guest-host.h"
+static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                                      MMUAccessType access_type, int mmu_idx)
+{
+    return g2h(env_cpu(env), addr);
+}
+#else
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
+                        MMUAccessType access_type, int mmu_idx);
+#endif
+
 #endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 8f42a28d07..9cb5d8ee53 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -30,6 +30,7 @@
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/cputlb.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 #include "fpu/softfloat.h"
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 51b137febd..44974b25f8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "exec/cputlb.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
 
-- 
2.45.2


