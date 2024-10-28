Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AE9D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWd-0008A8-JA; Mon, 28 Oct 2024 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWa-00089a-NX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWZ-0000nN-4Z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBu80ghROOFVl+ODQDotB85rk6JKcA8U1vloiGHevjg=;
 b=JYrRF9KYBe6O3/np56z7jZiVqFaqE7JC79hf95ximBnF2gUT1MAfM4D9RINERrhwZx4CsE
 uuy1z3vSIcMIbovNOPTlSmkTw14yHiKzE59RpA5lWMlzfg4E9UdVx2b/r949D40V16Yfmq
 UJVL8TmQP5fuXizqVZrTdGNCnejiSYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-b9hYyFb0NNuL4FJ48dljVA-1; Mon, 28 Oct 2024 11:19:17 -0400
X-MC-Unique: b9hYyFb0NNuL4FJ48dljVA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso24794685e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128755; x=1730733555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBu80ghROOFVl+ODQDotB85rk6JKcA8U1vloiGHevjg=;
 b=P5W5n/otp2O3OjYXZ5HQbvWocsn8RON2tWzgL29PNgjvQWbWCkMgm/u90zKIy+3de+
 daY7xmomftbbQn1q4vg5TiqUru9FpbsHBJdy2oLZi8CPooNpaZE6QfkHtWMk3kbk8nll
 oXYrpZ4vLoIOS1IpoXDn/6hyNcP777YAyslBmEjuZCzyvK/nEV54dc6RFdVTA2aT6Z6Q
 RrlXbsrZj878tfDXVhVQ/LdGGv0ZFjgLcFBiERWKX1oXceMfiecndmKRIIFe2IxtDcpj
 n05tDkusTd1cb+5A/W20AznHaIbT46kRWvwgoZNKbb+tZrACtzIuWtJ+FGRKoUc+9o39
 GTBg==
X-Gm-Message-State: AOJu0Yx8HfoZGbGCly+z/Lseq3YvbYURVjC9golOh2dCx1nSSFv35OHV
 WGUh9VdoZ+OE2ADM1ZJ6Q/efcmSWFY02O8oSjTZ8IZtXJflfERJnhFdQlD8uDF/fdQeLPLM40lJ
 Kk+shiD9QNcYgZwLtn+69+GmZBQVEI8FGmq2ZAe8HnMoIKfm/Wnb67bMD8IV1cLkVHtmvXZE1ae
 6Ke0oR2dIasIbKTeE1cuIew1ytJpAAW4mPuMki5Lo=
X-Received: by 2002:a05:600c:3b23:b0:431:4fbd:f571 with SMTP id
 5b1f17b1804b1-431b2ae97dcmr1632945e9.13.1730128755202; 
 Mon, 28 Oct 2024 08:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrBPBG+IgbO8ONr2ZhgVQBlUo0TnP6WvXxcLd7W2oBihLwAlr9bQkFfqwCX53GtPdsAgg5eg==
X-Received: by 2002:a05:600c:3b23:b0:431:4fbd:f571 with SMTP id
 5b1f17b1804b1-431b2ae97dcmr1632695e9.13.1730128754779; 
 Mon, 28 Oct 2024 08:19:14 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573d47sm114822155e9.3.2024.10.28.08.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 06/14] target/i386: Wrap cc_op_live with a validity check
Date: Mon, 28 Oct 2024 16:18:43 +0100
Message-ID: <20241028151851.376355-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Assert that op is known and that cc_op_live_ is populated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                |  1 -
 target/i386/tcg/translate.c      | 21 ++++++++++++++++++---
 target/i386/tcg/decode-new.c.inc |  2 +-
 target/i386/tcg/emit.c.inc       |  4 ++--
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e598fe3de9a..afe6643db83 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1373,7 +1373,6 @@ typedef enum {
 #define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
 
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_NB,
 } CCOp;
 
 /* See X86DecodedInsn.cc_op, using int8_t. */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 46062002c02..1a9a2fe709e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -291,7 +291,7 @@ enum {
 };
 
 /* Bit set if the global variable is live after setting CC_OP to X.  */
-static const uint8_t cc_op_live[CC_OP_NB] = {
+static const uint8_t cc_op_live_[] = {
     [CC_OP_DYNAMIC] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_EFLAGS] = USES_CC_SRC,
     [CC_OP_MULB ... CC_OP_MULQ] = USES_CC_DST | USES_CC_SRC,
@@ -312,6 +312,21 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_POPCNT] = USES_CC_DST,
 };
 
+static uint8_t cc_op_live(CCOp op)
+{
+    uint8_t result;
+    assert(op >= 0 && op < ARRAY_SIZE(cc_op_live_));
+
+    /*
+     * Check that the array is fully populated.  A zero entry would correspond
+     * to a fixed value of EFLAGS, which can be obtained with CC_OP_EFLAGS
+     * as well.
+     */
+    result = cc_op_live_[op];
+    assert(result);
+    return result;
+}
+
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
     int dead;
@@ -321,7 +336,7 @@ static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
     }
 
     /* Discard CC computation that will no longer be used.  */
-    dead = cc_op_live[s->cc_op] & ~cc_op_live[op];
+    dead = cc_op_live(s->cc_op) & ~cc_op_live(op);
     if (dead & USES_CC_DST) {
         tcg_gen_discard_tl(cpu_cc_dst);
     }
@@ -808,7 +823,7 @@ static void gen_mov_eflags(DisasContext *s, TCGv reg)
     src2 = cpu_cc_src2;
 
     /* Take care to not read values that are not live.  */
-    live = cc_op_live[s->cc_op] & ~USES_CC_SRCT;
+    live = cc_op_live(s->cc_op) & ~USES_CC_SRCT;
     dead = live ^ (USES_CC_DST | USES_CC_SRC | USES_CC_SRC2);
     if (dead) {
         TCGv zero = tcg_constant_tl(0);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 48bf730cd3e..cda32ee6784 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2865,7 +2865,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
         }
         set_cc_op(s, decode.cc_op);
-        cc_live = cc_op_live[decode.cc_op];
+        cc_live = cc_op_live(decode.cc_op);
     } else {
         cc_live = 0;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 45ac5edb1ae..785ff63f2ac 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3777,13 +3777,13 @@ static void gen_shift_dynamic_flags(DisasContext *s, X86DecodedInsn *decode, TCG
     decode->cc_op_dynamic = tcg_temp_new_i32();
 
     assert(decode->cc_dst == s->T0);
-    if (cc_op_live[s->cc_op] & USES_CC_DST) {
+    if (cc_op_live(s->cc_op) & USES_CC_DST) {
         decode->cc_dst = tcg_temp_new();
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_dst, count, tcg_constant_tl(0),
                            cpu_cc_dst, s->T0);
     }
 
-    if (cc_op_live[s->cc_op] & USES_CC_SRC) {
+    if (cc_op_live(s->cc_op) & USES_CC_SRC) {
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src, count, tcg_constant_tl(0),
                            cpu_cc_src, decode->cc_src);
     }
-- 
2.47.0


