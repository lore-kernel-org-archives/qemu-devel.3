Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C602606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ha7byYqT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLy8-0005Mu-JQ; Mon, 09 Nov 2026 04:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xQLy7-0005Mg-1f
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:47:15 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xQLy4-0006qc-J3
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794217633; x=1825753633;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=aiqAz1BjfoRhtEiYBw+kZ8fcint9a1uCK1uGb/n3OzQ=;
 b=Ha7byYqTFW+ei+V41N1PNnGqgPtN5C4FFIbUqX0hQXBMKpR+YH/pmADE
 fRr72xlmJtQxLqTc9SAhRAFKZTUY2MNC+K3St0fS6TCF++AujB3Yo8B7n
 SQ1OLmTJFXWrjCgatVl4GLndvq4o7hlkOllHl1SNJ52hksuC8qCmKW5JN
 ITt8BqxsDJyAH+noq0FIS9mauiM1Vj+Qwz5XiEMij1UgLQir1sxC/IKqS
 TCsnjnYIw0RdWb9Xr6Fe4Q4xk2CJQvOtJuI8yL24Kh9piUJ0YpXCAxma+
 Ds95fMhMNA7xmbcV5ErFZm1Zld3IhX/omgFeSiMwHnO6ar7OsIw5QKjfO A==;
X-CSE-ConnectionGUID: 4aGxGXJpREOFSfEtMe0guA==
X-CSE-MsgGUID: NrEQg5EXQp+uJprRquSV+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2926483"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2926483"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 01:47:08 -0800
X-CSE-ConnectionGUID: BtV5+e1tTnaKgreloKVcWA==
X-CSE-MsgGUID: VKcaUcLkSBau/6t9qnpFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8164748"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa009.fm.intel.com with ESMTP; 09 Nov 2026 01:47:07 -0800
Date: Mon, 9 Nov 2026 17:47:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: QEMU Sashiko
Message-ID: <avGWmoZUBkFcU8l4@intel.com>
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 <de5dd85c-e486-40b3-a0ce-613cc102089d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de5dd85c-e486-40b3-a0ce-613cc102089d@oss.qualcomm.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:06:45AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Thu, 29 Oct 2026 09:06:45 +0100
> From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Subject: Re: QEMU Sashiko
> 
> On 29/10/26 00:32, Alistair wrote:
> > Hey,
> > 
> > Sashiko just merged initial support for QEMU [1].
> > 
> > For those who don't know, Sashiko is a LLM powered review bot used for
> > the Linux kernel. When people send patches to LKML Sashiko reviews the
> > patches and responds to the mailing list with any issue that it finds.
> > 
> > Like all LLM tools, it is both useful, but also verbose, prone to
> > hallucinations and misses things (like humans do to though). The
> > general consensus in the kernel community is that it's a useful and
> > valuable tool.
> > 
> > Sashiko is just a Rust application and prompts, it doesn't include a
> > LLM and you can use a range of different LLM backends.
> > 
> > Google sponsors the development and runs a Linux instance. So you can
> > see the hosted Linux instance here: https://sashiko.dev/ and it uses
> > Gemini for the LLM which Google pays for. It seems like there is also a
> > GCC one starting up.
> > 
> > The cool thing about Sashiko though is you can run it locally as well,
> > so you can use it to test your patches before sending them to LKML, as
> > long as you have a LLM backend you can use.
> > 
> > So, now that Sashiko also supports QEMU there are two exciting use
> > cases:
> > 
> > 1. Developers can run it locally to review their patches before sending
> > them to the list. This can catch issues before sending patches
> > 
> > 2. Maintainers can run an instance to review patches. How you set this
> > up depends on the maintainer and how many tokens you have. Pointing it
> > at the list directly and running it for all patches might be too much,
> > but some combination of manually triggering it for certain patches
> > seems to work well. The Settings.toml file can be setup based on what
> > you want to do.
> > 
> > The hope with this is to save maintainers time as Sashiko can catch
> > issues without requiring much time from a maintainer.
> > 
> > QEMU support in Sashiko is very new, so it will take some tweaking to
> > improve things, but it is at least a good starting place.
> > 
> > 1:
> > https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e6c834d8176f70
> 
> I'm glad you added projects/qemu/ directory there; some time ago
> Zhao and myself tried to leverage LLM to review QEMU and reduce
> maintenance burden but there was little community interest and
> some negative feedback so we didn't pursued on the list.
> https://lore.kernel.org/qemu-devel/afxbDjQEWJZ6P9oe@redhat.com/
> https://lore.kernel.org/qemu-devel/arpINtziWCbjENeo@intel.com/

Thanks, good to know this!

From my own experience, LLM-driven review (for QEMU) is indeed very
helpful. I think there are two aspects that make LLM reviw effective:
one is the prompt (or guidance), and the other is agent orchestration -
especially multi-stage sub-agent orchestration.

Regarding the second point, I think this is the key factor that makes
Sashiko produce better results compared to direct prompting. In the
project Philippe and I mentioned above (https://github.com/trueptolemy/review-prompts),
agent orchestration was also implemented through prompts, and we were
ultimately able to achieve effects similar to Sashiko — however,
multiple sub-agents do lead to significant token consumption :-).

Coming back to the first point, the recent `qemu-codebase` skill has
inspired me. From a long-term (ideal) perspective, guidance-type prompts
about code are actually unnecessary. As long as the documentation is
comprehensive, the `qemu-codebase` skill can fully direct the LLM to the
relevant docs. Therefore, if third-party prompts about code (perhaps
compiled from mailing list discussions) can produce better results, it
suggests that certain content should be documented.

So, I think the best and ideal approach is to identify documentation gaps
from review prompts, and we can consider to feed that back into in-tree
contributions (which in turn can reduce the need for out-of-tree review
prompts) - finaly, third-party review tools are only responsible for
orchestration, while all code-related rules and guidelines are in-tree.

Thanks,
Zhao


