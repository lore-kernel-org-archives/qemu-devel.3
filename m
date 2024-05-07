Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21009C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUK-0004Rs-Lm; Tue, 07 May 2024 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUH-0004QP-Ok
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUF-000285-S1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VGZo6OJgSmxu6kSdK/0pRmHiKxv4I19qIwPexYcwy4=;
 b=NoTAbq4nUB+cS1ksqiFavanUiX/rFDzooXz0idra2hLgtxfgd62FtoEcB4QFXzCs80CMzU
 5es0v2VBXOvLfCrW4Ke/FUzQg0uXLG7BOaY0nz9k/qTZ/dH9p7yMxyA747guSIl4mZNdnp
 cX1BahgBLRNPME4b6fwDRb4ZtfgRLZY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-XR5UaH3aO66JIvY5LFBENw-1; Tue, 07 May 2024 06:55:53 -0400
X-MC-Unique: XR5UaH3aO66JIvY5LFBENw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a558739aaf4so232183466b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079352; x=1715684152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VGZo6OJgSmxu6kSdK/0pRmHiKxv4I19qIwPexYcwy4=;
 b=VzMm1ZzKtZyojzZrgDDDM1yFH7zabeF6OLy6WjSIZIfsrQgPghML47++zluj6NP2Gg
 nlOzgXLkXKoICoLa4nJC9pBFpCdUHiybI1VYe2/iOFxPsY5rmdbcqJxRJLEeG/7VGsbA
 bt8jC7PkPXfQE0z/aD0GT/V+9oa4+gyefce8/+uRMrOBFXPmah+3k8cSrv9Xl9tMKaer
 QzO+v/6X+gklF6V5bWtuxyR7k89AQLjJv5HDaTnL118bBsXuUGL3jxoXkn6OUKDk5yQL
 7uV6OeMU7Dc4WLJfxB4FLdV5n0+v2x3Hxrd7bFmllBMhKUKWQKOEgNGgJIQPU45PvhMP
 ufJA==
X-Gm-Message-State: AOJu0YwpJ0JaR+Mxq0ikkjMgJSOld21AXk8lB8b72qMqp8pl5qT17TMw
 3i6fe5EWqLXcy4+Flyjs3lsSO93ePYJ6hsGQo/NgszlbmhteTgdves0whC73cp0Zzrp2T6gmxP9
 ajaV+xIEdEOW+TxTZHZcnwRp7P86ONGC6ihzab9IkAg0CqF8iaCWATZDQONL985gIpV1LgQH8qf
 DXSxKgRELnzpNJXDtgwyDisAutltBP7CG73geg
X-Received: by 2002:a17:907:7d89:b0:a59:cb29:3fa8 with SMTP id
 oz9-20020a1709077d8900b00a59cb293fa8mr6859205ejc.14.1715079352284; 
 Tue, 07 May 2024 03:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDLQjpZj4KNnXbm0CtwvJUmTfTr/3xmLBeH03uDCpvgMKmehdSfqdkO+MbgUGJqqpZmDvn9g==
X-Received: by 2002:a17:907:7d89:b0:a59:cb29:3fa8 with SMTP id
 oz9-20020a1709077d8900b00a59cb293fa8mr6859191ejc.14.1715079351905; 
 Tue, 07 May 2024 03:55:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a17090655c400b00a5931d77634sm6331116ejp.34.2024.05.07.03.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/26] target/i386: remove mask from CCPrepare
Date: Tue,  7 May 2024 12:55:16 +0200
Message-ID: <20240507105538.180704-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

With the introduction of TSTEQ and TSTNE the .mask field is always -1,
so remove all the now-unnecessary code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 81 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 62ba21c1d74..9aecd415b38 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -923,7 +923,6 @@ typedef struct CCPrepare {
     TCGv reg;
     TCGv reg2;
     target_ulong imm;
-    target_ulong mask;
     bool use_reg2;
     bool no_setcond;
 } CCPrepare;
@@ -931,9 +930,9 @@ typedef struct CCPrepare {
 static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
 {
     if (size == MO_TL) {
-        return (CCPrepare) { .cond = TCG_COND_LT, .reg = src, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_LT, .reg = src };
     } else {
-        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src, .mask = -1,
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src,
                              .imm = 1ull << ((8 << size) - 1) };
     }
 }
@@ -962,17 +961,17 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
     add_sub:
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
-                             .reg2 = t1, .mask = -1, .use_reg2 = true };
+                             .reg2 = t1, .use_reg2 = true };
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_CLR:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_NEVER };
 
     case CC_OP_INCB ... CC_OP_INCQ:
     case CC_OP_DECB ... CC_OP_DECQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = -1, .no_setcond = true };
