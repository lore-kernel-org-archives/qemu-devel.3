Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E7BD6406D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 03:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVhyP-0005GV-KV; Tue, 16 Dec 2025 22:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVhyN-0005Fb-6F; Tue, 16 Dec 2025 22:13:07 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVhyL-0004Eg-0p; Tue, 16 Dec 2025 22:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765941185; x=1797477185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=f615fpmWqCZllLrZqNripFqTae3cYSQKTpNqudKOSiI=;
 b=igqoTQlbqcgPvNcGhzD7PbUMTwNeyE44iQLs7Rxd4Q8tmh6qCCyPgWdA
 ZS8Rx46JsccVk4Gs2n7uMkwTLAj+YYt+8znjeAFhegxZeBvEXYjaw3KYZ
 cMlruzH/3X0GqirC1JtgIUPHpMUAaonGv5FNCIvY+alapyRcfNM+U7+bD
 Ki62t47/8k4bVs0Hw/825xI8gQkdyOqarfJft1lIqCxwS8ahZxiGxt/pR
 4ai0T3c+AUVodEIp0fx2d72Ip9hiFaV+GdXnZUh7r5Ikdm7yIGKUKxmZa
 6xxEZS0MevKFdYNeNGiSSmglGQzO5UxZLVwosNvyUdCSp0ZRNc214RiP9 A==;
X-CSE-ConnectionGUID: fPcGjYlvQu6wRr8Tuq51Tg==
X-CSE-MsgGUID: NCKaTLfjQDWet0qP+1qyyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79325418"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="79325418"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 19:13:00 -0800
X-CSE-ConnectionGUID: k3TZuxVuT9GB5pUisJ4AKA==
X-CSE-MsgGUID: fdqkS7W0TLeZaW3bi4k28w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="228881916"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 16 Dec 2025 19:12:59 -0800
Date: Wed, 17 Dec 2025 11:37:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, marcandre.lureau@redhat.com,
 Martin Kletzander <mkletzan@redhat.com>
Subject: Re: [PATCH 04/11] rust: Do not link qemuutil into Rust rlibs
Message-ID: <aUIli8Do+HM89mu8@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 15, 2025 at 08:49:53AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:53 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/11] rust: Do not link qemuutil into Rust rlibs
> X-Mailer: git-send-email 2.52.0
> 
> From: Martin Kletzander <mkletzan@redhat.com>
> 
> Commit de037ab8d83d removed qemuutil dependency from chardev and util
> rust crates.  However it stayed in the _util_rs static library.  The
> dependency is also defined as `link_with`, which is fine for C targets,
> where the resulting archive gets linked as another parameter on the
> command line when it is a static library.
> 
> However, when a C library is linked into a Rust rlib, rustc remembers
> the dependency into the metadata and adds the library to the linker
> command line.
> 
> Unfortunately, static libraries are sensitive to their
> position on the command line and rustc does not always get it right.
> Fortunately, simply removing it from dependencies of any rust libraries
> and instead adding them into the dependencies of executables and
> doctests fixes the behaviour.
> 
> Without this patch the error I get is:
> 
>   FAILED: [code=1] rust/tests/rust-integration
>   ...
>   = note: rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           rust-lld: error: unable to find library -l:libqemuutil.a
>           rust-lld: error: unable to find library -l:libvhost-user-glib.a
>           rust-lld: error: unable to find library -l:libvhost-user.a
>           collect2: error: ld returned 1 exit status
> 
> Meson could work around it itself by never adding these static libraries
> to the rlibs (after all, Meson tracks the transitive dependencies already
> and knows how to add them to dependents of those rlibs); at least for now,
> do it in QEMU: never link C libraries into Rust rlibs, and add them to the
> final build products only.
> 
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/chardev/meson.build | 2 +-
>  rust/qom/meson.build     | 2 +-
>  rust/util/meson.build    | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


