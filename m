Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DE8C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6j-0005fa-GM; Thu, 18 Jul 2024 21:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6D-0003xU-Pv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc68-0000rX-W8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso697091a91.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351263; x=1721956063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bUXzTdrPbw6J9v+TJRzwWPTfmVGuUdx4HTdstgXW1M=;
 b=eHfOuBfxlYFntoICqJAcXq1CW+YQXOKEnUwa+sy6LYJu+Ucy9vt/DVX6YtzJbciV78
 y2gY/yZ7m5p3rBbPDFqM/ySoXiTu9NvwNtns3t9bbjQH6VFUr4HsQ9ZMrakchGaX7pQp
 aVLAo7g4f26YvrEt2wH6RFZuyJhKNZo7h0eOFx8gf48wFt+KGvZHHKVIa+1em8g+HZwT
 p73tF9JayhQP+CnZQFGBIONL3UaljJZ9DRaRUjrALkzZ02xBKbBpy1s0C6YLKTLSosHe
 /1CFllgV+7pUuWSrejhDJc6tNjOua0X3iFtmuOckiBhp9EwlbOKwVhQufnthzSej79I9
 hJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351263; x=1721956063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bUXzTdrPbw6J9v+TJRzwWPTfmVGuUdx4HTdstgXW1M=;
 b=PCmnzCzKg2t+H4c7I5MEcUUKrzIp+UZNFP/9owkK0JlhWSMklH6a2SVlHFoQDjo6st
 W097gn5kr+MkZCq9QpFbxD0elLMNzfGgfCM2LN9Nj6ZACNT6BEqU1HJcKWthld6wTDCe
 kz0TrtfbO2uRLYaUK1ENngFbQo+4Ku6yvCTn+tvlHueFj0hn2P1xd1ErjhsPav+0hRl5
 MEgLCRhYfS+dtBVWf+teApcKqnV9X2zMQ4UVJnb8uiZJ9OjvsRXzjiWeWCNrQSWfZyI+
 946FkeFH0oLhQzqljymai7Tl+rYkzZD8+05cHDTRnkRa3PmvtZD3ogtpgIflLpBUli4C
 C6TA==
X-Gm-Message-State: AOJu0Yz9cBvrAn6njDANdp6GUTgNoFhxHEEGfaNOk5WTtl0CT0mQu7hF
 Xwo8a+QHQYmNVg2WMnSGoHdK7xNa9E1oJYzCaKaG7yPh/BBP8TX3N7FuXxBPEpSmg/kKyMJKDEQ
 gkg7UWQ==
X-Google-Smtp-Source: AGHT+IFwEW7dHs6y/yT3OG0IpseYV04+Gr0brN7p14g8wJ2VC2Ff2PwOEO9SC/Rva4EMrV4ScI4RFw==
X-Received: by 2002:a05:6a20:7f93:b0:1c0:f2ee:7dc0 with SMTP id
 adf61e73a8af0-1c3fdddca31mr7468239637.55.1721351263037; 
 Thu, 18 Jul 2024 18:07:43 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 08/12] target/ppc: Improve helper_dcbz for user-only
Date: Fri, 19 Jul 2024 11:07:03 +1000
Message-ID: <20240719010707.1319675-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Mark the reserve_addr check unlikely.  Use tlb_vaddr_to_host
instead of probe_write, relying on the memset itself to test
for page writability.  Use set/clear_helper_retaddr so that
we can properly unwind on segfault.

With this, a trivial loop around guest memset will spend
nearly 50% of runtime within helper_dcbz and host memset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 24bae3b80c..953dd08d5d 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -280,20 +280,27 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     addr &= mask;
 
     /* Check reservation */
-    if ((env->reserve_addr & mask) == addr)  {
+    if (unlikely((env->reserve_addr & mask) == addr))  {
         env->reserve_addr = (target_ulong)-1ULL;
     }
 
     /* Try fast path translate */
+#ifdef CONFIG_USER_ONLY
+    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
+#else
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
-    if (haddr) {
-        memset(haddr, 0, dcbz_size);
-    } else {
+    if (unlikely(!haddr)) {
         /* Slow path */
         for (int i = 0; i < dcbz_size; i += 8) {
             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
+        return;
     }
+#endif
+
+    set_helper_retaddr(retaddr);
+    memset(haddr, 0, dcbz_size);
+    clear_helper_retaddr();
 }
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
-- 
2.43.0


