Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E3CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 05:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdNA2-00075O-4V; Mon, 12 Aug 2024 01:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdNA0-00071Z-EL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdN9y-0002Qz-Pp
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723438798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYOj0pjO4QInpM7uFYkNau/S8zRMvfE+gddLmEdtoN4=;
 b=Wol5ztEG0Udu3blATRm3Bj7s6fGaJ2zrMIzVYNEkArKVOY8X0Lhb9I+1Czybt1fBT/ofuO
 70P+CvNDZbD+3/et/Amkl8iKZ0EwUCeNEnAR6IHlELrvTQvQ4QqeMMvpGXhejNCXAbXrLy
 quL8PTT4XtGdaovyEtx/f3/GC7jdP3Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-UGIuEturOtGTsYltB0Y-ZQ-1; Mon, 12 Aug 2024 00:59:52 -0400
X-MC-Unique: UGIuEturOtGTsYltB0Y-ZQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1fd6d695662so45977325ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 21:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723438791; x=1724043591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aYOj0pjO4QInpM7uFYkNau/S8zRMvfE+gddLmEdtoN4=;
 b=DitJB2TSTQxmiRryvt/lVJCjBdVJZ+V5fxgWWLKS87j9plcsoDFpnAucMCmgHz4BCk
 lXE3i0BKIs1LoUKwtJBEVwudTsSMc/I+nSc6IaU+A7JWuwGRMH9MeBizC+Z7+v+BPIpI
 V6+PO3Fv6/+glttVSm406v3LxKlKIMVccSIgAlwcYz2C6UnVGayWkpsxGVZ8U2eSH4ux
 zxKfjlwFsndXkiaU2WK12iNDVm/UFh1Qoe7KwD/8MEMQtZdYdRsHr4LFE0fWEW7orz9L
 l9yYLzangwXi8uPc1V+GasBZg9eJ/kTJL/5WL/1PzkXqMva7+sOZJRXHIjjiyUdXpqVY
 32qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwT/YhrxLVUvnanDYR/LigQE0w96l0tb8MdPoPPAr4LJAq7zgh0AHuzcrxRfqdj4lSarsyzHspD3yOX7ZavJfFO9aHCRs=
X-Gm-Message-State: AOJu0Yx7Fye7k7LY+Kn1PPMqvEE5RZNTdO+aOLq+u4O7qmLlQQV2uVI2
 9rMBgoI1dwOpJtOat8g2+JzEupMXkPhdqjCyS0fuWY+IhBiLOEJMin4NcfkcXcR6+kKI0EWxMaV
 WdPB5wIQoT9QRasgWdYCwuxozPNg/hCNYEhTTJT60fz0hEMbXxY2b
X-Received: by 2002:a17:902:e885:b0:1fc:6c23:8a3b with SMTP id
 d9443c01a7336-200ae4fab33mr103688175ad.17.1723438790991; 
 Sun, 11 Aug 2024 21:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEsqY2a5opqOtaTABU0V5Wcq/PWF1/fRe3UH6fBUVwDcsiK0VYIohUg+WSJa3sYxnLAODkHw==
X-Received: by 2002:a17:902:e885:b0:1fc:6c23:8a3b with SMTP id
 d9443c01a7336-200ae4fab33mr103688015ad.17.1723438790519; 
 Sun, 11 Aug 2024 21:59:50 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb7e8ad2sm29591615ad.11.2024.08.11.21.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 21:59:50 -0700 (PDT)
Message-ID: <8fcb7441-bb5c-4dd8-a9c2-9d73b6176240@redhat.com>
Date: Mon, 12 Aug 2024 14:59:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 02/29] cpu-common: Add common CPU utility for
 possible vCPUs
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
 <20240613233639.202896-3-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> This patch adds various utility functions that may be required to fetch or check
