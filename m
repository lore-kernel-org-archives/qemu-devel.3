Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33207D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG6-0003Wx-9s; Sun, 20 Oct 2024 11:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFi-0003NH-Jj
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFf-0005Pi-JF
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZG7pDim8gIa7OEsfLMhqCQMQAwzlje+SQX3YGIdJRk4=;
 b=fvNrf7e0pW7H/eXr1uBpVM6J+3NUDjtauXAImnZr0Sgpjulqs+RMLZJnLG0xhmLS9Ws4Fs
 CWTzhIscq0ALrsigDpF5BBoLcq5KPzbyBhYMDBmkb3VB583TcWMbfCHvXiQwVXVHAWZ+fy
 BckwSXwWH1uEQJ6g2FBGCuiT4omoJEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-oou1QCbyPVuykxrT6N1Jpw-1; Sun, 20 Oct 2024 11:53:39 -0400
X-MC-Unique: oou1QCbyPVuykxrT6N1Jpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso24230505e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439616; x=1730044416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZG7pDim8gIa7OEsfLMhqCQMQAwzlje+SQX3YGIdJRk4=;
 b=NkgzXMYQL+VeziNy0pzUlaYpD1Lk1X1la4LfHHZYWrxbIQg9UVNeNcdaH3r2AQR34U
 MxYQ3IT5XnD+vAfTDEAmzVPytM8GgZ0uzFd5qNaJzWzH2q7zcoRnlYpQNjOXqsavJ/u4
 Zdx+CJt8ec5XtAWalTBN1cfzu2Df/2cTZ5lW3zIcVIZdS1DonzWwozp4/AGHpVEProPJ
 rpWE5Q/YbmbWrIVJVXl+a+SwxlVzD+sGTmgHJ1GEqvoUFh88rorcYFgYUUixpzNoZcXd
 eg8OYOcPW2TwbV5mBUlrPQ8Ook8nXuLD/aG4UGjZd0lolBJ8NXd93EjktKQs32cVUnaV
 B5kQ==
X-Gm-Message-State: AOJu0Yxw037bJVniwfQI/76b1D86n/i+T2JQ0Rq5U1jOJGs5a++VaNH4
 PkKVbYtE+iMpVCq39pbmUnw3ElcmU81xDOVbEZx9Sjv21HdeSA8KCB1CoYNUzIwL4LydMl/5Rju
 QGONBY9kt6nqz3gtjbDRlkqDXV5JiH0iMBQFvUPdPbzLQatysDlXr/d50Un8ft7ucxfOSGKK/NS
 xeU7uVckwSHwsIf04gllhG0aUwxq1CWuPBVkxa0eY=
X-Received: by 2002:a05:600c:c89:b0:431:5c1c:250b with SMTP id
 5b1f17b1804b1-43161633321mr70622655e9.1.1729439616474; 
 Sun, 20 Oct 2024 08:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkachAWDb3R5jKP+xQSpQUj5WQCI4H1d2THyn09b/y6GSBk3CTXpj3MmloHeRBMBjAFFXT0g==
X-Received: by 2002:a05:600c:c89:b0:431:5c1c:250b with SMTP id
 5b1f17b1804b1-43161633321mr70622455e9.1.1729439615860; 
 Sun, 20 Oct 2024 08:53:35 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57112esm27392755e9.6.2024.10.20.08.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 03/14] target/i386: remove CC_OP_CLR
Date: Sun, 20 Oct 2024 17:53:13 +0200
Message-ID: <20241020155324.35273-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Just use CC_OP_EFLAGS; it is not that likely that the flags computed by
CC_OP_CLR survive the end of the basic block, in which case there is no
need to spill cc_op_src.

