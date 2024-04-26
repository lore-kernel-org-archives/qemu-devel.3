Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27484C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 07:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0G1G-0007W5-9F; Fri, 26 Apr 2024 03:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0G1C-0007S9-Tn
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 03:29:14 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s0G1A-0008K7-LM
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 03:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714116553; x=1745652553;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8CDqikRy8rQu2vPZyFLPE+tRdsZUnZr7MlJ8t6mWajg=;
 b=QyVe7LdaQoMFbFKRxo3lx8O279cIzcA7oRZIM/OVVIU5i4Cy/SYxd5VH
 PS7qnzy7vNbsBG6WhRJnMIIWeCDOUZwwpOeWYP06NRAcB3KNeB7zMyDrd
 Zc/GrlKPoNc3F37jvxBbRnQXl2vEg6y7Ku5Ev1X85KFrGliXyHhEXW7rX
 kgMI72ZV9eNgbydurpqc7RDAR/Evq2a64ZOhQ4G8+NXd0pcbuIR3sBn/u
 ZDxeSqkPlhHQyTRHbqnpPQolD77lR415xZ6nGgTiO5+O1XBvWzcp5AI2Q
 O902MrWKQoYRayXlZttGYWclVa4EMmQGLZKmjCs3y8BjVw79K2WfvIUGe A==;
X-CSE-ConnectionGUID: oUnkS4ucSIeSrsW1yl7flQ==
X-CSE-MsgGUID: Sf985lw1T2eVEffPvz34pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20396544"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; d="scan'208";a="20396544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 00:29:09 -0700
X-CSE-ConnectionGUID: aHOpPkvoTISpXj8MG+kPpQ==
X-CSE-MsgGUID: aH0gI8DjTGSKZSM5LG/vaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; d="scan'208";a="25382483"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2024 00:29:07 -0700
Date: Fri, 26 Apr 2024 15:43:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/63] First batch of i386 and build system patch for
 QEMU 9.1
Message-ID: <ZitbE46sNJAQN0xk@intel.com>
References: <20240424081443.75869-1-pbonzini@redhat.com>
 <7217032f-2d44-4c9b-aa73-1b97787de03e@linaro.org>
 <CABgObfYAJQS-x6NRnjF5T-i0FmKwJR5eK0XQ8t1HBBTbP2QDkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYAJQS-x6NRnjF5T-i0FmKwJR5eK0XQ8t1HBBTbP2QDkw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Paolo,

On Fri, Apr 26, 2024 at 07:21:12AM +0200, Paolo Bonzini wrote:
> Date: Fri, 26 Apr 2024 07:21:12 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PULL v2 00/63] First batch of i386 and build system patch for
>  QEMU 9.1
> 
> On Wed, Apr 24, 2024 at 8:49 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 4/24/24 01:14, Paolo Bonzini wrote:
> > > The following changes since commit 62dbe54c24dbf77051bafe1039c31ddc8f37602d:
> > >
> > >    Update version for v9.0.0-rc4 release (2024-04-16 18:06:15 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> > >
> > > for you to fetch changes up to 7653b44534d3267fa63ebc9d7221eaa7b48bf5ae:
> > >
> > >    target/i386/translate.c: always write 32-bits for SGDT and SIDT (2024-04-23 17:35:26 +0200)
> >
> > Sorry, I've already merged v1.  You'll need to adjust the fix on top.
> 
> It's the same tag, so you actually merged v2.

The difference between v2 and v1 is about fixing two of Xiaoyao's
comments, right?

Currently in master, luckly the CPUID fix [1] has landed, but another
comment fix [2] hasn't land. So Richard merged v1 and helped fix [1],
[2] did not catch up with v1 merge window. ;-(

I have a misc kvm cleanup series coming up soon that I can also include
[2]'s fix there.

[1]: https://lore.kernel.org/qemu-devel/b9043b52-5fdf-4349-8a56-c1418feb1bbd@intel.com/
[2]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/

Regards,
Zhao


