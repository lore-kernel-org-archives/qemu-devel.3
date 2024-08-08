Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DDC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 09:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbzSe-0002n6-Sr; Thu, 08 Aug 2024 05:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbzSY-0002mD-TI
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbzSV-0004hX-DD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723109349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbic9GAnDLbCg2mFAjPwrB4omZBulslpWG3qbtmC6jw=;
 b=O+X2xYtHTOVgivMlMDHhIRVg92MwkR7gD6SiWVBJyziAjNxAlW9WVap4lmmpG5V9EAl1hu
 YFXDayeufA6QmjZTo8Nr8JlVW4h/NxFflQeabEUfn6ldAHpKe1C8D7pQNZUufhaU0AFzyr
 qlFJp2rIfRu9OMoZkKtikyIxIpxXv+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-1XI79P31MmSoDG51L6J7Nw-1; Thu, 08 Aug 2024 05:29:06 -0400
X-MC-Unique: 1XI79P31MmSoDG51L6J7Nw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so347652f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 02:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723109345; x=1723714145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wbic9GAnDLbCg2mFAjPwrB4omZBulslpWG3qbtmC6jw=;
 b=berWVf9BfsInQvDETs4uenFtfpdmdNT6AHBrlhaJtvHmGw5tsANZtiWWK6a3Sirb1r
 09oowOlcTIUqythL3qNaMCT6fRxml8p+VqsZoOp0lm2ERrq9cWHr8tyIjiaZnSb2/Ra6
 2G2gN/Km/JCqjoq6fT7Z4+SVfp314jsEoYmKr6c02TXR4UVfCtX1+sIuLzZY+jsTocYk
 3wqbMCb/SgmCS7JojbO81NC9hDn+0XaqLo3wGUERJJ0pIaWvkl9jwv14Sw2ybbeOI3kG
 y4ZdMDO/gtl7HvrwJglFpKekm3uzcEXksbf/q/yvGyoHk2T6FJIG4Xkw6oTmJZFRz8zG
 ayJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwv8ziWWciWDJzp0lyFfwS6kxtaKyr8j8oNFM5BSyTsyWIJ46BBOqeJfzhjuEcSTD9YgpsBY2JypkFuTEsp3L8sB2bCQ0=
X-Gm-Message-State: AOJu0YwfkICNPswJXRCfy0l1gSuRy+WgFiUrIhCZFGSmjNBBhYyU9IS1
 py1yD1CrmQE3Dru7awPDBr9Jm5Pg2AIssXXqdIKtVsu98nmEZQ+jHGzJ6aMpAIgX2UCyf77xfgG
 GXdSpPER8J44gXFlNi6jj8PK01727FRztQHvbuIXJ1wLogKapiavy
X-Received: by 2002:a05:6000:156c:b0:36b:ea2d:fd5a with SMTP id
 ffacd0b85a97d-36d281a624bmr1389141f8f.22.1723109345479; 
 Thu, 08 Aug 2024 02:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZYqchjBDIphQeiBTMQVGfr70xJzzXZSKpXeJ7CeUoJ7qYPoKc2ikEvVuc/RBb2juHdhHa/Q==
X-Received: by 2002:a05:6000:156c:b0:36b:ea2d:fd5a with SMTP id
 ffacd0b85a97d-36d281a624bmr1389111f8f.22.1723109344954; 
 Thu, 08 Aug 2024 02:29:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7a6d15sm12968915e9.45.2024.08.08.02.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 02:29:04 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:29:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Manish <manish.mishra@nutanix.com>,
 John Levon <john.levon@nutanix.com>, zhao1.liu@intel.com, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Message-ID: <20240808112902.3e25609f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240802072426.4016194-1-xiaoyao.li@intel.com>
References: <20240802072426.4016194-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  2 Aug 2024 03:24:26 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest.

above implies that there could be a workaround to enable this leaf by
tweaking -smp CLI, so I'd suggest to put it here. So users would be able
to boot Windows without requiring to set this property.

> However, 1) TDX architecture forces to require CPUID 0x1f to configure CPU
> topology. and 2) There is a bug in Windows that Windows expects valid
> 0x1f leafs when the maximum basic leaf > 0x1f[1].

Which Windows versions are affected by this?
 
> Introduce a bool flag enable_cpuid_0x1f in CPU for the cases that
> requires CPUID leaf 0x1f to be exposed to guest. For case 2), introduce
> a user settable property as well, which provides an opt-in interface
> for people to run the buggy Windows as a workaround. The default value
> of the property is set to false, thus making no effect on existing
> setup.


> Opportunistically rename x86_has_extended_topo() to
> x86_has_v2_extended_topo() because per Intel SDM, leaf 0xb is for extended
> topology enumeration leaf and leaf 0x1f is v2 extended topology enumration
> leaf.
I don't see any point in renaming, just drop it 

 
> [1] https://lore.kernel.org/qemu-devel/21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com/
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  include/hw/i386/topology.h |  9 ---------
>  target/i386/cpu.c          | 18 ++++++++++++++++--
>  target/i386/cpu.h          |  4 ++++
>  target/i386/kvm/kvm.c      |  2 +-
>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index dff49fce1154..b63bce2f4c82 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -207,13 +207,4 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
>      return x86_apicid_from_topo_ids(topo_info, &topo_ids);
>  }
>  
> -/*
> - * Check whether there's extended topology level (module or die)?
> - */
> -static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
> -{
> -    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
> -           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
> -}
> -
>  #endif /* HW_I386_TOPOLOGY_H */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2d9..b5b7ac96c272 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -300,6 +300,19 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>             (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
>  }
>  
> +/*
> + * Check whether there's v2 extended topology level (module or die)?
> + */
> +bool x86_has_v2_extended_topo(X86CPU *cpu)
> +{
> +    if (cpu->enable_cpuid_0x1f) {
> +        return true;
> +    }
> +
> +    return test_bit(CPU_TOPO_LEVEL_MODULE, cpu->env.avail_cpu_topo) ||
> +           test_bit(CPU_TOPO_LEVEL_DIE, cpu->env.avail_cpu_topo);
> +}
> +
>  static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
>                                            enum CPUTopoLevel topo_level)
>  {
> @@ -6637,7 +6650,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_v2_extended_topo(cpu)) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -7450,7 +7463,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           * cpu->vendor_cpuid_only has been unset for compatibility with older
>           * machine types.
>           */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if (x86_has_v2_extended_topo(cpu) &&
>              (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>          }
> @@ -8316,6 +8329,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> +    DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false),
if we ever add this knob, rename it to 'x-cpuid-0x1f'
meaning: internal/unstable: use it on your own risk subject
to removal without notice

>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c6cc035df3d8..211a42ffbfa6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2110,6 +2110,9 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Force to expose cpuid 0x1f */
> +    bool enable_cpuid_0x1f;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> @@ -2368,6 +2371,7 @@ void cpu_set_apic_feature(CPUX86State *env);
>  void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  bool cpu_has_x2apic_feature(CPUX86State *env);
> +bool x86_has_v2_extended_topo(X86CPU *cpu);
>  
>  /* helper.c */
>  void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index b4aab9a410b5..d43c1fa26746 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1835,7 +1835,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_v2_extended_topo(env_archcpu(env))) {
>                  cpuid_i--;
>                  break;
>              }


