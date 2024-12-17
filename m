Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFD2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZud-0002wC-Lr; Tue, 17 Dec 2024 10:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNZub-0002vJ-Or; Tue, 17 Dec 2024 10:55:05 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNZuW-0001Ed-GN; Tue, 17 Dec 2024 10:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734450900; x=1765986900;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vuQ3KoCPzQgb6wxfO6E75TTecEzX0afWei6P6wTlA2o=;
 b=Urb1TODs6qEMce4PKS04vXkE7iw6hBJf/U9N/yOcmhXycq5YMzhO8npS
 6CqFBOqah0vTAY1cV7lnZSc5sGdVg4xpVQ+b8EzITfHZBaO946K4PWrpt
 uRJT2im2ycH+UE4tcCUcBYWjPXvaXULicmLQ4F6IXq+9ndBQZQM3uTanW
 FJ3yGWkM/ifcUJH7HJIEwRJvU5Sk/mgCW7+4TfgtXGh5Hg7lxc1JyBKI7
 6NvHUSnw9EcumRaKVxU4QguyTYeDEbUd1NL9nwY5GwG4sCqZ0I2CXhXRo
 NEuELCE9QrFEozPCgVFGVrX/Xele7Cc35GxS/3JY6hMEonp5ozKtl+tln w==;
X-CSE-ConnectionGUID: xq6dnvYGQcu3i/bmtr7khQ==
X-CSE-MsgGUID: oQlyn6cVTb6mzk+GtaL7ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45579759"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="45579759"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 07:54:54 -0800
X-CSE-ConnectionGUID: hv6IZlsmT12T4/AX0SM3RA==
X-CSE-MsgGUID: YhMkV4X5S7W/ggcB6kIrzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="97424922"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Dec 2024 07:54:53 -0800
Date: Wed, 18 Dec 2024 00:13:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
 as ()
Message-ID: <Z2GjLOppRcHFBpAT@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-27-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-27-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 09, 2024 at 01:37:17PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:17 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 26/26] rust: callbacks: allow passing optional callbacks as
>  ()
> X-Mailer: git-send-email 2.47.1
> 
> In some cases, callbacks are optional.  Using "Some(function)" and "None"
> does not work well, because when someone writes "None" the compiler does
> not know what to use for "F" in "Option<F>".

I understand the direct use case is MemoryRegionOps, which has optional
callbacks. However, I'm not quite sure how exactly it should be applied
to C bindings and how it will play with Option<callback>.

Could u pls provide a simple example?

> Therefore, adopt () to mean a "null" callback.  It is possible to enforce
> that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME" before
> the invocation of F::call.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
> index 6401d807198..83c681d6478 100644
> --- a/rust/qemu-api/src/callbacks.rs
> +++ b/rust/qemu-api/src/callbacks.rs
> @@ -76,6 +76,31 @@
>  /// call_it(&move |_| String::from(x), "hello workd");

typo: s/workd/word/ (in previous patch :-))


