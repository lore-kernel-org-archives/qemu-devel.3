Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CEDC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORh-0003Ec-Kc; Tue, 04 Jun 2024 03:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORg-0003Ch-6C
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORe-0005dN-Do
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdoHVj3MnM6xNHR6wiFxITGd/pg/M7TRVW28uhWoqSA=;
 b=A6xG8l5nK2COHr3g9reR6EfiVjLaYywt1ZUU9r7Gi2/uTZ6IusInwhGb9dsn2DBl58HffU
 Zd/zCaVqtSqB8axdHu6j0LWiu1GrlF92fH9Dh+rfXFHRM6XvkyluOzyUxHvwtzCO5tLM1k
 eL7QTIb9xaBtqUaIFqO4O4Zmwq7byHI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-R5rhD1EjPJ-uXDIGk3u0bg-1; Tue, 04 Jun 2024 03:18:52 -0400
X-MC-Unique: R5rhD1EjPJ-uXDIGk3u0bg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a33a589b3so1410062a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485531; x=1718090331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdoHVj3MnM6xNHR6wiFxITGd/pg/M7TRVW28uhWoqSA=;
 b=pVmdev/mh3SESkkcp91eGHlYUg8yhWlLC3k7yOzP6U8OQqjzWMSgmJyn+RSk6NiI1t
 NUFHCATAhyY1zn3PGvkZsv/x60HvzLqQTI/Zl6sYZxe+0bx1HVuVhOuUQA169rJIB1FG
 JuoqBeYPqH4sT5CUEz8FuBLaX8lnsFAI75cWC+6sp6XoXnF3XYhnAkMVxexA0Fw/MmB5
 alEuhfSqaUvhlTOOrr4KSKkodVvvP5HQDHA8XghotkxlkNNsL0RJ/DYKRmg/FS+ghiUN
 geKZj7ExhTA6JJs5KKaG9wV1Fb0P9v4RUJRcxjY+CCIPgWiUKDMv2lo/tMli8Sr5MNRG
 itCQ==
X-Gm-Message-State: AOJu0Yx16qOADA232C9MKD4MG8827yPZuveRxKQbkAz3laHH6DjTG7fw
 8US3VErCoHBUblntAl1SKwQ61jsSdD+xx4Azd1LaGfGms43MH0ot3BBP/75slO5I5gyk+DGBJRO
 2kiyGXvWiq72fILNw7ZGM31UafCderfbnWz23LcTOSC6Np6LoQeo3QgmDKpmduAFaSE9vTeAvdx
 /ufD3ZsV5Xpw9PdRH140IJqGoGPFzx3yDQQKQb
X-Received: by 2002:a17:906:3488:b0:a69:24f:23e7 with SMTP id
 a640c23a62f3a-a69024f243dmr351152866b.19.1717485530705; 
 Tue, 04 Jun 2024 00:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQO0U2Meo9rcZ2moPnucu22v3XH/OB4DJUwrQep5TLlkvYphj1TyHZDUcQps26eCEEn8DF9A==
X-Received: by 2002:a17:906:3488:b0:a69:24f:23e7 with SMTP id
 a640c23a62f3a-a69024f243dmr351150866b.19.1717485530236; 
 Tue, 04 Jun 2024 00:18:50 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e7dc0f95sm368091766b.108.2024.06.04.00.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 04/11] target/i386: cleanup PAUSE helpers
Date: Tue,  4 Jun 2024 09:18:26 +0200
Message-ID: <20240604071833.962574-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use decode.c's support for intercepts, doing the check in TCG-generated
code rather than the helper.  This is cleaner because it allows removing
the eip_addend argument to helper_pause(), even though it adds a bit of
bloat for opcode 0x90's new decoding function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                 |  2 +-
 target/i386/tcg/helper-tcg.h         |  1 -
 target/i386/tcg/misc_helper.c        | 10 +---------
 target/i386/tcg/sysemu/misc_helper.c |  2 +-
 target/i386/tcg/decode-new.c.inc     | 15 ++++++++++++++-
 target/i386/tcg/emit.c.inc           | 20 ++++++++------------
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index c244dbb4812..2f46cffabd8 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -53,7 +53,7 @@ DEF_HELPER_1(sysenter, void, env)
 DEF_HELPER_2(sysexit, void, env, int)
 DEF_HELPER_2(syscall, void, env, int)
 DEF_HELPER_2(sysret, void, env, int)
-DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 6a5505e7b4c..43180b58314 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -91,7 +91,6 @@ extern const uint8_t parity_table[256];
 
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
-G_NORETURN void do_pause(CPUX86State *env);
 
 /* sysemu/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index b0f0f7b893b..8316d42ffcd 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -88,7 +88,7 @@ G_NORETURN void helper_rdpmc(CPUX86State *env)
     raise_exception_err(env, EXCP06_ILLOP, 0);
 }
 
-G_NORETURN void do_pause(CPUX86State *env)
+G_NORETURN void helper_pause(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -97,14 +97,6 @@ G_NORETURN void do_pause(CPUX86State *env)
     cpu_loop_exit(cs);
 }
 
-G_NORETURN void helper_pause(CPUX86State *env, int next_eip_addend)
-{
-    cpu_svm_check_intercept_param(env, SVM_EXIT_PAUSE, 0, GETPC());
-    env->eip += next_eip_addend;
-
-    do_pause(env);
-}
-
 uint64_t helper_rdpkru(CPUX86State *env, uint32_t ecx)
 {
     if ((env->cr[4] & CR4_PKE_MASK) == 0) {
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index e41c88346cb..093cc2d0f90 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -547,7 +547,7 @@ G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
 
     /* XXX: not complete but not completely erroneous */
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
-        do_pause(env);
+        helper_pause(env);
     } else {
         helper_hlt(env);
     }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 376d2bdabe1..c2d8da8d14e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1359,6 +1359,19 @@ static void decode_group11(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     }
 }
 
+static void decode_90(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static X86OpEntry pause = X86_OP_ENTRY0(PAUSE, svm(PAUSE));
+    static X86OpEntry nop = X86_OP_ENTRY0(NOP);
+    static X86OpEntry xchg_ax = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v);
+
+    if (REX_B(s)) {
+        *entry = xchg_ax;
+    } else {
+        *entry = (s->prefix & PREFIX_REPZ) ? pause : nop;
+    }
+}
+
 static const X86OpEntry opcodes_root[256] = {
     [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
     [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
@@ -1441,7 +1454,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
-    [0x90] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x90] = X86_OP_GROUP0(90),
     [0x91] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
     [0x92] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
     [0x93] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2e94e8ec56f..f90f3d3c589 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2350,6 +2350,14 @@ static void gen_PANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
                       decode->op[1].offset, vec_len, vec_len);
 }
 
+static void gen_PAUSE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_update_eip_next(s);
+    gen_helper_pause(tcg_env);
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
 static void gen_PCMPESTRI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -4014,18 +4022,6 @@ static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (decode->b == 0x90 && !REX_B(s)) {
-        if (s->prefix & PREFIX_REPZ) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
-        }
-        /* No writeback.  */
-        decode->op[0].unit = X86_OP_SKIP;
-        return;
-    }
-
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_xchg_tl(s->T0, s->A0, s->T1,
                                s->mem_index, decode->op[0].ot | MO_LE);
-- 
2.45.1


