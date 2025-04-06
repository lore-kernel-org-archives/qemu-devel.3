Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E487FC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K30-000372-B3; Sun, 06 Apr 2025 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2k-0002x7-BJ
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2i-00022l-Lx
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x4ZEJZ/v0SMUca1WRYGbFQcsK12f2uxmWN6J2z0GLo=;
 b=V1uyhj+/ZfJOJZXwThNWXBKQXFpt/fCPlW4r1v/DhQbyzy4Cw8EAzkTkhyjLOHJ56eCh2q
 TBgrjyMjz7Uv5aLuQiw8LOxDHEGieztC9jldYfRaMHxPwuuo1TYUGFNhnPb7TcebJz/Rbd
 k4C9NCptQ3C0mNcRQ2Qi+n3VGM8O00A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-w4KzpH_KP7mwhIPQpIs-Hw-1; Sun, 06 Apr 2025 03:03:41 -0400
X-MC-Unique: w4KzpH_KP7mwhIPQpIs-Hw-1
X-Mimecast-MFC-AGG-ID: w4KzpH_KP7mwhIPQpIs-Hw_1743923020
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso21442355e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923019; x=1744527819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3x4ZEJZ/v0SMUca1WRYGbFQcsK12f2uxmWN6J2z0GLo=;
 b=o5f+ZKUOz07+ARMuC88ku12S3gK/o4k2zquZaD+dkBbzWOlP15lusJ3aCjnPUK2IBM
 xmIidGhEKMkjnemdje3kFXSoNIz1h1AazkifsJwr3vWrA94vh9wr198PM9KttGQP/LCB
 lWPLG6yamFw/deqwygky93HTksyUqtBuHbl9ncI+f8BH1/taDWa45Vc4GipxMIzrI56s
 Esmf8nbbsH/3S0DYF3lYPIlply9cRNnrpXaObGQDJ2rfyCk7FVG2mEmvokaYFiIHex5m
 f0RD8qXBsbF3zkNePzPuo4XTr7A3csn7rdaIexv+nNB2lnp3TKR+BEo/pVzozk4EVt2z
 lQpg==
X-Gm-Message-State: AOJu0YxNUgmv8ze1Ff8lxIkoitWjkcK8J73IDOgqqRMVLH3UuB6+qC2K
 FVxH5rWe7Opev9aRmUT22EO2CFPNl/L4tvnGr8nerhETs6oi/cIiAfwXWT5WBKFI0QWxl5tlG9x
 1/5Q8NyK174hT+VPzKF1K/k/m0uzpFUt26pX92PrZcI4hy2UWbtAChhA2Rvui1n04pHS2iAgjLo
 SIUAA+xJu5UHdd4KKA4eMkDZdfIxA9PVDsQ/kD
X-Gm-Gg: ASbGncuX4ElCDSgewDcgofOdx/5FuT3o2KqCmoH328HpsCKfU+E4EAPwjZVqS2uRy3u
 +wFG6F/n1/SgpkAG1tmv1U7/c8ejxF6bJ05Uegk+SGvpajx8C8GrCObDnMVAPygYjTpKAsIWKdl
 NyQRGz6MU3tt3Jad36dYCnPvLwA0ob99KmZ4yCHdqGPOBQWjQTbPEIExxAafn+6rtlQhqDH7yIO
 HWpBPewT4th0G/U74n8zQFRPqWwPojhBWJnc6wMe85vfp7orW0dwov7qlP61gnp4KzQKUaXiQ6G
 +xComqLuoM2zW1H/PQ==
X-Received: by 2002:a05:600c:6b71:b0:43b:baf7:76e4 with SMTP id
 5b1f17b1804b1-43ebee73fb1mr99099715e9.1.1743923019363; 
 Sun, 06 Apr 2025 00:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDuHvvW5PiZJaAuydTgsbOX7pt6P5WWTcVaXo7FDmnwUAC1b45fkxZ8N0L35G7Q6oANKZaig==
X-Received: by 2002:a05:600c:6b71:b0:43b:baf7:76e4 with SMTP id
 5b1f17b1804b1-43ebee73fb1mr99099495e9.1.1743923018918; 
 Sun, 06 Apr 2025 00:03:38 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6c89sm8590517f8f.28.2025.04.06.00.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 16/27] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:43 +0200
Message-ID: <20250406070254.274797-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
 target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d3d5c048d02..2ea203d97b7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -735,18 +735,6 @@ static void rv128_base_cpu_init(Object *obj)
 }
 #endif /* CONFIG_TCG */
 
-static void rv64i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv64e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
@@ -839,18 +827,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv32e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3222,19 +3198,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
-        .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3319,8 +3282,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVE
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
@@ -3340,8 +3310,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG */
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVE
+    ),
 
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
-- 
2.49.0