+                             .no_setcond = true };
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
@@ -981,23 +980,23 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE,
-                             .reg = cpu_cc_src, .mask = -1 };
+                             .reg = cpu_cc_src };
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
         t0 = gen_ext_tl(reg, cpu_cc_src, size, false);
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0 };
 
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
-                             .mask = -1, .no_setcond = true };
+                             .no_setcond = true };
 
     case CC_OP_EFLAGS:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
         return (CCPrepare) { .cond = TCG_COND_TSTNE,
-                             .reg = cpu_cc_src, .mask = -1, .imm = CC_C };
+                             .reg = cpu_cc_src, .imm = CC_C };
 
     default:
        /* The need to compute only C from CC_OP_DYNAMIC is important
@@ -1006,7 +1005,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
        gen_helper_cc_compute_c(reg, cpu_cc_dst, cpu_cc_src,
                                cpu_cc_src2, cpu_cc_op);
        return (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                            .mask = -1, .no_setcond = true };
+                            .no_setcond = true };
     }
 }
 
@@ -1015,7 +1014,7 @@ static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
     return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                         .mask = -1, .imm = CC_P };
+                         .imm = CC_P };
 }
 
 /* compute eflags.S to reg */
@@ -1030,10 +1029,10 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                             .mask = -1, .imm = CC_S };
+                             .imm = CC_S };
     case CC_OP_CLR:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_NEVER };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
@@ -1049,17 +1048,16 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
-                             .mask = -1, .no_setcond = true };
+                             .no_setcond = true };
     case CC_OP_CLR:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_NEVER };
     case CC_OP_MULB ... CC_OP_MULQ:
-        return (CCPrepare) { .cond = TCG_COND_NE,
-                             .reg = cpu_cc_src, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
         gen_compute_eflags(s);
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                             .mask = -1, .imm = CC_O };
+                             .imm = CC_O };
     }
 }
 
@@ -1075,21 +1073,19 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                             .mask = -1, .imm = CC_Z };
+                             .imm = CC_Z };
     case CC_OP_CLR:
-        return (CCPrepare) { .cond = TCG_COND_ALWAYS, .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_ALWAYS };
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src,
-                             .mask = -1 };
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
             if (size == MO_TL) {
-                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
-                                     .mask = -1 };
+                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
             } else {
                 return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
-                                     .mask = -1, .imm = (1ull << (8 << size)) - 1 };
+                                     .imm = (1ull << (8 << size)) - 1 };
             }
         }
     }
@@ -1117,7 +1113,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             gen_extu(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
-                               .reg2 = t0, .mask = -1, .use_reg2 = true };
+                               .reg2 = t0, .use_reg2 = true };
             break;
 
         case JCC_L:
@@ -1130,7 +1126,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             gen_exts(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
             cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
-                               .reg2 = t0, .mask = -1, .use_reg2 = true };
+                               .reg2 = t0, .use_reg2 = true };
             break;
 
         default:
@@ -1154,7 +1150,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_BE:
             gen_compute_eflags(s);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                               .mask = -1, .imm = CC_Z | CC_C };
+                               .imm = CC_Z | CC_C };
             break;
         case JCC_S:
             cc = gen_prepare_eflags_s(s, reg);
@@ -1169,7 +1165,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
-                               .mask = -1, .imm = CC_O };
+                               .imm = CC_O };
             break;
         default:
         case JCC_LE:
@@ -1179,7 +1175,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
-                               .mask = -1, .imm = CC_O | CC_Z };
+                               .imm = CC_O | CC_Z };
             break;
         }
         break;
@@ -1204,16 +1200,6 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
         return;
     }
 
-    if (cc.cond == TCG_COND_NE && !cc.use_reg2 && cc.imm == 0 &&
-        cc.mask != 0 && (cc.mask & (cc.mask - 1)) == 0) {
-        tcg_gen_shri_tl(reg, cc.reg, ctztl(cc.mask));
-        tcg_gen_andi_tl(reg, reg, 1);
-        return;
-    }
-    if (cc.mask != -1) {
-        tcg_gen_andi_tl(reg, cc.reg, cc.mask);
-        cc.reg = reg;
-    }
     if (cc.use_reg2) {
         tcg_gen_setcond_tl(cc.cond, reg, cc.reg, cc.reg2);
     } else {
@@ -1232,10 +1218,6 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
 
-    if (cc.mask != -1) {
-        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
-        cc.reg = s->T0;
-    }
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
     } else {
@@ -1251,10 +1233,6 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
 
     gen_update_cc_op(s);
-    if (cc.mask != -1) {
-        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
-        cc.reg = s->T0;
-    }
     set_cc_op(s, CC_OP_DYNAMIC);
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
@@ -2519,11 +2497,6 @@ static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T1);
 
-    if (cc.mask != -1) {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_andi_tl(t0, cc.reg, cc.mask);
-        cc.reg = t0;
-    }
     if (!cc.use_reg2) {
         cc.reg2 = tcg_constant_tl(cc.imm);
     }
-- 
2.45.0


