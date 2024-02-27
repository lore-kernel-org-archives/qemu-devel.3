Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F23C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqle-0007Oq-Lp; Tue, 27 Feb 2024 01:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqld-0007Oa-Ih
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:16:41 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqlc-00034F-4r
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709014601; x=1740550601;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q8yiXMREGfzbKKbxvuHBXHkPd1dtPuM1qcw2Uck3NdY=;
 b=aLVlEx7x/B6b7tX6m3jwffoFZ+iPm0LDbDL72Ai7GdQIEiv8gOAYbYIt
 HLSLa56IAUQLNscMlDhCDW5xPouZNjtIEcMTidkIU+A6zluSbGjt0cE51
 k4g+26PyPf6v5WG31EcJBZMWSjZdlkA7BcxqaamG0mfyIes8elLZEgmD/
 h+TORbwBYaxggn8jib/n4F1bIQB7Ju0nDS7ihuXHUZfbDccrcnwpBb+7f
 JXvjko5bSQmRD37ao9wS1/kwkxPamh1czvM1T5IWHkRtFnhrK4QEBD2cb
 qtuayXA9TBep2GZZNJFqdY2WXiBz0VqN0NIub+WJWKL1Y5XLg/ZNaKI+V w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14779554"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="14779554"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6892523"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2024 22:16:35 -0800
Date: Tue, 27 Feb 2024 14:30:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 10/10] docs/devel/reset: Update to discuss system reset
Message-ID: <Zd2Bep+U/dGTaJvV@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-11-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-11-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

On Tue, Feb 20, 2024 at 04:06:22PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:22 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 10/10] docs/devel/reset: Update to discuss system reset
> X-Mailer: git-send-email 2.34.1
> 
> Now that system reset uses a three-phase-reset, update the reset
> documentation to include a section describing how this works.
> Include documentation of the current major beartrap in reset, which
> is that only devices on the qbus tree will get automatically reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This merely documents the current situation, and says nothing
> about what we might like to do with it in future...
> ---
>  docs/devel/reset.rst | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


