Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE4C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQocW-0007Nc-0f; Mon, 08 Jul 2024 09:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQocQ-0007MY-CT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQoc2-0007Fy-Ob
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720446054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMVqANTOrD9ic9nuONWapNY2Nr3eoZGcxSXBq4fKi9Q=;
 b=AoSCtbE0C/QT+OwMc8ZfnRQ1Ck5xArsesH7ylema653oj6QVswAPwa+C6KJZx84qka1LPY
 6xZ6Aj+p2R0RT06Vb0CCc8VobJdcIiLnxdNz5Ngbfwo8Px+Ik/hwMDqcgyUAyLV02S2C/g
 ohT53L+0aAtxJ4Zbtoh9Wmgr18oWLPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-AEV0bWOGMdGK7arCfnSK-g-1; Mon, 08 Jul 2024 09:40:52 -0400
X-MC-Unique: AEV0bWOGMdGK7arCfnSK-g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265e9de046so14163105e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720446051; x=1721050851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMVqANTOrD9ic9nuONWapNY2Nr3eoZGcxSXBq4fKi9Q=;
 b=uxS9tLG4phCX0mkwlDKkzO6EPatWB3RLmoYPNq/3ityvZAiYIue3qRxIDnzZyw8qil
 qvlixcihx5JfebmOuG09AuU69B8RLVsfjOMVxkhGW5hBC/+rLdQ4f5fTuUvjheAuRiB+
 6GIXbiCloWTu10rWEaLIsDLJMBju5Vi3YXgHXhkJF0RIwvajjPvzA9mltKEuhLn6cENT
 FWWfaKwTDAei2UEUJpXJ2ycXDPyRxztwbViBWWG0MGYEYb+935botyT7QQweiGNUkQsa
 1S2y6w2jngwQztEmNxaYDs8e3JvLBDxKlK5QjeXSEKHrPkh2ldzut89ByWHCCGS3b9vW
 rMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2HfotnH5T36ZqBOT45DUVEgWTqfMN+ElvObhDduEaGula97no0sgGkHGCKKmapPUcKz5+AeLX0tcZP7rBX0CtLFizbFg=
X-Gm-Message-State: AOJu0YwAUuXzKQu8HYQSJWvIWR/WoqruHib8t9Tanip8M3DaBNbaTzpe
 MN6dIYqzVsHBiqCmveGxczC3KIj7AnAB2CwHPQqpiPxMxKzGuqNlhQyb/wFeJUxS1Cc/iGGiXJ7
 QB6GoSPlI8XQVyOxXgYBYrj+UM5Ikg8ZDKAgOwWZ2wtui0J20SwYt
X-Received: by 2002:a05:600c:2e54:b0:426:627d:5542 with SMTP id
 5b1f17b1804b1-426627d5616mr34654035e9.28.1720446050772; 
 Mon, 08 Jul 2024 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcfyRA7lm7EbYxW3Cc2Gq7fkG4fzq6y5AvWVxMlQCkdCkOi3miRRSTLpL+Qe0XjOBlxuSZjw==
X-Received: by 2002:a05:600c:2e54:b0:426:627d:5542 with SMTP id
 5b1f17b1804b1-426627d5616mr34653735e9.28.1720446050324; 
 Mon, 08 Jul 2024 06:40:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d1668sm167550995e9.1.2024.07.08.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:40:49 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:40:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <20240708154048.254e1036@imammedo.users.ipa.redhat.com>
In-Reply-To: <c74b6d5e-1939-48df-ae21-9cdd4158a683@opnsrc.net>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-4-salil.mehta@huawei.com>
 <20240706154640.0a45c5d6@imammedo.users.ipa.redhat.com>
 <c74b6d5e-1939-48df-ae21-9cdd4158a683@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 8 Jul 2024 05:12:48 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> On 06/07/2024 13:46, Igor Mammedov wrote:
