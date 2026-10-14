Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F4BCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqK-0004ws-O7; Tue, 13 Oct 2026 23:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqF-0004ti-Lo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqE-0001NT-13
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:47 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so2730196a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949184; x=1792553984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Se/8NwHIL/oM2z+UeIiSfMT2la1VTJrbxJq6EnwflRc=;
 b=lbR0rtAV66wyexDhr8H3iucFa6OAJLHRegah+A/8suSYgTjCqvQV8Z5XRxZ9M+0Uti
 +El0vwJxtiW8QXxm7V/KLs8DxXHy+Zh7hDE5Pb0fjAl63yfTMmhm3+ToB/lTv6Y+bVMg
 TgaZx543cu/CqaIDu2iQ8s4wI7ay8r2Ozp5Jo2m+5Yq5oiPYEOdLAiepQyswtDScnynv
 qq2783MGJYXo9LnFeLpZUCd2Z75GQPYWU+XYPjX5inOYdpQQIYH4oenDkUOf4nd6h0Ql
 giiRr526x99pE8k9nbyC/ek1Bk/epc6zKnI/RBNgM+GR1NvmMoj5+MJTckBvsJQIQIeL
 SMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949184; x=1792553984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Se/8NwHIL/oM2z+UeIiSfMT2la1VTJrbxJq6EnwflRc=;
 b=2MZuBH3HoiycFcpVyXAoezDcQbv2qg+EH5ZggJyByf1pXsEFk/3ujM6BEaHM/Ks0ot
 7ZUNqkobqPD9pCu8KXJwuWQd5iU8Ux2l7E02w+9m6Oz4MHkxrvonsjlWeZsujxcEPWsh
 S98Fs3XMoisbvUsSxaNNFfcAmSjeB9NZl9/R4LRqE91hlqtLCAgYAp1+19HuZuUVbLCt
 lvpVVqFyhSXwh1xWdN670hf7s6ZL+nK2wOzVlRx0sMRiOlVeR7EdEePXH90TWfGt8H6M
 gj72aKtDZWHzNoWFZiH1fSq9NKyQGnN3OhdtON/PJvvJOo3UkC9i5xU+Syzt2f9KFthC
 mi6A==
X-Gm-Message-State: AFq9FYKt73kcDFhBBYo/6uXAxqdp9w7OMRk1yYrTFF3O5VXmNA60cBUA
 lXuZ9oRWiMDfyVseZjIieyKHag2pZLbGOHG4JL3sTkoc/6k9OieqHPN707a4qw==
X-Gm-Gg: AYBFou0PMYeI6TNhNI5nmz4xyW8O4Ef1qenZn3L8uzm5FOFJ3Q5+zdDH18obirhG4XW
 0QNI2VDu0OMIXJFV2jL+a+e+gYE9qaJhSy19XUIU/TdQB1P7m5yV7683bfGaLgZACDToHrY24Nr
 HhHCBz86UJlcIbuER7/yYGqDipXRgfjayyuuav+CWyWS6scxqOVvcbrl8iCujiGsfhzSV10vlnw
 o2AtmcnA7HqYium+twUHus8B4rdr+jHgL7Z1YqppZn0NG5NyjK/h7DuK0YReC11YhKiYRWgTf07
 OdwrM+YvehDQKy7X7ZSMaP3Qvb5hCGBuH0SNni6pIHVbGz0L5BrGzNeEMmvaSzb3FxwKhjyTy6N
 ZdUVwfojW1wHP2P/dJOe2RJkXN5n2nhPz46vTxOp5OsMfKpaF4RxdnK3F17ePXj7t2/sNt38JM7
 huElYaQKqkJVWhj3ARNfHg/BS/APF4c8SFEV5GrDRN3FiTQRL6y9rksSTiOrsBIv6e0qQM+RW0R
 h+NCKje6X7dSBbY
X-Received: by 2002:a17:90a:642:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3ab3a953616mr5425689a91.8.1791949184526; 
 Tue, 13 Oct 2026 20:39:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/52] target/riscv/kvm: Preserve FCSR across migration
Date: Wed, 14 Oct 2026 13:38:22 +1000
Message-ID: <20261014033907.3332383-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

kvm_riscv_get_regs_fp() and kvm_riscv_put_regs_fp() handle f0-f31
but not FCSR.  KVM exposes FCSR as a separate 32-bit register in both
the F and D register groups, so frm and fflags are lost after migration.

Read and write FCSR together with the FP registers and save it in a
KVM-only subsection.  Older streams do not contain the subsection; in
that case the destination keeps its reset value.

Fixes: 937f0b45120b ("target/riscv: Implement kvm_arch_get_registers")
Fixes: 9997cc1e19d1 ("target/riscv: Implement kvm_arch_put_registers")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-2-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 +++
 target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++----
 target/riscv/machine.c     | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd..25f8ec00a9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -535,6 +535,9 @@ struct CPUArchState {
     hwaddr fdt_addr;
 
 #ifdef CONFIG_KVM
+    /* KVM floating-point state */
+    uint32_t kvm_fcsr;
+
     /* kvm timer */
     bool kvm_timer_dirty;
     uint64_t kvm_timer_time;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 68e1501b21..c8ccd9124e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -111,6 +111,14 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
+#define RISCV_FP_F_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, \
+                         KVM_REG_RISCV_FP_F_REG(fcsr))
+
+#define RISCV_FP_D_FCSR_REG \
+    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_D, \
+                         KVM_REG_RISCV_FP_D_REG(fcsr))
+
 #define RISCV_VECTOR_CSR_REG(name) \
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
@@ -743,7 +751,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -755,7 +764,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
             }
             env->fpr[i] = reg;
         }
-        return ret;
+        return kvm_get_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
@@ -776,7 +786,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_D_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     if (riscv_has_ext(env, RVF)) {
@@ -788,7 +799,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
                 return ret;
             }
         }
-        return ret;
+        return kvm_set_one_reg(cs, RISCV_FP_F_FCSR_REG,
+                               &env->kvm_fcsr);
     }
 
     return ret;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffce..3238912b63 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -197,6 +197,32 @@ static const VMStateDescription vmstate_rv128 = {
 };
 
 #ifdef CONFIG_KVM
+static bool kvm_fcsr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return kvm_enabled() &&
+           (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD));
+}
+
+static int kvm_fcsr_post_load(void *opaque, int version_id)
+{
+    return kvm_enabled() ? 0 : -ENOTSUP;
+}
+
+static const VMStateDescription vmstate_kvm_fcsr = {
+    .name = "cpu/kvm-fcsr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_fcsr_needed,
+    .post_load = kvm_fcsr_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.kvm_fcsr, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool kvmtimer_needed(void *opaque)
 {
     return kvm_enabled();
@@ -564,6 +590,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_pointermasking,
         &vmstate_rv128,
 #ifdef CONFIG_KVM
+        &vmstate_kvm_fcsr,
         &vmstate_kvmtimer,
         &vmstate_kvm_mp_state,
 #endif
-- 
2.55.0


