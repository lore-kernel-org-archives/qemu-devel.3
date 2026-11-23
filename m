Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41897606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwVVDtMz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVRcF-0003qU-Tx; Mon, 23 Nov 2026 05:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRcB-0003pz-9C
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:39 -0500
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xVRc9-0005FY-E1
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:49:39 -0500
Received: by mail-pj2-x08.google.com with SMTP id
 d9443c01a7336-2efb7c0225bso7557255ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795430976; x=1796035776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jL3MKyRWxXTEf/1fZj3kgO228Y9Z148VbNgaKP80WRc=;
 b=IwVVDtMzjHwZ9fG5ROxov+Cxwz+0A3jf6ODfVvsDA3zf0Mjlf6qSxWHepwffQBHZRt
 eTBLajrGbteiiVP4UyNUVWbR2z+EoI2BviFsIZwo4Gkle/mTIoRXSgi8QudnvhWVujrH
 tWDPMwJ4jt2qLTtkRB2n8pLNcDHcwtKXJ7lwQ9Fvx0DH53aCKURVeFh7JkkwjrD88mZr
 8THNUwaGIxGfyLs91W9bZVPGAmdKlNhwTvk1lz/+oe7FOEcpuWJnadZe0HK/b5tLTUST
 XqkQ7shoYqmcmNjtG3mEo7EPr8AuLhyLJ19+yhxzv3ff0ALtSnx9Bjhdg2YNE6LPDU0p
 ZM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795430976; x=1796035776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jL3MKyRWxXTEf/1fZj3kgO228Y9Z148VbNgaKP80WRc=;
 b=kYX/dQREOKTqZi+JzLO6xstuHmHSbq0SPlQQY5xWjlhGwq3dZ6z/kF0mAgPEtey2ku
 t+Ngy6kgFjvQ3FkzSKxVlHJMtGuUCGoqBzn6QKC/ZFoUrOnUZHNiq+c5nT6+PPjqqH4N
 91Zh06fFHpS6s/fh4ltE+JMICVzrMoNPZyebIV4OFP8GYqhRt/Ho48QyVwYzXelObQWi
 jmTUYf6eZ/4JU8AHxUp31tqao9ymXQ1tqgrAxlJhGgJxfIJ4eZETveFw3U7aL2OlrtuS
 LY1IXkTkIRhfm5XgQaD945ksDwyCL5syqp3qcfqR6zVMp75BJrWLbDRErq2Ctu9ccLVb
 u2ww==
X-Gm-Message-State: APuU4Z9mQXSdPVrKDizLu2aw4yIMTcRJobJFl7T4nOl1eKdqpT1gHw2V
 ro+Vj9xGDaSczFDJsSOmMMppEwhlYm9RiPZeOW0udQapv5GHtuMc9o8K5UZ5n0MtiFkzAA==
X-Gm-Gg: AZFdTZclyS8UQ1yPUgPUsfuIbmsO+pu4CykIKeUjpRm+ko3s1jC0LVtCQx6PHf6OH9B
 JiTNVAj+sLiD8fcYTflcpmPvezdGjJVAy+wnUboZPthc67HnW/d47MdtJ2GQDJ34vsT/hFlV+rj
 Bu9fFBHHKR7XK4q2puVph0A/kP3F6wV0UHeYZK32axhb4DNasP5HjUHZ3MywMMzCQZW9tIzyaSJ
 6A4PtJv5n08BWWES7cj50tXbmoIazMQQNJoWTswWy7l+/BFFpHa2B4labLGml+X35fSLH5eYxA1
 AMGJl5ZnlU+IAM+YehGsXTt1r6EhGQc032XNmAmU2el1YsZL4z/xhmzweM6GEZAzwdxAarILD8n
 YxCbvdT4Xj9pllnBw3mzln0Z4Ozo7mkmyZPNt3NCt7q0uXKQKbC7to/2cQ3s4yCyVys/tw2f/cu
 3gfPfI5dL0Yd9pcumazR/coktOwrW+JpDWwdlta76FRqECI9QoB0iEn0Y6T3gHpm6ijASfgsJta
 ryrfXwm6uhoutg+xTp5lvxeSrH3rjZrAcv3NGxwb8s8+VT5ZoKgawqKgjRJ98u9fDN37k2nbDXu
 C9JhHfowLmcJrcsMOGibLEU7
