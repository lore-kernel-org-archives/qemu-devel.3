Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35932E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 03:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNOQz-0005Gv-NK; Mon, 16 Dec 2024 22:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNOQr-0005GS-RC; Mon, 16 Dec 2024 22:39:38 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNOQn-0001Yf-2R; Mon, 16 Dec 2024 22:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734406773; x=1765942773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1lKqA14A+q7aPJdRP/DccKwQ8mg3UVxW3vBWti0y9/g=;
 b=Fsa5aVrnEb4PGByXTHuQvacMHaNcWL8pTAoa4Yti/ca/AS3LItq375iV
 ejzg0EbVKtghQ+sp31ddgeE1aMfJjUClTTXlIDHcLzFjp/VuS1vzrFPG4
 OVxz+4E+okONk12ycnaNaV9Ze2NU1KSbKRxFMa/zBS4sC72X8RT0jdgBu
 bJjs4K2msIntDfg5xSiPJl9ijJ//1wfwWZEhKdbnPWd+VPA7hSchcvCS2
 5OyN4/apRSud3nUXnoagE3EJkMpkydNlit7jRwYIfPgzCe5wKpqEK91Fs
 4ux2uH+80dT59YEieqg6L74OtjHykyATIsLH8URHfdPf3GbCtwv2XPLDJ A==;
X-CSE-ConnectionGUID: VPMbF/lqREaaGVIFyda7+g==
X-CSE-MsgGUID: lMsednBQQM6dhvzaIFyLIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35043055"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; d="scan'208";a="35043055"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 19:39:28 -0800
X-CSE-ConnectionGUID: nE2bIs7RRzCXKEMu/Pf2Mg==
X-CSE-MsgGUID: 8qEa4zJVRGueQ2UJONimRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; d="scan'208";a="97445348"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 16 Dec 2024 19:39:27 -0800
Date: Tue, 17 Dec 2024 11:58:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
Message-ID: <Z2D2zk2Wdlqc5q2k@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-25-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
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

> +impl ClassInitImpl<PL011Class> for PL011State {
> +    fn class_init(klass: &mut PL011Class) {
> +        klass.device_id = DeviceId::ARM;
> +        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);

This seems a bit of a conflict with the C version of QOM semantics. In C,
class_init is registered in TypeInfo, and then the QOM code will
automatically call the parent's class_init without needing to explicitly
call the parent's in the child's class_init.

However, SysBusDevice (and Device) is a bit different. Its TypeInfo is
registered on the C side, and the class_init method on the Rust side is not
actually a real QOM class_init (because it is not registered on the Rust
side).

Therefore, the call here seems valid from the code logic's perspective.
But, when there is deeper class inheritance, it seems impossible to
prevent class_init from being called both by the C side's QOM code and by
this kind of recursive case on the Rust side.

So, for devices like SysBusDevice that are registered on the C side,
should we not implement class_init and also not call it explicitly?

Or should we distinguish between two different usages of class_init? One
is registered in TypeInfo (only as a callback in rust_class_init) - perhaps
rename it as qom_class_init, and the other is used as a helper for Rust-side
calls (similar to the recursive usage here) - maybe rename it as
class_inter_init.

> +    }
> +}

