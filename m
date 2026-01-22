Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50AFD6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oC-0002xg-Nn; Thu, 22 Jan 2026 16:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nu-0002hH-2k
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nr-0005El-Qz
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-480142406b3so10787955e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115678; x=1769720478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NA0YVCTxMATHJDcDmNQHeNseHnB0KbGS01BN89MceE=;
 b=ZwKbwLd2oXQn6zTLewYTXgO07aEIdfFGvXkf8gLq+4kyfrtDI+LFeztCcuQ1tWI0/S
 1vfBdYRXQQObLkPAGA4xs218x9DSULEMmg5ITYY+W0vxynPm29oRyeFMj0GpRZZ1jsqZ
 uwW3yguQxtS1pE4x9q9086qLtOkAQHj7K0tNzqKVEt3DRRVBcnY3AmPic1WIFWXi+9dA
 bE1jN6UrAjBu0KxJ6TljCMnBpP0ugZ2+N2JLsW2BhLC7LXXMeSynIVXhmJuGNwTGmlZc
 4W6kbbZBtmd3lLvg5HcWXIapr75ahQlzPYhICVR7BPQVlnvCjnZLk2HD5QzFYJpuVnYd
 wBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115678; x=1769720478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+NA0YVCTxMATHJDcDmNQHeNseHnB0KbGS01BN89MceE=;
 b=BEmwslHQLJ5uz79X8ZcUufBuqGqLbaC8V/y5WuOGiU3tzrFzyjIAFknEENVcfsj4vE
 s09zsOR+cSm+VuHpK4dQJlq4sqiGhVBeYPcOxwKtDMEjQPzuR9SIAriwk7et1vJyu0dR
 csYNBkEoDnZWXQZUHa45y/pDflDc7wNtoJXZdF4mgb/7djajyFlNEAVdW+BYdvo7xXEw
 xfG3tqs3gH+e1CjsSpHfeCdRUMZPZ9nGahDjJZIslqirmszxkOAGhsydHPIMMwM5xWvC
 ranXvZffQIpztVwiCPoEWtgQCYUKVEAUjZvR9cV93gY4sM9BUyvrY9ZPecIuiyhHD/V1
 pCGg==
X-Gm-Message-State: AOJu0YwL9euXjbEZtvD6uLAFEayHxK8ypGoNt8V6tqk6F8kBgeLIACY1
 kwv7aRU/qpjxDyg9LiNMwhB/kkZRLw22f3nM4ku0G0iltoAShc6fK++6+tOsPIqVkr3Som1xakV
 5HL6VNiQ=
X-Gm-Gg: AZuq6aI6GNqJ6PoAH1ote9MctQ1BAtas1o7J3ilcaQu7WB0MqdEUq/+0P2UQKmBGlbe
 0aKdrborZrd2mp1LgHhHwk8IYZZoBAoKVU7I8xl5brb0tPiUslRZxlnxJPaE8tprfH+AKQj38+F
 J4vKT/VxNplvF2uhEr35W6TFLZI2GSQjb4OZaO+wlfuWbvP++ZPIin1ki6DEt0zgA5BhpaYff3G
 BlFJHWI2oIQZpr0BZC2PPt+U83TZJwxZDVWKuaRi7ZBxiYlhl3sOIQ9nvzaeAfAnsHkABGitU9N
 1VgP8a/BYqX9w6u1md14ZOSRdXK8HVVS6X1HZIChasvTkdC4qnxs7HQ5BiIPPNGc+50yi+vZu/L
 prELdOjWpWWs2h7DlCrIm2YHpZQyofC5LX90SUR/HBs1DqkPtvl4Rdv2KoP1cWNP+f1jTu25xcq
 u6c2BAjV64jDHs7wMpGYMtOPSQilofJFwlhYcPyFCRnqUhp3krJkQAz95c1FsT
X-Received: by 2002:a05:600c:c08c:b0:480:4d37:e742 with SMTP id
 5b1f17b1804b1-4804d37e85bmr7805665e9.10.1769115678045; 
 Thu, 22 Jan 2026 13:01:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8c0aebsm7011765e9.15.2026.01.22.13.01.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 02/11] target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in
 memory helpers
Date: Thu, 22 Jan 2026 22:00:52 +0100
Message-ID: <20260122210101.55358-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

In preparation of removing the cpu_ld*_mmuidx_ra() and
cpu_st*_mmuidx_ra() calls, inline them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mem_helper.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 636ad769a93..cf8f1fa9c1e 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -88,8 +88,11 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
         }
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (; reg < 32; reg++) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -111,7 +114,10 @@ void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     } else {
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; reg < 32; reg++) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            MemOp op = MO_TE | MO_UL | MO_UNALN;
+            MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             addr = addr_add(env, addr, 4);
         }
     }
@@ -152,9 +158,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         /* Slow path -- at least some of the operation requires i/o.  */
         for (; nb > 3; nb -= 4) {
-            env->gpr[reg] = cpu_ldl_mmuidx_ra(env, addr, mmu_idx, raddr);
+            env->gpr[reg] = cpu_ldl_mmu(env, addr, oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -165,10 +174,12 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
             val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
             break;
@@ -241,8 +252,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
+        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (; nb > 3; nb -= 4) {
-            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
+            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
             reg = (reg + 1) % 32;
             addr = addr_add(env, addr, 4);
         }
@@ -252,10 +266,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
             cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
             break;
@@ -284,8 +300,11 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
     if (unlikely(!haddr)) {
         /* Slow path */
+        MemOp op = MO_TE | MO_UQ | MO_UNALN;
+        MemOpIdx oi = make_memop_idx(op, mmu_idx);
+
         for (int i = 0; i < dcbz_size; i += 8) {
-            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
+            cpu_stq_mmu(env, addr + i, 0, oi, retaddr);
         }
         return;
     }
-- 
2.52.0


