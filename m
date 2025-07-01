Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B66C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZth-0007x9-5h; Tue, 01 Jul 2025 08:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWZte-0007vd-KR; Tue, 01 Jul 2025 08:15:34 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWZtY-0004dL-NO; Tue, 01 Jul 2025 08:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751372129; x=1782908129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+8OWmjwP/2bYJlYBUultibyNB+P9/EIDBMLVEEFej3o=;
 b=j6JdgQot3ma8nmye267WcyuEicVTcYBmTdbRTVo7PNDqFxJEcvGVeYbN
 yNTPMByIkDJuLz+Ipg4oCIUyX1W2RoHLcmIciNhyLpJsjoqPV2mPCaZzu
 P7LkSF75pT9oXCvZ3Xd7l23gmlEGpFEruvLH00Ft1APJSkCAKw1z0IsWN
 oQvV53aNj1tLkmqE0bIt75cTdu4aYDoqeCsKe0meEC4HajPXPEa3reJeb
 Rifz2AanqcrQJdTVf3S8XdmaFjc8JGpyYx2vQXiMK+admqzerRlnEsJdD
 WHRQrgSEDsvO8452NQcN2CvgKhi44tTOpYsL8STRa1i/Qje4LxlXAJ2Ws Q==;
X-CSE-ConnectionGUID: vP44EOncThe/oNddYQSitQ==
X-CSE-MsgGUID: QQi7W5rpRFiKhJQZ9hVUKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57314838"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="57314838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 05:15:21 -0700
X-CSE-ConnectionGUID: RPuwhi74RuaLHkGVvKCWPA==
X-CSE-MsgGUID: t/tWrUs9ThG5f4jyYfWgZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="153530875"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 01 Jul 2025 05:15:18 -0700
Date: Tue, 1 Jul 2025 20:36:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGPWW/joFfohy05y@intel.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Tue, Jul 01, 2025 at 07:12:44PM +0800, Xiaoyao Li wrote:
> Date: Tue, 1 Jul 2025 19:12:44 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised
>  on AMD
> 
> On 7/1/2025 6:26 PM, Zhao Liu wrote:
> > > unless it was explicitly requested by the user.
> > But this could still break Windows, just like issue #3001, which enables
> > arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
> > turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
> > value would even break something.
> > 
> > So even for named CPUs, arch-capabilities=on doesn't reflect the fact
> > that it is purely emulated, and is (maybe?) harmful.
> 
> It is because Windows adds wrong code. So it breaks itself and it's just the
> regression of Windows.

Could you please tell me what the Windows's wrong code is? And what's
wrong when someone is following the hardware spec?

Do you expect software developers to make special modifications for QEMU
after following the hardware spec? Or do you categorize this behavior as
paravirtualization?

Resolving this issue within QEMU is already a win-win approach. I don't
understand why you're shifting the blame onto Windows.

> KVM and QEMU are not supposed to be blamed.

I do not think I'm blaming anything. So many people report
this bug issue in QEMU community, and maintainer suggested a solution.

I totally agree on this way, and provide feedback to help thoroughly
resolve the issue and prevent similar situations from happening again.

That's all.

Thanks,
Zhao



