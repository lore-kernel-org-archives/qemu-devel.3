Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F986C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 08:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcKpm-0000V7-Ti; Mon, 27 Jan 2025 03:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcKpk-0000U5-6J; Mon, 27 Jan 2025 03:51:04 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcKpg-0007VZ-Jn; Mon, 27 Jan 2025 03:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737967861; x=1769503861;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KNoYsFJjt1OHIm/LLCI9R/NzyPcPNRqNhS/7ZKR8CQU=;
 b=LGsmYmqctBwgh+GMLu2Cwbvek38ZeDbO6p+ObQODfOXGrfqMyJiG4ny0
 dZD2tN10czI2KZ6QLqWlYYRzVOYx50OHK9PWTLd4yQaZB4PeV3+xWz4/Q
 XIfGXehah2Bh3Xgl2PU4lQa4vYkrqhMvC8Ffn4R/9wG68RArC7dCYcqqN
 bqMUO8exq7BrAxIDhPob3WAllR6hmYcXrHuUy6gWypM/TyZsPZnZxdyvb
 JOo1UwtpX1sKPOlmynuSXajjqJxNn8xm+IMlMe9JADSF5ilBvkH1vNH7S
 pnTjGj7L1yLR34RNMNglo7MzF/rQ63Gu62hHQxqqh04P7LWbsyOzSiq2g w==;
X-CSE-ConnectionGUID: I3a/4iqKQmqEwPqYROl85A==
X-CSE-MsgGUID: 2DUxECiyRdOMnebSnP2Q6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="38302479"
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; d="scan'208";a="38302479"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 00:50:57 -0800
X-CSE-ConnectionGUID: ceW7WAkHR+6WzE/pCda2kg==
X-CSE-MsgGUID: tk/HigQ5T+yLULCL+4TkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112398966"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 27 Jan 2025 00:50:55 -0800
Date: Mon, 27 Jan 2025 17:10:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/10] rust: qdev: make ObjectImpl a supertrait of
 DeviceImpl
Message-ID: <Z5dNfKeRnV/modpA@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 17, 2025 at 08:40:00PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:40:00 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/10] rust: qdev: make ObjectImpl a supertrait of
>  DeviceImpl
> X-Mailer: git-send-email 2.47.1
> 
> In practice it has to be implemented always in order to access an
> implementation of ClassInitImpl<ObjectClass>.  Make the relationship
> explicit in the code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


