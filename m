Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04122CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd98-00020V-BI; Tue, 28 Oct 2025 02:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vDd8S-0000ss-1A
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vDd8P-0000fe-B4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761632684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Guh1Uekl3vuapz7CFiOfAcyy+/bldv09DzV0CSIPBog=;
 b=Uat3RwrB745KHxXROs1v4z/HzFIX/H3xPEyqPEejYeS0SuNJ1aNoY7OCDY/Ypt7sa/MpZq
 oODW7MQQx1cK1vykHALG942MyBAA2pDn6TYSWg+PEGQqCWC2LgJ9DS2P7UAZwvvbF90GYU
 N54m/WdxkzEGvJBUFCoUrhIt6Jjd0Hw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-6BwjWa1tNqi9O6U-loNWyA-1; Tue, 28 Oct 2025 02:24:41 -0400
X-MC-Unique: 6BwjWa1tNqi9O6U-loNWyA-1
X-Mimecast-MFC-AGG-ID: 6BwjWa1tNqi9O6U-loNWyA_1761632680
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so3747206a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632680; x=1762237480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Guh1Uekl3vuapz7CFiOfAcyy+/bldv09DzV0CSIPBog=;
 b=bRBDt23hNSPbQNT4mxUOgTdV1Hr6eu2Jz86aHpdTbkQSm7qNWDIFvztHA+5kCmYYV4
 1XoHQ+IhwjQsbnDGruNi/qJk6XO1UYCv8v1H6CtXO6TNUOWDNijKibcpGstzvdY0Y8xe
 yrkKVFGYG7dcbP10q2ToHnHZYQKdWyfYHY8pkE/6ANFTIhkI7qbhfWvC4mMM5U1NzGBs
 roIJE9/2bBI+AmmVqYyMJ5aQKlrODSffQnXLWcII/pUw98GIsflPUdWsiF8uuEvC2UF2
 89oDNVK1Gut5znz3Nzd31fSGsMB4HLNcfi/TcaJtxY/NHc/EyK4D9QyGV7ACLJi6Spjy
 3gXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTgVK0vwtSB4ozR9NctG8RzEeB4FxaMXfWRRetZdFNu0qTNNeww1VITscFYPdVs2Wz37XmhMj+ef7k@nongnu.org
X-Gm-Message-State: AOJu0YwM3KtRUJMeBei4ra0bFuU6Cz8Hzqdx1hIx+l1at2FB3BPQebGl
 6adXBBEowX9vdVu+S+vMPVjvkqWLOzzLpp4gfU6paTAFIiaPxM3znpgBlKMFBCESbNs5UswhQLl
 ODaIzz5N2VELr7+50R6KmQWjLGG/N0NRh630La3Am9/v7AC6ufxmR02c7
X-Gm-Gg: ASbGncuQE+1ClumICrBJ0yNxHasLilAGGg3ebovMyNJRX0vfhswoZYwzdF0yNAR30ta
 MbeqOvZYKFG01SGTFHkBaxNyHFn8zy5JF5GzPC2dD0gh/l2bXEtDYIvCM9srwD7S1A46kAJgPRE
 rdMkUdNBk2S30QsMYCkZwZ5Jlykxq16c/fOi0eZEtJLInfVyTNeJ8awNPJiNfWRJMDh7kL7j3kb
 hcKxi6iLrv984/ulLSZ3FgRdta1TqNnIJxWSooWYHsXKjNkXEELWD6Ro7cDmKCM/iX16CxPrmAu
 4+rf3aNRgo0b7P+maiACgZstW7rqKXx1Ee0Wj6jdy42lKCaVxJhMbuTcLlEg3mX63b+zzhE0lHp
 fJwwBGnv7MINvvUsFALNCrDz5XwLrdzhCLuOmHkc=
X-Received: by 2002:a05:6a20:3ca2:b0:2e3:a914:aab7 with SMTP id
 adf61e73a8af0-344d4229f5cmr2626912637.47.1761632680531; 
 Mon, 27 Oct 2025 23:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE64lbqq/bITrZSJdZrfRZj9HTMnsl7PioJub74Cpui5L3PdBPHi9JLQtMPbah5hRm49bSS5Q==
