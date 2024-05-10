Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FDC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 03:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Gmn-00054Z-Jl; Thu, 09 May 2024 23:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Gmm-0004zH-6r
 for qemu-devel@nongnu.org; Thu, 09 May 2024 23:19:04 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Gmj-0001UG-GN
 for qemu-devel@nongnu.org; Thu, 09 May 2024 23:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715311142; x=1746847142;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CJ3KlYTcjdnRs3fHwf04DggSIHS8T4nETNQRTM8+ldU=;
 b=YHNpAG+yRuRci+PYXJADbs4d0CDqNfBOlCSWjg0znYBc2JFPYlTIvkGY
 x9LTuVQgft1xUB1IiVPcAnYcmiflfnNtVEvleoous06DPEr/zxVE5jSbO
 RdlCrLGbxOhGY3IJ66oAVACFw60AbPdhIe6iRje7U2G/iybwJf5q8W1ps
 974XuBjoQyKJfI1/vb8hGd3CJqxgV2onNR5knrOJJ2/1PdTi2kXhHGs9g
 4hT4QGVRiyqLOY6qR/VkH6QJp4+wC1/t2Hs43A9AsNxDydKw91PIu0Cyd
 e1HCTOcyXhQcgmn7RAEM2uRShsybjBN3pe3/Cjrxjbs8pdJuguYGWvUli w==;
X-CSE-ConnectionGUID: hsbZaw8WTvu1L6Gr6Cdp0Q==
X-CSE-MsgGUID: HBp7dsFpTuqHqdm8av2RFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11121706"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="11121706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 20:18:59 -0700
X-CSE-ConnectionGUID: u+snQdThQPidAaOjDPsL4w==
X-CSE-MsgGUID: FZ6/zf3DRsysIpwCVPAAOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="30015510"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 09 May 2024 20:18:57 -0700
Date: Fri, 10 May 2024 11:33:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: add feature dependency for XSAVE
Message-ID: <Zj2Vd1WSX2qXyj+T@intel.com>
References: <20240509153952.143805-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509153952.143805-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Thu, May 09, 2024 at 05:39:52PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 17:39:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: add feature dependency for XSAVE
> X-Mailer: git-send-email 2.45.0
> 
> The XSAVEOPT, XSAVEC, XGETBV1, XSAVES features make no sense if you
> cannot enable XSAVE in the first place.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


