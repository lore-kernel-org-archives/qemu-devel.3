Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C47CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHE3-0004XN-QZ; Wed, 27 Aug 2025 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHE2-0004Ws-1x; Wed, 27 Aug 2025 10:34:10 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHDy-0008Bq-FO; Wed, 27 Aug 2025 10:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756305247; x=1787841247;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IQqbDAXq08m9PvJxjfyY4LiECehXFs7VN1fCcMvsxZc=;
 b=M/ASdU5EPN2uuUzRWX+5r4OdjhlxaU8p5BlyHuWNUiMV6BOqomX9Hmwv
 Ecn1LSKyDh7mMRQw/1M278uw/TdmW3BsdIGlkaeHQJMyKWJfvjYjmMLSu
 Vem0OxrrN8benypYIFU30dwlYW9COqxzKESSJtSumHw4TqC1wh7R1gCXB
 X2BnPklo91/h6yNgkzXrTZA2/zhmviCeCKH1OAJM/a8k4eAhemlZbZepx
 K2Yv3A5mUgn2eMJt6AT2DYsaS38Is4tPkeZ9um+wZ5a+PbaHYO6F4l1x7
 jEJZjf4qfq5vKTmg0S9MS3ejmPD90Md4tUpLYVHZU+Bhy/Q0hHI9ik2/H Q==;
X-CSE-ConnectionGUID: l8pV55PxSEiTvBWnhM1rWg==
X-CSE-MsgGUID: J6nyn8/zR4ivEGfHS7smfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58621974"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58621974"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:34:02 -0700
X-CSE-ConnectionGUID: 6u6ylQkETOGT21ynX1B67Q==
X-CSE-MsgGUID: IPKGvQKYTIGS8oRICE51ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="170234011"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 07:34:00 -0700
Date: Wed, 27 Aug 2025 22:55:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 02/22] rust: remove unused global qemu "allocator"
Message-ID: <aK8cc7fW8FhFmYlM@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-3-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:24PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:24 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 02/22] rust: remove unused global qemu "allocator"
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The global allocator has always been disabled. There is no clear reason
> Rust and C should use the same allocator. Allocations made from Rust
> must be freed by Rust, and same for C, otherwise we head into troubles.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  meson.build               |   4 --
>  rust/Cargo.toml           |   2 +-
>  rust/qemu-api/Cargo.toml  |   1 -
>  rust/qemu-api/meson.build |   1 -
>  rust/qemu-api/src/lib.rs  | 135 --------------------------------------
>  5 files changed, 1 insertion(+), 142 deletions(-)

There's a discussion almost one years ago:

https://lore.kernel.org/qemu-devel/CABgObfYY1PrD9dRKRgzgyRAe8gzp-4KHvV1-Bgq32_2jpaTMPg@mail.gmail.com/#t

Now we have libc crate and have an example which allocates the C structure
at Rust side:

let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());

this indeed seems simpler than enabling QemuAllocator.

So it's fine for me to remove this allocator:

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


let's see if Paolo & Manos have other comment.



