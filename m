Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85110C3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUTK-0007Z4-Bz; Tue, 06 May 2025 22:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUTC-0007Vp-Tg; Tue, 06 May 2025 22:25:15 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUT5-0008Eb-JK; Tue, 06 May 2025 22:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746584708; x=1778120708;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uWau9pRE3GZ4PMWuylDdVF6jmza3xquZ6FWM9H4/voY=;
 b=bpr3+N5dFQNxTqAUpBeluxxzmE9XHgeYzhV4J+DeFDX3xt3zOs1SpSWL
 Xx1hBu2LP/GH9dUFRXaF8yyjPV1xNVrUKrlleFn90L/0mbTOC2b2AvEZy
 9sZ1iKe752+hQdFb/k70H1taMNgMoJBj/pSF8euhs602x8yG2zmYPRhtd
 AygwraU4Kra8FRwDlnevvrZNFzZC7nbFQbrzW9aScYevdkfakovnC8mje
 M4TxMUE8BYsu5P1tl/E5zRRGoDhM+segeTBvfgrlR2RdCk59kTTu84wPj
 XFmla+7o3R6OKoaSKNX/eXVL/xaCY20qY+29ef5RgwS6rBYdDO7IsKymY Q==;
X-CSE-ConnectionGUID: f7CLhXliTd6LBBNDXDKm2A==
X-CSE-MsgGUID: aC/iyLgGS9iAlGmbYR8Eww==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59276608"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="59276608"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 19:25:03 -0700
X-CSE-ConnectionGUID: o5BdnP+1R02Qut9Lja+06Q==
X-CSE-MsgGUID: LIvWlmVFSw2VPFSWPKpqUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140648468"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 06 May 2025 19:10:47 -0700
Date: Wed, 7 May 2025 10:31:48 +0800
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
Subject: Re: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Message-ID: <aBrGFGirGIlgJNZX@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, May 06, 2025 at 04:38:47PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:47 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
>  pc-i440fx-2.4 machines
> X-Mailer: git-send-email 2.47.1
> 
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Remove the qtest in test-x86-cpuid-compat.c file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/pc_piix.c                   | 13 -------------
>  hw/i386/pc_q35.c                    | 13 -------------
>  tests/qtest/test-x86-cpuid-compat.c | 14 --------------
>  3 files changed, 40 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


