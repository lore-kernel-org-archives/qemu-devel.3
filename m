Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F0D15D9F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tVB-0004JE-72; Mon, 21 Oct 2024 10:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tV8-0004Im-To
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:35:18 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2tV7-0008UM-8W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729521317; x=1761057317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q18Wp5NLJ3j0JLMkJbuqvL8WEvPGNxL8w3yVBD3C+Dc=;
 b=ds2HfWMn8P2hiPZbjDLCm0Vd4fA/RXMMsggWGhJXlEd/yOr5+NPKlGmg
 wrkvaZsB6sa7XFzPffjjwATIZt4xnF4TSM4JdF/8QksbcWVKzlSYQNsdS
 Q9/EQkmOnM53SwYPGYgDgEVaaJcqoikZ52qznq/oJB6xT+J6cI06LVVKv
 423d7znHCTtfYkp+XGCXeraNTFRVzovim868KuzUrQh5t4P0OsxZEEtBq
 edGY+GCR9ae9LI8yUdp0uIRcGg5GuRxnL5GFHpxKZvSS4yQvWlkp0CCEz
 nHVpkCHriN0zg/RxHK+nctlFUrmOjuZ31+YHbAFgeMAep3e9oL988bD/T w==;
X-CSE-ConnectionGUID: WtiecNgBSdSSlBiXC8cYTA==
X-CSE-MsgGUID: WYhvVARtRgKoYuUDedjVUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29127318"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29127318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:35:15 -0700
X-CSE-ConnectionGUID: mP/tkhSgTkupP+muMsEEvA==
X-CSE-MsgGUID: a95vhcptR7+Xzsj74X0gLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="84363094"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 07:35:14 -0700
Date: Mon, 21 Oct 2024 22:51:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
Message-ID: <ZxZqcuYx16BVXMK1@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

On Tue, Oct 15, 2024 at 03:17:26PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:26 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/16] rust: build tests for the qemu_api crate
> X-Mailer: git-send-email 2.46.2
> 
> Fix some bitrot in tests.rs, and allow the unit tests to be run via
> "meson test".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build  | 3 +++
>  rust/qemu-api/src/tests.rs | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Codes look good to me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


