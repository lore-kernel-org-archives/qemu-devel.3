Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B529C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqu2-0005tp-Vx; Wed, 05 Jun 2024 09:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEqty-0005pD-D0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEqtv-0005Gy-5p
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717594921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0O0BrZBeorsDSlWqqb75Id2FxwyblMLQic+MBhE1DB0=;
 b=YQkMfNT2pi3PeGXiPs3BIhb+EfRNnAhJmsP8BRXOzkle29sF4lcixGmkPJbIzZCiZbflXG
 Bd1FllCyx+ZlQkC8SHyBJXUEyA54N5RzjaAs5M8EGW1u0MoY2/DM9wcN2E/uBJFyCJ54uw
 01PC1L8yVh8EsADk3yaA8ajVX7SxMUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ciudXo2ANL6OZDNmmfwmzA-1; Wed, 05 Jun 2024 09:42:00 -0400
X-MC-Unique: ciudXo2ANL6OZDNmmfwmzA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso32048825e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594919; x=1718199719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0O0BrZBeorsDSlWqqb75Id2FxwyblMLQic+MBhE1DB0=;
 b=Yvf3CPH8yQkgvwHqyOfOvG/DOu6/Y50arqGpEo0jMBRI3bqCBEizM2gC8tbwaQORwa
 W07dfJ76hBS1KroKGHpsJxziReueJZzdswazCMzsH6BzzyQgGA+HtGWTqPTi/Rvv2qGv
 7ZC/DHMnc7J+QhtA2cZobHAhu14KxAjf6Og3ioelh6xx9i0nLc4rKKsfkUoIDsAPbjVx
 AczyMNniE79+Vhbqk2eGVzkSB353tO4mQk4Xg2zKyIXoBoobacY4oxKYY5anvH2QZ12M
 6mFRZ2oL3zlS6ZBIxKPQrsaNwBu+CdbI84U97ANhet3pN1OPgt+AIqVaAJ9XFYxgDpzr
 rcfg==
X-Gm-Message-State: AOJu0Yx6xAoqBniUt2nADwA52z5K1FjIdOq95x9Vd68uaLGZpwFDn5ig
 aULh74SIOkn6FavPyVTxI7O1S9ih2puBhOlgl06fG/tKu/7MxRii/hSxeqc9dJ3AWZmK97v0yg4
 IZal8vhOitXElusHs+swbH7D+RE2RT+ldvJQCZH5n0aHRa7kEDGMK
X-Received: by 2002:a05:600c:46c3:b0:421:2cb3:143 with SMTP id
 5b1f17b1804b1-421562cf604mr18961455e9.3.1717594918952; 
 Wed, 05 Jun 2024 06:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kfxnqBL0ZcIFk0P7ClyMYS6GQt3TkD/bbXAkkjd3JawmJ6y9LSIjrKNL8oojMOQsOkjilQ==
X-Received: by 2002:a05:600c:46c3:b0:421:2cb3:143 with SMTP id
 5b1f17b1804b1-421562cf604mr18961235e9.3.1717594918599; 
 Wed, 05 Jun 2024 06:41:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421581016c6sm22320795e9.3.2024.06.05.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 06:41:58 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:41:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org, seanjc@google.com, zhao1.liu@intel.com
Subject: Re: [PATCH V3 2/2] target/i386: Advertise MWAIT iff host supports
Message-ID: <20240605154157.6874cad0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240604000222.75065-3-zide.chen@intel.com>
References: <20240604000222.75065-1-zide.chen@intel.com>
 <20240604000222.75065-3-zide.chen@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon,  3 Jun 2024 17:02:22 -0700
Zide Chen <zide.chen@intel.com> wrote:

> host_cpu_realizefn() sets CPUID_EXT_MONITOR without consulting host/KVM
> capabilities. This may cause problems:
> 
> - If MWAIT/MONITOR is not available on the host, advertising this
>   feature to the guest and executing MWAIT/MONITOR from the guest
>   triggers #UD and the guest doesn't boot.  This is because typically
>   #UD takes priority over VM-Exit interception checks and KVM doesn't
>   emulate MONITOR/MWAIT on #UD.
> 
> - If KVM doesn't support KVM_X86_DISABLE_EXITS_MWAIT, MWAIT/MONITOR
>   from the guest are intercepted by KVM, which is not what cpu-pm=on
>   intends to do.
> 
> In these cases, MWAIT/MONITOR should not be exposed to the guest.
> 
> The logic in kvm_arch_get_supported_cpuid() to handle CPUID_EXT_MONITOR
> is correct and sufficient, and we can't set CPUID_EXT_MONITOR after
> x86_cpu_filter_features().
> 
> This was not an issue before commit 662175b91ff ("i386: reorder call to
> cpu_exec_realizefn") because the feature added in the accel-specific
> realizefn could be checked against host availability and filtered out.
> 
> Additionally, it seems not a good idea to handle guest CPUID leaves in
> host_cpu_realizefn(), and this patch merges host_cpu_enable_cpu_pm()
> into kvm_cpu_realizefn().
> 
> Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> V3:
> - don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn().
> - Change title to reflect the main purpose of this patch.
> 
>  target/i386/host-cpu.c    | 12 ------------
>  target/i386/kvm/kvm-cpu.c | 11 +++++++++--
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 280e427c017c..8b8bf5afeccf 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -42,15 +42,6 @@ static uint32_t host_cpu_phys_bits(void)
>      return host_phys_bits;
>  }
>  
> -static void host_cpu_enable_cpu_pm(X86CPU *cpu)
> -{
> -    CPUX86State *env = &cpu->env;
> -
> -    host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> -               &cpu->mwait.ecx, &cpu->mwait.edx);
> -    env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> -}
> -
>  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>  {
>      uint32_t host_phys_bits = host_cpu_phys_bits();
> @@ -83,9 +74,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
>  
> -    if (cpu->max_features && enable_cpu_pm) {
> -        host_cpu_enable_cpu_pm(cpu);
> -    }
>      if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>          uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
>  
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index f76972e47e61..148d10ce3711 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -65,8 +65,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>       *   cpu_common_realizefn() (via xcc->parent_realize)
>       */
>      if (cpu->max_features) {
> -        if (enable_cpu_pm && kvm_has_waitpkg()) {
> -            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
> +        if (enable_cpu_pm) {
> +            if (kvm_has_waitpkg()) {
> +                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
> +            }
> +
> +            if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
> +                host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> +                           &cpu->mwait.ecx, &cpu->mwait.edx);
> +	    }
>          }
>          if (cpu->ucode_rev == 0) {
>              cpu->ucode_rev =


