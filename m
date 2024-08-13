Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A872C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnoh-0003tt-PT; Tue, 13 Aug 2024 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdnoh-0003tO-2p
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdnoe-0006zZ-Se
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723541262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9C7RyZRxXZjLSnb3NP9DlMXWhdwjtMqAWN70Wg8tAwg=;
 b=GjfoRrSoQgKfPOas0kQ78eAaMyPeeKMuG2Mqf8UZbLbnxWczuHoLGBAxSQA0MeZ8OlmyTI
 M6F4h3OfCVLUFqj/aM/Y7rBcnbkrm0a/zjiP1K4Jiz8Gn8BlOuAoTfMzLVB8mAPl8iBI2S
 2co5QiC2MlY0doRHGCr5l372LI740A0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-daqaYYMBP5OroadSmLNsHw-1; Tue, 13 Aug 2024 05:27:39 -0400
X-MC-Unique: daqaYYMBP5OroadSmLNsHw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280d8e685eso40945505e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723541258; x=1724146058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9C7RyZRxXZjLSnb3NP9DlMXWhdwjtMqAWN70Wg8tAwg=;
 b=AQqZ0W7hCAr+QuhYAN+0GUPsTjnRYj442Vl+yNRNyHde+8NDYuz9sxsQ4qZSbdFsvg
 s7+Is0PzcfGubsf4bI2Mw+ojCjYs7OTh3+CfQ7EFPHclFowX7rizE7UCEGzfbH2OsKg3
 C7B/NMeGhTMMdRJ2r3M261TZBAgR0nhdkiXzsjEF26dBqhzDSvYqcuekVFU7KFWHcxnc
 XpFO8N9dioDX0T3+i7BdWhJ/nvXPYuD7OrrxwP1nzwURsZoD6727EOeDnpDW07zOn0CZ
 lDn3V4pN65S6akSIDDjXsa5nsu59i222DcYcwO8sWcZGqjz0GDwx8dfcbjw87wQUr9k5
 oR3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXTVdtNwdkLCovRZJIU5VhX0SpHgIjRl0g+6Y+KwCwzuzZTqdSUVsBgBzH41swAsRUFw9r57Sd8AqH9Z4KDMh02UGLL44=
X-Gm-Message-State: AOJu0Yx9YAl/NtoJZG+I34tj3InGUrDTMJNgCK1g8SY0jD4w5k4k5kpi
 0iUSo7kTI6b1EXBFYGL291RUIxvAHFKDxIlJpuzWaH9WarKeCHG8Qxjw5rCjI2GRo4QCjF7c5iV
 Kr0+iWssgLXQSVtc/DayfhMYOT+iho1R9tdJVPRPdpIkm5UwUW+/3
X-Received: by 2002:a05:600c:5108:b0:426:61e8:fb35 with SMTP id
 5b1f17b1804b1-429d4818b81mr23918765e9.4.1723541258005; 
 Tue, 13 Aug 2024 02:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8hsmUS8hvYSk7qyWMNIyo4P3nUZCy4yW1D7fFXjVfhdcPcAxwJjn7I9DbaF2ItbwDTM6nAw==
X-Received: by 2002:a05:600c:5108:b0:426:61e8:fb35 with SMTP id
 5b1f17b1804b1-429d4818b81mr23918565e9.4.1723541257456; 
 Tue, 13 Aug 2024 02:27:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c72d69esm222465915e9.5.2024.08.13.02.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:27:36 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:27:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, zhao1.liu@intel.com, John
 Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>
Subject: Re: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <20240813112734.6b2394b9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240813033145.279307-1-xiaoyao.li@intel.com>
References: <20240813033145.279307-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Aug 2024 23:31:45 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest, e.g., -smp xx,dies=2.
> 
> However, 1) TDX architecture forces to require CPUID 0x1f to configure CPU
> topology. and 2) There is a bug in Windows that Windows 10/11 expects valid
> 0x1f leafs when the maximum basic leaf > 0x1f[1].
 1. will it boot if you use older cpu model?
 2. how user would know that this option would be needed?

> 
> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the cases that
> require CPUID leaf 0x1f to be exposed to guest. For case 2), introduce
> a user settable property, "x-cpuid-0x1f" ,as well, which provides an opt-in
> interface for people to run the buggy Windows as a workaround. The default
> value of the property is set to false, thus making no effect on existing
> setup.
> 
> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> to enable cpuid leaf 0x1f for the guest.
> 
> [1] https://lore.kernel.org/qemu-devel/20240724075226.212882-1-manish.mishra@nutanix.com/
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v2:
>  - Add more details in commit message;
>  - introduce a separate function x86_has_cpuid_0x1f() instead of
>    modifying x86_has_extended_topo();
> ---
>  target/i386/cpu.c     | 5 +++--
>  target/i386/cpu.h     | 9 +++++++++
>  target/i386/kvm/kvm.c | 2 +-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c04e..1e8653c6b051 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6649,7 +6649,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_cpuid_0x1f(cpu)) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -7462,7 +7462,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           * cpu->vendor_cpuid_only has been unset for compatibility with older
>           * machine types.
>           */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if (x86_has_cpuid_0x1f(cpu) &&
>              (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>          }
> @@ -8328,6 +8328,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> +    DEFINE_PROP_BOOL("x-cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false),
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c6cc035df3d8..085272d4c74a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2110,6 +2110,9 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Force to enable cpuid 0x1f */
> +    bool enable_cpuid_0x1f;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> @@ -2369,6 +2372,12 @@ void host_cpuid(uint32_t function, uint32_t count,
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
> index 31f149c9902c..8af43cb48101 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1835,7 +1835,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
>                  cpuid_i--;
>                  break;
>              }