cc_op_src now does need spilling if the XOR is followed by a memory
operation, but this only costs 0.2% extra TCG ops.  They will be recouped
by simplifications in how QEMU evaluates ZF at runtime, which are even
greater with this change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  1 -
 target/i386/cpu-dump.c      |  1 -
 target/i386/tcg/cc_helper.c |  3 ---
 target/i386/tcg/translate.c | 10 ----------
 target/i386/tcg/emit.c.inc  | 15 ++++-----------
 5 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580f..567fefa1d7b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1283,7 +1283,6 @@ typedef enum {
     CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
     CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
-    CC_OP_CLR, /* Z and P set, all other flags clear.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index dc6723aedee..a72ed93bd2f 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -91,7 +91,6 @@ static const char * const cc_op_str[] = {
     [CC_OP_BMILGQ] = "BMILGQ",
 
     [CC_OP_POPCNT] = "POPCNT",
-    [CC_OP_CLR] = "CLR",
 };
 
 static void
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index dbddaa2fcb3..40583c04cf9 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -104,8 +104,6 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
 
     case CC_OP_EFLAGS:
         return src1;
-    case CC_OP_CLR:
-        return CC_Z | CC_P;
     case CC_OP_POPCNT:
         return dst ? 0 : CC_Z;
 
@@ -243,7 +241,6 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_LOGICW:
     case CC_OP_LOGICL:
     case CC_OP_LOGICQ:
-    case CC_OP_CLR:
     case CC_OP_POPCNT:
         return 0;
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dc308f31041..a20fbb019c8 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -309,7 +309,6 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
-    [CC_OP_CLR] = 0,
     [CC_OP_POPCNT] = USES_CC_DST,
 };
 
@@ -803,10 +802,6 @@ static void gen_mov_eflags(DisasContext *s, TCGv reg)
         tcg_gen_mov_tl(reg, cpu_cc_src);
         return;
     }
-    if (s->cc_op == CC_OP_CLR) {
-        tcg_gen_movi_tl(reg, CC_Z | CC_P);
-        return;
-    }
 
     dst = cpu_cc_dst;
     src1 = cpu_cc_src;
@@ -897,7 +892,6 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
-    case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
 
@@ -969,7 +963,6 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_S };
-    case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     default:
@@ -988,7 +981,6 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src2,
                              .no_setcond = true };
-    case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     case CC_OP_MULB ... CC_OP_MULQ:
@@ -1013,8 +1005,6 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_Z };
-    case CC_OP_CLR:
-        return (CCPrepare) { .cond = TCG_COND_ALWAYS };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fd17a9b1eca..790307dbba8 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1452,19 +1452,12 @@ static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv
      * C is the result of the test, Z is unchanged, and the others
      * are all undefined.
      */
-    switch (s->cc_op) {
-    case CC_OP_DYNAMIC:
-    case CC_OP_CLR:
-    case CC_OP_EFLAGS:
-    case CC_OP_ADCX:
-    case CC_OP_ADOX:
-    case CC_OP_ADCOX:
+    if (s->cc_op == CC_OP_DYNAMIC || CC_OP_HAS_EFLAGS(s->cc_op)) {
         /* Generate EFLAGS and replace the C bit.  */
         cf = tcg_temp_new();
         tcg_gen_setcond_tl(TCG_COND_TSTNE, cf, src, mask);
         prepare_update_cf(decode, s, cf);
-        break;
-    default:
+    } else {
         /*
          * Z was going to be computed from the non-zero status of CC_DST.
          * We can get that same Z value (and the new C value) by leaving
@@ -1475,7 +1468,6 @@ static void gen_bt_flags(DisasContext *s, X86DecodedInsn *decode, TCGv src, TCGv
         decode->cc_dst = cpu_cc_dst;
         decode->cc_op = ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB;
         tcg_gen_shr_tl(decode->cc_src, src, s->T1);
-        break;
     }
 }
 
@@ -4724,7 +4716,8 @@ static void gen_XOR(DisasContext *s, X86DecodedInsn *decode)
         decode->op[2].unit == X86_OP_INT &&
         decode->op[1].n == decode->op[2].n) {
         tcg_gen_movi_tl(s->T0, 0);
-        decode->cc_op = CC_OP_CLR;
+        decode->cc_op = CC_OP_EFLAGS;
+        decode->cc_src = tcg_constant_tl(CC_Z | CC_P);
     } else {
         MemOp ot = decode->op[1].ot;
 
-- 
2.46.2


