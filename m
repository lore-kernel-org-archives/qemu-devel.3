Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AE0CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEZw-0000XY-Jb; Tue, 09 Apr 2024 12:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZd-0000KU-5X
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZV-00081M-8A
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1KQQnQGmYnGuwtQD09Q9lKvxrOfBHUYPnj8qF07koM=;
 b=OBbKVfq/ZoiR9eFG9UhUDmHYW5f0wdBm0gEObewifNuzfH0riERTGbi8cDDXUVlrmoYY6V
 Dnpm37OW2vcWEWS+pfL2zIUIIZBD8irrHHj1aW6X8q2Igq1u81rfLiOaJSetoN6TJTFCJg
 Uzd0b1eahRmurDa6HgCnRVa8hGIuCY8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-n-pb9CH5Oa6L5DgraZSfIA-1; Tue, 09 Apr 2024 12:43:36 -0400
X-MC-Unique: n-pb9CH5Oa6L5DgraZSfIA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343e00c8979so2680171f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681014; x=1713285814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1KQQnQGmYnGuwtQD09Q9lKvxrOfBHUYPnj8qF07koM=;
 b=Aopqg6MAlgI+ZXxZdbvdYjJLttTr8R4eDobnIUpEDP6vsyGELq7gB8mrXKmbzKVhvL
 UfCybdCm/cCb9fxr0/Qnp2H8S44LKbSokfGDzXmqpHxmbrjAbBr9Zr9wYcE/gYhvP0H3
 i4j+ipaDtjtOMGB/rx5iMfXHKxKxz/mxJ/Xy2zs2yr0ipzy6nqXx2otx37qUzKEqPUBT
 gRjir/w3Aj63lRUOX2pKI/Kiy34bo0TgfxeWvyRjan3DKOGUpgf4PJpy6pA+dL8j+OEE
 zt+EC+F0WihDut9jYQ1jMF2BNjDo57oeLpjLffeT/lp/otCtsK+d97cCgsQf3iA3GhDZ
 CrIw==
X-Gm-Message-State: AOJu0YxdU6zTAW8/V8x6ypFjtQiDP+j5vQu+kbgLhaPVtn/n8Se8+XFx
 jvtHeb1wc1SpPvwLjfFVM4RnlzznAovTByeEQzJ24uRo4rV7y2ZSr8QUQMzvWVk2g+fghSJRm4a
 rm0cI4bHmkzUeR7txDYSXFDSSyK42rVks0vkFu0+2PujMp4gSWTd2EXTMiEw3NertiOqGrnvkDf
 iNJvxFXfoBcRG3bgJxUH+0dP4jBYt2WbvsNnJi
X-Received: by 2002:a5d:628c:0:b0:343:ad7e:5bc5 with SMTP id
 k12-20020a5d628c000000b00343ad7e5bc5mr170270wru.57.1712681014272; 
 Tue, 09 Apr 2024 09:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZW+p/EeqhK3wNBH/1eqnN+lF7t76+K38nUcqRm6zj2HBLRl2PtNbtuOHu4yIB4ZXh6SHhhA==
X-Received: by 2002:a5d:628c:0:b0:343:ad7e:5bc5 with SMTP id
 k12-20020a5d628c000000b00343ad7e5bc5mr170254wru.57.1712681013811; 
 Tue, 09 Apr 2024 09:43:33 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 c18-20020adffb52000000b00346266b612csm1912538wrs.81.2024.04.09.09.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-9.1 03/19] target/i386: remove mask from CCPrepare
Date: Tue,  9 Apr 2024 18:43:07 +0200
Message-ID: <20240409164323.776660-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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
index 4de5090846a..197cccb6c96 100644
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
2.44.0


