Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B33CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGM-0005f2-Df; Tue, 30 Sep 2025 21:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFk-0005QN-Ik
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lF8-00087z-FC
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:32 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso45689485e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280568; x=1759885368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxcfPHc8rOInaK/rBPQBZ9/nywW3P+jwOuWG6ZmnnIw=;
 b=LrUfQu/CRRqn+JPcbzo/gDpz7F3WiOkWEz0jnPSuKO06Pcl2yPND/qZPGmeqlJE6AB
 VQxbdXFbiAXsmAQM4KDfS2HY6qQxfu6NnpKoV/VXj6yIgYnNKsF0sD4Hj4M/H2aQYfBs
 nHJWuDet2quDVL9yQJEGTTDpHutflFmZkF542W1m01w1NIY9bFGBaID8u0TcBuZk2jwh
 7vo95N7gXqhaGwOmh5JnJ0GePkwgl941RL47AfGxM+r8QcVHDzCKOufYOf7UeMvL1nWA
 xKufYxQ4FpmXx2KEExm/XQ0a2I7ENQBGOaA/cOm4ZbNf0Kerv3Qg99Eu3bdkNpnE3sVW
 Pn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280568; x=1759885368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxcfPHc8rOInaK/rBPQBZ9/nywW3P+jwOuWG6ZmnnIw=;
 b=WsvQwqrq/hutaH4YbkDl3r1sbpIOon4eG05OUIFjhWSPkjQXxGI4vIp9GyP6cfLR6E
 BJ9iYpkgzxhPZqzhbKFJ8GPCoP5Gb22JRBkllmiZbSnbt38T4D+T8GMzJZnp0n3caxkm
 kCvJ3nbesd3dHsq5NmgzZh2yUDGF/oZKrEsVbP/mn1wCzkhP7GDJmPwczwg/S8Y+jjco
 Ic3Vdy08otEitvABlvaIL4rbZ6Z6/NOa2yVtkcoM9iGnOklKDtNCYKYBNhv9nvBfb/kj
 QPkP+VyO7bS6wj727sCL8JVD0fiBzbP3QQLPydvrvROUMf0CHbCLSC3lBQukje9L2Ktc
 hSfw==
X-Gm-Message-State: AOJu0Yzh2yJsN/2X/yUOZx45grAnFFPzhO3mQCQEWN5ctTUdoRpSlHgx
 /skeLEBgQpBW17zIrZmpa514nSxibiTgFu8fZ4i0YmwAVM41WmoTrciI+7J5Ax41iaZkzxrFYde
 T6klV1w3jsQ==
X-Gm-Gg: ASbGncvugNuix9ugo68al6IXuRbZ6ZUAk53p7Rg4360Su5iXQZpqd6p0Gj+wFqTbvHF
 MEhh/mxJXtdf47JzojvRHhB34DBbwAcIuGAUrhlcAgcfGssTiEZRXt7nmDr61/zLW4k+r1azghJ
 3lfjr09IaJQOpvbuWcDPDW4TSoTXnw52oFglSuCgxY9VadE47c2pq3azE9RaXl5YEzF7rgmsqXR
 Hvj4VZ3YDntD8i7/KOVWje2GFcosWpuUBHt4Nzoe1G84K0MZzsxRoH8DTwJTgpfNf9k140e2IkM
 t0fjulyMOuldYY/6nWvpd8m3lhdzyuW7pUw3saO953pKBrhfQrEN1G10dRYk4ChwVbZRO7xHZT0
 VPAbnbxcZYHhUWcIKIm+pUFQgn0PSIzhO0bnuDEn7v89Tjd1zjBVXKBLheXUNZyPlfxHOr1GNWJ
 gnJuuSGO5r5PphgQ/dcedz+GZ4G+lVJfTd5PhOjcuWZYQ=
X-Google-Smtp-Source: AGHT+IGj/RZIjav8CCq0VUnatmGH+py6HOaa0NVdgzVsL0LeYJoCeBhWny/xhFaB2PnT0N0oVITBkw==
X-Received: by 2002:a5d:5f52:0:b0:3ff:d5c5:6b03 with SMTP id
 ffacd0b85a97d-4255781466fmr1134196f8f.35.1759280567800; 
 Tue, 30 Sep 2025 18:02:47 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:46 -0700 (PDT)
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
Subject: [PATCH RFC V6 15/24] acpi/ged: Notify OSPM of CPU administrative
 state changes via GED
Date: Wed,  1 Oct 2025 01:01:18 +0000
Message-Id: <20251001010127.3092631-16-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32c.google.com
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

