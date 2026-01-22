Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3630D6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2tj-0006Ip-Ux; Thu, 22 Jan 2026 17:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2th-0006Fo-Ut
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tg-0003KA-CQ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so13548565e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119882; x=1769724682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oemSyEpHaYDHaAfhztm3M5JIpYi10x+W8FZc95Yv/Ns=;
 b=QxbwIhETk1RoOw+cx7ABUD48hFXXHnSR+dPjPMdrbzX3RbZkx65VB+2bOK7W96Hm1f
 leuLiNRPjK2gFQF+dc0Yc0RHeJmZLLN5LHRcLbqmFOZURvAszfJjT8wXMtavpU9m3sFz
 DV366IxTnOJKDLhFcdqqibCFwcqbjcorR6kSm87m7kAnqxGEHTieN2j7tFa1WrTTQQZg
 V5FFV3nnjoLflZxwxq+rMES4+HvZPG5kdUucojUUaP5zCAxLIrJBF06wfGSXzjUe9blQ
 4y9BMP8p4TAB/nnWSbZeUvMQeuE1eKMJJo9XVc3YqVrT4TBX0sw7AYFDGbZj1XA7MAWC
 CgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119882; x=1769724682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oemSyEpHaYDHaAfhztm3M5JIpYi10x+W8FZc95Yv/Ns=;
 b=Hq3xX3C0N6Ofjwq9TU4x2c+UwZxLw91PaMdwTk4wflSUpaJOOsHYv7X2IWGIBqhCmX
 HPEt4TDDwlhH39BHQ4x4wt1ygB5J3sb8QYXe4Ab7jIYniAj2l0OewFXKmD4bpiebjfb2
 SH7f3Noy+fhqrruGoldM0RQywA9oXt04ihg/z5xKdlgiNgGzlPY7xTGJjJ94r2+6EKbj
 5dWCIrxx48suCtwxo7bSAo8UCvPvQkxkee3pFYTjAoxiukRvX4gOmT08qdg80U5TjxEJ
 zKHbU0bSOh97blFeuWHkZt7L0K8o4ApoELHwgS2CJS9cHeL4OQi/qVKtj/zva050G7Kf
 xaDw==
X-Gm-Message-State: AOJu0YwvdpRcx2GvA8sM5KJ/jquzxjUCtMCi7ud72Iwk+Ig5wSDudvPb
 fQQ6WltEi8eHnjC4THW9Tq61IWKOIIgBL6j7kS181G1Q3f74pAhiSWu4y+d9rSf3adX/PTZpBP8
 EuUGCiqo=
X-Gm-Gg: AZuq6aIhZwdKT6FkTPifWZg38WwBahBrEbKtQE9lkL2GBTuGP7HpmFa0yAFI99U8XPo
 DtL/L2jLmBV3XkQoMUtkN+ckffIRd5SxdcfvbbRP6+PT5dsDmJQZm4mRKr1+mRj2VHyKAUkSKKV
 XdpgoS3N4bB/SZG29eRxuiXRiaePRjyo16mxSUecYacrpBmgnvC0quUtdDqVpOtNyY9SsI+/lFK
 +VTIbeCSjFjYOwt7f3Kc2+fLwZbHxCpA2820K0XhI6mkD8R+5DhWNv5or7L/2P15p3ImdzapezS
 aMy8E0800C/K76x0IG0FQDrONLoVLc+p8u6PMOcfq6yqbpkQQmMvviw3+ZVrsv9VfoX8kG+G7ff
 Ql6yBBnoPkeiLQYASDLZOi+6IHyJSDgRai6Ilfa3Bgqr/IEgSmXADypod4CQZ7yEAhhj6oad8vK
 ywg1oU5Fvnx5Ccu/KLF1Tsh86uE2lD2ATIDXtJZnpobYBE+u6O6KLoW+Ywm1OX
X-Received: by 2002:a05:600c:8b58:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4804d2f69c6mr16353705e9.14.1769119882567; 
 Thu, 22 Jan 2026 14:11:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbaa3ecsm2864805e9.10.2026.01.22.14.11.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/11] target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in
 memory helpers
Date: Thu, 22 Jan 2026 23:10:56 +0100
Message-ID: <20260122221106.57184-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 target/ppc/mem_helper.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 636ad769a93..90546967593 100644
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
@@ -165,10 +174,14 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             val = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 24;
             break;
         case 2:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             break;
         case 3:
-            val = cpu_lduw_mmuidx_ra(env, addr, mmu_idx, raddr) << 16;
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            val = cpu_ldw_mmu(env, addr, oi, raddr) << 16;
             addr = addr_add(env, addr, 2);
             val |= cpu_ldub_mmuidx_ra(env, addr, mmu_idx, raddr) << 8;
             break;
@@ -241,8 +254,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
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
@@ -252,10 +268,14 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
             break;
         case 2:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             break;
         case 3:
-            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
+            op = MO_TE | MO_UW | MO_UNALN;
+            oi = make_memop_idx(op, mmu_idx);
+            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
             addr = addr_add(env, addr, 2);
             cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
             break;
@@ -284,8 +304,11 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
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


