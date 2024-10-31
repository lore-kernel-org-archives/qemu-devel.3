Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FC7D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNo-000548-OX; Thu, 31 Oct 2024 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMO-00023v-UB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMM-0007PJ-RY
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t75bptLQuFWStBAgd/QlETVlY++DUQbSAXj2IgGFOHM=;
 b=NoKQPhiX6xKONZe/RyoelPAhmvY7wVbAAgFddjF2Flg0/dijMGDnrOi27asWCX4B46zwD6
 b1QNjqa0C+hq1xnaHbpGXOQX4EcdXwwLx621Vahy+WkgGXcPiHxz0wCJ0MbHlQrIExdI5k
 4gbR1VeZZKTM03MvHKpB42zgksjvXZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-3vVPqS0CPrm7BjdeeZb6uA-1; Thu, 31 Oct 2024 13:53:25 -0400
X-MC-Unique: 3vVPqS0CPrm7BjdeeZb6uA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so7505985e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397203; x=1731002003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t75bptLQuFWStBAgd/QlETVlY++DUQbSAXj2IgGFOHM=;
 b=NrnMVCBQpFImiGPWnQkE6hz0Wu6xUFKkVPGhUDxoDKOo+KbtKyHt8x1g/r0Rph3gtc
 rq3JJNiZ+unF7LwMcl1hlF58N1jj17yp8UV+EE5P8CB4korwUyxe6mv3K/K8aPTZZqBh
 gNiWwKiyXqpiRiQLjr1H+Z04OzcgiFAn0/2rd1DqhKXf2ZdLjrtbJP00qsNORAQEulnu
 O8KPyZCb06I3YsmxeqkQmcpy22uclr3Vs457Lzp7vTV2rkrcgrItu2JLOxhewc7InRtG
 WfEqztzYlEpQDGZqeCDXeNiREpz7RJ2J9egFnR/brPVp3wz2oRKX3I6xDJ92CbZkj0e+
 TGgQ==
X-Gm-Message-State: AOJu0YyviCo1TVbsB5QXg5X/qAEW7CLM4MsDpJEMbbuN26FZAtxUOyjd
 XAah1f4Q0THVVhpGICuvGX/lg4Q/BkRMFdWY0ylM6QPS4C0YD1/R5IWPaD0P5tGfrsapwI+I0Km
 3Cd7euopug9f0EPtRcn0vpGV/gNTHS1aOZIYJ0P6/SDBXSqcee4Ba0RUBhjNivOeNmlqcXBflRS
 ptQ9PlNVaxVXpDvbx9UGDJq1vc0WuKx8MK6wgVjH8=
X-Received: by 2002:a5d:6f1e:0:b0:37d:498a:a23f with SMTP id
 ffacd0b85a97d-381c7ab6eb8mr831925f8f.53.1730397202574; 
 Thu, 31 Oct 2024 10:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+BNCErv+veaZzc7fqtQbZqzDRfLISBZoERfTsyUVAbc761MC5wtwMEuf7qqogCpPG89KTQ==
X-Received: by 2002:a5d:6f1e:0:b0:37d:498a:a23f with SMTP id
 ffacd0b85a97d-381c7ab6eb8mr831901f8f.53.1730397202090; 
 Thu, 31 Oct 2024 10:53:22 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4983sm2790710f8f.33.2024.10.31.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/49] target/i386: remove CC_OP_CLR
Date: Thu, 31 Oct 2024 18:51:54 +0100
Message-ID: <20241031175214.214455-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just use CC_OP_EFLAGS; it is not that likely that the flags computed by
CC_OP_CLR survive the end of the basic block, in which case there is no
need to spill cc_op_src.

cc_op_src now does need spilling if the XOR is followed by a memory
operation, but this only costs 0.2% extra TCG ops.  They will be recouped
by simplifications in how QEMU evaluates ZF at runtime, which are even
greater with this change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  1 -
 target/i386/cpu-dump.c      |  1 -
 target/i386/tcg/cc_helper.c |  3 ---
 target/i386/tcg/translate.c | 10 ----------
 target/i386/tcg/emit.c.inc  | 15 ++++-----------
 5 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e2e10f55b2e..50172d7a6f9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1304,7 +1304,6 @@ typedef enum {
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
2.47.0


