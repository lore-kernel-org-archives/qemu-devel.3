Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA4C83F03
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 01:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYaGc-0006Dn-Pk; Sun, 06 Jul 2025 21:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaGY-0006DS-D2
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:03:30 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1uYaGV-0003V3-8s
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 21:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751850207; x=1783386207;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fvnOLTjlDdwzxE2oVDgXZaUD6KDiTHRBEjYgFvDBI5o=;
 b=iIMGOuINPVB/ZebUmWGyleopkvlxGt1Xyn2Qe3+cMOwaziaVzspgWLAb
 2OZu1UBmwMJrREau5Wnz3HOGFSDv8UUrtfZsX3PC4H5CUOH7JwkeA8/Jy
 NGgRuD1TF03i/28YnLwNcTHztqiuXdh+xUV4SZT1RlJS4kHNxg3nlJ7gJ
 lfEhGpb+wY1c/x+W7oTzsbQWI2MMwg5kdRrZZgxX8bJXVThRdXK3+YlIb
 FK/rbdKR31liCzcWh6L4fuwK1kaw+WLdVoqgT8kozB38P+Hcj4zuS/AcB
 w1hzjfqaGR+f5v+dVwk3eLG/3VFkgVqQdnXQl8pWwK8mgAoFsGXo5iy6N w==;
X-CSE-ConnectionGUID: teYEuSIkQkir33aXSm6F6w==
X-CSE-MsgGUID: aVaYOAPXQ3aANW8eQMxkOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53189345"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="53189345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:03:22 -0700
X-CSE-ConnectionGUID: 3XrWK80LTGapOGMzLOPy5Q==
X-CSE-MsgGUID: zgs4VCeUQaCbyCPNraRSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; d="scan'208";a="159352368"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 18:03:20 -0700
Date: Mon, 7 Jul 2025 08:55:59 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] i386/cpu: Clean Up Reserved CPUID Leaves for Intel
Message-ID: <aGsbHwjukIYuF8DX@linux.bj.intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 27, 2025 at 11:51:25AM +0800, Zhao Liu wrote:
> Hi,
> 
> Since the previsor unified cache model series has already introduced a
> new compat property "x-vendor-cpuid-only-v2", it's a chance to once
> again consolidate more vendor-specific CPUIDs.
> 
> I also checked the CPUID leaves currently supported by Intel & AMD and
> found that since the previous "x-vendor-cpuid-only," AMD has already
> cleaned up the Intel-specific CPUIDs quite well.
> 
> As for Intel, the only cleanup needed is for the "extended function
> CPUID" leaves (0x80000000~0x80000008). That's what this series does.
> 
> This series is based on:
> 
> <20250626083105.2581859-1-zhao1.liu@intel.com>
> 
> Or you can find the code at:
> 
> https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025

For the whole series,

Reviewed-by: Tao Su <tao1.su@linux.intel.com>

> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (4):
>   i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for
>     Intel
>   i386/cpu: Mark CPUID 0x80000007[EBX] as reserved for Intel
>   i386/cpu: Mark ECX/EDX in CPUID 0x80000008 leaf as reserved for Intel
>   i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
> 
>  target/i386/cpu.c | 83 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