X-Received: by 2002:a05:6a20:3ca2:b0:2e3:a914:aab7 with SMTP id
 adf61e73a8af0-344d4229f5cmr2626893637.47.1761632680130; 
 Mon, 27 Oct 2025 23:24:40 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a4387cbf00sm4463926b3a.2.2025.10.27.23.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 23:24:39 -0700 (PDT)
Message-ID: <666f00c4-da3e-40ed-8ad2-57bfee5b2f40@redhat.com>
Date: Tue, 28 Oct 2025 16:24:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 04/24] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
To: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com,
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-5-salil.mehta@opnsrc.net>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251001010127.3092631-5-salil.mehta@opnsrc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Salil,

On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> From: Salil Mehta <salil.mehta@huawei.com>
> 
> Store the user-specified topology (socket/cluster/core/thread) and derive a
> unique 'vcpu-id'. The 'vcpu-id' is used as the slot index in the possible vCPUs
> list when administratively enabling or disabling a vCPU.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>   hw/arm/virt.c         | 10 ++++++++++
>   include/hw/arm/virt.h | 36 ++++++++++++++++++++++++++++++++++++
>   target/arm/cpu.c      |  4 ++++
>   target/arm/cpu.h      |  4 ++++
>   4 files changed, 54 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 76f21bd56a..4ded19dc69 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2334,6 +2334,14 @@ static void machvirt_init(MachineState *machine)
>                             &error_fatal);
>   
>           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
> +        object_property_set_int(cpuobj, "socket-id", virt_get_socket_id(n),
> +                                NULL);
> +        object_property_set_int(cpuobj, "cluster-id", virt_get_cluster_id(n),
> +                                NULL);
> +        object_property_set_int(cpuobj, "core-id", virt_get_core_id(n),
> +                                NULL);
> +        object_property_set_int(cpuobj, "thread-id", virt_get_thread_id(n),
> +                                NULL);
>   
>           if (!vms->secure) {
>               object_property_set_bool(cpuobj, "has_el3", false, NULL);
> @@ -2902,6 +2910,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>   {
>       int n;
>       unsigned int max_cpus = ms->smp.max_cpus;
> +    unsigned int smp_threads = ms->smp.threads;
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>       MachineClass *mc = MACHINE_GET_CLASS(vms);
>   
> @@ -2915,6 +2924,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>       ms->possible_cpus->len = max_cpus;
>       for (n = 0; n < ms->possible_cpus->len; n++) {
>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
> +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
>           ms->possible_cpus->cpus[n].arch_id =
>               virt_cpu_mp_affinity(vms, n);
>   
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 365a28b082..683e4b965a 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -213,4 +213,40 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
>               vms->highmem_redists) ? 2 : 1;
>   }
>   
> +static inline int virt_get_socket_id(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
> +}
> +
> +static inline int virt_get_cluster_id(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
> +}
> +
> +static inline int virt_get_core_id(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
> +}
> +
> +static inline int virt_get_thread_id(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
> +}
> +
>   #endif /* QEMU_ARM_VIRT_H */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 0c9a2e7ea4..7e0d5b2ed8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2607,6 +2607,10 @@ static const Property arm_cpu_properties[] = {
>       DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                           mp_affinity, ARM64_AFFINITY_INVALID),
>       DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> +    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
> +    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
> +    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
> +    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
>       DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
>       /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
>       DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),

SMPCompatProps::clusters_supported isn't always true on ARM platforms. Is it safe
to add "cluster-id" property to ARM CPU, which is available to all ARM platforms?

Thanks,
Gavin

> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index dc9b6dce4c..cd5982d362 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1126,6 +1126,10 @@ struct ArchCPU {
>       QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
>   
>       int32_t node_id; /* NUMA node this CPU belongs to */
> +    int32_t socket_id;
> +    int32_t cluster_id;
> +    int32_t core_id;
> +    int32_t thread_id;
>   
>       /* Used to synchronize KVM and QEMU in-kernel device levels */
>       uint8_t device_irq_level;


