Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE135CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhD-0007pB-8x; Tue, 16 Jun 2026 06:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhB-0007ga-Ov
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh9-0003KC-UM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-842cd900ee0so1958677b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604418; x=1782209218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQG0yk5z1yC9H4Dw6LKZKYTX7Uw12q4zbc2nNy7e0VA=;
 b=RUKBSbFnw/NS8rpBul9cRGN84KSfhpHHOMPRO1rOL5tiPeMzJVaqVWvsbgrqWRbHV1
 B9BV6BSUlPeVSOymy9JhLQrNUlZHfYK891sAXSfmL47BHqbVMXD+Aq8fy4HLysDLMRxn
 D1TxbvMtoC/+wD6rAPQ7apdXBVx1JNbe762tJEmmN1jq82CmzEzhbafJ/dwt6K5T0f2K
 hVg6l5X6AAVwwxOynLh5jfZO5oAvigQYi0o0lMKwkvpcG6kLid2IBpEoORQCRS14VKhB
 YYYt4G5EZXdpp+EygrsLbZ8EXs+BJDKX9n+6tojySAqV3Jnwuh/LOCIl/BPCVby4uXIt
 9Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604418; x=1782209218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RQG0yk5z1yC9H4Dw6LKZKYTX7Uw12q4zbc2nNy7e0VA=;
 b=c+LJhTEuJ3m4wP1IMqrJCGi8gyNIaseY2dZGKiqgJ+bUUxQPJiqZvoDcdv3bhHysRo
 BgrxIBdl+TzWEQHdUIgG38pPrFsBSBYPlrAiFkOy0sUuAOJ4JQivlQSuLJ4rjoa5iQ6j
 RYaSaxFJnoT8jwiU4tBd5IgYLpMMlt7JkOopG2B4NQB5EFedcP/PzbBFQRy44aH0SLSN
 /bbkIZktUwPJfKoUvPE/AOKRKtcIchS2jYEFqTImWHc7+F8f/+c9PTslOKW4eD1GIClG
 ye9k1RSfgGmi0IccUUDGPyKRbv5OTGgI09IL3XGTtd8z4ZXHY/lpqjfIe9soOV6ma0Wj
 Wp8g==
X-Gm-Message-State: AOJu0YyAoK7Z89LlWoO2aS57AkAYr5WXOwHwrjGtNbFotLXHh9WkO5Jp
 O9HYj0ZO2gAfmO/MylxtxxYE34zdi/C3OohZ2LkkdJrAryO7qm4N/d5gtr54ghjK
X-Gm-Gg: Acq92OGB/LiXFf/b9p/XzKj6DR2/jidmZXPISWmKy4J7vXxKU2qNja4eFLOHJ/k1X5/
 7ri4ZOE92nEXQsHfoH5PsYibzMi0KblSNL6muYxPqN456ywK/3W7B2cQO+IWcxGraVNAoOec8cC
 MPIHB1fl+gZ7Y2/thCfGWTI370AyTtnpDoPTHUPWoBPedtyq966KeJrtXUz8n6jfSCZKENcjuTm
 VSIsT9BVMPcmMcJbZKkfAOu+iyJxdK4xoijzKUarqWYjhvcBbd//goNG6F0xwEBdkB6ssDQrffc
 GTQWTodEImGQlRImCljFS4IcAL85mjHDdLfpeGLp3vflKI4uh/g3i+Efxm1TwvhMt3znM+PasZX
 NXqJU5Tf+4MP0wPXprrN95eOmsg6NwZogZYzAVkgL1pqshW+LpJ9CjVAXhzy0xEGCGWQc2sbbSl
 menandTWM5pguTMM8trFGUIQDkXXdGHuTts+Qk2/eM
X-Received: by 2002:a05:6a20:9186:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-3b7e49d09f6mr3381494637.35.1781604418401; 
 Tue, 16 Jun 2026 03:06:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/83] target/riscv: Fix size of gei fields
Date: Tue, 16 Jun 2026 20:04:27 +1000
Message-ID: <20260616100527.1939565-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Anton Johansson <anjo@rev.ng>

geilen takes the values 31 or 63, fix it to 8 bits. hgeie and hgeip are
at most 64 bits in size, fix to 64.  Update relevant function arguments
and uses of hgeie and hgeip.  Note, masking is widened to 64-bit as
geilen is already verified to be smaller than the target long size, and
an out-of-bounds shift would be UB anyway.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-14-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 10 +++++-----
 target/riscv/cpu.c        |  4 ++--
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/csr.c        |  4 ++--
 target/riscv/machine.c    |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a57e28f40e..2a4b7378f3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -280,7 +280,7 @@ struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
-    target_ulong geilen;
+    uint8_t geilen;
     uint64_t resetvec;
 
     uint64_t mhartid;
@@ -357,8 +357,8 @@ struct CPUArchState {
     uint64_t htval;
     uint64_t htinst;
     uint64_t hgatp;
-    target_ulong hgeie;
-    target_ulong hgeip;
+    uint64_t hgeie;
+    uint64_t hgeip;
     uint64_t htimedelta;
     uint64_t hvien;
 
@@ -611,8 +611,8 @@ int riscv_cpu_mirq_pending(CPURISCVState *env);
 int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b6218421..c063604298 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1084,9 +1084,9 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         }
 
         /* Update HGEIP CSR */
-        env->hgeip &= ~((target_ulong)1 << irq);
+        env->hgeip &= ~(1ULL << irq);
         if (level) {
-            env->hgeip |= (target_ulong)1 << irq;
+            env->hgeip |= 1ULL << irq;
         }
 
         /* Update mip.SGEIP bit */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9ffcc6fa51..4529341696 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -712,7 +712,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
+uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
 {
     if (!riscv_has_ext(env, RVH)) {
         return 0;
@@ -721,7 +721,7 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env)
     return env->geilen;
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
+void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
         return;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f885f5d4f7..0d0b2fca49 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3786,7 +3786,7 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
 
     if (csrno != CSR_HVIP) {
         gin = get_field(env->hstatus, HSTATUS_VGEIN);
-        old_mip |= (env->hgeip & ((target_ulong)1 << gin)) ? MIP_VSEIP : 0;
+        old_mip |= (env->hgeip & (1ULL << gin)) ? MIP_VSEIP : 0;
         old_mip |= env->vstime_irq ? MIP_VSTIP : 0;
     }
 
@@ -4971,7 +4971,7 @@ static RISCVException write_hgeie(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
     /* Only GEILEN:1 bits implemented and BIT0 is never implemented */
-    val &= ((((target_ulong)1) << env->geilen) - 1) << 1;
+    val &= ((1ULL << env->geilen) - 1) << 1;
     env->hgeie = val;
     /* Update mip.SGEIP bit */
     riscv_cpu_update_mip(env, MIP_SGEIP,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 045e830242..eb57ab07dc 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -92,8 +92,8 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.htval, RISCVCPU),
         VMSTATE_UINT64(env.htinst, RISCVCPU),
         VMSTATE_UINT64(env.hgatp, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeie, RISCVCPU),
-        VMSTATE_UINTTL(env.hgeip, RISCVCPU),
+        VMSTATE_UINT64(env.hgeie, RISCVCPU),
+        VMSTATE_UINT64(env.hgeip, RISCVCPU),
         VMSTATE_UINT64(env.hvien, RISCVCPU),
         VMSTATE_UINT64(env.hvip, RISCVCPU),
         VMSTATE_UINT64(env.htimedelta, RISCVCPU),
-- 
2.54.0


