Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37401C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgP4k-0004Vz-Lj; Fri, 07 Feb 2025 09:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgP4i-0004UD-5F; Fri, 07 Feb 2025 09:11:20 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgP4f-0000zH-2C; Fri, 07 Feb 2025 09:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738937477; x=1770473477;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JaL/UL+TA4FuGB7aoV0l8ICOHuU1aCLdlnyesY6Y150=;
 b=FiK0bvrLt5YMWHUQQkigQ0A55C2DlHkpjKNuE4GKEOut8GHVenyJop+7
 PPgWpsQbTdXb5tAZwVCPHMNbrmD0k9haAq3lLfex4M1RysTS9tiWdMSOK
 VNO95tMNMfIa+3HpEQwhphQ0Z7uJBBcpDYdPvDT61gob2bkNFatiypKEl
 15RyqOXOhdBvxyr8lYWI4qclsdqd0usbRPLFPb807w6O5tJkH8byoq6MT
 hU1wuxVrkru0upWzW3p3VZ1mhH+4LmIUbW1hAZ8sKXVUBvsCYhEzjXYfn
 xzivPv7ZURSj3kxEwh1/L7n+JrmEsyRtqhk2oM5Yu7NC/NfX1a04QeY8l A==;
X-CSE-ConnectionGUID: +lST5y+UQUi1g/Q4ud1OAA==
X-CSE-MsgGUID: LM45NlUDQ7SISI6Sw8LGMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="56993524"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="56993524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 06:11:13 -0800
X-CSE-ConnectionGUID: +HvVvVtjQj2SGErFsBuUhA==
X-CSE-MsgGUID: RAxQKGDPQdi+IRSOPzlEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="111358441"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 07 Feb 2025 06:11:10 -0800
Date: Fri, 7 Feb 2025 22:30:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/10] rust/timer/hpet: define hpet_cfg
Message-ID: <Z6YZEGCk0hfHxhl4@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-8-zhao1.liu@intel.com>
 <f2339eb2-f129-48a7-aed8-9d4ee6bcdf05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2339eb2-f129-48a7-aed8-9d4ee6bcdf05@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 29, 2025 at 11:58:46AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:58:46 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 07/10] rust/timer/hpet: define hpet_cfg
> 
> 
> 
> On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > @@ -5,6 +5,7 @@ edition = "2021"
> >  authors = ["Zhao Liu <zhao1.liu@intel.com>"]
> >  license = "GPL-2.0-or-later"
> >  description = "IA-PC High Precision Event Timer emulation in Rust"
> 
> Please add
> 
> rust-version = "1.63.0"
> 
> here.

Done.

> > +        // SAFETY: all accesses go through these methods, which guarantee
> > +        // that the accesses are protected by the BQL.
> > +        let fw_cfg = unsafe { &mut hpet_fw_cfg };
> 
> Clippy complains about references to static mut; use
> 
>    let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
> 
> to make it happy; same below in update_hpet_cfg().
> 

Fixed. Thanks!!

Regards,
Zhao


