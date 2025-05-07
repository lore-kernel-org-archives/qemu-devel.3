Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C54CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 03:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCVFe-0005je-Vl; Tue, 06 May 2025 23:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVFc-0005i2-N6; Tue, 06 May 2025 23:15:16 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVFa-0004kp-Nh; Tue, 06 May 2025 23:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746587715; x=1778123715;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wj8e03x1sPjoDxZbEMymUzktNF9S17SBkFX4kEyUknA=;
 b=ZsBGxPFQWQ7LJpBC4YSagGvxOjpeXHqjzFt0Y6gU9OxZA1dbfPZF9DIm
 EPQ/q0qqMzus4aSnCkjUaFl5G4uKFwY+CnhTMV5aNDYmDltS5dY7KwxgZ
 Q6ktSSGksm04ZkFRmaXOZ8qxq0dCDcSKll7tjmDAwioTLsY2RAPdJypsj
 itca3aTzyN1vDgC4Z1lXMS191OXhS/OPoR8xRQ3K0PaxiLZZ1gpAYyRvn
 urjKFexKKrergFO/zMdntrYBPUxLYqRti5BpdItEx4FNrs5kZvWeOn25T
 qFwvcTjopuTvQ/d3uUfIOutKEPgZ26wYqaVEavC6PCLk/1Tl4A0VKPvrR g==;
X-CSE-ConnectionGUID: H5YcIvz/Tr+MLUl03n96Bg==
X-CSE-MsgGUID: ejX61XMUTV+jZNHrOnMaMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48000284"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="48000284"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 20:15:12 -0700
X-CSE-ConnectionGUID: T524AQjWRb+YnqbDfYsuOg==
X-CSE-MsgGUID: 506tyD3yS4aVDojHLeumJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135775795"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 06 May 2025 20:15:08 -0700
Date: Wed, 7 May 2025 11:36:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 08/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
Message-ID: <aBrVKafRdtVSFbQd@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-9-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 04:38:54PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:54 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 08/19] hw/virtio/virtio-pci: Remove
>  VIRTIO_PCI_FLAG_DISABLE_PCIE definition
> X-Mailer: git-send-email 2.47.1
> 
> VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the hw_compat_2_4[]
> array, via the 'x-disable-pcie=false' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_DISABLE_PCIE (see commit 9a4c0e220d8 for similar
> VIRTIO_PCI_FLAG_* enum removal).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/virtio/virtio-pci.h | 4 ----
>  hw/virtio/virtio-pci.c         | 5 +----
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


