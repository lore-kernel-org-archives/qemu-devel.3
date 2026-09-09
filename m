Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2FEC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4BgI-0007XK-6z; Wed, 09 Sep 2026 02:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x4BgG-0007Wy-9h; Wed, 09 Sep 2026 02:21:12 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x4BgE-0003jd-LK; Wed, 09 Sep 2026 02:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788934870; x=1820470870;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AoxD8+udGj6N32YfwbJkN/STpHhwRxFzHVVa/mjWwf4=;
 b=fgM31njCkZSDxLogTdyPb/GKyzonR7zQT6QjjhpG77tbJw3VnT19rOua
 J//yQLQ0pZMTB/lnY3Lz5H24tGXx5jJagmKwSvmmf3eQIlcYe9pce9d90
 AdZNWibgz5ommxRRPk6yvBPqyM4bpbscmkczyPu96UBQKSkWC/gf5eHh8
 o+4p6Lr5NWP24Ee7idI4uBiwNRe+vihN/B8Wss/TiqTidyQy3Yr3FlGQn
 P7NigD8ui27TOiAeYvMlaExAPSQDNk5Q+16ZveCOhS4n3krMC6YNvsb93
 gNlaOESsOjMVl0HvTBBpRU3+W4/0C5wgOpZ6bsUaGyJHVc6ly6+lnOxHN w==;
X-CSE-ConnectionGUID: 9MShSGyySDGg25lnbHfMOQ==
X-CSE-MsgGUID: TXnI60XmRCe4vNJEp28Rqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88285488"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="88285488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 23:21:03 -0700
X-CSE-ConnectionGUID: o9RJxYSRTz2tvwlJhG8HTw==
X-CSE-MsgGUID: hw7kgETDQICFAz9RAaM/hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="269881416"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 23:21:01 -0700
Date: Wed, 9 Sep 2026 14:21:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust: bindings: disable more clippy warnings
Message-ID: <aqD6zIDPORAamvKu@intel.com>
References: <20260908173826.867616-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908173826.867616-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 08, 2026 at 07:38:26PM +0200, Paolo Bonzini wrote:
> Date: Tue,  8 Sep 2026 19:38:26 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: bindings: disable more clippy warnings
> X-Mailer: git-send-email 2.55.0
> 
> The clippy::complexity category includes manual_div_ceil, which triggers
> with e.g. bindgen 0.73.2.  It is not really relevant to automatically
> generated code so drop it from all bindgen crates, but keep it
> enabled on purpose for other code.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Cargo.toml                         | 1 +
>  rust/bindings/chardev-sys/lib.rs   | 1 +
>  rust/bindings/hwcore-sys/lib.rs    | 1 +
>  rust/bindings/migration-sys/lib.rs | 1 +
>  rust/bindings/qom-sys/lib.rs       | 1 +
>  rust/bindings/system-sys/lib.rs    | 1 +
>  rust/bindings/util-sys/lib.rs      | 1 +
>  7 files changed, 7 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


