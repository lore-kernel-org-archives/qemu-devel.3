Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C51AD68BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7tv-0004Um-9A; Thu, 18 Dec 2025 01:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW7tu-0004Sc-DK; Thu, 18 Dec 2025 01:54:14 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW7ts-0000aa-Tk; Thu, 18 Dec 2025 01:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766040853; x=1797576853;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZB4ZU7ml6vgpu7Yu6GFeyg/UyU/aZ2mFDMJjxmBM/Eg=;
 b=KesECpLXEYbf/iVgiJ/IZi0JzQIfzwVH9bSlzqiAzHG597IDGVA73HH1
 IUcKBWl83QJkrYKA/Fm/KKJ69CpQLkUvVTv99LSeBGqASxmbUG8+0wkPq
 iAtHjypBccICQ4krCcglmIMs6uD5VgpmuU/90dCreUbKh5d6mC6nscwBX
 ++ROU0IBMdzGFklR5RKBrqT+L7G8zY2pCwUc5YhnmTg5etAgQOA1i8vqK
 H1Jq/c0Dmi1AHkgBVp1WQnGfdrSPYLAtRag/6Xsp3IvlfKyc7Ei8WVCVV
 b/WqoP2tdGRY/xbe2h+CnuhTjwLXEWbtZVOUf4KZ5sRea5VACPRJhQhxH Q==;
X-CSE-ConnectionGUID: WjJc5LQiSGmYcLMaQOO+Qg==
X-CSE-MsgGUID: C7g/kPofT3q3Y1JI+ntE5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70564841"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70564841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:54:11 -0800
X-CSE-ConnectionGUID: RG0V+tjiROSxSvNfmjsICw==
X-CSE-MsgGUID: VzVjqmEmQQqWoDoDI0Ayhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="198586094"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 17 Dec 2025 22:54:08 -0800
Date: Thu, 18 Dec 2025 15:18:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: Re: [PATCH 03/11] bump meson wheel to 1.10.0
Message-ID: <aUOq4aW7RJ0uZjb3@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 15, 2025 at 08:49:52AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/11] bump meson wheel to 1.10.0
> X-Mailer: git-send-email 2.52.0
> 
> This version includes several improvements and bugfixes for Rust.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                                   |   4 ++--
>  python/scripts/vendor.py                    |   4 ++--
>  python/wheels/meson-1.10.0-py3-none-any.whl | Bin 0 -> 1057029 bytes
>  pythondeps.toml                             |   4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 python/wheels/meson-1.10.0-py3-none-any.whl

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


