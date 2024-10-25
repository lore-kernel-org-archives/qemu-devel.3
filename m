Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF86D0C600
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4IDn-0000Vv-HM; Fri, 25 Oct 2024 07:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4IDf-0000VL-8K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:11:04 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4IDZ-0006dT-Qu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729854657; x=1761390657;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6CrhQ11rT4mIIGYaoOVyl66wNlhiV935Di3CsOf3bN8=;
 b=D7KTs9FwAczIn8t7fOTIOBzLwxs1mVsAwydrF8LOOYfsrSM6uVNx1c5t
 JnkzaFxOrl7h6jGRPBeNgy9+y6O5J01S9mJ5uRCh8t4q6WFseoj3pwGyB
 p+n5OlWbyMgYcsl8Wp0rrUxPLQpBbbFxCRnJZkbPKkN26uhz6UTmulO+8
 t2PMbWpAwockjIKvYUQX3rea0n783YXX8nlXhnq4Hy9H5U+v0doFavP38
 Dre2oGeon6y2RbDIf9fSWpzRlikHfgEwsgKK3S9bZo6aToVVinRwob3KB
 jn3yerAdO052w/A6Rif08gqYknexE/W99bUVzyMgXXTPSETGsNDsprYNK g==;
X-CSE-ConnectionGUID: WbBj7GaFRRWRVuGocAeB5w==
X-CSE-MsgGUID: N3zLSvDfTjm407RezDmxBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40107704"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="40107704"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 04:10:52 -0700
X-CSE-ConnectionGUID: PoZ/CmjxRi6ABShUaLfPnw==
X-CSE-MsgGUID: q4wxXO1eSFKyV17HoEpsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="85680630"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 25 Oct 2024 04:10:52 -0700
Date: Fri, 25 Oct 2024 19:27:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 11/13] rust: make properties array immutable
Message-ID: <ZxuAjfuYAOMe+FDI@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On Mon, Oct 21, 2024 at 06:35:36PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:36 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 11/13] rust: make properties array immutable
> X-Mailer: git-send-email 2.46.2
> 
> Now that device_class_set_props() takes a const pointer, the only part of
> "define_property!" that needs to be non-const is the call to try_into().
> This in turn will only break if offset_of returns a value with the most
> significant bit set (i.e. a struct size that is >=2^31 or >= 2^63,
> respectively on 32- and 64-bit system), which is impossible.
> 
> Just use a cast and clean everything up to remove the run-time
> initialization.  This also removes a use of OnceLock, which was only
> stabilized in 1.70.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/device_class.rs | 42 ++++++-------------------------
>  1 file changed, 8 insertions(+), 34 deletions(-)
> 

Very elegant!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


