Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E20CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE7wS-0002Qk-Bt; Wed, 29 Oct 2025 11:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7wQ-0002QB-4x; Wed, 29 Oct 2025 11:18:26 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vE7wI-0006LF-A2; Wed, 29 Oct 2025 11:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761751099; x=1793287099;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8gnk/JL9+0eiIcvncW15/r0QIK0NWbFUOmXoj2Ye8kY=;
 b=QQzjZK4skYQag37jpVKlYJgku+tLAjYYKLDXisS7OuoQU1a9oDs1WHe2
 mK2r2mS69qIdhbU3wJQPaB74KuzkJmZqPXXDFiCK+eeqcOCExGCGmrisg
 sZhWBedNF/lgOe0cY/ZvGBxTHeqadLvQccmcs/9vrzwjN+gZwMcHcyu7K
 FuletAkHXXUooSxYGwgGJvnyt3eTvmGHYhI2Gy7n2Znp2+evCdR5bem1a
 TNKs+9LsvrH4uIBEuH8sA9FzeC2hMQ2eDv3NxcgLWnRQ8Iv21E5l02Y3F
 iWA169JJalmSe0kuulX5DRUFMaCo+8QYQ3p/3aImNzk7aeLVFQKo0vFX1 A==;
X-CSE-ConnectionGUID: UPqrWcJPSbiCmLSUeDEYmQ==
X-CSE-MsgGUID: QY4at45MRGy8HWSWlXFpWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63915906"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="63915906"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:18:10 -0700
X-CSE-ConnectionGUID: DWtbGhXeSWm5tdqGDD5wnw==
X-CSE-MsgGUID: dAW/SJ/cSWqhcvqpMB0hFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="190866879"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 29 Oct 2025 08:18:08 -0700
Date: Wed, 29 Oct 2025 23:40:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Chen Miao <chenmiao@openatom.club>
Subject: Re: [PATCH] rust: migration: allow passing ParentField<> to
 vmstate_of!
Message-ID: <aQI1ZCwbp3mkIzs+@intel.com>
References: <20251028113821.1736215-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028113821.1736215-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Tue, Oct 28, 2025 at 12:38:21PM +0100, Paolo Bonzini wrote:
> Date: Tue, 28 Oct 2025 12:38:21 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: migration: allow passing ParentField<> to vmstate_of!
> X-Mailer: git-send-email 2.51.1
> 
> The common superclass for devices could have its own migration state;
> for it to be included in the subclass's VMState, ParentField<> must
> implement the VMState trait.
> 
> Reported-by: Chen Miao <chenmiao@openatom.club>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  roms/opensbi                  | 2 +-
>  rust/migration/src/vmstate.rs | 3 ++-
>  rust/qom/src/qom.rs           | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/roms/opensbi b/roms/opensbi
> index a32a9106911..43cace6c367 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
> +Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20

nit: rebase error?

Others,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


