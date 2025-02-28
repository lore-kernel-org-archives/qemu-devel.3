Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38206C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbP-0002Dk-3E; Fri, 28 Feb 2025 05:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbL-00028L-V3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbI-0002xX-Da
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+m45zklF+a+BzuiPWZgXjYoUj2lZHdtRS7uWKhk89oM=;
 b=hkK/0JBhHR0LZXjfzNmy7SXFUS7ex+1JdnE89qhs2mCiMGogJqW26OUAKAzUIu0peutFGx
 kWzAhrP5QhfWTXf6+fG2+eXf5vkJB2De0bawFG5Vny3tIDko9YwPweGQqLtUb3A/CIcRtf
 d67OfwnQMNhfw5FnE6LG5T2xJh9q8GA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4umjO1kuPluUkX6T9WUGNg-1; Fri, 28 Feb 2025 05:28:08 -0500
X-MC-Unique: 4umjO1kuPluUkX6T9WUGNg-1
X-Mimecast-MFC-AGG-ID: 4umjO1kuPluUkX6T9WUGNg_1740738487
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso19214715e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738486; x=1741343286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m45zklF+a+BzuiPWZgXjYoUj2lZHdtRS7uWKhk89oM=;
 b=ckMs/CjyrC/iU4ZRxfjkZLf3YyKxVuoblUCgxIVe0Rs76kyXqcJNdqrgKBn0mxll57
 WivU9Gpim0PvMnFfjwnKMA7yymOgvkygQrcJKkiETGcwVEpdZtjgWLhT91QMffrTsUdg
 yHUnxFTbN3W/gJCmvEi91JmwbDGD3x7vCKUKiwK4WxCQxzQpR2VtHHgssM3nuhGHplqf
 qa0zuLZgGLLyW8o5ZFrtYzfoOdhFoQS6elrLEPXVbwyoGA/qahV54vEriWU+mi8JHPRu
 7Q4hNlnb+QbLwILmgZqCV9zHt5Ho9Nwot0OQhGlcGzPFgYc6pETXh84hcc4ufs5GHX5D
 nInA==
X-Gm-Message-State: AOJu0YzNeCW9JXj94mRcN5Cs5St5cauKA1kkwJbvlEdJmjR3I6iG9EZu
 7c7zIOsuETJW1UOVYaj1ITAFyTLyKLhmVjSC2jLCzn3rs6kpNeGw97PCH0P6x7mngdutckE+ju2
 uQJ8KqPh1NG3a2QtFH8ZZgG8skEgSwPXMQkBKIa8U8HIDAvqEV7nTEJNTmY8QZx18RqndrP3s/W
 re9WE82GEJTPJQEJRTEfzC2Y3gsWh+Q47yVXkLRBc=
X-Gm-Gg: ASbGncuqDrdivo2taNyG0AARcN+DyC157LhvVBkU9wFryU6kBneumyLQe4F1gB85mQG
 YdsV/g+40O/boSjgcLB4M1HridEb28rz+Q/cyAwNWZ2FNySRBf/YJmrs/IfGce3/WkAOhHMUnnp
 BDf9Ezda4MCLALKZ1QDa+a2+w/Dv3G0bYR1RjjIqfOEwOp/6pTe/ISmqFn0MDK3mzwZyzqLx5gD
 WCelbb7n6ObpjnjO6UPP0gjyB2G61+6USxvBC1Br5n7K5MuTOhF+RpS92WQ40/OUWwTsqbNJ6Qq
 9road6fbDl8Xe4jBT1A9
X-Received: by 2002:a05:600c:a05:b0:439:86fb:7325 with SMTP id
 5b1f17b1804b1-43ba676d2e9mr26478565e9.31.1740738485830; 
 Fri, 28 Feb 2025 02:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsbhIWbppXIo3xtMtn4lblAaxCsT0GN9ZqdZGJlO5Wa1ETpaLrHumlq2MKCAe+W6NCwRDECA==
X-Received: by 2002:a05:600c:a05:b0:439:86fb:7325 with SMTP id
 5b1f17b1804b1-43ba676d2e9mr26478245e9.31.1740738485384; 
 Fri, 28 Feb 2025 02:28:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7868sm4762552f8f.24.2025.02.28.02.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 08/22] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:32 +0100
Message-ID: <20250228102747.867770-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 92 ++++++++++++++++++++++------------------------
 2 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c9e73c68cc..2a8e1aa7d12 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -537,6 +537,7 @@ typedef struct RISCVCPUDef {
     int priv_spec;
     int32_t vext_spec;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c513d7ce32d..e9d8126360e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1472,8 +1472,8 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2987,6 +2957,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 
     if (data) {
         const RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3131,6 +3102,18 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             __VA_ARGS__                                    \
+        }),                                                 \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3154,22 +3137,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1


