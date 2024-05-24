Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1605AC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0n-0005LN-2h; Fri, 24 May 2024 04:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0l-0005Ic-KN
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0i-0000ay-Af
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXmBE/duhd+71tzkCPvAsV1jTylKJ/o/izbc+RObas4=;
 b=dRdB1rL5k+GpSMWmta4/WhOx+3nlfEXRSCDX+xFf0A1Rftgf5Wf5+niPLAWay9mARu7d1Q
 UF1MLadWsNySznkcYAuJZvSOh+K47PVe8CTnYX6nzNsb+U4DDLTBFkYCFPbtHArKXXT9M4
 xpyF/z2UOsiW50F3J0rWmaBxLkYFjCg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-7a2OZAT4MFGbBaglqS2l3w-1; Fri, 24 May 2024 04:10:41 -0400
X-MC-Unique: 7a2OZAT4MFGbBaglqS2l3w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6269ad800aso27587466b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538239; x=1717143039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXmBE/duhd+71tzkCPvAsV1jTylKJ/o/izbc+RObas4=;
 b=SsNXi6aPElnkYowtguDacuQwFgUnzInQoiTzlnh7CUrohSmjoLGTox8yc2I02sRmoD
 In5/AgKHIIWn3YQUwkmFgBl69SF+8+i/SWRkQs2cCPUHObi94x2PSMg6/tgf2RV3IMIE
 RW0a0//Bp+nE2I0m30b7TRLUKuMnV2HHEfc4kJQSRSiHiPkE1YneJ/LONUEWAc90tGnj
 DC+zPatqjC7LYQs0sTti37V4BptqJVIk/y7ZDHbXTjTb5/gjGRoNFIWpgwJ9lG7CuhJ/
 Rr5KI5PuI+jyvFDPQorOLfEfkr0G3xHvPrYgj070jn1S6aslgCutRM3zLEe2mS6ZWqlg
 AQQQ==
X-Gm-Message-State: AOJu0YxnfSxq5sF3CPAETp9W4yzd+LmUGiL32jDJF2tV+I8KpJ7nzhwg
 pXcS7ctQQW+GEiYKu1MsHaVD7dZBZLu3qdUtPi7qqP2Jnk3iHWH3VvrganMGGSzvfw507Z2lZw/
 qIay3YdgyKJhxdiKLWyU7EXfsE+HKj07ghUWCl9Onc9dfgdFhf2J9ZaKnVytf/Q7ts8K46I43nF
 3ohx+tiEJB1oaX3PtIEWAP9ipilumaXa3+6tHB
X-Received: by 2002:a17:906:f18a:b0:a59:edbc:193d with SMTP id
 a640c23a62f3a-a6265119d6amr161720266b.55.1716538239465; 
 Fri, 24 May 2024 01:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkwnnW03vwuPXGRw9U68ha9FnoNq7bz+KAMbfF8RUsZAmDV8KEB5PEb9XN1Fr7lWJLPjoDg==
X-Received: by 2002:a17:906:f18a:b0:a59:edbc:193d with SMTP id
 a640c23a62f3a-a6265119d6amr161718666b.55.1716538239015; 
 Fri, 24 May 2024 01:10:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc523d1sm89632066b.134.2024.05.24.01.10.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] target/i386: split gen_ldst_modrm for load and store
Date: Fri, 24 May 2024 10:10:12 +0200
Message-ID: <20240524081019.1141359-10-pbonzini@redhat.com>
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

The is_store argument of gen_ldst_modrm has only ever been passed
a constant.  Just split the function in two.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 52 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b75d61a9141..d32b5b63f5c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1821,27 +1821,33 @@ static void gen_add_A0_ds_seg(DisasContext *s)
     gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
 }
 
-/* generate modrm memory load or store of 'reg'. */
-static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
-                           MemOp ot, int is_store)
+/* generate modrm load of memory or register. */
+static void gen_ld_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
 {
     int mod, rm;
 
     mod = (modrm >> 6) & 3;
     rm = (modrm & 7) | REX_B(s);
     if (mod == 3) {
-        if (is_store) {
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-        }
+        gen_op_mov_v_reg(s, ot, s->T0, rm);
     } else {
         gen_lea_modrm(env, s, modrm);
-        if (is_store) {
-            gen_op_st_v(s, ot, s->T0, s->A0);
-        } else {
-            gen_op_ld_v(s, ot, s->T0, s->A0);
-        }
+        gen_op_ld_v(s, ot, s->T0, s->A0);
+    }
+}
+
+/* generate modrm store of memory or register. */
+static void gen_st_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
+{
+    int mod, rm;
+
+    mod = (modrm >> 6) & 3;
+    rm = (modrm & 7) | REX_B(s);
+    if (mod == 3) {
+        gen_op_mov_reg_v(s, ot, rm, s->T0);
+    } else {
+        gen_lea_modrm(env, s, modrm);
+        gen_op_st_v(s, ot, s->T0, s->A0);
     }
 }
 
@@ -3431,7 +3437,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, 0);
+        gen_ld_modrm(env, s, modrm, ot);
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
@@ -3578,14 +3584,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_ldst_modrm(env, s, modrm, ot, 1);
+            gen_st_modrm(env, s, modrm, ot);
             break;
         case 2: /* lldt */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_LDTR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, 0);
+                gen_ld_modrm(env, s, modrm, MO_16);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(tcg_env, s->tmp2_i32);
             }
@@ -3600,14 +3606,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? dflag : MO_16;
-            gen_ldst_modrm(env, s, modrm, ot, 1);
+            gen_st_modrm(env, s, modrm, ot);
             break;
         case 3: /* ltr */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_TR_WRITE);
-                gen_ldst_modrm(env, s, modrm, MO_16, 0);
+                gen_ld_modrm(env, s, modrm, MO_16);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(tcg_env, s->tmp2_i32);
             }
@@ -3616,7 +3622,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
@@ -3880,7 +3886,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
-            gen_ldst_modrm(env, s, modrm, ot, 1);
+            gen_st_modrm(env, s, modrm, ot);
             break;
         case 0xee: /* rdpkru */
             if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
@@ -3907,7 +3913,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
@@ -3979,7 +3985,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             t0 = tcg_temp_new();
             gen_update_cc_op(s);
             if (b == 0x102) {
@@ -4483,7 +4489,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         ot = dflag;
-        gen_ldst_modrm(env, s, modrm, ot, 0);
+        gen_ld_modrm(env, s, modrm, ot);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
         tcg_gen_ctpop_tl(s->T0, s->T0);
-- 
2.45.1


