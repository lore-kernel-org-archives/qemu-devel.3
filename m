Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B70C25B77
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nA-0003be-2x; Sun, 12 May 2024 06:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mz-0003Uz-1P
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mt-00068N-BP
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+BVqB9LGs3hpzmjk/f3k7oJxKyxqJ2ARrVZJ9qh9Z0=;
 b=RA4Z2l0aOG+F99cWsYYMIDNkeHTY0CTrBMZMxpRg/QVfXbBR0d2xfMTcyZQ1zBokBd/Wsh
 wajkxegdu3BbbmnScLlfkf+9hUKXas/8kHl9m7Tky+7v/Rf1Pe+epXK09vG6wpsftCiCTQ
 MhPDyrTsfqUr7GjvumeENQsYahjJ3Dw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-0_3Eve03MFCEyeCNFsCsQQ-1; Sun, 12 May 2024 06:50:36 -0400
X-MC-Unique: 0_3Eve03MFCEyeCNFsCsQQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5222a0800f0so1691357e87.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511034; x=1716115834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+BVqB9LGs3hpzmjk/f3k7oJxKyxqJ2ARrVZJ9qh9Z0=;
 b=pUb0Rd5iXq0YNzQvLLJKGWSZoKCEvLOJtG9iz3VD4tB9IC681Tb2Fi001AeLrq7XNV
 UV+GvjWejY70SK0orzYU3wIhZ3qvE1ILaK8/z3BLuEdWq/D15kGSHQanoZMsKPT+5n88
 5hAjlbRNing25V2rOuBGdUP//GWgmW4ThkRGOVkFs3d6xOKVECe2vxu0A0dNvaoCJF+y
 5pw+Sy9vMGSlUfZpB6tbjFPbMSp/iUn6to7kbbTf/RKklfUz2a9mNzTp6jRqUp5BSnut
 TBls0NGWBOagYNMS3qKqQBQU859iY7fpKJgywfbLtkhIsf3xjJkk5ImNvuPSBCn+mDf4
 rblg==
X-Gm-Message-State: AOJu0YxYuSaJCrib8nzFYYgOkHJCqPrApmjVJUl3CfBK4Ia8AVfgzCxJ
 5cbboOaesvhhnS6z6YzqtYizTRBDaSXAjtx0l306Gn8WZk6A8ujB3NBWm4H118L3uJiFCwxcIKM
 CsRIk+79Q0X/5IiPirXCqTO42gYJQ9QZDGDqQ3UGO1T1SrFpk2Xp7XroV1KEx9h1ifO4orPWoir
 +SFMJJ8iXCw5Yq8A7UrQ2v6Qt+koEQiQCTYI92
X-Received: by 2002:a05:6512:3e17:b0:51d:605e:f0ce with SMTP id
 2adb3069b0e04-52210278698mr8266813e87.50.1715511033369; 
 Sun, 12 May 2024 03:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtb9NPCUCAwmeoboYb03CaRxyMs5odhQ4YB4AIscC7xm0g2YwUW8pqClepUX0WLBgHvX4vjA==
X-Received: by 2002:a05:6512:3e17:b0:51d:605e:f0ce with SMTP id
 2adb3069b0e04-52210278698mr8266767e87.50.1715511032177; 
 Sun, 12 May 2024 03:50:32 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d9dsm442087166b.132.2024.05.12.03.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/27] hw/i386: split x86.c in multiple parts
Date: Sun, 12 May 2024 12:49:36 +0200
Message-ID: <20240512104945.130198-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep the basic X86MachineState definition in x86.c.  Move out functions that
are only needed by other files: x86-common.c for the pc and microvm machines,
x86-cpu.c for those used by accelerator code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240509170044.190795-11-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h |    6 +-
 hw/i386/x86-common.c  | 1007 +++++++++++++++++++++++++++++++++++++++
 hw/i386/x86-cpu.c     |   97 ++++
 hw/i386/x86.c         | 1052 +----------------------------------------
 hw/i386/meson.build   |    4 +-
 5 files changed, 1113 insertions(+), 1053 deletions(-)
 create mode 100644 hw/i386/x86-common.c
 create mode 100644 hw/i386/x86-cpu.c

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index c2062db13f5..b006f16b8d3 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -21,6 +21,7 @@
 #include "exec/memory.h"
 
 #include "hw/boards.h"
+#include "hw/i386/topology.h"
 #include "hw/intc/ioapic.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
@@ -109,12 +110,11 @@ struct X86MachineState {
 #define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
 OBJECT_DECLARE_TYPE(X86MachineState, X86MachineClass, X86_MACHINE)
 
-uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
+void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index);
 
-void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
 void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
-CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx);
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
new file mode 100644
index 00000000000..67b03c913a5
--- /dev/null
+++ b/hw/i386/x86-common.c
@@ -0,0 +1,1007 @@
+/*
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2019, 2024 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+#include "qemu/datadir.h"
+#include "qapi/error.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
+#include "trace.h"
+
+#include "hw/i386/x86.h"
+#include "target/i386/cpu.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/sev.h"
+
+#include "hw/acpi/cpu_hotplug.h"
+#include "hw/irq.h"
+#include "hw/loader.h"
+#include "multiboot.h"
+#include "elf.h"
+#include "standard-headers/asm-x86/bootparam.h"
+#include CONFIG_DEVICES
+#include "kvm/kvm_i386.h"
+
+#ifdef CONFIG_XEN_EMU
+#include "hw/xen/xen.h"
+#include "hw/i386/kvm/xen_evtchn.h"
+#endif
+
+/* Physical Address of PVH entry point read from kernel ELF NOTE */
+static size_t pvh_start_addr;
+
+static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
+{
+    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
+
+    if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
+        goto out;
+    }
+    qdev_realize(DEVICE(cpu), NULL, errp);
+
+out:
+    object_unref(cpu);
+}
+
+void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
+{
+    int i;
+    const CPUArchIdList *possible_cpus;
+    MachineState *ms = MACHINE(x86ms);
+    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+
+    x86_cpu_set_default_version(default_cpu_version);
+
+    /*
+     * Calculates the limit to CPU APIC ID values
+     *
+     * Limit for the APIC ID value, so that all
+     * CPU APIC IDs are < x86ms->apic_id_limit.
+     *
+     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
+     */
+    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
+                                                      ms->smp.max_cpus - 1) + 1;
+
+    /*
+     * Can we support APIC ID 255 or higher?  With KVM, that requires
+     * both in-kernel lapic and X2APIC userspace API.
+     *
+     * kvm_enabled() must go first to ensure that kvm_* references are
+     * not emitted for the linker to consume (kvm_enabled() is
+     * a literal `0` in configurations where kvm_* aren't defined)
+     */
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
+        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
+        error_report("current -smp configuration requires kernel "
+                     "irqchip and X2APIC API support.");
+        exit(EXIT_FAILURE);
+    }
+
+    if (kvm_enabled()) {
+        kvm_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
+    if (!kvm_irqchip_in_kernel()) {
+        apic_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    for (i = 0; i < ms->smp.cpus; i++) {
+        x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
+    }
+}
+
+void x86_rtc_set_cpus_count(ISADevice *s, uint16_t cpus_count)
+{
+    MC146818RtcState *rtc = MC146818_RTC(s);
+
+    if (cpus_count > 0xff) {
+        /*
+         * If the number of CPUs can't be represented in 8 bits, the
+         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
+         * to make old BIOSes fail more predictably.
+         */
+        mc146818rtc_set_cmos_data(rtc, 0x5f, 0);
+    } else {
+        mc146818rtc_set_cmos_data(rtc, 0x5f, cpus_count - 1);
+    }
+}
+
+static int x86_apic_cmp(const void *a, const void *b)
+{
+   CPUArchId *apic_a = (CPUArchId *)a;
+   CPUArchId *apic_b = (CPUArchId *)b;
+
+   return apic_a->arch_id - apic_b->arch_id;
+}
+
+/*
+ * returns pointer to CPUArchId descriptor that matches CPU's apic_id
+ * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
+ * entry corresponding to CPU's apic_id returns NULL.
+ */
+static CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
+        x86_apic_cmp);
+    if (found_cpu && idx) {
+        *idx = found_cpu - ms->possible_cpus->cpus;
+    }
+    return found_cpu;
+}
+
+void x86_cpu_plug(HotplugHandler *hotplug_dev,
+                  DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    if (x86ms->acpi_dev) {
+        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    /* increment the number of CPUs */
+    x86ms->boot_cpus++;
+    if (x86ms->rtc) {
+        x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    }
+    if (x86ms->fw_cfg) {
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
+    }
+
+    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
+    found_cpu->cpu = CPU(dev);
+out:
+    error_propagate(errp, local_err);
+}
+
+void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    int idx = -1;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    if (!x86ms->acpi_dev) {
+        error_setg(errp, "CPU hot unplug not supported without ACPI");
+        return;
+    }
+
+    x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
+    assert(idx != -1);
+    if (idx == 0) {
+        error_setg(errp, "Boot CPU is unpluggable");
+        return;
+    }
+
+    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
+                                   errp);
+}
+
+void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
+                       DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
+    found_cpu->cpu = NULL;
+    qdev_unrealize(dev);
+
+    /* decrement the number of CPUs */
+    x86ms->boot_cpus--;
+    /* Update the number of CPUs in CMOS */
+    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
+ out:
+    error_propagate(errp, local_err);
+}
+
+void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                      DeviceState *dev, Error **errp)
+{
+    int idx;
+    CPUState *cs;
+    CPUArchId *cpu_slot;
+    X86CPUTopoIDs topo_ids;
+    X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
+    MachineState *ms = MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+    unsigned int smp_cores = ms->smp.cores;
+    unsigned int smp_threads = ms->smp.threads;
+    X86CPUTopoInfo topo_info;
+
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        return;
+    }
+
+    if (x86ms->acpi_dev) {
+        Error *local_err = NULL;
+
+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(x86ms->acpi_dev), dev,
+                                 &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    init_topo_info(&topo_info, x86ms);
+
+    env->nr_dies = ms->smp.dies;
+
+    /*
+     * If APIC ID is not set,
+     * set it based on socket/die/core/thread properties.
+     */
+    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
+        int max_socket = (ms->smp.max_cpus - 1) /
+                                smp_threads / smp_cores / ms->smp.dies;
+
+        /*
+         * die-id was optional in QEMU 4.0 and older, so keep it optional
+         * if there's only one die per socket.
+         */
+        if (cpu->die_id < 0 && ms->smp.dies == 1) {
+            cpu->die_id = 0;
+        }
+
+        if (cpu->socket_id < 0) {
+            error_setg(errp, "CPU socket-id is not set");
+            return;
+        } else if (cpu->socket_id > max_socket) {
+            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
+                       cpu->socket_id, max_socket);
+            return;
+        }
+        if (cpu->die_id < 0) {
+            error_setg(errp, "CPU die-id is not set");
+            return;
+        } else if (cpu->die_id > ms->smp.dies - 1) {
+            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
+                       cpu->die_id, ms->smp.dies - 1);
+            return;
+        }
+        if (cpu->core_id < 0) {
+            error_setg(errp, "CPU core-id is not set");
+            return;
+        } else if (cpu->core_id > (smp_cores - 1)) {
+            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
+                       cpu->core_id, smp_cores - 1);
+            return;
+        }
+        if (cpu->thread_id < 0) {
+            error_setg(errp, "CPU thread-id is not set");
+            return;
+        } else if (cpu->thread_id > (smp_threads - 1)) {
+            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
+                       cpu->thread_id, smp_threads - 1);
+            return;
+        }
+
+        topo_ids.pkg_id = cpu->socket_id;
+        topo_ids.die_id = cpu->die_id;
+        topo_ids.core_id = cpu->core_id;
+        topo_ids.smt_id = cpu->thread_id;
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
+    }
+
+    cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
+    if (!cpu_slot) {
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        error_setg(errp,
+            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
+            " APIC ID %" PRIu32 ", valid index range 0:%d",
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
+            cpu->apic_id, ms->possible_cpus->len - 1);
+        return;
+    }
+
+    if (cpu_slot->cpu) {
+        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
+                   idx, cpu->apic_id);
+        return;
+    }
+
+    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
+     * so that machine_query_hotpluggable_cpus would show correct values
+     */
+    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
+     * once -smp refactoring is complete and there will be CPU private
+     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
+        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
+            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
+            topo_ids.pkg_id);
+        return;
+    }
+    cpu->socket_id = topo_ids.pkg_id;
+
+    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
+        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
+            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
+        return;
+    }
+    cpu->die_id = topo_ids.die_id;
+
+    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
+        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
+            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
+            topo_ids.core_id);
+        return;
+    }
+    cpu->core_id = topo_ids.core_id;
+
+    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
+        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
+            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
+            topo_ids.smt_id);
+        return;
+    }
+    cpu->thread_id = topo_ids.smt_id;
+
+    /*
+    * kvm_enabled() must go first to ensure that kvm_* references are
+    * not emitted for the linker to consume (kvm_enabled() is
+    * a literal `0` in configurations where kvm_* aren't defined)
+    */
+    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
+        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
+        return;
+    }
+
+    cs = CPU(cpu);
+    cs->cpu_index = idx;
+
+    numa_cpu_pre_plug(cpu_slot, dev, errp);
+}
+
+static long get_file_size(FILE *f)
+{
+    long where, size;
+
+    /* XXX: on Unix systems, using fstat() probably makes more sense */
+
+    where = ftell(f);
+    fseek(f, 0, SEEK_END);
+    size = ftell(f);
+    fseek(f, where, SEEK_SET);
+
+    return size;
+}
+
+void gsi_handler(void *opaque, int n, int level)
+{
+    GSIState *s = opaque;
+
+    trace_x86_gsi_interrupt(n, level);
+    switch (n) {
+    case 0 ... ISA_NUM_IRQS - 1:
+        if (s->i8259_irq[n]) {
+            /* Under KVM, Kernel will forward to both PIC and IOAPIC */
+            qemu_set_irq(s->i8259_irq[n], level);
+        }
+        /* fall through */
+    case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
+#ifdef CONFIG_XEN_EMU
+        /*
+         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
+         * routing actually works properly under Xen). And then to
+         * *either* the PIRQ handling or the I/OAPIC depending on
+         * whether the former wants it.
+         */
+        if (xen_mode == XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
+            break;
+        }
+#endif
+        qemu_set_irq(s->ioapic_irq[n], level);
+        break;
+    case IO_APIC_SECONDARY_IRQBASE
+        ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
+        qemu_set_irq(s->ioapic2_irq[n - IO_APIC_SECONDARY_IRQBASE], level);
+        break;
+    }
+}
+
+void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
+{
+    DeviceState *dev;
+    SysBusDevice *d;
+    unsigned int i;
+
+    assert(parent);
+    if (kvm_ioapic_in_kernel()) {
+        dev = qdev_new(TYPE_KVM_IOAPIC);
+    } else {
+        dev = qdev_new(TYPE_IOAPIC);
+    }
+    object_property_add_child(parent, "ioapic", OBJECT(dev));
+    d = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
+
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
+    }
+}
+
+DeviceState *ioapic_init_secondary(GSIState *gsi_state)
+{
+    DeviceState *dev;
+    SysBusDevice *d;
+    unsigned int i;
+
+    dev = qdev_new(TYPE_IOAPIC);
+    d = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_mmio_map(d, 0, IO_APIC_SECONDARY_ADDRESS);
+
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        gsi_state->ioapic2_irq[i] = qdev_get_gpio_in(dev, i);
+    }
+    return dev;
+}
+
+/*
+ * The entry point into the kernel for PVH boot is different from
+ * the native entry point.  The PVH entry is defined by the x86/HVM
+ * direct boot ABI and is available in an ELFNOTE in the kernel binary.
+ *
+ * This function is passed to load_elf() when it is called from
+ * load_elfboot() which then additionally checks for an ELF Note of
+ * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
+ * parse the PVH entry address from the ELF Note.
+ *
+ * Due to trickery in elf_opts.h, load_elf() is actually available as
+ * load_elf32() or load_elf64() and this routine needs to be able
+ * to deal with being called as 32 or 64 bit.
+ *
+ * The address of the PVH entry point is saved to the 'pvh_start_addr'
+ * global variable.  (although the entry point is 32-bit, the kernel
+ * binary can be either 32-bit or 64-bit).
+ */
+static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
+{
+    size_t *elf_note_data_addr;
+
+    /* Check if ELF Note header passed in is valid */
+    if (arg1 == NULL) {
+        return 0;
+    }
+
+    if (is64) {
+        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
+        uint64_t nhdr_size64 = sizeof(struct elf64_note);
+        uint64_t phdr_align = *(uint64_t *)arg2;
+        uint64_t nhdr_namesz = nhdr64->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr64) + nhdr_size64 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+
+        pvh_start_addr = *elf_note_data_addr;
+    } else {
+        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
+        uint32_t nhdr_size32 = sizeof(struct elf32_note);
+        uint32_t phdr_align = *(uint32_t *)arg2;
+        uint32_t nhdr_namesz = nhdr32->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr32) + nhdr_size32 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+
+        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
+    }
+
+    return pvh_start_addr;
+}
+
+static bool load_elfboot(const char *kernel_filename,
+                         int kernel_file_size,
+                         uint8_t *header,
+                         size_t pvh_xen_start_addr,
+                         FWCfgState *fw_cfg)
+{
+    uint32_t flags = 0;
+    uint32_t mh_load_addr = 0;
+    uint32_t elf_kernel_size = 0;
+    uint64_t elf_entry;
+    uint64_t elf_low, elf_high;
+    int kernel_size;
+
+    if (ldl_p(header) != 0x464c457f) {
+        return false; /* no elfboot */
+    }
+
+    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
+    flags = elf_is64 ?
+        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
+
+    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
+        error_report("elfboot unsupported flags = %x", flags);
+        exit(1);
+    }
+
+    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
+    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
+                           NULL, &elf_note_type, &elf_entry,
+                           &elf_low, &elf_high, NULL, 0, I386_ELF_MACHINE,
+                           0, 0);
+
+    if (kernel_size < 0) {
+        error_report("Error while loading elf kernel");
+        exit(1);
+    }
+    mh_load_addr = elf_low;
+    elf_kernel_size = elf_high - elf_low;
+
+    if (pvh_start_addr == 0) {
+        error_report("Error loading uncompressed kernel without PVH ELF Note");
+        exit(1);
+    }
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
+
+    return true;
+}
+
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled)
+{
+    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
+    uint16_t protocol;
+    int setup_size, kernel_size, cmdline_size;
+    int dtb_size, setup_data_offset;
+    uint32_t initrd_max;
+    uint8_t header[8192], *setup, *kernel;
+    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
+    FILE *f;
+    char *vmode;
+    MachineState *machine = MACHINE(x86ms);
+    struct setup_data *setup_data;
+    const char *kernel_filename = machine->kernel_filename;
+    const char *initrd_filename = machine->initrd_filename;
+    const char *dtb_filename = machine->dtb;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    SevKernelLoaderContext sev_load_ctx = {};
+
+    /* Align to 16 bytes as a paranoia measure */
+    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
+
+    /* load the kernel header */
+    f = fopen(kernel_filename, "rb");
+    if (!f) {
+        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
+                kernel_filename, strerror(errno));
+        exit(1);
+    }
+
+    kernel_size = get_file_size(f);
+    if (!kernel_size ||
+        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
+        MIN(ARRAY_SIZE(header), kernel_size)) {
+        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
+                kernel_filename, strerror(errno));
+        exit(1);
+    }
+
+    /* kernel protocol version */
+    if (ldl_p(header + 0x202) == 0x53726448) {
+        protocol = lduw_p(header + 0x206);
+    } else {
+        /*
+         * This could be a multiboot kernel. If it is, let's stop treating it
+         * like a Linux kernel.
+         * Note: some multiboot images could be in the ELF format (the same of
+         * PVH), so we try multiboot first since we check the multiboot magic
+         * header before to load it.
+         */
+        if (load_multiboot(x86ms, fw_cfg, f, kernel_filename, initrd_filename,
+                           kernel_cmdline, kernel_size, header)) {
+            return;
+        }
+        /*
+         * Check if the file is an uncompressed kernel file (ELF) and load it,
+         * saving the PVH entry point used by the x86/HVM direct boot ABI.
+         * If load_elfboot() is successful, populate the fw_cfg info.
+         */
+        if (pvh_enabled &&
+            load_elfboot(kernel_filename, kernel_size,
+                         header, pvh_start_addr, fw_cfg)) {
+            fclose(f);
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                strlen(kernel_cmdline) + 1);
+            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
+            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
+                             header, sizeof(header));
+
+            /* load initrd */
+            if (initrd_filename) {
+                GMappedFile *mapped_file;
+                gsize initrd_size;
+                gchar *initrd_data;
+                GError *gerr = NULL;
+
+                mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+                if (!mapped_file) {
+                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+                            initrd_filename, gerr->message);
+                    exit(1);
+                }
+                x86ms->initrd_mapped_file = mapped_file;
+
+                initrd_data = g_mapped_file_get_contents(mapped_file);
+                initrd_size = g_mapped_file_get_length(mapped_file);
+                initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
+                if (initrd_size >= initrd_max) {
+                    fprintf(stderr, "qemu: initrd is too large, cannot support."
+                            "(max: %"PRIu32", need %"PRId64")\n",
+                            initrd_max, (uint64_t)initrd_size);
+                    exit(1);
+                }
+
+                initrd_addr = (initrd_max - initrd_size) & ~4095;
+
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
+                                 initrd_size);
+            }
+
+            option_rom[nb_option_roms].bootindex = 0;
+            option_rom[nb_option_roms].name = "pvh.bin";
+            nb_option_roms++;
+
+            return;
+        }
+        protocol = 0;
+    }
+
+    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
+        /* Low kernel */
+        real_addr    = 0x90000;
+        cmdline_addr = 0x9a000 - cmdline_size;
+        prot_addr    = 0x10000;
+    } else if (protocol < 0x202) {
+        /* High but ancient kernel */
+        real_addr    = 0x90000;
+        cmdline_addr = 0x9a000 - cmdline_size;
+        prot_addr    = 0x100000;
+    } else {
+        /* High and recent kernel */
+        real_addr    = 0x10000;
+        cmdline_addr = 0x20000;
+        prot_addr    = 0x100000;
+    }
+
+    /* highest address for loading the initrd */
+    if (protocol >= 0x20c &&
+        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        /*
+         * Linux has supported initrd up to 4 GB for a very long time (2007,
+         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
+         * though it only sets initrd_max to 2 GB to "work around bootloader
+         * bugs". Luckily, QEMU firmware(which does something like bootloader)
+         * has supported this.
+         *
+         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
+         * be loaded into any address.
+         *
+         * In addition, initrd_max is uint32_t simply because QEMU doesn't
+         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
+         * field).
+         *
+         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
+         */
+        initrd_max = UINT32_MAX;
+    } else if (protocol >= 0x203) {
+        initrd_max = ldl_p(header + 0x22c);
+    } else {
+        initrd_max = 0x37ffffff;
+    }
+
+    if (initrd_max >= x86ms->below_4g_mem_size - acpi_data_size) {
+        initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
+    }
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
+    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
+    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
+
+    if (protocol >= 0x202) {
+        stl_p(header + 0x228, cmdline_addr);
+    } else {
+        stw_p(header + 0x20, 0xA33F);
+        stw_p(header + 0x22, cmdline_addr - real_addr);
+    }
+
+    /* handle vga= parameter */
+    vmode = strstr(kernel_cmdline, "vga=");
+    if (vmode) {
+        unsigned int video_mode;
+        const char *end;
+        int ret;
+        /* skip "vga=" */
+        vmode += 4;
+        if (!strncmp(vmode, "normal", 6)) {
+            video_mode = 0xffff;
+        } else if (!strncmp(vmode, "ext", 3)) {
+            video_mode = 0xfffe;
+        } else if (!strncmp(vmode, "ask", 3)) {
+            video_mode = 0xfffd;
+        } else {
+            ret = qemu_strtoui(vmode, &end, 0, &video_mode);
+            if (ret != 0 || (*end && *end != ' ')) {
+                fprintf(stderr, "qemu: invalid 'vga=' kernel parameter.\n");
+                exit(1);
+            }
+        }
+        stw_p(header + 0x1fa, video_mode);
+    }
+
+    /* loader type */
+    /*
+     * High nybble = B reserved for QEMU; low nybble is revision number.
+     * If this code is substantially changed, you may want to consider
+     * incrementing the revision.
+     */
+    if (protocol >= 0x200) {
+        header[0x210] = 0xB0;
+    }
+    /* heap */
+    if (protocol >= 0x201) {
+        header[0x211] |= 0x80; /* CAN_USE_HEAP */
+        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
+    }
+
+    /* load initrd */
+    if (initrd_filename) {
+        GMappedFile *mapped_file;
+        gsize initrd_size;
+        gchar *initrd_data;
+        GError *gerr = NULL;
+
+        if (protocol < 0x200) {
+            fprintf(stderr, "qemu: linux kernel too old to load a ram disk\n");
+            exit(1);
+        }
+
+        mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+        if (!mapped_file) {
+            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+                    initrd_filename, gerr->message);
+            exit(1);
+        }
+        x86ms->initrd_mapped_file = mapped_file;
+
+        initrd_data = g_mapped_file_get_contents(mapped_file);
+        initrd_size = g_mapped_file_get_length(mapped_file);
+        if (initrd_size >= initrd_max) {
+            fprintf(stderr, "qemu: initrd is too large, cannot support."
+                    "(max: %"PRIu32", need %"PRId64")\n",
+                    initrd_max, (uint64_t)initrd_size);
+            exit(1);
+        }
+
+        initrd_addr = (initrd_max - initrd_size) & ~4095;
+
+        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
+        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
+        sev_load_ctx.initrd_data = initrd_data;
+        sev_load_ctx.initrd_size = initrd_size;
+
+        stl_p(header + 0x218, initrd_addr);
+        stl_p(header + 0x21c, initrd_size);
+    }
+
+    /* load kernel and setup */
+    setup_size = header[0x1f1];
+    if (setup_size == 0) {
+        setup_size = 4;
+    }
+    setup_size = (setup_size + 1) * 512;
+    if (setup_size > kernel_size) {
+        fprintf(stderr, "qemu: invalid kernel header\n");
+        exit(1);
+    }
+    kernel_size -= setup_size;
+
+    setup  = g_malloc(setup_size);
+    kernel = g_malloc(kernel_size);
+    fseek(f, 0, SEEK_SET);
+    if (fread(setup, 1, setup_size, f) != setup_size) {
+        fprintf(stderr, "fread() failed\n");
+        exit(1);
+    }
+    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
+        fprintf(stderr, "fread() failed\n");
+        exit(1);
+    }
+    fclose(f);
+
+    /* append dtb to kernel */
+    if (dtb_filename) {
+        if (protocol < 0x209) {
+            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
+            exit(1);
+        }
+
+        dtb_size = get_image_size(dtb_filename);
+        if (dtb_size <= 0) {
+            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
+                    dtb_filename, strerror(errno));
+            exit(1);
+        }
+
+        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
+        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
+        kernel = g_realloc(kernel, kernel_size);
+
+        stq_p(header + 0x250, prot_addr + setup_data_offset);
+
+        setup_data = (struct setup_data *)(kernel + setup_data_offset);
+        setup_data->next = 0;
+        setup_data->type = cpu_to_le32(SETUP_DTB);
+        setup_data->len = cpu_to_le32(dtb_size);
+
+        load_image_size(dtb_filename, setup_data->data, dtb_size);
+    }
+
+    /*
+     * If we're starting an encrypted VM, it will be OVMF based, which uses the
+     * efi stub for booting and doesn't require any values to be placed in the
+     * kernel header.  We therefore don't update the header so the hash of the
+     * kernel on the other side of the fw_cfg interface matches the hash of the
+     * file the user passed in.
+     */
+    if (!sev_enabled()) {
+        memcpy(setup, header, MIN(sizeof(header), setup_size));
+    }
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
+    sev_load_ctx.kernel_data = (char *)kernel;
+    sev_load_ctx.kernel_size = kernel_size;
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
+    sev_load_ctx.setup_data = (char *)setup;
+    sev_load_ctx.setup_size = setup_size;
+
+    if (sev_enabled()) {
+        sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
+    }
+
+    option_rom[nb_option_roms].bootindex = 0;
+    option_rom[nb_option_roms].name = "linuxboot.bin";
+    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
+    }
+    nb_option_roms++;
+}
+
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only)
+{
+    uint64_t bios_size = memory_region_size(bios);
+    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
+
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, read_only);
+}
+
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    const char *bios_name;
+    char *filename;
+    int bios_size;
+    ssize_t ret;
+
+    /* BIOS load */
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (filename) {
+        bios_size = get_image_size(filename);
+    } else {
+        bios_size = -1;
+    }
+    if (bios_size <= 0 ||
+        (bios_size % 65536) != 0) {
+        goto bios_error;
+    }
+    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
+                           &error_fatal);
+    if (sev_enabled()) {
+        /*
+         * The concept of a "reset" simply doesn't exist for
+         * confidential computing guests, we have to destroy and
+         * re-launch them instead.  So there is no need to register
+         * the firmware as rom to properly re-initialize on reset.
+         * Just go for a straight file load instead.
+         */
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+        load_image_size(filename, ptr, bios_size);
+        x86_firmware_configure(ptr, bios_size);
+    } else {
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
+        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
+        if (ret != 0) {
+            goto bios_error;
+        }
+    }
+    g_free(filename);
+
+    /* map the last 128KB of the BIOS in ISA space */
+    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                      !isapc_ram_fw);
+
+    /* map all the bios at the top of memory */
+    memory_region_add_subregion(rom_memory,
+                                (uint32_t)(-bios_size),
+                                &x86ms->bios);
+    return;
+
+bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
new file mode 100644
index 00000000000..ab2920522d1
--- /dev/null
+++ b/hw/i386/x86-cpu.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2019, 2024 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "sysemu/whpx.h"
+#include "sysemu/cpu-timers.h"
+#include "trace.h"
+
+#include "hw/i386/x86.h"
+#include "target/i386/cpu.h"
+#include "hw/intc/i8259.h"
+#include "hw/irq.h"
+#include "sysemu/kvm.h"
+
+/* TSC handling */
+uint64_t cpu_get_tsc(CPUX86State *env)
+{
+    return cpus_get_elapsed_ticks();
+}
+
+/* IRQ handling */
+static void pic_irq_request(void *opaque, int irq, int level)
+{
+    CPUState *cs = first_cpu;
+    X86CPU *cpu = X86_CPU(cs);
+
+    trace_x86_pic_interrupt(irq, level);
+    if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
+        !whpx_apic_in_platform()) {
+        CPU_FOREACH(cs) {
+            cpu = X86_CPU(cs);
+            if (apic_accept_pic_intr(cpu->apic_state)) {
+                apic_deliver_pic_intr(cpu->apic_state, level);
+            }
+        }
+    } else {
+        if (level) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+qemu_irq x86_allocate_cpu_irq(void)
+{
+    return qemu_allocate_irq(pic_irq_request, NULL, 0);
+}
+
+int cpu_get_pic_interrupt(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    int intno;
+
+    if (!kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
+        intno = apic_get_interrupt(cpu->apic_state);
+        if (intno >= 0) {
+            return intno;
+        }
+        /* read the irq from the PIC */
+        if (!apic_accept_pic_intr(cpu->apic_state)) {
+            return -1;
+        }
+    }
+
+    intno = pic_read_irq(isa_pic);
+    return intno;
+}
+
+DeviceState *cpu_get_current_apic(void)
+{
+    if (current_cpu) {
+        X86CPU *cpu = X86_CPU(current_cpu);
+        return cpu->apic_state;
+    } else {
+        return NULL;
+    }
+}
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index fcef652c1e3..0b5cc599566 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -22,52 +22,25 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu/option.h"
-#include "qemu/cutils.h"
 #include "qemu/units.h"
-#include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
-#include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "sysemu/qtest.h"
-#include "sysemu/whpx.h"
 #include "sysemu/numa.h"
-#include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/cpu-timers.h"
-#include "sysemu/xen.h"
 #include "trace.h"
 
+#include "hw/acpi/aml-build.h"
 #include "hw/i386/x86.h"
-#include "target/i386/cpu.h"
 #include "hw/i386/topology.h"
-#include "hw/i386/fw_cfg.h"
-#include "hw/intc/i8259.h"
-#include "hw/rtc/mc146818rtc.h"
-#include "target/i386/sev.h"
 
-#include "hw/acpi/cpu_hotplug.h"
-#include "hw/irq.h"
 #include "hw/nmi.h"
-#include "hw/loader.h"
-#include "multiboot.h"
-#include "elf.h"
-#include "standard-headers/asm-x86/bootparam.h"
-#include CONFIG_DEVICES
 #include "kvm/kvm_i386.h"
 
-#ifdef CONFIG_XEN_EMU
-#include "hw/xen/xen.h"
-#include "hw/i386/kvm/xen_evtchn.h"
-#endif
 
-/* Physical Address of PVH entry point read from kernel ELF NOTE */
-static size_t pvh_start_addr;
-
-static void init_topo_info(X86CPUTopoInfo *topo_info,
-                           const X86MachineState *x86ms)
+void init_topo_info(X86CPUTopoInfo *topo_info,
+                    const X86MachineState *x86ms)
 {
     MachineState *ms = MACHINE(x86ms);
 
@@ -94,355 +67,6 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
     return x86_apicid_from_cpu_idx(&topo_info, cpu_index);
 }
 
-
-void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
-{
-    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
-
-    if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
-        goto out;
-    }
-    qdev_realize(DEVICE(cpu), NULL, errp);
-
-out:
-    object_unref(cpu);
-}
-
-void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
-{
-    int i;
-    const CPUArchIdList *possible_cpus;
-    MachineState *ms = MACHINE(x86ms);
-    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
-
-    x86_cpu_set_default_version(default_cpu_version);
-
-    /*
-     * Calculates the limit to CPU APIC ID values
-     *
-     * Limit for the APIC ID value, so that all
-     * CPU APIC IDs are < x86ms->apic_id_limit.
-     *
-     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
-     */
-    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
-                                                      ms->smp.max_cpus - 1) + 1;
-
-    /*
-     * Can we support APIC ID 255 or higher?  With KVM, that requires
-     * both in-kernel lapic and X2APIC userspace API.
-     *
-     * kvm_enabled() must go first to ensure that kvm_* references are
-     * not emitted for the linker to consume (kvm_enabled() is
-     * a literal `0` in configurations where kvm_* aren't defined)
-     */
-    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
-        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
-        error_report("current -smp configuration requires kernel "
-                     "irqchip and X2APIC API support.");
-        exit(EXIT_FAILURE);
-    }
-
-    if (kvm_enabled()) {
-        kvm_set_max_apic_id(x86ms->apic_id_limit);
-    }
-
-    if (!kvm_irqchip_in_kernel()) {
-        apic_set_max_apic_id(x86ms->apic_id_limit);
-    }
-
-    possible_cpus = mc->possible_cpu_arch_ids(ms);
-    for (i = 0; i < ms->smp.cpus; i++) {
-        x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
-    }
-}
-
-void x86_rtc_set_cpus_count(ISADevice *s, uint16_t cpus_count)
-{
-    MC146818RtcState *rtc = MC146818_RTC(s);
-
-    if (cpus_count > 0xff) {
-        /*
-         * If the number of CPUs can't be represented in 8 bits, the
-         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
-         * to make old BIOSes fail more predictably.
-         */
-        mc146818rtc_set_cmos_data(rtc, 0x5f, 0);
-    } else {
-        mc146818rtc_set_cmos_data(rtc, 0x5f, cpus_count - 1);
-    }
-}
-
-static int x86_apic_cmp(const void *a, const void *b)
-{
-   CPUArchId *apic_a = (CPUArchId *)a;
-   CPUArchId *apic_b = (CPUArchId *)b;
-
-   return apic_a->arch_id - apic_b->arch_id;
-}
-
-/*
- * returns pointer to CPUArchId descriptor that matches CPU's apic_id
- * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
- * entry corresponding to CPU's apic_id returns NULL.
- */
-CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        x86_apic_cmp);
-    if (found_cpu && idx) {
-        *idx = found_cpu - ms->possible_cpus->cpus;
-    }
-    return found_cpu;
-}
-
-void x86_cpu_plug(HotplugHandler *hotplug_dev,
-                  DeviceState *dev, Error **errp)
-{
-    CPUArchId *found_cpu;
-    Error *local_err = NULL;
-    X86CPU *cpu = X86_CPU(dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    if (x86ms->acpi_dev) {
-        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
-    /* increment the number of CPUs */
-    x86ms->boot_cpus++;
-    if (x86ms->rtc) {
-        x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
-    }
-    if (x86ms->fw_cfg) {
-        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
-    }
-
-    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
-    found_cpu->cpu = CPU(dev);
-out:
-    error_propagate(errp, local_err);
-}
-
-void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
-                               DeviceState *dev, Error **errp)
-{
-    int idx = -1;
-    X86CPU *cpu = X86_CPU(dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    if (!x86ms->acpi_dev) {
-        error_setg(errp, "CPU hot unplug not supported without ACPI");
-        return;
-    }
-
-    x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
-    assert(idx != -1);
-    if (idx == 0) {
-        error_setg(errp, "Boot CPU is unpluggable");
-        return;
-    }
-
-    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
-                                   errp);
-}
-
-void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
-                       DeviceState *dev, Error **errp)
-{
-    CPUArchId *found_cpu;
-    Error *local_err = NULL;
-    X86CPU *cpu = X86_CPU(dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
-    found_cpu->cpu = NULL;
-    qdev_unrealize(dev);
-
-    /* decrement the number of CPUs */
-    x86ms->boot_cpus--;
-    /* Update the number of CPUs in CMOS */
-    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
-    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
- out:
-    error_propagate(errp, local_err);
-}
-
-void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
-                      DeviceState *dev, Error **errp)
-{
-    int idx;
-    CPUState *cs;
-    CPUArchId *cpu_slot;
-    X86CPUTopoIDs topo_ids;
-    X86CPU *cpu = X86_CPU(dev);
-    CPUX86State *env = &cpu->env;
-    MachineState *ms = MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    unsigned int smp_cores = ms->smp.cores;
-    unsigned int smp_threads = ms->smp.threads;
-    X86CPUTopoInfo topo_info;
-
-    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
-        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
-                   ms->cpu_type);
-        return;
-    }
-
-    if (x86ms->acpi_dev) {
-        Error *local_err = NULL;
-
-        hotplug_handler_pre_plug(HOTPLUG_HANDLER(x86ms->acpi_dev), dev,
-                                 &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
-    init_topo_info(&topo_info, x86ms);
-
-    env->nr_dies = ms->smp.dies;
-
-    /*
-     * If APIC ID is not set,
-     * set it based on socket/die/core/thread properties.
-     */
-    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / ms->smp.dies;
-
-        /*
-         * die-id was optional in QEMU 4.0 and older, so keep it optional
-         * if there's only one die per socket.
-         */
-        if (cpu->die_id < 0 && ms->smp.dies == 1) {
-            cpu->die_id = 0;
-        }
-
-        if (cpu->socket_id < 0) {
-            error_setg(errp, "CPU socket-id is not set");
-            return;
-        } else if (cpu->socket_id > max_socket) {
-            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
-                       cpu->socket_id, max_socket);
-            return;
-        }
-        if (cpu->die_id < 0) {
-            error_setg(errp, "CPU die-id is not set");
-            return;
-        } else if (cpu->die_id > ms->smp.dies - 1) {
-            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
-                       cpu->die_id, ms->smp.dies - 1);
-            return;
-        }
-        if (cpu->core_id < 0) {
-            error_setg(errp, "CPU core-id is not set");
-            return;
-        } else if (cpu->core_id > (smp_cores - 1)) {
-            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
-                       cpu->core_id, smp_cores - 1);
-            return;
-        }
-        if (cpu->thread_id < 0) {
-            error_setg(errp, "CPU thread-id is not set");
-            return;
-        } else if (cpu->thread_id > (smp_threads - 1)) {
-            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
-                       cpu->thread_id, smp_threads - 1);
-            return;
-        }
-
-        topo_ids.pkg_id = cpu->socket_id;
-        topo_ids.die_id = cpu->die_id;
-        topo_ids.core_id = cpu->core_id;
-        topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
-    }
-
-    cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
-    if (!cpu_slot) {
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
-        error_setg(errp,
-            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-            " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
-            cpu->apic_id, ms->possible_cpus->len - 1);
-        return;
-    }
-
-    if (cpu_slot->cpu) {
-        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
-                   idx, cpu->apic_id);
-        return;
-    }
-
-    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
-     * so that machine_query_hotpluggable_cpus would show correct values
-     */
-    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
-     * once -smp refactoring is complete and there will be CPU private
-     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
-    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
-        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
-            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
-            topo_ids.pkg_id);
-        return;
-    }
-    cpu->socket_id = topo_ids.pkg_id;
-
-    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
-        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
-            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
-        return;
-    }
-    cpu->die_id = topo_ids.die_id;
-
-    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
-        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
-            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
-            topo_ids.core_id);
-        return;
-    }
-    cpu->core_id = topo_ids.core_id;
-
-    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
-        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
-            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
-            topo_ids.smt_id);
-        return;
-    }
-    cpu->thread_id = topo_ids.smt_id;
-
-    /*
-    * kvm_enabled() must go first to ensure that kvm_* references are
-    * not emitted for the linker to consume (kvm_enabled() is
-    * a literal `0` in configurations where kvm_* aren't defined)
-    */
-    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        !kvm_hv_vpindex_settable()) {
-        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
-        return;
-    }
-
-    cs = CPU(cpu);
-    cs->cpu_index = idx;
-
-    numa_cpu_pre_plug(cpu_slot, dev, errp);
-}
-
 static CpuInstanceProperties
 x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -528,676 +152,6 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
