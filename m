Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214C2CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13pO-0002dJ-GK; Tue, 23 Sep 2025 10:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13pF-0002a0-K9; Tue, 23 Sep 2025 10:17:02 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13pD-0007yr-EL; Tue, 23 Sep 2025 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758637019; x=1790173019;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dy49G0WXF+Tuf1E5X/6FaOqKu/mAHnZvyqPsWnwY6EY=;
 b=PLO9G+gSQhr7jYz49yjNMWVh5XjPxRB9lPI7X4k96rI+XJEvPANo4R9E
 Zd9JYljZBx5A5Xi5/TFw0ToczNM/8/7//RsVtvsrCUWv3Wjj5B0/CCYu9
 f9PghVvh3sdfGhFucITfSQKrNi2lgj9KMwBlmRHrBVgn6kTai+o37PoZy
 W6almPL8gUsyDbDGLdtcz5abnxGAqX/oU/ZWTcI0JO06rkkHdqpNtq5al
 AWz9z6vbnT+ws/HwoM7wm4+pX+Qiv/0qQuxdVxI0M6n//2JoSiOSaWYKz
 eNSkrATAHuePH42G7h82iNd6OlLr63F0Ex+n0exqvpVBlQxlHhUiMeOYd A==;
X-CSE-ConnectionGUID: PLlUpnPsRduE5xiJWo13pA==
X-CSE-MsgGUID: BrZ588xuQaKVXHarTejJ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60834259"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60834259"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:16:53 -0700
X-CSE-ConnectionGUID: tcI7hdEyRteuhHVCfjyq0g==
X-CSE-MsgGUID: PcvLDuPWSRGXn3WBnkQ1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="200474450"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2025 07:16:52 -0700
Date: Tue, 23 Sep 2025 22:38:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: build: add back common and util tests
Message-ID: <aNKw+cJQX9eVRNS4@intel.com>
References: <20250919083617.86582-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919083617.86582-1-pbonzini@redhat.com>
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

On Fri, Sep 19, 2025 at 10:36:17AM +0200, Paolo Bonzini wrote:
> Date: Fri, 19 Sep 2025 10:36:17 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: build: add back common and util tests
> 
> These were dropped by mistake when extracting the crates.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/common/meson.build | 3 +++
>  rust/util/meson.build   | 4 ++++
>  2 files changed, 7 insertions(+)> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


