Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBB7CD1297
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj5D-0004pV-Hr; Fri, 05 Apr 2024 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj5B-0004o5-CD; Fri, 05 Apr 2024 08:54:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rsj59-0000yE-Kq; Fri, 05 Apr 2024 08:54:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29ddfada0d0so1520303a91.3; 
 Fri, 05 Apr 2024 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321648; x=1712926448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jARGZ5t8qjs1XSZjo4NZHkEKWxs+rQQU56W1uBL9n0I=;
 b=Brx37PE+2hszUmqqb3cuzk2ToxGzpJTPxq/INiZ3DFChwKBkA8hrDbdR3etp2lKnLp
 8Eu1dvDMifoMYuU4kPmX9eDXAwACRsPofl8+qTqukAZW1VaFPMOXAvOVjK2VhU8GiEUz
 pJ4ZXkFLR37oIfkYag4ThaN8x4VWatKzPFoRmvMLJorrLqG0Comtr6S2rrCnfwrUk9iz
 cOONq/0V/n13kvl/sWvx4zuYEXoUidLKvvoKqTeo7hTySAJjEBv+6b7tRa4JkuLH+IoD
 r9wPvcglVSGA1irB2kqn4AF+4O1vc1hyyqk8mfZ2iqc4xoUVPC47gTSOaxxKDZ9sl03Q
 AtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321648; x=1712926448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jARGZ5t8qjs1XSZjo4NZHkEKWxs+rQQU56W1uBL9n0I=;
 b=KMCQd6L94kVEiVAD7U6aJDGpEsupKZ+Iac/f5zfPbWbthc1W/0Yk/BtL6JXhuA24Lx
 Oamg6tgAdzLO5RNnhRQTW7VqZrucM8uVKVguQ6p9+hMLkQMN0BghoLnib01DSsFukWr/
 ijX4q++fkLMevrd6hNthcrJVCIFbXAJkwzI77S7lvFGPSrCqEMhm324SMCQXSAmCabon
 cyUJusqLOATSeeo3Aes/y1EyrnZHb7gCLP+Tfi/Isx3GMn5Eqw6qwf20eB8v/WbWuVyD
 UMG+nu3HLc+a4OVDSrHtiDFbsOi6cukkmQCoN165F51GHJJ75CkfQLzjlg6DXW0jvzY3
 0MTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPAu4Y240NnLgNP24kL6T5KyRwNYdaen/Ic+PexIrwhgxcjjaF216xrAOEBeRh2TgjG66j/NONCJKa+AtJ8CS4cCKeprvk/im0eKXyn3O+Dz97sEuU67Q+gdhbv4PrGfFM5sBiOVJ8ullrAwWG4lZ3xS8UgD5gwFsBUK5IzNJowKo8vrYjU7MW
X-Gm-Message-State: AOJu0YxS+YcgVk7PvlWERtBXu1pVAtNglgov5+h+5fsalVnitwvv2STp
 dLf/s4cVuUspOU+knvtw4KZa9EhFiZOj92xBHPkAtOekzDf18zvYSY80CyA/
X-Google-Smtp-Source: AGHT+IHb1xZVS1TxNfGKMYCQuLGSgcvhQNH2E/XTkIAWoodFPQFGj/azdYKyOY/ZHn6j7mrwFVKiCw==
X-Received: by 2002:a17:90b:46c8:b0:2a4:82ca:4516 with SMTP id
 jx8-20020a17090b46c800b002a482ca4516mr568882pjb.5.1712321648367; 
 Fri, 05 Apr 2024 05:54:08 -0700 (PDT)
Received: from wheely.local0.net (124-169-104-130.tpgi.com.au.
 [124.169.104.130]) by smtp.gmail.com with ESMTPSA id
 t19-20020a17090ae51300b002a2d8d34009sm2984414pjy.27.2024.04.05.05.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 05:54:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 3/3] tcg/cputlb: remove other-cpu capability from TLB
 flushing
Date: Fri,  5 Apr 2024 22:53:38 +1000
Message-ID: <20240405125340.380828-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405125340.380828-1-npiggin@gmail.com>
References: <20240405125340.380828-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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
before the destination has completed the flush). Since all TLB flush
users need the _synced variants, and that last user (ppc) of the
non-synced flush was buggy, this is a footgun waiting to go off. There
do not seem to be any callers that flush other CPUs, so remove the
capability.

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
2.43.0


