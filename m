Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D403D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjfX-0002lS-6A; Wed, 03 Dec 2025 05:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQjfU-0002kb-Be; Wed, 03 Dec 2025 05:01:04 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQjfQ-0002Of-BE; Wed, 03 Dec 2025 05:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764756060; x=1796292060;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ku70nufJQx0eQBUG06gbsOebWWRJL5iKL0yAKzmgETM=;
 b=jeY3iv3XixmPkAvST2NQwpXv67TNNdXgZiLDCqUe7zEbNiy6ivLgHnK0
 pTO4/ItnMiwN/kRXttMPh3mYb9IQiPXzVNl4F31PqyANXcT2LvGQOpFwM
 fYrNHbrKZEg6ZDxTdpS1462Qeqbs04XQrjZlbchHUZkre6/rvorbU+Xwp
 NRof7fJi6VGosi3ZTjr6R1zIaKnfSmRaWTtIA6NNMgdGQ3tnFidvnd2ER
 S6NsQcTW2eJG27N3m55A9aBlMvT1FFe6M9QjyxPF/7VtbkQTOqoj62+6F
 tTxnyK8ewsJh2xIHJt1CktqzSmSjJ6FNihqj8VjeDu6TvUisfc9j45cz8 w==;
X-CSE-ConnectionGUID: 91VGYHYbQk+8LJ4s2/QrXg==
X-CSE-MsgGUID: ZIhWjLlnSmua5NH6wSUFMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66909002"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="66909002"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:00:56 -0800
X-CSE-ConnectionGUID: 5HfLKTtzQQ6LZquzi3jj+Q==
X-CSE-MsgGUID: KkCaO/uYTjGtR+l+7FHmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="194535386"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 03 Dec 2025 02:00:54 -0800
Date: Wed, 3 Dec 2025 18:25:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/9] rust: remove unused --cfg arguments
Message-ID: <aTAQIb2pm1Ozau5J@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Nov 27, 2025 at 02:20:29PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:29 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/9] rust: remove unused --cfg arguments
> X-Mailer: git-send-email 2.51.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-macros/meson.build                                 | 5 -----
>  subprojects/packagefiles/bilge-impl-0.2-rs/meson.build       | 3 ---
>  subprojects/packagefiles/proc-macro-error-1-rs/meson.build   | 1 -
>  .../packagefiles/proc-macro-error-attr-1-rs/meson.build      | 3 ---
>  4 files changed, 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


