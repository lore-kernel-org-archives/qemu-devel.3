Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA0FC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjv-0002qU-Oh; Sat, 02 Mar 2024 00:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjt-0002bz-6i
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:49 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjr-0007a0-J9
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:48 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so2145160b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356606; x=1709961406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3J4u4o+ZiZhoYzI/EAUQNnJq1yCqdu7R1cfUSbRF4M=;
 b=Wo3Pb39kJjqUvK+hwOOPmAGu76J5R+pT+TwiUr4/Uw+KXZ6q8dn21FYnNCPSPdgucl
 xGWjaeEo59X6HYnzaA1QFCP3J/iL3Uyb5+O+B5mVhc4M4FwcDAde25l97QgAULlKbXiT
 VrSh7YjDUr5b7fn6WHhrXl2tBwR35NE+7CUu3PV1Efg0RNNEbsJQ/Mo4NqW1blMCrmpX
 aHxWVUBuBJSmz5j6BtIQhttwzOUStZ26TSfqCeDr0Niz4KtoMQb9soMOa4BBSFpXdhgW
 FoQp4XkNlr+8J3KCEO+APw11pJ/eOtyLAxD8AxFnBRt1z0fIdDdYbIYvjG79krnIlIgF
 R3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356606; x=1709961406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3J4u4o+ZiZhoYzI/EAUQNnJq1yCqdu7R1cfUSbRF4M=;
 b=lp52jnpd9RwAkBSrkBXqaXXnHtGDkgLsrUX5er2eZ+R+DMHfb4dQ5RQBdbv1VFEdmX
 zs9AUm63MlmUkcdfI9dHAePsq4/A3X1LJpVA/Na0R0npdcJ6dfIorKHFmexS02xVyLXc
 SIfo6x9qSi2sHrHiJrFO3ZHGq0KfzMP0MLx0xM2ct6p2YBnjyA84WJuQmWZNBczEdRQ4
 La6H5ELO5c0dKxXWsOH+C1DeqGgJgkpGICFE7W3dMvTtn+nglxrwoGbd+p0r99Z7lqYL
 MygUZx5IXStX22egwP94mzwBwonYWGbVc5Hl652b4PXIOlNkwbZF1Rs8i5iotPHpIYiS
 zKhA==
X-Gm-Message-State: AOJu0YwsrXPrWJgWaSALxmGAfoBhsHx3UD5IA384tmJ0ShMLbxdP4jTQ
 d1BvwJ+w8vfSDq6lExABtEKbMQ8MDHaSq8CsZAiBghhiAMckPD76BnOmGCpqZdXlaYV69T8IFPS
 p
X-Google-Smtp-Source: AGHT+IEW+6RcoNYXgc4jL8CgASHpiLzP59xeD8BrZVTP6UTqefl02AB1nrJ8AlkVZzoQtwBSgD+v0w==
X-Received: by 2002:a05:6a20:3955:b0:1a0:d956:5590 with SMTP id
 r21-20020a056a20395500b001a0d9565590mr4472195pzg.20.1709356606408; 
 Fri, 01 Mar 2024 21:16:46 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 25/41] target/sparc: Implement LDXEFSR
Date: Fri,  1 Mar 2024 19:15:45 -1000
Message-Id: <20240302051601.53649-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  1 +
 target/sparc/fop_helper.c |  6 ++++++
 target/sparc/translate.c  | 11 +++++++++--
 target/sparc/insns.decode |  1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 331acbe8d0..56daf2ad01 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -37,6 +37,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
+DEF_HELPER_FLAGS_2(set_fsr_nofcc, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(set_fsr_nofcc_noftt, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_WG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_WG, f64, env, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 8c07442ad6..a483d69ab7 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -570,3 +570,9 @@ void helper_set_fsr_nofcc_noftt(CPUSPARCState *env, uint32_t fsr)
     env->fsr_cexc_ftt |= fsr & FSR_CEXC_MASK;
     set_fsr_nonsplit(env, fsr);
 }
+
+void helper_set_fsr_nofcc(CPUSPARCState *env, uint32_t fsr)
+{
+    env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
+    set_fsr_nonsplit(env, fsr);
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cab177190a..c26fd04598 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4454,7 +4454,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     return advance_pc(dc);
 }
 
-static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
+static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
 {
 #ifdef TARGET_SPARC64
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4479,13 +4479,20 @@ static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
     tcg_gen_extract_i32(cpu_fcc[2], hi, FSR_FCC2_SHIFT - 32, 2);
     tcg_gen_extract_i32(cpu_fcc[3], hi, FSR_FCC3_SHIFT - 32, 2);
 
-    gen_helper_set_fsr_nofcc_noftt(tcg_env, lo);
+    if (entire) {
+        gen_helper_set_fsr_nofcc(tcg_env, lo);
+    } else {
+        gen_helper_set_fsr_nofcc_noftt(tcg_env, lo);
+    }
     return advance_pc(dc);
 #else
     return false;
 #endif
 }
 
+TRANS(LDXFSR, 64, do_ldxfsr, a, false)
+TRANS(LDXEFSR, VIS3B, do_ldxfsr, a, true)
+
 static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 67591b7df9..353d26b9e6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -589,6 +589,7 @@ STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 LDF         11 ..... 100000 ..... . .............          @r_r_ri_na
 LDFSR       11 00000 100001 ..... . .............          @n_r_ri
 LDXFSR      11 00001 100001 ..... . .............          @n_r_ri
+LDXEFSR     11 00011 100001 ..... . .............          @n_r_ri
 LDQF        11 ..... 100010 ..... . .............          @q_r_ri_na
 LDDF        11 ..... 100011 ..... . .............          @d_r_ri_na
 
-- 
2.34.1


