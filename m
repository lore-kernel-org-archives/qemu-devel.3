Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C0C3DA61
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVXbv-0005IL-Il; Sun, 21 Jul 2024 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVXbr-0005Gw-Tq; Sun, 21 Jul 2024 10:32:23 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVXbn-0005Y3-SQ; Sun, 21 Jul 2024 10:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721572340; x=1753108340;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dgewjQCx6bg9+T1HWxV7ETFDVTjyCyPPpDZKxdrI17U=;
 b=KXTcKW3N/0EP7DoBk9fW+BVBP3S1VNlUfIq0MUSkQepFyB2OaN28ks1j
 EodW+63MmygkFLtIQaTonxeScBIC2jzqEtbUoLmr0BZYzpFihjV04340w
 kP2l0hq0TKhAU+NP7+hmZrlrmWDIKTaLYBPLdMuYORWRYotJF1arrcjFl
 QI43AwLzZhb1JNLCvbY3AiyiLm+rgc8ghdRmWBDMY277VBfrZzH9K5//P
 fZR3Pv6Rpy3M/PXHmeD7L4HQqrmE6w1roI8Snyt30QH1U3G/dyVfIVOv1
 MWemn2VRy0y5hcmP0/bdwsJ5Kxl4XsuWzWxPFeu01rJNFN3AHkkZjbbfn Q==;
X-CSE-ConnectionGUID: TO/vSUHpRCe3UkGYnPWhJw==
X-CSE-MsgGUID: /GQnLXMWSVKKD8pBLb/hfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="23005198"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; d="scan'208";a="23005198"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 07:32:15 -0700
X-CSE-ConnectionGUID: OGG2WZecSMKc+412L1Hw5A==
X-CSE-MsgGUID: L232TfeCRwO8q+ctMQf6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; d="scan'208";a="82245708"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 21 Jul 2024 07:32:13 -0700
Date: Sun, 21 Jul 2024 22:47:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/x86: add a couple of comments explaining how the
 kernel image is parsed
Message-ID: <Zp0fnCmGyi2L4AFX@intel.com>
References: <20240719134937.3643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719134937.3643-1-anisinha@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Fri, Jul 19, 2024 at 07:19:37PM +0530, Ani Sinha wrote:
> Date: Fri, 19 Jul 2024 19:19:37 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH] hw/x86: add a couple of comments explaining how the kernel
>  image is parsed
> X-Mailer: git-send-email 2.42.0
> 
> Cosmetic: add comments in x86_load_linux() pointing to the kernel documentation
> so that users can better understand the code.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/x86-common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


