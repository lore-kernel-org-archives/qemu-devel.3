Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D43C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHNO-00064l-6c; Thu, 20 Mar 2025 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvHNK-000638-Lp; Thu, 20 Mar 2025 11:00:02 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvHNH-000279-1F; Thu, 20 Mar 2025 11:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742482799; x=1774018799;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=E4XrqLXbdLYm9NmY66jv9lxKr6RDfqS3tVB23LeDES0=;
 b=FibDQDoi03RLotcKuTVktsvVV/VkcVSaZ1SGD5vySgWn8kiq4NlOVnBD
 g139ysyEfStVyEU2H5tf2k07Cnldu1xdF5YbS/+N8/IKHd/F4UVjHX1al
 NIJfCUE1JDmE+dOfChfFtr797PrsdMt6eCa+On91ERgm7wrMJYvuiCFx1
 T2bUDjOu48zG9VZFg117Frf1YDM23CR0/TC3nn7fNZaYg0FjEWWJqs/5Q
 KSfII6c/DSnlUOslh8gf3KQ65JkcdqzUwhY/iW6L9VAl94PX41m9g9thw
 5sMtjOi9sAfHIlck68Bji0Xs84nRptFsuXKIKfK/pvp/zwQZTSY6kqlUL g==;
X-CSE-ConnectionGUID: aD1D8ZcGTAO7o50y6gxlXQ==
X-CSE-MsgGUID: s/ny3h6wShmeeAG3/DNFVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53938919"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="53938919"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 07:59:53 -0700
X-CSE-ConnectionGUID: NZGVObiBQhiCMZxi+C1RqQ==
X-CSE-MsgGUID: NW9mP4w+RuqaEVLRYyxbUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="124059939"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 20 Mar 2025 07:59:51 -0700
Date: Thu, 20 Mar 2025 23:20:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] rust: assertions: add static_assert
Message-ID: <Z9wyJWVwSNlAAsNA@intel.com>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
 <20250320133248.1679485-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320133248.1679485-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Thu, Mar 20, 2025 at 01:32:46PM +0000, Peter Maydell wrote:
> Date: Thu, 20 Mar 2025 13:32:46 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 1/3] rust: assertions: add static_assert
> X-Mailer: git-send-email 2.43.0
> 
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Add a new assertion that is similar to "const { assert!(...) }" but can be used
> outside functions and with older versions of Rust.  A similar macro is found in
> Linux, whereas the "static_assertions" crate has a const_assert macro that
> produces worse error messages.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


