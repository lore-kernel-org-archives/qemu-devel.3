Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28925C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP2-0008Sc-GP; Sun, 04 May 2025 16:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOt-0008Nh-Gc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOq-0006x9-Ih
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso3366093a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392243; x=1746997043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIQELB2tRYMc57jWwkjeMWxsQZONjOqCuvRT3H/S0gQ=;
 b=GAZluYBCncTuczWvE4cR417NM6PCdrwlFl4Q4DRzu1w9PwzhzgzYniqJ65+2D2PbnY
 sE3BHBga0e4Z18GDsxK+xextGbzghbcGjnKt4lC8doe17n6VnxTOhotNNlSj0OvXFYwU
 bZK7BwrpbVFlo70kuMlv5EgnxLTJoo0vgVshnvOmN6zf55eiQXhCpyaBkzsR8P7SX9Nc
 0GQnNad+GNJNqGKOiL3taDAZ/CQHWXAcKeh3YyWkE9rWdMnEgSzTa+EJBTRAS/C7IuhH
 qF5R7yaWV5fH5Ur6jrlIvixuH0TzHurdnbcE+bIXDnNG/iOUY4esE4D1O2dGmL5C2Kjd
 0AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392243; x=1746997043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIQELB2tRYMc57jWwkjeMWxsQZONjOqCuvRT3H/S0gQ=;
 b=Wlw3NUSs2b1sYWlVT3BjUrLTSHjB/G1EhSDy3DSE+xqR9tgFhMRKoLF3zRW79QYIOK
 PELWTcktghHlXUmSIr4eqqvSVE4yrioedP9IFJRmOsz3o7mRccxfQofc9gXlBOD7XS9j
 yM0Ewy5Wu87OMSpkM9R9hj1AznPU18MqZIXYnvQfWDBjkP7L6TQrfNxHbH1vHt0ZGPp3
 g7Co2Q+pMxwKa1SZeJ8+KJYa0U/GMdIdX59RmVAL0XMRCVQ2+meCa/QtzPiEq3SbGBw8
 vp0Iqc0+rZoBwV/uztBEoJ0BvI5gd4hzEOkO5iyiX40y4vEOaecbZcVrOqikOCjLh+XC
 3H5A==
X-Gm-Message-State: AOJu0YxMaUJAmWxj0lVpTY7LDjHAjmf9Xt7BkYNGNbOE5q45bVDkpIdN
 KtuYFoPOmi8W0N4rU0tshIZJx0v3REl9DKpWZIMLktCcIebWL31+O3UYaih6Va//g6mlotMGf15
 o
X-Gm-Gg: ASbGnctT81ZJG1y9oKfFzNILGgQKssmj4zSLcQysih4K8qN6Q56sLCmPlsBci3dGdar
 vkywtDHPKnDEXV7Nbh/1uCaqNRpgEsUKb82ECFtRE8IxkCHJhdUpvZ8cQfVANBRpjUysmzoBuWx
 hiVaAA7iThZJr8rsMn2U3Z6zkw9U32f6OpS2KDh9O4v8Uw51gBpntf5526P4jSikLBKrk5peViT
 f2Pdkw9MaQCfcjvGm1hU0nu7G7NJ6y/kUlKKXBFn1xqBQXmPJiaWPnuKKKynw8XQMjoRS/PN/Hj
 xXI7F+6ohd0MtmEJi5iaM7dIUWZZbCt+dQgmVkZICZk6s68eSUs4WbUeyqE8vlTc2TSidqn9Jcs
 0FGYufk/eVg==
X-Google-Smtp-Source: AGHT+IGiSjkXytY1Cg6vGzsn2xbomthAKGNmZRcrP49T+TKpnUIiJFeqJTYknXQEL19xxMCfWdJS8Q==
X-Received: by 2002:a17:90b:578f:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-30a6174fda0mr9082464a91.0.1746392242797; 
 Sun, 04 May 2025 13:57:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 09/12] target/riscv: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:10 -0700
Message-ID: <20250504205714.3432096-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Check 32 vs 64-bit and pointer masking state.

Cc: qemu-riscv@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 55e00972b7..267186e5e3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -237,6 +237,31 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     env->excp_uw2 = data[2];
 }
 
+#ifndef CONFIG_USER_ONLY
+static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
+                                vaddr result, vaddr base)
+{
+    CPURISCVState *env = cpu_env(cs);
+    uint32_t pm_len;
+    bool pm_signext;
+
+    if (cpu_address_xl(env) == MXL_RV32) {
+        return (uint32_t)result;
+    }
+
+    pm_len = riscv_pm_get_pmlen(riscv_pm_get_pmm(env));
+    if (pm_len == 0) {
+        return result;
+    }
+
+    pm_signext = riscv_cpu_virt_mem_enabled(env);
+    if (pm_signext) {
+        return sextract64(result, 0, 64 - pm_len);
+    }
+    return extract64(result, 0, 64 - pm_len);
+}
+#endif
+
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
     .guest_default_memory_order = 0,
@@ -250,6 +275,7 @@ const TCGCPUOps riscv_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
+    .pointer_wrap = riscv_pointer_wrap,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


