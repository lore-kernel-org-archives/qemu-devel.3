Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0993DD2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 12:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8J19-0004Yz-Kg; Tue, 05 Nov 2024 07:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8J0y-0004YK-J0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8J0w-0000U6-E2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730811028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=465g0lg81sKbtxLWNg6ScFjOztpGakJeYxSZZ4FBNGc=;
 b=N7qLANxKlJaS6HZzMKyxjvlT12napS/k4e8ga/Dl6NkrCFITZEVdP6KNS6X6BmGSiOoNTk
 tAut3zIzgDrSBJCAOwVt2NcjK195ofjNShkn5yqF3xki4ahNODwNnu/dgPEjpvjMuRUuIf
 8kATBl7pIsE8gnDATYaunobR2fEhgcY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-9xPWPpYCNwWPvU8h20plaw-1; Tue, 05 Nov 2024 07:50:27 -0500
X-MC-Unique: 9xPWPpYCNwWPvU8h20plaw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e7dc83ecso3385202e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 04:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811025; x=1731415825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=465g0lg81sKbtxLWNg6ScFjOztpGakJeYxSZZ4FBNGc=;
 b=WiN3afUHNUwl/kAffLZSPeQiJ8+L1E1R2eEh1yggCkKitzMvsDdDnfjUX2nt1Oc5JO
 Jtvh9rFVqLF+X0jOAZ/ZhSdDnT9TmAZuyO6s6n++bZLS/tJGryj1S3ZMkAIAZgrQV/Zs
 37eGzhakGSZo3684+xYv1GhODl6HVt5ONi42gxo7ycU7qbUaETI8GEd91uV6w+JXx/NZ
 Vx/Eq3m/iXrMR6Gg96R26RQNKyBXCygQq/fS0/OCmyDum9oiEHcmr5L9AD0G0/uzDjHt
 A4c8a99ylElWjFq/BPqFxdAUEKIcRLHVelXKOcChiQ8IOcfruYL9ZVv4oYqfjFquDOz0
 qVFg==
X-Gm-Message-State: AOJu0YyjCFjy4BOSvKQSzgv0Y27UP96pv5hlLdmWsfTv6G1f8RA7GWAG
 QLBietZWUqJNbEQ+FSvJg+vm85bvZnlYoL6mv/84hUUWN98RMEb6y/XKYXcywBEmrBRPdz7rfQP
 GeSN32uWcddKItoEGt9cPqbYDIxDgTGCbgPJQTkTs3a7yr4TDTVol
X-Received: by 2002:a05:6512:e91:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-53b34c5f7e3mr18027285e87.45.1730811025422; 
 Tue, 05 Nov 2024 04:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5wP1a1PT+hDbKiCqKfNLkpcpTjM7+M4yZZrldirShdhAO0EWTFXHUjFjriyBAOTEYXilX+g==
X-Received: by 2002:a05:6512:e91:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-53b34c5f7e3mr18027257e87.45.1730811024934; 
 Tue, 05 Nov 2024 04:50:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca704sm217461875e9.41.2024.11.05.04.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 04:50:24 -0800 (PST)
Date: Tue, 5 Nov 2024 13:50:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Salil
 Mehta <salil.mehta@huawei.com>, Ani Sinha <anisinha@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM vCPU
 ACPI Hotplug states
Message-ID: <20241105135023.703f1e84@imammedo.users.ipa.redhat.com>
In-Reply-To: <bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
 <bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d.1730754238.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 4 Nov 2024 16:09:26 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: Salil Mehta <salil.mehta@huawei.com>
> 
> Reflect the QOM vCPUs ACPI CPU hotplug states in the `_STA.Present` and
> and `_STA.Enabled` bits when the guest kernel evaluates the ACPI
> `_STA` method during initialization, as well as when vCPUs are
> hot-plugged or hot-unplugged. If the CPU is present then the its
> `enabled` status can be fetched using architecture-specific code [1].
> 
> Reference:
> [1] Example implementation of architecture-specific hook to fetch CPU
>     `enabled status
>     Link: https://github.com/salil-mehta/qemu/commit/c0b416b11e5af6505e558866f0eb6c9f3709173e
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Message-Id: <20241103102419.202225-4-salil.mehta@huawei.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/core/cpu.h |  1 +
>  hw/acpi/cpu.c         | 38 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index e7de77dc6d..db8a6fbc6e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -159,6 +159,7 @@ struct CPUClass {
>      void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
>      int64_t (*get_arch_id)(CPUState *cpu);
>      bool (*cpu_persistent_status)(CPUState *cpu);
> +    bool (*cpu_enabled_status)(CPUState *cpu);
>      void (*set_pc)(CPUState *cpu, vaddr value);
>      vaddr (*get_pc)(CPUState *cpu);
>      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 9b03b4292e..23443f09a5 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -50,6 +50,18 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>      }
>  }
>  
> +static bool check_cpu_enabled_status(DeviceState *dev)
> +{
> +    CPUClass *k = dev ? CPU_GET_CLASS(dev) : NULL;
> +    CPUState *cpu = CPU(dev);
> +
> +    if (cpu && (!k->cpu_enabled_status || k->cpu_enabled_status(cpu))) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>  {
>      uint64_t val = 0;
> @@ -63,10 +75,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>      cdev = &cpu_st->devs[cpu_st->selector];
>      switch (addr) {
>      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
> -        val |= cdev->cpu ? 1 : 0;
> +        val |= check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : 0;
>          val |= cdev->is_inserting ? 2 : 0;
>          val |= cdev->is_removing  ? 4 : 0;
>          val |= cdev->fw_remove  ? 16 : 0;
> +        val |= cdev->cpu ? 32 : 0;
>          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>          break;
>      case ACPI_CPU_CMD_DATA_OFFSET_RW:
> @@ -349,6 +362,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_REMOVE_EVENT  "CRMV"
>  #define CPU_EJECT_EVENT   "CEJ0"
>  #define CPU_FW_EJECT_EVENT "CEJF"
> +#define CPU_PRESENT       "CPRS"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> @@ -409,7 +423,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>          /* tell firmware to do device eject, write only */
>          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> -        aml_append(field, aml_reserved_field(3));
> +        /* 1 if present, read only */
> +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> +        aml_append(field, aml_reserved_field(2));
>          aml_append(field, aml_named_field(CPU_COMMAND, 8));
>          aml_append(cpu_ctrl_dev, field);
>  
> @@ -439,6 +455,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
>          Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
>          Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
> +        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
>          Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
>          Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
>          Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
> @@ -467,13 +484,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          {
>              Aml *idx = aml_arg(0);
>              Aml *sta = aml_local(0);
> +            Aml *ifctx2;
> +            Aml *else_ctx;
>  
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>              aml_append(method, aml_store(idx, cpu_selector));
>              aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_enabled, one));
> +            ifctx = aml_if(aml_equal(is_present, one));

very likely this will break hotplug on after migration to older QEMU.

>              {
> -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> +                ifctx2 = aml_if(aml_equal(is_enabled, one));
> +                {
> +                    /* cpu is present and enabled */
> +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> +                }
> +                aml_append(ifctx, ifctx2);
> +                else_ctx = aml_else();
> +                {
> +                    /* cpu is present but disabled */
> +                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
> +                }
> +                aml_append(ifctx, else_ctx);
>              }
>              aml_append(method, ifctx);
>              aml_append(method, aml_release(ctrl_lock));


