Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKuD-0006q4-VP; Mon, 27 Oct 2025 06:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKuB-0006nF-U2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:56:52 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDKu6-0004YG-TX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761562607; x=1793098607;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tBi0DDOGa1sTaTA9yS+f/khOO57uDsMBL7lkmcWwF84=;
 b=d4sEnyJb0rSFJmOav70PWUNbUdBseOclAtY5RZvl5BLzax3W0sJ5uPfU
 C4TF53WALjkrVHhqOmnZ+TXTa9xqYV554Ahm2tN/I3tGwI/KeyDXPXT+9
 m61zeOf8AvwLOmcaBY71CITON6WdtP6JN6g39lMfnYiBYQW0D9eXgykqZ
 yJXQg5ONa/is5APfCyTyQpFi24MAxT37v9ZbB1NsgPbri6aJlbHaE2pBl
 juIrBESttq8rElReHqivfIcKlcYP6ydooLVTBoBApzFeDmYwRKH9PS/Ps
 DUav9Qej1p2Y3FuYSfqGvJTh0Ekev6s4InGiozfPEP1WeNWx9B6wweqYx A==;
X-CSE-ConnectionGUID: ec/gtVWgRe60JHg48vzntw==
X-CSE-MsgGUID: +pxuqcRfRuOEW/Fznzo3SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67281303"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="67281303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 03:56:41 -0700
X-CSE-ConnectionGUID: C0KV7ngJTDyAD1zQ6vTykQ==
X-CSE-MsgGUID: 73+ArOTiRlu8W1oS+/dCIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="222224397"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 27 Oct 2025 03:56:37 -0700
Date: Mon, 27 Oct 2025 19:18:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
Message-ID: <aP9VF7FkfGeY6B+Q@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
 <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com>
 <aP9HPKwHPcOlBTwm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aP9HPKwHPcOlBTwm@intel.com>
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

On Mon, Oct 27, 2025 at 06:19:40PM +0800, Zhao Liu wrote:
> Date: Mon, 27 Oct 2025 18:19:40 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave
>  features
> 
> > Though the feature expansion in x86_cpu_expand_features() under
> > 
> > 	if (xcc->max_features) {
> > 		...
> > 	}
> > 
> > only enables migratable features when cpu->migratable is true,
> > x86_cpu_enable_xsave_components() overwrite the value later.
> 
> I have not changed the related logic, and this was intentional...too,
> which is planed to be cleaned up after CET.

There's only 1 use case of migratable_flags, so I would try to drop
it directly.

The xsave-managed/enabled feature is not suitable as the configurable
feature. Therefore, it is best to keep it non-configurable as it is
currently.

At least with this fix, the support for the new xsave feature —
including APX next — will not be broken, and the migratable flag
refactoring will become a separate RFC.

Regards,
Zhao


