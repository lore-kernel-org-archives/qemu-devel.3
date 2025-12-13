Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E4CD59F53
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDHr-0006iq-7y; Fri, 12 Dec 2025 19:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ALA8aQoKCqMPDUFPRUFRVJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--marcmorcos.bounces.google.com>)
 id 1vUDHo-0006gQ-LY
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:15:00 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ALA8aQoKCqMPDUFPRUFRVJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--marcmorcos.bounces.google.com>)
 id 1vUDHm-00079Q-PG
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:15:00 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-29efd658fadso37920555ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584897; x=1766189697; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=r0/im7YjCCi+qgN9Vco+Ebkxox6sDC/emBzqJ0iO8yU=;
 b=thcDYKXrxCTmaGmKlQt9bKaxZt1JQyhwBCRO/M+a1k3EoNPOuLSO+I/zyyGsN5NClk
 UBRmRdsEInWgPUzXcEZLHg6pzbe7ktestQ1XVZFdUtctvj/sR5r3UuXCDv34t/eW/Bsx
 bZ2J98U8AUCo2Y+718lbGl6GHh+4gFFVkSXGYuPfD2AFLWGgCdRNCVH+bVQB4cWY5G3i
 qHEDBZ6lGvS6I2NGepG5nTX0CQvE/GR67cpUWHOcv2ZY1rexTirg7PCcXe408tWK33yY
 hpG4IJM6rTbN0k+Ajf7RiOhGK6yhSY3lq0k0p790TfcmRmPJGfvurvrK0Upfj3cJL1wW
 bF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584897; x=1766189697;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0/im7YjCCi+qgN9Vco+Ebkxox6sDC/emBzqJ0iO8yU=;
 b=xFjAe2oAphX0pb5aaieR7mrBmc4dhm2bEhxoYhSnsNsShn9DPckNciwFU/hucPuGVE
 EiD4G42JND49/hCB0hiEGnXhjIlKrL4ynt0OHMEvA9IvZA1k7ysiw299AQVzFTJgaHGB
 pyJFPL8hiUEhM7FMRjVozNp4IHbc16phJgAY/AsJgmMhv/D+Z/1fwRh9i6dVTAcRKlrr
 sH3hh1Vus2XQBk6ysbmsqGVDIpBRFzqV31HfJ4DWiIcJx224sht/t7a+yjDJRWj9/Qxf
 ZCtf6WT/J+VUYmKZyXGipXzdPMKjmJdKu/5G1uJEK8cvV2lXwfdHzF3A2IaJwXBqohK0
 l5RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHhLO92BbflKZGge6hnVdEYm39rzSBrn1b3DgVJfklg3f7JMiMpFyOfzKv56S9RdEQrdZ0Ig1fcD6K@nongnu.org
X-Gm-Message-State: AOJu0YwJtDIqXwRabCgJCXUoLCwm2GcNyTPrMQ8kuYwobyro0VOEkKMU
 JlXYhxA3BgOOKysP/FsU9Evz59qM5hV41+niAW6l75Mw3CGOPm0/OFpCHmGlsbt/Diji/uQBiq5
 +Znq6rKCtf9qjAqnr1R7ZQg==
X-Google-Smtp-Source: AGHT+IGP+nbj+TPXEpjND5WvAvwQyuoZEIuskWGCKNVI2224dHhTfkISQO4miX5JQWLAWdIhcNFv/TjfUJgNAbxi
X-Received: from dlbcj13.prod.google.com ([2002:a05:7022:698d:b0:11a:51f9:d69])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b886:b0:11d:ef84:6cff with SMTP id
 a92af1059eb24-11f34c56ff8mr2376497c88.37.1765584896801; 
 Fri, 12 Dec 2025 16:14:56 -0800 (PST)
Date: Sat, 13 Dec 2025 00:14:43 +0000
In-Reply-To: <20251213001443.2041258-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001443.2041258-5-marcmorcos@google.com>
Subject: [PATCH 4/4] apic: Make apicbase accesses atomic to fix data race
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3ALA8aQoKCqMPDUFPRUFRVJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--marcmorcos.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

A data race on APICCommonState->apicbase was detected by ThreadSanitizer.

To resolve this race, direct accesses to s->apicbase are converted
to use the appropriate qatomic_*__nocheck() atomic operations. This
ensures that reads and writes are properly ordered and visible across threads.

This patch depends on the previous commit changing the type of `apicbase`
to `uint64_t`.

The race was identified by the following TSAN report:

==================
WARNING: ThreadSanitizer: data race
  Read of size 8 at ... by main thread:
    #0 cpu_is_apic_enabled hw/intc/apic_common.c:75:15
    ...
    #15 main_loop_wait util/main-loop.c:600:5
    ...

  Previous write of size 8 at ... by thread T7 'CPU 0/KVM':
    #0 kvm_apic_set_base hw/i386/kvm/apic.c:101:17
    #1 cpu_set_apic_base hw/intc/apic_common.c:47:16
    #2 kvm_arch_post_run target/i386/kvm/kvm.c:5621:5
    #3 kvm_cpu_exec accel/kvm/kvm-all.c:3229:17
    #4 kvm_vcpu_thread_fn accel/kvm/kvm-accel-ops.c:51:17
    ...
