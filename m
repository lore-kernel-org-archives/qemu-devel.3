Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9EC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDb-00035k-VJ; Tue, 08 Jul 2025 16:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDnc-0004gQ-Ln; Tue, 08 Jul 2025 15:16:20 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDnV-0007GK-Si; Tue, 08 Jul 2025 15:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002170; x=1783538170;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=atwudXLeTa5tSIxfbiQr6IFjLu+NtrdGqLBrqQEydxg=;
 b=XcgE5s8LAo325e8iHEnqP5lh9jMvDSNsEdOWzBwWQkKaHXSGEI8SO2wV
 EP0B581/RsJgxF9Ad9ZNurKqHQov1EPgDmYSZbJ3pAztIRoooK7N/oG2x
 dd6HBdN8VdHruilWGKOso8IeT40S0FcEJjtj40Nz83ffLVgeVzh3rrhUu
 rkiOGhmTLYa3/7ns7lqJFjsn0XgZ96kx87Nyyij7XTo4cNb3RiKUqAUnb
 J9egFBG7i8EHpIjOr9U2n7AgNQ7N4F5Q7a3MINZdaVw5qC6Ifc9Rq0J5i
 ytah/DYV+pM7HWkMyT/k8SVDVo5kAVtx/sXJaWZKc2Y6vfRCdsQI1DR9Z Q==;
X-CSE-ConnectionGUID: 0cXOeOJbSmGFODS1mqyNaw==
X-CSE-MsgGUID: i2epkh3eQY+Yhogy+Gm9ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54119137"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="54119137"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 01:00:44 -0700
X-CSE-ConnectionGUID: hYd+tfmWSJK4hB1vO+ZRoQ==
X-CSE-MsgGUID: OB4FF75TQH2zSEQrYYXBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="155925894"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 08 Jul 2025 01:00:42 -0700
Date: Tue, 8 Jul 2025 16:22:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
Message-ID: <aGzVMbFDmJcpxHXp@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 04:58:12PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 03 Jul 2025 16:58:12 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
> X-Mailer: b4 0.14.2
> 
> Convert MemTxResult defines into an enum. This will allow bindgen to
> generate a bitflag using the enum variants as its domain of values.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  include/exec/memattrs.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


