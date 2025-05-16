Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E67C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 02:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFlFY-0002wA-IO; Thu, 15 May 2025 22:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFlFU-0002vr-Ss
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:56:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFlFS-0001yA-Rr
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747364195; x=1778900195;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kyp5B9Yk+/qeMoCR0UxmKqiiDUDuqHi+ztmAS8HGzMc=;
 b=N/984DONbtMB9HexNKEdTqI2iqxrRVr3o+01m5X6nsnLfuZ+uiOEc0yJ
 xwy3TMiHFgQY+gstWE91Zu7VJWokFf0vK/6v0DzPDbc5saoIBfPdrydQp
 4eZtv5gI/Rt/PT8SS1V926wQNN2khJD1o7l1TJ6+aiC/emx1yXlmXnK95
 duhUeL9RfDFUCzMGQ5AsQV4GQ/adbEeCrIldHumko+AfohnSs09EPZZxw
 jZ76fy82rJ/nZPbk2p7q3L3hI9vKiwt4lHcsYuwZENJQcYTVPBnUuTeVQ
 rrPAPVPRWZkjNsQnShMTgwI2BWkORytZ2W4iM5SGzH9bA5++vaqb5NvdC w==;
X-CSE-ConnectionGUID: CZ5M4F9/RGSLwfxIQkVY1A==
X-CSE-MsgGUID: 943ZD/lbTlKWPSIdwNx0jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60347580"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="60347580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 19:56:32 -0700
X-CSE-ConnectionGUID: QRctgbuMT0CcqzqJTLXYoQ==
X-CSE-MsgGUID: Uo1NUvnIRDmyTT3mhGxB9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="138445148"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 15 May 2025 19:56:30 -0700
Date: Fri, 16 May 2025 11:17:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
Message-ID: <aCauT25wGtyr5lt7@intel.com>
References: <20250514031652.838763-1-xiaoyao.li@intel.com>
 <20250514031652.838763-3-xiaoyao.li@intel.com>
 <aCWjGFFlKqwOyY0/@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCWjGFFlKqwOyY0/@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Thu, May 15, 2025 at 04:17:28PM +0800, Zhao Liu wrote:
> Date: Thu, 15 May 2025 16:17:28 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
> 
> On Tue, May 13, 2025 at 11:16:52PM -0400, Xiaoyao Li wrote:
> > Date: Tue, 13 May 2025 23:16:52 -0400
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > Subject: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
> > X-Mailer: git-send-email 2.43.0
> > 
> > Since Commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
> > x86_cpu_expand_features() instead of cpu_x86_cpuid()"), CPUID_HT will be
> > set in env->features[] in x86_cpu_expand_features() when vcpus >= 2.
> > 
> > Later in x86_cpu_filter_features() it will check against the HVF
> > supported bits. It will trigger the warning like
> > 
> >     qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
> > 
> > Add CPUID_HT to HVF supported CPUID bits to fix it.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> > Note, the issue is totally by my analysis (which should be the same as
> > the TCG warnings) because I don't have HVF environment to verify it.
> > 
> > If would be helpful if anyone can help reproduce it and test the patch
> > in HVF environment.
> 
> Ah, I found someone has reported a bug on HVF. In his log, there's the
> ht warning:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/2938
> 
> But I don't know if this fix can help on his bug...let's wait for his
> feedback.

Amitai has confirmed this fix can resolve #2938. So I think it's
necessary to add the tag:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2938

and CC this series to qemu-stable@nongnu.org.

Thanks,
Zhao

> > ---
> >  target/i386/hvf/x86_cpuid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Anyway, this fix is fine for me, so,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 

