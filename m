Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF15C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdj-0001K9-QQ; Sat, 08 Jun 2024 04:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdi-0001Jf-Hc
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdg-0001N0-Tb
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66RZMatbGR6oA18ZOL7a6HEImIegaXx8KnES6s66OmA=;
 b=b5zkt0IqZptrxjRLz6yJKJJqjgYuoo9PCDxqUqwZwVQmVhE/Qe5YXqY3/NaGsQ3HRPBA7V
 ncCDN9nY4LyHBdzhCFQEEeWu6JzeNcdRG33Z3z5ozVd4XuAcHCKNQwBrkOKmiap2WivfO3
 ZBRTfhUVpcc0XWN26401lHIAK0ToScc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-MmjRsU54MLuT2dtIGw7klg-1; Sat, 08 Jun 2024 04:41:26 -0400
X-MC-Unique: MmjRsU54MLuT2dtIGw7klg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-579c69260bbso1393094a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836083; x=1718440883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66RZMatbGR6oA18ZOL7a6HEImIegaXx8KnES6s66OmA=;
 b=DZMnQuxiINEw+daxHg3/Z2xzVDz07O36FhL5UFj1jgDhuzM0o2pnWDG+xMQVHqSAbv
 kVR0nQuArL3+ZCFSN6BhNr3a1I1GEfF+7Q8AVYWzVY3b3YAOfvNnsZxx8d7UBhYiXrNp
 FYVQxCwbEoaQIQ/+YH/coGRRxdgxSDjrIEj8V3lixX5v4A6395IZBpvWttYKL+LzPQeL
 zoViBFDYTWdh/yC/KLJD2Lp+PdtvWxYVLPeznjLBidh9fR0TSZTJWfr3HvDspAsntp38
 r3M0se4IAfsxYop0TmrZitCXdKe8PmEOdSsQWercG3BmwpX137uLRPT0jEuaBlS8zolj
 r1fQ==
X-Gm-Message-State: AOJu0YynEsMi1k9gctJzTFy1OGZ+C0pd09afcaUcpLxJqGGASjDRl2l0
 O2f1MhFs5W3/9mt1MztaMly3mAusOcR3P1fc2NRASTFOs4TLWVtWldnMWsUJGTdrW+YWW2CbSc7
 cAklYN08jRHRL+GJ/1izdXXCTpInt2cmZ83rqZ4yywtrkdQbkC1MnAj4t6VRhksgboieHfGFSJX
 La9kzXfJCyzlX/5zMvPuf/cd4iodU0Hshq00pL
X-Received: by 2002:a50:9308:0:b0:57c:6ba4:3d89 with SMTP id
 4fb4d7f45d1cf-57c6ba4400cmr720272a12.40.1717836083021; 
 Sat, 08 Jun 2024 01:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTp2rekmeKG0Q7LFZ5oRGO+gUbnu5OnxCzHuM1FmltYKTYw98BFVUHVjzFdS2Za8s7isC9iw==
X-Received: by 2002:a50:9308:0:b0:57c:6ba4:3d89 with SMTP id
 4fb4d7f45d1cf-57c6ba4400cmr720262a12.40.1717836082546; 
 Sat, 08 Jun 2024 01:41:22 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d064sm3931626a12.10.2024.06.08.01.41.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/25] target/i386: rewrite flags writeback for ADCX/ADOX
Date: Sat,  8 Jun 2024 10:40:50 +0200
Message-ID: <20240608084113.2770363-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

Avoid using set_cc_op() in preparation for implementing APX; treat
CC_OP_EFLAGS similar to the case where we have the "opposite" cc_op
(CC_OP_ADOX for ADCX and CC_OP_ADCX for ADOX), except the resulting
cc_op is not CC_OP_ADCOX. This is written easily as two "if"s, whose
conditions are both false for CC_OP_EFLAGS, both true for CC_OP_ADCOX,
and one each true for CC_OP_ADCX/ADOX.

The new logic also makes it easy to drop usage of tmp0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |  9 +++---
 target/i386/tcg/emit.c.inc | 61 ++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8fe28b67e0f..ee873a0ed84 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1260,6 +1260,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Use a clearer name for this.  */
 #define CPU_INTERRUPT_INIT      CPU_INTERRUPT_RESET
 
+#define CC_OP_HAS_EFLAGS(op) ((op) >= CC_OP_EFLAGS && (op) <= CC_OP_ADCOX)
+
 /* Instead of computing the condition codes after each x86 instruction,
  * QEMU just stores one operand (called CC_SRC), the result
  * (called CC_DST) and the type of operation (called CC_OP). When the
@@ -1270,6 +1272,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 typedef enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_EFLAGS,  /* all cc are explicitly computed, CC_SRC = flags */
+    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX, /* CC_DST = O, CC_SRC = rest.  */
+    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1326,10 +1331,6 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
-    CC_OP_ADOX, /* CC_DST = O, CC_SRC = rest.  */
-    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
-
     CC_OP_CLR, /* Z set, all other flags clear.  */
     CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index df7597c7e2f..2041ea9d04a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1122,24 +1122,41 @@ static void gen_ADC(DisasContext *s, X86DecodedInsn *decode)
     prepare_update3_cc(decode, s, CC_OP_ADCB + ot, c_in);
 }
 
