Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2pP1-0001A8-4p; Fri, 03 May 2024 05:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2pOx-00019i-95
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:40:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2pOr-00075G-Cq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:40:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a599c55055dso10272966b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714729214; x=1715334014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+aYukAFjSkKANGHcVIV8wuIMZB/UvTg/F4UINqCVkZU=;
 b=vqUAEpKjwWtXpWLIq/OqhwiqqP0kH8Jv6sXZvkXiq0BkZrClakN+6Sx2nnWWt3EmA2
 +4yZCPp+PkMXWuy6oPu0+iuBmhSuWG7hs512Cfxz1li4SgHprqEjm0zNXz7dyg8cWVow
 WPIJst8adgrE3E7bVnzT52v0JKC8xkjm2xT+jO4LlDyfZAXGj1HvFn0aq9B+3KV4B0DC
 i/wyinkWp69wdPCIPR8LyjqqEcBZkyLyQP5kiOZUb3DYL0LxhQBjbfQYt8sbw5Bi3izH
 7LW7bzehicAbjJkHgRZDhGQVM2RqBqdxKhPppJjzxP0pSeAiahDebH944bbqdKJXc5bD
 wDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714729214; x=1715334014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+aYukAFjSkKANGHcVIV8wuIMZB/UvTg/F4UINqCVkZU=;
 b=jvOlDutwpX+V/qsYqa+gPS8cjQwQr14ffhhoV9gOCt1+qp7arR6P4M05nAPg9YMIb+
 RuX7bB634BgicIYU4zKa1qFpRAMMO1eK9TBwfXczjUZQlrFBO7wCjITZw7YX364h1cAE
 CvbLaoKYNMcG8AvOQWFQYagzm3tdUjyWaTWK1BXUIFK6z2aLe751RhBCKySQD1x6WRCR
 sW1IZLkdrrn7XoCT7ngcLsWBblwRQVaquqENlsqTX/XhNdqyKnCdOh0lCj6fL83EZc0u
 tQdIJ0p9jXBOKqEsWgXAbCbsN8jRu1n9oUAMq5DcXTc6t/nCMFsK5Yiuw2imCcF1Groi
 K4nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVasa782+5vfGhM/Fp2A/gM+QlxpLmWphP07vQIydfnMJ27UCTgyQaH4L02cmrBYQClDj3tWQCaz2XDtUXskaO9JDdRMzA=
X-Gm-Message-State: AOJu0YyPX4et8I4z6bxJL4cp/iu1SDlWc7MGIe3bYR0+XYNmD8xzKEb6
 iGN6EfKSJRLw5CKuQv4GhAf31ffl82uWXVs7c7fF7zTD8wirC+isfPC7DR9ESCA=
X-Google-Smtp-Source: AGHT+IHIToLEnpdNruYrQBoTyWj2gFK1Cz1QmwFWVv+7gCqdsuJSn9RcpPNSSbr6WOuF0nFrhPsslw==
X-Received: by 2002:a17:907:1b06:b0:a59:9a68:7283 with SMTP id
 mp6-20020a1709071b0600b00a599a687283mr489708ejc.12.1714729214279; 
 Fri, 03 May 2024 02:40:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a170906d29400b00a58aff25d77sm1496488ejb.193.2024.05.03.02.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 02:40:13 -0700 (PDT)
Message-ID: <9747db79-4444-4d31-b014-8c368936cab4@linaro.org>
Date: Fri, 3 May 2024 11:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240312020000.12992-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/3/24 02:59, Salil Mehta wrote:
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
> 
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
> 
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events instead of DPRINTF. No functional change is intended here.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
>   accel/kvm/trace-events |  5 +++-
>   include/sysemu/kvm.h   | 16 +++++++++++
>   3 files changed, 69 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a8cecd040e..3bc3207bda 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
>   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>   
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>   
>   static inline void kvm_resample_fd_remove(int gsi)
>   {
> @@ -314,14 +315,53 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->vcpu_dirty = true;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    return 0;
> +}

This seems generic enough to be implemented for all accelerators.

See AccelOpsClass in include/sysemu/accel-ops.h.

That said, can be done later on top.

