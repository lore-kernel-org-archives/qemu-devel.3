Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D81C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXg-0007BU-Io; Thu, 23 May 2024 19:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXe-0007Az-PS; Thu, 23 May 2024 19:08:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXd-0005dz-2d; Thu, 23 May 2024 19:08:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6765226d0so2763207b3a.3; 
 Thu, 23 May 2024 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505687; x=1717110487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRTmiW2cASA3rhl7leKTOZhlCbikObGe8oO9U2Jgdu0=;
 b=BQoMg4JN0EcXCFiIYWSnBXd6cGO94XB+VKHK9GBhfMTeUxplExDmUiF+ZyW/6SzDoo
 B3sFwnjyQ9omsITzsOLhGK9+t8IbsOSDtSH8qT8itEwYODs+wSsYtAn3Qg4+PXLnewc7
 vXAgxpp3X6v+Y1g3Q0RnsSq5Yk4FZjpofaXv4G7VUV+VeqmvTHSilZjKDx9NFepw0nhk
 fiwsqwvaR4Ae0G5w7BuMuqeUzQnOCe1DUp3She3zdNCdbPAWNETThKkcNPngbw4fRjle
 i8ulst8etbpLsOXw8PGYmDif/3zEH6HPb/I5FGiLowAMhjfR+65YplSa21bJjTaYu4XS
 OmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505687; x=1717110487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRTmiW2cASA3rhl7leKTOZhlCbikObGe8oO9U2Jgdu0=;
 b=eBgmUtZZ1dwN/NKtl3AhYg76SyqiYAwJ6hSKU2iDZSopxBJi/Nzl9CRSf+Hz6kPkth
 2O/p0CU4BC6BOaYZnQC+MXllwhiIkJBF1eDoI3/oHwtF7qHtmRIA5WxDWJE0vi5yA+It
 rqa+BOxboVebQCnCCzb387dNNH05pmh2MgT15JhxkOq8txX2GhRq0iinauYd1yq5Fufp
 fJ4X67XWHhdiDieaEqshRfDrme773k1guK4ji2yb/QmTtA0DrkxtlYmrRDXKM+qtX2Gx
 ZZYfcSytApNCSIt6faAWY07ericxr2Zbzdn+qaU1Kh1I+8Qn6ndKRGhmHnyXTwVzAJBu
 7AbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+fTwJCIyYqDiPusFpOis1RLl3ss4TdN6LxFAKtMA11OjVNKg2DKQA12ClaX3LtdsNj06q4bzCXBpxsjrkXyHI1XIn
X-Gm-Message-State: AOJu0YxOBuQVuFcPMupuJ9BqJiJpSzQ0zOlocaX8YpwCea4OkUoAhQph
 W/QsDC6RsawezqMVbRdHhpBQEg2KucY/mbq3PL0y3an6ram6SH6oMasatA==
X-Google-Smtp-Source: AGHT+IH0bejOIu18l+bF/y/C0RBJdiEVo2fPMxaPP1vnBNEH3JdUkDvs6xf5NhwmUndut4XlLERYAg==
X-Received: by 2002:aa7:9a84:0:b0:6ec:e726:b6f5 with SMTP id
 d2e1a72fcca58-6f8f3d6bfcbmr517650b3a.26.1716505687067; 
 Thu, 23 May 2024 16:08:07 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/72] target/ppc: Fix broadcast tlbie synchronisation
Date: Fri, 24 May 2024 09:06:36 +1000
Message-ID: <20240523230747.45703-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

   CPU0
   // *memP is initially 0, memV maps to memP with *pte
   *pte = 0;
   ptesync ; tlbie ; eieio ; tlbsync ; ptesync
   *memP = 1;

   CPU1
   assert(*memV == 0);

It is possible for the assertion to fail because CPU1 translates memV
using the TLB after CPU0 has stored 1 to the underlying memory. This
race was observed with a careful test case where CPU1 checks run in a
very large expensive TB so it can run for the entire CPU0 period between
clearing the pte and storing the memory, but host vCPU thread preemption
could cause the race to hit anywhere.

As explained in commit 4ddc104689b ("target/ppc: Fix tlbie"), it is not
enough to just use tlb_flush_all_cpus_synced(), because that does not
execute until the calling CPU has finished its TB. It is also required
that the TB is ended at the point where the TLB flush must subsequently
take effect.

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
index b35a93c198..d9d950e220 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -534,7 +534,7 @@ void helper_tlbie_isa300(CPUPPCState *env, target_ulong rb, target_ulong rs,
     if (local) {
         tlb_flush_page(env_cpu(env), addr);
     } else {
-        tlb_flush_page_all_cpus(env_cpu(env), addr);
+        tlb_flush_page_all_cpus_synced(env_cpu(env), addr);
     }
     return;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 49dee6cab0..24461c2d1b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3494,6 +3494,13 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
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


