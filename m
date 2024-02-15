Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7F7C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafKa-000243-Gt; Thu, 15 Feb 2024 12:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rafKX-00023D-8a; Thu, 15 Feb 2024 12:15:25 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rafKV-0003fA-A2; Thu, 15 Feb 2024 12:15:24 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d911c2103aso7235655ad.0; 
 Thu, 15 Feb 2024 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708017320; x=1708622120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dh/kb4YIp6n7fig01Q43vy69CS878rHHhStr9zKIkxU=;
 b=m9Ti6yANoS1cZkMclybyZ2Fl1gzGsGT1jts5J8IAvb9dCUozUFHKyrXnzHlz/hImtY
 JzpMmdb3uqTeYCr0YY52adLMKhwodSM5vTmCz1ttIDnYWjYLAL/ckSHv7q0eb+PYMsT7
 gGKdYWjlJDYpR8dvDWri+STLeqz9Gi3kWNVncIY+3ogsKW80qWrS3lwXzOmko0TRoVa4
 zX3RmBV/x7KqTaiaYLbHJO7tjbRawD3fy3V4EQTl/HEaiGbk5vh8npnlk7Edv0Lpbb3K
 z54b0ufoEFrzT97WyDSvDXMDSuhrsbyIzLaFJuFBhO+fbaXdJhGYnITA8px5AoqD/LA+
 5IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708017320; x=1708622120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dh/kb4YIp6n7fig01Q43vy69CS878rHHhStr9zKIkxU=;
 b=HH/qtUZwHNlan8n7aD53Du5tOx+Av9smqCb7y13VvCMCt7jk9ZZdy+OFfwajWhtUOq
 HCFDxCz+oU/+O664oS8upWMxaT6UefjArqwogftfCP8OIsd+9xhYc2lb7oYG9/79T5s/
 VcCEOZEwjRTvHUtYr1ZGUZliYIcdVeue/yLNz2luFo7dsESS0lPFCeZBNNYU5ISLPXZz
 Pb3yzioESAWeG7X6Rh/WNHHn9fe8szKRZaSjNxKV+qwOqbEKuRrDS72cQMhG/nsluZdN
 MHcWKcSIYE0kKjcmnBNQlr2RMUwN00PaYNSSkVBPHoauoderNNntCPAQaB9YK6tZl7uA
 HA5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcAd+o4RmAFyq8+/ubceLhfRIYdJi2IjiA2sMIcsTzOIOOuwZq120xJoIcLeTs5if84nD3CEkPcOy4kkh1FBwGK0ycgHs=
X-Gm-Message-State: AOJu0Ywb8ftRfdBZPHk0xM+gDv1NWI04MkRm2r2jgeJcebsIEmTyRIkJ
 svdViNpSWbN00Uj1gUCOY8w7b+f1cvkVPj2NA3QWrvzjLjkV4EQ+lRvmyHIi
X-Google-Smtp-Source: AGHT+IE78rEe0r0nCiKBsZcn+w8b8KGSNK+Nx3tPb1gjhTih2iYR4jukeJZIbEyrM+8r/LAgtsMilQ==
X-Received: by 2002:a17:902:c3d2:b0:1d9:841d:2e3b with SMTP id
 j18-20020a170902c3d200b001d9841d2e3bmr2611497plj.21.1708017319481; 
 Thu, 15 Feb 2024 09:15:19 -0800 (PST)
Received: from wheely.local0.net (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902ee4600b001d9a40f50c4sm1494731plo.301.2024.02.15.09.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:15:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH] target/ppc: BHRB avoid using host pointer in translated code
Date: Fri, 16 Feb 2024 03:15:12 +1000
Message-ID: <20240215171512.800892-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Calculate the BHRB base from arithmetic on the tcg_env target ptr.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi Glenn,

I think I have to squash this into the BHRB series. 32-bit host
compile shows up a size mismatch warning... I think it's not quite
right to be using host pointer directly in target code. The change
of offset and mask to 32-bit is needed due to to seemingly missing
tl->ptr conversion helpers, but 32-bit is okay for those anyway.

