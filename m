Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1295C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUq-000632-0k; Fri, 26 Apr 2024 15:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUS-0003HK-9Y
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUO-0003SY-Nu
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:11 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57225322312so3651116a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160646; x=1714765446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi4qzwVEIokTDVOXJGX3UXAbAGnKr2+Pju6ZmUzQWug=;
 b=JlxMWkm6oUDxpEPsHc/9FkGba94rEFG08N4HJV7mUv1m0yeOHoU2DJoDRS0OEo4Wca
 vzahnq5869oMVyWsFAMN88xBj0rMt8hnyO6UanWMpWZLtDHue7x5ubhg3EHfrYjW4DxP
 Uwa94TyVsLWQkCLPJpxYPsilBxmBNF7Q0FHir+wudK56esIlPMwjhCenbwE4PRUYoeWm
 jIiYXrSdLzFMbx/OYF4oQQ+3+s3QBfesDzSjCHT3B3JRf2TS5JUVgVS2642G89mloArV
 99D9M5jxbDbBSSnFKMp0kjjJ0t78/xhjIMiO2D2SJJIrI3QMQDeIwcr5wwbp2IVNEU0l
 cP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160646; x=1714765446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi4qzwVEIokTDVOXJGX3UXAbAGnKr2+Pju6ZmUzQWug=;
 b=NEbvCJ8PRSzwsWNASVcxubew6WXjlAfX9N7K4ol7/ySDCYpC9CTP7iQGCLkhm2pZ8R
 GH65nWf9F/mxsW1uPzap81faa1hqSHhPP2rIgLLwABQbI3bAvGyo1d8/qoXDF233fS2r
 ve4ZbMdKv97yj5VpiHVCQRUN0XS4hvd82LKrdQg8CVhA4gGsbg/zXCo8Ntthrz9TTVtV
 N7BA7/wf6PS8QceURzKzwgnMs0xQDZcfQKhh7tsYdUqldawSjFYD4mhoPW9g6atFxHAM
 pQMpYP6OvQishojaC58SbpBNW8wIGPcJeXbcZVqiD7zdwUHGN1yIoLBkJoZXSHTWA3xB
 83gw==
X-Gm-Message-State: AOJu0YwXGUFZxQM4d9b/gNrl99RyqVO9JIwb0OCvdpWn2UuwyPLCZ22w
 1hZUpPXb2VjoDydYBxkzOVq8wjT0Tu1bqejYhqcWrJhnDllvw9tDQPxqV+8oW9NM8MZOiAVrwyF
 ZRnM=
X-Google-Smtp-Source: AGHT+IFXMGCYbRnNfazAzNLEZBwThw+jXzRFYB0Gm2woHPKm9YaOPwh/RhTlp5jRRRkn11wGYFVPfA==
X-Received: by 2002:a50:8d42:0:b0:56e:2e10:7dad with SMTP id
 t2-20020a508d42000000b0056e2e107dadmr2804865edt.35.1714160645819; 
 Fri, 26 Apr 2024 12:44:05 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 bf17-20020a0564021a5100b0056bf6287f32sm10263342edb.26.2024.04.26.12.44.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:44:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PULL 21/38] accel/nvmm: Use accel-specific per-vcpu @dirty field
Date: Fri, 26 Apr 2024 21:41:41 +0200
Message-ID: <20240426194200.43723-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

NVMM has a specific use of the CPUState::vcpu_dirty field
(CPUState::vcpu_dirty is not used by common code).
To make this field accel-specific, add and use a new
@dirty variable in the AccelCPUState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424174506.326-3-philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 49a3a3b916..f9cced53b3 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -30,6 +30,7 @@ struct AccelCPUState {
     struct nvmm_vcpu vcpu;
     uint8_t tpr;
     bool stop;
+    bool dirty;
 
     /* Window-exiting for INTs/NMIs. */
     bool int_window_exit;
@@ -507,7 +508,7 @@ nvmm_io_callback(struct nvmm_io *io)
     }
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->vcpu_dirty = false;
+    current_cpu->accel->dirty = false;
 }
 
 static void
@@ -516,7 +517,7 @@ nvmm_mem_callback(struct nvmm_mem *mem)
     cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->vcpu_dirty = false;
+    current_cpu->accel->dirty = false;
 }
 
 static struct nvmm_assist_callbacks nvmm_callbacks = {
@@ -726,9 +727,9 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Inner VCPU loop.
      */
     do {
-        if (cpu->vcpu_dirty) {
+        if (cpu->accel->dirty) {
             nvmm_set_registers(cpu);
-            cpu->vcpu_dirty = false;
+            cpu->accel->dirty = false;
         }
 
         if (qcpu->stop) {
@@ -826,32 +827,32 @@ static void
 do_nvmm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_get_registers(cpu);
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->vcpu_dirty = false;
+    cpu->accel->dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->vcpu_dirty = false;
+    cpu->accel->dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
 }
 
 void nvmm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         run_on_cpu(cpu, do_nvmm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -981,7 +982,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.41.0


