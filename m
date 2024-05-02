Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5F4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Zir-00017X-Fv; Thu, 02 May 2024 12:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zid-0000wr-I1
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zia-0005wC-D4
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so7387732b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668935; x=1715273735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qq22xznEO4fQ2ADySN036W1Iaw759n3OSnbVrtPpfGU=;
 b=ZaGVLQsYuCqKZjXEwtbFQUlyEDLD3hKf6MkjXqrjTkkxv1NlwANnz7WMQBOCOkEa9a
 uCk3I8WCvdVHhmUFP9Ng9myK4dSPs/6yZde2q5TBmufYvvOZiywoJ/PLOOCYxwu43jG1
 R7fiiI1mU7aBBz4MqVRj/gYa1NYvEIzROjmHMkc8Re6QseQ3/W3fVi+lvITPNUf4sCRB
 ynLo8gZAiH09QEbNe/IkMvWAp+wlhhSr+T8C7DZeYl4ZTSTVeM13Z13hFrLIZX/B8/NX
 AAPYQ2N34OyfXt7XRtyQlFCJlGuqmxt5crqy8hh3WCIkLlYVM27gyX3l519Q1fWRO6/Q
 Z2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668935; x=1715273735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qq22xznEO4fQ2ADySN036W1Iaw759n3OSnbVrtPpfGU=;
 b=wk5LftnFE+5rByVAj95xSVf4qJWVV8Yqs4GgWONeqf/GtDa8ByTiC15h/aIwHQZ3fj
 ABYyzB+hHQOAebptKFj4B9rllOWOHPPnTEJ3PW9b7zusONKWYjU/QnY5kP7SrjXG2iYx
 6tS4n8j4K8zj9ok/HTnEtVt7gFXY7XqJii3N3uz2HvfhahemPdFLrFdY2x74LM+DHSZy
 toSUm7fR3q1KR3ff4d8sn96r4G2QOcpwnG0LHpoaqM3V/NphoPjJSNxwcs4QEHclpsZI
 pG23nbg0ViEbmgskWjJ6rHaoVbrDOJVdzxjr9rEyaT+I2O/NhmuhbjVYkVQG3An/FiIN
 yBOQ==
X-Gm-Message-State: AOJu0Yx9HfYcmfC9FtZozWLU2p2z1PyARxibpMaPStFnVVk8cxXODEjX
 2MBIHcfxL+GyoCzHv77l4/c56spFNe1+x6miLCP/UJR5hmz9xOVUSH3Fi8RjWOHQklltjU9AZfo
 2
X-Google-Smtp-Source: AGHT+IGnU9nnJAglGEqbxIAMBlB3f+kKOKmaLSWMFOdp7D3ue7YWElLhpkl8llpQc9pLXvaWAWAh0w==
X-Received: by 2002:a05:6a00:464e:b0:6ec:db05:36c3 with SMTP id
 kp14-20020a056a00464e00b006ecdb0536c3mr165058pfb.4.1714668934821; 
 Thu, 02 May 2024 09:55:34 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 6/7] target/sparc: Fix FPMERGE
Date: Thu,  2 May 2024 09:55:27 -0700
Message-Id: <20240502165528.244004-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

This instruction has f32 inputs, which changes the decode
of the register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  2 +-
 target/sparc/vis_helper.c | 27 ++++++++++++++-------------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index fcb9c617b7..97fbf6f66c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -94,7 +94,7 @@ DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_WG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
-DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8a2894bb9f..99c6f3cc72 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4656,6 +4656,7 @@ TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
 TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
+TRANS(FPMERGE, VIS1, do_dff, a, gen_helper_fpmerge)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4696,7 +4697,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 61c61c7fea..14c665cad6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -74,22 +74,23 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
+uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
+    d.ll = 0;
 
-    /* Reverse calculation order to handle overlap */
-    d.VIS_B64(7) = s.VIS_B64(3);
-    d.VIS_B64(6) = d.VIS_B64(3);
-    d.VIS_B64(5) = s.VIS_B64(2);
-    d.VIS_B64(4) = d.VIS_B64(2);
-    d.VIS_B64(3) = s.VIS_B64(1);
-    d.VIS_B64(2) = d.VIS_B64(1);
-    d.VIS_B64(1) = s.VIS_B64(0);
-    /* d.VIS_B64(0) = d.VIS_B64(0); */
+    d.VIS_B64(7) = s1.VIS_B32(3);
+    d.VIS_B64(6) = s2.VIS_B32(3);
+    d.VIS_B64(5) = s1.VIS_B32(2);
+    d.VIS_B64(4) = s2.VIS_B32(2);
+    d.VIS_B64(3) = s1.VIS_B32(1);
+    d.VIS_B64(2) = s2.VIS_B32(1);
+    d.VIS_B64(1) = s1.VIS_B32(0);
+    d.VIS_B64(0) = s2.VIS_B32(0);
 
     return d.ll;
 }
-- 
2.34.1


