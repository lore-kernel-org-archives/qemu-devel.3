Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4D5CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuE-0007pH-RC; Wed, 06 May 2026 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctI-0005f6-QL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctC-0001m1-Uk
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b150559bso44952635e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076372; x=1778681172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ivFnlR9eWQsRMPs6/PVT5snQ5D0F0dv4qOp7SGIUiJw=;
 b=FNNoM/Th3Oin2WnYZoxCwkHPUVc48fHXPdEzt1DEx1Vn1UfgYkdgzUdciGAap2Qnwa
 nLFSx1IQ8SWAhKBEKglstMyXxMCuyXf57nq4Jyl2uqFSgOBUCwGsbCHKn6Z7/Zk4I0Kk
 G+cwnrK185OxxDw5sIGN4q6xwUGN+vfZfgcUpN10rsdDIbq1bzBKD5AXQ9mhxg9uepC1
 OBbPOlRgWgdtrudSWV7spsvb2uJakuXtgybYDyMaTYTII9hDavcp578ZqmSaMoDffa1H
 LkavfRSVLc5ckoFsDSKLlaM4sLyQQ92rBFnFIR9Rl2jL+Q+VUIv3QW0cs6yz6X9Ee4LE
 gsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076372; x=1778681172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ivFnlR9eWQsRMPs6/PVT5snQ5D0F0dv4qOp7SGIUiJw=;
 b=QbE1tAEVe8ijDMG+4Xc6MhzjAHskOqSPCKxs1U1q1UVUvGdcXm6zKDGgW2ExxLqZC8
 jrFtFZSBfntk2KJ9XhIvcK4P34aQrRa1lwtIQZmzDDxZ6xKGi+zHvUGwINaiuUauxmDy
 pJYpQ7jjSTh0T/QycfrItHi7QpwwgJdbpUEYQtXyrjA5xataXmVuLZtvYZbUP/WNRGdn
 UZH5XU+UOQuEBE+Zznz+DutVOpUQ23dFETaeU1TNPVcgrLFLziPCK79aOuwFcBBcMF6D
 ZCuUUYecO9CmyWfymruAREiEXhiXo0z1zdXsoH9ZUto7svia5evaR//MdaXkdEPVeNqZ
 CK8g==
X-Gm-Message-State: AOJu0YysXc7XBexZBDqIngGwcxPCCsu4ekjefTkA9MzRDuTlKO7D52Mb
 +ZkweeKrV3MEJWB4UboShWCvLs8QpIsmHPaJu0DP6kv3fjYDI+GG/hYOmmtKAkuF44KsfP9JGGF
 svD30UYQ=
X-Gm-Gg: AeBDievBWRhDXyoW8SSbYuD66RKlT6jApr2IkLp/cUkEOGhFqhDYaGhnt33vlQElvJ6
 r6d0aANuN5U4WWWOvxhRlwYZRSN72L+CoA1e+TUgkSlQH3agc8jnaMX3u58Jl9VH2QdQjKTnylw
 kmisAUuwYRS3bHo3txQwECQLIWELLHJWvY/uL2sVsKq9Jao84f+UbnW1z/M+UVrWRUx0/Vlxkn3
 +CffMwh5s6vAWuOUkviEcBbMN/gK2H3VkBzgWQfqJi8Pl8uKIxxXapyEvX0aGXsPVsR+e/Y5LPn
 FYZAHDQ/wDeoLvjIoxce+dQYsM7ruMXp4v6QZnOCsuxfeBZDbHYb6ztaXALITXTlBFGfmxtUzmy
 bRFf9A9IA/dLbGr0WRwMtLKbf8ovS/1UX8TAgXmKMPtDSOnaFtSRflneXpK1LI24Yr7nZ0H3ocO
 vNz40Q4803O/y9tPOTF71YSpaQxFOMmca5Zd05jRaduA7Ulc8AskeuFJyfz9hp+UEJQzxaYPrZg
 vrsdWrZFu4=
X-Received: by 2002:a05:600c:47d3:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48e51f37358mr38066405e9.16.1778076372115; 
 Wed, 06 May 2026 07:06:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d36dacsm12685450f8f.32.2026.05.06.07.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 082/110] target/microblaze: Replace translator_ldl_swap() ->
 translator_ldl_end()
Date: Wed,  6 May 2026 15:54:54 +0200
Message-ID: <20260506135524.20617-83-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the microblaze targets, using mo_endian(ctx) --
which we introduced in commit 2c9e8ddd7699 -- instead of MO_TE.
Remove mb_cpu_is_big_endian() which is now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-4-philmd@linaro.org>
---
 target/microblaze/cpu.h       | 7 -------
 target/microblaze/translate.c | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5765786e6dc..ad5a4a8e7bf 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -412,13 +412,6 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-static inline bool mb_cpu_is_big_endian(CPUState *cs)
-{
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-
-    return !cpu->cfg.endi;
-}
-
 #if !defined(CONFIG_USER_ONLY)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5e8bb4ed77b..8fee5dbc337 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1646,8 +1646,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
-                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
+    ir = translator_ldl_end(cpu_env(cs), &dc->base, dc->base.pc_next,
+                            mo_endian(dc));
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.53.0


