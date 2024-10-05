Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8987CFB42E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2d-0006Mq-St; Sat, 05 Oct 2024 16:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2b-0006L5-OC
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:13 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2Z-0001ks-N0
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:13 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so2839772a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158770; x=1728763570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wa2JC5GTiuZOa9FUt+c/E5R/4D7wBSs90VoPwelenc=;
 b=Oph6G3SGoaxulsvPO1cbl6De/4CT6GGM7Sy8hNzKtC90KA43cXIGH5Sd6nL042+ksJ
 kWkRdklwrKgYVUGRmqJbuBwrmt97y6VFCOqWUJppjx8tPN2XSH3wv/p/WA0DNQHdb9+a
 fWD0x2q5cGQQ24WrYqNzPBfp8qq3rZzZaXKBtB7UC8DA4Qw7ad4+v3d+LR2DG/aaruhU
 r9iJiM/twGXHSlVCcdl8zk1ulaRSh11ttMc7jntQUlBpG8zk6dsxyYqgJoL6tbNIBlNX
 TNDvwO3VoIzAm0GMyAlFgHwlZZLz565FOjMW/ytJkBByI6qeGxXKPBAU7JIwyJncUAXl
 l9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158770; x=1728763570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wa2JC5GTiuZOa9FUt+c/E5R/4D7wBSs90VoPwelenc=;
 b=dRNfKjHxOKAyvD/G8ivCT+xUClwK4bu7mtl6lYB4vKkOgCgjpFwq76n8eZy4ShVnbS
 AUrMCmLNloxXbP5zwEgoO6DcTfIk5ku6xm+BjMyTWK2CBZM2paYG5qljWRrRcg322zHj
 nnrazNxgbBWb9s87KRHZAJWqNJwlKJAGDodFS2lRX+0FaLrTWQ9x5Aywy++AeKNPKGUY
 wVdLkam2iwlzmoG66JVj8OYaolJp3FP8laz7ucI+dPPx55TW7c9++L2TvBeUw7SgaeJZ
 cGZXIe2DGaZ160ZMz+7QKHuLkdLJrQb8REFKnBSNEDIL2/VL/JyG+KkRa2MV8W67clSC
 aK+A==
X-Gm-Message-State: AOJu0YwL9Eks/ZUgdO5PFDOVBCmP5sDE1mH94YuoEbAq9/5Y24IKBRnK
 lD0WOMOJfXv6+MK4qmtlAXpGGfzeoHRhGhpC6m0kRyjNLxtkbSlMW4f9zS1MCW7VqYqgwy2JVgL
 R
X-Google-Smtp-Source: AGHT+IEu/yRGIXzgnnxtsNkCW1Gem8iXzS/ffba0hjtpfN6ZQ1VIoxbuDWZWql5a5WIxSKhWPrRs6g==
X-Received: by 2002:a17:90b:3709:b0:2e0:7b03:1908 with SMTP id
 98e67ed59e1d1-2e1b38c7582mr16486887a91.10.1728158770066; 
 Sat, 05 Oct 2024 13:06:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 09/21] target/hppa: Perform access rights before protection
 id check
Date: Sat,  5 Oct 2024 13:05:48 -0700
Message-ID: <20241005200600.493604-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Data memory access rights trap" in priority order ahead of
"Data memory protection ID trap".

Swap these checks in hppa_get_physical_address.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a386c80fa4..f027c494e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -267,6 +267,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
+    if (unlikely(!(prot & type))) {
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
+        goto egress;
+    }
+
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         int access_prot = (hppa_is_pa20(env)
@@ -281,12 +287,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         prot &= access_prot;
     }
 
-    if (unlikely(!(prot & type))) {
-        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
-        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
-        goto egress;
-    }
-
     /*
      * In priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
-- 
2.43.0


