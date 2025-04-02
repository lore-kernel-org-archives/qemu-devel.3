Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD07C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fe-0004Jk-Jo; Wed, 02 Apr 2025 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fb-0004I5-Vu
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FY-00066f-LE
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso1768485e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627829; x=1744232629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sxbMVhD3bEvS83tquXFpF0OjRyJof4LX4BkOe9da+FA=;
 b=f1MkhKGD6UxmvSzQEBd8JH42lua/ExFFv4Du8tJ2VHPKhylNgLQ49vvvFzl8irbaIo
 4NnQ+afYcS3aKlzoo52GX1migPjS4pE6uLzwSx9L4kOxrYM4h2A6CYXNUPIw+NWOx6GJ
 A1C0h4uMzvYLnytHTyabbKnxsNp64a28811OLnvCsQOggbDPKyaZGiRrthMPAsShE/tk
 sTeoLZ4ovPjusB+L1RU5GwYool5vPlX/Bfm+UKg4mmcSZEJXKpjhYxlBRrXg56sckS+a
 8SXC67T89I3qYsMm+h9pFBA3+/P/XpJJ0uZxaz1Rg46/0stNyk6ixYXIxRn+fNUhMxbO
 0OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627829; x=1744232629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxbMVhD3bEvS83tquXFpF0OjRyJof4LX4BkOe9da+FA=;
 b=hxMCfvgE84ECbP//Xx68iJ4uyrfI1scsRbMJrkx9almTUs3M4oWmf2RyRRER0qiiat
 C0CQmzdoqQSZ6Duj63qMz9H/wc/tzJF2uh0TiVHEt4z1Ce6MW1q9kqq6nIu2Hu4xpL+A
 ucBw/G2y2iDmb+bvgZZHZkInQ0Me/wQvmfqHPSlT9obGQ3x+Aixp86sdng2Xb8O0ba2k
 3kSIRz46ROpTpXPxrf6MWxzDbHG8M0MiBWYyDW14Q1MaWFOgNAPuajFIvo1VYWmNjt+H
 1RSrKZN3kMlOd/xNOtB6jzYEUe9mdePHtav93nF2fIMzwST8pYwJvmKwvSgdoC17mTKS
 ysHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPTf8iSZB8zCyggRH9UsHuPoPU66FvpxOcFeEAOo0BoG2D39WnraXlUswVYqicwgKTELNhHkgnYTb+@nongnu.org
X-Gm-Message-State: AOJu0Yyz/h8NTqqD8IgdhafofTsNEgchZljbibcB0+qM1Unaflbp1Ru1
 r0ArNRiCNEO6CAL7Z6I93IU2ht4FRbiu6Vw1we8lsHIUuHgQdnvNGxQZ5TNF+jNFNuNaCXFeaoB
 t
X-Gm-Gg: ASbGncvHhmWp0DREI4hZ53cSX83c7bFtaH+Ll6V18kP5u716/UNxD9iEaUYEOYKSuaR
 sIOiH1GH/LuZYl8LH+hZDsklsRFoPAzOCMB5+2Vh0/kQRCCWH2f3lzOJgI6rDdPpnOWWHmcQPR0
 3sWBbqg6HRRnweZT7kxWKgejqr7OaOyP3NoZbgdJh7VTfPqnotNjNgTtsQllsiKLDPOxvlr9vvm
 hZP1pSrmLLb3LzATIrhgemQnViu8/UfH+tR8TDrnyjoCEuO8BgE6Y9sEn9BpViGA+/yehtt6RDJ
 wgQyV4zOPzSR8a2XvIPLXF29UmbMAFvaPr3hI1sWVOIjiTAe073lmsj5PbJ/69Xp/q773kIato+
 nqjmIkT8iINpERcC9JOY=
X-Google-Smtp-Source: AGHT+IFyx/ADxTDJ3l/5k9lF0izabW1IqTtXZ0I3Uut75AqVObKJjcrqEwYNFPOr4KVkjP3y77GkPQ==
X-Received: by 2002:a05:600c:198b:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43eb5c20f9cmr39794575e9.10.1743627829448; 
 Wed, 02 Apr 2025 14:03:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656afsm17751785f8f.40.2025.04.02.14.03.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 04/43] accel/tcg: Introduce TCGCPUOps::mmu_index()
 callback
Date: Wed,  2 Apr 2025 23:02:49 +0200
Message-ID: <20250402210328.52897-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

We'll move CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h  | 3 +++
 include/exec/cpu-mmu-index.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f21..106a0688da8 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -67,6 +67,9 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /** @mmu_index: Callback for choosing softmmu mmu index */
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
+
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
index cfc13d46bea..651526e9f97 100644
--- a/include/exec/cpu-mmu-index.h
+++ b/include/exec/cpu-mmu-index.h
@@ -10,6 +10,7 @@
 #define EXEC_CPU_MMU_INDEX_H
 
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tcg/debug-assert.h"
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
@@ -31,7 +32,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    int ret = cs->cc->mmu_index(cs, ifetch);
+    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
+                                 : cs->cc->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
-- 
2.47.1


