Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3384BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ls-00089s-0X; Thu, 25 Jul 2024 19:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lj-0007AX-Gr; Thu, 25 Jul 2024 19:58:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lh-0001X7-Oj; Thu, 25 Jul 2024 19:58:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7a0c6ab3354so359539a12.0; 
 Thu, 25 Jul 2024 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951896; x=1722556696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X3FsJ02xLaACuboI7a4PZGJHAR59UJfBjdSV3wDRKg=;
 b=JyXB8SEa19u03TK+wKkoldLEA4xh2Ncl0JvyFjMs2zOejedYD46FjgNbMAx/AYa5Oz
 tmTZVr6+XuOFgGZcPdnY7tApeYzOy0fKn5sbTnSYGV+Hp5nEV5Moy3Ct/tY797t5BCcx
 1fW2QBzNPwjr8S3iJWOXxSrSPRmXOSu5iQTvwtLXil7fXAR7MBmma4VSvV5TKuKAHlh9
 SmG2LXbjRIQbQhZ1vHwXxkfu1+aVCgumGSiGxulsvczvpyrPwYzYNnGVluryMN5/1VOG
 kLEZO3MmtZX6WafH0cwPTKR29CTGfAHmmMdFQmyJoRDluu1VJvMKzL8m/3NpO7Msbxqm
 ywEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951896; x=1722556696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9X3FsJ02xLaACuboI7a4PZGJHAR59UJfBjdSV3wDRKg=;
 b=iEtpx2K+VUQ/FdclTVuY+tG5lBVBk/xrT64KF8ZpFkk9MEEnQNp6sh+WKw4rzfyIu1
 ccnubheemjCsrqRLImiliIjSptNWhEtxfC6yIX2r7SshCuRLEZW3vyzfXWcSGStny3Io
 uoQXKeQKs0eeJVSxVxdwl4qFZsM0i3EEUwlVpK8K8HtNMBrN7ZYJ/9V9C5Q0HRQZ69TB
 xQx738NjII3+lEvbp9FZzGQ+qf1uvciTuBLF98I0Im3GVX0hwnl7SwH9s4JVz0yOeNbI
 Z7YY0FYXDHGUaL2wFSZaGwfnItMlm5WrP3oAoVWcBR9muRWOZpELG/mpMKmgFExOzD36
 sEXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK8TVkujspaeytQ4lmqrH+26XrDG4ZbVdJ86OIFV/S1NT7T6peeuK/Of/uI5f/nG2yZ/Adj2gGzlvvcv0Q5swl84b1
X-Gm-Message-State: AOJu0YwKGzi/NkapHuMz4YaGo1MfGWfuvj8UCKr2yrGITg+vIFi95DfL
 Lt0srtbkCwz8dMyw4ux0DxF3ftltpZ6K4wWPtXMUjXkHM5F1j6f9AOjlwA==
X-Google-Smtp-Source: AGHT+IGPu28tAwgrMZ/kCyoViW6sHBxl/1FAUzcco9OYlLSGRotlXXxH0+n/1Ft42SKoB1h3+iHGgQ==
X-Received: by 2002:a17:90b:3a82:b0:2c9:be63:b641 with SMTP id
 98e67ed59e1d1-2cf2ea1918fmr4273542a91.24.1721951895656; 
 Thu, 25 Jul 2024 16:58:15 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 64/96] target/ppc : Update VSX storage access insns to use
 tcg_gen_qemu _ld/st_i128.
Date: Fri, 26 Jul 2024 09:53:37 +1000
Message-ID: <20240725235410.451624-65-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Chinmay Rath <rathc@linux.ibm.com>

Updated many VSX instructions to use tcg_gen_qemu_ld/st_i128, instead of using
tcg_gen_qemu_ld/st_i64 consecutively.
Introduced functions {get,set}_vsr_full to facilitate the above & for future use.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 74 +++++++++++++----------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 26ebf3fedf..40a87ddc4a 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -10,6 +10,16 @@ static inline void set_cpu_vsr(int n, TCGv_i64 src, bool high)
     tcg_gen_st_i64(src, tcg_env, vsr64_offset(n, high));
 }
 
