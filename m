Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4C4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 05:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdNTF-0001Nt-UE; Mon, 12 Aug 2024 01:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdNTD-0001ME-GN
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdNTB-0004rY-9N
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723439987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiPl5qz+TiUuTbWQp5G1cpe9SAgLQOutn6xibbuWscY=;
 b=EjaH25Jy2JXGKtajgR5kt6xXksafNXfeUgpWwf0FM9OcjZtBMr8FB8eZclFN4KPfroy3hn
 t/QpqK7qz9heh/kz2VC7q2KaaE5Q0tdwjuUqnVP10nxmn2X8ZOzC6PNPy8c06QogeB6Ddg
 KW/tUy4tyzgatKftqe6ymiIJmeff8n8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-ywJraW6zMj-jPZzl4p86vA-1; Mon, 12 Aug 2024 01:19:46 -0400
X-MC-Unique: ywJraW6zMj-jPZzl4p86vA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb4e6725ccso5465829a91.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 22:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723439985; x=1724044785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uiPl5qz+TiUuTbWQp5G1cpe9SAgLQOutn6xibbuWscY=;
 b=E0L6lSJj47tikEIl1lPpZndqRMb0Yd4X9kV7Ra3bbFCKDDZxGVJlcxNDx0aKBu7HJi
 4B6eXiPDFuSQ+MFW3E41P1+9ZGi3FY8UStfc6BTncnmebxY+l1YAaohphpvqmrEaD63M
 unfo7z8R7+W2vZViHi43IqjxEVCU0dTSWr2dluV1rNkmxMGssn+k6rUjC0Gqselpbsqq
 KJBboFtHdErFeaPI+iHHYhndKRZbeoPErGOipKNFeqTkCAAtt+HOopUexYNhtcJgyCoz
 5OAqBzyCHS0EbaueWsXubX37E9G0B0Zk6yPBPpGjI8VyvfsYKYLvl3jIrfJU6iQgNxqE
 kILw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXm4XScdPrQJOKge0RgAYr6uqM5fwzb8f7qziAPh2bs8rVo3et0NtGaf5irfK/gpv9y1fOL1w2wIYxnGbuM/jQGXUQVPc=
X-Gm-Message-State: AOJu0YwUSBUCbsOGuTv4u55y42SuOMpJrFQruU6KFp6sB4JxIFbXUh5T
 6thA4bLpw1O2hnFS9yZBB5l+h8wiXK6Xf72cFG/2rQslzDYJusB3ZSVGbQAW1tr4CVY8GgXdBrq
 eKY6x2xlvHVsInxoDB0RSEcMNGwLkWq74UmibnpFlNJZQ8O+NXnJZ
X-Received: by 2002:a17:90a:1117:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2d1e7f9514amr9288911a91.3.1723439984807; 
 Sun, 11 Aug 2024 22:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIyYq11jHOTT6h21hLl+DjJH4VKWZ7af/NlFLqWhXXjbPyb3Li1SrSPXmQWyxzT/VIZojXjg==
X-Received: by 2002:a17:90a:1117:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2d1e7f9514amr9288892a91.3.1723439984380; 
 Sun, 11 Aug 2024 22:19:44 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fce2ad36sm3989060a91.10.2024.08.11.22.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 22:19:43 -0700 (PDT)
Message-ID: <e5446234-c832-4487-b9cc-1b6261150ca8@redhat.com>
Date: Mon, 12 Aug 2024 15:19:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 04/29] hw/arm/virt: Move setting of common CPU
 properties in a function
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
 <20240613233639.202896-5-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-5-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> Factor out CPU properties code common for {hot,cold}-plugged CPUs. This allows
> code reuse.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c         | 261 ++++++++++++++++++++++++++++--------------
>   include/hw/arm/virt.h |   4 +
>   2 files changed, 182 insertions(+), 83 deletions(-)
> 

