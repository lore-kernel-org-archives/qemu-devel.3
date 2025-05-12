Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B371C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPr2-0007cm-VZ; Mon, 12 May 2025 05:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqr-0007ab-RN
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqp-0000ge-Fv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJrmMnaRIxDOFjvBIilrwrwJO0JRgZHg+dn60ugUN0s=;
 b=g/Ay5Ce9V3X9BViBwKdhMEe72xzu1ozlCp5thiml/48sDc0v1DKg55UKYh7y41CB5ra3nZ
 FcDDEGzJl8TMxZvnXxuHv1AGgfd8bC9ZrFAODFoNS6pAIrOHyNUYw+NJFf2tZmJ3V6fTEj
 KcUzGDqlWiW3pFWyF9kPwLqVMTzCKsQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-UM3JudJMN6iciT1YRvfLLQ-1; Mon, 12 May 2025 05:53:32 -0400
X-MC-Unique: UM3JudJMN6iciT1YRvfLLQ-1
X-Mimecast-MFC-AGG-ID: UM3JudJMN6iciT1YRvfLLQ_1747043611
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso331429166b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043610; x=1747648410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJrmMnaRIxDOFjvBIilrwrwJO0JRgZHg+dn60ugUN0s=;
 b=oE/cZgAp6lDmKf7Ogsem5oTW4MBlq/rfKQBr3tD34UFRKL9AZWYXBwafhPPiHorxK+
 ynQ0asanoNUcN230NPr/VVWKmlZwdau4ROenZn22+RJtE6OghgvFuvunQCUfG2nw9ssq
 ryntEHYAlx/tQR7wJmxXpYP1zn26TQB0mZsdnZtQsqZacWSoZvKt9odShyKxply35kdj
 3haEXjYbCHNqn44UpD9dHn1xI7jKgLnkotb25pHmUWUhRFUlV2Jk+GwVBDof8gtpflzN
 omWJPCgvhckYSh2hx7sSTyG4+HcLasUTLnGDtzcivRc9InUuVBO+AOUcQ1Gw7H/v1PeC
 96+g==
X-Gm-Message-State: AOJu0Yzz60nLR7j/HlGXwPzjfXuPU65yTe4qb6NX3yZFTHCuoamP6v4G
 c4K8ksISSRR2fDovKCWK4aHOnKq02NdCCzLeFal2uRQ8mWHLfPc051Os0U20m2Z6E8meT0KsLNn
 QaIrOCSjv+MQCDnhcCHJCdyvjL/WsUxeUMxapLxULB09mnGF5+rvQ1anKjUIdvFDi6dWrINIR/l
 A6kw8wPMN175RpfD9VetElq5xYnZ4K0e42D/nR
X-Gm-Gg: ASbGnctNcC5j4XomYSFbv4M3BKN1zjyqFGAo1ErIA3rnEm/6ZdsUFzlIIy/xdho9gfw
 H6jJ/nWXQ/xaT/VSsyOKep/LWGqbG45GysAnM6cplagHeB46V121x/c/udEqY2SU40SnL7UafWp
 LwvmVXtlsiWsM2N+NyN9ywlVxl/SNQv/UypybHGH+SXeUiZ3Md2xUgkEbq5X9qAjlhdghG2eznC
 u4qyipEJql0BfYKwr4a0++m6tJd5paue1MHKnvgZeeafLRwcFGlTpJ5JSa/DLt+VQ4wkYkx5NXX
 Ii+tKUJxaJ0qALGBqNQ3cFLW7UmqcVY4et0U1B4wa1iEfus=
X-Received: by 2002:a17:907:7b04:b0:ad1:fab8:88ab with SMTP id
 a640c23a62f3a-ad219085c07mr1088458466b.29.1747043609709; 
 Mon, 12 May 2025 02:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfdu182isBxUbnNmAChPMbo026SvKroDbaYUu3lgMYMsSFWuS4tvAwom5H5m+gQPK8oluQRg==
