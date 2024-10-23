Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83143CF538B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3brA-0004jw-7H; Wed, 23 Oct 2024 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3br7-0004jl-GN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:56:57 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3br4-000062-Ud
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729691815; x=1761227815;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BILSRExVc2vLKjOp2vU2MfBWTA8vmeeUmVCagSGJ+Ds=;
 b=UMuSZT/Dc8yAtqMIFe4QZdfzN0cMYwWnPJ7j/KpdvQdFxsxhpdi9RErp
 uU79aJvqvAFFPjuFe4R+5adaMoj+lFrH18aUb9yMOzcx2HzF1RADixisV
 Fk5ndXXSK5Fghl4Utw2q6wIvTl4itTWVAl+e7JsOCnAO8n+iGoRaDpevh
 uzkT8zBqoqO2MIs2EtmE33LMSg9SwqBu6/Rn/Vk8wymQGs/8Ppw1F3878
 j4+Rd9lorfWlmla0FI1mTMX+CCRUYQNWkCdS6FxBuSpMhcKp3OdIjOcO0
 xFBY9hkr/eURzuUftSfJ2XbmNXToYXz7OG/P/FSmJLsOKx3t57o4a4A3m A==;
X-CSE-ConnectionGUID: BXx3Yp5cTke2eqlgEeQB6w==
X-CSE-MsgGUID: xS7ULXDSSm6h/bVk485Wsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54683022"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="54683022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 06:56:52 -0700
X-CSE-ConnectionGUID: 9l3SOvbeRaOEggqKodcRzQ==
X-CSE-MsgGUID: uU2NQ5jsQrmwT99CPf8i/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="80617984"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 23 Oct 2024 06:56:50 -0700
Date: Wed, 23 Oct 2024 22:13:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 05/13] rust: remove uses of #[no_mangle]
Message-ID: <ZxkEc5uDFIShBcvP@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Mon, Oct 21, 2024 at 06:35:30PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:30 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 05/13] rust: remove uses of #[no_mangle]
> X-Mailer: git-send-email 2.46.2
> 
> Mangled symbols do not cause any issue; disabling mangling is only useful if
> C headers reference the Rust function, which is not the case here.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       | 5 -----
>  rust/hw/char/pl011/src/device_class.rs | 2 --
>  rust/hw/char/pl011/src/memory_ops.rs   | 2 --
>  rust/qemu-api/src/definitions.rs       | 1 -
>  rust/qemu-api/src/device_class.rs      | 2 --
>  5 files changed, 12 deletions(-)
> 

With pl011_create() fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


