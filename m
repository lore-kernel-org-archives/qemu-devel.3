Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0338DCA0EEA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeY-0004Ek-Ex; Thu, 14 Aug 2025 09:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdb-00036b-SH
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdS-0005JV-Qv
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e2e8bb2e5so1141682b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176686; x=1755781486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59Vc71z+OG5Nme1jDykZuPFaHV8e81GjVPog9V1N6Wc=;
 b=IbEF4zQ2oyZaH1rHPnknARG8Exk0b8h3PL+WFYKgRzNPebyvrHFVcFjnN4RDl7uikO
 /Tqx0Rd/dgguRvt31TzEUp8aZcmmYx6jFxRzrmqga3E8pP97RC6b2g0n3FwnDnYWtnLc
 mkbES6D//jMMi50os3M44ShtoEWGY7c0NpLM+5rCKHC15bXf47gR3GL/YUatSV2VE3Xb
 r9gRDmd0AffdLQhR3Yq4ICRADWx9FeFtB18K+j5wWKk6d3nZWsuJJT+Yl1cHowmOD2Sl
 b/kAumaVGtKrYEYfkXobRFPUvVMYowU5Kp19T5FMW+5DdCnqzioQQFCKIelz6ot3qpmx
 Xq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176686; x=1755781486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59Vc71z+OG5Nme1jDykZuPFaHV8e81GjVPog9V1N6Wc=;
 b=fiEcJhIc8KRiQVynJ7Voh3tssPK3qXQdh7OeEehEv4v5Tw60Hyl5FWkGGNOBzqFNnE
 q2SuLtZpEVGQbz6TzlCTGOkfRAcZgMYOEwfzOj+4pharUG7MTX30/NISVRP6X9zFM+TL
 t4nKaTOVUEly9zCSV2iuQCWdDgIf3I+mzmai3jTIG+atEEALEwwFZx3IJ8k2qoYqO87E
 N8ILYs6lsQ8pJreIZUyUzVx3VsgMzOEdGa0enLqvLLGpsgAdwynL3y7mwM68rUAEaFGE
 8UqHE9yh5ZQ01s1/nxfGQoUENDsohQQS/ioqX4qVzyFfFjtJTRfkpEVTOQiCNSG2PXH4
 GYIA==
X-Gm-Message-State: AOJu0YyxIZv2Q39f/Jhoqc7vFKhRCvDy/aOBtV3+aaYKKl8bviMZrvUD
 D9GcyLDAjE+blIeui4DPkHJb9wTF60K0lCCc4VPK4qMLznc7A0NdRBlgdXSxiPl9UfZxQ7E4wix
 Wq7FGqFk=
X-Gm-Gg: ASbGncstmmwl0LJ6qtvJuTSSTL8g+he4mIQC1QGbBynth6rDUHz0kUzfn9TmAR5PrKH
 bGNx8IWrf/7601OQ9Ddc5T0WR0s3zkn1e/PwaTtVPpINzHUI8pxNSmATCzQiPy030tbTpPqnEr1
 pH3pLuWKxHDe3e0cQTL46dDQQtxxnf5hRAKkTkH8Ue++I40sj39L5A5gn0/HmwPw/MmS+yT+1F8
 Vu/pN5cd7fkAQuLkEpKgkXzoFc6HLPt7T6ySjWfgCpzhjP+SnLJNafXWJU3LPEdmAMRkUbcrYZD
 Nq5cfzzTk56gVFwtvHXOTjTrasPs6H9NbFIC538HzcV2yzAfUN98sAvdhyEEvwmFW/4Mvrwg+V5
 AdKhaZDahT6LM/G8+L42XBp79eZBDbreGMzTu8s0qx4dzt5o=
X-Google-Smtp-Source: AGHT+IGp+FSadv6GDyINa3dqUz8Rs7SnfusM8+9mAxsoENsax8IJT7xkA+1CWe6ZxnViVlmMkk7uPw==
X-Received: by 2002:a05:6a20:7d8b:b0:233:f0c6:a8a4 with SMTP id
 adf61e73a8af0-240bd28673dmr5282846637.31.1755176686518; 
 Thu, 14 Aug 2025 06:04:46 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 68/85] target/arm: Add gcs record for BLR with PAuth
Date: Thu, 14 Aug 2025 22:57:35 +1000
Message-ID: <20250814125752.164107-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 62cc565229..3a25a24047 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1842,20 +1842,20 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
 
 static bool trans_BLRAZ(DisasContext *s, arg_braz *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
-
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     gen_a64_set_pc(s, dst);
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
@@ -1892,19 +1892,20 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
 
 static bool trans_BLRA(DisasContext *s, arg_bra *a)
 {
-    TCGv_i64 dst, lr;
+    TCGv_i64 dst, link;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+
+    link = tcg_temp_new_i64();
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     gen_a64_set_pc(s, dst);
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
-- 
2.43.0


