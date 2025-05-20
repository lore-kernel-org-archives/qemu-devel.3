Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B438C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKno-0000Rt-7x; Tue, 20 May 2025 07:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKni-0008Sd-HL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKng-0003F0-Kp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlP2lhS81+uvghTLlJlc3pWMGTZTvlZCWSW9BG7siWs=;
 b=hwtW9tmjHpoyJ5A8VTLYv3YS1506NJcuwjAhwo/0SGIXAz4f8qI9dTU9h+UNurg7LLJ9Pf
 1URIvmYMY4JA94F6RwfbGtLBLI5Vlo66vIZNetGtp5PEVUk5J92ZMJpE6ziKg4MXEUuj9d
 9/wgUZq+dcJcHpVY03ioGyo5dKTqngk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-4RnYBLuKNsC4T6460vmM2g-1; Tue, 20 May 2025 07:06:22 -0400
X-MC-Unique: 4RnYBLuKNsC4T6460vmM2g-1
X-Mimecast-MFC-AGG-ID: 4RnYBLuKNsC4T6460vmM2g_1747739181
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56c38dbeaso237090066b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739180; x=1748343980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlP2lhS81+uvghTLlJlc3pWMGTZTvlZCWSW9BG7siWs=;
 b=PRpyRBxKJ/0IdMgFLHWrmJZQeOGKJUHj18lnKEPLRDKXeTrGarX0gDG40SUqIkwnbs
 GRrH3Mqy4XEMU4+x3dNfzI6W82SstVtlaTSkx+NXIiLVV3eZHObtULVV7G9n7IuRk3/D
 xGgS8QS871azUQnYV4DBh3Hbgp58hHdL4l2I3FmVYW5K7m/KOpfbO8VaNobAEAJjOK8p
 zoa6eqimM9UcgD0Wia1v3FXFNmq1IAQEW9FNH0IROLsk2BcmRoYzDJ3+Do4ecRuOTewy
 LF2VQqVJfNLSIoGHNYc31rqoAzXzju0s8HtYHNfVahVmSZZwAp93xfhQdnHRVjGUg5ac
 K/fQ==
X-Gm-Message-State: AOJu0Yyb4BsBz/RM+PW5HTshPFPKuKd2xzIIagYJOIjTcP+RgZfNRplE
 heZWzjvwjpbW9B//SOGpKNWK4L0XLicV0cj8pPZeKFa3I3aiMPnTcabyzjBQvqnrKa9C4n9Dkxg
 ljPQa8rgI/ooNYmVT/09P59aRUUCs6IAiIjw0mPZkVRwul9JfjRvGdEkc1yvFvjIN8aaTj7MIUT
 3Oikdml2s5J98I5HJNRlC6IRMGuWDPa6NILhKwLiBO
X-Gm-Gg: ASbGncuT8tQXcEk58wjvwDaEhzXfohf13y2e2bt+BaWF6ZyqtmyddXS8LRYYoNqdxUv
 Kh/5GvynamKmlfYXqDEooHjqWWc0GKFOeE3ned1cop8EA44QpYrggAlWG3vEWGEko8F+OamyoOe
 pXltA9UTut7dFOozVN6GFB+Q+FELLDRoOf5RK0vq2dFGYJ7BPGMY5ATfovKgW6yU2ZVd7FWS44c
 R8isLCt0msOQ92IzQpraBcAv+t8tAbU/jxuwSebU4nen6hagZyOncqpWvslm53JP+ZtiDHvdAOt
 TNJko08AquWx2g==
X-Received: by 2002:a17:907:97ca:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad536c22d77mr1336393066b.31.1747739179855; 
 Tue, 20 May 2025 04:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjNeQQAM/zF/aDpbVwh+PLHjjWyJ9Pdk2e64I2dTGCjPWeMQIRNr8SK6hMyJ+kH93nVbQSPA==
X-Received: by 2002:a17:907:97ca:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad536c22d77mr1336389766b.31.1747739179350; 
 Tue, 20 May 2025 04:06:19 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm721976166b.69.2025.05.20.04.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/35] target/riscv: convert abstract CPU classes to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:16 +0200
Message-ID: <20250520110530.366202-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
index 29b01e9aa86..f3d70afb866 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -544,6 +544,7 @@ typedef struct RISCVCPUDef {
     int priv_spec;
     int32_t vext_spec;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 634216870ed..7dcaf72fc14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1474,8 +1474,8 @@ static void riscv_cpu_init(Object *obj)
      * for all CPUs. Each accelerator will decide what to do when
      * users disable them.
      */
-    RISCV_CPU(obj)->cfg.ext_zicntr = true;
-    RISCV_CPU(obj)->cfg.ext_zihpm = true;
+    RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
+    RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
@@ -1498,36 +1498,6 @@ static void riscv_cpu_init(Object *obj)
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
@@ -3100,6 +3070,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
     if (data) {
         const RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3253,6 +3224,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = &(const RISCVCPUDef) {                \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
+        },                                                  \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3279,22 +3263,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


