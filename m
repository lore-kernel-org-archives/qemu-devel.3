Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A48C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPbE-0007qm-Pu; Tue, 18 Feb 2025 10:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPb9-0007lz-2u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPb7-0001Lv-CV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UCjt3mp7yDvSEsnhqs87k56LFrtYTUCWzATqqG4knA=;
 b=DL2g7cSoa83cutkxLiFEqq1r4YDYUj9nmw4fc9uquHKzuTA9zsuf7kIRuWrH2aUaZ91qFI
 YqDy33m+3/2rRkLzDew5sTUPEHl/OMXt1WPNNGcqritCd/1nLHq4H7phFQ9XTtQ1D8lNrX
 OadBFLDwaO7LPimy3rclGGrv+RfY7cI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-ryy_ojHdN6WWOjtuIR8qmQ-1; Tue, 18 Feb 2025 10:33:17 -0500
X-MC-Unique: ryy_ojHdN6WWOjtuIR8qmQ-1
X-Mimecast-MFC-AGG-ID: ryy_ojHdN6WWOjtuIR8qmQ_1739892797
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f394f6d84so2015500f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892796; x=1740497596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0UCjt3mp7yDvSEsnhqs87k56LFrtYTUCWzATqqG4knA=;
 b=HyBQa830NFzedG6/CXSEkN0OATckbpW8iDj4+L1pSCyHhvBo4C4YiQVahJmjr2999j
 hS4SXDXeQALwpL14Ex5r2YErLB/oOKonYzznA7qWOe2FlEYaPLldZsNMyQdcY+HFCZVX
 OanGll/bUmWD1RmLxu0Z8rjdWic1iszfIc4UxyL/3oZYim0CqZ16S7UZGjtA0+1P0+qD
 apdz4iEP91/ZZpb4mfZCXrWVVCBUBJJ3x43qwG2t+4fy2LYPXF91U5MT8Xi8wgGKD3/D
 OxW0iba1IDC/+xLkmlYxTLpDpnfynAYctrGrdUA7yWGk9OGcPMhPRQrc1lykIQopty+i
 5vhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb52PjNwMcwn3DjoQED0TLB0GaIba+zSGtQzJxF6ERADKF/f8cBRXAlkoE1nLOvH8hEZKaQiwJ9CGT@nongnu.org
X-Gm-Message-State: AOJu0Yy+JhBRGax8KaXLDfYpULMBiVE8oDUhflh7LTmidH0Cf7E/n5ae
 XmxU43nxlluc5GxTi2fP2QymCjgI4Y3hO+BWAyh4oWp0VGaIRXD/QTqbK9+ddL2VL8i8NQVUThA
 HWH68huQsOPS3P3po5lFiCQr1Szkcrz6cmSySx2/niBfpwGz9DOpW
X-Gm-Gg: ASbGnct6t6TEnEuF3mWrHGWLiUfhkYXDG5yf8Iz36V9ROC9AEh73/lRdmt3JQcy4ZqO
 dG0ojemkLYokkha8IUzqvpfkR+nWIAA6qOi39NtkUcStNHub7nmGYkCXk0yKIQdo6zACikndHpI
 F00ooBeSYbHZBTX8wENKmPWVlMp47uD3ghX7RUO+hSRaHBicDOC/0t0XRwnIdEv2xqtLRzNqvc1
 JEUdqwar0eeggEdNpXL4sgbngunnt4ri/mIkcGaMWHtmnJUq60h8VOe5bPnvu7Nnpb7fUcrmWuO
 o9LTCAi9/1qQgrt+ou13xnMPbnH0zBAabRN1BrVECuVVxFpguZqI
X-Received: by 2002:adf:e80a:0:b0:38f:2230:c0ff with SMTP id
 ffacd0b85a97d-38f33f4ea6dmr10548880f8f.30.1739892796521; 
 Tue, 18 Feb 2025 07:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzkUCXr2JJcUxJNQuE/eRCZ66ignXp/RWQWbK2xa7+TiL33a+A9YN3MmY2SKlj/Tq3XxIkyA==
X-Received: by 2002:adf:e80a:0:b0:38f:2230:c0ff with SMTP id
 ffacd0b85a97d-38f33f4ea6dmr10548858f8f.30.1739892796174; 
 Tue, 18 Feb 2025 07:33:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5c36sm15486329f8f.67.2025.02.18.07.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:33:15 -0800 (PST)
Message-ID: <b1a2e796-b2f5-4acc-9d6d-e85d99d67a0d@redhat.com>
Date: Tue, 18 Feb 2025 16:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] arm/kvm: add accessors for storing host features
 into idregs
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-3-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250207110248.1580465-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


Hi Connie

On 2/7/25 12:02 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-sysregs.h |  3 +++
>  target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
>  target/arm/kvm.c         | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index de09ebae91a5..54a4fadbf0c1 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -128,4 +128,7 @@ static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>      [CTR_EL0_IDX] = SYS_CTR_EL0,
>  };
>  
> +int get_sysreg_idx(ARMSysRegs sysreg);
> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
> +
>  #endif /* ARM_CPU_SYSREGS_H */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8188ede5cc8a..9ae78253cb34 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -736,6 +736,31 @@ static void aarch64_a53_initfn(Object *obj)
>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>  }
>  
> +#ifdef CONFIG_KVM
> +
> +int get_sysreg_idx(ARMSysRegs sysreg)
> +{
> +    int i;
> +
> +    for (i = 0; i < NUM_ID_IDX; i++) {
> +        if (id_register_sysreg[i] == sysreg) {
I agree with Richard that if we could get rid of this linear search it
would be nicer.
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
> +{
> +    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
> +}
> +
> +#endif
> +
>  static void aarch64_host_initfn(Object *obj)
>  {
>  #if defined(CONFIG_KVM)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..3b8bb5661f2b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -246,6 +246,36 @@ static bool kvm_arm_pauth_supported(void)
>              kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
>  }
>  
> +/* read a 32b sysreg value and store it in the idregs */
> +static int get_host_cpu_reg32(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
those are defined as static but there is no user so this will break
compilation locally

Eric
> +{
> +    int index = get_sysreg_idx(sysreg);
> +    uint64_t *reg;
> +    int ret;
> +
> +    if (index < 0) {
> +        return -ERANGE;
> +    }
> +    reg = &ahcf->isar.idregs[index];
> +    ret = read_sys_reg32(fd, (uint32_t *)reg, idregs_sysreg_to_kvm_reg(sysreg));
> +    return ret;
> +}
> +
> +/* read a 64b sysreg value and store it in the idregs */
> +static int get_host_cpu_reg64(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
> +{
> +    int index = get_sysreg_idx(sysreg);
> +    uint64_t *reg;
> +    int ret;
> +
> +    if (index < 0) {
> +        return -ERANGE;
> +    }
> +    reg = &ahcf->isar.idregs[index];
> +    ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
> +    return ret;
> +}
> +
>  static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  {
>      /* Identify the feature bits corresponding to the host CPU, and


