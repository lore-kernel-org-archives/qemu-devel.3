Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34541C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklg4-0001Zo-PL; Wed, 19 Feb 2025 10:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tklfw-0001Wf-Vp; Wed, 19 Feb 2025 10:07:50 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tklfr-00030y-Ty; Wed, 19 Feb 2025 10:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739977664; x=1771513664;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U3wn+MW8ZT2M11WwpMQPtb9IohNZRvnc1fQ+1XY91kU=;
 b=byKmlPN1tdU2r6STfeat5lR8Wl07b8w6zTHPerlV4yI/Kscy6RNpmpIt
 pVQJhKadOirgf4ZLjafB0MAUcaA1KpcW/4X6fWmQZ/DOFXuzoWIhcbWom
 f1HE8p9qQZIhEiatTRn1QozCjJSAYSbkjLBRbA9yZevCSar/4J0l+5Z6k
 Ra84fDSH9H2lWCILBKfSM1rZP8hYGO8+RIZByj/kKL8LLzJyqslgAI5Pk
 Kw4+m/ZNdJ2+Lnji9uUrWppMWa2HBxfxqyjhmzir1W/M3DDy9YXphYVkS
 nf1GKxVrwPuJODIg1/DDMn4n734DoFlYhNsKcsrKUHQySEmdUxJ35Fayz g==;
X-CSE-ConnectionGUID: L8KmINi0Ti+XU2f9qPKA8A==
X-CSE-MsgGUID: 9dK0UZgnSYO0TBXSD+UOIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51699124"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; d="scan'208";a="51699124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 07:07:40 -0800
X-CSE-ConnectionGUID: L1ajwwN0Tri0Isd3azaVeQ==
X-CSE-MsgGUID: z5S7vVhNQxiGR9PrbtUtTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; d="scan'208";a="114673177"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 19 Feb 2025 07:07:38 -0800
Date: Wed, 19 Feb 2025 23:27:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, kwolf@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] rust: subprojects: add libc crate
Message-ID: <Z7X4UVQYiT26oWO0@intel.com>
References: <20250213143216.3910163-1-pbonzini@redhat.com>
 <20250213143216.3910163-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213143216.3910163-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On Thu, Feb 13, 2025 at 03:32:15PM +0100, Paolo Bonzini wrote:
> Date: Thu, 13 Feb 2025 15:32:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/2] rust: subprojects: add libc crate
> X-Mailer: git-send-email 2.48.1
> 
> This allows access to errno values.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                               |  7 ++++
>  rust/qemu-api/Cargo.toml                      |  1 +
>  scripts/archive-source.sh                     |  2 +-
>  scripts/make-release                          |  2 +-
>  subprojects/libc-0.2-rs.wrap                  |  7 ++++
>  .../packagefiles/libc-0.2-rs/meson.build      | 36 +++++++++++++++++++
>  6 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 subprojects/libc-0.2-rs.wrap
>  create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build

Missing to update subprojects/.gitignore. With this nit fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


