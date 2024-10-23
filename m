Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93961CF538B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bl4-00023w-Cw; Wed, 23 Oct 2024 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3bl1-00023Z-W5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:50:40 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3bl0-0007Pv-3R
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729691438; x=1761227438;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x2SVOn5EVaxN6tWLEBk0VNYj32XuJW6iCPFSmbL6jPw=;
 b=Ok62nfOAgwm4jwbg7AbOhaBr40XvCWsNA0YEp+jzyVQsvhZHJVkhnicg
 lxrJh5fA215sGghejwWX45FQaS11GrZGKS18R3AS+IN3OI8olXnEC3BCF
 6Cau1JaUiN8LUo+gBfvQNPhHCop+SVjkIxsMHu1mBLCcKKiHUhkbH2RFv
 sI+UcEM+sztPRAUKESvGKIixBAZSw+w1clrjGZNXmUf0gz92PKVXmDiiL
 pckpWX6k0NZOreND7gj5QqehJBV++N5GspgWEmE1JH1QkpNzBO4waJYM5
 1W8Twogj0xW0kFwnUxwnUrumGH/We4d3gJCUR2sxGuZpNLJZumpYtl6M2 A==;
X-CSE-ConnectionGUID: kds+lUw7T4S4MsKk2HwIfQ==
X-CSE-MsgGUID: CEvFxYagSUueZN1Di2aX3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="28717399"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="28717399"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 06:50:34 -0700
X-CSE-ConnectionGUID: huxu/qKCSPO9VNviuQE2Ag==
X-CSE-MsgGUID: DcmZRVfmRluuLIdoRfNg0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="111000317"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 23 Oct 2024 06:50:33 -0700
Date: Wed, 23 Oct 2024 22:06:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 05/13] rust: remove uses of #[no_mangle]
Message-ID: <ZxkC+QEDUKv8UqrW@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-6-pbonzini@redhat.com>
 <c77c8129-a732-4c80-b9de-61a92a7d97c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77c8129-a732-4c80-b9de-61a92a7d97c2@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Wed, Oct 23, 2024 at 12:48:33PM +0200, Paolo Bonzini wrote:
> Date: Wed, 23 Oct 2024 12:48:33 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2 05/13] rust: remove uses of #[no_mangle]
> 
> On 10/21/24 18:35, Paolo Bonzini wrote:
> > @@ -566,7 +563,6 @@ pub fn update(&self) {
> >   /// # Safety
> >   ///
> >   /// We expect the FFI user of this function to pass a valid pointer for `chr`.
> > -#[no_mangle]
> >   pub unsafe extern "C" fn pl011_create(
> >       addr: u64,
> >       irq: qemu_irq,
> This _needs_ to be no_mangle actually, because it is called from C.
>  

I'm a bit uncertain whether the "pub" keyword here should be removed.

I understand that pub and private are based on modules and do not apply
to FFI, but I haven't found any related documentation to confirm this.

However, technically, removing the pub here does not seem to cause any
issues during compilation and runtime.

Additionally, the pub keywords in the other functions involved in this
patch (except for the one in device_class_init) can also be removed, as
they are either only used as C callbacks or are indeed only used within
the current crate after macro expansion.

-Zhao


