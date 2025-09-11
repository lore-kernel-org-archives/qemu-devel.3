Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A351CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe52-00041W-G0; Thu, 11 Sep 2025 05:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe4y-0003z9-OK
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:59:01 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe4q-0005oi-Kf
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757584732; x=1789120732;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=63Nr1BtFPFLHw1X8x9QryseUFB7bVYUgkDTyEbYIdms=;
 b=iU4jGc4ZIxOD/BRsDboLzDLi8MY4/g2qcykcHUHlyyvgKYX/pvrbYuXZ
 iErshLjUDYCZZDGWJYhQ2irP+PsjQtpGIO4YSSR/lARrqU0tbmjSbCPdI
 cFQKJddPEl4H3zEgq+WZuoTq0TXuKLpUO0UlW9mc+eIiFYkaGgFnAr8qb
 SGNjl0KHm02Py66/QR5BmpRSAcOq5X06iX6nBC5Y+6HEwye1ieNphWmZr
 mKXcVm20/9xX5GG6iWGLgVUjOL/pzM7xOzr5BAGwbFhDrtqobHZG6ROte
 pEFQxz14lP4TWx5Looq6nZOCSLV/8nAnNN8LcDvZH4ifdEYYLhCwHpAGg A==;
X-CSE-ConnectionGUID: vbQLF9UVSZ6GL0BsZ9ydog==
X-CSE-MsgGUID: i9UVIbgrRRiUNnRdPqabog==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58952235"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="58952235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 02:58:43 -0700
X-CSE-ConnectionGUID: nHfEmTGfRYypf1206DB/EA==
X-CSE-MsgGUID: 75hp+VhqQDuhvXEctctMFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="172830959"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2025 02:58:42 -0700
Date: Thu, 11 Sep 2025 18:20:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 09/33] rust: qdev: const_refs_to_static
Message-ID: <aMKicy+pfqLxiyfF@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:41PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:41 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/33] rust: qdev: const_refs_to_static
> X-Mailer: git-send-email 2.51.0
> 
> Now that const_refs_static can be assumed, convert the members of
> the DeviceImpl trait from functions to constants.  This lets the
> compiler know that they have a 'static lifetime, and removes the
> need for the weird "Box::leak()".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs  |  4 +--
>  rust/hw/timer/hpet/src/device.rs  |  9 ++-----
>  rust/qemu-api-macros/src/lib.rs   |  8 +++---
>  rust/qemu-api-macros/src/tests.rs | 44 ++++++++++++++-----------------
>  rust/qemu-api/src/qdev.rs         | 19 +++++--------
>  rust/qemu-api/tests/tests.rs      |  4 +--
>  6 files changed, 33 insertions(+), 55 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


