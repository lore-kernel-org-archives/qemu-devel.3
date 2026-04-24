Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F92DFDEE53
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG43X-0006gI-L5; Thu, 23 Apr 2026 20:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43W-0006fm-1P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:06:02 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43T-0000z1-IP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:06:01 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2d9916deb14so12928898eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776989158; x=1777593958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=romhlJbT++e95ezZHaRqmY4KWUmngLYBLnwDrcI19RA=;
 b=j6O1imUGACXpj0y1l+Ez0T5qpdBx5+K5Nlv0Q3muemBZvcc0GnClN+0zwz1znejNmd
 9r+4GCm467fbXEWqj2zPv8bQkIm8/6fUlqrAfkTuay0wYYneUY0BI4XBtqYzct+/GUEc
 iQ+kAzO7fy7kMWrGxQ09LkFjcIQ0Ttv3LwoLOE1e601Zm6KsAKuOQRuKBJl++sHc4XD/
 ZSCulCttBNDl23TjctYtQc/enKqiVD49flMejKAtE8Yqi2bjledieBmDbEYqpQBQJI6l
 mkdRYGHQwGiriSEtXt5WacqTIK1P7RzWRA4O0IF3CYiisocGNAdoz2fxXZMt5AKOqA1L
 URjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776989158; x=1777593958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=romhlJbT++e95ezZHaRqmY4KWUmngLYBLnwDrcI19RA=;
 b=nWagFQDbNjtJLBk7KEUklA8IIrHDFsj5NQlPndKWRPQfeadfIExd5nQCxNGOzUvDlK
 GDIjyr/K44X997vKtkqRt4ExJCR211a0jhOBz0wnE95q4MgygLqI2+zIahU9R91oqg38
 g0Ejpjvn+85bxazkgbCgtFeQljub1mK52jjehTgFe5dA4aiZCSj85U+V+IUnLw302Y79
 XRCDwZ8qzH3EvlN0E1DEuy+wRw2aQSPQYj6XVQKwjdjc16XU43JujHRErkVdS1MYfzKC
 i433HfVN6SLDJj55AooOOwMI+H7Pu3gvkpqsYJkO9YXIlGJUmUBVKe6Bggf8s3A15KRO
 uHcQ==
X-Gm-Message-State: AOJu0YxZGa35sGVsPKUqjdKGKFeQ1eaGO6zPKrJXTHB+lj33ozIB4d0F
 ps9WlxuYAvY8d3c3Ypz9TG/AL4O1H4T0DqvEVjO9tFV2+xbL9PiyjmiOPJhfcOrbCio=
X-Gm-Gg: AeBDieusfoiXf0UWx+Hre5p5Xra2jeYkKcqVZSVTQS05U9zyKc6d7qMcntB6PZEdxwA
 GezBQ0Lq+/UhoSRMk95ashUVJLyUbXE+9bPN+3jLVUpMqthryD9gaOCAdaeeFSut7xyhI9nFfo/
 wOZqsBCACHqIsgtIHGZhOwaRgKagU7U8ArJvuC9Lbyxpkhd4mKL5MZqTpG3BXn7rZ0qBuJvkRWC
 SWxewU7ov26SfmQE1fDmmW9GkxIPMe3+pMSr0RwU7Bz/78pkMSKxSHtJ+Sr5doPkiK2EdbxTe3t
 RY+8bcwrlqzQuD0bja2VmHhZd7dDZCAjCmaKfj3tuLyyLcLlJrGhvOzQ/tc8aH69tXfS2Pk+6ct
 QdlzldLX6Y8A5yIQHp21CWVzf5Nt138ZnDE8cc4/SHoLcELafrwMuUm9fONt72Mt/7W9059Fhv0
 X1BhxTcDBhEVS6yTs2M//LSCTqpKjj2qPF12Jcg2KyFk5SFfwHcYqYIKFfMBL/ikr8qqtkZGUd
X-Received: by 2002:a05:7300:5728:b0:2be:2953:fd74 with SMTP id
 5a478bee46e88-2e479723e13mr16627599eec.14.1776989157771; 
 Thu, 23 Apr 2026 17:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ea8e4b373dsm12958055eec.6.2026.04.23.17.05.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 17:05:57 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 2/3] accel/hvf: introduce map granule abstraction and IPA
 property
Date: Thu, 23 Apr 2026 21:05:43 -0300
Message-ID: <20260424000544.9617-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424000544.9617-1-lucaaamaral@gmail.com>
References: <20260424000544.9617-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a map granule abstraction that decouples HVF memory mapping
alignment from the host page size.  On ARM64, Apple Silicon supports
stage-2 translation with 4KB page granules regardless of the host OS
page size (16KB on macOS).  This allows running guests with 4KB pages
without interior mapping failures.

Introduce hvf_set_map_granule()/hvf_get_map_granule() in hvf-all.c
to replace hard-coded qemu_real_host_page_size() references in
do_hv_vm_protect() and hvf_set_phys_mem().  When the granule is not
explicitly configured, fall back to host page size to preserve the
previous behaviour.

Add an "ipa-granule" accelerator property (auto, 4k, 16k) following
the established kvm_arch_accel_class_init() pattern: ARM registers
the property in hvf_arch_accel_class_init(), x86 provides an empty
stub.  This avoids #ifdef __aarch64__ in common code while keeping
a single hvf-all.c shared by both targets.

