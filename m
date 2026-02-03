Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49394E8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyX-0001QM-BK; Tue, 03 Feb 2026 10:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHy0-0000xh-4F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxx-0001ed-J8
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so55036665e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131120; x=1770735920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vBekIowfhSKm+z/HpzDtmhdFhXQphEU9snM01OdgKlA=;
 b=A5mSVJNoQB4Uq+sx0/h/xMgcaY3OLYmrBkXPLgol+p89j5SJFWSelbBIGuKY7d8pUf
 0u/GjnkIGILV5++hS+Ik0HKwv/wigKKeKpw2O7BEnumoYNwiM70HncuDEastYOahLGqk
 IWh2oibNRgwui1jj6XXrheKxJ+guL3OHYucDGBsHwBbFWtp3Bl2xcZ58NRHZDd2Sq75u
 IN+iZAgIyJMOqtq342qXa70MgKtKS+gwHTdEC6rhlhraelK88lV6I2h7pfmC8CImCgpf
 B56AvO7+J4FkDT9pwEsuNP3T+AszMI05vJGmzoTHjMcbhMSZP5Vs6Agzpkz0UstY4+Tv
 Vk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131120; x=1770735920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vBekIowfhSKm+z/HpzDtmhdFhXQphEU9snM01OdgKlA=;
 b=O/dmLG7vk+3xVmTa/Znbtxs/ImUrr1wY15FsYC6+Qp+XjU7PoHb1fpcV/V7puxSYwP
 EmlhU3NRqhhWDIGVgL3KYIr7q21OTupGdHnhwa1QQFeqQX5fQLNt9uUAeAUwdGvEa5My
 aYV0q+cje7Rrkt1uCyYsY+b6RwrKLJtRqiljLbRltf0UbVohrKJMsdj18cE7LHaz9QIW
 iFrzzZvdxkXUQRxAXLxBZIOHgXBDciE7iqE0WLDoans37huGhtaHI4etsc0v0P5q4+5X
 cDG+EEJggSIMPUS97rG7UwYIi7gqFfKsrBiG1JHqZ+S0SLeJglj4bKMdvRTg0J8ruglD
 Y7wg==
X-Gm-Message-State: AOJu0YwU8B6qhpmL2f3rzJVwRtZJL06TjpJIT9u1ckNHSSPFQjWFJB7y
 uDrvTrbWRhwV3D/Hfb6vomG6W0TLOio7td7odUN/Xq8dIqlZXJalZPCF/H76c2fsJMSrTfMYxTJ
 9QRfPYmk=
X-Gm-Gg: AZuq6aKKXQnHtyJixdIyvK306oNEkU+oISQ+LFwYoVpxToIeKxRjMcSkr64bCS8eKQx
 R5M9MW5N9rfUOB+tDjdEcDuSV5sedFgzYVmh+wOID6I19/v8+tmxlX2EyFdj44O0+Umx9X5xR+h
 v16+iDInI+8d7zS15Fy3Op7+kIhqgip0AvEHjK5Sk2R4Dtt+OBB3rbX9ioKqnX2LQPj3lsToQZs
 f0hLWXss7jki2+K/3kiNQoUiE223+wLkxypGHJy9+qLyxVR5Kmh2ivC4nqzcf0V9RN0IDrISLEA
 hZ3BLju9+dwqBNyAudJ1hU5HYoE3eQErreZYu/gBU023nUoU3xj0PwkXKu2hlbnq+ZesTUnqoFi
 iECSO/HZ+QeCbhu/2VHGGp/YuhuYbt+5lhXfhTi9rKDbaRc6VScuGGp2krZGWFY0oR1QqVRztDH
 DZg7dDywCDQL2y8utyK4pS3MbAY8+ezsV860oqr0vup/9o46QnEVlqyKOpykWD
X-Received: by 2002:a05:600c:1da8:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-482db493ff1mr221261405e9.3.1770131119549; 
 Tue, 03 Feb 2026 07:05:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512d634sm107921295e9.8.2026.02.03.07.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] target/ppc: Introduce ppc_data_endian_env() helper
Date: Tue,  3 Feb 2026 16:04:11 +0100
Message-ID: <20260203150436.71907-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
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

Introduce ppc_data_endian_env() which returns the endian MemOp
of the data path from the vCPU env pointer. Keep it hardcoded
as MO_TE, the target built-time endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260202210106.93257-6-philmd@linaro.org>
---
 target/ppc/internal.h        | 12 ++++++++++++
 target/ppc/mem_helper.c      | 18 +++++++++---------
 target/ppc/tcg-excp_helper.c |  2 +-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 58f315ffcf5..c3d3590cc89 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -19,10 +19,22 @@
 #define PPC_INTERNAL_H
 
 #include "exec/breakpoint.h"
+#include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+/**
+ * ppc_data_endian_env:
+ * @env: the cpu context
+ *
+ * Return the MemOp endianness of the DATA path.
+ */
+static inline MemOp ppc_data_endian_env(const CPUPPCState *env)
+{
+    return MO_TE;
+}
+
 /* PM instructions */
 typedef enum {
     PPC_PM_DOZE,
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 90546967593..ca84131d1a9 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -88,7 +88,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; reg < 32; reg++) {
@@ -114,7 +114,7 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            MemOp op = MO_TE | MO_UL | MO_UNALN;
+            MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
             MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
             cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
@@ -158,7 +158,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         /* Slow path -- at least some of the operation requires i/o.  */
@@ -174,12 +174,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
@@ -254,7 +254,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; nb > 3; nb -= 4) {
@@ -268,12 +268,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            op = MO_TE | MO_UW | MO_UNALN;
+            op = ppc_data_endian_env(env) | MO_UW | MO_UNALN;
             oi = make_memop_idx(op, mmu_idx);
             cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
@@ -304,7 +304,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
-        MemOp op = MO_TE | MO_UQ | MO_UNALN;
+        MemOp op = ppc_data_endian_env(env) | MO_UQ | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (int i = 0; i < dcbz_size; i += 8) {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index a8c67364669..3f9eb3d924e 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ;
+    MemOp op = ppc_data_endian_env(env) | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


