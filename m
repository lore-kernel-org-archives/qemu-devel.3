Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C1C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i1M-0005z5-3i; Wed, 02 Sep 2026 06:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i1L-0005yt-18
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:16:43 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i1J-00053a-5B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788344201; x=1819880201;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XuWsCwVEmw1nsuFB/mbj8N981k8/d1KCbc+09ImqyQY=;
 b=LK3nXO9gYbffpzmgrLb9MuSb5IYsZgzy+MG41RM9jByEDuHARXwugW09
 z/gi+Qn2+QY5tQl+PlhxICVB0HciZd3MrbOJyrITnXnl0oqxw5HHO9+BX
 ZEuCasEzbvTjkxRRNdWtxkSGKxYlXP+S3bWhx7QMQEmGGfEtgIDKo1XKs
 yES11z3dGlqQZ2zu6MtFlm/HIf8bdR6n+0Z8dzpmY8Tea9Arr1K28LSKK
 HGY6b4jR92GHJN7IcfIvWwvoEminp1RXIPSUGyBQgyxQaXpsyTRCxBNSG
 SYNdhA1AON3xShdhZlZoMKq+KGNW4VI8emRxnj3HaHzkXBFwt9MV3uueF g==;
X-CSE-ConnectionGUID: rka01f1eQ4iuRgkH6sjKYw==
X-CSE-MsgGUID: p9PMqckXRRCbSxgmcWgmfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92665424"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92665424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:16:39 -0700
X-CSE-ConnectionGUID: HT5Mz9KnSLWumBC+bu0xkA==
X-CSE-MsgGUID: Qsu9kHNARIOFz8yJPghDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="274623500"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa005.fm.intel.com with ESMTP; 02 Sep 2026 03:16:36 -0700
Date: Wed, 2 Sep 2026 18:16:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com,
 binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 2/5] target/i386: Add LASS support in CR4
Message-ID: <apf3g2MQrt72OKdO@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-3-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-3-kishen.maloor@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Tue, Aug 25, 2026 at 08:57:31PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:31 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 2/5] target/i386: Add LASS support in CR4
> X-Mailer: git-send-email 2.47.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> CR4.LASS[bit 27] enables Linear Address Space Separation, and may be set
> only when CPUID.(EAX=7,ECX=1):EAX[6] enumerates LASS.
> 
> Recognize CR4.LASS as a valid bit by adding CR4_LASS_MASK to the known
> bits, i.e. clearing it from CR4_RESERVED_MASK. Mark it reserved in
> cr4_reserved_bits() and clear it in cpu_x86_update_cr4() when the guest
> CPUID does not enumerate LASS. This keeps CR4 handling consistent on
> paths that reach cpu_x86_update_cr4(), such as gdbstub register writes.
> 
> LASS is not emulated by TCG, so it is not added to TCG_7_1_EAX_FEATURES
> and cannot be set under TCG (helper_write_crN() and helper_vmrun() both
> reject reserved bits via cr4_reserved_bits()).
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> [kishen: rewrote commit message, rebased, fixed formatting]
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.h    | 7 ++++++-
>  target/i386/helper.c | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


