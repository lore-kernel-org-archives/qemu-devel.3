Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB13CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcoi-0004dN-BA; Fri, 21 Nov 2025 20:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbZu-0001sD-M3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:14 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbXs-0004ru-T4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:11 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5957f617ff0so2879582e87.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763771507; x=1764376307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeYBDSu6cMgQceRuy5tiVH2SP+8CoWLSP+CQiGR2J0w=;
 b=hEZjXeTYsBIYWX5wd51UrXeaoBrNb7Uasi1ITZbdd69+MRjId1Ht6EFwrYO4+f0fOR
 c5TW20+k/4EaaXgFL+SapMkRTWyBhF/4M2OP4Bks52u32cTDYSuflG5vxILmKNv5Fhip
 RYzhLzrTID1B+JF68kmgoqweox3YoloAfKI+9AGpH68xFLj8HZNq3S3b3eC7LjxfAwev
 E9jHo5essNDjt0TIZdbcQDSCitVL23xufn4g684b3lGMdMdZfhGdHTzx5EHng+SPNwS6
 bJOuj/w3VxmuEpLr+8HshE4UC6+HGcnB6hPG60Sjr2g476ITm/MfYypUmzLu1K3/rRLu
 hQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771507; x=1764376307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PeYBDSu6cMgQceRuy5tiVH2SP+8CoWLSP+CQiGR2J0w=;
 b=Tv7xLEYrMlWXas9i/1vNbcnugjGgKCoDjJ+qA3d5nNobbTzC03u5KVDYvrp8BUrAZM
 ZqMdKumeIuqAoh9tOz/PN5lJEtBtsq8Fgp38xv2bx0XECMoSHp9fD5W8y+5wZRwv6bU0
 HuCk4k4BjeREZV1y+Mx6slqdgGXY/qouNuA18qVWNexJIeoLZCAg5gIzetl+Ah+mDH8z
 5Ygjr6+afQNrE8VCzgTthwV4ofI4Y+maQKKGZB5j/Aj0F93uC6GYi8SjVffUu5Mo5u2T
 52ok9UB2f7mCpXtHF49YQfMobfpCxWg19+k+3O541uIwXrq13KSb+yfkQQJVlX8ey3VM
 n9hw==
X-Gm-Message-State: AOJu0YwyY6Y2bqI3Z+HOXdRi9xrrIlerqy2KpCKHUaA7+VIN3E1Ayk0p
 EYq8+hf5oerciPPRZ4ioQbspta3iNKpymGqpuKj9RXCyizE3WlPnegQdP4JJJJj1fXJp49xFDK6
 65H4YYsT0oA==
X-Gm-Gg: ASbGnctidIR8FZTo3YVGVAndhaOm+i4oPxb3ZkFc3KjpgB/+9Hnuxhfch/JVb0ghkWN
 gzauo7LDz0Pbu0VEEMGHl4scvO4sRebosxHqxsg7V4BLleDcmhFFua35aZHC0Ts4tb+ob02v29H
 iE75iFAjnv/8aIcrhe1vq/JMD5pouJpYzl4CnWRz6sC8l3mKYEdsjXejMIAb04QouV5ypvjVOmH
 myLmXOKK8mthqKHUCrmy9LmQeDEkzvUUtp+hC2DKtst2bo/bAun4bO/RAdSl50GJptOmcIQWZHL
 /Pn86S6fKv9frYjIS5t583ehIoxDEZTwGe/ZiMyqwlAgaw3DM/ru/hJHrJ0+kRS0cCsnjSM184t
 1+EEU5cioMgKWuRcZMiU91dOKvWn7lKIYLksFD9DcsnqgTMBOBe00LBWElswTR/ypaSTRh3Pyxk
 fevgx38mGR5YlhYn/2HDJzlNXHobhlqCaPd0nOiN9Li8zmYdzUxyWU+zQrVfDW
X-Google-Smtp-Source: AGHT+IGOy7ijW3Saoq3tEPfafETXCLdd03s9R4J1y/0QOA7IKP9EnH8884b5OD/Z9Zvc/CZ5mAuqPw==
X-Received: by 2002:a05:600c:3551:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-477c10e2bc2mr28653215e9.15.1763732758974; 
 Fri, 21 Nov 2025 05:45:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9dea7fcsm87143845e9.8.2025.11.21.05.45.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 08/21] target/mips: Replace cpu_ld{uw,
 l}_code() by explicit endianness variants
Date: Fri, 21 Nov 2025 14:44:50 +0100
Message-ID: <20251121134503.30914-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/system/tlb_helper.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 566924b079e..415c214c5b4 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -997,18 +997,30 @@ static void set_hflags_for_handler(CPUMIPSState *env)
     }
 }
 
+static uint16_t lduw_code(CPUMIPSState *env, target_ulong addr)
+{
+    return mips_env_is_bigendian(env) ? cpu_lduw_be_code(env, addr)
+                                      : cpu_lduw_le_code(env, addr);
+}
+
+static uint32_t ldl_code(CPUMIPSState *env, target_ulong addr)
+{
+    return mips_env_is_bigendian(env) ? cpu_ldl_be_code(env, addr)
+                                      : cpu_ldl_le_code(env, addr);
+}
+
 static inline void set_badinstr_registers(CPUMIPSState *env)
 {
     if (env->insn_flags & ISA_NANOMIPS32) {
         if (env->CP0_Config3 & (1 << CP0C3_BI)) {
-            uint32_t instr = (cpu_lduw_code(env, env->active_tc.PC)) << 16;
+            uint32_t instr = (lduw_code(env, env->active_tc.PC)) << 16;
             if ((instr & 0x10000000) == 0) {
-                instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
+                instr |= lduw_code(env, env->active_tc.PC + 2);
             }
             env->CP0_BadInstr = instr;
 
             if ((instr & 0xFC000000) == 0x60000000) {
-                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
+                instr = lduw_code(env, env->active_tc.PC + 4) << 16;
                 env->CP0_BadInstrX = instr;
             }
         }
@@ -1020,11 +1032,11 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
         return;
     }
     if (env->CP0_Config3 & (1 << CP0C3_BI)) {
-        env->CP0_BadInstr = cpu_ldl_code(env, env->active_tc.PC);
+        env->CP0_BadInstr = ldl_code(env, env->active_tc.PC);
     }
     if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
         (env->hflags & MIPS_HFLAG_BMASK)) {
-        env->CP0_BadInstrP = cpu_ldl_code(env, env->active_tc.PC - 4);
+        env->CP0_BadInstrP = ldl_code(env, env->active_tc.PC - 4);
     }
 }
 
-- 
2.51.0


