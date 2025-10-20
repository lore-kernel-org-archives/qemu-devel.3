Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC44CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAieN-0001dG-J6; Mon, 20 Oct 2025 01:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vAieH-0001cm-Bg; Mon, 20 Oct 2025 01:41:38 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vAieF-0007l9-HK; Mon, 20 Oct 2025 01:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760938895; x=1792474895;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gcWznPMOrFjo5caeVf3Xjhoshp7j6NjoowlKOhxy+/o=;
 b=OGzsrNVg/Jrcbs2X2Y/aGqCzjGbWzDW3CDVKc8Rn6WUQTs1bbBpWNTKP
 Oo41ox8oSvZOpRl0iNidFqrdDBGLX9BmrOMwcyZjtAYKDjqA056pWeUIK
 iobPtljQ6EbIsPbZkSqKAxELFWGquop17MHRQOnKyhqEe1wMqKMCx4yEx
 Ylzl0LVCEKDBFZ4nuVx8yeXk8wi74/YXCA3SGsULcIAbI6Nho1Y7VfRNd
 U/I9iE87J36kDqtyG1REZ+6FUbsD7hV899OGB9FWptM0jZzoPkY44uZU0
 kTiF4Mnu18i8kv9WK+re9kFBnJWw96MW4XwcQUZDZvMiB5AWlhy/WzLtk Q==;
X-CSE-ConnectionGUID: Io/VpkjZTci/nnKg3jKsyQ==
X-CSE-MsgGUID: EPE7ZUNXRIKrn1ynsJVplQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="65668853"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="65668853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2025 22:41:16 -0700
X-CSE-ConnectionGUID: PxmtUJkwTTqHBHBntka67w==
X-CSE-MsgGUID: vLZvIP1LTni6RykAcI2jqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="188544046"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 19 Oct 2025 22:41:15 -0700
Date: Mon, 20 Oct 2025 14:03:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mkletzan@redhat.com, marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: remove useless glib_sys bindings
Message-ID: <aPXQqvgNIdpBP58c@intel.com>
References: <20251016145619.1324585-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016145619.1324585-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 16, 2025 at 04:56:19PM +0200, Paolo Bonzini wrote:
> Date: Thu, 16 Oct 2025 16:56:19 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: remove useless glib_sys bindings
> X-Mailer: git-send-email 2.51.0
> 
> From: Martin Kletzander <mkletzan@redhat.com>
> 
> The definition of types needed for g_autolist(), g_autoslist(),
> g_autoqueue() need the imports for GList, GSList and GQueue
> to appear everything.  Rust code is never going to see those,
> since they are not used in structs.  Block the types from
> appearing in the bindings.
> 
> Co-authored-by: Martin Kletzander <mkletzan@redhat.com>
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                        | 1 +
>  rust/bql/src/bindings.rs           | 2 +-
>  rust/chardev/src/bindings.rs       | 4 ++--
>  rust/hw/char/pl011/src/bindings.rs | 2 +-
>  rust/hw/core/src/bindings.rs       | 2 +-
>  rust/migration/src/bindings.rs     | 2 +-
>  rust/qom/src/bindings.rs           | 2 +-
>  rust/system/src/bindings.rs        | 2 +-
>  rust/util/src/bindings.rs          | 2 +-
>  9 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


