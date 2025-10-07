Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 12:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66gZ-0007DC-Li; Tue, 07 Oct 2025 08:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v66gR-0007C5-HJ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v66gC-00048y-JF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 08:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759839624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRj0bFF+8yzserraghC6ec0ObsdCzz2iRJKy09RlCuw=;
 b=N78m6ZVv5NVUiJezAkcggPKavzvBDNFATMEQfB/tOn/bbLPDV6o9f1aCb+hWgm1uW6PmWt
 M5NzoHCFV4ApFgw+mPF2KyozJfQXBEtMZfquV/K0LPUWdgzR2t9fGoSnvZjtUSsJd/i7g7
 JcbvdLk/XH69RcG4971XSjDj9WBUj+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-26Pb6p2MO-6jtkdqd5PWeQ-1; Tue, 07 Oct 2025 08:20:22 -0400
X-MC-Unique: 26Pb6p2MO-6jtkdqd5PWeQ-1
X-Mimecast-MFC-AGG-ID: 26Pb6p2MO-6jtkdqd5PWeQ_1759839621
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42558f501adso2702700f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 05:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759839621; x=1760444421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRj0bFF+8yzserraghC6ec0ObsdCzz2iRJKy09RlCuw=;
 b=a2BMH3qhQoDhciIOK25BP/CbjNvqplKPoM6X8aba6uWRnw3tRvhqimQeYu1jT0Rh2l
 eA2La1Bn1r/9P7xMLk4wj3RTHAFFOi339jBkfRQnK+zcy38PEpjl30X8OeWZi9B9ZlmF
 ZJlRRHEaJ0JhUoHICvEQznYYLjPMoLPQNe7CKrq/ffYDowI4Mz+WGQ+FDM7e1Jhgpq2d
 S7igzRdhs6M2H6rfiy+CHQgALFNCpAQbwUzRejDX+Kbgj/HdBbeGjHgIe7If0GJlzxZC
 8ApHIX9HVbUDJddjS9pgJIcTJPVslB40RFMjSa3eacJZcG4TEK2rf6swtTtRmXv/pn5A
 HrSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmJ2wL3N8rDInCBqM7f3zBSzxqQ0NxD6Wi+/j07Rvi6Rt5vGLwHInZ74M4FJ8fmhOuhSKvUrc6Dida@nongnu.org
X-Gm-Message-State: AOJu0YzduipTjcTJZsK1eq4eGl9BsJTzgRo5wJPAqdqJFg5bD7qGzwe0
 zEUF6Pa/VQxPQpc6nqKEpTYoSGR6Cs+ZnHUQAxiCPBs0q1cNjDHcqWf7C2vkAae6F/M12snAmut
 OlNEjl3jFv1FPVzh/edviY8C85i2wAsJrj4bJIK/LusZeP3xkR388AHMo
X-Gm-Gg: ASbGncux7seCpLQ4FZGBvwz4OHfxq72eFC/VLbX6o821la6o4p4qVJGhCjRtzLqBvv1
 RaRbMAN8z4iG+j+ud7WrFuko/hhNMca/upOASjXEeqlVPUjZPc+/ApHxIUi4n78OUH32EbcBm9y
 eKXF4scbSWfYqEyldkxJKJe7Q4WLsfjMMNZNqSs3rFNVeeuzsKP96wvUZvxVTd99BynTqd6vuFn
 dXqVer91pSu4jN9TOltauoRo4hcwjJ9t14317a7jR45qYCabtFmQFYkpByf3Fj1yAYv50WZuuk6
 /Zrp9fUJrACISGHY65yj95AttHOa2gj1XTg8
X-Received: by 2002:a05:6000:4301:b0:425:8546:6870 with SMTP id
 ffacd0b85a97d-4258546694emr1206190f8f.21.1759839620660; 
 Tue, 07 Oct 2025 05:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7R4WMDalHUZGGLCLueQNWnQux6OwZVJs/Q46kF0LReaZyo9Jp3p6JBtpKQ/LaVdbmR20RdQ==
X-Received: by 2002:a05:6000:4301:b0:425:8546:6870 with SMTP id
 ffacd0b85a97d-4258546694emr1206129f8f.21.1759839619987; 
 Tue, 07 Oct 2025 05:20:19 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374b8dsm231016895e9.19.2025.10.07.05.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 05:20:19 -0700 (PDT)
Date: Tue, 7 Oct 2025 14:20:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 11/24] hw/arm/acpi: MADT change to size the guest
 with possible vCPUs
