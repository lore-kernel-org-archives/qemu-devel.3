Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD0D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7tY-0004Mn-W1; Thu, 18 Dec 2025 01:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW7tQ-0004M7-Sq; Thu, 18 Dec 2025 01:53:46 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW7tO-0000VH-Eo; Thu, 18 Dec 2025 01:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766040823; x=1797576823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kq3EVTX+V7OSI2RRTAJqg+Ct87axTPOW5J2fHbppAdo=;
 b=j+HdnQsY/MAdcTwPPftTulUGY9ZqeRWgcyAdRP3oOatSWozJyMnPIVcx
 1et/jF7ZlGcot7tRTalMYuLX4JxYBjMS30ZGOxQ+NJ2W/w0SNdaphJbBR
 Pi2ffIDXcQcED5RHYuNP3LH29uFfhxTdvl3aOB02gJc3fdzIrmsBYKoiG
 3LAiTdwo5Q+nXOpqxgPMo0cMq2gYl2/ftFlZ/XFfQk6xn0xQEb/ZpO+Tx
 uYrSOC8UdhEETNgB9xOyH9x6RpWIkDJHsClPK+oRerj+zE/v73IFk2HiJ
 t9Uvpi64d1EpVOUuSQ7xZRn8TCJi2wTzHAO566LWRJZrFh4XaNKzoaAtR Q==;
X-CSE-ConnectionGUID: W/MmKfjYSGWOE0XnXGnugA==
X-CSE-MsgGUID: qTLOD4RUS4m6QHfcJ/AAUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="78701873"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="78701873"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:53:37 -0800
X-CSE-ConnectionGUID: XnySzBGtQR+8ujzT9hsMWg==
X-CSE-MsgGUID: SMUevTuQTAOQbkOC+5eb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="229201491"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 17 Dec 2025 22:53:35 -0800
Date: Thu, 18 Dec 2025 15:18:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: Re: [PATCH 07/11] meson: let Meson handle mixed-language linking of
 Rust and C objects
Message-ID: <aUOqwYjUHwrDWvM3@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 15, 2025 at 08:49:56AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:56 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/11] meson: let Meson handle mixed-language linking of
>  Rust and C objects
> X-Mailer: git-send-email 2.52.0
> 
> With the bump to Meson 1.10.0, C objects can be passed to rust targets.
> This way, the Rust libstd will be added by rustc itself in its final
> linker invocation.  Use that to eliminate the staticlib and allow
> dynamic linking with libstd (also introduced by Meson 1.9.0, but not
> for staticlib crates due to lack of support in rustc).
> 
> The main() function is still provided by C, which is possible by
> declaring the main source file of the Rust executable (which is
> still created by scripts/rust/rust_root_crate.sh) as #![no_main].
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                     | 19 ++++++++-----------
>  scripts/rust/rust_root_crate.sh |  1 +
>  2 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


