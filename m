Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L0R-0001Ix-Qg; Fri, 25 Apr 2025 11:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L04-0000gk-UT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L02-0003d6-HM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso1598092f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594995; x=1746199795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDxkbdkyL4GcSfv3jwWo9uDXk+Gdi7zDW5D89ScTwDs=;
 b=qQqlNUwMh4dYecWZd4Dzw71YSh9dHSedf7PZkP5VQm6u7Fr5r2durkvXWKo1lVHwiK
 pFYA+OBSzoFQgw4VxZqYLNi4k5sgRWfb1T7Qnu7rLtmpeBLg1fya8PLUw6hWObCbdGUS
 RttWyriR3ewU2zjoKrsnUjJo3MnwSt/oW1Xag7mscFe0quvQ4kQvKWJD4jqh8vuUfs1Q
 AaD//5dpxn86aRLWFB9gkzBN6G7bcO4s22Ys2wuS9MgLbCDP2lq3EcYaTRkGyaXaT4HM
 pMV1m8TGpIwPaj10FjG5wM0uzGFso6eRAV4sQDO1oZLrv157soX9htWuyyG7ESGoxSAz
 VJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594995; x=1746199795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDxkbdkyL4GcSfv3jwWo9uDXk+Gdi7zDW5D89ScTwDs=;
 b=ChgQAL5orNMqKQIhtjM7NLr1JLJDg1IW+myzBwbP1UzjIq4EnEZ39B9PIvJL+g5tfW
 t2Gj0FCoQXePqbWg8vsRXoNLla93adNUWxPaOvB0JicCq598aFFTcmjvkF84mg4f+yM6
 uQAn/Y0Y1uzpct2wGSjYU+sszQK5rVuNsxO/+bY3IPNm7acfxDPc/9mnLGqL99SAIU1e
 3Z5C8usy6zIsgq9EnzNq6sKjWvfQZVG8N/NLE3w1jL3Hzne0QhQMYFaUlQiGbr6lB7id
 VIuoxuYJ3Kny8e7Cg1Wi6YlUOAzQvGMZZWFWZz9g+R6TgyM40kUzGi9Etohb6zFbeY5k
 KlTQ==
X-Gm-Message-State: AOJu0YzmWca3ZvhFZyyHYnlVFpAMm3S7RqNwgPtoR+hNkXU8grXb3vqj
 GIUnc1YewoqTYORwPpSPwnXdwz8B5z2Z9T0B1PCXyLNAPmHrc7BLKbj1gFNZdRJK+EADt29rgzi
 5
X-Gm-Gg: ASbGncseToouYcWpMiJ+DvrSC6iHvFR/HxOPFXNmJ9cAsh01AS02damtBZnbltP+zv4
 kw5Ag3+62/L5lL/Pi9aPzKcbgc4Rhca97ULHmnFJmFQNY8qKmkY6Bj8qW/uJAAL4PqxacDOOKlx
 /9l6IHUnRZi/4Nc+CRNL7QNBYWB9q+Wa1tSsKw2zdg4S8NdCXl27LV0deTg3IWe7jGeOha+Q6/V
 Ou681mLocYB9xDsV7c+sk+HUurr+tr8rZSKkvFSCVZIGVJbTvEBvo6mjHjn8/m4U9+rd5zAO7Zm
 TzWR0TRCoGhC3hAoxyj3deEU7FYRFP1yP5RdoTmWnBHE26rSwKFjyDuWsDROF/oz6tN35s2QJ4S
 P2PWccXnKpANrWjPRRMoATQmqJw==
X-Google-Smtp-Source: AGHT+IHtD0eUm4V4gIpr0vWhkpcGYZiI5AwILRSAGTiZcQV9opHY2KZ6UyqTUrrpZnPrmzRO+PBs0g==
X-Received: by 2002:adf:e290:0:b0:3a0:77d0:b96 with SMTP id
 ffacd0b85a97d-3a077d00de1mr1131141f8f.6.1745594995327; 
 Fri, 25 Apr 2025 08:29:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c7d1sm2611004f8f.83.2025.04.25.08.29.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/58] qom: Constify TypeInfo::class_data
