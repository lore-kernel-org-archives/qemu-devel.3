Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F9C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqOH-0006Zb-9x; Tue, 27 May 2025 05:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJqO1-0006XT-EN; Tue, 27 May 2025 05:14:21 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJqNv-0004ov-I0; Tue, 27 May 2025 05:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748337251; x=1779873251;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T5UwtNUBKcwK1Jkr9/vKENNPQT6sU8TGX0kZZdkcxpg=;
 b=aZ/tKdt4+nPq0YKoFh0E8Np1zRLzFt1xBFpSV2YfVwGEeVHAiM3Tjvfb
 lWPN4i6oFIxjfeXpZMGj2P7x+aQUTv271DwqjFkfZejnOtC+zlRJQoaz5
 4Ue+R1BbKtzlV2P06rMmqdlGj+x8M8FRQkA8mdCOtgkf1bMQDHFwT4bce
 vJv0c5DS1iTzxxDzSba75f9a4zrGPVAmqZ0r00bS1OKsiKO+YQfEbjiY+
 MgPg2kaO7AV7Y05em5oAtyo21b6e9DPAubW6fvqCKnV14Lj0tvn9Wyixn
 DZvGj727AJWpYZ4zxVCMyLz1Oa5rXvIB3y5Fy3U+0RgwzY8s+12vrkfBo A==;
X-CSE-ConnectionGUID: bmIdbVL2SL+zOnjUIAtwbg==
X-CSE-MsgGUID: QYT4qnpmS1+iCSTl9JY71A==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60977384"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="60977384"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 02:14:08 -0700
X-CSE-ConnectionGUID: vOD7OekPQP+bf5Mdc/4n8w==
X-CSE-MsgGUID: hQvHU+aIToyA1Zq5wJthtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="142717785"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 27 May 2025 02:14:07 -0700
Date: Tue, 27 May 2025 17:35:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/12] rust: make declaration of dependent crates more
 consistent
Message-ID: <aDWHVNBecjWierTI@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 26, 2025 at 04:24:44PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:44 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/12] rust: make declaration of dependent crates more
>  consistent
> X-Mailer: git-send-email 2.49.0
> 
> Crates like "bilge" and "libc" can be shared by more than one directory,
> so declare them directly in rust/meson.build.  While at it, make their
> variable names end with "_rs" and always add a subproject() statement
> (as that pinpoints the error better if the subproject is missing and
> cannot be downloaded).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/meson.build   | 12 +++---------
>  rust/meson.build                 | 16 ++++++++++++++++
>  rust/qemu-api-macros/meson.build | 14 +++-----------
>  rust/qemu-api/meson.build        |  4 +---
>  4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


