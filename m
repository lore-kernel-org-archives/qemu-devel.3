Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF779D6406D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 03:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVi2w-0006fs-VC; Tue, 16 Dec 2025 22:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVi2o-0006bR-GO; Tue, 16 Dec 2025 22:17:42 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVi2m-0006Eo-5D; Tue, 16 Dec 2025 22:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765941460; x=1797477460;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zBJgc/hbE6t3nLugzcJb+1vjT990b/mKDeAY5TEz314=;
 b=NUD3vkb5vriCLc0PfCiGTd5oRpJtBTs62Vbi5jmHFw9tSctdtlcNE/gE
 bEP4S4IT+cB4KwGu7NHCBGcafzpCSNs9XOtVWHYJmmyVtYM3rOhY+vwFt
 ncB3tn2HHYXYrP/ruMs9Zrp5KsNV3WkAlcvO37u+JKMGUhvKZ6fLT2S4X
 mcuDbUgHF6C7w9kkv/doc2boOwHzhRxPzWZUlSGyc+zAKFiNrC0STpN9A
 plzx+iQWQlcpOdbsVw0Ne4t2zjKxneyBpxgU/pyVn5KkQ7vN8e6j6dDm4
 38EwIbqoQRvg9IO9JVSk0xgpRShh2OamDU0WTxjPTd2JIm7WzS0cpFf8M A==;
X-CSE-ConnectionGUID: oHd8HqKiSWeMTdCCxyiMIg==
X-CSE-MsgGUID: 2kllHh2tS9+QHXZG6w/RoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67757184"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="67757184"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 19:17:38 -0800
X-CSE-ConnectionGUID: GWbUW4UpRmajI6fMMM86RQ==
X-CSE-MsgGUID: szWdfd8WTM2h9FH9P17U/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="228882837"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 16 Dec 2025 19:17:37 -0800
Date: Wed, 17 Dec 2025 11:42:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: Re: [PATCH 05/11] rust: only link the Rust part of the code into
 devices
Message-ID: <aUImoemVOzoYUc1i@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 15, 2025 at 08:49:54AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:54 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/11] rust: only link the Rust part of the code into
>  devices
> X-Mailer: git-send-email 2.52.0
> 
> Do not include libqemuutil in the device crates for the same
> reason as in the previous commit.  Static libraries like qemuutil
> are sensitive to their position on the command line and rustc does not
> always get it right.
> 
> If rustc places the library too early on the command line, the stubs
> are included in the final link product, which results in duplicate
> symbols.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/meson.build | 18 ++++++++++--------
>  rust/hw/timer/hpet/meson.build | 18 +++++++++---------
>  2 files changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


