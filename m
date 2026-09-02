Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102BC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hzc-0005MN-V2; Wed, 02 Sep 2026 06:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1hzb-0005ME-HD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:14:55 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1hzZ-0004ei-Id
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788344093; x=1819880093;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0oo1wqzF82q5JQZfuhwF7jpKIwtqpn8i98POmVLmVu0=;
 b=SwGo28PR0j9lkArEnT+TL36CJUxaVee7qq8F8wNHlyfw1za3oFUvsWXx
 H0enGNh459Qvh4TlZ7xZ8nxmMYn48GaFv6CUWaAZ54KOAzUagTbF42mBO
 r4ZrFhofB63luGiK32GHcxrYd2DsJRMmCi9syr8m6PRl7MBTd1TK5ppJg
 SA55iekVGB3f2+Jihx9gj1W4myIECfcQHWeMusNyEW9iRjW+hEUaYr4BB
 f2ALQwks5/B+eebcN8zmJbrHfFeB3Ckrsbj6vNX7WQm+bIPJkxeaKrQBT
 +cEe3DhE52cfRsMccqY+HXr2RAkF6yCn2M8kNzEV1GTt2khHnECRgkh0v w==;
X-CSE-ConnectionGUID: pWK8A5qGTYC4UJVXUxJ5SA==
X-CSE-MsgGUID: 2ZBmBA0eTB6M23bARu/L3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100311454"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="100311454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:14:50 -0700
X-CSE-ConnectionGUID: SnSMoeG5QHaAuL91f2HrOw==
X-CSE-MsgGUID: O5H/GUblT5CzyATb7XafNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269389650"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2026 03:14:49 -0700
Date: Wed, 2 Sep 2026 18:14:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com,
 binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 1/5] target/i386: Add support for LASS in CPUID enumeration
Message-ID: <apf3FycK5uWh+yq5@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-2-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-2-kishen.maloor@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 25, 2026 at 08:57:30PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:30 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 1/5] target/i386: Add support for LASS in CPUID enumeration
> X-Mailer: git-send-email 2.47.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Linear Address Space Separation (LASS) is a security feature that
> prevents a class of side-channel attacks relying on speculative
> accesses across the user/kernel boundary. Paging, along with SMEP
> and SMAP, already provides mode-based access protection, but
> enforcing it requires a page walk whose timing can leak the
> layout of kernel memory.
> 
> LASS applies the equivalent protections during linear-address
> pre-processing, before any page walk. Given the usual partitioning of
> the linear address space into a user half (bit 63 clear) and a
> supervisor half (bit 63 set), an access targeting the opposite half is
> rejected on the basis of bit 63 alone, raising a #GP. LASS is enabled
> via CR4.LASS[bit 27] and applies only in IA-32e mode.
> 
> Feature bit:
>   CPUID.(EAX=7,ECX=1):EAX[6]
> 
> A CPUID_7_1_EAX_LASS macro was previously added in commit 31df29c532a9
> ("i386/tdx: Add supported CPUID bits related to TD Attributes"), but the
> bit was left unnamed in feature_word_info[FEAT_7_1_EAX]. Add the "lass"
> feature name to expose it via -cpu host, -cpu max, or an explicit +lass.
> 
> Exposing LASS to a guest also requires KVM support: KVM must validate
> the CPUID bit and CR4.LASS, and enforce LASS violations in its
> instruction emulator.
> 
> LASS is not implemented in TCG, so the bit is not added to
> TCG_7_1_EAX_FEATURES.
> 
> More details can be found in the Intel 64 and IA-32 Architectures
> Software Developer's Manual, Volume 3A, Section 4.3,
> "Linear-Address-Space Separation (LASS)".
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> [kishen: rewrote commit message, rebased]
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> KVM support for LASS is currently under review:
> https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/
> 
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


