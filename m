Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF7BC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx1M-0006Hm-Eb; Sat, 27 Jan 2024 23:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx1C-0005qS-3o
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:42 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx1A-0004RA-GL
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:41 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29065efa06fso1553948a91.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417018; x=1707021818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMqE9xBix0QLmyhH8Xqft/09pdbioiePfeACz0Kfp3o=;
 b=yWyFvs5GLPW9XgHMsmDwAVGUO25QwbfifYhUo0UrG+4jTdK/Xp26ERHYL4Ywsig+63
 CtK6V/N8P88Mjr2hHibPWBaEJr9k88sP67bnemrYmN0kGpc9mZ96bGqZ1pA3lmkDE5O3
 mJkd1LKpS+8qoDTWCzxjKd/26mvUltaOU3yfp6lw82Y19H/99M4kpyOT81FwDqsnb9pv
 s3wk6gxoe+2aMjEKv0x7RrhTkNMwQ0b1PHVZGeqNPPQMrILnqjlsnLQRkYXpZ33kTSxD
 EepXEQiK0opgXFkTFnsrobAkajcR70EF2fdKK9fsQb8KM4Ghy4EZepYpJZuZgFKxSckR
 mR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417018; x=1707021818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMqE9xBix0QLmyhH8Xqft/09pdbioiePfeACz0Kfp3o=;
 b=e61Cc6Sc65T0rvWijzouoisXMqQ1Ov+SxRgfCaU2Dw/3wXQsGOinnj/MUK2TIRU6+H
 M5fg3Q/Kua5eq4+Z3cFyJ8vY/UKBliryjyHQmeg0GC4Zg2tMeufEy/jcN1GopHPj4yrb
 J19ySOS93UqUEoX0tfHMKnDIiBrxaF0zaUvdzeXhlDvGm5+gfzVMYYl7l7gKnBhVDbLL
 irFXFinUeUpAghJv24otlPGP02/BLdtzozQZwseheciQ7LzWGbIHQAGNmy1kgr9sxbyn
 zIMr1UBBJKm91Vv2BxopS6hIi9ONIDLWnmpeNT475xrqVExbtXAOhVfzNzK5GAAHtCXA
 W6oQ==
X-Gm-Message-State: AOJu0YxtKVcnieCdgeTfwpyUd0caL8x582Yd4J9AhJQtkfdl8L3QXvkl
 wIWapxKirohhGBSliHIQv+d6hPChsPybDTXZSj6AMjV17Kh5VCd2SlV1du+faAzM0Wz/ZCjGhV+
 iT7eaWA==
X-Google-Smtp-Source: AGHT+IEoTkgNygjlQX+xOaKcSFVmDunG/JqWg05qSiM3srH71iwE99c7dgHabEs9hukxMbJAfWZGTg==
X-Received: by 2002:a17:90b:88c:b0:28c:ea35:44f8 with SMTP id
 bj12-20020a17090b088c00b0028cea3544f8mr1631535pjb.79.1706417018287; 
 Sat, 27 Jan 2024 20:43:38 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 32/33] accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
Date: Sun, 28 Jan 2024 14:42:12 +1000
Message-Id: <20240128044213.316480-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to make accel/tcg/ target agnostic,
introduce the cpu_exec_halt() handler.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 2 ++
 accel/tcg/cpu-exec.c          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 013867b890..bf8ff8e3ee 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -112,6 +112,8 @@ struct TCGCPUOps {
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
+    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
+    void (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 75f7ba7bed..82627b12b8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -664,6 +664,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
 #if defined(TARGET_I386)
         if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
             X86CPU *x86_cpu = X86_CPU(cpu);
@@ -673,6 +675,9 @@ static inline bool cpu_handle_halt(CPUState *cpu)
             bql_unlock();
         }
 #endif /* TARGET_I386 */
+        if (tcg_ops->cpu_exec_halt) {
+            tcg_ops->cpu_exec_halt(cpu);
+        }
         if (!cpu_has_work(cpu)) {
             return true;
         }
-- 
2.34.1


