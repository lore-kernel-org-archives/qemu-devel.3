Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96B6D6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oD-0002yf-95; Thu, 22 Jan 2026 16:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1o0-0002pb-KY
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nz-0005Fb-6R
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so13195565e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115685; x=1769720485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJ5PETmEZLmm3Y1gSNdqj1xhiHNr34HOHNL2IBd92JM=;
 b=HO60b6GKvPmzaQ41ZGd1kqVBytquOsuRUlkM6FSenK8KGHzuacLWl00tYNW+VVRWlB
 h4h5eEAtrJJlnJP/0V5HmLPJm1chsIL344ApI96LzU4XLAR3OjPp3OY/Fc3XVbCKGM6J
 NaO+eUKnfZOLv65Zlo+FsOY6CZXXx/+kZY+Qy10r8B8ySLbBaddgcKa6FqTw0Mp54521
 opoBrhLVk4cgJeJlRML9kP1+sK0auIrHSwRziz1GdLEkBHD/GR79i4L+vkjseu2rGolY
 9bX3p5k5Qu6xX8nFnfbdNCK51F6tsgS3KgfyCiYy7t30qzmuzPRS1DgBEVvuuiKdUWAd
 +DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115685; x=1769720485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJ5PETmEZLmm3Y1gSNdqj1xhiHNr34HOHNL2IBd92JM=;
 b=GoLluTHsbWeXG1gRWxkTly1L0aGG6R0ZnjkKFpG4TkBFIFXJkIsxX4nEAZKNifw/92
 rKuJPcwuSIaXTkS5GBztgoM49JPy/IWgQmiCDsVUEyVtjdjhQFIbeoLBbUfzbGLcc1RB
 CBWAKU/8ux26TYiwuAGWqxEw36N0v0tumvKBQOvc8KJ33Vr6GY49wYlTalRfHNNUH3I7
 4zP8JxlwmG6CCM+SuBp2uhcCTsEyeo32v9FnmARrYl7TrUHX0lCznjfbfq4WZeudWkbL
 Z6Aoqqi41L5bRNymAd7n1lIwgfvMWFJCacmKBXPXWDGzgWUtgga7Xvwm8sR+MgzaiITx
 5m5A==
X-Gm-Message-State: AOJu0YwiRERalE9wfUmQkwskN3cHf4WEtX5+sQdIuJYiGjmRCbSjPLPf
 lUwF7hKqQ87f/0a5UgNJpi5ArFzw7zWSg8R3oJSFG0Wdseax9y0z4GzPF01gGZZLvH5lFDwYH5A
 esA/yEWA=
X-Gm-Gg: AZuq6aLJ4qH9I4DGuK7a1KAwkasm7kUZfDw5BwtOapeM0CDgBMzCGOQLXEmIl2qy26Z
 m7MQ/AYqk+fRict8AMmY45+2hyPqzO9QmLxVbANAe5j0RNK29t3mcAnYvAdtzeS9slxzQnNxkl7
 hn/ox+aqKtS5yHyav2EcR56v/MerFMM+G3guokg+FDnyT64lenhQwt1/YV3DPbfdR0m2NM9GSzV
 wIShPKUvKnSb3P7BSXOsOYPI85iJEnbF/mn2QVmfKHmP3DVQCBYXhDW+YnEttlxrdVyJwL/EfWR
 S4DEY1jQBybyqML7k7Edvh3JuBaa9eYZslA3jtqWsTxwreypz89aCaZg7K/2DiglGHT8foINDaU
 dDNSCwWo75u00y/Tvc6rTe9TyGLjf04wWFAjVsrOTjnY67uajtKwnXtHAdj8tRrrvxVZQwvPHmf
 FU8ue4HDW+3qfKALCIAYFTjxVWM4UpUKB8fHsZnBQBbZO6fD6vLm2nXAsexGH0
X-Received: by 2002:a05:600c:3e0e:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4804d307b0cmr11534505e9.16.1769115684917; 
 Thu, 22 Jan 2026 13:01:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470bfe42sm89260495e9.9.2026.01.22.13.01.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/11] target/ppc: Inline cpu_ld/st_data_ra() calls in
 do_hash()
Date: Thu, 22 Jan 2026 22:00:53 +0100
Message-ID: <20260122210101.55358-4-philmd@linaro.org>
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


