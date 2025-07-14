Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4529C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSLl-0008Vq-A9; Mon, 14 Jul 2025 19:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIh-0004lk-UK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIe-0005u6-TS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQNHSRwys1OpaB1ilXn8N+IA7K18jcvtXblvgfOk7GQ=;
 b=LSBMKGaNpwuo440Z67I4O/Y1DnFEkC1IgJuxIKDI2AUVHKswOM8gfWjiHAB/lFOR6DVNya
 BHeyghEprm3lB9kW13fWV+3jK3p5lLAxPCQfdLVbEcNqG6HdGXjIhthmCEu3cyfRPQ5rT1
 rf//B4dz0HwmxqVTjYvYk/bb++4TTnc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-9Ad1pC_oPYmVbsWNZT996Q-1; Mon, 14 Jul 2025 19:09:31 -0400
X-MC-Unique: 9Ad1pC_oPYmVbsWNZT996Q-1
X-Mimecast-MFC-AGG-ID: 9Ad1pC_oPYmVbsWNZT996Q_1752534570
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45626532e27so1772515e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534569; x=1753139369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQNHSRwys1OpaB1ilXn8N+IA7K18jcvtXblvgfOk7GQ=;
 b=hkJql4Sn1KZLw0n0mtHXWUztOM6SOHswxz3ESct80mn6Jy+Nvs4PhIPYk9c0gMzyh2
 RKu2NjP7jp89rzq/KKEibmyygMCrgu3QF9bVO2fUtf0pDw/8fHGd2aGJy9+pBdK9kFIN
 k8wtt+NjImi7U2W39XT4bvpyw/pJZnWERMfbOXkRe3RsyT3NXw2KqgzPTc/Ft/QwXqan
 2DWNozJiy8kNtJ9/+ts6D0AVvCEE8TnXHm7sFA1MIAOFZgX5ZQIHpSfjVPRA6l1gNAzp
 5Vy+2ydYTYAb3BxSOQsNR6qt29Xfgt50DvSXuS7mWH2LrTNfxbMPCkGbjzXb0EgWf1hV
 t7lA==
X-Gm-Message-State: AOJu0Yx2eokF19KlBqVGyqD/VP4axbAGsm94UB6d0Q0slRKWvo1ovwGz
 XcqaFfEnULkojlZrRu8cytRVQzaATsAip3tQQVB3j877iu3G4rds0EUnB0Xeg/2CDJISW03w/sX
 mxOtxdTvXHbMi1N38tDOzdyjteV5qFRel824BGzPFWMY4a3K82+IsWhpFJbCXX+mhUZ5XZ35OWP
 eruEReXwQneUVE3Cpzrnp97/9/CHdmFbDThg==
X-Gm-Gg: ASbGncsVvk+sqQc9nIZB1VmWj/nOgWRcprgjGFC5fMr4Q72G5/uVEh/dPkGND+fshoy
 KRNT3K8lQbK3uHI8OOxbC85qsvtywKcKrBOHh4AvKRNeQ8I0Y7d1kAbuKyQblT4Cya8XbM6paiR
 EhRDHsEqutbJhBx30ogdQc3RdDnAAD+kMV7NllWcNUjLj5g9o+X/QZO7HCNa8IAB4gc+Y+ll1FR
 9b0Y6tUoa9QirJvzZP42EV8YCLJDFIT817VEqq2kYpWBQOoAYjO+CaCAFnfCY99V7ZqebCwwix7
 LoKPye2bfW53qIrqbFgAlFsWXMULiB08
X-Received: by 2002:a05:600c:138d:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-45565edcb1emr111754595e9.26.1752534569451; 
 Mon, 14 Jul 2025 16:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL3UFtkIylaf2lRGIEE6l+rDW7M3DPp6lvk8JK1y8Q452p96zU0MDz7RcsopuDTLFtp+6TdQ==
X-Received: by 2002:a05:600c:138d:b0:453:697:6f08 with SMTP id
 5b1f17b1804b1-45565edcb1emr111754355e9.26.1752534568911; 
 Mon, 14 Jul 2025 16:09:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627898725sm1724035e9.1.2025.07.14.16.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 74/97] hw/acpi/ged: Prepare the device to react to PCI hotplug
 events
Message-ID: <03a83fb2d10a9e2a97d5a8e9a770552515706483.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

QEMU will notify the OS about PCI hotplug/hotunplug events through
GED interrupts. Let the GED device handle a new PCI hotplug event.
On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
mutex held.

