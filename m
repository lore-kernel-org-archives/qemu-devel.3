Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AE6C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXs-0007H1-Q5; Thu, 23 May 2024 19:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXl-0007Eo-EK; Thu, 23 May 2024 19:08:18 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXj-0005f6-QG; Thu, 23 May 2024 19:08:17 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-681bc7f50d0so151382a12.0; 
 Thu, 23 May 2024 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505694; x=1717110494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTU3YRtFQJnscRLORpazwzFhMRi8nDXQ8CTx8TmsNlc=;
 b=NJchB7+h52jMrRLLZ0J0dX0GdgFtGXxEpO3BxidVDzCdh97zWTxZe0pyU3Yov4Jd6y
 A7+TR5z4IZTrkOrfmrQ0wMY0eSNEg35qCslM3AhbyEKxG8HBPtsCVFR3Gy+vqrG6Hzav
 Fjc7Cvg90mRGdT+laQ9/2xBo5ZIFJYyBCCBNWrFNZgqRzF37YQCPVa8AvJ4chS2g3sWl
 Z0r0NkPxNdzwQY1JXT2qIZJC7aGiT6OQhCul9VRQ9CucRujfzHceDUoTVOdXXd/abKeK
 OOm/T43UGpzq4pd9sxl/Ch9OhBEQES4hGgbWAO/cUVWhgJoMAQ5V2dMN0MkMpgK17881
 Q4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505694; x=1717110494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTU3YRtFQJnscRLORpazwzFhMRi8nDXQ8CTx8TmsNlc=;
 b=gz4bahGKkeUdzG9DcEXBx3i0ClRnF7t5ZUjp9t6nkjyV7kqcRjKokgmD9scrsJPw81
 Mef4uVvexKbluYxrfDNdw91N81KRceX/r+pEmXGTATGCetSohxu1fopf9qNxAcaPw6Jm
 aQpaWfIkXzn7nCV0Cjwyhz+KBOy2TuxNMBKzapqvN+juNHXdkdmTlH3uUqDVPeygcvnE
 IGHVvJ2Db/YBKoox5/U8TZ/mWThwmr/wVKMzXTHNFgKa7I2oSF8pyGQBmjuGNKM3FL6I
 5h8hpN+Xn2z2ePHvTvWET3x6uGR+BiiC4Si1I4XTrIXdiVF0K3mwSJIl6TlSGbhdvCCv
 wKkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ptJcnrYz1Ad1ciVHXxELLOnEGTClQd79WDTsfqDKMsY0f4eQ8O57r7WEKIYs7UnylvQkqAZi/Xr/KXbX3/eqIphw
X-Gm-Message-State: AOJu0YzgUUKFRRlle09r4n497nmthBEfvIgujSlzDNKY+hXvKkHwnS97
 C2jZ6LCe2CE+IAr98raxZatfKUtGmYvldR7IHjVILhRKeur62Wy/k9aNyQ==
X-Google-Smtp-Source: AGHT+IHezfNCx1LOEUiX1pZzgMb7iVoIvqNedfoP+VW1cjtWhC1geLVycnvGcbcSYqf0JSvMVu9dGQ==
X-Received: by 2002:a17:90a:c08d:b0:2bd:faa4:e075 with SMTP id
 98e67ed59e1d1-2bdfaa4e0a1mr2538006a91.6.1716505693595; 
 Thu, 23 May 2024 16:08:13 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/72] tcg/cputlb: remove other-cpu capability from TLB flushing
Date: Fri, 24 May 2024 09:06:38 +1000
Message-ID: <20240523230747.45703-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 accel/tcg/cputlb.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 45799869eb..117b516739 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -418,12 +418,9 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
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
@@ -612,28 +609,12 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
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
@@ -796,6 +777,8 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 {
     TLBFlushRangeData d;
 
+    assert_cpu_is_self(cpu);
+
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
@@ -816,14 +799,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
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


