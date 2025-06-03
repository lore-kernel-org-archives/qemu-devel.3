Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNim-0006Hy-CZ; Tue, 03 Jun 2025 05:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMNij-0006H4-Q0; Tue, 03 Jun 2025 05:14:09 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMNig-0005pF-V6; Tue, 03 Jun 2025 05:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748942047; x=1780478047;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zvg6L018Ewov4eURmDaD8O4hsuuTb8Ic6w9dXXAN2f0=;
 b=nLv1Py+vvTxt+qqQLRchG0EvpHtkRu48M31w8e95wGSmimn5saA5QTwq
 +CkizfP6lATgQKuIQVHHy0EGrybWXIZweWhTBOxmM1P3cUCckpP4kiRvV
 Ne+TvXe/MWTja/xJ41R/N0xYVFsvgcHN7W+26srk1bOXLMjDooxWOK5mP
 5CnvLXACPlpgKLrVvOLQcKPgfVEtkv//Hqk/gNsaIBgmPy0wJxgtk+07w
 Uo20JPLlnfIOtLNGs0qa6AnJvCtfaRoG4OF6SUdUaYoIE8v0xLO2NDtgg
 f9GbzTTqCWjlKapZ2xpHfhYMun16hq8T2hO2Ya8nGoGUd+5TeEeqWEeh+ g==;
X-CSE-ConnectionGUID: DTm52iuoQ3KVSTU6FZvkKQ==
X-CSE-MsgGUID: 8DnTxf5sQumYe9gQSRnp1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="76365490"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="76365490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 02:14:04 -0700
X-CSE-ConnectionGUID: Ls0kT20JRwabESDUa6YxMA==
X-CSE-MsgGUID: tBbSOFXIS3aa6VB8pRwOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="144775548"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 03 Jun 2025 02:14:03 -0700
Date: Tue, 3 Jun 2025 17:35:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/14] rust: bindings for Error
Message-ID: <aD7B02b1EOedrtUq@intel.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Fri, May 30, 2025 at 10:02:52AM +0200, Paolo Bonzini wrote:
> Date: Fri, 30 May 2025 10:02:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 00/14] rust: bindings for Error
> X-Mailer: git-send-email 2.49.0
> 
> As explained for v1, the impetus for this series is to remove BqlCell<>
> from HPETState::num_timers.  However, it's also an important step for QAPI:
> error propagation is pretty central for example to QMP, and the series
> is also a first example of two-way conversion between C and native-Rust
> structs (i.e. not using bindgen-generated structs or their opaque wrappers).
> 
> As an aside, support for NUL-terminated file is now scheduled for
> inclusion in Rust as "panic::Location::file_with_nul()", but it will be
> quite a while before QEMU can use it.  For more information, see
> https://github.com/rust-lang/rust/issues/141727.

Apart from Markus's comments, the rest of the code (the specific
implementation of error binding) looks great to me. The interaction with
Foreign crate is quite insightful. I'll go through other patches on the
rust-next branch.

Thanks,
Zhao


