Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF9CD1280
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 05:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpiMk-0000sk-V3; Thu, 28 Mar 2024 01:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMi-0000ru-IN; Thu, 28 Mar 2024 01:31:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpiMg-0008VQ-9i; Thu, 28 Mar 2024 01:31:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso13283105ad.0; 
 Wed, 27 Mar 2024 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711603908; x=1712208708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLSWb/szZO14hNBwYoBx42bH9NiuYRFQa5Hxq4e8oD4=;
 b=WUFiubUO4lt7xB4Wi5M+iIUJmTUTTkked/WNNfDP4FhKCKFSD7+NQlz7O9FQbQaV31
 TdG7T+IJcuZ15/DFlmqeu0KctqekqbFn7LlGlJvmnZ4KLP2NPDa3/SW4x3lXF+bFOXa4
 N0oiaFh/BqeRfBrk9lUoqeW27FYFpknXAJuTaaoNEK7rf8DtjmNHvoMZpeuZUi0ujta2
 7TNaPztKS8KfFiDCvIhK9OgwS4FM04G5y16dcG6gzwhuPOYV6j1aDIVbP6hRWdxGoVXm
 KqgR16qergsJsfUj2UxUV4JgTlXReQL5mXCXEvHTUV5A9bU8t0n1Jar/UyEMuCRNnu/m
 qeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711603908; x=1712208708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLSWb/szZO14hNBwYoBx42bH9NiuYRFQa5Hxq4e8oD4=;
 b=lXrAJheRJiIVS/yR4DfmFJQo3ziU0KIwD2hfH1k3Tpm9cAMJP/pV2QEoLW8aeX3HRi
 KQvAp+0l4Wq/imdRknlRf4Y4hZ8h9qgAoD5u1GF/Y3N9o/dy69/tLG+9PjbGkUkxWSSM
 ds77wuN5Gv9L3OFoZ4pbhoagfhgisC07E74fjCjgRKrLwO/SRvFuc9gVx/Ym9tUQesEz
 lutKIrXSjGEM6oHyOqJecAeaYyBBtHhgAZEe7vI1rbphSMTjCCfZmseZNH7uR2AeEczp
 lBDAXN8atHYJvcqsLIurjLYiImluk/MBqA1lszff78ywn9GJvD/vnutVz1FQL63Pr1aS
 18Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxoWuhuyHZIcbGXRC2mPcXYJq/UJScsSVnEWx/KE9KU+KdbHK90MB6Pb+BVfdGqbtvjS99kAXlnb4tkNxMge56ebp8ayw=
X-Gm-Message-State: AOJu0Yyl2N5nCaBToP44o3ZfN9uwi5m0u6r4L0wlpxhH5A3Rg01WDUTN
 iqfHK/4v9CqaLGqo272GyFiQZL7o/4MH5AecFrrM1Tr38JhUW00ocfoJLc6eiPc=
X-Google-Smtp-Source: AGHT+IGafdWMaGmL0SPjbl4VrdLio07q9TGTKSzybTEYvmIYMP+TlL4kQF35w9Y687ZKYjN2f+Ovtw==
X-Received: by 2002:a17:902:d511:b0:1dd:8ed:997d with SMTP id
 b17-20020a170902d51100b001dd08ed997dmr1849716plg.3.1711603908216; 
 Wed, 27 Mar 2024 22:31:48 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902654d00b001e211a290efsm535018pln.132.2024.03.27.22.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 22:31:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/3] tcg/cputlb: remove other-cpu capability from TLB flushing
Date: Thu, 28 Mar 2024 15:31:31 +1000
Message-ID: <20240328053131.2604454-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240328053131.2604454-1-npiggin@gmail.com>
References: <20240328053131.2604454-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Some TLB flush operations can flush other CPUs. The problem with this
is they used non-synced variants of flushes (i.e., that return
before the destination has completed theflush). Since all TLB flush
users need the synced variants and the last user of the non-synced
flush was buggy, this is a footgun waiting to go off. There do not
seem to be any callers that flush other CPUs, so remove the capability.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 accel/tcg/cputlb.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8ff3aa5e50..1fe6def280 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -366,12 +366,9 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
-    } else {
-        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
-    }
+    assert_cpu_is_self(cpu);
+
+    tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
 }
 
 void tlb_flush(CPUState *cpu)
@@ -560,28 +557,12 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
 {
     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
+    assert_cpu_is_self(cpu);
+
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
 
-    if (qemu_cpu_is_self(cpu)) {
-        tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
-    } else if (idxmap < TARGET_PAGE_SIZE) {
-        /*
-         * Most targets have only a few mmu_idx.  In the case where
-         * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
-         * allocating memory for this operation.
-         */
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
-                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
-    } else {
-        TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
-
-        /* Otherwise allocate a structure, freed by the worker.  */
-        d->addr = addr;
-        d->idxmap = idxmap;
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
-                         RUN_ON_CPU_HOST_PTR(d));
-    }
+    tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
 }
 
 void tlb_flush_page(CPUState *cpu, vaddr addr)
@@ -744,6 +725,8 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 {
     TLBFlushRangeData d;
 
+    assert_cpu_is_self(cpu);
+
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
@@ -764,14 +747,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
     d.idxmap = idxmap;
     d.bits = bits;
 
-    if (qemu_cpu_is_self(cpu)) {
-        tlb_flush_range_by_mmuidx_async_0(cpu, d);
-    } else {
-        /* Otherwise allocate a structure, freed by the worker.  */
-        TLBFlushRangeData *p = g_memdup(&d, sizeof(d));
-        async_run_on_cpu(cpu, tlb_flush_range_by_mmuidx_async_1,
-                         RUN_ON_CPU_HOST_PTR(p));
-    }
+    tlb_flush_range_by_mmuidx_async_0(cpu, d);
 }
 
 void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-- 
2.42.0