If this series are going to be split for easier review, this is an candidate
for a prepatory patch.

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3e1c4d2d2f..2e0ec7d869 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1753,6 +1753,46 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>       return arm_build_mp_affinity(idx, clustersz);
>   }
>   
> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    CPUArchId *found_cpu;
> +    uint64_t mp_affinity;
> +
> +    assert(vcpuid >= 0 && vcpuid < ms->possible_cpus->len);
> +
> +    mp_affinity = virt_cpu_mp_affinity(vms, vcpuid);
> +    found_cpu = &ms->possible_cpus->cpus[vcpuid];
> +
> +    assert(found_cpu->arch_id == mp_affinity);
> +
> +    /*
> +     * RFC: Question:
> +     * Slot-id is the index where vCPU with certain arch-id(=mpidr/ap-affinity)
> +     * is plugged. For Host KVM, MPIDR for vCPU is derived using vcpu-id.
> +     * As I understand, MPIDR and vcpu-id are property of vCPU but slot-id is
> +     * more related to machine? Current code assumes slot-id and vcpu-id are
> +     * same i.e. meaning of slot is bit vague.
> +     *
> +     * Q1: Is there any requirement to clearly represent slot and dissociate it
> +     *     from vcpu-id?
> +     * Q2: Should we make MPIDR within host KVM user configurable?
> +     *
> +     *          +----+----+----+----+----+----+----+----+
> +     * MPIDR    |||  Res  |   Aff2  |   Aff1  |  Aff0   |
> +     *          +----+----+----+----+----+----+----+----+
> +     *                     \         \         \   |    |
> +     *                      \   8bit  \   8bit  \  |4bit|
> +     *                       \<------->\<------->\ |<-->|
> +     *                        \         \         \|    |
> +     *          +----+----+----+----+----+----+----+----+
> +     * VCPU-ID  |  Byte4  |  Byte2  |  Byte1  |  Byte0  |
> +     *          +----+----+----+----+----+----+----+----+
> +     */
> +
> +    return found_cpu;
> +}
> +

I don't see why virt_find_cpu_slot() is needed. Apart from the sanity check, it
basically returns ms->possible_cpus->cpus[]. The caller can dereference
ms->possible_cpus->cpus[] directly. About the sanity check, the mp_affinity
has been properly populated in virt_possible_cpu_arch_ids(). I don't see why
we it needs to be checked again.

