Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB5C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFO-0006Vc-4r; Fri, 24 Jan 2025 04:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFL-0006Ue-RK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFJ-0003em-E6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2/9PlpXoOglUx6Dtwf/yi/v6/s//LvDY4FV96ReuTE=;
 b=dRpSfapTQ2z/uoovrWBP0ckNIPspWFB6GIQsxw+yZgq+i03Uit7n1GXNB1Bc6pjbfKrth5
 NK9kojshkH2t9bcsMd1WjC3C5fdYw7mB5kAiyl2E7Ys7gvMUTa+6GHZo5/Fz9w0YMzdtAd
 /9xldqV+5s01qWz7b4A5I2vgfkc0TP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-tf34eCvfO_qssvPXR-ZAxw-1; Fri, 24 Jan 2025 04:44:58 -0500
X-MC-Unique: tf34eCvfO_qssvPXR-ZAxw-1
X-Mimecast-MFC-AGG-ID: tf34eCvfO_qssvPXR-ZAxw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so10341515e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711896; x=1738316696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2/9PlpXoOglUx6Dtwf/yi/v6/s//LvDY4FV96ReuTE=;
 b=Q049hsRyW+S1y0x+KSkq+dcuXDgSHY+0M9D/ij25lCLNMmWOsn7u6rirQS7s3tW/JG
 QNjRrIvc4/CQnP+tcoxpPf+IWwXuz+RG0SzXd7GgqZWsATW4WcvRCNUrBBs8HG7kv8B0
 bUUFe4YRyn0VJ5PHviBzV4xkx8SHV0ucwPV6rVd3TuNFmTz7BrY/9Mz9ndXH1G/4kUZW
 nTV+MFrgKsO0Pz0m147KOuu7fx8ocU/4kADBfrGrauep2WAlpTxlJP6snuO1xblHi1JF
 QTa5wMwgvp/y9oeJyhejSa4Wav2a8h85gF2xvompGC3thxVGN1iV3ZLTU0GaBodd+Dc3
 Ed5g==
X-Gm-Message-State: AOJu0YymFXuMdOyQgA+oFJ8aid3ACNzIZb6B1OHCFiJ8KvRv2bPmkm5X
 d2oWw2/Pk2wgKVFnznr5pBe6Afp1Rb59sKylLPUzyEm0dIL5t3am+KMuHppTMgRgKMey0xcRxKj
 2PIWbfizjE/53xTAuWmz8Vjs6SEyD9c0H7Y7D5xX3eTP/6rYdS4lqMbqK1KIqmIK8AzawfIeAfl
 0NEE7ayQGObVMB+dMaSt19XtM44tHnhZBvT36NR/U=
X-Gm-Gg: ASbGnctY5xjOhrX4uPZjepOckGwYAN3xYcG4A7tQUxZVvAx1tz577YujihxGLUUU9O9
 sTcBEwcu+3xPO7E/vIk4MR05fBKLam0zrVM9exa9OixHbut34yndt92Np4xQnuSpaR5YAPWlOya
 1VRCr542gPSRGB0F/TqfTNidYk+iY0Fsb+zM06BsU+2pUYkaflD6MUDfITm0ozA2IVLIPVrkyEN
 yHcYZItoiwHW/URRSCNtLG2K/uDt9GtUWCQzP7Dq4kTb4q0RLkfTIdYXhgpxIcVJ6g8vCDnSg==
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-43891435c37mr250640845e9.24.1737711896311; 
 Fri, 24 Jan 2025 01:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRvUhnHMuyQTlvDEZ0+ojaSa7lft9wF4cm5O02j59lG6Eo7yPtrFx4cP7g5HO1SA13mpK7+g==
X-Received: by 2002:a05:600c:4ec8:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-43891435c37mr250640335e9.24.1737711895658; 
 Fri, 24 Jan 2025 01:44:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c098sm20178745e9.31.2025.01.24.01.44.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/48] target/i386: reorganize ops emitted by do_gen_rep,
 drop repz_opt
Date: Fri, 24 Jan 2025 10:44:00 +0100
Message-ID: <20250124094442.13207-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

