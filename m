Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CDFD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oT3-0006hi-UF; Fri, 18 Oct 2024 11:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1oSe-0006YM-Rg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:00:22 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1oSd-0004Kq-5f
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729263615; x=1760799615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7D+Bj5PNHOB883QSjDLZqfMriO6Yk4rxdlZDcMgxIr4=;
 b=nfznYKB7hmoF0ALZ9lGAyLwPPZYcnaDWqC4jB1yQKTVI7O2dC6Ajr0w0
 UCWahEdAMDc7MJaMt+swpLiHi5Dr3+Dk9qnsvl272IgnG8Wd+JMZtLENs
 fWCSCnrzVbyHXgt1SLxg7BNJq3ZrHPDcdvBIDXFNBRDIVkfqf5ovAvhHZ
 DxjYLIs2FKpKd6WV7j9gx46hLjjILpy7a4+WRMKn0YMsGKjMb5QOWaEs2
 O3CZp8ln9UcuMSC/qqSdkdfHDPm8C15lNQTbrx0U4LX7siFytQtIJjSqy
 0Bfz0CCnL/ZVUbVVX2EZ4ZunZt/D1JkaBR4QUVAbm+jWLtxKNgmHKMFZZ g==;
X-CSE-ConnectionGUID: g3n3x2LZTvyiutT7LLkwFA==
X-CSE-MsgGUID: hWDyV5peQn+kIcx7u7eZpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="29006219"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="29006219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:00:08 -0700
X-CSE-ConnectionGUID: JjVkaXpESt2J0hc1zgAh2A==
X-CSE-MsgGUID: ntsVYkaZSHKdd4V2zM9yFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="79234532"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 08:00:06 -0700
Date: Fri, 18 Oct 2024 23:16:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/16] meson: remove repeated search for rust_root_crate.sh
Message-ID: <ZxJ7xb0l8igb2bjP@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, Oct 15, 2024 at 03:17:20PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:20 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/16] meson: remove repeated search for rust_root_crate.sh
> X-Mailer: git-send-email 2.46.2
> 
> Avoid repeated lines of the form
> 
> Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)
> 
> in the meson logs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


