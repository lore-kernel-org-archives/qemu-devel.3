Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B05C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgEM-0001lk-Ev; Mon, 12 Aug 2024 21:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdgEJ-0001ku-L1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdgEH-00054y-6u
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723512100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZTWsWk/SecPpff2uduq6vVjrbcNYRORm6NKSWu5gkw=;
 b=bkG9xjQiZTkRCTgbNqbdIXKUkyloMx3IqnSPJMUk/SopnpOJQP4I4Ofyc+3KODfUwbIIfq
 Rb0YjqepYD70sI8OPnQqM/3DbxI3DriDp8bZiL6BpRigpqK4T39/1XPh0acPTZO3v7Da7y
 pmJiiaIljO/VHc55v477AgwbGJx4SAg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-fbdVt4UDN7Gi9U5RqHd6Tw-1; Mon, 12 Aug 2024 21:21:38 -0400
X-MC-Unique: fbdVt4UDN7Gi9U5RqHd6Tw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb63abe6f7so6197453a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 18:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723512097; x=1724116897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZTWsWk/SecPpff2uduq6vVjrbcNYRORm6NKSWu5gkw=;
 b=skPW1/sVP2DzhPqv6evB0uXuwhmMVye8kXyOoXMW3gwFUVBrzHZuhZV5C0uiH80Pbu
 4faVrpv5F6lJAcvJt7XVjG5Q7Q9mF3NBXXAGaQT3zR6zxwl/hn8h4YDFbzsAruOvENbr
 rBSY0PFY4vSjuGX3oKd0bFik0CXc9BChMWxf+stXGqD95Dygnouhy1VGWJ6f6UjsnUmC
 mqvj6Hgwqh6vEsd+OZ41z7RexyySLxkTJBYOOL9yttYaOknN1Sz8QyraC9R0sOQpoRzh
 ejaM84JXpsmDMsD200HLmul9ac/98wzM5JjsxgJCUqoe4yCc9pEfLyA8+5/WN3UZ7VM5
 7Ocw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeGUlSE557i5JjIvM0ZA8vE9BRSdQ81vHsUHQ1Qfl1mdWojE+i9SN95/ZHdgypNYWILJYzg/1UhsbvDqze8boJVsRvc/g=
X-Gm-Message-State: AOJu0YwRbWTUSDWWFTyP8P9ghNGUvWKAyn8/tp4HNLaaI0aJeGwISaPl
 h2bYxLW6zAMBTGLodcz4zjj1gG2/tHQv8a+95ml/pPaBIH/pjrvIztgDY7o8T11JKaPOx5BxVPF
 JZyg+8xOWUC9MHUXjwzbSxx/YCAclahe7pZfjKEt/0LaNpHqS2HTB
X-Received: by 2002:a17:90a:4e08:b0:2cf:7cce:cc19 with SMTP id
 98e67ed59e1d1-2d3924d6b93mr2290866a91.6.1723512097402; 
 Mon, 12 Aug 2024 18:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtXxxjZoHrPw5NirZUB3XYNPtAwQbQNW6k5Y1zvcvFkt0QUXE9jDYOC7qgq66nILP8VWHmQw==
X-Received: by 2002:a17:90a:4e08:b0:2cf:7cce:cc19 with SMTP id
 98e67ed59e1d1-2d3924d6b93mr2290817a91.6.1723512096931; 
 Mon, 12 Aug 2024 18:21:36 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c64b1fsm10010729a91.7.2024.08.12.18.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 18:21:36 -0700 (PDT)
