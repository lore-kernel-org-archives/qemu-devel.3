Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB273CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwavO-0005YT-Ln; Thu, 11 Sep 2025 02:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwavN-0005YK-D5
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:36:53 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwavL-0004L1-33
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757572611; x=1789108611;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SFjXu4jtWiYrb85YbhI4kbzDr5NlRt4W0KReEB6xbLg=;
 b=TSVp/i/P1D81kMn3PjQQOX3jwNeRe/j8XHOWLa63JQ6tU7krLFdNqfMW
 CcYRizN0UW4dVKgnErW60afLvhE3WdDO0iJzttVKycaLdeqkELA3GL1UQ
 tfwCFPJtrruI+KTnZR1frxKnUVVkEMIoEm1t7JZDDb/fOscI0AwGn2DH/
 ybdH58qLAbGgxbSjVRhEXx2IVQbG8BgYwq2BHQZNsBzeT4D4dYaAdjYbX
 x7HrXrZbGYGF65Tz7akQBOaQDWjaBepkZXxcJ5fU6/NyR6F/93P934/I3
 RPxtHyDtzVqZkP1N8tHP42zKvTYpbX20+AXswSKkySFc3po7NkuQNLVvF g==;
X-CSE-ConnectionGUID: AQHmoBD2S2mIXKQ+l2kO0A==
X-CSE-MsgGUID: CAwyH+mpS8SQuaFw+TKxeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71318792"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="71318792"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 23:36:48 -0700
X-CSE-ConnectionGUID: wNjbOVTqRE+1sXRvdtVejg==
X-CSE-MsgGUID: iYczTH9DTruZ8GGbwKYoCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173168001"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Sep 2025 23:36:47 -0700
Date: Thu, 11 Sep 2025 14:58:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 06/33] rust: add qdev Device derive macro
Message-ID: <aMJzHysK/cN3wDHX@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:38PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:38 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/33] rust: add qdev Device derive macro
> X-Mailer: git-send-email 2.51.0
> 
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Add derive macro for declaring qdev properties directly above the field
> definitions. To do this, we split DeviceImpl::properties method on a
> separate trait so we can implement only that part in the derive macro
> expansion (we cannot partially implement the DeviceImpl trait).
> 
> Adding a `property` attribute above the field declaration will generate
> a `qemu_api::bindings::Property` array member in the device's property
> list.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Link: https://lore.kernel.org/r/20250711-rust-qdev-properties-v3-1-e198624416fb@linaro.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs  |  31 +-----
>  rust/hw/timer/hpet/src/device.rs  |   6 +-
>  rust/qemu-api-macros/src/lib.rs   | 152 +++++++++++++++++++++++++++++-
>  rust/qemu-api-macros/src/tests.rs | 111 ++++++++++++++++++++++
>  rust/qemu-api/src/qdev.rs         |  70 ++++++++++++--
>  rust/qemu-api/tests/tests.rs      |  24 +----
>  6 files changed, 336 insertions(+), 58 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


