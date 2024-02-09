Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924BDC4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 08:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMdw-00023V-4K; Fri, 09 Feb 2024 03:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMdu-000238-8M
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:53:54 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMds-0006LX-Li
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:53:54 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3810e975aaso78848966b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707468830; x=1708073630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pwSfvCJqzj+wIq2XrLR1OJ8LL64wnx0Gphh6ut+YpUs=;
 b=CVghlhw8L1h5xSA3pxSauCb1VWgrdGxUYReo1r9cpnwYIXMQC+1ExfC7G6xu9vyBVX
 BnK2pPET7KEWbXEi0ZIX338OiC9iN4NsKBDFgGbPsEUiVVFsQb7/XVAHvZHNsMt2L83x
 IJulDjbX/1iygcYAWyRlgJlzv9kCBkD0avY+C4cvJ7vvO+qgGdETD2BAyB59zqBtQ5W+
 dJOq9+ahXC6ShvVR4VTtXiUfHu7omo0FI6CJMNlIEEzj7nKNbE6vf5nFUeEASEyjTgqp
 cEpFPRG2FgLf2XfmBh7YA4ozYLFD1f5EOq6U8Y68WDCfy2dMmZuEKZjAw6UycDUWX1yf
 p7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707468830; x=1708073630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwSfvCJqzj+wIq2XrLR1OJ8LL64wnx0Gphh6ut+YpUs=;
 b=ZtG7pVoqGvk7a2Y7lVNGHhYDJ8tEzw98Lty7H8kd12v1k66bpoAo4IJac6BL2v4jOY
 31xpfGk+mpo4MHvIqKX2lGsMaP95Zwuh3T2Lr1evpTNoDXk5D1Qe5rHwf+R5OQVRWLTt
 bjza2mBtRl/w9UKnc/0aZMfAUFgHT/j6/F1gjsXiDzajQHcrcSzWXmb2E2qlJuJ9vWig
 rot72X0Xnsj1jQ863nJ3TSXtLfnJyk+kJdGNcccnyvAnndRNcKRST053Qv1AiBKzamnr
 MF6xO8XaNxQsXHbQQWwYcPoHpb546a6Bua36qBM/Euf9xAX0litzS+EBr5/DAn4VZdmh
 gpJA==
X-Gm-Message-State: AOJu0YyKmxXnGpBjpyV+TMX10nR9QL5EoQpxMsK/6WtkWNheMhXCnC5M
 XnJzwjOKvle360L+EgWvyRcPoYSiXBMlyd4zDjhqpzA1x5FOz+ltngjLkm1QYH8X0eDIRl2G2Rk
 wIR8=
X-Google-Smtp-Source: AGHT+IGW+79XK6so27T4BOMQRbx6oUMi1gYTgq8jWnFpAzWJr2h3+Bdvfk91G+Nd0nbn5fRZg7GpOg==
X-Received: by 2002:a17:906:4a45:b0:a37:625d:397d with SMTP id
 a5-20020a1709064a4500b00a37625d397dmr730948ejv.44.1707468830492; 
 Fri, 09 Feb 2024 00:53:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWc2qVm7ipOoFRXJA6+rz12A5prG6T1E7XPxtx5Z3lYUcp6m9nFvEfgw96H4uv4Rmw9bbbJRRu0L3GbzDCz+d3BqSTqEMImrdf4ElcbC+/oDQPDjke1OWn8QZM2rD7xYbxBrX65RYutr32AYg1nstgsVhTt4HsgjlmvtM0sPRGYcFKOV4I3fJZf/LvaFCnxN8OztcggLuserBwUtCARIz9Wwcns7BiXQ2xJ84KMlx0tGaWIBZzcWWvE4d+Rv8o=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a17090605d700b00a38a476fc08sm545645ejt.87.2024.02.09.00.53.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 00:53:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [dubious RFC PATCH] target/mips: Allow I6500 CPU to access CP0 SAAR
 registers
Date: Fri,  9 Feb 2024 09:53:47 +0100
Message-ID: <20240209085347.8446-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Desperate attempt to enable access from ITU to SAAR registers, by
taking missing part of commits c9340491cc ("target-mips: implement
SAARI/SAAR registers") and c1af807054 ("target-mips: add I6500 core
configuration") from [*] which were partly committed as 5fb2dcd179
("target/mips: Provide R/W access to SAARI and SAAR CP0 registers").

[*] https://github.com/MIPS/qemu/commit/c9340491cc.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I can not test this. We don't test the I6500 anyway. Besides this
CPU lacks DSPRAM support which was never merged, see:
https://lore.kernel.org/qemu-devel/1566216496-17375-2-git-send-email-aleksandar.markovic@rt-rk.com/
and:
https://github.com/MIPS/qemu/commit/a4c1477c84#diff-5362bb61a4a73490270458b19e452bac9b3b907f4efd59ece6494ec19d033a81
so I doubt it is really useful in its current incomplete state.
---
 target/mips/cpu.c           | 1 +
 target/mips/tcg/translate.c | 1 +
 target/mips/cpu-defs.c.inc  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d644adbc77..6fa5902ec7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -256,6 +256,7 @@ static void mips_cpu_reset_hold(Object *obj)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    env->saarp = env->cpu_model->SAARP;
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 12094cc1e7..ee2b4051f3 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15405,6 +15405,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
     ctx->vp = (env->CP0_Config5 >> CP0C5_VP) & 1;
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
+    ctx->saar = (bool) env->saarp;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index fbf787d8ce..6885196dca 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -817,6 +817,7 @@ const mips_def_t mips_defs[] =
         .PABITS = 48,
         .insn_flags = CPU_MIPS64R6,
         .mmu_type = MMU_TYPE_R4000,
+        .SAARP = 1,
     },
     {
         .name = "Loongson-2E",
-- 
2.41.0


