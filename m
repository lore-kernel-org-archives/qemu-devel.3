Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD14D5CCAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68O8-00073M-H9; Wed, 30 Oct 2024 09:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t68O5-0006yc-2s
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:05:25 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t68O2-0008I3-MK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730293523; x=1761829523;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=aoVDUatUJG0roc8TOohAu6l/mv0A9/07tntEYj2BAUo=;
 b=bo5SXG+JxwXb6bNVZwdFrm+M6VjREGOA1ufqed5WDmjQlpgQHPHMy+Qn
 R0GIwnIQfy4ELdyMPRagM70WjMUGfid+9NL5SjruQS/ucOQIsy+7zeBKe
 eRxDpbPl8r8ox/P20CV8Q8VrNG1w+otwrmxDNfBDAEMlMIE/rL4x5wa4s
 mKwsqck+8MiFPimsdhXlx5p2PtAuiNigrBZL299nwC4UzoLZ7/7ag7xKC
 lpk6OjZiqwZjTIITv3qGazZf09Txx63+TMyKVO279BZrIuFpeW5QEDlwK
 J+KGOgTCSyP2XobhOeELNTZqL27wYj/U2YjLewQkZIGTVYhY/+i7fVVra A==;
X-CSE-ConnectionGUID: ltDUOSjsTl+O0Ql+VuylVw==
X-CSE-MsgGUID: 2Z1TZZ3bSwOZzYAt++lpuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30141248"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30141248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 06:05:19 -0700
X-CSE-ConnectionGUID: JaYXe0jqTiSjAX5aWwbmXw==
X-CSE-MsgGUID: CmbjOcG6TzeqJ83RnXpMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; d="scan'208";a="83119817"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 06:05:16 -0700
Date: Wed, 30 Oct 2024 21:21:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyIy4OGSGPhAZutK@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > > Introduce avx10-version property so that avx10 version can be controlled
> > > by user and cpu model. Per spec, avx10 version can never be 0, the default
> > > value of avx10-version is set to 0 to determine whether it is specified by
> > > user.
> > 
> > The default value of 0 does not reflect whether the user has set it to 0.
> > According to the description here, the spec clearly prohibits 0, so
> > should we report an error when the user sets it to 0?
> > 
> > If so, it might be better to change the default value to -1 and adjust
> > based on the host's support.
> > 
> 
> If user sets version to 0, it will directly use reported version, this
> should be a more neat and intuitive way?

The code implementation is actually similar for different initial
values. And about this:

> If user sets version to 0, it will directly use reported version", 

It's defining a special behavior for the API, which is based on the
special 0 value, and there needs to be documentation to let the user
know that 0 will be considered legal as well as that it will be quietly
overridden... But AFAIK there doesn't seem to be any place to add
documentation for the property ...

There may be similar problems with -1, e.g. if the user writes -1, there
is no way to report an error for the user's behavior. But it's better
than 0. After all, no one would think that a version of -1 is correct.
Topology IDs have been initialized to -1 to include the user's 0 value
in the check.

> > > The default can come from the device model or, for the max model,
> > > from KVM's reported value.
> > > 
> > > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > > Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
> > > Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  target/i386/cpu.h     |  4 +++
> > >  target/i386/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++-----
> > >  target/i386/kvm/kvm.c |  3 +-
> > >  3 files changed, 63 insertions(+), 8 deletions(-)
> > 
> > [snip]
> > 
> > > @@ -7611,7 +7644,23 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> > >          }
> > >      }
> > >  
> > > -    return x86_cpu_have_filtered_features(cpu);
> > > +    have_filtered_features = x86_cpu_have_filtered_features(cpu);
> > > +
> > > +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> > > +        x86_cpu_get_supported_cpuid(0x24, 0,
> > > +                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
> > > +        uint8_t version = ebx_0 & 0xff;
> > > +
> > > +        if (version < env->avx10_version) {
> > > +            if (prefix) {
> > > +                warn_report("%s: avx10.%d", prefix, env->avx10_version);
> > 
> > Perhaps also tell user about revised version?
> > 
> > warn_report("%s: avx10.%d. Adjust to avx10.%d",
> >             prefix, env->avx10_version, version);
> > 
> 
> I see, thanks!

Welcome!

> > > +            }
> > > +            env->avx10_version = version;
> > > +            have_filtered_features = true;
> > > +        }
> > > +    }
> > 
> > 
> > Per Tao's comment, perhaps we can check AVX10 and version here (default
> > version is 0):
> > 
> > @@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> >                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
> >          uint8_t version = ebx_0 & 0xff;
> > 
> > -        if (version < env->avx10_version) {
> > +        if (!env->avx10_version) {
> > +            env->avx10_version = version;
> 
> x86_cpu_filter_features() is not a good place to assign avx10_version, I
> still tend to set it in max_x86_cpu_realize().

It's not proper to get the host's version when AVX10 cannot be enabled,
even maybe host doesn't support AVX10.

As you found out earlier, max_x86_cpu_realize doesn't know if AVX10 can
be enabled or not.

> > +        } else (version < env->avx10_version) {
> >              if (prefix) {
> > -                warn_report("%s: avx10.%d", prefix, env->avx10_version);
> > +                warn_report("%s: avx10.%d. Adjust to avx10.%d",
> > +                            prefix, env->avx10_version, version);
> >              }
> >              env->avx10_version = version;
> >              have_filtered_features = true;
> >          }
> > +    } else if (env->avx10_version && prefix) {

Oops, here we only need to check env->avx10_version...

> > +        if (prefix) {
> 
> I think it is reasonable, especially when we don't check AVX10 enable bit
> in max_x86_cpu_realize(). But checking prefix here again seems not
> necessary.

Thanks! We only need the second check since have_filtered_features
should change whether prefix exists or not.

> > +            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> > +        }
> > +        have_filtered_features = true;
> >      }
> > 
> >      return have_filtered_features;
> > 
> > > +    return have_filtered_features;
> > >  }
> > >  
> > >  static void x86_cpu_hyperv_realize(X86CPU *cpu)
> > > @@ -8395,6 +8444,7 @@ static Property x86_cpu_properties[] = {
> > >      DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
> > >      DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
> > >      DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
> > > +    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
> > 
> > As my first comment, we could consider changing the default value to -1.
> > 
> 
> I still think 0 is better¡­
> 

