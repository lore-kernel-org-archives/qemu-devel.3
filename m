Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E40D25032
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfCPK-0006PN-O2; Mon, 12 Jan 2026 02:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCPJ-0006Nk-0a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:32:09 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCPG-0008Bk-Ex
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768203127; x=1799739127;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wCdVxv++vV4zY3U/Uah3D3XPw6RJeI7tbc9d7yTBM7o=;
 b=j/DDh15lFgICQL9AefPD8JHq/YMrZUOatyylV1WeUaOECNGnzMFrAAsM
 vBJgu93JQydt8VnAwTHQQHUb52J/Md9RmsiaH4BU83kOUKwlbfDkOktNz
 OFHWElq9I6EaXIGbhT2Wj5v2Wne8qUXJrckDxYC3J0nr4z0678GdujnHE
 JkWmaAY/KdWI0EOjsCJneY2vCjF2o8GUPYr68KKe33AS242Md42TiFoDK
 GykCIvi1kYBKSXRz7WUts0r2iRXmh+mWkJGav2TcW1NVov8zUAmfGh/zx
 YqHZ11pif+vii32OvXtZAVTHI7NmVCB9ns7fswMr+ubqRjMIfAy0bzqXY g==;
X-CSE-ConnectionGUID: bA81WAguROy9hAeDIOn0Uw==
X-CSE-MsgGUID: 0RXohKMMTlGGQ70HGmdbIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="79766993"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="79766993"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 23:32:03 -0800
X-CSE-ConnectionGUID: CiYmraRrTG2+bJ4JHwrfKA==
X-CSE-MsgGUID: 61hwoF19S3Cw0+KZP2FN0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="203175604"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 11 Jan 2026 23:32:00 -0800
Date: Mon, 12 Jan 2026 15:57:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, seanjc@google.com, santosh.shukla@amd.com,
 nikunj.dadhania@amd.com, ravi.bangoria@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 2/5] i386: Add CPU property x-force-cpuid-0x80000026
Message-ID: <aWSpZxg7kKrdBifu@intel.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-3-shivansh.dhiman@amd.com>
 <aV4PgVwYVXHgmCi3@intel.com>
 <8ef42171-5473-449f-bd72-e9874fa6f7f1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef42171-5473-449f-bd72-e9874fa6f7f1@amd.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> On 07-01-2026 13:17, Zhao Liu wrote:
> > On Fri, Nov 21, 2025 at 08:34:49AM +0000, Shivansh Dhiman wrote:
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index b7827e448aa5..01c4da7cf134 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -9158,6 +9158,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> >>          if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
> >>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
> >>          }
> >> +
> >> +        /* Enable CPUID[0x80000026] for AMD Genoa models and above */
> >> +        if (cpu->force_cpuid_0x80000026 ||
> >> +            (!xcc->model && x86_is_amd_zen4_or_above(cpu))) {
> > 
> > I understand you want to address max/host CPU case here, but it's still
> > may not guarentee the compatibility with old QEMU PC mahinces, e.g.,
> > boot a old PC machine on v11.0 QEMU, it can still have this leaf.
> 
> Wouldn't initializing x-force-cpuid-0x80000026 default to false prevent this?
> Oh, but, this CPUID can still be enabled on an older machine-type with latest
> QEMU with the existing checks. And probably this could also affect live migration.

Yes, on a zen4 host, booting an older machine with latest QEMU will have
this CPUID leaf.
 
> > So it would be better to add a compat option to disable 0x80000026 for
> > old PC machines by default.
> 
> Does this look fine?
> 
> GlobalProperty pc_compat_10_2[] = {
>     { TYPE_X86_CPU, "x-force-cpuid-0x80000026", "false" },
> };
> const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);

It looks fine if we only check "if (cpu->force_cpuid_0x80000026)".

> > If needed, to avoid unnecessarily enabling extended CPU topology, I think
> > it's possible to implement a check similar to x86_has_cpuid_0x1f().
> 
> Do you mean something like this? I avoided it initially because it is
> functionally same as current one, and a bit lengthy.

Sorry for confusion. Could we get rid of model check
(x86_is_amd_zen4_or_above)? and could we do something like 0x1f leaf,

static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
{
    return cpu->force_cpuid_0x1f ||
           x86_has_extended_topo(cpu->env.avail_cpu_topo);
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

similarly, apply x86_has_extended_topo() for AMD CPU as well?

x86_has_extended_topo() also checks "module" level, but I think we could
return error in encode_topo_cpuid80000026() for unsupported "moduel"
level?

Thus, when users explicitly set these levels, the 0x80000026 leaf will be
enabled.

Furthermore, I think it's better that different x86 vendors could adopt
similar behavior for these extended topology levels, especially since
they are all all configured through a unified "-smp" interface.

Thanks,
Zhao


