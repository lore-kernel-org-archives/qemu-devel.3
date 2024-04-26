Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB3AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RSv-0000UO-G2; Fri, 26 Apr 2024 15:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSm-0000Is-VP
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:29 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSd-0002nX-35
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:24 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso35053341fa.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160536; x=1714765336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/VvS2kWTA4rqEGF0JfFrfE/nD7tnjsws7S2+jUi5LY=;
 b=LLZ5gaaUImzu1QoiVR+g9ULSvAhAyfPWE8DzzB248TJP0C6FPFUTy5tiP0Ih4ImyvE
 LxpCpcYjVLMocCj0VpcLU2/fJGCxjC1RWB1RaQGx/rk4uAFhPcx1S9ANdyGvF4giUA7k
 hqNMsI1qLvDrtyZZeFh/zaoMUAQNLIHsC+nD8MRbgZwTpT/nfLxaFk4pZs10iXgcGxX2
 XfUrHI922nC+qibQPhyJTJJq5Pgnfcfwve0XBXz5MhSbLK89aOdGwgeTeO3gd6Wiwimg
 fyXNGAhLIiPI4d4f7tU5MmPg0tkGBGEtNNXflEiutuD//pXgRaQSKz8JbsCzcDNKcVvY
 gr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160536; x=1714765336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/VvS2kWTA4rqEGF0JfFrfE/nD7tnjsws7S2+jUi5LY=;
 b=RzVPAovwDdwradiw2XltQ8ZY88i/Xh9OsaUIYeyrTCPNLba1IH52+yebobH/ZuUlhK
 k16ToONpgI+dh+7NzCMF29Fv/USjeGsPc0jfIydazId0MIXZ3ewPeafebzQbcNVtBjSK
 NQuqeXhQ1LM1VFjH+84Pol8+s9V9yx7R+YyytpGEnA4L/Yrly9MkW3qhRFWhUVRg6uHc
 T2iHvex2W6gofuUOS1VCLyS9+UlPZh409+eX0xtHaI4WxJOQZr19zJCjRGotEAwbqGw0
 aicq0p4LhFGzHhibDh0kuxlCewrTQP3uBwNCT08jYij6B8vT1wfO0AyJsXbcUrPiMibF
 lz/g==
X-Gm-Message-State: AOJu0YyaqxbsDz1EikMTHljEky98kppSQ+aQDgdktYSHGlPodxDtQpfX
 sATJVKLvWwHoq9zgLJuM9GfwvJEpJ3KnFkj6PjsFuKXBA3RtMoHPlGWHuNJFGstuI/rjF+KMFy0
 011I=
X-Google-Smtp-Source: AGHT+IHeLtSXNpoa+2cufMxIp9ptF0cVlDgusmb+EblTSh2hSulYqomjm/YGG71rxaX9oJD/tEzuCQ==
X-Received: by 2002:a05:6512:4806:b0:51b:6366:3459 with SMTP id
 eo6-20020a056512480600b0051b63663459mr2820804lfb.67.1714160536378; 
 Fri, 26 Apr 2024 12:42:16 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 c26-20020aa7c99a000000b00572405680e8sm1789128edt.21.2024.04.26.12.42.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/38] exec: Reduce tlb_set_dirty() declaration scope
Date: Fri, 26 Apr 2024 21:41:22 +0200
Message-ID: <20240426194200.43723-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

tlb_set_dirty() is only used in accel/tcg/cputlb.c,
where it is defined. Declare it statically, removing
the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-11-philmd@linaro.org>
---
 include/exec/exec-all.h | 1 -
 accel/stubs/tcg-stub.c  | 4 ----
 accel/tcg/cputlb.c      | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3e53501691..9599e16a09 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -654,7 +654,6 @@ static inline void mmap_unlock(void) {}
 #define WITH_MMAP_LOCK_GUARD()
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_set_dirty(CPUState *cpu, vaddr addr);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
 MemoryRegionSection *
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 8a496a2a6f..dd890d6cf6 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tlb_set_dirty(CPUState *cpu, vaddr vaddr)
-{
-}
-
 int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 93b1ca810b..e16d02a62c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1039,7 +1039,7 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
 
 /* update the TLB corresponding to virtual page vaddr
    so that it is no longer dirty */
-void tlb_set_dirty(CPUState *cpu, vaddr addr)
+static void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
     int mmu_idx;
 
-- 
2.41.0