-/* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
-static void gen_ADCOX(DisasContext *s, MemOp ot, int cc_op)
+static void gen_ADCOX(DisasContext *s, X86DecodedInsn *decode, int cc_op)
 {
-    int opposite_cc_op;
+    MemOp ot = decode->op[0].ot;
     TCGv carry_in = NULL;
-    TCGv carry_out = (cc_op == CC_OP_ADCX ? cpu_cc_dst : cpu_cc_src2);
+    TCGv *carry_out = (cc_op == CC_OP_ADCX ? &decode->cc_dst : &decode->cc_src2);
     TCGv zero;
 
-    if (cc_op == s->cc_op || s->cc_op == CC_OP_ADCOX) {
-        /* Re-use the carry-out from a previous round.  */
-        carry_in = carry_out;
-    } else {
-        /* We don't have a carry-in, get it out of EFLAGS.  */
-        if (s->cc_op != CC_OP_ADCX && s->cc_op != CC_OP_ADOX) {
-            gen_compute_eflags(s);
+    decode->cc_op = cc_op;
+    *carry_out = tcg_temp_new();
+    if (CC_OP_HAS_EFLAGS(s->cc_op)) {
+        decode->cc_src = cpu_cc_src;
+
+        /* Re-use the carry-out from a previous round?  */
+        if (s->cc_op == cc_op || s->cc_op == CC_OP_ADCOX) {
+            carry_in = (cc_op == CC_OP_ADCX ? cpu_cc_dst : cpu_cc_src2);
         }
-        carry_in = s->tmp0;
-        tcg_gen_extract_tl(carry_in, cpu_cc_src,
+
+        /* Preserve the opposite carry from previous rounds?  */
+        if (s->cc_op != cc_op && s->cc_op != CC_OP_EFLAGS) {
+            decode->cc_op = CC_OP_ADCOX;
+            if (carry_out == &decode->cc_dst) {
+                decode->cc_src2 = cpu_cc_src2;
+            } else {
+                decode->cc_dst = cpu_cc_dst;
+            }
+        }
+    } else {
+        decode->cc_src = tcg_temp_new();
+        gen_mov_eflags(s, decode->cc_src);
+    }
+
+    if (!carry_in) {
+        /* Get carry_in out of EFLAGS.  */
+        carry_in = tcg_temp_new();
+        tcg_gen_extract_tl(carry_in, decode->cc_src,
             ctz32(cc_op == CC_OP_ADCX ? CC_C : CC_O), 1);
     }
 
@@ -1151,28 +1168,20 @@ static void gen_ADCOX(DisasContext *s, MemOp ot, int cc_op)
         tcg_gen_ext32u_tl(s->T1, s->T1);
         tcg_gen_add_i64(s->T0, s->T0, s->T1);
         tcg_gen_add_i64(s->T0, s->T0, carry_in);
-        tcg_gen_shri_i64(carry_out, s->T0, 32);
+        tcg_gen_shri_i64(*carry_out, s->T0, 32);
         break;
 #endif
     default:
         zero = tcg_constant_tl(0);
-        tcg_gen_add2_tl(s->T0, carry_out, s->T0, zero, carry_in, zero);
-        tcg_gen_add2_tl(s->T0, carry_out, s->T0, carry_out, s->T1, zero);
+        tcg_gen_add2_tl(s->T0, *carry_out, s->T0, zero, carry_in, zero);
+        tcg_gen_add2_tl(s->T0, *carry_out, s->T0, *carry_out, s->T1, zero);
         break;
     }
-
-    opposite_cc_op = cc_op == CC_OP_ADCX ? CC_OP_ADOX : CC_OP_ADCX;
-    if (s->cc_op == CC_OP_ADCOX || s->cc_op == opposite_cc_op) {
-        /* Merge with the carry-out from the opposite instruction.  */
-        set_cc_op(s, CC_OP_ADCOX);
-    } else {
-        set_cc_op(s, cc_op);
-    }
 }
 
 static void gen_ADCX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADCX);
+    gen_ADCOX(s, decode, CC_OP_ADCX);
 }
 
 static void gen_ADD(DisasContext *s, X86DecodedInsn *decode)
@@ -1190,7 +1199,7 @@ static void gen_ADD(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_ADOX(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_ADCOX(s, decode->op[0].ot, CC_OP_ADOX);
+    gen_ADCOX(s, decode, CC_OP_ADOX);
 }
 
 static void gen_AND(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


