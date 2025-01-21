Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3697C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHi9-0003ye-RP; Tue, 21 Jan 2025 12:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHi7-0003xC-Sv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:06:43 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHi6-0006a2-7A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:06:43 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso102288685ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737479200; x=1738084000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmkc6bBb+HgSrw9XzuEaJgDnALN5HKYN9Bheo5qcDys=;
 b=eJgGFN9bHbKjvwrfBJBj1odATOW8vCxRx4306olDdS2bKQmExLfJU30MwlMiznpTCb
 O/XYCP5c0Aj35idrxan/FqlMY+lU47Bem2eotiAIY3vxp/kHcQR18he360f8yVVoalFp
 zHwghpLWffoilykRPhysXfBjbKbND7qRDGVmYgs44ZPu1uqnruHfw5HP8ZLx35jyrBJz
 Hu4o3HduATdmgxZq/u0supX8LdR1cXaTi5FFR6yu1s6cg1LTwsR6C4+6sB3OVa0U+MS3
 ivJRSDGlOdekl7NSCYZE+qThcCzQds9e6ITGnfj25Re6yNrv9d0QmFu0spXHNlyEBDLM
 knAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737479200; x=1738084000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmkc6bBb+HgSrw9XzuEaJgDnALN5HKYN9Bheo5qcDys=;
 b=H4E69L1/J+lh4EefBeQVPXDyYQ/AbxCVDxjlGGhkhbSr3GZHi2163BKI5AG3E7v6xV
 lqm2tgzCGIKAREnmP9qV0KNEoVBWRJcJv7ftwQMF+FugIJW4t6JuLM1BuBhhWL3kNAiQ
 Eoc4zUTKSgM/IZCfI17DPBKZBHaJmiipB2YjKdoI0Xw5IkZOBs6kHp6aerwjt9SM9b9G
 qdFvWeYXqU2gHXIXJ2WI1Gm7M5hSHuiF9Ui+CLwIWz/Kni4nKsjWlwIqLRWuVV3tm/eh
 /iRQt+abSbcGSe2qFvih2VkOZBErnueZQeR+u+lOAqSODxnFEJQK7Fkl8nhel6W+yLgY
 e1Mg==
X-Gm-Message-State: AOJu0Yw58/Tn2SvugU4j2WOEd7WoOt74O+Kh3yUh1NCpHeSYScQOeK68
 POKT7dm8YEdG9htx//jtPkim/NuoD/o8K4bVRsbqR1fHvukNw+gTJCUbn4YuMpEdszGQz3+kqW8
 H
X-Gm-Gg: ASbGncti7zqK0rlAJf11PKT3CluatOvZBnMYF3FMy8AQt6GbLx46ArBBp6YrWrcKGjj
 LgB09AYrutzLH/dmf2cnwrkBGagawHfsFXnf2eFHPgtOva6OJRse+xkNFrN4ZWuD3+4C6BJUGT5
 sGY5SW1I0P4x4VvtxIQ72dFWI+g8zTPX4pqusriIGoIkxw7KvgJNmT+Q+3AtuDQsJtoPIHWoEGc
 2P8bDX0VbeBca61KGjADZaf6wwDOFoFkj1foNbm3DXlUNSBKv4wuGVsvgz1NKDV714aLvAz
X-Google-Smtp-Source: AGHT+IErdRMpQCoLNBlwipWtVjo3PGdCzA1j6LReAYI4j6z0XUcVIdC48oiW2qR8n9LnZx8Ht3Ut9A==
X-Received: by 2002:a17:902:e84c:b0:216:6769:9eca with SMTP id
 d9443c01a7336-21c355b9442mr225226465ad.37.1737479199767; 
 Tue, 21 Jan 2025 09:06:39 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cfbbdf0sm80657825ad.105.2025.01.21.09.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:06:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/2] target/riscv: throw debug exception before page fault
Date: Tue, 21 Jan 2025 14:06:26 -0300
Message-ID: <20250121170626.1992570-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..df5de53379 100644
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
@@ -1708,6 +1709,23 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
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
+        cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
+                             wp_access, retaddr);
+
         raise_mmu_exception(env, address, access_type, pmp_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
-- 
2.47.1


