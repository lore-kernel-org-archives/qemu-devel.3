Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF1CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJJ-0001Nh-MF; Wed, 09 Oct 2024 11:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJF-0001Jt-Oz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJD-0007wF-Fh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71dea49e808so4428350b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486540; x=1729091340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/kCglcC+IjHEzmMz83kkwbAHqcDArOp+yBPf3gcvXc=;
 b=b/JOfgfol/fc7xdAIgmwzJsPYXxaj8zBDil2Pv4RnketqR8WOmDlCM84KZCTGVQDZh
 HpOudEWA/LsP+6inzzGUvofY23xMLQcvAf3ArrTiqFdkFuFTIu5nJnPQaXhPbZTlWtif
 GDwkskY+mg+YfzS9H9OE1xp8chNnn6PD2chI2AC6qwE3rNLw2dU/VglleLCIfbIotETN
 jDp2RC3bbDyPEvMiFE8EK9eYSi2ipWD0c297ga+Z9Fpl1MH5Xj/xuvKBw2yL4GDy9zja
 Bry1b6zgkKf/wPKkXItOWGRYpW3RKfpNRvVKxFD6g0BMCX48Cjv5kOIOE2JU8MQcFnmB
 QSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486540; x=1729091340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/kCglcC+IjHEzmMz83kkwbAHqcDArOp+yBPf3gcvXc=;
 b=GaeErqw3EgAyl0pJh91MvagP1zo7aOTxFCt4Frde4iiQwkMbT9AfFthrK70gJY5oJD
 iSV5LSmoRvrfOQlbsOlMhSHG7A6TzNrFfJaTi30DVWj7JFfI5UP1JJeIuCB6T17PeRTX
 6DXEWZRfMRppDU9kVJZrAAvI/ZtWChFKgj5NRMbX0rx7yPNgz3o1y9HB5qtWGnR5FU/z
 drEn1RMnH/5bt8OtE7K59R9i1nPa0TdMls4nPoG53Np5yk3Y2LFr0hcPZFLCu6i7CC3o
 7TEbUuOIego3f22JSatwSSBt802/rFMWga5wn350G2A7XnF0ajyIeTK5KlHLuQCYtnku
 YrMg==
X-Gm-Message-State: AOJu0YxTLeYoV8qjMoGkKqwfHbo7s6Q042vlZezVr0yLFCdTrV7BLQwV
 aEMv5j7YQ8Gta39OO3+SvzVHZfe+Mr446jmIqsGrXfN0/ZllQpgl1uES6OlrzfpADHAgnAf6tic
 S
X-Google-Smtp-Source: AGHT+IHdRRW3ngb0pz896g8Fgg6Z3mN7oHu1GCmpTxcOt5SqBUdwH8gVcMZOFUfLJeoSWE4V7zSl+g==
X-Received: by 2002:a05:6a00:2d8d:b0:71d:f7ea:89f6 with SMTP id
 d2e1a72fcca58-71e1dbc20cbmr4603234b3a.18.1728486539868; 
 Wed, 09 Oct 2024 08:08:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.08.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/23] accel/tcg: Split out tlbfast_{index,entry}
Date: Wed,  9 Oct 2024 08:08:35 -0700
Message-ID: <20241009150855.804605-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Often we already have the CPUTLBDescFast structure pointer.
Allows future code simplification.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c1838412e8..e37af24525 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -131,20 +131,28 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
     return tlb_read_idx(entry, MMU_DATA_STORE);
 }
 
+static inline uintptr_t tlbfast_index(CPUTLBDescFast *fast, vaddr addr)
+{
+    return (addr >> TARGET_PAGE_BITS) & (fast->mask >> CPU_TLB_ENTRY_BITS);
+}
+
+static inline CPUTLBEntry *tlbfast_entry(CPUTLBDescFast *fast, vaddr addr)
+{
+    return fast->table + tlbfast_index(fast, addr);
+}
+
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
                                   vaddr addr)
 {
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
-
-    return (addr >> TARGET_PAGE_BITS) & size_mask;
+    return tlbfast_index(&cpu->neg.tlb.f[mmu_idx], addr);
 }
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
 {
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+    return tlbfast_entry(&cpu->neg.tlb.f[mmu_idx], addr);
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
-- 
2.43.0


