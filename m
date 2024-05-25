Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17CEC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfN-0002Ty-BN; Sat, 25 May 2024 07:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfM-0002Tb-6b
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfK-00047S-FO
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBkZJsxUjQCschxBUdmlajywVV3FGiU9N2lB0Rg7DLg=;
 b=bnwAtSFMjwMk7aFXYuLepmB18kZukHg9cwj7leRsAZYZbFlzyxCx48hbcccg2oe8u3e8DH
 atuMJGinlPStT7B6d8c49rEIz//HsBdIIEVeJix4+E/yGbXgU6m6p2r3ppUMgo2yyrL8R/
 oP5z6piIxervCk/crZoxm+ZoBOZSBXM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-pO_kd6EIO4qoukvizMEkpg-1; Sat, 25 May 2024 07:34:19 -0400
X-MC-Unique: pO_kd6EIO4qoukvizMEkpg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so416390766b.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636858; x=1717241658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBkZJsxUjQCschxBUdmlajywVV3FGiU9N2lB0Rg7DLg=;
 b=aT30wqtdIhhWydWFzE4YJnqU3qcDQgdPBYMhUCU/gDIy510BF/uuuQwOVmhz718wJL
 DFOMEX6XxKx2AdpV+VyhKCn/INcHhefS4SMyhdpgG60nGVI9wxgtBnGVzvQnAGi68H94
 NETLITp1fEZ09NAkbCzELejNrPGh8zEpXh13wCSkk+6B44RG3sqDFxcmzbp1PdbAXyI2
 APN1JFr49YdVYPaWReMXUhKzXR+xW5At3QluOXQMTv/zdgPEpYKqCd1IJ0esWbzdLAt0
 5hkkJWOkxtYcGYJ099N/8bAWkCFpcws6pPr/hu0WJYYT56cqvuwpl7DKqU9xA7MaDH6c
 0+Yw==
X-Gm-Message-State: AOJu0YxINXFS5pCrZb0TESevwsUYxggMccHWaC+0aW2DFTHKqlif9kFP
 vGrMMgReq9Kme+u/14ojsuBC3dUG7d180FLb4q5vtIxNqJZfsDDMvNqGwVVxC10D1KkGPQVrMuK
 LKUtDGhmmd2QmrzW38XOj/t1JsnDOiiHiNdIQLKl9NXi76SF/ayrocF2tEGdH8gK9aksXTdTkbV
 t/676MC+vgQewISfsh+7spGDQpNWBHV7h5SHtU
X-Received: by 2002:a17:906:358e:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a626250ddcemr409072366b.24.1716636858057; 
 Sat, 25 May 2024 04:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoVMOEa2tJTmt491sGj8Dq8796mfUUUspdsRPxOvshBpj8lfXpnVHKQJWrbxRRIaw09SEzwQ==
X-Received: by 2002:a17:906:358e:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a626250ddcemr409071366b.24.1716636857594; 
 Sat, 25 May 2024 04:34:17 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8c27bsm244459166b.156.2024.05.25.04.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/24] target/i386: split gen_ldst_modrm for load and store
Date: Sat, 25 May 2024 13:33:22 +0200
Message-ID: <20240525113332.1404158-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 52 +++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4bb932af16b..afbed87056a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1828,27 +1828,33 @@ static void gen_add_A0_ds_seg(DisasContext *s)
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
 
@@ -3438,7 +3444,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, 0);
+        gen_ld_modrm(env, s, modrm, ot);
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
@@ -3589,14 +3595,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
@@ -3611,14 +3617,14 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
@@ -3627,7 +3633,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
@@ -3891,7 +3897,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
-            gen_ldst_modrm(env, s, modrm, ot, 1);
+            gen_st_modrm(env, s, modrm, ot);
             break;
         case 0xee: /* rdpkru */
             if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
@@ -3918,7 +3924,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
@@ -3990,7 +3996,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
-            gen_ldst_modrm(env, s, modrm, MO_16, 0);
+            gen_ld_modrm(env, s, modrm, MO_16);
             t0 = tcg_temp_new();
             gen_update_cc_op(s);
             if (b == 0x102) {
@@ -4494,7 +4500,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         ot = dflag;
-        gen_ldst_modrm(env, s, modrm, ot, 0);
+        gen_ld_modrm(env, s, modrm, ot);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
         tcg_gen_ctpop_tl(s->T0, s->T0);
-- 
2.45.1


