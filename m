Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EC0CC6B20
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqM-0004xu-Dz; Tue, 13 Oct 2026 23:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqJ-0004wK-8W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqH-0001Ns-A8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:50 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3a4cdc9025bso1886552a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949188; x=1792553988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ae/F+1F479Gr7OFX9NWEPgT7rC5OzvDZ2GzLfQE5Bs8=;
 b=ZiuHn4Bv+HSXy0WlbJnuoUHztB8LO0AluNSsI1oOSw3lOr4Rui9kfbTDY7z/2TUdVh
 v4B07gPD/NH0FhBTkV/Uv+rXEJCoZVP3gSP9c0Ag3/2gzQa5p5BfKzJVn1aEL0fn1gSP
 MhRM8FuLicTF70CKvMAiGS/26Y7vbmaQrphfuRtg6t8GkMTcKvxjpQGqvKKDsRmoTtgT
 nfJsNrW86EJBvlbqakSPgAwXtsXiTe/+AJ0n2ILxj7G5jhakddTSAvfjH3lTml97MOck
 WUcIG3hvUtMm8kCvTxjocU82mfOyQGqExHB1bLgnBtUDllEnXT/S0/HhjiwyU5f64J+m
 fg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949188; x=1792553988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ae/F+1F479Gr7OFX9NWEPgT7rC5OzvDZ2GzLfQE5Bs8=;
 b=Fd9ZIwf+yUx3NgHd/BbuLoWhhRoTUW5dynItCuDnsgY9GJmNNtpOrPz6BpWhvXqaxO
 jygVmmKJFcQFPT3BrbZb3vYLOGE1wOXbW3Sc0TVgMGoz6dUBGhSBpnZ5C/YOBpsadTea
 tqH19mqn63X4Px+FADxrhkCf+39jA5xkP8Iqm8saGzfC7ja2KBu1plB0zEOtcOytAjx2
 OIM5GeHd68rWSRPmfzKj0awGPil5Se2VyvuAIrgPAAttDfwjhDZEQ8mn3v0WnluIoRRD
 c/CDfE6mcjH3F1wwgSHpSrDmj0gNeldst5Axd6SbpjG7EJITdEeFoe208rT4rgFio9st
 LSxw==
X-Gm-Message-State: AFq9FYJIWKn8G/9VRSbcP2ZOVHhZCaz2T8NA0zWTu55lgzS4bYcVU69g
 SEesK5d3p9clB/DC7CujSOcbX6XdZhl54MMs6qi4pi6kq7IjEesQzbqRCCOmfw==
X-Gm-Gg: AYBFou1K05qHzhaZROgGgVRMyA6kC2ysHx8r2IPnEGpy9q11LQBb3DJnWzBd/eMQEf0
 KcfogGIi3dySVf66KWnF9X5wK+R90Jas5PxSnWecC5YgJ2HWVt571fNtr2WclIsF8p9Serntx7r
 I7d7Ek+CSVmpHrsVFD7DWCdQ/DfUo2drFroRgiaVtI9X1jbXSKpOY3aIWxmnh1RLH5SygR0j2Sg
 OZIcWFJ8lQjF/3u6yvn4gPlVPtErBItrg4t1EwKax/hL3Jfy3aPjx/Z4IsgD3kERFOJX+qFoOsd
 9VWRw7y0QnARixPMbZIuNpz9+Q3h33htl6kb3XQqyQOc2j9n85TFXaooBhVYLLD/Ih0ze3JtXZl
 LNqKn9ZPogdj0RLxO6zIzo0m3bMVkxkdl+R8eVrnAXyn6uhlT+gbyEfIYB5pkH2YMVaMadTMxNs
 A6Xz/JTWwG93oa4MVZ6MnrCOjwHg9jcJiEH8B6aeJR6D6QKnN4t9So5v1sXlIOTv66UDUydo4hL
 SOghXgRyp2ivFBKFQ==
X-Received: by 2002:a17:90a:51a7:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3ab58327370mr8177290a91.32.1791949187749; 
 Tue, 13 Oct 2026 20:39:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/52] target/riscv/kvm: Reject migration with a different
 timer frequency
Date: Wed, 14 Oct 2026 13:38:23 +1000
Message-ID: <20261014033907.3332383-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Xie Bo <xb@ultrarisc.com>

