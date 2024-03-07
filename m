Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D37DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDWu-00079d-1j; Thu, 07 Mar 2024 08:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1riDWi-00077n-Qi
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:11:13 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1riDWg-0002Qh-6I
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709817070; x=1741353070;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4wWbKFxPaspCb29yzhUTh9XUbtln+fvz2AzTl5umSWg=;
 b=dvzM66iRNEGjFbwUlF3tlVlRvzsXYWjA/KdgtJz/EHivkPTDJB3ODLpy
 UTZnE2hRaczYGDun+tWg9YqOqPBBBQY7FNJZjEFSoghbNSDI7Cv8YmSJA
 AvrKMyKdjkmRbRTeELwc2iEzr6AP1jdi4gfFCGw1Vculw6iGBBXGzyQL7
 7l5aR4zfJN91yqFV0d3O59eWKZ5BUn7DZm9rD5qzCrjE2hPILKmlarAwU
 3rEPYnUl8QTO2HCIwPAM6zpATm9rMmaom0QzdkG32Wev5Jp+jSkn3WF2N
 7bvVbf5tJhNn81BWr0Lz7kR8PCeR7GFBxHRdYRI0L+u+TR4e84hMPh57T A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="22006089"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="22006089"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 05:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="10081841"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 07 Mar 2024 05:11:04 -0800
Date: Thu, 7 Mar 2024 21:24:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v3 3/3] docs/system: Add recommendations to
 Hyper-V enlightenments doc
Message-ID: <ZenAISwKs3BQCp/y@intel.com>
References: <20240305164204.525575-1-vkuznets@redhat.com>
 <20240305164204.525575-4-vkuznets@redhat.com>
 <Zel7612e3rSgcBjv@intel.com> <87sf12l6h3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf12l6h3.fsf@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> Hyper-V is a role you can enable in various Windows versions, both
> server and client. When enabled, you get a hypervisor (which is called
> 'Microsoft Hypervisor' as I was told) and your Windows becomes the root
> partition (similar to Xen Dom0). In case you run this on KVM, Windows
> becomes L2. Hyper-V enlightenments provided by KVM/QEMU are consumed by
> the hypervisor then.
> 
> Note: Hyper-V role is optional, in many cases Windows guests run without
> it (no Hyper-V VMs, no WSL2, ...) and thus consume KVM's Hyper-V
> enlightenments directly, no nested virt involved.

Thanks much for your explanation!

Regards,
Zhao

