Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6BAD41C07
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 06:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB6rn-00084c-OU; Wed, 13 Nov 2024 01:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tB6ri-000845-VP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 01:28:37 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tB6rh-000885-9K
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 01:28:34 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2feeb1e8edfso84381051fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731479310; x=1732084110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MydHF9t/w/ct/1EMVG3dItdPgKvgvLeI/8cIryhFm4=;
 b=UBoxHPwVkRW5d+/nkXWdECQfq9YdvSOnGtlMdogLTwDHGbhbu0lqfDr8W7loWnr8cE
 gBnDLYAjgbq8bOF5rUmVDKrJ7np0DvVI47YeRs3cwiK8ceqCv/h/LaDB1UAav7zPVZyD
 yrpESBzQtQcjxL3/26KgUMnvg82KaT2Hy+XTtx/oliWZ/tJWawKVmR9sAcxvdS2+jgqy
 OhH0EDznuHAsFC74eZq36p3TibMgj+N+hLwVDKY4w5V3jY4GozNTQh91Ib2hUjxW2BE4
 Nlw62/p84y3k2UKqRHW0LDK1a7KjxqVZLNyZht2cg2adQ4A7hLrLreWhP6Tjum+qjeJG
 IpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731479310; x=1732084110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MydHF9t/w/ct/1EMVG3dItdPgKvgvLeI/8cIryhFm4=;
 b=mCJZpabSbdj6malB8ZoNgXrix9mLdO/hAm3wq/RO7dSnNSa8rIcOU8tNjxx+748DS7
 KMJNOlouwQInom212wai+3EEjOv6OxbGpLO6swVce4yQTDx9RLB/e7YRDqXtFXVT/EJr
 4Yco1UX36oV0U5Yi8nAgSa+pdbNzl4IOXMvFVK/HADsuT47ogvqZHrfTgtfEWv5pIfuB
 Wet7UV3lHUoQjv/6cGYhddEReFUj4hXV57dB7La60cgruJf03cTu+HoeEEdXfVtDN0Ta
 iC2VpyGLzh158uPMX9ECCyAi7YJmGrY98xcr/m8zmiyFAsBGDZriYfC62gLV60318PcT
 rDSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiImhZnY7iAzuZcCvSHTG7YO0iq8IrpwYqs8UE5OrtfKV2gy6t/XGJIJ/SkXfFhLG0MvxFlNkP5A5I@nongnu.org
X-Gm-Message-State: AOJu0Yx7pY8qk3dLtTaCC4CQnIdBpQhO7RWQ6sFudLcIWxTzdv7e7iM4
 cFvxJysvnnki8TubN2vCDswQmzBAN+EhODsuaqb2qiRI7ayZxofGEom98SEZD5o=
X-Google-Smtp-Source: AGHT+IGKzyDVFYR5ZYN3HiQLZfu0/jwK8IkxuMCc19BP0lOmLqZNHBgQkW5X9nnsF64mV94mzsXOqQ==
X-Received: by 2002:a2e:a551:0:b0:2fa:cdac:8732 with SMTP id
 38308e7fff4ca-2ff2028ad8fmr133177161fa.30.1731479310254; 
 Tue, 12 Nov 2024 22:28:30 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr.
 [176.184.27.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b64sm816138766b.39.2024.11.12.22.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 22:28:29 -0800 (PST)
Message-ID: <fbe5da1d-9a0e-4aa4-91f9-dfb729f39dc9@linaro.org>
Date: Wed, 13 Nov 2024 07:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/60] kvm: Introduce kvm_arch_pre_create_vcpu()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-8-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241105062408.3533704-8-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Hi,

On 5/11/24 06:23, Xiaoyao Li wrote:
> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
> work prior to create any vcpu. This is for i386 TDX because it needs
> call TDX_INIT_VM before creating any vcpu.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v3:
> - pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
> ---
>   accel/kvm/kvm-all.c  | 10 ++++++++++
>   include/sysemu/kvm.h |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 930a5bfed58f..1732fa1adecd 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -523,6 +523,11 @@ void kvm_destroy_vcpu(CPUState *cpu)
>       }
>   }
>   
> +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)

We don't use the weak attribute. Maybe declare stubs for each arch?

> +{
> +    return 0;
> +}
> +
>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   {
>       KVMState *s = kvm_state;
> @@ -531,6 +536,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
> +    ret = kvm_arch_pre_create_vcpu(cpu, errp);
> +    if (ret < 0) {
> +        goto err;
> +    }
> +
>       ret = kvm_create_vcpu(cpu);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret,
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index c3a60b28909a..643ca4950543 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -374,6 +374,7 @@ int kvm_arch_get_default_type(MachineState *ms);
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s);
>   
> +int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>   int kvm_arch_init_vcpu(CPUState *cpu);
>   int kvm_arch_destroy_vcpu(CPUState *cpu);
>   


