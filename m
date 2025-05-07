Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD0FC369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXS7-0000nU-0k; Wed, 07 May 2025 01:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXS4-0000nA-T7; Wed, 07 May 2025 01:36:17 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXS3-0003Gj-Bh; Wed, 07 May 2025 01:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746596175; x=1778132175;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ra+M1klKz8sSLyUWfbxb0SZ8VrWGatuvWy8VvmLfmjs=;
 b=OLBk7b5jSCiQRgFqmGPNeXdaSe96s3+Nuf91jY1BLgvUdRk8od1o5UPS
 cQLSQXjijeBs0LYboWRuBrTI568eKyQvYY3atpftcmaA2H93e8UZ/tpO0
 jfQ+8Q/cA7GF9AXqFitawnO/ujanffTIuAwHHPc8WhllVhXwF9suLDXL+
 i+YnRMxL2RpplVlDbZHiiZcDz/wVmgLKhCMW4SfnJIM3uJN68lqI3UmSX
 Ay1RgE9im/rXXaSMDsGeWbYHk/lajoNMYxUF+v9NF5UMz6pvockvp19Se
 8f5sEjiaXySxLZZT+eNM9iYMWtzCWBvVo6jzmydoYylMaEYyhK8c3XaHq Q==;
X-CSE-ConnectionGUID: bkvPT5uSSEWa8xXzPOmIXA==
X-CSE-MsgGUID: lm6lPO43RBC4AayQaPjBEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50951722"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="50951722"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:36:12 -0700
X-CSE-ConnectionGUID: +Hz4lhp5Rp2N07EhZ+PvkQ==
X-CSE-MsgGUID: z08LjKhzRT+nLwYSscLqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135843347"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 22:36:08 -0700
Date: Wed, 7 May 2025 13:57:09 +0800
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
Subject: Re: [PATCH v3 14/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Message-ID: <aBr2NbXJ/UhfVIUF@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-15-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, May 06, 2025 at 04:39:00PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:39:00 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 14/19] hw/scsi/vmw_pvscsi: Remove
>  PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
> X-Mailer: git-send-email 2.47.1
> 
> PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
> hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
> property. We removed all machines using that array, lets remove
> all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/scsi/vmw_pvscsi.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


