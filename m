Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA0CC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taad6-0007nj-1e; Wed, 22 Jan 2025 08:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taad3-0007lo-4x; Wed, 22 Jan 2025 08:18:45 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taacz-0006fZ-DB; Wed, 22 Jan 2025 08:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737551922; x=1769087922;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uO3GwZQDSdxNqtjyuP4Js7fdfnXJwEt29QyTP1TsNys=;
 b=CW1k+2UKBSOoq6jBwT86PDEPe4i5Yioo2BORJtha3/gwnJRxTdSw7Get
 UcSETAPyCMpa6SGeWzWLLv9v63HY6wyZI0uYoEB8VSbdmhenSoiPYUxRk
 FEv/od+FFfSvYc+iiXl1Q6jqyZA5wqL1JQ8IPT+iQ+BAUBfB1EUhEiaeJ
 6p4oaqA07AZXb600MId4nqSe5d2idpmQnaEALAQ3OSn+z/DmJGuDHgBJW
 qFNo33LEptkrQxHqWdfGH5oND2OtqE8au+ejn4xibTmLraEfq4Pt92cMz
 jxOjOpvgvRBG4xRv78o+tqu0EjY+MHBX6KR7LxhO5Fan5omwGmZ13KIi3 g==;
X-CSE-ConnectionGUID: s7p2tVR2SrOZQKm7/1/zSw==
X-CSE-MsgGUID: SHQBv8gnSOiEYt2dUDRuuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="60475635"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="60475635"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 05:18:34 -0800
X-CSE-ConnectionGUID: JgHGJhViSkCgcLMruGbqoA==
X-CSE-MsgGUID: cegjEaa2SZSj6iDJQLVVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="107163720"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 22 Jan 2025 05:18:33 -0800
Date: Wed, 22 Jan 2025 21:37:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/10] rust: pl011: remove unnecessary "extern crate"
Message-ID: <Z5D0szRoyR24EqlU@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:26:48AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:48 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/10] rust: pl011: remove unnecessary "extern crate"
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/lib.rs | 4 ----
>  1 file changed, 4 deletions(-)

Yes, it's unnecessary from Rust 2018.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


