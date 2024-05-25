Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3358C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfL-0002SP-0v; Sat, 25 May 2024 07:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfJ-0002Qx-BX
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfH-00046b-4f
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypmfESkNybagHKfxWS2jwXuxZV2IYRYZI2tTdh7sRrU=;
 b=ENGfX8m5LtOu0JBoR6VC6vlPW0uC5DWq49YwdEXQWXJ2+ZxdNyzW6G+SffuaZ96caOK6Ns
 D6BiwUpOydiQPsyDyMmReI8qPcxpl8iCtOxfzVJYOQmXOSP4bR4qAy2+E6ZBwD8f58woV2
 V1a9TNkBHia4ptylqtX+Jftf9GNULCg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-O3E-qFkHNruj6_AkwkOoCg-1; Sat, 25 May 2024 07:34:16 -0400
X-MC-Unique: O3E-qFkHNruj6_AkwkOoCg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6269ad7288so81933466b.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636855; x=1717241655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypmfESkNybagHKfxWS2jwXuxZV2IYRYZI2tTdh7sRrU=;
 b=GH8/v/xoRAOciPh+CxHNb1++mOtDWMayqCjRB4BYmFhT1k4SQlYHz5ldfup8cLE4vT
 wMfqvlOkKPwcYQ40lqEbdQk0y2sh3JIxP2xp7A01+fmDtOQjPaE5JKd3v/a1SAWr6+GB
 q741w3nBQUAEXRD1vvXyRH3mnTW0iuKtCaHEFuCdbThdeTJcOd33jI4ppmDZw34uX1SE
 6eFVv9w17SLUB52Bs4tMmIVcXse5RYVIETtXu9QL/PYRv6V9QOR3Nisg97qLbI/5/or0
 SsWT3C2xe+ZzkCsAjeBRhtXBs3pNH0C5/BtTEbYlB7SeEAVO0GIzUGWXHgUWu+LKzMIA
 HpbQ==
X-Gm-Message-State: AOJu0Yz7k0Yk4Er9IbLYdVtEJ08RH++0SvBB88V/Gz5iwD1PnT4KRIuG
 Hw6QZI5KRxnfJbr+M/AGJ1PpWH71FyTKZI1dkVFagkUWfUqNo2axnx8GAoFZQM6SpzocYFY08NS
 6u/JqVV1A+PNUKdplX2IvITV1WG99je8KyB5Iv4L/sRBtvyXiVzlW8crKG/SXaKyjUkWELfQCh3
 eSkyxYzwyIn6DUrvymuUaxAQYttx07E5KUg6cA
X-Received: by 2002:a17:906:c095:b0:a5a:6bde:c3fb with SMTP id
 a640c23a62f3a-a62641dff7dmr316425666b.28.1716636855118; 
 Sat, 25 May 2024 04:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7XcY/bbNKtpteL7GX5590WOzqnJ81yb3cYS0PrjgQASneh3K78qZJSGJ4qk4+k3YlGrh78g==
X-Received: by 2002:a17:906:c095:b0:a5a:6bde:c3fb with SMTP id
 a640c23a62f3a-a62641dff7dmr316424466b.28.1716636854662; 
 Sat, 25 May 2024 04:34:14 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc519a2sm241938666b.126.2024.05.25.04.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/24] target/i386: reg in gen_ldst_modrm is always OR_TMP0
Date: Sat, 25 May 2024 13:33:21 +0200
Message-ID: <20240525113332.1404158-14-pbonzini@redhat.com>
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

Values other than OR_TMP0 were only ever used by MOV and MOVNTI
opcodes.  Now that these have been converted to the new decoder,
remove the argument.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 46c452032ba..4bb932af16b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1828,10 +1828,9 @@ static void gen_add_A0_ds_seg(DisasContext *s)
     gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
 }
 
-/* generate modrm memory load or store of 'reg'. TMP0 is used if reg ==
-   OR_TMP0 */
+/* generate modrm memory load or store of 'reg'. */
 static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
-                           MemOp ot, int reg, int is_store)
+                           MemOp ot, int is_store)
 {
     int mod, rm;
 
@@ -1839,24 +1838,16 @@ static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
     rm = (modrm & 7) | REX_B(s);
     if (mod == 3) {
         if (is_store) {
-            if (reg != OR_TMP0)
-                gen_op_mov_v_reg(s, ot, s->T0, reg);
             gen_op_mov_reg_v(s, ot, rm, s->T0);
         } else {
             gen_op_mov_v_reg(s, ot, s->T0, rm);
-            if (reg != OR_TMP0)
-                gen_op_mov_reg_v(s, ot, reg, s->T0);
         }
     } else {
         gen_lea_modrm(env, s, modrm);
         if (is_store) {
-            if (reg != OR_TMP0)
-                gen_op_mov_v_reg(s, ot, s->T0, reg);
             gen_op_st_v(s, ot, s->T0, s->A0);
         } else {
             gen_op_ld_v(s, ot, s->T0, s->A0);
-            if (reg != OR_TMP0)
-                gen_op_mov_reg_v(s, ot, reg, s->T0);
         }
     }
 }
@@ -3447,7 +3438,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_ldst_modrm(env, s, modrm, ot, 0);
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
@@ -3598,14 +3589,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
+            gen_ldst_modrm(env, s, modrm, ot, 1);
             break;
         case 2: /* lldt */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_LDTR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_16, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(tcg_env, s->tmp2_i32);
             }
@@ -3620,14 +3611,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
+            gen_ldst_modrm(env, s, modrm, ot, 1);
             break;
         case 3: /* ltr */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_TR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, MO_16, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(tcg_env, s->tmp2_i32);
             }
@@ -3636,7 +3627,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
@@ -3900,7 +3891,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
+            gen_ldst_modrm(env, s, modrm, ot, 1);
             break;
         case 0xee: /* rdpkru */
             if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
@@ -3927,7 +3918,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
@@ -3999,7 +3990,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             t0 = tcg_temp_new();
             gen_update_cc_op(s);
             if (b == 0x102) {
@@ -4503,7 +4494,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         ot = dflag;
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_ldst_modrm(env, s, modrm, ot, 0);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
         tcg_gen_ctpop_tl(s->T0, s->T0);
-- 
2.45.1


