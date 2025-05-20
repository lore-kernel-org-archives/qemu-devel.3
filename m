Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5716C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnv-0000yw-JM; Tue, 20 May 2025 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKno-0000U9-DO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnm-0003Gt-7F
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u7O99sOeNI6w8Mk9SYljAjsaua2ADq398/ujKmLpFI=;
 b=ESN/ZLZwkVtZ5LXKv2rglMJpUIE7so9Nc+d4BiZCn6VvYBPhjTXLDacCp0/gflX4i7hyfx
 kEaZnJ1vqkN8NjUonHS/ca6UOx9VilDt9gmbnwwEHuEyARHRl3rlpATW2FTNv/oLHQK6YY
 xcp+w3+jDNhwWygXP8LM5EIqKEyuRa8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-_nCgPB9iPgCgnSym-TrWQg-1; Tue, 20 May 2025 07:06:28 -0400
X-MC-Unique: _nCgPB9iPgCgnSym-TrWQg-1
X-Mimecast-MFC-AGG-ID: _nCgPB9iPgCgnSym-TrWQg_1747739187
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad56bfb164eso211691366b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739186; x=1748343986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+u7O99sOeNI6w8Mk9SYljAjsaua2ADq398/ujKmLpFI=;
 b=v7chYu4Mo2Gb92DZI9yp04U2EwQ4/Xyq2+WDDFhmt8dK/by0T4c7gl3jowML1cC/cF
 IvOWLn9Jd2ZxPiYS6Itel8+g8glFtqBR60h/Lbh6Ci4LrOejpBCdBtE3w9dAuMVpJuzU
 Z60Fasz8S7zZqOHVvB+ksxFN7QZTO/CHpPdhRuFf9xqCYgzsfmGb+5/b6l00MyE2lEmM
 0xJ7w7rN6Q/T84DDmVnWabN6y9EexsdMzvRQwp+0DEXcnZmQVoaQq5QhdMkDs1GK6grr
 XgXWfAh9HZSu1XQqtfqWElZwylC+BLeo6wTX03unhIQ2/Xsg5ZCdTJLBOx7OMPrEEJX2
 1aMg==
X-Gm-Message-State: AOJu0YxTE1XzhkoxfufKUdCduL51gPpwTfp8MqHP20RLwngvVqfMSkT+
 kU/IhssHfOa8kVcPQbmqcvTlM2lh6GaMAcQxlDTYM+nOusQm3lxePtCgbw1oWwC3hMqjgVBaCdg
 2RVd7NbLvoAqU1P0Ui4OUs2p43HrSwPvM4wHqsQD87tL6E32oIbM1w5CqYrOaP5YEgmDSnk4R2s
 hEMFT+iIP/UxG3j75ADs36r52TZ5J1xbP8AyzY+CCv
X-Gm-Gg: ASbGnctsLICdZbQlSl+m5JeSqRt39m6rVAMU1NC2hmaIU/Pl4zsEq8KZyCO7XCYrbMk
 Xvffg9x/D9Wj1ffo1tvTkkjFM11UNkRpt2T2OHPmW7wiyWHb+GEdhf4j9GtTQw8OCRhDR9dlQd7
 hjucJlyInJlI7yffG653+Yc/moMIZgrjDX3kCM2kyxXLGWbWF1rKpcq1InDlN0fv/vo7wZQK0ud
 3XJeouiftj6Ijno/SjgoL0WxegqjbiHuvmkcea6LC5X6RveKzAUaqNVtBO5AFTn0c2UQuPM+ldo
 NCumuRg51hfBQw==
X-Received: by 2002:a17:907:8e96:b0:acb:b9db:aa22 with SMTP id
 a640c23a62f3a-ad52d0756b4mr1315947466b.0.1747739185740; 
 Tue, 20 May 2025 04:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9PgC3na+3M8FulaJgnz8LJNqM0DebK9+Q1AbatAbHaUv4/VTbkK2CVcjqx5qrcs9LH8W2Q==
X-Received: by 2002:a17:907:8e96:b0:acb:b9db:aa22 with SMTP id
 a640c23a62f3a-ad52d0756b4mr1315944866b.0.1747739185313; 
 Tue, 20 May 2025 04:06:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04e990sm711153466b.35.2025.05.20.04.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/35] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:18 +0200
Message-ID: <20250520110530.366202-24-pbonzini@redhat.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54fce767657..8b82a1b7b33 100644
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
         },                                                  \
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


