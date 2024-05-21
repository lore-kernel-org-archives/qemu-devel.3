Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FAC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9M2G-00039E-Bi; Tue, 21 May 2024 05:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9M2B-00037S-6m
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9M29-0002qA-AL
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716284628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7amI72qGHb9CShbmVHT3fpwHJPCMvUS/l9EYhYOmMG0=;
 b=cr935sPxlS5GBblFjDx+z+QVvaUnvUkjKO3lyhqhdbIaumu3XIxQEU6D0Q/pOWp2YE3xC8
 uD63phscrqWexvrYWLAuyLC7V/XiGop0I4t09OL9gkWuRyeGt9iStSyf7mwbONCe3kiS3Q
 FmfQi5Vmx1+BR9EkQeiwx41Q17kOOPs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HjEAAkWCNJ2HWaNlMG4r3A-1; Tue, 21 May 2024 05:43:46 -0400
X-MC-Unique: HjEAAkWCNJ2HWaNlMG4r3A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5733eed0c19so2193442a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 02:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716284625; x=1716889425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7amI72qGHb9CShbmVHT3fpwHJPCMvUS/l9EYhYOmMG0=;
 b=EGiGH+yqiKiICehcXgO6F2YwVqH+60zbYccXwLkeogV1tSFEMWAURhuJTKtIJrZTx4
 H2BnvQDgedsYIzOJKPCg1B/XabumKEm6YSRcsgJiGbS+ByYbDuYDtRSvJGQOLq2lsVNN
 Yb3pigA83n3GUPTjC2T8YyZzmioV176bwcXKH1UXWrykoLWCXkXylzfjqWDYXhv3fi7a
 aUgVlc6cCOCCtPwgK7yMwEHjM+6Hcw/JEYy1fML6+lZvRdGQIMHOxbTdhfc65l9vwJgP
 A5eO5zwr90EWNsGHWq2Is9oGpPW8Ue6WoZdbaoCghJJK6xw/UP4oYFlUpoSE0ClKO1xh
 3x4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQFRVL4D8TV8ROJ3dsO5KBs9SD1VPfqx34QHoxi2eiloeZzsL7vH/xITDTVdhh1cmFhm2EhhaCh2+oGdb79NaQZh8Hn2Y=
X-Gm-Message-State: AOJu0YwAGLqDBqn+c9wbHJJOKl5+vzFnghqvPFCIuzG+OQ5Q7c4AW5dc
 xEt4bF2GBX1SLbzK18YcVg2blYco2LBM2loflwSWkCVLn12mLDwGnQ1RRtjH9E7nBu+HtJWIU91
 3w8W3lRDpKkOnIR7vighOlWXrkXZOde6P8H/Wij5DvUJvCBscqC2w
X-Received: by 2002:a50:9ecd:0:b0:56e:7751:ae4e with SMTP id
 4fb4d7f45d1cf-5734d67bf42mr21696414a12.33.1716284625667; 
 Tue, 21 May 2024 02:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjVeAJH2XfucFeRmHGX71bOzH4CGccB8AlVE1+Q89v3/5XsUvsD3a3jAv7prhV6FqBssnRuw==
X-Received: by 2002:a50:9ecd:0:b0:56e:7751:ae4e with SMTP id
 4fb4d7f45d1cf-5734d67bf42mr21696402a12.33.1716284625276; 
 Tue, 21 May 2024 02:43:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57421480d99sm14481198a12.8.2024.05.21.02.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 02:43:45 -0700 (PDT)
Message-ID: <d75ffd2e-8fa2-4161-8f35-56fa8c72418c@redhat.com>
Date: Tue, 21 May 2024 11:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 18/18] hw/arm/virt: Set SMMU OAS based on CPU
 PARANGE
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-19-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-19-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 4/29/24 05:24, Mostafa Saleh wrote:
> Use the new SMMU property to make the SMMU OAS match the CPU PARANGE.
> That's according to SMMU manual ARM IHI 0070F.b:
>     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/virt.c      | 14 ++++++++++++--
>  target/arm/cpu.h   |  2 ++
>  target/arm/cpu64.c |  5 +++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..f203b1f8e1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -252,6 +252,13 @@ static bool ns_el2_virt_timer_present(void)
>          arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
>  }
>  
> +/* We rely on CPU to define system OAS. */
> +static int32_t get_system_oas(void)
> +{
> +    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
> +    return cpu_arm_get_oas(cpu);
> +}
> +
>  static void create_fdt(VirtMachineState *vms)
>  {
>      MachineState *ms = MACHINE(vms);
> @@ -1384,7 +1391,7 @@ static void create_pcie_irq_map(const MachineState *ms,
>  }
>  
>  static void create_smmu(const VirtMachineState *vms,
> -                        PCIBus *bus)
> +                        PCIBus *bus, int32_t oas)
>  {
>      char *node;
>      const char compat[] = "arm,smmu-v3";
> @@ -1404,6 +1411,9 @@ static void create_smmu(const VirtMachineState *vms,
>  
>      object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                               &error_abort);
> +
> +    qdev_prop_set_uint64(dev, "oas", oas);
to me you cannot handle that this way because for older machine types
the smmu oas needs to stay the same as it was before, ie. 44. So you
need to properly handle the compats.
Since the new default value depends on the CPU PARANGE this is a bit
more tricky but maybe you get can inspired from no_its class field trick
in virt.c and introduce a no_smmu_cpu_oas_align to disable the settings
up to 9.0 included.

Thanks

Eric
> +
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -1578,7 +1588,7 @@ static void create_pcie(VirtMachineState *vms)
>  
>          switch (vms->iommu) {
>          case VIRT_IOMMU_SMMUV3:
> -            create_smmu(vms, vms->bus);
> +            create_smmu(vms, vms->bus, get_system_oas());
>              qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
>                                     0x0, vms->iommu_phandle, 0x0, 0x10000);
>              break;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 17efc5d565..68261ffbf9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3287,4 +3287,6 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
>  }
>  #endif
>  
> +int32_t cpu_arm_get_oas(ARMCPU *cpu);
> +
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 985b1efe16..08da83c082 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -787,6 +787,11 @@ static const gchar *aarch64_gdb_arch_name(CPUState *cs)
>      return "aarch64";
>  }
>  
> +int32_t cpu_arm_get_oas(ARMCPU *cpu)
> +{
> +    return FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
> +}
> +
>  static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      CPUClass *cc = CPU_CLASS(oc);


