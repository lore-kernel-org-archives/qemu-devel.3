Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9F7C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8bv-0004Af-9B; Thu, 06 Mar 2025 05:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8bs-0004AA-NR
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:37:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8bn-0000PF-Dg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:37:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso2743795e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741257461; x=1741862261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cnmNlNqWUiYotLjRx0btPSV2jHI6AFnF6iMz5rPyZ2A=;
 b=m+H0oGxm8uyJ4NT0yz/iIar5rWtQT1r6rHPKVXtj16vPR0Wwj9ADnbizi82Kggoulx
 fQyZRgmOBAA19EquTPenrcNfjk3BjlKMjE6Q5gQ9FLaZeDAqWk2JJt3EazbgZUUol24m
 gddxnT/adO0Zj1D6MdBAbwayHQooWEyYcj8hwBvwFlQRjbdw1wHH3sOk58j5/tZUJchU
 8RvFFfYoHLpx02e7KmZfLgO2wsmm1yXoZIoyrRVVO4atQCmkNldfU07CNXUnl1EmSX6/
 D9BpYebDAU/FmoWPSyQyZFO6OOKP3cgxFMOvmSyNnbfQZD173AbQ0LMC/l3vEFUAD2mb
 knxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741257461; x=1741862261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cnmNlNqWUiYotLjRx0btPSV2jHI6AFnF6iMz5rPyZ2A=;
 b=jLOrxv3aNJhRUi63GvqUuxsjcN5eI8Ic2BpJoeUEDls+DvfmTUx8fqnAk9E8d1AZtJ
 P++7QRjRYVpETh98ZX8ePyg0G2VhtMqTe0b8ZKE8ovR0AFvkejmwwRPaGoAiUXuFZYkO
 NCfyBJRYlC6QLbcESyMoJEumaIixLQE1i3RC6R6Slci5VZ8OL+URb0Ls5J1dtgNUSZVz
 TLhss8V2CndvffURzOXsv4L5vpjXqBTwmRH8LJjcTYrqQalcDKGSrZ/f6tc0IXZVaXDZ
 pCQh5h9U5IGnaPXdSlXtFhYaH9wC0Liz2/wWuiMB2e9JRORdXANMOKB29F4mV+0lOGsJ
 R6NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgx/W1Bj+KAvIt2+OcDNXqJLeLlmvzo9gCnmulzpS5tZl6hpEJqXyRmrOWDkCE5bGI+Z3aDw3lnGsC@nongnu.org
X-Gm-Message-State: AOJu0Yyy646qhYeKE4O1Y8CMksuIcEnMFc9V1Dp76MSZvVokXo/AGtwc
 jBMI0O6oL7iqFPp7964IGwTidhqbvufiYaaU1wBhKDVPdq0g4fBW6USrG9MEKPo=
X-Gm-Gg: ASbGncvLKhKU4kp/HQHfRb6nctWf9l9PTmNWb5CEV4RKzlcx8XGFhkuAua1xTO6cNRZ
 npYxgPMVHWLDuaaHhwZSkW9OpaCKYgN2D2mDUHepNAPBoHEusgkH4PxBawuZm+wESTSyXiBC4Fr
 VbxWGnbCswYIQVT4LAp1JRJMaNRoTRwoq/qptTDutj9dFtCn793TLmjqRi9NmwPZbViMVr7vU4E
 Faqjtq9Uz25MNBy9Ru3o0ZSLQtysJLNRfkz8uUc9xW7vjoe7/fjt0u6NXcZ4Jxt1rpl/eZs8v1G
 N0Fv6EVHU5AYVjs0ESpY1+KE8dg+FzX6XxBeNqoI7RLMoiWnu0FKdUL84EubKJQQLG2PLNVyOgh
 Ldl9TOTF2b14f
X-Google-Smtp-Source: AGHT+IGNXVK1QhDHo/kNBIIeGlO7DFsE4gAoebSrHG+W2B+Sbcao7NMfHhDrIWM4v/GpGoSbo0keMA==
X-Received: by 2002:a05:600c:4f0f:b0:43b:c390:b78d with SMTP id
 5b1f17b1804b1-43bd2aed6d8mr47714195e9.24.1741257460622; 
 Thu, 06 Mar 2025 02:37:40 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm15398605e9.37.2025.03.06.02.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 02:37:39 -0800 (PST)
