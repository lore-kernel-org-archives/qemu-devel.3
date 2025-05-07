Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78B1C3ABBE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 03:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCVDZ-0004M8-2Q; Tue, 06 May 2025 23:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVDW-0004Lj-NW; Tue, 06 May 2025 23:13:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVDU-0004QD-C1; Tue, 06 May 2025 23:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746587585; x=1778123585;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KQ8XLUvDqbw1AQAr/Jgncz5ZxDjunkr3hGbUhTv+7kc=;
 b=Cuk7H54W6AMTwQJcM3n+bLtjhPCuoYng9xpNj30EAJD7ifk++kcYETHJ
 chxVgXq5V3f5P84VEsit57LEXyELhkAbUc0p49Qxkh4ZQc3nbtuYbjlG0
 u1EgyrRjKLDy6xFeNQNmgzteI/00qk1YydYwSCi1oIRbCecjRfaSJitip
 lpnnLBxxtqUM/kT+eN5bnKRP/CxI3SlFWUtWOjxeizjQvI8lVGnJQ8ot6
 EV1wmk0tGfk8ZFO59g9FBj0VTl9PaP0JmxcdTMb6bPbyheCjB1sCsxyho
 Kxa0jciXb8kqofmRyf9R6Nuv9nQ3T4eGlT8R2TheKF9YAGSmQhrDTfck8 g==;
X-CSE-ConnectionGUID: ohsOarphTqKwvzReozsSwQ==
X-CSE-MsgGUID: /eXzMy3aSJCaCswXUmTBcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48197485"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="48197485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 20:13:01 -0700
X-CSE-ConnectionGUID: 4WS4BHJEQs+3AhOuDC05DA==
X-CSE-MsgGUID: pMsiRX93SwOQKrZNtTZJYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="166740933"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 06 May 2025 20:12:57 -0700
Date: Wed, 7 May 2025 11:33:58 +0800
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
Subject: Re: [PATCH v3 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Message-ID: <aBrUptYTGjzUq22K@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-7-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Tue, May 06, 2025 at 04:38:52PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:52 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
> X-Mailer: git-send-email 2.47.1
> 
> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
> via the 'extra_mac_registers=off' property. We removed all
> machines using that array, lets remove all the code around
> E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
> similarly to commit fa4ec9ffda7 ("e1000: remove old
> compatibility code").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/net/e1000.c | 72 ++++++++++----------------------------------------
>  1 file changed, 14 insertions(+), 58 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