X-Received: by 2002:a17:907:7b04:b0:ad1:fab8:88ab with SMTP id
 a640c23a62f3a-ad219085c07mr1088455966b.29.1747043609178; 
 Mon, 12 May 2025 02:53:29 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197463e2sm597241766b.108.2025.05.12.02.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 07/26] target/riscv: store RISCVCPUDef struct directly in the
 class
Date: Mon, 12 May 2025 11:52:07 +0200
Message-ID: <20250512095226.93621-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for adding more fields to RISCVCPUDef and reading them in
riscv_cpu_init: instead of storing the misa_mxl_max field in
RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
and go through it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  2 +-
 hw/riscv/boot.c            |  2 +-
 target/riscv/cpu.c         | 23 ++++++++++++++++++-----
 target/riscv/gdbstub.c     |  6 +++---
 target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
 target/riscv/machine.c     |  2 +-
 target/riscv/tcg/tcg-cpu.c | 10 +++++-----
 target/riscv/translate.c   |  2 +-
 8 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 511fc25adc0..7edefc80d73 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,7 +553,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUDef *def;
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 765b9e2b1ab..828a867be39 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -37,7 +37,7 @@
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(&harts->harts[0]);
-    return mcc->misa_mxl_max == MXL_RV32;
+    return mcc->def->misa_mxl_max == MXL_RV32;
 }
 
 /*
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c163b2b24a2..02f2073441c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -356,7 +356,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 {
-    return 16 << mcc->misa_mxl_max;
+    return 16 << mcc->def->misa_mxl_max;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1047,7 +1047,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1449,7 +1449,7 @@ static void riscv_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -1543,7 +1543,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -3070,12 +3070,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    RISCVCPUClass *pcc = RISCV_CPU_CLASS(object_class_get_parent(c));
+
+    if (pcc->def) {
+        mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
+    } else {
+        mcc->def = g_new0(RISCVCPUDef, 1);
+    }
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = def->misa_mxl_max;
+    mcc->def->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3226,6 +3238,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
+        .class_base_init = riscv_cpu_class_base_init,
     },
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 18e88f416af..1934f919c01 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -62,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return 0;
     }
 
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         return gdb_get_reg32(mem_buf, tmp);
     case MXL_RV64:
@@ -82,7 +82,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
     target_ulong tmp;
 
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         tmp = (int32_t)ldl_p(mem_buf);
         length = 4;
@@ -359,7 +359,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
                                  0);
     }
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 75724b6af4f..cd82b29567c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_class_init(ObjectClass *c, const void *data)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
-
-#if defined(TARGET_RISCV32)
-    mcc->misa_mxl_max = MXL_RV32;
-#elif defined(TARGET_RISCV64)
-    mcc->misa_mxl_max = MXL_RV64;
-#endif
-}
-
 static const TypeInfo riscv_kvm_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU_HOST,
         .parent = TYPE_RISCV_CPU,
-        .class_init = riscv_host_cpu_class_init,
+#if defined(TARGET_RISCV32)
+        .class_data = &(const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV32,
+        },
+#elif defined(TARGET_RISCV64)
+        .class_data = &(const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV64,
+        },
+#endif
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index a1f70cc9556..c97e9ce9df1 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -170,7 +170,7 @@ static bool rv128_needed(void *opaque)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
 
-    return mcc->misa_mxl_max == MXL_RV128;
+    return mcc->def->misa_mxl_max == MXL_RV128;
 }
 
 static const VMStateDescription vmstate_rv128 = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ab8659f3044..305912b8dd3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -691,7 +691,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -788,7 +788,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
     }
@@ -1026,7 +1026,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -1035,7 +1035,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
 
@@ -1161,7 +1161,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 #ifndef CONFIG_USER_ONLY
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
-    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
                    "128-bit RISC-V currently does not work with Multi "
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 85128f997b7..254c2c81a24 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1281,7 +1281,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->misa_mxl_max = mcc->misa_mxl_max;
+    ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-- 
2.49.0