Message-ID: <64e9feaa-8df2-4108-9e73-c72517fb074a@redhat.com>
Date: Tue, 13 Aug 2024 11:21:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 18/29] arm/virt: Add/update basic hot-(un)plug
 framework
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-19-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-19-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/14/24 9:36 AM, Salil Mehta wrote:
> Add CPU hot-unplug hooks and update hotplug hooks with additional sanity checks
> for use in hotplug paths.
> 
> Note: The functional contents of the hooks (currently left with TODO comments)
> will be gradually filled in subsequent patches in an incremental approach to
> patch and logic building, which would roughly include the following:
> 
> 1. (Un)wiring of interrupts between vCPU<->GIC.
> 2. Sending events to the guest for hot-(un)plug so that the guest can take
>     appropriate actions.
> 3. Notifying the GIC about the hot-(un)plug action so that the vCPU can be
>     (un)stitched to the GIC CPU interface.
> 4. Updating the guest with next boot information for this vCPU in the firmware.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 105 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a72cd3b20d..f6b8c21f26 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -85,6 +85,7 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/char/pl011.h"
>   #include "qemu/guest-random.h"
> +#include "qapi/qmp/qdict.h"
>   
>   static GlobalProperty arm_virt_compat[] = {
>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -3002,11 +3003,23 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>   static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>   {
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>       MachineState *ms = MACHINE(hotplug_dev);
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>       ARMCPU *cpu = ARM_CPU(dev);
>       CPUState *cs = CPU(dev);
>       CPUArchId *cpu_slot;
>   
> +    if (dev->hotplugged && !vms->acpi_dev) {
> +        error_setg(errp, "GED acpi device does not exists");
> +        return;
> +    }
> +
> +    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> +        error_setg(errp, "CPU hotplug not supported on this machine");
> +        return;
> +    }
> +
>       /* sanity check the cpu */
>       if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
>           error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> @@ -3049,6 +3062,22 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       }
>       virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
>   
> +    /*
> +     * Fix the GIC for this new vCPU being plugged. The QOM CPU object for the
> +     * new vCPU need to be updated in the corresponding QOM GICv3CPUState object
> +     * We also need to re-wire the IRQs for this new CPU object. This update
> +     * is limited to the QOM only and does not affects the KVM. Later has
> +     * already been pre-sized with possible CPU at VM init time. This is a
> +     * workaround to the constraints posed by ARM architecture w.r.t supporting
> +     * CPU Hotplug. Specification does not exist for the later.
> +     * This patch-up is required both for {cold,hot}-plugged vCPUs. Cold-inited
> +     * vCPUs have their GIC state initialized during machvit_init().
> +     */
> +    if (vms->acpi_dev) {
> +        /* TODO: update GIC about this hotplug change here */
> +        /* TODO: wire the GIC<->CPU irqs */
> +    }
> +
>       /*
>        * To give persistent presence view of vCPUs to the guest, ACPI might need
>        * to fake the presence of the vCPUs to the guest but keep them disabled.
> @@ -3060,6 +3089,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                             Error **errp)
>   {
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>       MachineState *ms = MACHINE(hotplug_dev);
>       CPUState *cs = CPU(dev);
>       CPUArchId *cpu_slot;
> @@ -3068,10 +3098,81 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
>       cpu_slot->cpu = CPU(dev);
>   
> +    /*
> +     * Update the ACPI Hotplug state both for vCPUs being {hot,cold}-plugged.
> +     * vCPUs can be cold-plugged using '-device' option. For vCPUs being hot
> +     * plugged, guest is also notified.
> +     */
> +    if (vms->acpi_dev) {
> +        /* TODO: update acpi hotplug state. Send cpu hotplug event to guest */
> +        /* TODO: register cpu for reset & update F/W info for the next boot */
> +    }
> +
>       cs->disabled = false;
>       return;
>   }
>   
> +static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
> +                                    DeviceState *dev, Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    ARMCPU *cpu = ARM_CPU(dev);
> +    CPUState *cs = CPU(dev);
> +
> +    if (!vms->acpi_dev || !dev->realized) {
> +        error_setg(errp, "GED does not exists or device is not realized!");
> +        return;
> +    }
> +

How can a vCPU be unplugged even when it hasn't been realized? :)

> +    if (!mc->has_hotpluggable_cpus) {
> +        error_setg(errp, "CPU hot(un)plug not supported on this machine");
> +        return;
> +    }
> +
> +    if (cs->cpu_index == first_cpu->cpu_index) {
> +        error_setg(errp, "Boot CPU(id%d=%d:%d:%d:%d) hot-unplug not supported",
> +                   first_cpu->cpu_index, cpu->socket_id, cpu->cluster_id,
> +                   cpu->core_id, cpu->thread_id);
> +        return;
> +    }
> +
> +    /* TODO: request cpu hotplug from guest */
> +
> +    return;
> +}
> +
> +static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                            Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    CPUState *cs = CPU(dev);
> +    CPUArchId *cpu_slot;
> +
> +    if (!vms->acpi_dev || !dev->realized) {
> +        error_setg(errp, "GED does not exists or device is not realized!");
> +        return;
> +    }
> +

Same question as above.

> +    cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
> +
> +    /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
> +
> +    /* TODO: unwire the gic-cpu irqs here */
> +    /* TODO: update the GIC about this hot unplug change */
> +
> +    /* TODO: unregister cpu for reset & update F/W info for the next boot */
> +
> +    qobject_unref(dev->opts);
> +    dev->opts = NULL;
> +
> +    cpu_slot->cpu = NULL;
> +    cs->disabled = true;
> +
> +    return;
> +}
> +

The 'return' isn't needed.

>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **errp)
>   {
> @@ -3196,6 +3297,8 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>                                        errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        virt_cpu_unplug_request(hotplug_dev, dev, errp);
>       } else {
>           error_setg(errp, "device unplug request for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -3209,6 +3312,8 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>           virt_dimm_unplug(hotplug_dev, dev, errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        virt_cpu_unplug(hotplug_dev, dev, errp);
>       } else {
>           error_setg(errp, "virt: device unplug for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));

Thanks,
Gavin


