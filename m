Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB68AC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 17:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgovM-0008B9-Jr; Sat, 08 Feb 2025 12:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgovE-0008AU-Nl; Sat, 08 Feb 2025 12:47:16 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgov9-0001Nz-OM; Sat, 08 Feb 2025 12:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739036832; x=1770572832;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1gK9h1vczc5j3kZbPyd0lYpHUIWHeETECrkJDpSnH9M=;
 b=WkresChNltQVKsArG7g5TmulWGn3K4vCOqdzkz06IxrKTnSnGxLML1/n
 nMEgE6zAYjKBKeZq443Sw1i+inb+7OgneZa4xgcE2Mm602zDTUPL1cWQ0
 VkET2havGiX1nBuTKj+hvbD29iDlBQ2g/KzWD9i9i316mrkQWTxpwspAy
 rBiwvIuDEf9sJI8bj4XrC6OZZNPlKctX3eyufXleR4pyQsW6ej0PyvJSp
 MnKKjAH1p0wSe2zGAiZm4MNExeQZGasr5KNyH122IPE1Nt8WGT91B+ab3
 7ByHAn4BKdHbTKhYL+7kC+uDXWMlsDilsGOIKNevTSal30dWCkMNedlsy w==;
X-CSE-ConnectionGUID: dwTUJdEDS0qNzjMX+Q0G+w==
X-CSE-MsgGUID: dX+FMNGFQaqIfkZ5ge3lIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="50300252"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; d="scan'208";a="50300252"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 09:47:08 -0800
X-CSE-ConnectionGUID: Z/D0jeOqQnqrUVP3d6mRoA==
X-CSE-MsgGUID: gHb+jhT3QCidaNTTtp6zrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111637131"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 08 Feb 2025 09:47:05 -0800
Date: Sun, 9 Feb 2025 02:06:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
Message-ID: <Z6edKxYFzA6suDlj@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-10-zhao1.liu@intel.com>
 <750f06f3-6326-473f-9d08-ad6bb1f2a54a@redhat.com>
 <Z6c4NVX4wteIEIOA@intel.com>
 <CABgObfaBLdQOf0RGbnmxYJ5qYM0Q95z-8Nx6Amwzvu-88e56zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaBLdQOf0RGbnmxYJ5qYM0Q95z-8Nx6Amwzvu-88e56zQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

> > > This needs to be "match addr & !4".
> >
> > I understand it's not necessary:
> >
> > In timer_and_addr(), I've masked the address with 0x18.
> >
> >     fn timer_and_addr(&self, addr: hwaddr) ->
> > Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
> >         let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
> >
> >         if timer_id > self.num_timers.get() {
> >             None
> >         } else {
> >             Some((&self.timers[timer_id], addr & 0x18))
> >
> 
> Ah, this should be 0x1C (or perhaps 0x1F). Otherwise there is a bug in
> accessing the high 32 bits of a 64-bit register; shift will always be 0 in
> HPETTimer::read and write.

Yes, you're right. Then we should use 0x1F so that invalid access could
detected (or loged in future) and ignored.

Based on the similar reason, C side also need to use "addr & (0x1f | ~4)"
instead of 0x18 to catch invalid access. If I'm right, I can submit a
fix.

Thanks,
Zhao


