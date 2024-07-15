Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9FAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLvg-0006n0-J2; Mon, 15 Jul 2024 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLvd-0006m4-OO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLvO-0000TI-D1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721050768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBtjuDMSwuw3nJB8kbux1qyAWsDSE9RGuyeX6JuknmI=;
 b=c785Dx0bpM/mH94lbmPItLolnepZp3DK3pL7WLmE8UXfQyn6am106yOekXl2AWWmg1KwW0
 2meRehNIUzYBUrG59D0zDMuyUlzyAzKoTZpER6xUb7seNRTabeYd0X1f9/ja3C3Xpc7gDc
 f/0AN5SeeWwQUwGjJTpFrvqjPeGLN4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-jR5psgpUMJuiOqvVJ3ETwg-1; Mon, 15 Jul 2024 09:39:27 -0400
X-MC-Unique: jR5psgpUMJuiOqvVJ3ETwg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so3860594f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050766; x=1721655566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBtjuDMSwuw3nJB8kbux1qyAWsDSE9RGuyeX6JuknmI=;
 b=wngYJ1Ye8a8sUHKlY6th4MGW2J8rZxz0KIHDmi45FNAyQsNQIUh6/Yq5G/1scx4Lvg
 lFyDYUkQuheCCprC4vLXhywaBrr+F+sV24//A9WhedZVAQwXCTgqq7vcxwdZ5AcJoLQc
 DhLqcflSgcHeJfV6hfQJ22vjZ8PzFPXllz0zrzOAzGyhCMKyKwF26DXNz11/Jgf80dgR
 tdoH7FsZcu5+r6cNQrTCPDsapkTjudjrTh28Ng9Xt597y+Omms1b/HZ/0mf8Y1KzJkkM
 DcqipIpGRTdvdAe0a+vypzfTEHx5noedI7yVARk8YgjQSdCNpE+OSltO2xWGP1mtzw7G
 Ie3A==
X-Gm-Message-State: AOJu0Yxw2hcS4ViIfiAsjE5P8oOH4yZpZWY6KFg6nz7dx4H+bpHjLhlY
 tapFF+MUTxPWXiYJV5B02suwBNmOR9Ii2ZI1L3C0I0gu1bhKi8FrQZ+A26pod3oJdPeJTAxvQ4n
 0hWXJsfTz5QKrxnJUvnzTdp8CDG4DcxiHKZdNZ98VGJfef2cOaS5d
X-Received: by 2002:adf:e683:0:b0:367:8fc3:a25f with SMTP id
 ffacd0b85a97d-367cea96453mr15464577f8f.37.1721050765824; 
 Mon, 15 Jul 2024 06:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWSY2rRJA7awtr3FB4QsQZYyjuGhjrwz0ONdEACL14YbT7jQ+qqF420YI4Zify45G+u4PF5w==
X-Received: by 2002:adf:e683:0:b0:367:8fc3:a25f with SMTP id
 ffacd0b85a97d-367cea96453mr15464550f8f.37.1721050765359; 
 Mon, 15 Jul 2024 06:39:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb939sm6451539f8f.89.2024.07.15.06.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:39:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:39:23 +0200
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
Subject: Re: [PATCH V15 5/7] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20240715153923.60f9a2f1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240713182516.1457-6-salil.mehta@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-6-salil.mehta@huawei.com>
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
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 13 Jul 2024 19:25:14 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
> based and existing CPUs AML code assumes _CRS objects would evaluate to a system
> resource which describes IO Port address. But on ARM arch CPUs control
> device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
> evaluate to system resource which describes memory-mapped base address. Update
> build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
> update the _CRS object.
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/cpu.c         | 17 +++++++++++++----
>  hw/i386/acpi-build.c  |  3 ++-
>  include/hw/acpi/cpu.h |  5 +++--
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index cf5e9183e4..5cb60ca8bc 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -338,9 +338,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
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
> @@ -364,14 +365,22 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              aml_name_decl("_UID", aml_string("CPU Hotplug resources")));
>          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>  
> +        assert((rs == AML_SYSTEM_IO) || (rs == AML_SYSTEM_MEMORY));
> +
>          crs = aml_resource_template();
> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
>                                 ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else if (rs == AML_SYSTEM_MEMORY) {
> +            aml_append(crs, aml_memory32_fixed(base_addr,
> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> +        }
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
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f4e366f64f..5d4bd2b710 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1536,7 +1536,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
> index df87b15997..32654dc274 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -63,9 +63,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
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


