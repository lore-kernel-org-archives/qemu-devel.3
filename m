Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D20C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 06:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgJFO-0003Nj-BG; Sat, 02 Mar 2024 01:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rgJFH-0003N3-8Z; Sat, 02 Mar 2024 01:53:20 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rgJFF-00063D-Hg; Sat, 02 Mar 2024 01:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709362397; x=1740898397;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9fwep/7AZNW0eCKIXJgGZuTHg9SjIqiPMyccxKMXpcM=;
 b=QLJYfkhzGpeMVAc5syXWgivPQM1H9cDL3K+E7fF6oH0MqpTSC43Bva9b
 0AbE5Qx6suXkRoE+U4uyQeGmynqf5kQgBbb0FmgPxi5VBQn4oy79pGwgm
 sKWpYw6iS64kOCBhmz1aBVojiOWp/d59I1zUoXs6ffKyF3xnGL0JQVRlz
 asK3mOlscV71ipowvAL31c4Uzi5qWMAXDPkbZ2CjkKaWk5zqaTAb+/F4E
 ZSjc0J8Rf2hL4cGlEF2NMlablXJZjOPXuVtwmK34xyIsBG/OwbXsaW03Y
 BHlf9WWqGbxxkFT610GkXksuBkXknm4cmHMERl1kro1JuXzJVlzznPEku A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14620378"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; d="scan'208";a="14620378"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 22:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8839157"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 01 Mar 2024 22:53:13 -0800
Date: Sat, 2 Mar 2024 15:06:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Frediano Ziglio <freddy77@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] Fix typo in comment (uin32_t -> uint32_t)
Message-ID: <ZeLQEEtbcPJpxenT@intel.com>
References: <CAHt6W4fiLh+bBOX1qwvm-1qJVG=j9SrT5rMJnEaMSWPjwwZr1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHt6W4fiLh+bBOX1qwvm-1qJVG=j9SrT5rMJnEaMSWPjwwZr1g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 06:55:35PM +0000, Frediano Ziglio wrote:
> Date: Fri, 1 Mar 2024 18:55:35 +0000
> From: Frediano Ziglio <freddy77@gmail.com>
> Subject: [PATCH] Fix typo in comment (uin32_t -> uint32_t)
> 
> Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
> ---
>  hw/vfio/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 6e64a2654e..4bb7d7d257 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -181,7 +181,7 @@ struct VFIOPCIDevice {
>      Notifier irqchip_change_notifier;
>  };
> 
> -/* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
> +/* Use uint32_t for vendor & device so PCI_ANY_ID expands and cannot
> match hw */

It would be better to also change the comment style as:

/*
 * Use uint32_t for vendor & device so PCI_ANY_ID expands and cannot
 * match hw.
 */

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor,
> uint32_t device)
>  {
>      return (vendor == PCI_ANY_ID || vendor == vdev->vendor_id) &&
> -- 
> 2.34.1
> 