Date: Fri, 25 Apr 2025 17:27:58 +0200
Message-ID: <20250425152843.69638-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All callers now correctly expect a const class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250424194905.82506-5-philmd@linaro.org>
---
 include/qom/object.h                                | 2 +-
 hw/arm/armsse.c                                     | 2 +-
 hw/block/m25p80.c                                   | 2 +-
 hw/isa/vt82c686.c                                   | 4 ++--
 hw/net/e1000.c                                      | 2 +-
 hw/ppc/spapr_cpu_core.c                             | 2 +-
 hw/scsi/megasas.c                                   | 2 +-
 hw/sensor/tmp421.c                                  | 2 +-
 hw/virtio/virtio-pci.c                              | 4 ++--
 qom/object.c                                        | 2 +-
 target/arm/cpu.c                                    | 2 +-
 target/arm/cpu64.c                                  | 2 +-
 target/mips/cpu.c                                   | 2 +-
 target/s390x/cpu_models.c                           | 4 ++--
 target/sparc/cpu.c                                  | 2 +-
 target/xtensa/helper.c                              | 2 +-
 rust/qemu-api/src/qom.rs                            | 2 +-
 scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
 18 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2fb86f00a68..42b75d10a43 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -488,7 +488,7 @@ struct TypeInfo
 
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
-    void *class_data;
+    const void *class_data;
 
     InterfaceInfo *interfaces;
 };
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index d65a46b8d8d..9403b65ddb5 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1730,7 +1730,7 @@ static void armsse_register_types(void)
             .name = armsse_variants[i].name,
             .parent = TYPE_ARM_SSE,
             .class_init = armsse_class_init,
