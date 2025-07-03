Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FA1C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpR-0006Z1-MP; Thu, 03 Jul 2025 13:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNp1-00067j-FV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoz-0008NR-8v
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso28894f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564042; x=1752168842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx6KMQw8/FlRNTZmEqVUbDa7PGnyLnMhWj7KkWZFnoM=;
 b=Mdo40MewnXquP3Pux+z97q9fHZQT/h8IU8s0PqKWKJUPdGXXfdr4AzXS3x7xJuk3jS
 DoztxXrjkO4ZbjS2x2Tv/3y1Ge8RhDmtC50+DbqZ9VG3tbhBjAJL2rUlwZ+xDGz+b6fA
 YhDcgJvZNrVbst+Nf3iPdrhi7BhmWopxeM++MY46LAzXfi+Ihq6PtOV5pQuOx0pf6Xu7
 BT5v8M0AivwmMugUOho9WdgjJHLBwrci1RXBBcnnkx83E50AFbWhNiJySNqmqxAL5HV1
 V6H+puFOnIu+7XUxqH7RgrJapwo1VAlF0GUtToWjLTvhmA0Tavr6rKQbxUkF7t86ZX6r
 P5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564042; x=1752168842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx6KMQw8/FlRNTZmEqVUbDa7PGnyLnMhWj7KkWZFnoM=;
 b=T7S6ruru/JxGmYDhShpME6SFSaIovkz1sUa003V1tgkFTuVl9bEpqhw8aenFCfyE8p
 dwMiBEvl8+Xzw3u+xQpyxCsNFDBLjfX/B6biV0Q+ku8lI31aya9SFWpe1fWdTp8KdbN6
 0/fhETt45u3x84Eg7BkrgVOp4qUnYKB6S6s7EjyO6uEIwfbjlPsueReocH+erPzRoYdY
 CUCsAoIHk1YHBBtZ0CeDch+ynKlORQ747IYCJ26phcSCC1ZdE9C0MAsVZBcXfAQkHQf1
 ImKI6P26vppAsSPOur/aOUaS9zbwM5GR/6yN1nrkqm0EtGCxvr0F0zv79dlqlS8Gew0k
 fvzw==
X-Gm-Message-State: AOJu0Yw7BdDrFlZMwiaY23TmP4YkdM/1w2Fxs4mgZ0nfmcTR4BOkTjVP
 w6E1NdSl2/Gl2ynIX82zvL9qGTqfoV2Z01hBAGUfdcNGLb8wo2Oal96K7Ti+c2U3TIT2sxbixvQ
 oV4C2goI=
X-Gm-Gg: ASbGncsuXzLh/OmD1tNMMrWTFWbHj+mEvdiYt02dX4sffdF70BuYbY+t2mCfYxh3AGp
 KUoCrCWgAf3nA1A3W2/fuZqEh9J8hEKvyWv7p+hwDPTmzVV6Bf7gdPGlzRcJ+pR+gFw9AtRrg7N
 Ch5LAU+RKT7Ur5bSvZiAcbjBy7D8B18go3NhFGTB9jWEGxdXMCbtV9CupfqNLAYkb82jAt3qelH
 CEdclp6MufXM//rtWwm5GINQtJXWrG3yJtdAfUkfwNvERSbWb5trQxnMRa/QA0SdkgIdJG0W4aF
 NMPnxo8PEF7FI88GcuY6UUlWq6eP/4eWWPVIhvfrESR8yWDnjEvemSmO3clWcu27MjPJb8GZKfe
 iWbNBEfrOJWwNhQAnHb9LsGAmuxX6Lxv4kVPm
X-Google-Smtp-Source: AGHT+IFnEJvbccQl9NuxDXr6r9kBXQmzF6fHXy9j1Yz5apR3negcqbwZ1xBPZw9TbiuxaRiahJGQmg==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3b1fdd16d21mr6756060f8f.16.1751564042531; 
 Thu, 03 Jul 2025 10:34:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997b492sm32358785e9.13.2025.07.03.10.34.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v6 14/39] accel/hvf: Restrict internal declarations
Date: Thu,  3 Jul 2025 19:32:20 +0200
Message-ID: <20250703173248.44995-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Common code only needs to know whether HVF is enabled and
the QOM type. Move the rest to "hvf_int.h", removing the
need for COMPILING_PER_TARGET #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf.h     | 38 --------------------------------------
 include/system/hvf_int.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index a9fd13d9bba..d3dcf088b3f 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -14,10 +14,6 @@
 #define HVF_H
 
 #include "qemu/accel.h"
-#include "qemu/queue.h"
-#include "exec/vaddr.h"
-#include "qom/object.h"
-#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_HVF
@@ -40,38 +36,4 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
-#ifdef COMPILING_PER_TARGET
-struct hvf_sw_breakpoint {
-    vaddr pc;
-    vaddr saved_insn;
-    int use_count;
-    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
-};
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
-                                                 vaddr pc);
-int hvf_sw_breakpoints_active(CPUState *cpu);
-
-int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
-int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
-void hvf_arch_remove_all_hw_breakpoints(void);
-
-/*
- * hvf_update_guest_debug:
- * @cs: CPUState for the CPU to update
- *
- * Update guest to enable or disable debugging. Per-arch specifics will be
- * handled by calling down to hvf_arch_update_guest_debug.
- */
-int hvf_update_guest_debug(CPUState *cpu);
-void hvf_arch_update_guest_debug(CPUState *cpu);
-
-/*
- * Return whether the guest supports debugging.
- */
-bool hvf_arch_supports_guest_debug(AccelState *as);
-#endif /* COMPILING_PER_TARGET */
-
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d774e58df91..dcf06f53d97 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -12,6 +12,8 @@
 #define HVF_INT_H
 
 #include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "qom/object.h"
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
@@ -77,4 +79,36 @@ int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+struct hvf_sw_breakpoint {
+    vaddr pc;
+    vaddr saved_insn;
+    int use_count;
+    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
+};
+
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
+                                                 vaddr pc);
+int hvf_sw_breakpoints_active(CPUState *cpu);
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
+void hvf_arch_remove_all_hw_breakpoints(void);
+
+/*
+ * hvf_update_guest_debug:
+ * @cs: CPUState for the CPU to update
+ *
+ * Update guest to enable or disable debugging. Per-arch specifics will be
+ * handled by calling down to hvf_arch_update_guest_debug.
+ */
+int hvf_update_guest_debug(CPUState *cpu);
+void hvf_arch_update_guest_debug(CPUState *cpu);
+
+/*
+ * Return whether the guest supports debugging.
+ */
+bool hvf_arch_supports_guest_debug(AccelState *as);
+
 #endif
-- 
2.49.0