When vCPUs are administratively enabled or disabled, the guest OSPM must be
notified so it can coordinate the corresponding operational transitions and
preserve system stability.

When a CPU is administratively enabled, GED raises a Device Check event. OSPM
then uses the ACPI _EVT handler to identify the CPU device and evaluates its
_STA, ensuring the CPU is identified, registered with the Linux device model,
enabled in the guest kernel, and made available to the scheduler.

When a CPU is administratively disabled, GED raises an Eject Request event. OSPM
again uses the ACPI _EVT handler to identify the CPU device and evaluates its
_STA, marking the CPU absent. This allows OSPM to invoke the _EJ0 path,
gracefully offload tasks, and shut down state before removal. Without this
coordination, CPUs may be forcefully removed, risking state loss or kernel
instability.

Platform code (e.g. Arm virt machine) calls PowerStateHandler hooks, which in
turn drive the GED callbacks. Those callbacks use ACPI events to reflect the
administrative change and let OSPM orchestrate the operational transition.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/generic_event_device.c         | 91 ++++++++++++++++++++++++++
 hw/arm/virt.c                          |  9 ++-
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/generic_event_device.h |  6 ++
 include/hw/arm/virt.h                  |  1 +
 5 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 95682b79a2..4fbf5aaa20 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -23,11 +23,13 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "system/runstate.h"
+#include "hw/powerstate.h"
 
 static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
+    ACPI_GED_CPU_POWERSTATE_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
     ACPI_GED_PCI_HOTPLUG_EVT,
 };
@@ -112,6 +114,9 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                 aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
                                              MEMORY_SLOT_SCAN_METHOD));
                 break;
+            case ACPI_GED_CPU_POWERSTATE_EVT:
+                aml_append(if_ctx, aml_call0(AML_GED_EVT_CPUPS_SCAN_METHOD));
+                break;
             case ACPI_GED_CPU_HOTPLUG_EVT:
                 aml_append(if_ctx, aml_call0(AML_GED_EVT_CPU_SCAN_METHOD));
                 break;
