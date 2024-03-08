Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4659AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribeT-0003fY-IS; Fri, 08 Mar 2024 09:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe8-0003LS-Ht
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdz-0005VH-NC
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjw8zi9dZOFQVHo23DU2FKCgNcnZ27yeYMAa0tZsIGg=;
 b=Hkd7v0/4VC5Qt40Ik15aPX5eVcZDSd1Fbth1GQbg5NxEnv0fqAhD3EA+Ytz5yDMYzpI/td
 ZV3Ujq69wi+od3AHeLvPfUS6ACcC0W/dBi4jVTngdskh7tWbOoIAaYlBNT20r4QTdeI3j8
 XiNlDJPvhhXkvRV6WC5jv2FtvcPG9F8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-TmlILwM4O16dc8x4ct_96Q-1; Fri, 08 Mar 2024 09:56:17 -0500
X-MC-Unique: TmlILwM4O16dc8x4ct_96Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5683081bf4eso419868a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909774; x=1710514574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjw8zi9dZOFQVHo23DU2FKCgNcnZ27yeYMAa0tZsIGg=;
 b=i0L6M/KUsgZgCD3oOTljt3dpde2Opg3ap/jsuRcefI+qAeVKs2wmwejwrDoFxF8BAx
 4dHrbobpp8U9c4Vx+yPrAoCicRpdKFNGpD4x5Qa5tExibbP9NEaKa5s6M38wvn/naMBa
 AYIIwoYRe13RH4B68TkHFoBMv9IgSrecxfmeDGf907JK98JBeBlEukTgmgzElNyAReOv
 uW+fQdbbDGeisZOzPIPH1r+TnQRNPFVOqQYveJb37QYtax5dgGncsbVKkOW6n7QLqBxC
 gJenXZlywnCfOJDcGWu6q4jaPc5kqpnpF3y8jmlVrHWuBp1dZgLPZHCf/qKkOmWWGeAH
 GvQA==
X-Gm-Message-State: AOJu0YzntHN+D8dm1luY4j5CfjMoUn+nzUbZb8sHT+UD6A4/2KzqgVUO
 r5XdFPvNMJ59yNJjU2WC2OBSBtOeFAZ7npWrmP3mh18kHoY/pF5wDNyZwBtg5Gq0Qaw29TWL7UC
 wEpI5ALY9YepzL/HRtkR1nK7IqI4odBBqJhmUxQwVX2iy2+qMBJVS4GG52G/h0iS32CpIY+doyI
 i0g0g7cXiHSjCVUYCutpP80jJG4ApQLdaqQgyl
X-Received: by 2002:a50:ab55:0:b0:567:2870:1f1c with SMTP id
 t21-20020a50ab55000000b0056728701f1cmr2221156edc.19.1709909774433; 
 Fri, 08 Mar 2024 06:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECs8xfPFt5i9emABngjaUgDtqpL6VffBofNl2urdu7WqVMNanB2iL2j43p/QdrrJxB0ToSZw==
X-Received: by 2002:a50:ab55:0:b0:567:2870:1f1c with SMTP id
 t21-20020a50ab55000000b0056728701f1cmr2221147edc.19.1709909774139; 
 Fri, 08 Mar 2024 06:56:14 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 ig10-20020a056402458a00b005657eefa8e9sm9256518edb.4.2024.03.08.06.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/12] target/i386: use TSTEQ/TSTNE to test low bits
Date: Fri,  8 Mar 2024 15:55:50 +0100
Message-ID: <20240308145554.599614-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When testing the sign bit or equality to zero of a partial register, it
is useful to use a single TSTEQ or TSTNE operation.  It can also be used
to test the parity flag, using bit 0 of the population count.

Do not do this for target_ulong-sized values however; the optimizer would
produce a comparison against zero anyway, and it avoids shifts by 64
which are undefined behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 ++++++++++++++++++++--------
 target/i386/tcg/emit.c.inc  |  5 ++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e9..fe9021833e3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -927,11 +927,21 @@ typedef struct CCPrepare {
     bool no_setcond;
 } CCPrepare;
 
+static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
+{
+    if (size == MO_TL) {
+        return (CCPrepare) { .cond = TCG_COND_LT, .reg = src, .mask = -1 };
+    } else {
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src, .mask = -1,
+                             .imm = 1ull << ((8 << size) - 1) };
+    }
+}
+
 /* compute eflags.C to reg */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
     TCGv t0, t1;
-    int size, shift;
+    MemOp size;
 
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
@@ -966,9 +976,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = s->cc_op - CC_OP_SHLB;
-        shift = (8 << size) - 1;
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = (target_ulong)1 << shift };
+        return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE,
@@ -1028,8 +1036,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
-            return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
+            return gen_prepare_sign_nz(cpu_cc_dst, size);
         }
     }
 }
@@ -1076,8 +1083,13 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
-            return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
+            if (size == MO_TL) {
+                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
+                                     .mask = -1 };
+            } else {
+                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
+                                     .mask = -1, .imm = (1ull << (8 << size)) - 1 };
+            }
         }
     }
 }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 6bcf88ecd71..0e00f6635dd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1209,7 +1209,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
         [JCC_Z] = TCG_COND_EQ,
         [JCC_BE] = TCG_COND_LEU,
         [JCC_S] = TCG_COND_LT,  /* test sign bit by comparing against 0 */
-        [JCC_P] = TCG_COND_EQ,  /* even parity - tests low bit of popcount */
+        [JCC_P] = TCG_COND_TSTEQ,  /* even parity - tests low bit of popcount */
         [JCC_L] = TCG_COND_LT,
         [JCC_LE] = TCG_COND_LE,
     };
@@ -1260,8 +1260,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     case JCC_P:
         tcg_gen_ext8u_tl(s->tmp0, s->T0);
         tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
-        tcg_gen_andi_tl(s->tmp0, s->tmp0, 1);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(1);
         break;
 
     case JCC_S:
-- 
2.43.2


