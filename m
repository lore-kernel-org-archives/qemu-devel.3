Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C63C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG9-0005wP-0D; Tue, 30 Jun 2026 23:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFw-0005iX-Jl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFs-0002p1-IP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c82538b6b0so983685ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875091; x=1783479891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iDK5Y5tKY1GYf0B8NSrA3z/u0Rrzqvpx7FoJxemUn0=;
 b=QH2K5EC6fZGDBuX0KzzCD9IHdFIELb3gu96gDdlS/Ldq72hOndf5oC4YkJQSFSOXrY
 +oNRPnjkPeZngPIP+OlizmQcT9uLlRI1KomZdMNZP9AxLgPgzAX+gEk5f1mCHXrZ6try
 1e6c4hObDNjJ7fN/hTR9qVjnxiHmOy59iulxlrKCxPitoTZmD+r30xGsn3MQDH0hwdXS
 SaD6kFRNL/zlpSf1fgc/82yUNbgcRNfJmMq4kdY31vrwvJWNYRG2Sjz2Om/FEf8riZQh
 qtIg0jiGo4xc5icdtnJb8wKZUtjaGqKUF0ygyoubhPH2q8Ycvtr4TZaKtioQVcqvPpaR
 xf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875091; x=1783479891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5iDK5Y5tKY1GYf0B8NSrA3z/u0Rrzqvpx7FoJxemUn0=;
 b=b+Lw9t9iM0ZFy3z3SgtV/kYUyYPYtmgHFtNZ6qK/Q/sHkDTbhFXZgDYQKDNGfFFJqf
 0BykEAx05VssNx/4cJlqhdQAPC3rxC3Eehzq3/vF0uFJ7MZNJmW/8teiLOdAFfBs6i5l
 Xe7TUd3f3zkL17LcfMwZ6UiPMiVvm2kmTxyXhf/No9IFpgEPEvCwDa64p81TiwGZRNjz
 hAbotY6hCAxphQTUa9eTD0aDfFQBde3kHEEAov9UlArc/x9dfrM7Dn51+uXbz7+MmR2q
 fgKGs+iv6jMEaOxJIbH7Lj+BQkWpj6885XFlAgv2czEkNmd5T9iVte64500Ls6D6XzrL
 JoLQ==
X-Gm-Message-State: AOJu0YySW1FbKhY7LKCEUapMTFz8PcxlC069CYE8BPgxiBvqWM3foePj
 yf6JuAjTna8htJIJHihkM/HZZLFqjs/lmPvsw27i+6O6v4EasA+W0rN/sY1er5eymeeF9K1pV4c
 mpagx
X-Gm-Gg: AfdE7cnm59ksfYp1xnyHo3g/BkP231jWE+Ca3/ZT+wnmoJfGJG3Vx1I5PcSwNWWZNVP
 MVnmlkTUQEaWlbQEM5npykt9CO2+0zJBPWgPA1la/hpL5a0plT2FAu6QWHMGwcl9DttQuNXdSlG
 codZz4Ix+sEM3zq3ifWs6319PZm5B3/dTD+qTvGqgwMGzyNNoqQW5/6pxS9fKwcMKOZp+sPVVnL
 CXyEm9NXcZahFLmeDyNfb+VfRieGQ4GFyt9h2R/nW/3PMUr/ssgY/HoEWE90EA7wjT347IlZsUL
 3kA7e5DSU10fL1Um5pJ7J2poeahdKovNmKYpjxCwKeRMVobnxuxanzqCPRY+am0PnpQctaw4j3w
 T7a7Q0Fx/GzSicQhMS0UxLCO/alXkszzBc5qftEGiLTHhpvvY1adY7J05CmSoui7uzmyGvzed2f
 lQV24li+6TpmrVAmgXLQn+hiS9PNVJ+CdEsN+9fe5QQlSZVp7F1g==
X-Received: by 2002:a17:902:f143:b0:2ca:de3:15e3 with SMTP id
 d9443c01a7336-2ca5a537e6fmr16157985ad.4.1782875090794; 
 Tue, 30 Jun 2026 20:04:50 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 07/17] hw/core/cpu: Remove exec/breakpoint.h include
Date: Tue, 30 Jun 2026 20:04:33 -0700
Message-ID: <20260701030443.1382447-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is no longer required in the generic header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e05e261883..ae8daa1159 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,7 +22,6 @@
 
 #include "hw/core/qdev.h"
 #include "disas/dis-asm.h"
-#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
-- 
2.43.0


