Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8642C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5Xr-00051L-9q; Fri, 27 Jun 2025 05:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV5Xo-000516-0T
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:38:52 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV5Xh-0000vB-UD
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751017126; x=1782553126;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TASrzFFKscQb6bswN5PtwZWpTztVqbZpCGl4Q+8knO0=;
 b=hS1Zk78IylH+0LKtgvez+2BixuIDIK2lMvMvXH73PI3xauKj8BFZ2RPv
 IgDnoNrCtSroP9diEQaJX/RvNu9a/pWYaihvi6GFsaTF/68cw1JUuIsh1
 srVCnEAsbU5m6oYf9E35iafS+f0miVwsX+SLuGpaoDt/7m2SdNr/g2G1o
 /Ttpcyz4GqXJ7XiGdJyT7dibvjVb0l6Wd0N6V1sLjnmg+UwS2uwlk1G22
 EOFMok1/PpYWiz/uv18PxW9LaIXpBZgiwVy59xz+fyjWv2qP2TGJ/u50C
 pWBniVmYFI+CNDHNm64fF/VVwPn0HX5lgwIm0K4yDWiBqgR+WF6gwRtn0 Q==;
X-CSE-ConnectionGUID: +0+xa5oWT0qMV/E6lPYcWQ==
X-CSE-MsgGUID: H/x4+wO6TTKIY/l3xykYUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64765846"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="64765846"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:38:42 -0700
X-CSE-ConnectionGUID: u0YrtBQdT1CU8ZIluyYFvg==
X-CSE-MsgGUID: q4v5zntESriqCsHI6IwUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153058431"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 27 Jun 2025 02:38:39 -0700
Date: Fri, 27 Jun 2025 18:00:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>,
 Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
Message-ID: <aF5rokNYB0PKZniJ@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-6-zhao1.liu@intel.com>
 <0d038476-e7c6-4e7a-add2-aeb4d715c202@zhaoxin.com>
 <aF4Kjf7iGhEORMSL@intel.com>
 <22fe027d-b426-4682-aec5-dca12fa15bdb@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fe027d-b426-4682-aec5-dca12fa15bdb@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jun 27, 2025 at 02:48:05PM +0800, Ewan Hai wrote:
> Date: Fri, 27 Jun 2025 14:48:05 +0800
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
> 
> 
> 
> On 6/27/25 11:05 AM, Zhao Liu wrote:
> > 
> > 
> > > After applying these patches to QEMU mainline at commit 6e1571533fd9:
> > 
> > Ah, I forgot I've rebased these patches...Now you can rebase all the
> > patches at the latest master branch.
> > 
> > Or, you can try this repo - I just created it to make it easier for you:
> > 
> > https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025
> > 
> 
> I cloned the repo and then ran:
> 
> $ git am 20250620_zhao1_liu_i386_cpu_unify_the_cache_model_in_x86cpustate.mbx
>

Hi Ewan,

no need to apply any patches on that branch "cache-model-v2.6-rebase-06-23-2025",
since this branch has already contained all my patches.

You could check the git log.

Thanks,
Zhao


