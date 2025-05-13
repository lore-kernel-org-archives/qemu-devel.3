Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434B0C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqUj-0007qv-CT; Tue, 13 May 2025 10:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqUe-0007ms-MX
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqUa-0006Ev-OD
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747146021;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyscc4t3yNl1uSrVJZkh3Y4b61e+bOq9gii8cVcyfdc=;
 b=ZdikAzTahXhYYnth9sL17oyMtKMesOMdl0aONlOJ8DwRGuxi8REPq0ijZAbybdbdiiS+0D
 y0EWdPHdPML79yVdDa35OwVOsC3u7GlnQRC3lYZ8fuYptUz98ADBuzcZtCvvFVk21NNOlo
 lnMUcg/lv//iILJSuh31opMWpoRwtIM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-V5FshCKPPcK0awLcTepTaA-1; Tue, 13 May 2025 10:20:17 -0400
X-MC-Unique: V5FshCKPPcK0awLcTepTaA-1
X-Mimecast-MFC-AGG-ID: V5FshCKPPcK0awLcTepTaA_1747146014
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so23951625e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747146014; x=1747750814;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyscc4t3yNl1uSrVJZkh3Y4b61e+bOq9gii8cVcyfdc=;
 b=r1EF0MMRCIDiwmDgly+WWpkVGSiKB8BKk9DzrSCzv4yweO2jxwl1qtK+BXkBbhpopL
 KwXGqCncgH1+BkRwSoiV33T/3wAL1QbtQqpLAgUGM7l3dqBjUH1jSr56Lr5+xaUuQto/
 GjosfDqEerY2MJr7F39X7WvlQhHZU0lAnvj6qO1TK41b7TnJrFO/YT+e5NxmT6+VbDqS
 pAVjQoDkBYBDbFUmZZubXWXJmWXK/LjCTyYrc//PCpRCJITj01O8a/+Q9QbRJByV81Fr
 ZGKHrWfzz51CAtJh/ipt8cP2gP0tDQM6t1WFuagySj89eO+ZnW2O6URqr+JA45hRVWRm
 xWMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8qO6Jofig4wOf4UStZJQwqgPCNRpoZoSn4m0i1FMCbGQkXA7Qe3Cs9O9cIoxudkXwgElv9zKx3OUc@nongnu.org
X-Gm-Message-State: AOJu0YxcoUqTJjmXSAFYQv1M0/oeK3FhYk6au1axGV3LPYnUUwLEjfkB
 arvEXx2zl3awuK0kt3piRE9ZItryP/byJGhTGGf75n1lBfMaD9fp+KI7nZ9rM2qgkHTCNwXoybK
 ahvgTxMKBKoe8YDkGmShbY/gK/bzfT2GovlTI9PyNgg9et2Xbfi8V
X-Gm-Gg: ASbGncshiJLHEF4yuS0XzqJ81E36g0RY9FrbbdbilLT8dO/Qts9Lp31zjSU1/fJb3O4
 OsLLGGkxaXxNZcP/uGewYtQoKEv1Axd2OSQXx9dMQma66LDik8GuDqgoM8FQ/HFyzbkEtbsqh6L
 24D+ulWV78wEysyiuMWf/vvHs9bWCHn2YUeQ2Q7HjvTghUCBbNg/YAykW4A9kJyizsMQTzC7nCq
 Qlkb+xY/DzN3fKStZ+SIWDFAoC6CQVJiKKJfhWlB/8qzl3f5+XtzL0H4MwLPSgbW/RXUWcYcSrg
 U8L3u7CQAUr11aVq/MNBl0Y3PLHP7gmCbmP4vAz2pHYFye/h4/UOt3W23fk=
X-Received: by 2002:a05:600c:8887:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-442d6d6ac34mr142266745e9.15.1747146013767; 
 Tue, 13 May 2025 07:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJd0Y4ol20KqwlD/xjV97DJlvepa/eAx0yECTHw2Xv6k+BGIX3yLcJJl1tDp+QEbkSi1Nbw==
X-Received: by 2002:a05:600c:8887:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-442d6d6ac34mr142266335e9.15.1747146013344; 
 Tue, 13 May 2025 07:20:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3285f9sm215246655e9.8.2025.05.13.07.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:20:12 -0700 (PDT)
