Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3B1C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bM-0001K8-V5; Thu, 06 Feb 2025 13:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bG-0001GQ-Vl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bF-0001BA-5Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pcCO4SpQ971o0wNrM6zoJJ66x7a3+5UaNoshD/fIRI=;
 b=WZHH679OVeGW4pgngRI8PAwvT34J33GjkThdp2m9QopAIDvpYzYcrP+bKHrKZfQQd1GxjV
 bjiVMJVzRhTf257i5t4RMLTtL1lMIZOhUsIai+chCLC/Nn+ZET/N+/ULf5N9MVJ6RTUqpR
 6Q0hS9+rP9w03wkTvrz5IA3UhkAbMcg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-cLBfy0XMOjerpA6oF0iJxA-1; Thu, 06 Feb 2025 13:27:35 -0500
X-MC-Unique: cLBfy0XMOjerpA6oF0iJxA-1
X-Mimecast-MFC-AGG-ID: cLBfy0XMOjerpA6oF0iJxA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dc88ed9c0so11591f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866454; x=1739471254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pcCO4SpQ971o0wNrM6zoJJ66x7a3+5UaNoshD/fIRI=;
 b=HSdTXAeiTArt+CRELRlaOcNkhY1WElVK94jVmNEIOiZ0uyWRcaMG3/+uoprk6rYXHT
 fOmftdymstKFItXzIGssxzvqzsMugfML2eCZyeL35dg/OJRkr+DbTeZ6XCiuAbGVtTkB
 Ys6E5kAdcz7pfGVWNRZoxFwLs+Px3aW/yLBKh4PnvrmJOkgBL2zUJ8w3jODC2GUDHzb4
 6IsHxXjVZPwIDYfKibzRkCcm7WQnui7wY+MFzZp4w5/5IZZY/ouNQlaGzUAWbnDED5Cs
 2JrHumn3raeaafJ5FIBULqEdljISsP1PJMe7bwF9VzgBdKa3RdB8Z74v0sZWu9/Cpa1s
 weSw==
X-Gm-Message-State: AOJu0YzCXt4ZgJ8n3NqBziKzh7q0QpeqS5Ru5eDfS2bk/Qtcb2RyTTtF
 jva8H+T9/euhSs3uRTAwOIvMwz4gezXa2Ow6hOXBfFMdJpi4n5+kTlRlRwJXFJsMU3dlZsrP/2r
 1v/TXiCHMe4deUUnVx4NyHpsMQIMlfDZNXVlgrgY3SCuI/2WvYMpqYKY80BoZlaDvZYWR2aY+QG
 ZW5m+dc5+BH/lNUnLiCHx5IY4Z2JxpcoR+Ix/EWRY=
X-Gm-Gg: ASbGnctB8bOWyzMXYnfhAr2Co3KgHV0msGMysCTeIYpXZhI1kHAjazT4O5vaCN+XbkL
 1srbdAn4MWnUfHj5+Rtrolu7bZQ/VJVIHw1UX430Nay/pOwlgyRcQ7Oa/8Ps1E99rTu60RpyA7W
 P7ZE9JmEMGbfFl2pC3fSwHRg1a0P3Vf/S+xp/3b4nMPXPglHG9ewso/yiSB/+DZY+hluul0wQVr
 st2zXHgoVVBUrZq+Hg5WxGkdtBEAcv0YYh2YERyr/L5s3FWTrCmyw1fxa5EwtOT1MKhe0ikO9GH
 z9KRX1M=
X-Received: by 2002:a05:6000:1865:b0:38c:5fbf:10d6 with SMTP id
 ffacd0b85a97d-38dc90e19e9mr31393f8f.7.1738866454017; 
 Thu, 06 Feb 2025 10:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuskJhfYhKgy/vpY0wl2WD/MWu7slN4RhBY3/+DJkuYkUt9DRpfgXeebnMnsbwCvngNYT5UA==
X-Received: by 2002:a05:6000:1865:b0:38c:5fbf:10d6 with SMTP id
 ffacd0b85a97d-38dc90e19e9mr31379f8f.7.1738866453619; 
 Thu, 06 Feb 2025 10:27:33 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1e197sm2391223f8f.91.2025.02.06.10.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 09/22] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:26:57 +0100
Message-ID: <20250206182711.2420505-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/riscv/cpu.c | 55 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 253ed5132c4..5c6ba511ef2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -727,18 +727,6 @@ static void rv128_base_cpu_init(Object *obj)
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
@@ -831,18 +819,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
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
@@ -3115,16 +3091,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
-        .class_data = &((RISCVCPUDef) {                     \
-             .misa_mxl_max = (misa_mxl_max_),               \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...)    \
     {                                                       \
         .name = (type_name),                                \
@@ -3208,8 +3174,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3229,8 +3202,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1


