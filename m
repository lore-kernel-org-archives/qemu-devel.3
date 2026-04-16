Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0C4F8D758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOJG-0007rp-Rg; Thu, 16 Apr 2026 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOJC-0007n3-SU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOJB-0000lH-Cv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso79210795e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352027; x=1776956827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8eTKiduCZMg9yJhYc+PUDvB0qmyxyEaSBVvhdpHjpQ=;
 b=VnNAT0OumMm8S25cvdMesFlgWfRI8bVlbbM2dnYLLBh9H17S+43KqVeesMpm/5HwPZ
 dzM8U1HSimV8TEmXMfGgEiRM8da596JL+ZLHalydnQ2hH6XkR1osOAeyT8xrAE73yfSq
 VdLLqTf29KPYY9xwQDqfD5yGVtls54oYe7CiWMP13omQCYlmCDgyDzObb8V0n3FexB8N
 E4pc0D9gegGozYF+3RmaFcSId9nmRP8QqWuPKKDsvgbQAqHJi1/GyUzbUESDWlvZem4M
 l5yjtF1dvLB3sva/l3nj5QhFRlr6S+APoDsqFRwMuyvIKNrnqrfpdgSip0a2Q6eSo2+x
 czZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352027; x=1776956827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/8eTKiduCZMg9yJhYc+PUDvB0qmyxyEaSBVvhdpHjpQ=;
 b=FgimNhkN1mqpZqio5VynOTBDbye7uTVH4SjnHoBMJixKVQGpxuDcdiLOXgL4aE1Teg
 tqEROvvTk8S7Tq79zjs93mMyFTX8Cr7jK1D+oYi081Yo2uY1cOqb+xyZyWcr2SOggqPy
 wCJF5nO2ZCD7Nqgd3szGMfclsDI674daPK9s7sMIWcqALwS1qILD7e/5QWLYSSiCCVFB
 pJuLOXaJC6+1+6Vdn5G6DRVwX2nF8+GJktVvkCo3lEYWOWaqo40FkoDLGFRudWNjYo8m
 Bp4ik7k6wJB24vVM/T8P2arKdszl3PI7yARFNjJkd13olXRn4+T+PN+WWcJozlRcRjph
 t+6A==
X-Gm-Message-State: AOJu0Yw4ImHAnn3fUpiLVynw/9rMmZ6AmHK+zAqMQWk77yIAmC9R6/oe
 +80YcKbAZN+AX34Xowht4C3QyvECyXDBHUoLQzxCTzG6PfF8kDXqEKv3+8QxyMRzb1vk9VQdQmV
 Bg++x2uo=
X-Gm-Gg: AeBDieuhU6gxW63nUh5kZ/pT77gjg5vIeWx3m+0rlRow9iLkty1+p4SAvspcqW+eR4K
 IITVEd+4w2RuN9V2ivH35aoWTh6X61ptyjwu8Gh9pAmrolCsYXUfcZCkyfNXWNMNC/B1O1H6j51
 dOYzMv6XlDRoGPVwntqcFM91VWkvHoAUDEOLKafonFDTJLpcjXU6RiZOIL1rH776X07jYeW7QPB
 slJdKsbX+L50ajS4Hcg1IbN66Uh2fpQf21JrIdpDQlUFTssYw0MYVIuvjuSulIWcuqgnZtIHSZB
 6OQ2EIgCerEh+7wpaUwLCa0wSwHwxIkiOL7e1T+u/0e04ts6W1aHrKrQeUkaItFtkx775utGe9/
 V/pa/rQq36Y+ES1ztdsR3VbIZ9n1vEx6fGqfV6rn04e+DgiuBKlsVv9XgRcBuP9OM4guyacrNm7
 q0f5MvONW+jNL7F3P/7xD//CPl6a6ldKg2OMEtW+2ck96TonjqYo8vAS5JBpOyiNvz11jp3YcC
X-Received: by 2002:a05:600c:5292:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488d67fa48emr383437815e9.9.1776352027386; 
 Thu, 16 Apr 2026 08:07:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e71f5dsm68350215e9.6.2026.04.16.08.07.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 08:07:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 2/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Date: Thu, 16 Apr 2026 17:06:49 +0200
Message-ID: <20260416150649.23671-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416150649.23671-1-philmd@linaro.org>
References: <20260416150649.23671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Let the probe_access() API check the address alignment.

Move env->CP0_LLAddr and env->lladdr assignments so we
don't update them when an alignment fault occurs.

Since we have a handy MemOpIdx, replace the legacy
cpu_ld*_mmuidx_ra() calls by cpu_ld*_mmu() equivalent.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

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
-- 
2.53.0


