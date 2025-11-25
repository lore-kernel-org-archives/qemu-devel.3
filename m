Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A18CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnCN-0006vC-Bk; Tue, 25 Nov 2025 02:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNnCL-0006tw-ED
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:10:49 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNnCI-00024O-RV
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764054646; x=1795590646;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Z97xnWPHcuHDol7wfz8W091+foCH7Ni8mcM+R2WTW3g=;
 b=fZV5Coc2hZhDZ8NH6aZgDvPt+LJ/7bg9gKaexcXUQjVpyZCxaHUarp3X
 HO6eQVTftxj93JvDoagKf8SIRexbwvl8nccDMQAjZn5SBpfzm9TeQLnQr
 jbZMb4P2ypJlamHyPkflz0hKgxMjR+ObCJsUBOcClTtKjQBZRrhDOQ5c5
 xbGHojxj21MgTl+pUemfGh48ZvwMTZ6ApithVDwOuDatbHbZf3MDk7+Dl
 qhkkF6g4cWzgwnribCp2TRFd/8zh14nf42O5otZIWpolmw36VfKJBVoeZ
 HJSjroa+XldOYJVdKvgXtC/nMNEKibCp2D2UeLhP19rQOpwZBNynmJ8UE g==;
X-CSE-ConnectionGUID: v5TwY8P7Tsq6Tc7cZw0VLA==
X-CSE-MsgGUID: N+9ee8QBQBiVG/PJThZ6hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65953487"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="65953487"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 23:10:44 -0800
X-CSE-ConnectionGUID: pMiHqy8yQKKZjDa1Ge2Rgg==
X-CSE-MsgGUID: UniVVoJ2RvKDsHHWp9SBNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="192634830"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 24 Nov 2025 23:10:42 -0800
Date: Tue, 25 Nov 2025 15:35:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
Message-ID: <aSVcOX5WvJYjIEbM@intel.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027102139.270662-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

> +        /*
> +         * TODO: When the Linux kernel introduces other existing definitions
> +         * for this leaf, remember to update the definitions here.
> +         */

This TODO seems a bit vague; it's best to explicitly list the existing
features that are currently missing. Otherwise, maintainers won't be
able to understand or clean up this TODO either.

> +        .features[FEAT_C000_0001_EDX] =
> +            CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
> +            CPUID_C000_0001_EDX_PHE_EN | CPUID_C000_0001_EDX_PHE |
> +            CPUID_C000_0001_EDX_ACE2 |
> +            CPUID_C000_0001_EDX_XCRYPT_EN | CPUID_C000_0001_EDX_XCRYPT |
> +            CPUID_C000_0001_EDX_XSTORE_EN | CPUID_C000_0001_EDX_XSTORE,

...

> +        .model_id = "Zhaoxin Shijidadao-Client Processor",
> +        .cache_info = &shijidadao_cache_info,
> +        .versions = (X86CPUVersionDefinition[]) {
> +            { .version = 1 },
> +            {
> +                .version = 2,
> +                .note = "with more XSAVE features",

it's better to mention "without smap" as well.

(Based based on my personal experience, the absence of SMAP seems a bit
odd. Could it be a hardware bug in a specific stepping?)

> +                .props = (PropValue[]) {
> +                    { "xsavec", "on" },
> +                    { "xgetbv1", "on" },
> +                    { "xsaves", "on"},
> +                    { "vmx-xsaves", "on"},
> +                    { "smap", "off" },
> +                    { /* end of list */ }
> +                },
> +            },

BTW, if the differences aren't too significant, is it possible to merge
the server and client models? :)

Thanks,
Zhao


