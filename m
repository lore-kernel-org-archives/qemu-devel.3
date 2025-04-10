Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE2C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rJC-0000Hx-Mf; Thu, 10 Apr 2025 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2rIy-0000GZ-Oh
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:46:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2rIw-0003AP-JO
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:46:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso8606785e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744289209; x=1744894009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZXIo1fhTP6w3XfC9tv2GhzcTe3ZMQskxjXxbZzFahQ=;
 b=X0/a1+ccF4lulBF9SNOocfhp5sp0L2ojq49B6/XA9PcvFm/csWnRRY0zNETOGbergK
 MeESIkls7Ugox2NDnGATvsbj4XJ9ePcZ10PBHoXZ/rIFgB1LRA7EtkMZYox6e4PP/PHS
 26B2sgm7ejpSeB0R83ye5AJYT6uSeorHV01HKYoxHaUt7kE5I22z6ERnFmIocjGLCPAs
 MxpT8Ddg7Jo7uNOm+0tWHHXliHY0sm9sI7YCpF7M2s8osG7kWlGMZ30P7sRIsiNxU/8H
 6nJvtCP2Zume73Sl4l2Kkpd7sSKb/U9Vt9AjbJKF+X5F4BPFq7gKJBv5rUdZAjK0gxVP
 CzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289209; x=1744894009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZXIo1fhTP6w3XfC9tv2GhzcTe3ZMQskxjXxbZzFahQ=;
 b=c4sirdgoq3MdkpxTUfM0j4hLBCNibMCVErMR7qeUrrx3/OJi2JWBVtRB2PK9lCLoT0
 Wg1/px4b90Myv9s4R4Vhy5JtR2PQA+ECF0ABQ414uYIqwuD6ovhlE0w0U8duyMCO/4gI
 126xEL9Wtd1QeTmukBbWmtqcjq49SVnFSNOIqknaPDspl6/CY/I1y1RIwja18J2CM0CI
 mhIBawqEvrH8dyao22sAucER24SROC+vlUJjLcfe2hNVGsR7tsE/Tys/2zV0M5PnWi84
 CpNvsjyFoCm14bi/5Ic48xB8svVX18DE1YzskMWWffmnnAzmuBQDHcrCwu3s+w0WmLEh
 pyag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSHhBzl0wv/9kwthu1tCVzabxZhlE+mJRSoIW2qhqPvcMz0I1gjBftmqvS1fcCfDdP99Ctr6YXjW3S@nongnu.org
X-Gm-Message-State: AOJu0YwG7WU1rPOeKZqdiVQ0f06cOuM6rmcGQBZdlgNWyMNIzks1df1C
 XZfE3jYFJdi1+IeOaulQHDnNgyS3k5ZS3FJaHaZnfAaopFOd6FCU6xq4oTWIXCI=
X-Gm-Gg: ASbGncuZJ8YnHqBsyObPV3D7GbcpcnVAS6nJJckiMwxobLr/ah1kyUEwzh2uvD8j2BD
 2NWRyDHQXPolaB5erSXhMsISV/opt4afAv9mh1K/bjJU9HgJDhS/08GoQ/EQnOXytHjDKRmL/Vk
 eFvZWUCjxNF27t4R+MVpWgg8ul0T3XXplko1o2S+lRJXStbkyl7xL8m3UaIZFyZ+ukv6c2N0SpQ
 SycJk1jHe3RE0z4yjWjwlhKywBPER0SwKU08Wx7NcWWffYIjVZFudmm2QMbPIKaTRM5fVHwaSuB
 rTA4sHkJC5bJm6hnglP2wmysSW5DbO6NOG3NJ7cR/FcFJwK8uIktTiaGk8Mis6+JBeQiYmTJYzD
 kMhKqsFyE+6Rq7g==
X-Google-Smtp-Source: AGHT+IFYkPxS+JwgVWraoLI7bmEmqc5FQIN4eQ5rt5c/GcOIXBPGzwbqDNoNGdpm/+fgPK1Kb+38eA==
X-Received: by 2002:a05:600c:258:b0:43d:fa59:bced with SMTP id
 5b1f17b1804b1-43f3611175fmr2845515e9.32.1744289208772; 
 Thu, 10 Apr 2025 05:46:48 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2075fc83sm55219905e9.26.2025.04.10.05.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 05:46:48 -0700 (PDT)
Message-ID: <5393ff40-0e1f-4f3e-8379-8b2208301c70@linaro.org>
Date: Thu, 10 Apr 2025 14:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/spapr_hcall: Return host mitigation
 characteristics in KVM mode
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, pbonzini@redhat.com,
 vaibhav@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250410104354.308714-1-gautam@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410104354.308714-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Gautam,

On 10/4/25 12:43, Gautam Menghani wrote:
> Currently, on a P10 KVM guest, the mitigations seen in the output of
> "lscpu" command are different from the host. The reason for this
> behaviour is that when the KVM guest makes the "h_get_cpu_characteristics"
> hcall, QEMU does not consider the data it received from the host via the
> KVM_PPC_GET_CPU_CHAR ioctl, and just uses the values present in
> spapr->eff.caps[], which in turn just contain the default values set in
> spapr_machine_class_init().
> 
> Fix this behaviour by making sure that h_get_cpu_characteristics()
> returns the data received from the KVM ioctl for a KVM guest.
> 
> Perf impact:
> With null syscall benchmark[1], ~45% improvement is observed.
> 
> 1. Vanilla QEMU
> $ ./null_syscall
> 132.19 ns     456.54 cycles
> 
> 2. With this patch
> $ ./null_syscall
> 91.18 ns     314.57 cycles
> 
> [1]: https://ozlabs.org/~anton/junkcode/null_syscall.c
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   hw/ppc/spapr_hcall.c   | 6 ++++++
>   include/hw/ppc/spapr.h | 1 +
>   target/ppc/kvm.c       | 2 ++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 406aea4ecb..6aec4e22fc 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1415,6 +1415,12 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>       uint8_t count_cache_flush_assist = spapr_get_cap(spapr,
>                                                        SPAPR_CAP_CCF_ASSIST);
>   
> +    if (kvm_enabled()) {
> +        args[0] = spapr->chars.character;
> +        args[1] = spapr->chars.behaviour;

If kvmppc_get_cpu_characteristics() call fails, we return random data.

Can't we just call kvm_vm_check_extension(s, KVM_CAP_PPC_GET_CPU_CHAR)
and kvm_vm_ioctl(s, KVM_PPC_GET_CPU_CHAR, &c) here?

> +        return H_SUCCESS;
> +    }
> +
>       switch (safe_cache) {
>       case SPAPR_CAP_WORKAROUND:
>           characteristics |= H_CPU_CHAR_L1D_FLUSH_ORI30;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 39bd5bd5ed..b1e3ee1ae2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -283,6 +283,7 @@ struct SpaprMachineState {
>       Error *fwnmi_migration_blocker;
>   
>       SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
> +    struct kvm_ppc_cpu_char chars;
>   };
>   
>   #define H_SUCCESS         0
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 992356cb75..fee6c5d131 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2511,6 +2511,7 @@ bool kvmppc_has_cap_xive(void)
>   
>   static void kvmppc_get_cpu_characteristics(KVMState *s)
>   {
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>       struct kvm_ppc_cpu_char c;
>       int ret;
>   
> @@ -2528,6 +2529,7 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
>           return;
>       }
>   
> +    spapr->chars = c;
>       cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
>       cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
>       cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);


