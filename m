Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D30C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpO4S-0004l9-Dm; Wed, 27 Mar 2024 03:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpO4Q-0004km-6w
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:51:38 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpO4O-0007dz-AA
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711525897; x=1743061897;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EKilDtQGUE+aPzFGLkujBkQ0LybksSXRCKVPYJ0Bcxk=;
 b=Z1tmaEQtn6/aW+JTiktQVPhX05/LIeO8TIJEZ6b23v30K7Lr15yDXo/H
 hTvrGCFZDSNxTqUALav95VJFgs2B+F+noSf06XKL/JdkiCSZtmG+Ggfdc
 iRsP3dpozjth9F8U+e2D0y7ecqoLHOS+lKzsxwJCEGH8gqn7iNIuHhBry
 RJBEsrH6y0PPXwneLD5q7OHE0gf5JX9a/lITEeZ2v78opWmmSAtBh0w+j
 VgI2y+UNnCbwDd2dFFjMG+J0IjCiGEoUZyln5s9UfLq2nPZFGmgxmOqYn
 LzJHASDzPWdhcduNqW2w5wCFZTwEgaz53AdBmbVVOaGjRSas9+FxaEWpV g==;
X-CSE-ConnectionGUID: 5slPcaiCTuG/FswDo34/UA==
X-CSE-MsgGUID: AsM7DEXaThqjzVPySj27pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10412269"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="10412269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 00:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16145106"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Mar 2024 00:51:31 -0700
Date: Wed, 27 Mar 2024 16:05:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH for-9.1 v5 2/3] target/i386: add guest-phys-bits cpu
 property
Message-ID: <ZgPTR0cdSFODG2Z3@intel.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141422.1380087-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 25, 2024 at 03:14:21PM +0100, Paolo Bonzini wrote:
> Date: Mon, 25 Mar 2024 15:14:21 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 v5 2/3] target/i386: add guest-phys-bits cpu
>  property
> X-Mailer: git-send-email 2.44.0
> 
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Allows to set guest-phys-bits (cpuid leaf 80000008, eax[23:16])
> via -cpu $model,guest-phys-bits=$nr.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20240318155336.156197-3-kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v4->v5:
> - move here all non-KVM parts
> - add compat property and support for special value "-1" (accelerator
>   defines value)
> 
>  target/i386/cpu.h |  1 +
>  hw/i386/pc.c      |  4 +++-
>  target/i386/cpu.c | 22 ++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6b057380791..83e47358451 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2026,6 +2026,7 @@ struct ArchCPU {
>  
>      /* Number of physical address bits supported */
>      uint32_t phys_bits;
> +    uint32_t guest_phys_bits;

Maybe here it deserves a comment, just as most any other fields...what
about copying commit message of patch 3 like:

/*
 * Number of guest physical address bits supported. Usually this is
 * identical to host physical address bits. With NPT or EPT being used
 * this might be restricted to 48 (max 4-level paging address space
 * size) even if the host cpu supports more physical address bits.
 */

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


