Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA2D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjqr-0001fW-VI; Wed, 03 Dec 2025 05:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQjqq-0001eT-L3; Wed, 03 Dec 2025 05:12:48 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQjqo-0006t2-Re; Wed, 03 Dec 2025 05:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764756766; x=1796292766;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FkEWYu/LFqLXmzn8xqFCuuGWPigZO4lD3Iq7Kru3ZV4=;
 b=GTyXbuEBjZYS+cAFyk+1tHXV03xyj9YHS8Rvd2rtIB30Ud1Qy0J/g5RB
 E0XeZMiT8oDF8ENaDdXCUckOoUDcjDm+kHCPC0doMq3ep0aEuSi/avzSC
 UZYXf9OfBeFGC2u3FN+M8L/ae5qIBkj9S9U3u28iejfuLwKvlXOFRByhx
 30/xRwtJi0k9Yghhv7rJGauRWK8emne8++2Tc/xwuSTalW52A2d1CI0fR
 bG/DQtjtJjj/8MuxjwQfNFOQctSho4MiaSrpNC9moLPfs5iBn3Ci/+nRk
 mN0mRXItmP0rbsNqHKR0/kPALSV3kTmLHN4lCB4EV1Vn/p6RMLgumWcPa Q==;
X-CSE-ConnectionGUID: b/jR1+EERrOcsoAuUxf4VQ==
X-CSE-MsgGUID: LzYuDfZgQS2pILnahAg+/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="78093266"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="78093266"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:12:43 -0800
X-CSE-ConnectionGUID: ZttNxyiyS6qwtfWciAW/JQ==
X-CSE-MsgGUID: cf/i6aevTl2QppZVYXHW/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="194317330"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 03 Dec 2025 02:12:42 -0800
Date: Wed, 3 Dec 2025 18:37:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/9] rust: remove unnecessary repetitive options
Message-ID: <aTAS5TgA3Xc9pCsu@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-4-pbonzini@redhat.com>
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

On Thu, Nov 27, 2025 at 02:20:30PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:30 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/9] rust: remove unnecessary repetitive options
> X-Mailer: git-send-email 2.51.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                  | 3 ++-
>  rust/bits/meson.build        | 2 --
>  rust/bql/meson.build         | 2 --
>  rust/chardev/meson.build     | 2 --
>  rust/common/meson.build      | 2 --
>  rust/migration/meson.build   | 2 --
>  rust/qemu-macros/meson.build | 1 -
>  rust/qom/meson.build         | 2 --
>  rust/system/meson.build      | 2 --
>  rust/tests/meson.build       | 1 -
>  rust/trace/meson.build       | 2 --
>  rust/util/meson.build        | 2 --
>  12 files changed, 2 insertions(+), 21 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