Message-ID: <20251007142016.3ed85bff@fedora>
In-Reply-To: <0175e40f70424dd9a29389b8a4f16c42@huawei.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-12-salil.mehta@opnsrc.net>
 <20251003170908.48070061@fedora>
 <0175e40f70424dd9a29389b8a4f16c42@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 7 Oct 2025 11:34:48 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
> 
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Friday, October 3, 2025 4:09 PM
> > To: salil.mehta@opnsrc.net
> > 
> > On Wed,  1 Oct 2025 01:01:14 +0000
> > salil.mehta@opnsrc.net wrote:
> >   
> > > From: Salil Mehta <salil.mehta@huawei.com>
> > >
> > > When QEMU builds the MADT table, modifications are needed to include
> > > information about possible vCPUs that are exposed as ACPI-disabled (i.e.,  
> > `_STA.Enabled=0`).  
> > > This new information will help the guest kernel pre-size its resources
> > > during boot time. Pre-sizing based on possible vCPUs will facilitate
> > > the future hot-plugging of the currently disabled vCPUs.
> > >
> > > Additionally, this change addresses updates to the ACPI MADT GIC CPU
> > > interface flags, as introduced in the UEFI ACPI 6.5 specification [1].
> > > These updates enable deferred virtual CPU onlining in the guest kernel.
> > >
> > > Reference:
> > > [1] 5.2.12.14. GIC CPU Interface (GICC) Structure (Table 5.37 GICC CPU  
> > Interface Flags)  
> > >     Link:
> > >  
> > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.h
> > tm  
> > > l#gic-cpu-interface-gicc-structure
> > >
> > > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >  hw/arm/virt-acpi-build.c | 40 ++++++++++++++++++++++++++++++++++-  
> > -----  
> > >  hw/core/machine.c        | 14 ++++++++++++++
> > >  include/hw/boards.h      | 20 ++++++++++++++++++++
> > >  3 files changed, 68 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > > b01fc4f8ef..7c24dd6369 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -760,6 +760,32 @@ static void build_append_gicr(GArray *table_data,  
> > uint64_t base, uint32_t size)  
> > >      build_append_int_noprefix(table_data, size, 4); /* Discovery
> > > Range Length */  }
> > >
> > > +static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu) {
> > > +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> > > +    const uint32_t GICC_FLAG_ENABLED = BIT(0);
> > > +    const uint32_t GICC_FLAG_ONLINE_CAPABLE = BIT(3);
> > > +
> > > +    /* ARM architecture does not support vCPU hotplug yet */
> > > +    if (!cpu) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    /*
> > > +     * If the machine does not support online-capable CPUs, report the  
> > GICC as  
> > > +     * 'enabled' only.
> > > +     */
> > > +    if (!mc->has_online_capable_cpus) {
> > > +        return GICC_FLAG_ENABLED;
> > > +    }
> > > +
> > > +    /*
> > > +     * ACPI 6.5, 5.2.12.14 (GICC): mark the boot CPU 'enabled' and all others
> > > +     * 'online-capable'.
> > > +     */
> > > +    return (cpu == first_cpu) ? GICC_FLAG_ENABLED :
> > > +GICC_FLAG_ONLINE_CAPABLE; }
> > > +
> > >  static void
> > >  build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState
> > > *vms)  { @@ -785,12 +811,14 @@ build_madt(GArray *table_data,
> > > BIOSLinker *linker, VirtMachineState *vms)
> > >      build_append_int_noprefix(table_data, vms->gic_version, 1);
> > >      build_append_int_noprefix(table_data, 0, 3);   /* Reserved */
> > >
> > > -    for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
> > > -        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
> > > +    for (i = 0; i < MACHINE(vms)->smp.max_cpus; i++) {  
> >                                      ^^^^^^^^^^^^  
> > > +        CPUState *cpu = machine_get_possible_cpu(i);  
> > ...  
> > > +        CPUArchId *archid = machine_get_possible_cpu_arch_id(i);  
> > 
> > what complexity above adds? /and then you say creating instantiating ARM
> > VM is slow./
> > 
> > I'd drop machine_get_possible_cpu/machine_get_possible_cpu_arch_id
> > altogether and mimic what acpi_build_madt() does.  
> 
> 
> We can do that here but I need this function elsewhere in the monitor code as well
> to iterate over the possible CPUs and if I remember correctly I was getting compilation
> errors there. But I will check if this can be removed.
> 
> I would like to keep machine_get_possible_cpu().

if you did iteration with this helper over CPUs, you'd basically introducing
^2 complexity at that point.
But that's details, we will sort it out eventually.

> 
> I think you've misunderstood the reason of the boot time delay mentioned to you in RFC V5.
> It is because of the realization leg i.e. qdev_relaize(), of the vCPU and not because of this
> initialization leg

I did misunderstood wrt slow vcpus creation.
I did object to lazy creation in general, and well I still dislike it.
For more on this topic see my reply to cover letter, let continue discussion there
about that.

> 
> 
> >   
> > > +        uint32_t flags = virt_acpi_get_gicc_flags(cpu);
> > > +        uint64_t mpidr = archid->arch_id;
> > >
> > >          if (vms->gic_version == VIRT_GIC_VERSION_2) {
> > >              physical_base_address = memmap[VIRT_GIC_CPU].base; @@
> > > -805,7 +833,7 @@ build_madt(GArray *table_data, BIOSLinker *linker,  
> > VirtMachineState *vms)  
> > >          build_append_int_noprefix(table_data, i, 4);    /* GIC ID */
> > >          build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID  
> > */  
> > >          /* Flags */
> > > -        build_append_int_noprefix(table_data, 1, 4);    /* Enabled */
> > > +        build_append_int_noprefix(table_data, flags, 4);
> > >          /* Parking Protocol Version */
> > >          build_append_int_noprefix(table_data, 0, 4);
> > >          /* Performance Interrupt GSIV */ @@ -819,7 +847,7 @@
> > > build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState  
> > *vms)  
> > >          build_append_int_noprefix(table_data, vgic_interrupt, 4);
> > >          build_append_int_noprefix(table_data, 0, 8);    /* GICR Base  
> > Address*/  
> > >          /* MPIDR */
> > > -        build_append_int_noprefix(table_data,  
> > arm_cpu_mp_affinity(armcpu), 8);  
> > > +        build_append_int_noprefix(table_data, mpidr, 8);
> > >          /* Processor Power Efficiency Class */
> > >          build_append_int_noprefix(table_data, 0, 1);
> > >          /* Reserved */
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > > 69d5632464..65388d859a 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -1383,6 +1383,20 @@ CPUState *machine_get_possible_cpu(int64_t  
> > cpu_index)  
> > >      return NULL;
> > >  }
> > >
> > > +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index) {
> > > +    MachineState *ms = MACHINE(qdev_get_machine());
> > > +    CPUArchIdList *possible_cpus = ms->possible_cpus;
> > > +
> > > +    for (int i = 0; i < possible_cpus->len; i++) {
> > > +        if (possible_cpus->cpus[i].cpu &&
> > > +            possible_cpus->cpus[i].cpu->cpu_index == cpu_index) {
> > > +            return &possible_cpus->cpus[i];
> > > +        }
> > > +    }
> > > +    return NULL;
> > > +}
> > > +
> > >  static char *cpu_slot_to_string(const CPUArchId *cpu)  {
> > >      GString *s = g_string_new(NULL);
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h index
> > > 3ff77a8b3a..fe51ca58bf 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -461,6 +461,26 @@ struct MachineState {
> > >      bool acpi_spcr_enabled;
> > >  };
> > >
> > > +/*
> > > + * machine_get_possible_cpu_arch_id:
> > > + * @cpu_index: logical cpu_index to search for
> > > + *
> > > + * Return a pointer to the CPUArchId entry matching the given
> > > +@cpu_index
> > > + * in the current machine's MachineState. The possible_cpus array
> > > +holds
> > > + * the full set of CPUs that the machine could support, including
> > > +those
> > > + * that may be created as disabled or taken offline.
> > > + *
> > > + * The slot index in ms->possible_cpus[] is always sequential, but
> > > +the
> > > + * logical cpu_index values are assigned by QEMU and may or may not
> > > +be
> > > + * sequential depending on the implementation of a particular machine.
> > > + * Direct indexing by cpu_index is therefore unsafe in general. This
> > > + * helper performs a linear search of the possible_cpus array to find
> > > + * the matching entry.
> > > + *
> > > + * Returns: pointer to the matching CPUArchId, or NULL if not found.
> > > + */
> > > +CPUArchId *machine_get_possible_cpu_arch_id(int64_t cpu_index);
> > > +
> > >  /*
> > >   * The macros which follow are intended to facilitate the
> > >   * definition of versioned machine types, using a somewhat  
> >   
> 


