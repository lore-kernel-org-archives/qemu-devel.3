Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3450BD2E9C6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVtJ-0006j7-5m; Mon, 11 Nov 2024 09:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAVtH-0006iP-Ai
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAVtF-0003CR-G8
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731337179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfwG7C9f8beRerYhjJe+Jyy+omwy59X5IZrCEpNc7qo=;
 b=a3wHqHmqeom1iqKrbSl764Q02F9ANhtZs76CJHck3GCZwWiNhUO7uaED2m/5qoqgJo0lQa
 oTwX+GOYi9RoY8IcK0Bl2eORfqdlHfpaa1+OgTMpTWUlpEm9cb6ygEL7yY+ymlAyNxg2oY
 hdv2gC/FNaVi9dwcj9L0IX/pW1JNLaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-QTnPMpKQPP2cUEjiYxEdVQ-1; Mon, 11 Nov 2024 09:59:38 -0500
X-MC-Unique: QTnPMpKQPP2cUEjiYxEdVQ-1
X-Mimecast-MFC-AGG-ID: QTnPMpKQPP2cUEjiYxEdVQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-381d07c377cso3718323f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731337177; x=1731941977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfwG7C9f8beRerYhjJe+Jyy+omwy59X5IZrCEpNc7qo=;
 b=gdIfsWfkeJvY67fxEXRBdV96XPalpE2cBegA/sGHFwFzg0udFr4n5tiPdJwhae4COM
 habOzdBUh27YHr5Mr0lBPXFlF2YjNdtSaSVHZvxJYQ1FIlM0UWQiCBWH8xcsLYJ3GqFG
 Ev+SeAVTpWFCHugzGaHHKtK0CDSjH68ay0UOMPySgAB36KoA9N1z7Kfs3GA/BRwubkHN
 dNQKEOgrzCyP0MD4Wdk9AGyUqCg1Vob841n0Z08WrBVmyUs5ba9afe7+6M6pY7eSGdtD
 CPY+GSd2ETze0GmX8RL97j/l3F+N54sgfChhGy4c8064UxevIMVftMWGE4sVfwDBqfQv
 utxQ==
X-Gm-Message-State: AOJu0YxtIKy6ENc7UH0U2ca1JoC/SneRKcD8vobwZDm5ZHm0N+vfLHRO
 F0ySUUgN0RBKZxjkKAtBMhHxjKtfMPxweREzrcGbCwE/IlMtYZ2NyKVOGAMTcayiOXdWMbRlj3b
 Jxqgnbim/mFmc020ztGubRT8NCqdo79WahFus0vs1NldxOBSVKqIg
X-Received: by 2002:a05:6000:1a89:b0:37d:4cf9:e08b with SMTP id
 ffacd0b85a97d-381f18723d4mr12954500f8f.31.1731337176683; 
 Mon, 11 Nov 2024 06:59:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHac10dMTIrNusnPOhufKkrLuXR7aJ2pswaL21uzCnKB2QlDpAM7Pksld5S9oYhKdqAH5QIA==
X-Received: by 2002:a05:6000:1a89:b0:37d:4cf9:e08b with SMTP id
 ffacd0b85a97d-381f18723d4mr12954447f8f.31.1731337176153; 
 Mon, 11 Nov 2024 06:59:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97f544sm13198084f8f.40.2024.11.11.06.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 06:59:35 -0800 (PST)
Date: Mon, 11 Nov 2024 15:59:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <jonathan.cameron@huawei.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <anisinha@redhat.com>,
 <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <zhao1.liu@intel.com>, <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: Re: [PATCH V2 2/3] Fix: CPUs presence logic in _STA for x86
 backward compatability
Message-ID: <20241111155933.0b920f57@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241109000728.206825-3-salil.mehta@huawei.com>
References: <20241109000728.206825-1-salil.mehta@huawei.com>
 <20241109000728.206825-3-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, 9 Nov 2024 00:07:27 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Checking `is_present` first can break x86 migration from new Qemu
> version to old Qemu. This is because CPRS Bit is not defined in the
> older Qemu register block and will always be 0 resulting in check always
> failing. Remove CPU_PRESENT Bit to preserve older ABI.
> 
> -                If ((\_SB.PCI0.PRES.CPEN == One))
> -                {
> -                    Local0 = 0x0F
> +                If ((\_SB.PCI0.PRES.CPRS == One))
> +                {
> +                    If ((\_SB.PCI0.PRES.CPEN == One))
> +                    {
> +                        Local0 = 0x0F
> +                    }
> +                    Else
> +                    {
> +                        Local0 = 0x0D
> +                    }
>                  }
> 
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

AML parts looks fine modulo global nit.

My recommendation is to revert both patches for 9.2,
as that would fix the broken hotplug and return code to original
state. And then repost them (amended) as part of ARM cpuhp series
to have cleaner history instead of spaghetti of fixups/refactoring commits.

See other comments below.


> ---
>  hw/acpi/cpu.c         | 49 ++++++++++++++++---------------------------
>  include/hw/acpi/cpu.h |  1 +
>  include/hw/core/cpu.h |  1 -
>  3 files changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 23443f09a5..7b0badd08a 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -23,6 +23,8 @@ enum {
>      CPHP_CMD_MAX
>  };
>  
> +static bool always_present_cpus;
> +
>  static ACPIOSTInfo *acpi_cpu_device_status(int idx, AcpiCpuStatus *cdev)
>  {
>      ACPIOSTInfo *info = g_new0(ACPIOSTInfo, 1);
> @@ -79,7 +81,6 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>          val |= cdev->is_inserting ? 2 : 0;
>          val |= cdev->is_removing  ? 4 : 0;
>          val |= cdev->fw_remove  ? 16 : 0;
> -        val |= cdev->cpu ? 32 : 0;
>          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>          break;
>      case ACPI_CPU_CMD_DATA_OFFSET_RW:
> @@ -246,15 +247,9 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>      memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
>  }
>  
> -static bool should_remain_acpi_present(DeviceState *dev)
> +static inline bool should_remain_acpi_present(DeviceState *dev)
>  {
> -    CPUClass *k = CPU_GET_CLASS(dev);
> -    /*
> -     * A system may contain CPUs that are always present on one die, NUMA node,
> -     * or socket, yet may be non-present on another simultaneously. Check from
> -     * architecture specific code.
> -     */
> -    return k->cpu_persistent_status && k->cpu_persistent_status(CPU(dev));
> +    return always_present_cpus;
>  }

instead of using global, we should pass parameter to

 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,                        
                         CPUHotplugState *state, hwaddr base_addr, bool always_present_cpus)
                                                                   ^^^^  

