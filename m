Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7349FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hd0-0007fK-Da; Tue, 29 Apr 2025 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hcy-0007ep-UT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:51:48 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hcx-0001IO-9G
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920307; x=1777456307;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tGU38TRg07K/Mv43zK/ICJjv0cU0Nf3qQm21pikXjEQ=;
 b=PEhS+++nFCqQe/bSm6MEshjwTZPciN1LrjApMd9qaRPlt2jGZiDtEicN
 SICceLBVzinMOjB9PoCu1ox1AEyRbqMXhUHuEMSmqYrbkAP7PBydeiL27
 FZGA0XVQh4fRJ+487lb3XzPr3d71NEmmhmuoTAVzJlqucQqcXEJ+8ScHx
 EHjTm3wyayVCxkARkWtr0SyRwRj6hd5ziXm4YoFdmoo2O8uSTLBAbLu9a
 Q+R/ewnI+f4I2Y3vAV5aMinNSRougZSLLycUcUldcAhiLVrHfkjzp3fY2
 AsSCT4KX0m6or+rdQ/suYJwvDmakGvTrz6sAIh5+a63IKxr1OD5v2ue2y A==;
X-CSE-ConnectionGUID: s+tS25ouT5+o3iLKH/Dirg==
X-CSE-MsgGUID: b5qHphmzRVOVLQkaFOYNVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="57732697"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="57732697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:51:45 -0700
X-CSE-ConnectionGUID: 72qf1D+RRFiaKmOQ4wvoSg==
X-CSE-MsgGUID: YQ5dcPU0RBG2MXgqhaMizg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133661221"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2025 02:51:43 -0700
Date: Tue, 29 Apr 2025 18:12:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 35/55] i386/tdx: Set kvm_readonly_mem_enabled to false
 for TDX VM
Message-ID: <aBCmGAIE1Y/OPfmk@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-36-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-36-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:45AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:45 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 35/55] i386/tdx: Set kvm_readonly_mem_enabled to false
>  for TDX VM
> X-Mailer: git-send-email 2.34.1
> 
> TDX only supports readonly for shared memory but not for private memory.
> 
> In the view of QEMU, it has no idea whether a memslot is used as shared
> memory of private. Thus just mark kvm_readonly_mem_enabled to false to
> TDX VM for simplicity.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/tdx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


