Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621A9C44525
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXpp-0003UK-5E; Wed, 21 Jan 2026 08:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXpH-0003Cw-JP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:00:53 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXpE-0004Io-RO
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769000445; x=1800536445;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HXIrZf9Ioz7N5QzTbcb9jMOrRQL7Zvc/93CoIxhy9nQ=;
 b=LV16dVc9awfRf/a29BS9LvHKVsR8wpxUwpQ4flrUnF5/26d/RdT4zWib
 N/s7LuIs8QZPGnYa5say4spY+gUe4XHUHloCtRxSHULhbYZBg+nhZ1R7a
 KVRbifIpFdHkhnNEJTIAB+36NRqJvPKlE4DblYnqYkUs8vOlVKY8eB0hj
 4VR3A/k2LvlMCmAgZt5DHqPUBbbc7Oyn2oKOXCndZyNizZI6cjobZYehT
 qGIP/BJRYvNAbF7TD/6VK8iEGvYLNBIzaE29jN9zyrLrR1RkcG2NW3ZCs
 jnWztQuzeWAYl17xZow9614yPI7YGYil7CvYrqSID69qrU+UIxb6+CvPr g==;
X-CSE-ConnectionGUID: 2eD4N/mwRteqMX0O3qhSAQ==
X-CSE-MsgGUID: PNUmRIYFTEaxFxYmqdePFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87803693"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="87803693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:00:38 -0800
X-CSE-ConnectionGUID: u9nIZEL4TRCWsbEP+50sgQ==
X-CSE-MsgGUID: LeI6ImxPTveXMeogwC5Lew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="237107125"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 21 Jan 2026 05:00:36 -0800
Date: Wed, 21 Jan 2026 21:26:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v3 1/3] target/i386: Add cache model for Zhaoxin
 Shijidadao vCPUs
Message-ID: <aXDT7wWEk67XmGZO@intel.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-2-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109021028.83985-2-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 08, 2026 at 09:10:26PM -0500, Ewan Hai wrote:
> Date: Thu, 8 Jan 2026 21:10:26 -0500
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3 1/3] target/i386: Add cache model for Zhaoxin Shijidadao
>  vCPUs
> X-Mailer: git-send-email 2.34.1
> 
> Zhaoxin "Shijidadao" vCPUs require built-in cache enumeration in QEMU
> to properly report CPUID leaf 0x4 and 0x80000005/0x80000006 when
> 'host-cache-info' is disabled.
> 
> This patch defines the L1/L2/L3 cache parameters for the Shijidadao
> architecture, preparing for use in both client and server models.
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


