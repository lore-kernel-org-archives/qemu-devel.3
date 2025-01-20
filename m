Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173CCC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyip-0000Ww-Sa; Mon, 20 Jan 2025 15:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyi7-0007Wm-Sj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:27 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyi6-0006T1-6y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:27 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21661be2c2dso86452715ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737406164; x=1738010964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15v7CjmqmiVnhIsisrdhFZVgAtNohMz6B6oxkmQn1Ww=;
 b=ehBvQZGX7dce9hTnEunwfcgDI+Jp8kq+MkSh18sVpNSHf7EjAd2XzBIk24RBAENP4f
 JmS19gABMxBioAZmfjLgoc1igD3b7OtwpKNg6fCtfPIjVg/rEF99ZHDkrrnuKsOe0alO
 8SNWnb2OtjOYmRe+LbN7E7uBf9KU8+s5vWJTSkQHFe9TfNNHI5PT3MWECYycRiFfMhHM
 6EnhhyzXU91RrHHAlw8U3PfNDhXAKjw+utAgT4pLvRL+0XR10Yumx9yKZnzDGjrTjIfZ
 C9FDrljBbr9FtQ75x/kd2zIkqmlhipbe1l9M7FhtkK6Jm9Vvc+GL9s/lXeXDfW2RCK82
 jkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406164; x=1738010964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15v7CjmqmiVnhIsisrdhFZVgAtNohMz6B6oxkmQn1Ww=;
 b=cboqwz9mpdtKY5pA9dMwsIEwojc1oO8KxYHY2nKLbepLRpYQUVQGvO3H/KNH0CfJn+
 yYcDv0T5G8/0ubjiAlzKRy86HfcDJyyCBlY11m2x/Cxs4fc5UNx6+TpzUo4ITBvwGuhj
 OwwdovuObKm61/tYXlhF43DqkGXrBPWPz/CsA1aY+QGVM4Dcm3LyjpqRNq5/zNtiBjR4
 6Z6ZwTqRK5psiHpeKKms9L9gJPlDsFkoz6qtr1hxWSL/U1M8VlsT1gpSQ6GebvuKN/ee
 PAd/xsvqoesg5y+iqfvlVF+eRc2pLEVmPm63NfJvPad/l5c/bcqvhdYlu4W9bneB+W5/
 NZCQ==
X-Gm-Message-State: AOJu0Yyqc8FneITfBzsG5DnV5m/6jvhJF5WV9k7kvWP8mydaMCuXLb0F
 BN/EFrJ5rdqOOxyqHVbeVtZvgF4J3/jBhrP6/+ZSA6sHCJrV6JF9o3HwcNyZsSJLc6YcdD4OI1i
 Z
X-Gm-Gg: ASbGnctJdPu8uuroE/+jELr4L600YI4Eb0ebOOsFUIxn1IuSkpEkQ0DNJM/+WRNosZ6
 EZSmiZatqXBEv8HkCjd4ShtbnCHVeWOm5z20bDrzTGTIUVtBdI6bMes98kZ10OoJjGdDo62Ttg3
 yCDjVbfW6oppgkD7i5EFBVHUWWHcmzww6WrMnypZuogZY1k0oTX1KzQlhfluX8l+qXvAxUPuf+T
 jk/zR83WNPucAJ7OW8lDix5B/7slHdN/PJc2OwO31iOCNsC84C84S0z1zOUsAqrhInEAL/YUw==
X-Google-Smtp-Source: AGHT+IFpupti+sEQlL8jzdcS281EHn3VhtE+Mbds10JMfVKEIIBlXbdHInGyT4gz0lVxStvGYU4UQQ==
X-Received: by 2002:a17:902:d4cf:b0:215:a97a:c6bb with SMTP id
 d9443c01a7336-21c35400a0dmr216826905ad.12.1737406164409; 
 Mon, 20 Jan 2025 12:49:24 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea08e4sm64865025ad.7.2025.01.20.12.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:49:24 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/2] target/riscv: throw debug exception before page fault
Date: Mon, 20 Jan 2025 17:49:10 -0300
Message-ID: <20250120204910.1317013-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
that a debug exception that is triggered from a load/store has a higher
priority than a possible fault that this access might trigger.

This is not the case ATM as shown in [1]. Adding a breakpoint in an
address that deliberately will fault is causing a load page fault
instead of a debug exception. The reason is that we're throwing in the
page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
raise_mmu_exception()), not allowing the installed watchpoints to
trigger.

Call cpu_check_watchpoint() in the page fault path to search and execute
any watchpoints that might exist for the address, never returning back
to the fault path. If no watchpoints are found cpu_check_watchpoint()
will return and we'll fall-through the regular path to
raise_mmu_exception().

[1] https://gitlab.com/qemu-project/qemu/-/issues/2627

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2627
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..ae0a659ec7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -27,6 +27,7 @@
 #include "exec/page-protection.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
+#include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "system/cpu-timers.h"
@@ -1708,6 +1709,24 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
+        int wp_len = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
+        int wp_access = 0;
+
+        if (access_type == MMU_DATA_LOAD) {
+            wp_access |= BP_MEM_READ;
+        } else if (access_type == MMU_DATA_STORE) {
+            wp_access |= BP_MEM_WRITE;
+        }
+
+        /*
+         * If a watchpoint isn't found for 'addr' this will
+         * be a no-op and we'll resume the mmu_exception path.
+         * Otherwise we'll throw a debug exception and execution
+         * will continue elsewhere.
+         */
+        cpu_check_watchpoint(cs, address, wp_len, MEMTXATTRS_UNSPECIFIED,
+                             wp_access, retaddr);
+
         raise_mmu_exception(env, address, access_type, pmp_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
-- 
2.47.1