+static inline void get_vsr_full(TCGv_i128 dst, int reg)
+{
+    tcg_gen_ld_i128(dst, tcg_env, vsr_full_offset(reg));
+}
+
+static inline void set_vsr_full(int reg, TCGv_i128 src)
+{
+    tcg_gen_st_i128(src, tcg_env, vsr_full_offset(reg));
+}
+
 static inline TCGv_ptr gen_vsr_ptr(int reg)
 {
     TCGv_ptr r = tcg_temp_new_ptr();
@@ -196,20 +206,17 @@ static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
 static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xth, xtl;
+    TCGv_i128 data;
 
     REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    xth = tcg_temp_new_i64();
-    xtl = tcg_temp_new_i64();
+    data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-    tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
-    tcg_gen_addi_tl(EA, EA, 8);
-    tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
-    set_cpu_vsr(a->rt, xth, true);
-    set_cpu_vsr(a->rt, xtl, false);
+    tcg_gen_qemu_ld_i128(data, EA, ctx->mem_idx,
+                         MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR);
+    set_vsr_full(a->rt, data);
     return true;
 }
 
@@ -385,20 +392,17 @@ static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
 static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh, xsl;
+    TCGv_i128 data;
 
     REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    xsh = tcg_temp_new_i64();
-    xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, a->rt, true);
-    get_cpu_vsr(xsl, a->rt, false);
+    data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-    tcg_gen_qemu_st_i64(xsh, EA, ctx->mem_idx, MO_BEUQ);
-    tcg_gen_addi_tl(EA, EA, 8);
-    tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
+    get_vsr_full(data, a->rt);
+    tcg_gen_qemu_st_i128(data, EA, ctx->mem_idx,
+                         MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR);
     return true;
 }
 
@@ -2175,13 +2179,13 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
                      int rt, bool store, bool paired)
 {
     TCGv ea;
-    TCGv_i64 xt;
+    TCGv_i128 data;
     MemOp mop;
     int rt1, rt2;
 
-    xt = tcg_temp_new_i64();
+    data = tcg_temp_new_i128();
 
-    mop = DEF_MEMOP(MO_UQ);
+    mop = DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR);
 
     gen_set_access_type(ctx, ACCESS_INT);
     ea = do_ea_calc(ctx, ra, displ);
@@ -2195,32 +2199,20 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
     }
 
     if (store) {
-        get_cpu_vsr(xt, rt1, !ctx->le_mode);
-        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
-        gen_addr_add(ctx, ea, ea, 8);
-        get_cpu_vsr(xt, rt1, ctx->le_mode);
-        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
+        get_vsr_full(data, rt1);
+        tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
         if (paired) {
-            gen_addr_add(ctx, ea, ea, 8);
-            get_cpu_vsr(xt, rt2, !ctx->le_mode);
-            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
-            gen_addr_add(ctx, ea, ea, 8);
-            get_cpu_vsr(xt, rt2, ctx->le_mode);
-            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
+            gen_addr_add(ctx, ea, ea, 16);
+            get_vsr_full(data, rt2);
+            tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
         }
     } else {
-        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-        set_cpu_vsr(rt1, xt, !ctx->le_mode);
-        gen_addr_add(ctx, ea, ea, 8);
-        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-        set_cpu_vsr(rt1, xt, ctx->le_mode);
+        tcg_gen_qemu_ld_i128(data, ea, ctx->mem_idx, mop);
+        set_vsr_full(rt1, data);
         if (paired) {
-            gen_addr_add(ctx, ea, ea, 8);
-            tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-            set_cpu_vsr(rt2, xt, !ctx->le_mode);
-            gen_addr_add(ctx, ea, ea, 8);
-            tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-            set_cpu_vsr(rt2, xt, ctx->le_mode);
+            gen_addr_add(ctx, ea, ea, 16);
+            tcg_gen_qemu_ld_i128(data, ea, ctx->mem_idx, mop);
+            set_vsr_full(rt2, data);
         }
     }
     return true;
-- 
2.45.2


