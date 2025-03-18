Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08511C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 06:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQO8-0007an-5H; Tue, 18 Mar 2025 02:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQNu-0007Wu-6i; Tue, 18 Mar 2025 02:25:10 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQNr-0005jJ-DR; Tue, 18 Mar 2025 02:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742279103; x=1773815103;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3Pq6PWKDudu7MLTJ+MS6d3xcTEicGhPOVkg5N/uaMFQ=;
 b=l3mNYUl4ZVW2EgKwAvnS68hXtopFDpdJ5s3XBIfrrgE/4SaAoWcipXLi
 nG00r3xL0yW0AXHuQhnPPnmDCdBusxRuXUOuudAmc5SdVJBfDukeqj/Z6
 3L+z+jGrP7s3uM9MK9yEIlkxpLNVUzjVjIQUHG6u01t8WsKCerZ1DyM6Y
 nMa9TNGvUEKPFsJy8jZYpaYQcXbhMs+M7KbAsh5sRHCxL0sgYaMOj44dI
 ig+FvyRs/idxuRyb+2f9K4JYG63jhUozRvANiN65HvkKuEvIzzpSgT0mL
 1MxkwZaVhNuygUqpNyTaCn6GvmumUczJikcWJqkxdrOeK6Gq11Qe2Znmp Q==;
X-CSE-ConnectionGUID: Bl8vK+lERGS9rR4jLgIUig==
X-CSE-MsgGUID: Odqv8u2/TxWcN8CqLN3vDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42649707"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="42649707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 23:25:00 -0700
X-CSE-ConnectionGUID: Atyp8IGfTze2YERBO+ccIg==
X-CSE-MsgGUID: rFBZQ+j1T+mvKxokkTkJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="126819147"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 17 Mar 2025 23:24:59 -0700
Date: Tue, 18 Mar 2025 14:45:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 14/17] rust/vmstate: Add unit test for vmstate_of macro
Message-ID: <Z9kWeCZnCjjs2Xkp@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-15-zhao1.liu@intel.com>
 <CABgObfaHDrKPx7jRLtOn9CdjC8A1zjpAwBDuuY7WGY9bwYzckw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaHDrKPx7jRLtOn9CdjC8A1zjpAwBDuuY7WGY9bwYzckw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 06:11:35PM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Mar 2025 18:11:35 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 14/17] rust/vmstate: Add unit test for vmstate_of macro
> 
> Thanks very much for the tests!
> 
> On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > -pub use crate::bindings::{VMStateDescription, VMStateField};
> > -use crate::{
> > -    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
> > -};
> > +pub use crate::bindings::{VMStateDescription, VMStateField, VMStateFlags};
> 
> Does VMStateFlags have to be part of the public API?

I can do `use qemu_api::bindings::VMStateFlags` in vmstate_test.rs
directly, which is better since it's the raw value of VMStateField that
I need to check!

> > +    assert_eq!(foo_fields[0].info, unsafe {
> > +        ::core::ptr::addr_of!(vmstate_info_int8)
> > +    });
> 
> You can use & instead of addr_of here.

Thanks! Will fix.

Regards,
Zhao


