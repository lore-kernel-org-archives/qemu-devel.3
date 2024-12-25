Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04FE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 16:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQUEG-0006JE-RF; Wed, 25 Dec 2024 11:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQUEE-0006Iq-UZ
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:27:22 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQUED-0001s9-Dn
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735144042; x=1766680042;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HYg8K/xpFPn7k5CWo70BEmN4F9tn8FByCEklrcvV4EQ=;
 b=Iaciv2Uhd9pMpFqW4YMrmY52+A5n16c4N2WdnjjmC04o8sraz5AfAvR0
 MofbMO1gOTEsk5Xjc1rsQc2pZzWEpABdHU1l9ohJjS1PhL02Lt1yQgHGx
 zipKu4dB6kIbmQ9bBffESf/7XK0iWqHLWHQQDeMQYVmW48FQdJmL+6iCK
 gUyJBWFhHUJxLSesF7/1i424GwbU4aUWQzhp+aSd8zpXIrhPdBB9Ziskh
 CvpNRs7y2fgA+7/zBx0eYob2/kKa0acZu5jOsxOeUSl0PZuxaa8O+wIgM
 5QjN+3uNGhEbv+duKtIV9+FRX0YYAShskhP4R/LhmwHCIZV4IAp+768VZ w==;
X-CSE-ConnectionGUID: 3aTxep3QSeOjqBzRdd/8wg==
X-CSE-MsgGUID: YQ8XeKcYQt2bXp0kgGiYQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="52990544"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; d="scan'208";a="52990544"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 08:27:20 -0800
X-CSE-ConnectionGUID: VOm2CUlFTmSfCxdlAe335Q==
X-CSE-MsgGUID: VuF9Lpv0RnyMNg+Oxzo/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="103821696"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 25 Dec 2024 08:27:18 -0800
Date: Thu, 26 Dec 2024 00:46:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 04/12] rust: macros: check that #[derive(Object)]
 requires #[repr(C)]
Message-ID: <Z2w2yZ5RZdLxtkLl@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:46PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:46 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/12] rust: macros: check that #[derive(Object)] requires
>  #[repr(C)]
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

(I think this patch would be best placed before patch 3. What do you
 think?)


