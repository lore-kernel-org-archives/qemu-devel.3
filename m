Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8252C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHrB-0004ix-O6; Wed, 28 Feb 2024 06:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr9-0004go-5D
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr6-0003ne-ET
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wUSO+qZ4tNs0ir8YxjqhY4NacCQoW943sxnYhbULbKk=;
 b=HGrT4QhUJ9791clu/ZAK2hJzMiC/79WmiV8XoyHrQ2DyuM9eQb9zOAP85Ab4nGQ7xIZeIy
 Cvhj4v6gp0Gd2eoVJ1WAxBJkkhoo6XXHouRQmmxgz18cFStl+WXr28cwGg0pUNgou6pCv5
 0LczbIGfjq+qkiX6JzOSbBtV3VkyUtI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VWHrIgezOMKDFPSOFbe1kQ-1; Wed, 28 Feb 2024 06:12:06 -0500
X-MC-Unique: VWHrIgezOMKDFPSOFbe1kQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56542d424cdso2955521a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118724; x=1709723524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUSO+qZ4tNs0ir8YxjqhY4NacCQoW943sxnYhbULbKk=;
 b=rZ734eEO+G5YJQkND6Ki+u4Qm/fmGr4oKUmAhubYsi7IGAiH7/IdteI78pqcNjspt9
 utKzqVUNjePHXS/YeBPH8sC6XFQExGKUciEmQFi3XBJK+19Fp5dBfpHWa0gzeEROQXcS
 VWJqXxg/jI93N7qs+X0a3EzEJ8rswyO9wVnDIycbW1w4nrmstQ433q/ATVcpB4ZGtxvk
 SqXhGNHhMGaxKP37Aqm5YW1IAxHWucdtVoMW3c4yuYvzjfyoG030IGwbTe6g4aqHt1Df
 eg5u81rK6xsNMbjFs9FD+l8dYELsT12ilCU+zElgblymICS0NvXKoibFNnR7zbN0A2EL
 l5Pg==
X-Gm-Message-State: AOJu0Yyc3FIOWgFGbNRLZlHgRGnwVTXyqbdZqjhxN3wgvU/GzRFWH9GA
 jvbZebqeKrkhnD63rADYvH0E9OwQf+D/dSNcNi4ZwL4Wn3hMTPO1md+FAnbD5apiN9+xM5fCaE2
 1hNRRmp1tovYJmERjvxcg9bLRfG3Iq+ixgKvEiaN52rCL6v3rybvW5H2DwimBw+VytbrUVgDG6n
 fKqNXSnHwG5NhruVDw4XCikqMGNxYoTb8yC9xc
X-Received: by 2002:a17:906:d192:b0:a43:2290:7689 with SMTP id
 c18-20020a170906d19200b00a4322907689mr5733357ejz.65.1709118723718; 
 Wed, 28 Feb 2024 03:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGalDDsXcf1+kfbie99oGFSvP5y8mZW3invQnXSotjlrRHSzn8THRUuuR+J3iovdFihR9cYrA==
X-Received: by 2002:a17:906:d192:b0:a43:2290:7689 with SMTP id
 c18-20020a170906d19200b00a4322907689mr5733343ejz.65.1709118723314; 
 Wed, 28 Feb 2024 03:12:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ti6-20020a170907c20600b00a43c3e5e008sm1286195ejc.205.2024.02.28.03.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:12:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 3/4] target/i386: remove mask from CCPrepare
Date: Wed, 28 Feb 2024 12:11:50 +0100
Message-ID: <20240228111151.287738-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228111151.287738-1-pbonzini@redhat.com>
References: <20240228111151.287738-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

With the introduction of TSTEQ and TSTNE the .mask field is always -1,
so remove all the now-unnecessary code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 81 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 63d520e0cba..6b4522c226d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -922,7 +922,6 @@ typedef struct CCPrepare {
     TCGv reg;
     TCGv reg2;
     target_ulong imm;
-    target_ulong mask;
     bool use_reg2;
     bool no_setcond;
 } CCPrepare;
@@ -930,9 +929,9 @@ typedef struct CCPrepare {
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
@@ -961,17 +960,17 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
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
@@ -980,23 +979,23 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
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
@@ -1005,7 +1004,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
        gen_helper_cc_compute_c(reg, cpu_cc_dst, cpu_cc_src,
                                cpu_cc_src2, cpu_cc_op);
        return (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                            .mask = -1, .no_setcond = true };
+                            .no_setcond = true };
     }
 }
 
@@ -1014,7 +1013,7 @@ static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
     return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                         .mask = -1, .imm = CC_P };
+                         .imm = CC_P };
 }
 
 /* compute eflags.S to reg */
@@ -1029,10 +1028,10 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
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
@@ -1048,17 +1047,16 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
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
 
@@ -1074,21 +1072,19 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
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
@@ -1116,7 +1112,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             gen_extu(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
-                               .reg2 = t0, .mask = -1, .use_reg2 = true };
+                               .reg2 = t0, .use_reg2 = true };
             break;
 
         case JCC_L:
@@ -1129,7 +1125,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             gen_exts(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
             cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
-                               .reg2 = t0, .mask = -1, .use_reg2 = true };
+                               .reg2 = t0, .use_reg2 = true };
             break;
 
         default:
@@ -1153,7 +1149,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_BE:
             gen_compute_eflags(s);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
-                               .mask = -1, .imm = CC_Z | CC_C };
+                               .imm = CC_Z | CC_C };
             break;
         case JCC_S:
             cc = gen_prepare_eflags_s(s, reg);
@@ -1168,7 +1164,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
-                               .mask = -1, .imm = CC_O };
+                               .imm = CC_O };
             break;
         default:
         case JCC_LE:
@@ -1178,7 +1174,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
-                               .mask = -1, .imm = CC_O | CC_Z };
+                               .imm = CC_O | CC_Z };
             break;
         }
         break;
@@ -1203,16 +1199,6 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
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
@@ -1231,10 +1217,6 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
 
-    if (cc.mask != -1) {
-        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
-        cc.reg = s->T0;
-    }
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
     } else {
@@ -1250,10 +1232,6 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
 
     gen_update_cc_op(s);
-    if (cc.mask != -1) {
-        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
-        cc.reg = s->T0;
-    }
     set_cc_op(s, CC_OP_DYNAMIC);
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
@@ -2518,11 +2496,6 @@ static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
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
2.43.2


