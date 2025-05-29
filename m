Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A00CC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZ41-0004HT-U3; Thu, 29 May 2025 04:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ3v-0004Gy-OV; Thu, 29 May 2025 04:56:32 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ3t-0007Dc-Uy; Thu, 29 May 2025 04:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748508990; x=1780044990;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xtEbzCcTI3hVbsmBYdip6ySQLmJrRgMJIuV4q/yrNr0=;
 b=IDI/DfoG4tWlc85aiBfea6kfE6Gk3293NbpnFFD7aD4SSSHFyC4+si8e
 2gOfUir+wIabvMyvHAbeHUQhIDnrdHAoHBNsRamzuT9fJJtARZ37MOnpP
 DYAZSk4oqgzpKeDkKyOYRCqUveL41DHQI3S82FaLJhaNEA+PIifkwc6fa
 JwZJ+4AeqA5CUzXZRxDxireYY1FBYaTT7tDLlyXS8c3C8OhD0HxX1OyWe
 1+1WVkJq+28pHNCW17eKrjGWyE8CRqzxBr3h8D5nPCqaTDlZscBJqgF/n
 QEcxQQ2Q58qOkhfXlbGH8a28EaFhsiBmJfx7sm8Vq3bqWWiWcdEWMHVsv Q==;
X-CSE-ConnectionGUID: RUOwYm/3QNeIgJXZ8D1aCg==
X-CSE-MsgGUID: sFloz1TtQdWnw6owtuTHMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68111389"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="68111389"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:56:27 -0700
X-CSE-ConnectionGUID: g+H8rcs8QjWE/HomikEuNQ==
X-CSE-MsgGUID: DZ6pXR7WS1iTLTm7NI+08w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174376829"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 29 May 2025 01:56:26 -0700
Date: Thu, 29 May 2025 17:17:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 12/12] rust/hpet: Drop BqlCell wrapper for num_timers
Message-ID: <aDgmMPtd6pw3tB5p@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Mon, May 26, 2025 at 04:24:55PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 12/12] rust/hpet: Drop BqlCell wrapper for num_timers
> X-Mailer: git-send-email 2.49.0
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Now that the num_timers field is initialized as a property, someone may
> change its default value using qdev_prop_set_uint8(), but the value is
> fixed after the Rust code sees it first.  Since there is no need to modify
> it after realize(), it is not to be necessary to have a BqlCell wrapper.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Link: https://lore.kernel.org/r/20250520152750.2542612-4-zhao1.liu@intel.com
> [Remove .into() as well. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/hpet.rs | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)

Thank you! Now we're finally here.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


