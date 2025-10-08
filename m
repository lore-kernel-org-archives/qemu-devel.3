Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083F3CCD187
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCN-0008FH-RP; Wed, 08 Oct 2025 17:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCL-0007uL-1S
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:59:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCH-0007M4-BQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:59:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so333331b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960782; x=1760565582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZunbW8zrXRCzDcEAaVX1Pev0CRMsCYpGOAhWGA2DZnI=;
 b=hrdA4pGpnKyHtliXzmrigJ9et6oxQwvFXKX0NnmKcaniUFb5IgQiZG6rhl/ddhqyNj
 SU9pRd6NQ1PTxhJmmr5fLVaA1yb5nSVL4Rm8NBa5xOKb3jshUeKCxncw2nf+e7OCa5BQ
 QqxHqYFKxgzNM3vghu0Wz62Vvq0/wY3WTPIIbSuG6Na3csMlLszBeDICTMymZJE76s28
 F6+H1Qw7aTGuz9IOVYSWwbl0+8v5+segE2YeMIZgREz5up8ym1vTX31ourqB/UD9I7GW
 5plbOpD+mp9GGSnIfOj/AbuhzxEz6U/DORXVls5LDuqGFdZuHOlAkVy49J+zvHFtPLMC
 kVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960782; x=1760565582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZunbW8zrXRCzDcEAaVX1Pev0CRMsCYpGOAhWGA2DZnI=;
 b=WgONK2mfMEl7ytHhqSfnewgfu0F92aYqvkvtRcRJXQCjrZ1tyHvCCiKEvzo3JReSrF
 mDIcWQbUUUMFQw0quBffaV2FEC8HOSG81s6Jgl+bwhCRxqd8dRMxE+3jABNaiDme/0vO
 sNVqUbnU5SzHY0wwozuU7CbnVqOGOUAUscHgLB32mM1gB+Va7wryX6Ti/vgNrAuDHyRR
 QPDPdTg9d+lIv5uwmO4XIoH4vY6rjw+Xg+CQpE/LAMEEx+zHBcXCz3KZoNPtEatbk2iu
 odITRN+z0jDGQ0blSKmYmP3LenKTuGjGDZpLVEnu6E+8fuomTT6W4QCCuLgnf0S7EvKv
 NZkg==
X-Gm-Message-State: AOJu0YwTzrASk2xUfkZt/M1XwsHX1bNB9/Kgfz5P+DW+XySCChV0yx2C
 +ENhwgiZQvJlGgFBaFXUpVsLeU2aYE7PVaq3wg5wXNLaeLRh4td6wwdLhLfrUafR20N758LXhgU
 q8wZXrz8=
X-Gm-Gg: ASbGncusimMy46zCziRHGfeDJhTRLHaIf0JeqyO1uYjs8wKsnZS0XMnKvyGJ9XaCUgb
 8OY9PaHgxfYWY5DBtJMCRZuCReGd0QcdZqcuJq6KB7v3TKcQVUZJQyWGI3gGaceTdAE41MO2SDs
 6gqwd6htF4894nGQqSwZQe9KRi1vpVrTwy2ypjSrcsAXj3R5sJOcPE8SdbuCogkgCPwuTz3Nro0
 MI+CAMR61jbrAUBvUYZ5uYaBEsTVKtKrx11yYM07KpuTofbOdl5BTIHjJ2rQBLOPXazS9JSJVrM
 ZXKGi124jnj3FmX5ZPnxNPcMPr4/WS2E+L/6VHin+pfeH+/IRexDkatPYtwj84ZPGklt9sPHsXi
 FilBWWpJKUEv7jm1lkQ8Wee4+cCuVIDZEd4ifyUangmwd06FlsyGbwAn7yTazEffKa9A=
X-Google-Smtp-Source: AGHT+IFN59dQieInBzNalgtp2BYJ/+3z7Tkgl3+fgj+Fd52eB3IuE9CFRdxhorA2sjvD9d2Rew3pjQ==
X-Received: by 2002:a05:6a00:a15:b0:76b:ecf2:7ece with SMTP id
 d2e1a72fcca58-79231df6680mr9457172b3a.12.1759960782075; 
 Wed, 08 Oct 2025 14:59:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 42/73] target/arm: Split {full,core}_a64_user_mem_index
Date: Wed,  8 Oct 2025 14:55:42 -0700
Message-ID: <20251008215613.300150-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Separate get_a64_user_mem_index into two separate functions, one which
returns the full ARMMMUIdx and one which returns the core mmu_idx.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 43c9bfef93..1337e16a96 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -93,7 +93,7 @@ void a64_translate_init(void)
 }
 
 /*
- * Return the core mmu_idx to use for A64 load/store insns which
+ * Return the full arm mmu_idx to use for A64 load/store insns which
  * have a "unprivileged load/store" variant. Those insns access
  * EL0 if executed from an EL which has control over EL0 (usually
  * EL1) but behave like normal loads and stores if executed from
@@ -103,7 +103,7 @@ void a64_translate_init(void)
  *           normal encoding (in which case we will return the same
  *           thing as get_mem_index().
  */
-static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
+static ARMMMUIdx full_a64_user_mem_index(DisasContext *s, bool unpriv)
 {
     /*
      * If AccType_UNPRIV is not used, the insn uses AccType_NORMAL,
@@ -130,7 +130,13 @@ static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
             g_assert_not_reached();
         }
     }
-    return arm_to_core_mmu_idx(useridx);
+    return useridx;
+}
+
+/* Return the core mmu_idx per above. */
+static int core_a64_user_mem_index(DisasContext *s, bool unpriv)
+{
+    return arm_to_core_mmu_idx(full_a64_user_mem_index(s, unpriv));
 }
 
 static void set_btype_raw(int val)
@@ -3577,7 +3583,7 @@ static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
     if (!a->p) {
         tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_a64_user_mem_index(s, a->unpriv);
     *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
                                         a->w || a->rn != 31,
                                         mop, a->unpriv, memidx);
@@ -3598,7 +3604,7 @@ static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
@@ -3616,7 +3622,7 @@ static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
@@ -4514,7 +4520,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         return false;
     }
 
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_a64_user_mem_index(s, a->unpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
@@ -4568,8 +4574,8 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
         return false;
     }
 
-    rmemidx = get_a64_user_mem_index(s, runpriv);
-    wmemidx = get_a64_user_mem_index(s, wunpriv);
+    rmemidx = core_a64_user_mem_index(s, runpriv);
+    wmemidx = core_a64_user_mem_index(s, wunpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
-- 
2.43.0


