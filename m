Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCA606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFfL7cdc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLai4-0004i7-EO; Tue, 27 Oct 2026 02:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLahA-0003hV-HY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLah4-0008Fg-KA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso678743a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082593; x=1793687393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+F5ozcPU80MXYFAuIcg9vhn/h8mgxfMthTunab7OQpE=;
 b=IFfL7cdc8SUjTpr09hSA5jS0SP2OsaHcuaX3Fv14TyP9CzIg3M4/erYSxXSuG/j3Lp
 m3Z2576FCXXchX9UlDMTjJzvgRCyHtPAmB5UG6RpzQQYxsBOs14w0wRPjGsQI7nIgqnf
 Tm201rCiS2JwH2MGwa1hTzeztuYmAJqZgFulC6jwz1SI1ReRtZae1lq0ccoPQaRlTne4
 Oz3POEU3BrKXHSJXT8+RENme0R4t2aOOZNmVQisHVuYnRwNpHoqqTharUUybLQAbWjMq
 o3Jba0g+H23W/w25714VUL6B0oVQwc4ZgADpne5Q/HmG2OQADZAm1JzJ3Xc3Gv5gqyYE
 eDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082593; x=1793687393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+F5ozcPU80MXYFAuIcg9vhn/h8mgxfMthTunab7OQpE=;
 b=ebe1CR3xpHTynbVwJsELCWOT7fAMowUEtLgREhGaWOs3d94+ChQvdyt78aUdyPAQRV
 rE+5DPYX/NkXeeFtpIxy4EwMx4EerPP1WIlmjPEITbLNPtFw9C0NAQhDX5eMTLu8zOg6
 /vzjjX9nv9psO7WxeI6UVA4EC+fWULDDzeAjJZXbV8a++eq262dWv8EIY1Dbh2zbsRKG
 t9wQrbO5v7tmmHi725s+RuI4Kcs2ePW9B/srefrcjB5JrbOmL1qXaf4MUFuc8QF4Rdi4
 JAQhUx2cmJ2LA9U4TiqzE/TSnBykFMrkQqkI81EcOKzuvrd/t71QPA8cNKY7LXKvR+LW
 hVcg==
X-Gm-Message-State: AFq9FYKh4opl3ibrelSYmP23rJlKOFDbNhcQJL1Gx93YKosWgva8iuSC
 wY+ZQj+/RuJFUGSsg4P064s9t2YmXnjneDU2gPqi89N6nJbMknvL/5AzTfZkbA==
X-Gm-Gg: AYBFou1BRKWtmX7hsZgHHVgX9gjdcGrFoZU1FzqFrnSV0S/Zw2TNtNUOL31eU35JYKf
 k6NmfBUh6tZEQL5tgLkdfYvnu9czoJ/D/MIjYZmCOornjFFhWBCk40f794lB6pK9tOyyezJWGrC
 BVA1HmcUKfqEWtsCiqsPpkbKauRY1262NLvfB5DFsz/Jlmrv1vPzgejFJ1cN39cldXBCjtQJ02R
 X+PoIKcOwxU+o2acN8S64K+bpRywTXpXN3GF8vtCHBNpfVug/KYq5x5bG/hHmxYjoEXMrUf2ugG
 n+doHF9grZU4Utls73lP+y1iK5/uJE2xUgn5Jinbv4vkn7KMhmZmsemwBB8vJIKi5hRe/3ml/G4
 NmTMTEFM0M2LaliAKYBBr68kacnrNKQpaxmQUmpvzfFly4epNsucDqew+YbJ0qOoanYmcyJbMue
 7JpPnOSbRyEjoeZPoNFZckEqcd5vADRpCDv0lol6euNNloO3/afJkG6yXpIzqfghnln9VLdkf6W
 YR1E/hDLipA0h5zBCSwJTRpkR0YexO7mf37+ro4jAuzBEX/H8/QZ3iAj4xqhTGbjSgxmMM/PxS2
 WL3cp1mRyqLBRw6GexPwHY+E0WrNhLPJfkWv/AHrT9pRr7Mc3n3FREte8yrcanhnTQw3
X-Received: by 2002:a17:90a:e18d:b0:3a7:9045:fe29 with SMTP id
 98e67ed59e1d1-3ade9b2cf0fmr6980595a91.4.1793082593111; 
 Mon, 26 Oct 2026 23:29:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Harshit Mukhedkar <harshit007k@gmail.com>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/29] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Date: Tue, 27 Oct 2026 16:28:07 +1000
Message-ID: <20261027062808.1995205-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harshit Mukhedkar <harshit007k@gmail.com>

pmu_timer_trigger_irq() reads the counter by passing
(target_ulong *)&curr_ctr_val to riscv_pmu_read_ctr(). On RV32 that
pointer is to a 32 bit type, so only half of the uint64_t gets written
and the rest is whatever was on the stack. The high word read from
riscv_pmu_read_ctr() is then ORed in on top of that, and the result is
compared against the software written counter to decide whether to raise
LCOFI. A stray bit in the garbage half can make that comparison wrong.

Read the low and high halves into their own target_ulong variables and
assemble the 64-bit value explicitly.

This was found while looking at #4724, whose reported mhpmcounterh
mismatch is fixed separately by 57b484e2d232.

Fixes: 74112400df65 ("target/riscv: More accurately model priv mode filtering.")
Cc: qemu-stable@nongnu.org
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261023093522.34335-1-harshit007k@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/pmu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 1a4658319b11..0165faf06b86 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -355,7 +355,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
     int64_t irq_trigger_at;
-    uint64_t curr_ctr_val, curr_ctrh_val;
+    target_ulong ctr_lo = 0, ctr_hi = 0;
+    uint64_t curr_ctr_val;
     uint64_t ctr_val;
 
     if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
@@ -383,12 +384,19 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
-    ctr_val = counter->mhpmcounter_val;
+    /*
+     * riscv_pmu_read_ctr() stores a target_ulong, so on RV32 each call fills
+     * only 32 bits. Read each half into its own target_ulong and build the
+     * 64 bit value explicitly instead of passing a cast uint64_t pointer,
+     * which would leave the upper half uninitialised.
+     */
+    riscv_pmu_read_ctr(env, &ctr_lo, false, ctr_idx);
+    curr_ctr_val = ctr_lo;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
-        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
+        riscv_pmu_read_ctr(env, &ctr_hi, true, ctr_idx);
+        curr_ctr_val |= (uint64_t)ctr_hi << 32;
     }
+    ctr_val = counter->mhpmcounter_val;
 
     /*
      * We can not accommodate for inhibited modes when setting up timer. Check
-- 
2.55.0


