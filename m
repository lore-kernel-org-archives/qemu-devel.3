Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A33CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGU-0005kP-HE; Tue, 30 Sep 2025 21:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lGF-0005a5-3d
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFP-0008Ez-7P
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:04:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so1581161f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280584; x=1759885384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqlJ1Ed3QXcZnlY4qexn4Hfgq2mlv/iEUpdzIVVjHlk=;
 b=MP1303CNHvdDwdTaZACP/+sk5v2ZHHbp/3co5Li52hM9jQzUH2aMVwUZnzIwED2v3r
 BVLs/8nXviCU4s3hFPU9Y5I8cN6efR7MAy9L/lrZIuGU4bVqwltCUgozxDT0wslsFiNc
 CftKUO28G/clSUe9xZndGWFTDR9K3M0q3lOA2zS+UUWrcqBNYVlEHYw4LpKg6bqrm+sP
 tGmXwVnZ7BALatMfic+FjL07IZlcIgroinwqp3zZaGrfUPy8yQqEYyAhZG3Px8e+Bzxy
 RTED5iSUg6XANLpo7VvfRhvRVw9hvZ16N/A8+eu1OsAlZ1/OISqJ6b9yKhIcbOgAop2b
 mX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280584; x=1759885384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqlJ1Ed3QXcZnlY4qexn4Hfgq2mlv/iEUpdzIVVjHlk=;
 b=mlMCKwCeTugwiU6ea/179w54NFa7PX/HRHZ+R0vsEoD8JMftdbTPGibYAxJSQC89rn
 5WILILahHBoz6llF0HL7GwHarA475GQsXWgysypQAq/rq404PwsCwGnp7v4+xhK6hj2J
 mYM6RMajt12WHIyG503nJWFJWvglnDdDbJsTogSW+gRN8qjVb7XNeVp7oV7Bp0uWnUVa
 d9sa5VPwlcOkKUQGrPt1D+cz/KhgJQs8jPTX7DTExN8O5jMW2ls1/p2GBT/2pN0ErUps
 xi5d07O07BJMQiQMjV7ZGVi3v0UNEjYxyaji3Yhw/ILEAbQtiUx+QJvsy/ARs8FdXZa2
 DWNw==
X-Gm-Message-State: AOJu0YwPf3M5OK0xEFgsrwKO4cNk9mXxI8piYZGec6T3zzAMHTWa3S7D
 6cgXyUfbEwM43gDpT355pY50Pr9fjFaVcrFOi1K+V16vI0h4M8xni5RB2ivByVuyipwqpT5nTlo
 B4hOJQvHZqA==
X-Gm-Gg: ASbGncvfBlwG5zaC+kA4VWCdc2VmySBNzfU/Yn7ddY/EH0RD3qtehN2tQ4cV242aE2K
 Ei1afkK0K+i9I2wRI7VmjzRPWJ9ObVz/hyiB3nyg+T9n5v9QNeH5hitwDMW2LPthFpYuflT4MOV
 1mFgGCK5dhXPM3XxYxapfxz5oHh6Xpd2jp6JX/p7LF0IyqjSzrM272K7Afbw3Fn1E4aa6REU6TL
 KbjCKPrkQhfoY9Slu1zYCEo67ixvR6RoaIQF+mJr9VkWTdqoT/8t+wc1HiVUQriYQsLI+sy5L1p
 oNWSZpHbZZfmxRzW5G2rgHWOZd+ppRVVaIciJFe2SeneWVu4X5mGOZNOBX84pV5j7f7uM9QCAZj
 KeN4atJKoqy0wdKz4O4/EGPRM6uJBiH64rxwcHOuEzSUUnJcJF+eE4SWkYkrkVrC/xl1dDDzkhL
 qAKOBAYKvElIE9McRfR4lmJUciTHGrAWps5Qut84flQDs=
X-Google-Smtp-Source: AGHT+IG1OBzG3IMv9K5awWGeGYbciu9hTZ9mCdT5/F5dG73capVwC8DN4VC2EWZSd6kl2kqttZBcbA==
X-Received: by 2002:a05:6000:250c:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-425577e4a77mr911612f8f.4.1759280584205; 
 Tue, 30 Sep 2025 18:03:04 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:03:03 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 23/24] monitor,
 qapi: add 'info cpus-powerstate' and QMP query (Admin + Oper states)
