Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CDBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tR3-0003tA-NS; Mon, 06 May 2024 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQo-0003UN-Fo
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQm-0002NQ-KG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpLnINNltKNYuICEAfgrVDWivbsafSJrxfeDwCfqtJ4=;
 b=e1N0NsWJDG5bv7WF/P9Xmo0iyZYeAN5fhF3unrcIk1EAFmiP8RWHcpfreE3xHGdjXrWyh3
 aRhPp7zoVZPzzkC2C5YQBIfYZgGA+ojYvI8zoEsQmzKbW+KLqH0mFO6PntVjKtXfkhxnuY
 Am3TXdug755SEltlro9iY0tKbAqX30k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-7IidAv3sO8OkDVxME77caA-1; Mon, 06 May 2024 04:10:34 -0400
X-MC-Unique: 7IidAv3sO8OkDVxME77caA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so174047466b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983031; x=1715587831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpLnINNltKNYuICEAfgrVDWivbsafSJrxfeDwCfqtJ4=;
 b=RATToVTcfgdRe1Y38BImd6RYJxT9u1xM3IgR1Y6bwY2pbpPeXlfFIZq8f+YdvhWm8G
 bDhFLyY8UfEfZQQoDvLafbjybth08BVwuUg2hwRA7OJAhCuc1xbtOZWLy6AYBQe1fpZf
 BFLVWuxWHrY3uWkKAIN8KWmUy54p4FkhY9lLH7VwbAIYNd4bRry/h4u4jj2U+cptVzHf
 1Uqhe5YpRuq5buX9wdGkjS0nvj6fp2eiYy0VMpLa+2XXpQIW0wHjj5htlFinVaY//HOv
 mvTfGJI0QHDlEyXUX7G2et1OdkC9Ko9WeVWXABhFlV0jNtetl+V37tvMohtFtcwcjCF0
 BreA==
X-Gm-Message-State: AOJu0YyZ6re9EpFuXsKEGG7khOdp6yJl+R6D02k/wp5ni99D4QInS8OD
 xCw0zN5sgTaO01qsiEP+2Btb8h/k8qOwThX3F5DQNG/6vTlqEIiDWZ2yAmvJWVXoL76zesHUJsr
 L9YxE2Aj2D/sr6712wUDpTCMg/NAkrqy2Qj45O16Tvd7dkFc8+j5Krg32lIcsb1ZeV8QbJ83NkZ
 xA3Y3Blla/Mk6BGGKiz3T3vceZ0DwZzG3FF617
X-Received: by 2002:a17:907:7ea9:b0:a59:c307:2a4c with SMTP id
 qb41-20020a1709077ea900b00a59c3072a4cmr3324973ejc.25.1714983031064; 
 Mon, 06 May 2024 01:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECWzhwWoyTBgLQZy1Vxl1K6/YzesK5BFXpNhpVH/jq4jCL07ke/tXJXJ1tDWlGm1IVgT3n/A==
X-Received: by 2002:a17:907:7ea9:b0:a59:c307:2a4c with SMTP id
 qb41-20020a1709077ea900b00a59c3072a4cmr3324959ejc.25.1714983030727; 
 Mon, 06 May 2024 01:10:30 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1709060bf200b00a59cf813f34sm857801ejg.144.2024.05.06.01.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 10/25] target/i386: cleanup *gen_eob*
Date: Mon,  6 May 2024 10:09:42 +0200
Message-ID: <20240506080957.10005-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Create a new wrapper for syscall/sysret, and do not go through multiple
layers of wrappers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7efd12cbe7e..e36ed4dcc10 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2782,7 +2782,7 @@ static void gen_bnd_jmp(DisasContext *s)
    If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
    S->TF.  This is used by the syscall/sysret insns.  */
 static void
-do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
+gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
     bool inhibit_reset;
 
@@ -2816,28 +2816,27 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
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
@@ -5590,7 +5589,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_set_eflags(s, IF_MASK);
             /* interruptions are enabled only the first insn after sti */
             gen_update_eip_next(s);
-            gen_eob_inhibit_irq(s, true);
+            gen_eob_inhibit_irq(s);
         }
         break;
     case 0x62: /* bound */
@@ -5724,7 +5723,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob_syscall(s);
         break;
     case 0x107: /* sysret */
         /* For Intel SYSRET is only valid in long mode */
@@ -5743,7 +5742,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_worker(s, false, true);
+            gen_eob_syscall(s);
         }
         break;
     case 0x1a2: /* cpuid */
@@ -7058,7 +7057,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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


