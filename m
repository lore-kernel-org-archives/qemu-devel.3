Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0062CD1269D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkEX-0005FF-NR; Wed, 03 Dec 2025 05:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkEW-0005EJ-Ly; Wed, 03 Dec 2025 05:37:16 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQkEV-0001gP-5F; Wed, 03 Dec 2025 05:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764758235; x=1796294235;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lagjdawcbRuDkIyYWXdjB8v8vilIt+dveuh/NLBIC1o=;
 b=PglyiVXCxHNWHWUOr0/RAyErpCyWSbLTuhuFxfNMqD3ESkd+tQLsoXGN
 nlXG1mN0FLSu8LFKU5DC95v198HyB7oo3tCvlM04+Iy29cwJ7lTPNZdQC
 oCDgB0J3iydFJ7lyOfRWJOf3klkfhkdA1NM1JnkYQyxh0IPozeQcNAY+e
 9d4OoggBDVdFsbsLShzPlDBJpEXZite2TvxFB0NH9RmHHdwqr3y41GlTi
 kUhevtrghbgIlY+n3GOrbou9Yrh1KiNuC4E1VCoaOqz3Q9MRyvhKD+YZY
 D29H1bFnS9VwQVtdr9tO6tyZg8o1cOz9w6/ouM5m+d5ii4I4xpHMb49Np w==;
X-CSE-ConnectionGUID: dOW3r3N6RyqTfr1KlfNhZg==
X-CSE-MsgGUID: 7uuZ1yXTSF6SPkyjOzv/bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65745887"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="65745887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:37:13 -0800
X-CSE-ConnectionGUID: rRXhJDOcQviNPIap8/FIwQ==
X-CSE-MsgGUID: vBkVfVtISbi1XHataeGUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="225593107"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 02:35:19 -0800
Date: Wed, 3 Dec 2025 19:00:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 6/9] rust: fix reference to MemoryRegion
Message-ID: <aTAYMoFer6UxG1kF@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127132036.84384-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 27, 2025 at 02:20:33PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:33 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 6/9] rust: fix reference to MemoryRegion
> X-Mailer: git-send-email 2.51.1
> 
> Use the wrapper struct, not the C one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bql/src/cell.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


