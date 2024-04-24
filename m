Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90186C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzggt-0005lC-0p; Wed, 24 Apr 2024 13:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggT-0005Nu-Es
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggR-0005c3-Jr
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b31e2788aso815215e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980725; x=1714585525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1vG3j9SklDspIE1oKgdKXBwljECYteot2YkVWDa25w=;
 b=hDzKW/7IPUHiYbbr6SUp5RbE5KuB8q41m8XT8fgDeOj/OUPrzpl14OCxE0yEuxQjkk
 xtvmklVVxZjgQKkz5MUrxdl7yAM0EmaTiXdZNDx8cMj4Jxgfp+cXjZ9QX5xDNCCOaIoG
 GhhHKIakivf/RHw6AYHweKNYTFSe+jjK8jdXqt6AzKo+1BILHQJna3gcBIDZY1mpMGju
 EGmzoytPBl/1YllW8OmXrEW6JgWb9wFBgpfbSu0dx4DK50oR6sjEzd0/2K8ZBruxVTFJ
 muVsO76ll1HB0d8z2TZql2A3cwQUthlY+EzdAdruztJ+BfqA61qYbmIY8XkFfOkv73vP
 DN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980725; x=1714585525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1vG3j9SklDspIE1oKgdKXBwljECYteot2YkVWDa25w=;
 b=blImnqfXW502zuIqZoaXRz/c1DB11EEcloOMNerSrWPyq9ehaA/KQgtZVcUugZIFeb
 9QJv3I+8iSq3Ghv/LM3m6k1udoUED2nkJRQn3/KAoAU3AFVfI/aE1NcuE+usU00JuMr9
 niLhrscwhJhL8RvWDciTVNJgfqoAQruMMVxPg2/v3Hc1F1yl7pkFXkDTjhZf3OZ+rEzM
 1puEHBPpUf2aDnzOoXjTdO4GZUAqabxGfHprM22qopSS6ky8PbvpFDml4fxV63OKLBWh
 Nwe828Bkvol5kxeuKgK012nuf7zIbuV6nirKcsOkyZ07FEqbn72pfYY38nUTMHa7we+N
 5r7w==
X-Gm-Message-State: AOJu0Yz/O42+pO7jK5a0LJG+/EVLJ5+arAOshXfIV4i/hXxOKD8/OvxK
 letx6J167o0J2i8+3GZRDRyFYAEJuPxaQkgcOl214LS4cfO/eLTTPvYyfgKCWxjZ7tkddOfxaTi
 G
X-Google-Smtp-Source: AGHT+IFwFZBgIqpBtwRcAs6x3R/veLvvhrVMlizTnST30aKgnh0+nHaLcGPigRjInrmLgboRFJ58xw==
X-Received: by 2002:a05:6000:1e8d:b0:346:b778:eaa7 with SMTP id
 dd13-20020a0560001e8d00b00346b778eaa7mr1923315wrb.18.1713980725528; 
 Wed, 24 Apr 2024 10:45:25 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 a3-20020adffb83000000b0034b32e5e9ccsm7253936wrr.64.2024.04.24.10.45.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:45:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 3/3] accel/hvf: Use accel-specific per-vcpu @dirty field
Date: Wed, 24 Apr 2024 19:45:06 +0200
Message-ID: <20240424174506.326-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424174506.326-1-philmd@linaro.org>
References: <20240424174506.326-1-philmd@linaro.org>
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

HVF has a specific use of the CPUState::vcpu_dirty field
(CPUState::vcpu_dirty is not used by common code).
To make this field accel-specific, add and use a new
@dirty variable in the AccelCPUState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h     |  3 +--
 include/sysemu/hvf_int.h  |  1 +
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6f5a16e0fc..46b99a7ea5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -505,6 +505,7 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
+    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -526,8 +527,6 @@ struct CPUState {
     int32_t exception_index;
 
     AccelCPUState *accel;
-    /* shared by kvm and hvf */
-    bool vcpu_dirty;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
      * autoconverge
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 718beddcdd..4a327fd526 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -55,6 +55,7 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
+    bool dirty;
 };
 
 void assert_hvf_ok(hv_return_t ret);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d94d41ab6d..40d4187d9d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -204,15 +204,15 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         hvf_get_registers(cpu);
-        cpu->vcpu_dirty = true;
+        cpu->accel->dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -221,7 +221,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -402,7 +402,7 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->vcpu_dirty = 1;
+    cpu->accel->dirty = true;
     assert_hvf_ok(r);
 
     cpu->accel->guest_debug_enabled = false;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 65a5601804..db628c1cba 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -806,9 +806,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->vcpu_dirty) {
+    if (cpu->accel->dirty) {
         hvf_put_registers(cpu);
-        cpu->vcpu_dirty = false;
+        cpu->accel->dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1ed8ed5154..e493452acb 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -419,9 +419,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->vcpu_dirty) {
+        if (cpu->accel->dirty) {
             hvf_put_registers(cpu);
-            cpu->vcpu_dirty = false;
+            cpu->accel->dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index be2c46246e..1569f860eb 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->vcpu_dirty) {
+    if (!cs->accel->dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.41.0


