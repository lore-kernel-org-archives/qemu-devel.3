Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BF8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrb-0008E0-Af; Mon, 12 May 2025 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrC-0007eG-9Q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrA-0000iv-Lt
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BeCgcY0flMaS6sUJzEDYGbn4oIHa7zbL2M1zBQOBeg=;
 b=Q/71qPFw4lN1NvB6mTFBGQtA5PIfOa+/Z9rl9pJ+h1xmsh7/gK5ZvG66VIM7JmGeFDyEyC
 Qd9vjj+2U5CU5pm4Q/YkBhJ+8N6afgZkPZ3drROGXXB/UIOFzVdZxiNz3RkP3bawqtdcQy
 fXLZQ/bDNMz5nWe91JbYavNhO0Yho8A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-3e4K6aryMguMMAGt6IrXVQ-1; Mon, 12 May 2025 05:53:53 -0400
X-MC-Unique: 3e4K6aryMguMMAGt6IrXVQ-1
X-Mimecast-MFC-AGG-ID: 3e4K6aryMguMMAGt6IrXVQ_1747043632
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad240e3f501so138057266b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043631; x=1747648431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BeCgcY0flMaS6sUJzEDYGbn4oIHa7zbL2M1zBQOBeg=;
 b=of0tGoty5Zm09yrF4ZXnq4dzhEnqIEL1SY7nbEG5MVZaJYI++iFWIOj0FiT5znu8LU
 il43Tn/bdgBfEjfkARz7yTNwDXr3PGAsSXfCFVyVBGzpgA1uEFG78GYSLRNjOP/BA7Lp
 a7cWBPgSpb9jdWmPW7f+RcYgGwr66ggTyk/8Wgi0L5rJTlRYGNZGYf54x6IwjX+iomuf
 q6+MW6Otqjm1IkPw0Qz/NCHFOk74dSW/sAkTGoMJQAqQPkS2KDy+5Im4MIuqPMC/Wz45
 MXyx0H1zy6KGfWkD78QJ/aAb+AcN3DgiaBF3RS+x1ZKYHjhtMsXZ18Aq3wlb8RipwVF6
 w9gA==
X-Gm-Message-State: AOJu0YznxnhlaGivf0pjggcDqmamilOx17mzDIM5oYSlOBY54zFEgocn
 pu9yLoGykp+HIzkl8s7AsaP1Twv6YKq0OcqUGhX2BuL4lul84wIVZEbZURYwq35plIvxX7qHRh2
 yegmNOF9H1LUU961/gfTZWXCt7gdvfEPp9/vUPwaaY1kQ1BwPvdQgaKeCFQguQFxM20MgpRhkBe
 9jvHOzSYwJn6ApI0za+rCpG8HWyPNMKt/1xDrW
X-Gm-Gg: ASbGncukcBcZTes/pW8ITYew75bhrMKNrO3Brh7k09DNStoHMTuw4l66KEpBWAF/cdI
 UNfKboc4IOs2m5T3215Y0i4QujiCCkeRJSO1wn1HNXOCx0yEIX81CSpFVtBnovKhuGGC7eZkQCa
 CQu+k9qAAvS6gdedJvzD0E1fZ5rV68whPMVWsrxtMiNxcQYgef4jSGVvNePO9ar+QBi6NelyFP/
 QLmqnTgGz6f8mCNx5p0d09Xjja5uS9tcvvQmcL70pQ1kMH2wLIcLj5N+MfTP/SCKucd3KjNBz7s
 9aQRGWRVb6N+/xu+hWanfmPI9hXCYm6EBj1X19jzRO6t31Y=
X-Received: by 2002:a05:6402:40c6:b0:5fe:e492:817c with SMTP id
 4fb4d7f45d1cf-5fee492819amr3528a12.26.1747043631538; 
 Mon, 12 May 2025 02:53:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvBS9xKLr/BhyGpyDKUzecm+lWPzGjN74CBRI1l2n24ZSr7NesrYEN6F1DWfN5NeAadddEGA==
X-Received: by 2002:a05:6402:40c6:b0:5fe:e492:817c with SMTP id
 4fb4d7f45d1cf-5fee492819amr3515a12.26.1747043631078; 
 Mon, 12 May 2025 02:53:51 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cc5134fsm5637244a12.46.2025.05.12.02.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 14/26] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:14 +0200
Message-ID: <20250512095226.93621-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 06c612afba7..af5b4af4814 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -732,18 +732,6 @@ static void rv128_base_cpu_init(Object *obj)
 }
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
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
@@ -836,18 +824,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
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
@@ -3216,19 +3192,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
-        .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        },                                                  \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3313,8 +3276,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3334,8 +3304,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
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


