Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06BACCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGpj-0008DT-2P; Tue, 18 Nov 2025 03:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGph-0008Cj-4P; Tue, 18 Nov 2025 03:13:01 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGpe-0004mN-JA; Tue, 18 Nov 2025 03:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763453579; x=1794989579;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cbim/+YsUSlgrenj9UdQB+crv7ypDSFHj9B2yyLkXGY=;
 b=WkvUklZzJ1GWnqRLbjAYulgmMW6D2erfKxZ/FvWfRastN2RvpGVPkXGw
 ql9J5umB2jwZWw5DxRs4nzPUIOBQ7CjflaHCRKeH/A7DjSptSv8lssNB4
 1kBE5K/uLwDI2Z+puFuy/zaj/fqHAiE2CniVvGS/2Ml8mfoZmWy+TtASl
 32EVX4PD8e5ZAT3QanXkvnsfm9dcMeFRKQwgdpYn9P85wtl4+ujZWTrVW
 dAcuI0MyGQtQMQPLKZn3saMU5FjXDw5VWVTiKaMG4GKGQ8+ZHnZ0yAbzm
 AbfqXXlZWdG4Zw3JObOE0zCOygFwDL8qgKI6+0Tic8R2aPBq4MqvB+uJw Q==;
X-CSE-ConnectionGUID: rVWWVC6aQV2TK17EYR9rFA==
X-CSE-MsgGUID: +Qh1CCk4QqGzJv9AybxG2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68072651"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="68072651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 00:12:55 -0800
X-CSE-ConnectionGUID: Ydcp3aEgT6CWGi+WStlnCw==
X-CSE-MsgGUID: 3VfXKU8BS16/I0aqYu5GNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="195007163"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2025 00:12:54 -0800
Date: Tue, 18 Nov 2025 16:35:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/5] rust/hpet: move hidden registers to HPETTimerRegisters
Message-ID: <aRwvwXuLD/YAkzh2@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Nov 17, 2025 at 09:47:48AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Nov 2025 09:47:48 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/5] rust/hpet: move hidden registers to HPETTimerRegisters
> X-Mailer: git-send-email 2.51.1
> 
> Do not separate visible and hidden state; both of them are used in the
> same circumstances and it's easiest to place both of them under the
> same BqlRefCell.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 157 ++++++++++++++-----------------
>  1 file changed, 71 insertions(+), 86 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


