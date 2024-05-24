Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37D0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEi-0006wQ-Os; Fri, 24 May 2024 19:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEe-0006re-1T
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEW-0005uq-MQ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b441b08so10590955ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592915; x=1717197715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbPodXVfNYDOBeFPuI23bmSPTaq8W6PthVSB/YmIGHc=;
 b=LIio8tpkFHmCFh/CZYa0aKC//FJdoSM70UeRA6MTM8m4lGmamNiNtKIwiM4yXZQj5a
 aCrtOkJkU3SdxoRpwKHBCaQbLnAsNQc+DwsvCG1oIdYELmnWGe/elH7lR2/aKGpkaq8t
 RhfVJPWPsqCj9lMgRdtvlXbdTOim9wl2eSk2d0hEURdmRg6RTz5l/vA3D5M2eJLNOiMA
 Gp02IdYjg0bPEZq3B9B//WBIDvn5awAjtL1DkA5J0zU1hww88TBh765XmINrOl2wXJ8n
 zpZJZYfz2fiQ0CMAgQceVMdDEQLkS0lZYGftOz7k4f4+bigcc6goLoX5SBtawUL9eXxd
 Ik+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592915; x=1717197715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbPodXVfNYDOBeFPuI23bmSPTaq8W6PthVSB/YmIGHc=;
 b=A3ANFHpKv3OT7uVUT479vzxXR9E8nQhoXEL8uzZ2Luw7rDrFcfdgF5rbmIcQ97WwKJ
 ds0vAWlRIMCN8AdX4rmnwcAU8yO373+PwIPkLT6uX8iwJtViKYAR4LvCxVqJGeSkxmUl
 N/7Z2uMOx7YOmvLP7e2JF69BPceC/eTR2ghzY+O6d465mhYP6UWc2Pw/xjQJf2MZcmcd
 euLyiNqNYJC3Lu4d5oAXr+s1CWKKPITVqRTorXuVs0DRWLr0uqRsSWWKR5c6WScZRMe4
 /UWos622oPmytYMvVYbHNn2e93SsHtu60fpoUDFoCozAnBK13sNeMSM/BAB4bXQMY0Oo
 GN8g==
X-Gm-Message-State: AOJu0YxV/xGh2lnx++pn4gWAme/nF+1ncoXyLgcNLLJoIJ+dRLc2LvlS
 Btgfan+GPfQR7rkjF4J2BoSS9a7GI36FuU93aTZIEcUH9770RTLPSk8qOXQrRBn2euJF8nBE9rw
 n
X-Google-Smtp-Source: AGHT+IF3SrQGjMcMJFjXNJOM5qCJNRZzuiW3xiuw55iZjSWRlYjpl04TrXMJLNoAZl0BgQWQ4xMCyw==
X-Received: by 2002:a17:902:f688:b0:1f3:704:8304 with SMTP id
 d9443c01a7336-1f4486e5ef5mr41421055ad.9.1716592915162; 
 Fri, 24 May 2024 16:21:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 37/67] target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
Date: Fri, 24 May 2024 16:20:51 -0700
Message-Id: <20240524232121.284515-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No need for a full comparison; xor produces non-zero bits
for QC just fine.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 22c9d17dce..bfe6885a01 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1217,21 +1217,21 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_add_vec(vece, x, a, b);
     tcg_gen_usadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+        INDEX_op_usadd_vec, INDEX_op_add_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_uqadd_vec,
@@ -1259,21 +1259,21 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_add_vec(vece, x, a, b);
     tcg_gen_ssadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+        INDEX_op_ssadd_vec, INDEX_op_add_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_sqadd_vec,
@@ -1301,21 +1301,21 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_sub_vec(vece, x, a, b);
     tcg_gen_ussub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+        INDEX_op_ussub_vec, INDEX_op_sub_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_uqsub_vec,
@@ -1343,21 +1343,21 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_sub_vec(vece, x, a, b);
     tcg_gen_sssub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+        INDEX_op_sssub_vec, INDEX_op_sub_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_sqsub_vec,
-- 
2.34.1


