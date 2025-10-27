Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E1CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJyz-0008VP-15; Mon, 27 Oct 2025 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJyw-0008VE-Na
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:57:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJys-0001w9-1b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761559058; x=1793095058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IYai5m1YVZem9EfY0nEuzzJKBLzA7AeCEofC0v8Vq4o=;
 b=hfDZ2aBrHrq6crR8rfNjkUdtLLGo6KhGfjAipap8kAAYV0kNLBDn8Y5g
 GkD0VdTAJtNhtb0n4XTgVBkFz+6EuA1XfesQa/Iz4TYInxVToY70tzvC/
 Ai00AI0mr/KvUCd/ENIPz5oAoTwd9X5YnCgxkaTa9plUEZaurM/JUHYj+
 fzFqdY7pShvIFToGEvn7rHXhroT3c3AY7WWFuH3gPxi202YACedYNQeNe
 k4KI8RQsor9OEAxpHEUlj3r94x3DRAtv0oQjKTy8DT3VVtLL+Vqomu162
 EiCtz/aiaTTngXMroCaHMSpF7V6EyPQYrjU7Bu/VACAoDnSr6Onkbr5OO w==;
X-CSE-ConnectionGUID: T6ycS0SMSNasT+HGH2B0zA==
X-CSE-MsgGUID: 2a98JFzJSMOTrUZ5pIDm9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74977785"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="74977785"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 02:57:34 -0700
X-CSE-ConnectionGUID: 81XN1JpNSr2gwGhIinUWeg==
X-CSE-MsgGUID: /BRy8T5yT62AIzTWs7e5cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184229168"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 27 Oct 2025 02:57:31 -0700
Date: Mon, 27 Oct 2025 18:19:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
Message-ID: <aP9HPKwHPcOlBTwm@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
 <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc79cc8-f932-4025-aff3-b1d5b56cb654@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Though the feature expansion in x86_cpu_expand_features() under
> 
> 	if (xcc->max_features) {
> 		...
> 	}
> 
> only enables migratable features when cpu->migratable is true,
> x86_cpu_enable_xsave_components() overwrite the value later.

I have not changed the related logic, and this was intentional...too,
which is planed to be cleaned up after CET.