SUMMARY: ThreadSanitizer: data race hw/intc/apic_common.c:75:15 in cpu_is_apic_enabled
==================

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 hw/i386/kvm/apic.c    | 12 ++++++++----
 hw/intc/apic_common.c | 20 ++++++++++++--------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 82355f0463..b9b03c529f 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -34,9 +34,10 @@ static inline uint32_t kvm_apic_get_reg(struct kvm_lapic_state *kapic,
 static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
 {
     int i;
+    uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);
 
     memset(kapic, 0, sizeof(*kapic));
-    if (kvm_has_x2apic_api() && s->apicbase & MSR_IA32_APICBASE_EXTD) {
+    if (kvm_has_x2apic_api() && apicbase & MSR_IA32_APICBASE_EXTD) {
         kvm_apic_set_reg(kapic, 0x2, s->initial_apic_id);
     } else {
         kvm_apic_set_reg(kapic, 0x2, s->id << 24);
@@ -63,8 +64,9 @@ static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic
 void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
 {
     int i, v;
+    uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);
 
-    if (kvm_has_x2apic_api() && s->apicbase & MSR_IA32_APICBASE_EXTD) {
+    if (kvm_has_x2apic_api() && apicbase & MSR_IA32_APICBASE_EXTD) {
         assert(kvm_apic_get_reg(kapic, 0x2) == s->initial_apic_id);
     } else {
         s->id = kvm_apic_get_reg(kapic, 0x2) >> 24;
@@ -97,7 +99,7 @@ void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
 
 static int kvm_apic_set_base(APICCommonState *s, uint64_t val)
 {
-    s->apicbase = val;
+    qatomic_set__nocheck(&s->apicbase, val);
     return 0;
 }
 
@@ -140,12 +142,14 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data data)
     APICCommonState *s = data.host_ptr;
     struct kvm_lapic_state kapic;
     int ret;
+    uint64_t apicbase;
 
     if (is_tdx_vm()) {
         return;
     }
 
-    kvm_put_apicbase(s->cpu, s->apicbase);
+    apicbase = qatomic_read__nocheck(&s->apicbase);
+    kvm_put_apicbase(s->cpu, apicbase);
     kvm_put_apic_state(s, &kapic);
 
     ret = kvm_vcpu_ioctl(CPU(s->cpu), KVM_SET_LAPIC, &kapic);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 1e9aba2e48..9e42189d8a 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -52,8 +53,9 @@ int cpu_set_apic_base(APICCommonState *s, uint64_t val)
 uint64_t cpu_get_apic_base(APICCommonState *s)
 {
     if (s) {
-        trace_cpu_get_apic_base((uint64_t)s->apicbase);
-        return s->apicbase;
+        uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);
+        trace_cpu_get_apic_base(apicbase);
+        return apicbase;
     } else {
         trace_cpu_get_apic_base(MSR_IA32_APICBASE_BSP);
         return MSR_IA32_APICBASE_BSP;
@@ -66,7 +68,7 @@ bool cpu_is_apic_enabled(APICCommonState *s)
         return false;
     }
 
-    return s->apicbase & MSR_IA32_APICBASE_ENABLE;
+    return qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_ENABLE;
 }
 
 void cpu_set_apic_tpr(APICCommonState *s, uint8_t val)
@@ -223,9 +225,9 @@ void apic_designate_bsp(APICCommonState *s, bool bsp)
     }
 
     if (bsp) {
-        s->apicbase |= MSR_IA32_APICBASE_BSP;
+        qatomic_fetch_or(&s->apicbase, MSR_IA32_APICBASE_BSP);
     } else {
-        s->apicbase &= ~MSR_IA32_APICBASE_BSP;
+        qatomic_fetch_and(&s->apicbase, ~MSR_IA32_APICBASE_BSP);
     }
 }
 
@@ -235,8 +237,9 @@ static void apic_reset_common(DeviceState *dev)
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
     uint64_t bsp;
 
-    bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
-    s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
+    bsp = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_BSP;
+    qatomic_set__nocheck(&s->apicbase,
+                    APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE);
     s->id = s->initial_apic_id;
 
     kvm_reset_irq_delivered();
@@ -405,7 +408,8 @@ static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
     APICCommonState *s = APIC_COMMON(obj);
     uint32_t value;
 
-    value = s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id : s->id;
+    value = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_EXTD ?
+            s->initial_apic_id : s->id;
     visit_type_uint32(v, name, &value, errp);
 }
 
-- 
2.52.0.239.gd5f0c6e74e-goog


