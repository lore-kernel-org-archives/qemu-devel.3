Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F2FCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 05:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpiMd-0000qc-J5; Thu, 28 Mar 2024 01:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMb-0000pq-IZ; Thu, 28 Mar 2024 01:31:45 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMa-0008S3-1p; Thu, 28 Mar 2024 01:31:45 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso366256a12.3; 
 Wed, 27 Mar 2024 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711603902; x=1712208702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0C6uoCntyN/0GokSPADPgOAyPjNhHghNpUBgAoFP4U=;
 b=bQ+y+lyN0RuwuANq17zvhbj5eV42Zu51bnQuW8RYwPmImt+ibkwYvq7HkkMA/MwS+U
 BJm1xwfcAYBqQdyy7oCJwyi8s2UAPPC7h0sOGVGfDVMOTxGRVUAILvKheYNpHZ0XOLLU
 9vpKcL0CaodqTe1nBvrXMbO34f8bIUwqJTQP7U+H2pcriq5TUvGexjNfCtrG7tPaRwDy
 hZboxuSfvcsXVTLES5JHXfRQ5h9EbrXm26LuPic9psYJsyKlKm/JPqA4/Juukob0VvIi
 rZm9aquWwEW7PHYN4DntHz4E+FU4aovHHSQhJTYUceB9xHEyEsNfh4iU1Rf7NEIKyLRv
 4JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711603902; x=1712208702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0C6uoCntyN/0GokSPADPgOAyPjNhHghNpUBgAoFP4U=;
 b=ITzEKMhSxYYKb7eztouXvuDTKzEf2SWtxt2Z7siEqMT3N37az2Wn4fVSD0JGvwWEuX
 7JWJ4NH1H2dvhYxGrhSuvizWazll+WlkUioENLe3aTh9a+hWbN0atn+IxCuUaTuSdPTU
 1EOEFl9gN28P2YCzvuDb1BKvjI6PzI7V+Tig5Yn2zJkDXySYW48BIJjXCzXEdfx6SmzN
 6sZhgXfwyMSCYgKmy+07qNWw6euBbzeZFfoO0z02S5jtvyNCHqhrE/PYOTcGgoFSy4AB
 98L30cdvRZLro8pe/LGc2ZkAD/AjwKQqXf9MAx0DWgh0DWqa4dvr+q8360CtInHzQs9a
 SPjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsMbIEH6PZewuItUWP5Z0jsMGR5jgi1P3tSr074epoPA9wjbv1cWMbaXhLETjYrAK/HZ7369NjB1421GXgcO9Q91cYU+A=
X-Gm-Message-State: AOJu0YyiMgNwmltTyaQCQkQ6eKDIFJq76j2tu+cfp0gUwnTgfRRTkLfU
 Jj9CMVBK/ZRQajO0BKdRMtkCM51qpOux86n5BVqpCR9poYuTjscojyI5eXenKfM=
X-Google-Smtp-Source: AGHT+IFZV6dYx36Jc/qGdv0whH7h/uJ2rH08JcyqgQzfaLOlXKIL1xk0en7E0dpiUK3djCKSLgJkUw==
X-Received: by 2002:a17:902:6807:b0:1e0:2f59:524c with SMTP id
 h7-20020a170902680700b001e02f59524cmr1663244plk.37.1711603901926; 
 Wed, 27 Mar 2024 22:31:41 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902654d00b001e211a290efsm535018pln.132.2024.03.27.22.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 22:31:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/ppc: Fix broadcast tlbie synchronisation
Date: Thu, 28 Mar 2024 15:31:29 +1000
Message-ID: <20240328053131.2604454-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328053131.2604454-1-npiggin@gmail.com>
References: <20240328053131.2604454-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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
clearing the pte and storing the memory. It's normally very difficult to
hit, but preemption of host vCPU threads could trigger the race
anywhere.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 2 +-
 target/ppc/mmu_helper.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.42.0


