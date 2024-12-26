Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B58E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 06:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQhmh-0004OV-Mw; Thu, 26 Dec 2024 01:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQhma-0004N2-LW
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 01:55:45 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQhmY-0000DQ-So
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 01:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735196143; x=1766732143;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EL6HUKrmObS46S3cHHNi914ANMglQReIbHgGn2anPYc=;
 b=Bw8zCNJkk7SG+Q1deSTZ+z0Ve+Q1Iu5j3Jqv3mmp0pI+lXgkeYcIer7/
 JBK0Gn+/HxlP0PQTrbyNSI83junjIkjTh5Oe0CojjJz2DBRpMg63Hb5bI
 9GQfGf7nhBlkWfK3kLh6kLO7K3hp8h0lp/PIvLe7pUq8jspRc+txUW1p7
 wwJZyZ8Bb9fo8bIVdX5Gkw/Av3Ru8HMFgBNMUdIAQBz5Oqlpg/uzZEdJg
 AGhL6Bro4su0LeFsKR3OON2MUkf3CGbYHU8azCVDNHqA/q4EFYVtGeAiK
 QrLBOmkwno89gzWJD6EsS/hRjqM+aOLB2TcjkxtDpJMSy8cYh0qaWjEPN A==;
X-CSE-ConnectionGUID: Z4N70P81QAawuNlvghd1oQ==
X-CSE-MsgGUID: ytfvameqSbWdqvGIKcTaNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39554800"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="39554800"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 22:55:38 -0800
X-CSE-ConnectionGUID: Kcw6WJAuRoGPO9+yGPegVA==
X-CSE-MsgGUID: ViVjcbKnSHC+f86h+GwI4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="104942296"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 25 Dec 2024 22:55:37 -0800
Date: Thu, 26 Dec 2024 15:14:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 11/12] rust: qemu-api-macros: add automatic
 TryFrom/TryInto derivation
Message-ID: <Z20CS9YazZ9Rg6c7@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:53PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:53 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/12] rust: qemu-api-macros: add automatic TryFrom/TryInto
>  derivation
> X-Mailer: git-send-email 2.47.1
> 
> This is going to be fairly common. Using a custom procedural macro
> provides better error messages and automatically finds the right
> type.
> 
> Note that this is different from the same-named macro in the
> derive_more crate.  That one provides conversion from e.g. tuples
> to enums with tuple variants, not from integers to enums.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/lib.rs   | 28 +------------
>  rust/qemu-api-macros/src/lib.rs | 74 ++++++++++++++++++++++++++++++++-
>  2 files changed, 73 insertions(+), 29 deletions(-)
>

This improvement is also very elegant.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


