Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8627BCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay3-0006JL-Pd; Tue, 23 Sep 2025 17:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay0-0006IK-Qq
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axz-0003iG-6m
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2570bf6058aso82387525ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664470; x=1759269270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI01yo0kUGWJmBVW9EA2Eo0iWFIm1s7La1lCDq4SBkA=;
 b=qdOAGKq7VMRi2rtVVHF6ehiP0tuEl6ke3+5CsTA7/c9ls/rKj+ySkKYMyazZmIgYj0
 DId5UsrtCezR/W+cLLh7dqqM9geW6pJGoEpQho/IlX2VUCBilrP+wWNRj0yn4hMCPRhG
 BHfZhuGAT0r/YeyBI1gDJFQkoZ8gTXjZkWSF9t7gkrNX2MykDCUfBlVPuWSdrmqEJOZF
 d0hKB4xuAkp5faegKjuPam6xfhF4D9GqsvTnu+rxsoZq/Copgy35bi6exnNtOK9xsp7P
 V1xW8T8qEsmyG3XzMNjEHxc14UJ6UnT65hDMlaAYMk9c3R0cA/wfGe/lgs8gKGHlhDuX
 zkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664470; x=1759269270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI01yo0kUGWJmBVW9EA2Eo0iWFIm1s7La1lCDq4SBkA=;
 b=rS3AQEkV4I7SuLPsgwm6myKdmh2twnJa5+ycqDK5/YUtDlKzr/fDXOuskHHoJDMPMC
 d2fgGFn4HWzRLKQN4CzACtDH1hno9heu5+2SAylo2Qq9ckFmBGUjX+F+jI/9xgx5Y5vX
 igS7k9qt2CJxqAWZU45HBQ3/4MpH0O6olIBQEUeE0yvhnBerOVp4OplRNYnMEMbBLiTH
 LY1jTUPKEgkpiCY7PATbjL3i7RhguoMr8Nz/zNXJ9PUD1O1ShPj5UW+LjU+H9enJSm/g
 6z/nU5hsiv8xpodRYjQCfC+NH3DWr4GKDrlJEsNVY0/lpa8vCGg2R4h3Prf3mLpEXIMZ
 TemQ==
X-Gm-Message-State: AOJu0YxHeIxke/itiK4aBddYSwY86sS3BFNlvlTYIdx+/raew2JU+26u
 1860+yAO6fTh2cGzyHGkVdSRFMkYWG/vPZ4bS5x9FS7UsR/KQKuvgmxOSPEhpLPZ4AOEgSq//yc
 swAQB
X-Gm-Gg: ASbGncubHzsyMvRGBtSsqp/frpIkd4APA64qY79sdikB8I+QJWUHCdRAWzxvY4DhtE8
 +MjnO+VPZJhujrmlS+7ZtkSnSsjhU6BAn8aEl+LrbHURWnEG0FCtqhoOgQVrUejCBEYekAwUO/N
 hC0Ws4Tqwcp0B9Wvoc56kkz+JCmqUKwCUDfFcBqpIMYPNV0j5/Yqq9OVGA/lpoVa6oHLvVvtCsJ
 elQedmpMLYI7zfKXmYPrsSAj8T36LdZmPTqJG20aADWQUrA4fyniGqAiuG2S2/6DbmPfrCQlYzz
 +wKtFiOwem/Nc1lHzVRBzUwTyV249PtcIPnBqYv9FyXTkxNMHaDdr87Vo8/ZKMG+OxMOqw40YX6
 X9HlJbLCfqimZpMixY+2WrBjhZdGm
X-Google-Smtp-Source: AGHT+IHcYuBbcewqNEI3mRL74jOEb3uZRLQBgpWk7nlFGZ6+LNRdunme5Cfzda+pGBZh40NHotPVxg==
X-Received: by 2002:a17:903:3c25:b0:26b:3aab:f6b8 with SMTP id
 d9443c01a7336-27cc98a13f3mr54679475ad.58.1758664469764; 
 Tue, 23 Sep 2025 14:54:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v3 04/10] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
Date: Tue, 23 Sep 2025 14:54:18 -0700
Message-ID: <20250923215425.3685950-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
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

We only need invalidate tbs from a single page, not flush
all translations.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c594d4b916..8c1e0a4817 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,7 +8,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
@@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
         } else if (tcg_enabled()) {
-            tb_flush(CPU(cpu));
+            tb_invalidate_phys_range(CPU(cpu), dst, dst + len - 1);
         } else {
             g_assert_not_reached();
         }
-- 
2.43.0


