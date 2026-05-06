Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcs3-0002eB-1i; Wed, 06 May 2026 10:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcra-0001hy-0D
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:34 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrY-0001HA-1o
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so182701966b.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076269; x=1778681069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uM6UWyoawDF9y6Yim7qGoTjBgyDsq2sGYBt8tqPaAvs=;
 b=uEA0UZ2s0fNv5JhBBQka7ua30cCrEHEyv5hpTfFISL5sLvJtDfcM2WRc15euOhKHe4
 /V+oZTrgt1tuUICr2R5XtQ4P9yMjEt7Jgw7YqaUeScw9bQBOpzf5mGQOj4KIECRXR1fQ
 jGrb4kB2TdCUnxYw0EdzJPolRm5Iym+1HHMUE1wrEIJE9KJohbEXI3xT+DBzEH0sd1jy
 EDXWfRdqodXMVy+eDj8omQKYgaQ1jev7tQJw9u8Lth+cTTykLMPKS2+8KjnjtRR3mEZe
 eqXIlumX9Kv3Q9BbNmlgak9P2QlXwMI8woIjEb459bXForF6NK7wq3j1bOIe/S/8009a
 kTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076269; x=1778681069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uM6UWyoawDF9y6Yim7qGoTjBgyDsq2sGYBt8tqPaAvs=;
 b=HOU2oNCSB1rWIiyKlufx5vaGhYA8ttRv8msKarFM/OYvq4ml/PXgxtsQF8MLBlrqz7
 KcRlPATXtUsWwQo6E6G+Xo650T7DGvGO8tc6IE9onex3eQJ7jUQ5sLIwsRr3dS2elQyA
 xcgmosNeDB0NI9R7kWjp0DgR4WJzkHrtzTt4QUuToy5kD6XL0KSPHqn9Q1BdgcKqI7Lg
 +R/kYadFv+TM5BdjOvNLujX/xbS1VF4EhIAm4oMvPqshWx9YnRtQmCEWCwyymItIIsFK
 ASoZxQwEqSEUIsuUTwb9AmfHWFy6KVAoeIP11+AI4If86GkJyD7Y1r7YWXyyfEHEAjhq
 gwQg==
X-Gm-Message-State: AOJu0YxpM117jCnoGeNmVg0+mhzDJcD9fPENvaFkyP5QI44IqBFCEdJy
 0BaIIEXyMXVHlpBpgh4VCjXARdRDIEd4b4FW+/fHXGCuWIPeQAEK2e0WkXIo5EYMuWUoSaecNeL
 Xho/r8po=
X-Gm-Gg: AeBDiesrWDIFv5jJHu3KW+oBbHosKhwX3XKJ+DkYggex9wsIicVULmiPIlKlcJ07FDZ
 Mtc10q2c//hp2n/LU+ntxJHkfSbhgse9w8SIIQ/GnluCwxJUdMSQd/fVBcSuKV/UDSA6A2SsmMt
 uM093Y/r/HQSwHlF2Fs+CEdGyMvXCd7VKJjLfoxTdD+liTZG76HyJRqYk+jISOQ0PJM6Lc2g9F6
 YAdJmpJZaZpn/fOvM7nuSYKghYaI8pmRZCKOLYAY1Fs34c5W/9AM938m8rdDM/hO/z31NY36Q6o
 gyjjie3DM5X0GMGyFGwqFBWDPPQdZn8ks3CgNyu9WgnAHaNa5rG8GWMMB2G5F3AvniinKKmpsw2
 /eGHG7O0mzx3HY7Pa4q1OEqwFqrXEnwiEnK1c03itC9H63JR2hJaa3Mgm0CinTXCxLyOx4CqQOi
 yj9wK860vgjhwc0WjBDbaqKfgSkSo9fEVtgKjlU+WoU+I4QJZPqGe/4224sTwRQ77eVpWKzqXPt
 GiquGkTDwU=
X-Received: by 2002:a17:906:e090:b0:bc4:f3ff:7c46 with SMTP id
 a640c23a62f3a-bc4f3ff83d3mr210646366b.7.1778076267985; 
 Wed, 06 May 2026 07:04:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48c04sm13277383f8f.15.2026.05.06.07.04.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 069/110] target/mips: Inline cpu_ld{uw,
 l}_code() calls in set_badinstr_registers
Date: Wed,  6 May 2026 15:54:41 +0200
Message-ID: <20260506135524.20617-70-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260320074555.33974-2-philmd@linaro.org>
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