The GED device uses a dedicated MMIO region that will be mapped
by the machine code.

At this point the GED still does not support PCI device hotplug in
its TYPE_HOTPLUG_HANDLER implementation. This will come in a
subsequent patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-29-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h | 14 ++++++++++-
 hw/acpi/generic_event_device.c         | 35 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index f5ffa67a39..d56adaa626 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -69,7 +69,7 @@
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
 
 #define TYPE_ACPI_GED "acpi-ged"
-OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
+OBJECT_DECLARE_TYPE(AcpiGedState, AcpiGedClass, ACPI_GED)
 
 #define ACPI_GED_EVT_SEL_OFFSET    0x0
 #define ACPI_GED_EVT_SEL_LEN       0x4
@@ -102,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -109,6 +110,8 @@ typedef struct GEDState {
     uint32_t     sel;
 } GEDState;
 
+#define ACPI_PCIHP_REGION_NAME "pcihp container"
+
 struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
@@ -116,12 +119,21 @@ struct AcpiGedState {
     CPUHotplugState cpuhp_state;
     MemoryRegion container_cpuhp;
     AcpiPciHpState pcihp_state;
+    MemoryRegion container_pcihp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
     AcpiGhesState ghes_state;
 };
 
+typedef struct AcpiGedClass {
+    /* <private> */
+    SysBusDeviceClass parent_class;
+
+    /*< public >*/
+    ResettablePhases parent_phases;
+} AcpiGedClass;
+
 void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
 void acpi_dsdt_add_power_button(Aml *scope);
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 92b931758f..7535d07737 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
@@ -28,6 +29,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_PCI_HOTPLUG_EVT,
 };
 
 /*
@@ -123,6 +125,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name("\\_SB.NVDR"),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_PCI_HOTPLUG_EVT:
+                aml_append(if_ctx,
+                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
+                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
+                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
+                break;
             default:
                 /*
                  * Please make sure all the events in ged_supported_events[]
@@ -316,6 +324,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
         sel = ACPI_GED_CPU_HOTPLUG_EVT;
+    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
+        sel = ACPI_GED_PCI_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
@@ -427,9 +437,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AcpiGedState *s = ACPI_GED(dev);
+    AcpiPciHpState *pcihp_state = &s->pcihp_state;
     uint32_t ged_events;
     int i;
 
+    if (pcihp_state->use_acpi_hotplug_bridge) {
+        s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
+    }
     ged_events = ctpop32(s->ged_event_bitmap);
 
     for (i = 0; i < ARRAY_SIZE(ged_supported_events) && ged_events; i++) {
@@ -449,6 +463,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
             cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
                                 &s->cpuhp_state, 0);
             break;
+        case ACPI_GED_PCI_HOTPLUG_EVT:
+            memory_region_init(&s->container_pcihp, OBJECT(dev),
+                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
+            sysbus_init_mmio(sbd, &s->container_pcihp);
+            acpi_pcihp_init(OBJECT(s), &s->pcihp_state,
+                            &s->container_pcihp, 0);
+            qbus_set_hotplug_handler(BUS(s->pcihp_state.root), OBJECT(dev));
         }
         ged_events--;
     }
@@ -490,11 +511,22 @@ static void acpi_ged_initfn(Object *obj)
     sysbus_init_mmio(sbd, &ged_st->regs);
 }
 
+static void ged_reset_hold(Object *obj, ResetType type)
+{
+    AcpiGedState *s = ACPI_GED(obj);
+
+    if (s->pcihp_state.use_acpi_hotplug_bridge) {
+        acpi_pcihp_reset(&s->pcihp_state);
+    }
+}
+
 static void acpi_ged_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
+    AcpiGedClass *gedc = ACPI_GED_CLASS(class);
 
     dc->desc = "ACPI Generic Event Device";
     device_class_set_props(dc, acpi_ged_properties);
@@ -505,6 +537,8 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
     hc->plug = acpi_ged_device_plug_cb;
     hc->unplug_request = acpi_ged_unplug_request_cb;
     hc->unplug = acpi_ged_unplug_cb;
+    resettable_class_set_parent_phases(rc, NULL, ged_reset_hold, NULL,
+                                       &gedc->parent_phases);
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
@@ -516,6 +550,7 @@ static const TypeInfo acpi_ged_info = {
     .instance_size = sizeof(AcpiGedState),
     .instance_init  = acpi_ged_initfn,
     .class_init    = acpi_ged_class_init,
+    .class_size    = sizeof(AcpiGedClass),
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
-- 
MST


