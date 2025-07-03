Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5FCC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHhj-0001uC-LP; Thu, 03 Jul 2025 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeR-0005tD-5l
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeP-0002yC-Bw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4539cd7990cso5161885e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540323; x=1752145123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IUtIm3JHDSf2CDlC9ODm0iBh8kfs+CSjmgEqHJOxOs=;
 b=jEc9RJRB3iAW1FPyYgtVf14aakJbC0CzPEeN/eCmwmdpXkaNbxz+eLZO8bkZEBaPQf
 jX6Geh1P3Z2flC5hZGhy0UcyeJjNLAcJW9B8dwu2K89AjaEUkbC7dzo6qaOHf3NWc3rz
 AiIesyBZah1/NQsLyc1Z0iT1A4XcWnXVLGIqIz5XyUKL1biG724Rl0aCvnwVBZ54yPeG
 U6f5ygXmVNeNz3GtFxgSblpur8AyEAz/JoTSwbdSvIRf4FoV5S4GpVMUtadJ0Ou8kjdK
 c2yup+TfAdXqTy22StHDynfSYYeykDvLegrv59PBo2T5DvtLjwPyZw9rEYRU3j7bWLwN
 4dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540323; x=1752145123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IUtIm3JHDSf2CDlC9ODm0iBh8kfs+CSjmgEqHJOxOs=;
 b=sjrqubmPv28Jsd7S++4sMWcB1Cm4FiqqvKFDbPZubsIFk+HzArLK9swnxtDv4vK8xq
 aWPGARRNMVlsHSb5I+5nQOU9yBBu3BwUTzDCxbSLUknuK9/7/5djSFS0QHt1ftnBSeeG
 lkLZWs9dHvKgYP1e6L79HI5td5/j7NJ8EKgZNvxEkziSTwwpDyBpj8i6ItdhSdad4vvM
 s0nX9xycgu7HORq5LcppzYHuTUAw+zpDlTtjSEXBTHQZemw9D8x2CWnqjqALUx3/dwsn
 RWW+Lk+l2mPCQuclMqJhH0PuLz2GBs8uHLKfS8AfA/btHCxVVV4ifBl9d9qs+OMfzlYA
 3fpQ==
X-Gm-Message-State: AOJu0Yw3f2PbFBAS4qp4mTzow4d7J7lzVE2ktxtCBXBKEtDHhRT1GP7t
 eYKyvvq1aANJDW+3hH+r14eUYEWqfttaNOpieXv1rNgPz++l3iBTTW/3FTQDbR+9HQnVz2uHKMt
 tKBbEhdg=
X-Gm-Gg: ASbGncu1sSg4fUlRQwpWhGmbK+f+kwVwn55qcrUiOxmCvKMrGhjEj+XTGV+lb3bZcMd
 Yv2PSxO5DO3zBagDm42Ad98KxnGDkoTMYXIbr9UIdGXAjiXm53DFwB2lDHBVdXn3mhTQu7X/E+Q
 xPCB4Wa7Xiub48cUCBZXM35ZmaicA8E9C/q1WH+6MZdXVQruHSkioqAtd/9i6Bo9XhqI2Uop61j
 nhpyvGMr1feqaB738cTq8nM9PzuS8yQcIHNAQs/qRxgqFOYVCirJLC+SOd/h5NC0H3RjzPHR1yg
 +o90+kKulnyfWWv0QSACdmIGoJftZ5QLdTzNMrUmbhG2nz3lJ8OVe25PJDj9FYxKNDNswXuBuEO
 kWNO5bhYnuqA=
X-Google-Smtp-Source: AGHT+IGtJ0cI//sX+xQO2okCH3UjY/N8mn1LD8ELSsOTVKgUuaoSzuNpUsRkyEMDk9mdHMZB/nR0mA==
X-Received: by 2002:a05:600c:8b23:b0:453:69dc:2621 with SMTP id
 5b1f17b1804b1-454ab34b49bmr23287835e9.12.1751540323244; 
 Thu, 03 Jul 2025 03:58:43 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde3b9sm23830665e9.28.2025.07.03.03.58.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 34/69] accel/hvf: Restrict internal declarations
Date: Thu,  3 Jul 2025 12:55:00 +0200
Message-ID: <20250703105540.67664-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 include/system/hvf.h     | 41 ----------------------------------------
 include/system/hvf_int.h | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 7b9384d816c..d3dcf088b3f 100644
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
@@ -40,41 +36,4 @@ typedef struct HVFState HVFState;
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
-
-bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
-
-#endif /* COMPILING_PER_TARGET */
-
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d774e58df91..ea6730f255d 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -12,6 +12,8 @@
 #define HVF_INT_H
 
 #include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "qom/object.h"
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
@@ -77,4 +79,38 @@ int hvf_put_registers(CPUState *);
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
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
-- 
2.49.0


