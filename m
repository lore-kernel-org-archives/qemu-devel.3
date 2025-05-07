Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F2CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 03:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCVTD-00033L-ON; Tue, 06 May 2025 23:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVT9-0002zc-Fv; Tue, 06 May 2025 23:29:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCVT8-0006Ko-1D; Tue, 06 May 2025 23:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746588554; x=1778124554;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Y4WuQNHbECwowUHYobekd7JhEn9s+446EkI023sFa/Y=;
 b=Y/6PnJ092yz3MC5INT4rAQgtESrTkWDpdaUf9NAKdC/I9IMmpY8Xt4OR
 ZGHGB6RB5WeaZop3K9PBosfi3kTHmJ2Qc+Ais/SZzaptLZHHi6Y329OQj
 B9FfOkwAHmyQjalAor6QuWBv+agIiCz0Scp4wgF+Nroy/B5ERhPnunHlc
 zjxyTpkBc8gO2qCbUE34D9GRxnpGoV6V98XT4DMPTrYiQrDHGUUA0UeoN
 rYlPDxWca7Id/C40BCV4+gr5MkGvn7Mqtk/HVyLhGlkbw4mOpwPz7CVAe
 Ic45r9K4ESR5l4PEXMzCbrJrNRo/TavFAQXyriBR8oG6R/UCEpW5Pg5Fc Q==;
X-CSE-ConnectionGUID: M+kv91t+Q8mEMuAv4dZrmA==
X-CSE-MsgGUID: Rqacc4Q3QteohWAmYJf3IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59650417"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="59650417"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 20:29:10 -0700
X-CSE-ConnectionGUID: J9cv5QkQTH6CX7DYPJzD+Q==
X-CSE-MsgGUID: UbzmarEjREmcbMHyOIbtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="159112216"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2025 20:29:06 -0700
Date: Wed, 7 May 2025 11:50:07 +0800
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
Subject: Re: [PATCH v3 12/19] hw/core/machine: Remove hw_compat_2_5[] array
Message-ID: <aBrYb9GSF88YGpSk@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-13-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, May 06, 2025 at 04:38:58PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:58 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 12/19] hw/core/machine: Remove hw_compat_2_5[] array
> X-Mailer: git-send-email 2.47.1
> 
> The hw_compat_2_5[] array was only used by the pc-q35-2.5 and
> pc-i440fx-2.5 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/hw/boards.h | 3 ---
>  hw/core/machine.c   | 9 ---------
>  2 files changed, 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


