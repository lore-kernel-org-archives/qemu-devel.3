Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5C0D4336C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTuI8-0004yo-3m; Thu, 11 Dec 2025 22:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3v087aQoKCpwI6N8IKN8KOCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--marcmorcos.bounces.google.com>)
 id 1vTppL-0005NU-Os
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:12:03 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3v087aQoKCpwI6N8IKN8KOCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--marcmorcos.bounces.google.com>)
 id 1vTppJ-0001n3-F9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:12:03 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-29848363458so11341875ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 15:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765494719; x=1766099519; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=u8q7tz7MTCZpiE+hr1G09G0ZNAT74W5WhBdcbpt6Uyc=;
 b=oUlyBnpLLp86y5BmQElw1BE/9AN0TPZzQAibzwj7G4THCdEflL8mWQM3Vr5L5VOYfw
 ri33tJXDi/HTPOcvRR4rF7CGxHw5hVbxS946Gf55xmVza0EjXRvvgh5PC0VeQp07OrBo
 L8uHcX+NbivbxMsimo47gNCGfX3qbfEPNdi8z2epVweBzLtpQmPNf4jTEWEKWKnFNESV
 CpiCD3p4gSEDhnu+q4rrxI8eObJl3/vwO3lsfyCHcW0jGF0ij8ktxPF5H8fv/CRO3SKF
 m47xsL/BDyYBvWXpDK3Ur46YaxCAneXlQnZbktMesWZQNQS4O57Uil8YgF8Tcf/TRpyk
 OmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765494719; x=1766099519;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8q7tz7MTCZpiE+hr1G09G0ZNAT74W5WhBdcbpt6Uyc=;
 b=ReUuzjYgEnmuiQxixSTGRi7qe45sQ/+ftZr2QyrnZZtEZpMM/ykPaEEuOq9d04xdkO
 OuXKHH2iVAf+9XxsxBO07LdS6zSLF/+QiBqx8gP8pIOcqe9K5Q5/4og9v13VGAOt4y6R
 u/IcwBTNe6kd8WifMeyOjSu4YLIj1duK0rPpDRQJ0W6Ib3+i8LdE4BIggxsylQjDviY/
 Tu5UBurhJs7yGZJZijb+zuPhUflv4wVY5sA5S4d7sXZiRBNDGFvbLLohM2ya6CKowxbE
 py6qq5W0CAX75H+GeOLiwyLt6jZyLak/KPTbpPmnRXbMZqJdMoxUjaSCEsevpgIoFB0D
 mBZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUArvK1lPDI5OK8GOh60+FoRtJziNaBws37l02Tsa3kjLeOurL/F5AZxKBEnkPMxboDYO0PIaw3MGqZ@nongnu.org
X-Gm-Message-State: AOJu0Yzyp0cDm3TaxLMVROHZwnk4St3uYX89h2Av0J6TPlwCK4f0j6/X
 j7zRyoHJNclAwe/me3JdYhDh8hUzv62v+PB2x7QmfYx2bQDbjtRLr4EyCezwnAhKiZTtg7ZO0XN
 ny/Bqn+KCWAVsI/dUwwHmmg==
X-Google-Smtp-Source: AGHT+IE5pLeBwdArBsE+j6udxvXcGptSEZ+AR0VZv2EJk0A+Trdkq7kQsmX3hvMeFfcwnT4gc+kxk+BF832VBvm9
X-Received: from dlbdx13.prod.google.com ([2002:a05:7022:e0d:b0:119:49ca:6b84])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7f02:b0:119:e56c:18a0 with SMTP id
 a92af1059eb24-11f34ac1ae1mr122805c88.8.1765494719034; 
 Thu, 11 Dec 2025 15:11:59 -0800 (PST)
Date: Thu, 11 Dec 2025 23:11:55 +0000
In-Reply-To: <20251211231155.1171717-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251211231155.1171717-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251211231155.1171717-2-marcmorcos@google.com>
Subject: [PATCH 1/1] qemu: TSAN Clean up
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
 envelope-from=3v087aQoKCpwI6N8IKN8KOCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--marcmorcos.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:58:02 -0500
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

- Fix 3 thread races detected by tsan
- Change apicbase to 64 bit variable to reflect what it holds

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 hw/i386/kvm/apic.c              | 12 ++++++++----
 hw/intc/apic_common.c           | 24 ++++++++++++++----------
 include/hw/i386/apic_internal.h |  2 +-
 monitor/monitor.c               |  8 +++++++-
 monitor/qmp.c                   |  2 ++
 target/i386/kvm/kvm.c           |  3 +++
 util/thread-pool.c              | 24 +++++++++++-------------
 7 files changed, 46 insertions(+), 29 deletions(-)

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
index ec9e978b0b..9e42189d8a 100644
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
 
