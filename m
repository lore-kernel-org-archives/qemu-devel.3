Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F22F8D775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSyG-0000KY-Hj; Thu, 16 Apr 2026 16:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxz-0008V5-C4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxx-0008I9-3m
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so4325910f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369930; x=1776974730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9K4LtXD4htqKcuCzEDGNxbXS9ukINIj2XSlyTHvWnFM=;
 b=QEhotvu2VHZ77qHEUeRPgtDdDRi4C8IchU+XmXAwp943n2fK3jwl5B7wg2ydgUW4xQ
 UdnbecfyCeLOWR6AeehA8l97pffn0jljWs5z+WSUxIb5Ms2tslbRalwjTDEx+Fb2O/f8
 0+M6easQBcD45OpSZn/pR9rnrcHltbKnyti4bcDXIZvuDzKIDsN4gtAOB/UjS4CclY3v
 R30UjMVRGvLUJgZFNBVNT4BC+/+s9HQ7c1A4706BWNTUybVcdCmEFul1JBn6jR70KlJL
 fEoZ0H565yw1m5YkEmX/D/VIsLzQs5lce+qPFwdWE1QmlsTM9A3IiqtADSNVzWOfFSDU
 /O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369930; x=1776974730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9K4LtXD4htqKcuCzEDGNxbXS9ukINIj2XSlyTHvWnFM=;
 b=MogmlHciErmDhRdaclaqpyAdZEHlI977ljW0lmAooDCTsMxVUINM0zL3c2fp0hpRGX
 jW+IBitHSJ1+1++isEjGOIS6Y7Me09DLsaMMtKlxhRUwVUN+7FMIuDWGJnsZuceTexS8
 IM61grvB+VgX08i0R5FnqqIFXd/rPmnmN448EDqoh0QR8WybBRwQi/a1Qhy/8AcMaqs9
 qr2LLMw89C3ddvHYxRLliqpkABV9jOdBtlgGr9EYC8GcyfnOy3HWyIHiC17ZkMspyibm
 DYq0WFYDuhduRKeKwAtK1gzsc+fvneXRjUm1Qqeg6rSJGUUDpcxlZvUZ7BLkkRJ2Cdcw
 p8uw==
X-Gm-Message-State: AOJu0Yzl9I74PrF4GPYKqaXKauDk7sZYunRvetjxXHoCO8XKWhbQxrhi
 rXzPHewJfBDVqrCdxT2LkWzceOLlBmfY4T0YI5xZ1FqlRhqymKqe9RwJzhUBGf5JD9egkWVVzPt
 AU+WEtE8=
X-Gm-Gg: AeBDietL71Iw/0aMf0JfUuQByBVcooB5vvJER5aSLO1v23YR0Qt7DUfU59BLGYPFThq
 mNfXig9c+faVpu3WaLTxSw+ILKQlHcByJs0n4ze1m2/fV+O19X7mVkV6+itQUV9hB7869hoVJo2
 0vINpoWgB3OwqIwMf/TbimYaiXrt8Z7YjlaUnl89gouHOdcrsKEUbHiroBJN+cwfSI8dD56Cl6s
 9dmvOoo/i+8vyoA7XIQyQjlQ27Gtm/5mQHJPdAzAaz83Z7wQulUvHGGK0vRyOtvvtZkooELLViZ
 DWaANyx3++NR7jTdRF1wMp4GwiivcOnsNT5WRPcOK9TtqCkBsJFU3NqrfNmBSQXqA6hC4ACDHCR
 nrCsYS2Rr0/FnZ0fsptlbYVWi+vWla9b5U2881pNmTQgdRbiXW+xOl8P8wFVlnQ6iUkIuiBm13J
 zIA18whyAv1AjucvKCDqEzusG+rKK3Lst/0XGSxpOD4/763Gb8xhbQf0hKvGKFVDH2gFwrtsiXn
 v1b7Y6+LUE=
X-Received: by 2002:a5d:64e3:0:b0:43d:7b23:bc99 with SMTP id
 ffacd0b85a97d-43fe0eaf176mr1181929f8f.15.1776369930018; 
 Thu, 16 Apr 2026 13:05:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3ebaaasm16889893f8f.32.2026.04.16.13.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 13:05:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v5 2/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Date: Thu, 16 Apr 2026 22:05:13 +0200
Message-ID: <20260416200513.27100-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416200513.27100-1-philmd@linaro.org>
References: <20260416200513.27100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Let the probe_access() API check the address alignment
(request MO_ALIGN in the MemOp bits).

Move env->CP0_LLAddr and env->lladdr assignments so we
don't update them when an alignment fault occurs.

Since we have a handy MemOpIdx, replace the legacy
cpu_ld*_mmuidx_ra() calls by cpu_ld*_mmu() equivalent.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 21 +++++++++++++++------
 target/mips/tcg/translate.c   |  2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index b725c6d0333..4ebf72d610e 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -28,23 +28,32 @@
 #include "internal.h"
 
 #ifndef CONFIG_USER_ONLY
+#include "accel/tcg/probe.h"
+#include "exec/tlb-flags.h"
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
                            uint32_t memop_idx)                                \
 {                                                                             \
-    MemOpIdx oi = memop_idx; \
-    unsigned mem_idx = get_mmuidx(oi); \
-    if (arg & almask) {                                                       \
+    MemOpIdx oi = memop_idx;                                                  \
+    unsigned mem_idx = get_mmuidx(oi);                                        \
+    unsigned size = memop_size(get_memop(oi));                                \
+    uintptr_t ra = GETPC();                                                   \
+    CPUTLBEntryFull *full;                                                    \
+    void *host_unused;                                                        \
+    int flags;                                                                \
+                                                                              \
+    env->llval = do_cast cpu_##insn##_mmu(env, arg, oi, ra);                  \
+    flags = probe_access_full(env, arg, size, MMU_DATA_LOAD, mem_idx,         \
+                              true, &host_unused, &full, ra);                 \
+    if (unlikely(flags & TLB_INVALID_MASK)) {                                 \
         if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
             env->CP0_BadVAddr = arg;                                          \
         }                                                                     \
         do_raise_exception(env, EXCP_AdEL, GETPC());                          \
     }                                                                         \
-    env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
-                                                 GETPC());                    \
+    env->CP0_LLAddr = full->phys_addr;                                        \
     env->lladdr = arg;                                                        \
-    env->llval = do_cast cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  \
     return env->llval;                                                        \
 }
 HELPER_LD_ATOMIC(ll, ldl, 0x3, (target_long)(int32_t))
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 839bfe18bab..4889bd1e518 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1936,7 +1936,7 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx_ignored,  \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    MemOpIdx oi = make_memop_idx(memop, mem_idx);                          \
+    MemOpIdx oi = make_memop_idx(memop | MO_ALIGN, mem_idx);               \
     gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
-- 
2.53.0


