Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94025C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7GS-00061e-VX; Mon, 03 Mar 2025 09:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp7GQ-000617-28; Mon, 03 Mar 2025 09:59:26 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp7GM-0007qd-Lo; Mon, 03 Mar 2025 09:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741013962; x=1772549962;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HRPVbfho+LLuUuzc8CR6Jb5tPbOh4MIqnxIb1XWx0mg=;
 b=CsgzjrjhBt9G6n39xB46jCtAd7bmPzJmgdn0o7Gh84NvsukxzNpc6S1j
 zGPD1oF/k4CirVX6TqliPukd84GyAemSuPG10bRFVz5GT34AIjH3c0qKB
 zWubkBeNV8e4eO4Cpp2TKGxPT6ayfqBBdlWp6xehvxORdAPscxa7bjQT8
 X6LRtNxz+PjMua0gjz7kMjSbKehII5wudoXqcGe4uU4Y9e1A2+fzWECK4
 ataS77LbMEaUdVI3zU6I8oobmaHfbUDUz6eL8ajH21pnJnswN3i37Hig2
 s3LjaGgj7rwJMNyi6Y5cF4KyBofdWxpIKVLHsNkPNVEs0PtH9pydhZB8c Q==;
X-CSE-ConnectionGUID: AEspLUrbSXuQmMqQw0K90g==
X-CSE-MsgGUID: 2yvS0l0LTPasGt9V1vyMrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53284418"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="53284418"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 06:59:19 -0800
X-CSE-ConnectionGUID: nKMNwBAzTz2aalV3eMeTrw==
X-CSE-MsgGUID: y3QenLH4QEicO9dc+/Eg0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="148850079"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 03 Mar 2025 06:59:19 -0800
Date: Mon, 3 Mar 2025 23:19:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/12] rust: sysbus: wrap SysBusDevice with Opaque<>
Message-ID: <Z8XIfZ6L6I4jKaBJ@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 27, 2025 at 03:22:16PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:16 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/12] rust: sysbus: wrap SysBusDevice with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs |  3 ---
>  rust/qemu-api/src/sysbus.rs   | 29 +++++++++++++++++++++--------
>  2 files changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


