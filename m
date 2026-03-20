Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6041093182
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3UYl-0003G9-Az; Fri, 20 Mar 2026 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYd-0003Ck-S2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYc-0003DS-9u
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b49819938so146021f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773992768; x=1774597568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBFqLwCySlhRVZKnQMFhk+efPccSYwi0v7wmrh6svjo=;
 b=vQg18Lov3LFKOjwquhf4q9cfEAI78JNCBTgsvm8UV5k6i5a6LzMYRzaEHVkuXoLKHl
 asIoTH7wEdEHqyaGgYm0h49q9jbxMRVioiqDeKm55rvfJNQJMwFYa7YNTBX+hrE5VkfQ
 ipuABKb9Xr1J6JAkSUGk9w5Co2XkUbTm0M83nIyjDyp+cePzDtJGJ3ez/jCQeHpc+ZIT
 0FGiMT+4xHLlmSIZGWxHoKRV0QG2cK8eLaSN73THSOA1rZelA5+dS/LZYW3OPeQXVtun
 LmI0iCKzKy7LSQjHE/r2/F0zFL880hszctaUhV3oAJqC9Rc+/2JK278WfzFQVot+cYM3
 5Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992768; x=1774597568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lBFqLwCySlhRVZKnQMFhk+efPccSYwi0v7wmrh6svjo=;
 b=flejqKOuYetxdo2STITsRn/OXW3GX8Gigv57ra/kdMuXgGqTa+u0Ti0DP5F4ZIzwWU
 9HZB1R9j6WvZKoV+D4mjgfpCk6lUCDHO6fwNy5WHnwNDI8bR8bWR7AnUuBGmYJeARCZv
 XAMj1rBo7ItGQv4u5DoQCtvDMX0lUj4tY4tKb7P8evqSlz5TGDYlJkbmWnvFMMWwrc0r
 xONRNQBxN9UhiTBCYYWmy7tx3JRtpfThLzUMoDBvC8c4N2D3M3bReWjxdhHDgp4k1RGP
 PuEzrzojc3zJYzs7HRWC9W05WxY65McOtGwO8rUVcehppNsq85P0NCSrWj1U9pZUQmo6
 nWZw==
X-Gm-Message-State: AOJu0YzftWTHHXbQIQ7f9e4I0gen2wOjMtHrQ5XapUDXDlcPLDgaHXju
 VSjod0t9mTqqNC3R69R09nNQZqGhvxZGzgdO4528QyVij7TUW4wSuvRv6OodQn56ofzmDEbJn5b
 ff46j2WY=
X-Gm-Gg: ATEYQzwsvQTAcBssznwXE+0tzI6Yecp9MyIMujtxoZAMIUMTFBB8mUaBpEeOiA7P7cK
 Yt08QO+Iw3yRE+eJ2V7n1HSofVNKw8w0kzFWCcGgrmamW5OZB5JnJYuXsxGjOujJgQDD0Av9bLt
 9oFqBHhx+H/3psaWuUtbgGjj4Md4PIS3ruiBoFrXwWsxHBDEsC5xJ+AaHp6alZbkug9N20YjFoF
 YozTeLm4BeiAhPFAw/qYMMozImnhCZLcdz/BodQeL/I0OIKXxLY/CdcrhcE1JNgdquqjUm6VzkN
 GvW8sIVE30h/JMjwSy3nAKFsihY3EgCvU4ncT5SxElR46zfpy6HgYlyBKSTa67N+3hy/g56P88a
 3h+wWdZxgQlY2AbRK5GHlXyJEfpfNGWkyjsYGbxKC/K1lCyueG/tfloB85OSE18BAqa1EJY2VhC
 8aLgRYpPxBmhJcxtB3FDLo6OENJqki8qMH4lr0nkBvJg==
X-Received: by 2002:a05:6000:2203:b0:43b:46b6:87aa with SMTP id
 ffacd0b85a97d-43b64277e1amr3564056f8f.27.1773992768086; 
 Fri, 20 Mar 2026 00:46:08 -0700 (PDT)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a297sm4100867f8f.37.2026.03.20.00.46.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 00:46:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 1/2] target/mips: Inline cpu_ld{uw,
 l}_code() calls in set_badinstr_registers
Date: Fri, 20 Mar 2026 08:45:54 +0100
Message-ID: <20260320074555.33974-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320074555.33974-1-philmd@linaro.org>
References: <20260320074555.33974-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In preparation of removing the cpu_lduw_code() and cpu_ldl_code()
wrappers, inline them. Directly replace MO_TE by mo_endian_env(env).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/system/tlb_helper.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 566924b079e..b989c7e5bd5 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -999,16 +999,22 @@ static void set_hflags_for_handler(CPUMIPSState *env)
 
 static inline void set_badinstr_registers(CPUMIPSState *env)
 {
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi;
+
     if (env->insn_flags & ISA_NANOMIPS32) {
         if (env->CP0_Config3 & (1 << CP0C3_BI)) {
-            uint32_t instr = (cpu_lduw_code(env, env->active_tc.PC)) << 16;
+            uint32_t instr;
+
+            oi = make_memop_idx(mo_endian_env(env) | MO_UW, cpu_mmu_index(cs, true));
+            instr =  cpu_ldw_code_mmu(env, env->active_tc.PC, oi, 0) << 16;
             if ((instr & 0x10000000) == 0) {
-                instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
+                instr |= cpu_ldw_code_mmu(env, env->active_tc.PC + 2, oi, 0);
             }
             env->CP0_BadInstr = instr;
 
             if ((instr & 0xFC000000) == 0x60000000) {
-                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
+                instr =  cpu_ldw_code_mmu(env, env->active_tc.PC + 4, oi, 0) << 16;
                 env->CP0_BadInstrX = instr;
             }
         }
@@ -1019,12 +1025,14 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
         /* TODO: add BadInstr support for microMIPS */
         return;
     }
+
+    oi = make_memop_idx(mo_endian_env(env) | MO_UL, cpu_mmu_index(cs, true));
     if (env->CP0_Config3 & (1 << CP0C3_BI)) {
-        env->CP0_BadInstr = cpu_ldl_code(env, env->active_tc.PC);
+        env->CP0_BadInstr = cpu_ldl_code_mmu(env, env->active_tc.PC, oi, 0);
     }
     if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
         (env->hflags & MIPS_HFLAG_BMASK)) {
-        env->CP0_BadInstrP = cpu_ldl_code(env, env->active_tc.PC - 4);
+        env->CP0_BadInstrP = cpu_ldl_code_mmu(env, env->active_tc.PC - 4, oi, 0);
     }
 }
 
-- 
2.53.0


