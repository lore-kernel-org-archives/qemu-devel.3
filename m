Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4E3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0FV-0003jv-NN; Thu, 08 Aug 2024 06:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0FO-0003j9-IJ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:19:55 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0FM-0003K9-3q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723112392; x=1754648392;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=m0RvGOLZ6Tb82CC1yUN1plzxAMNOr/m8eI94er4ybgs=;
 b=R87dAMt07YNGK4XFwl2EZV+CuxYXanNLdA1+C4v92+4JFxNMGfBu3stA
 GDpSx2a1p9NdFLCLk/CGH2PRFi/T9cFeEdJeMyxYSno9UPFPVsQ8ii/dU
 iqux+lxOfdsBwiVCP4g1V3ptnFZhU66vkNuLD98GAOZ3YM+qEVAvdlsud
 024CXUIuqXQuwepLUlzsFVMYSzQM/jBfo54O5V13E9ykjIYS3qIE04NP5
 T06JdO1/jHsdvrpxTrBYit+hqVxNIcoj657iejKDpGoWJnRUIMsAMJEGk
 zkkENKtN2PFF9I7kfvQyBqALEfI6wGSbDPGGxCxkVKLXlGBdRiDiEhDPs g==;
X-CSE-ConnectionGUID: lSg8+gjmSGu+qR7QKgifUA==
X-CSE-MsgGUID: sy/0KyvtRQ2RytImPZzmrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38684187"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="38684187"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 03:19:50 -0700
X-CSE-ConnectionGUID: G/VUZ0usTvSypkBDVRsPlA==
X-CSE-MsgGUID: +rujaAVfSWWTU2vvllNgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="57090705"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 03:19:47 -0700
Date: Thu, 8 Aug 2024 18:35:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX
 definitions
Message-ID: <ZrSfeHP5YZe9SKDz@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-3-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112511.184257-3-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 04, 2024 at 07:25:09AM -0400, EwanHai wrote:
> Date: Thu, 4 Jul 2024 07:25:09 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX
>  definitions
> X-Mailer: git-send-email 2.34.1
> 
> Add new CPUID feature flags for various Zhaoxin PadLock extensions.
> These definitions will be used for Zhaoxin CPU models.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


