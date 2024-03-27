Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A332C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSqB-0005MM-Dm; Wed, 27 Mar 2024 08:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpSqA-0005M1-65
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:57:14 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpSq8-0007RB-PD
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711544233; x=1743080233;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4XFDlHxykiZ2GqNXzQZRFXHCN+RjhDui8BDuHdozgtA=;
 b=UzfcBhltcegRMkatKjjTfuFN36VhAvxK8rQg21xDIkzJanq9EEcTLjeW
 sE+M4g5WsezK58Hd8d/yFKMHWapeV+z2ezULqmv1hCS/jD3rsmfsFOVqE
 mpLU/lPnzOzgTJOhELQQSDDBCfXAtkAMUaYKX8C4GRHMProDw6lVI62tY
 Eoz7ywG/HUvRVt6BA502oj9F3/5CwATkD260PXz18XVfYs3/53PHfZgzy
 ouldQhd9Fpzq/nlZNEMQqO83PAlwLhTmeOxgDNxhSIlZdnCtEDam2VwWi
 Int5l2Y+jJmNV9WyRR6bKUn694r61NRhtyr3R6KYWElHdxR/pwIyOXLFi g==;
X-CSE-ConnectionGUID: AqSuq8sNR+2oPQY078DaVQ==
X-CSE-MsgGUID: dmHawybjTCWcyOwTvMLq4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6774624"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6774624"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 05:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16217058"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Mar 2024 05:57:00 -0700
Date: Wed, 27 Mar 2024 21:10:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 02/21] hw/usb/hcd-xhci: Remove
 XHCI_FLAG_FORCE_PCIE_ENDCAP flag
Message-ID: <ZgQa3xEqbtOVlQJE@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:04AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:04 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 02/21] hw/usb/hcd-xhci: Remove
>  XHCI_FLAG_FORCE_PCIE_ENDCAP flag
> X-Mailer: git-send-email 2.41.0
> 
> XHCI_FLAG_FORCE_PCIE_ENDCAP was only used by the
> pc-i440fx-2.0 machine, which got removed. Remove it
> and simplify usb_xhci_pci_realize().
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/usb/hcd-xhci.h     | 1 -
>  hw/usb/hcd-xhci-nec.c | 2 --
>  hw/usb/hcd-xhci-pci.c | 3 +--
>  3 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


