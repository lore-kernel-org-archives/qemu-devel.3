Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC5DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFX-0000Aj-VN; Thu, 02 May 2024 01:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFK-0008Sa-9c
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:42 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFB-0002fO-UN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:42 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so5278734a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628672; x=1715233472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRpV+p3uN0SIcNVCCOcIP9JnG3tMdIXRYZSMJANZEE0=;
 b=dyyA/BIuz/CuMpKA6TaR3xQZOVLYsTLI1ghJGo5h96Z0uCFPhzaYKw+q9m5fWwhyy5
 OskKGTH2tdXzalCtK9MGaNnpt9e7AADny6J1wUj2xXKu7efBD8SeNoqqdogCwoF+ZFIh
 CLAADA+8YU/zzfUMTL3eAf7TSpqgweIIabLb0YIO8QfYrKw0JQg9a82fIvNmWKxM0kg1
 vC0ZFUGrmZU+UczSxes8JkfCgSroztrL8lQRHjfDq5Ewx78T2CcvA9qCqAXaovFoHuT7
 rmlmH7Hu1eDZWrPkQHZNDJqMZEo5t4ztw060BTXufn0LWcnWf8Mb4BCNjVhUedvthP2M
 1oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628672; x=1715233472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRpV+p3uN0SIcNVCCOcIP9JnG3tMdIXRYZSMJANZEE0=;
 b=SMYo0YqFkaQAIM5QKrhNeVuGW2xQymIDb6FUhFVWNWYbz52BIXDc9n2V5XSNZoAWGo
 +AIFZRzjRksq/+ExAuwWutWL6nfHHtyT9su+NGfAGzl7CtM70qBrepE0yLMzEBs/RR6U
 YPyZk4pHNUIVtWJhyGK/EEfbzDEYKtLYCxUvaUtS/oO4nNKxv9TxWdrG8PgtfBIQijHw
 0a/4cYhx5u9IzxWEY6a8u4VRLzF4UDnFlX1uBmodLZ+63CKL9KZiIXFV9FBMXFVqMPCh
 T/EhKg7R3Zq5bqWK9thaU+GGUqV5dfEPj+XwPN++eYkjLPozCYe8+5tlsTsMwFxUA2OF
 OgaQ==
X-Gm-Message-State: AOJu0Yy9Rr32c7X6oit/yiUfE7j4o2e1A8QcsDMf7qK9UfLR4nA7eQcu
 qwVRPTV6oAXNGz2q7c5p2QvtVNQ44CDbD4BAgHgg3tlbVOaiHyEifCZZnevE8sSiDULS9FbRCMO
 L
X-Google-Smtp-Source: AGHT+IHRmPDRlFfZAPLeBYXVERBGbaO65qFG3tD/29YSGhjHJhFU5uypgITKF6EMgcPMf++7NBTUlA==
X-Received: by 2002:a05:6a20:a124:b0:1af:4ea2:5424 with SMTP id
 q36-20020a056a20a12400b001af4ea25424mr5476462pzk.33.1714628671698; 
 Wed, 01 May 2024 22:44:31 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 12/14] target/s390x: Simplify per_ifetch, per_check_exception
Date: Wed,  1 May 2024 22:44:15 -0700
Message-Id: <20240502054417.234340-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Set per_address and ilen in per_ifetch; this is valid for
all PER exceptions and will last until the end of the
instruction.  Therefore we don't need to give the same
data to per_check_exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

# Conflicts:
#	target/s390x/tcg/misc_helper.c
---
 target/s390x/helper.h          |  4 ++--
 target/s390x/tcg/misc_helper.c | 23 +++++++++--------------
 target/s390x/tcg/translate.c   | 20 ++++++++++++--------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 31bd193322..1a8a76abb9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -359,9 +359,9 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_3(lra, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(per_check_exception, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_1(per_check_exception, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_WG, void, env, i64, i32)
-DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(per_store_real, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 5f1efc6a32..f5e674a26e 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -604,12 +604,10 @@ G_NORETURN static void per_raise_exception_log(CPUS390XState *env)
     per_raise_exception(env);
 }
 
-void HELPER(per_check_exception)(CPUS390XState *env, uint64_t next_pc,
-                                 uint32_t ilen)
+void HELPER(per_check_exception)(CPUS390XState *env)
 {
+    /* psw_addr, per_address and int_pgm_ilen are already set. */
     if (unlikely(env->per_perc_atmid)) {
-        env->psw.addr = next_pc;
-        env->int_pgm_ilen = ilen;
         per_raise_exception_log(env);
     }
 }
@@ -639,23 +637,20 @@ void HELPER(per_branch)(CPUS390XState *env, uint64_t dest, uint32_t ilen)
     per_raise_exception_log(env);
 }
 
-void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
+void HELPER(per_ifetch)(CPUS390XState *env, uint32_t ilen)
 {
-    if (get_per_in_range(env, addr)) {
-        env->per_address = addr;
+    if (get_per_in_range(env, env->psw.addr)) {
+        env->per_address = env->psw.addr;
+        env->int_pgm_ilen = ilen;
         env->per_perc_atmid = PER_CODE_EVENT_IFETCH | get_per_atmid(env);
 
         /* If the instruction has to be nullified, trigger the
            exception immediately. */
         if (env->cregs[9] & PER_CR9_EVENT_IFETCH_NULLIFICATION) {
-            CPUState *cs = env_cpu(env);
-
             env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
-            env->int_pgm_code = PGM_PER;
-            env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, addr));
-
-            cs->exception_index = EXCP_PGM;
-            cpu_loop_exit(cs);
+            qemu_log_mask(CPU_LOG_INT, "PER interrupt before %#" PRIx64 "\n",
+                          env->per_address);
+            per_raise_exception(env);
         }
     }
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 041857e720..7cf2920aec 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6260,8 +6260,8 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
-        TCGv_i64 addr = tcg_constant_i64(s->base.pc_next);
-        gen_helper_per_ifetch(tcg_env, addr);
+        /* With ifetch set, psw_addr and cc_op are always up-to-date. */
+        gen_helper_per_ifetch(tcg_env, tcg_constant_i32(s->ilen));
     }
 #endif
 
@@ -6360,14 +6360,18 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
 #ifndef CONFIG_USER_ONLY
     if (s->base.tb->flags & FLAG_MASK_PER_IFETCH) {
-        TCGv_i64 next_pc = psw_addr;
-
-        if (ret == DISAS_NEXT || ret == DISAS_TOO_MANY) {
-            next_pc = tcg_constant_i64(s->pc_tmp);
+        switch (ret) {
+        case DISAS_TOO_MANY:
+            s->base.is_jmp = DISAS_PC_CC_UPDATED;
+            /* fall through */
+        case DISAS_NEXT:
+            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+            break;
+        default:
+            break;
         }
         update_cc_op(s);
-        gen_helper_per_check_exception(tcg_env, next_pc,
-                                       tcg_constant_i32(s->ilen));
+        gen_helper_per_check_exception(tcg_env);
     }
 #endif
 
-- 
2.34.1


