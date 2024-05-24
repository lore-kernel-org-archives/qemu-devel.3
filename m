Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF32C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0k-0005Hw-O7; Fri, 24 May 2024 04:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0j-0005GZ-7e
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0h-0000as-FB
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2BbL6jR1b542eSscLXiZLPQxRUIoJp8BSdDrVwqVsM=;
 b=E1lMNzgWtuly3mRM6u2MxsTEfVLV4cvzO32PRHcYJtUFo92PwUV2cQEk/vR1c4O00nISv0
 qx1oJXoscdJ3fTO+NZbw2tI1AoF/M4RSzsc3odfpLJFP+ktzPmc9v+4NISrLIy3RsjvD6a
 nhfpDshdvK9c7+3Lu7HaXF+hf1qNw4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-U5afqTSUN7-4wzLfRfAkXA-1; Fri, 24 May 2024 04:10:39 -0400
X-MC-Unique: U5afqTSUN7-4wzLfRfAkXA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6269ad7288so23389166b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538238; x=1717143038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2BbL6jR1b542eSscLXiZLPQxRUIoJp8BSdDrVwqVsM=;
 b=YQWTR6BlFob5HA4HKaX74V+A+ipTsmJzh/wicr2376zuejTquvtXyqjtNgmhB9ijmI
 P0TCANcYJlRFWJGfibo9A54bvKHm5Cir6Imcd7lmgKRiKelouTscQ25GSHczy1AClbUr
 8DnbHpIvaFnvajzaPdrtEEWjXBCH9LYisQTyyKYGILRf+M4+4wNW+afZVZEV0xVc/BLl
 113UEMxr1eu/tJaV4zS5DkP77DKswNwSNGup0XqArl2bfK0HVqITnD9KxWJLXP93NnUs
 1qUqtEfnV79/ydhU1cN/AyO2D7L7N8WBzo3lxNvhmdH8FkFZ2TbOSKDH2B2NJ0H9+quU
 xu1A==
X-Gm-Message-State: AOJu0YylsdWtJqmUqinsiKPeV+3WZm0hSfW3CYZbI7E5EnCUbDfCpScO
 7nWInyPq9vpP+Tl9LkZREOXrwiYPpGZdnwZ/TxG8Psee88Q500H9Nu5rg3HZgU/kk2t/jKeTTcv
 HBC2CDdJaJL+8ZCHcqn8ttBNHDuzq1nmWXnmDkqE4XAMFIhrJF4LgU0GbR+EgFde/jyIE2i/Xn6
 f59XBqca9Csco3rQZVnPEYs1G3gAKK3Y9XviK3
X-Received: by 2002:a17:906:181b:b0:a59:cdc9:6fe1 with SMTP id
 a640c23a62f3a-a62641d9a28mr93873766b.19.1716538237715; 
 Fri, 24 May 2024 01:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMIDXQbHlxHTKiXWl5zfEyGrKKfbRMt5cHsjOTz+1mZUXyhw4lAhk83d9pnxHrKKmN3v/8zw==
X-Received: by 2002:a17:906:181b:b0:a59:cdc9:6fe1 with SMTP id
 a640c23a62f3a-a62641d9a28mr93871466b.19.1716538236916; 
 Fri, 24 May 2024 01:10:36 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8e295sm89405366b.185.2024.05.24.01.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] target/i386: raze the gen_eob* jungle
Date: Fri, 24 May 2024 10:10:10 +0200
Message-ID: <20240524081019.1141359-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
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

Make gen_eob take the DISAS_* constant as an argument, so that
it is not necessary to have wrappers around it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 60 +++++++++----------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2c7917d239f..c46385be060 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -260,8 +260,6 @@ STUB_HELPER(write_crN, TCGv_env env, TCGv_i32 reg, TCGv val)
 STUB_HELPER(wrmsr, TCGv_env env)
 #endif
 
-static void gen_eob(DisasContext *s);
-static void gen_jr(DisasContext *s);
 static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num);
 static void gen_jmp_rel_csize(DisasContext *s, int diff, int tb_num);
 static void gen_exception_gpf(DisasContext *s);
@@ -2259,12 +2257,13 @@ static void gen_bnd_jmp(DisasContext *s)
     }
 }
 
-/* Generate an end of block. Trace exception is also generated if needed.
-   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.
-   If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
-   S->TF.  This is used by the syscall/sysret insns.  */
+/*
+ * Generate an end of block, including common tasks such as generating
+ * single step traps, resetting the RF flag, and handling the interrupt
+ * shadow.
+ */
 static void
-gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
+gen_eob(DisasContext *s, int mode)
 {
     bool inhibit_reset;
 
@@ -2275,52 +2274,29 @@ gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
     if (s->flags & HF_INHIBIT_IRQ_MASK) {
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
         inhibit_reset = true;
-    } else if (inhibit) {
+    } else if (mode == DISAS_EOB_INHIBIT_IRQ) {
         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
 
     if (s->base.tb->flags & HF_RF_MASK) {
         gen_reset_eflags(s, RF_MASK);
     }
-    if (recheck_tf) {
+    if (mode == DISAS_EOB_RECHECK_TF) {
         gen_helper_rechecking_single_step(tcg_env);
         tcg_gen_exit_tb(NULL, 0);
     } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
-    } else if (jr &&
+    } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
                !inhibit_reset) {
         tcg_gen_lookup_and_goto_ptr();
     } else {
         tcg_gen_exit_tb(NULL, 0);
     }
+
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static inline void
-gen_eob_syscall(DisasContext *s)
-{
-    gen_eob_worker(s, false, true, false);
-}
-
-/* End of block.  Set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
-static void gen_eob_inhibit_irq(DisasContext *s)
-{
-    gen_eob_worker(s, true, false, false);
-}
-
-/* End of block, resetting the inhibit irq flag.  */
-static void gen_eob(DisasContext *s)
-{
-    gen_eob_worker(s, false, false, false);
-}
-
-/* Jump to register */
-static void gen_jr(DisasContext *s)
-{
-    gen_eob_worker(s, false, false, true);
-}
-
 /* Jump to eip+diff, truncating the result to OT. */
 static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
 {
@@ -2372,9 +2348,9 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
             tcg_gen_movi_tl(cpu_eip, new_eip);
         }
         if (s->jmp_opt) {
-            gen_jr(s);   /* jump to another page */
+            gen_eob(s, DISAS_JUMP);   /* jump to another page */
         } else {
-            gen_eob(s);  /* exit to main loop */
+            gen_eob(s, DISAS_EOB_ONLY);  /* exit to main loop */
         }
     }
 }
@@ -4787,22 +4763,14 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
+    case DISAS_EOB_INHIBIT_IRQ:
         assert(dc->base.pc_next == dc->pc);
         gen_update_eip_cur(dc);
         /* fall through */
     case DISAS_EOB_ONLY:
-        gen_eob(dc);
-        break;
     case DISAS_EOB_RECHECK_TF:
-        gen_eob_syscall(dc);
-        break;
-    case DISAS_EOB_INHIBIT_IRQ:
-        assert(dc->base.pc_next == dc->pc);
-        gen_update_eip_cur(dc);
-        gen_eob_inhibit_irq(dc);
-        break;
     case DISAS_JUMP:
-        gen_jr(dc);
+        gen_eob(dc, dc->base.is_jmp);
         break;
     default:
         g_assert_not_reached();
-- 
2.45.1


