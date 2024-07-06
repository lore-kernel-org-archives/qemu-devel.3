Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD8C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6Vi-0001OS-TX; Sat, 06 Jul 2024 10:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6Vh-0001NC-6t
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6Vf-0007J9-FC
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720276530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7ZDVMJB6mbHb0NzR0PiU6PX/ITdG+OKHh2qw/xAKpw=;
 b=eqAfsOpSzoH2gIidX/dz45wHCW4bZTOWZyA7K6r1hfIpUw1yaf8kEqy2VCgVbH9saMsZY+
 pgrfdjpGuIcHTEEhiwLI+qJithhHiAmgX7T176FpP6PIGwiCcpw/mYR6XxoUPcEf8DWN/8
 cgLOPtXW6Bq/HtmvvmY5A3xQcE9EbzA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-2uDlnAwOPlWUtygjsd1FWg-1; Sat, 06 Jul 2024 10:35:27 -0400
X-MC-Unique: 2uDlnAwOPlWUtygjsd1FWg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3679aa0ee0aso1627889f8f.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720276526; x=1720881326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7ZDVMJB6mbHb0NzR0PiU6PX/ITdG+OKHh2qw/xAKpw=;
 b=AMRo0JiKxns2GkrliUXZOojHb+mIBsWFF1b68vKomTzfqaoAqibjMNo5LaINXlSlAI
 tJfq/QLZrYBDAUWir3DjXKWBB7xrVtoUGJl5+9Nem8rEZyIwEPFT8ufcJfpFzfSugLT+
 76QsgEt/kyy/nAo98og1cbMqj8R7zN9TgMNepbD5ylWNc7c3QbqlpJ93iw3GBSjcthA7
 Cuzzio9LrX5m9TsFI3FnuufQ/VTZlcbrX0nQsGkJJzrY6NmuJqBthtqaISBvYoHHZWk2
 A4+HnWZ5JQm8HRFWkh6MJWJHkfhvdzZKVh4iQ3fFQi+I87cd5NsvUfsh7SvXrBGGTx3H
 QKsA==
X-Gm-Message-State: AOJu0YwplkyYy2Gc3+vQ7ZBP/3GF6i7Jy9nPjmngnpwAf6E5gcNDeYO9
 tzxv6uQkFHtU7xnFeXMWE6hkloyGsiTNvfz+I/fdaokm7+IYN0rO6Jiks3DFsZwq8DjO3/IurMU
 ada+a1up0CQ3A5uQhCppP+m4PM6X5QmL4128ESmY23l8r/X307UDy
X-Received: by 2002:a05:6000:c0b:b0:367:997b:21ed with SMTP id
 ffacd0b85a97d-3679dd329e5mr4238871f8f.42.1720276526514; 
 Sat, 06 Jul 2024 07:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5cWLnH2T8GFKhOxtK5ngGPN6H3OrRYO9TPrNCsny//wbFw29J/ysK1akC39mU+6i6Px3yWA==
X-Received: by 2002:a05:6000:c0b:b0:367:997b:21ed with SMTP id
 ffacd0b85a97d-3679dd329e5mr4238866f8f.42.1720276526131; 
 Sat, 06 Jul 2024 07:35:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36796351169sm8414124f8f.95.2024.07.06.07.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:35:25 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:35:24 +0200
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
Subject: Re: [PATCH V13 5/8] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20240706163524.012b6caf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-6-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-6-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Fri, 7 Jun 2024 12:56:46 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
> based and existing CPUs AML code assumes _CRS objects would evaluate to a system
> resource which describes IO Port address. But on ARM arch CPUs control
> device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
> evaluate to system resource which describes memory-mapped base address. Update
> build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
> update the _CRS object.
ack for above change


but below part is one too many different changes withing 1 patch.
anyways, GPE part probably won't be needed if you follow suggestion made
on previous patch.
 
> On x86, CPU Hotplug uses Generic ACPI GPE Block Bit 2 (GPE.2) event handler to
> notify OSPM about any CPU hot(un)plug events. Latest CPU Hotplug is based on
> ACPI Generic Event Device framework and uses ACPI GED device for the same. Not
> all architectures support GPE based CPU Hotplug event handler. Hence, make AML
> for GPE.2 event handler conditional.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/acpi/cpu.c         | 23 ++++++++++++++++-------
>  hw/i386/acpi-build.c  |  3 ++-
>  include/hw/acpi/cpu.h |  5 +++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index af2b6655d2..4c63514b16 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -343,9 +343,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_FW_EJECT_EVENT "CEJF"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>                      const char *res_root,
> -                    const char *event_handler_method)
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs)
>  {
>      Aml *ifctx;
>      Aml *field;
> @@ -370,13 +371,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>  
>          crs = aml_resource_template();
> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
>                                 ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else {

else
 if (rs == yours type)
> +            aml_append(crs, aml_memory32_fixed(base_addr,
> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> +        }
else assert on not supported input

> +
>          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>  
>          /* declare CPU hotplug MMIO region with related access fields */
>          aml_append(cpu_ctrl_dev,
> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> +            aml_operation_region("PRST", rs, aml_int(base_addr),
>                                   ACPI_CPU_HOTPLUG_REG_LEN));
>  
>          field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> @@ -700,9 +707,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>      aml_append(sb_scope, cpus_dev);
>      aml_append(table, sb_scope);
>  
> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
>  
>      g_free(cphp_res_path);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53f804ac16..b73b136605 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1537,7 +1537,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>          };
>          build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
> +                       AML_SYSTEM_IO);
>      }
>  
>      if (pcms->memhp_io_base && nr_mem) {
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index e6e1a9ef59..48cded697c 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -61,9 +61,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
>                                    GArray *entry, bool force_enabled);
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>                      const char *res_root,
> -                    const char *event_handler_method);
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs);
>  
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>  


