Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D65C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv4-00029C-Mb; Sun, 04 May 2025 01:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuy-00025T-Rc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuw-0004Kx-VZ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3435619b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336573; x=1746941373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzMy66shbPXXlyjnEns4rH7PvNwF6buM8qH1Xg0FZ+4=;
 b=cmKIp1RBB4nYsIJT6Nfu1qBw9SIWaM++Zyl6fcPU682HZQNnZf+z3g5oRd2lTG+CHm
 JTjNWAEiR3mqTcwwVGP6q4Z+O0l+0m5hi4uuWQ8VEA06pepQ49QjC+q4WpZNZmjm8WUe
 gqJwOyDSa22tBWiotr2as6yBX1ZMicmgGSedT+n2Y2U9e/7RJe3+Sfx8AqxtVEXQfMqp
 xZKmVE2cqJTZ+jqfeIDhGG8SBTRjdWigzfnE1WfYdBC9YEer0vMEunLbXqxDX5EiZUct
 NFd5CdZMW8DjuK25eYf2zeorigYxvTMOrny/jdLy2bsu4YJdLSHRrbpaSr/kv3wrk8fg
 v4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336573; x=1746941373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzMy66shbPXXlyjnEns4rH7PvNwF6buM8qH1Xg0FZ+4=;
 b=QSO1n87fRPwm6Wz2ayywUtNr91yHTMp/Erc6HLUgz1JHmZ4io6DuinUWGYMNsyrtSw
 YswTdgstS/yJ7CQmLuK0s4VlvJ0k9z5AkttCtcnnOTbb1u7qG7zMydRWHQzlsIfPiMD8
 rXPIdcp/QlsV7dcLjthUd86wqPBWvzqq9C7HqplsLcKWgPD/OcPgrOyfD1LWZNQHda1r
 0pJ70Vtv2eAv9JbIVSFPaoL45+q4QXZjCmVNIAieC6lyBMZcZ2dFBz6o2EKHKWhSvDkd
 M49VqdPpuNMBKtYKzlCwD0xTwgzfVVAXAqq1tYNahfFpgYsp1zAWmIKi5qjG1m43yrHB
 p+AQ==
X-Gm-Message-State: AOJu0Yzluw8Gx9D9r+qVuXwQwoRFhKRGtpJzqFIyCrOLA/27/tsr8J/p
 Ur5kx7BdeBnWAlUXAAvpTSS1UH38zP6ELoozNJ4F8urNzUPkdrp63zWezm1nQfwny5CTI4DQdJd
 u/eE=
X-Gm-Gg: ASbGnctEDNI81SQop18wcIOySyHgp1Q6JnnsV6ZveaJ2QY58b9Lt64yf07LVsMFuwUN
 mQwEanXL38S+4efgk+S8EY3eYq0XYJEODTQjKrSBBnU9vTi7Sx54NV7zAcSYcd+Q/g4/EZ11NMA
 zhsZJuihQHxtyiUEI5dQ7RIQJZU/5iZHmx4butVE4p0e8EiT6X4Zk2AimwPMmES0rAGrmFm8m54
 ocKAfp3RqteplxvvxNgYdT0T5jrLKq3oFNyn0olxQqWQXn59QyX+sACPKFZjmwHBtk4YcPx3Vd+
 CYO8MRQ/vHwoz+mAGfRoXRAzcWBOwBseoPhQWMIU
X-Google-Smtp-Source: AGHT+IF3MsqDxnvukykvE/6O00kSUuX24CTMca9uQ13CHCSwtTjTadd/FH15AOifa1kLNKXwqjQ+ZQ==
X-Received: by 2002:aa7:9314:0:b0:73e:30dd:d14b with SMTP id
 d2e1a72fcca58-7406f1769e2mr4015705b3a.15.1746336573425; 
 Sat, 03 May 2025 22:29:33 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 15/40] target/arm/helper: use vaddr instead of target_ulong
 for exception_pc_alignment
Date: Sat,  3 May 2025 22:28:49 -0700
Message-ID: <20250504052914.3525365-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h            | 2 +-
 target/arm/tcg/tlb_helper.c    | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 09075058391..95b9211c6f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
 DEF_HELPER_2(exception_swstep, noreturn, env, i32)
-DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
+DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8841f039bc6..4e3e96a2af0 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -277,7 +277,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
+void helper_exception_pc_alignment(CPUARMState *env, vaddr pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d9305f9d269..4f94fe179b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10243,7 +10243,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * start of the TB.
          */
         assert(s->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         s->base.is_jmp = DISAS_NORETURN;
         s->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 88df9c482ab..99f07047fe5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7790,7 +7790,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * be possible after an indirect branch, at the start of the TB.
          */
         assert(dc->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         dc->base.is_jmp = DISAS_NORETURN;
         dc->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
-- 
2.47.2


