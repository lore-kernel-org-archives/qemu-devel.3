Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE3EC54F30
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6mV-0006Iv-Bf; Tue, 27 May 2025 22:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6mQ-0006Ih-Bj; Tue, 27 May 2025 22:44:35 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6mL-0004H7-F0; Tue, 27 May 2025 22:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748400269; x=1779936269;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZglFOBTuAYQOPhuSJa3M7s3ZAYFFdcQZLUj9In5bAZU=;
 b=ZYN4O6+k2ZRXuZhntuIumMna4RdiZTrozN/f+iDjimMewkxCTKKOlbhb
 V5nb3wKi7lL3opY1ydtd7cBdBS4Fpl/7UYWuBYZpsduaEK6ISlvxEM9QM
 LnsOFA3/ivLI8SgIL0ScXTHAGhtGrsj2mhHi93Ir4EoairkSzEn/bT11l
 6nu7J2YMNYBH7CXFrUqfO26u702bwU79svulrusJ/p4NSuuBHCCFIMNhn
 /s7dTH1NBeooYSwPZKR5SkX0eKL4t4hVG60Umpk2F/+63nSneQ1EosxvA
 TKXkkhAoclDF9h+salSJvev7U90qpN4S1HM306q6jPGHjtzupRBJ43h8t Q==;
X-CSE-ConnectionGUID: zmr0T/4PT+ynPAuVzqzxjA==
X-CSE-MsgGUID: FgnTIhAiS3mlESFGNtm/zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54218059"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="54218059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:44:23 -0700
X-CSE-ConnectionGUID: DWm0Bm3GTuWJeTtSeDEAtA==
X-CSE-MsgGUID: 582tNcvMTbKc7NZna4cB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="147943335"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:44:18 -0700
Message-ID: <ad5ab65a-3193-421a-8e23-4da8c51d4516@intel.com>
Date: Wed, 28 May 2025 10:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-9-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the hw_compat_2_4[]
> array, via the 'x-disable-pcie=false' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_DISABLE_PCIE (see commit 9a4c0e220d8 for similar
> VIRTIO_PCI_FLAG_* enum removal).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/virtio/virtio-pci.h | 4 ----
>   hw/virtio/virtio-pci.c         | 5 +----
>   2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index d39161766e0..f962c9116c1 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -33,7 +33,6 @@ enum {
>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
> -    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>       VIRTIO_PCI_FLAG_ATS_BIT,
>       VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
> @@ -53,9 +52,6 @@ enum {
>    * vcpu thread using ioeventfd for some devices. */
>   #define VIRTIO_PCI_FLAG_USE_IOEVENTFD   (1 << VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT)
>   
> -/* virtio version flags */
> -#define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
> -
>   /* have pio notification for modern device ? */
>   #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
>       (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index a3e2e007d6c..8d68e56641a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2349,8 +2349,6 @@ static const Property virtio_pci_properties[] = {
>                       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
>       DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
> -    DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
>       DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
>       DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
> @@ -2379,8 +2377,7 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
>       VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
>       PCIDevice *pci_dev = &proxy->pci_dev;
>   
> -    if (!(proxy->flags & VIRTIO_PCI_FLAG_DISABLE_PCIE) &&
> -        virtio_pci_modern(proxy)) {
> +    if (virtio_pci_modern(proxy)) {
>           pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>       }
>   


