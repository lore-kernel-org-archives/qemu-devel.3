Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA6C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 16:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucR4L-00019t-0Z; Thu, 17 Jul 2025 12:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucP6t-00015a-Lg; Thu, 17 Jul 2025 09:57:22 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucP6q-0008Jq-RO; Thu, 17 Jul 2025 09:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752760636; x=1784296636;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eTMXcvi7nZy2wB8ufIHkow9klfmXZAaMVkrsZW5XBk4=;
 b=EMsEQ5Zv3TiNUgo5Qx6to6KTOZFv2ka+inWs6E0cp+DQ7q1+XoJkoytP
 uqq5qH2zC8k8jvTXSjtxymU53gSMSiq6nxhcmWN2GOHj+e1Tb8XEENQQs
 qsE02evno2wrMQ96ThEA7w+bwNnsRqg2Z1Iu0Aj4LF8Ei6ti9s8vOBebj
 JlCedeQ5O2r2EcEm8RgWNEcugfLiRvleVYdqzEnI8OkUbbCVOImTq9/BX
 ZFalSfoXlm+3UwTDH0oxRkutocIKOFgH9h0F6+K0U+kHUUE+ImrBjYrJZ
 U0jiymBxNDR4JCxlCa9qpxqHn8IDOLMc/ul+ssErrnJzLAp0cuqurnIWc g==;
X-CSE-ConnectionGUID: PobEOHeTRkaoTga1PQghVQ==
X-CSE-MsgGUID: +cmVfYC+R/KPkDBvq0k+6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54144105"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; d="scan'208";a="54144105"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 06:57:12 -0700
X-CSE-ConnectionGUID: 255UZBKPQ82UM5jpD2tegg==
X-CSE-MsgGUID: JGZdfFmjR4OgYhsWMpvCzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; d="scan'208";a="181504735"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 17 Jul 2025 06:57:10 -0700
Date: Thu, 17 Jul 2025 22:18:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v11 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
Message-ID: <aHkGQWeqoFiMKMwN@intel.com>
References: <20250717100941.2230408-1-shahuang@redhat.com>
 <20250717100941.2230408-3-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717100941.2230408-3-shahuang@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 17, 2025 at 06:09:40AM -0400, Shaoqin Huang wrote:
> Date: Thu, 17 Jul 2025 06:09:40 -0400
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: [PATCH v11 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
> 
> Move the TYPE_* to a new file hw/vfio/types.h because the
> TYPE_VFIO_PCI will be used in later patch, but directly include the
> hw/vfio/pci.h can cause some compilation error when cross build the
> windows version.
> 
> The hw/vfio/types.h can be included to mitigate that problem.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/vfio/pci.h   | 10 +---------
>  hw/vfio/types.h | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 9 deletions(-)
>  create mode 100644 hw/vfio/types.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


