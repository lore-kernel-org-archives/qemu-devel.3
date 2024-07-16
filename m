Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E04AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjYT-0007UU-Rg; Tue, 16 Jul 2024 10:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjYR-0007LI-J4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjYP-0005op-1s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721141600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYk17DpTXgnKJoJV13J9NrBKiIDX5Oo+kvtC/bXXRxA=;
 b=W02zI2DX80USQIel3vaHZRcT+xGfXT0scpXUEMG7JlHRQRWQzvrRrP8UvM6Gfy3GhZbbW9
 /C0Cfh+VfeKrxOlxBDyV812LduWHbnKWoiJsvIz9hB3KAiM8u41/rrOKwhJyU+GKTzQET/
 Y4qj3SDluDpNsWDd424ghMz4n6GxZoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YhPliVzDMZWh3evo7Gh0sQ-1; Tue, 16 Jul 2024 10:53:19 -0400
X-MC-Unique: YhPliVzDMZWh3evo7Gh0sQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4266945770eso37115385e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141598; x=1721746398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYk17DpTXgnKJoJV13J9NrBKiIDX5Oo+kvtC/bXXRxA=;
 b=L3Xt8twrGvE8lbrhrYiNMdCAwIFhab2uC1gChCMie2BLN6g1HUDKkFKnW9X1NChGf2
 xh11rKnowWSWHAGmcm4HjyN7TBgKKuKc4cOBs4YFQi052Smjzm3lgV574vG601h+ixur
 gDNVnIEvYUgXqvMwD04elvQG+wnoJfPmMnz6TO0JLykKKdCU6O1Iwe1H5ivmmwzFRuvf
 UsCkbFvTm5ee+AgEFMchGTy5vvT119h7+b9WprZ+QUxNgpdi/ay6UF/b9PeMFeNo2XhH
 nGi85dna1wJVmHtW4IakS+q9zQjj+IwyBiMo3er4cqAR8tcFj5fmDZGZp9LFdvAfFgg2
 JlLg==
X-Gm-Message-State: AOJu0YxI3xxU0+HbDu8B5rVv8kqfXVVV+sqk39UKcFmIN4tbQYklqtNK
 AY75oiOeZzt1RMQarOIa3OnQCmLOIlLuOeFyMvOCm3rg3HfifBPyG8AsYfFNsvIA384q3tHyFov
 2TeKsYuoYn0BoIi7wzawwP1Gwet+7kYnz5WxpMvcnq0nKDRB8pe3I
X-Received: by 2002:a05:600c:4e4a:b0:426:618f:1a31 with SMTP id
 5b1f17b1804b1-427ba71dae7mr17135915e9.34.1721141597749; 
 Tue, 16 Jul 2024 07:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyhIVfSzRUNFI0qpcHxYaO7e/euP8ROUtuBTiTCQoTnqzOtA8Sn9A80UvuaAt4YQfGXhsPWA==
X-Received: by 2002:a05:600c:4e4a:b0:426:618f:1a31 with SMTP id
 5b1f17b1804b1-427ba71dae7mr17135605e9.34.1721141597279; 
 Tue, 16 Jul 2024 07:53:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc306sm167570505e9.30.2024.07.16.07.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:53:16 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:53:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V16 3/7] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <20240716165315.4862e1a0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240716111502.202344-4-salil.mehta@huawei.com>
References: <20240716111502.202344-1-salil.mehta@huawei.com>
 <20240716111502.202344-4-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, 16 Jul 2024 12:14:58 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
> _CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
> notified event by evaluating ACPI _EVT method to know the type of event. Use
> ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.
> 
> Note, GED interface is used by many hotplug events like memory hotplug, NVDIMM
> hotplug and non-hotplug events like system power down event. Each of these can
> be selected using a bit in the 32 bit GED IO interface. A bit has been reserved
> for the CPU hotplug event.
> 
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

I haven't tested it but looks fine to me,
it missing migration bits, but as long as there is no actual users
in this release it could be a patch on top later on.

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++
>  hw/acpi/generic_event_device.c         | 47 ++++++++++++++++++++++++++
>  include/hw/acpi/generic_event_device.h |  4 +++
>  4 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> index 0bd3f9399f..3acd6fcd8b 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>         0: Memory hotplug event
>         1: System power down event
>         2: NVDIMM hotplug event
> -    3-31: Reserved
> +       3: CPU hotplug event
> +    4-31: Reserved
>  
>  **write_access:**
>  
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>      return;
>  }
>  
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>  {
>      return;
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 2d6e91b124..4641933a0f 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>  };
>  
>  /*
> @@ -234,6 +235,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -248,6 +251,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -261,6 +266,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -272,6 +279,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>      AcpiGedState *s = ACPI_GED(adev);
>  
>      acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
>  
>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -286,6 +294,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_PWR_DOWN_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -371,6 +381,42 @@ static const VMStateDescription vmstate_acpi_ged = {
>      }
>  };
>  
> +static void acpi_ged_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AcpiGedState *s = ACPI_GED(dev);
> +    uint32_t ged_events;
> +    int i;
> +
> +    ged_events = ctpop32(s->ged_event_bitmap);
> +
> +    for (i = 0; i < ARRAY_SIZE(ged_supported_events) && ged_events; i++) {
> +        uint32_t event = s->ged_event_bitmap & ged_supported_events[i];
> +
> +        if (!event) {
> +            continue;
> +        }
> +
> +        switch (event) {
> +        case ACPI_GED_CPU_HOTPLUG_EVT:
> +            /* initialize CPU Hotplug related regions */
> +            memory_region_init(&s->container_cpuhp, OBJECT(dev),
> +                                "cpuhp container",
> +                                ACPI_CPU_HOTPLUG_REG_LEN);
> +            sysbus_init_mmio(sbd, &s->container_cpuhp);
> +            cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                                &s->cpuhp_state, 0);
> +            break;
> +        }
> +        ged_events--;
> +    }
> +
> +    if (ged_events) {
> +        error_report("Unsupported events specified");
> +        abort();
> +    }
> +}
> +
>  static void acpi_ged_initfn(Object *obj)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -411,6 +457,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
>      dc->desc = "ACPI Generic Event Device";
>      device_class_set_props(dc, acpi_ged_properties);
>      dc->vmsd = &vmstate_acpi_ged;
> +    dc->realize = acpi_ged_realize;
>  
>      hc->plug = acpi_ged_device_plug_cb;
>      hc->unplug_request = acpi_ged_unplug_request_cb;
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce0214..e091ac2108 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -62,6 +62,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/ghes.h"
> +#include "hw/acpi/cpu.h"
>  #include "qom/object.h"
>  
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -106,6 +108,8 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;