Date: Wed,  1 Oct 2025 01:01:26 +0000
Message-Id: <20251001010127.3092631-24-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

The existing 'info hotpluggable-cpus' applies to platforms with true CPU
hotplug. On ARM, vCPUs are not hotpluggable: resources are allocated at
boot and policy is enforced administratively (e.g. via ACPI _STA) to
achieve a hotplug-like effect. As a result, the hotpluggable interface
cannot describe ARM CPU state, whether administrative or runtime.

Operators need a clear view of both administrative policy (Enabled,
Disabled, Removed) and guest runtime status (On, Standby, Off, Unknown)
for all possible vCPUs. This separation is essential to debug CPU life
cycle flows on ARM, where PSCI CPU_ON/CPU_OFF and ACPI methods are used,
and to distinguish CPUs that are enumerated but administratively blocked
from those actually executing in the guest.

The new interface is independent of hotplug and coexists with 'info
hotpluggable-cpus' on platforms that support it (e.g. x86). By default
devices are administratively Enabled; on hotpluggable systems, absent
CPUs appear as Removed here.

This patch introduces:
  * QMP 'query-cpus-powerstate' returning CPUPowerStateInfo per possible
    vCPU.
  * HMP 'info cpus-powerstate' for human-readable output.
  * Enums:
      - CPUPowerAdminState { enabled, disabled, removed }
      - CPUOperPowerState  { on, standby, off, unknown }
  * CPUPowerStateInfo with admin/oper state, optional topology ids, and
    qom-path.

Operational state semantics:
  * 'on'      : CPU is on and runnable.
  * 'standby' : Reserved for suspend-with-context (e.g. PSCI CPU_SUSPEND).
                Not emitted yet.
  * 'off'     : CPU is powered off.
                - At initial boot, admin-disabled vCPUs may be left
                  unrealized (lazy realize) and are reported Off.
                - After an admin enable, the vCPU is realized; if later
                  powered down, it remains realized and reported Off.
  * 'unknown' : State cannot be determined (very early init/teardown,
                transient hot-(un)plug window, or no power-state handler).

Migration semantics:
  * Admin-disabled (unrealized) vCPUs do not migrate.
  * Admin-enabled vCPUs migrate their operational state, including Off.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hmp-commands-info.hx       |  32 +++++++++++
 hw/arm/virt.c              |  32 +++++++++++
 hw/core/machine-hmp-cmds.c |  62 +++++++++++++++++++++
 hw/core/machine-qmp-cmds.c | 107 +++++++++++++++++++++++++++++++++++++
 include/monitor/hmp.h      |   1 +
 qapi/machine.json          |  87 ++++++++++++++++++++++++++++++
 6 files changed, 321 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6142f60e7b..b4d24c8aed 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -766,6 +766,38 @@ ERST
 SRST
   ``info hotpluggable-cpus``
     Show information about hotpluggable CPUs
+
+ERST
+
+{
+    .name       = "cpus-powerstate",
+    .args_type  = "",
+    .params     = "",
+    .help       = "Show administrative and operational CPU states",
+    .cmd        = hmp_info_cpus_powerstate,
+    .flags      = "p",
+},
+
+SRST
+  ``info cpus-powerstate``
+    Display administrative (policy) and operational (runtime) power
+    states for each virtual CPU.
+
+    Administrative states:
+      - ``Enabled``  : CPU is available to the guest
+      - ``Disabled`` : CPU is present but administratively blocked
+      - ``Removed``  : CPU is not present (hidden from the guest)
+
+    Operational states (if available):
+      - ``On``       : CPU is powered on and executing
+      - ``Standby``  : CPU is idle/low-power and can resume on an event
+      - ``Off``      : CPU is powered off or guest-offlined
+      - ``Unknown``  : State cannot be determined (e.g. very early init,
+                       teardown, transient hotplug/hotremove window, or
+                       target/platform does not expose a queryable state)
+
+    The administrative state constrains which operational states are
+    possible.
 ERST
 
     {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7bd37ffb75..5e02d6749d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2080,6 +2080,21 @@ virt_cpu_post_poweroff(PowerStateHandler *handler, DeviceState *dev,
     virt_park_cpu_in_userspace(cs);
 }
 
+static
+DeviceOperPowerState virt_cpu_get_oper_state(DeviceState *dev, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(CPU(dev));
+
+    switch (cpu->power_state) {
+    case PSCI_ON:
+        return DEVICE_OPER_POWER_STATE_ON;
+    case PSCI_OFF:
+        return DEVICE_OPER_POWER_STATE_OFF;
+    default:
+        return DEVICE_OPER_POWER_STATE_UNKNOWN;
+    }
+}
+
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
     uint8_t clustersz;
@@ -2452,6 +2467,9 @@ virt_setup_lazy_vcpu_realization(Object *cpuobj, VirtMachineState *vms)
                                 NULL);
     }
 
