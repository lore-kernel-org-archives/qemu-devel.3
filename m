Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8618C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDF7-0000VM-1k; Tue, 23 Jul 2024 06:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEq-0008P8-Cn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEn-0002LO-I6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+5K6DenD/BNBvf8O7CFbeMuv8YmbqeLYA/hq2CgnkY=;
 b=hG9fCVv1qjBeZ6VhDAZa212tt0TiZjelbvYUsT/5G7ivbuqLfp8ukQPG2FPwAX75vVr9Vs
 brr25rWBMlORJCu+bFBxPSb693a3Fouyd3H4HsGl0GAa1+33cEzmSAo34ka42M1QLOvEJz
 M08EUVNfdTfcXmGE55UX630j6FBhcQM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-b_sODgK-OkemPukwQ_Ex7w-1; Tue, 23 Jul 2024 06:59:19 -0400
X-MC-Unique: b_sODgK-OkemPukwQ_Ex7w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77f0eca759so399699966b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732357; x=1722337157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+5K6DenD/BNBvf8O7CFbeMuv8YmbqeLYA/hq2CgnkY=;
 b=b8KfkegxTwRdY1DiqQpj+KO5BtTnxNHbMV/HkzV/fulOnWOAffgqKTMBs8TDteWSXf
 DIq7q/gmmJXKRyhU+Go+18cU8HyfXrPAq1M0WlBaLJlChu4/LRv6UOc/zK7+uiytjLTz
 phPSGBSZqTrosKXCB9Skp1LH1rXyhaB2lsZTLSG1d+/grvLA07jcmTfYSECXL17A44xp
 juxj3GHGGJoOBYv88F+0+ETnPQ6ILR5rEULK2ulI6D2tB61Tm4BXv1l1d+gu3zSOeyIS
 JtNVFAkNdnsIvwQblBh3AkxN9BPZsWFviRj0fqhs0Laoe0EoLV6v6Q1ew+PJKeBOBh5v
 kiBQ==
X-Gm-Message-State: AOJu0Yx8O3ciBZpCyUtfHx0wVnHS6bqQhcV5mQxH98JLi8Duis/p2/KD
 G9Ch0Fu6CTy7v+MKTEVcD9X12WyVsDX0RUT99xXpteIFsctGzP6rf26qbPwMT4IZI2yWG79nmcM
 2A3FdiQeKKKfclt0N/aowHFIz0+9TllMKJEHyY9ESOtKsfRVUNpHDzwX9sDofFveUYXRuI5HcVn
 Fg4LK7p59A+iQI+RrSHCC04mVTIjnJFA==
X-Received: by 2002:a17:907:3f0a:b0:a7a:a138:dbc5 with SMTP id
 a640c23a62f3a-a7aa138e2e2mr76768966b.65.1721732357589; 
 Tue, 23 Jul 2024 03:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLpCrlLhamV0OrNTZjlgfyDV53/NhAPnUho+nlyyFEhzDphz9o/9Xmz/lTg/1zhuphCywJjA==
X-Received: by 2002:a17:907:3f0a:b0:a7a:a138:dbc5 with SMTP id
 a640c23a62f3a-a7aa138e2e2mr76766266b.65.1721732356989; 
 Tue, 23 Jul 2024 03:59:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c9510fcsm525971766b.218.2024.07.23.03.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:16 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 39/61] hw/acpi: Update ACPI GED framework to support vCPU
 Hotplug
Message-ID: <06f1f4958be70f14f527d1f03d1e9a141650bbc5.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
_CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
notified event by evaluating ACPI _EVT method to know the type of event. Use
ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.

Note, GED interface is used by many hotplug events like memory hotplug, NVDIMM
hotplug and non-hotplug events like system power down event. Each of these can
be selected using a bit in the 32 bit GED IO interface. A bit has been reserved
for the CPU hotplug event.

ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
stub to avoid compilation break.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240716111502.202344-4-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  4 +++
 hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++
 hw/acpi/generic_event_device.c         | 47 ++++++++++++++++++++++++++
 docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index ba84ce0214..e091ac2108 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -62,6 +62,7 @@
 #include "hw/sysbus.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
+#include "hw/acpi/cpu.h"
 #include "qom/object.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
+#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -106,6 +108,8 @@ struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     MemoryRegion container_memhp;
+    CPUHotplugState cpuhp_state;
+    MemoryRegion container_cpuhp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 3fc4b14c26..c6c61bb9cd 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     return;
 }
 
+void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
+                         CPUHotplugState *state, hwaddr base_addr)
+{
+    return;
+}
+
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
     return;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 2d6e91b124..4641933a0f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
+    ACPI_GED_CPU_HOTPLUG_EVT,
 };
 
 /*
@@ -234,6 +235,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
         } else {
             acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
         }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "virt: device plug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -248,6 +251,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
     if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
                        !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
         acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -261,6 +266,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -272,6 +279,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     AcpiGedState *s = ACPI_GED(adev);
 
     acpi_memory_ospm_status(&s->memhp_state, list);
+    acpi_cpu_ospm_status(&s->cpuhp_state, list);
 }
 
 static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
@@ -286,6 +294,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_PWR_DOWN_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
+        sel = ACPI_GED_CPU_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
@@ -371,6 +381,42 @@ static const VMStateDescription vmstate_acpi_ged = {
     }
 };
 
+static void acpi_ged_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AcpiGedState *s = ACPI_GED(dev);
+    uint32_t ged_events;
+    int i;
+
+    ged_events = ctpop32(s->ged_event_bitmap);
+
+    for (i = 0; i < ARRAY_SIZE(ged_supported_events) && ged_events; i++) {
+        uint32_t event = s->ged_event_bitmap & ged_supported_events[i];
+
+        if (!event) {
+            continue;
+        }
+
+        switch (event) {
+        case ACPI_GED_CPU_HOTPLUG_EVT:
+            /* initialize CPU Hotplug related regions */
+            memory_region_init(&s->container_cpuhp, OBJECT(dev),
+                                "cpuhp container",
+                                ACPI_CPU_HOTPLUG_REG_LEN);
+            sysbus_init_mmio(sbd, &s->container_cpuhp);
+            cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
+                                &s->cpuhp_state, 0);
+            break;
+        }
+        ged_events--;
+    }
+
+    if (ged_events) {
+        error_report("Unsupported events specified");
+        abort();
+    }
+}
+
 static void acpi_ged_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -411,6 +457,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
     dc->desc = "ACPI Generic Event Device";
     device_class_set_props(dc, acpi_ged_properties);
     dc->vmsd = &vmstate_acpi_ged;
+    dc->realize = acpi_ged_realize;
 
     hc->plug = acpi_ged_device_plug_cb;
     hc->unplug_request = acpi_ged_unplug_request_cb;
diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
index 0bd3f9399f..3acd6fcd8b 100644
--- a/docs/specs/acpi_hw_reduced_hotplug.rst
+++ b/docs/specs/acpi_hw_reduced_hotplug.rst
@@ -64,7 +64,8 @@ GED IO interface (4 byte access)
        0: Memory hotplug event
        1: System power down event
        2: NVDIMM hotplug event
-    3-31: Reserved
+       3: CPU hotplug event
+    4-31: Reserved
 
 **write_access:**
 
-- 
MST


