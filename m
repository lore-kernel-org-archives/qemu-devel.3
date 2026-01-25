Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B210E63C82
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 08:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjvF8-0003uR-IU; Sun, 25 Jan 2026 03:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vjvF4-0003pr-Mx
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 03:13:06 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vjvF1-0001gE-Rl
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 03:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769328784; x=1800864784;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Jn8uqfx7qSGHxVBxgUF6hCOAJlmyJYwvFLs0epqJEVI=;
 b=A2eZFzP/YTuYM2v4remBC3j9tGY2k/KUN5iY5BqcUmnApFb60SQL2Cw/
 OyHe4mIiEHQsrkG0J+beH5SHWGlKuNUCxOFCRwo+C+yPsXWZuM+4z1+kR
 DGPci1l7UicyrxfpxLbVvwTgXHB1S/R1priQ1oGEJ9nN3w/D8HrLRbXPS
 lLDniA7UmZ7vXPc1Dd/uV2Gjrw1GoP1lJBfKHdNYj9hNNW38OJ8sLDlWo
 xWdxSwdJCjsYU6otN7Lw7HnFCh/cYSy1eCBC9qME8+6Os2PuLlqaEu/Se
 gjmDgzkYt9W265q+syHL3NMkVEoaXStTAEpuHMP1p9VkV/3HcdKIL8g4X Q==;
X-CSE-ConnectionGUID: uAez5h0ST0S1HBzJy1Wirg==
X-CSE-MsgGUID: aIK+HYSARHq1197lYgl5EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="73114046"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; d="scan'208";a="73114046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2026 00:12:59 -0800
X-CSE-ConnectionGUID: ZGNQJYr6S9ijwnHjVJpHAQ==
X-CSE-MsgGUID: 6TvzgI8YR9iGQ+vdvlFsiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; d="scan'208";a="207303516"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 25 Jan 2026 00:12:57 -0800
Date: Sun, 25 Jan 2026 16:38:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chen, Zide" <zide.chen@intel.com>,
 "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, xiaoyao.li@intel.com,
 Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 6/7] target/i386: Make some PEBS features user-visible
Message-ID: <aXXWhqUuPQaxDKCV@intel.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
 <20260117011053.80723-7-zide.chen@intel.com>
 <56dd6056-e3e2-46cd-9426-87c7889bed49@linux.intel.com>
 <513c6944-b80a-46f2-ad6c-4de77dac4b09@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <513c6944-b80a-46f2-ad6c-4de77dac4b09@intel.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zide & Dapeng,

> On 1/18/2026 7:30 PM, Mi, Dapeng wrote:
> > 
> > On 1/17/2026 9:10 AM, Zide Chen wrote:
> >> Populate selected PEBS feature names in FEAT_PERF_CAPABILITIES to make
> >> the corresponding bits user-visible CPU feature knobs, allowing them to
> >> be explicitly enabled or disabled via -cpu +/-<feature>.
> >>
> >> Once named, these bits become part of the guest CPU configuration
> >> contract.  If a VM is configured with such a feature enabled, migration
> >> to a destination that does not support the feature may fail, as the
> >> destination cannot honor the guest-visible CPU model.
> >>
> >> The PEBS_FMT bits are intentionally not exposed. They are not meaningful
> >> as user-visible features, and QEMU registers CPU features as boolean
> >> QOM properties, which makes them unsuitable for representing and
> >> checking numeric capabilities.
> > 
> > Currently KVM supports user space sets PEBS_FMT (see vmx_set_msr()), but
> > just requires the guest PEBS_FMT is identical with host PEBS_FMT.
> 
> My mistake — this is indeed problematic.
> 
> There are four possible ways to expose pebs_fmt to the guest when
> cpu->migratable = true:
> 
> 1. Add a pebs_fmt option similar to lbr_fmt.
> This may work, but is not user-friendly and adds unnecessary complexity.
> 
> 2. Set feat_names[8] = feat_names[9] = ... = "pebs-fmt".
> This violates the implicit rule that feat_names[] entries should be
> unique, and target/i386 does not support numeric features.
> 
> 3. Use feat_names[8..11] = "pebs-fmt[1/2/3/4]".
> This has two issues:
> - It exposes pebs-fmt[1/2/3/4] as independent features, which is
> semantically incorrect.
> - Migration may fail incorrectly; e.g., migrating from pebs_fmt=2 to a
> more capable host (pebs_fmt=4) would be reported as missing pebs-fmt2.

For 2) & 3), I think if it's necessary, maybe it's time to re-consider
the previous multi-bits property:

https://lore.kernel.org/qemu-devel/20230106083826.5384-4-lei4.wang@intel.com/

But as for now, I think 1) is also okay. Since lbr-fmt seems very
similar to pebs-fmt, it's best to have them handle these fmt things in a
similar manner, otherwise it can make code maintenance troublesome.

> Given this, I propose the below changes. This may allow migration to a
> less capable destination, which is not ideal, but it avoids false
> “missing feature” bug and preserves the expectation that ensuring
> destination compatibility is the responsibility of the management
> application or the user.
> 
> BTW, I am not proposing a generic “x86 CPU numeric feature” mechanism at
> this time, as it is unclear whether lbr_fmt and pebs_fmt alone justify
> such a change.
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 015ba3fc9c7b..b6c95d5ceb31 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1629,6 +1629,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .msr = {
>              .index = MSR_IA32_PERF_CAPABILITIES,
>          },
> +       .migratable_flags = PERF_CAP_PEBS_FMT,

About the migration issue, I wonder whether it's necessary to migrate
pebs-fmt? IIUC, it seems not necessary: the guest's pebs-fmt depends on
host's pebs-fmt, but I'm sure what will happens when guest migrates to
a mahince with different pebs-fmt.

note, lbr-fmt seems not be migrated.

Thanks,
Zhao


