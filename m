Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBE0C3ABB6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCYEQ-0008Pg-8Z; Wed, 07 May 2025 02:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCYEO-0008PH-Aq
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:26:12 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCYEM-0008Ri-Oj
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746599171; x=1778135171;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=EN1Oi7r46yPYOorhg67Y2ev5p9Xe4QzAmxO+pxYY994=;
 b=L2iPyaKilVN/LRHq1JX4j7ZU8cuvaxAO5VVkO/wzKc4XSCFcXjdJsnKy
 o3UTVDQvjuFcRjIWsDV1nlgHej0QbdHsUZ9o08R6P7BfRjVtQ6Vaji7IK
 riaAkiSeuFxLujzWXZB1Zy0/49PlTltIgJTBCtY6R/sxbzGimzrX11FIj
 lflbvimskhZjL+eEY4FvtRo9fn4idumvs7L3HxzlETcA5JmJIghdcIif5
 Wi+dZgu2mqtTp+YMcAu0LvgCiD/ViCwzSVPsRNZ/pfm+h6Q2x5T3HGYRn
 QkrFea36LikHYqfRtr6Z9Pj/hNSZUcakGnc/oKeJPoF5znBhDtRh+deAH g==;
X-CSE-ConnectionGUID: OwW+XAbwTUu/9kFQ+e6YbA==
X-CSE-MsgGUID: njqYI3KQTUWD1PHkcAxXLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48180786"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="48180786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:26:09 -0700
X-CSE-ConnectionGUID: X+UBwxGZT1ewCQVFUE35gA==
X-CSE-MsgGUID: wcCO+fJ4THmiCvlF4xYMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135858537"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 23:26:04 -0700
Date: Wed, 7 May 2025 14:47:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v3 07/19] hw/i386/pc: Remove pc_compat_2_6[] array
Message-ID: <aBsB6YaIURX1Ds02@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-8-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 02, 2025 at 08:56:39PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:39 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 07/19] hw/i386/pc: Remove pc_compat_2_6[] array
> X-Mailer: git-send-email 2.47.1
> 
> The pc_compat_2_6[] array was only used by the pc-q35-2.6
> and pc-i440fx-2.6 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 8 --------
>  2 files changed, 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


