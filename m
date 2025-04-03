Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4074EC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gn1-0006ds-3R; Thu, 03 Apr 2025 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gmw-0006cn-Vu
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0Gms-0007pM-Me
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743672180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3FMJOXnaYIhu0KflEBHXaK67YWu7zHzWCQTPN7Gr5E=;
 b=cD6Fd0STIC073YpqcQIStBqta/dyglyJVPtSXyW16qzQhlcKzIRzjF6ngd9opFSEeObm9U
 XmRB5U26tvwWr58Fl6FoHuQV3wM90LkALFxh3nAI9cnM5pQsvT5TFstmDhbP/9DFJU0UYn
 3wPeLyJSOLx6w+lkKAx+V19AlojX1aI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-RsBb_AcVOZSmIjaiNzaAOw-1; Thu, 03 Apr 2025 05:22:57 -0400
X-MC-Unique: RsBb_AcVOZSmIjaiNzaAOw-1
X-Mimecast-MFC-AGG-ID: RsBb_AcVOZSmIjaiNzaAOw_1743672176
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac28a2c7c48so66422566b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743672175; x=1744276975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3FMJOXnaYIhu0KflEBHXaK67YWu7zHzWCQTPN7Gr5E=;
 b=mWy99q51utpMZN59GAUttpOl0iOEjSz614F2KrY1fLWEw+lVk10IupKP3CTWOmZXPg
 YRnPHAZaoIWV50nat0ThVPSsJ+8L9N7+qEKRUOzcCpwfIt1bbCKpFYXgURucZsxL4J/M
 88qoc9t9sujz5gKGODKlwkbnICIT+kvgkAv9zeLBHDVl2cAGzWWlXIa4e0xsdHQ6OR5p
 4Gi5oYV/8n5AXhs1tG65BBIVZs/6UyjD3PcNwakFTBTaoGu5XnB3okR5IM7hTJVXZbID
 xeKu/MjuZKqiEJntbO40sew64R2349gjpVcePLgQ51gWzOt7dqsRBPwJmqAM+y/UOgVq
 cKMQ==
X-Gm-Message-State: AOJu0Yw5UM9bYaKkE1V3zug9XULuQ+iXbt9nHzEd77uWLLqb4AAGP/oV
 jWViy2wIfAiZ76KI+Wf30gQmO5Y7y1Qe73814SVw59CN2+lW7uNwLH0NHAr3oJ/RHigDKqyKR6P
 FZRrgx7bN7N4RXkFmpj11f6+pz0aO0VJEGYPlCkTlM2jE15JV1LPcVotU6HAmBf3KodzWZ6uqQp
 ub6ppjT57G4QbxRwd0r0I2BbcjLVTZPiD+A8lu
X-Gm-Gg: ASbGnculSvHFI2TiN36sStxbYHfTZiXQyxBd1+JFmSnVCCm6FuiXp2tLzV9O2grcFnu
 PJX5gulOSQTYAfK+UjJsEpX8EfgZ0Ag1/w7+xJedZ5JCoVUytSCKay1tj/Y3A7FcqzRzIGOu8rm
 RhBH9fSZFbVDL9EyWDl0JwPTzvp+F7YUE5jkc3lLXdIk+Rb7ZWTVAyyuDXg6/JmO4CDKIW28MO9
 XgPzLJMdX39pwTlxosAl04ckMhGmjhsoHWg9Mx6xNjNzz7R+NrKuALdoeq9tng9mpH8m/ynv3Os
 ZLgIIlYyhBzY8duumS4d
X-Received: by 2002:a17:907:7285:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-ac7bc15f3edmr164243866b.32.1743672175488; 
 Thu, 03 Apr 2025 02:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESE37uhPjCEff3vSNFhKAFZI0Iwp4LMf9UhcE7eCyRRPUdXAw+n+zq2W9TRwZ97NKuE1ncfw==
X-Received: by 2002:a17:907:7285:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-ac7bc15f3edmr164242466b.32.1743672174912; 
 Thu, 03 Apr 2025 02:22:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f2f4sm62594666b.108.2025.04.03.02.22.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:22:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/i386: special case ADC/SBB x,0 and SBB x,x
Date: Thu,  3 Apr 2025 11:22:47 +0200
Message-ID: <20250403092251.54441-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403092251.54441-1-pbonzini@redhat.com>
References: <20250403092251.54441-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Avoid the three-operand CC_OP_ADD and CC_OP_ADC in these relatively
common cases.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 ++++++++++++
 target/i386/tcg/emit.c.inc  | 65 ++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487aa..aee33428989 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1183,6 +1183,26 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     return cc;
 }
 
