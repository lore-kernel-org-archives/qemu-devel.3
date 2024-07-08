Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C6C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQokJ-0003OC-6R; Mon, 08 Jul 2024 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQokH-0003LY-7w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQokA-0000On-PT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720446563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnl0NTwyz0QMr2cBO8K/QyleLySUQ0WTiR71Nrv8xzc=;
 b=NXydy3NkxbIlrbBJKb3HxIENiP6b/6hrHjBserMwkHqskqCZyhjzBr1PzrdDm///8v5Rsr
 bZeU4w5XqhSiPJ608WKqIULzs4HlN1lfTwEc4u9k6lkO5EP+pU5EIkpi39fGVpTmidkv1j
 EtKqkXW+vCvo/oNKJvu28xzkgpi4/mU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-55ZWVAOlMxyYxofA_mOrCQ-1; Mon, 08 Jul 2024 09:49:22 -0400
X-MC-Unique: 55ZWVAOlMxyYxofA_mOrCQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3679ab94cdbso2959453f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720446560; x=1721051360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnl0NTwyz0QMr2cBO8K/QyleLySUQ0WTiR71Nrv8xzc=;
 b=cqOaT1u1C/TnLjurLqZlz4hA9M6qEz2JG9CyWuQ85AO/YGwZFWPL9dAXlUDldqY4AS
 Yl3KNUDOFzTlzDV1wUkQJI4ki45hZrQSncPfxVEsvTEBrm5lCIjAx57d7jTf/YYQSocV
 u+gnJM2eGjRfdou1dAkXEYdS7iHuYK9NHlt5Ir1cFOk8yNrOoVfMdGo/xb2LutfQoTvA
 iA3ITrgp00izzdDrO2/0OYsEEW6tFuosf6r+VdwVMyrRsh8Q3rZKRIXtPhuhM2jt50VC
 Hw66oUH0JrrjMnUhi7AP5CxPAC3vwhKiCcc91+4Gf/MZfDlPe3rgnpxZnMLzBtFbGxRj
 /5yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjr7HbTlZYpIYsZMAqynKpPYTB+JdRtK9dRqjA5dvRvRn4uADKelzb3f4yDq4Cj9v2dTp0cYLTnpiCt06emE0/7eLo/N4=
X-Gm-Message-State: AOJu0YxqgH/6FEBSLll5sYry4uQOf7zpLmdl9SM9NcYq+IBJTR7mZAgR
 S8C5Y6iufIvTrpYd6griehwnbmXSxHFx/pM8BU7jHerbuMOfzYZR5hZXnEXdQ1Yoy/qxfX/mDHS
 pb5edno2dReAWpxldZv3bSpQWoShT1Y3AHk7197slX59bTtna2PGeX12FSA/b
X-Received: by 2002:adf:e892:0:b0:367:993e:874f with SMTP id
 ffacd0b85a97d-3679dd35745mr9627620f8f.34.1720446560434; 
 Mon, 08 Jul 2024 06:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvZSC3lC9PhKgCdUBZH45B/HaHSUZIld2KhIRdkQF1haZpPzRn4mpv6TgCngJ8TTykrirTg==
X-Received: by 2002:adf:e892:0:b0:367:993e:874f with SMTP id
 ffacd0b85a97d-3679dd35745mr9627586f8f.34.1720446559967; 
 Mon, 08 Jul 2024 06:49:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789a02631sm16271187f8f.1.2024.07.08.06.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:49:19 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:49:16 +0200
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
Subject: Re: [PATCH V13 5/8] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20240708154916.7ff9bdf3@imammedo.users.ipa.redhat.com>
In-Reply-To: <020c731c-8bfc-4524-9750-879dd44b6cfe@opnsrc.net>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-6-salil.mehta@huawei.com>
 <20240706163524.012b6caf@imammedo.users.ipa.redhat.com>
 <020c731c-8bfc-4524-9750-879dd44b6cfe@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 8 Jul 2024 05:26:00 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> On 06/07/2024 14:35, Igor Mammedov wrote:
