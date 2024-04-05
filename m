Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884F9C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj54-0004Wo-7T; Fri, 05 Apr 2024 08:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj51-0004Qm-VC; Fri, 05 Apr 2024 08:54:03 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj4z-0000tk-PR; Fri, 05 Apr 2024 08:54:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so1510416a12.2; 
 Fri, 05 Apr 2024 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321637; x=1712926437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=useQ7jYU2MVSZLWPS4tiRLnS8UHaOQWjS/2uSUxE11M=;
 b=LJRVGL/MhF4UuZY1VeVNZ7Izyznz4cQ8GdqolpnqxbYkqgj6zLdyB71TLqxo5doUpB
 /KfZ79MDRXrVI0uUxLmIILaHEG97dww5R1TxnrGMzcPglz9k8Mq2rVJBwWf7wBIPN/Zo
 AzSnKC8O/oKDdJ/DbER93x4wU4YnJUNyS0izpXh5BwN53a+ZMtm/imxGYzXnfBUMKdqm
 AILDOuaxF5Js0zP69GDShPjj+fhKYTQu+jinuV+u4r79HwUOdwQPK6sB5uLcPMpAE9SN
 lcMlSrS+cUgqGlk7YZwsir7TtfRA6+BqjOQ6hrMu4THn+lXtUMmkA7RG50Lf8vfGn9KZ
 GuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321637; x=1712926437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=useQ7jYU2MVSZLWPS4tiRLnS8UHaOQWjS/2uSUxE11M=;
 b=gREUHW6KbOyzsB9gbUEa6UK31JdHTn+zcKl5wmWyLaPdCPbWKRU64mCZs1J/vCNcKd
 yEtqUOUco6llBIaN1pXm5Qwpt0JbApw+tUHXoeu2ZQwZj0F4JugR6mWsHGbLsPSxfrwS
 JJnKRk4qye35rgKvdyHesULvw6viEpPD5xggSksKDaD2YkYobE3ilqO9YCQhdNoLQalX
 C5F5GjSpUrYghWsxmdBGitINrt4V5OE6Vunuifz4ipPh7dw/lmBu2TtT9BmZDlTnU+9d
 ya2gTLLxR4FjviKvqEInhf/Zb2zosL1HfNHqBAe82JUvXDz8SC6auapqwFgyOzr8DqNm
 vmog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9syqTDXr2g2PoFLRo7O007ufQJFhCZQDfPR07VoMYr4REjM4vcru7LlrverkmN170a9fxwFu+ZBBQCNZ43EiBpiqAmnQeYkBnGtQfNirWVJ1lHgwovKpy4NNI9pzY9NsuMiujEuo+W0pyiVetBJ+2AjJjFJOOGjwfN7SW8MBHax5eo8fTT3DF
X-Gm-Message-State: AOJu0YzM0mxHJuzQ9JqyCaXtv29wCyHVOSvThKcKsGZp8yZ9D5ae08Sv
 4vqRhCDcDKtvOnA4bAJaLNbHDvvsQLfWvSq54/s5F8mzKw1I+F0vOt8E+BX9
X-Google-Smtp-Source: AGHT+IH4vrl7IB4mP5sojqjM0bhc9Ks/6XmoLXQ+79O5Isz+A4wLoaWzL4tI8yP2PQs+/25e06CAJw==
X-Received: by 2002:a05:6a21:196:b0:1a7:1c7:69e6 with SMTP id
 le22-20020a056a21019600b001a701c769e6mr1597667pzb.6.1712321637590; 
 Fri, 05 Apr 2024 05:53:57 -0700 (PDT)
Received: from wheely.local0.net (124-169-104-130.tpgi.com.au.
 [124.169.104.130]) by smtp.gmail.com with ESMTPSA id
 t19-20020a17090ae51300b002a2d8d34009sm2984414pjy.27.2024.04.05.05.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 05:53:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 1/3] target/ppc: Fix broadcast tlbie synchronisation
Date: Fri,  5 Apr 2024 22:53:36 +1000
Message-ID: <20240405125340.380828-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405125340.380828-1-npiggin@gmail.com>
References: <20240405125340.380828-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With mttcg, broadcast tlbie instructions do not wait until other vCPUs
have been kicked out of TCG execution before they complete (including
necessary subsequent tlbsync, etc., instructions). This is contrary to
the ISA, and it permits other vCPUs to use translations after the TLB
flush. For example:

   // *memP is initially 0, memV maps to memP with *pte

   CPU0
     *pte = 0;
     ptesync ; tlbie ; eieio ; tlbsync ; ptesync
     *memP = 1;

   CPU1
     assert(*memV == 0);

It is possible for the assertion to fail because CPU1 translates memV
using the TLB after CPU0 has stored 1 to the underlying memory. The
correct behaviour would be no assertion and possibly a page fault due
to pte being cleared.

This race was observed with a careful test case where the CPU1 checks
run in a large TB making multiple loads so it can run for the entire
CPU0 period between clearing the pte and storing the memory, but host
vCPU thread preemption could cause the race to hit anywhere.

As explained in commit 4ddc104689b ("target/ppc: Fix tlbie"), it is not
enough to just use tlb_flush_all_cpus_synced(), because that does not
execute until the calling CPU has finished its TB. It is also required
that the TB is ended, which will guarantee all CPUs have run the work
before the next instruction will be executed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c                     | 2 +-
 target/ppc/mmu_helper.c                      | 2 +-
 target/ppc/translate.c                       | 7 +++++++
 target/ppc/translate/storage-ctrl-impl.c.inc | 7 +++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 25258986e3..9094ae5004 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -334,7 +334,7 @@ void check_tlb_flush(CPUPPCState *env, bool global)
     if (global && (env->tlb_need_flush & TLB_NEED_GLOBAL_FLUSH)) {
         env->tlb_need_flush &= ~TLB_NEED_GLOBAL_FLUSH;
         env->tlb_need_flush &= ~TLB_NEED_LOCAL_FLUSH;
-        tlb_flush_all_cpus(cs);
+        tlb_flush_all_cpus_synced(cs);
         return;
     }
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c071b4d5e2..aaa5bfc62a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -533,7 +533,7 @@ void helper_tlbie_isa300(CPUPPCState *env, target_ulong rb, target_ulong rs,
     if (local) {
         tlb_flush_page(env_cpu(env), addr);
     } else {
-        tlb_flush_page_all_cpus(env_cpu(env), addr);
+        tlb_flush_page_all_cpus_synced(env_cpu(env), addr);
     }
     return;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..4ac8af2058 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3495,6 +3495,13 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
         gen_helper_check_tlb_flush_local(tcg_env);
     }
     gen_set_label(l);
+    if (global) {
+        /*
+         * Global TLB flush uses async-work which must run before the
+         * next instruction, so this must be the last in the TB.
+         */
+        ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+    }
 }
 #else
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index 74c23a4191..b8b4454663 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -224,6 +224,13 @@ static bool do_tlbie(DisasContext *ctx, arg_X_tlbie *a, bool local)
                                  a->prs << TLBIE_F_PRS_SHIFT |
                                  a->r << TLBIE_F_R_SHIFT |
                                  local << TLBIE_F_LOCAL_SHIFT));
+        if (!local) {
+            /*
+             * Global TLB flush uses async-work which must run before the
+             * next instruction, so this must be the last in the TB.
+             */
+            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+        }
         return true;
 #endif
 
-- 
2.43.0


