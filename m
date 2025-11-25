Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF60CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnEC-000088-Fd; Tue, 25 Nov 2025 02:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNnEA-00005z-Sa
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:12:42 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNnE9-0002E2-4W
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764054761; x=1795590761;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lzKIqHyFUoXe+3USKF4N2UGIfvhfHjMQu6idMswTilU=;
 b=MUXQu8Kx74xOsGFzqeDjLDpVgKEdhEI28xvKQyUr55wRaxHHOQK3ED57
 3I89W3qSDhVfL+SpesGkyG6sBrzwCEeKF2bteGXEwG6XH6V6g5n7cojue
 KFJ5vxciSNG/ahwKErHa3VAsAZVsJkvVNOgwlMZlXOLBjiAaAeICrEW/h
 v1geUKOQVFCO8B7FJ1v6ptPP1m03COQ/FdPjUJBkAlhxFoZLumK4hZQa/
 ZZU69Q0/TuCe018PCZjETrvZrpeyqxVwfJ6fGQMXIc4eJJpkEwDNy4GJq
 bf1MXwJ2u8qIMZfqYZEy+H5r+PNwkhm5QqiUBR/5bzc+7uddeBFHGYJkO Q==;
X-CSE-ConnectionGUID: g8rrvikZTKK8N2ioT2jTVQ==
X-CSE-MsgGUID: L7DWLk2hTT+6fbuNbC+4MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69922431"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="69922431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 23:12:39 -0800
X-CSE-ConnectionGUID: xieMMJVwTjCpztmjV4OSBA==
X-CSE-MsgGUID: HjId8EghTaeuwzA5sKKuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="192200986"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 24 Nov 2025 23:12:37 -0800
Date: Tue, 25 Nov 2025 15:37:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v2 1/4] target/i386: Add an option in X86CPUDefinition to
 control CPUID 0x1f
Message-ID: <aSVcrBGfR6WlnsMB@intel.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-2-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027102139.270662-2-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On Mon, Oct 27, 2025 at 06:21:36AM -0400, Ewan Hai wrote:
> Date: Mon, 27 Oct 2025 06:21:36 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 1/4] target/i386: Add an option in X86CPUDefinition to
>  control CPUID 0x1f
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Many Intel and Zhaoxin CPUs enable CPUID 0x1f by default to encode CPU
> topology information.
> 
> Add the "cpuid_0x1f" option to X86CPUDefinition to allow named CPU
> models to configure CPUID 0x1f from the start, thereby forcing 0x1f
> to be present for guest.
> 
> With this option, there's no need to explicitly add v1 model to an
> unversioned CPU model for explicitly enabling the x-force-cpuid-0x1f
> property.
> 
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Thanks! I also mentioned this in my series:

https://lore.kernel.org/qemu-devel/20251120071030.961230-8-zhao1.liu@intel.com/

Regards,
Zhao


