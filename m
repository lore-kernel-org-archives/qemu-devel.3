Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB71C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNMd-0007Ko-8r; Mon, 24 Aug 2026 01:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNMb-0007KC-Bh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:36:53 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNMX-00082m-Do
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787549809; x=1819085809;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OzBmje/LGNWvTvM0XPtRiX5VSU/TrOMTu/DYVMxTT4Y=;
 b=aDUzCFZunNnqGFeZs7LSgOm6B5Jjcpch2PZC03Zbwz3tQF0FiOKQyoCZ
 X29WcUmeZUzWmXGnhr3MeCtnG7g/5BIfb82E6qg3QvxW9+T9Kr3ozBLow
 U3On3TY3s7/YtujYtg/y98BCiRplqiIP0VwOCFifdM6AjOgFTZU8LMSAt
 6tpqM4dl7KUF44b+COG6oby7UDdRYPHw/t55XVLEgZcU6tYfwateA020p
 DIegKSXTCxMLyJJorQ1E12nG5PB9yyjtRgtpvvaEfJuUmudwVz/IvUz6e
 x86w4kJ+jprXp9Z58qzYuflZlr5c+OitaYfN0de+ASayxew3iqTOZXJIw g==;
X-CSE-ConnectionGUID: 7y5v2hNiT06XmGe1aFk/1A==
X-CSE-MsgGUID: O0YX8cpDSiyoAIx9UeWrcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98581932"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="98581932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 22:36:46 -0700
X-CSE-ConnectionGUID: WlY4WI9aQhmHFBNRoZgxyg==
X-CSE-MsgGUID: +z5jhLCXR2y83XkgdxlNag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="265119094"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa006.jf.intel.com with ESMTP; 23 Aug 2026 22:36:44 -0700
Date: Mon, 24 Aug 2026 13:36:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Yongwei Xu <xuyongwei@open-hieco.net>
Subject: Re: [PATCH v3 01/10] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <aovYayjaps1GBb7H@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-2-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-2-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Aug 24, 2026 at 12:53:05PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:05 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 01/10] target/i386: Sync AMD CPUID aliases for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
> CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
> guest CPU vendor is AuthenticAMD.
> 
> Hygon Dhyana uses the HygonGenuine vendor string, but implements the
> same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
> advertising a feature in CPUID[1].EDX while the matching extended alias
> in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
> confuse guest OS feature detection.
> 
> Apply the alias synchronization to Hygon CPUs as well.  Gate the new
> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.1 and
> older machine types, because the CPUID result is guest-visible ABI and
> must remain migration-compatible.
> 
> Add qtest coverage for the Dhyana model, including the compat property.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
> ---
>  hw/i386/pc.c                        |  4 +-
>  target/i386/cpu.c                   | 10 ++--
>  target/i386/cpu.h                   | 12 +++++
>  tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>  4 files changed, 98 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


