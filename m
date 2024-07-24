Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C688C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXrJ-00018O-Qu; Wed, 24 Jul 2024 05:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWXrI-00017s-5q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWXrF-00066c-3b
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721811623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5TyCzOHlXMU+ycL9+X9xG9KAKek/HROnfsnzIFsSDE=;
 b=XtS8CBoJKhcyVynaUB7knNWQcgsiC+o4CZu6tBkMMkHEY6Cik1VNOY+u5yA1n+js/WSh+s
 22mM4vb64zv/p0vy+TOC3sRFThqP1FhH5fZR6+AfUkjvVoivQwUF3rY3wRs+FevEc3p+r2
 1yMrh1r8WPLS1d3OjPQLa863uM3lbdo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-IGrYQtnVM_6ZhcEOrEJXuQ-1; Wed, 24 Jul 2024 05:00:08 -0400
X-MC-Unique: IGrYQtnVM_6ZhcEOrEJXuQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef3133ca88so26503471fa.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 02:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721811607; x=1722416407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5TyCzOHlXMU+ycL9+X9xG9KAKek/HROnfsnzIFsSDE=;
 b=Q25UXgjsMG+LfTC62B/EQLQBWjJnXk7CrRPQdA1yzHdH5RD6e5cU09r2JJhV71zb/M
 3IV7PNTmPjhNaU6s2ppdLj7goOvg0yO4FOZXyj4V5Ln4fT6dZgZJpSuw3Pr45qb3g0BZ
 fPa+1Jf+S3v0wA0hpllofeweS831o4yWhjuk4XuzpHOQKn1agvcOmoKSAJWj+pFF7w9X
 8zuFZmjqqTxDifJ1id5BSe2v2FDoM8uM+eYbVtEpD/svdk2FyGBFngZYCpgbXI/6iEXp
 UXv236sIDqHrs4kDkX8Plvq9qUSddXC6tnB7k46BVp/oFBDVDxGSlVj4L5sFIklxcRtV
 Cthw==
X-Gm-Message-State: AOJu0YwZHyCNEAJDkzDF/qZ5QJjlb+uTS3GCYS7EshQnXkRI328IbJSf
 3oNr+27ImVUJMvIGpJ/l4dutTs+RgNDMjN1lp3snrwqT+y8AKnHvc6MQaCI+FoD2r7l3ZvFCkl2
 0PyFQXYbWAKrsFNs6qD+eayBm8Pc8TYfB2eD5SzFOSKt85GBqTU1m
X-Received: by 2002:a05:651c:a0f:b0:2f0:19f5:9d99 with SMTP id
 38308e7fff4ca-2f019f5a030mr63661261fa.23.1721811606740; 
 Wed, 24 Jul 2024 02:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3U3VrgCiDK/+XAxCnEYj3DDG0vTXnwJdrEnbY+d2ZfXq1GuD2vkEXbX4RifR8eLLA89h6FQ==
X-Received: by 2002:a05:651c:a0f:b0:2f0:19f5:9d99 with SMTP id
 38308e7fff4ca-2f019f5a030mr63660921fa.23.1721811606211; 
 Wed, 24 Jul 2024 02:00:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9413663sm19918405e9.45.2024.07.24.02.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:00:05 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:00:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "manish.mishra" <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240724075226.212882-1-manish.mishra@nutanix.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Wed, 24 Jul 2024 07:52:26 +0000
"manish.mishra" <manish.mishra@nutanix.com> wrote:

> From: Manish Mishra <manish.mishra@nutanix.com>
> 
> QEMU does not set 0x1f in case VM does not have extended CPU topology
> and expects guests to fallback to 0xb. Some versions of Windows does not
> like this behavior and expects this leaf to be populated. As a result Windows
> VM fails with blue screen.

BSOD usually has error code displayed, it would be better to specify it here
this way whomever searching for the error, can find this patch/commit

> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> to 0xb by default and workaround windows issue.>

> This change adds a
> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> case extended CPU topology is not configured and behave as before otherwise.

repeating question
why we need to use extra property instead of just adding 0x1f leaf for CPU models
that supposed to have it?

> Steps to reproduce this issue:
> This requires Windows 10 or 11 VM, with credential guard and HyperV role
> enabled. Also this issue shows starting SapphireRapids which raised cpuid
> level to 0x20, hence exposing 0x1f to guests.
> ./qemu-system-x86_64
> -drive file=/usr/share/OVMF/OVMF_CODE_4MB.secboot.fd,if=pflash,format=raw,unit=0,readonly=on
> -drive file=/usr/share/OVMF/OVMF_VARS_4MB.fd,if=pflash,format=raw
> -machine pc-q35,smm=on
> -global mch.extended-tseg-mbytes=80
> -accel kvm
> -m 2G
> -cpu SapphireRapids-v1,invtsc=on,vmx=on
> -smp 2,maxcpus=240,sockets=120,dies=1,cores=2,threads=1
> -hda systest_ahv_win10_cg.qcow2
> 
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>  hw/i386/pc.c          | 1 +
>  target/i386/cpu.c     | 7 +++++--
>  target/i386/cpu.h     | 5 +++++
>  target/i386/kvm/kvm.c | 4 +++-
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..4cab04e443 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
>      { "sev-guest", "legacy-vm-type", "on" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
> +    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2..7b71083bc9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6637,7 +6637,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_extended_topo(env->avail_cpu_topo) &&
> +            !cpu->enable_cpuid_0x1f_enforce) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -7450,7 +7451,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           * cpu->vendor_cpuid_only has been unset for compatibility with older
>           * machine types.
>           */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if ((x86_has_extended_topo(env->avail_cpu_topo) ||
> +             cpu->enable_cpuid_0x1f_enforce) &&
>              (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>          }
> @@ -8316,6 +8318,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> +    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1e121acef5..49c5641ba8 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2102,6 +2102,11 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Always return values for 0x1f leaf. In cases where extended CPU topology
> +     * is not configured, return values equivalent of leaf 0xb.
> +     */
> +    bool enable_cpuid_0x1f_enforce;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index becca2efa5..a9c6f02900 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>      uint32_t limit, i, j;
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
> +    X86CPU *cpu = env_archcpu(env);
>  
>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>  
> @@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
> +                !cpu->enable_cpuid_0x1f_enforce) {
>                  cpuid_i--;
>                  break;
>              }


