Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E81C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PXC-0008I8-C2; Fri, 10 May 2024 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PX9-0008HW-9D
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:39:31 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PX7-0005tB-25
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715344769; x=1746880769;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hXAvyJxg99Y6xFC8l0DK+qFsjTpILY1PCZvmzo0O77A=;
 b=cAsiDmNqrF9+phj9U3H08435S0Fi123A/yZGc6Cv5ZnaVpErepUbXLxL
 s7NusBE2bsZPQA3LYzBT4p8Tn2SPWNUQKaphqGDqNM08ZG1MFBTt4AOec
 0l6V4BkZSoqda9J7UCLI+7HZx1phZX+XCzAPDzRxwlM1R1Du4OmfE74+E
 /GByTOZeAA7huNC4bmH9nQkP1FBAfDHCPDLGotAu48jJPQu10umo4PC13
 gsTJhDLroA/in6g3/WzbuL/CU5OcfSA5UJSvtIjrYBlaWuYqqox38RSXV
 Zd3oB0TthKt28nEEBy8fbOVtWN/RGzzspVS8gLoLDAhiEljP0N7WG7N5m w==;
X-CSE-ConnectionGUID: gM7WMyfqSwyp8PD+RLrhww==
X-CSE-MsgGUID: 5SaCWutoQp6PLwW5qtoiKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28833732"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="28833732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 05:39:26 -0700
X-CSE-ConnectionGUID: LDauxf0GRvGe8k0SHR3oKw==
X-CSE-MsgGUID: dS2P/cxPRpmJ4HJ1KsrWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="60774516"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 10 May 2024 05:39:25 -0700
Date: Fri, 10 May 2024 20:53:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: remove PCOMMIT from TCG, deprecate property
Message-ID: <Zj4Y08cAVkLZvDE0@intel.com>
References: <20240508154421.61419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508154421.61419-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
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

On Wed, May 08, 2024 at 05:44:21PM +0200, Paolo Bonzini wrote:
> Date: Wed,  8 May 2024 17:44:21 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: remove PCOMMIT from TCG, deprecate property
> X-Mailer: git-send-email 2.45.0
> 
> The PCOMMIT instruction was never included in any physical processor.
> TCG implements it as a no-op instruction, but its utility is debatable
> to say the least.  Drop it from the decoder since it is only available
> with "-cpu max", which does not guarantee migration compatibility
> across versions, and deprecate the property just in case someone is
> using it as "pcommit=off".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/deprecated.rst   |  8 ++++++++
>  target/i386/cpu.h           |  2 --
>  target/i386/cpu.c           |  2 +-
>  target/i386/tcg/translate.c | 12 +-----------
>  4 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


