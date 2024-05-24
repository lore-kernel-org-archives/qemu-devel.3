Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D40C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0l-0005IF-CX; Fri, 24 May 2024 04:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0j-0005GY-AD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0h-0000aq-A6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOf1GDc1mw7wQ8tgJj66VHZbtkhao7Ks6veQoOnKMHc=;
 b=POy4OEjjwdL0n68owRvf+gfTiNBTqOpBzi6Ga16lbGK0S+x8VsIm9mg4iQXVnri5/g2qaV
 lZ3J8W1SFOHLtbxhmS464dk9rffg9FMrZtEihp4kqmcHcA2i6m5YiCPSwMGw5pcxNBnHq6
 vufamORg77j8CFZk86mrZYWV4ZIJgic=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ymontsuLNPKhuNC0GXcx6Q-1; Fri, 24 May 2024 04:10:40 -0400
X-MC-Unique: ymontsuLNPKhuNC0GXcx6Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6266ffd419so25016966b.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538238; x=1717143038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOf1GDc1mw7wQ8tgJj66VHZbtkhao7Ks6veQoOnKMHc=;
 b=qERkBl0cVwH4ttkniwqVrZwW3TAYv5rKPN3A+AviMo1DBMXfojBv25wz270jiM+r8c
 52xJXl539o8ERvO5nupLKrnwQ0iXoVu13j58Wn6X0IYPTJVeUvkl2ZxQu387Qvrxh/ec
 qkijXWrEKZ4ecJHYicu1EqUqbubt2D9IyNE6aqs++RcfOlhrZFtiQoBKLdWyPx9e5ZDm
 ecbX7nr36BP8xluurFqQSOTrNgq0oFD4vMVBLf0tcdnxSgBP8KrPpWK4g1MWDlm2fCCL
 9DJz3mGrcKnEAZDp8fdOwhI1fczIW/sc+VHTPMm5SVSZKdmvkbU7HUtJ4NNawmwPEsFz
 QFhA==
X-Gm-Message-State: AOJu0YyV6Bbw85jwy+cmeEYsE8MmeHwVd2SZhQsWMhk7O4zGe8d/CQ3c
 sf+ofHTvFGD2olDTM4vLrrvdp7KMbuElt5u0V8uKohyMdgpSCn//HHKbx9ngckDqHHxV9/Akeq+
 LjgwLyfdLdgyRrH7M5E2fa/OwWypQGipDf50+PMTrUlRT3TgtYBVj9yfflEXixlHUuVfFMVMkpK
 Nh/zCLo7J9r5pMmWBdTVIt9AXTTA1ab4JmP5jn
X-Received: by 2002:a17:906:788:b0:a59:adf8:a6e1 with SMTP id
 a640c23a62f3a-a62651144f1mr90978166b.47.1716538238520; 
 Fri, 24 May 2024 01:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkLnYpCjlOoGTWiQNIpiIuXci86y7vSmMhwG5fLep1/NBQc1IUTST4kkrgoOwBsDmgq5TvdQ==
X-Received: by 2002:a17:906:788:b0:a59:adf8:a6e1 with SMTP id
 a640c23a62f3a-a62651144f1mr90975766b.47.1716538237979; 
 Fri, 24 May 2024 01:10:37 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93707csm91368966b.57.2024.05.24.01.10.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] target/i386: reg in gen_ldst_modrm is always OR_TMP0
Date: Fri, 24 May 2024 10:10:11 +0200
Message-ID: <20240524081019.1141359-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c46385be060..b75d61a9141 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1821,10 +1821,9 @@ static void gen_add_A0_ds_seg(DisasContext *s)
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
 
@@ -1832,24 +1831,16 @@ static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
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
@@ -3440,7 +3431,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_ldst_modrm(env, s, modrm, ot, 0);
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
@@ -3587,14 +3578,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
@@ -3609,14 +3600,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
@@ -3625,7 +3616,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
@@ -3889,7 +3880,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
+            gen_ldst_modrm(env, s, modrm, ot, 1);
             break;
         case 0xee: /* rdpkru */
             if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
@@ -3916,7 +3907,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
@@ -3988,7 +3979,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
+            gen_ldst_modrm(env, s, modrm, MO_16, 0);
             t0 = tcg_temp_new();
             gen_update_cc_op(s);
             if (b == 0x102) {
@@ -4492,7 +4483,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         ot = dflag;
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_ldst_modrm(env, s, modrm, ot, 0);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
         tcg_gen_ctpop_tl(s->T0, s->T0);
-- 
2.45.1


