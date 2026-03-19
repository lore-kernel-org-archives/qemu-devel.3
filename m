Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748AC108E1EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQS-0007lf-M3; Thu, 19 Mar 2026 07:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQN-0007jh-Oq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQJ-0005f1-Eh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so1800345e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919217; x=1774524017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kV6UJs6uJ+gJwq/B/WXu0vSWOly3L8qb+FvxJ/ow/Lw=;
 b=ISNRihspwccNObV4MN+G3pVK59G1SkMm52QreQ9sENN1fIiA46teHCKVtTFA4HhigV
 GV5tMQaOmHbqg+l+4nDggldD6iQatORMpzWtMlZQ63CMTmowJUzSZPpokdqV0EoU5/VA
 sBGTKlSH0CY0Ql4FVgqBA68dnVNy9xTolg/jGoWnT1oNaxcyyj7zUVmzZLREpe2kKrLI
 xPGBgEDDzaazGsAWoHKz7WOqVa4VJCxIcyTYKxFi/Oh/rK3wnfZ+8aAUxx7+efzGlIhY
 cFdk1c8WN77BmNCg3S4s73TujvCaFC2xPpjKQWOC1Le4uBWtnTC1rg+e7NZqT7dR7NUP
 c82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919217; x=1774524017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kV6UJs6uJ+gJwq/B/WXu0vSWOly3L8qb+FvxJ/ow/Lw=;
 b=Qw04Zego5tOa0RZLbbPwL39A5z+neR0pZFOrJD8DAkWw1DPFrCybzgSB2e+YOAEZVX
 1bafqjqWSSMOM5+Jwv+8vEBT6GU8kWKb9ZGovoasN/xUhfZcBnqb2zJ+PE30if0U9IG4
 3j2tNE6pn5DvGL1y8HXfXW8q07ILqmLkj66Q4kjRks4nPUvgltmveYBgLeCx20J+PMY+
 DnHG5zvqTkNcKXSvc42uL06cJJyO1BiB1zVhv168eUH/w0uCPN6V3AvqJzTfnQH+zaDa
 vY7dwy9JBIMWkq9QcZbuqLxGlRdem4/tmNhkjO5xT23BzxQvq4rhQ5JG+GpcQ3jIxCxc
 l0iA==
X-Gm-Message-State: AOJu0YzwaXWTkA++oReQ0R6U966dGlzAkIvLkx3F8W3Dwa6eYY7K6Qav
 tEwFUA/30TeSTPYfc2mmtLwspdevpuyDldznd03uCqq4s6KXfEAUHuvDpq3HaZm6GB3JckozM5I
 1298H9Qs=
X-Gm-Gg: ATEYQzz2/sH94NVKg3I5EuMgafrRTQUDNmsNBAP+J6QD2rzOHeTt9dQyd0vU3rOGjxh
 OQ8xNghxsaWZafkZ5YlBwYR/ORAizGp/tX1WiurD9acvnXjI5wSZ3kg07pECjuX6VOEDgCiWWQB
 wnUlPTAgZ8K0sSKvnnxGBS4JMN5UF3nVL3N9PDwmI6tvJHjJPDNwTBpHMmKNMIA/UqkwWpqLNbb
 l49YNlsw2q6oC3IH2PvXHtwZ46O85hGaKqBCxFb5QHDIdAyluIVxhPQ9uH5mWTFhzyf/czqUudh
 IAkaXE24KHTCNkYXIn96sO/+eSSl+SbxASiehIodj1Xf6Y/6UhyO9Bt8lwP0aE5PutT7mb4hbUc
 GpgUUrkB/PN6RoySrR0RkNlrxSm+CmaGbZ+Mz0P3dvTxMHrFA2fBcfXgRowRd7xdKLf/gPYUu9D
 9q8wNFp1lZFVy1yTJP7zmU8vjtTAyVtBTvEk81Uex0G9+C/hAeOTS00L5bQOnxvb4RPbxdusWH
X-Received: by 2002:a05:600c:810c:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486f4475342mr112999585e9.20.1773919216971; 
 Thu, 19 Mar 2026 04:20:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949e1sm103571465e9.9.2026.03.19.04.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
Date: Thu, 19 Mar 2026 12:19:33 +0100
Message-ID: <20260319111936.68041-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result) per the definition in
"system/memory_ldst_phys_endian.h.inc":

 27 static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
 28 {
 29     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 30 }

 28 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 29 {
 30     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
 31                                     MEMTXATTRS_UNSPECIFIED, NULL);
 32 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.c        |  3 ++-
 target/ppc/mmu-hash32.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index f24801a9731..89fad5356b4 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -110,7 +110,8 @@ uint64_t ppc_load_epr(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    return ldl_phys(cs->as, env->mpic_iack);
+    return address_space_ldl(cs->as, env->mpic_iack,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 08c9f63a132..81fa7336b76 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -23,6 +23,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
+#include "system/memory.h"
 #include "kvm_ppc.h"
 #include "internal.h"
 #include "mmu-hash32.h"
@@ -205,14 +206,17 @@ static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
 {
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    return ldl_phys(CPU(cpu)->as, base + pte_offset);
+    return address_space_ldl(CPU(cpu)->as, base + pte_offset,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
 {
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
+    return address_space_ldl(CPU(cpu)->as,
+                             base + pte_offset + HASH_PTE_SIZE_32 / 2,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
@@ -253,7 +257,8 @@ static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_t pte1)
     hwaddr offset = pte_offset + 6;
 
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+    address_space_stb(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_t pte1)
@@ -262,7 +267,8 @@ static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_t pte1)
     hwaddr offset = pte_offset + 7;
 
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+    address_space_stb(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
-- 
2.53.0


