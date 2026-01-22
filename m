Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C22D6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2u6-0006WM-Vx; Thu, 22 Jan 2026 17:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2u3-0006Ug-5u
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2u1-0003MC-FN
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso13511225e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119903; x=1769724703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyIWXld1FWQ8hHXOqbk/6iIga1BTq5Gc5Yz2aOFOv/8=;
 b=LapB3KYP56rCbNxMHUaaPeQKvVsYZZrUNZffNtcF8GOaAZotSUDmNBd5NAI6mqUCr1
 oT8yCsduZQs3mXGwYrArf1Yi4YwuzyQ3cSt0nidn3iZ3/3aPNipVeZzkSqvL0yFCm3ex
 KHKgvBqUTQrur4D/mJM/xuTAe0nndJsd5HjX0jguLJ3WmRAAFKCQdHrnWDFzRQts7ryJ
 PaDn/m8yIYjcv1N/OnjiJnvmgMaHsFxKHl7HK2FShosj/1+2OmyzVWPAEErtJ+oM9pTx
 t0pjEdFwSigZPdMdLrpAsKRDIDfPutW9MFTjdKjQLq9dQnj+DHAqGUPMEUYxLs75B4O5
 Xokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119903; x=1769724703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kyIWXld1FWQ8hHXOqbk/6iIga1BTq5Gc5Yz2aOFOv/8=;
 b=Wi2r6nmEseiF8CIkmQqyaBHnx8lM3kLwuq+s6HHyCZMClLdHOrG2i3yZtDtuP5FJO5
 3K88LW/1ch/h9DLLBaW7V+ApJrFqRBY9+GLpsk1Ymc9VbyFgt2PP0zUjpl/3CSKGmM2+
 7zw+4wRFXvyraMU6mGDvCEeUGK9LmCyc82m5KNBE5UA0Cft+vh4ay57CNSMSmMpevk8m
 N3DbpIH7lsghyJN0pbPIzqISB/Szs29MtEqPjEY35+guyWMX33nu4ZsAnoHtHZqqM9vI
 lQKbBUms+O6wP5wdT/OjGTwbkCKJdDagnxGPZRNRJvtGc3yNwAnwJlQne/MuUeTwl4rW
 T4Qg==
X-Gm-Message-State: AOJu0YzC/15mp/fFDiRmleCa4CGz7K8rucj4kYGfGqYd3uSoaLCOtXoS
 rx11anMA0dSJ+zY8BzCR6WlOFh2xYf/lIsf3zR6Xrb2fhF+vGwrF/qQMy7MtMFz4KIGC2a2Kjck
 dhtHm2bU=
X-Gm-Gg: AZuq6aLweI1+abvgfE6bt4faqrPYPXBwnjP45G/1Hy65dSL2KrgJv41FQ+MgIIYLNVy
 mwEQWFQ3Cq81eLKJDsTEqpQ+H5Mxuw4sghzYV1Gb6R+QFcGlCPLKyrhSsR21U+d5U1AScbGn6RN
 tUKpFN1tAvTUz8ATZL3zQokoWjshzQA2/0W/416sBXKxvWJvKOv6+1aHRvnxto+8LBjke3IV+IC
 EMbodaHehJYcbNHicGXD6G/hP5YE6bU28/I72u174DjjgNlVLQlKNTxcJMKhn7PIem6W1Qda+Ca
 bN2ugJXY9/VCAbocTJwovqcPhIAQzqWaz1sSZaXp1W0tGtzARfxQeor8Zf6L51z1oA3JnHaI2qw
 3YpN/NIvrgpdTqo+7jwqmFgv/eSquib17pCYyuIuN9ANH1Z62LJxAL1u9kKNwW7PQ81T6Rz/pvo
 F4sAfDz6uC+fbzGNLVVfDLVRFD6xlEowq2O2n/RP88Yr6riqchbYAqPSk2q28megx204RCw3A=
X-Received: by 2002:a05:600c:3b0d:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-4804c8e9508mr16430795e9.0.1769119903562; 
 Thu, 22 Jan 2026 14:11:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d84ebb9sm9777315e9.4.2026.01.22.14.11.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 05/11] target/ppc: Introduce the mo_endian_env() helper
Date: Thu, 22 Jan 2026 23:10:59 +0100
Message-ID: <20260122221106.57184-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
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

Introduce mo_endian_env() which returns the endian MemOp
from the vCPU env pointer. Keep it hardcoded as MO_TE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h        |  6 ++++++
 target/ppc/mem_helper.c      | 18 +++++++++---------
 target/ppc/tcg-excp_helper.c |  2 +-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 58f315ffcf5..09333bed342 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -19,10 +19,16 @@
 #define PPC_INTERNAL_H
 
 #include "exec/breakpoint.h"
+#include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+static inline MemOp mo_endian_env(const CPUPPCState *env)
+{
+    return MO_TE;
+}
+
 /* PM instructions */
 typedef enum {
     PPC_PM_DOZE,
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 90546967593..89718441310 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -88,7 +88,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; reg < 32; reg++) {
@@ -114,7 +114,7 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            MemOp op = MO_TE | MO_UL | MO_UNALN;
+            MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
             MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
             cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
@@ -158,7 +158,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         /* Slow path -- at least some of the operation requires i/o.  */
@@ -174,12 +174,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = mo_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = mo_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
@@ -254,7 +254,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; nb > 3; nb -= 4) {
@@ -268,12 +268,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = mo_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = mo_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
@@ -304,7 +304,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
-        MemOp op = MO_TE | MO_UQ | MO_UNALN;
+        MemOp op = mo_endian_env(env) | MO_UQ | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (int i = 0; i < dcbz_size; i += 8) {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index a8c67364669..77d21523a5b 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ;
+    MemOp op = mo_endian_env(env) | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


