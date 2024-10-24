Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FEECE8E97
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41JM-0000kK-96; Thu, 24 Oct 2024 13:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t41JJ-0000k0-Fp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:07:45 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t41JH-0004gA-1Z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729789663; x=1761325663;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=knsSR+jAnM7fdHTlma4V8oL/4z0AMSZl+6u8kQ0cERg=;
 b=ORdYpW5w7Gz1Vls7RQAc0HkTzTbvLjXhf9SThHGGUFobMVcr7V6utFgd
 sz2/OaaKWhggoLk5i/eUD6q2dq+wci77nNVAV0S1YaS2NV071NJQHDOnK
 frQ9GU5r4LY6uBFqTAv6yuw05g9siP7/2nfW5lBuSoSQYStsLWKRtCwxD
 bf6a8Ptrh6uTexnINYsDeXaGWJ9vu2Z4OiWSLyJ2sm7PN80BMGt9W+hPw
 E6zBJ71n4oIljtKKwBASrIaMDN+p3HD5Khuvb//0k85+iL8+QcT1txXQV
 h2tq/uZaspGTlth7Wz8mBSrxKjq0f9SGJS0x6uaOrPlOT+gKG47DdyI/b w==;
X-CSE-ConnectionGUID: OgbGGD6wTBOnw+3yNJhDIQ==
X-CSE-MsgGUID: HZZLyNglRcqym3resQPKaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40024693"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; d="scan'208";a="40024693"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2024 10:07:39 -0700
X-CSE-ConnectionGUID: B2AOYiPLQACAEZK0CaSSvA==
X-CSE-MsgGUID: D/8+G6BtQ5W42/DwtvJFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; d="scan'208";a="111456158"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 10:07:38 -0700
Date: Fri, 25 Oct 2024 01:23:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 07/13] rust: build integration test for the qemu_api
 crate
Message-ID: <ZxqCqki2zhb2Gvjz@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Mon, Oct 21, 2024 at 06:35:32PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:32 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 07/13] rust: build integration test for the qemu_api
>  crate
> X-Mailer: git-send-email 2.46.2
> 
> Adjust the integration test to compile with a subset of QEMU object
> files, and make it actually create an object of the class it defines.
> 
> Follow the Rust filesystem conventions, where tests go in tests/ if
> they use the library in the same way any other code would.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                  | 10 ++++-
>  rust/qemu-api/meson.build    | 26 ++++++++++--
>  rust/qemu-api/src/lib.rs     |  3 --
>  rust/qemu-api/src/tests.rs   | 49 ----------------------
>  rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 110 insertions(+), 56 deletions(-)
>  delete mode 100644 rust/qemu-api/src/tests.rs
>  create mode 100644 rust/qemu-api/tests/tests.rs

Ran "make check-unit":

qemu:unit+rust / rust-qemu-api-integration          OK

Tested-by: Zhao Liu <zhao1.liu@intel.com>


