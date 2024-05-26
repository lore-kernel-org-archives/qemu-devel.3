Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B60C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm2-0008Va-UG; Sun, 26 May 2024 15:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlz-0008K7-BG
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlx-0007h0-DM
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso20630405ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752592; x=1717357392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9yuYs5gPe1MnBfUW016Au7c2/dj70+dfKpSeivnHWo=;
 b=Y4jki3U82u1Mi+dZfBoP3j+4Ygzisv4+uxujTk/ygU9RBa+qvffEf/sx39plexf5WJ
 Llrb3wbxNWCjQZST0sPSp7tNmi9oibwbJa59uwo66yp+w1h6ktXnCitHMYmQs2THUnsm
 pM3COJjzZ69OaPB3o2UCc2oYb18C/1OeV2aamPhsdd47bIlKS8gMc/RwWFeU3SJXvhXh
 lg2uWv8BD+CtOwypJh1rbKpHdcoan5wTsEN+sACYGKU8FZywtcCV6IiozIylnAXtJtk7
 jhICdyIhPycnCyu7jZSfBBlS9gKYu3LmMikdqIgFrN3WGbDxvXvPEcyOAv+x/53rB7b5
 V0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752592; x=1717357392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9yuYs5gPe1MnBfUW016Au7c2/dj70+dfKpSeivnHWo=;
 b=vVfEFWV0gp8tRLf7KEB2QESecsiBhA8HCghuE1E80nj5Z1zZ+uMYbmc8aU9U3Hz++Y
 r3Ut0URIxOgVjUp18npi0BWexFYvmUcPOhgZagStMNUJrKmbPinFGwUXfC8had8IxWiM
 HMqBk5BttPfJCw+KQCT2/f/4YiB/gvycd41pHGGwLbaNDwZwgrisbNF96DHwa/w0vSHA
 383qdcTMIw5iTwuF0/R/6QfCZML2a8FoD77yJWCRlakhGJmhV5xGD6AYqYYJbL7tp7Fo
 0sG22Q5dMG+XVaL3Srj09Ue0Y+0h0mjKIWH3SRrDeRpCZ6VE3ILQsbpymy5cd1SrUWRX
 tj5Q==
X-Gm-Message-State: AOJu0YyMH/srYwYB+d+WL5gVn8Zd8GpgpblbILIcz4er5Ub6FUg6kaje
 4K+6FT/ySW4BEs8VSaKHum8IPVPmm4/48GsFpKKUqv/g5epLsIqYxOK/YaeHMEL8Jt/Sb20s/aL
 x
X-Google-Smtp-Source: AGHT+IE0RH/HhrONTSr0cICOO8NxcWSJalykKqfniOVfI6TS9jWWptOHiqWUXZwqrDDwGcj9yjsxZQ==
X-Received: by 2002:a17:902:e2d3:b0:1f3:11a4:b67 with SMTP id
 d9443c01a7336-1f4494f1d00mr53772125ad.43.1716752592192; 
 Sun, 26 May 2024 12:43:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 21/37] target/sparc: Implement LDXEFSR
Date: Sun, 26 May 2024 12:42:38 -0700
Message-Id: <20240526194254.459395-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/fop_helper.c |  6 ++++++
 target/sparc/translate.c  | 11 +++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 219f0e04c7..4ae97866af 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -40,6 +40,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
+DEF_HELPER_FLAGS_2(set_fsr_nofcc, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(set_fsr_nofcc_noftt, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_WG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_WG, f64, env, f64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a5eefebfbc..fec055910e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -589,6 +589,7 @@ STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 LDF         11 ..... 100000 ..... . .............          @r_r_ri_na
 LDFSR       11 00000 100001 ..... . .............          @n_r_ri
 LDXFSR      11 00001 100001 ..... . .............          @n_r_ri
+LDXEFSR     11 00011 100001 ..... . .............          @n_r_ri
 LDQF        11 ..... 100010 ..... . .............          @q_r_ri_na
 LDDF        11 ..... 100011 ..... . .............          @d_r_ri_na
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 1b524c6d3c..0b30665b51 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -602,3 +602,9 @@ void helper_set_fsr_nofcc_noftt(CPUSPARCState *env, uint32_t fsr)
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
index ade9df3960..e3059f32bb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4458,7 +4458,7 @@ static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
     return advance_pc(dc);
 }
 
-static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
+static bool do_ldxfsr(DisasContext *dc, arg_r_r_ri *a, bool entire)
 {
 #ifdef TARGET_SPARC64
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4483,13 +4483,20 @@ static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
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
-- 
2.34.1


