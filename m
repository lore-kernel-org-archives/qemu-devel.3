Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B18CCF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNrg-0002UB-Ic; Wed, 07 Jan 2026 02:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNre-0002Tq-VV
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:21:55 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNrc-0004gA-Gt
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767770513; x=1799306513;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eECLbTr1DaGxSjoWz66Jd1rt+CG1mD7xd48W2lFlFOE=;
 b=ZJAAnH0m2FOZh6CYYgSCckvzjDkeKhrTVH0heWtas2Ds16pUahlY5Itc
 j2TkZ/Tm5ElXfkOSu5cpBGgN1yEbofI+eszEocgnZz2caJ9x6RlHxbFs7
 ZMRwRbhJhQaRfbPXOdiItm4ULfPKq0i7Hvz/PGEaMdop+7NswQJTnM72G
 Ak34pBSgpaMuGFZYhPvJzKNGgQabNlY6tlOq8ciVdbulg+MSwYarPLM9M
 OAIDoFxCwwzx/F6P6N8fxdHt0MgRf+F27KdOCcA6DdMop+r8v4u66xyaR
 NzEX1Jd7cLsj0ypgQVIWCK+ANkKsElcs6Mq3P4JFqwG3rMeoKIF6wKe1a g==;
X-CSE-ConnectionGUID: qhPUYQFCSu+fCr+X0nvqww==
X-CSE-MsgGUID: yan/P24nShqKIYVg4eo7fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69211125"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69211125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 23:21:50 -0800
X-CSE-ConnectionGUID: zP3uEfjcR7y1s8+1Ellx8A==
X-CSE-MsgGUID: zF8aJ6ZATdqwPUgc9caCXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="233993578"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 06 Jan 2026 23:21:48 -0800
Date: Wed, 7 Jan 2026 15:47:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, seanjc@google.com, santosh.shukla@amd.com,
 nikunj.dadhania@amd.com, ravi.bangoria@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 2/5] i386: Add CPU property x-force-cpuid-0x80000026
Message-ID: <aV4PgVwYVXHgmCi3@intel.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-3-shivansh.dhiman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121083452.429261-3-shivansh.dhiman@amd.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Fri, Nov 21, 2025 at 08:34:49AM +0000, Shivansh Dhiman wrote:
> Date: Fri, 21 Nov 2025 08:34:49 +0000
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Subject: [PATCH 2/5] i386: Add CPU property x-force-cpuid-0x80000026
> X-Mailer: git-send-email 2.43.0
> 
> Introduce new CPU property x-force-cpuid-0x80000026 using which the CPUID
> 0x80000026 is enabled. It defaults to false.
> 
> If a vCPU's model is host, then CPUID is enabled based on CPU family/model.
> Implement x86_is_amd_zen4_or_above() helper to detect Zen4+ CPUs using
> family/model.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>  target/i386/cpu.c |  8 ++++++++
>  target/i386/cpu.h | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b7827e448aa5..01c4da7cf134 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9158,6 +9158,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
>          }
> +
> +        /* Enable CPUID[0x80000026] for AMD Genoa models and above */
> +        if (cpu->force_cpuid_0x80000026 ||
> +            (!xcc->model && x86_is_amd_zen4_or_above(cpu))) {

I understand you want to address max/host CPU case here, but it's still
may not guarentee the compatibility with old QEMU PC mahinces, e.g.,
boot a old PC machine on v11.0 QEMU, it can still have this leaf.

So it would be better to add a compat option to disable 0x80000026 for
old PC machines by default.

If needed, to avoid unnecessarily enabling extended CPU topology, I think
it's possible to implement a check similar to x86_has_cpuid_0x1f().

> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000026);
> +        }
>      }

Thanks,
Zhao


