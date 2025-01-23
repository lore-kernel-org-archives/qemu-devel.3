Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F49FC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 05:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taq90-0001ll-J2; Thu, 23 Jan 2025 00:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taq8y-0001lS-Qo; Thu, 23 Jan 2025 00:52:45 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taq8w-0004vk-6L; Thu, 23 Jan 2025 00:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737611563; x=1769147563;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fYi2v+XHbENGUU7cOG+oekdjxxN+5qFhH+sglUAssF8=;
 b=itMOPC7tSx1Am6X1OfSXwVzxciztD9qQxo8UYL64W5x8dkH4c8rbD0dB
 rSZ6VeKNuXmshATTzC1Lna9MyaagW6Byn7nBidEsPja6VDBIs/3UBasTE
 nOAwRP63WuXhR65nh81V80nHU1pEmVt/gddUC6eVC5pjkLS7bYfhoqC4M
 3okGX16wooTiVqKlWTv211e1V95n/WpodCX8ZZ/6VTs8gf0o8jLbhSkdo
 wk59/VA3kZocrZroKUKuD0hQKfgEhvdh3pNwHn03M0AyAWMM/Bdixc0xn
 irtH1o5o8pXO4vSPMNRHybEYNVTlRb4debS6NL+RH139AiQKKnyo/tUvI g==;
X-CSE-ConnectionGUID: Cd3LPwjAQm6PchCQ0wwowA==
X-CSE-MsgGUID: J89uTsRIQxmMB+6Or7KhaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38126209"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="38126209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 21:52:39 -0800
X-CSE-ConnectionGUID: RM4i/IbHSsabqxSAGz95Vw==
X-CSE-MsgGUID: 7tCR7pT9R7qLuHrHQP4LRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107791877"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 22 Jan 2025 21:52:37 -0800
Date: Thu, 23 Jan 2025 14:12:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/10] rust: pl011: remove duplicate definitions
Message-ID: <Z5HdsFxeXkqlYYnI@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 17, 2025 at 10:26:55AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/10] rust: pl011: remove duplicate definitions
> X-Mailer: git-send-email 2.47.1
> 
> Unify the "Interrupt" enum and the "INT_*" constants with a struct
> that contains the bits.  The "int_level" and "int_enabled" fields
> could use a crate such as "bitflags".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 36 ++++++++++++-------------
>  rust/hw/char/pl011/src/lib.rs    | 46 +++++++++++---------------------
>  2 files changed, 33 insertions(+), 49 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


