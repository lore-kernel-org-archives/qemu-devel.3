Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB511E69EAF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUqT-0001nv-Eq; Tue, 03 Dec 2024 10:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tIUqQ-0001jv-A4; Tue, 03 Dec 2024 10:29:46 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tIUqN-0008Ef-Qb; Tue, 03 Dec 2024 10:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733239784; x=1764775784;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WqH5S9nYqM/7K0+LRFvOaecwXadq3GKXHflnoUGJlm8=;
 b=KUcG+VbtToMjvEFBrrd/uG8+Nd0qbq4sG/ZdivB7P9e62LWnQpZTOZaS
 RqF9eMkTgH/2tK5B0fnyu+OjESZi3zdVZMA++wGH5BlDQGstCm1ybu2Zx
 PFA3Nwshkxf14vbnODjboMj3k2AoBnD8kdjsbOEcW3trLkI6SQzTdKgL5
 B1eiRT5PItNDJfuB3ODtfOwng5t2W3A84p8/JkF8Hg6c1qwwdDRnoC/8P
 EzWXYBFlK+n3aRYlE6/E23ydc8L4uBelMuE/EjoTcitfqzHJ4ielTz9qY
 IBFL8srbaXdRcACjHOv+0WM7ny0Wu3jmTFcxcyc/HFSFBOrI4zA7Du1Av g==;
X-CSE-ConnectionGUID: IcZ9toOjQVq538TcWGb3QQ==
X-CSE-MsgGUID: y5C/H4IkRYuLiGXMT9ZsUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="36311879"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; d="scan'208";a="36311879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2024 07:29:35 -0800
X-CSE-ConnectionGUID: tyQ68S8cTdWQYMzvIxwtlw==
X-CSE-MsgGUID: bwLuNQ6BSIqmm8ayDMoAtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; d="scan'208";a="93927470"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 03 Dec 2024 07:29:34 -0800
Date: Tue, 3 Dec 2024 23:47:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 2/2] rust: add bindings for interrupt sources
Message-ID: <Z08oItSaucp9Z5Xi@intel.com>
References: <20241202110609.36775-1-pbonzini@redhat.com>
 <20241202110609.36775-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202110609.36775-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 02, 2024 at 12:06:09PM +0100, Paolo Bonzini wrote:
> Date: Mon,  2 Dec 2024 12:06:09 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 2/2] rust: add bindings for interrupt sources
> X-Mailer: git-send-email 2.47.0
> 
> The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
> as safe code.
> 
> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
> They are QOM link properties and can be written to outside the control
> of the device (i.e. from a shared reference); therefore they must be
> interior-mutable in Rust.  Since thread-safety is provided by the BQL,
> what we want here is the newly-introduced BqlCell.  A pointer to the
> contents of the BqlCell (an IRQState**, or equivalently qemu_irq*)
> is then passed to the C sysbus_init_irq function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 22 ++++----
>  rust/qemu-api/meson.build        |  2 +
>  rust/qemu-api/src/irq.rs         | 91 ++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs         |  2 +
>  rust/qemu-api/src/sysbus.rs      | 26 +++++++++
>  5 files changed, 133 insertions(+), 10 deletions(-)
>  create mode 100644 rust/qemu-api/src/irq.rs
>  create mode 100644 rust/qemu-api/src/sysbus.rs
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