> > On Fri, 7 Jun 2024 12:56:44 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >  
> >> ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
> >> _CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
> >> notified event by evaluating ACPI _EVT method to know the type of event. Use
> >> ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.
> >>
> >> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> >> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> >> stub to avoid compilation break.
> >>
> >> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> >> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> >> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> >> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >> ---
> >>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
> >>   hw/acpi/cpu.c                          |  6 +++++-
> >>   hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
> >>   include/hw/acpi/generic_event_device.h |  4 ++++
> >>   4 files changed, 32 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> >> index 3fc4b14c26..c6c61bb9cd 100644
> >> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> >> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> >> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
> >>       return;
> >>   }
> >>   
> >> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> >> +                         CPUHotplugState *state, hwaddr base_addr)
> >> +{
> >> +    return;
> >> +}
> >> +
> >>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
> >>   {
> >>       return;
> >> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> >> index 69aaa563db..473b37ba88 100644
> >> --- a/hw/acpi/cpu.c
> >> +++ b/hw/acpi/cpu.c
> >> @@ -221,7 +221,11 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> >>       const CPUArchIdList *id_list;
> >>       int i;
> >>   
> >> -    assert(mc->possible_cpu_arch_ids);
> >> +    /* hotplug might not be available for all types like x86/microvm etc. */
> >> +    if (!mc->possible_cpu_arch_ids) {
> >> +        return;
> >> +    }  
> > if hotplug is not supported, this function shouldn't be called at all.  
> 
> True. But none the less this gets called for Intel/microvm and causes 
> qtest to fail.
> 
> I think, we've had this discussion before last year as well. Please 
> check below:
> 
> https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net/

And I see that I had the same objection, 
'
cpu_hotplug_hw_init() should not be called at initfn time,
but rather at realize time.
'


> >
> > [...]  
> >> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
> >>       memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
> >>                             TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
> >>       sysbus_init_mmio(sbd, &ged_st->regs);
> >> +
> >> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> >> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> >> +    sysbus_init_mmio(sbd, &s->container_cpuhp);
> >> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> >> +                        &s->cpuhp_state, 0);  

> > suggest to move this call to realize time, and gate it on
> > ACPI_GED_CPU_HOTPLUG_EVT being set.
> > Platform that supports cpu hotplug must optin, setting ACPI_GED_CPU_HOTPLUG_EVT,
> > while for the rest it will be ignored.

which I've just suggested again ^^^.

> >
> > for example: create_acpi_ged() : event |= ACPI_GED_NVDIMM_HOTPLUG_EVT; 
 
> 
> Similar case applies to the Memory hotplug as well and any cleaning here
> 
> will mean going beyond the realms of this patch-set. But I can definitely
> 
> take this activity in a separate patch-set if you wish?

For memory hotplug cleanup it's fine to be separate series,
but for cpu hotplug parts you are touching I'd very much prefer
done it right from the start.

That might also help to reduce code churn within this series.

> 
> Thanks
> 
> >  
> >>   }
> >>   
> >>   static void acpi_ged_class_init(ObjectClass *class, void *data)
> >> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> >> index ba84ce0214..90fc41cbb8 100644
> >> --- a/include/hw/acpi/generic_event_device.h
> >> +++ b/include/hw/acpi/generic_event_device.h
> >> @@ -60,6 +60,7 @@
> >>   #define HW_ACPI_GENERIC_EVENT_DEVICE_H
> >>   
> >>   #include "hw/sysbus.h"
> >> +#include "hw/acpi/cpu_hotplug.h"
> >>   #include "hw/acpi/memory_hotplug.h"
> >>   #include "hw/acpi/ghes.h"
> >>   #include "qom/object.h"
> >> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >>   #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
> >>   #define ACPI_GED_PWR_DOWN_EVT      0x2
> >>   #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> >> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> >>   
> >>   typedef struct GEDState {
> >>       MemoryRegion evt;
> >> @@ -106,6 +108,8 @@ struct AcpiGedState {
> >>       SysBusDevice parent_obj;
> >>       MemHotplugState memhp_state;
> >>       MemoryRegion container_memhp;
> >> +    CPUHotplugState cpuhp_state;
> >> +    MemoryRegion container_cpuhp;
> >>       GEDState ged_state;
> >>       uint32_t ged_event_bitmap;
> >>       qemu_irq irq;  
> 