Message-ID: <4dc45084-fb9d-4fed-88b0-18b0034c8c74@linaro.org>
Date: Thu, 6 Mar 2025 11:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] cpu: Introduce cpu_get_phys_bits()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-8-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/1/25 14:43, Cédric Le Goater wrote:
> The Intel CPU has a complex history regarding setting of the physical
> address space width on KVM. A 'phys_bits' field and a "phys-bits"
> property were added by commit af45907a1328 ("target-i386: Allow
> physical address bits to be set") to tune this value.
> 
> In certain circumstances, it is interesting to know this value to
> check that all the conditions are met for optimal operation. For
> instance, when the system has a 39-bit IOMMU address space width and a
> larger CPU physical address space, we expect issues when mapping the
> MMIO regions of passthrough devices and it would good to report to the
> user. These hybrid HW configs can be found on some consumer grade
> processors or when using a vIOMMU device with default settings.
> 
> For this purpose, add an helper routine and a CPUClass callback to
> return the physical address space width of a CPU.
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/core/cpu.h            |  9 +++++++++
>   include/hw/core/sysemu-cpu-ops.h |  6 ++++++
>   cpu-target.c                     |  5 +++++
>   hw/core/cpu-system.c             | 11 +++++++++++
>   target/i386/cpu.c                |  6 ++++++
>   5 files changed, 37 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fb397cdfc53d12d40d3e4e7f86251fc31c48b9f6..1b3eead102ce62fcee55ab0ed5e0dff327fa2fc5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -748,6 +748,14 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
>    */
>   bool cpu_virtio_is_big_endian(CPUState *cpu);
>   
> +/**
> + * cpu_get_phys_bits:
> + * @cpu: CPU
> + *
> + * Return the physical address space width of the CPU @cpu.
> + */
> +uint32_t cpu_get_phys_bits(const CPUState *cpu);
> +
>   #endif /* CONFIG_USER_ONLY */
>   
>   /**
> @@ -1168,6 +1176,7 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>   void cpu_exec_reset_hold(CPUState *cpu);
>   
>   const char *target_name(void);
> +uint32_t target_phys_bits(void);
>   
>   #ifdef COMPILING_PER_TARGET
>   
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 0df5b058f50073e47d2a6b8286be5204776520d2..210b3ed57985525795b81559e41e0085969210d5 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -81,6 +81,12 @@ typedef struct SysemuCPUOps {
>        */
>       bool (*virtio_is_big_endian)(CPUState *cpu);
>   
> +    /**
> +     * @get_phys_bits: Callback to return the physical address space
> +     * width of a CPU.
> +     */
> +    uint32_t (*get_phys_bits)(const CPUState *cpu);
> +
>       /**
>        * @legacy_vmsd: Legacy state for migration.
>        *               Do not use in new targets, use #DeviceClass::vmsd instead.
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c929aa53782c94343def34571272d5f..88158272c06cc42424d435b9701e33735f080239 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -472,3 +472,8 @@ const char *target_name(void)
>   {
>       return TARGET_NAME;
>   }
> +
> +uint32_t target_phys_bits(void)
> +{
> +    return TARGET_PHYS_ADDR_SPACE_BITS;
> +}
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index 6aae28a349a7a377d010ff9dcab5ebc29e1126ca..05067d84f4258facf4252216f17729e390d38eae 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -60,6 +60,17 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>       return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>   }
>   
> +uint32_t cpu_get_phys_bits(const CPUState *cpu)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +
> +    if (cc->sysemu_ops->get_phys_bits) {
> +        return cc->sysemu_ops->get_phys_bits(cpu);
> +    }
> +
> +    return target_phys_bits();

I might have suggested to return TARGET_PHYS_ADDR_SPACE_BITS
by default in v1, I'm not sure about it anymore. Maybe default
to 0 and have each target register its helper if necessary?

> +}
> +
>   hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
>   {
>       MemTxAttrs attrs = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5dd60d2812e0c3d13c1743fd485a9068ab29c4f..01cf9a44963710a415c755c17582730f75233143 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8393,6 +8393,11 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
>   
>       return cpu->env.cr[0] & CR0_PG_MASK;
>   }
> +
> +static uint32_t x86_cpu_get_phys_bits(const CPUState *cs)
> +{
> +    return X86_CPU(cs)->phys_bits;
> +}
>   #endif /* !CONFIG_USER_ONLY */
>   
>   static void x86_cpu_set_pc(CPUState *cs, vaddr value)
> @@ -8701,6 +8706,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
>       .get_memory_mapping = x86_cpu_get_memory_mapping,
>       .get_paging_enabled = x86_cpu_get_paging_enabled,
>       .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
> +    .get_phys_bits = x86_cpu_get_phys_bits,
>       .asidx_from_attrs = x86_asidx_from_attrs,
>       .get_crash_info = x86_cpu_get_crash_info,
>       .write_elf32_note = x86_cpu_write_elf32_note,


