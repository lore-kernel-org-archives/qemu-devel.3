Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jMk-0000cZ-CM; Fri, 03 Oct 2025 13:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKy-0006Na-NM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK0-0007lx-Gf
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2134257b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511510; x=1760116310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/laVSNmqvynDQZVk+WnXdmOi04Sgp3zf/0AhbJe4L0c=;
 b=SttqXCwa8n1QdLqfaLPOOYlBhyucbRzVth1x3V1/Pxol8FJflL1EVCGln+yUIuIqnB
 CCne78Ffc/M9epQCUNkjTP35W7CqeNu/tcda6h3/pSLZ1Kx4Pxm48BRxXoqM1LyyGHSf
 RuU0ZhRlrjb2BxspEzW3X2PqW0t9FxKo+95ds/GIwUHQ5futUT94ytqOVDm12FivpVp0
 vq4JeLu3NkhjsHtij/DBAb1gqVLQr8BOKDqpaEj8mrkbbAwdtCAnacIjHCMvr9/SawJS
 VoCnz2SzfI1BrSkMB690753mAbkXbnBsJicKd9nS4rcWjw6uC7Co6/G37ugmk/PonnV0
 x5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511510; x=1760116310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/laVSNmqvynDQZVk+WnXdmOi04Sgp3zf/0AhbJe4L0c=;
 b=Qo+cWLarTZAHyW0Jn/jk+5lGOOIAZ5ZhOmLtUSZR5o/kQOF4jdvXyVbqyfflkagbDa
 /lQAINMKjG0CKhmRg7OOpW041rX/DPUYyT62S3otipM52ZGOJyQYVZVR2LCqX6iVLSjQ
 WexsKVEEKH052bSRGr4tcEw31S+RGyOWTsFYqmT+uTflf0L7fnZSziRbUh9OfsllgsH6
 SAe/oUYQv71EJ96tGfam7q6L/2hGQu7rw6knOgvijt7N0fivcd/E7+TWmDrgCsclkaQT
 PE70k+JSnW4rvdK2YDZBvxZJ4BVaE6Al54n3YEDc/4nhEHaRqN9VWb0PSXjONsFKnXKv
 /Zpg==
X-Gm-Message-State: AOJu0YybyqaNU/bvdm6GqGb6qrxMEU2OHAmU/qBwLFP/cKeyAeHSWvkG
 ArP1uVqhDv5PEo4BbTQ6COWpITr+hsf9qA1UH1eOQqUUZpb1LpIGmJg+DhBXqbOgXBon8uWJZ3M
 5DD6uRsU=
X-Gm-Gg: ASbGncvq1yWoXLyYL9niOGnE9eNLXm1wG1HKH0uMonm08He4pmp0YxaBvYFbrFGN1iK
 bCEZCHovbl6HxaDQTwpSnW9j7DD1OPGP1uPz4BJY7SpvPTVq4n09oc1MXf5u5dx8wrSTfEYPi15
 PkDSyQ52E4yy4KztpHfIp2GMq1deitAJTzw0cC2R41A/FyxZmGkC26x0xQFEwCGAaG/oRVo/iBX
 5Hznuv5DdEtHOfUTsPLRcKU9KGqRkw8eQo38zU8FhKp52oxODctAqEizQHJmrifqFvbUk6ibfgc
 Zxea+3xBkdE+o2sMfcitg45P0puhH4yHHJFWIMBvIZhUMZrsR8/HI4+mpxPSsYayYvzzwJdVONI
 sVRhH3pDVf0OvEjxETopPQj87Oc/Qf9MtjqCxeE7wfmgoYZkZsxA/f0PtA1QUAWxWIkQ=
X-Google-Smtp-Source: AGHT+IF80ykCYAaUZ3xRp+hUx5bDNoXL91yfoLoG3rmhZsVilxrslz0FVROCx7VX8SeUKqB1ipoCOA==
X-Received: by 2002:a05:6a00:178b:b0:772:6856:e663 with SMTP id
 d2e1a72fcca58-78c990b6868mr4560401b3a.8.1759511509976; 
 Fri, 03 Oct 2025 10:11:49 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 53/73] target/arm: Implement GCSSS1
Date: Fri,  3 Oct 2025 10:07:40 -0700
Message-ID: <20251003170800.997167-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 6d9145109f..e7e7050880 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -53,6 +53,7 @@ enum {
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
+    ARM_CP_GCSSS1                = 0x000d,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 3795bf7f36..eda5c498d7 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -129,6 +129,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
+      .access = PL0_W, .type = ARM_CP_GCSSS1 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d87133a3bc..b0831938ea 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2643,6 +2643,31 @@ static void gen_gcspopx(DisasContext *s)
     tcg_gen_addi_i64(gcspr, addr, 8);
 }
 
+static void gen_gcsss1(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 inptr = cpu_reg(s, rt);
+    TCGv_i64 cmp = tcg_temp_new_i64();
+    TCGv_i64 new = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS1, rt));
+
+    /* Compute the valid cap entry that the new stack must have. */
+    tcg_gen_deposit_i64(cmp, inptr, tcg_constant_i64(1), 0, 12);
+    /* Compute the in-progress cap entry for the old stack. */
+    tcg_gen_deposit_i64(new, gcspr, tcg_constant_i64(5), 0, 3);
+
+    /* Swap the valid cap the with the in-progress cap. */
+    tcg_gen_atomic_cmpxchg_i64(old, inptr, cmp, new, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, old, cmp, fail_label);
+
+    /* The new stack had a valid cap: change gcspr. */
+    tcg_gen_andi_i64(gcspr, inptr, ~7);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2984,6 +3009,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopx(s);
         }
         return;
+    case ARM_CP_GCSSS1:
+        if (s->gcs_en) {
+            gen_gcsss1(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


