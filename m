Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3TU-0002sz-Vn; Tue, 28 May 2024 16:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TL-0002o5-D4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TA-0003ZG-O1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6fcbd812b33so1132827b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928248; x=1717533048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bw2OR3avNdEp8SO81AHF6+sbRJu+jw044WvC2PSZAd8=;
 b=Z1B/BjVQrhnsBkN+1VdTuJoEf4Jna6F4+PtPvTW2ih6FInMPrAiKe6WxmlB3oSwOQS
 wOeUvXWsopRTb9apLyf0QZ/LxNiSSxy6XQgylhJz3/uMg02UMMmChkLxq1pkA1L10auz
 LhrvGmz5MYq4FmVO1iXOkrGqc1rZ7oUpUuWMdMvPQSPbF1KpWea20AHd1uaKTPYZRgZo
 se2ZjcrSbKWFtU12/XNMbC9dokikr/XsuugQ8Zit0vuFYRgyu7rgSEsnNU8P1g0c/bcg
 /Xoc5dNv6L+m8e7WZvKcpvu/z66+t8gMZ/TwbKJsPk3+4BySWL1MPThcHa59zQBpdYh/
 LQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928248; x=1717533048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bw2OR3avNdEp8SO81AHF6+sbRJu+jw044WvC2PSZAd8=;
 b=jGvwCLiBvE+hRwKb/oui8CMCjD5IBW/7C4C986LOgKEO1dFxmW5QEiqABxkstjy5IZ
 qB14AeyUnV9oIjRvPBuV9PuKF2nkF7S1vhR+eSIozbaoBtS2fxSslghhbh/FEK7djsHO
 ruoYEw9t2XgeCciMclY7rF2lDaENh4gHDNv4xXIWqrf/Z0CM77E+aGbYiwBe2hN66rqh
 43F24rZJRF9D/0oIorsIaUfm0UQ/tgC1d18heVbR/GrQok1dBu4wXZ/YADIPOpzWGVxI
 skgkPm1TQxKz1iumXlWfP3HPH5YuIDF5GcKD8pKdKvO8vOGldTMTe8J6bi/+20rzXIQn
 Kbnw==
X-Gm-Message-State: AOJu0YyEZ7Wxp6t3rqOezYMtNaKtkqxJrZb50ByAn765WKenud8TxQqb
 rC29s7i/X7mD2a49BvylRLrRJ8cb/UU90DEkURaK9tthiXSRi5VwnWRLw1Fgy5f+TFZRAt2yejj
 z
X-Google-Smtp-Source: AGHT+IFZL1IYJd8L6zItRboBj8kUQkCIiTfMlcEWNEPuFn5xpmoXi5Q3AuBtyAamz1zp+2W8XQ3GpA==
X-Received: by 2002:a05:6a00:39a2:b0:6f8:fe77:8a0a with SMTP id
 d2e1a72fcca58-6f8fe778b79mr13467121b3a.32.1716928247724; 
 Tue, 28 May 2024 13:30:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 02/33] target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
Date: Tue, 28 May 2024 13:30:13 -0700
Message-Id: <20240528203044.612851-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


