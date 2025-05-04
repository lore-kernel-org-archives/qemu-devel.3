Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35C9C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRuu-00022d-Pt; Sun, 04 May 2025 01:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRut-00021K-6w
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:31 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRur-0004Il-Hf
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so3346306b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336568; x=1746941368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=bMkKxDWnpEPxNsgfs/tFPNN4aqrWwPOVDVa3IW6eWmCVCoE1Tk4QLko7GE+PmSw2wA
 orDS4dKpNTFqOKeu4jo8FyAYzq1S58IGHlRF3IHHUZztrROs9NTt1IspO+MAVUzFNtVj
 I7SZ2XlrdaFAAGwMtORA2rYZpIh44+5MMjvLWPNUQfL0Q0dxmdp3mT0oSmdVV6RuWeoY
 Un5x/gK6SugcU1dpq3HDmb6ZftedXOa6wfc+tWjt4QSgmarrm/nPbCyMTraVlNfzzwco
 XZYevE7tQru+5W7GZMiRRehmKH3YOsrw2AlwiLBZY9sliKshIoAcR+VyQtgVlB2R2mtI
 Nbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336568; x=1746941368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=ZU6D1dO1dwLAfIHssCLBhUyCaVNUmVk6+v/6rs6dNyajB5YP5LkAU3midGVN3wJVN+
 kTt8ArzFTotlbethEW4nlhUDCdfxygn57mHIAFw3PEFLC/ooIgP4F+tZR/MHAWhNFACr
 AEZ8L6QSdJEbTkl4iYN7IXnH2KCVwRIG5va4N4XOeT5J2lHC7JKv6qMzU8ASFZWtH7wX
 u6m4zF+JYaRrCcjBV9wH4pCqbspRxMtXjMXCuQNptQvTY8+j6wOkvxqwL4HCNjdlXifp
 JEB08r9hz5664JRYRi1M8x3PKgBcpL+WkdsLZ9ivyAiOis89Bq/WKzvdSPEuNr08BTvG
 TC+Q==
X-Gm-Message-State: AOJu0YxoQH4x2aZs4dAogR1/0hfadnKjnDBBNqPFVN8mBAzUyUSTYssg
 591iCKXEjJCBpdmx5w+3McyL1+Pw+3gqADZxNwoMiRR+iGqH2OhCPESd1PY8eHvXt0wslrklMrz
 95/o=
X-Gm-Gg: ASbGncvoBdwjWuwprQPbzO8G8GFiUMWIUWy1FbEGS11tunOYDN9+CXPvAII0u2wvwuK
 OPLKU8gLa1Eo69Q6jDAR/xA/xxlxJPdwYWkE+NJQM2QhQC7xpAJiWAqvsV53oe4rN+mhrQf8SU6
 NjjaotGfIW92RaQ5n6h6KGHe+sEMj2LLUegC32uLYxsMlboY8f2TXznV/XW4trVGB3QhGhEq2nj
 +uHxHRz0xHCyRU/Ak9qZaibYfjmwmNckxFVuLeqnTYeLBO1JGY4IBphddPDTpTK4cwDwSfhUzDR
 oUXuNfOwK+wJID9mJgnMMU8I74YCGAipJ7cJqNBn
X-Google-Smtp-Source: AGHT+IGu15PBf2rG0jV3bfDUJnP/9reL3xvY3YvbbIU6AzYvR6V/RBuTvzsbzlIgf0athadGHRLk8A==
X-Received: by 2002:a05:6300:218a:b0:1ee:c7c8:ca4 with SMTP id
 adf61e73a8af0-20ce04e699cmr13507222637.36.1746336568319; 
 Sat, 03 May 2025 22:29:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 09/40] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Sat,  3 May 2025 22:28:43 -0700
Message-ID: <20250504052914.3525365-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07f279fec8c..37b11e8866f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


