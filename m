Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67D4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLVX-0006VT-Nj; Mon, 15 Jul 2024 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLVR-00065G-7i
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLVP-00028W-0Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721049157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xt3uGPIDJBWbyBlAMkf9wmgaGHAIPk6TxUEUYB+a70=;
 b=L/KV3ZkWpqkU3GiF9aFXqWpmnHb/VV0hYnx5l0k/h2S5L/c2HbtHWlP5lzKRuPVQb8jrdE
 iKB9fDTXOxKfeeyZl3fi9RSNz6Yp9P8cd8GbqFxevjdYoBw4t14cxCcfTQ+IIM24jfre/T
 ii9Dtc2Kv7vAhsYJaDRwF+IeG0NdgOA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-3hxQjzAXN8SkEenSW4bgGA-1; Mon, 15 Jul 2024 09:12:36 -0400
X-MC-Unique: 3hxQjzAXN8SkEenSW4bgGA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52e98c1a9d2so4631716e87.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721049154; x=1721653954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xt3uGPIDJBWbyBlAMkf9wmgaGHAIPk6TxUEUYB+a70=;
 b=WGSgcWUeJk4XqDcw2X0oNQzpezgC2ZWWEXYC3R/sTz2qZHM4eLoCq3bMVWhoQnZsaw
 PjTH0SkZAdaMUIScgPd29pw3nTjsDY8hpogZSTV9VoXUTJpmHOff1Pdksm27pjZ1/s13
 NiW2mSOhprV1JlAuw1wwQl/GIg8j/pslQ8Gah6P8gD8F0BoVma5QSmB71D5fXldL5aUt
 AIoOUz99z4+LUQX+ppleLpPq1QoK9DK6c6WM4arhFgxaweq45B8FM+/DIgH+jVIzDcKV
 H7+lUWdGWjxJFJFeEdhkYoPwtvBT/Zo7CQW72+hBOop7e8WeBYftV5ndgxv8tpMG7Gnh
 XLlA==
X-Gm-Message-State: AOJu0Yy8/GwR5WFekEfJ1N4/yDu+DtI/qWev04nIDvt/E8fkZoFLDfUf
 buJsobDCrDaXBwJLINno+jGJA/jP4E/y7pxtRpRlHmN3geUK/HP+B+NZePaYzyRQxGz1GknglK8
 /PA8BUiUlPCOJ2LgNZtyrCo4CgLMTwEAyCzDgNrhZUcbIvivROwO8
X-Received: by 2002:ac2:5f74:0:b0:52b:bd90:29c8 with SMTP id
 2adb3069b0e04-52eb99d59camr9469804e87.60.1721049153650; 
 Mon, 15 Jul 2024 06:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCiR1T8yLGjwYl5bkdKT8hWHbQI69TJp4dPnMXvyfgG/Y4J2s2tgcm9PsCe/XhKEdUxNPLjA==
X-Received: by 2002:ac2:5f74:0:b0:52b:bd90:29c8 with SMTP id
 2adb3069b0e04-52eb99d59camr9469707e87.60.1721049151203; 
 Mon, 15 Jul 2024 06:12:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf445sm6443636f8f.46.2024.07.15.06.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:12:30 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:12:29 +0200
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
Subject: Re: [PATCH V15 3/7] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <20240715151229.7f934357@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240713182516.1457-4-salil.mehta@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-4-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 13 Jul 2024 19:25:12 +0100
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

> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.

so any target (and machines in it) that has ACPI_CPU_HOTPLUG enabled will use have all CPU hotplug
machinery builtin which is fine.

However any machine that uses GED but do not opt-in into CPU hotplug,
will still have CPU hotplug registers/memory regions enabled/mapped. 

It's not much concern for upstream as migration from new to older QEMU
is not supported, however it will break migration downstream (arm/virt) as
new QEMU will try to migrate memory regions/state that do not exists
in older QEMU. Se below for suggestion.

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
> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst |  3 ++-
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
>  hw/acpi/generic_event_device.c         | 24 ++++++++++++++++++++++++
>  include/hw/acpi/generic_event_device.h |  4 ++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
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
> index 2d6e91b124..1b31d633ba 100644
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
> @@ -371,6 +381,19 @@ static const VMStateDescription vmstate_acpi_ged = {
>      }
>  };
>  
> +static void acpi_ged_realize(DeviceState *dev, Error **errp)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +

> +    /* initialize CPU Hotplug related regions */
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(sbd, &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);

how about making it conditional on supported events
see hw/arm/virt.c: create_acpi_ged()
    if (ms->ram_slots) {                                                         
        event |= ACPI_GED_MEM_HOTPLUG_EVT;                                       
    }                                                                            
                                                                                 
    if (ms->nvdimms_state->is_enabled) {                                         
        event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;                                    
    } 

so cpu hotplug would have similar section
and ged realize could use ged-event to enable/disable
cpuhp feature registers and hwinit.

> +}
> +
>  static void acpi_ged_initfn(Object *obj)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -411,6 +434,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
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


