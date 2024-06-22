Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E60C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3O-0000S2-OW; Sat, 22 Jun 2024 02:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3D-0000LY-9T
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3B-0006TZ-HV
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbIvh5b7KQ5TRyXSWuEts9KNlhisXZ5PWf3o2CP+6Cg=;
 b=ReBikAabhFNQeU953TyqoixA/+yst0Tx5nVsXf07DD0ckh5zcJ4CbMifkt8g4WHYiLS3nf
 WbSwu/Iw9wiFW4cXkEZmwhN/T0nOWyMBin4kfyYuCgcaSoO02NIi8CLscryAfVnI5dJpnM
 ORW6yJjFEn+qWZugUhKCJqpbsCyLTgM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-rbd-Q8ZHPWW6r38t1A__GQ-1; Sat, 22 Jun 2024 02:16:31 -0400
X-MC-Unique: rbd-Q8ZHPWW6r38t1A__GQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a706f279c56so4974766b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036989; x=1719641789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbIvh5b7KQ5TRyXSWuEts9KNlhisXZ5PWf3o2CP+6Cg=;
 b=R0pOGoeO1vb+TsjbJy1+bMDv4BjWTwzhgy8o8hbvWhRcdPxDSie9aQSRu9vzv6zFq3
 8GrVuPiu791h2ZXv7jcbxZqnXlI700gg/euKWDmPJlBjTc+RvkVB5y0GHXxi5XBjGS84
 MxYnlFvqz0H67dTvGhqWGUQZ8lalB2iMQIFu7puIX0G1SViBHCSYpJnjBxUIDEAkSyGc
 +NqZ4dut43p5DTlbKD8e1lLysEKCvUGXYD88Y1Mo4Ybiz5F8nOx6kZOKEGA8rgKiyhME
 YqmIb6XQw4e6r8qHCgd3ZnZfT3pqhABi0CTlNtBTtDb59KkTsg6eKAdVZaatBa4OGBsc
 XP7Q==
X-Gm-Message-State: AOJu0YwiM2fv983w+yHrXXdkTYmZ5Np/6ksZL385xuaBvS1lxrTkJJKK
 JazACet2hIRHVGR0lafoXMRxDiEEQPD0tAwkhOlRofRX+NO1y+pkUxtXqaNVB2k6X6aaFqoeYyM
 EcuzeHj3XUoIEUd9a8Bz+6fsJLP1dIHg5nfv7KdOYwjpDXfdaphq/p7DnH86w6Qd5AicUtpgF8D
 25UBDjyxJwok+tvf3oqEDr+Vwjx2zHUxGnaSE7
X-Received: by 2002:a17:907:9693:b0:a6f:8a1b:9964 with SMTP id
 a640c23a62f3a-a6fab77570dmr722242566b.57.1719036989120; 
 Fri, 21 Jun 2024 23:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnXOPBapSQIZ7BKnYELPDD/fHOrwfdh0+Uj9GEGuQsRnh5wInTqAolDFxvVIQDUR90Gfj6TA==
X-Received: by 2002:a17:907:9693:b0:a6f:8a1b:9964 with SMTP id
 a640c23a62f3a-a6fab77570dmr722241166b.57.1719036988763; 
 Fri, 21 Jun 2024 23:16:28 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a707a0e4a52sm18620366b.87.2024.06.21.23.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/23] target/i386: remove gen_ext_tl
Date: Sat, 22 Jun 2024 08:15:46 +0200
Message-ID: <20240622061558.530543-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

With the introduction of tcg_gen_ext_tl, most uses can be converted directly
because they do not have a NULL destination.  tcg_gen_ext_tl is able to drop
no-ops like "tcg_gen_ext_tl(tcgv, tcgv, MO_TL)" just fine, and the only thing
that gen_ext_tl was adding on top was avoiding the creation of a useless
temporary.  This can be done in the only place where it matters, which is
gen_op_j_ecx.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d11c5e1dc13..5c9c992400e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -697,23 +697,16 @@ static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
     return dshift;
 };
 
-static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
-{
-    if (size == MO_TL) {
-        return src;
-    }
-    if (!dst) {
-        dst = tcg_temp_new();
-    }
-    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
-    return dst;
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
-
-    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
+    TCGv lhs;
+    if (s->aflag == MO_TL) {
+        lhs = cpu_regs[R_ECX];
+    } else {
+        lhs = tcg_temp_new();
+        tcg_gen_ext_tl(lhs, cpu_regs[R_ECX], s->aflag);
+    }
+    tcg_gen_brcondi_tl(cond, lhs, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
@@ -886,16 +879,16 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
@@ -920,7 +913,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
 
     case CC_OP_ADCX:
@@ -1050,8 +1043,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
@@ -1061,8 +1054,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-- 
2.45.2


