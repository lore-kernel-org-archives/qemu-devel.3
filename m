Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E99D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 08:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV46P-00077v-2I; Mon, 15 Dec 2025 03:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV46N-00077O-6R
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 03:38:43 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV46E-0007R2-H7
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 03:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765787914; x=1797323914;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WVWtWeaAiD3LHgvNa+L+wwWo0KlDqDcKRJVtbfhE1QA=;
 b=NH0QknUmSKzQsH06vlgNEVgj7GUcZyitJge6ml20zYY3AkmlAqbS7TXZ
 2kGav0lhIdJHieAmUFXKfbUAm5S9eeeXxTiagDk93CHuiYgKrQ6SOOW5J
 Dxd1tZ7Y/PaVd44XDPwW31GaBRI1SFMNj7zfM/FkozTwahUzerNxx4YoK
 xgOwR+xyCQwUd3C77hQkUMlrhmA2lteR/bMI1A5PpMbdktJJpSjRLhCNk
 PAE4hnmWohvmocKTeqGRnqQdoj96Ed+H5xe29xGfWqiSiyAtr0FXlKRU+
 WJIox120bssrs8tRYIuyE3pvWfSmuKYO4Aky4okAM7fKQ/iYgXB/yNBjZ Q==;
X-CSE-ConnectionGUID: iqSdHMoCQSio+/jloXxBnQ==
X-CSE-MsgGUID: /MinGtCgRFKtRipiuuuezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="70263705"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="70263705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 00:38:32 -0800
X-CSE-ConnectionGUID: 0I9z6EBESbSh4qoHz5yKxA==
X-CSE-MsgGUID: b9rAYJy3TACDQauf3V9JuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="202578143"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 15 Dec 2025 00:38:30 -0800
Date: Mon, 15 Dec 2025 17:03:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, TonyWWang@zhaoxin.com
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
Message-ID: <aT/O1u22C1o3p5sn@intel.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-4-ewanhai-oc@zhaoxin.com>
 <aSVcOX5WvJYjIEbM@intel.com>
 <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20164c5-291c-4646-86cb-fddc69542599@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, Nov 25, 2025 at 04:57:04PM +0800, Ewan Hai wrote:
> Date: Tue, 25 Nov 2025 16:57:04 +0800
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin
>  Shijidadao-Client CPU model
> 
> On 11/25/25 3:35 PM, Zhao Liu wrote:
> > 
> > 
> >> +        /*
> >> +         * TODO: When the Linux kernel introduces other existing definitions
> >> +         * for this leaf, remember to update the definitions here.
> >> +         */
> > 
> > This TODO seems a bit vague; it's best to explicitly list the existing
> > features that are currently missing. Otherwise, maintainers won't be
> > able to understand or clean up this TODO either.
> > 
> 
> I agree. The same problem also exists in the YongFeng vCPU model. For this
> series, I can drop the vague TODO and instead add a more explicit comment that
> documents which CPUID.C000_0001.EDX bits are intentionally missing today. In
> addition, I can post a small follow-up cleanup patch to fix the YongFeng model
> in the same way, so the two Zhaoxin models stay consistent. If you prefer, I can
> also fold the YongFeng comment update into this series as an extra patch.

Yes, it's good to make everything clear and I think it's better to
include your extra patch into this series to help maintainer review/pick
in one goes.

> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
> 
> We previously tried to upstream all these extra feature bits in one
> patch(https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
> but the maintainer rejected it because there was no in-tree code using these
> features yet. So our current plan is to add the CPUID bits together with real
> kernel users step by step.

I see. I think it's enough to document missing CPUIDs in comment.

...

> > (Based on my personal experience, the absence of SMAP seems a bit
> > odd. Could it be a hardware bug in a specific stepping?)
> > 
> 
> This is not a stepping-specific silicon bug. For this product family, SMAP
> support was intentionally not enabled in the final product because our internal
> performance evaluation showed an unacceptable performance impact in certain
> workloads. The v2 CPU model therefore keeps "smap" off to reflect the actual
> shipped behavior, while the v1 definition with SMAP enabled is kept for
> customers who need to model early v1 silicon where SMAP is still available.

v1 is not the final product, then I think it's not necessary to upstream
it. For example, these Intel CPU models are basically all targeted at
the final products. But unluckily, engineering samples may have bugs so
we have to add or remove features based on what the final products
support. So if the final product is clear from the beginning, there's no
need to take intermediate steps.

BTW, even with v2, user can still enable smap by +smap.

> >> +                .props = (PropValue[]) {
> >> +                    { "xsavec", "on" },
> >> +                    { "xgetbv1", "on" },
> >> +                    { "xsaves", "on"},
> >> +                    { "vmx-xsaves", "on"},
> >> +                    { "smap", "off" },
> >> +                    { /* end of list */ }
> >> +                },
> >> +            },
> > 
> > BTW, if the differences aren't too significant, is it possible to merge
> > the server and client models? :)
> > 
> 
> From the user point of view, I slightly prefer keeping separate
> Shijidadao-Client and Shijidadao-Server models.
> 
> The main reason is that customers who want a "full-feature" vCPU that behaves
> very close to a specific physical product can simply pick the corresponding
> model name, without having to remember a set of extra "-cpu ..., +-feature"
> overrides. If we merge everything into a single Shijidadao model that
> corresponds to a more restricted baseline, users who want the full configuration
> would need to explicitly enable multiple features (such as the additional XSAVE
> bits) on the command line, which is easier to get wrong and less user-friendly.

Could we make Shijidadao-Client as a v2 of Shijidadao-Server, and create an
alias for this v2?

.alias = "Shijidadao-Client"

Then we could rename Shijidadao-Server to Shijidadao, and its v2 is for
client.

> This is also aligned with how QEMU models other vendors' micro-architectures
> where client and server products have slightly different feature sets.

The main use case for CPU models is to easy migration across mixed CPU
clusters [*]. So, IMO, not all products require a model.

[*]: https://lore.kernel.org/qemu-devel/ZJrJYG1dICHjKx09@redhat.com/

> Thanks again for the review!

Thanks for your patience and sorry for my late reply.

Regards,
Zhao


