Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B46C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpT6P-0003ez-H8; Wed, 27 Mar 2024 09:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpT6L-0003em-1z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:13:59 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpT6I-0002fo-M2
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711545235; x=1743081235;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=m1hANmU/ZMNTCt+2iOV7JT6FGE5KCobHF28RX/F5OKY=;
 b=hTHJZxpTFiVn/8dzLybkS1YDiOO8hxIJC+v5CfQViZgtSK6ua0Iv5ctN
 5yLjEQyXJcZqTNXss4P0YUJvJFejvW8fl0T1YFcW4EuadctJfd8jvv4UN
 xiOn2qAS0ds6leBXLE4j6CUAgvhFglbCG52IvB6J6z+JttAZIG4KgwpSp
 OTLJzubRjShK42U5AaqwE6yc5xhXHzJ14Lfq19/9VhtwtUGsFJ4hSjI/7
 n8n3MP/Cqe16NBXmoLAWC9LcHF+5VZqDR2Qvdi+QGLCGNFsDExvFYJDBm
 0tuEg9OYRn2pAqplikzPe0rLo2jsNGG+iBCkMH8TJ8qTWgOg4iQ0od5f8 g==;
X-CSE-ConnectionGUID: jFZpfpE6THyDkc53x3ZbXQ==
X-CSE-MsgGUID: IhYLX/y9RF+nPnt/4gqqDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10425769"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="10425769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16945771"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 27 Mar 2024 06:13:48 -0700
Date: Wed, 27 Mar 2024 21:27:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 03/21] hw/usb/hcd-xhci: Remove
 XHCI_FLAG_SS_FIRST flag
Message-ID: <ZgQe0BACtoKwb5nZ@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Wed, Mar 27, 2024 at 10:51:05AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:05 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 03/21] hw/usb/hcd-xhci: Remove
>  XHCI_FLAG_SS_FIRST flag
> X-Mailer: git-send-email 2.41.0
> 
> XHCI_FLAG_SS_FIRST was only used by the pc-i440fx-2.0 machine,
> which got removed. Remove it and simplify various functions in
> hcd-xhci.c.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/usb/hcd-xhci.h     |  3 +--
>  hw/usb/hcd-xhci-nec.c |  2 --
>  hw/usb/hcd-xhci-pci.c |  1 -
>  hw/usb/hcd-xhci.c     | 42 ++++++++----------------------------------
>  4 files changed, 9 insertions(+), 39 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


