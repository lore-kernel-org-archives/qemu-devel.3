Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD12BC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t91-0005rd-T9; Mon, 06 May 2024 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Y-0005il-JI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8I-0001UC-Dh
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkBKFh1uHjc74jYCPGWrYjt/t0FCbUHfDC8rQ9UiTvU=;
 b=b58Mr0OTGcte+kEf1vKkUT0lO3n0mr2uVs+CyBwSCiTWNNYVQlD/6iJKrffs7uH7r6n9Sw
 g1/SCd2FT/uGBOb/z4jcWYfLUoD3Gz4BgsO562UUQwBbhy3Ox7ZcFskRXLxB3AwiVs7ge7
 VIqBGp2bjJHQqacDxzqfPhrqqt32vyU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Q2X3w0YfP6-0mpOcdwpIIQ-1; Mon, 06 May 2024 03:51:32 -0400
X-MC-Unique: Q2X3w0YfP6-0mpOcdwpIIQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso89396066b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981890; x=1715586690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkBKFh1uHjc74jYCPGWrYjt/t0FCbUHfDC8rQ9UiTvU=;
 b=KbZKc3aD7gatMlW17qLlwrFEOHoV+/wm3kVKpN42xZYmgsNctsBo00OxJ80wXaN2md
 V74lx7nXgIwSlEl2afaDSVHHY5F5zrcaDzyYytOtZmhraTDmROZCbxY+H0kXEiHOoJDe
 kl/7QSvorWyiDwofAuUQg7pBY1szpQrH89bVJAoHH/M9j+AVReyZAC5MKNn1buad5Y57
 1NGFEcdE3FAPl8NBoRKEJlcJR0CBJGaq1ExPMEL7KajRMJZvqfNQ98yXYYRL4QY6IfSf
 yrgGJQU7r0li6lxqLLquwvu/Qe070bHszB0MyEv0RZAfJsAkQCjmm3HohbJoGN/PKXjH
 peOw==
X-Gm-Message-State: AOJu0Yx43zOboUZM38cVY4oB/E3PchGlDBjpGP2g4YqLSZVc+xoq6JCG
 Uxj9xLHStugF3J9OwR10IElZvp5Q2jsG+sRoEGv16/NHe29XqqYvXNexnrYArEcIyv/AaXNn5Vq
 2NwmyJ5NMHdyRGWu5fw/HSycpTxotkGOtwGUFog2JDhMNQH/w6unaYD1xBivzusXIw79nexWL/6
 coPlUdtcLrWbZ9QObmiikgwvOvChSMGs1S2HIj
X-Received: by 2002:a17:907:9724:b0:a59:b359:3e14 with SMTP id
 jg36-20020a170907972400b00a59b3593e14mr3133828ejc.10.1714981890197; 
 Mon, 06 May 2024 00:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5ZHa5Mfy3hpTH89lkjF861B+hFQWwvqYjvqgkZjswi1MTMI5pb2F7nwTfoCx0J17I1AJLJw==
X-Received: by 2002:a17:907:9724:b0:a59:b359:3e14 with SMTP id
 jg36-20020a170907972400b00a59b3593e14mr3133816ejc.10.1714981889655; 
 Mon, 06 May 2024 00:51:29 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 wk18-20020a170907055200b00a59df1df5c3sm118393ejb.47.2024.05.06.00.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ruihan Li <lrh2000@pku.edu.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/46] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Date: Mon,  6 May 2024 09:50:40 +0200
Message-ID: <20240506075125.8238-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Ruihan Li <lrh2000@pku.edu.cn>

When emulated with QEMU, interrupts will never come in the following
loop. However, if the NOP instruction is uncommented, interrupts will
fire as normal.

	loop:
		cli
    		call do_sti
		jmp loop

	do_sti:
		sti
		# nop
		ret

This behavior is different from that of a real processor. For example,
if KVM is enabled, interrupts will always fire regardless of whether the
NOP instruction is commented or not. Also, the Intel Software Developer
Manual states that after the STI instruction is executed, the interrupt
inhibit should end as soon as the next instruction (e.g., the RET
instruction if the NOP instruction is commented) is executed.

This problem is caused because the previous code may choose not to end
the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
case where the STI instruction is immediately followed by the RET
instruction), so that IRQs may not have a change to trigger. This commit
fixes the problem by always terminating the current TB to give IRQs a
chance to trigger when HF_INHIBIT_IRQ_MASK is reset.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Message-ID: <20240415064518.4951-4-lrh2000@pku.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c05d9e52259..051ffb5e1fd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2798,13 +2798,17 @@ static void gen_bnd_jmp(DisasContext *s)
 static void
 do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
+    bool inhibit_reset;
+
     gen_update_cc_op(s);
 
     /* If several instructions disable interrupts, only the first does it.  */
-    if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
-        gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
-    } else {
+    inhibit_reset = false;
+    if (s->flags & HF_INHIBIT_IRQ_MASK) {
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
+        inhibit_reset = true;
+    } else if (inhibit) {
+        gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
     if (s->base.tb->flags & HF_RF_MASK) {
@@ -2815,7 +2819,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
         tcg_gen_exit_tb(NULL, 0);
     } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
-    } else if (jr) {
+    } else if (jr &&
+               /* give irqs a chance to happen */
+               !inhibit_reset) {
         tcg_gen_lookup_and_goto_ptr();
     } else {
         tcg_gen_exit_tb(NULL, 0);
-- 
2.44.0