@@ -233,10 +235,11 @@ static void apic_reset_common(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-    uint32_t bsp;
+    uint64_t bsp;
 
-    bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
-    s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
+    bsp = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_BSP;
+    qatomic_set__nocheck(&s->apicbase,
+                    APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE);
     s->id = s->initial_apic_id;
 
     kvm_reset_irq_delivered();
@@ -363,7 +366,7 @@ static const VMStateDescription vmstate_apic_common = {
     .post_load = apic_dispatch_post_load,
     .priority = MIG_PRI_APIC,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(apicbase, APICCommonState),
+        VMSTATE_UINT64(apicbase, APICCommonState),
         VMSTATE_UINT8(id, APICCommonState),
         VMSTATE_UINT8(arb_id, APICCommonState),
         VMSTATE_UINT8(tpr, APICCommonState),
@@ -405,7 +408,8 @@ static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
     APICCommonState *s = APIC_COMMON(obj);
     uint32_t value;
 
-    value = s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id : s->id;
+    value = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_EXTD ?
+            s->initial_apic_id : s->id;
     visit_type_uint32(v, name, &value, errp);
 }
 
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4..32ce2c821e 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -158,7 +158,7 @@ struct APICCommonState {
 
     MemoryRegion io_memory;
     X86CPU *cpu;
-    uint32_t apicbase;
+    uint64_t apicbase; /* All accesses to apicbase must use qatomic helpers. */
     uint8_t id; /* legacy APIC ID */
     uint32_t initial_apic_id;
     uint8_t version;
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d30877..f3bc4f0202 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -338,15 +338,21 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     Monitor *mon;
     MonitorQMP *qmp_mon;
+    bool send;
 
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
+        qemu_mutex_lock(&mon->mon_lock);
         if (!monitor_is_qmp(mon)) {
+            qemu_mutex_unlock(&mon->mon_lock);
             continue;
         }
 
         qmp_mon = container_of(mon, MonitorQMP, common);
-        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
+        send = qmp_mon->commands != &qmp_cap_negotiation_commands;
+        qemu_mutex_unlock(&mon->mon_lock);
+
+        if (send) {
             qmp_send_response(qmp_mon, qdict);
         }
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index cb99a12d94..73c2fb8cbf 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -462,9 +462,11 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
+        qemu_mutex_lock(&mon->common.mon_lock);
         mon->commands = &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
         data = qmp_greeting(mon);
+        qemu_mutex_unlock(&mon->common.mon_lock);
         qmp_send_response(mon, data);
         qobject_unref(data);
         break;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..76bdef2c78 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5474,7 +5474,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     int ret;
+    bool nmi_pending = false;
+    bool smi_pending = false;
 
+    bql_lock();
     /* Inject NMI */
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
diff --git a/util/thread-pool.c b/util/thread-pool.c
index d2ead6b728..af49d4dfd9 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -18,6 +18,7 @@
 #include "qemu/defer-call.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/atomic.h"
 #include "qemu/coroutine.h"
 #include "trace.h"
 #include "block/thread-pool.h"
@@ -39,9 +40,9 @@ struct ThreadPoolElementAio {
     ThreadPoolFunc *func;
     void *arg;
 
-    /* Moving state out of THREAD_QUEUED is protected by lock.  After
-     * that, only the worker thread can write to it.  Reads and writes
-     * of state and ret are ordered with memory barriers.
+    /*
+     * All access to state must be atomic,
+     * Use acquire/release ordering if relevant
      */
     enum ThreadState state;
     int ret;
@@ -105,15 +106,14 @@ static void *worker_thread(void *opaque)
 
         req = QTAILQ_FIRST(&pool->request_list);
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
-        req->state = THREAD_ACTIVE;
+        qatomic_set(&req->state, THREAD_ACTIVE);
         qemu_mutex_unlock(&pool->lock);
 
         ret = req->func(req->arg);
 
         req->ret = ret;
-        /* Write ret before state.  */
-        smp_wmb();
-        req->state = THREAD_DONE;
+        /* _release to write ret before state.  */
+        qatomic_store_release(&req->state, THREAD_DONE);
 
         qemu_bh_schedule(pool->completion_bh);
         qemu_mutex_lock(&pool->lock);
@@ -180,7 +180,8 @@ static void thread_pool_completion_bh(void *opaque)
 
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
-        if (elem->state != THREAD_DONE) {
+        /* _acquire to read state before ret.  */
+        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
             continue;
         }
 
@@ -189,9 +190,6 @@ restart:
         QLIST_REMOVE(elem, all);
 
         if (elem->common.cb) {
-            /* Read state before ret.  */
-            smp_rmb();
-
             /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
              * wait for another request that completed at the same time.
              */
@@ -223,11 +221,11 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     trace_thread_pool_cancel_aio(elem, elem->common.opaque);
 
     QEMU_LOCK_GUARD(&pool->lock);
-    if (elem->state == THREAD_QUEUED) {
+    if (qatomic_read(&elem->state) == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
         qemu_bh_schedule(pool->completion_bh);
 
-        elem->state = THREAD_DONE;
+        qatomic_set(&elem->state, THREAD_DONE);
         elem->ret = -ECANCELED;
     }
 
-- 
2.52.0.239.gd5f0c6e74e-goog


