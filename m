Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82977C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBR-0007Se-Dc; Tue, 01 Jul 2025 10:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBM-0006tz-4h
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBJ-0006x5-Ng
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2707838f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380913; x=1751985713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/f32srrQFtVjI1/fpLwO8kbOY7BvaFI4sQ1UNMe9p/w=;
 b=GLQ+QCasYTnWC4GBqxedHrpvRYQb4o7lhGD2s0+RVQFa2jtIJ6HI+1zH+7ZDuH6LrM
 pYjgcpA0lIOuOZxZ7r51ESAj6aOVKHh66CenX4dJT5pEOtYLpbtJ4ED8ba/FEPrC3AZy
 2sSL3/dUV4QBOrJUazBVYXePRlOuGtXtJ/iGCppHJi9kbw26S+sCtpF+SwcK7a/cbz8W
 3peGQOnXtYQR3Ku5fcWVtvqtI6ZxjPGSYqdF5tBPjF8xAA9SRkt8P41XXHMbEjMGNB0K
 ZbiHCN0eD3AA+xVTIhagPfg5k/ulx2E2PMiyOJODC+bHx301BieOhLdHGmR81aymwzC/
 /5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380913; x=1751985713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/f32srrQFtVjI1/fpLwO8kbOY7BvaFI4sQ1UNMe9p/w=;
 b=JBJCD9+ytcyEJY8f7NXBlQuMcIZpFkzZsNqVpc+PPloEUiImKEiMKNanCZM8IFIkla
 Iv3sHInMjm3FvVg237wS9bvxQkpn0mUcmmheX8oOD7V0J/FeecelLlhRyUoax0OTQTte
 xLWIAC4bykOd8y65CKYQJy0a0e9h7s9LpJA6+dei9hLeVixSfTISND3zYcLfgktyd6Ua
 QNhgMlETNlbZ7nqKZI6xfvf3rpB6wQIntI+RzW7COWCov3qHx4kjEDCOpH1FS8tu1FtW
 KheOt/wTAbRJ91R1J9VtH39+l3c0XpwEXuNuZhDIR3wYDBNubPjFfFCkPXUuYNbRj8Z0
 RL6Q==
X-Gm-Message-State: AOJu0YxhlNyOTjfgqYqCf73hPZlNdHogkmapAtWq+wjZBKKkh5I1LEaN
 nNX2BGTpsIatKfPaqen2sXjzmVQ38w/LRrSfSc/7fg6/eqIJDGQQ8U0QEj6oAnjSvbf1rCOpjdp
 tuULz
X-Gm-Gg: ASbGncsqYQ7u/8NXBTkMDFmzFYJsTxQ/XQk1gfwuqoqGNL219Yh9zw84pJJox2oIZ0F
 cwvZMAMN7YlZOwCWdx0ZnZCXVAZlz+gWgfAVMcEDRsqpf4WXDcmpARGuHgZTz7OG7EGJuZElB+L
 tWY9O47RdHd+yNDr/nll0FTYjDRQjLwA1CQYB8OdwVbuPDlflM2kdOhToUpYpaDdpnSaCL6wTaE
 2Efk84ISbeeKbfanG76EhrLYStFBYyHqyOMUFlAZpxK0rnWoRKNOg9J8/8U4vivefPsiyH1TZc/
 /XBRq/jQ593KukApMFwykQGk+AS55n88ZJpG+NvrSdBtcA2u7py5b7UdSJXIEq+rUlL8Ypq+tKx
 VOv6WCzVsS5L0bJkLGH8/x3DNBLxfS6UTvyIK
X-Google-Smtp-Source: AGHT+IGoAe0fPs3T5IvXlgKgLtXDYC6dG4Aks5Kd9cGZlblleypCjNZIvgiwT36sjHlOuwuGvwCKpA==
X-Received: by 2002:a05:6000:1448:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3a90c07d619mr15228331f8f.57.1751380913441; 
 Tue, 01 Jul 2025 07:41:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e9d1csm13642956f8f.13.2025.07.01.07.41.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/68] accel: Move supports_guest_debug() declaration to
 AccelClass
Date: Tue,  1 Jul 2025 16:39:25 +0200
Message-ID: <20250701144017.43487-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

AccelOpsClass is for methods dealing with vCPUs.
When only dealing with AccelState, AccelClass is sufficient.

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h       | 1 +
 include/system/accel-ops.h | 1 -
 include/system/hvf.h       | 2 +-
 accel/hvf/hvf-accel-ops.c  | 2 +-
 accel/tcg/tcg-accel-ops.c  | 6 ------
 accel/tcg/tcg-all.c        | 6 ++++++
 gdbstub/system.c           | 7 ++++---
 target/arm/hvf/hvf.c       | 2 +-
 target/i386/hvf/hvf.c      | 2 +-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 1c097ac4dfb..c6fe8dc3913 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,6 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
+    bool (*supports_guest_debug)(AccelState *as);
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index a863fe59388..51faf47ac69 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -65,7 +65,6 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    bool (*supports_guest_debug)(void);
     int (*update_guest_debug)(CPUState *cpu);
     int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
     int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
diff --git a/include/system/hvf.h b/include/system/hvf.h
index 8c4409a13f1..7b9384d816c 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -71,7 +71,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
 /*
  * Return whether the guest supports debugging.
  */
-bool hvf_arch_supports_guest_debug(void);
+bool hvf_arch_supports_guest_debug(AccelState *as);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b57a75f83e3..a2e0f890463 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -358,6 +358,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
+    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
 }
 
@@ -594,7 +595,6 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
-    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 };
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 37b4b21f882..07b1ec4ea50 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -106,11 +106,6 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static bool tcg_supports_guest_debug(void)
-{
-    return true;
-}
-
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
@@ -218,7 +213,6 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5904582a68d..93972bc0919 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,6 +219,11 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
+static bool tcg_supports_guest_debug(AccelState *as)
+{
+    return true;
+}
+
 static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
@@ -242,6 +247,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
+    ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
     object_class_property_add_str(oc, "thread",
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8a32d8e1a1d..bced226fd94 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -634,9 +634,10 @@ int gdb_signal_to_target(int sig)
 
 bool gdb_supports_guest_debug(void)
 {
-    const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->supports_guest_debug) {
-        return ops->supports_guest_debug();
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->supports_guest_debug) {
+        return acc->supports_guest_debug(accel);
     }
     return false;
 }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6551cf1bed1..3fb0b49df8a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2343,7 +2343,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps(cpu);
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 28484496710..bcf30662bec 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1024,7 +1024,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return false;
 }
-- 
2.49.0


