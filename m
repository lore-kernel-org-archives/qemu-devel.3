Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEABFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUV-0004b5-ID; Tue, 07 May 2024 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUR-0004Yj-RT
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUP-0002WP-Gp
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9ortWfv584lxxmsMIWihvg3kGQaWQkicwj3fJ5Ld9A=;
 b=AxLOl59QqgwshfQOvTL062pmqC59yKKq38Y3z3MHUtTnSGUvUQqHWf+OflT3HGPSV9GJUh
 D6fRgJwaiCyKsnUv1onmjVM6vt2s4ES8PNqTF8JESZfyyAsvb7S0SwzuOi6m45gEIRxX7E
 5K62/rVndgVZDRtZgEj2saVh6xf+teY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-mLIaGZY6PaujKB2LB7IKPw-1; Tue, 07 May 2024 06:56:03 -0400
X-MC-Unique: mLIaGZY6PaujKB2LB7IKPw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572afd6e96fso1157748a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079361; x=1715684161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9ortWfv584lxxmsMIWihvg3kGQaWQkicwj3fJ5Ld9A=;
 b=dSXl47iM37rjqP8D6ik5qTBSVD8o9vSqHp8f51Zk+w/TU5wbe1KnFVPmm++N7OCyfY
 bvvYg3WUB4e20N/pnv5Kkbm5uk/bCltOcL5cWtDqJET5g6SbwTRaiUn/8QuRq35stdI5
 eL+3C1g1W4StzdXroU8myRNkmlDOM/9lt5IK36IkwTMiu68vsdaxRyC3Nr/7DZ1b/F4H
 dXMTMDV+mugJdUHNrTqsFTb9FLtM4+gLr3dgqMhSeeErmzpU8TSshlb0MniP+fpLhb6l
 0bK5Ei0IHUYzn8RUh54RsuOrSWDe4+RThxnZ8Nr+VL+k4uBMWWSxKsPxtnOOkDNUQ1UL
 6LPA==
X-Gm-Message-State: AOJu0YxetDG+vcjTSsIpnSEtSWqROHaFtG2lUKIES7RNuK2WD751RQKy
 y2OnjRvgpZ927K3JZvjqXFaUolo+mT8lsvIfsTAUJFrcuSlGPKyyachuF6gLOw6BmFeE4WHGaXs
 ZtsR8HnORr1PBcmI6EChEwRhoDHIO3FOWEoaRAgNbWB2/TQ3pLK8FbORdH5gwO0neZb022fTbN/
 4k22erD36TwQZPhggtvVoE0fct9mcqAFek1QQ1
X-Received: by 2002:a50:8d5a:0:b0:56e:7722:553 with SMTP id
 t26-20020a508d5a000000b0056e77220553mr12031362edt.24.1715079361589; 
 Tue, 07 May 2024 03:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjYLwznJkvM2TgjZVM+ZvGWgQEsh0o3IZKqbRvp9WGfRrJlQ0+anJ3jC91qxxToMkgUlncpQ==
X-Received: by 2002:a50:8d5a:0:b0:56e:7722:553 with SMTP id
 t26-20020a508d5a000000b0056e77220553mr12031348edt.24.1715079361219; 
 Tue, 07 May 2024 03:56:01 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a056402088f00b0057232df2e5dsm6252894edy.32.2024.05.07.03.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/26] target/i386: extend cc_* when using them to compute flags
Date: Tue,  7 May 2024 12:55:20 +0200
Message-ID: <20240507105538.180704-9-pbonzini@redhat.com>
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

Instead of using s->tmp0 or s->tmp4 as the result, just extend the cc_*
registers in place.  It is harmless and, if multiple setcc instructions
are used, the optimizer will be able to remove the redundant ones.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 44 +++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 024da6d88eb..7292908adc3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -940,28 +940,24 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
 /* compute eflags.C to reg */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
-    TCGv t0, t1;
     MemOp size;
 
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        /* If no temporary was used, be careful not to alias t1 and t0.  */
-        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
-        tcg_gen_mov_tl(t0, s->cc_srcT);
-        gen_extu(size, t0);
-        goto add_sub;
+        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
+                             .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
-    add_sub:
-        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
-                             .reg2 = t1, .use_reg2 = true };
+        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
+                             .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_CLR:
@@ -984,8 +980,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        t0 = gen_ext_tl(reg, cpu_cc_src, size, false);
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0 };
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
 
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
@@ -1098,7 +1094,6 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     int inv, jcc_op, cond;
     MemOp size;
     CCPrepare cc;
-    TCGv t0;
 
     inv = b & 1;
     jcc_op = (b >> 1) & 7;
@@ -1109,24 +1104,21 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_extu(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
+            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
+                               .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-
         case JCC_L:
             cond = TCG_COND_LT;
             goto fast_jcc_l;
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_exts(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
-            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
+            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
+                               .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
 
         default:
-- 
2.45.0


