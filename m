Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A350CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe6U-0005wq-7V; Thu, 11 Sep 2025 06:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe6S-0005wK-Gw
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:00:32 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe6J-0006Ho-35
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757584823; x=1789120823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=n87dABdsD1J3a1Kkxf9PvaiG0GCOdgGYv1TAqaxiipc=;
 b=BqvaLj+6jWYfk7Rv90IRchpi8yBv1n5z1bQ3GyPbKEAF5C1J+QrynXmN
 lOZHzo68d4Oc1RSLXiVI3BrR3Unvqnm4a5l2zDlS4DgX4tofbeISyIvs7
 TNFW+Es7JedFGl6nIw8wDredtbell6bhH7FvmSuU8n8LdAGlKtmsxNLgE
 vXyahuPomz3VEcV7iuaMO0bugktgvEPjRCaizOBxAEP2WQ2u6jtT4EN72
 xJ4/FP27eDzWk+lLJVjQDmLtdcNi6etCbucC4xLA0ztBcQ14xwjYzBWHI
 c4ODCBolOpQYmRkTn16K6jU6R7X8U6Ybd7I/9adNkHQCNhSB7844c5P7N g==;
X-CSE-ConnectionGUID: 2E+tDracSku8gLXWvIFgpw==
X-CSE-MsgGUID: XFw//irZSmK6x4XgNmy0gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70166370"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="70166370"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:00:08 -0700
X-CSE-ConnectionGUID: PDzfPMbeToCs4auA6aL4fw==
X-CSE-MsgGUID: knwlTEbaTl6x0Y5bdplUjg==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2025 03:00:06 -0700
Date: Thu, 11 Sep 2025 18:21:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 11/33] rust: remove unused global qemu "allocator"
Message-ID: <aMKixyg+pXqvuNz8@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:43PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:43 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/33] rust: remove unused global qemu "allocator"
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The global allocator has always been disabled. There is no clear reason
> Rust and C should use the same allocator. Allocations made from Rust
> must be freed by Rust, and same for C, otherwise we head into troubles.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-3-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build               |   4 --
>  rust/Cargo.toml           |   2 +-
>  rust/qemu-api/Cargo.toml  |   1 -
>  rust/qemu-api/meson.build |   1 -
>  rust/qemu-api/src/lib.rs  | 135 --------------------------------------
>  5 files changed, 1 insertion(+), 142 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