The timer frequency check is currently in kvm_riscv_put_regs_timer()
and guarded by migration_is_running().  That condition is false on the
incoming side, and the source frequency is not part of the migration
stream, so migration between hosts with different frequencies completes.

Add the source frequency to a KVM-only subsection.  Its post_load checks
the destination frequency before the timer registers are restored and
rejects a mismatch.  When loading an older stream without the subsection,
skip the check and retain the old behavior.

Fixes: 27abe66f31ef ("target/riscv: Add kvm_riscv_get/put_regs_timer")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-3-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/kvm/kvm_riscv.h |  1 +
 target/riscv/kvm/kvm-cpu.c   | 40 +++++++++++++++++++++++-------------
 target/riscv/machine.c       | 31 ++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 25f8ec00a9..5489c564ae 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -544,6 +544,7 @@ struct CPUArchState {
     uint64_t kvm_timer_compare;
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
+    bool kvm_timer_frequency_loaded;
 
     /* KVM multiprocessor state */
     uint32_t kvm_mp_state;
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 61eaa12443..0e27ce8bf3 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -29,6 +29,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 bool kvm_riscv_has_mp_state(void);
+int kvm_riscv_check_timer_frequency(RISCVCPU *cpu);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c8ccd9124e..1993bd446b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -45,7 +45,6 @@
 #include "kvm_riscv.h"
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
-#include "migration/misc.h"
 #include "system/runstate.h"
 #include "hw/riscv/numa.h"
 
@@ -822,9 +821,34 @@ static void kvm_riscv_get_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = true;
 }
 
+int kvm_riscv_check_timer_frequency(RISCVCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    CPURISCVState *env = &cpu->env;
+    int ret;
+    uint64_t frequency;
+
+    if (!env->kvm_timer_frequency_loaded) {
+        return 0;
+    }
+
+    ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(frequency), &frequency);
+    if (ret) {
+        return ret;
+    }
+
+    if (frequency != env->kvm_timer_frequency) {
+        error_report("KVM timer frequency mismatch: source %" PRIu64
+                     " Hz, destination %" PRIu64 " Hz",
+                     env->kvm_timer_frequency, frequency);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void kvm_riscv_put_regs_timer(CPUState *cs)
 {
-    uint64_t reg;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     if (!env->kvm_timer_dirty) {
@@ -844,18 +868,6 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
         KVM_RISCV_SET_TIMER(cs, state, env->kvm_timer_state);
     }
 
-    /*
-     * For now, migration will not work between Hosts with different timer
-     * frequency. Therefore, we should check whether they are the same here
-     * during the migration.
-     */
-    if (migration_is_running()) {
-        KVM_RISCV_GET_TIMER(cs, frequency, reg);
-        if (reg != env->kvm_timer_frequency) {
-            error_report("Dst Hosts timer frequency != Src Hosts");
-        }
-    }
-
     env->kvm_timer_dirty = false;
 }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 3238912b63..ed10e65259 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -197,6 +197,35 @@ static const VMStateDescription vmstate_rv128 = {
 };
 
 #ifdef CONFIG_KVM
+static bool kvm_timer_frequency_needed(void *opaque)
+{
+    return kvm_enabled();
+}
+
+static int kvm_timer_frequency_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+
+    if (!kvm_enabled()) {
+        return -ENOTSUP;
+    }
+
+    cpu->env.kvm_timer_frequency_loaded = true;
+    return kvm_riscv_check_timer_frequency(cpu);
+}
+
+static const VMStateDescription vmstate_kvm_timer_frequency = {
+    .name = "cpu/kvm-timer-frequency",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_timer_frequency_needed,
+    .post_load = kvm_timer_frequency_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.kvm_timer_frequency, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool kvm_fcsr_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -255,6 +284,7 @@ static int riscv_cpu_kvm_pre_load(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
+    cpu->env.kvm_timer_frequency_loaded = false;
     cpu->env.kvm_mp_state_loaded = false;
     return 0;
 }
@@ -591,6 +621,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_rv128,
 #ifdef CONFIG_KVM
         &vmstate_kvm_fcsr,
+        &vmstate_kvm_timer_frequency,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.55.0


