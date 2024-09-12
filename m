Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08C7EE644C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socS1-0003Zo-1S; Thu, 12 Sep 2024 01:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRP-0000ys-9s
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:32 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRN-0003Bw-OR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7191fb54147so363088b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119144; x=1726723944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWryAgOwLMSF+r/4gq1tiWKnxg+KJOz4OtvMHYQlMIk=;
 b=PRQkvqtvZA4QDr1FYdRPIVC9c0PIqy5QChaNPk533IlDn+lp/K0cdkQOaUjs5WDKSE
 9wZOBbRfR/YUGmm4zWyJyALfnqGz7aMEf5VfFxC46y3QuF5Nwoscfq5hzihSzGsWbyz/
 QfkRwsb/SKEba8a9Pkj66IkLL3/AAnZMQsGUuivdYTGNCllqn/EUUZ9rWTHytx6/rs4d
 LonDKKOE5srGANJEv9pbfvPvbbaqjSDDn4LjUH9DxZzoFqXUdbeAB/Y9+FrTrgUKb6Ta
 XA52jfe94eVrbPsAcThqzpONhMYt4MBrFxnGm1Mb8wJE44egd0DD0m04P3aOkEhnxcDa
 vrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119144; x=1726723944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWryAgOwLMSF+r/4gq1tiWKnxg+KJOz4OtvMHYQlMIk=;
 b=ktub0fYtutL/2yhr0wfnSWc7PtKZ8ACIyXpYDxFXnJtw8jUsHMFPjqtFid9Xh+I1cK
 S0Ck4+HMnPjrVrYfSMVr4vil9iZxt3I45qTQASOoEoQP0vhBhKP8dKYh/tU2f6wSl4Jd
 p9Tm19HL3pHxeyu+1wZWauvjhjoMBviueutA9zmEoStFjSt8Q/m+OmjAH3mQmbKde1uE
 msDaMuyTYBRZaJvgURJMmcjJ9Pt4jctDYWl4D28xlw2EVwcNdgQpvPHsOltwyfA4Ef+l
 gPmPHsj257YZt8XTOPYP+CjiV5oBjk69UBBshfWH+E1VwVgyX4woraFVPBwJ9cTswI1t
 TF4A==
X-Gm-Message-State: AOJu0YxBPCvjCA9mp9yREff781/xjEaPtzc6tvr7s6HuPu2Dc2kNKk1S
 Err4LJbwGcYlQhd4bIWQlAIyKKdbXhsbwM04AbjgbMqg/gQn6gV1EX640g==
X-Google-Smtp-Source: AGHT+IGIl5jveHVwWGuuFk+fS1DwvPJL8BUDe40YpjoHbyqVXsfzosIGklU55xRNDILGJdR3WFW/rg==
X-Received: by 2002:a05:6a00:3e29:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-71926090ecdmr2621079b3a.14.1726119144174; 
 Wed, 11 Sep 2024 22:32:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/47] target/riscv32: Fix masking of physical address
Date: Thu, 12 Sep 2024 15:29:50 +1000
Message-ID: <20240912052953.2552501-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

C doesn't extend the sign bit for unsigned types since there isn't a
sign bit to extend. This means a promotion of a u32 to a u64 results
in the upper 32 bits of the u64 being zero. If that result is then
used as a mask on another u64 the upper 32 bits will be cleared. rv32
physical addresses may be up to 34 bits wide, so we don't want to
clear the high bits while page aligning the address. The fix is to
use hwaddr for the mask, which, even on rv32, is 64-bits wide.

Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240909083241.43836-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..4b2c72780c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret = TRANSLATE_FAIL;
     int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
-    target_ulong tlb_size = TARGET_PAGE_SIZE;
+    hwaddr tlb_size = TARGET_PAGE_SIZE;
 
     env->guest_phys_fault_addr = 0;
 
@@ -1375,7 +1375,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
                 qemu_log_mask(CPU_LOG_MMU,
                               "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                              " %d tlb_size " TARGET_FMT_lu "\n",
+                              " %d tlb_size %" HWADDR_PRIu "\n",
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
@@ -1409,7 +1409,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s PMP address=" HWADDR_FMT_plx " ret %d prot"
-                          " %d tlb_size " TARGET_FMT_lu "\n",
+                          " %d tlb_size %" HWADDR_PRIu "\n",
                           __func__, pa, ret, prot_pmp, tlb_size);
 
             prot &= prot_pmp;
-- 
2.46.0


