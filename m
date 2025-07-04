Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A35C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXf0H-0001yZ-Ry; Fri, 04 Jul 2025 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXf0F-0001yF-HJ; Fri, 04 Jul 2025 07:54:51 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXf07-0007b9-M2; Fri, 04 Jul 2025 07:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751630084; x=1783166084;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nHxLZnRJULJ8wMclJBaqK/qYsk48uSA1nXCIP1o+Rt4=;
 b=lHes/0V8b6Au74srp8ghe5RagBLqJKQhaIuikhA3rKZr9tFsZ+dR0hzW
 MKXMnWEXQ3CUAAk9Yzv+Wzn8bXQ2l76EtzEBIHEKLDqZ9hnQdmaW7HPwH
 x9NOM9r7onkTJIyqQ+DnsrxGqHz6G5051zYSqc816YcgXUxqMGfI0lxZK
 obJbknljB2gJkypcwj2IM7nac8L7QiqfPLNjiZjedg2wIpBGKe1BH59Z9
 Nlj0WPjpEsWB+DHnfb+ubD6wjlS+g7jl7QGCir47TnmMs/aIxB3SXIizI
 3QjzL+1jz4/S3rrHLGSCOh9H6XLFhtps4qru52LiTlZzfMOJvl523b3yD Q==;
X-CSE-ConnectionGUID: STmvupqISEK2Qly0Nj4HJw==
X-CSE-MsgGUID: JMAHGwGCSQSUI+f0dTwVKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71401185"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="71401185"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:54:38 -0700
X-CSE-ConnectionGUID: LHm9fgjHQaSjCvTq5KlNqg==
X-CSE-MsgGUID: BdQX2OQaQAK5kQq1Y4QOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="158658098"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2025 04:54:35 -0700
Date: Fri, 4 Jul 2025 20:16:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] rust/qemu-api-macros: normalize TryInto output
Message-ID: <aGfGAcebpPS4UV3x@intel.com>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
 <20250704-rust_add_derive_macro_unit_tests-v1-1-ebd47fa7f78f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-1-ebd47fa7f78f@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 04, 2025 at 01:26:57PM +0300, Manos Pitsidianakis wrote:
> Date: Fri, 04 Jul 2025 13:26:57 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 1/2] rust/qemu-api-macros: normalize TryInto output
> X-Mailer: b4 0.14.2
> 
> Remove extraneous `;` and add missing trailing comma to TryInto derive
> macro to match rustfmt style. We will add a test in the followup commit
> and we would like the inlined output in the test body to be properly
> formatted as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/qemu-api-macros/src/lib.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


