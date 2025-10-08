Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13B6CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEg-00025G-Ff; Wed, 08 Oct 2025 18:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cD1-0000tZ-BX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCT-0007Oo-AG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so333411b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960793; x=1760565593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jt567D0J6a1P7ec8JzEIC8+N+AcWWszERl+qJiuYGNI=;
 b=o5oAd7Jx7qYm+xlu/bq3cz4hzWbDp00T65h3I/SxWe3fXa8p9Iu9VDp56Jn3VsYzqF
 ZtBJTHCZ8hbxa2kp3MTuacVGEA7d4bs+Wb5HcXF+TpRyuTS9IYEMXl49kjnDbrururBm
 3i8YzRyunvNJ8Yw5VFWSn72jVNNWqyG62gs4o7FfWD2KsOJQMktHPJN1FJAHhtH/TDry
 4oB1qbNVdel3D7/M26rM8KmcdEgxH3JbYnWee8eeB682addYM2wbvtOyLp8aghqMb0sZ
 qJjeclC/7nbO6CEo8mybKAA1beEPkNDQ9Z8SDVEhYuweNhASUYj3dGiSbubgVnzuz8eU
 KvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960793; x=1760565593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jt567D0J6a1P7ec8JzEIC8+N+AcWWszERl+qJiuYGNI=;
 b=pjhRRq3HGp/kJUXBdPGeWHPYHnKfpeeiWsElqRnmefU/oJ4pWVlycHaHxT/YBByUPu
 vHWMZWssixoOAMn5vb2tNRxJxDMppG2OcKVFxYxHn9YLPYGDE0xNIvRb+OUabOuNZicO
 +q2neQBjqwC0w1PywHnNUpaXBOrk8pLEOTz3kBxnvKH12YIDotC0K5dUlfdsFsNGJw/D
 sKiKlfSI8PzwypNxJiyJ2Jgvyn1GU+q/jtIPLMqleMvsqSp/UhGdOwjX3fBipOBgxYVl
 7B3YgoAl9kYzXXIizjzbGKc1Z5erCGG4lz0hHqXpuXUa487oVl0yTPegIJzO8V4t2X22
 FmOQ==
X-Gm-Message-State: AOJu0YyLrUunPp1ZfiX4l6M/KEqLhcugJ27+Zp+iPCHQSf9fISF7b/J6
 pVDMf3U8ecqWP1Yhl17piNJpOxTBUqEuJA2eGaZr1QtJsNwSjfXKZ6XMJEOZTZTyo4QFzpj/+oe
 OXT5YDIU=
X-Gm-Gg: ASbGncvxmn5eKLH2LSodehnEStE7vg2GdBApZG5TrYy7ifUZhuhYiy8mNyzML8K2UE/
 aVJzXHRiZIfmw28N3PvekffAMh8Tc/XfZzc0/IH1w7ze7EnJmZ3hqhzHeV9srM3y6e9EHl/WRsH
 Awx9rYewQoE2ENQll1D2sInWueGEhQgYKmibI16y2qD/CAYQLYgyRL5FSe9QVu3xWGJVnWl5dtl
 lDzCwQOgn7ENZwII7Fy2U6UpL9ypbURs2ULDU355zYHqsZP+3izRNUZsgM+kqYlggDRFCtgmTsL
 uy2fjRKBKCdtQyob0IkT2L8vm/Rsve70w7ajlhVelxg5DHhtBmfQ5Gx7fStktPMKnrJKq0uag2e
 z3XcBcEZHpwm5l/tmJJdSLYQmvSKPoEZB7h9pzly2WUUVW8114JCKlBoy
X-Google-Smtp-Source: AGHT+IESkJlkRiVtewu9TDkHa51POxdXEB3cTctGYjQLYPsLObzSYJ1bh0bwthtXchAhGlnR/j4dTA==
X-Received: by 2002:a05:6a00:3998:b0:770:4753:b984 with SMTP id
 d2e1a72fcca58-793998483b7mr5809070b3a.16.1759960792467; 
 Wed, 08 Oct 2025 14:59:52 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 58/73] target/arm: Load gcs record for RET
Date: Wed,  8 Oct 2025 14:55:58 -0700
Message-ID: <20251008215613.300150-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9c3de0cf71..dfd5b17831 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -444,6 +444,27 @@ static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
     tcg_gen_mov_i64(gcspr, addr);
 }
 
+static void gen_load_check_gcs_record(DisasContext *s, TCGv_i64 target,
+                                      GCSInstructionType it, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 rec_va = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(rec_va, clean_data_tbi(s, gcspr), mmuidx, mop);
+
+    if (s->gcs_rvcen) {
+        TCGLabel *fail_label =
+            delay_exception(s, EXCP_UDEF, syn_gcs_data_check(it, rt));
+
+        tcg_gen_brcond_i64(TCG_COND_NE, rec_va, target, fail_label);
+    }
+
+    gen_a64_set_pc(s, rec_va);
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -1798,7 +1819,13 @@ static bool trans_BLR(DisasContext *s, arg_r *a)
 
 static bool trans_RET(DisasContext *s, arg_r *a)
 {
-    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    TCGv_i64 target = cpu_reg(s, a->rn);
+
+    if (s->gcs_en) {
+        gen_load_check_gcs_record(s, target, GCS_IT_RET_nPauth, a->rn);
+    } else {
+        gen_a64_set_pc(s, target);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


