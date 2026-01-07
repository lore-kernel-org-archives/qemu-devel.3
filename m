Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4508CCF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKFZ-0003po-Cv; Tue, 06 Jan 2026 22:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdKFH-0003Zl-Eh
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:30:07 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdKFD-0001nX-7y
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767756599; x=1799292599;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tKrYOOr7sgEAJxrTtz6h28vaixAwN0LfW1so6P3IumU=;
 b=hNI70i3pOWpnR6Ojx6bvxtHlnlXM3DYSOs1ZinpAVZVYYDJrgh4nCvN3
 coyMBud07MGYSUuMixBQPucfJwDxRnpXFTt4wtym8cx6q6HQ8eYEaVLaX
 osoppT6wafR/3t/fOoAFzuYG94TahPhYVRdjJSozYhvtUq52JJEfQrubH
 t0ulxjyn2msno0cYvRFpno+KK6PrJQoKql59q07auaOdkAGHddgN0ZO+4
 dV/4SCaVMpSDcYKZ8dOAOEGFzXCfAt4xl5/smxhGXe2hKnJWnUVyIdI7O
 AMv0iv1pDl0t/msfWH/zTk0lI64oUYJP5SfWr+HELOA5xCA/B2NciGD6k w==;
X-CSE-ConnectionGUID: kFgAbhAuRyeMslAXi7h7pw==
X-CSE-MsgGUID: snJXb2OES8KylIcA+DIx6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69283417"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69283417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 19:29:56 -0800
X-CSE-ConnectionGUID: w0EPpG7WQKajWuFW3FRBZA==
X-CSE-MsgGUID: c2+C3AvxTLiolqXeluVivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="233515301"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 06 Jan 2026 19:29:55 -0800
Date: Wed, 7 Jan 2026 11:55:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, TonyWWang@zhaoxin.com
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
Message-ID: <aV3ZKFlCGFyeZ0wh@intel.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-4-ewanhai-oc@zhaoxin.com>
 <aSVcOX5WvJYjIEbM@intel.com>
 <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
 <aT/O1u22C1o3p5sn@intel.com>
 <a8516d27-0ee9-4139-9d47-51eda832c219@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8516d27-0ee9-4139-9d47-51eda832c219@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

> >> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
> >> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
> >> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
> >> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
> >>
> >> We previously tried to upstream all these extra feature bits in one
> >> patch(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
> >> but the maintainer rejected it because there was no in-tree code using these
> >> features yet. So our current plan is to add the CPUID bits together with real
> >> kernel users step by step.
> > 
> > I see. I think it's enough to document missing CPUIDs in comment.
> > 
> 
> Would the following comment be acceptable?
> 
> /*
>  * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
>  * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
>  */

Yes, look good to me.

> Do you think I should also include the lore link in the commit message/cover
> letter for additional context?

Yes, mentioning the link in commit message is good. More information is
helpful.

> > Could we make Shijidadao-Client as a v2 of Shijidadao-Server, and create an
> > alias for this v2?
> > 
> > .alias = "Shijidadao-Client"
> > 
> > Then we could rename Shijidadao-Server to Shijidadao, and its v2 is for
> > client.
> > 
> >> This is also aligned with how QEMU models other vendors' micro-architectures
> >> where client and server products have slightly different feature sets.
> > 
> > The main use case for CPU models is to easy migration across mixed CPU
> > clusters [*]. So, IMO, not all products require a model.
> 
> For the CPU model naming/versioning, my plan is:
> The current Shijidadao will be equivalent to the old Shijidadao-Client-v2, drop
> the old Shijidadao-Client-v1 according to your advice, Shijidadao-v1 will have
> the alias Shijidadao-Client, and Shijidadao-v2 will have the alias
> Shijidadao-Server.

Migration should have more use cases for the server. Personally, I feel
using the server version as the base model might be more convenient?
Anyway, it's up to you. Overall, these are fine for me.

Thanks,
Zhao


