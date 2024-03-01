Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D839C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2Z-0004tn-8a; Fri, 01 Mar 2024 18:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1X-0003rp-Gv
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:44 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1V-0005ig-RL
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:39 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f15bso658681b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334636; x=1709939436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5H5GE1LAqBUPd7mQOHglWKh/GcV0V+kwE9pYm3ahFA=;
 b=lJYAe32X81XPDf+gXyZgIsourEj2xnRFoqlWjxG8mNoZbq2djjMCDm+JjZY6cJkNL4
 NndUDSADBbMEILefks0Ezfa4Md2/hG4IA2ILhKWm3rvclj4OTu4Or56sH+mYANCGhn9v
 msGoRxLf462rbgJYpmaI8B+7b7xXPCSdHvGTi9qSrYoGxOL6kqMxBLQrjPkenRWtOdHq
 YBKj4xv1ec70ZWz7ZZLn5os0Zrr5v87bYZlWUf/KEGe2h9KjAXuWiGavP+0p5H1ghvsd
 TZlWD/hdSf1s2IvoYyYxFkvCTPgKIuuMyyqNXQp0ubIxg9jE5k+OLlhfGW/cvlDPPEbn
 cigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334636; x=1709939436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5H5GE1LAqBUPd7mQOHglWKh/GcV0V+kwE9pYm3ahFA=;
 b=eaBRBLcnC/bGv73b6IpWqbNoWucdNCVhls7D+PfVCZtZMuKuiWnnfHag7U9xJBe28k
 pqXB1yj4GiwCu7JFpEUupwH/ZQhGxUKorpgKyJdYbjiUSh1P1dZ6IC04t/z7y7QPmGEF
 OpR1NUT3sFIAPOeMFJgtooOhlYPIDJG8Y7QTPFsMjIRbkD+trXdpYh7xU9e8nkryi85v
 j5EQdS4tCY+xf5jfwV8apG+4iXZ9VIZTpxPuMgJOPncv/rhAZyAAzXVosTu0XqAwVrju
 C4mcxLn3U4MXjvspnkneoEm9BOv2irWGqvtWaYAi8HtH0kR634ulW+QKGASvNm9YjK5D
 IFeA==
X-Gm-Message-State: AOJu0YzWaJRKeHebYlt9NPZz8eHzQrcun2NoSKi+cf6367lqKnVhYH3r
 Gqrot1Rn7TGRI7HglOYjJtqxn6RI1osuz6WvoCSuruz3DZ0Hn3oizbx+9ptDmcKwwY1F7tOF/YE
 W
X-Google-Smtp-Source: AGHT+IHgIaq6v7s1Hel2par6K/zWw20Y4zGQ1YEdf6pOZ5puaEnlaN/yqqE4EINtaAAgIuJ7fhBWOQ==
X-Received: by 2002:a05:6a20:429f:b0:1a1:461a:3a04 with SMTP id
 o31-20020a056a20429f00b001a1461a3a04mr397633pzj.8.1709334636656; 
 Fri, 01 Mar 2024 15:10:36 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 50/60] target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64
 user-only
Date: Fri,  1 Mar 2024 13:06:09 -1000
Message-Id: <20240301230619.661008-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Since aarch64 binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-31-richard.henderson@linaro.org>
---
 target/arm/cpu-param.h |  6 ++++-
 target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index f9b462a98f..da3243ab21 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -19,9 +19,13 @@
 #endif
 
 #ifdef CONFIG_USER_ONLY
-#define TARGET_PAGE_BITS 12
 # ifdef TARGET_AARCH64
 #  define TARGET_TAGGED_ADDRESSES
+/* Allow user-only to vary page size from 4k */
+#  define TARGET_PAGE_BITS_VARY
+#  define TARGET_PAGE_BITS_MIN  12
+# else
+#  define TARGET_PAGE_BITS 12
 # endif
 #else
 /*
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b2ea5d6513..f3ed79cef2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1809,7 +1809,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
-    int pagebits;
     Error *local_err = NULL;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -2100,28 +2099,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
            !cpu_isar_feature(aa32_vfp_simd, cpu) ||
            !arm_feature(env, ARM_FEATURE_XSCALE));
 
-    if (arm_feature(env, ARM_FEATURE_V7) &&
-        !arm_feature(env, ARM_FEATURE_M) &&
-        !arm_feature(env, ARM_FEATURE_PMSA)) {
-        /* v7VMSA drops support for the old ARMv5 tiny pages, so we
-         * can use 4K pages.
-         */
-        pagebits = 12;
-    } else {
-        /* For CPUs which might have tiny 1K pages, or which have an
-         * MPU and might have small region sizes, stick with 1K pages.
-         */
-        pagebits = 10;
-    }
-    if (!set_preferred_target_page_bits(pagebits)) {
-        /* This can only ever happen for hotplugging a CPU, or if
-         * the board code incorrectly creates a CPU which it has
-         * promised via minimum_page_size that it will not.
-         */
-        error_setg(errp, "This CPU requires a smaller page size than the "
-                   "system is using");
-        return;
+#ifndef CONFIG_USER_ONLY
+    {
+        int pagebits;
+        if (arm_feature(env, ARM_FEATURE_V7) &&
+            !arm_feature(env, ARM_FEATURE_M) &&
+            !arm_feature(env, ARM_FEATURE_PMSA)) {
+            /*
+             * v7VMSA drops support for the old ARMv5 tiny pages,
+             * so we can use 4K pages.
+             */
+            pagebits = 12;
+        } else {
+            /*
+             * For CPUs which might have tiny 1K pages, or which have an
+             * MPU and might have small region sizes, stick with 1K pages.
+             */
+            pagebits = 10;
+        }
+        if (!set_preferred_target_page_bits(pagebits)) {
+            /*
+             * This can only ever happen for hotplugging a CPU, or if
+             * the board code incorrectly creates a CPU which it has
+             * promised via minimum_page_size that it will not.
+             */
+            error_setg(errp, "This CPU requires a smaller page size "
+                       "than the system is using");
+            return;
+        }
     }
+#endif
 
     /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will override it.
      * We don't support setting cluster ID ([16..23]) (known as Aff2
-- 
2.34.1


