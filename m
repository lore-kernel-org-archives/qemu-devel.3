Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B10DC021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl07R-0001kt-HD; Thu, 20 Feb 2025 01:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl07O-0001jj-AH; Thu, 20 Feb 2025 01:33:07 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl07L-0006bJ-J1; Thu, 20 Feb 2025 01:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740033183; x=1771569183;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PEqn8csDB63c9Qf+hVkpnVsHR3MVc2QOGG1wuW2Kg7E=;
 b=PYn04pKEDILxueayLkd9RmQSKYEatnltXzWw8KdDggG26ZlE2hecQjaj
 0b8kZk/Nt49cio+Jlnuuq7F5ZDLOwCRMOWBqWrpveBfZEI5hu0GhHGfCk
 6iOwc6c/d7XEjgV/icthxv5fcwcqqw9bo3QQc0/B87bqjKPYP7rLqJENg
 y9BEGz0LbPd+leFjD7C+EqqQSavY1XjaxK5JMMeVpdbnkUF3s103YgpS0
 AKo7lLxuGCbut9tpZV1zq5gVShhzNgoISAl05115KiB0mR2nfyWNXdxvV
 3ZQChb+Mpj4XabfEGGaWMmm+iu8rGNQ59uqPF4ojrEyAdIX9c7FgMB6LA Q==;
X-CSE-ConnectionGUID: DRB5KvMLSCuETW/jIdlDQg==
X-CSE-MsgGUID: xsCsO6ubSp+HAEeLAAT5Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40512204"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="40512204"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 22:32:59 -0800
X-CSE-ConnectionGUID: yk4Ws4y7QDiOFQnWZa9/pQ==
X-CSE-MsgGUID: MqYcGRN6R4Wflu4u67o9vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="114929756"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 19 Feb 2025 22:32:57 -0800
Date: Thu, 20 Feb 2025 14:52:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 08/11] rust/block: Add driver module
Message-ID: <Z7bRMOUA8+30nnFh@intel.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-9-kwolf@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> +impl BdrvChild {
> +    /// Creates a new child reference from a `BlockdevRef`.
> +    pub unsafe fn new(
> +        parent: *mut bindings::BlockDriverState,
> +        bref: *mut bindings::BlockdevRef,
> +        errp: *mut *mut bindings::Error,
> +    ) -> Option<Self> {
> +        unsafe {
> +            let child_bs = bindings::bdrv_open_blockdev_ref_file(bref, parent, errp);
> +            if child_bs.is_null() {
> +                return None;
> +            }
> +
> +            bindings::bdrv_graph_wrlock();
> +            let child = bindings::bdrv_attach_child(
> +                parent,
> +                child_bs,
> +                c"file".as_ptr(),

c literal starts from v1.77, and there's a workaround provided by
c_str.rs:

c_str!("file").as_ptr()

> +                &bindings::child_of_bds as *const _,
> +                bindings::BDRV_CHILD_IMAGE,
> +                errp,
> +            );
> +            bindings::bdrv_graph_wrunlock();
> +
> +            if child.is_null() {
> +                None
> +            } else {
> +                Some(BdrvChild { child })
> +            }
> +        }
> +    }
> +

