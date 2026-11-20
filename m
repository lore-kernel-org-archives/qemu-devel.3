Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35F606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JbFtG54Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULO6-00086U-Ve; Fri, 20 Nov 2026 04:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xULO5-000868-8b
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:58:33 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xULO3-0007bC-18
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795168711; x=1826704711;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=VqfWWyNKP41xggbE8G4O+U9tuF1EbfzC3ALH58eUH8E=;
 b=JbFtG54Q8xwtqXuFIub0wPNrdIAfT/D7OCvy1UgS5Addu8kSHTTLKRMq
 gAfd1pLebCyNwJwpdmGxlWBlJox8ixCynHoFHx72iqeCwd4GAkeFae6Ma
 ISlz6Id/QD6XxY0TzWkkfptJkTmXtFgboQOjdR2u5lB9rRj2AT8LEprxV
 ld9pB/joBOfgCf6wmEsImmAk/PS4WGcW19IRG2pSvUDM1uKA1sg2UYG/r
 SYFYaybwtFDfh3SVxTsA3L/ed8E3R4REtmLr7+CnAQPjf47e/B9XFpTfb
 KrUKlIeNzj0Jv2osm5SqZMLHaRJWd/p+HcosLKQtNhoZX17hCGIN1b91L w==;
X-CSE-ConnectionGUID: zcfSskI/T0ifX3VNKc2LZg==
X-CSE-MsgGUID: wrDYkytbRgOBDxNG8TRiig==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4052249"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4052249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 01:58:26 -0800
X-CSE-ConnectionGUID: vh4oHUzHSYqdJIcu7sa0SQ==
X-CSE-MsgGUID: BBkncL18Qvi715stShz4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10605541"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa007.jf.intel.com with ESMTP; 20 Nov 2026 01:58:24 -0800
Date: Fri, 20 Nov 2026 17:58:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
Message-ID: <awAZv3AsmNdJ7oUW@intel.com>
References: <20261119180859.1044425-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi John,

On Thu, Nov 19, 2026 at 01:08:59PM -0500, John Snow wrote:
> Date: Thu, 19 Nov 2026 13:08:59 -0500
> From: John Snow <jsnow@redhat.com>
> Subject: [PATCH] i386/cpu: mark CPU properties as const
> 
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  target/i386/cpu-internal.h |  2 +-
>  target/i386/cpu-system.c   |  2 +-
>  target/i386/cpu.c          | 30 +++++++++++++++---------------
>  target/i386/kvm/tdx.c      |  2 +-
>  4 files changed, 18 insertions(+), 18 deletions(-)

I'm fine with the "const" change, but it seems only
cpuid2_cache_descriptors can move to .rodata:

$ objdump -t build/libqemu-x86_64-softmmu.a.p/target_i386_cpu.c.o | grep -wE 'feature_word_info|cpuid2_cache_descriptors|epyc_v5_cache_info|epyc_v4_cache_info'
0000000000005fa0 l     O .data.rel.ro.local     0000000000000020 epyc_v4_cache_info
0000000000005f80 l     O .data.rel.ro.local     0000000000000020 epyc_v5_cache_info
0000000000000d20 g     O .rodata        0000000000001284 cpuid2_cache_descriptors
00000000000060a0 g     O .data.rel.ro.local     0000000000006a80 feature_word_info

I think it's because FeatureWordInfo and CPUCaches have pointer fields.

So with the commit message fixed:

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

...

Futhermore, for CPUCaches, it could embed the cache info by value:

typedef struct CPUCaches {
    CPUCacheInfo l1d_cache;
    CPUCacheInfo l1i_cache;
    CPUCacheInfo l2_cache;
    CPUCacheInfo l3_cache;
} CPUCaches;

although the cache info will be stored in .rodata, this would also give
each vCPU its own copy, so smp-cache would no longer modify the global
tables. The cost is that CPUX86State grows per vCPU (from 4 pointers to
4 full CPUCacheInfo). So, maybe there¡¯s room for further optimization,
but that¡¯s a separate issue, not a blocker for this patch.

For FeatureWordInfo, what I can think of right now is to make the
feature name array a fixed length like:

#define FEAT_NAME_SIZE 36   /* strlen("vmx-invept-single-context-noglobals") + 1 */

typedef struct FeatureWordInfo {
    FeatureWordType type;
    char feat_names[64][FEAT_NAME_SIZE];
    ...
} FeatureWordInfo;

Thanks,
Zhao