>   static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
>                                                    int index)
>   {
> @@ -2065,16 +2105,129 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>       }
>   }
>   
> +static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
> +                                    Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    Error *local_err = NULL;
> +    VirtMachineClass *vmc;
> +
> +    vmc = VIRT_MACHINE_GET_CLASS(ms);
> +
> +    /* now, set the cpu object property values */
> +    numa_cpu_pre_plug(cpu_slot, DEVICE(cpuobj), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    object_property_set_int(cpuobj, "mp-affinity", cpu_slot->arch_id, NULL);
> +
> +    if (!vms->secure) {
> +        object_property_set_bool(cpuobj, "has_el3", false, NULL);
> +    }
> +
> +    if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> +        object_property_set_bool(cpuobj, "has_el2", false, NULL);
> +    }
> +
> +    if (vmc->kvm_no_adjvtime &&
> +        object_property_find(cpuobj, "kvm-no-adjvtime")) {
> +        object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> +    }
> +
> +    if (vmc->no_kvm_steal_time &&
> +        object_property_find(cpuobj, "kvm-steal-time")) {
> +        object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> +    }
> +
> +    if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> +        object_property_set_bool(cpuobj, "pmu", false, NULL);
> +    }
> +
> +    if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> +        object_property_set_bool(cpuobj, "lpa2", false, NULL);
> +    }
> +
> +    if (object_property_find(cpuobj, "reset-cbar")) {
> +        object_property_set_int(cpuobj, "reset-cbar",
> +                                vms->memmap[VIRT_CPUPERIPHS].base,
> +                                &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    /* link already initialized {secure,tag}-memory regions to this cpu */
> +    object_property_set_link(cpuobj, "memory", OBJECT(vms->sysmem), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (vms->secure) {
> +        object_property_set_link(cpuobj, "secure-memory",
> +                                 OBJECT(vms->secure_sysmem), &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    if (vms->mte) {
> +        if (!object_property_find(cpuobj, "tag-memory")) {
> +            error_setg(&local_err, "MTE requested, but not supported "
> +                       "by the guest CPU");
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +
> +        object_property_set_link(cpuobj, "tag-memory", OBJECT(vms->tag_sysmem),
> +                                 &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        if (vms->secure) {
> +            object_property_set_link(cpuobj, "secure-tag-memory",
> +                                     OBJECT(vms->secure_tag_sysmem),
> +                                     &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * RFC: Question: this must only be called for the hotplugged cpus. For the
> +     * cold booted secondary cpus this is being taken care in arm_load_kernel()
> +     * in boot.c. Perhaps we should remove that code now?
> +     */
> +    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
> +        object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
> +                                NULL);
> +
> +        /* Secondary CPUs start in PSCI powered-down state */
> +        if (CPU(cpuobj)->cpu_index > 0) {
> +            object_property_set_bool(cpuobj, "start-powered-off", true, NULL);
> +        }
> +    }
> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +}
> +
>   static void machvirt_init(MachineState *machine)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(machine);
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       const CPUArchIdList *possible_cpus;
> -    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *secure_tag_sysmem = NULL;
>       MemoryRegion *secure_sysmem = NULL;
>       MemoryRegion *tag_sysmem = NULL;
> -    MemoryRegion *secure_tag_sysmem = NULL;
> +    MemoryRegion *sysmem;
>       int n, virt_max_cpus;
>       bool firmware_loaded;
>       bool aarch64 = true;
> @@ -2148,6 +2301,8 @@ static void machvirt_init(MachineState *machine)
>       /* uses smp.max_cpus to initialize all possible vCPUs */
>       possible_cpus = mc->possible_cpu_arch_ids(machine);
>   
> +    sysmem = vms->sysmem = get_system_memory();
> +
>       if (vms->secure) {
>           /*
>            * The Secure view of the world is the same as the NonSecure,
> @@ -2155,7 +2310,7 @@ static void machvirt_init(MachineState *machine)
>            * containing the system memory at low priority; any secure-only
>            * devices go in at higher priority and take precedence.
>            */
> -        secure_sysmem = g_new(MemoryRegion, 1);
> +        secure_sysmem = vms->secure_sysmem = g_new(MemoryRegion, 1);
>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                              UINT64_MAX);
>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> @@ -2203,10 +2358,28 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (vms->mte) {
> +        /* Create the memory region only once, but link to all cpus later */
> +        tag_sysmem = vms->tag_sysmem = g_new(MemoryRegion, 1);
> +        memory_region_init(tag_sysmem, OBJECT(machine),
> +                           "tag-memory", UINT64_MAX / 32);
> +
> +        if (vms->secure) {
> +            secure_tag_sysmem = vms->secure_tag_sysmem = g_new(MemoryRegion, 1);
> +            memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                               "secure-tag-memory", UINT64_MAX / 32);
> +
> +            /* As with ram, secure-tag takes precedence over tag.  */
> +            memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> +                                                tag_sysmem, -1);
> +        }
> +    }
> +
>       create_fdt(vms);
>   
>       assert(possible_cpus->len == max_cpus);
>       for (n = 0; n < possible_cpus->len; n++) {
> +        CPUArchId *cpu_slot;
>           Object *cpuobj;
>           CPUState *cs;
>   
> @@ -2215,15 +2388,10 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           cpuobj = object_new(possible_cpus->cpus[n].type);
> -        object_property_set_int(cpuobj, "mp-affinity",
> -                                possible_cpus->cpus[n].arch_id, NULL);
>   
>           cs = CPU(cpuobj);
>           cs->cpu_index = n;
>   
> -        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
> -                          &error_fatal);
> -
>           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>           object_property_set_int(cpuobj, "socket-id",
>                                   virt_get_socket_id(machine, n), NULL);
> @@ -2234,81 +2402,8 @@ static void machvirt_init(MachineState *machine)
>           object_property_set_int(cpuobj, "thread-id",
>                                   virt_get_thread_id(machine, n), NULL);
>   
> -        if (!vms->secure) {
> -            object_property_set_bool(cpuobj, "has_el3", false, NULL);
> -        }
> -
> -        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> -            object_property_set_bool(cpuobj, "has_el2", false, NULL);
> -        }
> -
> -        if (vmc->kvm_no_adjvtime &&
> -            object_property_find(cpuobj, "kvm-no-adjvtime")) {
> -            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> -        }
> -
> -        if (vmc->no_kvm_steal_time &&
> -            object_property_find(cpuobj, "kvm-steal-time")) {
> -            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> -        }
> -
> -        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> -            object_property_set_bool(cpuobj, "pmu", false, NULL);
> -        }
> -
> -        if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> -            object_property_set_bool(cpuobj, "lpa2", false, NULL);
> -        }
> -
> -        if (object_property_find(cpuobj, "reset-cbar")) {
> -            object_property_set_int(cpuobj, "reset-cbar",
> -                                    vms->memmap[VIRT_CPUPERIPHS].base,
> -                                    &error_abort);
> -        }
> -
> -        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
> -                                 &error_abort);
> -        if (vms->secure) {
> -            object_property_set_link(cpuobj, "secure-memory",
> -                                     OBJECT(secure_sysmem), &error_abort);
> -        }
> -
> -        if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus. */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> -                    exit(1);
> -                }
> -
> -                tag_sysmem = g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> -                if (vms->secure) {
> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                       "secure-tag-memory", UINT64_MAX / 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> -                                                        tag_sysmem, -1);
> -                }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> -            }
> -        }
> +        cpu_slot = virt_find_cpu_slot(machine, cs->cpu_index);
> +        virt_cpu_set_properties(cpuobj, cpu_slot, &error_fatal);
>   
>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>           object_unref(cpuobj);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 6f9a7bb60b..780bd53ceb 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -139,6 +139,10 @@ struct VirtMachineState {
>       DeviceState *platform_bus_dev;
>       FWCfgState *fw_cfg;
>       PFlashCFI01 *flash[2];
> +    MemoryRegion *sysmem;
> +    MemoryRegion *secure_sysmem;
> +    MemoryRegion *tag_sysmem;
> +    MemoryRegion *secure_tag_sysmem;
>       bool secure;
>       bool highmem;
>       bool highmem_compact;

Thanks,
Gavin