-            .class_data = (void *)&armsse_variants[i],
+            .class_data = &armsse_variants[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 75b9d712518..a5336d92ff9 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1893,7 +1893,7 @@ static void m25p80_register_types(void)
             .name       = known_devices[i].part_name,
             .parent     = TYPE_M25P80,
             .class_init = m25p80_class_init,
-            .class_data = (void *)&known_devices[i],
+            .class_data = &known_devices[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 80366aaf647..c62afc907b2 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -259,7 +259,7 @@ static const TypeInfo vt82c686b_pm_info = {
     .name          = TYPE_VT82C686B_PM,
     .parent        = TYPE_VIA_PM,
     .class_init    = via_pm_class_init,
-    .class_data    = (void *)&vt82c686b_pm_init_info,
+    .class_data    = &vt82c686b_pm_init_info,
 };
 
 static const ViaPMInitInfo vt8231_pm_init_info = {
@@ -272,7 +272,7 @@ static const TypeInfo vt8231_pm_info = {
     .name          = TYPE_VT8231_PM,
     .parent        = TYPE_VIA_PM,
     .class_init    = via_pm_class_init,
-    .class_data    = (void *)&vt8231_pm_init_info,
+    .class_data    = &vt8231_pm_init_info,
 };
 
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index d49730f4ad4..13814e84d18 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1770,7 +1770,7 @@ static void e1000_register_types(void)
 
         type_info.name = info->name;
         type_info.parent = TYPE_E1000_BASE;
-        type_info.class_data = (void *)info;
+        type_info.class_data = info;
         type_info.class_init = e1000_class_init;
 
         type_register_static(&type_info);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b4b926d759a..4952f9bd2cf 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -388,7 +388,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, const void *data)
 #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
     {                                                   \
         .parent = TYPE_SPAPR_CPU_CORE,                  \
-        .class_data = (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
+        .class_data = POWERPC_CPU_TYPE_NAME(cpu_model), \
         .class_init = spapr_cpu_core_class_init,        \
         .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
     }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index ffcabd5a8e9..b024905a01f 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2572,7 +2572,7 @@ static void megasas_register_types(void)
 
         type_info.name = info->name;
         type_info.parent = TYPE_MEGASAS_BASE;
-        type_info.class_data = (void *)info;
+        type_info.class_data = info;
         type_info.class_init = megasas_class_init;
         type_info.interfaces = info->interfaces;
 
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 263bfa1bbda..3421c440869 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -382,7 +382,7 @@ static void tmp421_register_types(void)
             .name       = devices[i].name,
             .parent     = TYPE_TMP421,
             .class_init = tmp421_class_init,
-            .class_data = (void *) &devices[i],
+            .class_data = &devices[i],
         };
         type_register_static(&ti);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c0fd3db0630..95bf7ddd972 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2497,13 +2497,13 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 
         generic_type_info.parent = base_name;
         generic_type_info.class_init = virtio_pci_base_class_init;
-        generic_type_info.class_data = (void *)t;
+        generic_type_info.class_data = t;
 
         assert(!t->non_transitional_name);
         assert(!t->transitional_name);
     } else {
         base_type_info.class_init = virtio_pci_base_class_init;
-        base_type_info.class_data = (void *)t;
+        base_type_info.class_data = t;
     }
 
     type_register_static(&base_type_info);
diff --git a/qom/object.c b/qom/object.c
index 06d7367032e..425ee2f0ee8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -57,7 +57,7 @@ struct TypeImpl
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
 
-    void *class_data;
+    const void *class_data;
 
     void (*instance_init)(Object *obj);
     void (*instance_post_init)(Object *obj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81257f20fd7..00577f97eb6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2758,7 +2758,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .parent = TYPE_ARM_CPU,
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = (void *)info,
+        .class_data = info,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1184c92b4c0..eaf5705cdc2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -855,7 +855,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
         .parent = TYPE_AARCH64_CPU,
         .instance_init = aarch64_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = (void *)info,
+        .class_data = info,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 29611a0a1c3..d13361a1507 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -626,7 +626,7 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
         .name = typename,
         .parent = TYPE_MIPS_CPU,
         .class_init = mips_cpu_cpudef_class_init,
-        .class_data = (void *)def,
+        .class_data = def,
     };
 
     type_register_static(&ti);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b097ed55d9d..8951f1b36f9 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1072,7 +1072,7 @@ static void register_types(void)
             .instance_init = s390_cpu_model_initfn,
             .instance_finalize = s390_cpu_model_finalize,
             .class_init = s390_base_cpu_model_class_init,
-            .class_data = (void *) &s390_cpu_defs[i],
+            .class_data = &s390_cpu_defs[i],
         };
         char *name = s390_cpu_type_name(s390_cpu_defs[i].name);
         TypeInfo ti = {
@@ -1081,7 +1081,7 @@ static void register_types(void)
             .instance_init = s390_cpu_model_initfn,
             .instance_finalize = s390_cpu_model_finalize,
             .class_init = s390_cpu_model_class_init,
-            .class_data = (void *) &s390_cpu_defs[i],
+            .class_data = &s390_cpu_defs[i],
         };
 
         type_register_static(&ti_base);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 981aa86e0e0..bc753d5f627 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1104,7 +1104,7 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
         .name = typename,
         .parent = TYPE_SPARC_CPU,
         .class_init = sparc_cpu_cpudef_class_init,
-        .class_data = (void *)def,
+        .class_data = def,
     };
 
     type_register_static(&ti);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 04597879815..2d93b45036d 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -192,7 +192,7 @@ void xtensa_register_core(XtensaConfigList *node)
     TypeInfo type = {
         .parent = TYPE_XTENSA_CPU,
         .class_init = xtensa_core_class_init,
-        .class_data = (void *)node->config,
+        .class_data = node->config,
     };
 
     xtensa_finalize_config(node->config);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f385cb72753..f0a79f96d5e 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -513,7 +513,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_size: core::mem::size_of::<Self::Class>(),
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
-        class_data: core::ptr::null_mut(),
+        class_data: core::ptr::null(),
         interfaces: core::ptr::null_mut(),
     };
 
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 72113927960..08857c5008d 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -70,7 +70,7 @@ def fullmatch(regexp, s):
             .name = armsse_variants[i].name,
             .parent = TYPE_ARMSSE,
             .class_init = armsse_class_init,
-            .class_data = (void *)&armsse_variants[i],
+            .class_data = &armsse_variants[i],
         };''', re.MULTILINE)
 
     print(RE_ARRAY_ITEM)
-- 
2.47.1


