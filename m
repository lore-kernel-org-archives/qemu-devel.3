Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3833C0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taaKB-0002qU-U6; Wed, 22 Jan 2025 07:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taaKA-0002pw-70; Wed, 22 Jan 2025 07:59:14 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taaK8-0000kw-OA; Wed, 22 Jan 2025 07:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737550752; x=1769086752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oWOfeYtoPAEzW8Z6IDVJJ/UHz7wmFjuEAjMUPF2/JBo=;
 b=OGx4qzJh6zX8WzSM6q3OjMvYFKInDN8FRrdISY4Ry3yxBtqMRjv9wesh
 aoKCMy0Uj+MXndS+ms9R/z61aW2qeNQQWOCIp4y9kXQj0Qpo4/bD82XfB
 q5xtNKU4FFc44+7OfskM8VboMMr3TwnMfKg+rar6EGZ8l/jweG2lxhztv
 16mIM2vHEaHyJjdXEm8InoenQThBfxLiZbEzhTgfbEyG9j9v/dnQOD+Vz
 h6ttyLrOhutisNZQbmwLrnv1dOYScaQczb2gIMqItHq++elpnUKXJk+su
 +UY4aRmHL8wsnP94vO0hjIxxISij8jb2rdUqR9dC8qXV1ICNmRkwK+4wv g==;
X-CSE-ConnectionGUID: WcArOK8DT16Wc0InvFrQFg==
X-CSE-MsgGUID: hRFq1Nx/RuS0S4JGg3U2Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48668298"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="48668298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 04:59:10 -0800
X-CSE-ConnectionGUID: d8MmLcTESDiEPaoaCjrjow==
X-CSE-MsgGUID: KqfmYJKkRneanSgv4LC2aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="108013505"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 22 Jan 2025 04:59:09 -0800
Date: Wed, 22 Jan 2025 21:18:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/10] rust: vmstate: make order of parameters consistent
 in vmstate_clock
Message-ID: <Z5DwJ+RoAF2yz0Bt@intel.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090046.1045010-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:00:46AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:00:46 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/10] rust: vmstate: make order of parameters consistent
>  in vmstate_clock
> X-Mailer: git-send-email 2.47.1
> 
> Place struct_name before field_name, similar to offset_of.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device_class.rs | 2 +-
>  rust/qemu-api/src/vmstate.rs           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