-static long get_file_size(FILE *f)
-{
-    long where, size;
-
-    /* XXX: on Unix systems, using fstat() probably makes more sense */
-
-    where = ftell(f);
-    fseek(f, 0, SEEK_END);
-    size = ftell(f);
-    fseek(f, where, SEEK_SET);
-
-    return size;
-}
-
-/* TSC handling */
-uint64_t cpu_get_tsc(CPUX86State *env)
-{
-    return cpus_get_elapsed_ticks();
-}
-
-/* IRQ handling */
-static void pic_irq_request(void *opaque, int irq, int level)
-{
-    CPUState *cs = first_cpu;
-    X86CPU *cpu = X86_CPU(cs);
-
-    trace_x86_pic_interrupt(irq, level);
-    if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
-        !whpx_apic_in_platform()) {
-        CPU_FOREACH(cs) {
-            cpu = X86_CPU(cs);
-            if (apic_accept_pic_intr(cpu->apic_state)) {
-                apic_deliver_pic_intr(cpu->apic_state, level);
-            }
-        }
-    } else {
-        if (level) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    }
-}
-
-qemu_irq x86_allocate_cpu_irq(void)
-{
-    return qemu_allocate_irq(pic_irq_request, NULL, 0);
-}
-
-int cpu_get_pic_interrupt(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    int intno;
-
-    if (!kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
-        intno = apic_get_interrupt(cpu->apic_state);
-        if (intno >= 0) {
-            return intno;
-        }
-        /* read the irq from the PIC */
-        if (!apic_accept_pic_intr(cpu->apic_state)) {
-            return -1;
-        }
-    }
-
-    intno = pic_read_irq(isa_pic);
-    return intno;
-}
-
-DeviceState *cpu_get_current_apic(void)
-{
-    if (current_cpu) {
-        X86CPU *cpu = X86_CPU(current_cpu);
-        return cpu->apic_state;
-    } else {
-        return NULL;
-    }
-}
-
-void gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    trace_x86_gsi_interrupt(n, level);
-    switch (n) {
-    case 0 ... ISA_NUM_IRQS - 1:
-        if (s->i8259_irq[n]) {
-            /* Under KVM, Kernel will forward to both PIC and IOAPIC */
-            qemu_set_irq(s->i8259_irq[n], level);
-        }
-        /* fall through */
-    case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
-#ifdef CONFIG_XEN_EMU
-        /*
-         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
-         * routing actually works properly under Xen). And then to
-         * *either* the PIRQ handling or the I/OAPIC depending on
-         * whether the former wants it.
-         */
-        if (xen_mode == XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
-            break;
-        }
-#endif
-        qemu_set_irq(s->ioapic_irq[n], level);
-        break;
-    case IO_APIC_SECONDARY_IRQBASE
-        ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
-        qemu_set_irq(s->ioapic2_irq[n - IO_APIC_SECONDARY_IRQBASE], level);
-        break;
-    }
-}
-
-void ioapic_init_gsi(GSIState *gsi_state, Object *parent)
-{
-    DeviceState *dev;
-    SysBusDevice *d;
-    unsigned int i;
-
-    assert(parent);
-    if (kvm_ioapic_in_kernel()) {
-        dev = qdev_new(TYPE_KVM_IOAPIC);
-    } else {
-        dev = qdev_new(TYPE_IOAPIC);
-    }
-    object_property_add_child(parent, "ioapic", OBJECT(dev));
-    d = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(d, &error_fatal);
-    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
-    }
-}
-
-DeviceState *ioapic_init_secondary(GSIState *gsi_state)
-{
-    DeviceState *dev;
-    SysBusDevice *d;
-    unsigned int i;
-
-    dev = qdev_new(TYPE_IOAPIC);
-    d = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(d, &error_fatal);
-    sysbus_mmio_map(d, 0, IO_APIC_SECONDARY_ADDRESS);
-
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        gsi_state->ioapic2_irq[i] = qdev_get_gpio_in(dev, i);
-    }
-    return dev;
-}
-
-/*
- * The entry point into the kernel for PVH boot is different from
- * the native entry point.  The PVH entry is defined by the x86/HVM
- * direct boot ABI and is available in an ELFNOTE in the kernel binary.
- *
- * This function is passed to load_elf() when it is called from
- * load_elfboot() which then additionally checks for an ELF Note of
- * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
- * parse the PVH entry address from the ELF Note.
- *
- * Due to trickery in elf_opts.h, load_elf() is actually available as
- * load_elf32() or load_elf64() and this routine needs to be able
- * to deal with being called as 32 or 64 bit.
- *
- * The address of the PVH entry point is saved to the 'pvh_start_addr'
- * global variable.  (although the entry point is 32-bit, the kernel
- * binary can be either 32-bit or 64-bit).
- */
-static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
-{
-    size_t *elf_note_data_addr;
-
-    /* Check if ELF Note header passed in is valid */
-    if (arg1 == NULL) {
-        return 0;
-    }
-
-    if (is64) {
-        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
-        uint64_t nhdr_size64 = sizeof(struct elf64_note);
-        uint64_t phdr_align = *(uint64_t *)arg2;
-        uint64_t nhdr_namesz = nhdr64->n_namesz;
-
-        elf_note_data_addr =
-            ((void *)nhdr64) + nhdr_size64 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *elf_note_data_addr;
-    } else {
-        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
-        uint32_t nhdr_size32 = sizeof(struct elf32_note);
-        uint32_t phdr_align = *(uint32_t *)arg2;
-        uint32_t nhdr_namesz = nhdr32->n_namesz;
-
-        elf_note_data_addr =
-            ((void *)nhdr32) + nhdr_size32 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
-    }
-
-    return pvh_start_addr;
-}
-
-static bool load_elfboot(const char *kernel_filename,
-                         int kernel_file_size,
-                         uint8_t *header,
-                         size_t pvh_xen_start_addr,
-                         FWCfgState *fw_cfg)
-{
-    uint32_t flags = 0;
-    uint32_t mh_load_addr = 0;
-    uint32_t elf_kernel_size = 0;
-    uint64_t elf_entry;
-    uint64_t elf_low, elf_high;
-    int kernel_size;
-
-    if (ldl_p(header) != 0x464c457f) {
-        return false; /* no elfboot */
-    }
-
-    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
-    flags = elf_is64 ?
-        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
-
-    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
-        error_report("elfboot unsupported flags = %x", flags);
-        exit(1);
-    }
-
-    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
-    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
-                           NULL, &elf_note_type, &elf_entry,
-                           &elf_low, &elf_high, NULL, 0, I386_ELF_MACHINE,
-                           0, 0);
-
-    if (kernel_size < 0) {
-        error_report("Error while loading elf kernel");
-        exit(1);
-    }
-    mh_load_addr = elf_low;
-    elf_kernel_size = elf_high - elf_low;
-
-    if (pvh_start_addr == 0) {
-        error_report("Error loading uncompressed kernel without PVH ELF Note");
-        exit(1);
-    }
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
-
-    return true;
-}
-
-void x86_load_linux(X86MachineState *x86ms,
-                    FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled)
-{
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
-    uint16_t protocol;
-    int setup_size, kernel_size, cmdline_size;
-    int dtb_size, setup_data_offset;
-    uint32_t initrd_max;
-    uint8_t header[8192], *setup, *kernel;
-    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
-    FILE *f;
-    char *vmode;
-    MachineState *machine = MACHINE(x86ms);
-    struct setup_data *setup_data;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *initrd_filename = machine->initrd_filename;
-    const char *dtb_filename = machine->dtb;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    SevKernelLoaderContext sev_load_ctx = {};
-
-    /* Align to 16 bytes as a paranoia measure */
-    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
-
-    /* load the kernel header */
-    f = fopen(kernel_filename, "rb");
-    if (!f) {
-        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
-                kernel_filename, strerror(errno));
-        exit(1);
-    }
-
-    kernel_size = get_file_size(f);
-    if (!kernel_size ||
-        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
-        MIN(ARRAY_SIZE(header), kernel_size)) {
-        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
-                kernel_filename, strerror(errno));
-        exit(1);
-    }
-
-    /* kernel protocol version */
-    if (ldl_p(header + 0x202) == 0x53726448) {
-        protocol = lduw_p(header + 0x206);
-    } else {
-        /*
-         * This could be a multiboot kernel. If it is, let's stop treating it
-         * like a Linux kernel.
-         * Note: some multiboot images could be in the ELF format (the same of
-         * PVH), so we try multiboot first since we check the multiboot magic
-         * header before to load it.
-         */
-        if (load_multiboot(x86ms, fw_cfg, f, kernel_filename, initrd_filename,
-                           kernel_cmdline, kernel_size, header)) {
-            return;
-        }
-        /*
-         * Check if the file is an uncompressed kernel file (ELF) and load it,
-         * saving the PVH entry point used by the x86/HVM direct boot ABI.
-         * If load_elfboot() is successful, populate the fw_cfg info.
-         */
-        if (pvh_enabled &&
-            load_elfboot(kernel_filename, kernel_size,
-                         header, pvh_start_addr, fw_cfg)) {
-            fclose(f);
-
-            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
-                strlen(kernel_cmdline) + 1);
-            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
-
-            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
-            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
-                             header, sizeof(header));
-
-            /* load initrd */
-            if (initrd_filename) {
-                GMappedFile *mapped_file;
-                gsize initrd_size;
-                gchar *initrd_data;
-                GError *gerr = NULL;
-
-                mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
-                if (!mapped_file) {
-                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
-                            initrd_filename, gerr->message);
-                    exit(1);
-                }
-                x86ms->initrd_mapped_file = mapped_file;
-
-                initrd_data = g_mapped_file_get_contents(mapped_file);
-                initrd_size = g_mapped_file_get_length(mapped_file);
-                initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
-                if (initrd_size >= initrd_max) {
-                    fprintf(stderr, "qemu: initrd is too large, cannot support."
-                            "(max: %"PRIu32", need %"PRId64")\n",
-                            initrd_max, (uint64_t)initrd_size);
-                    exit(1);
-                }
-
-                initrd_addr = (initrd_max - initrd_size) & ~4095;
-
-                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
-                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
-                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
-                                 initrd_size);
-            }
-
-            option_rom[nb_option_roms].bootindex = 0;
-            option_rom[nb_option_roms].name = "pvh.bin";
-            nb_option_roms++;
-
-            return;
-        }
-        protocol = 0;
-    }
-
-    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
-        /* Low kernel */
-        real_addr    = 0x90000;
-        cmdline_addr = 0x9a000 - cmdline_size;
-        prot_addr    = 0x10000;
-    } else if (protocol < 0x202) {
-        /* High but ancient kernel */
-        real_addr    = 0x90000;
-        cmdline_addr = 0x9a000 - cmdline_size;
-        prot_addr    = 0x100000;
-    } else {
-        /* High and recent kernel */
-        real_addr    = 0x10000;
-        cmdline_addr = 0x20000;
-        prot_addr    = 0x100000;
-    }
-
-    /* highest address for loading the initrd */
-    if (protocol >= 0x20c &&
-        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
-        /*
-         * Linux has supported initrd up to 4 GB for a very long time (2007,
-         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
-         * though it only sets initrd_max to 2 GB to "work around bootloader
-         * bugs". Luckily, QEMU firmware(which does something like bootloader)
-         * has supported this.
-         *
-         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
-         * be loaded into any address.
-         *
-         * In addition, initrd_max is uint32_t simply because QEMU doesn't
-         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
-         * field).
-         *
-         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
-         */
-        initrd_max = UINT32_MAX;
-    } else if (protocol >= 0x203) {
-        initrd_max = ldl_p(header + 0x22c);
-    } else {
-        initrd_max = 0x37ffffff;
-    }
-
-    if (initrd_max >= x86ms->below_4g_mem_size - acpi_data_size) {
-        initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
-    }
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
-    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
-    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
-    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
-
-    if (protocol >= 0x202) {
-        stl_p(header + 0x228, cmdline_addr);
-    } else {
-        stw_p(header + 0x20, 0xA33F);
-        stw_p(header + 0x22, cmdline_addr - real_addr);
-    }
-
-    /* handle vga= parameter */
-    vmode = strstr(kernel_cmdline, "vga=");
-    if (vmode) {
-        unsigned int video_mode;
-        const char *end;
-        int ret;
-        /* skip "vga=" */
-        vmode += 4;
-        if (!strncmp(vmode, "normal", 6)) {
-            video_mode = 0xffff;
-        } else if (!strncmp(vmode, "ext", 3)) {
-            video_mode = 0xfffe;
-        } else if (!strncmp(vmode, "ask", 3)) {
-            video_mode = 0xfffd;
-        } else {
-            ret = qemu_strtoui(vmode, &end, 0, &video_mode);
-            if (ret != 0 || (*end && *end != ' ')) {
-                fprintf(stderr, "qemu: invalid 'vga=' kernel parameter.\n");
-                exit(1);
-            }
-        }
-        stw_p(header + 0x1fa, video_mode);
-    }
-
-    /* loader type */
-    /*
-     * High nybble = B reserved for QEMU; low nybble is revision number.
-     * If this code is substantially changed, you may want to consider
-     * incrementing the revision.
-     */
-    if (protocol >= 0x200) {
-        header[0x210] = 0xB0;
-    }
-    /* heap */
-    if (protocol >= 0x201) {
-        header[0x211] |= 0x80; /* CAN_USE_HEAP */
-        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
-    }
-
-    /* load initrd */
-    if (initrd_filename) {
-        GMappedFile *mapped_file;
-        gsize initrd_size;
-        gchar *initrd_data;
-        GError *gerr = NULL;
-
-        if (protocol < 0x200) {
-            fprintf(stderr, "qemu: linux kernel too old to load a ram disk\n");
-            exit(1);
-        }
-
-        mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
-        if (!mapped_file) {
-            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
-                    initrd_filename, gerr->message);
-            exit(1);
-        }
-        x86ms->initrd_mapped_file = mapped_file;
-
-        initrd_data = g_mapped_file_get_contents(mapped_file);
-        initrd_size = g_mapped_file_get_length(mapped_file);
-        if (initrd_size >= initrd_max) {
-            fprintf(stderr, "qemu: initrd is too large, cannot support."
-                    "(max: %"PRIu32", need %"PRId64")\n",
-                    initrd_max, (uint64_t)initrd_size);
-            exit(1);
-        }
-
-        initrd_addr = (initrd_max - initrd_size) & ~4095;
-
-        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
-        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
-        sev_load_ctx.initrd_data = initrd_data;
-        sev_load_ctx.initrd_size = initrd_size;
-
-        stl_p(header + 0x218, initrd_addr);
-        stl_p(header + 0x21c, initrd_size);
-    }
-
-    /* load kernel and setup */
-    setup_size = header[0x1f1];
-    if (setup_size == 0) {
-        setup_size = 4;
-    }
-    setup_size = (setup_size + 1) * 512;
-    if (setup_size > kernel_size) {
-        fprintf(stderr, "qemu: invalid kernel header\n");
-        exit(1);
-    }
-    kernel_size -= setup_size;
-
-    setup  = g_malloc(setup_size);
-    kernel = g_malloc(kernel_size);
-    fseek(f, 0, SEEK_SET);
-    if (fread(setup, 1, setup_size, f) != setup_size) {
-        fprintf(stderr, "fread() failed\n");
-        exit(1);
-    }
-    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
-        fprintf(stderr, "fread() failed\n");
-        exit(1);
-    }
-    fclose(f);
-
-    /* append dtb to kernel */
-    if (dtb_filename) {
-        if (protocol < 0x209) {
-            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
-            exit(1);
-        }
-
-        dtb_size = get_image_size(dtb_filename);
-        if (dtb_size <= 0) {
-            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
-                    dtb_filename, strerror(errno));
-            exit(1);
-        }
-
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
-        kernel = g_realloc(kernel, kernel_size);
-
-        stq_p(header + 0x250, prot_addr + setup_data_offset);
-
-        setup_data = (struct setup_data *)(kernel + setup_data_offset);
-        setup_data->next = 0;
-        setup_data->type = cpu_to_le32(SETUP_DTB);
-        setup_data->len = cpu_to_le32(dtb_size);
-
-        load_image_size(dtb_filename, setup_data->data, dtb_size);
-    }
-
-    /*
-     * If we're starting an encrypted VM, it will be OVMF based, which uses the
-     * efi stub for booting and doesn't require any values to be placed in the
-     * kernel header.  We therefore don't update the header so the hash of the
-     * kernel on the other side of the fw_cfg interface matches the hash of the
-     * file the user passed in.
-     */
-    if (!sev_enabled()) {
-        memcpy(setup, header, MIN(sizeof(header), setup_size));
-    }
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
-    sev_load_ctx.kernel_data = (char *)kernel;
-    sev_load_ctx.kernel_size = kernel_size;
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
-    sev_load_ctx.setup_data = (char *)setup;
-    sev_load_ctx.setup_size = setup_size;
-
-    if (sev_enabled()) {
-        sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
-    }
-
-    option_rom[nb_option_roms].bootindex = 0;
-    option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
-        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
-    }
-    nb_option_roms++;
-}
-
-void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
-                       MemoryRegion *bios, bool read_only)
-{
-    uint64_t bios_size = memory_region_size(bios);
-    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
-
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
-                                        isa_bios, 1);
-    memory_region_set_readonly(isa_bios, read_only);
-}
-
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
-{
-    const char *bios_name;
-    char *filename;
-    int bios_size;
-    ssize_t ret;
-
-    /* BIOS load */
-    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (filename) {
-        bios_size = get_image_size(filename);
-    } else {
-        bios_size = -1;
-    }
-    if (bios_size <= 0 ||
-        (bios_size % 65536) != 0) {
-        goto bios_error;
-    }
-    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
-                           &error_fatal);
-    if (sev_enabled()) {
-        /*
-         * The concept of a "reset" simply doesn't exist for
-         * confidential computing guests, we have to destroy and
-         * re-launch them instead.  So there is no need to register
-         * the firmware as rom to properly re-initialize on reset.
-         * Just go for a straight file load instead.
-         */
-        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
-        load_image_size(filename, ptr, bios_size);
-        x86_firmware_configure(ptr, bios_size);
-    } else {
-        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
-        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
-        if (ret != 0) {
-            goto bios_error;
-        }
-    }
-    g_free(filename);
-
-    /* map the last 128KB of the BIOS in ISA space */
-    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
-                      !isapc_ram_fw);
-
-    /* map all the bios at the top of memory */
-    memory_region_add_subregion(rom_memory,
-                                (uint32_t)(-bios_size),
-                                &x86ms->bios);
-    return;
-
-bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
-}
-
 bool x86_machine_is_smm_enabled(const X86MachineState *x86ms)
 {
     bool smm_available = false;
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index d9da676038c..3437da0aad1 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -4,6 +4,7 @@ i386_ss.add(files(
   'e820_memory_layout.c',
   'multiboot.c',
   'x86.c',
+  'x86-cpu.c',
 ))
 
 i386_ss.add(when: 'CONFIG_APIC', if_true: files('vapic.c'))
@@ -12,7 +13,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
-i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
+i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
@@ -22,6 +23,7 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
+  'x86-common.c',
   'pc.c',
   'pc_sysfw.c',
   'acpi-build.c',
-- 
2.45.0


