Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E91CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRdt-0005iq-Nh; Mon, 25 Aug 2025 03:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRdr-0005hk-PE
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:29:23 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqRdn-00028s-GC
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756106959; x=1787642959;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4qIvf1l0O4xYi292IQ3loMG2/GghOIEulhJmAivyYVE=;
 b=SWgRKxNd4NJIiiVoWNTg/ND2wkqUPd6MYpuFEJ3CK4KlpXL5g7jWyIKu
 +2uo3cHZr01N887yNTmsJ5foaWYnf6f1bNkKfzpkCcqQv1sAC+b1Qk5lH
 +RL7B25WNR/l+TAqaIVJzZlITTfP+W6TsXzSgsNZMxFWxJOXF6usbYfgQ
 BxcWuh3W2gay0Mv6Sr+nvx9Bk9CvmoIQitHHaq56OFkOC72teXU5TawkM
 6AG3yoKe611wIRJOaF+NtW/rRExvyPDaJ0WoWm4oSTZTGEdt8IkSrMypP
 3rXk/fTWJLhecxRk4c5DgFWPx8f29bWVvWzHJMO8s80d2cKVfY8K/+NV9 Q==;
X-CSE-ConnectionGUID: k3hT8fwJSFW5NpsRVeJGMA==
X-CSE-MsgGUID: G2lghB25Q72UaNapq/Vzdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="80905145"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="80905145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 00:29:15 -0700
X-CSE-ConnectionGUID: bXWW9zw0SHGIP5CfOIwL6A==
X-CSE-MsgGUID: CTuZ3RKyT7OTSX8X/7FgUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="169597663"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2025 00:29:14 -0700
Date: Mon, 25 Aug 2025 15:50:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 08/14] rust: qdev: add minimal clock bindings
Message-ID: <aKwV49H1RE31Bue5@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 22, 2025 at 02:26:49PM +0200, Paolo Bonzini wrote:
> Date: Fri, 22 Aug 2025 14:26:49 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/14] rust: qdev: add minimal clock bindings
> X-Mailer: git-send-email 2.50.1
> 
> Add the minimal support that is needed by pl011's event and tracepoint.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+) 

...

> +    pub const fn get(&self) -> u64 {

get() sounds too general for Clock obj...maybe get_period()?

> +        // SAFETY: Clock is returned by init_clock_in with zero value for period
> +        unsafe { &*self.0.as_ptr() }.period
> +    }

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


