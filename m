Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20BEC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJb-0000Zo-C4; Mon, 23 Jun 2025 21:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJZ-0000Yf-9O
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJW-0005nj-MW
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so3782104b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727945; x=1751332745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPRuJthFo3g6aUjTagI9t4QMkLmDirDDkkZ2ir5luhk=;
 b=GNXimdkhVk12Cv7FfkdVfWkz2qIH6KQNfuhpWNeMNhlj2ONhX9AN2Rwl5A7gOUDfhQ
 v4/og85Xy5L8GQOzgMLOFuD+hhQvc1QK1VNqqCpc57pR7YJaxeooecBrzjb9Inv6CU0v
 icrVFpueNMd4XnPWojiJ0mcSCeUoxcm7VfPC/dxTJnjiEkkbnqlBOTRgUwUydXGg+SEQ
 /tHFBv2bRRVLqYY8Qqc15e4DtQ1JwtfHcxtvikljSMFiyOdTdvxaJEfSGRQhR2GlnvH1
 076/+dVUxPZikq1DRByCSAvThN2ePJglf0+uGIm6TBJ7tOwRZNMHdWTQ4lP/iakSn4fy
 q1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727945; x=1751332745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPRuJthFo3g6aUjTagI9t4QMkLmDirDDkkZ2ir5luhk=;
 b=KcRt2Tm8O1XwmCU6Wh94ocRO/DFiuIUY4f13QE4DUzAc4h8GPg/br/ZFnZ3hylpDJw
 mRB0NQTteGjhZtAjfuSxkmdFBV1a1VwEcSWLzE0pkpu4Pcu65vpejqsbG4yAuQdM/hZC
 v/xrJMQQhRU2RcKWH+LBIk2GAZGZe2A36vAnafqwOJ4pPVMq5JjLhjk/xLysie5FzdBp
 6J/07zHV1dDZeSq9e6NXq63mbPchF/pQJFNO+CvknoAJSpN+KmUUPeLwPIHEp7oQtIs1
 nP9qtw3DjSNRS61WLSgEC0rU3b7Qgozq3dTIy2VwyJhTsdCciK5KPt5IB8KtUReDmPUF
 Gqew==
X-Gm-Message-State: AOJu0YyKWV4AIfwucsJjdilkEoFz+YlMI/11V/nI0bd2DmH/BP/3h7AU
 d0Ph4gFfzHINZNI7FuUCSUvRit/w78ev1YNnWi7aaT1gVKKFp7Rr34BxCWzD25kmsJor8p/uK9Z
 l/pyzOqQ=
X-Gm-Gg: ASbGncuVJ1ZYDdNM8zvhDhtCdpuAinn+VA4TmQpXA4GWBw4sQdRWGNM4IzvuMFfSWEL
 W74T8N+RTFwqowRcPyomaRPywCIy+M5pyCsaThHX62YGa/x1j12oWqyqi4Ju4Cd6CWzDwO2DP6u
 3+bB8QTieEJhTlw6IwzQL7Vb7qytZaDZtSHg32/3RIZNcInQU51F3+4GqQ8KNNl3Cv9Cbk26l4i
 61/z1KZmHOyJD6gUDZo659mJPxuQ7RMP9mmN+oG4uiR8OvM9nCLbE5GT5qSWsYu9PIBPU33BbX3
 01IO3d3XgzPjp6jwIeVjMxgmpLCf/BT60jgtbZlBylAoK+sHYBUV6Lm0tGS4/Y3cCFym0h6Nqwl
 IR4JvudxhByKkKqvcQJmcAjGv1mKp3sU=
X-Google-Smtp-Source: AGHT+IElPNI69gNd+q0TLSGlkW496bIr12321or8cUssNlCNJs/TDHZ95q/dzUHkEdnXWhpXlS+RdA==
X-Received: by 2002:a05:6a00:ccb:b0:736:34a2:8a23 with SMTP id
 d2e1a72fcca58-7490da6cc55mr18947314b3a.15.1750727945320; 
 Mon, 23 Jun 2025 18:19:05 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/11] tcg: Split out tcg_gen_gvec_mov_var
Date: Mon, 23 Jun 2025 18:18:55 -0700
Message-ID: <20250624011859.112010-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  4 ++++
 tcg/tcg-op-gvec.c                | 21 +++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 29bcedb737..b2e797780d 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -283,6 +283,10 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
 
 /* Expand a specific vector operation.  */
 
+void tcg_gen_gvec_mov_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 862cecf1bf..85e1807580 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1746,8 +1746,9 @@ static void vec_mov2(unsigned vece, TCGv_vec a, TCGv_vec b)
     tcg_gen_mov_vec(a, b);
 }
 
-void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz)
+void tcg_gen_gvec_mov_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                          TCGv_ptr abase, uint32_t aofs,
+                          uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen2 g = {
         .fni8 = tcg_gen_mov_i64,
@@ -1755,14 +1756,22 @@ void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fno = gen_helper_gvec_mov,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (dofs != aofs) {
-        tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
-    } else {
+
+    if (dofs == aofs && dbase == abase) {
         check_size_align(oprsz, maxsz, dofs);
         if (oprsz < maxsz) {
-            expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
+            expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
         }
+        return;
     }
+
+    tcg_gen_gvec_2_var(dbase, dofs, abase, aofs, oprsz, maxsz, &g);
+}
+
+void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_mov_var(vece, tcg_env, dofs, tcg_env, aofs, oprsz, maxsz);
 }
 
 void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
-- 
2.43.0


