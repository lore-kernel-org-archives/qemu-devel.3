Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1B6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQm-0003So-MT; Mon, 06 May 2024 04:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQO-000331-Su
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQM-0002Eh-Su
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VGZo6OJgSmxu6kSdK/0pRmHiKxv4I19qIwPexYcwy4=;
 b=WY85ZKxyUApkpNAOnxS9h3fmBv3DH4tU/GO7vybRaZ7yVseu1TgHIah+XjC8lla5wkHTES
 5FgqRDzsoDT4IO6Be/sb2P05WPkgJpkdUpxFvSZ3MyRu1K/zICz52BiiOEb2W+4A6nFuyM
 E/u87jkLYTtSOUIfMHyOwv54CFSJx+c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-M2URe6rgPW-naQkxxweh7g-1; Mon, 06 May 2024 04:10:12 -0400
X-MC-Unique: M2URe6rgPW-naQkxxweh7g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-516d46e1bafso509545e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983010; x=1715587810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VGZo6OJgSmxu6kSdK/0pRmHiKxv4I19qIwPexYcwy4=;
 b=Qfnn2hS4yAFAkpJhI8TjrXhiAYOPGTve69hl5JdlhehAWDeSiG316oIJH9bYj0ZPra
 ZA5gsb0DEJkn/XAodc6rSvm5xtE6HHpbpIqEnyOBr71wtN2ku9AQRcLcPzF3SSJ2Z79N
 8rsKX421RHlTxKe5tVjsswJzCpZej3767amE+kUQb8qvhZBLQAB/hgCqIrtRqlpBnZvY
 Ow0cs6QvLx5ozdCOXnKAwgkLVjvPMMaYxQLjdX3wlXW0Ei/enEOt8GcVQ2MJyl9OPE4e
 QWngap8PVhDOJ8Q8trF8Oza+fTLJ1erXX1xjXKM89WWLOY0PFPqMZQr+I8smgbq+o7AP
 fGdQ==
X-Gm-Message-State: AOJu0YwNrXNRzdrnELLAG4GGp/YxKVEyNYnnHdUyPJ9Wl8Jpg30V+wP0
 ebelOMlHsc2I0lRImfRg5oLxOlU4oVTB4jZ80Pp643qXIz+6ROaT85Wa8U1nrKMqKWZt1veoG0n
 4Ee+jQ9ZKF4Ruy4wFll7lSj1Vsfynv3u/vXQ9h/5HqROd+OqXW6xYgQdtg13XPC2r7mK1ueyviJ
 gzYj5tXD9QqGWxuwvBNjS7978rjEfdBB7/doSY
X-Received: by 2002:ac2:51b3:0:b0:515:a8c9:6e99 with SMTP id
 f19-20020ac251b3000000b00515a8c96e99mr7441041lfk.5.1714983009658; 
 Mon, 06 May 2024 01:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGakMioupiMs26QN5IKeVEpaLiRwPQcs7rbX+drMOML3EadBvz4BOoNBxd287oj5aT5v5ZufA==
X-Received: by 2002:ac2:51b3:0:b0:515:a8c9:6e99 with SMTP id
 f19-20020ac251b3000000b00515a8c96e99mr7441012lfk.5.1714983009052; 
 Mon, 06 May 2024 01:10:09 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 g40-20020a056402322800b00572e0ab367dsm2984779eda.11.2024.05.06.01.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 03/25] target/i386: remove mask from CCPrepare
Date: Mon,  6 May 2024 10:09:35 +0200
Message-ID: <20240506080957.10005-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


