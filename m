Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F5ED6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oH-00034R-6E; Thu, 22 Jan 2026 16:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oE-0002zV-3A
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oC-0005HP-EV
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1361919f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115699; x=1769720499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43ixM+aKuIksflZPIqnhd7zfLTeR5wkYWXfnKtaWNkY=;
 b=ButbmFvg8kFhkaA+51zMW8AkExRqUmVzLvMoxermfzMa6WvmLzSPp5cKihtPbkK3Gb
 iBrJh5lL05u5PgnBHDaAU9aiCn6Wy7Pm/rdNO+RSn0m9Dcmuzfoona0xhvZ5aMV6IM5R
 ChUgvmQbVwTM43Wm6FeM6PbDQZgSq1vTadcgYe0BbUuV/CpJA1zpAA/PnLsJU/OAZ3kK
 9vHEyLxI7x8jCIIh24bq01dTMe2o7u+v18I551kN+1md/LvifK1xSMOEv4IEdpcpXlZq
 hKpRGKUIXUNIU40M7tthQQ9lBosGNj/OYdEMCfh1USD2Ee1TYJEn1FvxhcvNfUUJyGjh
 7wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115699; x=1769720499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43ixM+aKuIksflZPIqnhd7zfLTeR5wkYWXfnKtaWNkY=;
 b=NLjcPWlCMrx2UMJBW/3MPSz8Ma3l2vM0mC2Au+RRYO3YXuaoAV9Y5rhgABrjhZEj6O
 5fAavsoXPDO1WOuac4Qf3JUppQzfielXvlO/YQ48Oc6/3zWOroCjTc3IS080YQjO/WMw
 D4vCHef9DlYLxjMxzaOIC4rEeFutO7DihUKyp3tJD6SX4WU46QqcmkQEh1nBzWZEwl6k
 zjEV9v9+WQw16SsAmhAUU5OJLY1zCMffcSanhewKzWb8EM12MQTwyK0MEblPCUQCdvyy
 9KbHKEee5Hjtkju/U0eT8V1K0YsBIsfvG1R+9N3jSPR5RfDWRXnQhsZIja13tbm0XQIN
 mPDQ==
X-Gm-Message-State: AOJu0YxtTxtKpyYVtuEY4DGP/VfkEoMdaCVyxOU2q45Lki49TS+vafwr
 A03RJWb/yQ9AWrqOOdoxrSEIyfe7OewmvDaBD/yBvNaPL3kCcdB8nSQjCwZJZjHmzgk5jeNvNXN
 YtIVmaq4=
X-Gm-Gg: AZuq6aJ+8EeCWdNEwcUP+oWVRq1y0arhKhIzVfFqSNJk0YFS+I9N2au3zEDeFKln4Vn
 28yB1AvhwkD3v4gI6aXbr7PsleJQ4BN9uTNKtkI6k+ULOUOQFTmykiQJG82ZyOr+PSLGiztnxY/
 1zczS29o40kT3xIL8DXMo32vc9yPe2JrEsoEBBqBp90IMliqbAT8x/0NmqZjj0b1Q+alEnOc20y
 dYsRhBACkAn1NnXKdxV9rEOvHJxNqCZnAOCi0XeeOYluMNmLikDM2bmO8yZ/WntBIdHjjxaj/0o
 61v/fGBz7YC3bPlyMv223+ZWmmSJrQpEXzTIXzMk5immfcnxBYF+U9rk4Hy+KDoZO4MHZXYb4xq
 zMMv6bi3ClrmAq4ZPtGPfEeCNqVw+ZIKmkTbYi4xT1qDiSm2/tyy10ZWab053E3rHCZDNRTefBD
 JOwjRh1JyEmCseczcw5HfZalfqiQFcRMkqjJrK6JwlU6cz/8jlH/oJ631JTs85
X-Received: by 2002:a05:6000:2c01:b0:430:f454:84ae with SMTP id
 ffacd0b85a97d-435b161d1famr1333446f8f.63.1769115698541; 
 Thu, 22 Jan 2026 13:01:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24ac1sm1324206f8f.14.2026.01.22.13.01.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/11] target/ppc: Introduce the mo_endian_env() helper
Date: Thu, 22 Jan 2026 22:00:55 +0100
Message-ID: <20260122210101.55358-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Introduce mo_endian_env() which returns the endian MemOp
from the vCPU env pointer. Keep it hardcoded as MO_TE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h        |  6 ++++++
 target/ppc/mem_helper.c      | 10 +++++-----
 target/ppc/tcg-excp_helper.c |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

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
index cf8f1fa9c1e..3c91d641f9a 100644
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
@@ -252,7 +252,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
             break;
         }
     } else {
-        MemOp op = MO_TE | MO_UL | MO_UNALN;
+        MemOp op = mo_endian_env(env) | MO_UL | MO_UNALN;
         MemOpIdx oi = make_memop_idx(op, mmu_idx);
 
         for (; nb > 3; nb -= 4) {
@@ -300,7 +300,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
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


