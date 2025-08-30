Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4FBCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usODA-0002sU-P1; Sat, 30 Aug 2025 12:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQW-0007Eg-FH
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:00 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQJ-0004pd-Tv
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:52 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4dc35711d9so688081a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532806; x=1757137606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=FQfB1zLB1nRIdgI+BncuHSRsnkluJcMmR/vOvQLWRav9K861phZ1cmHE8CVqk66mhw
 SmxfLEuOpTFuhitrycAcb1PmKonoH8PDxzcQr7LE1wFYjrs33Q7GueaC2wCcBiFPxhdd
 hRGnL7lsXsE7F96/a/4gZsnG0CJuxkvtnnquDhA9r6dtYMdw/+VcIKLHKmpgHT2D25Mv
 g5nPml7AhMzR77PhpZ0iJiDxKUv/zVuvsMKaaokw2R8FvxFhOYWMAYc6m4EgW6g15W9F
 wTTIyQmunaqiUmcDi4bDXQxE9oPeJDrUHp0QNn3Ql8OkVS5wZr6vUljwhWkp9DY6BtBA
 is+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532806; x=1757137606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=BlzlVmme3NTC+QpR4P1dYyzH1xpHzofxincXXtq/GANZvNvrD2qEqQWUIQGHk/kUD1
 7zUvd8JQlSR07r/69uqDpGp9uFdP59xIhrx5vEZDtert6Poppirr6G0JYy8AY3JIfgTO
 dHL2v1PdGYqmsWpZvNpS6R7QB9ZC8fbbWlGcxUK6ibOxP5oh6erIYbBPwbFUy1vL075m
 u83R7GKQJO4D1E9p75iJjWXsqg3O2giCkwjyg1DYPuCNIxbhEMTyFh3yJbWhd3TJbA8n
 5eqRnKSQyRuXkpfelUPyH18/N3Pdx/C1/uNR3OOO/cwiuSK5hzw9n+puExcJLZ9NnSF+
 bFTQ==
X-Gm-Message-State: AOJu0YwAKYBAWIhz6BsI917uIy1Twz7NJIJi5sK0hSdyi5LRh3UNVk0f
 vqSYeJP053EUEaTGiDsVtxgDLwPmkeasV+ZdSu/I/D2+N9pmXDfkjV2Pei3gLp7WBb+MygxfO+w
 /Rd3Sy/E=
X-Gm-Gg: ASbGncvIFdLq2IW7g/yjjQiSbQvFDArjR3HwUPdA4cZp6pQALDx+RVkH7+yrVloeMuj
 4JGD0nu5ryEqK/OxZuXpWH1/PXmIRG2Zz1d/z601kJCqnoZVcKmTIeESGK5nhXIToIzvUGQriv7
 c6ZQ9lNmdodtnyAoSTefc9bA9NIFyqPUKYzVBsKZB+ftPEZ3okMnGzJYiCgGyg1SFD2XDf1Xubw
 3Ves1/m57zGvh6j5PyMGkeKVyQQk3ZGC0YZUjgGn9Uf3RBSZwELzUyml7aOAbTZHv8gFU859nfe
 jk6f16PH8lCMOQVYgasRP0joZ5mexRJ7nAEodJMcFV5cSy5aT2qlnH9OHnaqBJ7n77bce1xC224
 u+EnDJ4F5n+1MdjmlHwjmS7AYnf/dSDfjgDcnQlx/HkScBPVo/DtWEiZSM6YhWAw2JBcPZrgMoQ
 ==
X-Google-Smtp-Source: AGHT+IENyNyEVAuyalTEbfbRr0O62gIKo3HxW95LAEcbR4IxvqWRKzdjc3cxPf5hr5pS3iVUodaPHw==
X-Received: by 2002:a17:903:1aa5:b0:249:17d1:f1d5 with SMTP id
 d9443c01a7336-24944b29de0mr15030175ad.60.1756532806361; 
 Fri, 29 Aug 2025 22:46:46 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 46/84] target/arm: Implement gcs bit for data abort
Date: Sat, 30 Aug 2025 15:40:50 +1000
Message-ID: <20250830054128.448363-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..f1983a5732 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -28,7 +28,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
-                                            int fsc)
+                                            int fsc, bool gcs)
 {
     uint64_t syn;
 
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)gcs << 40;
 
     return syn;
 }
@@ -252,9 +253,10 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
+        bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
                                    same_el, access_type == MMU_DATA_STORE,
-                                   fsc);
+                                   fsc, gcs);
         if (access_type == MMU_DATA_STORE
             && arm_feature(env, ARM_FEATURE_V6)) {
             fsr |= (1 << 11);
-- 
2.43.0