Fix hvf_set_phys_mem() to return early for non-aligned regions instead
of clearing the add flag, which previously fell through to an
incorrect unmap of a region that was never mapped.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 accel/hvf/hvf-all.c      | 30 +++++++++++++++++++++++++++---
 include/system/hvf.h     | 15 +++++++++++++++
 include/system/hvf_int.h |  2 ++
 target/arm/hvf/hvf.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c    |  4 ++++
 5 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d..d745fefd 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
 #include "system/address-spaces.h"
@@ -22,6 +24,21 @@
 
 bool hvf_allowed;
 
+static uint64_t hvf_map_granule;
+
+void hvf_set_map_granule(uint64_t size)
+{
+    hvf_map_granule = size;
+}
+
+uint64_t hvf_get_map_granule(void)
+{
+    if (!hvf_map_granule) {
+        return qemu_real_host_page_size();
+    }
+    return hvf_map_granule;
+}
+
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
@@ -53,7 +70,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 static void do_hv_vm_protect(hwaddr start, size_t size,
                              hv_memory_flags_t flags)
 {
-    intptr_t page_mask = qemu_real_host_page_mask();
+    intptr_t page_mask = -(intptr_t)hvf_get_map_granule();
     hv_return_t ret;
 
     trace_hvf_vm_protect(start, size, flags,
@@ -83,7 +100,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     MemoryRegion *area = section->mr;
     bool writable = !area->readonly && !area->rom_device;
     hv_memory_flags_t flags;
-    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t page_size = hvf_get_map_granule();
     uint64_t gpa = section->offset_within_address_space;
     uint64_t size = int128_get64(section->size);
     hv_return_t ret;
@@ -104,7 +121,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     if (!QEMU_IS_ALIGNED(size, page_size) ||
         !QEMU_IS_ALIGNED(gpa, page_size)) {
         /* Not page aligned, so we can not map as RAM */
-        add = false;
+        return;
     }
 
     if (!add) {
@@ -186,6 +203,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    /* Resolve ipa-granule=auto → host page size */
+    if (!s->ipa_granule) {
+        s->ipa_granule = qemu_real_host_page_size();
+    }
+    hvf_set_map_granule(s->ipa_granule);
 
     if (mc->get_physical_address_range) {
         pa_range = mc->get_physical_address_range(ms,
@@ -223,6 +245,8 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+
+    hvf_arch_accel_class_init(oc);
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d3dcf088..3c4c3b89 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -36,4 +36,19 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
+#ifdef CONFIG_HVF_IS_POSSIBLE
+/*
+ * Minimum alignment for hv_vm_map().  Returns the configured IPA granule
+ * or host page size if not set.
+ */
+void hvf_set_map_granule(uint64_t size);
+uint64_t hvf_get_map_granule(void);
+#else
+static inline void hvf_set_map_granule(uint64_t size) {}
+static inline uint64_t hvf_get_map_granule(void)
+{
+    return qemu_real_host_page_size();
+}
+#endif
+
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164c..9589b022 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -38,6 +38,7 @@ struct HVFState {
 
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
+    uint32_t ipa_granule;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
 };
 extern HVFState *hvf_state;
@@ -57,6 +58,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
+void hvf_arch_accel_class_init(ObjectClass *oc);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
 void hvf_kick_vcpu_thread(CPUState *cpu);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 000e54bd..1b5860c7 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
 
 #include "system/runstate.h"
 #include "system/hvf.h"
@@ -1219,6 +1221,44 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static char *hvf_get_ipa_granule(Object *obj, Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+
+    if (s->ipa_granule == 4 * KiB) {
+        return g_strdup("4k");
+    }
+    if (s->ipa_granule == 16 * KiB) {
+        return g_strdup("16k");
+    }
+    return g_strdup("auto");
+}
+
+static void hvf_set_ipa_granule(Object *obj, const char *value, Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+
+    if (!g_strcmp0(value, "auto")) {
+        s->ipa_granule = 0;
+    } else if (!g_strcmp0(value, "4k")) {
+        s->ipa_granule = 4 * KiB;
+    } else if (!g_strcmp0(value, "16k")) {
+        s->ipa_granule = 16 * KiB;
+    } else {
+        error_setg(errp, "invalid ipa-granule: '%s' (use auto, 4k, 16k)",
+                   value);
+    }
+}
+
+void hvf_arch_accel_class_init(ObjectClass *oc)
+{
+    object_class_property_add_str(oc, "ipa-granule",
+                                  hvf_get_ipa_granule,
+                                  hvf_set_ipa_granule);
+    object_class_property_set_description(oc, "ipa-granule",
+        "IPA granule for HVF stage-2 translation (auto, 4k, 16k)");
+}
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c0d028b1..565c79b3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -228,6 +228,10 @@ int hvf_arch_init(void)
     return 0;
 }
 
+void hvf_arch_accel_class_init(ObjectClass *oc)
+{
+}
+
 /* 48-bit on all Intel Macs. Function currently unused. */
 uint32_t hvf_arch_get_default_ipa_bit_size(void)
 {
-- 
2.52.0


