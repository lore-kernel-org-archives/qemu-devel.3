Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DD7C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfd-0003MN-IV; Sat, 25 May 2024 07:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfc-0003I8-BA
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfY-0004AK-8Y
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3M9ywOxaASVOOG3Tp7/CLQyP00X1ishhis/9n+JJcM=;
 b=DSPviPfPrFdbQY4E9KslLP2QHiZOKVD6Rj8mIHfDi1mfFaEFHn8ZOJwV8UhTeXvSilqbh1
 K/HplX7cKqc4vJ7p1u9jlKT+165gwN/UDRhVYEe0OBOpbQtn7iGDxwP16TwGXvINJEA/vv
 9vU6ltf4Vm+Az6EWPZFAa4jHm+q3j5k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-DfzQfri0MWmMnmf6VOgGNg-1; Sat, 25 May 2024 07:34:34 -0400
X-MC-Unique: DfzQfri0MWmMnmf6VOgGNg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6267bcfb5fso32441366b.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636872; x=1717241672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3M9ywOxaASVOOG3Tp7/CLQyP00X1ishhis/9n+JJcM=;
 b=DK7xjROYKSR42pMcgtj9yL/lgOe/MCBR9r42INlcbNgC8kbz7idCKtLCs3/u21s2Hj
 qgG7EIzmnZaOJLI5SriG5Id+wTLis25yT6PZg5bhOCp3L86wqLRD4UlxXGBaSohBruL4
 gkyUeti2e1U2Iz+kPCBTYIA7y05pOEl6q4PFJSr2cLsgtvLUIWUEpaFlzgwexlQvJo/d
 cYXYWE8rsE4HBjq3hyBwaOBgdM/t12hG6rglYRFkOVf3f3q5iYfwCUq9r+pySaT1hikd
 r++D5/wszzBr2bxZ8YFeK9tuBUKyT/kxDE87h4r7HDuRxkzKmJimBxkVl+ORUHlLZALh
 195w==
X-Gm-Message-State: AOJu0YxFGQlRAYo1V95R5kCZSdUftJBmZlawjS07+CBRxvoN5a1Z8s2n
 umOb75OuJRaAJRRQBctH/Z/hfN7GYbpEX22zRg4kDpF0sSk4ozBaSYRdS8hoo9WlR2sVLxu9zcv
 bTtrbFydBaJ/Z82kz89GekKSkZXlTDGkwwSa30EHAzJbIxKv8mPdtRhCMpI4bj2OkYUIQLWDdrj
 +wEO39UecTm5F/zwrXxorQ4gHVb+Y75qtkrKhu
X-Received: by 2002:a50:8a98:0:b0:578:63c3:dfd0 with SMTP id
 4fb4d7f45d1cf-57863c40306mr2053591a12.24.1716636872355; 
 Sat, 25 May 2024 04:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmMDQEVuOeamwKghc68UaPUqYh4+48YLY/niAKoeY84OmzA3CVt3paf7zlUUl4YgzV1Th/Pw==
X-Received: by 2002:a50:8a98:0:b0:578:63c3:dfd0 with SMTP id
 4fb4d7f45d1cf-57863c40306mr2053583a12.24.1716636871988; 
 Sat, 25 May 2024 04:34:31 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579c3bbee4asm60965a12.76.2024.05.25.04.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/24] target/i386: remove aflag argument of gen_lea_v_seg
Date: Sat, 25 May 2024 13:33:27 +0200
Message-ID: <20240525113332.1404158-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is always s->aflag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 ++++++++++----------
 target/i386/tcg/emit.c.inc  |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7dd7ebf60d4..6dedfe94c04 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -680,20 +680,20 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
     }
 }
 
-static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
+static void gen_lea_v_seg(DisasContext *s, TCGv a0,
                           int def_seg, int ovr_seg)
 {
-    gen_lea_v_seg_dest(s, aflag, s->A0, a0, def_seg, ovr_seg);
+    gen_lea_v_seg_dest(s, s->aflag, s->A0, a0, def_seg, ovr_seg);
 }
 
 static inline void gen_string_movl_A0_ESI(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_ESI], R_DS, s->override);
+    gen_lea_v_seg(s, cpu_regs[R_ESI], R_DS, s->override);
 }
 
 static inline void gen_string_movl_A0_EDI(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);
+    gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
 static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
@@ -1784,7 +1784,7 @@ static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
     AddressParts a = gen_lea_modrm_0(env, s, modrm);
     TCGv ea = gen_lea_modrm_1(s, a, false);
-    gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
+    gen_lea_v_seg(s, ea, a.def_seg, s->override);
 }
 
 static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
@@ -2523,7 +2523,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
         bool update_fdp = true;
 
         tcg_gen_mov_tl(last_addr, ea);
-        gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
+        gen_lea_v_seg(s, ea, a.def_seg, s->override);
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
@@ -3320,7 +3320,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
             tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
             tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a, false), s->tmp0);
-            gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+            gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
             if (!(s->prefix & PREFIX_LOCK)) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
             }
@@ -3645,7 +3645,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
-            gen_lea_v_seg(s, s->aflag, cpu_regs[R_EAX], R_DS, s->override);
+            gen_lea_v_seg(s, cpu_regs[R_EAX], R_DS, s->override);
             gen_helper_monitor(tcg_env, s->A0);
             break;
 
@@ -4051,7 +4051,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
@@ -4156,7 +4156,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 377d2201c91..e990141454b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -76,7 +76,7 @@ static void gen_NM_exception(DisasContext *s)
 static void gen_load_ea(DisasContext *s, AddressParts *mem, bool is_vsib)
 {
     TCGv ea = gen_lea_modrm_1(s, *mem, is_vsib);
-    gen_lea_v_seg(s, s->aflag, ea, mem->def_seg, s->override);
+    gen_lea_v_seg(s, ea, mem->def_seg, s->override);
 }
 
 static inline int mmx_offset(MemOp ot)
@@ -2044,7 +2044,7 @@ static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_DS, s->override);
+    gen_lea_v_seg(s, cpu_regs[R_EDI], R_DS, s->override);
 
     if (s->prefix & PREFIX_DATA) {
         gen_helper_maskmov_xmm(tcg_env, OP_PTR1, OP_PTR2, s->A0);
@@ -4039,7 +4039,7 @@ static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* AL is already zero-extended into s->T0.  */
     tcg_gen_add_tl(s->A0, cpu_regs[R_EBX], s->T0);
-    gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
+    gen_lea_v_seg(s, s->A0, R_DS, s->override);
     gen_op_ld_v(s, MO_8, s->T0, s->A0);
 }
 
-- 
2.45.1


