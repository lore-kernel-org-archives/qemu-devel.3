Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9818CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsZ-0007V8-BJ; Fri, 07 Mar 2025 13:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsS-0007SN-JK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:57 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsQ-0007mq-H7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:55 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso2548909a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373813; x=1741978613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdNSdlVsW8pmir+q1TpDvW924tsDK1wZFdH64G2NXCE=;
 b=hCxtWCyJkDSYF/RTpfTFbkcHBgm1GJpLlAyKT5Xwmw/QKxiS943UKZJuiUX7mGkS+w
 j2+WOwnkSKP5d8M/Yj+Zn3imkh+jyfswmX7XANHIJnqhJpRoq9BkXu0dS1JnTIIwAzBn
 BKqnPEcBtLEm+XjZvUCq2VnMCkie2o4fwJlk1tKnyi0PjOo/+d6jgx7zNayrKXZkN56K
 i0nHUBNUj4K6gKpHHyOzY41fXZVgqJw0kFlVmb5i3IxeccyJVajoyO0Zo/I4MSUM50rm
 6yeyFwBvAGmCErHzjdMSyVV+zHSEdKnt/H3K8e94CQji40QzTTSdbkE3vxaUr3VBi3wp
 DupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373813; x=1741978613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdNSdlVsW8pmir+q1TpDvW924tsDK1wZFdH64G2NXCE=;
 b=gF9rCi7Lpqm349e/sa1qXxivcID///pK1xn12y1pS/WfwbknSygSEHpG1eiuJ9NZtF
 Bzxh3KDH965Q8YmZtDO6f8C3ESWEAKMNqe3RhD+z9hxMN/SgmuHc0JWyeiqdBRvo+ljn
 mq1J+z5BZ2HcbbHWDbORV2/KViw6cJGXb8grQmJUXNsTpkiEMyXrBvOatVYk4UFwtfmf
 cMN3ADRbviFS5geIJO3Iua3HLZAuYk8kwxo28dTQ1x5Df3kvf8fMjPHRIUuXWqIL2yLG
 hvhjbG40K+Cg5umsM+yRufNHiZzabqPWVoBFRv6oGffBDeRbjKU/JR4cJIJVXYRr02Ge
 FtuQ==
X-Gm-Message-State: AOJu0Yy6DEKtATVr2WF6UUiNvYET28dfEzTx6p5q+uInNqIcBknk+6JZ
 o3pm8BLnX4DVlitoCG6zCtaBu3JBM5TYWb0uckMIMvqljgsQwLofiIfOO4+gKVAByn0fM731j8Q
 p
X-Gm-Gg: ASbGncs8ivlmjW4Y3vxuoDO2A3wkg5V8G6aXS4zOA/2MEklV/zmEQa5GTKGiFFHUXD4
 5NIfH6n/9Vj/5/aZuY+uI5nUbSgaU7Sp3KByc6N3FOoamCF3A3Soz7jYXQtbWQIDe7cC+UN0G1X
 jPrrJaHH6pvsIYFt4EFbT2U7FXW3PTiop/sVVr+7sq8fc56zyIV8zXJrA3CK8o8Z7qrYuaOulzr
 UEcFMfEKgR39D3HDe078GTV59tiv650fdUB5424EamB+9eOTPp54qi5oTGkfck/OwzS28ZpCtF3
 b9CkuRnkGbx4gHaoYu8YDWRw2KeG+1MD0Xhr8/UOqgFFT/cg/j3VKMRTyX2+fYW1ZlTU0ofFtax
 U
X-Google-Smtp-Source: AGHT+IF9tCTKlgi1Wus6LHNAX3eQU4m0UXI5SCy8M5LlSsYYqmhMsN8gcyx2yt/p8ITtl0ILifBFcw==
X-Received: by 2002:a17:90b:2d83:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-2ff7cf317c3mr6389177a91.30.1741373813034; 
 Fri, 07 Mar 2025 10:56:53 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/16] exec: Declare tlb_hit*() in 'exec/cputlb.h'
Date: Fri,  7 Mar 2025 10:56:36 -0800
Message-ID: <20250307185645.970034-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-20-philmd@linaro.org>
---
 include/exec/cpu-all.h | 23 -----------------------
 accel/tcg/cputlb.c     | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 9e6724097c..8cd6c00cf8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -179,29 +179,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
-/**
- * tlb_hit_page: return true if page aligned @addr is a hit against the
- * TLB entry @tlb_addr
- *
- * @addr: virtual address to test (must be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
-{
-    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
-}
-
-/**
- * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
- *
- * @addr: virtual address to test (need not be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
-{
-    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
-}
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c8761683a0..fb22048876 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1201,6 +1201,29 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                             prot, mmu_idx, size);
 }
 
+/**
+ * tlb_hit_page: return true if page aligned @addr is a hit against the
+ * TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (must be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
+{
+    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
+}
+
+/**
+ * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (need not be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
+{
+    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
+}
+
 /*
  * Note: tlb_fill_align() can trigger a resize of the TLB.
  * This means that all of the caller's prior references to the TLB table
-- 
2.43.0


