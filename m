Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0823C369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1c-0006LG-6v; Mon, 28 Apr 2025 03:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1S-0006Gl-7J
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1P-0001CR-AJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cE/UnPxVXK9mYHbpRyj+QpAMiZE1mDpx2gyfY2o9hI=;
 b=W5U4ZId/0/gsNJ6HRB0vV8vCnTMG12hejVgkGfleQLYBqDZZDv/eair690VvLoaiCflzCz
 ZY1lRO4CohE5H+1X2CAfPwvZt+nJJ+16kgoCxZ7yrjovcQDUnItxaW03KR+c1b1gwW1GLj
 a1P3vP2VAgFNzFndaw7pJqrxr65suxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-oJFFJ3S2O3idVyfiq2udcw-1; Mon, 28 Apr 2025 03:35:20 -0400
X-MC-Unique: oJFFJ3S2O3idVyfiq2udcw-1
X-Mimecast-MFC-AGG-ID: oJFFJ3S2O3idVyfiq2udcw_1745825719
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so33697625e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825718; x=1746430518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cE/UnPxVXK9mYHbpRyj+QpAMiZE1mDpx2gyfY2o9hI=;
 b=w+vM7XYPHRjJxIntrQxkLpGu2/Faxs8PBIioKld9oCgCXpJA1hP6oHPJ87xFk1vbhs
 rOSYt9RdMSaapR8/SntsofYSaouFhnl3azmf47pgVZjrOp0ZfPiIgsmtEDCBF/LckDBs
 1UzowZmSf6r/dFAjAT8FIs1myvB4N9Em80P/WgX4E/ynjEsNJIH44dekzEUkJSb0Rrwt
 a+L6qRz2ooyfS+rTvEELtoYyqKps7YDqDCFm9PHsJKuOFRIAduLjUcr7FkFzyli/+siW
 Lsz/m8mwRGymFW9+9MoOV+TftGqAh3BRr3FowKMKbuBvO3T9rU3mJj5SOzimiXs12W75
 vZ0w==
X-Gm-Message-State: AOJu0YxMjGbBFZwY0OiS8qfMoII5JOMaV+TzZGQS/9F113gXsfwv39yJ
 du5fdn5F/NSZjfZq0XYbOPp3wTEdLFzfxZkXXjh7wC8NfIpy8hPpGcqXP4vzATJywrN9cOCVJYk
 sxl6yxtjWJk+TxqI2rm/BTna6qe78rudcBbiqWBhkft8iRzZ1jiFYIyrnAgzM2URwaqEEmfo9Zv
 FSakZA129QNrWpM4gV6QmfrKAI2o6bzja1gpZg
X-Gm-Gg: ASbGncuZs+M0Bfbww1GPACFrQqX+9rPx6rt7tD60siOgEIio2eKYgcbS7+icWa4t9Gl
 aFa3Q87hNgvTGpNhvucI53dyedqF54xmFg00dWInQb8mfoy0GHxPkj7ugHiJwvhDp5jkjqcS+mv
 n2FzbtXFZ+3D8PEecwtQmlom3ervvz2T1ml/5f/JM1cmWjiTg/bV0N0XeRfQAcFr4YV48ulbbuB
 6U6088eHbm0aKeHPDizPuy5wbqXSMvxm4EoU+uWCGilGjXj3Gn6/5+ng5JWJUp8ldErqC2iI6hU
 sZO2cOs2UB1j5M4=
X-Received: by 2002:a05:600c:3111:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-440a64c179emr90664415e9.7.1745825718264; 
 Mon, 28 Apr 2025 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERw9boEc2ptjITRbuQEqSI8VEJ9VpNYIQnG41q7rly483+1g5+/fkaWW0Jw5V9UMv8dSGmCQ==
X-Received: by 2002:a05:600c:3111:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-440a64c179emr90664155e9.7.1745825717808; 
 Mon, 28 Apr 2025 00:35:17 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53031acsm113269865e9.9.2025.04.28.00.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 13/26] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:28 +0200
Message-ID: <20250428073442.315770-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Start from the top of the hierarchy: dynamic and vendor CPUs are just
markers, whereas bare CPUs can have their instance_init function
replaced by RISCVCPUDef.

The only difference is that the maximum supported SATP mode has to
be specified separately for 32-bit and 64-bit modes.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 93 ++++++++++++++++++++++------------------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5015763b7f4..b2744b66030 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -543,6 +543,7 @@ typedef struct RISCVCPUDef {
     int priv_spec;
     int32_t vext_spec;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index de831c8004d..0876b8a959c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1475,8 +1475,8 @@ static void riscv_cpu_init(Object *obj)
      * for all CPUs. Each accelerator will decide what to do when
      * users disable them.
      */
-    RISCV_CPU(obj)->cfg.ext_zicntr = true;
-    RISCV_CPU(obj)->cfg.ext_zihpm = true;
+    RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
+    RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
@@ -1499,36 +1499,6 @@ static void riscv_cpu_init(Object *obj)
     }
 }
 
-static void riscv_bare_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    /*
-     * Bare CPUs do not inherit the timer and performance
-     * counters from the parent class (see riscv_cpu_init()
-     * for info on why the parent enables them).
-     *
-     * Users have to explicitly enable these counters for
-     * bare CPUs.
-     */
-    cpu->cfg.ext_zicntr = false;
-    cpu->cfg.ext_zihpm = false;
-
-    /* Set to QEMU's first supported priv version */
-    cpu->env.priv_ver = PRIV_VERSION_1_10_0;
-
-    /*
-     * Support all available satp_mode settings. The default
-     * value will be set to MBARE if the user doesn't set
-     * satp_mode manually (see set_satp_mode_default()).
-     */
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-}
-
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -3101,6 +3071,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
     if (data) {
         const RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3254,6 +3225,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = &((const RISCVCPUDef) {               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
+        }),                                                 \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3280,22 +3264,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_init = riscv_cpu_common_class_init,
         .class_base_init = riscv_cpu_class_base_init,
     },
-    {
-        .name = TYPE_RISCV_DYNAMIC_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .abstract = true,
-    },
-    {
-        .name = TYPE_RISCV_VENDOR_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .abstract = true,
-    },
-    {
-        .name = TYPE_RISCV_BARE_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .instance_init = riscv_bare_cpu_init,
-        .abstract = true,
-    },
+
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
+        /*
+         * Bare CPUs do not inherit the timer and performance
+         * counters from the parent class (see riscv_cpu_init()
+         * for info on why the parent enables them).
+         *
+         * Users have to explicitly enable these counters for
+         * bare CPUs.
+         */
+        .bare = true,
+
+        /* Set to QEMU's first supported priv version */
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        /*
+         * Support all available satp_mode settings. By default
+         * only MBARE will be available if the user doesn't enable
+         * a mode manually (see riscv_cpu_satp_mode_finalize()).
+         */
+#ifdef TARGET_RISCV32
+        .cfg.max_satp_mode = VM_1_10_SV32,
+#else
+        .cfg.max_satp_mode = VM_1_10_SV57,
+#endif
+    ),
+
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
 #elif defined(TARGET_RISCV64)
-- 
2.49.0


