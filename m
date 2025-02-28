Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6071AC282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbL-00026A-BO; Fri, 28 Feb 2025 05:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbK-00024a-Ct
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbI-0002wG-8B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeflcpDefEzE9fjqm9Q4rHkD/sFyAOgspp/ICvl4OB4=;
 b=gA0t3tow3SUof6KhBjx4EDo7VoQtJgK27itIY11zW6+dqR6/TsAmhxM2Po4GCwlNnWk6w+
 Xc68mvBNHzpPqmCoatewdg+eqwiOpYhlxh5iIBZ55OaZM6C2YzlUARFYwvBZZTwcYARhid
 R8n63lYo8lM09hgxmOf4bD0N3A9Z8qw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-7TEHyrAhMFmrU7RBidKq6A-1; Fri, 28 Feb 2025 05:28:00 -0500
X-MC-Unique: 7TEHyrAhMFmrU7RBidKq6A-1
X-Mimecast-MFC-AGG-ID: 7TEHyrAhMFmrU7RBidKq6A_1740738479
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so10244685e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738479; x=1741343279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeflcpDefEzE9fjqm9Q4rHkD/sFyAOgspp/ICvl4OB4=;
 b=qw2K7WEU4q6DRpbkLuxda4F84Sh1pS7ll08a1TS+/GAUb3McGoUcGWqSRe+j1A+jH9
 /hO1gCRk+xbcK+uUauOj7TV5Ar0ZdZdF9709jqe9ZFHaLN+1RwPVfhRzngP7/lM6uujX
 b6lQFHGqwG9+q2K7Yv5NOYJmnMekjT5Ba5IS0r0/m1L+32jaBr53KQa2UP4555ylSneF
 Iw1iiBUKPbtLOesMmWAVt5aWvV1erDC9ZzstTqxMq95X9ReydyLFsCms8lll9qX/I/M9
 62dksfokGhSoNY4oRRP1TbJpY+sZCs2XKG/CjbPPEt2sytSKbRBhdWbhqtVrHS+Eiqg9
 N6lA==
X-Gm-Message-State: AOJu0Yxv0H/JWoLQ+91aX01o68vwhcE9zI/q5Dl8nEsDhVo+6lf1LL/Q
 gs3UvOa2+RLXbUZd+Zksi9HHe8H1lwx4ViBY8bMK2nkxpU7vQ0KBSgRQOAXYWdira2J8R+rnbeR
 JTMidrrK/0XupXzvOjD1omWJewc10piCdN8sKI6d2/goyqXy1YyhaMPkR1LZonGiCExYyJgQHkS
 +r3R7Jkai90Kv9ZMzsSnmwGPUNuNnpT4mUS7+YpSo=
X-Gm-Gg: ASbGncs52haMsgILGdZjpUn8sPS3fAPa4syc5+zzm3vqWJ2hXP3LEVgEy2RnvdB7o9u
 4mSkMDseocQ3j7K6141x2f499qleene9PYAjcFu3i29vYTTeB94wu6sjN6OEq2DSWYXK7iZLXCZ
 DyfR4G+kF0WIfsdYdPmIudKMylWIsBCS6bCSRrBpg66wEKupC8jSsWGg1ki0qtWk+x0Z7VJ8HAw
 W3RAFDOgIIPxAy85qUxkOMVd0wHuWi5x566qCyMroSgq/UKTOnFbGzZZ+x7KVDvSyWENbuzozz7
 xNr3IaR0NvwdsCgXJIiX
X-Received: by 2002:a05:600c:3507:b0:439:884c:96ae with SMTP id
 5b1f17b1804b1-43ba6774658mr20210055e9.27.1740738478686; 
 Fri, 28 Feb 2025 02:27:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHelZ3XJrniwRpvSiPPWadHD9N2dIuntwtcWX31M8xwixGjEMtUc0rDLdwB7hfASHrnD+WpbA==
X-Received: by 2002:a05:600c:3507:b0:439:884c:96ae with SMTP id
 5b1f17b1804b1-43ba6774658mr20209825e9.27.1740738478198; 
 Fri, 28 Feb 2025 02:27:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f839asm51752535e9.2.2025.02.28.02.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 04/22] target/riscv: store RISCVCPUDef struct directly in the
 class
Date: Fri, 28 Feb 2025 11:27:28 +0100
Message-ID: <20250228102747.867770-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  2 +-
 hw/riscv/boot.c            |  2 +-
 target/riscv/cpu.c         | 23 ++++++++++++++++++-----
 target/riscv/gdbstub.c     |  6 +++---
 target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
 target/riscv/machine.c     |  6 +++---
 target/riscv/tcg/tcg-cpu.c | 10 +++++-----
 target/riscv/translate.c   |  2 +-
 8 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 743afeb1655..a038122f80c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,7 +547,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUDef *def;
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c309441b7d8..13728e137c4 100644
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
index a71d806e35f..51acce07752 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -354,7 +354,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 {
-    return 16 << mcc->misa_mxl_max;
+    return 16 << mcc->def->misa_mxl_max;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1054,7 +1054,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1447,7 +1447,7 @@ static void riscv_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -1544,7 +1544,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -2957,12 +2957,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = def->misa_mxl_max;
+    mcc->def->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3113,6 +3125,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
index 23ce7793594..f3ec4f33931 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1985,22 +1985,19 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
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
+        .class_data = &((const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV32,
+        },
+#elif defined(TARGET_RISCV64)
+        .class_data = &((const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV64,
+        },
+#endif
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c3d8e7c4005..98d20afd04d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -170,7 +170,7 @@ static bool rv128_needed(void *opaque)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
 
-    return mcc->misa_mxl_max == MXL_RV128;
+    return mcc->def->misa_mxl_max == MXL_RV128;
 }
 
 static const VMStateDescription vmstate_rv128 = {
@@ -383,8 +383,8 @@ static bool riscv_validate_misa_mxl(void *opaque, int version_id)
     uint32_t misa_mxl_saved = env->misa_mxl;
 
     /* Preserve misa_mxl even if the migration stream corrupted it  */
-    env->misa_mxl = mcc->misa_mxl_max;
-    return misa_mxl_saved == mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
+    return misa_mxl_saved == mcc->def->misa_mxl_max;
 }
 
 const VMStateDescription vmstate_riscv_cpu = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e5e01715f10..f434b2448db 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -579,7 +579,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -676,7 +676,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
     }
@@ -891,7 +891,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -900,7 +900,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
 
@@ -1024,7 +1024,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
                    "128-bit RISC-V currently does not work with Multi "
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 698b74f7a8f..782e724a648 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1234,7 +1234,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->misa_mxl_max = mcc->misa_mxl_max;
+    ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-- 
2.48.1


