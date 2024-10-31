Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A5EE68949
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFm-0007Ey-8p; Wed, 30 Oct 2024 23:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFk-0007Em-Vc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFj-0003tP-9K
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso4908805ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346822; x=1730951622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppmjnBV+ZwGtUBNsYIvDijQ5bVMFS/e+QNA+9LIDzCQ=;
 b=SB329mmUFDwN5yLzteBsrKGKPQwptBlesSbaKtl/1z8TYiygVANRnmu8TBRAMgEycz
 UEVM3p8HVBXdm+qInxpGl1YLx+l/OXd3X2iEYPofTmdmIdM4ru1yxlJXh6IOTSD2jW2S
 ia+Ago6GZC/eTAms6ouYMUY9X6lLTdFoKkwtZD7TCLVv+PQM9VC1qS5kLMWUPaEbmYdk
 hvw0FAjDxAtWNnDg2syEaGo57+/18GUkD4XBh1rXUJFBKEB+W5DPUVru4eFB3W+HRILe
 NgjHk8ha5xZhDdsGUPv/aD8Ck/a+SQRQl2xVm9/nKSNNUInt6BAh8KbY+w8M4sadJRoJ
 QAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346822; x=1730951622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppmjnBV+ZwGtUBNsYIvDijQ5bVMFS/e+QNA+9LIDzCQ=;
 b=RoJFKbDP/6trIXojX7CTU5TH4jMqSg3wOkm/jibzrhxoj3CRU4ikh5oCSgdOOtw6IA
 lkKb9t19atTij597H+dq6c11yyGwu5AH1eII+vvxO0Yi+0goolKC/ObpOO3XaVpQihoy
 oHywuTqFAL7whqGKNJfCZb7InkrBvzY+Cogca4lyQmbUSOJkBReZVZ8wzEVJIrEFcMhV
 wXMQ6THnRI9jVmC1Mr4Ik2iBSAO+k/EnZatcHLrO5UZ3uLzkUP4hicrUQuEp5Z+Zkpzm
 MOOdlKiBTGGOyVgIj5eVFhwSv/W1dqPrHdUNkxxwoDR2uyF7deeP11SD/ebtT4sOXpRj
 65SQ==
X-Gm-Message-State: AOJu0YyN//24E8nYezaL4fs151xL+BU79g03btYDMGtemfYZgKL1c39k
 2TRhS5b1v6OZbNVpaXayeHHOZgQ6ZW7bo1SKPHEiyb/nnsAAoFcAD7yewHTD
X-Google-Smtp-Source: AGHT+IFXi4k01eXY7SNftpzidxtwjCrbmsfTB9nWkOOEnVzihDt0KqrzNwQ/OMke8Bf/+uNv16kFsA==
X-Received: by 2002:a17:903:244b:b0:20c:ce9c:bbb0 with SMTP id
 d9443c01a7336-210c6724215mr225965435ad.0.1730346821747; 
 Wed, 30 Oct 2024 20:53:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/50] target/riscv: Detect sxl to set bit width for RV32 in
 RV64
Date: Thu, 31 Oct 2024 13:52:33 +1000
Message-ID: <20241031035319.731906-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure correct bit width based on sxl when running RV32 on RV64 QEMU.
This is required as MMU address translations run in S-mode.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-5-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a935377b4a..621bf4c1b8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -890,12 +890,14 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     CPUState *cs = env_cpu(env);
     int va_bits = PGSHIFT + levels * ptidxbits + widened;
+    int sxlen = 16 << riscv_cpu_sxl(env);
+    int sxlen_bytes = sxlen / 8;
 
     if (first_stage == true) {
         target_ulong mask, masked_msbs;
 
-        if (TARGET_LONG_BITS > (va_bits - 1)) {
-            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+        if (sxlen > (va_bits - 1)) {
+            mask = (1L << (sxlen - (va_bits - 1))) - 1;
         } else {
             mask = 0;
         }
@@ -964,7 +966,7 @@ restart:
 
         int pmp_prot;
         int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
-                                               sizeof(target_ulong),
+                                               sxlen_bytes,
                                                MMU_DATA_LOAD, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
@@ -1116,7 +1118,7 @@ restart:
          *   it is no longer valid and we must re-walk the page table.
          */
         MemoryRegion *mr;
-        hwaddr l = sizeof(target_ulong), addr1;
+        hwaddr l = sxlen_bytes, addr1;
         mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
                                      false, MEMTXATTRS_UNSPECIFIED);
         if (memory_region_is_ram(mr)) {
@@ -1128,7 +1130,12 @@ restart:
              */
             *pte_pa = pte = updated_pte;
 #else
-            target_ulong old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+            target_ulong old_pte;
+            if (riscv_cpu_sxl(env) == MXL_RV32) {
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+            } else {
+                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+            }
             if (old_pte != pte) {
                 goto restart;
             }
-- 
2.47.0


