Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzggn-0005az-Vl; Wed, 24 Apr 2024 13:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggO-0005Kl-Kg
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggL-0005b4-P3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34a3e0b31e6so51111f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980720; x=1714585520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHy7p+TsVd61UoOXNyWftQk9Qj6gD334eWPgXT4ErEE=;
 b=HzZaFJIMOFG6+ofWC9QiH/vzu/10Ps+a4kASdk0uZMLuZ7Pvwf0m5OoMyW3kZ0n5GO
 6AALIpb9dt50F+6mf4JohS7zgjsZJthKxZ3kOai4WuR2dCCFtlcviXE+QxgyMcYMfz6s
 i2T4g/5iOJvE1m7h3+gSFVLTYx/jVUjqhL+Q8qIcY/B0Kwb9UnQCpbHKqgUSjzmVfcfO
 F5KNwAI25eyk0q+e0UEfNciL6s6N8qTipZbD7lGQ9GrFCUsLW0bVqUmWxRPkTji8jiGP
 clA2hQjSVeA8jdNbIHcQkTHFzeK9+HwLNBqhg9IVdq7jwdttVSl+UF+XJ6KXucAwyhme
 Kobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980720; x=1714585520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHy7p+TsVd61UoOXNyWftQk9Qj6gD334eWPgXT4ErEE=;
 b=hEGT/hN+ycXTgfTT3daeH9yXUVTyJ01jpbj8bGLvgyop0N6Twcf/aCvwYADzXjzwEt
 O9ETpc18QMQ479bh5P+gP7m/AlrojpIxgASROxmU4GAAxBfxKcl5jgBkLtk2lL84oSmP
 qgRn+Yq8qWyCDVQOUwSIYTmIMkIkireWA0PH8lc86IuYJOelOE0P8TmwjhyyfmNOOkre
 1DM+x4Xrb9HTbtG0J8rdgLXtPpkJPcXhPGT5W+pfsUDYBCUPd4+7spJbE9WCfRRFcDqW
 H+LFxaJen18d9vU6IMdNjzWFLRMVmxBsxY4tKCxybs66MKQHl2GzqDkaqC9U+rl+ywLN
 aFHw==
X-Gm-Message-State: AOJu0YzloicMVn7J+zb4U0rWefSt2hxnsNdgy9wAjZmeKTIFI0V5hXaN
 1OK4TjDI4/E4gW2saNxf14+YtW4gVV9HjscKoQBaTS3BfRxa9A/zDMGs5i43lHEzzaJncmabhmV
 O
X-Google-Smtp-Source: AGHT+IFXdqsLeS5txq4m6Qf0oKCg8dTzSoaUPErGDxhMtMmoE3VoGbbLRRFC3N+vK/AJHUZeD6kNfw==
X-Received: by 2002:adf:ea8c:0:b0:34a:9adc:c37a with SMTP id
 s12-20020adfea8c000000b0034a9adcc37amr1924659wrm.10.1713980719950; 
 Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adfe00f000000b0034b03d0b94csm9059925wrh.74.2024.04.24.10.45.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:45:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] accel/nvmm: Use accel-specific per-vcpu @dirty field
Date: Wed, 24 Apr 2024 19:45:05 +0200
Message-ID: <20240424174506.326-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424174506.326-1-philmd@linaro.org>
References: <20240424174506.326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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