X-Received: by 2002:a17:90b:380f:b0:3b1:bd6d:fcc2 with SMTP id
 98e67ed59e1d1-3b41c97c88cmr6883269a91.40.1795430976041; 
 Mon, 23 Nov 2026 02:49:36 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3a71:c3e:fd79:a32f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b409330ae8sm20343555a91.7.2026.11.23.02.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:49:35 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH 1/2] target/riscv: preserve interrupt-pending state under qtest
Date: Mon, 23 Nov 2026 10:49:08 +0000
Message-ID: <20261123104909.197758-2-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123104909.197758-1-w1355457260@gmail.com>
References: <20261123104909.197758-1-w1355457260@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::8;
 envelope-from=w1355457260@gmail.com; helo=mail-pj2-x08.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The qtest accelerator is neither TCG nor KVM, so the mip updates gated
by tcg_enabled() in commit 6c91b423a9a4 are skipped even though device
models still inject interrupts.  Treat qtest like TCG for the
architectural pending-state updates in TCG-enabled builds, where the
qtest csr command is available.

The update blocks are additionally wrapped in #ifdef CONFIG_TCG because
riscv_cpu_update_mip() is only built with TCG.  Without this guard, the
runtime qtest_enabled() check keeps the reference in the link and breaks
--disable-tcg builds.

Fixes: 6c91b423a9a4 ("target/riscv: gate riscv_cpu_update_mip with tcg_enabled()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4929
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
 target/riscv/cpu.c         | 13 ++++++++++---
 target/riscv/time_helper.c |  5 ++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..a8eba90704 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,6 +39,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "system/device_tree.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
@@ -1459,20 +1460,24 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
                 kvm_riscv_set_irq(cpu, irq, level);
             }
 
-            if (tcg_enabled()) {
+#ifdef CONFIG_TCG
+            if (tcg_enabled() || qtest_enabled()) {
                 riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level));
             }
+#endif
              break;
         case IRQ_S_EXT:
             if (kvm_enabled()) {
                 kvm_riscv_set_irq(cpu, irq, level);
             }
 
-            if (tcg_enabled()) {
+#ifdef CONFIG_TCG
+            if (tcg_enabled() || qtest_enabled()) {
                 env->external_seip = level;
                 riscv_cpu_update_mip(env, 1 << irq,
                                      BOOL_TO_MASK(level | env->software_seip));
             }
+#endif
             break;
         default:
             g_assert_not_reached();
@@ -1498,11 +1503,13 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         if (kvm_enabled()) {
             kvm_riscv_set_irq(cpu, irq, level);
         }
-        if (tcg_enabled()) {
+#ifdef CONFIG_TCG
+        if (tcg_enabled() || qtest_enabled()) {
             /* Update mip.SGEIP bit */
             riscv_cpu_update_mip(env, MIP_SGEIP,
                                  BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
         }
+#endif
     } else {
         g_assert_not_reached();
     }
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 29bbebb96f..579e05f7ee 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -23,6 +23,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "kvm/kvm_riscv.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/tcg.h"
 
 static void riscv_accel_set_irq(RISCVCPU *cpu,
@@ -35,12 +36,14 @@ static void riscv_accel_set_irq(RISCVCPU *cpu,
         kvm_riscv_set_irq(cpu, irq, level);
     }
 
-    if (tcg_enabled()) {
+#ifdef CONFIG_TCG
+    if (tcg_enabled() || qtest_enabled()) {
         uint64_t mask = irq_or_mask;
         uint64_t value = level_or_value;
 
         riscv_cpu_update_mip(&cpu->env, mask, value);
     }
+#endif
 }
 
 static void riscv_vstimer_cb(void *opaque)
-- 
2.54.0