The condition for optimizing repeat instruction is more or less the
opposite of what you imagine: almost always the string instruction
was _not_ optimized and optimizing the loop relied on goto_tb.
This is obviously not great for performance, due to the cost of the
exit-to-main-loop check, but also wrong.  In fact, after expanding
dc->jmp_opt and simplifying "!!x" to "x", the condition for looping used
to be:

   ((cflags & CF_NO_GOTO_TB) ||
    (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK))) && !(cflags & CF_USE_ICOUNT)

In other words, setting aside RF (it requires special handling for REP
instructions and it was completely missing), repeat instruction were
being optimized if TF or inhibit IRQ flags were set.  This is certainly
wrong for TF, because string instructions trap after every execution,
and probably for interrupt shadow too.

Get rid of repz_opt completely.  The next patches will reintroduce the
optimization, applying it in the common case instead of the unlikely
and wrong one.

While at it, place the CX/ECX/RCX=0 case is at the end of the function,
which saves a label and is clearer when reading the generated ops.
For clarity, mark the cc_op explicitly as DYNAMIC even if at the end
of the translation block; the cc_op can come from either the previous
instruction or the string instruction, and currently we rely on
a gen_update_cc_op() that is hidden in the bowels of gen_jcc() to
spill cc_op and mark it clean.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-6-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 60 ++++++++-----------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3e46be8d78d..ee536234398 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -113,7 +113,6 @@ typedef struct DisasContext {
 #endif
     bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
-    bool repz_opt; /* optimize jumps within repz instructions */
     bool cc_op_dirty;
 
     CCOp cc_op;  /* current CC operation */
@@ -1206,23 +1205,6 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
     }
 }
 
-/* XXX: does not work with gdbstub "ice" single step - not a
-   serious problem.  The caller can jump to the returned label
-   to stop the REP but, if the flags have changed, it has to call
-   gen_update_cc_op before doing so.  */
-static TCGLabel *gen_jz_ecx_string(DisasContext *s)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-
-    gen_update_cc_op(s);
-    gen_op_jnz_ecx(s, l1);
-    gen_set_label(l2);
-    gen_jmp_rel_csize(s, 0, 1);
-    gen_set_label(l1);
-    return l2;
-}
-
 static void gen_stos(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
@@ -1314,27 +1296,25 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        void (*fn)(DisasContext *s, MemOp ot),
                        bool is_repz_nz)
 {
-    TCGLabel *l2;
-    l2 = gen_jz_ecx_string(s);
+    TCGLabel *done = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_jz_ecx(s, done);
+
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     if (is_repz_nz) {
         int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
+        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
-    /*
-     * A loop would cause two single step exceptions if ECX = 1
-     * before rep string_insn
-     */
-    if (s->repz_opt) {
-        gen_op_jz_ecx(s, l2);
-    }
-    /*
-     * For CMPS/SCAS there is no need to set CC_OP_DYNAMIC: only one iteration
-     * is done at a time, so the translation block ends unconditionally after
-     * this instruction and there is no control flow junction.
-     */
+
+    /* Go to the main loop but reenter the same instruction.  */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
+
+    /* CX/ECX/RCX is zero, or REPZ/REPNZ broke the repetition.  */
+    gen_set_label(done);
+    set_cc_op(s, CC_OP_DYNAMIC);
+    gen_jmp_rel_csize(s, 0, 1);
 }
 
 static void gen_repz(DisasContext *s, MemOp ot,
@@ -3665,20 +3645,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
-    /*
-     * If jmp_opt, we want to handle each string instruction individually.
-     * For icount also disable repz optimization so that each iteration
-     * is accounted separately.
-     *
-     * FIXME: this is messy; it makes REP string instructions a lot less
-     * efficient than they should be and it gets in the way of correct
-     * handling of RF (interrupts or traps arriving after any iteration
-     * of a repeated string instruction but the last should set RF to 1).
-     * Perhaps it would be more efficient if REP string instructions were
-     * always at the beginning of the TB, or even their own TB?  That
-     * would even allow accounting up to 64k iterations at once for icount.
-     */
-    dc->repz_opt = !dc->jmp_opt && !(cflags & CF_USE_ICOUNT);
 
     dc->T0 = tcg_temp_new();
     dc->T1 = tcg_temp_new();
-- 
2.48.1