Thanks,
Nick

 target/ppc/cpu.h       |  5 ++---
 target/ppc/cpu_init.c  |  1 -
 target/ppc/machine.c   |  2 +-
 target/ppc/translate.c | 45 +++++++++++++++++++++---------------------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index eaa24f2c95..6b050ea628 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1325,10 +1325,9 @@ struct CPUArchState {
 #ifdef TARGET_PPC64
     /* Branch History Rolling Buffer (BHRB) resources */
     target_ulong bhrb_num_entries;
-    target_ulong bhrb_base;
     target_ulong bhrb_filter;
-    target_ulong bhrb_offset;
-    target_ulong bhrb_offset_mask;
+    uint32_t bhrb_offset_mask;
+    uint32_t bhrb_offset;
     uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
 #endif
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 2494527765..262b1d7852 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6117,7 +6117,6 @@ static void bhrb_init_state(CPUPPCState *env, target_long num_entries_log2)
             num_entries_log2 = BHRB_MAX_NUM_ENTRIES_LOG2;
         }
         env->bhrb_num_entries = 1 << num_entries_log2;
-        env->bhrb_base = (target_long)&env->bhrb[0];
         env->bhrb_offset_mask = (env->bhrb_num_entries * sizeof(uint64_t)) - 1;
     }
 }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 731dd8df35..3541cd83cd 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -724,7 +724,7 @@ static const VMStateDescription vmstate_bhrb = {
     .minimum_version_id = 1,
     .needed = bhrb_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
+        VMSTATE_UINT32(env.bhrb_offset, PowerPCCPU),
         VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 81afc892de..05f0f1ac52 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4167,21 +4167,24 @@ static void gen_rvwinkle(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-static inline TCGv gen_write_bhrb(TCGv base, TCGv offset, TCGv mask, TCGv value)
+static TCGv_i32 gen_write_bhrb(TCGv_i32 offset, TCGv_i32 mask, TCGv_i64 value)
 {
-    TCGv tmp = tcg_temp_new();
+    TCGv_ptr ptr = tcg_temp_new_ptr();
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    /* add base and offset to get address of bhrb entry */
-    tcg_gen_add_tl(tmp, base, offset);
+    /* add base and offset to tcg_env to get address of bhrb entry */
+    tcg_gen_addi_i32(tmp, offset, offsetof(CPUPPCState, bhrb));
+    tcg_gen_ext_i32_ptr(ptr, tmp);
+    tcg_gen_add_ptr(ptr, ptr, tcg_env);
 
     /* store value into bhrb at bhrb_offset */
-    tcg_gen_st_i64(value, (TCGv_ptr)tmp, 0);
+    tcg_gen_st_i64(value, ptr, 0);
 
     /* add 8 to current bhrb_offset */
-    tcg_gen_addi_tl(offset, offset, 8);
+    tcg_gen_addi_i32(offset, offset, 8);
 
     /* apply offset mask */
-    tcg_gen_and_tl(offset, offset, mask);
+    tcg_gen_and_i32(offset, offset, mask);
 
     return offset;
 }
@@ -4193,10 +4196,9 @@ static inline void gen_update_branch_history(DisasContext *ctx,
                                              target_long inst_type)
 {
 #if defined(TARGET_PPC64)
-    TCGv base;
     TCGv tmp;
-    TCGv offset;
-    TCGv mask;
+    TCGv_i32 offset;
+    TCGv_i32 mask;
     TCGLabel *no_update;
 
     if (ctx->has_cfar) {
@@ -4216,32 +4218,31 @@ static inline void gen_update_branch_history(DisasContext *ctx,
     tcg_gen_andi_tl(tmp, tmp, inst_type);
     tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
 
-    base = tcg_temp_new();
-    offset = tcg_temp_new();
-    mask = tcg_temp_new();
-
-    /* load bhrb base address */
-    tcg_gen_ld_tl(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
+    offset = tcg_temp_new_i32();
+    mask = tcg_temp_new_i32();
 
     /* load current bhrb_offset */
-    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+    tcg_gen_ld_i32(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
 
     /* load a BHRB offset mask */
-    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
+    tcg_gen_ld_i32(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
 
-    offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
+    offset = gen_write_bhrb(offset, mask, tcg_constant_i64(nip));
 
     /* Also record the target address for XL-Form branches */
     if (inst_type & BHRB_TYPE_XL_FORM) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        tcg_gen_extu_tl_i64(t, target);
 
         /* Set the 'T' bit for target entries */
-        tcg_gen_ori_tl(tmp, target, 0x2);
+        tcg_gen_ori_i64(t, target, 0x2);
 
-        offset = gen_write_bhrb(base, offset, mask, tmp);
+        offset = gen_write_bhrb(offset, mask, t);
     }
 
     /* save updated bhrb_offset for next time */
-    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+    tcg_gen_st_i32(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
 
     gen_set_label(no_update);
 #endif
-- 
2.42.0


