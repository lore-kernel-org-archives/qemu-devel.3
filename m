Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E02CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 07:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKuF6-0004jh-HX; Tue, 10 Dec 2024 02:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKuF5-0004jT-Bk; Tue, 10 Dec 2024 02:01:11 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKuF2-0001aW-BQ; Tue, 10 Dec 2024 02:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733814068; x=1765350068;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1fFwSLVo0H6rOhoVAiWMSXmRBiYrEfJR5XC6lLLyJRg=;
 b=Th/p8ZE4JgvC7y338MXjIIJNG1yNP5SgMOcybXVff6rQmpElb0XmDTRz
 ngOFpiylzQF3bLZCRfXPul3rxPDA0owAAEaqrW7vRiHNZaOCiKKQ0PxVV
 izTzKHhP0A5GihPPJvUuK66ejrysAywks1vTkOOcQr/i1QEyr7Czaa42L
 tMf7XInzHgsVEGxIJdvl4L33XtVsI6hw3oqyvOjMyBhVQW6HjUPjo7qS2
 WiYukGaNGEaF7ShKCwFcJI23TjtL78EHyGB+PIDhrpdh6bpYtzpi42/pr
 pTgi5wq9jO86pLI7L0Jx6f4Jk9PaPIxqI0pkKjSzQ6b+8p7wIq9z7jmfy A==;
X-CSE-ConnectionGUID: fu61GLe7RrW4r2KqfhPIqQ==
X-CSE-MsgGUID: lofS2kjgRQ+WOuKPUbVtuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44612761"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="44612761"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 23:01:05 -0800
X-CSE-ConnectionGUID: KfeF5OQCS+C0Y9+ESb+Flw==
X-CSE-MsgGUID: 2KSOz+wQRiW4QwSKUQNnlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="95380659"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2024 23:01:03 -0800
Date: Tue, 10 Dec 2024 15:19:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 04/26] rust: define prelude
Message-ID: <Z1frdQh+eD7Cy8hI@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 09, 2024 at 01:36:55PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:36:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/26] rust: define prelude
> X-Mailer: git-send-email 2.47.1
> 
> Add a module that will contain frequently used traits and
> occasionally structs.  They can be included quickly with
> "use qemu_api::prelude::*".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build    | 1 +
>  rust/qemu-api/src/lib.rs     | 5 +++++
>  rust/qemu-api/src/prelude.rs | 6 ++++++
>  3 files changed, 12 insertions(+)
>  create mode 100644 rust/qemu-api/src/prelude.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


