Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF504C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrf4-0006Vy-Jf; Sat, 08 Jun 2024 04:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrf0-0006Lg-88
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrey-0001b1-Ig
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y89oAmpMMJpJrCJMrNComgRidKETfKFzJFsG8GNQjw0=;
 b=gjQ8Y6V0wbr+wgYokAiCVDCsNlHOtaRzLbt0Y6U2bUSKIbNLQHtWeBzFmL7soFJ+E/oIAX
 rx9BNOLWSNSbbe0j8TMQOvZPOpraauud6vv4OhMYbFXaDUjRGgmgWROivyOpt+TEkxUNCt
 EQ81Y531KJc+HV6Ps8Qqwc4JOVIUfTc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-qKlgK2_wOe6vSR6V2kiEBQ-1; Sat, 08 Jun 2024 04:42:45 -0400
X-MC-Unique: qKlgK2_wOe6vSR6V2kiEBQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c091e4413so574408e87.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836163; x=1718440963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y89oAmpMMJpJrCJMrNComgRidKETfKFzJFsG8GNQjw0=;
 b=Kz0gVyzmivGO1DrodzYK31alMN9cOhFS4vrfy7evRRMHvQX+bjqGXQl8AjSEqf0Tsz
 nQWwerWatslJvo1Z6i3GsvYp2Dev0xrh1MrmjoFV/bfVoGRLdatmCjO+tQFTRIuL4mt6
 +oHyP6ffdoYj3v7SzWMreYeKzQa70HSuTLNK8ADPiUMO93BpwIxw695dwrIeV1Y3dpeY
 vjVE/XYaBYh6/BtmOEn+t+p90T7gPd0/d2tcq6xRldfRoGn6IzLXEqvHT1+EFZJQAudN
 6PogzjoY9HalhMgTeqp1Pk1G9gsrppnWd6SNGEzWYXcWqw2C9TITUlBH64JcoX1jH6pR
 9dwQ==
X-Gm-Message-State: AOJu0Yx869HI48AYNXuBZZhEusa/IQTc/GxvyIYH3VT+l5rZjNQP48F+
 v5ObTr1Dpm5j8pEWAuZhX3varvUsTlER7vsO33tGXsqMAwkcpN4Bn0wwm32aBDljF3bnwPe1aAO
 wMX0ki6nd+bpwNXB85lpTgqHC/07SReQ6CU/4j7hDNmcLQcdrfCQ17IONmx8zDAOSM6lPknEie3
 EDO02OAJHq8npKyyJNTFO1Q26UHx3dVjcD4rdD
X-Received: by 2002:a05:6512:3d29:b0:52b:959c:1dc7 with SMTP id
 2adb3069b0e04-52bb9fc5eadmr4604719e87.42.1717836163154; 
 Sat, 08 Jun 2024 01:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKHrz81WP2xiFpiVddh0eh54+736GE4evfMlYCqo2TTlegcY2tLEND4G4PFazZ2nfu0BgaAA==
X-Received: by 2002:a05:6512:3d29:b0:52b:959c:1dc7 with SMTP id
 2adb3069b0e04-52bb9fc5eadmr4604705e87.42.1717836162695; 
 Sat, 08 Jun 2024 01:42:42 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cccfesm356672866b.86.2024.06.08.01.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/25] target/i386: remove gen_ext_tl
Date: Sat,  8 Jun 2024 10:41:13 +0200
Message-ID: <20240608084113.2770363-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

With the introduction of tcg_gen_ext_tl, most uses can be converted directly
because they do not have a NULL destination.  tcg_gen_ext_tl is able to drop
no-ops like "tcg_gen_ext_tl(tcgv, tcgv, MO_TL)" just fine, and the only thing
that gen_ext_tl was adding on top was avoiding the creation of a useless
temporary.  This can be done in the only place where it matters, which is
gen_op_j_ecx.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ee5ef3ccbc6..8089b502628 100644
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
@@ -1048,8 +1041,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
@@ -1059,8 +1052,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
2.45.1


