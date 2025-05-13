Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5698CC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEp1N-0006IV-T1; Tue, 13 May 2025 08:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEp0f-0005qc-Q9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEp0d-0000hp-S4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747140321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qbzKwIrC2/FHuWNCqW2F1uNvDxrKnayEbn3X40B/pY=;
 b=Nr7gFpjWCLFN1lcsrWcYhK8HGndsLdGp8kR5SILl88eWe8J9dVGaQvFoLGTDeIn1/dHsiu
 tndLJxGXHM5DFOWBkzYp/RjR7aLc0aW3KOWLGgXinda+zhFuXTzc2fHucwaoxOvpzoSxFy
 voKvtwoZLvCbshR0G+k7OuDkGhXxlIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-eV9EVsQhOUmbpd9PQabylA-1; Tue, 13 May 2025 08:45:20 -0400
X-MC-Unique: eV9EVsQhOUmbpd9PQabylA-1
X-Mimecast-MFC-AGG-ID: eV9EVsQhOUmbpd9PQabylA_1747140319
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso41919555e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 05:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747140319; x=1747745119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qbzKwIrC2/FHuWNCqW2F1uNvDxrKnayEbn3X40B/pY=;
 b=LvpHnI2ZUe6zWvZVKTYC6kFYyvsLfIdmQ9h1ns98C9Qd2DBoLBj00OD3FSVDE6Ssm/
 1DCvoBpsVNGXg6uil6MDQoC3rkh0KllfzGKh6qj3iGldefBaLsc/nUgEQ38wgLsiNBTm
 kLN11pK7gxzuwB8vOvZP/hMZLBHI8vuq8UaoSKhFbyU3tJG/sfw3HJastxieZqTcaVmJ
 axMqvyv58cxxSjp+CSrZAXwM8j0JJbk3lyILsnlubfryd9rJBeWQKUjlL31RnJIHo39p
 Nu2q2GRbFmmN3j+y+f+MRRMMKKGwsSx3OmDNozxpBvgj+1DCr2F0AOjMSpJ6EErhesBr
 wKnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr/SWzLW7LxeGVU9Y+k/KN8oXEbH0eEGIsAKdGFPiWElQWnzDjWyEq7HSjkFbe3lyD3Q0ldu3HbLNz@nongnu.org
X-Gm-Message-State: AOJu0Yz4b3arP561YIe5zvJGgkAAIrpGzi0YBpyn/7c3TCj8I1qhE962
 9C3pvC7xElq/Ho3Kp02w1YB8yWZAQ/0u1HiSoh3vRufq1pry3YXjORZsI/g/kFuHhQl7ohH1lhB
 SXc7+TPiFpp4SSf0Jrs6qddnhIRwEaG6CBYCdZn7E+78qxO0TktyX
X-Gm-Gg: ASbGncsJg64B4BGgZosZGzN8l+QHyHW7Gf3Xet9fF50uMOaZtk80R1IYlQdKvKbIuC0
 8/aEw3IQD17tjRsNhvKDaRppxv33pp2euzH8cPTdRQE2JgnIc5xxAJshn7YWxkS+EODAVbTiLsF
 Eb5KhCgb1ww48su6QTQoAleeGeIeucUxBMZw06iA2fDkEQ+O3bMrB4leJMJjyEF3ffMyIj5xSpn
 vGNpqK/z/af0DbQll031wbZ3yyso3j9kBDzNZGeMbOhALOj3ekL2tw/Z5x3P9aPB0ix6l/nh7u4
 t2/vAou3SJS96el623UAmTRVuWX6658z
X-Received: by 2002:a05:600c:6819:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-442d6d1fadamr135825295e9.11.1747140318798; 
 Tue, 13 May 2025 05:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwUzWUPASx2NiQ1Kn3uuvcgEdnOm17Ak4ZkvlCvpTjzcgN+0pD9VaNQeoqRZ/ENeDLe7VIdA==
X-Received: by 2002:a05:600c:6819:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-442d6d1fadamr135824865e9.11.1747140318428; 
 Tue, 13 May 2025 05:45:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58eb91bsm16387897f8f.33.2025.05.13.05.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 05:45:18 -0700 (PDT)
Date: Tue, 13 May 2025 14:45:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Babu Moger <babu.moger@amd.com>, Ewan Hai
 <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK
 <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <20250513144515.37615651@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250423114702.1529340-7-zhao1.liu@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-7-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 23 Apr 2025 19:46:58 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest, e.g., -smp xx,dies=2.
> 
> However, TDX architecture forces to require CPUID 0x1f to configure CPU
> topology.
> 
> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
> requires CPUID leaf 0x1f to be exposed to guest.
> 
> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> to enable cpuid leaf 0x1f for the guest.

that reminds me about recent attempt to remove enable_cpuid_0xb,

So is enable_cpuid_0x1f inteded to be used by external users or
it's internal only knob for TDX sake?

I'd push for it being marked as internal|unstable with the means
we currently have (i.e. adding 'x-' prefix)

and also enable_ is not right here, the leaf is enabled when
topology requires it.
perhaps s/enable_/force_/
 
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c     | 4 ++--
>  target/i386/cpu.h     | 9 +++++++++
>  target/i386/kvm/kvm.c | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d90e048d48f2..e0716dbe5934 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7292,7 +7292,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_cpuid_0x1f(cpu)) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -8178,7 +8178,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           * cpu->vendor_cpuid_only has been unset for compatibility with older
>           * machine types.
>           */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if (x86_has_cpuid_0x1f(cpu) &&
>              (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>          }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 76f24446a55d..3910b488f775 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2251,6 +2251,9 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Force to enable cpuid 0x1f */
> +    bool enable_cpuid_0x1f;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> @@ -2513,6 +2516,12 @@ void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  bool cpu_has_x2apic_feature(CPUX86State *env);
>  
> +static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
> +{
> +    return cpu->enable_cpuid_0x1f ||
> +           x86_has_extended_topo(cpu->env.avail_cpu_topo);
> +}
> +
>  /* helper.c */
>  void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
>  void cpu_sync_avx_hflag(CPUX86State *env);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 6c749d4ee812..23b8de308525 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1863,7 +1863,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
>                  cpuid_i--;
>                  break;
>              }


