Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD128C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObF-0000r8-QJ; Fri, 09 Feb 2024 05:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObD-0000nH-KC
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:15 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOb7-0000Fn-QL
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:14 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bba50cd318so550790b6e.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476348; x=1708081148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAASVfXWzsZJGSdrwiSLmP/Nh82xOuYUIlfw1ZDx9+k=;
 b=d0Z+ar2DvRjhaKO7jHqnBRg0eflNih5sJHkAuPLJm0/bdzuxa0euR3HTfNY+Zeld+9
 lBX4zir2j1axAaIH9FNk1+ib7MKIVOZ2cbmMSlAV2Z4rjS1mCdHYAah0ZG8/WU6ntgdG
 emWZ5cG6SEsHuHIAme3AShZ5nYdPz42BbYP7zKCAhnrBxxQTBrLy3xkOTjDXEaZ4NobZ
 GTniqtFQ7jptAQz8VlR7GHSK4CHAtaPXwh8Kcuci0HiaraDsHf6PuHjYsfclqigv6wRs
 1GeOVf4l1BJ5RUpYH4v3dSW6VvPIhZ6nioEU1e2IDuYWLRXY27lc5d+rgvBJFf/OMD3r
 dIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476348; x=1708081148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAASVfXWzsZJGSdrwiSLmP/Nh82xOuYUIlfw1ZDx9+k=;
 b=ugf7YR+ePtM3JFuGza9U0ogLoLeZvMX2HaZFWtET6ErOJajNkpO+ZCZ1+vqYaavVFw
 PPtILMBZqeiQDIV9lJeL6jCRgFbwoWmRWKfl0/69031dWSsKsJGbO7ciCELoCtZ0TdqT
 iVDBnqI1binwY0emoUSreVOXRsoDSVlnqS8vD9ZhkLvXKxOmnLKLaNsb5HyylObeiz5K
 /QgRqUN2ntGaQT6+O+KP8U+MnyxZ2zb7cMywA+jBPh+ze6B843DalDsbySDRTBdj+0od
 5H0CnRo7yXjlkIAHvAzWA5fnsPvRwY229ofcQfQI7qwwfxoBZQjskPO6aEcwS8wDCb8P
 Vltg==
X-Gm-Message-State: AOJu0YylQ/VoOWX9mgcB5iO3up4lx903r+xww+yehSq26oTgKsxUy9lL
 emHqBHtxuWAKVYeTclFUENSb2ixB4rhOKEm2qNOekCOQmsLa9/PB2DQ4/WUJp8BNsw==
X-Google-Smtp-Source: AGHT+IGVEm8vA9ZZeM5f5eNXHD8gFvUIHwJShaV7jI9bpuVH/gJ34j+TzYPkD5fuaPkBVW6GKmj0Bg==
X-Received: by 2002:a05:6808:13d4:b0:3bf:ef18:13d9 with SMTP id
 d20-20020a05680813d400b003bfef1813d9mr1525990oiw.10.1707476348392; 
 Fri, 09 Feb 2024 02:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUv6D23mR/gMEMWdR+NRrRjAYDmkSqgkrKz9VI5qJpwxQCtLB314tfMGhThhTNI8tbXh//mUmm/xYu6zxCq//NODu0dFTGItcw0NmCqEwZte5DSTFnoMdk5YUkQWS6XlImbFFQ=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/61] target/riscv: create finalize_features() for KVM
Date: Fri,  9 Feb 2024 20:57:25 +1000
Message-ID: <20240209105813.3590056-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

To turn cbom_blocksize and cboz_blocksize into class properties we need
KVM specific changes.

KVM is creating its own version of these options with a customized
setter() that prevents users from picking an invalid value during init()
time. This comes at the cost of duplicating each option that KVM
supports. This will keep happening for each new shared option KVM
implements in the future.

We can avoid that by using the same property TCG uses and adding
specific KVM handling during finalize() time, like TCG already does with
riscv_tcg_cpu_finalize_features(). To do that, the common CPU property
offers a way of knowing if an option was user set or not, sparing us
from doing unneeded syscalls.

riscv_kvm_cpu_finalize_features() is then created using the same
KVMScratch CPU we already use during init() time, since finalize() time
is still too early to use the official KVM CPU for it. cbom_blocksize
and cboz_blocksize are then handled during finalize() in the same way
they're handled by their KVM specific setter.

With this change we can proceed with the blocksize changes in the common
code without breaking the KVM driver.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/kvm/kvm_riscv.h |  1 +
 target/riscv/cpu.c           | 16 +++++++---
 target/riscv/kvm/kvm-cpu.c   | 59 ++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2a5e67c141..3e342a5ae5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -510,6 +510,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
+bool riscv_cpu_option_set(const char *optname);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 8329cfab82..4bd98fddc7 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -27,5 +27,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1d4b2b1544..3703efe702 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -68,6 +68,11 @@ static void cpu_option_add_user_setting(const char *optname, uint32_t value)
                         GUINT_TO_POINTER(value));
 }
 
+bool riscv_cpu_option_set(const char *optname)
+{
+    return g_hash_table_contains(general_user_opts, optname);
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -1114,17 +1119,18 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 #endif
 
-    /*
-     * KVM accel does not have a specialized finalize()
-     * callback because its extensions are validated
-     * in the get()/set() callbacks of each property.
-     */
     if (tcg_enabled()) {
         riscv_tcg_cpu_finalize_features(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (kvm_enabled()) {
+        riscv_kvm_cpu_finalize_features(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 680a729cd8..dc0466df69 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1598,6 +1598,65 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
    return true;
 }
 
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    KVMScratchCPU kvmcpu;
+    struct kvm_one_reg reg;
+    uint64_t val;
+    int ret;
+
+    /* short-circuit without spinning the scratch CPU */
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz) {
+        return;
+    }
+
+    if (!kvm_riscv_create_scratch_vcpu(&kvmcpu)) {
+        error_setg(errp, "Unable to create scratch KVM cpu");
+        return;
+    }
+
+    if (cpu->cfg.ext_zicbom &&
+        riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
+
+        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+                                        kvm_cbom_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read cbom_blocksize, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.cbom_blocksize != val) {
+            error_setg(errp, "Unable to set cbom_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
+    if (cpu->cfg.ext_zicboz &&
+        riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
+
+        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+                                        kvm_cboz_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read cboz_blocksize, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.cboz_blocksize != val) {
+            error_setg(errp, "Unable to set cboz_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
+    kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
+}
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-- 
2.43.0


