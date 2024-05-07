Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A39C25B76
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUu-0004xw-RG; Tue, 07 May 2024 06:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUa-0004gN-C1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUY-0002fb-9x
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7orX+k7LBpJEeF1OzUgP4w1muQCvR0E2L1VJbeGmG8=;
 b=PWqEmIyBkfk+ttoN1usxC6/huhdGGMd/cib4fePWIXi6Q0zojvnFQM3kbQBg6Ssw+qR6Dc
 TWSlIhJw90vKblbLGHudrIvDw7MdpKzvw7k9+Zp58o7T24UfdUhIb5c81QfGZWh9nvizB0
 yMDkg1B7WXuMF94jEFFQPHH0T1cICFw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-HbX9q7ckMD-8Ukhlibj3xQ-1; Tue, 07 May 2024 06:56:11 -0400
X-MC-Unique: HbX9q7ckMD-8Ukhlibj3xQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c0ecd59cso164773666b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079370; x=1715684170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7orX+k7LBpJEeF1OzUgP4w1muQCvR0E2L1VJbeGmG8=;
 b=MQRv7UHE0g6GY8FqfC2/6T6aNX3SxfiO4GsOn+TUfmhRombs3c42Viuce8PIuIbQpm
 vxiZcQgExggQfLDiU+onlQvnUvvQH2HWjiuPyiDazVxI4Li0ILx5Hqq9VhV0Svys4BGg
 /kTo/Ya4UUWP5HYJ0FXJvaUizSraFpYqE/mBTPtRxA5UqAcbgyAM5A10vjOKbXyinjkU
 0Vtb7vCIWvwPb/ANhLy281WMB/5gSJDjTLJ1LeURj6zD4qJirJk1JoR2tS7nRJMEJPYb
 owHo2EQn9qp/sWNZA36w7LV9A8Tf2OrKjKbDay/pN/OszHPYuS7fdKLaovSRi/k6nldW
 K+9w==
X-Gm-Message-State: AOJu0Yzawy+3ZngM1O8rrMYAGqocl1p9aGk0fsoxKp5IKAaxA5jh0+47
 WpvjzgClrnjmKZSAqbmrEaCkl5Zr/We33nUiPE4jvLihJtDm8dQTea41BzorZUUGADqncJLdrkS
 QmCWJx6KKTwFZb2xjrMs/1LeZYndxEk7i2L1trTIXLDYmV7SKWuTcXCPG0cfqNMtx1UhxrVj/Ll
 dfiavjLEvBXCP3jgbqL6lmQoQFnI1MwasJzNei
X-Received: by 2002:a17:906:a84f:b0:a59:a64d:c5b9 with SMTP id
 dx15-20020a170906a84f00b00a59a64dc5b9mr8062471ejb.76.1715079370164; 
 Tue, 07 May 2024 03:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgxkNcpvLzdI1jiACfvPmyxiNqGeWAd+BYOnmCpg0OppTDsiKF2/LLlE2aYJM1tBTyJtgTDQ==
X-Received: by 2002:a17:906:a84f:b0:a59:a64d:c5b9 with SMTP id
 dx15-20020a170906a84f00b00a59a64dc5b9mr8062456ejb.76.1715079369833; 
 Tue, 07 May 2024 03:56:09 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a170906548d00b00a59caa028b0sm2621996ejo.225.2024.05.07.03.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/26] target/i386: cleanup *gen_eob*
Date: Tue,  7 May 2024 12:55:23 +0200
Message-ID: <20240507105538.180704-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Create a new wrapper for syscall/sysret, and do not go through multiple
layers of wrappers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8e0289ca414..f018d6303a9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2783,7 +2783,7 @@ static void gen_bnd_jmp(DisasContext *s)
    If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
    S->TF.  This is used by the syscall/sysret insns.  */
 static void
-do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
+gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
     bool inhibit_reset;
 
@@ -2817,28 +2817,27 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 }
 
 static inline void
-gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
+gen_eob_syscall(DisasContext *s)
 {
-    do_gen_eob_worker(s, inhibit, recheck_tf, false);
+    gen_eob_worker(s, false, true, false);
 }
 
-/* End of block.
-   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
-static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
+/* End of block.  Set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
+static void gen_eob_inhibit_irq(DisasContext *s)
 {
-    gen_eob_worker(s, inhibit, false);
+    gen_eob_worker(s, true, false, false);
 }
 
 /* End of block, resetting the inhibit irq flag.  */
 static void gen_eob(DisasContext *s)
 {
-    gen_eob_worker(s, false, false);
+    gen_eob_worker(s, false, false, false);
 }
 
 /* Jump to register */
 static void gen_jr(DisasContext *s)
 {
-    do_gen_eob_worker(s, false, false, true);
+    gen_eob_worker(s, false, false, true);
 }
 
 /* Jump to eip+diff, truncating the result to OT. */
@@ -5591,7 +5590,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_set_eflags(s, IF_MASK);
             /* interruptions are enabled only the first insn after sti */
             gen_update_eip_next(s);
-            gen_eob_inhibit_irq(s, true);
+            gen_eob_inhibit_irq(s);
         }
         break;
     case 0x62: /* bound */
@@ -5725,7 +5724,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob_syscall(s);
         break;
     case 0x107: /* sysret */
         /* For Intel SYSRET is only valid in long mode */
@@ -5744,7 +5743,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_worker(s, false, true);
+            gen_eob_syscall(s);
         }
         break;
     case 0x1a2: /* cpuid */
@@ -7059,7 +7058,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_EOB_INHIBIT_IRQ:
         gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
-        gen_eob_inhibit_irq(dc, true);
+        gen_eob_inhibit_irq(dc);
         break;
     case DISAS_JUMP:
         gen_jr(dc);
-- 
2.45.0


