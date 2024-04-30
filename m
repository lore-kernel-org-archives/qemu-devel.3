Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DB8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbn-00071d-KU; Tue, 30 Apr 2024 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbf-0006ko-Bi
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:15 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbd-0001p0-JD
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:11 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51aa6a8e49aso6917402e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480147; x=1715084947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09Seekt4NtHu4QpViHBSYG/Y3RTFIcJPKW9xHjJqbt8=;
 b=RaQ7rHdAnNdsbVjSgEanIOGzX9YdcBoV8LGnHVlTqPdaHJwacl5Y80zICatFFssadQ
 /xynp7KrgT5daA+BaTEjCQxjZrTRgni74waTwqpcAD6hh3tYEDU/HPmqIiqzglnQBhju
 88l/ZuxUqK3BhohFkjS8RX01v64mgJTFZgsb6lyR2+76fLnT+cVTsEw8qQDzVTqm4UEi
 qOAQhSZyIIOSCEMrLUtPGzPxzoXy2qMjr6HLs3jXKV/ZJ+lrLgc36fg3ulDfZryRb9SL
 m64G77DvvEKqFf0avGKUSQbtc1OwEVdO1aI+g7LoGR2mfig11gENDSrRbqz+EImFn97E
 ji+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480147; x=1715084947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09Seekt4NtHu4QpViHBSYG/Y3RTFIcJPKW9xHjJqbt8=;
 b=n3+41sRw+KEo4VfZKik+Q04PCQyji9C8REX9LRBWmEcSQsr0k83v5ubzn50CRWjJsR
 g4U+WRxImm3C9Lx7lGzcc1aTMTPYnQvXRSnmF2YvSSX8HXphik1GpXzje5tVGupBsBOU
 Xyk2/CJ/5RI7n5Yn7nhWM/iALfX2psqjlYmUmn2FoMM4XvWBaoxkphq5IQQLk7fPu7tn
 yhkoVhOi8CvfLQ326qzhfq+zRpwjHv/6FdVlfnF0Bg9fN05opkUp1lz3jWxgEmsE1yK3
 DOIIJbaKvx9z8ufd8wjOaBRViZRfqz36h/r6l0xTzb8IOvftarzsulfs4/XC1w24IJLf
 oI1w==
X-Gm-Message-State: AOJu0YyxwWtEG1v/DAgQ9qihO58yZmrOEIG/mzXYiFVGk1VAzjpA/IO0
 Uc+eTTr/50U2rS+R29+ePzIk848HfnCLdU8hezFA66XLBIZIlAGPzdIGHEETYa98AvwNpn1QAOf
 4
X-Google-Smtp-Source: AGHT+IGTnXcAZsDup7XOQOMcHugY6PXJAk9K0b61r23h354XMXEThiF9ck7ycCpIsi7HtLFNXG8cBw==
X-Received: by 2002:ac2:4542:0:b0:51c:66eb:8a66 with SMTP id
 j2-20020ac24542000000b0051c66eb8a66mr7387954lfm.67.1714480146743; 
 Tue, 30 Apr 2024 05:29:06 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 er1-20020a170907738100b00a58bf5ebc68sm5907046ejc.146.2024.04.30.05.29.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:29:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/13] accel/tcg: Move @tcg_cflags from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:28:04 +0200
Message-ID: <20240430122808.72025-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

@tcg_cflags is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-23-philmd@linaro.org>
---
 accel/tcg/vcpu-state.h | 2 ++
 include/hw/core/cpu.h  | 4 +---
 accel/tcg/cpu-exec.c   | 6 +++---
 linux-user/main.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 51e54ca535..008fe847b4 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -10,9 +10,11 @@
 
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
+ * @cflags: Pre-computed cflags for this cpu.
  * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
+    uint32_t cflags;
     uint32_t cflags_next_tb;
 
     sigjmp_buf jmp_env;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f3cbb944eb..e546e67f4d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -394,9 +394,8 @@ struct qemu_work_item;
  *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it will
  *   be the same as the cluster-id property of the CPU object's TYPE_CPU_CLUSTER
  *   QOM parent.
- *   Under TCG this value is propagated to @tcg_cflags.
+ *   Under TCG this value is propagated to @accel->cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
- * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
@@ -517,7 +516,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t tcg_cflags;
     uint32_t halted;
     int32_t exception_index;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2edfad78b3..2af0e964c1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -150,17 +150,17 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 {
-    return cpu->tcg_cflags & flags;
+    return cpu->accel->cflags & flags;
 }
 
 void tcg_cflags_set(CPUState *cpu, uint32_t flags)
 {
-    cpu->tcg_cflags |= flags;
+    cpu->accel->cflags |= flags;
 }
 
 uint32_t curr_cflags(CPUState *cpu)
 {
-    uint32_t cflags = cpu->tcg_cflags;
+    uint32_t cflags = cpu->accel->cflags;
 
     /*
      * Record gdb single-step.  We should be exiting the TB by raising
diff --git a/linux-user/main.c b/linux-user/main.c
index 5f7f03f4b0..8be06627da 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -241,7 +241,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
 
-    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    new_cpu->accel->cflags = cpu->accel->cflags;
     memcpy(new_env, env, sizeof(CPUArchState));
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
     new_env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
-- 
2.41.0


