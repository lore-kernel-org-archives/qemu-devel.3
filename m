Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94989C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMRX-0006MO-Jb; Fri, 09 Aug 2024 06:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scMRO-0005ou-Lv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scMRM-0004CC-2P
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723197703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqTlc/7r7TFzilI+jp6vUYVKeFD/MTyOpFCRYa4eILk=;
 b=WGg48PuGHyjfpuyxDWX+TtzecO5ld4aj4J17Qu4lIdNwlG0q8PFPGmjEo7kP+qVvIz/Nn5
 jAJsRvfr6Rqeq+Fsr9dK92DLyeUXf9lcheoDYuRxsp3G/vR8qW/wCFWXjJpb80PA26eAgb
 pctUUmMZp8uvS+ws1QpfpvS8xFQvld4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-QlE7q9yjPPWN5eoDUt0gAw-1; Fri, 09 Aug 2024 06:01:42 -0400
X-MC-Unique: QlE7q9yjPPWN5eoDUt0gAw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1fd9a0efe4eso18582785ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723197701; x=1723802501;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bqTlc/7r7TFzilI+jp6vUYVKeFD/MTyOpFCRYa4eILk=;
 b=cNxAkg8cCZYd6HoQB4Eh4/Poh6qM0EOGdWpBIQoeW3iAtTADqU/I1eOTmKN4G5nFpb
 AsbvpeiVg4vB2jPAZfzpVBKhUwBCaxW0HEMKr32JKCbD4php2YDto7badHKHOXIrHv9o
 fH5Eg6MawAOqg8l7uI3BSQXUiRqHjWfpHtw3Fwl77KcjuVYXyBPRO5RvizAbMVoI3UF7
 nEdqbEV2f4XDjCjRXJufZbtXcYJf5ElL6xerfkXR/wDIpDQn+rizzI8CdnqcuEeqUnSU
 LMv0AMbWD652AfC96VKgWSKHH5CrRnsGiND+wsJyG2A/Qsfictp7z0fwew4SAguVYy1s
 kgJQ==
X-Gm-Message-State: AOJu0YzeAnq7oU3tBVkhyexOMT1LmOCP/CguS9UOfq3B5QJeTocjdm8l
 pxYzUQnVgfDeFKWbik5cuuIJEhHYFVVQZbbUL4zimTqX35TwdtzKSXoRozWMjlHFTnsTnQr+Gyw
 ldO3cEN5jXcgbBXTMblkRvL2uuFOd2jl62zRsJ4m8rt2zVbxKMBFi
X-Received: by 2002:a17:902:f54b:b0:1fd:9e6e:7c10 with SMTP id
 d9443c01a7336-200ae5e68e8mr7183925ad.41.1723197699432; 
 Fri, 09 Aug 2024 03:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2hB8GYN0XlXSK5TgfHvKqJke54YCX2bu8TA3cq65G9v4x5wm/v83KMCc5S4TfPeYif8gNiA==
X-Received: by 2002:a17:902:f54b:b0:1fd:9e6e:7c10 with SMTP id
 d9443c01a7336-200ae5e68e8mr7183435ad.41.1723197698254; 
 Fri, 09 Aug 2024 03:01:38 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f21723sm138749415ad.15.2024.08.09.03.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 03:01:37 -0700 (PDT)
Message-ID: <d75a3435-6ab4-47c2-aee5-71dc4f877639@redhat.com>
Date: Fri, 9 Aug 2024 20:01:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm/virt: Use kvm_arch_get_default_type()
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-4-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20240809035134.699830-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/9/24 1:51 PM, Gavin Shan wrote:
> kvm_arch_get_default_type() and kvm_arm_get_max_vm_ipa_size() are
> interchangeable since the type is equivalent to IPA size (bits)
> with one exception that IPA size (bits) is 40 when the type is zero.
> 
> Replace kvm_arm_get_max_vm_ipa_size() with kvm_arch_get_default_type().
> After this, kvm_arm_get_max_vm_ipa_size() needn't to be a public API
> any more.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/arm/virt.c        | 14 ++++++--------
>   target/arm/kvm.c     |  2 +-
>   target/arm/kvm_arm.h | 15 ---------------
>   3 files changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 09b7a158a9..f35857aa95 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2995,10 +2995,12 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>   static int virt_kvm_type(MachineState *ms, const char *type_str)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(ms);
> -    int max_vm_pa_size, requested_pa_size;
> +    int type, max_vm_pa_size, requested_pa_size;
>       bool fixed_ipa;
>   
> -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> +    /* The IPA size is 40 bits when the type is zero */
> +    type = kvm_arch_get_default_type(ms);
> +    max_vm_pa_size = (type == 0) ? 40 : type;
>   
>       /* we freeze the memory map to compute the highest gpa */
>       virt_set_memmap(vms, max_vm_pa_size);
> @@ -3017,12 +3019,8 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>                        requested_pa_size, max_vm_pa_size);
>           return -1;
>       }
> -    /*
> -     * We return the requested PA log size, unless KVM only supports
> -     * the implicit legacy 40b IPA setting, in which case the kvm_type
> -     * must be 0.
> -     */
> -    return fixed_ipa ? 0 : requested_pa_size;
> +
> +    return type;
>   }
>   #endif /* CONFIG_KVM */
>   

This actually needs to be something like below. It's incorrect to ignore
@requested_pa_size here.

         return (type == 0) ? 0 : requested_pa_size;

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 849e2e21b3..65893c9c12 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -526,7 +526,7 @@ bool kvm_arm_pmu_supported(void)
>       return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
>   }
>   
> -int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
> +static int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
>   {
>       KVMState *s = KVM_STATE(ms->accelerator);
>       int ret;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cfaa0d9bc7..fd919d4738 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -188,16 +188,6 @@ bool kvm_arm_pmu_supported(void);
>    */
>   bool kvm_arm_sve_supported(void);
>   
> -/**
> - * kvm_arm_get_max_vm_ipa_size:
> - * @ms: Machine state handle
> - * @fixed_ipa: True when the IPA limit is fixed at 40. This is the case
> - * for legacy KVM.
> - *
> - * Returns the number of bits in the IPA address space supported by KVM
> - */
> -int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
> -
>   int kvm_arm_vgic_probe(void);
>   
>   void kvm_arm_pmu_init(ARMCPU *cpu);
> @@ -248,11 +238,6 @@ static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>       g_assert_not_reached();
>   }
>   
> -static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
> -{
> -    g_assert_not_reached();
> -}
> -
>   static inline int kvm_arm_vgic_probe(void)
>   {
>       g_assert_not_reached();

Thanks,
Gavin