and store it in 'CPUHotplugState *state::always_present_cpus',
Then caller would supply it to the function depending on configuration
(a new property in GED to opt-in in the feature, and hardcoded 'false' for x86 call sites)
 

Also this does leave around cpu_enabled_status() callback,
instead of adding callbacks we should just use
  object_property_get_bool(OBJECT(cdev->cpu), 'realized')
to do the same (i.e. what v6 was hiding behind callbacks).

That is still correct for x86, it might be different for ARM,
like a dedicated property 'enabled' depending on where
discussion leads us, but that is the topic for discussion
with ARM cpuhp patches.

The point is, it's stray arm cpuhp patch and not needed in 9.2.
It's better to have 2d6cfbaf1 and bf1ecc8dad6 reverted for 9.2 and
then ARM cpuhp will bring them back to the clean 9.1 codebase,
instead of having a mess of not necessary right now broken patches +
fixups to bring them to desired state.

>  static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
> @@ -362,7 +357,6 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_REMOVE_EVENT  "CRMV"
>  #define CPU_EJECT_EVENT   "CEJ0"
>  #define CPU_FW_EJECT_EVENT "CEJF"
> -#define CPU_PRESENT       "CPRS"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> @@ -423,9 +417,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>          /* tell firmware to do device eject, write only */
>          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> -        /* 1 if present, read only */
> -        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> -        aml_append(field, aml_reserved_field(2));
> +        aml_append(field, aml_reserved_field(3));
>          aml_append(field, aml_named_field(CPU_COMMAND, 8));
>          aml_append(cpu_ctrl_dev, field);
>  
> @@ -455,7 +447,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
>          Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
>          Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
> -        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
>          Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
>          Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
>          Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
> @@ -482,28 +473,24 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>  
>          method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
>          {
> -            Aml *idx = aml_arg(0);
> +            Aml *default_sta = aml_int(opts.always_present_cpus ? 0xD : 0);
>              Aml *sta = aml_local(0);
> -            Aml *ifctx2;
> -            Aml *else_ctx;
> +            Aml *idx = aml_arg(0);
> +
> +            always_present_cpus = opts.always_present_cpus;

opts argument is meant to configure AML generator,
so I'd rather not overload it with ACPI device configuration
and introduction of a global var.  

>  
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>              aml_append(method, aml_store(idx, cpu_selector));
> -            aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_present, one));
> +            /*
> +             * Default case:
> +             * _STA(0xD) = cpu is present and disabled OR
> +             * _STA(0x0) = cpu is not present (and hence disabled)
> +             */
> +            aml_append(method, aml_store(default_sta, sta));
> +            ifctx = aml_if(aml_equal(is_enabled, one));
>              {
> -                ifctx2 = aml_if(aml_equal(is_enabled, one));
> -                {
> -                    /* cpu is present and enabled */
> -                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> -                }
> -                aml_append(ifctx, ifctx2);
> -                else_ctx = aml_else();
> -                {
> -                    /* cpu is present but disabled */
> -                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
> -                }
> -                aml_append(ifctx, else_ctx);
> +                /* _STA(0xF) = cpu is present and enabled */
> +                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
>              }
>              aml_append(method, ifctx);
>              aml_append(method, aml_release(ctrl_lock));
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 32654dc274..4a3e591120 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>  typedef struct CPUHotplugFeatures {
>      bool acpi_1_compatible;
>      bool has_legacy_cphp;
> +    bool always_present_cpus;
>      bool fw_unplugs_cpu;
>      const char *smi_path;
>  } CPUHotplugFeatures;
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index db8a6fbc6e..e936b67675 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -158,7 +158,6 @@ struct CPUClass {
>      void (*dump_state)(CPUState *cpu, FILE *, int flags);
>      void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
>      int64_t (*get_arch_id)(CPUState *cpu);
> -    bool (*cpu_persistent_status)(CPUState *cpu);
>      bool (*cpu_enabled_status)(CPUState *cpu);
>      void (*set_pc)(CPUState *cpu, vaddr value);
>      vaddr (*get_pc)(CPUState *cpu);


