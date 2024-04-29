Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B54C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ybb-0008E4-T4; Mon, 29 Apr 2024 17:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbL-0007oB-45
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbI-0003N3-Th
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ebso24100145e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426311; x=1715031111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RalDqVPJ3rLs2jYwmC3Tt03XCZdQnhUJqO3vFzpn9o4=;
 b=U8r1Gt1nKqdxzgfdcCKq+VLyqkp9yD8fqSlvOBCBOjsHUM9PJ0ROmvJ8+LhAwAexbE
 m4stLI8J6dfPOOK/mbFF7IhGyREhMq2PiMduWYJ3rLAzRdnkhUMRronLhY0MklL+BaFv
 b9uY395zCRMStyjyXaYIhdcbAObdAJkNFQnZnmsEqkvketG/ITzWosYzt0wS6oJTlSfw
 Qyu43HheE5u1xDsrqWsw1HsgpgmvVa9ADSgo2lRtckDz1/4g8Y6mqdYskHRKJaO1i3Lk
 hu0sk7FlKiPwaqfJ2xnqi26+hgpx9P/FoLsbTl/0GbSAKjaWxtKmsNVG4YiyZs4jmHRD
 8AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426311; x=1715031111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RalDqVPJ3rLs2jYwmC3Tt03XCZdQnhUJqO3vFzpn9o4=;
 b=GSrviS5RrgCowH0IVKMSa5+38mRQtI1liFRK45T15Ppa3L3rA3VkISqMCvTN9n4PJ1
 ipicDYvlkDb3i8yyC+IoiBaLAl8DUuucTD9ixfvtbxsjrGb1AFwwG4weIM40ZC3nf9lX
 T4r5/0oT06g3734tcDRsO4kBw577hk/2N7jYSUthr7gp82+O+f9kXnNDgccClp/l4D2r
 BHTUFHUISmG1AGcvl6Ry3uj+c9PziwXm0J8wdG0Obc3yT0olzayUai9zu+cSi7poszPU
 YJq9TW3GOUvI6q9Yu+vHf2OsxfnA4WkZwEhxhABUY4sFdsVO1tKUTNrqk4DewTsnB9At
 TWEw==
X-Gm-Message-State: AOJu0YyEbR9DLXlGaAVXJ5+28yHFz2O6CZWxrvv2BWcRDneNXKlo4Qnc
 777cKJgarOrB/ur2WbBY+jEmxcXqF9Fwoh4YGQIJD0Ty+9MpCJakVLmc/SbV8hzmi2YPqp9B639
 NSD4=
X-Google-Smtp-Source: AGHT+IH5igrkr78z5cS2s+aJfV6/vtNImjqovSUZnwC3o5wZIJ1pUhhkfrdW4Ld2FGZdT00TY/77GQ==
X-Received: by 2002:a05:600c:3b8c:b0:41b:143b:5c2d with SMTP id
 n12-20020a05600c3b8c00b0041b143b5c2dmr7885753wms.28.1714426311015; 
 Mon, 29 Apr 2024 14:31:51 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b00419f572671dsm34316236wms.20.2024.04.29.14.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/13] accel/tcg: Move @tcg_cflags from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 23:30:48 +0200
Message-ID: <20240429213050.55177-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index 0cb58ba734..6c12bd17df 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -11,9 +11,11 @@
 
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
index 6e6e946b66..14e96aae85 100644
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
@@ -515,7 +514,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t tcg_cflags;
     uint32_t halted;
     int32_t exception_index;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8f8e1fa948..84fd041aec 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -149,17 +149,17 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 
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


