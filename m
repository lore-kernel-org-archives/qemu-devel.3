Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99BFD6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2tx-0006Nn-JJ; Thu, 22 Jan 2026 17:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tr-0006Lt-Q6
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2tq-0003LA-EO
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:11:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso12297285e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119889; x=1769724689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJ5PETmEZLmm3Y1gSNdqj1xhiHNr34HOHNL2IBd92JM=;
 b=lO8Y6gDsQoAjGtIB17JBDnBOtt5AHC/fIke/X1ij4EgV2pjZL7opEzyl7ezYI+o1pB
 EzMzK3q4HfvlllT+ZvNtgb62WPOkEizTR8GL9iGt2V3Mz3dv0w2V6KNOibqmuD3jjx0q
 l5X7L2FWC3diFKBsOlUSNxsHo8AI4lpE9V+No6D346sjlfHMOiQNA6JnvQo8YafEKIra
 8MF2Vs47OPBvTy7W2jzzYboMU7cRwQNcYKdvRszTLI4ECTnPaQqp2+7X5oLJ1eEVe1hy
 BB8NYjkUNzNGfdfTZewb3a9jp3kURHxFmoOQ323MRwkIqBrROPiWLx3qBMVCT7ve6B+3
 CS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119889; x=1769724689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJ5PETmEZLmm3Y1gSNdqj1xhiHNr34HOHNL2IBd92JM=;
 b=xN9Y/WujjrNswIWyJ7GWuNhNPV9GCfhO2HND09pYF43LQ0rN2Lmol0oZ8ZvmYi3pVU
 wrc4QJmEzeDtT87nlEx6OJvmCk/4uF9l6geyF+IzsoXQWjw5LATL8d5UE5+siHkqDNFp
 TQl9QhMa3ZkAIlOTNn/4BQUoBeGiwIaHjCs+Bg+8F5y7yARj5boQoboAAzesnHkIxHlZ
 14mcdbHRWGOZbzInP7oWyAk/aNURXC9xMeh9i4dM955F9k+p3fe0whU0kC/s3i52UOR3
 1e9RKiCu/fQ7paHDhkdYNi0KNeC0aycPjFbuWhzVdREXh0afDbTmnDyI5JZIMOt2JXfb
 zdHg==
X-Gm-Message-State: AOJu0YweQxDk+7deiOEV6XCPV6NHy7wihzC0EIkcZLn21lO881+JztSP
 wgyTZsodzUNmSl8TCIE5N5S/wahco7OIfAbN+bKH+TcD3886Ipc6L320tjWrJluE3EnHLBo6GnV
 iNy/yyjs=
X-Gm-Gg: AZuq6aKBZsyqpDUuBHowHFhBYlJX5o490Y3BjHAHQTRzrVoK7+/C5zgbeQozeLzn1YA
 opReAPM6R3jHTII8UYTlDrVfvhquL1SHDF2hSy8z4SvcnNy+4vnTaa3+Zl8UM4WCByUyDSN6pKV
 LBMXkaPiTHpfdDjJpMON3h3326W7OEFfQgz+Ka8KeqqVd3j8e/FlK+6HE5Qq5ILCujOgaiEVqIQ
 1X0ITL/tlZaSSvhIXKXwMMRiCpmUBYZmmSl4vz5Bz4/RT9wN9G0nIOan+qrdnnVJH/WqoTp7/4/
 QzUphirmlGk4CrmL8QMFKWUYAKcNuEx/X7Ivkq0QP2vo+XnlDm3aUYLcpif+9aiSL0qYp81f8xC
 oxJYSH3unoFTWK8OlZaP2ZOmrs5iLyfULOA4JfMEv/3ZLtMHoWSsaPbF2n9XTuKPRZS8bwBnXO5
 9e5d7wQpj0W4cWta8gQeO9ikwNnQRdbQeToWrahTo0Yr/W4Mx7XuKFEtzHtpZbfwAsPv/p7Eg=
X-Received: by 2002:a05:600c:1d28:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4804c9d4fd2mr17080105e9.33.1769119889561; 
 Thu, 22 Jan 2026 14:11:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d85206fsm11486705e9.6.2026.01.22.14.11.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:11:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 03/11] target/ppc: Inline cpu_ld/st_data_ra() calls in
 do_hash()
Date: Thu, 22 Jan 2026 23:10:57 +0100
Message-ID: <20260122221106.57184-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In preparation of removing the cpu_ld*_data_ra() and
cpu_st*_data_ra() calls, inline them. No logical change
intended.

We note the page translation hash address is expected to
be aligned, so the MO_UNALN flag is misleading. Next commit
will remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..6f5d82af636 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -160,14 +160,18 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
                     target_ulong rb, uint64_t key, bool store)
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOpIdx oi = make_memop_idx(op, mmu_idx);
+    uintptr_t retaddr = GETPC();
 
     if (store) {
-        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
+        cpu_stq_mmu(env, ea, calculated_hash, oi, retaddr);
     } else {
-        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
+        loaded_hash = cpu_ldq_mmu(env, ea, oi, retaddr);
         if (loaded_hash != calculated_hash) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                POWERPC_EXCP_TRAP, GETPC());
+                                   POWERPC_EXCP_TRAP, retaddr);
         }
     }
 }
-- 
2.52.0


