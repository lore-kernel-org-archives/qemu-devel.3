Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D9FC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqoY-0002jL-4l; Tue, 25 Feb 2025 04:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqoO-0002dc-L7; Tue, 25 Feb 2025 04:01:08 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqoN-00015y-1K; Tue, 25 Feb 2025 04:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740474067; x=1772010067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Vs53/Ogs4sl4BzHTFsAstvRumeLpCP62A1dWxTMeAoM=;
 b=CgAv5zOGZPErWl170X9YqujjVwS83behVAk/nw7Z/1x/mYsDjK+KOfVz
 7anoNQo0sbxAhfGofav64F79Noxu/VfH8M1r4aYKooUxeBCJPXZI8Ussj
 p8xAVaHjQZ+kbAqBzGkkQVrFQF7kaWCyFgjbcpYOpUZKft50/+SnrBqxg
 HBdhzIQbgpQHsObN58pIYeD/cAJoPG0DqTexfL0Fit74E7b81Wx2Tv0Hm
 WaVrBW8c4UEO7kBNNRwxRQEcAtE+8Y2BjT+Zr4zzmz8jmsED8QnCECAp+
 gzuKA3CwCHc0ycmInKDYjaMDf5dfaD8aaWA8dq/wRtXfJ5S6Y5XTnGZ8X Q==;
X-CSE-ConnectionGUID: X93ANaWFTYKQuqmhtgbftA==
X-CSE-MsgGUID: VVn0qZsQQu6oVEYm60qGjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41184212"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="41184212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:01:05 -0800
X-CSE-ConnectionGUID: r3oCgVZcTqWKnrsLLqNiVQ==
X-CSE-MsgGUID: kK2Tvc8ORAqEeDTfMyaLnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116346467"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2025 01:01:03 -0800
Date: Tue, 25 Feb 2025 17:20:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 15/15] rust: bindings: remove more unnecessary Send/Sync
 impls
Message-ID: <Z72LaFpqKGataGpn@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-16-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:42PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 15/15] rust: bindings: remove more unnecessary Send/Sync
>  impls
> X-Mailer: git-send-email 2.48.1
> 
> Send and Sync are now implemented on the opaque wrappers.  Remove them
> from the bindings module, unless the structs are pure data containers
> and/or have no C functions defined on them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


