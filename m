Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90941D6406D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 03:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVi4C-0007J8-G5; Tue, 16 Dec 2025 22:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVi4A-0007IW-TH; Tue, 16 Dec 2025 22:19:06 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vVi49-0006bY-EZ; Tue, 16 Dec 2025 22:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765941546; x=1797477546;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RZtDMBQe8Jfogu798vLQrAfpdA9Qwot6bk8LrubbchQ=;
 b=Y/bxjWZGykm8sJ1k7eu9vXKVrRwZqPSiR6yTxHTCaDNKvp1K48OYM3O2
 RcO1VPaddptVDKy2PxJibZQ1zs47LRCwdXGS1x1t6yKkfIJhkBHI7kiiC
 bdrvujBtgeJW//q2pJtuP/hY9LwNdVJ1HAZh67beJ+R90ib16W/ATwMOa
 Ugk6gABXqvwEtXAd55KiHVdpflLnRhtrjwdY5NVBhYEadax3YhYrQ7oVx
 BpAupDC7O6FuyLmW6aZna8yXF36xsg41p1GXs6NIKEyahNCkh+0p3bHjt
 ruZFiw2odv/WiSkfjZX2xNtllyJtrNvLGrcyxQUogVpnjkwXww2x+6wgL g==;
X-CSE-ConnectionGUID: 3pbno/XiQcy4FZJNI3UezA==
X-CSE-MsgGUID: tsEmA8AYTDu53xrDrQXneQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="70447994"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="70447994"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 19:19:03 -0800
X-CSE-ConnectionGUID: t8GH8KgYRj+1vj92Dtmh/A==
X-CSE-MsgGUID: voZsRUbdQ6WttwSPepxA7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="198439337"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 16 Dec 2025 19:19:02 -0800
Date: Wed, 17 Dec 2025 11:43:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: Re: [PATCH 06/11] rust: Meson now adds -Cdefault-linker-libraries
Message-ID: <aUIm9/nfCV6Qf5DE@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-7-pbonzini@redhat.com>
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

On Mon, Dec 15, 2025 at 08:49:55AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/11] rust: Meson now adds -Cdefault-linker-libraries
> X-Mailer: git-send-email 2.52.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviwed-by: Zhao Liu <zhao1.liu@intel.com>


