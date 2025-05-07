Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ECDC369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXc2-00078P-GK; Wed, 07 May 2025 01:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXby-0006u8-BQ; Wed, 07 May 2025 01:46:30 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXbv-0004cJ-D5; Wed, 07 May 2025 01:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746596787; x=1778132787;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bquH8AjGmSKwsdIcMZeW7ONXaUT5sbDCKkWtx3FV0IA=;
 b=FwnQ9KvWeJ0WfNULoZPu1PFzboscVd2Cw10zWo0+26m61cUz0iPUrsqR
 KxrqrRz7Um26B5BodCIPlkYB8iGCXgNqCg3e8YKh0f1szGSeVzy+cvLY+
 HtzCVQc7deZuXYrR+Z7SHr2Q6Rh9xCz+pjCBkwfS0J9jGlRQHcm7WDlK3
 TxezXsqDK21dbH95qqoxg87dWr+90F1nnCnR1U3J4h0WSV/Mggo7EZbvo
 iJwf18f5RgbR25rDqeHVLZsASD9kTA61xpmkx8GCQbNroayxffBjS8K9I
 Gb6LPh1p+oygxPu76W9pSzOs2yhxESjK3gArpk9nI+m6BDCuv3Wprny7h g==;
X-CSE-ConnectionGUID: hGnVXLthQpO0JpI2AbeYDw==
X-CSE-MsgGUID: 8V2ITIzTSyu9PB3HCv+MKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47403772"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="47403772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:46:24 -0700
X-CSE-ConnectionGUID: 9TKW+n4oQR6kbDuxTgXvCg==
X-CSE-MsgGUID: GsYoo8YlSXuBE+ExbpZJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="173039969"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 06 May 2025 22:46:20 -0700
Date: Wed, 7 May 2025 14:07:21 +0800
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 17/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
Message-ID: <aBr4mX7QDPhtTLZf@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-18-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-18-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 06, 2025 at 04:39:03PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:39:03 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 17/19] hw/net/vmxnet3: Remove
>  VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
> X-Mailer: git-send-email 2.47.1
> 
> VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS was only used by the
> hw_compat_2_5[] array, via the 'x-old-msi-offsets=on' property.
> We removed all machines using that array, lets remove all the
> code around VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/net/vmxnet3.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


