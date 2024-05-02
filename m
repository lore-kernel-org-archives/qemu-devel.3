Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C183C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFP-00007P-TM; Thu, 02 May 2024 01:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFG-0008PC-05
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:38 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF9-0002eW-6y
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:37 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5aa400b917dso4782029eaf.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628670; x=1715233470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0uU+3DiiRkX+l1IEg6+O7xl3/GxGb8nOcs90DZy+eQ=;
 b=unmP5LXa4xo9zpN11+vnApfjcSgtWwnQrst+TC6ynGn0A8qMR5nJOAW+RRWzHSeCZQ
 RrZpaG2i7F7gA+Hn+Y5rBLfRvEo6ib2aT2xNqhZDr29eamCGMW6pWuA1vHsq/0LKxOim
 t8UrWRJhrnDc/5Mg90IALUpzZB6zBsm6gk8QSZKCtmAVeFR7a/fNOiFUHBmOBBEZZJn4
 H4OdQbFhoAo0WjBSapcQb4HqyueAK5K/R1dSc/3rbpRZEVkkg7pWITuC/GpyWkfAPm9s
 letCGzzIxMqcwUs+D/5lhqegMz2S9lzgR48wlYsSIvAI1XXGaa2HZSa4O/oNjJhqcfhq
 XGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628670; x=1715233470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0uU+3DiiRkX+l1IEg6+O7xl3/GxGb8nOcs90DZy+eQ=;
 b=UWEjwx5uS/HlDrcb6c1XievtMtkrcI3ihJu5bNaC9x9aHBM+h9yLUONlN+10yGVBQk
 /9TAvCfguY2HSlqpV1+aTzg/Om7DgkWG9YcEXCeukcS0wUxAkx8J2GqEjGSqle1LBsLN
 pa0kLJog/+421VdQQ2U8e6xrikbLel+f1M+gCCjD9t86iwu6+TIQlIB/BgH8x/86xGzj
 ygaSfCVlHq8hYtCm9xGpWHS3k5x0XK/bIuqJ59lpjoAWRmFeL5dyB1p0sHAPFBLjKUUI
 +g9oEQFM/QHY5kzEx/DNptSfDhU/r4nwKeU5SENlkZPXQFibHe/g4wE4okaWI2z2kpAl
 w8qg==
X-Gm-Message-State: AOJu0YxDcHqgCjOVwmrMQVFyF11gTpq1tBezE+y3D2toCOIhA91/wJCN
 +JiueHwEqgzvOOgB23ldrPbFbaEu3JZOR4i8GIyrpWy18kWgw0pWJjMcjTTwrGL3w5WcDJbkbJe
 w
X-Google-Smtp-Source: AGHT+IHp+7NApASYZUlD5c+NQ4bgVHguN8lxpbaIjA8FdIwTJaw/DE5renkiCbOPwmqi8WHr6e+tzg==
X-Received: by 2002:a05:6358:224a:b0:18a:62fd:b874 with SMTP id
 i10-20020a056358224a00b0018a62fdb874mr1709743rwc.17.1714628669866; 
 Wed, 01 May 2024 22:44:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 10/14] target/s390x: Raise exception from per_store_real
Date: Wed,  1 May 2024 22:44:13 -0700
Message-Id: <20240502054417.234340-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

At this point the instruction is complete and there's nothing
left to do but raise the exception.  With this change we need
not make two helper calls for this event.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h          | 2 +-
 target/s390x/tcg/misc_helper.c | 4 +++-
 target/s390x/tcg/translate.c   | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 061b379065..5611155ba1 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -362,7 +362,7 @@ DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
-DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(per_store_real, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_2(xsch, void, env, i64)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 5b1c512367..5f1efc6a32 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -660,11 +660,13 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
     }
 }
 
-void HELPER(per_store_real)(CPUS390XState *env)
+void HELPER(per_store_real)(CPUS390XState *env, uint32_t ilen)
 {
     /* PSW is saved just before calling the helper.  */
     env->per_address = env->psw.addr;
+    env->int_pgm_ilen = ilen;
     env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
+    per_raise_exception_log(env);
 }
 #endif
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4a6ef144b7..041857e720 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4344,8 +4344,10 @@ static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
     tcg_gen_qemu_st_tl(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
 
     if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
+        update_cc_op(s);
         update_psw_addr(s);
-        gen_helper_per_store_real(tcg_env);
+        gen_helper_per_store_real(tcg_env, tcg_constant_i32(s->ilen));
+        return DISAS_NORETURN;
     }
     return DISAS_NEXT;
 }
@@ -6357,8 +6359,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & (FLAG_MASK_PER_STORE_REAL |
-                             FLAG_MASK_PER_IFETCH)) {
+    if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
         TCGv_i64 next_pc = psw_addr;
 
         if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-- 
2.34.1


