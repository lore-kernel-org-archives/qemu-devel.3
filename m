Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDBEC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 10:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgiWO-0004IR-IE; Sat, 08 Feb 2025 05:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiWJ-0004Hg-6w; Sat, 08 Feb 2025 05:57:07 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiWH-0001ru-PP; Sat, 08 Feb 2025 05:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739012225; x=1770548225;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DSsZrANcTJeTDe2XG2rANTgEcuJ6JlCUl4fqqBiaA08=;
 b=k5tCkcdSWQasr4yeKOft6tnKsg8cn2aI4fROX+7pzP8vnw7oJR0qZRMz
 xr6vSUdYuzAuGrPhxpIXXLX/x0H0gZOBsojAVCXXwHHzSO62jqnVPhLBK
 2bEeCwyKOJaBh7q7f44rBZL3xmpJo86QzxC/ms/WEhqR9EIM1FM83CFE3
 myi1rSOS/TodnxH0gMDa9TtGDF1grZWy6UU0BB2lYADFLaS0QP1eB8/sR
 wJoo/VD9qqGWE6hLwXq1edLN1SNET0//Zj2b3WvWy6vhQjBJGa9ib4FVe
 wKbqR4eSmsNmufTbUZQTeB9/uCg2eEBApM1V3XawoviAbyLIgp9VXYs2U w==;
X-CSE-ConnectionGUID: zDRuAsGVSTW9MtFY7BdZzw==
X-CSE-MsgGUID: 3JY5+3nqQcGFLBDVey942g==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57186324"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="57186324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 02:56:58 -0800
X-CSE-ConnectionGUID: MwZcsMT1QgC9bDvc9055Vg==
X-CSE-MsgGUID: ORrFD1u6TGy8VLnnPYicew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148955570"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 08 Feb 2025 02:56:56 -0800
Date: Sat, 8 Feb 2025 19:16:25 +0800
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
Subject: Re: [PATCH 04/10] rust: add bindings for gpio_{in|out} initialization
Message-ID: <Z6c9CWaPPnWmp3gT@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-5-zhao1.liu@intel.com>
 <5a19e7d2-9d69-45fe-812f-84145229876f@redhat.com>
 <Z6XHzXwoIklPZQ/I@intel.com>
 <CABgObfYathYPF-KWrZv+33+iEA_j=ee7eJbJmzA5F2rpY-ktqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYathYPF-KWrZv+33+iEA_j=ee7eJbJmzA5F2rpY-ktqw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> Use the "let" so that it's caught at compile time.

Thanks! Fixed.

> There's a difference with origianl C version:
> >
> > In C side, qdev_get_gpio_in() family could accept a NULL handler, but
> > there's no such case in current QEMU:
> >
> > * qdev_get_gpio_in
> > * qdev_init_gpio_in_named
> > * qdev_init_gpio_in_named_with_opaque
> >
> > And from code logic view, creating an input GPIO line but doing nothing
> > on input, sounds also unusual.
> >
> 
> Wouldn't it then crash in qemu_set_irq?
> 

Yes! Thank you for the education.

Regards,
Zhao


