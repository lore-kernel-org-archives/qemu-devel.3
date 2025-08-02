Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D6C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLpt-0001Fc-FA; Sat, 02 Aug 2025 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnG-0004Rx-MU
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:40 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnE-0005vx-Ec
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:37 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ff9b45aec2so1830276fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177854; x=1754782654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHjAyHFO49Xnsrf4XYBbOWKhIj7dGvot2d9bfnaFFuQ=;
 b=fsbsQFxQlCuTgx7ql4nXivXeEXhxnXXDgx6w4lTmIDXgG921JGeJSFwYa+UkDzjZsx
 6nri7E6zzalb9VhpftvYJ8fGW998es25jVyVQf4ynlStEGj+krC/pd67/6oRodEBwa0o
 ThS0WdxsVzrJo9roNVA9rCxwtKEjuIxCrxiD6XHMeyECLq3bkpgvFowyQgJPUXalAplk
 wCH3kcY5SpBxrzB5TJt35hWV0QKCD4YDpJBJS9PEZ6ZAyDPlhQSBNLDFwkV51drOh9k7
 O3H9Ft8SP59xjzlXS2GEz6m1Alx5fitmzE/qZ+ErzIr+7pmaKuA1yekvO+8nRK5SqXN1
 BV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177854; x=1754782654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHjAyHFO49Xnsrf4XYBbOWKhIj7dGvot2d9bfnaFFuQ=;
 b=Xlur2FIhp+ZAASMGivAdrYVhj3gzPn0Nql4mPijqrj8a30AGdiO4QIUSU3Pr4NgkE5
 I+o2zw3pLKZRwGot/tCFdZDj7uzHMWm4xxGMhE8epVEDCbyjFfiuqQK7ZfiAxtddPP2/
 v8isafuRu05i51VJSuR9W9LLiWMw2kQndveA2aSu4YPCNN/jP/32S44qwGztbN+hCtQc
 2B1EFbSrgwPmCWT96uGfQXphGVIbxDT0o0wcyoPewV2hrhmgR/kOYo6x49nD6h9tOIpd
 m7D9Ti0HkAguNZCWJwtbfKPAAG4/yXeu2KfxVuT7C0UYB50mbZ369RyadZNO7oLu6AW7
 oJnA==
X-Gm-Message-State: AOJu0Ywe+/Dplfboa6gGZwpi45WZBCZvyOLYnp1PQqrMXeimE0GRB0Rx
 TBbYmApwPSM/ebz7P8GbGLx1RmpKT+eIZ/3OZ5sZnKUocA6LLBU2RN1xdq+nldHMTTrxOjUXrEj
 S+yfDzyI=
X-Gm-Gg: ASbGnctyA/pRSLriPJeY3ct99vDCYZ91wKPYp/xgIhbVKUGMxBo2VxYCM6FT5GC6XXE
 MyJkIAsQRX4nMTbaqyc48MXB0tKSsIGvtKEFCPFH1MBZxfYdKingHf+CX18R9H6sRXElN3SBrok
 rBWTOQ2rEfkJA1QO1Xiry2WVDI76ojS1JK3o5vIYBcaKduroKxMVNvo8Lej9kgivkvY3FnmmxFz
 z1HAuWnHvVu9cfBP1B8BDkYkSekiiILtftQXyEExzmeosPOr5LUER7GWp/RsewOV940Ey+CxaNG
 Xj7jTZSZ9wD7cLROH3Z7QuC1kfdTivBpluJ240NZsdLeIQGnTpSXwV4gNJp/kSoedLRByrQSRwA
 6tuzf+mfbqQGNekIiTqWq4dF2v9M/rdchejF4CsOdqphdPVwW0TKR
X-Google-Smtp-Source: AGHT+IF6DdBYDKadFZwvjh9hfAMUww+WfpFdDzFVvLzL40PrhzE93bF0/DnfvmnJr2WZbf2weTYPcg==
X-Received: by 2002:a05:6870:e393:b0:2d4:ce45:6987 with SMTP id
 586e51a60fabf-30b67730912mr2401969fac.9.1754177854545; 
 Sat, 02 Aug 2025 16:37:34 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 57/85] target/arm: Implement GCSSTR, GCSSTTR
Date: Sun,  3 Aug 2025 09:29:25 +1000
Message-ID: <20250802232953.413294-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d803c10ac7..e0548f7180 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(arm_user_mem_index(s, unpriv));
 }
 
+/* For a given translation regime, return the core mmu_idx for gcs access. */
+static int core_gcs_mem_index(ARMMMUIdx armidx)
+{
+    return arm_to_core_mmu_idx(regime_to_gcs(armidx));
+}
+
 static void set_btype_raw(int val)
 {
     tcg_gen_st_i32(tcg_constant_i32(val), tcg_env,
@@ -3902,6 +3908,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
+static bool trans_GCSSTR(DisasContext *s, arg_GCSSTR *a)
+{
+    ARMMMUIdx armidx;
+
+    if (!dc_isar_feature(aa64_gcs, s)) {
+        return false;
+    }
+
+    /*
+     * The pseudocode for GCSSTTR is
+     *
+     *   effective_el = AArch64.IsUnprivAccessPriv() ? PSTATE.EL : EL0;
+     *   if (effective_el == PSTATE.EL) CheckGCSSTREnabled();
+     *
+     * We have cached the result of IsUnprivAccessPriv in DisasContext,
+     * but since we need the result of arm_user_mem_index anyway, use
+     * the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = arm_user_mem_index(s, a->unpriv);
+    if (armidx == s->mmu_idx && s->gcsstr_el != 0) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_gcs_gcsstr(a->rn, a->rt),
+                              s->gcsstr_el);
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_qemu_st_i64(cpu_reg(s, a->rt),
+                        clean_data_tbi(s, cpu_reg_sp(s, a->rn)),
+                        core_gcs_mem_index(armidx),
+                        finalize_memop(s, MO_64 | MO_ALIGN));
+    return true;
+}
+
 static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4315ed8dab..d034d96b37 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -554,6 +554,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
 
+# GCSSTR, GCSSTTR
+GCSSTR          11011001 000 11111 000 unpriv:1 11 rn:5 rt:5
+
 # Load/store multiple structures
 # The 4-bit opcode in [15:12] encodes repeat count and structure elements
 &ldst_mult      rm rn rt sz q p rpt selem
-- 
2.43.0


