Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBA5CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06px-0007Fg-QZ; Sun, 13 Oct 2024 18:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pb-0007BA-TH
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pa-0000w3-Bf
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so1872749a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857573; x=1729462373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQhK8NjjgW/kNvx5X1m22TpA6VVxTZtyOqTVcWaZJho=;
 b=OTdi2pZTE+Fn3O4JPFgZhKlCfD5zIAkUzIKSiUaGh9rC9Bwj4u4q4Y4KGkN2jOr9+e
 U34JHhzxBvLvRUSTHJ5IHBXwZaqvNVR4fub67YMKTD0kdi/2yp+bItc4iXevNM6Lfdea
 wsbLaNBPSTwOCHSVsLqvt4KU9OpIXbIx0SKMURfU3JsPlBc/CnSktiXWsrapbU0RlD9T
 tkfq2O5Ka6dmroLLNvppCDmHnL21hn4Fc60uQlhqnw09BvaItJgL4qOOaqXCMPsG6sPV
 +c+cKpJc7ffEeQ+gXwLY2rQpdbtoHA+G/U6/VrM4cc8zKrpOqPzSU0fyYdz8/bJFN9/B
 23vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857573; x=1729462373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQhK8NjjgW/kNvx5X1m22TpA6VVxTZtyOqTVcWaZJho=;
 b=wJOCthiL7eP4cDARtcVXHtTJMlAXh8FCF4t6Frl6iGrFKYX9NPW9rqQxZONxIojMbN
 O9WnFlFlPFnPRkIDlA78AiJR2ZY5QztwBY11b783zHDTLiKF/XXyEJNfsY2Anvpe6twm
 sEaS89y59idhWrfgquX19PRwvjN/MDnpTNVX41xC93c4++i7y7LR58Z35SeZLA0CpfoV
 fPx2CfGm26TPQkJTAqHiyUEXJ2CBBJ9gEQctTGES7oNBPqVqz+YWXL4mCmiCcQ1MVC2P
 /YV/mDcA8SaCuff4W2jJOugchCSgazeU9tw5JiGYzZHs/V4SE+g7uVnEKkp/IdX9GJxn
 uJUw==
X-Gm-Message-State: AOJu0Yzmc+iY2YII4arANBQ3gDMzksxHUT9gA7rceFRozuQa2kvQzVX9
 1ooC6u2DvqAAaWUNsAgWt7Y3fohFKIUCf9q47oq6K78484QGHRW6XrUOGoLQpFr4WFGtHTis5wz
 Q
X-Google-Smtp-Source: AGHT+IEgaK8a2Vo5XpPXWgoTsWI0uEazrqeO36i8Bvms9BIIf/O3KcC36AjePArD6VFLCm1TQIuryA==
X-Received: by 2002:a17:90b:3015:b0:2e2:d434:8547 with SMTP id
 98e67ed59e1d1-2e2f0a0f7a6mr12860504a91.7.1728857573108; 
 Sun, 13 Oct 2024 15:12:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 17/27] target/hppa: Handle alignment faults in
 hppa_get_physical_address
Date: Sun, 13 Oct 2024 15:12:25 -0700
Message-ID: <20241013221235.1585193-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Unaligned data reference trap" has higher priority than
"Data memory break trap".

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f71cedd7a9..d38054da8a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -221,7 +221,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             g_assert_not_reached();
         }
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        goto egress;
+        goto egress_align;
     }
 
     /* Find a valid tlb entry that matches the virtual address.  */
@@ -323,6 +323,11 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         }
     }
 
+ egress_align:
+    if (addr & ((1u << memop_alignment_bits(mop)) - 1)) {
+        ret = EXCP_UNALIGN;
+    }
+
  egress:
     *pphys = phys;
     *pprot = prot;
-- 
2.43.0