Message-ID: <4f370fae-8234-48ca-97e2-3b7038092974@redhat.com>
Date: Tue, 13 May 2025 16:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] kvm: kvm_get_writable_id_regs
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-5-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-5-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 4/14/25 6:38 PM, Cornelia Huck wrote:
> Add an helper to retrieve the writable id reg bitmask. The
> status of the query is stored in the CPU struct so that an
> an error, if any, can be reported on vcpu realize().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu.h     | 26 ++++++++++++++++++++++++++
>  target/arm/kvm.c     | 32 ++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h |  7 +++++++
>  3 files changed, 65 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d27134f4a025..bbee7ff2414a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -856,6 +856,26 @@ typedef struct {
>      uint32_t map, init, supported;
>  } ARMVQMap;
>  
> +typedef enum ARMIdRegsState {
> +    WRITABLE_ID_REGS_UNKNOWN,
> +    WRITABLE_ID_REGS_NOT_DISCOVERABLE,
> +    WRITABLE_ID_REGS_FAILED,
> +    WRITABLE_ID_REGS_AVAIL,
> +} ARMIdRegsState;
> +
> +/*
> + * The following structures are for the purpose of mapping the output of
> + * KVM_ARM_GET_REG_WRITABLE_MASKS that also may cover id registers we do
> + * not support in QEMU
> + * ID registers in op0==3, op1=={0,1,3}, crn=0, crm=={0-7}, op2=={0-7},
> + * as used by the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl call.
> + */
> +#define NR_ID_REGS (3 * 8 * 8)
We may rename this define to better associate to the KVM API. I tend to
mix it with NUM_ID_IDX now ;-)
maybe something like KVM_NR_EXPOSED_ID_REGS
> +
> +typedef struct IdRegMap {
> +    uint64_t regs[NR_ID_REGS];
> +} IdRegMap;
I would add a comment saying this is the mask array, just to prevent the
reading from thinking it is the actual reg content.
> +
>  /* REG is ID_XXX */
>  #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>      ({                                                                  \
> @@ -1044,6 +1064,12 @@ struct ArchCPU {
>       */
>      bool host_cpu_probe_failed;
>  
> +    /*
> +     * state of writable id regs query used to report an error, if any,
> +     * on KVM custom vcpu model realize
> +     */
> +    ARMIdRegsState writable_id_regs;
maybe rename into writable_id_reg_status that would better reflect what
it is.
> +
>      /* QOM property to indicate we should use the back-compat CNTFRQ default */
>      bool backcompat_cntfrq;
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8491f42a18d2..6e3cd06e9bc5 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -50,6 +50,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>  static bool cap_has_mp_state;
>  static bool cap_has_inject_serror_esr;
>  static bool cap_has_inject_ext_dabt;
> +static int cap_writable_id_regs;
>  
>  /**
>   * ARMHostCPUFeatures: information about the host CPU (identified
> @@ -488,6 +489,37 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      env->features = arm_host_cpu_features.features;
>  }
>  
> +int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
> +{
> +    struct reg_mask_range range = {
> +        .range = 0, /* up to now only a single range is supported */
> +        .addr = (uint64_t)idregmap,
> +    };
> +    int ret;
> +
> +    if (!kvm_enabled()) {
> +        cpu->writable_id_regs = WRITABLE_ID_REGS_NOT_DISCOVERABLE;
> +        return -ENOSYS;
> +    }
> +
> +    cap_writable_id_regs =
> +        kvm_check_extension(kvm_state, KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES);
> +
> +    if (!cap_writable_id_regs ||
> +        !(cap_writable_id_regs & (1 << KVM_ARM_FEATURE_ID_RANGE))) {
> +        cpu->writable_id_regs = WRITABLE_ID_REGS_NOT_DISCOVERABLE;
> +        return -ENOSYS;
> +    }
> +
> +    ret = kvm_vm_ioctl(kvm_state, KVM_ARM_GET_REG_WRITABLE_MASKS, &range);
> +    if (ret) {
> +        cpu->writable_id_regs = WRITABLE_ID_REGS_FAILED;
> +        return ret;
> +     }
> +    cpu->writable_id_regs = WRITABLE_ID_REGS_AVAIL;
> +    return ret;
> +}
> +
>  static bool kvm_no_adjvtime_get(Object *obj, Error **errp)
>  {
>      return !ARM_CPU(obj)->kvm_adjvtime;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 05c3de8cd46e..8d1f20ca8d89 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -221,6 +221,8 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>  
>  void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
>  
> +int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap);
> +
>  #else
>  
>  /*
> @@ -247,6 +249,11 @@ static inline bool kvm_arm_mte_supported(void)
>      return false;
>  }
>  
> +static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
> +{
> +    return -ENOSYS;
> +}
> +
>  /*
>   * These functions should never actually be called without KVM support.
>   */
Cheers

Eric


