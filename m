Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E7BCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGWZ-00075E-C5; Thu, 18 Sep 2025 11:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uzGWW-0006v1-1u
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uzGWS-00038U-Ll
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209171;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60bh1/8KDe5Bli2xGeThDg2WbIb0AYpA+zhbjhLgDGc=;
 b=WzfGcXuGuUfkFOtpWHbSwPSRikC0U0ICxz0tLXu6pwq76JIaXsCF7kTlVywT2nuDnrG8Ma
 EOEd32HZ1uOOWV8pGodRHY9vrwyG0bh4jCo0OsdYXqq2dvJdRPgFjU9YXw9kX3Xc+fdNsU
 KT3VgMvB+4x0SZALovGTrCYHA1Xhzik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-llocCH6IMWqN0JdRidp6nQ-1; Thu, 18 Sep 2025 11:26:10 -0400
X-MC-Unique: llocCH6IMWqN0JdRidp6nQ-1
X-Mimecast-MFC-AGG-ID: llocCH6IMWqN0JdRidp6nQ_1758209169
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2c1556aeso4199165e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209169; x=1758813969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60bh1/8KDe5Bli2xGeThDg2WbIb0AYpA+zhbjhLgDGc=;
 b=YvR7kKFxCyDhcQIwNFlbr5AxXJ4caXRu37CtRZApGm2QkjdQjivA5/+ioAsKB5grZk
 OD1xC/Uz6/WD8PvqPEI7QRF0HI7S0/zwrpIxDSbYiAQaG3Wm/WMmjzUd7AkaPu2ZouGw
 IEhJj+Cbp9RcN+dop/1Mg/HfcP5RYnD8/KNJnQ/VZ+O9HSQNY6QwIVf3HbCm6i378ox6
 4vMTQOrTduTQ4fxdxnrUpvWm+7phi9QaNkniBSbJqaF1o3WF00Ua5e8YkvKVR6fdVwjO
 fA+Td2NSgUOVFNHfG5ocrwrPpWM5iAjoGJQPBNLd2M5jnMTLehj/LfWD0PGI2fZAgeuX
 IKvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1aWioSTxbumlfwC5jW6qJlQqlC0NCsyWkPMRsMv6HwMp8LTS1yFdIcsJ6WYNELrjYkVTzkpS1ZcZG@nongnu.org
X-Gm-Message-State: AOJu0YxPe7mJWZ86EP6NKoBcSiFxJxdeaXUb8STCoeDrPIlMYaN6nPbQ
 Wk1zZhEYINTa/xORVboelSgywlPPQ3igT4kJfbFzFEoYK7l1/cKn6qKw+gr+B7lTwpUIERcCMc7
 oXKdb8TG2f5MFK9AhiRl9eSVRA49M2FrhcPIqnfFizae8OFW5B+WAPVat
X-Gm-Gg: ASbGncvENalAAaGiZSv1m23O36BbrxWJyPhG99SEhfWEMWwNqZgkCSq+hN4O8kPC60t
 KR3HqdgvJWH7AtO5GTsCj2ngKSIUBkZch3kaBVmLq6jWVkv9iulVuyBQpWbYDugtxuDEBeHFLxV
 4pTHuylPNpiYChMuOfjXKV7f0nc2hVjeNixSQutiUu/UbU9UZCcNBiHZ2PlZ+MF3QxW+Tztee+N
 wNhWZLbHfGbjf+N4bRJa82nYJfvNYRt1EkrWRN5ZNci++5FawEH28cHm2LIhpyQugUoN4WH6rS/
 6LXpyn7+8GtLSmM8c2G0iPM0U9N6ohry+hWq2lB0Vtu6NtKcEMYt/14cY/DQmUtJXRqGB6+iUmL
 hozG0ugOFMQY=
X-Received: by 2002:a05:600c:4eca:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-4634c528acamr48192815e9.36.1758209168696; 
 Thu, 18 Sep 2025 08:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEtQw7Ad4RC9Ve+flPRrpO5OIZ1reWlCMCoXq69hJMRKQIk5PW42Rnui+NeQkSFExCkaGLOA==
X-Received: by 2002:a05:600c:4eca:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-4634c528acamr48192565e9.36.1758209168259; 
 Thu, 18 Sep 2025 08:26:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f5d053f2sm46067075e9.20.2025.09.18.08.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 08:26:07 -0700 (PDT)