+static void gen_neg_setcc(DisasContext *s, int b, TCGv reg)
+{
+    CCPrepare cc = gen_prepare_cc(s, b, reg);
+
+    if (cc.no_setcond) {
+        if (cc.cond == TCG_COND_EQ) {
+            tcg_gen_addi_tl(reg, cc.reg, -1);
+        } else {
+            tcg_gen_neg_tl(reg, cc.reg);
+        }
+        return;
+    }
+
+    if (cc.use_reg2) {
+        tcg_gen_negsetcond_tl(cc.cond, reg, cc.reg, cc.reg2);
+    } else {
+        tcg_gen_negsetcondi_tl(cc.cond, reg, cc.reg, cc.imm);
+    }
+}
+
 static void gen_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24f..76cd7f00308 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1170,11 +1170,28 @@ static void gen_AAS(DisasContext *s, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
+static void gen_ADD(DisasContext *s, X86DecodedInsn *decode);
 static void gen_ADC(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    TCGv c_in = tcg_temp_new();
+    TCGv c_in;
 
+    /*
+     * Try to avoid CC_OP_ADC.  The definition of ADD and ADC is different
+     * for AF and OF: CC_OP_ADC would make the second source argument 0 and
+     * the incoming carry would not be taken into account; whereas with ADD
+     * the second source argument is the incoming carry (c_in).  However it does
+     * not matter here:
+     * - for AF, only bit 4 matters and it's zero for both 0 and c_in
+     * - for OF, only the sign bit matters and it's zero for both 0 and c_in
+     */
+    if (decode->e.op2 == X86_TYPE_I && decode->immediate == 0) {
+        gen_compute_eflags_c(s, s->T1);
+        gen_ADD(s, decode);
+        return;
+    }
+
+    c_in = tcg_temp_new();
     gen_compute_eflags_c(s, c_in);
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, c_in, s->T1);
@@ -3830,22 +3847,60 @@ static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
     TCGv c_in = tcg_temp_new();
 
+    /*
+     * Try to avoid CC_OP_SBB.  The definition of SUB and SBB is different
+     * for AF and OF: CC_OP_SBB would make the second source argument 0 and
+     * the incoming carry would not be taken into account; whereas with SUB
+     * the second source argument is the incoming carry (c_in).  However it does
+     * not matter here:
+     * - for AF, only bit 4 matters and it's zero for both 0 and c_in
+     * - for OF, only the sign bit matters and it's zero for both 0 and c_in
+     */
+    if (decode->e.op2 == X86_TYPE_I && decode->immediate == 0) {
+        gen_compute_eflags_c(s, s->T1);
+        gen_SUB(s, decode);
+        return;
+    }
+
     gen_compute_eflags_c(s, c_in);
+
+    /*
+     * Here, src1 is changed from T0 to 0, and src2 is changed from T1 to c_in
+     * (and T0 = T1).  AF and OF are unaffected because:
+     * - for AF, only bit 4 of src1^src2 matters, and it's zero for both
+     *   T0^T1 and 0^c_in
+     * - for OF, the sign bit of both T0^T1 and 0^c_in is zero, so there can
+     *   be no overflow.
+     */
+    if (decode->e.op2 != X86_TYPE_I && !decode->op[0].has_ea && decode->op[0].n == decode->op[2].n) {
+        if (s->cc_op == CC_OP_DYNAMIC) {
+            tcg_gen_neg_tl(s->T0, c_in);
+        } else {
+            /*
+             * Do not negate c_in because it will often be dead and only the
+             * instruction generated by negsetcond will survive.
+             */
+            gen_neg_setcc(s, JCC_B << 1, s->T0);
+        }
+        tcg_gen_movi_tl(s->cc_srcT, 0);
+        decode->cc_src = c_in;
+        decode->cc_dst = s->T0;
+        decode->cc_op = CC_OP_SUBB + ot;
+        return;
+    }
+
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, s->T1, c_in);
         tcg_gen_neg_tl(s->T0, s->T0);
         tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
                                     s->mem_index, ot | MO_LE);
     } else {
-        /*
-         * TODO: SBB reg, reg could use gen_prepare_eflags_c followed by
-         * negsetcond, and CC_OP_SUBB as the cc_op.
-         */
         tcg_gen_sub_tl(s->T0, s->T0, s->T1);
         tcg_gen_sub_tl(s->T0, s->T0, c_in);
     }
-- 
2.49.0


