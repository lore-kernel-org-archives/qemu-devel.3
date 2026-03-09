Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C99BF3C260
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaiK-0006Hi-1l; Mon, 09 Mar 2026 09:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzaiF-0006H5-UC; Mon, 09 Mar 2026 09:31:59 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzaiB-0003PI-Gb; Mon, 09 Mar 2026 09:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773063115; x=1804599115;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qDJICbTuZQxj7p6V49LsUdl7YQ+lBiSvBxCNAVsDVDA=;
 b=cfZPcgMxSHFLINEgQEUgeluyfxcpuERlYg3bsbiV1Lm1hc3sUrz+pEGc
 kwr99j+eOslCe86q0I02zFXazQvnE8H2fzGG2opUPWr9Sf95EAR8ElZpK
 lkWPEV5EvIbMPq2SyzJUF3ggMJaXFHJNPUhQAihUk2dqhRMVMzb1Xn+dr
 CDAq7Uf9Ab6rhwLd2JB4cQFZ/xwg079iEAgmedzoN/SH5rmnFg8HUrLo0
 Affl4c7jVDpzK2ukhfvFi2/DwjXAkG4qb7FC8yPXOHs5ab1RFM16ged6x
 63WwZR84aagSt5KAw5HsK5vfgS0tQyr97Z9p9/wwvBBz6OBfK5qBQDqV5 g==;
X-CSE-ConnectionGUID: OIyTjXuyTb6yQI7ADz2qDA==
X-CSE-MsgGUID: Fga0dE+lSc+tFspxLJSfyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74003598"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74003598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:31:53 -0700
X-CSE-ConnectionGUID: sae6LRbETni9YLLgBwej5g==
X-CSE-MsgGUID: ndGOrI3FTgOw5991yTq+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="250224611"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 09 Mar 2026 06:31:52 -0700
Date: Mon, 9 Mar 2026 21:58:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2] hw/timer/hpet: Remove HPETState::hpet_offset_saved
 field
Message-ID: <aa7R6evN5W0kpSwr@intel.com>
References: <20260306093134.27789-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306093134.27789-1-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 06, 2026 at 10:31:34AM +0100, Thomas Huth wrote:
> Date: Fri,  6 Mar 2026 10:31:34 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH v2] hw/timer/hpet: Remove HPETState::hpet_offset_saved field
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> The HPETState::hpet_offset_saved boolean was only set in the
> hw_compat_2_11[] array, via the 'hpet-offset-saved=false'
> property. We removed all machines using that array, let's remove
> that property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20250501230129.2596-6-philmd@linaro.org>
> [thuth: Adapted the rust part to the current master branch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/timer/hpet.c                  | 9 +--------
>  rust/hw/timer/hpet/src/device.rs | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


