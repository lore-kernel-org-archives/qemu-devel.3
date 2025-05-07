Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67136C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXdU-0001ne-EQ; Wed, 07 May 2025 01:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXdD-0001ch-S6; Wed, 07 May 2025 01:47:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXdB-0004fO-FL; Wed, 07 May 2025 01:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746596866; x=1778132866;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=o/wtlwc0Rt7lZAcaducfQgX/1u11XR96ax4G6qwTSjo=;
 b=IQPr0hI/Dkdml6dxJ7i13E0Mun10zNpErbbHnjHmCveEa5qiZvS1JpeW
 EFuInME4UjiK51XfTXjMBa2aIQelB86OwU1uwU0J/oAltWZifyb8tMkK/
 ZsASo/N8ZCwwyfLqGNuyIXRAH831iGt+zohtZ4KwutDkhuRIq82LTigsN
 ucLFEGJvb7/QI/aQavD4SE+3i4F6UiD7iNAq0h9BAKVgeFoRCMAP8uDu4
 0NUDyWE5AaqVuM+jNRTuddLIhsxJTfdtByvutjXHa0q5O4B5zZDWI1Kc7
 t8L6ixsrOQJODEpjL/AdJU1aXL/HvRxyY714EwAfgXjm0cjSTV60SeW3P Q==;
X-CSE-ConnectionGUID: L3AfGmJtRoWc2PfGvTUh1A==
X-CSE-MsgGUID: WgNUyOcsRrSejcmvX8a+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50953223"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="50953223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:47:43 -0700
X-CSE-ConnectionGUID: EVTEbi5yRyCCokJxJdLLqw==
X-CSE-MsgGUID: nrhy20j3QAG6hZJSpJ3vtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140801944"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 May 2025 22:47:39 -0700
Date: Wed, 7 May 2025 14:08:39 +0800
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
Subject: Re: [PATCH v3 19/19] hw/net/vmxnet3: Merge DeviceRealize in
 InstanceInit
Message-ID: <aBr458k3k3d+/Kqz@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-20-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-20-philmd@linaro.org>
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

On Tue, May 06, 2025 at 04:39:05PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:39:05 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 19/19] hw/net/vmxnet3: Merge DeviceRealize in
>  InstanceInit
> X-Mailer: git-send-email 2.47.1
> 
> Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
> removing the need for device_class_set_parent_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/net/vmxnet3.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


