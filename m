Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D61CC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K30-000379-Cp; Sun, 06 Apr 2025 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2m-0002xd-0l
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2k-00022u-3X
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skSAIZ2xtBX6EPs+MJ0qTLqziuXyOaBGyYcYJBETD8I=;
 b=B021C7DDemRByyA8J+jwADuW3B12adRtI0kWV44A5JRFEQIDxBgRbwkpbZmtNArM1vpYde
 ChackQEk7F66kxr+OwnGq7rq0eTnI4cImEuEEIQWT4aSnVeuE0uwTj1zaH6/jgftizELzA
 wI23Y+hJHzCNi5dwu6gB0EBypuueyJw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Gyj91owwO5inLoz2tTFcoQ-1; Sun, 06 Apr 2025 03:03:42 -0400
X-MC-Unique: Gyj91owwO5inLoz2tTFcoQ-1
X-Mimecast-MFC-AGG-ID: Gyj91owwO5inLoz2tTFcoQ_1743923022
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so28983115e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923021; x=1744527821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skSAIZ2xtBX6EPs+MJ0qTLqziuXyOaBGyYcYJBETD8I=;
 b=JKbOGfeKoIr4F6EUgDvLk7PzUS1WRLqW9Tkgxe84qCMu8KHadg0s0Rgm61dBYZATog
 zapDS93cGxhKdU37chepRO2ydObItE5GWYAmy6WhG+xSarwQyyLVp2sbemBZQIsVIGl1
 lrKWlFSVd2Yn6bavwYKWzP5VzKgulrUDLA5HL6TrEmzFLw5o/dZYQVlYJwkHdgqocpPZ
 Yz+SVHVymjhm3BBbPc5Ra5A4djtKANlx29EuHy0YeqGOmn6D/vmHBz2ewn7TBCVQVQ7v
 XPZ+rAfdoLJBwTvAJ05A9PBMQ8/6Rr2qJxevET2mEfLx8bdP95sei3l+lHRdJ7rJfAv/
 Esyg==
X-Gm-Message-State: AOJu0YzVp6bcfb5hO4Bro53ZyIUjmwn9yEcEZ9bSz0uxKKIzD8I+Ym5j
 P1X39WhWJzKb5CjfxSZDuPvTrzBfJ2EUVX0Xx5esy1mvAGciFhipjGld862vyi5q/n1vuFJGS/P
 OxtmWEVrWokBWvFKbgdzZSNlxAKl3C1iC/8OL87tI3bzdbVgoNPEGBj8c8EhP2RjMd8LG4ph4FI
 HJi7Oqa7nTwiHwb6Es/Pb1V7UgKEoxaMKFiAf7
X-Gm-Gg: ASbGncuONIsC6KvYQMQF0UH5WtT93uTD7xUToHRCrVvlPf1BJMfkGAHjHu3d/saocRT
 QbdYQOQQa0/rpwrE8h4SkeFjso9PVO2VOipfQCOO6vIL/moxviSSHaa4Z1Xn2ZM9O5tSIm1H9Vd
 7MRmAOF2wQuAniYhWspWDbK1GVs2266x2Qbjkbko1vF6mvk6xaMNIJWTVVLniynLLFC62QQPft5
 fzNJIUEfRHfSgXJij6yfgNsVH93iNqGxQ0o5Y/v2EyO65ugjx0oSuSYS981K9juJ5f7F9XpWAKX
 Oh5887GjlVEDyZv3lg==
X-Received: by 2002:a05:600c:1d24:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-43ee06644dcmr35963205e9.14.1743923021340; 
 Sun, 06 Apr 2025 00:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcW4sAMGeKj/8sCKnASnM9wIjQVrwGPpvXHO1ZRjHI5heiuVrBNEV6c+aGb18tWTEXp+8VYw==
X-Received: by 2002:a05:600c:1d24:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-43ee06644dcmr35963005e9.14.1743923020965; 
 Sun, 06 Apr 2025 00:03:40 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020dacfsm8749042f8f.72.2025.04.06.00.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 17/27] target/riscv: convert dynamic CPU models to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:44 +0200
Message-ID: <20250406070254.274797-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 113 ++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 83 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ea203d97b7..73c815d22e9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -486,38 +486,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-static void riscv_max_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-}
-
 #if defined(TARGET_RISCV64)
-static void rv64_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
-}
-
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -718,43 +687,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#ifdef CONFIG_TCG
-static void rv128_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
-}
-#endif /* CONFIG_TCG */
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
 
-static void rv32_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-}
-
 static void rv32_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -3172,19 +3109,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
-        .instance_init = (initfn),                          \
-        .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        }),                                                 \
-    }
-
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3241,7 +3165,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_base_init = riscv_cpu_class_base_init,
     },
 
-    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .priv_spec = PRIV_VERSION_LATEST,
+    ),
+
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
         /*
@@ -3269,15 +3198,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV32,
+        .cfg.max_satp_mode = VM_1_10_SV32,
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
 #endif
+    ),
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
@@ -3294,11 +3231,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
 #endif
 
 #if defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
@@ -3308,7 +3252,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV128,
+    ),
 #endif /* CONFIG_TCG */
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
-- 
2.49.0