@@ -302,12 +307,57 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void
+acpi_ged_pre_poweron_cb(PowerStateHandler *handler, DeviceState *dev,
+                        Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(handler);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_device_check_cb(&s->cpuospm_state, dev,
+                                  ACPI_CPU_POWERSTATE_STATUS, errp);
+    } else {
+        error_setg(errp, "acpi: poweron transition on unsupported device"
+                   " type %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void
+acpi_ged_request_poweroff_cb(PowerStateHandler *handler, DeviceState *dev,
+                             Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(handler);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_eject_request_cb(&s->cpuospm_state, dev,
+                                  ACPI_CPU_POWERSTATE_STATUS, errp);
+    } else {
+        error_setg(errp, "acpi: poweroff transition request for unsupported"
+                   " device type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void
+acpi_ged_post_poweroff_cb(PowerStateHandler *handler, DeviceState *dev,
+                          Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(handler);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_eject_cb(&s->cpuospm_state, dev, errp);
+    } else {
+        error_setg(errp, "acpi: post poweroff handling on unsupported device"
+                   " type %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
 static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
 {
     AcpiGedState *s = ACPI_GED(adev);
 
     acpi_memory_ospm_status(&s->memhp_state, list);
     acpi_cpu_ospm_status(&s->cpuhp_state, list);
+    acpi_cpus_ospm_status(&s->cpuospm_state, list);
 }
 
 static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
@@ -322,6 +372,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_PWR_DOWN_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    } else if (ev & ACPI_CPU_POWERSTATE_STATUS) {
+        sel = ACPI_GED_CPU_POWERSTATE_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
         sel = ACPI_GED_CPU_HOTPLUG_EVT;
     } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
@@ -379,6 +431,24 @@ static const VMStateDescription vmstate_cpuhp_state = {
     }
 };
 
+static bool cpuospm_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_online_capable_cpus;
+}
+
+static const VMStateDescription vmstate_cpuospm_state = {
+    .name = "acpi-ged/cpu-ospm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpuospm_needed,
+    .fields      = (VMStateField[]) {
+        VMSTATE_CPU_OSPM_STATE(cpuospm_state, AcpiGedState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
     .version_id = 1,
@@ -447,6 +517,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
         &vmstate_cpuhp_state,
+        &vmstate_cpuospm_state,
         &vmstate_ghes_state,
         &vmstate_pcihp_state,
         NULL
@@ -461,6 +532,8 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
     uint32_t ged_events;
     int i;
 
+    s->cpuospm_state.acpi_dev = dev;
+
     if (pcihp_state->use_acpi_hotplug_bridge) {
         s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
     }
@@ -474,6 +547,18 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
         }
 
         switch (event) {
+        case ACPI_GED_CPU_POWERSTATE_EVT:
+            /* initialize regions related to CPU OSPM interface to be used
+             * during notification of the power-on,off events to the OSPM
+             */
+            memory_region_init(&s->container_cpuospm, OBJECT(dev),
+                               ACPI_CPUOSPM_REGION_NAME,
+                               ACPI_CPU_OSPM_IF_REG_LEN);
+            sysbus_init_mmio(sbd, &s->container_cpuospm);
+            acpi_cpu_ospm_state_interface_init(&s->container_cpuospm,
+                                               OBJECT(dev),
+                                               &s->cpuospm_state, 0);
+            break;
         case ACPI_GED_CPU_HOTPLUG_EVT:
             /* initialize CPU Hotplug related regions */
             memory_region_init(&s->container_cpuhp, OBJECT(dev),
@@ -544,6 +629,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
+    PowerStateHandlerClass *pshc = POWERSTATE_HANDLER_CLASS(class);
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
     ResettableClass *rc = RESETTABLE_CLASS(class);
     AcpiGedClass *gedc = ACPI_GED_CLASS(class);
@@ -560,6 +646,10 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
     resettable_class_set_parent_phases(rc, NULL, ged_reset_hold, NULL,
                                        &gedc->parent_phases);
 
+    pshc->pre_poweron = acpi_ged_pre_poweron_cb;
+    pshc->request_poweroff = acpi_ged_request_poweroff_cb;
+    pshc->post_poweroff = acpi_ged_post_poweroff_cb;
+
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
 }
@@ -573,6 +663,7 @@ static const TypeInfo acpi_ged_info = {
     .class_size    = sizeof(AcpiGedClass),
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { TYPE_POWERSTATE_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
         { }
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3980f553db..8d498708ab 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -188,6 +188,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
+    [VIRT_ACPI_CPUPS] =         { 0x090d0000, ACPI_CPU_OSPM_IF_REG_LEN },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -688,9 +689,10 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_CPU_POWERSTATE_EVT;
     bool acpi_pcihp;
 
     if (ms->ram_slots) {
@@ -711,6 +713,11 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
                          vms->memmap[VIRT_PCDIMM_ACPI].base);
 
+    if (mc->has_online_capable_cpus) {
+        sysbus_mmio_map_name(sbdev, ACPI_CPUOSPM_REGION_NAME,
+                             vms->memmap[VIRT_ACPI_CPUPS].base);
+    }
+
     acpi_pcihp = object_property_get_bool(OBJECT(dev),
                                           ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, NULL);
 
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..eea03ca47d 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_CPU_POWERSTATE_STATUS = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 2c5b055327..87e4e5e6ce 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -64,6 +64,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/pcihp.h"
+#include "hw/acpi/cpu_ospm_interface.h"
 #include "qom/object.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -92,6 +93,7 @@ OBJECT_DECLARE_TYPE(AcpiGedState, AcpiGedClass, ACPI_GED)
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
 #define AML_GED_EVT_CPU_SCAN_METHOD "\\_SB.GED.CSCN"
+#define AML_GED_EVT_CPUPS_SCAN_METHOD "\\_SB.GED.PSCN"  /* Power State Scan */
 
 /*
  * Platforms need to specify the GED event bitmap
@@ -103,6 +105,7 @@ OBJECT_DECLARE_TYPE(AcpiGedState, AcpiGedClass, ACPI_GED)
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 #define ACPI_GED_PCI_HOTPLUG_EVT    0x10
+#define ACPI_GED_CPU_POWERSTATE_EVT 0x20
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -112,6 +115,7 @@ typedef struct GEDState {
 
 #define ACPI_PCIHP_REGION_NAME "pcihp container"
 #define ACPI_MEMHP_REGION_NAME "memhp container"
+#define ACPI_CPUOSPM_REGION_NAME "cpuospm container"
 
 struct AcpiGedState {
     SysBusDevice parent_obj;
@@ -121,6 +125,8 @@ struct AcpiGedState {
     MemoryRegion container_cpuhp;
     AcpiPciHpState pcihp_state;
     MemoryRegion container_pcihp;
+    AcpiCpuOspmState cpuospm_state;
+    MemoryRegion container_cpuospm;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 02cc311452..68081b79bb 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -81,6 +81,7 @@ enum {
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
     VIRT_ACPI_PCIHP,
+    VIRT_ACPI_CPUPS,
     VIRT_LOWMEMMAP_LAST,
 };
 
-- 
2.34.1


