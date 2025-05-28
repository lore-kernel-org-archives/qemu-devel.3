Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD028C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBym-00036h-BV; Wed, 28 May 2025 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwG-0008G2-9U
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwB-0005JC-Ar
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso4199592f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420084; x=1749024884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vs5hfkivQJt5wX/5toRxL3hVB3+jUHVP3+IxQEXrVGs=;
 b=CNGzHWI6w4P8pcBxPxXydslHPrZOL7lgzfogVXckuvWiCGz86Y/6Kg9/McWhr1tJfp
 faeDJIFXRmXrOJ4nw/excpzOb4R2eQY2iaBzFSdJkQEonG9uxx1wqDyv7VUy0RHGifnF
 LYma64GLsFUbAPUcJiib25BCflnwXMVHeQHva8W4C9dD35Y4di4B6wsVq1/5/YjvCkme
 oV3IwhB/aoVdSE8a5CRdpU7DWzw/75V8ZvomOcG3WhRIgxhdOSUCvYJp5/72Vcx3RzxG
 f0/+dVCBiX3i3n5g54vPvekcq7nZRlgNPlFtWi96xBiOergMutE3daJ3B3fEOEThVLXo
 OGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420084; x=1749024884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vs5hfkivQJt5wX/5toRxL3hVB3+jUHVP3+IxQEXrVGs=;
 b=PXSRvBLWg7oGhq7dhgePz7ZM/7guRq6yzWUE0EZbrGHk+4YPaPi9zZTiT3woE7fXCA
 Qv/xPR1Qj8ApRaE1sKK1oQuh8UB0nnYRjUIub5A++x1zO3bv0n0oSfzT/uS6bM6DFzFO
 9pJpEB7AhEka/kzGbK/lPNqCbRNgO6PGYQIFjPw3FxjNthyXTc6A6MpNrQ2sXjjZmJnH
 VUP/srhLBgCIb95SlxLZVpynw8ILQt3c4pk61T3SxYHPeXdRORNLGOnQvTk1Zbb4S6Np
 ah+IbOgsGJdKirRWq9dudmwI2elhFwIWyY9e4llxWkSMn4gTXMCDFbNqlyp5ulPV6W9z
 OeLg==
X-Gm-Message-State: AOJu0YxegM0IDvV4CdU9uymzHcY8h77nhHjHF9Tpye3ypGHlDxTpN/Kp
 HQQLJSm7II+0Gd6Cu5i8DclBdDziT9lKKVkfhHaEP8KfxL1PnRdHeF/bWRjUOVLC4dMV/yxyyvA
 x7wpfJQ5rgA==
X-Gm-Gg: ASbGnctg9FAX3fptIKNJTy7/zoz33GWOOWnNNPCahU58JtiO8+EUNyq4XO750A+Niym
 a/yTc/HiokFQmPeCe434zVd7JxwhcyPFWqH+PDvEXgx1j+n/zaRND35MTym3Tqxq46A6voGwxHU
 SghRKusVxAlo1zGjiy/iOrJwxYVFvpNew/CxJ1DfpqM+o61h+imxMOWC2Zb2SRjURJfgdMvzN7B
 cmR1MYnzbDZBqVaI+QWH2FBfLhUCMasmiGZndU446UZuNGVSMomCXsjWSR2AzxnYNBm+kSzyvXt
 L+KZpDk47KRasn1nsoFrsKzfYmetulRff8W6ltwXdJfRtBesnJt6vcJ7
X-Google-Smtp-Source: AGHT+IFH4EQm1xpr8tF79Fcjgva+csR/24zkjIyBxYkti00DOzdtgfTnlXPAmUDM7CFBjrcp1JbJ5A==
X-Received: by 2002:a05:6000:2011:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3a4eb7a2df9mr697983f8f.30.1748420084555; 
 Wed, 28 May 2025 01:14:44 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/28] target/mips: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:05 +0100
Message-ID: <20250528081410.157251-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check 32 vs 64-bit addressing state.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4cbfb9435a..1f6c41fd34 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -560,6 +560,14 @@ static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
     };
 }
 
+#ifndef CONFIG_USER_ONLY
+static vaddr mips_pointer_wrap(CPUState *cs, int mmu_idx,
+                               vaddr result, vaddr base)
+{
+    return cpu_env(cs)->hflags & MIPS_HFLAG_AWRAP ? (int32_t)result : result;
+}
+#endif
+
 static const TCGCPUOps mips_tcg_ops = {
     .mttcg_supported = TARGET_LONG_BITS == 32,
     .guest_default_memory_order = 0,
@@ -573,6 +581,7 @@ static const TCGCPUOps mips_tcg_ops = {
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
+    .pointer_wrap = mips_pointer_wrap,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


