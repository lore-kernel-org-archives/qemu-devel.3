Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4C2C3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP0-0008Qr-7r; Sun, 04 May 2025 16:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOl-0008Ky-HB
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOj-0006vq-Pq
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227b828de00so40210655ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392236; x=1746997036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmYZsTnUMl5IM410FTxmeaTfbTLbZEPczwGnLZA+ci8=;
 b=ZlXj37l1cH6WkCgYG0biKDsGVOZekxarHbhS+2En9ybbCOVN9eXZdQXoHapx8Y7qep
 WBJ3asQJaKTdXoE2GO5eQuerJuI8NlXRK/PPYYTXl5X5I18hJxvWeQSL/i3maGa6LFpW
 V0RhR1BlzQwvT8JPFNGMBh55T4RTJpNpWCW44aIfiTZIiZq3zkGxPTkXfnkqEniol6o3
 KcfqdBvP4ZKB73CHCh8s0ZeFNBwp6QfnJgU2EIcVWMsKPKbm4v3b9+FVlUFpvygGd1U5
 hi1nI2RPyIfyzNkCt+P6fFy/0z5uMnKM/o8ybP8+rndyeKwYyM9zB8wwKqskjs1v11N0
 RLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392236; x=1746997036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmYZsTnUMl5IM410FTxmeaTfbTLbZEPczwGnLZA+ci8=;
 b=jesl7MVdHQ8H0jmu5onapFkw+HlfTOjB9EZij/mcSvoTLmRz4tT0Ncy3nz9orjORhx
 BBN32g+srrTFFrZS/tPxCDf956vfS5E3O9wrcXtzNodXmFMJtj9MNZb9OcpXjo7wsc2k
 9GcHFzIOk2Qf3i8abr4tTHiz8H8Wee3NFAx579dQNyPFlDYrr+xKKObLx9ppMA+Wh3Hj
 eYRw4wFOxb5YT1JvrePv2G4J8uYBU7GuPgDiF65cvfsAvpaAmThw7szJkwtpWoqW1lci
 LAACWHWpzzmwPqktoHNqaTablKD56FzoYhT2riZZ8yabq6X3fPixA9ST5wUZad99iD5X
 vHVw==
X-Gm-Message-State: AOJu0Yzg0i1/1XGucarXXVPpjSTr1NJ+yk+53m0+7kTGREuoA6Gv3eln
 EGzPcVx2YFDyeDMY0FL3j4kQmQ4Xo1fNMDcjuXg3GsQM+B+NN0pRT9WjvFzJ3AUZEvY7us+CAAv
 L
X-Gm-Gg: ASbGncu8Iq694X4QchN6eelvq9spnQU6gTg/djwp1gyhx3oXpp66ZC3FfA36PDPUgbM
 Z+j8CvOunvmzK3oGkqd8idxnYTjeEzYTUUfhc3Yj7KxIlPtinVt74xg+iJMSuVVauWHufgjPhO+
 not0EZHdrYH4/dS1QsekFug1kxY9wBm/eCuqrh+6p7uMYoA39LNbd5D0Bgftmq9EYxDW4IfJ+2P
 tSetttj/bbL0VR2R1BskheZflq2PMGDOYMMOgVcr30zxLIQnlRtKpg5Bf+iVgLMU1K0qTQHcwna
 arZlYg/RPdpVC/Muwb3vMkd5NzZjmXuc51KDlBmtcQ9UH4wb9tnos+sWG5sUvI/+VM+0RQ1QmmW
 cdiaRU8TGCQ==
X-Google-Smtp-Source: AGHT+IGuoAZumEs9l6mRec7LrlKGjZQ8Ll6m00v1ZFPiZy10gN3SMeOpS054wvkS0piQgmMAB0AS1Q==
X-Received: by 2002:a17:903:4403:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-22e18bcac92mr83986955ad.18.1746392236258; 
 Sun, 04 May 2025 13:57:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com
Subject: [PATCH 01/12] accel/tcg: Add TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:02 -0700
Message-ID: <20250504205714.3432096-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 7 +++++++
 accel/tcg/cputlb.c          | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index cd22e5d5b9..83b2c2c864 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -222,6 +222,13 @@ struct TCGCPUOps {
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
+    /**
+     * @pointer_wrap:
+     *
+     * We have incremented @base to @result, resulting in a page change.
+     * For the current cpu state, adjust @result for possible overflow.
+     */
+    vaddr (*pointer_wrap)(CPUState *cpu, int mmu_idx, vaddr result, vaddr base);
     /**
      * @do_transaction_failed: Callback for handling failed memory transactions
      * (ie bus faults or external aborts; not MMU faults)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5f6d7c601c..c394293d33 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1773,6 +1773,12 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
 
+        if (cpu->cc->tcg_ops->pointer_wrap) {
+            l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
+                                                             l->page[1].addr,
+                                                             addr);
+        }
+
         /*
          * Lookup both pages, recognizing exceptions from either.  If the
          * second lookup potentially resized, refresh first CPUTLBEntryFull.
-- 
2.43.0


