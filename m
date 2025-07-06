Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112E5C83F03
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Jul 2025 09:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYLvv-0005AC-5s; Sun, 06 Jul 2025 05:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uYLvs-00059O-Rp
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 05:45:12 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uYLvq-00053O-4V
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 05:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751795110; x=1783331110;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UgOxMYGUQrXD2Q70QegGp4m6RLcXk9Fx/6TuNu8rk28=;
 b=TC+ZsnGyqbRx7iAs+Qm5LujoOfv8gB2lUq+HN5vKOw/5tFL/YwavVj3y
 8YubbRsR4LiuGu9ag3zgbCvpRJrKkEV3BJYBdnzojllrE1uoctyUWn0oH
 cxUSe29KTZKdDhXhJmYso3osws7pM1TL4JqNp1MDfshvzW9CHAQIhf4x5
 EmzoLn7u44w96kuWwXuKH8yduI42G2yfOOVlB1MLx2QcVFJGDOlk+oLDO
 aCds+Hz1eqZP1C1h0JMbnwnER+eXLUpCjCVAL5c4FUekELreRSS+M3tYy
 HYRr1B741mjUqSZ8X5L7vqgLJZ0dQc4AWokl8ZAbD8pY48f27RcXuOfmc Q==;
X-CSE-ConnectionGUID: spCBQpMnQV63qDBCJBKE7g==
X-CSE-MsgGUID: 8swxbFvESw+waeWJoWOVIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="79479253"
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; d="scan'208";a="79479253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2025 02:45:05 -0700
X-CSE-ConnectionGUID: JrNqCl3BQrWVGrniCXCfzA==
X-CSE-MsgGUID: kH/3Bf6vQoSmtzlAq2KWkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; d="scan'208";a="155541337"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 06 Jul 2025 02:45:03 -0700
Date: Sun, 6 Jul 2025 18:06:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tao1.su@intel.com, chenyi.qiang@intel.com
Subject: Re: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
Message-ID: <aGpKpvh+sEQb4LDM@intel.com>
References: <20250704144504.4094810-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704144504.4094810-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 04, 2025 at 10:45:04PM +0800, Xiaoyao Li wrote:
> Date: Fri, 4 Jul 2025 22:45:04 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
> X-Mailer: git-send-email 2.43.0
> 
> Intel AVX10 spec has been updated to make the bit 16-18 of
  ^^^^^^^^^^^^^^^^

This "AVX10 spec" is misleading, there are both AVX10.1 spec and AVX10.2
spec, and QEMU currently supports AVX10.1 for the GNR, but your change
is based on AVX10.2 spec.

It would be good to explain something like,

Although AVX10.1 has already marked AVX10/128 as always supported in
revision 3.1 (QEMU did not synchronize this change), in the latest
AVX10.2 spec (revison 5.0), AVX10 roadmap is updated, "AVX10/512 will be
used in all Intel products, supporting vector lengths of 128, 256, and
512 in all product lines". This applies for all AVX10 versions.

> CPUID.24_0.EBX as reserved at 1 because all the Intel processors with
> AVX10 support will support all the vector lengths.
>
> The bits will be reserved at 1 to ensure the compatibility of the
> existing software. For QEMU, it makes no sense to allow the
> configurability of the bits anymore. So just remove the leaf
> FEAT_24_0_EBX and related stuff and hardcore the bits to all 1 when
> AVX10 is exposed to guest.

Add the doc link here if thers's next version.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 36 +-----------------------------------
>  target/i386/cpu.h | 12 ------------
>  2 files changed, 1 insertion(+), 47 deletions(-)

...

> @@ -7720,7 +7686,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *ecx = 0;
>          *edx = 0;
>          if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
> -            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
> +            *ebx = (0x7U << 16) | env->avx10_version;

Instead of hardcode, it's better to keep the macros and encoded this
like:

*ebx = CPUID_24_0_EBX_AVX10_VL_MASK | env->avx10_version;

and leave a comment: all processors supporting Intel AVX10 will include
support for all vector lengths.

>          }
>          break;
>      }