> > On Fri, 7 Jun 2024 12:56:46 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >  
> >> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
> >> based and existing CPUs AML code assumes _CRS objects would evaluate to a system
> >> resource which describes IO Port address. But on ARM arch CPUs control
> >> device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
> >> evaluate to system resource which describes memory-mapped base address. Update
> >> build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
> >> update the _CRS object.  
> > ack for above change  
> Thanks
> >
> >
> > but below part is one too many different changes withing 1 patch.
> > anyways, GPE part probably won't be needed if you follow suggestion made
> > on previous patch.  
> 
> The change mentioned in the earlier patches might end up creating
> 
> noise for this patch-set as one will have to touch the Memory Hotplug
> 
> part as well. I'm willing to do that change but I think it is a noise for
> 
> this patch-set, really.

you don't have to touch memory hotplug,
but fixing it up (as a separate patch of cause) to be consistent
with cpu hotplug would be nice.

> 
> >     
> >> On x86, CPU Hotplug uses Generic ACPI GPE Block Bit 2 (GPE.2) event handler to
> >> notify OSPM about any CPU hot(un)plug events. Latest CPU Hotplug is based on
> >> ACPI Generic Event Device framework and uses ACPI GED device for the same. Not
> >> all architectures support GPE based CPU Hotplug event handler. Hence, make AML
> >> for GPE.2 event handler conditional.
> >>
> >> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> >> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> >> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> >> ---
> >>   hw/acpi/cpu.c         | 23 ++++++++++++++++-------
> >>   hw/i386/acpi-build.c  |  3 ++-
> >>   include/hw/acpi/cpu.h |  5 +++--
> >>   3 files changed, 21 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> >> index af2b6655d2..4c63514b16 100644
> >> --- a/hw/acpi/cpu.c
> >> +++ b/hw/acpi/cpu.c
> >> @@ -343,9 +343,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
> >>   #define CPU_FW_EJECT_EVENT "CEJF"
> >>   
> >>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> >> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> >> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> >>                       const char *res_root,
> >> -                    const char *event_handler_method)
> >> +                    const char *event_handler_method,
> >> +                    AmlRegionSpace rs)
> >>   {
> >>       Aml *ifctx;
> >>       Aml *field;
> >> @@ -370,13 +371,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> >>           aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> >>   
> >>           crs = aml_resource_template();
> >> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> >> +        if (rs == AML_SYSTEM_IO) {
> >> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
> >>                                  ACPI_CPU_HOTPLUG_REG_LEN));
> >> +        } else {  
> > else
> >   if (rs == yours type)  
> >> +            aml_append(crs, aml_memory32_fixed(base_addr,
> >> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> >> +        }  
> > else assert on not supported input  
> 
> Sure, no problem. I can incorporate the change.
> 
> Thanks, Salil.
> 
> >  
> >> +
> >>           aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> >>   
> >>           /* declare CPU hotplug MMIO region with related access fields */
> >>           aml_append(cpu_ctrl_dev,
> >> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> >> +            aml_operation_region("PRST", rs, aml_int(base_addr),
> >>                                    ACPI_CPU_HOTPLUG_REG_LEN));
> >>   
> >>           field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> >> @@ -700,9 +707,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> >>       aml_append(sb_scope, cpus_dev);
> >>       aml_append(table, sb_scope);
> >>   
> >> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> >> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> >> -    aml_append(table, method);
> >> +    if (event_handler_method) {
> >> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> >> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> >> +        aml_append(table, method);
> >> +    }
> >>   
> >>       g_free(cphp_res_path);
> >>   }
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 53f804ac16..b73b136605 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1537,7 +1537,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >>               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
> >>           };
> >>           build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> >> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
> >> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
> >> +                       AML_SYSTEM_IO);
> >>       }
> >>   
> >>       if (pcms->memhp_io_base && nr_mem) {
> >> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> >> index e6e1a9ef59..48cded697c 100644
> >> --- a/include/hw/acpi/cpu.h
> >> +++ b/include/hw/acpi/cpu.h
> >> @@ -61,9 +61,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
> >>                                     GArray *entry, bool force_enabled);
> >>   
> >>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> >> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> >> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> >>                       const char *res_root,
> >> -                    const char *event_handler_method);
> >> +                    const char *event_handler_method,
> >> +                    AmlRegionSpace rs);
> >>   
> >>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
> >>     
> 


