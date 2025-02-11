Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5E8C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgh8-0002zf-0Q; Mon, 10 Feb 2025 22:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgh1-0002yw-Qq; Mon, 10 Feb 2025 22:12:12 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thggy-0001TR-QO; Mon, 10 Feb 2025 22:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739243529; x=1770779529;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aHqpNgpbf6LhPOY0ipnTGdOXwpnrBnzF5w+KKKRVbM0=;
 b=T0VJNnLWEd/Br/v3Iu4unuHdJ6ghwM7zsMiaL/ER8iNBaesmy7eu8Z2e
 r0XXxfOv+ItWnNGH/G6/ryhX9qHh/B1Nq+1e6HQT6wKIA1WAwlBWTcGpg
 BSy0j5ipZThw2i3vMiKCHlxEk6da6xwa9BG4sw0K8dWMb53tYzBn8yllL
 Yc9/0yrKIc0LRB7WYZZo53sZxX1pTt1OFNLniwvfK7d7gpYQGmYdLAIus
 JGi0nZygLHGHhpOnnqVqC2NA7L8nLKxf/t2HJDRP3wLPuS/LseLmDjqXB
 VuBTzbURE1KkuNqjrDk8xMyZvy7v5J8qs0ElzkfRZQXE3zJROJwdZ8WBG g==;
X-CSE-ConnectionGUID: p1iNfWfUQ9WpQT/3d/4WDw==
X-CSE-MsgGUID: KCi93J9VSguOGNr34TignA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39968658"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39968658"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 19:12:06 -0800
X-CSE-ConnectionGUID: ofCqhxvjT0eLFnbqAkPvgQ==
X-CSE-MsgGUID: gEMHVAsCRMqcEjn050HWJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116471356"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 10 Feb 2025 19:12:04 -0800
Date: Tue, 11 Feb 2025 11:31:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/12] rust: irq: define ObjectType for IRQState
Message-ID: <Z6rEl3nypz+RtBAC@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

> +unsafe impl ObjectType for IRQState {
> +    type Class = ObjectClass;
> +    const TYPE_NAME: &'static CStr =
> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_IRQ) };
> +}
> +qom_isa!(IRQState: Object);

This is necessary for Owned<>, though IRQState has been defined in C.
It's another example to handle the C object in Rust (the previous one is
SysbusDevice).

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


