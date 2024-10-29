Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62066D3A660
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nPz-0007on-PX; Tue, 29 Oct 2024 10:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5nPt-0007o8-En
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:41:53 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5nPr-0002QO-Uw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730212912; x=1761748912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kOET25tq4VAS33JT/X/rlHWA5Cfc1TwgNBg9AnnxRTU=;
 b=Pq9QQz2JHMLiqbgtKmWUWaWZt7JTkMMZztnnJ/dgGlOnw/2oqWiQ3RhE
 dc2YTeDa19fJ88+9HASAD5vkMqgcchCyb2jdaNVYJYr66mG+AeS3uZ8Qk
 i5WMHP/UoqmJVh7RfbAipvTBTDFtlnG/7TrIGwrAd/JLV7fCD04i8T38F
 58ig28+H7jRP7JeUO4LwCeZYgC4YVi0xk4JhAOEWmdJFRUk7FEJYNHlJ4
 DNuEgFdlA0i5DNQK31tPwNcTTmAjDMzXglwP+YCMl/Qa2RjJPv2Up5ja5
 x8b6vcGUcJJ0m330+PPeP8RE6f6tCfvaDc7gFUjY8GJ7vMAgkCTqBW45e Q==;
X-CSE-ConnectionGUID: rgBKGumiQGWW1yd4M657aA==
X-CSE-MsgGUID: JCzfPzh8SaK5oYxTJgMdBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29822438"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29822438"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 07:41:50 -0700
X-CSE-ConnectionGUID: mI4l6pOkR+G25vbNnZwOCg==
X-CSE-MsgGUID: KhqDA1EbSkaTPDCS5SGi1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="112784370"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 07:41:48 -0700
Date: Tue, 29 Oct 2024 22:36:45 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
Message-ID: <ZyDy/YLMNLzXWF13@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <ZyD1aKoyuHSbvero@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyD1aKoyuHSbvero@intel.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 29, 2024 at 10:47:04PM +0800, Zhao Liu wrote:
> Hi Tao,
> 
> On Mon, Oct 28, 2024 at 10:45:10AM +0800, Tao Su wrote:
> > Date: Mon, 28 Oct 2024 10:45:10 +0800
> > From: Tao Su <tao1.su@linux.intel.com>
> > Subject: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
> > X-Mailer: git-send-email 2.34.1
> > 
> > Since the highest supported vector length for a processor implies that
> > all lesser vector lengths are also supported, add the dependencies of
> > the supported vector lengths. If all vector lengths aren't supported,
> > clear AVX10 enable bit as well.
> > 
> > Note that the order of AVX10 related dependencies should be kept as:
> >         CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
> >         CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
> >         CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
> >         CPUID_7_1_EDX_AVX10          -> CPUID_24_0_EBX,
> > so that prevent user from setting weird CPUID combinations, e.g. 256-bits
> > and 512-bits are supported but 128-bits is not, no vector lengths are
> > supported but AVX10 enable bit is still set.
> > 
> > Since AVX10_128 will be reserved as 1,
> 
> Does this means AVX10_128 bit is reserved and it is always 1?
> 
> From the spec you linked in cover letter (Table 1-1. CPUID Enumeration
> of Intel® AVX10), it seems AVX10_128 bit is marked as reserved.
> 
> It's worth describing its behavior.

Yes, AVX10_128 will be reserved as 1. SDM(Volume 1, Ch16) and AVX10.2
have already described this. I believe AVX10.1 spec (linked in cover
letter) will change the description.