Message-ID: <22caf6ef-e1ba-4465-b587-baffb3ce4618@redhat.com>
Date: Thu, 18 Sep 2025 17:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250911144923.24259-1-sebott@redhat.com>
 <20250911144923.24259-3-sebott@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250911144923.24259-3-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sebastian,

On 9/11/25 4:49 PM, Sebastian Ott wrote:
> Provide a kvm specific vcpu property to override the default
> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst |  5 +++
>  target/arm/cpu.h                 |  6 +++
>  target/arm/kvm.c                 | 70 +++++++++++++++++++++++++++++++-
>  3 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 37d5dfd15b..1d32ce0fee 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -204,6 +204,11 @@ the list of KVM VCPU features and their descriptions.
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>  
> +``kvm-psci-version``
> +  Override the default (as of kernel v6.13 that would be PSCI v1.3)
> +  PSCI version emulated by the kernel. Current valid values are:
> +  0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
> +
>  TCG VCPU Features
>  =================
>  
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c15d79a106..44292aab32 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -974,6 +974,12 @@ struct ArchCPU {
>       */
>      uint32_t psci_version;
>  
> +    /*
> +     * Intermediate value used during property parsing.
> +     * Once finalized, the value should be read from psci_version.
> +     */
> +    uint32_t prop_psci_version;
> +
>      /* Current power state, access guarded by BQL */
>      ARMPSCIState power_state;
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6672344855..bc6073f395 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -483,6 +483,59 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>  
> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    const char *val;
> +
> +    switch (cpu->prop_psci_version) {
> +    case QEMU_PSCI_VERSION_0_1:
> +        val = "0.1";
> +        break;
> +    case QEMU_PSCI_VERSION_0_2:
> +        val = "0.2";
> +        break;
> +    case QEMU_PSCI_VERSION_1_0:
> +        val = "1.0";
> +        break;
> +    case QEMU_PSCI_VERSION_1_1:
> +        val = "1.1";
> +        break;
> +    case QEMU_PSCI_VERSION_1_2:
> +        val = "1.2";
> +        break;
> +    case QEMU_PSCI_VERSION_1_3:
> +        val = "1.3";
> +        break;
> +    default:
> +        val = "0.2";
can you explain why you return 0.2 by default? Shouldn't we report the
default value exposed by KVM?
> +        break;
> +    }
> +    return g_strdup(val);
> +}
> +
> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (!strcmp(value, "0.1")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_1;
> +    } else if (!strcmp(value, "0.2")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_2;
> +    } else if (!strcmp(value, "1.0")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_0;
> +    } else if (!strcmp(value, "1.1")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_1;
> +    } else if (!strcmp(value, "1.2")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_2;
> +    } else if (!strcmp(value, "1.3")) {
> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_3;
> +    } else {
> +        error_setg(errp, "Invalid PSCI-version value");
> +        error_append_hint(errp, "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3\n");
> +    }
> +}
> +
>  /* KVM VCPU properties should be prefixed with "kvm-". */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>  {
> @@ -504,6 +557,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>                               kvm_steal_time_set);
>      object_property_set_description(obj, "kvm-steal-time",
>                                      "Set off to disable KVM steal time.");
> +
> +    object_property_add_str(obj, "kvm-psci-version", kvm_get_psci_version,
> +                            kvm_set_psci_version);
> +    object_property_set_description(obj, "kvm-psci-version",
> +                                    "Set PSCI version. "
> +                                    "Valid values are 0.1, 0.2, 1.0, 1.1, 1.2, 1.3");
>  }
>  
>  bool kvm_arm_pmu_supported(void)
> @@ -1883,7 +1942,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
> -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
> +    if (cpu->prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
> +        kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
I don't get why this change is needed. Please can you explain?


>          cpu->psci_version = QEMU_PSCI_VERSION_0_2;
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
>      }
> @@ -1922,6 +1982,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
>  
> +    if (cpu->prop_psci_version) {
> +        psciver = cpu->prop_psci_version;
> +        ret = kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
> +        if (ret) {
> +            error_report("PSCI version %lx is not supported by KVM", psciver);
don't you need a PRIx64 here?
> +            return ret;
> +        }
> +    }
>      /*
>       * KVM reports the exact PSCI version it is implementing via a
>       * special sysreg. If it is present, use its contents to determine
Thanks

Eric


