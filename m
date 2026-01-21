Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FF4C44525
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXs3-0005lF-Bg; Wed, 21 Jan 2026 08:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXs0-0005kC-Pi
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:03:36 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXry-0004vU-SI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769000615; x=1800536615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hIL8zMa8hY5TMteGWocN2wSEkFwQBU/y01MYZGrbQfk=;
 b=FvaHC7eKIXLgJUHRF0MdFck5Chtewz3Z+QQbe76lOLIw/KyyfKLxqAZW
 ld2dSSyx3DwmzKJRMvAV9kT3n4xUOCyiDHlCeg123PK4yCPUbPFgv5ysY
 wn4IN/F0rVXarnd/V2R+g+nSWSZS9pxaRa6oghXDHmmx09z44MLPki1Cx
 pflVtQZOXjwWl/X16RF2BZ5qFPYp7hUXiCuDryR8WwkWZlboaXjfm9/ck
 rEr1L5TFlz+VLGIhSl/4BngrXeHyUo2STuzn6JYrqGzR1FACua1aLJhbo
 tIt4CsZkywbMM0R2706Pg+OjDi0tHM2JMeHTKdjr6uFOcvamsONwQRK2E g==;
X-CSE-ConnectionGUID: K/DOeN2HSQeZsYfV4k4f/A==
X-CSE-MsgGUID: fhvxa7qNRxS8d0wIgR5SYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57787180"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="57787180"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:03:33 -0800
X-CSE-ConnectionGUID: 2DMRan3XTQusydQo611PHQ==
X-CSE-MsgGUID: 8YR67kEBRNGggPLjfq1wfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="205573176"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 21 Jan 2026 05:03:31 -0800
Date: Wed, 21 Jan 2026 21:29:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
Message-ID: <aXDUn6GY9YPCfq8D@intel.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

On Thu, Jan 08, 2026 at 09:10:28PM -0500, Ewan Hai wrote:
> Date: Thu, 8 Jan 2026 21:10:28 -0500
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
>  Yongfeng model
> X-Mailer: git-send-email 2.34.1
> 
> Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
> accurately list the missing features instead of the generic TODO message.
> 
> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
> 
> We previously tried to upstream all these extra feature bits in one patch
> (https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
> but the maintainer rejected it because there was no in-tree code using these
> features yet. So our current plan is to add the CPUID bits together with real
> kernel users step by step, Once full or partial in-tree implementations of
> these features are merged, we will update these definitions accordingly and
> potentially introduce corresponding support in QEMU.
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good cleanup,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


