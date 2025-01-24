Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9861C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFS-0006c3-QS; Fri, 24 Jan 2025 04:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFP-0006W5-M9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFN-0003qo-ST
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SghbM/NNoU3iHbE0G8WtufvFOtxEQ/VfpTeyiNEP0U=;
 b=YCKCam1bOJTVJtd+V7uULcla1FWgqF4FxWYqcMoy1QKdKqNu1OJHbo3q7lrAsQnbbIkPWE
 EqYZdzVgmVmN2kHDgJv9GIcb0ZOo+mgwi9VauPuFIFFrf+TDnizqYT2W/jbbRM7u1oElKC
 Bp2tBmXa6ZqAwtr8/4aTs2wDYIrUfkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-I2KN4JB9P4SJNTP2ePNPRw-1; Fri, 24 Jan 2025 04:45:03 -0500
X-MC-Unique: I2KN4JB9P4SJNTP2ePNPRw-1
X-Mimecast-MFC-AGG-ID: I2KN4JB9P4SJNTP2ePNPRw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so703000f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711901; x=1738316701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SghbM/NNoU3iHbE0G8WtufvFOtxEQ/VfpTeyiNEP0U=;
 b=JJCC+TAie0/kY9w6zloZb7JGzXJHxSAsY9TYoYBPpMCuGth5gMT4b2m62d3MXB3Sh5
 FPA7RuEh9tMyI+LGLaaiG0w0hFXNlaSaDNG1XDygGQWzdhBU3feXrqtkBJqPI53tf1YJ
 BBEqcbT2+6A4IaXXG/S0ULoBWFAJXabJpNYArrvbg+rLq+0ktr9FlEmggsPQ+DDogosj
 YLaRz/Ngc0FggwAcJj7AUWaTCHxJgI+dwpk3WxDAzx2vrOc+3KNUq7ZKgF7LwdfOrpSn
 MZzNhujHNyqzFa/gvCHgIgRAEX3eaGLr0l43kWJXfMoLyMopjvzoeNyage/yNrSAzaAO
 R8Qg==
X-Gm-Message-State: AOJu0Yw8MFNiyNVbxh/NMY6cnxwqGRMX7HzaemozDZ1yEIapbGS3o+nR
 J3UiBXiq27MtfeoxNZN/QUpUdnXChFzNI5dQRvA8XlqLfbRC/Q4ctJIsdQqfNYLonYYEZpSIN79
 2YEoxTO/senh51TPQ4/iVOgYgU84A18N0vnUtu7kpJMlXFdtcgM8sswffGqyiXwNaSVBk+GtEK3
 pgLeWEj1alOq847WSykfRkzRmif2fx77atuWc2Dl4=
X-Gm-Gg: ASbGncthFJlRiklDTPMflh9dq6iS93SL3kmf3xKvRDfrGe9pAdnYd24zgM2OeUwI5NZ
 uyPIID975dACLt6PFzDWe7tVLsbiRpVxAbu2mkfjGX51JwZbl1Au6EbFRYX8ku1Hd++xpCt3vhp
 X3CVCM8eIUqlPJfDndAHUItVw9w1kZXygVR9ZopXCrG3fqrsruy8py699ofPC2/2Nc4hpC44DZq
 j/n8NK+JqT0TO6fb3TsY4LE21+BOmk6WatqUqSh4rQZFRhh63P5JfkFIqF2F96DNcJrREkS4w==
X-Received: by 2002:a05:6000:4008:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38bf55c53c8mr25158537f8f.0.1737711901511; 
 Fri, 24 Jan 2025 01:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP6mTzQ9P75WlOcIRQYeRnExACSQStsulxTNCTTwCfHzLFazt6TftK2eCUAYqFBjkjpCLG8g==
X-Received: by 2002:a05:6000:4008:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38bf55c53c8mr25158511f8f.0.1737711901074; 
 Fri, 24 Jan 2025 01:45:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188fd0sm2207866f8f.58.2025.01.24.01.44.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/48] target/i386: fix RF handling for string instructions
Date: Fri, 24 Jan 2025 10:44:02 +0100
Message-ID: <20250124094442.13207-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

RF must be set on traps and interrupts from a string instruction,
except if they occur after the last iteration.  Ensure it is set
before giving the main loop a chance to execute.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-8-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6347de446a4..141295742ae 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1337,6 +1337,14 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        bool is_repz_nz)
 {
     TCGLabel *done = gen_new_label();
+    bool had_rf = s->flags & HF_RF_MASK;
+
+    /*
+     * Even if EFLAGS.RF was set on entry (such as if we're on the second or
+     * later iteration and an exception or interrupt happened), force gen_eob()
+     * not to clear the flag.  We do that ourselves after the last iteration.
+     */
+    s->flags &= ~HF_RF_MASK;
 
     gen_update_cc_op(s);
     gen_op_jz_ecx(s, done);
@@ -1348,12 +1356,24 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
         gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
 
+    /*
+     * Traps or interrupts set RF_MASK if they happen after any iteration
+     * but the last.  Set it here before giving the main loop a chance to
+     * execute.  (For faults, seg_helper.c sets the flag as usual).
+     */
+    if (!had_rf) {
+        gen_set_eflags(s, RF_MASK);
+    }
+
     /* Go to the main loop but reenter the same instruction.  */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 
     /* CX/ECX/RCX is zero, or REPZ/REPNZ broke the repetition.  */
     gen_set_label(done);
     set_cc_op(s, CC_OP_DYNAMIC);
+    if (had_rf) {
+        gen_reset_eflags(s, RF_MASK);
+    }
     gen_jmp_rel_csize(s, 0, 1);
 }
 
@@ -2158,7 +2178,7 @@ gen_eob(DisasContext *s, int mode)
         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
-    if (s->base.tb->flags & HF_RF_MASK) {
+    if (s->flags & HF_RF_MASK) {
         gen_reset_eflags(s, RF_MASK);
     }
     if (mode == DISAS_EOB_RECHECK_TF) {
-- 
2.48.1