+    /* set operational state of disabled CPUs as OFF */
+    ARM_CPU(cpuobj)->power_state = PSCI_OFF;
+
     /*
      * [!] Constraint: The ARM CPU architecture does not permit new CPUs
      * to be added after system initialization.
@@ -3517,6 +3535,19 @@ virt_machine_device_pre_poweron(PowerStateHandler *handler, DeviceState *dev,
     }
 }
 
+static DeviceOperPowerState
+virt_machine_get_device_oper_state(DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        return virt_cpu_get_oper_state(dev, errp);
+    } else {
+        error_setg(errp, "can't get power state for unsupported device-type %s",
+                   object_get_typename(OBJECT(dev)));
+    }
+
+    return DEVICE_OPER_POWER_STATE_UNKNOWN;
+}
+
 static void *
 virt_machine_powerstate_handler(MachineState *machine, DeviceState *dev)
 {
@@ -3672,6 +3703,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     assert(!mc->get_powerstate_handler);
     mc->has_online_capable_cpus = true;
     mc->get_powerstate_handler = virt_machine_powerstate_handler;
+    pshc->get_oper_state = virt_machine_get_device_oper_state;
     pshc->request_poweroff = virt_machine_device_request_poweroff;
     pshc->post_poweroff = virt_machine_device_post_poweroff;
     pshc->pre_poweron = virt_machine_device_pre_poweron;
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 3a612e2232..b01d8b800a 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -107,6 +107,68 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_HotpluggableCPUList(saved);
 }
 
+void hmp_info_cpus_powerstate(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    CPUPowerStateInfoList *list = qmp_query_cpus_power_state(&err);
+    CPUPowerStateInfoList *entry = list;
+
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
+
+    monitor_printf(mon, "CPUs Power State Info:\n");
+
+    while (entry) {
+        CPUPowerStateInfo *cpu = entry->value;
+
+        monitor_printf(mon, "  CPU ID: %" PRIi64 "\n", cpu->id);
+
+        if (cpu->has_socket_id) {
+            monitor_printf(mon, "    socket-id: %" PRIi64 "\n", cpu->socket_id);
+        }
+        if (cpu->has_cluster_id) {
+            monitor_printf(mon, "    cluster-id: %" PRIi64 "\n", cpu->cluster_id);
+        }
+        if (cpu->has_core_id) {
+            monitor_printf(mon, "    core-id: %" PRIi64 "\n", cpu->core_id);
+        }
+        if (cpu->has_thread_id) {
+            monitor_printf(mon, "    thread-id: %" PRIi64 "\n", cpu->thread_id);
+        }
+        if (cpu->has_die_id) {
+            monitor_printf(mon, "    die-id: %" PRIi64 "\n", cpu->die_id);
+        }
+        if (cpu->has_module_id) {
+            monitor_printf(mon, "    module-id: %" PRIi64 "\n", cpu->module_id);
+        }
+        if (cpu->has_book_id) {
+            monitor_printf(mon, "    book-id: %" PRIi64 "\n", cpu->book_id);
+        }
+        if (cpu->has_drawer_id) {
+            monitor_printf(mon, "    drawer-id: %" PRIi64 "\n", cpu->drawer_id);
+        }
+        if (cpu->has_node_id) {
+            monitor_printf(mon, "    node-id: %" PRIi64 "\n", cpu->node_id);
+        }
+        if (cpu->has_vcpus_count) {
+            monitor_printf(mon, "    vcpus-count: %" PRIi64 "\n", cpu->vcpus_count);
+        }
+        if (cpu->qom_path) {
+            monitor_printf(mon, "    qom-path: \"%s\"\n", cpu->qom_path);
+        }
+
+        monitor_printf(mon, "    admin-state: \"%s\"\n",
+                       CPUAdminPowerState_str(cpu->admin_state));
+        monitor_printf(mon, "    oper-state: \"%s\"\n",
+                       CPUOperPowerState_str(cpu->oper_state));
+
+        entry = entry->next;
+    }
+
+    qapi_free_CPUPowerStateInfoList(list);
+}
+
 void hmp_info_memdev(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e..b48356f36f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -158,6 +158,113 @@ HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
     return machine_query_hotpluggable_cpus(ms);
 }
 
+CPUPowerStateInfoList *qmp_query_cpus_power_state(Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    CPUPowerStateInfoList *head = NULL;
+    CPUPowerStateInfoList **tail = &head;
+    CPUPowerStateInfo *info;
+    CPUState *cpu;
+
+    CPU_FOREACH_POSSIBLE(cpu, ms->possible_cpus) {
+        CPUArchId *arch_id = machine_get_possible_cpu_arch_id(cpu->cpu_index);
+        if (!arch_id) {
+            continue;
+        }
+
+        info = g_new0(CPUPowerStateInfo, 1);
+        info->id = cpu->cpu_index;
+
+        /* Optional topology fields */
+        if (arch_id->props.has_socket_id) {
+            info->socket_id = arch_id->props.socket_id;
+            info->has_socket_id = true;
+        }
+        if (arch_id->props.has_cluster_id) {
+            info->cluster_id = arch_id->props.cluster_id;
+            info->has_cluster_id = true;
+        }
+        if (arch_id->props.has_core_id) {
+            info->core_id = arch_id->props.core_id;
+            info->has_core_id = true;
+        }
+        if (arch_id->props.has_thread_id) {
+            info->thread_id = arch_id->props.thread_id;
+            info->has_thread_id = true;
+        }
+        if (arch_id->props.has_die_id) {
+            info->die_id = arch_id->props.die_id;
+            info->has_die_id = true;
+        }
+        if (arch_id->props.has_module_id) {
+            info->module_id = arch_id->props.module_id;
+            info->has_module_id = true;
+        }
+        if (arch_id->props.has_book_id) {
+            info->book_id = arch_id->props.book_id;
+            info->has_book_id = true;
+        }
+        if (arch_id->props.has_drawer_id) {
+            info->drawer_id = arch_id->props.drawer_id;
+            info->has_drawer_id = true;
+        }
+        if (arch_id->props.has_node_id) {
+            info->node_id = arch_id->props.node_id;
+            info->has_node_id = true;
+        }
+
+        info->vcpus_count = arch_id->vcpus_count;
+        info->has_vcpus_count = true;
+
+        info->qom_path = object_get_canonical_path(OBJECT(cpu));
+
+        /* Determine current power state */
+        switch (qdev_get_admin_power_state(DEVICE(cpu))) {
+        case DEVICE_ADMIN_POWER_STATE_ENABLED:
+            info->admin_state = CPU_ADMIN_POWER_STATE_ENABLED;
+            break;
+        case DEVICE_ADMIN_POWER_STATE_DISABLED:
+            info->admin_state = CPU_ADMIN_POWER_STATE_DISABLED;
+            break;
+        case DEVICE_ADMIN_POWER_STATE_REMOVED:
+            info->admin_state = CPU_ADMIN_POWER_STATE_REMOVED;
+            break;
+        default:
+            /* This should never be hit */
+            g_assert_not_reached();
+            break;
+        }
+
+        /* Determine current operational power state */
+        switch (qdev_get_oper_power_state(DEVICE(cpu))) {
+        case DEVICE_OPER_POWER_STATE_ON:
+            info->oper_state = CPU_OPER_POWER_STATE_ON;
+            break;
+        case DEVICE_OPER_POWER_STATE_OFF:
+            info->oper_state = CPU_OPER_POWER_STATE_OFF;
+            break;
+        case DEVICE_OPER_POWER_STATE_STANDBY:
+            info->oper_state = CPU_OPER_POWER_STATE_STANDBY;
+            break;
+        case DEVICE_OPER_POWER_STATE_UNKNOWN:
+            info->oper_state = CPU_OPER_POWER_STATE_UNKNOWN;
+            break;
+        default:
+            /* This should never be hit */
+            g_assert_not_reached();
+            break;
+        }
+
+        /* Add to result list */
+        CPUPowerStateInfoList *entry = g_new0(CPUPowerStateInfoList, 1);
+        entry->value = info;
+        *tail = entry;
+        tail = &entry->next;
+    }
+
+    return head;
+}
+
 void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
 {
     if (phase_check(PHASE_MACHINE_INITIALIZED)) {
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 3e8c492c28..946ccb90c1 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -142,6 +142,7 @@ void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
+void hmp_info_cpus_powerstate(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index e45740da33..3856785b27 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1069,6 +1069,93 @@
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
              'allow-preconfig': true }
 
+##
+# @CPUOperPowerState:
+#
+# Guest-visible operational state of the CPU.
+# This reflects runtime status such as guest online/offline status or
+# suspended state (e.g., CPU halted, suspended in a WFI loop).
+#
+# .. note::
+#    This field is read-only. It is derived by QEMU from runtime
+#    information (e.g., CPU execution/architectural state, PSCI power
+#    status, vCPU runstate) and cannot be set by management tools or
+#    user commands.
+#
+# @on: CPU is online and executing.
+# @standby: CPU is idle or suspended (e.g., WFI).
+# @off: CPU is guest-offlined or halted.
+# @unknown: State cannot be determined at this time (e.g., very early
+#           init/teardown, transient hotplug/hotremove window, no
+#           power-state handler registered, or the target/platform does
+#           not expose a queryable CPU state).
+##
+{ 'enum': 'CPUOperPowerState',
+  'data': ['on', 'standby', 'off', 'unknown'] }
+
+##
+# @CPUAdminPowerState:
+#
+# Host-side administrative power state of the CPU device.
+# Controls guest visibility and lifecycle.
+#
+# @enabled: CPU is administratively enabled (can be used by guest)
+# @disabled: CPU is administratively disabled (guest-visible but unusable)
+# @removed: CPU is logically removed (not visible to guest)
+##
+{ 'enum': 'CPUAdminPowerState',
+  'data': ['enabled', 'disabled', 'removed'] }
+
+##
+# @CPUPowerStateInfo:
+#
+# CPU status combining both administrative and operational/runtime state.
+#
+# @id: CPU index
+# @core-id: Core ID (optional)
+# @socket-id: Socket ID (optional)
+# @cluster-id: Cluster ID (optional)
+# @thread-id: Thread ID (optional)
+# @node-id: NUMA node ID (optional)
+# @drawer-id: Drawer ID (optional)
+# @book-id: Book ID (optional)
+# @die-id: Die ID (optional)
+# @module-id: Module ID (optional)
+# @vcpus-count: Number of threads under this logical CPU (optional)
+# @qom-path: QOM object path (optional)
+# @admin-state: Administrative power state (enabled/disabled/removed)
+# @oper-state: Guest-visible runtime power state (on/standby/off)
+##
+{ 'struct': 'CPUPowerStateInfo',
+  'data': {
+    'id': 'int',
+    '*core-id': 'int',
+    '*socket-id': 'int',
+    '*cluster-id': 'int',
+    '*thread-id': 'int',
+    '*node-id': 'int',
+    '*drawer-id': 'int',
+    '*book-id': 'int',
+    '*die-id': 'int',
+    '*module-id': 'int',
+    '*vcpus-count': 'int',
+    '*qom-path': 'str',
+    'admin-state': 'CPUAdminPowerState',
+    'oper-state': 'CPUOperPowerState'
+  } }
+
+##
+# @query-cpus-power-state:
+#
+# Returns all CPUs and their power state info, combining host policy and
+# runtime guest status. This is useful for debugging vCPU hotplug,
+# suspend/resume, admin power states or offline state flows.
+#
+# Returns: a list of @CPUPowerStateInfo
+##
+{ 'command': 'query-cpus-power-state',
+  'returns': ['CPUPowerStateInfo'] }
+
 ##
 # @set-numa-node:
 #
-- 
2.34.1


