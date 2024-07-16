Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABACC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 03:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTYjL-0005aL-Ps; Mon, 15 Jul 2024 23:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTYjK-0005Zr-4g
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:19:54 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTYjI-00086A-5m
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 23:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721099993; x=1752635993;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5hwE8jefYu3wzgfHPUKdIBBuEEdxSZRNn2cQHsoVJPk=;
 b=U3UysVYdsxc0xz3jEPwDKmH9x//QzEJAnH0Bqc1oNsu6Ys+2IC815Hab
 0Q56prhhAiE5UWR7cxQzQr0rwlU7RlDklOqjB2/Pxz+YBQJfzbLk4uCmS
 3DyVqAc4/DdHmwQh+9mlpwlW9dhmShRqCQ7MExM2bIzuBKPOx1sOjJsa4
 tN1s6QJoOTBS2Vupv18DlaypMIIKYvI2B/x1FhPVfWabOxlikHkiWLQtP
 NDnZxR5r6Wy6lAMmPC8b2ydJNbaoe6MPEzUc1utVWMvRWbfrindAM3eLJ
 Dup88OEFc8t7vRT2zujXiHAoxRoVZEoQTggPJHSAp9u8poKU4X9ikSYAR g==;
X-CSE-ConnectionGUID: QoJzfYcJREyCfjeMVSnWMQ==
X-CSE-MsgGUID: tyeF3+NMQaKBNaX85JQgag==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18628021"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="18628021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 20:19:50 -0700
X-CSE-ConnectionGUID: 5hS9BWRlSvqlT35x19A8rA==
X-CSE-MsgGUID: iwZQFyToTjmx6zBNzEJFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49788264"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 20:19:46 -0700
Date: Tue, 16 Jul 2024 11:35:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 7/8] target/i386/kvm: Clean up return values of MSR
 filter related functions
Message-ID: <ZpXqf7Pc5shZ8osj@intel.com>
References: <20240715044955.3954304-1-zhao1.liu@intel.com>
 <20240715044955.3954304-8-zhao1.liu@intel.com>
 <f8f2cfb9-1128-4e1f-a152-3f88587927a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f2cfb9-1128-4e1f-a152-3f88587927a1@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Zide,

On Mon, Jul 15, 2024 at 03:18:07PM -0700, Chen, Zide wrote:
> Date: Mon, 15 Jul 2024 15:18:07 -0700
> From: "Chen, Zide" <zide.chen@intel.com>
> Subject: Re: [PATCH v3 7/8] target/i386/kvm: Clean up return values of MSR
>  filter related functions
> 
> On 7/14/2024 9:49 PM, Zhao Liu wrote:
> > @@ -5274,13 +5272,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
> >      }
> >  }
> >  
> > -static bool kvm_install_msr_filters(KVMState *s)
> > +static int kvm_install_msr_filters(KVMState *s)
> >  {
> >      uint64_t zero = 0;
> >      struct kvm_msr_filter filter = {
> >          .flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
> >      };
> > -    int r, i, j = 0;
> > +    int ret, i, j = 0;
> >  
> >      for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
> 
> Nit: Since it's a clean up patch, how about replace
> KVM_MSR_FILTER_MAX_RANGES with ARRAY_SIZE(msr_handlers), to make the
> code consistent in other places to refer to the array size of
> msr_handlers[].

Yes, that's fine, I'll add a new small trivial patch to clean up this.

> >          KVMMSRHandlers *handler = &msr_handlers[i];
> > @@ -5304,18 +5302,18 @@ static bool kvm_install_msr_filters(KVMState *s)
> >          }
> >      }
> >  
> > -    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
> > -    if (r) {
> > -        return false;
> > +    ret = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
> > +    if (ret) {
> > +        return ret;
> >      }
> >  
> > -    return true;
> > +    return 0;
> >  }
> 
> Nit: Seems ret is not needed here, and can directly return kvm_vm_ioctl();

Yes, good catch!

Thanks for you review!
Zhao