> the state of possible vCPUs. It also introduces the concept of *disabled* vCPUs,
> which are part of the *possible* vCPUs but are not enabled. This state will be
> used during machine initialization and later during the plugging or unplugging
> of vCPUs. We release the QOM CPU objects for all disabled vCPUs.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   cpu-common.c          | 31 +++++++++++++++++++++++++
>   include/hw/core/cpu.h | 54 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 85 insertions(+)
> 
> diff --git a/cpu-common.c b/cpu-common.c
> index ce78273af5..49d2a50835 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -24,6 +24,7 @@
>   #include "sysemu/cpus.h"
>   #include "qemu/lockable.h"
>   #include "trace/trace-root.h"
> +#include "hw/boards.h"
>   
>   QemuMutex qemu_cpu_list_lock;
>   static QemuCond exclusive_cond;
> @@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)
>       cpu_list_generation_id++;
>   }
>   
> +CPUState *qemu_get_possible_cpu(int index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
> +
> +    assert((index >= 0) && (index < possible_cpus->len));
> +
> +    return CPU(possible_cpus->cpus[index].cpu);
> +}
> +
> +bool qemu_present_cpu(CPUState *cpu)
> +{
> +    return cpu;
> +}
> +
> +bool qemu_enabled_cpu(CPUState *cpu)
> +{
> +    return cpu && !cpu->disabled;
> +}
> +
> +uint64_t qemu_get_cpu_archid(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
> +
> +    assert((cpu_index >= 0) && (cpu_index < possible_cpus->len));
> +
> +    return possible_cpus->cpus[cpu_index].arch_id;
> +}
> +
>   CPUState *qemu_get_cpu(int index)
>   {
>       CPUState *cpu;
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 60b160d0b4..60b4778da9 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -528,6 +528,18 @@ struct CPUState {
>       CPUPluginState *plugin_state;
>   #endif
>   
> +    /*
> +     * Some architectures do not allow the *presence* of vCPUs to be changed
> +     * after the guest has booted, based on information specified by the
> +     * VMM/firmware via ACPI MADT at boot time. Thus, to enable vCPU hotplug on
> +     * these architectures, possible vCPUs can have a CPUState object in a
> +     * 'disabled' state or may not have a CPUState object at all. This is
> +     * possible when vCPU hotplug is supported, and vCPUs are
> +     * 'yet-to-be-plugged' in the QOM or have been hot-unplugged. By default,
> +     * every CPUState is enabled across all architectures.
> +     */
> +    bool disabled;
> +

The information to determine vCPU's state has been distributed to two data structs:
MachineState::possible_cpus::cpus[] and CPUState. Why not just to maintain the vCPU's
state from MachineState::possible_cpus::cpus[]? For example, adding a new field, or
something similiar, to 'struct CPUArchId' as below.

typedef struct CPUArchId {
#define CPU_ARCH_ID_FLAG_PRESENT	(1 << 0)
#define CPU_ARCH_ID_FLAG_ENABLED        (1 << 1)
     uint32_t flags;
        :
} CPUArchId;

In order to determine if a CPUState instance is enabled or not. CPUState::cpu_index
is used as the index to MachineState::possible_cpus::cpus[]. The flags can be parsed
to determine the vCPU's state.

>       /* TODO Move common fields from CPUArchState here. */
>       int cpu_index;
>       int cluster_index;
> @@ -914,6 +926,48 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
>    */
>   CPUState *qemu_get_cpu(int index);
>   
> +/**
> + * qemu_get_possible_cpu:
> + * @index: The CPUState@cpu_index value of the CPU to obtain.
> + *         Input index MUST be in range [0, Max Possible CPUs)
> + *
> + * If CPUState object exists,then it gets a CPU matching
> + * @index in the possible CPU array.
> + *
> + * Returns: The possible CPU or %NULL if CPU does not exist.
> + */
> +CPUState *qemu_get_possible_cpu(int index);
> +
> +/**
> + * qemu_present_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU is amongst the present possible vcpus.
> + *
> + * Returns: True if it is present possible vCPU else false
> + */
> +bool qemu_present_cpu(CPUState *cpu);
> +
> +/**
> + * qemu_enabled_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU is enabled.
> + *
> + * Returns: True if it is 'enabled' else false
> + */
> +bool qemu_enabled_cpu(CPUState *cpu);
> +
> +/**
> + * qemu_get_cpu_archid:
> + * @cpu_index: possible vCPU for which arch-id needs to be retreived
> + *
> + * Fetches the vCPU arch-id from the present possible vCPUs.
> + *
> + * Returns: arch-id of the possible vCPU
> + */
> +uint64_t qemu_get_cpu_archid(int cpu_index);
> +
>   /**
>    * cpu_exists:
>    * @id: Guest-exposed CPU ID to lookup.

Thanks,
Gavin


